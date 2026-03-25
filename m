Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674110A62CD
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4722010E9B0;
	Thu, 26 Mar 2026 13:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkIlIWae";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C503C10E855
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:46:42 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2b0603ee486so16377745ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774439202; x=1775044002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BcgLnCA0f7wz6dPCqxCZz9kXuIVTeQJ0aRrxBcbCgTA=;
 b=mkIlIWaeoyOYuuabgV6UU5ezAiOfUg3bafwvkRgdp2CFkUMjPjOoR0dEZnwy/QhpB0
 ml4fFXpyKnJ/mZ/1SdS8uB1Mp0Dyw6dsjW8pTDpkMA2AgnscAl0mEQxZTVezUnmVDEJb
 C+KUNAqHelWYW9gLEw69md2F5A12pRfvCQoJLvR9yXkPfWghjvTT1zQBA/x8afXYCS0x
 6KVBAE70orI7wIe/ETzXaGF0QmhpYvnKOexL8XTrwZlht9Mt/NKmgB+BVfB2lGW2N/GO
 vOen7FnPeMsvBzaYwjch6otbl4L7fgrl/gOREL9S45dr1z91zWFiV2LM23dtaricfW2O
 aRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774439202; x=1775044002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcgLnCA0f7wz6dPCqxCZz9kXuIVTeQJ0aRrxBcbCgTA=;
 b=O8yzejOU5knE2JuuRFCKJQG6WDPXPJ6zjHHnee/1GpOEalD3Oo4e0DVefq/rGgNJo7
 hx77SLQq2jTX/VqAn3iN2KcakaqRPTU9NYYWVWKbIzm3Xqe8nncdSyj3mbCR5UoeuOKS
 7BywSKYqNJVOcOvQi009FBAbK66XnxQv1jTn4cnmXCeXd9O3eOOb22qr9wC6Wgv5Q25i
 j7Li8/pTM9nD/vkgEJ8WxwMu+rkQZ5yE7UE6lLqCTsqVNOXR/u7aMP3BlwJcEFOTbY8n
 jmxZKNz2WY5LhYuaX2qk12WKyUdF3WHKzPNTozbBt+sGeLe5Tc7FjIbBQWxtVySlXbYu
 L8GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX03z44F57jbnA+m3umOKie45rDNn7torzRDE/LOJX/9v+xaJktGXr+gN9YZ2r215aO2y5JXJ0Y/S8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2++BetIQl9/q/H94l6Ooy+Z+yVCmj6zYcH4vCropjAwIcLP/w
 Aj4KqQgUtEAM6HJDXTAH2C1Kp9WLiajacDtIi68wLG4NPjVg5qTNY/gV
X-Gm-Gg: ATEYQzyhx+xq/OTNLrJ9/G31KCO5RbqBpeWcMky0SCkcfJQwztJb1lM4l71ISkPbo+X
 2siIiI9usBWmBIcdocCYqqCy3oGSRM8quRTEgZ797u/5R+cQ0MuVCTrLrvZD+6HS1Nbu/WEFQFo
 h42RAHryQDASQYxtt1k5aT9Fq4i0ENvUJwUDb2aNyCzqmSweZU4x9tROtXGCGXdaHrmyQh/k6YM
 XbLfRpMxqjZLBXQkumIejLLB6QXrgwcjvQevFDLtdqyXsakP4cYc8NnHXLH5NxuKfFuqPrP2GRz
 2Xi4OvSmfQlI0PG9vg2xNlLDtbZh4Nb6WS15iv7xHBK0Jm13xs/5kxKJGBvUB0qqPlYt+McWiDG
 0y+3liFkLFmYLCOy5/Q2YBf7pCLfyRfp2uyEc2fMzcAc+fCJU2UvVTAH9pJzYekUluhupGjA6K5
 0lRyRUNkwpCWu4j6fgSVzSbZQ=
X-Received: by 2002:a17:903:908:b0:2b0:669d:3a68 with SMTP id
 d9443c01a7336-2b0b0a15b81mr36980765ad.19.1774439202138; 
 Wed, 25 Mar 2026 04:46:42 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:661a:64b7:4163:997b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c36fsm234579835ad.61.2026.03.25.04.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 04:46:40 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, stable@vger.kernel.org,
 Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH] drm/msm/gem: fix error handling in
 msm_ioctl_gem_info_get_metadata()
Date: Wed, 25 Mar 2026 20:46:34 +0900
Message-ID: <20260325114635.383241-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Mar 2026 13:17:48 +0000
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

msm_ioctl_gem_info_get_metadata() always returns 0 regardless of
errors. When copy_to_user() fails or the user buffer is too small,
the error code stored in ret is ignored because the function
unconditionally returns 0. This causes userspace to believe the
ioctl succeeded when it did not.

Additionally, kmemdup() can return NULL on allocation failure, but
the return value is not checked. This leads to a NULL pointer
dereference in the subsequent copy_to_user() call.

Add the missing NULL check for kmemdup() and return ret instead of 0.

Note that the SET counterpart (msm_ioctl_gem_info_set_metadata)
correctly returns ret.

Fixes: 9902cb999e4e ("drm/msm/gem: Add metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e5ab1e28851d..195f40e331e5 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -536,6 +536,11 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 	len = msm_obj->metadata_size;
 	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
 
+	if (!buf) {
+		msm_gem_unlock(obj);
+		return -ENOMEM;
+	}
+
 	msm_gem_unlock(obj);
 
 	if (*metadata_size < len) {
@@ -548,7 +553,7 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
-- 
2.50.1

