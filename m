Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B99C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 21:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF17010F6B2;
	Fri, 26 Jun 2026 21:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QLMqXiF3";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A95010E3DA
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:49:32 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1365eb2a773so100760c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782510572; cv=none;
 d=google.com; s=arc-20260327;
 b=dBG/sgFOvnhNqJyz9otJFG16CJaSwIzxPYpEZJ0ou93fGncD7idpAAF07TeBAJEfrn
 NJYdkfOlFLOJFXywsgJd66ecqiecjvqHz21T+UE+EWPVH/ViR9UNw+r8Ttjt8SxMwA7T
 RvwS+v1sMHFHYsaKuGNA35Hiy9oFusuE00fCu/aWD8nrEkECDB6RAnnY1FBQIdw/n8Fz
 BMykjU9y+VOycrgTidYZuFc1wRuQi5/hMsPweDGlAM2vGLuBfM9XyWJE4xsjeF3cv/8e
 f4CKruBi5Hxr3+lW3PLx9hWYg6Ls3RvC73a90TjvDZp4MR9gj39rhntkCdD6Lj5NqySI
 lhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 fh=n5xajTO/dlgZqUsxCNS1ZiLzfa9oGz7jYZwzf0hKTz0=;
 b=egoBBOWNYyr+wCdehhdJeaUV2uWCo0XCl5l+bK92BtdwMVWrhopLn/Jrf+m/hh769S
 zfyESLH8YW5HCA5ISp1jHRfkfHIcqfYk4T8SVBO6CibSQgj74Qp+r1UnoO70ra+N7hsD
 2d8QRZh+L69dMUeBusuPkoIfxH3osdD2fE3B7/D4Wxzlvs7V4hUBluZ6r8jrFleyiUPw
 27HjWi+DPBUXKWk+R6+jblikro1dKFXCSXO8jUnHGVuRxTUnXOSrnenA40swi4Tij033
 0lNEAONLEkAPeZvsc8ykKPqVUKF44ael0kikmN6ZnJOYRfBU1NdUfKp8B5ajNeR0u9Sj
 kgCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782510572; x=1783115372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 b=QLMqXiF3gas3KP9x0vcLqCr+5TY7GrjbBHtJp/r4zIsep1bg9HGNnlEA7laGoB20nU
 es+Z2TA3RaBu4fr9+ptiuIXqNtXC1yQ2Lbl/NpEhmZK++OT+ARbrLyG4nh4LZfQi3F0U
 oPl/GntaOYc12SvsoiheQQSPRaD/lmBt3brS3Gb+RkftZhfZTPtCzJRUYTPVnuQgIOEK
 MRR4oR8+RWrZ2AKF4xon/CVDEr+pASjxnlpiBouxpfrEzSQt0guMdjjR42Ws7F0iPeNA
 9u5N0OQuK4sxk6PqeZjT2w7uhm5TbLcJwPJ5zqhoeNqhknyTICzZ8SFhlrdbIJ7H9oKG
 ElVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782510572; x=1783115372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GwWlgxvrw/Wm/U7DbeeEyNi2oClEcjrfWLtOvXaNbXs=;
 b=o58Q3ni9GGjveRD3u2Pfz/zxZvJcp+1sOIy44+ogBJMM+HbExgu/I+jOaLw7GN7SZX
 Wjnds4VE40HMvd1KuQcbdCaR28DZdoLm8H1VtSF4LyhxAhb2K7ue4F/omqxJWfFiZ9HJ
 v+0r6+UpvgnGHuBXmQJ5/rAz6kJ7UE3X65KjWf1w0kPEve5mFliYdhOPBGhX1eYz2J6A
 z1fcMotQO8uW6giaahBEbqf5FOL6bbkvMishBp+ZPJcdoD203K5r2q5VpwKOOzjo5yK5
 0Ewya0BiE3cTMVjwB4CEWvL9513Ht4hsxNRjJtBFfTxDdNrE7vegbkS6GFSXI534QJE4
 8Tmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X7IBxG3Iz5zAFhSgVHeeu58Z7hVLriENm9lURaevtlSOcUyKKsvyn9BuZ45qL4O0PJeKTDff7s6A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQtdJ+y8FGzezYLZlDXTBCBmchBDHL4rnzok7vXdmYExTEmxip
 /vhWfjm0G56ILqWQ00S122uqwtlkFU9YVlywtO3Cq5aa/NQT5QncnmzxQ02ySoVfXsFfbpSv73y
 tllCoHGmcpnYNhbRBiaAcmUvN+LUJH3g=
