Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D242C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044E310E08E;
	Tue,  7 Jul 2026 08:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJDucMHz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csey+ApZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C45E10E08E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:18:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dw6r3070328
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 08:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OzEnq10eQpTEsyK25FSqsk
 IIwwhw4E1ABZCS4iBgGeo=; b=RJDucMHz6gWCA1vSo260Aew8oylskbB3ElAfAd
 g6/CZbfAh9r2gBfN+gBi0nYE9wcjdkxuY74flXi4QqOSYn6kDYGy3hfLgvQf8Cu7
 pEKsG+u3/aFn2Fp+ABjhbPrMvQFIcVWMg26kj+plyT3fU7FKy9VG3ycziU0yZG2a
 xY39nslkHbfM+Qtnkt5uPSC6YZd3xkuoTM2zw5sww7voSp7b8NaYCPI3MVx9Mudx
 mFLpMlsP02BqnOMjsEBdD3+KK1Vg49PtlpyM+qpP+d1iE9mfvwNzeYD1u3rdHlv0
 xl1a+tnQU7YQk82hQpl8/7waUYb+8kkxEmIRf8JiAL0Vfmsg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h07w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:18:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so7830975ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783412330; x=1784017130;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OzEnq10eQpTEsyK25FSqskIIwwhw4E1ABZCS4iBgGeo=;
 b=csey+ApZZEvIyiSSwee8lJGy1w3Xu/Ohhj4vs9zbbSbmstFNeDlAQstOGuHuWSAtwY
 lrxgiy+abetXul8Sf5+qPeXMkXRFI5tKrOsdn98nS9lg8Qwq1JawbovSIkhrB+2vUdZL
 ePltOcowpP4aD04bydkZFT8LcG1XshdD6voA217p79KBzWF96TenhZiDln5IY7kyv1F8
 9GRo/nG5eSzAzt7tLOpqWIVG8MqrAP1a6JDi4Hh6HfYgR1pMNo/+sZMdT42hPgbdHDOm
 G9uH2CrdsQgdOqW4rQf1rmcQni4/CkGde2WAkBmYBp5D4Oo+ZSIpT9AGotDumbzLg9kn
 BaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783412330; x=1784017130;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzEnq10eQpTEsyK25FSqskIIwwhw4E1ABZCS4iBgGeo=;
 b=gWQH0iMFJR2GsISxOxOlJ9iTl9ESBqATrYdg5KzE++IAfWQ+vfUbPgiWiG1Xv5wvQL
 XEIZZy6zbT9KDNVaYcdGxbO4ooYNdY3o1P0PQ/jZjDyoiHZgXGAkkm2bVToDT6XwM/NR
 ezv3R8Yk+SHgxrxYIkNQFbP5o+tq7TsAnCZl9RMCs+b02U64gsOLzErOPNqeB7eE3rWM
 DNZFxjez0Wu1bQZkXFNfzuWdHPYhHePnd1b9niC7XDZAgVq2Js6oTc6+LOwYYxz7rUBM
 /RGHsEyLLnCakU5ps4AOMxAkJUGf5vNfK70QiR7NZqkYPpS/O4OD/F4KIcQj/f9temFT
 wAOA==
X-Gm-Message-State: AOJu0Yyydpvqp8VBL2I4MpQCT7u0/h4nr1pdU/E1qjL0XsejPwqTN9FZ
 6Dlu+0+HxdIekAccq4Euopre839RVKpttZLQtvu/FoGzGVu3dSB02475pBunSKEgmEqF3csz58B
 q2ttzUsm9QavJ4i+7rJna3vXZ3TDCCUGgYvUSBWt+7mDwcKsOxfuUVQP9AQEJchEPF+q0HlM=
X-Gm-Gg: AfdE7cnuyTXQMS1xizcjqtpRiIX8orSip8Vf8ZT9YYakxeCP+DX5CdeWb5vynucL/wQ
 YTkFw2l88sPlfqwioTeRfEafHTzvcenfIQKeFxVugLXT/tJv1SmWebYFQ8lCBW2WN/beagZrwnz
 Tgk2zJEM5h7w7Qm66GaY6p2W5gH8mlf5PhFJKEIw4nGtAXKhrnLb97OFVm3eJh2wH+YzD34MMtq
 RKw6ZdGk58Ef9s5UEkR8g2xZ08Cqgtf8lHGdL44TkcMSMWMxkiuY76ck0DehYm6yFypY4AkO2fM
 8pow1zvxbFyQYhnpY2stvjMyH9XyN9+Qgcgwg46nYyEqfXm6+Dnqkj+aCfRzIZz8f0cXZMettxf
 8VAs+Yhtkeb8fBVhpi0z9Vx5QpbCNlRoBBT5+
X-Received: by 2002:a17:903:2b05:b0:2cc:bdb9:3c04 with SMTP id
 d9443c01a7336-2cccad7cc8bmr16256165ad.17.1783412330133; 
 Tue, 07 Jul 2026 01:18:50 -0700 (PDT)
