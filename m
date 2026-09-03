Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB78C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3EB10F57C;
	Thu,  3 Sep 2026 12:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xje0YJg7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DDB10F57C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:36:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56DFC6022C;
 Thu,  3 Sep 2026 12:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435141F000E9;
 Thu,  3 Sep 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788438994;
 bh=4w6jf87vafgM99bg9s6kWCWTFKCA2du6LEtWeZQAPcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xje0YJg7/rQdGmYKvRqh8OHMnTgXxL9lxMK2WYusyrfjvyCj1P42mpgdm2wfxtqTb
 gF5oqbwataixl0q9rm01GE677vb2RjMTPMx1RLto7UJrhdmRSjsj9aIGy6iINWnvPf
 EsmOolg65pC/cvHw/btvFoxVERH1ZBJRV0MzqhohlEceM+vVB6Z8HnGGfZOfGA6K7d
 B6YOhzM/QaMbq8GCHHiWPXcDu87dXXF7F6wltT2R4XnYg0takIbWaSsyLat8Cujv/a
 s2eRk9Z1fS/3OQkNm/62rFmfEQGeLqKtEtbipr+gDQcjK4BWcp/Z5mVJrK8tPHwP1M
 tdEHNOR9RMlQA==
Date: Thu, 3 Sep 2026 14:36:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Message-ID: <20260903-corgi-of-splendid-defense-9c8cae@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
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

On Tue, Sep 01, 2026 at 04:47:57PM +0800, Xilin Wu wrote:
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm

"Document the Radxa ....".

> SC8280XP platform.
> 
> Document its radxa,dragon-q8b compatible.

No need to repeat the diff contents.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

