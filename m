Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C4CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52D110E3B4;
	Wed, 17 Jun 2026 14:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dQ6Lmv9K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF45410E3B4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:11:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 276136001D;
 Wed, 17 Jun 2026 14:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FCA1F000E9;
 Wed, 17 Jun 2026 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781705500;
 bh=cJeGPAzjEe8/m+YpzaT+6UOFPt3hM6DM+rJSFzClQE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dQ6Lmv9K6ra98s487NAB1PrE8YpwNNBv73B+eE0hi3ih+dDw+9Ke5Pa9xZcOfEtDl
 +nj25j0U3gJk3z5U5PcsdAWVVIj28HzWAvzUhi2TXGP9TpJtx0YlXcQrGE3T2ZYmPi
 T0XtjgDqUC1Q3HGDk+f8CNRIGoZ2qyc2fOsXtJwDeGLV6LvOyvREZ/CWOfv1ERZcLf
 Px47wwhPQ+kuUy42koKMJUK29AyCMIgUxj5t16/Wdx2bTDIVKQJliiFeIdzlDSq5wJ
 z0TB6vo7Vc3oc2urGA0y4cIt8EciJ5rNX9BxE0sqaD06TbgDeDSy8PH7J4mjpFOaaG
 COEJpcIX8Ke7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: convert to kernel bitfield macro
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260617-nova-bitfield-v1-1-ec10c6772666@nvidia.com>
References: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
 <20260617-nova-bitfield-v1-1-ec10c6772666@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:11:39 +0000
Message-Id: <20260617141140.A0FCA1F000E9@smtp.kernel.org>
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
- [Medium] Refactored FSP message validation incorrectly bubbles up enum co=
nversion errors via `?`, bypassing diagnostic logging and changing the retu=
rn code from `-EIO` to `-EINVAL`.
--

commit affc1bd88bbaf7649b7fc1c329019739603b4580
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: convert to kernel bitfield macro

This commit replaces uses of the Nova-local bitfield! macro with the
kernel one.

> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 8fc243c66e356..91885b355d462 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
[ ... ]
> @@ -274,7 +275,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device,=
 bar: Bar0<'_>, msg: &M) ->
>              return Err(EIO);
>          }
> =20
> -        if command_nvdm_type !=3D u8::from(M::NVDM_TYPE).into() {
> +        if command_nvdm_type
> +            .try_into_bounded()
> +            .ok_or(EINVAL)
> +            .and_then(NvdmType::try_from)?
> +            !=3D M::NVDM_TYPE
> +        {
>              dev_err!(
>                  dev,
>                  "Expected NVDM type {:?} in reply, got {:#x}\n",

[Severity: Medium]
Does the ? operator here prematurely return EINVAL if the firmware returns =
an
unknown or invalid NVDM type?

It looks like if NvdmType::try_from fails, this will immediately propagate =
the
error out of send_sync_fsp(). Does this bypass the dev_err! diagnostic block
below that was intended to log the unexpected hardware value?

By returning early here, this also appears to alter the original error
reporting semantics by returning EINVAL instead of the expected EIO for a
device failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-nova-bitfi=
eld-v1-0-ec10c6772666@nvidia.com?part=3D1
