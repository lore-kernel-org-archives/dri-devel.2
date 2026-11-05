Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1C606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Sg7RfEuK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F35610E905;
	Thu,  5 Nov 2026 02:36:57 +0000 (UTC)
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com
 [209.85.222.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD26010E905
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:36:50 +0000 (UTC)
Received: by mail-qk1-f228.google.com with SMTP id
 af79cd13be357-93cbc3ab2fdso74160785a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846209; x=1794451009;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SG3mnPTkUQ4F9za/w8XE+qK/ulAJ5xkH8LniqYdvqGs=;
 b=PK2r0TlaXdkVAe2YG4XkwxaMIGm/r33JBqFcr5ZMFeNAy6Ob/mnwIxkvxHTS6229Yo
 d2+084gywLWoe0uTjeMnXFAsHYpFDffEqcyqlwr3kEjiiFPYKkPJX2kYnzeOkzvhJ+7L
 x/7L6xw8ZvJ4c7kn4kMRoeVEeR8VZA26IjzRObrcaudgRqbEbKohNsBQsLZwz0XxKR88
 wxeveWs9+50u6LobikwbbXIXHr65CjgGiJwmZEUwptKz7dhk4Y5Y5leBfxNM4vVLajIW
 3gaeePnh5wMCrXnUcOFVWPcvD6ntZs0X7eBBAwpKLtTL36cGHhJaINrIyuwraNj82aaU
 6hVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGYskzC53C9k3T0FdzCuFtV9eiK3g+reKX4b+7zECedTzRpekpF918c4tw9f6Vt7fWX2xH6kUd8yc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SgiKsc1WqRVSoVuQmAj+9Pd60hNUqtCCgYacVDrA1RUFlokiV
 p6dz2vPisVzFAMBRZQ0KrhhX8s+6QX04pOipwDh5k0QZ8KM+Z0vtAsj6ij8sQHIpTZIueM9xwEp
 WNQ9ncwmirbVHr8a/EOTyKgme97t7PN+6wSsXDxuMFbyhnxO5pYpTQgOxXR8JZBizsVT9dnO5nw
 7YA/qMNITzJkBZiAeN//cNMboVbpXR3tRWHOyPboqxykIhBLACcO5k+ZTOFwebh1F6+A9mUSf9k
 270x0Cj2zK8nVmjzpPkSchTLA86
X-Gm-Gg: AYBFou2Jk1W8vYQmTOUQ7QQTUGuAr4X2WqZZMJi4g5csWGIcjiS9oq7hgsCwd9we2lO
 rCefh2Kn6INajWb84q/6v1vPYUus/Pvi7iqVsSbdUMiOD5C7mmz1w34e1XBChWYehfsfPnuYUs3
 LdBnLl3xyq4kKxX6RLlt8ioe62i52+Q6NkBgsbw8iZSBQU0RLfUr32teO1R5wWRzMMCv7k64ihy
 YoUOwrB1dA+mozInV9BAX6fiiu9G7xQNvXLSrFOh3oQaYun6jIAwuC4ncq/FMlmVCB54NI+bBiD
 meXcs+VsygQEEJOODynww9q72dGhFmrQWqRaPEqhqPefwFFhXARSBnX6cVxfU7I8QZLj/zWcTSq
 iwgwUgNbHofS3GhE9iIZ/vVhi8knHFIOX7g6GohpcsN4y6FIb5vdU3NFWGy10wJjpgcZ9dE4+wJ
 ykwWELbNgolLTqG6FCfnPMe3PSOeXtc+dMHaluJU9K
X-Received: by 2002:a05:620a:1a20:b0:940:f224:5a63 with SMTP id
 af79cd13be357-9442178c510mr3084111785a.64.1793846209423; 
 Wed, 04 Nov 2026 18:36:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-945d47b76b0sm49460085a.14.2026.11.04.18.36.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:36:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c71966998so18993876d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846209; x=1794451009;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SG3mnPTkUQ4F9za/w8XE+qK/ulAJ5xkH8LniqYdvqGs=;
 b=Sg7RfEuKEh/pGM7BIXEvTVKKAD6RGOMpU1YQfKjkvTLlqm/yWjCDFROpUteaL+qDrj
 Yxv28G5jj0KEN8SdzljAWvkDkpG+ZXM3tHnCOiFp4SeuA5X1625abSLanZCpChJT3BG9
 A12V2XJkhdJ990pL0lJTvJu3EJVYBRvKNwReU=
X-Forwarded-Encrypted: i=1;
 AKwUvBxupAygir4CqlJ+YYwFnCcNeVP5hiGMrtZtFi5SdMf+IY+qWigb1pcdHPjMQ/fxal7JRAyHq3mwy34=@lists.freedesktop.org
X-Received: by 2002:a05:6214:5c43:b0:91e:9699:5f05 with SMTP id
 6a1803df08f44-91e96997eaemr14886856d6.31.1793846208786; 
 Wed, 04 Nov 2026 18:36:48 -0800 (PST)
X-Received: by 2002:a05:6214:5c43:b0:91e:9699:5f05 with SMTP id
 6a1803df08f44-91e96997eaemr14886616d6.31.1793846208186; 
 Wed, 04 Nov 2026 18:36:48 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7e7b1e92sm35327436d6.45.2026.11.04.18.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:36:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:38:07 -0800
Message-Id: <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-3-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-3-zack.rusin@broadcom.com>
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
> Guest-backed devices without cursor MOB support define cursor images with
> SVGA_CMD_DEFINE_ALPHA_CURSOR. SVGA_REG_CURSOR_MAX_DIMENSION belongs to th=
e
> cursor MOB register class and reads as zero on devices that do not expose
> that class. Applying this register to GB-only cursors rejects every
> nonempty image submitted by KMS clients, leaving Xorg without a hardware
> cursor.
>
> The submission transport also limits the command size. A 96x96 image fits
> the 40 KiB FIFO image limit, but exceeds the 32 KiB command-buffer limit
> and causes a device command error when submitted through that transport.
>
> Validate GB-only images against SVGA_MAX_CURSOR_CMD_DIMENSION and
> SVGA_MAX_CURSOR_CMD_BYTES. For command-buffer submission, also bound the
> whole command by SVGA_CB_MAX_COMMAND_SIZE, including its header. Calculat=
e
> the image byte count in 64 bits and keep the register-based dimension and
> MOB size checks for MOB cursors.
>
> Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB curs=
ors")
> Cc: stable@vger.kernel.org
> Reported-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
> Closes: https://patch.msgid.link/20260830151619.2452307-1-yunfeng.li.nb@g=
mail.com
> Assisted-by: LLM
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index 942d07079ef7..14490ead99cd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -778,8 +778,27 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  				 "surface not suitable for cursor\n");
>  			return -EINVAL;
>  		}
> -	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> -		   update_type =3D=3D VMW_CURSOR_UPDATE_MOB) {
> +	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY) {
> +		u64 image_size =3D (u64)new_state->crtc_w *
> +				 new_state->crtc_h * sizeof(u32);
> +		u32 max_size =3D SVGA_MAX_CURSOR_CMD_BYTES;
> +
> +		/* The command-buffer limit includes the define-cursor header. */
> +		if (vmw->cman)
> +			max_size =3D min_t(u32, max_size,
> +					 SVGA_CB_MAX_COMMAND_SIZE -
> +					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
> +
> +		if (!new_state->crtc_w || !new_state->crtc_h ||
> +		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> +		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> +		    image_size > max_size) {

We should have a separate message for image_size > max_size.

> +			drm_dbg_kms(&vmw->drm,
> +				    "Cursor dimensions (%u, %u) violate command limits\n",
> +				    new_state->crtc_w, new_state->crtc_h);
> +			return -EINVAL;
> +		}
> +	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_MOB) {
>  		u32 cursor_max_dim =3D
>  			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
> =20


--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

