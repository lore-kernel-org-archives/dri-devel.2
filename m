Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D428CD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15CD10E2BA;
	Wed, 17 Jun 2026 05:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi6Fle9/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7865510E2BA;
 Wed, 17 Jun 2026 05:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6Cvf1OpDRA8YnCNCNTc6gjqsEdXhDVjSRf+hYxcVrzDBSB8XSY15QKLAxDZiarpQIQC0ytm1tP4tWy6AVUNV2gqF3eWhQTytix7PAbRYzoE+owwVk7bgXrkzoNXAx2Vp6g+8Mld3R/L5hIIAjfBdQlDD2hjIqP/6CljnX7tNqO0D4P3t8iadGjlTWzmnXF+cfyiH3OJVNACT5l0gxeqoSL/XJVa2gPXGCrgzhMC1ve/te+bbigj8TQHJFBDHH6cV3sB6mA0CYP+qfLsxWKOxk5hGMX5fZP6tGLz0cZmYhL4hnq/udsl4bh+hMjBT8lX61EzjY24zaXXz3JrGELn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+70/CWCCZADfVbRIO/ZJD98vwn+ZJj5oYbKBJyvppk=;
 b=VyBdfXiYkeZHHA8sw9dBr8IK4dFfI8cLKVRa2skMPBzV+3M9KoXNi/z3n6tIiXPVApLe6q583TgtWYa1VMFXikZepj4BKdgYVHQV0yhgTUtVZF1Krr2yWuv6NWzzYMZfKaM4oyK+VplZbE+0DrgW/60MvvbM7hBl5fXMQBNkuY3+qwgD71MKwtrATEHmE2YKKNyUv0utujpaMZZl8ZYPmQRIMLk7lz31EEi48sgJRE9ZCydUYQ/QF58ZUMktP0gZEr6Xi+0yiUF4zEgVWLh1t1vSHII0aks1RPgw3f69jAWRE6aTwPKZ1eB34Y4aiRznjRUNyCaTm0qpUSI36u4Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+70/CWCCZADfVbRIO/ZJD98vwn+ZJj5oYbKBJyvppk=;
 b=qi6Fle9/ToVsATD4LZJtfHT0DXrrKWX1A9OC3cYNQTpsEP45PPt4+YdAwVzF5NCvC+P9DX7NKdtKY4giPusmxJybh+j8bqiUKKi90ybBnGNPr8/MtbPv4pJuuMMQIQEQ0bLyhNHvK0fVuCt3sIKg9hC/WJ2dnV7qVCJXa8D2Ku0ujWpWxGfw/ZU6+L0Oeq0FaxuKAu8nxllpOj0Y3ii+fPgStR6UeSPhpII/mQ1edxDFo5ZIvzY0oty8ZxNRdsF6H60Zf3Y7XCtI4TLkz3dA2IXAgLLu/si9DqgRXBM7NC+qCMQ9oMekL6Me6VOPcAZaWYVBOyOazlGd7J713UXd4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:27:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 05:27:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 14:27:21 +0900
Message-Id: <DJB2QJAXEDVF.2KUIUQ90Q818W@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 05/13] gpu: nova-core: gsp: keep FMC boot params DMA
 region alive during error
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
 <DJ9SQ12O99GR.3TDJ2L39P03GQ@garyguo.net>
