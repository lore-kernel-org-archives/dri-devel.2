Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F37106B506
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEC610E7F2;
	Wed, 25 Mar 2026 11:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EiQ7QhjI";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861F710E228;
 Wed, 25 Mar 2026 11:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE7KrCvPNjlIMWriz+VIv8px5Zv75wKeteSvNoiD1JNwqJZCCNAL/fGJpCamcJb1hrzBXUTvqeW2FkydfIHQ9GO/uGcBI09mwHkr1XsupGP5yx9f+JEtUaEdRN4CaEMzoufNO18qReVDJlBJyItsGliu+UnKSIbSXIJ0F3XVK96Mfa/bPBsJpMH/FnPHhPsIHnBuDLyZgdmYFr+RNBqvI71db8CxKmr7rLYOknvbJY/DF5C5Epf1PSnD7uVqVYUNh5JH5HFCQnbq8XD2jyuerMg2hMKHU9ddlb/6lE3YDd5HjLNzc+kfc6FJG47JKMjtaSZLdMev0rwt33qufikD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmFCg14aIOrsp9YqHLUFfcdR0ddKLw/xENfR7EBqn6E=;
 b=i7kTE0umVr+uCpwQqcnIRdaOdf3f/PqhAvfFxHaq4zC3hEwenlNYJaGtzunVqzH2PEIrXUnTbFlFOr82PebS6T8zCMztFjqKVoB6s+A3s59Whvl6vF2Xybmze8aBrahOmHKdNVeHyJeZNo/MH/sDgsovCGbXSb3eAi2OJ0wxz855fw0XgjdWjIe9b3XWuLbqNK69qpPzLtjoFU9WFcwfCVtqgfTBj+81Ml+/msQUHL2frhVw4xW7UJwTgL4WrnF5u6sMKNUOuxlf9wb8Bct0HQUgtKhV5A2CW9ssv7Ts79GMo95HWaz69CNDfhglkuPzSfRUp6T8uMfbM1dYfk3ycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmFCg14aIOrsp9YqHLUFfcdR0ddKLw/xENfR7EBqn6E=;
 b=EiQ7QhjIGBHWTNJZ3cM1+8bBO5nUKPFALiWY3ExVWmQl1Z7nKof0hVZUQ1axTkUO8pPt3GdJeaPdsosBGwemsTsGXfogZaT8wZLOSKFrLwHPki5kFkkwHrNrhIGnBauHQErH6LSjeVCmDJA4+jgkaNO03zQa4JlF1j977w9LXVuRXhtn7/xdPbTyxyeXyc0fcQAtcnth6UV2LAK0nWD/TINg1+b3YRfL32iQjDk8mHN9Xov9+Mb4aLRkpdYWQGhgoBJDcwEw6G8JqQe7asnopkAHXAMD607I5gIZaaY9lPq6ok9zIC2c/ixTIEIx5wTprcVvGdXiOKLCNhugPNwdnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:57:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:57:36 +0000
