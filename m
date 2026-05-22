Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8FCCD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B4910E175;
	Fri, 22 May 2026 06:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T9fklyXk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A477510E175
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:53:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DB5C40A4E;
 Fri, 22 May 2026 06:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ACD1F000E9;
 Fri, 22 May 2026 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779432795;
 bh=MCXTW2aOaTue8CGuD3TkPBjG5amIHfOVy3I1QHrr5hw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T9fklyXk++gVyN5MTlOuDtPZAa4x2oK5cbE/aA6ue6o8/47ysIaE/BmTQyrdCYRHF
 t+F0Em7yVbh1qVURXJJtBg9pshRY5ymwwYt5GFC1EBpak06BfSZh+J8KeIexHpBhEl
 8tf0padDvBn+uKHXymRV6unqxfNHJcmBWuRm4Bvhg5iSfWjWunNZy20kF/JHpFnmKa
 mMWDjYJgA49WiTvu92FNdWw2Jdih9uU6fU/FmtBllfmsS5vh+oK63rHhQ63eVx0DGu
 3jp7Kg4wjHkU3JROyI284uTEz7RdBMBT39uUPBIFQeTqoLHQlbQNU4SDkDEOMMI6wb
 xG6KGyfyLf08w==
Date: Fri, 22 May 2026 08:53:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vitor Soares <vitor.soares@toradex.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 14/15] dt-bindings: display: panel-lvds: Add LG LP156WF1
Message-ID: <20260522-furious-coua-from-arcadia-b81cba@quoll>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-31-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-31-ivitro@gmail.com>
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

On Thu, May 21, 2026 at 04:00:50PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add the compatible string for the LG LP156WF1 15.6" FHD (1920x1080)
> dual-channel TFT LCD LVDS panel.
> 
> Assisted-by: Claude:claude-sonnet-4.6

Really - oneliner for trivial binding needs AI tools to help writing it?

> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

