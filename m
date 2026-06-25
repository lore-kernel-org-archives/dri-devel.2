Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36F1CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877DD10F316;
	Thu, 25 Jun 2026 15:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="noaEykE2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D7A10F311;
 Thu, 25 Jun 2026 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782400989; x=1813936989;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=izqtDzGnHbtQxmtPbrBFDOh/jxd8obvs5oRqGmLQp8s=;
 b=noaEykE2DWWkb+54FQRSQlzSaaz+o6dQ+rNABvnEIfw6K/MCyyPaZ2x5
 0dvcl0sd28WtzJOXfrTkjoBEovSHSpq9T/eUMoshizsnvt9F952Oa8hwW
 sE9jZFQakcsHIRgzrY4grbauiAEdXdsWTpQKsO4zfNI1gm8STp1O+HKDG
 x/f7JpAzIqDJ8Rkm/4pyzjGFgR0BtT3a5Ve0AAHIS2ze4oj33V/Kvq5Sc
 fv5TJNApDlFTG/ao+0MbowiXO/fhXUYbhCZLCCEftt75VeiYU66anpmMg
 I/tl5poJ790gw/oAZp9MPAuQhzDReBr/JEVHvHwD/SgPLDEJqC20BNjCg g==;
X-CSE-ConnectionGUID: 0hps54/fTLecjMFNEcl80Q==
X-CSE-MsgGUID: ebDy0K8tQayIp6L4ZmB/Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83056872"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83056872"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:22:57 -0700
X-CSE-ConnectionGUID: b/SIcBjkR8K01b+45U1XYg==
X-CSE-MsgGUID: cc8dx6h4S8SoRjjm6y4ZuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="251333019"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:22:56 -0700
Date: Thu, 25 Jun 2026 17:22:53 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] drm/i915/gt: Return bool values from a boolean helper
Message-ID: <aj1HzUjokwiZCk7T@black.igk.intel.com>
References: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
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

On Thu, Jun 25, 2026 at 01:44:42PM +0200, Andi Shyti wrote:
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

I know the logic remains the same but isn't this Fixes material?

Raag

> -	return intel_get_gpu_reset(gt);
> +	return !!intel_get_gpu_reset(gt);
>  }
>  
>  bool intel_has_reset_engine(const struct intel_gt *gt)
> -- 
> 2.53.0
> 
