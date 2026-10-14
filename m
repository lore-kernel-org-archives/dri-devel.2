Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6393C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1318610FF11;
	Wed, 14 Oct 2026 17:31:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DFD10FF17
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D96E60230;
 Wed, 14 Oct 2026 17:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B21F000C6;
 Wed, 14 Oct 2026 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999079;
 bh=lqlhvGYNTaAZNeyc3JYp6Qmo022t/NPaKqP94NCwIWU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QwU7CGsFAm1WALdTzymXcR1xjjY9j2bBVqmv4EYgEUXtagjix8WWTXiEeIb4PHpRT
 ecJevc9t2P8UDhMji01IFhtSXVDsxgouEGgH/DGXMFJ1PV4tVzQhTLneF4YuXUaR26
 R9Pkvoc6KlB/+NQL/VHhbveF49Ju661FzTdRB0A7k3PH+PDDD/8BahSVVGEWP2Mccq
 4AfI1/gecpVgmJB8TRmliJMgl4etagwXwF7QfR7BHgFkNqMrWIttub7mz/nOTMchML
 zSx5poFw6kI1NElk2W56SkZeP4z7Xpk8LrsznAz+njW41ZHi1VZ/ZipPQadhq9wRRL
 H2cj7uJCM43rQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:31 +0200
Subject: [PATCH 68/75] drm/ast: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-68-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1OI9boqL+nAqL6tJfef2fTqG8bbHFfDNXe96y1d79Zg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2fo7J1h8uvm/urOh/tW3WA69+ucVYO5s1v4EVvuH
 gtTp6BpHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAinw8xNjSnXjJxfXj7wIHL
 Ch9lvn67WGfAkHvlbdXmc68+/zz167HF+fwf65Zk3j+wXfuexd2A36qM9TFd5rsDJ9j7i9+f59Z
 y+u2LJ0f/LeOaFOHf7S98kiN5U97jFZcfSzRev7hAv80gplHEBgA=
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

The ast DisplayPort connector reset implementation creates a custom
state subclass, but only initializes a pristine state without resetting
any hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_dp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index f22c0c215a21..7708169d0254 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -467,21 +467,22 @@ static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector
 static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {
 	.get_modes = ast_astdp_connector_helper_get_modes,
 	.detect_ctx = ast_astdp_connector_helper_detect_ctx,
 };
 
-static void ast_astdp_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *ast_astdp_connector_create_state(struct drm_connector *connector)
 {
-	struct ast_astdp_connector_state *astdp_state = kzalloc_obj(*astdp_state);
+	struct ast_astdp_connector_state *astdp_state;
 
-	if (connector->state)
-		connector->funcs->atomic_destroy_state(connector, connector->state);
+	astdp_state = kzalloc_obj(*astdp_state);
+	if (!astdp_state)
+		return ERR_PTR(-ENOMEM);
 
-	if (astdp_state)
-		__drm_atomic_helper_connector_reset(connector, &astdp_state->base);
-	else
-		__drm_atomic_helper_connector_reset(connector, NULL);
+	__drm_atomic_helper_connector_state_init(&astdp_state->base,
+						 connector);
+
+	return &astdp_state->base;
 }
 
 static struct drm_connector_state *
 ast_astdp_connector_atomic_duplicate_state(struct drm_connector *connector)
 {
@@ -511,11 +512,11 @@ static void ast_astdp_connector_atomic_destroy_state(struct drm_connector *conne
 	__drm_atomic_helper_connector_destroy_state(&astdp_state->base);
 	kfree(astdp_state);
 }
 
 static const struct drm_connector_funcs ast_astdp_connector_funcs = {
-	.reset = ast_astdp_connector_reset,
+	.atomic_create_state = ast_astdp_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = ast_astdp_connector_atomic_duplicate_state,
 	.atomic_destroy_state = ast_astdp_connector_atomic_destroy_state,
 };

-- 
2.55.0

