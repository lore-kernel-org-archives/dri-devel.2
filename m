Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3560C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75310F312;
	Fri, 28 Aug 2026 09:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9bdY6Kc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425A710F312
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmxSlt6oTJt2FD0M4h/IM04HCi6e5YxQBjIcO6FZW9KmwQUiAL1KZ0+Zok7SlAC6bKzGNSI4PuJOC6Zh805AYK9/aUG9UtY7QG1Vp6fErXgj0JURhfYe+SPZhP22HeymlhN5inu01d4ZtnE6+vxxrynaX4fZE+kUyfbi88XF3K6cqiP2XyZ3162ybEn1mBYufTwqmKG7qMH23LhhJcTslNt9SrdZsV9LEXj2bZxGFxWRbnKoSoLWHRgfiBcEgp3pp5gaYl2Ow/UTmEQbr3tFZIXk622B1p6xoTTRob8wiDjsSpudx9S4MABKdfZKAo8xghPV6NxRJ9edYWvIC3DPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqkiUm6uxGVzouDoRMWCD5KlSPf5vU/QCbNSpKAMku4=;
 b=XkIiLwSp/surgZSY0Dk+e0kiR71RkIy8p869tIoKwhFONd40W8wD7JJ/zpsg570JAtsElI2D0XEXp5/ElLnsCz58mmCCaC3fSlxKBSNnaVdfQT3It7HzOK6aBbHhji6XPz+tTWbQAzvpTX/OQE6X/QhfBZ7z4s0aed56cjhqVGkv3cfms4pW60tNwjcXZJl7YBykIEcTr7M9zEOIco0+FLYogL8Z+QQTURG0/QQ2/yTFcHAS/0Dwq4rqa6RNt6xVhdflydcc8Zxv0Ko2MvOQXIeOqBnUxfgLnPK0HWTub6SBb92I3ko3+0BQ7K8GvZMqztYpha2UCzi5vVp34Xlk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqkiUm6uxGVzouDoRMWCD5KlSPf5vU/QCbNSpKAMku4=;
 b=D9bdY6KcR1FbaNPFgr96u6YcMy3t37isy/T5+G1zvfMfNWAxlqHeocenLa0ZVmvDymZKNEvDUrw8NJplBKMbABzssvS9qLjz2fd3V4IPbNtFoagF6dQa7vt7xCpTGJZSe/aCKZjq+QiSirYV0GNbwLQNS2E4G2TI4ShCfocu1QK9uNhrCBMtCFSIK6Bj1a13XAQukfgyPtok3vLP5sDI/wpwTgvC/Z9iQnRzuEnWdozoNnud/ptf0yxdx+D+QlIGarZJCii0kdnTnWivqtOmZJREnw6pAaVhZddj2jp15eT+C7gWCN+Fj4ACRX9zepyDfaPRzTbzB2IhY5URZuuikw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:16:47 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:16:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 28 Aug 2026 18:15:57 +0900
