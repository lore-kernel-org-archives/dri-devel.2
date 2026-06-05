Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69000CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C069410E4C6;
	Fri,  5 Jun 2026 14:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="D+8E3BR4";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B9810E4C6
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:55:10 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso1136275f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671308; cv=none;
 d=google.com; s=arc-20240605;
 b=eKzL9WR8usAcimdACmYjWCfcQXguynG+1QWz1I3EHESTW8VWGrdFUfsyYv0eno0OmO
 LQyzXECLamTmiugf/nNEb63fAATweuzaRnR83wGdIJoB3V188uPtAJStgNmoWwP/adFM
 y07NYqvGrDJoYNLsfSSBDs5wbf/35JBG43pAM7GwPtKqRbFm38yb2EscF3yoB3IzvTzc
 4N69vBaRairDdT0jlGXlB50SB9xuLicBEXbA1k3zn5vu/Onpj08flF34lWStwcMQvdgk
 lFOuy6biwI0avDiXUQAmgyFTRinhmdsUrN8h8hXgF0IFjqXQs31hqneUqP1EY2U7DPgX
 IjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ga5I8YlfP9EVgN78rA8flUbrTYvBmVk8NvjmWyk37Eo=;
 fh=pEOJloBCQ4NBnfSXWcWsOMNHCV0Vp8DuHAF0my5k3tA=;
 b=Bsp1c3SBnaPzgiUhnMq0+i+woQbnnBRPyL9BTEx4er3Tk3L6kuQfiiN4M6E8X72sgE
 wpO3czu+m3VHRVUFvmIClcaXgWhcaA65fn0qbGZzQc8DzZoJxGtN16OJ2Pz4W8MTGI1w
 nWAa4SZXf4RTEdUaeSa+6zcXHpkkbQcnVXQkYcVbDhpPFTq1KQuoqlgFxhw7dE8r9K75
 1SiNhelLmgJ6zimACwmOaM0jTBn/V6LkKYl42hLpEeIwwzTSe7XpQFKiBWQm0SPOUqUZ
 Zo6mpNCvC0trKoixq7m26mfzPH7MD8Af+D/B/HoAhewmroMhJ7HITTYy7541gUe9o1JS
 llcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780671308; x=1781276108;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ga5I8YlfP9EVgN78rA8flUbrTYvBmVk8NvjmWyk37Eo=;
 b=D+8E3BR40ucaKyRimJi+YThUe+mOEHrMzNNp2unk5S1eW91LgUHNlPAVVG2ckLNQJO
 8eEtH4pk1ozqmS8o6QQt4mZ/Zc8pz4J/z4WWzYcUCeeLAp/1ux4GrCXBsq2ilVRBtZf4
 r7ES+Qk10vu/027IZFMiXP/o+hNVVM4mJyDfxO2YBlM5c5RgEBJFyV+x1JCD1aCEBf3f
 3rRtryl385FdwxXeF2oWh2hj2awrwqvQVJ1Ls3cokb/4XOiGIbiW1Qn/vbxKmDgn/HhB
 Jt9p4aKrQwHKNqOF8buK8p56XxfuHYXH3vNcs6gij91Lp17dMuAAn85kgA9f4wZlFwpJ
 wpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671308; x=1781276108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ga5I8YlfP9EVgN78rA8flUbrTYvBmVk8NvjmWyk37Eo=;
 b=J8Rmvl2w1eLWZzbXtS9L5jovTD6MiYbAQIPaC+6BbzUR6yl1dKNCu6arM4gJ6KECHA
 s7nzhZUZIroOSDFfiHZ2gdwZX1BZ+B69k1EqJZwezAdX4CyuaQVVCZv4UjQabM2PVVzk
 XJg0/5TsG6FQOVOspZq0Di0zLEJ4CZREMC6B3pu52B2Flz4C0qi3ep3o/4qFs55uPzJv
 QNj0NW57be0cM9ErvwYxWNAn4cUrJlcaqKuprfVFv2URXBOkN8O7GPjdw/JaBkQUcrv/
 +dd92BD2JsHkcNghKtRfX4stDhehLZMm/Iil5ds/QfmCbaeImfVAeg6vAwLBgbfIh84t
 Tx6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7fVWzg4wfyq1KTvQjaINEHGxeRF3M4rpP6m7otPIWdMZWH13CtRmZsP5eKbPSQTtlmGZFhBsXyYQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWpv7ej1M/oXyRdJsnSw8wtr3gQKbduDEdCDMKje9JNJeSkXdv
 Br37dAlEQ2enFNRcKQdflfe4Y9kcCyPbp2bZKGFhAknR75gwDL8YTM/vE/UJAQXNsexI1bvV5q1
 Ott1AaTJYDFvKvDsJi/OOpnDrarnF/8GLth1QPBqLJicKxLXiwgyD/gZL
