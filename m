Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD8CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E3410EE3C;
	Tue,  7 Jul 2026 15:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DMbo/2Vf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B5710EE3C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11E7F60018
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343F1F000E9;
 Tue,  7 Jul 2026 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439817;
 bh=Zqe+VMvV96gr1j+WcFXSM9Httx96+UcBuLisDLifd5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DMbo/2VfoyPAodAO9/W8lzbcrupoqNIAQOywTaK2EwtfkjnccAbcUJy3wqXiIbQKr
 Zy0tzhjdbGUL0nULVyTtkF1uORY1+2mFeW7iBJ4muD7brDL9VirUenXfc1p643mpkk
 TBworilRhmaLyEFDXQIDiJibg/3BoFTQw51C0Fqi7D+N8Bj/HSIT1VZYlOmsnbJMoY
 MrK+z9iJpz6FS6IDdczbUoDvGA1vfjm7nOtXEvW/NUXZju4ZI/QpwjVMHU8aDbmCMj
 3M37pW6z8MevBM1CCayxp2gQyP1iCt1eWxZH+ztcIRwgHUy+RVnYLKwFH+r24+m/CU
 QVr4mXSEEC2EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/37] drm/mediatek: dpi: Switch to atomic bridge
 callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-28-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-28-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:56:57 +0000
Message-Id: <20260707155657.9343F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying persistent driver state in `atomic_check` instead of ato=
mic bridge state.
- [High] The bridge enable callback ignores the return value of mtk_dpi_pow=
er_on(), proceeding to access hardware registers even if clock enablement f=
ails.
--

--- Patch [28]: [PATCH v2 28/37] drm/mediatek: dpi: Switch to atomic bridge=
 callbacks ---
Note: The format of this review has been altered to use a free-form summary
instead of inline diff quoting due to text recitation restrictions.

commit 396f1ff8f70eedabf798b2a8fbc7bac8f10dfaad
Author: Maxime Ripard <mripard@kernel.org>
drm/mediatek: dpi: Switch to atomic bridge callbacks

This commit switches the dpi bridge to use atomic bridge callbacks instead
of the legacy non-atomic ones, updating the function signatures and adding
atomic state handlers via a Coccinelle script.

[Severity: High]
This is a pre-existing issue, but I noticed something while reviewing the
atomic conversions in mtk_dpi_bridge_atomic_check().

The check callback appears to mutate the global dpi structure directly:

mtk_dpi_bridge_atomic_check()
    dpi->output_fmt =3D out_bus_format;
    dpi->bit_num =3D mtk_dpi_bus_fmt_bit_num(out_bus_format);
    ...

Rather than modifying the local bridge_state, the persistent driver state
is altered. Could this cause state corruption if a userspace application
performs a test-only atomic commit (DRM_MODE_ATOMIC_TEST_ONLY)?

It looks like a test-only commit might permanently alter the active
configuration used by mtk_dpi_set_display_mode(), potentially breaking
subsequent display operations.

[Severity: High]
This is also a pre-existing issue, but looking at the newly renamed
mtk_dpi_bridge_enable() callback, it calls mtk_dpi_power_on(dpi) without
checking its return value:

mtk_dpi_bridge_enable()
    ...
    mtk_dpi_power_on(dpi);
    mtk_dpi_set_display_mode(dpi, &dpi->mode);
    mtk_dpi_enable(dpi);

If any of the required clocks (like engine_clk, tvd_clk, or pixel_clk)
fail to enable, mtk_dpi_power_on() will return an error, but the caller
proceeds to access hardware registers anyway.

Will accessing this unclocked register space via mtk_dpi_set_display_mode()
and mtk_dpi_enable() trigger a bus fault and result in an immediate system
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D28
