Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB000C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD4610E2F3;
	Tue, 25 Aug 2026 00:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSsNVKpF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16DA10E189
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EAFE6011F;
 Tue, 25 Aug 2026 00:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9851F000E9;
 Tue, 25 Aug 2026 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787617674;
 bh=wgaHDWd1x6ykOY2OZuR67Shdj6eHfONWyUqlQsmN1MI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSsNVKpFvHFc19NsrqpylluIFlZhW0fFzJnYiVQdnSxEr23g+AtF6U9HXKhWXYyWg
 IRdh7+im8U6fqYImzcHQrAIxL1g2P9UhES/LsWYqf8+f6TThN0YPlMwyX4rkjTlwPb
 4/iEXqa3bilFf5MQj8opCm8VFDjfzhiBC1JowExm6tYAqxeYogqIWjVmju1N680tlz
 FrCsqLB9kk3mX2A0ArrIVqeY/U6jjhkhmj/mC7yv+p/z2FDKMGk2zMLn/lC8wo/bXy
 k7bCT96hkqyUubeUfk2B6flZNNcwXS2sz4JVpcXjDNpCqpreUeWsFFGwcN1xhHLpac
 CYIPs7X1Dcwdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] drm/nouveau: honor HF-EEODB EDIDs by
 converting to struct drm_edid
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825001408.14219-11-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
 <20260825001408.14219-11-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 00:27:53 +0000
Message-Id: <20260825002754.2B9851F000E9@smtp.kernel.org>
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
- [High] Potential out-of-bounds read when copying the EDID from a Device T=
ree property.
--

--- Patch [10]: [PATCH v3 10/10] drm/nouveau: honor HF-EEODB EDIDs by conve=
rting to struct drm_edid ---
commit a90c1b47260c1e8987750f3b4670510323a260f4
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

This commit converts the nouveau driver to use the struct drm_edid API=20
instead of the legacy EDID APIs. This allows the driver to properly honor=20
HF-EEODB EDIDs by tracking their true block size instead of truncating them=
.=20
The patch updates various EDID retrieval and parsing paths to use the new=20
allocation and validation infrastructure.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index b0b0ad9a0c248..3738c23215c58 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -490,8 +520,17 @@ nouveau_connector_of_detect(struct drm_connector *co=
nnector)
>  		int idx =3D name ? name[strlen(name) - 1] - 'A' : 0;
> =20
>  		if (nv_encoder->dcb->i2c_index =3D=3D idx && edid) {
> -			nv_connector->edid =3D
> -				kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
> +			const struct drm_edid *drm_edid =3D
> +				drm_edid_alloc(edid, EDID_LENGTH);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the device
tree to provide an EDID property smaller than EDID_LENGTH?

In nouveau_connector_of_detect, of_get_property is called with a NULL length
pointer, discarding the actual size of the firmware property. If the proper=
ty
is shorter than 128 bytes, drm_edid_alloc (and the previous kmemdup call)
will perform an out-of-bounds read which could potentially trigger a panic =
if
the memory access crosses an unmapped page boundary.

Would it make sense to pass a length pointer to of_get_property and verify
the property is at least EDID_LENGTH bytes before attempting to allocate it?

> +
> +			/* Firmware-provided, so validate it like the DDC
> +			 * readers would.
> +			 */
> +			if (drm_edid && !drm_edid_valid(drm_edid)) {
> +				drm_edid_free(drm_edid);
> +				drm_edid =3D NULL;
> +			}
> +			nouveau_connector_set_edid(nv_connector, drm_edid);
>  			return nv_encoder;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825001408.1421=
9-1-mohamedahmedegypt2001@gmail.com?part=3D10
