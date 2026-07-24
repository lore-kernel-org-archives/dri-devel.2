Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA002C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0130D10E64E;
	Fri, 24 Jul 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NOOQpa6D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C93510E64E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:53:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA2D0600AB;
 Fri, 24 Jul 2026 09:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3F51F000E9;
 Fri, 24 Jul 2026 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784886830;
 bh=57WjHrrj+XhBfQI6VN17QRnSeT6I8LyZrntfRkUsn/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NOOQpa6DkNk59xH7jAhYYCtTCXcARk8G4ct6y5SKzZJQfGN9GWgaPGvF+bIJV4J8I
 HjVVgYAOlVq0K+iTP30usuneAqVPxWkYco4sYn1n2zJkysbu+9oMjMKRCN+oH2pDtE
 AWz2KXnb7/1IbiDgD6NEQW32nq6vXL6T1m4XIEoAwrhZwf7SOWziSOsrEtoQ47Q5g8
 B0t+YOCilRpl+Y86VUj6sM9qKtakeAW/+Aqv1oPdtt8MiO+SW+6WQc2KnverOyGZuM
 MV2fFZD7wumPiE1Gf1ejMfgkoxvzgHybVgnwb6byTT42Z5nGstZRsMG8l21wNMDXW4
 fW2USH6SXOKzg==
Date: Fri, 24 Jul 2026 11:53:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre Hamamdjian <azkali.limited@gmail.com>
Cc: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add AYANEO Pocket DS lower panel
Message-ID: <20260724-aspiring-imported-skunk-abecfb@quoll>
References: <20260723-b4-st7703-pocketds-lower-v1-0-e3db246589f4@gmail.com>
 <20260723-b4-st7703-pocketds-lower-v1-1-e3db246589f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-b4-st7703-pocketds-lower-v1-1-e3db246589f4@gmail.com>
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

On Thu, Jul 23, 2026 at 06:26:28PM +0700, Alexandre Hamamdjian wrote:
> The lower (secondary) 5.0" 1024x768 IPS LCD panel of the AYANEO Pocket DS
> dual-screen handheld is driven by a Sitronix ST7703 DDIC, as identified
> by its ST7703 manufacturer command set (SETEXTC 0xB9, SETMIPI 0xBA,
> SETGIP1/2 0xE9/0xEA). Document its compatible alongside the other ST7703
> panels.
> 
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

