Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A150CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC2610E97E;
	Wed, 27 May 2026 19:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="GArmH3nC";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4377D10E97E
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJFB5F/1ZiYVugqhIdiyJhVm17CcCWp19M0/zSeANLmiurgPZS+kKBqBGs/5RtbUr2YN4bkfjF3ve4sYOXzxoix/Jo26VP/ZsR5wCrrgJ2lWRlYKY4YqCgLwJvcxephq0tJqRl69LSSMkzdypmpfpHqlVEA/MTeiMd0itNhbrPX6zCmIT81JefCloIEMA+1bnCtD6UW6+LD2nTyDlNoiDJRb7M6zAD4OyUslK5BChhI+4Loh8N54QbzNt2IMmob4SV9IJW7yQbYYRwIMyaSclCr5aNVLlY7Nlz0AnSn6qYQG7p/Xd+tATwoKvvre41LG3/U+6kjrg1lWYqNnf4T1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de++OltCUqIJlTdIhlnZgN5c6ZpVgy6VHJ1FY/g9Nck=;
 b=U3/iMejqP5MMTtsJVl0PW3SOKJXIkG+aAtPJUXaMOYcnSGI4+Rkz6kmS4a/We+qLDSCyKfRRCDdwSBAQFppA1jngYsanOHXsEffSgIiIHI4wz6zSYEYs6sxlo1c3dryD3COZmugc3Y4YK36XnunMaXq71iQ7LK0j0o8AvKDHpx/GY1q4fhhzIv19dxpylRsqWwOytYwGCAyeHaJaGjlikQgmzz9wvJAOxY/AfML217PYUVYSCm/AkwD90emDovDXdVBr2MVL+mTOXLHHX3ApD2mcaH7rzraXe9y37ELGZ6+g5CKqTsYG8TyfYwFyXqOPt2XUK6XPyH6ZnUHC1IrbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de++OltCUqIJlTdIhlnZgN5c6ZpVgy6VHJ1FY/g9Nck=;
 b=GArmH3nCTM3gWJLU3DC3wnsYe7/4Go1p4POhbY83UN2YHkvXaB1KRMnUVLIKHsmkugoYn7Wfl/7bRpBU5RtASkOCfBfUralh0aU3oUZv8PPUtrtc744ElgXcu/jnA3JEc52mU23ha3zLmmPjhdhqAtwG/oDKcP6D2UD24YObhCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8996.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:482::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 19:47:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 19:47:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 20:47:47 +0100
Message-Id: <DITPVW44P95X.18VRH23M2Q0AI@garyguo.net>
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <ecourtney@nvidia.com>, <deborah.brouwer@collabora.com>,
 <lyude@redhat.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/6] rust: drm: Add UnbindGuard for drm_dev_enter/exit
 critical sections
From: "Gary Guo" <gary@garyguo.net>
To: "Alistair Popple" <apopple@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-3-dakr@kernel.org>
 <ahU6HgCsXWxHlH3L@nvdebian.thelocal> <ahZBOXFh7rb7vxzX@nvdebian.thelocal>
