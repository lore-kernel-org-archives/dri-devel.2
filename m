Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA7FF885A
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 00:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752A310E1F5;
	Wed, 29 Apr 2026 00:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SCdNaaGs";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA96B10E1F5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 00:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1777420902;
 bh=VrnMB3tcOj8bZAULg2P4zrD7zgFL+si25Q7plTnnH7Y=;
 b=SCdNaaGsggXUGjHYGB8ubWJV+FoPaRhyx8uV1xZgBTXOP8SbdmO+oVnXNQaTcezl4hkqF8t7D
 cTlQpzAdUXTSAsKayn9/Ltudu5Kp43G04P8fcnz5mFpZA3m5f4T1ZBhdp6AfOE3X5+JWt6EF5AA
 dKxDK1ibIV/1MLNHepVqRP9GTXOUBxqJgp2lNQ34XPYO83mgvs9hoRZZ9QYwcGCrwVSgAA835g5
 ciOI0+NHPTOGRirfioHb3L7Cx/+LtMpiK4iZsUBPzFf43WMlAodIeSpZyI5n8nasmBm6fsAr/K2
 9ngVfqnGsNXn3ajJm8677G6dM5dMNtFXBroOV53146Sw==
X-Forward-Email-ID: 69f1039ca2c58f47e2132447
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c77eb179-37b6-4de8-9fb2-2b095f06d462@kwiboo.se>
Date: Tue, 28 Apr 2026 20:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] drm: bridge: dw_hdmi: Use
 drm_connector_helper_hpd_irq_event()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-11-jonas@kwiboo.se>
 <6n44goy63rcd44r3l3qliqgybd7f7kn7p3ktosrjdtphuid5hj@lkigypdzbn3q>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6n44goy63rcd44r3l3qliqgybd7f7kn7p3ktosrjdtphuid5hj@lkigypdzbn3q>
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

Hi Dmitry,

On 4/28/2026 2:40 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 06:52:56PM +0000, Jonas Karlman wrote:
>> Use drm_connector_helper_hpd_irq_event() or drm_helper_hpd_irq_event()
>> depending on if a dw-hdmi connector or bridge is used.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v3: New patch
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 4d079b689b3b..4a0498922476 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -3054,10 +3054,13 @@ static void dw_hdmi_hpd_work(struct work_struct *work)
>>  {
>>  	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
>>  
>> -	if (hdmi->bridge.dev) {
>> +	if (hdmi->connector.dev)
>> +		drm_connector_helper_hpd_irq_event(&hdmi->connector);
>> +	else if (hdmi->bridge.dev)
>>  		drm_helper_hpd_irq_event(hdmi->bridge.dev);
> 
> Okay, following the comment to the previous patch it should rather
> become:
> 
> 	if (hdmi->bridge.dev)
> 		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
> 	else if (hdmi->connector.dev)
> 		drm_connector_helper_hpd_irq_event(&hdmi->connector);

I will likely just drop this patch in a v4, as current ongoing work to
convert dw-hdmi to use a bridge connector and become a hdmi bridge fully
reverts the change introduced in this patch. See [1] for current
work-in-progress snapshot of such ongoing work.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20260427-rk-hdmi-v2/

Regards,
Jonas

> 
>> +
>> +	if (hdmi->bridge.dev)
>>  		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
>> -	}
>>  }
>>  
>>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>> -- 
>> 2.53.0
>>
> 