In-Reply-To: <DJ9SQ12O99GR.3TDJ2L39P03GQ@garyguo.net>
X-ClientProxiedBy: TYCP286CA0268.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: ea81ca42-bee4-4b82-06c4-08decc311d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /eHwassN6jII29R70UGzPInrbYI+86SICZFo460T38HKyRq97LxDS5gIWakzG86RjDk/Fn4GKDA4xagkfZE9+t9Qq7LJjK/mVM/VPNbDeWTTrE+tIVGzLjKmFe3PYtL0hekL9I7pVjETg+qruSz1kWswyK2qe2cT41S9r/cJnf3L/p2Qcivl+1oMr82e3KQ+R1eInARQGAd2fCkcccVeyi70h3o/xFieWtmO+gIab5apawhOpTilwXOD+auUeW+dizRfivdFckK8bwiPrJkfiGQydZPl+1eN9O1yNxSFRwNjX7OGtsgNYyTMoiDS3GV9KBBH2kqSztLXv3y2viUeZz30bZ1Zwo7NFbIZ0FMaHIDZWnn4T9+diZwFAlUGb1KvCtEpkZyfw378Qmh4dEtJfdSyH4nRzrg/GJ28R4HRNUPMG2755q90QtxsqVJAHdxw21TyjS7aB22YcncOcDEjqnWGOsy1vK79rFHvgp0UyVhaxO1nTDoNCCMqjIpxbaXHVBZkL6iOI7NXNCOS/jlgDu27P7TqzAHwEBtN5WmT2djC+pxmyGcM1Du6NnOG4e9J78TnTEC0YKvds73ndobu7o0mHPAHsWnOZxQ7Z+vA+eaDY8iOPUVk/qZa2W59W3gO32UVsvaM4txNc9WaqybAzXB8pRg8eXDiinlNagUFO2+K2mMdMFMfKlLaI3nR0eyp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVYzYm5leWNhMmM4OEZDTE5Pb2VIQUJUcVVMU2p2aVBROE5Tb1VSdzJoTVA3?=
 =?utf-8?B?Wm1ZRUlIN3c0TFNCM1hQeEh1MG1XamtmaXpBbzVQb2x3VExqazlEbTVLVEcr?=
 =?utf-8?B?UUJhZkRRVjBoTHNUU0xoNkFkbGJ1TUJFOHVXMkgzV2h2VU9sT2dPUG11Umw1?=
 =?utf-8?B?V3YwR0QrR3hOK2FBaHdkNmk0NkZEV3FoRElmVmNuRXV5WVRjd2p0TnRDN2pP?=
 =?utf-8?B?UnVGK3cvd1JqRUJieC91OW1xOVY1b0VjMStUNzB5dm5OWmdDcDRtUkZxT0RF?=
 =?utf-8?B?ZWo0eFlqalR0T3ZXK1RxQ1VoSWFYZVh0Z25PMXE4YSs3U2FvMjUyemZBL2NI?=
 =?utf-8?B?bW11UVY4ZUdrdUVod2dUMzFJZTJxRkdDWmlYeGo3NjRQQnVjbXd1blNtaVlL?=
 =?utf-8?B?SGhEY2IvUnNJM21PLzMxRXMrVmVkd3MraXdVUkIyUVovV0ZOY0tMUkZ6T2lJ?=
 =?utf-8?B?bGMzYjF6S3M3K1h5OWFrS2xkMVljR3lOa01BZzI4N1UxQU53a0lmY1hleHIz?=
 =?utf-8?B?a1ZrTjNRTUJPNVJmeVMzOEhrUDZjLzBzbkwyQ09RVVJ6cGl2R3A0M2tBRC81?=
 =?utf-8?B?WG5xL1NlYzU2bzhwdXl4OHM3VGs1eDNISjkzUGV1TWhuTXpxSVpUcXFqQzNN?=
 =?utf-8?B?WVVxRGlZdHlDSHFKbzlqRFZZTU90WUZ5UUNtL3NnUURnOVNwa05VN1BpUHBB?=
 =?utf-8?B?VHo0cWovQkQ0VlBVYjZ4SGpUUVpscndMNlhFbThCTHNYQzFvdjJ0ZzlIckhE?=
 =?utf-8?B?ejk1Rmw5WG8wdDdhd3VyQ0tYOE1wTUl1K2pZUitUTDlYK3AxZGM2Nk8yS2dq?=
 =?utf-8?B?dmdzNHNNVkVoYVRwT3NOR2p3M0xlK0s0OGZxTmFDRTVYd01rNithbFdBaytF?=
 =?utf-8?B?ait0Y0dBWTdGeWgvVmphWE0wVlY3T0s1ckFzQ1F3MFdwMHVscUpGdWJxbXZC?=
 =?utf-8?B?MGx0V3dNN200eDNYbVlwQytCbDEzZGFNOFUzVFI5ck5GYW9pcWFudW5xQlNR?=
 =?utf-8?B?UkZKR3RjUUZDK0h0NDR6dmJPT0tWdlN4dXEwTVRWUm00ekp1OENkeHQ1K1dj?=
 =?utf-8?B?eTJ1eWFlSHB0cjgyOGIvL2l3Z2gxeUtiU2xMVmFvNzl1QTFTQlBDWlVkNnJP?=
 =?utf-8?B?Q3ZseFJLZURDU2pkbHc3NisyU2tSNnNRSEFLMUJvRTdldnNLMnF5TmZrSVFt?=
 =?utf-8?B?dEZ3U1pVNnlLd1B5TlFrMXV3ZUh2cFVPRXpZTVFGUkhNaXFYbzZEOHZUeDB4?=
 =?utf-8?B?NGhRak9QNGxwWkp0ZzhZUmJGVldYaTltTmMrb29mQ2drV1VRMVBiaVdWaVpW?=
 =?utf-8?B?NkhUdUpHK3JDWC9JRnZFMCtLR2ozbG1qMnU1bVhGTThpOERtOU5MMVBlQzJt?=
 =?utf-8?B?VmFVdTZvQVc1NWFtdDYrcUJjN1BHYndjdlVZbExYSjdJMDE2elJ5NzlSNW1H?=
 =?utf-8?B?bTZnMnhGYnJYdzNkTTVkQTBjRVlNOWh1RjFKMVZDTTFncjR5bnpDYzB3aEhn?=
 =?utf-8?B?RU1UaHJoaHNjcjhic2tHSzZPbXI0R1NKbkxVVmREcVZwUEJjeFc3TWgxVXZZ?=
 =?utf-8?B?T2dLVDVkbEIvTzB0eTRQTEh1Sk5sUzNVVFl0UGV1aDNJVHB4UFAwVDVjSy9I?=
 =?utf-8?B?bmt2S2Frdm9qckNqeG1tNm5ETE4zQmZQVWJ4RUNTcVd3WnVvZlNBOXV4Vjgw?=
 =?utf-8?B?RE0yK1F4VERVRW1yUUNlaDdUY201RWYzQ1pRY1JQVFNqWjdxTHV3d0VPYy9D?=
 =?utf-8?B?UmI3ZnZ4N0N2RFFJck1GV0VMZ2NEVnhwc0NrQkkxbE01OUFTeTZwVk9ReTVl?=
 =?utf-8?B?R3lsUUJNRGRVYVpGZUxPdElmazBMSU8wSWM4eVhRSGlMSmo0S3pJVkxnTUI4?=
 =?utf-8?B?VmZSM2FaeFpYbklLUU5HQkR5aDQydW9aRytnZVlkeC9TRzlBeFVGcFBlTFdx?=
 =?utf-8?B?cmlZRnhGc0hqY3k5cGE1WEZlZHZTdFdGeE5yTzQwMVBtL2EvTjk2SUJDT3hj?=
 =?utf-8?B?V3JJNUk4c09Ec0pkWWFuNEFwL2ltb0tQMWkzYkUyRGJNa3FHYmpDTmM3cXJ6?=
 =?utf-8?B?bEo1RzBiZ25PLy9FSGhRUlVEYjVpQnd2YWgxdXJNbTJIZTNRcDBUUi90em5u?=
 =?utf-8?B?ckViQ1pOQUt3TDlQWHlNTjlTU3owMExhZWFZS0QwbFhRT2pxMjRCNm56NTNQ?=
 =?utf-8?B?UTFka0N2cG96cWp4MTVSZG1ueVZmeDFldWNaY3psRUxMcE9EbmthNldyMWFZ?=
 =?utf-8?B?Z0RXU28vZmhYdS9GeWlUeEhsRTc1V2ZVV0grVDROZUhsdGNkOFZBVjY2bkEz?=
 =?utf-8?B?YnFrL2RSOExJZ2lLNU1xR2hrTnQ2QU13ZXVGeEY3QSthUUlYRVNIbndVU241?=
 =?utf-8?Q?8CGsfyotWt9usDpOJY/GiiXOCZVobMWQDY8n5AnG4wSg8?=
