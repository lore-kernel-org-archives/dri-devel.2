Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2457CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7B510E4C5;
	Mon, 22 Jun 2026 06:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzURfmrJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1D810E4C5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROsOqKZ0OZyRHcSSs6TFt+e1uzrkIAx4UzFeC2v7PQ3dTsyYk1xyxx8hcONHHy/t4HUS2+emMSDK87Bg5Ibk3SL9Eahgmi0T8vj6GEEmf+bqoiS89DIc16t49nxPqszBCaX482DKy751SJ5p0U9c2dO4T0xl7Frq5owwQaeTDFE5hDMcr2fd1Xn75pvk8IQpFOhfEAz+Jf/dlCnZI90eGQXe5NHc1wKIebXxvlP8l1fd45qGu7bhft1QjvxonD2YvWag6IRdJwSy2Hid3caUQodLOTEIo+HaQcYNB5NWR2X/hQpg/vmga/7s3KvQQYzRRySxWATspCVFBK0PMzIZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYOks6iDYbVkInw/b4oBGj91ayKWETHuVohklzkv6wk=;
 b=f14YokIlUE+wrZpWFZI5gt4+Ey4Nb4tKnLneXtdH/cdlOAEs3MTYxcY3avtSo0KRGgrTHB8xrmsSv+ng5XQp8HD7m8WmGH8ZIvc+3s2K4coSDYMKDYf3563xh1EXEDGjHgxTuuIA6puAxmAnc8WcMmxAgWpr9pXROW6oIAL02N9gbYHbopnH8Di6v7PJd0DTSNEhW888Lu6dHxF3mm/HqfUrRgCFhL2Xa5sO6K2BSFjCBoctLuOUXTzFRCj2hUK/UXc+NuWRx02w5zv7byS+zJmHdfhe3psVgNsAfq81dLNMrlUa0w7QfoC67oSluw7IXbR6RoG9m6LLEEA+5N3iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYOks6iDYbVkInw/b4oBGj91ayKWETHuVohklzkv6wk=;
 b=jzURfmrJyotyH5fXlBuiH5T+2zQ82rlkxWGQ8kXhxyFqnI4ZzqTRFMTL3ixse4s3iLrtxHSg8TDXI7Eztez837sYpYWi+ljTN8H1m3u1uKhYAg2lbUuW0J3a3w/aH6dlxjQRMRNMd/cFEW20IXjnvjDfAO7rRvjSJfZT+xKHBNcAZdg4bgCCEg16pvJTnAGWCqZPHvHC8H88FE8zd77MceMypnnE2ARRnJe1XO7wMND6hEoHd9UPlpQaSdjuSeA68WElJL7xhbJVDnVL/olrgi1aWLhHW+esr8RtMF6vsHMM9AlxkggO5uiw3liab2PMQmUCFa0qhY7xeKCfqIzSXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:57:57 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:57:57 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:38 +0900
