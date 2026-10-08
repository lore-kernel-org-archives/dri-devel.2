Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28585CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF0310E84D;
	Thu,  8 Oct 2026 13:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSdatKod";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Skoiz7Vr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0310E840
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:15:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698CXJqR2763147
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GMVLjHiN77JDF3XhX8hA0in6DLXXVD21cTvzqwETSIU=; b=FSdatKodN0qDDlH8
 i1DtYnp1VxH8IM3zqM7rlwXYGh1DRiNtWp9MNzkqc41V+QyNgOQGR/Odr/jrhnCV
 Hva+QXfAmw9WVS37+iIraeTbOAkbEe0iQreEA3A0XLCX5VMHWeLlTGzCQ3dGMIrB
 eMml7vntOJ4HGSN5q+8ONB5Gd+4HA0F4EQPWeBh56QX75lVX5scyBDbhKdlJmk15
 DU+3w4NTRqHwslcjfbdxKxFPszC9q0kIi8S3YeyQdLaGsHhQ0a9lJeRb94/6qWPK
 5gbTjOKH2GsS1Nlip4b2kjcLuqc9t8W8vLrKKzBp6CJ/IGdTJtthcYodNsCc37jU
 o0rEuA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kg51j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:15:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c124d17880so919763137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465299; x=1792070099;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GMVLjHiN77JDF3XhX8hA0in6DLXXVD21cTvzqwETSIU=;
 b=Skoiz7VrLVXUgO/1/GXwHr1N8h7DwD3kfbNc8b1GdHqC01TkgkSMIdOSFei9noiFrO
 XG6hKV4ldWWLORe/qHr5FWCp+a1YWePfFVkjl5SmF7/gSXwS0KOooO42qNTcmkr2FNZF
 NYvdCMMPKHVv5b38/2cmIowbWDEdxpJ+9QVvFcwI0F8Lo6t//NFhaEe7/sRzspSoPGMl
 ZZK7E8SbJzIkv1nKAK21gMVdX+E/0Gj/7d+L5yxxf1iSkaIBnp0ohdHvWwNkWIbXgMRr
 bOKjGzHK4TJfpECdjQ2ZxCSa/wp72L/wtpqLSTwE9WslnF6eR3WvHuDXbrmhnMI26/yW
 LD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465299; x=1792070099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GMVLjHiN77JDF3XhX8hA0in6DLXXVD21cTvzqwETSIU=;
 b=CK3NOdVXprsPSOZY5I3+0oemTzvBDZ4/wz8ZuwKwKHDwDU0K2+nHngfXGQqX3m9wn0
 JjNyQj0kgC5tX60N7lKrNDKCb+cTdQBGhCRHtlCWwieJGsOwLcwSOFhuwf0bu2lAbZlH
 qzUjRfagNGd4bvxe0ZJWwwhP9Lo7Qh6PPFxJukqjjflbS5Jn1Ei30FPNBm82k2CRpmZx
 68a8Ar5PmQNbtRlIZRaWBIe+lhva2zDEPSEqpjNLxZ+P+FEcA0wcfUfC9OPNXvFtKSqX
 yJxgx3NikUN9AQojGrORPWfBe1RAbl3HqBL7VXz+CJQcgYozaLBiFl9NScjZpb5pomsm
 96SA==
X-Gm-Message-State: AFq9FYKSc+hZeElBZ1iDSF91oTk0vyyJkYgjyLcEJ1zo/Cy21PN/08h+
 F0E2ttaYA3eLUDWR4hFAhPjcbMhC9d6/SKSbJLK6fmV/KWiKCChoJXSuT2mYcMj2DdpMHmXYjIx
 1a1jrME+PFrdBcDxUBZRfTyIzWPclEoaO+Vg0nlpuAddDH6aWpd8hUcTNnUEtBnZX8Mc2nao=
