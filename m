Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97583FB5E81
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F7410E401;
	Mon, 16 Mar 2026 22:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4lEHNXz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XCA+rk36";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7957910E401
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GGRMlT3124561
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4IbsLGrI1KKIjHx8jj+lvuMaQvi9KqTTUAq
 216gBs4E=; b=c4lEHNXzOMMt6Tsnrcv8LX2gDNa01bQ9WGJWzrcpWAwL8MrFHat
 8HAObURz4QPkv7sE2VBirGtBLz83IWik32HUQtRnH/3uaGCyU0zUp69xrSK4Hkxj
 UQTS2nScvde5/iCi+5Gsj/TBRbSkUvlgGduDKwfBATFAweadu+REEmu4whhOL6N6
 UVpNdKMqAWf91/11Wf4SWMTAVefTmoy7rWzNFluNky92zxhcIl+MeNbb/Eag2ARE
 kAaSFtA2OKZGOf4kC4XQryTCBSRN3xyXTLS83XKGECezw85d/nvVxjG8rzadSDcu
 ydAuS0CmTWYki9/waK7WBgv608mXq4yfipQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxfsmjhse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso26867001a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773700741; x=1774305541;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4IbsLGrI1KKIjHx8jj+lvuMaQvi9KqTTUAq216gBs4E=;
 b=XCA+rk36Zv8CNj3HKLI4qOc/LZxob1zkoqXmu2ZY8pah2158CfJtiXlrMumzKl5hpB
 kPReoYEymOWL5k0krnfVcNG9gS+Hg4GDzqbuMyVoNiPU0ynxCCg42JoUISgi80Qp/+r2
 i99l4COXXyfPHUhSV6I7nbPXTT+JIWQWqPFcda1ODjIIb15gn8+g/R8Bq1DxZeWDBxp2
 KGklZbwJmRnR1dCF8rwMTeEebTLZFf5JNafZe5sf3A2IImqGQ3elTvK+bL2/8JupdICR
 AreSkcpL3Zd8TaYyiOhWf4NHmf79uJ5cf2VKNWiN0MRXeAHEYU5kjMGze9HoMwb3GQ2r
 chYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773700741; x=1774305541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IbsLGrI1KKIjHx8jj+lvuMaQvi9KqTTUAq216gBs4E=;
 b=jqN6E+zL9J0t/Bz8nTEYSGHalzAzlbYQSkcskWcUo0k7TWT2jEW50R+IbW8nabYdf3
 zf69WO85Iw0MqHBPQlbNOci+VpOn+odZq+Kq657R0wagb5eb5Uvx/DiQYaX3RDswuWd4
 IY2aia0rtZPCI1Rq3m3u2FDdn6nlU0slbr58p/WNoJJbgtXthIq21Yd78zhdLZtUtTOx
 vB2u1vP0Y6IQrwN5mCflNpdwqFhi5lB7eo8prJoHcyLmtYrlA82CvJEQnWe0Se6nG6fT
 TXhBEttjRnFPxluG4+NBFQxchNU3efJL1aZY4T7nrh39oM/i+yXl+wOwznvaAeJGchRZ
 1JZA==
X-Gm-Message-State: AOJu0YyhYDBsPdgV3K3Dwqvt/BC4BEhHmn0R1lKj08uEqNltXeaLQC1I
 aVCL0DZZbrfMht3Igd8OAtap+k/BtdOfBr5AnAps8btR/LbwOqMr0ONGAOaArJI3mD0MR+ghG/Z
 0xWl/w0/gN2LRNJ0x1UXudHJhiDhbCo4Cp6DnPbZ/ZQ3MJYTpgemge4+2d3jfYWqnayDDaeDi4X
 cTZZk=
X-Gm-Gg: ATEYQzyolnEC20Xi2h84DdKS+/sE8Tpt61cbVR/+KBy1jSb5F4HUo0yfg1sRKW/X68i
 Nno3+pUXHjDbgyw6CbF3+OpPxWHZm2y3R7JtHkiKU5R7ee3PWt8MD0oo7vhNWY7pL8vPKQr0fE9
 /7MysfMG3Wz53JADyvnhoQkQVU09SWGicEtxNNo/GJA2VFUlwqIwKS2J5hQs2+3dOws1MlnJbnL
 4l4t7Rc3aiKtr96V5RP6LeT4U+LPyJ3UpnVRXJoMbEm+j9HpLUAKmirGyqF7uCZGIwBTLaS58XZ
 Q24RsOK/8Q63IIJ4TBZu/Qk7Czrr6rdtnfIeV61QpAJF9oz4pHGU4S036IXT0v6XxS5X1CHb7Zk
 Asp4nRBYZm8xjKCLq0KMW6b+lhKJbLHeN
