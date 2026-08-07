Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09042C5AD05
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 22:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C7B89196;
	Fri,  7 Aug 2026 22:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iDcH522z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5A189196
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 22:58:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65FA940601;
 Fri,  7 Aug 2026 22:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850B1F00A3A;
 Fri,  7 Aug 2026 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786143519;
 bh=qgInBwua0KUqVGKuYZJWYzxoohAhBjTD4eh1gVZ7K0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iDcH522zJTzA2rzdF1COT9Mk3P+fOQfQx4rc7GU5PEwIbnvkM4P8DVTqv9Jj2rzCL
 SVNi1R/LH+2a6XUR9HD3jZXNO7XYQnBWqRWNgz8dngu/aVpjedIk886Hv/aOuSk/u6
 Lmtuj8UtavBqD5SpF1az/9X6Us2c4J6Acjb+hEQ8qwSywzFWKDNNm0uHBw96av3dXg
 tt0IheujypKLcoHNucMpdcSGTaUOL27nOAv11MxQ4osBJH5Ebktelqsgh3g/BYad4q
 BVOIIigxP2eCJaJRu2x6caoD18RbP54rBsyLQFO0fx5Q/gghubRfr0I2942249/oG5
 pcKp4SmXXKyoQ==
Date: Fri, 7 Aug 2026 17:58:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cody Kang <codykang.hk@gmail.com>
Cc: linux-clk@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Brian Masney <bmasney@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Haylen Chu <heylenay@4d2.org>,
 Yixun Lan <dlan@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-phy@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH RESEND 01/17] dt-bindings: display: spacemit: add K3
 Saturn DPU controller
Message-ID: <178614351779.2207398.16648513134637713806.robh@kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-1-6de34d80e86c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725-k3-display-v1-1-6de34d80e86c@gmail.com>
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


On Sat, 25 Jul 2026 00:51:10 -0400, Cody Kang wrote:
> Document the Saturn display processing unit found on the SpacemiT K3 SoC.
> The K3 instantiates two of them, one per display path. They share a
> compatible: an instance differs only in which register window, interrupt,
> clock and reset lines it takes.
> 
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> ---
>  .../display/spacemit/spacemit,k3-saturn-dpu.yaml   | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