X-MS-Exchange-AntiSpam-MessageData-1: snypXQ2yQNz+SA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea81ca42-bee4-4b82-06c4-08decc311d6d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:27:25.4210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3cr5J+ZA8v5ZEA0JnVh9s9eOYiXUcOAsdABaTPdRBliWdxqBdshmEtQaOiqne9zIJSP6jElY0udEpiSaeA9qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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

On Tue Jun 16, 2026 at 2:23 AM JST, Gary Guo wrote:
> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>> Currently, if, for example `boot_fmc` fails, `FmcBootArgs` will be
>> dropped before the boot unload guard. But until everything is unloaded,
>> GSP may access this memory, so make sure it doesn't get deallocated.
>
> Hmm, this looks very weirld. `boot_fmc` only needs `&args` but it actuall=
y need
> it for much longer?
>
> This is hinting to me that the signature is wrong of the `boot_fmc` funct=
ion is
> wrong..
>
> What is the exact lifetime requirement for GSP?

Once `wait_for_gsp_lockdown_release` returns, it no longer needs the
allocation. In the case that we get an error in this function, GSP may
be (asychronously to the CPU) accessing the DMA memory we gave it. So
FmcBootArgs should stay alive until FspUnloadBundle finishes (GSP is
reset) if there is an error, or, until `wait_for_gsp_lockdown_release`
returns successfully.