Subject: [PATCH v2 1/7] dt-bindings: display: tegra: Changes to support
 Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-1-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
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
X-ClientProxiedBy: OSTP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4aad60-a79b-4441-c759-08ded02b9767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 7OmGkk+lusPw0VkPQdUv2q9RvtKgm0ZaH+KrKll/mR+Y5iY4ANZ2hC2zP45pHKaTCNckC3Xh4tbd/i+PhpG0eruxw9lyK1MeC+Inrpa8ePmwOQ+z8jBFxNnTaoTfG6o+dWBFyAshUMxyEbdelYZQT7MvPhiYDrpj6fRrfs2PyZ3GYvQatG31vBV7KcDWD0UUTzvM8LqvNoSEJI7k+Qjf9+i7JSeHZMsZCDpWHqm6dJgXXaTLKZrn9TNUFloXmPH5SwsA12ulL3DtLZL5QdUbAlv532b065eAivTrdL3G0rwS/oh78uSTrhh3XGpe444VkvB74grhVzIiejGWrcpsSG3ohrUAGzz2bMamc3oI8xIHLO+yCBhk/qtqTlQskGs4ZDmvtzXz/H+PCZV2tlAZFrdShk9VvcgVqGs3Z+qvaPntKX/WQJR65MJvIotJN2WRxKo5WnlJHp/p/ax8LEfL5JkydjQrwD6JoDLv535Fc81v3CFMRqNJAN6sYo+fYzdALXC2je0MZMC+I7RUxXbbeBLyX7hiYhdBpBy605IrN610tFzTJf/KneRtPCFN1wuKk+4rv5kDym7XwzAw+7BHIInf0okWrKqX9tnWwgYb/gC2/3ftzAakVlGWrNet/uJMCfSSa050+oDvg4B0hdfbhhjpNzwPLdDYAVxLy6/SrkiIObRRcr29qY/EuX/zDDZKcraJWmXlQKWQ6w1EW2k1gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhGZVlMd0M2V0FPZlBkQ2VwNkQxUkFMSHZpc2MvUkE0b0Y0bnlpbGtlWDh5?=
 =?utf-8?B?MFFOb0JXMjN5ekh4N3NMNVIvT1EvT29vOFpmK3Y1ZmNjSjYyOGRtN2pjVmc0?=
 =?utf-8?B?dEV2bDJnTk9GTWZqWk1ubUxEOU54dWViZUFFVXBVUDJxdUFZSXpJdWcwcFdq?=
 =?utf-8?B?TjFOeHAwaWRQTjFiWURNZVltK0lka2gyTllkSllpOXdkNkNOWGM5ZmlSYzBH?=
 =?utf-8?B?dnNDb1BiVmg3ZlpPbmNPcTNkYjIwYjlkb2J4RnN3eE1uTkpZdzhqUUJKaEoy?=
 =?utf-8?B?QVU3ZVU2SFQybDVGUUZhcTRpbkhHdGNzcVJkMlQ1bURkTUtDT3VIVG45a2ZX?=
 =?utf-8?B?a3duQkdoZTVsVGxKS2ZkRmx5aVpVUTNZanFmbWREaGl2NUIxU2Jzbk9Jbzg0?=
 =?utf-8?B?MU53MmJRemJIdTliY1NUMFZSWHRYVmx5OXRpYkhlOE12R3JYQ0ZIQWhCYzFZ?=
 =?utf-8?B?NURRQXgwNmF3Vk01Q2VNT0p3Umlya0dxcS9xbFFjUlpQR2Jpc3J1YXZTWlJK?=
 =?utf-8?B?ZVNIQ3NTREMzR1FOcE8vWTh5YVN1Q1cvLyt2ZlJwMW1IU3VVWUZzNDBnTDBO?=
 =?utf-8?B?ejdBWHh4ODljUHpZNFV0YS9XcVZiQ2VzZmNlQTQ0b1lyRU11WHZKNW9pWGd4?=
 =?utf-8?B?Qi9BMmRaZ0tPaXZaWlZxTEczbkQ3Uk5jbjhhTk5jYUJWSy83STlpZ1NsRlNC?=
 =?utf-8?B?V21LbTBHVXlWT3JHbXlXV3QvRWxlRHdZTjBsZVMwRXhIMDNXcTBjUmhVeTN5?=
 =?utf-8?B?VjI5c2dSdU5YdndSNDlxMmlMWWZHM1QyQk1QcE5GRGoyTk04TzBJWDNxb1hV?=
 =?utf-8?B?VjNHVWJDTGVtU2xkbDZDeXdnbUtJMUE0bk5Md3U0TFNRQzdsa0QxTkVIOXMx?=
 =?utf-8?B?bW43UE9ZOU41Umx2bjgzK3FMYnZ0VGRPa2RsY2YwdCtuNWdZYnVzNGdWU1Vt?=
 =?utf-8?B?b1FGY2Zrb2FUSTJkMVg2NGR5WFZYWVpoUGhxK2c4N2Z2bjFRYnA1QTNVWHhT?=
 =?utf-8?B?QmVBWlgwT1FIQVpiQ2JHbXBhRUttZWVxYmxhaXhqc0dRNkY5VEFKU3A2czdV?=
 =?utf-8?B?U3JJa21CdVVGTWpzM0pKMTErZ2pNd2RFQXoycW9POGJqNVpNS1pQeDNNSHBi?=
 =?utf-8?B?T3lzSkpnVGpZaHhHd3lucVZrZm1PY2E5Wi82WkFqcjdWMzFYTG1ZUUxKRGtU?=
 =?utf-8?B?ek90MFlTYkpQWjRTYitmaUJaZ3YxOWUvSGxCUDhNRHp2aFZhd0c4YW1sc0kv?=
 =?utf-8?B?OVBYMC83bDM5cFlwUTdWa1BpRWxPdDZKbGhDOHdEOVpkWDlqVWhiMHZ2Q2xm?=
 =?utf-8?B?WTdpOW9KTzVOZE9WZzVQT0c1K09CclFTcjZmZDRiMm14NDM0K2tyZitLbjF1?=
 =?utf-8?B?cWlqamZpUzNKakRad3MrYm9CU0NJN21mTGpMVUxIMHQyemludVZJdXJ1Z3Nk?=
 =?utf-8?B?eVJCVTJOcjB1R3oyRmxLWGZZdFl4VytJaWlwcEdQV09FU0NYeTJkNVpvc2Yz?=
 =?utf-8?B?ckM5UVFGQ1pvWm5hdDFTZjhNOVF6UHBFZlpYT3NZZFEwWENsaHJxVjRJejBx?=
 =?utf-8?B?VDhUSlBLempWUHNLVFlvSVNjeTlLS3lGRjA1WlQ1OUVndWZzdXJHVmFpNEwx?=
 =?utf-8?B?MmlicGlzcloyMlFLeXBIdTdqQ0ljZmEzcE50OU90UWRDQkozQTd6K0pmWVRQ?=
 =?utf-8?B?Q0tabThxL1NvUHI1NW5QcmI2anZjNlRLR1NENzFmSVFDa0NBOTdDV0ZYMFBz?=
 =?utf-8?B?QXQ5bXZKUlZlTDg3cnQxME5wOVJDcDNmc3V4Njl0TEJQQUhWYzVJRjlCU0Nn?=
 =?utf-8?B?bzVkb3JJSlV5VW9MWmJnQXVuSzBHZklHSk5kbFd3UUFLRGw2OUlXL2lQQkhr?=
 =?utf-8?B?dStwRDh6eXRiejZ4b0dFRGZ4cU9JV21RTnRpQVF2UEoxanZabUdXU2tTQnpa?=
 =?utf-8?B?bHVRbC9qUFNVQVBMYnlLN3NYT3JzTlFYQWFVeUxCZ1pYaEFVbWtNZjVQQ01C?=
 =?utf-8?B?VHRlN2dvOVoySUhjQXRjUGRtWUh1QndmazhwV0dvVWxoVTRONUdwVWR4cEtn?=
 =?utf-8?B?Mzh6a09UKzdCWTN6bmsrN0F2ckFRd1JVWjErUnRtUllxU2Y1TU9wY2VEdzNr?=
 =?utf-8?B?TDljcWgySTVqNWtuT0ZpWTE2cCtuc0UzMHg3TWdwcnlpNHozbTR3L3h0Y0tq?=
 =?utf-8?B?Wk5senlpUDUreXpFTlFvbTdRZ0ZsTWVScUtjeDcwY0hDZ1JLSUl6SjJhUmNo?=
 =?utf-8?B?ays1blUvM1pvVmRwTmlFbGsyNS9QL1FHOUlVQ2pCNUw2UjFNV0pRY3lodWNS?=
 =?utf-8?B?cFVGZXlxQ0swVFdlQ2M3SjhTSUt2SGZjdGVxMmcvakFPSU40b094ODVIZk5o?=
 =?utf-8?Q?aQJsYhU7fjPmgK2R4RuV187c4yvqs79AY0MDsZfOrHI+x?=
X-MS-Exchange-AntiSpam-MessageData-1: gs/yb15oxt2gvA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4aad60-a79b-4441-c759-08ded02b9767
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:57:57.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZdGX9aZ/LhxQ0yNKCvX8Rr8HmpmmK7L9VlR7RQQf1b7VgoZvqpBZK1WlRkQQGXHTX+F/hSamZ8710XYzOod1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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
 .../display/tegra/nvidia,tegra20-host1x.yaml         | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 3563378a01af..8312b7699cbe 100644
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
@@ -239,6 +242,21 @@ allOf:
 
       required:
         - reg-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra264-host1x
+    then:
+      properties:
+        ranges:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        ranges:
+          maxItems: 1
 
 examples:
   - |

-- 
2.53.0

