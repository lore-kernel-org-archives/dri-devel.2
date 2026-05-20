Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED5CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C82510F0BC;
	Wed, 20 May 2026 14:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrchZeNn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idtERtPv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8E310E43E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCktNI1725708
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eeo9ei59HVM192M/bjlrRrRCHN6RB/mEIWbOlSQQvRA=; b=PrchZeNn4t63qFdf
 hI9nUi+N2zDsKLFEmdhmBk6+coqYiT3hDhl+HbWzIUcZGgS/1Dx1tzzEO7ODOgZT
 HE7CYaree5WiCxFSyayaTyeC85DLnnroH1BUSmsBg6L+pfUtIJJygzI2/H8cfgO/
 o9A+mSUP9CY244jqyHZNMtQgz5lQOXmhvL9hKTdKvERCWNxyukx3cyapv55CfAsJ
 bL6vJS5HU4/0LsX5CtaW9d+eDWL8KLRGAhymEIBwQKfLao9H3hUldX6rv27IXJHP
 HdjXOb4L+pnjvLowcLnYX3nmAya/r74lIBY809Be3SNyxcAJHAkHrh5HvzuT9eeV
 iTcmTA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qn8vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:40 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5758156cc93so5820839e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288699; x=1779893499;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eeo9ei59HVM192M/bjlrRrRCHN6RB/mEIWbOlSQQvRA=;
 b=idtERtPvhX6UgwMp9S1NvZH82cZWqUl1XW93dcf2GMTuh5yHHw5H2TiX9ZqdeqqQNd
 hSFr6151KeXEufOcaRB5L/fMTVK6G/LUW5Td7ib/GTA6QmB7Rp+Nzwo2hPSYgtrPsx4f
 CaVZ6wAa31O24LwbcQ0duROC7MdUGeCOe5iSNZNFlPao/anRV3FpOCSJJ4uqjrAYbvJP
 CGy5Re5uR9qYctXfMkEr5CPzte7+02fJEqaA5YjHXTpFonFytQ+p/GQ3KLxk7FfNEiW7
 OD/1yeay25Kpui3RDAMq7jiK/K+753BkOs283FC6NljiwwqbhqmiwA/0leonKbv0+Dn2
 y6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288699; x=1779893499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Eeo9ei59HVM192M/bjlrRrRCHN6RB/mEIWbOlSQQvRA=;
 b=aKRUwOITmbSVI6q9vkSwhUOLKCAknBYVNIxMdkLFVyWYEfq5HZ6xsB2BpCHECnOW4U
 +Kktv4PBogblkw6k1htlTeI1pd/edXS9rr3+D4C+y91Jtosgm/+w5kBIfmRbYBpUl9Wf
 Hw1c404AmYeuqqiiZ7y7PeBwgJudHYJRGsR3+RDLlcWnBilkZbiQr/TpxEfxQC42VexV
 jX54Thpeaq+DbTKKk5H2rsAC1psuXBfCPfDW8ZQhoHfX8y4bviPU1yZJ1dKuwoyHeVp9
 G/ydsVL2mIcOrcnw/D2Z4zUAHP7cuVOOTelkmgiOXIci+VVu2ERwJN4Fs0R1lrdKvx8k
 OCug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BblHa/7dwvcrNE/+V434y9WRunYL7sxKrJtmXqkTN/fS6xumiPO7sgej5G7jzapA3jDEGwFlnQGo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0lI47h90+Pt4O86m8xdrhZZ19FwTWUTPAXzi9I1fJez2pLkE2
 YnhrWD8pYi4wJh3WELJagBLG6uhOqsR1leF/4jXk2Mwn/8WjeaVALumcDqt4sutFCrE3qk4fxHa
 Gl/9Bxws6pBhr6fKmRbATKOlkTDauMYC1iJrlZCZw9jLW4HJJ6/dCK+DM0ZO1+fNSsPnOzHs=
X-Gm-Gg: Acq92OHNnNP6Jykgkci8DXjEZ6A93+Pqv389PVddPp1o70Fp2alOHj6A9ydKgydgHf4
 3UZQwpr2V0erJKvq0lWNk9Qqbc7Hv2YRS7R2L8tkF9fJgTJvm2S464UDtDj4RD1Bpt+FSQWf8wU
 RLHmh8F3UplgRzh/LQIhVwJ2pr0Lvi13R98vagsbz0ETuugZkHBHnEs8wNl67wIdyS69Ae4ymhL
 YWviwXTDUuvhOGayEy8il2rpOLRzNxHPquFUWfx3SjnVFhdo1ruUiUK8Ayx1MLZf0q8LdlANvwe
 LyxqS837f9L0w3lvNRWYh+KF+LVL2sgQj+x3Y4L7ELQ8l5Wrojy5Vavg3R2Dggfo6/qtqUKQGh2
 cUk/QXLMaXCAiBX+jA2BG0s0Y5RNaM6hoZbsUMSP110PSZEV3Lne/a1sCi/7a3/etW4rrecy1/Z
 zInZXDxWYaeDXr2jfhCIppMHwSVc1uiIjab2o=
