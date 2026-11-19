Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72322606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T98eRA2a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931A910E34A;
	Thu, 19 Nov 2026 11:50:14 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE1D112310
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:50:08 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1330111f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795089007; cv=none;
 d=google.com; s=arc-20260327;
 b=Zs3qW+yGJLapgf7ukYlnHnmKyZzaUNwqUOvVPB7sPBPFlyhaRdCLQJg+5rExjFfH5d
 v90xjSTrbqgi9n3VJ8z04XutyjlLDQUD5Q/paQj5m8UoY/mAQ9pyRAXdAB74mMn06Naw
 woiGIupoQ4hTsr4+3z6/aaOE8DIHhxdlitnF/q595Xc0kkNbaUJe3DNOofK7W66dgmws
 BDv26UuOgBClMpiFBeMzX8KHeVSOeeUWnpI7EAuI/dcOfjl0nMwAlbF1kO8FSve4ObvK
 a+iPKy1Ndr+fIUcPQndJR85XtIYP/NTb29B5J8HGDArYudb8nDLU0/wjTh0AqpIZL/z2
 +Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zOO8IN3WTwfTWmmyHCF/uCzTotxA10dmHaLxKg4Nq4E=;
 fh=yYKepYoD08k5Bp9sZg6kCkd8SFPEK/bhqTD/rYr5ago=;
 b=sV98d45stUN3XYsQ0TFRz8ZUdIsRNohtzaG4pxUFAmeSsfSReWO2GBHa14Z+l6x/oI
 A6Zuko9fHQzzsLiJ5uStKzyews5OA2n+7uoii0nHiZGR3gPP1eC/CHp2Mvr9HrWKbOs+
 5puaU5QYm/4s6muKtXixk23eIp+5akMDEpviycEGWg1FvMHvOB75DZ3uMyzGwAhR5e2P
 WEa0qHo/s830vIGtiRTDvgAJb33SC9UVayvEpCICyGGzKL3lHF2Y88n82u6XIz0w+amf
 i0nBeLh2i7//9SM9ZKUUr0y/QUUFhRf0MpTU+ioh1OFbQ8HDMecnvGE5BGzqwi83N69X
 9OxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795089007; x=1795693807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zOO8IN3WTwfTWmmyHCF/uCzTotxA10dmHaLxKg4Nq4E=;
 b=T98eRA2amqmtqUEEW4sAA25CJZ1C14joc7I1Yj+7upVPyXioi7tliVCz9i2688rtsE
 IlxjRJYpLeFbVOTjyMG8PltBK4ZWd+0tsxnna+9dodyO8uJ1PBMomFpzvYx3EK/0GJZQ
 DZ09s3wMlN896LpeMYeJbFiuS188aW8MuVYBDkLTJFL61sx5Xj6klKOOtyJuY2N0072y
 W8Xaxyp/OumJJZT2xQQw8jVrQbAeCHF+r7/NMtyhreklnGXyjWlNJn2nAZ1Wxddpw+9P
 VJMCheXB7hAUJtHtlXJLBvrN6Tam5Uua9m89mdSmIQpq5Ws3ldSGoUdZp+z28PXI2JGw
 Fzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795089007; x=1795693807;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zOO8IN3WTwfTWmmyHCF/uCzTotxA10dmHaLxKg4Nq4E=;
 b=iFXE+ZzJQw88LBkGZ8qQejooVkY09JuJ6Vi6Oi5BirhLFcfgWv/CMs724leMwyx0CP
 jW0/PRYt00VvUprBPMOatF/eucOXdfD5VHaqfXe1nzdzKCsylcwudDxIch4NuHYP8LqQ
 Zqs3tVqFFgXCFhkYzhdY5mvAsmOc/kV26m8iUghRIBo6VWM8P7P9cUr76Cb+JggkIsaR
 DX77t6pWLHdvg7O8XrJcpFACRHIFvfQXs4dPbFd2vVdGGeeV3TUXToG2sHyYUk1DsqED
 ElNTWLyANGNJk5IuElDvbjgI6fY6ip1ifAh/uhdbTLORjGmbSNyNBz9KH9nPaaoQjqu5
 uCyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGXFBi0brtkObHky0NwfvIJdtBZSoxkcLQ8zX7SKU5VqDyZYCfxrXX1QBH7m2yWjR/HWQIfEpAbGTs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80EdBsktIbu5RVSuydJbbjQVAghK1sTltSd7exLXMbX++p5d+v
 1jGD/hP0f59wMbjp3z92mRi603DgllI82GeTSoic2RTgygyCygP6TuiRZbOJJH6j2rt3HF5cmzK
 Rtbhpm16TipJUE9TiPfRQnfMoaczLDijK3KDgdDXW
