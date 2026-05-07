Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5D1CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0801710E27C;
	Thu,  7 May 2026 10:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h/zcRLW7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4557610E27C;
 Thu,  7 May 2026 10:47:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 599D460252;
 Thu,  7 May 2026 10:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E63C2BCB2;
 Thu,  7 May 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778150871;
 bh=2khru/DOkaa/Vn4AxiniN4WAypSs00tFxSzj+sF3p68=;
 h=Date:From:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
 b=h/zcRLW7hTLI82O7Edb8zvEpGX24DPBS9WcqSQeYj2QUetIhtmDg5EoNpMz8+kcm9
 jtdozRgyN0HR5ivBWsFcfcAo9FU8Pf8a5Ibfp7+Qynb+fgb04A52YnbqmgbaPj+Mna
 OI3JqSm7RJHvWNzQsvDHFU2BQ9JC7uxojxBe49Sf4MuWSR5/xbJiLDpUM5YuQ/Lqoj
 3XNgZojW0xt/Gqjvbz/Vn4G2DAmEeAuLX5aia3wgARZHh56Pd9WN7Cs1yNhSDcMsx7
 3xsfEZBO0o+G1XADm2cJQhe4H4Tb0TFto+VbqWDdirWZAZrr+IhIC2xzswUPyrhReM
 Xj6ZMRrUSS6mQ==
Date: Thu, 07 May 2026 12:47:48 +0200
Message-ID: <3b729608ad4bc3bb161c3779a9768b12@kernel.org>
From: Thierry Reding <thierry.reding@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: DRI <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl-intel tree
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

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

  drivers/gpu/drm/bridge/microchip-lvds.c:132:44: error: 'struct drm_atomic_state' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    132 |                                     struct drm_atomic_state *state)
        |                                            ^~~~~~~~~~~~~~~~
  drivers/gpu/drm/bridge/microchip-lvds.c: In function 'mchp_lvds_atomic_enable':
  drivers/gpu/drm/bridge/microchip-lvds.c:153:62: error: passing argument 1 of 'drm_atomic_get_new_connector_for_encoder' from incompatible pointer type [-Wincompatible-pointer-types]
    153 |         connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
        |                                                              ^~~~~
        |                                                              |
        |                                                              struct drm_atomic_state *
  In file included from include/drm/drm_bridge.h:31,
                   from drivers/gpu/drm/bridge/microchip-lvds.c:25:
  include/drm/drm_atomic.h:758:74: note: expected 'const struct drm_atomic_commit *' but argument is of type 'struct drm_atomic_state *'
    758 | drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_commit *state,
        |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
  drivers/gpu/drm/bridge/microchip-lvds.c: At top level:
  drivers/gpu/drm/bridge/microchip-lvds.c:161:45: error: 'struct drm_atomic_state' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    161 |                                      struct drm_atomic_state *state)
        |                                             ^~~~~~~~~~~~~~~~
  drivers/gpu/drm/bridge/microchip-lvds.c:171:26: error: initialization of 'void (*)(struct drm_bridge *, struct drm_atomic_commit *)' from incompatible pointer type 'void (*)(struct drm_bridge *, struct drm_atomic_state *)' [-Wincompatible-pointer-types]
    171 |         .atomic_enable = mchp_lvds_atomic_enable,
        |                          ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/bridge/microchip-lvds.c:171:26: note: (near initialization for 'mchp_lvds_bridge_funcs.atomic_enable')
  drivers/gpu/drm/bridge/microchip-lvds.c:172:27: error: initialization of 'void (*)(struct drm_bridge *, struct drm_atomic_commit *)' from incompatible pointer type 'void (*)(struct drm_bridge *, struct drm_atomic_state *)' [-Wincompatible-pointer-types]
    172 |         .atomic_disable = mchp_lvds_atomic_disable,
        |                           ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/bridge/microchip-lvds.c:172:27: note: (near initialization for 'mchp_lvds_bridge_funcs.atomic_disable')

Caused by commit

  c4cbe5d9e87d ("drm/bridge: microchip-lvds: migrate to atomic bridge ops")

from the drm-misc tree interacting badly with commit

  5164f7e7ff8e ("drm: Rename struct drm_atomic_state to drm_atomic_commit")

from the drm tree.

I fixed it up (see below) and can carry the fix for now, but please get
this fixed in the drm-misc tree.

Thanks,
Thierry

diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index 12fc442f9867..5fb8633f43c5 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -129,7 +129,7 @@ static int mchp_lvds_attach(struct drm_bridge *bridge,
 }
 
 static void mchp_lvds_atomic_enable(struct drm_bridge *bridge,
-				    struct drm_atomic_state *state)
+				    struct drm_atomic_commit *state)
 {
 	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
 	struct drm_connector *connector;
@@ -158,7 +158,7 @@ static void mchp_lvds_atomic_enable(struct drm_bridge *bridge,
 }
 
 static void mchp_lvds_atomic_disable(struct drm_bridge *bridge,
-				     struct drm_atomic_state *state)
+				     struct drm_atomic_commit *state)
 {
 	struct mchp_lvds *lvds = bridge_to_lvds(bridge);
 
-- 
2.52.0
