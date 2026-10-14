Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0FCC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF01112188;
	Thu, 15 Oct 2026 07:57:14 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAA310FFB7;
 Wed, 14 Oct 2026 22:30:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j4mBC733xzKnTY;
 Thu, 15 Oct 2026 00:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792017044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1RlDgYjFOQMR+TOkPxgHO3ckyHzXoCdjohVK5jRak98=;
 b=VtoCQqnxXtvacsLZSaS8hFqFyUK6vLQKHU2xkQjx1gPeb7yLzUWKGAfqqLcwjna/4oyZJb
 qoPfhx/PUygOFzi1NNSPTyuc7U6yantBZpGKTveNgDl9mWnfva8ft/y/kT90xO55iB7But
 9CF+CXlQ4E2Nxm57xfG7pFyUjaDYytmNAmmyxwcNKi/clA+8l7gW6keTvqmCceOBvVSEPj
 xULYiRTFytYp4j53AudL9fZ14X2ikb9hKKh5eJbZ6uZBbtxpFYhm4XEiYOHMizpK79pbau
 vZBZSAhdwRjHMEdetuVMsCcqHyr6pI7H5qC6jG/ip67M+27XdbYeBH5wWy6aqg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 0/2] drm/amd/display: Keep eDP native timing after resume with
 video=
Date: Wed, 14 Oct 2026 23:30:39 +0100
Message-ID: <20261014223041.171317-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j4mBC733xzKnTY
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On a 3840x2400 eDP panel booted with video=eDP-1:1920x1200@60, an HDMI
hotplug followed by suspend/resume brings the panel back with the
1920x1200 mode as its raw timing. The image ends up squeezed into the
top-left corner. Photos, hardware details and the test loop are in
https://gitlab.freedesktop.org/drm/amd/-/issues/5983

The hotplug makes fbdev emulation reprobe every connector with its
framebuffer size as the limit, so connector->modes loses the 3840x2400
mode. On resume, create_stream_for_sink() finds no preferred mode in the
list and scales onto the first mode instead. Patch 1 falls back to the
encoder's native_mode, which amdgpu_dm_get_native_mode() copies from the
preferred mode before the size limits apply. Patch 2 adds KUnit tests
for it

The fallback only applies to eDP and LVDS, where amdgpu turns scaling on
by itself. On other connectors the preferred mode can also be missing
because mode_valid rejected it, and then scaling onto the first valid
mode is right. Those connectors still hit this bug when userspace sets
the scaling mode property, which this series doesn't fix

A fuller amdgpu fix would always take the eDP and LVDS native timing
from the encoder, and search connector->modes only when the encoder has
none. I kept this to a fallback so it changes less, but I can respin it
that way if you'd prefer

On amd-staging-drm-next, with an HDMI hotplug and suspend/resume
(pm_test=platform) in a loop, 28 of 29 resumes came back with the wrong
timing without the patch, and the other showed it briefly. With it, 169
of 169 were fine. A backport to 7.2.8 went from 103 of 103 bad to 1363
of 1363 good. The new KUnit tests fail without the fix, and the
connector suite passes, apart from dm_test_fs_caps_hdmi_vsdb and
dm_test_fs_caps_pcon_whitelist, which already fail on this tree

The cause could also be fixed in DRM core, for every connector, by
making drm_client_modeset_probe() probe with the device's limits and
apply the framebuffer size only when fbdev picks its own mode. That
touches more shared code, since fbdev's other mode pickers would then
need size checks too

Hugo Sales (2):
  drm/amd/display: Fall back to the native mode, not the first, on
    eDP/LVDS
  drm/amd/display: Add KUnit tests for the eDP/LVDS native mode fallback

 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  28 +++++
 .../tests/amdgpu_dm_connector_test.c          | 112 ++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.55.0

