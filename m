Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B403FF886F
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 16:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8C110E0E6;
	Sun,  3 May 2026 16:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2NO1q8K";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804EE10E0E6
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 16:38:56 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso7284860a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777826335; x=1778431135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uncfobcGMqJkNZBnd2AFYRmsf7AjZTfSUk16J49FjSg=;
 b=O2NO1q8KlYhBKOQOV2cSx6OcsiimbgU12/1XGGEAOOlY+DIequg9sWlX5foKBlqQ2b
 vFXNHxPr1JYlToBbJtAI5uCfhxNeK0OLsPO4OZHr4kIODPLUjWToHPwycp2R8fvHqbPP
 0ZG1Z0Lvi2IDGNgN+6K08qLFSxBFnBz5O7ifpJaseKDeA0fwhMw2SnmTCp93Zj/5QaxA
 rjRm+HylPo8mwb/306d6fXHVc5xQNAfalhm3wdfbaZxayz2kYyZTv/GbWo5hdr4xVUcb
 T9nnWWiETKEyleR76ixzOUJnuWrxdmreqUBJdwYiRMRpjJElzpTDxadNGEa5TGQsYqAu
 rCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777826335; x=1778431135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uncfobcGMqJkNZBnd2AFYRmsf7AjZTfSUk16J49FjSg=;
 b=i3TcIwBK2HR/z+bJ9APl77k5Yv3GgjotswmQZAAK80MqqFshkWFsX4ZWDaTh7XpNSM
 +5U15vAtqt65BRzkMM9hoJT84/M3XDBKU1mWNqJa7vpOQRJoheCP70kTMiVYeo0NXfD8
 grBb9SqKDNKY3/22O3GzDRpdhEr8JVyNLVU68NSsNd0OelGXjpCcidMEhtW8IZ0qKI3H
 HHEwZAqL1qAGt5wSatnSSLZ58CA02TuP6TeCrLFFgcgb3W0AkGvZ/S2eOIzwT7ak5oJO
 VII4mVV/pwW5JVnKi36I6jTf7dUBDPlUdxiR3mG1Cfhc5z/MUsDEB2Hp1osNONehbMO1
 5goA==
X-Gm-Message-State: AOJu0Yxa/Tx0PXT+SI2FsHpRzXzNnJk2EuCttDdcNsA3dKAeAIiQvDEL
 tPxjqjl1FQOXEZiqmJRrH+jVbPmO0hYOU0FW5BXjQTfwI22z9BA1rKtG
X-Gm-Gg: AeBDiet/0UPK8LDRkdDvroWxGLwuz24MKclhSWtjmKcWbC5APXIx9uZTmU2M0jafzO6
 N/Qqg/o0mjJ14ZnuEta23z3nbLcym11PYI7NEzXXj2JNz4H2y24qeDv2txqx+jJSGVH9bjLtMs3
 Oe5ife7AnSg46Up7XVAkQ4D1ou5HB9E6sULCoj1J6AMSYKT7jt1f+/S12FxcOt0Gpu+JGqKRTfJ
 NEoY4YcM6bI75tY9057Rsw/GEm/pfVingKF+lwPkejqmOFQw7BxRSXS3/yPR71DyfiCMYCYZPpM
 b4zmT0krvEgon7WWU09zuAl4DFvrm2MyzP21MjYEcIaG6IatdBwpTqXBITBWQ19b8BY2e1yGDJg
 ki2I/SGjcRmguIZoEBUpYODGE7XvqvnODjWvs9uEPc9SVGJKQ3rupokAPkB6izpUm2NmFeGw31k
 82mnf2RaFAKbHNrjxP/3QTQGs=
X-Received: by 2002:a17:907:cb81:b0:bc1:c4d:cc70 with SMTP id
 a640c23a62f3a-bc10c5d0eeamr181734966b.2.1777826334818; 
 Sun, 03 May 2026 09:38:54 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bc1ffd6f8e9sm44126066b.13.2026.05.03.09.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 09:38:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Sun,  3 May 2026 19:38:40 +0300
Message-ID: <20260503163842.213489-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The gr*d_remove() has pm_runtime_disable, this indicates it should be
paired with pm_runtime_enable in the probe instead of being inside
gr*d_runtime_resume().

---
Changes in v2:
- remove pm from gr2d_exit along with pm from gr2d_runtime_resume
- move register map initialize before host1x_client_register
---

Ion Agorria (1):
  drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove

Svyatoslav Ryhel (1):
  drm/tegra: gr2d/gr3d: Initialize address register map before HOST1X
    client is registered

 drivers/gpu/drm/tegra/gr2d.c | 17 +++++++----------
 drivers/gpu/drm/tegra/gr3d.c | 17 +++++++----------
 2 files changed, 14 insertions(+), 20 deletions(-)

-- 
2.51.0

