Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02D7606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ii7PI4za
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA0510E1AF;
	Wed, 28 Oct 2026 07:52:12 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEA810E1AF
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 07:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd4iA2ymGDTHRFrleRbzuaB3USgFGlPX0wIqpesCjItLbj8Qp8XDioUl8RUCNvjXMofFWtXBxf+idcaOMKvElH3rjACofwiTRa6xlw1j+VxK0qkqYJwZ5WTBqyOqzViYTQ9fqckrOLGbVujdCPFWdJpyuAxiGK2cJY2mIlp5aQqvuge02VOTUvWkDWf4kaPpNGne4Txhf9vXpftS37hL558r8FiJ6zXbJv2A7nm6TqccQCrO0nn0zo02P0vFnZo4RxvWzLuIH//jYmb7KOc5j8YbJmky+uOo6tf7JfaKRJfIhsZ/vvktWw3C9d7Sfraqmqa43Q9JayiGj/mScGKNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsuwKVIF1ebTb4dUuGHz2l9nOKXqioejlPSI4z/e/kU=;
 b=SdMlmHMJOI3U1pmq/WhHLQ767i1cc35OcLzCNu+jejrZ6YuNVUYPsRab6Vb9YsGIxD14LY8NagCaGTqqruZQ6uGPI77i1DqTF2kNtLgvRkw2cw1AaMj6z6VSo8WT1TrIo3S1yQxCrD5V9E7lv5pwN3X+Zt/hyWvhV2vF16xdMqrQKQ2flFrZzXtg4q5fsvWZs/gkpaFY59XA2/o5Bf1Vhz6otZAPmlmW1Wfip2RFoj8m/ViGrJtFzGiiyCaWO3N8JjgWCPo1DRWfMS9/wY6OT05pepBHJS+Kyp9ZfND8ar/9WAjRhBKxtxTD4ISP7I8pqpGDRsRgbk0jv+VyuotmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsuwKVIF1ebTb4dUuGHz2l9nOKXqioejlPSI4z/e/kU=;
 b=Ii7PI4zacg2nMLM6iAe16seuSMPgjRg9SGXn7T16R8gzoplrru/d7fNfBGFH+IutoPzfP2ZR4qsvJou3uVsj16pUdCD5D5mGxUtdo9VG0rKlV/Lciq6koNFpObh8gINTrs8D7oXSoXx9MXmjK5Zs59yf+xuUvfiWmNjOi9EgO5/5qKbnkz9GhAUEUFm61YBHklxSPDKkdsz8Wt297TcJb93HPCq/ygNsSiSw9tYJ5Hh7pO5GW8T9GreJ7Qj6Nz8J+vNhvSs6jIFnpepm92VAyHvc1Zik4M+cKoLIODPA9M7gN3I+z8nirAafovrAxexWA07QI/LPqJkzYI9kgpZ8qA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB935183.eurprd04.prod.outlook.com
 (2603:10a6:150:399::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 07:51:55 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 07:51:54 +0000
Date: Wed, 28 Oct 2026 09:51:41 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Paul Cercueil <paul@crapouillou.net>,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Linus Walleij <linusw@kernel.org>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Alison Wang <alison.wang@nxp.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Igor Reznichenko <igor@reznichenko.net>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Jagan Teki <jagan@edgeble.ai>, Jianhua Lu <lujianhua000@gmail.com>, 
 Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 Joel Selvaraj <jo@jsfamily.in>, Icenowy Zheng <icenowy@aosc.io>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Tretter <m.tretter@pengutronix.de>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Junjie Cao <junjie.cao@linux.dev>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, Nickolay Goppen <setotau@mainlining.org>, 
 Stefan Mavrodiev <stefan@olimex.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Robert Chiras <robert.chiras@nxp.com>, 
 Alexander Koskovich <akoskovich@pm.me>, Markuss Broks <markuss.broks@gmail.com>,
 Artur Weber <aweber.kernel@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Yedaya Katsman <yedaya.ka@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 06/35] drm: mxsfb: use devm_drm_panel_bridge_add()
