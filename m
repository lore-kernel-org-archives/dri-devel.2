Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969E2CCA465
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C5410F4DE;
	Thu, 15 Oct 2026 15:10:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273A010E95A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0835842D8D;
 Thu, 15 Oct 2026 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616991F000C4;
 Thu, 15 Oct 2026 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077023;
 bh=7Y9tjkZc/Y8kY+w0hM5wchjGY4K3aLH1T6//1IcMaFs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ebNxbZiTytuXNZFV26Ym6uFJSwlWuJKiLWDcAWYxML9VnPaC2rfKp7cWBb0Z5CSsd
 xIChxmD3TMgyzkN5Z2P0HUtWSi6VE2Z6p0hOH9/T8K/T3gAGx4+2TFdd5n1vL/XK0m
 l9kNOhDUhTawXhkL5w/p6FSduJzRnJYfIgadcNTblQ1Ca0OVi8pX5Uj92TE499Ba/V
 TBSQWRo/Cr4Y2Xx4tw3Nhrd/bUtIceAMo/Zh19dfcZgsdJ+rtnbKfyqgfetbWBgn6b
 7/9rZ2EKutP3pK6FKKwpDwucsytdxzlpbSKc0WfBEwJoRclMgKGrSlwsV+KriOnNw8
 UZAZT2VXLTbBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:11 +0200
Subject: [PATCH v6 19/28] drm/atomic-helper: Document State Read-Out as a
 state initialization approach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-19-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vrPj+8DIv9pr01yt5M5J+p86n1OO9mzqvFvtD3bT/dE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kyK2lL087r2zJu7OIJyZ2tbujNOvH562pP85Ts3/
 L7RKHF6QcdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYiP8dxoaVgdcMP518ZPbp
 TPVDzdv313e0r/U4s//tsXtL80w6zR80ZfQqHEo/nLX87LmnFrl5ok8Za4VWHw1p2WrJvtkxKcK
 LZ8uOTWt9KifXsXyKmlJ/qzJYaw7To+g1byb2fdpis19Yd5/MOwA=
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

The "atomic state reset and initialization" DOC section describes the
problem of needing correct atomic state at driver load and after
suspend, but only mentions the reset approach and a vague reference to
i915's read-out as an alternative.

Now that the State Read-Out (SRO) infrastructure provides a generic
solution, update the documentation to describe both approaches and
cross-reference the SRO section. Also mention
drm_mode_config_create_initial_state() which combines both.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index efe173f3eeca..9bc029d633c1 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -45,17 +45,25 @@
  * DOC: atomic state reset and initialization
  *
  * Both the drm core and the atomic helpers assume that there is always the full
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
  * and resume a lot. For drivers using drm_mode_config_reset() a complete recipe
  * is implemented in drm_atomic_helper_suspend() and drm_atomic_helper_resume().
  * For other drivers the building blocks are split out, see the documentation

-- 
2.55.0

