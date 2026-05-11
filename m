Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A21CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863B810E22F;
	Mon, 11 May 2026 23:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="onstIQac";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E6E10E22A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:40 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77507517;
 Tue, 12 May 2026 01:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543791;
 bh=LrnvNjxC5AlgiNohRlXZHVTzNqBGOFVxb4cytKEZ9HA=;
 h=From:To:Cc:Subject:Date:From;
 b=onstIQacQ6+esRRKSKovyW9vywbC1VMS349+nmfoASY8BDnjPTO9dMhoq33jH/K4a
 IhuCrfZeknu5d4zRwS7agA89dY/cMZu8OMKVdBwolW4itMj6+cMftP8Fq4xvoKIo3t
 W/4SF1J71JZAKjpDSuqtGGKC5xyZhMiCuslcbFKI=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 00/11] media: renesas: vsp1: Modernize the driver
Date: Tue, 12 May 2026 02:56:24 +0300
Message-ID: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.53.0
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

This patch series modernizes the VSP1 driver by using scoped guards and
moving loop index variable declarations to the loop statements.

Patches 01/11 and 02/11 prepare for the introduction of scoped guards by
splitting a large function to lower the indentation level. As the
function is called by DRM clients (R-Car DU and RZ DU drivers), an
inline compatibility wrapper is introduced. The clients are then updated
in patches 03/11 and 04/11, and the compatibility wrapper removed in
11/11.

Patches 05/11 to 08/11 then introduce guards and scoped guards for
mutexes and spin locks. There isn't much to say about this, the changes
are pretty boring, but generate a nice reduction of 148 lines. I advise
reviewers to apply the changes and use 'git show -b', as a large part of
the modified lines in 06/11 and 08/11 are just indentation changes due
to scoped guards.

Patch 09/11 continues with the introduction of a helper macro to
simplifying iteration over format arrays, which occurs 6 times in the
driver. Patch 10/11 ends the modernization effort with declaring index
variables in for loop statements to avoid using index variables outside
of the loop unintentionally.

Patch 03/11 and 04/11 touch the DRM subsystem and depend on 02/11. They
could be delayed by one kernel release (in which case 11/11 would need
to be delayed by two releases), but I would prefer merging them through
the media tree if possible if there's no objection from the DRM
maintainers. I don't expect conflicting changes in the R-Car DU driver
for v7.2. Dave, Sima, could you give your ack for this ?

Laurent Pinchart (11):
  media: renesas: vsp1: Avoid forward function declaration
  media: renesas: vsp1: Split vsp1_du_setup_lif()
  drm: renesas: rcar-du: Switch to new VSP API
  drm: renesas: rz-du: Switch to new VSP API
  media: renesas: vsp1: Use mutex guards
  media: renesas: vsp1: Use mutex scoped guards
  media: renesas: vsp1: Use spinlock guards
  media: renesas: vsp1: Use spinlock scoped guards
  media: renesas: vsp1: Simplify iteration over format arrays
  media: renesas: vsp1: Declare index variables in for loop statement
  media: renesas: vsp1: Drop deprecated vsp1_du_setup_lif() function

 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   4 +-
 .../media/platform/renesas/vsp1/vsp1_brx.c    |  40 +--
 .../media/platform/renesas/vsp1/vsp1_clu.c    |  18 +-
 drivers/media/platform/renesas/vsp1/vsp1_dl.c |  75 ++---
 .../media/platform/renesas/vsp1/vsp1_drm.c    | 269 +++++++++---------
 .../media/platform/renesas/vsp1/vsp1_drv.c    |  42 ++-
 .../media/platform/renesas/vsp1/vsp1_entity.c |  31 +-
 .../media/platform/renesas/vsp1/vsp1_hgo.c    |  17 +-
 .../media/platform/renesas/vsp1/vsp1_hgt.c    |  27 +-
 .../media/platform/renesas/vsp1/vsp1_histo.c  |  55 ++--
 .../media/platform/renesas/vsp1/vsp1_hsit.c   |  15 +-
 .../media/platform/renesas/vsp1/vsp1_lut.c    |  18 +-
 .../media/platform/renesas/vsp1/vsp1_pipe.c   |  65 ++---
 .../media/platform/renesas/vsp1/vsp1_rwpf.c   |  44 +--
 .../media/platform/renesas/vsp1/vsp1_sru.c    |  13 +-
 .../media/platform/renesas/vsp1/vsp1_uds.c    |  13 +-
 .../media/platform/renesas/vsp1/vsp1_uif.c    |  29 +-
 .../media/platform/renesas/vsp1/vsp1_video.c  | 191 +++++--------
 .../media/platform/renesas/vsp1/vsp1_wpf.c    |  38 +--
 include/media/vsp1.h                          |   5 +-
 21 files changed, 413 insertions(+), 600 deletions(-)


base-commit: bc1ba628e37c93cf2abeb2c79716f49087f8a024
prerequisite-patch-id: 5aca4e543fab1580689807ae68bea97cf436124b
prerequisite-patch-id: 1f31895481c2e7c8ba2adac3b2067236c8fec8b6
prerequisite-patch-id: c83c8d5e318389b8cab7761c5012ce9fad95337c
-- 
Regards,

Laurent Pinchart

