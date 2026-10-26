Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF025606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TRNsowGJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C3C10E26E;
	Mon, 26 Oct 2026 10:48:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A704010E26E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793011681; x=1824547681;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9OD6Fc3Ri4/TWa2rRS9xHRLtGqIf8adQMmCjobWsN9c=;
 b=TRNsowGJLHh/t34fhkWdYffiQKrE8xYChRWTqjw1Ub3QpcuknfVag5Tq
 30mubGL4unTAAQOX3o8tEXDGXUGBTlJ/plfE1zzNKc9pZB5BkT573LXFL
 8qgiO5rtazibi9yQIQohzxVOM2K/S1D/aXQuPK9toNV/GJBLrQ/DR9gQT
 hsD1+CqjkFVGqnLTPSZD9+qYhM6wPo3TolNp59zT/Jk/yS9xnG75K37Jr
 m8JG2pbXaqSKsfvvGF3Xk6PmiZAmkuAWroaK/FNO/ddlG1h6eCyfZfDdZ
 SWeMGmjvBmLKaFN60YhZEQP8adw07GnfKIs07GKw2wKLTQTM5xqUeiKxt Q==;
X-CSE-ConnectionGUID: uMea3hivTWaS0aq8U3xh5A==
X-CSE-MsgGUID: JAERdJ2rSWyNZzSV222qpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1679202"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1679202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 03:48:01 -0700
X-CSE-ConnectionGUID: vLuXQWh/RL6fYdilE8RQsw==
X-CSE-MsgGUID: yV79jj5PQye8KK3QcSefAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4268706"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 03:47:59 -0700
Date: Mon, 26 Oct 2026 12:47:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <at8v3P1bbai9lQPY@ashevche-desk.local>
References: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:48:15PM +0530, himanshu bakshi wrote:
> 
> The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Next time wait at least 24h before resend.

-- 
With Best Regards,
Andy Shevchenko


