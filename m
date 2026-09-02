Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA2EC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5128210F0C3;
	Wed,  2 Sep 2026 09:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6i5QnA2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4FE10F0C3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHWI0jNcD3BHY933s/QNE4xLzIN+WRHAAjwNRrg1YQ8KFqv5C93piCH5z4nLXJEg6XAYoGY9wPI+zszwy4CuiY3uMksIE3MUxI3lII0NeN4O4+EmFDEsusggyDyInAGDd2NpWYg9bUtNDt/ApZh0Zpy4HHW0Pqvh9DSxvKi9MdJGnVG9ajUKIIMUGr/NaG8THgluGLA6Jfp0QAzcRwQ8yQk47sV0Y3vEu4T2ijK0mWeUmtld4uS3aWtxh0p9apcHUEIYgMMr/uykZBS8rpuQLCpDo8N1hAp+DqD2LxlYSlQjhI6qnlphC60DfaOyhXoP5IJGMg0/AFMCEliZyOp3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaKRd3EWTTSVC1DRyAsw6o7D2mWSxccHnR09kX80NQ4=;
 b=bNClqGE6WgbLhutT/l+Lm+NMWF/LLtGifPQWYG92dUp6Quez64NS3uYao7We+TpEVstxllMAfGT3Ly8xBFmbqX5LKqvGLzRo9bgQkh2DHdtpcBYrhTXY9VSsJdp1ZCdrx31PQ7j9nihmFX+pivIBkmt6yl5Q0L3sqf5RBvqttaEX+VXc6CSdKeQpXbBmAzPZrwHxqU9sE9BC4lt0j7i31nqPTR5qP8Sr+Au6mgvyU15F5XncP/Q/hGBbfTJ4h556fkNO1jRKS07Uz36YNjyGkNIiLYtv7busGD3Dj7LyDHlqlBSiixr6Zz0pU6WrBq307RtnI0YZlOsR86GDdgYfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaKRd3EWTTSVC1DRyAsw6o7D2mWSxccHnR09kX80NQ4=;
 b=S6i5QnA2tzRCq6GOXxAK7DSXPGzkz30gtEs7uhrdIzMF9ji1A6HjI4FyS11DjIvJkJNSsbowXGoaTg2BHUn+xJO/6h3qVWfeKAyQ38ZRdVt/GUIlDQG9qJZ5Um+SNe69rc1Uvi9nrQ7pJmSi+/VtPWLscXuNVP3yoEEHn/pxWcHVWv9dCZclR+ef+yUT+jF5PksGgSQXilDAciIn0tgqFH+6VvRdnqvx0FXYsE4ERCyQ0RuJNkZmcP1fby7pfevHWDNHf3wIPs1S86jnmv1zPtvmymYGLuxGWFygBwU/AiLQORlzXIUExmEJUMxBId0sAT74PqhiVzHf+IK0IhitUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 09:17:08 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:17:08 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 02 Sep 2026 18:16:41 +0900
