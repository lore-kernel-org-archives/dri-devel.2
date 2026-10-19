Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B806080AB8
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ti4nkkuW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE47E10EE4D;
	Mon, 19 Oct 2026 15:05:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1205A10EE4C;
 Mon, 19 Oct 2026 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422336; x=1823958336;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qu/70rYg+vG2HLxPI4Uiia6m/VyuInts7xnBWyiDo/c=;
 b=Ti4nkkuWLdNzeCg+7dD9QgHcGeRjuSFHAuLKZuJ3xFGqwacqq+txQZzD
 QfpqBM25RopcIFiJpoBTsckaM04nLEEWh5KMXnonsYBm4Cs59CB63u4jY
 8X7kVVvi0AijQZbVwVihUNO8KIPvIGG6W2ltFYCu0/PMhV3nL2zxUOf/V
 zCBtt/drm8GC9VBDFKYlcU77GbelTBdiUSdX3hNwK1UvOM+kw1+IDRHPx
 7VGcoMahx4H31hgCnMijlNb1IPYSqpFRY03GCtis+hPydCRbag3NAFaZf
 B7nZzvEG1ebgWyKgBMXPcWmdmhFtOaL/Pg3Rtk7K7iYOtDfwLlBKcvDAg A==;
X-CSE-ConnectionGUID: tKU2wjBLQTKoTKj0/HC2Ag==
X-CSE-MsgGUID: XOGymNgrQL+2t5o1Wuay6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="991257"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="991257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:05:36 -0700
X-CSE-ConnectionGUID: MqMhmSnGQr2zmmj5aYuJqw==
X-CSE-MsgGUID: BVwTOvCORJ+b7kKdZMSUPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2634438"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.21])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:05:33 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>, intel-gfx
 <intel-gfx@lists.freedesktop.org>
Cc: rodrigovivi <rodrigo.vivi@intel.com>, joonaslahtinen
 <joonas.lahtinen@linux.intel.com>, tursulin <tursulin@ursulin.net>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/sdvo: Remove disabled HDMI buffer dump code
In-Reply-To: <1a12556af17.597a885f7429.8559089497420287597@zohomail.in>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <1a12556af17.597a885f7429.8559089497420287597@zohomail.in>
Date: Mon, 19 Oct 2026 18:05:31 +0300
Message-ID: <7e2193324bc2d42d420d3afe227699c9dd09bff5@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 10 Oct 2026, Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:
> From cbebdc3b5dce2d4c0ce8c9b69c62b539fc77dce5 Mon Sep 17 00:00:00 2001
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Sat, 10 Oct 2026 15:42:48 +0530
> Subject: [PATCH] drm/i915/sdvo: Remove disabled HDMI buffer dump code
>
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>

Please read submitting-patches.rst.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_sdvo.c | 30 +----------------------
>  1 file changed, 1 insertion(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
> index 3075ef04df56..d9c6a620377e 100644
> --- a/drivers/gpu/drm/i915/display/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
> @@ -974,35 +974,7 @@ static bool intel_sdvo_get_hbuf_size(struct intel_sdvo *intel_sdvo,
>  	return true;
>  }
>  
> -#if 0
> -static void intel_sdvo_dump_hdmi_buf(struct intel_sdvo *intel_sdvo)
> -{
> -	int i, j;
> -	u8 set_buf_index[2];
> -	u8 av_split;
> -	u8 buf_size;
> -	u8 buf[48];
> -	u8 *pos;
> -
> -	intel_sdvo_get_value(encoder, SDVO_CMD_GET_HBUF_AV_SPLIT, &av_split, 1);
> -
> -	for (i = 0; i <= av_split; i++) {
> -		set_buf_index[0] = i; set_buf_index[1] = 0;
> -		intel_sdvo_write_cmd(encoder, SDVO_CMD_SET_HBUF_INDEX,
> -				     set_buf_index, 2);
> -		intel_sdvo_write_cmd(encoder, SDVO_CMD_GET_HBUF_INFO, NULL, 0);
> -		intel_sdvo_read_response(encoder, &buf_size, 1);
> -
> -		pos = buf;
> -		for (j = 0; j <= buf_size; j += 8) {
> -			intel_sdvo_write_cmd(encoder, SDVO_CMD_GET_HBUF_DATA,
> -					     NULL, 0);
> -			intel_sdvo_read_response(encoder, pos, 8);
> -			pos += 8;
> -		}
> -	}
> -}
> -#endif
> +
>  
>  static bool intel_sdvo_write_infoframe(struct intel_sdvo *intel_sdvo,
>  				       unsigned int if_index, u8 tx_rate,

-- 
Jani Nikula, Intel
