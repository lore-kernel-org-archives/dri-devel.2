Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A8606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=UYGE+3up
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E5410E2A4;
	Mon, 16 Nov 2026 08:17:11 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F73910E2A4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=cw42d6ZCptc5PSIS/Cy7d405imHq7uVLiZ3GFGb5rYA=; t=1794817024; x=1796026624; 
 b=UYGE+3upzdi7tkJWV4eEc/CSyfeviaKXQf7ctltYXRWAvblpd1TycFr3K1lhiBDnbJT9jiPIvsI
 KrjVJsz+S9Csu65qK3vWRYhEi3h/i4ccQKU5fX3KzJuexuD/udollkyFbYsI5D6r0NpTSA2+ENjJ6
 lYP4cCWREReQfK4DUovi2ZdKdE7BlGZyq7+v8+nwW65VcBFoqiFnFSIBf7ULUok+/iPOIbXA3C4Ja
 vxitgCu6W5xH7hsfzzIvIVHUdaDrE5iyEJThX4LGFVxFDYwAEU1Ax/MiEhpXhHfn0uZWmyreLQBAK
 rY76oAsWpOUpyf0ApRLjfMfvHpMCXRZR1HQg==;
Date: Mon, 16 Nov 2026 09:16:54 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 04/13] drm/bridge: tc358762: Configure SYSCTRL first
Message-ID: <20261116091654.26a56120@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-4-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-4-7cd721a6451b@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 14:15:55 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> SYSCTRL affects the DPI output and the clock tree, but we configure it
> late, when the DPI output is already enabled and clocks are running.
> 
> Move the SYSCTRL configuration to the beginning, before anything is
> enabled.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

sounds sane so

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/gpu/drm/bridge/tc358762.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 26671dc66874..f5ee781275fc 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -134,6 +134,13 @@ static int tc358762_init(struct tc358762 *ctx)
>  {
>  	u32 lcdctrl;
>  
> +	tc358762_write(ctx, SYSCTRL,
> +		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
> +		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
> +		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
> +
> +	msleep(100);
> +
>  	tc358762_write(ctx, DSI_LANEENABLE,
>  		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
>  	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
> @@ -157,13 +164,6 @@ static int tc358762_init(struct tc358762 *ctx)
>  
>  	tc358762_write(ctx, LCDCTRL, lcdctrl);
>  
> -	tc358762_write(ctx, SYSCTRL,
> -		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
> -		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
> -		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
> -
> -	msleep(100);
> -
>  	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
>  	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
>  
> 

