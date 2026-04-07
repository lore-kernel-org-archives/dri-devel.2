Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A63FEEF50
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F8610E428;
	Tue,  7 Apr 2026 14:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ukaxVz9B";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011029.outbound.protection.outlook.com
 [40.107.130.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819A10E410
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrkJqGAclgY6ciMGUzdREtiBc1bOaVy++flssiYcOlJHCElGjQKmgYGY5VeCUqlCysEm8XfSeY6gLWQCfwaiKAR928pDW3Ze1/dBcQLXu1MeXQ4kDVwymYRykK+OaULdnrtvJRJSCUiAgp0p+1+pi7zfW1CRRIEW2q2r8hEwU3OLOy0MfAH+qoKv178/RFC/mqE1L6xYnSdcYuu7i00ORqWPu5vt5412fYgevz4qBCe5bCxNTpYJfKPmhkfDar3sLeL8MSoEz5m66wXv73Gyyd9kN6NC/P1urmIg/hmvtXgn5/1bOLK1shkpdX2eeN4J5zg4IphQYfCUiiaEgAUsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PHhfBr4qUbWpMRvsP/r9rsnb7XBQKz6zKK5nXJJnH8=;
 b=dQ+9D/9COl9P0yKrlhWbdCQpGXR8DdKCSFoUO+E4bUxzVQxezc94+HCqE+JXhY+tnyUxBsx3V302Gp+IoezrgwgIFEV/MgtJz/H2US8z/oy9/GTIXGbdOW6ZHhkGCgKHVm/EJv5RGO/LZ/rHFHbNlVPg7vb61rYKOEs5ksX6qrDuAJNH8//LgneMDA+Hoc2zanM9LPVpES9tUgWVbWPWrQw0cutcVYqTxCmgNO1JmduxzCG306yUpCi38Kld0fUH1FxjYLN9isGN2HJLY3QFZt4fl5/LAv+0WLo98MY5AW74dn94dg+BmApMAj1EAbLITNx+M4u3Spf7XdNPpolc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PHhfBr4qUbWpMRvsP/r9rsnb7XBQKz6zKK5nXJJnH8=;
 b=ukaxVz9BO0aJwGFhEtDqpy3gdJe14aWxMW8mX7hwBuuwfBOQRvJuy4k+SMLifW0DM18Ap9+sT5A7fjBYvera9fNXRFJqpE6LvqXOPivMrQWXcfZgd8qxEs4yGSToPKpgNUdZ3jN2U/iwDRQ2I4+M1MPkIGZ1s4tUuIPPs9Zt6GtXxL/4gq4fQ+0CVi0RddhHEXCToGCVomynbld5X7D87svLhtrzYtfkiiL4jcutnXraG+dEXRgxjsJgwxYNFaWn9vgQAXdboZtzrnCy9ot7gQkzDj6NqB8n8zSRKdNqu2O+/Rord78S+SsiZrHoommKYc1zbXAF99tyR3M9Kcc8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:32:09 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:32:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Ying Liu <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v21 1/8] soc: cadence: Create helper functions for Cadence MHDP
