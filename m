Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=WyTwsgnL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD1910E903;
	Mon, 16 Nov 2026 15:30:50 +0000 (UTC)
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9663E10E903
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1794843044; bh=CacpKblEsA760YtsmLMPl5YPi5Ety3Wyn3XjcqxLU+Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type;
 b=WyTwsgnLg6wlZ+I6NUp3cLPR7oQ9V7R0xKoTHz3fmWoi6tS2AZKtaFeJ8z9GudGj9lNhki4uhLFCcyuUBuLnfw4gOvaGlF6OYz1Td9jxsmw33sFlnOAwbEv6kTl8ZU8zLdcM/4k8DKNfs+2eXgVvK8YSDEIUzwYQ9IMT5EhZEMQgyWw3F5oJ10lmJjmxeo8/dmUUjk/J3Qo9oZIGGxwCZQeccNz6vE5ET+ashCjjXckUupWvtFZ8QtmB7AAj4S95m3IMt8NXRfqjs+/Hg/PQhRzeKcpKh3tvuKbyPUerDf4o/d60Q/zcTuFKRYxbq4ZRt9BosoKQaUNOz6hi/EuOcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794843044; bh=sf5Q7cRdTi5g8h7Dmr2jQX5HEudDAAMeGBu4a8x/YQ4=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=cKXXnJFrrHUxv00DkgxEV4aH7Ff+EFSzkT1kHQFEYS4l4gFLXt+ZR90ehQi5QXX4/rWfc8dsOveTlGdske4p25lUAvN/S932g58cb0vq2TysUU9s7VQMhe1ZDJf7VnRvNSLh0j5WBMUjiyG6WjQL7wUQ77FouAN9b7ieEXPwUnuWS6mTb6qMgQktRwIgrP+7hEdyO4arB2YVU1CVAD8cM7RMV/kdrrK2NQ//kb0mb2eFrhEomdXayXlsQZChnF40eodSeF1DRUVcwwsR+oyFPd4JT1qbo7oBHnsEdpXPUUbX4nF8TjZf1m+DOXG+CNalE4C3mSEFBnVrnRg+vKoU9Q==
