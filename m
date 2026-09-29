Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD953C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A7210EF07;
	Tue, 29 Sep 2026 14:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJwHmy+K";
	dkim-atps=neutral
Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A18F10EF07
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:21:16 +0000 (UTC)
Received: by mail-lr2-f1.google.com with SMTP id
 38308e7fff4ca-3a64f8b0e43so27623831fa.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790691675; x=1791296475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lTXKKkjD2DPm867cDZvzjVmhgplcLwudkdm5kHSl/UM=;
 b=bJwHmy+K+UAcqGcajCExZyfJpZLrXdHSo1zeUCktPEoN7lEXi0nWZoKn0PBTxpJm9l
 8PYxduqvidzaallPVNbhy0p2llaK2gNw+AaW8VwSX32P+399zxMemzvP6BypI6M9FXU6
 7tZYerAZvSyg+aIjJ9WU3H9qpf/gxdaqP2V+7c4xKRu9gvffnh6euIvWtxQXh6IkUphQ
 GoF2sSlKfUhx11osBI0dwfESRcfuy7qTtE+SNdsYusZ1pCiVkIf5hjktkPiGH+zqoNj8
 a42mKfeuwa9JbpMQF4AfiDQopzIk/2Wj1mkUBHMIXWGiKwDR74MHxRwO+qXNYubmg4et
 hz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691675; x=1791296475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lTXKKkjD2DPm867cDZvzjVmhgplcLwudkdm5kHSl/UM=;
 b=LiYDoMX5Tm7PkohNcMViWG3E5MdRTgFlKhciXxhFQhttwyZawFnyQQlwAYZetkE/j6
 OBGP2j5yUocdjzZQ/+SzKyJNnQFiChEUwtk6fFBGAl/dyN3YqLPy56o4oplnJhKtgUC6
 XY4Wreww4B21EDMRoJtb2IEJO27Cb7K2UAIatYMMlZcJmUJ28nQ8y8kSm/P1UzE+yi5F
 3nHLfa1DIc9oQf1fddpV049EZCVLxU1o/kUC+Qlr+lSyBr448OqLYeVja4Ki1vIpcIyP
 05K5fxCTAcW597Htz0xI+CVHAkqzxUvrqGn/ieivYKeN8qUDTuP44y4aq90USrjjKwDx
 b6oA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqcKcRIrVLlLgRMvZdz8vaCcGm1gUpln11T22z2sCq8phCz/KC5DgXJsJ6sGPk4T25z7LqJIRDUuU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxslSyVxHsWpsgmt6SRiFbxFRPPlocjA14hZrjTLMDgdujuDcZ
 TsUlDDPTZUfOERbT4wDL9JS7FFkGqo1cxqrb5LnZgf4ZtTMlxy1XyMjX
X-Gm-Gg: AYBFou18wCzfoFQFihveUKrwWVGwAFXSYYxvnVROP82xzYMQKGDeXeZXJxhznNwM2wN
 PIlpE1msdYDVYnjbjEDPBVfDJ6xUAhgpPoUsLTTSJK6kiAU7ME9kSmb4YMzGNWIVt02+RVKk5Rf
 cAjXgRYDBS0RiXWkYtk5APfv/E6qQRYcE+Lh/zyXyRgwPEp7Ra9035G+G6T2ewPrMMMRbjszrf2
 7XD/baU2BkixryUP/Itmzx56K5r9YWZlc9yc6KEq+h+AvBWV61vM61LhjxOzQxGQexpE1lx0AEi
 psbQI0qWEhGXa1yGL5iXWqOFQ0DFgTer6I0OBTssfrGHbVedWSNiHCqfzJau5feaKLZvuAMzuHM
 nwxTAhH+RZfqrBZ9BYiwEl/yqS9wXXcY80SRvD/lsu246l+3TattK0Kp6RuNkBlAWZe7StD5T+r
 Lj4l4N5CQ7Sgvbl3w2wIryAKFckDUy34QkANduWSODaOhhoq/gyWij+mC+sbD5SiQ4Bb53OKJWj
 yxfN4bCH7fNPYnhal57IRZq0/o=
X-Received: by 2002:a2e:be25:0:b0:3a7:5f55:5e00 with SMTP id
 38308e7fff4ca-3a75f556084mr13204741fa.9.1790691674420; 
 Tue, 29 Sep 2026 07:21:14 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a76a503af4sm4538631fa.33.2026.09.29.07.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:21:13 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH v2 1/2] drm/msm/a6xx: fix use-after-free of OPP in
 a6xx_pm_resume
Date: Tue, 29 Sep 2026 17:20:58 +0300
Message-ID: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
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

The OPP reference obtained via dev_pm_opp_find_freq_ceil() is dropped
with dev_pm_opp_put() before being passed to dev_pm_opp_set_opp(). If
the reference count reaches zero, the OPP object may be freed, leading
to a use-after-free when dev_pm_opp_set_opp() dereferences it.

Fix the order of calls: first use the OPP to set the required
performance state, then release the reference.

Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
v2: The dev_pm_opp_find_freq_ceil() function returns an OPP object with an
incremented reference count. Dropping this reference via dev_pm_opp_put()
could cause the object to be freed if it is concurrently removed from the
OPP table. Fix this as Sashiko AI <sashiko-bot@kernel.org> suggested.

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f9de9329dee3..c827986951cc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2177,10 +2177,10 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 		ret = PTR_ERR(opp);
 		goto err_set_opp;
 	}
-	dev_pm_opp_put(opp);
 
 	/* Set the core clock and bus bw, having VDD scaling in mind */
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
+	dev_pm_opp_put(opp);
 
 	pm_runtime_resume_and_get(gmu->dev);
 	pm_runtime_resume_and_get(gmu->gxpd);
-- 
2.53.0