X-Gm-Gg: AYBFou0o/OSBNTwptoOzn62nBfxrQdHnCL8pLckF5coDPiDrLomFESHV+QC9EujD6Eb
 8TKVHu8rUihmINOobE+wp3zM6YTcvN9FaILHkuIxrzoDdQ7Nxg0ujpm7FL6BYpPz6xHtarbq9AQ
 IdKDjUN/hfXoF7FVyBd4o3eY75Jr+WnHh8wtQqGKiRFRV0fXECMjitjRCFoXZ7wS1em3fNp/KGb
 n7nktkBi0nK+tkBOZn1qzOvpW1OtVrKvhj65VJhHRyuJGCEUYvVRwSwG0XosRUqJKTNfqG+USbg
 5uPG6D2Hqcd5t+w/TRl9NS8OhNC1XvIDIurhK/TCiYP8PzyPy2SgCfZ3vvm5NmlIZfepkxKBSSK
 AKH7F3tXfJEcbeX2hT+RnDZKdomiih3hsO2opeUEgywMGpvoGTga3p6ot6YfBycyiIUyfdYBcjA
 KgufClJdyTObu/
X-Received: by 2002:a05:6102:2c0d:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7ca393604bamr1267181137.36.1791465299083; 
 Thu, 08 Oct 2026 06:14:59 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0d:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7ca393604bamr1267154137.36.1791465298371; 
 Thu, 08 Oct 2026 06:14:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:26 +0300
Subject: [PATCH RFC 4/9] drm/panel: add atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-4-b157fddb8de1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20845;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ryNN3DmrHi8XXS0qn5CJ7WTWFsktpdUnGV4Ax3o5lVI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9bx6W7ipcq9vl/T72R/eb9OdjNzmsPbnFuRifzpLU3up
 xm35Ut1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAin15xMMx0D/S0qzmioMvZ
 t/Z557Y838t/7+uHC6QJrApSXBohVsvfcPzB/8du58W8VqvZrOMKzOLRXqi4JDTYWMOe80hugoP
 7m+seMcYzrS7laWapr5m8+udZc15P/wXrFJ9lhkYlGd/Yuc/J6sGzW9cz9rgtc/i3cnb2S6Wyoo
 aQ+Zc3X4uslN7JmCCk3udpkr39nMvUjn83y5MP3//Ex97LI2XyOO1Q2zemmr2CNqXmzGouUn06D
 4Knfp3olDLt72SeCum54hf0uJa1LO0OqsjdvevyD6FtJw8kHTQq6vDevnVXp/67dXGHM00Dbx3w
 MO12+DjLa0a5V1minj4L99I1gqKlzxf+TrKdJfBor+BnAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: bngA8EdWDFQzAS9eG3bjS2Ng8Tw8pEgR
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac79754 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ms1Gz_XUBqPSZgH_T3AA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXy2jj6DUdgn5f
 3/K5NPqGaH7lGCAFgxY9qZ9C8wo4bWC6pmxumsruXRoH2MnV2M3kbSc14tM4jFAbPHqprmwpXu+
 +wgcOD0SjQ83fIcIE2m5eTsXZZqscxE=
X-Proofpoint-GUID: bngA8EdWDFQzAS9eG3bjS2Ng8Tw8pEgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXxX0yuQE/aMnh
 0gC5wEH/T0k3z8BkOzgHW+KxikAnrHWHQTTa5F8h1bliE5Ky9J85NsPilruAo36oFHvdbzsviHH
 1RBJ7i+69GNc/S9WBYui+ZG72T+QCk5TLxsrdCSNtugHEjx9udTkA+Hw5/djtAAMgta+OZIR5fw
 jHJY2OJmouKgI952Xc5lxJPkGuh6/f3ydU8RJ0Ht2Q8TnDxO4oSICCs2eB4elag4w9SwviaahMQ
 RT7aaN4Q6CYftGQrEclY2m0OfEaggDMrCwTQjiuqhnpnw8b0MZRyFfzrYuq917q3opZWEkO+ZBS
 u359WlVnBX0/QlGtmxGCQ76uJNBgKTJNqZJUkqP+INvWcynGBdM39pltOZGSlFvdvsD4JxxMlmI
 7m2esvLuuuy4yiCEYN26GYhzVj+JuEBlvWIrxEhXv/CzdAAVt/yMjgjtss6a69qoMq8yINObB9a
 K0V4vWrzXePHqdbjBsw==
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

