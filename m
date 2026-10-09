Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D9CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8108210E41A;
	Fri,  9 Oct 2026 03:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MT1v4yq5";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167B910E41A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:26:34 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1562196a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791516393; x=1792121193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LYAohfURFktRBLdiWxIwClXMCDAhfiRzTvJlH6pEOZU=;
 b=MT1v4yq5MDcP61CJKskgA4xgOojXPQRNHiDfIxAj7zW+5F60oH2jCNb+nvHDudlvsa
 TxrqjunSAZ8cqcdcDSdElaDfaOPbyrHLxEqbxh+Fjdt6dUWVtYxo+hFoY0tNXX43v5BX
 g0MxbOhh1NQDwHSdFbsR3MM5sMlRRZ8prfFRUH3DL7ZfsRKw2kXugsQqrM+HVMZrxA+0
 iSl7S8I0gMhSeY8KmdyzrtlMcfH601L4YgiZHb8SGKyfr1CpA5bd86hmnVRFySSNC54p
 U42dYtHgUtP1D/bJ9qfT2DFrUmIkKisQhWFWXF04lJwi//66MCYHkj+I46P1XOf/YpxP
 WJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791516393; x=1792121193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LYAohfURFktRBLdiWxIwClXMCDAhfiRzTvJlH6pEOZU=;
 b=gNJdIAqOhq1mEB26sZ9iuXfSUy2+RsJFv6EZ1iIwlwkOAYFmET6I9PRC8nTyistbMB
 khp7WOhzWapOLhChweN5fn+I0BvfwXVqMpCl+JlBdSzAB4DrRy9d1Fj+thPBfn33AKCQ
 dwF/fK5v7FN4G23r3f7RDMhXhbGyHKFWxK4Zbm4noKKUzxgayx6/+uClY3MfFHOn3dJh
 ZWOAsPVl5PsQfgVCael2aPYW8yiv41Dx1W1H1xNAAS8ZTk3o/ICFOwD6kOhqbqNhtlFc
 DPvcQZtI/1Ubka+sm1YE8zxUPBZRJSNIw1LDdO0EChUQ5Wi8DFdSlprRUo/QNtUyY5Wd
 iBuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvJZgULX/MrlOmC1RpgABhvbunkrZyos8Tk3EM0C9s5HMJaMP7mnTJA+dlrvrA2coF+jcw38OAgMQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLhrmQM0YjCsPkhvVqgTHjQqFf7N7qnrW6gqH/wSw2lESCDrHyB
 lrKOXq1rsIF2PhoCXaFfBlTmyDN46FYS7jEoQI6Mn3tv7QtwQd8lEtHz
X-Gm-Gg: AYBFou28564JsYH4U+uGzReFnjRmzJx6MhJghqFKQjKrsdH4P0NJKJQV8pnyq0Ro60b
 j3H0JJ4mTYkZHYvazfUCZ6nhadgurgogOklYRDo27HUzUhe1Ln4/ZKgc+11aq5pjBJ+8VKBNuJ+
 Y9ROiKr3vYF9KK99Cbnzr7vwc8bjlXUwe5KVo9mU5brWK8LMH32jLT2vz7E40wb6Vw610BWNJSG
 6LufkbwQKFU1Haupqpg8WiAbnTo83Q+m+uJbUj8Bkal2+8eGeB2gC+iywLsQt8zhq6rTa6GtU88
 Gt9648qarRO8lYjF1cmqA8qQE/KwhNLKiGYUipoY0PfF2SyGn0tTT86UkOigNWoDFQNIxV4hmb/
 ASCvTraTlg7VmXttwUxzQFmuLAP4RS8fFPfzsq1p35bZnxue6XN38x8/U3irUaeZk23W70xuwlK
 MjLv8ZewWzZdhXd2XwZv+Lemq9LXW8sBk7p/63k2ZuJkrh0v3Nl/aUu0OuAeXuX5yT5X0sOwbON
 GTxep/PNsuH/LkCIKXCRmaE9lvBsdVTYyAtkUK0NpNo+v4GBztmT1uAsWaVc1tlXF8MhmIimwPV
 0QIR9m8C
