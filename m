Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C117EF30275
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 00:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084B910E206;
	Mon, 16 Mar 2026 00:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HAXuhQPA";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C764C10E117
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 00:27:14 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1271195d2a7so858327c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773620834; x=1774225634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RjV9FNP/ZZx7lYZ+bvw0t3S84c6Qov2i9oa8xc3xT3E=;
 b=HAXuhQPAUJcQLZ0yvYulldOYeP6xzal7V1Fof2qByTnBdAr6fi+SzzloE0htyj1Iny
 d1imW0tuts7ovegONZWx9CFEhi4pMBOYLkZM0+K0Hwzjlier+QneOUOumxuggyx5V02P
 HMRzum4wAu6v9+JQP98uyE0POqOBoz4HAQ38VHq/1PFd3daIclClmWqJ/Cr3EPkoEJ/s
 j03IlFysyDBFxR9klljeR3K3Yuw7mGBlrOccCORV1IwOVHI5oaIsco7I6GO2pPC+UoYX
 MkD7dwb5IRY8dttJgYhZaqPoNj2XQfRxuBG0rPPhL4IMVCPqQBdgHMNof6Bj6HX1f8wv
 Ihvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773620834; x=1774225634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjV9FNP/ZZx7lYZ+bvw0t3S84c6Qov2i9oa8xc3xT3E=;
 b=lWzvFcQR8LU0a4O8nKHHHi3HIPe2r63Ajy2qagW0zCfxcEMeIyS0JsxihZe2Qal3nC
 qZKGMehmmCix8YZvQ6pom1rcxwqGSYlybtnGMPhJxlxBOTRx06JP0DbwH1ccTdAsvrdA
 Lm0Buc7MG22NaqjMiyqnvDWopML9x9ZHqXyWJh+gyoc7vM/vZjS8t+/2iIfchZOkODIC
 qYIdPE4oXh5Xd027Ns7LYphfTkvukPeyxPLUMP8Ch0cjVLMOnfZjOV4qVBKHvtQfOo9V
 1YuN5Jp2zZ/ddtMlSKF0+V3VeAVbW3ELZ2+PfYmC0HaVOX2Jjy48JbL0Wwf8KX5caISr
 t2vw==
X-Gm-Message-State: AOJu0YxDJouhB4LrFIU3uAhTsU7sOK7xnAtcvOrzNgTR25vaJiyR4LT0
 vNeVHU42XzOp7+9LvocMp7U7SrTt2Rb+t1AdLOgWzqrGhnbTdS6DPeQ/
X-Gm-Gg: ATEYQzzIa2ucD8GPHT8gvgxydfAJNOih4Qdm3O/uy/8aFdooO3ZCYqtZIVfU7ODGDLK
 PT30PH5rRiXsOoz8BvBSBYXs4B5rW9uyI1Hse1bgordu9LVF9jGBo8m61Ska1IBwMN5DzD/yKOt
 Dsadya5ydytME7etbhxpRMPQAqfRH8kr3sv/dHo3AQh/uvWCG4fH/IfzKgSS6FBj2wNYw2ch/Zz
 7hEvmy2fQrVKlJE4mX8PIXIFV0eGw/SzHdLhLJ5MFvJ95T2NvA9llRUAIksNBlZ7ymeq67VY3lT
 JLvRb+CNqT2lqHj+IV7IKMS1Gzvk4tH1vfiAYNnAq99QXd734eXK0mzg3Q3iVIH0fPbR84HNExC
 zWFyJX1p7vB2FRbP/nRQBpRedKXekFRUkCoG2jMhG7565ino8q9zlG2oFX4f158q7RO/FE3p84L
 oaLUQZa5kkpzHlBzy6YIYaTQ8w1Y3I1w+eMUPm+xrlYyZwZKpWvoxUw0pMS7nSEJ/jiJNabQ==
X-Received: by 2002:a05:7300:3724:b0:2c0:afcc:c732 with SMTP id
 5a478bee46e88-2c0afccde55mr2645688eec.29.1773620833846; 
 Sun, 15 Mar 2026 17:27:13 -0700 (PDT)
