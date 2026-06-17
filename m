Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B281CD98F1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8151710E9BD;
	Wed, 17 Jun 2026 10:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WncROHv2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444F210E9BD;
 Wed, 17 Jun 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781693677; x=1813229677;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6cQoc0XDwgSC3rq88jE9ZOu9X4zh8mv9B+GVkjwgNbw=;
 b=WncROHv2CJI50sqaakX1bs+7wUEmtor3Sh1E8xN377UHyechN7+GBfD/
 ZF0p8ESlmtSJqzAU2IRd+nKg4CH+SrXiUY959XmAGgKqT9QTZPuzeBiQq
 Dh02/wzuE/9c6RgV0099LqJWNtMPHbETEyBkYZwM5jMO27YPXsFzZypqO
 pJdQ45iGlMjcwK6FXI9tu6RyFbxfatRpQnec8vQBKeUuuDLuDQukNaorG
 voQIZDIVbv3XslZiKXHqeSEHoIUHBdxrL+eb+jaVT6Kj4tYMkG5jywEVe
 vO3AMBNY1HxMOrM2SEBiSqAIx7U4bfYej1Bc5OO5cwnUGrSYE2X6t3fLS w==;
X-CSE-ConnectionGUID: Lh8ZM0wXQpyJj/J57ac9qA==
X-CSE-MsgGUID: PctRMx9FQnqbXtTh3ZZ9Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82573613"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82573613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:54:37 -0700
X-CSE-ConnectionGUID: kZdxgdTaTEWgttFmkm0QHQ==
X-CSE-MsgGUID: REd9SseKSFm2YWK0wPnkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="245129648"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:54:35 -0700
Date: Wed, 17 Jun 2026 12:54:32 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Zhan Wei <zhanwei919@gmail.com>
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/xe/hwmon: document DG2 fan speed reporting quirk
Message-ID: <ajJ86P9MvLmtbPpp@black.igk.intel.com>
References: <ahqN8Esjz9SmGofH@black.igk.intel.com>
 <20260602161707.18922-1-zhanwei919@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602161707.18922-1-zhanwei919@gmail.com>
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

On Wed, Jun 03, 2026 at 12:17:07AM +0800, Zhan Wei wrote:
> On DG2 the driver always shows two fan channels, because the
> FSC_READ_NUM_FANS command does not work on some cards. OEMs decide how
> the fans map to tach channels, so two fans can share one tach line.
> When that happens, the second channel reads 0 RPM even though the fan
> is spinning.
> 
> Note this on the fan2_input ABI entry so the steady 0 RPM is not
> mistaken for a driver bug.
> 
> Fixes: 28f79ac609de ("drm/xe/hwmon: expose fan speed")
> Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>

This one seems got lost in the noise. Any takers?

Raag
