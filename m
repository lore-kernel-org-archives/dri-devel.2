Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C67C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D3E10F3EC;
	Thu, 24 Sep 2026 09:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iE2hDD9R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A4710F3E6;
 Thu, 24 Sep 2026 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790243141; x=1821779141;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sfY11cdtJp865U1tC2f/dZACe/B/9CLIWV3bLlL5Bwk=;
 b=iE2hDD9RXkIbcuZ3gEM2bD8iRlBKum2DcUx/+9u+D9mYHOf6M9aMKWXc
 dRp+lJoOQMGKAY52bltxER1me9JPLcwah8A2lBKFBlUFFqBXIniyR0jnj
 jIqhaE66jQwg/0zdBV+KyULL6ujTRSEi5z9m3gYaViLwVsWXry6X7uj7m
 nZDfRHVTNIATkFY9q38zdNYlz/8L7DQ0kjuFA4lIrXnhxXV+05f+qdvmu
 MjEY68CW7vmlP7XLcOcx6R2kBS6knUqkqD72LYM+ZrVDLUktTPYyJ+e4n
 FMjhbAqn3tIo7LixOGrk9fMcC8/Rs5Lxwh23gnNGNqFS46DDNDUG0cnb1 A==;
X-CSE-ConnectionGUID: PPL96b7SQvitGuWAwo8nlA==
X-CSE-MsgGUID: LRPusl0ORi20B6Dpv7jb0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90048133"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90048133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 02:45:41 -0700
X-CSE-ConnectionGUID: ON0PMdNNRzSp4iGopxx0CA==
X-CSE-MsgGUID: 4/iZC4TMQdCXozfqBD6ing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311879535"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 02:45:38 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v3 0/2] drm/i915/dp: Fix MST PBN accounting
Date: Thu, 24 Sep 2026 17:43:14 +0800
Message-ID: <20260924094316.822211-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922092647.2263962-1-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the raw video PBN in ALLOCATE_PAYLOAD requests while keeping the
TU-aligned PBN for source hardware programming. Also track the PBN
actually allocated by downstream branches and use it in later bandwidth
checks.

The series was tested with a three-display PS8650 MST daisy chain.

Changes in v3:
- Preserve allocated_pbn when recalculating an active payload; clear it
  only when releasing the payload.
- Patch 1 is unchanged.

Xiao Lu (2):
  drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to use actual video
    bandwidth
  drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD down-reply

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 +++++++---
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 33 ++++++++++++++-----
 include/drm/display/drm_dp_mst_helper.h       | 10 ++++++
 3 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.43.0

