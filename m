Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91910CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AA3113729;
	Mon,  1 Jun 2026 18:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WXJjJ/v9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3615B113729
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780338737;
 bh=hpq52y1SFKvP7WMQOqSolNHHdSm1wNX+AFlAGowAD0E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WXJjJ/v9Cd3CyRPzXPVakcZvERIdBp2wqqt3zG22edYccFsvq8cf8YK71rw1OudMB
 Nggt6lirooaIEKdF/jwbJNiEA1pnyY6tqe/31kqFxX2exmoVSZzNrErQpO8GJh+YBt
 mOkfWsprWfpiFWNAGYG9r8rDRlToUnoH6t9vfoO4zQFHdk22bhwTOMdLuNd/S9FQ7b
 0oBiRurFIx9dGmruG2wEXJ1tzyCVNoAniCpCxXHsfU1JznywktZWWYsvGjN+3q2idb
 fqc/HUcDjVmBX3Q3o1jmI5ZXbBstHZfQR1iL/RkZpj4yZbu0yt3fuYWhkHUjfm51ot
 CF0HbfvCXEcPg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 259B617E05B8;
 Mon,  1 Jun 2026 20:32:17 +0200 (CEST)
Message-ID: <d8d7362f-4f62-44ca-895f-15f804f53b0a@collabora.com>
Date: Mon, 1 Jun 2026 21:32:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] YUV support for VOP2 background color
To: Andy Yan <andyshrk@163.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
 <8061cc0.a9f1.19e836d8cf0.Coremail.andyshrk@163.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <8061cc0.a9f1.19e836d8cf0.Coremail.andyshrk@163.com>
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

Hi Andy,

On 6/1/26 4:44 PM, Andy Yan wrote:
> 
> Hello Cristian,
> 
> At 2026-05-25 00:27:27, "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com> wrote:
>> Since commit bec7cbfa7d4f ("drm/rockchip: vop2: Support setting custom
>> background color") the VOP2 display controller allows configuring the
>> background color of each video output port.
>>
>> However, this is currently limited to RGB formats.  When operating in
>> YUV overlay mode, the color must be programmed using YUV format.
>>
>> Add the necessary RGB-to-YCbCr conversion logic, covering all color
>> spaces supported by the display controller: BT601L, BT601F, BT709L and
>> BT2020L.
>>
> 
> 
> Do you currently have a branch that makes dw-hdmi-qp output in YUV mode ?

Yes, please check [1] which is based on a subset of Nicolas' color format
series. 

Note I've also submitted a new revision [2] to handle the conversion from V4L2
colorspace to vop_csc_format (already included in [1]).

Quick test:

# Switch to YUV444
$ modetest -M rockchip -P 34@82:1920x1080+960+540 -w 82:BACKGROUND_COLOR:18446462598732840960 -w 85:'color format':2

# Switch to RGB
$ modetest -M rockchip -P 34@82:1920x1080+960+540 -w 82:BACKGROUND_COLOR:18446462598732840960 -w 85:'color format':1

Regards,
Cristian

[1] https://gitlab.collabora.com/cristicc/linux-next/-/commits/rk3588-yuv420
[2] https://lore.kernel.org/all/20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com/