In-Reply-To: <ahZBOXFh7rb7vxzX@nvdebian.thelocal>
X-ClientProxiedBy: LO4P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: ce31caa2-1847-4e55-2b62-08debc28d44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7416014|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: MxRBOaQ+URigCQbBWFxhJ9EyR4CFFv+G4bgOLF0edw9WOiQwLZqFrl6nypG38y9TrvYZYtzcIi63ShOIcBlq7e3XLnrdQw6Q5MOAebgpoEUiDl2+Hp+WgZB13ClgJvmddcrO9qIT5XLYVeLDn0dlDsFzJg4m5WR0IrqhKO8NGfidXZJDgUNofLowqLHaVqKzDx1vMbvfPg1hveWA/xqeYvNIQmzGE/p5Ev4tP6iWwGveFBuqo1i2xoQt85ox2HJsMgvvsY4zEVyYrZ85woo5g8J1zX9gRyoRFraIZ/ivQtoodgzsBbKj6+LMxZozSn/O5yemzF9en0IaiIs+I/wNN511kN4orldpl3Oip7fTlHQheApiR/kbOGnGzpge4J6N7IlW/Tqd8nOTSUkxmbTNSJefBDAfJFsdM7IJYHUH6T0hcv9r7puE1X0wiC3QPFis+S+b4xhk/3rDmSK1Tq9/uXmuoXnkT2CDdUzbgPkOj0VM174J3ZohKH1CAyc6FbhQp1+DGqrJduaQVTGAXjYk8xv3S9HuOjJLyuS4djOt7s5QEN8HuzT983ejFQf9fnGnZhV8VIlQoN7SSzilMJCm/J78G5GXMCO4BcFYisO3dAEWFaN/Viqpu/RzRDibQN7L1JI+QVToYG0I7bsAQ0kUZXG2Qs5xrC+nPiGM1FDuriSFpUk2p9+8MSgv9xFpfeXsHTU4CEaGECtE7a3y4Cf+mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Q1ZHErUFNsMlgrMkpDQmdlK010b0NTMENDaTkwYjNXWWVVZ1ZBeEVZcVM2?=
 =?utf-8?B?dW05OWpNMHpPRWJJNlJuVmEwNDhNM3lzcmZBK1dPbnl6aU9UdjZuU1ZjbFFS?=
 =?utf-8?B?Rm9IMDloeTdLK3RWankvUGdWNlUzUWcvNlNFTWRqZEUrSVpGUHhxeTZlbzkr?=
 =?utf-8?B?anphV0g0bnF4bFVuSmhaYkpScFdxcCtmZndUWjU0NEtVRCtaUVptNjQrdWd0?=
 =?utf-8?B?a3pPenhZMmZlc2FFZjcvcjRiZXQyWThleUNSWHd4c0ZZSmVFTmg1U3JnalVG?=
 =?utf-8?B?bjhUSGFLZ2tGOTV2aktMVko1NG90ZHNzbFFucDltcjE1ZmQzUG02MFowdzUy?=
 =?utf-8?B?T0Y3Y2NZU2VhUjlQVy9iTHJYUVBXSTZQb0xremZyMEZvQmpFQUYvenVUanBF?=
 =?utf-8?B?bnFNdGZqZVNDL3E0RkVHV3N2cnhYM082TzZKZ0FzcG1zajg1RlJnTzBodno4?=
 =?utf-8?B?WlVXR3k1NUJ3cjRFWVZNS0hVR1Q5aG8xVEQ2TnFzdlQ1Wk1VUHFLWVBNSmZ0?=
 =?utf-8?B?cW1pNmU1eVdFRlJQdUVoNVZVTEtoU3NJbWdYNmtRZWJoN0cyanB3SmxRQ1Ez?=
 =?utf-8?B?TTZkSGg2UXIvUjVFUlpCUk5YaFVvUDZGd3A2eFp4YndVQ2hhS2RyNzdVa01N?=
 =?utf-8?B?UXYzTGlWTU4rSTZNcW5QSEc2NUYwZ25HNjRiN3hxWXl2ZndEMGtHZVZWOVpU?=
 =?utf-8?B?VTBsV0t4bXhNWmw2M2JrbTJXWDZvSEpUM1lSSU0xZ24wK0YxbGZwR2pMdHl3?=
 =?utf-8?B?TFlVbTFpZ2JTaEdieGhUdlN5ZUU2NHVMYWJ1VE5aV2RQS20rU1hURHRMcXVK?=
 =?utf-8?B?aWVJRDlZQWcyZlpUNWNtbmNsbVdXTERIN2V5RFZnRXl6dXgvakRYUlVxTTU4?=
 =?utf-8?B?Um1mY1BsTGFtQzBoSTI5SER3MGdFaXZQaTRENzI2N1hDREJOMjg2NDNCTHNh?=
 =?utf-8?B?ZDhQZ0xTY1hKZDZHajBNSzd1dzVvSk5uZXREbGIxM1FrU2RmeGtIeDduOUdS?=
 =?utf-8?B?bm1reHF0blpMeFg2aHZoRlJUOG1pdllyUGE1WUhBUllNRTdTZFBmNkdsMEFH?=
 =?utf-8?B?VTJYOWh4OVV4YVlEQjAvVTVGT0UycDVGelU2OE1GQVh3eFo1MFJEblNiWnFz?=
 =?utf-8?B?UnRaR2JYWStJSVF4UHRrcldGQVF1TXo0WUZNLzJralFka29qVTFjaWJWVStu?=
 =?utf-8?B?VzNCbGp1UGNlenNoT3dadXZHaUgzUXVtblMyVStZVitFWHVpTTlMS05xWDF4?=
 =?utf-8?B?QmtSckx0N2d6bDNBREJrUHc4MFNDSXJwY3B0SjhEeDF4Vi9MNnNWM2xhN25T?=
 =?utf-8?B?eUdCSDAxbVdRVWRvLzlza1dKSkg4a01uTVhYQjl1ejJhcXY3R3pDcHVndTB1?=
 =?utf-8?B?K1dkZi9ZWnFHSUlUd3k5Nkk3cXNuMVEzMlRnYVZEbEl0azk1NjJzMVhXS0lZ?=
 =?utf-8?B?a1J0T2Y0QXJiRG1rVGRoaEN0ZGtRNFMySHBUb0V5SkZGaTdmdXJ1ekUydWlo?=
 =?utf-8?B?cDRCcmxFU2hFOHE2UkRZMkNPSXpmMThEMldabXJoM0lxNFhEMXVDbUZKTCtI?=
 =?utf-8?B?TU0xa1RLMEE4UkFNWk9xQUM3VnprT2hpMjQvd0NFQkwza3ROZytBSFV4TVBY?=
 =?utf-8?B?RDNESnVYaDN5eEw1clFsbzRyczNXajJkOC90QnRkNHk4b3NxYXNSV282Qytw?=
 =?utf-8?B?MmsrVzhHTFNMUnI0cmFtckdGamhHdzNBeDJlSG05YnhMY3BWVmdVUFpFUW9I?=
 =?utf-8?B?SlpNdWIxazJqdHFqKzVsZFFZOU04N2EzSUJzTGduV0c4TVN3QWZEajJycThP?=
 =?utf-8?B?emVZNmo0bDlPSTJhMllrY3g3Mzd2SkNsRVRUdCs5azZGSm1yN21XdEtvdzdQ?=
 =?utf-8?B?SkpuUFhTRUNEZnZPYUVwb2ZoRVhNa0VPSkJYVmZRYjVUVFkycEp0c1BFVXpJ?=
 =?utf-8?B?QzdVTXpmQkRsWTk4NUxGSStUaDNWeVVhTzQvOTB0K0ZWYXlFek13NThaMnI4?=
 =?utf-8?B?ZFMzb3RZRUlwWG80YWFJRnJzdjZxQ0ZvZEs0SFZscmtFQ3N6Q2g5UGxoaHc0?=
 =?utf-8?B?cnk4ejY0RTN4VFdrbzRHNU16RGs4aVd5cmpLQklWZk0xbUpEc0NFMzIvZGFy?=
 =?utf-8?B?T1ExVnpGaDc3Vno5bEd5WHUzeTlnVmtGVEpKZFdOaDNwcVNjWHd6M3Awa0dP?=
 =?utf-8?B?VVFsQXFKWk93ZUpuNFNuTXNwZGZQQlNxL0d3eTFVdktvNGRiWkE5bnMydjFW?=
 =?utf-8?B?blFBdkcrR28vVlZWamNIZ05GaFlSRStpZTdMR3pGSVdHbTQ0QmRLaURSeDlE?=
 =?utf-8?B?WHV1NktzSGNPd1FMR3ZnME9BaDNSNWhZYnJWRHVxaFFCUjMrWXlJUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ce31caa2-1847-4e55-2b62-08debc28d44f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:47:48.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfysbLG4yegYFTYiwVN+rYAYSTN3x8jP6khSCYo1paiDfPbT2NNbwBEZEftJ5u3n98qDGn0OlkrIkhUhu8FTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8996
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

