Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3FBCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1D410ED16;
	Thu, 11 Jun 2026 07:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4GXXGve";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF47610ED16
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:26:38 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b1df16acso6886385e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781162797; x=1781767597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cO8v5zFPHN391/LtW4mNbY912mSFMxqBdmu1KT2yTyA=;
 b=K4GXXGveA+UkKaTyOz5Y4Lz8tFmjsn/msA3S0+8Azwu3Hjzi9Y3KIVsSaQ7IbVffOr
 vLuftX8Ca3NaLsbdVH0mLyfpCBLUt9qGWlxTD0XJqs0WarEct64jKM2pXgXWWJbk5LTb
 kH3syKe1C/iklZJOVTt64G2TOqluudTwT72A6nkhAbstjkQj+8RBh/Hn/Z57CnHdkCe0
 m7fNS3ml14PbX6gEzNzMNX8o0MBrdhU0UD1/cv4SOc6Ncd4q1lVxGyq5w/D2VuxgtqFL
 FsQrThzmASwUPqrkAYp688kKu5YatNIGgf0a8wqay1Y0zN1X3pgB3/zNwwC4s42h67KG
 l+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781162797; x=1781767597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cO8v5zFPHN391/LtW4mNbY912mSFMxqBdmu1KT2yTyA=;
 b=FTl4vygxDDwf/0ys1tdb2Yw8f7r1Pk7GQxcR+alEk6EvHGZ6n1X2vb5vwuAFSe+YAI
 XU89njl/UOdJgLywMWX32bGHjYydGLajqF7FJYlZOWoXzx5UD3vq/glNOOVoexPjj3iD
 JQYCMuNMF9XjqDga7pAY4egNSe5MoLM6w6NidYkt2hBnyVhMAHUqe1YCCAK39TCY6ud0
 xIC6bFexRAKSxz15+bLI8YtWiHVoY+I8NM9PyjGoZabrgtG8Zt57CYO9jK/RhmlpAHQv
 9x6sWFAIVoifDIAop7ClpHdcpmspUh1oVOjKZUKORM/9MggsFSJvx70CSFhDtC9NEQ8M
 gzrg==
X-Gm-Message-State: AOJu0Yw/ezK6sxH2tMEPqeSNnK8xvmzTQCe002ZwTS3ffvThzu9urcU2
 kSHVTodzfdhbmoPW7Iq9WFLdjM39aWKQ8pJppfG59fbxM9IMxmyZsgde
X-Gm-Gg: Acq92OGKxhLXfSzIoDmqaLRZ8r88sj1ti+/Pi4CfGmbKmYIXKRbEXTUXK3zJS4iBAZq
 n+bGlodf7U993MRpB4SedeEHh1NFXlMvubgDcc4nkTHwymjnx8HNIOjsXOWIRnqnESoB1/sV5O5
 TQQPpoM3EGHwCviS1a7Ndj7D/oHa7i0ZKmdbljhCvXb1ArzvLsTJ7R0xmHgqUplsSeDNMS+d4f2
 YGPIJaPSsGI834JiP6YdLGy6pRWrcCyVKW0pLhlo6dBIJWgpJrdkn6GNJOJFKj4iGwJJLY+EVjo
 PrcjbdfCLahqMmsBXa7q7qMwygYceSSbyOjj1LLhE0yBSGCZp7i8RzfEH5xy8IfBAuAwbavpJrv
 j3qSeh3Iah3KCvVPOipNT4DEajSXj38ldeiUSBS96VaPSvhE9y4XCET6c0kOJjcb11m/7hQQ0tu
 JwkhVeM1zqW9WpvU6RrKUbL3dhkMG9gJE0tYcpvf1TbbPXwDzSMuoOSJfKDRRm6CkoGH/v5/CgE
 4oGdMgYAIuS3Yx6qmS3aLtlWA==
X-Received: by 2002:a05:600c:8b29:b0:490:6e0f:29f4 with SMTP id
 5b1f17b1804b1-490e55cc3fdmr8988475e9.3.1781162796880; 
 Thu, 11 Jun 2026 00:26:36 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea21sm42585795e9.1.2026.06.11.00.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:26:36 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v2 0/2] drm/nouveau: NVAC (MCP79) MSI rearm + SOR-disable NULL
 guard
Date: Thu, 11 Jun 2026 09:26:32 +0200
Message-ID: <cover.1781162589.git.marek@czernohous.de>
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

This is a v2 of the NVAC (MCP79/MCP7A) stability series, narrowed to the
two changes that are genuinely stable material and reworked after review
plus an independent second-machine test.

The original v1 [1] was a three-patch series. Since then it has had a
three-week soak on my Apple Mac mini (early 2009, MCP79) and an independent
test by Fab Stz on a second machine (iMac9,1 / MCP79, 6.12.90, X11/KDE 6),
who confirmed the system is more stable with the series and provided a
Tested-by. After an internal review pass:

  Patch 1 (MSI rearm): NVAC re-arms MSI through the MMIO mirror of PCI
    config space, which is unreliable on this IGP; a missed re-arm leaves
    the interrupt line dead and the GPU wedges. v1 switched the whole
    shared g94_pci_func (ten chipsets); v2 narrows this to a dedicated
    mcp79 pci func so only the tested chipset (0xac) changes, matching the
    existing g92 precedent.

  Patch 2 (SOR disable NULL guard): nv50_sor_atomic_disable() can run with
    a NULL nv_encoder->crtc under Wayland session teardown / VT switches,
    and because the deref goes through container_of() the NULL becomes a
    bogus pointer that faults. v2 restores the guard as drm_WARN_ON_ONCE()
    and, unlike v1, does not call nvif_outp_release() in the early return
    (that path is owned by the commit_tail release loop; the v1 form could
    release twice and detach the OR before the disable flush).

The v1 patch 3 (HPD link-check retry) is intentionally dropped from this
series: it is a behavioral workaround that sleeps under mode_config.mutex,
not an obviously-correct fix, so it does not meet the stable bar. I will
revisit it separately if it is still needed.

Both patches carry Fixes: and Cc: stable tags. Per-patch v1 -> v2
changelogs are under the --- in each patch.

Disclosure: this work was done with assistance from an AI coding assistant
(Anthropic's Claude, Opus 4.7 and 4.8); the analysis and conclusions are
mine and have been verified on hardware. Each patch also carries an
Assisted-by trailer to that effect.

[1] https://lore.kernel.org/nouveau/20260409172126.115441-1-marek@czernohous.de/

Marek Czernohous (2):
  drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
  drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 16 ++++++++-
 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 33 +++++++++++++++++++
 5 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c

-- 
2.53.0

