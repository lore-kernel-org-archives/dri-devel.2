Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B3BCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9669C10EF22;
	Wed, 20 May 2026 07:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="h0XyaRAd";
	dkim-atps=neutral
X-Greylist: delayed 413 seconds by postgrey-1.36 at gabe;
 Tue, 19 May 2026 07:50:36 UTC
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B1410E26E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1779176620;
 bh=WE3c349agN86JsGsWRZz2FB/FUQqI/3vABu7hjIFay8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=h0XyaRAds70kGUnNLn9TxiTSsMUGb/Mr4DKJcpVwxrd6/u3olsjnMv/e64V128QbY
 6wL2iNo7Z8+M1GerrlBoIFIjz1IEOjx9E4NGx0XDoL8W9cZNZY3/iIqYEm7+sQnLdO
 PwdAZ1BQJ8FvKj29ZJ1nUPH3974CoY23k79U5XRo=
Received: from [127.0.0.1]
 (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com
 [IPv6:2607:8700:5500:e873::1001])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id CFBE26597E;
 Tue, 19 May 2026 03:43:38 -0400 (EDT)
Message-ID: <580c761b3297a079b88823ce323c131b57696e71.camel@xry111.site>
Subject: Re: [PATH] drm/loongson: add cleanup path for lsdc_ttm_init
From: Xi Ruoyao <xry111@xry111.site>
To: yaolu@kylinos.cn, lvjianmin@loongson.cn, wuqianhai@loongson.cn
Cc: chenhuacai@kernel.org, jeffbai@aosc.io, zhengxingda@iscas.ac.cn, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 15:43:36 +0800
In-Reply-To: <20260519074158.144134-1-yaolu@kylinos.cn>
References: <20260519074158.144134-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-05-19 at 15:41 +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
>=20
> There has resource leak when TTM_PL_VRAM or TTM_PL_TT man range init
> failed.
>=20
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongs=
on/lsdc_ttm.c
> index d7441d96a0dc..c84bc582f77c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -554,7 +554,7 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
> =C2=A0
> =C2=A0	ret =3D ttm_range_man_init(&ldev->bdev, TTM_PL_VRAM, false, num_vr=
am_pages);
> =C2=A0	if (unlikely(ret))
> -		return ret;
> +		goto err_vram;
> =C2=A0
> =C2=A0	drm_info(ddev, "VRAM: %lu pages ready\n", num_vram_pages);
> =C2=A0
> @@ -565,11 +565,17 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
> =C2=A0
> =C2=A0	ret =3D ttm_range_man_init(&ldev->bdev, TTM_PL_TT, true, num_gtt_p=
ages);
> =C2=A0	if (unlikely(ret))
> -		return ret;
> +		goto err_gtt;
> =C2=A0
> =C2=A0	drm_info(ddev, "GTT: %lu pages ready\n", num_gtt_pages);
> =C2=A0
> =C2=A0	return drmm_add_action_or_reset(ddev, lsdc_ttm_fini, ldev);

Isn't the error handling path also needed in case
drmm_add_action_or_reset fails?

> +
> +err_gtt:
> +	ttm_range_man_fini(&ldev->bdev, TTM_PL_VRAM);
> +err_vram:
> +	ttm_device_fini(&ldev->bdev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void lsdc_ttm_debugfs_init(struct lsdc_device *ldev)

--=20
Xi Ruoyao <xry111@xry111.site>
