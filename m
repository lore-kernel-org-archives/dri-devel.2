Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE857606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kD6C0vbR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CBF10F435;
	Wed, 11 Nov 2026 08:21:12 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5A510F520
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:21:05 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so1093525f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794385264; x=1794990064;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PcL13psvRZFQi+EqqGXNhdYLmJXts/aYGQ1HARjBFyI=;
 b=kD6C0vbREgbjeOqY5wi78ZWItJ2OBr872E+L/M4lfhzwOWHEJ0w/0DOSFVMGf3UsHC
 bveHR7n4SA5P+tFd++EgHGTesAX7wH06kIXMIC+edPg+jX0EGr21qY0sfQHy+Hto6rU5
 EEca/2BnBfxT8MpAClGAV8xFTH1WX+dlV5406a49frWwwxnmaD/+PIinzUmzLnH2pKCf
 Ao2uvBVl7ClkI2eBATCOjmu0PtGKvmCGF6L8Rz3tZlOlfZN355cHhGhWh+TksO6aAxxa
 2i+xrt3r1mcBia4XE1JYBfvGdT5W4zorLq4FmQcLrNa/KEng/GSwSITQ0ksPjkACs0DL
 Dz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794385264; x=1794990064;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PcL13psvRZFQi+EqqGXNhdYLmJXts/aYGQ1HARjBFyI=;
 b=CevL+9LcDvQdqxUwPZa+6uUnaug7bU7etNIcbS5xi7dPn/dvUO82wc6mPKtgsUiBwI
 iNRVykxbrMiUCVXqxnt6X+Ut9C4rOBv5tarJ1Zrv8hIXMBKYPwhUChH2oY8lSCOkvsoF
 U4yaG5Ck+dRQ0gNf3h9BsoAmPvS4KUCtSbThBeauO6C6aw9lDauB3TveQrnO/IPeqAWN
 uk7lvEb5A4AgteGtRe/OwIy7kWouzytM7yWfe76ji4BQqh7fGCNR3YxgoJI7MazupqO4
 keiZNEtHaRzRTATRS1qns9HwifxGHZTsojHpSr7T5uEPIShOlT0FEjCBVdJhih0B1SEX
 1GXw==
X-Forwarded-Encrypted: i=1;
 AL+hErHx1cmb7xrfzmqTC0hyOWEw/ag/ul5JOJVJQFlPXs70sSJD4GGCqXYYxKJ55wVtbJsBrnbvkjch+9Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84YLvnpfES3WPOUTG3sSc6EJ1vEAQSZpr0o1suhA1zmdNqpYJa
 VeKuDfzqOYz8N5k+QjEHzYenkqzfCqtOVRbBLI08DcQnb86OqTOKwFGPbu6tLKXIC+BDp25oLh1
 ilsrKEVw=
X-Gm-Gg: AYBFou0UF3Ok3o2uX2Fo5Kcj8mnyCf9BauRT31OFVU8sJVgvRr/9KSedYFJkT3JRnBW
 i1HnRnhuDopl1b/wvmbKx3POqRT0dc7Nq1+4Sjw7SiksjMpbStvCnxRHY0h5Sjjpa9uMY8gkTmY
 TQda6N7614++iR+fXukyQ+UJjCc1+hHfFvmDYpmIKJlxY+yu2kOo0SMWmhDtl2cP+osxX1k3vKs
 DvtogH1FEZxJgjwbr9ez09zZRqUH+nYypySJ/VKzj/UmyyUCPmMImB3ZLSY6ErZy4h+xEIe5Qdo
 QKyOlq+t1TCGdSqimWgwtMG8jg8ix0iy08eBYDf/wyb+aM8jlD2D6/NQO6KNcLQc3b/6NkONGE6
 2u73MOhOO7JHeeaovlkH5HIW0ed2V5C57Tn4Wi5e8Ys3sMb46yam2uibNABVfwCZlbAKU6keB+Z
 pTMBtp71Ok0M390xIN4CD9XoU+8o5sjEUD2qebnFkxJXvQwCod2n0LRLoHsl9Ds+/vtsCR5nIgB
 o3utshANMGJJFzFnBOVeI577by1fj/8ODPkzIBofGPN4QLUjJh7Ey7Mrdk1Fqc34mO8vqQS1d9+
 VdE/bqda8fPNqzCzqlsCBlS58DWqy6MQMYUP9Hflmu23s3BbLn8bfjQrn/ThOu4sbO5ciZRzAdT
 2j6BY+vLCJV7VbVZD00oWaJB6sNRJsNOWZss=
