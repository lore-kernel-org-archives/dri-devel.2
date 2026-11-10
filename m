Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3160A3810
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAMi9Vle
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DAE10EE5F;
	Tue, 10 Nov 2026 07:19:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91CB10E92D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:19:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BE34637D7;
 Tue, 10 Nov 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295169;
 b=MYxaczkZ6IyW/ybPnWJqsNtr5NtvNgdboBpR09WSQOkQyQ5TK6K2I1gsL4Ibikd34dFs
 ySgKRuEpCV2vSROUDEiGNNm7uAKUPUiyVR29lARQS4dHULmCDu0bZWcZu1piaMU+9Vw2U
 A3n9u7pQ1K70qvJbXIjNq7LzW5Oz0iuNbfSpdW9o+P7w0eDpQ9xvpKiyXH97wY4GkXSeq
 YBPl4zACd17pI54onJdQZZuKi7qgsTFWodYMIVniENMVSPsS4GH9dAb0ObYU7WzAAU5FG
 P8FDS3aAItK2oozP6Opo49A+ZHlxaLhmyPVw69z3oDr9UiCuGQHGY+9ag0Tmb/bfCUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295169;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=zaVmZOMrBjPzc+fEuDwXTYn0rY5LTU6XQyWkDq4ewRM=;
 b=QowQvlijKwhPFrQhqDR6n3GIYip539wSQTh/n9+Px8bvaLfRCEH4Fs08PWf+KJqosAVA
 FrIe7umCoapH2jJP1r9lZLMZxB2fOiN2GPPWd+p2XdijhBurkyvFOuYgZn9DOvu+oE6yt
 jgltGe9RutX5zB6NndVar6jfKcs7vbqmRUCZcbM/sqUC0ym+N91EMd5TWaCXMdaVEm5fp
 /9knTOJ6niVr0kxB834Xdns3gR8q59sTV+ZIc+l8v6CM7VfGMkr6DOAccpcqEhaXgeoTQ
 neY0zd30JxmQabmr11I4fMO+uF8fbFX+6RbzGDhaFG6OVlB9eWW1PgQ3vwWyc8FlTqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6F03D1F0089F;
 Tue, 10 Nov 2026 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295169;
 bh=zaVmZOMrBjPzc+fEuDwXTYn0rY5LTU6XQyWkDq4ewRM=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=LAMi9VleqId3cEvSSQwUFlqlfUCXL6YOTcs6UrjDV6xJTpGRljTwWlfMh3S1NvN3K
 sVm3p/dlPBBYesIPtUJYA/6Gton/nRjIajCi7tV7xi9sl/ohCGEbX7ZCHGtOUOugtb
 ddh8E/Bt+Ax/584XkAzzCDnbqqqwXlensBmB+6RpEYJAsz3uMDEYwIx+kJ1J/mPWZ0
 ZoUuZ3Xf6N/bPZ1K2nkeDHcH55LedMa138WtECs80iHui2WR2odxOeVA/wQuWs0V17
 ejZcsFfbWzlMULNtf1s5OZ/T6Uvapqiwfz1pTdvKvwreZjmzsxC8GfCKufuyHBv3Is
 CstNF7jJ9Cw6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 03995488E6;
 Tue, 10 Nov 2026 07:19:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:19:28 +0000
Subject: [PATCH] drm/bridge: Fail an unsatisfiable bus format negotiation
 with -EINVAL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-drm-bridge-busfmt-einval-v1-1-c0494bd23264@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0Q6CMAyF4VchvbbJOgwRX8V4wbaCJTJNC4SE8
 O5Ovfxycv4djFXY4FrtoLyKySsX0KmC+OjywCipGLzzDRE5TDphUEllCYv104wsee2e6GO8hDq
 RO7c1lPtbuZftl77d/7YljBznbw+O4wPXWCeLfAAAAA==
X-Change-ID: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295167; l=2931;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=6XMYzP0YUE+EgwGGwMYmFB73J3HaaBRqLqa6SWZe9Zw=;
 b=tKDI+fU38XeKY5fsQssGVW69baV1Qxo0SkqKz0o5wZreiIkudAVUWXiy68hPx040+wtvEH5ts
 yST01F+7SnsDWSenN9uq8r6RjEi7I/kKdLSn+PTM92BoBvmJ5bw3Wkg
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

drm_atomic_bridge_chain_select_bus_fmts() reports that no chain of bus
formats fits with -ENOTSUPP, and drm_atomic_bridge_chain_check() passes
that straight back through drm_atomic_helper_check_modeset() to the
atomic and legacy modeset ioctls. -ENOTSUPP (524) is a kernel-internal
code that userspace does not know; for a configuration the hardware
cannot do the atomic API returns -EINVAL. Since the connector "color
format" property makes the negotiation fail for any requested format a
bridge chain cannot output, userspace now hits this routinely: a DW DP
connector asked for YCbCr 4:2:0 on a sink without 4:2:0 support gets
here with no matching format and would fail the atomic commit with
errno 524, where an HDMI connector asked for the same returns EINVAL
from the HDMI state helper.

Return -EINVAL when the negotiation finds no chain, with a debug
message naming the encoder.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Found while making the DW DP bridge honour the "color format" connector
property on an Orange Pi 5 (RK3588S): once dw-dp only offers the bus
formats of the requested colour format, a request the sink or the mode
cannot take leaves the chain with no format, and the atomic check
returns the kernel-internal -ENOTSUPP.

Tested on that board with this patch and that dw-dp change, with a
DisplayPort monitor whose EDID has no YCbCr 4:2:0 support: all 74
commits asking for YCbCr 4:2:0 over the monitor's modes and depths are
refused with EINVAL, as the same request on the HDMI connector is; the
296 RGB, YCbCr 4:4:4/4:2:2 and automatic cases still get their format,
with the picture checked by a camera.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed and tested it
as described above.
---
 drivers/gpu/drm/drm_bridge.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8ae2f9b1db44..6a97b579c604 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1437,6 +1437,17 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 
 	ret = drm_atomic_bridge_chain_select_bus_fmts(bridge, crtc_state,
 						      conn_state);
+	/*
+	 * -ENOTSUPP is the internal "no bus format chain" code of the
+	 * negotiation. It is not a valid userspace error code; an atomic
+	 * check that cannot be satisfied fails with -EINVAL.
+	 */
+	if (ret == -ENOTSUPP) {
+		drm_dbg_atomic(bridge->dev,
+			       "[ENCODER:%d:%s] no bus format chain found\n",
+			       bridge->encoder->base.id, bridge->encoder->name);
+		return -EINVAL;
+	}
 	if (ret)
 		return ret;
 

---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


