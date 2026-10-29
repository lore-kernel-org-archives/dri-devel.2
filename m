Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC095606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ouu3AuL0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3508E1121C6;
	Thu, 29 Oct 2026 10:30:03 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D534B1121C2;
 Thu, 29 Oct 2026 10:29:56 +0000 (UTC)
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: lst@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4DBAB200467;
 Thu, 29 Oct 2026 11:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1793269795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNplS0zzpx7i/xZRFiwu1m1gWz/uU3B841QxYLsWDE8=;
 b=Ouu3AuL0td/GA4CXCAjqkAnzYyeT5NMT8eTLTB/dP/g70gpRL2muYm+LHuykTlbc7pzZmX
 6FD0solH2WX/omdPMbWp4gj5e5PgcI7mOmj1pdSNARzNjb8GSxPNFkZOCst1+2jxoitcrH
 9rz4m555/XT0xz2e0J+yN9s/0yCiVkJIL7a0KRNwpYUb5l9gl0F//PVZBnHRTjUbMm4Fn1
 z6CJjulAGMOz888RDmKJ0gU2A9Mr2mCRWD36yUJHP44GLDMPVCN1utoTCoClbjqaJG7E6u
 qpilQFSuo29FPvslQNVLOzgdcnZVLqvM0clx8BE6Ka63yWbnNLbLTAB0XLAN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1793269795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNplS0zzpx7i/xZRFiwu1m1gWz/uU3B841QxYLsWDE8=;
 b=YQ16bMiv/93sxnl9JqbF24Sbj6pC0xgEZhW9f5RaWujz0EMIt5Dcs87Int1qAwHJ77GEV/
 Z/tju4N6Wgc9ElEvrgI/1mjkVK1twZD8knwuEB93hF+XnyLiijsFDgit0nvA72ElQWG5El
 iE8+NPfzcVxw0gZ9AUSQi0axsvLqNJM1miWNBZuLRLsJuT6JCvPxziJZvnmbGKXczqrBOC
 dbiTh8bAKFYrLsxyZwpH27weRWS/NqhtTBvCMevWJEEQNic8XUPWQTk+1nSkNlKzqe87Mw
 8sCnaQ74l+xLGzzEdf1lh7DMhJ41ZJLv0gvQo/Dv/Jy29hSuT+/JgCfAiaxaPg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793269795; a=rsa-sha256;
 cv=none;
 b=fWBfDvbpU5d8hVbO1VhAWCs2Snz+MZ/iyDtvFGSV42bwV9cs0FSgeo27XWBUGshFI6KUlY
 yH7T4D8JP4FoNqIOcu+DpGB+XD2TT4ogF01tFarf2X2qyw7o8tUJl4rr76chynHPgYdJJm
 egKCyG9TmQNepL+yZehQKfnwW6wprc2xsbluqTmNvVlwJgbdCY+c2pvnamdoSQAqI7xK+Z
 5pej/vDshrujw9SUnTb64FyFXYU1D2lX20hnK+BMv97xwsYRGrhKb+Ec3uXLv/FTay0l41
 A/gT95DSGSG1E+qHW0+CpM9yp6W3/n+BqPgkeK5LOh0xMf5m+XdQG4ajv/nWXw==
Message-ID: <70665d4cee43685f603beb94f220848cd00e02ab.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] drm/etnaviv: etnaviv_fence: Put base class first
From: Lucas Stach <l.stach@pengutronix.de>
To: Philipp Stanner <phasta@kernel.org>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Thu, 29 Oct 2026 11:29:55 +0100
In-Reply-To: <20261028103129.1036380-2-phasta@kernel.org>
References: <20261028103129.1036380-2-phasta@kernel.org>
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
> struct etnaviv_fence contains a struct dma_fence, which is its base
> class. The base class should always be the first member of a class.
>=20
> This allows for removing a deprecated callback in a subsequent patch.
>=20
> Make struct dma_fence base the first member of struct etnaviv_fence.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 5c23182f4d33..e51a310c8d70 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1148,8 +1148,8 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, st=
ruct seq_file *m)
> =20
>  /* fence object management */
>  struct etnaviv_fence {
> -	struct etnaviv_gpu *gpu;
>  	struct dma_fence base;
> +	struct etnaviv_gpu *gpu;
>  };
> =20
>  static inline struct etnaviv_fence *to_etnaviv_fence(struct dma_fence *f=
ence)
>=20
> base-commit: 731ba09867520c047c7de53f92e384808e0b638e
