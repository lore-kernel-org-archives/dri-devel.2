Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F54F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25C210E3DB;
	Mon, 23 Mar 2026 20:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLR59CsO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WeGAZCSb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D1010E3D6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqbft1762120
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7VzCEBL2E65XFVAgC4ps2o
 FizCEaaNONz136DmmOrqw=; b=HLR59CsOSltyNVhtBVvJfKWVqAdCMvgQOjHpxs
 GLwRYr7lk42ZpiukN+muRGVBgOzxV5FNc+J6pyFlUfuU70hu2t2kawgbmgvOsSYR
 MweP/dgOM9XpXjUko2VK7wVXWwcH56yTMKlzeJED9iMDDC0VY1U7acV+Jy/N1aLd
 pWRkg9AdLUaTDcpF0IxUOkIoYgoHZAVM/gAENsRO1YeoX95qbs+tL54a9CQIYwfF
 7X6D9UVa7aoy+PLhD3oE2j41oh12YXe6ThrotZxHnfqIGglyliOWbsrdF/hW8WXR
 AlXuvnUnAg8UhhWwFj6tjfWdE9cDxkq1iJ+ZWa6pUfgH8RTQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d36f09dqf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7380305a9aso3678037a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296759; x=1774901559;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7VzCEBL2E65XFVAgC4ps2oFizCEaaNONz136DmmOrqw=;
 b=WeGAZCSbFQyrF+O2XitL+py2nbNoLbemcXdVAoe8xwJ6KrXZ6knBnTXnuufaOgCfJs
 5OGB8Ro0+cGzSGrZRcFlRmbsRCJwPGQ8vA6OnIU67zqMfFbo2AUXaVdB0L58hk+T/E1e
 +/bZYClwQB7e1o2rL29mOFPi/2qs8WICWOvlkpvJBzAxegl2NnM2/B4GT7xsiqs4IZD1
 UDgVIElE0vmTBbMoxnLSyKQTm83QlJSJLDjvJWssNiA991AEIu5SfU7d5HaHSVSCFzu8
 Cy3n1qP3OMe+jngHGeeF/UxjPWe/D59Rq8L03E3INBQoE+ieidDjxPdps5Db9NORYaGs
 sKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296759; x=1774901559;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VzCEBL2E65XFVAgC4ps2oFizCEaaNONz136DmmOrqw=;
 b=jQFatQHO7DmrtCGZfi+7ofw7DpDG2u8iCgbq7dL1OuWWgMGtRq+gJSrxQYhWgO3lj3
 FE8Tt8LZvE4XOyJE4cL/RnfyXnvh0dEYQlZxkhA9JyrO5gDhD2WgACzdeilQb7an1Wo8
 oiGbY0+OL6foeT0LwGMgwCNrkv4X6OY3wXa29DAE7ahufd0ZpVXZKtTCardcAuIEq10F
 hZVrOF/NBTJBHZJCUw+mIUL9JdNM8xnA17FgI5Ihnt3KWEURdR7JJ1P0G26Pt4H7YbLY
 PkJVUKYBhxwbsV6La+5DO3icVnoyIXvv4Z+1OTF/6ELvmYWYtN0KyqFBzBYVFYmdjC+P
 OQPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2F6xXt9NQXkR4GrDoPKNqHqm93fR3nPhoSoJNpSeFoiuYpB4jj8HvUYJRvriMNNFCbVx7bjTWsxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcEjVFGUe82vqNonDEucIhVybCD4HOHXofhYOXFOpRpgvhk6Go
 a9y/cg0mSYTVjZntREm1WiIVnoqy/Pb5GoB2bokcZkUj89P6Zh16GB3Mcm3f6x6xAMZ9AwWMiS1
 8G7CmlWxHuqdHCnGSG/WV4vZXs+rJH+LK0mdbiPZWwnkxCHa8Qii50oN9aaiUuQR3gTF/AfY=
X-Gm-Gg: ATEYQzxdaPxdWSw1rKWoln5TxXrrwGxbebjhA0RbMh+jAJkdp5p3SmlFFAoCuA3wX5e
 ha0wo9IQRKUi6AumDsqBZZaTdRAf31Qx2l0ksEWYkUyJRRU6Bgs8M8NwI+nfbTjKE451CQRqqhO
 XSsneA9GLmUskCdJSrqEg2VHrzdJMHmyntAEDygTksJvTdG6xekCfphj4wfXOfvqBlgrFZVpjZJ
 FfHF9+0sTbxUXOrgxKvc+/SRR9vRTPgUZCHfiKhfKHFqcKwzahz4aSXEhG9p1/SuLlG2g2MILjz
 KdqiM7Wtqdht78Dm22669QU/wmX1ysKz0EVUFZE8rCFxmRJmyjvqhheCh+xBRG4HQQqWD53j170
 Vt1RDF0+aPDB6VhJ+Fs8JJebgfXvj9mQdh0f8kWz+S4azlw==
