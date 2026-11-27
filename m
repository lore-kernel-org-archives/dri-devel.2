Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D27606A332
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8+0R5Of
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C13710E4E7;
	Fri, 27 Nov 2026 15:38:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B4A10E4E7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:38:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0767541A64;
 Fri, 27 Nov 2026 15:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088651F0089C;
 Fri, 27 Nov 2026 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795793880;
 bh=+WLLtnN2R5M/5/EnMLDzbwynr8R1odsEdwLSn/mSjI8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f8+0R5OfsFjO33opKrRKuW1ZOsc/GpwUnegecgpgPETJ1eAQbi4bMEmdO6CCD5DuY
 WI+fpib9/uytV2K/6bysheAhgizkX7WWbIOzQN9lsBQU4HKTcDXwyRdaAO46OEavs2
 pLzFHiwK+0CvNgWjraziYFUrxdvPMhr3tx8xWQWeCfGQzbBi2KM6xfbp+f+xE9FWmw
 0bAL1aHQTQ+tKEAwyQIUdNyyUjxQkkZX9KwVKAlnjb/1m9/P9AUsPfSAZT1uyNXOAy
 Vc20eKYwh5nTmm7urcZ0oDZ0RLjKtFHReVZm7Srid/M8mSg37GMAcodm6wzFh8jD8G
 psMS6DLs9aqpA==
Message-ID: <sashiko-outbox-237759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] dt-bindings: soc: amlogic:
 meson-gx-hhi-sysctrl: Fix compatible matching in conditionals
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-1-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
 <20261127-meson-drm-create-hdmitx-phy-v5-1-88c43eb95468@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:37:59 +0000
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

commit 3a6f82497ac8b3eb518b14c0bffeec3b4447c0f9
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
Since this fixes the bare compatible enum conditionals and the
phy: false constraint, should it include:

  Fixes: 4d023beb3998 ("dt-bindings: soc: amlogic: document System Control =
registers")
  Fixes: 960a4140ade8 ("dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Doc=
ument the System Control registers found on early Meson SoC")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-meson-drm-=
create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr?part=3D1
