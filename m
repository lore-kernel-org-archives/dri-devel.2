Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E82CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728A810E5C8;
	Tue,  9 Jun 2026 18:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ALtgFpKy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC13010E5C8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781029160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDu4MwBmfRX/E++3VuTP0EJgWXcI+dGfLnWE00TFqa8=;
 b=ALtgFpKyOTNRqk3xqeGZ0VeG8MXMPVyKgECpjCaC391NG22u36eNoTegwotlgRDCb0kQ2j
 sk1HjDthaxsg6VwLrGicXuDtAgumJ+Uxpc/8mdo7QEv3COV1v/h5i8hb7HupiNlZVtT9Ed
 tN8kXVHKUcnNx+NA6jHvu6p2rrWieJs=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-6SOVLYUyMUCgeciwl_TJ9g-1; Tue, 09 Jun 2026 14:19:19 -0400
X-MC-Unique: 6SOVLYUyMUCgeciwl_TJ9g-1
X-Mimecast-MFC-AGG-ID: 6SOVLYUyMUCgeciwl_TJ9g_1781029159
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6cff652cc58so9045207137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 11:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781029159; x=1781633959;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDu4MwBmfRX/E++3VuTP0EJgWXcI+dGfLnWE00TFqa8=;
 b=iggIrxT6r4BlQwdpMBr5h+XG0HzYPXT160XMQmA2Eot2L8VhwV9Lnw1LWJMM60IX19
 Ii6iB2xJOG0QHXj4VbScYHjdwJuTW0sl8x0F91tjJTG7vwyQDHuiYx7qRjZZ5QXALy3V
 4vpe1IHfG6sRcwHbb8aDoQOOo5y0rJ2I3eP9NBwnaS79UXH4gqNg8WRyHVP3sdqUY3WN
 +D6ALIfGKWYSEruA+TbsT3xx4LxlWWTUxZJQhAmXpqER7W8IUkQyKROLuHgHbA2LacNJ
 TF4g9PCShcPSj0j93/RU+cUGkEFGe4ygqhHHT84tUaO+esw46Ve6yjqo+ITOpnfUQgk+
 OEEA==
X-Gm-Message-State: AOJu0YxuoTux5xE4Xw4Z1CbLauIfDp0PojXlYdoi4WF69+dJG5M/oU8V
 Ijvio+mUmZNiWEIlucOn60n28pPzEVOKUE922G/5kys1I1Gyy/Ac4ruLW7Y5itdnUNIhut9Fwru
 sIc/tgQYigaGmWgjd94Khrh0WKkdiXVDgtbVW7DQOalv0BzEfLKtz3NkN7Bm6kogPrT8PKA==
X-Gm-Gg: Acq92OGT4h+hswSN7ApNPC1c6eksMZ7470wWCOIE5m/iKBB9L8wE14NQM5jN/C3dmKp
 Rpc8AfaPlyAc9EnpzvF8QkzvZ+/9grh5gAra7/Wr8Z3uHrkIWEPHm6XnEoQEBxOVaz+Bu6UPCa2
 RCvo21XcLEGw0uNlR1phxK/fvPKJaMqjEiFivTyEot4KTorNb6rLhBMexo3gB6nseXzDVY0KvDc
 Q15cGU4514JfMPFSDlooIpegJ2pQHBBi1bZ2aL3H3cEkfBzHSl1FNyLpKW5lZjFNYPJaIFQgDR5
 y3pzaUunRoaB/r2u3SMO/mP6g9c0HiprsR8cWXs7W4jzzxF8CVzZvSbuaIZJ3iqHKM/qs7MdNMi
 6dojLpnn90m+6H0OfE0lJB205a7g6
X-Received: by 2002:a05:6102:945:b0:6f0:3999:b378 with SMTP id
 ada2fe7eead31-6fefe3c4824mr13164694137.13.1781029159085; 
 Tue, 09 Jun 2026 11:19:19 -0700 (PDT)
X-Received: by 2002:a05:6102:945:b0:6f0:3999:b378 with SMTP id
 ada2fe7eead31-6fefe3c4824mr13164599137.13.1781029158360; 
 Tue, 09 Jun 2026 11:19:18 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053210sm206713066d6.26.2026.06.09.11.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 11:19:17 -0700 (PDT)
