Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5383606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F2YIWW0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0976110F851;
	Tue, 24 Nov 2026 18:43:21 +0000 (UTC)
X-Greylist: delayed 96981 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 18:43:14 UTC
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70D410F851
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:43:14 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=Cr46827WCtKim+mG3QIW/z610jvuzUyK5XGWs6EBH0k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795545791; v=1; x=1796150591;
 b=F2YIWW0mrkI6Js/uRiHWXxGxsc5OogCFbJ3u8Gl9b1fXXc1knNkbp3sW2dAFmXjbwKzI7dBV
 l6wiR+MQK1Zr6r893rsoVWCADHcm9YuZuS8MMTaCmpODKyinZF1Ddk8Svu9Nv91fPBdTvr5bE+Y
 4aicVYL518PNmn2ZQMASMES4=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ec72b3c1cde0bcde;
 Tue, 24 Nov 2026 18:43:11 +0000
X-Mizu-Trace-ID: ec72b3c1cde0bcde
X-Migadu-Flow: FLOW_OUT
Message-ID: <06ab3827afd9515e5cfa4821b0a744c7ac94baec.camel@linux.dev>
Subject: Re: [PATCH RESEND v4] drm/gud: move format init from gud_probe()
From: Ruben Wauters <ruben.wauters@linux.dev>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 18:43:00 +0000
In-Reply-To: <d9212a46-b5ea-4bee-a1b3-052549cc4ed6@suse.de>
References: <20261123154638.2298-1-ruben.wauters@linux.dev>
 <d9212a46-b5ea-4bee-a1b3-052549cc4ed6@suse.de>
