Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456CAC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB5B10FB66;
	Sat,  5 Sep 2026 00:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QZBxfOKM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4AB10FB65
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:57:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F56B602C4
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E082D1F00A3D;
 Sat,  5 Sep 2026 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569856;
 bh=fbQUf8Nj6IlYI26J5f3q0wrpT/96luX/Uz98yNp/GIo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QZBxfOKMz/E4PbePbeEti/xQ5oDuJYgTvIN2Stf7RCumr3k3X9BBaLnhFZPpiduqL
 LiFvhYNPxCvQ7qxkoZ8Nhu/U+rsTj2pUQswgg8m0BVx2bl5vnUHBa8WUOCU0B/1B8l
 rOuVBH4kYimc6rNUC5PnBaIrTM69mM941uzu3zuBmTeFMQLjYQQINtbUj7qPGuzw03
 kjSqTKBkMFWGVpakoP5dU7SLJPkOv4amLxSMUX71bBytYkrpcb2mPCwE/q/TGVbGmI
 k+1fnaZu2nwph4k/fS8eysvm9IojLB/+R8PoRk57m3Tw4XzIcd3CKd+oxLazlzfWoo
 aV1Dd3rwTvcFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/19] accel: ethosu: Fix probe error cleanup
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-2-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-2-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:57:35 +0000
Message-Id: <20260905005735.E082D1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Active devm-managed IRQ during probe error paths can trigger use-a=
fter-free or system crash due to destroyed scheduler.

Pre-existing issues:
- [High] IRQ handler is registered before device clocks are enabled, riskin=
g system crash on pending or spurious interrupt.
--

commit 884e296c2a78cb8e0657cc20be2687762177ac12
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Fix probe error cleanup

This patch unwinds initialized resources on both failure paths in probe:
ethosu_init() and drm_dev_register(). It also avoids calling drm_sched_fini=
()
after a failed drm_sched_init().

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index df76253d01a64..c684e28ac7871 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -375,9 +375,20 @@ static int ethosu_probe(struct platform_device *pdev)
> =20

[Severity: High]
This is a pre-existing issue, but is it safe that the IRQ handler is regist=
ered
and unmasked before the device clocks are enabled?

In ethosu_probe(), ethosu_job_init() is called before ethosu_init():

ethosu_drv.c:ethosu_probe() {
	...
	ret =3D ethosu_job_init(ethosudev);
	if (ret)
		return ret;

	ret =3D ethosu_init(ethosudev);
	...
}

Inside ethosu_job_init(), devm_request_threaded_irq() unmasks the IRQ. If a
pending interrupt from a prior boot or a spurious interrupt fires, the hand=
ler
ethosu_job_irq_handler() executes and immediately reads NPU_REG_STATUS.

However, the hardware clocks are not enabled until ethosu_init() calls
ethosu_device_resume(). Could accessing this register with disabled clocks
trigger a synchronous external abort and crash the system?

>  	ret =3D ethosu_init(ethosudev);
>  	if (ret)
> -		return ret;
> +		goto err_job_fini;
> =20
>  	ret =3D drm_dev_register(&ethosudev->base, 0);
> +	if (ret)
> +		goto err_sram_free;
> +
> +	return 0;
> +
> +err_sram_free:
> +	if (ethosudev->sram)
> +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> +			      ethosudev->npu_info.sram_size);
> +err_job_fini:
> +	ethosu_job_fini(ethosudev);

[Severity: High]
Could the devm-managed IRQ trigger a use-after-free or a crash during this
teardown window on probe failure?

This patch adds ethosu_job_fini() to the probe error path. When
ethosu_job_fini() executes, it tears down the DRM scheduler via
drm_sched_fini().

Because the IRQ was allocated via devm_request_threaded_irq() in
ethosu_job_init() and is not explicitly disabled before ethosu_job_fini(), =
the
interrupt remains active until the probe function returns and the devres
cleanup runs.

If an interrupt fires in this window, the handler could access the destroyed
scheduler when calling drm_sched_fault(&dev->sched). Additionally, since
ethosu_init() already suspended the device on its successful path, could the
handler crash the system by reading the status register with clocks disable=
d?

>  	return ret;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D2
