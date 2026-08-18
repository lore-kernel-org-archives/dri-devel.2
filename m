Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87F9C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CD410EA78;
	Tue, 18 Aug 2026 09:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvEGMl0i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C175810EA65
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:05:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC2F760A61;
 Tue, 18 Aug 2026 09:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658151F000E9;
 Tue, 18 Aug 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043929;
 bh=dEnljxo0cPfEBmMxWEU2YfmO6Q8TD6rHTlbi0qUFIBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VvEGMl0iEuoU7p4cr7L3b2P1L5Oga5Jz0bPSjRk+B129D3GlF/EJOSQy8hsF8ceOG
 3Zhcsd9yvDMlNQbhDM04tqbkyr7rtBcVy0bAz1vFmsKdLQUuWR083cbUh9MKq5zRIS
 2dIu9TxTVVTeB6owTDMLeZ/PdeV+Spnx/QwixaQywUd3JNLfm+3iM/QzdHK+tQ9ZHX
 bNjdXOmKL0yxMqgnOz9nJQFipsHowUBOLZeOxYzqoTH/dDQb0b/FpRqnEWDreP3vgi
 5GpjM+jASM2mIvF3KDDdPswQPhb/r1sAXiAx5LmLCvfujTyT9ub7JlKSHdg4NG/rby
 ukYvrQRtC2gWA==
Date: Tue, 18 Aug 2026 11:05:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: display: bcm2835-v3d: Add an optional
 reset line
Message-ID: <20260818-idealistic-chivalrous-sawfish-08ddae@quoll>
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-2-896444373716@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260816-vc4-reset-control-v1-2-896444373716@igalia.com>
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

On Sun, Aug 16, 2026 at 11:05:41AM -0300, Ma=C3=ADra Canal wrote:
> The BCM2835 PM block has exposed a reset line for the V3D block since
> commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains

This is a reset provider driver, so not really relevant here. Driver
commit would be relevant if it was about consumer who implemented
undocumented ABI. I suggest to drop reference to driver and instead
describe the hardware.

> under a new binding."), which allows the GPU to be reset without
> power-cycling its domain. Document it so that the vc4 driver can use it to
> recover from a GPU hang.

Does every device have it? Cygnus as well?

Best regards,
Krzysztof

