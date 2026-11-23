Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A03606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvhsxErT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDDE10F1AC;
	Mon, 23 Nov 2026 19:46:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CD610F1AC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:46:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22FDC624B6;
 Mon, 23 Nov 2026 19:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B211F000CF;
 Mon, 23 Nov 2026 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795463182;
 bh=KE41Jy27ffz827pHQMFOPzKZ8B9e/3qLveo/Z2KJPcU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AvhsxErTE3cwKxdVFuZSnPngjpWN7dWNwsNGzx9Y7ZvMER2FkYRSTHy4aphsMAnUp
 M30rnU2L2AHgYioi+sKcVXFci2RltrGjRULL8PiA6GXgzAfCYq/+sXJwO4ajhtJj3V
 3O58Vb072H02/BM5FuvzfxIdfyt7q1jNl/T4db7/7+aRn5liTdEvJXoZuMGzZ9OD+X
 aZtLcw8hT+UQJX7+MWdhmMPpv0NWrLp4YqQD9b4h8GdMknkCuDfM+b+o9qZMEt2Oi9
 xsoxDhNYk2/7PXnUx7RGTqmt1sE9TnD6j7g1HvFRu+lmr86Ok4yZEua3jBhn3U5pxo
 mTLPI+Qu7OEeQ==
Message-ID: <sashiko-outbox-229956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: soc: amlogic:
 meson-gx-hhi-sysctrl: Fix compatible matching in conditionals
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-1-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <20261123-meson-drm-create-hdmitx-phy-v4-1-3fb94f5534ca@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:46:21 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: soc: amlogic: missing Fixes trailers for
  conditional matching fix
--

commit 0cda355d81fb14b7a8b1c5dafc9b6d3f2114d679
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

> dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix compatible matching =
in conditionals
>
> The conditional schemas select on "compatible" with a bare enum. On a
> list such as:
>
>   compatible =3D "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
>
> an enum applied to the whole array only matches single-entry lists, so
> the if: blocks never match as intended and the per-variant constraints
> are not applied reliably.
>
> Wrap the enums in "contains" so that the conditions match on any entry
> of the compatible list.
>
> Doing so exposes the "phy" child node of "amlogic,meson-gx-hhi-sysctrl":
> it was forbidden (phy: false), but some DT legitimately describe an
> "amlogic,g12a-mipi-dphy-analog" PHY node under this system controller,
> which resulted in dtbs_check warnings such as:
>
>   system-controller@0 (amlogic,meson-gx-hhi-sysctrl): False schema does
>   not allow {'compatible': ['amlogic,g12a-mipi-dphy-analog'],
>   '#phy-cells': 0, ...}
>
> Allow the phy child node for amlogic,meson-gx-hhi-sysctrl by referencing
> the amlogic,g12a-mipi-dphy-analog binding instead of rejecting it.
>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

[Severity: Low]
Should this include Fixes: tags for the commits that introduced the bare
compatible enum conditionals and the phy: false restriction?

  Fixes: 4d023beb3998 ("dt-bindings: soc: amlogic: document System Control =
registers")
  Fixes: 960a4140ade8 ("dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Doc=
ument the System Control registers found on early Meson SoC")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-meson-drm-=
create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr?part=3D1
