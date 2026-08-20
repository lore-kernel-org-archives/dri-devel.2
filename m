Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB54BC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1321210E14C;
	Thu, 20 Aug 2026 06:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uhnp1VQY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FAE10E14C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:48:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B369E43738;
 Thu, 20 Aug 2026 06:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9529E1F000E9;
 Thu, 20 Aug 2026 06:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787208520;
 bh=QevXqOjmThfsypAErhlJDLgFo7ZGdAndBJHfDiAW7e0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Uhnp1VQYPSOGkPG6GeIj5hePdI+FB86YKKTVTGvjHO/Glk6mpSQ0fcW5mIQsOH/YV
 DPn81zGYBdciMSWB2zcZTaIUrokp/s/NlvxN+bExBr+eioD00d5Sga9XbAYWNapyK4
 /1ds1E9+W/DxbfTIhu610M6N46l1149wsjAK5/1VdQu7iwi1dx/Df5mjzia1TB5otI
 cuxBeLYKaMAVHHXUiOsJqob9DIkr557Dle5T5cr9PRAv1OAhaJss3NsBA+YAt6q4Hj
 o0QokcdWKumnU+XjG/QtooA+kA8YTRpC4wi91bowvtAtwgyQNhg12aNXzuuSOX0gQn
 FVWIRp86odU5A==
Date: Thu, 20 Aug 2026 08:48:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: visionox, vtdr6130: Add Retroid
 Pocket 6 panel
Message-ID: <20260820-nocturnal-arboreal-cuckoo-2eed61@quoll>
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-1-111c1aeccf0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-rp6-panel-v1-1-111c1aeccf0f@gmail.com>
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

On Fri, Aug 14, 2026 at 01:17:15PM -0500, Aaron Kling wrote:
> The vtdr6130 is a display driver integrated circuit, a common chip used
> for various panels. One such panel is used in the Retroid Pocket 6.
> 
> The RP6 panel only lists the regulators vddio and vci, so drop vdd as a
> required property. The panel is rotated 270 degrees to natural, so also
> add rotation as an allowed property.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml      | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

