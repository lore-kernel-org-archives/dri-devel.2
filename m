Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BF606A893
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dE9/VK19;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TVPYf262
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB94410ECBB;
	Wed, 11 Nov 2026 13:05:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB10B10E4A5
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCYvFb2356424
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6ovnIEyc2J8D+ybmpj/3V5
 WAu/+92pfJIfGhuR0QfCc=; b=dE9/VK19NVGmAophCknixC+JA8zw2F7eBn/a3J
 z7k3NiY2sd+Tjoek3WhPYPUeT6hZd2kclK+u4k2/WVEzmM6RbCBqGeWj0B4EeGAw
 5h9cLlDe7dzyRk+/esLyeI0NN7dh/jCZJ2dUiR30RqHM1PbBivhEQX2atQ/s8GA5
 VMfqUfzf32fMLRLPnWXzRyTP6jHoXH4rp5LEzra2rH4GP+cMhQ2OJ2pbqx4tOQLF
 ohil2VuLREnraiVT4ubFAQQYr4SXnu3pBt0TRG82sRbW9hQvAE5XgJeMbm3UFS0n
 F+0GxnlsuzH7EqvNh4OAfGLodOFeAAPfhEmqN5kROjpYBhew==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdhx48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:34 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eac41ff334so2901241e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794402333; x=1795007133;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6ovnIEyc2J8D+ybmpj/3V5WAu/+92pfJIfGhuR0QfCc=;
 b=TVPYf262e0lVvEodTk+BeC5cFPbOAX2QoWU/hrEFyjILGtPr0bKmgXnHihZSsAboi4
 GcUVgnPbQD1HianxSo8c3yHHDqDB/5Db9yFyWZ5mzJ9FvUco2JWsuaakvuR/waRBWHnC
 0TxLONnMFMyzGisdTauoh4uMgbXbndXPfGbuQCIkDtBrF9T11A3MkccXFg2Mx7g29faN
 ZOCu1on4cfdVMPVYhkdWqWKYauLjZyCRVL2ulBntUnNamO35tCNQMrh5Q0w08sPoEddH
 YomToflX7gz6UH5bsEZp2RzkRtelhpCVYJSTv2HqgUKBCxDGoHtfIe2wTwNLj3sPkFgu
 GRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402333; x=1795007133;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6ovnIEyc2J8D+ybmpj/3V5WAu/+92pfJIfGhuR0QfCc=;
 b=p3h0Hi1fGNgSw8Du3WejVKzb1IY9Ge6LTSo/LwSUjI2NXVn04uVc5D6m6SjK9tNQoJ
 y8zXHNu6P/vTpkvqStrjTXgyjcoIK6HjKspiu82JCRjlH4MPUkk9qr5jD3vlR2c6OIw6
 NXSRTCmfWbTn1kZdTVEd1dg5afbv3jfCXh8Gel3X4O/aEUVsobgx8Hh3PeaPWNpcX+oM
 pxd2hBrac4WtzXYFf2L1w1LoGLhcpd3W9ohy3JGdX4Jqcc7pvFl3sZMGgm/nhXwGbgtm
 N2c1oolq3BZzUrlq8OJvmwRevjAGDiBfysYpAcbj7m6r3zM/lvddZaqefceP9mXXzaIv
 4BaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH35VQTui3k9rx3LlqrmKQfPekv3h4PmmzRNKEL0MeaO5Snv64y3fBshiwKuDkVYok9YrSiDdEapP8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80gLlgscVf8tDIGxizBbLII6vC7J38lX9fTX2WqT0YkgaWvHsO
 coMGRUVkxOFlYbFaaKt6HZ/yv4/c9TytjHaF0BxAs9ExYhfbDnellkFv3Hwh3BNBOEZObX39g2H
 JVfRrmJgXOXBhOkh/NC/cpEJ6a9nbh5O0HMGTK8A/caG5LxMCSA7fQXxDN3jto6XyJ2o4Mr8=
X-Gm-Gg: AYBFou3flTWAQiFJbySxfAytuqefadwC2aR5LpBlag7Vgl3DwmORyatmM+q2jKY71C2
 bGXLBrOsmVE+0iqig+HZy+ZeQa2Wi/JR+pdfRI2MVT+kM1PYRMKJyv7D60/N9JM4BoDUcf5pUJ2
 UhHcrRR5vTzPT46jPKrVLy2d40Kf273OmS0y/VsDXqABp9Y3AbF5ZzXD5obZQwS2xuSZOmqQXLL
 zzXeB+4RhoI1LU/zs6bQ97sMIk5hcRFL8/EttIkz9bfdbKbk5c+bYlblRboopC3jLfgBgLRRY1a
 iItdaKonLzIkXcA8DHm/xDbbtJ/IapKZMhaLKbbn0bsk/eVgUyvyfG5weR0T6Ff7hk6kdnSAbxV
 zepYoECVRzcqeFdSBHbE+gxnBkZc9ijnS1EszE415GGq2ZjwvDl9xZ1TXS3ivLHu0fqEaDPWz7U
 ey6xkf8M3s3m7AzqLb9f9l60k+m31g9pesr/SbeM+fJnbjznfF8Zq6Cx7Ca2CinQ==
