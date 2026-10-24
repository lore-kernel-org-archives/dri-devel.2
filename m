Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A05606A324
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=PlWGrR3n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D286C10E339;
	Sat, 24 Oct 2026 02:58:45 +0000 (UTC)
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E71110E339
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 02:58:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=gMqBedMqV6/PbEo4P/C/wuOOsirk4D+GGPXOjLgDTws=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792810716; v=1; x=1793415516;
 b=PlWGrR3n5CnVaJDtS1BCZrLEZV3BF47ZC06Vma1LNJdgfCCgzrXTMjkFGKt+sa0M4rJgIwaK
 k9ZAf95fFi3BfwFIZ9Jy5AxUE8QAd35QRYOnQTb77MZggU2qQ2iAhPZ5E5j+/wKgAud/knZx/Lr
 v3F7bd7suXx+ICwQZp79cus9p8Ke6NTVM4dkrUUe8pRkQHoxmBE8UZmM5r8oaD5vUPSTsAqnva+
 ck4gYX12rZE9HpeiCRmiL0cH1HyQM+UZ8vg48r/NeghbdUC80hpGVYnnu+0XyJxrFAt4ZHYCW0v
 ynhE94sD95pd3aJWyXGcJT9k0yYW8Wr11RuiOpVnC4oHQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 16e8be6ff7b3bc0f;
 Sat, 24 Oct 2026 02:58:36 +0000
X-Mizu-Trace-ID: 16e8be6ff7b3bc0f
X-Migadu-Flow: FLOW_OUT
Message-ID: <c1f5b813-4228-42ff-94ac-2ea6533328f2@packett.cool>
Date: Fri, 23 Oct 2026 23:58:25 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] drm/msm/dp: hold one runtime PM reference per plugged state
To: Joonhoe Kim <26rote@gmail.com>, robin.clark@oss.qualcomm.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 yongxing.mou@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261007155848.106-1-26rote@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261007155848.106-1-26rote@gmail.com>
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/7/26 12:58 PM, Joonhoe Kim wrote:
> The plug handler takes a runtime PM reference every time it runs and
> sets dp->plugged; the unplug handler drops a single reference when
> dp->plugged is set. msm_dp_bridge_detect() also takes a reference and
> marks the sink plugged, and keeps that reference as well -- on every
> detect while the sink stays connected. On top of that, in the current
> tree the plug handler runs more than once per plug:
> drm_bridge_connector_detect() calls .detect() and then .hpd_notify(),
> and pmic_glink altmode reports an IRQ_HPD as "connected" too. Every
> extra reference is leaked on unplug.
>
> On a Lenovo TB323FU (SM8850, DP over the USB-C port via pmic_glink
> altmode) the DP controller's usage count reached 28-34 after a few
> plugs (rpm_usage tracepoint), so the controller never runtime-suspended
> after the display was unplugged. It in turn kept the MDSS core GDSC on
> while all displays were off.
>
> Make the plugged state own exactly one reference: the plug handler
> only takes it when the sink was not plugged yet, and detect() returns
> its own reference when the plugged state already holds one, or drops
> both when it finds the sink gone.
>
> With this the count stays at 1-3 while a display is connected, the
> controller suspends 3-4 s after unplug, MDSS suspends and its GDSC
> powers off on DPMS off, and replugging (quickly or after 20 s) still
> brings the picture back. Only tested on this device.
>
> Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Changes in v2:
> - Drop the plugged state's reference once, after the if/else, instead
>    of in both branches [Val]
> - Drop the comments
> - Link to v1: https://lore.kernel.org/all/20260929130627.959-1-26rote@gmail.com/
>
>   drivers/gpu/drm/msm/dp/dp_display.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 6abe30bdff12..4059cb9dba64 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -412,10 +412,12 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>   
>   	guard(mutex)(&dp->plugged_lock);
>   
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret) {
> -		DRM_ERROR("failed to pm_runtime_resume\n");
> -		return ret;
> +	if (!dp->plugged) {
> +		ret = pm_runtime_resume_and_get(&pdev->dev);
> +		if (ret) {
> +			DRM_ERROR("failed to pm_runtime_resume\n");
> +			return ret;
> +		}
>   	}
>   
>   	msm_dp_aux_enable_xfers(dp->aux, true);

This part (msm_dp_hpd_plug_handle) is now also handled by the IRQ_HPD 
series:

https://lore.kernel.org/all/20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com/ 


> @@ -897,6 +899,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>   	struct drm_dp_desc desc;
>   	bool phy_deinit;
> +	bool was_plugged;
>   	int ret;
>   
>   	dp = to_dp_bridge(bridge)->msm_dp_display;
> @@ -910,6 +913,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>   		return status;
>   	}
>   
> +	was_plugged = priv->plugged;
>   	phy_deinit = msm_dp_display_host_phy_init(priv);
>   
>   	msm_dp_aux_enable_xfers(priv->aux, true);
> @@ -962,6 +966,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
>   		pm_runtime_put_sync(&dp->pdev->dev);
>   	}
>   
> +	if (was_plugged)
> +		pm_runtime_put_sync(&dp->pdev->dev);

Thinking about this again, this flow of the reference(s) seems confusing.

If I understand it correctly now,

* there's a long-term reference associated with priv->plugged;
* and this function needs the device to not be suspended because it's 
doing transfers to check if there's something plugged into the port.

With the current flow (fixed by this v2 patch to not leak, or at least 
leak less):

* we always take +1 reference;
* if we "find a plug" (!was_plugged && priv->plugged): no drop, our 
reference "becomes" the long-term one;
* if we "find an unplug" (was_plugged && !priv->plugged): we drop our 
own reference, as well as the long-term one;
* if we "find no change while plugged" (was_plugged && priv->plugged): 
we only drop our own reference;
* if we "find no change while unplugged" (!was_plugged && 
!priv->plugged): no drop, is this intended or a leak still? Not clear 
who needs the reference to persist in this case?

**If** that last case is actually **not** intended to keep the 
reference, I think it would be clearer to, instead:

* use a guard (probably PM_RUNTIME_ACQUIRE_IF_ENABLED to keep the error 
check) for this function's own reference;
* and use a plain get an extra time when setting priv->plugged = true..?

> +
>   	return status;
>   }
>   


Thanks,
~val

