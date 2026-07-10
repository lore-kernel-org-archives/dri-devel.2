Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475AAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE1510E191;
	Fri, 10 Jul 2026 10:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RL1kQSP7";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42D810E191
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783678187;
 bh=FDg1r4G8mrvviKfhBFq/arYf1DlfLAJ4FBPR1ruq5Wo=;
 b=RL1kQSP77/ecKQaspiShEYAYxs9U9hnE/O59wQEMgMD6hEyG+ReGL2F/wdkgGX8SjQnW5fRIr
 ceTE1Yx9R/Tru9OWR1muD3/yb9CkHhtYZH5HAzgqbiAF7lk7GfzJyhe3T/I8W8h3/j4Kej9nQAf
 A+b10nq6HmS3LS7mpwm2vYdOyraRDVgLCpt61b8FtXox3bL66PH5/h+Qwddv+bRsg+RH++gI9wm
 nSxBOK+N7xiUd5iJEaNfar79OxaYQi7CK4go+9UZKEObDrliIm9VkuOBR4HczpCJh4tho607aGv
 ezIO0jyMQvmEhV5Lxek0icrPYZ2xqER4IDoecgpaSkkA==
X-Forward-Email-ID: 6a50c4e899bdaaa2453e9f64
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e739edf6-8531-4e30-83a7-c941acba1ee2@kwiboo.se>
Date: Fri, 10 Jul 2026 12:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/rockchip: dw_hdmi: Propagate bus format to
 display driver
To: Dan Carpenter <error27@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <alDDok08ZB6hBQ4n@stanley.mountain>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <alDDok08ZB6hBQ4n@stanley.mountain>
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

Hi Dan,

On 7/10/2026 12:04 PM, Dan Carpenter wrote:
> Hello Jonas Karlman,
> 
> Commit dc70272cc184 ("drm/rockchip: dw_hdmi: Propagate bus format to
> display driver") from May 18, 2026 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:289 dw_hdmi_rockchip_get_bus_format()
> 	warn: 'bridge_state' is an error pointer or valid
> 
> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
>     278 static u32 dw_hdmi_rockchip_get_bus_format(struct drm_encoder *encoder,
>     279                                            struct drm_connector_state *conn_state)
>     280 {
>     281         struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
>     282         struct drm_bridge_state *bridge_state;
>     283 
>     284         bridge = drm_bridge_chain_get_first_bridge(encoder);
>     285         if (!bridge)
>     286                 return 0;
>     287 
>     288         bridge_state = drm_atomic_get_bridge_state(conn_state->state, bridge);
> --> 289         if (!bridge_state)
> 
> drm_atomic_get_bridge_state() never returns NULL, only error pointers.

This issue has already been addressed in the patch "drm/rockchip:
dw_hdmi: Fix error handling for drm_atomic_get_bridge_state()" at [1].

[1] https://patch.msgid.link/20260701030835.2662123-1-nichen@iscas.ac.cn/

Regards,
Jonas

> 
>     290                 return 0;
>     291 
>     292         if (bridge_state->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)
>     293                 return bridge_state->input_bus_cfg.format;
>     294 
>     295         return bridge_state->output_bus_cfg.format;
>     296 }
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter

