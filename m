Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C544C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FAB10EECA;
	Thu, 27 Aug 2026 07:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMQrG646";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5A810EECA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4PSMRflsZNM1QMPe6KUnTWGDQFt4Q+BL9uh/0o76hBxhPMMVrUskuU/Dnd0cE6aghHq5T9B1rJbPX6/rte7fk/VCKGnamOSd18yE2Z4d2Hk3ACWDf/Uq8c2/kTDKhKC4EsQsFb/NL/4SCYnShdzqpwH5hHwDgpV3v8V0/td2t22nSfnd0dktVOt/Xsc9Fo6/Usaso3GbXa+hstgRl0TCjerqOMuNgLFn6wfUF2oKxdhtqJCqniA2X4VBI7jbEESp8ACrXrMmijgCcDMdl8OynUH31E5k0XYd8Q52bTCwgZuC3RxVo9o5bCvlLBGr4WkQUW7Y8dEoV6tgyAi4hqwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh1f+snMvFaEBAp4swQKZ+qqtQaeYWCJX2DekKP/CaA=;
 b=pwusYSVl7PCSWaH/Pa5PLh0emgklC/QxNylCD9CY2C2xmW0h9kcMNmB35I6u1CMx/9phubNM6znyDRuPEVgKdU1rumOrgmeEioJJP5ejpCa71vZKm/sAD41x5yMoTEOsItfHuy/ScgvfHpZmi3tAIQHYrk/p213svKs32WtM8VDn8B1fiqTKOjXC/Ed5yzMPO2igRQRXjxiR5GQup9WngLMLz4xbt0pe0eF/mYuQHUw5N8GNOx9ZWmIdEsEuclXNnru+8zAyJ11vbcjTP/vhNvlv4AHx7EDi1rklp0dA9HKJdnQRaZ2iuzlUysw46A1ImFnxZjl8HiYQ/1vuNSBVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh1f+snMvFaEBAp4swQKZ+qqtQaeYWCJX2DekKP/CaA=;
 b=VMQrG646KlyeIZSLOLtv6AgUwVgq+6fPw4p+B1RshXCUSZ6C85+2KULIr8VKVLfd0q7O50jfyXBOM78Q6z6WkPx1oTPk5UCqk6pYhqouP44ttdobvrov7aJHAkFSpqdNxRp/j91xyGeSEN9swZcC+5UbRguzoeT9WeXdjjyHYYDvGPEEhKqe71ahc6omX5Przz5Pl+gSPmsM/PyhoiQAd2K9Q66Zz32EUwevlhXXJJF/sgV/8jNsy3pLh2qJyHBpD8iHK4eePXPr/VdC2U8p/a7DjRXWMSxxZDWRxLBYmIYoeV8Sis6hpPaAQmPlLeZD5NgUt0riWBwkUQWRE41ZyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:32 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:32 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:32 +0900
