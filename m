Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E43606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H4SQOspO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdjCLiLI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B2810E318;
	Sat, 31 Oct 2026 16:12:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A016010E10E
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD0tRG1852258
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KnpAwYJakalTKmDuW9ff0h
 5zFEmFAGhrl/uCVIa7jTQ=; b=H4SQOspOPcIFuSqCRGnbv+gWCcxz9pp5QNxBVg
 Wt+7c+7IEB79lrGWRN1OtDvOZrgFGBf6MOHSAYx7wUZ2/maUuF0/H7V/sRDOry5h
 y/MmMEW2z8NpbxWrzTmABy5LndX4HWsLOiPL52/NY7dbG6LftOZlLqRZuSOahbAR
 WG2MRdudnYH4LIWKHVczVaD1re8jC51YNAuNupL5qTLhYPVI2c9ix00hFmR00o8c
 NBxXV2mJSs8/zK7BTqWhmFmwvuq6ny6YxUr7iUzeZBA5gMgJrKZSHyX2myJRIrzL
 sgwcw9TdhdIQOHMQ7+rAyOqiJ4Pav29lOWFUU1huGBVgPMig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfsjs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so468467685a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463128; x=1794067928;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KnpAwYJakalTKmDuW9ff0h5zFEmFAGhrl/uCVIa7jTQ=;
 b=SdjCLiLI9DiDSlQY3hj8RqNrAs8cgAr2MxpAionTClMHuGxd47X+icwXqXB/5EFCo4
 x4/ZElWetD14hX9XK3ni8xX9s88HKPAmes/LbCdeoT6l+qVZHl/Xb7l5cn51XUU5qmmA
 T6VbP5kMeiqmdWUnkTPpYTMg1spDyj7LltZPvf9KfSqXLL98Jl2JtWZWJziS/NTI9hdp
 MorXXkPiSXe7EADJfORpR6sss5lPALml3axGtDlC41rWaZuYEveFDmNDg1SEzmEQGmj7
 zjJq0HHXujndoS7ltqt/cW6TbJPvK8qSzn0p8OW6QoOvfEH81cqhkhWOblcnhvlegq1N
 oUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463128; x=1794067928;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KnpAwYJakalTKmDuW9ff0h5zFEmFAGhrl/uCVIa7jTQ=;
 b=QICK7Eq+MNuGNzAUvkWqk+W+kQfFKCmmwcZcDALUJlHrZ3zOhkan5dyRadEcWXDde7
 sPKH97gRxOJY65Tcra/grvVcHqQbzOhL6WmQns/sEKiS8Ldj4v4lrVwqz7ilRTZB5lWY
 cAjHT7hO1NTWK0OD6bJSY03tngO3LeUMSRYfrhfs6U1dqNQZymXUMhRovgBo69GOil7a
 MDJ4Q3TIqDWvSYazj+GL5ZJ7D9Ok9rlAIYR34vAn4zPQ0r5sXuJYpDYlMKNxF8RUWUnl
 JDqw589Pr7vBucF0nueAeoXfEFHG3G7jeqyJB+3xsuBeEmOl1kiz6/EmBM9gQCvDiJAL
 bMWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV2MpdEcouXF3d0meXQvX2htmDrEpTe+Un3vs+Ey2VdCCanYIK5YQzVG1nATaF5NLE0/HfNoXU+d8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLeM7kDrTVtrUgweERFI20o8Llmgb8eTwcWHAN+y4zM9Ghn5cOY
 JyqqUrmnzqTtT5pPr0Jy4XjdLvzPPCcJm/HCr66CHVOEBY21pv5Dm10AFXph2qPeV+WJ2qb1hmi
 ah8FzZLDGKKqi7EEaf/Tawfg2goWXXUnFV7cclPIORQ4msuuJBuZ1GUC7w0ql1or1KU+kJig=
