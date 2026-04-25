Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171E8FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 08:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4E710E0F2;
	Sat, 25 Apr 2026 08:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V5TqowGn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7900810E0F2
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 08:27:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8602160052;
 Sat, 25 Apr 2026 08:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A00C2BCB0;
 Sat, 25 Apr 2026 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777105648;
 bh=JGYbF/CAx2fm2Y2c+p/5FAbpm8wEl0YaPWaPki3UAQI=;
 h=Date:From:To:Subject:From;
 b=V5TqowGnA37KGTd6X1s5M/3iguCrArMV0LRVsj1ZCmCZxECDF8R85ciG05iRBvOvS
 84dm7AUuxGMWztjh+QDQ5ySaiZj+iHgXb31F8pR5dGvid1G8NYfrxnQSWv2Xozu0se
 aIurOIF5d8WfFe2dAVp3q2GzAdJ0H2Z/RrLz99bIeZBvFc9lKTVWTBqHnRMNlKFo9+
 wApSaK4IziZrXgwHRKR91NoV4s6dDymvp472Z5pl+ztFQNculj3TS8n6JObXkUWyKT
 B4FmfmxbwMGuVL3GPa67nlyxwii3jVE6UHDL+bVBN8rWLOFhB1YghG2c2HiKpl5oEi
 wCGX/5Vm0WP9g==
Date: Sat, 25 Apr 2026 10:27:23 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] more fbdev fixes for v7.1-rc1
Message-ID: <aex66_AU379EYm_a@carbonx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Linus,

please pull a few remaining fbdev fixes for this merge window.

Thanks!
Helge

----------------------------------------------------------------


The following changes since commit 6596a02b207886e9e00bb0161c7fd59fea53c081:

  Merge tag 'drm-next-2026-04-22' of https://gitlab.freedesktop.org/drm/kernel (2026-04-21 17:39:21 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1-2

for you to fetch changes up to 448aaf54d3ae1b73dfcf723c9f8a02c2116f3358:

  fbdev: hgafb: Request memory region before ioremap (2026-04-22 17:02:55 +0200)

----------------------------------------------------------------
fbdev fixes & cleanups for 7.1-rc1:

- request memory region before use (cobalt_lcdfb, clps711x-fb, hgafb)
- reference cleanups in failure path (offb, savage)
- a spelling fix (atyfb)

----------------------------------------------------------------
Amit Barzilai (2):
      fbdev: cobalt_lcdfb: Request memory region
      fbdev: clps711x-fb: Request memory region for MMIO

Ethan Carter Edwards (1):
      fbdev: atyfb: Fix spelling mistake "enfore" -> "enforce"

Hardik Phalet (1):
      fbdev: hgafb: Request memory region before ioremap

Yuho Choi (2):
      fbdev: offb: fix PCI device reference leak on probe failure
      fbdev: savage: fix probe-path EDID cleanup leaks

 drivers/video/fbdev/aty/radeon_monitor.c     |  2 +-
 drivers/video/fbdev/clps711x-fb.c            |  9 +++------
 drivers/video/fbdev/cobalt_lcdfb.c           | 12 +++---------
 drivers/video/fbdev/hgafb.c                  |  9 +++++++--
 drivers/video/fbdev/offb.c                   |  7 ++++++-
 drivers/video/fbdev/savage/savagefb_driver.c |  2 ++
 6 files changed, 22 insertions(+), 19 deletions(-)
