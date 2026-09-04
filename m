Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E54C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C792710F974;
	Fri,  4 Sep 2026 08:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NrU1OzPy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010E910F95F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:29:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02F6360211;
 Fri,  4 Sep 2026 08:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC721F00A3D;
 Fri,  4 Sep 2026 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510575;
 bh=57+zfRWquEc7/m7zU9U9Jv+O6fWgkTCFuvFGHmL7CgQ=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=NrU1OzPyAtJcQd2IbkJ0bwhfg/Y0v5rztSmztUnqZ8UF5Z4W4NBVriwtz/uEqC5PP
 EWT6q0yHiiFn66VKtWD5c8x3qQ/QprSwnyRYsMri69Tm1wy/af/KVpnHYgMFmEz5FS
 GcS4bJIc9w9xviUxreWGGeSTFpIdIMniUfiQgqg+MaVCGewJF+8TvZd3Zaz4c8Zm/1
 ks84AnlsD87w0tziRrIM9gSQcTLPD3cZGeeaNxVHLSxQFqH3X8uiTzSgdrn/9M1/yr
 snTpDqIvkrA68+/rmz7TdwxO1Z4LtBmkT6gnz4Etb3HXyu5dK72K7i3T+/WMSqeozl
 cCqRlh/xvwuHg==
Message-ID: <94cc04ba62b25e87918820db4c548be5@kernel.org>
Date: Fri, 04 Sep 2026 08:29:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 05/13] drm/imx: dc: Add PRG support
In-Reply-To: <20260904-imx8-dc-prefetch-v6-5-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-5-26643e3f6cb7@nxp.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Conor
 Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Fabio Estevam" <festevam@gmail.com>, "Frank
 Li" <Frank.Li@nxp.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Vasut" <marek.vasut@mailbox.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Fri, 4 Sep 2026 15:54:55 +0800, Liu Ying wrote:
> Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
> prefetch engine.  It sits between a Display Prefetch Resolve
> Channel(DPRC) and a FetchUnit.  Add a platform driver to support
> the PRG.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