Subject: [PATCH 2/3] rust: prelude: add `num::cv`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-cv-v1-2-48a180dfc4c8@nvidia.com>
References: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
In-Reply-To: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PAYP264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9f4771-586b-45f9-b36e-08df04e515c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ru1VqYz1KS65kvB++UbKm3cI7R9yXrBEFmtq9T/t+oukJz66kfNK771V0XyhaN9nbfd7b78GEbq88N0P2yCIsJDAu7iCfkk0flZLnbezvTdM8puSDQkAuSQ570LmUmkBNk2Yso7fwiq7zIAgXOJeZnt73ijrRHwShgyS9gKjRmiBXD+xUJUK3OE8t9gvoEQy6acM368aCwhdrbtMlgjRxxAzMsFNQrSLUevQrD/o8vZq1Jl4uuby+m5bTfj5Bkszxe823TyqUkmeM0MVwF/IrQx/GCZWg4jTeNQ7W9XtpqeewFc8DWZrG7hqz4tZdXCGnf1Joskr1NEygubc9S3ueu61QHWDeEs6vCYNkiR8VTfNUkpaZBhs+fS62xoy3uYuIqb0UQwXJ9esr7KhjkC+3rVSQ65vh1aak9vCVoNJbsmeg6wvpAv6egqYLwlI1NGYAMz2pxOU4uRKydsNaEsBUD8CKJqozUTPc6V1XZvuC0zFKeyTFGcbZ5dVFi1D79PloeEX3lNVr/ssuCN3LGV/8YHL6apBmSgJz37XV+0kSatYdrYro2Ve/b32nhWhdzTBLrTs+4Kem9pXXEisfxjaJ/Gwjp3yxf1GUGwW2pxdAQEVJdjLS6MQsE+ADmDDWItEQzw5K22A2b5BF+E5a3jdqhymznc+HgxcWesRsYI3DrkKD3hB+CCX5P/Vf9fJVgETSV1e9sZNbly5qwSY+1DA3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bld0TUtTeGdLQVVRRk9sVUxhRkg4MGtSN09FaStBbHNDalN5aVphR2REUzh2?=
 =?utf-8?B?NS9jamFzbFZUTU5HMU5mY2NrSlZNcGZ1dS9ZNTBra2haNHNtWU9sTU9tZFRZ?=
 =?utf-8?B?aXZkaVlMd0JObWoybnJtYVJWNXlCTHQxT0s3K2QvcU43cHJQUGZPV2NtK3du?=
 =?utf-8?B?VlJadVg2UkFwU25rTHhZN1dZam1ndFVMZDFWWW93aHBONzRHUHhkSGNNend3?=
 =?utf-8?B?U1JpT1VvMmt5NWM4dTVVdWwzd3VnbXNQVnNWcWZxdjM5Y1RFNHZ1RmdVNmN2?=
 =?utf-8?B?MXg1M0RubWdKRS9RdzQyNGdTSWhlT0EvRG41MmdRM0pocHp2aWUzUExDUmhZ?=
 =?utf-8?B?dTJuOFZNSnM0cTV5SkpvUXhycFkySzdndjNHYVBUcVM0dWoyc3k3bTYwbysx?=
 =?utf-8?B?TEtBQytuaVlOanh1K0lZQ3g4bkU5TTduRitiWVVWeElFSWpCNlU2TkFOeHRo?=
 =?utf-8?B?cXllQTFCQ0k3NHluN3NBNkFOTzVKN1c2dldHTThPaHRKWFJ1L0RVWFRHbW9w?=
 =?utf-8?B?YllUWHExTGdlL2doMXB4QkRSbFUrazA5blpGTmNaQ3RjZGhHaTgxZTd3MlpB?=
 =?utf-8?B?alB4WjNMWXY5b1RFR2JTbDlDaGJyR25PaXZrUHR5eXlXeUtxNllvYTJrSkRh?=
 =?utf-8?B?djdUMjZBK3p1NnQ1Y3FCYjRGbkZLQ2FxSDZoSDNDUVhVTXozdnI2dnp0TWh3?=
 =?utf-8?B?N1NHVTBVS1k1TVhPNENaM3VENHlvUWsrdExnbGlHRENGaklvTlM0UFY4R3Jp?=
 =?utf-8?B?WG9CZ2NJT1hiQjhaSEY3QWxLTE5jeE4wTm9oRks5UlA3dC9ESFVXaGlpMFdM?=
 =?utf-8?B?emFZTm1iT2xwOFVJNEZidW5ZT1pVUmRjYzF5OUVUYjdyMVRhekNmN3dXL0Ra?=
 =?utf-8?B?TGJ3V3RLVXY0bjY3clkwN1VydnlrckFtQU90eDBqKzZuSk1FQlBrVTYvT21H?=
 =?utf-8?B?UndFYnByaHEyQlV6bUxXVVhtaHBDTEtrYnZMb2t0c1Ntbm0reG1XZkNwODZq?=
 =?utf-8?B?dHRLSGVLTWV6dlM5Z2taTWgrOFlRbnhtZStRMm5SL1gzeFAyK0VoNzhqZmx6?=
 =?utf-8?B?ZnpZL2pzS0tVVC8zVURVa3BkNWFkYkJnandSNEtPVGNrRmZJckxOTzdwVGxE?=
 =?utf-8?B?NkdlUmZ5T3h6dmVvZEdtQUJMUUNHNXV6TGYvaE1GUU9qZ216ZU9iTngrbnEr?=
 =?utf-8?B?K1p2dFhCeHhnckU5U1dMaDdpek5jWVBSSFNibTdzSmtHTlU3RWZtLzE3djd2?=
 =?utf-8?B?aGNnUnFCbi9kZFFjRG9WS2ZWUzIrR0VEZm1sWHp4ZHIwTFZVd3NSQkRaQU5u?=
 =?utf-8?B?eW5qUGpkQUxLU3Q1VzJOTkxUS2hjakxiQmswb1Q2TDBEVTk2MWtrM2h1V2tB?=
 =?utf-8?B?WWdGQ1N5dVJudVF4MkJYdVFTSHpIYkNHTGUyYjBhZGdKWUJjZW1BVUI0NDhP?=
 =?utf-8?B?dnpscGJTMXN6SkpjWnFJc1g1Y3hmdWRJSjBtSkdJWmQvay95MmJRMllFNVpS?=
 =?utf-8?B?S0FVVWVsNSttL1ZVUnpIRGZUNlJjL09QY1ZKMzVoMEhicXJQclZDVmtkd09N?=
 =?utf-8?B?dkpHd3ROUDN2aVg0L3FhYUE1eE1WbmNMc1gxMXkzRHBuU202UWpXRzR0TGtM?=
 =?utf-8?B?dXRvR3E2bWRMakNTcGhabFZ6T3hVUDNvclI3MkZzNmxYSmNPWW9ZSDJEaVVB?=
 =?utf-8?B?VGgyK29vZ0c3VkdmRnptT2hiUTZyQ2puWFdHaVo3aGN5cGFCWDc1MFIzK2Vq?=
 =?utf-8?B?dnFNYzhBeFlOL0hXODNOcTEwMXRtYUNISVZzTW1nN1ViWjdoWDdMVzJjSHh1?=
 =?utf-8?B?cHpZWWpNUzRkaFJheTFkeXFTZC96cTJyalJIcUhWbHFCdVYyTVpRRURIbS9k?=
 =?utf-8?B?RE1TKzRsdnFXV3ozbmZrdnZrY0tmZDhBa2dUR0ZSZ214SmpVdmZnYkdiSXd6?=
 =?utf-8?B?Lzl2VzBlcmh6K3YyZ1VNRHJIR0pDa2JuUjBmR1loTE5EUDBZclVkUTF3cjR3?=
 =?utf-8?B?ZTVWVGhJOUhHd2xReUgyR01GL3oyYVFxZkV2bCt3UWVnTTdGaGptSkdmTGJW?=
 =?utf-8?B?eEtvOVVvRmNhTkR1ZnZsbHBBVkg2cjFWdDRlR1Y0K2RqcUI5T1Nid1pTZlRv?=
 =?utf-8?B?T0Q5dEF0NGFkL0NvRzkrZjZDdWpOZjVtNE1pMFJrOTVTWDhCNzdtMWJsd2hG?=
 =?utf-8?B?Z05vOGtFSXV3NUp2UEpSV0gxb25mMzhmdmN3NVA3em1XYW9YM2YvUXVISmhN?=
 =?utf-8?B?TDVUUkhTZTQwSGlBQzJqT0dMcTBGWTBlenczak91K0hBVzNrbXpNZGNwa0c1?=
 =?utf-8?B?K3VhUGdLbmdsWkErZWorWUJFY0RoR0x5SWlQWEJCbzFQdHB6a3Q0RC80Smdn?=
 =?utf-8?Q?TRextKRIyzUdDAKp8TrYD6RUHhItzfRDCJPLwArXvTked?=
X-MS-Exchange-AntiSpam-MessageData-1: TMfRcvMs/Nbk4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f4771-586b-45f9-b36e-08df04e515c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:16:47.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZL2IKGqb8puqwLpylKiff8npKXOX72qDqxpRnQ6g+o8p94kEsT7r2P3DjsghtUZzFVtjzzmtvnBv1kNjn2H4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755
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

Add the `cv!` macro to the prelude so it doesn't need to be imported
explicitly to use it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs     | 1 -
 rust/kernel/prelude.rs | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index d9e4a089d128..6b9b84919941 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -20,7 +20,6 @@
 /// ```
 /// use core::num::NonZero;
 /// use kernel::num::Bounded;
-/// use kernel::num::cv;
 /// use kernel::ptr::Alignment;
 ///
 /// let v: NonZero<usize> = cv!(8);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca396f1f78a6..5facf8f7af90 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -106,6 +106,7 @@
         Result, //
     },
     init::InPlaceInit,
+    num::cv,
     pr_alert,
     pr_crit,
     pr_debug,

-- 
2.55.0

