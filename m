Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82339CD6E4C
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 23:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986A610E246;
	Sat, 30 May 2026 23:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e2jGAnQe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D102E10E246
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 23:51:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD03160008;
 Sat, 30 May 2026 23:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B439F1F00893;
 Sat, 30 May 2026 23:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780185074;
 bh=e97dhm3DCmMHdKubUBMsoeKxwBZGTs6HbLhBOat2oK4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=e2jGAnQeoK/T+UeqD4gy0FuvMwzHtX9YDHdJXgPWYTEe06JqylKqsBLTRvhxpAyIb
 VYbB1+oGYwnfH++8wQ9uU7tHN8/aDSUhmn0kuR8/H/UjPpd8bqdEr2Kikp5fX7fIwJ
 9uEpD1Igmfxco4bqgqVjKEONJOZuQZOUj0g8p6BbSi/Bkw9uBmocJjVWTGwDwwvW6T
 jJaDaR8CmVxTlhKkgXCGAvujzkNgwnMUZSOukVDOBkszTWwV4hpVOAOWNy20vrBLR1
 O/LqRaKynKcMSHCaXcgkPrc+SXyNESzyW/cTeb38Bq8QQ4AU2ChrIUreBoBAjRcCWj
 fghrPhO9IStyA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 01:51:08 +0200
Message-Id: <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
Cc: <markus.probst@posteo.de>, "Rob Herring" <robh@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst via B4 Relay" <devnull+markus.probst.posteo.de@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
In-Reply-To: <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
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

On Sun May 31, 2026 at 12:51 AM CEST, Markus Probst via B4 Relay wrote:
> +#[pinned_drop]
> +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let mut active =3D self.active.lock();
> +        if *active {
> +            // SAFETY:
> +            // - We have exclusive access to `self.driver`.
> +            // - `self.driver` is guaranteed to be initialized.
> +            unsafe { (*self.driver.get()).assume_init_drop() };
> +            *active =3D false;
> +        }
> +
> +        // SAFETY: We have exclusive access to `self.open`.
> +        if unsafe { *self.open.get() } {
> +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> +            // `struct serdev_device`.
> +            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) }=
;
> +        }
> +    }
> +}

Just in case it came across otherwise, I did not mean to push for you to go=
 for
this approach. We just kept discussing it because it let to the (to me more
interesting) discussion around the LED class device abstraction.

While this approach gets us rid of an extra allocation and the rust_private=
_data
pointer in struct serdev_device it also turns out a bit more convoluted.

That said, both are correct, and I won't object either one; up to you and t=
he
serdev / tty maintainers.

Please wait a bit before resending, so other people can comment on this as =
well.

> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };

CoreInternal snuck back in, should be BoundInternal.

> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +        let active =3D private_data.active.lock();

I think SRCU would be a much better fit, but the code didn't land yet, so t=
he
mutex seems fine for now. But I'd probably add a TODO.

> +
> +        if !*active {
> +            return length;
> +        }
> +
> +        // SAFETY: No one has exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY:
> +        // - `private_data.driver` is pinned.
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
> +        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        T::receive(sdev, data_pinned, buf)
> +    }
> +}
