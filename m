Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A076CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E5610EA0E;
	Tue, 23 Jun 2026 08:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R0u4f0vm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1D510EA1F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:43:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A373A60052;
 Tue, 23 Jun 2026 08:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB51F000E9;
 Tue, 23 Jun 2026 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782204233;
 bh=9N7Z/t3yS/fJOyNmuIzO1Bt4wNfsxzy25SOgFyC2mdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R0u4f0vm++dpzVcMtZGMaEUor0mZo4RbD9F8Ws0y+OR8CSmusOJvIV/yg6VpnpPOH
 UTxSf9Er79H2Mi+/K0PWjVCg5j0xMoLeY0VLb64CfaJ4AAZay+kbNA31urbSW9YpHL
 8pVsyxHG41J5ee9VZjRYYV4UNR48aKO7by0P3ubMouhfz/4nYvTPZqEUMiVHDg4ftC
 T+nwBesuiiBsScOqLCmsQlbX9Obzq6GVBayK/KB1CGKD7zFXZJ3wXPtl0x8ysWEzQg
 8mZihPskb4J5pDTWA7SOQuIbjobbsQr/2aWrMa+nw6DgE0FxDIhEMmXAeasNDKx9Si
 bnsQ02SRcuJfA==
Date: Tue, 23 Jun 2026 10:43:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, 
 gregkh@linuxfoundation.org, deller@gmx.de, azuddinadam@gmail.com,
 chintanlike@gmail.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Message-ID: <20260623-debonair-wonderful-bug-e8abb3@quoll>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-2-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-2-amit.barzilai22@gmail.com>
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

On Mon, Jun 22, 2026 at 06:25:03PM +0300, Amit Barzilai wrote:
> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> builds on the shared solomon,ssd-common.yaml properties already used by
> the other Solomon display controllers.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  .../bindings/display/solomon,ssd1351.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

