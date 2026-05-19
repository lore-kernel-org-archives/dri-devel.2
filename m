Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0C4CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3FB10E200;
	Tue, 19 May 2026 12:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="STu4KbSw";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021125.outbound.protection.outlook.com [52.101.95.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605F810E200
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE4nFRlFmkS1PeKbr0vvWw8yr6H63v0u55DEHKc/uLRD880Dw8mzpGtgqB2DtXL/6KXutWhnqIU+s0zp5Cvz+kC1n6ish67r6DVoKPs4KSuT/8aDlNx81NsWUEHvzvMUGB+AMvPTTElxKS6gT87BB8U5FPDL+W3M5Ow4JJiPouRjN7UT6tmQwVAjOJr98bOCYhbBAWf610XJP1p0h1PgA1EB6dQS1SLe9fS8d73WgNYy7y6vD8mCf2R3NnD8KjeVhRaU+Ib+YLNkuplcZvEjidUGNzhfhKdgLM1x8dSFEVNu4mpy8PsKL5pG6utixj8MnEVTdMbbIeBrQW4xSUkgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v3scrHqt+7BD+61A0PCIirNBweCGdgCrsFW0be6/68=;
 b=LWin/zpIT3bUBMIsWR0AUdc+WCETune0gF/EQcQkm3tKRp5slIosu6kliwUnPaeewRpeET+zyvYsxhSy6RKVEkBFsi6v0DqLMEu5LUASb9JEkNVjo0OuKOL5EiXM+5j+hzAn0HuRP6A03Ov61uZkQXw9C3AItmyxNzlOdPU02pNDFDwMzzVyscpWrrivVWXP+32cU+X/X1I1bAIWj/vcbq318ZhZN7EG1Lzi0TfE5ty2d34ZhczefmLKBaCFOw1djcj61b5qgKWGjKmSLhFpkKE6EMCRLAY7kLHUgngrYX5okbckoUhHyY/SeqK4+ME+LAaBiSK9AWr6JuOVzis59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v3scrHqt+7BD+61A0PCIirNBweCGdgCrsFW0be6/68=;
 b=STu4KbSwAcifZJuWV6u/tvMtjfSXmJ1Sj5pJMKhG6WH0/IVuJ40uQjJ5Bt0+Z8PQLFIS7HJ9ChrAszV6RMtZofITYv6HTtobvYHIfvGiSSJ6tBjRH/n28qaqty7xIo7LOWznNqkk9lHmQtPRSzgeNXb7xU8otBrm2IdtcCuLAD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3428.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:47:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 12:47:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:47:22 +0100
Message-Id: <DIMNXMXQ6DOA.3NVFSC6PETIGB@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 03/27] rust: driver: decouple driver private data
 from driver type
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-4-dakr@kernel.org>
 <DIL0WRS36ZL2.2CT5UNXVH8VKE@kernel.org>
