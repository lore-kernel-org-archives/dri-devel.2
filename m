Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEACA606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JSrzm9lX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E590910E8E7;
	Fri, 20 Nov 2026 02:15:49 +0000 (UTC)
Received: from mail-m83196.xmail.ntesmail.com (mail-m83196.xmail.ntesmail.com
 [156.224.83.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBF511284E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:15:42 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5559cde68;
 Fri, 20 Nov 2026 10:15:39 +0800 (GMT+08:00)
Message-ID: <9c6ab599-1401-4ecc-b938-092b01faef01@rock-chips.com>
Date: Fri, 20 Nov 2026 10:15:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix runtime PM reference leak in
 set_bridge
To: Brian Norris <briannorris@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>
References: <CGME20261119093353eucas1p1de9688c7e1847ae8266690934b09f925@eucas1p1.samsung.com>
 <20261119093347.1159198-1-m.szyprowski@samsung.com>
 <av85x_6VV1qcsUgh@google.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <av85x_6VV1qcsUgh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1f6bceed203a8kunm2770188244a2b9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR0aVh1OHk0ZQ0IYGR5OHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=JSrzm9lXyxx3w3l7KB5dOIHtupyOnasP7oph2uzAHGviAsg5hZj6qhs6NttCDMcZ8bEHBduHQl2DEcLaq5uoUTf862KKmv04rGO40YryLONwujqL378G/MB3dsHW9twtlp0/yLIJ+QerVn4zl9lZ1qFvMuvKolSWIqxDjC/XGK0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=XVvS1kp9P1+4Lyq0yhUjBJqDFYBYQ7mQNTUrpWUdSQM=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/2026 2:02 AM, Brian Norris wrote:
> On Thu, Nov 19, 2026 at 10:33:46AM +0100, Marek Szyprowski wrote:
>> analogix_dp_set_bridge() takes a runtime PM reference at the beginning,
>> but returns directly without dropping it when
>> analogix_dp_init_analog_func() fails. Jump to the common error path
>> instead, which drops the reference.
>>
>> Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 022acb962b7c..84951413012b 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -998,7 +998,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>>   
>>   	ret = analogix_dp_init_analog_func(dp);
> 
> This function never fails, in fact. So this patch is just an academic
> exercise.
> 
> Personally, I'd prefer you just make analogix_dp_init_analog_func()
> return void, to simplify things.
> 

I agree with Brian, that sounds like a cleaner approach.

Best regards,
Damon

