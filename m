Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A061061B21
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29B310E84C;
	Tue, 31 Mar 2026 03:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eEOKtRJT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EAc36jsH";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2539710E84C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:11:54 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flCp04Cl5z9v7j;
 Tue, 31 Mar 2026 05:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774926712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b0E8jNb5u3Q+Hgd6Ymy+a7KhoG8hKcQuq1aRU89kZw=;
 b=eEOKtRJTsx60J3em/LdVvUZUYyaV9INnIpi8xRHPpVnQjS6PtHhzz/RI02UZiHsqyKGXvo
 Kq22zIPpmwCk+6MOCghf8ZCnQxRXqSgW6nnaUXiLwBqxiPPjXCpYuLwyIZIHVGvqd/7XKf
 7dajFrxFufZWChJaE+L21VjvAv8eKMKTowRNS2LwPxtNVPZgfyVBCkxst9fot5Im8GuW/F
 1yRCfIqbtbhQ32bOZTD7InHtnIlipXpIB5vOO1XOyVAevGY16asCFwKyL40RLJFc9kqoru
 WVxvqXfEXylQFL01HH0GtTAmSK293vCBAVjTbAuz4ZaSowzJENnPaFm3gVNRYQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EAc36jsH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <982c4d97-695f-46b0-b819-a0b3d016b12b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774926711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b0E8jNb5u3Q+Hgd6Ymy+a7KhoG8hKcQuq1aRU89kZw=;
 b=EAc36jsH0XykxzW6m0HcWUu8WqDfihs+SO/GB71bu79ayqd0Z7lcuRe2AWXKnsXb+c4dsE
 i9/mAznX9k77/Zqccl7LFMU6RbhSgFlOhVTmekcfZSMGyo5z7bo0l6KGD69cQCj0GGVJ2T
 wXr6gDlvLKUBwhHl+y30+h99zlch9F3J9Y8/1jlsf9Z5NWVavWHvngyIlB3LJTr6pKIX5u
 oAjkKDnyzXb9YaXaOAHduaGk0NODni5GCRL8yPK8wdVjDZhTegI9+I++Ji+pKS68phc4aM
 8+E8KXyd+D27n/LA4qFUqMqTxZfI6ltf++XAiInj8nAWgAULoU62KivyojbzWw==
Date: Tue, 31 Mar 2026 05:11:43 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAO9ioeUFfjr3Dh58TQ8EB7H3NgUX04N24OXXYijiigRZ8Kkh0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 78c283372b980213c76
X-MBO-RS-META: i9nhbihupwadqgcp4yejhwsnrjmgjoo9
X-Rspamd-Queue-Id: 4flCp04Cl5z9v7j
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

On 3/31/26 3:22 AM, Dmitry Baryshkov wrote:
> On Tue, 31 Mar 2026 at 00:07, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/30/26 3:25 PM, Dmitry Baryshkov wrote:
>>> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
>>> being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
>>> ("dt-bindings: display: panel: Add waveshare DPI panel support")
>>> described two of them in the bindings and commit 46be11b678e0
>>> ("drm/panel: simple: Add Waveshare 13.3" panel support") added
>>> definitions for one of those panels. Add support for the rest of them.
>> Can we by any chance use the icn6211 driver in tree for this ?
> 
> As far as I can see, no. Waveshare kits have an extra ASIC in front of
> ICN6211 / ICN6202, which completely hides all programming. So far the
> interface is really better expressed by the waveshare,dsi2dpi /
> dsi2lvds: this way, even if they decide to change the actual
> implementation (like they did for DPI -> LVDS), we won't have to worry
> about it for as long as their programming interface remains stable.
Hmmm, I've seen this before, but I don't think this is extra ASIC. The 
ICN6211 pulls its register settings from EEPROM, does it not ?

But no matter how the ICN loads its configuration, this is not waveshare 
specific. I have another display from another manufacturer here which is 
also ICN6211 that is preprogrammed. Can we instead have some generic-dsi 
display , because I don't think these proprogrammed DSI displays are 
going to be only ICN6211 based and only made by waveshare ?
