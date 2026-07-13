Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25B3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5D710EAEE;
	Mon, 13 Jul 2026 20:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqQk0LA4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+OaLA4J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F69710EAEE
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:38:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9YFr2356010
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3ixaKtvzn2c1HoaM38+GZlCvyJJBgDktBId
 9o41dreA=; b=mqQk0LA4jXc5qpKzoIpAydTWMOqstKaAtY4yjVNulfTrvIuXhxk
 MU8ktEdq0B3LY7CQ/CeFBoZy5f5QRGWtCmSuBc68JDOihMXhSHsE4o6AvXKaIS6e
 UHBdM3mY7IjWiMMB0m7Qr+rXYx56k3mDb0DPEllHBUH3U0PUmnXPueFwGzOUMyig
 bwCGv7YW3xurnuQlGUc5F86SUKtxR51M5v9Jd/TBIg5+4a5kBEWqmzdKu93zbJ/R
 PZ3S+upK+ma2JhGPHXBSOWcCqMCBRNb97kI0bgDGuSDUaohWwNsuBJQI5ITiwV5q
 UdqTUBxJz7zbynMYFJ9eOVWJfRmMGLE7YSQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tfkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:38:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-904ee4473a8so35166396d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783975111; x=1784579911;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3ixaKtvzn2c1HoaM38+GZlCvyJJBgDktBId9o41dreA=;
 b=f+OaLA4JbWlFkQwGhCMdeZl/lZ16zliXOoZXdMuARGcsziLKiXk3WjMUjqTcyEZ2MD
 dBiGS9h2Sw0Bc/BFKcESsdeaThQpiVzdL6bOAGT7547j8TbQKB8ix8Vs6D8g891C98If
 ReuRcqyvdCqEkp/Vzo1x+II/quQqPaZYA/4tZOb5JKM7FUEm06Z7GeLfAWarI4nfmZKt
 GfZn1z4gmRiZhGhUcwVPYQyIey8GdUJ1y6R5J3GvVAuPz0izskuHmkRton2wvx+oA9Qp
 sTsqXXjUDH90AppnG1nI0UksE84OMYIJL5I85IRTa91x8fp/MHxaHeu4r9OJrMPRn9ZY
 5nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783975111; x=1784579911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ixaKtvzn2c1HoaM38+GZlCvyJJBgDktBId9o41dreA=;
 b=gp8oVGaZafMx2xsm6IA4EyHwtM/ns8eSPSHGLPANmYGOq1AAQFTu38ggv2BsYgZsZW
 mYXXjITGjo3RnpJVsvcd0+1OZfBqYe6MepFU87FAa1DXphryQ+LhINEr3CiIqsYKxrfB
 uGXD5nIp8ppWAs8ximHC5QdjbD5qIxNKjQk1gDRT7WJNrbPQNdaqs/hv4NOurRki6Qgj
 jABduYzKUiG8NYbpaOpGRxTRLPGEyhqX8DRtbDyvgliZ1pgp1uG21qVdkWXII6N35Mz6
 cNRW5kdw9IWnRdvyCQtKE1JUOAXYRiZqwWjwFnWeIaKwOhpWudZzuYzsF5If6nXFNisr
 n5og==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTzqatH2lLvHZHd3CPgntN5QiFT/mny89Ccw499huApEdxfEcRx8PRx7IgLxNCh+kM1NE3r9788Vg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdS4nBuUzuaM/AvojxOiPFWCGGoJvOj7Wfg3nVOGhTbsTyLrDx
 7mKF476OKgRQXWC2IxrPYzvBP0+3do+o1IsPLGIjJ766cjBAoTjS0C/3GvjHhnFwIgVHP1vEhG6
 64aZ7JCEc4tsH7zbmKO4TCoI1jNXQGKagwmQkUpMzfpIS2p/b2CBMHNHVg4x6BWPPnJGfxaQ=
