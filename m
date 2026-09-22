Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BA8C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DFE10ED84;
	Tue, 22 Sep 2026 15:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGO92bOF";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90AC10ED78
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:34:35 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso7690732a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790091274; x=1790696074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KqNXgwrnC6/yf8ldr9VODDt8z7mpX7HYSVueoRJSAsQ=;
 b=QGO92bOFAMkrs4+BxDDZGsfJCNxWeIvGz/aNlCF8X4h4ezZdWLpL7X6X6xBIK861+T
 YK/JLve0ihRD/MlI9UdmzMZL0ASzrYIVbZK5KGAVF2BJDsz+9vB4JDmEQPbWyLdtIigR
 Diqr/WbmW54ewg769klUknmfITJwTjKUduqXMA15zDqdesua4OVgMSb5EPltN4xqkBNf
 uiLDsa9Vx6Xv2AFZz2xMzMJqlOPzF28ZpB6Uc5wGal2XiasFiUz0IBwQnmgeFQXCYEgz
 hw3rZnCc11fFjmgemxfB13VcKFcWYZQQgxGI2HMu367m9atDJeiR5F7rP6kKZ61YlqDa
 ftlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091274; x=1790696074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KqNXgwrnC6/yf8ldr9VODDt8z7mpX7HYSVueoRJSAsQ=;
 b=coNPtXItc6nA1ZdwW90LtcDR5JHW3wPfgLAB5ZXG/kQnDRW3jpIzJf2Leos7ssS5Q1
 H5EmHyZnUIj+ZIOE0c7GYg074mKrzjp7xI1l9OyN+oNSgocI4JcZdPeqYCXaRHDARgC0
 pRA5ZhUuyR69XF/3HcxWirN/Cu+hfVxu6Mv8AkNqLSxiz4R+yeHDxKa9j1SNuEsdWWc3
 hhrlMV1Le9c9aT1f65nuoMvrOofA11leMATyx5a3FkwL4QlTNaI3BzyVC/Tjiv2hLyI6
 QX+GMX3hiNY8YyFdj7MJENW1WEdkNKx6YBWgNle0PZpp0c8i2NFzuwV20ztzC8UtZH/n
 Sl7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8NydMZMevblpNxOikRGZJFmFih03r/rzYphe4xrGHBQorEc8yr5N4qly9xBK8P0Q2byZHvD+WqJI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ny24E62URZJlVUMqxHdriwovBeyfSEpjmWiEDvAFWdrhlRoqer
 TBIiwbyq+QDXDJ/IBLmAlI8EP521esc6PtPG1hPZyegYnIaRJ4OxS/b1
X-Gm-Gg: AYBFou0aRXMCgBsEwTZhgbSfCN9ytCDRRplTJw/ewnXIpmV7yXyIkO8uRpzlqjY6o7l
 +5jbreK89nk/VHmM6en5m3mzs99dt6O0febGrknHma2ti1nNzevTjjwaoaybaD466WwA6yttVZy
 N2UzCS5tYPqMBXro0x9diWAtllbS0c5LnW6PYIx4Z5utssuFL/tS3LGP+uErsvmaPfqTcegO65T
 s6B84RsR8thV1CYkD2epCXs61X0gex975h4xMxkvsPfhP8VrPdEAb1jjpJdeUS0oNNRvPnkG9Eu
 hgyHd05nIIBflQKQQvc+t6bURmxCH6v7CbtGLQ9Z9KWDZ2kATXm3iknDbrVEOWYtmfU76W01uLE
 RyjoZfio37RDnxLC9xXZA9bqub7bdHx2gpholZ4qjuFrnJ72GRmfFYNa73304Ug2RXEwzWsVZ47
 XvrBodm0laCwg7QVJiYmuRjyDQSBCNoRQrOhMb9E4eOcwEWdyIFBLtSg38NoiCCGm8FGSDHWQry
 vtbSUiUfWid8/8=
X-Received: by 2002:a05:6402:13d0:b0:6aa:a01e:f177 with SMTP id
 4fb4d7f45d1cf-6aaa01ef223mr3266486a12.21.1790091273890; 
 Tue, 22 Sep 2026 08:34:33 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aaa450c4basm1272517a12.20.2026.09.22.08.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:34:33 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 skainsworth@gmail.com, Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
Date: Tue, 22 Sep 2026 18:33:34 +0300
Message-ID: <20260922153334.136648-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092253-dimness-unethical-2515@gregkh>
References: <2026092253-dimness-unethical-2515@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.

ttm_tt_swapout() returns the number of pages swapped out on success and
a negative error code on failure; for a populated ttm it never returns
zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU
walk on swapout failure") moved the bulk_move bookkeeping in
ttm_bo_swapout_cb() under "if (!ret)", so the
ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_tail()
pair is now skipped on every successful swapout. The equivalent change
for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink()
infinite LRU walk on backup failure") tests "lret > 0", which is what
was intended here as well.

Before b2ed01e7ad3d the resource was taken off the bulk_move before the
swapout; since then a swapped-out resource stays inside its BO's
bulk_move range (and on the manager LRU) although it is unevictable.
When it is later freed or the BO leaves the bulk_move
(ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
ttm_resource_del_bulk_move() skips it because of its
!ttm_resource_unevictable() guard, so a range endpoint in pos->first /
pos->last is left pointing at freed memory. The next
ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cursor
is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(),
"list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
dereference in ttm_resource_manager_next() -- minutes to hours after a
hibernation, or at process exit / reboot following one. Samuel
Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
dangling cursor; the missing removal at swapout time is the reason it
dangles.

Testing the condition for success restores the removal. On an AMD
Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate on
a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
crashed 5 of 18 hibernation cycles; a function profile of one
hibernation showed 336 ttm_tt_swapout() calls and zero
ttm_resource_del_bulk_move_unevictable() calls. With this change the
removal happens for every swapped-out resource and 12 further cycles
were clean.

Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure")
Cc: stable@vger.kernel.org # v7.1+
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail.com
[ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed
  ("drm/ttm: apply the swapout bulk_move fix to the intended condition"):
  upstream 3db7d7d58341 was applied to the "if (ret)" after
  ttm_resource_try_charge() in ttm_bo_alloc_at_place() instead of the
  "if (!ret)" after ttm_tt_swapout() in ttm_bo_swapout_cb(), and
  fcfe64715b42 restored the former and changed the latter. 7.2.y has no
  ttm_resource_try_charge() (dmem cgroup charging is 7.3 material), so
  neither commit applies on its own; the net effect of the two is the
  single hunk below, which is the change the changelog describes. ]
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6..ca6fc5c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1178,7 +1178,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
-- 
2.53.0

