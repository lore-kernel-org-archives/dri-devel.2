Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DA1CD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C64710E90D;
	Wed, 17 Jun 2026 03:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pgvB3D/c";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE84D10E90D;
 Wed, 17 Jun 2026 03:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUlKCiRFhKERNcYEMO4r94wZoidYodavkRRZus/VEUQODkduJ8E4WLr8S/BGym9UnKZtqZI692whjO42IhjEzz2wEWU1PTI2iTSWWOvGH7E85Og++a9U7ryFleV714/Ug3NgWhIySGEf2Y8y5tWS0kZwZU7s8vPVk90pf67NzEPXpzlzL3B5Afs9/6ZM+GwNjhCBgEorJbh750sVFzITqUQm1bZrmXLLzTnTGluhPRaA3H771LI1jL8BWrXBOlefjv3cX/gzoAjcQ4QKXyvj3UgAy9w1bhwdgC3Z30m9ez1OXxXdVpfW8DhQnpSwjNra9RRoMHoWkFqabOvL4bdXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKp59/tn1GHHhEAidM79DAsEcTYbDAn9yOTtcmOK57I=;
 b=vU/q2cA19NIuIHZIMP9dqXI2kL3xCa5ZL/nDY3RpoKcKEgg7wNtt5nJlGt8/2XdUs3/eMomdJLhSlKlzDrH1Vp6JiOwYh6Yr6ZSuOx7clvbpKZtP5PUykdq0yyzs+00XtyquPfWmXNAtZ9L09k4U0AewVkdTNUZVuhrhtBqv898wr30U4yht4vuaUSNzxgPb0XuKbPi0kowyVIDJ6RLnnFkN/hmNxZZ8MP8zfZOhD9wQm22X4NksncfuUO+gga3ktV2ccffqnaxP829adBuAwSojYaYdCP+2PqrgEAK03+bOpX6uPo8byYM7rxO3E51ElTptAhKiuddM/yfBgi2Zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKp59/tn1GHHhEAidM79DAsEcTYbDAn9yOTtcmOK57I=;
 b=pgvB3D/cI63jvyJqicSflADwHiayDArdf6slgHLNhdNu3mvmJWep4KCnemkL6UR3lJ8StwxFd6fJeXFyq3xbOa00Iy/yFsPVvFdDcn7hciIVn0yIjwfbalsJ0mzJEsfzyHjq29Xb9ke6MXHlxSnDrYUZsrQNV/6P/oKzLqfMbR/Wj5mhKiw+j6zWV8/uGPn31/ddOusOk4BAn0yLz7voCYR7w2qbcVlp0EEFMT3vSfmGI9alqQOWIAWYxixbu8rnQt80vHHhaxdgo5UXHpPz2ys8rN8+qgfRQ3dhqzWbZRvgYwmjBJSojCHb7do30fEsVfPsOZ6kKFfTfG8Ygimc6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 03:51:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 03:51:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 12:51:12 +0900
Message-Id: <DJB0OWXDA3SA.2C7C24RNJY2LQ@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
 <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
 <ajD-8-bp6Usjl56R@nvdebian.thelocal>
 <DJAF4F8GJIWM.14MO2JWGG7OZM@garyguo.net>