X-Received: by 2002:a17:90b:4b09:b0:39e:3713:c2e4 with SMTP id
 98e67ed59e1d1-3ab3ac58076mr575751a91.14.1791516393448; 
 Thu, 08 Oct 2026 20:26:33 -0700 (PDT)
Received: from 0xiviel ([49.224.123.154]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm1436401a91.15.2026.10.08.20.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 20:26:33 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to the BO
 size
Date: Fri,  9 Oct 2026 16:26:14 +1300
Message-ID: <20261009032616.432392-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

[ Upstream commit dbc8fd7a03cbc0704e8e558a448015f620547a02 ]

amdxdna_drm_sync_bo_ioctl() passes the caller's offset and size to
drm_clflush_virt_range() on the BO's kernel mapping without checking
either against the BO size. The ioctl has no permission flags: any
process that can open the accel node controls the offset. Any BO with a
kernel mapping reaches that call: AMDXDNA_BO_DEV_HEAP, AMDXDNA_BO_DEV
and AMDXDNA_BO_CMD. A DEV_HEAP is vmapped, so an offset equal to its
size lands the flush on the vmap guard page.

Measured on 6.18.55 on an AMD Ryzen AI 9 365 NPU, firmware 1.0.0.63,
as a non-root user with access to the accel node: unpatched, an offset
equal to the 64 MiB DEV_HEAP size oopses in drm_clflush_virt_range()
under amdxdna_drm_sync_bo_ioctl(), 2 of 2 runs; patched, the same call
returns -EINVAL, 2 of 2, and an in-bounds sync returns 0, 2 of 2.
DEV_HEAP is the type tested; DEV and CMD are by code reading.

Upstream bounds the range in amdxdna_flush_bo(), added by commit
dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support").
This applies only that check: an offset at or past the BO's end, or
an overflowing offset plus size, returns -EINVAL.

Deviations from upstream: that commit adds a feature and is too large
for stable as a whole. It calls drm_WARN() when the check rejects a BO
whose type is not AMDXDNA_BO_DEV, which userspace can trigger; this
fix does not. Upstream bounds AMDXDNA_BO_DEV by the heap chunks it
spans and flushes only the overlap, reporting no error for an offset
past the end; 6.18 has one heap per client, so this fix uses the BO's
own abo->mem.size and rejects such an offset instead. As in upstream,
a size past the BO's end is clamped, not rejected.

Built from v6.18.55 with the test system's distro-derived config,
DRM_ACCEL_AMDXDNA=m. The touched file also compiles W=1 clean.

Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
Cc: stable@vger.kernel.org # 6.18.x
Assisted-by: LLM
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index ca747457cec7..95d04af2b993 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -934,6 +934,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	struct amdxdna_drm_sync_bo *args = data;
 	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
+	u64 end, size;
 	int ret;
 
 	gobj = drm_gem_object_lookup(filp, args->handle);
@@ -943,6 +944,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	}
 	abo = to_xdna_obj(gobj);
 
+	if (args->offset >= abo->mem.size ||
+	    check_add_overflow(args->offset, args->size, &end)) {
+		ret = -EINVAL;
+		goto put_obj;
+	}
+	size = min(abo->mem.size, end) - args->offset;
+
 	ret = amdxdna_gem_pin(abo);
 	if (ret) {
 		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
@@ -955,7 +963,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (abo->mem.kva)
-		drm_clflush_virt_range(abo->mem.kva + args->offset, args->size);
+		drm_clflush_virt_range(abo->mem.kva + args->offset, size);
 	else if (abo->base.pages)
 		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
 	else
-- 
2.53.0

