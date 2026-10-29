Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549C606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HAHrjgNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DAE1121D0;
	Thu, 29 Oct 2026 10:31:08 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14901121D0;
 Thu, 29 Oct 2026 10:31:00 +0000 (UTC)
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: lst@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6E0F52000E3;
 Thu, 29 Oct 2026 11:30:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1793269859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vReinFyJuq/ESO/NM1w8p1Ykf2lFRhtp9bKhJhu9+p0=;
 b=HAHrjgNadQOzCFzerIWjXpjCt0BxnmL7Iaxw+OXjvuGf6abeziszPqrl2pXQuWzUWjS+Gy
 h6ocSJ+SirkfVvo568/YhOabEa7uEaYnsp4nEaLMnnQ8MF51DMtZKblfTwOkkm0jLnrjra
 +0YYMqp1tgdoK8fhfV+aTFnHw2MrXeYq1DsJ9xnP7q6LLMLGlscW6015mNoOJqQVSEaa6l
 EaeDPdckz96E0TGJghN2JE6dB0g3mo+2uA64ATN+X4WyOc1j7XfOFS/TIGlysxzGAn9Dyi
 7zIZQHZcvFegzaRPjahHkFn7ZxJrddTuIk6G+h9AcqpfmDx4asRSmnJq4bleuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1793269859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vReinFyJuq/ESO/NM1w8p1Ykf2lFRhtp9bKhJhu9+p0=;
 b=KmQzt2pvfrQmPxV9buNk39KBsTE7geM+OZt6fyJi2g2INHwX56KCxa9C4DB+uVY3we5VrU
 rLWdWPGNt3aM+jIAD3lNKeMufmOmx+eOLLbzHsKCN6Lt/IEbhlSvqvrVEMi6egXIMI9mr+
 Zswb9+anneeVTCFjxjaMGIBGKvsICvX0NAyUiwfcSjDnin2Dhn4aNL8WmciXULrXejUB9u
 tZR+/pnTDfkW6gtWS3DHAfmzpND4aIoAmpslzfcXDtivDLuBXdlvpouFnxZ1FEgJXiiG1s
 46LK8028OHAK0bUUKMqhdnfDK7EkX/tJ13CTIyQwvVCsnHlvm1L0eqGBUAamQw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793269859; a=rsa-sha256;
 cv=none;
 b=Kl6fF4e1rilfJxkycY7uZhMMx603SVYKOZTLapb7cXRbXt1nORdwD9gEiFhnUIvoNZgjWx
 hDCWB8KjybiTFyKXcZmZ6uXj6JhbxjYvdmhKZragSymSMxHNNLI19rnBDYQ4vy68PlrFpF
 UofZahKaaGl4BW6SluZzFIjTUkbahqDTwQqhwbU9mr41ijyDf4b/wr97I/iv38VDXbd/xA
 UUD3+h46cvYVI5VY/axoYfGFTuES8eX5EQfkV+QY092tYXqqauYoEMLVBZZ8Jl8XlcHD7a
 /yKdJJYs2wbw6qyogOY9JvCfjMdqvcmfW2UB4RxhZzdCDkq4/Vt3LspjDmquUQ==
Message-ID: <4b9c47028821bfcc0969f8ca811360fce096a3d9.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/etnaviv: Remove deprecated fence_ops->release()
From: Lucas Stach <l.stach@pengutronix.de>
To: Philipp Stanner <phasta@kernel.org>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Thu, 29 Oct 2026 11:30:59 +0100
In-Reply-To: <20261028103129.1036380-3-phasta@kernel.org>
References: <20261028103129.1036380-2-phasta@kernel.org>
 <20261028103129.1036380-3-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Mittwoch, dem 28.10.2026 um 11:31 +0100 schrieb Philipp Stanner:
> The dma_fence->ops->release() callback is deprecated because it prevents
> drivers from unloading. All etnaviv does in its implementation is invoke
> a kfree_rcu() on the fence.
>=20
> The fence backend by now also frees fences with kfree_rcu() if
> ops->release() is not implemented.
>=20
> Remove the deprecated callback.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Please take this through drm-misc or whatever tree is convenient.

Regards,
Lucas

> ---
> Just compile-tested.
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index e51a310c8d70..e75dab5e407d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1176,18 +1176,10 @@ static bool etnaviv_fence_signaled(struct dma_fen=
ce *fence)
>  	return (s32)(f->gpu->completed_fence - f->base.seqno) >=3D 0;
>  }
> =20
> -static void etnaviv_fence_release(struct dma_fence *fence)
> -{
> -	struct etnaviv_fence *f =3D to_etnaviv_fence(fence);
> -
> -	kfree_rcu(f, base.rcu);
> -}
> -
>  static const struct dma_fence_ops etnaviv_fence_ops =3D {
>  	.get_driver_name =3D etnaviv_fence_get_driver_name,
>  	.get_timeline_name =3D etnaviv_fence_get_timeline_name,
>  	.signaled =3D etnaviv_fence_signaled,
> -	.release =3D etnaviv_fence_release,
>  };
> =20
>  static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu=
)
