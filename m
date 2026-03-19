Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAECE107527A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D61B10E920;
	Thu, 19 Mar 2026 08:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adishatz.org header.i=@adishatz.org header.b="TuqPN92B";
	dkim-atps=neutral
Received: from adishatz.org (ns314768.ip-37-187-26.eu [37.187.26.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C064610E920;
 Thu, 19 Mar 2026 08:52:03 +0000 (UTC)
Received: from [172.28.27.157] (unknown [193.52.84.14])
 by adishatz.org (Postfix) with ESMTPSA id 39DBD4C01C1;
 Thu, 19 Mar 2026 09:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adishatz.org;
 s=mail; t=1773910321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FY6S8SUmPOFEMlQni6SQQVM3d6TjXiNwyXWrYfbWeW4=;
 b=TuqPN92BC+RfvhumZ0bIJj6YwxG0t9aVN6kO3lgLBwhrPjau1z3AHj+KnhtVhB6cU9mt8c
 R/YaD4/eITMeCEkH5Wm9/xut1qZPPNS1sji2oajZ/5O5QbYZGwh+Qk6bmNjkipMqasHA8b
 7SBEI6EDzlva5ALxsuH2SuOUhL5Qru2bL4yjYfAx9XjwQ/v9EIYKRw+GewWZYcIBL72M5R
 9mzt1Hmgz+FsVj567NnUjy0A+CAKVqudfY2LtzuJ9LJ50Dq2zMUopR/ifvNvbDBH3/l9Hg
 +fczp0hANia1Bhk8l90y6Zuw8tv7hQuPLRTSZI420HBex8aJRKgnyYtgD8XYyg==
Authentication-Results: ORIGINATING; auth=pass smtp.auth=cedric.bellegarde
 smtp.mailfrom=cedric.bellegarde@adishatz.org
Message-ID: <15a76455-d2f4-4ad5-8474-dc29a7ad4099@adishatz.org>
Date: Thu, 19 Mar 2026 09:52:00 +0100
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
> Thanks, but it is not correct. The transfer callback is documented as
> requiring to power up the host if it is not on at the time it is
> called. Could you please implement corresponding logic?
Hi,

Thank you for your review.

Looking at the mipi_dsi_host_ops documentation: "Also note that those 
callbacks can be called no matter the state the host is in. Drivers that 
need the underlying device to be powered to perform these operations 
will first need to make sure it's been properly enabled."

I would argue that this sentence places the responsibility on the caller 
to ensure the host is properly enabled before calling transfer(), not on 
the transfer() implementation itself to power up the hardware.

In our case, powering up the DSI host from within transfer() is not 
trivially achievable. These arguments and steps are owned by 
dsi_mgr_bridge_power_on() and are not available at transfer() time 
without significant architectural changes that would spread power 
management logic outside the manager.

BTW, I'm quite new to kernel dev, my logic may be totally wrong. If that 
is indeed the expected behaviour, would a callback mechanism be 
acceptable, where the manager registers a power_on callback on the host 
at bridge init time, allowing transfer() to trigger the full power 
sequence owned by the manager without duplicating it ?
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
Regards,
-- 
Cédric Bellegarde

