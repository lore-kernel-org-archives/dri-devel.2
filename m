Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438BFC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8F710E7AB;
	Tue, 21 Jul 2026 08:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DMxkNFxX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA4210E313;
 Tue, 21 Jul 2026 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784623231; x=1816159231;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N/fNl0STMVXOM7MK04jg30opbHmwh+0fTTdIVc/7fus=;
 b=DMxkNFxXeglQDHEo2HiS/N90yZweK6tREerENti53LZBgQRj9hwURwpf
 1tvjw87P9tkNLEIUWE9pxZUhO190UMRMoL/cMH3y9bCEi7AaYCd9nHlpn
 kqV2kR/XB/GL407wDzvp9a0SMAk1op2gFTwiOf2SsUVTJDkw3QdHWsoEO
 ZxWsyAFGAktV62eSen8tZbtwJ+vPY2UQjQK8Ij5aPHOV6Dv3F6d+XCFQU
 Zd99hKfx7rCU/n3NJudsMpOcoXgBr1vBgkCVB4hC1RLzh2dFB6cE13u+R
 LPvilo1Ibbc6d3prbo5jBMuYWRnpMNSWz5ROonfN2f2CRz9KL2EHe/WFC A==;
X-CSE-ConnectionGUID: AqjiQr5yQ1OYtbt6B2DtMw==
X-CSE-MsgGUID: BPUkV7KhQKaai0q8tmLv2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85254400"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85254400"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 01:40:31 -0700
X-CSE-ConnectionGUID: e/CK7lyuT3O1nnzdQjmSHw==
X-CSE-MsgGUID: EAgF+5zjS+6G7Mbr4hNBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="257765400"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 01:40:27 -0700
Date: Tue, 21 Jul 2026 10:40:23 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com
Subject: Re: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error events
 to userspace
Message-ID: <al8wd1fN43vkVVPR@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-8-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-8-riana.tauro@intel.com>
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

On Mon, Jul 20, 2026 at 01:52:12PM +0530, Riana Tauro wrote:
> When the firmware reports uncorrectable errors in response to an AER
> interrupt, deliver a drm-ras error event to userspace for each affected
> component. Multiple errors for the same component within a single firmware
> response are collapsed into one event to avoid duplicate notifications.

This one too can reuse the patch 2 kindness but I'll leave it to your
mercy.

Raag
