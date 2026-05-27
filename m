Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826FCCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 08:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91BC10E1AD;
	Wed, 27 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rWPg3IQB";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246910E1AD
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 08:58:01 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-83538fbd0b2so4677775b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779872281; x=1780477081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pipUftR0EEqahSAIWXG9QxR/sTyw2bQdCF35/iM0edM=;
 b=rWPg3IQBgVaZo+ikoRnx8iESGDPNqbdN6XncBeMcGhOrY66Xro93azwsXrf9g1nRPU
 NtL0VYZiMEsSsVG0V/5f3bRIy3EgfDZy7qEO18P8y6i/biYFi7c1+akFP9BGM8JJcHRA
 j2o6T/C1Oc/64p/aA369/72CkU1pnjjSxC+bosMkdINrkdalwfTh6SUrcTC42Rm7a8Bu
 YKyvUn+P/REdEfZRQdZfsAM3rs/VO6JtI6aNkoX6NnGFwhx3OQarBOJW3Zk2KABJXHXY
 pyf/0sJEEx7GA8lj0txNGQrqfDjvj9Wy6OXJItVx7RjfI2LvBG+8bLP5Xa7WB8RrF1ba
 9NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779872281; x=1780477081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pipUftR0EEqahSAIWXG9QxR/sTyw2bQdCF35/iM0edM=;
 b=lwKEWhlirdqrHEWzem3V7X8SXADQ0T2eTtpHzVUoyVgI55O5oMkjnA79xxwQ/r5r7g
 X3vHt+FozqWs/5adAF995Fy4K2GhBlSGTlMK7lnF7nVkpQh5Rkg1quAAnL2tjQ+Al6h3
 jG1cg1JHksKkWEj4ufukyYZxznoFdsdkAmt3sDzWOwLzJUt4VLw7sjYfUIADirWO+FBm
 eWzovtgz++RJzJKXiLEJtxFdrpxdYCqJoEWEG2pxkmjdO779WtGKBMHzU1ypFINivq5g
 OEmOEKxe42KpaxdrBCPMWnmB5o39qF6AhFLbMo7rFZL4k+RpRSoie8lgfO+MsSKbBmMZ
 Eg9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y5ClFu3E9FEg0P0SaK+RGDFpjmYBjpMR6N/k3lYc0005SNCcLTbG7uH2AI7yfjgyiZ5WP6hIQ1mk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyL4PVPvF/Wm6JcaffWwXwO2WzL6nxPxgkH/nKtWXSetL8iW7a
 pjIpjJeb30Ji2reaSYAlHlGeJEs/FJTPAK1ulF+P4q9hN7TqYL2TXBTg
X-Gm-Gg: Acq92OEjrYJjZ2DixOXFulrpFIScoKS+fp1FtdCd/ubPt+ogG0QhQI666iCIvsQSqNN
 R/EeR9y4OANxEXJkSirsSbCIeS7CE3M5GtvBptJznAN3qxsx4xlBZq8q3+LA05PwjxPWytt+ukK
 H4ngnGdKz43oCQqJNpSPeeceSrYyYiUquYNiuG6bbmjqsFPXQkyIsCGIECRYU1p2nGJ3nwmH2mT
 gwDVw5KZX1TBF7fiiPlnm9n6+seQOjv0TGNwtVydN+X0wqbVFRtcniyhU7xI8Sg6rMtp797czo0
 mApQBQlHy52TsNLIC9SowJGm4PNZ3pxeyIOzjN4Uap2FtA2VUtiBwMjODxlSHReJj9MKIkAxpV5
 O6Qx9cndpLcVNVnyMDVZox6uPZeX03O/JYaOouJjqontkcDOXvD/OOqMBno9hvbls3pkrl7C0iW
 daj2g73dT9fDqeeNfpFNteq6aZjdkCUXL35bQ2z84N7kGlSgrU
X-Received: by 2002:a05:6a00:2d1b:b0:835:3730:571e with SMTP id
 d2e1a72fcca58-8415f3a944amr20380235b3a.5.1779872281286; 
 Wed, 27 May 2026 01:58:01 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d70b855csm1651909b3a.38.2026.05.27.01.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 01:58:00 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v4 0/2] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Date: Wed, 27 May 2026 14:27:34 +0530
Message-Id: <20260527085736.920390-1-tessolveupstream@gmail.com>
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

Hi all,
 
This patch refines dual-link LVDS support in the SN65DSI83/84
DSI-to-LVDS bridge driver.
 
Recent upstream changes added support for dual-link LVDS timing
adjustments and related fixes:
 - Halving horizontal timing parameters
 - Test pattern handling adjustments
 - DSI clock range correction
 
However, during validation on our platform, LVDS output remained
unstable for certain panels due to the DSI mode configuration.
 
Specifically, the following flags were found to cause issues:
 
 - MIPI_DSI_MODE_VIDEO_NO_HFP
 - MIPI_DSI_MODE_VIDEO_NO_HBP
 
These disable transmission of horizontal front porch (HFP) and
back porch (HBP) timings over the DSI link. The SN65DSI bridge
relies on complete horizontal timing information to reconstruct
LVDS timings, and omitting these parameters results in incorrect
or unstable output.

Reference:
SN65DSI84 Datasheet, Section 7.4.7 (page 20):
https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84

Additionally:
 
 - MIPI_DSI_MODE_VIDEO_BURST
 
While supported by the hardware, burst mode operation depends on
continuous clocking from the DSI host. In practice, this may lead
to instability depending on the host controller implementation,
as the link may transition to LP mode between bursts.
 
Removing these flags ensures that:
 - Full timing information is transmitted
 - The bridge can correctly reconstruct LVDS timings
 - Output remains stable across tested panels
 
This patch updates the DSI mode configuration accordingly.

Changes in v4:
 - Split the original patch into two separate patches:
   - Enable HFP/HBP transmission by removing
     MIPI_DSI_MODE_VIDEO_NO_HFP and
     MIPI_DSI_MODE_VIDEO_NO_HBP
   - Disable MIPI_DSI_MODE_VIDEO_BURST separately
 - Updated commit messages

Changes in v3:
 - Rebased on top of latest upstream changes
 - Dropped previously proposed dual-link DT property and related handling
   as equivalent functionality is now available upstream
 - Refined DSI mode flag configuration to ensure stable LVDS output
 - Added detailed justification for removing NO_HFP/NO_HBP and BURST mode
 
Changes in v2:
 - Introduced ti,dual-link-video-mode DT property
 - Added DT binding documentation for the new property
 - Update driver to read the DT property and apply dual-link
   configuration conditionally
 - Adjust DSI mode flags when dual-link video mode is enabled
 - Update commit messages 

Thanks,
Anusha

Sudarshan Shetty (2):
  drm: bridge: ti-sn65dsi83: Remove NO_HFP and NO_HBP mode flags for
    LVDS stability
  drm: bridge: ti-sn65dsi83: Disable video burst mode for LVDS stability

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.34.1

