Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD0CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7832310EA25;
	Thu, 18 Jun 2026 14:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zO3Zph7v";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8AD10EA25
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:03:50 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c07a6520cafso91775066b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781791429; x=1782396229; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=38plZ0uTNBbwKeBUJYWbAXFzzu4qCG2nojxXWDV02QY=;
 b=zO3Zph7v6A5hm1mdNUGjIidup1MLnEOGiC8zN31JiJ399DKeyYnjw3f+17YhPjgHxp
 rxz4Vm4QR7Dc2hsjpdMr+62W0GtEfcauotm1kP3YmbsUkJj9XT3pjliw0VoCG+QimHfJ
 xsA0T1CDpiOiWyti2eTm3u48B3PaDF0WgqJ7cBxKAB4ZVuE8pU9CQbTwmqP6dMRVd/v3
 5jK+aSt0tpBkG7eGLRC5kWYTvUdwXmAbQ3Y00Lj9Ik2bg2uPgkKkRSFp7vKcccoVNZRF
 FeEvZROCRUzzhYEvxXQg/Wg3KTOF1hBNnTsEV/+GXVXsW1BwZXJA/Typ3pMIwLu+Jt+w
 xY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781791429; x=1782396229;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38plZ0uTNBbwKeBUJYWbAXFzzu4qCG2nojxXWDV02QY=;
 b=phEQVFGsbxX1xJdC5/6vq5sFmJSIbebzqkaLFnm1+o2Q1PIWUPC0UrsniibMv11qb0
 pzGXhOuuhjBM6deZgTIor/h9wqL8SfziXzMKoYxjxGHKp2eB1cr01n0bHUcgjRqHlQQc
 GlwXwhJ5cDdo8DAB65/GknmX+Wm+vEF1Q7GOw5fE4WYc2wwXY3xWUXZ4ShQXt6jCAa6E
 TDi7NWa9ta4NHHuiNIEYje2B+aCf8EOea+C25V2RHqJVlhhwOpTJJgJs9GsT48G3fpKM
 quCMUJ0T9Zt5JDd6LwxZfK9e92DN7Z+91i1c9u053Vl/2lrGv2xYLgdov6qy+n0kc0fd
 pd0Q==
X-Gm-Message-State: AOJu0YxNrj01GapYeXhSxxf/EN4AxeaNVaPYBV6+6ggim6jpTeUvTWHI
 QH5Ftaf4oPV3z9G75A8lm77yb3eEbae8SCmNPj/Gn+nlRF+uC8Lmj+yVtEiIgNgLDwI=
X-Gm-Gg: AfdE7clp0DBFq1vOsQcinDETzZPiaSui3JuTkqD3mJ8d+X/17yggMZ/2wGD0unQERvX
 aeqGAKJyieyDlyjqAlIxuIcg4UOq4oFhDg8nIwMQhtv5pnHjHm8myjlrxTjtOJLw4nhr62KTOsq
 7oTQ/BgIPE0qKLNvZqMPyVFDOsBsreO9agsk09iUorCSGEezi8wsdFuyIesbk+KdagxXs+xKm0H
 rBH6ted34MI4pOq6Dz9FHLtuUCGoZIavVefRjHy+JpMBvJvO0PLnaN+Lzu5vM8BCZJIvaqzTNFg
 k5BurBxakkD0905Whk4pKhWBdiq5GeChURuYFsov2UaMxjDuyxL5cfC51Ht37LjKHl2+tiUMTgG
 XwuGG4+2td8zKmfO+3u8vIZudOYXZlzY1wpaKjL8yVGUBy/30vj4VD1BdAn7M6GUAk1DeKsFS0I
 iv7z5ZlR5vkjJkRiJI8JvH/niQ+nYKLo39k2yulzxVSn+GK/ctuVFbhG5o2E0yvkQ9/7R3Ym2mz
 VHBqXI=