In-Reply-To: <DIL0WRS36ZL2.2CT5UNXVH8VKE@kernel.org>
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3428:EE_
X-MS-Office365-Filtering-Correlation-Id: 597c12e7-6e2f-4fb7-0689-08deb5a4c5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: meT9lxJTATfMRP5Z9roTtRvZb9UdAFDjKvV0GXiVsn7b5i8AtGs2yXptJFjgQzGzMFtSoXchBghHVgJKjnG4lwKOqRnGDnNLMnbWJI2/sAQuy9KCrjXMheioSQHk1UqDTuiv7Z/uciEZawI7B8JNghSy5pU+oPS/iNtsBtzds3U6MsYC7unTgEU9GZTWnilxj/dZQQSqU1bteUvU5wqAWM/qUy99ajCeMQ2HuvAelhTdHySnDUh4q/9/4ug34W0jtMdMpxPvy/n03zkxbcdUloxaGy2Q12d3KS97TKxYXc1o0EGTr60kz7LgqNEPSp79qE6LRW7+DSYjFD6ckCzAcejX7aOUfAZC27T3fnIx0dLH3/35B93BmIN2IpWGdaa45XGj+Xau9LMe0r6p1jGiGr3eymsnBMlPHvSjLJmD27eaZUzMp1ERr6IMzu0T6Qm0Un06DZzEd5L4qN5vgek4YAwR9EFrvo23yFBNJ3lGzcs6Ka3GtBcO2zHo1KR4tApcpnTNbAyvuYzUDahQf6mYZfV97BoVIIRzKdOPx2Ew8ymyCFrDUyHrlkr8ZJZP3GCztpWUHj/TjaZduStBebT1vADHyVV2bTUO98vbXhvWG+utfwadScHk5RJap18zSEOZYT1tzhTgaA6JUlIl1eUfJZ8vCQiZlkwRrLByOLPUna0cD+0KF9txPX61Vx6WscYRXeXWuC5L1TfvWjAWxXnX0VEmiXyjEccSdhzfYzcNzQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JZd0l6dG5Cdit5RGE4blNVY0NEMHdFYitvNXJic05GSVBscmNNck1rWXFP?=
 =?utf-8?B?Mm52L1QxY1g1L3dvYlgycy9xeWQrZk13NHQxOWExbHdNUXlIS0RIVStUVXE1?=
 =?utf-8?B?Y3BGQi9xd1BKT3JkNktHWXZJR0R2OFRCcE1GVjBJUGI2aGJ0QTBsVDE4N0xr?=
 =?utf-8?B?UXpnTU5LYVRPbXQ2ZVRvUEs3cG5YaHhyUENNQVhML3hzNUdISlZUVGJWekpO?=
 =?utf-8?B?MnUySjBrL0VTNEZqYUtBZEJDVWNqSW5wYTdaT0NiaGR2VUtTT3VOMEp5TUY5?=
 =?utf-8?B?bEtXSlVDY3cxbWdOZXEyVHVPZlM4bzQvSkJsLzJzRnd3ZWFXMUVqMk41R01x?=
 =?utf-8?B?KzNoQnhHeE1Qbkl4ektUbGdNUmZRQytBdU43OUEyZEI0YjM3SUNYM0p1TUQ4?=
 =?utf-8?B?cjJUb1RNUVlXeitkbExxZ3NEb1Y1bitBUUhxZ1EvYlJuNytUOXVoK2lnR09u?=
 =?utf-8?B?UWhpeC9oMTk2YnQ5azUvbTBoY3paenJ6UTg4c0VGSnZKbkRaTkw4N1llaDY4?=
 =?utf-8?B?TU4yTTU5RUFyRFZGYzdBd290bWl0cldGQUFFeG9MMTNzOExKQk9OOEJZaElq?=
 =?utf-8?B?ZXdVdk5LQ2ExV213NEM5Z2NXblNLTWJXVStEdjNaQUYvTzdtcW5JeEFxNlBO?=
 =?utf-8?B?NWgvTjVldjlqOTFkcFZUWTBZQkE1MGxCdS9HUVN4c0VPcVZ2eWpoZnY5aGpi?=
 =?utf-8?B?WFB5eVFIalFsY0lrTzBjQ09BQ2ZCc2k1cHZ0aG5GVFg2ZHpjbUdidHV3YWF1?=
 =?utf-8?B?QnpSZVpBRVBxZ25xMmF2M1lWNjlVTVhWRkllSFlVWVlTVDNsU1NSci9TVEpQ?=
 =?utf-8?B?Rk5GZ3JDajBseG5lNE9HWlIybkNIK0JWWGxidnJaTC9kZXNXQWMrdUpvWUhr?=
 =?utf-8?B?UmdFSFBqR1JDcUVKNFZEclZlY3JTcGxCNjBiNjVhQmtrREY2RjVPcnZDdkF6?=
 =?utf-8?B?dUhzWVYwNVFhYllQT3ZmcnUycGN6bXFxbWZFd3Z4UlpZbUpTVnF1eTZ2Qmp0?=
 =?utf-8?B?RGRGUlNkclYxdmhXd2tLZ3FZZXQzajhrVzZoQVdpN0FhRTd0bklvVHI3Q05p?=
 =?utf-8?B?UlFMVy93bW0zWnpGVS9rbjAvUW8xaElVUWJ4bk0yVndUMXNrN01uRitxNkFD?=
 =?utf-8?B?cTQ3R1pGZmJ6SUJ6NE5OWFR0RXVIcE5jZFk0ODQ1WG1iYU5UQ2FPVXZUVEhU?=
 =?utf-8?B?cEYxdEJHMTZzRTBYK0tsdWdPUlhPOVZSMmg4eVA1aldnNzd0aTB1amlmdFov?=
 =?utf-8?B?SUxPbVlZVUhNb2xDb2w0azl0cGRGMjdXNWhOb0tBK01ZczFGTWlxbGVrQ0FW?=
 =?utf-8?B?eTlFM1lEL1JETWd2YWYxaFllUnhVQThlcDRkR0xuVFdzb3hFaFpnajBrRU1P?=
 =?utf-8?B?MVRpRkdVd2JPVHlhWnZudjFIdTAvY2VPa2EwNnAveXVCZGZUK05FVy9abHFG?=
 =?utf-8?B?VTgxRzV3S2wxbVIxTGtHaHpRb05mYWp6NUdJcTRISjZrVFc1ekcrRjBkMHd5?=
 =?utf-8?B?WEFhRi96TndGWjNwTXhsU3dTR2M2TUVFVWlRQ0VTZlViNkVHTE1xUnF2WDBj?=
 =?utf-8?B?WC9lTjFHQU8xVHp4d1BwWi9kUG54dUpzdmRCWXB1dmIrbE1nUTVrVnAyZXRj?=
 =?utf-8?B?R3dIOHQxMFlCellVVzlOWWg1akhWWmtDV1oyU2dLZWZjckFNMTB2R0tLOFVU?=
 =?utf-8?B?WFphK0lnR3BlcFZRR0t6QnZQK2Q0UGsrTDM1M1RJc3pHUWhqa1pObDAwcXQw?=
 =?utf-8?B?VGlwUVZQbGRRY3Y0dU9wKzZkeXlmR1ZFM0pEWU9PaDU1ZC9mbmNLRHlyTDJw?=
 =?utf-8?B?L3l3L2kvZE04NTJEWkZ5d09jdS9hajVUL0UrRWQxWFdrRURWc2EzTk5nTlBX?=
 =?utf-8?B?S1NEZFNGTVo4OEgrNjJzamlLRTJSbFRzWGE4TXJnYTh2akhNRFVibi9BUFVD?=
 =?utf-8?B?clZ1bDl4ZURiRkJGdGNFelMrdmsyNVl6QVJUbm5xZkJkLzY5NDFzczV6dHFS?=
 =?utf-8?B?V3p2elRVcWZUNnNLWTRWbTJUbWd1eS9NWVlNbTNOeXZocUdNNGNSeUtDMjY1?=
 =?utf-8?B?MlI4ZDE4TkNieHU1SDVsalI5ejRPZERaRG8zNGU2VkhmMllXRVZ6Z2ZTWHVm?=
 =?utf-8?B?QnNUZ2lxUE4xMzlxT3pBNk93TnlxWXQxL2hKYTc4S1FnZDFzYS9yM3FJUG1W?=
 =?utf-8?B?WGtDRVI3NXZYZGRnUnB6anV5dG4rN0ozbDllQjgyblV4QldPK2dsYjNXL0lK?=
 =?utf-8?B?ZmZ2Q3hzSWlZSGdIUlk1VHdUejJVTEZaMTRTNFIyS0xKQWh4R3NuRkJ6b0dx?=
 =?utf-8?B?ZkkwTm4xcFBIM2hVeWkyb05BRkE2Z21zd1NuMExNc2lYL1NUajhyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c12e7-6e2f-4fb7-0689-08deb5a4c5af
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:47:23.0220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJlVavUzZYzp5Sr3C++CjnJslib4Gu0CxMAqUPmoPHTdYwn35vKM9G26MqBKjx4Xmsgsrzkyzb5GhV6Cu8zFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3428
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

On Sun May 17, 2026 at 3:32 PM BST, Danilo Krummrich wrote:
> On Sun May 17, 2026 at 2:00 AM CEST, Danilo Krummrich wrote:
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > index 586091cfa45c..3506b4e8bff9 100644
> > --- a/rust/kernel/driver.rs
> > +++ b/rust/kernel/driver.rs
> > @@ -17,6 +17,9 @@
> >  //!     /// The type holding information about each device ID supporte=
d by the driver.
> >  //!     type IdInfo: 'static;
> >  //!
> > +//!     /// The type of the driver's bus device private data.
> > +//!     type Data;
>=20
> Should be:
>=20
> @@ -13,10 +13,13 @@
>  //! The main driver interface is defined by a bus specific driver trait.=
 For instance:
>  //!
>  //! ```ignore
> -//! pub trait Driver: Send {
> +//! pub trait Driver {
>  //!     /// The type holding information about each device ID supported =
by the driver.
>  //!     type IdInfo: 'static;
>  //!
> +//!     /// The type of the driver's bus device private data.
> +//!     type Data: Send;
>=20

Reviewed-by: Gary Guo <gary@garyguo.net>

With this fix applied.

Best,
Gary
