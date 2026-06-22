Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E87CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC8D10E528;
	Mon, 22 Jun 2026 08:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFoY0bLM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420F310E528
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXlDAAIV1M6rR8F/h9aSTdPZ5CKLVo0cQR2ICvb5zpT7FtOI4TcnUFRl0DXb1aavHBQgNr5wuodKp6+wc1oOv0+ptH1+F1LTBm6GG0n8Lox1i7jOSC7BIkT2yee4cfX6m7Iib/yNk6gxRxirZGq0hKKDzpenCBpiwbGOGMU0eHTqumvJh8E9/2at2G1x6kZ8QXEduN6RARuft2DRJq2yB0pvl9bjjn+36JpNqV6/DMPLP2I2IBA4JJtSqJE0155teqF0sEntDpyLy2RtVlbd/uHrpFgDLoYl0JsohcG9w01beKhP9DjFK/ekDFOrBTgUbamkHJ08i7hpgblmvMIuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu8OvPBqaB1eANKiSrBaqsWZ1181+pgBMuurjLEFro4=;
 b=O4YUTr1AJ1Q/M4mUbRQl8+b55UQM8eVUn/gOpMNjOR+2LjQVLGJEOjca+7+mhQbzLEk38LxwEQJmXGycv3nRSMknCTFe29yTdildKsiM6MoQTW+vsSMnvONGw6X0oUa0fzgBy5wHyj7adpMVJWa2hCGBttkbzkOs4DX+J7HSPVlchrTaYmYx2JGwaOuszT3U02fJBNgFTmAfxALv2B/wHIvIHyCoYWcmZlH35DGlCBNdEi549YzKJASPp7EE/eboloZ12XDeMT6/AuYyh/5UX6HSNTGzU0IK+80/2ykFpjDutpltQpqXsfTrd9tegcqNtlg8+I7Oa0aVzAkt0a5UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu8OvPBqaB1eANKiSrBaqsWZ1181+pgBMuurjLEFro4=;
 b=ZFoY0bLM8+zgqBvfPeceAv1I2hdmpVppC/uQLIwlCH8V+Uq/Ayj48AJxZYGGAO6B+Q6UBZ2Tjwh8BWHF2q5PRUo4q2V5ldpSXP8t15yqRQA68uarOq7NTJCZJGtYpweancj6xpoWUtsl1alUCSjiUCLciX4Fn2H2KCwrgcgAo6hCAjcw0Jj5QP5uhxJPPAnHpMTawo3hqASjTT5mU6Glw5ljpi3sErITFLYzLBs5qCviKUZXLwVEJcmhrkXuVgcO/4rq5j1rMNH9r09hJCVGN/AaL/odBw4k2HtzhISF/oKKzRkWu4QmsT+xvG6N9yymkjRUeZM228ld0CBkogi1/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:23:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:23:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 17:22:50 +0900
