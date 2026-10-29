Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E30606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=af1EHBsg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B52112111;
	Thu, 29 Oct 2026 09:21:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9984710E4A3;
 Thu, 29 Oct 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793265697; x=1824801697;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=+bpb/8kPIVNwRKvdj/29TyIe1DPVEf5uWH63MxBSu2M=;
 b=af1EHBsgsBSXRKVjOa0BsV98anVD6rbDEue1hieOU1Rbd/ngmlNxxILO
 KDR5zFHR6Ep/c+LnWBSzql0pP70ucyVLLWNfgVNb0S1tnAf8G8sz3gJe2
 dQgd8XiiFlRxuRqdTkB0PXFPd9klIpaJtBauzEKYNdV0VjBDuwDpHnxh/
 eDsVguRE3S+LKIeqUHDzJy7hp+BZizK+mtebdHV4nAgaFT/cDlu/PL/SF
 zJsIbf07hRnl3oZJ2lRpNXno1CK+YcOQA+0pc8Eg0HuWQ3fat8+ghyi2H
 ugfPUgr5mUZ9su5685MG9oFxSWxGVpwaw6sabiUQpzKD6LOwb6TdvyUcz g==;
X-CSE-ConnectionGUID: RjEl/lIPSIiy7fNORBbi8g==
X-CSE-MsgGUID: TBkjgOznTBWiOL8eDobJwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1886267"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1886267"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 02:21:36 -0700
X-CSE-ConnectionGUID: 1lluCUtBT2+pODh0CfA0Lw==
X-CSE-MsgGUID: JZUywEd0TAenJ/1+NKOZuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5222047"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.74])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 02:21:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmitry Malovanyy <dmitrymalovanyy@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Harry
 Wentland <harry.wentland@amd.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm/dp: Keep base enhanced framing cap from extended
 DPCD caps
In-Reply-To: <CAKCCmHOLiSkBp0kTy128it5znRpQ4yS_MOohZOq38T0TF3RFmQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261028162941.62762-1-dmitrymalovanyy@gmail.com>
 <77b574384ed695f8ea06a2ed142907e7d5f118d6@intel.com>
 <CAKCCmHOLiSkBp0kTy128it5znRpQ4yS_MOohZOq38T0TF3RFmQ@mail.gmail.com>
