Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA99FC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FDB10E4EE;
	Mon, 24 Aug 2026 06:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GGBJEDOv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13E210E0C8
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:52:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58E5742E5B;
 Mon, 24 Aug 2026 06:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE331F000E9;
 Mon, 24 Aug 2026 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787554367;
 bh=wlrAFaWo1E9hyYaIgSD0+VLQ53/AVaiGp6wMA6KTVQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GGBJEDOvUmxuTCp2AtIBaxsqKLHu8hHDITDP6CLMYM9AxLYKVVeQtoSwOKDysH0PL
 Zxw2sdSlLeST40HBUmI4OV9A1yoG/G1Pw/Q6FU4iIQidFARbWdUT3Js1nfmLTXCjVA
 Uax2++0S1FvsuGbOtbOzoGZD18g2YIWOdB6AOtI206Tb8MT16KSbzYwMvt4jqcasW9
 UYcG3TAFR2LuNw2fDxkguLUd/kSG3HK/WTaReuSCtydQFOEGvF2aLV2HmJA+l7QxJK
 XymUDYSBuQKMbAUWlYrNg/tUDOReWReIIXGbPHxE188rFeVofj/QVTDmipf5HaDwDd
 oBa8izaSr34ZA==
Date: Mon, 24 Aug 2026 08:52:44 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind
Message-ID: <20260824-expert-sepia-oyster-cabaea@houat>
References: <20260822143218.68764-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="2nw3szy5zgrinfwp"
Content-Disposition: inline
In-Reply-To: <20260822143218.68764-1-kmehltretter@gmail.com>
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


--2nw3szy5zgrinfwp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind
MIME-Version: 1.0

On Sat, Aug 22, 2026 at 04:32:18PM +0200, Karl Mehltretter wrote:
> vc4_hdmi, including the embedded ASoC card, is DRM-managed and freed
> together with the DRM device when the aggregate device is torn down.
> The card however is registered device-managed on the HDMI platform
> device, whose release runs later

Not necessarily, no. The comment you removed explained it. DRM-managed
memory isn't removed when the device in unbound/removed, but when it has
been and the last fd to the device file has been closed to userspace.

> so snd_soc_unregister_card() operates on freed memory:
>=20
>   # modprobe vc4; rmmod vc4
>   BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
>   Read of size 1 at addr ffff0000456a8450 by task rmmod/262
>   Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
>   Freed by task 262 (rmmod): drm_managed_release / drm_dev_put

And that happens only because you have no user. If you had one, you
would have had the opposite sequence.

Maxime

--2nw3szy5zgrinfwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaovqPAAKCRAnX84Zoj2+
dhrDAYCAAsWCltPgMB7RSFCkdIfB7+hLSVCZswgsYNWF23+uWuFaTfNfleRm72Uq
cWeXnIgBfAidP/BhAf7UGp2w0J6CGKFP9iImXy/uXGXIyoQNabPxoJ/s5HruRE4H
a2YO1+CL8A==
=NpUy
-----END PGP SIGNATURE-----

--2nw3szy5zgrinfwp--
