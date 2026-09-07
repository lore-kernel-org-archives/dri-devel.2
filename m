Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34739C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BBA10E818;
	Mon,  7 Sep 2026 13:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iyXsIFFr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D6610E818
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60C8C40F3E;
 Mon,  7 Sep 2026 13:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7F41F00A3A;
 Mon,  7 Sep 2026 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787528;
 bh=4lQ3sIzZ4c1B17v0JmC0e3X+ZoqR2HPa/JOrQsrT2e8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iyXsIFFr9fhwMDWhE3inhGEJ5PxH/WzdsEi8c4avdydOmdv/VmBwexgbiD06ne6OQ
 V2nB7w6YgE8y6XAt6Vdlwp9rgRdrI3AL2jYaYRYxn9pVEojxoWzCDc+qTrRRWCvFwX
 wgCI+wmIlGSSR1sq9PKUpQ3t2GFu8V2pObHQ7NUSQtVHFaqs8oL7V/gjAy68HhaWlU
 zLQusIohHju3lHCsTuLx6Rp/h+q7frJhp94l/5zkHdy1xXXWz1CPO6sgqgYcX510YN
 r+UIie8rwkmnjki8ZsO0NTcNgOpK2zAoDxNLOjz/qdt/tevxweG7cLTSIJ0ru9CaBr
 g8e21oEfZKA1w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:59 +0200
Subject: [PATCH v5 23/33] drm/atomic-helper: Document State Read-Out as a
 state initialization approach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-23-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
 h=from:subject:message-id; bh=M/n9JCAlF+zDNC64C0qWNO8Ai/eis8HaJv3BxexjoSs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdr1YWy+mIZpfY5QTYruUKVF5x6z9G08vMHv1XtLZT
 tP8DrNLx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAbiIOGN9fZ/ljzeCHjHGUbEK
 q0OnyJ+cp9H1bc+kyX8C5sRsFn+psITJ5e4O3ROfFpbdelHzq8iEsaHniEP0J4aft8oUzl5gm5O
 1m/ts3IH6P7J6HpHB9udnBIX1MxRVK9fJLGh/9vPZp8feagA=
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
index 354fa9c6aca8..bd61c56ceca6 100644
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

