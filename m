Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4ED606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CjZI75U+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F83810E766;
	Fri, 13 Nov 2026 14:04:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF691125A1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794578648; x=1826114648;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=RogHcFm6X/dyYff9rF8nteDsJKcYDVnQFYqj4YoEAFo=;
 b=CjZI75U+STF/DLCpaxKwmfN7D36cXeQwfY8AohIFS0BxFIf5iIlC42L8
 +dZy825EPynLnddwNrk1fMPtNisXqPOnQ0H1fU5mvSpHZLk8zRF9PsU+J
 sT/gHVVpKdBveBLkwmdRSe1I16wwR1bTqd2ryZCjeUQgjKgV7XLAk3Urv
 Zvr3agTzO9FNNAuDlT/bSWwg3004lV0dFhQ5IrqV0mp4ZfduyGjYPE2el
 KdEP9Qi7NOGxNlrPSUMVYEOZp617XHUw86lzyO+yp7bQMxbc68OFwGmGt
 QMK4In2OATi2ohket0vZKTCd4YtBwGa3YF77DfUz2X9TH19St0UbMgnuB g==;
X-CSE-ConnectionGUID: EUQs5EPLToyO6r86jvOPVQ==
X-CSE-MsgGUID: EtceOSiKTJ+OizlptXYdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3250001"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3250001"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 06:04:08 -0800
X-CSE-ConnectionGUID: XuyLDK0vSuSUBQHppPvcBg==
X-CSE-MsgGUID: QkW/AB6iRs2YDR85IeZcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9478173"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 06:04:06 -0800
Date: Fri, 13 Nov 2026 16:04:02 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
Message-ID: <avcY0oQ-LKWzQuyk@intel.com>
References: <20261107165303.13508-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261107165303.13508-1-lui2012qwq@gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 12:53:03AM +0800, Chengyu Liu wrote:
> In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
> singleton fence) and "fence" (explicit or previous plane's) exist, they
> are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
> fails, the error path runs before dma_fence_chain_init() adopts "new",
> and error: only puts "fence" - leaking one fence reference per failure.
> 
> Put "new" in the allocation-failure branch.
> 
> Found by static analysis.
> 
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem_atomic_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index abef865c5f2c..1e484f26ab31 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -153,6 +153,7 @@ 
                      ^

Why are we missing the context here? Is this some git misconfiguration
or bug?

>  		if (new && fence) {
>  			struct dma_fence_chain *chain = dma_fence_chain_alloc();
>  
>  			if (!chain) {
> +				dma_fence_put(new);
>  				ret = -ENOMEM;
>  				goto error;
>  			}
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
