Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91428CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C1510E844;
	Mon, 18 May 2026 13:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I/fT5pjc";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF6610E7F8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779110014;
 bh=dqM1ut20Hl7qXhva/NQlyMYZp9gJ/pkhsUNC7ES1+h0=;
 b=I/fT5pjcDrI9ZK1x0Jl3DZD6n6JhF6V/P/tg7v0C3zLrvr22E+BZwBpQreD6Z8gthByC+8dGy
 Gsgbq0p/aaKpjiJmhQ3x6p+JkxiFFt9Yf6QPcIF7gZu0lTAoRwV/7DHo1ENP90PlLaleVrAyjZ9
 vszI8elnPWupZ/Dk6PooYuqBlXT0kSx82Rmbki5PhJe+9J4sfFBRsGl5Nls5vPYmMzac4lIazKr
 CVoHPKZukGHy+uz4oreKpkOZEEuXwrieGO1EPIP/R55LRgwlVwyhNhBN+sU5ksl20ZLy9P/ddrY
 cyGIewjNXew2GXf91QZp4PLgUzC0WKTiQD57fiWVkvxQ==
X-Forward-Email-ID: 6a0b106a6279d260fcf358ec
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9aa4bd35-bff6-4009-a959-ce31010c7b35@kwiboo.se>
Date: Mon, 18 May 2026 15:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/bridge: display-connector: trigger initial HPD
 event for DP
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
 <20260513-dp-connector-hpd-v2-2-42f757bfcbf9@oss.qualcomm.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260513-dp-connector-hpd-v2-2-42f757bfcbf9@oss.qualcomm.com>
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

On 5/13/2026 8:19 PM, Dmitry Baryshkov wrote:
> If the DisplayPort drivers use display-connector for the HPD detection,
> the internal HPD state machine might be not active and thus the hardware
> might be not able to handle cable detection correctly. Instead it will
> depend on the externall HPD notifications to set the cable state,
> bypassing the internal HPD state machine (for example this is the case
> for the msm DP driver).
> 
> However if the cable has been plugged before the HPD IRQ has been
> enabled, there will be no HPD event coming. The drivers might fail
> detection in such a case. Trigger the HPD notification after enabling
> the HPD IRQ, propagating the cable insertion state.
> 
> Note, thia issue only affects drivers which set OP_HPD but not OP_DETECT
> (like dp-connector). Here DP differs from HDMI. For HDMI there is no
> additional state or extra "bridge with no sinks plugged" cases. The HPD
> pin state is equalc to the display plugged state. Nor do we have a an
> AUX bus with timeouts, etc.
> 
> Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
> Reported-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index 6bb1134f75c3..f7a5bfd9c075 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -25,6 +26,8 @@ struct display_connector {
>  
>  	struct regulator	*supply;
>  	struct gpio_desc	*ddc_en;
> +
> +	struct work_struct	hpd_work;
>  };
>  
>  static inline struct display_connector *
> @@ -92,15 +95,29 @@ static void display_connector_hpd_enable(struct drm_bridge *bridge)
>  	struct display_connector *conn = to_display_connector(bridge);
>  
>  	enable_irq(conn->hpd_irq);
> +
> +	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
> +		schedule_work(&conn->hpd_work);
>  }
>  
>  static void display_connector_hpd_disable(struct drm_bridge *bridge)
>  {
>  	struct display_connector *conn = to_display_connector(bridge);
>  
> +	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
> +		cancel_work_sync(&conn->hpd_work);

Could use of the sync() variant cause a deadlock here?

Both drm_bridge_hpd_disable() that calls into this func and the
drm_bridge_hpd_notify() called from the hpd_work both hold the
bridge->hpd_mutex.

Sashiko pointed out a similar deadlock question when I tried to do
something very similar to this for the dw-hdmi bridge, and I think
it theoretically could happen?

- hpd_work is scheduled
- drm_bridge_hpd_disable() calls hpd_enable() under lock
  - hpd_work starts and calls drm_bridge_hpd_notify()
    - drm_bridge_hpd_notify() waits on lock to be released
  - hpd_enable() calls cancel_work_sync() and waits
    - deadlock

Ahh, looks like Sashiko found same for your patch as it did for mine :-)

https://sashiko.dev/#/patchset/20260513-dp-connector-hpd-v2-0-42f757bfcbf9%40oss.qualcomm.com

Regards,
Jonas

> +
>  	disable_irq(conn->hpd_irq);
>  }
>  
> +static void display_connector_hpd_work(struct work_struct *work)
> +{
> +	struct display_connector *conn = container_of(work, struct display_connector, hpd_work);
> +	struct drm_bridge *bridge = &conn->bridge;
> +
> +	drm_bridge_hpd_notify(bridge, display_connector_detect(bridge));
> +}
> +
>  static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
>  							  struct drm_connector *connector)
>  {
> @@ -395,6 +412,8 @@ static int display_connector_probe(struct platform_device *pdev)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_DETECT;
>  	if (conn->hpd_irq >= 0)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_HPD;
> +	if (conn->hpd_irq >= 0 && type == DRM_MODE_CONNECTOR_DisplayPort)
> +		INIT_WORK(&conn->hpd_work, display_connector_hpd_work);
>  
>  	dev_dbg(&pdev->dev,
>  		"Found %s display connector '%s' %s DDC bus and %s HPD GPIO (ops 0x%x)\n",
> 

