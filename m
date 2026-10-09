Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5157CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F0910FE25;
	Fri,  9 Oct 2026 03:18:18 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2AA10FE29;
 Fri,  9 Oct 2026 03:18:17 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515826t0fda5ad6
X-QQ-Originating-IP: 1m0x0heME81gQiDrvyw1IQiDZIStO9MbFOMmJ8xkQy4=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 359533307684351837
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:53 +0800
Subject: [PATCH v2 01/20] drm/atomic: Handle max bpc properties before
 connector state allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-1-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5131; i=sophon@radxa.com;
 h=from:subject:message-id; bh=iY5Uc1xTCGczUi0dqQkmwt1qtcO7yk+6gKr9GQ/UnJk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZs31B1zKVURPdXms5Xgb0XHiqV7Y54feWedc4eE
 SZm2Uy+jlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABMR2cDwh/NZnu31jX6Lqxll
 dy98ejFAjcdId0Nq03nWSoMXD6eo1DEy9O14VH7ZRCs32K2i/e82Dim96YFzGE+Z+7k7n9y4mTO
 eFQA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OY7kNFRo2XI4LjaELtbWp4MX8GvTVWZ5i/VWNxsnow/bbPcfG7q2quAS
 KBHLk73P9ddghRcc/5BLLAE0LcqFCn1kPXAt/CVYEQNTbxELqAnJLsJTYAnnrzOI9NBj9Me
 UluLZvF1Kk40VrcsYZlMmE2R8nRRjiDtk+WsyzZuUVS75fEwCxMcJvZxzPGh1hIxF15ctje
 crDsRiHWg3iea9MGpwzug6GnMvG2soi/DzVtBRSGrHzW40BGsCxSa11ixKisDslVxWamkYY
 CMdIaYRgd6QgbKdtxvTB511IVT5M7O19T5cST7EUuV9oPFAK89nhCtVBRVWZnYASafOJeDn
 C23e7oxFSaM9apZtYH1NawA3RT1L7dTGt+2Nri8H02IWdJqjeVVaoaJmKWOBEfbyU2WAyV7
 QnAFeBu8957IoaSyOlnfYYafM28v3aoYdO7SNTc1OnH2KNWlWsyogQCogmYfEV+t+Epo76r
 ms9eb3ZNy3r43mpIF6BdESx89gLWXbBTrb6T/OskqObk2FRW3gEs2Nzm6jiJEseCJe9kzF1
 EPU47iVvlhzZXYEc7sMXUvRqlEyze4+RqKslGfXUif+u7Sv+11asS9cr5WEYHZlV+m7wtLw
 rbE26/ZLWwCSAO4ag3bTNjjBS57as5ey3ZwCi4Mt0ahIneKvtXc7MkfeMk+ONFICsAW1Pdi
 RtfYddUsrGBvm86VrIBIk4ReMP4KjlZT2W33oQe3yrXZ4JZJTT08P9A6WNxt8R2N5D31fxt
 Ur1X6iWht83BtkGZCC/ZRz3KSFeRDQYLT6g6ZeUNbYgKocGTs7OB+tH8bXs2bP9vO5NZcZL
 hBQwtAvFZN9RVxZ1BcM247m5c2x838HzKTudJUdDCQsFnEbSqG09i7eQ2//YfzLr8z0795e
 zi0FVikXJEqX9U1ncfeXJ1/lgGsk1WgezI/tEO0t7HrOFPubqF7R9+mlvt1S24iizAvEtRW
 vLjMiYOwjWTgUbzAcTytiz2sNHyaNPxB3xikzCywy559c+VY8xB8uxGcECgW2qtGkxNo/t1
 Ir3X+KrauMwgKKOGK5TwkhV1Q7DPRgzYBxWXIi/g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
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

Allow drivers to attach the max bpc property before allocating connector
state, as needed by the upcoming non-HDMI bridge connector support.
Only update the current state when one exists.

Initialize max_requested_bpc and max_bpc from the attached property default
when creating connector state. Use drm_object_property_get_default_value()
rather than the range maximum so that state creation and subsequent resets
restore the value chosen when attaching the property.

Cover deferred allocation, existing state and restoration of a default
that differs from the range maximum in the connector KUnit tests.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c  |  8 +++++
 drivers/gpu/drm/drm_connector.c            |  6 ++--
 drivers/gpu/drm/tests/drm_connector_test.c | 53 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index a2ef272e9f27..8352b5a9097a 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -494,7 +494,15 @@ void
 __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					 struct drm_connector *connector)
 {
+	u64 val;
+
 	conn_state->connector = connector;
+	if (connector->max_bpc_property &&
+	    !drm_object_property_get_default_value(&connector->base,
+						   connector->max_bpc_property, &val)) {
+		conn_state->max_requested_bpc = val;
+		conn_state->max_bpc = val;
+	}
 }
 EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..34c30469f405 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2886,8 +2886,10 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 	}
 
 	drm_object_attach_property(&connector->base, prop, max);
-	connector->state->max_requested_bpc = max;
-	connector->state->max_bpc = max;
+	if (connector->state) {
+		connector->state->max_requested_bpc = max;
+		connector->state->max_bpc = max;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index beb1d50a6646..1174607441b9 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -12,6 +12,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_property.h>
 
 #include <drm/display/drm_hdmi_helper.h>
 
@@ -187,7 +188,59 @@ KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
 		  drm_connector_init_type_valid_tests,
 		  drm_connector_init_type_desc);
 
+/* The attached default need not equal the upper end of the property range. */
+static void drm_test_connector_max_bpc_default(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_property *prop;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, connector, &dummy_funcs,
+				  DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	prop = drm_property_create_range(&priv->drm, 0, "max bpc", 6, 12);
+	KUNIT_ASSERT_NOT_NULL(test, prop);
+	connector->max_bpc_property = prop;
+	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NULL(test, connector->state);
+
+	drm_mode_config_reset(&priv->drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->max_requested_bpc, 10);
+	KUNIT_EXPECT_EQ(test, connector->state->max_bpc, 10);
+
+	connector->state->max_requested_bpc = 8;
+	connector->state->max_bpc = 8;
+	drm_mode_config_reset(&priv->drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->max_requested_bpc, 10);
+	KUNIT_EXPECT_EQ(test, connector->state->max_bpc, 10);
+}
+
+static void drm_test_connector_max_bpc_existing_state(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector *connector = &priv->connector;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, connector, &dummy_funcs,
+				  DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_mode_config_reset(&priv->drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+
+	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, connector->state->max_requested_bpc, 10);
+	KUNIT_EXPECT_EQ(test, connector->state->max_bpc, 10);
+}
+
 static struct kunit_case drmm_connector_init_tests[] = {
+	KUNIT_CASE(drm_test_connector_max_bpc_default),
+	KUNIT_CASE(drm_test_connector_max_bpc_existing_state),
 	KUNIT_CASE(drm_test_drmm_connector_init),
 	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
 	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,

-- 
2.56.0

