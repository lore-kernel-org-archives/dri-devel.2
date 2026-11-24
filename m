Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE15606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DztQ+gSh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED3210F8AF;
	Tue, 24 Nov 2026 22:47:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AEE210F8AF;
 Tue, 24 Nov 2026 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795560457; x=1827096457;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Fvpb2ntULlBUm1e6BAvLugqz54o7iPgBihhOIHo2IFE=;
 b=DztQ+gShatTjVj0ZaXyuSF3qwyXWMPewzWuyG+kymrBLsrVaMvyXjB+7
 NCtGD5gcWGSCp0kBqU+PnMPVp9iiIrt/Lp3sWR+uLPVHpxWyLepC9vRGj
 vUKJVYYJNvZkNkJLa+iyG2vFjU2CvKso4QpzdrbuVwXRIPvhPRqCZAABy
 z+Bbwh8qE6+urRR2Ml8BEtcPdicg9iWAB3InQZymkIAIfV0PZBUUQ4Nv4
 7UWtluhEGAKV6QJq8y3pPAMMPF4WDvI6NDBbsZV3Tn80eN6y6B3ZOWT9a
 e9h6BMhv6erBptKs8K7odd+e9/AvkynTbDTL3cN7FHfS+JYtzFumG1Tse A==;
X-CSE-ConnectionGUID: zAz7adcnT/Sq/3fS4NRXgg==
X-CSE-MsgGUID: Cy3EbDBGShqMU+r6BfseuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4413071"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4413071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:44 -0800
X-CSE-ConnectionGUID: MHzmC+MVQs60sLTl5S4EYQ==
X-CSE-MsgGUID: drwC3H7ORRiZOEYkMKDm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11799012"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.204])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:24 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 0/2] drm/i915: Implement DisplayID based VBT panel type
 detection
Date: Wed, 25 Nov 2026 00:46:19 +0200
Message-ID: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On some new systems we apparently have to use the
the DisplayID product ID block rather than the EDID
base block to find the correct panel entry in the VBT.
Implement that.

Ville Syrjälä (2):
  drm/edid: Introduce drm_edid_get_displayid_product_id()
  drm/i915/bios: Attempt to match the VBT PnP ID against DisplayID first

 drivers/gpu/drm/drm_displayid_internal.h  | 11 +++
 drivers/gpu/drm/drm_edid.c                | 49 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_bios.c | 81 ++++++++++++++++++-----
 include/drm/drm_edid.h                    | 10 +++
 4 files changed, 133 insertions(+), 18 deletions(-)

-- 
2.56.1

