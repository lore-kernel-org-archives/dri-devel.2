Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B5B10775F9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD61210E0A0;
	Wed, 18 Mar 2026 18:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eJ7e38SL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005E610E0A0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773857556;
 bh=0UrZRLkimMDCcD2T3nHPvaaxC017oNtzYkFihTplPZg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eJ7e38SLJwx0CvRCMIqYzBnZpiwRHLdICvBTEYXxTx0u+ZM72avUXVBd/s1M+pK2Z
 BD8tH2jG1UbJ0JqlA4EwnHyT0Mz1bUSqa1iQ0MdI+9St5y58zBZMOgq+8+Z+M3Cjfo
 dGveAdC9BfDQIBXWWaoBTvMABj3KxsFWD6xXGjxhOjS89NT/xJRzsAP8RMZ05a5Ik+
 NIIL3erXZdw0pEo9PLOBxI0Ul1MsRxWA1+K/FfFdqzOsLSstB3e1ip2RrXqwafpP0r
 EKbJEjVOPrbGz1uotCbVCuhLleTufJSah55GnFjxpDNidDjIArYFJr8wZmcMut9jnv
 xxg0Xn6N7c7tQ==
Received: from [192.168.1.90] (unknown [86.123.23.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BDEF717E0ED6;
 Wed, 18 Mar 2026 19:12:35 +0100 (CET)
Message-ID: <0895dfa0-9527-41b1-b991-a2bd6e0c549b@collabora.com>
Date: Wed, 18 Mar 2026 20:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Douglas Anderson <dianders@chromium.org>, Andy Yan
 <andy.yan@rock-chips.com>, Sugar Zhang <sugar.zhang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
 <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
 <00EE3E21-F614-429B-ACB6-19AF64CF74B3@gmail.com>
 <DH58MAETGDMM.2QS6VJDQ7UXIV@bootlin.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <DH58MAETGDMM.2QS6VJDQ7UXIV@bootlin.com>
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

Hi Luca,

On 3/17/26 7:35 PM, Luca Ceresoli wrote:
> Hello Christian, Cristian, Jonas,
> 
> On Tue Mar 17, 2026 at 5:49 PM CET, Christian Hewitt wrote:
>>> On 17 Mar 2026, at 8:16 pm, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>>>
>>> Hello Christian,
>>>
>>> On Sat Feb 28, 2026 at 12:28 PM CET, Christian Hewitt wrote:
>>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>>
>>>> Channel Allocation (PB4) and Level Shift Information (PB5) are
>>>> configured with values from PB1 and PB2 due to the wrong offset
>>>> being used. This results in missing audio channels or incorrect
>>>> speaker placement when playing multi-channel audio.
>>>>
>>>> Use the correct offset to fix multi-channel audio output.
>>>>
>>>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>>>> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>
>>> While applying this patch to drm-mics-fixes, checkpatch complains:
>>>
>>>  -:14: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report
>>>
>>> You can send v3 with the link, or just reply with the link and I'll take
>>> care of adding it to the commit message.
>>
>> Apologies, it looks like use of Reported-by was tightened since I last
>> used it, and there’s no official report anywhere I can link to (it was
>> all done in private channels) so better to just drop it from the v2 patch
>> if that’s possible? - if not I can send a v3 without it.
> 
> Thanks for the quick feedback.
> 
> I applied keeping the commit message as is. In lack of a public discussion
> I guess the 'Reported-by' is somewhat informative anyway. I read the
> checkpatch as a general suggestion, not a hard rule.
> 
> So now this patch is on drm-misc-fixes, but drm-misc-fixes and
> drm-misc-next are now conflicting because of other changes by Cristian
> Ciocaltea applied in the meanwhile to drm-misc-next, and particularly
> commit 3ea699b56d31 ("drm/bridge: dw-hdmi-qp: Rework Audio InfoFrame
> handler").
> 
> Cristian, Christian (heh), Jonas, could you please check whether the code
> on drm-misc-next has or not the bug that is fixed here? And if it still
> has, send a fix based on current drm-misc-next?

The conflicting commit in drm-misc-next (i.e. 3ea699b56d31) implicitly resolves
this audio related issue as well, hence there is no need for any further action.

Regards,
Cristian
