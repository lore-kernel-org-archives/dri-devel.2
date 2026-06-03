Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E5CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270D510FE9F;
	Wed,  3 Jun 2026 14:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="SefhuhEG";
	dkim-atps=neutral
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5143110FE9F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780495290; x=1780754490;
 bh=0EZsJvwM6lMZ5ZpyMK8ylpPZGzWdFd8P/vhUyBwyAJ8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SefhuhEGfYbIom39iOomqeW4PDrcbKtJuzXPnIRbcHXG5GYbVcLCNK13V+WganFic
 BSXGXc+FNoYz1yDZi8CDGhhfIbwbwCSq3L2yOZxxWnfwschLmERdWBjtl9kaCNmtqJ
 qpJi3JDkGLMFGa9G0DvHGXt94/lK2c+lZWWtEAwhRLodQzHRlKnv/WQ2dS7q1LhYzR
 xh18neR4rPMyDMZTFKYR7MkgvLilr/FXSQ7j4eLVrildQ28/TsX/9PunVE1mV/azu1
 kMFGtte+jmlZ6Ezc4OnCki/ijSJspBUYXMHwLR15ZWBzK318cONx8P+2/T6UTQeDeN
 GfCczZCbU71zA==
Date: Wed, 03 Jun 2026 14:01:24 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Document BOE BF068MWM-TD0
Message-ID: <ALMSs_2ssEuRgFGXhTUpuP022Q2bMpEn0F-QqFgw4PYn8RkcSWGh0e7_lL3XZy1MQpViwpnMj_98Mi8lTP6A3UsRAYi8XuZWdqIAFVT2dq4=@pm.me>
In-Reply-To: <4a7c19a3-bb00-4a68-beea-146ef65f9e5c@linaro.org>
References: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
 <20260603-asteroids-panel-support-v1-1-109c6ac81c8f@pm.me>
 <4a7c19a3-bb00-4a68-beea-146ef65f9e5c@linaro.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: baf767d958ea255241b0159643e0ae0b9472890e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wednesday, June 3rd, 2026 at 9:58 AM, Neil Armstrong <neil.armstrong@lin=
aro.org> wrote:

> On 6/3/26 15:03, Alexander Koskovich wrote:
> > +description:
> > +  This is a 6.77" AMOLED video mode display panel on a MIPI-DSI 4-lane
> > +  interface.
> > +
> > +  The panel also requires ELVDD/ELVSS/ELAVDD rails but these are
> > +  internally managed by the panel via EL_ON1 (ELAVDD) and EL_ON2
> > +  (ELVDD/ELVSS) control signals, they are not managed by the platform.
> > +
> > +  The driver IC for this panel assembly is an RM69220.
>
> If you know the DDIC, please switch to bindings & driver around the RM692=
20 DDIC
> instead.

Question about this, isn't the DDIC kind of generic? E.g. another panel
assembly with RM69220 cannot use this driver if the actual panel assembly
is different.

Thanks,
Alex