Message-ID: <auGpbUjcoN4TJjo-@vm>
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
 <20261026-drm-panel-funcs-v1-6-5e3070a3478f@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-drm-panel-funcs-v1-6-5e3070a3478f@oss.qualcomm.com>
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB935183:EE_
X-MS-Office365-Filtering-Correlation-Id: fb88a05e-b9f8-4ad0-f381-08df34c855aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BWrnoGfusvwyecOeHqqjOyytboGPQ7IqZlWQd2vskG8AagsvMwbFe57bQTT5Hs4CAvfaBI+o8iQgRHU47oYYJRXqUjln1KLXzZuDHYTkow0nbDGVJypMA4GtUnY/By9zRPe3UQE75HL45bMtXbVl+qjhpdCZH8fXqj3YjgwvhDo5xgRwv4WIx430ODOwg/H2ptId7zO2oTOG074U0osAiKUcRbZAJHSeBio7VtOgXhC9dyST17jjoimOIxQz6vEE0qPXyDc+I9b+WIIvNsOSCboslhCsrnBkfwLiuIcik/cDh/SeBHTkOxPj9vQLE+do6+SKMWvHSbbDG1ZdC93Qvi8Aszwq8gdtayzyEVPY5BJhIJGnaRVVjwcbmKQbX7ymYWg11MebjgJpqXYGKJYBSVRdvPHjiwalrYv2rm5E+zwsi2dDigkSRh+5+3NuM3SEBciNSoDb2cWtvPGa2Ls/ViFGtEeEi+uHObIMrAWnT6377+IFm0OQt7Jb2v2PZGZz1TGNozd2vEXOBux3VgfIIx/jb99Yc5lcztMLK+v9FMDJ4BBeiYrUkeLbsTprbL6GtrYqM1LxXX60ciAvnO24ZY9MJehzw4RxMEV3TNjXMqS6aos1xPGt5/EzkRdxN/yxSfBVhiIpZqZk1JJeZGv8kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/FInqondirwU5R8Iqk7oIDFncReLZ0YQVIdYDmo3aGf7xDyhMm3BN7RX9RWT?=
 =?us-ascii?Q?9ZGm3arN2eBtAgln9OINjQCfTot2SQTgKNFTscI1rFam/Zai+pe8OMwspGJn?=
 =?us-ascii?Q?mRwRXi9e2tOxUXhuvb43u5yJ+85cDHP5cyMI5eqM6jUb+SeftBdYTshvVO2Q?=
 =?us-ascii?Q?IOydtHpnz7266+C5T0KD+PFwq50jcg3i4puJy++EShjira5o3BI+ehG/fwae?=
 =?us-ascii?Q?HXMyyqKphZlomoIXXYKJNVywQgzrx0D9k2L3BvdMB6JXU7kKq4YyQP8Ib5Z2?=
 =?us-ascii?Q?Ebe11jHF579pdCnScfOswyL8Qt+5QX1wydYBxfmyXHrBesn1thNWmlVOlrRg?=
 =?us-ascii?Q?ABY/Ty7uLpwl57sdbm0DV+SGieVMsWz3/moPfMGM6/mLvo6eBHH+mwY7sIhx?=
 =?us-ascii?Q?1GxsaCO0T0PgHJC6O3lmIa25JUWJYfI90GvUrmtWzC98PphirfBWuvCQDeK6?=
 =?us-ascii?Q?bRfYYmzur2vSbuKObPJIG5H2X29aOnQokLYPHq7GlHq7OXm2C3NFyl2GnlAs?=
 =?us-ascii?Q?F/11QUF/j9TBIDBR52lsTfWlt1TxYPyKPqQbo+IFgfSE6FmNH/v1rgFEE/n3?=
 =?us-ascii?Q?0OMFwIMWQ0z9IAozww/zis2RP6XStv2uBuTT1VsPz23CerDV1PpUtPQL0zDO?=
 =?us-ascii?Q?Hc+MitdD+PL0kx3sqUTW13MH24XQ2HyFXUWhIam8+6AUUTIaWo+S8hvzKL6X?=
 =?us-ascii?Q?YVBy1f1SnKRSKQzIAGYDp7uQfbxkvzdXWrHcLtZJMyzX/eJN5+zQCYLpX8Ex?=
 =?us-ascii?Q?1Sj/SjlAvTyc5mqQvtVRxpocPskcDmT4wmg6jqxPlK2f0ixXp7sjqtKk7VcA?=
 =?us-ascii?Q?b6UswPIpQY4AlU3nvSYtqAIXY2fClHXODvxpFE4VtzWcjZnmP0vovur2psm/?=
 =?us-ascii?Q?1k962tK7NkWhPhlckOGChP681CSN5sUKB4hRUgzikp0LKIoc8CtEunrMbAuT?=
 =?us-ascii?Q?tG2g+ZsMWw6RRzQ+LYHDEStCmGrgcfrwCaREg9bYAw2CHGyNmVi870lz4VL0?=
 =?us-ascii?Q?lRmv7aip1pHCu0CqQTshXEXlEi4Pp/XABv0WGiLMkH7XcRVT5eYBRtrG3tRv?=
 =?us-ascii?Q?V/SGWjr8XFdxojewzdfNLGQvZSgLRL7WLW8OuQOGzvlSh/BT9FZrttxqDTkI?=
 =?us-ascii?Q?x+u9pZR+IHUqi2oXBDSxoSZN1VW5bmPti+SevlXrH/VOBBntkQ9OeAVgzZbq?=
 =?us-ascii?Q?2NphbPOgoV3W0FyjBtD/t0ImAGY7dt9msLfi9M3fqAku8KGHQxNwzsS2jipq?=
 =?us-ascii?Q?uSVPvYoAijS76Jsk+a5o0A8NsdDq/zkuIl/wXkerKpi/D+v/i/uhlQ2kVqGR?=
 =?us-ascii?Q?Jdgm1Rwfuhch63Pcefq4eR5hfsxelELqHG865GmbL4yBbEF4MBCHFQ10Zcd2?=
 =?us-ascii?Q?GqgQwmPxzvMy0cx/CvgrbLsFhwXgDLuotNx3NO/OE5BzWECtv/PnOzs8ASCJ?=
 =?us-ascii?Q?3RxKGnf9bsLX+77HWe2wwRp5wVoRKj9HpLD2cAcHpEj1gMYy1N5yexnosK82?=
 =?us-ascii?Q?GtBnuBuzL1iZBxh1i4mBC/EEXxDcF8t27JcRF0KewxyqTPo4H7e58dSxL/Sv?=
 =?us-ascii?Q?lxB+Jc8jfTIzzyZU9YR0EP4HV8wRAnBIjJg4GgOB4kM4qUxjTNkDumqmj2/e?=
 =?us-ascii?Q?p6zFdI1T8j/wSSGib5sgB4+4HtkVdoJ3K3WZj2kTCvOuCQi5/h+1D4iwql5v?=
 =?us-ascii?Q?6L1Fw86B0qxtayMHrL6HxEsyvEIJWScp/xuanegVdkWtHC+LEavYy4jrA2us?=
 =?us-ascii?Q?OakscDy0iO4dcUfB5+RctZ38BDxTpu0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb88a05e-b9f8-4ad0-f381-08df34c855aa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:51:54.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQRH47YLK5JuH+5MlpRmQUogWeB4VMx+hyWrPkQmPVWcT3aEz2UO8XrY3HkVD5cx2UGSMSENZm2PQLxJtWqxxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB935183
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:09:55PM +0200, Dmitry Baryshkov wrote:
> The connector type passed to devm_drm_panel_bridge_add_typed() has been
> ignored since commit b7797081ccfe ("drm/panel: embed a drm_bridge into
> every drm_panel"), the bridge always has the type of the panel.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
