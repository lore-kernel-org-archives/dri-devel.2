Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC3ECCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EA710E2D5;
	Fri, 16 Oct 2026 15:30:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E42A112870
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:30:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B50D7411F6;
 Fri, 16 Oct 2026 15:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC91F000C4;
 Fri, 16 Oct 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792164635;
 bh=JFnTmB5sqjLGfShmwLVzlOKzOTcZuvQ7gf3RXCL4J3Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JcLRy/Rm/2DMz4qjjhdXHf9s68mYAtR2uy2vuhfNFlhyEJtkbPTtDU0mdeevOYRJD
 bza2+kjMy4GlPfOq+qBbl0feC0zqQ30CwfyNKQETV017PKAugC/Pl4cptp8MzwrdVM
 7O/27HbwPuBx26OiVdonFrBY03Ex4V9q6hwoQAA+qjUeTtH5c48YrcrUrcyGMWnAz3
 LJWBomm7Sj5TVX1ASkwSl9V1ZhScjO/bo4jvueMYLk5NlrO0BP6bIhqJvUocX0+h7B
 zvcdMeJ0FD6PCKuaMrtgxXl95U5Y12dulFXutJaHErk7X3OV6hMtPbpyGPVlduZqLI
 vdjbFyxvk7S/w==
Date: Fri, 16 Oct 2026 16:30:29 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max
 current
Message-ID: <atJDFRXmgZ37GrCE@aspen.lan>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013180933.487013-3-clamor95@gmail.com>
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

On Tue, Oct 13, 2026 at 09:09:31PM +0300, Svyatoslav Ryhel wrote:
> @@ -69,10 +57,11 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
>  	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
>  		 bd->props.brightness, bd->props.power, bd->props.state);
>
> -	ret = aat2870->write(aat2870, AAT2870_BLM,
> -			     (u8)aat2870_brightness(aat2870_bl, brightness));
> -	if (ret < 0)
> -		return ret;
> +	if (brightness) {
> +		ret = aat2870->write(aat2870, AAT2870_BLM, (u8)brightness - 1);
> +		if (ret < 0)
> +			return ret;
> +	}
>
>  	if (brightness == 0) {

I think this could be spelled "else" ;-)

However, other than this this looks good. With that change applied:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel
