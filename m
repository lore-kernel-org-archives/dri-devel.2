Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5478FFE5202
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD9910E3BB;
	Fri, 24 Apr 2026 11:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tE06mVPj";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CE510E3BB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQr0Lf6vYEByJELfPkARLi5MLzb5qxk5JpfvnCPh8HU+xHCbN2WXYZrATHU6L+UNdR/AEJ9QZJnQJzYg5c2bMercZ4TjW4UgMF6CQNVQit54itYn3siYhTFI9MXbibXVkXB/c/XT7s41WZyUuGVq+xmEQ1NjDeSsPOxmNT+bNmDhO6Nfn1CAjaB6CxfbOl/5zplBOjwoIUWE5ADSAd+C2J/6Teiy86lzS24hkopG6wri/v1TyHjhGTkx7CwxIm67kyWeBK5SAMlxoLAcHtcRtXjxWD5Ke7amZzFZ6AoMCnOzPPfUlZxCtB3qgERurfX19+F5yypP1Pvcrg6E+W34qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm3hcidFSe2dYQj0VwDoZAxdvBOBOszSMBkqI2+xyi4=;
 b=Wzr73HDNl3+ncclE0HpEkCHDPF+qxAg6ZtlXudZ04h4ghcRw5n7NWJRAZXz0ZJA5WO9qVIBnfpXkHU7kfKY4EXBU5HES/pzUdC9JW0LM81idnSUouLDaiUc3WBXkaBREVv3zx0wboGJN4Jr4sITMTgpQ4wEYE//dnKU81fkY8aKf4T0TxnuSmvocgDB1zMXFrvnZWZMJuDXy9XtWthUBMtXG1Y7szpJPpV+1Hd4b+U0dYWjsFQJqQp5FBGGr1HApW3UdUfv06HiTbHVG0Jm8PovFhilB4yYendtg7ADFEYaLg/n94JKvmwWGHIsDVZkDg8ZeT5w7+UsU9ZMDNDKBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm3hcidFSe2dYQj0VwDoZAxdvBOBOszSMBkqI2+xyi4=;
 b=tE06mVPjfWPieTPVjaKizKNrxv7TRa7PRx0YM1/GhgwM+RSdvDzLE4o4h4+rs0WhMetsAL1WlBWHjpPoAMXWl9Vyhv5KuthsLmFee2EaNaY+IMIEjiXc3a3r6OBduxo9OqrCbBUMaOYPVnqSKN9HIBJ3IMotH1olueXV2I5dOjrF6OQX5Eadh/t+/1HGRNBLKFlYy586cRTSY1U8Dd9RV1+LSTi/XMqa9YcxxbAePSPjuS6P7n7LRHBCzifWpv9mvC+45/SHzBZgcwW8wey4XhiZPGc0OuHET25IKQ3XUFmwxE8pnK20aEGllScXhB9q6dmT+z5jk26JUnoHpxbt1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:07:57 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:07:57 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Nikhil Devshatwar <nikhil.nd@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 1/8] soc: cadence: Create helper functions for Cadence MHDP
