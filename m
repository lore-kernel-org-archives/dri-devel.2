Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36129606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SvDp+UP5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0EE10E0FD;
	Wed, 18 Nov 2026 12:32:50 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F55610E0FD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795005163;
 bh=wteOM9b+zSffSygch8OIiG1KfgGZxZdoiAbmq3MuSjM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SvDp+UP5rJzMgno0Rw8XcbVnIR40+0cLIXqM7U1qt3IvoBBtX2CdwLMBnu/tYrLNF
 mx5GHSS/udI8UNablyDlmu6mItAYAmbSedTYSLBpA/3xLvOHir/ePh2i/u2SpEZrso
 BiEILgdKCWwBVfpFn6xxjHKd6kMNF7/g/h1ozrDySkW9C92m8gPa2piQMIR9Z2u1Vu
 qoKszQboTwJwp+VHzXt36VZQko34CAbrYXI7rcTJatRUlhlSRqqxJJywt6OBYOX4LH
 vBmyoA7V3UtpZ7sAvCkXduXSnEyDUeF9umKgxRLI6uYaYBF1wACIvN1+OLc4gRPK5y
 wnd4uOyXf6swA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id ADE5E17E052F;
 Wed, 18 Nov 2026 13:32:42 +0100 (CET)
Message-ID: <675eb0c5-96a1-4254-844e-234fb972d824@collabora.com>
Date: Wed, 18 Nov 2026 13:32:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
To: zi-hao.huang@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 shaoming chen <shaoming.chen@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>
References: <20261118-mtk-dsi-irq-wait-v2-1-8bda52993c6f@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261118-mtk-dsi-irq-wait-v2-1-8bda52993c6f@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 10:33, Zi-Hao Huang via B4 Relay wrote:
> From: Zi-Hao Huang <zi-hao.huang@mediatek.com>
> 
> mtk_dsi_wait_for_irq_done() waits for the DSI IRQ with
> wait_event_interruptible_timeout(). If it returns early, for example
> with -ERESTARTSYS when a signal is pending, both callers still treat the
> command as done, because they only handle a return value of 0 as a
> failure.
> 
> On an MT8196 board this led to a hard lockup during shutdown. The wait
> returned before the IRQ arrived, the panel disable sequence went on and
> restarted video mode, and the late CMD_DONE interrupt was then handled
> by mtk_dsi_irq().

This happens because of the hacks that you have downstream.

With the restructured mediatek-drm adding proper support for MT8196's Display
Controller architecture, what you're describing does not happen, because the
tear down path is correct.

Regards,
Angelo

> The handler writes RACK and loops until DSI_BUSY
> clears, but DSI_BUSY stays set while video mode is running, so the CPU
> never leaves the handler until the watchdog fires. Forcing the wait to
> return early reproduces the lockup every time, and it no longer
> happens once the wait cannot return early.
> 
> The wait synchronises the driver with the hardware, and it is bounded by
> its timeout. Use wait_event_timeout() so that it only ends on the IRQ or
> the timeout.
> 
> wake_up_interruptible() cannot wake a task in uninterruptible sleep, so
> switch mtk_dsi_irq() to wake_up(). Without it every wait would last
> until its timeout.
> 
> Fixes: dd5080a54df8 ("drm/mediatek: add dsi interrupt control")
> Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
> Changes in v2:
> - Drop the remark that the wait is not made on behalf of userspace, since
>    a userspace backlight change can reach it (CK)
> - Collect Reviewed-by
> - Link to v1: https://lore.kernel.org/r/20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index f82506e10fd5..1315dd31a834 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -627,9 +627,8 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
>   	unsigned long jiffies = msecs_to_jiffies(timeout);
>   	struct drm_device *drm = dsi->bridge.dev;
>   
> -	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
> -					       dsi->irq_data & irq_flag,
> -					       jiffies);
> +	ret = wait_event_timeout(dsi->irq_wait_queue,
> +				 dsi->irq_data & irq_flag, jiffies);
>   	if (ret == 0) {
>   		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
>   
> @@ -656,7 +655,7 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
>   
>   		mtk_dsi_mask(dsi, DSI_INTSTA, status, 0);
>   		mtk_dsi_irq_data_set(dsi, status);
> -		wake_up_interruptible(&dsi->irq_wait_queue);
> +		wake_up(&dsi->irq_wait_queue);
>   	}
>   
>   	return IRQ_HANDLED;
> 
> ---
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
> change-id: 20261118-mtk-dsi-irq-wait-a24712ada627
> 
> Best regards,
