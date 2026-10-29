Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftzV/oct
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979391125B0;
	Thu, 29 Oct 2026 23:02:44 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3E11125B0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 23:02:38 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-93f2551f57fso1209585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793314958; x=1793919758; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pdQPJwzRJN+nwSRrKcHiePRwRlhix19hahTM/4bzC3U=;
 b=ftzV/octnkST+ONT5ndZMSViW2rxu9F6BngXvrc+3G+BVqEZudIOjYX2iBgsi9CHV7
 vP7dfu75qNzgkEJFeZSu+sBr4wbmPE/fUowGdEAtx8AnYDfNtQpmpyBlbMQ4+mDL3Y9D
 +02frTxTXPIE7vLPrNAqI/yxiHV/grxvfKbWtGoY/DopUF+D9Y8ODAxr/SU5kdR0O0Q3
 oAmSYyYimon/aY/7uEA3ukJiONZO8FI2DEMZdtyD3SzMv4hFLDw4UODfL4E3Dq+cWvPJ
 RcKfqGb7qlQCsV5Svf9tuqlrO3RT6xFe5WmwY4N+9kDb3ZKjMyCh0PJq9JkZyZphgPs+
 28ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793314958; x=1793919758;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pdQPJwzRJN+nwSRrKcHiePRwRlhix19hahTM/4bzC3U=;
 b=1AZb25gWwg0NY5V2Nt1Qk0ODH/T22H2kTncooqtKjAQGNTVPaotmliO4PtkZBAxgWM
 kXlh4qr9gSplj5OJ2lBrLjhnxHZ2HwF7cP4yBFRzyc2VaYEoQhKHh8igBNGAUeaJzxpw
 g7CFb5/2QkLQuvILD5GEUKOF2kyBDm8y0cSCZIFktQBYstfJsJuuwjYpZFSKLUaFA015
 o0PPpRFYwqfARqE/uGn7ww52COr5njgNnnKNAIPbmyI0Te02Dzw2mE7L9zllBr8zWov1
 mQtTfSnKsbRGyFPu6A+Vwzvsk1LiGUJ8EB6d6unzZjkJ+yrtTyOsdafkHiOYMY8f2ZfM
 VK7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRgRoeJFri8mGjb3jNLN8I76f0kAFbW4ng1bTyE7Bh1L4GEkuf2cmdrRn6nmBBQT75ffctxLF8yyI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+qoOo2XHG32kXpwZq5R93z4kMmYVFU5UZatvmycMlp0z/B5KW
 0PYezN8Yj0tyxWA2JAxxt71bahKhOTbGOMv8IQiiNcOJpW/bUfKBOjw9
X-Gm-Gg: AYBFou1xpdnCaM+UpiWWttYuHPu4PMHoAyJ5WDsO4bBflWON10+k0vVZrNYO81c63wv
 +CllZUrfbP50028Xwqh1f9pOfxV+xWX9YCJAlK6FV7hCJHjfnyo78L7wEOTFUDHkd1GZIst9uuT
 gKg2NDj+4HA+UPMa9B5BXd+9U0zGzkIg0uKLAh5T92B2bnnnlIKD+0Bd25Yqt1Ur3D9gJ0JYoJ6
 GZ+/WGJarfFx18Xn6Y9jaf4PfB9FzwgD3X0vDTr1IMhwd76KF9kXHaDx+3KkmwQjZoaEowqhICt
 YY7Lqbgq3zfVqSpEnJe+S8XMr82A+MzcvXY0CFJqr79QcU5TjGBTF+asE2dlvdyjvbsH0Kkxel5
 FDrzeM/ZET/nhBCX9RCrmAtuCiHyB0LVwi6zWeefyDS0hSH91xaySCrpzYMTU7kXb3tfk8So2EW
 5V2pYysEndevMrXXcsLJawGc/bNLy9+tjghp1HVmWDC9axkP60k5rwMFMJQOGupK9H0Z4jNLysv
 tQcn9/r7y95X1l3atapx5lhPBUOQJ2JpDLMUT19gZHlVx1hNYEepqPEBJClD3L1Ry/t+6Fp8uBB
 AJpZ7pw48o6RQdp1o7iUGMbutD/GwGYi+RX7RYTrOFwl/KgTQZt8KxPJd2tltmFw+Q==
X-Received: by 2002:a05:620a:870e:10b0:940:f21a:eb64 with SMTP id
 af79cd13be357-944216f3e4amr127183785a.5.1793314957732; 
 Thu, 29 Oct 2026 16:02:37 -0700 (PDT)
Received: from [192.168.50.231] ([142.255.23.46])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94424133d61sm2791485a.3.2026.10.29.16.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:02:37 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 29 Oct 2026 19:02:30 -0400
Subject: [PATCH v2] drm/msm: Fix GMEM_BASE on a8xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-msm-gmem-base-fix-v2-1-26b338471b46@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi21oKuvIdhUcpYJnGAtIZoC
 He3cgGX7yX//RUyJaYM12qFRAtnnsYC5lBBGPwYCbkvDEYZp5W5YJ8EJQtGIcHOZ8IHv5F0Z5T
 VjSfXQNnOiYreu/e28MD5NaXPfrPon/1XXDRqPNnaWRPOrlbhFsXz8xgmgXbbti/Yy28iugAAA
 A==
X-Change-ID: 20261029-drm-msm-gmem-base-fix-e1b20418ae68
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was missed during initial bringup because GMEM_BASE is not used
anymore for textures on a8xx. However other things such as mesh shading
still use the GMEM aperture. Fix it to match the value programmed into
the registers.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
Changes in v2:
- Fix enum name
- Link to v1: https://lore.kernel.org/r/20261029-drm-msm-gmem-base-fix-v1-1-347642c5670c@gmail.com
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..5b05386ecffe 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -382,7 +382,9 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->info->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
-		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
+		if (adreno_gpu->info->family >= ADRENO_8XX_GEN1)
+			*value = SZ_64M;
+		else if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
 			*value = 0;
 		else
 			*value = 0x100000;

---
base-commit: 9c31496a57579d0a46e1eabb8f53ec735b72d180
change-id: 20261029-drm-msm-gmem-base-fix-e1b20418ae68

Best regards,
-- 
Connor Abbott <cwabbott0@gmail.com>

