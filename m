Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBD7C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D1F10E1B2;
	Tue, 30 Jun 2026 09:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y2ALFwmG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9323B10E1B2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782813488; x=1814349488;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=kOm2v0nC7noZvRg091VQlCT9kgOiGVUDlosx4XuzZnM=;
 b=Y2ALFwmGP5zr6fXbtkzKQOGeF5BJqIyNCXG5H7Z+G5MCsIqTUQF2DFbg
 FIUTwa0xMKhdr2HW++zpOpXVA6zSrnogdoXssJbqdwgwTJ5ovWOpIuu8O
 kZ4YzUUXic8Rrg8VqSUiI0qbuE+RC9Y9nF3wqXIkOlbONjec7LUYVZgvH
 4yuTbu7wUaRlMKChRYioN+lQAzPhqQj16bsCH5Ko643iMR/sXwkMF1Rgl
 B5xdKmL+iA5nGurmcdosmPCuKjjn7uXOKq8iybaRjBNL0SMLygvJ7ZRKM
 76H1M2U8sBikaec4RMuIu6ETNPSdOroIlOV6SV/pSox057VYv4Gqy7llj A==;
X-CSE-ConnectionGUID: 9OIYt9iYQFOZSW5Va+oNlA==
X-CSE-MsgGUID: yReHhkOjQtOqOnUVs3JoPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94174650"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94174650"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:58:08 -0700
X-CSE-ConnectionGUID: UywBQZDUSdKBc7i5QuBMgw==
X-CSE-MsgGUID: 2Mh1JB+ATYSPVv1t9VjgiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="276499316"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:58:07 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/dp: fix kernel-doc for struct drm_dp_vsc_sdp
In-Reply-To: <73daef55-2f45-4cd5-9de6-7398e86d4f78@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260615153027.1899784-1-jani.nikula@intel.com>
 <73daef55-2f45-4cd5-9de6-7398e86d4f78@suse.de>
Date: Tue, 30 Jun 2026 12:58:04 +0300
Message-ID: <a069720e1850a401e9c54ad518d4e07c6dd915a4@intel.com>
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
>> Add the missing coasting_vtotal kernel-doc member documentation for
>> struct drm_dp_vsc_sdp.
>>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> With the title fixed as mentioned by Sashiko:
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, pushed to drm-misc-fixes with the commit message fixed.

BR,
Jani.

>
>> ---
>>   include/drm/display/drm_dp_helper.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
>> index 8c2d77a032f0..ab16c1be3900 100644
>> --- a/include/drm/display/drm_dp_helper.h
>> +++ b/include/drm/display/drm_dp_helper.h
>> @@ -115,6 +115,7 @@ struct drm_dp_vsc_sdp {
>>    * @duration_decr_ms: Successive frame duration decrease
>>    * @target_rr_divider: Target refresh rate divider
>>    * @mode: Adaptive Sync Operation Mode
>> + * @coasting_vtotal: Coasting vtotal
>>    */
>>   struct drm_dp_as_sdp {
>>   	unsigned char sdp_type;

-- 
Jani Nikula, Intel
