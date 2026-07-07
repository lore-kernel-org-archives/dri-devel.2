Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430D4C44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81DC10F429;
	Thu,  9 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PMCbIXlC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2426510E308
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783462906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flgZZUgXhkTFGySNpaQuFvJ1hawAqHuGykw7LrBB0QI=;
 b=PMCbIXlCwNJeRqlTPtql49RBTiK7QnAnC6UI8GQ62yX+/Z3pFO3zDM26KuLmHMfQ5wyGKW
 VLDFgfgRnraIwKOl5K5upcbo2AWFukJ+P1GGmQEQbGgvcH15dpKUQGsSs8/DFaHdVvNwZC
 HNXZF9QOLw0nhQGPo+7zMtVsGU9Ut6o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Li_sJ85qNaunbm4pQ130Eg-1; Tue, 07 Jul 2026 18:21:44 -0400
X-MC-Unique: Li_sJ85qNaunbm4pQ130Eg-1
X-Mimecast-MFC-AGG-ID: Li_sJ85qNaunbm4pQ130Eg_1783462904
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso54637771cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 15:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783462904; x=1784067704;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flgZZUgXhkTFGySNpaQuFvJ1hawAqHuGykw7LrBB0QI=;
 b=RVUBRGcE7HYhpnGJFfDEj1brVivRbxSLHOOdX0nBc15Porvzz1Bjqp6PYvLsLRVef7
 W2gt/B+vSLGJGOOUwl49ZmIardDL2U4ot0yd0vSJZ0gTrSS7JwhEcJj7YC/vhymPBZc9
 1W5jupUzlNeh1ep60GwZraGG0tXRXo7UZSCn+fMM3OmX/ZQAfZehcWGQKIv80n3n0tgx
 a7NLuZPEGyC46QV4cZTsvuWza9tQQfjHnN5oiv7cJt3CtavsEEVPVxVPnuigVPCOwBde
 ycDYFDeuUsDJFzpss0O3MwNWXXLg1oKjIGgk0r1HgLHzDBzd5QQVVnOJMgxaEpw39eXw
 U0vw==
X-Gm-Message-State: AOJu0YzuVb4vo5UI+gnVnmzZxSZmeJhHxYeNhjXusT7zw13MPblYehe3
 /4cmcXFtogsiM7vGhPBhbJKERFvR76JVTxgxJydpgUwHsi737UES7a3p9gfNa6u8XJvt+dgLh/X
 2SISHbQLmuRSjGPxE3+1ohRHjLv8vpAfWRfSjcqumirwDZbhRyvEyFRchXqNCYmW0IC8prQ==
X-Gm-Gg: AfdE7cl35G9OIjWu1pdBnTJ3zBAyBlKOr2X43pvsbj1/F1TDcK49ABRpBtZCIrh5DhD
 Msfgx9+JgpOTuYw2u78wAmd7KZbWLjMK+AiO7qhdpgvoo9XTnNjyw1C4AO/GJpTF46w9PVbutnV
 9U6cwuKbFFVVK+desMaZlLgAIzFm3kmY8e6TovBXaX2zx6An+478YM7fLv/TaI3ulSorxTDOLxJ
 fxoWCs+xh9u6KaO9quuLjht8e+Y2KC225r2gKGT+lSve3NYpPwygo5LFvZHx/AnMYBNOh430uHm
 QhnaAR42qfTDW2j5AzsEJwu5YCETZ+vDL+vq1pLbpjhGI/sAPteWUtf0Fj5WG0pNVgviC8xRp+r
 qU5lqucc=
X-Received: by 2002:a05:622a:1e12:b0:51b:efe9:27c0 with SMTP id
 d75a77b69052e-51c8b3fa4e3mr599091cf.71.1783462901907; 
 Tue, 07 Jul 2026 15:21:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:51b:efe9:27c0 with SMTP id
 d75a77b69052e-51c8b3fa4e3mr597401cf.71.1783462898929; 
 Tue, 07 Jul 2026 15:21:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4718141e6sm170582566d6.24.2026.07.07.15.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:21:38 -0700 (PDT)
Message-ID: <a75f6888d42291b1adae08ebfc60ba20805287f1.camel@redhat.com>
Subject: Re: [RFC PATCH v2 01/18] rust: drm: kms: forward-port the safe
 mode-object layer onto the typestate device
From: lyude@redhat.com
To: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 18:21:37 -0400
In-Reply-To: <20260703030123.2814-2-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
 <20260703030123.2814-2-mike@fireburn.co.uk>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1C_Nih7vB-Mc9oG5nXlRJ8cEBxadHcch-R2Ihd3p3no_1783462904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

NAK on the whole series.

The first patch starts with taking all of my work, changing the
authorship, adding a claude tag on the thing I spent 2 years of my life
trying to get upstream, on top of the dozens of other issues with this
patch series:

 * You, again, changed/removed my authorship on work that I wrote. In
   this case, you copied my entire git branch, re-authored it under
   yourself and added a claude assisted-by tag, and have tried
   submitting it to the kernel mailing list. That is absolutely not OK
   by any stretch, even for an RFC. The next time I see this, I am
   giving an immediate NAK and just pointing back at this email.
 * Rebasing means actually going through the entire patch series and
   modifying the patches so they apply. It doesn't mean changing the
   authorship on patches, squashing them together, and then adding a
   rebase patch at the end. If you need to have a hacked-together
   branch to make things work, that can't be part of the actual series
   you submitting.
 * Multiple import items on a single line.
 * I get that this is a RFC patch, but there are dozens of patches here
   that seem to do things that are entirely out of scope of KMS:
    - Changing the build system to workaround issues without any
      description as to the actual issues that were hit. It took me
      multiple tries to understand what you were even trying to fix, and
      regardless: it shouldn't be part of this patch series.
    - Blobs of text that appear to be copied straight from AI output,
      especially in the git commit message. Maintainers aren't here to
      clean this up for you, people read this and use this to understand
      what is going on.
    - More reimplementations of things that exist elsewhere, dozens of
      comments across patches that clearly didn't get looked at by a
      person, etc. etc.

I've left comments, but there are so many to leave here and it is very
obvious that a lot of this code was generated and not actually looked
over by a person. I get it, RFCs can be messy, but not like this. It's
much different when you ask a machine to generate a large amount of
code, don't actually look over it, and then ask for others to go
through and vet it.

I'm going to ask: if you're not willing to write the code here yourself
(as in, without claude), please simply don't submit another version.
I've received AI generated patches, they're usually fine, but that's
because they're generally used as large search replaces with limited
scope such that it's obvious the person who made the patch has
understood it. I don't see evidence that the vast majority of this was
even read before it was submitted. It's not a maintainer's job to take
slop and turn it into something legible. That's not the purpose of an
RFC either.

On Fri, 2026-07-03 at 04:00 +0100, Mike Lothian wrote:
> Port Lyude Paul's rvkms-slim safe mode-object layer
> (CRTC/plane/connector/
> encoder/vblank/atomic state) onto her newer rust-stuck typestate
> Device
> design (ParentDevice/DeviceContext/RegistrationData), which the
> preceding
> cherry-picked commits bring in. Source: lyude/rvkms-slim +
> lyude/rust/rust-stuck.
>=20
> Same module split as rvkms-slim (kms/{atomic,connector,crtc,encoder,
> framebuffer,modes,plane,vblank}.rs), same trait shape, adjusted to
> the
> typestate device's generic Ctx/State parameters. This is a mechanical
> type-level port, not new design -- diff against lyude/rvkms-slim to
> see
> exactly what moved.
>=20
> Does not build yet. The port's mode-object traits are mutually
> recursive in a way the current trait solver can't evaluate; the next
> few commits get it to a clean build.
>=20
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
> ---
> =C2=A0rust/kernel/drm/kms.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 395 +++++++++-
> =C2=A0rust/kernel/drm/kms/atomic.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 864 ++++++++++++++++++++++
> =C2=A0rust/kernel/drm/kms/connector.rs=C2=A0=C2=A0 |=C2=A0 997 ++++++++++=
+++++++++++++++
> =C2=A0rust/kernel/drm/kms/crtc.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1110
> ++++++++++++++++++++++++++++
> =C2=A0rust/kernel/drm/kms/encoder.rs=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 409 =
++++++++++
> =C2=A0rust/kernel/drm/kms/framebuffer.rs |=C2=A0=C2=A0 70 ++
> =C2=A0rust/kernel/drm/kms/modes.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 76 ++
> =C2=A0rust/kernel/drm/kms/plane.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
1095
> +++++++++++++++++++++++++++
> =C2=A0rust/kernel/drm/kms/vblank.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 461 ++++++++++++
> =C2=A09 files changed, 5469 insertions(+), 8 deletions(-)
> =C2=A0create mode 100644 rust/kernel/drm/kms/atomic.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/connector.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/crtc.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/encoder.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/framebuffer.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/modes.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/plane.rs
> =C2=A0create mode 100644 rust/kernel/drm/kms/vblank.rs
>=20
> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> index 084ed0aebd0e..11b09d2175db 100644
> --- a/rust/kernel/drm/kms.rs
> +++ b/rust/kernel/drm/kms.rs
> @@ -3,17 +3,37 @@
> =C2=A0//! KMS driver abstractions for rust.
> =C2=A0
> =C2=A0use crate::{
> +=C2=A0=C2=A0=C2=A0 container_of,
> =C2=A0=C2=A0=C2=A0=C2=A0 drm::{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device::Device,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device::{Device, DeviceContex=
t},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver::Driver,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private::Sealed,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Uninit, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 error::to_result,
> -=C2=A0=C2=A0=C2=A0 prelude::*, //
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 sync::{Mutex, MutexGuard},
> +=C2=A0=C2=A0=C2=A0 types::*,
> =C2=A0};
> =C2=A0use bindings;
> -use core::{marker::PhantomData, ops::Deref};
> +use core::{
> +=C2=A0=C2=A0=C2=A0 cell::Cell,
> +=C2=A0=C2=A0=C2=A0 marker::PhantomData,
> +=C2=A0=C2=A0=C2=A0 ops::Deref,
> +=C2=A0=C2=A0=C2=A0 ptr::{self, addr_of_mut, NonNull},
> +};
> +
> +// Forward-ported mode-object layer (see
> Documentation/gpu/rust/vino-kms-forward-port.md).
> +// Modules are declared here as each is grafted onto the rust-stuck
> typestate design.
> +// `modes` is self-contained and ported as-is; the rest follow per
> the plan's order.
> +pub mod atomic;
> +pub mod connector;
> +pub mod crtc;
> +pub mod encoder;
> +pub mod framebuffer;
> +pub mod modes;
> +pub mod plane;
> +pub mod vblank;
> =C2=A0
> =C2=A0/// The C vtable for a [`Device`].
> =C2=A0///
> @@ -77,13 +97,21 @@ impl KmsContext for Probing {}
> =C2=A0/// This type is guaranteed to represent a [`Device`] that has not
> been registered with userspace,
> =C2=A0/// and is in the process of setting up KMS support. It carries a
> [`KmsDeviceContext`] to indicate
> =C2=A0/// which stage of the KMS setup process this [`Device`] is
> currently in.
> -pub struct NewKmsDevice<'a, T: Driver, C: KmsContext>(&'a Device<T,
> Uninit>, PhantomData<C>);
> +pub struct NewKmsDevice<'a, T: Driver, C: KmsContext> {
> +=C2=A0=C2=A0=C2=A0 drm: &'a Device<T, Uninit>,
> +=C2=A0=C2=A0=C2=A0 /// Tracks whether any CRTC created during probe requ=
ested
> vblank support, so that
> +=C2=A0=C2=A0=C2=A0 /// [`drm_vblank_init()`] can be called afterwards. S=
et by
> [`crtc::Crtc::new()`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_vblank_init()`]: srctree/include/drm/drm_vb=
lank.h
> +=C2=A0=C2=A0=C2=A0 pub(crate) has_vblanks: Cell<bool>,
> +=C2=A0=C2=A0=C2=A0 _ctx: PhantomData<C>,
> +}
> =C2=A0
> =C2=A0impl<'a, T: Driver, C: KmsContext> Deref for NewKmsDevice<'a, T, C>
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D Device<T, Uninit>;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.drm
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> @@ -95,15 +123,56 @@ fn deref(&self) -> &Self::Target {
> =C2=A0/// [`PhantomData<Self>`]: PhantomData
> =C2=A0#[vtable]
> =C2=A0pub trait KmsDriver: Driver {
> +=C2=A0=C2=A0=C2=A0 /// The driver's [`DriverConnector`](connector::Drive=
rConnector)
> implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// TODO: This will be unneeded once we support multi=
ple
> `DriverConnector` implementations.
> +=C2=A0=C2=A0=C2=A0 type Connector: connector::DriverConnector;
> +
> +=C2=A0=C2=A0=C2=A0 /// The driver's [`DriverPlane`](plane::DriverPlane)
> implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// TODO: This will be unneeded once we support multi=
ple
> `DriverPlane` implementations.
> +=C2=A0=C2=A0=C2=A0 type Plane: plane::DriverPlane;
> +
> +=C2=A0=C2=A0=C2=A0 /// The driver's [`DriverCrtc`](crtc::DriverCrtc)
> implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// TODO: This will be unneeded once we support multi=
ple
> `DriverCrtc` implementations.
> +=C2=A0=C2=A0=C2=A0 type Crtc: crtc::DriverCrtc;
> +
> +=C2=A0=C2=A0=C2=A0 /// The driver's [`DriverEncoder`](encoder::DriverEnc=
oder)
> implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// TODO: This will be unneeded once we support multi=
ple
> `DriverEncoder` implementations.
> +=C2=A0=C2=A0=C2=A0 type Encoder: encoder::DriverEncoder;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Return a [`ModeConfigInfo`] structure for th=
is
> [`device::Device`].
> =C2=A0=C2=A0=C2=A0=C2=A0 fn mode_config_info(dev: &Device<Self, Uninit>) =
->
> Result<ModeConfigInfo>
> =C2=A0=C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: Sized;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Create mode objects like [`crtc::Crtc`], [`p=
lane::Plane`],
> etc. for this device
> -=C2=A0=C2=A0=C2=A0 fn probe(drm: NewKmsDevice<'_, Self, Probing>) -> Res=
ult
> +=C2=A0=C2=A0=C2=A0 fn probe(drm: &NewKmsDevice<'_, Self, Probing>) -> Re=
sult
> =C2=A0=C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: Sized;
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`atomic_commit_tail`] callback for =
this
> [`Device`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// It must return a
> [`CommittedAtomicState`](atomic::CommittedAtomicState) to prove that
> it has
> +=C2=A0=C2=A0=C2=A0 /// signaled completion of the hw commit phase. Drive=
rs may use
> this function to customize the
> +=C2=A0=C2=A0=C2=A0 /// order in which commits are performed during the a=
tomic
> commit phase.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If not provided, DRM will use its own default ato=
mic commit
> tail helper
> +=C2=A0=C2=A0=C2=A0 /// `drm_atomic_helper_commit_tail`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`atomic_commit_tail`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_commit_tail<'a>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _state: atomic::AtomicCommitT=
ail<'a, Self>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _modeset_token: atomic::Modes=
etsReadyToken<'_>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _plane_update_token: atomic::=
PlaneUpdatesReadyToken<'_>,
> +=C2=A0=C2=A0=C2=A0 ) -> atomic::CommittedAtomicState<'a, Self>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: Sized,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s function should not be
> reachable")
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> =C2=A0impl<T: KmsDriver> private::KmsImpl for T {
> @@ -123,7 +192,11 @@ impl<T: KmsDriver> private::KmsImpl for T {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kms_helper_vtable: bindi=
ngs::drm_mode_config_helper_funcs {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
atomic_commit_setup: None,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_commit_tail: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_commit_tail: if T::HAS_ATOMIC_COMMIT_TAIL {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic::commit_tail_callback::<T>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 });
> =C2=A0
> @@ -156,7 +229,19 @@ unsafe fn probe_kms(drm: &Device<Self::Driver,
> Uninit>) -> Result<ModeConfigInfo
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just setup=
 all of the info required to call
> this function above.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> bindings::drmm_mode_config_init(drm.as_raw()) })?;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::probe(NewKmsDevice(&drm, P=
hantomData))?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new_kms =3D NewKmsDevice =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm: =
&drm,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_v=
blanks: Cell::new(false),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _ctx:=
 PhantomData,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::probe(&new_kms)?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if new_kms.has_vblanks.get() =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: `has_vblanks` is only set when CRTCs with
> vblank support were created during
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // pr=
obe (the only place static mode objects are
> created), so the vblank state is ready
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // to=
 be initialized.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_re=
sult(unsafe {
> bindings::drm_vblank_init(drm.as_raw(), drm.num_crtcs()) })?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // TODO: In the future, =
we should add a hook here for
> initializing each state via hardware
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // state readback.
> @@ -192,3 +277,297 @@ pub struct ModeConfigInfo {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// An optional default fourcc format code to be=
 preferred for
> clients.
> =C2=A0=C2=A0=C2=A0=C2=A0 pub preferred_fourcc: Option<u32>,
> =C2=A0}
> +
> +// -----------------------------------------------------------------
> ----------
> +// Mode-object framework (forward-ported from lyude/rvkms-slim's
> kms.rs).
> +//
> +// Adapted to rust-stuck's typestate device: `Device<T, C>` defaults
> `C` to
> +// `Registered`, so most `Device<T>` references port unchanged; only
> creation
> +// paths (during probe) use the `Uninit` context, reached via
> `NewKmsDevice`.
> +// -----------------------------------------------------------------
> ----------
> +
> +/// Implement the repetitive from_opaque/try_from_opaque methods for
> all mode object and state
> +/// types.
> +///
> +/// Because there are so many different ways of accessing mode
> objects, their states, etc. we need a
> +/// macro that we can use for consistently implementing
> try_from_opaque()/from_opaque() functions to
> +/// convert from Opaque mode objects to fully typed mode objects.
> This macro handles that, and can
> +/// generate said functions for any kind of type which the original
> mode object driver trait can be
> +/// derived from.
> +macro_rules! impl_from_opaque_mode_obj {
> +=C2=A0=C2=A0=C2=A0 (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $( $l=
ifetime:lifetime, )?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $( $d=
ecl_bound_id:ident ),*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > ($opaque:ty) -> $inner_ret_=
ty:ty
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 $( $extra_bound_id:ident : $extra_trait:ident<$(
> $extra_assoc:ident =3D $extra_param_match:ident ),+> ),+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )? ;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $obj_=
trait_param:ident as $obj_trait:ident,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $drv_=
trait_param:ident as
> KmsDriver<$drv_assoc_trait:ident =3D ...>
> +=C2=A0=C2=A0=C2=A0 ) =3D> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D "Try to convert `op=
aque` into a fully qualified
> `Self`."]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D ""]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("This will =
try to convert `opaque` into
> `Self` if it shares the same [`",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stringif=
y!($obj_trait), "`] implementation
> as `Self`.")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub fn try_from_opaque<$( $li=
fetime, )? $( $decl_bound_id
> ),* >(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opaqu=
e: $opaque
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) -> Result<$inner_ret_ty, $o=
paque>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $drv_=
trait_param: KmsDriver<$drv_assoc_trait =3D
> $obj_trait_param>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $obj_=
trait_param: $obj_trait<Driver =3D $drv_trait_param>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $( , =
$( $extra_bound_id: $extra_trait<$( $extra_assoc =3D
> $extra_param_match ),+> ),+ )?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // FI=
XME: What we really want to be doing here is
> comparing vtable pointers, but this is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // cu=
rrently blocked on getting unique vtable macros to
> ensure that each vtable has a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // co=
nsistent memory pointer.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Fo=
r the time being, we simply restrict things to one
> object type per driver and do a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // tr=
ansmutation based on that assumption holding true.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: We currently only allow one object type per-
> driver, so this transmute is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // al=
ways safe.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(un=
safe { core::mem::transmute(opaque) })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D "Convert `opaque` i=
nto a fully qualified `Self`."]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D ""]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("This is an=
 infallible version of
