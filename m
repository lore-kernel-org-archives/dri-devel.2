Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B4C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4993910F0ED;
	Thu, 30 Jul 2026 23:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/Z4DHgA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D977010F0ED
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC25B60254;
 Thu, 30 Jul 2026 23:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855F81F000E9;
 Thu, 30 Jul 2026 23:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785454401;
 bh=hBXkWesllLiSkUR2TQmLiRBA41k3CnI5ZjZMNLWiPso=;
 h=From:To:Subject:Date;
 b=J/Z4DHgA4YKSb8j5VO2EAjb8D2BCiHt7PbE4zMGNjB4d4uDhaHlqnRnEaHdrsHNRl
 s7YJdy+9Ml4VOUzbSKQhkp0F4wUOC/8K3iPTuFTsLGx+iS/5riWqacysIGHrZ53l/W
 pfIBGXMS3CQA/ytPUJifObbvdCgjeKC+FpmDcT30XKriInAL1myMQWGJ0Ythacutnd
 vK67jVGVIz9JT2Y3z9OP/g3vJF+fqFkcgnBdfem7htk7LaWWJuc6/LzudZVi4n8gGV
 EYuvyPL6+gCROp9ySWImGC2TrgrGClKKoK5naG5r0+u2XrIWap0wTJtTQ8JZ7a+u6P
 rFZQwirDEx+Yg==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: [GIT PULL] mediatek drm next - 20260731
Date: Thu, 30 Jul 2026 23:33:17 +0000
Message-Id: <20260730233317.3222-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi, Dave & Sima:

This includes:
1. cec: Correct the compatibles for mt7623-mt8167

Regards,
Chun-Kuang.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-next-20260731

for you to fetch changes up to 4c0ca180a386cf72f2bd368557067b0210d61ac3:

  dt-bindings: mediatek: cec: Correct the compatibles for mt7623-mt8167 (2026-07-29 23:21:27 +0000)

----------------------------------------------------------------
Mediatek DRM Next - 20260731

1. cec: Correct the compatibles for mt7623-mt8167

----------------------------------------------------------------
Luca Leonardo Scorcia (1):
      dt-bindings: mediatek: cec: Correct the compatibles for mt7623-mt8167

 .../devicetree/bindings/display/mediatek/mediatek,cec.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