X-Received: by 2002:a05:6a20:cf14:b0:39b:8e94:c4b2 with SMTP id
 adf61e73a8af0-39c30f2549dmr461618637.12.1774296759131; 
 Mon, 23 Mar 2026 13:12:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:cf14:b0:39b:8e94:c4b2 with SMTP id
 adf61e73a8af0-39c30f2549dmr461599637.12.1774296758637; 
 Mon, 23 Mar 2026 13:12:38 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:12:38 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 00/16] drm/msm: A8xx Support - Batch 2
Date: Tue, 24 Mar 2026 01:42:12 +0530
Message-Id: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyewWkC/yWNQQ6DIBBFr0Jm3UkotrT1Ko2LAQdlgVrAhsR49
 1Jdvp+89zdIHD0naMUGkb8++XmqcL0IsCNNA6PvK4OSSstGKaRnKTgsKxrKdlRo3MPd6XWTmix
 Ua4nsfDmK7+7kyJ+1hvM5gqHEaOcQfG5FHwOGFPBw8P+CskGpodv3H9XMsYqdAAAA
X-Change-ID: 20260322-a8xx-gpu-batch2-bf7f5a9406ac
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=2904;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tsrqhnh/4KQGcogalvfrZcWTtxfmVrAZkQvMOMIVg4M=;
 b=UaVLyFZNH8WCBkbqcBCGLkm0owjayRG3hP5gk2G2xW5UTRGfbWqgl8mTdmxRZXUYTByncwUrD
 QlBDrqICFoUDd45PseqO/C2GSCnr12nbpnY/MOEUMFIF7WdppVA1w7O
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=b+q/I9Gx c=1 sm=1 tr=0 ts=69c19eb8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=69T32sAQ5s3mN8b8UpsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: yYjLPG-sAv9y1zW36IdG8eAeTLTe3A8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX+qf7iumfClMV
 pZtWV+UQfNwM4fuljLN2J/mzSv/EmQ6PSj4Sa8mGbcmNUK5yZWuTT4soEY20z8LtvUKjsTu0rDl
 kOjR62cN7eNw3vXlACynO942ngXVT3rAY9Xy4bw2jNHbwiHjgjqD6c22PScXrNPrM2j1DB8uqwm
 L7yTm/U6iCS4wFrZ+RG8hLGmQoPGcBqWVmfI5YwU8qJSGhSwB2TZm2X6w6r7FEH4KLmrPMZG0SN
 TdHw15zwRxXcMzy/j82RennHn+a6Kp9lYPWuzDdt6Q51yiD2Z1mVRW5lVGSRyZcr7Y6Bq2QNHQc
 N07mkA+sT1vGDAMWsCBG7HDIlVZLbHVbb05mJrYLJOdHLymkIy3JW2D8GNkkvPTUYU17JqIxAcn
 bZWANKBSWIBvj+rB7mu4+PHTphoOLzQYM6KzPwm96fI5BFLdK3NjLh8LvX47fEjE8D/eiZkBTvc
 04d5uubZH5SXPoPlwuQ==
X-Proofpoint-GUID: yYjLPG-sAv9y1zW36IdG8eAeTLTe3A8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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

This series brings a few additional features for A8xx GPUs which were
deferred in the initial series. First few patches are a few general fixes
and improvements. The next few patches adds support for SKU tables,
Preemption, IFPC and a UABI to query AQE support.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (16):
      drm/msm/a8xx: Fix the ticks used in submit traces
      drm/msm/a6xx: Switch to preemption safe AO counter
      drm/msm/a6xx: Correct OOB usage
      drm/msm/a6xx: Add support for Debug HFI Q
      drm/msm/adreno: Coredump on GPU/GMU init failures
      drm/msm/a6xx: Use barriers while updating HFI Q headers
      drm/msm/a6xx: Use packed structs for HFI
      drm/msm/a6xx: Update HFI definitions
      drm/msm/adreno: Implement gx_is_on() for A8x
      drm/msm/a6xx: Fix gpu init from secure world
      drm/msm/a8xx: Add SKU table for A840
      drm/msm/a6xx: Add SKU detection support for X2-85
      drm/msm/a8xx: Implement IFPC support for A840
      drm/msm/a8xx: Preemption support for A840
      drm/msm/a6xx: Enable Preemption on X2-85
      drm/msm/adreno: Expose a PARAM to check AQE support

 drivers/gpu/drm/msm/Makefile                      |   1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c             |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c             |  12 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c         | 243 +++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  89 +++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 155 ++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   7 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c       |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  33 ++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h             | 155 +++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         |  77 +------
 drivers/gpu/drm/msm/adreno/a6xx_preempt.h         |  82 +++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 166 ++++++++++++--
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c         | 262 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c        |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  17 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |   5 +-
 drivers/gpu/drm/msm/msm_gpu.c                     |   5 +-
 drivers/gpu/drm/msm/msm_gpu.h                     |   2 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml     |   4 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |   6 +-
 include/uapi/drm/msm_drm.h                        |   1 +
 23 files changed, 1101 insertions(+), 246 deletions(-)
---
base-commit: 38d568f154c66430920b01edc9c722ec14aa54d7
change-id: 20260322-a8xx-gpu-batch2-bf7f5a9406ac

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