> [`Self::try_from_opaque`]. This ",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "functio=
n is mainly useful for drivers where
> only a single [`",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stringif=
y!($obj_trait), "`] implementation
> exists.")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D ""]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D "# Panics"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D ""]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("This funct=
ion will panic if `opaque`
> belongs to a different [`",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stringif=
y!($obj_trait), "`]
> implementation.")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub fn from_opaque<$( $lifeti=
me, )? $( $decl_bound_id ),* >(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opaqu=
e: $opaque
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) -> $inner_ret_ty
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $drv_=
trait_param: KmsDriver<$drv_assoc_trait =3D
> $obj_trait_param>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $obj_=
trait_param: $obj_trait<Driver =3D $drv_trait_param>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $( , =
$( $extra_bound_id: $extra_trait<$( $extra_assoc =3D
> $extra_param_match ),+> ),+ )?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self:=
:try_from_opaque(opaque)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .map_or(None, |o| Some(o))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .expect(concat!("Passed ", stringify!($opaque), "
> does not share this ",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stringify!($obj_trait), "
> implementation."))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +pub(crate) use impl_from_opaque_mode_obj;
> +
> +impl<T: KmsDriver, C: DeviceContext> Device<T, C> {
> +=C2=A0=C2=A0=C2=A0 /// Retrieve a pointer to the mode_config mutex
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn mode_config_mutex(&self) -> &Mutex<()> =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This lock is initi=
alized for as long as
> `Device<T>` is exposed to users
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> Mutex::from_raw(addr_of_mut!((*self.as_raw()).mode_config.mutex)) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the number of registered [`Crtc`](crtc::Cr=
tc) objects
> on this [`Device`].
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn num_crtcs(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * This can only be modifie=
d during the single-threaded
> context before registration, so
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 this is safe
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * num_crtc is always >=3D =
0, so casting to u32 is fine
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).mod=
e_config.num_crtc as u32 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> Device<T> {
> +=C2=A0=C2=A0=C2=A0 /// Acquire the [`mode_config.mutex`] for this [`Devi=
ce`].
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn mode_config_lock(&self) -> ModeConfigGuard<'_,=
 T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: We're locking m=
ode_config.mutex, fulfilling
> our invariant that this lock is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // held throughout ModeConfig=
Guard's lifetime.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ModeConfigGuard(self.mode_con=
fig_mutex().lock(),
> PhantomData)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A modesetting object in DRM.
> +///
> +/// This is any type of object where the underlying C object
> contains a [`struct drm_mode_object`].
> +/// This type requires [`Send`] + [`Sync`] as all modesetting
> objects in DRM are able to be sent
> +/// between threads.
> +///
> +/// This type is only implemented by the DRM crate itself.
> +///
> +/// # Safety
> +///
> +/// [`raw_mode_obj()`] must always return a valid pointer to an
> initialized
> +/// [`struct drm_mode_object`].
> +///
> +/// [`struct drm_mode_object`]:
> srctree/include/drm/drm_mode_object.h
> +/// [`raw_mode_obj()`]: ModeObject::raw_mode_obj()
> +pub unsafe trait ModeObject: Sealed + Send + Sync {
> +=C2=A0=C2=A0=C2=A0 /// The parent driver for this [`ModeObject`].
> +=C2=A0=C2=A0=C2=A0 type Driver: KmsDriver;
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the [`Device`] for this [`ModeObject`].
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver>;
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a pointer to the [`struct drm_mode_object`=
] for this
> [`ModeObject`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_mode_object`]:
> (srctree/include/drm/drm_mode_object.h)
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect;
> +}
> +
> +/// A trait for modesetting objects which don't come with their own
> reference-counting.
> +///
> +/// Some [`ModeObject`] types in DRM do not have a reference count.
> These types are considered
> +/// "static" and share the lifetime of their parent [`Device`]. To
> retrieve an owned reference to
> +/// such types, see [`KmsRef`].
> +///
> +/// # Safety
> +///
> +/// This trait must only be implemented for modesetting objects
> which do not have a refcount within
> +/// their [`struct drm_mode_object`], otherwise [`KmsRef`] can't
> guarantee the object will stay
> +/// alive.
> +///
> +/// [`struct drm_mode_object`]:
> (srctree/include/drm/drm_mode_object.h)
> +pub unsafe trait StaticModeObject: ModeObject {}
> +
> +/// An owned reference to a [`StaticModeObject`].
> +///
> +/// Note that since [`StaticModeObject`] types share the lifetime of
> their parent [`Device`], the
> +/// parent [`Device`] will stay alive as long as this type exists.
> Thus, users should be aware that
> +/// storing a [`KmsRef`] within a [`ModeObject`] is a circular
> reference.
> +///
> +/// # Invariants
> +///
> +/// `self.0` points to a valid instance of `T` throughout the
> lifetime of this type.
> +pub struct KmsRef<T: StaticModeObject>(NonNull<T>);
> +
> +// SAFETY: Owned references to DRM device are thread-safe.
> +unsafe impl<T: StaticModeObject> Send for KmsRef<T> {}
> +// SAFETY: Owned references to DRM device are thread-safe.
> +unsafe impl<T: StaticModeObject> Sync for KmsRef<T> {}
> +
> +impl<T: StaticModeObject> From<&T> for KmsRef<T> {
> +=C2=A0=C2=A0=C2=A0 fn from(value: &T) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: Because the lif=
etime of the StaticModeObject
> is the same as the lifetime of
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // its parent device, we can =
ensure that `value` remains
> alive by incrementing the device's
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // reference count. The devic=
e will only disappear once we
> drop this reference in `Drop`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value.drm_dev().inc_ref();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(value.into())
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: StaticModeObject> Drop for KmsRef<T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're reclaiming t=
he reference we leaked in
> From<&T>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drop(unsafe { ARef::from_raw(=
self.drm_dev().into()) })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: StaticModeObject> Deref for KmsRef<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed o=
bject will point to a valid
> object as long as we hold dev
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { self.0.as_ref() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: StaticModeObject> Clone for KmsRef<T> {
> +=C2=A0=C2=A0=C2=A0 fn clone(&self) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: See `From<&T>`;=
 we keep the parent device
> alive for this new reference.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.drm_dev().inc_ref();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(self.0)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +macro_rules! impl_aref_for_mode_object {
> +=C2=A0=C2=A0=C2=A0 (impl $( < $( $param:ident: $bound:ident ),+ > )? for=
 $type:ty)
> =3D> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: drm_mode_object_ge=
t()/put() ensure the type is
> ref-counted according to the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // safety contract
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe impl $( < $( $param: $=
bound ),+ > )?
> kernel::types::AlwaysRefCounted for $type {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[inl=
ine]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn in=
c_ref(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed by the safety contract
> of `ModeObject` that
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // `raw_mode_obj()` always returns a pointer to an
> initialized `drm_mode_object`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsafe {
> kernel::bindings::drm_mode_object_get(self.raw_mode_obj()) }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[inl=
ine]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e fn dec_ref(obj: core::ptr::NonNull<Self>) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed by the safety contract
> of `ModeObject` that
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // `raw_mode_obj()` always returns a pointer to an
> initialized `drm_mode_object`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsafe {
> kernel::bindings::drm_mode_object_put(obj.as_ref().raw_mode_obj()) }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +pub(super) use impl_aref_for_mode_object;
> +
> +/// A trait for any object related to a [`ModeObject`] that can
> return its vtable.
> +///
> +/// This reference will be used for checking whether an opaque
> representation of a mode object uses a
> +/// specific driver trait implementation.
> +///
> +/// # Safety
> +///
> +/// `ModeObjectVtable::vtable()` must always return a valid pointer
> to the relevant mode object's
> +/// vtable.
> +pub(crate) unsafe trait ModeObjectVtable {
> +=C2=A0=C2=A0=C2=A0 /// The type for the auto-generated vtable.
> +=C2=A0=C2=A0=C2=A0 type Vtable;
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a static reference to the auto-generated v=
table for
> the relevant mode object.
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable;
> +}
> +
> +/// A mode config guard.
> +///
> +/// This is an exclusive primitive that represents when
> [`drm_device.mode_config.mutex`] is held - as
> +/// some modesetting operations (particularly ones related to
> [`connectors`](connector)) are still
> +/// protected under this single lock. The lock will be dropped once
> this object is dropped.
> +///
> +/// # Invariants
> +///
> +/// - `self.0` is contained within a [`struct drm_mode_config`],
> which is contained within a
> +///=C2=A0=C2=A0 [`struct drm_device`].
> +/// - The [`KmsDriver`] implementation of that [`struct drm_device`]
> is always `T`.
> +/// - This type proves that [`drm_device.mode_config.mutex`] is
> acquired.
> +///
> +/// [`struct drm_mode_config`]: (srctree/include/drm/drm_device.h)
> +/// [`drm_device.mode_config.mutex`]:
> (srctree/include/drm/drm_device.h)
> +/// [`struct drm_device`]: (srctree/include/drm/drm_device.h)
> +pub struct ModeConfigGuard<'a, T: KmsDriver>(MutexGuard<'a, ()>,
> PhantomData<T>);
> +
> +impl<'a, T: KmsDriver> ModeConfigGuard<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Return the [`Device`] that this [`ModeConfigGuard=
`] belongs
> to.
> +=C2=A0=C2=A0=C2=A0 pub fn drm_dev(&self) -> &'a Device<T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let lock: *mut bindings::mute=
x =3D
> ptr::from_ref(self.0.lock_ref()).cast_mut().cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `self` is embedded withi=
n a `drm_mode_config` via our
> type invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `self.0.lock` has an equ=
ivalent data type to `mutex`
> via its type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mode_config =3D unsafe { =
container_of!(lock,
> bindings::drm_mode_config, mutex) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: And that `drm_mode=
_config` lives in a
> `drm_device` via type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devic=
e::from_raw(container_of!(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mode_config,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bindings::drm_device,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mode_config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Assert that the given device is the owner of this=
 mode
> config guard.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Panics
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Panics if `dev` is different from the owning devi=
ce for this
> mode config guard.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn assert_owner(&self, dev: &Device<T>) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert!(ptr::eq(self.drm_dev(=
), dev));
> +=C2=A0=C2=A0=C2=A0 }
> +}
> diff --git a/rust/kernel/drm/kms/atomic.rs
> b/rust/kernel/drm/kms/atomic.rs
> new file mode 100644
> index 000000000000..cc14bff47abd
> --- /dev/null
> +++ b/rust/kernel/drm/kms/atomic.rs
> @@ -0,0 +1,864 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! [`struct drm_atomic_state`] related bindings for rust.
> +//!
> +//! [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
> +use super::{connector::*, crtc::*, plane::*, KmsDriver, ModeObject};
> +use crate::{
> +=C2=A0=C2=A0=C2=A0 bindings,
> +=C2=A0=C2=A0=C2=A0 drm::device::Device,
> +=C2=A0=C2=A0=C2=A0 error::{from_err_ptr, to_result},
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 types::*,
> +};
> +use core::{cell::Cell, marker::*, mem::ManuallyDrop, ops::*,
> ptr::NonNull};
> +
> +/// The main wrapper around [`struct drm_atomic_state`].
> +///
> +/// This type is usually embedded within another interface such as
> an [`AtomicStateMutator`].
> +///
> +/// # Invariants
> +///
> +/// - The data layout of this type is identical to [`struct
> drm_atomic_state`].
> +/// - `state` is initialized for as long as this type is exposed to
> users.
> +///
> +/// [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
> +#[repr(transparent)]
> +pub struct AtomicState<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 pub(super) state: Opaque<bindings::drm_atomic_state>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> AtomicState<T> {
> +=C2=A0=C2=A0=C2=A0 /// Reconstruct an immutable reference to an atomic s=
tate from
> the given pointer
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// `ptr` must point to a valid initialized instance =
of [`struct
> drm_atomic_state`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_atomic_state`]:
> srctree/include/drm/drm_atomic.h
> +=C2=A0=C2=A0=C2=A0 #[allow(dead_code)]
> +=C2=A0=C2=A0=C2=A0 pub(super) unsafe fn from_raw<'a>(ptr: *const
> bindings::drm_atomic_state) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: Our safety cont=
ract upholds the guarantee that
> `state` is initialized for as
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // long as this type is expos=
ed to users.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn as_raw(&self) -> *mut bindings::drm_ato=
mic_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the [`Device`] associated with this [`Atom=
icState`].
> +=C2=A0=C2=A0=C2=A0 pub fn drm_dev(&self) -> &Device<T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `state` is initialized v=
ia our type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `dev` is invariant throu=
ghout the lifetime of
> `AtomicState`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.state.get()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the old atomic state for `crtc`, if it is =
present
> within this [`AtomicState`].
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_crtc_state<C>(&self, crtc: &C) ->
> Option<&C::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableCrtc + ModeObj=
ect<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This function eith=
er returns NULL or a valid
> pointer to a `drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_get_old_crtc_state(self.as_raw(),
> crtc.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .as_ref()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .map(|p| C::State::from_raw(p))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the old atomic state for `plane`, if it is=
 present
> within this [`AtomicState`].
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_plane_state<P>(&self, plane: &P) ->
> Option<&P::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P: ModesettablePlane + ModeOb=
ject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This function eith=
er returns NULL or a valid
> pointer to a `drm_plane_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_get_old_plane_state(self.as_raw(),
> plane.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .as_ref()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .map(|p| P::State::from_raw(p))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the old atomic state for `connector` if it=
 is present
> within this [`AtomicState`].
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_connector_state<C>(&self, connector: &=
C) ->
> Option<&C::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableConnector + Mo=
deObject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This function eith=
er returns NULL or a valid
> pointer to a `drm_connector_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> bindings::drm_atomic_get_old_connector_state(self.as_raw(),
> connector.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .as_ref()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .map(|p| C::State::from_raw(p))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: DRM atomic state objects are always reference counted and
> the get/put functions satisfy
> +// the requirements.
> +unsafe impl<T: KmsDriver> AlwaysRefCounted for AtomicState<T> {
> +=C2=A0=C2=A0=C2=A0 fn inc_ref(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `state` is initial=
ized for as long as this type
> is exposed to users
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_atomic=
_state_get(self.state.get()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn dec_ref(obj: NonNull<Self>) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `obj` contains a v=
alid non-null pointer to an
> initialized `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_atomic=
_state_put(obj.as_ptr().cast())
> }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A smart-pointer for modifying the contents of an atomic state.
> +///
> +/// As it's not unreasonable for a modesetting driver to want to
> have references to the state of
> +/// multiple modesetting objects at once, along with mutating
> multiple states for unique modesetting
> +/// objects at once, this type provides a mechanism for safely doing
> both of these things.
> +///
> +/// To honor Rust's aliasing rules regarding mutable references,
> this structure ensures only one
> +/// mutable reference to a mode object's atomic state may exist at a
> time - and refuses to provide
> +/// another if one has already been taken out using runtime checks.
> +pub struct AtomicStateMutator<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 /// The state being mutated. Note that the use of `Ma=
nuallyDrop`
> here is because mutators are
> +=C2=A0=C2=A0=C2=A0 /// only constructed in FFI callbacks and thus borrow=
 their
> references to the atomic state from
> +=C2=A0=C2=A0=C2=A0 /// DRM. Composers, which make use of mutators intern=
ally, can
> potentially be owned by rust code
> +=C2=A0=C2=A0=C2=A0 /// if a driver is performing an atomic commit intern=
ally - and
> thus will call the drop
> +=C2=A0=C2=A0=C2=A0 /// implementation here.
> +=C2=A0=C2=A0=C2=A0 state: ManuallyDrop<ARef<AtomicState<T>>>,
> +
> +=C2=A0=C2=A0=C2=A0 /// Bitmask of borrowed CRTC state objects
> +=C2=A0=C2=A0=C2=A0 pub(super) borrowed_crtcs: Cell<u32>,
> +=C2=A0=C2=A0=C2=A0 /// Bitmask of borrowed plane state objects
> +=C2=A0=C2=A0=C2=A0 pub(super) borrowed_planes: Cell<u32>,
> +=C2=A0=C2=A0=C2=A0 /// Bitmask of borrowed connector state objects
> +=C2=A0=C2=A0=C2=A0 pub(super) borrowed_connectors: Cell<u32>,
> +}
> +
> +impl<T: KmsDriver> AtomicStateMutator<T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`AtomicStateMutator`]
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// `ptr` must point to a valid `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 #[allow(dead_code)]
> +=C2=A0=C2=A0=C2=A0 pub(super) unsafe fn new(ptr:
> NonNull<bindings::drm_atomic_state>) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: The data layout of `AtomicState<T>` is
> identical to drm_atomic_state
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We=
 use `ManuallyDrop` because `AtomicStateMutator` is
> only ever provided to users in
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // th=
e context of KMS callbacks. As such, skipping ref
> inc/dec for the atomic state is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // co=
nvienent for our bindings.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
: ManuallyDrop::new(unsafe {
> ARef::from_raw(ptr.cast()) }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 borro=
wed_planes: Cell::default(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 borro=
wed_crtcs: Cell::default(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 borro=
wed_connectors: Cell::default(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn as_raw(&self) -> *mut bindings::drm_ato=
mic_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the [`Device`] for this [`AtomicStateMutat=
or`].
> +=C2=A0=C2=A0=C2=A0 pub fn drm_dev(&self) -> &Device<T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.drm_dev()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the last committed atomic state for `crt=
c` if
> `crtc` has already been added to the
> +=C2=A0=C2=A0=C2=A0 /// atomic state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise.
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_crtc_state<C>(&self, crtc: &C) ->
> Option<&C::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableCrtc + ModeObj=
ect<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get_old_crtc_state=
(crtc)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the last committed atomic state for `con=
nector` if
> `connector` has already been
> +=C2=A0=C2=A0=C2=A0 /// added to the atomic state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise.
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_connector_state<C>(&self, connector: &=
C) ->
> Option<&C::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableConnector + Mo=
deObject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get_old_connector_=
state(connector)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the last committed atomic state for `pla=
ne` if
> `plane` has already been added to
> +=C2=A0=C2=A0=C2=A0 /// the atomic state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise.
> +=C2=A0=C2=A0=C2=A0 pub fn get_old_plane_state<P>(&self, plane: &P) ->
> Option<&P::State>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P: ModesettablePlane + ModeOb=
ject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get_old_plane_stat=
e(plane)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a composer for `plane`s new atomic state i=
f it was
> previously added to the atomic
> +=C2=A0=C2=A0=C2=A0 /// state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise, or if another mutator s=
till exists
> for this state.
> +=C2=A0=C2=A0=C2=A0 pub fn get_new_crtc_state<C>(&self, crtc: &C) ->
> Option<CrtcStateMutator<'_, C::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableCrtc + ModeObj=
ect<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM either returns=
 NULL or a valid pointer to a
> `drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e {
> bindings::drm_atomic_get_new_crtc_state(self.as_raw(), crtc.as_raw())
> };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CrtcStateMutator::<C::State>:=
:new(self,
> NonNull::new(state)?)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a composer for `plane`s new atomic state i=
f it was
> previously added to the atomic
> +=C2=A0=C2=A0=C2=A0 /// state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise, or if another mutator s=
till exists
> for this state.
> +=C2=A0=C2=A0=C2=A0 pub fn get_new_plane_state<P>(&self, plane: &P) ->
> Option<PlaneStateMutator<'_, P::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P: ModesettablePlane + ModeOb=
ject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM either returns=
 NULL or a valid pointer to a
> `drm_plane_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e {
> bindings::drm_atomic_get_new_plane_state(self.as_raw(),
> plane.as_raw()) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneStateMutator::<P::State>=
::new(self,
> NonNull::new(state)?)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a composer for `crtc`s new atomic state if=
 it was
> previously added to the atomic
> +=C2=A0=C2=A0=C2=A0 /// state being composed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns `None` otherwise, or if another mutator s=
till exists
> for this state.
> +=C2=A0=C2=A0=C2=A0 pub fn get_new_connector_state<C>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connector: &C,
> +=C2=A0=C2=A0=C2=A0 ) -> Option<ConnectorStateMutator<'_, C::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableConnector + Mo=
deObject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM either returns=
 NULL or a valid pointer to a
> `drm_connector_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> bindings::drm_atomic_get_new_connector_state(self.as_raw(),
> connector.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConnectorStateMutator::<C::St=
ate>::new(self,
> NonNull::new(state)?)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// An [`AtomicStateMutator`] wrapper which is not yet part of any
> commit operation.
> +///
> +/// Since it's not yet part of a commit operation, new mode objects
> may be added to the state. It
> +/// also holds a reference to the underlying [`AtomicState`] that
> will be released when this object
> +/// is dropped.
> +pub struct AtomicStateComposer<T: KmsDriver>(AtomicStateMutator<T>);
> +
> +impl<T: KmsDriver> Deref for AtomicStateComposer<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D AtomicStateMutator<T>;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> Drop for AtomicStateComposer<T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're in drop, so =
this is guaranteed to be the
> last possible reference
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { ManuallyDrop::drop(&=
mut self.0.state) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> AtomicStateComposer<T> {
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The caller guarantees that `ptr` points to a vali=
d instance
> of `drm_atomic_state`.
> +=C2=A0=C2=A0=C2=A0 pub(crate) unsafe fn new(ptr:
> NonNull<bindings::drm_atomic_state>) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: see `AtomicStateMu=
tator::from_raw()`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(unsafe { AtomicStateMuta=
tor::new(ptr) })
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Attempt to add the state for `crtc` to the atomic=
 state for
> this composer if it hasn't
> +=C2=A0=C2=A0=C2=A0 /// already been added, and create a mutator for it.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If a composer already exists for this `crtc`, thi=
s function
> returns `Error(EBUSY)`. If
> +=C2=A0=C2=A0=C2=A0 /// attempting to add the state fails, another error =
code will
> be returned.
> +=C2=A0=C2=A0=C2=A0 pub fn add_crtc_state<C>(&self, crtc: &C) ->
> Result<CrtcStateMutator<'_, C::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableCrtc + ModeObj=
ect<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM will only retu=
rn a valid pointer to a
> `drm_crtc_state` - or an error.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_=
err_ptr(bindings::drm_atomic_get_crtc_state(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 crtc.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .map(=
|c| NonNull::new_unchecked(c))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CrtcStateMutator::<C::State>:=
:new(self, state).ok_or(EBUSY)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Attempt to add the state for `plane` to the atomi=
c state for
> this composer if it hasn't
> +=C2=A0=C2=A0=C2=A0 /// already been added, and create a mutator for it.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If a composer already exists for this `plane`, th=
is function
> returns `Error(EBUSY)`. If
> +=C2=A0=C2=A0=C2=A0 /// attempting to add the state fails, another error =
code will
> be returned.
> +=C2=A0=C2=A0=C2=A0 pub fn add_plane_state<P>(&self, plane: &P) ->
> Result<PlaneStateMutator<'_, P::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P: ModesettablePlane + ModeOb=
ject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM will only retu=
rn a valid pointer to a
> `drm_plane_state` - or an error.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_=
err_ptr(bindings::drm_atomic_get_plane_state(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 plane.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .map(=
|p| NonNull::new_unchecked(p))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneStateMutator::<P::State>=
::new(self, state).ok_or(EBUSY)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Attempt to add the state for `connector` to the a=
tomic state
> for this composer if it hasn't
> +=C2=A0=C2=A0=C2=A0 /// already been added, and create a mutator for it.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If a composer already exists for this `connector`=
, this
> function returns `Error(EBUSY)`. If
> +=C2=A0=C2=A0=C2=A0 /// attempting to add the state fails, another error =
code will
> be returned.
> +=C2=A0=C2=A0=C2=A0 pub fn add_connector_state<C>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connector: &C,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<ConnectorStateMutator<'_, C::State>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableConnector + Mo=
deObject<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM will only retu=
rn a valid pointer to a
> `drm_plane_state` - or an error.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_=
err_ptr(bindings::drm_atomic_get_connector_state(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 connector.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .map(=
|c| NonNull::new_unchecked(c))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConnectorStateMutator::<C::St=
ate>::new(self,
> state).ok_or(EBUSY)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Attempt to add any planes affected by changes on =
`crtc` to
> this [`AtomicStateComposer`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Will return an [`Error`] if this fails.
> +=C2=A0=C2=A0=C2=A0 pub fn add_affected_planes<C>(&self, crtc: &C) -> Res=
ult
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: ModesettableCrtc + ModeObj=
ect<Driver =3D T>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Both .as_raw() val=
ues are guaranteed to return a
> valid pointer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> bindings::drm_atomic_add_affected_planes(self.as_raw(),
> crtc.as_raw()) })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A macro for declaring the repetitive take_all(), take_state(),
> etc. methods for atomic state
> +/// token types.
> +///
> +/// It is assumed that $token_name refers to a struct that contains
> two members:
> +///
> +/// - `state`: This should be the atomic state type to use
> +/// - The object in question. The name of this member is generated
> by converting $obj to lowercase.
> +///
> +/// The struct should have one lifetime ($lifetime_a) declared, and
> one meta-variable ($meta) which
> +/// should be bound to the Driver* trait for the given mode object.
> +macro_rules! impl_atomic_state_token_ops {
> +=C2=A0=C2=A0=C2=A0 (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $token_name:ident,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $state:ident,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $obj:ident,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use <$lifetime_a:lifetime, $m=
eta:ident>
> +=C2=A0=C2=A0=C2=A0 ) =3D> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel::macros::paste! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// C=
reate a new token.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// #=
 Safety
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// T=
o use this function it must be known in the current
> context that:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// -=
 The object has had its atomic states added to
> `state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// -=
 No state mutator can possibly be taken out for the
> objects new state.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub(c=
rate) unsafe fn new(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [<$obj:lower>]: &$lifetime_a $obj<$meta>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state: &$lifetime_a $state<$meta::Driver>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) -> =
Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Self { [<$obj:lower>], state }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Get the [`", stringify!($obj), "`]
> associated with this",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 " [`", stringify!($token_name), "`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n [<$obj:lower>](&self) -> &$lifetime_a $obj<$meta>
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.[<$obj:lower>]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// E=
xchange this token for a (atomic_state, old_state,
> new_state) tuple.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_all(self) -> (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a $state<$meta::Driver>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a [<$obj State>]<$meta::State>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [<$obj StateMutator>]<$lifetime_a, [<$obj
> State>]<$meta::State>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let (old_state, new_state) =3D (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.[<get_old_ $obj:lower
> _state>](self.[<$obj:lower>]),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.[<get_new_ $obj:lower
> _state>](self.[<$obj:lower>]),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - Both the old and new object state are present
> in `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed to have no mutators
> taken out via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let (old_state, new_state) =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (old_state.unwrap_unchecked(),
> new_state.unwrap_unchecked())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (self.state, old_state, new_state)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Exchange this token for the old [`",
> stringify!($obj), "State`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_old_state(self) -> &$lifetime_a [<$obj
> State>]<$meta::State> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let old =3D self.state.[<get_old_ $obj:lower
> _state>](self.[<$obj:lower>]);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: The old state is guaranteed to be present
> in `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsafe { old.unwrap_unchecked() }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Exchange this token for the new [`",
> stringify!($obj), "State`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_new_state(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) -> =
[<$obj StateMutator>]<$lifetime_a, [<$obj
> State>]<$meta::State>> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let new =3D self.state.[<get_new_ $obj:lower
> _state>](self.[<$obj:lower>]);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed to be present in
> our `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed not to have any
> mutators taken out for it via our
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsafe { new.unwrap_unchecked() }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Exchange this token for both the old
> and new [`",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 stringify!($obj), "State`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_old_new_state(self) -> (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a [<$obj State>]<$meta::State>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [<$obj StateMutator>]<$lifetime_a, [<$obj
> State>]<$meta::State>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let (old_state, new_state) =3D (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.[<get_old_ $obj:lower
> _state>](self.[<$obj:lower>]),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.[<get_new_ $obj:lower
> _state>](self.[<$obj:lower>]),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - Both the old and new object state are present
> in `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed to have no mutators
> taken out via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let (old_state, new_state) =3D unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (old_state.unwrap_unchecked(),
> new_state.unwrap_unchecked())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (old_state, new_state)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Exchange this token for both the [`",
> stringify!($state),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "`] and the old [`", stringify!($obj),
> "State`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_state_old_state(self) -> (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a $state<$meta::Driver>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a [<$obj State>]<$meta::State>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let old =3D self.state.[<get_old_ $obj:lower
> _state>](self.[<$obj:lower>]);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: The old state is guaranteed to be present
> in `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (self.state, unsafe { old.unwrap_unchecked() })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc=
 =3D concat!("Exchange this token for both the [`",
> stringify!($state),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "`] and the new [`", stringify!($obj),
> "State`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub f=
n take_state_new_state(self) -> (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &$lifetime_a $state<$meta::Driver>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [<$obj StateMutator>]<$lifetime_a, [<$obj
> State>]<$meta::State>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 let new =3D self.state.[<get_new_ $obj:lower
> _state>](self.[<$obj:lower>]);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed to be present in
> `state` via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // - The new state is guaranteed to have no mutators
> taken out via our type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (self.state, unsafe { new.unwrap_unchecked() })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("Exchange t=
his token for the [`",
> stringify!($state), "`].")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub fn take_state(self) -> &$=
lifetime_a
> $state<$meta::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
state
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +pub(crate) use impl_atomic_state_token_ops;
> +
> +/// A token proving that no modesets for a commit have completed.
> +///
> +/// This token is proof that no commits have yet completed, and is
> provided as an argument to
> +/// [`KmsDriver::atomic_commit_tail`]. This may be used with
> +/// [`AtomicCommitTail::commit_modeset_disables`].
> +pub struct ModesetsReadyToken<'a>(PhantomData<&'a ()>);
> +
> +/// A token proving that modeset disables for a commit have
> completed.
> +///
> +/// This token is proof that an implementor's
> [`KmsDriver::atomic_commit_tail`] phase has finished
> +/// committing any operations which disable mode objects. It is
> returned by
> +/// [`AtomicCommitTail::commit_modeset_disables`], and can be used
> with
> +/// [`AtomicCommitTail::commit_modeset_enables`] to acquire a
> [`EnablesCommittedToken`].
> +pub struct DisablesCommittedToken<'a>(PhantomData<&'a ()>);
> +
> +/// A token proving that modeset enables for a commit have
> completed.
> +///
> +/// This token is proof that an implementor's
> [`KmsDriver::atomic_commit_tail`] phase has finished
> +/// committing any operations which enable mode objects. It is
> returned by
> +/// [`AtomicCommitTail::commit_modeset_enables`].
> +pub struct EnablesCommittedToken<'a>(PhantomData<&'a ()>);
> +
> +/// A token proving that no plane updates for a commit have
> completed.
> +///
> +/// This token is proof that no plane updates have yet been
> completed within an implementor's
> +/// [`KmsDriver::atomic_commit_tail`] implementation, and that we
> are ready to begin updating planes. It
> +/// is provided as an argument to [`KmsDriver::atomic_commit_tail`].
> +pub struct PlaneUpdatesReadyToken<'a>(PhantomData<&'a ()>);
> +
> +/// A token proving that all plane updates for a commit have
> completed.
> +///
> +/// This token is proof that all plane updates within an
> implementor's [`KmsDriver::atomic_commit_tail`]
> +/// implementation have completed. It is returned by
> [`AtomicCommitTail::commit_planes`].
> +pub struct PlaneUpdatesCommittedToken<'a>(PhantomData<&'a ()>);
> +
> +/// An [`AtomicState`] interface that allows a driver to control the
> [`atomic_commit_tail`]
> +/// callback.
> +///
> +/// This object is provided as an argument to
> [`KmsDriver::atomic_commit_tail`], and represents an atomic
> +/// state within the commit tail phase which is still in the process
> of being committed to hardware.
> +/// It may be used to control the order in which the commit process
> happens.
> +///
> +/// # Invariants
> +///
> +/// Same as [`AtomicState`].
> +///
> +/// [`atomic_commit_tail`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +pub struct AtomicCommitTail<'a, T: KmsDriver>(&'a AtomicState<T>);
> +
> +impl<'a, T: KmsDriver> AtomicCommitTail<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Commit modesets which would disable outputs.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function commits any modesets which would sh=
ut down
> outputs, along with preparing them
> +=C2=A0=C2=A0=C2=A0 /// for a new mode (if needed).
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Since it is physically impossible to disable an o=
utput
> multiple times, and since it is
> +=C2=A0=C2=A0=C2=A0 /// logically unsound to disable an output within an =
atomic
> commit after the output was enabled
> +=C2=A0=C2=A0=C2=A0 /// in the same commit - this function requires a
> [`ModesetsReadyToken`] to consume and returns
> +=C2=A0=C2=A0=C2=A0 /// a [`DisablesCommittedToken`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If compatibility with legacy CRTC helpers is desi=
red, this
> +=C2=A0=C2=A0=C2=A0 /// should be called before [`commit_planes`] which i=
s what the
> default commit function does.
> +=C2=A0=C2=A0=C2=A0 /// But drivers with different needs can group the mo=
deset
> commits tgether and do the plane
> +=C2=A0=C2=A0=C2=A0 /// commits at the end. This is useful for drivers do=
ing runtime
> PM since then plane updates
> +=C2=A0=C2=A0=C2=A0 /// only happen when the CRTC is actually enabled.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`commit_planes`]: AtomicCommitTail::commit_plane=
s
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 #[must_use]
> +=C2=A0=C2=A0=C2=A0 pub fn commit_modeset_disables<'b>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _token: ModesetsReadyToken<'_=
>,
> +=C2=A0=C2=A0=C2=A0 ) -> DisablesCommittedToken<'b> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Both `as_raw()` ca=
lls are guaranteed to return
> valid pointers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_helper_commit_modeset_disables(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.drm_dev().as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DisablesCommittedToken(Phanto=
mData)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Commit all plane updates.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function performs all plane updates for the =
given
> [`AtomicCommitTail`]. Since it is
> +=C2=A0=C2=A0=C2=A0 /// logically unsound to perform the same plane updat=
e more then
> once in a given atomic commit,
> +=C2=A0=C2=A0=C2=A0 /// this function requires a [`PlaneUpdatesReadyToken=
`] to
> consume and returns a
> +=C2=A0=C2=A0=C2=A0 /// [`PlaneUpdatesCommittedToken`] to prove that plan=
e updates
> for the state have completed.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 #[must_use]
> +=C2=A0=C2=A0=C2=A0 pub fn commit_planes<'b>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _token: PlaneUpdatesReadyToke=
n<'_>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags: PlaneCommitFlags,
> +=C2=A0=C2=A0=C2=A0 ) -> PlaneUpdatesCommittedToken<'b> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Both `as_raw()` ca=
lls are guaranteed to return
> valid pointers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_helper_commit_planes(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.drm_dev().as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 flags.into(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneUpdatesCommittedToken(Ph=
antomData)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Commit modesets which would enable outputs.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function commits any modesets in the given
> [`AtomicCommitTail`] which would enable
> +=C2=A0=C2=A0=C2=A0 /// outputs, along with preparing them for their new =
modes (if
> needed).
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Since it is logically unsound to enable an output=
 before any
> disabling modesets within the
> +=C2=A0=C2=A0=C2=A0 /// same atomic commit have been performed, and physi=
cally
> impossible to enable the same output
> +=C2=A0=C2=A0=C2=A0 /// multiple times - this function requires a
> [`DisablesCommittedToken`] to consume and returns
> +=C2=A0=C2=A0=C2=A0 /// a [`EnablesCommittedToken`] which may be used as =
proof that
> all modesets in the state have
> +=C2=A0=C2=A0=C2=A0 /// been completed.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 #[must_use]
> +=C2=A0=C2=A0=C2=A0 pub fn commit_modeset_enables<'b>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _token: DisablesCommittedToke=
n<'_>,
> +=C2=A0=C2=A0=C2=A0 ) -> EnablesCommittedToken<'b> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Both `as_raw()` ca=
lls are guaranteed to return
> valid pointers
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_helper_commit_modeset_enables(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.drm_dev().as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EnablesCommittedToken(Phantom=
Data)
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Fake vblank events if needed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Note that this is still relevant to drivers which=
 don't
> implement [`VblankSupport`] for any
> +=C2=A0=C2=A0=C2=A0 /// of their CRTCs.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// TODO: more doc
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`VblankSupport`]: super::vblank::VblankSupport
> +=C2=A0=C2=A0=C2=A0 pub fn fake_vblank(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` is guar=
anteed to always return a valid
> pointer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::drm_atomic_helper_fake_vblank(self.0.as_raw()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Signal completion of the hardware commit step.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This swaps the atomic state into the relevant ato=
mic state
> pointers and marks the hardware
> +=C2=A0=C2=A0=C2=A0 /// commit step as completed. Since this step can onl=
y happen
> after all plane updates and
> +=C2=A0=C2=A0=C2=A0 /// modesets within an [`AtomicCommitTail`] have been=
 completed,
> it requires both a
> +=C2=A0=C2=A0=C2=A0 /// [`EnablesCommittedToken`] and a
> [`PlaneUpdatesCommittedToken`] to consume. After this
> +=C2=A0=C2=A0=C2=A0 /// function is called, the caller no longer has excl=
usive
> access to the underlying atomic
> +=C2=A0=C2=A0=C2=A0 /// state. As such, this function consumes the
> [`AtomicCommitTail`] object and returns a
> +=C2=A0=C2=A0=C2=A0 /// [`CommittedAtomicState`] accessor for performing =
post-hw
> commit tasks.
> +=C2=A0=C2=A0=C2=A0 pub fn commit_hw_done<'b>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _modeset_token: EnablesCommit=
tedToken<'_>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _plane_updates_token: PlaneUp=
datesCommittedToken<'_>,
> +=C2=A0=C2=A0=C2=A0 ) -> CommittedAtomicState<'b, T>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'a: 'b,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: we consume the `At=
omicCommitTail` object, making
> it impossible for the user to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // mutate the state after thi=
s function has been called -
> which upholds the safety
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // requirements of the C API =
allowing us to safely call this
> function
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::drm_atomic_helper_commit_hw_done(self.0.as_raw()) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CommittedAtomicState(self.0)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// The actual raw C callback for custom atomic commit tail
> implementations
> +pub(crate) unsafe extern "C" fn commit_tail_callback<T: KmsDriver>(
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `state` always poin=
ts to a
> valid instance of
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `bindings::drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 // - This conversion is safe via the type invariants
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { AtomicState::from_raw(state.ca=
st_const())
> };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_commit_tail(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AtomicCommitTail(state),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ModesetsReadyToken(PhantomDat=
a),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneUpdatesReadyToken(Phanto=
mData),
> +=C2=A0=C2=A0=C2=A0 );
> +}
> +
> +/// An [`AtomicState`] which was just committed with
> [`AtomicCommitTail::commit_hw_done`].
> +///
> +/// This object represents an [`AtomicState`] which has been fully
> committed to hardware, and as
> +/// such may no longer be mutated as it is visible to userspace. It
> may be used to control what
> +/// happens immediately after an atomic commit finishes within the
> [`atomic_commit_tail`] callback.
> +///
> +/// Since acquiring this object means that all modesetting locks
> have been dropped, a non-blocking
> +/// commit could happen at the same time an [`atomic_commit_tail`]
> implementer has access to this
> +/// object. Thus, it cannot be assumed that this object represents
> the current hardware state - and
> +/// instead only represents the final result of the
> [`AtomicCommitTail`] that was just committed.
> +///
> +/// # Invariants
> +///
> +/// It may be assumed that [`drm_atomic_helper_commit_hw_done`] has
> been called as long as this type
> +/// exists.
> +///
> +/// [`atomic_commit_tail`]: KmsDriver::atomic_commit_tail
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +pub struct CommittedAtomicState<'a, T: KmsDriver>(&'a
> AtomicState<T>);
> +
> +impl<'a, T: KmsDriver> CommittedAtomicState<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Wait for page flips on this state to complete
> +=C2=A0=C2=A0=C2=A0 pub fn wait_for_flip_done(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm_atomic_helper=
_commit_hw_done` has been
> called via our invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_helper_wait_for_flip_done(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.drm_dev().as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.0.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: KmsDriver> Drop for CommittedAtomicState<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * This interface represent=
s the last atomic state
> accessor which could be affected as a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 result of reso=
urces from an atomic commit being cleaned
> up.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> bindings::drm_atomic_helper_cleanup_planes(self.0.drm_dev().as_raw(),
> self.0.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// An enumator representing a single flag in [`PlaneCommitFlags`].
> +///
> +/// This is a non-exhaustive list, as the C side could add more
> later.
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(u32)]
> +#[non_exhaustive]
> +pub enum PlaneCommitFlag {
> +=C2=A0=C2=A0=C2=A0 /// Don't notify applications of plane updates for ne=
wly-
> disabled planes. Drivers are encouraged
> +=C2=A0=C2=A0=C2=A0 /// to set this flag by default, as otherwise they ne=
ed to
> ignore plane updates for disabled
> +=C2=A0=C2=A0=C2=A0 /// planes by hand.
> +=C2=A0=C2=A0=C2=A0 ActiveOnly =3D (1 << 0),
> +=C2=A0=C2=A0=C2=A0 /// Tell the DRM core that the display hardware requi=
res that a
> [`Crtc`]'s planes must be
> +=C2=A0=C2=A0=C2=A0 /// disabled when the [`Crtc`] is disabled. When not =
specified,
> +=C2=A0=C2=A0=C2=A0 /// [`AtomicCommitTail::commit_planes`] will skip the=
 atomic
> disable callbacks for a plane if
> +=C2=A0=C2=A0=C2=A0 /// the [`Crtc`] in the old [`PlaneState`] needs a mo=
desetting
> operation. It is still up to the
> +=C2=A0=C2=A0=C2=A0 /// driver to disable said planes in their
> [`DriverCrtc::atomic_disable`] callback.
> +=C2=A0=C2=A0=C2=A0 NoDisableAfterModeset =3D (1 << 1),
> +}
> +
> +impl BitOr for PlaneCommitFlag {
> +=C2=A0=C2=A0=C2=A0 type Output =3D PlaneCommitFlags;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitor(self, rhs: Self) -> Self::Output {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneCommitFlags(self as u32 =
| rhs as u32)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitOr<PlaneCommitFlags> for PlaneCommitFlag {
> +=C2=A0=C2=A0=C2=A0 type Output =3D PlaneCommitFlags;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitor(self, rhs: PlaneCommitFlags) -> Self::Output=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneCommitFlags(self as u32 =
| rhs.0)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A bitmask for controlling the behavior of
> [`AtomicCommitTail::commit_planes`].
> +///
> +/// This corresponds to the `DRM_PLANE_COMMIT_*` flags on the C
> side. Note that this bitmask does
> +/// not discard unknown values in order to ensure that adding new
> flags on the C side of things does
> +/// not break anything in the future.
> +#[derive(Copy, Clone, Default, PartialEq, Eq)]
> +pub struct PlaneCommitFlags(u32);
> +
> +impl From<PlaneCommitFlag> for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 fn from(value: PlaneCommitFlag) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(value as u32)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl From<PlaneCommitFlags> for u32 {
> +=C2=A0=C2=A0=C2=A0 fn from(value: PlaneCommitFlags) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value.0
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitOr for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 type Output =3D Self;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitor(self, rhs: Self) -> Self::Output {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(self.0 | rhs.0)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitOrAssign for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 fn bitor_assign(&mut self, rhs: Self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *self =3D *self | rhs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitAnd for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 type Output =3D PlaneCommitFlags;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitand(self, rhs: Self) -> Self::Output {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(self.0 & rhs.0)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitAndAssign for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 fn bitand_assign(&mut self, rhs: Self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *self =3D *self & rhs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitOr<PlaneCommitFlag> for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 type Output =3D Self;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitor(self, rhs: PlaneCommitFlag) -> Self::Output =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self | Self::from(rhs)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitOrAssign<PlaneCommitFlag> for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 fn bitor_assign(&mut self, rhs: PlaneCommitFlag) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *self =3D *self | rhs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitAnd<PlaneCommitFlag> for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 type Output =3D PlaneCommitFlags;
> +
> +=C2=A0=C2=A0=C2=A0 fn bitand(self, rhs: PlaneCommitFlag) -> Self::Output=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self & Self::from(rhs)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl BitAndAssign<PlaneCommitFlag> for PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 fn bitand_assign(&mut self, rhs: PlaneCommitFlag) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *self =3D *self & rhs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl PlaneCommitFlags {
> +=C2=A0=C2=A0=C2=A0 /// Create a new bitmask.
> +=C2=A0=C2=A0=C2=A0 pub fn new() -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self::default()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Check if the bitmask has the given commit flag se=
t.
> +=C2=A0=C2=A0=C2=A0 pub fn has(&self, flag: PlaneCommitFlag) -> bool {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *self & flag =3D=3D flag.into=
()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> diff --git a/rust/kernel/drm/kms/connector.rs
> b/rust/kernel/drm/kms/connector.rs
> new file mode 100644
> index 000000000000..05ec64cf6fa2
> --- /dev/null
> +++ b/rust/kernel/drm/kms/connector.rs
> @@ -0,0 +1,997 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM display connectors.
> +//!
> +//! C header:
> [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
> +
> +use super::{
> +=C2=A0=C2=A0=C2=A0 atomic::*, encoder::*, KmsDriver, ModeConfigGuard, Mo=
deObject,
> ModeObjectVtable, Sealed
> +};
> +use crate::{
> +=C2=A0=C2=A0=C2=A0 alloc::KBox,
> +=C2=A0=C2=A0=C2=A0 bindings,
> +=C2=A0=C2=A0=C2=A0 drm::{device::Device, kms::{NewKmsDevice, Probing}},
> +=C2=A0=C2=A0=C2=A0 error::to_result,
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 types::{NotThreadSafe, Opaque},
> +};
> +use core::{
> +=C2=A0=C2=A0=C2=A0 cell::Cell,
> +=C2=A0=C2=A0=C2=A0 marker::*,
> +=C2=A0=C2=A0=C2=A0 mem::{self, ManuallyDrop},
> +=C2=A0=C2=A0=C2=A0 ops::*,
> +=C2=A0=C2=A0=C2=A0 ptr::{null_mut, NonNull},
> +=C2=A0=C2=A0=C2=A0 stringify,
> +};
> +use macros::paste;
> +
> +/// A macro for generating our type ID enumerator.
> +macro_rules! declare_conn_types {
> +=C2=A0=C2=A0=C2=A0 ($( $oldname:ident as $newname:ident ),+) =3D> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// An enumerator for all pos=
sible [`Connector`] type IDs.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[repr(i32)]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[non_exhaustive]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[derive(Copy, Clone, Partial=
Eq, Eq)]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub enum Type {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // No=
te: bindgen defaults the macro values to u32 and
> not i32, but DRM takes them as an
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // i3=
2 - so just do the conversion here
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("The connector type ID for a ",
> stringify!($newname), " connector.")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 $newname =3D
> paste!(crate::bindings::[<DRM_MODE_CONNECTOR_ $oldname>]) as i32
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ),+,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // 9P=
inDIN is special because of the 9, making it an
> invalid ident. Just define it here
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // ma=
nually since it's the only one
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// T=
he connector type ID for a 9PinDIN connector.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _9Pin=
Din =3D crate::bindings::DRM_MODE_CONNECTOR_9PinDIN
> as i32
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +declare_conn_types! {
> +=C2=A0=C2=A0=C2=A0 Unknown=C2=A0=C2=A0=C2=A0=C2=A0 as Unknown,
> +=C2=A0=C2=A0=C2=A0 Composite=C2=A0=C2=A0 as Composite,
> +=C2=A0=C2=A0=C2=A0 Component=C2=A0=C2=A0 as Component,
> +=C2=A0=C2=A0=C2=A0 DisplayPort as DisplayPort,
> +=C2=A0=C2=A0=C2=A0 VGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Vga,
> +=C2=A0=C2=A0=C2=A0 DVII=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dvi=
I,
> +=C2=A0=C2=A0=C2=A0 DVID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dvi=
D,
> +=C2=A0=C2=A0=C2=A0 DVIA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dvi=
A,
> +=C2=A0=C2=A0=C2=A0 SVIDEO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as SVideo,
> +=C2=A0=C2=A0=C2=A0 LVDS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Lvd=
s,
> +=C2=A0=C2=A0=C2=A0 HDMIA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as HdmiA,
> +=C2=A0=C2=A0=C2=A0 HDMIB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as HdmiB,
> +=C2=A0=C2=A0=C2=A0 TV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 as Tv,
> +=C2=A0=C2=A0=C2=A0 eDP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Edp,
> +=C2=A0=C2=A0=C2=A0 VIRTUAL=C2=A0=C2=A0=C2=A0=C2=A0 as Virtual,
> +=C2=A0=C2=A0=C2=A0 DSI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Dsi,
> +=C2=A0=C2=A0=C2=A0 DPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Dpi,
> +=C2=A0=C2=A0=C2=A0 WRITEBACK=C2=A0=C2=A0 as Writeback,
> +=C2=A0=C2=A0=C2=A0 SPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Spi,
> +=C2=A0=C2=A0=C2=A0 USB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
s Usb
> +}
> +
> +/// The main trait for implementing the [`struct drm_connector`] API
> for [`Connector`].
> +///
> +/// Any KMS driver should have at least one implementation of this
> type, which allows them to create
> +/// [`Connector`] objects. Additionally, a driver may store driver-
> private data within the type that
> +/// implements [`DriverConnector`] - and it will be made available
> when using a fully typed
> +/// [`Connector`] object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_connector`] pointers are contained within a
> [`Connector<Self>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_connector_state`] pointers are contained wi=
thin a
> +///=C2=A0=C2=A0 [`ConnectorState<Self::State>`].
> +///
> +/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
> +/// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +#[vtable]
> +pub trait DriverConnector: Send + Sync + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The generated C vtable for this [`DriverConnector=
`]
> implementation
> +=C2=A0=C2=A0=C2=A0 const OPS: &'static DriverConnectorOps =3D &DriverCon=
nectorOps {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_connecto=
r_funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpms:=
 None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_get_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_set_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early=
_unregister: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 late_=
register: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_p=
roperty: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset=
: Some(connector_reset_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_print_state: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_destroy_state:
> Some(atomic_destroy_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destr=
oy: Some(connector_destroy_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force=
: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 detec=
t: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fill_=
modes:
> Some(bindings::drm_helper_probe_single_connector_modes),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug=
fs_init: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oob_h=
otplug_event: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_duplicate_state:
> Some(atomic_duplicate_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_c=
onnector_helper_funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
valid: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_check: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_m=
odes: Some(get_modes_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 detec=
t_ctx: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabl=
e_hpd: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disab=
le_hpd: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 best_=
encoder: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_commit: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
valid_ctx: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_best_encoder: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepa=
re_writeback_job: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clean=
up_writeback_job: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 /// The type to pass to the `args` field of
> [`UnregisteredConnector::new`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This type will be made available in in the `args`=
 argument
> of [`Self::new`]. Drivers which
> +=C2=A0=C2=A0=C2=A0 /// don't need this can simply pass [`()`] here.
> +=C2=A0=C2=A0=C2=A0 type Args;
> +
> +=C2=A0=C2=A0=C2=A0 /// The parent [`KmsDriver`] implementation.
> +=C2=A0=C2=A0=C2=A0 type Driver: KmsDriver;
> +
> +=C2=A0=C2=A0=C2=A0 /// The [`DriverConnectorState`] implementation for t=
his
> [`DriverConnector`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// See [`DriverConnectorState`] for more info.
> +=C2=A0=C2=A0=C2=A0 type State: DriverConnectorState;
> +
> +=C2=A0=C2=A0=C2=A0 /// The constructor for creating a [`Connector`] usin=
g this
> [`DriverConnector`] implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to instantiate their
> [`DriverConnector`] object.
> +=C2=A0=C2=A0=C2=A0 fn new(device: &Device<Self::Driver>, args: Self::Arg=
s) -> impl
> PinInit<Self, Error>;
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve a list of available display modes for th=
is
> [`Connector`].
> +=C2=A0=C2=A0=C2=A0 fn get_modes<'a>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connector: ConnectorGuard<'a,=
 Self>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard: &ModeConfigGuard<'a, S=
elf::Driver>,
> +=C2=A0=C2=A0=C2=A0 ) -> i32;
> +}
> +
> +/// The generated C vtable for a [`DriverConnector`].
> +///
> +/// This type is created internally by DRM.
> +pub struct DriverConnectorOps {
> +=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_connector_funcs,
> +=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_connector_helper_funcs,
> +}
> +
> +/// The main interface for a [`struct drm_connector`].
> +///
> +/// This type is the main interface for dealing with DRM connectors.
> In addition, it also allows
> +/// immutable access to whatever private data is contained within an
> implementor's
> +/// [`DriverConnector`] type.
> +///
> +/// # Invariants
> +///
> +/// - The DRM C API and our interface guarantees that only the user
> has mutable access to `state`,
> +///=C2=A0=C2=A0 up until [`drm_atomic_helper_commit_hw_done`] is called.
> Therefore, `connector` follows rust's
> +///=C2=A0=C2=A0 data aliasing rules and does not need to be behind an
> [`Opaque`] type.
> +/// - `connector` and `inner` are initialized for as long as this
> object is made available to users.
> +/// - The data layout of this structure begins with [`struct
> drm_connector`].
> +/// - The atomic state for this type can always be assumed to be of
> type
> +///=C2=A0=C2=A0 [`ConnectorState<T::State>`].
> +///
> +/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +#[repr(C)]
> +#[pin_data]
> +pub struct Connector<T: DriverConnector> {
> +=C2=A0=C2=A0=C2=A0 connector: Opaque<bindings::drm_connector>,
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +}
> +
> +impl<T: DriverConnector> Sealed for Connector<T> {}
> +
> +impl<T: DriverConnector> Deref for Connector<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverConnector> Connector<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D>(&'a OpaqueConnecto=
r<D>) -> &'a Self;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T as =
DriverConnector,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Connector =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Acquire a [`ConnectorGuard`] for this connector f=
rom a
> [`ModeConfigGuard`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This verifies using the provided reference that t=
he given
> guard is actually for the same
> +=C2=A0=C2=A0=C2=A0 /// device as this connector's parent.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Panics
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Panics if `guard` is not a [`ModeConfigGuard`] fo=
r this
> connector's parent [`Device`].
> +=C2=A0=C2=A0=C2=A0 pub fn guard<'a>(&'a self, guard: &ModeConfigGuard<'a=
,
> T::Driver>) -> ConnectorGuard<'a, T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard.assert_owner(self.drm_d=
ev());
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConnectorGuard(self)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A trait implemented by any type that acts as a [`struct
> drm_connector`] interface.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// [`as_raw()`] must always return a pointer to a valid initialized
> [`struct drm_connector`].
> +///
> +/// [`as_raw()`]: AsRawConnector::as_raw()
> +/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
> +pub unsafe trait AsRawConnector {
> +=C2=A0=C2=A0=C2=A0 /// Return the raw [`struct drm_connector`] for this =
DRM
> connector.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers should never use this directly
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_Connector`]:
> srctree/include/drm/drm_connector.h
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_connector;
> +
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw `bindings::drm_connector` pointer i=
nto an
> object of this type.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Callers promise that `ptr` points to a valid inst=
ance of
> this type.
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connec=
tor) -> &'a
> Self;
> +}
> +
> +/// A supertrait of [`AsRawConnector`] for [`struct drm_connector`]
> interfaces that can perform
> +/// modesets.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// Any object implementing this trait must only be made directly
> available to the user after
> +/// [`create_objects`] has completed.
> +///
> +/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
> +/// [`create_objects`]: KmsDriver::create_objects
> +pub unsafe trait ModesettableConnector: AsRawConnector {
> +=C2=A0=C2=A0=C2=A0 /// The type that should be returned for a plane stat=
e acquired
> using this plane interface
> +=C2=A0=C2=A0=C2=A0 type State: FromRawConnectorState;
> +}
> +
> +// SAFETY: Our connector interfaces are guaranteed to be thread-safe
> +unsafe impl<T: DriverConnector> Send for Connector<T> {}
> +
> +// SAFETY: Our connector interfaces are guaranteed to be thread-safe
> +unsafe impl<T: DriverConnector> Sync for Connector<T> {}
> +
> +// SAFETY: We don't expose Connector<T> to users before `base` is
> initialized in ::new(), so
> +// `raw_mode_obj` always returns a valid pointer to a
> bindings::drm_mode_object.
> +unsafe impl<T: DriverConnector> ModeObject for Connector<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T::Driver;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The parent device =
for a DRM connector will never
> outlive the connector, and this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // pointer is invariant throu=
gh the lifetime of the
> connector
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose DR=
M connectors to users before
> `base` is initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.as_r=
aw()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// Connectors are refcounted objects.
> +super::impl_aref_for_mode_object! {
> +=C2=A0=C2=A0=C2=A0 impl<T: DriverConnector> for Connector<T>
> +}
> +
> +// SAFETY: `funcs` is initialized by DRM when the connector is
> allocated
> +unsafe impl<T: DriverConnector> ModeObjectVtable for Connector<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_connector_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `funcs` is initial=
ized by DRM when the connector
> is allocated
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY:
> +// * Via our type variants our data layout starts with
> `drm_connector`
> +// * Since we don't expose `Connector` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_connector`.
> +unsafe impl<T: DriverConnector> AsRawConnector for Connector<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.connector.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connec=
tor) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout st=
arts with
> `bindings::drm_connector`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: DriverConnector> ModesettableConnector for
> Connector<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D ConnectorState<T::State>;
> +}
> +
> +/// A [`Connector`] that has not yet been registered with userspace.
> +///
> +/// KMS registration is single-threaded, so this object is not
> thread-safe.
> +///
> +/// # Invariants
> +///
> +/// - This object can only exist before its respective KMS device
> has been registered.
> +/// - Otherwise, it inherits all invariants of [`Connector`] and has
> an identical data layout.
> +pub struct UnregisteredConnector<T: DriverConnector>(Connector<T>,
> NotThreadSafe);
> +
> +// SAFETY: We share the invariants of `Connector`
> +unsafe impl<T: DriverConnector> AsRawConnector for
> UnregisteredConnector<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connec=
tor) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This is another fr=
om_raw() call, so this function
> shares the same safety contract
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let connector =3D unsafe { Co=
nnector::<T>::from_raw(ptr) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical via our type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { mem::transmute(conne=
ctor) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverConnector> Deref for UnregisteredConnector<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverConnector> UnregisteredConnector<T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`UnregisteredConnector`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A driver may use this to create new
> [`UnregisteredConnector`] objects.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`KmsDriver::create_objects`]:
> kernel::drm::kms::KmsDriver::create_objects
> +=C2=A0=C2=A0=C2=A0 pub fn new<'a>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a NewKmsDevice<'a, T::=
Driver, Probing>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_: Type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args: T::Args,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<&'a Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new: Pin<KBox<Connector<T=
>>> =3D KBox::try_pin_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_p=
in_init!(Connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 connector: Opaque::new(bindings::drm_connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_private: &T::OPS.helper_f=
uncs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inner <- T::new(dev, args),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_K=
ERNEL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `dev` will hold a refere=
nce to the new connector, and
> thus outlives us.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We just allocated `new` =
above
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `new` starts with `drm_c=
onnector` via its type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_connector_init(dev.as_raw(), new.as_raw(),
> &T::OPS.funcs, type_ as i32)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't move anyt=
hing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { Pin::in=
to_inner_unchecked(new) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We'll re-assemble the box =
in connector_destroy_callback()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D KBox::into_raw(t=
his);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // UnregisteredConnector has =
an equivalent data layout
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: *mut Self =3D this.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just allocated =
the connector above, so this
> pointer must be valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { &*this })
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Attach an encoder to this [`Connector`].
> +=C2=A0=C2=A0=C2=A0 #[must_use]
> +=C2=A0=C2=A0=C2=A0 pub fn attach_encoder(&self, encoder: &impl AsRawEnco=
der) ->
> Result {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Both as_raw() calls are =
guaranteed to return a valid
> pointer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed this co=
nnector is not registered via
> our type invariants, thus this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 function is sa=
fe to call
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_connector_attach_encoder(self.as_raw(),
> encoder.as_raw())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// Common methods available on any type which implements
> [`AsRawConnector`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// connectors.
> +pub trait RawConnector: AsRawConnector {
> +=C2=A0=C2=A0=C2=A0 /// Return the index of this DRM connector
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn index(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The index is initi=
alized by the time we expose
> DRM connector objects to users,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // and is invariant throughou=
t the lifetime of the connector
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).ind=
ex }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the bitmask derived from this DRM connecto=
r's index
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn mask(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 << self.index()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawConnector> RawConnector for T {}
> +
> +unsafe extern "C" fn connector_destroy_callback<T: DriverConnector>(
> +=C2=A0=C2=A0=C2=A0 connector: *mut bindings::drm_connector,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `connector` points to =
a valid
> initialized `drm_connector`.
> +=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindings::drm_connector_unreg=
ister(connector);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindings::drm_connector_clean=
up(connector);
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We originally created the connector in a `Box`
> +=C2=A0=C2=A0=C2=A0 // - We are guaranteed to hold the last remaining ref=
erence to
> this connector
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via `DriverConnector`s type in=
variants.
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { KBox::from_raw(connector as *mut Connec=
tor<T>) });
> +}
> +
> +unsafe extern "C" fn get_modes_callback<T: DriverConnector>(
> +=C2=A0=C2=A0=C2=A0 connector: *mut bindings::drm_connector,
> +) -> core::ffi::c_int {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This is safe via `DriverConnector`s type i=
nvariants.
> +=C2=A0=C2=A0=C2=A0 let connector =3D unsafe { Connector::<T>::from_raw(c=
onnector) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This FFI callback is only called while
> `mode_config.lock` is held
> +=C2=A0=C2=A0=C2=A0 // We use ManuallyDrop here to prevent the lock from =
being
> released after the callback
> +=C2=A0=C2=A0=C2=A0 // completes, as that should be handled by DRM.
> +=C2=A0=C2=A0=C2=A0 let guard =3D ManuallyDrop::new(unsafe {
> ModeConfigGuard::new(connector.drm_dev()) });
> +
> +=C2=A0=C2=A0=C2=A0 T::get_modes(connector.guard(&guard), &guard)
> +}
> +
> +/// A [`struct drm_connector`] without a known [`DriverConnector`]
> implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverConnector`]
> +/// implementation for a [`struct drm_connector`] automatically. It
> is identical to [`Connector`],
> +/// except that it does not provide access to the driver's private
> data.
> +///
> +/// # Invariants
> +///
> +/// - `connector` is initialized for as long as this object is
> exposed to users.
> +/// - The data layout of this type is equivalent to [`struct
> drm_connector`].
> +///
> +/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
> +#[repr(transparent)]
> +pub struct OpaqueConnector<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 connector: Opaque<bindings::drm_connector>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaqueConnector<T> {}
> +
> +// SAFETY:
> +// - Via our type variants our data layout starts is identical to
> `drm_connector`
> +// - Since we don't expose `OpaqueConnector` to users before it has
> been initialized, this and our
> +//=C2=A0=C2=A0 data layout ensure that `as_raw()` always returns a valid
> pointer to a `drm_connector`.
> +unsafe impl<T: KmsDriver> AsRawConnector for OpaqueConnector<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.connector.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connec=
tor) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_connector`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: KmsDriver> ModesettableConnector for
> OpaqueConnector<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D OpaqueConnectorState<T>;
> +}
> +
> +// SAFETY: We don't expose OpaqueConnector<T> to users before `base`
> is initialized in
> +// Connector::new(), so `raw_mode_obj` always returns a valid
> pointer to a bindings::drm_mode_object.
> +unsafe impl<T: KmsDriver> ModeObject for OpaqueConnector<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The parent device =
for a DRM connector will never
> outlive the connector, and this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // pointer is invariant throu=
gh the lifetime of the
> connector
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose DR=
M connectors to users before
> `base` is initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &mut (*self.as_raw()=
).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +super::impl_aref_for_mode_object! {
> +=C2=A0=C2=A0=C2=A0 impl<T: KmsDriver> for OpaqueConnector<T>
> +}
> +
> +// SAFETY: `funcs` is initialized by DRM when the connector is
> allocated
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueConnector<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_connector_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `funcs` is initial=
ized by DRM when the connector
> is allocated
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Our connector interfaces are guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaqueConnector<T> {}
> +unsafe impl<T: KmsDriver> Sync for OpaqueConnector<T> {}
> +
> +/// A privileged [`Connector`] obtained while holding a
> [`ModeConfigGuard`].
> +///
> +/// This provides access to various methods for [`Connector`] that
> must happen under lock, such as
> +/// setting resolution preferences and adding display modes.
> +///
> +/// # Invariants
> +///
> +/// Shares the invariants of [`ModeConfigGuard`].
> +#[derive(Copy, Clone)]
> +pub struct ConnectorGuard<'a, T: DriverConnector>(&'a Connector<T>);
> +
> +impl<T: DriverConnector> Deref for ConnectorGuard<'_, T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D Connector<T>;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverConnector> ConnectorGuard<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Add modes for a [`ConnectorGuard`] without an EDI=
D.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Add the specified modes to the connector's mode l=
ist up to
> the given maximum resultion.
> +=C2=A0=C2=A0=C2=A0 /// Returns how many modes were added.
> +=C2=A0=C2=A0=C2=A0 pub fn add_modes_noedid(&self, (max_h, max_v): (u32, =
u32)) ->
> i32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We hold the locks =
required to call this via our
> type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_add_mo=
des_noedid(self.as_raw(),
> max_h, max_v) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Set the preferred display mode for the underlying
> [`Connector`].
> +=C2=A0=C2=A0=C2=A0 pub fn set_preferred_mode(&self, (h_pref, w_pref): (u=
32, u32)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We hold the locks =
required to call this via our
> type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_set_pr=
eferred_mode(self.as_raw(),
> h_pref, w_pref) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A trait implemented by any type which can produce a reference to
> a
> +/// [`struct drm_connector_state`].
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +pub trait AsRawConnectorState: private::AsRawConnectorState {
> +=C2=A0=C2=A0=C2=A0 /// The type that represents this connector state's D=
RM
> connector.
> +=C2=A0=C2=A0=C2=A0 type Connector: AsRawConnector;
> +}
> +
> +pub(super) mod private {
> +=C2=A0=C2=A0=C2=A0 use super::*;
> +
> +=C2=A0=C2=A0=C2=A0 /// Trait for retrieving references to the base conne=
ctor state
> contained within any connector
> +=C2=A0=C2=A0=C2=A0 /// state compatible type
> +=C2=A0=C2=A0=C2=A0 #[allow(unreachable_pub)]
> +=C2=A0=C2=A0=C2=A0 pub trait AsRawConnectorState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Return an immutable refer=
ence to the raw connector
> state.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings=
::drm_connector_state;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Get a mutable reference t=
o the raw [`struct
> drm_connector_state`] contained within this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// type.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// The caller promises this =
mutable reference will not be
> used to modify any contents of
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// [`struct drm_connector_st=
ate`] which DRM would consider
> to be static - like the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// backpointer to the DRM co=
nnector that owns this state.
> This also means the mutable
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// reference should never be=
 exposed outside of this crate.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// [`struct drm_connector_st=
ate`]:
> srctree/include/drm/drm_connector.h
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut sel=
f) -> &mut
> bindings::drm_connector_state;
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +pub(super) use private::AsRawConnectorState as
> AsRawConnectorStatePrivate;
> +
> +/// A trait implemented for any type which can be constructed
> directly from a
> +/// [`struct drm_connector_state`] pointer.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +pub trait FromRawConnectorState: AsRawConnectorState {
> +=C2=A0=C2=A0=C2=A0 /// Get an immutable reference to this type from the =
given raw
> [`struct drm_connector_state`]
> +=C2=A0=C2=A0=C2=A0 /// pointer.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees `ptr` is contained within=
 a valid
> instance of `Self`.
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` cannot not be =
modified
> for the lifetime of `'a`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const
> bindings::drm_connector_state) -> &'a Self;
> +
> +=C2=A0=C2=A0=C2=A0 /// Get a mutable reference to this type from the giv=
en raw
> [`struct drm_connector_state`]
> +=C2=A0=C2=A0=C2=A0 /// pointer.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` is contained w=
ithin a
> valid instance of `Self`.
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` cannot have an=
y other
> references taken out for the
> +=C2=A0=C2=A0=C2=A0 ///=C2=A0=C2=A0 lifetime of `'a`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut
> bindings::drm_connector_state) -> &'a mut Self;
> +}
> +
> +/// Common methods available on any type which implements
> [`AsRawConnectorState`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// the atomic state of [`Connector`]s.
> +pub trait RawConnectorState: AsRawConnectorState {
> +=C2=A0=C2=A0=C2=A0 /// Return the connector that this atomic state belon=
gs to.
> +=C2=A0=C2=A0=C2=A0 fn connector(&self) -> &Self::Connector {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This is guaranteed=
 safe by type invariance, and
> we're guaranteed by DRM that
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // `self.state.connector` poi=
nts to a valid instance of a
> `Connector<T>`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> Self::Connector::from_raw((*self.as_raw()).connector) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawConnectorState> RawConnectorState for T {}
> +
> +/// The main interface for a [`struct drm_connector_state`].
> +///
> +/// This type is the main interface for dealing with the atomic
> state of DRM connectors. In
> +/// addition, it allows access to whatever private data is contained
> within an implementor's
> +/// [`DriverConnectorState`] type.
> +///
> +/// # Invariants
> +///
> +/// - The DRM C API and our interface guarantees that only the user
> has mutable access to `state`,
> +///=C2=A0=C2=A0 up until [`drm_atomic_helper_commit_hw_done`] is called.
> Therefore, `connector` follows rust's
> +///=C2=A0=C2=A0 data aliasing rules and does not need to be behind an
> [`Opaque`] type.
> +/// - `state` and `inner` initialized for as long as this object is
> exposed to users.
> +/// - The data layout of this structure begins with [`struct
> drm_connector_state`].
> +/// - The connector for this atomic state can always be assumed to
> be of type
> +///=C2=A0=C2=A0 [`Connector<T::Connector>`].
> +///
> +/// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +#[derive(Default)]
> +#[repr(C)]
> +pub struct ConnectorState<T: DriverConnectorState> {
> +=C2=A0=C2=A0=C2=A0 state: bindings::drm_connector_state,
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +}
> +
> +/// The main trait for implementing the [`struct
> drm_connector_state`] API for a [`Connector`].
> +///
> +/// A driver may store driver-private data within the implementor's
> type, which will be available
> +/// when using a full typed [`ConnectorState`] object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_connector`] pointers are contained within a
> [`Connector<Self::Connector>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_connector_state`] pointers are contained wi=
thin a
> [`ConnectorState<Self>`].
> +///
> +/// [`struct drm_connector`]: srctree/include/drm_connector.h
> +/// [`struct drm_connector_state`]: srctree/include/drm_connector.h
> +pub trait DriverConnectorState: Clone + Default + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The parent [`DriverConnector`].
> +=C2=A0=C2=A0=C2=A0 type Connector: DriverConnector;
> +}
> +
> +impl<T: DriverConnectorState> Sealed for ConnectorState<T> {}
> +
> +impl<T: DriverConnectorState> AsRawConnectorState for
> ConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 type Connector =3D Connector<T::Connector>;
> +}
> +
> +impl<T: DriverConnectorState> private::AsRawConnectorState for
> ConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverConnectorState> FromRawConnectorState for
> ConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const
> bindings::drm_connector_state) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout starts wit=
h
> `bindings::drm_connector_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *const Self =3D ptr.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires that `ptr` be contained
> within `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires the caller ensure that it
> is safe for us to take an
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 immutable refe=
rence.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut
> bindings::drm_connector_state) -> &'a mut Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout starts wit=
h
> `bindings::drm_connector_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *mut Self =3D ptr.ca=
st();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires that `ptr` be contained
> within `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires the caller ensure it is
> safe for us to take a mutable
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 reference.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &mut *ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: `funcs` is initialized by DRM when the connector is
> allocated
> +unsafe impl<T: DriverConnectorState> ModeObjectVtable for
> ConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_connector_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.connector().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverConnectorState> ConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D, C>(&'a OpaqueConne=
ctorState<D>) -> &'a Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverConnectorState<Connector =3D C>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C as =
DriverConnector,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Connector =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`struct drm_connector_state`] without a known
> [`DriverConnectorState`] implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverConnectorState`]
> +/// implementation for a [`struct drm_connector_state`]
> automatically. It is identical to
> +/// [`Connector`], except that it does not provide access to the
> driver's private data.
> +///
> +/// # Invariants
> +///
> +/// - `state` is initialized for as long as this object is exposed
> to users.
> +/// - The data layout of this type is identical to [`struct
> drm_connector_state`].
> +/// - The DRM C API and our interface guarantees that only the user
> has mutable access to `state`,
> +///=C2=A0=C2=A0 up until [`drm_atomic_helper_commit_hw_done`] is called.
> Therefore, `connector` follows rust's
> +///=C2=A0=C2=A0 data aliasing rules and does not need to be behind an
> [`Opaque`] type.
> +///
> +/// [`struct drm_connector_state`]:
> srctree/include/drm/drm_connector.h
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +#[repr(transparent)]
> +pub struct OpaqueConnectorState<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 state: bindings::drm_connector_state,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> AsRawConnectorState for OpaqueConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 type Connector =3D OpaqueConnector<T>;
> +}
> +
> +impl<T: KmsDriver> private::AsRawConnectorState for
> OpaqueConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> FromRawConnectorState for OpaqueConnectorState<T>
> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const
> bindings::drm_connector_state) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_connector_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut
> bindings::drm_connector_state) -> &'a mut Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_connector_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &mut *ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: See OpaqueConnector's ModeObjectVtable implementation
> +unsafe impl<T: KmsDriver> ModeObjectVtable for
> OpaqueConnectorState<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_connector_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.connector().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// An interface for mutating a [`Connector`]s atomic state.
> +///
> +/// This type is typically returned by an [`AtomicStateMutator`]
> within contexts where it is
> +/// possible to safely mutate a connector's state. In order to
> uphold rust's data-aliasing rules,
> +/// only [`ConnectorStateMutator`] may exist at a time.
> +pub struct ConnectorStateMutator<'a, T: FromRawConnectorState> {
> +=C2=A0=C2=A0=C2=A0 state: &'a mut T,
> +=C2=A0=C2=A0=C2=A0 mask: &'a Cell<u32>,
> +}
> +
> +impl<'a, T: FromRawConnectorState> ConnectorStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 pub(super) fn new<D: KmsDriver>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutator: &'a AtomicStateMutat=
or<D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state: NonNull<bindings::drm_=
connector_state>,
> +=C2=A0=C2=A0=C2=A0 ) -> Option<Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `connector` is invariant=
 throughout the lifetime of the
> atomic state.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `state` is initialized b=
y the time it is passed to this
> function.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed that `s=
tate` is compatible with
> `drm_connector` by type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let connector =3D unsafe {
> T::Connector::from_raw((*state.as_ptr()).connector) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let conn_mask =3D connector.m=
ask();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let borrowed_mask =3D mutator=
.borrowed_connectors.get();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if borrowed_mask & conn_mask =
=3D=3D 0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutat=
or.borrowed_connectors.set(borrowed_mask |
> conn_mask);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some(=
Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mask: &mutator.borrowed_connectors,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed `state` is of `T` by
> type invariance, and we just
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // confirmed by checking `borrowed_connectors` that
> no other mutable borrows have
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // been taken out for `state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state: unsafe { T::from_raw_mut(state.as_ptr()) },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverConnectorState> Deref for
> ConnectorStateMutator<'a, ConnectorState<T>> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverConnectorState> DerefMut for
> ConnectorStateMutator<'a, ConnectorState<T>> {
> +=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawConnectorState> Drop for
> ConnectorStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mask =3D self.state.conne=
ctor().mask();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.mask.set(self.mask.get()=
 & !mask);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawConnectorState> AsRawConnectorState for
> ConnectorStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 type Connector =3D T::Connector;
> +}
> +
> +impl<'a, T: FromRawConnectorState> private::AsRawConnectorState for
> ConnectorStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're bound by the=
 same safety contract as this
> function
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { self.state.as_raw_mu=
t() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: we inherit the safety guarantees of `T`
> +unsafe impl<'a, T> ModeObjectVtable for ConnectorStateMutator<'a, T>
> +where
> +=C2=A0=C2=A0=C2=A0 T: FromRawConnectorState + ModeObjectVtable,
> +{
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D T::Vtable;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverConnectorState> ConnectorStateMutator<'a,
> ConnectorState<T>> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <D, C>(ConnectorStateMutat=
or<'a,
> OpaqueConnectorState<D>>) -> Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverConnectorState<Connector =3D C>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C as =
DriverConnector,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Connector =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +unsafe extern "C" fn atomic_duplicate_state_callback<T:
> DriverConnectorState>(
> +=C2=A0=C2=A0=C2=A0 connector: *mut bindings::drm_connector,
> +) -> *mut bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `connector` points to =
a valid
> initialized `drm_connector`.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*connector).state };
> +=C2=A0=C2=A0=C2=A0 if state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return null_mut();
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We just verified that `state` is non-null
> +=C2=A0=C2=A0=C2=A0 // - This cast is guaranteed to be safe via our type =
invariants.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { ConnectorState::<T>::from_raw(=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 let new: Result<KBox<_>> =3D KBox::init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init!(ConnectorState::<T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inner=
: state.inner.clone(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
: bindings::drm_connector_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL,
> +=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0 if let Ok(mut new) =3D new {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `new` provides a valid p=
ointer to a newly allocated
> `drm_plane_state` via type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This initializes `new` v=
ia memcpy()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> bindings::__drm_atomic_helper_connector_duplicate_state(connector,
> new.as_raw_mut())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBox::into_raw(new).cast()
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null_mut()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +unsafe extern "C" fn atomic_destroy_state_callback<T:
> DriverConnectorState>(
> +=C2=A0=C2=A0=C2=A0 _connector: *mut bindings::drm_connector,
> +=C2=A0=C2=A0=C2=A0 connector_state: *mut bindings::drm_connector_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_connector_state`
> +=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_connector_destroy_state(connector_state
> ) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees we are the only one with access t=
o this
> `drm_connector_state`
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via our type invariants.
> +=C2=A0=C2=A0=C2=A0 drop(unsafe {
> KBox::from_raw(connector_state.cast::<ConnectorState<T>>()) });
> +}
> +
> +unsafe extern "C" fn connector_reset_callback<T:
> DriverConnectorState>(
> +=C2=A0=C2=A0=C2=A0 connector: *mut bindings::drm_connector,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_connector_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*connector).state };
> +=C2=A0=C2=A0=C2=A0 if !state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `connec=
tor` is `Connector<T>` via type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `state`=
 is `ConnectorState<T>` via
> type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { atomic_destroy_state=
_callback::<T>(connector,
> state) }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: No special require=
ments here, DRM expects this to
> be NULL
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*connector).state =
=3D null_mut() };
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // Unfortunately, this is the best we can do at the m=
oment as
> this FFI callback was mistakenly
> +=C2=A0=C2=A0=C2=A0 // presumed to be infallible :(
> +=C2=A0=C2=A0=C2=A0 let new =3D KBox::new(ConnectorState::<T>::default(),
> GFP_KERNEL).expect("Blame the API, sorry!");
> +
> +=C2=A0=C2=A0=C2=A0 // DRM takes ownership of the state from here, resets=
 it, and
> then assigns it to the connector
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees that `connector` points to a vali=
d instance
> of `drm_connector`.
> +=C2=A0=C2=A0=C2=A0 // - The cast to `drm_connector_state` is safe via
> `ConnectorState`s type invariants.
> +=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_connector_reset(connector,
> Box::into_raw(new).cast()) };
> +}
> diff --git a/rust/kernel/drm/kms/crtc.rs
> b/rust/kernel/drm/kms/crtc.rs
> new file mode 100644
> index 000000000000..b9d095854ba6
> --- /dev/null
> +++ b/rust/kernel/drm/kms/crtc.rs
> @@ -0,0 +1,1110 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM CRTCs.
> +//!
> +//! C header:
> [`include/drm/drm_crtc.h`](srctree/include/drm/drm_crtc.h)
> +
> +use super::{
> +=C2=A0=C2=A0=C2=A0 atomic::*, plane::*, vblank::*, KmsDriver, ModeObject=
,
> ModeObjectVtable, StaticModeObject,
> +=C2=A0=C2=A0=C2=A0 NewKmsDevice, Probing, Sealed,
> +};
> +use crate::{
> +=C2=A0=C2=A0=C2=A0 alloc::KBox,
> +=C2=A0=C2=A0=C2=A0 bindings,
> +=C2=A0=C2=A0=C2=A0 drm::device::Device,
> +=C2=A0=C2=A0=C2=A0 error::{from_result, to_result},
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 types::{NotThreadSafe, Opaque},
> +};
> +use core::{
> +=C2=A0=C2=A0=C2=A0 cell::{Cell, UnsafeCell},
> +=C2=A0=C2=A0=C2=A0 marker::*,
> +=C2=A0=C2=A0=C2=A0 mem::{self, ManuallyDrop},
> +=C2=A0=C2=A0=C2=A0 ops::{Deref, DerefMut},
> +=C2=A0=C2=A0=C2=A0 ptr::{null, null_mut, NonNull},
> +};
> +use macros::vtable;
> +
> +/// The main trait for implementing the [`struct drm_crtc`] API for
> [`Crtc`].
> +///
> +/// Any KMS driver should have at least one implementation of this
> type, which allows them to create
> +/// [`Crtc`] objects. Additionally, a driver may store driver-
> private data within the type that
> +/// implements [`DriverCrtc`] - and it will be made available when
> using a fully typed [`Crtc`]
> +/// object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_crtc`] pointers are contained within a
> [`Crtc<Self>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_crtc_state`] pointers are contained within =
a
> [`CrtcState<Self::State>`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +#[vtable]
> +pub trait DriverCrtc: Send + Sync + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The generated C vtable for this [`DriverCrtc`]
> implementation.
> +=C2=A0=C2=A0=C2=A0 const OPS: &'static DriverCrtcOps =3D &DriverCrtcOps =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_crtc_fun=
cs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_destroy_state:
> Some(atomic_destroy_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_duplicate_state:
> Some(atomic_duplicate_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_get_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_print_state: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_set_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curso=
r_move: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curso=
r_set2: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curso=
r_set: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destr=
oy: Some(crtc_destroy_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disab=
le_vblank: <Self::VblankImpl as
> VblankImpl>::VBLANK_OPS.disable_vblank,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early=
_unregister: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabl=
e_vblank: <Self::VblankImpl as
> VblankImpl>::VBLANK_OPS.enable_vblank,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gamma=
_set: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_c=
rc_sources: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_v=
blank_counter: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_v=
blank_timestamp: <Self::VblankImpl as
> VblankImpl>::VBLANK_OPS.get_vblank_timestamp,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 late_=
register: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_=
flip: Some(bindings::drm_atomic_helper_page_flip),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_=
flip_target: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset=
: Some(crtc_reset_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_c=
onfig:
> Some(bindings::drm_atomic_helper_set_config),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_c=
rc_source: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_p=
roperty: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verif=
y_crc_source: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_c=
rtc_helper_funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_disable: if Self::HAS_ATOMIC_DISABLE {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_disable_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_enable: if Self::HAS_ATOMIC_ENABLE {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_enable_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_check: if Self::HAS_ATOMIC_CHECK {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_check_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpms:=
 None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commi=
t: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepa=
re: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disab=
le: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
set: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
valid: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
fixup: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_begin: if Self::HAS_ATOMIC_BEGIN {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_begin_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_flush: if Self::HAS_ATOMIC_FLUSH {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_flush_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
set_nofb: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
set_base: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
set_base_atomic: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_s=
canout_position: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 /// The type to pass to the `args` field of
> [`UnregisteredCrtc::new`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This type will be made available in in the `args`=
 argument
> of [`Self::new`]. Drivers which
> +=C2=A0=C2=A0=C2=A0 /// don't need this can simply pass [`()`] here.
> +=C2=A0=C2=A0=C2=A0 type Args;
> +
> +=C2=A0=C2=A0=C2=A0 /// The parent [`KmsDriver`] implementation.
> +=C2=A0=C2=A0=C2=A0 type Driver: KmsDriver;
> +
> +=C2=A0=C2=A0=C2=A0 /// The [`DriverCrtcState`] implementation for this
> [`DriverCrtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// See [`DriverCrtcState`] for more info.
> +=C2=A0=C2=A0=C2=A0 type State: DriverCrtcState;
> +
> +=C2=A0=C2=A0=C2=A0 /// The driver's optional hardware vblank implementat=
ion
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// See [`VblankSupport`] for more info. Drivers that=
 don't care
> about this can just pass
> +=C2=A0=C2=A0=C2=A0 /// [`PhantomData<Self>`].
> +=C2=A0=C2=A0=C2=A0 type VblankImpl: VblankImpl<Crtc =3D Self>;
> +
> +=C2=A0=C2=A0=C2=A0 /// The constructor for creating a [`Crtc`] using thi=
s
> [`DriverCrtc`] implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to instantiate their [`Drive=
rCrtc`]
> object.
> +=C2=A0=C2=A0=C2=A0 fn new(device: &Device<Self::Driver>, args: &Self::Ar=
gs) -> impl
> PinInit<Self, Error>;
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_crtc_helper_funcs.atomic_check=
`] hook for
> this crtc.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to customize the atomic chec=
k phase of
> their [`Crtc`] objects. The
> +=C2=A0=C2=A0=C2=A0 /// result of this function determines whether the at=
omic check
> passed or failed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_crtc_helper_funcs.atomic_check`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_check(_check: CrtcAtomicCheck<'_, Self>) ->=
 Result {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should not be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_crtc_helper_funcs.atomic_begin=
`] hook.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This hook will be called before a set of [`Plane`=
] updates
> are performed for the given
> +=C2=A0=C2=A0=C2=A0 /// [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_crtc_helper_funcs.atomic_begin`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_begin(_commit: CrtcAtomicCommit<'_, Self>) =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should not be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_crtc_helper_funcs.atomic_flush=
`] hook.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This hook will be called after a set of [`Plane`]=
 updates
> are performed for the given
> +=C2=A0=C2=A0=C2=A0 /// [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_crtc_helper_funcs.atomic_flush`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_flush(_commit: CrtcAtomicCommit<'_, Self>) =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should never be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_crtc_helper_funcs.atomic_enabl=
e`] hook.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This hook will be called before enabling a [`Crtc=
`] in an
> atomic commit.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_crtc_helper_funcs.atomic_enable`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_enable(_commit: CrtcAtomicCommit<'_, Self>)=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should never be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_crtc_helper_funcs.atomic_disab=
le`] hook.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This hook will be called before disabling a [`Crt=
c`] in an
> atomic commit.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_crtc_helper_funcs.atomic_disable`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_disable(_commit: CrtcAtomicCommit<'_, Self>=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should never be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// The generated C vtable for a [`DriverCrtc`].
> +///
> +/// This type is created internally by DRM.
> +pub struct DriverCrtcOps {
> +=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_crtc_funcs,
> +=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_crtc_helper_funcs,
> +}
> +
> +/// The main interface for a [`struct drm_crtc`].
> +///
> +/// This type is the main interface for dealing with DRM CRTCs. In
> addition, it also allows
> +/// immutable access to whatever private data is contained within an
> implementor's [`DriverCrtc`]
> +/// type.
> +///
> +/// # Invariants
> +///
> +/// - `crtc` and `inner` are initialized for as long as this object
> is made available to users.
> +/// - The data layout of this structure begins with [`struct
> drm_crtc`].
> +/// - The atomic state for this type can always be assumed to be of
> type [`CrtcState<T::State>`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +#[repr(C)]
> +#[pin_data]
> +pub struct Crtc<T: DriverCrtc> {
> +=C2=A0=C2=A0=C2=A0 // The FFI drm_crtc object
> +=C2=A0=C2=A0=C2=A0 crtc: Opaque<bindings::drm_crtc>,
> +=C2=A0=C2=A0=C2=A0 /// The driver's private inner data
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +}
> +
> +impl<T: DriverCrtc> Sealed for Crtc<T> {}
> +
> +// SAFETY: Our CRTC interfaces are guaranteed to be thread-safe
> +unsafe impl<T: DriverCrtc> Send for Crtc<T> {}
> +
> +// SAFETY: Our CRTC interfaces are guaranteed to be thread-safe
> +unsafe impl<T: DriverCrtc> Sync for Crtc<T> {}
> +
> +impl<T: DriverCrtc> Deref for Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We don't expose Crtc<T> to users before `base` is
> initialized in ::new(), so
> +// `raw_mode_obj` always returns a valid pointer to a
> bindings::drm_mode_object.
> +unsafe impl<T: DriverCrtc> ModeObject for Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T::Driver;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM connectors exi=
st for as long as the device
> does, so this pointer is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose Cr=
tc<T> to users before it's
> initialized, so `base` is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.as_r=
aw()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: CRTCs are non-refcounted modesetting objects
> +unsafe impl<T: DriverCrtc> StaticModeObject for Crtc<T> {}
> +
> +// SAFETY: `funcs` is initialized when the crtc is allocated
> +unsafe impl<T: DriverCrtc> ModeObjectVtable for Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_crtc_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to a
> CRTC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtc> Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D>(&'a OpaqueCrtc<D>)=
 -> &'a Self;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T as =
DriverCrtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Crtc =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn get_vblank_ptr(&self) -> *mut
> bindings::drm_vblank_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: FFI Call with no s=
pecial requirements
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_v=
blank_crtc(self.as_raw()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 pub(crate) const fn has_vblank() -> bool {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::OPS.funcs.enable_vblank.is=
_some()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`Crtc`] that has not yet been registered with userspace.
> +///
> +/// KMS registration is single-threaded, so this object is not
> thread-safe.
> +///
> +/// # Invariants
> +///
> +/// - This object can only exist before its respective KMS device
> has been registered.
> +/// - Otherwise, it inherits all invariants of [`Crtc`] and has an
> identical data layout.
> +pub struct UnregisteredCrtc<T: DriverCrtc>(Crtc<T>, NotThreadSafe);
> +
> +impl<T: DriverCrtc> UnregisteredCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`UnregisteredCrtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A driver may use this from their
> [`KmsDriver::create_objects`] callback in order to
> +=C2=A0=C2=A0=C2=A0 /// construct new [`UnregisteredCrtc`] objects.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`KmsDriver::create_objects`]:
> kernel::drm::kms::KmsDriver::create_objects
> +=C2=A0=C2=A0=C2=A0 pub fn new<'a, 'b: 'a, PrimaryData, CursorData>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a NewKmsDevice<'a, T::=
Driver, Probing>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 primary: &'a UnregisteredPlan=
e<PrimaryData>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor: Option<&'a Unregister=
edPlane<CursorData>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Option<&CStr>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args: T::Args,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<&'a Self>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PrimaryData: DriverPlane<Driv=
er =3D T::Driver>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CursorData: DriverPlane<Drive=
r =3D T::Driver>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if Crtc::<T>::has_vblank() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev.h=
as_vblanks.set(true)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: Pin<KBox<Crtc<T>>> =
=3D KBox::try_pin_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_p=
in_init!(Crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 crtc: Opaque::new(bindings::drm_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_private: &T::OPS.helper_f=
uncs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inner <- T::new(dev, &args),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_K=
ERNEL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `dev` handles destroying=
 the CRTC and thus will outlive
> us.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We just allocated `this`=
, and we won't move it since
> it's pinned
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `primary` and `cursor` s=
hare the lifetime 'a with `dev`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This function will memcp=
y the contents of `name` into
> its own storage.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_crtc_init_with_planes(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 this.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 primary.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cursor.map_or(null_mut(), |c| c.as_raw()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &T::OPS.funcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name.map_or(null(), |n| n.as_char_ptr()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't move anyt=
hing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { Pin::in=
to_inner_unchecked(this) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We'll re-assemble the box =
in crtc_destroy_callback()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D KBox::into_raw(t=
his);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // UnregisteredCrtc has an eq=
uivalent data layout
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: *mut Self =3D this.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just allocated =
the crtc above, so this pointer
> must be valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { &*this })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We inherit all relevant invariants of `Crtc`
> +unsafe impl<T: DriverCrtc> AsRawCrtc for UnregisteredCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) =
-> &'a Self
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This is another fr=
om_raw() call, so this function
> shares the same safety contract
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<=
T>::from_raw(ptr) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical via our type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { mem::transmute(crtc)=
 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtc> Deref for UnregisteredCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A trait implemented by any type that acts as a [`struct
> drm_crtc`] interface.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// [`as_raw()`] must always return a valid pointer to a [`struct
> drm_crtc`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +/// [`as_raw()`]: AsRawCrtc::as_raw()
> +pub unsafe trait AsRawCrtc {
> +=C2=A0=C2=A0=C2=A0 /// Return a raw pointer to the `bindings::drm_crtc` =
for this
> object
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc;
> +
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw [`struct drm_crtc`] pointer into an=
 object of
> this type.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Callers promise that `ptr` points to a valid inst=
ance of
> this type
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_crtc`]: srctree/include/drm/drm_crtc=
.h
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) =
-> &'a
> Self;
> +}
> +
> +// SAFETY:
> +// - Via our type variants our data layout starts with `drm_crtc`
> +// - Since we don't expose `crtc` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_crtc`.
> +unsafe impl<T: DriverCrtc> AsRawCrtc for Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.crtc.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) =
-> &'a Self
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout start with=
 `bindings::drm_crtc`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *mut Self =3D ptr.ca=
st();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our safety contrac=
t requires that `ptr` point to
> a valid intance of `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: DriverCrtc> ModesettableCrtc for Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D CrtcState<T::State>;
> +}
> +
> +/// A supertrait of [`AsRawCrtc`] for [`struct drm_crtc`] interfaces
> that can perform modesets.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// Any object implementing this trait must only be made directly
> available to the user after
> +/// [`create_objects`] has completed.
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +/// [`create_objects`]: KmsDriver::create_objects
> +pub unsafe trait ModesettableCrtc: AsRawCrtc {
> +=C2=A0=C2=A0=C2=A0 /// The type that should be returned for a CRTC state=
 acquired
> using this CRTC interface
> +=C2=A0=C2=A0=C2=A0 type State: FromRawCrtcState;
> +}
> +
> +/// Common methods available on any type which implements
> [`AsRawCrtc`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// CRTCs.
> +pub trait RawCrtc: AsRawCrtc {
> +=C2=A0=C2=A0=C2=A0 /// Return the index of this CRTC.
> +=C2=A0=C2=A0=C2=A0 fn index(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The index is initi=
alized by the time we expose
> Crtc objects to users, and is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // invariant throughout the l=
ifetime of the Crtc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).ind=
ex }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the index of this DRM CRTC in the form of =
a bitmask.
> +=C2=A0=C2=A0=C2=A0 fn mask(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 << self.index()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawCrtc> RawCrtc for T {}
> +
> +/// A [`struct drm_crtc`] without a known [`DriverCrtc`]
> implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverCrtc`] implementation
> +/// for a [`struct drm_crtc`] automatically. It is identical to
> [`Crtc`], except that it does not
> +/// provide access to the driver's private data.
> +///
> +/// It may be upcasted to a full [`Crtc`] using
> [`Crtc::from_opaque`] or
> +/// [`Crtc::try_from_opaque`].
> +///
> +/// # Invariants
> +///
> +/// - `crtc` is initialized for as long as this object is made
> available to users.
> +/// - The data layout of this structure is equivalent to [`struct
> drm_crtc`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +#[repr(transparent)]
> +pub struct OpaqueCrtc<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 crtc: Opaque<bindings::drm_crtc>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaqueCrtc<T> {}
> +
> +// SAFETY:
> +// - Via our type variants our data layout is identical to
> `drm_crtc`
> +// - Since we don't expose `OpaqueCrtc` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_crtc`.
> +unsafe impl<T: KmsDriver> AsRawCrtc for OpaqueCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.crtc.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) =
-> &'a Self
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout st=
arts with `bindings::drm_crtc`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: KmsDriver> ModesettableCrtc for OpaqueCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D OpaqueCrtcState<T>;
> +}
> +
> +// SAFETY: We don't expose OpaqueCrtc<T> to users before `base` is
> initialized in Crtc::<T>::new(),
> +// so `raw_mode_obj` always returns a valid pointer to a
> bindings::drm_mode_object.
> +unsafe impl<T: KmsDriver> ModeObject for OpaqueCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The parent device =
for a DRM connector will never
> outlive the connector, and this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // pointer is invariant throu=
gh the lifetime of the
> connector
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose DR=
M connectors to users before
> `base` is initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.as_r=
aw()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: CRTCs are non-refcounted modesetting objects
> +unsafe impl<T: KmsDriver> StaticModeObject for OpaqueCrtc<T> {}
> +
> +// SAFETY: Our CRTC interface is guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaqueCrtc<T> {}
> +
> +// SAFETY: Our CRTC interface is guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Sync for OpaqueCrtc<T> {}
> +
> +// SAFETY: `funcs` is initialized when the CRTC is allocated
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_crtc_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to a
> crtc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).fun=
cs }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtcState> Sealed for CrtcState<T> {}
> +
> +/// The main trait for implementing the [`struct drm_crtc_state`]
> API for a [`Crtc`].
> +///
> +/// A driver may store driver-private data within the implementor's
> type, which will be available
> +/// when using a full typed [`CrtcState`] object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_crtc`] pointers are contained within a
> [`Crtc<Self::Crtc>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_crtc_state`] pointers are contained within =
a
> [`CrtcState<Self>`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm_crtc.h
> +/// [`struct drm_crtc_state`]: srctree/include/drm_crtc.h
> +pub trait DriverCrtcState: Clone + Default + Unpin {
> +=C2=A0=C2=A0=C2=A0 /// The parent CRTC driver for this CRTC state
> +=C2=A0=C2=A0=C2=A0 type Crtc: DriverCrtc<State =3D Self>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: Sized;
> +}
> +
> +/// The main interface for a [`struct drm_crtc_state`].
> +///
> +/// This type is the main interface for dealing with the atomic
> state of DRM crtcs. In addition, it
> +/// allows access to whatever private data is contained within an
> implementor's [`DriverCrtcState`]
> +/// type.
> +///
> +/// # Invariants
> +///
> +/// - `state` and `inner` initialized for as long as this object is
> exposed to users.
> +/// - The data layout of this structure begins with [`struct
> drm_crtc_state`].
> +/// - The CRTC for this type can always be assumed to be of type
> [`Crtc<T::Crtc>`].
> +///
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +#[repr(C)]
> +pub struct CrtcState<T: DriverCrtcState> {
> +=C2=A0=C2=A0=C2=A0 // It should be noted that CrtcState is a bit of an o=
ddball -
> it's the only atomic state
> +=C2=A0=C2=A0=C2=A0 // structure that can be modified after it has been s=
wapped in,
> which is why we need to have
> +=C2=A0=C2=A0=C2=A0 // `state` within an `Opaque<>`=E2=80=A6
> +=C2=A0=C2=A0=C2=A0 state: Opaque<bindings::drm_crtc_state>,
> +
> +=C2=A0=C2=A0=C2=A0 // =E2=80=A6it is also one of the few atomic states t=
hat some drivers
> will embed work structures into,
> +=C2=A0=C2=A0=C2=A0 // which means there's a good chance in the future we=
 may have
> pinned data here - making it
> +=C2=A0=C2=A0=C2=A0 // impossible for us to hold a mutable or immutable r=
eference to
> the CrtcState. In preparation
> +=C2=A0=C2=A0=C2=A0 // for that possibility, we keep `T` in an UnsafeCell=
.
> +=C2=A0=C2=A0=C2=A0 inner: UnsafeCell<T>,
> +}
> +
> +impl<T: DriverCrtcState> Deref for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our interface ensu=
res that `inner` will not be
> modified unless only a single
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // mutable reference exists t=
o `inner`, so this is safe
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*self.inner.get() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtcState> DerefMut for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.inner.get_mut()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantee of Crtc<T>'s ModeObjectVtable
> impl
> +unsafe impl<T: DriverCrtcState> ModeObjectVtable for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_crtc_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.crtc().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtcState> CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D, C>(&'a OpaqueCrtcS=
tate<D>) -> &'a Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverCrtcState<Crtc =3D C>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C as =
DriverCrtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Crtc =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A trait implemented by any type which can produce a reference to
> a [`struct drm_crtc_state`].
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +pub trait AsRawCrtcState: private::AsRawCrtcState {
> +=C2=A0=C2=A0=C2=A0 /// The type that this CRTC state interface returns t=
o represent
> the parent CRTC
> +=C2=A0=C2=A0=C2=A0 type Crtc: ModesettableCrtc;
> +}
> +
> +pub(crate) mod private {
> +=C2=A0=C2=A0=C2=A0 use super::*;
> +
> +=C2=A0=C2=A0=C2=A0 #[allow(unreachable_pub)]
> +=C2=A0=C2=A0=C2=A0 pub trait AsRawCrtcState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Return a raw pointer to t=
he DRM CRTC state
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Note that CRTC states are=
 the only atomic state in KMS
> which don't nicely follow rust's
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// data aliasing rules alrea=
dy.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bind=
ings::drm_crtc_state;
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +pub(super) use private::AsRawCrtcState as AsRawCrtcStatePrivate;
> +
> +/// Common methods available on any type which implements
> [`AsRawCrtcState`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// the atomic state of [`Crtc`]s.
> +pub trait RawCrtcState: AsRawCrtcState {
> +=C2=A0=C2=A0=C2=A0 /// Return the CRTC that owns this state.
> +=C2=A0=C2=A0=C2=A0 fn crtc(&self) -> &Self::Crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This type conversion is =
guaranteed by type invariance
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our interface ensures th=
at this access follows rust's
> data-aliasing rules
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `crtc` is guaranteed to =
never be NULL and is invariant
> throughout the lifetime of the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { <Self::Crtc as
> AsRawCrtc>::from_raw((*self.as_raw()).crtc) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Returns whether or not the CRTC is active in this=
 atomic
> state.
> +=C2=A0=C2=A0=C2=A0 fn active(&self) -> bool {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `active` and the r=
est of its containing bitfield
> can only be modified from the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // atomic check context, and =
are invariant beyond that point
> - so our interface can ensure
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // this access is serialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).act=
ive }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawCrtcState> RawCrtcState for T {}
> +
> +/// A trait implemented for any type which can be constructed
> directly from a
> +/// [`struct drm_crtc_state`] pointer.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +pub trait FromRawCrtcState: AsRawCrtcState {
> +=C2=A0=C2=A0=C2=A0 /// Obtain a reference back to this type from a raw D=
RM crtc
> state pointer
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Callers must ensure that ptr contains a valid ins=
tance of
> this type.
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc=
_state) ->
> &'a Self;
> +}
> +
> +impl<T: DriverCrtcState> private::AsRawCrtcState for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 type Crtc =3D Crtc<T::Crtc>;
> +}
> +
> +impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc=
_state) ->
> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout st=
arts with
> `bindings::drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*(ptr.cast()) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`struct drm_crtc_state`] without a known [`DriverCrtcState`]
> implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverCrtcState`]
> +/// implementation for a [`struct drm_crtc_state`] automatically. It
> is identical to [`Crtc`],
> +/// except that it does not provide access to the driver's private
> data.
> +///
> +/// # Invariants
> +///
> +/// - `state` is initialized for as long as this object is exposed
> to users.
> +/// - The data layout of this type is identical to [`struct
> drm_crtc_state`].
> +///
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +#[repr(transparent)]
> +pub struct OpaqueCrtcState<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 state: Opaque<bindings::drm_crtc_state>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> AsRawCrtcState for OpaqueCrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 type Crtc =3D OpaqueCrtc<T>;
> +}
> +
> +impl<T: KmsDriver> private::AsRawCrtcState for OpaqueCrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.get()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> FromRawCrtcState for OpaqueCrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc=
_state) ->
> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*(ptr.cast()) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantees of OpaqueCrtc<T>'s
> ModeObjectVtable impl
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueCrtcState<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_crtc_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.crtc().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// An interface for mutating a [`Crtc`]s atomic state.
> +///
> +/// This type is typically returned by an [`AtomicStateMutator`]
> within contexts where it is
> +/// possible to safely mutate a plane's state. In order to uphold
> rust's data-aliasing rules, only
> +/// [`CrtcStateMutator`] may exist at a time.
> +///
> +/// # Invariants
> +///
> +/// `self.state` always points to a valid instance of a
> [`FromRawCrtcState`] object.
> +pub struct CrtcStateMutator<'a, T: FromRawCrtcState> {
> +=C2=A0=C2=A0=C2=A0 state: NonNull<T>,
> +=C2=A0=C2=A0=C2=A0 mask: &'a Cell<u32>,
> +}
> +
> +impl<'a, T: FromRawCrtcState> CrtcStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 pub(super) fn new<D: KmsDriver>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutator: &'a AtomicStateMutat=
or<D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state: NonNull<bindings::drm_=
crtc_state>,
> +=C2=A0=C2=A0=C2=A0 ) -> Option<Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `crtc` is invarian=
t throughout the lifetime of
> the atomic state, and always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // points to a valid `Crtc<T:=
:Crtc>`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe {
> T::Crtc::from_raw((*state.as_ptr()).crtc) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let crtc_mask =3D crtc.mask()=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let borrowed_mask =3D mutator=
.borrowed_crtcs.get();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if borrowed_mask & crtc_mask =
=3D=3D 0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutat=
or.borrowed_crtcs.set(borrowed_mask | crtc_mask);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some(=
Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mask: &mutator.borrowed_crtcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state: state.cast(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverCrtcState> CrtcStateMutator<'a, CrtcState<T>> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <D, C>(CrtcStateMutator<'a=
, OpaqueCrtcState<D>>) -> Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverCrtcState<Crtc =3D C>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T as =
DriverCrtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Crtc =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawCrtcState> Drop for CrtcStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our interface is p=
roof that we are the only ones
> with a reference to this data
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mask =3D unsafe { self.st=
ate.as_ref() }.crtc().mask();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.mask.set(self.mask.get()=
 & !mask);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a,
> CrtcState<T>> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our interface ensu=
res that `self.state.inner`
> follows rust's data-aliasing rules,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // so this is safe
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*(*self.state.as_pt=
r()).inner.get() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a,
> CrtcState<T>> {
> +=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our interface ensu=
res that `self.state.inner`
> follows rust's data-aliasing rules,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // so this is safe
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.state.as_ptr(=
)).inner.get_mut() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawCrtcState> AsRawCrtcState for
> CrtcStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 type Crtc =3D T::Crtc;
> +}
> +
> +impl<'a, T: FromRawCrtcState> private::AsRawCrtcState for
> CrtcStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_crtc_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.as_ptr().cast()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantees of T::Crtc's
> ModeObjectVtable impl
> +unsafe impl<'a, T: FromRawCrtcState> ModeObjectVtable for
> CrtcStateMutator<'a, T>
> +where
> +=C2=A0=C2=A0=C2=A0 T::Crtc: ModeObjectVtable,
> +{
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D <T::Crtc as ModeObjectVtable>::Vtable=
;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.crtc().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A token provided during [`atomic_check`] callbacks for accessing
> the crtc, atomic state, and new
> +/// and old states of the crtc.
> +///
> +/// # Invariants
> +///
> +/// This token is proof that the old and new atomic state of `crtc`
> are present in `state` and do
> +/// not have any mutators taken out.
> +///
> +/// [`atomic_check`]: DriverCrtc::atomic_check
> +pub struct CrtcAtomicCheck<'a, T: DriverCrtc> {
> +=C2=A0=C2=A0=C2=A0 state: &'a AtomicStateComposer<T::Driver>,
> +=C2=A0=C2=A0=C2=A0 crtc: &'a Crtc<T>,
> +}
> +
> +impl<'a, T: DriverCrtc> CrtcAtomicCheck<'a, T> {
> +=C2=A0=C2=A0=C2=A0 impl_atomic_state_token_ops!(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CrtcAtomicCheck,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AtomicStateComposer,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Crtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use <'a, T>
> +=C2=A0=C2=A0=C2=A0 );
> +}
> +
> +/// A token provided to [`DriverCrtc`] callbacks during the atomic
> commit phase for accessing the
> +/// crtc, atomic state, new and old states of the crtc.
> +///
> +/// # Invariants
> +///
> +/// This token is proof that the old and new atomic state of `crtc`
> are present in `state` and do
> +/// not have any mutators taken out.
> +pub struct CrtcAtomicCommit<'a, T: DriverCrtc> {
> +=C2=A0=C2=A0=C2=A0 state: &'a AtomicStateMutator<T::Driver>,
> +=C2=A0=C2=A0=C2=A0 crtc: &'a Crtc<T>,
> +}
> +
> +impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
> +=C2=A0=C2=A0=C2=A0 impl_atomic_state_token_ops!(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CrtcAtomicCommit,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AtomicStateMutator,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Crtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use <'a, T>
> +=C2=A0=C2=A0=C2=A0 );
> +}
> +
> +unsafe extern "C" fn crtc_destroy_callback<T: DriverCrtc>(crtc: *mut
> bindings::drm_crtc) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `crtc` points to a val=
id
> initialized `drm_crtc`.
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_cleanup(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees we are now the only one with acce=
ss to this
> [`drm_crtc`].
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via `DriverCrtc`s type invaria=
nts.
> +=C2=A0=C2=A0=C2=A0 // - We created this as a pinned type originally
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { Pin::new_unchecked(KBox::from_raw(crtc =
as *mut
> Crtc<T>)) });
> +}
> +
> +unsafe extern "C" fn atomic_duplicate_state_callback<T:
> DriverCrtcState>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +) -> *mut bindings::drm_crtc_state {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `crtc` points to a val=
id
> initialized `drm_crtc`.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*crtc).state };
> +=C2=A0=C2=A0=C2=A0 if state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return null_mut();
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This cast is safe via `DriverCrtcState`s t=
ype
> invariants.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<T::Crtc>::from_raw(crtc)=
 };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This cast is safe via `DriverCrtcState`s t=
ype
> invariants.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { CrtcState::<T>::from_raw(state=
) };
> +
> +=C2=A0=C2=A0=C2=A0 let new: Result<KBox<_>> =3D KBox::try_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_init!(CrtcState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inner=
: UnsafeCell::new((*state).clone()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
: Opaque::new(Default::default()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL,
> +=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0 if let Ok(new) =3D new {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new =3D KBox::into_raw(ne=
w).cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `new` provides a valid p=
ointer to a newly allocated
> `drm_crtc_state` via type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This initializes `new` v=
ia memcpy()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_crtc_duplicate_state(crtc.as_raw(),
> new) }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null_mut()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +unsafe extern "C" fn atomic_destroy_state_callback<T:
> DriverCrtcState>(
> +=C2=A0=C2=A0=C2=A0 _crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 crtc_state: *mut bindings::drm_crtc_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_crtc_destroy_state(crtc_state) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees we are the only one with access t=
o this
> `drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via our type invariants.
> +=C2=A0=C2=A0=C2=A0 // - All data in `CrtcState` is either Unpin, or pinn=
ed
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { KBox::from_raw(crtc_state as *mut CrtcS=
tate<T>)
> });
> +}
> +
> +unsafe extern "C" fn crtc_reset_callback<T: DriverCrtcState>(crtc:
> *mut bindings::drm_crtc) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_crtc_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*crtc).state };
> +=C2=A0=C2=A0=C2=A0 if !state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `crtc` =
is `Crtc<T>` via type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `state`=
 is `CrtcState<T>` via type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { atomic_destroy_state=
_callback::<T>(crtc, state) }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: No special require=
ments here, DRM expects this to
> be NULL
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*crt=
c).state =3D null_mut();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: `crtc` is guaranteed to be of type `Crtc<T=
::Crtc>` by
> type invariance
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<T::Crtc>::from_raw(crtc)=
 };
> +
> +=C2=A0=C2=A0=C2=A0 // Unfortunately, this is the best we can do at the m=
oment as
> this FFI callback was mistakenly
> +=C2=A0=C2=A0=C2=A0 // presumed to be infallible :(
> +=C2=A0=C2=A0=C2=A0 let new: KBox<CrtcState<T>> =3D KBox::try_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_init!(CrtcState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
: Opaque::new(Default::default()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inner=
: UnsafeCell::new(Default::default()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL,
> +=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0 .expect("Unfortunately, this API was presumed infalli=
ble");
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM takes ownership of the state from here=
, and will
> never move it
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::__drm_atomic_helper_crtc_reset(crt=
c.as_raw(),
> KBox::into_raw(new).cast()) };
> +}
> +
> +unsafe extern "C" fn atomic_check_callback<T: DriverCrtc>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) -> i32 {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `crtc` is of type `Crtc<T>` via=
 type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `crtc` is pointing =
to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees `state` points to a valid
> `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 // We use a ManuallyDrop here to avoid AtomicStateCom=
poser
> dropping an owned reference we never
> +=C2=A0=C2=A0=C2=A0 // acquired.
> +=C2=A0=C2=A0=C2=A0 let state =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> ManuallyDrop::new(AtomicStateComposer::new(NonNull::new_unchecked(sta
> te))) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic check callback, we're =
guaranteed
> by DRM that both the old and
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 new crtc state are present in this ato=
mic state
> +=C2=A0=C2=A0=C2=A0 // - We just created the state composer above, so oth=
er
> composers cannot be taken out on the
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 crtc state yet.
> +=C2=A0=C2=A0=C2=A0 let check =3D unsafe { CrtcAtomicCheck::new(crtc, &st=
ate) };
> +
> +=C2=A0=C2=A0=C2=A0 from_result(|| {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::atomic_check(check)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(0)
> +=C2=A0=C2=A0=C2=A0 })
> +}
> +
> +unsafe extern "C" fn atomic_begin_callback<T: DriverCrtc>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // * We're guaranteed `crtc` is of type `Crtc<T>` via=
 type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // * We're guaranteed by DRM that `crtc` is pointing =
to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed by DRM that `state` point=
s to a
> valid instance of `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic_begin callback, we're =
guaranteed
> by DRM that both the old and new
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 crtc state are resent in this atomic s=
tate.
> +=C2=A0=C2=A0=C2=A0 // - We just created the state mutator above, so othe=
r mutators
> cannot be taken out on the crtc
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state yet.
> +=C2=A0=C2=A0=C2=A0 let commit =3D unsafe { CrtcAtomicCommit::new(crtc, &=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_begin(commit);
> +}
> +
> +unsafe extern "C" fn atomic_flush_callback<T: DriverCrtc>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `crtc` is of type `Crtc<T>` via=
 type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `crtc` is pointing =
to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed by DRM that `state` point=
s to a
> valid instance of `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic_flush callback, we're =
guaranteed
> by DRM that both the old and new
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 crtc state are resent in this atomic s=
tate.
> +=C2=A0=C2=A0=C2=A0 // - We just created the state mutator above, so othe=
r mutators
> cannot be taken out on the crtc
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state yet.
> +=C2=A0=C2=A0=C2=A0 let commit =3D unsafe { CrtcAtomicCommit::new(crtc, &=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_flush(commit);
> +}
> +
> +unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `crtc` is of type `Crtc<T>` via=
 type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `crtc` is pointing =
to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM never passes an invalid ptr for `state=
`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic_enable callback, we're=
 guaranteed
> by DRM that both the old and
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 new crtc state are present in this ato=
mic state.
> +=C2=A0=C2=A0=C2=A0 // - We just created the state mutator above, so othe=
r mutators
> cannot be taken out on the crtc
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state yet.
> +=C2=A0=C2=A0=C2=A0 let commit =3D unsafe { CrtcAtomicCommit::new(crtc, &=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_enable(commit);
> +}
> +
> +unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `crtc` points to a valid instan=
ce of
> `drm_crtc`
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed that `crtc` is of type `Plane<T=
>` by
> `DriverPlane`s type invariants.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed that `state` points to a =
valid
> `drm_crtc_state` by DRM
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic_disable callback, we'r=
e
> guaranteed by DRM that both the old and
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 new crtc state are present in this ato=
mic state.
> +=C2=A0=C2=A0=C2=A0 // - We just created the state mutator above, so othe=
r mutators
> cannot be taken out on the crtc
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state yet.
> +=C2=A0=C2=A0=C2=A0 let commit =3D unsafe { CrtcAtomicCommit::new(crtc, &=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_disable(commit);
> +}
> diff --git a/rust/kernel/drm/kms/encoder.rs
> b/rust/kernel/drm/kms/encoder.rs
> new file mode 100644
> index 000000000000..5f860faf8b61
> --- /dev/null
> +++ b/rust/kernel/drm/kms/encoder.rs
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM encoders.
> +//!
> +//! C header:
> [`include/drm/drm_encoder.h`](srctree/include/drm/drm_encoder.h)
> +
> +use super::{
> +=C2=A0=C2=A0=C2=A0 KmsDriver, ModeObject, ModeObjectVtable, NewKmsDevice=
, Probing,
> StaticModeObject, Sealed
> +};
> +use crate::{
> +=C2=A0=C2=A0=C2=A0 alloc::KBox,
> +=C2=A0=C2=A0=C2=A0 drm::device::Device,
> +=C2=A0=C2=A0=C2=A0 error::to_result,
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 types::{NotThreadSafe, Opaque},
> +};
> +use bindings;
> +use core::{
> +=C2=A0=C2=A0=C2=A0 marker::*,
> +=C2=A0=C2=A0=C2=A0 mem,
> +=C2=A0=C2=A0=C2=A0 ops::Deref,
> +=C2=A0=C2=A0=C2=A0 ptr::null,
> +};
> +use macros::paste;
> +
> +/// A macro for generating our type ID enumerator.
> +macro_rules! declare_encoder_types {
> +=C2=A0=C2=A0=C2=A0 ($( $oldname:ident as $newname:ident ),+) =3D> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[repr(i32)]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[non_exhaustive]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #[derive(Copy, Clone, Partial=
Eq, Eq)]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// An enumerator for all pos=
sible [`Encoder`] type IDs.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pub enum Type {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // No=
te: bindgen defaults the macro values to u32 and
> not i32, but DRM takes them as an
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // i3=
2 - so just do the conversion here
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 #[doc =3D concat!("The encoder type ID for a ",
> stringify!($newname), " encoder.")]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 $newname =3D
> paste!(crate::bindings::[<DRM_MODE_ENCODER_ $oldname>]) as i32
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ),+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +declare_encoder_types! {
> +=C2=A0=C2=A0=C2=A0 NONE=C2=A0=C2=A0=C2=A0=C2=A0 as None,
> +=C2=A0=C2=A0=C2=A0 DAC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dac,
> +=C2=A0=C2=A0=C2=A0 TMDS=C2=A0=C2=A0=C2=A0=C2=A0 as Tmds,
> +=C2=A0=C2=A0=C2=A0 LVDS=C2=A0=C2=A0=C2=A0=C2=A0 as Lvds,
> +=C2=A0=C2=A0=C2=A0 VIRTUAL=C2=A0 as Virtual,
> +=C2=A0=C2=A0=C2=A0 DSI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dsi,
> +=C2=A0=C2=A0=C2=A0 DPMST=C2=A0=C2=A0=C2=A0 as DpMst,
> +=C2=A0=C2=A0=C2=A0 DPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as Dpi
> +}
> +
> +/// The main trait for implementing the [`struct drm_encoder`] API
> for [`Encoder`].
> +///
> +/// Any KMS driver should have at least one implementation of this
> type, which allows them to create
> +/// [`Encoder`] objects. Additionally, a driver may store driver-
> private data within the type that
> +/// implements [`DriverEncoder`] - and it will be made available
> when using a fully typed
> +/// [`Encoder`] object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_encoder`] pointers are contained within a
> [`Encoder<Self>`].
> +///
> +/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
> +#[vtable]
> +pub trait DriverEncoder: Send + Sync + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The generated C vtable for this [`DriverEncoder`]
> implementation.
> +=C2=A0=C2=A0=C2=A0 const OPS: &'static DriverEncoderOps =3D &DriverEncod=
erOps {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_encoder_=
funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset=
: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destr=
oy: Some(encoder_destroy_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 late_=
register: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early=
_unregister: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug=
fs_init: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_e=
ncoder_helper_funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpms:=
 None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
valid: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
fixup: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepa=
re: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode_=
set: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commi=
t: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 detec=
t: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabl=
e: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disab=
le: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_check: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_enable: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_disable: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_mode_set: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 /// The parent driver for this drm_encoder implementa=
tion
> +=C2=A0=C2=A0=C2=A0 type Driver: KmsDriver;
> +
> +=C2=A0=C2=A0=C2=A0 /// The type to pass to the `args` field of
> [`UnregisteredEncoder::new`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This type will be made available in in the `args`=
 argument
> of [`Self::new`]. Drivers which
> +=C2=A0=C2=A0=C2=A0 /// don't need this can simply pass [`()`] here.
> +=C2=A0=C2=A0=C2=A0 type Args;
> +
> +=C2=A0=C2=A0=C2=A0 /// The constructor for creating a [`Encoder`] using =
this
> [`DriverEncoder`] implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to instantiate their [`Drive=
rEncoder`]
> object.
> +=C2=A0=C2=A0=C2=A0 fn new(device: &Device<Self::Driver>, args: Self::Arg=
s) -> impl
> PinInit<Self, Error>;
> +}
> +
> +/// The generated C vtable for a [`DriverEncoder`].
> +///
> +/// This type is created internally by DRM.
> +pub struct DriverEncoderOps {
> +=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_encoder_funcs,
> +=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_encoder_helper_funcs,
> +}
> +
> +/// A trait implemented by any type that acts as a [`struct
> drm_encoder`] interface.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// [`as_raw()`] must always return a valid pointer to a [`struct
> drm_encoder`].
> +///
> +/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
> +/// [`as_raw()`]: AsRawEncoder::as_raw()
> +pub unsafe trait AsRawEncoder {
> +=C2=A0=C2=A0=C2=A0 /// Return the raw `bindings::drm_encoder` for this D=
RM encoder.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers should never use this directly
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_encoder;
> +
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw `bindings::drm_encoder` pointer int=
o an object
> of this type.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Callers promise that `ptr` points to a valid inst=
ance of
> this type
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encode=
r) -> &'a
> Self;
> +}
> +
> +/// The main interface for a [`struct drm_encoder`].
> +///
> +/// This type is the main interface for dealing with DRM encoders.
> In addition, it also allows
> +/// immutable access to whatever private data is contained within an
> implementor's
> +/// [`DriverEncoder`] type.
> +///
> +/// # Invariants
> +///
> +/// - `encoder` and `inner` are initialized for as long as this
> object is made available to users.
> +/// - The data layout of this structure begins with [`struct
> drm_encoder`].
> +///
> +/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
> +#[repr(C)]
> +#[pin_data]
> +pub struct Encoder<T: DriverEncoder> {
> +=C2=A0=C2=A0=C2=A0 /// The FFI drm_encoder object
> +=C2=A0=C2=A0=C2=A0 encoder: Opaque<bindings::drm_encoder>,
> +=C2=A0=C2=A0=C2=A0 /// The driver's private inner data
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +}
> +
> +impl<T: DriverEncoder> Sealed for Encoder<T> {}
> +
> +// SAFETY: Our interface is thread-safe.
> +unsafe impl<T: DriverEncoder> Send for Encoder<T> {}
> +// SAFETY: Our interface is thread-safe.
> +unsafe impl<T: DriverEncoder> Sync for Encoder<T> {}
> +
> +// SAFETY: We don't expose Encoder<T> to users before `base` is
> initialized in ::new(), so
> +// `raw_mode_obj` always returns a valid pointer to a
> bindings::drm_mode_object.
> +unsafe impl<T: DriverEncoder> ModeObject for Encoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T::Driver;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM encoders exist=
 for as long as the device
> does, so this pointer is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.encoder.get()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose En=
coder<T> to users before it's
> initialized, so `base` is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.enco=
der.get()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Encoders do not have a refcount
> +unsafe impl<T: DriverEncoder> StaticModeObject for Encoder<T> {}
> +
> +impl<T: DriverEncoder> Deref for Encoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY:
> +// - Via our type invariants our data layout starts with
> `drm_encoder`.
> +// - Since we don't expose `Encoder` to users befre it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_encoder`.
> +unsafe impl<T: DriverEncoder> AsRawEncoder for Encoder<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_encoder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.encoder.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encode=
r) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 starts with to
> `bindings::drm_encoder`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: `funcs` is initialized when the encoder is allocated
> +unsafe impl<T: DriverEncoder> ModeObjectVtable for Encoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_encoder_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to an
> encoder
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverEncoder> Encoder<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D>(&'a OpaqueEncoder<=
D>) -> &'a Self;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T as =
DriverEncoder,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Encoder =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`Encoder`] that has not yet been registered with userspace.
> +///
> +/// KMS registration is single-threaded, so this object is not
> thread-safe.
> +///
> +/// # Invariants
> +///
> +/// - This object can only exist before its respective KMS device
> has been registered.
> +/// - Otherwise, it inherits all invariants of [`Encoder`] and has
> an identical data layout.
> +pub struct UnregisteredEncoder<T: DriverEncoder>(Encoder<T>,
> NotThreadSafe);
> +
> +// SAFETY: We inherit all relevant invariants of `Encoder`
> +unsafe impl<T: DriverEncoder> AsRawEncoder for
> UnregisteredEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_encoder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encode=
r) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This is another fr=
om_raw() call, so this function
> shares the same safety contract
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let encoder =3D unsafe { Enco=
der::<T>::from_raw(ptr) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical via our type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { mem::transmute(encod=
er) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverEncoder> Deref for UnregisteredEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverEncoder> UnregisteredEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`UnregisteredEncoder`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A driver may use this from their
> [`KmsDriver::create_objects`] callback in order to
> +=C2=A0=C2=A0=C2=A0 /// construct new [`UnregisteredEncoder`] objects.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`KmsDriver::create_objects`]:
> kernel::drm::kms::KmsDriver::create_objects
> +=C2=A0=C2=A0=C2=A0 pub fn new<'a, 'b: 'a>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a NewKmsDevice<'a, T::=
Driver, Probing>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_: Type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 possible_crtcs: u32,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 possible_clones: u32,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Option<&CStr>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args: T::Args,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<&'b Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: Pin<KBox<Encoder<T>=
>> =3D KBox::try_pin_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_p=
in_init!(Encoder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 encoder: Opaque::new(bindings::drm_encoder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_private: &T::OPS.helper_f=
uncs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 possible_crtcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 possible_clones,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inner <- T::new(dev, args),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _p: PhantomPinned
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_K=
ERNEL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `dev` is responsible for=
 destroying the encoder and
> thus outlives us.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - as_raw() returns valid p=
ointers for each type here
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This initializes `this`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our type is proof that t=
his is being called before KMS
> device registration
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `name` is optional and w=
ill be auto-generated by DRM if
> passed as NULL
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_encoder_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 this.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &T::OPS.funcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 type_ as _,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name.map_or(null(), |n| n.as_char_ptr()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't move anyt=
hing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { Pin::in=
to_inner_unchecked(this) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We'll re-assemble the box =
in encoder_destroy_callback()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D KBox::into_raw(t=
his);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // UnregisteredEncoder has an=
 equivalent data layout
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: *mut Self =3D this.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just allocated =
the encoder above, so this
> pointer must be valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { &*this })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`struct drm_encoder`] without a known [`DriverEncoder`]
> implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverEncoder`] implementation
> +/// for a [`struct drm_encoder`] automatically. It is identical to
> [`Encoder`], except that it does not
> +/// provide access to the driver's private data.
> +///
> +/// # Invariants
> +///
> +/// Same as [`Encoder`].
> +#[repr(transparent)]
> +pub struct OpaqueEncoder<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 encoder: Opaque<bindings::drm_encoder>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaqueEncoder<T> {}
> +
> +// SAFETY: All of our encoder interfaces are thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaqueEncoder<T> {}
> +
> +// SAFETY: All of our encoder interfaces are thread-safe
> +unsafe impl<T: KmsDriver> Sync for OpaqueEncoder<T> {}
> +
> +// SAFETY: We don't expose OpaqueEncoder<T> to users before `base`
> is initialized in
> +// OpaqueEncoder::new(), so `raw_mode_obj` always returns a valid
> poiner to a
> +// bindings::drm_mode_object.
> +unsafe impl<T: KmsDriver> ModeObject for OpaqueEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM encoders exist=
 for as long as the device
> does, so this pointer is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.encoder.get()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose En=
coder<T> to users before it's
> initialized, so `base` is always
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.enco=
der.get()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Encoders do not have a refcount
> +unsafe impl<T: KmsDriver> StaticModeObject for OpaqueEncoder<T> {}
> +
> +// SAFETY:
> +// - Via our type variants our data layout is identical to=C2=A0 with
> `drm_encoder`
> +// - Since we don't expose `Encoder` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_encoder`.
> +unsafe impl<T: KmsDriver> AsRawEncoder for OpaqueEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_encoder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.encoder.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encode=
r) -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_encoder`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: `funcs` is initialized when the encoder is allocated
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueEncoder<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_encoder_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to an
> encoder
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
> +=C2=A0=C2=A0=C2=A0 encoder: *mut bindings::drm_encoder,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `encoder` points to a =
valid
> initialized `drm_encoder`.
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_encoder_cleanup(encoder) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees we are now the only one with acce=
ss to this
> [`drm_encoder`].
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via `DriverEncoder`s type inva=
riants.
> +=C2=A0=C2=A0=C2=A0 unsafe { drop(KBox::from_raw(encoder as *mut Encoder<=
T>)) };
> +}
> diff --git a/rust/kernel/drm/kms/framebuffer.rs
> b/rust/kernel/drm/kms/framebuffer.rs
> new file mode 100644
> index 000000000000..54d0391388a9
> --- /dev/null
> +++ b/rust/kernel/drm/kms/framebuffer.rs
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM framebuffers.
> +//!
> +//! C header:
> [`include/drm/drm_framebuffer.h`](srctree/include/drm/drm_framebuffer
> .h)
> +
> +use super::{KmsDriver, ModeObject, Sealed};
> +use crate::{drm::device::Device, types::*};
> +use bindings;
> +use core::{marker::*, ptr};
> +
> +/// The main interface for [`struct drm_framebuffer`].
> +///
> +/// # Invariants
> +///
> +/// - `self.0` is initialized for as long as this object is exposed
> to users.
> +/// - This type has an identical data layout to [`struct
> drm_framebuffer`]
> +///
> +/// [`struct drm_framebuffer`]:
> srctree/include/drm/drm_framebuffer.h
> +#[repr(transparent)]
> +pub struct Framebuffer<T:
> KmsDriver>(Opaque<bindings::drm_framebuffer>, PhantomData<T>);
> +
> +// SAFETY:
> +// - `self.0` is initialized for as long as this object is exposed
> to users
> +// - `base` is initialized by DRM when `self.0` is initialized, thus
> `raw_mode_obj()` always returns
> +//=C2=A0=C2=A0 a valid pointer.
> +unsafe impl<T: KmsDriver> ModeObject for Framebuffer<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `dev` points to an=
 initialized `struct
> drm_device` for as long as this type is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.0.get()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose Fr=
amebuffer<T> to users before
> its initialized, so `base` is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // always initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.0.ge=
t()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: References to framebuffers are safe to be accessed from
> any thread
> +unsafe impl<T: KmsDriver> Send for Framebuffer<T> {}
> +// SAFETY: References to framebuffers are safe to be accessed from
> any thread
> +unsafe impl<T: KmsDriver> Sync for Framebuffer<T> {}
> +
> +// For implementing ModeObject
> +impl<T: KmsDriver> Sealed for Framebuffer<T> {}
> +
> +impl<T: KmsDriver> PartialEq for Framebuffer<T> {
> +=C2=A0=C2=A0=C2=A0 fn eq(&self, other: &Self) -> bool {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr::eq(self.0.get(), other.0=
.get())
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: KmsDriver> Eq for Framebuffer<T> {}
> +
> +impl<T: KmsDriver> Framebuffer<T> {
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw pointer to a `struct drm_framebuffe=
r` into a
> [`Framebuffer`]
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The caller guarantews that `ptr` points to a init=
ialized
> `struct drm_framebuffer` for at
> +=C2=A0=C2=A0=C2=A0 /// least the entire lifetime of `'a`.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub(super) unsafe fn from_raw<'a>(ptr: *const
> bindings::drm_framebuffer) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to drm_framebuffer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> diff --git a/rust/kernel/drm/kms/modes.rs
> b/rust/kernel/drm/kms/modes.rs
> new file mode 100644
> index 000000000000..0e8dc434487d
> --- /dev/null
> +++ b/rust/kernel/drm/kms/modes.rs
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +use bindings;
> +
> +use crate::types::Opaque;
> +
> +/// DRM kernel-internal display mode structure.
> +///
> +/// This structure contains various resolution and timing
> information for a given display mode in
> +/// DRM.
> +///
> +/// # Invariants
> +///
> +/// - The data layout of this structure is guaranteed to be
> equivalent to that of `struct
> +///=C2=A0=C2=A0 drm_display_mode`.
> +/// - We ensure through our bindings that rust's data aliasing rules
> are maintained, ensuring it is
> +///=C2=A0=C2=A0 safe to read any fields inside of `self.inner`.
> +#[repr(transparent)]
> +pub struct DisplayMode {
> +=C2=A0=C2=A0=C2=A0 inner: Opaque<bindings::drm_display_mode>,
> +}
> +
> +// SAFETY: Our bindings are thread-safe via our type invariants.
> +unsafe impl Send for DisplayMode {}
> +// SAFETY: Our bindings are thread-safe via our type invariants.
> +unsafe impl Sync for DisplayMode {}
> +
> +impl DisplayMode {
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw pointer to a `struct drm_display_mo=
de` into an
> immutable [`DisplayMode`] ref.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # SAFETY
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `self_ptr` points to=
 a valid
> initialized `struct
> +=C2=A0=C2=A0=C2=A0 ///=C2=A0=C2=A0 drm_display_mode`.
> +=C2=A0=C2=A0=C2=A0 /// - The caller must ensure that rust's data aliasin=
g rules
> will not be broken for the lifetime
> +=C2=A0=C2=A0=C2=A0 ///=C2=A0=C2=A0 of `'a`, e.g. no mutable references m=
ay exist while
> immutable references exist to Self.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub(crate) unsafe fn as_ref<'a>(self_ptr: *const
> bindings::drm_display_mode) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The pointer is val=
id via our safety contract, and
> the data layout of this struct
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // is equivalent to `Self` vi=
a our type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*self_ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return a raw pointer to the `struct drm_display_m=
ode`
> contained within this [`DisplayMode`].
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn as_raw(&self) -> *const bindings::drm_d=
isplay_mode
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.inner.get().cast_const()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the pixel clock for the adjusted display=
 mode in
> kHz.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn crtc_clock(&self) -> i32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Reading these fiel=
ds is safe via our type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).crt=
c_clock }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the start of the vertical sync period fo=
r the
> adjusted display mode.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn crtc_vblank_start(&self) -> u16 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).crt=
c_vblank_start }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the end of the vertical sync period for =
the
> adjusted display mode.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn crtc_vblank_end(&self) -> u16 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Reading these fiel=
ds is safe via our type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).crt=
c_vblank_end }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the number of vertical scanlines for a f=
ull scanout
> frame in this adjusted display
> +=C2=A0=C2=A0=C2=A0 /// mode.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn crtc_vtotal(&self) -> u16 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Reading these fiel=
ds is safe via our type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).crt=
c_vtotal }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> diff --git a/rust/kernel/drm/kms/plane.rs
> b/rust/kernel/drm/kms/plane.rs
> new file mode 100644
> index 000000000000..661d82273099
> --- /dev/null
> +++ b/rust/kernel/drm/kms/plane.rs
> @@ -0,0 +1,1095 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM display planes.
> +//!
> +//! C header:
> [`include/drm/drm_plane.h`](srctree/include/drm/drm_plane.h)
> +
> +use super::{
> +=C2=A0=C2=A0=C2=A0 atomic::*, crtc::*, framebuffer::*, KmsDriver, ModeOb=
ject,
> ModeObjectVtable, StaticModeObject,
> +=C2=A0=C2=A0=C2=A0 NewKmsDevice, Probing, Sealed
> +};
> +use crate::{
> +=C2=A0=C2=A0=C2=A0 alloc::KBox,
> +=C2=A0=C2=A0=C2=A0 bindings,
> +=C2=A0=C2=A0=C2=A0 drm::{device::Device, fourcc::*},
> +=C2=A0=C2=A0=C2=A0 error::{from_result, to_result, Error},
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 types::{NotThreadSafe, Opaque},
> +};
> +use core::{
> +=C2=A0=C2=A0=C2=A0 cell::Cell,
> +=C2=A0=C2=A0=C2=A0 marker::*,
> +=C2=A0=C2=A0=C2=A0 mem::{self, ManuallyDrop},
> +=C2=A0=C2=A0=C2=A0 ops::*,
> +=C2=A0=C2=A0=C2=A0 pin::Pin,
> +=C2=A0=C2=A0=C2=A0 ptr::{null, null_mut, NonNull},
> +};
> +
> +/// The main trait for implementing the [`struct drm_plane`] API for
> [`Plane`].
> +///
> +/// Any KMS driver should have at least one implementation of this
> type, which allows them to create
> +/// [`Plane`] objects. Additionally, a driver may store driver-
> private data within the type that
> +/// implements [`DriverPlane`] - and it will be made available when
> using a fully typed [`Plane`]
> +/// object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_plane`] pointers are contained within a
> [`Plane<Self>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_plane_state`] pointers are contained within=
 a
> [`PlaneState<Self::State>`].
> +///
> +/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
> +/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
> +#[vtable]
> +pub trait DriverPlane: Send + Sync + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The generated C vtable for this [`DriverPlane`]
> implementation.
> +=C2=A0=C2=A0=C2=A0 const OPS: &'static DriverPlaneOps =3D &DriverPlaneOp=
s {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_plane_fu=
ncs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 updat=
e_plane:
> Some(bindings::drm_atomic_helper_update_plane),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disab=
le_plane:
> Some(bindings::drm_atomic_helper_disable_plane),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destr=
oy: Some(plane_destroy_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset=
: Some(plane_reset_callback::<Self>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_p=
roperty: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_duplicate_state:
> Some(atomic_duplicate_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_destroy_state:
> Some(atomic_destroy_state_callback::<Self::State>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_set_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_get_property: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 late_=
register: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early=
_unregister: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_print_state: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 forma=
t_mod_supported: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 forma=
t_mod_supported_async: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_p=
lane_helper_funcs {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepa=
re_fb: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clean=
up_fb: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin=
_fb_access: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_f=
b_access: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_check: if Self::HAS_ATOMIC_CHECK {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_check_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_update: if Self::HAS_ATOMIC_UPDATE {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Some(atomic_update_callback::<Self>)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } els=
e {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_enable: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_disable: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_async_check: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomi=
c_async_update: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic=
_flush: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_s=
canout_buffer: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 /// The type to pass to the `args` field of
> [`UnregisteredPlane::new`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This type will be made available in in the `args`=
 argument
> of [`Self::new`]. Drivers which
> +=C2=A0=C2=A0=C2=A0 /// don't need this can simply pass [`()`] here.
> +=C2=A0=C2=A0=C2=A0 type Args;
> +
> +=C2=A0=C2=A0=C2=A0 /// The parent [`KmsDriver`] implementation.
> +=C2=A0=C2=A0=C2=A0 type Driver: KmsDriver;
> +
> +=C2=A0=C2=A0=C2=A0 /// The [`DriverPlaneState`] implementation for this
> [`DriverPlane`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// See [`DriverPlaneState`] for more info.
> +=C2=A0=C2=A0=C2=A0 type State: DriverPlaneState;
> +
> +=C2=A0=C2=A0=C2=A0 /// The constructor for creating a [`Plane`] using th=
is
> [`DriverPlane`] implementation.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to instantiate their [`Drive=
rPlane`]
> object.
> +=C2=A0=C2=A0=C2=A0 fn new(device: &Device<Self::Driver>, args: Self::Arg=
s) -> impl
> PinInit<Self, Error>;
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_plane_helper_funcs.atomic_upda=
te`] hook
> for this plane.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to customize the atomic upda=
te phase of
> their [`Plane`] objects. If not
> +=C2=A0=C2=A0=C2=A0 /// specified, this function is a no-op.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_plane_helper_funcs.atomic_update`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_update(_commit: PlaneAtomicCommit<'_, Self>=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should not be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// The optional [`drm_plane_helper_funcs.atomic_chec=
k`] hook
> for this plane.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers may use this to customize the atomic chec=
k phase of
> their [`Plane`] objects. The
> +=C2=A0=C2=A0=C2=A0 /// result of this function determines whether the at=
omic check
> passed or failed.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_plane_helper_funcs.atomic_check`]:
> srctree/include/drm/drm_modeset_helper_vtables.h
> +=C2=A0=C2=A0=C2=A0 fn atomic_check(_check: PlaneAtomicCheck<'_, Self>) -=
> Result {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_error::build_error("Thi=
s should not be reachable")
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// The generated C vtable for a [`DriverPlane`].
> +///
> +/// This type is created internally by DRM.
> +pub struct DriverPlaneOps {
> +=C2=A0=C2=A0=C2=A0 funcs: bindings::drm_plane_funcs,
> +=C2=A0=C2=A0=C2=A0 helper_funcs: bindings::drm_plane_helper_funcs,
> +}
> +
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +#[repr(u32)]
> +/// An enumerator describing a type of [`Plane`].
> +///
> +/// This is mainly just relevant for DRM legacy drivers.
> +///
> +/// # Invariants
> +///
> +/// This type is identical to [`enum drm_plane_type`].
> +///
> +/// [`enum drm_plane_type`]: srctree/include/drm/drm_plane.h
> +pub enum Type {
> +=C2=A0=C2=A0=C2=A0 /// Overlay planes represent all non-primary, non-cur=
sor planes.
> Some drivers refer to these
> +=C2=A0=C2=A0=C2=A0 /// types of planes as "sprites" internally.
> +=C2=A0=C2=A0=C2=A0 Overlay =3D bindings::drm_plane_type_DRM_PLANE_TYPE_O=
VERLAY,
> +
> +=C2=A0=C2=A0=C2=A0 /// A primary plane attached to a CRTC that is the mo=
st likely
> to be able to light up the CRTC
> +=C2=A0=C2=A0=C2=A0 /// when no scaling/cropping is used, and the plane c=
overs the
> whole CRTC.
> +=C2=A0=C2=A0=C2=A0 Primary =3D bindings::drm_plane_type_DRM_PLANE_TYPE_P=
RIMARY,
> +
> +=C2=A0=C2=A0=C2=A0 /// A cursor plane attached to a CRTC that is more li=
kely to be
> enabled when no scaling/cropping
> +=C2=A0=C2=A0=C2=A0 /// is used, and the framebuffer has the size indicat=
ed by
> [`ModeConfigInfo::max_cursor`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`ModeConfigInfo::max_cursor`]:
> crate::drm::kms::ModeConfigInfo
> +=C2=A0=C2=A0=C2=A0 Cursor =3D bindings::drm_plane_type_DRM_PLANE_TYPE_CU=
RSOR,
> +}
> +
> +/// The main interface for a [`struct drm_plane`].
> +///
> +/// This type is the main interface for dealing with DRM planes. In
> addition, it also allows
> +/// immutable access to whatever private data is contained within an
> implementor's [`DriverPlane`]
> +/// type.
> +///
> +/// # Invariants
> +///
> +/// - `plane` and `inner` are initialized for as long as this object
> is made available to users.
> +/// - The data layout of this structure begins with [`struct
> drm_plane`].
> +/// - The atomic state for this type can always be assumed to be of
> type [`PlaneState<T::State>`].
> +///
> +/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
> +#[repr(C)]
> +#[pin_data]
> +pub struct Plane<T: DriverPlane> {
> +=C2=A0=C2=A0=C2=A0 /// The FFI drm_plane object
> +=C2=A0=C2=A0=C2=A0 plane: Opaque<bindings::drm_plane>,
> +=C2=A0=C2=A0=C2=A0 /// The driver's private inner data
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 _p: PhantomPinned,
> +}
> +
> +impl<T: DriverPlane> Sealed for Plane<T> {}
> +
> +impl<T: DriverPlane> Deref for Plane<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: `funcs` is initialized when the plane is allocated
> +unsafe impl<T: DriverPlane> ModeObjectVtable for Plane<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_plane_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid plane pointer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlane> Plane<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D>(&'a OpaquePlane<D>=
) -> &'a Self;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T as =
DriverPlane,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Plane =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`Plane`] that has not yet been registered with userspace.
> +///
> +/// KMS registration is single-threaded, so this object is not
> thread-safe.
> +///
> +/// # Invariants
> +///
> +/// - This object can only exist before its respective KMS device
> has been registered.
> +/// - Otherwise, it inherits all invariants of [`Plane`] and has an
> identical data layout.
> +pub struct UnregisteredPlane<T: DriverPlane>(Plane<T>,
> NotThreadSafe);
> +
> +// SAFETY: We share the invariants of `Plane`
> +unsafe impl<T: DriverPlane> AsRawPlane for UnregisteredPlane<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane)=
 -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This is another fr=
om_raw() call, so this function
> shares the same safety contract
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let plane =3D unsafe { Plane:=
:<T>::from_raw(ptr) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical via our type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { mem::transmute(plane=
) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlane> Deref for UnregisteredPlane<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlane> UnregisteredPlane<T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`UnregisteredPlane`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A driver may use this from their
> [`KmsDriver::create_objects`] callback in order to
> +=C2=A0=C2=A0=C2=A0 /// construct new [`UnregisteredPlane`] objects.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`KmsDriver::create_objects`]:
> kernel::drm::kms::KmsDriver::create_objects
> +=C2=A0=C2=A0=C2=A0 pub fn new<'a, 'b: 'a>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a NewKmsDevice<'a, T::=
Driver, Probing>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 possible_crtcs: u32,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 formats: &[u32],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format_modifiers: Option<&[u6=
4]>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_: Type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Option<&CStr>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args: T::Args,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<&'b Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: Pin<KBox<Plane<T>>>=
 =3D KBox::try_pin_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_p=
in_init!(Plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 plane: Opaque::new(bindings::drm_plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 helper_private: &T::OPS.helper_f=
uncs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inner <- T::new(dev, args),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _p: PhantomPinned
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_K=
ERNEL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // TODO: Move this over to us=
ing collect() someday
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Create a modifiers array w=
ith the sentinel for passing to
> DRM
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let format_modifiers_raw;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if let Some(modifiers) =3D fo=
rmat_modifiers {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let m=
ut raw =3D KVec::with_capacity(modifiers.len() + 1,
> GFP_KERNEL)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for m=
odifier in modifiers {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raw.push(*modifier, GFP_KERNEL)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raw.p=
ush(FORMAT_MOD_INVALID, GFP_KERNEL)?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 forma=
t_modifiers_raw =3D Some(raw);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 forma=
t_modifiers_raw =3D None;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `dev` handles destroying=
 the plane, and thus will
> outlive us and always be valid.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We just allocated `this`=
, and we won't move it since
> it's pinned
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We just allocated the `f=
ormat_modifiers_raw` vec and
> added the sentinel DRM expects
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 above
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `drm_universal_plane_ini=
t` will memcpy() the following
> parameters into its own storage,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 so it's safe f=
or them to become inaccessible after this
> call returns:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 - `formats`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 - `format_modi=
fiers_raw`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 - `name`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `type_` is equivalent to=
 `drm_plane_type` via its type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_universal_plane_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 this.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 possible_crtcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &T::OPS.funcs,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 formats.as_ptr(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 formats.len() as _,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 format_modifiers_raw.map_or(null(), |f| f.as_ptr()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 type_ as _,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name.map_or(null(), |n| n.as_char_ptr()),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't move anyt=
hing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { Pin::in=
to_inner_unchecked(this) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We'll re-assemble the box =
in plane_destroy_callback()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D KBox::into_raw(t=
his);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // UnregisteredPlane has an e=
quivalent data layout
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this: *mut Self =3D this.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just allocated =
the plane above, so this
> pointer must be valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { &*this })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A trait implemented by any type that acts as a [`struct
> drm_plane`] interface.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// [`as_raw()`] must always return a valid pointer to an
> initialized [`struct drm_plane`].
> +///
> +/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
> +/// [`as_raw()`]: AsRawPlane::as_raw()
> +pub unsafe trait AsRawPlane {
> +=C2=A0=C2=A0=C2=A0 /// Return the raw `bindings::drm_plane` for this DRM=
 plane.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers should never use this directly.
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_plane;
> +
> +=C2=A0=C2=A0=C2=A0 /// Convert a raw `bindings::drm_plane` pointer into =
an object
> of this type.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Callers promise that `ptr` points to a valid inst=
ance of
> this type
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane)=
 -> &'a
> Self;
> +}
> +
> +// SAFETY:
> +// - Via our type variants our data layout starts with `drm_plane`
> +// - Since we don't expose `plane` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_plane`.
> +unsafe impl<T: DriverPlane> AsRawPlane for Plane<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.plane.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane)=
 -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout start with=
 `bindings::drm_plane`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *mut Self =3D ptr.ca=
st();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our safety contrac=
t requires that `ptr` point to
> a valid intance of `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: DriverPlane> ModesettablePlane for Plane<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D PlaneState<T::State>;
> +}
> +
> +// SAFETY: We don't expose Plane<T> to users before `base` is
> initialized in ::new(), so
> +// `raw_mode_obj` always returns a valid pointer to a
> bindings::drm_mode_object.
> +unsafe impl<T: DriverPlane> ModeObject for Plane<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T::Driver;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM planes exist f=
or as long as the device does,
> so this pointer is always valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose DR=
M planes to users before `base`
> is initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.as_r=
aw()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Planes do not have a refcount
> +unsafe impl<T: DriverPlane> StaticModeObject for Plane<T> {}
> +
> +// SAFETY: Our interface is thread-safe.
> +unsafe impl<T: DriverPlane> Send for Plane<T> {}
> +
> +// SAFETY: Our interface is thread-safe.
> +unsafe impl<T: DriverPlane> Sync for Plane<T> {}
> +
> +/// A supertrait of [`AsRawPlane`] for [`struct drm_plane`]
> interfaces that can perform modesets.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// # Safety
> +///
> +/// Any object implementing this trait must only be made directly
> available to the user after
> +/// [`create_objects`] has completed.
> +///
> +/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
> +/// [`create_objects`]: KmsDriver::create_objects
> +pub unsafe trait ModesettablePlane: AsRawPlane {
> +=C2=A0=C2=A0=C2=A0 /// The type that should be returned for a plane stat=
e acquired
> using this plane interface
> +=C2=A0=C2=A0=C2=A0 type State: FromRawPlaneState;
> +}
> +
> +/// Common methods available on any type which implements
> [`AsRawPlane`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// planes.
> +pub trait RawPlane: AsRawPlane {
> +=C2=A0=C2=A0=C2=A0 /// Return the index of this DRM plane
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn index(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - The index is initialized=
 by the time we expose planes
> to users, and does not change
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 throughout its=
 lifetime
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `.as_raw()` always retur=
ns a valid poiinter.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.ind=
ex
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the index of this DRM plane in the form of=
 a bitmask
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn mask(&self) -> u32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 << self.index()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawPlane> RawPlane for T {}
> +
> +/// A [`struct drm_plane`] without a known [`DriverPlane`]
> implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverPlane`] implementation
> +/// for a [`struct drm_plane`] automatically. It is identical to
> [`Plane`], except that it does not
> +/// provide access to the driver's private data.
> +///
> +/// It may be upcasted to a full [`Plane`] using
> [`Plane::from_opaque`] or
> +/// [`Plane::try_from_opaque`].
> +///
> +/// # Invariants
> +///
> +/// - `plane` is initialized for as long as this object is made
> available to users.
> +/// - The data layout of this structure is equivalent to [`struct
> drm_plane`].
> +///
> +/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
> +#[repr(transparent)]
> +pub struct OpaquePlane<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 plane: Opaque<bindings::drm_plane>,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaquePlane<T> {}
> +
> +// SAFETY:
> +// * Via our type variants our data layout is identical to
> `drm_plane`
> +// * Since we don't expose `plane` to users before it has been
> initialized, this and our data
> +//=C2=A0=C2=A0 layout ensure that `as_raw()` always returns a valid poin=
ter to
> a `drm_plane`.
> +unsafe impl<T: KmsDriver> AsRawPlane for OpaquePlane<T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.plane.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane)=
 -> &'a
> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to
> `bindings::drm_plane`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: We only expose this object to users directly after
> KmsDriver::create_objects has been
> +// called.
> +unsafe impl<T: KmsDriver> ModesettablePlane for OpaquePlane<T> {
> +=C2=A0=C2=A0=C2=A0 type State =3D OpaquePlaneState<T>;
> +}
> +
> +// SAFETY: We don't expose OpaquePlane<T> to users before `base` is
> initialized in
> +// Plane::<T>::new(), so `raw_mode_obj` always returns a valid
> pointer to a
> +// bindings::drm_mode_object.
> +unsafe impl<T: KmsDriver> ModeObject for OpaquePlane<T> {
> +=C2=A0=C2=A0=C2=A0 type Driver =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn drm_dev(&self) -> &Device<Self::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: DRM planes exist f=
or as long as the device does,
> so this pointer is always valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 fn raw_mode_obj(&self) -> *mut bindings::drm_mode_obj=
ect {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We don't expose DR=
M planes to users before `base`
> is initialized
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &raw mut (*self.as_r=
aw()).base }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Planes do not have a refcount
> +unsafe impl<T: KmsDriver> StaticModeObject for OpaquePlane<T> {}
> +
> +// SAFETY: `funcs` is initialized when the plane is allocated
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaquePlane<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_plane_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to a
> plane
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fun=
cs
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Our plane interfaces are guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaquePlane<T> {}
> +unsafe impl<T: KmsDriver> Sync for OpaquePlane<T> {}
> +
> +/// A trait implemented by any type which can produce a reference to
> a [`struct drm_plane_state`].
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
> +pub trait AsRawPlaneState: private::AsRawPlaneState {
> +=C2=A0=C2=A0=C2=A0 /// The type that this plane state interface returns =
to
> represent the parent DRM plane
> +=C2=A0=C2=A0=C2=A0 type Plane: ModesettablePlane;
> +}
> +
> +pub(crate) mod private {
> +=C2=A0=C2=A0=C2=A0 /// Trait for retrieving references to the base plane=
 state
> contained within any plane state
> +=C2=A0=C2=A0=C2=A0 /// compatible type
> +=C2=A0=C2=A0=C2=A0 #[allow(unreachable_pub)]
> +=C2=A0=C2=A0=C2=A0 pub trait AsRawPlaneState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Return an immutable refer=
ence to the raw plane state
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings=
::drm_plane_state;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// Get a mutable reference t=
o the raw
> `bindings::drm_plane_state` contained within this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// type.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// The caller promises this =
mutable reference will not be
> used to modify any contents of
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// `bindings::drm_plane_stat=
e` which DRM would consider to
> be static - like the backpointer
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// to the DRM plane that own=
s this state. This also means
> the mutable reference should
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /// never be exposed outside =
of this crate.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut sel=
f) -> &mut
> bindings::drm_plane_state;
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +pub(crate) use private::AsRawPlaneState as AsRawPlaneStatePrivate;
> +
> +/// A trait implemented for any type which can be constructed
> directly from a
> +/// [`struct drm_plane_state`] pointer.
> +///
> +/// This is implemented internally by DRM.
> +///
> +/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
> +pub trait FromRawPlaneState: AsRawPlaneState {
> +=C2=A0=C2=A0=C2=A0 /// Get an immutable reference to this type from the =
given raw
> [`struct drm_plane_state`]
> +=C2=A0=C2=A0=C2=A0 /// pointer.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees `ptr` is contained within=
 a valid
> instance of `Self`
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` cannot not be =
modified
> for the lifetime of `'a`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_plane_state`]: srctree/include/drm/d=
rm_plane.h
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_plan=
e_state) ->
> &'a Self;
> +
> +=C2=A0=C2=A0=C2=A0 /// Get a mutable reference to this type from the giv=
en raw
> [`struct drm_plane_state`] pointer.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` is contained w=
ithin a
> valid instance of `Self`
> +=C2=A0=C2=A0=C2=A0 /// - The caller guarantees that `ptr` cannot have an=
y other
> references taken out for the
> +=C2=A0=C2=A0=C2=A0 ///=C2=A0=C2=A0 lifetime of `'a`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`struct drm_plane_state`]: srctree/include/drm/d=
rm_plane.h
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_pl=
ane_state)
> -> &'a mut Self;
> +}
> +
> +/// Common methods available on any type which implements
> [`AsRawPlane`].
> +///
> +/// This is implemented internally by DRM, and provides many of the
> basic methods for working with
> +/// the atomic state of [`Plane`]s.
> +pub trait RawPlaneState: AsRawPlaneState {
> +=C2=A0=C2=A0=C2=A0 /// Return the plane that this plane state belongs to=
.
> +=C2=A0=C2=A0=C2=A0 fn plane(&self) -> &Self::Plane {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The index is initi=
alized by the time we expose
> Plane objects to users, and is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // invariant throughout the l=
ifetime of the Plane
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Self::Plane::from_ra=
w(self.as_raw().plane) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the current [`OpaqueCrtc`] assigned to thi=
s plane, if
> there is one.
> +=C2=A0=C2=A0=C2=A0 fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b Opaque=
Crtc<D>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self::Plane: ModeObject<Drive=
r =3D D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: KmsDriver,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This cast is guara=
nteed safe by `OpaqueCrtc`s
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NonNull::new(self.as_raw().cr=
tc).map(|c| unsafe {
> OpaqueCrtc::from_raw(c.as_ptr()) })
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Run the atomic check helper for this plane and th=
e given
> CRTC state.
> +=C2=A0=C2=A0=C2=A0 fn atomic_helper_check<S, D>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crtc_state: &CrtcStateMutator=
<'_, S>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can_position: bool,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can_update_disabled: bool,
> +=C2=A0=C2=A0=C2=A0 ) -> Result
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: KmsDriver,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S: FromRawCrtcState,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S::Crtc: ModesettableCrtc + M=
odeObject<Driver =3D D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self::Plane: ModeObject<Drive=
r =3D D>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're passing the =
mutable reference from
> `self.as_raw_mut()` directly to DRM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // which is safe.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindi=
ngs::drm_atomic_helper_check_plane_state(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.as_raw_mut(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 crtc_state.as_raw(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bindings::DRM_PLANE_NO_SCALING as _, // TODO: add
> parameters for scaling
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bindings::DRM_PLANE_NO_SCALING as _,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 can_position,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 can_update_disabled,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the framebuffer currently set for this pla=
ne state
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 fn framebuffer<D>(&self) -> Option<&Framebuffer<D>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self::Plane: ModeObject<Drive=
r =3D D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: KmsDriver,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The layout of Fram=
ebuffer<T> is identical to `fb`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
as_raw()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .fb
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .as_ref()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .map(|fb| Framebuffer::from_raw(fb))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
> +
> +/// The main interface for a [`struct drm_plane_state`].
> +///
> +/// This type is the main interface for dealing with the atomic
> state of DRM planes. In addition, it
> +/// allows access to whatever private data is contained within an
> implementor's [`DriverPlaneState`]
> +/// type.
> +///
> +/// # Invariants
> +///
> +/// - The DRM C API and our interface guarantees that only the user
> has mutable access to `state`,
> +///=C2=A0=C2=A0 up until [`drm_atomic_helper_commit_hw_done`] is called.
> Therefore, `plane` follows rust's
> +///=C2=A0=C2=A0 data aliasing rules and does not need to be behind an
> [`Opaque`] type.
> +/// - `state` and `inner` initialized for as long as this object is
> exposed to users.
> +/// - The data layout of this structure begins with [`struct
> drm_plane_state`].
> +/// - The plane for this atomic state can always be assumed to be of
> type [`Plane<T::Plane>`].
> +///
> +/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +#[derive(Default)]
> +#[repr(C)]
> +pub struct PlaneState<T: DriverPlaneState> {
> +=C2=A0=C2=A0=C2=A0 state: bindings::drm_plane_state,
> +=C2=A0=C2=A0=C2=A0 inner: T,
> +}
> +
> +/// The main trait for implementing the [`struct drm_plane_state`]
> API for a [`Plane`].
> +///
> +/// A driver may store driver-private data within the implementor's
> type, which will be available
> +/// when using a full typed [`PlaneState`] object.
> +///
> +/// # Invariants
> +///
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_plane`] pointers are contained within a
> [`Plane<Self::Plane>`].
> +/// - Any C FFI callbacks generated using this trait are guaranteed
> that passed-in
> +///=C2=A0=C2=A0 [`struct drm_plane_state`] pointers are contained within=
 a
> [`PlaneState<Self>`].
> +///
> +/// [`struct drm_plane`]: srctree/include/drm_plane.h
> +/// [`struct drm_plane_state`]: srctree/include/drm_plane.h
> +pub trait DriverPlaneState: Clone + Default + Sized {
> +=C2=A0=C2=A0=C2=A0 /// The type for this driver's drm_plane implementati=
on
> +=C2=A0=C2=A0=C2=A0 type Plane: DriverPlane;
> +}
> +
> +impl<T: DriverPlaneState> Sealed for PlaneState<T> {}
> +
> +impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 type Plane =3D Plane<T::Plane>;
> +}
> +
> +impl<T: DriverPlaneState> private::AsRawPlaneState for PlaneState<T>
> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_plan=
e_state) ->
> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout starts wit=
h `bindings::drm_plane_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *const Self =3D ptr.=
cast();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires that `ptr` be contained
> within `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires the caller ensure that it
> is safe for us to take an
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 immutable refe=
rence.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_pl=
ane_state)
> -> &'a mut Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Our data layout starts wit=
h `bindings::drm_plane_state`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr: *mut Self =3D ptr.ca=
st();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires that `ptr` be contained
> within `Self`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our safety contract requ=
ires the caller ensure it is
> safe for us to take a mutable
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 reference.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &mut *ptr }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlaneState> Deref for PlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlaneState> DerefMut for PlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantee of Plane<T>'s vtable impl
> +unsafe impl<T: DriverPlaneState> ModeObjectVtable for PlaneState<T>
> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_plane_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.plane().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: DriverPlaneState> PlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <'a, D, P>(&'a OpaquePlane=
State<D>) -> &'a Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverPlaneState<Plane =3D P>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P as =
DriverPlane,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Plane =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A [`struct drm_plane_state`] without a known
> [`DriverPlaneState`] implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the
> [`DriverPlaneState`]
> +/// implementation for a [`struct drm_plane_state`] automatically.
> It is identical to [`Plane`],
> +/// except that it does not provide access to the driver's private
> data.
> +///
> +/// # Invariants
> +///
> +/// - The DRM C API and our interface guarantees that only the user
> has mutable access to `state`,
> +///=C2=A0=C2=A0 up until [`drm_atomic_helper_commit_hw_done`] is called.
> Therefore, `plane` follows rust's
> +///=C2=A0=C2=A0 data aliasing rules and does not need to be behind an
> [`Opaque`] type.
> +/// - `state` is initialized for as long as this object is exposed
> to users.
> +/// - The data layout of this structure is identical to [`struct
> drm_plane_state`].
> +///
> +/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
> +/// [`drm_atomic_helper_commit_hw_done`]:
> srctree/include/drm/drm_atomic_helper.h
> +#[repr(transparent)]
> +pub struct OpaquePlaneState<T: KmsDriver> {
> +=C2=A0=C2=A0=C2=A0 state: bindings::drm_plane_state,
> +=C2=A0=C2=A0=C2=A0 _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> AsRawPlaneState for OpaquePlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 type Plane =3D OpaquePlane<T>;
> +}
> +
> +impl<T: KmsDriver> private::AsRawPlaneState for OpaquePlaneState<T>
> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: KmsDriver> FromRawPlaneState for OpaquePlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw<'a>(ptr: *const bindings::drm_plan=
e_state) ->
> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to `ptr`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_pl=
ane_state)
> -> &'a mut Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layout is=
 identical to `ptr`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &mut *ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantee of OpaquePlane<T>'s vtable
> impl
> +unsafe impl<T: KmsDriver> ModeObjectVtable for OpaquePlaneState<T> {
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D bindings::drm_plane_funcs;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.plane().vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// An interface for mutating a [`Plane`]s atomic state.
> +///
> +/// This type is typically returned by an [`AtomicStateMutator`]
> within contexts where it is
> +/// possible to safely mutate a plane's state. In order to uphold
> rust's data-aliasing rules, only
> +/// [`PlaneStateMutator`] may exist at a time.
> +pub struct PlaneStateMutator<'a, T: FromRawPlaneState> {
> +=C2=A0=C2=A0=C2=A0 state: &'a mut T,
> +=C2=A0=C2=A0=C2=A0 mask: &'a Cell<u32>,
> +}
> +
> +impl<'a, T: FromRawPlaneState> PlaneStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 pub(super) fn new<D: KmsDriver>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutator: &'a AtomicStateMutat=
or<D>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state: NonNull<bindings::drm_=
plane_state>,
> +=C2=A0=C2=A0=C2=A0 ) -> Option<Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `plane` is invaria=
nt throughout the lifetime of
> the atomic state, is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initialized by this point,=
 and we're guaranteed it is of
> type `AsRawPlane` by type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // invariance
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let plane =3D unsafe {
> T::Plane::from_raw((*state.as_ptr()).plane) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let plane_mask =3D plane.mask=
();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let borrowed_mask =3D mutator=
.borrowed_planes.get();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if borrowed_mask & plane_mask=
 =3D=3D 0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutat=
or.borrowed_planes.set(borrowed_mask | plane_mask);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some(=
Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mask: &mutator.borrowed_planes,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed `state` is of
> `FromRawPlaneState` by type invariance,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // and we just confirmed by checking
> `borrowed_planes` that no other mutable borrows
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 // have been taken out for `state`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state: unsafe { T::from_raw_mut(state.as_ptr()) },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawPlaneState> Drop for PlaneStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mask =3D self.state.plane=
().mask();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.mask.set(self.mask.get()=
 & !mask);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawPlaneState> AsRawPlaneState for
> PlaneStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 type Plane =3D T::Plane;
> +}
> +
> +impl<'a, T: FromRawPlaneState> private::AsRawPlaneState for
> PlaneStateMutator<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> &bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.as_raw()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 unsafe fn as_raw_mut(&mut self) -> &mut
> bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This function is b=
ound by the same safety
> contract as `self.inner.as_raw_mut()`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { self.state.as_raw_mu=
t() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: FromRawPlaneState> Sealed for PlaneStateMutator<'a, T>
> {}
> +
> +impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a,
> PlaneState<T>> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.state.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a,
> PlaneState<T>> {
> +=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.state.inner
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// SAFETY: Shares the safety guarantees of `T`'s ModeObjectVtable
> impl
> +unsafe impl<'a, T: FromRawPlaneState> ModeObjectVtable for
> PlaneStateMutator<'a, T>
> +where
> +=C2=A0=C2=A0=C2=A0 T: FromRawPlaneState + ModeObjectVtable,
> +{
> +=C2=A0=C2=A0=C2=A0 type Vtable =3D T::Vtable;
> +
> +=C2=A0=C2=A0=C2=A0 fn vtable(&self) -> *const Self::Vtable {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.state.vtable()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: DriverPlaneState> PlaneStateMutator<'a, PlaneState<T>> {
> +=C2=A0=C2=A0=C2=A0 super::impl_from_opaque_mode_obj! {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn <D, P>(PlaneStateMutator<'=
a, OpaquePlaneState<D>>) ->
> Self
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: Dr=
iverPlaneState<Plane =3D P>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P as =
DriverPlane,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D as =
KmsDriver<Plane =3D ...>
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A token provided during [`atomic_check`] callbacks for accessing
> the plane, atomic state, and
> +/// the old and new states of the plane.
> +///
> +/// [`atomic_check`]: DriverPlane::atomic_check
> +pub struct PlaneAtomicCheck<'a, T: DriverPlane> {
> +=C2=A0=C2=A0=C2=A0 state: &'a AtomicStateComposer<T::Driver>,
> +=C2=A0=C2=A0=C2=A0 plane: &'a Plane<T>,
> +}
> +
> +impl<'a, T: DriverPlane> PlaneAtomicCheck<'a, T> {
> +=C2=A0=C2=A0=C2=A0 impl_atomic_state_token_ops!(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneAtomicCheck,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AtomicStateComposer,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Plane,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use <'a, T>
> +=C2=A0=C2=A0=C2=A0 );
> +}
> +
> +/// A token provided to [`DriverPlane`] callbacks during the atomic
> commit phase for accessing the
> +/// plane, atomic state, new and old states of the plane.
> +///
> +/// # Invariants
> +///
> +/// This token is proof that the old and new atomic state of `plane`
> are present in `state` and do
> +/// not have any mutators taken out.
> +pub struct PlaneAtomicCommit<'a, T: DriverPlane> {
> +=C2=A0=C2=A0=C2=A0 state: &'a AtomicStateMutator<T::Driver>,
> +=C2=A0=C2=A0=C2=A0 plane: &'a Plane<T>,
> +}
> +
> +impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
> +=C2=A0=C2=A0=C2=A0 impl_atomic_state_token_ops!(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PlaneAtomicCommit,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AtomicStateMutator,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Plane,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use <'a, T>
> +=C2=A0=C2=A0=C2=A0 );
> +}
> +
> +unsafe extern "C" fn plane_destroy_callback<T: DriverPlane>(plane:
> *mut bindings::drm_plane) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `plane` points to a va=
lid
> initialized `drm_plane`.
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_plane_cleanup(plane) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees we are now the only one with acce=
ss to this
> [`drm_plane`].
> +=C2=A0=C2=A0=C2=A0 // - This cast is safe via `DriverPlane`s type invari=
ants.
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { KBox::from_raw(plane as *mut Plane<T>) =
});
> +}
> +
> +unsafe extern "C" fn atomic_duplicate_state_callback<T:
> DriverPlaneState>(
> +=C2=A0=C2=A0=C2=A0 plane: *mut bindings::drm_plane,
> +) -> *mut bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `plane` points to a va=
lid
> initialized `drm_plane`.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*plane).state };
> +=C2=A0=C2=A0=C2=A0 if state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return null_mut();
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This cast is safe via `DriverPlaneState`s =
type
> invariants.
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { PlaneState::<T>::from_raw(stat=
e) };
> +
> +=C2=A0=C2=A0=C2=A0 let new: Result<KBox<_>> =3D KBox::try_init(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_init!(PlaneState {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inner=
: state.inner.clone(),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
: bindings::drm_plane_state {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ..Default::default()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL,
> +=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0 if let Ok(mut new) =3D new {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `new` provides a valid p=
ointer to a newly allocated
> `drm_plane_state` via type
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This initializes `new` v=
ia memcpy()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_plane_duplicate_state(plane,
> new.as_raw_mut()) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBox::into_raw(new).cast()
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null_mut()
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +unsafe extern "C" fn atomic_destroy_state_callback<T:
> DriverPlaneState>(
> +=C2=A0=C2=A0=C2=A0 _plane: *mut bindings::drm_plane,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_plane_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_plane_state`
> +=C2=A0=C2=A0=C2=A0 unsafe {
> bindings::__drm_atomic_helper_plane_destroy_state(state) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // * DRM guarantees we are the only one with access t=
o this
> `drm_plane_state`
> +=C2=A0=C2=A0=C2=A0 // * This cast is safe via our type invariants.
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { KBox::from_raw(state.cast::<PlaneState<=
T>>()) });
> +}
> +
> +unsafe extern "C" fn plane_reset_callback<T: DriverPlane>(plane:
> *mut bindings::drm_plane) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees that `state` points to a va=
lid
> instance of `drm_plane_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe { (*plane).state };
> +=C2=A0=C2=A0=C2=A0 if !state.is_null() {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `plane`=
 is `Plane<T>` via type
> invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're guaranteed `state`=
 is `PlaneState<T>` via type
> invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { atomic_destroy_state=
_callback::<T::State>(plane,
> state) }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: No special require=
ments here, DRM expects this to
> be NULL
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*pla=
ne).state =3D null_mut();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // Unfortunately, this is the best we can do at the m=
oment as
> this FFI callback was mistakenly
> +=C2=A0=C2=A0=C2=A0 // presumed to be infallible :(
> +=C2=A0=C2=A0=C2=A0 let new =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBox::new(PlaneState::<T::Sta=
te>::default(),
> GFP_KERNEL).expect("Blame the API, sorry!");
> +
> +=C2=A0=C2=A0=C2=A0 // DRM takes ownership of the state from here, resets=
 it, and
> then assigns it to the plane
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - DRM guarantees that `plane` points to a valid in=
stance of
> `drm_plane`.
> +=C2=A0=C2=A0=C2=A0 // - The cast to `drm_plane_state` is safe via `Plane=
State`s
> type invariants.
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::__drm_atomic_helper_plane_reset(pl=
ane,
> KBox::into_raw(new).cast()) };
> +}
> +
> +unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
> +=C2=A0=C2=A0=C2=A0 plane: *mut bindings::drm_plane,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `plane` is of type `Plane<T>` v=
ia type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `plane` is pointing=
 to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let plane =3D unsafe { Plane::from_raw(plane) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: DRM guarantees `state` points to a valid
> `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 let state =3D unsafe {
> AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic_update callback, we're=
 guaranteed
> by DRM that both the old and new
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 plane state are resent in this atomic =
state.
> +=C2=A0=C2=A0=C2=A0 // - We just created the state mutator above, so othe=
r mutators
> cannot be taken out on the plane
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 state yet.
> +=C2=A0=C2=A0=C2=A0 let commit =3D unsafe { PlaneAtomicCommit::new(plane,=
 &state) };
> +
> +=C2=A0=C2=A0=C2=A0 T::atomic_update(commit);
> +}
> +
> +unsafe extern "C" fn atomic_check_callback<T: DriverPlane>(
> +=C2=A0=C2=A0=C2=A0 plane: *mut bindings::drm_plane,
> +=C2=A0=C2=A0=C2=A0 state: *mut bindings::drm_atomic_state,
> +) -> i32 {
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed `plane` is of type `Plane<T>` v=
ia type
> invariants.
> +=C2=A0=C2=A0=C2=A0 // - We're guaranteed by DRM that `plane` is pointing=
 to a valid
> initialized state.
> +=C2=A0=C2=A0=C2=A0 let plane =3D unsafe { Plane::from_raw(plane) };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed by DRM that `state` point=
s to a
> valid instance of `drm_atomic_state`
> +=C2=A0=C2=A0=C2=A0 // We use ManuallyDrop here since AtomicStateComposer=
 would
> otherwise drop a owned reference to
> +=C2=A0=C2=A0=C2=A0 // the atomic state upon finishing this callback.
> +=C2=A0=C2=A0=C2=A0 let state =3D ManuallyDrop::new(unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> AtomicStateComposer::<T::Driver>::new(NonNull::new_unchecked(state))
> +=C2=A0=C2=A0=C2=A0 });
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0 // - Since we're in the atomic check callback, we're =
guaranteed
> by DRM that both the old and
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 new plane state are present in this at=
omic state
> +=C2=A0=C2=A0=C2=A0 // - We just created the state composer above, so oth=
er
> composers cannot be taken out on the
> +=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 plane state yet.
> +=C2=A0=C2=A0=C2=A0 let check =3D unsafe { PlaneAtomicCheck::new(plane, &=
state) };
> +
> +=C2=A0=C2=A0=C2=A0 from_result(|| T::atomic_check(check).map(|_| 0))
> +}
> diff --git a/rust/kernel/drm/kms/vblank.rs
> b/rust/kernel/drm/kms/vblank.rs
> new file mode 100644
> index 000000000000..dc34e02e8ccb
> --- /dev/null
> +++ b/rust/kernel/drm/kms/vblank.rs
> @@ -0,0 +1,461 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM KMS vblank support.
> +//!
> +//! C header:
> [`include/drm/drm_vblank.h`](srcfree/include/drm/drm_vblank.h)
> +
> +use super::{crtc::*, ModeObject, modes::*, Sealed};
> +use bindings;
> +use core::{
> +=C2=A0=C2=A0=C2=A0 marker::*,
> +=C2=A0=C2=A0=C2=A0 mem::{self, ManuallyDrop},
> +=C2=A0=C2=A0=C2=A0 ops::{Deref, Drop},
> +=C2=A0=C2=A0=C2=A0 ptr::null_mut,
> +};
> +use kernel::{
> +=C2=A0=C2=A0=C2=A0 drm::device::Device,
> +=C2=A0=C2=A0=C2=A0 error::{from_result, to_result},
> +=C2=A0=C2=A0=C2=A0 interrupt::LocalInterruptDisabled,
> +=C2=A0=C2=A0=C2=A0 prelude::*,
> +=C2=A0=C2=A0=C2=A0 time::Delta,
> +=C2=A0=C2=A0=C2=A0 types::Opaque,
> +};
> +
> +/// The main trait for a driver to implement hardware vblank support
> for a [`Crtc`].
> +///
> +/// # Invariants
> +///
> +/// C FFI callbacks generated using this trait can safely assume
> that input pointers to
> +/// [`struct drm_crtc`] are always contained within a
> [`Crtc<Self::Crtc>`].
> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +pub trait VblankSupport: Sized {
> +=C2=A0=C2=A0=C2=A0 /// The parent [`DriverCrtc`].
> +=C2=A0=C2=A0=C2=A0 type Crtc: VblankDriverCrtc<VblankImpl =3D Self>;
> +
> +=C2=A0=C2=A0=C2=A0 /// Enable vblank interrupts for this [`DriverCrtc`].
> +=C2=A0=C2=A0=C2=A0 fn enable_vblank(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crtc: &Crtc<Self::Crtc>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vblank_guard: &VblankGuard<'_=
, Self::Crtc>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq: &LocalInterruptDisabled,
> +=C2=A0=C2=A0=C2=A0 ) -> Result;
> +
> +=C2=A0=C2=A0=C2=A0 /// Disable vblank interrupts for this [`DriverCrtc`]=
.
> +=C2=A0=C2=A0=C2=A0 fn disable_vblank(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crtc: &Crtc<Self::Crtc>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vblank_guard: &VblankGuard<'_=
, Self::Crtc>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq: &LocalInterruptDisabled,
> +=C2=A0=C2=A0=C2=A0 );
> +
> +=C2=A0=C2=A0=C2=A0 /// Retrieve the current vblank timestamp for this [`=
Crtc`]
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If this function is being called from the driver'=
s vblank
> interrupt handler,
> +=C2=A0=C2=A0=C2=A0 /// `handling_vblank_irq` will be `true`.
> +=C2=A0=C2=A0=C2=A0 fn get_vblank_timestamp(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crtc: &Crtc<Self::Crtc>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_vblank_irq: bool,
> +=C2=A0=C2=A0=C2=A0 ) -> Option<VblankTimestamp>;
> +}
> +
> +/// Trait used for CRTC vblank (or lack there-of) implementations.
> Implemented internally.
> +///
> +/// Drivers interested in implementing vblank support should refer
> to [`VblankSupport`], drivers
> +/// that don't have vblank support can use [`PhantomData`].
> +pub trait VblankImpl {
> +=C2=A0=C2=A0=C2=A0 /// The parent [`DriverCrtc`].
> +=C2=A0=C2=A0=C2=A0 type Crtc: DriverCrtc<VblankImpl =3D Self>;
> +
> +=C2=A0=C2=A0=C2=A0 /// The generated [`VblankOps`].
> +=C2=A0=C2=A0=C2=A0 const VBLANK_OPS: VblankOps;
> +}
> +
> +/// C FFI callbacks for vblank management.
> +///
> +/// Created internally by DRM.
> +#[derive(Default)]
> +pub struct VblankOps {
> +=C2=A0=C2=A0=C2=A0 pub(crate) enable_vblank: Option<unsafe extern "C" fn=
(crtc: *mut
> bindings::drm_crtc) -> i32>,
> +=C2=A0=C2=A0=C2=A0 pub(crate) disable_vblank: Option<unsafe extern "C" f=
n(crtc:
> *mut bindings::drm_crtc)>,
> +=C2=A0=C2=A0=C2=A0 pub(crate) get_vblank_timestamp: Option<
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe extern "C" fn(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crtc:=
 *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_e=
rror: *mut i32,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vblan=
k_time: *mut bindings::ktime_t,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_vb=
lank_irq: bool,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) -> bool,
> +=C2=A0=C2=A0=C2=A0 >,
> +}
> +
> +impl<T: VblankSupport> VblankImpl for T {
> +=C2=A0=C2=A0=C2=A0 type Crtc =3D T::Crtc;
> +
> +=C2=A0=C2=A0=C2=A0 const VBLANK_OPS: VblankOps =3D VblankOps {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_vblank: Some(enable_vb=
lank_callback::<T>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_vblank: Some(disable_=
vblank_callback::<T>),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_vblank_timestamp:
> Some(get_vblank_timestamp_callback::<T>),
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +impl<T> VblankImpl for PhantomData<T>
> +where
> +=C2=A0=C2=A0=C2=A0 T: DriverCrtc<VblankImpl =3D PhantomData<T>>,
> +{
> +=C2=A0=C2=A0=C2=A0 type Crtc =3D T;
> +
> +=C2=A0=C2=A0=C2=A0 const VBLANK_OPS: VblankOps =3D VblankOps {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_vblank: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_vblank: None,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_vblank_timestamp: None,
> +=C2=A0=C2=A0=C2=A0 };
> +}
> +
> +unsafe extern "C" fn enable_vblank_callback<T: VblankSupport>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +) -> i32 {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed that `crtc` is of type
> `Crtc<T::Crtc>` by type invariants.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<T::Crtc>::from_raw(crtc)=
 };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This callback happens with IRQs disabled
> +=C2=A0=C2=A0=C2=A0 let irq =3D unsafe { LocalInterruptDisabled::assume_d=
isabled() };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This callback happens with `vbl_lock` alre=
ady held
> +=C2=A0=C2=A0=C2=A0 // We don't want to drop `vbl_lock` when this callbac=
k completes
> since DRM will do this for us,
> +=C2=A0=C2=A0=C2=A0 // so wrap the `VblankGuard` in a `ManuallyDrop`
> +=C2=A0=C2=A0=C2=A0 let vblank_guard =3D ManuallyDrop::new(unsafe {
> VblankGuard::new(crtc, irq) });
> +
> +=C2=A0=C2=A0=C2=A0 from_result(|| T::enable_vblank(crtc, &vblank_guard,
> irq).map(|_| 0))
> +}
> +
> +unsafe extern "C" fn disable_vblank_callback<T: VblankSupport>(crtc:
> *mut bindings::drm_crtc) {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed that `crtc` is of type
> `Crtc<T::Crtc>` by type invariants.
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<T::Crtc>::from_raw(crtc)=
 };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This callback happens with IRQs disabled
> +=C2=A0=C2=A0=C2=A0 let irq =3D unsafe { LocalInterruptDisabled::assume_d=
isabled() };
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: This call happens with `vbl_lock` already =
held
> +=C2=A0=C2=A0=C2=A0 // We don't want to drop `vbl_lock` when this callbac=
k completes
> since DRM will do this for us,
> +=C2=A0=C2=A0=C2=A0 // so wrap the `VblankGuard` in a `ManuallyDrop`
> +=C2=A0=C2=A0=C2=A0 let vblank_guard =3D ManuallyDrop::new(unsafe {
> VblankGuard::new(crtc, irq) });
> +
> +=C2=A0=C2=A0=C2=A0 T::disable_vblank(crtc, &vblank_guard, irq);
> +}
> +
> +unsafe extern "C" fn get_vblank_timestamp_callback<T:
> VblankSupport>(
> +=C2=A0=C2=A0=C2=A0 crtc: *mut bindings::drm_crtc,
> +=C2=A0=C2=A0=C2=A0 max_error: *mut i32,
> +=C2=A0=C2=A0=C2=A0 vblank_time: *mut bindings::ktime_t,
> +=C2=A0=C2=A0=C2=A0 in_vblank_irq: bool,
> +) -> bool {
> +=C2=A0=C2=A0=C2=A0 // SAFETY: We're guaranteed `crtc` is of type `Crtc<T=
::Crtc>` by
> type invariance
> +=C2=A0=C2=A0=C2=A0 let crtc =3D unsafe { Crtc::<T::Crtc>::from_raw(crtc)=
 };
> +
> +=C2=A0=C2=A0=C2=A0 if let Some(timestamp) =3D T::get_vblank_timestamp(cr=
tc,
> in_vblank_irq) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Both of these poin=
ters are guaranteed by the C
> API to be valid
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*max=
_error) =3D timestamp.max_error;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*vbl=
ank_time) =3D timestamp.time.as_nanos();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A vblank timestamp.
> +///
> +/// This type is used by [`VblankSupport::get_vblank_timestamp`] for
> the implementor to return the
> +/// current vblank timestamp for the hardware.
> +#[derive(Copy, Clone)]
> +pub struct VblankTimestamp {
> +=C2=A0=C2=A0=C2=A0 /// The actual vblank timestamp in nanoseconds, accur=
acy to
> within [`Self::max_error`]
> +=C2=A0=C2=A0=C2=A0 /// nanoseconds.
> +=C2=A0=C2=A0=C2=A0 pub time: Delta,
> +
> +=C2=A0=C2=A0=C2=A0 /// Maximum allowable timestamp error in nanoseconds
> +=C2=A0=C2=A0=C2=A0 pub max_error: i32,
> +}
> +
> +/// A trait for [`DriverCrtc`] implementations with hardware vblank
> support.
> +///
> +/// This trait is implemented internally by DRM for any
> [`DriverCrtc`] implementation that
> +/// implements [`VblankSupport`]. It is used to expose hardware-
> vblank driver exclusive methods and
> +/// data to users.
> +pub trait VblankDriverCrtc: DriverCrtc {}
> +
> +impl<T, V> VblankDriverCrtc for T
> +where
> +=C2=A0=C2=A0=C2=A0 T: DriverCrtc<VblankImpl =3D V>,
> +=C2=A0=C2=A0=C2=A0 V: VblankSupport<Crtc =3D T>,
> +{
> +}
> +
> +impl<T: VblankDriverCrtc> Crtc<T> {
> +=C2=A0=C2=A0=C2=A0 /// Retrieve a reference to the [`VblankCrtc`] for th=
is
> [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn vblank_crtc(&self) -> &VblankCrtc<T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - The data layouts of thes=
e types are equivalent via
> `VblankCrtc`s type invariants
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We don't expose any way =
of calling `vblank_crtc()`
> before `drm_vblank_init()` has been
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 called.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { VblankCrtc::from_raw=
(self.get_vblank_ptr()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Access vblank related infrastructure for a [`Crtc=
`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function explicitly locks the device's vblan=
k lock, and
> allows access to controlling
> +=C2=A0=C2=A0=C2=A0 /// the vblank configuration for this CRTC. The lock =
is dropped
> once [`VblankGuard`] is
> +=C2=A0=C2=A0=C2=A0 /// dropped.
> +=C2=A0=C2=A0=C2=A0 pub fn vblank_lock<'a>(&'a self, irq: &'a
> LocalInterruptDisabled) -> VblankGuard<'a, T> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `vbl_lock` is init=
ialized for as long as `Crtc`
> is available to users
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: We just acquire=
d `vbl_lock`, fulfilling the
> invariants of `VblankGuard`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::spin_lock(=
&raw mut
> (*self.drm_dev().as_raw()).vbl_lock) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just acquired v=
bl_lock above
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { VblankGuard::new(sel=
f, irq) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Trigger a vblank event on this [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Drivers should use this in their vblank interrupt=
 handlers
> to update the vblank counter and
> +=C2=A0=C2=A0=C2=A0 /// send any signals that may be pending.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns whether or not the vblank event was handl=
ed.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn handle_vblank(&self) -> bool {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to an
> initialized drm_crtc.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_h=
andle_vblank(self.as_raw()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Forbid vblank events for a [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function disables vblank events for a [`Crtc=
`], even if
> [`VblankRef`] objects exist.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn vblank_off(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to an
> initialized drm_crtc.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_v=
blank_off(self.as_raw()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Allow vblank events for a [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This function allows users to enable vblank event=
s and
> acquire [`VblankRef`] objects again.
> +=C2=A0=C2=A0=C2=A0 #[inline]
> +=C2=A0=C2=A0=C2=A0 pub fn vblank_on(&self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `as_raw()` always =
returns a valid pointer to an
> initialized drm_crtc.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_v=
blank_on(self.as_raw()) }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Enable vblank events for a [`Crtc`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// Returns a [`VblankRef`] which will allow vblank e=
vents to be
> sent until it is dropped. Note
> +=C2=A0=C2=A0=C2=A0 /// that vblank events may still be disabled by
> [`Self::vblank_off`].
> +=C2=A0=C2=A0=C2=A0 #[must_use =3D "Vblanks are only enabled until the re=
sult from
> this function is dropped"]
> +=C2=A0=C2=A0=C2=A0 pub fn vblank_get(&self) -> Result<VblankRef<'_, T>> =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VblankRef::new(self)
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// Common methods available on any [`CrtcState`] whose [`Crtc`]
> implements [`VblankSupport`].
> +///
> +/// This trait is implemented automatically by DRM for any
> [`DriverCrtc`] implementation that
> +/// implements [`VblankSupport`].
> +pub trait RawVblankCrtcState: AsRawCrtcState {
> +=C2=A0=C2=A0=C2=A0 /// Return the [`PendingVblankEvent`] for this CRTC s=
tate, if
> there is one.
> +=C2=A0=C2=A0=C2=A0 fn get_pending_vblank_event(&mut self) ->
> Option<PendingVblankEvent<'_, Self>>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: Sized,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The driver is the =
only one that will ever modify
> this data, and since our
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // interface follows rust's d=
ata aliasing rules that means
> this is safe to read
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let event_ptr =3D unsafe { *s=
elf.as_raw() }.event;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!event_ptr.is_null()).then_s=
ome(PendingVblankEvent(self))
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T, C> RawVblankCrtcState for T
> +where
> +=C2=A0=C2=A0=C2=A0 T: AsRawCrtcState<Crtc =3D Crtc<C>>,
> +=C2=A0=C2=A0=C2=A0 C: VblankDriverCrtc,
> +{
> +}
> +
> +/// A pending vblank event from an atomic state
> +pub struct PendingVblankEvent<'a, T: RawVblankCrtcState>(&'a mut T);
> +
> +impl<'a, T: RawVblankCrtcState> PendingVblankEvent<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Send this [`PendingVblankEvent`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A [`PendingVblankEvent`] can only be sent once, s=
o this
> function consumes the
> +=C2=A0=C2=A0=C2=A0 /// [`PendingVblankEvent`].
> +=C2=A0=C2=A0=C2=A0 pub fn send<C>(self)
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: RawVblankCrtcState<Crtc =
=3D Crtc<C>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: VblankDriverCrtc,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let crtc: &Crtc<C> =3D self.0=
.crtc();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let event_lock =3D crtc.drm_d=
ev().event_lock();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _guard =3D event_lock.loc=
k();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We now hold the appropri=
ate lock to call this function
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Vblanks are enabled as p=
roved by `vbl_ref`, as per the
> C api requirements
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our interface is proof t=
hat `event` is non-null
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_s=
end_vblank_event(crtc.as_raw(),
> (*self.0.as_raw()).event) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The mutable refere=
nce in `self.state` is proof
> that it is safe to mutate this,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // and DRM expects us to set =
this to NULL once we've sent
> the vblank event.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.0.as_raw()).e=
vent =3D null_mut() };
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Arm this [`PendingVblankEvent`] to be sent later =
by the
> CRTC's vblank interrupt handler.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// A [`PendingVblankEvent`] can only be armed once, =
so this
> function consumes the
> +=C2=A0=C2=A0=C2=A0 /// [`PendingVblankEvent`]. As well, it requires a [`=
VblankRef`]
> so that vblank interrupts
> +=C2=A0=C2=A0=C2=A0 /// remain enabled until the [`PendingVblankEvent`] h=
as been
> sent out by the driver's vblank
> +=C2=A0=C2=A0=C2=A0 /// interrupt handler.
> +=C2=A0=C2=A0=C2=A0 pub fn arm<C>(self, vbl_ref: VblankRef<'_, C>)
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: RawVblankCrtcState<Crtc =
=3D Crtc<C>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: VblankDriverCrtc,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let crtc: &Crtc<C> =3D self.0=
.crtc();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let event_lock =3D crtc.drm_d=
ev().event_lock();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _guard =3D event_lock.loc=
k();
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We now hold the appropri=
ate lock to call this function
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Vblanks are enabled as p=
roved by `vbl_ref`, as per the
> C api requirements
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our interface is proof t=
hat `event` is non-null
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_a=
rm_vblank_event(crtc.as_raw(),
> (*self.0.as_raw()).event) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The mutable refere=
nce in `self.state` is proof
> that it is safe to mutate this,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // and DRM expects us to set =
this to NULL once we've armed
> the vblank event.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.0.as_raw()).e=
vent =3D null_mut() };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DRM took ownership of `vbl=
_ref` after we called
> `drm_crtc_arm_vblank_event`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem::forget(vbl_ref);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// A borrowed vblank reference.
> +///
> +/// This object keeps the vblank reference count for a [`Crtc`]
> incremented for as long as it
> +/// exists, enabling vblank interrupts for said [`Crtc`] until all
> references are dropped, or
> +/// [`Crtc::vblank_off`] is called - whichever comes first.
> +pub struct VblankRef<'a, T: VblankDriverCrtc>(&'a Crtc<T>);
> +
> +impl<T: VblankDriverCrtc> Drop for VblankRef<'_, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: as_raw() returns a=
 valid pointer to an
> initialized drm_crtc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_crtc_v=
blank_put(self.0.as_raw()) };
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<'a, T: VblankDriverCrtc> VblankRef<'a, T> {
> +=C2=A0=C2=A0=C2=A0 fn new(crtc: &'a Crtc<T>) -> Result<Self> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: as_raw() returns a=
 valid pointer to an
> initialized drm_crtc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> bindings::drm_crtc_vblank_get(crtc.as_raw()) })?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self(crtc))
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +/// The base wrapper for [`drm_vblank_crtc`].
> +///
> +/// Users will rarely interact with this object directly, it is a
> simple wrapper around
> +/// [`drm_vblank_crtc`] which provides access to methods and data
> that is not protected by a lock.
> +///
> +/// # Invariants
> +///
> +/// This type has an identical data layout to [`drm_vblank_crtc`].
> +///
> +/// [`drm_vblank_crtc`]: srctree/include/drm/drm_vblank.h
> +#[repr(transparent)]
> +pub struct VblankCrtc<T>(Opaque<bindings::drm_vblank_crtc>,
> PhantomData<T>);
> +
> +impl<T: VblankDriverCrtc> VblankCrtc<T> {
> +=C2=A0=C2=A0=C2=A0 pub(crate) fn as_raw(&self) -> *mut bindings::drm_vbl=
ank_crtc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.get()
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 // SAFETY: The caller promises that `ptr` points to a=
 valid
> instance of
> +=C2=A0=C2=A0=C2=A0 // `bindings::drm_vblank_crtc`, and that access to th=
is
> structure has been properly serialized
> +=C2=A0=C2=A0=C2=A0 pub(crate) unsafe fn from_raw<'a>(ptr: *mut
> bindings::drm_vblank_crtc) -> &'a Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Our data layouts a=
re identical via
> #[repr(transparent)]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Returns the [`Device`] for this [`VblankGuard`]
> +=C2=A0=C2=A0=C2=A0 pub fn drm_dev(&self) -> &Device<T::Driver> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm` is initializ=
ed, invariant and valid
> throughout our lifetime
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_raw((*s=
elf.as_raw()).dev) }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +// NOTE: This type does not use a `Guard` because the mutex is not
> contained within the same
> +// structure as the relevant CRTC
> +/// An interface for accessing and controlling vblank related state
> for a [`Crtc`].
> +///
> +/// This type may be returned from some [`VblankSupport`] callbacks,
> or manually via
> +/// [`Crtc::vblank_lock`]. It provides access to methods and data
> which require
> +/// [`drm_device.vbl_lock`] be held.
> +///
> +/// # Invariants
> +///
> +/// - [`drm_device.vbl_lock`] is acquired whenever an instance of
> this type exists.
> +/// - Shares the invariants of [`VblankCrtc`].
> +///
> +/// [`drm_device.vbl_lock`]: srctree/include/drm/drm_device.h
> +#[repr(transparent)]
> +pub struct VblankGuard<'a, T: VblankDriverCrtc>(&'a VblankCrtc<T>);
> +
> +impl<'a, T: VblankDriverCrtc> VblankGuard<'a, T> {
> +=C2=A0=C2=A0=C2=A0 /// Construct a new [`VblankGuard`]
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The caller must have already acquired
> [`drm_device.vbl_lock`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// [`drm_device.vbl_lock`]: srctree/include/drm/drm_=
device.h
> +=C2=A0=C2=A0=C2=A0 pub(crate) unsafe fn new(crtc: &'a Crtc<T>, _irq: &'a
> LocalInterruptDisabled) -> Self {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: The caller prom=
ises that we've acquired
> `vbl_lock`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(crtc.vblank_crtc())
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Returns the duration of a single scanout frame in=
 ns.
> +=C2=A0=C2=A0=C2=A0 pub fn frame_duration(&self) -> i32 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We hold the approp=
riate lock for this read via
> our type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *self.as_raw() }.fra=
medur_ns
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /// Return the vblank core's cached copy of the curre=
ntly set
> display mode.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// If the display is disabled, this will return `Non=
e`.
> +=C2=A0=C2=A0=C2=A0 pub fn hwmode(&self) -> Option<&DisplayMode> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We hold the approp=
riate lock for this read via
> our type invariants.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr =3D unsafe { &raw con=
st (*self.as_raw()).hwmode };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We check here if t=
he cached DisplayMode is Null,
> which means the only other
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // possibility is that the po=
inter points to a valid
> initialized drm_display_mode.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!ptr.is_null()).then(|| unsa=
fe { DisplayMode::as_ref(ptr)
> })
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: VblankDriverCrtc> Deref for VblankGuard<'_, T> {
> +=C2=A0=C2=A0=C2=A0 type Target =3D VblankCrtc<T>;
> +
> +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +impl<T: VblankDriverCrtc> Drop for VblankGuard<'_, T> {
> +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We acquired this spinloc=
k when creating this object
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This lock is guaranteed =
to be initialized for as long
> as our DRM device is exposed to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 users.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::spin_unloc=
k(&raw mut
> (*self.drm_dev().as_raw()).vbl_lock) }
> +=C2=A0=C2=A0=C2=A0 }
> +}

