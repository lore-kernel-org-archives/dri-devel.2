Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06734C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DCE10E1FB;
	Mon, 10 Aug 2026 14:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpAMESP9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UsgPQkCn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9D410E202
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACiebo1704545
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zxqhJG+46XP4U4QelHuaFo
 OC2P3agnUHF42PXfBS3WI=; b=XpAMESP9n908IPHu947b12Bsdz2BREv7xJjkq1
 M3rZwDXCp+FBLV6Rm2JhQit7XzeMRbZZXKBnaUclwygxoW05+JAvYfXfNx91QFfH
 vkyIp+V9uTqlbwYvsxxuW/Ix5pKVIEWE7qiH7mYbdDswT38uLhE2mV2e+aJAzZ6y
 DttSM2tMJFt88pLUsq9da1UE+m5ryWqDgejk7jQbAMEuhJZYCU6bT1ymKexbq+xg
 SAFmlcdSPjPys1GXycjAkLH49vgJJmWq8KSg/iaSVHaBpxWZhUGT+JvzAKnnasNR
 OkHHKU+IzF6EE5Jhf74bitMEAJA3NIV/GCxgr2CaPTDUe16w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fybh59evw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso17958106d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373510; x=1786978310;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zxqhJG+46XP4U4QelHuaFoOC2P3agnUHF42PXfBS3WI=;
 b=UsgPQkCnLTFe6RepX16KEhEVBuNQSZGSOO6dFKNN60jwEvlwiIEzsRo6yi0QslW9tP
 86iZ+LdzGpXGOelHrACuy54v8I1kXU7UjJ9GPKAEDZ5ThR4mKU5DDpD79Egy2qNHZx/c
 xj/ENUefzsMxeL1oYYbXZJcY6VycxG2poI8OWTMq8bL1r2kSjl98pBG84P54Wl/aBy9o
 WBKOTFjmu+3DJpHYcSSx9KBXkGi0oVUdQlabEktJIoE9RVOvgno7UUAQ2Tpg3HpETyDk
 wsI+3kzhhVwxLvvpGcImbwNCDBvhAbll3FP2b/dhNnH+KIYnu2Z3WE0Mxdn9p23uXX2O
 qkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373510; x=1786978310;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zxqhJG+46XP4U4QelHuaFoOC2P3agnUHF42PXfBS3WI=;
 b=qVklVxIcGKc1e/6kyiYLQFJOWaeq/3Z5o/hd3O660hgbmsTZlrxfMNa8gw69bJeHoB
 kE+0eWWj5nSlrzG+m1d4KfGrwDwKe4IBboYtEJpJgjyPH8R6ShVI2IWDpVUwlIsUV/23
 trXyBnG7O6LJtb/1TMV9EqG+k7T0uQhtVmDDrxUa6wtzEWwfmMj81l5eQtRyLHxwbvnM
 DRR0AVld3N4+SEPV/4dw1bWyY0FeFRCJkEoJo96yJ/37TVINlZrzL4cf2ghEI3vxijZT
 EU70e77+pyzXehNPbsrbFagDD2xFZX6uwvXK0Tgukc70TpfFTBp9M8sPT1N0VNSL64NI
 IT4Q==
X-Gm-Message-State: AOJu0YwlC9gUkyqu4BlQLDtZXvW1TL8sjvOSFG00rTq6Acto347jF+Al
 icMiuyjeLi7R+s1EyA1CGcMTCzmsWLBul0ydk280VgLO8r7LR7HQojQmZ7gtMciiwgQyGasEIq9
 HpMySDITx7XGHkZMY6a8zxOnMnYF0go16aA2gly/liG3EUKiuv/90reJ5vseKq0sGUNlXnQM=
X-Gm-Gg: AR+sD10Gly4iQkyRLyZ24fea4dtvIex3aPmMZacbNHQRkdTecpGNSXl9BJHRjaYcPyc
 ADen6peQsxdVvDAa5fUhNYhN1WHc/C6hkv0ompGHKAxr5DNzwrCuVTGpVtUwgoMK+C4vBYmwere
 C00PeztTcqq/rHJ+XDCM0/6BbNuhc73kJeVF/CPULj20U3zqaegzG14rAr8xlhGwvkFBxu1HTp4
 /Dn8wn7LtApBu7WfM9yFUA1Peyej2OCGvT4lxFOQ3sXFqahPU1BoBTbbsbfw8D4t7em5xAK0LTi
 wLF3KlwaaMWYMdtO4usmj6fsZs9JOApC3ifO+jmOliIT1O5WpE8IenJD0zlOoRR3uJVndYrFOgc
 qxW3fZCveyIdD9d6BIPM8p7/lxGk5JXdfQ9MSFm/mtsoZe1g01bIUQ4p+W1se5g7mrZ/a7Q9xev
 oJH4wKuXO84LOvAg==
