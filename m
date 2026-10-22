Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB724606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlsHGjyC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14F11125D3;
	Thu, 22 Oct 2026 12:37:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FD31125CD;
 Thu, 22 Oct 2026 12:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6191B435BC;
 Thu, 22 Oct 2026 12:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF61D1F000C3;
 Thu, 22 Oct 2026 12:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672624;
 bh=w9/nkyyl9xEJeMvGlC/pBuofbxSTlPkaNh3qI1hwPcg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SlsHGjyCip08qwErUdTwfdhGnkf41cH0azmBIAKfVUatk2RzSC5VrriZurFR7iHM9
 ajdDjR95TxfXrQz5RuivLXkmFhXgfoAEsq2GJNztiQtO4t6Lfw9aqG5fH1kup54GBi
 aF84CMO57n5wK8ln10zV8WVDhTegqy1z6wpYk+8hwMQeSuVNk1npO8visRCxzgqSsU
 8gQw9wof+FOofVVTJxOS8KWgh06ZHmUMG6hbXZqRCilnFrG/Ei4kvXrjJQGB+ilHow
 OdtkynrsFPiIa3F/lBwMoHHaPzhM9JFo+zAWElN+DXDu0O9ysWWQ/12heOBqmnwzlf
 AEC/0bQ9lVE2Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:54 +0200
Subject: [PATCH v2 55/59] drm/i915: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-55-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/ZyUToIQg2zFET8pB8M5hB3bErgp2EFCrcpVblMGw4c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mJa+NY9O0flz40UPv4tH19bMw7M3vhOruX/5asihJ
 0fP/VPP65jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATqQhgbNgk1xG5/XNEsI/B
 8tfJRoX+z9rf3z98VM6h815tndH82pX5rGeiK+MvzWBTefAyU/qmNWN9gAJrxeznDEGzJbM+7xX
 bKXDRrFuHSylofVRyYX39EZMV3OzGLb9NvpVJ3l+rcWa+nAUA
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The i915 connector initialization uses
__drm_atomic_helper_connector_reset() to set up the initial state
during connector allocation. However, it only needs to initialize
the state, not reset it.

Switch to __drm_atomic_helper_connector_state_init() and assign
connector->state explicitly, matching what atomic_create_state
expects.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_connector.c | 6 ++++--
 drivers/gpu/drm/i915/display/intel_sdvo.c      | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
index 7ef9338d67ab..ed38959b466d 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -91,6 +91,8 @@ static int intel_connector_init(struct intel_connector *connector)
 		return -ENOMEM;
 
-	__drm_atomic_helper_connector_reset(&connector->base,
-					    &conn_state->base);
+	__drm_atomic_helper_connector_state_init(&conn_state->base,
+						 &connector->base);
+
+	connector->base.state = &conn_state->base;
 
 	intel_panel_init_alloc(connector);
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 3075ef04df56..7b97f531acbf 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2791,6 +2791,8 @@ static struct intel_sdvo_connector *intel_sdvo_connector_alloc(void)
 	}
 
-	__drm_atomic_helper_connector_reset(&sdvo_connector->base.base,
-					    &conn_state->base.base);
+	__drm_atomic_helper_connector_state_init(&conn_state->base.base,
+						 &sdvo_connector->base.base);
+
+	sdvo_connector->base.base.state = &conn_state->base.base;
 
 	intel_panel_init_alloc(&sdvo_connector->base);

-- 
2.55.0