X-Received: by 2002:a05:6122:1d12:b0:5e9:176f:a548 with SMTP id
 71dfb90a1353d-5ee1bf5e39cmr747000e0c.0.1794402333321; 
 Wed, 11 Nov 2026 05:05:33 -0800 (PST)
X-Received: by 2002:a05:6122:1d12:b0:5e9:176f:a548 with SMTP id
 71dfb90a1353d-5ee1bf5e39cmr746924e0c.0.1794402332787; 
 Wed, 11 Nov 2026 05:05:32 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15d368e81sm391858e87.21.2026.11.11.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:05:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] drm/msm/a3xx: follow the msm-3.10 kgsl CP setup
Date: Wed, 11 Nov 2026 15:05:13 +0200
Message-Id: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlo9GoC/yWM2wpAQBRFf0Xn2SlDefAr8sDMxlEuzaAp+XcH+
 221W+uiAC8IVCUXeZwSZF0UTJqQHdtlAItTpjzLS6PjtoiRe4k8g7veFCgtHKwjNTYPfb5a3fw
 cjm6C3d8E3fcDbhvg0W8AAAA=
X-Change-ID: 20261111-a3xx-fix-me-bf13e6cedecd
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DUAj3e5OQiOBNMj5siOdfFBEyuSsNIZAllewi8t3uIg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9aXDP4J/157b1z/K/PlrU3VvTt7QierN6Rm2RvvcJuUa
 WK7Y5FxJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmsriW/Z+yh5iDxGs/3Qot
 pbUqMWrWi55N5V0WJz2pc6r40hqWxfU6b5fX3Z26sICpuEsgxLpNZD3Tt+kTBf8zMRSbaXf0Btg
 YuyzdL1jz12n6im0/ndQXn5CyreEUY/F/+/KzvTRP1Lc/138m/ooN0TRU2TfxbcdxuePNKTcy/V
 YHZ0fs/sCnVrYp0N1d3fxmckese+sHVTP7o8+/pCo9bQjaJ7MwcK/aCv5MAe9JErsnPTL9WuisE
 ffwwH6ObycnfP/8Z2ULa/QzZtfK4OQgvvKrD6z7tv1RjnonV9t5ivPmlGv5G3REv/3Scghe/Uo5
 1Z558T9jtwnWn/2OSU8wXnUhlrV4epxulZVCVaXw4/2HAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af4681e cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=qa_B_Q5AuH6_wmrwAUAA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: UeavzyU7AMmmpBA0pxTjZ61jORSyhtuI
X-Proofpoint-GUID: UeavzyU7AMmmpBA0pxTjZ61jORSyhtuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfXzZRu5Qz2FeCd
 jt76OFLk7RbwcvdEu3+WfIgvfC2ugZcjzCGZMcDLOz8MI6fIVAklb2bz7fJ0oRCMrAl5gtQm+q/
 SmNHPqKLe56BotesLJS0u8ET3p9tmxVtDIMNUOdT4L5OKjFcVm2PFfKONQ3fCKQdSdFZYnn+3g+
 77nWlM3MrSYN83hHmvra2VgMwuSgJWQ9hzxuonfhRJBoGDFoqRNINevalt8OcPUWWBE8YM71Kgd
 9ry+Hgw9kbanYQ08jYk/xTKwDJq/TNDoRzpkPi2KHTyvPKUkIToTq/Sa0jrWgn90OMbkBuFZNrb
 KhrLEQ+6RA3TgXY0ohlw+nw+uu/DbH0Cz6TvV9HthLg4GRXTjtYZFKkaL3dxzj6Fw2GWuHSk5QU
 IrgnnNHbIP1AOT4oAs3yaw9nIDEcNcQeYcgpVU2gONjw0rGdTpeVTL0YGQC2rXZa8rxZczhBbVS
 uZuyatsh80KD1ecutiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX2ceswnOG10sF
 xRb2P9br8Eq61kHSZ1ogJ5GDSbc+SwmHWJ/xA1uHZNlMbfHZNlZhwFfIkc4EgY5YZP1bfD0/Ah/
 FBQL8vQEQWpT/a3cSDRMfvq6WgGrL9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The a3xx CP setup in msm still matches the msm-3.4 downstream driver,
and a3xx_irq() silently acks the CP error interrupts it enables, so a
CP error only shows up as a hangcheck timeout. Report those errors and
bring the register range table and the CP_ME_INIT data in line with the
msm-3.10 kgsl driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      drm/msm/a3xx: report CP protected mode faults
      drm/msm/a3xx: update the CP protected register ranges
      drm/msm/a3xx: update the CP_ME_INIT data to msm-3.10

 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)
---
base-commit: bbfe1d58f42ad2cb56a01f5717355901698075e4
change-id: 20261111-a3xx-fix-me-bf13e6cedecd

Best regards,
--  
With best wishes
Dmitry

