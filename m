Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B04606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=e8agXrda
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5686B10F8D3;
	Tue,  3 Nov 2026 22:51:24 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8F410F8C8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=o7HXQPomhFEfrYFjVcsrdsok+Tx5KNS+/so3Un5/lrc=; b=e8agXrdauKRx9EGxkmib/g9VuU
 mDkazXkDbRhtV8JTfmGehKVWbki2agxMfivjwj3H4Z7DrWaQ87OgZlnjv96V405f70UM8mEHiCoEK
 TLd4STOnPAShQ8B5UpqgNF77zT0/kgRPw/bgf1mBJTSHL5/ItZgiw07vjqZMz8ri84ErO7Sqn5uY8
 BjeUx54xkn3O/6fjaNdEbOCVTI2mJDProM+XKVHiSN1FuQdZXYUhw8KhN0mtqJkPCyJOTIMjnsun+
 Ct9vIUE/vopzPCY8Sep1G/z0WMU8T4JLlqhKjt5CTs/Lcr32soSSG4RSYht1Z/bG5OHaAT0LNrfFx
 R/xopxBA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Tue, 03 Nov 2026 23:50:58 +0100
Message-ID: <3311623.TQGk6oTFT5@diego>
In-Reply-To: <20261101082307.151957-4-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-4-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Sonntag, 1. November 2026, 09:22:55 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> drm_sched_stop() does not wait for a threaded handler that is already
> running. Call synchronize_irq() after it, outside job_lock, which the
> handler takes.
>=20
> Before the sync, mask the block's interrupt and clear its raw status, so
> that an active core cannot signal a completion after it. Do that under
> job_lock, since rocket_job_hw_submit() arms the same mask under that lock,
> and only when pm_runtime_get_if_active() returns a positive count: the
> reset holds no runtime PM reference, and with the domain down a register
> access takes an async SError.
>=20
> Igor Paunovic's induced-reset runs on RK3588, including a two-task job th=
at
> puts hw_submit() on the IRQ thread, found no fault; as he put it, "this
> does not show the race is closed".
>=20
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
=2Ecom/
> Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaX=
Q8HoMtHD5U1g@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail=
=2Ecom/
> Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmai=
l.com/
> Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gma=
il.com/
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2
> ---
>  drivers/accel/rocket/rocket_job.c | 71 +++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 03e5f094f60b..5b2abf40b618 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -401,9 +401,74 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>  	drm_sched_stop(&core->sched, bad);
> =20
>  	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().

Also, why are you changing the original comment here?
The new wording below, does say essentially the same and you're changing
it again the next patch.

[...]

> +	/*
> +	 * No handler is running now, but we might still have stuck jobs. Let's
> +	 * make sure the PM counters stay balanced by manually calling
> +	 * pm_runtime_put_noidle().
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
>=20




