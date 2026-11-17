Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D9606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQAoK8Fp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFEB10EB67;
	Tue, 17 Nov 2026 08:07:25 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F4710E0C2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 03:41:40 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-930c0f9c1b1so506595185a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794886899; x=1795491699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k7CFaIYn1dfrHupuH6Y5CyqJe0ZNCdr90nwRUvOqNf4=;
 b=sQAoK8FpPNGkSnEnFGz/Y8tGjYSIq2iSOLO2RH/b4S8O7BIja4awfZFnP10n3fTbmj
 LCTMLkV85643xFd2c365L6Ol1hUja4DJGs3Vn/LPNMvni8d+x9NNoMxm/VjA/2G8osLu
 DRmw/A7vqHmehlXRkwRgikU0WtO3lIZBF1zpUarANcGBudpXEW8iObXwVS590FNHVNTG
 nh++vi54DbpQuAlshGqKs7yPYpypVkK/hR3PLZJ5QuGdq8DohJ3Pz9v6OtJzsRe9OFgM
 t8VGOv9UzWCXMyU0Gi8LmAGWApYGJFluSmQnODs0Ncf8uDW8re8RqmxBuV0+eJ51DHzA
 JXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794886899; x=1795491699;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k7CFaIYn1dfrHupuH6Y5CyqJe0ZNCdr90nwRUvOqNf4=;
 b=L+ysQ/bPcukp35Vy2/m+pLa4mueLn0geJmDqmpo25CMeNNH5jrAssaWccF1R9VfsZJ
 cCB/XgQIlqrJvOpT+MXBs4RZQ36+i/4uWD7+DlwxjoSC0f6qdbaycCNlgukg8Z/hZOEO
 TAGGlBjJcxfkglInMzXmIvk0C6LAub5KALWuYARrftU1gvzru3u8/8r9po5H43VGH0ZE
 Ac1nADnd/qtcJt6Hq32yv2LkGcC9iIw5r0hmzIeAjM/eNcPQK8wbXIk+5x0lAjFlcfD3
 oNKqVXl177ZqD/4KuYBzVsza6Xw9ZgA6iOeCfvC8OuoFgOcY652wMVEprzdpKffwq+eN
 vJKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHYTQyCvBtuw9WxozdKVP/vkym4gxcGCOWzyXXaeHqlmF1U3IzSdbKI7xa1bDG2plUc2uOlZxOUeY4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Jv7Z82qqUcoy0lhcUipkHqmtr+nZT2Eai3wYPtrSwJSB2uSHQ
 b8IXen1OBqLpDkL/A9rAHW/wOcHD8GcnKOVMLtY1cHce6YmUh0qY1Czk
X-Gm-Gg: AYBFou1CXE2JsYmsYowJo+mwl2W0j2dArkb5NOz2gXowJT7r3TY8+ynFAf8uConiYyR
 Ng/1i+uO/3v0gjzFvh790Jf5ljjOzs00oZu3L9KNH7T0yujV+UKQ4HM/cQhjbIIXk7a3/P878gv
 9DH2aR1+mEmEBsnMmOZRxjn8szR/zVPDfPoOYXtlHWJXHWN2MiSpS9T1sV8rtwSw4Qk8ITDal3s
 1hp6iQWmQJr/voGnLpD7u6aZkcmiSmYO694mgZHYg7ZMY4JE5jVWJuK1CisjlRXawFiYKOGfzxM
 vUENthaSV5AfaGSdaQZbsa4a0axehB0et3yx2oo2sBBRriS+b6NEHL4bk+Y1baWTghelAtS0ZT7
 zuYaDgES1Uar1LOw0DA8bYybjnSsoKd8Bo1s8C88AUnfTy5ajN0omsSnv5HZP3KvEoaIcnn3jqd
 YcUXfTm9ivhDV5vkUDDCcPsjZG2etbp7NYvlLUETEWRpOQq0xjFFnH3miwfyaOj5MuSnaMK5kxP
 dtk3o4NmN64bkWFPzAFLuDLuP/rv7zrOd6ggGpj2YNDMwIWNlOuOJI+5l6YBuc2z7CdorRwJ9tG
 qnxhxQqcSmuqzr5I+DUNEk6q17a/Azl03386nnINQVzBxQVZ7YlVF4Mv45XPd5DEmK5IzR6IWHZ
 IiSDWXgwNjB2ZsjzWW3VuiwxKE4wNxs7NnCGy+mx/k4MWZPgNtvPg
