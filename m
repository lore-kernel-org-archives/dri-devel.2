Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAD1C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E359A10E417;
	Tue,  1 Sep 2026 16:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXZkravo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 196A310E417
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:55:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5D706013A;
 Tue,  1 Sep 2026 16:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41C1F000E9;
 Tue,  1 Sep 2026 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281736;
 bh=Dc6bwf/GahXGIO5yuZtsjqF/kfFRrgzsaVcAvEKcbA4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXZkravoMfMs3pgiGI3OCsoOhvEsnCm7ItbD5hUx5frHCOkaiArc9u+iPqndaM89T
 OokUOnMLalieKVxOzBZTYaBjUm7PX+I5XIf17OUdXB9EV7/tXQYE4gmGJxTCyTs1pS
 mRbYnjBY2sLAZDaXY67FRe6IOJp0YG8Df9Vu1TwT1D0+3fdby8/QLSL6Sn77k0NKYC
 s2jcYOL/oLO19I3PYPTOF01TVDSaZQtIm9APCIM3+j1DniIbbwgtjGGjzGi0GEegQM
 4cHmNFz8IGonqCPobqBERqFjilnq7Hhry/8gE6bCj6jO67Md94/ke0n+/FlPJc+Wdb
 N7reCvh0h7pXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/16] gpu: nova-core: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-7-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-7-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:55:35 +0000
Message-Id: <20260901165536.3E41C1F000E9@smtp.kernel.org>
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

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D7