Date: Thu, 29 Oct 2026 11:21:29 +0200
Message-ID: <ad139110db6e7c4017a908ca76246646f84a8f0c@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Dmitry Malovanyy <dmitrymalovanyy@gmail.com> wrote:
> On Wed, 28 Oct 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> Additionally, a DPRX with DPCD r1.2+ must indicate support for enhanced
>> framing. The display is also in violation of the spec.
>>
>> That said, the spec kind of says to use enhanced framing for DPRX with
>> DPCD r1.2+. It's subtle, but it doesn't say check the capability
>> anymore, just the DPCD revision. That's my reading of DP v1.1a, v1.2a,
>> v1.3, v1.4a and v2.1a anyway.
>
> Thanks for the quick review!
>
> Yes, I checked DP 1.2 and it is there in 2.2.1.1, "An upstream device
> interoperating with a downstream device with DPCD Revision of 1.2 or
> higher must enable Enhanced Framing Mode". So doing it in
> drm_dp_enhanced_frame_cap() makes more sense, agree.
>
>> I think drm_dp_enhanced_frame_cap() should probably be:
>>
>> static inline bool
>> drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>> {
>>         return dpcd[DP_DPCD_REV] >= 0x12 || dpcd[DP_DPCD_REV] >= 0x11 &&
>>                 (dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
>> }
>>
>> And the remaining direct references to DP_ENHANCED_FRAME_CAP should be
>> migrated to use drm_dp_enhanced_frame_cap().
>
> Will do it in v2. I will add parens around the && part, otherwise gcc
> complains with -Wparentheses.

Another alternative is to have:

	/* brief comment explaining the reason with spec reference */
	if (dpcd[DP_DPCD_REV] >= 0x12)
		return true;

Up to you.

> For the direct users I found cdns-mhdp8546, it6505 and gma500, I will
> convert them into separate patches.

Separate patches is the way to go, thanks.

> There is also nouveau, dispnv50/disp.c checks the bit for the watermark
> calculation, but the actual enable is in nvkm/engine/disp/dp.c with its
> own definition. If I change only disp.c they will not agree with each
> other. Should I convert both, or leave nouveau out for now?

I'm afraid I can't speak for nouveau. I've Cc'd the maintainers.

In general, I think choose an approach, mention it in the commit
message(s) and why you think it makes sense, and you'll hopefully get
told that's cool or the maintainers want it changed. People generally
react better to code, right or wrong, than hypotheticals.


BR,
Jani.


> drm_dp_get_phy_test_pattern() also uses DP_ENHANCED_FRAME_CAP but there
> it is the DP_TEST_LANE_COUNT register, so I would leave it as is.
>
>> One of the main reasons I don't like this is that we have the logging
>> for the base and extended caps, and this sneaks in a change without it
>> being present in the logs.
>
> Makes sense, I didn't think about the logs.
>
> Thanks,
> Dmytro
>
> On Wed, 28 Oct 2026 at 18:24, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>> On Wed, 28 Oct 2026, Dmytro Malovanyi <dmitrymalovanyy@gmail.com> wrote:
>> > Some sinks set DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT and advertise
>> > DP_ENHANCED_FRAME_CAP in the base receiver caps, but clear it in the
>> > extended receiver caps at 0x2200. drm_dp_read_extended_dpcd_caps()
>> > replaces the base caps with the extended ones, so the link is trained
>> > without enhanced framing.
>> >
>> > The Xiaomi Monitor A24i (P24FBA-RAGL) is one such sink:
>> >
>> >   base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
>> >   extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81
>> >
>> > Without enhanced framing all lanes train (0x202-0x204: 77 77 81), but
>> > the sink never syncs to the stream (SINK_STATUS 0x205: 00) and shows
>> > "No signal" until it is power cycled. The same monitor works on macOS.
>> >
>> > DP 1.4 section 2.9.3.1, as quoted in the commit that added extended
>> > caps support, says the extended caps match the base caps except for
>> > DPCD_REV, MAX_LINK_RATE and DOWN_STREAM_PORT_PRESENT. Keep the base
>> > value of DP_ENHANCED_FRAME_CAP.
>>
>> Thanks for the patch and explanation, refreshing clarity.
>>
>> The display is obviously being silly.
>>
>> Additionally, a DPRX with DPCD r1.2+ must indicate support for enhanced
>> framing. The display is also in violation of the spec.
>>
>> That said, the spec kind of says to use enhanced framing for DPRX with
>> DPCD r1.2+. It's subtle, but it doesn't say check the capability
>> anymore, just the DPCD revision. That's my reading of DP v1.1a, v1.2a,
>> v1.3, v1.4a and v2.1a anyway.
>>
>> So I guess that might be the more appropriate fix, really. Even if it's
>> slightly more work.
>>
>> I think drm_dp_enhanced_frame_cap() should probably be:
>>
>> static inline bool
>> drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>> {
>>         return dpcd[DP_DPCD_REV] >= 0x12 || dpcd[DP_DPCD_REV] >= 0x11 &&
>>                 (dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
>> }
>>
>> And the remaining direct references to DP_ENHANCED_FRAME_CAP should be
>> migrated to use drm_dp_enhanced_frame_cap().
>>
>> > With this change the link uses enhanced framing (0x101: 84) and the
>> > sink syncs (0x205: 03).
>> >
>> > Tested on i915 (Arrow Lake-U) through a USB4 dock.
>> >
>> > Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT")
>> > Cc: stable@vger.kernel.org
>> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
>> > Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
>> > ---
>> >  drivers/gpu/drm/display/drm_dp_helper.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
>> > index e623ccb4c..205b6cc89 100644
>> > --- a/drivers/gpu/drm/display/drm_dp_helper.c
>> > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
>> > @@ -1219,6 +1219,9 @@ static int drm_dp_read_extended_dpcd_caps(struct drm_dp_aux *aux,
>> >
>> >       drm_dbg_kms(aux->drm_dev, "%s: Base DPCD: %*ph\n", aux->name, DP_RECEIVER_CAP_SIZE, dpcd);
>> >
>> > +     /* Keep the base enhanced framing cap if the extended caps drop it */
>> > +     dpcd_ext[DP_MAX_LANE_COUNT] |= dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP;
>>
>> One of the main reasons I don't like this is that we have the logging
>> for the base and extended caps, and this sneaks in a change without it
>> being present in the logs.
>>
>> And having the decision in drm_dp_enhanced_frame_cap() is explicit and
>> same for everyone.
>>
>> BR,
>> Jani.
>>
>> > +
>> >       memcpy(dpcd, dpcd_ext, sizeof(dpcd_ext));
>> >
>> >       return 0;
>> >
>> > base-commit: feaa32dc98090b2f45f7b6f179711a6640169c1a
>>
>> --
>> Jani Nikula, Intel

-- 
Jani Nikula, Intel
