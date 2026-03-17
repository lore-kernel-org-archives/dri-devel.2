Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F3F33812
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4F910E59D;
	Tue, 17 Mar 2026 08:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dvtS/P1q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3FE10E59D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773736115; x=1805272115;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=RyEyZWlgRoJR+qedehkyL9nP/wYmPAVc+XgVhfvHdrY=;
 b=dvtS/P1qbN0Mc5MF8SioxFPpAqgPhKOhUvmSfg4C18YjPO8hTrGrZWcM
 KAW3iftWlGZD5VpExWuWMf1+XTxH3B3e1+BvZPf6VzH6AjGg0lYoY57R9
 bP4XTzF7sCUQiWLZyoocIoojpldKRkrmq7C+IgRig7emimeCJkKxif5Zl
 oqufHYnQ+99KIcY7qnLgRmjzA2T9Hd2ZGnjoiVW0jpoRly7Pef0DAQlNr
 Y6WxS78riZlF5juvLCOBFsWlCXYcI3lbXUsXxad6KGNa52EQPgFwA0AZr
 V8r4rTIKra9mY4aoZs+GhdnkHSp5ZOAHWB0TT1wWcDHQfBv8LPPQNoFIK A==;
X-CSE-ConnectionGUID: fP0SajieQ7iWEkwi+Aq+fg==
X-CSE-MsgGUID: wX9D5vb1S+6CFXAZWHZPvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74795339"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74795339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:28:34 -0700
X-CSE-ConnectionGUID: Nc5HWpsCSjG1czo0fM73Eg==
X-CSE-MsgGUID: YLUR8khUTjWWamcEA4RNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="252689770"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:28:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas
 Zimmermann <tzimmermann@suse.de>
Cc: Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie
 <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
In-Reply-To: <abkM2-295MJO15ht@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
 <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
 <abj-J1yYsFymXmn5@intel.com>
 <7b91451a-7764-4822-b15b-47437592691f@suse.de>
 <abkM2-295MJO15ht@intel.com>
Date: Tue, 17 Mar 2026 10:28:26 +0200
Message-ID: <5c090a1cc9eb75eaacf2932241636bd12016df13@intel.com>
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

On Tue, 17 Mar 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Tue, Mar 17, 2026 at 08:41:35AM +0100, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 17.03.26 um 08:09 schrieb Ville Syrj=C3=A4l=C3=A4:
>> > On Mon, Mar 16, 2026 at 01:38:22PM +0200, Jani Nikula wrote:
>> >> On Mon, 16 Mar 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> >>> Hi Jammy
>> >>>
>> >>> Am 13.03.26 um 11:04 schrieb Jammy Huang:
>> >>>> DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
>> >>>> edid block 0 and 1.
>> >>>>
>> >>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> >>>> ---
>> >>>> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
>> >>>> blocks fetched can be 0 and 1.
>> >>>> ---
>> >>>>    drivers/gpu/drm/ast/ast_dp.c | 2 +-
>> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast=
_dp.c
>> >>>> index 9d07dad358c..c938e1d6b1d 100644
>> >>>> --- a/drivers/gpu/drm/ast/ast_dp.c
>> >>>> +++ b/drivers/gpu/drm/ast/ast_dp.c
>> >>>> @@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, =
u8 *buf, unsigned int block, si
>> >>>>    	int ret =3D 0;
>> >>>>    	unsigned int i;
>> >>>>=20=20=20=20
>> >>>> -	if (block > 0)
>> >>>> +	if (block > 1)
>> >>>>    		return -EIO; /* extension headers not supported */
>> >>> But see the code at [1]. It clears the number of extensions to zero =
and
>> >>> updates the checksum accordingly. This is required to make the short=
ened
>> >>> EDID work with DRM. If you leave this as-is, it will still clear sup=
port
>> >>> for any extension in block 1.
>> >>>
>> >>> See the table 2.4 in the VESA EDID 1.4 standard for the semantics. F=
or
>> >>> 1.3, if the number of blocks is >2, the first extensions is a 'block=
 map
>> >>> of the extensions'. This is useless, as it's not a data extension in
>> >>> itself.=C2=A0 In 1.4, the block map is optional. That code should cl=
ear the
>> >>> EDID's number of extensions to 0 or 1, depending on whether there is=
 a
>> >>> block map to be expected.
>> >> I think long-term the goal should be for the kernel to not modify the
>> >> EDID, at all.
>> > I think as a short term goal it would be much better if all EDID
>> > mangling would be done by drm_edid.c rather than individual drivers.
>>=20
>> We don't fix the EDID here, but work around a hardware limitation. I=20
>> guess we could fix this automatically near edid_block_read() [1] if the=
=20
>> driver clearly communicates this issue.=C2=A0 The read loop could then f=
ix=20
>> the header's checksum by itself.
>
> edid_filter_invalid_blocks() already has the code to update
> the extension block count and fix up the checksum.

I've been meaning to nuke edid_filter_invalid_blocks()...

It's a real problem that users report issues with EDID, attach the EDID
from sysfs, but it's not the actual EDID because the kernel modified it.

BR,
Jani.


>
> So seems to me all we'd need is some way for the driver to
> indicate it simply cannot read the requested block (based on
> which edid_read_block() would return some other value than
> EDID_BLOCK_READ_FAIL), and then the fixup happens naturally.
>
> Hmm. What happens if the driver returns "success" for the
> read, but just leaves the entire block zeroed? Looks to me
> like we should then end up with status=3D=3DEDID_BLOCK_ZERO
> and the block will get treated as invalid and filtered out.
>
>> Best regards
>> Thomas
>>=20
>> [1]=20
>> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid=
.c#L2424
>>=20
>> >
>>=20
>> --=20
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>>=20

--=20
Jani Nikula, Intel