Received: from ryzoh.168.0.127 ([2804:14c:5fc8:80a3:8b71:8583:278d:8c27])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-2beab526f9asm15427371eec.19.2026.03.15.17.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 17:27:13 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Date: Sun, 15 Mar 2026 21:26:49 -0300
Message-ID: <20260316002649.211819-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When running ./tools/testing/selftests/mm/split_huge_page_test multiple
times with /sys/kernel/mm/transparent_hugepage/shmem_enabled and
/sys/kernel/mm/transparent_hugepage/enabled set as always the following BUG
occurs:

[  232.728858] ------------[ cut here ]------------
[  232.729458] kernel BUG at mm/memory.c:2276!
[  232.729726] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[  232.730217] CPU: 19 UID: 60578 PID: 1497 Comm: llvmpipe-9 Not tainted 7.0.0-rc1mm-new+ #19 PREEMPT(lazy)
[  232.730855] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  232.731360] RIP: 0010:walk_to_pmd+0x29e/0x3c0
[  232.731569] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
[  232.732614] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
[  232.732991] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
[  232.733362] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
[  232.733801] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
[  232.734168] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
[  232.734459] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
[  232.734861] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
[  232.735265] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  232.735548] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
[  232.736031] Call Trace:
[  232.736273]  <TASK>
[  232.736500]  get_locked_pte+0x1f/0xa0
[  232.736878]  insert_pfn+0x9f/0x350
[  232.737190]  ? __pfx_pat_pagerange_is_ram+0x10/0x10
[  232.737614]  ? __pfx_insert_pfn+0x10/0x10
[  232.737990]  ? __pfx_css_rstat_updated+0x10/0x10
[  232.738281]  ? __pfx_pfn_modify_allowed+0x10/0x10
[  232.738552]  ? lookup_memtype+0x62/0x180
[  232.738761]  vmf_insert_pfn_prot+0x14b/0x340
[  232.739012]  ? __pfx_vmf_insert_pfn_prot+0x10/0x10
[  232.739247]  ? __pfx___might_resched+0x10/0x10
[  232.739475]  drm_gem_shmem_fault.cold+0x18/0x39
[  232.739677]  ? rcu_read_unlock+0x20/0x70
[  232.739882]  __do_fault+0x251/0x7b0
[  232.740028]  do_fault+0x6e1/0xc00
[  232.740167]  ? __lock_acquire+0x590/0xc40
[  232.740335]  handle_pte_fault+0x439/0x760
[  232.740498]  ? mtree_range_walk+0x252/0xae0
[  232.740669]  ? __pfx_handle_pte_fault+0x10/0x10
[  232.740899]  __handle_mm_fault+0xa02/0xf30
[  232.741066]  ? __pfx___handle_mm_fault+0x10/0x10
[  232.741255]  ? find_vma+0xa1/0x120
[  232.741403]  handle_mm_fault+0x2bf/0x8f0
[  232.741564]  do_user_addr_fault+0x2d3/0xed0
[  232.741736]  ? trace_page_fault_user+0x1bf/0x240
[  232.741969]  exc_page_fault+0x87/0x120
[  232.742124]  asm_exc_page_fault+0x26/0x30
[  232.742288] RIP: 0033:0x7fb4d73ed546
[  232.742441] Code: 66 41 0f 6f fb 66 44 0f 6d dc 66 44 0f 6f c6 66 41 0f 6d f1 66 0f 6c fc 66 45 0f 6c c1 66 44 0f 6f c9 66 0f 6d ca 66 0f db f0 <66> 0f df 04 08 66 44 0f 6c ca 66 45 0f db c2 66 44 0f df 10 66 44
[  232.743193] RSP: 002b:00007fb4907f68a0 EFLAGS: 00010206
[  232.743565] RAX: 00007fb47840aa00 RBX: 00007fb4d73ec070 RCX: 0000000000001400
[  232.743871] RDX: 0000000000002800 RSI: 0000000000003c00 RDI: 0000000000000001
[  232.744150] RBP: 0000000000000004 R08: 0000000000001400 R09: 00007fb4d73ec060
[  232.744433] R10: 000055f0261a4288 R11: 00007fb4c013da40 R12: 0000000000000008
[  232.744712] R13: 0000000000000000 R14: 4332322132212110 R15: 0000000000000004
[  232.746616]  </TASK>
[  232.746711] Modules linked in: nft_nat nft_masq veth bridge stp llc snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore overlay rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr ppdev 9pnet_virtio 9pnet parport_pc i2c_piix4 netfs pcspkr parport i2c_smbus joydev sunrpc vfat fat loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport zram lz4hc_compress vmw_vmci lz4_compress vsock e1000 bochs serio_raw ata_generic pata_acpi scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse qemu_fw_cfg
[  232.749308] ---[ end trace 0000000000000000 ]---
[  232.749507] RIP: 0010:walk_to_pmd+0x29e/0x3c0
[  232.749692] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
[  232.750428] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
[  232.750645] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
[  232.750954] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
[  232.751232] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
[  232.751514] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
[  232.751837] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
[  232.752124] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
[  232.752441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  232.752674] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
[  232.752983] Kernel panic - not syncing: Fatal exception
[  232.753510] Kernel Offset: disabled
[  232.754643] ---[ end Kernel panic - not syncing: Fatal exception ]---

