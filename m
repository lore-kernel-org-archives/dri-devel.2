Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC8CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D7F10E26C;
	Mon, 18 May 2026 23:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6EqbYcL";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8DC10E26C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:51:00 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7bdc947aaa3so21863417b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779148259; cv=none;
 d=google.com; s=arc-20240605;
 b=ILsYnr53Js1nPzki59ILH20cyL8QWqdQMNzlecf6V3FE4hmRQ8Thc2BZ3p+9kdbVA9
 cF4CA2EGTDrBPQ9NK76db7QQzvj28aVo/Q9QhxCdrBowCQAztITeYlOeF9ICKrTur1d9
 oUMq2Q+E8HKQM+86+43yn3wuOBa1KX1pm7x6zxizJ4/Ryhjo1xeWHKyytfnje/m5SKLD
 BxhGZd1U+u79sc9+Cab/13TaRXSfDa/IQOKkXLQr/5SSpGGqHyF/6vJz0HpYsQuehGTr
 RCd4dt0VLIGkP8RmvaAtpR7x+Sad0GdsQHtPtGTQZVCZAqn6KhnmEBCG86aTiGv+Z3+r
 vsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IeeTUYaRZ5BMifrp/CORM7G6Oak23mAzpXgU06USVUU=;
 fh=kcLiayVtGr9f76BqWD1KOp5omsINyoTzkzwELy2OYOE=;
 b=H4rVNEYuXUsSu8vo/lrHb78346JlU/a/wbiofWOfE9HOVjfqC1TBGjmNXrmn6dUysI
 5IGmo9I7tiH3Ud0fbTZ4tas1sbejJ6Bie7fEqBDKbzGtJ0WoBI7mWZxcu4FQsm6v0G89
 j3HMbeUCXF0XArMZDQC5M07J7rCasX8biAc1UY/1PSiUUAcVc6X7ATnQGp/pdgQNGZT7
 C3YByideKGlsJEO7NFjSpEclyUihjYZ+XPjQiN8T2RaQTzfyiMSqZbd/kpIuoLvDaHDD
 meu3aWpuU4eQJBj658XrVvvTTR6Ck/HkQ7t8R/wlvltpStoVcs1zw18JWiC+fPMANHab
 NTug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779148259; x=1779753059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeeTUYaRZ5BMifrp/CORM7G6Oak23mAzpXgU06USVUU=;
 b=J6EqbYcLh2qy5clULh87BycN6i+QU6l/dkwZ4hNhFc4YEMRxPT9RZI9a3ds+AWnkRC
 BzwYo5QG07lv7zyVzOD3N8moyzYjGzzuNHxE1HPmxJuQ39WnVDGVmfiVHBuH3/b0xJOb
 rst8s+Z2C2GsWhjjNyFytPuGY4NnJ3+AkS8xH53hMY1tiBrDq6DRMrBhEOPZfhwtUk8J
 xl1nPyzKj6Xe+lLzypQNeDYp7kJAz3e3YYKNrP0/4YbptL3+jaB5szTQ8bmzxizlFwCk
 cAVVsWA7PGFGVWEZwBjtoxMXyVB/t9WHWCikXR4byKFwtycZceVmOY4So4c8uK+EqKCE
 0Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779148259; x=1779753059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IeeTUYaRZ5BMifrp/CORM7G6Oak23mAzpXgU06USVUU=;
 b=OrjLUUWgNq51/C3BzlDmdv2pShxe0TgySeURKcrws38GqvTtJVyvsoRNhfFTj8W2v6
 yJn8Rpz0CyBaboUaCdm6NtviKQtSqK3m5OjLkD0bDt/T5fuoN88UfUrTUBEfNbzwV4yM
 QJikSUkrsMBfZLGERAGOvN0JG/Prqkkhh6vVz3SYTz2g22LY80OkUB4ND0EGu4xJFppY
 Y28pDORlFZ5TDjrwpo+NTTDzZ/4oVXDrd6bHdtw4V0vst/YlRMEVdO1IVz1Oe4y8yASp
 SzyrN3KLYeJlli1+mXkRxg/wldBMo1J6WXcB9WHGQ4/Vi9pfSX/mEqWu50tdBREx3zei
 MJtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+B/huKZa6dB0ls2o1NePj6EBkV6lPbfUPPvxNQ9IqrdIA9AFTlOjQXS5y1jS0J99xP88xwd7KS2g8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzsj1nAW5Clm2Wr5qhpLaDdYClPOgFMMQS+/4S4c+RRncMqVeXL
 jpToYGQIFVlNIxMc2AXTK2r0zAXonSQA4NF3ft7UKm2fx11vTaOQgIWvSwE62i0BBwTJ4JOZ0ER
 nejq34QcaPIU5UDN+LStSKlCJxPoDLqDf8s5a
