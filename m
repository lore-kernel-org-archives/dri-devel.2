Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933760A2606
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E7hhSc+A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8015910E267;
	Thu, 19 Nov 2026 18:31:57 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E2D10E3CE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:31:51 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so70415c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795113111; x=1795717911;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s+cdKSsVMRJoMNbbuM4EY55OU9p2WNGal5/x59TGwPg=;
 b=E7hhSc+AlmfyFkY0NpDzGMD+ybRW5ss4yNg4HHUBJll3DooWru8ZcPCprDhSFMm2nm
 Rdu3NYx5uHBW4gudTHNyPTUOOszP8J2ljSLqnhz2srxXUlLICTJ3aMui+Asi9wMNs788
 ky2DEnBS6JtTgw4s73w0DhXSIkcPkuba7hbR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113111; x=1795717911;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s+cdKSsVMRJoMNbbuM4EY55OU9p2WNGal5/x59TGwPg=;
 b=p4gz8GtdBYPXRlWqbH9JtV/TPoeu8a5hrDZDlTZ95qcYLFhdIACDvSB8lRHZljjYUX
 cYZZDSkUDyXrN2zGTMq1oDX3UzVZCMkmxYnOWXmJwo/tqpLbLL/2DDIsSTK8aeznTY61
 I7kq/Lj5ntKyQ/KUZdvYZykutGLqGZXxjEYFsjmj2myWeou5Qe8eBWCodGPch1cfe0hI
 Cm3m5sHdS+YCYXeg5cIjIYS7DlZZ+ebUUwkcEsOjQk91jInlmx0GQyA9A49XjSyyOTak
 /Fs7mi1CvFxwyuPM+2712sPumaGtlziBe0OQOhh9Ys4XCs4bXW4+2WxicCeokSplLnAR
 E+IQ==
X-Gm-Message-State: APuU4Z+m3ZsuBLGgZtoqAdsuXPtpTniH4ActfzrIGh8m4EzUb2Qe9Xlx
 7GOB0hySQJf7vONX4dWLpZLfs+xw7lcFj8yDPUt24XmLrXyQF4uRYSLY+KQ/dYCtuQ==
X-Gm-Gg: AYBFou1bLYPTuKfIwLIA3AFwTrDnV8YStd26n1LiFrMxvWPtmO1GbxzSHhV/S4GV+1O
 KgeFAXn8mNeYiOZZW7NGesYaAYl5anxcMn7XZ3VSKZ9f8lIaKDrpQAnCbsdlXDQIgHlPmMiT2PF
 MAJyyKF1jPoFNW+vq5Jx+Y0EY8+3MTNOPxDjGXFk06CwynyNedTspzYd/7H3wPRiqyRIoCJsIXK
 ZGAduHZO45B4ISwGm0DUx5CIyaIL4vyhAaDurqdy+YcuOwnvmWMW7Q2nX/5vJrhvqy0MP4DEEWA
 +VPDcPKOwiP8UcD5kkS15h7l1xlMlUd0M6wM8bJX7mqEM3bSh4/VLevrGi96jxBjfggSEo9OxS6
 rvdMbT58K3cSvIewuTqyz023ezH0c+Ccx82l3/464t35ayA5edugB46wGmfxUKUnOwCA2GBBket
 WtXydvDWRmltPXX9CDZfz6R2Gv4Nf/0wi3rbBm5Luvr7kG2Fn+ezX8tyjHZ7r4oJs25o36tWdz7
 RNSCcNQWtvIQsSMqlONlk/o1Ljd0l6UzwhdvKigNVNz6/a3seH90jKpFZ2qeTuMfZzufa4dxwUe
 aSUhgvFS0yE8JbNnjjpBd5e1PxIhJhRVzYy4pBpbG79/qMnvaOxHqaZJ4PlU5llPMI61
X-Received: by 2002:a05:7022:1587:b0:1b2:6d5b:36bc with SMTP id
 a92af1059eb24-1b5568efd35mr474918c88.23.1795113110846; 
 Thu, 19 Nov 2026 10:31:50 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
 by smtp.gmail.com with UTF8SMTPSA id
 a92af1059eb24-1b5568592adsm865132c88.15.2026.11.19.10.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:31:50 -0800 (PST)
