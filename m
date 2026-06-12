Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA5CD98D5
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DCE10F26E;
	Fri, 12 Jun 2026 06:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJyELOrz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD9310F26E
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr8H0Av7jopUeZm2eZisltNaXxVqSI/SKsFR9jAmW8yxn9EcHG5SRoEBtFI8c+ADEVU15jbp2KY/UWDI0VNjWcmTdW1jxDCPYBZg3KP2Ya7qxc/ornq16DZDCVCYujdo/zPtYCFauKwSiZB/q/9tAvF4VGem9P+/n9qCtCh2/vQ83767ILHV7ALwbr/tym4q7a6PLQ4+10Z6Xua2pDx8ef8SaxcprLkvDUt+015/u40b+k57AZ18AX4vgxvGnLEY1iGKUF2e9o3N7a7ohF419pcK3u7CnLxeDtx8FFWHYzokiwYQ4w00655sCWqgrZvjANSyiPnGfC1VhO9s5v+BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e+S18JIWYxJ8HxZBgKELC7yfT2RJ/y41IzJ4B+YDZk=;
 b=DUs6pbp4gYjOv3j65d0EJzymeW5hodohoUMT5MhzmWcgDxunKotHPKqxTHdDpujQAV0XZT7gRjhrogsWPJOdnszYK6b0ikZEowCTM/w+MvlV5VP777L+iizAsv3zbj+BW5TRtbE46BRUnKZ85+on/XPpvN6DHLU9ndNMjQt6h8U6N/I9d6OyBTW29vROVEHyAQJTWH6q57M3XpbNiPSmhnd4WNieJWrZAI6KvPc9o9gl4CWB26l0el4IToV7gQj7DGdil216ThHYaV8ddeSesqFmhe6elJ2DAof9NblCWqjz3WY1lQB5GRzObxwTV+hW8XNoSI58X4yx67nwKqhCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e+S18JIWYxJ8HxZBgKELC7yfT2RJ/y41IzJ4B+YDZk=;
 b=GJyELOrzQ0aPij/OT3PL02JZmiiKgakTmikNUYcqMVHHjk/nWU/xkF/qTcOV+ULhe1u0nx4ZfYV/98X1ao3XPnbbQwxPBupRVBDuySRGGTD+faVFPYyrnfIIDRa3oQ36vwRQGV7naKLZAPmH3Yxztt9NWNixjViVf5suxNCtIn50ogCzzmTdnwG17dfWLgpKHoTTMAIhL9BBNp/LB5iydbTUHCy8S4YaH+MABUSK/fapDCrA3YHx+d9oy7Ly7GTEnxtZBO6z4hylHYnQYx5k3Np1W5tqV+zfL/dwFdHaCSCFsBIVaicNApqK5wftAoFhFPRcLGH5QHxYnTqg8I/u/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:41 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:41 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:29 +0900
