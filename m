Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A0BFF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA2310F0F8;
	Thu, 30 Apr 2026 14:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gYi//yM3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232B510F0F8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:19:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5012360142;
 Thu, 30 Apr 2026 14:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBF8C2BCB3;
 Thu, 30 Apr 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777558756;
 bh=5o4/RYDMXlLNCBj69ZCaFVM5lxPQdfnoE8Au8ur3foQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=gYi//yM3z82fLfcFpV/AAM2QKPEZy1kWDD6e2P1LTjCm5H3PsPyUKmMnRm1UIoJqE
 l2zPZjA9l3eHf3mHkObl3xldS3uvki2tQ30NDiSPGYYaVz/t66Gzm5Sh+Q/AryuNpJ
 A6CM/DdmTsOW2Em3/roqEXg6irns8GcBlVZSpJdywfnSF0MbJ1bSwe5D6eXX+k9OUj
 ewYbiz9F9V/a5I91i/M+ZteVBNfPMxHQQ8mFc1+Cnwsn4/DlVnlEVoFgPvPMVckjsV
 WAbsia1Pt/6A+so7A8kAqKYtXdxV6r/uNK9RzoMLKAD/gGmPkSnVrpjrWPcszuADfV
 t+9LxFpNbJHmw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 16:19:10 +0200
Message-Id: <DI6JZKW4N7VD.3B3233F8PNOMU@kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org> <afMaAfcxpDR3xIE1@google.com>
In-Reply-To: <afMaAfcxpDR3xIE1@google.com>
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

On Thu Apr 30, 2026 at 10:59 AM CEST, Alice Ryhl wrote:
> Is this really Rust-specific? Would you not want C drivers with the same
> pattern to do the same thing?

Unlike in C, it has the effect that it allows us to let the compiler ensure=
 that
the initilization order in probe() is correct.

The only advantage I see in C is that it provides a dedicated place for dri=
vers
to differentiate specific private data for when a driver registers multiple
auxiliary devices per instance.

>> +        // SAFETY: `ptr` is non-null and was set via `into_foreign()` i=
n `Registration::new()`;
>> +        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset =
0, so reading a `TypeId`
>> +        // at the start of the allocation is valid regardless of `T`.
>> +        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
>> +        if type_id !=3D TypeId::of::<T>() {
>> +            return Err(EINVAL);
>> +        }
>
> Right, okay, so if you put C stuff there, we need the layout to be
> compatible with Rust type ids.

Correct.

> Still, we could have Rust expose a couple methods to allow C code to use
> the same field with a null type id.

I think there are multiple options, e.g. two registration data pointers, on=
e
common pointer and a boolean, one common pointer, plus a type id pointer, e=
tc.

> But I guess this is all future work.

Yes, I rather do that once we actually need it.

>> +        let data =3D KBox::pin_init::<Error>(
>> +            try_pin_init!(RegistrationData {
>> +                type_id: TypeId::of::<T>(),
>> +                data <- data,
>> +            }),
>> +            GFP_KERNEL,
>> +        )?;
>> +
>> +        let boxed =3D KBox::new(Opaque::<bindings::auxiliary_device>::z=
eroed(), GFP_KERNEL)?;
>
> Use __GFP_ZERO here instead?

This is just moving existing code, but I guess we could add something like:

	pub fn zeroed(flags: Flags) -> Result<Self, AllocError>
	where
	    T: Zeroable,
	{
	    // SAFETY: `__GFP_ZERO` guarantees the memory is zeroed, and `T: Zeroa=
ble` guarantees
	    // that all-zeroes is a valid bit pattern for `T`.
	    Ok(unsafe { Self::new_uninit(flags | __GFP_ZERO)?.assume_init() })
	}

>> +        // SAFETY:
>> +        // - `adev` is guaranteed to be a valid pointer to a `struct au=
xiliary_device`, which
>> +        //   has been initialized,
>> +        // - `modname.as_char_ptr()` is a NULL terminated string.
>> +        let ret =3D unsafe { bindings::__auxiliary_device_add(adev, mod=
name.as_char_ptr()) };
>> +        if ret !=3D 0 {
>> +            // SAFETY: `registration_data` was set above via `into_fore=
ign()`.
>> +            let _ =3D unsafe {
>> +                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).=
registration_data_rust)
>> +            };
>
> Nit: Please use `drop(unsafe { ... })` to explicitly drop.

Same here, just moving existing code, but I think it's fine to change while=
 at
it.