In-Reply-To: <DJAF4F8GJIWM.14MO2JWGG7OZM@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0141.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 34298129-6fb4-4faa-96c6-08decc23aeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|23010399003|1800799024|11063799006|6133799003|3023799007|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7/GftXR7Q8Eic1L6LK7lUlz/00U985hzO9y/n8FdqKSy66euGLtqMWYw8i5AgO2cR5dNrqHC8BNLljUM4L2NLOcnPIKUyCBWeuSw6Mm5JcHHiQhilaM5o/ASvBTJLyowRbEgKWkKR9UCTWdjvx4N27tmdvd5+5NbbhA68wLeiW4PMiypATxG7vyfacEi+Uro6BUCDfQHfwIkqR9Us2Ko6Th8YRl1Wn5Z8LH7TnhpExQzrR3FY7gijXlQqw99j5RnbD+T8Q4sgwgcWTmFqSJ1UhqkOPZlW4i3XsLpP4KBCUkNMAnZv2qOadK0X3ISoTc8bs45BoUz4/9AW9gf03Sge/e/1bzqZphnQ5Y5rT4Xe872WWxEiV4m4/6PWdC7O7vMf7UxWgJbZSy5jIyi0XEPiFqOSyRMeglFHB0nnNLcpujwvP/AUV9iVpfY7Sb6ZyaZita78ffggs4VrMeSwxj5QVXXasnxoPokMpuaOH5iPBxQNZ/ywSUmd6IgOL555+vPI/G2GtobHIDKfEvOOVybQupqpMSsWq2YIg13f1JbXVmTY35dgP5ceIl7r76n0yPeW7I+dd035sXL8a7qkdcPL3dJ4VJMd6QBBc+MwJCHFDRwlR/IxvXWcHzk6f4DLLYR5aItG0BYlYGmHwaNlfqGmjDxcqRQJQrE3DYki9MEApNcZ55ilJQNism6sR08jAZt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(23010399003)(1800799024)(11063799006)(6133799003)(3023799007)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpIYnZDRXBFWDFpNkxHMnBZWHR0TzUxM2JoL0xCSWhFV3A1QlhBak40UUxi?=
 =?utf-8?B?SkprMGFCcXcydERnTlRtek82OWw4WWVDSm1EQTJmbC9rL3l3RC9hS29namsy?=
 =?utf-8?B?Y1hiZUZTUVRsalV1Q0dDZ2EzVU56dDA4QXEzZjlmdkpjRENEd3NmczRNMUhx?=
 =?utf-8?B?VnJJVjVTdlFrRVJjU1BtSkVRT2RnRU95eEcyTDBsVU9rZG9CZU5NZEJaMDdQ?=
 =?utf-8?B?ZE1WY3lFaWhWNnIzdi9RL3lKbERSNjNLTWM2K0c3TjB5cmJkSGRIUFVaQzlR?=
 =?utf-8?B?VEw0TlN4THRTSzltTjd0U0V5V1FYNU9jSVFKNkFCcC9EdjdhV21oOHg0dHZB?=
 =?utf-8?B?SDJRT0RBNkwvcEFTMXBjdEIyODJHcklpOG5rd0NZblE4WmxtVUkwckluQUVy?=
 =?utf-8?B?c0FNeDFiWXIyS1R5eHFiSFBwK1Z3TGRRMEhLaHQ3WGt3M21NY0ViL2tPc2J0?=
 =?utf-8?B?RnNUcXZFelB5T1hNb0hycW9sdHN6OERGUTdkaG01dk5ENTkxSThmcXp0cmln?=
 =?utf-8?B?Z2h5SkpQYjh4eDBjcDRqVjB6VGtiOFNzd2hCMzh0TGwyc2RTQ1d6RXYxdEwz?=
 =?utf-8?B?RTZlZTNaeFZPV2RvQkJPZDZKT3dpMFJYUVlCWlJldk4vdE9DdzhYR0szODEr?=
 =?utf-8?B?RDFtVk9La3Y5eDFCU2J5eTExYmlIZ2xtSjV1UEFKMzJzRHFXSThFTDk1TVdY?=
 =?utf-8?B?SmlmV0haTDNwR1FPcHhkTGw3eUozK1h6VTA3K3lndTVrTjhSSy9iQU83TEVG?=
 =?utf-8?B?cHNaUGFTV1YraUxtZG9wMklXM1hVeUpxYmdGY1I0M2dYRUpGSVp5NzlLemFF?=
 =?utf-8?B?aXNuQXVqd29kczF4OHNpeElxRmwzVEtTbWZOTHFvSUN3UVkva3g3OTFpM0N6?=
 =?utf-8?B?ejBKb1RwQ3I4dk9tWTJIUXUwdHhIQkxsMlRDcDNmYjV5NVZCMlNvbndoeERy?=
 =?utf-8?B?UkdQKzBLem5BSC9IcXRVS2FUdU45ZW9UaUFhSitYQTdtM3JnaFdxTEx2RG0r?=
 =?utf-8?B?RWRubnIxVzVtR0FNUUNJMC9XSzl3R3YxSnZPdjlROTNmV0pGWTdyaDNUU29O?=
 =?utf-8?B?VU5tRFRtcm10amdYemoyTjA2ZEIrNndNVGJHVHdFVGxrWnZzK3RYb3NZWVla?=
 =?utf-8?B?ZEtNVEpBN0JpaWlnTUFQNGhLQTRiVU9qN242Sm5zcks4TVFDN3Rlb3J4N3ho?=
 =?utf-8?B?QjVJS3QyNmxMYmI5UTk0VkJlZFBzQ2p2bzdEKzQ0TFJPemJvVGdiOWFPZXFV?=
 =?utf-8?B?V0FxVVJDUnNTM1FncWtMVUMvbUJrdUdXSWlqSE5idGpTVERNM0xobytObHBz?=
 =?utf-8?B?bVNCQkkwU3IwOGE2NWxFaitZN29UKzBKb05xN2JJbjFTVE5oK1Z4TS8rYkQ4?=
 =?utf-8?B?VCs5dEprZ0lNQlgwUVpSRk9JZFlINDhNY21rVlNCa21HQTRFMlBLSHFhTGZl?=
 =?utf-8?B?VlRqdGdneTFFYXVDbFRLMVFxK2FxMVV3QWVLcG1qSC95Z29XcnVWbmlTcTM4?=
 =?utf-8?B?cmpicm9NUVhXNHNFZHduRlBtQkMybFI3Z2ZEN21pK1RkUTdGMWpWZUJYcWVm?=
 =?utf-8?B?NDFmeUVFQWFFU2Y1elNZTVVPcFNWTW1CQmhtT1hwZVFUb0NBZ0dhbDVKTmxy?=
 =?utf-8?B?Q0FXN3JLaUduM2QvclZsTElUMGt4Nmt3Y1g0RTJGdk9Rbi94UnhSVkpGalRC?=
 =?utf-8?B?amxHWXVtd0hXS0ZlM3lsVGJhU0d4UXBVYVgzbmhRWGx1M0FRdi96RVVRdlBF?=
 =?utf-8?B?VTliUlVhenZmMW4vVUt6L2RLdzlLN3gwajJnQlVza2ZtMGFLOWpMRHRncFBv?=
 =?utf-8?B?VS81RjNLZ3VvY1RJTlBMNDI4NFZjWkpWQnRibEpWZXI3S0FvQnVnMGg2cFMv?=
 =?utf-8?B?OEYxM2MxbllPQmZndXo3bTV3YlJqRkFLRStNNExYYlhaUGV3NnJCbWVsVjVJ?=
 =?utf-8?B?UG1QS2dLSlJWNXhyeVpuc0dra2JNcnUrZkFNNGNVNzVOYTg1ZW9oQk5uTlMw?=
 =?utf-8?B?aVN2RFdyblJkd1JKTWtKZ01mR3A0TmczRE5yMy9xZzBvWTR3bFBkSFd5c0tm?=
 =?utf-8?B?RVlpWnpQaVYvbXhCQlYrVmtxZTdxQktNNGJPcnZOcm9POHpEOVVvanZrWXVL?=
 =?utf-8?B?M1lqWGJuMUR6bE5tTlBCb2dBelFFbVNKMWZFOGV5REJyVkFLcDZhTHNucFNp?=
 =?utf-8?B?aEI0L0JSWGoyOEEwTDJvaVg2TmExMWtvQnRNdHhiSExTaEU1Y0dRU3ZvU2ZR?=
 =?utf-8?B?VTk2andGWjlObDArVjhVN1FGRmJLMUgzNk5zSU05UGtFUlBxWnRpYU5jMmVH?=
 =?utf-8?B?VTB3eUJmUG1mcTVVNEdOWUtZdG1hdEs4MEZYRFdqOHZoY0dQSW5Cek9SMjJn?=
 =?utf-8?Q?zOkdE88X2K8df5i0mKi0wYrCNS5YSrjiAOkzP/4nRj3Dr?=
