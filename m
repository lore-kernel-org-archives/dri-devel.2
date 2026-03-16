Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D71F46456
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4AE10E324;
	Mon, 16 Mar 2026 11:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V5A/IBan";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071CC10E261
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773661110; x=1805197110;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=+R6gKdN94J8gAlUgGk+V1A9HkdVF8gpG1K0Cax4/Y0w=;
 b=V5A/IBaniUaTIAIrPjtmRbSjB71wEQT2oFvsyzLuk5e3gXI6HA1TXw4m
 Se0wAA9LoHEGfB8q0Hd4SP6qAIzxyX6Ra/N2oNjSxVCwUA1Lh+1XGGRf8
 QfIYX48c8NkXu78SVlTC48u/0kD8udL6OZ+mNpqP8GGDVLut5fikAPMKB
 2ZN+zFMcIjFVuZTMfBBfIuvBY8FFYPn1mRToVKZLjyKbM/gZS1vqMfzA2
 zpHIpenUfX1tLr6HbDhUXA5WdoDl+gtR7H3u7AlBAjnK/QEdbNM289wIm
 lHugQ6qDEdWdx8Wh16Sz9+2VRxtoZb6pAila8tBMtv7w3QKP4zLdBwb9X w==;
X-CSE-ConnectionGUID: CE8lcSPqScy0v1hCrNiPjg==
X-CSE-MsgGUID: RGJ7ecacTKaJ0kknaWO8wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74591258"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74591258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:38:29 -0700
X-CSE-ConnectionGUID: B5rwkWNARhqGLnnb8/lkgw==
X-CSE-MsgGUID: Dd2TWJwGR1WJ+oRLVEh7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="217728754"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.238])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:38:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jammy Huang
 <jammy_huang@aspeedtech.com>, Dave Airlie <airlied@redhat.com>, Jocelyn
 Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
In-Reply-To: <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
Date: Mon, 16 Mar 2026 13:38:22 +0200
Message-ID: <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
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

On Mon, 16 Mar 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi Jammy
>
> Am 13.03.26 um 11:04 schrieb Jammy Huang:
>> DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
>> edid block 0 and 1.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
>> blocks fetched can be 0 and 1.
>> ---
>>   drivers/gpu/drm/ast/ast_dp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
>> index 9d07dad358c..c938e1d6b1d 100644
>> --- a/drivers/gpu/drm/ast/ast_dp.c
>> +++ b/drivers/gpu/drm/ast/ast_dp.c
>> @@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *b=
uf, unsigned int block, si
>>   	int ret =3D 0;
>>   	unsigned int i;
>>=20=20=20
>> -	if (block > 0)
>> +	if (block > 1)
>>   		return -EIO; /* extension headers not supported */
>
> But see the code at [1]. It clears the number of extensions to zero and=20
> updates the checksum accordingly. This is required to make the shortened=
=20
> EDID work with DRM. If you leave this as-is, it will still clear support=
=20
> for any extension in block 1.
>
> See the table 2.4 in the VESA EDID 1.4 standard for the semantics. For=20
> 1.3, if the number of blocks is >2, the first extensions is a 'block map=
=20
> of the extensions'. This is useless, as it's not a data extension in=20
> itself.=C2=A0 In 1.4, the block map is optional. That code should clear t=
he=20
> EDID's number of extensions to 0 or 1, depending on whether there is a=20
> block map to be expected.

I think long-term the goal should be for the kernel to not modify the
EDID, at all.

BR,
Jani.


>
> Best regards
> Thomas
>
> [1]=20
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/ast/ast_d=
p.c#L157
>
>>=20=20=20
>>   	/*
>>
>> ---
>> base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
>> change-id: 20260313-upstream_ast_dp_edid-5fe6adf7ad36
>>
>> Best regards,

--=20
Jani Nikula, Intel
