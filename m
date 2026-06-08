Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB0BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3585D10F2F3;
	Mon,  8 Jun 2026 12:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RmwCg2/X";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697A410F2F3;
 Mon,  8 Jun 2026 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780921443; x=1812457443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TrAGXUsCk6JB+MSwl5sqpSAx1775KaUf0D3OIRPQv/Q=;
 b=RmwCg2/X7zz9X3MTWA3m6J6bTI89Y19P0bZizOK+QeIF4WguslShDenE
 jhRZGsxtsxjaDot2YQdUyJRxPtR/G4k8LR11CWQRWObw2ixutWylaQzuS
 dPvmZEvIQy3WMh9hsXsa9KJRbG8Mg962hCk+Lszi66CVtfgb0yszuzHf+
 Q2PmdMZqbVP/Y2zW1WugorpnuD+gtMR2NpZO1LOnLN858bVBvDPCrqUVL
 kilaS0gSMIo3cQxizAkoNRNE/SHdZrn3wIcdN82r8CcJJF6YT8Z+OEp07
 RC7MU5XdYhg9Jgq9w4SXJAQt2G3vK2KJ5Qe8BWOcy+dCBKyg1tx/hjzFT w==;
X-CSE-ConnectionGUID: /w917xrUQVq1+vFBmSycNw==
X-CSE-MsgGUID: KziWUyY+SP6N1n2n5RdujQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81700916"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81700916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 05:24:03 -0700
X-CSE-ConnectionGUID: EUgn6lwxRwSDRgdCuusSig==
X-CSE-MsgGUID: RlUg3MzkSMWfB8eQkO3MUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="241090613"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa006.fm.intel.com with ESMTP; 08 Jun 2026 05:24:02 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH 0/1] drm-tip: build failure
Date: Mon,  8 Jun 2026 14:23:15 +0200
Message-ID: <20260608122316.3131299-1-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260512162711.51118-4-christian.koenig@amd.com>
References: <20260512162711.51118-4-christian.koenig@amd.com>
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

Hi all,

today drm-tip build failed with following log:

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c: In function 'amdgpu_cs_submit':
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1326:33: error: 'struct amdgpu_vm' has no member named 'invalidated'
 1326 |         if (r || !list_empty(&vm->invalidated)) {
      |                                 ^~


Fixed the build by making same change as did commit 59720bfd8c6d
("drm/amdgpu: restart the CS if some parts of the VM are still
invalidated"), but double check would be probably needed.

BR,
Michał

Michał Grzelak (1):
  drm/amdgpu: check individual moved list instead of invalidated

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2

