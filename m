Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15085FEEF49
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F9B10E410;
	Tue,  7 Apr 2026 14:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JgMRLpzy";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011029.outbound.protection.outlook.com
 [40.107.130.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7A510E410
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWZp2voAufgHBmZzkM1xUdc0e0bezRCDb/vesJBZp5zt0dhXb5dKV7dNVba/F6npbQUvBO722vlY6mgtElbWwZO1b3bIjmhwvPITi/evbR/2oQ92N/jS6OGHd46l7ynRzB2MubE3gNNonXNGEo+y4FQHS042S3Pjna0HuyudS7eIkNxb/Gi26M0I6jX7L0oj7qCeemhO89XnxumY4O9q+PnOfw3C491kyRCuYm23Sj0yqrM+iOPFwApdKdTcg14jAj68ja62kqRN9+ECKycjgWzgRQQBDmSQBKvgmXjC4C3gKvD1ageJsz/LvJ1Ph/lWYaD4g6x4ymdCHUJ9Vp7LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAnxG/hmqhLbdBbJFi7Lsz2r3bP/1bRutoC/PGOD2DE=;
 b=Qm8DrzCzb+3TJJ9gZSeuzX8XzcJtq311O9GBZcPhVv2ObYi9s2OBCMkQfGrVbzZkJyynMINToqrgLbRyexO3kJw2f1xyI5HqMoMiD+A4gZzlvo9Ronjz7HtwCXi7F4/mQQATcrwm4qas7f6jfYunwspEWRdxjivfsDwzb4qV1Z+vsAzc9FDB+iROFApT53HJt9Lg05ILpYgww79fUxQSHREvQgY3yLHISiN1UFhv5YHLdsLwEJbE9aXiqDpkiN6jn+k4GU+MfQfRtDZUXZ71UhN7t8vf/6H5WQdAgs9e3WaGFdrKCiru7/522iuKZmm4//x91GqWTDyxl1uA4K+Fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAnxG/hmqhLbdBbJFi7Lsz2r3bP/1bRutoC/PGOD2DE=;
 b=JgMRLpzy9AS0zmK36j3EF71PGP3NuPAxTFq0FN4rf3nxQlOtNtTxi0wskFrXdZ+Ai7fK8L352fWxUqZLtFrnwZWbYmIHoiYADWvDTW9dSj7azjGBgnxzGUq3B7GzXCNCsSIy7QgJ3sAA6y4w3s6hmIJjGP/FSpLQcswIbvShdCWuSxg4l8cb/pXRqDFUkfXULRojnlGzqS+8C42TGktYaC5AwmBSIF07mC3Qv74jS5R7zj5KLk5JM4h9zNdIerCePbTIBUaIpZ44NMYaZOQFyhN8yTz0pStXarUc/ZQDsr6g4YBuQZwmV1hHht5jDKNRU+2fDg17grW/WxaN0dNcNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:32:05 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:32:05 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Ying Liu <victor.liu@nxp.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: [PATCH v21 0/8] Initial support Cadence MHDP8501(HDMI/DP) for i.MX8MQ
Date: Tue,  7 Apr 2026 14:31:24 +0000
Message-ID: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260406-dcss-hdmi-upstreaming-28998a88e911
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0059.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::26) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: ef704ab6-d662-474e-f374-08de94b270b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|921020|56012099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: 0Z/k5n0KYsNMBuVlEeAi1RYbCb4dYoHGAkhkcUVxso1Dwo9R2FwsgJWF6iKV2nOiDX0wHHgOxZEmJAXMhf1PLT4No9X5xZNrdc6SWTeTtDa2bPOtgnBkHBJIiQeDtsSTn1udqd6J7n/UKFhGP0x1qYUDrnxkQv3aMS+Ys5dEWvjUpE3wBL9D/Gf6y4aGENqxCK953Rz9WAAtGfkek+QZwSNIMtToFf7vWSoMm2HT9W8Fo+ipjEUyvhvOrJ4xrd6TfXQdO1v6CAfxW6KqbwG4IFdIC5k1zXE4tUNmILlbitbHh8RZJc6yd/y0LDp0f36gvcG0JCt7TDRnBgS5oY9p8zhpA+RdnmnmDUSl9rXw4CkEnE1cb31kfb01FwjbukCgbPX5DgMvPfwThugs4eh0BNmd5t1gIxTUuax8Hg2QaFuU+oZnL2P96qUeCaOdwJhwHFDCs6Yq9J0xvrdUJj8l9hTA0gYDo20HJWEbCvFXDxyy8RgxLmh2tj4BrznuCAiElkhXj81uB+aQMLen/UVRs0M8I6BryZRhTWvTTo9zjaiowS3e1B9BXUdHS8TDLRmaPGoF7maG/WJ5jS1+89IdorTe0Df+xiZ8MBgVbvi9Ebr3nU9UGpuIUALsnwp0B05OBgJpC6iig/cRGVHy9x15+4EfVsBrv5sizHuM0DlBbSctQRamWDIXqq/AkAu3PLBNupAgSGqzZr/0eYjFON+ySnWpCgNNdt2jW9TBVfm906SHkbc6AuLFj8mTiJ+OX/marw0cGp2ZoKKx0ZadphicnX93EsFaVtN/9DTP9dE49kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(56012099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBmeHFaZnhVTnVrRm55cVRkcXlUL0xlZDlNODh3aVRPUmdPb3JaelI3UCta?=
 =?utf-8?B?bFY4RGpJWmJmbDBFRUgzZStWK0t1ZWE2RloyTnNhRTJBdzNsRmFNN3IwU1ZB?=
 =?utf-8?B?V1hPTVo3T2MyQnRlTDdGTCtpV1RkbVRDdnhhazFseFJlbkRBaFhoV0J0OFVQ?=
 =?utf-8?B?K0dWeDlYQVhOeFJwa3FDK09TeUhXRnBWNHN3Z1pTNXk0bnhvZlJzR0xFOHFh?=
 =?utf-8?B?T29yd1hIN1JBYWhLQWNvei83RGNXdXc5MTh4YW8zYjZva3RXQ3hVcUk4cXBl?=
 =?utf-8?B?d3lWS2ozQVNldDByREZteTdBTVBKZ1JUNnJ5TUVodUtjQjhKcE1wQkE0ZGhF?=
 =?utf-8?B?ZFkzMkRDZ1NlUUYyVnpVMXVGWUd5TFBPcXVCdHZBb3V3V1pGcHcyNE9PeVhD?=
 =?utf-8?B?b25DUEx1bTI5SkFORVpTVmhSazNPRkswRUVjaG10akhsUnlTY0VWSDZuQzBs?=
 =?utf-8?B?UzhvMVRqOEZWbFFBQU56NDF5WTR2Rng0KzdBUlgxdkFDbHdMcGlpNGlvVDVt?=
 =?utf-8?B?UEZSUlJIcmdKbVIwNkhSaDJZeWE0eDJNTEJzUUNmZkdRa3c3UGVvZWJhTUFU?=
 =?utf-8?B?NGF3NjJyZnRVRWg2V09JRkVsZWppa1BYUk1hT1h5TDRVYklOWWswd0JMOTZO?=
 =?utf-8?B?WW5Ub1ltdXMvbjVGcnQ2VXNsZlpvNC8yTU5mSHZJZnkvMFZqUFBpZTFUWGFH?=
 =?utf-8?B?MmFXN0F6TWJEcFJKRlRraVk3OWhUNHdpMzVOb1JhSjJ3MmJtVjZuK0hhbDVT?=
 =?utf-8?B?QWlac0tWa1M4SWc1cURjTmJqYzljRG9mYzYrV0UrdSs4VnhaVk1PRXNXc0hh?=
 =?utf-8?B?Tmw4ejdRL3dUUVBmbG9NTDhGOVdEeXE2Qlg4ZXhUSkE4WmJWbTA0NWxqUjdG?=
 =?utf-8?B?SitPWUNzY2RydUkza0FJZUtLYXhsWk5ZcmJ5Uk5XeUFGVkxSUklmd2tXYnFo?=
 =?utf-8?B?ZmxwbzRiVEg2YXBzSHprenVvNHpySEd0aXFSV045NURUZ2htUCthWHBMMjE4?=
 =?utf-8?B?YlRxa24zL0VWT08rTDlXNDF3bjNFVzdDLzNJcXJGejdjOGR1Q0gza2tBeHVW?=
 =?utf-8?B?ZG9LT3oxSzI1VVNZTndjZ0xXd2pCbnhuNERyRjRnM0ZkM2VFbTlKVllIN2tM?=
 =?utf-8?B?TVJpbisrbU9ycEZPazFPUnhUMktOZXBTUGxQTHVsdHVmNXlTUVM0U1B3LzVv?=
 =?utf-8?B?VU5MM3hUYlRBN1V2OHUydTA0UWVCaTRTaXpoMFRaSi9SQUdIbjgxb0VoalJm?=
 =?utf-8?B?K3QwT1NHODIyMTdCT1VrNEVKTG1IcDQ2UWZiR0Z2YjdMQSszaEJOSlFKVHNN?=
 =?utf-8?B?WUc3YnJHSlJodm1lY1hjK1YzVTBtSG0rNzRoY1FJdDBVZUZrQkdJL1dpNnhK?=
 =?utf-8?B?L2xBZm95NStVYTJkYU9rVE1qMFZVYzEwMFNiZ29nUGRxNXdpR24zSlFkWm1V?=
 =?utf-8?B?WFN5dmc4NlBON0hPOEJVeWhCMkpnejNIZngwbnBDZXZUWFI1ckxOUzdDMGdX?=
 =?utf-8?B?YnhPazdFRzlTY1dyWkxiWURvUzNOREhQUmVPdk1UVTlFRCtyWVZGOHF6eGVq?=
 =?utf-8?B?enRiQ1QzWG5zait1UDA5Umd6Sjl0MlNycjY4Tzh2REpJdHdYaU5HNldSbmJi?=
 =?utf-8?B?TU1ESFJtbVIwTnhYemVKN3FCUHpvUWFqbEJPSGRzamUvOHByNmZNWWZCS1Ju?=
 =?utf-8?B?OHRpdEl2Wmg5KzFDdW1YTzc2cWZ0TGJjbXZFcnJ2R0FXUURNS0VMdENDM2NL?=
 =?utf-8?B?d3k4STIwYXVVWnJmUlVRaGNUc3JoRGQyOWNYdWVHUjAzeTZsRkc4ajA5V2I5?=
 =?utf-8?B?VlZGajB3T28wSWtlcGV0eHNCa0tDVUNWSkRPbVBMdDhxNlZwdGtPWGtaMlFS?=
 =?utf-8?B?OEtTQmRIWmp3NEFDazBGL21hVnBjNER3ZmNoY0xFeGNqYlcvOEpXeERmVzF2?=
 =?utf-8?B?ZG9OZk1kczRCNHpCMGRTZTZKT2wzdThSb1JMRUtBdTZFeWF2V1V3MmdEcUh5?=
 =?utf-8?B?akRpSS9RY0gwUmxjUEpJcjJvbmRZVEpCOVBGSThQL3BSZlpJenFCa016aEZ5?=
 =?utf-8?B?ZGw5c2lyS216VkllMVJqTUw0elBvekJvQlJ0K2xaNUJ6bHpZVFMyTDBGWDZ3?=
 =?utf-8?B?ckRFL0t4czVXS3hBNmlDOHpkVk5uTWhsaGxiS3A0eVFFaFBtdExaOE00Rk9a?=
 =?utf-8?B?cjBsTWtKRndrcFFmdHB2Y1NsMkhSWGZ1YjEvVFVBdERlNHNMajk1OGRVTlNw?=
 =?utf-8?B?VjhKNFVSN2VSRjNwRzQzMkprQVg4WDR0UVlwcmM2TVJXWDQ0cFVCcXIxYkll?=
 =?utf-8?B?WWdDaXE0Qzg4eDgxWE5JRWFRbWFoZEV3OVdQaFRsT0k2TldqMzBrMndvM2hQ?=
 =?utf-8?Q?KLjQ+kTmIg1KwDPo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef704ab6-d662-474e-f374-08de94b270b8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:32:05.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSIuFXUmjIuLT7ww4nNgpEJt/UEfNwCcPDpxpHeN8fdOwWpFK98vz6MT33gwZbvhZ2cFcMn7tXTR1T6epCQDbw==
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

Hi,

Since Sandor left NXP some time back, I'll be taking over this patchset
and continue the upstreaming process from where he left off.

The patchset adds initial support for Cadence MHDP8501(HDMI/DP) DRM bridge
and Cadence HDP-TX PHY(HDMI/DP) for Freescale i.MX8MQ.

I addressed all remaining reviewers' comments from v20 but I'm not sure
whether Alexander's issue is still present. Alexander, let me know if
you're still experiencing a black screen with this patch-set and I'll
try to address it in the next revision.

--
Changes in v21:
 - Dropped "phy: Add HDMI configuration options" patch because it was
   already merged separately;
 - Rebased to latest linux-next (7.0-rc6) and fixed all issues
   introduced by API changes in DRM;
 - Addressed Maxime's comment on patch #5 and used debugfs file instead
   of sysfs for printing firmware version;
 - Addressed all Dmitry's comments: handled the
   cdns_mhdp_mailbox_send_recv_multi() error, removed the RGB 10bit
   unused code, added a dts property in order to get the bridge type (I
   couldn't find another way to do it...);
 - Dropped Krzysztof's r-b tag for patch #4 (which is now patch #3)
   since I added a new property;
 - Link to v20: https://lore.kernel.org/r/cover.1734340233.git.Sandor.yu@nxp.com
 
Changes in v20:
 - Patch #1: soc: cadence: Create helper functions for Cadence MHDP
 - Patch #2: drm: bridge: cadence: Update mhdp8546 mailbox access functions
   - The two patches are split from Patch #1 in v19.  The MHDP helper
     functions have been moved in a new "cadence" directory under the
     SOC directory in patch #1, in order to promote code reuse among
     MHDP8546, MHDP8501, and the i.MX8MQ HDMI/DP PHY drivers,
 - Patch #3: phy: Add HDMI configuration options
   - Add a-b tag
 - Patch #4: dt-bindings: display: bridge: Add Cadence MHDP8501
   - remove data type link of data-lanes
 - Patch #5: drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
   - Dump mhdp FW version by debugfs
   - Combine HDMI and DP cable detect functions into one function
   - Combine HDMI and DP cable bridge_mode_valid() functions into one function
   - Rename cdns_hdmi_reset_link() to cdns_hdmi_handle_hotplug()
   - Add comments for EDID in cdns_hdmi_handle_hotplug() and cdns_dp_check_link_state()
   - Add atomic_get_input_bus_fmts() and bridge_atomic_check() for DP driver
   - Remove bpc and color_fmt init in atomic_enable() function.
   - More detail comments for DDC adapter only support SCDC_I2C_SLAVE_ADDRESS
     read and write in HDMI driver.
 - Patch #7: phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ
   - implify DP configuration handling by directly copying
     the configuration options to the driver's internal structure.
   - return the error code directly instead of logging an error message in `hdptx_clk_enable`
   - Remove redundant ref_clk_rate check
 - Link to v19: https://lore.kernel.org/r/cover.1732627815.git.Sandor.yu@nxp.com

Changes in v19:
 - Patch #1
   - use guard(mutex)
   - Add kerneldocs for all new APIs.
   - Detail comments for mailbox access specific case.
   - remove cdns_mhdp_dp_reg_write() because it is not needed by driver now.
 - Patch #3
   - move property data-lanes to endpoint of port@1
 - Patch #4
   - get endpoint for data-lanes as it had move to endpoint of port@1
   - update clock management as devm_clk_get_enabled() introduced.
   - Fix clear_infoframe() function is not work issue.
   - Manage PHY power state via phy_power_on() and phy_power_off().
 - Patch #6
   - Simplify the PLL table by removing unused and constant data
   - Remove PHY power management, controller driver will handle them.
   - Remove enum dp_link_rate
   - introduce read_pll_timeout.
   - update clock management as devm_clk_get_enabled() introduced.
   - remove cdns_hdptx_phy_init() and cdns_hdptx_phy_remove().
 - Patch #8:
   - move property data-lanes to endpoint of port@1
 - Link to v18: https://lore.kernel.org/r/cover.1730172244.git.Sandor.yu@nxp.com

Changes in v18:
 - Patch #1
   - Create three ordinary mailbox access APIs
       cdns_mhdp_mailbox_send
       cdns_mhdp_mailbox_send_recv
       cdns_mhdp_mailbox_send_recv_multi
   - Create three secure mailbox access APIs
       cdns_mhdp_secure_mailbox_send
       cdns_mhdp_secure_mailbox_send_recv
       cdns_mhdp_secure_mailbox_send_recv_multi
   - MHDP8546 DP and HDCP commands that need access mailbox are rewrited
     with above 6 API functions.
 - Patch #3
   - remove lane-mapping and replace it with data-lanes
   - remove r-b tag as property changed.
 - Patch #4
   - MHDP8501 HDMI and DP commands that need access mailbox are rewrited
     with new API functions created in patch #1.
   - replace lane-mapping with data-lanes, use the value from data-lanes
     to reorder HDMI and DP lane mapping.
   - create I2C adapter for HDMI SCDC, remove cdns_hdmi_scdc_write() function.
   - Rewrite cdns_hdmi_sink_config() function, use HDMI SCDC helper function
     drm_scdc_set_high_tmds_clock_ratio() and drm_scdc_set_scrambling()
     to config HDMI sink TMDS.
   - Remove struct video_info from HDMI driver.
   - Remove tmds_char_rate_valid() be called in bridge_mode_valid(),
     community had patch in reviewing to implement the function.
   - Remove warning message print when get unknown HPD cable status.
   - Add more detail comments for HDP plugin and plugout interrupt.
   - use dev_dbg to repleace DRM_INFO when cable HPD status changed.
   - Remove t-b tag as above code change.
 - Patch #6
   - fix build error as code rebase to latest kernel version.
 - Patch #8:
   - replace lane-mapping with data-lanes
 - Link to v17: https://lore.kernel.org/r/cover.1727159906.git.Sandor.yu@nxp.com

Changes in v17:
 - Patch #1:
   - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
 - Patch #2:
   - remove hdmi.h
   - add 2024 year to copyright
   - Add r-b tag.
 - Patch #3:
   - Add lane-mapping property.
 - Patch #4:
   - Reset the HDMI/DP link when an HPD (Hot Plug Detect) event is detected
   - Move the HDMI protocol settings from hdmi_ctrl_init() to a new function
     cdns_hdmi_set_hdmi_mode_type(), to align with the introduced link reset functionality.
   - Implement logic to check the type of HDMI sink.
     If the sink is not a hdmi display, set the default mode to DVI.
   - Implement hdmi_reset_infoframe function
   - Reorder certain bit definitions in the header file to follow a descending order.
   - Add "lane-mapping" property for both HDMI and DP, remove platform data from driver.
     lane-mapping should be setting in dts according different board layout.
   - Remove variable mode in struct cdns_mhdp8501_device, video mode could get from struct drm_crtc_state
   - Remove variable char_rate in  struct cdns_mhdp8501_device, it could get from struct struct drm_connector_state.hdmi
   - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
   - Remove mutext protect for phy_api access functions.
 - Patch #6:
   - Remove mbox_mutex
 - Link to v16: https://lore.kernel.org/r/cover.1719903904.git.Sandor.yu@nxp.com

Changes in v16:
 - Patch #2:
   - Remove pixel_clk_rate, bpc and color_space fields from struct
     phy_configure_opts_hdmi, they were replaced by
     unsigned long long tmds_char_rate.
   - Remove r-b and a-c tags because this patch have important change.
 - Patch #4:
   - Add DRM_BRIDGE_OP_HDMI flags for HDMI driver,
   - Introduce the hdmi info frame helper functions,
     added hdmi_clear_infoframe(), hdmi_write_infoframe() and
     hdmi_tmds_char_rate_valid() according Dmitry's patch
     'make use of the HDMI connector infrastructure' patchset ([2]).
   - mode_fixup() is replaced by atomic_check().
   - Fix video mode 4Kp30 did not work on some displays that support
     LTE_340Mcsc_scramble.
   - updated for tmds_char_rate added in patch #2.
 - Patch #6:
   - updated for tmds_char_rate added in patch #2.
 - Link to v15: https://lore.kernel.org/r/20240306101625.795732-1-alexander.stein@ew.tq-group.com

Changes in v15:
 - Patch #6 + #7:
   -  Merged PHY driver into a single combo PHY driver
 - Patch #7 + #8:
   - Add DT patches for a running HDMI setup

Changes in v14:
 - Patch #4:
   - Rebase to next-20240219, replace get_edid function by edid_read
     function as commits d807ad80d811b ("drm/bridge: add ->edid_read
     hook and drm_bridge_edid_read()") and 27b8f91c08d99 ("drm/bridge:
     remove ->get_edid callback") had change the API.

Changes in v13:
 - Patch #4:
   - Explicitly include linux/platform_device.h for cdns-mhdp8501-core.c
   - Fix build warning
   - Order bit bpc and color_space in descending shit.
 - Patch #7:
   - Fix build warning

Changes in v12:
 - Patch #1:
   - Move status initialize out of mbox_mutex.
   - Reorder API functions in alphabetical.
   - Add notes for malibox access functions.
   - Add year 2024 to copyright.
 - Patch #4:
   - Replace DRM_INFO with dev_info or dev_warn.
   - Replace DRM_ERROR with dev_err.
   - Return ret when cdns_mhdp_dpcd_read failed in function cdns_dp_aux_transferi().
   - Remove unused parmeter in function cdns_dp_get_msa_misc
     and use two separate variables for color space and bpc.
   - Add year 2024 to copyright.
 - Patch #6:
   - Return error code to replace -1 for function wait_for_ack().
   - Set cdns_phy->power_up = false in phy_power_down function.
   - Remove "RATE_8_1 = 810000", it is not used in driver.
   - Add year 2024 to copyright.
 - Patch #7:
   - Adjust clk disable order.
   - Return error code to replace -1 for function wait_for_ack().
   - Use bool for variable pclk_in.
   - Add year 2024 to copyright.

Changes in v11:
 - rewrite cdns_mhdp_set_firmware_active() in mhdp8546 core driver,
   use cdns_mhdp_mailbox_send() to replace cdns_mhdp_mailbox_write()
   same as the other mailbox access functions.
 - use static for cdns_mhdp_mailbox_write() and
   cdns_mhdp_mailbox_read() and remove them from EXPORT_SYMBOL_GPL().
 - remove MODULE_ALIAS() from mhdp8501 driver.

Changes in v10:
 - Create mhdp helper driver to replace macro functions, move all mhdp
   mailbox access functions and common functions into the helper
   driver.  Patch #1:drm: bridge: Cadence: Creat mhdp helper driver it
   is totaly different with v9.

Changes in v9:
 - Remove compatible string "cdns,mhdp8501" that had removed
   from dt-bindings file in v8.
 - Add Dmitry's R-b tag to patch #2
 - Add Krzysztof's R-b tag to patch #3

Changes in v8:
 - MHDP8501 HDMI/DP:
   - Correct DT node name to "display-bridge".
   - Remove "cdns,mhdp8501" from mhdp8501 dt-binding doc.

 - HDMI/DP PHY:
   - Introduced functions `wait_for_ack` and `wait_for_ack_clear` to handle
     waiting with acknowledgment bits set and cleared respectively.
   - Use FIELD_PRE() to set bitfields for both HDMI and DP PHY.

Changes in v7:
 - MHDP8501 HDMI/DP:
   - Combine HDMI and DP driver into one mhdp8501 driver.
     Use the connector type to load the corresponding functions.
   - Remove connector init functions.
   - Add <linux/hdmi.h> in phy_hdmi.h to reuse 'enum hdmi_colorspace'.
   
 - HDMI/DP PHY:
   - Lowercase hex values
   - Fix parameters indent issue on some functions
   - Replace 'udelay' with 'usleep_range'

Changes in v6:
 - HDMI/DP bridge driver
   - 8501 is the part number of Cadence MHDP on i.MX8MQ.
     Use MHDP8501 to name hdmi/dp drivers and files.
   - Add compatible "fsl,imx8mq-mhdp8501-dp" for i.MX8MQ DP driver
   - Add compatible "fsl,imx8mq-mhdp8501-hdmi" for i.MX8MQ HDMI driver
   - Combine HDMI and DP dt-bindings into one file cdns,mhdp8501.yaml
   - Fix HDMI scrambling is not enable issue when driver working in 4Kp60
     mode.
   - Add HDMI/DP PHY API mailbox protect.
   
 - HDMI/DP PHY driver:
   - Rename DP and HDMI PHY files and move to folder phy/freescale/
   - Remove properties num_lanes and link_rate from DP PHY driver.
   - Combine HDMI and DP dt-bindings into one file fsl,imx8mq-dp-hdmi-phy.yaml
   - Update compatible string to "fsl,imx8mq-dp-phy".
   - Update compatible string to "fsl,imx8mq-hdmi-phy".

Changes in v5:
 - Drop "clk" suffix in clock name.
 - Add output port property in the example of hdmi/dp.

Changes in v4:
 - dt-bindings:
   - Correct dt-bindings coding style and address review comments.
   - Add apb_clk description.
   - Add output port for HDMI/DP connector
 - PHY:
   - Alphabetically sorted in Kconfig and Makefile for DP and HDMI PHY
   - Remove unused registers define from HDMI and DP PHY drivers.
   - More description in phy_hdmi.h.
   - Add apb_clk to HDMI and DP phy driver.
 - HDMI/DP:
   - Use get_unaligned_le32() to replace hardcode type conversion
     in HDMI AVI infoframe data fill function.
   - Add mailbox mutex lock in HDMI/DP driver for phy functions
     to reslove race conditions between HDMI/DP and PHY drivers.
   - Add apb_clk to both HDMI and DP driver.
   - Rename some function names and add prefix with "cdns_hdmi/cdns_dp".
   - Remove bpc 12 and 16 optional that not supported.

Changes in v3:
 - Address comments for dt-bindings files.
   - Correct dts-bindings file names
     Rename phy-cadence-hdptx-dp.yaml to cdns,mhdp-imx8mq-dp.yaml
     Rename phy-cadence-hdptx-hdmi.yaml to cdns,mhdp-imx8mq-hdmi.yaml
   - Drop redundant words and descriptions.
   - Correct hdmi/dp node name.

Changes in v2:
 - Reuse Cadence mailbox access functions from mhdp8546 instead of
   rockchip DP.
 - Mailbox access functions be convert to marco functions
   that will be referenced by HDP-TX PHY(HDMI/DP) driver too.
 - Plain bridge instead of component driver.
 - Standalone Cadence HDP-TX PHY(HDMI/DP) driver.
 - Audio driver are removed from the patch set, it will be add in another
   patch set later.

---
Alexander Stein (2):
      arm64: dts: imx8mq: Add DCSS + HDMI/DP display pipeline
      arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI support

Sandor Yu (6):
      soc: cadence: Create helper functions for Cadence MHDP
      drm: bridge: cadence: Update mhdp8546 mailbox access functions
      dt-bindings: display: bridge: Add Cadence MHDP8501
      drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
      dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
      phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ

 .../bindings/display/bridge/cdns,mhdp8501.yaml     |  131 +++
 .../bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml       |   51 +
 .../boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   |   27 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   68 ++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |   11 +
 drivers/gpu/drm/bridge/cadence/Kconfig             |   17 +
 drivers/gpu/drm/bridge/cadence/Makefile            |    2 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-core.c    |  378 ++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-core.h    |  383 ++++++
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c  |  695 +++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c    |  770 ++++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  487 ++------
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |   47 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    |  212 +---
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h    |   18 +-
 drivers/phy/freescale/Kconfig                      |   10 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c       | 1231 ++++++++++++++++++++
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/cadence/Kconfig                        |    9 +
 drivers/soc/cadence/Makefile                       |    3 +
 drivers/soc/cadence/cdns-mhdp-helper.c             |  572 +++++++++
 include/soc/cadence/cdns-mhdp-helper.h             |  129 ++
 24 files changed, 4593 insertions(+), 661 deletions(-)
---
base-commit: ec07eff1fd1ed6c4dca399aee4e8da15856589f0
change-id: 20260406-dcss-hdmi-upstreaming-28998a88e911

Best regards,
-- 
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
