Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DA3CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E491126C7;
	Thu,  4 Jun 2026 06:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Fz0mouyt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16851126C3;
 Thu,  4 Jun 2026 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0tcASkMbUIXYkGyMlu3SgiYmN7bjj/ZO8CYpeqqNx0A=; b=Fz0mouytvpFyyuG85c1P8FPrty
 vUfCDym9bqXB6lb5CHVjJ4sY8A8Bv65UzbLgcE+P1n3wGLCKPvJX6COIxVtuZLyDAzBGF2NNoKUen
 8XAMnSJuw20iP95EydOAAOKJtPzMVpsktDv1T+ruwP+l1LGxfAc726T5I+JGpYQljURho5yZABXea
 f4F/aDyqbNGttBZarfhTYbme3cHTrfplqCw3fdP1wil8ylceAjvUtwM1t+ENMt92ncsCgSgp9aP1+
 bN1Qac4iY/CXe5KzHSaVlvW9E2UprPD95ckIvm26Kc5gOuSUI0ade2f7KY6URHePjGKdKEqCIwfqQ
 yVXG3m5Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wV1dI-00CW8D-GN; Thu, 04 Jun 2026 08:32:48 +0200
Date: Thu, 4 Jun 2026 07:32:47 +0100
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
Message-ID: <aiEcDyH-CvW9ic0Z@linux>
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

Only one fix for this rc week, adding missing plane state color blob
reference handling.

Tvrtko

drm-intel-fixes-2026-06-04:
- Fix color blob reference handling in intel_plane_state (Chaitanya Kumar Borah)
The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-06-04

for you to fetch changes up to 26eb7c0a7ab09d83eec833db6a5a2bc60b9d4d9a:

  drm/i915: Fix color blob reference handling in intel_plane_state (2026-06-03 09:18:15 +0100)

----------------------------------------------------------------
- Fix color blob reference handling in intel_plane_state (Chaitanya Kumar Borah)

----------------------------------------------------------------
Chaitanya Kumar Borah (1):
      drm/i915: Fix color blob reference handling in intel_plane_state

 drivers/gpu/drm/i915/display/intel_plane.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