Date: Fri, 24 Apr 2026 11:07:14 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-1-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0164.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::31) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 81908f00-7b73-48c3-87ae-08dea1f1bd8b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mycXUE744kx+/Vmhmlh/Las54S6EbV6RHTWn2JyDgIBHmHrRbWPeqk47RjJ+NbHKtNH9/RQWwDraib3H7jq5SYFyFXYDIuTgewTjb5Igel8Ol4DpeoawfGqO+Yzev6HpHvc+gSpUXG3loqafyCNtnD4onjXJ50fNR7QoU6BTwf8zJRR8E7Io5M6In5xcw0RlBxcsEG89WhFWuFx3RwVb05r9jF3DWhB/PwCGgBfOaiB6axjRm2Gr6OAdRbLyvjl5bnBFwhQyoOD7pR0VVGeO3gKcr0B7CREnVkgjAgXhtR5ud3o55Q2huy5B9lMz2XbWlZ6dRLR7zjB+GVJoDDQI9AX9qKRD+PPfkKcT48gP9fXyyFuyS6NkVRYs1tHhBcmd9F6OVCt3q5dxR89uYycmfGBNWMfaijU7JLW8APHXqWjHlF+NWnJTLmRcZRudS11J+McJ/1pC6BoZkztJFdCBogB44AGV19/5zsuzCUrJncflBQ9WYNJq8NQG35VwRnkFf1nJaMOeADIvcsNgKUeUHBedfLJu82D/h5wJEM1urqHZ+ANiNJPcj9+P4fJ11GLNmHY7UglwEUuumO/NADQMnkeZ2sadULz5FSrSB/GjsB+rPo6hl7RpDkOOhE0AvO4+D/EPXTwlgYMBd/xBpDO37uIf/PkfowieAoQ22SfUw4MVXhM/SayOISV5VPj0AYPMrxuoY6wPBI+GhBj9F50xDQGXZ39EWAgKB+LwL9E0bRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXB1UDY5MEZEa2REVDkzaGk2c2QzNVJGL3lYMm9oNFpacDM5dEdhUExEZFB2?=
 =?utf-8?B?RndsSDZpbFMxM20xbzdlQ3ArOWNxeE9CMnhHc3pFWjNod3F0OUZBWDRjalhD?=
 =?utf-8?B?SmJXZVl2YkxHWkRtY2tMbEdIejY3c3VDVjVab3U0MTQ4eTlpUktxN21jTSth?=
 =?utf-8?B?elV0Q2N5c09waXhrMEhkSVRYRlpDOGs2VWZ0c05TTG4rdlZJR1FxOWQvdGNh?=
 =?utf-8?B?Sm1lZ2UyZzBuL2JmVFY0cHRUWGFlRWZ2M0VSTVlJSlIycDZLQ1NEQnNOdmlh?=
 =?utf-8?B?TVVndG1hZmxtN1JTWVVjREFHM0JZL25nMlZEWTFYdHc4N1kwVEpNWTB0SENx?=
 =?utf-8?B?RGI0S2puT2hkVk0vS3BWWi9LQ2Y3ZHV6cXB3V1UyUXhtNUVSS3FVakhYMVJH?=
 =?utf-8?B?UnJjYThMZEQyV1JhMG1qb3Q3aElPNFFyR2l3bHR2UjduUTNLbmVIbVhEa3Vm?=
 =?utf-8?B?akcvL000MklvNkR3OUhMcGhZSzNOaEloOGdMb0FpMzNZaFJrUDFRRk9iaUZY?=
 =?utf-8?B?cXEyQkZhN1BVcWZsSHFNNlF6ZlJmMXhYNUV2M200L0I5NlBCd203b0NoY0FE?=
 =?utf-8?B?YVdJQXZSYXMxQ0pPWWlENHZnb29qdzBXcFNkd2RzdC80eVdFYVRFZTVIbFoy?=
 =?utf-8?B?aHNQL0N1bHJ3R1A1dEZ5NmFSWnBwM3Y2a1hKY29qdzVGOFpDWFlNdm52T1Ar?=
 =?utf-8?B?VkNCZ3ZjOGpWbjVJaDhOOHU5ZXN1U2diU1p6UUlBdUx0SlZFRUNXMnBnTTFZ?=
 =?utf-8?B?bkc5Wjc5ZXkvRGFTdXMzbFV4WnZJVWI3UDBKRXdMN0VnQk9kQms2bThZekpv?=
 =?utf-8?B?SDU5anpJVHo0T09YMG10cmlxMTUwY1EvdGdRVVlMSUZ6QmdRaG8yVkIrbTlH?=
 =?utf-8?B?TTJJWS81QXI3R1NPZG1tbGZFM3JvK0wyZGRjOFlSblFtWk05ekVPOG91V1g3?=
 =?utf-8?B?QUE1eURQdVQ5eVBpcGZxWm5HT3RESXI0bFNCWnpybnJGQk1iajlYa2REa2Nk?=
 =?utf-8?B?L1J6eWZJa21sUjdUSHB2U21ZaXU0NVdXdXBhQ0Zya3cwQnlTUE51cnlwTG5z?=
 =?utf-8?B?dTNPQmczTjl2emZsd1NoUVFyMG4yODBZNFJIYXg2bGtRb3AwVE5LSnZtZHBK?=
 =?utf-8?B?UnlQRDVNdkdXRGVlTDE5QnQzalJXeWJRODlyZmpTUHpuMzVHV3VpOHBsQVRS?=
 =?utf-8?B?WEJra05Jemh0eGZ3UlpxNDk3M0VSWVpqZ3N1eEhoYzArUVErRlBxb2VLRHVK?=
 =?utf-8?B?T1ByRW9KZjFyMzg4Q0hWOG80bGJPKzNyZnFNdE1wL2ZuOTNFbEJLTmg0ekJq?=
 =?utf-8?B?MEtnOStKSFNWYWQ0U1JuMVVRM21WWkxiaTZnd21jbnM0WmlhUWw5bTF3amhM?=
 =?utf-8?B?cTZScEVsOXJ3NmIrNTA2UFdQKzBaeFNFNjkzUDVGWStwMEhTSnNWdUVRY3NV?=
 =?utf-8?B?U3I5R2ZzMkZ0TFVESjFpVlREdGhQY2drdWZINkZVMjBTRkV1MXZoOTZEN0Zi?=
 =?utf-8?B?OEQ3ZW5wc25IeXFNQ0Fib1AzVDVrM3lCMlRjb09jcjNjOW8zellGZEVYS0I4?=
 =?utf-8?B?ckNSNXEyNUo3VlZ4NnNXaGRzWTJJUVVTTjdFZHNGMDUxdFI5NlkweGRTNFRT?=
 =?utf-8?B?RC93Qmg3UGh2cEJUZU5jRVh1NzkvNVd2SXp6QlBqbk1DYTJLbTcxblhFZkNw?=
 =?utf-8?B?V2N5MVJBRHhmU1dMazdTams1M0V0SVo5L2lrM1FQQ0g5eFRVZ1VuY21oU0dO?=
 =?utf-8?B?K2ZxbnVPQkhFMEdodThkSXNKOHdKMEIxRWNVUUcvUmdBTVBWMDl3anhYMjNh?=
 =?utf-8?B?dHU3YlpQZ1hWTUF1Smpqem5DVmJvVzRXTzR6U0p3UzQya2xnVkdWQk1JQ2FK?=
 =?utf-8?B?L0dDdFNSMStVZE1mYzFLU1RtSWhic0ZlSlVhYUhsZzl5OXBVSDB5aTUxZzNC?=
 =?utf-8?B?K1pPTGxVemYwSGhnUnRhVXhaclZsVVErRm9OTWJQcXZCeC9sbGxseVJGZGNt?=
 =?utf-8?B?UHZMRVptMitIRit6eW1CNk9aUlEvRXRmNXZiYmdCSzNuTUlTMmFhVUlIRUNk?=
 =?utf-8?B?aGZaYjNyWXRGaHBLQzBQY1dNdERFN0pFdHpaLzNYeUdhcVk4WDFGeDM0NXY5?=
 =?utf-8?B?UUxURHlFMXdwcTE3Mzl6TzlaenlNb2E4QU91aHNaVFhYQkI3K08rbmROQkIz?=
 =?utf-8?B?ZWdlSVZYNE41aGNTYXVoWThycm9RRXVXWmFoajVHN1FZRDJPV2lYWUswb2Rx?=
 =?utf-8?B?bFN3SzhndUlaR3o4emN6RjNYczNXL29OeThjUEZHb3dpdDJ3YkpndjJHcEZQ?=
 =?utf-8?B?K1JKSUZwaFUxRlF4bzk5SzdRdGpad1M5UUdqT0ZQNHoxZkJYWUFLMnUxK2l5?=
 =?utf-8?Q?/TX//cFoKlCHOOl4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81908f00-7b73-48c3-87ae-08dea1f1bd8b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:07:57.4927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGpPJd964ZXYsUa0y+UsudazgCzXvTAN0n1P1BrYrpjqsve/a2wRP+qNhZhezJOsnhgboAthL5phfQcuYnJaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279
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

