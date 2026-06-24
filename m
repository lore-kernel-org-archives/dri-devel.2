Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD91CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4845110EE48;
	Wed, 24 Jun 2026 09:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RuXE8ETs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B8410EE48
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:43:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99C5B44025;
 Wed, 24 Jun 2026 09:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A070A1F000E9;
 Wed, 24 Jun 2026 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782294196;
 bh=CmQBt7P2Kn0Io0KbERzB0bMS4Qfw0eQOzIjOmBYJhVE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RuXE8ETsiYdf/BYMy07f+nmvmgv5OeYMGl4o2FVqeg9X6ft3YXRusep8wyxM2rC+W
 llE2wP5bjOqvWPEpakRTgk9Drf4ZhW38ubz7DOZbIQkdi36GBVHMhxElH16M6AWWby
 q/UIbzfkf+qCpshD0jIGs5HkUNm7YgvNd8fBUxXDL50Xg6eQVucege54nFyRp3fNUA
 ZtSlG3K2mXFwNVQNTpsmiMZNOHRuyStj66JklCq6keN/zEgxJKGcpBpeFpcRj/cGoF
 ueM0gAXvK6VgpggwlnhUSV0VwSMGjWK2P5r5Ec8AzWctPbvYsaK1mWvFH4ChVfFqKk
 i5MppQzcYxCVQ==
Date: Wed, 24 Jun 2026 11:43:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, vigneshr@ti.com, 
 kristo@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
 thierry.reding@gmail.com, sam@ravnborg.org, leonardo.costa@toradex.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: display: panel-lvds: Add compatible for
 Opto Logic SCX1001511GGC49
Message-ID: <20260624-sociable-infrared-manatee-0e847a@quoll>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
 <20260623195741.495734-3-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623195741.495734-3-leoreis.costa@gmail.com>
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

On Tue, Jun 23, 2026 at 04:57:38PM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The Opto Logic SCX1001511GGC49 is a 10.1" WXGA (1280x800) TFT LCD LVDS
> panel.
> 
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

