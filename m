Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60551606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9734310E758;
	Wed, 18 Nov 2026 08:23:06 +0000 (UTC)
X-Greylist: delayed 843 seconds by postgrey-1.36 at gabe;
 Tue, 17 Nov 2026 17:17:34 UTC
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 031A810F848;
 Tue, 17 Nov 2026 17:17:34 +0000 (UTC)
Received: from escalante.csail.mit.edu ([128.52.128.198])
 by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
 (envelope-from <nickolai@csail.mit.edu>) id 1xTMae-00C8zH-IN;
 Tue, 17 Nov 2026 12:03:28 -0500
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] drm/radeon: stop the GPU before kexec
Date: Tue, 17 Nov 2026 12:03:28 -0500
Message-ID: <20261117170328.56738-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a kexec reboot, radeon leaves the GPU running, and on a system
without an IOMMU the GPU then writes into the next kernel's memory as
soon as radeon probes there.

The PCI core clears bus mastering before the kexec, but the interrupt
handler (IH) stays enabled, with its ring and write-pointer writeback
mapped through the old kernel's GART. The new kernel's
evergreen_mc_program() raises page-flip interrupts before the new GART
is set up; the GPU holds the IH writes for them while bus mastering is
off and issues them, to the old kernel's pages, once r600_irq_init()
sets it again.

Suspend the GPU in radeon_pci_shutdown() on kexec, as PPC64 and Loongson
already do on every shutdown. Normal shutdown and reboot are unchanged:
commit 8d13c187c42e ("Revert "drm/radeon: Fix EEH during kexec"")
removed the same call there because it hung some HD 5770 systems.

Tested on riscv64 with a Radeon HD 6450 by pointing the stale GART at
canary pages after a kexec: without this patch the page-flip interrupts
write IH entries into them, with it nothing is written.

Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Tested on a Milk-V Pioneer (SG2042, no IOMMU) with a Radeon HD 6450:
    9 of 9 kexec reboots of patched 7.4-rc3 into itself came up clean, with
    radeon and the desktop running. Unpatched, kexec boots there
    intermittently oopsed, logged "BUG: Bad rss-counter state" soon after
    radeon probed, or hung early in boot.
    
    Commit 8d13c187c42e removed this call from every shutdown after two
    HD 5770 x86 systems hung on shutdown and restart
    (https://bugzilla.kernel.org/show_bug.cgi?id=205147), but the cause was
    unclear. Kexec runs the same radeon_suspend_kms() as shutdown and only
    skips the firmware that follows it. Shutdown and restart end in
    different firmware paths and both hung, so the hang was more likely in
    the suspend itself and may recur on kexec on those systems. Also, with
    this patch the GPU reaches the next kernel in D3hot, so an early console
    on it (vgacon, efifb) is not decoded until radeon wakes it; PPC64 has
    done this since 2019, but it is untested on x86.
    
    Separately from any hang, I would expect that kexec without this patch
    would let the GPU corrupt the new kernel's memory on those systems, as
    it does here. If you prefer to avoid the full suspend, a narrower fix
    would disable only the IH: clear rdev->ih.enabled and call
    radeon_irq_set(), which on R600 through CIK turns off the IH ring and
    all interrupt sources without waiting on the GPU. That skips the code
    that may have hung, but leaves the CP, DMA, UVD and the old GART set up;
    they stayed idle in my tests, but nothing stops them.
    
    Reproducer (Evergreen register offsets): run it as root after a kexec,
    with radeon not loaded in the new kernel (modprobe.blacklist=radeon). It
    points every entry of the old GART, still live in VRAM, at canary pages,
    so stray GPU writes land there instead of in kernel memory; rewrites the
    D1-D4 surface addresses to raise page-flip interrupts, as
    evergreen_mc_program() does; sets bus master, as r600_irq_init() does;
    and counts the canary bytes the GPU changed. The IH usually holds its
    writes until bus master is set; in one run of eight it did not wait.
    
      gcc -std=c99 -D_GNU_SOURCE -O2 -o ihrepro ihrepro.c
      echo 0 > /proc/sys/vm/compact_unevictable_allowed   # canaries stay put
      ./ihrepro
    
      old kernel unpatched:  bus master off, IH on, GART on
                             68 canary bytes written by the GPU
                             (four 16-byte IH entries, 4-byte write pointer)
      old kernel patched:    bus master off, IH off, GART off
                             0 canary bytes written by the GPU
    
    #include <fcntl.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <unistd.h>
    
    #define DEV "/sys/bus/pci/devices/0000:01:00.0/"
    #define NPG 1024
    
    static void *bar(const char *f)
    {
    	int fd = open(f, O_RDWR | O_SYNC);
    	off_t sz = lseek(fd, 0, SEEK_END);
    	void *p = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    	return p == MAP_FAILED ? NULL : p;
    }
    
    int main(void)
    {
    	static const uint32_t crtc[] = { 0x0, 0xc00, 0x9800, 0xa400 };
    	volatile uint32_t *mmio = bar(DEV "resource2");
    	volatile uint64_t *vram = bar(DEV "resource0");
    	int cfg = open(DEV "config", O_RDWR), pm = open("/proc/self/pagemap", O_RDONLY);
    	uint16_t cmd;
    
    	if (!mmio || !vram || cfg < 0 || pm < 0)
    		return perror("open"), 1;
    	pread(cfg, &cmd, 2, 4);
    	printf("bus master %s, IH %s, GART %s\n", cmd & 4 ? "on" : "off",
    	       mmio[0x3e00 / 4] & 1 ? "on" : "off", mmio[0x1410 / 4] & 1 ? "on" : "off");
    
    	/* point every GTT page of the old GART table at a canary page */
    	uint8_t *c = mmap(NULL, NPG * 4096, PROT_READ | PROT_WRITE,
    			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE | MAP_LOCKED, -1, 0);
    	memset(c, 0xa5, NPG * 4096);
    	volatile uint64_t *pt = vram + ((uint64_t)mmio[0x153c / 4] << 12) / 8;
    	uint64_t flags = pt[0] & 0xfff, n = mmio[0x157c / 4] - mmio[0x155c / 4] + 1;
    	for (uint64_t i = 0; i < n; i++) {
    		uint64_t e;
    		pread(pm, &e, 8, ((uintptr_t)(c + (i % NPG) * 4096) / 4096) * 8);
    		pt[i] = ((e & ((1ULL << 55) - 1)) << 12) | flags;
    	}
    	mmio[0x5480 / 4] = 1;	/* HDP flush */
    	mmio[0x1470 / 4] = 1;	/* GART TLB invalidate */
    
    	/* raise a page-flip interrupt on each CRTC, then enable bus master */
    	for (int i = 0; i < 4; i++)
    		mmio[(0x6810 + crtc[i]) / 4] = mmio[(0x6810 + crtc[i]) / 4];
    	sleep(1);
    	cmd |= 4;
    	pwrite(cfg, &cmd, 2, 4);
    	sleep(1);
    
    	int hits = 0;
    	for (int i = 0; i < NPG * 4096; i++)
    		hits += c[i] != 0xa5;
    	printf("%d canary bytes written by the GPU\n", hits);
    	return hits != 0;
    }
    
    This patch was written with the help of an AI tool.

 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 53d06053dec8..cd786c3264ff 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -31,6 +31,7 @@
 
 #include <linux/aperture.h>
 #include <linux/compat.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
@@ -379,6 +380,10 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 	 * it breaks some other boards.
 	 */
 	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
+#else
+	/* Clearing bus master does not stop the IH writing to stale addresses */
+	if (kexec_is_in_progress())
+		radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
 #endif
 }
 

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.47.3

