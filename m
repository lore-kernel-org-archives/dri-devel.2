Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C664C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FD310E168;
	Tue, 25 Aug 2026 09:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="D44ofn27";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BBF10E168
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1787648503; x=1787907703;
 bh=/nP18Hx0tRTE63n07f6nEormlZZuADgFGbIvgxd/UIs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=D44ofn27juLRVWR8xgNLgZb2c1JvlMBnRfURDXaBrx3c9c7xXIAL8GGcGUCYx+XbQ
 AKVcRURSarvaoYdn6o0NtNkMZzVmv3sp/dGsPzUXiMeEMuggPQhWcCV82BCGW4nAIy
 NU/dqR9e0vZ0sUdW46hiodgMxGpDnyYmeVoYMVMg00FVfy/HQUc0gy8ooD6eV4qAZM
 OhH8hgbdKyYuD59TFjKTrMjoL7KPaTlLbWp9TLkNvnKghgEX1NnyB/zKD0qr6O6ul+
 Uxk6jj5QkcQKHEexDCx8D6lCyFfCCCDi3YdfAjvHf92MCIDXY5SuB1L4XHhGsCfItG
 lRc8e8zthxPlg==
X-Pm-Submission-Id: 4hThbm54v1z1DDX8
From: Esben Haabendal <esben@geanix.com>
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: "Luca Ceresoli" <luca.ceresoli@bootlin.com>,  "Andrzej Hajda"
 <andrzej.hajda@intel.com>,  "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,  "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,  "Linus
 Walleij" <linusw@kernel.org>,  "Frieder Schrempf"
 <frieder.schrempf@kontron.de>,  "Marek Vasut" <marex@denx.de>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
In-Reply-To: <20260819113253.5d602b2d@bootlin.com> (Herve Codina's message of
 "Wed, 19 Aug 2026 11:32:53 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
 <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
 <BAolbDDI0aiCzU2P4vC8Ym-ffhydGSVEvFuW-aVRTvqdzKqwFi53nnr3ps6bh1e6B-ioI-Jh9tKY76dHj6kkrw==@protonmail.internalid>
 <20260819113253.5d602b2d@bootlin.com>
Date: Tue, 25 Aug 2026 11:01:39 +0200
Message-ID: <87o6eqo9os.fsf@geanix.com>
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

"Herve Codina" <herve.codina@bootlin.com> writes:

> Hi Esben,
>
> On Mon, 10 Aug 2026 09:19:40 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> The error handling of sn65dsi83_reset_pipe() failure in
>> sn65dsi83_reset_work() has been a bit strange all the time, missing both
>> enable_irq() and drm_bridge_exit() in case of failure. But since
>> sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
>> not caused any problems.
>>
>> As we are going to change sn65dsi83_reset_pipe() to return error values in
>> case of failure, we need to fix this.
>>
>> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> index 42b451432bbb..0ccfff401b2a 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> @@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
>>
>>  	/* Reset the pipe */
>>  	ret = sn65dsi83_reset_pipe(ctx);
>> -	if (ret) {
>> +	if (ret)
>>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
>> -		return;
>> -	}
>> +
>>  	if (ctx->irq)
>>  		enable_irq(ctx->irq);
>>
>>
>
> In this v4, enable_irq() is called even if we cannot reset the pipe. I know that
> sn65dsi83_reset_pipe() always returns 0 (and this will be change) but we have to
> take care here.
>
> If the pipe cannot be reset, the sn65dsi83 component could be in a state where
> it can force the interrupt line. This was the reason the irq is disabled
>   https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/bridge/ti-sn65dsi83.c#L455

Ok. But maybe take it in two steps.

The change here, together with the change that makes
sn65dsi83_reset_pipe() return non-zero on error, should ensure that
behavior is unchanged. As long as sn65dsi83_reset_pipe() was always
returning 0, we have been calling enable_irq() even if the pipe cannot
be reset.

If that is a problem, I think it is fair to do that as a separate
change. As you say, we have to take care here.

If we leave the irq disabled when sn65dsi83_reset_pipe() fails, do we
simply want to leave the device with irq permanently disabled, or should
we add some additional logic to sn65dsi83_handle_errors() so that we
will try to recover periodically via sn65dsi83_monitor_work()?

I think this is tricky enough to warrant a new patch series.

/Esben
