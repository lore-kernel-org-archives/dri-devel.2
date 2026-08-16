Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2470CC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536FA10E27F;
	Sun, 16 Aug 2026 13:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHgKN8hZ";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3653F10E27F
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 13:09:07 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so281112f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786885745; x=1787490545; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uV4eLziIu7+6QdHB29PuLklAT6W4mEnmwjhDwjBVNpo=;
 b=hHgKN8hZ4kK/3isIadrFNAuqtlXU6T6EbXh79ggTj0TMFGQv0bki4rp3ESonIeImKM
 hZv3BqvgXqg5/+sUFElY9jdGOFKtJjSRb8bhogXu0KxH6h/lMLHxeZYbSqlAtKbtdlqK
 2d8D/QxHsZSb9Vx6K4Qd/Bi/biQ9tQul7+WRmDpLP2zDvAvm8n5azqlvxIhb7m5XzzAv
 7kyKfZmLZxOvYSZ/+0Uq41yxkOWx8iO8VT/PPBUIBaGEimj7qMgVSuuAZvVf2L5KBY8K
 MhJ928RzkyHjuGU0HRfmojLTgZWpA6obPuClXF/YUKBm8TimZBKwMBN380eIypt11tnj
 QKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786885745; x=1787490545;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uV4eLziIu7+6QdHB29PuLklAT6W4mEnmwjhDwjBVNpo=;
 b=qApzLeVtLYCSMsubFMbhTfsv2V7Yw4bq717jwQEG78tXozKbo9K5m5Pr9BdcYvQ8rq
 OozIi6jiWvj6e6A/AlnXf8zYWHqd4Lga+ZB8na80vhYpOBEOytGM0yFnDdb3f/UUtCpB
 6kAqudmE6hWbiHUE1ivMrnGqmR/7jFJbCmelgi6jp6VUSuf8Y5djuMy5bBg2WHU1doi+
 j/noQUjkwefHTrQfop4RVEkzT09g2EoppijbsZLfkxgGb7l+ccJ60vYT9npkIdovswAg
 iRpS7A74TwpyEyjCfTdsCpJyaavTOQrsNh7VUijVLJJx2UcKsHfqs9vnI2sYppFlhJDB
 jb/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHwf9nCGtH1spZoqmhryxxQnfTvjuRf+MeV3U9NNLdlzt9JrhvwEF6bioP0okAQwzlMb+M5Z3c9WQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG9ZmpqnvamzbgeZDtXr7vZj4zl8hk7+NBqCYOTu2uI5V3Jkf1
 EXUCiEKHcUjw9KHzxoLTONK2BiHr6Mll92IuJ5m/ZNPIJccOrHM55o+R
X-Gm-Gg: AR+sD13WPVdDH0zbjtGtkpBdtPcaIiE6leylvXrwRID2M+TyPX6rhmje+Pklz4x44fw
 V/qxOvAXjFN9BC0+rFJZp2c4mccwHST4wEfB5ALNaU/imCuRUZTY8NL2oT9t5xzugvMLq/3mXV8
 aaEGbIkrGn8iCxzp30a6E5I4bPWKp/yNTP7NcUWJVUsskTme7dgluGBmn4WdwF+Ylp8zYU6cJws
 x6YtTGpO76+dMjs2bU2NDcPAAB+jncAY1BHofiEloQptw9IEwE3kZ8bnV22Mx8l8xYshobz+kJv
 zphF2Zmo8NwX1LYJ1SSqogTInfqEo6kcbhwXYGxmkYN6mLtnhJ/L8yK4malXeTRsANFrNhrQumM
 9VR2DDsxLGAlimtzwQxZWsX/LQbCka4zhXXZ4oB8ulWcHA2b3u9idue+duZORdrfIhCtLrXKD4W
 B8DGXe5tOzW0gLJcfLb1dgiw8UGuCDYfHRS0gyyvRdigLc41DaewO4aL5VwIQMm7BrhBJq6XDxI
 wtMEdKp0daE/w7QCtMByOdNiuE/43Wno1DQ4YUYQA==
X-Received: by 2002:a05:600c:a0d:b0:498:1371:660c with SMTP id
 5b1f17b1804b1-499878d5e0dmr133443125e9.0.1786885745481; 
 Sun, 16 Aug 2026 06:09:05 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996105c0bsm66548375e9.4.2026.08.16.06.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 06:09:05 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 0/2] drm/nouveau: NVAC (MCP79) stability: MSI rearm and a
 NULL crtc guard
Date: Sun, 16 Aug 2026 15:09:04 +0200
Message-ID: <178688574400.522643.6695278742335367229@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

This is v4 of two NVAC (MCP79) stability fixes.  v3 went out on 11 June
and has had no replies:

  https://lore.kernel.org/all/20260611124535.527275-1-mczernohous@gmail.com/

Nothing in either patch changed.  Same diffs, same reasoning, same
trailers.  The reason this is a v4 and not a ping is that 2/2 no longer
applies to mainline, so a ping would have pointed at a series nobody can
test.

What moved was somebody else's context, not this code.
Commit 5164f7e7ff8e ("drm: Rename struct drm_atomic_state to
drm_atomic_commit") changed the callback signature, so
nv50_sor_atomic_disable() now takes a struct drm_atomic_commit *state.
2/2 is rebased onto that by hand.  1/2 applies unchanged and is
byte-identical to v3.

Both bugs are still live in c21bb4193868.  dispnv50/disp.c:1568 still
does nv50_head(nv_encoder->crtc) with no NULL check, and there is no
guard anywhere in the function.  Immediately below it, :1570 takes
nv50_outp_get_old_connector() and :1572 dereferences the result without
checking it.

1/2 drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)

    NVAC re-arms MSI through the MMIO mirror of PCI config space, which
    is unreliable on this IGP.  A missed re-arm leaves the interrupt
    line dead, submission times out and the GPU looks hung until
    reboot.  Give NVAC its own pci func that re-arms through real
    config space, the way commit 5112abc6a433 ("drm/nouveau/pci/g92:
    Fix rearm") already did for g92.  Only NVAC is switched, because
    that is the part this was validated on.

2/2 drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()

    Restore the NULL check that
    commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove
    (nv_encoder->crtc) checks in ->disable callbacks") removed, as a
    drm_WARN_ON_ONCE() rather than a silent return, since a NULL crtc
    here is a state-tracking inconsistency worth seeing.  The guard is
    hoisted above the backlight teardown so the old connector is only
    used after it has been checked; without that the oops would just
    move a few lines down.

Testing.  The MSI change continues to run here on the Mac mini as a
daily driver, and Fab Stz confirmed it independently on an iMac9,1.
Both Tested-by tags are carried over unchanged from v3; the
diffs they were given are the diffs sent here, apart from the mechanical
rebase of 2/2.  For v4 I rebuilt 2/2 with CONFIG_DRM_NOUVEAU_BACKLIGHT
set to y and to n, because the patch splits the #ifdef block in two and
that is where a change of this shape tends to break.

If something about the shape of the series is what is holding it up, I
would rather hear that than keep rebasing it.

Marek Czernohous (2):
  drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
  drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 30 +++++++++++++---
 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 35 +++++++++++++++++++
 5 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0

