Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDB0CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA2710EA2A;
	Tue, 19 May 2026 02:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3XkJf0W";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3204310EA2A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBYGKqeV0EWhhAu/iXgRH0Y7nj+m7lE0NwvLCp+b9FXcJP44OrP7CYD/Skku9s61iE9HMHf1UHSFQCKxXZsGeFI3lCTqyO2cgpA7yh14GPvtNUdr/MyXUfHPvRLy000UxmFnznC+tevL6dIC6vr5tjCPf6dyOzIsppPMhHsLxmKewO4H/NcFr2vrB4wpNCFBC4l7SEs/+Q5e+EHf+YcvSYyR8cqcO8NxLPjnTTqegeXL3az+ZL3+7vHj+7Iwb3DqyHSLGC505u4n+u0Yo96d4vlz69TVUvT+1sp3WEYuCYIbdIOTVib2gV5UYobojmTdaT8EfWEv29f+IJRJ4BUBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccevr+HfXoTciNCKVO+8l8HprXKaTHOohm5igOcyKRg=;
 b=jfRIQ9uySAnZ5qdlJsD/oyTCBIBmG08PHhAsMORhYO2vvONXlK5jA3jeVsTEyIhOAllkhD6Z52uSRbfdDSI220NyojjPZ7JgOB6tR455/6ojEiPpOO7B/KiuFoRGXoveqU3os2atPb5QiZxbgWfyfmK5caXlVqGTUwwbgykrzaJrydM83eDWoTgqhwY1erHNjbvtu9gb/qcEJz1MIKAanMxRDHKCRCZSVZ1v+lC96Yhz0jbjcSvGWTBbYsQpR1EVc8X2rUaQ5xX+L4z1T+GlBhEhh4l/ZAwXVT4/Aue2pLzCU89yHHC1lD4ew3qIHwTy/s6JyyDTX7X19f2InoQU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccevr+HfXoTciNCKVO+8l8HprXKaTHOohm5igOcyKRg=;
 b=a3XkJf0Wcz03aPXRuT30lksOLpCBSxg1Dmujrl9XKAyH6MQTGq/fFCqagtvztRMNLDmxuzQML44xQ5C0qKIgM4+O4+r4MNW2nvjw2sY2QlkcJoSOW3X41RUWh/kNsHO4bLmO6tZN2wduiuqBMJ9Zpyf2TMiEJkkGhaG5TcJ8gMIxbaRUIfqeAUXuP04V07tIXEsTsur9ofhGnb5eMFvNwbNzK1RPmVQU9WmXfor2d1a1GjiSwjw/UaXg2Y+6JSHguASp2vhJo67QtLjXLtpiUHsaU5TbvemuMCLI1AeZR3P50bWm0lGQRNLYuYzedYuk4PFOx0+u6YL07mBxxZy/HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:09 +0900
