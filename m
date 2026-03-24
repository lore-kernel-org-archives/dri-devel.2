Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B7F54AA0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7859C10E6CE;
	Tue, 24 Mar 2026 13:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLpbIGiR";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6F910E6C0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:22:24 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12734af2cdcso309859c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358543; cv=none;
 d=google.com; s=arc-20240605;
 b=U3EMdSjIeK3XEotE9cofgOc8A/O/byOL5ooahfTQGzfPqhE1eTS4b0gmSKQa4m5G2a
 PWdLNcGCIm4FLS3jRjBeDd7TjAP7/V3jh4LXjiN8xSE2rR985uIv7uSjad38fNriU5An
 ZnZ8iMtDu4GqfSNQ+46d2qPyoCDOuyoNdUVqdUeQdIweMlEtrgkPNGgvsMGNyy474S5I
 PRUllQQ+Ix1lNedvQqpW9D8oggWlcjbCbz+KeYZFwszs7jbeUBpWQCmyHPV2tNLG9wEw
 LBvsgTVAYARS272EXwc84qI18EW9THBPrka+aa0Fas+d+5GVRTvOvJqkGzv0W+/v7B+t
 kjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 fh=qStLhtZeorTZ0UpOIpf9zO+PT+kbSmFZNYdYAB377kY=;
 b=OihiHHp2VPcukNldCzsNi4bYEiYAsJ2v631RApdOlgkqVKTqgK1XWuFfk0N/n7KDoA
 lJ6lGcGDEcqyzkemRbWIbpdNqDZtCiFN8xVTTEovex/rI8Smtwk60TSIxh2EBdYkmZaQ
 IbuIWFTKWbsSSju13gT42Xsy1gCo9lmBJloRVpEg9kFE4traa8BPtuuXD0FG2Zx64GfE
 UTLxLNQWx1JcOQghgj1QXnw3wSbE84WAFZf8eHLWfZrHgMFAbCX+kFMDSR5YhQ1e93y2
 9z5HWRp1aSVdM9ogndKjuE807WffqkutdmJuoMpFEe3VanbtZPciEh5jotwhhEqwnMjI
 iIFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358543; x=1774963343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 b=HLpbIGiRKqvFhhE0q2Zg4ZYS8I+L15QbfkvtnbtyHlZdFZqKji8vpt+TD9DkKyX7J3
 FI3YRZ9hztugm2Fxe1+zm5gNs4PhY1OWVJzzjMZrCLSE9NMRn5FKWj7Mn3EY4/9d4K42
 JcWSjQgpuZ6NYscSeaVA5D3O2mqotqHnkd+PCP7Vt/b++0DZXYMHgvSq1I4ZCz+Y6xD0
 2ZL7wJT7tBgJ8cfbDMJYq6OI8bgCcC7dryImzieuHi7Blv13vBHjSP4Up8pu2PdE0sK7
 W7nxO3MbJMDJEGmHBBzYSb8d/euAch2LhpSURXjNLM1AbE20UVSZabye0JYoAIEPpLv9
 Qfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358543; x=1774963343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 b=Sk+PSGHF1h9zeeeWHu+ZWtGvzonKxdz823l0VR3U0s6HwmewQb+5boGU8sRNo4g4Ic
 pF5au0mdmZy22Nn7ZVKaSGuZkX+6fXsHFirc7WdFbFy2HkwnGhCC9Nma3tGYukQE7oL/
 SLzwAaJue9cIcIyMtUOuGvINn730RaaDfoh4kMjZ6hgV48aSVMi/SknD6HL2SmiGsYnx
 4zj8eYqY981A+Ot5+V5xghzK72bQn72zsrC4t78qQMfcpVEsICsjuV3zYSgVjt/k0FMb
 5Kk8CfXPMZzB2yln2jbKyYxEmtc6EoXLknFZb1sO02BRgvw0mTYjyDKoyCwoEUPUJFPQ
 oYlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSd+EPWSVOevTX7YvgDS1elau/244AwNEybH4lnHd/aTxhgTNHrzN214v9ih7zhKRor3B0sNsNeDk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI+NDtdOouGY7BsFc9nuhXLazWE4nEdm0dwcPwnbYGL00+osqW
 XMpEe7OnHvFv+As/yINdDVb35N7YIGk7YCdeQLm6mWHJylsNVcFl9QKsptEdALlnX/67ARGvJdT
 uXRsCL3HyK/FhnG/lUYMyIV8oIakN9P2+kQ==
X-Gm-Gg: ATEYQzy4THcpuZl06/vONahR7RVvGfR9a8O2VMPjXqdCknfHFAoppW6GnCBbZGMuPEB
 6KughmFTCrYOaxCb8t8ksFrRkY2/h/WRHcTu6FePjNCIY1hvQtTY/m+PPGMJQcOwhW1OcPmLzxN
 dqRrFHTzOmkrgZxxz9ntZxmYyaUji1uMtgXMYCPaScCgAwc38t/hwOZyCjmhe1DoZ/lLAkTIfQD
 5xhaOYorUJG2afmHOL7ygyPIz7tXPl1cpi341O0BskKB7b08JbvCVEgI2LWDE6+RjQM7eAz5LMH
 65uiGUpuIjQdl4VNwAVjwNZAewgs6ZAEnhVe7whlh2BqfqlvzqbK190Gl7SLFfO8YaRGcg==
X-Received: by 2002:a05:7022:2224:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a726c143dmr3378135c88.4.1774358543184; Tue, 24 Mar 2026
 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260323224348.343495-1-colin.i.king@gmail.com>
 <1060acb4-1a8c-4e52-add2-fbda4f2efb7d@amd.com>
In-Reply-To: <1060acb4-1a8c-4e52-add2-fbda4f2efb7d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:22:10 -0400
X-Gm-Features: AaiRm5365YdEJSMouctlHAFL3xVlmZM5_M9mMvfLm75WvY684wOEa50LTTLTuN0
Message-ID: <CADnq5_MBNLH6ArJT5J87xcqvPo4y4N15EKO-oJPa3MAqEnr2_g@mail.gmail.com>
Subject: Re: [PATCH][nexr] drm/amdgpu/mes12_1: emove extra ;
 from declaration statement
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Mar 24, 2026 at 5:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/23/26 23:43, Colin Ian King wrote:
> > There is a declaration statement that has a ;; at the end, remove the
> > extraneous ;
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v12_1.c
> > index 5dcc2c32644a..0e9089544769 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> > @@ -2227,7 +2227,7 @@ static int mes_v12_1_self_test(struct amdgpu_devi=
ce *adev, int xcc_id)
> >       struct amdgpu_bo *meta_bo =3D NULL, *ctx_bo =3D NULL;
> >       void *meta_ptr =3D NULL, *ctx_ptr =3D NULL;
> >       u64 meta_gpu_addr, ctx_gpu_addr;
> > -     int size, i, r, pasid;;
> > +     int size, i, r, pasid;
> >
> >       pasid =3D amdgpu_pasid_alloc(16);
> >       if (pasid < 0)
>