X-Gm-Gg: Acq92OEG061KAoYSaKGnQNuWbNoI5Hn96cUestsCfubA+mq1cttF+SHrqV7AdrKm60Y
 dO+NNB8lVu6F/+o92nDe5FTNrTexlop4BmbWetc1DMeVdj2FzuX2sOWYPxZTPUqtal+yjQzAY2G
 rR56v6JGZ9rOKkbjgoT5FovnSXXcfNm+PV+LxKfKs/CVaVNtJt1u2asSYzyAZWjbxVEwulWPymE
 Gj+ZD5Rpmuj2NJ2ucS5apNQz/J2M9qZPpaw0oK+SkRuglDAPfYVmyN7FT7R1jrWpeIpnNWfeOuT
 6v6X0KuvoPgD9/PvTAfW39V8BxgVyXAvkKWYVFigd3SDB4o1
X-Received: by 2002:a05:6000:4312:b0:460:395c:7404 with SMTP id
 ffacd0b85a97d-460395c7421mr2318434f8f.20.1780671307856; Fri, 05 Jun 2026
 07:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260605133541.22569-2-boqun@kernel.org>
 <20260605134935.B6C0E1F00893@smtp.kernel.org>
 <aiLgJkKzwEDGWNtY@tardis-2.local>
In-Reply-To: <aiLgJkKzwEDGWNtY@tardis-2.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Jun 2026 16:54:55 +0200
X-Gm-Features: AVVi8CcIvUHIO2p_9VW6ZHI2m65-lN84pQk89kmG3nnyyy__psHz_pZWj_Nq3k4
Message-ID: <CAH5fLgimUgbK_dVwq7RQimOugqJka2bM_u2r5S=3aze_8uCnbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
To: Boqun Feng <boqun@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, ojeda@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
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

On Fri, Jun 5, 2026 at 4:41=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote:
>
> On Fri, Jun 05, 2026 at 01:49:35PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Critical] RcuBox::into_foreign drops `self` instead of forgetting it=
, causing a guaranteed Use-After-Free.
> > - [High] RcuBox::drop bypasses the custom Allocator A and hardcodes kvf=
ree_call_rcu() for types that do not require dropping, causing undefined be=
havior for non-kvfree compatible allocators.
> > --
> >
> > commit f69c06884595bb68a76f4f1dd4014ee9e2c9e31c
> > Author: Alice Ryhl <aliceryhl@google.com>
> >
> > rust: rcu: add RcuBox type
> >
> > This adds an RcuBox container, which is like Box except that the value
> > is freed after waiting for one grace period (via {kvfree_,}call_rcu()).
> > To allow containers to rely on the RCU properties of RcuBox, an
> > extension of ForeignOwnable is added.
> >
> > > diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/r=
cu_box.rs
> > > new file mode 100644
> > > index 0000000000000..943fe3e8974e0
> > > --- /dev/null
> > > +++ b/rust/kernel/sync/rcu/rcu_box.rs
> >
> > [ ... ]
> >
> > > +// SAFETY:
> > > +// * The `RcuBoxInner<T>` was allocated with `A`.
> > > +// * `NonNull::as_ptr` returns a non-null pointer.
> > > +unsafe impl<T: Send + 'static, A: Allocator> ForeignOwnable for RcuB=
ox<T, A> {
> > > +    const FOREIGN_ALIGN: usize =3D <Box<RcuBoxInner<T>, A> as Foreig=
nOwnable>::FOREIGN_ALIGN;
> > > +
> > > +    type Borrowed<'a> =3D &'a T;
> > > +    type BorrowedMut<'a> =3D &'a T;
> > > +
> > > +    fn into_foreign(self) -> *mut c_void {
> > > +        self.0.as_ptr().cast()
> > > +    }
> >
> > [Severity: Critical]
> > Since `self` is consumed by value here without being wrapped in `Manual=
lyDrop`
> > or passed to `core::mem::forget()`, won't it be dropped at the end of t=
his
> > method?
> >
> > This seems like it would immediately schedule the memory for RCU free, =
causing
> > a use-after-free for the foreign code when it later accesses the pointe=
r.
> >
>
> [Cc Alice]
>
> I fixed this locally by:
>
>     fn into_foreign(self) -> *mut c_void {
>         let ptr =3D self.0.as_ptr().cast();
>
>         // FORGET: Leaking it as a pointer, the caller is responsible to =
free it or unleak it by
>         // from_foreign().
>         core::mem::forget(self);
>
>         ptr
>     }

I prefer to avoid use core::mem::forget.

    ManuallyDrop(self).0.as_ptr().cast()

Alice
