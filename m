Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B53CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 00:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0D810F72B;
	Fri, 29 May 2026 00:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cd1sNyoE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B029110F72B
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:01:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B1AF40ACC;
 Fri, 29 May 2026 00:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D38C1F000E9;
 Fri, 29 May 2026 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780012871;
 bh=JPawECuv70TjMvx1NH/GERoDHWctvHzeFAAYYj/q4rA=;
 h=From:To:Cc:Subject:Date;
 b=cd1sNyoEw1TqeuNAvlnXCPm4lukbXAqjelpJuF5EVWSwu655aUewYq8aQzHoTAXvr
 EgST2lTHodbaCZLf2w0bbBq7piSJOGWHnTLbgulx+p2dhQNcWYLPMPcdy3vyFKeoNK
 3KDRW4WqvGF+hkfBvkJQyCg8g2CFX5ojiZSoLDlLJ7GMRTCYHQKwn6ssr6HDGjW8JH
 b2H1kcYD49xUCrCePihYNU2h9iDoY769RAZbEloC53FdmuBZI6Y+rGtnCOpQQQGc78
 BF6pewQ3pvyaGQl+VnZkHOwdttpbBcRyhsocVK5ZK52YrTw1rN70/rPrzQohlXQQjp
 JuF374ZaN11LA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 boris.brezillon@collabora.com, deborah.brouwer@collabora.com,
 gary@garyguo.net
Cc: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 0/2] drm: tyr: use lifetime-bound IoMem
Date: Fri, 29 May 2026 02:00:52 +0200
Message-ID: <20260529000106.2257996-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Adopt the driver core lifetime infrastructure for tyr.

Separate the driver type from the driver data and use lifetime-bound
IoMem directly in probe instead of wrapping it in Devres and Arc,
simplifying register access.

Changes in v2:
  - Don't return Result from GpuInfo::new()
  - Use "drm/tyr:" commit message prefix

Danilo Krummrich (2):
  drm/tyr: separate driver type from driver data
  drm/tyr: use IoMem directly instead of Devres

 drivers/gpu/drm/tyr/driver.rs | 29 ++++++++++++-----------------
 drivers/gpu/drm/tyr/gpu.rs    | 17 +++++------------
 drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
 3 files changed, 19 insertions(+), 31 deletions(-)


base-commit: a3e50e7279996cd987001fd8a3db36e72665f8f7
-- 
2.54.0

