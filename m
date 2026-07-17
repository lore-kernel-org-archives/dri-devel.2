Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4115C44524
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8674310F602;
	Fri, 17 Jul 2026 20:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLaCAxa0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iy3R288X";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869C310F5FD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtOvl2751689
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nr8Y2kLGOAQ
 fP+6If92MLZogonNmCXdm3m2GqTYBhjE=; b=gLaCAxa0DW+ibkaCzTzroerrr0H
 Ymr6Rx48d/TcAGbSzUXU5xLAyTnM21jrvrRk3fWEzG5QVbuS0TlqAckcDBSFl9AS
 Zrh9uDnACNja0Z6NHwGg66o9B2/0IgVc7iTbTR8h3j2Tw6uzEbyu8NnZvnZAuKGF
 g9SFi/QWljv1QFYV3BtCipl0aDnIBFgTHYGs830wO+5N7n2KgMXXuzkbx414O0Av
 +0qT7ytiKswd96W+C2erXJ0m3OYX2MS3yCzXKDiZdobSQKoG5VeMglxl237U1hxp
 xbEgp8sk578SIJlETcDbWF48/m77wrrg1Pwl+twbqMbftIQtLGf50A9zRHg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug1awa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so169309375ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321337; x=1784926137;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nr8Y2kLGOAQfP+6If92MLZogonNmCXdm3m2GqTYBhjE=;
 b=Iy3R288X7ziI2oVDaJ+mMJ2w7ReRyq790cXtJf0CZ4S3IwwCW1ytEcG0xwlXYVk52l
 KCGyDYsL3wXUPgOsPkAb8d4WXD4fu/ol3IvNYpUOvp7dTAo4Tj+bqf8bqzalBzCCuVe3
 fklS9OPbHqU0w9ohGU0t49DfHBlSI1R5l6dnftsyMgh++8m9d7JTDUj8/oTPCYFi8kQc
 VTfVJiBUEibVjfnKKifEPyIy9b0Nx25AcYpCf8WKS86sIn2x7FbmATgXdNWGHngDKePG
 KDa037FskiRUzhYEENjeUOaVX/cxN1EZhsINboUFW5w78lvSDlFbtZCdS0m6jyR8ASRK
 /mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321337; x=1784926137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nr8Y2kLGOAQfP+6If92MLZogonNmCXdm3m2GqTYBhjE=;
 b=ZJhQF9B6K+/28SY71ytJ5IniiHhFoqwPF00ZNHVi9dxBhLWehuxWj9r300f19mLMqF
 vq1pGqzNpx+RlyZppsfazRNnAHQ8/2Qo5MjERxV647XCA2SvmUnntRqwDwPthPmIWSrq
 mCkplrIVyIJ8D0yL6eTNxKLGzU+apONq2ba2dA8G7meb+QtwKap2qE5LG76uUVi9HDmZ
 cAFhOp5ECVNFmkJyn78D+T12Un5/g1x1tjFE9O689Ka5yD4l5O6P3xBATiZX4fWN0Eyx
 44oRBp1s8+14h8y4iYkjjS4QT/hTOnXPSqQRb8vMWApQ827GZ+azgAPqILwGTiKVv9iV
 g0jw==
X-Gm-Message-State: AOJu0Yz7HhdPO4XfFuU6sP4QMxV0kIXGhBxkm/pkcoLLSIicUFkUk1SH
 ZkbIBFe17OC9hKAXXQJ17DnTYn1ZOwmXVgdyBzegJ8dGum+OMdHyVSlfv4fskBj7ABnBzGKAAUM
 fLMyPSMka2dEKC+r3lnRZOgkv6dnSbNhWgKvkgT+so1yXxX9GHTLY80S4CCLHNSPfrQi3dGsYPp
 Xz+v4=
