Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6605FC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24A610E3C7;
	Wed, 29 Jul 2026 21:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SHddM5dV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E6510E3C7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785361537;
 bh=/vDl702wNNSSL8gI1OIPSoyQPkfvUGHwL617pFKAMbw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SHddM5dVWEpmYb7OQi36S+wQrSsmSc08KKfxCcvtH6O2dgnklAswfCW3rjaHbbd+P
 K9Vtz1p+EXwbcNnnf46Psq0endTi/I0iIQ5aDcz4G3aG8RBWDBsjqEQTCXhhoRJUXk
 dJmB1YAjlktF44XxpOimEw1k4NN9tbgKW+rDqIZ9cWaMiYZ/E6wJiyXrHZP82vVjzI
 OVEfzQXej/1K2JJQK8NxNwsPjW++LpvflVXdObVBpWmqAiX2hV+VOnnxiJXamnBU3d
 K8QpB+1+5MqR2AeN8VW4a4/GO4bZT2Mg7Lt+vdMWBnf6cstaGbAjB/jIzaIe+pc9p5
 t4ZbhUD+Q3FUQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B5E2817E063E;
 Wed, 29 Jul 2026 23:45:31 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch,
 penguin-kernel@I-love.SAKURA.ne.jp, tytso@mit.edu, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
Date: Wed, 29 Jul 2026 18:45:05 -0300
Message-ID: <20260729214505.185776-2-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
with alpha exposed") introduced a WARN() to let driver developers know
that a previously valid behavior should now be changed.

But WARN() should not be used for that, as it's a kernel warning report
mechanism for conditions that are not expected to happen. It also
produces a stack trace. Instead, a simple warning-level log message
should have been used, as drivers were expected to trigger the
condition.

This is causing problems for fuzzers, as they may stop when encountering
a "BUG:" or "WARNING:" in the logs.

Replace WARN() with drm_warn() in this function, avoiding these issues.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/drm_mode_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 3bcc7bf0900c..3d9c554e08a8 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -869,8 +869,9 @@ static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
 	for (i = 0; i < plane->format_count; i++) {
 		fmt = drm_format_info(plane->format_types[i]);
 		if (fmt->has_alpha) {
-			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
-			     plane->base.id, plane->name);
+			drm_warn(plane->dev,
+				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
+				 plane->base.id, plane->name);
 			break;
 		}
 	}
-- 
2.55.0

