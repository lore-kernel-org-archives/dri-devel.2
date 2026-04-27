Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD0FF8869
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29E110E736;
	Mon, 27 Apr 2026 12:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l4gc7vjc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495BD10E2A1;
 Mon, 27 Apr 2026 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777294366; x=1808830366;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=cKopWZvomebPqmsCARn5BL5H+YMsyb+q0EKy+mD/Cbk=;
 b=l4gc7vjc0RXachU/gAiV8ZtP0zF0QLoyJhr+xNlO73c/2UidSriTYUWx
 edzg7kht6LDZMolQcGgyShZgwv/xjnCgHz08PyRGrIQkEgJP4YYqwBqaS
 IQx6vVK15yfFqUuqlbpNIxyEvWyHcrT87IcvGOx1nTXLA91zezRwF8ax6
 JkCzSFJOc6P1nhtuz6cIFTDv3xUtWB+UVEW4oVaYSUa34hWOzb+5QFBv0
 l2Sf48cbhvc+fIFRJZK8MBMCKxw+EyHBdVzA0pT2GOupiOgMu6JWUv1Az
 A5pY5LhM4A/ejGX3UXvW9P7WKJLrXiQrx4lkdgX67k6rjRAeC23S9XxPS g==;
X-CSE-ConnectionGUID: Lgc2k2UqR9m52Dm6zuuIRw==
X-CSE-MsgGUID: f/+gwQdOR1mHh4zEhSr+JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="80755751"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="80755751"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:52:45 -0700
X-CSE-ConnectionGUID: /aihhA/ES26lJzgoAQA1fQ==
X-CSE-MsgGUID: ZJFnnbnxTdy/jMzpIGangg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="257155973"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.53])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:52:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Ankit
 Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH 5/7] drm/dp: Store coasting vtotal in struct
 drm_dp_as_sdp
In-Reply-To: <ae9Zzw8dEms2NODz@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260424093424.3060805-1-ankit.k.nautiyal@intel.com>
 <20260424093424.3060805-6-ankit.k.nautiyal@intel.com>
 <ae9Zzw8dEms2NODz@intel.com>
Date: Mon, 27 Apr 2026 15:52:41 +0300
Message-ID: <7fea9950f85c0316c6d784048fd6c461a6ba4432@intel.com>
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

On Mon, 27 Apr 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Apr 24, 2026 at 03:04:22PM +0530, Ankit Nautiyal wrote:
>> Add new field in struct drm_dp_as_sdp to store coasting vtotal.
>> This is used by the sinks that support Panel Replay and Asynchronous
>> timing during PR Active to derive refresh rate, when AS SDP transmission
>> is stopped by the source.
>>=20
>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> ---
>>  drivers/gpu/drm/display/drm_dp_helper.c | 1 +
>>  include/drm/display/drm_dp_helper.h     | 1 +
>>  2 files changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/d=
isplay/drm_dp_helper.c
>> index a697cc227e28..e29958f8b0b6 100644
>> --- a/drivers/gpu/drm/display/drm_dp_helper.c
>> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
>> @@ -3512,6 +3512,7 @@ void drm_dp_as_sdp_log(struct drm_printer *p, cons=
t struct drm_dp_as_sdp *as_sdp
>>  	drm_printf(p, "    duration_incr_ms: %d\n", as_sdp->duration_incr_ms);
>>  	drm_printf(p, "    duration_decr_ms: %d\n", as_sdp->duration_decr_ms);
>>  	drm_printf(p, "    operation_mode: %d\n", as_sdp->mode);
>> +	drm_printf(p, "    coasting vtotal: %d\n", as_sdp->coasting_vtotal);
>
> For some reason the existing fields are using '_', this one ' '.
> Looks like VSC uses ' ' as well. So the existing stuff in
> drm_dp_as_sdp_log() should be fixed to conform to the common=20
> style, in a separate patch.

The indentation should be switched to tabs, and should be done using
drm_printf_indent() which keeps the format strings readable.

Can be done in follow-up.

BR,
Jani.


>
> Otherwise this looks fine
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
>>  }
>>  EXPORT_SYMBOL(drm_dp_as_sdp_log);
>>=20=20
>> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/d=
rm_dp_helper.h
>> index 1d0acd58f486..8c2d77a032f0 100644
>> --- a/include/drm/display/drm_dp_helper.h
>> +++ b/include/drm/display/drm_dp_helper.h
>> @@ -126,6 +126,7 @@ struct drm_dp_as_sdp {
>>  	int duration_decr_ms;
>>  	bool target_rr_divider;
>>  	enum operation_mode mode;
>> +	int coasting_vtotal;
>>  };
>>=20=20
>>  void drm_dp_as_sdp_log(struct drm_printer *p,
>> --=20
>> 2.45.2

--=20
Jani Nikula, Intel
