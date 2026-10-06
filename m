Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39480CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7654910E043;
	Tue,  6 Oct 2026 13:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="K8QKIWCk";
	dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E6010E043
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1791291753; bh=9E3OCWXprX0RJaktFxM/8n6uIVZDAaRTP/3rY7uLJ9I=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=K8QKIWCkGW9PqiNCq9FkGHkov/Bn8+geh8r+MTQrcwatBjOQR5+uUWPpiICVvOmddJ19koHXdPJY2jJqPw/2IjPRbGmcpZxx6Zl7K8OUW2XwPv7AMY0kIIogtbOFuBfbc5SgxfEJ5ZsxLL6Mpjspife8ae2xDOPRfkOkAGWFXKraT1VJLQdpb0grZGTLox2GfYoHvhdxoSK1VW9PboBn942x3Iic9Ex9V8IUbqPKb8VeDGfUzLWcfKTa7I+EEOwwPy2ysqOFlov9V+hntsSUOhJEuGMb8H6z6SgbAOseLvaapEzBlEY5tsbhQtFWvh06A8+x9PsJ8wpJBVlev9cPhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791291753; bh=q9Vn28JI/zLn58bgG/79fhL7Ws9V+oCmbKH+FbwO8RY=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=mQmz2MtEWIb+REqUa/KlJcKaDieiNdE+ogtmP5Wtjyd9JzappGnxNPhpUEL7sdky/oYX8Bdk54eIW/hbjcZZ5RE8EXcKBKR7wiz9ra3ywm8s46j24+8d24//pzGQAMoHuCzc1WdAT3euxGTdYfS0eiCrWgSrhRCcbGst6WUAx1UO4+sT2F+RXKsSt6fjjapieLiq55sfEayy5Y1pWDgS6hhuL8mLgFm1EvL50+cxRfDgyL9piAjObFJ/2nI/3aYLSC9HCBeTkZfov+2N6d9gNMl4JKfiKibB+pvxRiILsvY4V3m2IzJpWYhrZzfjPbvV1RSiCVn9CY/BHfyA9Z3jfg==
X-YMail-OSG: ccu42_4VM1mIvNDPR3peCwxwHT0RzwS0PuunkhaK_liYGkqzU2dIPw1SaINJElN
 eimk9CmHTQ7MM3B2DWE8O2f2MuWM_pRaJwIKiIxhrhSDGMm2enzDagMBgTKoyfh4PHGVSXJOwNVB
 4ee9P_ZVTOsTwrA4pipn4Bvzy_BZmIMTrWnzJwZ2oS5DK_db2qukKstPuvGe.x7xjZqmQABcZDpL
 6f9uP44jOi1u7UwY104t_PLEBu4.EY1VRX5oLKUSri856v9hZR7ShDtkVurURZFwIce.GC5S5rvH
 th0NDS8shVv1amhq9PsMHVsVn4v6fgkGUjKWVVBH2jCQTD9D.76nqVWIyMWwOzgUc0xs8o3ccXxO
 MdNEoDl5Y4KsruYFMxoo__ohGs7Fp9.RHmX8Uu4JMhmIdSk8PfQ.AA8kgVfLQ6qdLa5XWtHM0stp
 v__.y.65_9z75_vGsRJPytilbP0ESPOGYaXQXLxP8pSzaLmJ4lQBA8F9NNwM8wxNdRIcbdmeCmti
 4kSehuNU6mpRk5WiXaMCiF4.8ScRTHqiai9WVeLwJjuujkLaZ0D5dLmAYi988ChPWt0WlglH5fTw
 8B6Lu97RKLNDRW7ns2qv8MXCpIFAd5b4HIfS4tacB0WNivoqpZA_HUt8fND9IskrkwGEsGxpn_Vg
 lNpv4WvX7nHFrYtlHak8mYGMtlyOWNdSLCk1odyaSDaHxbB645cOXodP.h3k_BieylIvnPk.wxQ9
 pn7dQ5S01UlizdYktl6VNAguReSapnsVExIHr0o9LTPVx6V.3nFNmczaKPg24LagkfFSFROgrOwb
 g.jFXNGUXHxDoefzUcH6PiQdIpsOXnoccmLH_wZ_DEbLxLkGNuieoIF.VDMR5hrlLvPrPtHqpVZ4
 QgzFSwtdTCca1cH1qkgrxSopbO1qtOJx4IKxU27Dn.8k5mEtx94LowcLZwq77EPZWXFshH2m5WAX
 YlIWFS7tCwj49oZp.QMG1wmmNO1L5wZCzIasyhlKy8MPs4Xcpu6iybwLBhBlXaOY.ht7M0H_CqMz
 gG1CN_ElhCuseHjeD8huGHllyjHhOnnjNxRScRWap70Akwxejnush1u1BejN5nRVLSvTQ1LuknfW
 cZ4cCtqvYPLxsdHx786dgJ6CL2ZZPHAldpGrldyJ12BV2O3XtW.pilMCuM4_GdWyWB334MY35pdh
 gUQUnM1M_gStuGJG.WvG1.tCZOxTnPpzmb4EswN7BzD3JbdXENU2jEog6ulFTwlT28PzguwWzlzw
 WvXRRLQlmrXRraP8ruO0bkTuuw6jRdNRJfWCHQp1uJhSW3LCDuzUzaqvYxsFLvuxkiCXM95S7G15
 _vwGUXxlxz7FBot.Wp81xoL9DwMRD1YMMJqN3qMpUSCWkDgFtNXjUDns_N_6F897dt4FKSC2XrZo
 f83UlotehmdwwS1E6ujja0oWqNnkR302_iAfC7K5xkWlqcIdKiP1N9yv51XCWJ5cuNLp8.JnKAgv
 6DQt6Gfbn6YWwYeakpU1fjlqt8VarycYvEt5ZmIFDEN1AlV7rwGTMkRNpFfnbeIVaFNf_5NztfAL
 QjTBa0RfkPdOtEpursDA60jPxv4HQI6dwrgZkRf8Xvaq6pZyyPwx9jPxu4OK1FQbSBD6KcsCLIhW
 wr4pgGe59JDA9dbCkIb7XR30.frfdgRdiB56ENYw4aoXok2DtARr1JEZqPK9HsRQDLd82RjX7w2Y
 OjalCU6YjMPyN9Ow5p8YLFPYAMssqesOxBxDmn8S.H34LYBEoltOCbxNaDejWVwefFtYwA4NYNls
 vEgwfhjACAeim5E_FHsygF01bIAHGB3JRozNMzzsHX5h9fyL0hazsFbPeedwwL2YEomSINhE6QMJ
 _YO_mIsVZqCoPkDpMTbrfcIu_AzI16Djz556YltyptZLDcQxKiZMHT5aaLV4evGAUflOQJT9z5Ye
 fJ4peUVAsg95PL.qxa19a1O8Vadt34JpJtmgl_74ExkbjEe22jvegpUUgZtOETCBb1ptsp.wd5DI
 SFS.54GtO2PG_VWrQwWHpthGG4IHG5FcZkgNY1tFHrBdmhu9s5n9yAMos6ijMhUfAHyqW_76.dYn
 0hO0tgBA2lXyjIjv_KKREHHibxtEdOlnITXz8k7hL2yn0tJzu41TcJTPajcv7D8wnHsMiT2Dxdj7
 pbRmx9jbmhpU6oGb3r4Q9fO9.DwaVtelQB4_wggEZYLjg8AL6Liai6v.ESrBtctPyXA96Yn3th_Y
 5GrO.RaqoalYOA3DqIiS_uiP52CB7hErPsjeqVUV7mtv6J5c0Q3Nm2TUZfCueBkDSDVKsivDNKyQ
 e
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 4a8950ea-8a68-4480-a32d-903fbcca4f86
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Tue, 6 Oct 2026 13:02:33 +0000
Received: by hermes--production-ir2-5dd9bf4598-hrqwh (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID e54da0c57641f9e2d2552a0febb4bdc0; 
 Tue, 06 Oct 2026 13:02:27 +0000 (UTC)
Message-ID: <714216ad03c9189426d92646d28b1872301d83b1.camel@aol.com>
Subject: Re: [PATCH] drm/gud: fix bulk_len divide-by-zero, connector bitmap
 OOB, and short USB reads
From: Ruben Wauters <rubenru09@aol.com>
To: Hui Peng <benquike@gmail.com>, tzimmermann@suse.de, simona@ffwll.ch, 
 airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 14:02:24 +0100
In-Reply-To: <20260919223510.3888975-1-benquike@gmail.com>
References: <20260919223510.3888975-1-benquike@gmail.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-gNRPWEAJ3y4bweuDeAF6"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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


--=-gNRPWEAJ3y4bweuDeAF6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-19 at 22:35 +0000, Hui Peng wrote:
> In drivers/gpu/drm/gud/ (gud_drv.c, gud_pipe.c, gud_connector.c), ensure
> gdrm->bulk_len >=3D max_pitch so lines =3D bulk_len / pitch cannot be 0 i=
n
> gud_flush_damage(), cap num_connectors to GUD_CONNECTORS_MAX, and reject
> short USB control transfers in gud_usb_get().
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index 8141c3a1e30a..1bf0495bf43f 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -569,7 +569,7 @@ static int gud_connector_add_properties(struct gud_de=
vice *gdrm, struct gud_conn
>  			continue; /* not a DRM property */
> =20
>  		property =3D gud_connector_property_lookup(connector, prop);
> -		if (drm_WARN_ON(drm, IS_ERR(property)))
> +		if (drm_WARN_ON(drm, IS_ERR_OR_NULL(property)))
>  			continue;
> =20
>  		state_val =3D gud_connector_tv_state_val(prop, &gconn->initial_tv_stat=
e);
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.=
c
> index 3a1b9e2a2eaa..f69b0e6e2ee0 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -328,7 +328,7 @@ static int gud_stats_debugfs(struct seq_file *m, void=
 *data)
>  		seq_puts(m, " none");
>  	seq_puts(m, "\n");
> =20
> -	if (gdrm->compression) {
> +	if (gdrm->compression && gdrm->stats_actual_length) {
>  		u64 remainder;
>  		u64 ratio =3D div64_u64_rem(gdrm->stats_length, gdrm->stats_actual_len=
gth,
>  					  &remainder);
> @@ -427,6 +427,8 @@ static void gud_free_buffers_and_mutex(void *data)
>  {
>  	struct gud_device *gdrm =3D data;
> =20
> +	vfree(gdrm->shadow_buf);
> +	gdrm->shadow_buf =3D NULL;
>  	vfree(gdrm->compress_buf);
>  	gdrm->compress_buf =3D NULL;
>  	sg_free_table(&gdrm->bulk_sgt);
> @@ -443,7 +445,7 @@ static int gud_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  	struct usb_endpoint_descriptor *bulk_out;
>  	struct gud_display_descriptor_req desc;
>  	struct device *dev =3D &intf->dev;
> -	size_t max_buffer_size =3D 0;
> +	size_t max_buffer_size =3D 0, max_pitch =3D 0;
>  	struct gud_device *gdrm;
>  	struct drm_device *drm;
>  	struct device *dma_dev;
> @@ -495,6 +497,10 @@ static int gud_probe(struct usb_interface *intf, con=
st struct usb_device_id *id)
>  		put_device(dma_dev);
>  	} else {
>  		dev_warn(dev, "buffer sharing not supported"); /* not an error */
> +	if (!drm->mode_config.min_width || !drm->mode_config.min_height ||
> +	    drm->mode_config.max_width < drm->mode_config.min_width ||
> +	    drm->mode_config.max_height < drm->mode_config.min_height)
> +		return -EINVAL;
>  	}
> =20
>  	/* Mode config init */
> @@ -523,7 +529,7 @@ static int gud_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  	num_formats_dev =3D ret;
>  	for (i =3D 0; i < num_formats_dev; i++) {
>  		const struct drm_format_info *info;
> -		size_t fmt_buf_size;
> +		size_t fmt_buf_size, fmt_pitch;
>  		u32 format;
> =20
>  		format =3D gud_to_fourcc(formats_dev[i]);
> @@ -562,8 +568,9 @@ static int gud_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  			break;
>  		}
> =20
> -		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config.m=
ax_width) *
> -			       drm->mode_config.max_height;
> +		fmt_pitch =3D drm_format_info_min_pitch(info, 0, drm->mode_config.max_=
width);
> +		fmt_buf_size =3D fmt_pitch * drm->mode_config.max_height;
> +		max_pitch =3D max(max_pitch, fmt_pitch);
>  		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> =20
>  		if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_XR=
GB1111)
> @@ -588,9 +595,13 @@ static int gud_probe(struct usb_interface *intf, con=
st struct usb_device_id *id)
> =20
>  	if (desc.max_buffer_size)
>  		max_buffer_size =3D le32_to_cpu(desc.max_buffer_size);
> +	if (max_buffer_size < max_pitch)
> +		max_buffer_size =3D max_pitch;
>  	/* Prevent a misbehaving device from allocating loads of RAM. 4096x4096=
@XRGB8888 =3D 64 MB */
>  	if (max_buffer_size > SZ_64M)
>  		max_buffer_size =3D SZ_64M;
> +	if (max_buffer_size < max_pitch)
> +		return -EINVAL;
This feels like it can just be changed to a check for max_pitch >
SZ_64M || max_buffer_size > SZ_64M? Comparing max_buffer_size against
max_pitch twice seems... odd
> =20
>  	gdrm->bulk_pipe =3D usb_sndbulkpipe(interface_to_usbdev(intf), usb_endp=
oint_num(bulk_out));
>  	gdrm->bulk_len =3D max_buffer_size;
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 5ef887d8485a..1f08226b23b2 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -156,10 +156,14 @@ static int gud_prep_flush(struct gud_device *gdrm, =
struct drm_framebuffer *fb,
>  			  struct drm_format_conv_state *fmtcnv_state)
>  {
>  	u8 compression =3D gdrm->compression;
> +	unsigned int block_width =3D drm_format_info_block_width(format, 0);
>  	struct iosys_map dst;
>  	void *vaddr, *buf;
>  	size_t pitch, len;
> =20
> +	if (block_width > 1)
> +		rect->x1 =3D ALIGN_DOWN(rect->x1, block_width);
> +
>  	pitch =3D drm_format_info_min_pitch(format, 0, drm_rect_width(rect));
>  	len =3D pitch * drm_rect_height(rect);
>  	if (len > gdrm->bulk_len)
> @@ -327,7 +331,7 @@ static void gud_flush_damage(struct gud_device *gdrm,=
 struct drm_framebuffer *fb
>  {
>  	struct drm_format_conv_state fmtcnv_state =3D DRM_FORMAT_CONV_STATE_INI=
T;
>  	const struct drm_format_info *format;
> -	unsigned int i, lines;
> +	unsigned int i, lines, block_width;
>  	size_t pitch;
>  	int ret;
> =20
> @@ -335,12 +339,21 @@ static void gud_flush_damage(struct gud_device *gdr=
m, struct drm_framebuffer *fb
>  	if (format->format =3D=3D DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulati=
on_format)
>  		format =3D gdrm->xrgb8888_emulation_format;
> =20
> +	block_width =3D drm_format_info_block_width(format, 0);
> +	if (block_width > 1)
> +		damage->x1 =3D ALIGN_DOWN(damage->x1, block_width);
> +
>  	/* Split update if it's too big */
>  	pitch =3D drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
>  	lines =3D drm_rect_height(damage);
> =20
> +	if (!pitch || !lines)
> +		return;
> +
>  	if (gdrm->bulk_len < lines * pitch)
>  		lines =3D gdrm->bulk_len / pitch;
> +	if (!lines)
> +		return;
This also feels a bit odd, checking !lines twice, it shouldn't be
possible at this point for pitch < gdrm->bulk_len due to your changes
to max_pitch above, given that max_pitch should always be at least
min_pitch for all the formats.
> =20
>  	for (i =3D 0; i < DIV_ROUND_UP(drm_rect_height(damage), lines); i++) {
>  		struct drm_rect rect =3D *damage;
> @@ -399,6 +412,13 @@ static int gud_fb_queue_damage(struct gud_device *gd=
rm, struct drm_framebuffer *
> =20
>  	mutex_lock(&gdrm->damage_lock);
> =20
> +	if (gdrm->shadow_buf && gdrm->fb &&
> +	    (fb->pitches[0] !=3D gdrm->fb->pitches[0] || fb->height !=3D gdrm->=
fb->height)) {
> +		vfree(gdrm->shadow_buf);
> +		gdrm->shadow_buf =3D NULL;
> +		gud_clear_damage(gdrm);
> +	}
> +
>  	if (!gdrm->shadow_buf) {
>  		gdrm->shadow_buf =3D vcalloc(fb->pitches[0], fb->height);
>  		if (!gdrm->shadow_buf) {
> @@ -562,8 +582,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  			goto out;
>  		}
> =20
> -		req->properties[num_properties + i].prop =3D cpu_to_le16(prop);
> -		req->properties[num_properties + i].val =3D cpu_to_le64(val);
> +		req->properties[num_properties].prop =3D cpu_to_le16(prop);
> +		req->properties[num_properties].val =3D cpu_to_le64(val);
Please rebase your patch, this has already been fixed upstream

Ruben
>  		num_properties++;
>  	}
> =20

--=-gNRPWEAJ3y4bweuDeAF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmrE8WAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzha9kQAKnqmimlz9QU+TualnIu
Ct71/9CNST7ptTA5gaPomV/jQOGP3sOW+YtgQy1eavkcktDddk9vyH5EECcetTEM
BWCqWHSRtonDTPBhJCUY6fdTVPLDRU6XzIlfsDk8/fyzvBDrV44AYSFDROINkjJK
NLYKGWAJ7FhU5aYW3jJ7bE9bBRmtow4Nv1Et8yeRPrvPuHvkqAk1yCOLVkBLb5aP
NEi0bkcS8iYllEM36moh48eE1FJ7w3xZzKzlzBHOBUYedsQNNtEP9PdRKKWqfQmy
e4beuMSoNl/fauxVouZFOT+i18YYBH8FYGB+SbmAyeJFl5hKqO8pzg9okucPsW9g
OqAHUZn7uHNEfwXlP/QF6Z+o2fD+uqPn8Qy9sM0PmeZKo+uOXD1sfSkzewdXkaIv
ZoHvtcIfFopM8mx9CMyT8Z3rpiD81bzRBJnnGlSdffzNTtSORiPX7aC429YL5A7O
lLUck4x41Bat8UzStl9pHY+PpMECFmvSVcHc+bNG1KThr/rAQcf6GqxJP1nHQYAr
MER0ni11JYyrdiG/g7HsQzXrj9dH/bIb4uU6ObalpkQwzoG3X18c8JucWEvDUNqu
XRqFMIKqSFPKGh9ACcBCiLAq7IoW3+ba5ik1X3Za60SZJUBOYjJN0LSPZJVCnMwC
1ljKwwuw9i2e08zHc/75qARx
=cbxp
-----END PGP SIGNATURE-----

--=-gNRPWEAJ3y4bweuDeAF6--
