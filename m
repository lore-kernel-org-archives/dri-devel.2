Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD50CDE011
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AAD10E37B;
	Fri, 26 Jun 2026 12:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bF1zxuvF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECEB10E37B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:05:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8D8560128
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F7C1F000E9;
 Fri, 26 Jun 2026 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475521;
 bh=0Osr3VXerY32w6uKiUdxY7LofX41GJ0zuaLZNMGTP40=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bF1zxuvF34mJcgrMCZ13B6ET09AV4FELo0o5f1F2PnT6mpOCrJg6W0nFIldI0Bspk
 +CaFyqWwCFKpJObs0Kk2oOo9pjAVjXT7PpGpMTgVPeZuQat6P3M6mMhRm8MXWLfUG4
 L71M/zAtmrPcTjiqj9YpBAiR7aQwM51HHVeSI7zFdawuh12UxDg4l/4LE1WE6PiYUU
 8GvgfsKemGR2EIQ2flHnvhOTzr9CZ9aommdP4EFpmGqxA8bEJF9FtL73WBgsZCHDVm
 N6fPU/u2gzu0xnSmyqHID4DYCljBH51Ffvo7ogwL7erF/qGR+AO7gSA9bRn39AS70Y
 OONmQGvvIUyQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:05:20 +0000
Message-Id: <20260626120521.33F7C1F000E9@smtp.kernel.org>
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

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D4

