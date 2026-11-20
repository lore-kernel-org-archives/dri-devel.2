Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EE606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCtQUt8y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8600910E119;
	Fri, 20 Nov 2026 10:53:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DCB10E119
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:53:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F9EF61165;
 Fri, 20 Nov 2026 10:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136821F000CA;
 Fri, 20 Nov 2026 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795171986;
 bh=ESaHeBDa3dZ8Y3LM3Yrtm8UyVAUWN5rWrk8IE3TggzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCtQUt8yAAxYRbqcqG4hesZLipeS9ELyCXVaEPgN/d6cAieGcUZFQgGV3ng38n+5j
 gMwglN7Mx2INz9TzrWWMTHtoN8mBDPHDFFP3vfQSNsHbOF4ljA7SP15HPIU5mR5JEg
 nb23T2ZsmlJzPr0QdFkIeg0yKdDkKxOElHbebTlAbZ3vYavbh0pkgMGlpGxPJMKmIz
 6Rr8xtJTRep1m0kFm/bLwp4/wN/BJV9vchjE+6toiUztAtgRIC/fiIi35VfRy30A6G
 tMNbW9FumzELYb/eSQJ/4JeNvkPamDK4a5blG7gxoG3Mz7AACKzhPvxff+GWoHGAzF
 vKEGxV/oBIz2g==
Message-ID: <sashiko-outbox-224969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] drm/etnaviv: Don't set up a GPU on resume that is
 not initialized
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-1-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
 <20261120-etnaviv-gpu-freq-trace-v1-1-445fc6eacddf@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:53:05 +0000
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
- [Critical] drm/etnaviv: dangling pointer in
  etnaviv_flop_reset_ppu_init() [1]
--

commit e39a29696b51cde581759634e80e80a231bf7a60
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Don't set up a GPU on resume that is not initialized

This commit resets gpu->state to ETNA_GPU_STATE_UNKNOWN when
etnaviv_gpu_init() fails or during etnaviv_gpu_unbind(), and preserves
that state across runtime suspend so uninitialized GPUs are not set up
on resume.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 6a4aab75ebba5..2a15ae6135f5e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -951,6 +951,8 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	return 0;
> =20
>  fail:
> +	/* the GPU is not used, a resume must not set it up */
> +	gpu->state =3D ETNA_GPU_STATE_UNKNOWN;
>  	pm_runtime_mark_last_busy(gpu->dev);
>  pm_put:
>  	pm_runtime_put_autosuspend(gpu->dev);

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
etnaviv_flop_reset_ppu_init() during etnaviv_gpu_init() leave a dangling
pointer in priv->flop_reset_data_ppu [1]?

drivers/gpu/drm/etnaviv/etnaviv_flop_reset.c:etnaviv_flop_reset_ppu_init() {
	...
	int ret =3D etnaviv_cmdbuf_init(priv->cmdbuf_suballoc,
				      priv->flop_reset_data_ppu, buffer_size);
	if (ret) {
		kfree(priv->flop_reset_data_ppu);
		return ret;
	}
	...
}

Because load_gpu() ignores errors from etnaviv_gpu_init() and keeps the
DRM device bound, a subsequent GPU core sees a non-NULL
priv->flop_reset_data_ppu, skips initialization, and dereferences the
freed command buffer in etnaviv_flop_reset_ppu_run() (use-after-free).
On device unbind, etnaviv_unbind() also passes the dangling pointer to
etnaviv_cmdbuf_free() and kfree(), causing a double free.

[1] https://sashiko.dev/#/bug/linux-4d0f1113-6871-425a-a512-96f1b1788e33

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-etnaviv-gp=
u-freq-trace-v1-0-445fc6eacddf@igalia.com?part=3D1
