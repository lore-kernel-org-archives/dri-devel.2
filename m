Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE4DF3ED6D
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 05:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3024E10E030;
	Sun, 12 Apr 2026 05:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fyWBBMvN";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396EA10E030
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 05:38:23 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so3318175a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775972303; x=1776577103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MG2Gz2rlIZHS17fq7+ilm3CRSvnhfoyXdI4FUStwfX8=;
 b=fyWBBMvNhNR8wSPrG6BhctKWOQIj9ptGBXg5wSUg4ar8hvSJW1+N4VqS0HaLP0Jvxr
 stqhT1ukUbI2XF0fXWfOUs+8fOwdfOGUCWW078uE6/g9MgGBHGq9+gEqAJfPF0TAOnPn
 oVrEME38J1ZxRI4r+UQHsf6SNiICwc/jxNNskcRpE9cTuDfH6DFioonVcSZSNa/FeDYi
 R98PJCtw/2RLrWY7uxcrKQ81pKT/knBp0tKk5+eESsbRvshBwAkr6ozp3yWzTtjGHPsG
 0LznxtaX/tEfR831JItMK+Pj5csl/FjDS/0dGEiU1K95AFogUFPrgW1znegLTOGvLQBF
 U22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775972303; x=1776577103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG2Gz2rlIZHS17fq7+ilm3CRSvnhfoyXdI4FUStwfX8=;
 b=pbzGYTp4cx10erzntiq8Koh0pBsvbGhmPyhj8lBwfny2JEcQr3y6ii/taUoQ7eqgbq
 3DLOnZmqrhcP32EOXvKO7+5R2QUyYGFVu4FaeiR2yYPhDB60Xs5tZN5SN3ufC50H9ji3
 9tgRFlnK2yLeO5mklPk35LHbLQM9Ac180dz9BTWahhvts1aNj3d/TkKA8G5Mx0mri0Ap
 yXkHopaswgWwEDISni+oyqT47GmI8I1d9+48LBaBZwvSSELKSuHSWrXx/DWg6PHEJANM
 fn3I+cBNrRze9LiF3H3Pk7he80JZ+2iybQwwh4eUzp3aDWyRsvpz9wyc8gFQ1OEIViRv
 BjNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Curtmu8JZEUkyMcWxvLzkzEbdcKlJCEDt1JoUWmgXEgMAe2DdvNova9bmcAr8WKf6mZvgeAbxfGM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi9vPVCe7MIJyM7bfcI0/r/nQd1nuWrQ5FqFuPg38jPZqzSPn9
 rTyNP9/0WpC35/Xf8lwQGK6wt+5uDW+EjG11NwKWP0X60AuFHoQC+mvv
X-Gm-Gg: AeBDieuoX+OOJGQoNm8lnGpCxrdRCZ2gV75W1+XMJ+zD9yn0OihFNuK9BLjGKfCOGGQ
 EqvK2XogtawkRa8kSsBIwSxjFdYeThHmASAP9JbL7qZxvcgBKmYjJFBG/I4M9I6AKiFy869NFsT
 QUM3LP2UM377Jyywso0IFtAJ9j0kr3YCjn8mIYwBZ1lvT+oXqeaWOFZPUKn42p1GtFAtLyPYreJ
 nygLb6/1kmPTLtKVB6ylkMuWN9FL7MG8w5MeaSnUQ6GmuYF5Sew7wLPl0GX/U3i0StahOgB2wPf
 NXoWGP9tmRh6v6EpTKLmCwkWTPfGXTNIfkXhCRno4gogSlAcyG5hSUvoV/lHuViuIrOhZ6gA7bI
 LXjjK5267Q9Kx01/rIMrhXNKPjNXWNYvpe+xqD6GERXTSzeFi6hWQ+nNZGiyKWyyraP9ezewJlK
 KLZrvA9DiRLVLyVw6Xlhp0wISM8mPzBNMsGFHExAskp5QRo9yv
X-Received: by 2002:a17:90b:3b46:b0:35b:8d89:7199 with SMTP id
 98e67ed59e1d1-35e42853381mr9447175a91.15.1775972302597; 
 Sat, 11 Apr 2026 22:38:22 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e41e1196asm2740502a91.1.2026.04.11.22.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 22:38:21 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, marex@denx.de, valentin@compulab.co.il,
 luca.ceresoli@bootlin.com, philippe.schenker@toradex.com,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v3 0/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Date: Sun, 12 Apr 2026 11:08:10 +0530
Message-Id: <20260412053811.662461-1-tessolveupstream@gmail.com>
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
 
This patch is based on recent SN65DSI83 dual-link LVDS fixes:
 - https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/ 

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

Sudarshan Shetty (1):
  drm: bridge: ti-sn65dsi83: Fix DSI mode flags for stable LVDS output

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.34.1