Subject: [PATCH 1/7] dt-bindings: display: tegra: Changes to support Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-1-8d934987de67@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa69514-4233-43b7-bd89-08dec84c8b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: gtbPRIoUz3qsA5H0ZFGllmLNp5adgv3JkYtkWhcIxBZfKqhJ3KFPvb/y0GWkmGLfxkVaxZKNp4VTXIcHZbUmBIGgkwSUcwNHl0Oj51RGL2a+M8R7df6maWmBUeaLQU5rzLAEJjwtoP4+GchQIdUxnXOsVUqfb7l09FIoqYS86IlpQFUdgSJLcFZPaQsDk580PC8JBKPPBjQyB+GHBhcFUUtlOW7EFR334K5Qyia06czdi8QFBAa8HKDvY15PZpMvw5vgHBeqwZmIagC7k9urOrWfLhzG5Xbhgqcwsh92QYiyqx8k0IFUtQieuUMsRvu5YpAyTgPTXBdoM//U9qYe7BCR1ONpe9AiwzI/eVHC6/gCZydRliq8sYTn8zcgjGf+0aKGTxWT+q24pLdQPLBDX0rVJgQzP+T7bwuD8Nirjq3NLF1Y9aSyqaIU99RsfMXHW1rcsuI7OCHO+kntt+1CSCGa/28zseaFiElxSXwxejSQH+yj4DHyJKdvY7ycRrYH+QBN/zN6gJuixEcqfWSOCDKbG0CNAWR4uHSO4s4JvRmH/LrYWaBt9RjxxNRJXt76YPZSkUN+v0XgTtyfk1aqN3/VrlxnitCF8MHxNkuuRvaAUs0AbIay7IqrfJ921+MAZ2+50syL/CrNFgKTsSndnkFzou7+L6tgV1uFS+R0z3WX//LuQS/2mLIqgyyBpfjb2zQ5xAuDvMu3SU9rAKFi6tgpChzAaEqlxjInj3+SrJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkI5L0VkeEpjcCtsWnVvY0pYckZESDFCbngzbFJNKzc0enhSZUZJTkNBRC9m?=
 =?utf-8?B?NG5tRnlpNHM3MGQ5M3M5eXIzN0VST01XenM1TWJYWHdBMVJncUJ6YUczWmZq?=
 =?utf-8?B?WGhSeGFXWElDcC9qdzU0a0Z6b1dzTnBhZEhNeGJ1aGZxWDNmdHphV0x2S2RH?=
 =?utf-8?B?S3FITUt1MmNmcFU0dTIwK2hXeDNTSVMveVVmNmtwZXpPcE1iVDV2RWlpVFlI?=
 =?utf-8?B?d0VpNG5UVWp6MmQ2QkVyN2NuNG5MbDN3a014ZnNKMFdoTTA5SmYxYzZFc1c5?=
 =?utf-8?B?anV1N1Qvazd3TDBHcEVqMys2dHJTWnRacTR5WjQ5b3ZUYkNRZU91aFg5T2pq?=
 =?utf-8?B?SkRtQmpWZi93aHFYS1BZZ0VCTFcxeGVtY1RBb0lZcVoyU0Irc3ZON3NLWEE2?=
 =?utf-8?B?Q3dQWFJsWEwrYzEvK3NVcmJnbzRWT0t2Y2hGSStzTkRld1ZNV3hQQzI4UHdE?=
 =?utf-8?B?dkU1VXhmaXE2VGZuR1hMeXVZSG80cFlJckU5bzVxUFlDdXIybmNua0F5NDg3?=
 =?utf-8?B?cmwwQ3d0Z2ZGOEs4WDFuQ2Q4Y0ZvQWpEK2w2N2FHQW45c0RkYU11T1lMVktx?=
 =?utf-8?B?eFRUVi8rTlB4ZVFKTlowOHV2c3pwcnFCdVFvZWh5SEU1VjRCQXhnaXJ6MmVH?=
 =?utf-8?B?ZWU3ekd1L0gwSm9qTG1wM1RXZGhrclNMeHF0dmQ1clpLUFpyczBDb0J3cEQv?=
 =?utf-8?B?Z1RYUi9acmxrTExMV1gxWURvR2hlK0dMKytmREtMd1JaYUZKTFUyYStYSUpX?=
 =?utf-8?B?OGFyQlpJV1drbDk0bTZTK0ZHTmhJb3NHck13dDAzUkkwR3dGVzd4UExIaDVK?=
 =?utf-8?B?clZYMTZNRTk5eXRDWDdDSmtmaVVldTRGZ0IyTHlmQ1RoV3hoMG1KUWQ0a20x?=
 =?utf-8?B?SjFMaTlPWTNrdXJIckMwa1dWT0FmRUNTVXJ0WVNwVGhaWTdGMTlsRHJveVJK?=
 =?utf-8?B?ZFZoN2FIclJkdjVjd3VVWEpWVjJMVmFmZ0NjZFpEWlBwWU1IcHFsdVFFMUhM?=
 =?utf-8?B?d2VSQ1QvSDFjMnZiK2NqbVd0RlQwTitmeTdVeEhEalk5YkpnU3BvblNFZ09S?=
 =?utf-8?B?d0E5T3B2Ty9lWEw1VEpyTG9xeHhCcE9jQkxoaDJmNFhvbDdudytOV2FqT0R1?=
 =?utf-8?B?VXloa01JN1Q3SVgvTHBtNmhsaGROb21ObFd5LzU5SHRTa0JzdkxJL2ZIM1Fm?=
 =?utf-8?B?ampHeVRxQzlhODBWRmFBZm02eEp0bTF6bUVhWWxxVEZDREQrTXhmdWVLU0cr?=
 =?utf-8?B?d2ppaytMNFhiK3V0R1dWVlExVjA4U1hzQlZYNjFHTzJoOHBzQ0tNZXlZQ0Nr?=
 =?utf-8?B?dzdJeDdlTko2ekgvOUFTSHRlT2VZRUh2QTJKNUJMNVdNcCtvaW41Y29SbWRP?=
 =?utf-8?B?a0VNRXE1UTlYM0svTjVaOEdmRUp0ZG9KWE1HQ2o0bHBvK2FVcGhrOEFUcFdS?=
 =?utf-8?B?R2huSmNwTnhvcDV4K0wzQzRmVko3OEFLRFhES1h2clFWMUF5YmxqWWZXdFIz?=
 =?utf-8?B?M0NiWnJXRnEzWEcrSzVwWWpYdlpTZ0tubDhsbHZZNEFrdGFEQlcrMVZjeVpL?=
 =?utf-8?B?MmxjR1RKTmZNSEkvd24rVGVPWkZOanRNMjBxbXFTeFFXSk43TUZPVVBtSktJ?=
 =?utf-8?B?SVNvUExRLzJObzR6OHhkdnptaEdZYWtFbTB1YmNReTRXR2F2UHc4c3BlckQ1?=
 =?utf-8?B?ZEtTdWsxcFYzZGhqTDQrOGFHckI2SmIrQjFKNnBRYTloeUxTRHorVFYyRitz?=
 =?utf-8?B?N2dKVGl1MmhPdFZwMDJDQ1dhTEhITFRPUUtweDArUUxNd2RrVzFFRW1NUXVZ?=
 =?utf-8?B?OW5BbTIrSFdmamlXQ0oxRTloVkdzdXBSVVFpOTNoNjZadC94dGo2OTdOazAx?=
 =?utf-8?B?WEVFYk1GZGhYN2Yza2pjZmdvd0Q4SVp6M3N4bytBWVRUNUpvWEQ0dGtJMzlS?=
 =?utf-8?B?TFdNQWdDUDhZMEdoRGJBTzU0ODNNMzc2bkxsUm5FakVqZVViTXlGRlRYTlFu?=
 =?utf-8?B?V05xZTlLbVVGZTQ3c1hwZnh0TkRsVkZSMDhwVitndi9RaG0wRGhidTZ0aFBn?=
 =?utf-8?B?OFZzUzFIZDRWU0loVmNQbnlSNjFmN0xXRS9GVzBKUUd2eG83YlVHeWlQYW5K?=
 =?utf-8?B?OVFydkxLMU5jK2M4YnJtZys4YjlUQXhtYzZGb0Z3UnVJdVh4VkpUZnVDN2Qr?=
 =?utf-8?B?SG9RajRLY3E3SzJIWmtuZ1VaYnlFWjJwOWpJdXVGYmgxWkoyWWJMSGlOZy93?=
 =?utf-8?B?ZzlRczEzazZMQ3R3QXJFNGk5NHVBWmJRb3VSa2tNb0pQeTIwa2ZjRGFiTEhC?=
 =?utf-8?B?TEhld0dsaWdPZjNpUjR2ek1rUW8zS0JwZzJOK0N2N29kYlNxaHJxT3Z5clJT?=
 =?utf-8?Q?rIHNtFJNLcxv7V9WRmBopeHHlCz+J6xJBuQa+oyxG/1DH?=
X-MS-Exchange-AntiSpam-MessageData-1: ilFev2+o+DeImw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa69514-4233-43b7-bd89-08dec84c8b64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:41.5923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24MWcDuQFgloaAb9mZznqDOAwvWrXniIOfsErgQ7uAo+oAW3jzrXCXGh1Vzq7cY9xlVjcja2ZyntMCm+ZlUn+Q==
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

Add nvidia,tegra264-host1x compatible string. The Tegra264 host1x is
similar to Tegra234, but with a different set of engines and layout.

The engine register range is no longer continuous, so two range entries
are also needed.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 3563378a01af..5b0e3158aa5b 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -25,6 +25,7 @@ properties:
           - nvidia,tegra186-host1x
           - nvidia,tegra194-host1x
           - nvidia,tegra234-host1x
+          - nvidia,tegra264-host1x
 
       - items:
           - const: nvidia,tegra132-host1x
@@ -57,7 +58,8 @@ properties:
     enum: [1, 2]
 
   ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     description: Must contain one entry, for the module clock. See
@@ -192,6 +194,7 @@ allOf:
           contains:
             enum:
               - nvidia,tegra234-host1x
+              - nvidia,tegra264-host1x
     then:
       properties:
         reg-names:

-- 
2.53.0

