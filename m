Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB50CCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4491D10EF19;
	Wed, 13 May 2026 15:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XUTNBPXN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3324F10E5F5;
 Wed, 13 May 2026 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vh4HQrQm9GFKlIqiEab4T+AecgO/Zv8btuEpFSr95JM=; b=XUTNBPXNa3nIuiuEdCgFxdz3AI
 dA09Cqi9ehi+zvOWoJ5l4dP3B0r4Dwnjl0JJDpkU7Ej0gJtS3wAkwNWprmqi7+/TAFDi2UEM4NSu4
 60RZFSgj3EdACzTF6rYZEbP/rnZWptu/Foia12sDvVGJuTHvzivi72LBM+ZISMWFLGl9Fc5n2UFP0
 YXquL/S3iDjnqvbWR/Hz9KlcPBnj0CDUDEB1YhGNdMqz8gruL/52lKLlNJfWgYzT1SS2XX4XzBMnt
 XK4/wuDpbqI65gqBoFBwMKI7C7UQmnzs8G4sC0Nt+tAk5uusdMvRUKa4tY6F6yeNECH1jlTWaUL1C
 5gK9vd/Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNBIN-00A1It-Di; Wed, 13 May 2026 17:14:47 +0200
Date: Wed, 13 May 2026 16:14:46 +0100
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
Message-ID: <agSVZmNC_qV4G6jQ@linux>
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

Two fixes this week. One for a rare race on the SandyBridge reset path and
one to fix dynamic range setting on RGB formats over DisplayPort.

Tvrtko

drm-intel-fixes-2026-05-13:
- Skip __i915_request_skip() for already signaled requests (Sebastian Brzezinka)
- Fix VSC dynamic range signaling for RGB formats [dp] (Chaitanya Kumar Borah)
The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-05-13

for you to fetch changes up to 1ae15b6c7965d137eef21f2cc7d367b29cb88369:

  drm/i915/dp: Fix VSC dynamic range signaling for RGB formats (2026-05-12 08:05:24 +0100)

----------------------------------------------------------------
- Skip __i915_request_skip() for already signaled requests (Sebastian Brzezinka)
- Fix VSC dynamic range signaling for RGB formats [dp] (Chaitanya Kumar Borah)

----------------------------------------------------------------
Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Sebastian Brzezinka (1):
      drm/i915: skip __i915_request_skip() for already signaled requests

 drivers/gpu/drm/i915/display/intel_dp.c | 9 +++++++--
 drivers/gpu/drm/i915/gt/intel_reset.c   | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)
