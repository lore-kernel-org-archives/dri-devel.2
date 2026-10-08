Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471DECA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6712310E86E;
	Thu,  8 Oct 2026 13:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VR/3bMV1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fck3Xesj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2436E10E840
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:15:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698CXJqS2763147
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LmFgXz9bCUDEoCCFm4UoAId5Yo4tRXQx+o7RqBDpoyY=; b=VR/3bMV1ZVGwB4XI
 qnkVWK8/HT35hJVvXHej32VrFYVXtaI9Q79GPRLDJ3X4HQkXlbh2V6nhissOen1k
 91WCtt7UYLeBPHSQ6iPhxy2qsK8Hbbuxhm47oRSDHpP2+k9h+lA7xDXURbxPoxWX
 A9vePFBLAfBXzBFSINDvmTMxBFLZc93yEkkN2BO2rkV75fw88xC1ved8GDfZQIQc
 6O3GUt0OY3p7m7j6+HdEpswlOKViDCa/PIL/X1PSaljnNkdA0qKfaEsV7oZiPJfp
 5hjufMqDz884H2kut4gUz5NAlCAISoeg7hJSIBBlmS63BK+tj134nXLREypjRyIH
 gVqPvw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kg51r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:15:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so4596518241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465301; x=1792070101;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LmFgXz9bCUDEoCCFm4UoAId5Yo4tRXQx+o7RqBDpoyY=;
 b=Fck3Xesj5cmPwlusvbgLUjC0hCl5Y6vSiaE8YnINx3Mgg10Kz3Pev+hDt2dBsBtJyk
 oxUyNE75G/cs8Wl3EVb6wkZdIs/q4siKTrIg4eAuUj3R3i01kQiI9SS8HLfP+1vgFg+L
 2+ubJ9+egKuwEPTV9GS5PanPW3OO5KLZiLYwFo3eico+D6IXmJNnan4gaqi4aDav/fQ1
 32R2qbVl+60eYJYTK0aen9tZA6jpogavUAvpL5CWESGqgKaJxLEsN8F474hbyy1MD3CX
 qe9ZmuDB7YZQeryp+uagWGNKLxs6Kg+EDylusvI+sWVE1a9EzUWbLthGYERnM2AjulQc
 v9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465301; x=1792070101;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LmFgXz9bCUDEoCCFm4UoAId5Yo4tRXQx+o7RqBDpoyY=;
 b=g+7UQg3r6SkqY5ezfjvLvdlLfRF6qzKjnx6470WlySawtGnyHxhXUKmbg0FRp67DX1
 I6TYWURS5vaeNztzKjy+ub0VasDLpFnw1QiHOkZXfwHGPCPI3UXufdDil4Z8Ej2ma+tD
 xryK7sDO65yVcHt+1MfyBYqqiXMqdE5wbjkGpmZeFEM+GilG+TSUN+nkEzoDd5YumPOX
 4hPL3Pj9Mh/dsT7bbWrlykMNh+8bn8Q2v9UlbV5KWCEaml9zO9wml8P2dGEJP/fFh96G
 TlR4YiKMdAC2x2zZtt/H6eVXUB4xv66RM6iLOJ04El+j+3+snrQ4YkodUby7p9Q+AZJc
 bqzg==
X-Gm-Message-State: AFq9FYK9Df3FwsOtIaPexzyEWP9Dv7NsjpLfqVt/67b55YTdMlWU03hH
 PnftjDfgyJz9UjRYLTTeOibjpqSgPCJVxZFJk1K0/yO9aC/3Vv9NRvrxd5EM9yesQ2PdlWANWj+
 oVGku3aofX16sMhoa5rErPMAuWCAva3JqD11XLbKOmdRrMxv/HfEkrLUaq8MqjlEBQCvcyEQ=
X-Gm-Gg: AYBFou3bbAmMhKwOsuLurfuKI7K8F191L6gjYl3/5HI9wOsJgZfJS179afbjemEYhdp
 Fx8gf5bTroGP8Unh6hID9RCspJ0nA8dXSYOVJXT9PZJRXbXGHD5DZFC5BCK2KuAzHD96ZQmJP7S
 4h+IlCgJqi8LaZaySeP5Elex1OwcFdKQaQhsm6W9+kxXo99n2QJjUC3IprpseQrGDoF2hC1x6Jo
 IeqTqfy57SztxMznDZEJqIujsAevp/55cFZ7wy6fL32J/LEX1avqGcNLOMpAUzVaA4htdZ3/E61
 uYt36Uu3ovOXFFKo40XfPguAP+U2PFvnrbiFn0qggmJkJTSpjqAIZjGwcCDLb64e0PIoMgo31GH
 6JG3WO8QY24MAkonvU/ZRflj+zXpPi2gys7gNqGz+vZRuXdLElVeGUR/yOuxRIxhdLka1zm8b1h
 iaUd93e+4SiPNg
X-Received: by 2002:a05:6102:5114:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7ca38b56930mr1895313137.15.1791465301355; 
 Thu, 08 Oct 2026 06:15:01 -0700 (PDT)
