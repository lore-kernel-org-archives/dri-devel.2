Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7FFCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0357010EFA5;
	Thu, 28 May 2026 10:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="g9EWsGGL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3QjiCELX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g9EWsGGL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3QjiCELX";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4608810EFA5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:28:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7043B66F20;
 Thu, 28 May 2026 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779964093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FV2b9BnZl+VwY9JP+p3GK+XbUFegy/adMOFsk3qdFVc=;
 b=g9EWsGGLNBVcKs0aUqej/4MIKb5TLwXZpybLmADPkvzMVdHwFWzKKxtwCgIp50eHobKhh0
 vqxLcdnaTSSFlCL+KY2bkp4VH/SxVnPGO/i4POqOnGUOvuM7tt68MGlu4C3StCroQfJJw8
 Syse2SZ4Oe04twTpZK/eEtEhNotsbmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779964093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FV2b9BnZl+VwY9JP+p3GK+XbUFegy/adMOFsk3qdFVc=;
 b=3QjiCELXZCfJyY7+qnGGGcEmneCpRcYOhNCByb8WHIkNpWqJbLnuk+CESs9Gy29c9KYvDJ
 qQRhVnALwrTxC4Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g9EWsGGL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3QjiCELX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779964093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FV2b9BnZl+VwY9JP+p3GK+XbUFegy/adMOFsk3qdFVc=;
 b=g9EWsGGLNBVcKs0aUqej/4MIKb5TLwXZpybLmADPkvzMVdHwFWzKKxtwCgIp50eHobKhh0
 vqxLcdnaTSSFlCL+KY2bkp4VH/SxVnPGO/i4POqOnGUOvuM7tt68MGlu4C3StCroQfJJw8
 Syse2SZ4Oe04twTpZK/eEtEhNotsbmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779964093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FV2b9BnZl+VwY9JP+p3GK+XbUFegy/adMOFsk3qdFVc=;
 b=3QjiCELXZCfJyY7+qnGGGcEmneCpRcYOhNCByb8WHIkNpWqJbLnuk+CESs9Gy29c9KYvDJ
 qQRhVnALwrTxC4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 369B05AD33;
 Thu, 28 May 2026 10:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kV0oDL0YGGrRBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 10:28:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: boris.brezillon@collabora.com, igor.torrente@collabora.com,
 simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/gem-shmem: Immediately record writable mmap;
 drop pfn_mkwrite
Date: Thu, 28 May 2026 12:27:59 +0200
Message-ID: <20260528102809.399127-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7043B66F20
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[collabora.com,ffwll.ch,gmail.com,kernel.org,linux.intel.com];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Using pfn_mkwrite breaks KVM with "error: kvm run failed Bad address".
Seen on a Mali-G610 GPU. Fix this by marking writable mmapped pages as
written when installing the mapping in the page table.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Igor Torrente <igor.torrente@collabora.com>
Closes: https://lore.kernel.org/dri-devel/d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com/raw
Tested-by: Igor Torrente <igor.torrente@collabora.com>
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 48 ++++++++------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..7af31932af84 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -554,21 +554,6 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
-static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct drm_gem_object *obj = vma->vm_private_data;
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-	loff_t num_pages = obj->size >> PAGE_SHIFT;
-	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
-
-	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
-		return;
-
-	file_update_time(vma->vm_file);
-	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
-}
-
 static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
@@ -581,23 +566,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 
 		if (aligned &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
-			vm_fault_t ret;
-
 			pfn &= PMD_MASK >> PAGE_SHIFT;
 
-			/* Unlike PTEs which are automatically upgraded to
+			/*
+			 * Unlike PTEs which are automatically upgraded to
 			 * writeable entries, the PMD upgrades go through
 			 * .huge_fault(). Make sure we pass the "write" info
 			 * along in that case.
-			 * This also means we have to record the write fault
-			 * here, instead of in .pfn_mkwrite().
 			 */
-			ret = vmf_insert_pfn_pmd(vmf, pfn,
-						 vmf->flags & FAULT_FLAG_WRITE);
-			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
-				drm_gem_shmem_record_mkwrite(vmf);
-
-			return ret;
+			return vmf_insert_pfn_pmd(vmf, pfn, false);
 		}
 #endif
 	}
@@ -635,8 +612,18 @@ static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int ord
 	pfn = page_to_pfn(page);
 
 	ret = try_insert_pfn(vmf, order, pfn);
-	if (ret == VM_FAULT_NOPAGE)
+	if (ret == VM_FAULT_NOPAGE) {
 		folio_mark_accessed(folio);
+		/*
+		 * Immediately record write access to the buffer. The
+		 * natural place would be pfn_mkwrite at the time when
+		 * the access happens, but this breaks KVM.
+		 */
+		if (vma->vm_flags & VM_WRITE) {
+			file_update_time(vma->vm_file);
+			folio_mark_dirty(folio);
+		}
+	}
 
 out:
 	dma_resv_unlock(obj->resv);
@@ -683,12 +670,6 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 	drm_gem_vm_close(vma);
 }
 
-static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
-{
-	drm_gem_shmem_record_mkwrite(vmf);
-	return 0;
-}
-
 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
@@ -696,7 +677,6 @@ const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 #endif
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
-	.pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
 };
 EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 
-- 
2.54.0

