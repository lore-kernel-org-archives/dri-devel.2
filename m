Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830E9C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E922C10E958;
	Mon,  6 Jul 2026 12:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JKxXdybF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0890A10E958
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:57:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63503600BB;
 Mon,  6 Jul 2026 12:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC31F000E9;
 Mon,  6 Jul 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342678;
 bh=H8TWbiybvgVZrdX6xCsNuZaidHGq0ZgtQvWQA2K2mFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JKxXdybFDklmgE9dV1lKD92NCas718FxuvWCW7xn6zApvawu/FZHcHFUy1zk07Fr7
 N/aoVN+Fhp5T0ugTb61fCPH7BDbS9QApRrLFjcEgh0oW52aJwE5ETEpfk2rxNklfu+
 VO9a9TUTfRV2ABARScowZKqT8vh1PT9NHKPYv7PfNTLpPR1AxdTISOmoqNJM1gPykL
 bXlefRBtkkN6GF2rMpEGPi7D9/uUROeNLD5YK5lFulAaA6QWWVz6XM9lDyrgdVlS4w
 N7aaV7rzAhAxo6t/DYuXNqKGiUa7GTqjUQ34CeZpx55uvyxBfBgNdv/jnAnYroaYGd
 n9m2lKZWmUgEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/20] rust: io: rename `Mmio` to `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:57:57 +0000
Message-Id: <20260706125757.B4EC31F000E9@smtp.kernel.org>
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

> Most users would more commonly reach out to a view of `Mmio` rather than =
an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
> the name `Mmio` can be used for the view type instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D6