Message-ID: <8898fc261aded12d8adf4c5a74cc6bd830072f27.camel@redhat.com>
Subject: Re: [PATCH v19 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
Date: Tue, 09 Jun 2026 14:19:17 -0400
In-Reply-To: <20260608184329.0BF6C1F00893@smtp.kernel.org>
References: <20260608183057.2001376-2-lyude@redhat.com>
 <20260608184329.0BF6C1F00893@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 59NLgMoRS7UMFFqIsx_3coRpvBQuUTsFpFZ3A-_BTPI_1781029159
X-Mimecast-Originator: redhat.com
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

On Mon, 2026-06-08 at 18:43 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Low] Incorrect use of `#[inline(always)]` instead of `#[inline]`
> for abstraction methods.
> --
>=20
> commit 35068fc880d5bd0d2870750a321a6b8155d32ae4
> Author: Lyude Paul <lyude@redhat.com>
>=20
> rust: drm: gem: shmem: Add DmaResvGuard helper
>=20
> This commit adds a temporary DmaResvGuard helper type for managing
> the
> dma_resv lock on GEM shmem objects. It implements a drop handler to
> automatically release the lock.
>=20
> > diff --git a/rust/kernel/drm/gem/shmem.rs
> > b/rust/kernel/drm/gem/shmem.rs
> > index 34af402899a0e..79ebd746e9611 100644
> > --- a/rust/kernel/drm/gem/shmem.rs
> > +++ b/rust/kernel/drm/gem/shmem.rs
>=20
> [ ... ]
>=20
> > @@ -235,3 +241,32 @@ impl<T: DriverObject, C: DeviceContext>
> > driver::AllocImpl for Object<T, C> {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dumb_map_offset: None,
> > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0}
> > +
> > +/// Private helper-type for holding the `dma_resv` object for a
> > GEM shmem object.
> > +///
> > +/// When this is dropped, the `dma_resv` lock is dropped as well.
> > +///
> > +// TODO: This should be replace with a WwMutex equivalent once we
> > have such bindings in the kernel.
> > +struct DmaResvGuard<'a, T: DriverObject, C: DeviceContext =3D
> > Registered>(
> > +=C2=A0=C2=A0=C2=A0 &'a Object<T, C>,
> > +=C2=A0=C2=A0=C2=A0 NotThreadSafe,
> > +);
> > +
> > +impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C>
> > {
> > +=C2=A0=C2=A0=C2=A0 #[inline(always)]
>=20
> [Severity: Low]
> This isn't a bug, but should this use #[inline] instead of
> #[inline(always)]?
>=20
> According to the Rust subsystem guidelines, #[inline(always)] should
> be
> reserved for functions using build_assert!() that depend on function
> parameters. For small abstraction functions that simply forward to
> binding
> calls like this one, #[inline] is the correct annotation.

Looks like the magic 8 ball is either hallucinating or this needs to be
added to the documentation, because there's clearly nothing about this
in the documentation. Ugh.

If anyone can correct me here let me know, otherwise I just assume
hallucination from the hallucination machine

>=20
> > +=C2=A0=C2=A0=C2=A0 #[expect(unused)]
> > +=C2=A0=C2=A0=C2=A0 fn new(obj: &'a Object<T, C>) -> Self {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This lock is ini=
tialized throughout the
> > lifetime of `object`.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_resv=
_lock(obj.raw_dma_resv(),
> > ptr::null_mut()) };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(obj, NotThreadSafe)
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +impl<'a, T: DriverObject, C: DeviceContext> Drop for
> > DmaResvGuard<'a, T, C> {
> > +=C2=A0=C2=A0=C2=A0 #[inline(always)]
>=20
> [Severity: Low]
> This isn't a bug, but could this drop method also use #[inline]
> instead of
> #[inline(always)] for the same reason mentioned above?
>=20
> > +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We are releasing=
 the lock grabbed during the
> > creation of this object.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_resv=
_unlock(self.0.raw_dma_resv())
> > };
> > +=C2=A0=C2=A0=C2=A0 }
> > +}

