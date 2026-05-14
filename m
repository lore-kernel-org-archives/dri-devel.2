Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AB3CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 07:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DED10E378;
	Thu, 14 May 2026 07:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RiARc93Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169DF10E109;
 Thu, 14 May 2026 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778745586; x=1810281586;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8AtjJh65++xKLOFKBDQSuomo6zaxHfC+NEgbuOizWIc=;
 b=RiARc93Y/73GiXOEmlfedXYv+THOwD38lTAxXZ9R3+2RTv7XtC3LeZvY
 nxP7ovikjO8hVs+RQyZpP+WWqZzVKGZl8OZljQmkUXpDeCnHmqkDgUVrt
 QSsSh5AFwC3k27HKqyWEx04THtzs56pZsNibn/HBidPBV6zRSEjiL6oYb
 TrDblKMvGX/Ul5+Nt2drx18gk5F3H4A9Glr59HNNSbYA/4IZiOkIAMAp8
 uy/OY8PZ5MCriaDuko9n7j5hbMKlVvahxMXIz/lkCCCMgIMPiyoT81dKz
 n+49iIx4umIojwOa+eLqqE0YaeBRRKKTm7UwfNH9tXbaHaaboiNpH6OXb w==;
X-CSE-ConnectionGUID: qk2Cf8rFRCaiuWI99/fgLg==
X-CSE-MsgGUID: Jhh9O5WXR3OeFBQn/EdPWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89989802"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="89989802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 00:59:45 -0700
X-CSE-ConnectionGUID: KC+Vg68KSTOLYmPGRKd0Zg==
X-CSE-MsgGUID: 2F0Huc0eT2isWeekFaADsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="268671621"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 00:59:41 -0700
Date: Thu, 14 May 2026 09:59:38 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 2/5] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
Message-ID: <agWA6uHFMsZfvkd2@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-9-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132614.1793083-9-mallesh.koujalagi@intel.com>
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

On Tue, May 12, 2026 at 06:56:17PM +0530, Mallesh Koujalagi wrote:
> Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
> scenarios requiring device power cycle.
> 
> This method addresses cases where other recovery mechanisms
> (driver reload, PCIe reset, etc.) are insufficient to restore device
> functionality. When set, it indicates to userspace that only device power
> cycle can recover the device from its current error state. The cold reset
> method serves as a last resort when all other recovery options have been
> exhausted.
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
