Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18764CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6385510F2BA;
	Thu, 25 Jun 2026 13:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P/VTLgBr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E60E10F2B4;
 Thu, 25 Jun 2026 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782393117; x=1813929117;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=u5eVtnALt5+Lrf7O+yrnbwP/C1rDlFDTwZmiE348HuQ=;
 b=P/VTLgBrWRkAanXMft0eFPMlQL/IViriO8tpeXDUqi4zo6h1aJUSQO5c
 B6ryK49O2B+Kq3Pht2r7fA3EjTJSsCPcxHhA7JPiAgSuVeEtyPEICoTWX
 WodiTFNJflSbC7kYKJQMhd/6l1bPTzpSbhW9muNihf/f53hm6nZVo3B6q
 WitVpDQLlwjQAQAy8hJrurAYf0gRFyD1x0AjKKRraftaT7EmgYCY7Wipb
 25n0D06jokmFuUzB9RW0VFI/d5og5u7WEwJ0aIMLpnAmvBaiU8GuEa5FI
 3W7iDP0IpT7tqFFfvIoyBuririOmbAi8s2DJW9EpTAaAo7fGjLmhZ8cNv g==;
X-CSE-ConnectionGUID: uu2cevOJTa2l8VStnaFaQA==
X-CSE-MsgGUID: YVf6RtksRXS5N7fT9k3JcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94286864"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="94286864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:11:54 -0700
X-CSE-ConnectionGUID: KjK/Fw3xR1Wx7sedIHV7kw==
X-CSE-MsgGUID: KIvwv+SLQY2/snRUV9VJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="248137156"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.126])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:11:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>, dri-devel
 <dri-devel@lists.freedesktop.org>, intel-gfx
 <intel-gfx@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] drm/i915/gt: Return bool values from a boolean helper
In-Reply-To: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
Date: Thu, 25 Jun 2026 16:11:45 +0300
Message-ID: <53ba85083a23024c7d54b656c834c144abbb57cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 25 Jun 2026, Andi Shyti <andi.shyti@linux.intel.com> wrote:
> intel_has_gpu_reset() returns logically correct values by
> returning a function pointer when GPU reset is supported and
> NULL otherwise. However, as a boolean helper, it is more
> appropriate to return explicit true or false values.
>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
> index b2cf672564dd..a3f198646e1d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_reset.c
> +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
> @@ -797,9 +797,9 @@ static int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask
>  bool intel_has_gpu_reset(const struct intel_gt *gt)
>  {
>  	if (!gt->i915->params.reset)
> -		return NULL;
> +		return false;
>  
> -	return intel_get_gpu_reset(gt);
> +	return !!intel_get_gpu_reset(gt);

!! is superfluous.

>  }
>  
>  bool intel_has_reset_engine(const struct intel_gt *gt)

-- 
Jani Nikula, Intel
