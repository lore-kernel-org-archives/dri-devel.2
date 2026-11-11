Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10903606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=2OdJcHNX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B1610FA7E;
	Wed, 11 Nov 2026 10:35:16 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E04010FA7E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=rqgkq6oQbIsqnROn601ye4kioGRpwwGl2bIvAccYj10=; t=1794393310; x=1795602910; 
 b=2OdJcHNX2hFLa55hHKvo0wHaGVA5LaGuCyjRPa7XGQi5SaZY9NngYOt/clIRIKCLd3/VWE1eAwD
 vnldFUelrrEG0bvtB28HxhpLR4zXqkRe9WA1jusEE7sQkNxiiR3GpF+CA9lF4FmHljBOQWm8KJ1pG
 ZPqU6NKHpll5eonoKJ5Mz2Zyz4Zbb+7IorH/8h1mbAukn17PtpaWWx+ZPXkWxt8queQaQsLakj8sX
 LNuNRlY5LRKO5AabpRIuisd2PKr9IWlyaackt82ibL4L5xFbwn0rEzEF2CLXK6pYjJ2kDHLtDkr+s
 029nw7ZbUl77gGWN6TD7vB8jFX7kcMErim/Q==;
Date: Wed, 11 Nov 2026 11:30:26 +0100
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
Subject: Re: [PATCH v5 01/13] drm/bridge: tc358762: Clean up register defines
Message-ID: <20261111113026.2ab1e6c1@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-1-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-1-7cd721a6451b@ideasonboard.com>
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

On Thu, 15 Oct 2026 14:15:52 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Move the defines around and rename for clarity and consistency. No
> functional change.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Seems to match. So

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 76564d5e4f69..097d2f331a16 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -28,17 +28,22 @@
>  
>  /* PPI layer registers */
>  #define PPI_STARTPPI		0x0104 /* START control bit */
> +#define PPI_STARTPPI_STARTPPI	BIT(0)
> +
>  #define PPI_LPTXTIMECNT		0x0114 /* LPTX timing signal */
>  #define PPI_D0S_ATMR		0x0144
>  #define PPI_D1S_ATMR		0x0148
>  #define PPI_D0S_CLRSIPOCOUNT	0x0164 /* Assertion timer for Lane 0 */
>  #define PPI_D1S_CLRSIPOCOUNT	0x0168 /* Assertion timer for Lane 1 */
> -#define PPI_START_FUNCTION	1
>  
>  /* DSI layer registers */
>  #define DSI_STARTDSI		0x0204 /* START control bit of DSI-TX */
> +#define DSI_STARTDSI_STARTDSI	BIT(0)
> +
>  #define DSI_LANEENABLE		0x0210 /* Enables each lane */
> -#define DSI_RX_START		1
> +#define DSI_LANEENABLE_CLEN	BIT(0)
> +#define DSI_LANEENABLE_L0EN	BIT(1)
> +#define DSI_LANEENABLE_L1EN	BIT(2)
>  
>  /* LCDC/DPI Host Registers, based on guesswork that this matches TC358764 */
>  #define LCDCTRL			0x0420 /* Video Path Control */
> @@ -59,14 +64,8 @@
>  /* System Controller Registers */
>  #define SYSCTRL			0x0464
>  
> -/* System registers */
>  #define LPX_PERIOD		3
>  
> -/* Lane enable PPI and DSI register bits */
> -#define LANEENABLE_CLEN		BIT(0)
> -#define LANEENABLE_L0EN		BIT(1)
> -#define LANEENABLE_L1EN		BIT(2)
> -
>  struct tc358762 {
>  	struct device *dev;
>  	struct drm_bridge bridge;
> @@ -117,7 +116,7 @@ static int tc358762_init(struct tc358762 *ctx)
>  	u32 lcdctrl;
>  
>  	tc358762_write(ctx, DSI_LANEENABLE,
> -		       LANEENABLE_L0EN | LANEENABLE_CLEN);
> +		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
>  	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
>  	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
>  	tc358762_write(ctx, PPI_D0S_ATMR, 0);
> @@ -140,8 +139,8 @@ static int tc358762_init(struct tc358762 *ctx)
>  	tc358762_write(ctx, SYSCTRL, 0x040f);
>  	msleep(100);
>  
> -	tc358762_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
> -	tc358762_write(ctx, DSI_STARTDSI, DSI_RX_START);
> +	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
> +	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
>  
>  	msleep(100);
>  
> 

