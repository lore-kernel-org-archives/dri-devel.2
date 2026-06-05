Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5A4CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF0E10E1A5;
	Fri,  5 Jun 2026 10:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qxP05mxb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF2710E116;
 Fri,  5 Jun 2026 10:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=25uilpvB8H/MrMiKprmEmW2Ha22sjKIqcfJce1S5JNQ=; b=qxP05mxbVyizPIeNqIhIn66mbc
 pV7/dAVApJo0QROyKUv+2Z6xLLr7DOAVEkdTftaUzna02JvRt6Z10cn7lBzhiTRJOirmeCsSZJkgc
 m6BL/icGFhC2MB+B+OrvqIr+c8sp7Qk2KPZYh4yt3Fl20Hh+KhcJ6Ly82YcljyJvccmhs/GdpqfQe
 dbQG9uR8FjHb0PdotRduUQ+R7Pvn5xLf5pVyoiQhYZrb0HTMRUq4v3hYcWN7VZ1x+4DYGFuHYbRJe
 zwfwKDX9BKHA1BKXzMHfDqxQxAaYvHr3SNv3P8ihLlvQyZKB2AQ+HySivksnkJs3W0Ik5SG3VvD1c
 g11ldcFw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVRVc-00D5qo-RM; Fri, 05 Jun 2026 12:10:37 +0200
Date: Fri, 5 Jun 2026 11:10:35 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-fixes
Message-ID: <aiKgmwz7VGOaFXIv@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


Hi Dave, Sima,

Last minute updated pull request due a relatively urgent revert for fixing
the backlight on some laptops. Plus the other fix you haven't pulled yet.

Tvrtko

drm-intel-fixes-2026-06-05:
- Fix color blob reference handling in intel_plane_state (Chaitanya Kumar Borah)
- Revert "drm/i915/backlight: Remove try_vesa_interface" [backlight] (Suraj Kandpal)
The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-06-05

for you to fetch changes up to 2914709c914101eb704e01bed2351070d4161ccf:

  Revert "drm/i915/backlight: Remove try_vesa_interface" (2026-06-05 11:07:24 +0100)

----------------------------------------------------------------
- Fix color blob reference handling in intel_plane_state (Chaitanya Kumar Borah)
- Revert "drm/i915/backlight: Remove try_vesa_interface" [backlight] (Suraj Kandpal)

----------------------------------------------------------------
Chaitanya Kumar Borah (1):
      drm/i915: Fix color blob reference handling in intel_plane_state

Suraj Kandpal (1):
      Revert "drm/i915/backlight: Remove try_vesa_interface"

 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  | 19 +++++++++------
 drivers/gpu/drm/i915/display/intel_plane.c         | 27 ++++++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)
