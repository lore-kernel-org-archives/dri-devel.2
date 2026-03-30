Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752971061B08
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92C210E7D1;
	Mon, 30 Mar 2026 21:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WRFFKGMW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oFIrNh8j";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8074E10E791
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:07:49 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fl3jv6Zf6z9vWK;
 Mon, 30 Mar 2026 23:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YU+r2po9+ZAI3zyhFDbJIdHWX5FggAP3IdGb0xUDZpQ=;
 b=WRFFKGMWaYfMqYyhV1kxg+DnYlRJdgAUT0KSOgD3d2DEqEqx4H2cxpIR3b09j5mHmvPeD3
 zm3amPPGllTpdmzjiV4SV423/YqCov+sT1us8MyaDkirqa6KDrgItP/TdcLGoPTikXAPVr
 YQkgzSXW8Bs4TqDEVuej0VK3zpGulo3PGiY1+Lgsf44t7vxId1oNVd5jcTmjKbWwMeUQlp
 n2yOYbhuNo6+Y6rDo7qThPFj8J1/fWk9MJOhnKYR0Jty8WQwezkjXZhCBHAzqoM17UvhuK
 F3PuevL3TYbHxrxEUBl6mwJdlQ18sxTzJv/0ZuoIKOC2TSDwH2L5GhDGh43Otg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oFIrNh8j;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a13f5d5a-76aa-420e-a724-9b4714b51ccd@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YU+r2po9+ZAI3zyhFDbJIdHWX5FggAP3IdGb0xUDZpQ=;
 b=oFIrNh8jKs5ka1uIXFh8GEOUe5sI1Q5I13h93gXclziYSAicX+h7HXx1w03JiEF7N009VF
 8eW1ZrGf7E8fEFzHn11/SertXYE07tBEPL3NLFRhFNRuM5Y7unaVfbysN85/UNN/8qVZEK
 X8ivnLVvucJ6p/RnYf/9XsogCzeOd+kYP+EFeEx0HcYy3C+OhK60GwfmK5a/FbZm1bBNPn
 1Aogl2DJ75PiDqhFtPq1y/EMp6T2Q7g9FmBDfVaF89U5qu2BZ5VuNhbomZZGNKn7Viu5ge
 rcDFXkSkl8o+ps35dvtMoLLMYS7z/7NHkM92fmjjVkLtaeSeHN23oxZJogfsGA==
Date: Mon, 30 Mar 2026 19:21:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/panel: simple: add Waveshare LCD panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
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
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f8910bc22a03f00cc40
X-MBO-RS-META: 9jqxftae9jigkyjbc4zwgif49wdm4ba1
X-Rspamd-Queue-Id: 4fl3jv6Zf6z9vWK
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

On 3/30/26 3:25 PM, Dmitry Baryshkov wrote:
> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
> ("dt-bindings: display: panel: Add waveshare DPI panel support")
> described two of them in the bindings and commit 46be11b678e0
> ("drm/panel: simple: Add Waveshare 13.3" panel support") added
> definitions for one of those panels. Add support for the rest of them.
Can we by any chance use the icn6211 driver in tree for this ?
