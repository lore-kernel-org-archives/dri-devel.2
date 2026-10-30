Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aa+n9PXJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA7711276B;
	Fri, 30 Oct 2026 11:36:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8542A10E8A4;
 Fri, 30 Oct 2026 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793360200; x=1824896200;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=aadIw4rhulzpa6Y/ZdQ+M80PL9e0mgGB24qkPVmslLE=;
 b=Aa+n9PXJza882rwIYAPcQ2N9oVgbsrZcR8vz7xof4y8jrlVLVCnPYhXf
 uAaffLWa+CfL4VHSgGxPeBxRWOGukgge/japOwATIqVLAVIQn2+MLwG7F
 QwzxnC98pZZ+Jr33QF0/b8wt0Sau9egdltc8y5pWmXYRZ9sBejKc5Q4rd
 oKla2IjYUEouabzLcwypuRdZ2FDJLWmGU9T9Fz3hoc5kbLDeVS6T0ry/Z
 b4AfHInMtrzRMfpqgxVeEwZb9bp9X7FvBbN0vM5/+P2NjMvveFY1WGYzW
 9KxQcAACoNv5MgGKGk6XyQ/sdxliUvsbtiFvJ/7/J6ReZG0BZ6HgoyTLG Q==;
X-CSE-ConnectionGUID: 9A8/9VtrTUaY3a2GERuTwg==
X-CSE-MsgGUID: uIPjfiIhQkeWwoZEK0ZaKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2115253"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2115253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:36:39 -0700
X-CSE-ConnectionGUID: g+orv7JlT+urDFKI9tyaUA==
X-CSE-MsgGUID: xJVcYvSyRoGD2TgzkWSP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5509613"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:36:34 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Dmytro
 Malovanyi <dmitrymalovanyy@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Patrik Jakobsson
 <patrik.r.jakobsson@gmail.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drm/dp: Always use enhanced framing for DPCD r1.2+
In-Reply-To: <auR8R7G5S8hv5R0e@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-2-dmitrymalovanyy@gmail.com>
 <auR8R7G5S8hv5R0e@intel.com>
Date: Fri, 30 Oct 2026 13:36:31 +0200
Message-ID: <59106a36510e33e851f76c877f41952b11a8c774@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 30 Oct 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Thu, Oct 29, 2026 at 11:18:22AM +0100, Dmytro Malovanyi wrote:
>> DP 1.2 section 2.2.1.1 says "An upstream device interoperating with a
>> downstream device with DPCD Revision of 1.2 or higher must enable
>> Enhanced Framing Mode". So for r1.2+ the DPCD revision is enough, the
>> DP_ENHANCED_FRAME_CAP bit does not need to be checked.
>>=20
>> Some sinks get this bit wrong. The Xiaomi Monitor A24i (P24FBA-RAGL)
>> sets it in the base receiver caps, but clears it in the extended
>> receiver caps at 0x2200, which are the ones we use:
>>=20
>>   base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
>>   extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81
>>=20
>> Through a USB4 dock (CalDigit Element 5) the link trains without
>> enhanced framing (0x202-0x204: 77 77 81), but the sink never syncs to
>> the stream (SINK_STATUS 0x205: 00) and shows "No signal". Forcing RBR
>> does not change it. Connected directly to the laptop the same sink
>> syncs without enhanced framing, at RBR, HBR and HBR2.
>>=20
>> Make drm_dp_enhanced_frame_cap() return true for DPCD r1.2+. This
>> changes behaviour for every driver using the helper, but only for sinks
>> which already violate the spec by not setting the bit.
>>=20
>> Tested on i915 (Arrow Lake-U), with the dock the link now uses enhanced
>> framing (0x101: 84) and the sink syncs (0x205: 03).
>>=20
>> Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_F=
IELD_PRESENT")
>> Cc: stable@vger.kernel.org
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
>> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
>> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
>> ---
>>  include/drm/display/drm_dp_helper.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/d=
rm_dp_helper.h
>> index 5b05a7fbe..4f20f60db 100644
>> --- a/include/drm/display/drm_dp_helper.h
>> +++ b/include/drm/display/drm_dp_helper.h
>> @@ -160,6 +160,10 @@ drm_dp_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP=
_SIZE])
>>  static inline bool
>>  drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>>  {
>> +	/* DP 1.2 2.2.1.1: enhanced framing is mandatory for DPCD r1.2+ */
>
> DP_ENHANCED_FRAME_CAP is also mandatory so I think this needs
> a bit more detailed explanation.

Commit message not enough?

I think the wording in the specs suggest that with DPCD r1.2+ you should
just enable enhanced framing regardless of the cap.

BR,
Jani.

>
>> +	if (dpcd[DP_DPCD_REV] >=3D 0x12)
>> +		return true;
>> +
>>  	return dpcd[DP_DPCD_REV] >=3D 0x11 &&
>>  		(dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
>>  }
>> --=20
>> 2.50.1 (Apple Git-155)

--=20
Jani Nikula, Intel
