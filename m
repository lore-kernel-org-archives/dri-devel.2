Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086C606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=a6HuhZBO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F4A10E3E2;
	Fri, 20 Nov 2026 02:07:41 +0000 (UTC)
Received: from mail-m81230.xmail.ntesmail.com (mail-m81230.xmail.ntesmail.com
 [156.224.81.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BEB10E3E2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:07:35 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55597404f;
 Fri, 20 Nov 2026 10:07:31 +0800 (GMT+08:00)
Message-ID: <5de94aa3-acd3-43fa-8e66-5b89e3d8cbef@rock-chips.com>
Date: Fri, 20 Nov 2026 10:07:30 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Hold runtime PM reference in
 bridge detect
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>,
 Brian Norris <briannorris@chromium.org>
References: <CGME20261119103751eucas1p16485be9bf23e31909f3b2df7c1c9d43f@eucas1p1.samsung.com>
 <20261119103742.1161858-1-m.szyprowski@samsung.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261119103742.1161858-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1f6b57bb403a8kunmff82eb5044874b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh9OVk5IThkeTUtNGkgaTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=a6HuhZBOvisHksjGFs6z1ZI247G0q2MhCnY6CLZEUL2wwu2lE6psKf1s7P8tF2co2W+bshzw8a+faWumgRwmtMd+30IuOcGpVFy7HT0J6gXdPQtjVB1dK+HSLlyS4Ji26FbBuuBpN8K9qtxQBwSRgjrQ30QcuHVLda73v88QJII=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+gPo7TH+mEW/OkwX9oqBlwqZAlz9Z/VoBzX8K5p4O94=;
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

Hi Marek,

On 11/19/2026 6:37 PM, Marek Szyprowski wrote:
> analogix_dp_bridge_detect() calls analogix_dp_detect_hpd() without
> holding a runtime PM reference on the DP device. If there is no HPD
> GPIO, analogix_dp_get_plug_in_status() reads ANALOGIX_DP_SYS_CTL_3 and,
> with "force-hpd", analogix_dp_force_hpd() also writes to it. When the
> display is disabled the controller is runtime suspended, so these are
> accesses to an unclocked (and possibly unpowered) IP block.
> 
> The connector created by drm_bridge_connector is polled because the
> bridge provides DRM_BRIDGE_OP_DETECT without DRM_BRIDGE_OP_HPD, and
> userspace may also query the connector state at any time, so this path
> is regularly executed with the device suspended. It affects only setups
> without a next bridge or panel (e.g. a DP connector), as otherwise
> detect returns early.
> 
> Take a runtime PM reference around the HPD check, the same way as
> analogix_dpaux_transfer() and analogix_dpaux_wait_hpd_asserted() do,
> and report the connector status as unknown if the device cannot be
> resumed.
> 
> Fixes: 2b77a2918c5d ("drm: bridge: analogix/dp: move hpd detect to connector detect function")
> Closes: https://sashiko.dev/#/bug/linux-ea09d64b-12cd-4301-bd54-12c515b01bde
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changelog:
> v2:
> - removed pm_runtime_mark_last_busy(), as it is not included in
>    pm_runtime_put_autosuspend()
> 
> v1: https://lore.kernel.org/all/20261119092857.1158971-1-m.szyprowski@samsung.com/
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 84951413012b..664ee46c8e53 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -905,9 +905,14 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
>   	if (dp->plat_data->next_bridge)
>   		return connector_status_connected;
>   
> +	if (pm_runtime_resume_and_get(dp->dev) < 0)
> +		return connector_status_unknown;
> +
>   	if (!analogix_dp_detect_hpd(dp))
>   		status = connector_status_connected;
>   
> +	pm_runtime_put_autosuspend(dp->dev);
> +
>   	return status;
>   }
>   

Aha, Sashiko also spotted this same issue in the review for my v4 
series[0]. I added the runtime PM reference handling in 
analogix_dp_bridge_detect() starting from v5, and this logic is present 
in my current v6 series[1].

As Laurent noted earlier, pm_runtime_put_autosuspend() already 
incorporates pm_runtime_mark_last_busy(). I will include an extra patch 
in my upcoming v7 series to remove the redundant 
pm_runtime_mark_last_busy() call, including the leftover instance in 
analogix_dp_bridge_detect() from [1].

[0] https://lore.kernel.org/all/sashiko-outbox-176895@kernel.org/
[1] 
https://lore.kernel.org/all/20261113082305.541652-4-damon.ding@rock-chips.com/

Best regards,
Damon

