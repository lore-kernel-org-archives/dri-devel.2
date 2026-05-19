Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224F6CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DFD10EA30;
	Tue, 19 May 2026 02:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgdd8SMy";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ADB10EA30
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwRVtYY5HQihev1z4DoW4iiq9ORYtOJ4Rjsoxaw8AhkA6rk6D6ZRHmyskK/QDquRFge/xhY4RBSjHP/dm0FQhRywwHpbmjToSZ1+w356g6x32cEXCjnhET6kev46YWgFZ6jYBiuMFdVhoz1eaTP5brI/5B08jpdBKhBvuj/9BAfVEORfOd9wpQ0R9cknoXZ7PUH6n+ej80z0ac5xas99ds9eO74O8hWW4G9DrKVifrj8c+P//IhvRasSKCoiILWnoG66fqAJkayZjIXAu+KHJtNl9JYjQ2t/p/T3YcmASpbQHecVcukO+h1OS+1eDANRhGedSKwAe3gnjvaQCpx1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skCH2H/Jmg+cimdHD4tGh9+CEuo1RGzoh0Y1GieELaA=;
 b=P9HZPDY5WEmwrE70miTFB7+m3BofK/025KTJ80KsbRpevRuXleqLa4oSGTWF2mWEm3cJwu4QIhTodRgUikL6VceaBYm36Cv2NZNIlAlFKeOwFFycDQETta7pKGkMKxaXMN2gcNqxdcSRCj2UwTh2QHOJI+Sc3Iz9JUnEXCzMPt5f934AhWqTeWaOI2iA1Kex6xl/RgYkC7C8Tc0UwcgGtnuvDoYX6NjIs3fqjrmTp92e4MeF1Z17aSDK+XJHd0F5Y4F21XtC/sHq1oyM/Pc0nvp56MhOMWR1w+1xkRlNYpGTKzTwe94X5ZL2+NoXoKUVvzQKlRGxrjPrNimKxKcmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skCH2H/Jmg+cimdHD4tGh9+CEuo1RGzoh0Y1GieELaA=;
 b=bgdd8SMyqYI5iVGi/dvEoNuBy6yepPqSUrI6fXNd7ep8g6aJtAzqcgtq/sESPmEmu53YqkN56KcZ+a7bAiuN9SRrJW0v+mHEUt/J0Ublg9//NJBMZ/u8Yy7BJGr5rOceAPLdj+GdsFhAi2OOdE/8osZgRP0yNJ+vQ4kIgk/PwavWab4AQgkW9WSEtdHwOVjEd9Dm6U9fjzypuIr1b615N0r9s6AgbHeFy5ucpy+eOJzaw8dr4B4e2KNESdEIrPj3d72PmjaVTVK/+HNAh9raDUpOKVkkppn0qxWpt6rTG4NUnk8BVHrjdTYdmo9shqY1ULXNiknm6UPr4MI9UTjV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:57:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:57:01 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:12 +0900
