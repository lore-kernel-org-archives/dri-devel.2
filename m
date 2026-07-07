Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F6510EBD5;
	Tue,  7 Jul 2026 08:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7LX0WRD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BucLuaun";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F061910E462
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:13:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DkZG3050568
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 08:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1yBg+l3L6LYfkLEpJpAJF4
 inN7Oa+QWvyH4Dpp2TtR0=; b=L7LX0WRD2cq9+g4dfEp1G+6z6lL75xrOuTsVYU
 En4Xedq3bZamK6cOGVF0Nfj8ImHPTvS2Qimc9D6UdJ4PWitEfTfeTGx2OxPGEXzy
 YaeCnsmD+8Yrg9Z8ysKJ+hJbtEtOVcjGdFJwFP5eUWOLCaaQFH8qhppMnWU+0Svp
 h/gNI4d2BSMLXvQ8Y6sisnH0SMWi+PBVsrPyjTDXYl+lkelg+/OhSkxQ+ZcUURHR
 I7CnAXw20KBbK7rnUHn7je3AEKsIPoZ3GBGpRfBwkQEs2Cv6rc/S0izeMLbQVzJf
 01kwl8VjnYeQEmCQEegnzDqbsdR1gSjtDmWN0TvTeTWn4yFg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u85h9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:13:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cccfa32670so4353515ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783412026; x=1784016826;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1yBg+l3L6LYfkLEpJpAJF4inN7Oa+QWvyH4Dpp2TtR0=;
 b=BucLuaunGia9SJZ7y7tK/GNuvXObM0Ggb9uH/MdWd3ofIQ0n6meUZcq7uRiGcPUmeG
 4CEPUj++Pl/4409bogjBWe8SmK6Z2lllJ1ip1CO6GbW0PIJWqdcCWy033SibtCdKJxbj
 wK9wx1EA66ghZTYkFNEWp3TW4+8KE79Fss7IlSlbD8uW3N1BuX5hiePkBXNrswV0seU3
 hC75AT6zCtZqDP7wUoCOdG2gMQqvCEl/Ph0fICfwLvYxXb2XlxProhwnyv4eXU5Bw7j9
 WIzKQH+Lc7cQPhY7lA1ZqYQHCVW6TFuEGzYq+Gf3ugrP2RpP33q2v4ED5YnuGNc36IwR
 8Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783412026; x=1784016826;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yBg+l3L6LYfkLEpJpAJF4inN7Oa+QWvyH4Dpp2TtR0=;
 b=mxVasW2SjoIcJw/Aw8hnTThtGMqZsvmPajvucYUZw3wHJJc0l7W3NtnIFNNhvqhQid
 FZnSUM8GmDU9vOP+OKFfDpcxECvGZMwJEeGYBgHhW2cL6If/17EtKugbV5VSL7N0DML/
 NE+MCd1uLV5ZoIAjsiMtbJqw9DFJkTcIdMBzj6aRXUaneUvZWtHs4RsixmEZbEs49zdi
 UcPZ01PW+5YrOa7+NUtBw/dz77Qr6Cb1lTiOLEyffGNUENXXvDNkBhbxTpGSXIn3mfbQ
 T4hhUO58DUZiZ9TpMfMqxy1VUKhm7vmWj8AIqFzRwxgtrHJX4hTX7ui9FkODSPpZdD8y
 PWgQ==
X-Gm-Message-State: AOJu0Yw6/4DX6V0VQNJKcbW36dm21x1DVVWjQkGWEz/Ymg1vChxQ+AKB
 JoBcxtqOzoWm6DvWg9bLdM8Cca0DjeZdAVgNMy7Kq4jCdIyZgWZsSujRuaYp6oCrQVY3Ne19KDb
 Ulu9T6gH/fLbehmkjrDoFZ+4UwJCTP0k+GBDLSK6hfL5pixya8g6DXdvkoP7rNfFj0gCASEg=
