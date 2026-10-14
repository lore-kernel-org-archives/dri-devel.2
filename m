Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065BCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A8010E180;
	Wed, 14 Oct 2026 15:13:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194CF10FDF0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:13:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0796460A55;
 Wed, 14 Oct 2026 15:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CD91F000C4;
 Wed, 14 Oct 2026 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791990814;
 bh=FrxFkPouUX7J3dMs9YlY5xB8iQroELxdLCqQHW3LfOE=;
 h=From:To:In-Reply-To:References:Subject:Date;
 b=cHey9sg3+lCHoFj3hr892jH7v1xEtX8s45Jd4Peda4EfEj3TF+L1dZ/H6E4mIwH7r
 Ru0ioyPouP4MjXVUalSHHJnTnpO9vVR7yyNctjxl+3QY3YSmEqa6E/m9RAW335bape
 vQe97ZDe6b+/yden86dQFgI1q5lS34Y6I3bHT8oTg0HvQ+V2ReIFg4tjOdUNAlq2gU
 YJkv9stjN9n5ihsv7XcoAlD+BaJzugbAMAv9UPINeJU0gvHoD/oOGPicCBkGVy77Ix
 XYqsTCVizQzwA2fBADd7zDb4bJCHwHGn/rp69ZAdf3zG0U+Vd80qkKruLQ9+Lgef3x
 pWyX1HmmWjUlQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Artur Weber <aweber.kernel@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Aleksandrs Vinarskis <alex@vinarskis.com>, Andrew Davis <afd@ti.com>, 
 Steffen Trumtrar <kernel@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260913123301.100129-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913123301.100129-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH] dt-bindings: leds: Use consistent indentation
 in the example
Message-Id: <179199081109.1187066.13808287583904986298.b4-ty@b4>
Date: Wed, 14 Oct 2026 16:13:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Sun, 13 Sep 2026 14:33:02 +0200, Krzysztof Kozlowski wrote:
> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.

Applied, thanks!

[1/1] dt-bindings: leds: Use consistent indentation in the example
      commit: dc8aec7428160492252267cbc0f78b889f7cae01

--
Lee Jones [李琼斯]