X-Received: by 2002:a05:6a21:398d:b0:398:c4e6:fec1 with SMTP id
 adf61e73a8af0-398eca9c789mr13168470637.23.1773700740991; 
 Mon, 16 Mar 2026 15:39:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:398d:b0:398:c4e6:fec1 with SMTP id
 adf61e73a8af0-398eca9c789mr13168449637.23.1773700740490; 
 Mon, 16 Mar 2026 15:39:00 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a072612e2sm18573605b3a.21.2026.03.16.15.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 15:39:00 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [RFC 0/2] drm: Add sysrq handler to kill GPU
Date: Mon, 16 Mar 2026 15:38:48 -0700
Message-ID: <20260316223855.711574-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4NyBTYWx0ZWRfX+a4GhwkuuZC5
 3tPTsMjkdMWJOl8miIccmc7sZXdezzseY2FNyHbEdMAZsqwusl+4RCo03rXU8NK0K6fcuIN4RJL
 A7HO+kFuzDwZ4fMLcAJUeVqw5M5o93z4q836uZ1rCn4hvF0YA3oSO8TesWDRJfuWs1ESZ0JBZt9
 /ze93ePPr1OLt92BAizNLbEJOX9HjTZjwwLEM1g6/TewBtoYsUMIt9JjW37dHTiXzKXkfa3xajw
 GMIsMX9oAFOGS7z5Ko5pBcoxoWZHYrR1l4koFlEoiBrSTW3WVvjq9112S9eTQ2vA+3GLtsijda1
 1joTU1KnSxf0raWY5ZQCbib1XMsTnEGpP2gwpRGGxB0A6MSBRio+XsdfcRiqJMQBm8IrLRnCcaG
 Gc+fKdVewju3Y5RyE20MA4ThNJqvG5UvjoUmzrtuSBOqqwSaM1+qxevUSCOOU+5rhppaS+Aoexw
 FKQIjPttQ++tADNIQyA==
X-Proofpoint-GUID: krpcLvIorHUeuaMpHiFYBpfqXnRlWdK_
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=69b88685 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=zUJ0Y04Mm8-B5XzwJDsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: krpcLvIorHUeuaMpHiFYBpfqXnRlWdK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160187
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

Depending on contraints around preemption (ie. on what boundaries can
the GPU preempt) and priority of other processes using the GPU, the
compositor can get starved behind a long-running job.

This can be handled by a hangcheck timer that kills jobs that run too
long, but then there is a conflict between legit long running jobs
(opencl) and UI responsiveness.

This series adds a new sysrq key handler (SysRq-G because SysRq-g was
already taken) that kills the current job running on the GPU.  So a
longer hangcheck timer could be used but the user could still reclaim
their "hung" desktop by using SysRq-G to kill the background GPU job.

Sending this out as RFC to see what others think of the idea.  Possibly
the driver implementation should check how long the job has been
running to make sure it is only killing a long running job.  Possibly
we should kill the process behind the long running job, or at least
mark the context as unusable to prevent it from spamming more long
running jobs.  Etc.

Rob Clark (2):
  drm: Add sysrq key to kill current job on GPU
  drm/msm: Add sysrq_kill handler

 drivers/gpu/drm/Makefile        |  1 +
 drivers/gpu/drm/drm_dev_sysrq.c | 67 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_drv.c       |  3 ++
 drivers/gpu/drm/drm_internal.h  | 11 ++++++
 drivers/gpu/drm/msm/msm_drv.c   | 12 ++++++
 drivers/gpu/drm/msm/msm_gpu.c   | 18 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h   |  1 +
 include/drm/drm_device.h        |  8 ++++
 include/drm/drm_drv.h           |  7 ++++
 9 files changed, 128 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_dev_sysrq.c

-- 
2.53.0

