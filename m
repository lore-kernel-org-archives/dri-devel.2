Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A9EE63FFB
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC5210E07F;
	Sat,  4 Apr 2026 21:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nok5AUPz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1h/4vDC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE28C10E07F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:03:46 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6344dfim2971718
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=O8qW0bRHK9VtZRzpUZbVBD
 nyfCKTCiQkwr+gwij95pU=; b=Nok5AUPzJ1p62JfHrbx3zWpzWZL0PlFvlHijbQ
 EV+ex01GKdiQgce+h22lj4A0ZUov9KeBI/g89wW+U8QmrjgMdjiF2XcSQ9xj18gp
 yAPZKHKSDnuasfZWuvUvNGPDzZMT6C6+PMX0o2CIu3g3QuxCTA7tLZjQmNMdrl9B
 cJpt5hbTytmegE4Ay/h48N4xFiQhncGgt7E7JflKo0o1Qpl71VQddoMpLYs0Ctka
 AFZtLO5g9azAa5qOcXxaQZirMEXb5IpGE8RKiwLWRIGOAL9czXP/X7sr878XGktQ
 NWV0wKizz4qWQZCxNXItfXHUNvm3xW2a+wDKgTd0tRAF66dw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth9d9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:03:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35c1107da15so2794516a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775336625; x=1775941425;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O8qW0bRHK9VtZRzpUZbVBDnyfCKTCiQkwr+gwij95pU=;
 b=j1h/4vDCI6S8FiKKv9MgmvE01+Ixa88ozQIwpHI0k8gAZxKLsd6efFdHxGpORtJt3X
 xsigi3igL/CUHwf7soCsYfdFL4F6+nf9FyXQkVjmEEXmMb5372hVJIatnwe6213dMDwY
 yHX7JIpLE2cK0plcT3AjCbT4fyS90K5kveE7VuUvVBkHd5wXt3CZjPGJuzCI8+hxDNIL
 lKVm0iKJOb21VP2Q+9LNpDqjCphP+vCu4+jbFZMo+VRMIl9mSBekOb0YrsvrfdSoCIx9
 bWm2U242BsuNB9JqrWqrGjUSTsqJ9OMIouD0PREWcRSyfMeOd3d+pNczHgb/1mjTFwqC
 sa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775336625; x=1775941425;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8qW0bRHK9VtZRzpUZbVBDnyfCKTCiQkwr+gwij95pU=;
 b=OBAppQoVodtjKKC2G2oCQw6WrOigUC+ycAtqreM9zPjxNQ1nyZJp1EjmnjETvHczjH
 8msP1rk5FvWRom62SEa1f83AjybRWHMCXlFIwZYm4xqsW0mdViXf8PCmnb34sDoCjbGW
 TvGzqs+j44JiDZ+8K57mWAwrpyt8N+Ts2jrt0aUCVsODQP2svyjJH+zcjmuM2zsaroC3
 gXYs66tLMz/U35hsh+B7vB6cGL5UhR2uPrJu8xH2mv8xEeQkcEELRcXZrYIqLUUSID2u
 /EMgdlFfpOg+F4HCmrCJ4hY3VqERzqGNWNIAVi7Iq6AaHQbt+1XSiMLEYGabP8aroQ5q
 OYjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoAjoeU1PJx799uJJakxkJGCb1ANwdsIXeYk3EijyB0TOhalN6DKIJKWPIeZ1d9fpkQek8CgNN7Rg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjUPu4Dk4j73A9q4/9peO/6KYnfXTxcWmYj3e7NS/hGCm2QNOP
 qRr1EMSTAQaQnnaX05d8gs7MNfH0BJCFBCCRfBZ9e6h0WoSj8YefYUKewhHzhBEZtTUhetXZCT+
 WAHDSxELUtuy2EP6bvNGdQBB3TkRBj3/rqTLHr3Xezr9kHiB1904nZCagKu9AkECB6nws3Eg=
X-Gm-Gg: AeBDievZ3o1LuRlTSEu8jLPtVe20FS4kkFoy6UKyHHr0ZNABHw39kNUiusRf8ZxZDZO
 EePuzDB7rjYPq8xBtW21bYIfaV7zfUUJWjvgoLF1Y8iCukS1i2WDFj4IO0O8FOvV4djs6lL1TcV
 fVo8t7gKakseTjNttMDqu7PnMOm4rkCLlb+TIeD93zyeu70OKWEtdnBG+xbccKGV3gH4mg0c4JE
 M64rUw6zCqiSO2WhT4tvbfgJZN1+i5d+6HYA2qpOjs1enJhtWs86Iq0Lior/D6UI6bqQ9RFUIcQ
 YekRDtIX3iYhBz8iHl2YY49+PIhyE7mtcUBTxtH4d7xYzz9UxM004jRAvYwEW2o0ohukVTIGCSM
 rpzkxHdSgkwiksby4HkexcRYXKwrF+uYELFQar2qsVGxmtA==
