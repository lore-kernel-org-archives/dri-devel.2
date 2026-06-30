Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4167C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F9E10EC7F;
	Tue, 30 Jun 2026 12:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dLjkx0yA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BFC10EC7F
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782824007; x=1814360007;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=xH1HuZZVVAnpnXT9pXab+us/6OXNa0rs76MqhKjJ9yg=;
 b=dLjkx0yArMiafprqCqEIoa9rh7lDI18iiG7HzIQ7s8BSf0A/lO36+f9A
 VAlZZKt9QVv3ZKSNdytxaC2vBaK1Rb/R3YEv0vF/UWu4oYUHtARxRoSpD
 DtpenIyuEqX3myKBKQGAzpMGh1Ym5N3xPepZWhK7kiW4uowQ8szxQg616
 dWPBHM3CEGzs6WVBwiS4y+J8AWc78B7goASEAxEhuEyP04WDWkDNCLNl1
 D0MlxrYQr6EULImRLMk8Xgj4ccixPgddGcwvP25iAfgdE7B9NYZvwsbqa
 4ZOZq5jIKHNq7m4zG0kFRMML0ehkeHeUPljFYR7rVxDzYd8+4ROLxR1Dp g==;
X-CSE-ConnectionGUID: L2P0dQ8HQSG3CsrH7grtyA==
X-CSE-MsgGUID: o7YxwRi8TVa2k66nzIZ85A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83562549"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83562549"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 05:53:27 -0700
X-CSE-ConnectionGUID: S2/hk7bnSyeW4ejeCnQnhA==
X-CSE-MsgGUID: U4YQd2b+SPyBILXc2Pf8fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="275483669"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 05:53:25 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: Riana Tauro <riana.tauro@intel.com>
Subject: Re: [PATCH] drm/ras: include linux/types.h in drm_ras.h
In-Reply-To: <db688f2c-19df-4121-9e8b-bf4d62538c8c@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260615152949.1899358-1-jani.nikula@intel.com>
 <42a575c7-7b39-427e-8577-addf1c9e3398@suse.de>
 <a685ddfa7c435d0c63c186726437032ddef1672d@intel.com>
 <db688f2c-19df-4121-9e8b-bf4d62538c8c@suse.de>
Date: Tue, 30 Jun 2026 15:53:22 +0300
Message-ID: <95a1051272acf60b45d0f5290b1fdd41fa8f222e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
> Am 30.06.26 um 12:57 schrieb Jani Nikula:
>> On Tue, 30 Jun 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Am 15.06.26 um 17:29 schrieb Jani Nikula:
>>>> drm_ras.h uses u32. Include linux/types.h for it.
>>>>
>>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>
>>> with the question below answered
>>>
>>>> ---
>>>>    include/drm/drm_ras.h | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>>> index f2a787bc4f64..0beede3ddc4e 100644
>>>> --- a/include/drm/drm_ras.h
>>>> +++ b/include/drm/drm_ras.h
>>>> @@ -6,6 +6,8 @@
>>>>    #ifndef __DRM_RAS_H__
>>>>    #define __DRM_RAS_H__
>>>>=20=20=20=20
>>>> +#include <linux/types.h>
>>>> +
>>>>    #include <uapi/drm/drm_ras.h>
>>> Should the uapi header be included first? That's what I've seen
>>> elsewhere and what seems more correct.
>> I'm not sure. I just pretty much always put linux includes before any
>> drm includes, and I don't think the order should matter functionally. If
>> it does, something else is wrong.
>
> Well, OK then.=C2=A0 R-b: me.

Thanks, pushed to drm-misc-fixes.

BR,
Jani.

>
>>
>> BR,
>> Jani.
>>
>>
>>> Best regards
>>> Thomas
>>>
>>>>=20=20=20=20
>>>>    /**

--=20
Jani Nikula, Intel
