Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0ACC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8EB10F0A0;
	Wed, 23 Sep 2026 14:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nv/hVViy";
	dkim-atps=neutral
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2ECA10F0B5
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:56:35 +0000 (UTC)
Received: by mail-lr2-f8.google.com with SMTP id
 38308e7fff4ca-3a59dae8ce5so6597551fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175394; x=1790780194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=Nv/hVViymZJn0Hm1bC5X3zXVaqZ7AbOs1mtbHH3JQ969JVQfk1C3kPYcklL6JzdeZm
 ToJn+bskf6Lh8O56w831zgSWI2hQQp//vNyVM4olTpF8Vrdxhv9VrsGvHuKINJMsSGKJ
 +zLybHG6Vso0SMgIvoazfJXZSqj9DdM52l0/jFkNTMmN4jHN9UTwIUVvMwJlLD/GyIG/
 WdLK9S9zVVa1gWrltx0MYP1N57VCN/prneBN6deLe55Q0xv4dssUzzRT3Xy4CIJJKNtF
 SYomp5NAvaxY7TuiNTzoYjE64VdSUlhztBLLCr5lWr59JuReiqG8TuQThcbHjnbyqy8Q
 yLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175394; x=1790780194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
 b=0yIoPA7wL1wTeyV83hge1bMg0chLH/gIs+rc0NNFn85rsuyGV766kPB1OiaAHS75LU
 wNoOTuiEAJS6VIfoR/C2872yyvsRkW1/KrqZysNOJQX/t7FQjc8CfBOg71DDR1B+Nrwp
 Pk/2Li/TAGHrE9ZNUv1f9eO3yNcmyeM5XCC355G2W9E2coYYcKpEY/mFLz4471VNXcVs
 ro/R7km653Rt0YYVyaw9VCaPcUZwTqq5unpjGcKjV7M/5VusQoWEgk5Mh8Ru/rrkgaAo
 8tvtu2PnPhqnSfjTAkE0gtYUOd4QWIGN4yKK31WQ4TFeq+NxSb6CCBpnc4APmvU4hl3T
 fn7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoB9zzYsx+hWh5Hh1f2SQ8H+Uwl+TO5B6hvYhKmKg/tHnXYP9l8TcDCVomzDAfb//D2PKz9kzfhuc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFzAMdmVXOSU9OVOTn54tX4lTvMk0GAuG7dDucGS4XOXlnqp6Z
 g+6TlAcA1PLq5ieI8HX5X0lO4CkzNn5b9sluQDpbpxSCzhWvfy35LCbA
X-Gm-Gg: AYBFou3Z6NKzBzObMd6V2XwH+eJiqKf3KuL7hjkcevGKptrIORo1sby7taPY5HjPHj6
 DJoqO3Po/xN38UO98Lf1V/mEFGBkYWmY/Yug+fjdXbeyCs1gmpWuSlYjElGXBL7dCt5Kx8AgcnR
 19TzHGrAFVwbn4rNtjiYt7XlECDAwQyIAIUgyUoQoE05kXcR4/yLEjnrIkeDseWzKQ6sCKWK1Ef
 NNmsUMbHKC3kfCRy54QRAPNHM7DfdTJ0igbjnsm5U0d3iurXqB2kUelHRJ4+tnXdiUN0FkXoWw4
 WpoXntnvl6eZO/qAtoWSrxZSLb9zwgmsqrNsIUKeoxr4LimTDprRyFNyoKqLNASi+OOB3eWHbx7
 dAuEgA6T7VoS9yf4uUhp/gpfWsqt041/BTvjSopDlXvTOKNa+7VWNxwOGjSCg8F84PMMvrFlM2s
 5qRkuVlBsdknRYZwOtzlL3f+5f9eZbYkBta57FI+nmWXgNq61SCISgnDqejDfS+aUcmENH5pX1P
 /SZYZsWDHrsSiJS
X-Received: by 2002:a05:651c:a201:20b0:3a5:bb28:3324 with SMTP id
 38308e7fff4ca-3a63067b2ffmr5677661fa.28.1790175393880; 
 Wed, 23 Sep 2026 07:56:33 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:56:33 -0700 (PDT)
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
Subject: [PATCH 5.10 2/3] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
Date: Wed, 23 Sep 2026 17:56:19 +0300
Message-ID: <20260923145622.76242-2-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
References: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
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