X-Gm-Gg: Acq92OFQ5ecU/hjIWpAE3EJNdhAxQu6QHnu8wjCzt/QeW71Fy/9mDPMnaU6/235Xqyh
 DdPIcwl8qoD4IHYeJGVt2TVLkqXBXNvdb5oRoXoT4qjjkzfhKLXItvC3q5zEa1AzokpNtdjECNi
 haTI7RMu30WQsv7SeYJfEmzdewUyxWpLr2YUZW3PRvtFc3zIs5xKYVNbEjboBF8N1Ji47YOB2eV
 0bOutFbnw7SjUsATEwA00Cwi9fVxxm0Rukaj7Ei1gs0uTjSP7ZD11gaVg/dABw6dlFrMR/rxcMt
 HHJA37Z2eMSuZ8oOo4KCiMORMSjmYGQ8fg3QS0EMQEvibdlyF7SWVlcdiCjVlwYsCtvlT9mp
X-Received: by 2002:a05:690c:c244:b0:7b4:657d:bd5d with SMTP id
 00721157ae682-7c95bf10a2cmr197794877b3.30.1779148259100; Mon, 18 May 2026
 16:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
 <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
 <20260518105721.42ffa64c@fedora>
In-Reply-To: <20260518105721.42ffa64c@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 18 May 2026 16:50:48 -0700
X-Gm-Features: AVHnY4Kh2f1AVPZetJ2ndlIB4ihBeeqmA3WYM7Ew2lGnTHy97cgp6M33GrZdWXw
Message-ID: <CAPaKu7RRcGQSivs8n6RhOO5XeBSoLG6YF1GRR6Cysv_yDpd2=w@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH 1/6] drm/panthor: Driver-wide
 xxx_[un]lock -> [scoped_]guard replacement
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

On Mon, May 18, 2026 at 1:57=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 14 May 2026 14:16:37 +0100
> Steven Price <steven.price@arm.com> wrote:
>
> > On 13/05/2026 17:58, Boris Brezillon wrote:
> > > Right now panthor is mixed bag of manual locks and guards. Let's
> > > make that more consitent and thus encourage new submissions to go
> > > for guards.
> >
> > I'm fine with encouraging guards for future code - but I'm a little war=
y
> > of a big change like this - it's hard to review it and check that
> > everything works the same.
>
> I can try to split that up, but even after the split, it will still be
> a pain to review.
Splitting up a bit can be helpful. If we did introduce errors
unintentionally, at least we could bisect and there would be less code
to look through.

That said, for changes like these, AI should be very effective at
catching errors.

>
> > And it's a little dubious that the mechanical
> > refactoring produces more readable code in some cases.
>
> I agree, though the mix of guard()s and manual locks makes things even
> harder to reason about, especially when they appear in the same
> function/block. The very reason I ended up sending this series is
> because, as part of the IRQ refactor, I decided to be a good citizen
> and use guards when I could, and I realized how bad the partial
> transition was in term of ergonomics: not only you have to think about
> whether the function/block scope is what you want (that's basically
> what guard provides, unless you used explicit scoped_guard()), but you
> also have to think about the interactions with your other manual locks.
>
> TLDR; I'd rather switch over to guards entirely, or go back to manual
> locks, but the mix we have right now is far from ideal.
>
> >
> > That said I asked my friendly AI bot...
> >
> > [...]
> >
> > > @@ -3142,48 +3126,44 @@ panthor_mmu_reclaim_priv_bos(struct panthor_d=
evice *ptdev,
> > >     LIST_HEAD(remaining_vms);
> > >     LIST_HEAD(vms);
> > >
> > > -   mutex_lock(&ptdev->reclaim.lock);
> > > -   list_splice_init(&ptdev->reclaim.vms, &vms);
> > > +   scoped_guard(mutex, &ptdev->reclaim.lock)
> > > +           list_splice_init(&ptdev->reclaim.vms, &vms);
> > >
> > >     while (freed < nr_to_scan) {
> > >             struct panthor_vm *vm;
> > >
> > > -           vm =3D list_first_entry_or_null(&vms, typeof(*vm),
> > > -                                         reclaim.lru_node);
> > > -           if (!vm)
> > > -                   break;
> > > -
> > > -           if (!kref_get_unless_zero(&vm->base.kref)) {
> > > -                   list_del_init(&vm->reclaim.lru_node);
> > > -                   continue;
> > > +           scoped_guard(mutex, &ptdev->reclaim.lock) {
> > > +                   vm =3D list_first_entry_or_null(&vms, typeof(*vm)=
,
> > > +                                                 reclaim.lru_node);
> > > +                   if (vm && !kref_get_unless_zero(&vm->base.kref)) =
{
> > > +                           list_del_init(&vm->reclaim.lru_node);
> > > +                           vm =3D NULL;
> > > +                   }
> > >             }
> > >
> > > -           mutex_unlock(&ptdev->reclaim.lock);
> > > +           if (!vm)
> > > +                   break;
> >
> > ... and it said the above has changed behaviour.
> >
> > In the !kref_get_unless_zero() case you now assign vm =3D NULL which th=
en
> > leads to the 'break' case above. Previously we 'continue'd.
>
> Oops, that one wasn't intended, indeed.
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
