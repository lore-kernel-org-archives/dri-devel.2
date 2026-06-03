Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C6DCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B220A112440;
	Wed,  3 Jun 2026 22:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="XiiTiML6";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021085.outbound.protection.outlook.com [52.101.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CB6112440
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTLrjdzNoA/YYwXhV7C1MR3C7R2GWTjjTkiqCGfJjdLNkhX6MsgZNKhFzuhF2Mf04YdSGanzP20paDs0LZRUrtYm/HRuns6SRr1T+MAd5QxrofWrLUNGke6uF2bXmNAegpGGAq9anmqL6kVGNutHignb9E89QRaU9lJtjdsnzlGcduG6+TuxxbbG+YKpE3tLXq7+73xPsAS7meCvdeHI+E+WZvcs2NRnWNrgW4ILQ7xDPZ22h63nKaLl9C62r+KaPCjBwGFzVrfqpOOElegmTvLI7/5lysRfZ9us3x4yMz4eSSgL+dHlS7C3mWZMPROzJiBq0GfOuzMkdNtoEeT6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMIIYJZ7ygbkJh8MrZcNUlfZfmB5tMQii1DbnJe7FDg=;
 b=Z0/gprJaQfsMIP4nesPHRY3ZAVpdf31ZUFLx9Lf5XmdWBd3JBGKqG7DxrwRZbU8NKpWIfHGoaSKjOtCsp1k3DAQwPlGIhxMT7VfP3Ppvdt5GOa88fnZaYzFGozu8jXol7/fUK1ZrM+o2A7kA59DA+U93+7bo4leGgysevMJg7Dp0wZvV8mZuJOAezRuAjBVb6e5abFjZ4dS1HqAgXVpBW2zks8NTQ8LuzJZXNEB1Szeyg4hgN1BPbY9AB2iee8+JaB9/i1kzfrlq7E3YJfYiVYm1WJOl0ADH9FFSIPd3QlOf3ZCw+TLGJ5uHX9QCMdsv5HpEHxZ4IvH4Dp6S2GnrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMIIYJZ7ygbkJh8MrZcNUlfZfmB5tMQii1DbnJe7FDg=;
 b=XiiTiML6JlijSmr/yD1yDpi3GfU6s+87n0drFRUDdhc+ZcePwS9iQ52Zdd8FTUs//9zSL16i3gne42DRIG7V4pwGxC3ixZjpeJbUjzINdZSiXELG/zfugPC6+6aUAhfB1qBZHpcR0rJI5FsRmjnqfsS2qWu+xaz8tr4I3zXhd1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB9268.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:36:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.007; Wed, 3 Jun 2026
 22:36:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 23:36:32 +0100
Message-Id: <DIZRUWI8M0S1.209UW3SKZ53L1@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
X-Mailer: aerc 0.21.0
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org>
 <DIZE54GCJ9MS.DW75EP5OM604@garyguo.net>
 <DIZRLM5N81KS.DIRUHYO435XR@kernel.org>
In-Reply-To: <DIZRLM5N81KS.DIRUHYO435XR@kernel.org>
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: d56a9782-96e8-4b7c-ba01-08dec1c0908c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sDP7t+qwAlFUbdVYJv/e3rFnHBpGSdKkD/YTq7SxZw5NHizG+rddJTjAhuvW6aG7Y3UhjheL0E/NAW0m6nhQ79ynkdQcAx2aPJCUF99w5EqQ/l/MY3Zo/KVbrOBpESl2BqxeCQZUwpp4NqLQTaWoPVa+dbiO9Z83upd2mp1DkCAI0zfENd1I7S59TevsTqPtjN5dyAORklXyh1xsNWTW9NioGoDPC02qcDDqmTRzwdSz/Z1NRLZxeHw79ELfYkIDQriAyWAt/mNJJ5fDXhr9+6xKATC3DAsrwOMGbiGH4SfRlYJkyRYDGorjP67UlkFTgprPV69Jq9fg+bhRfqDW3JCpR5px7vIgAIQbG9Mh+KnFmWjtnzLTItgY8Zw/z6F4vB3oBfLcp0Xvt3ATMedW1elzXaHdFIttMVL9uFZqLsek2BMHJVmHhxrW8IvhYBknXX/SwktP4tM2UXbXJg3zvJf39mpBUJqZP/yqQnPra2jQSymEz2sAb1nRALS1kTlPoZcHkuZuk04a2G4YrB3VVRgwu/zb9jHmXjcKGMKvEXSEI7V8A1GDx0fhbijVIUhhMNK9r9ApEQ7EuT7BrH56Ee739Eg//DAakUHQjCA3bDI2o+L3relg+sfG5lVpQWI+dN0AEfrEMleYoldkkiQJQHs+04jMxrrCa9bpP7dTKsekiuSh2ZlnHInWs6VhwhQU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ryt2MkdhSUUrTTA3blFXck0vc0p1cGFGRXV6MmxUSzFPaDdxZHZlWDEwOFJH?=
 =?utf-8?B?cUUxbFE0SkU2UkpPUXh2WW9DSjR3NCtpdjUyVndDdHNaUlY4T0QrcFdmeHdo?=
 =?utf-8?B?bVZ6d1dtU2htSWh0N3RTWWYvZkNxRXdKb1RncU5PeUVWbjM3UmJXdmxxUXRv?=
 =?utf-8?B?WWVnaU1aNHpqc3VFaGpsek9CWGIyS1pGQno0UG1GUVVXYVRWSGRHZ1UycnNR?=
 =?utf-8?B?Zm0rU1hHS3VRTU1Hdm5IMEZxVVF0ZktpL1I4a2RmOVhkOTVnYmhmYWFpQURJ?=
 =?utf-8?B?cWZYblFDWVI4cVRiUlQ1WkZ5a283Wjd4UzFUc2RQMDFlMTFWZGtLNnVmamJK?=
 =?utf-8?B?MVJaYVRac1pzbUFrcDFvMXY4Y0xPN1NORVB1N3ZsMWZKWThjVm5PSVpSSnp4?=
 =?utf-8?B?YlFncjZOVENydXBjdGphVnNvUmZGU2c2dFcwbHhOL25wV09yR0I0Um1DMmVo?=
 =?utf-8?B?U1pBQnh0bW9XM28xb2VLeTlVUHBoWVJGejBQR0h6NXJ4T1c2TkdHRVRCVE1w?=
 =?utf-8?B?ZUtZR0dKYmZESHRkN0FEVC9ZVGZ1eW1yaDRyVlU4am9PMFloNzU1aDYyT2tS?=
 =?utf-8?B?ejYxQkVzL29yd3FYRlpuZUFSSktWQUhidHdlU1dkK3U3c2IwWWR0TzkvcUFu?=
 =?utf-8?B?V1NCMnZNZTRaZW01L1I2SGhraHdLTEJPODRDUzNiZUhsbDV5TE5hZ25BTk0w?=
 =?utf-8?B?NnRtalgxaDQ3WmF0OTIra2tsSi9kR0ZIZWZEQk9oTTR6VHdqWjZ0SktFdlhV?=
 =?utf-8?B?TU5BTjNlRkxVY3NsSFJVcEJrSU4zeGRhWmJzUFY4VDlYVVZleTdkeTdPQTlM?=
 =?utf-8?B?NFMrZ2hyUFo1MXlySGNjRHhyZDNDNGljdmpjS1RoVW8wdTlJVUZBTHluWkhB?=
 =?utf-8?B?NGRhSFFmNGtFalhQV3RYSUJhOEZ5d3pHM0k4RXNUcHFqL3hBYzd6V2pPTE5s?=
 =?utf-8?B?aXpNY3lnUWw2Z3pWdnFuVzY0Mjg5UDNDNTVUOE5QeFVhb0NLeG1SWUxnMndM?=
 =?utf-8?B?bEMzcU1uMXRabVNrZWF6UXhmSGZMeFNMbTZaRDVtR2UwQWpQQUNTUUNqeHRq?=
 =?utf-8?B?aWhzbjBFcDRFTHhTejVRK2ducC9uVGpNNUdicWFQNDVTeGJEdDlISnpDYWZz?=
 =?utf-8?B?Z3IvbEZXb2t1cWZjUEcyMTFvOUw4SW5wVzhCRHRHbGRuaVFYaVI2d25UNTF4?=
 =?utf-8?B?cWVtdE82cWdTQ2JIL2hoeXpranJ2ZU94TkIyR09SQ0hFbGpDT1hDcWdZSGxl?=
 =?utf-8?B?NFM2cThQQVpQQS9xbnAyTk5rM0ROZjJscXJ4SHhIamRiL3p2R3d4Y1JMS3ZI?=
 =?utf-8?B?MTdmWWJnS21zaWI4a0J1Z1NlOXF3KzlvVkdnaDF5TW9WMGtYZWpPMUdvVk1U?=
 =?utf-8?B?U2k1RUJpM01pby9OWm1mZTE3SFpxZUVnV1RzK21hYUV5LzZqUm1HZTVoejRP?=
 =?utf-8?B?OSttMGdnWEFBZnZaaFJxOW5LZ3RaT2l5RGFEOG4vcWVKSCtPRG9QQ2tSbWJQ?=
 =?utf-8?B?NWZob3l2RmswUEJtamRzOHZrenZtMzdOUkx3ZkZnT011VksxK2ZDd2gxRHJn?=
 =?utf-8?B?MXR1QjNGU1hkUEZIeHczREw0QXNHMURQdW0vemJHTUNhTklzQlpic0JSUVlM?=
 =?utf-8?B?aUpmdFBYeVROM0RaY0tOdUkxZFVPZHl4Zkd3SFFCSEl3UFZQQUhZUWRQUTRP?=
 =?utf-8?B?WjdseU5ZQ3ozemNlc29PNVdXYkJDbURvT1hhSDlkV20vSENiUE8xeU1TdGZO?=
 =?utf-8?B?K3cwM0lSN1pabkw0a0k3ZmhoR0RwZ3pIbEJHbjVIQytUMEk3TDM0NzQzTlFv?=
 =?utf-8?B?OXFGWXNFNm1LUGRESjNXNXRZdVF3QVdEUkVtZ3k2ZzNETjUwS0tDWFJXWUdm?=
 =?utf-8?B?TUZxSzY1bERKd0V5eXZUUXVtQjNDTXRrZXZUOGJhaW10QmhFcWRSL05iOURT?=
 =?utf-8?B?WlJKc01MeWQ1ZXowUmxxZlEyZXF4Tk9zRDQyNFJWbk9rWjliQ1U2SkxtUHJn?=
 =?utf-8?B?TThHc3JaUkpHeENIL2VGdjlIcTFNQ09PeWhPMS9RZHJ2azlReksyV2hFVzUx?=
 =?utf-8?B?eWdEc3U2aDZScklEcEpmQ1NSb0kzbUQvOStXR1ZiOEZPTVRQaU5FV3orSkw2?=
 =?utf-8?B?VFVHR2FZSldVV1ZaaVcxMjBXUW1PYVZqSUJOZDFubmQvYVJiazBLdnRTRHBR?=
 =?utf-8?B?U0JwNHdYV21GbDNjTkExdStVOEtXVC94aUtYdUNVQVhWQ3orcG1oanRwdTls?=
 =?utf-8?B?cUtPSTNmUzNtV1paeEYyb0NlMzFmTS9PVTlaTE8zWEpxUk9DV2dTWDdKdWFY?=
 =?utf-8?B?R3ExWE9vWjNBbUU2VitOR25tZzQwbk5oaVlXZEZnME9ocHJZZjdXMnBZVzBl?=
 =?utf-8?Q?u/falRsNyIw8qfmdbO/duxzByrKxyqiyd8NQy?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a9782-96e8-4b7c-ba01-08dec1c0908c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:36:33.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zU/YXUf4uVrN2MIIN07dJIqX0B8QLyO11MNOjzvi4GbKch/Id/f178iWPWs5b6Jx1ptbl+FqruFKEUs8r3AdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9268
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

On Wed Jun 3, 2026 at 11:24 PM BST, Danilo Krummrich wrote:
> On Wed Jun 3, 2026 at 1:51 PM CEST, Gary Guo wrote:
>>> +    /// Safe variant of [`Registration::new_with_lt()`] for registrati=
on data that does not contain
>>> +    /// borrowed references.
>>> +    pub fn new<E>(
>>
>> This is currently unsound, as leaking the unbind guard also gives out
>> `&Device<Bound>` in addition to the registration data.
>
> For this to be unsound someone would need to be able to move the
> drm::Registration into a context where its Drop runs independently of the=
 driver
> unbind, because otherwise leaking the UnbindGuard would also block driver=
 unbind
> forever and the now unconstraint &Device<Bound> remains valid.
>
> So, I assume you refer to the case where someone calls forget() on the
> drm::Registration that was created without the promise not to do so, i.e.=
 new().

Right, I was indeed thinking about this.

>
>> I think we should just remove the not pass `&Device<Bound>` to ioctl cal=
lbacks.
>> Giving back registration data is sufficient; if a device driver needs
>> `&Device<Bound>` it can just store a reference in its registration data;=
 more
>> commonly I suspect it will just store whatever device resource is needed=
 and
>> doesn't need `&Device<Bound>` (with the introduction of lifetime, we hav=
e much
>> fewer cases that we actually need `&Device<Bound>` and cannot be replace=
d with a
>> direct reference to the device resource).
>>
>> Not passing this bound device allows us to make this safe, and also remo=
ve the
>> need of patch 1 and patch 5.
>
> I follow your reasoning, but not passing T::ParentDevice<Bound> in the io=
ctl
> makes Registration::new() rather pointless on its own; given that it take=
s
> T: 'static you can't store &'a T::ParentDevice<Bound> in the first place.

I suppose you could create a DRM device without it backed by any real hardw=
are
resoruces :)

Joke aside, I think my actual point is that with the current approach, and =
the
fact that `UnbindGuard` serializes with drop of `drm::Registration`,
`&Device<Bound>` is not really inherent to the design anymore. This can fol=
low
the same pattern as other registration data and there's no need to bring
`&Device<Bound>` into the mix.

You might be right the `new` might not be very useful without storing devic=
e
resources; in that case I think you could just remove `new` and have the
`new_with_lt` be the only API.

Best,
Gary
