Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF663C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0677E10E6C5;
	Thu,  9 Jul 2026 18:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAwLOPUC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NklfM1t2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F7E10E0E5
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:42:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HYUnp2331635
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=dAwLOPUCN4+fS3FY
 zSMbQj1VkLrgSvjf90D5Pv66M0wHcSeFsoCjPd3BuNGPPzjo4gq69Zr2EPuf87+q
 xY51GcMBq1NbBDYfLCy2PY4fi7BdQ3iwUiBqA+zJyxKyW6zXIdNu3zj2XEwihOg+
 NUfgX5QVOrcv7xIlGsEMRuE0LbXPRUnZsMCDlCmaLy087f16esmgAvpimQ6i4KYM
 aLgvtof5MdJeIJHSaljSMpo1NHxzwWTcs59aQA1+pGWqIlktr0y3wh/2TuYVzq+a
 tceDmYbcefwf6gkuY2BkT3dlAXVR6+gUlj9iqSR3Z0x4Q5Rrl7ZsY+R3sksmOxGk
 JoWkhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24rq0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:42:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so235758a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622555; x=1784227355;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=NklfM1t2AwYsjVWgOUQeDcwMgdM62dQcy/8Eup+oqh6R4OO+2oL/Ff803VQc2YedMT
 G440lQHFLvLKi/NViSIaXU47L6K5i+8UZXqd+dkeMWnHwxI1Mc57P+kHc1i91bSO7oGH
 D9mitduVb06JAK4zdpR8q7mHCPZUo+qaUJLD0BAgJGqaoYiUKvmaVDu+enuiUmGYvVVz
 /iGOlKA6xZ/YNXhy9zfx3dGxCcjrhI/lgHKDAKb52LtFbHmX/+tu6NGxDkK+DLXZyenm
 An3EVcQdw67drR3/IgfgGMN6aSSzrv+pHZb768CpxSc/9zfwF91S1OBlLlxypQhp1lRs
 aaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622555; x=1784227355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=U8SsOAX8MFrI4LWZ0RmDM+sWOTbfkXQS56Kg9I/2C92nF4hqwsdiuyWxN7wQ7k4LSX
 UTfFfDnG28v2IZko9yjGPciGqDSB2yCKFvT3lowO7wOqQ+3mtrlb1LRdXVATSlKxl05K
 1tfftKtFas87rVNlWhxLJ0b+BPc7ibUJryHDz+MgM7Z+LGVhsZCBos/+e77mUlhKIaJC
 FL280Wn7GX9+p1HQSabCzaRyhZh5n3n177zZfyQHrH6SwurCkvtqo+AklcKquRTsjREf
 r1H7iwZC4VysHuk0jZggnCi3Qa564USKb0mcRxfzo/P6SGNLsXxqdcjldT9P29Nxmvwd
 IrwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqS4KCHWMI/08QfxdUXE4xO53/JtVW5DTzi34XwWCcYCTKUpPZOjtSsn+hqg8LdMMIPvES4I4VAJoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCOXziSJKTbFWCotzzZsa6BDyIwV/zULfAYcUSB88U9/5yWNM5
 8Hq6kRuIag3Quw3AzrzVZtBz5JrNMklgeyS7qhqJZbJD6/HlUyYN0vYsudkgO5n93KugKOHUiXq
 iFLyb17mdx4uYwtf+7oPzvadXrOhoWkQIkkeJ2jzMFyiwr0Ocx08Yum54ivbJTMiBh3fhd38=
X-Gm-Gg: AfdE7cmJAbD6UXumRl4W+ojdwasXdmSWUOrEeNC4Ml7KWQzynqTNVSGIQbL7JWfL2Xk
 aLUF09Ib27kqUgccPp4A/fvuN858vwxZPSvOWas2NeWt4UdzdDCS+s4CicRIWKIBnHmYuKrKoK/
 CHB51or/oNlOXv3XevF/WWOMDhGa/eeqgzO7ZNosYXj40cWVlI6fBI2PN3ppx9jMSdkO5worUMG
 5KjWHHePMFFXhATDqcFEZGLG43DQH9D04oYsX3LohckuoIuPDh2wdRG9uv11FT43yFa0VhTEr3u
 PueyrsAyNNYhPxs9CVUSaBHyM6B7UtcIeS1ti6zw3Uw7fav3Ev8daGRouglWHp9f+BYU0mTlEYc
 sq8mTy2tFXVEN8uxlv8M20DaX52JtvWm/wkA=
X-Received: by 2002:a17:90b:554e:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3893fe5d587mr9351785a91.14.1783622555155; 
 Thu, 09 Jul 2026 11:42:35 -0700 (PDT)
X-Received: by 2002:a17:90b:554e:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3893fe5d587mr9351738a91.14.1783622554713; 
 Thu, 09 Jul 2026 11:42:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:42:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:00 +0530
Subject: [PATCH v6 1/7] drm/msm/adreno: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-1-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=nxXrfXueHCc8y0f+NSNb9djpV2+XQhcnHRgE6tAiSlaz/KzrkKd70ZDgPVMGFyhqmn/+r/2aH
 qjx5RZWOQQCDnIJSYqVVjc9IR1xwlOARTfmr7T/GKNDW7jB80rJlUhx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: hPNw3Jy2jwCTs0pmK4JnxgXJ8MRGFQ0q
X-Proofpoint-ORIG-GUID: hPNw3Jy2jwCTs0pmK4JnxgXJ8MRGFQ0q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX3GPrTxSkJPyj
 793JpyBsJvThYIBCqQ4HEICTv27jCVLgoK9hGmOi/Cg+ddW0yCYWT+heo5JtOpCZXgFKWl27vDD
 KH0Sg3gmuNE7xnRlMqyO5MKCLkDNG+c=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a4feb9c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX/UYh8Od8MNpJ
 icCL23JTFndPqPF4MBgIvr/9PjjadL6+IzAblGR4mVvZvbI1Sb+nqF6uPsTz2TLiUQGlMwc4XRf
 o3a28XG5V/RruJMLGaFWvJd8nyi5EOMdlr6gInKn3Gh20vyecS01QHyimtSSbuLg/bodj8VpB2y
 c0bCfDrD1mYP5v4hYkR5FnkfY91STnuVkSeqIJ8yb6bxeBL5ZX1cb5bd6MxCTxXlQ+pEGY7tpoj
 yNyyMJs8pJe6lq9+itTEBr8VdKlWrNHZsmtq9cVU3uzu642j7hWWwIRANIAWDgh0LTGJM2Q35mO
 BEoBiQ1vBHHcCFoxAA+8Zwirp1Q2bgQ5sWEV67hp/TT0LfOEac07of/iK/tnuOunDmfxkOcTUWv
 tC+6HGY8EcIReVxqfqZSz1aTaYZQA+9gedXkxGMOuBsG2+VnL4FFk6YjXbjoVTo5nH1ULHOA/0K
 f4saiYVPxrmVegufU4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090184
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

