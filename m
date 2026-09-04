Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1BEC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B4610F960;
	Fri,  4 Sep 2026 08:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ct1XKUY0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3F710F960
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:33:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DBF660211;
 Fri,  4 Sep 2026 08:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC4D1F00A3D;
 Fri,  4 Sep 2026 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510809;
 bh=j4UqJL4I9Plor9CtIHU2V1yjT48iQ2MyrKeeW7z58WM=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=ct1XKUY0fnuFX5eiw09xoWPGKZlBikbdz3lQhjp1a77+eGvhCFYjurrfgI21cJexD
 lpk9YpDb+U1yeFs5hwKRgXmPAEaS+d6bMtabxJEl12LTVbNH0K54I1H9z/h1iR3IZj
 ZAolGmtwAsLT0wfqHOQoy23izYnhQDgMnxbox1S1cnTUWz0EL37f5XAqkcSlLZISoI
 ex5US7EXLj0STQ1sGzJCNnG1Z75Hanw2pkeNDaWsAkNK3i0qBn/fHqHS1XicgFl4Fx
 Wul7A20YfeWNMtpcZfKWvl/Q7rL0uU+khJoRDudZ2d8Nq7Ptop/UvW46jjpM00zCNR
 CFhGUl+VDq+Yw==
Message-ID: <0d4f2e0275dbb7fd4db16f9e4393dad2@kernel.org>
Date: Fri, 04 Sep 2026 08:33:25 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 10/13] drm/imx: dc-ed: Drop initial source selection
In-Reply-To: <20260904-imx8-dc-prefetch-v6-10-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-10-26643e3f6cb7@nxp.com>
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

On Fri, 4 Sep 2026 15:55:00 +0800, Liu Ying wrote:
> It's unnecessary to set initial ExtDst source selection because KMS
> driver would do that when doing atomic commits.  Drop the selection.
> This is needed as a preparation for reading ExtDst source selection
> when trying to disable CRTC at boot in an upcoming commit.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
