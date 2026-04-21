Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883C4F327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21D410E879;
	Tue, 21 Apr 2026 08:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aW9jd7Kn";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C961A10E879
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9u1yJATxfFOfxpityGmhZ04pZ1ZDNYJ8j4EaalDDwJecMjsEufwSxTK+210Xbijb9SHfqOvDRdY0XNpQYl/WdimnxH2Ub4KiHQlf2G8jAUflj6VhS0sJFagwYKO6WAr0pW4oDXJ7efi7Dre9yq5fVH3+FbVQ/5xt56Cqk6fwVkW6KKP7b+c8dHFdtXXm6qWk+cUfSlMCFher8mHH+NPfPKE6hLC3mSFG9pAMDmyqq4gnIhtagRTDxDMlWiUwdQ8DCJLdg6XorxPYsfR+PquJiv2JqAtKmqxX1AxzzyGhN9lvtygUmf0HDUFal5US4WJV9k3nn4HsQNWASYizYT5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xe4lj25pLelHhHRVrinfyrwKL37xLXF4CF5+fweIzk=;
 b=qwsrYg3vKLfzH0l8iCQuI7bCTnH550gmDJlp9eC29XprOFrE2tHrDHOd406f7R4F7yH7WyJ8p00RLJu8rYTVNTTeFraXfvDqaxAD70aa6zDyiaYck5VCiXt1ykLpdpSKGU0YPgSG0GbUNv04NKXH+zUqplLe6hezGbVMvP/+5DCYHtlyV6cMv5LKMAt5+UqwzIHNbyBZM1q8/Js8aRJJ8UxE+4Msq1GW5TsKOq5cKDUwh34awzae3DN7IIh3O+MCYgmj4025zkiYafAzHR7U3VbL5yyuscXA3BGNbbB3yzIP6Pe6GYR7yLqXCcGX/l6oDvG5L2zz540fa9hH61fq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xe4lj25pLelHhHRVrinfyrwKL37xLXF4CF5+fweIzk=;
 b=aW9jd7Knz4qe4eFuH1VPl7zmaCAxZe2bzJ1WEm+qGekwBGKzzcVO5sohi7lxGjH73C7Rk19GfdnnUG17/dQdmMzR9hzFBYMobvSy/+VviZJg924I+6VXn6KJt1XY7o/1m65uvrCxsB3vWTsVWe3/Nf/KRPmwUX1jGZOeI85VDfjhICl8rfVloQJZyxgIRc3jfOlYAypq5ci8NenyfZWIMGAamEUzZkg3+Q1wm4PvvPLZVSmmIQh0YroeJpJqglIbNI7piM2VBRhNu4lE1Njsrng2zZUB6/EVEmIcJMdMEIJOiSYzu2Y6lTyQpLdAgasY9rOEdEk8JSHDkeii+5XxlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:20:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:20:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:21 +0900
