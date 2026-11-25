Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C9606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iUWyOkS1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112D210F9EC;
	Wed, 25 Nov 2026 08:41:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011016.outbound.protection.outlook.com
 [40.107.130.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B6610E1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti7JDn/ucERQArWH1WLIOQ/kqx2344CT2bWzTKJhmf/E8ak34ZLUNdwSTNlVobgL5JiydRbjW26p0VINtEFIAZLAE4BKp/14bOLhX777K8uijMrxLsnUkNeteg+H2He4pvetvM7/+sdJnagqXhEi0qPsOwEWIp64x1F9Ote1xtBM8ZH+xE2iDajCaGip20cnezhyIKhFT1qszzXgKxtgW8U/Wx+c2xcJCk8NYw35r/wN9pKK8tzk5Sh/gDpTAgod1mZ0jNMXRr6s83FFsOAl0CyxQtl6Eyg++kL9wBjPnC41Pey/m7WQpSTS7q3uKUGmRBL8Bde6AmurPfCr9NXaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvvckOLgY1Z/vXlf8qyI9aKDSqiUNJo2wde+Fh8RCh4=;
 b=uYo/CVlSCWzECfK+GBwVaoXaAKKW9GRYPx9OlnSdp7B/icdD6VrySIYQD4FkGPrmVJVTOOVvHMqtEXVttTv2XdbhEvT4uHoZY5xHS7bVAxlcfK9b2aCmU12d25jDCLBj+XIEi1n26TK9wv2WCRARnA8D7fYtq+Bdat7WCff0xgJZ4v9l1TD869lU8ZRlCxGc+7yhBFq3G1Ma2KbLt4NKNFAV1dnaSOfzCSQAg+SS5bvCxMwVi9JdUmlgdLI+/nxtkF30Kpx20xNMMUFPFN3jglRad49WUoe17LVzZ1C25IASJeF0OEQ6nSU0zfRKYEy9R5b/44EDoy+X923ujPUcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvvckOLgY1Z/vXlf8qyI9aKDSqiUNJo2wde+Fh8RCh4=;
 b=iUWyOkS1ElQZpVvbTP9Fbrv7awgLMcRLHA333/z1ZPlSS4AguV0UvSJ2VCUeTNio1G1fUw8Qw2YvqKVbXZd8Lkx4viicN7D2TH9++wVLCbewHWLk2wXlvUCetZgZEeROnpG2gKQpLau5F3BF9iENQOvB0gDHWIG11T2TVQr1vAZSj34edGx4AgbEzmjdqZXIJq3O2QLPi4108VxgH/KHfxFZQMb4ajADr3Ogrg0kFvcd4WoG2O6dwqcRsAKmqBbWHd7xSPIkmHtIt5m221rWzw1xd0wmNpY3MjsrPXcKuORgb18QMtc6wGgvMakyl1cqWuVPFRvMdP4m14D7vXPSCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by BR0PR04MB503013.eurprd04.prod.outlook.com (2603:10a6:2c8:4c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:55:01 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Wed, 25 Nov 2026
 07:55:01 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Robert Chiras <robert.chiras@nxp.com>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH 0/2] drm: Fix rm68200 panel shutdown on nwl-dsi
Date: Wed, 25 Nov 2026 09:54:53 +0200
Message-ID: <20261125075455.772826-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|BR0PR04MB503013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e178e09-477f-4efe-49db-08df4ac9689e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|261009223027099003|261009221227099003|18002099003|3023799007|261026121527099003|56012099006|261021123027099003|261021121427099003|261102123227099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: rBxujmkK/3aUlM+NrF6vHVcMBtv+4JRk+c4uvKxFovVW55BWoSQUCnFSgq6gPcn7a3FxvNINF5o5EhUQx1RXVlNE8XDfSZpZ24Za1ydmco8gG6MtkehT/WaeSX2XlgMyetyJjJlv1vSEozsw8P+AS7uug3lhgqnuB39LBip78Lv9Pr7nlPpsIqRqcKuvdf+qtp0DmGiwwS2BSvykuU3H6Xy6dH/69eMtDXcQWeoKvyea5AXoKmfFdMN42lHaLkS48QnFKDPJDDE/Jc/O+RBecHE4XLD9tqK+2Uqb8P1+v9kHJ3B7HCsG72M9QcuFMy5f0e7DMxTjUlp67wATjjfFxs2i2qiqE2UMHmiRCS9DyPlu3e0wWB8KBtzstu89h6lq8iBklvCmQbAyGkJZu6nK9Eh6fDvtm7EFi9i2eZ/Qh/kiRe/nwZGB0IvNTSuyqyK9am7RkCvTGGntQahKlVIfOXagq88NdOEZFVszManm0fsBnQTxboxHl7k/jKYnIXgie/kysNAP6Ce8lYNxkP/Hzmgki6tHnuz21RWpsDdYr/8ciqiiJ1MnK1CP2h0WvYxKyUTgO6T2xjnVnqtPdjVihiruK3gCugl50sqVNpRq1nBPDqLqr8J+k9fO/rL2BHAjnosDnPZhKLK970NAgphnXJimaxs9aAVoc7da2ir2t60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4472.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(261009223027099003)(261009221227099003)(18002099003)(3023799007)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0KIYCjIaTuLQiWRxKdoXU/c8g6N0Zxbg7bPCc1a6EPLEC1BeskfvsNFrwPV?=
 =?us-ascii?Q?ARum+sv3YHWS6Io9RjHvbXEH1QN7fRMtBz44N6ShgA1SsGDOqSVqMsPulGKs?=
 =?us-ascii?Q?kC8QFV3ktXt/z/6Si8cr5Y/0pP2qe0gNujJU56qkzuVeLpykCeXyXkn90jFh?=
 =?us-ascii?Q?gzx90ryT2nPkEpty0riYpFX1xEjV/cbAd6umfwHfPJ+d2SaRwFqOzQfQ3aja?=
 =?us-ascii?Q?T+lLKzgC5wYQ3mYCin3Zaza13OuAs5x5QjbXeqnWRVu4Ujv9RgmBhqFTOKOy?=
 =?us-ascii?Q?vMDwim7tmyjN8n3soeW2uF088o8Ddn8wFyIzQOIvIMN4RJl4C1sA6bUIobkZ?=
 =?us-ascii?Q?XDHsG8PceZ+2//7cU/pNSf43kST8/YlLTA0j5K6kVveF+az4JkECOGF0nskr?=
 =?us-ascii?Q?Gcn9Zd2Fk2N5nYzAn1dToLrRrQ/9jpfADp2znbcAbby5u/jy5d+hjpwole5+?=
 =?us-ascii?Q?WzeC3ZdjfjBzopH6GryuHtdY3eSS2/7b1M3pi3jFwbmB/AHPjMP+4YfqRmY9?=
 =?us-ascii?Q?DHwBLYtEcaYjTkcYR4Geo5DpCi0ztj9XPq0XBWynYkMoVpfT/1rrEdIh9z/u?=
 =?us-ascii?Q?JaTpxsV+MgVjZM53HPFlg7bIq9r7BzVVYKs/Al2E1VxGgGISbEACbfRHp7ag?=
 =?us-ascii?Q?lfb1DWC8wyhZVRGvZs/A1OIebGnR3ZlzGTPn+musrFnF3nAeI3xb7FFeY+nc?=
 =?us-ascii?Q?iH8kFlh8sGa5fgwBthmPjAglo9MKy3BO/6dB/K2rXctqpiqRq972Ck3T99rn?=
 =?us-ascii?Q?8GkMIwad0aWUsUJfaag7wqJ2Pds42LfZpVOFOMi3nxYWaA3t3JDo26adUk7X?=
 =?us-ascii?Q?Gh0/51LDxG6gZNSd9ViTj8JQ/EuA2HbF9JY/cxS6hGKPq0F75mWegoRVlA+C?=
 =?us-ascii?Q?IHyShPrst4fnGRxhAeB6GzGmolJT/MkXbgPBbIiNDP56B9HsABMKhVqpQVtp?=
 =?us-ascii?Q?rtgHk4lB4Qs50MUl75/5z+gI6SII0OPO8Jv5W47jSVaSvbdRqDO3ILIcANwD?=
 =?us-ascii?Q?DC73DuXNzqNYbko8hDAb9GVxu67h3xDNFiTKiJ3H6msPwkAwIfUN3lqjYqcJ?=
 =?us-ascii?Q?6accj+JqwpKB5StV7O8QS0J3Kr5ENVt4dI5IblAH1F1FbxFPKGqKJfAKIeh2?=
 =?us-ascii?Q?lubouu1vaj0AsxpoLULraxyr0WYTLNTODV2IPIv4ndZBbjOBPN1BbJUEAmA6?=
 =?us-ascii?Q?1rYb2LcpwWghjYR0G0C//31gOsit57HbTl8cww9A/UneL1w3aNcdqeYjIdBj?=
 =?us-ascii?Q?E0x6XBzP7duQ8HUv6wFnZTuHZkdO3MPl8oPJD46Ebbq/5n1xI0kBCZW+MGOt?=
 =?us-ascii?Q?I18YIR2c0C31fSX3hB2LiKPI5AjzXpVjYVkqjNZqbY38n9Q9I4IHPi4Xp2OJ?=
 =?us-ascii?Q?Rebmb7xEKyXM1BpgpPC+g7au77f6TgQfQtN8ygoomqSsvogBA0SvtwqP6dst?=
 =?us-ascii?Q?XqrmsKqAghvwaA1ipfrBgGzHIG1qRf/vyi/kPelxbNmgckobm+koLgz2O36T?=
 =?us-ascii?Q?9jRSfJqJpn+8CY+ougu/WARR2y3cANYCsTa3x7Itw2e6TgDUKPQdvu5bLpG4?=
 =?us-ascii?Q?tkPQGleWSxna3kBA4qmVSigVCBDGsnao2MLpgIkiNRpU1+gtUQgIocNNczBT?=
 =?us-ascii?Q?GKKLMIbr0fHN4+YLuBnUZVzMLYRKaI1cPdZ7VIxVGvjdPkGhfdjwhxZTI20w?=
 =?us-ascii?Q?BndIk4sPB9Zn3KsRzH4+xhpQtJcN4iuJLfTDUet4hgo6SCbXB8pn/KBNK3Ma?=
 =?us-ascii?Q?deR+M5RJ9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e178e09-477f-4efe-49db-08df4ac9689e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:55:01.5072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjA9N6vziE/p8u1t7oDtq0FVVpNLMhK6u7aV39Cek5x9pxVenhGVOyJfRakGDxnJros8UK1wvrlH6ttSI8TI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB503013
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Raydium RM68200 panel sends MIPI_DCS_SET_DISPLAY_OFF and
MIPI_DCS_ENTER_SLEEP_MODE from its unprepare() callback. On i.MX8MQ
with the nwl-dsi host, those commands never reach the panel, because
nwl-dsi has already shut down the DSI controller and PHY by then.

Two changes are needed, one on each side of the link:

Patch 1 moves the nwl-dsi shutdown from ->atomic_disable() to
->atomic_post_disable(). On its own this does not change the outcome,
since the default bridge ordering still runs the host's post_disable
before the panel's.

Patch 2 sets prepare_prev_first on the RM68200 panel, so that the
panel is unprepared before the DSI host bridge's post_disable. On its
own this does not help on nwl-dsi either, since the link is torn down
earlier, in ->atomic_disable().

With both applied, the panel sends its shutdown commands while the
link is still up. Neither patch is expected to regress anything on
its own, and they touch separate drivers, so they can be applied
independently.

Patch 2 also changes the prepare/unprepare ordering on the only
upstream user of this panel, stm32mp157c-ev1 with the STM32 DSI host.
That host enables the link in ->atomic_pre_enable() and disables it in
->atomic_post_disable(), so the new ordering should be correct there
as well, but I have not been able to test it on that board.

Liu Ying (1):
  drm/bridge: nwl-dsi: Move DSI host disablement to
    ->atomic_post_disable()

Stefan Ghetu (1):
  drm/panel: raydium-rm68200: Set prepare_prev_first

 drivers/gpu/drm/bridge/nwl-dsi.c              | 6 +++---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