X-Received: by 2002:a05:6123:4201:20b0:576:1a8d:8989 with SMTP id
 71dfb90a1353d-5761a8d8c59mr8715651e0c.0.1779288699229; 
 Wed, 20 May 2026 07:51:39 -0700 (PDT)
X-Received: by 2002:a05:6123:4201:20b0:576:1a8d:8989 with SMTP id
 71dfb90a1353d-5761a8d8c59mr8715554e0c.0.1779288698506; 
 Wed, 20 May 2026 07:51:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:16 +0300
Subject: [PATCH v5 09/28] drm/msm/adreno: use new helper to set macrotile_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-9-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YFsDO3JoZHZoGFeDfQhOfrhr6lwbEX34GrHVmQ8WqWA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpnptHF0cvSg3htcJq2qUXfc7rPQgOHPfOdq
 mBQUOPEJEuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZwAKCRCLPIo+Aiko
 1XOeCACgNFmMquQqVD64f6D97uj9j4yaAvvnVe7hHODyf6xs4Tht7rToBtBXI5vtut61hXLdZtt
 pUPIIpKjZC5IefW2CW7cZbapGVw52IX7S0gZMWdzssgJ1zofLqw/l7L31dhnOsRErb+xw6vLFXD
 oq2f1rKKdsNyAEGhYvAdWqLE/vAW1f+YUtELLLAfKUWUABnuqOwhxTkMGB1dBcNg+FpLE+vgLgH
 vTlaJbl9Ue0RKvnA+bNQUi6QrzaeIsbDM6X1n9HCwEngjVZ2/O6E2XlpTJz2UluZL7yCORc/lbK
 GIILktH4y1Ehl4SGViyL3BmgOLIbv8sWAxZ97EoEQH4LPG9u
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX6e8xGfH3GvuH
 DlT3kfiOo1hsmy/mRfcn8qkbrLh4h07VWBb+2N1lUFS0KGhFEnecFC4mHy/R2jCmKaMFnO8SEgZ
 32ohPumzcjnyRgqO1kKlwGFKyG5IQxpV3TBNNdMXdsi9P/bcVRMcBjJyNuXtLIlBGQQSs4emAAe
 qgrTLzcCMQFLlUv9TP5vnABV+WHfTn32yCLaazx15YamhdvLy49GcvWMNiue+EWrOQzh4hiDyk1
 glyqXmf/OmxiTwZnoXMt36CmR0CgS3nEfgHakonXbes38BbS/MHSg7c3T1cGAY92Hz+wa8/rk6X
 RgaxftPqgQ90RclRwrfwAkfd8syN9xr/mzsMf38I76iv+1Xq5gfzFyl8j8Ll+ntDsNSc/aUlOtX
 SNWpSi+Dh8I1nvjUEXr+E9UgMlo4SdJJJmvJTwO072DUR7CXjQg+L1wXdcVwIsz+LEHmp+oo/sT
 A4kbTCU2BYTXdPZoJYQ==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0dca7c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=AuD0-tKUimmDNzgPTmIA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: eKRh5yVb96nn0mG5X_FZuAp1zoJx7HYB
X-Proofpoint-ORIG-GUID: eKRh5yVb96nn0mG5X_FZuAp1zoJx7HYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200145
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 45c966610511..43818d1907ab 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -791,7 +791,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		  min_acc_len_64b << 23 | hbb_lo << 21);
 
 	gpu_write(gpu, REG_A6XX_RBBM_NC_MODE_CNTL,
-		  cfg->macrotile_mode);
+		  qcom_ubwc_macrotile_mode(cfg));
 }
 
 static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 03f96a1154e1..78d7ac3fd8c7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -439,7 +439,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 	case MSM_PARAM_MACROTILE_MODE:
 		if (!adreno_gpu->ubwc_config)
 			return UERR(ENOENT, drm, "no UBWC on this platform");
-		*value = adreno_gpu->ubwc_config->macrotile_mode;
+		*value = qcom_ubwc_macrotile_mode(adreno_gpu->ubwc_config);
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:
 		*value = adreno_gpu->uche_trap_base;

-- 
2.47.3

