Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65290C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84D610E09E;
	Tue,  4 Aug 2026 06:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Nn8YHZBx";
	dkim-atps=neutral
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBE710E09E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 06:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785826110; x=1786085310;
 bh=KqfKYGJNjUhLaSbht+pZlWC4kNkno5tAwM66cjF7pOo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Nn8YHZBxoxcm8q3IdKc0RZvj4sZ1ZWU1Zkg+S/aq3JRl55xBChJoBDqdBQ2Yg22L/
 blueCFboPS3fBp1B6cykoqG5EL+aHLI5//+F0on4OIfFUgMWKM52932g1DneIZ6FXN
 U2rc0UfXeocagPRhOv98GvF6rqBPgefqIKWTPWgQZU790VhBWgJT6ZmAEYXinGsnlP
 Y/bEqGs4QHmX4LJ1EXVCLw2q71i/A+N4a45WgeOfeFo2LtYZsxld8pbv+jw4hMFLEL
 1o0FMUqNYeGfAN7/Wwhz6ydlXk3F4QcY92kr2D41DwKC2i4Vv4spaSw4c0B0wv9OYK
 RdV2bP+tSKZ/g==
X-Pm-Submission-Id: 4hDkdn21mVz2Sdm1
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
In-Reply-To: <20260803152112.5CC281F000E9@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Mon, 03 Aug 2026 15:21:11
 +0000")
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
 <TKBCK7kXBFomt3_G6e_k5x4Azce7mNJH-pBKtQftoFH2IaNTAU1lbZd0nwutvpQD9ZhjDZGOxBjCFfBJG0fFmA==@protonmail.internalid>
 <20260803152112.5CC281F000E9@smtp.kernel.org>
Date: Tue, 04 Aug 2026 08:48:25 +0200
Message-ID: <87tspabcue.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing cancel_work_sync() for ctx->reset_work during driver=
 teardown leads to a Use-After-Free.
> - [High] Skipping enable_irq() on the error path causes an IRQ disable de=
pth leak, leaving the interrupt permanently disabled.
> --
>
> --- Patch [2]: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handlin=
g in sn65dsi83_reset_work() ---
> commit 58246b5ef131d7aeea7b5c2b693088e7255aa435
> Author: Esben Haabendal <esben@geanix.com>
>
> drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
>
> This commit fixes the error path in sn65dsi83_reset_work() by adding a
> goto to ensure drm_bridge_exit() is called when sn65dsi83_reset_pipe()
> fails, safely closing the critical section.
>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bri=
dge/ti-sn65dsi83.c
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> @@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struc=
t *ws)
>
> [Severity: Critical]
> This is a pre-existing issue, but could this work function execute after
> the device is unbound, resulting in a use-after-free?
>
> If the driver is removed and devres frees the ctx structure, the work
> could still be pending since sn65dsi83_remove() does not appear to call
> cancel_work_sync() before returning:
>
> sn65dsi83_remove() {
>         ...
>         drm_bridge_unplug(&ctx->bridge);
>         // missing cancel_work_sync(&ctx->reset_work);
> }
>
> If the workqueue executes sn65dsi83_reset_work() after teardown,
> dereferencing ctx for drm_bridge_enter() might access freed memory.
>
>>  	ret =3D sn65dsi83_reset_pipe(ctx);
>>  	if (ret) {
>>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
>> -		return;
>> +		goto err_exit;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't jumping to err_exit
> here leave the interrupt permanently disabled?
>
> If a hardware error triggers the IRQ handler, sn65dsi83_handle_errors()
> calls disable_irq_nosync(), which increments the IRQ disable depth. By
> skipping the enable_irq() call on this error path, the depth counter
> remains unbalanced.
>
> Would it be better to mask the interrupt source via hardware registers
> on failure, and still call enable_irq() so the kernel's depth counter
> remains balanced?

Nah. I would rather just balance the counter here.
Calling enable_irq() on error should be the safe choice.
As sn65dsi83_reset_pipe() have always been returning 0 until now, we
have in practise been doing that unconditionally anyway.

I will do that in next version.

>
>>  	}
>>  	if (ctx->irq)
>>  		enable_irq(ctx->irq);
>>
>> +err_exit:
>>  	drm_bridge_exit(idx);
>>  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-ti-sn65d=
si83-fixes-v3-0-9b403a405ccd@geanix.com?part=3D2
