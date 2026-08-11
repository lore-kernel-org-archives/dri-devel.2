Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD17C5AD7B
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDAD10E258;
	Tue, 11 Aug 2026 01:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AhgqQMgo";
	dkim-atps=neutral
Received: from mail-m128242.netease.com (mail-m128242.netease.com
 [103.209.128.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C8710E258
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:09:04 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 497cc1d3b;
 Tue, 11 Aug 2026 09:09:00 +0800 (GMT+08:00)
Message-ID: <c1571659-0e9c-4d00-b517-c344c2772f9e@rock-chips.com>
Date: Tue, 11 Aug 2026 09:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>, royalnet026@gmail.com,
 heiko@sntech.de, tomeu@tomeuvizoso.net, robin.murphy@arm.com,
 diederik@cknow-tech.com
Cc: alchark@flipper.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-8-gahing@gahingwoo.com>
 <20260807211629.1573228-1-gahing@gahingwoo.com>
 <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
 <20260810104718.1214191-1-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260810104718.1214191-1-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fee5d9f0403a7kunm580812a34372e1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh1NVhhMTExPHRgZQ0IYGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=AhgqQMgoktMUJi3o7cEQ1EXjE1h6vtnke8qGBVEBJXyJDfTCkhJFBq8MVGdaqDT9vTZ56M6MTDOe66Ite3rdCLeZ0M0xfI9/E8D252RhX8EzIQcvcNwD9fp8kw5XsyrUNE9tiwlGaSiDNoUtyt7rrxxO3ZuecyLg7PZ3vsemUqw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=5ox2pSQcRMCfh620cnCM//FeEtDAYOQ5T3MWVhlTcio=;
 h=date:mime-version:subject:message-id:from;
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

Hi Jiaxing,

On 8/10/2026 6:47 PM, Jiaxing Hu wrote:
> Hi Chaoyi,
> 
> Thank you, that settles it, and no apology needed for not reading the
> series.
> 
>> For RK3576:
>>
>> - BIT[15:0] task_number
>> - BIT[16] task_pp_en
>> - BIT[17] task_count_clear
>> - BIT[18] task_last_layer_clear
> 
> That matches the register trace bit for bit, and it is worth more than
> the trace, because the trace could only say which word the vendor writes
> and not what the bits in it are.
> 
> BIT[18] is new to me. I was setting it because the vendor's word had it
> set and clearing it was not something I wanted to try blind. Now it can
> be named rather than shipped as 0x7 << 16:
> 
>   #define PC_TASK_CON_TASK_NUMBER		GENMASK(15, 0)
>   #define PC_TASK_CON_TASK_PP_EN		BIT(16)
>   #define PC_TASK_CON_TASK_COUNT_CLEAR		BIT(17)
>   #define PC_TASK_CON_TASK_LAST_LAYER_CLEAR	BIT(18)
> 
> with the RK3588 positions kept beside them, since the two differ only in
> the width of the first field and that is exactly what made v1 through v6
> wrong.
> 
> One question, if you have a moment. Is task_last_layer_clear meant to be
> set on every submit, or only on the task that ends a layer? Setting it
> unconditionally works on RK3576 here, but working and being right are
> not the same thing, and I would rather not encode a guess in a driver
> other people will copy from.

I think it should be for every submit. That is, when you set task_count_clear,
you should also set task_last_layer_clear at the same time.

> 
> Thanks again,
> Jiaxing
> 
> 

-- 
Best, 
Chaoyi
