Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXR2i/0N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D755E10FFDB;
	Thu, 29 Oct 2026 07:34:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9ABA10FFCD
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2C29410C0;
 Thu, 29 Oct 2026 07:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367E31F031E3;
 Thu, 29 Oct 2026 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259285;
 bh=4paofLznwWA6gJv3Fq8qyIAHKhMEOihgkjBba4fMtEA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HXR2i/0NrBd7jz9HdEPk2jGp1MCcn/9QQUBqVb3tSvLvHHsDvkDg2unwPYFlS4rHL
 Zehe+UrCTO3Kk4/wcRMQATVM3ObB6vzIlR44JVtNRIVDkbDU9GDVGUPRnZBgMVuDgj
 x6n4+klm56sYB3HVfjRlm5qUCdUic95XpEXcLq0NkjAiYQRzljnQbWWfzYdd4PCRM/
 9uYNHAF1z3vYxS+4uVb4dHV/fYVlrPEIPiA1+RPaw8xCMZR8meMURywwn1p/OCO6H7
 LZT5bNPKzWKoPPiwbpixOgl0RZCG0DG1+20XLLOu0v36HyqwfdlnRH0Mxqo5rsqKvc
 3t9jJ0UhOxLkg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:56 +0100
Subject: [PATCH v7 06/34] drm/bridge: Switch print_state to use bridge name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-6-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=mripard@kernel.org;
 h=from:subject:message-id; bh=p2ADHvBGncnit5A+YIQo1KZfkmQWtLRR8OLAjrv+/Tg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr1vFPm+6ZeEZucCxrtte2vvuqjOyfug4nz84YWtb
 LW9ZvPqOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEilQZ67ODeS5UTgts+xFc
 8kjy5OcHt8IPTsiInxb/4ENqyuOdQQJCZz+t1os/XFY6Z/tsB6s4fcaG87e+Wc9593R3VrDIfG5
 3p7Bb1wQtppvWizEtvnJJJ//L8d6bq7VEjLfq/esVkWb3excDAA==
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

drm_bridge_atomic_print_priv_state() currently identifies bridges by
printing the symbol name of bridge->funcs using the %ps format
specifier. This produces output like a raw function pointer name, which
is not particularly user-friendly for debugging.

Since bridges now carry a human-readable name, switch to printing
bridge->name instead. This makes the state readout output more
consistent and easier to interpret.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index ac65ac941691..e237366199a7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -570,7 +570,7 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 
 	if (bridge->of_node)
-		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
+		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
 	else
-		drm_printf(p, "bridge: %ps\n", bridge->funcs);
+		drm_printf(p, "bridge: %s\n", bridge->name);
 
 	drm_printf_indent(p, 1, "input bus configuration:");

-- 
2.55.0

