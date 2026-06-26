Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887A4C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C7410F685;
	Fri, 26 Jun 2026 15:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dldgESN9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60F510F67D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:13:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF88540E58;
 Fri, 26 Jun 2026 15:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DE01F000E9;
 Fri, 26 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486780;
 bh=sQGYohwaXrdcKYwAkRRSUwUd4xrUIr9i2x73FCzJ/OQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dldgESN94aS33ceGRH7WxyMIs2VJ3ls5hovZMRWfK/4e8e83M0flm7Fn38EWiJKRx
 2I47hzM2JkQWKBG2zdxPcLBRtabsiOi312NDHFy44e5nXcayx64ihz5lGSN4QxQWm3
 AAe3h0d0b6YbyGSfTPH0Ktw7jWKdWXdk1TUaBuVFM2lIyedlzCdY0esXMVTq8JRhjR
 AnL6FKg6Yp2CEyEqD0RuQMw6TLfhriwrr6FPYeKBC6sM9VDZnUDVE08J2welkWFVkx
 Km6WIP0Kqaq54MQj1uNaKtV5xxDbTRnsgJNz27CfVk2LiXP7H+93fSJAgwGQd8DccS
 3wbcDmM6P6KoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:12:59 +0000
Message-Id: <20260626151300.08DE01F000E9@smtp.kernel.org>
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

> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert t=
he
> lack of concurrent access, or should be using memcpy-like APIs to express
> the non-atomic and tearable nature.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D18

