Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E150CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C7C10FEEE;
	Wed, 14 Oct 2026 17:29:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B094310FED0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34A9860238;
 Wed, 14 Oct 2026 17:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648451F000C4;
 Wed, 14 Oct 2026 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998962;
 bh=HOq8zJzXBAwtXaYbaYwO8aenyEox/C70KgdmJakBdco=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nFjFyh3JJ9vgoGFO56JUhen5T7dc/BhjcZXaZMJOsE/3eXrpeq3m2B4goyalYO4ry
 7Y+3e0taNE3VVCvcTSWsWAHSUxYiRqCn8xi9FLo05/AGAn1qKJP1JCQxXRLtQsVtrJ
 gb/VypytQAKreO74anioPgOCKdzSMD31O1kE+LT5NkalB0fyZsoRe+PD4yMxVKZvq5
 iN40nvitMX06BRaSgilsUWnDVv+IsYV9z3MHdNkBy57hwhSqI4qcHOPw+4OHvkthhl
 p0aRhzTtDpEeuj8aV2XrOjOZQa+uvQig413sJ3aVTrO+H8gH1LpraZgZW3A3cYPWHY
 MeDUsfKocYQLQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:59 +0200
Subject: [PATCH 36/75] drm/sti: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-36-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=mripard@kernel.org;
 h=from:subject:message-id; bh=worINel9GDd86Ttp3My4/ab03iSNTdanTVYiL1chgLo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0f9f/ZCYG7fZPOqylOMvEksp7juTXV/UV66P3Z58
 lxfp8+rOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEPqsy1qkLyrTUFaWtfad5
 bc6m8IxUn3fl7PKvtNxjtbfv0NDz8eXZyjlRx9NP/+2aquiNsdOmMjacW8SR8D9mQcVTt407J3d
 Ott5hrX7j46J53v4Pir/Ojy7TfOzzX/aY2RKF+2HTMvwXz7wIAA==
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

The sti connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 2 +-
 drivers/gpu/drm/sti/sti_hda.c  | 2 +-
 drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index cdb19b75f5e1..18c337ffa161 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -418,11 +418,11 @@ static int sti_dvo_late_register(struct drm_connector *connector)
 
 static const struct drm_connector_funcs sti_dvo_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = sti_dvo_connector_detect,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.late_register = sti_dvo_late_register,
 };
 
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b4def2b25cec..204738807c86 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -661,11 +661,11 @@ static int sti_hda_late_register(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs sti_hda_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.late_register = sti_hda_late_register,
 };
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 7ba9e0b7ba6c..9a810a89e6c0 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1144,11 +1144,11 @@ static int sti_hdmi_late_register(struct drm_connector *connector)
 
 static const struct drm_connector_funcs sti_hdmi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = sti_hdmi_connector_detect,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_set_property = sti_hdmi_connector_set_property,
 	.atomic_get_property = sti_hdmi_connector_get_property,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.late_register = sti_hdmi_late_register,

-- 
2.55.0

