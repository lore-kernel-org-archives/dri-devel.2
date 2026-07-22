Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0015C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2920910EC7D;
	Wed, 22 Jul 2026 06:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="An4vEwxh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LL+INngJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9205F10EC5B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53ZgT3767528
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bo/4C79iwt7zABGRuOK3HQrfFNywcLsmPwQZeiLMY64=; b=An4vEwxhrYwDGuLb
 /exn5a+Eoqi6Bnyz0UeSdpNXpw6XzQtLSAB6qDUAL/lgeQiAVnBzSPYlcmdrHwx5
 ezQnefIVOc2bT+WaOnkbLOKoSem45vQtJH0yEbDzuJYKS+cgnc3RsSLI2CJZR9U3
 AVZhBawIbSerx5STPgzFVV+hgA50B0pQnLF9DyYK9jIK+pNwIij+QzJSr59R3VmZ
 Nhh5rCZPwRockr3erHjMXkBEjKn7IYLh+9PtLBhIeNJ7M7eXuEGou48xLjICwsxN
 V4qOxxWaWSoDDVpFouUOS6ib6R5v6CTftokN9/8oVOcUZDYtC2rLALn0FfQNzK7n
 a4qxeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rn9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-520a00c7a03so154720791cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702243; x=1785307043;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bo/4C79iwt7zABGRuOK3HQrfFNywcLsmPwQZeiLMY64=;
 b=LL+INngJA+s0idL0pSyQY+Hh5PP7NrOUzwOkm1qF5aCNmw0uKLHlu+qb0NNEQf/hpS
 d6cPtq8K8B1jrq0rqFDbwHqVczTAe0xg0xsrAqk0lNmph07prX3B8FxY06XPN+NY0V5e
 8MmFLTLbeFkBIHu0dYsbq+/1iQFV6a0aRhJf2qqV2XRLa0fpCHBKypfXdsA0mFKEzRrt
 yJjDvgTf5tpFJJSwtOMPt1Q4aVXDLycxaB+iUmCdioypXCAeOwWvq4T8hvh+IYo7wLgA
 +f9gieDA4bpBA34DHWu+tzrQRP43dwTpRBS+CT3QBuGkqs8gnZweZmfaWGXsfEVBATsf
 NdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702243; x=1785307043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bo/4C79iwt7zABGRuOK3HQrfFNywcLsmPwQZeiLMY64=;
 b=GMnARfWMTYRiQrohDdRgpXrXIe+yRhrYMfsDZECVwgHth5glFc54RsKdEs/oi9YeRb
 jnB3hx7T7YceG1nU8rX5zCMkDiMgSX8VjH6JynGZYQ4HiNbIFdXHcMVQJPBJ4BXQQUYs
 zfiiZR/bDTvoqSTwGoQKyFvhXAEx5SiAY2AlGAVJRRW7IKbcnY+CC0gz5xJyTITeLxPd
 clYfz0txKFdRbkSZ+rT0EmNgr360NAd7FgD9Zzv/CRnNlo/gDdRa1k9K1KMSrIpbIZlL
 5D7UuzH+ubmgGDJx27ySbIiIcMYZQQjrcvVcPgwTXGXqiRzrNqB5di3HcOu1TStwZp3F
 AgsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUDH5r/26XDKnSa8dJpWoJdS9l16ROTw603Y8/kd2pycA2b2+Vx+3JB29ejexTDpeph1sNIQzMLnk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI+5OQQaoudCLLVy1CLyIs2ZivGRVYY1cItbVwdNM1onGL+Qvm
 k+qX9MMU3zdLHA31Zh0QuDfg6xbHOiS01+yyb+s9cJNAUq1ljWQv9N283vxGXQ7Gl+E1aHLtcru
 Q2NLzvfh3J/4nUVPecMZWfG/UiTVR7JjP1t+fCWSn8hYctXJDfhEHGfmUQ3bjNbR2pl+J22Q=
X-Gm-Gg: AR+sD12wa3Y8mMOYx5uHTNPL/JuvXeFGqKaOZoolNTOhUjIwLd8zXTImFdmybZsfKUb
 cP6dJycykKow6oOIaMZqkLAT/DW6gObGb0pqq8R6AEfjT6Yip0wq69Sk/aZY0mH9dNcMfy8JcFN
 YIZAYYAwSoojbSEYAf0hIAPfbnL+tqw+I7pn1fYesm4WCZ9384OpOkX54HWHK9cKOj856WKRDXL
 efL/a6bNg9PsfyRZqQyDk3rvjh0AiRceyFOOn2piuvAQ1CvA6vrOqDk94CH1xKTAfz5l5uEFY8Z
 KigZLVLvES10UriCMpBwBag75+VpL61c7kX4b3ZAAjgLjgFDDpEZKeuw1OvV5exsJAu0ERlMRk8
 +4kZO5+t4hqSuaoce3OU7LPA8kE40rFzIRfK9ySaR2+BV0ZDVarfha8NIlQdhLbrAuWOw52WaFK
 gMKh9c1yl2YBEK5g==
