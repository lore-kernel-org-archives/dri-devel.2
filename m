Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971ACD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A71911A247;
	Thu,  4 Jun 2026 18:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Kq8N+JLz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFF011A247
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780598944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSOB8kwgdkJuUcuvvGWTTy+0BwGIhrEyhn+sNY27Rlk=;
 b=Kq8N+JLz02zsBYTdWj3Tebo0Vc/DKIUU6mDYaNsRgUjp77QnJ7t2EpV4wtATrssZIL/vpu
 zxJPoAMOZ7B9mt4CR7A8XTnnzsUQmMemUwwT5b42nUAC1RMktGc0IDusR7EnSMTVy2H7v+
 BXmA9N1GzGtsi3bv0mEdDj+HBiOby88=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-pll_D4joNPKN4F3tq1bUaA-1; Thu, 04 Jun 2026 14:49:02 -0400
X-MC-Unique: pll_D4joNPKN4F3tq1bUaA-1
X-Mimecast-MFC-AGG-ID: pll_D4joNPKN4F3tq1bUaA_1780598942
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso5594036d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 11:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780598942; x=1781203742;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSOB8kwgdkJuUcuvvGWTTy+0BwGIhrEyhn+sNY27Rlk=;
 b=qBlutRpHSbub9edHuCtoM+I307FYm0z6vXTyj+UdJSufOV3oQeVWAsxpXVUbM350kE
 16lOg13dNRuYY9i7yJqbFT0IOv2E85FzNsvoRK2xudIEiQVka4+mRxS901lmGlJNmEZ1
 ImgkU+s9v+jTvdgJ9g7mY97IzZzvoz85ULNSZHWF0NLoRmwls0JTGm8lMgMxBWIusZ2Q
 n9HEO6mfbonJmulzfjHxx31c6pcFdLPgXFBbynk7oU/VslsiW9IPJ5MKj2Io+N7hrah7
 bfrmpRQjoYMQUENqvzpBgxIoq0kyWQL/wtqSa5w7q1o6qwdDPgG07DVYWQ4IkPEMfNZM
 vhJQ==
X-Gm-Message-State: AOJu0Yz6rD0qHSUuC+4bZIyeuFsZf1I564fecwEfTNhyE9wSwKQDVNSo
 OwXb2Rkr8IYj13TVH8cC5EheR/bN5OwOh551TvFEbTjSlzC6krOJdvdw6gYHHnS30n6Ye8Sj2Ek
 BNv9VgLC2OwlGD9BfVcGyfBHm7vBYCayRBsRPQ/nD7ye+oZDKXgFxOpaRi5cVRdzUozdm+Q==
X-Gm-Gg: Acq92OF2jARXj//gxPu0xNvb+Awj+ifp9OsBrg9CFr74RnQGq7LjI+6D66ZMp63Dvl9
 CkBpzx+0xOzJUcxqmkr9cU4C1rYwEIbYOOo5sfTarjYm9eN4WAknHdmBkep/3Haoj5GQV9QUVjz
 e+3z0RYIfgGLox/Ykd0CRvNIEzzZOW8Tsswj3pRAl7WE3OqazVM0aKAKd9T7B0sWXOvQhalGdeC
 zROYGJtxDEjzVh+ooiqz0WyyPOJH6yBu5PYYHvU44uauSJSLFW5UYicLoJ5+Lnr44QtKc/0aOzD
 eaBlK+WUG3jt+HVob7UuJ8l1ldPkgGLwdEEqsH/JxFmnT1JHurNyhCTtke5c/9PHe316uSd1br9
 Q93SFnQa/kqPyZAnx0svK+DBOKOJ8
X-Received: by 2002:ad4:4e09:0:b0:8cc:dd12:a545 with SMTP id
 6a1803df08f44-8cee5f9e8c3mr5117606d6.8.1780598941804; 
 Thu, 04 Jun 2026 11:49:01 -0700 (PDT)
X-Received: by 2002:ad4:4e09:0:b0:8cc:dd12:a545 with SMTP id
 6a1803df08f44-8cee5f9e8c3mr5117046d6.8.1780598941090; 
 Thu, 04 Jun 2026 11:49:01 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9fda2sm60367866d6.2.2026.06.04.11.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:49:00 -0700 (PDT)
