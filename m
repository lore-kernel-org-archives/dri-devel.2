Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830AC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5042C10EF4F;
	Wed,  5 Aug 2026 16:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ScZeyG5N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8E010EF4B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D37D8439BD;
 Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC421F00A3A;
 Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948222;
 bh=ohtVowNY5JGV13lGpspYB+kc0UZb2zKeEcsa5r2MCAc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ScZeyG5Nw/v4SSlnRLhcglGqh80IG1XpikwDNQOlZ/3PLv0m+Yyebs8aW7me/5eJT
 Kj7Z+IinW/cNuFVgs6WTlrmMbBBTbbZQkPbEnNXCVqCmjGaulX7FRMNDQ1t2YjICgP
 9zBof1JkfG9d3tMw0t7c7RcvDufTflj/zxIAzDsfNbGsqFnzJe8urhDE3iA+p9K+Yb
 D+PRCof902YnenXh6kmbaduY9om0A2m/PmMUHtOOFlJrsp1yB0Pu2mEdY3vHGk+rFh
 nKuKDDoo1Tzx7R4Gz4PmXWpousmCDXOMAv1SxIY2TffKK/PaXzOBmEILxiSe5k7klv
 k1XQ8y/Y9yNYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] rust: io: register: make register have a typed
 base
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-10-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-10-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:43:42 +0000
Message-Id: <20260805164342.5FC421F00A3A@smtp.kernel.org>
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

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Also, add an `io_project!` example which is enabled by this change.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D10

