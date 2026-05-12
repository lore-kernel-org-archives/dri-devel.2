Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E02CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9670F10E2B4;
	Tue, 12 May 2026 20:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0+8gt3U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="On5sCgM0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843E510E2B4
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:19 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CJNi5w545266
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pX6fCL5guQPN0jqgASeMVy
 DoZuNVVH6rixmCIUGHZUo=; b=D0+8gt3U74S5D3ZmyTSp3g20IWNWm7AN8Tfjgr
 k8Zhu1FSrHuHw/F3kvwnNSxvDyq0nYQgCrbjajBH0/6BHpukLzQMiHTtunChQIeQ
 Lkojs3qQW0Qr0GaMqm64il3AahpBzue5gLV/vZGuBUij3NsjZFJlhEQeZvsXsNli
 qflv1MF1TJQH7gXEe28IQ1SCbDIi4FB8ylVGNRrYxUG5KBJDmnUsakeC113VQ+/0
 sgqaDUFJtYZeTMLl9k0vIvpOMjAP/0h6lbiYxeqf8UHkIluKuXF5mt09L+QzHKQl
 zGf80M3XTenGb/y9wVZb47dqJKsvF94XGQ920CG372JQ2ynQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e444sswf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-83eefe4867eso686889b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619198; x=1779223998;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pX6fCL5guQPN0jqgASeMVyDoZuNVVH6rixmCIUGHZUo=;
 b=On5sCgM0NY0PDndXIjRAbETDaeW9w/thPoqu2uqomeoDUwhwRLpLktbOcn9j3C11l2
 WP31uc4pwtzAKcdoHMbB90eqgcAu9zFSZM7mdqqZHsfT4mSOjxmyfSFMWmAcyxof5VBe
 CGjhB9Sre475dlQo2074G6idewWePNs7qAi8mbCpI9bA6LjfmhzRZbfpFil3Lv/eXFNH
 KyusE+xls9GYHT7R4MH7yhI0F7EdSGdf1USYjiwRWqHyd0W8fnJYjAYBl+mgEyLm5TrD
 /VQ0TZeU+5R1xWEp0hPuIUnpbR526yCfXW3fsVqEf93OANhykLL1h+Wv3x6xAJg4z3WN
 Gl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619198; x=1779223998;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pX6fCL5guQPN0jqgASeMVyDoZuNVVH6rixmCIUGHZUo=;
 b=fhE8Rw4rttZBtOOZzdBqTUJ4KtxetNkk9cNLcDzNMC7K7lX/8TfyW/fuRLTZsSIpka
 Rz7MzAF04rcOzqTgX1IK8YokP1NarBuii9d9P1TQSYpRvxBol9ckOwBFk3CkapibC64m
 1bwkbgXNkdhu4DJu1eaM7CE9Yi1kO1ecQBXo2JIsYtOqsJl4P2H9Yb9Ep3EeCxHChuEi
 z9m5bhryWII3azCimjJLCNxxBbhvDHZwAaOiBqgdPNbSXmGsIjy7Qj5fktEakh4GEixt
 mGazitwDndZasd69jiPzrl9oI+arJT7g0YhHDW/dQpFStSWeTX0x0PGz6P31G8kGAUd/
 /NMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99//dRbveK1jsCMTc7snRA5DDyfqW0Z8NHjDOPRk6kipWxfpOJwi9SUXoemKXiHaVZ8QUGARkN02o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzozltbovu4kChgU5wvUD8gjimJgW+3w2y186QVtqvyMwd3JRYk
 N8/nB3+G47e1iNnuGhNrVIsb9Sx7EOC9AiBV6Uf3on281bpObq4xPImOdaWTX1Z/acZzIix2E+f
 4YsSxYc4efpCaU02w4d+Zd2kW10IZnTIE9UQkNgP2sFmxpVA7bt1kk0bushSGIkpsRHHzFzw=
X-Gm-Gg: Acq92OGDPKsO2oJ3o9bkMYnRkjp1s42QyTtxrCLo4OgGxhX3dC7ltQI0DUysVbbAD1I
 gEvXzVCbMVVzRktSM4SJLUa7k6zEIT1GadwlOW8c30lZ3S6NkQniUY6p6HgSYtqqp2709sTuarq
 aFvmjcXWMyCBaKGuRaXW2kH2lOREkRKJEMBObr0/MQ64OQU/vLSgzmLDtR+aUOV/OpPMFeXIkAd
 zBYFWlhQ2OZnIh+AFZ6GBlfIGfV/OvcY4FYPV9xdTYrjVZsSq+ehTL9eQiXSPDlO6aDECjlmY9u
 tijtnouBJC6CPEFGLMchitGFyykYOo6KQuEiGHznrApemQS9I8aDDv1xlvwu/04o0xf+vt+GEhZ
 TsaIBmZKd1Xx5uLURQ8qtDTPYzwqe7eTSbN/J7BiMDknbDg==
