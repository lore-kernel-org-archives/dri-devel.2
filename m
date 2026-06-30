Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B702C44500
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6EF10E494;
	Tue, 30 Jun 2026 13:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="Sl6SPCpn";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FF810E031;
 Tue, 30 Jun 2026 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782827694;
 bh=18TRgTSKp/wqNvfT3TCnFY7GXvBz6W1X7owntVv+Dow=;
 h=From:To:Cc:Subject:Date:From;
 b=Sl6SPCpnl4QARwra5gPKqkKwxdunBds7DEC1XoiyswmC0DxbuYN0fHvlkxbwRpxN0
 HXJr/shkz8KiTYgPZJKa0Z2mY78cugTe2dRKbW9w8veJlJtk4g/O6sveuA2ZO8NvxX
 VLXDpXbbEeO7Pq18/tyMpgdHxe1ED5W5XJizS2aIAxcukEs74DWUCius3dbsNmuSDY
 TQf9UHaZaYEKcpPg11bsCjZPNZY4U1HYZ2v3tvy7IfWRWzmdZXxL2K35QutmZU+ozs
 FYCufsoTPnurQyrgwhCKL16mC9qfwp6E4rP32kqmN8jlBFOiPTAob6Ud1qMYTpe2jx
 29rsLghtHjE5w==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 0/3] drm/xe: Disable stolen memory for driver allocations.
Date: Tue, 30 Jun 2026 15:55:19 +0200
Message-ID: <20260630135523.1775379-1-dev@lankhorst.se>
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

Using stolen memory has effect on system stability on integrated at high load,
and causes increased latency waking up from media C6 state.

Only use stolen memory when needed, which is for GSC firmware and FBC.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513

Maarten Lankhorst (3):
  drm/xe: Avoid using stolen memory for DPT.
  drm/xe/display: Avoid using stolen memory for framebuffer when media
    gt exists.
  drm/xe/display: Do not allocate into stolen for new framebuffers.

 drivers/gpu/drm/xe/display/xe_display_bo.c | 40 +++++++---------------
 drivers/gpu/drm/xe/display/xe_fb_pin.c     | 33 +++++-------------
 2 files changed, 21 insertions(+), 52 deletions(-)

-- 
2.53.0

