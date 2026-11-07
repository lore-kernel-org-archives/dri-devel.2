Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A5606A330
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF8RqXYn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF2710E073;
	Sat,  7 Nov 2026 08:47:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACB110E073
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 08:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78651438E1;
 Sat,  7 Nov 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794041218;
 b=g5jUbZ7i6+5hbtQKE547WWTYXfZ22ih1P5M6ILXhqLR5T5/YbsLTOBv2IZsC5Wg+fXOW
 VQr+C5ZQk7K5unNodxK7nBpWvu5tBdZCwrZNunAk4gVuShd8QIAHZLtjS6TFALovbdZPb
 6kIruiE1DdZw0dWLFJR21o3xfxokufcGdvbxGg/lXvIi+Dfz0NXLKUuQfSvVelemFCYx2
 WTzcz47tAKpNIeybnjQejk0QuKup0vTBj6mEavXjab4WHiVp+GFZS4ESbnnWbxV7/5Rty
 uk6ozCtipyym++xUKeJ6dDFpFIWvrvDJeodcvaZfVBJ+ueyv92WH04HPd2NPKaYgQFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794041218;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=bAtNJeQQZtV0gJf8mO/hJSLFnMdkjTPe0Tyts98GCi0=;
 b=SgE43hTHLKfsZmRifaLKmcFPUJWZfW6I4orNVpdr3bkiSuwwCwPqNk01Ldk5JdgL4+E/
 4HsaDSzahzF9i1QcQqdsUbixxUqGTVdwpgsFAhsJB09M7br4TYAYNRM8WpCbp74fWAjpS
 +T8AmLfKtBQEI2OXfy8eXGNwgB519X0TiRE+5Vn0mY/dJYK+MbvaLQkFQaN9385B2PdCd
 tIpV96e9GKPTU2aL5ahnUSNUfkFVteFlA/NW2ByX9yhLKj4uEMDlkDC86BffGWyzsAx+Z
 NB2IA0UbYD5Xhj5k5RRGDChf8jJivJTpNoKg8RRSlWQfYOgdAzTiy3DcKsRbgWZHtxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B28671F0089F;
 Sat,  7 Nov 2026 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794041218;
 bh=bAtNJeQQZtV0gJf8mO/hJSLFnMdkjTPe0Tyts98GCi0=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=FF8RqXYntGFx92+sfkOztEgA4WIAyQcpfDrN5w6rcRI4PN/aC/aikAS+NjSvOT/0N
 vJvvYAQRcf7sIzfPnGj5gehP7i3fxpAsDjwL4dTIEJ3Pt35Lp+TCjFg9cHU3TCqeUf
 Eca9sLD/bKlApKMdYImE6f+1xe68TgiuePOpSja7IEkBc/HmLjWkaY1CSykrcv6kIx
 QagCqkKMKCYYWh5dBwbrDehR8zjQM9LvnedxhAzOiCRgzJ3rzl+vKa5dYEAFEVgKLu
 IrfHBjWPon79bxCmQKqlCS7yhMbUjY1qQWvVGr/Qy6YDeGTuD9Y/z97pFk0m+DECiN
 g7zfpJ7j6KQsg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 10B8B47B20;
 Sat,  7 Nov 2026 08:46:57 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 07 Nov 2026 16:46:40 +0800
Subject: [PATCH] firmware/sysfb: Avoid simple-framebuffer behind DT PCI
 host bridges
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gbaOqjMVQYXto0aFyqNilK8+
 1Rdfg/eH0EoMAl8swiBdhaepwSdZ+CGduoJ2SeDUabUWlUop3QW/YqLY6SOb1SFVbUn/7EG0nE
 JaT+e6K95LZsdya13Ca7rDywKGgR2AAAA
