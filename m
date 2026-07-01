Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53D3C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4EA10E1D3;
	Wed,  1 Jul 2026 18:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="soIUaez8";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D2510E136
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:23:01 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c0c32d1350so637395ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782930181; cv=none;
 d=google.com; s=arc-20260327;
 b=DZnzLeLGI8X5H7HQtB6HZKjBzV5ApA8JzVJSXXAlSs6sjdlt66sEi/4Ni0ZJI0/ZJU
 Etfk3JzLapIVjZsMBLQybbgO9Vl2E1WRJiRf9qySCh7M8k5AUzyrVLbUwdm9PRzz/M7i
 qcJc6Sl3QObZsNeQyjLdS+KZ4X8JQoOdII9MQeAlc3cM+n+2YvotIUP/GsJICt2NJIVN
 3E1F7PL33twxvnMMsKISWgxkG3Jktcixen3p7cyJz5bSKF8hdYzAgO4nP6MKspuW1/NA
 SQecSSw7237FPvqc3S04SNvuQh3oDEPPyB+EztLax00CN/wgrNU7E/eyBYosNh17BjDd
 6lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jp3o7JOeE+DxRWgBwC6RrPeolPYYVDoyMRqR0btXSnA=;
 fh=+XKKQ+0V/1N41IXV2NSm6BtukYZSvzERatNv3SkEkxw=;
 b=BNzZ309G8fLtRBjEzjq5WYSzJL676tlVS3/OSrIY3KLkZpM4NIFCjLpcyOi0U7YasP
 8L2NIzKXFyfG2H4vXq92hD5RxvWkQEUXq2pfisXc53voiNUeeolkWob/hVo87VGAFq4Y
 mUvlI/ynvcaj9gEP7SHoeFHxaOFNRSfk4WedOWBThtcJr5EYz3ifMczKYQzyj1aSpntF
 n0HTMQpYmogRnjnZFCug0sQso8hsaZf833TzLLSMprwlryuWYyE2r61UqtqjiIBkpHvZ
 QsNP6Yn7UjcZ2mFPvVWw7VFDxwPx6e5lE4R54Ogf/mb3Qk9FAFTkEK3ogZEMW65UIo+i
 Fa7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930181; x=1783534981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jp3o7JOeE+DxRWgBwC6RrPeolPYYVDoyMRqR0btXSnA=;
 b=soIUaez8uguadfOZoLOrmprNwe06Y1TqLMdJKZ3HEcIhKbLjNzHX9PHYS0ts8zZMpY
 EodfKLKtGmQljoWxz/Ypv/GwpEcQ3RFvichwTkaPMQKGEZwkN35Di9wJjCSXUddWsLGl
 FIgT8tSBz+4i/hwtXwURE+gDDnJmKinEDvWmYD31nsUTm1g24ztzhOHAWCBN0if5KAmy
 XkD11obsVa/KwCH4clba/g9Al84Bb7fAMRzTG7Baj8u7ntz7sBVfSd//SwM2z9Mt8n5v
 YiiuPar7BMqwG9+5vE4v+OedhOwq/vrfn3NVuCOGlxk4loXDSvT8/vXpOIGsWtrqUI3P
 PF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930181; x=1783534981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jp3o7JOeE+DxRWgBwC6RrPeolPYYVDoyMRqR0btXSnA=;
 b=HWy7IQwLOy96uRS+eIfS8VD1P7VDFWohrtlWXC0Ek5gcCxGC19LIwyKQlxnoEY/ZLn
 WQcLmUracpM7ZVkl5Vma+NLCcIap7O1HIF9yKRWTWmaHYXnxe7IoT84sHQOfyrfI1Hb6
 lmwgE7JUb4xfYwJ7Px88PQeXAfu5r+E7mDAoXGBvWvFXLFOTyo1QwmkI1DYCTJ0664wo
 NpGZ759OhmqBAayljUkHp4ouT70/H0J8L8NZs7TZydl3wOPrvfhTrm31WUFYBA0PPuFR
 F81cte2e37RwgYDwYjDM1FpLJaKRRdOrdfhlZ1hh4B5gVqjYlMrX3AlZC9RivAs0Yxjt
 H5xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlZYHFHdExduGjWXQGCjxhi+k0u1e/8yJQpmONLpwqtqBEaKhAekzC6S7EDT/R4T6+A2gctTy2YaA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyocw4JKAsutWjEcgYvlyRinF5oEZ6F8Mz5wCKby+reL0BUKhlU
 wd+4uQf8Cp0RKfMdjwmxxRQQIOHcPEsCI6hWJegcziVp6D3gJe+BFo7qRYiAS+F0g5QM9r5NoX0
 +EViBTX4HVPsTeTi+33Gw7IWAQBACD4A=
