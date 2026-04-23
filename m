Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90539F9EDFE
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC42C10EF7F;
	Thu, 23 Apr 2026 07:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNAa3Nt2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F5810EF7F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOX2Zl/L4ZIYcrlYFMHAlbHQBl1Vd7sNo2QNEqaKGzt4rFR0hcf2FYqRA3ELmaYi08B4U9SIPVe76OG9h7fl9cl1n/YT1huDqcynFR/84r6caIIWqsOqGBL3zjO0Z+6TsWpnKCU6jbnkMlO6Ydk614AKacX/tP2+nH+B6T0gIp/kwHPMZRF9/45VZgZZ5J393+bVnoBD6G4wAh1cjhl489qUnNVhHm0WLGRWn0USUSA0CORavyBofFgZhdBMEeskcRXftCwmICobd2LvxqsqnR++gsKoHTo9lBRoLDaIrlM+wgB1Lu+/yRvmI/1EibWsU3cYnIQNjteXYRbqrXMXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23klcSpBwOrWMnj4W6OMfxrsqzWazM7/GWkl72Ayycw=;
 b=fYN44A7pjOYjcyGWQNA8xRbMLcqMwc9cbL3aXF+rITV7toO2z5kzWLfPNG6KRATdB0FumZkqAdgVo2X/ot3bleNnN7EiozIKcj9p0p7AGQY6oV3Dl0ENVVoCsCMJ/lrUXEh32rpvK45U0MPHQwIBD/1QB/REfSunyUZA2jR0sFUtgFCGChV4EY1+CwW42OqDCpwzd0I6/sZoyttZUM8ZmmIthQZCzevGnRL/vDAZkSsdkLmeHBtYWpliuspVOrNgTOUkzg4LFg5fgt3HdwujxujgUUOSToKk2PmoBOPdQPKo/in7YaYM0C5JMXhBvOcwrUSlr1581z4Kqm3Hlos2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23klcSpBwOrWMnj4W6OMfxrsqzWazM7/GWkl72Ayycw=;
 b=dNAa3Nt2EgfUJmtyVwaL5nfkx4yf0u+l7G8O5QtG4Jf7U2ktLckLGV+DXQo4R0bcgolScZnGmUAimojpxeCRYdSCur5N3yoult6jTqm/SKS7FsAdPOPF5L2CYy9KzI9ZfGX+/xWUwuP7eIKWWxgUGzrDRcNnksnqqyCdhSiiICe7eNrUy+rEym0ZDeVmVAQowQfDUP3hwettKznRtMARRkLl8hkwvnrMHhtaQ0o/SVl/YM6WKmVrbMyjyvrPlmwuiV/VSFoVdsJCYXN8Yw5B34gtHy8x0JRFsJcjnekU/cW59JyH8GxjetqQLDyu+CADtgVSUkTaeJlDDmiEmF7GlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 07:11:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 07:11:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 23 Apr 2026 16:11:44 +0900
Subject: [PATCH] gpu: nova-core: simplify and_then with condition to filter
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNj3bTMCiDOKUkt0rVMtDQzNzRMMjc2SVYCaigoSgXKgg2LjoXwi0u
 TslKTS0AmKNXWAgAhA4bxbgAAAA==
