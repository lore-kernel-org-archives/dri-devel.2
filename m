Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F73606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=uXdcXHCN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A0510E431;
	Fri, 27 Nov 2026 16:53:29 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE33210E431
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:53:22 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261127165320euoutp024c5fcdfeb78bcc21adbc48f75c3ca089~r9SFz3d-_1155811558euoutp024;
 Fri, 27 Nov 2026 16:53:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261127165320euoutp024c5fcdfeb78bcc21adbc48f75c3ca089~r9SFz3d-_1155811558euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795798400;
 bh=7eCRdkskUVIKAV4F73pc7bqV887F0lnrxukv66qVTv4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=uXdcXHCNDgUvKYjGzs4I6Y/LbSNrmKUYF/1I7VJEdq5FMAsBOJnK/421qd1tvZBCH
 LhDrXlSqopL/8bPiDI3uNpIQZPrPJqWZ8PpjEnUggYOoykHsf67rgoaMckrVXdQB0r
 q/UFtioXKgOj9nRw/8+BsmCSOkgieKfI3SQj27S8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261127165320eucas1p2d67ab9f6e81486993b7490f3746c914c~r9SFgBiTE0677506775eucas1p22;
 Fri, 27 Nov 2026 16:53:20 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261127165318eusmtip137bf72803c990386bb415f5deb6f1ddb~r9SDzrCr51687116871eusmtip1Y;
 Fri, 27 Nov 2026 16:53:18 +0000 (GMT)
Message-ID: <eb7ec558-7f5e-4fa6-b8de-db99c0b56467@samsung.com>
Date: Fri, 27 Nov 2026 17:53:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] drm: starfive: jh7110: Enable display subsystem
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Yakir Yang
 <kuankuan.y@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
 William Qiu <william.qiu@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>, Manivannan
 Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Byron Stanoszek <gandalf@winds.org>,
 Owen O'Hehir <oo.hehir@gmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261127165320eucas1p2d67ab9f6e81486993b7490f3746c914c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155359eucas1p2f7d4e5137f38415561ce77fd55023466
X-EPHeader: CA
X-CMS-RootMailID: 20261124155359eucas1p2f7d4e5137f38415561ce77fd55023466
References: <CGME20261124155359eucas1p2f7d4e5137f38415561ce77fd55023466@eucas1p2.samsung.com>
 <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/26 16:52, Michal Wilczynski wrote:
> This series enables the display subsystem on the StarFive JH7110.
> 
> Merging: everything except the DT patch goes through drm-misc:
> 
>   drm-misc                     1-16, 18
>     drivers/gpu/drm/bridge/, include/drm/bridge/, the display bindings,
>     and, as Conor asked, the StarFive SoC drivers and bindings (patches
>     4-6, 14 and 15, which carry his Acked-by), since the display
>     bindings and drivers belong together. Patches 1 and 2 are inno-hdmi
>     fixes with Fixes: tags; they apply to Rockchip as much as to StarFive
>     and are independent of the rest, so they can go on their own.
> 
>   Conor's tree                 17
>     The DT patch is included for review and testing only. As Conor
>     asked, I will resend it to him on its own once the rest is applied.
> 

Hi,
Patches 1 and 2 are now in a separate series with a third inno hdmi
fix, so they can be applied on their own merit [1].

v9 will drop them.

[1] - https://lore.kernel.org/all/20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com/

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
