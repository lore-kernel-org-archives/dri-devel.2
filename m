Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBFFC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7077F10EACA;
	Tue, 21 Jul 2026 17:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZWjMloHu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FFC10EACA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:03:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E257F43BBA;
 Tue, 21 Jul 2026 17:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBCF1F00A3A;
 Tue, 21 Jul 2026 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653406;
 bh=nVM5/Rmwhu+NMf7YEReFDEo7Z+8m4fFKgeWCnR+YVr8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZWjMloHutDOfzFk0Rhfi0wKA3DxbyS579XYFQiEbZlUoTiacJF2jnXDavwy0WGo7V
 aGYPXQ0FDWKHGpXXM3lEgNoA11ew2bdZO53FsSCoQ/d0IcBo/6qfitcBwFBw1ttGRn
 Pbwf/lsTdu6T8Te8VgiDvLXrNqfLiQei3Gh9sLVqI/nKD4obhYJK25nkJdCuJXQfMS
 VAY2XklQp6gSu+4lKtv6xMYu6CnCYU0LVMtmdq6FDPzSQd0lia4hYnclcKThTYnhEz
 d8YOuRYiFMTRIOwHs2sa5goKoT2GcivThDreK2fgDP/WBhzjQPyEoSdCStH1NOQ87Q
 wFM9XpDK1kntQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] samples: rust: pci: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-4-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-4-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:03:25 +0000
Message-Id: <20260721170326.6DBCF1F00A3A@smtp.kernel.org>
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

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D4

