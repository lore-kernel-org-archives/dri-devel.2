Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=izXGW7YM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5CC11266A;
	Fri, 30 Oct 2026 06:59:48 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4787411266A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgUDo7/xZJBLgESW1nYl0zz+QdY+TPEZsLpo/YiQYRsoVPujiw58WEiXzL19J1VhHZDtQIpXZwyLSTDRjL3bbc6RTkscGx1yRK2kcCdx5L8BX/UhXT9HEd+OtvLKFe+asyK11Fs56AdV2MCSQnDsUvL3KpgcWuBi5CHHO67zpVPXRhZTaUDR+Hi8Pznekfi/69mOU2z58wOUmfqF/Y6K2H7RqbwUKdEOvrwNahIfAjdEn5j+zUr/BPxWyvB/VQtwiBbcNpxtynYoR7i/qqkGdr9Saov+23M+FEC3942l7ZgQ/cq0uSa8p1TR8qxgxrv5v+15UKG1Pg0SvrKeDjLJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM67aKZa2k2c6bKq+gBbl3F1MAGEAQchHa0lPFGtDy8=;
 b=VY58Dl9m+yKtY1d9BS73IjJxQ9ST8Fbo7NDRFwinwsdW0GCAy+SC6IEHBodJnydAcCo88y3wcDdEu/ogBkbFJij1K7YbfTSHe9CVIWdswZMsHnvjL5TJf6p4065aXaLNr4K57SfVzGHzIYMWJ38KLt/6ie5OSlV7mIqAz8wb4iFhPVE/LnM4VzXny+CgWVdnbDDhuYHSfzf0Der11EpN8DaH08r+1LpMhvonJEvx4yNqOnfpTNKwcfUujnB0RS8lVfWCjuUSnPJrWWxymM82nHnrTWNouchay0rkuCnlJPt8HiSPJZhXM0AwLR2+hjsXPW+YzsR2QiRgbmul0J4F7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM67aKZa2k2c6bKq+gBbl3F1MAGEAQchHa0lPFGtDy8=;
 b=izXGW7YM16KyQ9YvUM9Zgaye43hmLqqXvJtd7hVpHj9aNvhSYm9nxVFiC7XCA1E6jLfjYPTxbgPOYCPs8iJxEMm6hmiaF4chcfAS2Y2al+4xNgUZXE49Lk5YturtMURBOiWaBDsRzlL0yLT8yHFMugTx44jerIPSff+DGc8GqJN5u4WfyR0noTZKqLcB/5ccHSCwfEdlyhvGVq+nj/57f8wlLyHQnXZ0WIQ2jwWbZcDa0/qMQckVSFtO071MTnCd4GG7zULKrQYZs+fD2K1Z6LiJq2QGFD3Rl4b2xbYnVC/O3nuFaPrjbm077j6woPCrKuoFTvgNn24+j6dOoKFpVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS8PR04MB8561.eurprd04.prod.outlook.com (2603:10a6:20b:420::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:59:38 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 06:59:38 +0000
Date: Fri, 30 Oct 2026 15:01:15 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 06/15] drm/imx: dc-crtc: Disable at boot
Message-ID: <auRAu8P3JDfSV7Sh@raspi>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-6-a0b50cc4fc65@nxp.com>
 <auH8X0tITcU72fk5@vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auH8X0tITcU72fk5@vm>
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS8PR04MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffa6725-6a7d-412a-7c7a-08df36535cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|19092799006|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZpzPkgIzuDwRuqMwx76dtHetOqSXl73p1M2tbpr2BH0NbfyQTyYjiYoEroUU2ZbsbgTc3OBAQm6sAAcFsXNPniA9OJxG3l4/9kPqCrUjHM7SdAKtqEpwkUNl5hGYSgZTx5TO8Mk18bJ90dCrO/f2r2UZ+DLMOtNw1aChdUV0r5s70rOE+9MgI7VOlRM3EXVOE72PN8v2AQKANzAdXtwLQDDS/IKD78fJOLm72unTei4kn5sInIjVFUVeGvo3iEGh8dVy/QKl1E+d1CoI09vHweD501hKkKmWoRAniYppfNaV9yFbtPMA7B9bq+nDor7AkQNzi3yAnFOEiBO1OvtB5CbsyivSNFrPOGw5JfKP1YQb3NfShdxxeseMVS5iPf2+umm8SPn/7TvEX9U4+0/J8RPM44Q8L7p90YQP2xTFUe+KP+qrpnyq5YVOIJmPkcFz6FsjlqpQIwuQFPrlFNlZDJA36Pe2iaIBNmsHQLg7uL5NqsVYQ5wz16Y5OeJcfUpIwmN/YKGavTEwwyNxkk4tkNKy/WywlJ3F5R1w+rhLPBsUTLhKzsLxQP/PfROmOJSOgcx1n3Ht6rvRYIqVuoklV92qSr7b5QFX/x/LP8nf/4jnP4mzKLztexZvnWsYNxCCfOJj4chCgX3UVqW4REVRBvGU731LvGdnOnoCHYD36Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(19092799006)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LaVzPSQyzO4RtfUXS0bIPfnYi8sy3wGRKZDW22g+bK/rCKyu5WT/+JbmUiTI?=
 =?us-ascii?Q?4dt1ngs8mW+dqeDLgJwQCG6yVClx7I2Km4d64faF3FZlbRAtj39VU7zAOMoF?=
 =?us-ascii?Q?S8NHkmoH4uqO/Iu5vthW/yYVXnlYGw0MXws3N+1e+gmni9vJeK9IamagkwLb?=
 =?us-ascii?Q?iJ1uXW690Ukslca6l5dJIpyh/vMWpApWhls8OhZi8hUEMk50P7nf2h95RUV6?=
 =?us-ascii?Q?Z7x/rdUoRflXeipiJ/TjryksfxIVm9Yrw9CJ1ETkLnMmPqKkr91WFFuxM/1H?=
 =?us-ascii?Q?mHYs5jWkpSFWib8yJrb05PVtUUJ2fGm3OPMX/zjBpiD3gfom4NjeYDibRZJ2?=
 =?us-ascii?Q?fhJ8boZk9lLhxvi/VmyLTCKGMnYT2wEh+nKs42bpsI6VIo7OggXW+O5lZxhE?=
 =?us-ascii?Q?jyVx5GCp1Idgme46dGyVNJY2DyLA1FeoumiCj+rK2ihF+dUV746CY+7+5GLQ?=
 =?us-ascii?Q?5NCSjZNmrwK/tz2ISh/LZXJImnO+4uquUuERyeH2KjCO+U21JQBMH0iJ0N6L?=
 =?us-ascii?Q?GqCiRjm3eKz3kUEntKkr4nNBQ9FCE1eiqc3vVvqIqUIfvYcxdvUD8vq+eZLC?=
 =?us-ascii?Q?7hnF8EAtXsXksD1/XxarzaI21BQF7vC9+VgHhr06TfPfwqqaEGYFUAEHq+dO?=
 =?us-ascii?Q?qywTbPjGbl/ADni1GeXWkcKuLDw17I5yFA/8eKD8pVSiBttSNQpTsLw+ZtEo?=
 =?us-ascii?Q?znSgBesrmziTxgZyO99VarrAWTWDHadHQXzEF/WgfAAUu87+pQVghB4B2Uzx?=
 =?us-ascii?Q?Gl3Qc+ZoxC/Hq+7+tqafTQ3I/u3gkUleNoFkTVYL00F9uGh7YlonfMxKJfkB?=
 =?us-ascii?Q?xxUbqfLBOTvwugc5FPZoXkVTFz0v7mWtWosIngx5gVq8kXMAydFUa+faR5tW?=
 =?us-ascii?Q?yFp65sRcFAoAtDdlB7T+QJbDVK6IB4KtzFd4qp/reYbEuTmwCgcgRefgKhN3?=
 =?us-ascii?Q?wa5rOpAuf/xujpRWCLH+dk4lJ/B9y3jUwtbIJxE3ZzJEWm5HjOspKB4YKmT9?=
 =?us-ascii?Q?ujN5kNi1g8+blWZyHECJbgl09OQFatVeWlUBjVTnrL/R+3N95VlrwaI+JTlb?=
 =?us-ascii?Q?YkPC1mInt2G1CIZ6HqdtNGrlGWWcc6/sBuV69L20+wgW2L1ueCvB4pZy7MeH?=
 =?us-ascii?Q?11KyBaLRfHDbra4t4j71ZCJlyW1RgRacuF3hC8JIrNCS21SNP6V1icNx40xI?=
 =?us-ascii?Q?gfFKvt6vOmtsC2643yFtwqSjhV5WvGo2+gV8IWs+BU8bQNm/cZGIP9aMYLkD?=
 =?us-ascii?Q?JZB2mB+YVO687QWNYtRTh9zsxSBFdh+BGMwa/EIXSIlbVl+yO1qFCiy4FItJ?=
 =?us-ascii?Q?OFRwejL6qmW1dCXqRucqJfLZOOJXUUJAoXWaG0hQbYy0ggK6dQHngRk8++Ww?=
 =?us-ascii?Q?YGapudFVuhWnVeFTosM0Umz+zvtu7d+OE+pZCOGrIjjnvnmSCvBJbaE0sZt6?=
 =?us-ascii?Q?1aa+2tc9EhFjee5RCzNexe5IdHBf/a9WAFvgdqs0bsOlp4Vz2b3x2da1Ct0x?=
 =?us-ascii?Q?BI6R3LkITulylUHyjYhbpQ9AFoSeHn65vw3AQIlgJ33La0sTzvOcptX3w7En?=
 =?us-ascii?Q?88wX9sbIMSaENmaMCrnUh7wlvz6o4v5rcGfPC0yQapZ2w/TtmRWNJZNVJnU5?=
 =?us-ascii?Q?Nleexiy6ZE+MUzFfZdNjWLHoao30wlm8NaHfuP/dwiX5xNmFQ0QYVSDTkyyM?=
 =?us-ascii?Q?cOq/quLUlfyZAp6M/YIEbjV+nM8RJg57/Q2/m7N+Sd3SMRizA3N8lrtULnJN?=
 =?us-ascii?Q?zZQuXidj5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffa6725-6a7d-412a-7c7a-08df36535cef
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:59:37.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xibwtnVSCEPJECvmDMjrgbgTfSl7QLuLFXsmVmqE3w/RQb4FI9Euodl5l2LgHwCG8kvvbRronut3M1PwQOMGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8561
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:30:06AM +0200, Laurentiu Palcu wrote:
> On Mon, Oct 26, 2026 at 06:05:11PM +0800, Liu Ying wrote:

[...]

> > +void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> 
> Shouldn't this function return int in order to propagate a potential error to
> dc_drm_bind()? For example, if pm_runtime_resume_and_get() fails, or frame
> index isn't moving, wouldn't it be better for dc_drm_bind() to fail as well?

Will make it return an integer.

-- 
Regards,
Liu Ying
