Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EA606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shpXOPHF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3E410F61D;
	Tue,  3 Nov 2026 14:44:17 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5423910E0F6
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:44:11 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1af971cd9f9so196840c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717050; cv=none;
 d=google.com; s=arc-20260327;
 b=ULrI8Bq1rn9EzOa0IvK95z+TMGlQEHj57pqKaup5JIUT+FmGj+g1HB/4gmtO7ejdua
 Ol6YQCczDLyw6SioZWPdfHoee0hKkCbRy2ch8AbQN0Jjwq7opTMn/VQ1fuEg8cpOxa/m
 ZSESPzv0mAIHuYXotAPnq9QMZ1XEHjqN5QHjvQTBOHYPa/8abGz+iQwgAM7WDrQ5kl8z
 C6sBcOymfO+JnaxOVgFP92SbQxToUi0LY3WtPQuacjNEBF9pDm/drNa1BHAITRLB4dob
 9KbprwclIxIOopzpQmmzJd5+P4A9IhbNh1svieN22jxpexXVdIA1DFOH1anAVNu4zcVy
 3O0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 fh=8Q56oWoR9btfyGv1u0SUDNhRBG3h4Mc0kOYnaDACKwo=;
 b=UQTXM0m/wVHw/1w4czdetJdGJkvakWoudlWmKtK+XIhFk29ONRhS9Qvi2CiS3oj+6L
 NKQWa7lDdIL2XPqDCl5aHWexO0rxKYSTXDtiuwbvQYMPV0Yu2O9ixQ8asO/8vcpHEsgA
 AplJKOO62zk3hkOZohTRPvhSl//YrLvBwpfOv+V97Eu1m6iQA6aSLO2J+NSPyxEBJQew
 HAYxy62IqA/+niAjHgbm6oaWzXYVVDZcsAhWPuRXYumOKzWNXkVLAqDQ270YxkPgp8gN
 ZJzru3jeKvJlCZScNXuxkWQrYfqODVo+m63cYGxUfhlVlT1/XgHVTDyUCE5Y9ctYOCQr
 e2cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793717050; x=1794321850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 b=shpXOPHF7uOj7rXQVXdLzxR8IhwEOjrcd7dj0Ic77TBK41VfUU81aS1rHnvnikJDN8
 FObjKYnpGrWSe80jjJiwbHEvPmzTM5c9+yrHPvvP5T8xCXcraeX+FKJ1o4j8yzD2ao9t
 TqKNkEhiNcLrsieRbMlzgvtZH5wISnyo0QQYAtH25hzU9rPqu9wRaTZfgOrm50aXQtIO
 glefnMmcZgCGN8Kkt3osRIH9PlAnDyBkdxnVi1oWdqAJbgG6yf2LFZUlc441Yz4cbuXV
 WAsUYJjLV50E9h89B241M4NQWbei70G9uf68iUXfqUCt3rKbEoAbpb0F+z04n01Fb7Yz
 Z8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717050; x=1794321850;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 b=fz6+euvoAO8aTUBhUG1/HM/RjsDoFGngTzE33KfYDpclnYu8ZhJsJ9wKqpx/oRa2r4
 jQYiXJdHS4o1RVg3a/an6D4QuzvmdNrFjdnyfNn5xiLPy/YJJSR6pxLOfZK0Yip1LA4X
 pHr9ggRRFGK0GI+JabitYUMgLmy2HBlZmRmTLoX16o7GY9/WaDhQRZwlwAvZCk/rWQOT
 9OlFpKDwGxi50RRSY1El0ahzt80WBiSd2RgOQUWpox1ugj7hg/mQRepwAKSrIOu5ZnG/
 jLm67SkXLZV9y5h2FUzlKhPMbWH7HehXx/unu+pmz4TUHXJAoDkukaUe/2CyCs7BYkbG
 1g3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBygU5VLxovgkTVABEZfoIKFrlOvSoitoctSgh19Vi8yIPDXm0LHTlnZZP+KWPdy/Wb7M5JJUY74h/Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95XsMA9YoldxS7jn4y7uf/YG52VWZfFibmNtLOkpVJjXiTiV65
 J/TS7sOzPhcyLDDIj+e8ukJI9oyvMZnPULyYUy3Z5URLqxLYGvYv5za9KW6mJSLwiuntzb/w/AG
 2083zkAzAloW62ZW/UnunTNROlFlMEaQ=
X-Gm-Gg: AYBFou3ztgZPbDQ2ur/1b+mSo7OcE7De6O+HVzm+Hudl6hQ7l3qRl22W+/poYx3VPo/
 9MmMmM9gqu2Ub+YDx+pJtKQGqR75KUcIT0RooXEYg41tNKJI8+OWFdFbG1ExxoeKZM2GM/eDywM
 shybYAOlrpWHVzqC8Myo2mprGIyXLPNBtnNxitYiDQ/VVIPZoozXiQMdY4C5lWDENmS+B73KEVR
 nrloKFkxON/6WFPVQTiQ7zL3mVBl2qEhmedSdAfvYYnTgPueHoG4OTnHdLFhZWJBk/AsZV1QtRW
 J7YZXkQyF/qdTr7+KsjmUkIu4Hx57hTL3DrNRR9d+JhWrRCJVexGXDRnDau9efYMojYXrOOqEjH
 0IERb/6lwTD3pvlZ3lS16QSfYvYCIjGtKEasJ1TyegfL4YqPb95VGaeclf1WcNlEXEBwFygYB2m
 4Y7xnnkiSrAVMZe242mOOdU/6/n0UTDngx5UgO2tL3sZ4C
X-Received: by 2002:a05:701b:428f:10b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1ac4f91ef0emr33223893c88.0.1793717050355; Tue, 03 Nov 2026
 06:44:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103114053.73761-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114053.73761-1-k.chen@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:43:58 -0500
X-Gm-Features: AclHuK80YDWXw3RH4Lv7ORguPbCuG3Q8k5HJ1e5r-PWy-1oFZs2Ug-jOTbIa5-w
Message-ID: <CADnq5_Oax1FOEx=oGA07rWsWq9DspU6QNxnXv1yR0UAG2bA6jA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: reject invalid ATRM results
To: Kang Chen <k.chen@smail.nju.edu.cn>
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

On Tue, Nov 3, 2026 at 9:21=E2=80=AFAM Kang Chen <k.chen@smail.nju.edu.cn> =
wrote:
>
> radeon_atrm_call() trusts the buffer returned by the ATRM method: it
> copies obj->buffer.length bytes into the VBIOS image without checking
> the object type or that the length fits in the requested chunk.  A
> firmware-provided ATRM method returning a non-buffer object or a buffer
> larger than the requested 4 KiB chunk can write beyond the 256 KiB
> VBIOS allocation.
>
> Reject the response unless it is an ACPI buffer no larger than the
> requested chunk.  The only caller always requests ATRM_BIOS_PAGE-sized
> chunks inside the VBIOS allocation, so checking the returned length
> against len is sufficient.
>
> Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX ha=
ndler (v3)")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Thanks, this was already fixed:
https://patchwork.freedesktop.org/patch/764437/?series=3D177235&rev=3D1

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_bios.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 1da6bf1c17ff..c23892470265 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -183,7 +183,12 @@ static int radeon_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER || obj->buffer.length=
 > len) {
> +               kfree(buffer.pointer);
> +               return -ENODEV;
> +       }
> +
> +       memcpy(bios + offset, obj->buffer.pointer, obj->buffer.length);
>         len =3D obj->buffer.length;
>         kfree(buffer.pointer);
>         return len;
> --
> 2.34.1
>