X-Gm-Gg: AfdE7cnm9/VEK3f7eRekm7EKfFUhsxrU/7D2hWrIz2UxSp1a/2Y2I7YMFIkai3cyyoX
 k78YsVNEktRpZGcXQqe3Jl/EQABJm3S07p7N6h/li7Hf2TTylkQ6/PixwpI+wGZDwvWZXpQ7xPd
 c7GsQBNCoFrTg0fDWRQ0Ui1hcmdtsZTHf2B3AXAoUDGa2W0s3fABqG51ND1bLu0KP7vy5IQuVyJ
 SjfjOcr5ecYxWDzOiT+qWnvge292Bz2kCVqnXAUfdSwZEDHqTVrqmAj/1Z47zIhmoC9r5TTMCiJ
 s1nJeGwAGohpbKOjVx8QQqiHdxCGRID2HrDNKFIEme3GIW3rzt4laa/peCo=
X-Received: by 2002:a05:7022:1085:b0:139:90ab:36ac with SMTP id
 a92af1059eb24-139dbb1e039mr2362650c88.7.1782510571709; Fri, 26 Jun 2026
 14:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
In-Reply-To: <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 17:49:19 -0400
X-Gm-Features: AVVi8Cf7sEZtYouWUOPdAwzR66k49DaN5x35HjJ1GOvsJ5itj00iqqvtgBA2e1Y
Message-ID: <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tiago Dourado <tiagodourado@usp.br>, kernel@lists.ime.usp.br,
 airlied@gmail.com, 
 alexander.deucher@amd.com, simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>, 
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

On Fri, Jun 26, 2026 at 8:14=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/26/26 04:59, Tiago Dourado wrote:
> > The jpeg_v3_0_process_interrupt function is identical to
> > jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> > in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_funcs=
 struct.
> > Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> > cross-version reuse.
>
> Usually we intentionally don't do any cross IP version reuse, that has ca=
use tons of problems in the past.
>
> @Leo any particular reason why we don't have a separate SRCID file for VC=
N3?
>
> My educated guess is that nothing changed compared to VCN2 and nobody car=
ed to re-generate the file from the HW definition.
>

I think it's the same so no need for a separate one.  There are a
number of existing places where VCN or jpeg use one function
implementation across multiple generations.

Alex

> Regards,
> Christian.
>
> >
> > Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> > Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > ---
> >
> > v2:
> > - Assigned function directly to irq_funcs instead of using a macro.
> >
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
> >  3 files changed, 6 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.c
> > index 9fe8d10ab..9006fc57e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amd=
gpu_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> >                                     struct amdgpu_irq_src *source,
> >                                     struct amdgpu_iv_entry *entry)
> >  {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.h
> > index 654e43e83..4f400fb47 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_=
ring *ring,
> >  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t r=
eg, uint32_t val);
> >  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
> >
> > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > +                             struct amdgpu_irq_src *source,
> > +                             struct amdgpu_iv_entry *entry);
> > +
> >  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
> >
> >  #endif /* __JPEG_V2_0_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v3_0.c
> > index 98f5e0622..2f3a5a17e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct am=
dgpu_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> > -                                   struct amdgpu_irq_src *source,
> > -                                   struct amdgpu_iv_entry *entry)
> > -{
> > -     DRM_DEBUG("IH: JPEG TRAP\n");
> > -
> > -     switch (entry->src_id) {
> > -     case VCN_2_0__SRCID__JPEG_DECODE:
> > -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > -             break;
> > -     default:
> > -             DRM_ERROR("Unhandled interrupt: %d %d\n",
> > -                       entry->src_id, entry->src_data[0]);
> > -             break;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> >                               unsigned int vmid,
> >                               struct amdgpu_fence *timedout_fence)
> > @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct amd=
gpu_device *adev)
> >
> >  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D {
> >       .set =3D jpeg_v3_0_set_interrupt_state,
> > -     .process =3D jpeg_v3_0_process_interrupt,
> > +     .process =3D jpeg_v2_0_process_interrupt,
> >  };
> >
> >  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>
