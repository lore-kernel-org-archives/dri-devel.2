Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC53606A337
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPb5Sorv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F5110E1B7;
	Fri, 13 Nov 2026 20:19:06 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D6B10E1B7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:19:00 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b5973a4b4cso2570762a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601138; cv=none;
 d=google.com; s=arc-20260327;
 b=OVi1fTjxit9MH9WUHrI9tP42gcRSuUkF7WM6OXNwGcQwQyjMNOshQhRlxS4x2JWT+f
 /1ELpws9qfcGemCtBo0kAI1n8I4ltzAxIy9iM9QmrTywPWFqJx+Qvm51gZ7nqGy+Xkf0
 PfdKQN4cc2ViS6UH3MW+7vAcS4bBUzCrpDE5uiFMsudievtPg3wNHWsxIolLHvYukNuD
 pF4aq7hlxzuPQ9+8VyuI9B5yFs2NUGa5xess7JGgQgwnqVCIPdsHQ4ygQsRb5j3ShG9+
 ifKwvC6nI5EcDD/y/1EwkmHB1g36Kt9hDMDvh6Emz0znTwKzM74lakP15Rw6A16wsnwI
 CCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=bxdV0RP3/aehfscZJClHsIJTJuMBYVFzVd+ePnY7CqU=;
 fh=oa7HM1yJ0fAYhRdWfUySMelpSsFIGNhkFbTT/Ck/yM0=;
 b=YV5ZxxnmT9xYQIHT++ND3cvUOiti0c6/lM1hcJ1JmsFNAITq0nlYFmtKiVYhy4DIdh
 tNxjxa+xpyeGbNIZaZX3ybO9BTW7BgOZi3thjGNg6pnQ4j/uOCSyTalZGMQfjlZy0H0R
 xrBHiZLr/VPjdipMX+za4FpzRfyr2+cGOzZM2yjBiQRU/rFmjHETg8hmlcEW2WuX3Xo8
 Tfxz4cNOIepU8E+2kjcmF/UCBp25kcJddEk9iRqGWuTxlfwQ1Verqa96Fr/Yi+PN4IS2
 rrWQGb5c7VJOlSpD0COxP7G74l8mNjZ9T33AlhLJ8/eSCeBPmed/ojAx66X7GflWahPy
 xrdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601138; x=1795205938; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bxdV0RP3/aehfscZJClHsIJTJuMBYVFzVd+ePnY7CqU=;
 b=aPb5SorvpK+JT2ni3etqe2yepoCDJzoVRvkxAS3RH+pniTyN5mQWU7zDSOzx0J9CDc
 MVo+Xin16LhbnHNTTnUQHSsm2eYls8bzDDz9rtm5nv4SLywp0zCwh6rSNnhyK7HOg3dk
 CxJZyNX+NCau6DXXVH97kzmXRBNgfyJ7KWgFQmgRLe4M72A3FDBM0JkL9BLzFGiEE4ni
 om0LKJZuAiHLKo2Ppgcw/5EyntOE4cl5v5u8lTi3uIz1rkizjzMraLQ1KqqqJMpt48YX
 Bv2TesakIrziZ2q8xbMd85ErgY4v8p/c0WZUDNLnq4PkFtwfuJiZ4xck4ZfNGQ7rukWN
 3pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601138; x=1795205938;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bxdV0RP3/aehfscZJClHsIJTJuMBYVFzVd+ePnY7CqU=;
 b=tS/Siyeq6q6G9gHOB4bMTvNdYoW9mEWOMVk1O7NdRxD181mzfrZnESMTQvpiLUrnRk
 8K6VMi4pKVqU0r30khgWK2vzEyIH5bk2EY7r2lEUeY8KeQkDdDetmaoKn0JFaTRiuEme
 Y+0PlnYxgNdSxgIMWLAUxM0RiiYyxsdUhuie9boTcyxK15oFUSmpUN9qFx6UE7GXBEjD
 5hdKY8NewFTdu3/B6EcbwQin34uIAd0n7rjz9qPA4FpkYyNXqCkcJuCauQzmpQwbh+33
 fMjS+MHbw34YagJ6uL0kcMROGEMsRP1b4C8xUaeSEIak2HfQCYp1uRw+VQPWHEyig5Fm
 wPyw==
