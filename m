Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45858C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07E910EDFB;
	Wed, 19 Aug 2026 11:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gHbxXJaW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CA110EDFB
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2021860A58;
 Wed, 19 Aug 2026 11:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8B1F000E9;
 Wed, 19 Aug 2026 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138618;
 bh=1mKeqtMfgNu27MUTT+aYhYybzVZeTQnCiMXDTo7DdSM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gHbxXJaWJWx5pybesc5Q/EULRHKxuCuVTKhjPOnazhpHfN+UggNvnesn+FRQyGC2g
 vF/4giQqo7WlvrJY2l4bKYYf3d7r/uchnq7BHRkQqn06KQpfppQNXrI1b4AgIWb4CG
 cctWkUBSEm3YZIWS8+aNbl06WGSOINf4StTr3ucJYKftfad9PdEhtW/aHpW68B5jh8
 HEjjDtVFqCkZXPFrJPCPDYtv4NKchmsCvw+6XXw1DtYKz/Kq8m3wmRF5WKmeqoHTRh
 n+iHS+40+KoyGjsH4hic3vKSc7bPCgiLt8qDDcilP+Fkeu1FCzfQ52NguiknIpx1vL
 ggHp2hBCGp9Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/16] rust: io: register: remove relative registers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:23:38 +0000
Message-Id: <20260819112338.8BB8B1F000E9@smtp.kernel.org>
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

> Relative registers can be better served by projection to subregion instead
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>=20
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D14

