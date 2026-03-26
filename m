Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26DC10AB82F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456D410EB00;
	Thu, 26 Mar 2026 23:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6VZuTEp";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065CC10EB0D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:35 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so670364a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568855; x=1775173655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5DHuKVgXN+dD1YajVE7A08pLyTvO/MeTPUKN+QQ6x/Q=;
 b=W6VZuTEpSrxhdt7KwZqwD/oVRCZ75R/LXlvUDk4MDZv/jcxTo5xyL3Z++eT16kNOJ7
 it+UzOUUFqy2WIrfwTg0aNQkdjvZdLsJuuv+VQLg/WJO/kV7ZNk+piLUL3UOn/rfYNx4
 xtKANC5n7uZIabTUEIxmyXurjT4iKJKiZbA3ip80ze/pO1R/Yt6dpH8hrism8RmyDMwe
 Q+Lw1XdA6CfkMO0NYrtj4nqMiTBskfflXAERC2+GH8spnBVJWU6NTVYPyVBZMY/dihbX
 P5tmxAdDOMydwI8shmbW3P7XvXHeDR5VfRB5vacDK4npzVe8AkvlSAS2ZerI5Ovsczou
 g71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568855; x=1775173655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DHuKVgXN+dD1YajVE7A08pLyTvO/MeTPUKN+QQ6x/Q=;
 b=EEWaTnOVqNzZxwH7aiSa4rWFfAryn4bJVMXJFrd+L1uScpIDAu6CeZmwyN4YWNIz5R
 anhTLsIWDFOpvkyy77jR21gIPpDf0rBFkpZoNLu713cfvm8Zay3azDhOJrtJOcKmppjW
 /z7+QsuDJKuOp4u39BWwzAJlnzxRDGjJGS1sd0DMWVGHY22MnFe2rSimNz+Adjj1DR6P
 CTHQtynIa/SMXO7f/Oe5JdKU1XdefnLIyh5g8aFPCkGAFVGY3J2hfNNJpbcC3u3QOcDC
 aTN3aJtyGnz3vIVKk//qp/43f78vaA7F+xSq15teEL1LIGBCxvsh0ZY5igLr7zIMR5Xi
 lRPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+Wqn9I6viaqp8cJsWNjloEbyELOxW8j7+2WzqbI4/pweNJM1hyrCpIdOXX6AnU1zj20VWO0gK74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznLCOIEwmfC8XjR88BXoIKYM2a0ezEyEDEBmgbrzQmQEmJNWoD
 mkUK9zr14CD17AwkTgEci9SnlM7OlVuYxluAHCH1c1b5gTsRr0WyR+wV
X-Gm-Gg: ATEYQzz3lKJSjML+FvDmyD6xxrH5PK3YLi+yV8aKj4nXt40mAB7R9OjBuk6MPtctDs1
 s9eZCsHEWXR2Tv8PS6177i0WXd0icsP5J+mX0fnnmvJ9SrSiWPdeArD3dgywbFcVlUW4H8GCklU
 VOsrvYMR0qe3XwQ13Orgvvf5vTnZKbVAJxhJ7z9zLlgr9GGnM7sdR3vyCbQw0zV/XdnsEEBDFOo
 J3USFmkPyNS3rkKQPYXL7FO+gNLOJwddD/LCIUU1A0GeP2iTLw0PZRaVHVQETPGkkoarDE7d9Zz
 em0w0XuZz/h5bdSPyIBFjdzOAUjjxCNfCU6bYm0Nphzva7ZyMxkJtmH3MeTd0WL6yVBLRmjEM1F
 15p6Qi05VYMiVxn2rcfI5WalPt0G7QjvVW9KSwkD0horLf1XobCK7vTc7i2vt5BZGZzzvVfJhAc
 8Shg268W17BSsOo3jC8sHDZLIhlxVpwFLhhdh/SV+3cYIy4oabEov1IBwiIx4xu0+IJg==
X-Received: by 2002:a05:6a20:60d3:b0:39c:14c1:43f6 with SMTP id
 adf61e73a8af0-39c87c0b0b5mr394562637.61.1774568855408; 
 Thu, 26 Mar 2026 16:47:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 0/9] drm: amdgpu: backport suspend fixes for
Date: Thu, 26 Mar 2026 16:47:07 -0700
Message-ID: <20260326234716.16723-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Work that completed in kernel 6.18 resulted in working suspend with DC
on old hardware. This series aims to backport it to 6.12 to have working
suspend there as well.

All commits were applied with git cherry-pick, the only changes being
adding upstream commit, and signing off.

Tested on AMD HD7750 with:
radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
on Arch Linux.

Kenneth Feng (2):
  drm/amd/amdgpu: decouple ASPM with pcie dpm
  drm/amd/amdgpu: disable ASPM in some situations

Timur Kristóf (7):
  drm/amd/display: Disable fastboot on DCE 6 too
  drm/amd/display: Reject modes with too high pixel clock on DCE6-10
  drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
  drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
  drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
  drm/amd/display: Disable scaling on DCE6 for now
  drm/amd: Disable ASPM on SI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 +++++++++++-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 20 ++++---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 59 +++++++++++++------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../dc/resource/dce100/dce100_resource.c      | 10 +++-
 .../dc/resource/dce80/dce80_resource.c        | 10 +++-
 7 files changed, 117 insertions(+), 32 deletions(-)

--
2.53.0

