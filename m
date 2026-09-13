Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C90C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE9110E0D4;
	Sun, 13 Sep 2026 09:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JKWXfKUm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E01510E0D4
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 895B060AAB;
 Sun, 13 Sep 2026 09:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFD1F000FF;
 Sun, 13 Sep 2026 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789292080;
 bh=ZkTfuIMcCGjNXiffCR6iTaAfYv3lmpMxeqnGSOZ/ADE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JKWXfKUmhRrmv3OHeOsoY1pYrxXdt3gq9xGUEmspxOU6/UMPTqkqdAbJFRMOk+1v+
 FHm0eSVw3YfxWBHFo/ixIle8yqsZSt3GDdhUQkVrrnQk6tBVCRzSisx5KeicNJ6iin
 agzP6y3CKM+dM1717/BJbYyOKfdjoVK9J9gTVaqPPKAjKzbdwM83rXECNJM3ra0oOh
 gV9x6diqJRuBuGa1oiIHVc0zDed/bhAkRM+sxklQDdex4uLrZpVLTNkbpSrNzvG5Fs
 dTze1G4S2/IGjI9KqcZjjpCiI0mx4u2RUIZrb3KXKB6XbYO0wVXZ82NzbfZWBAfpsr
 cB0lrEt5EiJfA==
Date: Sun, 13 Sep 2026 11:34:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enzo Frese <freseenzo@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: panel: mipi-dbi-spi: add
 sitronix,st7789v-tft28
Message-ID: <20260913-easygoing-chubby-sidewinder-67beb9@quoll>
References: <20260911203342.76692-1-freseenzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911203342.76692-1-freseenzo@gmail.com>
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

On Fri, Sep 11, 2026 at 05:33:42PM -0300, Enzo Frese wrote:
> This is a generic 2.8" 240x320 RGB LCD panel with a MIPI DBI compatible
> SPI interface, based on the Sitronix ST7789V controller. It is commonly
> sold by various resellers without an identifiable original manufacturer
> name printed on the PCB.
> 
> A basic mipi-dbi-cmd[1] script to get the display running looks like
> this:
> 
> $ cat sitronix,st7789v-tft28.txt
> command 0x11
> delay 120
> command 0x3a 0x55
> command 0xb2 0x05 0x05 0x00 0x33 0x33
> command 0xb7 0x75
> command 0xc2 0x01 0xff
> command 0xc3 0x13
> command 0xc4 0x20
> command 0xbb 0x22
> command 0xc5 0x20
> command 0xd0 0xa4 0xa1
> command 0xe0 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x44 0x45 0x0f 0x17 0x16 0x2b 0x33
> command 0xe1 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x43 0x45 0x0f 0x16 0x16 0x2b 0x33
> command 0x36 0x00
> command 0x29
> command 0x21
> 
> $ mipi-dbi-cmd sitronix,st7789v-tft28.bin sitronix,st7789v-tft28.txt
> 
> Tested on a Raspberry Pi 4B using the panel-mipi-dbi driver.
> 
> [1]: https://github.com/notro/panel-mipi-dbi
> 
> Signed-off-by: Enzo Frese <freseenzo@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

So v2 send in a few minutes, with different subject so Patchwork could
not detect that it is v2, thus I spent time there.

Same comments.

Best regards,
Krzysztof

