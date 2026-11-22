Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B035606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXwIkoeR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE98C10E07B;
	Sun, 22 Nov 2026 15:58:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F6110E07B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:58:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 089B960F73;
 Sun, 22 Nov 2026 15:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB61F000D0;
 Sun, 22 Nov 2026 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795363131;
 bh=VkNsouhm78R/+6qGXHRWt/S5fZecyxYZ6dmODAQUfIQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RXwIkoeR372izVFEogyI+8JpQ1QTIpOZnbkhYNI1M+XheLmpwCqSKP4dUg4JirdXZ
 GLSiN3AN8vAFH7wf8sCXRB50gs2hbTKAfHPcEY0ZJMsHDg0UI6RIYzOad4SsDIs9Vq
 E7Ka+xiCR6L1JjTMd4Up24zg2K2Y1qO1dg/Dat2swqlPkwIfQczLR7eum8V8PhWH6F
 NonYr4w3UZePAZSxJECBBvSe029sMFQxpwUl91kwLUEdqWAbdF9ZkKj49Ze/D07jCA
 lsybAnJBrF7yquh2ek5lgjM8mQT7RyI6h9zdA/zcCpKdq1U3iVOZNsx7EY/hKLBySK
 /B3kl8sSeXdrw==
Message-ID: <sashiko-outbox-228068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: Remove V3D 3.3 and 4.1 support
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
References: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
 <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 15:58:50 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] drm/v3d: V3D 3.x OVRTMUOUT bit reported on V3D 4.2 in
  v3d_v3d_debugfs_ident()
- [Low] drm/v3d: stale V3D 3.3 and 4.1 deprecation notice in v3d_drv.c
  DOC comment
--

commit 24570297f583283eb9b4a58e9c2e78e6081f77f1
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Remove V3D 3.3 and 4.1 support

This commit removes support for the deprecated V3D 3.3 and V3D 4.1 GPUs,
along with their device tree compatibles, GCA and bridge reset registers,
and V3D 3.x performance counter handling.

> diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_=
debugfs.c
> index 634cc796ba232..938622c730d04 100644
> --- a/drivers/gpu/drm/v3d/v3d_debugfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_debugfs.c

[ ... ]

> @@ -210,8 +194,6 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, =
void *unused)
>  		if (v3d->ver <=3D V3D_GEN_42) {
>  			seq_printf(m, "  BCG int:      %d\n",
>  				   (ident2 & V3D_IDENT2_BCG_INT) !=3D 0);
> -		}
> -		if (v3d->ver < V3D_GEN_41) {
>  			seq_printf(m, "  Override TMU: %d\n",
>  				   (misccfg & V3D_MISCCFG_OVRTMUOUT) !=3D 0);
>  		}

[Severity: Low]
Should the "Override TMU" line (along with the misccfg read in
v3d_v3d_debugfs_ident() and V3D_MISCCFG_OVRTMUOUT in v3d_regs.h) be removed
instead of folded into the v3d->ver <=3D V3D_GEN_42 block?

As noted in commit a7dde1b7a5c9 ("drm/v3d: Don't try to set OVRTMUOUT on V3D
4.x."), V3D_MISCCFG_OVRTMUOUT only existed on V3D 3.x, and this patch drops
the corresponding write from v3d_init_core().  Keeping it here causes
v3d_ident on V3D 4.2 to report a V3D 3.x bit that does not exist on V3D 4.x
hardware, and the new "/* Only V3D 4.x */" comment above
V3D_MISCCFG_OVRTMUOUT in v3d_regs.h is also inaccurate.

[ ... ]

> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index b790be8a7face..0551e9abf17ea 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c

[ ... ]

> @@ -421,18 +392,6 @@ static int v3d_platform_drm_probe(struct platform_de=
vice *pdev)
>  	 */
>  	WARN_ON(v3d->ver !=3D gen);
> =20
> -	/* V3D 3.3 and V3D 4.1 has had no in-tree userspace since Mesa
> -	 * dropped support in 2024 (MR#25851) and they have no known users.
> -	 * Due to that, support is scheduled for removal in the next release.
> -	 */
> -	if (v3d->ver <=3D V3D_GEN_41) {
> -		dev_warn(dev,
> -			 "V3D %u.%u support is deprecated and will be removed "
> -			 "in the next kernel release. If you rely on this hardware, "
> -			 "please report it to dri-devel@lists.freedesktop.org.\n",
> -			 v3d->ver / 10, v3d->ver % 10);
> -	}
> -
>  	v3d->cores =3D V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);

[Severity: Low]
Should the deprecation paragraph in the "DOC: Broadcom V3D Graphics Driver"
comment at the top of drivers/gpu/drm/v3d/v3d_drv.c also be removed now that
V3D 3.3 and 4.1 support is gone?

drivers/gpu/drm/v3d/v3d_drv.c:
    ...
     * This driver supports the Broadcom V3D 4.2 and 7.1 GPUs.
     *
     * Support for V3D 3.3 and 4.1 GPUs is deprecated and it will be removed
     * in the next kernel release.
    ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-v3d-remove=
-33-41-v1-0-52152b454ad8@igalia.com?part=3D2
