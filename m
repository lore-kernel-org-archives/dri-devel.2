Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDE2C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A938010EF4C;
	Wed,  5 Aug 2026 16:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7RX7wEE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681B610EF4C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:42:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50B5840577;
 Wed,  5 Aug 2026 16:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B262A1F000E9;
 Wed,  5 Aug 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948168;
 bh=DkR8ODVbDpqOsaHlJvLbBFWIWBIyEXd+addmLaESPGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7RX7wEEwTRmnA+0mN4lQ+Ozdwoo/ynnox7rhtixey4PpxH013BufCGHhY3fgZD+V
 c6KdCAHFlhFJyfqKpM3oy+4CQ7+86kpQAarOGIGk4q/Av5HkXJxZ2kNMwscFZ4c8ck
 g50GJKY3ZPP7ToL9U6MekcV3OO+aXNBx0IxQWJBcvFii7o9HIy3lasMo4WpxoWJlhN
 KHP2RaCiVoZusHdmG8P7X52QcNBi4yRr8u6C7KlNAe6jzuAwT6Br3ldvt/eeRdZ9lU
 pt8zj32ZrrlMiC+0DmOZomFahQMH6zU/sxAMYKmoZfRwZa+5CpL9ieoTJMsBZUIF2D
 sSufdYjQhjlXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/16] rust: io: support register projections
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:47 +0000
Message-Id: <20260805164247.B262A1F000E9@smtp.kernel.org>
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

> `IoLoc`s themselves just describe a projection from a region to a concrete
> register. Thus, support it in `io_project` macro too. Also, update methods
> that operate on `IoLoc` to use I/O projection.
>=20
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D3

