Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CFCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CBC11A703;
	Fri,  5 Jun 2026 10:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QLjjj51j";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BF15811A702
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:30:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FEF04CF1;
 Fri,  5 Jun 2026 03:30:01 -0700 (PDT)
Received: from [10.1.31.21] (e122027.cambridge.arm.com [10.1.31.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755413F632;
 Fri,  5 Jun 2026 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780655406; bh=IcilndRyAKqQCF1QSaXNfFd0st+oLZ4AaMEsfiCIfXQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QLjjj51jj69xdI11Crft2GjNOZml3pL9OIpqJvPng2pre5pfIp9V3yfJuPoCuayLs
 vv6L5AgIEcD1H9n+bEEgjZThJ0o62H2AY9IHuDF+EpaVvPPu2mrstbCVCM2Y+DCzcR
 KVr/mdjIZiwSLvzfXZT0treTCDDqu+XKu0Sm8Ghs=
Message-ID: <19d76abb-baff-4249-9f17-d0460b418d56@arm.com>
Date: Fri, 5 Jun 2026 11:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/panfrost: Prevent division by 0
To: Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
 <20260604200215.303dbc43@fedora-2.home>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260604200215.303dbc43@fedora-2.home>
Content-Type: text/plain; charset=UTF-8
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

On 04/06/2026 19:02, Boris Brezillon wrote:
> On Thu, 04 Jun 2026 18:35:21 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
>> When updating and debug-printing devfreq stats, in the very unlikely
>> offchance that total device time is less than 100 ns, clamp it to 0 to
>> avoid division by 0.
>>
>> Reported-by: Claude <noreply@anthropic.com>
>> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>> ---
>>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> index b51c30778811..e34de47bf43b 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> @@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
>>  
>>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>>  		status->busy_time, status->total_time,
>> -		status->busy_time / (status->total_time / 100),
>> +		status->total_time >= 100 ?
>> +			status->busy_time / (status->total_time / 100) : 0,
> 
> or:
> 
> 		status->busy_time * 100 / MAX(status->total_time, 1),
> 

I have to admit I prefer Boris' version ;)

But either way:

Reviewed-by: Steven Price <steven.price@arm.com>

>>  		status->current_frequency / 1000 / 1000);
>>  
>>  	return 0;
>>
> 

