Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8F606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=J8U3SKmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0763B10FB2F;
	Wed,  4 Nov 2026 11:03:33 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78A110E1B6;
 Wed,  4 Nov 2026 11:03:26 +0000 (UTC)
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: lst@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5AE0A2000A8;
 Wed, 04 Nov 2026 12:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1793790205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdhY1e8I9Jc14rbguEsTrJ/gz2O3WFLt1vbqMY/V0N4=;
 b=J8U3SKmWWxVCZ9ri9MgTERn6+2G+RR+s/tg6Q9IZNrju32WRUDKt710/4LdzjX+CBOXV0t
 jY1ooIwG53Dwn298lur7/fP0dnjKvzqf5VEK5VYB4icXGb5Mat5SEOjhVcA3wKiBoiNTtL
 qXpZxmI021zJE1ED89itFtTUXMmHBiSDwjHoSYsmOKXOs0Mtl1LonK5qsvyJw1kC4qFY2y
 x6DdpsVP0IE4tEEUiiiYiAVDt1pECwx2BUQ1he2pe1V/LxS8h6e39AK8DNHqkbifxdnyZ6
 Z1Fte+FtHdojA8QYjKB/PShPtV3beWQvP/9t2Zyx5SmQN+roc+/YPWaClX100w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1793790205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdhY1e8I9Jc14rbguEsTrJ/gz2O3WFLt1vbqMY/V0N4=;
 b=Re5hC0QPlRzDDIn4XsPZF7CKDEs4ZEMdfq6s0nMc8BnbczBE60Dh1h45hOF9PU7m5bK+zJ
 /4jF2oC39hcK3v3WqSVN7xbNwzREamMwCOpcBS/HyyCD7Zx54cmqu1SJRJwfat3L6leqUO
 xeIAnMy1qqcCbcSiZX0SCh9enTSntpMkk/sDE5pnKGULm0vnOoWemhQbub4UZPfvBXE0/o
 neC+703xUUuiM2CTN2887xtXir56eb2bJ1cmTOOmZCXn5ravuLb9HnXMToPCXrLu/O/Rj9
 dFEWtN22qzho14EtO3jVAEStCkSmT9I1mS1vYWngN5AnYaF4YrJ/UIsIknVOOg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793790205; a=rsa-sha256;
 cv=none;
 b=HTlahCmCz6KxpBbT3+fqOF29RC63BIcEg5TwpomsuD+FWXhFk75zagc4MHw1KsVlstXqzl
 hRHbmpXzvNwgndiqw6wxWN/sp7oubj2nynypkc1OLLm04IlgDty9AGDmUbopssh38HSJax
 ghD/7hhp6Vol9Owk6HYTKaSxsVsfRAeXwQAsU4vFP5tuQ02f7ihHY8Zu5FhRYle2RBr43s
 J6TX3BOrGNPl3/uYZuzGqdPjyN94xKJqFbObLMHWO/hZBw4+r0KfPp1grLwh8eTk10azAE
 m+1erqsZ/pzaebzGjhiiuiTzqDDPEX4WCAFEgdxnqLQmPOprJ0vsMEgydoSuXw==
Message-ID: <bf6acbfabf47de84243495f564865db19d44e184.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Flush the tile status cache through both
 the PE and BLT
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 12:03:25 +0100
In-Reply-To: <20261102-etna-pe-ts-flush-v1-1-e4454ed86f85@igalia.com>
References: <20261102-etna-pe-ts-flush-v1-1-e4454ed86f85@igalia.com>
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

