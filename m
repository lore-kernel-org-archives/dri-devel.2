Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24B0CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED31F10E342;
	Mon, 25 May 2026 23:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M/o77t8o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCA710E342
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:02:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 151DE4431B;
 Mon, 25 May 2026 23:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330711F000E9;
 Mon, 25 May 2026 23:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779750126;
 bh=S2uI5zgspP6cNcWKDDQWRpzAEQVb4nF+eNOFB+O6P0k=;
 h=From:To:Cc:Subject:Date;
 b=M/o77t8ojLAk7q6HCkyBbDZzhoTrEdSzdqfF9SeGll7wR+dz0xjpALmERSq0GufdX
 p7ihl5N8ns8m7vPUT/hHX5h9wt/9C11WUGDBepTmQRd5Es3tgTOL7fD6xPa1jb3xss
 kOIwyzWuWPWf/C1kS0YIMTRgYXSyXQnPg9cJdIUp0jaDjLVIAqc6AAZUU5UIFdc4bB
 en8u/8ydqxIpqwz/MPVpq876HX5CgWEce5g9fH+PPvC1ZMCfo6kMiENayP/LmhawZ5
 efKarLzCVCTMIrInz1sKBy7xoODafyhJ2Laz3Lpstllfq83frxdoTjl8KWZCNyzlub
 UNiZOltqAo/oQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 boris.brezillon@collabora.com, deborah.brouwer@collabora.com,
 gary@garyguo.net
Cc: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 0/2] drm: tyr: use lifetime-bound IoMem
Date: Tue, 26 May 2026 01:01:42 +0200
Message-ID: <20260525230152.277820-1-dakr@kernel.org>
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

This patch series is based on [1] and drm-rust-next.

[1] https://lore.kernel.org/driver-core/20260525202921.124698-1-dakr@kernel.org/

Danilo Krummrich (2):
  gpu: drm: tyr: separate driver type from driver data
  gpu: drm: tyr: use IoMem directly instead of Devres

 drivers/gpu/drm/tyr/driver.rs | 29 ++++++++++++-----------------
 drivers/gpu/drm/tyr/gpu.rs    | 13 +++----------
 drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
 3 files changed, 17 insertions(+), 29 deletions(-)

-- 
2.54.0

