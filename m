Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF9C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C6110E844;
	Mon, 13 Jul 2026 07:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mg4nZIqx";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3A210E2C9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:37:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so19817875e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783859846; x=1784464646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEMsU51i/WwRT9EUJxt87IiRt2e91AKiv08Nq7CHthI=;
 b=mg4nZIqxL6/PD87YTw4n2OuHKkw1M3SJsPiV+HnnrALZb9NyNVs/G9FFI+fwCYzM/O
 26xxG6BUUl4WWsr8D6iHZXNV4cPqTUelWFGwLkZKLCpvdxCFIalx2eNHm3Tuf8BuJwVD
 pLC1fJVGOmVGdJ3UcVxwxQz5sVqDH0pK3HF025LGTdM7sGJJ7GXsi2V9ArhYYRcH5TX7
 KuskemQWxhxjzdcQDJdrP7DvGS/SjRZPPlfT/eJPUv9daV87MkZKWTMm8ou3vEoAqFQC
 QeIEo7+7fzvyIdaRi14dY5nY2EyksHn6QfoddYvyxW1yrs4aPEda71h/oFgM3SYEr5hB
 SB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783859846; x=1784464646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEMsU51i/WwRT9EUJxt87IiRt2e91AKiv08Nq7CHthI=;
 b=jx8B13lE486Uqbz7oKo7TZ48FPkYVEin7/ez7MoBqDKMhO7NoXK815WqHw6sWCFrpi
 VlaGHChxhapVqxxs/6ba7Zv4Z6FHBYbFoqLBn1Aeoq43oPaTdxWHEoBI3LpGhG1fG3iX
 DikdsCHhFmaxZW7ByOUy02xTvMek2GLG/xCGY5yGZSKAJkoSNS4AHyAksTinT1UtmooT
 tUx5cWzEb4bSOIxs73Pl/z6jqI45FDbvsAH8a9zSpF3Ol/yGJKr/fIYEs2q2B19wb+uA
 JqyE5+8v2TUvbgxib8xRUHknQWy3RNtoN5aR7lJL1yDAcpo5tuiHQWUYlUWheGL5TG66
 zeaw==
X-Gm-Message-State: AOJu0Yz/t9cVENc8lUAMnu/vtqZu7gtuYGzSKKZLXGrS/PlJYNXSmfFg
 dzVqX13qoLgjZXfsT5z59+kgEZYrmiVvwMaG7ywMrxBAp9h+ul5yu9kM
X-Gm-Gg: AfdE7cl/E6wagHaIttIB1kMV3C45pjkHBVB3irSUt/mPSlEFpM/LBermxe/l9HW72eh
 WGa4ft+Uz1zdI9yIDBC4RX99G6UHc5Nlm6g0dNNt7jB00ExxDiet3ClDtc8/SrnhWv5AnnA4+8R
 TfIf75jxc85GhtxY+deW0wtchylj1J22kNUmdMnWv09E1pnL5RX8fKg8Ef9qZ60sz9bLxN8L5KZ
 CWOhK2frl6jAIVN3s6N/G7eLkSDZbc2f1xFa36ak0LlT5TGA8MYG7f9Az+wfeQc36LuEbL3GpID
 2LnPW4I0V5SINUsyafGdh3Q5eQq4PfGkFBYz/BDpXabpJPxotlo/ST4gOvZJVSt2od+8jNnqJ+W
 wKXRygK/+VaTQMWuSv30mfsM3BfcfHMESX6GZmvoSEiQnmuY+TVpiDTLwzxxgR5LOe9htJzXDxY
 uYrDZO3ROPqO8UcfM=
X-Received: by 2002:a05:600c:705:b0:493:9661:f55d with SMTP id
 5b1f17b1804b1-493f8826bf7mr39689255e9.30.1783859846182; 
 Sun, 12 Jul 2026 05:37:26 -0700 (PDT)
Received: from fra-x8664 ([2a01:e11:8000:43b0:96d6:566b:35c:7b8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm280280485e9.1.2026.07.12.05.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 05:37:25 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 0/4] drm/nouveau: fix list cursor use after loop in the clk
 pstate paths
Date: Sun, 12 Jul 2026 14:36:12 +0200
Message-ID: <20260712123616.1180830-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

This series deals with the three places in the nouveau clk pstate code
where the list_for_each_entry() cursor is used after the loop, plus one
unrelated fix.  They are exactly the three sites Dan Carpenter listed in
2022; his patch for the first one was never applied and the bug is still
present in drm-misc-next.

Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/

Only patch 1 fixes a bug that can actually be triggered:
nvkm_clk_ustate_update() takes an arbitrary pstate id from the user and
never checks that a matching entry exists, so if it does not the cursor
ends up pointing at the list head and the code reads past it.  It carries
a Fixes: tag and the credit for spotting it goes to Dan.

Patches 2 and 3 fix the same pattern in nvkm_pstate_prog() and
nvkm_control_mthd_pstate_attr(), but neither is triggerable as the code
stands: the callers of nvkm_pstate_prog() clamp the index against
clk->state_nr first, and nvkm_control_mthd_pstate_attr() already rejects
args->v0.state >= clk->state_nr before the loop.  Both are hardening, not
bug fixes, and they carry no Fixes: tag on purpose.  The point is to stop
the two functions from being correct only by virtue of what their callers
do.

Patch 4 is unrelated and is a real bug, though a modest one:
nvkm_cstate_prog() overwrites the reclock status in 'ret' with the status
of the voltage/fan restore calls it makes afterwards.  The only consumer of
the return value is an error message in nvkm_pstate_work(), so the
observable effect is that a failing reclock is never reported in dmesg.

Compile-tested only.  All the affected paths are reachable only by root,
through the 'pstate' debugfs file, so I could not exercise them in any
other way.

v2: v1 (2 patches) was sent on 2026-07-11 with a mail client that mangled
the patch text, so it did not apply; it is resent here with git send-email.
This version also adds the two remaining sites from Dan's list, and the
Fixes: tags to the two real fixes.

Link to v1:
https://lore.kernel.org/nouveau/CAHwn+vnw=DD=j7umFVdcr8-F6yUz=iM+3yfA+HcHKXJwpNrHRA@mail.gmail.com/

Francesco Magazzu (4):
  drm/nouveau/clk: fix list cursor use after loop in
    nvkm_clk_ustate_update
  drm/nouveau/clk: don't use the pstate cursor after the loop
  drm/nouveau/device: don't use the pstate cursor after the loop
  drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

 .../gpu/drm/nouveau/nvkm/engine/device/ctrl.c |  8 ++++-
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 32 +++++++++++++------
 2 files changed, 29 insertions(+), 11 deletions(-)


base-commit: a284476db2653ae893f46cbea408eb412db54eb0
-- 
2.55.0