X-Gm-Gg: AfdE7cl3058Y1tamHPU75Cc64HxGqVHiVUthRHZeySEzDxk+j1LXhUFnlbXhVdiK22n
 iEi8vSfOtdGkQIMK37WalktXCqxEec1tNV6BTwFZWOaG+2XmedI9d+3ZeGYPaZIzicPTXDjP2RN
 qbcocIzXpXTo/0ref/5TDq6Gk/SRAyWp8MQR7tFxgz1qT9zzWxUI67EY2zldl7wLR+ae/GTMXS6
 nXiYKscvKKaK+oF0tFyT2e0y9eBjQDwyNvRuCJu3hIGb6oAg9KW3WUqmjLMW34urKBw4d2smB5m
 K8T1LhsBuDUb3CnAEsYm020PfW+YC4dvis6P89Hy3pBYu0NdaEOGLjys8JI=
X-Received: by 2002:a17:902:e546:b0:2c6:d204:10b1 with SMTP id
 d9443c01a7336-2ca7e8b8ba0mr18069875ad.8.1782930180946; Wed, 01 Jul 2026
 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
 <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
 <CAJRPy2G-X_uaHZWLWjXVBUFJsZ4Xq-mWmRrmsTPrFs7NyPdXow@mail.gmail.com>
In-Reply-To: <CAJRPy2G-X_uaHZWLWjXVBUFJsZ4Xq-mWmRrmsTPrFs7NyPdXow@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jul 2026 14:22:49 -0400
X-Gm-Features: AVVi8Cc-53ie7tl9r246WdtTezS2OInJvHVmFCUkGOk3d66a7Rswb_6ZRLKEgew
Message-ID: <CADnq5_NFJSwFQHeukMMQ3m81os=BE7hVWp5RTJzcny5tRXXkBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Tiago Gomes Dourado de Oliveira <tiagodourado@usp.br>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com, 
 simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>, 
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Wed, Jul 1, 2026 at 2:14=E2=80=AFPM Tiago Gomes Dourado de Oliveira
<tiagodourado@usp.br> wrote:
>
> On Fri, Jun 26, 2026 at 6:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Fri, Jun 26, 2026 at 8:14=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > >
> > > On 6/26/26 04:59, Tiago Dourado wrote:
> > > > The jpeg_v3_0_process_interrupt function is identical to
> > > > jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> > > > in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_f=
uncs struct.
> > > > Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> > > > cross-version reuse.
> > >
> > > Usually we intentionally don't do any cross IP version reuse, that ha=
s cause tons of problems in the past.
> > >
> > > @Leo any particular reason why we don't have a separate SRCID file fo=
r VCN3?
> > >
> > > My educated guess is that nothing changed compared to VCN2 and nobody=
 cared to re-generate the file from the HW definition.
> > >
> >
> > I think it's the same so no need for a separate one.  There are a
> > number of existing places where VCN or jpeg use one function
> > implementation across multiple generations.
> >
>
> Thanks for the feedback. Given what both of you pointed out, what do
> you suggest that we can do?

I've applied the series.  Thanks.

Alex

>
> Regards,
> Tiago
>
> > Alex
> >
> > > Regards,
> > > Christian.
> > >
> > > >
> > > > Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> > > > Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > > Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > > ---
> > > >
> > > > v2:
> > > > - Assigned function directly to irq_funcs instead of using a macro.
> > > >
> > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
> > > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
> > > >  3 files changed, 6 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/d=
rm/amd/amdgpu/jpeg_v2_0.c
> > > > index 9fe8d10ab..9006fc57e 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > > @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct=
 amdgpu_device *adev,
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > >                                     struct amdgpu_irq_src *source,
> > > >                                     struct amdgpu_iv_entry *entry)
> > > >  {
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/d=
rm/amd/amdgpu/jpeg_v2_0.h
> > > > index 654e43e83..4f400fb47 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > > @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amd=
gpu_ring *ring,
> > > >  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32=
_t reg, uint32_t val);
> > > >  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t cou=
nt);
> > > >
> > > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > > +                             struct amdgpu_irq_src *source,
> > > > +                             struct amdgpu_iv_entry *entry);
> > > > +
> > > >  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
> > > >
> > > >  #endif /* __JPEG_V2_0_H__ */
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/d=
rm/amd/amdgpu/jpeg_v3_0.c
> > > > index 98f5e0622..2f3a5a17e 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > > @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struc=
t amdgpu_device *adev,
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> > > > -                                   struct amdgpu_irq_src *source,
> > > > -                                   struct amdgpu_iv_entry *entry)
> > > > -{
> > > > -     DRM_DEBUG("IH: JPEG TRAP\n");
> > > > -
> > > > -     switch (entry->src_id) {
> > > > -     case VCN_2_0__SRCID__JPEG_DECODE:
> > > > -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > > > -             break;
> > > > -     default:
> > > > -             DRM_ERROR("Unhandled interrupt: %d %d\n",
> > > > -                       entry->src_id, entry->src_data[0]);
> > > > -             break;
> > > > -     }
> > > > -
> > > > -     return 0;
> > > > -}
> > > > -
> > > >  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> > > >                               unsigned int vmid,
> > > >                               struct amdgpu_fence *timedout_fence)
> > > > @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct=
 amdgpu_device *adev)
> > > >
> > > >  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D {
> > > >       .set =3D jpeg_v3_0_set_interrupt_state,
> > > > -     .process =3D jpeg_v3_0_process_interrupt,
> > > > +     .process =3D jpeg_v2_0_process_interrupt,
> > > >  };
> > > >
> > > >  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
> > >
