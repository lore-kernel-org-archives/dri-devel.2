Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD8CC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A4010E1B8;
	Tue, 30 Jun 2026 09:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZKCJaAfF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2166910E1B8
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782813551; x=1814349551;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=Rsxs8aEhUIy/x1lHQPRYTKTCN0exDRoJT27SXy7fmvU=;
 b=ZKCJaAfF+fQ5KDMR0U57zAWMqbHqIMhs+6oSBZRXUoeiSbwubA+yE3Pg
 4VYcf3V/kL8iF/yGYFBeljZ8kXTxSmm/qJhEZlHH1tDaB0yf7DRCcdPSz
 8chU5z/QYi3CcliV6j+rnnVWEtgh9UgblCuWuE1D0thYAJIpOw458Ot2l
 FUVVZLxmtATlNRk82BTy3sqLwzSm5PbDOVThBD6DPeKrc08kyHOCnr5WY
 RI/EdcATd6QjmnMJYMkWuqJ0cUo3zj70ZRfcwGyB5PFx+A/lFMaPHN2py
 0I4PeaMBsV3OHBL1fdWPJF//4wAsxxL3970eUHMYlv0W4lD0o7B52XI7W g==;
X-CSE-ConnectionGUID: uRd0ufPuRRCSY/OB2UduKQ==
X-CSE-MsgGUID: Pmq7VSipSa6Yk844WD4XOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83607686"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83607686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:59:10 -0700
X-CSE-ConnectionGUID: eDcivR1wRQKXWlUoVxDlqg==
X-CSE-MsgGUID: x5yCWH93TmO6qtpgHvv4yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245874724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:59:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/fixed: fix kernel-doc for drm_sm2fixp()
In-Reply-To: <085ad62d-ec87-4a3d-9b1f-f3ab3e3dfd2d@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260615153012.1899576-1-jani.nikula@intel.com>
 <085ad62d-ec87-4a3d-9b1f-f3ab3e3dfd2d@suse.de>
Date: Tue, 30 Jun 2026 12:59:05 +0300
Message-ID: <e6691e8737ef8bd01f8f8d0616cfe5249265caff@intel.com>
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

On Tue, 30 Jun 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 15.06.26 um 17:30 schrieb Jani Nikula:
>> Fix the kernel-doc comment for drm_sm2fixp().
>>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, pushed to drm-misc-fixes.

BR,
Jani.


>
>> ---
>>   include/drm/drm_fixed.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
>> index 33de514a5221..21d822aeed55 100644
>> --- a/include/drm/drm_fixed.h
>> +++ b/include/drm/drm_fixed.h
>> @@ -79,7 +79,8 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
>>   #define DRM_FIXED_ALMOST_ONE	(DRM_FIXED_ONE - DRM_FIXED_EPSILON)
>>   
>>   /**
>> - * @drm_sm2fixp
>> + * drm_sm2fixp() - convert signed-magnitude to fixed point
>> + * @a: 1.31.32 signed-magnitude fixed point
>>    *
>>    * Convert a 1.31.32 signed-magnitude fixed point to 32.32
>>    * 2s-complement fixed point

-- 
Jani Nikula, Intel
