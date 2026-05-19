Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70267CD4F5E
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F4910ED2A;
	Tue, 19 May 2026 14:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f6wPwJ7j";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ECC10E5E0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGcmfOSZOVh3oNLGIGXY5CvrDX2vH1cPZA6nto8U+eIUkEQA0jMRa0tUrSzJ8i3+0Sz3+TS+77+iDuP5xk7g+RN4b/7sPAg9CIPnys+pQlGdeykYMUvH5750hKrYQV21DPtSO9Slx9llLy6/beyaayhsmEVDKJ3OvhlobLKea9JxZENB93l4OKYik7UJc0cYtX5IMVmyCk/thYhvTR1fnpz5Ft1Y0ie2SCaO+BGUrRmCBMGQTbKRv/i7D+VmHTtEM6NxVTyXMo3aGMoStxMIm/Il5//AtafPgxMjmEIrNGfO4ExnpyTr+JtUO1TPypFc1KknRau+by4q+biVhZpJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjmWHjecBVqn4v1PBKy2oLejtHOp6KmnMPmXEwDeEpU=;
 b=O8uG6mOtCqtL8iSCfe48vd4Xn9Ap3PJiN+9S6NavTpVVMg8JHNXhwGKA6IpfAHfj+DrHS5StWzG7b/ZtldI1tzKMViHqp04R3VTBxYW+Wn+8Qvwva6K++25e4f9A1Px4nl+NBgtGQkI/EZGGrW348FqCxTzwyFIo8GaZwUDovefwaXtvVAVRLg1Ks27A69rp2wuZecSY2+FkXt7uGGyTutDDtnpVzyraa2XmuNQVFjWayuOki4xZk3uOw9Dp4k30sdFZpxujojDAVK1Zyh6BAH+QePIC8yCZlzK6y7h1AeKVKMRDTEaROdWACH+R+Tyfz43GJitvPC0fWDTYObokYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjmWHjecBVqn4v1PBKy2oLejtHOp6KmnMPmXEwDeEpU=;
 b=f6wPwJ7jKHrm0eWqccHvJIwmdz5eaZU1gxNF4A6gck7Z60mJH1pOUUuiIgG7QLiZUzcR8bACsaviwCiqfbRwK/dwnSfjNQeFDqz1V6gQZM/kTdRCAGpVMOmwXtqmC1GcUHoc3fMPLtMVFfh8G9glelZmuxOvPiJk82BR1cDBT9YdL10pgYQBGa5CwxpeSaUObOhXmACF6eXRv4VbrTX0RbrekDCmyR6XoutbNMKAlAkX+q7NwFwQx4+e8YHOpINi4sDhzCcB/+MlmCteQA3h4CQcG0wp4GkgT3RZ1HahzSJ3gLuwfRBYwbKggw04DJNsjoJdkf9cLHJBr1qhaPHdUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI0PR04MB10831.eurprd04.prod.outlook.com (2603:10a6:800:25e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:43:07 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:43:07 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Nikhil Devshatwar <nikhil.nd@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v23 1/8] soc: cadence: Create helper functions for Cadence MHDP
