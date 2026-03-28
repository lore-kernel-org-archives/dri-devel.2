Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1336010F3DE7
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 13:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C9789C93;
	Sat, 28 Mar 2026 13:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="qlIFf6Gj";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020074.outbound.protection.outlook.com [52.101.196.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB5189C93
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 13:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYdlTBr38G1dLJU3yYbngLDE2PhGqAkcXi8SU75jLL65HVBE8w23AjTJhZxKa23GD2Lu3QBiw8AKrTPC3pDqq8HVQIDxts/pzb3ud6RmryK4IdvZZwRYb2ddTEurxA00IkMOQW/ai5OsTJMKxCZfrk5FgKLltmElwiD3XAiCZGnXXngGBtmj89pXDmhoN4glKztR8q3k3LRyYVTvO7DBibT/noCrgeyBkt6t62B6IUw1L3WXpqQg9Lm5RguauZoDXj0IX9Q5Bp2mjfB0aJbEceJksFrMJoygWx2e9ab1LQDgXHHbc7kp3i3CKTUa5hYzLhtAyV967b3G9vI/k7XjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU4gjztlp0SkVSjULhTGpHmn6yll39hYht3PNPyngME=;
 b=Z4s9RSJ1PLu/D6bbPuXfl3egQAOPitrY2DtlaHHOQXo2IJZOrUhA/zMb87A1WJlj41WmMQwcfdCDC4IaNVZPCvNoZGNdVp6fXCCJ2RrRIY4xBEsD4g3rBgr9lGDh4qV3iUWp2WMvG1fZUVC1DkiyBOKo8ZycdmyswYXawNMznzvt1xnMODLI3DMy74hBO8VmY7jbudghj9ZJvvOnM95FmDIHlXJxy0MvHX5OPLUlSuvDZ/XOnMj2q1vex2fyRZjeZ6hfP7XtjRLrolMW267eGi9PpoLSTCuv4RmBLo2a5GaHFV0fFbRRxryex9G+Fk3uQQcKKF8Nk06slA3Zg9KC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU4gjztlp0SkVSjULhTGpHmn6yll39hYht3PNPyngME=;
 b=qlIFf6GjliAGJtnGAqVBDaPKjREdlV4ZbXBRn2jhqH31oE3jvkuPpyJnFhVY5wqT5EZO8IIdlZuGlIZ598gAd4kO+7g82liWd09/2i9BxL+uV7MrrgQM74GZkoDhQtgZY8F+9QhthejxpM11yImdNtgjBXCKk+ax9TB/RtnQMus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7245.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Sat, 28 Mar
 2026 13:09:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Sat, 28 Mar 2026
 13:09:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Mar 2026 13:09:39 +0000
Message-Id: <DHEFUD64AORK.8FOCH0VJAM4B@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
 <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
 <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
 <DHD5FQ1O1Q60.1C2FZI4A85PQ2@nvidia.com>
In-Reply-To: <DHD5FQ1O1Q60.1C2FZI4A85PQ2@nvidia.com>
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: df4fc0bb-27b6-4728-0b83-08de8ccb44ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BKpwp7peu+YlmVTwoo0yPyIe1QVoeDYnwJawbgZggEK+xKuT3jrDTCoqSwgIgI5D3fwWYv4WvkBKVBhs2rg7A6Ne6JxG2kiJRTJDzzLaXuruq/E11MlFWda0kq7MHh5q2Yxpy/0If3HTJJAraLvAhCRxVhWty2hJE4iMkQdcwbs55LuPONk5jlXCL/Uv37Tu4p5ew+nUE5rEYouMEXNp+7XpugczUb8P1PXXll6nTJNKKs4DirbsgkJ+ipoNoMARs26NHyRhZlEB7Zq2BTCu3jgttP0C5Rom7fDE9xwig1260T4LP5B3MT5wWZQiHLrpCfllowHcxGDil38K0GLc+e35/PZCr9JaTLaEqTI5jxIugI6XuvdqoX6K6DwN9GeOHlcMjkkj9aMadg/cCk/QYld7GlEpgmvydxDz77TnId/SfNmN3OwecZ3RhsgOtupftc7thysRRUYslMfAB1r6IRd/moP3rQyzzzAHFS6ESL5feaYUuqiv++M0FYY7o+oNMw9ISy5IzuQc3c2SqYWfBrfQPqgH5RSQz4gVznbgSwiNGXYIK7bOIgxmMios4gXksCkx/QYGDQcois54s4P7NPvXZXCHvJ6t14PYcO4H/lF8/WkmjPLh8H8KF72edjvR6oDDo8ztEsDqIqlgOCfBlbd7RVgEMYv3/LXXx9O9FsK1EZREnD/aZ1Mm6ytoCYHN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVaR2V1MFJBcy8reXFXY1RmS2xtc0JBcXhqZGNCUDF0V3orYWcyck44WFBp?=
 =?utf-8?B?QU84dG11T0pJa2szM0lXM21ZV0xMUjAwNC9OeWo0dWhzd1F2Ulpzem5NeFBF?=
 =?utf-8?B?M1poMFArQjMzUzRxMWs1MmRRZENDM1BEekNTL1ozSDF3V21ab1Vlamw1djQ0?=
 =?utf-8?B?VXV0dDlCMzVYNDNvUTJzd1dVYmlGeXBIeGtWcFptRGVYMzJwOTYrdG9SV0dO?=
 =?utf-8?B?eko2a1cyVGxsRnJxY0k2TWt6YUNkVTFxQjkzYnNZV1REa0dPcWpvZlF5QXcw?=
 =?utf-8?B?V0NWTFBqQ1hydUdsL29ENWp0QzlhZjYxUnR1czRaWGNoUGxiTFI5SlZ0ZzlC?=
 =?utf-8?B?ZlFET0p2eE9ERjh5d3JOc2JPZU55ODF3S0RUUXA0QUVmQ1dwdFl0NlVkZkxt?=
 =?utf-8?B?N0o5Zm9QVTV4aHR2TUJESUhpcG1HMy9XcGxwNlpoNEhQTjh5bEJaN0NySWdR?=
 =?utf-8?B?OTAxMEtNMGVYSTBwYWhPeUpwN3AwWTBLYlRtN1NaanA3eHNqbmQ1eVNrc2dK?=
 =?utf-8?B?TkttRWNhWE9GMVJacGVoRHpvWFY1a2pJOVZOK21WYm5LS09OZmtNTEV3aW9N?=
 =?utf-8?B?R1kzVndPOW1uTElaWHhEMUsrb25wUEZHMFFVd0RkSlNqdjNZc2pDYnlwS2g1?=
 =?utf-8?B?aysvUWlqREZENjg0RENxNks5MWJiZ2htZGdhZTVHdUdrM20wL3ZQYkN3Zzkv?=
 =?utf-8?B?OWFaNWoxNjRMemVIU3NIdjBNd2ZiU2hiaTVSUklhOWY4T1lJRThybTBJNTB1?=
 =?utf-8?B?RHpLMTJFeFp6RGc1ZlVTeEY5RDRPdVBJalRFODdaU016SlovVUZYWUE5dmM3?=
 =?utf-8?B?SElCcXpXK0gxS2VBYjUwZjU3VFpTbE1jc1BULzVQUzhxUm11b3pHY0wwaTZz?=
 =?utf-8?B?YVJVU3NwUzNmenVDd3RrRFdmaVlJeHNhOVN3WUxtc0RCbDF0QjdERDVlTXFj?=
 =?utf-8?B?cUpDRjc0TU9GTkVLck5WVmQ3ZFd3cUdWb00zRlFoRTR0cmw1ODFDbC9MMlJ4?=
 =?utf-8?B?a2grTTNJUi9OODdxR3ZwUEhTYUhlYnhPNkZLMDBhditIZW10bXJ0am9URTdz?=
 =?utf-8?B?Y2xFNHNsMlNzVmlwOGN5QjZyRWhTTTdtRjRhRDJ0L2xOMGhNTEtDclpXT0RR?=
 =?utf-8?B?M0xKaE42SFg2eUtOaTkxak5pblFLajVWZUg4eGoyNVM0bXR0WTZjdnBPNWR0?=
 =?utf-8?B?em1QWVZ0VEMyK0hLTklxVTZYMGdoN2hpcWN5bkcxUm12UmYwM043SHRDV0RL?=
 =?utf-8?B?dFRIRXluMnBxSmhxK0JseEpTdmQ4Z3BsRitJVFVPY0lPWFpwZGUzSFBmOGFv?=
 =?utf-8?B?OWZTaGlXbG1uaHNiSlo5bUZZYy9rSUtuVVBMUGwwcStUVEpaeUNldVVNVUtD?=
 =?utf-8?B?bFRnUzAzVmRMU2dFeWdWSU5GaEpramU0Y3k3M0lyRmpVbCtwMU40WmxMcXd1?=
 =?utf-8?B?UTZZai9hcnZYL2d3RE92Z2xJV1RKUWFONlVlTkpiMmRsclFCek5Wakt4cWky?=
 =?utf-8?B?c3VQMHRrWU5EaTdFL3hPTzdWSDRmLzBTN2ZzaU1zdWRGVW9pKy9ZaDIwUTJM?=
 =?utf-8?B?R3VmNUNqWGw3L1BQd0VhSy9QSXlHYVNwWUUzamJ1Mk1wNlROMHkvQWV4VUpC?=
 =?utf-8?B?V1pqUXJDZWlWWDlBazBoSTZ4NUJrT1RuRGlNYkJNcHd6a3VTc1NlUkNwRHBp?=
 =?utf-8?B?WFQ4L3VlaFQvYzRXR3NaTDdoTFN2TGRDazRZbnBUWmVVRmFna3NlK3BSVXN6?=
 =?utf-8?B?VVU2UmdSWWcxdkdRMDg0cHZZYTB6ZllKNVZqWEFKVU9MYTNTcGFOK3VEekJF?=
 =?utf-8?B?amE2VHBpRGtmdzI4d1cvK3RlNllURTgxNUR0ZHR1Z1NHUGNSaWhrY2VtQU1h?=
 =?utf-8?B?UlEzaDJ5WFRqM3FHMFRIV3Q1b0hGTnE4KzYwUDNDVm5VaTNuYnBrWHk1Z1Z5?=
 =?utf-8?B?bEtZZ2FnWlRjVGdGSDhUZi9NdEZkVm9DNUJGMFFELzlETS9VVmI2MkFSZDFa?=
 =?utf-8?B?alpXM2J6Q3EvRWVvN0pDMm9yaDE4YndIWjMxMHZNY2w5NHZOR29tV29yNjhQ?=
 =?utf-8?B?WTBGZUlyc0s5S1RLUXBpN1B1UGltT3M5blhVYkErS0pRSlJKakI4b01qOGhL?=
 =?utf-8?B?eTdOb3E1SDhURDY0Nll0L1Y5aGNKTWt0WFgxOUZWeklOelFaWldXL3BKU2JG?=
 =?utf-8?B?bjJhL2loUUR3dEJJd3RycWsvdnVrRmJlaVlLTmd3dVpwbkdGdk5BQVNHVHI5?=
 =?utf-8?B?eFA3Qm4xS3RlaTV5OFVSVTBNdmhESDE0aFM3WnBuRzBXeG51RDExeFc3dGl2?=
 =?utf-8?B?b2RrRU1ZaEJmOEFWeUM2R0RqamVkRFZKMkVLRDdrUGhKZk9JWUx5dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df4fc0bb-27b6-4728-0b83-08de8ccb44ee
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 13:09:39.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBummudABaCaG5wce5GYbZQrk+FbgHvZOY0+8ADPrPhOim49h+IdOh6oxaplh17vjhWfCUc3XGAcvgIlXMyixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7245
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

On Fri Mar 27, 2026 at 12:47 AM GMT, Alexandre Courbot wrote:
> On Thu Mar 26, 2026 at 9:03 PM JST, Gary Guo wrote:
>> On Thu Mar 26, 2026 at 4:51 AM GMT, Alexandre Courbot wrote:
>>> On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
>>>> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
>>>>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>>>>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>>>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>>>>>> `driver_read_area` and `driver_write_area` are internal methods th=
at
>>>>>>>> return slices containing the area of the command queue buffer that=
 the
>>>>>>>> driver has exclusive read or write access, respectively.
>>>>>>>>
>>>>>>>> While their returned value is correct and safe to use, internally =
they
>>>>>>>> temporarily create a reference to the whole command-buffer slice,
>>>>>>>> including GSP-owned regions. These regions can change without noti=
ce,
>>>>>>>> and thus creating a slice to them is undefined behavior.
>>>>>>>>
>>>>>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>>>>>> creating slices to valid regions only. It adds unsafe code, but sh=
ould
>>>>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>>>>>
>>>>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue b=
indings and handling")
>>>>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@ker=
nel.org/
>>>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>>>> ---
>>>>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>>>>>> drastically. The logic should remain identical though.
>>>>>>>> ---
>>>>>>>> Changes in v2:
>>>>>>>> - Use `u32_as_usize` consistently.
>>>>>>>> - Reduce the number of `unsafe` blocks by computing the end offset=
 of
>>>>>>>>   the returned slices and creating them at the end, in one step.
>>>>>>>> - Take advantage of the fact that both slices have the same start =
index
>>>>>>>>   regardless of the branch chosen.
>>>>>>>> - Improve safety comments.
>>>>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0=
f9f6e8f3ce3@nvidia.com
>>>>>>>
>>>>>>> Here's the diff that fixes the issue using I/O projection
>>>>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gar=
y@kernel.org/
>>>>>>
>>>>>> Should we apply or drop this patch meanwhile? I/O projections are st=
ill
>>>>>> undergoing review, but I'm fine with dropping it if Danilo thinks we=
 can
>>>>>> live a bit longer with that UB. It's not like the driver is actively
>>>>>> doing anything useful yet anyway.
>>>>>
>>>>> I want to avoid big changes back and forth. We could use raw pointer =
projection
>>>>> today, which could be fairly easy to convert to I/O projection:
>>>>
>>>> Thanks for the diff. I have adapted it to work on top of Danilo's
>>>> suggestion to compute the end indices first as it works just as well a=
nd
>>>> is cleaner. I have been running into a link error with this conversion
>>>> applied though - let's discuss that on v3.
>>>
>>> Mmm, I guess this was because the optimizer could not prove that the
>>> slices were within the bounds of the command queue as the expressions
>>> passed to `ptr::project` were too complex with that version and this
>>> makes the `ProjectIndex` check fail. I have better luck when doing
>>> something closer to the diff you pasted.
>>
>> I'm considering switching the projectiong `[]` syntax to become panickin=
g
>> instead, given that the slicing use case quite often is indeed hard to p=
rove
>> (and also, we already have panicking comments).
>>
>> One option is to just change `[]` to do that, another option is adding a=
 new
>> `[]!` syntax to denote panicking projections. I'm more inclined to just =
the
>> first one to keep consistency with Rust slicing syntax, but the second o=
ne is
>> okay to me too.
>>
>> Thoughts?
>
> If the slice's validity is hard to prove, then the caller should
> probably rework their code towards something simpler (like we did with
> this patch). Allowing a potentially invalid slice to build is just
> inserting a kernel panic mine, and as you might have noticed from LPC I
> am not a huge fan of those. :)
>
> I think hammering the point about slice validity in the documentation
> should be enough. We *want* build to fail if the slice can be invalid.

Given the kernel test robot result showing build errors, I am going to add =
a
panicking variant. For the use case here you don't really want to use falli=
ble
returns (panicking indexing + PANIC comments should be sufficient).

I haven't decided on the syntax yet, I'll put this in the next RfL weekly
meeting agenda to discuss.

Best,
Gary
