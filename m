Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BkYZGsDs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3BB10FC9C;
	Wed, 11 Nov 2026 16:58:05 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965BF10FCF9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:57:58 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36ecc11bd26so92547eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416278; cv=none;
 d=google.com; s=arc-20260327;
 b=TRSyVanYq2SECtAsWcy9fD7ZqvDCpLCB8CSI9lLkbXj7KpGV+exPLttvwR2jh8DLU+
 +QP7NqwfQ5BEdNaqYO9uBEwvebSbd5I/nzebaLAhYfNTVOPqnaYipAUgJ8eq7hiSQA1x
 O/jZ7JLuBnGiu1wsoGG2aXqVlVj01RRreiJVEb0q5MQehv2cUM2n3SUpULmMPp4zKTPC
 xTmruUhMGi0aYIti+n1LXJvOq+V7fhW0HPr9B/0sHIWTUTtHanRLJRH+N9ce+uRr4TDi
 /1R46V0CIWj7DfLpo7eRemmYwWT5zfSpngJSjNTIG9d86iDUi3PI7+IPwQqWHjYeDPLU
 n0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 fh=ICxhkdAWfe74jzPXEoL5sWhpHNEzUxmk5DvlCAMcuOM=;
 b=jExKBPuB0MWNefIkGDZQAon91l4r9nk2Qh7I7Eyo8jszM/z+HeeCx1Kl9oKCpqEsF0
 AOff8HiHF8ww4WXe99TRkyDD3LKPJpkAYYLNtnBjtZL0MHBOUrj+H1myFn33VHbJtWQx
 WVEZu+D8zBg3QspUVN//bO6aVFmGneD5F1F89xyuNEcVbZfiideD4I6khIBwZmE+g+Ky
 KQA661CNCJrk1pEyCz+Iwg7QMUyuGBMO9OqO5fFFmmfzAsoKKKxidY1YsLuEJ4tC+T39
 uVnnDtgwbCJBuQL5IVehRlXPTqY+2KWbKoPIjafsSrh5kHGDGy5oPyiT9agjf4P3Sf4I
 RBPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416278; x=1795021078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 b=BkYZGsDsJeNvNbDUdnVixaQgNBiKnweNd/tJhV4WKAT6cBrG3C95KW9+EvWdvAF1GA
 41kIo/7mya7pvn/UjfN8wJ12lX6qUPmc2HNyVSgVCQwYAZIi0JQm2QABlUaYTj+gET4G
 VhmuIFjT4CnHBF+7tAubTCVFUE2BOxSsDuFfvqsRdz7yRLJDBlr13ddnK2JKHrfoDKG5
 89NgPrBhg2+oIt72PlshkR6dtwWttcH2XXXPQkPL/N1cyCUGL0KMQZPsBt+2G5Ksg61Z
 ALxS3b+aj534RFbd8F4oTmzuKydtQSyhtZI0NHGwVf0dnil5lynA2/nbqSus8urV6rTa
 Y8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416278; x=1795021078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 b=sVNDBNHaNd+VnTOvfn0O3mmQjttNmXipvBA1TO+ij+nHBTnABkZvHAGnFMgyF8YPk4
 RsY91QxegPULwtSv9a6fbQTye6Q9v8ouLU6zM2UT7hdcDSZF8UBHpx14d6rEWrI2Smu4
 zm+0idWJJOyodAbWh8WGf27RroNQ0m1uGGif0xpmcak3IjIt8n2HEFcnh7vV62dTu5Et
 iULHFsz/yIGPijmNeTf2pKZEau+79epSUh2CyfC82UaF4zzWRQYCnKMCcn87k+s+lbCE
 GGklnOWUUUcJukpFQLIg9GuKiBeCK+TCwvRZIA4B0rrqCY158EpeJ4sMj+BwJLaFfEqL
 vN8g==
