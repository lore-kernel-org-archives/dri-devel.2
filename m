Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E952C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B8410E791;
	Mon, 29 Jun 2026 08:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HSPKGcnr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DF210E785;
 Mon, 29 Jun 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782723423; x=1814259423;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=wtzhexgYu/GiWMolnu8lXfeDieCTDoNiL+kBDBrK4ig=;
 b=HSPKGcnrrcbYdHdhD/d+5KFXumgVF2n1QuDNlwVzB7LfTzkNdrJD1x/d
 RVFpRHzzP1q1bjAq/8FKjspHBjH5iP7nbRqtE87RAeCeLqv/mLL/b2ZNe
 lc4aJ12qZpyWfD+4mw5AJ3c7lynY46em0qqWfsAvqKbiu8nAF6cGopRm9
 EYj450nfL1LPkk0WwL8AcCz47GFWkXoiQ2ZldIz1EwTieSQKzE1he0zV5
 VBTm2jYkrR1tcuQH0qKDHBJ/V5hR0vE7H/tGjr8X88PwwQLmDEPDhL33f
 nFkhal2J9hK0BTag6rArTixVDTA/wwVXxTGURI93pf2AT+uL5oO8aqF+W A==;
X-CSE-ConnectionGUID: 7Ab0iPy5SFqh3YqPl1NnlA==
X-CSE-MsgGUID: eBnVXZceRBq1l8QYpVBRnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83605584"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="83605584"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:57:03 -0700
X-CSE-ConnectionGUID: b23/RaZMRS26psfuHBE/LA==
X-CSE-MsgGUID: flC0TqmrQD+p/7xG0cI3cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="251514805"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.253])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 01:57:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, Alexander Kaplan
 <alexander.kaplan@sms-medipool.de>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Imre
 Deak <imre.deak@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2] drm/dp: Read the PCON max FRL bandwidth only for
 HDMI DFPs
In-Reply-To: <2a22b3bf-5dcd-4163-aab9-a3471da24b50@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260610193825.2933-1-alexander.kaplan@sms-medipool.de>
 <2a22b3bf-5dcd-4163-aab9-a3471da24b50@intel.com>
Date: Mon, 29 Jun 2026 11:56:36 +0300
Message-ID: <6cf1f0d9b46070901b96a96ba10a11a3be108f68@intel.com>
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

On Mon, 29 Jun 2026, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> On 6/11/2026 1:08 AM, Alexander Kaplan wrote:
>> The PCON max FRL bandwidth field lives in byte 2 of the DFP Detailed
>> Capability Info (DPCD 0x82 for the first DFP).
>> The DP standard defines the meaning of descriptor bytes 1-3 strictly
>> per DFP type, and for a DisplayPort type DFP all of them are
>> reserved, with "read all 0s" semantics (DP v2.0, section 2.12.3,
>> Table 2-183).
>> The FRL bandwidth field is an HDMI DFP extension added by the VESA
>> DP-to-HDMI PCON specification.
>> drm_dp_get_pcon_max_frl_bw() however parses the byte without checking
>> the DFP type, the branch presence or DETAILED_CAP_INFO_AVAILABLE.
>> Without the latter the port descriptors are one byte wide and
>> port_cap[2] is not even the right register.
>>
>> All neighbouring helpers parsing the same descriptor are scoped by
>> the DFP type already, see for instance drm_dp_downstream_max_bpc()
>> reading the same byte and returning 0 for a DP type DFP.
>> amdgpu's DC parses the field only for HDMI(/DP++) detailed types as
>> well.
>>
>> This is not theoretical.
>> A Synaptics VMM7100 based USB-C to HDMI adapter with a macOS targeted
>> firmware advertises a DisplayPort type DFP with the type byte
>> replicated across the whole descriptor (08 08 08 08).
>> i915 decodes that as "PCON limited to 18 Gbps FRL" and prunes every
>> mode above ~750 MHz dotclock, including all the 4k@100/120 modes the
>> sink EDID offers, while macOS drives 4k@120 through the same adapter
>> just fine via DP DSC (and amdgpu's type-scoped parser would ignore
>> the bogus field as well).
>>
>> Only parse the field for an HDMI DFP behind a DPCD 1.1+ branch
>> device that reports detailed cap info, matching the type-scoped
>> field layout of the spec and the rest of the helpers.
>>
>> Fixes: ce32a6239de6 ("drm/dp_helper: Add Helpers for FRL Link Training support for DP-HDMI2.1 PCON")
>> Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
>> ---
>> v2: add an explicit DPCD_REV check like the neighbouring helpers
>>      have (Ville)
>> v1: https://lore.kernel.org/r/20260610174819.6258-1-alexander.kaplan@sms-medipool.de
>>
>> This patch is part of a set of independent fixes for the USB-C to DP
>> to HDMI 2.1 protocol converter (PCON) path, found and verified on an
>> ASUS NUC 16 Pro (Panther Lake, xe) with Synaptics VMM7100 based
>> adapters.
>> Each part stands on its own and can be merged independently.
>> The other parts:
>> [1] https://lore.kernel.org/r/20260610174413.5881-1-alexander.kaplan@sms-medipool.de
>> [2] https://lore.kernel.org/r/20260610174807.6231-1-alexander.kaplan@sms-medipool.de
>>   drivers/gpu/drm/display/drm_dp_helper.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
>> index 9c31e14cc413..e623ccb4c1d8 100644
>> --- a/drivers/gpu/drm/display/drm_dp_helper.c
>> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
>> @@ -3686,6 +3686,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>>   	int bw;
>>   	u8 buf;
>>   
>> +	if (!drm_dp_is_branch(dpcd))
>> +		return 0;
>> +
>> +	if (dpcd[DP_DPCD_REV] < 0x11)
>> +		return 0;
>> +
>> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
>> +		return 0;
>> +
>> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) != DP_DS_PORT_TYPE_HDMI)
>> +		return 0;
>> +
>
> This is the right thing to do. These come under Additional HDMI Link 
> Capability in the spec, so this needs a check for HDMI DFP.
>
> Thanks for the fix.
>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

I kicked CI to let this through. Please wait for the results before
merging. Thanks.

>
>
>
>>   	buf = port_cap[2];
>>   	bw = buf & DP_PCON_MAX_FRL_BW;
>>   

-- 
Jani Nikula, Intel