Subject: [PATCH v3 2/3] rust: prelude: add `num::cv`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-cv-v3-2-0f90659e711d@nvidia.com>
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 483183a0-a97c-4187-23ab-08df08d2f65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|921020|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Axt1K6qHWw49L8izoG37Fi8gW9GxupENTfbbxKZrkTQtnz93e4bdNK+3k/hv3lol/lX6qM6nNoKiFxouAhN8fyDvDATj/DlHlbB9s8iQ0tnA5f4kE3DZlkyfKNrYWcdmX8h02W+uwVylc40vseV9D7susFXR52huZ8dVEDijZricQGa0BbZdNYpcHfXr+jNYmYIb5MIsOpKiefLlARcHOzLEtj3w8tcSGFlYcfQsD/f2R0sxrvAS1uJS5YzNZK5r5Zw4dT2F54s6sviYiXjW+MgJM2RVCu4V4/ghxvLV5Haou1jeP6/wsudGdWip006QgheWscJcpX+sDUoNd3mKmut9ifOpln9ZRaLfau80kfiw2EnUHqNqeciTtamrFSWQybAKEv2rW95u/YdSeFX3m+2zYHXVqnmG5Jan/0NGCsk2bNEjltEBMvK64PUHihB00h4RqMUvrEhikCaVEir9/dWv2RwKbHcb8doC7OPCcIIbidknmH+bWQwciQ0dcB3AL9UHKeQpPqodeyWEgfoIKdX0F4fJ5H3YEEqLurB2wyUCnMTaXG1cq/HRgGgHIKt0QGDxXwqg5PolrRt5x8v6BAmpf8dNLhrq9PlEp2EyeYGIU12wrvcH1kwgigTxD7QFbjWx7bFdRAR/KHjndOWaqLtb0NPuOOt4TMcZg7u7g9FL4wOoVCnBsczX6cqfIDcQlXGGXZKfj4WqSFQBzHQrEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(921020)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NiaXZocFhYRmlaMnZvZktPRHRucmJYcmJUYjAzK1hscm83bFFXbDN2bkN4?=
 =?utf-8?B?SXJ6UXZGNk5wVzJFeHBMVzlHaW8yWllOdDAzcnU5MDhDVjRaY2JRdFpzUGhs?=
 =?utf-8?B?K2VnTVQ0amJZdk4vODFCOWdOa3FFc2lwRUVoeTFmUnRuVjJOenZUd1Q0bXRT?=
 =?utf-8?B?OEYyUGwyUUxLKytQa3grYW8wSWdkVmt3QnI3WFdnektLOXRUOFhHWFA0NUxO?=
 =?utf-8?B?N1VWSDlzWmxTb2JzdnhlakJvelp6UTM5dUtkekx1dmc4S3dpQzRpbm9rVXJi?=
 =?utf-8?B?QVBoK0RWT2NsdWhsL1JqV2xLWXdZRk5VcG1hTkJKRVVGeXNVLzh5MjNFRHRx?=
 =?utf-8?B?dUk0R0l2YVMvN0VtL2lnWUtveVJOaldrNmtCQ20xeVlmTExFS3M1cy9OY0cv?=
 =?utf-8?B?SkhobnhlTE9IajhaL1FWTm84SDVaYXBlTVRhU1QzSjFuQXFMcjJPSU1EVVdK?=
 =?utf-8?B?KzB2ZWxEMWYzRWZHTUxwZ1lGZlVsamNIelZ2VzJsdTBQaTVlUzl1YXNHblFw?=
 =?utf-8?B?alNQd0tpc1JseUd6TzFuMC82N2M4d282cGN6RGJKZlpuaHMyYkdLc3FYZmdD?=
 =?utf-8?B?WTZKZzhxNldyMWJiQTVwSXoxRHlpaUt3Vit5NFd2TmxMTVl2K0V2b3VxTk9r?=
 =?utf-8?B?Z05Rb3ppcU40ZXNGeTQrak9sYWJYc3prS2NQa0UxMUQrMkk4M2xqcjRxNks4?=
 =?utf-8?B?MXl5bHFDSmRqVFNUQWVMVkgyck40K0hkU3lZVkhOS2tRaGNPMENVM21QRVAw?=
 =?utf-8?B?NHRhc1hxaE53eEo5UnNmeCtUWjc1RERvaVZ6K0xsRXd3K2g2Y2hQbUcrVmFC?=
 =?utf-8?B?Y1hOeVcrYXdvTWNWWGZmb0tDaEMvRXlJZ0ZpOGM1MzlTbW05d1NtMkNDc0NO?=
 =?utf-8?B?MkVBcWN1WG5wVXd4OVE0czQ0bXB5VUhMVlFKaTU2NHFJZ0FyYUtGM1RRNXR2?=
 =?utf-8?B?bFNYMWUrYjRjSitWZExCUVU5QXJqTGdEVE1seXRIa0hFZnFhZWhMMjdiaXp4?=
 =?utf-8?B?Z0tHbGdFNW0vcEU1Y1Q3NjZkS0pCVkdaMjVMd3dRYzlCWXNldWxLY3I2QzB4?=
 =?utf-8?B?UHhGbVZ2akVpTGh6bnlJRG9wekprZ29DK1NvSVRZbDVKSVBkLzB6VkpvbzNy?=
 =?utf-8?B?TTE2eWVZYW5raWp2MzRvaXNjT29CenhCRFNUa1hQVXlCNjI4TmliNVU4R3Fm?=
 =?utf-8?B?T013TkFndUhXQk5IbElzOWxnZkphaDROY0hKM2svQnI5R2tuYU5IT2xnZGFS?=
 =?utf-8?B?czhvL2RyWTBUakY4aFNUdTBMczdYdU8xeTYwNlA3dDRhYXFGZUE3OE40bUJ6?=
 =?utf-8?B?L3JIYWxnWUNRMWFvRDZDLzN4Ty9MeGEyUTVZa0pwNXBjMHJramErQkJYcTdB?=
 =?utf-8?B?RDN6dll6WjdYZEkrbTFWM0o2Y0s1bVp1S0hxMXBxNWVjdXRyS21kWVFOVWxV?=
 =?utf-8?B?anBFQXVscDdtbWRlM00yZUMwVWxsSi96dE1IY2VMd3FhUkJmeFRGRURTV0wy?=
 =?utf-8?B?R2tSMEdzc3RXMUxSRXNhTjk4TXEyNk1xOVY2RkZESmV6bUFtQUxqOThIc3FF?=
 =?utf-8?B?eHIwRWN3amIyaFA4TUdSd2lMKzZiL21sVUlMK2hlRmR0T0EwbnM2U2I3RjFO?=
 =?utf-8?B?Ri9xNHNSS2ZLeE9CZDNjQWw5YmgxWk9LQmpOcFB0T1VYa2l0YXhqMVpyQlo3?=
 =?utf-8?B?ZFhFVms0cml2S0I2cXRYZ1d4R0ViWUd4RmFvY0VnRnJTa3VoMHpUcXh5L0xk?=
 =?utf-8?B?ekdyTWpPYkJmWWNTeHp1UEFHVVgyYWN5R1FTa3BuMEN5REJ6S0oyOUg5S1Q4?=
 =?utf-8?B?K0ZKVEtWWVIwb3N0SldZZ1F4TTRnU1phcG1xRXprRzBFSTd2dWdTU3dWczlr?=
 =?utf-8?B?bUwxV0FMZ2F5RnBtNlFUeVBvVWxzOHhhVVhvK3pwMzI2SVZlYVRNUWE2T3lU?=
 =?utf-8?B?YjB1TlBWT0VlTFVzZ0svZlhrbDdDV3Jqa1lRc1RrOWR5SzFib3lLaWUwMXZF?=
 =?utf-8?B?QXAxUXd3SXFHb0ROWDZ4b2lJUFpoYk5wcGViMEVGcW03a0dmRnBMQTk4ZGpB?=
 =?utf-8?B?bGZuUzhsMTdqenJoYUYzRXlZbFA5WmNmejJvR1BnMjFVcWN6M3RHcjZzajJG?=
 =?utf-8?B?NVVjK050b285OEV4eWowQTVnQXYvUll4dFJJRDZBNzFCd3pyUFcrNnRMdVN3?=
 =?utf-8?B?ZWZwaU1lc3hjR1pMNjR2dzZ2VDJhRlFOaVVzWkFlVExEUXQrL1hDekdqbVFj?=
 =?utf-8?B?YU5PWTQvcnc0NXpuYjJoV29ncGJoNjhFMlFaTzdTa1hObkg0TjQ2QnZJdnFF?=
 =?utf-8?B?MXhYWWhKUHdjNG5xVUk3N1E2VC80R0grS1RPUEJBWks0eFg4SFAxV0wwSVdk?=
 =?utf-8?Q?R1LWa9THi8V7RkFjB+3p8vVgw94Hx5q2AJA2bkpMDmGP+?=
X-MS-Exchange-AntiSpam-MessageData-1: 1PN55sje6hqHow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483183a0-a97c-4187-23ab-08df08d2f65d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:17:08.0378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKaYuPGsqlxmbI9vlK5SRMqELDGHoj1GmXKPEdgX9kuJPSJJj83OSW614LL0vsYwJ3/L+UDcPh6vjQyPQO2FMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs     | 1 -
 rust/kernel/prelude.rs | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 9435459376a4..08862fe6ceee 100644
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