Subject: [PATCH v3 02/11] gpu: nova-core: vbios: limit `BitToken` entry reads
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-2-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a178c0-cb1c-40bc-887a-08de9f7ee44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yQnVZz6M7xxt3V2SJBSh61p8/i97b8sxSy7yI5wWC5t73raps1ZYtVvigc5zCUuqm69X6GgHGjvBJhzexJZT/iSi6e1Ke0XUxfF2laiUFM9FLtT2Jnj02FYwEg4J+tg1OtdA+RUnXlXYY+2aRqDu+us6Z3M08hRgD5JK7bOBTyEI6nrcVOBOGOKIqGpj4S/kSzrgiPSCLQ97kn/Rox4wy/0S2qj+wSlVH4/fC2CyK/0qhX6RiaznXdx2FeoBlDyB6/5nfR+T00DggP8qnq74OiorOXVelKJNWZBLueGxVn1JY/34ehvGpNOgev8YOlwmO+3npL2e+S2st9SHkSjFpkLTMhpJjr/lE4lQhpsOHaYf9HhfAQe2PI2GaRDp1TkemUdq3/ZFC7fBWrT0abiOvbMkn07nYOb3HzBcC/1p3oRFTm/Fycw5GxRa4/SiSpgUwK/m8OP6ZiaSqe6Urkx+ATz/JoasDTB6tMWy+fR3UXJQZTflf5B/XU9vC+n79oViSimBIJyg2ii2kTpAxmEByfP46MSDxqm9+goO36XSkhyPMv8yr5alLkZvvn1RpxWrbKD+TRe6ultjkd5V2/CYSEQrufYq8XqhDvYYfwbhZFLGjtMxb3uyq19do+l9WLiynlYLyO48Hh8VTZdChaBugdJZobLDqFoQdlke0i1iiE/Og5W8FeGDC5us6BiYFTPTB5RnCbCJs5vnuwzDVmO/YByNlYD2odvzk7Ti/EOHQ0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBUUVpsUm5IOUlReHhNTGhjNXFGTjMvWENwcEJnWmNmODN0OUxSb0tvc21z?=
 =?utf-8?B?SkVyQ0s4cnFYWjg5WnI0by9OWVlNRDdCSVArTmtqbGJJTUkrTUFqWmJpa1hn?=
 =?utf-8?B?WnhRK2paWjgrSXA0ZWkvSW4zZ1RoRE9pTmc0aUwvWE1kNkxRVldLVWxBUm5m?=
 =?utf-8?B?akJnSXBCWTBvMEU5WGlQTThZaWVaVHZlVmhEejJrdTQ1Nml6V1Y4RkNXd2ln?=
 =?utf-8?B?cnk1clE4Q2Y2Y1RNZzk4emc2L0RWNTEwTkhUbW5rRHNWYzIyWCtlZ0VrK3dQ?=
 =?utf-8?B?Z3pNUjdNaThHRzZWSlZGSzF1YXNZSlZ1ZktIdm9JaWhRL21pWm5ENGtsUHYw?=
 =?utf-8?B?dkFaQVJ0NE9Yc1FPZG5veW8vMUtyeUdDbGk5QmJ0emloTktPTS95cFZNQlQx?=
 =?utf-8?B?TmpDUGdvbVVQNmhRZVdPZWhvZ2gwQ1FMb3hiRThZOTNBQTVBaFZsRkhJS3lh?=
 =?utf-8?B?eFBjWWFIemU0aFUyWmVZbHB6ZWVVdTZ2NUdsVC9xd2laWXhvOVNsYlVicFdV?=
 =?utf-8?B?cDBpYUozUkswVmJ1Ni9jRnZTSUdxVVZ2SDZFcUtaQWVac2I5T3RWMFlkQkdM?=
 =?utf-8?B?OHNpOGpHL1d5bGg1NHNMLzRVWk5EMVJ1NFE2c3hwMzFvekljUjZOWTlQcy9Z?=
 =?utf-8?B?V0xnVkFnODdJVzZMSS9GTXN0SmFpd1FuYWtzRmtTc0szTTg2dmJMV3NpczR0?=
 =?utf-8?B?K2kyT1VIcVZlQXYrRXhxWDBMSFlWNlp4NTBrOUhZTXo2NlJpdmxoMzVIMXhj?=
 =?utf-8?B?ZlorWVBPM0lsdXlnZmg3NEZsNU8vZmdEZllzd2U5a1d4V05TSzZMNUFJczlI?=
 =?utf-8?B?S2ljYUMzYWtDRmNKSlZRb0dFZlFrUUJFOFpFTjd3dDRIMjRBeEROTUNObFkr?=
 =?utf-8?B?ZVRZeTdLK1VlY2NyM2lPWFc3MklvUUt1UHpTSjdVZDh2WHlvcSt0UTEweHVh?=
 =?utf-8?B?bmZ4VFR4M1pxeU9IbGVqQVZ3cjhhcHBIalBuZ25MMVZybWZKVm5XaEgwQTM0?=
 =?utf-8?B?SkpUVzNpMEphVVdCTTQwa0E1K0swcG1KRmFESnQzdEF2QXpwQXlnZjUxMTFS?=
 =?utf-8?B?dGUvcmN4TlhVWmwxRHRZU2paUURCR0dieUswT3ZYdWFmVCttcVhTSkoxMjll?=
 =?utf-8?B?UlRxQ3VBR1ZxZFNGczZucFA4c3pGcStGdFVRUVhVWFNJVllBTmRhRU9ldG1Y?=
 =?utf-8?B?eWg5emhBcmEwREhGK3g2alEyRHcxR2MzQUNtOHVyODg3TG1sNG96Y2FlSTU0?=
 =?utf-8?B?RWNEcUZDU2xjM0VKRzBnMXlpOEpQdXduWUZsZ1ovVGZFQ09JY2FVc1N6WlEv?=
 =?utf-8?B?ZFJya0ExdG5Vc3ZJa3VIY0pLNW5tOVRjRjA2TVE0eUlNWnZjRzcxaitPVGFH?=
 =?utf-8?B?SCtmMkRtRXJpemdUdkUxRlRRTHJpazh6RGJLeDdOYVl1dWpkTDM2YXY3SmhO?=
 =?utf-8?B?Tmc5eG14NlVqM1dDTjd3K2U5emFTaDA2cWJLaktCdXF5azRLWkh4K20xUGpi?=
 =?utf-8?B?TmVvMnVKeTdabjVxMHgxTGVJWUZtaHFvV0Yyd29ITXkvNGYzaGN3c3RDNWlj?=
 =?utf-8?B?ZjIzRjRzQmtjdHJkbjZVQkRlaGx3MlQ4K254SXJ4NUw1dS9na2NtN3hyZTh6?=
 =?utf-8?B?RHA3Zm9lM0ZZL1ZIcXJua1lRQkE5TUQ0dmRFTDd0YXlJcE9qOVN1b01YTXRM?=
 =?utf-8?B?dnZCWTZhZlk3WUlqVHhXbk1yZzVCM1FXSUt4a29la1BITmtNc0JDMVNhM2Rx?=
 =?utf-8?B?KzFzTDdpT1RYNy9uajhkSGNxQ3c5dEZRVHEvamVrVy9iYmJPV2t4M3Urc0JK?=
 =?utf-8?B?OW1mSGl6NU1KL1RvYWNxcThnOWFIVUg2ZVlyTS82dXY3TUw2VkRpMnNwMTJS?=
 =?utf-8?B?ZElJN09oZWF5SlFIZGRBUmZjU0lZRnpKMk9GNDFqNDF2UWF6M09NY0NtMUlN?=
 =?utf-8?B?TXVVR3RzcUV0NTNnaktsdFRtbFNuZ3BMbGNCcVF5UTZ2cy84YmVpcUp0VXNL?=
 =?utf-8?B?Tm85K2R1M0kweGV4L3FRRDVXcHVBc1dxa0NWd3B1aVV5R2UrT1JrNHJ2dlRP?=
 =?utf-8?B?aHVPOFpNVFZXQjBYUE9rdGovakNZcFpNcFRSU0dYc1l3WkV6MDVEZEhOQWhG?=
 =?utf-8?B?SGpEUUlCRFZCN2dMdW1PWEZTVWV3MWdsUGk3eEZMTk5keFVweUtSVG5qRCtm?=
 =?utf-8?B?Z2dOWkZ3RWFUaS9FdjBXSi9PSUd3RTZEVWE0V05PSTVZS2ZGdXFIVnpaZFoy?=
 =?utf-8?B?MCtqSkpuT1dJU2FDNGhHU0RHWFNTUktCeHlyMUVWd2syVmNYOUlWTjY2QmFs?=
 =?utf-8?B?WTBFOUZ5b3dEcFZSYnpQS1hHR2pMVEZySHBKQm9sbDFXV3pvVWowdjBiSUVt?=
 =?utf-8?Q?dtNqRMrGmvMt8H+/NWRkwoOMOUO9n0M35kr/ANo76w/1s?=
