Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CEBF54AB9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CF610E6D0;
	Tue, 24 Mar 2026 13:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePsdTKWm";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006BC10E6D0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:32:03 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1277863a912so507096c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359123; cv=none;
 d=google.com; s=arc-20240605;
 b=WH9pYGX4Mu2BiLWwXK40Q2fU8v4qXlYMD2Jajg9cPFV2jgYb9G04FqzOvlJXXUvfsA
 4mrSK8NL34IN+pULG/jAiQXZG5anEgzABA9UHItD1WCk9wvTqeVY1eA7yfKk53NSYiJD
 1z3nmqgHkN9VAF9M8Nv6De3MMKEwd4mZbtHHRYfWknLRomwZ8+mQhMsapzJqMi6DjSW8
 xuSIEZ0JiHTVDL5GDtpWSv/y+0UPzCu5OK2DkHbYYif4b6sEHITLUcj/MQMTbG1mXn3U
 Q7/EWOMzKNSA9TsASCheo4Gxa+Cu6p1tS3BDxBXPfbT03OFXTDK5yEJghmHCHDmbp2xP
 dJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 fh=2wmsj/IAQHbcllOQdizRK2Ntg3YRPEE2Ll7/OKMliTk=;
 b=YtmT/fa4w9Fsp/D/IKMgTlQ8yIIUnx2eIoOsT+VTQySDjsIsRlxgAdlCiTHMnHHYfx
 h/8m0mjZQmZjPAKTlUFK4sMvCx98HuGqsQrVlQR3S/Pt16yErGjWkSU4a3I1VAuwNMKq
 ANCkd0vV0VVLjedsb7NN/LaMeqfEALoNuo9RsKXhN7p2Yi+5/CxKM9XCl3i7QtI0gXN/
 v6Sb2Rh9+9QtO588W4XxA7eyx+t9U8dRuVDi2d6RtvuQuTrgMEFj467EApGiNwlIgMAJ
 VaZ820joTQubtMEIqHGZ2ex/L5m0GUheOFAgYJNlZV8kKLpD3DrkXZcsh1VT/0T1qcPA
 0SGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774359123; x=1774963923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 b=ePsdTKWmlKuBLhY5gaor493LRdIvw/A9fOukZ3DnwdE2Ke2GTeZHcrOK4stEuEuX0W
 GJhG+RZ+lmyMq6c4JqoIV5s/TSoO9NZFtVdgEQ3ryPjx/WESg0phz+JcAp1EJF7W8nbO
 ISaeDgZN56cjUhirq4KIApK8sC5Bo7HN1f1Ih4L/lBUiU91T9TaW9llOwmKFQ5v3Tqy3
 mOJjAz6UqvxQlGiQhBu9/wFVIf2i9bfhWsfgUIXE6ftRtvSYzvmFl6LPwFJC2reeJHaU
 jlj3M+HBFdONmXCqpMkxYetZhgd/n69YpWJHpFLodCIfriQxf7U19krfyNQb7cVjKXNi
 eqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774359123; x=1774963923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 b=o1FR8r3p7QHXc52iSmFp/TxAU4ehIFdpkFPPos1N3rrh+7n4cWvd7As8FdpxesWmZr
 Y33yJuze7epIiV0ML2AmPwNUL20hzgJJ+ALZQkFFTXTyfN72WDucAUpKrOIRGQk0wj5t
 6ywjJFElOaCHiTd4307dSGvKzI4UPjixdGZucZhnqLTj1UTa3Y+Y/8ImtIYUKHct4rpF
 bHA2oqhzMKCeeVi8c4a1SSbQPQhkWTTC+1JqMxstWJrbb2LdR3d+2EBSo2sjg2gl4GBi
 ZG/VuEKqSsyUg+A6VSPKd9MWZzxMvE2Nkz1n+tsw8hA0FL8ha3DgxxJiUXB2SiolASlp
 0vVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY28tRt4ikQ07agMBi0XDApDolcHsSYGKySUbnx5PqL9SAUYdRrfdYoVTkTonbySDDEWqK2lpwECg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw899bzAaAZqaX0FSA3PLKHS/IpTiPBqA0+SUELfm/GIvBIILnB
 Y8blYWhXVq8w8PyYKnbWZ/6GZw/73y+DbPrGG0vQnIioNdLfLb76iOk0O0oxTZcVYJ+fEU4t7j3
 tKimFCtRaNy7wLbdvtpY8AjV9E/FmNxc=
X-Gm-Gg: ATEYQzyZf8NypAaEWqR2o+s1cgbCeEudkgh/gNObL+tYnCc/gHK0tyuh3klnm8ezcOS
 N0qUqK1LSvMEDLi197QM+mo12Z2n/566Crv4yFXA6knFhNQp5xFsbhKmWxujU+X1Sb7X43/n9b2
 JFB6Y7Wew3LszT3W9N9W79Omb3sudJ0WACxofN3CWKE/NsxUOnP0tlptxhrTHOVel1qpWFHhrz4
 pozXI4AOHjQ/Czb4iFiytZZDAM/xpoWvTsFL3l1tsYhvQSD06Zo7zVqNPvbgo7VXRvjfQSZ0Lpd
 sQxvzddnl38OQWQEgH2FFtFzEYsSpGjnVEQxqY8bwuDkzTJNoZVWnZB3Djg3DKkFgnPumg==
X-Received: by 2002:a05:7022:60c:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12a72646221mr3600922c88.2.1774359123172; Tue, 24 Mar 2026
 06:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:31:51 -0400
X-Gm-Features: AaiRm5082bmB1vEFeF97G50_iqqBjFx7HoPxAOrnxaX1HwxWGKygBeGTgapRc_0
Message-ID: <CADnq5_N83j3ZjNKXH2K8jEod0s64JB_pdugGsx4AURoPjpveSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate doorbell_offset in user queue
 creation
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Tue, Mar 24, 2026 at 5:49=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> amdgpu_userq_get_doorbell_index() passes the user-provided
> doorbell_offset to amdgpu_doorbell_index_on_bar() without bounds
> checking. An arbitrarily large doorbell_offset can cause the
> calculated doorbell index to fall outside the allocated doorbell BO,
> potentially corrupting kernel doorbell space.
>
> Validate that doorbell_offset falls within the doorbell BO before
> computing the BAR index, using u64 arithmetic to prevent overflow.
>
> Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 7c450350847d..0a1b93259887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -600,6 +600,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_=
mgr *uq_mgr,
>                 goto unpin_bo;
>         }
>
> +       /* Validate doorbell_offset is within the doorbell BO */
> +       if ((u64)db_info->doorbell_offset * db_size + db_size >
> +           amdgpu_bo_size(db_obj->obj)) {
> +               r =3D -EINVAL;
> +               goto unpin_bo;
> +       }
> +
>         index =3D amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>                                              db_info->doorbell_offset, db=
_size);
>         drm_dbg_driver(adev_to_drm(uq_mgr->adev),
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260324-fixes-9ee6cab7bc47
>
> Best regards,
> --
> Junrui Luo <moonafterrain@outlook.com>
>