So for `boot_fmc` to cover the actual lifetime it would need to be
responsible for waiting until GSP is reset, which it doesn't feel like
it should be responsible for (even as some unload bundle that it
returns).

An alternative could be making another local guard holding the
reference:
```
let unload_guard =3D FmcBootGuard::new(
    BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unloa=
d_bundle)),
    &args,
);
```

WDYT?

>
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-c=
ore/gsp/hal/gh100.rs
>> index 98f5ce197d13..b08761af89d3 100644
>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> @@ -162,16 +162,6 @@ fn boot<'a>(
>>      ) -> Result<BootUnloadGuard<'a>> {
>>          let fsp_fw =3D FspFirmware::new(dev, chipset, FIRMWARE_VERSION)=
?;
>> =20
>> -        let unload_bundle =3D crate::gsp::UnloadBundle(
>> -            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadB=
undle>
>> -        );
>> -
>> -        // Wrap the unload bundle into a drop guard so it is automatica=
lly run upon failure.
>> -        let unload_guard =3D
>> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon=
, Some(unload_bundle));
>> -
>> -        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw=
)?;
>> -
>>          let args =3D FmcBootArgs::new(
>>              dev,
>>              chipset,
>> @@ -180,6 +170,16 @@ fn boot<'a>(
>>              false,
>>          )?;
>> =20
>> +        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw=
)?;
>> +
>> +        let unload_bundle =3D crate::gsp::UnloadBundle(
>> +            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadB=
undle>
>> +        );
>> +
>> +        // Wrap the unload bundle into a drop guard so it is automatica=
lly run upon failure.
>> +        let unload_guard =3D
>> +            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon=
, Some(unload_bundle));
>> +
>
> This usual "usage beyond reference lifetime" needs to be at least explici=
tly
> mentioned here.
>
> Best,
> Gary
>
>>          fsp.boot_fmc(dev, bar, fb_layout, &args)?;
>> =20
>>          wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_p=
arams_dma_handle())?;

