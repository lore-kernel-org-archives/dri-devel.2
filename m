Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9433C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B6610E533;
	Tue, 28 Jul 2026 07:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJE5l2Mb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF0C10E533;
 Tue, 28 Jul 2026 07:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcEQZ480Ovu768tD+kVOvzkHPtjeW9qMGGZhPCtAuHOj16iI1WZ9Z7rGCKOp8Pgqe1vrJPPEwLB8Ylz0WRYmG42DfkZb16ItjlbipzBCm9jqjSCpGL1/Xup1OzIPfSv0N/c+1oSPIJDN3DiB6/Gl5IUUErRcjI7MN2hEt+B85bbthH7xYmZOzAFvXkcfXNsPkXePZhTU/1IrKh3wMTXmOtt/tmpmH2YtA3YGTR9JamgMpe/IlTVfoRwRdOuvCGif9dFmznhO5MjnCdH3mFgMewOgpnk4ZwqxYG7Y8GqZRBOwWmlr3p0JTM5Li5zVFJ6uwZsIxH0mq8X/mLu1/1KjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFveVzfb5M2x2bukU/X85JKodxxFdue657sObs18Mj8=;
 b=ggBB/ip7zuMfVDKKcuXTN9uDnAJNyzBhs71zG1xFshpX9T2EU4Tk9rzYhVOpVUktqkV2Rs2m4CYiZEEdwVO9Jf1zxZeMuWZ4ry1ZlXAvvfzHLLftDxOTatBrW1cKJCyPly1Lx4ZMqurAyxwh81eE8BWTR5/Ay/IBRQJHzAB0sWvBb40xiAySJyI9IzP9uvNXQ9TQ+gAFMMmRxZicybMVXGJP/RqHfvvgQYAGt4jXpuNBjzoMpaMGjvfjXAP3CMfoZy6GoO0eClso/4F10CdLUMl8nFZcAZulAeJxwJn1sKjhKAvacgVOwSXl6L300bgJgAjjJW83qHwvFcQoMn8SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFveVzfb5M2x2bukU/X85JKodxxFdue657sObs18Mj8=;
 b=UJE5l2Mb/cp0mduvL1cauhUQPlO9p8W5KG0h7PRY+dmifma9ZrYefFNt4f66VH4dgd/q7xh8e+gGN7LjYGCbKgxvWCiYQ190w71IMh3cYWORwMM95Oayn0Xgt3Cdu9tLvVMsG24tkbriLK0pmEWpsgnOfOGGSK/2pIvT4r9KcJ4u91bXbN0uHduZ1Fm2Sy8uF88Zp0tW9p+Jx2+T1NC4dHL+FiAhvkv5e/BtMaMmEQMnd2mX4FKlIpWNid25EP6vcm/jp56FgLG5QQHyVlisuLIM/x2ccugSRma3B8rxBaxlNox9fq9ZsFX8K0IGe77T99KbV+PxSwUJ723jYha7ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 07:29:28 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 07:29:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 16:29:24 +0900
Message-Id: <DKA10BN3PYYU.WC5VTPHPZL5J@nvidia.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Alistair Popple" <apopple@nvidia.com>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "gary@garyguo.net" <gary@garyguo.net>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "lossin@kernel.org" <lossin@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "dakr@kernel.org"
 <dakr@kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
 <ae14f443778ebcee56e89a72441f3252fc020b96.camel@nvidia.com>
