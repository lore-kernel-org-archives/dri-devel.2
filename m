Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDA5C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1707210F11E;
	Wed, 15 Jul 2026 20:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PA8YgNSn";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C3110E1AA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:12:09 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso3831648f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784146328; x=1784751128; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LINappzTtqOvEOGJ2/VoPfdVWpHlvhISScXV6/Tgz94=;
 b=PA8YgNSnAcIwpTCduPWLbEHMIRdIhRxS+exBOdHc8Nk1cLYhuh+W3RmtsLRevbSGwh
 qSaVc2HnaMyp1b08xlG6BcwO2neoRj0p5ijZIxdDGXIKd1TWBPwXjyuJZSsqUwK/fi9e
 U8F6VGna9tJsd1477sQzuaqE2Iv4/N7y53c6dhE+/zn2DNyNk0C56kBml23xvhy0D42Y
 +fsbO6ADNfi/nmxk21279tQiov3jTDZVxy9jJ6URnk8xguGaNqdqXIOog6sWRpHtH4XX
 gPWX82aCpldVvrMcvIZUk4iBHf0A0AGq6dxQA3DeDe8oiKlkJrlKK0SAEIFsgnDvViNn
 GLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784146328; x=1784751128;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LINappzTtqOvEOGJ2/VoPfdVWpHlvhISScXV6/Tgz94=;
 b=M3hAI2owkqsM41d31w1v0VDdE0xrObSGYDNqHfX5Zm5tFhia2/kHpbckVWxZzHgx+b
 n7aCtBFrk11PApzBT7nqU+960GmzDQwfatUlX+zoIQuEu3iHDGaRMXSZb1jt892gPXKt
 6MimzuKkYk8OftNjRiHQ8Fb0/KT9tdJCALc81OryaCoECHmYq9ocO6MyNb9CQTCFfHZ1
 WcaBe+E3jCVXMZuFf+F/6/h9800g3kXqM7A+Smwp4dCLnMWVjteMNpCFigm+z78EF1lt
 RoowAF4O3t9LXhqWm4ohIP93U1obKh/PNk2EsbR8PKuQNblO18thMt2oMr7bbvTgnU9c
 gAPg==
X-Gm-Message-State: AOJu0Yys2tmyYCTWs1Chxzf9dQpdgKpLhGbV8ZsT6JAr45Q7g8zcKBDN
 Qs7eJAD+ODxirNKxQpBHeg+VDHZB9hoWziEjsy7VMQ9eny/2+dZMxTa9DiyPmcOg
X-Gm-Gg: AfdE7clyHfYm7T8HqtCCLdShrNTpZV2yNiM9AJgbn9nMSFV6aRhxFEg8B2vVPvt2E+I
 w1qHYRxHcfk+eHuT3BEcKZ6bZu+Zvguyz7NL7QqCWARB1FdYgMzln3O3wDby1FluI4tbV6skGRh
 9/d7MuyjUPVxxpzSuM1aXYbtwcPIU1sPKwpq4idUA/zfRDTQpboANTttWYdorsqcsDLNAsw7REj
 AnLU1kegkpE5IJqFx0GUAlmitNLm7C7WMwxLqBcvPC0DgeSJz6Q/iZi8y5k7sTha+BgURTuoY/3
 sDYfksa6B7RNj/9ug6gNhcmOMKbXtbR7DOLXJ5AX1oN3nnXrdBRh505d95FYpWB6btkTqy0hx8d
 AlgBBRpvPWCMGYLjgw1HRcD184YXZX/o6w7SNfgl0gUuROyfPm5En1lVoRz5350IVo3qPu4Bsje
 v2Pb2sKWCpZOcK9zecrRTPjeIxROlW1pdGEFnalb9durA39lSPmrZ83Q2Hm3IHuBGLnISXd68tO
 Zw3uIGuzfQtOdyDonmuBPTEc5kCDw==
