Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BEFCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C7010E52A;
	Mon, 22 Jun 2026 08:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuSJ+pI+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CC210E52A
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtMBZVheRKG85Pr41audW4crd7zOCb8ZQ/oPsh1IU8SIJb2tuWDZ2lsr/3r8+2z2Wnr+kxdxQC6X2engmft7858lpmTVVbiWroLxRYmS9v5RF8MU4Vqmb720URSnfQKz5OpTeE5auLZhnpg6W99Xy6sJQAIiKbYPDB/hyTmmGPlTcnK1xR3WaSJc7FB/vi0tiX1nc2Q34E3nCZZO8qgrl3MM8xqBXpPhsnhFnrLDDMH5I7Q4x02k1YL4Hty0fQ43INiAxLLkBeB5cZ3QkQhDwJLr8IEHelJ/5E6243U/OXgZMV9zmhVY7QENyIZCNxazc/P42Qab8zW3DgZJjdvFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93cc9BeDG5uECv2VG76s+4W14K/ykltOxWg+xjPZ1zU=;
 b=vxWBjUiypzX/GlnnyOxg9c3WnbyxB46tn1QYi2+E0gU+9XUuqyNQyh2+rEMVaE9eeSbzk++yQ/DFQGrx0abWuS80ANwi5lUE9VUMe+HjI3cYD8vzxfuuewRSv+6sHekI74r0//r8bX+oJVlg5tZiPp7v6O11pZhPXynnlyiIWpwpzMBalHQfZav6Y/oLho0VTSuwefGLOrsGTAiVSznOrzRAsb69BAFeCdszjFufNKEEm1PQI/+/AHzxeEdRpVnVrI/0AEnGpD1q6Zr+OM/0UQNxHMoAT+A0Cb9oPnpYiMfNm0wLZxSlBpSscal8JGdf5smRooVb/+Zf2YF5ITyBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93cc9BeDG5uECv2VG76s+4W14K/ykltOxWg+xjPZ1zU=;
 b=XuSJ+pI+Dl14D1Ag5TmdIJd3mm2WsyuHwEL6p2aGAhkByKSs3Dav0xdPFFxRcfK1D2kFvH6/0gKf8KS+oP31TeQh6vu7/8SZI68BOplyxjDgfhHyRoeyLsSQ04V4wD8wC4WORxbn4CQLAephVua/hQg3+Ezdq4GZBVE2F46PRY8QX09QMEO2BLTBbezIF/sKa6bE5tiwdEL83EMiUzp9pt59VbDqM06AWXASkgRint/nzxjD/d6J59GwRzDM6SeUY1BZu649pH2dt5tNBnFuxU1AJOnLTAGBW/cgfu23poRKNmA+dqVD9aVLjfqwm3shey9LzJaw1Nbc4A+OoEXDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:23:06 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:23:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 17:22:51 +0900
Subject: [PATCH 2/4] dt-bindings: display: tegra: Add channel/syncpoint
 range properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-host1x-nohv-v1-2-65bc682a617f@nvidia.com>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
