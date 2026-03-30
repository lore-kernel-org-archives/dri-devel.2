Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D203F1061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3949910E55A;
	Mon, 30 Mar 2026 16:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kZQHSbzM";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFA010E551;
 Mon, 30 Mar 2026 16:20:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fkxLN5X6cz9tWZ;
 Mon, 30 Mar 2026 18:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774887628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGHWTp8Y8n5iIuBQWmeBw2WomMZFnpot7EGjAbvxZZg=;
 b=kZQHSbzMxcZEBVraC7wNyeGyvGMH0CKq+HR88FO2PPeNyzOrG1RDi5CEZ6D57JkJ6m//nf
 89T85qMXvDtztRstwZJgZG0fCMLh8vb5+0hmH++Nw7dNaSVzrF6CanVnENU9+mCPR4hMCb
 MCDE+NCW43vlLDspIbcpFk3ZxWTPL2XoVCXGFBCx6UmAg31CYgBsz2DSxK04In85KeZUMM
 5iMdhl8JQRLRY5HVl4DiEzr7m+1TbrGw3rpYqUK15Vox39XBhhz+9tef6vjoJktL2Z0Lim
 5uayT0qEmY/m2yL1OTZ+5U0PZtVofZJQ4WGjtY/HWcNdUIp4xNm/yEQFWEn1zw==
Message-ID: <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
Date: Mon, 30 Mar 2026 18:20:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: yssdoj7ukujx6kfpaee7bstmr3ibqofa
X-MBO-RS-ID: 892335e59719b1c4ce2
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

On 3/24/26 20:20, Mario Kleiner wrote:
> On Sun, Mar 22, 2026 at 7:11=E2=80=AFPM Kovac, Krunoslav <Krunoslav.Kov=
ac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>=20
>>     There is a reason for the change that is alluded in the commit, bu=
t perhaps I should've been clearer.
>>     If you have an ARGB2101010 surface and monitor is 10bpc, one of th=
e HW design goals is that we can output this in a bit-perfect way, i.e., =
for every surface pixel value K=3D0..1023, monitor will receive K at its =
end. It's also one of the things some customers have checked for and comp=
lained about historically. This is very hard to see visually or even with=
 a colorimeter but is readily apparent with a HW capture card.
>>=20
>>     Our HW can accomplish this 10-bit perfect requirement if set up co=
rrectly, however, it can only do so if we use rounding, not dithering.
>>     For example, say you have a 10-bit code 200, our pipeline precisio=
n and error accumulation may result with 200.15, which in 12bpc before di=
thering would be 801 and the nature of the spatial dithering is that now =
and then RNG result will push that to 201 output, it's just the way it wo=
rks. Rounding is several times less sensitive to this, and without this r=
andomness component, we can verify we're always accurate enough at 10bpc =
level.
>=20
> Ok, that makes a lot more sense. I can understand that. My own software=
 and users have the same critical requirement for some use cases, of bein=
g able to pass through ARGB8888 surfaces to 8 bpc video sinks. They conne=
ct special neuroscience display equipment that parses special binary cont=
rol information out of false-color coded framebuffer images, or implement=
s very high color precision display up to 16 bpc per color channel on top=
 of 8 bpc framebuffers and some shader magic. Luckily, using a standard 8=
 bpc framebuffer under the native X-Server, a 8 bpc DVI-D or DP video sin=
k, and loading a specifically crafted gamma table achieved this for our c=
ase, despite the spatial dithering-down-to-8bpc being active. DC has some=
 special detection function (__is_lut_linear() in amdgpu_dm_color.c) that=
 detects if a user provided gamma lut is essentially meant to be a linear=
 identity mapping lut, and if so, enables lut bypass or identity mapping =
iirc, and that does the trick well enough for us atm.

Sounds like passthrough of 10 bpc values should work fine with your patch=
 thanks to this bypass / identity mapping, doesn't it?


> I haven't tested this yet under Wayland, as the Wayland eco system=C2=A0=
is not ready for the more demanding use cases, [...]

Are there issues describing those use cases?


>>     I believe we don't have surface info in that code, but one way to =
work around it would be to use spatial dithering for FP16/ARGB16 and roun=
ding for 10 bits. But if we just switch to spatial, some of the earlier c=
omplaints about 10-bit output having one-off bit errors will be coming ba=
ck.
>=20
> Looking at all callers of=C2=A0resource_build_bit_depth_reduction_param=
s(), they all have access to the associated "struct pipe_ctx", which shou=
ld give access to pipe_ctx ->plane_state->format of an associated display=
 plane. I could prepare a patch that passes the pipe_ctx from each caller=
 into=C2=A0resource_build_bit_depth_reduction_params() and that function =
could check if a 16 bpc framebuffer is in use and switch to spatial dithe=
ring down-to-10-bpc in this case, and leave the rounding/truncation to 10=
 bpc otherwise.

That doesn't really make sense, the output of the display HW colour pipel=
ine has more than 10 bpc regardless of framebuffer format.


> This workaround, that you also propose, would be the least bad of all b=
ad solutions.

Seems pretty bad to me, mixing up things which aren't directly related.


--=20
Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
https://redhat.com             \               Libre software enthusiast