Date: Tue,  7 Apr 2026 14:31:25 +0000
Message-ID: <20260407-dcss-hdmi-upstreaming-v21-1-4681070ab82f@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
References: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::17) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f0e340-a2a4-4e77-f18b-08de94b2736d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RJEWsmNAcMi5Hs9YKYkF1PYjycwDS0yl3fAw/DWFdUpIkyNRnGrmJ2TZHF/gXQdv4i6aIQtJw+T+UuKVxfWGJbf4Tw20c5QeZ2arLgKaPloKD9uAA+eyWG+R9wrmHFv/doZ7rKr9Uq+8ZUDJBVwkUQM+nA6flvFOm+7JrBQS/9amGLK4DjdybJk32FBLLwOsidjMyVUiACVj74o7/J/WAPss78KOwXFANhlO8wB5kLFMgTTTS1DbBZ71aOC8oFH1S1AVcZo4eXGF8U57qbpKDEoKh2M9/uuaIBU2aCFsMSk+PHr8is9fazdjiy+kSZHUgkjb1PH83vJz+3mOThXgxJB/BfiuAliJHWMk7DW3czHJMC6nuApaM5EPZGJBNBA1Ser3sveZ68cTK1h9OD+eOChvZbGLNDgcYX7z0HF0NyJsSNwJSRzPW2nT7ZAujlXEGukfNTF4btaeN/MbLFnrKkHOZXn20o3swqtc7o4xAS6iYlptdsvsOvwk60jT5pi9MLICFgVMIZ30+Di2C26QcSDX9HJHtvOoL7IhAd9URe1ZkkjT08LI0tBK/u+2CsR3Cgdxnwb4+a4kdbkh+Ovi5xodFs7tlHmwAa/rQqFudK6F9Y9UE5pMLBInmL/eVOoB9TQA5RrqbhDo/l8Pgllrmw1IU952hozvYPZ50AqYOb4ynPG6+dVXGluTlYdTSgagOjAexb6LqPhksKTfvenOzEi8p87uVogm9jKbMLWMAXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJoY3N2c1VWZ3BxU2kzdEMrWmRFb3JoZTIrbzVZSUJvYW1DMjhvR243blVI?=
 =?utf-8?B?VXdjamxZZE9qaHFHY2pCK05JQlhrRHhaVzBjalp5c1o3SW9xRTlEdmE2VHM5?=
 =?utf-8?B?dE5qVFYza1RrWmZTQVNGeEZTWXlVZTZXNnlCRVc1cEhNU0VOR3REMDdrdWR1?=
 =?utf-8?B?Y3VnNUxPNlBoWnZXYzlSZ09wNHlGdGd0VVZVS1JuZzF1YWo5Wjk4aW05UE9r?=
 =?utf-8?B?d1p6dmhtcTlVMitxUFhQZ05iMGZzbHVTQTFGc3dkSlpDSVZMK2NQUGV0UnYx?=
 =?utf-8?B?NVNiMklONXkvRFNEWnZNb1prZFlrR2xGOVc1cTAyOU15cjZmWkcweStnMkpy?=
 =?utf-8?B?cnhKTzIzb0Zxdk51RXhtWEJVS2dLTUN3OUhWTGZFdGloVGdxNmdGRmhpNjI1?=
 =?utf-8?B?cWRlZXNlaW1RdmhiVTdHa2JFWHltb2l4Si9PeXdBanlrK3ZoNDVmaE1Vb3ZJ?=
 =?utf-8?B?eW5GRnMvQ0pvL3c0TXFVaE9sd0QvdFllTnpUN2R2b1RvK2VzalRlZ3Z2RVVO?=
 =?utf-8?B?UWlPblpWU0FqYXgzVGtPRWZtbEhVbU9TaldPcXEzY1BGdURMalFrWnNrUFY4?=
 =?utf-8?B?YW1wRVBYN0pqRWwveUF2MWVFTW1rMHo4M3ErU3JjMlRiRXFSdW5YTGl1dlNa?=
 =?utf-8?B?d1B6OUFnRmxlMGF1bGM1MGZMV2dXYVoxamdlaGhqLzl5N2FJL1JsUCtoQlhP?=
 =?utf-8?B?cTVZK2ZkR25DV2RhOVFLclA1Rnd1ZzRKVm9TY2dLZTJnZWFZS1FkeEV3Nkdo?=
 =?utf-8?B?eHlpbWpqNEpBbEpsTDFTd3J4RitSWGZjK2duazF1cVFtU0Q0dDVzcEFudE5i?=
 =?utf-8?B?V3krZXc1OGJQRGpybWtPUSszSkl2aDF2dU00Y055RjArYjQ5eXNNbDBzOFpj?=
 =?utf-8?B?Nnd2RnZjSHJoVzA5ZjJVem1RTXpUUFcwNGtlQ0xSZ3FRR2xCL21zeXdBcHdm?=
 =?utf-8?B?TzNzemhwVHNLYzgwTGFUdVlwOWpGVWlQTFpvZXlYVDgzYjJVQm5qWDNocndX?=
 =?utf-8?B?L0Q3OU45Z3huTFhJcVpNaUxmNmZrU1plSkN6TVE3NnlBcWFvbGU1RmV1ek1x?=
 =?utf-8?B?dW5YWHA1blRNd3hFczg1cUhRRlZCam4zN0lsOFI0UDBIR1lFZHJJcnFtdWoz?=
 =?utf-8?B?UWZzdmNUUDBaTzBvNEk0d1FXcjBua2hGMVRNbGVRQ09HKy9mK2J2Tkc4Tkkw?=
 =?utf-8?B?ZTRFS01GZ25GRFZJaG0xNnYySytSREUxQll1TmRSV0FCTGlEZlZpd2lIZzB6?=
 =?utf-8?B?VWZwbE1qRDZOUUFnRlZPWmtPdUJUNzBpTVBiZUhDODJJWUt1aXA2RWxOb3RR?=
 =?utf-8?B?a0ZYakJFQ0xteUJXSjArWG5VcytLKzZQeVlvK25vVlNzcytXbWRVQlBnOTRq?=
 =?utf-8?B?dWFWOFVzT3VPZ21YbWcyeDVSa2t0NDFyUlFMUFlqV1FQcmt2Yi9MYWFycmtz?=
 =?utf-8?B?bEtMa1c3bDNpL1JJSlhWNkRvTWZVeGNQM3ZtdE1LNzJZeE82THluUk15TG5y?=
 =?utf-8?B?M1NLM2dxS0NQdnJXMWxuM255R3M0cHZrdXF2b1F5MXI3ZkYwUkxiR0ZDazhJ?=
 =?utf-8?B?dnltUTFUT1pRaWZEc25tMkc0MjhPVEhsNzJYMGp3d0FmODhtNmQ4dEcrMG0r?=
 =?utf-8?B?cTNlTjZhT3NHM2pyTW5oL0dvOWRMcC96WGY4cVFFYXJtWXJHc1FNM3NLM3p2?=
 =?utf-8?B?dXo5S1RkUkIvYllPOFVGbnhKd2tTK004RDNFRitlcGRRa2RrbjFkWHNOZmtX?=
 =?utf-8?B?L0d4K0tBenExUVBvRVc0TWZYWHBEUGlPT2wyTG43U0phdElMdXRtSVc4KzNT?=
 =?utf-8?B?OFRPekFpTHVsRHd6MWFIaTN4dWk4STdrYmdTbUdpMEZtK1MzYlcybnkvNi9Y?=
 =?utf-8?B?eXJnZHJZUXFLUXpqQWpjL3BBN2oyYjRtRGRMdVV6OVNieEZkYVNSVzlQYURS?=
 =?utf-8?B?bTVpZWJBQmozc0d1MFBJZ3dYWTlYSjhjT3ZjZEpXbnNGL1Zza01kdTFiWTRy?=
 =?utf-8?B?azRkbmxScFlYc29Fdm8rNTBxYno4aTFjMUw0OWVMNjRORjVXVjArcGdpcUFk?=
 =?utf-8?B?NWF6RThzUGVqYmE0Y0owaU5rQkhCWlhOUjR1aVdaVHg0bFlvbUU2VTJpM0pv?=
 =?utf-8?B?L0dtVHlVQTMwN0NYK1JPbFFmMURXaGpNZUJzWjhSTVlWY3hZcjJPNmp6dE5D?=
 =?utf-8?B?eWM4N0U4UkdTNk9yVytFSGY1Z1ExaHZwUEtCczJMNGdTYUl1Y1EzdGdZYU1E?=
 =?utf-8?B?UmZGZHpXTng3ZkhCcmw1RlZIQnVyNHAwN050dEs5cDlPNi9wQ2NncmZOTkpL?=
 =?utf-8?B?V3VNem9aMjBTZktKS09sUG9zMndZWmRvMXNJdUllcE9qaTZxUE1FcHNhYnlD?=
 =?utf-8?Q?r5tKHQnXQnWSFL1A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0e340-a2a4-4e77-f18b-08de94b2736d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:32:09.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P22Y0dgSc79O8ZRpIWoE5VV0vswwWmgqi6Rgbwd+K93ifda2biRZ5Qich+eFxhzllTY+I1Il5+ga+Gs6quR6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6936
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
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   1 +
 drivers/soc/cadence/Kconfig            |   9 +
 drivers/soc/cadence/Makefile           |   3 +
 drivers/soc/cadence/cdns-mhdp-helper.c | 572 +++++++++++++++++++++++++++++++++
 include/soc/cadence/cdns-mhdp-helper.h | 129 ++++++++
 6 files changed, 715 insertions(+)

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
index 0000000000000..466f5ac5f2e88
--- /dev/null
+++ b/drivers/soc/cadence/cdns-mhdp-helper.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, 2024 NXP Semiconductor, Inc.
+ *
+ */
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <soc/cadence/cdns-mhdp-helper.h>
+
+/* Protects mailbox communications with the firmware */
+static DEFINE_MUTEX(mhdp_mailbox_mutex);
+
+/* Mailbox helper functions */
+static int mhdp_mailbox_read(void __iomem *regs)
+{
+	int ret, empty;
+
+	WARN_ON(!mutex_is_locked(&mhdp_mailbox_mutex));
+
+	ret = readx_poll_timeout(readl, regs + CDNS_MAILBOX_EMPTY,
+				 empty, !empty, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	return readl(regs + CDNS_MAILBOX_RX_DATA) & 0xff;
+}
+
+static int mhdp_mailbox_write(void __iomem *regs, u8 val)
+{
+	int ret, full;
+
+	WARN_ON(!mutex_is_locked(&mhdp_mailbox_mutex));
+
+	ret = readx_poll_timeout(readl, regs + CDNS_MAILBOX_FULL,
+				 full, !full, MAILBOX_RETRY_US,
+				 MAILBOX_TIMEOUT_US);
+	if (ret < 0)
+		return ret;
+
+	writel(val, regs + CDNS_MAILBOX_TX_DATA);
+
+	return 0;
+}
+
+static int mhdp_mailbox_recv_header(void __iomem *regs,
+				    u8 module_id, u8 opcode,
+				    u16 req_size)
+{
+	u32 mbox_size, i;
+	u8 header[4];
+	int ret;
+
+	/* read the header of the message */
+	for (i = 0; i < sizeof(header); i++) {
+		ret = mhdp_mailbox_read(regs);
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
+		for (i = 0; i < mbox_size; i++)
+			if (mhdp_mailbox_read(regs) < 0)
+				break;
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mhdp_mailbox_recv_data(void __iomem *regs,
+				  u8 *buff, u16 buff_size)
+{
+	u32 i;
+	int ret;
+
+	for (i = 0; i < buff_size; i++) {
+		ret = mhdp_mailbox_read(regs);
+		if (ret < 0)
+			return ret;
+
+		buff[i] = ret;
+	}
+
+	return 0;
+}
+
+static int mhdp_mailbox_send(void __iomem *regs, u8 module_id,
+			     u8 opcode, u16 size, u8 *message)
+{
+	u8 header[4];
+	int ret, i;
+
+	header[0] = opcode;
+	header[1] = module_id;
+	put_unaligned_be16(size, header + 2);
+
+	for (i = 0; i < sizeof(header); i++) {
+		ret = mhdp_mailbox_write(regs, header[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < size; i++) {
+		ret = mhdp_mailbox_write(regs, message[i]);
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
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	return mhdp_mailbox_send(base->regs, module_id, opcode, size, message);
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
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base->regs, module_id,
+				opcode, msg_size, msg);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base->regs, module_id,
+				       opcode, resp_size);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv header failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base->regs, resp, resp_size);
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param module_id: ID of the module to send the message to.
+ * @param opcode: Operation code of the message.
+ * @param msg_size: Size of the message data.
+ * @param msg: Pointer to the message data.
+ * @param opcode_resp: Operation code of the response.
+ * @param resp1_size: Size of the first response buffer.
+ * @param resp1: Pointer to the first response buffer.
+ * @param resp2_size: Size of the second response buffer.
+ * @param resp2: Pointer to the second response buffer.
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
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base->regs, module_id,
+				opcode, msg_size, msg);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base->regs, module_id, opcode_resp,
+				       resp1_size + resp2_size);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv header failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base->regs, resp1, resp1_size);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data1 failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base->regs, resp2, resp2_size);
+	if (ret)
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv data1 failed: %d\n",
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param module_id: ID of the module to send the message to.
+ * @param opcode: Operation code of the message.
+ * @param size: Size of the message data.
+ * @param message: Pointer to the message data.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int cdns_mhdp_secure_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
+				  u8 opcode, u16 size, u8 *message)
+{
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	return mhdp_mailbox_send(base->sapb_regs, module_id, opcode, size, message);
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param module_id: ID of the module to send the message to.
+ * @param opcode: Operation code of the message.
+ * @param msg_size: Size of the message data.
+ * @param msg: Pointer to the message data.
+ * @param resp_size: Size of the response buffer.
+ * @param resp: Pointer to the response buffer.
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
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base->sapb_regs, module_id,
+				opcode, msg_size, msg);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base->sapb_regs, module_id,
+				       opcode, resp_size);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d recv header failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base->sapb_regs, resp, resp_size);
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param module_id: ID of the module to send the message to.
+ * @param opcode: Operation code of the message.
+ * @param msg_size: Size of the message data.
+ * @param msg: Pointer to the message data.
+ * @param opcode_resp: Operation code of the response.
+ * @param resp1_size: Size of the first response buffer.
+ * @param resp1: Pointer to the first response buffer.
+ * @param resp2_size: Size of the second response buffer.
+ * @param resp2: Pointer to the second response buffer.
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
+	guard(mutex)(&mhdp_mailbox_mutex);
+
+	ret = mhdp_mailbox_send(base->sapb_regs, module_id,
+				opcode, msg_size, msg);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, CMD=%d send failed: %d\n",
+			module_id, opcode, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_header(base->sapb_regs, module_id,
+				       opcode_resp,
+				       resp1_size + resp2_size);
+	if (ret) {
+		dev_err(base->dev, "ModuleID=%d, Resp_CMD=%d recv header failed: %d\n",
+			module_id, opcode_resp, ret);
+		return ret;
+	}
+
+	ret = mhdp_mailbox_recv_data(base->sapb_regs, resp1, resp1_size);
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
+		ret = mhdp_mailbox_recv_data(base->sapb_regs, resp2, 5 * resp1[0]);
+	else
+		ret = mhdp_mailbox_recv_data(base->sapb_regs, resp2, resp2_size);
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param addr: Address of the register to read.
+ * @param value: Pointer to store the read value.
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param addr: Address of the register to write to.
+ * @param val: Value to write to the register.
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param addr: Address of the DP register.
+ * @param start_bit: Starting bit position within the register.
+ * @param bits_no: Number of bits to write.
+ * @param val: Value to write to the bit field.
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param addr: Address of the DPCD register to read.
+ * @param data: Buffer to store the read data.
+ * @param len: Length of the data to read.
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
+ * @param base: Pointer to the CDNS MHDP base structure.
+ * @param addr: Address of the DPCD register to write to.
+ * @param value: Value to write to the register.
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
index 0000000000000..25b9737de615f
--- /dev/null
+++ b/include/soc/cadence/cdns-mhdp-helper.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023-2024 NXP Semiconductor, Inc.
+ */
+#ifndef __CDNS_MHDP_HELPER_H__
+#define __CDNS_MHDP_HELPER_H__
+
+#include <linux/iopoll.h>
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
+#define HDCP_TRAN_RESPOND_RECEIVER_ID_VALID	0x09
+#define HDCP_TRAN_TEST_KEYS			0x0a
+#define HDCP2X_TX_SET_KM_KEY_PARAMS		0x0b
+#define HDCP_NUM_OF_SUPPORTED_MESSAGES		0x0c
+
+struct cdns_mhdp_base {
+	struct device *dev;
+	void __iomem *regs;
+	void __iomem *sapb_regs;
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
+#endif /* __CDNS_MHDP_HELPER_H__ */

-- 
2.51.0