X-MS-Exchange-AntiSpam-MessageData-1: dwxcHCnNVVOP4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a178c0-cb1c-40bc-887a-08de9f7ee44a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:20:47.9221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq+dKiYFKHoel2epUuE344eQ3I1OOsIDTzhY3r2YTaVcaXgBr8xm9mjT9iRxBZCog/FGsLUNWgwgJ8JBxwlAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

If `header.token_size` is smaller than `BitToken`, then we currently can
read past the end of `image.base.data`. Check that the token size is at
least as big as `BitToken`.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 6de7e58e0da0..de856000de23 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -423,31 +423,31 @@ impl BitToken {
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
+        let entry_size = usize::from(header.token_size);
+
+        if entry_size < size_of::<BitToken>() {
+            return Err(EINVAL);
+        }
 
         // Offset to the first token entry
         let tokens_start = image.bit_offset + usize::from(header.header_size);
 
         for i in 0..usize::from(header.token_entries) {
-            let entry_offset = tokens_start + (i * usize::from(header.token_size));
-
-            // Make sure we don't go out of bounds
-            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
-                return Err(EINVAL);
-            }
+            let entry_offset = tokens_start + (i * entry_size);
+            let entry = image
+                .base
+                .data
+                .get(entry_offset..)
+                .and_then(|data| data.get(..entry_size))
+                .ok_or(EINVAL)?;
 
             // Check if this token has the requested ID
-            if image.base.data[entry_offset] == token_id {
+            if entry[0] == token_id {
                 return Ok(BitToken {
-                    id: image.base.data[entry_offset],
-                    data_version: image.base.data[entry_offset + 1],
-                    data_size: u16::from_le_bytes([
-                        image.base.data[entry_offset + 2],
-                        image.base.data[entry_offset + 3],
-                    ]),
-                    data_offset: u16::from_le_bytes([
-                        image.base.data[entry_offset + 4],
-                        image.base.data[entry_offset + 5],
-                    ]),
+                    id: entry[0],
+                    data_version: entry[1],
+                    data_size: u16::from_le_bytes([entry[2], entry[3]]),
+                    data_offset: u16::from_le_bytes([entry[4], entry[5]]),
                 });
             }
         }

-- 
2.53.0

