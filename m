Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D09C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E5C10F275;
	Thu, 13 Aug 2026 09:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0pXVMZv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB90C10F265
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:42:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A16BE405DF;
 Thu, 13 Aug 2026 09:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5931F00A3A;
 Thu, 13 Aug 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786614170;
 bh=O0GdR5HLPzTl9h8BXfupD23voEfJLfSuwylkuvGxcpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M0pXVMZvCmT3435jyxqyZgQUuZg2oUdjZLNSPHMlcxKkUm691YeWvTn3AdNI0mmuA
 KA7q1tTwkkM6SCypzcRlZ1PHzLI2VdALJWkXJ+/74ukzQURAZ4Mv5uFW/XJXvycafX
 oE9ax0DMc/U7vTqguwRZs6Z5mtLKNOeQkA9kEL8hndHEQSpt+cCalem3xOK+f3is0q
 GbudmnbYi2lUG7Kd1pF8Rg3cITjUkSYxbqY8o/r77zvxm9vLuaYg0gmSLCw97vQw6e
 /E0xXef8bQgjbVF2069VrhO7AYIY5B8BaaIg5zNUnq3jn2bI6wzcZkLNnE5wNus7IJ
 LuPB3C8KhQ8BA==
Date: Thu, 13 Aug 2026 10:42:45 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <an2RlSuqoH4EmLEO@aspen.lan>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
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

On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> Add a driver for the Orient Chip OCP8178 backlight controller.
>
> The OCP8178 supports either PWM or a vendor-specific onewire protocol
> over GPIO. This driver implements the onewire protocol, which enables
> setting static brightness levels without requiring a continuous PWM
> signal from the host CPU. Note that while the vendor calls the protocol
> 1-Wire, it is not the 1-Wire protocol from Dallas Semiconductor as
> implemented in drivers/w1.
>
> Signed-off-by: Wim de With <wf@dewith.io>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
