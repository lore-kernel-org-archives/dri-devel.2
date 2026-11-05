Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95948606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hKiKjp+n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5E210E8BB;
	Thu,  5 Nov 2026 02:36:33 +0000 (UTC)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6303310E8BB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:36:27 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cdb2e0062bbso568859a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846187; x=1794450987;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mMANaqSq4GcsvcAjECinF07SRMy3T/n0++S+KBqJRx4=;
 b=IYrX8DriJFRfi+BFaSJl0XIyzSNjHAApphjmcewt9ZDjEPFsP98FjECaeCp9HQISLk
 RTMcbXEkDLxRwDSNrZsOiQG9z9oLiLxa0AbdZrY0XXR/hh0jgoZKEWVV0UUuFoeKMNxD
 0mrGB/rRBa+QU3+8fQL4Fc7/2JnpUJ9BKLAVVvWx5EiqwBf1V//embc2mRxHMGYCXGYC
 6Qkm6OR7GUeJCGlHeZLRBrZgi4RU8YacHZPHv8qWbO3p42Dd+yZ5MIi7gKck+dwa9o7Y
 PrzRSjBTnPRLOFFIOK1K+Xw4SRF4voqexEVxbJ/AOV2iqqkTc2xj2BlKtj0k2V1gZvj8
 qDfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+nesujDZDkNCDKeqAB+vKYZ7k+g9cqPN4jh1xB9Gt/qUezAG3Ua1opI9BJgTE+9s0JJugfzdR5z8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PgJL+pTcki+ny7uI4IGAC3ULwpe3aDWfFaFY9KCuoorDOw9bB
 geFlxj5p9J/va/gbJ1Ytohn61KNBMdjKyG2BrM33EzcB2TsdeV41X4Uk0ltbWxyXwbcmFgVPMqp
 z4g2px7m6k0HgoR61PNpBn8g0XqgxINVv3O9G9c0A4XYMxA0ni+/lf4IImEVfbCLRwQ69ojhz0m
 rs8d5jVYLHDeYLX1Jy4IRDzfzI/8P0IpNW0tn3HQhXTdiYeyDKdsTILDfVdDsS/BsahSAyKMZK9
 DlvaQmSzoMXlEhd8+FZp6ihAsM7
X-Gm-Gg: AYBFou0lPrkmvjzmiMePQqhzKx8MZRhNdchWPsiAFyuYmYqkp3g+/28KfiCseZmLDkw
 CAtkL2pvNXP5G8JAPvc2O+mcUr4Tl/UF1h0Ctgh+p+tIBO47pxdCe28UtjAZD/RZnC/5H2Iub23
 csQaXg/MhXc0UugaNPZxy9m7fFCaa8wHmEemn88HTCAqjzRja7C9vK65SrEb58tRueErEYeqQ7S
 F2qcKj5UDjPMrDtEl2y02epC0ZdwKAQdpC1u+AUC+4SnmR65urqWBigJ2lrIJrcxBm5qZ2UA/ZC
 /UEzU5/5A2HImkRJ0jstpmYzDWUWYNT7at6cxn7XBoKK/Ip+qFrgV8BH2sCsWHn7uWFV2md46c8
 89CGor5CJSa8VsegLNUDzsFeqApTqtrUS+29CIdhG+ayMqhB2NFZSdvVrIh8Rhqny0KsX4wqC2X
 fXmci8icxSummM+dvDUckMkzZkeA268YwbYkjQT6MA