X-Gm-Gg: AfdE7cltDnC3tipg+6FgMepeM847xcwMGUniQmoQKzJAszCa1Fjsk5eCdR8FP7RS1Yf
 Yt+43VKYmrfgCA4DdITY7JbuF1cRnuK3LGOgRspK+UpCmJ1Hbn/cX4c1apYHwtBGZYdMI4xWocj
 Zerx/U8GajvIW/ah2mFomhxAiqvi8QYpkwV8snjnucpzaCqKctfz7O8d0A4H+gS1sacYgTKlepr
 ybN8SXYZGkhk+GgK5IRvpY/mdkExlKMSc6i0vq71N4uEBhClbl7uqhVIKq7+p1kGyx6n+gRTFo5
 tCq7z/P8IX8gy7HfPVAAhRQ63wkMH2qRkyIBcNU2e8jpGJeD2aX/8ad3UVYgReGShhzbk+2Qb85
 aZTdAhbE/ZaNwIzzqe2naZDC9aWkM7RyYaostJCBSF/qSnWU=
X-Received: by 2002:a17:902:ce84:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2cf3484be47mr48915395ad.8.1784321337344; 
 Fri, 17 Jul 2026 13:48:57 -0700 (PDT)
X-Received: by 2002:a17:902:ce84:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2cf3484be47mr48914865ad.8.1784321336552; 
 Fri, 17 Jul 2026 13:48:56 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34729df7sm17187575ad.63.2026.07.17.13.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:56 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 05/16] drm/msm: Move nr_cmds initialization
Date: Fri, 17 Jul 2026 13:48:21 -0700
Message-ID: <20260717204841.26120-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXyU7IotW9pPkR
 swMjacpRLJAYVfUMYbzRt1mJLSL6tT67K7Hc2gdY9MzVL1rUTXRsqecjCQa7t1yYJszaxA45tpH
 DfeMhcokj+dUlYIFe64M82zCFBBgO6M18uEXvs+YRo6r9OFKmDZKlDknetpipBXzF87dnGYnJj1
 Kn4rvCYIHB2Ne82pFwuin1zdPXeaoHadviRsvwdc0Jz/+MPy20a7wJJBYgS226zTBlvftV5ldPC
 vPulcJfvsyxlOqRxjvSzHnnRb7XRjSqooHBj2xd5Wa18e3WkWB8Xxqf9uGhCvnfSCREK6rrIq1S
 r/VhlaifZTvhEoTihTFQQkeGPf8BnnqpQF3TznJ/DOWlrSQzG1oo60pHsmq6W/V4AVCLYsq5xmI
 fmf8Rj2yKbqBD6CAcq/5mQypDkUmpCmQTbN1iWk+ABP5wO/rhvarPliw98qMX16VAZqoqauvI5Q
 /ue3autB5c3RXMb84og==
X-Proofpoint-GUID: JYlVUMujVVfoHw5WdA8ukvFcWQHuEzjt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXy00YnHb3NVGf
 2Yct64OTHQVZo0f3jGqB6GHfgv4Q8G9+wxHMLiip3D4TQnlFl2ieN1dThrigWkR/3eE4wJWODVj
 KyOLGUpOBzdPL6yvcjHGs2kVg8T5PXE=
X-Proofpoint-ORIG-GUID: JYlVUMujVVfoHw5WdA8ukvFcWQHuEzjt
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a953a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=F5a-vUUdUzRQ_IYq5r4A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

Previously if we entered an error path between these two points, we
could leak the relocs tables due to submit->nr_cmds still being zero.

In practice, relocs are disallowed on a6xx+, and non-ancient userspace
will not use relocs on earlier gens unless running on an ancient kernel.
But userspace could use this to trigger a memory leak.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c6bc90c3d48..aa48ea4e7f58 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -260,6 +260,9 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 			ret = -ENOMEM;
 			goto out;
 		}
+
+		submit->nr_cmds = i + 1;
+
 		ret = copy_from_user(submit->cmd[i].relocs, userptr, sz);
 		if (ret) {
 			ret = -EFAULT;
@@ -719,8 +722,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			goto out;
 	}
 
-	submit->nr_cmds = args->nr_cmds;
-
 	idr_preload(GFP_KERNEL);
 
 	spin_lock(&queue->idr_lock);
-- 
2.55.0

