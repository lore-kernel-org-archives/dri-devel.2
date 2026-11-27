Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=WftZKFXD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F84C10E04A;
	Fri, 27 Nov 2026 16:38:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F299710E04A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:38:43 +0000 (UTC)
Received: from abreu.molgen.mpg.de (g44.guest.molgen.mpg.de [141.14.220.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F2354C442F953;
 Fri, 27 Nov 2026 17:37:57 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] drm/i915/backlight: Use panel backlight quirks for the
 minimum brightness
Date: Fri, 27 Nov 2026 17:37:44 +0100
Message-ID: <20261127163752.54806-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1795797477; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=OzFwtFXDqG7sN4cGMD6lZutROPW+5n4wZk735plbaxA=; 
 b=WftZKFXD0kHqHxZPELCVH2Vtb/XRc3RuuXN9mn373FsdGRQ/srrl1tN9DwQVSQbVIX8Xl1czD43M
 qPovZHQsDOpEJbz3o8FMqYrQe4zqx5L5UXk6Fb8p/LxyiKmc/NJeZ5GcY/XOXE7c4VFTQWGh1G+kiP
 TgolFRWLdWvKTQDb0nb2S6+JqCy/9dux4oTvHzqK9fSBSTEgyPeJc22rRWLa7JUf1UTgUhBUYGdjeT
 2JrCEVe1srl3TqZQOzhcmGVbQ7Gy0wEhtsltH13mReZ5a0o6znRUMTtZpNar4egi/Ub8KzbCyP3OKG
 dWYdo3wdJgQuN2kUB/U7pszc1L4ewCaw==
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Linux folks,


On the Dell XPS 13 9310 and the Dell XPS 9315, the VBT entry of the
Sharp panel in use sets the backlight minimum to 15/255 (the other 15
entries say 6/255). With GNOME at its lowest brightness (1 % of
max_brightness), the PWM duty cycle is therefore 6.8 %, which is too
bright for the lowest level.

amdgpu already takes such corrections from the DRM panel backlight quirk
table. Patch 1 makes i915 (and so xe) consult it in
get_backlight_min_vbt(), patches 2 and 3 add the two systems, matched by
DMI and panel ID. With the series, the lowest GNOME position gives 1 %.

The series is based on v7.4-rc4 and applies cleanly to drm-tip
(2026-11-27). Patches 2 and 3 only touch the shared quirk table; for
Intel systems they take effect with patch 1.

Even 1 % is brighter than wanted on the XPS 9315 (0.25 % was judged
best by eye), but going lower is up to the desktop: GNOME/mutter never
sets less than 1 % of max_brightness.

The patches and messages were prepared with Claude Code
(claude-opus-5-5) and tested on both laptops; I reviewed them. Test
details are in the notes below the --- of each patch.


Kind regards,

Paul


Paul Menzel (3):
  drm/i915/backlight: Honor panel backlight quirk for minimum brightness
  drm: panel-backlight-quirks: Add Dell XPS 13 9310 FHD+ panel
  drm: panel-backlight-quirks: Add Dell XPS 9315 FHD+ panel

 drivers/gpu/drm/drm_panel_backlight_quirks.c   | 18 ++++++++++++++++++
 drivers/gpu/drm/i915/Kconfig                   |  1 +
 drivers/gpu/drm/i915/display/intel_backlight.c | 15 +++++++++++++++
 drivers/gpu/drm/xe/Kconfig                     |  1 +
 4 files changed, 35 insertions(+)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.54.0

