Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1CEC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85ADC10E42B;
	Sat,  8 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hr3yNQWY";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E1F10E43B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:24:33 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so447100a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786199073; x=1786803873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BxpSzB8c18EmT5JtuB1eU+b+G1XkrOHh1hT/Xfy0Dn0=;
 b=Hr3yNQWYLGRieDSmE0rEtuesfPiTRBgXVw6X2OOQAJ0a71EEcZYRj6J4VOq0jJQNor
 gt4BTpsaK7w6Ff2l57o3sq/dmKLwLPbHfZ/bYFCk1Hz3CFPzz0fSen9Pm6VTh/lHCGVu
 3vmaOsmKVIitnToOyuc7NK0TpeBAWGyGgQb+z/ocXYHrwXMWu5Yjtl8HT/kqIVLVE70V
 z1u1jgW1+BRQazj/44fhtfqppYh5oQ901S/r4NY6bilUtGFfYoNGigWqUojuXzuFcCl8
 B7pfv8ursAy88JSeppp41ipnF7CGKS8gms4tXu5Vp0xJJWqYgDpRPlAXfT54D0ylqPMc
 69ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786199073; x=1786803873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BxpSzB8c18EmT5JtuB1eU+b+G1XkrOHh1hT/Xfy0Dn0=;
 b=iajlJdKXAa1N0MjlD3qCSD6NP6GzWJO0V07DVcwptgwl94U3dUmmecQCtuE86ktAbX
 nJEXPm12vmzNfRp69nXp0W2QqrQepJ2dLh2Cu9T3QupyA2T9hXp7hJ1kaG5VEag/34s9
 mLASPOcisTH5j9FU5AcpN0yxOqXIUBEXomd68jvkgX/1o8XD6kTE0Jro/7vtJKL+ooHc
 xwyWylrzTMbfxeM0wERc8X1d5p/vEFMpzZ0ROX+tLqL4u+Otmhm3bEVDmDExIJ1TwfAz
 sIH9xfYcffki9Y6dqDhXL1xL5gvEm1lj3lyArKzcPjcwGO0MRBfxgHjE5eAKq7jnvFbO
 yI4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI1YGYPbb4X7voRZl/9TwWzYSvRRwtriuTPeaRJM4b6otNKH2D7xZRUVDbc+v270sti8yj9yZE2L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoeIlUdEMhjan+kkXvvR7Mojyzp7NXQE5PHSqOUT262sW/bT0c
 eZY57FJvkWTn8/gmjNI5e1E3zllwFEkvWKEvEck7t2AIbIOIIt+p/ZQF
X-Gm-Gg: AR+sD11pGmMVvAKdaqfcjGU0oZ3iS66yD5b03dqrcOivAKXFQyXtKm4mQNXGwHMBsAj
 uX3FFrxadZfhlIcz4s/OpZ9yELFss1GaPd5TBIbXgyaakk4zwK0K15D+3LxU7LXhEl/CgvY3EQp
 77jCoWVdT1THJX1r/TBfoaeyScxLWJmHTom0lM6Toaa3w43eTYX5tG3DCW6EqiEpcZwwigDSmtG
 uZD36oY/RiX+mr4A9+Cz4FMTzUFI3urcalu3WLeB0caavKpnocG2WT8CDHnCOO/aaSkWLP2UpE6
 NhNzTyMLryPKXefg2HdORwxtc8G5HnYg6je2Pa4i2bmmT8v1wo6QVWIClZTI04xdp3bxXwiC2Sc
 pjY86s8gO6wkmUY5DFiWsUJGVeYPY2yg3VQEpe2n8NcZYq13MpVg6UKh9DYVdFG3T0tPDHxKDqp
 z2DH4rCCSHCmxPeQ+WqkHL6HoHK0NI7ZyyH5VpINyxxzg=
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr30385694a91.11.1786199072815; 
 Sat, 08 Aug 2026 07:24:32 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2b2easm8638206a91.11.2026.08.08.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:24:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:22:16 +0800
Message-ID: <20260808142217.2893936-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

gr3d_probe() calls pm_runtime_use_autosuspend(), but gr3d_remove()
does not call the matching pm_runtime_dont_use_autosuspend() during
teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 1ec6ced959e4..5fd1fd32fcc0 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -534,6 +534,7 @@ static void gr3d_remove(struct platform_device *pdev)
 {
 	struct gr3d *gr3d = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr3d->client.base);
 }
-- 
2.43.0

