Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1ECCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5767110F247;
	Thu, 18 Jun 2026 10:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lb4u7GNL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A5A10ED60;
 Thu, 18 Jun 2026 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781777285; x=1813313285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=C+XViI3owNPDk7ocOokFo/XxhRN3dEGwZ3OHdlhAOtU=;
 b=lb4u7GNLUKKbY/N7TxQDuruCz7xDTyOe6RpnVfJ8sUdZapuWGFPJEHap
 Gcmi8gmy4pak11SgSEA2gAEGzLLNV+2em97PVqHJUv2OOohTYTPwC1O3N
 /IEbx3besdnGRmSjir/8EKyMjzrEF5P1OLySiU6GCMpN1zK9Ja1Wrd2fr
 NF+RkkzxOSH6ALkVnLXGWPmM/IWCrxrXXW083YxUs+06+WAtd9TpW1/fg
 hh0QINBYXzjHZCSkrD4BS1AuTcpykwQe74ToDuPAcTaF7Hd+3pR/UU7b3
 SrG1obYKzW68iCDEUG6JqjF8ba77WAGURjFBuBFAxabN9UfNjp98MwzlW w==;
X-CSE-ConnectionGUID: pBucpIxERiasm39FPW1pAQ==
X-CSE-MsgGUID: 8SIGwjL7T1KneaMVAV4C6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86450813"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="86450813"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:07:59 -0700
X-CSE-ConnectionGUID: AkhGEWlSRh+6lM90ZBVbsg==
X-CSE-MsgGUID: EIj4hHNTTYSlQPkrf+Hrug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="252644135"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:07:55 -0700
Date: Thu, 18 Jun 2026 12:07:52 +0200
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
Subject: Re: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add error-event support in XE
 drm_ras
Message-ID: <ajPDeMpSypYrFllq@black.igk.intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-6-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611052144.784969-6-riana.tauro@intel.com>
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

On Thu, Jun 11, 2026 at 10:51:47AM +0530, Riana Tauro wrote:
> Add error-event support in XE drm_ras to notify userspace
> when an error occurs.
> 
> $ sudo ynl --family drm_ras --output-json --subscribe error-notify

Same comment as first patch, but upto you.

> {
>     "name": "error-event",
>      "msg": {
>          "device-name": "0000:03:00.0",
>          "node-id": 1,
>          "node-name": "uncorrectable-errors",
>          "error-id": 1,
>          "error-name": "core-compute",
>          "error-value": 1
>      }
> }
> 
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
