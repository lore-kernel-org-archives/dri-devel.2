Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103F606A338
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfvKi2+C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B67811291C;
	Fri, 27 Nov 2026 09:53:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B58112918
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46F4362610;
 Fri, 27 Nov 2026 09:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E08B1F008A0;
 Fri, 27 Nov 2026 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773216;
 bh=28knq8AU4ne1GaB5Jv9e9EwMkib0UXbXv/E+xYKN/lc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lfvKi2+CiWzBu7QebBPpw3TtJlD40yXUKxuQohY8f90KNxsjn6S1tLH172AIZ0Amq
 h1f7u4zXj8Gixb9UgL1Wjlib02YlZzg71YCJ95HjT2X/r3XwcITAz+fC402aLQcmXe
 n50DBhCAslTo8MIc4FGnDRxScYErYn3f+BMCphI6o7lyWPbvTPfCGdKov+GH219o6g
 W4Mu3CXRKUDg4ICFMMr3DliFnGpVOVbXGpjBwL7OSwWigwxn93FWmDW7PGqmiuCEfY
 SHMjMxyb8Vc17hUWVDuVs4blD41vROPSIkSXpmzyaldftTsKzEJESi24EbvUJ6PJZa
 uXMbdaKWZV0QA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:47 +0100
Subject: [PATCH v10 05/36] drm/bridge: Switch print_state to use bridge
 name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-5-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=mripard@kernel.org;
 h=from:subject:message-id; bh=v1MI1el1I1ZkthZs2b1UGL4na6g/WUYwdqIT3feNnbM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcQf84hHYUxAdM6e45w/aoQI5bovZKFGdkbv/dL6wGl
 aJHDjR2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIm0PWNsODv728dVr2/5Ptzr
 ECJlK/Ivpd6hseDB1733l6nK/fl/v/7mnf9HVh6SzLkQ46670DO1i7HhNdcrL/Zt51Zo3trD2Xr
 gE+P+CqeTb1+a7FrdnHzDRvq889kJMw5//PD3Q55Fa/meiTMOAwA=
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 21219958c0dd..b6cdbc172f68 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -570,13 +570,13 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 {
 	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
 	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
 
 	if (bridge->of_node)
-		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
+		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
 	else
-		drm_printf(p, "bridge: %ps\n", bridge->funcs);
+		drm_printf(p, "bridge: %s\n", bridge->name);
 
 	drm_printf_indent(p, 1, "input bus configuration:");
 	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
 	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
 	drm_printf_indent(p, 1, "output bus configuration:");

-- 
2.56.1

