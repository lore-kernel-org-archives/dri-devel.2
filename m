Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC1EC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E66110E510;
	Tue, 18 Aug 2026 08:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lm3wg2Nf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ED010E4FA
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787042225; x=1818578225;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4b7I6huqeATBrGSn+Z3OSgkdRFOhUFuXxaN24NMCxmQ=;
 b=Lm3wg2NfOyz8OfyHcHX/6HmsrkR/C7VlI8rqB9kiOupK4eqz9HeGTLEG
 gSIJI2kdaH4QxVosX7SkbRzGdpMkbGUtgCBORu2riYrr4ED+hmjGmBXm5
 8kAgTpqKL0jCkxJkQbUV2Te5nmD7JpeHzoFFMk0tAEPOqb+6zkoSvtkdg
 4btRroShhIuq+CTUtmLw8lYq72h0fjs3ehrq1r3FaROs5gkU1V/J5vYC9
 NKIWUCgqVAEsnS8w5TFAqWcwHVZ2d6nNUJh5sPs/i3pdiY46iuHHJOUAH
 4PndoNxjTUOuY3tma9VUs3YQn0SeGiYVKTpGs0JdzSVMg94DUROr6YHk8 g==;
X-CSE-ConnectionGUID: ZyExHLfbTY2gzb1mkgHjXw==
X-CSE-MsgGUID: +K6HUDHBQwKgp0t/4jC6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="90040426"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="90040426"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:37:05 -0700
X-CSE-ConnectionGUID: dbiVEkfwSVqyGrHS2NSAng==
X-CSE-MsgGUID: 2MyR2/xpRr24LqqdGdKAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269007555"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:37:01 -0700
Date: Tue, 18 Aug 2026 11:36:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Piparo <holofermes@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
Message-ID: <aoQZqnbqoiOw6MKt@ashevche-desk.local>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-3-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818080626.30430-3-amit.barzilai22@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Tue, Aug 18, 2026 at 11:06:22AM +0300, Amit Barzilai wrote:
> SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
> Switch the SSD133X data path to RGB565.

> +	/*
> +	 * Horizontal address increment, normal SA,SB,SC (e.g. RGB) sub-pixel
> +	 * order, COM split odd even and 65k (RGB565) color depth.
> +	 */
> +	u8 remap = SSD133X_SET_REMAP_COM_SPLIT |
> +		   FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X_COLOR_DEPTH_65K);
>  	const u8 cmds[] = {
>  		2, SSD133X_SET_MASTER_CURRENT, 0x06,
>  		3, SSD133X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
>  		3, SSD133X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
> -		/*
> -		 * Horizontal Address Increment
> -		 * Normal order SA,SB,SC (e.g. RGB)
> -		 * COM Split Odd Even
> -		 * 256 color format
> -		 */
> -		2, SSD13XX_SET_SEG_REMAP, 0x20,
> +		2, SSD13XX_SET_SEG_REMAP, remap,

Strictly speaking this is now initialisation of const object by non-const value
(yes, since it's a simple integer  there is nothing in between to modify it,
 but still...).

>  		2, SSD133X_SET_DISPLAY_START, 0x00,
>  		2, SSD133X_SET_DISPLAY_OFFSET, 0x00,
>  		1, SSD133X_SET_DISPLAY_NORMAL,

-- 
With Best Regards,
Andy Shevchenko