X-Received: by 2002:a05:6a00:f90:b0:837:e9cc:d46e with SMTP id
 d2e1a72fcca58-83f041e5b9bmr273558b3a.21.1778619198258; 
 Tue, 12 May 2026 13:53:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:f90:b0:837:e9cc:d46e with SMTP id
 d2e1a72fcca58-83f041e5b9bmr273530b3a.21.1778619197683; 
 Tue, 12 May 2026 13:53:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH RFT 0/5] drm/msm: Attach a driver to GMU
Date: Wed, 13 May 2026 02:22:55 +0530
Message-Id: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeTA2oC/y2NQQ7CIBBFr0Jm7RigsdUewAMYd6YLoGOdBbQCb
 TRN7y5Rl+/9/P9XSBSZErRihUgLJx5DAbUT4B4mDITcFwYtdS0PSuHgZ0zv4DBlkwnv/ELraqv
 7ozxVjYJSnCIV/R29weV8he4nIz3ncpD/iTWJ0I3ec27F0uwVRldBt20fugwd85UAAAA=
X-Change-ID: 20260511-gmu-sync-state-fix-bc6b2d809371
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619192; l=1825;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=VJiP2CNPDm1TaYo847nT6IUtsKmpkr+gErSHMnh5B2w=;
 b=MECga4Q6THIomAzH9r9ubVYJCCSCrw0IBKkCRIDjI/8rWMrorZ5LEuCfoFANEwRYHdsWFRcGz
 vU4k2WpDoZGB0geMjJM94Gb6yVuFz30DhSr1YGhmH/aaKQbaBhuIfsw
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: PDInbtMUwtBgFC2L4pJ9jp6akgOqVlPK
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a03933e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vWiRZQarLoIxHqTZeDoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: PDInbtMUwtBgFC2L4pJ9jp6akgOqVlPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfX8koLrfu0guqN
 L50ZBw/r/HLL6cYzU+fjQK244g3lGuBLcKrvSPzKm+s+CZGaOyFgHIrncy4UPoiAA2DOA49zGuw
 1VgVkFZagIznGNZ23+ttN6ihs6JtBN5WtU4yrI/9CE0JhgKMUbI7QRKukqJywnUD03gZXRY6qSz
 i0OoVmdO+NOQmFrOkRuw2piSuFz/F/zRnxoATfM9Asak4Yj2jGpe7FTu9o+2nMLXOIQYHtZkDKB
 fpzEBU6jkkuvFcbWmkoGYTH1aW6SCVz4sf+capTB7sn3fWkc+UxCoG9okaeLf9NfPFtF9iCdaUy
 vye+Zq/PjpmPJ/Q+WC2ZO9jRgeBcwdnVy5DJiDwZMvM92BPBj5djDj5TVmkUphclf91yOSbqMwF
 B+4NUDo1yxWLCTmBMSFydfeuKM+E7u9Mcq+UpNIYPurSrscBEgr5QLmRbJWTtSmTFWBEubijQa9
 8qjr+R+vn9PusqUXeag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120214
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

With the introduction of sync_state in the genpd framework, any consumer
device of GCC and GPUCC which is not bound to a driver will result in
bootup warnings like below:

[   24.362666] gcc-kaanapali 100000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.371210] gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.380268] gpucc-kaanapali 3d90000.clock-controller: sync_state() pending due to 3d37000.gmu

To silence these warnings and also to have a proper state in driver core,
attach a driver to the GMU and set it up as a component device for the drm
master device.

The first few patches are preparatory fixes and refactorings. And the
final patch introduces a driver for GMU devices.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (5):
      drm/msm/adreno/a6xx: Mark cxpd device_link as stateless
      drm/msm: Centralize the standalone drm device check for GPU
      drm/msm/adreno: Fix invalid drvdata typecast in adreno_remove()
      drm/msm: Always use component model for standalone GPU
      drm/msm: Attach a driver to the GMU

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 76 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 30 +++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  3 --
 drivers/gpu/drm/msm/adreno/adreno_device.c | 27 +++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  3 +-
 drivers/gpu/drm/msm/msm_drv.c              | 49 ++++++++++++++-----
 drivers/gpu/drm/msm/msm_drv.h              |  8 ++--
 7 files changed, 143 insertions(+), 53 deletions(-)
---
base-commit: bb1459368dd795c43380057523f571d5eb0ddded
change-id: 20260511-gmu-sync-state-fix-bc6b2d809371

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

