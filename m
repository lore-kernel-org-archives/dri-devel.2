Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4349F9D0E4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229B010E631;
	Tue, 14 Apr 2026 16:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Le96GiwR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6B110E628
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:25:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 664B060018;
 Tue, 14 Apr 2026 16:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FDAC19425;
 Tue, 14 Apr 2026 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776183940;
 bh=oXPr6DICSQAjrstqrDQl8dHMx2EjDycoyikzXqoN0vE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Le96GiwRQmFJpXkrBR1cBOh46m9m12Vv3tth2mtOZn+E/McBgQSC6NTjAm3pzLW8F
 HTB8OQYqn0LsCwhhCQOu2J8aE33FBef3DHAaVo392gLOBXzSnaitm2oBHKo0vQD8Po
 Gl1rA8URvIDp06I51J74CENBcfomdPB+K3F535Nm4XQV9PFfN5lv8VWWXeYWZr7O4w
 KMwe+I1EVfiZfEzGc3xiNhyMnmIW/YjWfjirDW9j7jG8+TVN/s3C+tqlX8c9M2Y8ar
 zE9Sw31MS0sN9owOuR10RezkhbtR1oyGp6jk3jH0vAaeifMMmbVOkVZQ94GSMRI2fD
 Q1PBd8udugN3A==
Date: Tue, 14 Apr 2026 17:25:32 +0100
From: Daniel Thompson <danielt@kernel.org>
To: maudspierings@gocontroll.com
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/4] dt-bindings: backlight: Add max25014 support
Message-ID: <ad5qfDzaHZhjZsLs@aspen.lan>
References: <20260407-max25014-v8-0-14eac7ed673a@gocontroll.com>
 <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
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

On Tue, Apr 07, 2026 at 04:41:42PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
