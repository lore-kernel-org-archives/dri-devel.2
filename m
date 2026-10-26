Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623FB606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nk4xQPYa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8710ECEC;
	Mon, 26 Oct 2026 09:20:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D6810ECEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793006420; x=1824542420;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l98tJlWIxePL8UadcPX+icRB1JGKcTcv7OakA/8Fbb8=;
 b=nk4xQPYaqxVy2el9UByZy1TI4/fkvrLr5UvNDds+DzOgcVqM1C9mqVsn
 dtaFQuDv15yN4jajb2efUrCYPAn3ycUaKyfLkNgwV3JTungjdg7TsHqNJ
 Tj7i6+HQ8OaN64RqtWP94YcGxmz/krI9l4Vd5CoIkn3rXjEGP2Xzoz1GG
 nq3dOH1xyzPHm6ZDgcerecIC0B2jpuN6n8gSgQV9sfRtl2Dazc6NU1k8b
 vo3wKclataNvYn0pqajMxSEN81FdFIkw14x5YP9qEgpwquzQ41u+votDQ
 t995mMAj9r8L84TE5MmRg/DG6WsClWznKvHGCRJMACRKM13NtH0lOU7rw g==;
X-CSE-ConnectionGUID: 3Mz3M0tzR6iE+JlXFbraEg==
X-CSE-MsgGUID: QIHsgdOrS2KNU7RM1v1Ptg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1567222"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1567222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:20:20 -0700
X-CSE-ConnectionGUID: +NkuXWxbSty1XHIxudWlug==
X-CSE-MsgGUID: 61o73YBrTBeplNEqcvJ6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4269505"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:20:18 -0700
Date: Mon, 26 Oct 2026 11:20:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at8bT7NCQb9XvGoS@ashevche-desk.local>
References: <20261026044523.18516-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026044523.18516-1-himanshu.bakshi478@gmail.com>
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

On Mon, Oct 26, 2026 at 10:15:23AM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Split the line in fbtft_init_dbg macro to keep it within the limit of 100
> columns and address the checkpatch warning. Also aligned backslashes (\)
> for the macro. Added a temproray variable for platform data.
> 
> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

Where is the changelog?
Why do you think this patch is anyhow useful (based on the previous discussion
and your observations)?

-- 
With Best Regards,
Andy Shevchenko


