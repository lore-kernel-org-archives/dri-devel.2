Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E592CCF2D4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF89B10E12C;
	Mon, 19 Oct 2026 01:36:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0160410E165
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 01:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1555417A5;
 Mon, 19 Oct 2026 01:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4507C1F000C4;
 Mon, 19 Oct 2026 01:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792373789;
 bh=/BR6tYHepUWfOOub7vhEH5faC9Xm9yzzqG9QdBsvV0w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dKhl0d/zvx8hXUZ80O8Os9Fzq/g0IxUuxaDD9IiwG32VgcBhbPLFbFzB3Fz603fJE
 PAZ9HhmfFN1D4vkyrab6d9I/NYprcxHSoyDwH2CzRqYjkxKsBFuXwiNNlybdaTHkjK
 dchZJLLOKiv90mTloyvxpaSamyHlqe6mLpggBIe3JCTgEdltKqyv7VQTSp244s4M6D
 0klo2M847tLX9LIVcO8tMxaqZg59xOcDD2p5AqjHrdH2T26F4tltFQblQ+oyquhF6r
 Wp9MgtiNaMBr6L/HR4K1wx+hpgXBnM7IHyQRTuDEPBH0Ai/Jg+R1v8/c0kFSpMU3tp
 0ZhYqqjP/r25g==
Date: Mon, 19 Oct 2026 02:36:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
Message-ID: <20261019023621.30c413c6@jic23-hlaptop>
In-Reply-To: <20261001145702.2628429-3-olivier.moysan@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 1 Oct 2026 16:56:46 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add the STM32 Multi-function Digital Filter (MDF) core, serial interface
> and digital filter drivers. The MDF converts bitstreams from sigma-delta
> modulators or digital microphones into samples exposed through IIO.
> 
> Audio: capture PDM microphones via cyclic DMA for an ASoC consumer.
> Support CIC scaling and filtering, synchronized and interleaving modes.
> Audio use case requires a DMIC filter, and a separate ASoC DAI.
> 
> Analog: expose sigma-delta modulators as IIO voltage channels with
> direct reads or DMA buffering mode. STM32 timer triggers can be used as
> clock source.
> Analog use case requires an IIO backend for the SD modulator.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

I'm not going to spend long on this today, but a few trivial things noted
from a quick glance.

> diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-mdf-serial.c
> new file mode 100644
> index 000000000000..15a58cf833be
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf-serial.c

...

> +
> +int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf)
> +{
> +	int ret = 0;
> +
> +	spin_lock(&sitf->lock);

Use guard() for cases like this. Simplifies the flow and helps
readabilty as a result.  Everyone loves an early return.

> +
> +	if (!sitf->refcnt) {
> +		dev_err(sitf->dev, "Unbalanced serial interface stop ?\n");
> +		ret = -EPERM;
> +		goto out;
> +	} else {
> +		sitf->refcnt--;
> +	}
> +
> +	if (!sitf->refcnt)
> +		ret = regmap_clear_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
> +
> +out:
> +	spin_unlock(&sitf->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_sitf_stop);
>
> +static int stm32_mdf_sitf_runtime_suspend(struct device *dev)
> +{
Add a comment on why you need these.
> +	return 0;
> +}
> +
> +static int stm32_mdf_sitf_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}

> diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
> new file mode 100644
> index 000000000000..7e403c26d4dc
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf.h
> @@ -0,0 +1,312 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * This file is part of STM32 MDF driver
> + *
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
I'd guess you'll modify it enough that this might need
an update!


> +/* MDF_SIDR: Size Identification Register */
> +#define MDF_SIDR_SID_MASK GENMASK(31, 0)
> +#define MDF_SIDR_SID(v) FIELD_PREP(MDF_SIDR_SID_MASK, v)
I'd not bother with the second macro.  It is only a little
shorter than FIELD_PREP() in most case.

> 
