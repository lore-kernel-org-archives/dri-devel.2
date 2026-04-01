Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED43D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3610E012;
	Wed,  1 Apr 2026 07:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NANxtKxI";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B0610EC41;
 Wed,  1 Apr 2026 07:21:15 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4flxHF024Dz9vHh;
 Wed,  1 Apr 2026 09:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775028073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4PvnxpPnHOmlcrrhZxxZgYFj4bboTrHbCV8WTruEMg=;
 b=NANxtKxIxsL5imxavspRKiPTf+3ONiA3lNepxY9jILCKeeHo2LWCaE3EsDNXAzZjTTpYBc
 HL64PfCX8c9kyOC/9EpIhGLUBmdNV+Cl3UCSDaJeKeTl6mHAya5CW6HTT6MDrilOHFjK11
 ur6pt9HkdazUwO1rLGfmVaBHdi6+AeGPVqYOVGG8HxzMwbzx94SxwqpZkU+Q57DejvRIFk
 dduVwchBOikCueZtQ1g/TtZBx20njwByLmCCw79zxn33l7m48Q3rkgr4KnFBPON71XvJ/5
 3mFPKCM+I91zWQdzwlYjRI6gNMpbJRzUKeSJhVVGd34ioCZx3nhJj6lOgCiVBQ==
Message-ID: <713ee2f4-ad7f-4e07-be87-17a638c8b69e@mailbox.org>
Date: Wed, 1 Apr 2026 09:21:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: "Kovac, Krunoslav" <kkovac@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
 <acabf03c-aad6-47b1-9f91-e6ea8e710636@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <acabf03c-aad6-47b1-9f91-e6ea8e710636@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ny4r8j3q1k5rrcq954o8ax96ja5mcydj
X-MBO-RS-ID: 04e6f52a62c4c292cdf
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

On 3/31/26 21:57, Kovac, Krunoslav wrote:
> On 3/31/2026 03:16, Michel Dänzer wrote:
>> On 3/30/26 19:36, Harry Wentland wrote:
>>> On 2026-03-30 12:20, Michel Dänzer wrote:
>>>> On 3/24/26 20:20, Mario Kleiner wrote:
>>>>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>>>
>>>>>>      I believe we don't have surface info in that code, but one way to work around it would be to use spatial dithering for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spatial, some of the earlier complaints about 10-bit output having one-off bit errors will be coming back.
>>>>>
>>>>> Looking at all callers of resource_build_bit_depth_reduction_params(), they all have access to the associated "struct pipe_ctx", which should give access to pipe_ctx ->plane_state->format of an associated display plane. I could prepare a patch that passes the pipe_ctx from each caller into resource_build_bit_depth_reduction_params() and that function could check if a 16 bpc framebuffer is in use and switch to spatial dithering down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc otherwise.
>>>>
>>>> That doesn't really make sense, the output of the display HW colour pipeline has more than 10 bpc regardless of framebuffer format.
>>>>
>>>
>>> The output will be determined by the link bandwidth, display-advertised supported bpc, and userspace-selected "max bpc" on a drm_connector. This could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the internal DCN HW representation of the values?
>>
>> I am indeed.
>>
>>> They're higher, but that's somewhat irrelevant.
>>
>> How so? Surely dithering is applied to those values, not to the original values sampled from the framebuffer. 
> 
> Our internal precision is higher than 12, but since we first "trim" to 12bpc and then dither to 10bpc, bypass case is actually ok in practice even with dithering.
> 
> Normally for this case where we want 10bpc to go out as-is we would put HW color pipeline blocks to bypass. There are some exceptions however, and unfortunately one of them is not that uncommon. It's the multi-plane case where linear blending is desired, which is the norm for HDR. In this case, we do degamma, blend, regamma.

That's not "passthrough" by definition, so maybe the expectation that 10 bpc framebuffer values get through the pipeline unmodified just isn't realistic.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
