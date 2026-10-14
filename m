Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013BFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5802010FF02;
	Wed, 14 Oct 2026 17:30:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374AD10FF11
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E6B844049;
 Wed, 14 Oct 2026 17:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768061F000C6;
 Wed, 14 Oct 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999047;
 bh=kT1Qnynp/rLksrQPMZKCyM/dx95K38aGEnnWM1gHZJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Xi1FbUm3gELBZxAnNoA35abYemvgTpDnVuFFyY9dFZg8hnAdJk06XK4hZBbzykq0U
 BX2iI/S8R8k3uFevfFI02TYRZqJbAONHjVoK0LKgQPJSljgCDQoSLU5MIA44hcWcUk
 9nVZRWSQss1RFnU+epUDgM3InYVJNAyAfwRlo3qmgvvBbg93kboysdCUqhMVMQtkI8
 AvNzzEgfISKVWHSptgeTITsD24AD98Q0Vw/4sCJmcTae2fBGOjdieGBIvli3C1xZmz
 JqA+7XQvV5H1FJCjNJ1jMBGrOAaxwL0qCcU5Ld7SEQDWzyxZl5+ht+QlINNofWS2B8
 l8QNjXmLRD9cg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:22 +0200
Subject: [PATCH 59/75] drm/gud: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-59-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cKXmcd0HHAxJgdPtG4liazv1W4s1FpdfDHyoqgKB3go=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6ckXg/fYa26dG7ylqtpV8XyUlQEdA5Ibiuv/iykL
 irwLL27YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEdjVjw7qdC9QLH13Zf7Y8
 6dDOywFWFycks35xexDe0dX35MJv5YW3FKJntt99z/7jSm7ye0WeesYaDmW2WwXT/m2+mS0W2rF
 +etzLDqf6/W9eT1opNNlZWl+0u3FS0/Z1K21tPgr/a2OrPiwEAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The gud connector reset implementation creates a pristine state,
then initializes driver-specific TV properties, margins, and
brightness from the initial state. It does not perform any hardware
reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/gud/gud_connector.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index a57f2565d33e..ddbf3b3ebbca 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -345,29 +345,36 @@ static void gud_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 	kfree(gconn->properties);
 	kfree(gconn);
 }
 
-static void gud_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+gud_connector_create_state(struct drm_connector *connector)
 {
+	struct drm_connector_state *connector_state;
 	struct gud_connector *gconn = to_gud_connector(connector);
 
-	drm_atomic_helper_connector_reset(connector);
-	connector->state->tv = gconn->initial_tv_state;
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	connector_state->tv = gconn->initial_tv_state;
 	/* Set margins from command line */
-	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+	drm_atomic_helper_connector_tv_margins_state_init(connector_state,
 							  connector);
 	if (gconn->initial_brightness >= 0)
-		connector->state->tv.brightness = gconn->initial_brightness;
+		connector_state->tv.brightness = gconn->initial_brightness;
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs gud_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.late_register = gud_connector_late_register,
 	.early_unregister = gud_connector_early_unregister,
 	.destroy = gud_connector_destroy,
-	.reset = gud_connector_reset,
+	.atomic_create_state = gud_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 /*

-- 
2.55.0