X-Received: by 2002:a05:6102:5114:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7ca38b56930mr1895298137.15.1791465300727; 
 Thu, 08 Oct 2026 06:15:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:27 +0300
Subject: [PATCH RFC 5/9] drm/panel: add atomic_check callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-5-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7281;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NDuP83zqW5zQSG3EkE86iDSunaWPu3MRqhYZ+iIkb74=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dGknLGXeDIwrZ4oAApBaKXVGnq71wwJiGAH
 Ln84UGnPSCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRgAKCRCLPIo+Aiko
 1QZpCACwimdVnYYcDuqpMTmrHjg/Kzh69uM9YoV5/nrBhvGbqlZ+VBwRtqQwI79Bqx6fkETYqjX
 hgKvH3xEqQn/9RqdUeT6myXnYGKdKDC9f66D5xFwebw5WnSmAXv9eGXVFlXvC1+hC8F2cP0b1pS
 IkWAREbSs93PI+7rHrOrEd0WpuKPBVan6Dxu/onnnmn30EQDwerPNkpM6i/d36DxGoJUQ2Y5zs/
 Dz3bzL85Nf0uXh5wd1HkjCL+L3XxUfXGAIpcAoeRU0r9xLs0iixRYd00JLikXKU5F3vIn7c3eh4
 tKxzZDs0Skeq7pZPawg5A2wW9xcjQpu+BGfkQLl0KY8qk/PI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: sHVRkoRtoar-H9-0rumFnxYluuufSxMG
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac79756 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3mQ-IjTWdeCcQhJgvQ0A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXzBHpjJFMkzr5
 tKRw0S2uu3qTb8hfX809/M5yCIXtlRSeoDUiTVQz2TDL+lGEhik83O/sdycHeyPxdtIRRlYE35V
 wJqG7xDiL7psMoPkA3wjKt5ji9ZX0rk=
X-Proofpoint-GUID: sHVRkoRtoar-H9-0rumFnxYluuufSxMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX1EU2CaIo/I63
 IQOfOB+VNxMWdHPu6OUKr9fkFTCP2/O0PqLfa6d6ZsDcUWmmEtDn8DYfcKgKJ/4keUqWaJYrwyQ
 4kxRs5egSHuJ2Zhj8bM2Pyl60y4oy1h8gnDUHoGk8UnsTJyD3fLzFzIclGd+oLdHlGSZeFTqEnl
 4EGXZdDRmgVStYQsHdco8HgMga6WoVIxkPw29EekQLXcdAn+qyUHkcc1FLzCHKi2RPNamdcQ9w0
 t78ZcnmeJxG4wsTBPQPFRJJW9sUgTpTEqdhd0VTMpmNgUsax2MehT4Py0fM8XwQwObJq/vyoJ2P
 rvuUi7nDLKKH2Por0U4hcHiUyGqNDtyIeS2SqfvU7lk1uPm9rKR0oSMNn8a2242IeJ61f7vutBq
 aM1DyWg37rE75aWLD4m3iEeedwmmGlnRQNByvlbTjZauviymTA6vTqbDqrjeqoctvAC61inh6OE
 2UqPMiBIzANmcoruphQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052
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

A panel driver cannot reject a configuration it does not support, nor
compute its state for the configuration that is being requested: none of
its callbacks is called in the check phase of an atomic update.

Add an optional atomic_check callback, called from the atomic_check of
the bridge embedded in the panel. Following the other atomic_check
callbacks it receives the whole commit rather than individual object
states.

Add helpers returning the new CRTC and connector states for a panel, so
that panel drivers don't have to open-code the walk through the encoder.

The callback is only meant for the panels using atomic state, warn about
the panels implementing it without the state callbacks.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     | 30 ++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 481caa294243..3a154be128a0 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -243,6 +243,19 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 		panel->funcs->debugfs_init(panel, root);
 }
 
+static int panel_bridge_atomic_check(struct drm_bridge *bridge,
+				     struct drm_bridge_state *bridge_state,
+				     struct drm_crtc_state *crtc_state,
+				     struct drm_connector_state *conn_state)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+
+	if (!panel->funcs->atomic_check)
+		return 0;
+
+	return panel->funcs->atomic_check(panel, crtc_state->state);
+}
+
 static struct drm_bridge_state *
 panel_bridge_atomic_create_state(struct drm_bridge *bridge)
 {
@@ -297,6 +310,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_disable = panel_bridge_atomic_disable,
 	.atomic_post_disable = panel_bridge_atomic_post_disable,
 	.get_modes = panel_bridge_get_modes,
+	.atomic_check = panel_bridge_atomic_check,
 	.atomic_create_state = panel_bridge_atomic_create_state,
 	.atomic_duplicate_state = panel_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = panel_bridge_atomic_destroy_state,
@@ -654,6 +668,9 @@ static void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		      !funcs->atomic_create_state != !funcs->atomic_destroy_state,
 		      "Panel state callbacks have to be implemented together\n");
 