X-Received: by 2002:a17:90b:4cd2:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-35de68f8971mr7183157a91.19.1775336625163; 
 Sat, 04 Apr 2026 14:03:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4cd2:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-35de68f8971mr7183137a91.19.1775336624631; 
 Sat, 04 Apr 2026 14:03:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm2675545a91.4.2026.04.04.14.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:03:44 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH RFC 0/4] Devicetree support for Glymur GPU
Date: Sun, 05 Apr 2026 02:33:13 +0530
Message-Id: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJF80WkC/y2N3QrCMAxGX2Xk2khtdbghIgg+gLcyRm2zWbCb6
 8+YiO9unUIIfDnkfC/w5Ax5KLMXOBqNN32XwmqRgbrJriU0OmXgjOeM8xzb+9NGh+0jog4oREE
 bViSWXyH9PBw1Zpp9FzifjlD9jo6GmNzhT67SE6reWhPKrKMp4OxfM/6VWPJezs1ltpuBYOJfX
 FurVK1DrfquMW09ckzDUMtCk2ZbxfPm0Hu/HKK8fxuWae2her8/Yo4aLesAAAA=
X-Change-ID: 20260226-glymur-gpu-dt-339e5092606b
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775336617; l=2365;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+J4aWf5YojiTxQdOvfgMJtW8OPo2YRqorfMBEiErPAE=;
 b=jPzJNMWb3g7JXstolt1bgI0t3NvHo96BiE9bZ+CxlIAgn7WvnAAg9ofOsPmhTBqrDY6/6+elH
 NvOAdVhX+qJDRwb6GfPTvXphNmC6cz4gI54LDlTzQe/EnzTZOmLwUVH
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfX0yCATFMH6dAv
 zhYOgo+BoIJ3KP4phN69bUPk7wOTN5iN6xss7/FG9YYyd8j0GiuvlCDMUa/Hjbm1OSzjZieFOO1
 uwpdWESmBv7xYwpxLH7h3DBDBsijVzrq5vnYBUyoXXH9qGZBzJL3utSOSbMs66EgNna6izU2qfd
 vUC3UPgEUTN6+3Nv/DGgSPEzmouwtOXNMnDYUD8R7Tem6Oz50DMmkKfiKCrAW5ljKgm1mppfnrb
 WkKw6H74T8MEA04xd8ek1uW100ZC4NeAxHTAJjzaPwHSRoO1srt8VkBemHk2fEo0qGPAihVkCmC
 /SUEBWgMU7H8Z40mcQIZz2J/5/2cFAhU6WpWLyr0L+Tcq6NOoKkmID0ELqJ+KthSKgjiEjy9+n/
 GX7jmnAkXrba8tbu6b7A7mHk2uKO8iXGDJdZId9mTFYKUB4rEeguovyBTRTS2xljrgRMAV6IufC
 R5/d/+TazoscMWWFQKQ==
X-Proofpoint-GUID: 0OJQ_k_5Bv0oPmpcnxUJltWEra8v_Qy0
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d17cb2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Q5AOMzfNme0c0ULdHeUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 0OJQ_k_5Bv0oPmpcnxUJltWEra8v_Qy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040200
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

This series adds the necessary Device Tree bits to enable GPU support
on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
chipsets is based on the new Adreno A8x family of GPUs. It features a new
slice architecture with 4 slices, significantly higher bandwidth
throughput compared to mobile counterparts, raytracing support, and the
highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
improvements.

This series includes patches that add GPU SMMU, GPU/GMU support, and a
patch to enable the GPU/GMU nodes on the CRD. Keen-eyed readers may
notice that the secure firmware property is missing. This is
intentional: The Glymur-based laptop platforms generally allow booting
Linux at EL2 (yay!), which means the zap firmware not required here.

The series is marked as RFC because an update is required in the
gxclkctl/drm drivers to properly support the IFPC feature across all A8x
GPUs. We plan to post a separate series shortly to address this. I prefer
to merge the DT series after that series is acked, so that we retain the
flexibility adjust the DT bindings if needed.

This series is only compile tested on linux-next. But I have cherry-picked
and verified the functionality on a downstream tree which is pretty close
to upstream. Also, there is a dtb-check error for the adreno smmu node. I
will fix that in the next revision.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (3):
      dt-bindings: display/msm: gpu: Document Adreno X2-185
      arm64: dts: qcom: Add GPU support for Glymur
      arm64: dts: qcom: Enable GPU & GMU on Glymur CRD

Rajendra Nayak (1):
      arm64: dts: qcom: glymur: Add GPU smmu node

 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dts            |   8 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 234 +++++++++++++++++++++
 3 files changed, 243 insertions(+)
---
base-commit: 83acad05dee54a5cff0c98dd7962e55d4c6b145a
change-id: 20260226-glymur-gpu-dt-339e5092606b
prerequisite-message-id: <20260303-glymur_mmcc_dt_config_v2-v2-0-da9ded08c26f@oss.qualcomm.com>
prerequisite-patch-id: a1fb5b7ee94995a24f6e96d1d2524e710d3a7e60
prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