X-Change-ID: 20260423-fix-filter-9a96711b734c
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 025c477b-f145-46b8-e6b9-08dea1079788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: C23YGWy16HlB8VePt6hbq4QTVmlDA8vA//UMqXSrAGtR4jfi/5DI/khGKujHhpNUy2aXHeNoiF1VkpkhqtcaXhlv9P6diLkr/Y8Miu0AuNxc8KACwfmZD/OkIFkHiYFvmQ4TFIr13BqLMvd61AP/jLaOckPqJ+PW+mlphv7SMdy3km/jPrmSISJ2HsG+0pPaoxAdu9ibIRjXj1my3WrA4hQzUfqywygdzrRUN/uodsf96muLvSN4i3nqUUUDKWQDz3YepjsR59mkC21x+jjK5vFliryd0h8E9QEvcZpZ/f1fHUfTUCjsBVB8qURDfzxZVbS/T93K1I12UAoYPnh0BBuJqgRcgBpeeM0YYxycgwIyZa1+GVyzyPXOpAXAk3Y8R/DmQAI0PaAsSPG7t9eRuvhKuuhudGSsFD4gOsoHUUNXj5G7hS+l9I+5XhaCyaZKhuDkuDUpce/qs7dA88Op/5yLF8+rqym+IXLaXFCKg4GoVhcvIO6PA/qwaKlbh2qbp+mN09gU9CSUjaKWYrB1CvYk2VphnPP2pNT5qO9bHC6ae+dBNIf7W9YRr5mXEfhe8cATvDliRQgg+JCFRR+bGey081HVagkUEPsLyTl7/GUwL6A4s7q1JR1dWYGsAKHpHIBRG8R70eYmPNpqVLoc47dmGhR/hzYptzSfzj5L/9e8FCtZySeydT2K0uBIuiqD3iFT6hVf6W11ciMSKrhE5gRhQ6Z4uO5CozZVAYP63qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Z2M1dyeGJ4U3Rwa0pmUXZGS2dQdkt3VVhBVW1vMkY5TWdKVDdsemdKUjJH?=
 =?utf-8?B?ZE5TZEFLTjZqMld2dDE3YkdvZzQ4N1lQV0ZNL0Vud1d6UkwzTzJjZ2RjdDVX?=
 =?utf-8?B?V3l1eUxKUytmVmRXUElZbU40cXRZbTFBRzRYcUxudFBNQ056L3ZtQnJTZHYw?=
 =?utf-8?B?WUZaSHgwRXJXU0JKQVNvZ09zbGUwL3lTWVAwNHlwUHVOWk8ySjA4eGdSRU5T?=
 =?utf-8?B?NWFZcnJsWXRMZTNxNXNEcXJCcDZHYkN2emg0eFVqK0xLVFZpOXNhN3JRWWRK?=
 =?utf-8?B?U1VrTmwwcmxsQVp2TU16M3FGUC9veWMwWnhoN1JraktUVEloUEY3OTNxbmtS?=
 =?utf-8?B?czd4L3RIWG9IamFpUXc5cUVibUZjN0czaFpNVjUrbUpGVk5SMXQzVyt6Z0NE?=
 =?utf-8?B?cjRLeVhnSTZtV1I0NmNpUnF1UlZXWnUwRS9ZTEFWWHM3RHkzR1VQVCtBbnZF?=
 =?utf-8?B?ampza0l3VWFsUXc3aWMyQUdYQjZGTmdYOU4zOHI3Z29Ecit6c0IxTVF5bDE2?=
 =?utf-8?B?ZG9TY3YvTlBwK21Fd2x1Wk9KVVg5M1pRejFvZUhvVHZwTXBHWmJya3Y4WXBO?=
 =?utf-8?B?Q2RBdWVNdkdkc3FhU2dxRG5CMUtkeThwaGVKZ2l3c0dhbXdPL0p2eW9IVW44?=
 =?utf-8?B?bXNobnV4Q0RKODBINTR6U2p5bVZpYVBqcmhzQjFFWXNZcnJtMlNmUjA4OXJk?=
 =?utf-8?B?VTAwd2ppK3BMb29zYTh4RHRRRUxYRXN2VHNQYVJNTmNUTkl5ajhEcktQVzVF?=
 =?utf-8?B?ZmU4SmJXaG1ERW9USHdkTlFPSTF1K29HZFhBUXErMzdCb2w0NlZPMk1Pckdo?=
 =?utf-8?B?ZVhIVk1lQW54eDhDMDV1QVR6d3I5cC83aU9FUDNPS1lZK1VjUTB4NU9SdEFX?=
 =?utf-8?B?OGZhUmx4dDk3QmpQanBzekZRdFIxN0ZRemdtUmtpa0tPa2hRaUdXb2c5Wk8z?=
 =?utf-8?B?ZmNoMGJHdC9qWitEeXNGRmVacTBlcnRubXpGeDIvK3g1MjhoK0RxTlQ4Qkg5?=
 =?utf-8?B?Qk9CSGNsNUl0V2VDWEhEOGxTWUxpMHZMckFqWUhLci8vY1h6UUt2YXBSb05O?=
 =?utf-8?B?SFpualhWNC9PblpBTUtKdC9Xdmk1dWhZSU9wL1pZN3d5NDZXdjd6QUVQTmZZ?=
 =?utf-8?B?QWU4RW5oejg0Mld1dkk5WDhEZmlwSWNGMk9TRkw4L3lCSTZlNmM1WDZOTEJS?=
 =?utf-8?B?WmduWmpLY3E1WWowbktwNHMwWFZyaUt3ZDFYZzZBUG1FUWtQVlYweGVjRzVp?=
 =?utf-8?B?WFI0SlE2cmZsaHdabUdiUG11YWwzbW9ERk5neFBGQkVFYTdCL0cvUzJWcWtP?=
 =?utf-8?B?by9keFNLZHNVTnh2eERwMkhzSjZRMC96aGFYcURmeWlNOUlNeiswK1J4bmtT?=
 =?utf-8?B?RU9ITVR0UjRVbmE5VitheFhhb1pjcUNBcytRLzZZbmQ3dFZnSVYxR1M4V2c2?=
 =?utf-8?B?V0pKRXkxYnJZT3lmUXF0WmhZMk5FK0pjdW5hNHF4YkNLcG9uZXpJT1AzTGZ6?=
 =?utf-8?B?Vmx1Q2QxblhsSVFkZkx5Q1VsUzlkNUprTkxNMlBDbXBFNU9ZY3J3cHIrNlJn?=
 =?utf-8?B?MjNjcnQraWJrRWRtTzZWL0NRUVBTeU1iTjdlVGIzUTVXMEtud2VkeUVwVFNS?=
 =?utf-8?B?eklFVGpWVlp3MGE4Y2N4ZXM3SG8zbWk3cGo5Qjk0dndYNHZtY0svVG9xa2Vp?=
 =?utf-8?B?ZWlGUDlRaFRDdEU1dVQvQTJmUi9NNUxyakdLby92UjVJOFRJb2ltaTJBRHhF?=
 =?utf-8?B?Nko4SnhleVFPQVNOOUNSOXppOTRQaTVyczZYY3BOMFRMOFBrZTRoVEZsTXUx?=
 =?utf-8?B?QXZ3Qmt3NUttMUwwUjMvTHRtRmk2SnNZRmhrTnhBb1l0bTNUQVJrY1FyZHdo?=
 =?utf-8?B?V3Zxa1llRktvZUNtYllmeXhVK3E4ZjNuUTdiU3UvcTJOMTIvQVQ1WHRMSVdZ?=
 =?utf-8?B?WHJQWlo4MlpiZU1QcFpNamdCNE01Yk5JYjEydzB4UGVvL2hmY0JIZjArRnRR?=
 =?utf-8?B?d2xobXVJTG9xcy83LzRzdTJXNHR4TDhWc2V0Q2R1ZGFkUFpHSUZPWk5TYSs0?=
 =?utf-8?B?bzdGcDU4cG9oTjV6R3psNzVLeFZTc2tYNmd3MXoyNzJyeVBZRFN3dDZRNUFp?=
 =?utf-8?B?ZnU3WVFUbHZPWUsyOHJjSlg4Y1p5TG8yMzl0dFpWUnYvRWJ5MnU1REY3U2tV?=
 =?utf-8?B?NXpJZXJDT2ZTdHRtcU5KaHlGZlJ5NUF6Q0xzc1k1VGN0Qkk3YkR2dUJxOERS?=
 =?utf-8?B?WXloaVY3U3BnZVlmOTNicElEdEVJRnd6NmJiMlFpUFpjbnNHMysrOTNZVHZi?=
 =?utf-8?B?TkRHZ3F6aG5XTEhMNE9hcHFqK1VSc2R6a1lVVnBTeXBHZ1dUbzZyNC80OTF5?=
 =?utf-8?Q?Dm6XRD+UuAsoFaxbhNdQPDSeaLwFkGmN3CYsc338E3zEq?=
X-MS-Exchange-AntiSpam-MessageData-1: 4T3MKP/EqpCWMA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025c477b-f145-46b8-e6b9-08dea1079788
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 07:11:51.4057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSlvijEzkP5XEsBDlNCcC9LgKcGnx7LfvIuX/tsbmr/MgmAivMzJAP7dvJhyqk20ydkwA9FsgG4Bmn053u+KPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

This code is more simply expressed using Option::filter instead of the
and_then with conditional.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 6c2ab69cb605..3aac073efee2 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -388,13 +388,7 @@ fn new(fw: &'a firmware::Firmware) -> Result<Self> {
             // Extract header.
             .and_then(BinHdr::from_bytes_copy)
             // Validate header.
-            .and_then(|hdr| {
-                if hdr.bin_magic == BIN_MAGIC {
-                    Some(hdr)
-                } else {
-                    None
-                }
-            })
+            .filter(|hdr| hdr.bin_magic == BIN_MAGIC)
             .map(|hdr| Self { hdr, fw })
             .ok_or(EINVAL)
     }

---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260423-fix-filter-9a96711b734c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