In-Reply-To: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS3P301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21d::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7e6f43-0745-437a-772a-08ded0377c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|921020|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: o5L7yk/pU4ZjTmikZfV4SSLxTwVkKMgMmgn3PwZLfsjkAse4CINOREwkD2x0yTOKeqAAusOnl3tN3WDlncOFAPHcB8yo/aCC8w1uWTX0GMvS5GVLwM1uXIWUqGHPUmtSDZNjOE5pRqy9eRoIrLIM8AvLQarIaQ2+9u3qquQFkdHQGOwBOUWBLodTHvkiyzrjHoGmLpsaSZB+IN4jCsk7mRuJVQBGd8rq2oD9SUcmRv8Xtx8Jm7/PgEjALCYe6HkwgcM8L5gQwB/KNWqZg7iXvbetYlinCqKLJcOvxj48y85K/IEeA3mhRReAlNpFCDI/tQhsYnSAb6VKaQOhTTfKPsH3kRsUb6zQBx6raU4hslGmR3IQ2RVyLdB3QYIbyEk8wzchXqupsobtM/sZQc8+f/tbcobnTTzbH+duxzqMJXGrbITV91arz69XHbXP33hGHpBQdqq2pLKmOobn9yT4IR42sFgGUGgb02uvPZmDxi3o4pCQ1vVEl9rHBPbdebhI+ZQR/M1JDoohDSuPCUKpvxDDJmjyj0pj0cSXUhkZu1cXRnYzUHco6XyNTAcVkEK934QW/EyzmUuIvE06VFzK5EnJgjjklrwT7VpT1TyBJoNx/Glu1QKW8Ni4NrGA8TE3++CEsnUh4omUTuRtcQNOJjdf9ikLqHljEIzPsNCexeIhokphs7HgIvZ9aDzMEp5ZWF7QVAiarfwgal7MnrCVUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFdCdEp3ZElEcUt6TnF2V0wrTHFGc1JPMjZaYlhqUUVWWmVDaTVIVUgyaXpZ?=
 =?utf-8?B?YlJBUEF5OG5Za2tKV1RMNTR5S2pWWExPNnNqTWV5Sm5hZlA3TGVlUEZGSE16?=
 =?utf-8?B?NTdMOW5BZjM0dGlNL2kxdlhUaHNYL01jc2duMHppZjhjZmZwa1o4VXRKZmY5?=
 =?utf-8?B?bTlFdWxYL3BkQlFFUFNsWFJ3VHlMVXh1czR5eFlYbEdxZDlQRDJlR0lYZGhR?=
 =?utf-8?B?YmNOeWY4L3dOY1AvZ3dNVDF4Q3RDcC83dDlmT21KR0pid2dWV0FncXdsSXRy?=
 =?utf-8?B?aHk4Z2o4Um1DcXZGbTVpV1djS3dITTBZNDRkc0FhM1g4RSs1RVI0YTFpUitD?=
 =?utf-8?B?amJlV3ZFSndvajZFSTRiYnd6ZEk1SGV6K1FLa1JjcGJ1clBBVVk4aGs4NEp4?=
 =?utf-8?B?QnR1M2ZlYnBNT2o3bWh2a3hPVmIvbEllUDRWSHdNQWpyL251UEtrMHRqSFR5?=
 =?utf-8?B?dUUwU2lkYTBmVzE0cEJVaCtmbGZVK0gwbmh5ZndhZHFraFNucEwrRVBmOG5Q?=
 =?utf-8?B?STYxYlVFWTlRVG01WEVaaEJsRXlWVzZCY2FhVG9lTjRJNjZZajlKY0tKUktL?=
 =?utf-8?B?TU5BeGpmTFNvWHRNWFZRREU3aUVmRW5CaU5RV0hWZlptVW5iazJETWNlQzda?=
 =?utf-8?B?MThrQzB2QTdzU2NLQkFqejNYMy9seklJbnhhUTlyMUVQWC9aNjZiU2NmZGJm?=
 =?utf-8?B?Nzc4dy92YVR0cUhScDJDeEszNm9HeE83TStzZ2h4M2w5R0FwempYN203eHdL?=
 =?utf-8?B?eDA4b2hSRmtlR0w5Z25XRFM2aGpkVmtqcGxwUHdmYTNOaXRDM3hyQjhKQUEw?=
 =?utf-8?B?MkRWSW5UZ3l5aXJTb2luYmRiSjBmajFaUmtMbWN1dWxZdjF5OUx6aWJRRnRW?=
 =?utf-8?B?Y2RrWDFyL2tiQ3NJVXc0b25GMU5nRnk1ZGkyamlPMjNFdFlJKzhGS1lWcDVm?=
 =?utf-8?B?Tm1UR2oxdDB5YVc1bXJNQnR6azVxUUgzMHlYUVo5ZWoxb1BHdzNodlhscGRC?=
 =?utf-8?B?MldyS0ltSmJBcWFtRUkwRWI2ZDZWOFJ3cCtjMmE3VDhIL2QzazRBa3FCei9Y?=
 =?utf-8?B?aXRMaEs5Q1NaT0FsQytRSzhSUlJOYmlLdXhEelVZQlZxaysxZUczbUU4bExS?=
 =?utf-8?B?OWdkNndHTk05NlVrblkzSVN3MDliam1EWFpHNEpSTEVKeUZhTllGVzZXa3Av?=
 =?utf-8?B?UTduT05odVJ3NDJYSExKRERGeFByRDJLOFN6bTBtSkc0SERUc2hNK0FrMy9Y?=
 =?utf-8?B?eUdraFNFWWxGWU5oOEphbllJMmV4VkxhWUxaODk1b0k3WkNDTkxHWFE3UGRw?=
 =?utf-8?B?SzZkcXNmcGUweERSdG1RSzFrS2l6UmxCRE9TRVZhVVE1amRSVzN3aUxtUmJy?=
 =?utf-8?B?Q0I5RDBGMkRrcTVXSWlVekd2bGxqa1pxbEErbjRyZENaOUg0WHVHdU5rb3pL?=
 =?utf-8?B?TWd3ZXlBajJaTE44RktkUXlxNDJEanhERVhWek1FSUM3V1h2aTRsdC9Vc21V?=
 =?utf-8?B?NW00eTVydU1IT080aDV4WkFSUWdmL3JXVjlhZUZDc2Qyd0g4OHZIVFFRTkwr?=
 =?utf-8?B?ZFZ5bDZnM1FDN3QyS2NPcFFlS2lhMmc0YUtyUmhrKzVWWDlwWkE4ZVRZQllh?=
 =?utf-8?B?b3o1bE84MWRQWnlGQytueWNHT2wzVWdUYTR6TTRuZUFwaE9pZitJMjdrRUtC?=
 =?utf-8?B?ZWw4V2E5QUNEb3BrdW9nelZYcFpCR3lZNE1FZk1Vb3FCQzg2OWFudkpoa0h5?=
 =?utf-8?B?OU45YkxBeFJuN0R2MmIvL2ErdkFwNmJXbzh1dGxBRFFQTlAxcGlOQWRGUXp5?=
 =?utf-8?B?Yy9uaU5KT2UzQUc3ajI0SmVXdE5BYlJhVmZySlhmL2J2a1d1SE1yYWxUWERF?=
 =?utf-8?B?M3g1NVhkNE14bEVOTzRWM1pNYUdObm1YTUFyaDdEd3RLWk9TYVFiNnJRcThx?=
 =?utf-8?B?czJKd2ZPMGtWTVpteUxtbmloTFBCbnBMN1ZRMWNOZjk3bktqNWhQM0hjUk9k?=
 =?utf-8?B?dWtybElTZDVHK055Q2phdXFEK1Jkd01OUUhHejRwbStyZ1VIcDdEZFk4Rjhr?=
 =?utf-8?B?YXJIR2s5eG5kNEtnZEdEOElaMlZoVzJybVhJdk1rVWhQV25iS1Z0SUJuUU83?=
 =?utf-8?B?Mm83NVB0TTNvVlBOTHNtUjNSUUpRYzhhWWQ2WjJ1Unh0OXlQNFg2OHNQbjds?=
 =?utf-8?B?NEVVU2ljbzl0VzREZldMeEhjcWZXNzBIY0xqMkVqQzFPUk1SSWJEa1hIUWgy?=
 =?utf-8?B?MXZYOWlYZDh6anlDTHpnZ05rcnQ5L2Rzck1pdDB2TW5tbVdYdnc3NlhFTlli?=
 =?utf-8?B?d3JGd0dFZ1RUMzh4Si9GSmVYOWNnYzJwNlVmRStoL1BtSkl6YlVIckg2ZG85?=
 =?utf-8?Q?mmlXlFh/N/XlVrTXepczqgVe65VgkCgfBSmD7HZX2TrKD?=
X-MS-Exchange-AntiSpam-MessageData-1: Pxcw4awDsK3U4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7e6f43-0745-437a-772a-08ded0377c38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:23:05.9911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koSayt3dCFLzIDVm3NTkstAzQf2GpD9QhWNR4SJmFbYdB9/y0oMkSl1WCUXEkU/qcz2IY+OARS/DN+1eXvh0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

Channels and syncpoints available may be limited when other system
components are using them. Add properties nvidia,channels and
nvidia,syncpoints to limit the range of usable channels and/or
syncpoints.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index ffd0ed857d28..7a543b8b2f3d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -96,6 +96,18 @@ properties:
     items:
       - description: phandle to the HEG or core power domain
 
+  nvidia,channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: Describes usable channel range as a <base count> tuple.
+
+  nvidia,syncpoints:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description: Describes writable syncpoint range as a <base count> tuple.
+
 required:
   - compatible
   - interrupts

-- 
2.53.0

