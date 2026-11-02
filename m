Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E826082618
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXKNynng
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BD610E635;
	Mon,  2 Nov 2026 16:15:04 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1A210E635
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:14:58 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3550dd02c9cso270307eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636098; cv=none;
 d=google.com; s=arc-20260327;
 b=C7uQbIWTU+qcEiUAT5iljJt2zLLgx8ucdnSVsKA0LwDxZ5ApuxCWisyb9e5mBd+Ify
 meemGY816ofpUPlkmSOsMq6rR7aTrW4kImwOQnxES3Hk+Z9j4WwjoCzEhkgg7pGuiNC/
 g+PUasPwUFQuKkMM4cUcgdtkyM0OPgwf/cLnF3IhCz/cGS5OkL8qTuH+77I5DZIA9qK/
 HtvCNWBupLaaNsxnyrKg/l67EDfWSCXOfAuGBChWMHZ4NHn2WQ1bF5uAt0zrwCdvUNwb
 YqcYJjfoeUp03M2kYhPXoOVTZd3+EzK18H/GZmAypWjUzyffhoG7MUbKOyEjy8pqyGC8
 p+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 fh=PJ70wf+zUBhAnR92vUArdXvsVUrUxBFKp/b/zL2xP58=;
 b=YcdxbZ6sOfTjS+ttq/73NT7+Ummte2nDt7cHiwVSJuxJ/Pz90ifEyaCAnW7BZfPJNV
 Cp8IeGlU5NRaTnfuX7tsaPdDeReN4l2b2Qt+Ry1ZBGyuClRivyvOI+vZrmOytPEmsmyf
 sgctDf+R2/qcts+gffwgqECgmnL9U5oy17dAH0Dr0cw1a+yD7FrgFbh73uqEcB8ZGCRB
 Eju/qOa3rJRctH5Qreh73wtfGGi6JDaLtTvLXe/uLlEVkzbG+J0Ir4EUsjiNZJOYdohT
 j4BqNPz7/7C2tubEr/7fbtG0un1awWoTr7LQrGpQ3l/kWHEs7SNe+okBWwvYwDtbCtP5
 LFqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793636098; x=1794240898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 b=iXKNynngMEoLXGmkfhN0dbual5BtAbCUUBPeA4KyReLDl9yhiR9Z3tIbun77Xv9xp0
 bJV5ALdnQh4njfDCAN/voGnPqID91UfJCR9gyqlMI31mioqRSHkYG82kQX4H91AykScT
 7AM4srUAPyNzgg8CNjv4Z+m7CIpubMC5xhHsB6WnPBZc/eGcVe1Rh7Kr9+qimipzraKv
 ReJtcMuiZ+N94nLX1tZh69AeJEosLmd0wIkMIvh3wQZkxSdNUbGM1lOnC+n8PADY75Ox
 pjgWM343wX42WnIIqI5E2G6JsPLStXCSnr2Ec9yYNFWOewWrjXZUedTX0ZqQkAV/aR1N
 gzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636098; x=1794240898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 b=JB2YLVp5FkUDubgxud06SjI0caxKeOrRMxY7xQiFtoki5X/sOHm8eYHCVO5++Vc6ep
 twOMkX5yECC+McYQKJ5JICoJ8LGV9lbkx/9I6BW0709Xa7z1C+An8vFcLF5PATnWW8wL
 q0+2AWUvm+kHtahbjVeGvNgLhJnomOV9s97j8IQWuAzwiZMQalr5Q8jHKPQdmWN71Pnn
 FcK31IB03PzjtToOGURWZLUaLsauAXqFXHADFFcDTb1gkAro0Z3BX1Mx8kRpcCVOx7DE
 3f0BqmmNLEYb7keGkzYVX4UJ2jgbzYdGdmDlzVxWqGRen7nDk2ZgVXdaGJssrMkx+NEJ
 YRfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXY4LIQ8RuNqpRj6/SmzNPYvvTdVWoGRHQmeAYYyyhOmc1uhLNDIz4mY4uq6cUM1CQcqAap95FX+Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIoPyp9tmR4TrmCsbok8W2/8UyTCb4bb7DuQnqIezQ7QfzV399l
 kN0nAreypq9acKBQdzgL8qSrk+5QijqQh+Ulxf94sah5wB6z/eiGy5asyV3gjkVOXnValbCpiRf
 7FlkFYvNby57UejyjuuQrqoZ8sKtMrWQ=
X-Gm-Gg: AYBFou3VHCb9coeh78Mq1vAHUJFSNNv3ao9yRsfuZAm0l7RhLOjxdkzGaXIKx415ZYn
 YBuM/4Y8S+bqOkoJBxuSztoTJ7JoQev0uxe63ulS5NkI1lKfwSLFGOxoC+IpALyTYYcUoy84LK7
 E7v98Gwujtm8FB17K2sfvFlj5mzM6/vwVqAJBiqNfRBhInL5LXbPr4pDmJ7fCj3sfunL01DDfu7
 SUA+I8/oHgwNT8S/bHXPCwh73fa4zjUu8H7sQXUS8H+hifRdOSkExf5Ak77iLTELmg8U5lbet05
 yl79R1julIMssGVxwrh199FuDlB1vS0F8omAKmktpBjoQIOHCo5/NgWBBEvbRxJnFLsRwJgDQdQ
 ro4hDCZrurAu12klRo64rBMkDLESwpGEFlioR08pyeOqAxAfK9qyBmaEjffeBU2k69wtttrpsDt
 ZswrpyVYEkEeXWPPolTELpd1W+FGgTPKHCI7Y+F3iVhnPE
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr26290103c88.0.1793636098164; Mon, 02 Nov 2026
 08:14:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029170831.915318-1-tristmd@gmail.com>
In-Reply-To: <20261029170831.915318-1-tristmd@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:14:46 -0500
X-Gm-Features: AclHuK_JcRVN6W2vlVWf4f1-FWgd_LnG4QSNqF29fy2tI4WLRUhM7uUGnOkvvqI
Message-ID: <CADnq5_P9fh0dDU7-vBiBPEY8iNJ2eVZS1kojvObngsYQzb459Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: validate ATRM return buffer type and length
To: Tristan Madani <tristmd@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

On Fri, Oct 30, 2026 at 5:13=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> radeon_atrm_call() copies the ACPI ATRM method return data without
> checking that the returned object is actually a buffer or that its
> length fits within the caller-provided size.  If the ATRM method
> returns a non-buffer object type or an oversized buffer, the memcpy
> writes past the destination bounds.
>
> Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
> accessing the buffer fields, and clamp the copy length to the
> requested size.  This matches the validation already present in the
> amdgpu counterpart amdgpu_atrm_call().
>
> Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX ha=
ndler (v3)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 1da6bf1c17ff3..579ba1c1f23a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> -       len =3D obj->buffer.length;
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER) {
> +               kfree(buffer.pointer);
> +               return -EINVAL;
> +       }
> +
> +       len =3D min_t(size_t, obj->buffer.length, len);
> +       memcpy(bios + offset, obj->buffer.pointer, len);
>         kfree(buffer.pointer);
>         return len;
>  }
> --
> 2.47.3
>
