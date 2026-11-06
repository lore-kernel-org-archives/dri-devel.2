Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C0606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=MvZy8n9x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2E710E9F7;
	Fri,  6 Nov 2026 12:28:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCB710E9F7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=jVC/KGcJa8KGWOEH6o3QL+JqNyke1bKdIxAB7WhcXLM=; b=MvZy8n9xEqEqYJPTSiNa33GzYA
 PRizDDcL7Eb6Xmc8IweGoWlaUFYeh01I+SXYW2j5tB+7YpQ7tM2IPjrICskL0KVL4ciytYsTehMEP
 CvJtfT74M7ANKLOzW9s/oCLVCF3yvHMdPR4CmsEO5BGVPd9nQYW+JBtBNWyxYGfdDlT0O5znFAzKw
 7LCD1LXSTFL449brmOdjKcNyrKaBOnaGOyVLFM1FnskypGfi0ibESYfyNSE1CUw3qeDTkpRh04uNd
 0J4dsJYbI+lDOHWj9VCXFjlY42ExlibPxz81yvpNcgx96N/PT9orMHl10BHYbHjErvhDEUho2qPSM
 wu/IeWlQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Stone <daniels@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit
 YUV420 color format on DW HDMI QP
Date: Fri,  6 Nov 2026 13:28:37 +0100
Message-ID: <179396811444.1260748.9451141898652783370.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 05 Nov 2026 03:00:34 +0200, Cristian Ciocaltea wrote:
> This series extends the output color format support of the Rockchip DW
> HDMI QP controller to cover 10-bit YUV 4:2:2 and 8/10-bit YUV 4:2:0.
> 
> Patches 1, 7 & 15 improve VOP2 robustness on RK3588, helping recover
> from exceptions and preventing random display output glitches observed
> when switching modes that also change the color format, e.g. from RGB to
> YUV 4:2:0 and vice versa.
> 
> [...]

Applied, thanks!

[15/15] arm64: dts: rockchip: Add RK3588 VOP2 resets
        commit: f245313cd545f58dbb777fcfc6aaf33376e25c0a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
