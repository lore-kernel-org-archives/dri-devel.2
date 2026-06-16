Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05B9CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AECD89233;
	Tue, 16 Jun 2026 14:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="CVkGwtK4";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022109.outbound.protection.outlook.com [52.101.101.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D713289233
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxcJwq21BirVd7G5YRdIVSbjxPFjSm4s7YWDLA2D8/i7V7h9DXJwELoNlZNzE1lkV0IBNxvW7mAlH7Q5B8PUDcRISpXOfoTJxlMSi++Oz0enGHdieazVQcPTe6xWsM7SCACruhkynJTLvV/3Te0x7po479t3LciX74T1jmLKv8/g0Cs8C7hDy+eP9/mPhpW2ATSTQdJzxg6tFy8P90BC4r+hyTwR+xhmXje+pDQnNv2DHEt2YW22IQ6Aw0TniZdjCDqkgnKcm7TrA2RWagmjTltOoL2XlUhbIfJrVC3N7fVFriutIs3DnI1OXZbMO27RtO4YDM6t7hVIi++DzJrnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgLQVMpE4bxB6sG+FG70Z41+5HhQxlT1eZd8SgM0C3c=;
 b=SbCZD4c1nSZEDj2WsYke0vHPBdZvl2k8YJJ+U94f9h+7xpuFDLqtXIMT/5AIPf/vwaRxgtMIEAi1Nfn/fJCzW8ng09pKsjHBjD2+Eyp6QB4y/3diDtiiFbpYYRmpeN502I7eVKRqQ1RG9jDegrVCAtBRdDbQN4pWOWd9l7ieVGJAfGITWJLbNXEACf86mMHe0xoi+qlpZxxV4z5qGg1KTyhprkvV+VwZyKcD1CeJqgaAt8gCLZeHKvatEZhBq79Y7xy+37PH4GbhDCjOH61KB5X5MrZXXKlkCD8Xaj5dbQPQdK6m2dm+Cv3S6ZDWvQbpM3mTt9wV5RA8YkQ5pwdPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgLQVMpE4bxB6sG+FG70Z41+5HhQxlT1eZd8SgM0C3c=;
 b=CVkGwtK4ZeU5s1PENa7Ui+9tWg6OsLtzm+tbj/0dRyQ4pjfpwlaDEQGKIcIXapg/3jZpqMIW+amnGcDC+H8LTlOsIDhkljm/wlNQ0dTFWUHQx0pTzHUZ0kcmsTa5PxiBw6LiMcEyza0eMrmhvy2aFSJpUcdA6xF93zYdFEyQJY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6355.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:50:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:50:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 15:50:38 +0100
Message-Id: <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
In-Reply-To: <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4eddc5-3c08-43a9-5c28-08decbb6a1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|6133799003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A/0U7gnsrNgb1WsOm+4jBT6jleBpBdTfmeUscf4R8Y6eZMogDcF5buZvsngaIJQWxJ4XlRPjdgsuPI/gNJ8M4JQDoS1ghNtGFvnmG3hH3wIM5Hit4A087YKy5UhJHmL+ElCUm0v40UWwaKe0N7lP8YEnezXMYZnF8RdoS42thXxl/PKIfv973YoQ5Xugpp9N4q06W9lxj7IxIZvFlmPi3Np8r3MRgGgMVguiFHif2+vVytkS5YE7veh1GYrPjBOx84uCCgOuXdC1jwZCVa9aWjLWmd3FxJKtIL7CSj9/XFklTG59L25jpI1CjKhEjMFub95yHeYevFxiVr3P2y4w2blM9vexL19S7vmyMx6eOconm6TrMN1D8hxdkUnCaFF+vWCFeQzPU+F+YKwjoz8h2tNZhzLT5k1hkuCpg3qOoHa44JZrAUY1sSsBSZUazL2jkMfcS1svD6kF/nwzrnE/rxDoVqVTyHNbcnKFE05oQjhd3vQ8khMEdNf4q5wuVXwobHPRpnA2kE4UF6CW9kMKR9yqk5WiyNr8r6jPR9waDfJTkEP1aqsJ1BrCjDsB1SUTiyu81/YglIH9wIir4yBZFaSAVoapssT5zWJksJFPhFFezCPRMTUwTlINeMPnCixbm5pA3Zvpc/R12nmJ2Nl01IrqqD7+IZME5X34KaMpIEsB3quC/8jYuq87pWIdDwOf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(6133799003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhzYTR1YU1UQUMwUnNWOWhJbXVvRVZFMHhteUJFVXg0WkNScEVHYU9wWFY0?=
 =?utf-8?B?b3pPNloybmo5VGlZYmlEYWlqQ0RsUlF3V1V0M0pZUHNaSzgrNGg0eDN1aERs?=
 =?utf-8?B?YkhGajdjUHNXRndpVkY0Tzg0dUtlZXJqVTAyYTI0MWwrcXhkTjhpb00yaXlw?=
 =?utf-8?B?bnFJbXFoTnVvLzk0cmszSjRXekp6b090cU54ejQvMXQzV08xL1JEZXd3bGVZ?=
 =?utf-8?B?S2habXNhOFRGTnRXbk9wL2VVbDRuVHdJUmljZW5qSldQRnByRUhUdDZsZUZh?=
 =?utf-8?B?K1J1c2QxRjBQNXRmMndWVmZxMGJ5STRVTkd6dGM1SktRNFk3Y09XaWZDelow?=
 =?utf-8?B?SmpwWWF5RWlETG1MUXZ5ak5GS3NKQmIvOWZWMGg0K1FiRHkwT2lIUGN4aDBG?=
 =?utf-8?B?SE96ckZhMndUNWV2RHlram55NFRSelVvL0tkYWs2MjNYZ3d6ckVaWHdiaWhs?=
 =?utf-8?B?WUk5SkVlZ3JnaGllSklUamRZa2hCRUJwaFpEaHpKMTgxR3c0Sk5TRnFVK2xi?=
 =?utf-8?B?bUJZQm9sMGtUUktGSGtHVjErcFJFUmFOMUpwUWYrSGgzM2lBWXM3RHN2ejM0?=
 =?utf-8?B?YmtJWmluRzZ0WUFYSFlpaVJYZC9zZnpvb3hneXpMc0NFRDJabGliSWc3YjJH?=
 =?utf-8?B?MDZLL3BZOGNDSXZ4dm1lL1VWOHdWaXhNSWdoM2lodC9SYUFVdG9yZmh5b21W?=
 =?utf-8?B?T3NFWnZFREZ5NUJEMlh3enZGK0ZwaG1ObG5ycitCZkMrSTlPdjVqS01TdHJo?=
 =?utf-8?B?QXl2blBQbUE4VUFsY0xXbHdjWFd6Q0laZGUweXJFbFRtMnN2Q3BzRWlmVE83?=
 =?utf-8?B?MktNMHRMSVpnUGZRbWdzb2pLN3c1MythUkJ4NUZHNlpSZ3FSZFVlOFV1MWpX?=
 =?utf-8?B?T1ByY0tFdzNvc1lDU0lwZXc1dG90WUFzUmcrdk8yVlFFa3lxUXBPNG1YdGRO?=
 =?utf-8?B?alFiQ0Vxc3hVbDBKY3IzbWpiblErMTNGKzRuMTcxNThJN2w0U2JHcnptTm5W?=
 =?utf-8?B?Yk54RkllTTZjQnpEMjhTNVRpSnRjV002bjJONXZDSHRKZGFqbVZmTFdYM2V3?=
 =?utf-8?B?V0Z0dHA0dEh1a3gzY3QzZlUyVWVzYVd0NDhsdzZ5NDFES3c0NmNmekpqTVZC?=
 =?utf-8?B?ZzNKaEszYkRsOGM2S2ZELzVRbG5tNmNzMk1tcUNNbmpnZ25TVUJ6dmRicDk2?=
 =?utf-8?B?T3BRUlB2UFg0ODJsM2srY2NiZ2VIdWw0dEJ6U0IxUFgxK2pLMlhIaFhCbXhD?=
 =?utf-8?B?RkpZZEwrRjh4ZnpGWFNmTCtVcDFZZDhCSEZyckdCUExIcUtyU0JkOGZaUHp1?=
 =?utf-8?B?c2lsTm1WUlNTcml3a1owemMyQkE3U2hQK2dWeER0Qjl5eVc2ZllkV3VIMnNK?=
 =?utf-8?B?eDR2Q2QxclZ2YVRMR1BHVzVwbEd2TTNMclZQS3R2b1hrRGdWYWFxazdqK3I3?=
 =?utf-8?B?VWRUdjdBMlU5bHdXUnJvVmR1SHBFR1BNdEtadEpxZzRmR21IQUZMTGkrd2ND?=
 =?utf-8?B?QWhxM2hLME9PQlVzbVkwZVQ3MGVKVDY4NGp5VDlrRE53aHJSWWZJZitDUmxV?=
 =?utf-8?B?cUxMNm96N3lxWGNmQy9VbnFWMllWbEQvM3d3WFVYdEE1UEszZDJBdy9rd0g3?=
 =?utf-8?B?Nis0eHp3M0h6VG5QYXBlQzdOUWlBVjZlaHJUTXcwM05IYnVWaXVJR0V5VzhK?=
 =?utf-8?B?dk5lc0ZqaUdkNTlqT0dNQUdHOCtKSnlXVmdYRURxZzVwYkdkVTdpUzBKMmhj?=
 =?utf-8?B?dTFDVm9PQ3EzclI0alhXTG9sRzlaL3VsbjNwZ056QTZkMm80Ykc4aitlUWlQ?=
 =?utf-8?B?M0MyMjNpNW1XNUdnSGJYVlMzb2NnMHVSUVNiSnc5QkNsVkxVRnVqODRYTW1J?=
 =?utf-8?B?dTdIQU51TGhsYUpMWFRRK1BuWmVDMXJxT3J1TG1rdXFURVBVc3lpRGc4RnVy?=
 =?utf-8?B?M0J5TmJTV3hVV0l4dnczL3poZUpLaTNNRVh1WXEzMGJMZUh4d0VTTGVhYjIy?=
 =?utf-8?B?WW9kQmRYK2VYUmJDVjh1cmxvZ253dHdCdDZkL3lLT0QvU1FzMzQ1b1VyeUVE?=
 =?utf-8?B?TEdpOGNoWVVQVmpQQmZpTkZkYjlUbWVRdDVaNjlSMkxBYlA2ODFWTktlaG8w?=
 =?utf-8?B?VFhvQ2hiZnpkNkZTS2Q3YVE3cFhydmtWVXlQZHFKR3h6dGxGdGJ5Ym1CZ2V1?=
 =?utf-8?B?WXp6bGV1cHVqY0xzWE4vUFlqQXpnYjFiL1pnRGhtQ1U4QWp3VnlpLzVRYUE1?=
 =?utf-8?B?eUFRb29SLzcyTVB1czgwR2tiZ0ZsOHNYZmc5SlpudzZWWkFrR2p5Vk51UXNY?=
 =?utf-8?B?S3F4Umt3ZGhhWmtjVE5Tb2U3RkJhMXhoUnJWUWgxWUloK1dzVzRqUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4eddc5-3c08-43a9-5c28-08decbb6a1ac
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:50:39.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIUFFaTu5wnJVwVSYjfezc7cCR+bV9v7E7v8Zwb8yj7YQsls+SxT6PMB8wOwcn4Jir9J91/YGGT2rfBCd5yjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6355
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

On Tue Jun 16, 2026 at 3:05 PM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> Currently, `io_read` and `io_write` methods require the exact type of `I=
o`
>> plus an address. This means that they need to be monomorphized for each
>> different `Io` instance. This also means that multiple I/O implementors =
for
>> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
>> `MmioOwned`).
>>
>> Create a new `IoBackend` trait and define these operations on it instead=
.
>> The operations are just going to receive a view type and operate on them=
.
>> This has the additional advantage that the invariants can be moved from =
the
>> trait (and guaranteed via `unsafe`) to type invariants on the canonical
>> view types of the backends, so `io_read` and `io_write` can be safe.
>>
>> Note that view type is needed; addresses are insufficient in this
>> designk, as they do not carry sufficient information. For example,
>
> typo: design
>
>> `ConfigSpace` needs `&pci::Device` in addition to the address.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs     | 345 ++++++++++++++++++++++++++-----------------=
-------
>>  rust/kernel/pci/io.rs |  70 ++++++----
>>  2 files changed, 224 insertions(+), 191 deletions(-)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index 3ac8b396f5a7..e422a5ff2a5e 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -244,6 +244,38 @@ const fn offset_valid<U>(base: usize, offset: usize=
, size: usize) -> bool {
>>      }
>>  }
>> =20
>> +/// I/O backends.
>> +///
>> +/// This is an abstract representation to be implemented by arbitrary I=
/O
>> +/// backends (e.g. MMIO, PCI config space, etc.).
>> +///
>> +/// The base trait only defines the projection operations; which I/O me=
thods are available depends
>> +/// on which [`IoCapable<T>`] traits are implemented for the type. For =
example, for MMIO regions,
>> +/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically =
supported. For PCI
>> +/// configuration space, u8, u16, and u32 are supported but u64 is not.
>> +///
>> +/// This trait is separate from the `Io` trait as multiple different I/=
O types may share the same
>> +/// operation.
>> +pub trait IoBackend {
>> +    /// View type for this I/O backend.
>> +    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend =3D Self, Targ=
et =3D T>;
>> +
>> +    /// Convert a `view` to a raw pointer for projection.
>> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *m=
ut T;
>
> Same as the previous patch, this pointer is not necessarily
> dereferencable (e.g. for `pci::ConfigSpace`). This should probably be
> mentioned, or maybe we can use a newtype to prevent dereferencing?

This needs to be a pointer for pointer projection to work. I think the fact
they're raw pointers is a very good indication that they can realisticly be
anything; but I can add a note like

    /// Convert a `view` to a raw pointer for projection.
    ///
    /// The returned pointer is private implementation detail of the backen=
d;
    /// it is likely not valid. It should be used for projection only.

>> +pub trait Io<'a>: Copy {
>> +    /// Type that defines all I/O operations.
>> +    type Backend: IoBackend;
>> +
>>      /// Type of this I/O region. For untyped regions, [`Region`] can be=
 used.
>>      type Target: ?Sized + KnownSize;
>> =20
>> -    /// Returns the base address of this mapping.
>> -    fn addr(self) -> usize;
>> -
>> -    /// Returns the maximum size of this mapping.
>> -    fn maxsize(self) -> usize;
>> +    /// Return a view that covers the full region.
>> +    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Ta=
rget>;
>> =20
>> -    /// Returns the absolute I/O address for a given `offset`,
>> -    /// performing compile-time bound checks.
>> +    /// Returns a view for a given `offset`, performing compile-time bo=
und checks.
>>      // Always inline to optimize out error path of `build_assert`.
>>      #[inline(always)]
>> -    fn io_addr_assert<U>(self, offset: usize) -> usize {
>> -        // We cannot check alignment with `offset_valid` using `self.ad=
dr()`. So set 0 for it and
>> +    fn io_addr_assert<U>(self, offset: usize) -> <Self::Backend as IoBa=
ckend>::View<'a, U> {
>
> Since this doesn't return an address anymore, should it be renamed?
>
>> +        // We cannot check alignment with `offset_valid` using `ptr.add=
r()`. So set 0 for it and
>>          // ensure alignment by checking that the alignment of `U` is sm=
aller or equal to the
>>          // alignment of `Self::Target`.
>>          const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target=
::MIN_ALIGN.as_usize());
>>          build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SI=
ZE));
>> =20
>> -        self.addr() + offset
>> +        let view =3D self.as_view();
>> +        let ptr =3D Self::Backend::as_ptr(view);
>> +        let projected_ptr =3D ptr.cast::<U>().wrapping_byte_add(offset)=
;
>> +        // SAFETY: `offset_valid` checks for size and alignment and the=
refore `projected_ptr` is a
>> +        // valid projection.
>> +        unsafe { Self::Backend::project_view(view, projected_ptr) }
>>      }
>> =20
>> -    /// Returns the absolute I/O address for a given `offset`,
>> -    /// performing runtime bound checks.
>> +    /// Returns a view for a given `offset`, performing runtime bound c=
hecks.
>>      #[inline]
>> -    fn io_addr<U>(self, offset: usize) -> Result<usize> {
>> -        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
>> +    fn io_addr<U>(self, offset: usize) -> Result<<Self::Backend as IoBa=
ckend>::View<'a, U>> {
>
> Same here.
>
> And potentially, a more serious issue: `io_addr_assert` and `io_addr`
> remain part of `Io`, which is a public trait. They only verify size and
> alignment for `U`, not whether a projection of `U` at `offset` is
> structurally valid. AFAICT this remains that way by the end of the
> series, so users are able to call `io_addr*` to create and use invalid
> projections.

I think this could be solved by adding `U: FromBytes + IntoBytes`? We're on=
ly
using it form primitives anyway.

Technically, even without the bound, nothing can cause any breakage anyway,
given even after the full series to do things with the view you'd need to u=
se
`copy_read`/`copy_write` which themselves carry the `FromBytes`/`IntoBytes`
bound.

Best,
Gary

>
> Moving `io_addr*` out of the trait and into local helpers should be
> enough to close that loophole.
>
> Also, (and not entirely sure of it because I haven't completely wrapped
> my head around the issue yet), we might need to seal or otherwise
> restrict `IoLoc` so external code cannot create arbitrary
> implementations that allow invalid projections.