This happens when two concurrent page faults occur within the same PMD range.
One fault installs a PMD mapping through vmf_insert_pfn_pmd(), while the other
attempts to install a PTE mapping via vmf_insert_pfn(). The bug is
triggered because a pmd_trans_huge is not expected when walking the page
table inside vmf_insert_pfn.

Avoid this race by adding a huge_fault callback to drm_gem_shmem_vm_ops so that
PMD-sized mappings are handled through the appropriate huge page fault path.

Fixes: 211b9a39f261 ("drm/shmem-helper: Map huge pages in fault handler")
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---

Changes in v3:
 - Pass a try_pmd boolean parameter to drm_gem_shmem_any_fault
 - Compile drm_gem_shmem_huge_fault only if CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
is defined to avoid a build warning

Changes in v2: https://lore.kernel.org/dri-devel/20260313141719.3949700-1-pedrodemargomes@gmail.com/
 - Keep the #ifdef unindented
 - Create drm_gem_shmem_any_fault to handle faults of any order and use
drm_gem_shmem_[huge_]fault() as wrappers

v1: https://lore.kernel.org/all/20260312155027.1682606-1-pedrodemargomes@gmail.com/

---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 63 ++++++++++++++------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7b5a49935ae4..9428c3ab7283 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -550,36 +550,18 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);

-static bool drm_gem_shmem_try_map_pmd(struct vm_fault *vmf, unsigned long addr,
-				      struct page *page)
-{
-#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long paddr = pfn << PAGE_SHIFT;
-	bool aligned = (addr & ~PMD_MASK) == (paddr & ~PMD_MASK);
-
-	if (aligned &&
-	    pmd_none(*vmf->pmd) &&
-	    folio_test_pmd_mappable(page_folio(page))) {
-		pfn &= PMD_MASK >> PAGE_SHIFT;
-		if (vmf_insert_pfn_pmd(vmf, pfn, false) == VM_FAULT_NOPAGE)
-			return true;
-	}
-#endif
-
-	return false;
-}
-
-static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, bool try_pmd)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 	loff_t num_pages = obj->size >> PAGE_SHIFT;
-	vm_fault_t ret;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
 	struct page **pages = shmem->pages;
 	pgoff_t page_offset;
 	unsigned long pfn;
+	unsigned long paddr;
+	bool aligned;

 	/* Offset to faulty address in the VMA. */
 	page_offset = vmf->pgoff - vma->vm_pgoff;
@@ -593,13 +575,19 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 		goto out;
 	}

-	if (drm_gem_shmem_try_map_pmd(vmf, vmf->address, pages[page_offset])) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
 	pfn = page_to_pfn(pages[page_offset]);
-	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	if (try_pmd) {
+		paddr = pfn << PAGE_SHIFT;
+		aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
+
+		if (aligned &&
+		    folio_test_pmd_mappable(page_folio(pages[page_offset]))) {
+			pfn &= PMD_MASK >> PAGE_SHIFT;
+			ret = vmf_insert_pfn_pmd(vmf, pfn, false);
+		}
+	} else {
+		ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	}

  out:
 	dma_resv_unlock(shmem->base.resv);
@@ -607,6 +595,22 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	return ret;
 }

+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
+					   unsigned int order)
+{
+	if (order != PMD_ORDER)
+		return VM_FAULT_FALLBACK;
+
+	return drm_gem_shmem_any_fault(vmf, true);
+}
+#endif
+
+static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+{
+	return drm_gem_shmem_any_fault(vmf, false);
+}
+
 static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
 {
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -643,6 +647,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)

 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+	.huge_fault = drm_gem_shmem_huge_fault,
+#endif
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
 };
--
2.47.3

