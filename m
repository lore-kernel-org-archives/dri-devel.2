Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65499C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB8E10E672;
	Tue,  4 Aug 2026 06:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Pe7w/ejm";
	dkim-atps=neutral
X-Greylist: delayed 56727 seconds by postgrey-1.36 at gabe;
 Tue, 04 Aug 2026 06:42:06 UTC
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BC110E672
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785825724; x=1786084924;
 bh=31Ug+fA+RrUX7m+kiXo712hLEFUM8g1A+Ov7N/lwW1w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Pe7w/ejmJtF3Zldi1kAmx1elH6px3iFzJjqppVszQs1k2qJGoSe07sDhioClu7k8t
 hfEKu6KbvZEk5dO0gjBSj1Ru4gMqs3xhojbnkDWsxNuNBMIo6ryEO1psWKjk1tIuyc
 yOBW7KRCoDwv2LE6nWuemGkjqf/WWobPieVSSaEHudpmQTt9PuPGFIKRYHdGuIUFNk
 E/6bveEHGnW5pXboiHwuOMbf8a6CG2qpAKOh+HOXlDUjvbuTGPeLPRstC0B7IUN688
 HwQ7Rhs6zwxRKBhj+EKPOphdT68EVrdidaLhGqIBG5C/YcDjvtlA08iWBH9EDGzsGE
 RWmM3wv6qPKLw==
X-Pm-Submission-Id: 4hDkVK0ysCz1DGhD
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
In-Reply-To: <20260803150412.BF11F1F000E9@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Mon, 03 Aug 2026 15:04:12
 +0000")
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
 <6QecEBYszLlt-wRCd-IUkmVSkazILKAUnV8GyeWN-yOnVHHlKwWkc1E632SK5diLdL_qS6z4QTHRg1DqEGIY_A==@protonmail.internalid>
 <20260803150412.BF11F1F000E9@smtp.kernel.org>
Date: Tue, 04 Aug 2026 08:41:52 +0200
Message-ID: <87y0embd5b.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Leaking an SRCU read lock on the error path in `sn65dsi83_reset_work()` due to an early return without calling `drm_bridge_exit()`.
> --
>
> --- Patch [1]: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe() ---
> commit d19637cc30dea31a13c6747fe2aa3733116ec5e5
> Author: Esben Haabendal <esben@geanix.com>
>
> drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe()
>
> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.
>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> index 42b451432bbb6..476f255bd34dd 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> @@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
>>  	drm_modeset_drop_locks(&ctx);
>>  	drm_modeset_acquire_fini(&ctx);
>>
>> -	return 0;
>> +	return err;
>>  }
>>
>>  static void sn65dsi83_reset_work(struct work_struct *ws)
>
> [Severity: High]
> Does propagating the error here cause an SRCU read lock leak?
>
> By propagating the error from sn65dsi83_reset_pipe(), it is now possible
> to hit the early return path in sn65dsi83_reset_work():
>
> 	if (!drm_bridge_enter(&ctx->bridge, &idx))
> 		return;
>
> 	/* Reset the pipe */
> 	ret = sn65dsi83_reset_pipe(ctx);
> 	if (ret) {
> 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> 		return;
> 	}
>
> Because this early return skips the call to drm_bridge_exit(idx) at the
> end of the function, wouldn't this leak the lock and cause a system hang
> during drm_bridge_unplug() when synchronize_srcu() is called?

Yes. This is resolved in patch 2. I will reorder the patches in next
version.

/Esben
