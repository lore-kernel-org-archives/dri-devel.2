Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D511FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC93010E915;
	Mon, 27 Apr 2026 20:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DctoitRk";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41CB10E915
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 20:32:09 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891f625344so96492925e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777321928; x=1777926728;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vtsGRC0FacbegB0AwrvJfP/Z12ZLNzAQIxUg9a44s5w=;
 b=DctoitRkviZJL+OfXu88waLmSMWvR8ToNqlG64adMvmA6EgHujWsg8GADZaQBMcUuf
 AYKOdoSjExaJfi9ppbWqX1ma9VIMU1e4KcAWvi3nqP1DBIxWuY86lRGN30Vut/7dXWRO
 j34LhrSQB2xn1CvPVZFNIWhwvvu65n1viBAysLXHo+F6fgrcOGEqicxhATkHt5m4/B1h
 Bk0iHy/5tEkKCKigWQrYwSlnev56Hwl4JWBbWMly14okL/ufInB/xl8P+jubJ/49mWFR
 2VyAWt2jWvBosDlM/brofugvh4Rids76SvMSgP8zh9lm56ANEXpyqP7TT7XBLDCNAYGQ
 qgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321928; x=1777926728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtsGRC0FacbegB0AwrvJfP/Z12ZLNzAQIxUg9a44s5w=;
 b=od0ZOiP09yUt04zqpo5Nk1cW0UFHictK5cKIod1UBPOAipSNSi1of2x9ztay0BWP1N
 J5ueVXNRK4rFLjTihYBXriV8BRf9uyZeWKWhV71QMFycbA4j8bruXarG+M9fQNoS9pWs
 whZs0sJEUrX87JURQbqKPAJ81kx3hTWsAPqbhcdKGIsSp4/fDJ+o4leV6K8VJUkW2pWY
 sfBuKfUOqqKK19zxnLQJ/Bbjr5DX34Rb+t+3NCN7yNhW7IH6gd6E7kcyW1Yp/YgaGOwC
 8Lx9u7cGwiJjA++UNBHuMO/1bRIPNIQuE76oaex2YCP6sOeHZbqGDLmsuDssLFiIERaT
 wDAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XHbKXVJfEXTG+Ia5zEZ9/G4NU6K/DmloJlSEGnRHnuoHP9z21NWPdECU/7dmwOADzw8VKZcM5LS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaslpbS17Dx8MwFBm/6dJ8o3VI/qFev9P98XWRhxWNptmFpbXx
 bQyW5HwKOpGY873vGIjdB7Etz9n7yr4aIwapklXaYayUidSV65XPl4TGht8helcAf34=
X-Gm-Gg: AeBDietHD1ITmcuelcxXB8uYBiOzzM+Bo5TeP2aTupG2HHj+9TU7ItqA7gUUJpo/x2Y
 NVnuUQyciB/TFL66oqOOplUkXgEpGFkVLwL2h+e7pxU46/oBBD8OuXYAnIbQckrobCXblylCgP/
 /G5hpI4dGoZBrUkS+7GA1oDmgOkS/CSkUY9kyUR7ffC7iyEftmSeM2uWnowJAcDMjJAXkt4/PKH
 TiaDFIBU0g8+xWTrW1jvxS8L0A6fJQOdVYMkz2e//PmZzI4sAdLGmExw4e+gFAGJZEbF025Y14K
 7mP5Mt8COkywute8/qBWV3n4cE40Y/jLLzKyK1TVhyjXWwjqVOJlBfuCqdmLK4mS3a3R2JPR+2Z
 hVLBxaV7Ilhg43acRSRxe9dwIygRUR/X6oRv88i9xJ8RYz+biYWnb0jmZ9slJHyu2P/89VXTDD2
 Ojawe4PMuDhxoTYH4yB4tiOHeHoVx54n2VhNglhdg=
