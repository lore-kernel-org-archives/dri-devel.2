Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E25C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A6C10EF52;
	Wed,  5 Aug 2026 16:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NUIJpkHt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F7110EF52
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:48:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52A004150F;
 Wed,  5 Aug 2026 16:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F11F000E9;
 Wed,  5 Aug 2026 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948499;
 bh=2YoXrm+YrBdqLLPU4EIxJRsyoQw3Dz/KBoMXldFjO90=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NUIJpkHtaHnaGvBixA/CLu77qThxdNJlxjMX75x2ZStQNmXqTTIF2lcFXGzPvaqCB
 x7GTUj+OaSGkSDpt4s9AKgVsOXTd0XWl7wAnc2+L8y2dV6XYzWIDxUArUoNf8RuzDi
 ofbjNJl4sY04pQzmS3HjrCrQwgJMdQRw/32Arlw8fwyhFfodObMHGh47dPQsIBdZmY
 xJQYG/uu0HrBG8iLN6IgXSI/3EoJ+7aTaBk2RhMYWSvlOJ0Zlb0lg/6OvKcPLZCS95
 gplf7xIDb45on7eY4D6DHFJ8W3U6NZTO0R5SR7sX3X62glkVVEfWmSr8PY95XKKtwD
 DcA98ruVsBy5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-13-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-13-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:48:17 +0000
Message-Id: <20260805164818.D20F11F000E9@smtp.kernel.org>
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

> Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
> can also be achieved cleanly with projection and a new base.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D13