X-Received: by 2002:a17:903:2b05:b0:2cc:bdb9:3c04 with SMTP id
 d9443c01a7336-2cccad7cc8bmr16255875ad.17.1783412329667; 
 Tue, 07 Jul 2026 01:18:49 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1eea1sm7437415ad.46.2026.07.07.01.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:18:49 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 13:48:35 +0530
Subject: [PATCH v2] drm/bridge: lt9611c: use drm_atomic_commit in callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-lt9611c-v7-v2-1-67d4f688b68d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFu2TGoC/22OQQ6CMBREr0K6tqQttAVX3MO4gPqRGqDaX4jEc
 HcLsnQ5ycx78yEI3gKSc/IhHmaL1o0xiFNCTFePd6D2FjMRTCimmaZ9KBXnhs6a5kZJXZpbI5Q
 mcfD00Nr3Drtcfxmn5gEmbISj4eE1RUv41cgAiPVuidLNIVnBs5yxMs1lIWhGcVnij6p3Y7DTk
 Bo3kA3eWQzOL/vxme+sfx9nTjnN2ryQqmgUSFU5xPQ11X0EHbR1Xb9OurU0CAEAAA==
X-Change-ID: 20260707-lt9611c-v7-4c6579cdb267
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sunyun Yang <syyang@lontium.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mohit Dsor <mdsor@qti.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3OCBTYWx0ZWRfXwdEz4y2NF46t
 K85lDtr/af5xC3oi766T0EuhoilpUUehB0GaboBZpHPTpS2vvLNaKreL4n0AhXPFGsN3rn3SHpv
 btgg7pwTQz4eHaILViXhFeByWqZCY4GCSYu0yZFt7iDtlSb9/sciwUXNWje271kurAgMLPC+vZ/
 4BON7WW2Ca9ws1EHRre9FxK8YwbJDpqZhfG9XnvpQi02jWq2YikzB3Xh9i3F6R646U6yX88QQ+E
 TtOCbWb07ysqC7K1YaRF1JfPBD0m/K65yxqBlehC2+L2XaSzCuBohs2fRmdloFNXF/4SshcPZJZ
 Wlocdr3o+1xkyPinEyqpwVoyhZox/43GJktcYabYMDES/LycTdQ1j7epTLMMeQJcxa9UmHp+/Ea
 Ekc6CmHCSh/fzNtA1Lo76EFW+IeB9JP/KQx4bKQk0KNg6n/zxvcp8ytGtCqMSe0tuOLo6PqtFzS
 RTQf0w/BBKiBpnFFa5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3OCBTYWx0ZWRfXy6iVzi+bBNzt
 JqWJ5HizYiwYSxXiEWLrllH5PY+ZpidAvdwKoObyn3++W+vTStbb+ZNSLOQqGHOIkCU7W51uEIm
 fV+wQ7aGkDwLgaDm747TovHGbWIEEQ8=
X-Proofpoint-GUID: g1KQURqwSTN5fhCPJjLxq0NqzbD66UA7
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cb66a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=i8gz_U39_6ELFxHMBnkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: g1KQURqwSTN5fhCPJjLxq0NqzbD66UA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070078
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

DRM bridge atomic callbacks now pass struct drm_atomic_commit, and
the atomic helper functions also expect that type. The lt9611c
driver still declares its callbacks with struct drm_atomic_state,
which makes the callback assignments and helper calls fail to build
with incompatible pointer type errors.

Update the lt9611c callback signatures to match the current DRM
bridge API.

This will fix compilation issue in v7.2.rc1.

Fixes: 96d1cfec419e ("drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver")
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260707-lt9611c-v7-v1-1-3f48568b6e56@oss.qualcomm.com
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index cb584855fd8f..022205177a4d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -614,7 +614,7 @@ static void lt9611c_video_setup(struct lt9611c *lt9611c,
 }
 
 static void lt9611c_bridge_atomic_pre_enable(struct drm_bridge *bridge,
-					     struct drm_atomic_state *state)
+					     struct drm_atomic_commit *state)
 {
 	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
 	int ret;
@@ -626,7 +626,7 @@ static void lt9611c_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 }
 
 static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
-					 struct drm_atomic_state *state)
+					 struct drm_atomic_commit *state)
 {
 	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
 	struct drm_connector *connector;
@@ -652,7 +652,7 @@ static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
 }
 
 static void lt9611c_bridge_atomic_post_disable(struct drm_bridge *bridge,
-					       struct drm_atomic_state *state)
+					       struct drm_atomic_commit *state)
 {
 	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
 	int ret;
@@ -1238,4 +1238,3 @@ MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
 MODULE_DESCRIPTION("Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FW_FILE);
-

---
base-commit: a9f7d19810c7719ca55134a386dfc48160a1bcfc
change-id: 20260707-lt9611c-v7-4c6579cdb267
prerequisite-message-id: 20260508134009.4582-3-syyang@lontium.com
prerequisite-patch-id: e9ce15b4a5842cfde130a813afecf136798179f4
prerequisite-patch-id: 569618a60e8c3615e7347c79b48c4756b7bf85d0

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