Subject: [PATCH v8 04/12] rust: prelude: add `num::cv`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-4-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9cf56f-e12c-4360-0363-08df040d1353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: TV81AAPvUZ+qzRbfjpNkU5DqS5DuRmvYorjgjKc2k+k3VFxyxq93VRvgtenQP0G0EgO+ExCWLfNWwHdNkpaWE+QWhX0YIfU4Rr0jmNa7n4QoDnd/D2vjn16yT9zXyGRwS36z6EvISPtLhVY4PoSo0cYDWoTP8ILiyIcvWuuLwe5KEEr4OyRNavD6Z56FAUYHM1wBwtpMvsF9rtzvN5TLlbOZh0FzVQ+8qkQOMobOrhBIcaz6ignFPjPkr3Q+WF1jCzxFqTIou9mruaOimqYsSNUdOG14ompjPAtSQyYBC6fBoViMJqn4qIRmv2/0taC25QbsCadKbNSv29AvrSqR4ptn/Azdrah4OGQyUO6YWwMgkI+s/g/UDd4TLX+4qISGJT9V3Ew3+6EXiFKFRhy9Dt5/M+Aj9x7QWB0rdJbwc4Ji2o+YphPGBTTOwmwKczhjqHQOxYABLUOljo+D3BQTqPJyYdJIwWFtOHAskbsnpRGs0QKSA+4PMtV+uoHBeG42KBp1EUHyPXY5/HUgRrVPggwMDqgwBA2y6/DnJJqzxW8S2dadEK4MmsOT1ma2f4z0O7xRYxwrqh89tcmDyZif5l37UGLMlDyh9HXf8wbe3rL6Q3beIxXcXDJsZikPjrSf+Ju+sF/OJjNVFUFebxm0KuggBKNrCAfGYgUDynC53U8sca+Owx09oF9Y+K9l7c2Vby2/2DdH0w08UODmGM2Pfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWV1TGtidi82dFdvWHpRTG1WdEhEY01WVlhGY0J6WWN3ZlpHeHpUNmVaUXVQ?=
 =?utf-8?B?SFI2YnlteXdHcVVubmpVNnl0Uld6b1JEVkZNZ011VDFMYnhrQ2phVlN1NStQ?=
 =?utf-8?B?ZnhoMnFvWngyMlZvYlFucm95Q0hwRW5NNGRMakxyVEZTc0VTUm51dzQwVTRl?=
 =?utf-8?B?ZWRoMTVRbEo4NXFKczEzNmhjUnc0eXl5NWl1V2tkN3lQWlJGUGYxZUtwQ05a?=
 =?utf-8?B?eXZaYjFwS0dHYWh0S1FXMk9ocDRtL3g3RnhnTDZFL2pHbkhJcktPUU9MQzFr?=
 =?utf-8?B?SzV1Z3FyeFFCcWIxWlhMQTlvUFBuRVBGZFRtS2dzaVhXQ0l3di9YbVhhU25K?=
 =?utf-8?B?YTlmVlhLNWtUV0VjTUZFVnJnV1N0SlFtUmo2QlFGVHpQRmhuU0JRWXdqRzZZ?=
 =?utf-8?B?cDd4M2phOTlZQ0IwdWJyalU5aFBaSE0xaS9iOGRHVjI1ZVhxQy9IdWlmYTRT?=
 =?utf-8?B?YVdJZ3hXbVlTLzVHTE9PcG9zRkpYR0xPNHFMNlZvZUo1STZlQjdFKzZzUWhV?=
 =?utf-8?B?RkM4bHNhdnRwUGUwTlZoeW1iQkdXOHdGLzJhV0oxajJZcUdSQndUYWl2L2xU?=
 =?utf-8?B?dDluMmJ3K29SeS9IUWYwVTNWMTdoTzJuKys5SjE4c3RkUnhOOGFFRnB0bXNJ?=
 =?utf-8?B?NWFmcmhzdGxXMmlGODBIbWgyYjN1NkhlZGpqRzRjVmZMMFg2VGNvMGlEQWFW?=
 =?utf-8?B?c3JOVk1tMGNFdVIzZGUwRFZadC9JTjlHU0F0YVZOclVJMHdibjFVbGxIOUdw?=
 =?utf-8?B?eUZuMGxHa1Zrand4ZWJzalhna0M5U0QrMDVIWStWVnROZXBNd0RiQWFBRlc2?=
 =?utf-8?B?bFdxb3owUElEMGhwdG1LM0V0dEdlT25pYjZaMkxMZ29tc3FiNXhubUl0TnE5?=
 =?utf-8?B?dXJTekVzdFB2QnhDeWp6U045ZHR0RE1nTGlDcWI4dUxWSkxrd0FUZjFsdS8x?=
 =?utf-8?B?ODZlRGkxRlpscnkvV3ZKRGh4b1c5NjQ4SXJEdDE1UERMMkNBK294YlYyZVVW?=
 =?utf-8?B?bDNQa3YwMy9TZ1RqWGRLVHpKRlp2Q204NDRaQUxvM0FJVnUyOCthTGM0R2lK?=
 =?utf-8?B?N2lyOFVIR1FOTExkR1g2OHZUYWxaTGlBd2J2c1h3RzB4VDNHc2daZkh3L0lR?=
 =?utf-8?B?K2JzL0tXaVR2MUJ1amxjN1cxZml2OGVSU1pMbjhxMHJYdHozbnZ4VS90SzFY?=
 =?utf-8?B?MVErYUF4a3R4YzliUXNsc1A2eTJlZEM2QnZXUGtWcm5FajgyY285L3lrVWNT?=
 =?utf-8?B?RzRoU1BjUW5UYkxRU1dlWUJSbzdJTUpQb1lrb2pjdmhKdk5wand5QnVYZVhI?=
 =?utf-8?B?Q3B0U3hUMG5SdHBjYVgxYVlHRk0xMXFYbXRqeXM2Mmw0N01SaWhRM3FBSm9Y?=
 =?utf-8?B?eTdMN3BzVGQ0RzYyZWNvL29ITnJ3dUJQKzRieUtoK0MwMHNYZWhqSlRXTFRY?=
 =?utf-8?B?M2dyVFZudHQ2T2tkVHBLdm4xU1p1M01SRlNqU0hNZ0VHUTlvYUJSWnNJSjBj?=
 =?utf-8?B?eEVTcmY2ZlAvN0V5WElWMVB4eUtkMXdmWFZqTStVdmdtUGxuTFRIS0FzenBF?=
 =?utf-8?B?UzZ3WHdzNnlBYjAxWTliTlJMZ09Cc09qMVJyakFWaUpyeG5xdENRY2RLUzdN?=
 =?utf-8?B?N1RiclA2SElEeHFRRVIrNmRUdGtneWdvcVVRTEZxYmFYYTBrV2p6YVpKemNC?=
 =?utf-8?B?RXFPZnJGOEJzektKZE85K0x2NnpqUngvOEJ6SE1WL0FyemEvakZxcCtSbHRB?=
 =?utf-8?B?R25BQ2VTSWV2QkdnT2JWYWhhSnR0T1VEQ243Rk5HVXVCb3FaTFh5M2V6M1h6?=
 =?utf-8?B?NVRtdzAwV0FTMWM5Q3lhNXdsVVlSN0ZQNVFFN3JOMGorYjFNQkFxdUN1K2VN?=
 =?utf-8?B?MTQva1VIM2F1MFg0VGFVdW10T0NzNnZIQ3E4akhCU3dnRWlwYlFCeDAra3N6?=
 =?utf-8?B?TDRhN1dPdk5oMUphKzN3QVZHd25SZTVVS0hCdElDKzhNL084bUp3UEdCRFJG?=
 =?utf-8?B?Y3hqdGVFMzQrVWZnTi8xL2lvS051RWF5UXVVWnEzQm9QUS83UHRQOTVRZzlG?=
 =?utf-8?B?Z0tXMWIwcjhlbGo2U1B1WXhqRE1YMXdHUDJCeExQN2xIMjJNNFZMVXBQOXlu?=
 =?utf-8?B?L2JjT3RSMEt6OFJMbFJqN0VBMlpVQ2Y5VnZwUDgxRzlsWEdKeWlTb0tOQ3hR?=
 =?utf-8?B?OVNldWFJZE1wRkd2L0pTUjJCcExWS2JWclBQWUhVY0doNXRxT0Mrd05MQU1D?=
 =?utf-8?B?d3J0Q0djSHo3Kzl2eHVNWlcrNFVxZThNS2kyQWRRN0l6TjBKeE92a3E5OHF5?=
 =?utf-8?B?eVRCdG4xTGR3YjJuZjBpYXA2VlVRVk05TDhkbXBEZURWZEFvQnZWWEduZUV6?=
 =?utf-8?Q?3JmCRBTzUikNfK2kJQSZxy6BRLFwH+/NR0Eef241cVDlA?=
X-MS-Exchange-AntiSpam-MessageData-1: 3ixKWMSawn313g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9cf56f-e12c-4360-0363-08df040d1353
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:32.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJZPXMgRc0oEOw2rU+dcUm4zJIC3eyIm1mw62+KCegK9j4UGrMY9+GBLyagpm17LCs9hkKqOMiJXkrTKQWVHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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
index 29bf903a4a74..a20b8937d4b5 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -18,7 +18,6 @@
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

