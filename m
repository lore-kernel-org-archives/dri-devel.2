Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFF4CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018AB10EAD7;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4Nih6QC";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AED10E4B7
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 17:47:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso579755e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963240; x=1791568040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekbcB0Q6K0Df7evy98c+D1I4IxidAbimqgNUlWNjtzw=;
 b=K4Nih6QC/dlp4YeEXU4UMF8mv7mufDMkXYMVmMe+bhBudRRjhKqyzvvysMURVJK0/Z
 fEN2F2y3Pzkbbq3DDUr5Z6kHYEiVSd0XOHiYlUY0dh/uCfLONnLFFTQMr73D+331jfac
 2As251Q2/IB59oiuRiPcA6uibSMyreWhGCDG6jWrCDjs1IHMNUP8Zc7sNcAvXAoAOb4o
 u+tQESNbxaFtsvnt2zPflZnsq1doZNDQlyqoVyaSMtpzgnZFKTDW4iXgIx2OMs+bFoeX
 1q2nV9yhCXlJRytloHqZJIIJpljLKvJHUtv2oKB7msDcN6Ii2pvoN+dMD4x6q1y8Xxf4
 E6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963240; x=1791568040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekbcB0Q6K0Df7evy98c+D1I4IxidAbimqgNUlWNjtzw=;
 b=DnVf8kTaDEK4Ctn1V5LiF68/FNVrNhypIr24q2LM0CDdLp1e0NPEE9Qxv4zqWe03zN
 AZ69yGQnYDCK3HKaF/k8OSN4cGNp/dwYn90EbeRUla71ZoY3zQTsvxY0RJMTG4ujC7SI
 8f3Hz2qE64RMv3HpoQM6X5//MullMrvbMDDI3ESddy1WJEWZcdjmzR29nSPHiu0VbLnY
 j0bT+ukLxC9/WyFRasBzzyE1nr6QmXYo9vAxmq8ItXMres/DRv2cqERCNLed/eWCRpa0
 h/ooiRviY5miPkQwcDeHlC3m21zofO75ZWGGWmW+ClNbicOApVBRPwJDea58uvmyscUl
 E5lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP+rF5wXuzT/i6AOjyK20vxWx/mtX3MvULw6N/5DF4Z0FUPY72e/2I5XXnpXX0GD43o57fAV60fv8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJwiN+lI2efmKTbllV3758ncqbRjXSmwCd8squ10NGydyLISsK
 8s7B/1hldxC4DGwwqyllfGdcW0SGC6EL7u6KY8Ds1rNAotocjowaOSUi
X-Gm-Gg: AYBFou0buk8T3W+2hiHpoFYw8mFJYoojnDucfQosmwbruJbi674g6l7Zrw4v2HAQy3H
 DR/LjltYp+BDBr0iZmUycLs8hP/asLCEUL9Ooh4JFEzCDeRV6BiqCRKei4f7uL/KH8JHnMtCpYL
 Z+V1bgR0l+TeOTVJdxrITnA4/UDhRfFfTsbu3REfkNniIxXfPrPicAZ7oUe4KqTM+JG4PUNrBQV
 2NBJaORVQ29OC5LaXZ/qs5UHpv8ozIWOfL4Xam0JVkEbbZPhASVGmwQHvzJC/tHmAZ2BrkuMqEx
 NcPugJ2LyTD19O7YgB8rwQKGTLC8TU9WhughhdLQiitvieMdUjRhcnKmwvuRp5sMYQQ0SZOkeOQ
 1Wz0ZbNIBqIy7r9+Ngglf2Hl87kzeSXSyqwf6+UIW+KrNF7iHFGA9fMlzEssILL3NwDVmfJeRj3
 3f99qZbELYbrUMpBBEbalBPeU7cMvEcP76a7WIkqfSND5r0pFiX+VO1CkLJ/dkTpsZYhASEsia1
 toynTi431JCb7Ve
X-Received: by 2002:a05:600c:a012:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-4a1680e76dcmr2993815e9.5.1790963240043; 
 Fri, 02 Oct 2026 10:47:20 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.11])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7515541f8f.39.2026.10.02.10.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:47:19 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Date: Fri,  2 Oct 2026 19:47:10 +0200
Message-ID: <179096320161.1973.2852858792260211089@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar_AuRr1eaZzOfw9@baldur>
References: <ar_AuRr1eaZzOfw9@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Same on a Lenovo Yoga Slim 7x Gen 11 (Glymur) with next-20261001, GMU
firmware v5.2.38:

[    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
[    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu hw init failed: -110
[    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU firmware initialization timed out
[    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* Couldn't power up the GPU: -110

Compositor fails on the first start and works on the second.

Reverting this patch fixes it here as well.

Oleg