X-MS-Exchange-AntiSpam-MessageData-1: Fd2d561MlWmzBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34298129-6fb4-4faa-96c6-08decc23aeca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 03:51:16.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzY0JlF/jTM7OjactsHFG0lZLuz/GwEInFvaoBQ962lwjQFLB4L2g3PG+9kHADmV+7MjE9Q0+Yxv+ZcDCQA0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

On Tue Jun 16, 2026 at 7:57 PM JST, Gary Guo wrote:
> On Tue Jun 16, 2026 at 8:57 AM BST, Alistair Popple wrote:
>> On 2026-06-16 at 03:15 +1000, Gary Guo <gary@garyguo.net> wrote...
>>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>>> > Currently, `poll_msgq` will report a message of size 4 if the queue
>>> > pointers are broken. It's easy to catch this if it occurs, so have
>>> > `poll_msgq` return an error in this case.
>>> >
>>> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> > ---
>>> >  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
>>> >  1 file changed, 9 insertions(+), 6 deletions(-)
>>> >
>>> > diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-c=
ore/falcon/fsp.rs
>>> > index e7419a6e71e2..21eaa8e261ce 100644
>>> > --- a/drivers/gpu/nova-core/falcon/fsp.rs
>>> > +++ b/drivers/gpu/nova-core/falcon/fsp.rs
>>> > @@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &m=
ut [u8]) -> Result {
>>> >      /// Poll FSP for incoming data.
>>> >      ///
>>> >      /// Returns the size of available data in bytes, or 0 if no data=
 is available.
>>> > +    /// Returns an error if the queue pointers are bogus (`tail < he=
ad`).
>>> >      ///
>>> >      /// The FSP message queue is not circular. Pointers are reset to=
 0 after each
>>> >      /// message exchange, so `tail >=3D head` is always true when da=
ta is present.
>>> > -    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
>>> > +    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
>>> >          let head =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
>>> >          let tail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
>>> > =20
>>> >          if head =3D=3D tail {
>>> > -            return 0;
>>> > +            Ok(0)
>>> > +        } else {
>>> > +            // TAIL points at the last DWORD written, so the size is=
 `tail - head + 4`.
>>> > +            tail.checked_sub(head)
>>> > +                .and_then(|delta| delta.checked_add(4))
>>> > +                .ok_or(EIO)
>>>=20
>>> Whenever we fail with this, we should print a message (actually, the sa=
me thing
>>> probably should be done for patch 1 as well).
>>>=20
>>> A plain EIO is going be very difficult to troubleshoot if this is ever =
hit.
>>
>> I don't disagree with the sentiment - this is a problem through out the =
kernel
>> and I have spent way too long tracing where exactly error codes have com=
e from
>> both in C and Rust.
>>
>> But it seems odd to worry about these particular instances - they _shoul=
d_
>> never happen or at least be extremely rare and very unlikely by an end-u=
ser.
>
> I think we should either consider it possible and add prints, or consider=
 it a
> bug (hardware or driver) and add a `WARN_ON`, or consider it impossible a=
nd not
> add failure path at all.

I am new to this, but IIUC it's normal to guard against
hardware/firmware bugs - currently, for this error case, we would try to
create the `FspResponse` in `send_sync_fsp` and print an error "FSP
response too small: 4" without this patch. With this patch, we would
output "FSP response error: EIO\n". I think the latter is marginally
easier to debug, but both you would find it pretty quickly looking at
the code.

I am not that opposed to adding a print, but it seems low value to me,
since it's very unlikely this will occur and we have a print in the only
calling function right now (`send_sync_fsp`).

I think the semantics are clearer with this patch (no need to reason
about what happens when the saturating sub + add are hit).

>
>> More to the point though there are many other places in nova-core (and I=
'm
>> sure other drivers) where this pattern of just returning a fairly generi=
c
>> error code exists. So it feels like it would be nicer to deal with this =
at some
>> other layer, eg. some kind of debug option to tag error codes with locat=
ion
>> or something.
>
> This should happen whenever the information is lost. Creating a generic e=
rror
> code would be such occasion. Handling it at upper layers is okay if the
> information is kept for longer. For example:
>
>     enum NovaError {
>         ...
>     }
>
>     impl From<NovaError> for Error {
>         fn from(err: NovaError) -> Self {
>             // Print here
>             EIO
>         }
>     }
>
> Would be fine to me because the information is emitted to user when it is=
 lost
> by the concrete error -> error code conversion.

It feels very odd to me to have a From implementation have side effects
(printing) although I agree semantically with the "information is lost"
idea.

>
> Best,
> Gary
>
>>
>> So I'm not opposed to the comment, but maybe it would be better addresse=
d as a
>> separate question/patch series to figure out how to do this error report=
ing in a
>> more generic or consistent way across all of Nova at least?
>>
>>  - Alistair

