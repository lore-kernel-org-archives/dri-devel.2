Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A5C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8762010F308;
	Fri, 14 Aug 2026 07:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="L6w4TkoS";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3E810F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:03:28 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id A460023E65;
 Thu, 13 Aug 2026 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786615405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLaN4f3N6hbPhZzEo8AH8L3A2vrPXXcp/6EZkbNc4Lw=;
 b=L6w4TkoSNd7hnu6Nuxv73dllFQL9cOLiLvb4RBoGYI+2+AI/X0lbrjsrf6kXHSgQPUKFbh
 X0dyYBsyKB4r7A/119THkHcIEGu0jhvfwJdT77oJJjJe5q36V9hIqmdFhj2nBo7xxAZxLw
 Va7x/VjX0w9DD/wWHI2F2BbP2jaCEl0=
Date: Thu, 13 Aug 2026 11:59:44 +0200
From: Wim de With <wf@dewith.io>
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <an2VkN3446Ndxn9c@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-1-4ad18b48bef8@dewith.io>
 <an2RgGwu2YaglM7H@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2RgGwu2YaglM7H@aspen.lan>
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

On Thu, Aug 13, 2026 at 10:42:24AM +0100, Daniel Thompson wrote:
> On Wed, Aug 12, 2026 at 09:21:46PM +0200, Wim de With wrote:
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable and dim the backlight.
> > +    maxItems: 1
> 
> Is this really an "enable" GPIO? The enable-gpio(s) for most backlights
> is the HWEN pin rather than something used for protocol. Maybe
> onewire-gpios or control-gpios?

I agree, and there is prior art in the kernel for ctrl-gpios, so I'll go
with that.

Regards,
Wim
