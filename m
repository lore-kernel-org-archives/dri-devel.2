Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A935F3D5E7
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AED210E4AD;
	Mon, 30 Mar 2026 08:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LCf0wmlE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A8910E4AE
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774858496;
 bh=yRehV+3um9IVcwPkqBKdNu+iYsiIESTGgAVeCeMqkbA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LCf0wmlEN5YboxwmYPtl41YNrViq3wf4Xylh079nZYUKKdbT20MKNJdj1Ypl923Nw
 yIbnfqi8grpMRuWLGfRw+PzQnNkq0islsrh0XPrV1oP5U+q6QAYbeA2CduK5I92qS0
 TPttugV1o/fkjXBhsb7wymSwetkd3KdiKvkgrfprRqaOxaVhzoaa65Fmqql73HJB8/
 2sW8eMsJJFf1km4D407NGPNvDtOogaCw/pKDJNoi5qf9hY67h6Yl9dFEVi7oAl+hSu
 ryRqdhAs0z+0rraQLeI+C54wuAD0+YjUJ4hgmpw357LVdf85bd7ZsyrpGMlPgtKI+x
 c4vCcXW/MZcwg==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9DF0D17E421F;
 Mon, 30 Mar 2026 10:14:55 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:14:43 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, Daniel
 Stone <daniel@fooishbar.org>, Michel =?UTF-8?B?RMOkbnplcg==?=
 <michel.daenzer@mailbox.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/doc: document DRM_IOCTL_SYNCOBJ_EVENTFD
Message-ID: <20260330111443.14092de6@fluorite>
In-Reply-To: <20260327171812.128290-1-contact@emersion.fr>
References: <20260327171812.128290-1-contact@emersion.fr>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y7CZ/y=xD5uh7EgE3leQ=cG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/Y7CZ/y=xD5uh7EgE3leQ=cG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 17:18:29 +0000
Simon Ser <contact@emersion.fr> wrote:

> struct drm_syncobj_eventfd was documented, but
> DRM_IOCTL_SYNCOBJ_EVENTFD was not. This prevents references to this
> define from being properly linkified in docs.
>=20
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  include/uapi/drm/drm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d27..495462e44a17 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1323,6 +1323,13 @@ extern "C" {
>   */
>  #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
> =20
> +/**
> + * DRM_IOCTL_SYNCOBJ_EVENTFD - Register an eventfd to be signalled by a =
syncobj.
> + *
> + * This can be used to integrate a syncobj in an event loop.
> + *
> + * The IOCTL argument is a struct drm_syncobj_eventfd.
> + */
>  #define DRM_IOCTL_SYNCOBJ_EVENTFD	DRM_IOWR(0xCF, struct drm_syncobj_even=
tfd)
> =20
>  /**

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/Y7CZ/y=xD5uh7EgE3leQ=cG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnKMPMACgkQI1/ltBGq
qqcZww/9Hd0w/3F+7Lrh/oI/58jq4r2jd7urSHCRqs3zUNs2BD7nV+cAw1aWDZ3r
kEbPqpTE99mvIRspWYtMfpGLjFT+G7yUTEe1+ktIqn7ulepxQr7aOMsLOjvUGBKH
IBjP/0jbxWfye4rad1uQpx8svB4t/k53TCDD3xyUYCsLhk5fcC4dCd9FbBXAFg60
ZNq6TDpwoS54FawlITsaVEeZMcFl8Us27xeHrKMvKFn4VZzHMiTa+v1whkwM46Hc
Aq2685c+CaK5zEzTp+MXHi879BrZe5J0MEl1ZJi+QFF9WoMS7lMlFuxLWEujbZDc
NflGzVAPoU62ZpqjFAS8rrYOwpHtQDk83/klOrTGgLQ61No0YFjjqFWdkfizNtpk
cNJzbeozu0jVtDPl2IUaDZn9HiJFM5ZFGuqM194P7jRe/uBIPlioqGdFMm4nEDBS
j1gOraEbyLBgh7q7Jz7ee4TIxxlUqkipSW6SW5PvsP5t+0yBnTZOg4Y4kgEpNkZj
4F6Tf41AwwM+5FuTFS4gCx4EYj0x2WoAOluhYrCfKKxpZEZAhxg6o38PKgt2OSYS
Ohs0o3s0NWvFeUpPdzwuN23tupilCdfvFSsGx1VSYcbWwooCfvfyGotxXMySNqZp
1Eq/IbaR4xYb2V2OhAd7UGxxmAXhpyF2BJFngd4JBFeAilGzNzg=
=BoWp
-----END PGP SIGNATURE-----

--Sig_/Y7CZ/y=xD5uh7EgE3leQ=cG--
