Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3ECCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4453810EA9E;
	Wed, 14 Oct 2026 17:27:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA4910EA9E
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEF166022E;
 Wed, 14 Oct 2026 17:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118A71F000C4;
 Wed, 14 Oct 2026 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998839;
 bh=2Z698KWKjF+aBA2c/k/mZRfE7QFRVZVTynkZjBce4OU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KZVQ8m2LkOmgIbmMO/sIYNOl8MZFzr8/Wuy2Wg9R3PWRYhAAgimqXeA7YUkAihkzX
 io7m4PsT9qDTpsYjtg6yWePYfqXegQblY7wu8TMJDn1LYs6B2d2J8eaQNArhSBKfT9
 1/YfneJ791NCR5VCD46Gfczy2SSTn4JmwU+/fJF5Ahjs+kJM8A9kApKd5XQlwvUGF8
 RkpvDp7FR24o3aQUGbh++F8msUv6f7N9BWtf6o2tFx115MrgWASWkYIccb67MjM+iA
 q2YLkMqAQNHhY2a4FdnQJutWA5zJAi5vIWpIyAy8DPJrp5FHPyXHrr+mdx7AO2imUS
 IiOjJ5Qafmk3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:25 +0200
Subject: [PATCH 02/75] drm/adp: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-2-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Aun-Ali Zaidi <admin@kodeit.net>, Aditya Garg <aditya.garg@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EvFhTPX+raaRlGO6OXc9El8YWZjAJprv3qx/E7RAmJ8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd3u/5Wr10KzfO+OO+amDZz/9PPLE623Xlq2qT630Z
 yY7uDC/7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATUXdmbHhw+37Yqn0hbQtv
 fji68phLnduOkB3m7qd4P3wsPrf9pABH1VkhJYmw7dO3CS14O+3Z8yzGhr87yqvKLf4JPX90Qna
 51o3Ze28cUiorO2CXb5ARrPRz44mrxRXv0jxLeEUzvadoPJ/JDwA=
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

The adp connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Aditya Garg <gargaditya08@proton.me>
Cc: Aun-Ali Zaidi <admin@kodeit.net>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index 4297d9c1125e..4e17d7eb686f 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -587,11 +587,11 @@ static const struct drm_mode_config_funcs appletbdrm_mode_config_funcs = {
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static const struct drm_connector_funcs appletbdrm_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.destroy = drm_connector_cleanup,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 };

-- 
2.55.0

