Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0CC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB4510ECD6;
	Wed,  5 Aug 2026 05:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Skf4v/Ui";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561A210ECD3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8zfhiMy0LYK2ahGKWnHr0hLyQ0USnkQcQ0d6RifKMunh+SIL0Wzgfg+jAMHlibYwuE+nYMo8ucLdIGeMQKFnaoMJcNHoUyVseJo73XP6ScBFEGPGQKFTDq5UjVROO7c04dbGyaSplUwzMgOpyCrFYlS67xtLoWFjlgWarEUSz0Ila9pZBCAYYMJpsn1REuP+8L80C2vpP45pMrF+odfLyEcJPUfwfsYpQh+recoRQ73RZmUyAYTkR5x3LeXUljeiJ8abW+xNTzxrDBHIwDHlG3+M1I46UcCtOWvPrGvm51fB5WiJ3DiqjhSQCgAeCHHSt4z/7fdQiaekvx+pH92wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeYvP0W9/MvO9rOLD5uXlBozxZVNLLYh6aEyNB+1/Eg=;
 b=v6jaxcDmtF43dCku3a+wEjuSZmKqEPMRECxuPNUUowik3goaRjny/XG78MWNm77eh+EHVkPS0xeX7JOazcfALUVgVLDyvZYqLPoEl/654fqBTU0WnSDhSdfbd6nVu7lOaV9MT4LgOGi39PJiG5pKSwV9PKMwOq0pE4uQxHD+L3BDbrb/yHAYdQ+LOOHtgCqfNAOvQxohYtIuGK6bEjpayyLaJAngmFPFwRcoiN1pbMPtCkQ0cYlWxgUU6zuqJcBr/n+9HGM+X9eQr1eVQeXad09/uHvt2FOwX1wR8zkDTfBF+p1ZXJpdfr5pylpFldvSkQWJ5aszRfxxLGMhxKxMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeYvP0W9/MvO9rOLD5uXlBozxZVNLLYh6aEyNB+1/Eg=;
 b=Skf4v/UihSjYtHg/4io+ccbSteP/Smde/R+DHSALKYTUyv8nGKdykyTbNfnoyyAb9CD4wKDGiaKW8SfFf0miaY75a3nIgaeipklJgz+JlDbWIh9kSv54/ySdxf+XkG+rhzjYdci3x3deV1QW7DKgSHNQnZ4U7FUptAD/oPtsy6TghaOcN4y4hA6Yi36tMA7RJfhdceRb9owwVcEgfEnMhpTwhU8w2ihAZYCVpJhMI9MmXjiSmw3gYpaUElHKG032q7pwRW30uYrFZvuk9BUfCMtA8yWyj15LhrVJPOHsfxKcOkVcPM+psLT17ieyJDoJFZWgIWZHSjaI4tglhnjEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:18 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:18 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:49 +0900
