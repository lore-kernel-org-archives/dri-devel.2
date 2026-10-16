Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750ECCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15AD710E354;
	Fri, 16 Oct 2026 19:05:05 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013002.outbound.protection.outlook.com
 [40.107.162.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A56810E354
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 19:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypW73tXkG6aS4+UgSlqXCYgXut6TKrZgC8MieUFxQ8cJDO1mkWoxGJpefIoCP1x0FDOQh9yzqsmlfDOHV6tCc0s3S7s5LwtpFgO+1y3t2skIlIkZr7/Bxz81+BT2LzDj+L1x8QWOPj7A6qBH6wzG6YCjmWt4yzmYnffLEvHz6suXvfrH4cXOnOkMEND1pgPt3Du/Vh1vWh7vuNxQLMJ9KnFgbeHzS/ol5NMhF5b96HGhpiRLjzgIxd3T04Dp7j3eZlTwUAZ32WH8TBH4e+zGLATrwqWvxtGUV5qaN3ECL9nSRBwfOinX/dfcT1+gOCnilu+s1BsuFR9nSs50VdS9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp1V6+JKo9ljK1Y+99OBj4L13kUOHax6svosKs/vEn8=;
 b=ar46LjvZbbXeG/SW/E9eztosVnD6nyXTizTn3PAgS5M7HvrecyQVFSD8VZdEDSxLbUcza9loUFWo3Y3KCTbKRFqxLLYJW1mtfY+jnOnyyqF/+YV8dLD21cfFV51Saaau8jgxftTjh4Drb6xU+6N96FNloNkd+ZSTJHa8ICngqep5N+ASm+baWL0MzJAH7fFO2KGZfbRaXkq+Um23qqtKv8RdpDMlN238ukJhhhMBqmvr4cySqYEx6YkliIkv//SzDynUBF1q34qJl0ZrtivEvJkvWGB2QwjgmGeTdat8odUcohIfVqyephG8lTLsq7S34rcR2YqxGxFMbXLNIWZ2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp1V6+JKo9ljK1Y+99OBj4L13kUOHax6svosKs/vEn8=;
 b=GmrLJQ2srYaqdixtJpjEWcj284TTMvwBJ5/MbXId0kpN2dTuMlaVNQHgTB2ttrSaCpy98Mr4/81d9488o4SCCgzdyefFM8q7udV6DbWq661ltDKGuJqG7L8GlJ87uTyxs7jI9hxjbIM96DClt3dd9Ut6vb0CAfxmz3na2v3I4paDLkyPwbJL7wPM021KfPAtZZBb4W9Sj0sBPnHQNNl5U6ZEtXKKkqKCIBLZrvjiv7oGyBZ3Lkn1AmpU4222mq6Xylape81+CN/VDAdstGYD8ISwdXuzKtJ4s5aAPkhwmyoxWeLSgoVasb/PEGKkIxiSiyUlCe7NFZ3+WJrvhZo6MQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 19:04:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 19:04:54 +0000
From: Frank.Li@oss.nxp.com
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] dt-bindings: display: sgd,
 gktw70sdae4se: use unevaluatedProperties
