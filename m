Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A719CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6783E10F277;
	Fri, 12 Jun 2026 06:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TpWHoSek";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C425610F277
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqkwIc9zkCit69gW8eC40KbWibRM9xlAQl4exxa41C6G8mOu81fA4RXTqV6ttFIAUnQyizFi7hFMVVXA6ZFf+YWA5vSmqpPSZr6CtZ7TSL4jzMlFfakUN/9IRV+t7iVc1OxqmtNUs3geEiXTORYEmTUblaFKaVI6Q9snU+vhqUPO+J8YzqZkCRdawcgm3SNDe9/w7FYS0xa97mPgRaIywQ49/GMBY9+gMTLIWoem0Y4Y8YXqjk+3ADtlqIKDZGb9p3MBKaILxv59GvDXUty0k0WV1kksVTXhEktpn41tqWJxyZ+N9L8tYECSV9Go4RU9JYAHNSAqzfNQoB5ztZnnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D44KAsxGmNCYHEkLkXKA5857FAWb36qMlCzEsBLHts=;
 b=Ww+4wqSw1xmAjmEyFsuUpl5mwdWdogRhpbJF0jjKvTlHaZWIZaG+cvqELSj3V4iYzII9bvYiHcuIt1H9y5bdDjcN8YVBAup7L3Gh/fKra5142CVq1aMGWfWQNEHn5n5TsKKND06m/1bM+zn5Q17ggjDBYV/BbxBlhDY4rlRRxsw1+OEeOCCNIOgCFlXUEoOdjXWZ+7/YK2ct7hz12bR8jMBF7zfx5+cuyh+qfzNXRew38UlqZUxQPwDsPlvQ32vQGsjZ1DfV06VBu5DfLwSS9SbSp+T1JDEhoFUjbZrdVj73DJA5FcGehqKc559mXC68+tLaKypLmDx3husdUjFTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D44KAsxGmNCYHEkLkXKA5857FAWb36qMlCzEsBLHts=;
 b=TpWHoSekgVrFaxUwZTiq89dpL4eUAQGx0wSxm3fqwON4lsvZ2UgcBX0Z2+ZEuReGSAx811JT6I3KToZX+UtWgC76UL5wB/83KSR9N8p4B+heD6EU7VD2pa2mKQQzlAt3XxQSAjXUylK4Zy9KdRgGj1pJ0QHKzPajsTB4tR4AjHzQzWqYtHXup6ztY5dZZY6U2mJ0kAaoptWi/OvzQ57HvcsFNn6VzWIb/8n1kh5rU72j9DAXWfesi5lK6t2Lh60USf8UJqKWT+sOLCYjdXO6OejqTAtwtR8C1rKP6DKJz1AqYjjawb4kYiCFaFjfu6XGCXRqxVQJOBfnxlDojEDJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:45 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:30 +0900
Subject: [PATCH 2/7] dt-bindings: display: tegra: Add Tegra264 compatible
 for VIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-2-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
