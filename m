Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D871CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 08:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37C10E5DD;
	Sat, 30 May 2026 08:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KaibxtZz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E47010E5DD
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 08:56:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E77540907;
 Sat, 30 May 2026 08:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF01F00893;
 Sat, 30 May 2026 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780131360;
 bh=gCbea2ijODrO6sWfTgmHFJeUbJdsnvpmfjDFt87l/DA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KaibxtZz8iwYzltdaad6YmQE9wlQ56wgEGZvkdkNzysLW0D6l8V7t14XNKhNluyD7
 uGID3zLI2DI/G+EHuyivOzfx+sZUgpqWtFd1ZV2ouESpbr4PE+QJtqwQ3DDK5NUrnW
 tXSKAqT9NpLrc4KRDIE/3frQYTtcHvdtM0XE+69OaqmeZhwDMnhqpWDj+oQUcz1zXY
 tpJnZl8ZDMrqlnugMv6l9buOgBO5pVxMKIAFfgOrUF+PsIESTSkzuYclyaZOr731CF
 x7WN4Laj2FAXGiyjj2VhJorhHtqaeSuPNVgVVXcox2OA65FvIISPeLD2P7eDWhK7Ha
 d9WEBXdfCzKOQ==
Date: Sat, 30 May 2026 10:55:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/15] dt-bindings: display: ti,am625-oldi: Add
 optional power-domain for OLDI
Message-ID: <20260530-axolotl-of-normal-vigor-efaee1@quoll>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-3-7fefdc5d1adf@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-beagley-ai-display-v3-3-7fefdc5d1adf@ideasonboard.com>
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

On Fri, May 29, 2026 at 11:45:33AM +0300, Tomi Valkeinen wrote:
> On some SoCs the OLDI blocks belong to the same power-domain as the main
> DSS block, but on some more recent SoCs the OLDI blocks have a
> controllable power-domain.
> 
> Add the power-domain to the DT binding.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

