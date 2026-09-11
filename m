Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EF8C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4D210F575;
	Fri, 11 Sep 2026 11:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imm0nv1nhtv.is-a.dev header.i=@imm0nv1nhtv.is-a.dev header.b="OQMlXoST";
	dkim-atps=neutral
Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7226010F577
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2602131731; d=imm0nv1nhtv.is-a.dev; t=1789127753;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sttmLPJbXqHF8O2Q3VVBCslXXNEiPN/DARq1dGZW598=;
 b=OQMlXoSTiuvUh7CxiC5gLNt14LEf46Dtw5N1y9TaRUMgUAEbWiqpkOqm0ncnRdZPPaX5WN
 +7332n9yh/AjDbL9q9NMuDGJ4h586I5taapQ8crFSTTRrMnMKOs82sei94VtVx6AI6Ywfv
 Q6M42sakRiNUUKSy0YH2DVbVBrHPftEDFZ3+2bAAzZGuTpW5QtCRjpHDX+i0/mt0XhW2ju
 H4QmUIwK9UatLW6KjazoQhUy634Sh0v7/vo+XH7cPDbYfQmulzOg8r7yQuAkvvyqEB5wpa
 tJBCJI928v28otULxTLw41gm416Wr5V6NtTZPn4N8gDCtijbvakvF5kvh72BVQ==
Content-Transfer-Encoding: 7bit
X-Original-From: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Content-Language: en-US
To: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Alex Deucher" <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
User-Agent: Mozilla Thunderbird
Date: Fri, 11 Sep 2026 18:55:50 +0700
Message-Id: <a92e12a1-bd95-449d-bb02-9ab62481e8c7@imm0nv1nhtv.is-a.dev>
Mime-Version: 1.0
Cc: "Rodrigo Siqueira" <siqueira@igalia.com>, 
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, 
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/amd/display: close DDC on I2C engine setup
 failure
Received: from [192.168.100.185] ([42.112.63.158]) by smtp.larksuite.com with
 ESMTPS; Fri, 11 Sep 2026 11:55:52 +0000
In-Reply-To: <20260826204457.4666-2-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826204457.4666-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826204457.4666-2-neptune@imm0nv1nhtv.is-a.dev>
Autocrypt: addr=neptune@imm0nv1nhtv.is-a.dev; keydata=
 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
 w7556xiTImYhxhLT4QiuJfjqiGM=
Content-Type: text/plain; charset=UTF-8
From: "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
X-Lms-Return-Path: <lba+26aa3ec49+9ad036+lists.freedesktop.org+neptune@imm0nv1nhtv.is-a.dev>
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

Just a kind reminder to check this patch, thank you!

Best regards,
NepNep7601

On 27/08/2026 03:44, NepNep7601 wrote:
> acquire_i2c_hw_engine() opens the DDC pins before setting up the
> hardware engine. If setup_engine() fails, the error path releases the
> engine but leaves the DDC pins open and the engine's DDC pointer set.
> 
> Subsequent attempts to open the pins then return
> GPIO_RESULT_ALREADY_OPENED, preventing further I2C transfers, EDID
> reads and hotplug detection on that port until reboot.
> 
> Mirror the normal teardown path by closing the DDC pins and clearing
> the pointer after releasing the engine.
> 
> Assisted-by: Codex:gpt-5
> Signed-off-by: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
> ---
>   drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> index 05892ab4529f..e7a05494abab 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> @@ -485,6 +485,8 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
>   
>   	if (!setup_engine(dce_i2c_hw)) {
>   		release_engine(dce_i2c_hw);
> +		dal_ddc_close(dce_i2c_hw->ddc);
> +		dce_i2c_hw->ddc = NULL;
>   		return NULL;
>   	}
