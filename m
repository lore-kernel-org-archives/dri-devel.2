Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EF606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWUZ69uv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB4A10E660;
	Thu, 29 Oct 2026 22:57:53 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805E110E00F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:57:47 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-5337fa1ac6aso108361cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793314666; x=1793919466; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h5Hpaazv/PJJXvnma3M/buleF7hZLhW/TVfnybhiNnk=;
 b=mWUZ69uvZUE1X115UQo27IMiNjSZzV7Yx6gh4dRexpE/JHr/pLWy2aIXaVk11iXmhs
 7W25nGNtVI0djsv1uLGZObwtEPMQMrXO+b87yxbUffuJz1i6fSx2+Tdj6/MeVbLwCVrG
 nrfKnEIZumAmG7Px+C3E+2S6DtEJY+WzBbIDMb9GByDbCvu+vBU3DVlCFZulAJzRVArT
 aVmjPZnzpupaTgaz6n+KgKxZDDKYPJK8We4/wLWNMc7v75X1uvwtlHthCJWMhzFn1Upu
 /KA/hWFT23J3vy4snbOzrKPOIMOUJcnyorLIFFFYs0CDdsMkZhsdzBKsq3UdBlwD32OF
 aF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793314666; x=1793919466;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h5Hpaazv/PJJXvnma3M/buleF7hZLhW/TVfnybhiNnk=;
 b=fFlFYQ8BARPvB2YVPQQXFYljL2j6h5n7S/3L3iEKyBAfpQmmPJeVbXdZdkWA7/IcUW
 GPmgQ//9Pk+DoKY4Isejyq87FQuIT5/XCtdb6Hqx3L/SeWwkBv6WMdyOnCzhHVsVQ46X
 6zE0hhQO/Bokg9CT8jOgFrO531nnnGEmEMG8CNAvvhCebVlLqARJGGbdguUn4E89yV9v
 h90OkZxPC194LVQ0lyzAwORM/uIveR4ktEW3Rqs8tEWE/4ZLbJFLHAxYR/kSOGBY3YWA
 Az4YlBXKbNpxHtHuEoa0IQGFvAQhxIxm/ZxBSwcnga78JoBcdVGEB2J3oHs9sOpY2eRy
 RcVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygD7UzRh19/O+b512C4up4yClsmvAnDunSMh1IJdGXU11ghDXWS9L/iHtaIbBu5+HxfEC5veIyxk8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKueNoCM+TsuDyDkXixxX37ZG31K87AdkGETR+zIXTJ6ZgDEQDF
 TnA9w0m7NpiqCSffC0SQUy7wQjd8fvazWwOKA49MX6cCzrg776E2I12xsp2KOmF2
X-Gm-Gg: AYBFou3i/VhGHxOWrXZUkUyO6JVJlnY61PO2hpGsjCzgGqEReB1/Vd3X3fgD+1DL0Fw
 6YWj14eVHro3lr5+rawZYUVGu9IH4SWohqDbTyILtILSoetJmLZcbl5TTEcEnxzlKDFpHtiZfc1
 3vJte95uotvwWq9EMtpwVVb8DM9+6jORR1xRXpz7txxMiExfZ5nEqviMR83sxqkADPDlXDUswk9
 o/KiHAu+uSut6u0cxfMQZzJGZ98FCQ2kNv3FNYPsXK3Lva8gtfQIpzzk5vstaJqYUQD5bgesXWt
 ia2CMZf3coxhMsbjWXROd4KE0YoDXLJflePG6Ez5D07z5Szv2/xbfT22uxNgZrxMl4Tr74rYe4H
 BXDy/V+YU3Uo6CwItwVUxTimahxWuO6fklqQj4rzzO0OyKrTbP8aOkmt/iOZGClIHTuLPyKlxwH
 1C/UF2qJQd6j+zm+zun6X9zNO/4PqvaPxCeyY1n6F2wltcSeDbGNQH8sWV0lYdrlGK9846BnSXu
 IlXbFkyV2805h4j/srjL1FWiLi/kDmsUhttix+lqI+CpUZ8CK2cM/9NCgdYsUWBU7Xf2MiJYsac
 Ah6gjT9PfTUlmVUHMZ2LK/TpvThgQtadLfR/w0bjOV1PJb2cMXL1uf7ZVZaZV9xDdg==
X-Received: by 2002:ad4:5cc6:0:b0:91c:7b53:8007 with SMTP id
 6a1803df08f44-91ca4b3a873mr10249726d6.4.1793314666398; 
 Thu, 29 Oct 2026 15:57:46 -0700 (PDT)
Received: from [192.168.50.231] ([142.255.23.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca68c1578sm928146d6.40.2026.10.29.15.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:57:46 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 29 Oct 2026 18:57:37 -0400
Subject: [PATCH] drm/msm: Fix GMEM_BASE on a8xx
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-msm-gmem-base-fix-v1-1-347642c5670c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAQBBFf0XzbGp3k/Ar8rC4mIdBOyUl/27ze
 E6d85AhCYy64qGES0yOPYMvC5q2uK9gmTNTcKH2LrQ8J2U15VWhPEYDL3Iz/Bhc5ZuIuqHcngl
 Z/99+eN8PXlurUmcAAAA=
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was missed during initial bringup because GMEM_BASE is not used
anymore for textures on a8xx. However other things such as mesh shading
still use the GMEM aperture. Fix it to match the value programmed into
the registers.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..aba2f0d6934e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -382,7 +382,9 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->info->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
-		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
+		if (adreno_gpu->info->family >= ADRENO_8XX)
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

