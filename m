Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F03BCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D9F10E1FA;
	Mon, 15 Jun 2026 06:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VU4DZ7yX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481E810E1FA
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:43:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30D91418FC;
 Mon, 15 Jun 2026 06:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF95C1F000E9;
 Mon, 15 Jun 2026 06:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781505826;
 bh=fFPnZKPmtcngFYWaaYNFE8uD5xTdMxVbULPLZpK8C1o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VU4DZ7yXzfsvZSfOs6RJJWAgf6QKIthFVBdm9X0yy1XFflAobcWRSfaNv9mPAWITq
 GBoFpguMGu8UkjrAYnpjENSFzn9hbOSBtsUStyRpIsgguMaLVCBHYzJoaURZ3cDmO0
 QqIpfA5sgyqe/fBfLmokbDRx6naBXsqfM1jbuxsVgN7Y/oz3XBbGU+IFhrRhv9bqR3
 KCRjEwoHrwJxkF7rukGcv8jq4dh+qKcioz6corcKk3cDG8N12bW548up5x//OwdRSt
 3qxhE/EFjsnLihYmWhjgjfDqWTvuFki+j0SWynNKoofCtHkYuYsAlPNoGvRfKDTfE/
 v2x1tsR/Muibw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] arm64: dts: renesas: r8a779g0: Add DSC
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org
In-Reply-To: <20260615-rcar-du-dsc-v4-5-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-5-93096a1b56a3@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:43:45 +0000
Message-Id: <20260615064345.BF95C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `WARN_ON(pm_runtime_get_sync())` triggers a spurious warning and l=
eaks the usage counter on failure.
--

commit 0b204c1dc5dc2b356c39f6b89ab2b1606d6ffb6b
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

arm64: dts: renesas: r8a779g0: Add DSC

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The current dtsi file does not represent the DSC at
all, and thus the pipeline for DSI1 has not been functional.

> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/=
dts/renesas/r8a779g0.dtsi
> index 82a7278836e57..123baaea8db45 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -2298,6 +2298,35 @@ du_out_dsi0: endpoint {

[ ... ]

> +		dsc: bridge@feb8d000 {
> +			compatible =3D "renesas,r8a779g0-dsc", "renesas,rcar-dsc";

[Severity: High]
This isn't a bug introduced by this patch, but enabling this device node
activates preexisting code in the driver added earlier in the series which
has an issue in the runtime PM error path.

Looking at rcar_dsc_atomic_enable() in drivers/gpu/drm/renesas/rcar-du/rcar=
_dsc.c:

drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c:rcar_dsc_atomic_enable() {
	struct rcar_dsc *dsc =3D bridge_to_rcar_dsc(bridge);

	WARN_ON(pm_runtime_get_sync(dsc->dev));
}

Since pm_runtime_get_sync() returns 1 if the device is already in the
RPM_ACTIVE state, will evaluating WARN_ON(pm_runtime_get_sync(dsc->dev))
trigger a spurious kernel warning stack trace on every atomic enable if the
device is already active or if runtime PM is disabled?

Furthermore, if pm_runtime_get_sync() fails (returns < 0), the PM
usage counter is still incremented by the subsystem. Since the error path d=
oes
not call pm_runtime_put_noidle(), does this leak the PM usage counter and
prevent the device from ever suspending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v4-0-93096a1b56a3@ideasonboard.com?part=3D5
