Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBB606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsCi43JA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A873310E2F8;
	Wed, 18 Nov 2026 01:30:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC3210E2F8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63036404BF;
 Wed, 18 Nov 2026 01:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD81F000C6;
 Wed, 18 Nov 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794965410;
 bh=n0fMeTza51CwE0713RxU6MOCCTFghWslwl1QC9mmQ/Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KsCi43JAoeuSGYZezRB5J6aW4zk+jJXKb993MHP1HBDjTWJUWBsREuM4fmjiUIV+U
 yrb4Qcj0EnMj0yscAjR74xkanyWndP5FwUnyQxMTva4i9VgjWc2I32fzjaWLxnnfNE
 qS36A7hOgHxqYsexvSIdMqYf2Nju1uBK9RPGkJsb8FZ2TkAglplUHOC5Ic8wTTUtAC
 UiJy+amZO+r2C9krZt/s1pLJjf0L9+Hqw6WnhnMqBxmJ+5FtVe98WMB+nYqrK4b4vS
 byy74D+QkU9yapo88mBqpvZWp9va3KYlU6xyo57WNcCmXbAcMSQ4oaa6LkxEOouBOy
 mPs4TjiQPupLQ==
Message-ID: <sashiko-outbox-219902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
To: "Zi-Hao Huang" <zi-hao.huang@mediatek.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com>
References: <20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:30:09 +0000
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
- [High] drm/mediatek: data race on dsi->irq_data in
  mtk_dsi_irq_data_clear() [1]
--

commit 05e9a152e55dc7fe529c1070f18d57f8b05d8243
Author: Zi-Hao Huang <zi-hao.huang@mediatek.com>

drm/mediatek: dsi: Don't let a signal cut the IRQ wait short

This commit switches mtk_dsi_wait_for_irq_done() to wait_event_timeout()
and mtk_dsi_irq() to wake_up() so that pending signals do not abort hardware
IRQ waits prematurely.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index f82506e10fd59..1315dd31a8349 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -627,9 +627,8 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *=
dsi, u32 irq_flag,
>  	unsigned long jiffies =3D msecs_to_jiffies(timeout);
>  	struct drm_device *drm =3D dsi->bridge.dev;
> =20
> -	ret =3D wait_event_interruptible_timeout(dsi->irq_wait_queue,
> -					       dsi->irq_data & irq_flag,
> -					       jiffies);
> +	ret =3D wait_event_timeout(dsi->irq_wait_queue,
> +				 dsi->irq_data & irq_flag, jiffies);
>  	if (ret =3D=3D 0) {
>  		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> =20
> @@ -656,7 +655,7 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> =20
>  		mtk_dsi_mask(dsi, DSI_INTSTA, status, 0);
>  		mtk_dsi_irq_data_set(dsi, status);
> -		wake_up_interruptible(&dsi->irq_wait_queue);
> +		wake_up(&dsi->irq_wait_queue);

[Severity: High]
This problem wasn't introduced by this patch, but can a data race on
dsi->irq_data between mtk_dsi_irq_data_clear() and mtk_dsi_irq_data_set()
[1] lose an interrupt flag?

drivers/gpu/drm/mediatek/mtk_dsi.c:
static void mtk_dsi_irq_data_set(struct mtk_dsi *dsi, u32 irq_bit)
{
	dsi->irq_data |=3D irq_bit;
}

static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
{
	dsi->irq_data &=3D ~irq_bit;
}

Both helpers perform non-atomic read-modify-write operations on
dsi->irq_data without synchronization:

CPU0                              <hardirq>
mtk_dsi_irq_data_clear()
  read dsi->irq_data
                                  mtk_dsi_irq()
                                    mtk_dsi_irq_data_set()
                                      dsi->irq_data |=3D status
  write stale dsi->irq_data  <-- clobbers newly set status bits

When mtk_dsi_irq_data_clear() overwrites the flag set by mtk_dsi_irq(),
mtk_dsi_wait_for_irq_done() misses the completion and times out, causing
DSI command transfers or mode switches to fail.

[1] https://sashiko.dev/#/bug/linux-366e515b-3237-4b5e-90f0-3615e8a40df5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-mtk-dsi-ir=
q-wait-v1-1-205f25fac8b2@mediatek.com?part=3D1
