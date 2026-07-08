Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48593C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED9210E606;
	Wed,  8 Jul 2026 15:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CUKN1xgc";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C775010E521
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:22:10 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15bf399d3bso97893166b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783524129; x=1784128929; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LyC+FmbJe8AFV/pEnbxlDl/WDcANmupwyXjJcuF3JBk=;
 b=CUKN1xgcjxrEbi7x2u0zrJUZfk+iudaaAM2Zupy2a72nLF6kHzShvtQo1zzJQhxAME
 od0SIjNxEguUExaz4eoJ3iPF7G2mjWmnJf72BoityjR2dQIrXBitSjyTl6/Z07MT9NC0
 WUfMnWXLVtZI2wE5y8NkZviOEsFMwqb/6WB2jzYFDSTbyfGSrkYuGJ511IJGTqGo4K6n
 IaBdpT0LXhJEHk2UEeWoJpO124VIdQ7b6HEX0j0AmFmiOYddHU0B3WHTVZiaFxKBDM8z
 qNpWusqPTnVEwFxBpkbO+Gv+8eJ5tQllkFthNFf21g6OcEmecQkqbIXa7spdEM24CkvF
 xVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524129; x=1784128929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LyC+FmbJe8AFV/pEnbxlDl/WDcANmupwyXjJcuF3JBk=;
 b=L6fHgliB1fjqwfXGCyygdIwFi56OffslTUiGo3E/Nw31adtiS1cYZ/Nov9uJwqXIIj
 KLzf27fY6efDdb9blTpRbyzgzmGjzOY9pQSy1NRzD01O/cnMRwjXWNoWae22J4UM/1fZ
 9uhkDz7+xeAYIDasdfZrJoCG7FR9aVl0pQexMyX/b6beDm7c5mUcH4gcE7TQgSAWXjNS
 6LbIbLjGY4rzVgSeFE7P0zXAYFQjtTxkPqneoIlFfE2MPVEh+dmn1t5W0bW3oxgXpcB5
 ODeqGIS4uySpofYqOb7jHjbDuydQlxFCCWCeVOw9Ch0MkXvrdiAK/SSAnly0FDCObqAt
 FVXQ==
X-Gm-Message-State: AOJu0YxqzqoW/JDUnoHlEmJppWct5T7i5WrviI6Lz8qGO/SOoxJSYsJh
 9LC02L4YpfB1Vgy7yoZse1SNG8xDVB2gG4wpqEddzLC/niqiWUm5yTtMHLvOHT0UKYE=
X-Gm-Gg: AfdE7ck89VrV6iZ0vtlXSGJ1KIIcYAxXPuFM/sEAZ+129F2kTdDpuEqH1loVjF7RrLO
 8qVQWj44d5jDjzJLagTvvs2GsdDU2x8aqizcoJB+gSEuCT+qp4ed6kHWW2TjXgCCvaFeonh8/sD
 hrZhygeHGH90dmvVRGuVuSzgSM9WZwRk7QFyEFwZ1U9mP1QuFkX3TvVKEvv+P2gpBEG/mHNvaic
 ZPaidlBn/MTr4rdjqkJBlFSz8rWmCybAn7Hp3TujxQ8m8TtYYq0EAx6euJ40w9bo0R2KHrGK6UZ
 U5sSXng3q1V6LYhHMXMdXQyc3KZXzAINaiTYBj3TU3NysT5Vx0XUaPNd9gCMElfifKPdhdwu0qq
 IU+ep98bqy+9jp9kk2T6dC8CUuv20QZGFsJJHeehODlU0Dfg5AHt3Wi9QFpPkzQl/vC9K49egV9
 7+AkDcWd16GDKGp0zkexTftgIED3q6KmdR1+E5mwE8O8qGsE5cInRqFu+hlAq1sm+EGYO5rIqDb
 dj7j7o=
X-Received: by 2002:a17:906:f58f:b0:c12:a992:a6d6 with SMTP id
 a640c23a62f3a-c15ce000110mr142620966b.23.1783524129106; 
 Wed, 08 Jul 2026 08:22:09 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (181.179.204.35.bc.googleusercontent.com. [35.204.179.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15beb53b86sm213932966b.25.2026.07.08.08.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:22:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 08 Jul 2026 16:22:06 +0100
Subject: [PATCH v2 2/2] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-linux-drm_crtc_fix2-v2-2-cf72be75d75a@linaro.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
In-Reply-To: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
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
* Using BUG() and friends to take down the system is an unacceptable
  way to handle a failure as evidenced by many threads on LKML and also
  in the kernel coding style. Here, the check was presumably added for
  detecting when something passes an invalid pointer, but that does not
  happen - and if it could, gracefully handling that situation would be
  more appropriate.

Note that the adjacent drm_crtc_fence_get_timeline_name() has the same
problem and is fixed by this patch as well.

Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
- don't turn fence_to_crtc() into macro
- update commit message to include reference to unacceptable use of BUG
---
 drivers/gpu/drm/drm_crtc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index d55f1377ec36..36ae50ddf525 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -154,11 +154,8 @@ static void drm_crtc_crc_fini(struct drm_crtc *crtc)
 #endif
 }
 
-static const struct dma_fence_ops drm_crtc_fence_ops;
-
 static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
 {
-	BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
 	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
 }
 

-- 
2.55.0.795.g602f6c329a-goog

