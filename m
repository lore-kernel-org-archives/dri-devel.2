Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8AC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5A310EACC;
	Mon,  6 Jul 2026 21:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkb4D/1X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFTLyI3f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AE710EACB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8eZ1654904
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=lkb4D/1XuVf9UMpQ
 BgU+KGNhS6iWu2lcOfX5GQ36WYrsSl18R5ZG74JTkUIbt8g7M64XiGMIgDLGMCmF
 8PjEYu/uy0TyMoB7bcj0rENYAY1HMLQhHKwXsHGY73TTMqtlPFSTsZA86gLqU3JN
 14VgrVo2Eg+mXxFka9uofvowzG2FT/gddAJfxxj7+nDP1hXyQ8LleIY8W6MIblMz
 dzXbGoALDZnzvHPZr7XeA5ArlwYHJoMFcywOfZvxj60WrfIlXAURgFKxYP0HCx4t
 WX7BSPXHvMvlIwwVnd59NQDSxl2geVbVvbSemyyk8NEoPHtVb3At1KO6y5Qjp0v/
 aD97iw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpjy0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8894570b58so2431348a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371911; x=1783976711;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=OFTLyI3fEaXhh805PdNef98eLj4dPME7DobJzJdxa66WlFR6aNRPhWMPzvkV/Wi2LB
 gxGmSsX8GHH78FGrbEXEW7qlWcjDD1g3HNnvhTR+vgaNUqqEVtVmWcEm6Cos4NKD+NXd
 nyhkB5cwbyIX4JVIJJNcIbulU0yrJoDFOf+m4SbHEHioQrPDL/LhOj0r/f40pqtqOlYO
 IhZmpBypPIaDEoGWodzxpG+catkM4Nm/gltuPrLM/E7yCNtShWHcLPt/guK02vGRDxqf
 GAKHYEEaoNUgrhf4U+IEPTxY3HRWR87P43pY+Geu9+YN5HQgpz5cwdTOfXYoFKwTRab5
 1S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371911; x=1783976711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=fm1Bhg8AWZ7Rrvfd+hd8wLa4ObZXg1Xue9VeVuNBWuSIyc/iNCs5xGU9CoTW5RsEEK
 ivEFogvbghxAY47uGJVi2MiCjM8THWrAG2xY/Wmg7lIBGpsH8rC0VQS4k51f82K68euT
 +3xauLdXampphWf8uSU2FmCtaWhhUbWjXeoSu3qpOMJiT1oGbraAjXMwFKEutFAYNDFO
 FGWy9jqpv08DKyJjTIi25axDOTnUQKnaGsTlmL4G0/zeJIQauU7f9xnikkaCdJgDIVMF
 SKmu+EfR4d3qE2Ie/Tb1wnYNO00x6hcJvF9u+IxwaJFW40gdOAq0IMTKPBijEcB+B+fQ
 vYZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqQfSFFIZH3TF7xcaVOxkGmRWKUvv18E7lBlPebob51mCGF9cEb1tgkYvSsAWqVJFaTLTh1IPz7sI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycY5OgINg1t1q8NsELQJACVERLfo/BxSz8C3iGi/0CeVL8gXSB
 nKaYCAeVvkD0pdgkRUeSmgtGiiAq79JPzfgihA4nVcXqFJVMdtN9ljHZs3gS4YRiO2YBNGdlxhr
 8VFsTw/JxlzXXcJpp5h3G4Q4aGkwGGc3k+xbtKShOVamtv4lPtbSk4YNES5HiE5xo0hf4PNM=
X-Gm-Gg: AfdE7ckKO4L2dsir+7ckPMa+2M+7MdJeqysx9jwJm+yBIJLwqJwjJ3mo3anoZYy93vE
 UxPO0gBfmEKlsRNJLfTuKFsooOk4e5YWpPleRTViwO2e4nP+bGGJIBjp0dDUHo5FYrTflMzgM0E
 PvYnevHjOMa6PhZDMZWFLqIXT9g5tK+XKk/Rga4dvUMClRWEqhru17rVeXneiH6fv5XONphThNg
 Et8n3gVwnEBgzRh+7+wfsk0GxFbJvww0RNALq4CRcuxCVHYiv9TfsMRrb2sOSg5BUOdti6+rTLj
 ebttQUb3bpYNWCOWTzbirrvJi+KcPNaEYMSZmhdHFvGZi9c1cRNp4evbQWhUoFrN+nUcilEbKNk
 OHZ+p9B4ebm7JgaZini3eakugRFFu7851XFo=
X-Received: by 2002:a05:6a21:2c11:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3c08ed578b2mr2371433637.22.1783371911009; 
 Mon, 06 Jul 2026 14:05:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3c08ed578b2mr2371304637.22.1783371909486; 
 Mon, 06 Jul 2026 14:05:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:33 +0530
Subject: [PATCH v5 1/7] drm/msm/adreno: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-1-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=kpXC7qkSjgoy11voEpWm/qgJfUAZ4c17t4cpkQg5YXZd8lqbz6loooMhL15RODOHIRwzyL6tK
 a0+2Ku8Tb9eCjyNtiMNg36/Gls2eQ6ZhlTTCxX7OXHZ2QxAnkps9BWj
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c1888 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: -4UsdX-vVV2GPev5T7JHd831WjNiEqyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX3w+eLsh1Wdjq
 t4N9SR8p6wzQOqys0rlglZZXg97nTk/ITuZXN3dQ29oj0VsoIt3+hUeH6ljgrPUaHvrwpfNOdmB
 wRcocbfHRyLy/1H1qA+JOK1OAnxat74p+6PmLM070Z9cp8p1DPkC/R5HcCK1TzwnywPWF6xcPiA
 JP6GARVVtZ85YpyMyYXD5a0zPwUV/RZk8bvLx9xTJpxjdE9kkTEnpi3lrqTaH5arnCtgXnSP5vw
 Wwwctn91qTQhhPWb+XQp76lt2UNbGmNC3fthkuvZK3fR51H+doqgGoJS81UrRF09u3iT+4rMT/B
 outEzhyEkL/m4fs80sP3CYmqGyAdN9HX+lBVkarcRhyT6Xdi9lovUyy6I3vhyn4iP0nIKq8NqrN
 UCd5fOa8w9p9Scq2X4vRaxbjMrE8bWJxnyQuewQXtrD/Bg8sKS1cMG/UrLP6eM6TbvdwAK/zTQG
 gAVdsWv7gROulXbLLnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX2eRWqrFxRvzM
 ypc+QKVVsHLN5MxU9YXNXdcHxhe/FgtnY0ghFJ9xIEiplcm39x9BwXF+Ejtqb5sE6QIqfay2W15
 SbqHJqDwn2GcCiEcKBIW4efiXYOis/c=
X-Proofpoint-GUID: -4UsdX-vVV2GPev5T7JHd831WjNiEqyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060213
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.54.0