In-Reply-To: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 728aba76-5bfb-4334-7a4f-08dec84c8d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: wLH+CJ/0nvYTXDGaxKHXB2DeiTg/KfXC1/6kmOeDXul4CugzmjRAvNrK2p/MHb/pQNHk2dVGspg8tZzLKSElRagtoBAm5pWTY0LNugw3nam7GsbEMju/jJOwnpIg8dqi+LNcU+buJZCTpDwA1/jrav5oDm6SKy+xK76oYTc8a8m0zR6rZmouwaR3+wstvzxe2AUxR9aOFvWrzqFfteOjp/mLDsZ2nag413ubILRxE1Ifg+dx8Y1+XWy4kdyqbvlf3wb8vGh0PCCNYgJQwzdpkYNIDh7NIoPIwEnO8QqqyKJ/E5zl1p0e02dmyRSUsUN1BH1Ti0k24ZcboyLXgQlYSxvmgA76GoTDWCpDrGS4UcOvqFKAzdGMCSoXF/S+R9cbwfLbdGyHAP++jgF4shmU0n5mp/M9CItl5U3dThzN1WiqnHevpSH6T5ZzVyh0jZpoHBomwV/TRVkdCkk5UI5Splo0dMEnClZyWv7bPTL9i1kQxpnFNVGsrnx6JyP3yPBiSfL3H/SGGoLiA2MC+Ek93dF6R/cpgxfOmo7HDOo2M75kMHSf0H+D0tikw7wKqaTU4LKTFcUbXHW6Hajs3j6HdpglluSyRUST7a3Jz81RHpLRYPyKFYEBi+x3JpvpHZVF/CXgCDLHWNhHSwHLytvSeIFM23hDpHgJ2RZ0SA15LFKHZqynqxl+bcaKdUt2SeX3KI1f2Q5KFUD7n8hkMrQlCrBbqKr9Rm1qvMM/eo+vOFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBBV0hzbUtnSjQyV04vZHJDVHFmSmxOd25KbW1MRDM4VXo0NDdJeU41c0xZ?=
 =?utf-8?B?TWUrNlljcFZhV2t4QzQ5TXQ1VW5TbVoxV2JtM2NTTlVkMWpDd2ZiaWNnYkhT?=
 =?utf-8?B?eTRuMjZwWmF0cmpscE5MV01DcUtudW5jQTREZm4rZ1h6RkJHYmN2dUVLYXZN?=
 =?utf-8?B?NEptK3dCNnRKOU5mR3c2UlpEeDBObk52WTMzWTBRV0h2d2ZWbjl5VUJwbFRQ?=
 =?utf-8?B?N2g3MHlobHMwbFVFSlR4MVFHaS9HRUxsZUdrcnRldFhyQ21CTitsbXJPS3Vq?=
 =?utf-8?B?MzZSZzRPVFFkdzNJYTFBQWE0MGtlNk5CV2hlVGx2U0xhcEt1WFJpa3VYcWZD?=
 =?utf-8?B?UTVjTEp2ejRUVVl5VEpiS3JpeSs0Wit2a0pqOWtuVU9CTklzQ1JaZDMxQUZ1?=
 =?utf-8?B?SmJ0VDdZcy9WekJOOU5oLzk5czdsOGpYQ1ZwUW5Za1ovVkZsYkRUeDlTay9K?=
 =?utf-8?B?aHh3SGd5TGVsdm5SVUNzczE2NDFiemU1QUNpMHY4Znc2MlhUQzRreEZ5b3ds?=
 =?utf-8?B?ZXpUQkZxckkwdjIyRVQ4ZFZyNGRPSmQyalRSTXVvUC9kYVMzL0tMcjFHenBl?=
 =?utf-8?B?RDR3dmRKcUpZM05STDZQTk5jZjZpSFN4TzB4cmdYbXhrY2I0VlRTSFRWR3Fj?=
 =?utf-8?B?dmNSTzZKQVo2c2xXMDR3bGY1Ry9PRXFXSGJBazFQZHpTcC9icENMV1FiMGhT?=
 =?utf-8?B?K09yTDFGVCsrbHQxQkppanlhZDFrSEJpM0gwVWRyOERoTTEyZVYvKzR5VkI0?=
 =?utf-8?B?SHpOY2VWTUVhcFBYV1dEMFQrMStMNFYzRXlhY283NzJrSm4xY0hDcFUwWlNC?=
 =?utf-8?B?dGN1eHNER3l0bDV3Wi90dWliL2tDajZ2Q2hHV0sxQVFaVlJaczloRFExNmNB?=
 =?utf-8?B?NkJmcDhhOE9pSzc4SW1rSW5ZcHNad2cyMjUyMm1lR2ppS2RXUHhkV0EzZXpB?=
 =?utf-8?B?R04vY21DWE5mWlhFRWNXb3kzUFNFVUtCaHAva3BVVGtJNThxd0RheVlKZlpT?=
 =?utf-8?B?dUF0a2Vib3JzbzFlNzFodDloRTlNT3NaTWtTQXd6MTEwZEFmUXRWeVlOMXBx?=
 =?utf-8?B?eHdKQkQ4QTN6c1dKSGJPck80d3BjRWdtOGNNZmtYK1JVSWVJejRuRGxXcnJv?=
 =?utf-8?B?RWc2c2QrdUg1QjY0Um5Ta09iVXFzM0d2MGJuWDVadit3dHkwdjRoY1FGK05O?=
 =?utf-8?B?eHViQnY1YWs0ZUtTLytLQU42bUFlWHRPUGJTcmpUZ3ZDYThuc1ZrNUtQVEZP?=
 =?utf-8?B?TnExbndSN2F2ZGpSOGtERTVSUGVoTHRiMHBxZGVpcGpjd1k2UHA1Tnh2dkhS?=
 =?utf-8?B?SS9uZmIrdEl3MjhTZUhraGF2a2VOS1Y0RFFFaWFqZkVoSW5NRWl3Q013Z29l?=
 =?utf-8?B?NlovL1QxOVNONzZBTC84S2c3VmlCMmdwT3k2aWt5OEZRQm9EOEcvOCtvN01L?=
 =?utf-8?B?aWc5cGFxNmY5ZlFqNzhRSVFFYXdYQ05ZemM4Y3NOaUEvTzI1M2puZGJLRUZp?=
 =?utf-8?B?REgwY3RCM3ZhekJGMTlucHA2cjhPMExsWHZxRlVoYVJ5MVNwL3o3UWJET0xu?=
 =?utf-8?B?NW1JNHYwRHh0K0QyU0NRVDZZMHRzVmthckRWZjlNcHladzVxQ2ZxYzNlWDFt?=
 =?utf-8?B?eUE3d2N5RFZNcnVjMldCZmh4MjNoUG1Sd2FJYzFDQWc3NjIyYjlFVjlvMXQz?=
 =?utf-8?B?LzRpQXVxbmRPWTI5R1g3U252WnN0S0xhR290VWV5QkRuVlAyMlhiRUgvUmc5?=
 =?utf-8?B?Wm1mRjJNUVlyL3RtMXdnQVFuUDI4REkvY212N1FkMEpJWXNRSExXdW9YcENR?=
 =?utf-8?B?aUpVTHRSVnBCOXNWUkI0NWpjd0NyZGdZVStQaDRNdk15QmtZSFZxbUFEUmVt?=
 =?utf-8?B?WS9KM0hlc3doRHQ0WjI3bnlTeGRUdStnZnlua3VqSkFRWXZnT2pDdDdxVHJC?=
 =?utf-8?B?elFncjM4QjNzUjlRSXZ1NlJjY1FpTWhYWTFUdUlkcHRUMkIrQ1MwUjBIbDRS?=
 =?utf-8?B?RWx4YTlEOU1BMHhBVStZOE9NSk9Qek5STkZBcGRKR1NoUnlOSWRQUjJFWUF2?=
 =?utf-8?B?Z3lvUWluNDFJdWdOUnpVUGgxTll4bHZXS3AyTGhyQUlNa2NEU3ViYlBJVjhH?=
 =?utf-8?B?cEJhMXN1UXBmU21kYVMwZmhhS1Z5Mk5xMjBxOUJsa2ZyeFpQSFVKL1RrK1BS?=
 =?utf-8?B?NGd0ckVpTjYycXRhUmsrem9OREtaL1RCTTQybEl5NjcxaGlVbUtQZXNzbjZL?=
 =?utf-8?B?ZFJwUGF6cGxjM1RveHNCb0JwbjBBYStRaDhwN1dqaXhpUFJlOHFCUzhTVmsv?=
 =?utf-8?B?L3d2OTRBS0x6RHhoWG5tSm9xY01LaEpFZTJHM0V3TmpQOVZ2Q1VSc2NWQ0Vi?=
 =?utf-8?Q?bCPlOhsvA4maoitHuNeQKmJdi5iYFFYr5bFRcP9a2hlX8?=
X-MS-Exchange-AntiSpam-MessageData-1: FS25k2M/sjfqVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728aba76-5bfb-4334-7a4f-08dec84c8d73
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:45.0864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hPaceDfVMtSCt+0uB/OlR44VDlzptDJDhQkjNcrrLdCjYSeE89C5SWpyR3BWWv95fiBhQ9vVcegjy3KrUFJoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

Add nvidia,tegra264-vic compatible string for the VIC on Tegra264. VIC
on Tegra264 has a new RISC-V based microcontroller and improved image
processing capabilities.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
index 7200095ef19e..bdf981781bd5 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
@@ -22,6 +22,7 @@ properties:
           - nvidia,tegra186-vic
           - nvidia,tegra194-vic
           - nvidia,tegra234-vic
+          - nvidia,tegra264-vic
 
       - items:
           - const: nvidia,tegra132-vic

-- 
2.53.0

