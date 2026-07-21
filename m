Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3EC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C1510E35B;
	Tue, 21 Jul 2026 15:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPBZDEjG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B3A10E35B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1000414B7;
 Tue, 21 Jul 2026 15:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751AE1F000E9;
 Tue, 21 Jul 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784646168;
 bh=eRxy9o7bxYedbpNQw5m8RnT/2fuzGv+0CqJ7qJPopw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fPBZDEjGx4jjMacBFM4owxlS8aPseFZd/MW3q3Pq9fEjSM3BRd2V44b6MZoVB0uob
 N1QHjh4dKn/SnC8rkUqGFvKsPy2ZTgiNMsCOQeV/7gf4ZftUVW1PAZIEtV2NBqqSvY
 um+ljf+VZho7K1fPcEsY0759OuVP/0yHYfa3WZDJiWikO4PWhoYiM+CyjdYKiRy466
 Lgra2Gll9qOnJk6sxh7i0P0LUR+0+E7tDbM4F9mlShSeLx43WrcGCaS04m2IB5IBJB
 Kaj0CJffjWcHG5JT+1O8eobw39OvAFo+myCINfb0frqCBF9B+6+PjINoaakxrI8uo2
 uXoPfg2wZMgYw==
Date: Tue, 21 Jul 2026 10:02:47 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Eduard Bostina <egbostina@gmail.com>, conor+dt@kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 lee@kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <20260721150247.GA3820183-robh@kernel.org>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-4-egbostina@gmail.com>
 <20260721113408.655C01F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721113408.655C01F000E9@smtp.kernel.org>
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

On Tue, Jul 21, 2026 at 11:34:07AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing NULL check on `dev_get_regmap` can lead to a kernel panic in the IRQ handler.
> - [High] The driver incorrectly masks `platform_get_irq()` error codes with `-EINVAL`, breaking probe deferral.
> --

Why is sashiko pointing out driver issues on a DT binding patch? This 
series doesn't even touch the driver. This seems to be a re-occurring 
problem.

Rob