X-Gm-Gg: AfdE7ckIycy+xmM2LHf2zJbEQG2G6Yh+ygLl+wBDGXTwX5dZ3A+Uv6K5pXzF/IcZQwx
 kQAtJsqAgkaaw1sn55UAv6wPankXMCjAJQ+rC2gMHDyqJZRhPl5P8VNr7NBG65b0sZaFBZOb5D9
 M57iHXhetyeAJmDnRxxzJBJvMQvb12O9v3F9ZHY3M1GrwhXq2ugx6Lwfno7/YlJo1satWQ5tfnF
 d1nvQy+GXl/QEzkaAVhKAW7USvN4zkHKy5D+VFd5TFaDY5avQt3HNFkbiTbJbPECnwd/b2/TsVQ
 g6fyxHkEcwhfOXuhDCN8j8vJYymBhglzItTXVcYaHos0OwMu95ElLn5FHaNgU9/QmZGbnPIAhuT
 ilGrFU6bTdbNpy4V0VcV99ppQ/degCkPsYqaF
X-Received: by 2002:a17:903:40c6:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2ccbe3fea0bmr40676685ad.8.1783412025646; 
 Tue, 07 Jul 2026 01:13:45 -0700 (PDT)
X-Received: by 2002:a17:903:40c6:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2ccbe3fea0bmr40676215ad.8.1783412025123; 
 Tue, 07 Jul 2026 01:13:45 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb746sm7356775ad.7.2026.07.07.01.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:13:44 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Tue, 07 Jul 2026 13:43:34 +0530
Subject: [PATCH] drm/bridge: lt9611c: use drm_atomic_commit in callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-lt9611c-v7-v1-1-3f48568b6e56@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC61TGoC/y2Oyw6CMBREf4XctSVtgRZY+R+GBZSr1vCytxAJ4
 d+t4PIkM3NmA0JnkaCMNnC4WLLjEEBcIjDPenggs21gkFwqrrlmnS+UEIYtmqVGZbowbSOVhlC
 YHN7t5xi7VSfT3LzQ+N/CP+HwPQeLP2PQI1F9WMrocGQ8F0nKeRGnWS5Zwmhdw49rNw7ezn1sx
 h6qff8CCHA/j7kAAAA=
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
 Salendarsingh Gaud <sgaud@qti.qualcomm.com>,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3OCBTYWx0ZWRfX/Di77d48YCsn
 r/0AR8COkXc9r5ug+K4FbYF/eHeCfnmAW0EGIaubDnrTX19Z6x/yw/FhUoaMTfU5KVNWJQ8w8Q/
 8uGTN0a5RubM7ivbDQrJniZ5rf3JHMM=
X-Proofpoint-GUID: -zJBol9jpVPd_tSmupNGVJPw2PL4x8_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3OCBTYWx0ZWRfX6woO6/UWmUxt
 v/22/4AzLiUInQ/6KN/UJDcM8A+LFQqLmVxwyISNlnl+TMhicKk4tyr/fJQ4fqKx7OiWfYvCerY
 N8RBVyrxHk8/sn5mYHT4t724NTLbrSdP5F4Nf9LpUx7/A9/S7z8cgvoPUtx1ybxVj9ywEfh00dN
 +Gwe0igONRDNWIJ7b6HM1mJTHlK1DoDTkV2ZhG8yT/rwsAEiwiXPreh/l3ZQrMUyuD43DFVDmhq
 SHC8hJ9OzA0yMgQIygIl6XSfYRXA7plePU9v5kFdCCd/ThUMkqSrh0d4E6CkNO9sAGIvsgHeC9Y
 pPq5i7mRxoIQYDy4G1iPUPdXKpCw+zhM81xJmK9JagNZVY5qfXwvncYRS09xzg4LFu8iXGzt6Nm
 /8r8xfEkx9enGPkbhpRB728b0UNL4DQSOPPEukypU3tH8YUPvypX85+RWU9d78Z5RJZ3aZFRGbD
 iFvTzRPdQnVp651pBGA==
X-Proofpoint-ORIG-GUID: -zJBol9jpVPd_tSmupNGVJPw2PL4x8_I
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cb53a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=i8gz_U39_6ELFxHMBnkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070078
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

From: Salendarsingh Gaud <sgaud@qti.qualcomm.com>

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