From: Sandor Yu <Sandor.yu@nxp.com>

Cadence MHDP IP includes a firmware. Driver and firmware communicate
through a mailbox. The basic mailbox access functions in this patch are
derived from the DRM bridge MHDP8546 driver.  New mailbox access
functions have been created based on different mailbox return values and
security types, making them reusable across different MHDP driver
versions and SOCs.

These helper fucntions will be reused in both the DRM bridge driver
MDHP8501 and the i.MX8MQ HDPTX PHY driver.

Six mailbox access helper functions are introduced.
Three for non-secure mailbox access:
 - cdns_mhdp_mailbox_send()
 - cdns_mhdp_mailbox_send_recv()
 - cdns_mhdp_mailbox_send_recv_multi()
The other three for secure mailbox access:
 - cdns_mhdp_secure_mailbox_send()
 - cdns_mhdp_secure_mailbox_send_recv()
 - cdns_mhdp_secure_mailbox_send_recv_multi()

All MHDP commands that need to be passed through the mailbox
should be rewritten using these new helper functions.

The register read/write and DP DPCD read/write command functions
are also included in this new helper driver.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Co-developed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

---
To: Parshuram Thombare <pthombar@cadence.com>
To: Swapnil Jakhade <sjakhade@cadence.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Nikhil Devshatwar <nikhil.nd@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/cadence/Kconfig            |   9 +
 drivers/soc/cadence/Makefile           |   3 +
 drivers/soc/cadence/cdns-mhdp-helper.c | 611 +++++++++++++++++++++++++++++++++
 include/soc/cadence/cdns-mhdp-helper.h | 143 ++++++++
 6 files changed, 768 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index a2d65adffb805..8f2114b9a6b7d 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -6,6 +6,7 @@ source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