X-Forwarded-Encrypted: i=1;
 AL+hErFNtgspNHDKp7Z2qHauzIEQ7zepYevkCH6lYwd6AU53c2geEc4EA+nJbclnXj8b5wKI0i0SOtkDMvY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/OMPAtWoDLaFWwX0jNP+u/rbfsmAVhu1IjRagiN4WoB8WhvG1F
 xmke8dnl6Bm+sKcTDJblsphLHLK/2yMZpsTjdM3TJA/9u/XnCXbtNh1t8UjPPpQGRs/xI+pOAIe
 KGDrTjMTFUd8YjOu/TJ3CWavjUmDfVS0=
X-Gm-Gg: AYBFou1gcHCAcelNuh7Z3MQlsi6agPquN4HEWcZH8m0BlCNHkpcKOowe3a6YOII9lGk
 IJO0pbr47b2K0F24N0VJO1R9RchFRY9q3tNFQDix3yHApYdSZWcwVfFyk0kvlLPlmJn9KqeD51K
 +GKhvhZbQFQaTjjgvsekUAwOOsYAxnVFjkI+tG/2pDUTcxmUcmCggzTeK2d4JQMIklv+8OrPBYR
 nuduvjVo/7WZgLJHunpP3NgixHY99H4Y5xzqblEWpjumyP3kb7Y1L6Du/GPtVK5QZtNrjXvdYFE
 rjgp43m1UymhEUa8aePsuLMGk9QpFXlGSUAWSSzpbubt5XghZKmF8eyDc+GoJx2cEC4uNgiHZqQ
 FFRnnmaTdqjaNE8+p7ugVYdMZqNcrPRHROaIn1fn9gVEgoXzr5JA3FNviGdE0gbvUSkOhIRUJpZ
 fyPjuHZESE8sogkPvobHnJzgYKOa7+wss79y4hDz0r+jXHqu96dmDQrJad1jA/HD/mnIzVIkiSZ
 53KyBWs
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4291753c88.1.1794416277403; Wed, 11 Nov 2026
 08:57:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
In-Reply-To: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:57:43 -0500
X-Gm-Features: AclHuK-DMzwioV5PBa5WXoevsVpI761BeBU3ynr40SlnxuCKodphabVoHdQR7zc
Message-ID: <CADnq5_Mp0dxiK1cJOgkCcHap_0y4GhwnW0E52PR7gkySnkMk3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: do not dereference NULL vbios string
 pointer
To: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.com" <simona@ffwll.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 4:41=E2=80=AFAM Noah Weinberger
<NoahWeinberger2003@proton.me> wrote:
>
> Hello,
>
> In atom_get_vbios_pn(), when the part-number string is empty and
> atom_find_str_in_rom() cannot find the ATOMBIOS anchor, the fallback
> computes NULL + sizeof(BIOS_ATOM_PREFIX) - 1, i.e. (unsigned char *)8:
>
>     vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64=
);
>     if (vbios_str =3D=3D NULL)
>             vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>
> The subsequent range check is false for a near-NULL pointer, so the
> value survives and *vbios_str dereferences address 8 - a NULL-page oops
> during probe with a malformed VBIOS that passes the magic checks. The
> recent hardening of the neighboring date/version/build helpers closed
> their OOB reads; this fallback path was left intact.
>
> Simply leave the part number empty when the anchor is not found.
>
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670b=
d (v7.4-rc1, 2026-11-07), drivers/gpu/drm/amd/amdgpu/atom.c:1491-1503 (atom=
_get_vbios_pn).
> Pointer-arithmetic-on-NULL is pre-existing; this window's hardening serie=
s made it the sole fallback outcome.
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07);=
 every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

Missing your Signed-off-by.

Alex

> ---
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5..7598606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1493,8 +1493,6 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
>
>         if (vbios_str =3D=3D NULL || *vbios_str =3D=3D 0) {
>                 vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX,=
 3, 1024, 64);
> -               if (vbios_str =3D=3D NULL)
> -                       vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>                 if (vbios_str >=3D p_rom + ctx->bios_size)
>                         vbios_str =3D NULL;
>         }
>
