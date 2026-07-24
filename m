Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40A8C531FF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0678F10F266;
	Fri, 24 Jul 2026 00:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFCH4IEb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B14F10F266
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:13:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAD8E40741;
 Fri, 24 Jul 2026 00:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EF21F000E9;
 Fri, 24 Jul 2026 00:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852010;
 bh=fqAIIbHMDebpJeHJXGPfIfuuZqjDPwcHi+9hMhsVB98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iFCH4IEb2sj2VH6+i3mRhjahjCFJZqFp2ADm8WPEbCS6IUvGNu5jC/PsdKJi+P7aO
 fv6+Guv3Z9vLX8mJJpPuYOzAs7QHEpCQnH0ksdjHLUJQWnldSUfQ0hZ5LzHjKfxmPF
 ZB1aiV7E7snZB23KPBQ1C8F9AWWNh0NqqJuceP1j7KferUqdFMHJEN43HOsv/+bj9k
 Wc4mPj2QK/QQlVBIwOdKtQyalfAwaKPoGvzhXHccPxcbRCvVbooADu08mbZBXEBS5N
 YJkL6pg92UJPggHyMul4yilJWvuMWS16saQwFpMv65o+kKvMAhp6saH8uyUbDxOlLJ
 jZz9O+jiFC5Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-6-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-6-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:13:30 +0000
Message-Id: <20260724001330.93EF21F000E9@smtp.kernel.org>
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
- [High] Premature unmasking of MMU interrupts before reset workqueue initi=
alization leads to a NULL pointer dereference.
--

--- Patch [6]: [PATCH v3 06/13] drm/panfrost: Explicitly enable MMU interru=
pts at device init ---
commit 28382212258245805fe4be63994981403a3d9c1c
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Explicitly enable MMU interrupts at device init

Because the device must be in a position to accept jobs between the time
drm_dev_register() is called and autosuspend first kicks in, there's a very
narrow window inbetween during which jobs targeting the tiler buffer
object would time out, since the device's PM status is 'Active', but no MMU
interrupts were enabled at device initialisation time.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 4a3162c3b659f..bb6c1614964b1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c

[ ... ]

> @@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);
> +

[Severity: High]
Could this premature unmasking of MMU interrupts lead to a NULL pointer
dereference during driver initialization?

If the GPU asserts an MMU interrupt (e.g., due to leftover state from the
bootloader or a hardware glitch) right after interrupts are enabled here, t=
he
IRQ handler thread might encounter a fault and eventually attempt a reset.

However, the reset workqueue hasn't been allocated yet, because
panfrost_mmu_init() is called before panfrost_jm_init():

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_init() {
    ...
    err =3D panfrost_mmu_init(pfdev);
    if (err)
        goto out_gpu;

    err =3D panfrost_jm_init(pfdev);
    ...
}

If panfrost_mmu_irq_handler_thread() triggers a timeout in wait_ready(), it
will call panfrost_device_schedule_reset(), which assumes the reset
workqueue is already initialized:

drivers/gpu/drm/panfrost/panfrost_device.h:panfrost_device_schedule_reset()=
 {
    ...
    queue_work(pfdev->reset.wq, &pfdev->reset.work);
}

Will this dereference the NULL pfdev->reset.wq pointer if the interrupt
fires before panfrost_jm_init() runs?

>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D6