Date: Wed, 25 Mar 2026 13:57:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <20260325115731.genmq2yew2p4dvbs@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
 <20260325114309.3k7xkfrffpxp5xq4@skbuf>
 <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM8PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e1f118-c396-4740-51c6-08de8a65b4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|19092799006|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IoZA7Yrlz/oL4780ip4y5mVba2IlYCaP6Smft6r2tF7zhyQ7Cvo0NHk4wVtd1gAgQ7Ft5awHf+JddSAiQPJPvnF5AayEEG7iS62dizV5bBzYxVGEMrZ8IBs8xRVoK43NICWFEm3x3tUGVNhL5nLLflkjdTCEyezqVlltleqjg5a2YTp4IuC2Zg5+CX26kKPSeMOgkQUjET3gDo+P5QRGOpVPKiuL0u90plnKfbtEknbVoH+ahzSz5u7C9g9O4xKEHIkcs7jCixq4pQ4YSHJ7Mi4J63rPe1KBBxqPI6GCYpbAUm4ButyjewkGZdZ4VzUSPOYVNhx9gAHvsx03Vprut5Z4+BclcYnDlCEYV397D9XGuSb9d7UpMJURxaJKrMjgafiHygT6us8mgMWqw+1NVYGtVBOwEKxkW1rlqfXbiZVDkRrq6/Hw0IMin9TvoT+M69Xt9mwd+iJfmBo04l91W+TOB2CoysK3zc6VrxQNXoOyRYrzoKvQaDrSja9Kq19tSFQQMDwcp3uFWcawjvQZynj1g8JUwgRoPIQn6AsIdKCvcvb/n98oTCr2MccRkr9Og7v0t1xTB4H4vv1ZiTrYWmWrjx+Y5+/14lAR+4oHDH1qJMa0taw51dmTKPEd04UC4FS5lXnkWjcKBeKPnfBNQhgcMJ+6m/VmiqrBTN6GgP2CIsHiYSyMPMtFjR+bu3UmhukXr1mfoGGWK+X9O/+e6Bn1xoaGC9SYTDEdALhU1p0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8585.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8bXtPpsiaS0QFwRBaSe+8t4gr8HCUz/rqs3SagV2Mc61pB5+Z/0ZIKE4zjl?=
 =?us-ascii?Q?vVFaFQljnxfiRTYZ+SZZGX4GEn8T+mYqxmt+NHIMGYBP1U4KE5tFM9DENojv?=
 =?us-ascii?Q?2BPs2bjE65uKnsclh0t7cva1HkghbwUjtU8dlLLg2mAqUHkb1q1zcX31TsyS?=
 =?us-ascii?Q?SmL8lMoFIkQnXN4audsz287JF4/l4mnUv9e0PAh/PQX4sRuf3g6uGsQ41HUe?=
 =?us-ascii?Q?rWEDe4UzhrBvk5ODkLAQHPZFb/Ug1flyWnrAI9J/DYamaT+tt3ViXVkaU+Sh?=
 =?us-ascii?Q?8XhvR+7/wcJa54huKekal+DBJWvnB+Zk+w4h3IH4gU6bZMqH4Xa3uZVlV+da?=
 =?us-ascii?Q?yqh1Vmaf3hyNNRdmDZigq086GMsJz8bT6eR8YPxR6Z2YXaAS42cL9PxKfSXY?=
 =?us-ascii?Q?Fd12ImQIN33mPo63VKDD7i4ijsAXDsowq5JyOZo7S5iX8ya6+VnYNBpLNmNG?=
 =?us-ascii?Q?3gbbBXOGza7Sbo4k7terffTaAptvBIL8hs8q+hMBZGMMMygVQ6DTaHvjxf4w?=
 =?us-ascii?Q?Pq9ZFFGA3pSvctJoYSCLlaarfxNnBO+aKzyUcw6IYef8Ydqbk28Fomc5dCXW?=
 =?us-ascii?Q?M2aX2sQrW7x/wkv9GwxdEbcIBCM9xF52DMUwBBjAjIlPzavt4C41RvSOdiQ1?=
 =?us-ascii?Q?3qRB1/ard4mKd9EljMXfIobSpN7e5kyiH7mXwKP9X38raI77RnE0IzZhZ0IB?=
 =?us-ascii?Q?a10UXpjrBrEjvle80euqbxiYQB21hP823NXwUo2zO5BFvbWqfnLw3ovIYjv/?=
 =?us-ascii?Q?PMGJ0zuDp5Qrj1BkhgtPCra5NtuAy4mOUP/HQSyx/KgQ8Pi5UDWHPOr6uMVF?=
 =?us-ascii?Q?fsqKZQLrNm/zlYaItNjNLlOibCwigoQxBDKCEY8q9uYMcP3I8KUgtwkLzx/W?=
 =?us-ascii?Q?GuuFFAfMmLqMRJv6a2iGQrAHaOyZPsR+44Js3z6ecoWzUqFclLjWuLHUtX0M?=
 =?us-ascii?Q?24AJdLXaP486H+nVq4wgHmHg4iHXCz7UaA77ed3FCR7cNBp//4lTiyzl4jea?=
 =?us-ascii?Q?U+LGRW4u/+qgNAZ/pgzDf5RehrqnVd+JMmwjc2lu8UwEeyL4DLJwNbKn/HjA?=
 =?us-ascii?Q?gtcTgGCUJ7QuPMf3ucELKjmZfgao2zUa3rZTeF9agCxmVX60f2FIx/lTC6aR?=
 =?us-ascii?Q?8QB1EtKwHt4TV3iNVPqxhGgGhlW71Gy4AiYfLSMz1859ukN9PKOr/rJDmCAH?=
 =?us-ascii?Q?eCxg8pwlzJ3Z1GF2VlbGHLSGdqMhgXhsgHx5AbmLtYmdNNDc0Zha76jk09Lc?=
 =?us-ascii?Q?j1VYsW1jJzAlVJElJwN8AW3mRZKDcXwEgyYgv5byOPUpnQtGy4cB0YNv1oZR?=
 =?us-ascii?Q?Z3pv0jVRpHhmw7+WAC4oKOvmqsE5uY70gz+NwuLcZFcuE9h3c2oJsC1SsSHm?=
 =?us-ascii?Q?CYMbeB9/eHlacYHZnYmwixA8Xjlh3m9txMk9BM0THrx/q47hWKgoWyT+rSth?=
 =?us-ascii?Q?HK9YpxvwrE8XL3tPLdZcgvMhftxlKVy36eYYqHldGEdEY1na58Kb8Q/ruflr?=
 =?us-ascii?Q?wW6zWmPGBcfDL2QH92RAU71bP9fg5EPF8rne0fG/NYyEvOK4L8zsyo2i4QBR?=
 =?us-ascii?Q?R0UP2YJbc6u7568qNadlXwvIbqM7yxSb11lQP/HWNdWOOYkqjO4JX72ajY5K?=
 =?us-ascii?Q?IJuc11wpGd0D8Br+VXSejU3IfA6KPkfnXX4PB+ph8rMhfGMmAT0CwReEomfT?=
 =?us-ascii?Q?PXWZdRZVGjL8RkDz1OkOpmCTxWh651vvtyqN/aoFhI8cz+u2CZV/l3hUZYVD?=
 =?us-ascii?Q?tKbT0MtaxvmbnxqyLeB7zISHKWAmUiROY9C9xQ8K1mz9gW+GEs+Ck8zm0IoA?=
X-MS-Exchange-AntiSpam-MessageData-1: lHYTgBURCo07Dg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e1f118-c396-4740-51c6-08de8a65b4be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:57:36.5157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7v1y9qYxV8YT6EmZZKzHl3RX3sYDXvGJBEFp7J2LnQloCllziPvFVFuycDyeeC/OVyg+qV4+4xEbw7wlq4dBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331
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

On Wed, Mar 25, 2026 at 05:21:14PM +0530, Manivannan Sadhasivam wrote:
> I believe I added the power_count check for phy_exit(). But since that got
> moved, the check becomes no longer necessary.

FYI, the power_count keeps track of the balance of phy_power_on() and
phy_power_off() calls, whereas it is the init_count keeps track of
phy_init() and phy_exit() calls. They are only related to the extent
that you must respect the phy_init() -> phy_power_on() -> phy_power_off()
-> phy_exit() sequence. But in any case, both should be considered
PHY-internal fields. The "Order of API calls" section from
Documentation/driver-api/phy/phy.rst mentions the order that I just
described above, and consumers should just ensure they follow that.
