Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21997CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC8810EEE8;
	Thu, 11 Jun 2026 12:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKEBPmWP";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7C010EEE8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:45:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490a762c8d5so7493405e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181938; x=1781786738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hC/dkIeX3rG+bUwxYjAdonivB+9Nfr2TugEmLAKhT0w=;
 b=NKEBPmWPVfLv0N23TtSkz4zN/8mR20t3urXFZUotTGOjUxune3sydFmuSKt3+qxJSh
 UD2RvR6E/R0bKvGCyanob7vHHg5FR+pGsvgj9CPAyblSHDmcBxA5b3UJ23HZjGVdejnu
 pMGOrE7mAtj37zFgt29U0tDqq6E7b67+nQy1fR5k3HwHLveLuU+4ItXnm6PxR8/TKt4U
 LeBrlh9r2DNDC+7pm3k4O1MHKaYuRAMf6fXW4XZAfbmnSviRY1KOvHIVogZf8v48EWJS
 Yn5WqHWg1LJUebvs40L5mVB6JlBj9gOF105xN6T95VrEU7xX1ndwwa+KgAcqbeaMC8H5
 P03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181938; x=1781786738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC/dkIeX3rG+bUwxYjAdonivB+9Nfr2TugEmLAKhT0w=;
 b=AVItOl5VXkP6nHBhe1aELaSEaur8D7Rc2r0rhl+xduBnDol6LVk2FUH6oypMHFJJql
 SV2liLjTrB9khE+kdHzfVkN7vsErLt3gCxqPWOkegmkeNMNUDnyLvMo8s+pzAot3p1tG
 i2CLQ04yNSf8xvzHMkK6v/35CMqZUyNVMH4hPrEZuGi+quh9q8zLLBBLhti8UHB/WZ0K
 yYz+1yD/jAh2SVcuKJGbufgKdRL86IryyHgVvUlk7KYQVXKBJTvRdXIluwicmE0vSFOW
 qST/pHs+nGA4P6ZVltw+lrlA5TV2Il3hM5w+p4/bn8oEXAWrnsXf2Ztu94k8vGXvcs0J
 9eow==
X-Gm-Message-State: AOJu0YzCGGcQNtD+2Pg4vvFrSr1+RwInXkkkgjnjQJRYFr7oXL/qxLMM
 tdvW3u+NfYFP/z4zV6WcMQWoTZU2URXOdugfmtR1NGcMWLYX9awqHD/w
X-Gm-Gg: Acq92OGt889e9/SU6C1eHQvRm57Jp55v6uuRpoiq1qpxM7gpMyYvHSZouLo7pqRl9xJ
 AldXnprZBpxfB9kUnmAo3hfnOq9TIYUgTvpxPHfxKnWnKtwSQAKT29TCJ117t1DglMm+aMvqX3b
 b0Okif/oCluoI+UBnnY+EePx+pnPiB/d5L5Ht6/nZFw5V7dtZFLXK1Gtu+vsFywLrJtPFCUi7ZF
 CceE772hLlCk2pgA3CYIfO52I8lkdk5qmhYMzFALUKfJoZ0CtUtPpeU/rclsAsC8g7+DO5J1JKr
 M0S65GMoz8ZvtVkwQU78vg+Fzy2Zo5ptM5kFh6wQaLNS3/EvjptAr82/fwelfBJXb7ZkvBUIY4J
 JH8fkgYx9vRiwlQBKPokTHc2Bs6eKiygzS0FyKOFqeW4jnYJEL9vO/8YL+ZqSaNd9tsoKTwWorG
 daT1TvWJqzzGvB7UetjXRwt8voE6aHhlaPi5aiV2jBxiSUdN+HsVILqD48dVCxZv/Y34KXr/DXD
 ehD7MObRsAmAtf6KjR4ppDfomTy
X-Received: by 2002:a05:600c:46d5:b0:490:c123:3b7a with SMTP id
 5b1f17b1804b1-490e562490cmr17760225e9.4.1781181937355; 
 Thu, 11 Jun 2026 05:45:37 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm48697645e9.14.2026.06.11.05.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:45:36 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v3 0/2] drm/nouveau: NVAC (MCP79) MSI rearm + SOR-disable NULL
 guard
Date: Thu, 11 Jun 2026 14:45:33 +0200
Message-ID: <20260611124535.527275-1-mczernohous@gmail.com>
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

From: Marek Czernohous <marek@czernohous.de>

(v3 follows up on this morning's v2 posting twice over: those mails
went out with a duplicated in-body From: line and broken threading due
to a send-email misconfiguration on my side, and the Sashiko AI review
correctly pointed out that the new guard in 2/2 sat below a connector
dereference it was meant to protect.  Patch 1 is unchanged; please
disregard the earlier copies.  Previous posting:
https://lore.kernel.org/all/cover.1781162589.git.marek@czernohous.de/ )

This is v3 of the NVAC (MCP79/MCP7A) stability series, narrowed to the
two changes that are genuinely stable material and reworked after review
plus an independent second-machine test.

The original v1 [1] was a three-patch series. Since then it has had a
two-month daily-driver soak on my Apple Mac mini (early 2009, MCP79) and an independent
test by Fab Stz on a second machine (iMac9,1 / MCP79, 6.12.90, X11/KDE 6),
who confirmed the system is more stable with the series and provided a
Tested-by. After an internal review pass:

  Patch 1 (MSI rearm): NVAC re-arms MSI through the MMIO mirror of PCI
    config space, which is unreliable on this IGP; a missed re-arm leaves
    the interrupt line dead and the GPU wedges. v1 switched the whole
    shared g94_pci_func (ten chipsets); v2 narrows this to a dedicated
    mcp79 pci func so only the tested chipset (0xac) changes, matching the
    existing g92 precedent.  The stable tag is annotated v6.16+ (the new
    file uses the .cfg member added there); older LTS trees want the
    era-specific one-line msi_rearm switch instead, offered in 1/2.

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

Both patches carry Fixes: and Cc: stable tags. Per-patch changelogs
are under the --- in each patch.

Disclosure: this work was done with assistance from an AI coding assistant
(Anthropic's Claude, Opus 4.7 and 4.8); the analysis and conclusions are
mine and have been verified on hardware. Each patch also carries an
Assisted-by trailer to that effect.

[1] https://lore.kernel.org/nouveau/20260409172126.115441-1-marek@czernohous.de/

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

-- 
2.53.0

