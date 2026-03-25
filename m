Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE5E106B535
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD7310E14C;
	Wed, 25 Mar 2026 13:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lo/fNibT";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5835510E14C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:21:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A32AAC580B0;
 Wed, 25 Mar 2026 13:21:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BBECF601E2;
 Wed, 25 Mar 2026 13:21:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4B0D10450421; Wed, 25 Mar 2026 14:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774444870; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+xRZGZvq2GLBJmIqKT8BZBXN491lE9vOI5vb0OL9QoE=;
 b=Lo/fNibTAQfAX1a1ZFIf9bRdoIhrrvxXCuBBw3iPOeSEFhhdxSuOA15Qy66sWgUg8lI4dM
 T5Ud/gmaVXt7QbbQM7O3x8okas1huS01h2LJTiM0thS02IYbOYLKpj95EeyU5xXnVJJ6Oc
 uVTd/DORt5rJ8Jlia0b/ev2xQiVBIWZpZFTVPpuOoi1FBEvFEx8yUkTmMuUnx0yfxdlFQV
 do357Uhm3wSOnutkc5Di/hYHV1huskdwGrvZjr1RkHQoYb0kHgkExPxbW3aScC18c1WgYv
 XK6quBcw33+NSSpIEXMc3BXvi0egVeaytpVQk2xaXlxG4G58kxU9i204DyaGiQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org, 
 m.szyprowski@samsung.com, andy.yan@rock-chips.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251110085823.1197472-1-damon.ding@rock-chips.com>
References: <20251110085823.1197472-1-damon.ding@rock-chips.com>
Subject: Re: [PATCH v3 0/4] Apply DP helper APIs to do link train
Message-Id: <177444486244.646888.15598255632496167976.b4-ty@b4>
Date: Wed, 25 Mar 2026 14:21:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3
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


On Mon, 10 Nov 2025 16:58:19 +0800, Damon Ding wrote:
> Use the existing DP helper APIs instead of repeated self-defined
> interfaces with the same functions. It can help make codes more
> concise.
> 
> Damon Ding (4):
>   drm/bridge: analogix_dp: Apply DP helper API
>     drm_dp_dpcd_read_link_status()
>   drm/bridge: analogix_dp: Apply DP helper API
>     drm_dp_clock_recovery_ok()
>   drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
>   drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages
>     and pre-emphasises
> 
> [...]

Applied, thanks!

[1/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_dpcd_read_link_status()
      commit: b97a424b09b33cbec216706a84006fae6ed7084d
[2/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_clock_recovery_ok()
      commit: e0735bfd5dd1987d4849c331a2ef0194694a3c5f
[3/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
      commit: 51eb548ade20158b4f4f8693a95b1f31a2480e8e
[4/4] drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages and pre-emphasises
      commit: d84b087c7662dd65cd51b228219987c31b1cee02

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