X-Received: by 2002:a17:90b:3b51:b0:3ac:d19e:85f1 with SMTP id
 98e67ed59e1d1-3ae897dc967mr14751012a91.53.1793846186427; 
 Wed, 04 Nov 2026 18:36:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b0b315874dsm866687a91.1.2026.11.04.18.36.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:36:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-945c60b470dso215609285a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846185; x=1794450985;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mMANaqSq4GcsvcAjECinF07SRMy3T/n0++S+KBqJRx4=;
 b=hKiKjp+nKwwbSe+M5A96st2J+TDzPNh5pBjOlJ3nkcDem3rXyXre6DB6M7eQ8FmADH
 OsWJBzcKBQSI3OXsfGLAiQJ9w8opLCjau7E1QOvZ/v8g+qZa5Foo/vctEDUAPZKQQmP5
 oy3+ewafrh8rhprOXA+O9owfJkxIVZgI8dw5c=
X-Forwarded-Encrypted: i=1;
 AKwUvBySr0DBOr1tSTys9b/zMThJkVofaOLvc4MiJFe8ZQlcx19MvGtWD0NR1hGWjWRxsVQwnAF7gadTr7M=@lists.freedesktop.org
X-Received: by 2002:a05:620a:bd3:b0:93c:6ded:4665 with SMTP id
 af79cd13be357-944214cb617mr2864029585a.1.1793846185408; 
 Wed, 04 Nov 2026 18:36:25 -0800 (PST)
X-Received: by 2002:a05:620a:bd3:b0:93c:6ded:4665 with SMTP id
 af79cd13be357-944214cb617mr2864027385a.1.1793846184912; 
 Wed, 04 Nov 2026 18:36:24 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d4875514sm352304585a.37.2026.11.04.18.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:36:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:37:44 -0800
