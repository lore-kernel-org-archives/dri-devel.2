Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF674606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i1Nkt19k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2218710E4B8;
	Wed, 28 Oct 2026 03:18:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92D710E4B8;
 Wed, 28 Oct 2026 03:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793157498; x=1824693498;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vK2nr3LOCp8KXrYRpUFcujr+RRMG34V0e6P1Uiab714=;
 b=i1Nkt19kwa1SQpJl5XD/85yp/oLeBLSMgNc7Ku6KHNX83NV9gFH2oJfS
 Fb8/mcEKHvrIXqIAqU+y6SQELsFms+9Pkvea8ke3zSaWFZGOt2Zkg9DYv
 Qb4nsIBL+rkndCbrFHLX9RwT6YFaSHUcY1r2h3Xj7zr/r5xcijM5slBYM
 XIc2YZXItPRuPKsg7A+PAiBn5EMyG0BX99Sdp4V6/ZjZW5d8qMbKK0f8f
 dw6h35ibXffbVcUvmHFKM6K7PlgMcopLEfjYKDFoed9YPXZin0h5wjyiZ
 HnrQDZH5lrkG9BgtjDRMvAgvoVfD3FaW3Jq153NtjMlFMeqnJSjWKPc7K g==;
X-CSE-ConnectionGUID: 58GbpgUWSkaTpcmHdGSXIQ==
X-CSE-MsgGUID: LdiQIKYrQK2nW9U2MPlXnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1898052"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1898052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 20:18:17 -0700
X-CSE-ConnectionGUID: vHo4PnIHRDyE7Ib2tP6IWQ==
X-CSE-MsgGUID: F3pNtJLbQeChGFbK4lS6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4810980"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 20:18:16 -0700
Date: Wed, 28 Oct 2026 04:18:13 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Matt Roper <matthew.d.roper@intel.com>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Message-ID: <auFpdeRIafjgKSV9@black.igk.intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 10:36:25AM -0700, Alan Previn wrote:
> Today, when the driver faces issues with early pcode errors
> and attempts to enter survivabilty (when explicitly requested)
> it may either succeed or fail (latter being possible due to
> underlying subsystem blockers). During this flow the driver remains
> loaded and completely silent. No messages indicate that it may need
> or it attempted and succeeded or it attempted and failed, to enter
> survivability mode. This patch adds some awareness in dmesg.

What case are you exactly hitting here? From what I understand both pcode
and survivability failures are logged inside their helpers.

Raag
