Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C00CD98F0
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E174210EE83;
	Thu, 18 Jun 2026 23:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q2dzy2hf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2F210F41D
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 23:21:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DF9F43A5D;
 Thu, 18 Jun 2026 23:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FC91F000E9;
 Thu, 18 Jun 2026 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781824904;
 bh=txrxyKqh1nkGTyqlPvrZjtxqAPwO7M4NETjLRFyZSsI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q2dzy2hf3svlIQeaFx96Xg7OuvCABnaNjPH0bfthhl98UU+sBzuAdNooyym9tv+TS
 TChCWCozskVEQ+KOH54Del1TvERNqP2ONO3zAZDEDXLt2TuR7P2LW8ZFBXPJA1JncT
 FBNSCi/SmQTIKomxnocV9KJRIpj30twpZI+STsPr4/0tEgiUgbLmgKb71i5FiVNxzs
 zmAm2rbtBtId7bGz3LWgAncomUD0yyI5BJsTKM1ucBO1HLnmfdHN/52vLmhFwnnXV6
 h0mHEybzYDTwbTD8ixvdpL+EsvCOfDzKVXTa8ybluKr36ei0QxzYC8aefLMfGXEzo3
 lLVCjvxtn4ULA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] rust: auxiliary: sample: demonstrate ForLt with
 invariant Mutex type
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260618230834.812007-5-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 23:21:43 +0000
Message-Id: <20260618232144.09FC91F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Safe Rust code can cause a Use-After-Free (UAF) and lock a fre=
ed Mutex by calling `registration_data_with()` on a surviving `ARef<Device>=
` after the parent device is unbound.
--

commit 9c83313149d56b7513a5eff4702ae4ca9adae277
Author: Danilo Krummrich <dakr@kernel.org>

rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type

Extend the auxiliary driver sample to demonstrate both access patterns:

  - registration_data() with CovariantForLt!(Data<'_>) for the covariant
    data type that holds a plain &'bound reference.

  - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
    data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
    invariant over T, MutexData cannot implement CovariantForLt and must
    use the closure-based accessor.

> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_dr=
iver_auxiliary.rs
> index 92ee6a6d348e7..e441ae81fa2cf 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs

[ ... ]

> @@ -115,22 +140,39 @@ fn probe<'bound>(
> =20
>  impl ParentDriver {
>      fn connect(adev: &auxiliary::Device<Bound>) -> Result {

[ ... ]

> +            // Invariant ForLt types (e.g. containing a Mutex) require t=
he closure-based accessor.
> +            INVARIANT_DEV_ID =3D> {
> +                adev.registration_data_with::<ForLt!(MutexData<'_>), _>(=
|data| {
> +                    let pdev =3D *data.parent.lock();

[Severity: Critical]
This is a pre-existing issue, but can this safe Rust code cause a
use-after-free if called on a surviving ARef<Device> after the parent device
is unbound?

In the auxiliary core, Registration::drop() frees the RegistrationData:

rust/kernel/auxiliary.rs:Registration::drop() {
    ...
        drop(unsafe {
            Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
                (*self.adev.as_ptr()).registration_data_rust,
            )
        });
    ...
}

However, it leaves the registration_data_rust pointer dangling.

Since the auxiliary_device can safely outlive the Registration (e.g. via a
safe ARef<Device> inside an async task, cdev, or sysfs file), a caller hold=
ing
that reference could safely call registration_data_with() and trigger a
use-after-free when the dangling pointer is read:

rust/kernel/auxiliary.rs:Device::registration_data_pinned() {
    ...
        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
    ...
}

In this sample, wouldn't that result in locking a freed Mutex when
data.parent.lock() is called?

> +                    dev_info!(
> +                        pdev,
> +                        "Connected to auxiliary device with index {} (vi=
a Mutex).\n",
> +                        data.index
> +                    );
> +                })?;
> +            }
> +            _ =3D> return Err(EINVAL),
> +        }
> =20
>          Ok(())
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618230834.8120=
07-1-dakr@kernel.org?part=3D4
