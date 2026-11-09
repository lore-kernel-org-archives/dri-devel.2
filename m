Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755F606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F+M6yWqx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8292110F0D5;
	Mon,  9 Nov 2026 08:33:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE1F10E883
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAOOyR/tr/hjLewvP+1yjHbEjrGblftAAcm9WSojSffcnxTJxaEWD65fj75/HIjBap6ykDyfau7AYlTAl7hCzJqWdnngI5Dty5jukUzaUHdZGuJtdTESbzohZLU1ZV6qsK5hn69mEg4YRb7pZHNRGh6X5HNQw1lh9lAP+itaORD2/VbcpJippe06cAg0CM581jdlLap3oZFJMygQNOSVaCyO4LhjukO5eUMY1YtPFcUqGXNW73kztHbrxsFf4SCTFzl1U/m6LV+TRw7qys6Czxc6+aBJYGxHOSVoMbEHYcX/JnC+rOFPagf7+pfwvn+sTkIJiTAItY9/36jkSuFr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsTZtt7gzfm1tO08HAZD2O1lOUWFzkKf3l/FqHU26iY=;
 b=qprtUMCyLZ4TVUSRx0R/sdYaOgjK07Yyu2jVsMtB2AGtEH0xnKjzk3Dptq0fAeKPh/5Ae46a/xZThcA7mrrBn4DoCtHkRgrtCCbCBeeYa9P6qV1HKEU/X9AzsDFIHWMOivZ2L6lKhuQcsUCrJ0Kb0UBgMg6zn+jw25GssS9ENRlKLf8ETizfmrYTRwWwLn95gtaXCck6Etr66m5xxfMciU64HqxXNd68p+2F2LszR000mX0oI+ymZKTs4+KjuxrXo3Xx9UQUWuMRgOfXFP4NsX2AAX2aoup9d32CFFWCj7XIol5tExNN9VCwtE2xeVoLUMM/B3UhA8cAp1SUnqeqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsTZtt7gzfm1tO08HAZD2O1lOUWFzkKf3l/FqHU26iY=;
 b=F+M6yWqxBfme9h0KAe1uOvFoB44frFA/8BVGk5fgK4fWayQsah9xmz4ZISA59wctnCnzVyZJGcswlhxmRWBLIQIty4JIYJJ3rfVl9wV0w+8lS7z32aCe/3gqyjhtZvPTdeTbGKwqrzLzHtxxbNsTIASJa/YEIMZFLJkLcTijHqlP/ysI+/PlssCBNQuplfnXzJhrngah/D6X5XbVtkPszFJ7I6ih+jS+3imxUvoP1G2B2n4WS2QGfqxGFeEtwiQS5jL9UFl3jAWMieDhcXf7OZY8okKgBiqOboIhJ4Jd07MgxbLxwZp22+6VhZCk+OTXaMyVbqQGsuQOyaDLPAYDqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:06 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:06 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 09 Nov 2026 17:32:49 +0900
