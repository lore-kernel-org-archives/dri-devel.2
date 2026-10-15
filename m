Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E180CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D2B10EC02;
	Thu, 15 Oct 2026 13:38:42 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3475010EC02;
 Thu, 15 Oct 2026 13:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkWBCvLH51LhqmHEzUXw75+YOKAWw4B8GAwpiJpDg2z/VzY7HagclOKqtcpwR+v1RLuRps8x+SssW1FXxwB8mA1GNuJ9BMAY3m0os3G6jk1NF1MxOQ4DRWkiOCLDU7TuhoIDZ4RgHtLFWR8HntWvt3ph7kQF0foBgEilyV1r/NxYdNNiaF7Z6Jl85/RKNjOpMJq+l0qItL+nQqZ3O+aHSgEY44zyfetd5H9WBCc1OSmM6NC67jESHGy4NGoKSpKqDvTOij38E/J9SFDbTuU4XHchefo0NITEWdO+EcOF+4ySCVpLUrHBKWp2mWxZHFR9HV708AnSw/ycqAKCexnzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtpAdB3Z6pssCoq0AkTN/cuFzgh3egEef4p/QXLb//g=;
 b=FK9bHjZF7ZEO7gMnS7pP7/IX6mZTZh2+jvCNpiOFnjJzM6P6kAbwjjArae6Mu9Lu9Kzt3IkyEYKpyZN5NZZTXNDPBU/VMbKmDHaBONrUKimZtPfLEjPjXDZ2pEeK99YN5sHD2IQiqkl/1xSYzQzjuSGQ1qp9YwOweO5KByzanfRDcT/oUg7ulLqaYlcg058SegLsMhg0c/aj0OpF1zckmHNwzkesBAsPxvj7+p0s6d0zMsAQ7o31+GHVKK0ijCdkBMLlBbT+33ALReeONxYVX6s8/zk72BURWUem1TQR09pZJEldcW+47iJYVBYZDfw+EinUl0fP9zzgJMu60UPiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtpAdB3Z6pssCoq0AkTN/cuFzgh3egEef4p/QXLb//g=;
 b=tx/NC0pO/oDgOn7935AP3TfJOwoZamqWX7uQ7tROwqxsFD30Bg+wmD+k6YUgDT+g5/pmselIkaUyDp0u3/g0t3rtyseLqmyg/LUZmd7rQZBCHj80e3t1+vMaTJwPq4Bmk/0gmnwFzH5SAAqLHxTMkHf0SrfmxPaqr4Q/s9HWyejYOjVAb/7zcMjlstsk6eyuocutIZ3NvlIemKmpkouqmUFfa+cB9AyVOe8BZ5ZaGf8ecBuh8hL3+UqPJzzAqPuHrMgYvk7e3+Ikij5KLSUqNAkZRO+2lUUacavizG8HvHicJzUQUZntR3CP3CmITo/YFN4h11Dhq1dvnFnXm/e2hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 13:38:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:38:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 22:38:27 +0900
Message-Id: <DM5GBX7ULZFR.2TT17DYNN2UCL@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 06/10] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
 <DM46C72WC4G9.FRMU9QSIS1SE@nvidia.com>
