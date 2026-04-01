Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD381D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C17F10EF27;
	Wed,  1 Apr 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j9+VaA27";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8152610EEE6;
 Wed,  1 Apr 2026 07:19:12 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4flxDr672gz9v1S;
 Wed,  1 Apr 2026 09:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775027948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MoZx0+6r3lEgmSYd2yXiXTewxwJTlp6HCOQcm1GEvTw=;
 b=j9+VaA27dzHbz334XMdTbjmvxUYEIObdr69sl1r3svGAurEx+pK//vcO5biFjOYfkVUVe8
 dgpRSE6vzQ/oNUbx2vEeZGduYSIdifzm/Tc24r9yEFEOQXQmXMx41MVb6U3rJ6NxPZti8Z
 nVey4vUcQCahSPaxKNHiuk8Xx5TkAGZibb2omKNOMimKXTfxrIPDZSRH8glemsR9UGCiF8
 YLY88MtjoojaUnhBgcULBF3S58fRQQyfRh/e97AcqkKbR2k1EiSFsiPK9CiBECBeUCvgBT
 WAuL4DpKZodij1sr0Lgamg6/mbyCMaSM9JC+HI4YxF7vHbDLk5b/Qx0sCeM9Ng==
Message-ID: <bd35cba1-655a-4e44-bd1a-17b43162a462@mailbox.org>
Date: Wed, 1 Apr 2026 09:19:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Harry Wentland <harry.wentland@amd.com>,
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
 <97777bb6-6b5d-4a5e-aa33-ffb2c6e7baad@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <97777bb6-6b5d-4a5e-aa33-ffb2c6e7baad@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: smxb9xwdrqxjj4rd3raymdasqi8z6os1
X-MBO-RS-ID: 1226629d2263e717162
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

On 3/31/26 21:51, Harry Wentland wrote:
> On 2026-03-31 03:16, Michel Dänzer wrote:
>> On 3/30/26 19:36, Harry Wentland wrote:
>>> On 2026-03-30 12:20, Michel Dänzer wrote:
>>>> On 3/24/26 20:20, Mario Kleiner wrote:
>>>>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>>>
>>>>>>     I believe we don't have surface info in that code, but one way to work around it would be to use spatial dithering for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spatial, some of the earlier complaints about 10-bit output having one-off bit errors will be coming back.
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
>>
> 
> True, but if, for example, the input is 8bpc then the intermediate
> representation won't be able to add additional precision.

Why not? (See below)


> I guess if there are color operations on top of the 8bpc content
> then the values might be shifted in such a way that outputting
> or dithered 8pbc will be a better representation than 8bpc rounded
> values.

Exactly. The colour pipeline can produce arbitrary output values up to the precision limits of the KMS API / HW internal pipeline, independent from the framebuffer formats. I.e. the output values can have more significant bits than the framebuffer formats.

Therefore, basing the dithering on/off decision on the framebuffer format makes no sense.

A less bad solution would be to disable dithering if the output bpc is >= (or ==) 10.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