X-Received: by 2002:a05:600c:190a:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4ba0936c0d2mr28605045e9.6.1794385263638; 
 Wed, 11 Nov 2026 00:21:03 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba01feee1asm163617585e9.12.2026.11.11.00.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:21:02 -0800 (PST)
Date: Wed, 11 Nov 2026 09:21:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm: Drop #include <linux/mod_devicetable.h> from
 <drm/display/drm_dp_aux_bus.h>
Message-ID: <avQk9v83d-jEGTiX@monoceros>
References: <21c9390024479ec625ca7a2e7a5b959f04d85878.1786032838.git.u.kleine-koenig@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y3dpgl3ksduhd24t"
Content-Disposition: inline
In-Reply-To: <21c9390024479ec625ca7a2e7a5b959f04d85878.1786032838.git.u.kleine-koenig@baylibre.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--y3dpgl3ksduhd24t
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] drm: Drop #include <linux/mod_devicetable.h> from
 <drm/display/drm_dp_aux_bus.h>
MIME-Version: 1.0

Hello,

On Thu, Aug 06, 2026 at 06:16:06PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Only .c files include <drm/display/drm_dp_aux_bus.h> (see
>=20
> 	git grep -l drm_dp_aux_bus\\.h
>=20
> ). From the device-id structures that <linux/mod_devicetable.h> provides
> there are:
>=20
>  - 8 files using struct auxiliary_device_id;
>  - 2 files using struct i2c_device_id; and
>  - 10 files using struct of_device_id
>=20
> (and no other usages; see
>=20
> 	git grep -l drm_dp_aux_bus\\.h | xargs grep -oh -E "\<(acpi_device_id|am=
ba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_dev=
ice_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(de=
vice|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id=
|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_de=
vice_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio=
_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|=
parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_=
device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_i=
d|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id=
|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_devi=
ce_id|ulpi_device_id|usb_device_id|vchiq_device_id|vio_device_id|virtio_dev=
ice_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>" | =
sort | uniq -c
>=20
> ).
>=20
> The 8 files using struct auxiliary_device_id already include
> <linux/auxiliary_bus.h>, the 2 files using struct i2c_device_id include
> <linux/i2c.h> and drm_dp_aux_bus.h itself includes <linux/device.h>
> which provide struct auxiliary_device_id, struct i2c_device_id and
> struct of_device_id respectively.
>=20
> So the include of <linux/mod_devicetable.h> can just be dropped. This
> gets one step closer to being able to remove that header.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

This is still all true, including the statistics (as of next-20261110)
and the patch still applies fine.

Can someone get convinced to apply it?

Thanks
Uwe Kleine-K=F6nig

> ---
>  include/drm/display/drm_dp_aux_bus.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/drm/display/drm_dp_aux_bus.h b/include/drm/display/d=
rm_dp_aux_bus.h
> index 8a0a486383c5..ca8db8ccc1f9 100644
> --- a/include/drm/display/drm_dp_aux_bus.h
> +++ b/include/drm/display/drm_dp_aux_bus.h
> @@ -11,7 +11,6 @@
>  #define _DP_AUX_BUS_H_
> =20
>  #include <linux/device.h>
> -#include <linux/mod_devicetable.h>
> =20
>  /**
>   * struct dp_aux_ep_device - Main dev structure for DP AUX endpoints
>=20
> base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
> --=20
> 2.55.0.11.g153666a7d9bb
>=20

--y3dpgl3ksduhd24t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0JWoACgkQj4D7WH0S
/k61Fgf+LAbxTwzlhn7aNtdrgBrNmIEXSEuJtG7IZWCvVEN6gsNpfpR8LnF0/AUJ
F/q2IKcI3M+Yil/Q9knAmwEOqdJ/w/CBBny580BjLvupvNDD73+HzRH7RvQecYaO
yODn7MWNUTFvHUT6BjJ8d2dOI9ieTLJnKEO8hl3PiBDLqVYLnCG5uP5hEyAv8wY+
10ov9Su+j0QOdPDAyjIGOkDWhOzT8Jp44gwGrUVVfaRRw2QPvM3v/rGxATTv9zWu
D9VgNhdFhR5fk3RF4iR7x/PsvvBBNOkpeLXcoa+kU4i4TWBCZkh7vr26OKOY43pq
Bw/OGmEeE3ZOLA/lahYVsiiYPYRmaw==
=A5T+
-----END PGP SIGNATURE-----

--y3dpgl3ksduhd24t--
