Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5267CCD5BB4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D0D10E4C2;
	Thu, 21 May 2026 15:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dFaGxn2M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194D910E1A1;
 Thu, 21 May 2026 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779378781; x=1810914781;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VWbOniqgE+XRWw6wJdo5DmKWnNwxXf2x0K5srvjrxko=;
 b=dFaGxn2MdmW3e1k1EHhOTqkQzjdpI1YZR1BRPFrY7Spl5uWTrLcfVxNc
 B7MeqYKTcPXyNZoWguvMbKffpCi5aTP94A4pBFdW3d6bkBwEQBlzquvNm
 FA2UvBu9sS0Mc2LaMndaNsNYmmXdl3CvzibTEmvlDFq22gvmhV6SFO3Gl
 CVozvXcgsq4X/sAYGIvj0rZZlPf8A5B25e3CAg8CYIeY3rkNpIeQ3LNg/
 vQRhoDorUMAVPvt9qiTljCBMtARIOJUpq/3KpOlHLbQo8phz/PS7Gk0L+
 MSJCYCJEabEQdXTcDZZayYCMKeC2i3DdGKE6i9V/IAZmNPDP40XTsORoz A==;
X-CSE-ConnectionGUID: c6uSulptSFKw6xQNRvqfEQ==
X-CSE-MsgGUID: fiGN2pV7Ru6vW4Mq5AJiVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80200359"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="80200359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:53:00 -0700
X-CSE-ConnectionGUID: NZfOIh/EQjuNmTP98MToDw==
X-CSE-MsgGUID: rBpJE1TAQMCIsBDruuHCog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="244837722"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by orviesa004.jf.intel.com with ESMTP; 21 May 2026 08:52:58 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH v1 0/2] fixes to DRM doc & parameter's print
Date: Thu, 21 May 2026 17:52:29 +0200
Message-ID: <20260521155231.1821935-1-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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

Michał Grzelak (2):
  drm/print: describe 6th & 9th bit of drm.debug
  drm/managed: fix drmm_add_mod_or_reset() kernel-doc

 drivers/gpu/drm/drm_print.c | 4 +++-
 include/drm/drm_managed.h   | 2 +-
 include/drm/drm_print.h     | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.45.2