Date: Tue, 19 May 2026 14:42:24 +0000
Message-ID: <20260519-dcss-hdmi-upstreaming-v23-1-5615524a9c63@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI0PR04MB10831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee81896-0847-4357-54e3-08deb5b4f103
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|19092799006|366016|3023799003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7R9vXMvOJQUzhEoCQQeDrJMlnFV0s6u5z50OqE+QzQOzLV129mI7RLUVrot684MKa9FwxqPCizm5MyFKBIlgLp2B6O/SCy0bBIQ9ow2fBM8dG6lHICHVdFOYxz7wRL1/Z6YDjWWn8nfkpa9FgvOrULz8NYupUDUY/yt73EOv34DQraU3O1V7eaxmbsQJTwHo/CM5XVXf4FdfYIIP4znG52CZzYaxOCkFLsypvidl4jhdouS/BuM3LiLYSHC4JTBhXYRzrGRKrItE5+H6GyHhNtkftXZX+Ds3NL7NLLkuUf76ePTPySp5VT6aXWmPhOILWLZbvij88fwp2/o12l6eOPRO9CTCGE8/IrQ2C9rdFcmkgSr0785U5jtyTdPLCgmuCbZSFPK2d+m1TvyqcNBNRezY9YGJvod8SRitNb8Ry11GG2fwDFLZQVz3pjbO71Lw5C9eu5+e22icCCI8HJH3VvM9AALBwShIAcAaCUAtL0dxOmSoQ4Wgkz6k5X+dQmaGJJ1Ct7NxlDEuHClaqwG4nFrqjpVdObbPmuwXVa4TpOdpAriS7WdV965TMBlpyV3Jpe56RxjcrsWn1f6cpSrL+mzfgEsYomL34XnPADmtkMFtumNTTcvhoun6SwF2WRjsMqy2Zf+6vGAQmDqBS4pYlNftERLLOAi4k4k0jBNSr0jokBEbCTfxZasNsFqhV5Z4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(3023799003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG14Z21od1kzalRBNGNpczlmOHpIWkJsNXBUSU9uMEJVWU5XVS9paGd4b3gv?=
 =?utf-8?B?c25Jckl2M0o0ZWU1WlNZUE1qZE5NaTdmVDR1MzF5Y3ZCTGprNEJLSkF3SVpz?=
 =?utf-8?B?cVlQNmp5NnZuK2Q3TU5BeThOTzl0cG1Xcm1nRDE2QndkekRqS05pV3NyVElG?=
 =?utf-8?B?OHVxZng2SExqTDl6eERmeEtZcFBhbTNSaGlZOGg0RWxiUkdyREtlbFM3U0pP?=
 =?utf-8?B?RTIxaG45K3liSXM3WUtYTGx1UEg2NEZTaTBNOHhLN0Z3eHJLZHV6S0p2U0U1?=
 =?utf-8?B?dzFyaG52RUhJSW9xZkxGNDMxM01SR2NUOXd1NTNJWnpUU0JzM2Flb3Y3Lzlj?=
 =?utf-8?B?QkFmbUt4KzkxbGdtNWd3bEhWaTZMeHVTZSt3V01kZDM1azYzS1YrYzEwQWVK?=
 =?utf-8?B?WFlPY1ZOUlkyb1A3OGZOR1lWOW51YmNaMmd2aGFkTytaazZNVW4xMDNxRlR6?=
 =?utf-8?B?NjUvYkRyWGhaQ052bUs2Q3RmTXVuVVJMYitoY1psaVBLYWkrOEgyQUFxM0hQ?=
 =?utf-8?B?YzB6TjUvYkJhaGN6dWtHalJMM1lvM3ZMcHRpWW5nV2xOcm1VcWEyVkFvWnQ1?=
 =?utf-8?B?SnA0Tnprd2I5dStpcGIwcUYwTENxTTFNV0ZwNW9ZZExZSTBBZ1pVUDF4TXJo?=
 =?utf-8?B?N2VWS253NDFLYlVzYnFPTlRjKzhZYXBWTTN3bEN4Q1Q0Uld0YkRjckdBYXM2?=
 =?utf-8?B?TjM2ZHBPc2JoaDVxR3BNZzJiSjROakNxVGxudVVDNTZjZVhXTG5rYjVrWmRO?=
 =?utf-8?B?QzFlVHNuNlZnR2N2bnB4MzZrYzhzZDl3NnZYSFNmakc5Wi85VHhESGZmZi8w?=
 =?utf-8?B?bDlmME5CMGhCNjRDTkNJRUoxRWYwa3hPUGZoamVjZCtlMGlHQ3pyaWNJRlJP?=
 =?utf-8?B?SkI4d0NFSlNva2xaUzZTZlVXa3dMN1hJVmV3eHBZSFFOWDQya3BDcnhuak1h?=
 =?utf-8?B?bDMvT3V5bXdYNDZFOTA0NGxyWXdxcXh6NjFEcldldWE2L3pHNUZEZjBlbGNK?=
 =?utf-8?B?NDJCUWQrQ0ZMakdLZ1RUeVN1Z25wbCtwOWdXbWNRSDRnN0tjOUxlaVVuK0V0?=
 =?utf-8?B?RDFqeXpqTlFiMS9EcHJmcHpsZmdZTHJOQWVrVFZYdjEzUmZhZ29YYWVQb0tv?=
 =?utf-8?B?Rzc2S3dPVlNoeGRGbVZHbDFqd2FENTNVTHJWd0pVK01CV1VYaTJycXk1TmQ0?=
 =?utf-8?B?ZmpsM0MyMlpLNW1ZUlRHZkxZd2ZydGVpQUx1bkg0Nm9rOHIvaUkwUXV2K3pF?=
 =?utf-8?B?cUp1YmpPa1ZXR2U5ZUJzYklLQWd0TGtaUVNibmtoL2svTXc2ejIyd0ZzaWcv?=
 =?utf-8?B?M0dRUk1HTURtZGJZOE53a01xWWx5SzlhbzBuNk9LWlRaSGhIWTVwNDcrY05Q?=
 =?utf-8?B?eXBjc2NURmJUeXJ4WFRNV0VZVzhIcFpCMlMyalhTZHNjeDFxMXlJdDVHN1R0?=
 =?utf-8?B?MjFjbE84aVZmYm5mbzc1QUZmd3BJSmRUdGVNRnlSVitHNzl5WERNQnFqRW5n?=
 =?utf-8?B?eHNQNVBUTjVKRjBLaEtnTCtvcjFOaytyMzMwSVdyb0ZKOCtIUDlld3Y0QkZR?=
 =?utf-8?B?V0FQcExwdThTM0NZMDZZTEQvT00zbktFbytCUmRBOU9xbFpFRmpLYURJZTdw?=
 =?utf-8?B?cHFTa2lxQndGSG5wcEhoOVo5T0pyT0I1SThzQzZVNHpuUVlpYkdPeU5pVW9v?=
 =?utf-8?B?ZzFWc2ZKL2gxQ2liS3dzekNGRklYM25DaVRhRUE0bHRZREREVmpMMVRWZjB3?=
 =?utf-8?B?bHc3dmZIeXg3b2hLQVN1bklDUXlXbllHSzFGclJPeXhNZnVydUtmZE9xRlRX?=
 =?utf-8?B?MVFPdjV2VHpHUUlKQjJCTEp5amJlUXlNSWR2TDlpSTN0QTZaZi84VzM0Y2FI?=
 =?utf-8?B?UmJ2RkRDUHVJd3hmZk5PQUp5cWxoNGk3aC8vUUh4NUx5QnlYMzlaOHdVd1hs?=
 =?utf-8?B?d2lkdjdxTjNWV1ZlS05PN2txcU5nWjBiWi9wMytGNTNPbDRYS1Vta3RaY0Ns?=
 =?utf-8?B?emFmTEVjTVlzbVJRQklaWlJvK1c5TmVhSncxNC9Cd1ZpVlJuRHNyWkJFSHlG?=
 =?utf-8?B?VG1FRFBuMFNjQVIzdEFmdFN0YlRCUjc0M1FjaTFheUpXWmJjMmh1NHpONHNW?=
 =?utf-8?B?VnhCQ0twWTlhamtRVHJ2QWhkR0pQbklId0JLaDV1RUhFcEUvT1ZUMDJwTEhG?=
 =?utf-8?B?TDVBMmxCaHBGNGRtQjk0K3RoU2s1aXNEOG1ZK09aMXcrYTdDa1VBVWRyWnpI?=
 =?utf-8?B?WnFxQ1NhVUFEYVJmZkRNbjA2ek1nRGZTMU55akVEVy9NSjJaenNPcmpKTEFM?=
 =?utf-8?B?UWxBMjFYZ1NsbDhQQlRwSThSTjRoSU5CR0VWVTJ3bCt4M0tiMHpEUk5zeko0?=
 =?utf-8?Q?2N3LvNW7mR3u4XL8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee81896-0847-4357-54e3-08deb5b4f103
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:43:07.8536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwQvm6Z6U5qDIwj/XRj6DFPjc9BjVO0Vf+rmUPCUD0COOGoh6e/c2tP8I5pxuZtolU3KaCvHCI19l34vr0tkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10831
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
 drivers/soc/cadence/cdns-mhdp-helper.c | 625 +++++++++++++++++++++++++++++++++
 include/soc/cadence/cdns-mhdp-helper.h | 143 ++++++++
 6 files changed, 782 insertions(+)

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
index 0000000000000..217107c3b7b70
--- /dev/null
+++ b/drivers/soc/cadence/cdns-mhdp-helper.c
@@ -0,0 +1,625 @@
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
+	int ret;
+
+	put_unaligned_be16(len, msg);
+	put_unaligned_be24(addr, msg + 2);
+
+	ret = cdns_mhdp_mailbox_send_recv_multi(base,
+						 MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(msg), msg,
+						 DPTX_READ_DPCD,
+						 sizeof(reg), reg,
+						 len, data);
+	if (ret) {
+		dev_err(base->dev, "dpcd read failed: %d\n", ret);
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
