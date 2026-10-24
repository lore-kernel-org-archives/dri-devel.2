Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D81606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=I3jt/+R8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B91810E2D1;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5FA10E072
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 16:54:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jBmF14ZRQzKmy7;
 Sat, 24 Oct 2026 18:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792860837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xJOdXAoONoUMO2eVbHGOOuuM5yFrNx3ef+Kio9IwuqY=;
 b=I3jt/+R835HPi269yYQlQYE/skyg3vQcvIcpwW7WL/0CdXKaRTTMomC2xPMPJXgBbgE9kz
 3J8gqH1B1qDgTdLSR1J6lgG05p5GAMQgjl1EfWYDBhGAw/8uJCUiTSevqgl+8nL493a3KC
 tRZh0EvsOjHkrlx5+ydob3LqHnmxYcALxE4RHFYY4FhDCoydg3hZ34DF6JMft99Sy5uR8L
 M/Qd9PpHxwrN+25NSE+AzShT9aB6aALz9k4SJN97Y1K4AWXDrkqJ+ZussVL+ses866n8o3
 4zZJgeo8IUGXTsgNtT8gt1fh9ItBbSorn/34rg+eMyVX9VrpqEhXNi8g9aPp9Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, jfalempe@redhat.com,
 javierm@redhat.com
Subject: [PATCH v2 0/2] drm/client: Keep larger modes in connector->modes on
 fbdev hotplug
Date: Sat, 24 Oct 2026 17:53:53 +0100
Message-ID: <20261024165355.2782145-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBmF14ZRQzKmy7
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an ASUS ROG Flow X13 with a 3840x2400 eDP panel, booted with
video=eDP-1:1920x1200@60, an HDMI hotplug makes fbdev reprobe every
connector with its 1920x1200 framebuffer as the limit. connector->modes
loses the panel's 3840x2400 mode, and after suspend/resume amdgpu drives
the panel with the 1920x1200 timing. The image ends up squeezed into the
top-left corner. Details are in
https://gitlab.freedesktop.org/drm/amd/-/issues/5983

Patch 1 makes drm_client_modeset_probe() probe with the device's
limits and moves the framebuffer size check into the fbdev mode
pickers. Patch 2 adds KUnit tests for it

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

I sent an amdgpu fix for the same symptom separately. On eDP and LVDS
it makes amdgpu fall back to a mode of the native size, or to the
encoder's native mode if the list has none:
https://lore.kernel.org/r/20261024163347.2413649-1-hugo@hsal.es
This series fixes the shared mode list for every driver instead. Either
one alone fixes the reported bug, from my testing

On amd-staging-drm-next with only this series applied, with an HDMI
hotplug and suspend/resume (pm_test=platform) in a loop, 255 of 255
resumes kept the native timing. Without it, 28 of 29 came back with the
wrong timing, and the same loop on unpatched v7.2.8 got it wrong in 103
of 103. The drm KUnit tests pass, also under KASAN, which reports
nothing in the code this series touches

Ville, you said the approach should be fine. If this matches what you
had in mind, I'd appreciate an Acked-by or Reviewed-by

Changes in v2:
- Tests: free the picked modes through a KUnit cleanup action, so a
  failed assert no longer leaks them, and assert only after dropping
  mode_config.mutex. Both came from Sashiko's review of v1
- Tests: add a firmware config test for a tiled connector with missing
  tiles, with and without a non-tiled mode that fits
- Check the size of the CRTC's current mode before
  drm_client_firmware_config() falls back to it. Without the 640x480
  modes, a DisplayPort sink with no mode that fits could reach that
  fallback with a mode larger than the framebuffer. Sashiko found this
  on a local run over v2, and a new test covers it
- Don't use the firmware config when a lit connector ends up with no
  mode. Accepting it would also skip the fallback, which may light up
  other connectors on that CRTC. Sashiko found this on a later local run
- Sashiko also found a NULL modes[i]->name print in
  drm_client_firmware_config(). It predates this series, so the fix
  went out on its own:
  https://lore.kernel.org/r/20261022114356.669988-1-hugo@hsal.es
- Rebased onto drm-misc-next at cf5d8e390e2a
- v1: https://lore.kernel.org/r/20261015212545.1989962-1-hugo@hsal.es

Hugo Sales (2):
  drm/client: Probe connectors with the device's mode size limits
  drm/tests: Add KUnit tests for the client mode size limits

 drivers/gpu/drm/drm_client_modeset.c          |  72 ++-
 .../gpu/drm/tests/drm_client_modeset_test.c   | 498 +++++++++++++++++-
 2 files changed, 550 insertions(+), 20 deletions(-)


base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
-- 
2.55.0

