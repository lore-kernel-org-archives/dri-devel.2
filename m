Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A7CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF87F10ED2D;
	Thu, 11 Jun 2026 07:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CNLmau97";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3008310ED30;
 Thu, 11 Jun 2026 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OW1rughmaPoVXzZo44yIw3sm9DaFihfWaLOUCkIpbRM=; b=CNLmau9781otmvERAXLH/LGwzg
 uf15iwYHxE/T0EG/ITwEGu3+dbIXp6Bk8FnMKxMCiJNio3n6LybhBpfbIQYQ1onHcy3AFzRQxYVUn
 i+7SDvql+nB8nteKWTmnYLeF83etc9JjKvFGzpqHKsbGyaoEvqQMUtV9435Dup6AEEDu2h5/lKJ0R
 mMT0CL2fRfbHzAIcQ6TpKUwGhzbxj6aSzgZiP6CVABENN4gzFgzee6WYCgSTcZW6JCdWk7AUT9p5y
 DtheyFH9U61c0CjFsNGUyW7YYIV83kLI9NSZg85us2dZr23natCMk3lddP6FW7e+3dbd7waz+wZlP
 jlVQ5HDg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXZtS-00G0cQ-VT; Thu, 11 Jun 2026 09:32:03 +0200
Date: Thu, 11 Jun 2026 08:32:01 +0100
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
Message-ID: <aipkcUDnTlzre-8F@linux>
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

Two fixes this week - one to avoid bogus DP link rates caused by parsing
un-iniitialized stack values if DPCD read failed, and the second one to
fix a potential out of bound memory reads on Pentium 4 era machines cursor
plane access via pread/pwrite.

Tvrtko

drm-intel-fixes-2026-06-11:
- Check supported link rates DPCD read [edp] (Nikita Zhandarovich)
- Fix phys BO pread/pwrite with offset [gem] (Joonas Lahtinen)
The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-06-11

for you to fetch changes up to d21ad938398bca695a511307de38a65889e3b354:

  drm/i915/gem: Fix phys BO pread/pwrite with offset (2026-06-10 09:23:22 +0100)

----------------------------------------------------------------
- Check supported link rates DPCD read [edp] (Nikita Zhandarovich)
- Fix phys BO pread/pwrite with offset [gem] (Joonas Lahtinen)

----------------------------------------------------------------
Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Nikita Zhandarovich (1):
      drm/i915/edp: Check supported link rates DPCD read

 drivers/gpu/drm/i915/display/intel_dp.c  | 11 +++++++++--
 drivers/gpu/drm/i915/gem/i915_gem_phys.c | 19 +++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)