Am Montag, dem 02.11.2026 um 11:18 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> Since commit f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs
> with BLT engine"), jobs on GPUs with a BLT engine use a BLT command to
> flush the tile status cache instead of TS_FLUSH_CACHE, which is broken
> on most of these GPUs.
>=20
> GC7000 r6008/r6009 and GC8200 r6401 are the other way around:
> TS_FLUSH_CACHE works, but the BLT command does not flush the cache.
> The vendor driver handles these GPUs using TS_FLUSH_CACHE, but the
> etnaviv kernel driver has no way to identify them.
>=20
> As a result, dirty tile status cache lines survive the end of a job.
> They are written back by the next cache flush, using the page table of
> the job issuing it. If that job belongs to another process, the write
> goes to the wrong address space.
>=20
> On GC7000 r6009 this causes MMU faults and GPU recoveries blamed on an
> innocent process. I see around 1100 per run of a multisample
> depth/stencil test running alongside two other GPU clients.
>=20
> Emit both flushes at the end of every job on GPUs with a BLT engine.
> Whichever does not work on a given GPU is a no-op. Since dirty lines
> are only written back once, this costs one additional state load per
> job.
>=20
> Fixes: f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs with BLT=
 engine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_buffer.c | 40 ++++++++++++++------------=
------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/e=
tnaviv/etnaviv_buffer.c
> index 03b2576af67f..99c91a9eecf1 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
> @@ -168,6 +168,17 @@ u16 etnaviv_buffer_config_pta(struct etnaviv_gpu *gp=
u, unsigned short id)
>  	return buffer->user_size / 8;
>  }
> =20
> +static void etnaviv_cmd_flush_ts(struct etnaviv_cmdbuf *buffer, bool has=
_blt)
> +{
> +	CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE, VIVS_TS_FLUSH_CACHE_FLUSH);
> +
> +	if (has_blt) {
> +		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
> +		CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
> +		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
> +	}
> +}
> +
>  void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
>  {
>  	struct etnaviv_cmdbuf *buffer =3D &gpu->buffer;
> @@ -191,7 +202,7 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
>  		unsigned int dwords =3D 7;
> =20
>  		if (has_blt)
> -			dwords +=3D 10;
> +			dwords +=3D 11;
> =20
>  		link_target =3D etnaviv_buffer_reserve(gpu, buffer, dwords);
> =20
> @@ -204,16 +215,8 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
>  			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
>  		}
>  		CMD_LOAD_STATE(buffer, VIVS_GL_FLUSH_CACHE, flush);
> -		if (gpu->exec_state =3D=3D ETNA_PIPE_3D) {
> -			if (has_blt) {
> -				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
> -				CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
> -				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
> -			} else {
> -				CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
> -					       VIVS_TS_FLUSH_CACHE_FLUSH);
> -			}
> -		}
> +		if (gpu->exec_state =3D=3D ETNA_PIPE_3D)
> +			etnaviv_cmd_flush_ts(buffer, has_blt);
>  		CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
>  		CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
>  		if (has_blt) {
> @@ -400,12 +403,12 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, =
u32 exec_state,
>  	return_dwords =3D 7;
> =20
>  	/*
> -	 * When the BLT engine is present we need 6 more dwords in the return
> +	 * When the BLT engine is present we need 7 more dwords in the return
>  	 * target: 3 enable/flush/disable + 4 enable/semaphore stall/disable,
> -	 * but we don't need the normal TS flush state.
> +	 * on top of the normal TS flush state.
>  	 */
>  	if (has_blt)
> -		return_dwords +=3D 6;
> +		return_dwords +=3D 7;
> =20
>  	return_target =3D etnaviv_buffer_reserve(gpu, buffer, return_dwords);
>  	CMD_LINK(cmdbuf, return_dwords, return_target);
> @@ -422,14 +425,7 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, u=
32 exec_state,
>  				       VIVS_GL_FLUSH_CACHE_DEPTH |
>  				       VIVS_GL_FLUSH_CACHE_COLOR |
>  				       VIVS_GL_FLUSH_CACHE_SHADER_L1);
> -		if (has_blt) {
> -			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
> -			CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
> -			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
> -		} else {
> -			CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
> -					       VIVS_TS_FLUSH_CACHE_FLUSH);
> -		}
> +		etnaviv_cmd_flush_ts(buffer, has_blt);
>  	}
>  	CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
>  	CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-etna-pe-ts-flush-ffa01363b98c
>=20
> Best regards,