+	dev_WARN_ONCE(dev, !funcs->atomic_create_state && funcs->atomic_check,
+		      "Atomic callbacks require the panel state callbacks\n");
+
 	INIT_LIST_HEAD(&panel->list);
 	INIT_LIST_HEAD(&panel->followers);
 	mutex_init(&panel->follower_lock);
@@ -1185,6 +1202,73 @@ struct drm_panel_state *drm_panel_get_current_state(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_get_current_state);
 
+/**
+ * drm_atomic_get_new_crtc_state_for_panel() - get new CRTC state for a panel
+ * @commit: global atomic state object
+ * @panel: panel to get the CRTC state for
+ *
+ * This function returns the new state of the CRTC that drives @panel as of
+ * @commit. It is meant to be used from &drm_panel_funcs.atomic_check and the
+ * enable path. In the disable path the panel might not be driven by any CRTC
+ * anymore.
+ *
+ * Return:
+ *
+ * The new CRTC state, or NULL if the panel is not driven by a CRTC that is
+ * part of the global atomic state.
+ */
+struct drm_crtc_state *
+drm_atomic_get_new_crtc_state_for_panel(struct drm_atomic_commit *commit,
+					struct drm_panel *panel)
+{
+	struct drm_encoder *encoder = panel->bridge.encoder;
+	struct drm_crtc *crtc;
+
+	if (!encoder)
+		return NULL;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(commit, encoder);
+	if (!crtc)
+		return NULL;
+
+	return drm_atomic_get_new_crtc_state(commit, crtc);
+}
+EXPORT_SYMBOL(drm_atomic_get_new_crtc_state_for_panel);
+
+/**
+ * drm_atomic_get_new_connector_state_for_panel() - get new connector state for
+ *						     a panel
+ * @commit: global atomic state object
+ * @panel: panel to get the connector state for
+ *
+ * This function returns the new state of the connector that @panel is routed
+ * to as of @commit. It is meant to be used from &drm_panel_funcs.atomic_check
+ * and the enable path. In the disable path the panel might not be routed to
+ * any connector anymore.
+ *
+ * Return:
+ *
+ * The new connector state, or NULL if the panel is not routed to a connector
+ * that is part of the global atomic state.
+ */
+struct drm_connector_state *
+drm_atomic_get_new_connector_state_for_panel(const struct drm_atomic_commit *commit,
+					     struct drm_panel *panel)
+{
+	struct drm_encoder *encoder = panel->bridge.encoder;
+	struct drm_connector *connector;
+
+	if (!encoder)
+		return NULL;
+
+	connector = drm_atomic_get_new_connector_for_encoder(commit, encoder);
+	if (!connector)
+		return NULL;
+
+	return drm_atomic_get_new_connector_state(commit, connector);
+}
+EXPORT_SYMBOL(drm_atomic_get_new_connector_state_for_panel);
+
 /**
  * drm_panel_get - Acquire a panel reference
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index ff63bed934fa..a5879b7b986b 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -38,6 +38,8 @@ struct device_node;
 struct drm_atomic_commit;
 struct drm_bridge;
 struct drm_connector;
+struct drm_connector_state;
+struct drm_crtc_state;
 struct drm_device;
 struct drm_panel_follower;
 struct drm_panel;
@@ -168,6 +170,28 @@ struct drm_panel_funcs {
 	 */
 	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
 
+	/**
+	 * @atomic_check:
+	 *
+	 * Check that the configuration requested in @commit can be handled by
+	 * the panel and compute the new panel state. The new panel state can
+	 * be retrieved with drm_atomic_get_new_panel_state(), the CRTC and
+	 * connector states with drm_atomic_get_new_crtc_state_for_panel() and
+	 * drm_atomic_get_new_connector_state_for_panel().
+	 *
+	 * This function is called in the check phase of an atomic update, it
+	 * must not touch the hardware or any persistent driver data.
+	 *
+	 * This function is optional. It can only be implemented together with
+	 * @atomic_create_state.
+	 *
+	 * Return:
+	 *
+	 * Zero if the check passed, a negative error code otherwise.
+	 */
+	int (*atomic_check)(struct drm_panel *panel,
+			    struct drm_atomic_commit *commit);
+
 	/**
 	 * @atomic_create_state:
 	 *
@@ -438,6 +462,12 @@ drm_atomic_get_old_panel_state(const struct drm_atomic_commit *commit,
 struct drm_panel_state *
 drm_atomic_get_new_panel_state(const struct drm_atomic_commit *commit,
 			       struct drm_panel *panel);
+struct drm_crtc_state *
+drm_atomic_get_new_crtc_state_for_panel(struct drm_atomic_commit *commit,
+					struct drm_panel *panel);
+struct drm_connector_state *
+drm_atomic_get_new_connector_state_for_panel(const struct drm_atomic_commit *commit,
+					     struct drm_panel *panel);
 
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);

-- 
2.47.3

