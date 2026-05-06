Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF88CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7747110EDC4;
	Wed,  6 May 2026 14:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dRt/1vyQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0DE10EDC4;
 Wed,  6 May 2026 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m/95BYx0xQ2aSKleJD1zlHmCbav1VIA/uBvDHAKdoaU=; b=dRt/1vyQWy6rHR/o8ODlnbHhlg
 gVZ2qtcF6ykaolAatlA0rSPvWJONJp4OUAGS8F+fawlZN51Z6HSbCpceC2/1CoIsG3zW+HZQvhlu5
 ueqLf2c/iLOpdyPX3creFTif8ZSy4AeUW8wNcWcsD3TfCStla5k9so4eJM394U3kQ+TmrOG+rN/E1
 NnNkEFfEAyodDztt3pTVem1eSWD0X+YYGRzQh9WWMykKYjmyLbNUDXcupz9MeqGTvSMHEt7ksRsj0
 Qsi/wCQaCxhpaQQvM8Rh5dbCePphL+oHLYBkOqRcSyxR4zUn4PvNNMt3CdTOVEMiDmzYjet8o8sJN
 KQY5ggiQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKdP3-006wG1-QV; Wed, 06 May 2026 16:39:09 +0200
Date: Wed, 6 May 2026 15:39:08 +0100
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
Message-ID: <aftSjG1D0-hKISDy@linux>
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

The only fix in this week's cycle is re-enabling the CCS modifiers on DG2
which got accidentaly disabled some time ago.

Tvrtko

drm-intel-fixes-2026-05-06:
- Re-enable ccs modifiers on dg2 (Juha-Pekka Heikkila)
The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-05-06

for you to fetch changes up to aab3d205a086233c612fee86009265451793e0c2:

  drm/i915/display: enable ccs modifiers on dg2 (2026-05-05 08:12:37 +0100)

----------------------------------------------------------------
- Re-enable ccs modifiers on dg2 (Juha-Pekka Heikkila)

----------------------------------------------------------------
Juha-Pekka Heikkila (1):
      drm/i915/display: enable ccs modifiers on dg2

 drivers/gpu/drm/i915/i915_driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
