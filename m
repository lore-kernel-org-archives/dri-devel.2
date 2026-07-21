Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D18C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D1710E3AC;
	Tue, 21 Jul 2026 18:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HFWLFC3j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012CF10E3AC
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:14:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52604601DE;
 Tue, 21 Jul 2026 18:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF271F00A3A;
 Tue, 21 Jul 2026 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657697;
 bh=b9TxdQy0//5Ha8Gm5yJXnTz0DY13wIxZMlP4M1iFGzE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HFWLFC3jV4hlIppjT+uoMbAPLd/eKhg8bz7wkz4NSsQMMqfshtHpFx7KLWGk76lAA
 BE0ykQ9NaRBNxOqs5UT8lWEaq4fDHhsmd8yQuZxDR9RibZ5Vt8gxxXPIq33fUlAJRU
 p1h+qSt+Tzx5X0kuaDVb465ZrscO5DWXioXMDBWPOHKzHYzaFr2pcdzRHz43Wfd/Ot
 tx+jW4YIRwS9c5+DMQFTQ/U7cDbchWQm/QRN+zCMcoBBgxZ6UGxK46eaPnqgH3450I
 zDNqxxZfm4gBkG17Z6hI+cjtPbknntmE/ybCfppCmS4a2qa/j1RwYdNVXb0MWKM5x3
 aRcQMrgvUGkVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-5-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-5-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:14:56 +0000
Message-Id: <20260721181456.AEF271F00A3A@smtp.kernel.org>
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
- [High] Missing Workqueue Cancellation / Use-After-Free in teardown path
--

--- Patch [5]: [PATCH v4 05/10] drm/bridge: synopsys: dw-dp: Support softwa=
re triggered OOB HPD ---
commit 27d73c3f273597742127e6851884d387b3ffe886
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD

This patch adds support for USB-C DP AltMode out-of-band hotplug handling
by allowing platform-specific drivers to implement HPD software
configuration and selection.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 0e8ecd73a0002..8eb2699dc7ab0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -2052,6 +2086,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
> =20
>  	dp->dev =3D dev;
>  	dp->pixel_mode =3D plat_data->pixel_mode;
> +
> +	dp->plat_data.hpd_sw_sel =3D plat_data->hpd_sw_sel;
> +	dp->plat_data.hpd_sw_cfg =3D plat_data->hpd_sw_cfg;
> +	dp->plat_data.data =3D plat_data->data;
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> =20
>  	mutex_init(&dp->irq_lock);

[Severity: High]
This is a pre-existing issue, but is there a missing workqueue cancellation
in the driver teardown path?

In dw_dp_probe(), the driver initializes a work item for hotplug detection
shortly after the modified code block:

    INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);

However, looking at dw_dp_unbind(), the work is never canceled:

    void dw_dp_unbind(struct dw_dp *dp)
    {
        disable_irq(dp->irq);
        phy_exit(dp->phy);
        drm_bridge_put(dp->next_bridge);
        drm_dp_aux_unregister(&dp->aux);
        drm_bridge_remove(&dp->bridge);
    }

Since the dp structure is automatically freed by devres after the remove
callback completes, could this result in a use-after-free if the IRQ
handler schedules the work right before unbound is called, and the work
executes after the dp structure is deallocated?=20

Would it make sense to add a cancel_work_sync(&dp->hpd_work) call to the
teardown path to ensure the work item finishes safely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D5
