Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C08C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB44810ED9F;
	Mon, 14 Sep 2026 12:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="n0P2cKvZ";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9274710ED9F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SLMQO28uQgqrnJh6++zlcI3D9Cp6DaVv2tStRpu6n7g=; b=n0P2cKvZQr1mhdDWSiR/mWQvv9
 QwGVwbL+cXUCOdfFgwoP9HfIcnCDWHOX9tk/IYM5XmtD37kmexj416VjVqtdn/isteChz3Xh6hcFA
 opQs9C8GFARll7Kd8mN3dQlX0i+S2pv12U8bxbgP77ndK/EygG6uKdihsPTcZ3Bx0GO0=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1x65P7-00000009zfN-0vLA; Mon, 14 Sep 2026 15:03:23 +0300
Message-ID: <3eb4f6f6-e8bb-4094-b5bd-8b65fd843243@minlexx.ru>
Date: Mon, 14 Sep 2026 15:03:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/panel: novatek-nt36672a: Add Tianma panel for
 Xiaomi Mi A2
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-7-ce097402c6ea@minlexx.ru>
 <20260913063102.0BEC71F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260913063102.0BEC71F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13.09.2026 09:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Direct use of `usleep_range` instead of `mipi_dsi_usleep_range` bypasses multi-context error tracking.
> --
> 
> commit 883b76cff93d823c9430acc0b7cfca0a77f61ed2
> Author: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
> 
> Add support for Tianma TL060FVXS16-00 video mode panel based on
> Novatek NT36672A, used in Xiaomi Mi A2 smartphone (xiaomi-jasmine).
> It shares some code with already supported panel in this driver
> for xiaomi-lavender, so we can reuse the same panel deinit function.
> 
>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
>> index e6971ba6ef464..1bfa808365874 100644
>> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
>> @@ -445,6 +445,29 @@ static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>>   	mipi_dsi_msleep(dsi_ctx, 120);
>>   }
>>   
>> +static void tianma_jasmine_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>> +{
> [ ... ]
>> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
>> +	usleep_range(5000, 6000);
> 
> [Severity: Low]
> Is it intentional to use usleep_range() here instead of mipi_dsi_usleep_range()?
> 
> Using usleep_range() directly bypasses the multi-context error tracking in
> tianma_jasmine_init_cmds(). This causes the unconditional 5-6ms sleep to
> execute even if previous DSI commands have failed and set dsi_ctx->accum_err.
> 
>> +}
> 

Good find, this is likely not intentional, will be fixed in v2.

--
Regards,
Alexey Minnekhanov
