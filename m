Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C34CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAE110E0D0;
	Fri, 19 Jun 2026 17:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EkUu1iIr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005A510E0D0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29784601E4;
 Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA31F00A3A;
 Fri, 19 Jun 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888701;
 bh=xsNYdaSZ7DOl66yYxVx9vRbOxtf+w6s+PFyeaUD/br0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EkUu1iIreY9s6sc7gUBEwlvGBmosHp/wpg4lMzlW2sMwN/lSTkHu7YAzl5STe5x0A
 v+/3DORnBl5jFKZy83T0uAuk3fc3fsbrJp8rhoAXL3c8GtT5FzAwQ7UwcNQNbAOS08
 6vJ6Vum8E46rkg9qg8MZHJOb5A1FoC2b61PCrOfhszaeurzWfGRhGDYzQhbGW1kgjq
 DpiYyGo3Sa9DXYCQdLHAVEzj6I1OI4piLF/7cB2j9lR1QPZGI/9jLO3uZLl3NF74lN
 oYGB+XEy7G61EH5LlBzXKbK7/7ogkDBkgf277upVmIgW9+KoZzS3zLCOE8kTZdLctI
 MAxBT+OODvBqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] rust: driver: simplify `IdArray::new_without_index`
To: "Gary Guo" <gary@garyguo.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, robh@kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, conor+dt@kernel.org
In-Reply-To: <20260618-id_info-v1-2-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-2-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:00 +0000
Message-Id: <20260619170501.67FA31F00A3A@smtp.kernel.org>
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

> This method can very easily construct the `IdArray` on its own without
> delegating to `Self::build`. Doing so also simplifies the phy device table
> macro because it does not need to construct tuples anymore.
>=20
> This also allows simplification of `new` and `build` which removes the
> `unsafe`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D2

