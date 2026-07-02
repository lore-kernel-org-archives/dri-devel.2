Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED94FC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA0C10E41D;
	Thu,  2 Jul 2026 04:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qMP0l91s";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6D610E41C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ9Q6A25ZEo35mmhOPsiWsHHusr+hzCDD1g+YD336njp6l/HJFoA6xaTDtnbg4m7Zimz6Dc/qzWbqx0aRCgnWQXxr/Xilvdw32RSAipWTqW39F3zuA2htbcZ0PCU2/B4nAb0M3u0RfFlurGQhejP+RmtmFMz5Hm7NqVgiiMD0eaITg2j53YoeRn6SY7ly/mYsfoDZe+YHhoJ7ibDhAY4jkqM0aGBpMkv/HJ5wel7/Qh+TNlIpGq6V4zaYi4HJJhkTwHHCXhm3JVsOhKxPiyBOKLIfOuvcg7K3fzleNl7LaXzH7WV1P8sAf0PFlE2QiVv6ICwLpWoUwlLlg0qf1qZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTjRO7cKR1eCM5nt7MRxa1VM8aqdgO2VbIqif9jXqSE=;
 b=PK+yLB94c6Gv6CMkBPOztl0DeFK8JBe3dDDPNtpbMGd1cjkG7ORHeagNvgpksgGa7fnGk5yn6d2lZZxfQ8UeGCU4UrTFRMo6pCBq9A9hY3YbHSwgmCUzLY484EEo/Ya6LZ6aoJruaLhdDHzHWM3LGx6b4XR2YdngSYE+bTfwUGpIkEZ8BXmBfHUajVb9AZj11xYJH80KBFvMr1S/iAuyQQBq2g8nIlEJk2SORi7CyPRGscT6/10EcuzMdNXERaQs5PB2UfK7swlWV7OkbiSVfKhayeV8bBsFy2StzBb+ex224lcy6cOFwyu7ppP8t/8cz4NoEhaG9JdjWnDxQpQPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTjRO7cKR1eCM5nt7MRxa1VM8aqdgO2VbIqif9jXqSE=;
 b=qMP0l91sVcOfO21ZB4kKXa97uR8aeErDnXnCNtUXJXuYhgnJjfTM95aUdUkdqtwivrL8tomR6BSmfbRqAblcGkNFsmcXpos1k0GFFRekG/Ru2pQBTuh3Vi/ZmJ19cDiNWbPrHyW82bo7U48tPL2NlwwQejr9A07yTLXXOlvtIuk4Ki7JaYb4nALeaZlLOfkBgfV85RGPwJoFvwG6j20WRC6NSz3j3t1hN+gwbLiFr1bUrL/GI8M+ZBfPbnhBmRKYZgvfscO7GeVLdMV/iqzXnHtjwRfO/KmAqEOKWDiGuL77yoSBMMQ/tCQUld6/p7wUviKZAsPgcLxVYYPvj6gO5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 04:10:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:10:55 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 02 Jul 2026 13:10:26 +0900
