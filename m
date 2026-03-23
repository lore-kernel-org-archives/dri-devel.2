Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0559F483C8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2911810E15E;
	Mon, 23 Mar 2026 16:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PqiWYT13";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0B810E15E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:45:29 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 76D34189C;
 Mon, 23 Mar 2026 17:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774284251;
 bh=8BGEngxkySkyTKbeo/i0cTwWlKEY2Zfak/ZeMwY7f+s=;
 h=From:To:Cc:Subject:Date:From;
 b=PqiWYT13ST/GepdD8rGmo6BD2AAP1JLQe4wSeSNhjx10YlGJuz6c/AGVb/hPDs7sa
 ItYJVrKK/XDaWPoVUFrzIpC5oK+8KMUSGiItm8m+ViIa2F8j329LPD2r6fJpHBSo40
 GSUchT6n2K8Z8JkdkEUf7lOvjqjbZQW+kC1Tv3h4=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 0/4] drm: rcar-du: Improve device_link handling
Date: Mon, 23 Mar 2026 18:45:22 +0200
Message-ID: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
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

Hello,

This small patch series came out of the review of [1].

I noticed that the DU driver enforces suspend/resume ordering with the
CMMs but not with the VSPs, which patch 1/4 fixes. This in turn made me
notice that the driver leaks the device_link instances to the CMM.
Patches 2/4 and 3/4 refactor CMM handling a bit, to prepare for 4/4 that
fixes the leak.

Changes compared to v1 are minor, see individual patches for details.

[1] https://lore.kernel.org/r/02669d4630e04fe24c17dd2576ec8b27ded458f0.1765541401.git.tommaso.merciai.xr@bp.renesas.com

Laurent Pinchart (4):
  drm: rcar-du: Ensure correct suspend/resume ordering with VSP
  drm: rcar-du: Store CMM device pointer instead of platform_device
  drm: rcar-du: Use __free() to simplify device_node handling
  drm: rcar-du: Don't leak device_link to CMM

 drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c    | 26 +++++-----
 drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h    | 18 +++----
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.c    | 16 +++---
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h |  8 ++-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c | 52 +++++++++----------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 16 ++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h |  2 +
 8 files changed, 81 insertions(+), 60 deletions(-)


base-commit: 25854131c04a5aa25a41cf527aab269aadb86699
-- 
Regards,

Laurent Pinchart

