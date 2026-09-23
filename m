Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D094C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806BE10F0B6;
	Wed, 23 Sep 2026 14:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o/UgLXgn";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08FF10F0B7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:55:07 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a499fd4357so5506951fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175305; x=1790780105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=o/UgLXgn7e+kgWGMrW5HJlbqULXQe8gOLi+ZmR9kmLMmrmJa+8nmT+n2D3eUlAg2eJ
 8EYhSnyra2MeI5v+6yV+3okWuDXntMV/q7evE07+fGVzfhrVOn3Up6KXoBAeZ6qHkNYb
 q/V84PuZAkFAoqfV4LBjBjAVI4Q5cqXMWr1jO/uiLoGXIx2245TE4xp5t1yr3vSR6g3A
 kLmfSV3ieiBdSaMNzWlVpBes3bPQbKZtfJgQe6fuKldWiha7a11UwCGrR+jHSOtPVTCP
 5CEcdGB0pKFXi/fJn5BkjfRZBZDnFcQgwJ4i6xXYo7DMpHrqZx/wBy/9LRbWSw9vavME
 SkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175305; x=1790780105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=p8bW3vwbmgbFlW+XQXQGIhV5FnQQdPsSj9RLsnYK+vJp7Yo7wQ1USA9rDqEG9ZBbsy
 ZSiRHMpw5wsuRI+rHW2xjRXUe+ORhWByTYUmZeA8u8DBPPch5OpanQJyBL+HHb2u2g+g
 75m2fTrhHKcebxKaa8mhLSr34A6LPfJpeGOIXuYZ9ai0kD9p1CveWvZyjqLHm3HyXbnv
 UabK7NE8WaAnGiFt9jusxuX2ICGc8VZQpW0XtCz9l/4FGm1RoF+0Idj4A2fcf20qZ/uo
 aRzE4njS5cKiNhMVN/FiltWs815s2jE3qOwDbHecKfyH+gTIgva+od5ZlhA76hzkbH5D
 GDIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAsEA45uYCriyq3x2dJNdvJmS1k+juKZGXpCE71BVdaeldeZJcpLE4eqEKk61Xho1R3E0KWXWTTZM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/nV7d8SxKr1Y+TQtXjx2mE8BzHyyBZphMvgLbrPgfitshJVo+
 M/WiAtrHchdNrjNCk540bqvXM3TI0I7t10QLWVgXvaSSU2x1geuBg1Zi
X-Gm-Gg: AYBFou1r3PMhZr+1o94zlh8kpohSc3ZSxTar/TfmT4GtxjW1KEtCpzsmvYI28hQkk8l
 +RL8v3kKdpojsbYnsGD3b0NFeEkihWbgjj+pIQ8iNgNY8J61jIf9uMG6VVXAR7RMotwWZyto4Ru
 SuXEYCw4+IbcWvtWL2SoJAyBzWB9eqjTA9ulKWUxDsxaMStSoyxhy6hoOF9o2BFn088KTYhuQSs
 KaM3QDeszP8UaQXgzK0glnYAhWverDAEfsGqceozXCCGmcnJmfdhi/JmVOsiDcipo7n3FIB2pdx
 +mrS/7kWa/DORdykBdKFuZtqGEwRg/N05zqKQ4lGCwpaAB/Pcz6VHzurCqqDXX9l+zyEpBTBvoz
 3gqU5I19HjLM1ONkZTQ4bm/ZGftWaO4jD4iPaMRmQkYDx8JlNwbY1xeosSrmG5NsnBkz/jWZGc6
 yd8I8uk8ZSFsvKQln1v0CIqYr3nuj9MAqCR7ovAldczS5fdt/Y4KBTLKgVgMrMOEooff5Ls64E9
 E5iVq30eHAiHCpF
X-Received: by 2002:a05:651c:a381:20b0:3a6:95a:52b2 with SMTP id
 38308e7fff4ca-3a630659a31mr4896841fa.28.1790175305364; 
 Wed, 23 Sep 2026 07:55:05 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f527d51sm7824951fa.33.2026.09.23.07.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:55:05 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Fang Wang <32840572@qq.com>
Subject: [PATCH 5.15 1/2] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
Date: Wed, 23 Sep 2026 17:54:48 +0300
Message-ID: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit c4ac100e9ae252b09986766ad23b1f83ca3a369d upstream.

Replace kvmalloc_array() + copy_from_user() with vmemdup_array_user() on
the fast path.

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fang Wang <32840572@qq.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Stable-dep-of: c833d6c7199c ("drm/amdgpu: Limit BO list entry count to prevent resource exhaustion")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 9fb8012007e2..22d7b7c504db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -224,43 +224,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
 	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
+	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
+	const uint32_t bo_info_size = in->bo_info_size;
+	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
-
-	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 
 	/* copy the handle array from userspace to a kernel buffer */
-	r = -EFAULT;
-	if (likely(info_size == in->bo_info_size)) {
-		unsigned long bytes = in->bo_number *
-			in->bo_info_size;
-
-		if (copy_from_user(info, uptr, bytes))
-			goto error_free;
-
+	if (likely(info_size == bo_info_size)) {
+		info = vmemdup_array_user(uptr, bo_number, info_size);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 	} else {
-		unsigned long bytes = min(in->bo_info_size, info_size);
+		const uint32_t bytes = min(bo_info_size, info_size);
 		unsigned i;
 
-		memset(info, 0, in->bo_number * info_size);
-		for (i = 0; i < in->bo_number; ++i) {
-			if (copy_from_user(&info[i], uptr, bytes))
-				goto error_free;
+		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
 
-			uptr += in->bo_info_size;
+		memset(info, 0, bo_number * info_size);
+		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
+			if (copy_from_user(&info[i], uptr, bytes)) {
+				kvfree(info);
+				return -EFAULT;
+			}
 		}
 	}
 
 	*info_param = info;
 	return 0;
-
-error_free:
-	kvfree(info);
-	return r;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
-- 
2.53.0

