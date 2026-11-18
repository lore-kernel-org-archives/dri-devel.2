Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBA606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BmUL5rdG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E246E11203B;
	Wed, 18 Nov 2026 21:45:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6145910EC87
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038333; x=1826574333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kBUOMivS0p/dTXmtBlWhxtG75A0UN816unfAOvHp9ik=;
 b=BmUL5rdGDNJaBZ4+vssaIoXTQBpc+TlO699YIPXab/8kQNIy+pp8ckvd
 4I0ozRzvD/2muMiFuS2GGBAVEb6tBbeUhjY/HtKWqcBtU5TC0S7IbgtYY
 9bcCT2Dm7foZClfJzjxVDPBJJ72Bco9kQALzjymjETmf0jFl5mOy05OmY
 +A6SN40244ZMrSbciWqbapM5OIMVxFu9MHP8MB0veBe9Qhu/N5AoLOUNZ
 cqSDIQztwIE7SM12gs25j9Z9dzL1iT/qof1pq+A69iNlLO2z7JTTAjyhV
 4eAutPXqmmrIX2RXr3pVkdKVOY7K3RI3L3T+34eUnqDULULulpve+NIJa Q==;
X-CSE-ConnectionGUID: xJBS1GfgQoq1U8vD+0s5Jg==
X-CSE-MsgGUID: 7P6J+wtARqSJd1mb+ZbHIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3862533"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3862533"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:33 -0800
X-CSE-ConnectionGUID: GFD/LgYHQ966ZuEBsXUIww==
X-CSE-MsgGUID: nYtpnMhxSj+AeluE8YvB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10390663"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:30 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
Subject: [PATCH v4 01/20] drm/tilcdc: Allow build without __iowmb()
Date: Wed, 18 Nov 2026 23:44:58 +0200
Message-ID: <20261118214518.29317-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

__iowmb() isn't available on most architectures. Make
its use optional so that the driver can be built on
other architectures with COMPILE_TEST=y.

v2: Add a comment stating this is for COMPILE_TEST (Tomi)

Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Acked-by: Jyri Sarha <jyri.sarha@iki.fi>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
index 26ebaf1e0f70..55fe598fe770 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -125,7 +125,10 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
 #if defined(iowrite64) && !defined(iowrite64_is_nonatomic)
 	iowrite64(data, addr);
 #else
+	/* allow compilation without __iowmb() for COMPILE_TEST */
+#ifdef __iowmb
 	__iowmb();
+#endif
 	/* This compiles to strd (=64-bit write) on ARM7 */
 	*(volatile u64 __force *)addr = __cpu_to_le64(data);
 #endif
-- 
2.56.0

