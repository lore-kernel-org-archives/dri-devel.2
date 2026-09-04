Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704FCC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7AB10F95D;
	Fri,  4 Sep 2026 08:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bpf/CL+m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4BC10F95D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:32:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 713DC43716;
 Fri,  4 Sep 2026 08:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDF91F00A3D;
 Fri,  4 Sep 2026 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510770;
 bh=AQO2yLCuvyyjb9kwnOf42UURUHWUmykZv1MVLPFfndU=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Bpf/CL+mJpaJzRAHF4YSGGkjyZT3Tgm8ZZ00BZVxvd300hDOS32rnJUr4NJxPZKgQ
 lWn0O9g9v9ZvzRWkIHkwQuLcbOq/Iczn1VyoAO2eL7q54UsTiHcT8rXKLUAA0aBAQr
 em3QLSDP4uArMdwvMQWXZ0MfTWHp4KXTY/GGVdVAsByHIhm2rzYBhpi9yU2NQPgtnt
 QYCi5Gb4vQCjjrGu9ouZCOkRUlR6JvvmDrNqOvg81ov29WM+qI5Atuc3zNmCY7gVM0
 P8St61CwKFdyqIUJjbkfWlhTfehweZ+aUyF9BbPip2GRJKKQh5qBMt4hZMazS0+7uQ
 NuvgHLm3SyvUA==
Message-ID: <c25980ef93153c0edc6c5bd73e2e2a6a@kernel.org>
Date: Fri, 04 Sep 2026 08:32:47 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 08/13] drm/imx: dc-ed: Support getting source selection
In-Reply-To: <20260904-imx8-dc-prefetch-v6-8-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-8-26643e3f6cb7@nxp.com>
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

On Fri, 4 Sep 2026 15:54:58 +0800, Liu Ying wrote:
> Add a helper to get ExtDst source selection.  This is needed by
> disabling CRTC at boot in an upcoming commit which tries to get
> the source selection.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
