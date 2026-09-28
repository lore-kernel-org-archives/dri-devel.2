Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B02CA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E44D10E0E5;
	Mon, 28 Sep 2026 11:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="CWeQr2E3";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967A510E886
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:15:24 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260928111522euoutp02ab1336cec4e4d828ad8e2a1448a887e6~Zd94jeKKv1263812638euoutp02L
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260928111522euoutp02ab1336cec4e4d828ad8e2a1448a887e6~Zd94jeKKv1263812638euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790594122;
 bh=IWJTDuAAoxJNuDYoyjKdqDuwuipaiifAXkgQs8gVGbg=;
 h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
 b=CWeQr2E3HYtPOPQaQs3c7cAYkoTupw+OfNtCtlz64mrhh8ohj44KBgklfLJ1hbBAZ
 Q7O4y0ewCaDDezC5MRKEQDkpPA5TTcb2K0QrDLuCzqqbl9qPDGC9wafOQQyiAG0BZ/
 mHEiWs6gJQjESgMtzjto6UYmoNZmNBJrJ820Hik4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f~Zd937x-g32542425424eucas1p1j;
 Mon, 28 Sep 2026 11:15:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260928111521eusmtip25ee21cecd2bce4f2d8446081ed0ca8a7~Zd93m1wdG0159501595eusmtip2N;
 Mon, 28 Sep 2026 11:15:21 +0000 (GMT)
Message-ID: <c54e669b-442c-4ae4-acc3-9ccba0174fca@samsung.com>
Date: Mon, 28 Sep 2026 13:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/bridge: inno-hdmi: reset DDC segment pointer per
 I2C transfer
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Dominique Belhachemi <domibel@debian.org>, Andy Yan
 <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Language: en-US
In-Reply-To: <9274543d-c569-43a6-888c-9b74d1a8c92a@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f
X-EPHeader: CA
X-CMS-RootMailID: 20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f
References: <20260528184145.384114-1-domibel@debian.org>
 <9274543d-c569-43a6-888c-9b74d1a8c92a@samsung.com>
 <CGME20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f@eucas1p1.samsung.com>
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



On 9/27/26 10:51, Michal Wilczynski wrote:
> 
> 
> On 5/28/26 20:41, Dominique Belhachemi wrote:
>> The segment_addr and ddc_addr fields need to be reset per I2C transfer
>> to avoid stale values. The reset wasn't required on simple displays with
>> only one segment, but modern displays with two or more segments end up
>> with corrupt EDIDs.
>>
>> This was found on a StarFive VisionFive 2 SBC.
>>
>> Signed-off-by: Dominique Belhachemi <domibel@debian.org>
>> ---
>>  drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
>> index 5fa533a4eb342..297be02bbd58d 100644
>> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
>> @@ -989,6 +989,10 @@ static int inno_hdmi_i2c_xfer(struct i2c_adapter *adap,
>>  
>>  	mutex_lock(&i2c->lock);
>>  
>> +	/* Reset segment_addr and ddc_addr at the start of every I2C transfer */
>> +	i2c->ddc_addr = 0;
>> +	i2c->segment_addr = 0;
>> +
>>  	/* Clear the EDID interrupt flag and unmute the interrupt */
>>  	hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, m_INT_EDID_READY);
>>  	hdmi_writeb(hdmi, HDMI_INTERRUPT_STATUS1, m_INT_EDID_READY);
> 
> Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

I was also told that there were some changes in the MAINTAINERS file
regarding this patch and some core people may be missing e.g Luca and
Maxime.

It would be best to resend with updated list of maintainers.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
