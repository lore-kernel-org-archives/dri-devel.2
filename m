Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD86C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582DC10E0AA;
	Fri, 18 Sep 2026 10:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MNXukOiO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B811D10E0AA
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:17:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7E0E60A59;
 Fri, 18 Sep 2026 10:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF31F000FF;
 Fri, 18 Sep 2026 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789726630;
 bh=sjD7gXYT9sEFgIeGRllW0SYD6Scu3JJ7NhNsn25KgeM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MNXukOiOm3AOxM//9KfJdpEvdWp/wq592XQxYRB/aoFtqzftWn6hJdXRzeYnCD6BS
 fBTKJmzKkNtBaCwpiXDzYLprD35nN66YWtSPIjhQkILjnnoIZpMFooegwvwiR+U5iY
 szyMkA7UAZbBzFI+t9WoAbOhe8JrjUhN2SVeZ70Q9FDKZEGbLOret22win++Hz58f9
 rbpoem0/n/lktLi36DLiUwm/eGiSVqhVpmr9Sj0a0sl7s12/wmoGBF8tFQD0/MrFzk
 dTKnXRxn/WoWnmnUdLuHgGZsKNvitoALfiBfJr5iuK640r26039ObEVu/u0n6dQChj
 kyFPSfPVP8P3A==
Date: Fri, 18 Sep 2026 12:17:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, 
 tzimmermann@suse.de, jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tiny: Add RAiO RA8875 display controller driver
Message-ID: <20260918-agile-cormorant-of-admiration-82ae7c@quoll>
References: <20260916175942.3186804-1-azuddinadam@gmail.com>
 <20260916180410.3188922-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916180410.3188922-1-azuddinadam@gmail.com>
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

On Thu, Sep 17, 2026 at 02:04:10AM +0800, Adam Azuddin wrote:
> +static const struct drm_connector_helper_funcs ra8875_connector_helper_funcs = {
> +	.get_modes = ra8875_connector_get_modes
> +};
> +
> +static const struct of_device_id ra8875_of_match[] = {
> +	{ .compatible = "raio,ra8875" },
> +	{},

Drop ,. Missing space. Please look at other files how this is written,
because it was a cleanup some time ago.

> +};
> +

No blank line.

> +MODULE_DEVICE_TABLE(of, ra8875_of_match);

All ID tables are placed together, just before 'struct xxx_driver'.

> +
> +static int ra8875_write_reg(struct ra8875_device *ra8875, u8 reg, u8 val)
> +{
> +	int ret;
> +	u8 cmd[2] = { 0x80, reg };
> +	u8 data[2] = { 0x00, val };
> +

...

> +
> +static void ra8875_display_off(struct ra8875_device *ra8875)
> +{
> +	drm_atomic_helper_shutdown(&ra8875->drm); /* calls pipe_disable above */
> +}
> +
> +static const u32 ra8875_pipe_formats[] = {
> +	DRM_FORMAT_RGB565,
> +};
> +
> +static const struct drm_simple_display_pipe_funcs ra8875_pipe_funcs = {
> +	.enable = ra8875_pipe_enable,
> +	.disable = ra8875_pipe_disable,
> +	.update = ra8875_pipe_update,
> +	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
> +};
> +
> +static const struct spi_device_id ra8875_id[] = { { "ra8875", 0 }, {} };

This is completely misformatted table. Please open other files.
git grep 'struct spi_device_id'

> +
> +MODULE_DEVICE_TABLE(spi, ra8875_id);

Best regards,
Krzysztof

