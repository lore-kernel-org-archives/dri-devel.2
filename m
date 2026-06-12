Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A76CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248F810F649;
	Fri, 12 Jun 2026 18:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCgfg1hi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lq4sxkwh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E2110F645
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVotl4113371
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=; b=UCgfg1hivTnuWEjv
 nioBWrIUwJRrqQ7jqClIPM7Q9GYwG0HQ7iDh8MAi0XjxAVvMqTyoEbx8KK/TIL3y
 vqjX7Rvr8tZ7E9ALoeN+8V6TSaiQUZ3EWRoKcR1R13mevpluMOzlrgeNrqcVQpg5
 sBrUTk1uTzm2v0AP//5vx4kISvAxP7Rm7WRRSNQHBb2rEjHbae0bNQ67GMPV/GBk
 lI579hdewc4qZOzJT1FAnZWNBV2OWdHak+EwLedV+VXZE+mFynZmpx7f7TXmqhtd
 b5TCpsU79jhUL3L3pGUHnRxQ6y/3aa/h2ik5gFKkR7c4kQMG2ITTkq30i2qTU/Rw
 MBQNtA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914c8954923so223046685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289048; x=1781893848;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=Lq4sxkwhKUfGo2Rp/jaX9hgeebJpGzD0/iI8LVsKaKm2N7MOeKdxTKUm10aXuNz4Pt
 LvtCxpTjniqHw5emzMIsuOYbUeOvNTlOAAF5jC6XJx3JgpOC46uoQpXt5c+xSXZNERUd
 5sTB2GW0am759e/5axbGQEGmlugrvt/rfLyY+MCA2AZjc5k2J1ZPSPUfgB12rppNQxQi
 9di4fpIecod8/pIDwFTzTHj2W7jbcbO7jcqaBis9YN/p0zHTvVC6DYI8z3izpKkXJ+jN
 wMfyPpMJd6oZpL0RT6GI678IoIDwPFbIXCx2w+f6jrc5rDtTMpIuRwq/ECUspQyJIgsX
 a7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289048; x=1781893848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y4rDxNdRWU+aebNlPWMdizg27R+flJppZJLNZrroSxs=;
 b=Izex1EQB0s9mDc281mIjsFIJ/efQjYj+qJgj3seHh/HH2nomothFqwRhK2C59n4R7Z
 cvf7ne8m8sm3E6J4SMK5tCPIpe8vK0uwU3Uy67wFWajwfk/NPyCfIDnu35swNwvdHUbU
 qXBySjxZfd3APc8/A2QxhybrQ9I1uWo17gaT4Z1KtG7InGdW1O9xdIWkiHoTOJ6MKMR0
 M4jN/6N4+1Ab2w5Mc0tBO685S9n8EysTObuwyIUYWMj5PzEqhJGEwQ6+e1R8Cr1XqGZ+
 hfWsZVk51OiZr2LNRG5c/7RlNMF+uk8TDwZ4fzzp8RHV4gr7rv47K4lnTNTvwYuk612v
 Ftvg==
X-Gm-Message-State: AOJu0Yz8ELT9RJA5GkqVOYC1edSstRYsWbQEq0eUsTmmYIWA36EO+u6d
 9jK98Mx+C2uU6AtuR9oV/7Zeq5VSzGv8dkoBHXifqg98kvMSWVxG+oAUf/GTD/LQPYaqy5/xA1h
 PVWTdFDgQyZ1PEd2cSgPp7l6vAK8e9HTgl8+DfpVUurpsnhUVIlzmupLUPmm462nzMpCF1Dw=
X-Gm-Gg: Acq92OE/u+xpc/Oyp7XdAvBSsCfzeEsqGKGZwnw8nVxPEl+YeE19zf+awTnyQ1ShWmb
 oWGJTinxnZj2iDNlsMjd87BNThn+FR78e3NCG3IiKGamoIIe3c15svnVuMx1+GKhSRk1H+Fu6WI
 UgwDP3OVV2QPct5inhnAcwZlHB2283sidSpDnbjrSzjA8GgAI3SIhSH2Cp7EWZ33fBXi6YRrBcR
 xrz86rZm+bkBOwlfCUFI/9ltwFzu1NaMzjE0Rx2AlCoTkV5eRWPT2/EBUTAPQXgWS2kHM7fRJSj
 ZXJx2E92l5Jqtm5pfN15oBe/2c6TtdTm/HVgaHx4UvDo4+KEMbZpxn+rPzM62cXUmayY69mFcxE
 dTjs0dj2NJvirwv2icRx2vp0ZSkuZbkGjWc2d1YYyJJcbewheia38hQzdBz/qR+3uhL5wfdnuzv
 i58kvTKendF9YPz4NCu2LFR9iMdNKZGOWvpYI=
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr616315085a.33.1781289047427; 
 Fri, 12 Jun 2026 11:30:47 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-9161bccaed3mr616175885a.33.1781289037649; 
 Fri, 12 Jun 2026 11:30:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:19 +0300
Subject: [PATCH v6 9/9] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-9-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mE50BYUB/UAw+zq2VOqPPalyAMn1gAB1RtsYcBWwgx8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZOgPm7hKVaN3b0hT6bcClZSGAmt9jj62VfnGUivxSkl
 FVM9wnvZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBE0nay//c/97a2SbnxVfwx
 od8Z9RozxE2/d3rfOSh1P0zje3yeaSB/S/XRfVc0gwKz1j4p+rh++94Wl+wgxd8TAkNsea+yRuk
 IzkpZFXNW2f/Zg8wPmw1neZh0rLrQlVETKHpl3VR5PfVNW16uC39wPqQnxifsyP7V/znnhfAU8f
 19MOXqHOZwNj8mX8a7OduLjdh/1QqcVFZQWWhREPJEaN6UF5xep5gyFXZbeHiX64vXxD6IMfQwS
 a6umKp2szu778CpkNkNe9qmsWueMrZnvzTvmvj93HkySrOP3JyWoKt/4CG/r2KBWtvqmXUH9zu7
 xsdlhL1pebleUHSPr0iMxOp6xdx2Hdk7Pz6Lsx63C/cDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX73crJ6XZqQ3n
 cgkNP83ml//5PNuQLxJh2xwaSDewVzezVdglalnpVefdYYo6v22GCffJxoYHrVFSvP7imQ3VK63
 WXnaJMJbZvFysum1yU28Gu4eNBURSIA=
X-Proofpoint-GUID: wEB1Y2W-_clje48ZzIRb2VGydWwJdgh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX8giYPG/kOARz
 Ar+cmd0H6Ge1642y2i1nDs8rvDphvRjgE1/3Fcztz77mXgjKbpt6hXRaRFWJNmj/bTVPsMOcyaT
 PA/B29jPOKWDAbNNfgoT0pplgjYkOCNeAncq7+3laQ1uWVkzKNrTIie/UJXMz4Iwt8FGip0x0VG
 0NNE8UJE8YqEBaCBAJuOp6/ph7AgxRlHvScV2rEElatx09XbfnBwcuKzS5GjhAJlTnB+3BrMB4n
 fssb3NA7B6NSSSyNlzsMepRgWSai4yjVQrRtlFbp46ra1EKa6IylT9+WVeK94WNbAk+14bxaqG4
 ARuIUDwOFNm415QbFy735+uuU8ZTdFSIgDhshzOKb8mDody2ahJTs9V/WWhgaiIFifEMKwir9jt
 uquGEwN3e0aOl67bMg4WRAyo10pkmZ+iNfuG0kFnLimj/Z52BjXLCsPG4RoDQBDIkgP/vvAQak5
 NLs+QPOJBYwqYWVNatQ==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c5058 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=By2WwYRBACVvdXAjiroA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: wEB1Y2W-_clje48ZzIRb2VGydWwJdgh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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

Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init().

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 14 +++++++-------
 include/drm/drm_writeback.h     | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 9fc15168c34f..68fdac745f42 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -235,7 +235,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 }
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
+ * drm_writeback_connector_init - Initialize a writeback connector with
  * a custom encoder
  *
  * @dev: DRM device
@@ -263,11 +263,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
  *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats)
 {
 	struct drm_connector *connector = &wb_connector->base;
 	int ret;
@@ -284,7 +284,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
+EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 879ca103320c..958466a05e60 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats);
 
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,

-- 
2.47.3

