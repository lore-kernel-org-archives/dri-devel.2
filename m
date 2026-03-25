Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541D109C05D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B226910E1C0;
	Wed, 25 Mar 2026 20:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adishatz.org header.i=@adishatz.org header.b="TxsrGjQi";
	dkim-atps=neutral
Received: from adishatz.org (ns314768.ip-37-187-26.eu [37.187.26.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F5210E0F2;
 Wed, 25 Mar 2026 20:24:19 +0000 (UTC)
Received: from [192.168.1.197] (88-167-17-4.subs.proxad.net [88.167.17.4])
 by adishatz.org (Postfix) with ESMTPSA id AB3EE4C01F5;
 Wed, 25 Mar 2026 21:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adishatz.org;
 s=mail; t=1774470257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5gKYBO4fTmgruQ8a5PMivK7GbslUIKE49QDkqS/2uQ=;
 b=TxsrGjQiWd1WVnYFA0r13YJEH2u4S67I+5Y1oSM/DHZjXsYG8d0mEJjvzuZ7dx2RKHO7KI
 nAKaq9+XX2J1glP5bCfHGFdPgc942o5dGViyvq/yug0NJoyWd+tDCTPGjdTJIfRW8LsNes
 LT/EbLqHUOaJoGMvatdx5fbajQ5vxvn0R8czM9Jet8xb+6LQo1BF+J5JhZcxrEufOhb4nI
 kyzeqPTsuhN/AaSGPBUVwLcR0JAz3KRMi1bVdniTImhhWEOTq+N3Fu0yBWo4XxVT3l69S1
 wvP/c7qKrdXLC3v5gcP2ad8Ffg8wyVf0H3cyKFq1wzXlD35HTADDlU4sNvgWhw==
Authentication-Results: ORIGINATING; auth=pass smtp.auth=cedric.bellegarde
 smtp.mailfrom=cedric.bellegarde@adishatz.org
Message-ID: <b6df67d6-5999-48d4-bb4d-46853ca0aeab@adishatz.org>
Date: Wed, 25 Mar 2026 21:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: fix race between cmd transfer and host power
 off
Content-Language: en-US, fr-FR
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, antomani103@gmail.com,
 mitltlatltl@gmail.com, krzk@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318105635.270949-1-cedric.bellegarde@adishatz.org>
 <6wu7eezhtqyatbvoryprfpwkcmofdk4albr2zedfrbnrw37amf@rx4lslum3u6b>
From: =?UTF-8?Q?C=C3=A9dric_Bellegarde?= <cedric.bellegarde@adishatz.org>
In-Reply-To: <6wu7eezhtqyatbvoryprfpwkcmofdk4albr2zedfrbnrw37amf@rx4lslum3u6b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 18/03/2026 à 14:57, Dmitry Baryshkov a écrit :
> On Wed, Mar 18, 2026 at 11:56:35AM +0100, Cédric Bellegarde wrote:
>> The transfer function dsi_host_transfer() guards against the DSI host
>> being inactive by checking msm_host->power_on. However, power_on is
>> cleared at the end of msm_dsi_host_power_off(), after clocks have
>> already been disabled. This creates a window where a concurrent DCS
>> command (e.g. a brightness update from the backlight driver) can pass
>> the power_on check, call xfer_prepare()/xfer_restore(), and toggle
>> link clocks that are already being torn down, leaving
>> disp_cc_mdss_byte0_clk stuck in the 'on' state.
>>
>> Checking enabled instead of power_on closes the race by rejecting
>> transfers as soon as the bridge starts tearing down, before any clocks
>> are touched.
> 
> Thanks, but it is not correct. The transfer callback is documented as
> requiring to power up the host if it is not on at the time it is
> called. Could you please implement corresponding logic?
> 
>>
>>
>> Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index 4d75529c0e85..f66f138cfba0 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -1652,7 +1652,7 @@ static ssize_t dsi_host_transfer(struct mipi_dsi_host *host,
>>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>>   	int ret;
>>   
>> -	if (!msg || !msm_host->power_on)
>> +	if (!msg || !msm_host->enabled)
>>   		return -EINVAL;
>>   
>>   	mutex_lock(&msm_host->cmd_mutex);
>> -- 
>> 2.53.0
>>
> 
After being able to boot linux 7.0.0 rc4, I can confirm that this issue 
is already fixed.

Regards,

-- 
Cédric Bellegarde
