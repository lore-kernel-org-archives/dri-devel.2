Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C713C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796ED10F619;
	Fri, 26 Jun 2026 16:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YCaHU7qQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5AF10F619;
 Fri, 26 Jun 2026 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782490736; x=1814026736;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=zeOFSRy8pc3s2Pxnc5jJZ1C2YFWNUFAAxi+3HlbawKA=;
 b=YCaHU7qQwQYz6OSEuYNRb6DEIwPHDnOhpUKXQJSHuxNa9HCCLsHRnaFv
 Ez8cfwz5qPq9W19sbvc+SYZETnEVrtjyVMoLONC7apd7LK5qaONrGFjrj
 Y6ILrVrM003xYc7gyEMQe4bXy/ZraVzNgNforNgnjFtVpgdTvdtoYwJGM
 3iSgdscP4iO5jV9oFAeh4bkS03FX7srImjVoWv9RnZYYW5Z6BFEaIQ/D5
 NyxGJhOt7zcJWwoZZLaVOuDyFfqwk2XbmdP2uXsKtep5fFgbU9CPp0/f4
 1scW8ivWkvbd7sjPyQgEtQcrLJHMt7QR7XGA+XKeFYW9436v81zJXN4Wv g==;
X-CSE-ConnectionGUID: cIYKFzUYROO22spB/rdS8A==
X-CSE-MsgGUID: rJbppZ/7Q4KEuWlu+fntwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="94675805"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="94675805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 09:18:56 -0700
X-CSE-ConnectionGUID: KAlv5linTqqYNG898QQPtQ==
X-CSE-MsgGUID: mSrnC0mtTiK205WH7kn0Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="246898587"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 09:18:54 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, dri-devel
 <dri-devel@lists.freedesktop.org>, intel-gfx
 <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/gt: Return bool values from a boolean helper
In-Reply-To: <aj51Ia0HE9xDufPh@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
 <53ba85083a23024c7d54b656c834c144abbb57cf@intel.com>
 <aj51Ia0HE9xDufPh@zenone.zhora.eu>
Date: Fri, 26 Jun 2026 19:18:51 +0300
Message-ID: <9bc5c33ea64ddfdf0e317be0b039a5a246a9bf58@intel.com>
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

On Fri, 26 Jun 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
>> > diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
>> > index b2cf672564dd..a3f198646e1d 100644
>> > --- a/drivers/gpu/drm/i915/gt/intel_reset.c
>> > +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
>> > @@ -797,9 +797,9 @@ static int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask
>> >  bool intel_has_gpu_reset(const struct intel_gt *gt)
>> >  {
>> >  	if (!gt->i915->params.reset)
>> > -		return NULL;
>> > +		return false;
>> >  
>> > -	return intel_get_gpu_reset(gt);
>> > +	return !!intel_get_gpu_reset(gt);
>> 
>> !! is superfluous.
>
> OK, I can resend it. I actually like the use of "!!" because it
> explicitly converts the result to 1 or 0, by definition of true
> and false, but I don't have a strong opinion on it in this case.

!! is a convention from the time predating stdbool, when you had to use
an integer type to represent booleans, and often wanted to normalize the
value to 0 or 1 avoid errors with inadvertent val == TRUE comparisons
and the like.

Since C99 and stdbool, the !! is just redundant because of the implicit
type conversion that guarantees the same for you.

I don't like adding the redundant stuff, because I think they set a bad
example for people to replicate.


BR,
Jani.


-- 
Jani Nikula, Intel