X-Gm-Message-State: APuU4Z+sME6OLT0QO7wrMLbMBbSQUqq0WiQLARRK2AjbtEvGAyOBijnv
 AFmER6+DNBNKlliLSG2OFXID15yl0ZY4GKzwPvy4r9F6Z4GVUKQoL/vE4z7Q6WfciwsaGd018ii
 lVQTHDZhHrJJ/wsyq0O6ZXTW4MziK1+Zg6l5yMKc=
X-Gm-Gg: AYBFou18xXjZwv3NeFSrwXF9cvNi1+/SCSwhfezHN2WBZljGDh5tUdDbHs2IgJ0hIUJ
 7U/OF/lB3YcxsGjTiLoD9Sy1KfVrRClupOFdqukKn5mqFLJ2Xul4BJf8lJcNDZCxT5qXEx34KLw
 DuNmRMt/GE2/V4tJM7NTQ9O4wYUzGPBIg7xEKVTzJ9s68W8sCix7WEC3lP3ilKRG6zSseYn7iju
 HOuvIKJ0eIAI1AtQNSqYxDwk+rUy4XWxvayFwp2KXZ6fS8DeiX419ZkTjaKCtoYrGjAVC03mmZF
 /Zs4j+vTC4dQmcBOmIv+bJ55AlnAZkfMOJrGgs2Oa7agMI5Kwmhz+bnfo5znas2HD9hhtW121yN
 m8tb7guRFQa3LY99MmIsAESjnsAXBZ3wMlPchyZaftOucj53EItqWEJ6N
X-Received: by 2002:a05:6402:438f:b0:6b5:5ee4:c9d8 with SMTP id
 4fb4d7f45d1cf-6b7c0c8232bmr3161478a12.32.1794601138220; Fri, 13 Nov 2026
 12:18:58 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 13 Nov 2026 12:18:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
Date: Fri, 13 Nov 2026 12:18:57 -0800
X-Gm-Features: AclHuK--1NFqXOjx8WWPAptRvidio2BOB5T4tePseaJTl0xtIBOB400EWhqKPjM
Message-ID: <CAFGNeajxU1xU3V=dO_+CczMoECrmwnmRq+dbRzKtXVe8vXui7w@mail.gmail.com>
Subject: [PATCH 1/10] drm/gma500: use the common dumb-buffer size helper
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_create_dumb() already validates width * cpp * height before
calling the driver. On 32-bit systems, however, multiplying the pitch
after its 64-byte alignment by height can still overflow size_t.

Use drm_mode_size_dumb() for the aligned calculation and preserve the
64-byte pitch and page-aligned allocation.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 2708e8c68f4c5bae592292c257de47bdef3e41e9..7250bf660abd204f72e4fc07ff3e95e614252f30
100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>

 #include <drm/drm.h>
+#include <drm/drm_dumb_buffers.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vma_manager.h>