In-Reply-To: <ae14f443778ebcee56e89a72441f3252fc020b96.camel@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::21) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7addc437-e264-47c0-32bf-08deec79f52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7416014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9OGwemnULO0m5srKRds1Pl5DLNjfkobNo9VZxUcHlYh5jGDFd8MRomdD/6YaaYKlDzBKKZP47PivAkVItojsPOdzop1V1nS0zFF+f4Mh414l9BFzQ1rbxaQPhV6YwXgV+FtKnnO7VOhL+Qxnj3vf8XaUNQV6oWrqe541jZUyWBNwWBQ6k84AxvVvQH9RimZjPHweKJDuVrkfwJeLRj/klQJ/3HlDmMlO1tGJSCUIkvnfV/jcx5wOHY/nCIKqE5PQi3YQj/XVF1MUL3zNI4J3dKe6Cyl+zHVR7uFXxs1m4HoBGMVLmxAzcXH+Fclnk/OaiFuhm/MFF7S48Aqy1sdBNNhqTFX+725XWjc6LOWu6kUUL2f6ryXQyG/IDbFp9X103CTM/WcZ8uN+XhUAFOeiWmUM43SemVs1OBWtOyDEA4Y1J1WNlhfA8jxEVhcQBrJ8iyapA7k9LZvk1ystiRCn9Cv/N6kKGv8Dget4Jhq+86BSttNGnAPVwdfWcRFk/hFrjYKJ7maG9n2z2aFZIcEcUuDlZoNsZqy98jEI8LhvTAK5mmSfCzUJ669Z3EXBGnppws1FzyKnEUWxAWb5ES3hE47lKIzT4cblkhoh61skKiWXA9m2h9S08Y6syanU6N5vBZjdUabOt9h5lPNcIoPkvsjAUGxL/1/VjcvdCSSvn70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRHdjFtbTFyb00yUlRwUzFvZGIwR0hPNzRZMXRwbW5mQ085MXg2MWZ2Nyti?=
 =?utf-8?B?TGh5dzhZT0lkeDNnLzh6aG9FMDl2dVVxc1J1TE0vZkszK2J0RzBoWUF5cmlG?=
 =?utf-8?B?ZzhHNGhYUUx0S0QybHpoNVo3d2czcGd1QWxMRmM5SXRwWWRjUG5JYmEwamF4?=
 =?utf-8?B?R01xOWNQcHlaSFdtaENWT01SYUEySytpS0RLeU9SVHlqeERXS1VLbTFNNnVG?=
 =?utf-8?B?aXRObjd4ZXR2SGtOZ0F2UVIvYVR3YTZNYmk5cS9oeXdYbUJSeTk5UXNJd1My?=
 =?utf-8?B?dGpIQmR0a3Z5RUV3S1Q4VDhidG1uNlhyQzdNRkV0NjBKeExwd3hVdHJ0QW9M?=
 =?utf-8?B?R0h1T2J4TmNJTksvay9BZHVkQnU2U1EvZ2hUdnFma0RIRkpGamJvQU1lOVJO?=
 =?utf-8?B?YUxHL3BrVVVVS085SUJDTzJZenBPNEY1R1krQXR4SGlyWnlvMmtrM3hpeTlq?=
 =?utf-8?B?Y20vNEt1dHI2TThaL2g1K2cyMkFKcWl4dmdaa2Q2a0ZoMWRKL2Z3MWVWQ3E2?=
 =?utf-8?B?V1ZUdTl4VmFNSUxwcGZJWUQ1TlRianBaSWhPWW5jL2IvYzJBdERMNUFvMEZp?=
 =?utf-8?B?V2JsOFRBZFA0RTlidkFGSTVvQi9xRVlhR1p4SDM3KzFqVWI4aTc5a0dNTUpE?=
 =?utf-8?B?NzdDTFY3aUl5WktDSTJseHg2NmU2b1dIa0hMbDdrRXZnS25jNzM4S2sxbnRG?=
 =?utf-8?B?WkUvd3JCS2p0T1UzbE1FRndTYjlsdXRTaWMxWUExZ2VaUzhpVE1PaC9GanNE?=
 =?utf-8?B?a25CbjVZWVYyUEY5a2R3eVhKOWVPVUlkS1FkTitEQWpjSjB4VkZZRVQraXdZ?=
 =?utf-8?B?SEZ0Qm9iMXlWMzRWQWdrQnp6OSsyMGdUVjY5cS9tUWVkUStDVXptL2JRS1li?=
 =?utf-8?B?WnRtS1MxWmE4akFuZ05xbndUQzZocVNOM0xNNnppQWlVWldpUGpyR3l5bEhl?=
 =?utf-8?B?Q291OTBROUh1eDdCL2UxaHpaQkI0OGsxazFaNzdOcWdLYnpDWTNIRGtpbWJ2?=
 =?utf-8?B?cTFSd2dzR1pLTGU1bGNBem05cUNhRndCZ3Zkdjc4VXZEVVd2MDFaN0Y3NFgy?=
 =?utf-8?B?MnQvWWFZTkNiNk9Rb09LclVON25USTIzR2pIcnUzL0lYSjkzamJ2Sm9EN2hi?=
 =?utf-8?B?a1lOaU9zS1V0VHM4RWRTNjVkK3BBZENNYmwzakNpQUJsc2NaWHNIdkhhY0NC?=
 =?utf-8?B?emtpUEp4YnBMR3I5d0R3cUc5WGtoR0JKalNGS1pUVVgxU1dQQTF2aWpZMU5y?=
 =?utf-8?B?MTV5alNuRGVYOE5TdnNCRGhlMzJrOHJmbS9wdEJ1WWY0dDFzN0ZCdm5CNDBn?=
 =?utf-8?B?THk0SG1sZ2lIYitBT1hBUmdKRUdSRnVmdDNDUlpXSHZSRGJabnFSR3VPczFN?=
 =?utf-8?B?QTJDdXhIUm10bzFzTU9RblhhRHlDYkRJQzNFdjhvV2dvWGN2UksybDRlRk1o?=
 =?utf-8?B?MENlTmVTaURXNFA0bFVCSnJ6SUVWVkFFSFVNOFJFeTl4T3haZ0NqUVloZTlE?=
 =?utf-8?B?SUlBNkJiLzk4Q0t6RHdRQXE4Rmx1NS9iM3JqUUZzcDN0UmpvYzloSkV2Vmla?=
 =?utf-8?B?SEdFUDcraHNPMW81Z0Vrd3dGTzFpQlUvTXVlbDJJWWdyUHlTT2RSTVJvZTFS?=
 =?utf-8?B?SUNvWmJCVFl6b3Z3KzRrOGg5TS84M3BQUkh4eU1DK0dLaFl1RXNRc0V3QkdS?=
 =?utf-8?B?L2dFSmczcVBoUjc5U1BqdFRzeGFyWFVpaElqQjJNdjJDUnFpWWtqSXkxbWxr?=
 =?utf-8?B?ZDQrZGJmdE8vSVVUY2RZaUo3VUxmV0UyTTJnV3RnaFNSSXcvODV2R2taN3hq?=
 =?utf-8?B?WUhhOVE1ellCazBpd2l3STlNQk8relF5RUV2V3RmeDZnTkZXeG5tK295c3lp?=
 =?utf-8?B?WE56SllEZHVvRjFVc1BBWVpabkdLQWlDV0Fnbk1qNFJ2dEM5Qk9YbWF0SGF6?=
 =?utf-8?B?OVhOWDBGdGQ0K1Q1aTYrR1VHZG9CSlhBbkRheVFleXpuSXhzaUVwc1ZSdzI4?=
 =?utf-8?B?S3pLTkZvM0p6R2ZzZ1dQVFhkcnMyTG1GaHBmMmJPOFBFd0l3Tm5zcEdhSVVj?=
 =?utf-8?B?ZWdtR2ZzSFowS1dNSVg1aDhucG56VmIwQXAydHZMV1J4S0djM0JoMDdFcGti?=
 =?utf-8?B?cDZPVTNvWGpRejlxWW1WVkMxY0ZJRDh5NUNDcmpwblFZY2VueEJzc2lCbjFa?=
 =?utf-8?B?TmpoaXhtWUxNZ1VuQmI5bG9VOHVma0hDQjA5bVJjU1BEdTJ3azF3dFpPMDFB?=
 =?utf-8?B?dzNEZUFvaGNqUGpWS1MvRW54NlhlYkxtMlRXVHJ5bk4yMzRWbUd1V1l1dU5X?=
 =?utf-8?B?TjJ1TzVGSlpiNU81ZUpqSDhxd01UbXVWb1VPYk9ybWtEMjYvSE11N2dIZzZk?=
 =?utf-8?Q?zoFUTtcFMFDDFCI0/d/uyR8Pf+229wp+biFlCPnsBR6lZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 7XClQ2vvYhna+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7addc437-e264-47c0-32bf-08deec79f52c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 07:29:28.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsdF5fOMOQoJAm/tyqt2ohd6oH6bye1OfN0BOZNzeS6vMpgZJiaXQ0GHpK4Gc62Ai+uaSZ3aF4Ds/0q4bq3DeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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

