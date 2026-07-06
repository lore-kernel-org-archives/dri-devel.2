Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3881CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C9F10E960;
	Mon,  6 Jul 2026 12:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCR5/bev";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A6B10E960
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C5DC600BB;
 Mon,  6 Jul 2026 12:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793A1F000E9;
 Mon,  6 Jul 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342102;
 bh=5TP5FKXV2QfYP4taY1l+31Qs8Zcpx4j0j6opOvtbNfo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NCR5/bevwpoNx8rvWXE4RASOYTfIJb0kfDHzopOYg0l2n6JUgts8n1zdWl32rUl0n
 lmIpIdgxazuR4jrcyqluSiCChH7/49xKgn7bFCjOZ8abi3V/JWs47Y3EUA7XPpjNY4
 Cv+sR2vfktlAeyvNhb4qAGqW0BXFKKTO7j8zo07fqAZr0sGXl2dCSO6dA2K9rCLZ8A
 8eBWwBwfsW5oNJ1uivaSu8jdp2eHEkKI0qr44Ddf8VC6+791ySXff3M01RQA6376qj
 Q8nk5UMABj27rJ8OoIzDhHLlX9V8JLktWU4tmDrCXUqkQIisUFr9kEXzNLZeEqbqeJ
 6+raQb5AThqCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/20] pwm: th1520: remove unnecessary `deref`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:48:21 +0000
Message-Id: <20260706124822.7793A1F000E9@smtp.kernel.org>
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

> `Deref` is automatic and should normally not be used directly.
> Also, `IoMem` is going to be implementing `Io` directly, so it will no
> longer to be implementing `Deref`.
>=20
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D10

