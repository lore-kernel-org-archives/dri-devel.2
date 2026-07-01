Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77788C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B0510F1DF;
	Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="hyWVuM6L";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2300510E3E3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:14:54 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5aebfa21c62so1061012e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782929693; cv=none;
 d=google.com; s=arc-20260327;
 b=GmhXIQnUa5gcdaoAb7F1Job+82tKGwdY2VLYGMqHO3C+XlVEo9XXBe8cpumUUwRo0G
 2anC0c8VhvAxMo/18QpOuLjrukTaky/xFNLAAXLWqnEtAftt30FK9RJtJ0NnxQ8zVY3+
 fFJBtWq2oAUj8gD0FCyF1BbVLxyfayN6wPEIzqEk85wmhlF1TXeCmAxcrt/OjSpWTJ8P
 Evz1Bc7CabtjJmgQYsH2E7uml6KBKakXszyTF2Nq8TYPka9U8PxvPSRY6G5BILnBhPI4
 4+uDUm7ku2brsrnPHfN28ndva7VnuMGd0JwIJ/Q55f5Vr4DIGHIh2M36zBiLwyypEiIN
 gKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 fh=caQUtV2yAYXGDM4PDnT4okSpmM6/dZ4QcXIy8mXP/Tc=;
 b=JY8u+WXgLs1AoWPe1eIJHz3fsHP+uudpsBgg3HLCl6pMZiS4nTmGKCK7Aj1AtQ3hzK
 TYP7AG45n+/vuALpUzbXjkzq+xI4gQelZEPsfdCdg/lFsS5P+nDtMZzDSSr1hjGLZu2r
 GvRxWxi76kbgj0ca+wem/gAVBkEWORY8W6bPLjrjfYFMPLqkines1M4Lzhd3SmzTX9qe
 L6aTIZvMdGkH7OqTe6SmOU2yEgt96iQMCDURaQbe5t9JZglihlJ8tqYQAPQhUtjVgMzm
 47zS3d8EclFIl6aTq8/nNItHbIpVl2K3oiecFx9Tvf6WEe7TzIlTDVIGqL0+AfM3HEev
 EwoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782929693; x=1783534493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 b=hyWVuM6LLXE7x/C3yIiWPFg94VTeFypfesqYKCM/qd34t8gddcBQfbDHbfJlW+V9oT
 ENun9w+ZFAUH9Q7ILuuaOP60AwC5sL8KIvUuRQRQv4IzNsAkY/LgV3Xg5G9mAtLMAEIx
 89U+Ggc8k8T1U6JWXNwipqqixsEDdonO8STwRRAGSLwys9+AGOlfvj4PmSBidKtHCz7k
 9y5ho9+XvPfVbF9tCuLd29Z73LnTJgIk8OacqndwcZYdvAIQOGgDKUIO0k3g/+bwa743
 TVW7TcDk251zCrc8cZR99rurhQ3uBuVdOKbb9WolNX1R5hqd9Lu8w2M585Sx8BU4DSpB
 qe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929693; x=1783534493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 b=KJP23zvYHRzcMJcy6WskNPrmg1D5KngEr4aOJx69HxooWtaCsp8fgbvw6a9rXr2Hv1
 COmaycFZfHtyQAcZFYt3FM0J5Bzh7UbKGqLgRbM9XqD7IKiLM17xgENq4HWlnYaMX5yr
 ERt2b54G3EQiKNvuOtzCOG0qFE6Qx0cPhlzhnbotodaoO0JKz5+QxVSjQQx75Bk4NumF
 CM8p0af2qd7ppA70N/wEy66Iw2E3dNADo76TZbEMmZgRgNPXNV60FA9mwkO+FtAoLSbN
 dCdXRuQ77uztPuAVqnw6Y5MSax+JmmJ72XGPBMdw1Eaix940eG1b7qEevMVNZV+P7+Yw
 sORg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVKOui4RATzJ3l+LqF/mrOUJu1GvOAtKbGYKbCtQGjFjnShw6Onj+BqaXQB7YVc21+CDmS0658TGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlnwXU1Kb1qKWaP/xY9BTWFCtpMSXsSBWH/QR7F1WT++32TAzS
 dHjghVU2dT3saURUeol44sGmVQQVMDzC7RcKBy4j+I4e8ilGsAHf59XlmbB+K5QaKJhG+VsDHOS
 ekp3WtuZorQ/AI97jVAckpPvVakjZkP74EF251tEEIg==