X-Received: by 2002:a05:600d:8495:10b0:489:1e5e:2cc with SMTP id
 5b1f17b1804b1-48a77afcf3cmr2718895e9.9.1777321928066; 
 Mon, 27 Apr 2026 13:32:08 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4463fb7e366sm811816f8f.31.2026.04.27.13.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:32:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 22:32:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Don't emit UTS_RELEASE as part of device coredump
Message-ID: <ae_HSpwz298xt0Yj@monoceros>
References: <20260427160902.1126027-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nl4r2jq5dzig4bb"
Content-Disposition: inline
In-Reply-To: <20260427160902.1126027-2-u.kleine-koenig@baylibre.com>
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


--5nl4r2jq5dzig4bb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/xe: Don't emit UTS_RELEASE as part of device coredump
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 06:09:03PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> UTS_RELEASE changes quite easily (e.g. uncommitted changes in the source
> tree or new commits). So when checking if a patch introduces changes to t=
he
> resulting binary each usage of UTS_RELEASE is a source of annoyance as
> it introduces changes not caused by the change under test.
>=20
> It's little helpful to emit the kernel version in the device coredump, so
> drop the kernel version line from it.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
> Hello,
>=20
> I'm not really sure if my assertion above that the kernel version isn't
> helpful is actually true.
>=20
> If yes, there are a few more very similar changes to make:
>=20
> 	$ git grep -E 'drm_p.*UTS_RELEASE' v7.1-rc1 drivers/gpu/
> 	v7.1-rc1:drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:      drm_prin=
tf(&p, "kernel: " UTS_RELEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c:     drm_prin=
tf(p, "kernel: " UTS_RELEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/msm/msm_gpu.c: drm_printf(&p, "kernel: " UTS_RE=
LEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/xe/xe_devcoredump.c:   drm_puts(&p, "kernel: " =
UTS_RELEASE "\n");
>=20
> Best regards
> Uwe
>=20
>  drivers/gpu/drm/xe/xe_devcoredump.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> index 558a1a9841a0..260e3f19286b 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -101,7 +101,6 @@ static ssize_t __xe_devcoredump_read(char *buffer, ss=
ize_t count,
> =20
>  	drm_puts(&p, "**** Xe Device Coredump ****\n");
>  	drm_printf(&p, "Reason: %s\n", ss->reason);
> -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
>  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
> =20
>  	ts =3D ktime_to_timespec64(ss->snapshot_time);
>=20
FTR: If the patch is acceptable, the following should be squashed into
it:

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_de=
vcoredump.c
index 260e3f19286b..4ed1e4afa4c6 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -8,7 +8,6 @@
=20
 #include <linux/ascii85.h>
 #include <linux/devcoredump.h>
-#include <generated/utsrelease.h>
=20
 #include <drm/drm_managed.h>
=20

I will wait with a new revision in the hope to get some feedback first.

Best regards
Uwe

--5nl4r2jq5dzig4bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnvx7sACgkQj4D7WH0S
/k47UAgApSFviop5H5WcLHTrJ16SrGvoD/8b9OMezrcG6g/kkc7sBetFoXGKnsKi
f9Qtxnbkdv0wur6dQsvKxzkX6RKGGn2ZXaEHbRC07FO4XIrkIebQ7YNWWE3l0VM3
8385S74OD9Hrzehrkj5ZFZ+NJ+tf6SJdwlZqE8lubXtZGzsIMrjC6yWglZXcU0+F
cgP8I8+czIHWqLzgQ5KGusr8NTAPzkT4c4iI3mWboHyp3qP/vBba2dOFg9518Ao7
Q6RFQmY9PNCbOgBRNjOGs+sPJXfYDNJIfqq4kzDIQPK4pisa690bd2H8+9kH+zGp
dISTjeWk4+f8H+M1CJVJZqxNWTYx3g==
=lCt6
-----END PGP SIGNATURE-----

--5nl4r2jq5dzig4bb--
