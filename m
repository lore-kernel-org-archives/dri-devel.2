Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6340606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRlOfHAi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DE710E1FC;
	Fri,  6 Nov 2026 09:27:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C5910E1FC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:26:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4050D415B6;
 Fri,  6 Nov 2026 09:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056D51F00902;
 Fri,  6 Nov 2026 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793957215;
 bh=D9h7kXOjbkcftuC8ZrO7FTJtYma8avLx+88lPrS4EXQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HRlOfHAiYXfSMUDdkixpxEX1k2DxNLNoCgdMBjJVoEVLnM8tlzs8DGrFD89ODMPjt
 uOM3osccl9tpRoJUYQpGo6CdnRT56bx7zopNPZW+lKYr+2Jd3ri8NRl1mTdFUcbOyX
 KUbYYin2m2z1x72EpAfI0//hMYpzRNLMlkmjhfDDVczhNHGOIvxakQs4u3yZu3FPIK
 JBOQxSa2ik2vPKG/cu9vmRuNRZ+npqWUSdO/CsHXsJDoWBqTVEhR03nKZx1qMOqLpf
 X/kJ17vUxm9D9vufjuNXXrMeOL1Cr14qiU+b0AsBAXQB6GzHBQ5sT5Z0mLA1KIiaBe
 DJgAXgkKSEGTA==
Message-ID: <sashiko-outbox-201105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: Keep the mutex node reference across
 deferred binds
To: "Yige Jiang" <yigejiang86@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <confirmed-20261105-38-2e09963f1b23@gmail.com>
References: <confirmed-20261105-38-2e09963f1b23@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:26:54 +0000
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
- [Medium] drm/mediatek: device node reference leak in mtk_drm_probe()
  [1]
--

commit ca36688b98d58f438e7795c4737e318297cc995d
Author: Yige Jiang <yigejiang86@gmail.com>

drm/mediatek: Keep the mutex node reference across deferred binds

This commit removes the of_node_put(private->mutex_node) call from the
-EPROBE_DEFER error path in mtk_drm_bind() so the reference acquired in
mtk_drm_probe() is retained until probe failure or mtk_drm_remove().

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index dc8e3e917dd77..64c912ba95899 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -630,7 +630,6 @@ static int mtk_drm_bind(struct device *dev)
>  	if (!pdev) {
>  		dev_err(dev, "Waiting for disp-mutex device %pOF\n",
>  			private->mutex_node);
> -		of_node_put(private->mutex_node);
>  		return -EPROBE_DEFER;
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can mtk_drm_probe() leak
a device_node reference in private->mutex_node [1]?

drivers/gpu/drm/mediatek/mtk_drm_drv.c:mtk_drm_probe() {
	...
	for_each_child_of_node(phandle->parent, node) {
		...
		if (comp_type =3D=3D MTK_DISP_MUTEX) {
			int id;

			id =3D of_alias_get_id(node, "mutex");
			if (id < 0 || id =3D=3D private->data->mmsys_id) {
				private->mutex_node =3D of_node_get(node);
				dev_dbg(dev, "get mutex for mmsys %d", private->data->mmsys_id);
			}
			continue;
		}
	...
}

If the loop matches more than one MTK_DISP_MUTEX child node (for instance,
when multiple mutex nodes have no "mutex" alias), private->mutex_node is
overwritten without calling of_node_put() on the previously acquired node,
leaking its reference.

[1] https://sashiko.dev/#/bug/linux-6030c65d-4659-4fa7-8aa2-9eff923ac68e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/confirmed-20261105-=
38-2e09963f1b23@gmail.com?part=3D1