Subject: [PATCH 1/4] dt-bindings: display: tegra: Make non-vm registers
 optional
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-host1x-nohv-v1-1-65bc682a617f@nvidia.com>
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
X-ClientProxiedBy: OSTP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c04bf70-86e1-46b6-2194-08ded0377a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fDWlPW7Znjbr9ehy6g4OsLyOBJ+Chdw5iHlb3qyTtqtJmh8DKFO/4LClhWOM6ZKQKEQxwwfjcvHjxc+sFDa1bnulMbsvWYpMbxejyjVL1HBdrfcNvVfDtZ9C77UAAjneJJk81PCeg5QmA0CLl6Fx+ExYVZu/wmq2WLDOrp+jzFcNndyNhkjalMvBBeaDIoz35TkbrYn7F3gsyhlQVFkfzQJ+4NjePydjlIghVNEO1nM6vtwGJkPYCa7yWdj5cgWL5NzYRjVApQEbg9g3lymuiMBTUr6ihEQnIrS78xZNvfGo/g/P0j/44fQBPTdssTSkn38NNCHmeGDewng5scIPo41qZ/kPiBqpsgetJnnq5JKLj2pavNbMJi+Ie2A0G2y/6DVU4+wui+VFYnJVu6OukPoy4hgRNo48swLcq8N8I+L0j9xCl7A63GcOFOSW3mXdJBWgneUe8PeWwwmCcRCaP/enwtiYyaMAHqrrzX3WL56zPR6+fdGOSEOKnU0Fu0X4ZAk4o75k6rp8F/MWm2FKbljg9Aog2srVpga6i2FAzqoafIcDbDxB/LxzzVzZSEasuHa5eUzz73x33Ewl+7U7FNyRxGX6PpVSrkFZGMhXUy5CErtmTyD+deqpPi7N79kHYJ+1G6MP744TM/lkb/M+PB4h/Q+iB6KH8Qxj28laiqHT5KNz1p3hNeUkUR7yPYSW8e7l2nC4blOQDPWinYgn6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExrajFuMisvRW9oZmhpdlNVSU5wSms0Sllhakk5VG1OZWdNeVhDSjRMZmhN?=
 =?utf-8?B?RGJrNjc1d0cwVGU2S3lSMmNYMFFVeU0vRmZKU0lzR3ZKVUNiUjl2a3VQVzNz?=
 =?utf-8?B?WHZqRmcyeGlhSzBib2dSK2xmMjJ1NHZHclk0SVlKYzZ2MGpKejFlbTZzMDV2?=
 =?utf-8?B?V3k5Zi82c0g5Y2FuYytzZWtpTmhNUFlOeXJMMnpHZnJQdFQrSXRXUEJzTG8x?=
 =?utf-8?B?bXdpQ2xYWDBPNnR4dWlrSm5DUEV2QitSSkR1Q1grQ0JhckQ5a0hBR1Vxa0F1?=
 =?utf-8?B?UWZWUko4TmRGa1RSNnI1bjlwUktxQStadUovK3Q4cnNRVWxJVTVtbHB0RkNM?=
 =?utf-8?B?WFY4T2JCbnJadVhhQWlCc1JqanFNMU44TlVRY096eVgvQ3dHMVpVdVdmRi8y?=
 =?utf-8?B?WThnV2dtTkthUnNjK3JWMDRoYUdnYmViek44UEZ4WUNPNTFiVGljcGVoUXkr?=
 =?utf-8?B?STNPYkUrTTVqOTNONjhwUkdhOEVIK3N3czRRb09oUmlrdXZ6cEIyV0tHWS94?=
 =?utf-8?B?YjV3TTZtcU1TL08yMlNkKzR3alJlY0JsN2ZIWGlmZFlyNm9ZWFF1WWhWMC9K?=
 =?utf-8?B?dkVUNFBIZVJKaEtva2FELzdVV0Rob213WWNJb0F0UTFEcm11aVNBemd1Mi9u?=
 =?utf-8?B?VndVR2sxR2I1OTROL0dMSEVyQVkxOWNKeFBUSHpYamVJZnJhYnNiOEkybDhZ?=
 =?utf-8?B?U09mUlhyYXVOS0RnZHpJSkxaRWdFVGlrQXpPVlk1QzA0Yng1eHFQYzFaYkpK?=
 =?utf-8?B?bnhiSWlRdXFFd0ZQbStsQVJjb2M3OGRtY3pJUE94aTliRFRYUVNhWDJUMnBs?=
 =?utf-8?B?QWltenF2RmpRd3lSd01lSlpzSVV0SW5kbVcybC94Uk00T0VlVC9QSEx0R0k4?=
 =?utf-8?B?MHJTOEJ0YXBEQ3YyMWFKUVhUNldESHFMaENkREVxbmRuMkV3S2hVY0Nwally?=
 =?utf-8?B?aE51VWJyU0tqYUd6WElrUVBLbEVVZHdHZVR3YnIyaVh2WndDWk9ITFJ1N3Jq?=
 =?utf-8?B?Ny9IOEVEZ3Y1ZkRpU1VCK1ptcklod3MvakJmVkQzRVd2L2lIZXVhYjZpcTU0?=
 =?utf-8?B?dHpOamhPZ2tIZ3ZST3l6K2ZvbnRWcEY2bGkxKzFHbll3OWtpdndTbFROZ2Na?=
 =?utf-8?B?YVp0UUViMFRPZCtlSXhDNmV0MUdoWVZNTFVZKytMK1hIYWFSZ0pHazRqUFgy?=
 =?utf-8?B?V3FhQ2ZWWFJyY1VCTDVrdTBHbEpYdkZjZUtmTThZaVNQNU8rdkY0S0srM2ZQ?=
 =?utf-8?B?U3pSVHZvWld5TFBYNUN3TUNsdjMzc1Fvb1haOUZoclFzdkxFWmhXOS9KemE0?=
 =?utf-8?B?T1VRR2NxUm0wWDZKUUlPdUVtQTIydHBhTWlrd093UzVRdmtQenpDMnNncHN4?=
 =?utf-8?B?WVhpaGhVM3NqN3lDTUIwem95YXVwU1hoZmk4b2d2MUZyVW1lR3cyMVpPZDhT?=
 =?utf-8?B?bUxoTWt4UVJJcU9WbTdZOFFSN25VK0RseG1pTENYL0ovQWU5RFowakdvWmVD?=
 =?utf-8?B?cDc2SjdFUC90WTV6YzE2TFBHS1BTQnpzdSs5Vm12cTZEdUovSGZ1MzBHR3h4?=
 =?utf-8?B?Rm5kSGFtVXI2enFRejJ1WFNzYXF0NS83ZmVNaGhvMmZJN0h0YlV3SWs2dTB4?=
 =?utf-8?B?ek1VT3cwT3ZNdGoxUXh6SUVYbDV5cTRpNXk4NGVFd3hZR1cvYWwzTnA1M2Q1?=
 =?utf-8?B?cGVjK1pMZmpNM1VEWVh1elptWlJ1M0JkNEkxZHlEZUtSaTZoNjVQN09OOVda?=
 =?utf-8?B?ODNBRFQyalJESDFtTHQ2akk5VXg4aHk5VS9hVStaNTB2STJRbHNlQ0NSbEpW?=
 =?utf-8?B?emZQU2JOeGpqellXK2NqOU9WbW40VXRZS2N6MDd6OTl4ckpjeFZydXNZeFlZ?=
 =?utf-8?B?WXllRmVRd2dheVBRc0hZR1oyR3BYNEpaK3UrWTdmMEo4bkxCNkxOSUJoSkMx?=
 =?utf-8?B?OEtyNU5SejdVU09ocG1oTU41T2I2S2JicDZEV2hVM2F5dkhvOVp2YldjNWJL?=
 =?utf-8?B?RHVTdXo4djNOL2pmOHQvSnFWQmtQcUR6VXYraG9KU2U3TE5lU29UTmJhQmpM?=
 =?utf-8?B?VFNCc1R4QWtxUEVyMkJLZGFOVnZVL0QzcWIrZFR0QjFEaWltREJvMWR4UGUx?=
 =?utf-8?B?bXBoZjB0cWtNMThFNStaR2h5QWZneTlnd3EwQ25kb3JVeXExRVR1bGhSSkg5?=
 =?utf-8?B?NGppKzMrMkpxbFpVcFJiN3Azc1g5d3NUYVl4UG9QNlB5aDRER0Z0UzFiMUtY?=
 =?utf-8?B?ajVtVXB4RVR3L2xranNrWWJEbnZJc0JDUy9sYXhyWEg1K0JmeWRqTnROVmNs?=
 =?utf-8?B?OGpLcHFmTGxkTmw0Z3BiR20yVDFkTm1FeGt5TGI0ZklSVW1QZGRKVnY1dDhm?=
 =?utf-8?Q?FVBb4rbrgX/FBo2frGWvri4Q0pIVAc4LRgGU5yEdp08eA?=
X-MS-Exchange-AntiSpam-MessageData-1: Lh4pxOdINmLxEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c04bf70-86e1-46b6-2194-08ded0377a20
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:23:02.4676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JIIrgxhdchPwNrvg6sYMm7GjfSjxvh06P/6oaIedcs7SxwvhjmS+u607aTmTSN69eYhkqxzF/8PCmMX8EuWiw==
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

Host1x can be used without accessing the hypervisor or common
registers. Adjust the bindings to make them optional.

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