Date: Fri, 16 Oct 2026 15:04:47 -0400
Message-ID: <20261016190447.752297-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:510:23c::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3a247b-18a6-4c91-65aa-08df2bb85d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|921020|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: vqUgRdZO2txkhWXRTPlG7sTT9FgbvT3YzzTXRdBj5FIH15866kSt7EABUyygscXR4XPZYUPqJtV+I8d9cSnyZfnlQhoqf3u2RoBRp70VZzbh3UVMXmnrgLmShYUdqjh6e3ramacE9vVti/OHA0kCeFcnbRpTDYtXiRNrkiP9buvIzkb8sqNwd15BLoQGbiePAOElEeVq1BuUiN1LKMeTH/AfbmYzzbILr7CCgFyG2Po+EKPagJ61+reU1oC2NVXBEsUi0beaOxitGCaqgkeG34sfDeTkG3bKAKUhKFMebtfXwVyrTNSpxfWwItU8vakXshhGs894JcC2NxtFFZnEvACA56wndL9itwCYbjcrQZgUekdAUx00Jd7pv46PsKcMcCwiRPJ0rqNbLeVuHFXZrqK6YJoMSHsELTHIcu7eRBG2W0Yk2RNUoFyMQqUSz8GnXLtkJdPpNAv8uFFVjrs+Z6qAlMeMKPQFq3SUejihcz5dg81Y1bNjKOP/YEzqI25N+caNGm0rJQa16DKNBv+/gUv1n8piVQN2MI0FV+uk0S1CyXDxa5fvp9Iv+e45sECfA18vSBDD5IMwnzrFPguK2hpoKxFGPNBhsnvdq7ClIiQcaiDlWLaQADm+NK8ykfctEUzwaLkCQnzt5xVy2wjn8absxfUSFgWCw2a25mJad30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(921020)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cMAVvEV0v4Iax+vf96QHk0mOW9gHLzMrXAehdMbI86LPfVxD1cjJIsFqnwAs?=
 =?us-ascii?Q?/HQPWQAi6vbR6cBLEoq+oUfl8+FEUQHy9h7BoWAsvPLMuSBvW68XI/tGqN3L?=
 =?us-ascii?Q?tCE2Kh1okciCja0BRUwefwa60kGmp0s+RZ+19w65Br8Y22asoh2GLxS4yuZb?=
 =?us-ascii?Q?Mw3astuZ/9y2xYUJZBzCdt7q4gIBXclb6ZzMApycVDgSHR+uE0ogeHiKUi4x?=
 =?us-ascii?Q?SQoWYZ5wXo+TYmY4PoBv4Lu4395VPB4v2UlVKANTYLEbYCQ5jwGlmqHsARvd?=
 =?us-ascii?Q?gxZGH5tS6eJ/n8pwHvo0jHj+pHWeKjTaoDes8b8DLZK6+RnYylzMbv+e/dU+?=
 =?us-ascii?Q?pfn0YnHmx0dxZoA92FE0AbTfLK6M0DxtLM4UmjkURnvytEUeGguSuPgWFzj2?=
 =?us-ascii?Q?SbsJK8czfWaUl6U8sYQGHrHkSyGVgUoubBEOmJzEwMiDXr4Grg7tlr/9IJsd?=
 =?us-ascii?Q?CxH8mrI0dKHHDZ4Qq7nvGY3zJOisIrdrXgd7Vsta2YiHzXBwP3XrR+rMMylH?=
 =?us-ascii?Q?dakIM9cMX8M9k8jwKV99RHpX3JAbxG0a28oscW19vW72e8zcmNpFKrUF995Y?=
 =?us-ascii?Q?zsS1L0asatNMFof2uMiHZAWtJVkemu9SZZSENpKof2zSmCsCMaSpP6Edk0dv?=
 =?us-ascii?Q?ccv7buK5w3yy7FKYdYbC0pweEz12gMOTQyWrXv4PeQYge/IUcnts6XPYOAtQ?=
 =?us-ascii?Q?W7pN38ZfXk+yPPwdLnyQWOqPD648DynNkGCoX2BSWUtshVXoW2sKXfy8/hWB?=
 =?us-ascii?Q?LNPLGDNo6LvaFYQ24Yx2yQVFqh4Eho2iMtIMUToTcNkV10eht2cW309MOP2P?=
 =?us-ascii?Q?0Kd3T1KNq9lUTAQLgrIpYeIZGWB7w6PG5R4EtGMtxuDuXCkYR20POzF5HSih?=
 =?us-ascii?Q?AwLvg6W4rP1vCCMHk/hobEL7d/cMO8gDjMtMWU+b53e7SR+5y/htSTPUQ2I8?=
 =?us-ascii?Q?4ZoHzcrPtSXjYc1gcywx9j+bgSy0ybQiGZ5anqiY/lUogRDdRMi4Ob1ivOYj?=
 =?us-ascii?Q?dkupsZnoudHt3PuLmL3q66UpbJgq80C2HFCDDbULUAL5DqQ7YNkHPIaeOYWw?=
 =?us-ascii?Q?14fjPAZluYphv44LIes4sXV46QaJzniYY1311XntgjLpgWQNYyJ9gVx0C+H/?=
 =?us-ascii?Q?U5ZF5gG0AOTdsuWlHHmzeown/iTOjuYpNZxnJKg/NAhUH5Fto7/NwjPGT/vo?=
 =?us-ascii?Q?sJILGXYReO0HWrhCnkQz1YNHS6YHxuah8a1eNMRQv9b1GG9XKeMTS0wGeiIX?=
 =?us-ascii?Q?WujJVN1384KVfBB/j3Zk0dMtBImsMBEoGelDNJzG6SXWumnWMGXU0nHhXzFw?=
 =?us-ascii?Q?L+t2CW3uU0DXQoIt0qyomFL2LbZElK97wzDGBaM86CUUjBvtqgkwr5pt2qb+?=
 =?us-ascii?Q?oHnpwNU4b7+ZB2LiXb/EXhz8Ni+Ai34WD+mUM5a4R/H/ATMYgEdPCCDZNjjK?=
 =?us-ascii?Q?u4brVPtJyDbBhKMg75DdHXJiW7nc8w4fqid8as/4hRLkWFNZ1TkoF1b7OLLv?=
 =?us-ascii?Q?/dJqVP3GWxvY/kT7StB+fUn9x9546tW3IX4MOpM0tR4sLRtrW2KrzeTyNAMo?=
 =?us-ascii?Q?GW2kJ3McME7YkHtPXKVXNXAcbD1h2rSm0BOc/lIr6oSTK3A4sEljVc0PPMGR?=
 =?us-ascii?Q?nS34lXgfgFVWeGIYuYoWuxv/+Aq/89revAJ6FEkt5WQvi7Ntx94sEtY/7Glm?=
 =?us-ascii?Q?fVooztD7Q0kGyOGlt0tGLrKVWNPTJ/QiFtZt0zczce0e08TUdN9YQbSdVM0D?=
 =?us-ascii?Q?JENUK+tjiHOtd257XNbDNbV/9EdrelXUE2IUYlGE6WksY1dmonJs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3a247b-18a6-4c91-65aa-08df2bb85d02
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:04:54.6162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov/282pHgx+1tBl/iOQOhE3iNAzt1kqEjKVd0ZovYqYiiWoI1PNGqMw2VgHDMlooSZfeMOXWuJUUGFSN0wVSvcr5ij6gQETejhOqxZ3vaNfVN8BxYfoUazPghvgSQr33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9559
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

From: Frank Li <Frank.Li@nxp.com>

Use unevaluatedProperties replace additionalProperties because it ref
other yaml file to allow backlight and label property.

Fix below CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dtb: lvds-panel (sgd,gktw70sdae4se): 'backlight', 'label' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/display/panel/sgd,gktw70sdae4se.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
index 1beb4ba92248b..4c70576fe8a8f 100644
--- a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
@@ -49,7 +49,7 @@ required:
   - height-mm
   - panel-timing
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |+
-- 
2.43.0