Panel drivers have no way to track per-commit configuration. A panel
that supports several modes, or that needs different programming
depending on the selected configuration, has to keep that information in
its driver data, where it is neither checked at atomic_check time nor
tied to the commit that is being applied.

Every drm_panel embeds a drm_bridge, and that bridge already carries an
atomic state, but it is the plain drm_bridge_state and the panel driver
never sees it.

Introduce struct drm_panel_state, wrapping drm_bridge_state. As for the
other atomic objects, a panel gets it by implementing the
atomic_create_state, atomic_duplicate_state and atomic_destroy_state
callbacks, either with the default helpers or with its own functions if
it subclasses the state. Add accessors to get the old, new and current
panel state.

Panels not implementing these callbacks keep using the plain bridge
state, nothing changes for them.

The panel state only exists once the embedded bridge has been attached
to an encoder, which is not the case for the display drivers calling
drm_panel_prepare() and its counterparts directly. Make these functions
refuse to handle the panels using atomic state.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/gpu/drm-kms-helpers.rst |   3 +
 drivers/gpu/drm/drm_panel.c           | 301 +++++++++++++++++++++++++++++++++-
 include/drm/drm_panel.h               |  95 +++++++++++
 3 files changed, 396 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index d64f941d34f5..305c24be7f4b 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -229,6 +229,9 @@ Panel Helper Reference
 .. kernel-doc:: drivers/gpu/drm/drm_panel.c
    :doc: drm panel
 
+.. kernel-doc:: drivers/gpu/drm/drm_panel.c
+   :doc: drm panel atomic state
+
 .. kernel-doc:: include/drm/drm_panel.h
    :internal:
 
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c00529bfb706..481caa294243 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -38,6 +39,32 @@ static LIST_HEAD(panel_list);
  * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
  */
 
+/**
+ * DOC: drm panel atomic state
+ *
+ * Panels that only support a single configuration can be fully described by
+ * the &drm_panel_funcs.prepare, &drm_panel_funcs.enable,
+ * &drm_panel_funcs.disable and &drm_panel_funcs.unprepare callbacks.
+ *
+ * Panels whose programming depends on the configuration being applied, for
+ * example panels supporting several modes, should track that configuration in
+ * the atomic state instead of the driver data. Such panels get a
+ * &struct drm_panel_state by implementing
+ * &drm_panel_funcs.atomic_create_state,
+ * &drm_panel_funcs.atomic_duplicate_state and
+ * &drm_panel_funcs.atomic_destroy_state, either with the
+ * drm_atomic_helper_panel_create_state(),
+ * drm_atomic_helper_panel_duplicate_state() and
+ * drm_atomic_helper_panel_destroy_state() helpers or with their own functions
+ * if they subclass the state.
+ *
+ * The panel state is the state of the &drm_bridge embedded in the panel. It
+ * only exists once that bridge has been attached to an encoder, so the panels
+ * using atomic state can only be used by display drivers going through the
+ * bridge. Such panel drivers must not call drm_panel_disable() or
+ * drm_panel_unprepare() from their remove or shutdown callbacks either.
+ */
+
 static inline struct drm_panel *
 drm_bridge_to_panel(const struct drm_bridge *bridge)
 {
@@ -216,6 +243,52 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 		panel->funcs->debugfs_init(panel, root);
 }
 
