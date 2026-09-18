Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB195C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED86D10E2F6;
	Fri, 18 Sep 2026 21:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SoYhzv4M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB7810E256
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33CC6414B6;
 Fri, 18 Sep 2026 21:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E41F000FF;
 Fri, 18 Sep 2026 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789768481;
 bh=/IGcE4Un2wpGwr+Z93YjNPv1ak5DqpFH5SF0r5Kz4u4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SoYhzv4MR+LTYbfzms3XsI8GodI9iCPYHDPP3hYul5Vik7dq0ofmBKiKefD4dwCUj
 x/OXVoDxa7t8NFm7rv4RX1Ukw71y2ADjm6eNDmiI3vjC7twgMQF1B7nWGbXYJFW8wt
 GKIHYZRHTAb992YnyiDqYmzBI3+n/z6f6yULrAbPa1Ek4Otc0MbxL9cDJsF0/1OV29
 gCjU5VL0nBHG7I3IDxn82PvzPqnolCnL94ZB9pbHcadrd9ViqRlWW/Kcdvez7BJlrs
 5DT5FSyNsrCBWnig4Wu87TtH8uv1wfJkSu1qvVpicxu2gRJCPwK5gkV5KYqJD1zvMM
 t4em0p4kCubgQ==
Date: Fri, 18 Sep 2026 16:54:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, linux-pm@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 12/20] dt-bindings: watchdog: arm, twd-wdt: Allow power
 domains
Message-ID: <178976847923.2411948.11909002578336297742.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>
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


On Mon, 14 Sep 2026 13:54:40 +0200, Linus Walleij wrote:
> Allow TWD watchdog nodes to reference their power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