X-Gm-Gg: AYBFou3Qnwc1rHJaXrfaou3K/PB8nhbX6K6NV9aNRcWpgHdNF5V9SRg5YW1GAN/6KLj
 VJdZtvP3NbJ5GYj4mol1wD7Td42jtEiBPjsJDmsYXOe3LO73kLMV+BMKJGP64egT4cvVmnjdt1C
 Ngl7zFMfExRlj9juMr5phMNuLVZK0WWEbKBauF/ZxNa6jdWyzYdZiTbmrCutRAUybnwWuUEpo2M
 wyLrxVA/vRg3fdzy+bXNvh+ANPWKfs1RTsaM+Ar7O+sUt7Fj+KyNXif+QjB0gYTKS6D5Mrd07K/
 uxhjBusXiyK5f7faCW/2WPNuuOIY67TefTNgQ3lB8ZkFkv3EDkka7Q95bSDVKAjL4Wuw3HJ+g+2
 WmmHa/9UfeW+R1Ty5RI0tuF0mFyo2kgrcoM3+VlPOQSOOAvXF9hMUfa+p7AKfZ4OhxLBBy0RO1A
 HD163zf66yVedzDICieHSv09q9byoh14mB0Pt2AJI2JZwynO2d2umiKJW1Oij90A==
X-Received: by 2002:a05:620a:2b89:b0:943:f31a:c0a8 with SMTP id
 af79cd13be357-94421630598mr826643585a.17.1793463127700; 
 Sat, 31 Oct 2026 09:12:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2b89:b0:943:f31a:c0a8 with SMTP id
 af79cd13be357-94421630598mr826637485a.17.1793463127027; 
 Sat, 31 Oct 2026 09:12:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0720e3csm666666e87.28.2026.10.31.09.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:12:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/4] drm/msm/adreno: keep the GPU timestamp monotonic
 across power collapse
Date: Sat, 31 Oct 2026 18:11:50 +0200
Message-Id: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYT5moC/32Nyw6CMBREf4V07SW0lJcr/8OwKOUqNZZibyEaw
 r9bcO9mkpPMzFkZoTdI7JyszONiyLgxgjglTA9qvCOYPjITmSizWtTQSVC9x9FBMBYpKDvBTep
 alnnDu6ZicTl5vJn38Xptf0xz90Ad9qu9MRgKzn8O7cL33n/DwoGDqPJCFL3iUuqLI0pfs3pqZ
 20ag7Xbtn0BHw1wi88AAAA=
X-Change-ID: 20260828-b4-adreno-timestamp-f4c846391b97
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2903;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iUPiR6Fwwwm76HjO6myts5MQhGFZw924ukeGRKJiGZU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5hNIjrJ7ma/fmE2HB2R3lfL6UedlIjnc+2MJe
 IRRC4wpS7aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauYTSAAKCRCLPIo+Aiko
 1W2cCACK+v1s3+d/M9djYv31k3HzpmIDFp1pDkAq4m0GtcmPbfhaA/6MtYZ2BP/Ssn+9GLMvv6k
 +HG+34ddyJk+yWdeKs57i06WrvmpbnQ+OKR4TlqGCJmWFkbLKAtGik0Rp9qk1GoB5OYio0h5zZE
 11DfzWo5FnLqDks8GwB2x8O3jUQDN94WmPebQlyUi1FZv+R3zgnrKz9lle0QuRWOR5fOoS+xodB
 DLNotlmoUndNv5D4GJ2Y7f7eGhD8EkTSqRjQC/evSxokz70qNLNTiFLUDy8y1MGKE7W8Fs17Ccf
 kjfHeX4D9N+FrW6gOFHsEBAf7HPX7NDMZKpD7Ut61dSkRksw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX7Qqfqf7lF0Z6
 7/RBcLxZxstNRPrKjwcJXkWUMj0zyo0rKZUoqAvKE5HUO9lbarzT7g17Mdo3skJeKGZxy5B0GLH
 l2AxIMqG0s+Fuq7L7AbKKjCLFfmYJPk=
