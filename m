Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD4606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ti0u3oCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37F810FD79;
	Wed, 18 Nov 2026 14:55:21 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02A910FD79
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:55:15 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4e5c8b3facaso17630b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795013715; cv=none;
 d=google.com; s=arc-20260327;
 b=U08QKPbmAsihnW1cu5QPq02cXpokZ2TJKMIW+NMdxHSfJdQEBy7hQp5JrcZLuDfDvR
 bBZgMQaVrTSX0FMbIpL1I1vP3uu0kjQbEGhTUo60nEG35KPrV4X36zIB9o+YMTuYSG4o
 3VoX/R9ILn4GwbmMeknf9tT/o12MPOaqxoN285l3dBZAFdq9zpAa2bK8l7MYw2XDg/9W
 hVTadDOImNax6ewCUIGFo4mjwZ3q4k/RMrMhy+XK2SqyA9NmYyUyYajsq93zMrCVNeKA
 flVPtFIT+irjd8Nc3BeK14Gquvkde7tUVQ2T00++JC2muA2OGjklPji20i33b5N5YQi4
 KYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 fh=9sMPqOaThU7CBRCgvIvb/sRy0Oc+I9lYvzKXvfg5wFI=;
 b=IYIf0SrvFBxctUAQpXgWbeeFsD9/dKuoYnE0VeKkNJcFOOHh3MSiyAxC0V8XD5BWET
 PLscJWh3udpHrE9eXs7HKlLGsjbZrNHfFgduKJWa5iOFuFRx5xcpzvJQaDV0Q/O5RX6y
 kRA9JWCdFxwwfpikcYoJuMTxyLozuHykizUAFFiZOYuJc2UZPqnr9DEcCJ6RBqvuWN/e
 JDA5RPtb19u1uM6KqKkO6l8tf+S6vT1tB5qG1QKJoCVAU79ts0xrFxMbpelE4V1whOm6
 DYQihfAfu7lnuncLbY1bOu1VCI+O12lr78A80V1g6IGIzTz75+EAwRPltyDQLtMSlhAM
 CCoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795013715; x=1795618515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 b=Ti0u3oCPtb8fwptf4ZHRPexWvAGE5yzUpxbhbskkqtlqip4Z74gKCOqMYYio80g4ev
 JTs3vMo6ojTDG0KKFUSu9K6iV29C2bsrSYQ3f26YJRvqRzVf9cufDanlbqhcs0RpKkU1
 GXgpGA4T2k9xjIsIbC7zgEX/y0jvjRyGsSJwvBXVTOIy9Pdk+vNBUGnkv59eaHMljECX
 MKJ1iZL1cztvmYRrKRw9gVTT79ejclK/jVK7UitXJh0QSedK8dolbzDfr41GB9AmsNzw
 CAV+baUWNitzlLjAgQ4EYcPNy6jtGDLgPXTR0nWlpsSNPLZfnUAMPxybKbmgiNWoWYIe
 nejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013715; x=1795618515;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 b=GLNb+yVsqIyiXJ3n+45MyP0UsL5MNMx9LTbQFZpV2glhs+0Y3DorlK+UVUf8m7MLif
 Y434reecYVggaIR3j0hmRreGfT6EyloFkOyXYlnbrs4lcbnt10J78tIveivAobYb4Igg
 P/lq1gdHTkr+maP0IBrtP6ovlwMhfZUDRJgRA3w5reASrDYej2rFRih9MZlvxw//Ed/L
 otRjvHmPKa+bJWUzoq105J+Jtr5VhyerEsFwFUYz2xi9QvU3GLHQBmr9QeYdqg8gxeQV
 WJ/g2cb78wclzJO+KtbijUj5j1z6zFfYOIWS9TjrBhWo9hiTj7LNxHymPb4jfQ+8Sw6g
 jlpw==
X-Forwarded-Encrypted: i=1;
 AL+hErFOsSEQyuDLSopRuTL2SXJMSobdE885Gi1aVs+lzMEioQW0A98fIb3R8Ib0wnipgJzFZXVfMBuc5Q8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9t60LEAatzC7qHGfmJ5apSiBNDOZ36IfQIelsklYz7e1jYNPgc
 sMWZaFhs09CBAv9rcaK/HTs3jrzrkuWjsBV0unlQHcItuyxUcrqtT785zk6GC+oh76cH+sdefRN
 75o7mB3TDATFWhzxK3eURJe+l9IVvOko=
X-Gm-Gg: AYBFou29EKmAfHqvQF1DTFqGuwJeF/9q3k+34M1c0P90ckWsJbBKXPFBiyxtIIPHK5a
 JnxNqam6thTEuNadY/AhUjjopH6205d2yfGd3RwSysMPd/a0Wr/pEMEMYDglm65ftLTzi5+ra8l
 4cm3/7OTL3L6EgPm4Yhb/2F79v79xwAQjP9yeIey6HK1R4+aIzMJ/VKDdvLCEhaUrlbNMFuJ5Ey
 tKvpwFdUfYBddhtSsJXZH4v3wXkkGiKBVrjXD2dtc0hKc4MVOMAZG+yDggkPphoThjrvU5f3KyB
 yN+ekVc6l9Xz7xXUJ6hc/QlNRlMOXc7VEfdztSg65KDzr2mhq/WvLM28JvsGP6FLFkD0iZ/1ma+
 X9Yqa/h4gIZatjQHPeKCKUfgdlRAtkhFVy3AKJa0uep7VfBmeqPGsvkk9Oxy+bvCdss0I/49JrD
 6BIN2E/WI1xeApVnsa82NE8mjJ4f9kc/+XIAZTUJQtR3jQlsS2elF0LxMH7vCh5yhYcz0uvg9RE
 QhUazjN
X-Received: by 2002:a05:6808:50ab:b0:4e8:b729:3ebe with SMTP id
 5614622812f47-5773cf28fa9mr4891107b6e.4.1795013714673; Wed, 18 Nov 2026
 06:55:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Nov 2026 09:55:02 -0500
X-Gm-Features: AclHuK9S-4vVMS6uriyFTd2kN7_cTAz3DiLGyu1_3jE2ITmklct8mvSQoJDun6g
Message-ID: <CADnq5_PM+gdgDfBQGdYLOYZ3OV_ka2+1SPrNCh0YLTUwvzQSRQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: use a single clear entity on some chips
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 18, 2026 at 9:50=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Workaround to fix failing tests until the root cause is
> understood and fixed.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 8dfa92967b63..d5c1d044403e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2411,6 +2411,13 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_=
device *adev)
>         sdma_ip_version =3D amdgpu_ip_version(adev, SDMA0_HWIP, 0);
>         if (sdma_ip_version =3D=3D IP_VERSION(7, 0, 0) || sdma_ip_version=
 =3D=3D IP_VERSION(7, 0, 1))
>                 num_move_entities =3D 1;
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 1, =
0))
> +               num_clear_entities =3D 1;
>
>         adev->mman.clear_entities =3D kcalloc(num_clear_entities,
>                                                 sizeof(struct amdgpu_ttm_=
buffer_entity),
> --
> 2.43.0
>