X-Received: by 2002:a05:622a:11c8:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-5213c8e2f60mr208067361cf.5.1784702242965; 
 Tue, 21 Jul 2026 23:37:22 -0700 (PDT)
X-Received: by 2002:a05:622a:11c8:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-5213c8e2f60mr208067151cf.5.1784702242555; 
 Tue, 21 Jul 2026 23:37:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:33 +0300
Subject: [PATCH 18/24] drm/msm/hdmi: cache is_hdmi instead of storing the
 connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-18-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6460;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=O3Jqaz4ugrsLczAy6mpnpHdHHgthAqZTa8e2rdFVpUc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTpaoDgCLAerwkVcOKkcxoGFQZ8MMbf5o7F5
 ZtyF9U/ICSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6QAKCRCLPIo+Aiko
 1UI/CACEZ5rknFHrCvnMjYTa7ok4aeGn/cXLG2wgZpQmRB8Yj1/3aW2WQadMC7ebQe7jfrrco6k
 oAUlQ2i1iWLhGorgh3zrPX+sMVSlneW3vYRTX05i74TcgA6OP0AnXMitIlkf7BvniOwgue18dqU
 aObJUsb4awKi+riGMhBy/6QExHXz8G9MpL6gx6knUIHxPVzBUTVJ3Vq4vzXc4G8qNZ4eeZCa0+v
 xrGGFqVDT8x9edTKcDDvvRDUyl0sPJyltyXHSFgvrsHjzvNor7c9w5UJKLjFJjAPjR8uDgDIYjy
 +rZQkRGAhaV0t4XAoSTq4nZRmL9DAYnomcWPvSZ1rI4YiNkw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: KCXNTHjqg_bOS30RL8qVDwe_JKHyqu7j
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a606524 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ahIHk9JMi1UzJgPfqiEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX53xE4JGWnSSa
 07Pizi+2rgX8JRFUCZ3aYUVLlm9sYeQti0MqxPvzhUREFJGGf677nWpFMxr2Y9uTdhFoFodXDd0
 igL1cR0P32ngWoRhVsMO/Ri2ycyDggEuMMLCvNgSgeLeto1Oo3zbYxcnPalimbXOBKcl1b+uPv2
 otyfRYXWzaGNV6/1dPU8FTFO5Qynhcw2TZoSCrxODaDTefyX8qq8Q0aclqb7LmjodPScF4cWxXY
 r8JrvsYkZGOMcY2QH/RDw/PjXDfL41RFT22rc/jFKAaYzH19qayZD6jt0S47tNUc+A0cuEgibdm
 KFzm8UPsljt7xiBKUOXoBhwYyp6XLLd3VcW7PDD5Pu4x4leZjz2TmnGdPTpMxBtDmW3mDcPb6iH
 XpaPXjowbiuHAP6+QccViNNGTfwAtISeoDbSqzA2Unafd5ju/n5AA5qYNINH420/cEraQNI+oIq
 69YI4XT2I1MVzPkw3ug==
X-Proofpoint-ORIG-GUID: KCXNTHjqg_bOS30RL8qVDwe_JKHyqu7j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX7sOGZKDTYCHi
 6KDXtUYqhAx/kInTFTI8pLnYW5t46OnuPp5UFSelV7rEZem+l+XttL2cP2XO9B25nitq04IXCRR
 4CqNSp+o1aN3p6penOtvse+xV/yddZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
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

The HDMI driver stored the drm_connector in struct hdmi solely so that a
handful of call sites could consult connector->display_info.is_hdmi, and
so that the hotplug work could hand a connector to drm_bridge_detect().

Several of those call sites run outside of an atomic commit (the HPD
enable/disable paths in msm_hdmi_set_mode(), and the audio update path),
so they have no drm_atomic_state to derive the connector from and thus
relied on the stored pointer.

The only information actually consumed is the is_hdmi boolean. Cache it
in struct hdmi and refresh it from a new .hpd_notify bridge callback:
drm_bridge_connector_detect() updates the connector's EDID (and hence
display_info.is_hdmi) via drm_atomic_helper_connector_hdmi_hotplug()
before invoking .hpd_notify, so the cached value is always up to date.

