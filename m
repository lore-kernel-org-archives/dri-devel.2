Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E209CD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8DD10F6DA;
	Fri, 22 May 2026 13:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jfIS3sjn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828C410F6D8;
 Fri, 22 May 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779458128; x=1810994128;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=30td6Qe00ivsErn6mHuLefubhQdif2UM7K8DI8YAF7I=;
 b=jfIS3sjnsTY0oY9vbvDEIVgoPsp2cKtbQerZ8WF0EegF+TPag0tLZqi0
 fZ86sJoCWC2uhggp6cX8+3fh6BOSStnlk3EBh/99cAaGwCbHzUmugXGDX
 P1AJvcBRL76MjcdYXb5n/np0F3W5z1FXdcge0dsc+04+k6c24CbKIMtd9
 /rk1SF7vMlaMAitTM2zJ7zIUpC2fHjopr9ZA3WiXUVuE5dmJUsZ+70oko
 xIkChp9Fu7whViaMaqhtsBgAm6BFaLW3hkRPd2JB3kh+1ZaOjR55MvKFn
 Nz+QS955P5qtqd7GtHFirRJ+4FWKKc/5o+ncC+xhAs0W4Y73r/36UrlQn g==;
X-CSE-ConnectionGUID: GnTfEqPxRsWx754QYfRdZQ==
X-CSE-MsgGUID: EnwbmYJSQqGRvkqMbZoysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97809507"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97809507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:55:27 -0700
X-CSE-ConnectionGUID: bkZwtChaQlmC/pKL64C/KQ==
X-CSE-MsgGUID: 03thC8SCTPGuUvBENyOBpw==
X-ExtLoop1: 1
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa003.fm.intel.com with ESMTP; 22 May 2026 06:55:25 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH v2 0/2] fixes to DRM doc & parameter's print
Date: Fri, 22 May 2026 15:55:18 +0200
Message-ID: <20260522135520.1862848-1-michal.grzelak@intel.com>
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

Next version of [1]. Changed commit message to mention kernel-doc of
actually changed macro.

[1] https://lore.kernel.org/intel-gfx/20260521155231.1821935-1-michal.grzelak@intel.com/

BR,
Michał

Michał Grzelak (2):
  drm/print: describe 6th & 9th bit of drm.debug
  drm/managed: fix drmm_add_action() kernel-doc

 drivers/gpu/drm/drm_print.c | 4 +++-
 include/drm/drm_managed.h   | 2 +-
 include/drm/drm_print.h     | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.45.2

