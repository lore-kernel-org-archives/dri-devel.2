Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E6C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A6310F38E;
	Thu, 10 Sep 2026 08:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZzAFjEtg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0501410F38E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:53:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C897600C8;
 Thu, 10 Sep 2026 08:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0612F1F000FF;
 Thu, 10 Sep 2026 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030408;
 bh=rb/nWle+SPnEXKJq1ypUwPmXBvGKN1UyzXMzt0Y/Pa8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZzAFjEtggz3y0hm/gSNdIUPZ0/v8mA9N7TPqwNZHLbl/JsN1z76eGV0mn8gkGhb3j
 Icdxbz4qSZtxxsjNB24x1C64Yay7U215TDz2K3mlyLSU1lqEAbydcQqQwxy2iVtwEW
 49BwRqmHclLsHo/kgCDMU7swvQNeGKbnKU/1dsKZqiD+uS48kmHoEuLvZlAXvk4o1l
 nMPWcMEjfPZ3ClDHkRnTB0ymbZKAf5W9EdX9tlEYPOogfll1BCLoc/l26MKicrMXMc
 UBISW6h6AxeBcdHpo42sWwEyRbYQCXDQg9LKq3wpaVwZ/3myzBrVvnaoRLk5B0hmTq
 EinFhfmkh3bcg==
Date: Thu, 10 Sep 2026 10:53:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: ebbg,ft8719: update
 Joel Selvaraj's email address
Message-ID: <20260910-auspicious-aspiring-frogmouth-e6da48@quoll>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
 <20260909-update-email-address-v1-3-94a240f9469e@joelselvaraj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-update-email-address-v1-3-94a240f9469e@joelselvaraj.com>
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

On Wed, Sep 09, 2026 at 01:12:01AM -0700, Joel Selvaraj wrote:
> My jsfamily.in address is no longer active, switch to my current one.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
>  Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

