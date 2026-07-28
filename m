Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549CEC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12EA10E9D4;
	Tue, 28 Jul 2026 18:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oN2/rOCl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF0210E9D0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5EBC43C8C;
 Tue, 28 Jul 2026 18:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC8C1F00A3A;
 Tue, 28 Jul 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264958;
 bh=bG3eDXBzR3R7bCor/tKgRQDkPOMyoekzB72vpkUuIXc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oN2/rOClZF9gznt+o0hdWFBV6QNUrGWcZGqMnP6jCdJwZXOo7LzkRb8GYiiFGT7Iy
 u0lYyeLX5324kmEg/eBzTIcQjg9Q+0nN0uDG0MjCm6fHOyykg9Z0pQy/tKYV26z03X
 cUZBDT5akvdvNxxFDD6szj/5SfjoreLL7b4Mxk40H2uNh2nO0VfcogInSUsuvfzUzN
 RnPiJB4br0s72DrSUlvSNp/vMMcp2bDQVsx4MSk8Eb5pf7DUKjs5KtG+NuQRREptIW
 wLpaQ5FUyOFLseMsE7rLeR6wEnGCRj/8SjuA7ZVtf3hzRl/2Q8YgcijOZ6cvp0exMH
 bgcqTE+g6KAGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/7] drm/tyr: add resources to RegistrationData
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-fw-boot-b4-v10-1-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-1-9187aefa3f2f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:55:57 +0000
Message-Id: <20260728185558.3AC8C1F00A3A@smtp.kernel.org>
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
- [Critical] The DEV_QUERY ioctl handler fails with -EFAULT when userspace =
provides a smaller buffer size than the kernel's structure size, violating =
the documented Panthor UAPI.
--

--- Patch [1]: [PATCH v10 1/7] drm/tyr: add resources to RegistrationData -=
--
commit 582ca5eb256eb752ad582c7535dd1fc5bf72cd26
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add resources to RegistrationData

Currently Tyr is not storing any resources in its drm::Driver
RegistrationData. Move Tyr's device-private resources and gpu information
from drm::Driver::Data to drm::Driver::RegistrationData so they can be
accessed safely while the device is registered with userspace.

> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index b686041d5d6b4..9f60a90d49487 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs

[ ... ]

> @@ -53,7 +54,7 @@ pub(crate) fn dev_query(
>                      )
>                      .writer();
> =20
> -                    writer.write(&ddev.gpu_info)?;
> +                    writer.write(&reg_data.gpu_info)?;

[Severity: Critical]
This isn't a bug introduced by this patch, but does this strict size check
violate the documented Panthor UAPI?

When userspace invokes the DRM_IOCTL_PANTHOR_DEV_QUERY ioctl with a buffer
size smaller than the kernel's GpuInfo struct (for example, from older
userspace clients), the UserSliceWriter::write() method strictly enforces
that the length must be at least the size of the structure and returns
-EFAULT if it is not.

The C driver permits this as long as the size is at least the documented
min_size, copying only the truncated structure. Could this strict size
check in the Rust driver break backwards compatibility for older userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-fw-boot-b4=
-v10-0-9187aefa3f2f@collabora.com?part=3D1
