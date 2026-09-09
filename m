Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB41C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B396810EE97;
	Wed,  9 Sep 2026 04:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WYaCKd2m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90E810EE97
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:38:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5447601FF;
 Wed,  9 Sep 2026 04:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D0E1F00A3E;
 Wed,  9 Sep 2026 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788928707;
 bh=fSHQ9GiqjJNRHaIaXcC4b4xJ+/28S/Pwm+mXF/NyfCk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WYaCKd2mzwWyD5/JxeucOPLa6fE6aNPOBHTsvwCs56VOiUug2FX9SkqVKotCJYZuk
 NcGymyOKcNnbj7y4wLUUJgzfbXS/7G9JyR2Tjul02w1ak9FezWwCdk6B9f93pPFUwT
 SYDhJzwoYTtEr2+eNG9o92gTKHmQ7xFvzNbQJcZG5NVNKStHSHkDLV/wGAcpXz7BgJ
 GBRQOY2cFdW9+89yuqeNlDfDcuwC7W7Q0LjbkG2ImxINktGG8NTvJfK5yMSF/x4fHZ
 twbroFkBhi8RW3cKHNrovbRJzt6sbpPTG94BpV+YXAWUnJPAVR3fjfTZavZQNCxh27
 I2LJrW8AmNtLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/habanalabs: fix use-after-free of decoder array
 on removal
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909042333.652206-1-fanwu01@zju.edu.cn>
References: <20260909042333.652206-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:38:26 +0000
Message-Id: <20260909043827.43D0E1F00A3E@smtp.kernel.org>
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

Pre-existing issues:
- [High] Potential Use-After-Free of `hdev` due to improper lifecycle manag=
ement of `work_pci` during device unbind.
--

commit 72566230e41718de9b89ea8aac0671a21e78fed5
Author: Fan Wu <fanwu01@zju.edu.cn>

accel/habanalabs: fix use-after-free of decoder array on removal

This commit fixes a use-after-free issue by waiting for pending decoder
abnormal interrupt work items to complete before freeing the decoder array.
It cancels the work items using cancel_work_sync() during device teardown.

> diff --git a/drivers/accel/habanalabs/common/decoder.c b/drivers/accel/ha=
banalabs/common/decoder.c
> index e4802f30c08a4..ed0c259342061 100644
> --- a/drivers/accel/habanalabs/common/decoder.c
> +++ b/drivers/accel/habanalabs/common/decoder.c
> @@ -85,6 +85,16 @@ static void dec_abnrm_intr_work(struct work_struct *wo=
rk)
> =20
>  void hl_dec_fini(struct hl_device *hdev)
>  {
> +	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
> +	int i;
> +
> +	if (!hdev->dec)
> +		return;
> +
> +	/* interrupts are gone, but a queued work item may still be pending */
> +	for (i =3D 0; i < prop->max_dec; i++)
> +		cancel_work_sync(&hdev->dec[i].abnrm_intr_work);
> +
>  	kfree(hdev->dec);
>  }

[Severity: High]
This is a pre-existing issue, but while this patch correctly flushes the
abnrm_intr_work items to prevent a use-after-free, does a similar problem
exist with hdev->work_pci during device unbind?

Looking at drivers/accel/habanalabs/common/habanalabs_drv.c, if a
hot-unplug or sysfs unbind triggers hl_pci_remove(), the device can be
freed by devres without calling cancel_work_sync(&hdev->work_pci).

If pci_mon_func() is running concurrently:

drivers/accel/habanalabs/common/habanalabs_drv.c:pci_mon_func() {
    ...
    /* hdev is retrieved using idr_for_each_entry under hl_devs_idr_lock */
    ...
    /* The lock is released */
    queue_work(system_long_wq, &hdev->work_pci);
    ...
}

Could hl_pci_remove() complete and free the hdev structure before
queue_work() is called, or leave a pending work_pci item that executes on
the freed hdev structure?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909042333.6522=
06-1-fanwu01@zju.edu.cn?part=3D1
