Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F431606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUf3NrwC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4E010ED07;
	Mon, 23 Nov 2026 11:17:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFD610ED07
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:17:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9DE5433A7;
 Mon, 23 Nov 2026 11:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7A71F000C0;
 Mon, 23 Nov 2026 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795432660;
 bh=wRknIvw0cLKTwtOeyMRq4oTgIEAc2aw6LoyAAqqSPKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bUf3NrwCLmq3AIfOM8M78iR/drgzopuAxa4sfnY8YUB9SYYqVN43asRwyLpy4IxmI
 L5kNbrU8B3NVUq+UmV1nKnUlq4oDnzchEcye8BB69MKL/PjarZdSb5Am+lYimh9bOS
 S7gXP2wd1VgHQRSQ7o18Bg3W4sqFx4jtYgDABv2bmzpbUScPSqyR+YOkB2cpJ02jsr
 oj+Z8kIIJgOdrRTQyyW7YU5ZDvnobD/690NEzUN2aWB+/ri671whZnXftbMGuy2fLK
 iLt4ikr5cUYwjv6QllZpH5oCDpi6sRPkbfieLTqwbH3kk+uujhfL8A+EUQZAq4BDfm
 ItsxFJlC8b3MA==
Date: Mon, 23 Nov 2026 12:17:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Mahadevan P <mahadevan.p@oss.qualcomm.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: Add Parade PS195
Message-ID: <20261123-meek-salamander-of-abracadabra-3cfcbc@quoll>
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
 <20261116-mahua-hdmi-v2-1-0b5af6bf9e70@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-mahua-hdmi-v2-1-0b5af6bf9e70@oss.qualcomm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 05:04:04PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add bindings for the Parade PS195 DisplayPort to HDMI bridge, describing
> its power supplies, optional reset GPIO and display ports.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/bridge/parade,ps195.yaml      | 111 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 ++
>  2 files changed, 117 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

