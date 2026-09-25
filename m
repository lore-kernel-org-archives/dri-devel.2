Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442EBC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17A010E293;
	Fri, 25 Sep 2026 19:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ggJ53t7U";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494AC10E293
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790365558; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V0yHfIlicxlSFURBzR9KizSTXjiKuzKAbQAk5f/413AoFh+fdlgcQpKoNBoQy30AU7TSltLtOJRrzBW6NrXJbOw1G6imJD1XQP+BurJ0tSUooXJfF+5ybAoF9GaSt57eE8VNJJsW93Rt/zjaFOL0HA2ZQPDVIwAYsAlaSs4kcvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790365558;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qNelDJtxRD3hVHInLY1zscFbVX+OjnrhsDwrRHHSyXk=; 
 b=Z/A5r7XHGGRC/oO7ZMGHN8AnPlcibbsv6C0cB1DslIqch0VwLYSUyeqy7sWTEXBIbqTe0hfqlIhK3g8MOnkm/dn0eTQIWm/AcfXkf79uuh8qozURhI0N8u5rihcyCutkuuXdOjnp+eHjT3P6igva1tDnHPMYJJAMKCgN8hFYXlg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790365558; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=qNelDJtxRD3hVHInLY1zscFbVX+OjnrhsDwrRHHSyXk=;
 b=ggJ53t7UliP4NZMF4R4szL9N9yFHs9xlP2ZOx/gWA1PXOmXs99HCkvwi3oA6AjqX
 TYiKlJl9lfkH7WDEOmLUCEUfivZbOeyXN/ZUmpeU11yqpBGUqGPHWtp8xNSbLVcI0xw
 +BKIsooJVEDZTm0T4h59XlOevv89w5xKiTSC8/V8=
Received: by smtp.zohomail.com with SMTPS id 1790365556869124.38320245356829; 
 Fri, 25 Sep 2026 12:45:56 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 08/15] drm/panfrost: Move all DRM device
 initialisation into device_init()
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20260925-claude-fixes-v11-8-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
 <20260925-claude-fixes-v11-8-0dbf5a58e7ce@collabora.com>
Date: Fri, 25 Sep 2026 20:45:48 +0100
Message-Id: <179036554864.2217255.10773122876415356419.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=U7UArruoVKpMlDyOp9QZVpO7tn3LanpdrF8ISbtxSm0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqts9uNnZgKN8zTvaOcnkzyNQA7aRUhlJg7SPm3
 tvjn13bmwqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbPbgAKCRAOJn5M7lND
 PZfIC/0RtgIo50ztoq/PvWSpGtJX2bt0Q11yqn9L01LcsCvoSGyDh8jcUyebXWh6/Ga1bj3XJMb
 kXdmSKS1VXQHWxnmoBTwhxphEPXbqZPnepMchDS1/8HEnKgtApzIeWOkMU8jLFFNHL7ptK4jVXY
 ax68dppUN06G812RCPqIqfs0haSut9iVqjCR3P1HTiHoX4qWZR+og+DK+2NytiFVWU+TZ9fyOQx
 a3u2JKcjoiRptZ2bGsWRvR/dak5Z6auTyaS+K7ssTim/PTnAN6FFddLD7ejuwFbKbiI786zHj5l
 u6lbfuF4JO7gKun5MlM93KwlX+Z1fq+teLPMNLOBvjkvvoPrxRqsyBfjhSpOmKKR2Hjz7anAyoF
 eS8w+SthrcyEVBl5jxfKAUWo3l72Jw0Z4jLoFLn7QlOBiMBySxmyvd5ShtQAz/Wch6xCaalpVh5
 rNKeH15nGxTEH23VeJoqdj3vffRAevzmaF1cF77KwLA55E6eQlbKAUjchzoFa8fyzHbv0=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On Fri, 25 Sep 2026 19:45:29 +0100, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 9f2b1967a398..b8094c0d1252 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -311,11 +343,22 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	panfrost_reset_fini(pfdev);
>  out_pm_domain:
>  	panfrost_pm_domain_fini(pfdev);
> +
> +	if (pm_runtime_active(pfdev->base.dev)) {
> +		pm_runtime_set_suspended(pfdev->base.dev);
> +		pm_runtime_put_noidle(pfdev->base.dev);
> +	}
> +

Sashiko showed this won't work, because it'll return true when dev->power.disable_depth != 0.
However, before we enable runtime PM, its value would be -1 as set by pm_runtime_init(), so
I think I'll just create an 'initialised' bool that is set before the PM calls and check
it here instead.

-- 
Adrián Larumbe <adrian.larumbe@collabora.com>
