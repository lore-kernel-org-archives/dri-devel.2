Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1E606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lJBOw5y4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC2710E0C3;
	Mon, 23 Nov 2026 09:52:17 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC3810E0C3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795427529;
 bh=Xkw/D1TF0uOO7465Srp/1BFoL/lm3YZD34LfqM34Yl0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lJBOw5y4IYTMTiPJX2XHz2/WDEVdkIiOiIpDZ5bjkoQ0lHjGzQzejtBQOcZab0vmu
 LqTlYUucKXq2dTUa09cY74RC153/xk2prktRMGbJVS6z6Jlj0rbcXgH67DIrT+ih2/
 RXoT2dNc8kgThWFTl//O6ERt10TQisQRa0Jv4QQOD822kSIZTm1f0r8zo8WV0DlUG0
 4IXzHr2m6EccGyPk7pDXjr7FYrKZCUzKGy/mKftWyH1NqR68mMFiOeRdpluISjujWk
 rS1U74e7wSo8CEVugNcD9Y4BnHqfIf4aLoOxwJrBCcg+4UnS3YSdGsUSTSM7XvhoHf
 c7zctaqvDSlNQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E661F17E007F;
 Mon, 23 Nov 2026 10:52:08 +0100 (CET)
Message-ID: <75c71ea0-e2e7-4709-abf1-e2b99a537c2c@collabora.com>
Date: Mon, 23 Nov 2026 10:52:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8167: Add DRM nodes for
 primary display path
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20261123085840.8687-1-l.scorcia@gmail.com>
 <20261123085840.8687-3-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261123085840.8687-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 09:57, Luca Leonardo Scorcia wrote:
> Add all the DRM nodes required to get DSI and DPI0 to work on MT8167 SoC.
> 
> The primary display pipeline is defined using an OF graph identical to the
> fixed fallback implemented in driver code to maintain compatibility with
> existing boards. Its block sequence is as follows:
> 
> OVL -> COLOR -> CCORR -> AAL -> GAMMA -> DITHER -> RDMA0 -> DSI
> 
> If a board wants to use the DPI0 display output the last connection should
> be overridden in the board DTS. As far as I know however there are no
> devices using the DPI0 display output.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

