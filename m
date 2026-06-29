Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788CE10E059;
	Mon, 29 Jun 2026 09:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KeP9lnKD";
	dkim-atps=neutral
Received: from mail-m2453.xmail.ntesmail.com (mail-m2453.xmail.ntesmail.com
 [45.195.24.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4A810E059
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:09:29 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 442780943;
 Mon, 29 Jun 2026 17:09:24 +0800 (GMT+08:00)
Message-ID: <b2633b22-da30-4778-8e23-7b5bed9ead07@rock-chips.com>
Date: Mon, 29 Jun 2026 17:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: Xu Yang <xu.yang_2@oss.nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Chaoyi Chen <kernel@airkyi.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
 <erx73m2ueuvbzjteadjli6aki5by4pr3hyertkkqqoqwhaa4v3@5cstmshcercx>
 <56c6abb8-c127-449f-9368-12f94620c2bc@rock-chips.com>
 <k53t2soc3nxhwugncatksektig6agxfgdkogkdwbhrhu2fn2g7@auvsfrv76wxy>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <k53t2soc3nxhwugncatksektig6agxfgdkogkdwbhrhu2fn2g7@auvsfrv76wxy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f12a3faa703a7kunmb5a121f9254176
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUhIVkwfQ0hMHkxCHUNLHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=KeP9lnKD//VlvvlxIiRxEa09oTrs/v+c7Ck0y9CJ7kebPxL1eAQ4LuYjyaIGw/OYsBbKdtssXKahpSlLQkKujxKOUvxCbJxwSZlr8H/ZYK2KhzjMnwcoDd1Sn9tYhC8NZeSIdOHyY2fC9yOG+KjawDDY3dqQlsRMu7fzSYuGBdk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=oOV+Bwk6KYyidJt86LeBdzQS5L6KRlfhXQ6hucCploM=;
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

Hello Xu Yang, Heikki

On 6/29/2026 4:26 PM, Xu Yang wrote:
> On Mon, Jun 29, 2026 at 09:29:08AM +0800, Chaoyi Chen wrote:
>> Hello Xu Yang,
>>
>> On 6/26/2026 7:15 PM, Xu Yang wrote:
>>> On Wed, Mar 04, 2026 at 05:41:44PM +0800, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> The HPD function of Type-C DP is implemented through
>>>> drm_connector_oob_hotplug_event(). For embedded DP, it is required
>>>> that the DRM connector fwnode corresponds to the Type-C port fwnode.
>>>>
>>>> To describe the relationship between the DP controller and the Type-C
>>>> port device, we usually using drm_bridge to build a bridge chain.
>>>>
>>>> Now several USB-C controller drivers have already implemented the DP
>>>> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
>>>> HPD bridge on USB-C connector port device.
>>>>
>>>> But this requires the USB-C controller driver to manually register the
>>>> HPD bridge. If the driver does not implement this feature, the bridge
>>>> will not be create.
>>>>
>>>> So this patch implements a generic DP HPD bridge based on
>>>> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
>>>> Type-C port device containing the DP svid is registered, it will
>>>> create an HPD bridge for it without the need for the USB-C controller
>>>> driver to implement it.
>>>>
>>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>> ---
>>>>
>>>> (no changes since v14)
>>>>
>>>> Changes in v13:
>>>> - Only register drm dp hpd bridge for typec port altmode device.
>>>>
>>>> (no changes since v12)
>>>>
>>>> Changes in v11:
>>>> - Switch to using typec bus notifiers.
>>>>
>>>> (no changes since v10)
>>>>
>>>> Changes in v9:
>>>> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
>>>> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
>>>> - Add more commit comment about problem background.
>>>>
>>>> Changes in v8:
>>>> - Merge generic DP HPD bridge into one module.
>>>> ---
>>>>
>>>>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>>>>  drivers/gpu/drm/bridge/Makefile               |  1 +
>>>>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
>>>>  3 files changed, 60 insertions(+)
>>>>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>>> index a250afd8d662..559487aa09a9 100644
>>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>>> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
>>>>  	  Simple bridge that terminates the bridge chain and provides HPD
>>>>  	  support.
>>>>  
>>>> +if DRM_AUX_HPD_BRIDGE
>>>> +config DRM_AUX_HPD_TYPEC_BRIDGE
>>>> +	tristate
>>>> +	depends on TYPEC || !TYPEC
>>>> +	default TYPEC
>>>> +	help
>>>> +	  Simple bridge that terminates the bridge chain and provides HPD
>>>> +	  support. It build bridge on each USB-C connector device node.
>>>> +endif
>>>> +
>>>
>>> Should CONFIG_TYPEC_DP_ALTMODE select this one? Otherwise, we need to do it
>>> manually.
>>>
>>> $ grep -nr --include=Kconfig "select DRM_AUX_HPD_BRIDGE" .
>>> ./drivers/soc/qcom/Kconfig:118: select DRM_AUX_HPD_BRIDGE
>>> ./drivers/usb/typec/ucsi/Kconfig:88:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>>> ./drivers/usb/typec/ucsi/Kconfig:99:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>>> ./drivers/usb/typec/tcpm/Kconfig:62:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>>> ./drivers/usb/typec/tcpm/Kconfig:85:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>>>
>>
>> That's a fair point. But based on the previous discussion, Heikki
>> point out that configurations in the TYPEC subsystem should not
>> select configurations from DRM.
> 
> I have just reviewed your previous patchsets but I did't find such opinion from
> Heikki. Otherwise, why are tcpm.c/ucsi.c already allowed to add the above select
> condition in their configs?
> 
> I think Heikki means that the DRM_AUX_HPD_BRIDGE shouldn't been selected at the
> top level of Type-C subsystem. Because not all Type-C devices support the DP function.
> 
> As a generic Type-C DP HPD bridge, displayport.c will likely need to use it in
> the future. Therefore, allowing displayport.c to select DRM_AUX_HPD_BRIDGE makes sense.
> 
> According to my testing, it's impossible to build this driver in unless TYPEC_FUSB302
> or a relevant CONFIG is built in to select DRM_AUX_HPD_BRIDGE, or the defconfig is modified.
> 

Yep. For me, I select DRM_AUX_HPD_BRIDGE in DRM.

@Heikki, what do you think of the following change?
Should we add a new patch for this? Thanks.


diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
index 7867fa7c405d..f89cdf3c949b 100644
--- a/drivers/usb/typec/altmodes/Kconfig
+++ b/drivers/usb/typec/altmodes/Kconfig
@@ -5,6 +5,7 @@ menu "USB Type-C Alternate Mode drivers"
 config TYPEC_DP_ALTMODE
        tristate "DisplayPort Alternate Mode driver"
        depends on DRM
+       select DRM_AUX_HPD_BRIDGE 
        help
          DisplayPort USB Type-C Alternate Mode allows DisplayPort
          displays and adapters to be attached to the USB Type-C

-- 
Best, 
Chaoyi
