Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81DCD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B4310E23F;
	Fri, 22 May 2026 10:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JaBfUJfN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE1F10E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779447438;
 bh=RaCiD9C9ee+AQyy4fknkK+gihP8GQ7R1bKyeCWj4GDI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JaBfUJfNr5zqyyEI/gZ60k0uCx5ucNwCUpCb+nz04In5Nr63IGybolGcpcf16P+uB
 +FvtjHNPxh/5FZKqhnRpMPt7HeklNlIZdeA2eniYfEQYkyfyc+flXL8vunV+BFRZrs
 GL34YSlf46DWcQF79YZ4aA/dazoqE9dXAoeC+r3b2keMJxHm3/THxSyqC1+TV37aLz
 TU5ZWAxsNihkH2i/H+cmbJnuqJWGVSZZ+Q80GnFvBEehoLGLGcdxp32PVN7sCRj2RY
 mlKXZnNftdV6nYkp1r1rCxbV0thIPb6P/SGkaZg9XCieytEFhOkDQztSU0J2F3NY7F
 7l+qHsLkBBHyA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 621F117E0550;
 Fri, 22 May 2026 12:57:17 +0200 (CEST)
Message-ID: <bfdbf194-b400-4de3-bb68-74652dece74d@collabora.com>
Date: Fri, 22 May 2026 13:57:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/22] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Daniel Stone <daniels@collabora.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
 <20260520-dw-hdmi-qp-scramb-v6-2-24b74603b782@collabora.com>
 <20260521-sweet-devout-panther-44d73c@penduick>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260521-sweet-devout-panther-44d73c@penduick>
Content-Type: text/plain; charset=UTF-8
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

Hi Maxime,

On 5/21/26 10:52 AM, Maxime Ripard wrote:
> Hi,
> 
> Thanks for working on this!

Thanks for your quick review! :-)

> 
> On Wed, May 20, 2026 at 09:38:13PM +0300, Cristian Ciocaltea wrote:
>> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>>
>> - .scrambler_src_{enable|disable}() callbacks in
>>   drm_connector_hdmi_funcs for source-side scrambling control
>> - A delayed work item (scdc_work) with an associated callback (scdc_cb)
>>   for periodic monitoring of sink-side scrambling status
>> - A scrambler_enabled flag to track whether scrambling is currently
>>   active
>>
>> These are intended to be used by SCDC scrambling helpers to coordinate
>> scrambling setup and teardown between the source driver and the DRM
>> core.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_connector.c | 14 +++++++++++
>>  include/drm/drm_connector.h     | 52 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+)
> 
> So we would need kunit tests for this.

Ack.

> 
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index 3fa4d2082cd7..91e58362fbc0 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -220,6 +220,19 @@ void drm_connector_free_work_fn(struct work_struct *work)
>>  	}
>>  }

[...]

>> +	/**
>> +	 * @scdc_work: Work item currently used to monitor sink-side scrambling
>> +	 * status and retry setup if the sink resets it.
>> +	 */
>> +	struct delayed_work scdc_work;
>> +
>> +	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
>> +	 *
>> +	 * Currently used to monitor sink-side scrambling status and retry
>> +	 * setup if the sink resets it.
>> +	 *
>> +	 * This is assigned by the framework when making use of
>> +	 * drm_scdc_start_scrambling() helper.
>> +	 */
>> +	void (*scdc_cb)(struct drm_connector *connector);
>> +
> 
> I'm really not sure what the monitor thing is about. If we have setup
> the scrambler at enable time, and we set it again on hotplugging, why
> would we need to monitor anything?

This is similar to 257d36d493e9 ("drm/vc4: hdmi: Add a workqueue to set
scrambling") in order to deal with some displays needing a retry on scrambling
setup.

> Also, scrambling is only relevant for HDMI 2.0. We need a way to expose
> that somehow and make sure that HDMI 2.0 drivers actually have
> scrambling setup.

I assumed drivers that do not reject the HDMI 2.0 rates in their
.tmds_char_rate_valid() are implicitly expected to support scrambling. 
Thinking again we could extend the framework to provide some additional checks,
but let's discuss the topic on the SCDC patch.

Regards,
Cristian