X-Received: by 2002:ac8:5907:0:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-52d20960822mr231815891cf.16.1786373510457; 
 Mon, 10 Aug 2026 07:51:50 -0700 (PDT)
X-Received: by 2002:ac8:5907:0:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-52d20960822mr231815361cf.16.1786373509999; 
 Mon, 10 Aug 2026 07:51:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fddd6a796sm22489661fa.36.2026.08.10.07.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:51:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/4] drm/imx: fix TVE / HDMI coexistence
Date: Mon, 10 Aug 2026 17:51:45 +0300
Message-Id: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHleWoC/yXMyw5AMBCF4VeRWZukraC8iligg5G4pEWaiHdXL
 L+cnP8CR5bJQRldYOlkx+sSIOMIurFZBkI2waCEyoSWAnn2aYI9exzNzCgSqQqTFzrLNYTTZil
 sX7Cqf7ujnajb3wrc9wN7Z1CJcgAAAA==
X-Change-ID: 20260810-imx53-fix-hdmi-03129d798678
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=n0QwEGmm9QPFYqEaWEPfuhWwBfoE4E6XocGYB82nrkY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeeWD0drxB6zJyouBN6QZVzN8RjwVSKS4JXKly
 Mt49RWAqPCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCannlgwAKCRCLPIo+Aiko
 1Y9jB/43j39n7WjjoMAQDWUq589TaOBcT8q1aNzDUtM3ol5l786d/QI0TGEFznYALxKC97mF56N
 Kug2nJmXQf/kJM90Hp/mhuIZHbvRTFtQGm7t2TspzdZ+9+CUVQVEw2D/Avr6u24qwjgkp+Iegky
 7c5+9hXHjOC9vMYPo3Z3v47TZCKp9g7eD8AxFloZlpaFVg5BDLKI3zaUTj/zYTHkytQVTWLM034
 RMtR31LoM8xSE4MA7+lhJT9Omo8cDnfNb28GJePn/vECpbvX7Gcr1We0e8q0+ixsQO+UEI6iOZY
 huAzUDgnPWuQzxRI/HFK0w+1nPR+QA0fNkmtRF9B+edPkoJP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a79e587 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qhRTTLL9oDwathZehP0A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: jYNkanq-_ltkWQc0ct8-XU-k0lIEkd-d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX/KKa/tnAFtRJ
 b1gUnDYZQRQmX5BuM+XqL452lZBPq49Xdpr+lXwZIxG34Z7H0WUe9D/uXPEkmpOTfpgx0tYg0W6
 6bfnCyaB6n942QvrwABqWOvIwYSSv0w=
X-Proofpoint-GUID: jYNkanq-_ltkWQc0ct8-XU-k0lIEkd-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX+C5E0/ZpV6kx
 LrEVE0Bk56wrQF7bxH19jShrmgsUuVQRPaxubbVE9jpHnXoFravFqQVvS498ma4Dyj7qKkC8Hlb
 PfRVKeyYshMiE71XBcLhPEGPOQPxoV974EGJE+OertZE1duhGH218i+Sr0macoxl1h+VgxzHa40
 IHrRtEn9Xu1HcGtb6dxYQt9UWl+QemreURtU5M+p3w00tp7hxZOn6fr1WNO/IgQK+z66KRbR7YF
 W2YEesvxqhrh4Pzs44B02AsovwoosvKCG8X3CMZFRFqzG6xIzyiDyZRW8yiL7QB//FAer+tTpHC
 a6IPrlcofIZeLv92RAShxX0IBlHyBeBcCZbJdjqYmJtM4EO4D9CUJvO8LPdmBCMRWe2Dt8UHo3f
 9MDzxZvld4JmjRJY+ENVfyLpjXEpjE86bK05X/K5XOJxdbqiUi3Rkq/QhLkIxAdWoZe1XnYNJPi
 Gg0SCOAgAh9uvvD2R+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100128
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

Testing MCIMXHDMICARD on IMX53 QSRB platform revealed that the HDMI
output is broken. The TVE output (even unconnected) forces the PLL4
frequency, breaking the frequency selected for the HDMI output. Fix
those issue, making TVE stop grabbing the PLL4 frequency (by correctly
reporting if it is unconnected).

While we are at it, fix two plane-related issues, which are now reported
by DRM.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (4):
      drm/imx: ipuv3-plane: do not advertise separate alpha formats on DC planes
      drm/imx: ipuv3-plane: add the pixel blend mode property
      drm/imx: imx-tve: probe DDC before claiming the connector is connected
      gpu: ipu-v3: di: report an unattainable pixel clock

 drivers/gpu/drm/imx/ipuv3/imx-tve.c     |  1 +
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 49 +++++++++++++++++++++++++--------
 drivers/gpu/ipu-v3/ipu-di.c             | 16 +++++++++++
 3 files changed, 55 insertions(+), 11 deletions(-)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-imx53-fix-hdmi-03129d798678

Best regards,
--  
With best wishes
Dmitry