X-Received: by 2002:a05:6000:4a0a:b0:47d:f43b:fd63 with SMTP id
 ffacd0b85a97d-47f4fcc1527mr5056710f8f.26.1784146328035; 
 Wed, 15 Jul 2026 13:12:08 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5b8sm17552158f8f.6.2026.07.15.13.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:12:07 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
Date: Wed, 15 Jul 2026 22:12:06 +0200
Message-ID: <31315640.VsfAaAtOVx@timur-max>
In-Reply-To: <20260715114238.856321F000E9@smtp.kernel.org>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-5-timur.kristof@gmail.com>
 <20260715114238.856321F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 15., szerda 13:42:38 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 sashiko-
bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider: - [High] Removing the `tiling_flags` check in
> `should_reset_plane` allows framebuffers with different DCC pitches or
> dimensions (but identical modifiers) to bypass DRM atomic check validatio=
n,
> leading to hardware corruption and stale DML calculations during commit. =
=2D-

This is not an issue. DCC is not supported at all on GFX6-7 and is not=20
supported by the display engine on GFX8. The code does not advertise any=20
modifiers with DCC on GFX6-8 either.

>=20
> --- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
> --- commit b71fc193d0b1254508d4ef4e5b1e90decbcba27a
> Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> drm/amd/display: Don't use tiling flags anymore
>=20
> This commit removes all code from amdgpu_dm that dealt with tiling flags,
> as all supported GPU generations now support DRM format modifiers. The
> legacy non-DC display code still relies on tiling flags.
>=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> > c643cc5428577..2f7388c47d02a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>=20
> [ ... ]
>=20
> > @@ -4279,7 +4277,6 @@ static void amdgpu_dm_commit_planes(struct
> > drm_atomic_state *state,>=20
> >  		fill_dc_plane_info_and_addr(
> >  	=09
> >  			dm->adev, new_plane_state,
> >=20
> > -			afb->tiling_flags,
> >=20
> >  			&bundle->plane_infos[planes_count],
> >  			&bundle->flip_addrs[planes_count].address,
> >  			afb->tmz_surface);
>=20
> [Severity: High]
> Since the return value of fill_dc_plane_info_and_addr() is ignored here,
> what happens if DCC validation fails due to missed dimension or pitch
> changes?

DCC is not supported by the display engine on GFX6-8 so there is no DCC=20
validation.

>=20
> Could this result in a zero-filled plane_info structure being sent to the
> hardware (for example, setting global_alpha to 0) and causing a black
> screen?

No, it couldn't.

>=20
> [ ... ]
>=20
> > @@ -6248,8 +6245,7 @@ static bool should_reset_plane(struct
> > drm_atomic_state *state,>=20
> >  		new_afb =3D (struct amdgpu_framebuffer *)new_other_state-
>fb;
> >  	=09
> >  		/* Tiling and DCC changes also require bandwidth=20
updates. */
> >=20
> > -		if (old_afb->tiling_flags !=3D new_afb->tiling_flags ||
> > -		    old_afb->base.modifier !=3D new_afb->base.modifier)
> > +		if (old_afb->base.modifier !=3D new_afb->base.modifier)
> >=20
> >  			return true;
> >  =09
> >  	}
>=20
> [Severity: High]
> By removing the tiling_flags check here in should_reset_plane(), how do we
> ensure that framebuffers with identical modifiers but different DCC pitch=
es
> or dimensions still trigger a validation reset?

The tiling flags are no longer used because they are converted to modifiers=
=2E=20
Therefore, removing the tiling flag check is not changing the behavior of t=
he=20
code.

As I explained above, DCC is not supported by this HW.

Additionally, "identical modifiers but with different DCC pitches" would be=
=20
illegal for DRM format modifiers.


>=20
> If a user-space client flips between two framebuffers with the same format
> and source rectangle, but different backing buffer dimensions, it seems
> this might bypass DRM atomic check validation.

How?

>=20
> Could this lead to DC hardware being programmed using stale Display Mode
> Logger (DML) calculations and watermarks, resulting in display corruption?

How?





