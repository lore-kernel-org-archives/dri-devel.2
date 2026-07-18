Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A279C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 15:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C067810E5C7;
	Sat, 18 Jul 2026 15:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DCyh3ycs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FB610E5C7
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 15:55:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CF9C41714;
 Sat, 18 Jul 2026 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6051F000E9;
 Sat, 18 Jul 2026 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784390129;
 bh=wPjijAVg35MkHTacNeTYFYiw8V0qpSbo7X/KDhdz+HE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DCyh3ycs9qCeG4YWLcbdpOWTwWo/i5gAqfQQE0qfNCCUfAXkuOlI2hbQ5WD5m+G59
 dG2CTOAKKbqP1g2lvxtO4X9NBa2VKSTf2Zcua9neuQXwSotnK381A9lqYZZDq1OpRJ
 lEfNKOukpWiWFNn7r2EXV5PzxuwQ6GS4eU4RVxJrHWba1AkmWBZK9/7ZcEkjeOqE8j
 CoseEfApuqddfDqIysU7XGNd2qlIugjt4MjS1A+lB1HKq2rmBEQh213VMW398azUvF
 oTYu52ysjdyKksQT/CYb7QhcxQdN/2vgAUY3P/Zz341/dKl3uGxAv6uVTPdbrlwcZc
 VGDHbhSRbHp3A==
Message-ID: <767e5a58-3d2e-4f80-bb85-d300757a9dbc@kernel.org>
Date: Sat, 18 Jul 2026 17:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI
 to HDMI driver
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>, y@hu-mdsor-hyd.qualcomm.com
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
 <85505d92-ebe3-4ffd-84e1-8fe26994e053@kernel.org>
 <altfrJgx2IjO1g33@hu-mdsor-hyd.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <altfrJgx2IjO1g33@hu-mdsor-hyd.qualcomm.com>
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

On 18/07/2026 13:12, Mohit Dsor wrote:
> On Thu, Jul 16, 2026 at 02:56:02PM +0200, Krzysztof Kozlowski wrote:
>> On 16/07/2026 13:31, mohit.dsor@oss.qualcomm.com wrote:
>>> From: Sunyun Yang <syyang@lontium.com>
>>>
>>> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
>>> mipi dsi and output hdmi, differences in hardware features:
>>> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
>>> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
>>> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
>>>
>>> Signed-off-by: Sunyun Yang <syyang@lontium.com>
>>> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
>>> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
>>> ---
>>>  MAINTAINERS                              |    7 +
>>>  drivers/gpu/drm/bridge/Kconfig           |   18 +
>>>  drivers/gpu/drm/bridge/Makefile          |    1 +
>>>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1293 ++++++++++++++++++++++++++++++
>>>  4 files changed, 1319 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6dea93a41962..30be2eaf2bec 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15184,6 +15184,13 @@ S:	Maintained
>>>  F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
>>>  F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
>>>  
>>> +LONTIUM LT9611C MIPI DSI TO HDMI BRIDGE
>>> +M:	Sunyun Yang <syyang@lontium.com>
>>> +M:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
>>> +S:	Maintained
>>> +F:	Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
>>> +F:	drivers/gpu/drm/bridge/lontium-lt9611c.c
>>> +
>>>  LOONGARCH
>>>  M:	Huacai Chen <chenhuacai@kernel.org>
>>>  R:	WANG Xuerui <kernel@xen0n.name>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 4a57d49b4c6d..b8959b8e2ad0 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
>>>  	  HDMI signals
>>>  	  Please say Y if you have such hardware.
>>>  
>>> +config DRM_LONTIUM_LT9611C
>>> +	tristate "Lontium LT9611C DSI/HDMI bridge"
>>> +	select SND_SOC_HDMI_CODEC if SND_SOC
>>> +	depends on OF
>>> +	select CRC8
>>> +	select FW_LOADER
>>> +	select DRM_PANEL_BRIDGE
>>> +	select DRM_KMS_HELPER
>>> +	select DRM_MIPI_DSI
>>> +	select DRM_DISPLAY_HELPER
>>> +	select DRM_DISPLAY_HDMI_STATE_HELPER
>>> +	select REGMAP_I2C
>>> +	help
>>> +	  Driver for Lontium DSI to HDMI bridge
>>> +	  chip driver that converts dual DSI and I2S to
>>> +	  HDMI signals
>>> +	  Please say Y if you have such hardware.
>>
>> Please wrap the code to appropriate limits.
> I checked the others in Kconfigs they appear to be similar,
> still i will try to fix it.

This is nowhere close to the limit expressed by coding style.

Best regards,
Krzysztof
