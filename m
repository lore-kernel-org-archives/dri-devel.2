Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB5606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=MOcq+jSD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA3E10F838;
	Thu, 12 Nov 2026 07:57:50 +0000 (UTC)
Received: from mail-m8114.xmail.ntesmail.com (mail-m8114.xmail.ntesmail.com
 [156.224.81.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD2410F838
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:57:44 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 546cef110;
 Thu, 12 Nov 2026 15:57:40 +0800 (GMT+08:00)
Message-ID: <2807a167-0dab-4732-82e0-a3b5ebcabb15@rock-chips.com>
Date: Thu, 12 Nov 2026 15:57:39 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/bridge: analogix_dp: Use
 str_supported_unsupported() helper
To: Thorsten Blum <blum@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261111164243.77775-2-blum@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261111164243.77775-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1cec32ebc03a8kunm267e7e3944dc00
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTR5CVkxJGkJPQk1JQkJOGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=MOcq+jSDGGNBYVT+/mW4+Q3Aa/pYQ+X2jK/EoP5YAL1/WKPP8vTzHomzLDTanMzevw+vCPow3y1ugMqOT9nytLk53BmHmtTxViHcvMZWyFJnG79KwUgiDJzepDg5iWCovHd4nbdLv0glrXp3+PZNwDmlNb98nUuNmsBmjBDUohc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=NEKjIJAa/BSs/0v1WVFEUUAthlW5GEQY1FS7GPyIJQ4=;
 h=date:mime-version:subject:message-id:from;
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thorsten,

On 11/12/2026 12:42 AM, Thorsten Blum wrote:
> Replace hard-coded strings with the str_supported_unsupported() helper.
> This unifies the output and helps the linker with deduplication, which
> can result in a smaller binary.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 6df6963740d2..59d3ff9bcde4 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -19,6 +19,7 @@
>   #include <linux/of.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>   
>   #include <drm/bridge/analogix_dp.h>
>   #include <drm/display/drm_dp_aux_bus.h>
> @@ -745,7 +746,7 @@ static int analogix_dp_fast_link_train_detection(struct analogix_dp_device *dp)
>   	}
>   	dp->fast_train_enable = !!(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
>   	dev_dbg(dp->dev, "fast link training %s\n",
> -		dp->fast_train_enable ? "supported" : "unsupported");
> +		str_supported_unsupported(dp->fast_train_enable));
>   	return 0;
>   }
>   
> 
> 

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

