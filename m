Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED77606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxAMMnaD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DBF10E7B2;
	Thu, 29 Oct 2026 07:36:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EA810FFD3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:36:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAB5C42DE0;
 Thu, 29 Oct 2026 07:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290201F01825;
 Thu, 29 Oct 2026 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259369;
 bh=CqEW+l+JGX99FGoMvZaZDEASwW5sAXd/JtdVOe9MMJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jxAMMnaDlbZU6TVw+XNpHMNBUUVXqzlkCrGayyBlY0+Ohb87xL+k5XqhgUBT8ZhFx
 w/5Fe7L9QIy0tVrbfa2So7VC+oK/WW5P6rOeZY0D7MjsqaKB2rOFVk8jleKqMhd5/G
 tQN2yA8lLe9i+D9peI3NDx/O3kdrxh7BOKEGMWoMw6EE4qD4MmDRB67ce2ENHuK9sr
 Rbwp6auQbzYlSLy5i7s/71S5zkjuCmPSo10+6BwJ3Gxknt8ypj0/fQh31jUJpkySaP
 xAOz56r6IGJXJ2z/eBW4KILk/G/xGaLBMqVc93X3bvpKJwg8ej6lk5fiiel5KPtGqr
 GpcDOCOtmm4WQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:19 +0100
Subject: [PATCH v7 29/34] drm/tidss: crtc: Add atomic_print_state
 implementation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-29-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OaT9z6vDW3jq70AjKFg3g9ZXb4d0z01fgQUVCdw5xBk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvv1kWLR36+bqMpaT62bPEHjj2fmk5M6iedURxxfXi
 4tm73T52TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQ2hItTACbytI6x4aX5W4PfMn3sEjd+
 P/LyjZjisotx9mbhJuOEdLZsy3viQr3tbv6Xjx9M/LjONbXFIVKLsd7teZ7XUbPFTin7H1yU3P0
 zeMPhvIraJdG90g82aNgx8JifsY38syTw+zmZldf+PbpXzgkA
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

The tidss CRTC subclasses drm_crtc_state with bus_format and bus_flags
fields that are set during atomic check and state readout. These fields
are not visible in the standard atomic state dumps, making it harder to
debug bus format negotiation issues.

Add an atomic_print_state hook to expose them in debugfs and kernel log
state dumps.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 400329aa2200..3da49f77fa08 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -402,4 +402,13 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
 }
 
+static void tidss_crtc_atomic_print_state(struct drm_printer *p,
+					  const struct drm_crtc_state *state)
+{
+	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
+
+	drm_printf_indent(p, 1, "bus_format=0x%08x\n", tstate->bus_format);
+	drm_printf_indent(p, 1, "bus_flags=0x%08x\n", tstate->bus_flags);
+}
+
 static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.destroy = tidss_crtc_destroy,
@@ -409,4 +418,5 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
+	.atomic_print_state = tidss_crtc_atomic_print_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,

-- 
2.55.0

