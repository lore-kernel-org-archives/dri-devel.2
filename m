Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A686C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30A810EC31;
	Tue, 30 Jun 2026 10:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GQPGC7yl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313E910EC31
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782817056; x=1814353056;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=0eFoTQZJ+4CTzg8plJKh0HetfVhx52VYe0f9oYwkOQc=;
 b=GQPGC7yl+oR44uo3IRklbjD12SJ/g1IC522LUvt8F9kLQMLk6KfaNJv3
 wNzFvTrNe4y0hOMIeq4Bkx3ga761eC3PNNuDGz69VHbjUuf7XGh1luGla
 77dLgwI30t2zfwh8MG7JTdnegHTNlGnNwirnHi5MG20IdRkvEkNKaLFaW
 wL2fnbnWiPHNwi4B44JAA1Q2pLaxiZDSYysV9oGEkiWeiSsJTl5jynprW
 FfbgapD9mRobCU0mm7DDp9xuAPRUG+D1DYWVmLc4sEtCnnkBGkiZCwwM0
 zZyZIP9wpJGJBYD0AyJ3ghuUraA3T6AVgeK7mE20Y/G1HCjtWiGlyomZ4 w==;
X-CSE-ConnectionGUID: KIc/JSEKS3K0BP/+RqIXeQ==
X-CSE-MsgGUID: /cqnvG9QQcWDr5dhHqCBJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82640468"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82640468"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:57:36 -0700
X-CSE-ConnectionGUID: qv4fzqS+Rm6ixjV2iZh25A==
X-CSE-MsgGUID: 5tXM1pfQSumiLS0hZN/cZQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:57:35 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: Riana Tauro <riana.tauro@intel.com>
Subject: Re: [PATCH] drm/ras: include linux/types.h in drm_ras.h
In-Reply-To: <42a575c7-7b39-427e-8577-addf1c9e3398@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260615152949.1899358-1-jani.nikula@intel.com>
 <42a575c7-7b39-427e-8577-addf1c9e3398@suse.de>
Date: Tue, 30 Jun 2026 13:57:32 +0300
Message-ID: <a685ddfa7c435d0c63c186726437032ddef1672d@intel.com>
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
> Am 15.06.26 um 17:29 schrieb Jani Nikula:
>> drm_ras.h uses u32. Include linux/types.h for it.
>>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> with the question below answered
>
>> ---
>>   include/drm/drm_ras.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index f2a787bc4f64..0beede3ddc4e 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -6,6 +6,8 @@
>>   #ifndef __DRM_RAS_H__
>>   #define __DRM_RAS_H__
>>   
>> +#include <linux/types.h>
>> +
>>   #include <uapi/drm/drm_ras.h>
>
> Should the uapi header be included first? That's what I've seen 
> elsewhere and what seems more correct.

I'm not sure. I just pretty much always put linux includes before any
drm includes, and I don't think the order should matter functionally. If
it does, something else is wrong.

BR,
Jani.


>
> Best regards
> Thomas
>
>>   
>>   /**

-- 
Jani Nikula, Intel