Subject: [PATCH v2 1/4] dt-bindings: display: tegra: Make non-vm registers
 optional
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-host1x-nohv-v2-1-e6d88bac0af6@nvidia.com>
References: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
In-Reply-To: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: c03c3829-d1a1-47b6-0099-08ded7efe9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W6krOL038mle7Ghg4hoKpVm6rLvOuAOtUmmr7evjtwryRXP8y3W9R5C3YyvQZMAukVBOqO7X9k427vjYcp4rEvhdjgtJ62aXe2yKyesvNT8qghRotUsSUCEZWC/FeuO+ktLyKuRbI4kVaQsxMFuQUsxHKXAG5oVhk5XIcYhaj8c/4NMDn+QLzYEbwQDTdeaa2tsPUKvjYTZjhb3TjQN8gQJKpMdYNcvSUI+aEhLs+v9PmcliM3O7+RdnuKC+Oz0CR+olOL5Xb+U3LZf6u3WLGsLl4fgvj+XjfZSmxp+dWf9UsUs6CWxGdeDyoOTMXIAAwAN4sl0JgU61pXfV9WlfMu93oP+IEaoC0gPresrYiiMdu9Unm9iMVFSf0TuLVGhnIenqlHCbwCjghpLleDNQzq5NyjoPlBgIUGy5oYU65Rgmnt1C+k5kPXz7C0PUWOwgtyxCn+BSuWgOuZoXYOoh3ygJ6XayJfPAXvHc0vlTw/dvvXHI+QdYWrFzJRX4ZMe7xMlY/1z7t58QStb6pCEiYl7WhocJ/bdJKLSaAiwXKNtlm+1B43d5LXJ2ZsDB3Z+sYKVCXeaFGNKIqFmfEEy+adkgVxPcy81GmyJvlhbLZp2Iw+By7JfBTtSkK1vESouM4ssttcYZMihLnGeAvnfLMCyT5Gco9/m1pAjhVGzQfXtBiNJ/iYptg2KmYy2FVQPjyF1IDF98S5wwTIEtFI4hdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRIREsrakdvOVBLWW9WUi83MVZkZmdrUDliK0tmanhTcUE0SVZtZlVZYzRU?=
 =?utf-8?B?T1k0bG9aVm80OWRsUVltaEg3YTRGOE5RTnZacmxRYUFMM1hwME0xVDZ2V1Ez?=
 =?utf-8?B?Qm9QMVdHbzlJWmJBeTUyYmxuUmZxcGxoOXpUdWpYejBMU1JZWVNyN2NIdjNj?=
 =?utf-8?B?Z3lXZ3VxVnYyRm50NE9qdVJvUFE3bzlNS1pLTndUeW9sVU9BdUsraGswcXZr?=
 =?utf-8?B?ZWlaQjZTeFlMVWNDMHU2UFpzMWlDOEU0NGcybzVmZUs3N2o2eGVOR3dRUG5E?=
 =?utf-8?B?SEN3MzNMK3o4alhwTVA4NTFwSThTUHloRmNpUCtOaG9jUTFMMmJ6eTFxNUo1?=
 =?utf-8?B?M05INGpGNHpJOHpJcU1WdHpMUXFONjJlTTFhNkpOZFBzREpDWFlXcTdlODI5?=
 =?utf-8?B?a1pPdVl0Q3cyNUtnTHBxSzY4RE5xVGIranQzY29qNk53MUZKY0xsak5scHlh?=
 =?utf-8?B?dC92aE5xbW5JZUIxTWJPQTJZL1lXVHRXTnFLcXhDbGFJaWMrRXc3VG5vbzk1?=
 =?utf-8?B?RHNGazN6Q0YwODA4ajUwQ2twTzJXTVpiaFBDRThIdUUwUUpEQzZaaDNoVU5W?=
 =?utf-8?B?WElLRThtempzWW51S3pVdkR1S2huRldBYmkwRFA3VEJGMUxRWjM4L1VkcjBH?=
 =?utf-8?B?RHVDZDJ2MlVTYzdIc0RBZHY5V0dRODNaUTMwTEZvOWxpa0dxRmptWjZ6S1hZ?=
 =?utf-8?B?cUY3ZFZKKy9kOGRTemtPeTFXMGltYTgyUXJFVnpyaXdHNm9CTDBNWUNUL05z?=
 =?utf-8?B?RFN1WmxnbjlEMGRlZWdadkQwdDlwUSt5TDUzOVpZVllmdXRvMWYxQmk3bkdL?=
 =?utf-8?B?S1FRNi8waCtMWWR4SFZ0WEpqSDh3d1NEc3NyeEM4dXBxZytmNEU5WTFsU1l6?=
 =?utf-8?B?MFJNbjBYajY4LzQrejVnZnJVeDNMd3ovTDRsdnJaa0JXeWVPZkNpK2E2U3pl?=
 =?utf-8?B?Ti9tV29qVENGSi84cC9qb2dHRkNvdEw0ZFJGamJZQlFjVnhFTEhuclFsb3hU?=
 =?utf-8?B?ZFdvOGZKeXFnNVVRaVU0NWN3eHFWdGFqVk55cjFNN3RMS1JYYXRmNWc4ejZ2?=
 =?utf-8?B?SlpJemFIREUwUnpUanVqTm1NazI1UXlBNmMvN3VRUktJbHM0MHdTNHhxMTFm?=
 =?utf-8?B?Yk5pMkRhTU1uZ1lYMTFiYjMzWURpSmxGRjRURHRSUXB5d1YvNVZhdTJBQmJZ?=
 =?utf-8?B?K1AyM2hwZml3M3h3cHhmR0xwOFpxSDNNb01OMzdRQStvcTNNbEtSMElhVUNE?=
 =?utf-8?B?ZFowWUFZS2R2MDVNangyRDhTYnZJWjJJLy9DUVg3c0g2RUhSVVZYNmo1UlBB?=
 =?utf-8?B?RmhTYysrRXVJbys4T0d6MmJ5VS9jeXdsM045dHFQaWZ2OVdhTDY4b3J4Qy9t?=
 =?utf-8?B?c0xKUVlsWkpJRlVrSUt2VGlsbkR2YTBobTFKRml4VHdxYmRRWW1OREIzUFpl?=
 =?utf-8?B?KzRjVDJnOXVXdWVZcmhrMXVJQVREanhJelpQdFZjdVNyblJGQXo0cUVuOTEr?=
 =?utf-8?B?cEtNVUh0V1RhZUhrUm9LSjlKbDZrZ2xRNWJ0dUwyTHJEUzlKbnJvaVk0eEox?=
 =?utf-8?B?Q1hFLzNGUWdMN0E5SVkxRUhHdjNYblFhcFByRFlZQjZJa3Nob3gxV2pwbHo4?=
 =?utf-8?B?dlluK0Y5aDlmc0l6di9pd3V2MjJXeEJHNkRNTFRUeml4M3NpTldwVElxWUUv?=
 =?utf-8?B?TjV2K2YyL0RkaTlBUkIwei9HV2FTbFJGK011OFFpaythVFJDTkpGSmlFWDFw?=
 =?utf-8?B?YzRBd3N5aExBbVN2cElvQ3IxSW1palI1bU5TUjdxbDVQMWxpZU1VK1F0WmZH?=
 =?utf-8?B?cWZnU2tLb2F0djlxT0ZFODdOaTIyS2ZwelkydUViTVZHdVYxNGZLakhmUGF3?=
 =?utf-8?B?MWtsQy8vOVZadFpnOStmMFpQcnNQaUFhN3RYTzFuSVBSL0tKb1RNSnovWCtY?=
 =?utf-8?B?MHprWFJxN2kxM1JsVTA4S3lwdUlUcmd6TVpZb0phOTJmejh4TnJTMDVYRzlH?=
 =?utf-8?B?c1paZlVRU2tWTHVtK1dNam9TZWdmTHZVL241Uk1YNkhzOWpPU3lNQTJ5OHBu?=
 =?utf-8?B?T29jaXB1M2JwMEgyTUpDdnhtT05ZRCszSGJMVnBzdDA5VFJMTyszZWdtck05?=
 =?utf-8?B?MWsyRExDVDkvcm02ems5Y3FIcXFPWmhjSHZhQ1ZMS0tWUFBYSnNuWkZzQzFN?=
 =?utf-8?B?RDlzNXFTSEtQWEZNMTUyeEFYRlFqb0dtWE9qOEZxOVQvOTF5RExDdlJONjBF?=
 =?utf-8?B?NmpCdDAwQXh2Y2g3Y2pQSTJoYkUzRWZqeUsrVytWcDRmbEMvNHBNQi9Xb1A0?=
 =?utf-8?B?SFVENi9jZ3VGbmtqVUp1V1FJWlpEcWRBZEF0NjRVSlRYQ1dnbS9HdFlHdng5?=
 =?utf-8?Q?i34KllI4WNIC+9j03Q7ynh0w3UFW0NoB8JVJUApvcQlqS?=