On Sat Jul 25, 2026 at 1:52 AM JST, Timur Tabi wrote:
> On Fri, 2026-07-24 at 15:56 +0900, Eliot Courtney wrote:
>> +++ b/drivers/gpu/nova-core/fsp/hal.rs
>> @@ -19,6 +19,10 @@ pub(super) trait FspHal {
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 /// Returns the FSP Chain of Trust protocol ver=
sion this chipset advertises.
>> =C2=A0=C2=A0=C2=A0=C2=A0 fn cot_version(&self) -> u16;
>> +
>> +=C2=A0=C2=A0=C2=A0 // TODO: consider moving this into the TLV firmware =
metadata when ready
>> +=C2=A0=C2=A0=C2=A0 /// Returns the size reserved at the end of the fram=
ebuffer, in bytes.
>> +=C2=A0=C2=A0=C2=A0 fn fb_end_reserved_size(&self) -> u32;
>
> Do you know where in OpenRM this value is encoded?
>
> There are quite a few places in the code, especially for GA100 stuff, tha=
t are arbitrary and GPU-
> specific.  Without a means to scrape that data from the OpenRM source, it=
 will be impossible for the
> script to obtain the values.

Yerp, for before blackwell it's here [1]. For blackwell it's here [2].
According to [3] it seems to be able to vary based on openrm version and
it's required to boot GSP, so that's why I think TLV is a good spot for
it.

[1]: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/452cec62d827034=
798072827d3866d1881662b77/src/nvidia/src/kernel/gpu/mem_mgr/arch/maxwell/me=
m_mgr_gm107.c#L1829
[2]: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/452cec62d827034=
798072827d3866d1881662b77/src/nvidia/src/kernel/gpu/mem_mgr/arch/blackwell/=
mem_mgr_gb100.c#L64
[3]: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/452cec62d827034=
798072827d3866d1881662b77/src/nvidia/src/kernel/gpu/fsp/arch/hopper/kern_fs=
p_gh100.c#L1399
