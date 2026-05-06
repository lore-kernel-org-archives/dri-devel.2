Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37058CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E58F10E53D;
	Wed,  6 May 2026 13:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="0MSavuiL";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021090.outbound.protection.outlook.com [52.101.100.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D43C10E53F
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBpjWdhmMdEmuWeiEi6Iz0eEppBntu56h6pVF/x9xTkd8A51ufPmK7f6Z1PNvyJmOD7tSXfC1meG0INdesbWmfxxk6arQP75IwuiJ4hrGkt4Ri8jsc+BkVUlrwZ5nSSR+7XIlSNNtnC+AgPYNsoHu4o98PbC3GCkGIFyodPlPd+lMZlivbrUlzGcxti37r/ykfx7AWO0lhgFSp5Dhy8QHOB9upC9fg4ltHhz8TYjqWcvYeWBMAglWGsR3b47o7C585PJ48zMuCziPyP91z1agkeVIvgVfZKYnv30mlD91dQpjRU1pdlBzrGYdta07f0DQt5vNJu8ZGovNGqY7l6zFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22g7Uo8ON2npHPf8o074VTdzvsAdhhfrFJY1g0wFH5M=;
 b=pAk2AZH8Zj1ySGrZv0lzD6kxXu+48EsezP7FS+lnWHAm6XuEA5hbkEoWD923aBIYO7sFAge57CFGXhtH0Yjv/Ko24+wH2KaTqoFo0KuRyTDzDXS/SiD6lQh1ZYPNUqI1ZhlYfHtLE2MKqE7d72+4WeIMcIhPFvpcbPiS8HBpiX5JEMgQ9GJPJ0Dz/mrZZzxZdAoegR++Zd5z9WTIap0P+cnj5sVjfd6piEjwympGSEhEuPCWwPtAPu/tJjEGJA9iYVSlkOnkOCSZMpAN/LqVOTbZLf2k7pbCneVNL9PctL5jbeVhIp18PkagLtXkeHnA+By2ZQFIjJI/yidE/hkMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22g7Uo8ON2npHPf8o074VTdzvsAdhhfrFJY1g0wFH5M=;
 b=0MSavuiLJWhJ9R9Tvix11ck1oeJ0yzxRQfaQ/ZLrD6i7XWJfH2zwWJ6yn9ToKVUoGhMAZRXOFykEPgSsrqN8XHGsBU/3YVtz0WMLz8hSFJ9hatSq9Pj0m+fx+kNfYmpanuwmRWYB8f2OAng5a0IKTUUoQ9gwRwBI/7YdQZLuNRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6664.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:41:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 13:41:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 14:41:06 +0100
Message-Id: <DIBMXPC3ZKIA.1UQORYD223AY6@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: auxiliary: add registration data to
 auxiliary devices
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-3-dakr@kernel.org> <afs3Mz8J9oOeqF34@google.com>
In-Reply-To: <afs3Mz8J9oOeqF34@google.com>
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaf4c84-d4f2-44dd-46b1-08deab7520f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EJ2PHG0fVH04zWaC9bNfFRji/lugc8gpAN1oyJbnpBRor6iCH/jP8ZMBIVORnuC7asseNo6cX+Thtt3v65Ews5ZwywqmfilzLv5Qz2na2x1Ly7Y+X0ZPvgq1bNZKmuLOFgu9glHH+PcrcubUN9dRYugwXUeZ9xbAi6ZJH6VHZYn9mazPNSm8/wsyB9hAElSqb1o38/bfFiwnkj8xJF3mcMMyq/FYr5kyJjbG3FyAlGfc5mw8oOdN0hOnty20wzX3e1yrkQ65IFSOYquzs3gVYbqHVEKMvLwWzuiJtH2aT3a0MeiRY2MGEyRalWfh6tdSooi8X9WVxyBrauZmk66yIMkOKcmz9jeO9gpyjLpX+QM3q9yPJr2qKYIouFu0GZlrDSfXQnDwNmekd2ybxP+f5TeSCdc6zO8ORZLWcMPpyuN0FBvUaB313R6u0DIy1niCFrrrdWxGKEOVc3q+KAAm4sSjueB1EXtoK42ic3OuQaKd3ANIi8lqAnjt1UrXaTrU+ZMaTVM5NFtSTsxpdiKz6zbpP/sxeQjIeKfAtZLfzNgQcJWXNGThPETiZwdVFz69TwfawvV9XN5ssidtdVM1lna7yUzioK/RCxLCKO7Dr/E/c6MxFH2fPNyY2GWlWZ2G+g5VMoMSVxQ9HnqwfeoDPI3l7aRAxREDClpOVruW1X50J5eymc5k8cb7pf+jx2f5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FFM3RydU92OTFIZUZ1anJOYitvVDZlY1lJdXVYNzdHbHVDQ3ZrcGdieDZL?=
 =?utf-8?B?VnR1SHdNcnlBb1VmbFF5cVZ2ek05d1gybUI5c01iMUhKaFg1eHNpcXhFbEpu?=
 =?utf-8?B?d3NMOFdwa2hoa0psaURnTUxBTGZDUzBSR0JwSWl3Umw1cVd3bmlxU3VRYlBy?=
 =?utf-8?B?TzNBbmM3SmVnVXdBVUVrOGcvNTB2a1R6VXpzY3JYZ09EejFmMXI1bVdGc3p5?=
 =?utf-8?B?VW1WNEhUc0tDQncrNTNrUWZpRk8rVFp3NGtCeHhnc2RMMTRBeE5aQ3RSWHUv?=
 =?utf-8?B?eDY3Y2g5WGFFRnVUQVRFRFpEeFNsVDR0Q1FuRGYzbjhlSStYNHowbTlPNjhl?=
 =?utf-8?B?ZEovNzdIYXpxTytjS1MyY2l2bk1CNEhyT0VCN2xqNk9WTE1PN2hvbS8yOFRB?=
 =?utf-8?B?MkI4OGFiRGd1Ky9zRWp3bVNSQ1VkRVc5N0ljWXppbDVlWUpjNUVMWWdSdENw?=
 =?utf-8?B?ck8xdTROU2hUbi9lSHZlay9EbmwwZVp1anBlNE90QSs3SmJ0NGhTREJKZDhS?=
 =?utf-8?B?NzZKY3lsOC9QMVlBYVRCVXRSZmJibEpVNEJwelAreDhTRitrVGluYUFyNDcx?=
 =?utf-8?B?dERpeENQdFRiVHFQMzA1K0dxN005ZG5iTFRQSWdMNTlnRzB2Y2RiWHAxb3lx?=
 =?utf-8?B?d2RkT3d4NVdKdmZEY0twcGV3eXI3aDV2TjBvejQ2dlV3bC9KczFDODdra3Q1?=
 =?utf-8?B?MjZxMHQrand3VFNkR1U0ZFdPWWNZVjJtOHFIWWlKV1FTMmtMbU9ZVlhMNmhN?=
 =?utf-8?B?aTQyMWFOZ2orUXR0UnFLTGxva0w4ak1USzQzZ0U3ejAyVHREajdJVktiUk44?=
 =?utf-8?B?bG5oRjZibHBqNTI2a0hUZUtiSENXWFlNM3RTNjlnZ00vZUdDZXBDVHVrWTlJ?=
 =?utf-8?B?OTdsQ0syNjFOenRWYXQvaFVUL1ltR3QzWStoeTlQaGU0ckU0OUYycjNDZTcv?=
 =?utf-8?B?Tno0VWRYK1RVTW5PUHo2d1dKdHVMTGYxNkVNc2hnQUVHbWVLOE9QeG1yTy9P?=
 =?utf-8?B?SEFpNGxrNzB6L25OVzU5Vk1KK1krK0oyVHdCOGMxd2dLNUlDQldRakJEdm9i?=
 =?utf-8?B?YmhZYUI1YkJ3Q2JKbWNPY1JQZ2tmTlJqMFpZdTRXMWg1ZXY0R3JYd1VRNHU2?=
 =?utf-8?B?Y2ZHMEtvTGNXQUF6NzZ2WVRGR1pRaFYwQS9HSHBObVpkSGpnU0JGd3dvNTBu?=
 =?utf-8?B?RjZMaDBkTWw5aHpFZjBDdlNVbVc0TUpNMm96UzRNU0pPcml5RWxMdlVCbXh2?=
 =?utf-8?B?em1jZnRabmk2aWRFSkErM2JYRlZabk5WVVV1SFc3RnMrV2FqQUZFcUpWWGtw?=
 =?utf-8?B?N0xEYmhkc2NSc0U4eExwc2JsZlpiMU9DTW96QlFVYkRBQWJaYmJhL1BTTzVQ?=
 =?utf-8?B?N1hQNzREcUlBQXNJUkY4aHNEVlNZZmd4MnBwWGQ3cWdEVndPQUxyNFlyb2cv?=
 =?utf-8?B?TlRqZ2d4RHhucGM2OFE4aU0wK3FENHg0Q2ZuOGRyaGt3NWpXYkNqbGlDTHd6?=
 =?utf-8?B?a1A4TTdod2RzcWpYNndzUzFwYXlIZkl0UVVIL0FmcG9vSTZEMXl2QnQrNE14?=
 =?utf-8?B?NVNqL3ZWQlZ0ZDJoQTE2ZVNLM3NVaTgwNUV4Yysvb2YrZnNheUlIL1FWZGFa?=
 =?utf-8?B?SEMxYVZCNTdXWlVzUkw5cUZXd1ZFbWk5bVdJQnZJMlBVUXJENGhqWHFqOTg3?=
 =?utf-8?B?UGtaUEs3UHNPSVVzUGl4dEhZN2VkUW9vQmtqZnpPcTg2azEyQ2E0NUlVam1L?=
 =?utf-8?B?azQySm9oeEZtRWNkSTNvMjJNVHliL3NaREtoYUIvT0M3SFBUSmI5WlhJaWwz?=
 =?utf-8?B?TjlRNStNb2hWcmc3dG5aTnhqTkpLU3kvV3lWdHk0UkNOYnRwWGJVMno4b2hi?=
 =?utf-8?B?WjBaVm83VThYYkdxUUltalNnK3hxQVpVMVpmdGR4NFYxNXd3dXVGWGp6NUd2?=
 =?utf-8?B?OFhnTDRGTCtGZm9WWlFmV2krd0hTQzdoeVNTY3M5NUVBRFlOUG5BZUppRlUx?=
 =?utf-8?B?T0NLNS9pWEhMUEljVEpTWWhsNHI0ekJsVlBlbjBNL1ZZbDhiYkRhZEpqb3la?=
 =?utf-8?B?MTdOQjVKcjdhTVdybmFsMERWeUVWRk9hSGRVOGVBRC9tTWQwYTE1TGltWnFa?=
 =?utf-8?B?NzRlcnc4K3QvRXZPdHRXa3JNeEZlcGhiV2F6WTIzZTdnQU9XNFFLbjY4cFdJ?=
 =?utf-8?B?RndVdVhXaFlXYlJZVnVBNjY2eHNieVVZY1JDSnU4a0dCcWoyR3M5aHlDUmpD?=
 =?utf-8?B?YVFpMzVqTVpXUEZWNnArVmZBemRLcU5kS1pXUEZzRVJxT3BobW1LYjY3MHJZ?=
 =?utf-8?Q?noRtZjCYb4e76pCNZW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaf4c84-d4f2-44dd-46b1-08deab7520f4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:41:08.6918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duh8pDDcrfw1fSo557HVWVRr9J5nnu/4Y6KsLJtdPmi/rI/NDsiUDk5q/TEaDBhBUHUVWylsHr5C+acDUAUKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6664
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

On Wed May 6, 2026 at 1:42 PM BST, Alice Ryhl wrote:
> On Tue, May 05, 2026 at 05:23:08PM +0200, Danilo Krummrich wrote:
>> Add a registration_data pointer to struct auxiliary_device, allowing the
>> registering (parent) driver to attach private data to the device at
>> registration time and retrieve it later when called back by the
>> auxiliary (child) driver.
>>=20
>> By tying the data to the device's registration, Rust drivers can bind
>> the lifetime of device resources to it, since the auxiliary bus
>> guarantees that the parent driver remains bound while the auxiliary
>> device is bound.
>>=20
>> On the Rust side, Registration<T> takes ownership of the data via
>> ForeignOwnable. A TypeId is stored alongside the data for runtime type
>> checking, making Device::registration_data<T>() a safe method.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> The change itself LGTM.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> But I'm not entirely convinced that this is the most convenient
> user-interface. I'm wondering if the auxiliary driver trait could
> specify which type the parent driver data is using in an associated
> type, and whether you could eliminate the check and error path that way.
> But then again, AuxiliaryDriver does not appear as a generic parameter
> in auxiliary::Driver, so it might not work.

I think that's similar to what I'm suggesting in
https://lore.kernel.org/rust-for-linux/DI6L13A5LMOW.DU7ZTHXZYB0K@garyguo.ne=
t/.

This does still require the type ID to exist and that probe of auxiliary dr=
ivers
need to fail if type ID mismatches during probing.

Best,
Gary
