Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431B8CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7CA10E482;
	Sat, 16 May 2026 11:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZ9N3ObU";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E413510E19D
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:49 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so7411235e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929608; x=1779534408; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iLr2U6KkG2Uu+VOL8E6/tXdIBWCkFd/7X9q/HfFlgP8=;
 b=gZ9N3ObUdPP4vJjbgNG8sBCvMAZMjTsce06tQeh027ebHkHBrPl7Jjm2gH5607glm5
 EDbvn5UrCZ/z8n1EL0ujKMZM6h2COhCFdiN8WYns7F4i5hskUWeWed/jQBXCh3o504LE
 wDNsiXpisad47LFOXSHw5yPTBMPRBYf5JZbxBnA/iD+0q2SPTPLZab0OUvVMJ+D1CEkE
 liBEti1VeYVmX/+P54v5iqVdJuWRT6ScvyhlNAe8purOl00OkoqoKoXYMokgvt4Dl2wf
 SaXwf/QUJhDeGyOBj2OeJwMF+YbzOLAZ42lnnvLBb/YP+sqR6Ktu3vPZ+mTQaJ5/4/AN
 MI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929608; x=1779534408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iLr2U6KkG2Uu+VOL8E6/tXdIBWCkFd/7X9q/HfFlgP8=;
 b=kgqmWmo+UX30PeoVNflXPHukKHg0Mmmd1utNe0ZSwtr9rrkg9GznysgfzAvFs+bQdj
 4ooc02CH927/slNbkBn3IHiwN7JKqUqEJgnNd/RDBUOXReSOF9V7ihQ0NLZkAQpcUH5c
 9bfCh04QSu3pnFRBnhFAvidGW8QyuoYxvjgfePQv0jxxmsft8wdGYkwduSBKCU4+XvN/
 +HnmYUNldHLTN3WRN03Q9TQwISUVW7TBjszFC/G9hf46qz+w3s0UuxPSaHVptU9GNjT+
 Ag2/u/r9MZGzdrfBldOfYfUefYpsMT4+bMdfyMdRLL3p45yoGmZhXT6C374uAYnM5TmN
 grrg==
X-Gm-Message-State: AOJu0YxxUwrfICDwbPGWqFf7ASf/n/9K+a7d4xqxV52X1Ijb8/P8NFs1
 CC/qn3bOGlBC0n0h5z3cH8G0V4tylY5uLcFtEsRLFOO2gH3Sdf1nmh2z
X-Gm-Gg: Acq92OFkkrcOd2pk1S64uXVBjby857MEf7j2uSDXJ83xtjeX1cGX+onZPvzVY02yz+b
 aRmoQJuOIE6XO2Ptz0nj8uFjC8SXqzYBL2HEOBqQ6XUWEmU2vvwt1kyjB+ttAKsg5LYuWodY63R
 Ae4XQx+KvZpf5SHR4ICAKRkecblEePDS1S0xEhi/xVOZOJ58FG41duGENdMOc4OH5sFFgcMx94k
 E56PPS1pPUO0T2YiEoXPVQVhLl2w9CtBsSzD4/KOM0E4G+/yaiXVtwuhEjzU4LOUT37tpbYXkzW
 1yS/5Osm0ojwa4+Cz+QxCFCX7SLL2gP68JRzOdBBVxlLmbQLrpjUb+jBB9KZs0K7obgSY1b+3cw
 UUQNjl2+SagHxAGz6YLqfmeU9Itw0w6cHsuyZSq053JHIUdcJQ/FWyuQQl4yb9kXO3lVwVyw5IX
 qufkOv4YejXqEQ4IEf3BAh8SQzgBjfHQx0Ao2iKrz+z8mHb0U3Z4Iv6zod5QRXC42Ihl1FTm8bv
 Egz73s=
X-Received: by 2002:a05:600c:13ca:b0:48f:eb8b:9988 with SMTP id
 5b1f17b1804b1-48feb8b9a84mr53458715e9.23.1778929608240; 
 Sat, 16 May 2026 04:06:48 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:47 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:06 +0200
Subject: [PATCH 03/12] drm/syncobj: make drm_syncobj_array_wait_timeout public
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-3-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=2220;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=NwwauNPJiO1PfXNWR0Tt78KBCxqLRi4CSj0dLIMDu4c=;
 b=L70W+WfFJyxFbr6yV3GcY0+dLZ8/RrrjQI0perIlwa2ryxcj58Yc3uwASbkpuihDpL+gB9Dvu
 iClDpDWu5qLAvShl4cuWM8lV4UGkRD1RQm8k8xpOhVcZK9uExSKR7MT
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

For use by the upcoming misc/syncobj module.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 15 ++++++++-------
 include/drm/drm_syncobj.h     |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8df438fe0807..648afd1f4fdd 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1069,13 +1069,13 @@ static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
 	list_del_init(&wait->node);
 }
 
-static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
-						  void __user *user_points,
-						  uint32_t count,
-						  uint32_t flags,
-						  signed long timeout,
-						  uint32_t *idx,
-						  ktime_t *deadline)
+signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
+					   void __user *user_points,
+					   uint32_t count,
+					   uint32_t flags,
+					   signed long timeout,
+					   uint32_t *idx,
+					   ktime_t *deadline)
 {
 	struct syncobj_wait_entry *entries;
 	struct dma_fence *fence;
@@ -1229,6 +1229,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 
 	return timeout;
 }
+EXPORT_SYMBOL(drm_syncobj_array_wait_timeout);
 
 /**
  * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 580a967ae364..7677fd995be0 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -129,6 +129,11 @@ int drm_syncobj_fence_lookup(struct drm_syncobj *syncobj, u64 point,
 int drm_syncobj_find_fence(struct drm_file *file_private,
 			   u32 handle, u64 point, u64 flags,
 			   struct dma_fence **fence);
+signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
+					   void __user *user_points,
+					   uint32_t count, uint32_t flags,
+					   signed long timeout, uint32_t *idx,
+					   ktime_t *deadline);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

