Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694CFCCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C864C10E670;
	Sun, 18 Oct 2026 14:53:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E51810E2DC;
 Fri, 16 Oct 2026 15:12:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F41B601FF;
 Fri, 16 Oct 2026 15:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F291F000C4;
 Fri, 16 Oct 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792163561;
 bh=zExOvzSfNAOGhWyHayoCJYIMW12XGItswYYl/21/DBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HeXH2eNd0qTi1KJWMDpX2qurIIHfELGudDOFsBVj38SK5hgtwRmtRu++Y/B5kYqqd
 A4blc5Fp2xS9ugu94PJEByj6vIlDtKLwiWnVuaMsxRz0Ir4yLDMdWRBi4NsEDJfgYI
 dTCWHHQPHA4O4L72QOauM8WSJ4JjVCneqoIAwA1rVTR79Lh6W41DTt4LcokcrG/DS7
 QghFRktl0qmqBt0Q2454sV5etB2cRZSEkJVEe4jVB1iPvoqhJu/FGnl3nmWT7TfuCi
 kYiPGdYgWB0PP3fl0nc6yx6ZWW1MUxK7rfa2DXZnz9GRXCns4+n+2ph4Izy2R1nkwe
 CPOLN30xIOzMQ==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Aun-Ali Zaidi <admin@kodeit.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Peter Senna Tschudin <peter.senna@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yongbang Shi <shiyongbang@huawei.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Qianhai Wu <wuqianhai@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-renesas-soc@vger.kernel.org,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-sunxi@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org,
 Alexey Brodkin <abrodkin@synopsys.com>, Hans de Goede <hansg@kernel.org>,
 LiangCheng Wang <zaq14760@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Ruben Wauters <rubenru09@aol.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, Aditya Garg <aditya.garg@linux.dev>
Subject: Re: (subset) [PATCH 00/75] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Date: Fri, 16 Oct 2026 17:12:34 +0200
Message-ID: <179216354629.2387589.2597043397406887835.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Wed, 14 Oct 2026 19:26:23 +0200, Maxime Ripard wrote:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
> 
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[02/75] drm/adp: Switch to drm_atomic_helper_connector_create_state
        commit: db1de27aca30ebaad04aea74ac21e4c4fb531a37

Thanks!
Maxime
