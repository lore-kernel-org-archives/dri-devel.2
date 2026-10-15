Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF0ACCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD26112652;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4FF10E1B0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:25:50 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j5Lhr2XXszMlbP;
 Thu, 15 Oct 2026 23:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792099548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sNpQ/0RGdhDR+Y4DarK50jJ9ktHHzva5t2FzmBPC36I=;
 b=oR/US0z+NTT8xmzpnTARDlaxdmg9TeswCohsboHgYyDrZbyFPkrNI9caKdNRBGUtHjGPeN
 MShi6BJpp6z2JoGRK3ZWpsn0neuUB/gQWV0eL/nIUMan5lQB58IavEbRRpmW91Pwgn4YvN
 Y2/iwHdW+CI73iLuPkjd+Io13OCJRFgLC0ZGYOXOxR10j7B2ZuLIlLO6qgRKEQVdcrRg8O
 Mi3jjOxPLZbmcLDuokRK95ULe62CQBBWjliP1kPtrQxZ+2Ubeapjw/AjUk3PQv53Kl7ZmO
 8bhwDO07zOnUKfzQFhuoms9EBOW+FYYQI3vaxghRLJbrVkkoBhOjs01Hr6eapg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, jfalempe@redhat.com,
 javierm@redhat.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 0/2] drm/client: Keep larger modes in connector->modes on
 fbdev hotplug
Date: Thu, 15 Oct 2026 22:25:43 +0100
Message-ID: <20261015212545.1989962-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j5Lhr2XXszMlbP
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

On an ASUS ROG Flow X13 with a 3840x2400 eDP panel, booted with
video=eDP-1:1920x1200@60, an HDMI hotplug makes fbdev reprobe every
connector with its 1920x1200 framebuffer as the limit. connector->modes
loses the panel's 3840x2400 mode, and after suspend/resume amdgpu drives
the panel with the 1920x1200 timing. The image ends up squeezed into the
top-left corner. Details are in
https://gitlab.freedesktop.org/drm/amd/-/issues/5983

Patch 1 makes drm_client_modeset_probe() probe with the device's limits
and moves the framebuffer size check into the fbdev mode pickers.
Patch 2 adds KUnit tests for it

fbdev's hotplug probe has passed the framebuffer size since 2010
(4abe35204af8). The pickers didn't check mode sizes then, so leaving
larger modes out of the list was what kept fbdev from picking one. They
check the size themselves now, so the probe can use the device's limits
like initial setup, drm_log and GETCONNECTOR already do

The HiBMC thread "[RFC] drm/client: Relax clone mode selection in
drm_client_target_cloned" runs into the same pruning: its 640x480
framebuffer removes 1024x768 from both connectors' lists. With this
series userspace sees that mode again, but fbdev still can't use it, so
this doesn't replace that RFC:
https://lore.kernel.org/r/a48e0b33-7eab-478e-a396-b6e76b7a066f@huawei.com

I sent an amdgpu fix for the same symptom separately. It makes amdgpu
fall back to the encoder's native mode on eDP and LVDS:
https://lore.kernel.org/r/20261014223041.171317-1-hugo@hsal.es
This series fixes the shared mode list for every driver instead. Either
one alone fixes the reported bug, from my testing

On amd-staging-drm-next with only this series applied, with an HDMI
hotplug and suspend/resume (pm_test=platform) in a loop, 255 of 255
resumes kept the native timing. Without it, 28 of 29 came back with the
wrong timing, and the same loop on unpatched v7.2.8 got it wrong in 103
of 103. The drm KUnit tests pass, also under KASAN, which reports
nothing in the code this series touches

Hugo Sales (2):
  drm/client: Probe connectors with the device's mode size limits
  drm/tests: Add KUnit tests for the client mode size limits

 drivers/gpu/drm/drm_client_modeset.c          |  57 +++--
 .../gpu/drm/tests/drm_client_modeset_test.c   | 222 +++++++++++++++++-
 2 files changed, 260 insertions(+), 19 deletions(-)

-- 
2.55.0