Message-ID: <f8a49ca906428f6190f5df2ae93a7966b7734199.camel@redhat.com>
Subject: Re: [PATCH v17 4/6] rust: faux: Allow retrieving a bound Device
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>,
 Gary Guo	 <gary@garyguo.net>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, driver-core@lists.linux.dev, Miguel Ojeda	
 <ojeda@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,  Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org, Mukesh Kumar
 Chaurasiya	 <mkchauras@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 14:48:59 -0400
In-Reply-To: <DJ0AREWNNJPT.9XEZC98B76II@kernel.org>
References: <20260603195210.693856-1-lyude@redhat.com>
 <20260603195210.693856-5-lyude@redhat.com>
 <DJ0AREWNNJPT.9XEZC98B76II@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qKPv_aLauV4SIO5kgXb_zTDhxXrDFYYtUCKNkcrXhtg_1780598942
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

I mentioned this already to Danilo via alternate channels, but to
clarify - this patch -is- actually needed, as we make use of
`AsRef<Device<Bound>>` in the kunit test for SGTable

On Thu, 2026-06-04 at 15:25 +0200, Danilo Krummrich wrote:
> On Wed Jun 3, 2026 at 9:42 PM CEST, Lyude Paul wrote:
> > When writing up some rust code that used faux devices for unit
> > testing, I
> > noticed that we never actually added the Bound device context to
> > faux::Registration's AsRef<device::Device> implementation. This
> > being said:
> > the Registration object itself is proof that a driver is bound to
> > the
> > device - so this should be safe.
>=20
> Yes, it should be, but the reasons are non-trivial and should be part
> of the
> safety comment below.
>=20
> =C2=A0 - faux_match() always returns 1, and probe runs synchronously
> =C2=A0=C2=A0=C2=A0 (PROBE_FORCE_SYNCHRONOUS)
>=20
> =C2=A0 - suppress_bind_attrs =3D true on faux_driver prevents userspace-
> triggered
> =C2=A0=C2=A0=C2=A0 unbind via sysfs
>=20
> =C2=A0 - mem::forget(Registration) is not a problem; if the Registration
> is leaked,
> =C2=A0=C2=A0=C2=A0 the faux device stays bound forever
>=20
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> I can pick this through the driver-core tree already, as it seems
> this it not
> needed by this series. Feel free to resend as individual patch for
> thus purpose.
>=20
> > ---
> > =C2=A0rust/kernel/faux.rs | 7 ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > index 43b4974f48cd2..e0856b2964a2c 100644
> > --- a/rust/kernel/faux.rs
> > +++ b/rust/kernel/faux.rs
> > @@ -25,7 +25,8 @@
> > =C2=A0///
> > =C2=A0/// # Invariants
> > =C2=A0///
> > -/// `self.0` always holds a valid pointer to an initialized and
> > registered [`struct faux_device`].
> > +/// - `self.0` always holds a valid pointer to an initialized and
> > registered [`struct faux_device`].
> > +/// - This object is proof that the object described by this
> > `Registration` is bound to a device.
> > =C2=A0///
> > =C2=A0/// [`struct faux_device`]: srctree/include/linux/device/faux.h
> > =C2=A0pub struct Registration(NonNull<bindings::faux_device>);
> > @@ -59,8 +60,8 @@ fn as_raw(&self) -> *mut bindings::faux_device {
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > -impl AsRef<device::Device> for Registration {
> > -=C2=A0=C2=A0=C2=A0 fn as_ref(&self) -> &device::Device {
> > +impl AsRef<device::Device<device::Bound>> for Registration {
> > +=C2=A0=C2=A0=C2=A0 fn as_ref(&self) -> &device::Device<device::Bound> =
{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The underly=
ing `device` in `faux_device` is
> > guaranteed by the C API to be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // a valid initialized=
 `device`.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> > device::Device::from_raw(addr_of_mut!((*self.as_raw()).dev)) }
> > --=20
> > 2.54.0

