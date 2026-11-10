Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6A606B595
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hANm5RbU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BC610E076;
	Tue, 10 Nov 2026 11:52:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1132410E076
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:52:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2EC460E1D;
 Tue, 10 Nov 2026 11:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0451F0089F;
 Tue, 10 Nov 2026 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794311518;
 bh=NyJeAs3eQKkX3mm5wMmuSTEE5YDtpIpuRWQLRWEqVyA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hANm5RbU31M2Rd03n9ClyL/Huv8OM31i7bxVaGVrun0nzfNiqMh6oZ69cCz80M3rI
 6+o35MZ6mD9LZFhROsQ9KMNJ8igywatVFk9GEvyFDskFvBgz9PjaDZm+eeGe+Ge9hS
 BNeB29ZFGuAhvfi8L69/zzUlQDAi645cwiQUN/VKWmEpux90XLEZUENkg0tdbDaYyu
 aC8AiZLngBA9VLtHzbM+3Ibch/vZwu8XRM/iZFMGXNpERGBtPmxVhriDaWWLlcPVa2
 KyJB7tMDq5ODcuM5KzSkOaZ2EtyBGl3vJ8IF7EHFCj/fTZEKHyuW438pdmOTCUeghV
 y70c2C4J3KZug==
Message-ID: <sashiko-outbox-206960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: renesas: rz-du: mipi-dsi: Drop duplicate
 platform_set_drvdata() call
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261110114622.229608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261110114622.229608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:51:58 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm: renesas: rz-du: null pointer dereference in
  rzg2l_mipi_dsi_probe() [1]
--

commit dcaf0e503b70614276db2fd071bf963a09140504
Author: John Madieu <john.madieu.xa@bp.renesas.com>

drm: renesas: rz-du: mipi-dsi: Drop duplicate platform_set_drvdata() call

This commit removes a redundant platform_set_drvdata() call in
rzg2l_mipi_dsi_probe().

> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 5b257f5adf06c..985d6e02203c1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1576,8 +1576,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_dev=
ice *pdev)
>  	if (!dsi->dcs_buf_virt)
>  		return -ENOMEM;
> =20
> -	platform_set_drvdata(pdev, dsi);
> -
>  	ret =3D rzg2l_mipi_dsi_pwrrdy_init(dsi);
>  	if (ret)
>  		return ret;

[Severity: High]
This problem wasn't introduced by this patch, but can a NULL pointer
dereference occur in rzg2l_mipi_dsi_probe() [1] if the driver is
manually bound via sysfs without matching device tree data?

drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c:rzg2l_mipi_dsi_probe() {
	...
	dsi->info =3D of_device_get_match_data(&pdev->dev);
	...
	ret =3D rzg2l_mipi_dsi_pwrrdy_init(dsi);
	...
	ret =3D dsi->info->dphy_init(dsi, 80000000ULL * MILLI);
	...
}

of_device_get_match_data() returns NULL when no match is found, and
dsi->info is later dereferenced without a NULL check in
rzg2l_mipi_dsi_pwrrdy_init() and when calling dsi->info->dphy_init().

[1] https://sashiko.dev/#/bug/linux-14b243a7-c808-4384-b0dc-3416dc888b2a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110114622.2296=
08-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
