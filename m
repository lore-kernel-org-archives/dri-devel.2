Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAB606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R5GKzUDl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F2610ED57;
	Mon, 26 Oct 2026 09:48:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21F810ED4B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793008089; x=1824544089;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FO5YVRrreTVeqfWv1jXBJOTTkZR0P+8NlwynvXxgcVc=;
 b=R5GKzUDlpVvR+tdMOYjmlTwkQEV3qAZUbRJzcR1hK977/Hn0ZE2Tg3cW
 H9jwBdzK9JJK89kkuFadqiW9+CUwf+bQvabvQahUQXDL67OHezxDaYu++
 fOQYgSeTpwZKq957T3P+h+XBsthOxBoMojjytHNLtP1Lj4jpsV6hsWQY9
 iWCCxrfpkU2wrgBo/6U9AUF5QaC0Ffv3LK6o9qWfHQA0CJ/tOMdpGBsQv
 5/adFC+ZVQaO6b9i5nScbA6iWnQbw2c2oSnXJXEA7jDsiS+3IpWtXK5j8
 53LWY2a0kYnmCXexMlxO76CEds1YXdpX5JKWxpkZs9yuViEgOgk0Oqh1g w==;
X-CSE-ConnectionGUID: LMXizLgRQP2xPruIvS8XgQ==
X-CSE-MsgGUID: WnjEiwPsTPiFLEDXKOIAOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1680438"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1680438"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:48:09 -0700
X-CSE-ConnectionGUID: TlYW+mW7QnibfSWzmgSNuw==
X-CSE-MsgGUID: VjeOwo7CTom/BJPW5wLfjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4233961"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:48:04 -0700
Date: Mon, 26 Oct 2026 11:48:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8h0ignZd8srvBi@ashevche-desk.local>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Dan Carpenter error27@gmail.com
> 

No blank line in the tag block.

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

You must learn to provide a changelog!
What has been changed? Why (whose request was that)?

>  drivers/staging/fbtft/fbtft.h | 7 -------
>  1 file changed, 7 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


