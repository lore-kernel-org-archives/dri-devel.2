Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA64CCA5FC6
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4231E10F3A8;
	Wed, 30 Sep 2026 12:44:37 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B7110F39E;
 Wed, 30 Sep 2026 12:44:31 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772140t680fd5c8
X-QQ-Originating-IP: 6gXj8k4IFRk9DPHx7mQcZTfS1KofIcp9A9Oj5xufV3g=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3638371730461214938
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:45 +0800
Subject: [PATCH 01/13] drm/atomic: Handle max bpc properties before
 connector state allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=sophon@radxa.com;
 h=from:subject:message-id; bh=nFi+q46n+KrKRy5JWoWLaPT1tZJymG6zCNBTG0u4Z4U=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZf+2rctYqaQ/vvFvrfD9stvTN0ZefrHDSWtM7u31
 i3w2VG+v6OUhUGMi0FWTJFFIZ5hLntl7rWnYqV6MHNYmUCGMHBxCsBENmky/OH4tP/RNfnSSScD
 rOXZzzjVHJyYt+NC3vkLLMxMBzKvz3jHyPBuhtCN5QIf5bUkmqtr+VYJvuLm+3QsXq6mZ2etT6L
 LG0YA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nuk8bQLQf5MZi4JC39UudMFbwOQRRPw2eA+hG2yR8sZkpQ2xqg/NAbOb
 C1Ov7qK5uQa0B2fNubDbP8IswlxN3pIou7yCupwOt91f8/0jRnzhWIJDvYS70O5w18VWoKc
 73Kfqzgv7ovjfQdZV6KQ2CqsfsKa+vcO6cXdKKy9jKWqANL8QOXYqANRIbII5YbSkqYtPza
 5QPfOGedxNRECyb54BAXVeJEeDMRfRZ319qFIKEewtOwBjuvXyKH5v+xg2ox9AaqbTwtq5C
 pMTN7TPhrETW6+SgJGT1xg5JI8An4atu9u3Gmspcv2EzfAVZ2qXTYXz4aRZjlmgKW06Nmgj
 3yHUW8sfGCJ/eTiTgRJwkvbNDbqh1E5FKjQfQqNkVooHaUk6VuPIIjarsi04Rtmy9aRai1g
 aBuv95T+R0M9JxuUFMI9oVkoFSrOrsMraqdG8xEMXAVFlWElAjUuYXOmX2yG8eo7DMQ0udJ
 cXvwnNKqk3bwGi4RibiO7ZQ+sU63mO6wmTsRdZLTxalYoJSm5rYiEBNOdK7zNLop58mu4vY
 665OioKWH+M7mmhgtBMgnCM9VjlzC22nvpgYJhz+kMHBiut4S4s/srufrddaXmI1h6hwrvn
 GZWze20wiikL/LhIx4miI4AWAHgTaiSCXPqRYXiSlUMUkczXYAG7/IQBYCsMGiTftli/5D/
 0mSaakoSQvoV/7kYfnGp+cDHUhguDBYTDLHoLGrHbqtkudjiWkO4At020Dl75aVmq1RU1Gv
 upsPESBt8SSCxBpZybK1oePgbaNgnTY4Dt6JQIuxQbspAfB1RlctAQU0c5LSPm2iTDwux1N
 V6Zg7oxPTtW7HCa7nilDpBoyCXp8iqNY6kq7i+mTS0fv/IKEflAfvdfO0bx1CsV7+81E1mD
 qetZoUGcex4pZ+9JLudrzDw6fzv5uNpcAfLq2MbmFdNtNxYbuK9VpAuo7soQ5zqhTsV49YX
 vaudJnVwJAw4UslDFivdTT60bm9cUZsR/itPKvURWISLbFJxvNrAItbS//tvtOEj/RUY8bO
 JUp/WRfsFU9TMcjemtoGMuiLfdhXs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

Bridge connectors can attach the max bpc property before their atomic
state is allocated by drm_mode_config_reset(). Unconditionally updating
connector->state in drm_connector_attach_max_bpc_property() dereferences
a NULL pointer in this case. Adding max bpc support to MSM DP and eDP
exposes this during display initialization, before a framebuffer console
is available.

Only update an existing state when attaching the property. Initialize
max_requested_bpc and max_bpc from the property range when creating a
connector state so that deferred allocation and subsequent resets both
restore the default. Avoid leaving the bit depth at zero after reset,
which would otherwise cause valid display configurations to be rejected.

With MSM DP max bpc support applied, this also restores boot on the Lenovo
Yoga Slim 7x.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 5 +++++
 drivers/gpu/drm/drm_connector.c           | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index a2ef272e9f27..91d60bc7a2b2 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -34,6 +34,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
+#include <drm/drm_property.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
 
@@ -495,6 +496,10 @@ __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					 struct drm_connector *connector)
 {
 	conn_state->connector = connector;
+	if (connector->max_bpc_property) {
+		conn_state->max_requested_bpc = connector->max_bpc_property->values[1];
+		conn_state->max_bpc = conn_state->max_requested_bpc;
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

-- 
2.55.0