Date: Thu, 19 Nov 2026 10:31:47 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Power down synchronously on
 bridge disable
Message-ID: <av9AkwQDhB7O4wgl@google.com>
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
 <20261119084923.1156243-1-m.szyprowski@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119084923.1156243-1-m.szyprowski@samsung.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, Nov 19, 2026 at 09:49:21AM +0100, Marek Szyprowski wrote:
> The pipe (FIMD -> DP video) clock on Exynos is switched from the
> analogix_dp runtime PM callbacks via plat_data->power_on()/power_off(),
> which require the encoder to be still attached to a CRTC. The driver
> relies on pm_runtime_put_sync() in analogix_dp_bridge_disable() to run
> the runtime suspend callback immediately, while the encoder->crtc link
> is still valid.

This is a bit concerning, as this is somewhat of a misunderstanding of
how runtime PM works. (But then, I guess it's not really surprising that
people misunderstand runtime PM -- it's highly confusing.)

Runtime PM cannot guarantee that something powers off, at least while
runtime PM is enabled. It provides hints, but those can be overridden.

A primary reason: /sys/.../<this_device>/power/control can be set to
'on', which means the device will always be prevented from
runtime-suspending. So I assume that if you 'echo on >
.../power/control', you'll still see the same bug.

(It's possible that 'power/control' is the only way things break. I've
wondered at times whether we should allow for drivers to opt out, and
block this interface.)

> The device uses autosuspend, so whether put_sync() suspends the device
> right away depends on the last_busy timestamp. Since commit f2b556e3dad6
> ("PM: runtime: Update last_busy before calling rpm_suspend() in
> rpm_idle()") last_busy is refreshed in rpm_idle(), so
> pm_runtime_put_sync() now only schedules an autosuspend 100ms later.

I don't think commit f2b556e3dad6 is the only reason you'll get this
behavior. There's also:

55b2b8af704f ("PM: runtime: Update last_busy in rpm_resume() for active devices")
56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")

Those are all reasons that last_busy may get refreshed without explicit
calls in your driver.

> During system suspend this means that the device is runtime suspended
> only by pm_runtime_force_suspend(), when encoder->crtc is already NULL,
> so the FIMD DP clock is never disabled and its cached state gets out of
> sync with the hardware after FIMD loses power. On resume the clock is
> not re-enabled and enabling the bridge fails on Exynos5250 Snow:

I didn't spend enough time on all of this to see if it makes any sense
(or if, for instance, it's just LLM garbage), but it seems suspect that
you have to reason about runtime PM state so much in order to get
correct system PM behavior. They should be pretty much orthogonal,
functionally.

>   exynos-dp 145b0000.dp-controller: Timeout of slave video streamclk ok
>   exynos-dp 145b0000.dp-controller: unable to config video
>   [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>   exynos-dp 145b0000.dp-controller: failed to set bridge, retry: 0
>   ...
>   exynos-dp 145b0000.dp-controller: too many times retry set bridge, give it up
> 
> Use pm_runtime_put_sync_suspend() in the bridge disable path and in the
> analogix_dp_set_bridge() error path, so the hardware is powered down
> immediately when the display is turned off, regardless of the
> autosuspend delay used for the AUX channel transfers.
> 
> Fixes: f28dd5075675 ("drm/bridge: analogix_dp: Enable autosuspend")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This patch has been developed with LLM assistance and have been tested
> on the real Exynos5250-based Snow Chromebook device.
> 
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8bb4c48aa3b4..022acb962b7c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1021,7 +1021,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>  	return 0;
>  
>  out_dp_init:
> -	pm_runtime_put_sync(dp->dev);
> +	pm_runtime_put_sync_suspend(dp->dev);
>  
>  	return ret;
>  }
> @@ -1163,7 +1163,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>  
>  	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
>  
> -	pm_runtime_put_sync(dp->dev);
> +	pm_runtime_put_sync_suspend(dp->dev);

These may be valid changes to make (they are the correct way to
purposely skip autosuspend delays), but I'm not sure about all the
justification, and whether they imply there are larger bugs in here that
you're papering over.

Brian

>  
>  	dp->fast_train_enable = false;
>  	dp->psr_supported = false;
> -- 
> 2.43.0
> 