+static struct drm_bridge_state *
+panel_bridge_atomic_create_state(struct drm_bridge *bridge)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+	struct drm_panel_state *panel_state;
+
+	if (!panel->funcs->atomic_create_state)
+		return drm_atomic_helper_bridge_create_state(bridge);
+
+	panel_state = panel->funcs->atomic_create_state(panel);
+	if (IS_ERR(panel_state))
+		return ERR_CAST(panel_state);
+
+	return &panel_state->base;
+}
+
+static struct drm_bridge_state *
+panel_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+	struct drm_panel_state *panel_state;
+
+	if (!panel->funcs->atomic_duplicate_state)
+		return drm_atomic_helper_bridge_duplicate_state(bridge);
+
+	panel_state = panel->funcs->atomic_duplicate_state(panel);
+	if (!panel_state)
+		return NULL;
+
+	return &panel_state->base;
+}
+
+static void panel_bridge_atomic_destroy_state(struct drm_bridge *bridge,
+					      struct drm_bridge_state *bridge_state)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+
+	if (!panel->funcs->atomic_destroy_state) {
+		drm_atomic_helper_bridge_destroy_state(bridge, bridge_state);
+		return;
+	}
+
+	panel->funcs->atomic_destroy_state(panel,
+					   drm_bridge_state_to_panel_state(bridge_state));
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
@@ -224,9 +297,9 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_disable = panel_bridge_atomic_disable,
 	.atomic_post_disable = panel_bridge_atomic_post_disable,
 	.get_modes = panel_bridge_get_modes,
-	.atomic_create_state = drm_atomic_helper_bridge_create_state,
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_create_state = panel_bridge_atomic_create_state,
+	.atomic_duplicate_state = panel_bridge_atomic_duplicate_state,
+	.atomic_destroy_state = panel_bridge_atomic_destroy_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.debugfs_init = panel_bridge_debugfs_init,
 };