Message-Id: <DMMXFHCWWRFR.MUE8FPMJCZEG@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-6-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 27, 2026 at 2:17 PM PDT, Zack Rusin wrote:
> Cursor atomic checks select an update path and look up surfaces through
> vps->uo. That object is copied from the previous plane state and is only
> replaced with the new framebuffer's object in prepare_fb(). Switching
> between snooped surfaces and buffer objects therefore applies the old
> framebuffer's cursor limits to the new image.
>
> KMS clients can also submit a guest-backed surface without a backing BO.
> The check accepts it, but the MOB update later copies from a NULL source.
> Zero-sized MOB images pass the check as well, then fail preparation when
> mapping zero pages, so TEST_ONLY accepts a commit that cannot succeed.
>
> Resolve the user object directly from the selected framebuffer in both
> validation and preparation. Apply the matching cursor limits, reject
> zero dimensions and require a backing BO for GB-only and MOB images.
> Recheck the backing BO in preparation before mapping it, while keeping
> snooped surfaces independent of a BO mapping.
>
> Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 61 ++++++++++++++------
>  1 file changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index f0661e5effeb..9e8ea9e07f40 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -89,10 +89,26 @@ vmw_cursor_plane_update_legacy(struct vmw_private *vm=
w,
>  	}
>  }
> =20
> -static enum vmw_cursor_update_type
> -vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_plane_state *=
vps)
> +static struct vmw_user_object
> +vmw_cursor_plane_user_object(struct drm_framebuffer *fb)
>  {
> -	struct vmw_surface *surface =3D vmw_user_object_surface(&vps->uo);
> +	struct vmw_user_object uo =3D { 0 };
> +
> +	if (!fb)
> +		return uo;
> +
> +	if (vmw_framebuffer_to_vfb(fb)->bo)
> +		uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->buffer;
> +	else
> +		uo =3D vmw_framebuffer_to_vfbs(fb)->uo;
> +
> +	return uo;
> +}
> +
> +static enum vmw_cursor_update_type
> +vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_user_object *=
uo)
> +{
> +	struct vmw_surface *surface =3D vmw_user_object_surface(uo);
> =20
>  	if (surface && surface->snooper.image)
>  		return VMW_CURSOR_UPDATE_LEGACY;
> @@ -642,17 +658,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *p=
lane,
>  	if (!vmw_user_object_is_null(&vps->uo))
>  		vmw_user_object_unref(&vps->uo);
> =20
> -	if (fb) {
> -		if (vmw_framebuffer_to_vfb(fb)->bo) {
> -			vps->uo.buffer =3D vmw_framebuffer_to_vfbd(fb)->buffer;
> -			vps->uo.surface =3D NULL;
> -		} else {
> -			memcpy(&vps->uo, &vmw_framebuffer_to_vfbs(fb)->uo, sizeof(vps->uo));
> -		}
> -		vmw_user_object_ref(&vps->uo);
> -	}
> +	vps->uo =3D vmw_cursor_plane_user_object(fb);
> +	vmw_user_object_ref(&vps->uo);

If fb =3D=3D NULL then uo =3D 0 and that would cause a null pointer derefer=
ence in vmw_user_object_ref
since it's not doing a null check over there.

> =20
> -	vps->cursor.update_type =3D vmw_cursor_update_type(vmw, vps);
> +	vps->cursor.update_type =3D vmw_cursor_update_type(vmw, &vps->uo);
>  	switch (vps->cursor.update_type) {
>  	case VMW_CURSOR_UPDATE_LEGACY:
>  		surface =3D vmw_user_object_surface(&vps->uo);
> @@ -662,6 +671,9 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *pla=
ne,
>  	case VMW_CURSOR_UPDATE_GB_ONLY:
>  	case VMW_CURSOR_UPDATE_MOB: {
>  		bo =3D vmw_user_object_buffer(&vps->uo);
> +		if (fb && !bo)
> +			return -EINVAL;
> +
>  		if (bo) {
>  			struct ttm_operation_ctx ctx =3D { false, false };
>  			size_t size =3D (size_t)new_state->crtc_w *
> @@ -744,7 +756,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  	int ret =3D 0;
>  	struct drm_crtc_state *crtc_state =3D NULL;
>  	struct vmw_surface *surface =3D NULL;
> -	struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(new_state);
> +	struct vmw_user_object uo;
>  	enum vmw_cursor_update_type update_type;
>  	struct drm_framebuffer *fb =3D new_state->fb;
> =20
> @@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  	if (!fb)
>  		return 0;
> =20
> -	update_type =3D vmw_cursor_update_type(vmw, vps);
> +	if (!new_state->crtc_w || !new_state->crtc_h) {
> +		drm_dbg_kms(&vmw->drm,
> +			    "Cursor dimensions (%u, %u) must be nonzero\n",
> +			    new_state->crtc_w, new_state->crtc_h);
> +		return -EINVAL;
> +	}
> +
> +	/* The duplicated plane state's user object still belongs to the old FB=
. */
> +	uo =3D vmw_cursor_plane_user_object(fb);
> +	update_type =3D vmw_cursor_update_type(vmw, &uo);
> +	if ((update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> +	     update_type =3D=3D VMW_CURSOR_UPDATE_MOB) &&
> +	    !vmw_user_object_buffer(&uo))
> +		return -EINVAL;
> +
>  	if (update_type =3D=3D VMW_CURSOR_UPDATE_LEGACY) {
>  		if (new_state->crtc_w !=3D VMW_CURSOR_SNOOP_WIDTH ||
>  		    new_state->crtc_h !=3D VMW_CURSOR_SNOOP_HEIGHT) {
> @@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  				 new_state->crtc_w, new_state->crtc_h);
>  			return -EINVAL;
>  		}
> -		surface =3D vmw_user_object_surface(&vps->uo);
> +		surface =3D vmw_user_object_surface(&uo);
>  		if (!surface || !surface->snooper.image) {
>  			drm_warn(&vmw->drm,
>  				 "surface not suitable for cursor\n");
> @@ -789,8 +815,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  					 SVGA_CB_MAX_COMMAND_SIZE -
>  					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
> =20
> -		if (!new_state->crtc_w || !new_state->crtc_h ||
> -		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||

Why remove these checks?

> +		if (new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
>  		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
>  		    image_size > max_size) {
>  			drm_dbg_kms(&vmw->drm,


--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

