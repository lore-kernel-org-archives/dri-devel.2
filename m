Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C2F10F9304
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDB710E316;
	Tue, 31 Mar 2026 21:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uYz5MRzt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pruv7vUi";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BF610EBAA
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 21:46:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flhWv21gnz9tmn;
 Tue, 31 Mar 2026 23:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774993579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozSaOh7+BpCE0vApkvACw7eBcsLY93hAI+RbZthq0No=;
 b=uYz5MRztFxcvePVgI0MuzKTwFQFS4npnKPtcyXSuD7GzHv3d/L2ELZwQwontUbsxfzlBY0
 ClP3863kKbiuCNPgFbdt7bCk/+iEhgvtOR5CsmNF1g0aLkt03rkyxZ1paR3uPEj3H5VVjo
 iS/LWTvy/vNV9XX7OgQ+FAWltIF29ino8GY9WItgWA/gl8nBZsLq+pwwHI9eNKqSR2qGXK
 p6Xucgkds9JoMVFs+u0q9GXs4XxmoY9l5vjbPSu1NyyGLKG22v/n+bIctTus4kRJ5WPi1s
 pMendGxdLb9as2FEEmja5sYXdJsApKC8sveuL1xyptmHW5BIAL3PNwAl2hk+iw==
Message-ID: <543fbae3-5227-44df-b8d0-bc2798e4a96e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774993577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozSaOh7+BpCE0vApkvACw7eBcsLY93hAI+RbZthq0No=;
 b=pruv7vUiaf01/ByQ6a6zYrVZwiH0oKiT2PN79GYE325/Zyk2+cDiVGHGNForDbRFSg8VFF
 MDCL1xBAvnehCEjPAmkVOnpAobHtfYbhmj2kiLUclp0DgsWjvOtxArxIATxBOWYKLs/w08
 /Mi0KcEzTRUWG1Zk4QZ8mrGSyWsyDgdC60SUbAORRBN7e1Mk333Avs+9G/Ba+7pjWOUW2G
 ga8jjfnIjkQq13WqyKPp10aBbRrK+zzh+TpAA6o/C1vKcn6erM8S0RYGGvVRoyNYElTt+5
 VvPw7x5jnAuZhhPJKOF6U+3uRvx+0dtqT6zIlaDifqqfssTjsbNKEFOG0hjD3w==
Date: Tue, 31 Mar 2026 23:46:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/panel: simple: add Waveshare LCD panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <a13f5d5a-76aa-420e-a724-9b4714b51ccd@mailbox.org>
 <CAO9ioeUFfjr3Dh58TQ8EB7H3NgUX04N24OXXYijiigRZ8Kkh0A@mail.gmail.com>
 <982c4d97-695f-46b0-b819-a0b3d016b12b@mailbox.org>
 <kqrdzvu5ycajmdprrjqwcktq42t6453csi77ngzlkomtazxjhv@sxp7vh66my4x>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <kqrdzvu5ycajmdprrjqwcktq42t6453csi77ngzlkomtazxjhv@sxp7vh66my4x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 72346ae9da5ce2ad3fe
X-MBO-RS-META: oh93f587g17taisfs85h7c8g37f1si6s
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

On 3/31/26 5:36 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 31, 2026 at 05:11:43AM +0200, Marek Vasut wrote:
>> On 3/31/26 3:22 AM, Dmitry Baryshkov wrote:
>>> On Tue, 31 Mar 2026 at 00:07, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 3/30/26 3:25 PM, Dmitry Baryshkov wrote:
>>>>> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
>>>>> being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
>>>>> ("dt-bindings: display: panel: Add waveshare DPI panel support")
>>>>> described two of them in the bindings and commit 46be11b678e0
>>>>> ("drm/panel: simple: Add Waveshare 13.3" panel support") added
>>>>> definitions for one of those panels. Add support for the rest of them.
>>>> Can we by any chance use the icn6211 driver in tree for this ?
>>>
>>> As far as I can see, no. Waveshare kits have an extra ASIC in front of
>>> ICN6211 / ICN6202, which completely hides all programming. So far the
>>> interface is really better expressed by the waveshare,dsi2dpi /
>>> dsi2lvds: this way, even if they decide to change the actual
>>> implementation (like they did for DPI -> LVDS), we won't have to worry
>>> about it for as long as their programming interface remains stable.
>> Hmmm, I've seen this before, but I don't think this is extra ASIC. The
>> ICN6211 pulls its register settings from EEPROM, does it not ?
> 
> The kits that I have at hand don't have I2C EEPROMs. They have 25Q8
> QSPI. Also note that neither ICN6211 nor ICN6202 datasheets describe I2C
> master interface. It is defined as a purely I2C slave.
> 
> The kits have WSVTH01 chip (CPLD?) and 25Q8 QSPI NOR. I assume the
> bridge settings are loaded from by the WSVTH01 and programmed into the
> ICN bridge.
> 
>> But no matter how the ICN loads its configuration, this is not waveshare
>> specific. I have another display from another manufacturer here which is
>> also ICN6211 that is preprogrammed. Can we instead have some generic-dsi
>> display , because I don't think these proprogrammed DSI displays are going
>> to be only ICN6211 based and only made by waveshare ?
> 
> If it was just about the bridge config, I would completely agree with
> you. However if you check the waveshare-dsi.c, you'd notice that it is
> not directly related to either of ICN bridges. It controls backlight
> and panel regulators.
Oh ok, this part, I understand.
