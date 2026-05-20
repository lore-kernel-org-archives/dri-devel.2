Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E9CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 23:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EED410E427;
	Wed, 20 May 2026 23:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rmGscx3Z";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329DA10E427
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:46:34 +0000 (UTC)
Received: from killaraus.ideasonboard.com (unknown
 [IPv6:2a01:cb1d:8f2:800:42d6:38fa:3bdf:70df])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90978268;
 Thu, 21 May 2026 01:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1779320778;
 bh=shLhz+CxDmQFQ1bXF4B85iejZDaGX5NNX25MX8X5CAY=;
 h=Date:From:To:Cc:Subject:From;
 b=rmGscx3Zm2xaziNkt4eJKNJbjIYOd28HD4lHiI6Azz2e/k3xqpxKeSe+9acdu8Gyz
 VrD9/VX26SM8RsMPGTc5/WQLPYx2j2Y03tWerfp6EuYLk4blmW5mVG6DalQXpwB37O
 BH4mOAkPBDR8dXH41cMR7/d8DfurImllqt9TFMzI=
Date: Thu, 21 May 2026 01:46:31 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans Verkuil <hans@jjverkuil.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [GIT PULL FOR v7.2] Renesas VSP1 driver improvements
Message-ID: <20260520234631.GA109738@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hi Hans, Mauro,

The following changes since commit c2d1a2130c93f6d758af58590b86b2254c7a1dec:

  media: vivid: check for vb2_is_busy() when toggling caps (2026-05-20 16:00:40 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/pinchartl.git tags/next-media-renesas-20260521

for you to fetch changes up to c5d9fef1900c25cb542fcd66348a22bad30756ca:

  media: renesas: vsp1: Drop deprecated vsp1_du_setup_lif() function (2026-05-21 01:43:56 +0200)

Note that the series includes two patches for DRM drivers that consume
an API of the VSP1 driver changes in the series. The alternative would
be to split the series over three kernel releases, which would just
delay changes and make everybody's life more complex. Biju gave his ack
as the maintainer of the rz-du driver, and Dave as the DRM maintainer.

CI pipeline: https://gitlab.freedesktop.org/linux-media/users/pinchartl/-/pipelines/1671383
----------------------------------------------------------------
Renesas VSP1 driver improvements

- vsp1: Improve interface to DU drivers
- vsp1: Switch to scoped guards for locks

----------------------------------------------------------------
Laurent Pinchart (10):
      media: renesas: vsp1: Avoid forward function declaration
      media: renesas: vsp1: Split vsp1_du_setup_lif()
      drm: renesas: rcar-du: Switch to new VSP API
      drm: renesas: rz-du: Switch to new VSP API
      media: renesas: vsp1: Use mutex guards
      media: renesas: vsp1: Use mutex scoped guards
      media: renesas: vsp1: Use spinlock guards
      media: renesas: vsp1: Use spinlock scoped guards
      media: renesas: vsp1: Simplify iteration over format arrays
      media: renesas: vsp1: Drop deprecated vsp1_du_setup_lif() function

 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c     |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c      |   4 +-
 drivers/media/platform/renesas/vsp1/vsp1_brx.c    |  33 +--
 drivers/media/platform/renesas/vsp1/vsp1_clu.c    |  15 +-
 drivers/media/platform/renesas/vsp1/vsp1_dl.c     |  63 ++----
 drivers/media/platform/renesas/vsp1/vsp1_drm.c    | 263 +++++++++++-----------
 drivers/media/platform/renesas/vsp1/vsp1_entity.c |  27 +--
 drivers/media/platform/renesas/vsp1/vsp1_hgo.c    |  10 +-
 drivers/media/platform/renesas/vsp1/vsp1_hgt.c    |  16 +-
 drivers/media/platform/renesas/vsp1/vsp1_histo.c  |  55 ++---
 drivers/media/platform/renesas/vsp1/vsp1_hsit.c   |  15 +-
 drivers/media/platform/renesas/vsp1/vsp1_lut.c    |  15 +-
 drivers/media/platform/renesas/vsp1/vsp1_pipe.c   |  60 ++---
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.c   |  44 ++--
 drivers/media/platform/renesas/vsp1/vsp1_sru.c    |  13 +-
 drivers/media/platform/renesas/vsp1/vsp1_uds.c    |  13 +-
 drivers/media/platform/renesas/vsp1/vsp1_uif.c    |  29 +--
 drivers/media/platform/renesas/vsp1/vsp1_video.c  | 157 ++++++-------
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c    |  30 +--
 include/media/vsp1.h                              |   5 +-
 20 files changed, 362 insertions(+), 509 deletions(-)

-- 
Regards,

Laurent Pinchart