In-Reply-To: <DM46C72WC4G9.FRMU9QSIS1SE@nvidia.com>
X-ClientProxiedBy: OSTPR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:604:221::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0925b-53ca-41ca-d7d3-08df2ac19991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BthE8F5kkeMU4qXkEZw6EOabRXzjQcFXdghEU9kOHr6EefKO0dF7T8mrPd/AWcRbAH872KE5LhdJ3yIurRRl6CksJI5+1eV0Q1hFoZZbwmc1IhyBCMXSJ6GVFuKqzR5iNghTyJA2xEWCOzIX7cc/xwYP6WZiOhnMj8nABC2KkDFBr5Yxx4HFVKbLmz2T9teiOHnLFtSdTCJaUnxZYbSq1VRh3NE/URm9PDb4TFS324Xd5xNEnen79FvTK3TrsLPD8dJBoQWFpkATDBX9KG0i6pOazfI9LZJX67Di3Hsegm+a5EaGnqEtLRNys7APxAshn8sh4DiS1ILyw/aZZ995dx6IsQnDzY4PgfMPHeQ/dMzU1LEX9HGEoujvuZkpFlavpDkxSZv9QX+PYhyvzqP+HGXGnTe85Wr1pOGXqmnaHerY3ASKZUvj0Psyqim1v0vYmw/TqTfH6KOOtcluuapQTjGXGn9Fd8Un5FO2NNyXexMJY4w5Mtxt6CFHEUZzsyZ2LAx4pYdHjGfK04BHz/rJY/kNxe+KMghi2H7YzI648fJt4rXCc4FPQZ05C9kHNSe89aPM/f9pDttAqR1mvc++wvYEu8UJpfSm3nI9Y8CWfXhN6VSFHq9lVIKjQK5aSRkBy5Yc4B38lbXjADzLkZqpwEyxBxhzRvdLm6Nj/AHeQwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JnTUZvcnNHZEJsMXcrUGZLNHFuVS9uQUUxOW5iMXRGS3FneU93MlcrNktm?=
 =?utf-8?B?d2JWT1BaUVlTcFlHQnVzTUZhQmRWdkkvVE9NZEsvZWVydHd5UkpYV2VTaitz?=
 =?utf-8?B?TlYrNVVHeGgvekFXUFdNcms1T0xhOEdiR0Z3ODNrRm5qcUxTdVBEdi84ajhv?=
 =?utf-8?B?UUM2WWNTdXFLd1RoNzVmazZXWmtUVzJHVHlYSHpSVWhXRituK3VTNnYyOVdj?=
 =?utf-8?B?THhVUG41elQwam02ZnRsMm9JdzFsUGlkNEhZYmNNTGFhTXdYTGZySXhPMDVZ?=
 =?utf-8?B?RStaT0tHeTBGdHFjT3NXWlcxUC91OGdnOUJibVhIZHIrODFFWUYwOVhUVTB6?=
 =?utf-8?B?cDUxZzJMcWZFeEh2TnJ3UStSYjJobnQyR2ltWDNKcXZFaFFzVnJqZjZTbTFG?=
 =?utf-8?B?cTY3R1R1YVYyV3o1dGl2QTRhZVp1S0drVktINUl6K01ldG9OOXNJZzMzYU1x?=
 =?utf-8?B?eXc1RVMwRE9tS0NORnF5NDEvZHIzYUtZaVlKWkxGczVsWFl3aFVkQklZUENF?=
 =?utf-8?B?cTlsVDFEU3laK0J6dlRLSDVlZDlZWkNHazFKSTlUUDloMXVVNForTm5nMXFF?=
 =?utf-8?B?MUNKWXR1YWs0d1A0cG1memZKOVhmMWt3eGp2TU1Ba0xSRGNaUllMTkQ4UzFX?=
 =?utf-8?B?aGRIbGwxSWFzR2Z1NHRKbDg3T0dkSzlrVHNlUnZHODN6MmE0Q0c4L0h3bC9U?=
 =?utf-8?B?dE0vUE9QRjlEZlpuRlJkWWFGZ3Y0SUJmeEM1Tm1KM3dBZGJsOHM0OXRwZ2pi?=
 =?utf-8?B?TzZZbnNmNnlUYmt2NjJXS2dNcGtRSEg2dGFTbytyTHJhTXpPUlJ2OHFYSVR3?=
 =?utf-8?B?NXVRSngvU0JvSUJOaWhoMXJxamhwOFV4ZlRGMHo5UGVENng4dVBrTkxNNHA3?=
 =?utf-8?B?R3V5RGRWZ2xmWWc2Z0pPbVA5MFRianFjdkkxeG8waWRGbFZkQTJDQzIyamNn?=
 =?utf-8?B?YWJSQjcvWlB6TGVScFgvOTBET05VM3Vib0VBMy9SdWZ2SXN1WGY1d0RhcytZ?=
 =?utf-8?B?QW0xWjhhQmpEbG15QmU2anpycUlwVDhibnZVQTQ0SHFUZk9yNWUzMExiY1gw?=
 =?utf-8?B?dmFNWkFTdzJaaXN3eWt4Vk5iOVgzYmQ3WTV0OGxWaE1scTBXeGNXM2FtaVpw?=
 =?utf-8?B?enV6N2hkdFZRU3pyMW5NaDdEejk2YnBjc05QckgyZEVOME1kZmh3SXlXT01I?=
 =?utf-8?B?L3d0c0tZaUN6RnVBM2tSQldkVVc0WG9QbkV2cUhjRG5uNU42UnZKYlFLMlYx?=
 =?utf-8?B?MnVPT1JjR0wrMjNWQVlhdXpEek43VEVEaDZsSk1sZDUzV3Jxcit2WGxGY0NZ?=
 =?utf-8?B?d2RNcjNHb2xWcnRrcnFqYWdDQ0Fhdk1jaHl5ZktGMzkrd0xlL1hHaXNHdGx4?=
 =?utf-8?B?QmNSMnJLRWs5cDFjZE9DV0JXM0Q0U2c4aGlBV3FLa0NjaFQvVVJiUWM4STVF?=
 =?utf-8?B?bzk5cjFYcFRIcWZoSXpmODZBNytRRUlUaUJyUEVrMzgybWtpaWdsR0JmcHMx?=
 =?utf-8?B?S1hsbkRLTXBOVmJrNTh2cS83T1lydGxZM0liRnUyWG8yMTRHK3NIeWlXL1hn?=
 =?utf-8?B?cW5nVTlZcEhiZzY0N0pqVVVsRktmaUNvUU45NHBVTHE1SkNvbDRLQlZMeVc4?=
 =?utf-8?B?V2ZuSzZ1SUdEaG1wWWI5ZTZZa2ZYeW5UeVQ4NlhMNDMrQzE0QkZwVWw1NDhk?=
 =?utf-8?B?dlBiVFcyQ3AvRWViR05rNFVuZnZwc1lGamg0WHRPODVkUEU2cG1jVmIwZW1V?=
 =?utf-8?B?ZkpCd0FCY0hJWFIyTTY3NjBYU3M4a3duOC9HdzArSGZIek9manY0S1FVazlS?=
 =?utf-8?B?RlA1MnI1SFlML2xSSml6eDVpNXVlTHlhSjZ5aDhMRWxja1E2Yy8xYUVNQjZI?=
 =?utf-8?B?cU5kVEpLSEV1UFRYc3NIVHJYUnNYSWRsVmxRNkxXcW0zNEZuRjZaK05aN3Bz?=
 =?utf-8?B?anZpZ3pHVzBUUStSMXBpb2lnN3o1S2QxYnlOZUlJdlh2TXZ1VFZZL2JweUM3?=
 =?utf-8?B?aElXV01Ca1pUQ1ErZzhCTFhURExQalZSWG1YaGJCdkljUk9FWFJyNktaR2xP?=
 =?utf-8?B?T2VXdndPdE83aUhmcXc5citMMXRlUjV6N3VuRWIvTG1QRHRjRUptY0lwMDhj?=
 =?utf-8?B?NG1zcmx3OGxsdm0xcTVrZ0RiVTcwdmJGTEw3bkZlSkg0cndPTHNGN0tWMldr?=
 =?utf-8?B?Y0tOVnphSW5GSVpIbGZQSGhwZHc2bHE4NkJFVDFEbWUxR3NkS1pxNVBLTTJy?=
 =?utf-8?B?dTVITFRWT3BZbXVQN1hMWVNjSXNwckJhdVhWdGhwNWpZMnNiOUVrbEQ0VUli?=
 =?utf-8?B?bWJDYVhpbFE1ZnFqa3V2UmVnbXIyOGYxYjRQQko2UkFhQWw5enpmMG9YckZh?=
 =?utf-8?Q?QaxKLdQDDw3KgqMEjMV43TATdm6sE3urDHR8+R0HD9WHq?=
