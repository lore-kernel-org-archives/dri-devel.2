Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955FA1061B21
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A125F10E84F;
	Tue, 31 Mar 2026 03:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="ZSzIpFVo";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.74.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1468A10E1CF
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1774926993;
 bh=po6cgYQUd6uza9we04cCL9P4GtuOUVSmelm9ecj8dPk=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=ZSzIpFVo8hCJIqbhCSr28w/6i3p6jKzyf7Wq1mlNofx6JnEC3G3mX+flKWc3XYOfg
 N83SUmJQ+KY+Gc4i7Dvt9z1FaTFnBLjh0GXF9+BaYmWmBDPBFUhtrVFmxxtMJAdZxQ
 +i3xbV5vHkiQHch//N+/P8FlpiFMaWHjSmsVBRSk=
X-QQ-mid: esmtpsz19t1774926991t0fd6fece
X-QQ-Originating-IP: B/7X6/YjpZwXkACn5sUy6oA7OR2oOjx+LTF2eQ6PFnI=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 31 Mar 2026 11:16:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3341022901969366898
Message-ID: <1801CF6805B8DD32+0afb49ab-a03c-40f0-92bd-d0b332f8f28e@airkyi.com>
Date: Tue, 31 Mar 2026 11:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
 <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
 <acphlgK6ZmBitGJL@venus>
 <AFAEA46A791878B0+9fe68e46-8d8f-44f1-80e3-dfad2de51832@airkyi.com>
 <acsoT_i-LfoMoIy_@venus>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <acsoT_i-LfoMoIy_@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MX+1SEN3H+wAprBSZyZpYvedrMS6yPzCfm5hndPD+3dzYT5XYLnSa84T
 JI5/ask68pqN1TfcA5VzCkqX/w3gxWk9mms37P08J4aeux9HO04NK06PBSuXvka64HUSx0F
 1+DbAUaEQWMNFDwbeo4ZDa/ug7EAo1fWSFnlpS0BbQ8iRUD7NQA3MiwiRruLlD/9eRnpiLu
 q5MmKxG8Z6hsn07gUa99XFdgtBknAH9CoQpyLO8NxmknEAwqYzAznBhP3DWw41mjpq1XX0D
 osMPBQ9VBaWmlNEL7u0lSYIMS22MWHHAOx9P5gRGytcRQWljwalW5FdvuGLkPE41X6V6aZc
 At10WBbJzwN3DsBZlxMSJ0ATpZKsqAfmCx3WSiLzIIOfMuNQ56QpoPPOY0gmjorkUKm4fV4
 16FLUFpNQNlSm5DoUW8vfh4X41e3RZRmHxhTD9hC7gV3eeCh8fgbIOdnSZ3DoCqiCk6F5uF
 bTrxuT8mrcwHWxYUqu17mUQ95bnNyat2NVK1ayyRmK8HXTLrODBfrBKkZjVNPa+Qa4kuTPQ
 8Lc7PqnaN9vp8j89WLDly4LX5kXizeBQUexxBwEQwPwB89NgSXrG+B2vF0uPs+GSF1gfsj3
 DnT4BzSPrggUzCxxEW4ZSAAhnC9rySzHUH/UPC43EwLynLG5EtKy18xU8csEOxlerh8q7MY
 tMTnnUbfdNMkVhE2wmZ0mTjRKkCLrRDzYmjZ35fUVQ+B3U6AEaShTUMfwiOBi2Fdvp6aUq3
 U01zMNhvIHnLIw7h5WpjgU+2mxUmEWkbKCIsw6ym+A136cf+8ECeO1sRE6LPvda46HPzKHU
 tNozP9S7LgMHWldWSROGFD97A3WJtes6jiqSkzwlcMZgCCV2OUjnoRpfJYHjO4zvzAbjddB
 iaFOyWi4GlNCe8A7ffRz78BUpRvC/5PloAap47uDRs1bTsDFgoVCrupnnCWXhEiGLJaVpjU
 t8eCpKaRKTezgtXi9wiSyIGazgG64OKxeCVQmQS/mzjIUePZqj5Sey2t2LzMccUcmIZtDom
 mSfOQerVQGAcuJ2gvu
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

Hello Sebastian,

On 3/31/2026 10:09 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Mar 31, 2026 at 09:18:32AM +0800, Chaoyi Chen wrote:
>> On 3/30/2026 7:50 PM, Sebastian Reichel wrote:
>>> On Mon, Mar 30, 2026 at 09:34:15AM +0800, Chaoyi Chen wrote:
>>>>> There are two parts, which possibly need some discussion:
>>>>>
>>>>>  1. I added a dedicated bridge callback for out-of-band hotplug events,
>>>>>     which is separate from the hotplug_notify. I have a feeling, that
>>>>>     there might be a better solution, but haven't found it.
>>>>
>>>> Could you explain what an out-of-band hotplug event is?
>>>>
>>>> Can't the drivers/usb/typec/altmodes/displayport.c respond to these
>>>> hot-plug events? Thank you.
>>>
>>> That is what generates the out-of-band hotplug event in the first
>>> place via drm_connector_oob_hotplug_event(). The oob in that call
>>> means out of band.
>>>
>>> If you look at that function it calls oob_hotplug_event() callback
>>> on the DRM connector, which is then implemented by
>>> drm_bridge_connector_oob_hotplug_event(). This function calls uses
>>> the normal hpd handling (shared by in-band and out-of-band) and I'm
>>> patching it, so that the bridges are aware of hpd explicitly being
>>> provided out-of-band.
>>>
>>
>> Ah, I'm actually more concerned with the specific types of events.
>> For example, the "explicitly" provided HPD you mentioned here. 
>> Isn't drm_connector_oob_hotplug_event able to provide those?
>>
>> I assume you’re looking for an oob event that is propagated along the
>> bridge chain, rather than at the connector. Is that so? Thank you.
> 
> The connector has a dedicated hotplug oob event callback, but I obviously
> need the event on the bridge, since the DP controller is implemented as
> bridge. The existing infrastructure propages it down to the bridge chain
> via drm_bridge_hpd_notify(), which can be received by the DP controller
> via the .hpd_notify callback in struct drm_bridge_funcs.
> 
> The problem is, that this receives events for in-band AND
> out-of-band hotplug events. That's why I added a new bridge
> callback, which hooks into the existing framework, but only delivers
> out-of-band events and no in-band events.
> 

How to distinguish between in-band and out-of-band events? In your patch4:

@@ -180,6 +180,12 @@ static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connect
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
+	/* Notify all bridges in the pipeline of hotplug events. */
+	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
+		if (bridge->funcs->oob_notify)
+			bridge->funcs->oob_notify(bridge, connector, status);
+	}
+
 	drm_bridge_connector_handle_hpd(bridge_connector, status);


Here, drm_bridge_connector_handle_hpd() will eventually call:

	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
		if (bridge->funcs->hpd_notify)
			bridge->funcs->hpd_notify(bridge, connector, status);
	}

Therefore, for the bridge chain, you will call hpd_notify and
oob_notify separately.

This looks redundant, how do you distinguish between them?

> The problem with receiving in-band in addition to out-of-band is
> that the out-of-band signal should set the hotplug pin accordingly,
> but the in-band detection also checks the actual DP link. If the OOB
> hotplug signal says "nothing plugged", the hotplug pin should be
> forced off, but if the DP link detection fails, the hotplug pin
> should not be force disabled, as that makes any further detection
> tries useless.
> 

-- 
Best, 
Chaoyi