X-Gm-Gg: AfdE7cl3yT2GBJz0rD1ZKRHbscyxfhKbD4O9hUf4Zizsl+nKnScOo/GzhibnpQ4IYC0
 O8uE266YOTqOBSy/VJOhXMtDI0spoo/rEtWbllI71F33GAH0uEyZXfHwa+3nQTVjyKJJd04WDiT
 Sm/LTlzxLyIMV8RSK3wF9vNYYp5Wa5PFBD0YXd4UnSNellLklivp8SR8df3huwSnZkqITBEFfZQ
 jQzopFYhw7BBFLtekEiEh2f1sx4ftSxqEu8rLbHXVEvVki2TUqd5RwwYuFB96tJZboKVKB0GhVd
 UFY6Lwo/nlybfFIi5XuL0MI/dMINhLmeD1UH6ET+n6YilYwZveWnWL0w
X-Received: by 2002:a05:6512:6887:b0:5ae:c210:1a24 with SMTP id
 2adb3069b0e04-5aec679794dmr446560e87.6.1782929693093; Wed, 01 Jul 2026
 11:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
 <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
In-Reply-To: <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
From: Tiago Gomes Dourado de Oliveira <tiagodourado@usp.br>
Date: Wed, 1 Jul 2026 15:14:41 -0300
X-Gm-Features: AVVi8Cfz28S6QQpc728eGJ7jRF7I_P-iT0Kc_pfoJctYsb4JGLeCjJvMKVsUn_A
Message-ID: <CAJRPy2G-X_uaHZWLWjXVBUFJsZ4Xq-mWmRrmsTPrFs7NyPdXow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com, 
 simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>, 
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

On Fri, Jun 26, 2026 at 6:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Jun 26, 2026 at 8:14=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 6/26/26 04:59, Tiago Dourado wrote:
> > > The jpeg_v3_0_process_interrupt function is identical to
> > > jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> > > in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_fun=
cs struct.
> > > Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> > > cross-version reuse.
> >
> > Usually we intentionally don't do any cross IP version reuse, that has =
cause tons of problems in the past.
> >
> > @Leo any particular reason why we don't have a separate SRCID file for =
VCN3?
> >
> > My educated guess is that nothing changed compared to VCN2 and nobody c=
ared to re-generate the file from the HW definition.
> >
>
> I think it's the same so no need for a separate one.  There are a
> number of existing places where VCN or jpeg use one function
> implementation across multiple generations.
>

Thanks for the feedback. Given what both of you pointed out, what do
you suggest that we can do?

Regards,
Tiago

> Alex
>
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> > > Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > ---
> > >
> > > v2:
> > > - Assigned function directly to irq_funcs instead of using a macro.
> > >
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
> > >  3 files changed, 6 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_0.c
> > > index 9fe8d10ab..9006fc57e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct a=
mdgpu_device *adev,
> > >       return 0;
> > >  }
> > >
> > > -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > >                                     struct amdgpu_irq_src *source,
> > >                                     struct amdgpu_iv_entry *entry)
> > >  {
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_0.h
> > > index 654e43e83..4f400fb47 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgp=
u_ring *ring,
> > >  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t=
 reg, uint32_t val);
> > >  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count=
);
> > >
> > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > +                             struct amdgpu_irq_src *source,
> > > +                             struct amdgpu_iv_entry *entry);
> > > +
> > >  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
> > >
> > >  #endif /* __JPEG_V2_0_H__ */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v3_0.c
> > > index 98f5e0622..2f3a5a17e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct =
amdgpu_device *adev,
> > >       return 0;
> > >  }
> > >
> > > -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> > > -                                   struct amdgpu_irq_src *source,
> > > -                                   struct amdgpu_iv_entry *entry)
> > > -{
> > > -     DRM_DEBUG("IH: JPEG TRAP\n");
> > > -
> > > -     switch (entry->src_id) {
> > > -     case VCN_2_0__SRCID__JPEG_DECODE:
> > > -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > > -             break;
> > > -     default:
> > > -             DRM_ERROR("Unhandled interrupt: %d %d\n",
> > > -                       entry->src_id, entry->src_data[0]);
> > > -             break;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > >  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> > >                               unsigned int vmid,
> > >                               struct amdgpu_fence *timedout_fence)
> > > @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct a=
mdgpu_device *adev)
> > >
> > >  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D {
> > >       .set =3D jpeg_v3_0_set_interrupt_state,
> > > -     .process =3D jpeg_v3_0_process_interrupt,
> > > +     .process =3D jpeg_v2_0_process_interrupt,
> > >  };
> > >
> > >  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
> >
