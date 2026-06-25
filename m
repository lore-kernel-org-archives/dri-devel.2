Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E859BCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B6B10F47A;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RCC2guPd";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDA210E1CE
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:07:07 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-80af3058e29so810417b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378426; cv=none;
 d=google.com; s=arc-20260327;
 b=OPRiaDVOXnuAFF/NasgxxWQm6STrO5ctrvzI/2omsFYvg+nzxhhPS21OVCKSmTJT0z
 qcMBufKdqgIoWxd6KXrlDbOKJXch4aG7aroPYgdgLunHC1H1E84A3whX/umOhilS7ruX
 vlp5+QTFtJfTsMeebDGNNvcuUpyRjxlbzbu8MgXURLuv/1tioazNwbno/Iu22qtLxDSf
 2G8z7Mvz48RLYHW0RTfkeMoLNlemQpRlMzDarGmnB8g2vpmpnj0HEAPhWnIct1//CP/W
 yTr2VZ7Vv8k6So8uCOfXHrJ0m9LT6xP0kokLf84KP+jt1Y7zbPQApiz/ko5bHDpXddZ9
 cCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 fh=DLNDq0yTJpxjaslDZFTtdcGdaInAIm4Ff93/8juLzbU=;
 b=P7PjV4no9BZJoWuI9kZm+X3QR5Tz2dM63TW0chLW3+oU1XONY0Q/eRPSiU1czuQQf6
 WCh9J3mRu0n4TOHO3GQcFDq86/M3/aJtdw00X1rx2uV5LGRjlFjIGV/2LtrE7JOZbU5m
 lUO6PeJKsMW8oYPutq32s2EM+5LBSM/+QQBhuMdErJ481dagX2XoRiTC/xAOkOQEGFNF
 kgrg7Z28qsOUK87VfGuWL/GWQKHslv1Ytof8mjO1pn3xgrefOy1tIHuKFtN0tHzMHEkN
 9803l02ZbxprzZ1wJ/jGuoPp4a7lcE1JbVhVrWmD3qcRm8b8Mbays5xjAZhS3gXEAjIq
 gP2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782378426; x=1782983226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 b=RCC2guPdJ+UWt8NUcwdYaIbBdmV86R/G2bx6yD2UiunTWMNt7J25mZnpnNMWftON+K
 uO3rPO1T4Pe/wGDxhYHr29tTjYizC4ZEovjFgRvs3X8Kf9uuRb8OFwQsLHFi2/GmkHbE
 G5FkCrdjL+yPpSHKII6LdTTr7jIFSRp7Gi6momLbUD5EdYCQpJ/4H/RD5co1b+4aZa3Z
 HYwF+Y9JytdQ1Ud1GQALqdxGNCmPXtGkdNKXAQZZSijJaFEg5lXEOw3tg5+TCYC3j7KW
 hAtkjcOwnK6cV0BExQ8cWl2QzcSwifXN1g8XOgSzSsdvMWKZW5su9pwjXb3hyPqPFSJ8
 jJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782378426; x=1782983226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1lF2p0zapEf+xhq/90YUTa1Z2VnVgWZbekIEo47QZ4A=;
 b=UaA41rRlUhncHYpshY7BnQoKEOrwFxPIvX/7NqMFxW+H6fNI0t6HXvqkF76a2L3eJV
 bLvYt9meZXa4zGjsknp8CXUNVl0aLG0SlfFhwW8UZ/lZ0k3tGZuIXfeyH9ECV/z8a1mB
 mKfu7frYmFBQcRHtJmkEngtVi8G7EtINloDxEDCr4nR84bCBewI8ujjNp4K7Ie+FQrZF
 n7EofffhZ1/mkE4Nsw0FRa9WRz63gGrz34Qfi1C1XJnEcIgPK2vGqpDfqIQ3HvvsbOyC
 BHpdZ3O9VYSB8X4s9SS2o89TS0Xu5A1M9s2TW59jOrz+81Sqwz3N4acA+JswBy3PXf8i
 vT4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC03qq/CzUqgDLl2T/48W+IcpynD9B13rv0B9gbhmKpg3jy1zC8H4nzofDi0t97hiR+yXiI9sX5B0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG1L8qPn5fb4XPi3SoXk2uPlnvW11hnFxkaoETxGecleBX60ln
 4jbQsLCGqpUc8flgHSOk7+huCUA+HgmoPgxc/P1qD0ah8qfOiHzmG+DdS260j0ylJimDv7jvIM9
 7dxbI2QJWMd4DxM/eUB2/xOt6I0jP3uw=
X-Gm-Gg: AfdE7ckH/M2zOp2u0AwLJ2RP8sre9hA4lEYjm6HvpKXvue9vALld8sCQJIoSdLf1Smg
 ZuP9uUIeEdcAo6TRYZNTASxvabrmQt9PBMdGJwKp3NWIHqjhS8nj6NWRo+sOs2RcJE9QqjGEXon
 f3wci28ujDS6yeIFpHAILf2UWa+sMCIIz0pu0BflSJES5PubNA8rnnazxrA5gvckiIWEb9tAfqJ
 HbVXf7id7MvsqY1rLOX3O8diyTm0/5cFFyrzHJuN5TqINpKxtpUrGD87EO9+5lNH3FoB2q0JA==
X-Received: by 2002:a05:690c:f06:b0:7bd:cf35:e33b with SMTP id
 00721157ae682-80a680fd6b5mr15809967b3.17.1782378426348; Thu, 25 Jun 2026
 02:07:06 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:05 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:05 -0700
In-Reply-To: <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 02:07:05 -0700
X-Gm-Features: AVVi8CediwaEU0lbA3vIZaDjcsLl9lonps5TiuUPNt_1EGi3rRkszgQM2DjFHFE
Message-ID: <CAMuQ4bXYumKw9jTJ-FpCYfnzipR9jcFVSbp_k=LAbModoinRsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Hi Christian,

You're right. I rechecked the handle-open path and bo_va should
already be created for this file, so I do not have a valid reproducer
for the NULL case.

Please drop this patch.

Thanks,
Yousef

On Thu, 25 Jun 2026 10:46:24 +0200, "Christian K=C3=B6nig"
<christian.koenig@amd.com> wrote:
> On 6/24/26 19:20, Yousef Alhouseen wrote:
> > AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
> > iterates the valid and invalid mapping lists unconditionally. A GEM BO =
can
> > be queried before it has been mapped into the file VM, in which case
> > amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.
>
> Mhm, that is not correct at all.
>
> The bo_va is created when the handle is opened inside the filp and not wh=
en the first mapping is created.
>
> Do you have a test case to reproduce the issue?
>
> Thanks,
> Christian.
>
> >
> > Return -ENOENT for an unmapped BO, matching the VA operation path that
> > already rejects missing BO-VA state before touching the mapping lists.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 212c14d99..4b2699931 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, =
void *data,
> > struct drm_amdgpu_gem_vm_entry *vm_entries;
> > struct amdgpu_bo_va_mapping *mapping;
> > int num_mappings =3D 0;
> > +
> > + if (!bo_va) {
> > + r =3D -ENOENT;
> > + goto out_exec;
> > + }
> > +
> > /*
> > * num_entries is set as an input to the size of the user-allocated arra=
y of
> > * drm_amdgpu_gem_vm_entry stored at args->value.
> > --
> > 2.54.0
> >
