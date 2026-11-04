Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC540606D80F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=o5rbZXVq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134FD10FAF2;
	Wed,  4 Nov 2026 10:28:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DFF10E87E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=GLaKKMhflH6c9HMj7tkIQiYSGOrte1eESSKQrGjfr70=; b=o5rbZXVqXBOPz9MgAOGvVCI9OH
 rfV9RhCslhaCfar5qBWNZHOGhTb40svSP/U9cZBARICeF1s85qeLm1BXEtT1FXRqf/AxyyViXG5JX
 uIkNbXx6TybQeiCckwatSpovab7geUmVJWT0K8/k6CSMM106OEhaJ5IuD+HJk93478dgXIlLq1V4r
 N9RVyxyPENrg82zAQ9/z5Ej+MN4xwZMgv64pxwVyEPWSqNSYhP4JmER2b3z8rz2+60vAtDieRB/ya
 3mLn1L8ZILnwjvn3P0wwDdv+BlF8gERII7sgsrW/Io66GFLsiGRYShcjIZh/lpt2g4xaPqN5nSVLE
 7GEI3XHg==;
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
Subject: Re: [PATCH v15 05/15] accel/rocket: factor the completion tail out of
 the IRQ handler
Date: Wed, 04 Nov 2026 11:27:41 +0100
Message-ID: <8888361.5OynTdThKG@diego>
In-Reply-To: <20261101082307.151957-6-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-6-gahing@gahingwoo.com>
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

Am Sonntag, 1. November 2026, 09:22:57 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> Move the part of rocket_job_handle_irq() that starts the next task or
> retires the job into rocket_job_next_locked(). No functional change.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Igor Paunovic <royalnet026@gmail.com>

this makes the irq-handler more descriptive in what it does

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 152a9098634b..417d5ef06c09 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -365,6 +365,25 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>  	return ERR_PTR(ret);
>  }
> =20
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +	lockdep_assert_held(&core->job_lock);
> +
> +	if (!core->in_flight_job)
> +		return;
> +
> +	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_coun=
t) {
> +		rocket_job_hw_submit(core, core->in_flight_job);
> +		return;
> +	}
> +
> +	iommu_detach_group(NULL, iommu_group_get(core->dev));
> +	dma_fence_signal(core->in_flight_job->done_fence);
> +	pm_runtime_put_autosuspend(core->dev);
> +	core->in_flight_job =3D NULL;
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>  	pm_runtime_mark_last_busy(core->dev);
> @@ -378,17 +397,7 @@ static void rocket_job_handle_irq(struct rocket_core=
 *core)
>  		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>  		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
> -		if (core->in_flight_job) {
> -			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
> -				rocket_job_hw_submit(core, core->in_flight_job);
> -				return;
> -			}
> -
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> -			dma_fence_signal(core->in_flight_job->done_fence);
> -			pm_runtime_put_autosuspend(core->dev);
> -			core->in_flight_job =3D NULL;
> -		}
> +		rocket_job_next_locked(core);
>  	}
>  }
> =20
>=20




