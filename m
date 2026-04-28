Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EEEFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0C010E37A;
	Tue, 28 Apr 2026 18:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OvzWw6Yp";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4452C10EC75
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1777402411;
 bh=k9lpDu/EBPmysPoLDlLSYJQEimiqBesJ10bN4Ceg2ak=;
 b=OvzWw6Ypiv4Y0PB8E024Py0WwLs04tJivyfEmoMrxGCyjGDfquRBEiwO5weUJaN6MhB90OsUB
 U3V8L3j8EL78TjXJE25qwHMWqe49AYzh9qD2wKBnQTJLJSqSZfz51QZ6lRLrkE5ZvPOWo7h3fA+
 jgjOdwAhC9FKQn3bFurtA1dB4HdwK1n59nMPfoRG8HEK1PSwZla1mOeQ2AjZXyXqTC+R3XFp4dg
 9Ya0pGuWopPRIX3IURy8lsyeFh4KjOKfbGDKDZVs7doINUUHH8MjTqGwfz8YfQGA6IpHxvCgZPR
 Gjp//4OZxUE9P+t6ESLidNaG+LNgJpfAYVGbJz7Z2jhw==
X-Forward-Email-ID: 69f1021fc8c0cea2868e9b35
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.7.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d9d55427-2f56-4e3b-a476-f3981c9c20a2@kwiboo.se>
Date: Tue, 28 Apr 2026 20:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] drm: bridge: dw_hdmi: Use
 dw_hdmi_connector_status_update()
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
 <20260403185303.80748-13-jonas@kwiboo.se>
 <nsgxyv5sflscs66kxcgbyapivu3yjskfqzeqkt4yhnjfomyfav@rkxft2e6lqbd>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <nsgxyv5sflscs66kxcgbyapivu3yjskfqzeqkt4yhnjfomyfav@rkxft2e6lqbd>
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

On 4/28/2026 2:42 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 06:52:58PM +0000, Jonas Karlman wrote:
>> Update connector EDID and CEC phys addr from detect and force funcs to
>> ensure that userspace always have access to latest read EDID after a
>> sink use a HPD low voltage pulse to indicate that EDID has changed.
>>
>> With EDID being updated in detect and force funcs, there should no
>> longer be a need to re-read EDID in get_modes funcs, so drop it.
>>
>> This change make the dw-hdmi connector work more closely like the bridge
>> connector does with a hdmi bridge.
> 
> Please consider using drm_atomic_helper_connector_hdmi_update()
> directly.

It is unfortunately not possible to use that helper unless
connector->hdmi.funcs has been assigned a value, currently something
that is only done in drmm_connector_hdmi_init().

As briefly mentioned in the cover letter, I am working on converting
dw-hdmi to be a hdmi bridge, so this function will be replaced/removed
in a future series.

See [1] for a work-in-progres snapshot where dw-hdmi use the bridge
connector and has been converted to a hdmi bridge. This works great on
Rockchip RK3328, RK3399 and RK3568. More testing and cleanup is needed
before something beyond the initial HPD, CEC and EDID rework/cleanup
currently handled in this series is ready for posing to ML.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20260427-rk-hdmi-v2/

Regards,
Jonas

> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v3: Reworked 'Update EDID during hotplug processing' patch
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
> 