X-Change-ID: 20261107-sysfb-dt-pci-efifb-d73b08ded4b2
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, Borislav Petkov <bp@suse.de>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 Han Gao <rabenda.cn@gmail.com>, stable@vger.kernel.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794041216; l=3936;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=kYFDOzF/Itut71CnG8RI8WDwvweu0YIXUO3C925lonU=;
 b=f49pP12LVp3nDhY5/qNCdRrn7GKGKv+PAeF7rRNnQhocxFGvzzftFz+q/x/2lTZdiAgXP2VPM
 Spx0r81cSHOD19AjA6XvuruJdovxQmXrcjLGkzR1exrcTYj1jtHjwTP
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
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
Reply-To: gaohan@iscas.ac.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Han Gao <gaohan@iscas.ac.cn>

With SYSFB_SIMPLEFB, sysfb registers a simple-framebuffer device that
claims the framebuffer memory when it is added. On DT systems, the PCI
host bridge may probe later and then fails to claim its memory window.
On QEMU RISC-V virt with EDK2, a bochs-display and pci-host-generic
built as a module:

  [    0.703813] pci-host-generic 30000000.pci: resource collision: [mem 0x40000000-0x7fffffff] conflicts with BOOTFB [mem 0x40000000-0x403e7fff]

In that case, register an efi-framebuffer device instead. It claims no
memory before it probes, and commit 64c8a0cd0a53 ("efi/arm: Defer probe
of PCIe backed efifb on DT systems") makes it wait for the host bridge.

Tested on a HiFive Unmatched with EDK2 and a PCIe graphics card, and on
QEMU.

Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
Cc: stable@vger.kernel.org
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
In QEMU, efifb takes over with SYSFB_SIMPLEFB and efidrm without it.
With pci-host-generic built in, simpledrm is still used.
---
 drivers/firmware/efi/sysfb_efi.c | 16 ++++++++++++++++
 drivers/firmware/sysfb.c         |  8 +++++++-
 include/linux/sysfb.h            |  6 ++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 2338de73c62c..5c2cb87178ff 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -421,6 +421,22 @@ __init void sysfb_apply_efi_quirks(struct screen_info *si)
 		dmi_check_system(efifb_dmi_swap_width_height);
 }
 
+/* Returns true if the EFI framebuffer is in a DT PCI host bridge window */
+__init bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
+{
+	struct device_node *np;
+
+	if (si->orig_video_isVGA != VIDEO_TYPE_EFI || !IS_ENABLED(CONFIG_PCI))
+		return false;
+
+	np = find_pci_overlap_node();
+	if (!np)
+		return false;
+
+	of_node_put(np);
+	return true;
+}
+
 __init void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd)
 {
 	if (si->orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c1883..8853a74560b9 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -164,8 +164,14 @@ static __init int sysfb_init(void)
 		goto unlock_mutex;
 	}
 
-	/* try to create a simple-framebuffer device */
+	/*
+	 * Try to create a simple-framebuffer device. It claims the memory
+	 * when it is added, so a DT PCI host bridge that probes later would
+	 * fail. Use an efi-framebuffer device there; it waits for the bridge.
+	 */
 	compatible = sysfb_parse_mode(si, &mode);
+	if (compatible && !parent && sysfb_efifb_behind_dt_pci(si))
+		compatible = false;
 	if (compatible) {
 		pd = sysfb_create_simplefb(si, &mode, parent);
 		if (!IS_ERR(pd))
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index ed23d6516223..b136fdebc746 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -95,6 +95,7 @@ static inline bool sysfb_handles_screen_info(void)
 
 extern struct efifb_dmi_info efifb_dmi_list[];
 void sysfb_apply_efi_quirks(struct screen_info *si);
+bool sysfb_efifb_behind_dt_pci(const struct screen_info *si);
 void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd);
 
 #else /* CONFIG_EFI */
@@ -103,6 +104,11 @@ static inline void sysfb_apply_efi_quirks(struct screen_info *si)
 {
 }
 
+static inline bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
+{
+	return false;
+}
+
 static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
 					  struct platform_device *pd)
 {

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-sysfb-dt-pci-efifb-d73b08ded4b2

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>


