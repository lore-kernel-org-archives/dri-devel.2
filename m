Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A3FC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3F610EC53;
	Tue,  1 Sep 2026 10:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E9pvZ9mw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED3F10E3B6;
 Tue,  1 Sep 2026 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788258561; x=1819794561;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=6VL+2jTpoIlB/ex9UG+2bXV0ukx5HvT53gO1KHXzF7s=;
 b=E9pvZ9mwi8ZrVkv5csb/Uk0ypU4IcpDvDZtfuF9bWpREAAxyFLTJbigI
 jQETGNFstCSadwBDcTagtXzD352o6PWWTAb5pvfGSYX0wXGoJpSvKEHJS
 KvAzdS8K+Fguki5Ybm8nImrkjaA9Xk/czx4EfMz1A/6bYAkMzszWgbEAZ
 DOV4406YLoiMexenyAE7hM/gPa8OunSsf69u01P5UWL+h/sMm7M6fY5YU
 lEnwQGxupC+UoeW4JOhjAvGbsB/y41oJHk7WCChLBuWsF58EWFFLmfKH9
 70vvdyoX0vM8Xe0n863dLTjALqAoBoCzWlSd1rfrkqgkYGNklZtHQCR7u w==;
X-CSE-ConnectionGUID: 7Iv3i9wyQv+ofpCwOvx0Pg==
X-CSE-MsgGUID: KgBFtCVsTsuqEGSCnYQquw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88609367"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88609367"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 03:29:20 -0700
X-CSE-ConnectionGUID: 6sWl4nocQYCB4W25KjLY1g==
X-CSE-MsgGUID: VR0nG1OeSIWlgl4powKc8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="272842924"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.213])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 03:29:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>, Hrushiraj Gandhi
 <hrushirajg23@gmail.com>
Cc: joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: use strscpy() instead of strcpy() in
 virt_vbt_generation()
In-Reply-To: <20260901101225.3aa0f0cf@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260901050241.359490-1-hrushirajg23@gmail.com>
 <20260901101225.3aa0f0cf@pumpkin>
Date: Tue, 01 Sep 2026 13:29:15 +0300
Message-ID: <198aae087325b563c87d6335ffe3b46bd5fb56ba@intel.com>
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

On Tue, 01 Sep 2026, David Laight <david.laight.linux@gmail.com> wrote:
> On Tue,  1 Sep 2026 10:32:41 +0530
> Hrushiraj Gandhi <hrushirajg23@gmail.com> wrote:
>
>> strcpy() has no bound on the destination buffer, so convert this to
>> the bounded, always-NUL-terminating strscpy() instead. The literal
>> "BIOS_DATA_BLOCK" (15 chars + NUL) fits the 16-byte signature field
>> exactly, so this is a no-op change in behaviour.
>> 
>> No functional change.
>> 
>> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
>> ---
>>  drivers/gpu/drm/i915/gvt/opregion.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
>> index d6e76ba31d60..f2527e26cd1e 100644
>> --- a/drivers/gpu/drm/i915/gvt/opregion.c
>> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
>> @@ -151,7 +151,8 @@ static void virt_vbt_generation(struct vbt *v)
>>  	v->header.vbt_size = sizeof(struct vbt);
>>  	v->header.bdb_offset = offsetof(struct vbt, bdb_header);
>>  
>> -	strcpy(&v->bdb_header.signature[0], "BIOS_DATA_BLOCK");
>> +	strscpy(v->bdb_header.signature, "BIOS_DATA_BLOCK",
>> +		sizeof(v->bdb_header.signature));
>
> Pointless and potentially wrong.
> Both normally reduce to the same memcpy() call.
> If the fixed string is too long strcpy() generates a compile error
> whereas strscpy() will silently truncate.

Moreover, there's no provision that the signature must be NUL
terminated. All consumers must treat it as a 16-byte block which may or
may not be NUL terminated. In fact, it is usually padded with space
rather than NUL terminated, and one could argue the NUL termination is
wrong here.


BR,
Jani.

>
> (The '&' and '[0]' might need removing.)
>
> David
>
>>  	v->bdb_header.version = 186; /* child_dev_size = 33 */
>>  	v->bdb_header.header_size = sizeof(v->bdb_header);
>>  
>> 
>

-- 
Jani Nikula, Intel
