Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B9606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k17zC1O8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A071125C5;
	Thu, 22 Oct 2026 12:36:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4711125C5
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33A6043CC3;
 Thu, 22 Oct 2026 12:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959971F000C2;
 Thu, 22 Oct 2026 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672592;
 bh=x28bi62YAu4gnBC+XDhnCnRYzXsD3dkw+1Nv1frPObA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k17zC1O8IlHSP+8O21mdrE1poKD7FQKgt33rkTnRhW4ZFpVK0CIpIsPqhbVyZyykB
 4phqWIoCadU9ArranxW5GHuA2hQBz2WwqdNVzJ3Gx62690cw0jpnIO0TWaGSn+NtsA
 G7E/yr4xOc9oZMSXmbDK6M/dLxrdzcPwZj6QsdgkGEJeBZU00z4st21UEYKR1P/BXy
 oFaYDEd2GbAWexZd/GZMP2HLSIlDHDUGEz/MGoq/y3g9Pyg2iuO1K0TYio/pxjyzBI
 oOcYbxjC1sIWo/ODiSA7uvxVox1luCFlW28WDYEXo97PyDwAPW0UfPjV94Qy6Ni2/2
 KK15W0fjk0iPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:45 +0200
Subject: [PATCH v2 46/59] drm/gud: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-46-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/EO3O1M9H6aOupl+dVyLeVztUxWDdT2JFt9kNuCVd7s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBbem66yqtv1+nK3/VJT9LpzlGx+cTDphAXOehDZ+
 SxQefmjjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRex8ZG5pa2x7V7zsbnPM5
 +LEq35TtP6U4vi70Oc3DeP3W8U/NR+36F56fYnV+grBNZ9jtwn/zLRnr9AP+35iS7JGdb/NUlre
 QrfvMJKbSrn6hRRdtf/1eeSXDO6/y6r0dK/Y873l3K2xxOd9GAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The gud connector reset implementation creates a pristine state,
then initializes driver-specific TV properties, margins, and
brightness from the initial state. It does not perform any hardware
reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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
@@ -348,15 +348,22 @@ static void gud_connector_destroy(struct drm_connector *connector)
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
 
@@ -366,5 +373,5 @@ static const struct drm_connector_funcs gud_connector_funcs = {
 	.early_unregister = gud_connector_early_unregister,
 	.destroy = gud_connector_destroy,
-	.reset = gud_connector_reset,
+	.atomic_create_state = gud_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