X-Gm-Gg: AZFdTZegSlYpX+8iiLHpj8jYgLAKVCnhgCgZRmSUg0WmI4OZEpqbV+pyzI5ziXdFkoO
 4jRhNo52BSlSrNkqkNlJdzVclBDifQxw80Vx7fJcVuhJKt4SWNAG0fhhsxVTfhYLIsJzYbYEpHp
 szKau9vTnMUMyDT4WOpHAW/o7sQ4UJqMPvcCs8ZPLTNKsTD0SiPIwwAyWaMOSG3IdG3UpsxMiJp
 Jcamz4VnkqAZPctEVFpDZ4HNuEC2Q1KnU+goYJdVn92zUwyihlvuSCPZwq4or6R4A6zX6de5TFc
 tm/XA7VaP+j4VcHoM3P+JIoqtV9I+gNmhTbKjNgWEurZ7GdXzMKrUNs2homK2bOaK6Nzq9SH5xK
 0J1KGi35JMMVNnJwOGaKx3kkoefXKRTZY3i0bp56XS5QgJXhsHnKchbhiRxRMI3AMd5KqLWk22z
 /w9LF7dnTL6dyTngW0GIibtOaHuT8gX2c8xsYLrzPNJZo+
X-Received: by 2002:adf:e183:0:b0:4aa:8de6:6648 with SMTP id
 ffacd0b85a97d-4aa8de66db5mr1569581f8f.45.1795089006191; Thu, 19 Nov 2026
 03:50:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118181245.2583303-1-dakr@kernel.org>
 <20261119111746.3049044-1-aliceryhl@google.com>
 <DMZ5ER6XTNLG.2ZJOF7F4100XW@garyguo.net>
In-Reply-To: <DMZ5ER6XTNLG.2ZJOF7F4100XW@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Nov 2026 12:49:53 +0100
X-Gm-Features: Aa3M54oh8HJOrpuOfJ-i5QqnZtSXVPWrGr-cWZKRejJI37TjGzDfWl8zYFwePng
Message-ID: <CAH5fLghc63zD9c1F437pQiX+ohgSkYQe4nt3xP4gSTsqAVLzBA@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com, simona@ffwll.ch, 
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 12:25=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu Nov 19, 2026 at 11:17 AM GMT, Alice Ryhl wrote:
> > On Wed, Nov 18, 2026 at 07:07:35PM +0100, Danilo Krummrich wrote:
> >> Driver::Data is owned by the reference-counted drm::Device and can
> >> outlive device unregistration and driver unbind. Driver state belongs =
in
> >> RegistrationData, whose lifetime ends with registration teardown.
> >>
> >> The intended model is that, after drm_dev_unplug(), surviving DRM
> >> objects (e.g. through remaining userspace handles) no longer require
> >> access to the driver state. Thus Driver::RegistrationData is available
> >> (and sufficient) for all DRM callbacks into the driver.
> >>
> >> Remove Driver::Data, its storage and Deref implementation, and the
> >> unused workqueue implementations that depend on it. Drop the data
> >> initializer argument from UnregisteredDevice::new() and update its
> >> callers.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> > Makes sense to me. Both in-tree users had `type Data =3D ()` anyway, an=
d
> > nothing uses the `WorkItem`/`HasWork` impls on `drm::Device`, so this i=
s
> > a pure simplification.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > One small suggestion below.
> >
> >> -        release: Some(Device::<T>::release),
> >> +        release: None,
> >
> > [...]
> >
> >>  #[repr(C)]
> >>  pub struct Device<T: drm::Driver, C: DeviceContext =3D Normal> {
> >>      dev: Opaque<bindings::drm_device>,
> >> -    data: T::Data,
> >>      pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationD=
ata<'static>>>,
> >>      _ctx: PhantomData<C>,
> >>  }
> >
> > With `release` gone, nothing ever runs `drop_in_place()` on the Rust
> > side of `Device` anymore. That's fine today since all remaining fields
> > are trivially droppable, but it is now an implicit requirement on the
> > struct: anyone adding a field with a `Drop` impl (or a pinned field
> > that needs a destructor) would silently leak it.
> >
> > Could you add a short comment on the struct along the lines of "no
> > `release` callback is installed, so no field of this struct may require
> > dropping"? That way the next person adding a field knows they have to
> > bring back the `release` callback.
> >
> > (For what it's worth, I checked the lifetime-parameterized `File`
> > series [1] against this: `open_count`/`open_count_wq` are both
> > droppable without a destructor, and the two merge cleanly, so no
> > ordering constraint there as far as I can tell.)
>
> Instead of a comment, a const assertion of !needs_drop would be better.

Good idea

Alice
