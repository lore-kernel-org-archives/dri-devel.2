Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7702C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFC310E71E;
	Tue, 21 Jul 2026 08:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOfzafQl";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA21C10E71E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:21:33 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15f360851aso1174773766b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784622092; x=1785226892; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yOwKc54gLFklrg6TasEGy36BkhC9F73PBQa2PoKh7F4=;
 b=QOfzafQlv/2rxYDJXjB3AFN9z711oGymDbKNYvpCZKzGXKBOYeydcsCuB5tSW/A71N
 i1Ig33Mn2qB95Pc1jDxLULmGU517Qwn5Fqx0nwH/vG7WCkxmNGNxNw6enePyFsE1bZ8T
 5w/sMoZ/xZnMx2gDNC+cHilDLjFk4+Quf+GBG/Y2CFnavIjLI5n3/zys9if2c4VxbVB5
 VOx4OTakda60kflcE7aaEyQwWV4rc+Dht02DCJSri8J5LPnyg/QuExMsk2flMXhe/i5o
 hijNS6W7oESZk4Jf9mpdR9/mpzbL/Ci/dGl6CMHLis7i0mi27AFPmpQiU4+p0UpXfClL
 s6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622092; x=1785226892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOwKc54gLFklrg6TasEGy36BkhC9F73PBQa2PoKh7F4=;
 b=AnzRa37DmwYGQzt95d818vv0+sWYedohmRUe5kNhLW+OC8i1mGU3iEojErnVkr21oL
 TIe4LTSHCoUggiwpKjzYZzPisyNBASA0dkw8NQOKirkl6MpBWgmgb3eq0QUX6VK+trnH
 BI/aGSDAEOa3/bMebkx5mO4zxj7TLgOUgxsCNFFf5D/XHBTs3SPtp/zMT7KqGLU2xR21
 V30K25h08kC96/suyZeK0xFZUSv5UwBkw4XiGYsDjzZHgGhgZmTYgMDyYyhBu9ogKkJ0
 PbWBRbKyAa02GuSlhDvjCzySICLNZb5JQGmBFwu24UZ4eHk4MXWav/AogkHM3BacCKF4
 GbeA==
X-Gm-Message-State: AOJu0YzMahvL8f5cnVYuLCpu1PNPOejcUXZRktccByGCsQhvwuPvRiRa
 4+pwzH+b7WAe7C/YRAIxuII4AQOXRaNB1WO80hpV7ieB1PZZ05mU55Corvq4Jwr17vs=
X-Gm-Gg: AfdE7cm5veyw7cUXWxqbwMgvh7RvyaTY2pjdgfmPwBQzGkkztET/VCTX39edYz0ibIl
 lt9bkeAPQ2hhNC7MdxJs99G+J80VaHFAkBZfH46uzrSw1kRSOyqgHBVgeVkoEq85+85Bgtgxu82
 bLu2IToJJXSf0WSI8nG+4bysAm1Xpvw2HvzAI1Y3BH17Zahqgci35u5WrPeI+Jh4S7l6f4oK6xQ
 IQQhl0YyxrM/0Qjke4w3ACgvQNUv11xZ8CwyudwpQtU27tZPNVilxHOAch8vA7k6n1MNocSpPWb
 M1PW0etN70i1xfMwpecmmA/4EAIbYwJrfIyzVdGECHHVec5/usmPX8LJy2PCLZzW6aI9bqbzct+
 NwqOJRftC1uSipTF4KQETnCqRM1HgNBAA8n3IcSF0zKBui1U9j03H/NEWdcbisl5+gC99mYc3vu
 b30ojbcquu/PMOb2aGaHPidBkGt6EXpMXldlim4v7bcd5iGX5pq+F2aJJ5TX3VXVBoJw==
X-Received: by 2002:a17:907:c5c5:b0:c12:f81:661f with SMTP id
 a640c23a62f3a-c16b4833e24mr638733366b.51.1784622092166; 
 Tue, 21 Jul 2026 01:21:32 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1724f50b72sm564725066b.48.2026.07.21.01.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:21:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 21 Jul 2026 09:21:27 +0100
Subject: [PATCH v3 2/2] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-linux-drm_crtc_fix2-v3-2-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Sean Paul <seanpaul@chromium.org>, 
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
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

In other words, a fence's ops pointer can now change to NULL on signal,
which wasn't the case before the culprit commit and hence the BUG_ON()
triggers.

Simply drop the BUG_ON() as it's usage of fence ops is invalid now, and
because using BUG_ON() and friends to take down the system is an
unacceptable way to handle a failure.

Note that the adjacent drm_crtc_fence_get_timeline_name() has the same
problem and is fixed by this patch as well.

Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Cc: stable@vger.kernel.org
Reviewed-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
- Philipp:
  - shorten commit message
  - explicitly Cc: stable
  - collect tag

v2:
- don't turn fence_to_crtc() into macro
- update commit message to include reference to unacceptable use of BUG
---
 drivers/gpu/drm/drm_crtc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index e8e80c936852..5295ec122e0d 100644
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
2.55.0.229.g6434b31f56-goog

