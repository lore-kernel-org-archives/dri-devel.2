Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431C606A331
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anwuiEtZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F2D10EDF8;
	Fri,  6 Nov 2026 13:16:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7901A10EDF8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6067743F25;
 Fri,  6 Nov 2026 13:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0151F008A2;
 Fri,  6 Nov 2026 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970976;
 bh=BJrhIl9lc1uo2VthiMOMNBF4VZCwsSymlJd05G3lPyI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=anwuiEtZLHcNKpzhdEnKghhgxTl6NRNK8TZ5oUXKTE2bLKvsnUZFDpYFSeSyGpZ2K
 4HOWVkEckpmL7EtRnNoOlVaA9/XgOpQg4HaYf5E59V4moz9YxTG03qmF9MpydHqYkK
 sNKATJB3+EPbEUlbHG1utBWdDrDfFyzUX9I4FuRA6rsILi4IQtw8emmNUTtSYReqoI
 FFpdp3ewhvuiKqtqS4O6mpS9pZk5ezl+xQngUDDVL/QwPklJBj+tpBurx+vC661wFl
 8l47uu6VgThWotVSb1zAh/Asnj10hw8BCD2r+z0zIcoEE57hJQHAFsp3p7EtUyOIi2
 psc5PhDHuJT3Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:39 +0100
Subject: [PATCH v8 26/39] drm/atomic-helper: Document State Read-Out as a
 state initialization approach
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-26-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WWzC9xSGufyQSCmd8v7k5n65ixi5WdpidAACEDn0mSM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+2oWu7y3uD2s5/3hVb8dC9Y90392aZ7B1MNLAqF5
 C35btyd2zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmwnuAsU5HN9Im8+mT/zeZ
 eh5I7D73ra0p6cPpww7VIQxRnxZuVHlufvHybXYFqX1LT///JXW5sI2x4ZZhc+nf2wdf9+dGR75
 8sy4yrzNprW4a36sfi4//q9IJ911odedV0LxvX09rzje6eEqoEAA=
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

The "atomic state reset and initialization" DOC section describes the
problem of needing correct atomic state at driver load and after
suspend, but only mentions the reset approach and a vague reference to
i915's read-out as an alternative.

Now that the State Read-Out (SRO) infrastructure provides a generic
solution, update the documentation to describe both approaches and
cross-reference the SRO section. Also mention
drm_mode_config_create_initial_state() which combines both.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 267f44330629..c5bf70e6ad53 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -48,11 +48,19 @@
  * and correct atomic software state for all connectors, CRTCs and planes
  * available. Which is a bit a problem on driver load and also after system
- * suspend. One way to solve this is to have a hardware state read-out
- * infrastructure which reconstructs the full software state (e.g. the i915
- * driver).
+ * suspend. There are two ways to solve this:
  *
- * The simpler solution is to just reset the software state to everything off,
- * which is easiest to do by calling drm_mode_config_reset(). To facilitate this
- * the atomic helpers provide default reset implementations for all hooks.
+ * The first is to use the :ref:`State Read-Out (SRO) <drm_atomic_sro>`
+ * infrastructure to reconstruct the full software state from hardware
+ * registers. This enables flicker-free boot when the firmware already
+ * configured the display.
+ *
+ * The simpler alternative is to just reset the software state to everything
+ * off, which is easiest to do by calling drm_mode_config_reset(). To
+ * facilitate this the atomic helpers provide default reset implementations for
+ * all hooks.
+ *
+ * drm_mode_config_create_initial_state() combines both approaches: it tries
+ * SRO first, and falls back to a hardware reset followed by
+ * drm_mode_config_create_state().
  *
  * On the upside the precise state tracking of atomic simplifies system suspend

-- 
2.55.0