X-Gm-Gg: AfdE7cn6RBvsktfbDzViDnzKp8M06QIffizG5iwcYyQRyEqplLq67sCRZGjWbXxiI8H
 G25TDhCw4dkOfbkoIIPBvtRkpFbKjgg1rZn97SVdJCeI9hnii0XYmUlI1bvI4njHqoO3hC2Uqvt
 qKa+pap5ijZLaLr70QeGFbxEsVdGGaepmNLQ/UFBJr86JSGZ+e3C9kchsS+cqOsoueA3chFP9uX
 o7cJUf6ZK4IbFE6da8IgL5cZY3n/cqVjLcbnjiFzjWyr/8wQeIoKAguV3z+5+qXiEcOb0kNAeEs
 93uy4t5vs967OFH3Yird7OWNt8ZyrCSDR/sk2UTZLtDTqR4/7SJjK/QQ/cBHNV+PV+cJStUR17n
 y9rrPWgBBJEz0A1pnZkQG/Lko7GqXgmLaOD2oU6bvmcPGyyisGOWq2Q658/HBRXrkmEot85ZgXx
 A84krJp/9DtlywS0BFCnZlpyiUTQ==
X-Received: by 2002:a05:622a:a1b:b0:51c:c7:80a9 with SMTP id
 d75a77b69052e-51e3c33bdbcmr10964091cf.72.1783975110660; 
 Mon, 13 Jul 2026 13:38:30 -0700 (PDT)
X-Received: by 2002:a05:622a:a1b:b0:51c:c7:80a9 with SMTP id
 d75a77b69052e-51e3c33bdbcmr10963951cf.72.1783975110267; 
 Mon, 13 Jul 2026 13:38:30 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c165baa9152sm61289666b.18.2026.07.13.13.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:38:29 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: panel-orientation-quirks: Add FHD version of Acer One
 S1003
Date: Mon, 13 Jul 2026 22:38:28 +0200
Message-ID: <20260713203828.383404-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a554cc7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Wkc3qPyEvMQhiwgY95QA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIxNCBTYWx0ZWRfXyh7Pw0z00hOq
 +c+9xKA3qOKS2hDUgOl7hZOZET9oepBzEKR2VSsMIx+FoVhktkXJj3xwbqLGqgRys2h/W2T2sAw
 9JH2JDQJz25HUm8Ta8SPH+dNSQD9uXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIxNCBTYWx0ZWRfX9X/YmhEYS2vr
 Zbosgeb+FNNcH5Syu0eztvkAJjHHnnwtyWIqx07i7m1F43deOhX5Kq1BBA28PLK/umfBPbj44Ec
 /g4rTagwNc0gYQfA+flHSjdPSU8JxZIbJMIpmrcEhp1L8JzIWJmdIk1bGCDNK72xZpzzJyriyhm
 4BSxPVisxhwuJW4lf2AxoyW70g/AfAVpwV5zM41p+bijhtZ+TLhceEpkq/MkEKiMOSBlterABFs
 /phbLEl/KfvDC6CiPt/7VhwX4BWSYzgseyOcTYCIZKM3qXpKm5gV9i6AIMbMoUvoIRpR8qvWztl
 U0WZOeuk7OdXJhoKR0tU54TiQ7KjHsJiAAIX0Y+PhRE5eQxp3oA1IOtMxNai0jBC2gZXEkAyWiq
 bN7fLR4RZSmgQysXGhS5c1qev1DvBNDWRlUosnvw3s/z+ORmoD/PQp5N47hMhICZvLxhKE1jX8A
 jmWBKjmmi7TfDxMLVyw==
X-Proofpoint-ORIG-GUID: vUlerDwLlmb5LbpIYwMaX42sXUBNGkq3
X-Proofpoint-GUID: vUlerDwLlmb5LbpIYwMaX42sXUBNGkq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130214
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

The Acer One S1003 2-in-1 also comes in a variant with a 1200x1920 FHD
screen instead of the 800x1280 screen.

The FHD screen also is a portrait screen used in a landscape clamshell
2-in-1, add a second Acer One S1003 quirk matching the FHD screen.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..68b4eb7ab9f9 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -161,12 +161,18 @@ static const struct drm_dmi_panel_orientation_data lcd1600x2560_rightside_up = {
 };
 
 static const struct dmi_system_id orientation_data[] = {
-	{	/* Acer One 10 (S1003) */
+	{	/* Acer One 10 (S1003) (HD) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Acer One 10 (S1003) (FHD) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Acer Switch V 10 (SW5-017) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.55.0

