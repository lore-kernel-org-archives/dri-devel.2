Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED957CD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5592E10E666;
	Fri, 22 May 2026 06:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HECtbDQV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDFF10E666
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:55:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 780FF438E3;
 Fri, 22 May 2026 06:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE28A1F000E9;
 Fri, 22 May 2026 06:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779432915;
 bh=PoaYTpOtS/f83LSZSUS371YpKZ7Va1WFwiD79VpLxU8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HECtbDQVIxKupYOYPtJ9nH5KpRerCWP9jZT6Z0tI2nxzCe0ssvS4EbeIrd7Vk0fu/
 ssnOF1WHE+xRA/dcBJNI1coWs91fN3yZfSTRMdfMzzRVJ1+JujNd+gnHwOz1KezRBq
 9unUp/HHECrB8zDvoRyl+S94rc6gUMQo6+eju+fm0rVePR3EAxVFvDexmztyeGNxWK
 IjBDtXfA5SRdvQ2IJlSMQIpMz65DsntubMq/DIUcmGOzA6/JSHBWisndMh1a/Z/LQD
 hwojgvvbXTFowz99CyUMRy5FKJxnYIh7xYPImQJFQRs5kw+qI2sJBIP6M7SVXbWDVm
 8GzuYxJJR/HdA==
Date: Fri, 22 May 2026 08:55:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vitor Soares <vitor.soares@toradex.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 13/15] dt-bindings: display: panel-lvds: Add
 dual-channel LVDS support
Message-ID: <20260522-vehement-kangaroo-of-penetration-de8d99@quoll>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-30-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-30-ivitro@gmail.com>
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

On Thu, May 21, 2026 at 04:00:49PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The panel-lvds binding only supports single-channel panels.

On purpose, no?

> Extend it to support dual-channel LVDS panels by referencing the
> lvds-dual-ports schema when a ports container is present.

You now changed existing panels to dual channel.

> 
> Assisted-by: Claude:claude-sonnet-4.6

Using assisted by is not permission to send us unreviewed code.

Best regards,
Krzysztof