Subject: [PATCH v4 15/20] gpu: nova-core: vbios: use the first PCI-AT and
 FWSEC images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-15-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DS7P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::26) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff2d10b-affd-4331-be80-08deb5524502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 9B3cdv+jxOKiSAvGB+LDLYoRI9Qqj42Klb2w2iIepmMIyPmhXQPhYS6tAhemrRWHIgWOLkkZuqpeH7FzWqUhdICxTLklDGrE4MYlbmF6b5+fmGOLK3O/VYtpm78WAmSKX+jlhVNHC0Tu7QlPpfAj1/cbnuwnvqq8UG8jt/um+HyWhsB212J4R3CDhC0mvyrodZCJHit1LWm66Nd1RN2iGBEA+OLCoidjXZxw1gEQQPoQcw9LztI22AA5vL4UijFgWzMQdWrdrjLkv4HMgTfaTQnvCRc8vEmfSj7zDLloHvouSVtmCTKAogIcVCJLWA7WjY0sjXYvAhFP7DDhzxelidD1SUtmud+HtJxDdstqstaYtXoqoTvNKDmvyxuqsdGsQpEwXRqY+MTpOcaYmDQFQ/d0bNpEFJExtu2tVvcIw0m7p0EPzORJvEgSf5EWgKQRwAw0M9BAGRkakTQ8KwAya5HbrcRdiBitkvRd68+Bhnxc9Kh47WnRZpJCdm3dPBWe7q8UGj1l8BDRcx+Ag2EjkXDasz8d6UyEjGTH4vD1ACgTkQDvovi/xO+zhjWgeR2b3EpKTzB235V82qzwjnISc3S6fqsO4JM9q/EchSSvx4WKX2oo1lI7wKMLt5V/1kM7U63CbiVYdCZDcR/nJAc13W8JwqoRVJzqo1aCCBqDT7v/jl5JG7oWSwfQF5k+pviW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFXZ3R1Mk5XcXV3aEw1SW5xTTFxaHU4bjIxVmVFRDhYT2pCZlhZeTZFUm9Q?=
 =?utf-8?B?cm1BakIxTnZWOGMrWW5VQ0tBZ0FYT2lnb3ZMbzQzUEtFQmF6R2p2ZGFYSHEz?=
 =?utf-8?B?M2I4SDY2bllGN2RXMEluNUZ5TTRTY0pGL0kwSnBBR2dyZGU4MStEdCs2bSs5?=
 =?utf-8?B?NVM4N0ppUmVTVXd1RVhlYXJkRFRzaS9Wdjk2Ni9GeDNvZmxZKzdnbDFjaGcz?=
 =?utf-8?B?UU05dm5GSk9nZWZuZ1QwM094ZVd2bUxXTGYxbzBuaDVLSmpXMW1Za01yK055?=
 =?utf-8?B?NTJSREVIb2RGeFZQSFM5SmJRQi93bFlOWGN3M3dtc0NBQ1NSY2QyL0JsbExO?=
 =?utf-8?B?dEk1TDMza0Q4SUNYeHM3bFhkRThxbmpHQnZSbll4N0xUWHZ0YW9mb3A4WTd3?=
 =?utf-8?B?eHRZSlY2b0c3M1k1ZlVMOE1qZGxPajN4V1JNUzZ1OXpRcnUxQmgzdXFvWEh6?=
 =?utf-8?B?NUs4QTRVN1BlS2VUSXMrcFVRNjQ0SmFQQjZOWmRWU2NwcUJ1VlNDOUYweEZN?=
 =?utf-8?B?dnFNMENNMGJOdTFVWlNqUUcxTXhtYXo3NkxUUmhHenpBdndBRFpHdFVOdWxH?=
 =?utf-8?B?NkQrbHJoMzBtWWJ4azVSbVhQeXpmVGZDRG9HQjdsQjcyWUMxVVJhWjV4K1ov?=
 =?utf-8?B?SzJhZmxHa3AydC8ydmNTR1EwQUlkUk1pVFBzZXpRNEpsNWhFaW52ekhSeWhn?=
 =?utf-8?B?K2lQK2IydExqVVRRMEN3REVPTWI3N294c1FFWnk1eE4xaDJteU8zQ29iOVNU?=
 =?utf-8?B?U1Zja0VIMmRsZDkya0FhYVBHb3Nib084RTJaK0lYbHhJSTBmT1BwMCtzM2Q3?=
 =?utf-8?B?Q29ubVFwd09mWGxuaytKSE9aWVRVV1FqS1U0RkJBWHpLZGhHelFWK3JwTzl6?=
 =?utf-8?B?MjRCZzYweFZaakVEVUMyaEl4NDBWTmtiUGY5NGVyV1kyZms3eUM4bVdQSFNo?=
 =?utf-8?B?bStSdjBwSnUxdmRpN1hpeGdCd2R3WkI4OEhidU53VlJhQW9QK0RYSDRCeWht?=
 =?utf-8?B?MnB2blNENXgyd250ZlZraHN0Vytoa0NPV2lBVzE4VEFJdGxGQ1ZrUStHT1Fh?=
 =?utf-8?B?WGRuNEpnVlB1U0E5VVI4NW5DR255c2FhaE5QUEUrdlJUdVpteGNEMnVNd2pq?=
 =?utf-8?B?OFN5V0pPRUVpcTkvZlhaUDFxcmc4WUp4SXVobWhra1IrM3RKOUU2UHp0bHZU?=
 =?utf-8?B?eE1YN01lbnRJZ042bDdkTVJVTittdEZ0SXlNZlYyRngwUkdxVWVOTDhEbUE2?=
 =?utf-8?B?OXQ3bUVhajNpK1lvb01RaTY2VkRUSHVMVUxrbmJRb0R5WUx0Vk43T2F3OVlW?=
 =?utf-8?B?Sm5FN0dTODQ3QlRUaWF2V3Evby83Ym9EMEthcGRPZGZ5Q29QcTBXWXJGckZG?=
 =?utf-8?B?QXZocHAvdXlFdzJha01PQzNKQXJIU3ZpbWV1RVpNeUlkVDhlamIyci9UQ2o0?=
 =?utf-8?B?ZXFIZ2o4cEJpWTY2aXZ3MkloRWZBbytvRHBOck1lV2dTREh4dVYyTlNOTkMy?=
 =?utf-8?B?bGN5c0luQk9SaXF0cEdodlQ4U1gxSElNRXZ5aUpxd3BaWGd6M09PTDlpakhG?=
 =?utf-8?B?bXl6ekRVSDk3K3dQa094cE1wYUNyTHgxV1ZHcENOcVBhZDJIWllReGlBbjFh?=
 =?utf-8?B?dUZ5bFRuMVR0N2VyRXVKdmVIcksvTGtTU0h0V0FpdFlXeDBna0Q5Q0RmbXFZ?=
 =?utf-8?B?QzJSRHArV29MU3B6UEdvSU95TkJEcklyTDk2ZzVyS0JWKy9xYU9KWlQxZ0d6?=
 =?utf-8?B?aklQZzNaV2pQam1qNHlBQ1dHNkgvZFBNM2tDNzRKQ0RmUVJlemdQVEhZZnpU?=
 =?utf-8?B?N1FDNDJTR29SYk91S2phU0IyeUJ1dFFURWNqd2M5Z2NGWUY4VGU1OWp1YmJP?=
 =?utf-8?B?RzlKUitMbTdkZ2RHUHdYN0tpZ2RpYkU1WDEyZGtjNjFqSVdSSFdTckJzNzRs?=
 =?utf-8?B?ZlV4aUgweG5Cenl5aGVGWnR3V3NjRmxuckx6OC9vMkxiaXlhYjk0TE9PL0NJ?=
 =?utf-8?B?WUFCTmFLbEFLZ1dYWllVcE5CNTNiT05pRi9QdTdIeUUvZ3piYi9HSmk3Vm52?=
 =?utf-8?B?dTdJTG8yV09LdTBmdGVVU1Z0eDlJYVZqNjFLVWxLaEEwdDZWenpteDFyODJK?=
 =?utf-8?B?SjJCckFFbnFUMDFEdnNZTDh5K0tjQi9GMWREQmFaVlRyeHNzalBMTWprbmFa?=
 =?utf-8?B?aEtwRnBiWVJOMTFPMFdISlZRVHk4alZOUlNEajI2b1U0Qnd4UDZPajluOEZ6?=
 =?utf-8?B?TUozaE1pejN5MEJ3NzhyazRHcjcvQUZUbU84WTBlclo3dnh2WVFMMUZGVmNC?=
 =?utf-8?B?NGdFSFVSTzlPUWtjZFVaUXBzczRDWkhyZHpmeG5qKzVyQ2hKdGZxZUNOOVNF?=
 =?utf-8?Q?Mxl06L/E4qgYfxgeDxMy2O9BaemCpITtY3J059L/2dyBr?=
X-MS-Exchange-AntiSpam-MessageData-1: mWFJYwBO1Bo9Eg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff2d10b-affd-4331-be80-08deb5524502
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:48.3736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr6dS2OTl7o/dxaASjjd0cfYIUoolb1fCCJ51aAJeYQNDxeU+umJQRBk504x2abCq6k3mfpfHG/0mEA5dKkSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Currently, PCI-AT takes the final image if multiple exist. For FWSEC, it
takes the first one and the last one. Align both of these to nouveau
behavior by taking the first ones.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c5dad9e065da..ff21f85fdfb6 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -333,12 +333,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
                 Ok(BiosImageType::PciAt) => {
-                    pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    // Silently ignore any extra PCI-AT images.
+                    if pci_at_image.is_none() {
+                        pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    }
                 }
                 Ok(BiosImageType::FwSec) => {
+                    // Silently ignore any extra FwSec images beyond the first two.
                     if first_fwsec_image.is_none() {
                         first_fwsec_image = Some(image);
-                    } else {
+                    } else if second_fwsec_image.is_none() {
                         second_fwsec_image = Some(image);
                     }
                 }

-- 
2.54.0

