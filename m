Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C53CC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFC010EC6A;
	Tue, 30 Jun 2026 12:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCnK8OGz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67D810EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B253600BB;
 Tue, 30 Jun 2026 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB11F00A3D;
 Tue, 30 Jun 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823219;
 bh=N0wi7a15NjxWBjhztKeDcP9ZeAFuTbYSNVHzUfPKHSY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FCnK8OGzXMdhljhDQNpaVJDl2RgumAH+i7Q9OfzGbpGL1YUA8wwBPo93Ucv9W5LnH
 gUzgEZsgXx5jhwOnHNF7gwRgNdVwUvVWM2cIUlEAiLFlpl0L6IZBAaYuGwSaPpg8d/
 D5AV8IwQttvKvCZsyhB+wl2tG55exJu/l5d9TDKV5pDPkHdi36880i/+nkjNHw4tXL
 DgtHxPjLNkaGqmdDbskAYXP6Xa2D7sPKdqE3J+SPqpiPslpmGrvBa1CGhGLpSac58Y
 715wKT3w3SmJCw9fzLEst3j0Nw6ar3ivELG09T2kom8lgVpmfdhNqcv3jnxPY1gyJi
 qoUeGwleMDqJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] rust: driver: remove `$module_table_name` from
 `module_device_table`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-7-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-7-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:17 +0000
Message-Id: <20260630124017.E8AB11F00A3D@smtp.kernel.org>
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

> Wrap the generated code in a `const _: ()` block to avoid symbol conflict.
> This removes the need of creating a new identifier.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D7

