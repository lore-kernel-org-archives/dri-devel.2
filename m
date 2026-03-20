Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ADB1099B3A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 20:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BC610EBA1;
	Fri, 20 Mar 2026 20:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="wlOQYIOT";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020123.outbound.protection.outlook.com [52.101.195.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A220110EBA1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 20:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF5VfPxxq8BDKpKdHo4MA5QCIrrtqApAwJEddCtO0O1+wseS+PGSH7AKtn+JQiILlVBZFcfhW1znSh8EnJftO/+wNVcg8VpNPng2RboFbun1DiENlDq7V2/aFu2w4pIxvEk8odp2tZbfCDNqx5C2TJjaq5jNjj69jMv4B8Nbkdtse1IVq85EL8Hibab6ZvddPLYUTXHFlwqeJb1xlAWmAQkuZy4K/BsoZnlyXC+Il5LvKwVjfiT7Agw44bRXGkl+N+rdQSM07gCoRf+4j69Nc7t0X/NJFEZTplgij+Nla0darlIlzEW4aSTAo2sGtw+JzSn+t39vWyTyTtnAARr5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHicON2QfLLjEOkeB0LutUyeE8WYglvlJJ7BpnvySAs=;
 b=tQ9NdW7frR7j7BifknXC2k92KoABxvdS6rbT/es8F26uWXifS+Z0SDMA8R3CTURAb7ctz3/aOkisWFtooR7tFvb0t42R41/+EkI9LwSTp9cWpWUtl0ak9MHLqT3clv9PlVkA1aXZ022bsgBE0OI4RHmxDI4axt0+Tu7JvBFgiCPjKapsPtjy/T1lk4a7sAhcD8T6ODmBdSOuLooKvsR92/x7vBNi+A3AJlrMlksxBBcnNulfny3MH0E76/KhwdVyTAsG/EhM/ziljxQyQosEUWDdwtQT3j7wgK5PJTdeQWGyOl1XWQdZwk9ofN2+ZX5RmU9SX4frlGiYSTqfHb7VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHicON2QfLLjEOkeB0LutUyeE8WYglvlJJ7BpnvySAs=;
 b=wlOQYIOTrwSFYKVYpO7y091wiTGNFHkMnKoNY99AGjxUeqQ+5zkokZlSGZJz4SyOWvW4P1wBcVE5sf2ItobsYPEDX1Xs9Me/6kH5DrFsGDZ2zULDl3B1Tct6KUV+d3GcjiVEupxkMgueoLe8XSOc5DgmqLhmQ2im1wcNyIJ/Xeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2638.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:17:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 20:17:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 20:17:44 +0000
Message-Id: <DH7VXRZUH04B.31WHG3DCYBSH9@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
X-Mailer: aerc 0.21.0
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
 <8f9da1e2-fb86-4653-b702-333fc920af58@nvidia.com>
 <ba3c5689-5e34-4097-8823-c37a48a4f358@nvidia.com>
In-Reply-To: <ba3c5689-5e34-4097-8823-c37a48a4f358@nvidia.com>
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd5e0cb-055e-470e-2732-08de86bdbf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: s7YkzdhWc1E03OB7lmsvArQb28L4Nygo6qYMP4kCUn8/fnEVVVcT8bgBTfHzoEjTdinl5t8sjGW/tezyUL7wnyzkDs1CDFEre+Qjv1pPbOui0YwFYFWvfCVRtiJJVZTPnZ3coxvBnju4BbujW0YAPYh/tk8gGx9OssQUZXjqYFOaSVNcZ8vl4OaLuhwTGSv6BTBuYyQ/NmB11VLYgnA1u3SsvuziDuJYBgMtBVzPx+rgdUkc6vBWlEM3GeI5d34cRGnkRsa8IEGJpFXL9RWtl9QUTBsCaC7CMXu73KVdjmnnS4aO48UA3pOPJAi25Chs33aAxzfLW7YsARWc7TbXct0zYnpIi+RnoppYYut7ljj6V5aS53RnzbbJ3mA8YyVtGbVNFTSpw0bPGeg7LZ/LDP4f3741Jh96cGv9gmfQfCfgnsj2XyhOv87AP1Kx/vvSI4on56q7knGANry7N+FgK504CCwcPSxW42dTHJVVqOx8R7PvhScYvxm/LalrusZVTlZlYXh2Emp4GV3stEZd8iLVC+QdPfwgjjQ5y8YDW1hFWUqXH2E9DNn1tuGfSqjsDDu2cqinCnIoH3Vo4X6OGhy1d2tjy60Rgp3rUawilkeo+CegFPi5H/Xp+FzlPG5z/lwA0mZ8j+SqnafCMbcFKqAojjvmiNiXyO4edpNsSnWAGFwb1wcSMX9EzcwmHi/ksCrPLFDUH4adK3eD9nksQyPvoNUfOWj/psQubC87N6cjONwRIxOtXvmzbW+HIfVE8uWQIsdponsyeTpegBE34w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05OVUVVTlNYTGg2Q0RRNEFUelJCRVd5WC9qUkRob2JobURpc0lmSEZSR2JS?=
 =?utf-8?B?bkJ3bWVPVlJwR214YUlXd0poWlpqbGFpeE9YT1pzMTJwbEI4UzcwcnBqRDlh?=
 =?utf-8?B?YjRjeHlpTFZ0SmVFVnN0Nk9LaUJkTFgxVGI3R2dBZzdSRU4yR2k5enhiSDlX?=
 =?utf-8?B?Zi9TT1BCdVBNK2ZrZlhoU014SmpneXZuQkdVKzlLOTVuRzRIRloybU9zaFJw?=
 =?utf-8?B?MEpSNEd2Ly9hR09MNmRFTnFIYmhRNjdOcXhIcCtkYk5XeU1VVWowNjE1STdi?=
 =?utf-8?B?bVRGVGs3Zm16d0c5cGNlTENZRzlyZVdvckx5TmNabFk5dENEWEtReDRkMHhH?=
 =?utf-8?B?RHdobkNJUEhkaXZDbXFucDB1MzVqVFo3amhYYWI5b09sanIzWjlLdmtXbnZ3?=
 =?utf-8?B?UkJVbmJFQ09oOURnL2tXdXFDdFBKZ3FsZlRCVG5RL2hxUjMvdWQ2bWVYNnkv?=
 =?utf-8?B?RWlLZEduRzV6OHEyZmhXSjE0clZqTEJoakxGUEEraGRaeXRpRTNSdUowcFM1?=
 =?utf-8?B?cG5sM1hnamZKeUdidktOanl5d29KTFFrZzRObWN3S1ZLY2grS3dUWjhQcFJs?=
 =?utf-8?B?S2s2M0gzZmUvNWYyRkp0NkxzS2ZKamljd0h0UUNhMzZsbk1lVVUwMGs0ZW1p?=
 =?utf-8?B?cFI3Q2FreVVFUDhGOUJrcUJmTE5leG8yTUNzNFNJdkh3alJqSlRra09TMnV1?=
 =?utf-8?B?Y3k0b2Z5SXYxVGppTEk3YVZIV25BTTlWOTh6TXd1VXFLMmt2RXl6eWozYlJj?=
 =?utf-8?B?dTdkaUVhRm8vZEN6czdKOG9tazZMZFNHajQrT2ZwaTZSWUFIZGREbWhaK0Zy?=
 =?utf-8?B?Yi85L1VaZHlkWXg5TkVzUnQ5YWNWTUQ1eG1Da3Iza3c2bzN6MThBdU5GVk9k?=
 =?utf-8?B?WURDM2kycUVyVG5Tc3VrR1N1dU4rS2VybFNNVkxDeEVYTVNGWjIzQ01CdlM2?=
 =?utf-8?B?MDBTdXdlbFk5d2ZQelpWcmsyNVBVSjM1NGJOQ24vYUJIOFZ4L1RTRVFKeEpX?=
 =?utf-8?B?UUNGNk9OVkdsdDB6Y1V5QnkvTkZrYklPaDJTQmVaVzRQczJCMjRJbHBIVVpl?=
 =?utf-8?B?UzBQUTB5Qm0xTkRVblZubGM3eDhvWHExZ3ZaZS9WVUFGS3ZVK0hoeTAwVGdK?=
 =?utf-8?B?dG9zR3FiVUgxejJDSmZ2TjloU01vTkpOa0R3dHJlaXJFTjZRZUxQMk9USUJn?=
 =?utf-8?B?OUY4SFljYTcyNERTeUhxQXcvUUJpcTJoeUI2VjlreDZFODZ4ZU1HdWdwaVFk?=
 =?utf-8?B?cmUzK2VpQzZVUStONUpySmhDRkpSSjF6ZmowQXNraXhxZXBmbzZBWFlxSVla?=
 =?utf-8?B?Wjd5VVhOSDVUSCtNTm13b05oM1RLdzR5ZHZTTHc1UnhISitFclBkNUo3OEd6?=
 =?utf-8?B?M3I1VlQ5RHQ0U3lMVnJ4THg0RmZOaEdKTVZLMkI1WUxXL2tXdVE4R2U3Lyt2?=
 =?utf-8?B?bnpGWXhzVHlwQWFFaGQvSFgyQkpGTXJWc2lnckdWQTNvcGljcGYvYnl3Wm1w?=
 =?utf-8?B?VmtxY3MxcUJvSC8yOENKV3NaNk51SmFOd3REYmRNVmszQ3RNaVNDYVFyQlMv?=
 =?utf-8?B?ZlZjTi9Ub2tWLzVvT043Y1pxWFFWSVh1bDMrMXFadXhsM2xiSGR3WGVsNHE5?=
 =?utf-8?B?TUJ0dW1tWTN4ZVJCUUNkVjZKY1VJNTE1azZXQktlUFJFb1JocTd0MDVaRGFC?=
 =?utf-8?B?WlJIa0t2dXJtMmFoeTdMSW9WUlc4N1JPSWQ2VnhmS0pyb2RPNUtzMWl2eVc3?=
 =?utf-8?B?WjV1WE1FbDVDRHB0V2RnZzdzbWhwWWhqWXpWV29QZGZSRG5WTVVua2pSSWpr?=
 =?utf-8?B?QWhYNHcrem5kT2lVMUlOQWFRM1duRWVJbVZ4MSt6dk03TE1xMEk2M09tZDhN?=
 =?utf-8?B?d3hxd3B2Yk9TZFNxa1pwMS84a2Z4eXIrOXozSC9ldk5jOGNTaE45bEhqckNF?=
 =?utf-8?B?WkNzS2tXN0xEM3diTEw2UFlPa3NjZW9ZeDdHNWpoM3VNTFBINjBqVnpBajBP?=
 =?utf-8?B?dnZxSFFXbWtxeThmRnJrSEpxQXNSeTZuM0l5U2ZSd1FtMUxCNm03MVAwR25k?=
 =?utf-8?B?TGlxYnFqYjkvUDgyUDV5NUYwQXdCT3V6Mnl6WEVmR0VJRGFRNXB6R3lLakxW?=
 =?utf-8?B?dGhJY0ZuY1E1TVY4SWVmZDVKUUxhbW5KbnVqaWU2bDZoY2xleEsvRzBQVndW?=
 =?utf-8?B?bnhmam4xZ2FKcXZrTEhIN2NZdWhUem4xOVRmOGgwZzhqUnlIQTZWUUMwdjMz?=
 =?utf-8?B?Y2cvbGc4czkrRVI3YWRLUUhXS05PdzdaeGpzdE9QRGRDaEJNQmsxdmFXL3E5?=
 =?utf-8?B?UXIvenFGclNIaXlLOXNDa3ljYnpVR1VOWjBOQ21wUlN2QS8zTXVMQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd5e0cb-055e-470e-2732-08de86bdbf65
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:17:45.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9fgOgEJQLvKcsuEOnxWkpbkdKrcBKpORejsFaeeP23SJN5eKI+UsJWMgAji+qSKMojdOF9gVc0wBDdppHqFfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2638
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

On Fri Mar 20, 2026 at 7:52 PM GMT, John Hubbard wrote:
> On 3/20/26 10:38 AM, Joel Fernandes wrote:
>> Hi Alex,
>>=20
>> On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
>>>      /// Reset the controller, select the falcon core, and wait for mem=
ory scrubbing to complete.
>>> @@ -616,9 +462,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>>          self.hal.select_core(self, bar)?;
>>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>>> =20
>>> -        regs::NV_PFALCON_FALCON_RM::default()
>>> -            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>> -            .write(bar, &E::ID);
>>> +        bar.write(
>>> +            WithBase::of::<E>(),
>>> +            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOO=
T_0).into_raw()),
>>> +        );
>>> =20
>>=20
>> Overall, I think the series is good improvement but I still feel this pa=
rt is a
>> step back in readability, and we should come up with something better. I=
 don't
>> think there's any chance anyone can memorize this syntax.
>
> I must reluctantly (because I know this conversation has gone very
> long, across so many versions) agree. That .write() statement is just
> brutal, and we will be relying on AI in order to even figure it out,
> I fear.
>
> I'd hoped that there were other, simpler forms to express this,
> is that not the case here?

It's on my radar to integrate `register!` and I/O projection (but of course=
, I
need to ship I/O projection first) to solve the relative register issue.

The idea is that instead of having an operation with all of `bar`, `E` and
`NV_PFALCON_FALCON_RM`, you first use projection (with a surface syntax tha=
t I
haven't considered yet) to go from `bar` to `View<'_, .., .E>` and then you=
r
relative register becomes just a normal register on it.

Best,
Gary


>
> thanks,