+source "drivers/soc/cadence/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/cirrus/Kconfig"
 source "drivers/soc/fsl/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index c9e689080ceb7..33612ccdf5c47 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -7,6 +7,7 @@ obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
+obj-y				+= cadence/
 obj-$(CONFIG_ARCH_CANAAN)	+= canaan/
 obj-$(CONFIG_EP93XX_SOC)        += cirrus/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
diff --git a/drivers/soc/cadence/Kconfig b/drivers/soc/cadence/Kconfig
new file mode 100644
index 0000000000000..d4a8e8e751882
--- /dev/null
+++ b/drivers/soc/cadence/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CDNS_MHDP_HELPER
+	tristate
+	help
+	  Enable Cadence MHDP helpers for mailbox, HDMI and DP.
+	  This driver provides a foundational layer of mailbox communication for
+	  various Cadence MHDP IP implementations, such as HDMI and DisplayPort.
+
diff --git a/drivers/soc/cadence/Makefile b/drivers/soc/cadence/Makefile
new file mode 100644
index 0000000000000..a1f42e1936ca5
--- /dev/null
+++ b/drivers/soc/cadence/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CDNS_MHDP_HELPER) += cdns-mhdp-helper.o
diff --git a/drivers/soc/cadence/cdns-mhdp-helper.c b/drivers/soc/cadence/cdns-mhdp-helper.c
new file mode 100644
index 0000000000000..5657e88131ba1
--- /dev/null
+++ b/drivers/soc/cadence/cdns-mhdp-helper.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, 2024 NXP Semiconductor, Inc.
+ *
+ */
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <soc/cadence/cdns-mhdp-helper.h>
+
+/* Mailbox helper functions */
+static int mhdp_mailbox_read(struct cdns_mhdp_base *base)
+{
+	int ret, empty;
+
+	lockdep_assert_held(&base->mailbox_mutex);
+
+	ret = readx_poll_timeout(readl, base->regs + CDNS_MAILBOX_EMPTY,
+				 empty, !empty, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	return readl(base->regs + CDNS_MAILBOX_RX_DATA) & 0xff;
+}
+
+static int mhdp_mailbox_write(struct cdns_mhdp_base *base, u8 val)
+{
+	int ret, full;
+
+	lockdep_assert_held(&base->mailbox_mutex);
+
+	ret = readx_poll_timeout(readl, base->regs + CDNS_MAILBOX_FULL,
+				 full, !full, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	writel(val, base->regs + CDNS_MAILBOX_TX_DATA);
+
+	return 0;
+}
+
+static int mhdp_mailbox_read_secure(struct cdns_mhdp_base *base)
+{
+	int ret, empty;
+
+	lockdep_assert_held(&base->mailbox_mutex);
+
+	ret = readx_poll_timeout(readl, base->sapb_regs + CDNS_MAILBOX_EMPTY,
+				 empty, !empty, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	return readl(base->sapb_regs + CDNS_MAILBOX_RX_DATA) & 0xff;
+}
+
+static int mhdp_mailbox_write_secure(struct cdns_mhdp_base *base, u8 val)
+{
+	int ret, full;
+
+	lockdep_assert_held(&base->mailbox_mutex);
+
+	ret = readx_poll_timeout(readl, base->sapb_regs + CDNS_MAILBOX_FULL,
+				 full, !full, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	writel(val, base->sapb_regs + CDNS_MAILBOX_TX_DATA);
+
+	return 0;
+}
+
+static int mhdp_mailbox_recv_header(struct cdns_mhdp_base *base,
+				    u8 module_id, u8 opcode,
+				    u16 req_size, bool secure)
+{
+	u32 mbox_size, i;
+	u8 header[4];
+	int ret;
+
+	/* read the header of the message */
+	for (i = 0; i < sizeof(header); i++) {
+		if (secure)
+			ret = mhdp_mailbox_read_secure(base);
+		else
+			ret = mhdp_mailbox_read(base);
+		if (ret < 0)
+			return ret;
+
+		header[i] = ret;
+	}
+
+	mbox_size = get_unaligned_be16(header + 2);
+
+	/*
+	 * If the message in mailbox is not what we want, we need to
+	 * clear the mailbox by reading its contents.
+	 * Response data length for HDCP TX HDCP_TRAN_IS_REC_ID_VALID depend on
+	 * case.
+	 */
+	if (opcode != header[0] ||
+	    module_id != header[1] ||
+	   (opcode != HDCP_TRAN_IS_REC_ID_VALID && req_size != mbox_size)) {
+		for (i = 0; i < mbox_size; i++) {
+			if (secure)
+				ret = mhdp_mailbox_read_secure(base);
+			else
+				ret = mhdp_mailbox_read(base);
+			if (ret < 0)
+				break;
+		}
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mhdp_mailbox_recv_data(struct cdns_mhdp_base *base,
+				  u8 *buff, u16 buff_size, bool secure)
+{
+	u32 i;
+	int ret;
+
+	for (i = 0; i < buff_size; i++) {
+		if (secure)
+			ret = mhdp_mailbox_read_secure(base);
+		else
+			ret = mhdp_mailbox_read(base);
+		if (ret < 0)
+			return ret;
+
+		buff[i] = ret;
+	}
+
+	return 0;
+}
+
+static int mhdp_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
+			     u8 opcode, u16 size, u8 *message, bool secure)
+{
+	u8 header[4];
+	int ret, i;
+
+	header[0] = opcode;
+	header[1] = module_id;
+	put_unaligned_be16(size, header + 2);
+
+	for (i = 0; i < sizeof(header); i++) {
+		if (secure)
+			ret = mhdp_mailbox_write_secure(base, header[i]);
+		else
+			ret = mhdp_mailbox_write(base, header[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < size; i++) {
+		if (secure)
+			ret = mhdp_mailbox_write_secure(base, message[i]);
+		else
+			ret = mhdp_mailbox_write(base, message[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cdns_mhdp_mailbox_send - Sends a message via the MHDP mailbox.
+ *
+ * This function sends a message via the MHDP mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @size: Size of the message data.
+ * @message: Pointer to the message data.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
+			   u8 opcode, u16 size, u8 *message)
+{
+	guard(mutex)(&base->mailbox_mutex);
+
+	return mhdp_mailbox_send(base, module_id, opcode, size, message, false);
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send);
+
+/**
+ * cdns_mhdp_mailbox_send_recv - Sends a message and receives a response.
+ *
+ * This function sends a message via the mailbox and then receives a response.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @msg_size: Size of the message data.
+ * @msg: Pointer to the message data.
+ * @resp_size: Size of the response buffer.
+ * @resp: Pointer to the response buffer.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_mailbox_send_recv(struct cdns_mhdp_base *base,
+				u8 module_id, u8 opcode,
+				u16 msg_size, u8 *msg,
+				u16 resp_size, u8 *resp)
+{
+	int ret;
+
+	guard(mutex)(&base->mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base, module_id, opcode, msg_size, msg, false);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base, module_id, opcode, resp_size, false);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv header failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base, resp, resp_size, false);
+	if (ret)
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv data failed: %d\n",
+			module_id, opcode, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send_recv);
+
+/**
+ * cdns_mhdp_mailbox_send_recv_multi - Sends a message and receives multiple
+ * responses.
+ *
+ * This function sends a message to a specified module via the MHDP mailbox and
+ * then receives multiple responses from the module.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @msg_size: Size of the message data.
+ * @msg: Pointer to the message data.
+ * @opcode_resp: Operation code of the response.
+ * @resp1_size: Size of the first response buffer.
+ * @resp1: Pointer to the first response buffer.
+ * @resp2_size: Size of the second response buffer.
+ * @resp2: Pointer to the second response buffer.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
+				      u8 module_id, u8 opcode,
+				      u16 msg_size, u8 *msg,
+				      u8 opcode_resp,
+				      u16 resp1_size, u8 *resp1,
+				      u16 resp2_size, u8 *resp2)
+{
+	int ret;
+
+	guard(mutex)(&base->mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base, module_id, opcode, msg_size, msg, false);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base, module_id, opcode_resp,
+				       resp1_size + resp2_size, false);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv header failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base, resp1, resp1_size, false);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data1 failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base, resp2, resp2_size, false);
+	if (ret)
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data2 failed: %d\n",
+			module_id, opcode_resp, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send_recv_multi);
+
+/**
+ * cdns_mhdp_secure_mailbox_send - Sends a secure message via the mailbox.
+ *
+ * This function sends a secure message to a specified module via the MHDP
+ * mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @size: Size of the message data.
+ * @message: Pointer to the message data.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_secure_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
+				  u8 opcode, u16 size, u8 *message)
+{
+	guard(mutex)(&base->mailbox_mutex);
+
+	return mhdp_mailbox_send(base, module_id, opcode, size, message, true);
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send);
+
+/**
+ * cdns_mhdp_secure_mailbox_send_recv - Sends a secure message and receives a
+ * response.
+ *
+ * This function sends a secure message to a specified module via the mailbox
+ * and then receives a response from the module.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @msg_size: Size of the message data.
+ * @msg: Pointer to the message data.
+ * @resp_size: Size of the response buffer.
+ * @resp: Pointer to the response buffer.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_secure_mailbox_send_recv(struct cdns_mhdp_base *base,
+				       u8 module_id, u8 opcode,
+				       u16 msg_size, u8 *msg,
+				       u16 resp_size, u8 *resp)
+{
+	int ret;
+
+	guard(mutex)(&base->mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base, module_id, opcode, msg_size, msg, true);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base, module_id, opcode, resp_size, true);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv header failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base, resp, resp_size, true);
+	if (ret)
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv data failed: %d\n",
+			module_id, opcode, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send_recv);
+
+/**
+ * cdns_mhdp_secure_mailbox_send_recv_multi - Sends a secure message and
+ * receives multiple responses.
+ *
+ * This function sends a secure message to a specified module and receives
+ * multiple responses.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @module_id: ID of the module to send the message to.
+ * @opcode: Operation code of the message.
+ * @msg_size: Size of the message data.
+ * @msg: Pointer to the message data.
+ * @opcode_resp: Operation code of the response.
+ * @resp1_size: Size of the first response buffer.
+ * @resp1: Pointer to the first response buffer.
+ * @resp2_size: Size of the second response buffer.
+ * @resp2: Pointer to the second response buffer.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_secure_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
+					     u8 module_id, u8 opcode,
+					     u16 msg_size, u8 *msg,
+					     u8 opcode_resp,
+					     u16 resp1_size, u8 *resp1,
+					     u16 resp2_size, u8 *resp2)
+{
+	int ret;
+
+	guard(mutex)(&base->mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base, module_id, opcode, msg_size, msg, true);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base, module_id, opcode_resp,
+				       resp1_size + resp2_size, true);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv header failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base, resp1, resp1_size, true);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data1 failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	/*
+	 * Response data length for HDCP TX HDCP_TRAN_IS_REC_ID_VALID depend on
+	 * the number of HDCP receivers in resp1[0].
+	 * 1 for regular case, more can be in repeater.
+	 */
+	if (module_id == MB_MODULE_ID_HDCP_TX &&
+	    opcode == HDCP_TRAN_IS_REC_ID_VALID)
+		ret = mhdp_mailbox_recv_data(base, resp2, 5 * resp1[0], true);
+	else
+		ret = mhdp_mailbox_recv_data(base, resp2, resp2_size, true);
+	if (ret)
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data2 failed: %d\n",
+			module_id, opcode_resp, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send_recv_multi);
+
+/**
+ * cdns_mhdp_reg_read - Reads a general register value.
+ *
+ * This function reads the value from a general register
+ * using the mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @addr: Address of the register to read.
+ * @value: Pointer to store the read value.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_reg_read(struct cdns_mhdp_base *base, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	put_unaligned_be32(addr, msg);
+
+	ret = cdns_mhdp_mailbox_send_recv(base, MB_MODULE_ID_GENERAL,
+					  GENERAL_REGISTER_READ,
+					  sizeof(msg), msg, sizeof(resp), resp);
+	if (ret)
+		goto out;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*value = get_unaligned_be32(resp + 4);
+out:
+	if (ret) {
+		dev_err(base->dev, "Failed to read register\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_reg_read);
+
+/**
+ * cdns_mhdp_reg_write - Writes a value to a general register.
+ *
+ * This function writes a value to a general register using the mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @addr: Address of the register to write to.
+ * @val: Value to write to the register.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_reg_write(struct cdns_mhdp_base *base, u32 addr, u32 val)
+{
+	u8 msg[8];
+
+	put_unaligned_be32(addr, msg);
+	put_unaligned_be32(val, msg + 4);
+
+	return cdns_mhdp_mailbox_send(base, MB_MODULE_ID_GENERAL,
+				     GENERAL_REGISTER_WRITE,
+				     sizeof(msg), msg);
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_reg_write);
+
+/* DPTX helper functions */
+/**
+ * cdns_mhdp_dp_reg_write_bit - Writes a bit field to a DP register.
+ *
+ * This function writes a specific bit field within a DP register
+ * using the MHDP mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @addr: Address of the DP register.
+ * @start_bit: Starting bit position within the register.
+ * @bits_no: Number of bits to write.
+ * @val: Value to write to the bit field.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_dp_reg_write_bit(struct cdns_mhdp_base *base, u16 addr,
+			       u8 start_bit, u8 bits_no, u32 val)
+{
+	u8 field[8];
+
+	put_unaligned_be16(addr, field);
+	field[2] = start_bit;
+	field[3] = bits_no;
+	put_unaligned_be32(val, field + 4);
+
+	return cdns_mhdp_mailbox_send(base, MB_MODULE_ID_DP_TX,
+				      DPTX_WRITE_FIELD, sizeof(field), field);
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_dp_reg_write_bit);
+
+/**
+ * cdns_mhdp_dpcd_read - Reads data from a DPCD register.
+ *
+ * This function reads data from a specified DPCD register
+ * using the MHDP mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @addr: Address of the DPCD register to read.
+ * @data: Buffer to store the read data.
+ * @len: Length of the data to read.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_base *base,
+			u32 addr, u8 *data, u16 len)
+{
+	u8 msg[5], reg[5];
+
+	put_unaligned_be16(len, msg);
+	put_unaligned_be24(addr, msg + 2);
+
+	return cdns_mhdp_mailbox_send_recv_multi(base,
+						 MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(msg), msg,
+						 DPTX_READ_DPCD,
+						 sizeof(reg), reg,
+						 len, data);
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_dpcd_read);
+
+/**
+ * cdns_mhdp_dpcd_write - Writes data to a DPCD register.
+ *
+ * This function writes data to a specified DPCD register
+ * using the MHDP mailbox.
+ *
+ * @base: Pointer to the CDNS MHDP base structure.
+ * @addr: Address of the DPCD register to write to.
+ * @value: Value to write to the register.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_base *base, u32 addr, u8 value)
+{
+	u8 msg[6], reg[5];
+	int ret;
+
+	put_unaligned_be16(1, msg);
+	put_unaligned_be24(addr, msg + 2);
+	msg[5] = value;
+
+	ret = cdns_mhdp_mailbox_send_recv(base, MB_MODULE_ID_DP_TX,
+					  DPTX_WRITE_DPCD,
+					  sizeof(msg), msg, sizeof(reg), reg);
+	if (ret) {
+		dev_err(base->dev, "dpcd write failed: %d\n", ret);
+		return ret;
+	}
+
+	if (addr != get_unaligned_be24(reg + 2)) {
+		dev_err(base->dev,
+			"Invalid response: expected address 0x%06x, got 0x%06x\n",
+			addr, get_unaligned_be24(reg + 2));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_mhdp_dpcd_write);
+
+MODULE_DESCRIPTION("Cadence MHDP Helper driver");
+MODULE_AUTHOR("Sandor Yu <Sandor.yu@nxp.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/cadence/cdns-mhdp-helper.h b/include/soc/cadence/cdns-mhdp-helper.h
new file mode 100644
index 0000000000000..7e2ceb848fc2d
--- /dev/null
+++ b/include/soc/cadence/cdns-mhdp-helper.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023-2024 NXP Semiconductor, Inc.
+ */
+#ifndef __CDNS_MHDP_HELPER_H__
+#define __CDNS_MHDP_HELPER_H__
+
+#include <linux/iopoll.h>
+#include <linux/mutex.h>
+#include <linux/unaligned.h>
+
+/* mailbox regs offset */
+#define CDNS_MAILBOX_FULL			0x00008
+#define CDNS_MAILBOX_EMPTY			0x0000c
+#define CDNS_MAILBOX_TX_DATA			0x00010
+#define CDNS_MAILBOX_RX_DATA			0x00014
+
+#define MAILBOX_RETRY_US			1000
+#define MAILBOX_TIMEOUT_US			2000000
+
+/* Module ID Code */
+#define MB_MODULE_ID_DP_TX			0x01
+#define MB_MODULE_ID_HDMI_TX			0x03
+#define MB_MODULE_ID_HDCP_TX			0x07
+#define MB_MODULE_ID_HDCP_RX			0x08
+#define MB_MODULE_ID_HDCP_GENERAL		0x09
+#define MB_MODULE_ID_GENERAL			0x0A
+
+/* General Commands */
+#define GENERAL_MAIN_CONTROL			0x01
+#define GENERAL_TEST_ECHO			0x02
+#define GENERAL_BUS_SETTINGS			0x03
+#define GENERAL_TEST_ACCESS			0x04
+#define GENERAL_REGISTER_WRITE			0x05
+#define GENERAL_WRITE_FIELD			0x06
+#define GENERAL_REGISTER_READ			0x07
+#define GENERAL_GET_HPD_STATE			0x11
+
+/* DPTX Commands */
+#define DPTX_SET_POWER_MNG			0x00
+#define DPTX_SET_HOST_CAPABILITIES		0x01
+#define DPTX_GET_EDID				0x02
+#define DPTX_READ_DPCD				0x03
+#define DPTX_WRITE_DPCD				0x04
+#define DPTX_ENABLE_EVENT			0x05
+#define DPTX_WRITE_REGISTER			0x06
+#define DPTX_READ_REGISTER			0x07
+#define DPTX_WRITE_FIELD			0x08
+#define DPTX_TRAINING_CONTROL			0x09
+#define DPTX_READ_EVENT				0x0a
+#define DPTX_READ_LINK_STAT			0x0b
+#define DPTX_SET_VIDEO				0x0c
+#define DPTX_SET_AUDIO				0x0d
+#define DPTX_GET_LAST_AUX_STAUS			0x0e
+#define DPTX_SET_LINK_BREAK_POINT		0x0f
+#define DPTX_FORCE_LANES			0x10
+#define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
+
+/* HDMI TX Commands */
+#define HDMI_TX_READ				0x00
+#define HDMI_TX_WRITE				0x01
+#define HDMI_TX_UPDATE_READ			0x02
+#define HDMI_TX_EDID				0x03
+#define HDMI_TX_EVENTS				0x04
+#define HDMI_TX_HPD_STATUS			0x05
+
+/* HDCP TX Commands */
+#define HDCP_TRAN_CONFIGURATION			0x00
+#define HDCP2X_TX_SET_PUBLIC_KEY_PARAMS		0x01
+#define HDCP2X_TX_SET_DEBUG_RANDOM_NUMBERS	0x02
+#define HDCP2X_TX_RESPOND_KM			0x03
+#define HDCP1_TX_SEND_KEYS			0x04
+#define HDCP1_TX_SEND_RANDOM_AN			0x05
+#define HDCP_TRAN_STATUS_CHANGE			0x06
+#define HDCP2X_TX_IS_KM_STORED			0x07
+#define HDCP2X_TX_STORE_KM			0x08
+#define HDCP_TRAN_IS_REC_ID_VALID		0x09
+#define HDCP_TRAN_RESPOND_RECEIVER_ID_VALID	0x0a
+#define HDCP_TRAN_TEST_KEYS			0x0b
+#define HDCP2X_TX_SET_KM_KEY_PARAMS		0x0c
+#define HDCP_NUM_OF_SUPPORTED_MESSAGES		0x0d
+
+/**
+ * struct cdns_mhdp_base - Base structure for CDNS MHDP devices
+ * @dev: Pointer to the device structure
+ * @regs: Base address of the regular register space
+ * @sapb_regs: Base address of the secure APB register space
+ * @mailbox_mutex: Mutex to protect mailbox communications with firmware
+ *
+ * This structure contains the base resources needed for CDNS MHDP helper
+ * functions. Each device instance should have its own cdns_mhdp_base structure
+ * to ensure proper isolation of mailbox operations between multiple devices.
+ */
+struct cdns_mhdp_base {
+	struct device *dev;
+	void __iomem *regs;
+	void __iomem *sapb_regs;
+	struct mutex mailbox_mutex;
+};
+
+/* Mailbox helper functions */
+int cdns_mhdp_mailbox_send(struct cdns_mhdp_base *base,
+			   u8 module_id, u8 opcode,
+			   u16 size, u8 *message);
+int cdns_mhdp_mailbox_send_recv(struct cdns_mhdp_base *base,
+				u8 module_id, u8 opcode,
+				u16 msg_size, u8 *msg,
+				u16 resp_size, u8 *resp);
+int cdns_mhdp_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
+				      u8 module_id, u8 opcode,
+				      u16 msg_size, u8 *msg,
+				      u8 opcode_resp,
+				      u16 resp1_size, u8 *resp1,
+				      u16 resp2_size, u8 *resp2);
+
+/* Secure mailbox helper functions */
+int cdns_mhdp_secure_mailbox_send(struct cdns_mhdp_base *base,
+				  u8 module_id, u8 opcode,
+				  u16 size, u8 *message);
+int cdns_mhdp_secure_mailbox_send_recv(struct cdns_mhdp_base *base,
+				       u8 module_id, u8 opcode,
+				       u16 msg_size, u8 *msg,
+				       u16 resp_size, u8 *resp);
+int cdns_mhdp_secure_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
+					     u8 module_id, u8 opcode,
+					     u16 msg_size, u8 *msg,
+					     u8 opcode_resp,
+					     u16 resp1_size, u8 *resp1,
+					     u16 resp2_size, u8 *resp2);
+
+/* General commands helper functions */
+int cdns_mhdp_reg_read(struct cdns_mhdp_base *base, u32 addr, u32 *value);
+int cdns_mhdp_reg_write(struct cdns_mhdp_base *base, u32 addr, u32 val);
+
+/* DPTX commands helper functions */
+int cdns_mhdp_dp_reg_write_bit(struct cdns_mhdp_base *base, u16 addr,
+			       u8 start_bit, u8 bits_no, u32 val);
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_base *base,
+			u32 addr, u8 *data, u16 len);
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_base *base, u32 addr, u8 value);
+
+#endif /* __CDNS_MHDP_HELPER_H__ */

-- 
2.51.0
