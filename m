Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B3C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4905610F620;
	Fri, 26 Jun 2026 15:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDMve+Wb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4D510F620
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E817600C8;
 Fri, 26 Jun 2026 15:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2841F000E9;
 Fri, 26 Jun 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486174;
 bh=N1w4bIbLaNSgDww/70KVqlDecYIaWEvn3WGOogUNS+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EDMve+WbFv2UcXEjuTyeGtayMKKO38N4O95FveMPHDTjGvUDQ+yfzVXxvrSVQYKOf
 dUa1Y8fSXfQB1d3udcR4B3HPK7N9Me5OiD9JFYIRgZs04Ux0P5I4erPSXqw/FSq6Vc
 kHSio/YVl2vqEP9aYJ5dx/HX7a4mHKPq87elcKprIeNt98vc7A/HqSstRPoilHfFx3
 /HPN3/lpPRpipBlEE8xM9kpL4E8iv7jAoPv5EQPfpDDoNM6EL6rAA+/3TW6jn/xVfv
 MIAEFl0wkAXKnLP0lOEAaYubDApTH+MuoMH1syqdDx+tTYtVBa0IXU9fhIMRFQ1ft9
 Mk4k/385/8Jqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/20] rust: io: add copying methods
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:02:53 +0000
Message-Id: <20260626150254.5C2841F000E9@smtp.kernel.org>
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

> One feature that was lost from the old `dma_read!` and `dma_write!` when
> moving to `io_read!` and `io_write!` was the ability to read/write a large
> structs. However, the semantics was unclear to begin with, as there was no
> guarantee about their atomicity even for structs that were small enough to
> fit in u32. Re-introduce the capability in the form of copying methods.
>=20
>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>=20
> Model these semantics after memcpy so user has clear expectation of lack =
of
> atomicity. As an additional benefit of this change, this now works for MM=
IO
> as well by mapping them to `memcpy_{from,to}io`.
>=20
> For slices which is DST so the `copy_read` and `copy_write` API above can=
't
> work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
> memory.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D19

