Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478DFCD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC94410EA7B;
	Tue, 16 Jun 2026 11:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AlmLNhVU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B51C10EA7B
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781610866;
 bh=SOF6AL+ysNAFhPdAeEiJ5NIVz/Sx/p3YX7B/NqB0stw=;
 h=From:To:Cc:Subject:Date:From;
 b=AlmLNhVUBm6Z37q0OUvgoLPDWh5jtTWB7mrGsKkI9kyjdprdLTmBgMJoeyKgYjxvY
 Qi5wItnFA9b2XTW1Y2emqlFLKVdmK7rxwayklIcevli5UNa/1qWePljGjrUXkLihU2
 9b+cvXiP3OiWqr34lBO/zDMrlHcwpvAbkpgtY7+wZExhYn01jKEeG0ll3LOHpcNFl9
 qC+aanZzrkSht6iP7b1kDDz5lCPoBBatHHMQ69Ec2VUj1l5Rftw2ul/UWFR6UO96C/
 dfJqcgPVpIpBZTpv1zbases5HCuY13rVt8UvjvL37ram4bAaAF4bDEPM+l/46+nxBO
 PlB/pUrsi8fAw==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9BE0917E0979;
 Tue, 16 Jun 2026 13:54:23 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm/ci: retire limozeen job and add
 wormdingler-rev1-boe
Date: Tue, 16 Jun 2026 17:24:03 +0530
Message-ID: <20260616115410.325837-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
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

This series updates CI coverage for trogdor-based sc7180 devices by,

- Removing sc7180-trogdor-lazor-limozeen job, as most devices in the LAVA lab
  have been experiencing stability issues.
- Adding a new sc7180-trogdor-wormdingler-rev1-boe job.

MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1687201

Vignesh Raman (2):
  drm/ci: Remove sc7180-trogdor-lazor-limozeen job
  drm/ci: add sc7180-trogdor-wormdingler-rev1-boe

 drivers/gpu/drm/ci/arm64.config               |  4 ++++
 drivers/gpu/drm/ci/build.sh                   |  2 +-
 drivers/gpu/drm/ci/test.yml                   | 22 ++++++++++---------
 ...m-sc7180-trogdor-lazor-limozeen-flakes.txt | 20 -----------------
 ...80-trogdor-wormdingler-rev1-boe-fails.txt} |  5 +++--
 ...80-trogdor-wormdingler-rev1-boe-skips.txt} |  3 ---
 6 files changed, 20 insertions(+), 36 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
 rename drivers/gpu/drm/ci/xfails/{msm-sc7180-trogdor-lazor-limozeen-fails.txt => msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt} (95%)
 rename drivers/gpu/drm/ci/xfails/{msm-sc7180-trogdor-lazor-limozeen-skips.txt => msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt} (91%)

-- 
2.47.3

