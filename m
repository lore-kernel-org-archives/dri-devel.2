Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BC9C44538
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AF110EC71;
	Wed, 22 Jul 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDcDK5Nz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aFfhgEcM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477F010EC6D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53h3n3917564
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZiBIsylPCkNax8ix1SjuSMzRFBkg3HmZWMUJ4ntbMfo=; b=SDcDK5NzOu0F0wCC
 GoJNcV1rxw/IqBHHa1n7PGIYUAtlVSyG4fj0IRuuqhhl5KUn2skmScdaGaUArIIM
 G/Va/HMc2q/XA4bkfOHgxxatHHza2ac5zf2syYmrkKrGfvaYfOj/diBRHRgJOD8b
 wEus41X/Yvy0ZF2THHh+VC2uhyMc9gavYZE/pw54Chrg4HeqsFjJoO3VZhfWfdo6
 15YyTwo0UhJNhCVsmyJqWkaxyUBwMCOrjyYsqyUv2PMFRR90+2QJiYjh7zS+FXQY
 2BC/D3/HRQ1TIojFO7YEpgBgfU6wgdUkAO1k9flHvw/kDStBw2VujDZgDFvmW+x5
 34kV0g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6aahtf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso102805061cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702227; x=1785307027;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZiBIsylPCkNax8ix1SjuSMzRFBkg3HmZWMUJ4ntbMfo=;
 b=aFfhgEcMek0svVNcwi9gEPgbZ/P9pH/5+EtWfKfXLcSGpcMLMd75XX1qYjOIwWusz6
 N+qmh3I104lcnPJNVSbOKwjb8GKQhaSkn/ndnfveE1j5mppV07vFIjw2aPwZoEBZoQhW
 +xPMVt4IiEsUySDlZXC5yQgI8KiZIDpKkXvUbhvow13PpXlNBIr+TBcA3prnd+NLEguX
 Fidp1L8Pq6E9twfYpoImB5gAiVv4RwEqJibPPkyPNwQU6ApVS48AzWQipd6K44n/K1Qt
 QIZiYFDcmMy8zpkahU7/3W0WFVZsDHs/ZCSZ+ulXSbtSrPMnoYsgJi8qDMTSbH5CVCNR
 RF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702227; x=1785307027;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZiBIsylPCkNax8ix1SjuSMzRFBkg3HmZWMUJ4ntbMfo=;
 b=Dw/5g50kHACzkyah82AeMMRNLMohQjU2EiYZOoZXC1o+j4sCal/VQ24a4YVf3uHT5x
 GgjWggIydjLHlcULKKpHHJwNqjZ6FGzZynIDtqpYgPwP3VKn5uCyj0Egj2lvIgOv55dX
 4xg49XM2rH9JvOADtFR3TSr8lgYxhxh0o+oiUyI0eebWnt+mnqG5JVpCeoqwltAEVgN6
 /sWxy0nA3rYKA6lVHhc0VxBn3/ulLZAVLasjaGCIr4CNrR0HR8DTKzYeKOvrFfTArTDU
 oowtmfdMDZQp+FcH3+QvNJL/QN5zee4E9K/8WfnSuZ3/+SSTzZWRQUnKwHkl0jRUXhfO
 U8Xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrX0/LVHK1yzF6dfwvn1r+dIacgNnR28SuEtryiuP/cbq1H3Mu1xMxOe1J/FCNkbGy6Wgdt0w1VNoI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKgyLCeW5UTusYEca9Xm53AFUtK5a2qXMRncwuNN5j6wyLiof5
 hC8ehp8pyeZ/VC73MiPBNYPyjMOMkmAI19Lh9KUkba4pMAdNj9co5wU45nRLp37/KsT1cdJqG9M
 eqJzrbLINwMvYpGT/WQsOhxjTPIpskjYK5H/llB6mSTxr7cy5iq9E025uGFIkrjAvbCSGBdc=
X-Gm-Gg: AR+sD12d04q4YREsUx3HBfNqyZI/j1m8uawPryYGkexAki9ShKNJID51norW7/S8dkk
 VMJR1TboG8OCbribk7c8ATNUeC+SXA8wPinOMfsbAEjuzUWIQtmFovwielhUIi+ZVsUbHSE2DPp
 qnzEvsFYGxfe0nwMG16FEW9FEB1XazD9yi4OUsmauuedalWNDsP7qNL3hmlH0VoAvNJ5BoY0EiB
 6KPnGN3GNkk3QaHmO7m3RMCkzc7xS8NDZJmxMwzpLfjaRlL6DYcrH2WjZUJbYNAYj65MmSkSCIz
 G71TT04fBv815SXZLcq+FsjEZrOL2g5yW9SLkI9jBZP1ykU2PXsCqwZqnWvgnksak/U8beKudHl
 neSPRPhbKWf/y1UB8nYCv8UloJG0gRFcos3B9YLw0DfLNHRBHucFom/HgXX123Zz615zAJV4wbV
 m3NcxCCjbNSI9WDA==
