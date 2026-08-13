Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CBFC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D4E10E4DC;
	Thu, 13 Aug 2026 08:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lhlD24SM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF7510E4DC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:23:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 343BC43E4D;
 Thu, 13 Aug 2026 08:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9BE1F000E9;
 Thu, 13 Aug 2026 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786609414;
 bh=kAJG2tMi3j77KOOlXo8NWPoO25sEP3JIjzOASqatMTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lhlD24SMJQRjQd+kbLE5uRRv7WuA2GamB/Pus/CabE9F3MPHi5ZVhBai6uUrftIlg
 Jjbph9PP0aJkYmx8YLfqc0NhPrUG4bCJuNjNvGZmufEx3dkQOp09HY3xK2anCGSaM3
 8sHCpUVvvKv2mw3CG0h/y4a5TLNcy6D5ZYFiCZulgyNQeCeVEbE8TdSExN1GEdVFRy
 ET59kIWqX3+VixTe8+OO4GgG7Cf0NuFFKW4UwCmwuxRbTsueIDU3TOWClSFxkVX2To
 yc7g3KKcIZjGQXhaarBzfQ4CgZR+53pJ9rDCdpvKPEaw8Z+obieDL0zXec9Myq7hk1
 ZqoGoTIvrWQTQ==
Date: Thu, 13 Aug 2026 10:23:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple: Add
 boe,dv215fhm-r01 compatible
Message-ID: <20260813-eager-international-limpet-743d6a@quoll>
References: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
 <20260810-b4-lvds-panel-doc-v2-2-f2c2fe309989@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-b4-lvds-panel-doc-v2-2-f2c2fe309989@oss.qualcomm.com>
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

On Mon, Aug 10, 2026 at 08:27:30PM +0530, Vishnu Saini wrote:
> Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> compatible string to the panel-simple-lvds-dual-ports binding.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Best regards,
Krzysztof