X-YMail-OSG: Yniyq5kVM1n5b.o_SbUExf6yAWCn1MHtugftmypjK7rsJHb.JbmK8ub7k7H4VtV
 iD_x8OQ3GGXSPWecPrHrZFCMefWVOZPHp2_Fgg3MHGMPI0pEStXmikq5UzAQ0DFFXQGp5XOBo4s4
 tSPLMdJQqKLn_o7s2DWKLzUa1PrBnO7jm2G_Lyb7RHR4xaoDL5D57FChqafXRuOp5UF1voGsxbsG
 me3iS5aP0V7r.Qghpw7gjzv.wybLK6t2rM56gyhmb.byw5pwrRyg6zRlU8utn3wWAMV92ZCiW5au
 dgXV2gO0Emh54cotQgu04t_zV4Fd3PaSi6XncP2jU6BCMIdDTzwfwzFIyef_nI.6nS6tMfYWsN6X
 KZcGPGsqVs5Mxu2iuxghQjJWtKdgjbP2JyXmimYz3If.EgoN8iWDrPh4CQ202ZCjQ_hIMAMRQUcl
 XXP6ERCCUcIEy2EoVmBdNHiumN56Nk0hQF.uOYtI9kNNJJnZwTQ.zxvlLWm.8qrj0WOP_Y.90WER
 PlsApCpn3uPMuri9a2q.vNzQmsu2JfpHM8eGoiGROLh3a.qKi_cBlqDLk1HBcNIzu0gjtPRhCZwx
 _pdgqDUZVCcDf4eHW93iIxqbmtEO6S33gWGLCX_Q.NSryHsguiX31lOGgI89zdVfym_1uOnPjxPD
 4HLvRDmWgNhIzdAwGKiYSBp_iQ2K9t4ZruQNSuyqFw3F1audPvjSyqBvuzphSiO6VsSlaeLxrNWe
 CJ11cNR_OJhA09IeLFqH5RWLvJUVFnCn3ZkqCTUztPI0RRAtTApgitnGfDKMeIp2BD19iRzuYnLY
 64DW4_hiNA6rIcgJv2tQgdP0fYtv8o5Zsnq88MkwD.heFgzvh6ZiUKA5cAEzQgX.POy3e8KMeuXw
 hJBQjmOP22b72EzZBe7h_pOi_gJKAVZOdHKxne1ecxWKT3QK1Dard9UEpbiLnAAh7jQwkNp1.sBG
 X7LVBvgAk.YDEhI_unUGS9PgCgK7W0XkJzcyr.H6d33AxZpiGw__fVP1wKOHxMD_sEOwx1YsI8IL
 LGKLWvh3AHcIlv4skYgmLA7k4x_Qt3aOJfrBozTFsXcpH2Ki_w_..SFWbtyoUOi.6l6poEkKuc8C
 cjoIjFmfdKRzlIyaWSrTtaXRSRLHeI36OumYvmy9ohs7QVbbKYecLTvWGq26MQRWiHWm5mO0XxJM
 kBVK0zwaZzGYFZQzlxovsbmS4zu6j7ZWkI7C7gN5K66S_RefYawXgRjK8VfJhM6Uvwnv_50mVStd
 CxEP0jOQSf6lkjhFnRxHM3Bid9Ojjxy195PQ5sZqloaKI2mLFp5V9p4ELUX7k3UvgTO.eTh.zGTv
 AI9Vfy0D2FeWD2k2CqNn1ztapxB8JfL7HtdxNb8Vfgp4sUGEhZjyLJkeC09IFSL2f6dIQQCXgAfs
 l3lue94_h9qQeckIId8x3zRZ9QpczRIZPSaoXQEwEBPilAXBjhG3wYtwqxNIo4ThLhCWCf3wfwtC
 GAXnOtoV3.s6_93ypdFHkzK0lfDYuwatFPw7agMxmHgiAsx.ShXxysXtoRDzhfM9yleBn4m4lsFV
 IVn5mOYvjHBU6x4um7ctxPwHY_dSmjoqmkQYpD1mynVP_tXzE6QKEqc.SRasRwroI_I03FIpJ5bh
 Mr9JV_57CCxAEGn.AiiZ5fEya0sE8rB6LYxQC49Q8d2FQcJHP6XkwtUa7vf2oGFGz.OgiE02GqQN
 ZU40GtlEJLjE2Nhg.vADQ0bOLjz6tHwEE_wF7YoIyulKsZZruWF8nhrshqAHcUlDq6O7NRS3.dOV
 F3g8Z9daeDT4NVkNCh29ujdpEo.ulWN5I.RGyaYXza6iY1e4QvJclq7ch6FPJSdY1yCKzxlqcmYi
 KA7PsfM88Kxewma5CGPPhiiil2alttInUkU4jR2WvsK_oEKl4Tlbzcyc5OLnD5fBbQqnsTwQgnH8
 WCLr2pVF7yF5udDFkYElg653YYJtfDajFpoBWDv7MgOXkzdymZF6Q0zY00gy2aHtcFsxdNFqAFzE
 1pY0eWXoCncdxp2qXZoqT.3ZANFc8pr1fCw35OiEJEOnEvTKIL9RbIAOtVKHZmjl9Gys2BauJpoS
 aCkuRm36kvPqgkXR35a9AUTJnpKCidOjM5Y0Y4FvPwu1wFITrecAk0op9dxqnHGKQpskXhVUA7Ga
 1CsDZQyHEOgFNxYJaYA7t60CGnvnY0UvjQgGp_uowYn.ha0Kl3AEClahkV4qzZWcTgcO42nfvDjy
 8zsoovr_Py_LUjrNOncXbxCCCIkhoiXUp_EHbj43LPkC57EWNq9u_eBBihquleQZ6JFiqSFk-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 191b3ebe-fddc-4d07-9b0c-a801f7fb10ad
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Nov 2026 15:30:44 +0000
Received: by hermes--production-ir2-5dd9bf4598-ztwl7 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a2560806a443f778c1e95ce8d3860c30; 
 Mon, 16 Nov 2026 15:30:39 +0000 (UTC)