X-Proofpoint-GUID: _dLqShk6kl3sRx4sgTa0TKbge-4wXJN5
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae61358 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Laz_JB3cWz3Dvis22pcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: _dLqShk6kl3sRx4sgTa0TKbge-4wXJN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX9w8w9PmNpF3t
 Ze+0GErTYC7yCfLviUBXE3ZRlJ+79O9qCxAonp5jR72+/xTuUOvgLv+PApF0Lywho2NWaXyI/iJ
 D9hSv9mn6eHArN0zBYPiCoC88SKTsURC2z4Hf97qq13CjPgQiztlz1gY/Mup6CLwYMmnxV78szy
 uiOK8AMSXKLB+UQFxBaP9MK/BZ/L4OArXCituTfZgq6mskhZ/zEnFtMmXPxxTr35sgf1apY/76C
 SEV5FtpuJ9YsVsGdec267VGkmO6RT/0rWwrmxT94zof1X1xdcHHZ38Mo8s8tQDWjSPRsMjBrVO6
 wHrr59wQTU4aZ/f7Tr9FQca6VTCS80prWtSqj+CbF/b29DPv2OXZEdymxnK1aOCYXu6c+NAlHS4
 TMH4t7cuHDyGdD8IrknwT6F+IMzFISfXGYDn0MK/yHPmlDUIYuXN1JNLsNkJwAsSbaZAP8HNnYz
 m4zq423xFVxgaET6BMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310064
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before a750 the always-on counter behind MSM_PARAM_TIMESTAMP, which the
GPU also writes for its own timestamps, restarts whenever the GPU powers
up. This is the case on the GMU-less a5xx and a6xx parts, and also on
the GMU parts before a750. GL_TIMESTAMP, Vulkan calibrated timestamps
and clGetDeviceAndHostTimer() go backwards after every runtime suspend.

The counter can't be written back, so keep an offset that makes it
continuous, advancing it by the CLOCK_MONOTONIC time the counter was
stopped. Publish the offset in a new page that every context's command
streams can read, so that userspace can add it to the timestamps the
GPU writes, and report the counter with the offset already added as the
new MSM_PARAM_TIMESTAMP_MONOTONIC. The page isn't mapped to the CPU, so
it needs no sequence count. MSM_PARAM_TIMESTAMP stays raw. Where the
counter doesn't restart the offset stays zero, so userspace takes the
same path everywhere.

Tested on a512, a530, a540, a610, a630, a643, a650, a660, a702 and
a730: the corrected counter stays monotonic and tracks CLOCK_MONOTONIC
across runtime suspend, and the GPU can read the page but not write it.
With the Mesa changes GL and Vulkan timestamps stay monotonic, and the
OpenCL CTS device_timer test, which failed before, passes.

For the corresponding Mesa changes see [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45806

---
Changes in v2:
- Left MSM_PARAM_TIMESTAMP raw and let userspace add the offset, so
  that it keeps matching the timestamps the GPU writes (Connor, Rob).
- Added a GPU-readable page for kernel state, MSM_PARAM_VDSO_IOVA (Rob).
- Added MSM_PARAM_TIMESTAMP_MONOTONIC for the CPU side.
- Covered the a6xx GMU parts before a750, whose counter restarts too.
- Dropped a4xx, whose get_timestamp counts GPU cycles, not 19.2 MHz ticks.
- Split the change into four patches.
- Link to v1: https://patch.msgid.link/20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com

---
Dmitry Baryshkov (4):
      drm/msm: share a page of kernel state with the GPU
      drm/msm/adreno: add a timestamp offset for counters that restart
      drm/msm/a5xx: keep the timestamp offset
      drm/msm/a6xx: keep the timestamp offset before a750

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 13 ++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 21 ++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 66 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 10 +++++
 drivers/gpu/drm/msm/msm_gpu.c           | 15 ++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  5 +++
 include/uapi/drm/msm_drm.h              | 25 +++++++++++++
 7 files changed, 153 insertions(+), 2 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20260828-b4-adreno-timestamp-f4c846391b97

Best regards,
--  
With best wishes
Dmitry