Autocrypt: addr=ruben.wauters@linux.dev; prefer-encrypt=mutual;
 keydata=mQINBGQqWbcBEADD5YXfvC27D1wjh1hOmjTjSwAFjQDGynLtrhBBZpJ+NBsfu++ffR7HF
 d/AaSJ+hqJni6HBNr/DMxWYMC8fOAr6zCSAX6fD2Rvy6rq6emuLaGOFkAIWDyuFWw40anlSCPZN+f
 fXTKJvARo45ZpC9PcfNu9/iRl/CpzSdiB5U4O2YtggXPWyOm9ev+bysmn6sjS1d+IZ7iTs9Ef0O4v
 I+1VFXvZMaY0YzG7EoYnKfeeUD7IGLpI4EEkNqLaU4onLN/qkXUwjT+YTw/VtTxNCmtTVFf57RAg2
 toscC85JjcrOeGSXdpP3J9CPdcIDMpOlnE//KuJIA3QMkckPQgnYtRw3ZhbiVxLNNJSUYm7PuRd9L
 LyObX7dpi0YfsUhxmD2+grw+Yvh2YlPWFybBDBgzRIcSMMSw0ertL64hBof06aVIlT8+TBf1Sq7O+
 obGYoXUi2q6qAuz+0y11spGk0YOffx4ChGPMQGGGaXGaCcjRMuJ050MF4dtwep/mSWH/p8EJtIKY8
 LfP/2c6G8leikMddtb+wKSNUuGYE6ctgcUtlltssRt74ls/ajYE00K52dlhCiaKxd2y0KpYEfWXPE
 pfiQ8yd/P/6fZCaOleY4k8Y2/JmlVUfwfVcVmb3mKWxKQXaHhT3cEvv8yuFDZgkTvZInINKtxxzly
 1i3TlY/nn5mwwARAQABtCFSdWJlbiBXYXV0ZXJzIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlQEEwEKAD
 4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCat4
 GLgIZAQAKCRDSflDAUK4M4bMUD/9F5zDiNOdTC7jPXcMNUxJYG/D0SeHrZG47J1+HswSIiHiqy05f
 LaU9gCYyqPoLJT1rS00b0j36KWW7aB8Zwx8r/SVR3eWnokCfD/NwKD/Grs4KEh7iRPNXv88u9B2Ed
 XttirRh9D0IM9pTLVeAol4tLi9eH5hYrA6y2meJ7hRFnySdVBMnAca98RHJ229CCPXBetKfR0A2di
 7l35K39kQZYsRSLbuXScKmZB++bsyjuovAgf33Jfb7XzexS6L5hafks6ML+suxIVN/9PSwVWbqZum
 mWas3mKCQa0AT1XC0hBkMrB4nkkXmI2Z2sIn5ljjgUhfPsb0YU7hl7xxNNsDi1hROnDBwVTZJ6qrd
 D9PDVysRjd8ERmzgmgiIs0lLCYUlq0v7miSDbMAMRfl29tyaHgsBT7H9ZTyh7psy79y52AzWfk+cP
 XeqF40FpNeGxj8gxTo+/Str8eq+7JQsP57lGJ8ChofIjUkEIlIYWo5phVZ748pOQVT+fJJ5FfRvtS
 /fb80f8fxXm+hRr8rTb4v1UQ+YR+JJI71uW5mk5oUNcDBUd8zhO3XFqwegDcWBWm95hfbvNKqaotm
 Y7u50bwh0PCgzwuQYw5UL0rHBg2JvekWhs5ncKh0e0fI+WUW9OYtc34d14yS76lKRkx3cHFzyqw7X
 neJn8eMfozOSWKQ8KLQdcmVkMDMxMDAwIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlEEEwEKADsCGwMFC
 wkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCat4GJgAKCR
 DSflDAUK4M4XWrD/9jut5QYqxC2JiaDqqa1m6/UdvrJnmDFBkFKrId+bgfE3ZD/GB902kJ/kvrJpd
 TLtp3AUM/n9+rLv7pzwNAi5tc7eCcxhyIhQtGFbtgDem74lONiX1sQp0HYmTrTEB9rnwT5EurDse4
 8owTcWUtUvLhleAeVoeZbh3qrFf1DZp/N9sh615O1EO5+PM52mg07D7AzngBc5mWq+46kpWxob7N9
 GAPu8CXDbFOFfaWUPyLqQ5Tx7b6fiaYjFHpi0QEHaGWj446OK8xSqjvNBMGRVhq89Xzs+uu+RnfU9
 PhkCKT5ld9HE4Aq9lH9abEjZtwvtbAZARY2LyPA1vth09RS5g6+PeTdaH/ZFsTLlxyaomcX6dcYZh
 azpGvhXTokT8x5ZmghwkXJ4Yw6yHVFf509ycRtUifhu9hXPMY4muup6Zey5nRJHAoYpmSkurIPR0x
 Cul3Cl7aHlcA6CmpNQYf3KCfIX5Sj6G154syBiEYK+nn04ig2vglLyfjgOYMyZSBsm77nUQb5yCRe
 +qz8xmrsVoA5i96eS+v8M7jK5pEaeJtNhfpFaH6QBSGMJtIqyqMq8fv/T2S1Fff4c99f+/74uop8k
 qRlffckrSjy/fBX5koZtCgbdnadK/xruikytyDPbYiZ/2e146Y2qhNUCxBVPSqf1plZd83FX2ls55
 a5vJTKrQnUnViZW4gV2F1dGVycyA8cnViZW4ud2F1dGVyc0BsaW51eC5kZXY+iQJqBBMBCgBUFiEE
 3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmr2w90bFIAAAAAABAAObWFudTIsMi41KzEuMTIsMiwyAhsDB
 QsJCAcDBRUKCQgLBRYDAgEAAh4FAheAAAoJENJ+UMBQrgzhrxMP/1osrx6OC30ROvDHhkChhf++ih
 aB/6d2Br7Dn3CIMVhlcINk4vA8mrnyJv6JM/G68835k+mlCNbmfbsEi4SLR2ToJcZ/txIh6YJr0Ms
 UHZ6QRQoSgQJ4+huT391m494acdg1rp4IRh5TQ0jmUVlXOOrx25JFEaoHmZkng8LZ8MsPfDvUrvLl
 Ay+CQ5faOJoSiU1zfDicUxMoAr0lIH2mHF6K5q6RX+6D3Ck+ugGI1PCYVhX75ernqSMyI9NtKjqXm
 mIpfHxafIOLMdCL867AHWh6//hdwHug5GJFBoUkl4ZZoDnlduZEFCRozOslCXhpKkwf/ofGpKJ6B3
 fTxXgqo4t9/pMQnN+oQufpESvzZ7lAOft+B3RdOPcac9SUggUulQpgIZhzBHKGj1hBQ6EFYNeDDSc
 xMFrlgTSzfxzgIPbkylpRVVpVaE44GLKrBZ/+kpKMKEYhaVwPQaWy7cTQxlWOsDkle4TpiRbBCSBs
 jL+UQQW7Jb5ztUD5Qz78WZVDGVXfqahTXIgYrrVTMEwVNMAchwZXLsezEVsuueHRudtxbElAhXJiW
 /EVQAzi43aU6PiUrhMGpVx9/9Jcg3elku+E6kOu/QVB6nMGhCW/e2zygaKxb/YLXZobH28ft0Ri/X
 kucga8Gk5CFyv+Kpr88vZ12SAda27SKVfH4xDDbr0W
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-5PbnTEj0Rgma3qAKiMVd"
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-5PbnTEj0Rgma3qAKiMVd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-11-24 at 09:46 +0100, Thomas Zimmermann wrote:
> Hi
>=20
> Am 23.11.26 um 16:46 schrieb Ruben Wauters:
> > As part of the cleanup of gud_probe(), this patch splits off format ini=
t
> > code from gud_probe into it's own function. This makes the code more
> > compartmentalised and easier to follow, and makes gud_probe() smaller
> > and also easier to read.
> >=20
> > Signed-off-by: Ruben Wauters <ruben.wauters@linux.dev>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> I have two minor comments for you to consider.
>=20
> Best regards
> Thomas
>=20
> > ---
> > V1 -> V2:
> > - Removed output parameters for gud_get_formats()
> > - Added gud_get_max_buffer_size() helper function
> >=20
> > Apologies this v2 took so long
> >=20
> > V2 -> V3:
> > - Fix potential num_formats underflow
> > - Skip XRGB8888 in size calculations if emulated
> > - Remove redundant r1 and XRGB1111 size calculations
> >=20
> > V3 -> V4
> > - Take XRGB8888 emulated format into account when calculating
> >    max_buffer_size
> > ---
> >   drivers/gpu/drm/gud/gud_drv.c | 185 ++++++++++++++++++++-------------=
-
> >   1 file changed, 111 insertions(+), 74 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_dr=
v.c
> > index 680447f426f3..1ffb2a4fc901 100644
> > --- a/drivers/gpu/drm/gud/gud_drv.c
> > +++ b/drivers/gpu/drm/gud/gud_drv.c
> > @@ -435,11 +435,115 @@ static void gud_free_buffers_and_mutex(void *dat=
a)
> >   	mutex_destroy(&gdrm->ctrl_lock);
> >   }
> >  =20
> > -static int gud_probe(struct usb_interface *intf, const struct usb_devi=
ce_id *id)
> > +static size_t gud_get_max_buffer_size(struct gud_device *gdrm, u32 *fo=
rmats, u32 num_formats)
> > +{
> > +	struct drm_device *drm =3D &gdrm->drm;
> > +	size_t max_buffer_size =3D 0;
> > +	size_t fmt_buf_size;
> > +	int i;
>=20
> Small detail: num_format, which you're comparing to is unsigned. So=20
> using unsigned for i is preferable.
>=20
> > +
> > +	for (i =3D 0; i < num_formats; i++) {
> > +		const struct drm_format_info *info =3D drm_format_info(formats[i]);
> > +
> > +		/* Substitute emulated XRGB8888 for proper format */
> > +		if (formats[i] =3D=3D DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulatio=
n_format)
> > +			info =3D gdrm->xrgb8888_emulation_format;
> > +
> > +		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config=
.max_width) *
> > +							 drm->mode_config.max_height;
> > +		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> > +	}
> > +
> > +	return max_buffer_size;
> > +}
> > +
> > +static int gud_get_formats(struct gud_device *gdrm, u32 *formats)
> >   {
> >   	const struct drm_format_info *xrgb8888_emulation_format =3D NULL;
> >   	bool rgb565_supported =3D false, xrgb8888_supported =3D false;
> >   	unsigned int num_formats_dev, num_formats =3D 0;
> > +	u8 *formats_dev;
> > +	struct drm_device *drm =3D &gdrm->drm;
> > +	struct device *usb_device =3D gdrm->drm.dev;
> > +	int ret, i;
>=20
> Same comment here about i being signed.

Hi,

If you would like I can send a v5 fixing these, or I can just add them
when I push to drm-misc-next, up to you

Ruben
>=20
> > +
> > +	formats_dev =3D devm_kmalloc(usb_device, GUD_FORMATS_MAX_NUM, GFP_KER=
NEL);
> > +	if (!formats_dev)
> > +		return -ENOMEM;
> > +
> > +	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FO=
RMATS_MAX_NUM);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	num_formats_dev =3D ret;
> > +	for (i =3D 0; i < num_formats_dev; i++) {
> > +		const struct drm_format_info *info;
> > +		u32 format;
> > +
> > +		format =3D gud_to_fourcc(formats_dev[i]);
> > +		if (!format) {
> > +			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> > +			continue;
> > +		}
> > +
> > +		if (format =3D=3D GUD_DRM_FORMAT_R1)
> > +			info =3D &gud_drm_format_r1;
> > +		else if (format =3D=3D GUD_DRM_FORMAT_XRGB1111)
> > +			info =3D &gud_drm_format_xrgb1111;
> > +		else
> > +			info =3D drm_format_info(format);
> > +
> > +		switch (format) {
> > +		case GUD_DRM_FORMAT_R1:
> > +			fallthrough;
> > +		case DRM_FORMAT_R8:
> > +			fallthrough;
> > +		case GUD_DRM_FORMAT_XRGB1111:
> > +			fallthrough;
> > +		case DRM_FORMAT_RGB332:
> > +			fallthrough;
> > +		case DRM_FORMAT_RGB888:
> > +			if (!xrgb8888_emulation_format)
> > +				xrgb8888_emulation_format =3D info;
> > +			break;
> > +		case DRM_FORMAT_RGB565:
> > +			rgb565_supported =3D true;
> > +			if (!xrgb8888_emulation_format)
> > +				xrgb8888_emulation_format =3D info;
> > +			break;
> > +		case DRM_FORMAT_XRGB8888:
> > +			xrgb8888_supported =3D true;
> > +			break;
> > +		}
> > +
> > +		if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_=
XRGB1111)
> > +			continue; /* Internal not for userspace */
> > +
> > +		formats[num_formats++] =3D format;
> > +	}
> > +
> > +	if (!num_formats && !xrgb8888_emulation_format) {
> > +		dev_err(usb_device, "No supported pixel formats found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Prefer speed over color depth */
> > +	if (rgb565_supported)
> > +		drm->mode_config.preferred_depth =3D 16;
> > +
> > +	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> > +		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
> > +		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
> > +	}
> > +
> > +	devm_kfree(usb_device, formats_dev);
> > +
> > +	return num_formats;
> > +}
> > +
> > +static int gud_probe(struct usb_interface *intf, const struct usb_devi=
ce_id *id)
> > +{
> > +	int num_formats =3D 0;
> >   	struct usb_endpoint_descriptor *bulk_out;
> >   	struct gud_display_descriptor_req desc;
> >   	struct device *dev =3D &intf->dev;
> > @@ -447,9 +551,8 @@ static int gud_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
> >   	struct gud_device *gdrm;
> >   	struct drm_device *drm;
> >   	struct device *dma_dev;
> > -	u8 *formats_dev;
> >   	u32 *formats;
> > -	int ret, i;
> > +	int ret;
> >  =20
> >   	ret =3D usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
> >   	if (ret)
> > @@ -510,81 +613,16 @@ static int gud_probe(struct usb_interface *intf, =
const struct usb_device_id *id)
> >   	drm->mode_config.helper_private =3D &gud_mode_config_helpers;
> >  =20
> >   	/* Format init */
> > -	formats_dev =3D devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
> >   	/* Add room for emulated XRGB8888 */
> >   	formats =3D devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(=
*formats), GFP_KERNEL);
> > -	if (!formats_dev || !formats)
> > +	if (!formats)
> >   		return -ENOMEM;
> >  =20
> > -	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FO=
RMATS_MAX_NUM);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	num_formats_dev =3D ret;
> > -	for (i =3D 0; i < num_formats_dev; i++) {
> > -		const struct drm_format_info *info;
> > -		size_t fmt_buf_size;
> > -		u32 format;
> > -
> > -		format =3D gud_to_fourcc(formats_dev[i]);
> > -		if (!format) {
> > -			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> > -			continue;
> > -		}
> > -
> > -		if (format =3D=3D GUD_DRM_FORMAT_R1)
> > -			info =3D &gud_drm_format_r1;
> > -		else if (format =3D=3D GUD_DRM_FORMAT_XRGB1111)
> > -			info =3D &gud_drm_format_xrgb1111;
> > -		else
> > -			info =3D drm_format_info(format);
> > -
> > -		switch (format) {
> > -		case GUD_DRM_FORMAT_R1:
> > -			fallthrough;
> > -		case DRM_FORMAT_R8:
> > -			fallthrough;
> > -		case GUD_DRM_FORMAT_XRGB1111:
> > -			fallthrough;
> > -		case DRM_FORMAT_RGB332:
> > -			fallthrough;
> > -		case DRM_FORMAT_RGB888:
> > -			if (!xrgb8888_emulation_format)
> > -				xrgb8888_emulation_format =3D info;
> > -			break;
> > -		case DRM_FORMAT_RGB565:
> > -			rgb565_supported =3D true;
> > -			if (!xrgb8888_emulation_format)
> > -				xrgb8888_emulation_format =3D info;
> > -			break;
> > -		case DRM_FORMAT_XRGB8888:
> > -			xrgb8888_supported =3D true;
> > -			break;
> > -		}
> > -
> > -		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config=
.max_width) *
> > -			       drm->mode_config.max_height;
> > -		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> > -
> > -		if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_=
XRGB1111)
> > -			continue; /* Internal not for userspace */
> > -
> > -		formats[num_formats++] =3D format;
> > -	}
> > +	num_formats =3D gud_get_formats(gdrm, formats);
> > +	if (num_formats <=3D 0)
> > +		return num_formats;
> >  =20
> > -	if (!num_formats && !xrgb8888_emulation_format) {
> > -		dev_err(dev, "No supported pixel formats found\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Prefer speed over color depth */
> > -	if (rgb565_supported)
> > -		drm->mode_config.preferred_depth =3D 16;
> > -
> > -	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> > -		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
> > -		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
> > -	}
> > +	max_buffer_size =3D gud_get_max_buffer_size(gdrm, formats, num_format=
s);
> >  =20
> >   	if (desc.max_buffer_size)
> >   		max_buffer_size =3D le32_to_cpu(desc.max_buffer_size);
> > @@ -650,7 +688,6 @@ static int gud_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
> >   		return ret;
> >  =20
> >   	devm_kfree(dev, formats);
> > -	devm_kfree(dev, formats_dev);
> >  =20
> >   	drm_client_setup(drm, NULL);
> >  =20

--=-5PbnTEj0Rgma3qAKiMVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLIBAABCgCyFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmsF2rQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxGBxydWJlbi53YXV0ZXJzQGxpbnV4LmRldgAKCRDS
flDAUK4M4QLSEACSVerrQa80/n8yxqRFxixNWmr4j56wK6dLPKPYRlbFNixmLxP4
IAnOz8AH4nU9DklVstMn6JgxOMVvcrIRZULh+RQEqs63b+ni5/LHs3rkSVL0W6JL
EMJR7Xuj7S4ljnRMYz7FyMcRQIkD/ecQG5y3zhgugiLhj7rbbZ66/ELxndP9NIGm
NsLV+WLEEdQBWIZClWFAXRVQowk4QX1W4EvPdNJu6soGx1rSo0FOLBjPs4IHl35W
Wwq5NtYoGhSO3ziYyIf9V87uBbC88NlmgK7mxyybCW/ivx2VW5gcYgMInR2AgWym
Ts2BfHSqxt3Cd3ZqpYD+KJqRTvbF4ErXtHRBLtyzNhz7r0ta9J+Rn4n3CKFSrT54
dZkL0JRmcav09fiKnU0iYN5ifzAFbxaoeESfbIBQ4A7g6KAmqexTO2wEPSOyfmeV
nQIezOl51oUNQdKpocyicM7Egs4S2D8tvh3fQHxDnG7OqCSapumr6s6y1hgWi5xN
vhMxcTD+oblC7geG9NdyNjoxKw3Yy2noejA9c75sMwt0+BybC/OjOGv2kANgqQW3
df1ogbIew1onryMB8WZcWLCjpQq+HjFMqgaemrjmfef9jBzvUg173bfC1tXiEH48
vahqVgyMFfJFlK+sB1/SCUpDC1BrlN0LojKgof+E1npdmQ0BwpetTR73Yw==
=vspv
-----END PGP SIGNATURE-----

--=-5PbnTEj0Rgma3qAKiMVd--