X-Received: by 2002:ac8:7e86:0:b0:51c:7aa7:e0e9 with SMTP id
 d75a77b69052e-527a8c47932mr28198081cf.38.1784702227427; 
 Tue, 21 Jul 2026 23:37:07 -0700 (PDT)
X-Received: by 2002:ac8:7e86:0:b0:51c:7aa7:e0e9 with SMTP id
 d75a77b69052e-527a8c47932mr28197901cf.38.1784702227021; 
 Tue, 21 Jul 2026 23:37:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:28 +0300
Subject: [PATCH 13/24] drm/msm/hdmi: use dev_get_drvdata() in msm_hdmi_unbind()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-13-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AqGGr0Rt7sNJZEaxYRLu/whaI4ak/KQrIfKpyXCjw1s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGToionz/6DV8ZJm4VhBU5q5cv0PTogHzLvP1
 E0dMH7Ja2eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6AAKCRCLPIo+Aiko
 1c4jB/sGpoJuEPkjQmHA+gOgJJldC9vfgxczwZ/mlbfo1qcHv0crA6wb9wWjkhGqtdoke/T3+Xq
 zoCmjXzS6pjPL6FAgqbp1fnb4eSoe87Ny0Q+b1ZjW+3Yr2fNpMPUinjSmFt5wihbljgyXqoJhsM
 fCO/pYrPPiKuPpvuUw9LyboJUxAS7kig8cx9xIyb9XcG1Zl04chRDqu9/tdxg+lZa/KiS5ZeVBL
 T8XAwNPGXw5l0J0qfOo/JieidzCUlkTbPj6DbWdId1m007EXNRd2M3zDj6pQ35/nNkAXziYrFIw
 rlEM+HoJ5UjEEs1QvYvW5F69w8tr01Z/9WuzUyfQ+D/POHU4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX2HUwe+ce11bf
 3IdfXwpDn5n8dYGkxjMQd7zkhgFfH8O5YBlpQpaL3taaEh+qs0QhTaSCG+TSvcRMecVDbAiV9qb
 r1xT6oVwgow6Nd8ZNEsK1BHVaTbKQf7SDVHDGKbrzzEA8zhhJTmttiGo+akxe13JIi8XOiyWGWN
 +7uhw4mVckLu1PKuKKRO1gLhDOcm1AoL6vMcT1gdwPuLDpuyrnbYbfrWo99cSrf3yd+fmE4vIFP
 kiIp4q20pFz5QD4g8K4cAZIYZseIny8+C+IEkPW9z9srSW4egxeSACaK0X23uwhMriLU633p1wC
 KJMO7ZkK9lQNVaK2mjjiCUHGqTPy1j97yyddjpocORUE+nz63vNPNYvA8Pqebdc0GNQICj9jou5
 syOi8SakUfZ/4oY0DVP/TXWfj4LAMPDQ3rW2W2VzCE6WP4ZAktPYe81OS4W3P3+GiueWKBxjhZc
 Y25JkWkV2JJgjaQIQNA==
X-Proofpoint-GUID: 5DzLZnyj1cOEkpHKeSxBBphEfQ0n2k-h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX7WauDgXpoViU
 ogKbCRcyf+Pa/HgAFkiY+tyU0xXxDlGyLDqojLYnGBD/nTGgNbvmWA/O+dNyndJC/kkmBXnuv4y
 WrQXvSAbeexeIj4qa+u/ZkqNSJFPLcc=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a606513 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=sJWZvIJlLrokpUqr1y0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 5DzLZnyj1cOEkpHKeSxBBphEfQ0n2k-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

msm_hdmi_unbind() fetches its struct hdmi indirectly through
priv->kms->hdmi. The hdmi structure is already stored as the driver data
of the HDMI device (and retrieved that way in msm_hdmi_bind()), so use
dev_get_drvdata() here too. The hdmi pointer is always valid at unbind
time, so the priv->kms->hdmi check can be dropped as well.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 506a9856459e..0327098287d1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -324,11 +324,10 @@ static void msm_hdmi_unbind(struct device *dev, struct device *master,
 		void *data)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct hdmi *hdmi = dev_get_drvdata(dev);
 
-	if (priv->kms->hdmi) {
-		msm_hdmi_destroy(priv->kms->hdmi);
-		priv->kms->hdmi = NULL;
-	}
+	msm_hdmi_destroy(hdmi);
+	priv->kms->hdmi = NULL;
 }
 
 static const struct component_ops msm_hdmi_ops = {

-- 
2.47.3