X-Received: by 2002:a05:620a:880e:b0:93f:6375:aaa0 with SMTP id
 af79cd13be357-9494bccfa89mr1896919885a.80.1794886899150; 
 Mon, 16 Nov 2026 19:41:39 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c86c946sm1003870985a.25.2026.11.16.19.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 19:41:38 -0800 (PST)
Message-ID: <5e8d0a68-5c88-4a31-9c9c-47966093a273@gmail.com>
Date: Mon, 16 Nov 2026 22:41:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panel-edp: disable the backlight at probe
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Doug Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>,
 Linus Walleij <linusw@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dale Whinham <daleyo@gmail.com>, linux-arm-msm@vger.kernel.org,
 aarch64-laptops@lists.linaro.org
References: <20261026-sp11-bl-upstream-1-v2-1-efc84396adf1@gmail.com>
 <CAD=FV=U2sZaobJMHCimqB5Kw0fZ_-7=9tHAxT-KrSP8uQiY-vw@mail.gmail.com>
 <49e9a6d2-8665-4e78-ac17-da5a55abf065@linaro.org>
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <49e9a6d2-8665-4e78-ac17-da5a55abf065@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:19 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Neil,

On 11/2/26 8:15 AM, Neil Armstrong wrote:
> On 10/30/26 02:40, Doug Anderson wrote:
>> Hi,
>>
>> On Mon, Oct 26, 2026 at 6:14 PM Haipeng Lin via B4 Relay
>> <devnull+jimmie.lin.gmail.com@kernel.org> wrote:
>>>
>>> From: Haipeng Lin <jimmie.lin@gmail.com>
>>>
>>> pwm-backlight can preserve the enabled state left by firmware to
>>> support a seamless display handoff. However, panel-edp does not support
>>> such a handoff. When probing a generic eDP panel, it powers the panel
>>> on to read its EDID. If display pipeline binding takes longer than the
>>> runtime-PM autosuspend delay, the panel is then powered off while the
>>> backlight remains enabled.
> 
> So we don't support handoff _now_ but we may certainly support it someday.
[...]> 
> I lack some knowledge, but when the display pipeline is probed
> who's in charge of disabling the backlight when suspending ?

My understanding of the lifecycle is that once the display pipeline is
bound, and the first modeset is done, the DRM panel core via the panel
bridge is in charge of the backlight:

Enable:
panel_bridge_atomic_pre_enable() -> drm_panel_prepare() ->
 pm_runtime_get_sync() (panel power on)
panel_bridge_atomic_enable()     -> drm_panel_enable()  ->
 backlight_enable()

Disable/suspend:
panel_bridge_atomic_disable()    -> drm_panel_disable() ->
 backlight_disable()
panel_bridge_atomic_post_disable() -> drm_panel_unprepare() ->
 pm_runtime_put_sync_suspend() (.. power off)

So normally (e.g., DPMS off) drm_panel_disable() always disables the
backlight before drm_panel_unprepare() cuts the panel power.

The gap happens at boot before the first modeset:
1. pwm-backlight probes and preserves the enabled state from firmware
   (BL_EN high) while drm_panel starts with panel->{enabled,prepared} =
   false.
2. generic_edp_panel_probe() calls pm_runtime_get_sync() and
   pm_runtime_put_autosuspend() directly to read the EDID outside of
   drm_panel_prepare/unprepare()
3. If the display pipeline takes >1s to bind, runtime PM autosuspends
   the panel (which calls panel_edp_suspend() and cuts panel VDD)
   but drm_panel_disable() never runs because the panel was never
   enabled via DRM.
The backlight is then left on with the panel power off, which breaks
power sequencing on any panel but on the Surface Pro 11 LCD it leaves
the backlight controller stuck. At first modeset BL_EN is never toggled
because pwm-backlight thinks it is already enabled.

> 
> Why don't we handle the backlight state in the PM ops ?
> 
> Neil

Since panel-edp's runtime PM ops tracks prepare/unprepare state 
(panel power) rather than enable/disable (backlight), by disabling the
backlight at panel_edp_probe() we sync the initial backlight state with
panel->enabled = false until panel-edp supports seamless handoff.

As Doug mentioned, v1 did backlight_disable in panel_edp_suspend() but
Doug suggested that disabling it at probe could be a one-time work-
around to handle the bootloader handoff.

I hope this addresses your concern, happy to try other approaches.

Thanks,
Haipeng