With that, the stored connector becomes local to msm_hdmi_modeset_init():
the connector object is owned by the DRM core after creation, so there is
no need to keep a driver-side reference. The hotplug work now calls
msm_hdmi_bridge_detect() directly, which ignores its connector argument
anyway.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        | 17 ++++++++---------
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  4 +++-
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c  |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 16 ++++++++++++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 1d5a4b63f3c8..62961dddd8f5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -27,7 +27,7 @@ void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
 	if (power_on) {
 		ctrl |= HDMI_CTRL_ENABLE;
-		if (!hdmi->connector->display_info.is_hdmi) {
+		if (!hdmi->is_hdmi) {
 			ctrl |= HDMI_CTRL_HDMI;
 			hdmi_write(hdmi, REG_HDMI_CTRL, ctrl);
 			ctrl &= ~HDMI_CTRL_HDMI;
@@ -164,6 +164,7 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 		struct drm_device *dev, struct drm_encoder *encoder)
 {
 	struct hdmi *hdmi = container_of(display, struct hdmi, display);
+	struct drm_connector *connector = NULL;
 	int ret;
 
 	hdmi->dev = dev;
@@ -184,11 +185,11 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 		}
 	}
 
-	hdmi->connector = drm_bridge_connector_init(hdmi->dev, encoder);
-	if (IS_ERR(hdmi->connector)) {
-		ret = PTR_ERR(hdmi->connector);
+	connector = drm_bridge_connector_init(hdmi->dev, encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
 		DRM_DEV_ERROR(dev->dev, "failed to create HDMI connector: %d\n", ret);
-		hdmi->connector = NULL;
+		connector = NULL;
 		goto fail;
 	}
 
@@ -204,10 +205,8 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 	return 0;
 
 fail:
-	if (hdmi->connector) {
-		hdmi->connector->funcs->destroy(hdmi->connector);
-		hdmi->connector = NULL;
-	}
+	if (connector)
+		connector->funcs->destroy(connector);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 869f55d4704a..d4adaa6ccdd5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -47,6 +47,9 @@ struct hdmi {
 	struct mutex state_mutex; /* protects two booleans */
 	unsigned long pixclock;
 
+	/* cached from the connector's EDID, updated on hotplug */
+	bool is_hdmi;
+
 	void __iomem *mmio;
 	phys_addr_t mmio_size;
 	void __iomem *qfprom_mmio;
@@ -62,7 +65,6 @@ struct hdmi {
 	struct device *phy_dev;
 
 	struct i2c_adapter *i2c;
-	struct drm_connector *connector;
 	struct drm_bridge *bridge;
 
 	struct drm_bridge *next_bridge;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
index 249c167ab04d..ce1864f3f659 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
@@ -19,7 +19,7 @@ int msm_hdmi_audio_update(struct hdmi *hdmi)
 	bool enabled = audio->enabled;
 	u32 acr_pkt_ctrl, vbi_pkt_ctrl, aud_pkt_ctrl, audio_config;
 
-	if (!hdmi->connector->display_info.is_hdmi)
+	if (!hdmi->is_hdmi)
 		return -EINVAL;
 
 	DBG("audio: enabled=%d, channels=%d, rate=%d",
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 7abb9243dba5..84a423af73e9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -345,7 +345,7 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	if (hdmi->power_on) {
 		power_off(bridge);
 		hdmi->power_on = false;
-		if (hdmi->connector->display_info.is_hdmi)
+		if (hdmi->is_hdmi)
 			msm_hdmi_audio_update(hdmi);
 		msm_hdmi_phy_resource_disable(phy);
 	}
@@ -452,6 +452,17 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_char_rate_valid(const struct dr
 	return 0;
 }
 
+static void msm_hdmi_bridge_hpd_notify(struct drm_bridge *bridge,
+				       struct drm_connector *connector,
+				       enum drm_connector_status status)
+{
+	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
+	struct hdmi *hdmi = hdmi_bridge->hdmi;
+
+	/* called after the EDID update, so display_info is up to date */
+	hdmi->is_hdmi = connector->display_info.is_hdmi;
+}
+
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -460,6 +471,7 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,
+	.hpd_notify = msm_hdmi_bridge_hpd_notify,
 	.hpd_enable = msm_hdmi_hpd_enable,
 	.hpd_disable = msm_hdmi_hpd_disable,
 	.hdmi_tmds_char_rate_valid = msm_hdmi_bridge_tmds_char_rate_valid,
@@ -482,7 +494,7 @@ msm_hdmi_hotplug_work(struct work_struct *work)
 		container_of(work, struct hdmi_bridge, hpd_work);
 	struct drm_bridge *bridge = &hdmi_bridge->base;
 
-	drm_bridge_hpd_notify(bridge, drm_bridge_detect(bridge, hdmi_bridge->hdmi->connector));
+	drm_bridge_hpd_notify(bridge, msm_hdmi_bridge_detect(bridge, NULL));
 }
 
 /* initialize bridge */

-- 
2.47.3

