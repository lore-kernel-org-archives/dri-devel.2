Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C3CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 09:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CC010E17F;
	Sun, 17 May 2026 09:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlKcorag";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3127610E17F
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 09:15:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso9448615e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779009312; x=1779614112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0jmEAFXkvGaEuEol7IecG4O5py6NDPChMnuva5JHJCI=;
 b=nlKcoragI5Jsh8EMT3wVoGEQDBGeJXqYzOKaDK8SPN8CwcGwUQTFNJdXG1U3js0RkE
 IX4lIplBJNwBxzIue8OBH5LPbZZnyXGHzbIw4qV9lkzrLWFesbZv9lQhShhh5yI8Gnd1
 LlOsQIeT3nyx76QqeOsRKeTnKmRqDbvUjw4siSjnUUUDTiW3UrE0Us1AqeoKBbs8wa69
 eaI36BDX4gyfghgvNRFsFmkztfs0q+CAPqAi7a2kYyTOIIUgFyB7PJD4E4bcvpFgXlZe
 YUNseFmv0/gPoiwwA6wfvGXvMJsr+Ogb7O9qZ9dTKVe58rvN18oPYgOVAc16qVL7GpwZ
 7Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779009312; x=1779614112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jmEAFXkvGaEuEol7IecG4O5py6NDPChMnuva5JHJCI=;
 b=RLslZ8VCY5xO7mpS63H6UARChfdW5uRnYIV0A15Cnj5WQgCWxOgufcpcpAvi1Wyzd3
 qLVTx8jmhoISRhWFthNZX24uOs9CEIve5054/bEhqoraCwG51GFlaxlcKmwc92aj7d4v
 ZqiFGqe+uhSFmW6u3QjmERcoqYneZvcmOaLyC8REykEfRYTx40bZRKHBb+h6R2G4RjCW
 5uXPD8oaRO7VlRDhXFJTM6FjKCgsm4jDmZMrxCWx4PADQ6e4TimC59efCFt9vt/4CakG
 w2MHpJwlI9eF5q5HFzSoDFoaB176SAf1rrnVSBew5vVQ4fzEYba94LtFPupyKyfvgR6R
 Ohzw==
X-Gm-Message-State: AOJu0Yw1GQHFU/b6iWnBsflnf4IPM6bp7WGAd9qxsPKFQ25dRWRhYtde
 CfgiNnZlqxbHXHPHdu63Zl8CG+/YY2E0x/9D3ZWjhrqu6wfIsBfmOQ8X
X-Gm-Gg: Acq92OEz4ibJr885+GEC1XziXFac2xWdeLrNT9jYLzksC6/C2yGjuD08F8iIckfyWC6
 c11o3xSAZ19reMxRx9m6UvBz2U1esRZ1sqtO37RwsCvJm/0QJwJmIdC6F6NG9l6SUihkNUtexdE
 Qu1eLjNyPaFxsNwWpsDGcITnSnYxm62stFG0dVgCXrJQlNOTyaYN6cbCFV7TxWiLokat3wdqLag
 rzDRs/koxSVgb/m0slaoS1ilaCERdoBiCIyXuwV+KdTZ7bbbuYh1HE7epuNbWZ/u+YzcGZtOZ7u
 jpa4mfZKSC7OrHZJ7AxZ4BvEhH4/qc/JVVEBBq5IFrnU0pHjIiiPTO4erWqCmyH1cqitg77iLzy
 8lUSa3q8Sl7Alvykl9FboZLKyWM1u2LcAv6vah/0P5r+9gW8mvRU1uhvY5CWJa4T2diZyvo/R0g
 jKVuM1PKhEnNUk
X-Received: by 2002:a05:600c:4ed0:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-49007785052mr21015875e9.33.1779009312286; 
 Sun, 17 May 2026 02:15:12 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm29560235f8f.22.2026.05.17.02.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 02:15:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Sun, 17 May 2026 12:14:48 +0300
Message-ID: <20260517091450.46728-1-clamor95@gmail.com>
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
Changes in v3:
- pm_runtime_enable moved before host1x_client_register

Changes in v2:
- remove pm from gr2d_exit along with pm from gr2d_runtime_resume
- move register map initialize before host1x_client_register
---

Ion Agorria (1):
  drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove

Svyatoslav Ryhel (1):
  drm/tegra: gr2d/gr3d: Initialize address register map before HOST1X
    client is registered

 drivers/gpu/drm/tegra/gr2d.c | 19 +++++++++----------
 drivers/gpu/drm/tegra/gr3d.c | 19 +++++++++----------
 2 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.51.0

