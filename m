Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D5CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD3710E2D4;
	Wed, 30 Sep 2026 22:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FfQ2vSEW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F03710F533;
 Wed, 30 Sep 2026 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=dGITI3UKm1UsTqozCD6UHgqpVbOmz2+56VYRT69rTQk=; b=FfQ2vSEWcCDVQ3GjX6gqKtqWzl
 e49+9g5lw5QwUr0USvWMb04f50SRqPrqbZs7r2KyyslEy2LdDRDThmHN1IK/7T8R5ont9zsmX3M3U
 pGX4ETCfo6aWDbSTYk7YRQPwM2+6Q6uLk4Vg94mlRD2g9VNZQ0hiDIE68Q2bDBFcSx4eAT39vqVAY
 J7D5gS91SBcGbT60jRAWeAnN87dyd/wS4lQ0QMKCDn9WjfULkexJxUcbkUUpdVB+jtL60Z0Ogz6Kr
 xFO6vGVpXsJJHOvW6mlkZHG44KkQqYHpDALSFPzlITkIpQ5NQqNPR7B7yeneLK5pzHrC4qcjvXSep
 pXEUxuOw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xC3B2-009eAA-61; Thu, 01 Oct 2026 00:53:28 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 0/7] drm: Consolidate the wait timeout conversion
 helpers
Date: Wed, 30 Sep 2026 19:51:58 -0300
Message-ID: <179080871440.2011110.3586029540448216497.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 15 Sep 2026 16:42:15 -0300, Maíra Canal wrote:
> DRM wait ioctls express their timeout in one of two ways: as an absolute
> deadline in ns, or as a duration in ns. The core has a helper for the first
> form, drm_timeout_abs_to_jiffies(), which panfrost, lima, tegra, xe and
> some accel drivers use. However, there is no equivalent for the second
> form, so the drivers that take a duration convert it themselves.
> 
> For example, i915 has a local helper to handle the relative timeout case,
> and v3d carries a copy of it. This series moves that conversion into a DRM
> helper called drm_timeout_rel_to_jiffies(), next to the absolute variant,
> and converts the drivers that were open-coding either form.
> 
> [...]

Applied to drm-misc-next with Jani's suggestions applied to the first
two commit messages. Thanks for all the reviews!

[1/7] drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      commit: ae72b9c39d280e02b1c9e6c91f1f7dd23b550a85
[2/7] drm: Add drm_timeout_rel_to_jiffies()
      commit: 421cf7ccfc61cb990f38d671ddfe3a901519e21d
[3/7] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      commit: 5ce81ba29a4cfbce8be5cc2999292f2fc3962031
[4/7] drm/v3d: Use drm_timeout_rel_to_jiffies()
      commit: 226666556a9b3b51f04f9dad83662e5b9c78a325
[5/7] drm/i915: Use drm_timeout_rel_to_jiffies()
      commit: a92c785f810ea330e6ae4c79b5aa0eb031ee7d65
[6/7] drm/vc4: Use drm_timeout_rel_to_jiffies()
      commit: 88b7a9fb64afd206b3aad92a96425d2b562774d4
[7/7] drm: Rename drm_utils.h to drm_panel_quirks.h
      commit: 1628e34ee666fbd8bf974c52613cf7c8f957986a

Best regards,
- Maíra