X-Received: by 2002:a17:907:970f:b0:c05:8586:da12 with SMTP id
 a640c23a62f3a-c07c81d1871mr124087466b.50.1781791428476; 
 Thu, 18 Jun 2026 07:03:48 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (181.179.204.35.bc.googleusercontent.com. [35.204.179.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb9014501sm973334366b.60.2026.06.18.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:03:47 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 18 Jun 2026 15:03:45 +0100
Subject: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMD6M2oC/x2M7QpAQBAAX0X725Xb85VXkXSdxRZHe0jJu7v8n
 KmZBwIJU4AmeUDo4sCbj6DTBNxs/USKh8iAGZZZqWu1sD9vNcjaOzlcP/KNCo2tnClym2uEWO5
 C0f/XtnvfD1Lv8uZlAAAA
X-Change-ID: 20260618-linux-drm_crtc_fix2-23a7c354a412
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
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

Since commit 541c8f2468b9 ("dma-buf: detach fence ops on signal v3"),
I'm seeing the BUG_ON() triggering in drm_crtc's fence_to_crtc() via
drm_crtc_fence_get_driver_name() regularly:

    Call trace:
     panic+0x58/0x5c
     die+0x160/0x178
     bug_brk_handler+0x70/0xa4
     call_el1_break_hook+0x3c/0x1a0
     do_el1_brk64+0x24/0x74
     el1_brk64+0x34/0x54
     el1h_64_sync_handler+0x80/0xfc
     el1h_64_sync+0x84/0x88
     drm_crtc_fence_get_driver_name+0x60/0x68 (P)
     sync_file_get_name+0x184/0x45c
     sync_file_ioctl+0x404/0xf70
     __arm64_sys_ioctl+0x124/0x1dc

This looks to be caused by a code flow similar to the following:

+++ snip +++
thread A                             thread B

                                     ioctl(SYNC_IOC_FILE_INFO)
                                     sync_file_ioctl()
                                     sync_file_get_name()
dma_fence_signal_timestamp_locked()  dma_fence_driver_name()
                                       ops = rcu_dereference(fence->ops)
                                       if (!dma_fence_test_signaled_flag())
                                         ops->get_driver_name(fence) i.e.
                                         drm_crtc_fence_get_driver_name()
test_and_set_bit(SIGNALED)
RCU_INIT_POINTER(fence->ops, NULL)
                                     drm_crtc_fence_get_driver_name()
                                       BUG_ON(rcu_access_pointer(fence->ops)
                                              != &drm_crtc_fence_ops)
+++ snap +++

I see two ways to resolve this:
a) simply drop the BUG_ON(). It can not work anymore since above
   commit, as it is racy now.
b) pass the original 'ops' pointer obtained in dma_fence_driver_name()
   to all callees.

This patch implements option a), as because:
* I don't see much benefit in passing the extra pointer just for this
  BUG_ON() to work.
* Requiring the dma_fence_ops in those callbacks is an implementation
  detail of the drm_crtc driver, and therefore upper layers shouldn't
  have to care about that.
* The existence of the BUG_ON() doesn't appear to be consistent with
  implementations of ::get_driver_name() or ::get_timeline_name() in
  the majority of other DRM drivers in the first place. Those that do
  have a similar BUG_ON() (i915, xe) probably also need an update
  similar to this patch here but I'm not in a position to test those.

Note that the adjacent drm_crtc_fence_get_timeline_name() has the same
problem and is fixed by this patch as well.

Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/gpu/drm/drm_crtc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..31c8636e7467 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -73,6 +73,9 @@
  * &drm_mode_config_funcs.atomic_check.
  */
 
+#define fence_to_crtc(f) container_of((f)->extern_lock, \
+				      struct drm_crtc, fence_lock)
+
 /**
  * drm_crtc_from_index - find the registered CRTC at an index
  * @dev: DRM device
@@ -154,14 +157,6 @@ static void drm_crtc_crc_fini(struct drm_crtc *crtc)
 #endif
 }
 
-static const struct dma_fence_ops drm_crtc_fence_ops;
-
-static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
-{
-	BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
-	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
-}
-
 static const char *drm_crtc_fence_get_driver_name(struct dma_fence *fence)
 {
 	struct drm_crtc *crtc = fence_to_crtc(fence);

---
base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
change-id: 20260618-linux-drm_crtc_fix2-23a7c354a412

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

