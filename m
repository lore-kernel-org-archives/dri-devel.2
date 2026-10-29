Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A74606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl19u8Gk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622E71123E7;
	Thu, 29 Oct 2026 15:41:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2708F1123E7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:41:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90EDF601F8;
 Thu, 29 Oct 2026 15:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D23B1F01816;
 Thu, 29 Oct 2026 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793288478;
 bh=Uy1BNptO6TGnwphFU2BzxiWuSm3igjfnH9DTXVn4OLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jl19u8GkF5P0R2oUznd2mGXgPKhrIk1tyTFCVTOP4tJaMcSepLyIJGZo8BiCGqmoj
 mnK2Fh3Bn7PPqbH5BWqcttnc8a/gs9FZ2WE290DBZTXM8PLRDA5x6xecfQD3xVju2r
 p2P4+fpjvsoc8k8x3/REpfCXHHbqbLl76UcOBZore8ZdvIQRf9EJTp0w5mjAAeM05u
 Vj1+1TyiIEoJdWSDbt+k6JVk4Kl9NP134gad7k3mnCnUQJjhbHtTkCgrkxhpEUQ507
 RTI+Pn6O5c57AyiuFwFQtH2X6Wq+F5vgEuCUOUxWPkrSLRbY3N03G7CE7ynxCC4JjR
 TLgeOqwlZdw1Q==
Message-ID: <sashiko-outbox-189627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] drm/tegra: Make panel parsing by
 tegra_output_probe() optional
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029152909.234584-8-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:41:17 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/tegra: skipped bridge lookup in tegra_output_probe() breaks HD=
MI
--

commit 7887570371c7e1244731285458cba8facf234cb7
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: Make panel parsing by tegra_output_probe() optional

This commit adds a boolean get_panel parameter to tegra_output_probe() so
callers can skip panel and bridge lookup in the common output probe path.
It passes false from tegra_dsi_probe() and tegra_hdmi_probe(), and true
from tegra_dc_rgb_probe() and tegra_sor_probe().

> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index 0d2c0ab0a63e9..c0845bb45bb15 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -1855,7 +1855,7 @@ static int tegra_hdmi_probe(struct platform_device =
*pdev)
> =20
>  	hdmi->output.dev =3D &pdev->dev;
> =20
> -	err =3D tegra_output_probe(&hdmi->output);
> +	err =3D tegra_output_probe(&hdmi->output, false);
>  	if (err < 0)
>  		return err;
> =20
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/outpu=
t.c
> index d0ba3bd0aab8f..ff2e28a1e00b7 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -94,7 +94,7 @@ static irqreturn_t hpd_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> -int tegra_output_probe(struct tegra_output *output)
> +int tegra_output_probe(struct tegra_output *output, bool get_panel)
>  {
>  	struct device_node *ddc, *panel;
>  	const void *edid;
> @@ -104,31 +104,33 @@ int tegra_output_probe(struct tegra_output *output)
>  	if (!output->of_node)
>  		output->of_node =3D output->dev->of_node;
> =20
> -	err =3D drm_of_find_panel_or_bridge(output->of_node, -1, -1,
> -					  &output->panel, &output->bridge);
> -	if (err && err !=3D -ENODEV)
> -		return err;
> -
> -	panel =3D of_parse_phandle(output->of_node, "nvidia,panel", 0);
> -	if (panel) {
> -		/*
> -		 * Don't mix nvidia,panel phandle with the graph in a
> -		 * device-tree.
> -		 */
> -		WARN_ON(output->panel || output->bridge);
> -
> -		if (output->panel) {
> -			drm_panel_put(output->panel);
> -			output->panel =3D NULL;
> -		}
> -
> -		output->panel =3D of_drm_find_panel(panel);
> -		of_node_put(panel);
> -
> -		if (IS_ERR(output->panel)) {
> -			err =3D PTR_ERR(output->panel);
> -			output->panel =3D NULL;
> +	if (get_panel) {
> +		err =3D drm_of_find_panel_or_bridge(output->of_node, -1, -1,
> +						  &output->panel, &output->bridge);
> +		if (err && err !=3D -ENODEV)
>  			return err;

[Severity: High]
Does guarding drm_of_find_panel_or_bridge() behind get_panel in
tegra_output_probe() while passing false from tegra_hdmi_probe() break
HDMI outputs that use an OF graph bridge or connector?

In tegra_output_probe(), drm_of_find_panel_or_bridge() populates both
output->panel and output->bridge. Because tegra_output_probe() is the only
place in the driver that resolves output->bridge from the device tree OF
graph, calling tegra_output_probe(&hdmi->output, false) from
tegra_hdmi_probe() leaves hdmi->output.bridge permanently NULL and skips
probe deferral when a downstream bridge has not probed yet.

When tegra_hdmi_init() later runs:

drivers/gpu/drm/tegra/hdmi.c:tegra_hdmi_init() {
	...
	if (hdmi->output.bridge) {
		err =3D drm_bridge_attach(&hdmi->output.encoder, hdmi->output.bridge,
					NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
		...
		connector =3D drm_bridge_connector_init(drm, &hdmi->output.encoder);
		...
	} else {
		drm_connector_init_with_ddc(drm, &hdmi->output.connector,
					    &tegra_hdmi_connector_funcs,
					    DRM_MODE_CONNECTOR_HDMIA,
					    hdmi->output.ddc);
		...
	}
}

the if (hdmi->output.bridge) branch becomes unreachable. On Tegra20,
Tegra30, and Tegra114 boards that describe HDMI via an OF graph port
connected to an hdmi-connector or external bridge (where DDC and HPD
belong to the remote node rather than legacy properties on the HDMI node),
falling back to the non-bridge connector path leaves output->ddc and
output->hpd_gpio NULL, causing tegra_output_connector_detect() to
permanently report connector_status_disconnected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152909.2345=
84-1-clamor95@gmail.com?part=3D7