Subject: [PATCH v11 1/5] rust: io: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-chid-v11-1-082aa9bf5a91@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4bd7e3-3969-4db7-1fe9-08df3e3c1421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|10067099003|921020|11063799006|261102123227099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Ljo611/9xX10tyEpz/rypl0yveyuOShHhgaKm9b5RRj73zolPCmDTSG40Z1IrYfFN3hbdgyVIgJgskZNqCBd0xp68WhazM3sERAK7Andl1UFb+Cc4CUqOdwyPIc0l5R8aRU9m+BnciM1mvIfpJDgnOBpMQt3qOS01FNi3KBBBkHILOIswk9AMhRmZFY3UFBAvDaJ4daRsUZebAW9HIxVwiMjUjioox3i0J41uwMCfLSZUMTUlmTpvsJUAV4KqOR1cqFHVVyzt+doKa6tIgT0CPTItEvnbYaHS/fyt2HC0AzOKvUMjPzdSKY99N6Uw4wXSFDrHDqKRasw2ZQ1fQw1Ff71UWHOwJe0R5QLt7aq64qrPwn1S83oHDgkt7VeLPzykce2ZGO8XsTzPlzZSX9EaC2KAjtQ9QnNt7i+tHEA/81cWvrZYCgiGHhyOXZ6HmRK2rS6zQ8lIYNlg47BDgsAG855woDlaSEctoBSGdgucM2749oTJKc/aq9PqLnZr35xp+18lgp7S8bR40Tf5/7cWFoqS3XIr3eUYb/nuLZ5KaWA2NrVLi7AJ83Ap/GMcasFyXaxQJrAWDbHfQfkn7WH6dOncWy6b5TW6ua5WYpRJBshWwGzzZtjG06F/6j0hFKjiiODu/tHQuzm897lVQ3677L+FT330MYgyQYeGiDrBOx6oiii7L4E7q9FlRcXKqQYPehJIlOOc+mImFE6keFSjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkt2U1puM2Iwc3d3Z2VnRUZSYnRXeElaOTRmbldQcXkwdDJMVWpiSEtuL1Vm?=
 =?utf-8?B?V2JEcFhOSTlVdDVIeXJZcW91Zi9PalVGY0R4VEdEaEk2V29XcEVaTTFCVFE0?=
 =?utf-8?B?VWlQWjRaMVNLWnJkbnp0cU8zbW9VMUx2RzRlWEtIamJheTEvNmNPMkx0Zk1V?=
 =?utf-8?B?VGpjb1BsbEZXOHhrcmdSa0VueWd2ODQ1dk5RUWpPaDZRcGtvUDN1VFk2S1ZK?=
 =?utf-8?B?d2I1THJUWDdxd2tjV0c1S0gyVEdvZ3RReU44VU9iMm9XLzFoK1BRUTZRYm9O?=
 =?utf-8?B?Y3l2WDdGQ2NVVUdpcmYxaDVRTlNIZFVLbnNLTVZCMHVYUTI3ZWpxWWtiTUI2?=
 =?utf-8?B?VS8zVVgyaURuRmVJa2Jpb2YyVitaWGpidzZYSno0L2N2WHEyR2VINmh5K1hn?=
 =?utf-8?B?eVQrdDJtVmhLWlJESFNKSHFMTWJzaUt6dmpQdHF6RlZadFJ6L2JPSnFHdU9x?=
 =?utf-8?B?THZJNzlNOHBlZDdWczAwRmRtMDV1RDBMaG9sVEZSQWowVE5SZjJyTHVVSTVq?=
 =?utf-8?B?NG5IaUU1TTVXYUNCUHNrTmF5ZUxXWkNWbVpsY0JmY0ZFUytYRVNMcWlHVlY5?=
 =?utf-8?B?eVE0aU1neUtqVjBNVWp1RFJua1VzUzJhWmJXdnJjS3FQb2RXZU41UG9ncDNP?=
 =?utf-8?B?WjN2MnE0Y0tENGNlektMdVdISS9Cek1jYW1EOENhTlhIY2hGWlh3TWMxck1M?=
 =?utf-8?B?cUs1VnlMRWNtK3NWdHcrdFIwdHF2d0tTU0RBTjRhSllJTXAwemFTT09HVGZC?=
 =?utf-8?B?cnVuU1hiZEdaRU9iaVNXKzFJL2YrMzRTU3U2bWRYSStDRHBkQU4rVDRVSkZ0?=
 =?utf-8?B?WWZvUisyK3kyblJ0TnQ1SncweGRGWitJaVlsamlEMGhpYjdUYTNJTVJFNk15?=
 =?utf-8?B?d0pnWlc2SkpsU0RSYXgwUkpBUnNkUC9TcG9FUkV4cG15TXhGNnhoWmxkM3d5?=
 =?utf-8?B?SzA4a09ZWHZ5MlN5ckRHR1BNMTVDRzRnVW9ZU1FYd0U2NncxbUMzQVA2S3hL?=
 =?utf-8?B?M1d1OHFhd0ZEeVFXSTZRNEdianZHV2lVWlpRRkt4ZDM5cVNiOU9GQnQycXJ2?=
 =?utf-8?B?ZjQ5RUpMRWpVS28xUGRTcjZJN2huYUpZQ2hRZFJRbDd1RG9MTXhsUWJQQmdH?=
 =?utf-8?B?ZkpjY1JrSzByQ1Y0dXZPTldzVlI0eE1pMUZCTEplKzBVWTNUTEE4d2FSakZG?=
 =?utf-8?B?R0V4TEtmbHhzS0RoTVlPeHc4VWhlaTM4Y3hZVVVwUzBKenIvVXg0aDJYS3Iw?=
 =?utf-8?B?UFNhRkw4eklrdWZWTXFldllmYVY5eXc5aHd1aG5GNzEwN214V2ptcUsvb3kr?=
 =?utf-8?B?aGlYd1YwQlVydDB5cTBJY29NMHAySVlzVjZXamU0OXFnVkhCZXUrYjBpb2p0?=
 =?utf-8?B?UlRMMGxTWjNOZ1UxcXQxYlJxR2o2WElDNE9Zc3FNbnliWDdZTDl0QzZUZy8z?=
 =?utf-8?B?NUFlUnZlM3lPQkZ2UThVVWFUS2Y1RUpyZGI1WmVPV0pGakNRSnp0WFV6b211?=
 =?utf-8?B?aXlkaFVzc0ZvTHNRQlUwdnk0TW1zSmMzUk1Bc295NTh2SThZdjMvN0ZLck9B?=
 =?utf-8?B?NVdXV0Z4WWovQ01CU1UvWlo1aS9VRENwRDhkSllaNFQ4NnZEdmhrQkVseVpD?=
 =?utf-8?B?UnNwK09jMmh6VllpYUhOZCtnTE4wUlRqOGFhdmlZYi82TnlSMDl0U3YraHF2?=
 =?utf-8?B?YmRlMVZwbVNwR0VHRDlOajR2alI3a2p3NS9iQXBXdEhUQkpuSGxpTzZ3dUQr?=
 =?utf-8?B?RTNOakY0anBveHkzN3I0ZXkzdWJHRjNxekFCWU4xUVBCSGdGSVJhRlpEdmxx?=
 =?utf-8?B?NkJiaGd0ZHl3WDlHdGZzZ3JnUzJEZUxjdStZRHVGQUpOTzJkZDg1aUpEb1JX?=
 =?utf-8?B?dVh6MHFabDNLdXA5YllFb3RHUFljNXdyR3lQaGVMRDhXL3h0NkpheHJwWk85?=
 =?utf-8?B?cmphdVpGV0lab3hYbXFZSTVFNzhKRlA3OWZ6a2hlZzZ4anl3QkJvckRNUUc5?=
 =?utf-8?B?OUtId0NHTkhPc25Ec01ycGltai9lTDVNeGR2YlBlZ0FQVjl4TE8xQW5raEVE?=
 =?utf-8?B?QWNYYk9QVFc3ci9DMWRYK0RpNC9pRVlzK0gwcGVQbUhEREM3dmZNbVlDZWpF?=
 =?utf-8?B?UUZrK1luQW03OElxYno4Z1oxU2xqZmwxQkdZaG9DMUQ3S3dUUUFBaHZLOFg4?=
 =?utf-8?B?cXNEVGRkREhUeGkvSjBDSUdHcmE2TDNtZjVrNXJDYTMwNUQ1S2l5RUNQSmNj?=
 =?utf-8?B?cVFiUjVWcFU2MkQ0eEVsY3pQcVY3UTljRmN1Mm50Q21WbTZuWTVKdGQ4VE1P?=
 =?utf-8?B?YjFIN0FvRkVqZXhqbzhwajVWdVVITHlNeEVXQ0laN0paMXdmbHNUZHZ3Rm1Q?=
 =?utf-8?Q?xdkeK0LkWTJ0hs+eqWDAJAOKSECLMnarcWIHex5G5ggSY?=
X-MS-Exchange-AntiSpam-MessageData-1: ZRFJ1WVk7ub6bQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4bd7e3-3969-4db7-1fe9-08df3e3c1421
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:06.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7bSQ0LPqkmv0kI1t5fTKWMYO/pz0xBTj/2VyPQWgMgT5qQHD77ZGYbuexqlLmiZGrMGNTRjmGxAv2tMpezbvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use `SizeConstants` for Alignment that are implemented now.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/io.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a877df11a03e..31c6975376bf 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -21,7 +21,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sizes::SizeConstants, //
 };
 
 #[cfg(CONFIG_HAS_IOMEM)]
@@ -154,7 +155,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
     const MIN_SIZE: usize = SIZE;
     // Alignment of 4 is the most common; different base types can be added once required.
-    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+    const MIN_ALIGN: Alignment = Alignment::SZ_4;
 
     #[inline(always)]
     fn size(p: *const Self) -> usize {

-- 
2.56.0