@@ -576,6 +649,11 @@ static void drm_panel_init(struct drm_panel *panel, struct device *dev,
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
 
+	dev_WARN_ONCE(dev,
+		      !funcs->atomic_create_state != !funcs->atomic_duplicate_state ||
+		      !funcs->atomic_create_state != !funcs->atomic_destroy_state,
+		      "Panel state callbacks have to be implemented together\n");
+
 	INIT_LIST_HEAD(&panel->list);
 	INIT_LIST_HEAD(&panel->followers);
 	mutex_init(&panel->follower_lock);
@@ -657,6 +735,9 @@ EXPORT_SYMBOL(devm_drm_panel_add);
  * integrated circuitry via a command bus. This function cannot fail (as it is
  * called from the pre_enable call chain). There will always be a call to
  * drm_panel_disable() afterwards.
+ *
+ * This function can not be used with the panels using atomic state, those are
+ * only supported through the bridge embedded in the panel.
  */
 void drm_panel_prepare(struct drm_panel *panel)
 {
@@ -666,6 +747,10 @@ void drm_panel_prepare(struct drm_panel *panel)
 	if (!panel)
 		return;
 
+	if (dev_WARN_ONCE(panel->dev, panel->funcs->atomic_create_state,
+			  "Atomic panels have to be driven through the bridge\n"))
+		return;
+
 	if (panel->prepared) {
 		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
 		return;
@@ -703,6 +788,9 @@ EXPORT_SYMBOL(drm_panel_prepare);
  * reset, turn off power supplies, ...). After this function has completed, it
  * is usually no longer possible to communicate with the panel until another
  * call to drm_panel_prepare().
+ *
+ * This function can not be used with the panels using atomic state, those are
+ * only supported through the bridge embedded in the panel.
  */
 void drm_panel_unprepare(struct drm_panel *panel)
 {
@@ -712,6 +800,10 @@ void drm_panel_unprepare(struct drm_panel *panel)
 	if (!panel)
 		return;
 
+	if (dev_WARN_ONCE(panel->dev, panel->funcs->atomic_create_state,
+			  "Atomic panels have to be driven through the bridge\n"))
+		return;
+
 	/*
 	 * If you are seeing the warning below it likely means one of two things:
 	 * - Your panel driver incorrectly calls drm_panel_unprepare() in its
@@ -759,6 +851,9 @@ EXPORT_SYMBOL(drm_panel_unprepare);
  * this call completes. This function cannot fail (as it is called from the
  * enable call chain). There will always be a call to drm_panel_disable()
  * afterwards.
+ *
+ * This function can not be used with the panels using atomic state, those are
+ * only supported through the bridge embedded in the panel.
  */
 void drm_panel_enable(struct drm_panel *panel)
 {
@@ -768,6 +863,10 @@ void drm_panel_enable(struct drm_panel *panel)
 	if (!panel)
 		return;
 
+	if (dev_WARN_ONCE(panel->dev, panel->funcs->atomic_create_state,
+			  "Atomic panels have to be driven through the bridge\n"))
+		return;
+
 	if (panel->enabled) {
 		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
 		return;
@@ -809,6 +908,9 @@ EXPORT_SYMBOL(drm_panel_enable);
  * This will typically turn off the panel's backlight or disable the display
  * drivers. For smart panels it should still be possible to communicate with
  * the integrated circuitry via any command bus after this call.
+ *
+ * This function can not be used with the panels using atomic state, those are
+ * only supported through the bridge embedded in the panel.
  */
 void drm_panel_disable(struct drm_panel *panel)
 {
@@ -818,6 +920,10 @@ void drm_panel_disable(struct drm_panel *panel)
 	if (!panel)
 		return;
 
+	if (dev_WARN_ONCE(panel->dev, panel->funcs->atomic_create_state,
+			  "Atomic panels have to be driven through the bridge\n"))
+		return;
+
 	/*
 	 * If you are seeing the warning below it likely means one of two things:
 	 * - Your panel driver incorrectly calls drm_panel_disable() in its
@@ -890,6 +996,195 @@ int drm_panel_get_modes(struct drm_panel *panel,
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
+/**
+ * __drm_atomic_helper_panel_state_init() - Initialize a panel state to its
+ *					     default
+ * @state: panel state to initialize
+ * @panel: the panel this state refers to
+ *
+ * @state is assumed to be zeroed.
+ *
+ * Initializes the panel state to default values. This is meant to be called
+ * by the panel &drm_panel_funcs.atomic_create_state hook for panels that
+ * subclass the panel state.
+ */
+void __drm_atomic_helper_panel_state_init(struct drm_panel_state *state,
+					  struct drm_panel *panel)
+{
+	__drm_atomic_helper_bridge_state_init(&state->base, &panel->bridge);
+}
+EXPORT_SYMBOL(__drm_atomic_helper_panel_state_init);
+
+/**
+ * __drm_atomic_helper_panel_duplicate_state() - Copy atomic panel state
+ * @panel: panel object
+ * @state: atomic panel state
+ *
+ * Copies atomic state from a panel's current state. This is meant to be
+ * called by the panel &drm_panel_funcs.atomic_duplicate_state hook for panels
+ * that subclass the panel state.
+ */
+void __drm_atomic_helper_panel_duplicate_state(struct drm_panel *panel,
+					       struct drm_panel_state *state)
+{
+	__drm_atomic_helper_bridge_duplicate_state(&panel->bridge, &state->base);
+}
+EXPORT_SYMBOL(__drm_atomic_helper_panel_duplicate_state);
+
+/**
+ * drm_atomic_helper_panel_create_state() - default
+ *		&drm_panel_funcs.atomic_create_state hook for panels
+ * @panel: panel object
+ *
+ * Allocates and initializes a pristine &drm_panel_state. This is meant to be
+ * used by panels that don't subclass the panel state.
+ *
+ * Return:
+ *
+ * Pointer to the new panel state, or an error pointer on failure.
+ */
+struct drm_panel_state *
+drm_atomic_helper_panel_create_state(struct drm_panel *panel)
+{
+	struct drm_panel_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_panel_state_init(state, panel);
+
+	return state;
+}
+EXPORT_SYMBOL(drm_atomic_helper_panel_create_state);
+
+/**
+ * drm_atomic_helper_panel_duplicate_state() - default
+ *		&drm_panel_funcs.atomic_duplicate_state hook for panels
+ * @panel: panel object
+ *
+ * Allocates a new panel state and initializes it with the current panel state
+ * values. This is meant to be used by panels that don't subclass the panel
+ * state.
+ *
+ * Return:
+ *
+ * Pointer to the new panel state, or NULL on failure.
+ */
+struct drm_panel_state *
+drm_atomic_helper_panel_duplicate_state(struct drm_panel *panel)
+{
+	struct drm_panel_state *state;
+
+	if (drm_WARN_ON(panel->bridge.dev, !panel->bridge.base.state))
+		return NULL;
+
+	state = kzalloc_obj(*state);
+	if (state)
+		__drm_atomic_helper_panel_duplicate_state(panel, state);
+
+	return state;
+}
+EXPORT_SYMBOL(drm_atomic_helper_panel_duplicate_state);
+
+/**
+ * drm_atomic_helper_panel_destroy_state() - default
+ *		&drm_panel_funcs.atomic_destroy_state hook for panels
+ * @panel: panel object
+ * @state: panel state to destroy
+ *
+ * Destroys a panel state previously created by
+ * drm_atomic_helper_panel_create_state() or
+ * drm_atomic_helper_panel_duplicate_state(). This is meant to be used by panels
+ * that don't subclass the panel state.
+ */
+void drm_atomic_helper_panel_destroy_state(struct drm_panel *panel,
+					   struct drm_panel_state *state)
+{
+	kfree(state);
+}
+EXPORT_SYMBOL(drm_atomic_helper_panel_destroy_state);
+
+/**
+ * drm_atomic_get_old_panel_state() - get old panel state, if it exists
+ * @commit: global atomic state object
+ * @panel: panel to grab
+ *
+ * Return:
+ *
+ * The old panel state for the given panel, or NULL if the panel is not part of
+ * the global atomic state or does not implement the panel state callbacks.
+ */
+struct drm_panel_state *
+drm_atomic_get_old_panel_state(const struct drm_atomic_commit *commit,
+			       struct drm_panel *panel)
+{
+	struct drm_bridge_state *bridge_state;
+
+	if (!panel->funcs->atomic_create_state)
+		return NULL;
+
+	bridge_state = drm_atomic_get_old_bridge_state(commit, &panel->bridge);
+	if (!bridge_state)
+		return NULL;
+
+	return drm_bridge_state_to_panel_state(bridge_state);
+}
+EXPORT_SYMBOL(drm_atomic_get_old_panel_state);
+
+/**
+ * drm_atomic_get_new_panel_state() - get new panel state, if it exists
+ * @commit: global atomic state object
+ * @panel: panel to grab
+ *
+ * Return:
+ *
+ * The new panel state for the given panel, or NULL if the panel is not part of
+ * the global atomic state or does not implement the panel state callbacks.
+ */
+struct drm_panel_state *
+drm_atomic_get_new_panel_state(const struct drm_atomic_commit *commit,
+			       struct drm_panel *panel)
+{
+	struct drm_bridge_state *bridge_state;
+
+	if (!panel->funcs->atomic_create_state)
+		return NULL;
+
+	bridge_state = drm_atomic_get_new_bridge_state(commit, &panel->bridge);
+	if (!bridge_state)
+		return NULL;
+
+	return drm_bridge_state_to_panel_state(bridge_state);
+}
+EXPORT_SYMBOL(drm_atomic_get_new_panel_state);
+
+/**
+ * drm_panel_get_current_state() - get the current panel state
+ * @panel: panel object
+ *
+ * This function must be called with the modeset lock held.
+ *
+ * Return:
+ *
+ * The current panel state, or NULL if there is none or if the panel does not
+ * implement the panel state callbacks.
+ */
+struct drm_panel_state *drm_panel_get_current_state(struct drm_panel *panel)
+{
+	struct drm_bridge_state *bridge_state;
+
+	if (!panel || !panel->funcs->atomic_create_state)
+		return NULL;
+
+	bridge_state = drm_bridge_get_current_state(&panel->bridge);
+	if (!bridge_state)
+		return NULL;
+
+	return drm_bridge_state_to_panel_state(bridge_state);
+}
+EXPORT_SYMBOL(drm_panel_get_current_state);
+
 /**
  * drm_panel_get - Acquire a panel reference
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a..ff63bed934fa 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -35,6 +35,7 @@
 struct backlight_device;
 struct dentry;
 struct device_node;
+struct drm_atomic_commit;
 struct drm_bridge;
 struct drm_connector;
 struct drm_device;
@@ -44,6 +45,24 @@ struct display_timing;
 
 enum drm_panel_orientation;
 
+/**
+ * struct drm_panel_state - Atomic panel state object
+ *
+ * Only panels implementing &drm_panel_funcs.atomic_create_state,
+ * &drm_panel_funcs.atomic_duplicate_state and
+ * &drm_panel_funcs.atomic_destroy_state have a panel state. Panel drivers
+ * that need to track additional state can subclass this structure.
+ */
+struct drm_panel_state {
+	/**
+	 * @base: inherit from &drm_bridge_state
+	 */
+	struct drm_bridge_state base;
+};
+
+#define drm_bridge_state_to_panel_state(bridge_state) \
+	container_of_const(bridge_state, struct drm_panel_state, base)
+
 /**
  * struct drm_panel_funcs - perform operations on a given panel
  *
@@ -148,6 +167,62 @@ struct drm_panel_funcs {
 	 * Allows panels to create panels-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
+
+	/**
+	 * @atomic_create_state:
+	 *
+	 * Allocate a pristine, initialized, state for the panel and return
+	 * it. This callback must have no side effects: in particular, it must
+	 * not affect the hardware state.
+	 *
+	 * Drivers that subclass &drm_panel_state should use
+	 * __drm_atomic_helper_panel_state_init() to initialize the base
+	 * structure, the other drivers should use
+	 * drm_atomic_helper_panel_create_state().
+	 *
+	 * This function is optional, panels not implementing it don't have a
+	 * panel state. It must be implemented together with
+	 * @atomic_duplicate_state and @atomic_destroy_state.
+	 *
+	 * Return:
+	 *
+	 * A new, pristine, panel state instance or an error pointer on
+	 * failure.
+	 */
+	struct drm_panel_state *(*atomic_create_state)(struct drm_panel *panel);
+
+	/**
+	 * @atomic_duplicate_state:
+	 *
+	 * Duplicate the current panel state and return it.
+	 *
+	 * Drivers that subclass &drm_panel_state should use
+	 * __drm_atomic_helper_panel_duplicate_state() to duplicate the base
+	 * structure, the other drivers should use
+	 * drm_atomic_helper_panel_duplicate_state().
+	 *
+	 * This function is optional. It must be implemented together with
+	 * @atomic_create_state and @atomic_destroy_state.
+	 *
+	 * Return:
+	 *
+	 * A valid &drm_panel_state object or NULL if the allocation fails.
+	 */
+	struct drm_panel_state *(*atomic_duplicate_state)(struct drm_panel *panel);
+
+	/**
+	 * @atomic_destroy_state:
+	 *
+	 * Destroy a panel state object previously allocated by
+	 * @atomic_create_state or @atomic_duplicate_state. Drivers that don't
+	 * subclass &drm_panel_state should use
+	 * drm_atomic_helper_panel_destroy_state().
+	 *
+	 * This function is optional. It must be implemented together with
+	 * @atomic_create_state and @atomic_duplicate_state.
+	 */
+	void (*atomic_destroy_state)(struct drm_panel *panel,
+				     struct drm_panel_state *state);
 };
 
 struct drm_panel_follower_funcs {
@@ -344,6 +419,26 @@ void drm_panel_disable(struct drm_panel *panel);
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
+void __drm_atomic_helper_panel_state_init(struct drm_panel_state *state,
+					  struct drm_panel *panel);
+void __drm_atomic_helper_panel_duplicate_state(struct drm_panel *panel,
+					       struct drm_panel_state *state);
+struct drm_panel_state *
+drm_atomic_helper_panel_create_state(struct drm_panel *panel);
+struct drm_panel_state *
+drm_atomic_helper_panel_duplicate_state(struct drm_panel *panel);
+void drm_atomic_helper_panel_destroy_state(struct drm_panel *panel,
+					   struct drm_panel_state *state);
+
+struct drm_panel_state *drm_panel_get_current_state(struct drm_panel *panel);
+
+struct drm_panel_state *
+drm_atomic_get_old_panel_state(const struct drm_atomic_commit *commit,
+			       struct drm_panel *panel);
+struct drm_panel_state *
+drm_atomic_get_new_panel_state(const struct drm_atomic_commit *commit,
+			       struct drm_panel *panel);
+
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
 int drm_of_find_panel_or_bridge(const struct device_node *np,

-- 
2.47.3

