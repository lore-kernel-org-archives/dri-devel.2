Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71124606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FmRB0MQb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5245810ECE6;
	Tue, 24 Nov 2026 00:43:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E9D10E156;
 Tue, 24 Nov 2026 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795481024; x=1827017024;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pRLxCSQlJeYSDy4pkSVeZpWYHt1M+JLdVK74ZnxK9hw=;
 b=FmRB0MQbySYg5y34RluP5HuFugzRpoa0nxBVg+Grnnflo+mDD80lhPvl
 U3KalsJ0n6tkFJmey7eqMcUA7zQKD2V6YGP8Uy6OQ6OID2eTKLdGuaETy
 NrVpV+UgmR69BG/lOTQCP9wxK3G/6dnB+N69sEOaLSmJr+4bt4Um3yUG3
 jAipvhIHhf8I8uNpZ4rCJ1FosvGVVTclHnfnnwFFA91Ezs19nhTjSxvwY
 IcsZZ3q/CDieEWUpkDpU0zHlPq9kM8DkttDYfNSjal6U8c3DcnyxeF2BN
 QprF86m+xjeCOFXO6i+hhGDmony5GNjj/QrD8EqXyCzMD5tzVWL9D+2jD Q==;
X-CSE-ConnectionGUID: aXZJqrxNRA2cLhFBswfCag==
X-CSE-MsgGUID: Z+LdoKwASIK9BSmSqLY9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4147841"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4147841"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:43:43 -0800
X-CSE-ConnectionGUID: K/AfWp29QzGke9U2+JHJDw==
X-CSE-MsgGUID: MDdZ0O6lQxW0uzyklB7Hfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11304482"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:43:41 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Ian Forbes <ian.forbes@broadcom.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v1 0/1] drm/ttm/tests: unblock Xe CI runs
Date: Tue, 24 Nov 2026 01:43:11 +0100
Message-ID: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
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

There is a regression blocking xe's CI execution. This patch tries to
fix it.

BR,
Michał

Michał Grzelak (1):
  drm/ttm/tests: do not count pages after pool's teardown

 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.45.2