Subject: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at build time
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f4a1fb-f2f8-4429-49a2-08def2b4bb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|6133799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: azl7ashO7bdLbXmw/f5TzJgQPwJeOMipLx0cclK0Jc71Owf8hjPzPZTXP6htu3e+TL4AGrfaERy76HcowDU81bGRkSJgPDLlfm9eexzCWW91FjGp1jG5y8SOT/lfXzex+sXlVSOimm0QxMzAJctQ3G0V2nfXwL0kPla46e5v1ZJqAbogAQ9SROpMm4QXP0a1PMCDF0/PgQJLl9dXIj7cPWJGW/Qn9374ExOFL3Z0aiT4uYF/wcc9suBC6kC9EGRwgISF6Hb3945PA6+XQrz5QTkXkacdSCTvXY++62o32SKjPLAFmY3gin/L6lqX16fc8z0UwXKj5ByVHoXtymNuWvCRLA44c71PDKTdgt34781q+XI0IXjOry4CnagLsH3wpKzk3XIXgrImjRp1Zg32po6q98TtnrcM9vVWWpHQusr74s7dLFFvtewufXesnWxNgnXzjeUkMXPmUhtg7Am8si5OSDqF/Rl8MFSJEexN2g9Joe2xKKOEMFhZ2tjWjfmshnVU3w7MlWmn5ONK/H1XlP/VKGXp+0VL4Z9sE6x6h+LjxKZ500EW7/Smxhj1WJ6HpAzy2jjD8ucqzcCMc2ONbkaCVeo0NypkifjMWpKd300JtO0/g3ecCZWS4B/RZQD9KUD7r01D3z/TfW/iTN+XqnhetAHX6j6Cw0/v+btsQr05fYphkQuaoZh9wXN2uNeLD4lhYVcpvFib1hjFpGb0gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBZakpPQy9rK2tzOGM2MCszODJrRGpSRncyOGVNS0EvaWZiQ09XSytWNkpR?=
 =?utf-8?B?Nk9VUitkRHJucWEwZmtVS05HSnJoS1lrODVEM0wzMGZiVDgwNDFySzhzc2hE?=
 =?utf-8?B?MVpkeVg2c1UrV1YzZkJLVWJMNzNKbG43QXdHWnVuaDA1VVFSUkRZTzcvTzlk?=
 =?utf-8?B?UWFmZGZRYUlrMUVTZnpnaktsV1JoRGV0TS9UbDZpUmxLTUJaVmFVaStoRDVM?=
 =?utf-8?B?RGdyVE9IUWxrLzhSZFBZWUs1OVJIcmdkRDZTYm1wRDBqaXk5aUcxcVdyMTlT?=
 =?utf-8?B?enJCbHJIeENGeHcrendiRVBRL0pnU0h3R0FocTQxeU4zU3RsYlJpai9IanA1?=
 =?utf-8?B?Q09XWGVPbU1yTXhaN0ZIcUpZdUhiK3BNeEZKS3JBd1JyUDh0eEg1c2JtWlph?=
 =?utf-8?B?cEhRUW1melBiRnArVWo5TVlJbWF4VEExK3oxaG1WV3R0aVZycW52TVUzcXBV?=
 =?utf-8?B?Z3FJS0pzVHRHZDhUc0pEQWFwVXdTbWtlbWVZNklMS3dWd25DNmpoem9NbnVU?=
 =?utf-8?B?NkJkYTUvMHg4RERGUU1pQlUrSHg2dkpOdzl4b2VtM1k3S29lLzZidkp1VjdC?=
 =?utf-8?B?aEVUbEt3UUVuc2J6OG94eDJSMXgveUF3VSswRGRvdWVCMnU5YWY5NE02YStr?=
 =?utf-8?B?ZHVBTDF1WENyOWZ2RlpoQXpNMlZyVnl5c1dRekR3N3dJQVdUbFFoSnZqaFU3?=
 =?utf-8?B?L3ZXclA3TWsxR290WDV6VnBNWmg2SlpRaVhSS09sL3JmZFBaZjhCUlg2bHUr?=
 =?utf-8?B?TnB3Z1E2ajF0azZIYThuaGxrU3lTSXk0RVBsQXZhN1lqUE1RckZmdU1lc2Rw?=
 =?utf-8?B?clE4bTFSdWFUK0U5d1EvM3hlbW1Yd2dZSXFHcW96U3pZRVZWbEpYY0VJNXly?=
 =?utf-8?B?VFl3SjdFcFNjZk1zaTJSTDkrTjZXbGo0aVMxUEJHU3VDS0FRcW1JSnhoTXRJ?=
 =?utf-8?B?REhyZTBuckRxSUVaSnhSK2ZWWk9XMVZCL045cDZEdW1DSmdpU3B1TUVOaTRa?=
 =?utf-8?B?THdwSFhhc05TZEhhUDZMT1JsTm4wMm4xV3Z4TkplZDBoTVVKL0xEcjRXSlpZ?=
 =?utf-8?B?U2VQWDREVjhHSk5ZWndvWmNRK092RlM0UTF5LzBka2FmQ1Q3RGJzZU9lZFlX?=
 =?utf-8?B?OU1iOVM0QVlFd1NXSS9SV2JSTThFak5GQnd1SUdYSEFkYUZiY3dDVjQ2RnN6?=
 =?utf-8?B?WlpsT0VKbnFmcG5ySFA1Z2xTRXg2WkIvOG5Ha2E2bGhZSThja2RKYTlqTVZR?=
 =?utf-8?B?OG1LRWYwKzFyVUVlaG9pR3hGMXVUNWNyNEwvZjRKdmp3Z2NpMm9xYXFHM2lL?=
 =?utf-8?B?S3VkMzNiQnRsdVJNZkdhc0txVlMrRkw0N2xtbzlaUlVtWEVpQ3IyTTZKNGJk?=
 =?utf-8?B?Z2swQ2t6OUlRNG1raGlWOXBMOW9zR1U3VncvQ3dpd3pFOC9QZlZtdk1OVk04?=
 =?utf-8?B?dW5Fd0x3SzRaRXF6aGpSNTVSMDRTN3JYRXZjeStHbHYvNGQySE9veE5JcDNh?=
 =?utf-8?B?NFVFa05qMmM2VlhlYVVtWSsxTnZyaFpad3p1TmdXdjhJODdRa3k4ckN5cmk3?=
 =?utf-8?B?ckVtNHBlWEp6OU1GancyWC9BZWVwOG1MMjlJZENObmVBNTJYcHAxOTEzeWYr?=
 =?utf-8?B?LzdIWmNyMUxSQzJYUlZsRlYxbTMxdGlvc0REZnI1cmRXdlpXd2hyWkZmZXQz?=
 =?utf-8?B?ME9oWHliUi9lK2NjaVdWNHRmWlB1TVFXMWVhdkh3bE1GT25TTWgvS1NtSFFN?=
 =?utf-8?B?TDlTd3VYZlAvZjR3cG5CZlZIN0owMkUyUDR1TXB2a21PK1hVUTczdXE1aVps?=
 =?utf-8?B?Wi8xU1FMSFRkMmMzT1NCNWd0RDQ4clBBME1xWitFaTFyVW5PYm04TkRlS3di?=
 =?utf-8?B?ZUZ2VFZiR1o2K2Q1eEZ0ODVsMjYrSmxRcENNTXF2aXlPeDNJTUVwMGx5L0NI?=
 =?utf-8?B?emRxSUZzelE2QVNqSWY0M0xqRVgxZVpPYm9PSmdzMi9NaU9WZ1ZySGNNMUdR?=
 =?utf-8?B?YVQvSGpsLzVNMzhkbDJ5WTdlU2xTc016cVVMVEY0c0c0NW5zczBMaGp2dFZG?=
 =?utf-8?B?eWhNU2J1T0dnN3VmOTRsZlM4SUl3eWxXRWN6K29kak9uVmlRTlgxc05pUlJo?=
 =?utf-8?B?OTJGNFU4YmVTSStQOXAzVGhZMFRXd2RkYk1UTkFqOSs2OFpzU2NGaFNOYkE3?=
 =?utf-8?B?djlNckJrMjh6Z3FReUdCbFZ0ZlVrMC9RUWRYQXBBeXc2dm5GdEdQaVd1ZkRD?=
 =?utf-8?B?ZVFBVHlKUk5OWUpOa1U1alY2RnhkNDZNeHFiSlVRREJHRWxuUWR5Unk3ZVZI?=
 =?utf-8?B?b1NUVzdWSThvTEU1Y0QwMDN6THNvUzdPSjJuS2t5OGFndWFUQ1lNUTNaZmxa?=
 =?utf-8?Q?/KP/ANZyYbNeR03gUui8GTbn8AhC2fi3470d30uRKhkjw?=
X-MS-Exchange-AntiSpam-MessageData-1: ACzJLz5JBbqx+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f4a1fb-f2f8-4429-49a2-08def2b4bb5b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:18.5517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqU0FvacZvDN6gdFRfgAGN5sKv2+n8bYql75JMgeKc3DqQ1T0s4SYCeg82FUUVtGt3etMGxmKg7i+FTUF0gfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Make `shr` reject shifts of at least the type's bit width at build
time, instead of panicking or masking the shift amount at runtime.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num/bounded.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index dafe77782d79..f263107f001e 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -485,6 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
     /// assert_eq!(v_shifted.get(), 0xff);
     /// ```
     pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
+        const { assert!(SHIFT < T::BITS) }
         const { assert!(RES + SHIFT >= N) }
 
         // SAFETY: We shift the value right by `SHIFT`, reducing the number of bits needed to

-- 
2.55.0

