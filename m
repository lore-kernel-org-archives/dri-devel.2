Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4B8CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 22:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDF610E720;
	Sun, 18 Oct 2026 22:03:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D1410E13F
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 22:03:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D27C6408A1;
 Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADD3DC2BCC7;
 Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792361028;
 bh=R/lIBi5xVRT9GBvuisR5VhE0gQGV119/5xNOWD1DMVs=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=NRg/Xcknlkr3IvhUJUWbVme6VH0oK4vax/Uyan/pzxAwp3dU+pazzj7au7yy91D2s
 yRzvJRMsgzADbT9ZYNv/iVbcHtGtQoNwYopOSaMiF+v/rUzhHU2Vl7ejBi1arnR3Nt
 jLPnM/m5iCPmMi/QJijSQ2Qc1FALQr1xXH+cWl0sDqdnWqLw65lHrcMftV8Q+zaPVv
 sMJ8VuVScMMWC5B0kVKMDIKT/jt0frjGdqXW6XGvh5Q5mKv3lftDV7+F6wABl5+i05
 2srB/Bvl0nxytgVUkzIMkz2kATsdz3AJT/m3eTPTW0eEUgNkcUuEp66Z2pRTa/a7ba
 7HxL0sSLvE61w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8973CCCF2C9;
 Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] drm/tegra: Support YVU420
Date: Sun, 18 Oct 2026 17:03:45 -0500
Message-Id: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBBGr0Jm7ZhpqT9x5T0Mi9IOMImAabGRk
 N7dygFcvpd879sgchCOcKs2CJwkyjwV0IcK3GCnnlF8YdCkz4roigv3waIPI67pbTSh8m17UYb
 4ZCyU2StwJ589+WgKDxKXOaz7Q1I/+yeWFBJ6p5wxtSPq6ns/Wnke3TxCk3P+ArsvzFmwAAAA
X-Change-ID: 20261008-tegra-drm-yvu420-1dbb7140e54a
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792361027; l=1534;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=R/lIBi5xVRT9GBvuisR5VhE0gQGV119/5xNOWD1DMVs=;
 b=FRC4bjtGu7E6H/zvKW1tazwdCKnbUQd6u7L6Nt632QmVvTijrfpLho+6G4U5I3gD2JV9xSXMF
 nrujb+NNsd1BebpvpBJUSNgYBZUyghEMf9ZURmf4OzA/fxY5KdmSyyr
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is not directly supported by the display controller hardware.
However, this can be handled efficiently by just passing the chroma
planes to the hardware backwards and reporting it as yuv420.

The format is required by AOSP for software decoded video playback among
other things. An attempt was made to handle this in gralloc by swapping
the chroma planes there, but it wasn't working. This kernel
implementation is working and is more generic anyways. This has been
verified on a SHIELD TV 2019 Pro for the tegradc path and a Jetson TX2
NX for the nvdisplay path.

---
Changes in v2:
- In patch 1, simplify pre-nvdisplay path to a swap of the window base
  address
- In patch 1, address sashiko report about failure to copy the new
  struct entry in duplicate_state
- In patch 2, address sashiko report that yvu420 was missing from
  tegra20_overlays when the targets already support yuv420.
- Link to v1: https://lore.kernel.org/r/20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com

---
Aaron Kling (2):
      drm/tegra: Support swapping chroma planes
      drm/tegra: Support YVU420

 drivers/gpu/drm/tegra/dc.c    |  9 ++++++++-
 drivers/gpu/drm/tegra/hub.c   | 15 ++++++++++-----
 drivers/gpu/drm/tegra/plane.c | 13 ++++++++++++-
 drivers/gpu/drm/tegra/plane.h |  3 ++-
 4 files changed, 32 insertions(+), 8 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261008-tegra-drm-yvu420-1dbb7140e54a

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