Message-ID: <2b9812d198c7edb5efc3906482478fa08b3c6b84.camel@aol.com>
Subject: Re: [PATCH v4] drm/gud: move format init from gud_probe()
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 15:30:05 +0000
In-Reply-To: <20261107162207.26336-1-rubenru09@aol.com>
References: <20261107162207.26336-1-rubenru09.ref@aol.com>
 <20261107162207.26336-1-rubenru09@aol.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-K9g/5YUFLFdTjZdxQD2F"
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.27017
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-K9g/5YUFLFdTjZdxQD2F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2026-11-07 at 16:21 +0000, Ruben Wauters wrote:
> As part of the cleanup of gud_probe(), this patch splits off format init
> code from gud_probe into it's own function. This makes the code more
> compartmentalised and easier to follow, and makes gud_probe() smaller
> and also easier to read.
>=20
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>

I was wondering if it would be possible to get a review on this one,
since sashiko hasn't found any further issues, so I can get this merged

Thanks

Ruben
> ---
> V1 -> V2:
> - Removed output parameters for gud_get_formats()
> - Added gud_get_max_buffer_size() helper function
>=20
> Apologies this v2 took so long
>=20
> V2 -> V3:
> - Fix potential num_formats underflow
> - Skip XRGB8888 in size calculations if emulated
> - Remove redundant r1 and XRGB1111 size calculations
>=20
> V3 -> V4
> - Take XRGB8888 emulated format into account when calculating
>   max_buffer_size
> ---
>  drivers/gpu/drm/gud/gud_drv.c | 185 ++++++++++++++++++++--------------
>  1 file changed, 111 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.=
c
> index 680447f426f3..1ffb2a4fc901 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -435,11 +435,115 @@ static void gud_free_buffers_and_mutex(void *data)
>  	mutex_destroy(&gdrm->ctrl_lock);
>  }
> =20
> -static int gud_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +static size_t gud_get_max_buffer_size(struct gud_device *gdrm, u32 *form=
ats, u32 num_formats)
> +{
> +	struct drm_device *drm =3D &gdrm->drm;
> +	size_t max_buffer_size =3D 0;
> +	size_t fmt_buf_size;
> +	int i;
> +
> +	for (i =3D 0; i < num_formats; i++) {
> +		const struct drm_format_info *info =3D drm_format_info(formats[i]);
> +
> +		/* Substitute emulated XRGB8888 for proper format */
> +		if (formats[i] =3D=3D DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_=
format)
> +			info =3D gdrm->xrgb8888_emulation_format;
> +
> +		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config.m=
ax_width) *
> +							 drm->mode_config.max_height;
> +		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> +	}
> +
> +	return max_buffer_size;
> +}
> +
> +static int gud_get_formats(struct gud_device *gdrm, u32 *formats)
>  {
>  	const struct drm_format_info *xrgb8888_emulation_format =3D NULL;
>  	bool rgb565_supported =3D false, xrgb8888_supported =3D false;
>  	unsigned int num_formats_dev, num_formats =3D 0;
> +	u8 *formats_dev;
> +	struct drm_device *drm =3D &gdrm->drm;
> +	struct device *usb_device =3D gdrm->drm.dev;
> +	int ret, i;
> +
> +	formats_dev =3D devm_kmalloc(usb_device, GUD_FORMATS_MAX_NUM, GFP_KERNE=
L);
> +	if (!formats_dev)
> +		return -ENOMEM;
> +
> +	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORM=
ATS_MAX_NUM);
> +	if (ret < 0)
> +		return ret;
> +
> +	num_formats_dev =3D ret;
> +	for (i =3D 0; i < num_formats_dev; i++) {
> +		const struct drm_format_info *info;
> +		u32 format;
> +
> +		format =3D gud_to_fourcc(formats_dev[i]);
> +		if (!format) {
> +			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> +			continue;
> +		}
> +
> +		if (format =3D=3D GUD_DRM_FORMAT_R1)
> +			info =3D &gud_drm_format_r1;
> +		else if (format =3D=3D GUD_DRM_FORMAT_XRGB1111)
> +			info =3D &gud_drm_format_xrgb1111;
> +		else
> +			info =3D drm_format_info(format);
> +
> +		switch (format) {
> +		case GUD_DRM_FORMAT_R1:
> +			fallthrough;
> +		case DRM_FORMAT_R8:
> +			fallthrough;
> +		case GUD_DRM_FORMAT_XRGB1111:
> +			fallthrough;
> +		case DRM_FORMAT_RGB332:
> +			fallthrough;
> +		case DRM_FORMAT_RGB888:
> +			if (!xrgb8888_emulation_format)
> +				xrgb8888_emulation_format =3D info;
> +			break;
> +		case DRM_FORMAT_RGB565:
> +			rgb565_supported =3D true;
> +			if (!xrgb8888_emulation_format)
> +				xrgb8888_emulation_format =3D info;
> +			break;
> +		case DRM_FORMAT_XRGB8888:
> +			xrgb8888_supported =3D true;
> +			break;
> +		}
> +
> +		if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_XR=
GB1111)
> +			continue; /* Internal not for userspace */
> +
> +		formats[num_formats++] =3D format;
> +	}
> +
> +	if (!num_formats && !xrgb8888_emulation_format) {
> +		dev_err(usb_device, "No supported pixel formats found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Prefer speed over color depth */
> +	if (rgb565_supported)
> +		drm->mode_config.preferred_depth =3D 16;
> +
> +	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> +		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
> +		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
> +	}
> +
> +	devm_kfree(usb_device, formats_dev);
> +
> +	return num_formats;
> +}
> +
> +static int gud_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +{
> +	int num_formats =3D 0;
>  	struct usb_endpoint_descriptor *bulk_out;
>  	struct gud_display_descriptor_req desc;
>  	struct device *dev =3D &intf->dev;
> @@ -447,9 +551,8 @@ static int gud_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  	struct gud_device *gdrm;
>  	struct drm_device *drm;
>  	struct device *dma_dev;
> -	u8 *formats_dev;
>  	u32 *formats;
> -	int ret, i;
> +	int ret;
> =20
>  	ret =3D usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
>  	if (ret)
> @@ -510,81 +613,16 @@ static int gud_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
>  	drm->mode_config.helper_private =3D &gud_mode_config_helpers;
> =20
>  	/* Format init */
> -	formats_dev =3D devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
>  	/* Add room for emulated XRGB8888 */
>  	formats =3D devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*fo=
rmats), GFP_KERNEL);
> -	if (!formats_dev || !formats)
> +	if (!formats)
>  		return -ENOMEM;
> =20
> -	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORM=
ATS_MAX_NUM);
> -	if (ret < 0)
> -		return ret;
> -
> -	num_formats_dev =3D ret;
> -	for (i =3D 0; i < num_formats_dev; i++) {
> -		const struct drm_format_info *info;
> -		size_t fmt_buf_size;
> -		u32 format;
> -
> -		format =3D gud_to_fourcc(formats_dev[i]);
> -		if (!format) {
> -			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> -			continue;
> -		}
> -
> -		if (format =3D=3D GUD_DRM_FORMAT_R1)
> -			info =3D &gud_drm_format_r1;
> -		else if (format =3D=3D GUD_DRM_FORMAT_XRGB1111)
> -			info =3D &gud_drm_format_xrgb1111;
> -		else
> -			info =3D drm_format_info(format);
> -
> -		switch (format) {
> -		case GUD_DRM_FORMAT_R1:
> -			fallthrough;
> -		case DRM_FORMAT_R8:
> -			fallthrough;
> -		case GUD_DRM_FORMAT_XRGB1111:
> -			fallthrough;
> -		case DRM_FORMAT_RGB332:
> -			fallthrough;
> -		case DRM_FORMAT_RGB888:
> -			if (!xrgb8888_emulation_format)
> -				xrgb8888_emulation_format =3D info;
> -			break;
> -		case DRM_FORMAT_RGB565:
> -			rgb565_supported =3D true;
> -			if (!xrgb8888_emulation_format)
> -				xrgb8888_emulation_format =3D info;
> -			break;
> -		case DRM_FORMAT_XRGB8888:
> -			xrgb8888_supported =3D true;
> -			break;
> -		}
> -
> -		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config.m=
ax_width) *
> -			       drm->mode_config.max_height;
> -		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> -
> -		if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_XR=
GB1111)
> -			continue; /* Internal not for userspace */
> -
> -		formats[num_formats++] =3D format;
> -	}
> +	num_formats =3D gud_get_formats(gdrm, formats);
> +	if (num_formats <=3D 0)
> +		return num_formats;
> =20
> -	if (!num_formats && !xrgb8888_emulation_format) {
> -		dev_err(dev, "No supported pixel formats found\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Prefer speed over color depth */
> -	if (rgb565_supported)
> -		drm->mode_config.preferred_depth =3D 16;
> -
> -	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> -		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
> -		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
> -	}
> +	max_buffer_size =3D gud_get_max_buffer_size(gdrm, formats, num_formats)=
;
> =20
>  	if (desc.max_buffer_size)
>  		max_buffer_size =3D le32_to_cpu(desc.max_buffer_size);
> @@ -650,7 +688,6 @@ static int gud_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  		return ret;
> =20
>  	devm_kfree(dev, formats);
> -	devm_kfree(dev, formats_dev);
> =20
>  	drm_client_setup(drm, NULL);
> =20

--=-K9g/5YUFLFdTjZdxQD2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLCBAABCgCsFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmr7IX0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxEhxydWJlbnJ1MDlAYW9sLmNvbQAKCRDSflDAUK4M
4UP/D/94Obv6rN1kyeiSrhZBskyZpYuQP45alnQb6R2vlMJer89N+5LaJ1IEeIsf
qoDAyzSwWaWXhL1kz2HxTG8VgxPaoapXQhmIuxD10bcmDq8Ten/7BbHkIespY1i0
i+LaGHRZTWdywOE8dQh0eUIlkaenOUn23ikU3h9JYJswYYWIFI5xK1QUn7KbTZRl
dqUVRrjMCon3noUp9xFRsFE1geDJP/5V26e2vPnH2gmJ1jOwAi+v+0FE/YqKlRav
Wkix8CMeeFAhZAKdoKXihEnET4wiFkb9BwptA8Gn2L2fKXf+AzB/57rRpb4JE/m9
xflBHGhxrCdp3ocVf2+rRmLT9gf6JMFnORpsWjZ4T33dpAYD+LO4d5QC8mXoC2CX
xkIQCBsvRD4OH51hu4/skrzzHenxwK86xWvy1OyN+sx0gIZBATP9nMzs/R9VNGAW
/U704GAhYa2KRXyQwgC5mL8l4erS+XD5bc22RXkKajdOLSXbMAL+vVaZLg/+1+Im
xsbzLe0/FrAducQHT7FRw+dfxtmijJprLWkV0Gvf/X/nwcEVFuIWz4qV3tDiEMeh
5lN4IHMrLCdQOXlwYyvNLPeLeSIblPG9Fudh3/BG1FXxNWsTdGJNOEtyYprcoA6D
vQnbmvsx5Dhf9iD3MYYPLeqFxWz1Mb1FNwGN6TXNFb5i22JaKw==
=YAOx
-----END PGP SIGNATURE-----

--=-K9g/5YUFLFdTjZdxQD2F--