@@ -200,21 +201,16 @@
 int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			struct drm_mode_create_dumb *args)
 {
-	size_t pitch, size;
 	struct psb_gem_object *pobj;
 	struct drm_gem_object *obj;
 	u32 handle;
 	int ret;

-	pitch = args->width * DIV_ROUND_UP(args->bpp, 8);
-	pitch = ALIGN(pitch, 64);
-
-	size = pitch * args->height;
-	size = roundup(size, PAGE_SIZE);
-	if (!size)
-		return -EINVAL;
-
-	pobj = psb_gem_create(dev, size, "gem", false, PAGE_SIZE);
+	ret = drm_mode_size_dumb(dev, args, 64, 0);
+	if (ret)
+		return ret;
+
+	pobj = psb_gem_create(dev, args->size, "gem", false, PAGE_SIZE);
 	if (IS_ERR(pobj))
 		return PTR_ERR(pobj);
 	obj = &pobj->base;
@@ -225,8 +221,6 @@

 	drm_gem_object_put(obj);

-	args->pitch = pitch;
-	args->size = size;
 	args->handle = handle;

 	return 0;


On Fri, 13 Nov 2026 12:17:54 -0800, Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
> Hi,
>
> This series fixes existing gma500 dumb-buffer, GEM and SGX page-table bugs
> against Linux 7.4-rc2, 7475ea8b58616b33c04afb976cf0fbaad9dd63fb. It keeps
> SGX535 support and the current driver selection. The series contains no
> architectural migration, new rendering interface or accelerated admission.
>
> The existing DRM ioctl already checks width * cpp * height. The dumb-buffer
> fix covers the product after 64-byte pitch alignment on 32-bit size_t.
> The unpin fix uses drm_WARN_ON() and retains reservation-lock cleanup.
> The cache fixes separately address a directory-entry flush after unmap
> and the unconditional clflush_count division. The former is exposed by
> 32-bit HIGHMEM with CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP.
>
> Following Joseph Telaak's review of the previous six-patch RFC, the MMU
> changes are split into zero-page semantics, the incorrect stolen-range
> unload address, removal of absent mappings, range validation, and a
> transactional insertion/error-cleanup unit. The old inner do/while loops
> executed once for zero-page requests; they become no-ops here.
>
> One deliberate exception to splitting every lock change is patch 9. The
> write semaphore, prefix rollback and newly introduced GEM page-release
> error paths form a single safety unit. A rollback prefix cannot remain
> owned while another writer is allowed to change the range. Keeping these
> changes together prevents selecting an error-propagation-only patch that
> frees pages while stale PTEs reference them. The temporary host fault test
> explicitly checks for PTE references before each put_pages call; removing
> rollback triggers that assertion.
>
> For backports, take that entire transaction and its range-validation
> prerequisite (patch 8). Do not separate err_put_pages or weaken writer
> exclusion. A textual git-apply result alone does not establish safe
> backporting. Fixes tags were checked against the original introducing
> source: 8c8f1c958ab5 for MMU/cache behavior and ae012bdc5799 for the stolen
> mapping and unchecked callers. The unload fix uses the load address,
> gatt_start, rather than mmu_gatt_start (0xe0000000).
>
> Current validation:
>   - Native, UBSan and i386 CPU harnesses: ten MMU cases / 50 assertions,
>     twelve extra fault/cache checks, 48 GEM checks and eleven fixture
>     allocation budgets passed. Kernel services in these harnesses are
>     simulated; no device or GPU is involved.
>   - Actual original sizing arithmetic / DRM alignment-helper boundary
>     witness passed on native, UBSan and i386 CPU backends.
>   - i386 W=1 / HIGHMEM4G / forced-local-map gma500 objects compiled.
>   - Normal x86_64 W=1 gma500 driver objects/archive compiled successfully.
>   - Full i386 W=1 / HIGHMEM4G / forced-local-map guest-kernel link passed.
>   - The actual guest kernel passed all ten software MMU KUnit cases under
>     QEMU TCG; guest exit0 and parser exit0. This is software emulation,
>     without a physical SGX/device or hardware cache/TLB validation.
>   - Patch-prefix replay and source whitespace checks passed. Checkpatch
>     has zero errors; the new KUnit file gets the generic MAINTAINERS
>     advisory and is covered by the existing gma500 directory entry.
>
> Hardware display, GPU, suspend/resume and platform validation have not
> been run for this candidate. No upstream-readiness or
> hardware-validation claim is made.
>
> Patch list:
>   1. Use the common dumb-buffer size helper.
>   2. Prevent GEM unpin underflow with a device warning.
>   3. Flush the directory entry within its local mapping lifetime.
>   4. Calculate CLFLUSH count only on the path that uses it.
>   5. Make zero-page MMU requests no-ops.
>   6. Remove the stolen mapping at its load address.
>   7. Skip absent mappings during removal.
>   8. Validate MMU ranges and exclusive endpoints.
>   9. Make failed MMU insertion safe for GEM error cleanup.
>  10. Add software-only KUnit coverage.
>
> Thanks,
> Gabriel Gama
