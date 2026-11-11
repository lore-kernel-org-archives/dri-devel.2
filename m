Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F2606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Usp2HrwT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BEB10E00E;
	Wed, 11 Nov 2026 21:30:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D468310E00E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 21:30:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A08543811;
 Wed, 11 Nov 2026 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F38E1F00A05;
 Wed, 11 Nov 2026 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794432612;
 bh=kilTdcFHlKTizIuKvbkDsTnd4nBDrXHDz8MXX8QOCww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Usp2HrwTiZ4nLcQM9cPA95D/F6cxFdbb4jGEmKTgbsjAvzPyohoO1PTvS3Yn5wPwC
 XISSizzBchSg0oxGnQHYTylnq6Lxw84MmVUcA0qWf8OYrP6EWNtzNKBTFtpXIKhxtW
 8/JgUjf1doy41NJP27J7ehPiSBo/9sPpKhG2FFbCyqE2h8JtwQNKeySjK+ge26ds8a
 dmyvQ3oNoIFAVmNvkcBggAi64YssWhG/5pmJTSOWC1iydCu15mk2bGsM5iAH5x7VIN
 jhIQ0YzhqS8lcmy72EwDdA/ImJZIpfNptMw9b8RRJK6CDRKhkfIUZrnzFgf9VdOyTb
 mDc2XXJDNPs/Q==
Message-ID: <sashiko-outbox-209709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:30:11 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/omap: dss: unreachable NULL check and error label in
  omapdss_device_init_output()
--

commit f6c9c857e7ddd89b0afd04f9a84b349ebb1ccb32
Author: Andreas Kemnade <andreas@kemnade.info>

drm/omap: dss: fix handling deferrals

This commit forwards -EPROBE_DEFER from of_drm_get_bridge_by_endpoint() in
omapdss_device_init_output() instead of ignoring it as a missing video
sink.

> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapd=
rm/dss/output.c
> index 36d37deac8026..b5cef5093a883 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *=
out,
> =20
>  	bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_por=
t, 0);
>  	if (IS_ERR(bridge)) {
> +		if (PTR_ERR(bridge) =3D=3D -EPROBE_DEFER)
> +			return PTR_ERR(bridge);
> +
>  		dev_dbg(out->dev, "failed to find video sink\n");
>  		return 0;
>  	}

[Severity: Low]
Can the !out->bridge check, local variable ret, and the error label later
in omapdss_device_init_output() be removed as well?

of_drm_get_bridge_by_endpoint() returns an error pointer rather than NULL
when no bridge is found, and the IS_ERR(bridge) branch returns early. With
-EPROBE_DEFER handled here, out->bridge is never NULL in the local_bridge
block and the error path left over from b7e9b93fc8ec ("drm/omap: dss:
don't create a panel_bridge") is unreachable:

drivers/gpu/drm/omapdrm/dss/output.c:omapdss_device_init_output() {
	...
	if (local_bridge) {
		if (!out->bridge) {
			ret =3D -EPROBE_DEFER;
			goto error;
		}
	...
error:
	omapdss_device_cleanup_output(out);
	return ret;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-gta04-drm-=
regression-fix-v2-1-010caf3b08bd@kemnade.info?part=3D1