On Wed May 27, 2026 at 2:03 AM BST, Alistair Popple wrote:
> On 2026-05-26 at 16:17 +1000, Alistair Popple <apopple@nvidia.com> wrote.=
..
>> On 2026-05-07 at 08:06 +1000, Danilo Krummrich <dakr@kernel.org> wrote..=
.
>> > DRM ioctls do not guarantee that the parent bus device is still bound.
>> > However, since DRM device registration is managed through Devres, usin=
g
>> > drm_dev_unplug() on unregistration ensures that between drm_dev_enter(=
)
>> > and drm_dev_exit() the parent device must be bound.
>> >=20
>> > Add UnbindGuard, a guard object representing a drm_dev_enter/exit SRCU
>> > critical section that dereferences to &Device<Bound> of the parent bus
>> > device. The guard is only available on Device<T, Registered>, ensuring
>> > it cannot be used on unregistered devices.
>> >=20
>> > Also add with_unbind_guard() as a convenience helper that executes a
>> > closure with the bound device reference.
>> >=20
>> > Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug(=
)
>> > to provide the SRCU barrier that UnbindGuard's safety argument relies =
on.
>>=20
>> I don't (yet) claim to be a Rust-for-Linux expert but reading through th=
is made
>> sense to me and it's been useful for some Nova development so feel free =
to add:
>>=20
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>=20
>> for whatever that is worth :-)
>
> Which is definitely not much :) I just realised this has been replaced by=
 a more
> recent version of this series with 24 patches, so will use that instead.

Are you talking about
https://lore.kernel.org/rust-for-linux/20260525202921.124698-1-dakr@kernel.=
org?
That's for driver-core, this is for DRM.

Best,
Gary
