Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D4606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsVGmAXC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED1410E782;
	Thu, 26 Nov 2026 16:47:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCBC10E2FB;
 Thu, 26 Nov 2026 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795711618; x=1827247618;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nfQExbOYNL+7L1lwz7pYsVeWGRgrea6lnzl3+PdgAOg=;
 b=dsVGmAXC5pRxJav3rOYFFt+glvP9HENErEKD3PpK/IndxDo/EpbiivjL
 U4IHeQg2XpIMVAd2aG1yrpezbHQzNLg96SRFz78kdkaR7+fO/EdEkusFj
 4K3aDiWMzc1AtMj+Yo/Qp76dyk0ha7dtLH/322/0w00ppuRRnYCEfXmqN
 0OBbpLakxRuVtUfO4Q7zjwTnSN/C4OSaYEuL67JqvPdNqiV7E5/hvKlS7
 wpBmrAKBdRykct4D+4NFlu3iZXDXLmcLaF6RGGel0CIxEGyt0wIxpYjDb
 1wTkklCH+PoRyL34PCONmdhbnYgKCNGFHD/+ftgAI0Bwn8y1ZopjjNcsy w==;
X-CSE-ConnectionGUID: 4d6m+Dd9RWWis7LdeVGkUg==
X-CSE-MsgGUID: iR+XvQXTT82IhuizKgdpYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4531721"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4531721"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:46:57 -0800
X-CSE-ConnectionGUID: x9dUT6LTQ0WACyimg/QcxQ==
X-CSE-MsgGUID: AMibKTFFTmOyM4ygxwwaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12363704"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:46:56 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v1 0/1] drm/ttm/tests: typo removal
Date: Thu, 26 Nov 2026 17:45:15 +0100
Message-ID: <20261126164516.102435-1-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michał Grzelak (1):
  drm/ttm/tests: s/recrusive/recursive/

 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2