Subject: [PATCH v4 18/20] gpu: nova-core: vbios: drop unused image wrappers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-18-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 707a5822-408d-4a5d-e0e0-08deb5524cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: TrkbvAY4UMxeK1lMBt7K/8Sx2ABCKYGJWF98y7kuvdW7wUnPsOcjVvoeyUU4baguVB1OubyT9vjQj3NStPvJCphudZBhfu3VWrWO+rMLL5uhTeU71cCiJXMEuLUoQjUQ9PpBmg52OBJHfVWGGEdHvo2jZTN/7A1c2Tj7j8gZgAPwJQ7EinnYljJVYWHyeJkuSqPAknVejiHxBQ9TdGlL5i9I+W2wgnEh8mag2AYI/NeJAFLN3HWepyzfeW4VCYeLgUuufliTTdQDbpoZ/qO1g5+9Si43P9oJ4SxB7FC2DNFHlmc1NqaEI45DkXCWkzsp9PMx4jktP+oJurQ7ztBSMvWAJl219JAqUntA/901l+PM2sA9Vv/0H8PHERN9nuH9zkqK7waTpbrics8DQZ9yiEVAdpQyf6Xoz9w4wqit+aakLN/kYigPeD+PYP3Bae6MmWgki0A4zQwkrHfG+A81pB7iAez4poHvKME2WW3uu1mZpg/RDj+nUjLNSo8hVtaCC0UIf7vhM1uNshE3ubx814rCTyJQRscf4V5F5fXudtOCzzG0Vtabv69Rs/4dbOQF+nW33Z0+Fk/9Doi5O5Q+jsWCW9975aY5HTTU5801zy6Bg2jzqBW+rb6lgH3fDaidMJUd6r9VDSj1tXgusTJhfOqDMd0+zMFPzwn9yDmQaqRS2pfG5b5cIPp2ZrWCl1Cu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZkVXlzdkZiQk9pVHIxZ0p1VXNDZEFiRldEYWplYjJvSHdnRHN1MklGanRr?=
 =?utf-8?B?WnBUZTBIR1hHN3pTU29mNTZxaFhsVFFnN0RsUVQ2Z2NwVFREekxHeVZuRU1V?=
 =?utf-8?B?Y0xwNXdzbU84VGVpaVdLdEJrYVFUSEl3eUF2VDE5T1ZYTnV3d1ppQVpGZW0v?=
 =?utf-8?B?U0Vrd2hnMFA5a2lTRW9hUEdrRkJtbHJnYmR4VzZtMFM2ZU1hc1JnU2gzNEVj?=
 =?utf-8?B?dEZ6ZXdmZXpzVURsMjdJbUhwQ1NXQlpSeDg0RmlTS1U5Rzc4S3lkczhkWm5K?=
 =?utf-8?B?MHJ1UmJmK05LdStHNnJpSmphakg0ODBON2xjVjAydFZwVmc0a0xMME50UVB2?=
 =?utf-8?B?d3B1aUhKOXRtNHVITXh0aDlmV2pYdW4xaU0xMHFtSnJhTktvWkM2NnZTNDB0?=
 =?utf-8?B?VWNTcnVaQmo0TFRlWXFPQ1MzUW9yTWJqOURZc0lQdmU2dTk0bG9zeFFXeHgw?=
 =?utf-8?B?SStZVHNvSGxieC9oUm9ZaUhRSk9FS2JaR3BPVUlKMUNiektzSDZ1RUhzYlhI?=
 =?utf-8?B?dUJXOXBOTHZjbnhRb0d4SlM5cTBJb3V1VTNZN1IwM2cwV3hRdkRUSHQzSU80?=
 =?utf-8?B?NG5ZZ3p6NjBreFZ6VDBXUHNuS1Y4QzI5bWpndldCUThZS2s4bFVaSENkK3B4?=
 =?utf-8?B?VldtMjlOck5YdVJyWWVRV1NkZGNHUjM4WEhVU0xuUmwyTEl2ZmZWUHJocXE4?=
 =?utf-8?B?MWNaQnRaOTZQdUpzbHVSenJ5TTcwNXJWTll0NjA4MHNkUDF6YVFuZXVQS1lq?=
 =?utf-8?B?Mmt3N0lKUjVMUCtjbzViVmdSZFhvRkRsRjc3elNTUTlDWVRNWnJvQW1nR1JE?=
 =?utf-8?B?T3ZqR0RiNWFCUXlnVXp5dmpJSFpSb09ta3RhWTdJcDRONURQK2FtbmNxMVU1?=
 =?utf-8?B?c2dzd2Vqa0p2QUZiQlp5aTFuejgwYzRUMDZrK0NyTkdPZHRtSENIdmRSdXNQ?=
 =?utf-8?B?S3pCY1hkWGVLaFFWR1h0WnNleGRlWUxsZVIvK0xkMG1rNTZaRVJ1NEdqWjdk?=
 =?utf-8?B?aFlBNG53dEUzclA3ZHNIS1plVENHNnlpTkxYNzRXNlA5S3VySVk4elUrR3Na?=
 =?utf-8?B?RHVFS2xMMHZycGxENUo2aXMwYUxxNkNUbXA2eVJxK09rcWN1VEovaEIvSWRB?=
 =?utf-8?B?S1JaRzBFeWpmNURxL0Y0TnAyR25kdGgxY053RzBJdXVkVERUc0FUb1hocHlQ?=
 =?utf-8?B?eU5JdjFWelFwdnZsTXMrMEozTXRSb3JjWUdiY2dHQTdVZUQxcjdYZDh2WFE4?=
 =?utf-8?B?TVhxaVZ6QXppaWZieGZTeEQxQ05Eb21hUkNHTm1LeEtROVZLeUp6aERKZldW?=
 =?utf-8?B?cCtwNURMcEpBN0lwS0V1OGt0eUxoWmlBdGZTVXQ5UEdpWm1aN0wzVlpYL1Y5?=
 =?utf-8?B?eW1YVFVwd1hxMzg0MDh0bVlQOFVUbXJTOTBwMFZMbUxZcitpdytkVXBzSVM5?=
 =?utf-8?B?eW9KU2xkK3JVSzNsSXRJeWM5RkIvVWNYTEFNQUhQTStzaXhDLzJ3QmtLM2x4?=
 =?utf-8?B?VnVra3Z3ajhpOFRObG0zTVR5Vll6RGpMWHFYQ0lIZ2ppMXovb0J4L094VHZk?=
 =?utf-8?B?NUhZRDVOekduUndTczZoRm13cXlNcHdxWXI4MTlxdXB1NHlHeUY5b2dkRjMx?=
 =?utf-8?B?K1NXTWV6YWpXa2MvWlY5Y1htQ2dIblg2TGpaNUoyYUliU2NGOEJmRjFkZFFR?=
 =?utf-8?B?bjdsang3MVN3Ym9qb3VGQXVjUEpCaFExOU41emhxVCsyV2pIUVduT1hQbmFh?=
 =?utf-8?B?dVFsKzlaVC9KaEM0SDI3NnhhOUdTNExjaml6bTRUbFZCNlkvR3BFcmFQUHhS?=
 =?utf-8?B?S3ZKL0FKNGNFN3VqVnNqZUU5S0FmbmZDRVNoRXN5ZXlGRUt1K0dobE9LYlB2?=
 =?utf-8?B?S2FPRmw0elNUdEorMjNPbTVNdTY4WDZja1dxdGE1UEsrRUMybCtJajF5bEhs?=
 =?utf-8?B?RlJVQytzdENrSTFnYmtJVjY2SEU3T2NYMjlaazB2N3R4a3g4ZjdjL2ttcjZm?=
 =?utf-8?B?RjlwLzY5Q0N3R0NKTUhHNVVhSFE3TEFpVFJmaHJFMWhkZjA0Z2IwQTE0cUVU?=
 =?utf-8?B?RzUybGFhemNSbEthU3U4SG9PN08vNXhpaDM5M0c5UXlDNXROUnRyTUM2SzFl?=
 =?utf-8?B?a2NFQUNUWityb2dTalh2OGowN2dkODFqbHlxMlJNSzNrZlUwRWt6TElNSm9L?=
 =?utf-8?B?ZjhGYkxzZ3h0Nkwvd0pWS3oyeFV3SGJDdFhlTlI0UDhFcGd5REd6bFBYR3VV?=
 =?utf-8?B?M1VLZkhTNTVYVmdzQ0Z2RHFJZVQzaTk2RXh2c2Nzbk5LVGg3NVdwOFhuenV3?=
 =?utf-8?B?My9CMnprelQ0L29tdGRLcWNZWmZRV0dDempCQXBWZ09leVVDdE9ZZHlTSVlY?=
 =?utf-8?Q?RJEGKWQ72YMHHeMAGfWludgWGl87BdwX1TeojRrA3/Kg4?=
X-MS-Exchange-AntiSpam-MessageData-1: AYR2Zid/G/JWXw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a5822-408d-4a5d-e0e0-08deb5524cba
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:57:01.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjoTmt0TNqe3a9NNXxM7XrpmIsx0KW92GneBtBb1uwu72+L5LUQNzJHMrFuj8P/i4tgYhiPhUsZCl+XYH/agYA==
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

These are unused currently, and it is probably sufficient to just check
the type of BIOS image in the future.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 1dca7933fac5..ad571b39400d 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -669,18 +669,6 @@ struct PciAtBiosImage {
     bit_offset: usize,
 }
 
-#[expect(dead_code)]
-struct EfiBiosImage {
-    base: BiosImage,
-    // EFI-specific fields can be added here in the future.
-}
-
-#[expect(dead_code)]
-struct NbsiBiosImage {
-    base: BiosImage,
-    // NBSI-specific fields can be added here in the future.
-}
-
 /// The [`FwSecBiosImage`] structure contains the PMU table and the Falcon Ucode.
 ///
 /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.

-- 
2.54.0