X-MS-Exchange-AntiSpam-MessageData-1: lzUMJw7nGCPtIA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03c3829-d1a1-47b6-0099-08ded7efe9ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:10:55.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxhCK8CyDfxU3iYzRedVGSPS8ASdKNJumYo5UdE2u9oDOvysuv9VFtq+marilS5hn0dl1WeNYn2b+LYF6f+xzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

The hypervisor and common register regions are not always available to
the software -- usually when a separate hypervisor keeps ownership of
them and only passes through the vm register region to a virtual
machine.

Adjust the bindings to make these regions optional to allow describing
the situation in device trees for such virtual machines et cetera.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../display/tegra/nvidia,tegra20-host1x.yaml       | 40 ++++++++++++++--------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 3563378a01af..ffd0ed857d28 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -145,14 +145,20 @@ allOf:
     then:
       properties:
         reg-names:
-          items:
-            - const: hypervisor
-            - const: vm
+          oneOf:
+            - items:
+                - const: hypervisor
+                - const: vm
+            - items:
+                - const: vm
 
         reg:
-          items:
-            - description: region used by the hypervisor
-            - description: region assigned to the virtual machine
+          oneOf:
+            - items:
+                - description: region used by the hypervisor
+                - description: region assigned to the virtual machine
+            - items:
+                - description: region assigned to the virtual machine
 
         resets:
           maxItems: 1
@@ -195,16 +201,22 @@ allOf:
     then:
       properties:
         reg-names:
-          items:
-            - const: common
-            - const: hypervisor
-            - const: vm
+          oneOf:
+            - items:
+                - const: common
+                - const: hypervisor
+                - const: vm
+            - items:
+                - const: vm
 
         reg:
-          items:
-            - description: region used by host1x server
-            - description: region used by the hypervisor
-            - description: region assigned to the virtual machine
+          oneOf:
+            - items:
+                - description: region used by host1x server
+                - description: region used by the hypervisor
+                - description: region assigned to the virtual machine
+            - items:
+                - description: region assigned to the virtual machine
 
         interrupts:
           items:

-- 
2.53.0

