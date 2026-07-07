Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02263C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56EAA10EE3F;
	Tue,  7 Jul 2026 16:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FeYIzi6M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6039010EE40
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:04:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47BB040815
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E7B1F00A3A;
 Tue,  7 Jul 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440260;
 bh=I/F+19mKv6qOKk2FX9KmDcNjVknycjg438a+rTXdyik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FeYIzi6MZjnkcGDc7K4g/hQDZxgu8SfHoI9qJwMdUOneRUn+1qwq58EqzwOtaZ9Zo
 TjvUmY1aFW5SUqGtF48jOfP/hZaU0bLa5n3O2W5xdWh9Wus+v4hZYpG7YaeIj4mMdS
 EUiyrom+TIVZAwE7n2Gbi6YkDUypiaJ/hdvp9Fc+Ae8gsm7hfo9OoTy7B5exSl2jHb
 jEjnbDKWTLVbjcX2gqcXIaJR1/YUD3kbYMRmQ1GO0I2t4t1+zEMMbrIyH2au2Uxjb4
 VvHXyrUqSQkes2XE83v9tmjPZ1mMoQzvsX68SV7ZB/F1GnOIyezYKJb7AIsAoxCo5j
 oiEuCCFH1umVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/37] drm/omap: dsi: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-31-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-31-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:04:19 +0000
Message-Id: <20260707160420.16E7B1F00A3A@smtp.kernel.org>
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
- [High] The `te_timeout_work` is cancelled asynchronously during driver de=
tach, causing a possible Use-After-Free.
--

--- Patch [31]: [PATCH v2 31/37] drm/omap: dsi: Switch to atomic bridge cal=
lbacks ---
commit 7b874c0db789f5326cf81422dc10c73534a0a3cf
Author: Maxime Ripard <mripard@kernel.org>

drm/omap: dsi: Switch to atomic bridge callbacks

This commit switches the legacy non-atomic enable and disable bridge
callbacks in the OMAP DSI driver to their atomic counterparts. It also adds
the necessary atomic state handlers to support removing legacy bridge
callback support from the DRM bridge core.

> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index 27fe7bca9e2cf..7aaee94f86e41 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this asynchronous cancellation lead
to a use-after-free during driver detach?

Looking at driver detach paths, omap_dsi_host_detach() calls
omap_dsi_unregister_te_irq(), which uses the asynchronous cancellation:

drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_unregister_te_irq() {
        ...
        cancel_delayed_work(&dsi->te_timeout_work);
        ...
}

Because it does not wait for a currently executing work callback to finish,
could dsi_remove() and devres cleanup complete while
omap_dsi_te_timeout_work_callback() is still running?

If the devres cleanup frees the dsi struct (allocated via
devm_drm_bridge_alloc()), would the concurrent callback then dereference
the freed dsi pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D31