X-MS-Exchange-AntiSpam-MessageData-1: GuFMjXy/ICBNyg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0925b-53ca-41ca-d7d3-08df2ac19991
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:38:30.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZybrXZoqH8Z6cqm0NfvNZ36VzzwXEjy1uALYLAty65oy5Xg+pquVcmrVeynVZ3Lh/CACGyI/4io79x1JEkkU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

On Wed Oct 14, 2026 at 10:35 AM JST, Eliot Courtney wrote:
> On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
>> The `RpcMessage` type is the right container for the `log_event` method,
>> since it contains all the data we passed to it. Move it there so callers
>> don't need to extract the required data themselves.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
> [...]
>> -            let function =3D rpc_msg.header.function();
>> -            let seq =3D rpc_msg.header.sequence();
>> +
>> +            RpcMessage::parse(self.dev, msg)?.log(self.dev);
>
> nit: in core/interrupts.rst we say:
>
> ``` A drain fails when a message's framing or checksum is bad (see
> "Draining the GSP-to-CPU queue"). The message stays at the queue head,
> so every later drain would fail the same way, and the IRQ thread
> disables vector 155 and logs the failure, which leaves the queue
> unserviced until the device is reset. ```
>
> So `parse()?` returning early on failure here is intentional, but I
> reckon it is worth a comment, especially since the behaviour is
> different to the semantics for consuming elements regularly (still
> consumes and progresses for failed elements). Especially since you
> wouldn't expect this behaviour to differ for a method which explicitly
> "consumes every message the queue holds".

Sure, I'll add a comment.

>
> It looks like this is acting as some kind of implicit poisoning.

Indeed, and things will look better once we add the proper poisoning
container (after r000 to keep things smooth).

