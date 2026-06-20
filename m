Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A41ECD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 01:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631CB10E156;
	Sat, 20 Jun 2026 01:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSOZGECo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBD210E156
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 01:17:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7650340444;
 Sat, 20 Jun 2026 01:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0821F000E9;
 Sat, 20 Jun 2026 01:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781918240;
 bh=GRsRfq54fSBIBWVspJUB1hKcI+wM0RxrAmA4h8SOOYM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BSOZGECoeo5+gSGcifaaoOI4dLWsv7IFbjsbYL1b29PLMI3XCgSDJ3pTUfF0GAsd5
 HU2B/NBmLxUysEtW69c6b2oKJAzlnZRV/q3xesdbOysm2ZK3+BCtI/QBjIQ0YHdGqH
 O/NU84F5+fqX1L+lAhRqR+dwt5M1KOzgsk6VfHOW5109D2WOV/1XNsH/uVvR8ztE5e
 qi57X3MuzWkmLJuaeLUSifdfx/ak7JtC4C3ycV1WgkOHVeEqgQg4TeKa2q1jfgthZn
 JhhM21uG89HNW74calGBFjyGAIbQnuSHHPuAHB8htdXyFqBopcNXppnqAIvqdWky1U
 bZk0gByPUZqxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] drm: nova: Use drm::Device<Registered> to
 access the parent bus device
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620005431.1562115-14-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
 <20260620005431.1562115-14-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 01:17:19 +0000
Message-Id: <20260620011720.1B0821F000E9@smtp.kernel.org>
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
- [High] Changing the IOCTL handler signature to accept `&Device<Registered=
>` forces the `declare_drm_ioctls!` macro to unsafely assert registration i=
nvariants before verifying them.
--

commit ae89d443b44234dbccc8b42ac767d5eb9bdfb248
Author: Danilo Krummrich <dakr@kernel.org>

drm: nova: Use drm::Device<Registered> to access the parent bus device

This commit modifies the get_param ioctl handler to accept a
&NovaDevice<Registered> instead of &NovaDevice, avoiding the need for
storing device data.

> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 4c9fa409a8be8..e0e79b5719836 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs

[ ... ]

> @@ -23,14 +29,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>>=
 {
>  impl File {
>      /// IOCTL: get_param: Query GPU / driver metadata.
>      pub(crate) fn get_param(
> -        dev: &NovaDevice,
> +        dev: &NovaDevice<Registered>,

[Severity: High]
Does changing the ioctl handler signature to accept &Device<Registered>
cause the declare_drm_ioctls! macro to unsafely assert registration
invariants before verifying them?

The declare_drm_ioctls! macro instantiates a reference to the DRM device
using Device::from_raw(raw_dev). Because of the type-inference anchor
let _ =3D || { $func(dev, ...) }, changing the first parameter to
&NovaDevice<Registered> causes from_raw to be invoked with the Registered
context type.

The safety contract of from_raw requires callers to promise that any type
invariants of the generic context C are upheld. The Registered context
guarantees that the DRM device is currently registered and its parent bus
device is bound.

However, the macro calls from_raw before acquiring the RegistrationGuard,
which verifies via drm_dev_enter that the device hasn't been unplugged:

rust/kernel/drm/ioctl.rs:declare_drm_ioctls!() {
    ...
    let dev =3D $crate::drm::device::Device::from_raw(raw_dev);
    ...
}

If the device is concurrently unplugged between drm_ioctl's initial check
and from_raw, the invariant is violated, which breaks the from_raw safety
contract and could cause undefined behavior.

Would it be safer for the handler to continue accepting &NovaDevice (the
Normal context) and call dev.registration_guard() internally to obtain a
Registered reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620005431.1562=
115-1-dakr@kernel.org?part=3D13
