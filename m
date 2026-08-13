Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE24BC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CAD10F21B;
	Thu, 13 Aug 2026 19:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="fUagsPbb";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022086.outbound.protection.outlook.com [52.101.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8748710F21B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 19:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyTHb4yuvoq64akr/2t+XgcuSO2Kx8Av8d5l67o36PaBaQBGWhpU8DVeCnMRtfDA1qj5IU8mCHxXiBQ4Mw8o62X1b1dMHwRibkPx+1pHyzHCZgRJhaWcW486M8DrtqyAARXE/x/OQuP9DqpIneqbg5MhNTM9W2EgmlE1xa4nwxrj4jarHDF6g/os4DmvHij/pMtcKx1GlRlSNY9cs9wocy4NqGDOEhN5ebDO8lt/aTqHai0NvPciddx4qFhYP7JDEHQoagGEk6WQT/e1MVBFYYpon7UEuCvUy5AdDmieCvBRKncvCfn7nk7wn0nZ12ouZaRjewpgiIzrz6LBg5m3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAcowo+ScUf+VT0uwARxmMA6Z0JV5pWYx2sw6joaYao=;
 b=yUlIK82EkRgRmBKiIQKn78v6VqYH5D706s73v0v564H8DVUnFssJUdEXV4z4NG9F38GJ6FsYbKSAYtDuSNmIEUjekVCF3SX3EGGTs33MLTkDQyMB4GEO8sBJSuhU1H/UIa9BO5ZGgSA0BTPXFdiQpT8zE0CwaMoOYeyf0yAqfsXtsCH7eC3iz+8ORT2SkLbFS2mPCR9cEwOVlbChIQ2aR+QM2GpV/2PJMfeFjAz97659NTBYOmjL9StC7wUzKXn4tTroMUyMyBN/WJ0XCBrADxhVpiNdzaghnJLyWxNnyAyeBN96CySS6Hn7QjVbyDrIkYDt57QevWGZsLH4oIgmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAcowo+ScUf+VT0uwARxmMA6Z0JV5pWYx2sw6joaYao=;
 b=fUagsPbb/Czjl2DVZteP4YPlRGjrr1xZV8KxHwGln6RXsHP6sS4h5LxYDZXIubYTfeeVBbydt183Xg2ES+MR34k1gGqtP73wbzKdAoO7O5dEwEoGZ5NFhtCW64cMWEYLzWgDVyGPGV5Y8v2DRPZDUoHgjCMUP4l58Ed5qv5zI3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7221.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:58:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:58:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 20:58:42 +0100
Message-Id: <DKO2YQVU889X.3BX9MWOBCQ4F2@garyguo.net>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Vladislav Zaharov"
 <vladazaharova2018@gmail.com>, <dakr@kernel.org>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
 <20260813055044.98486-1-vladazaharova2018@gmail.com>
 <439f1fac-0745-45b1-a6e4-5c6fbcc32ee9@nvidia.com>
In-Reply-To: <439f1fac-0745-45b1-a6e4-5c6fbcc32ee9@nvidia.com>
X-ClientProxiedBy: LO3P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::21) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 84817aaf-9cb0-410b-82db-08def975471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Eauorypx5TW3KbGrmTQ8o9Cs2z70y+hHuEdautJgEs2o/LJdZA7oDku4uowNSPo+RFtUn1QrPLHF14M5dLfUaeYkc6ZZBtbpMVo37uEAAzQL2HLFWcXrs2zA01qvYkn9OYg2Z/xduNSQmkO1rGzauNx3Wy7GHx6PyZ4z2SaNVMTWfnc7WtRLBlYIj0diGYmN9hbPmxeIEP90cdJACqyScN0iPKJJBT3foSrJC9hlc32NxQdi0qMhsA1jxCo/oRYh+sS7/PtBj/6QTooTjnJ7v6w12eCWWp44IEglY2ZxtdDgQzd2FYz0WgdsK7Uoubd2oAp7f2RmfBvAuRc6008W689p7fFF2QUDoNPMD8yF6T0Q+gQb2npJX6Zzf1mELgm2acN9TgpwMeMsQytwFlIy/7Dw4c11ngY3ReZB7qoGOixLws7m31prR54d+GIDGEvanXCWdSeu5EmlASBsdRUxEP03A2Tg97zzGMPtJPA0ys0bI4cXXLIR0SNI92sIkm+qVB4A0YWtLjjUjDtSQKjpToMlpmVIZ0L+uWC1eL/chnF2T6rAAv4Ohm4/zose+9awoyvZxBGkFziFnmRhmlRjCIyzPt9ViHeUdmINmU1yNw82pR5LLff+qjPpKkTn7F91Cjm4riTkMcD/lZnpTBMSUNoWj5TJyxq+/79PzcERAkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFaN2w5YWM2TktRanROYktKYkdIdkhKL1dyRVpoRVdXQVlST0dabndDL3FH?=
 =?utf-8?B?aGRKN0FoMklUSGZCYlo2Q0VtUGZGRkZiZVJGMkVIVEQxeHVvUStzclZkSGxo?=
 =?utf-8?B?c3UvUkFrNU5zMUxOVStsYy8reVVDYjdVZlFRNHFkY2xYd3owb09IeG8xNmF5?=
 =?utf-8?B?WWh5OGQ3cWlkUG1IQ2NHaW96UWdPdUJjTFdnYUt1ZTNjbVlnY0lSV1dUYUlZ?=
 =?utf-8?B?VW5RUy9RRGo3cmtMbnVsSnIwT0MwUUNNRUUwWEQvUDkvazI5TDJiQ2VuZUlM?=
 =?utf-8?B?VXZWb1RVYitHOHRKNkhCRC92T2RRaCtlTHJSV0NPUGN4MlFMWkZ5enRQMGVu?=
 =?utf-8?B?clA1QzN6WmZ1Yjc4TFVqRmEwbnpQVjNFWHpNenpzeGhzM3lObFgrTlpnTjFG?=
 =?utf-8?B?eWtTOG42STIyQ1ZHS2p3VlN1L2R2UG1TQkV5amE4bEFha0xDdXI3SXhpQmU1?=
 =?utf-8?B?bExyb2FmUDh1QkZyU21aYUQwVUVqSm4xZmxuNVY3MHlSZy9GYUQvQjZteVp0?=
 =?utf-8?B?cllOWXpKUTk0bUZvbTd1a2N2bTdJS1QwZUwrOUVkR0Nqd3h5WEVqME10Ujkv?=
 =?utf-8?B?QmRUQjZ5S0tzOE9KbFVqbWg0WUJtcnBWUkZlY0FqV2FlMUxHYzVKV2hmVzVr?=
 =?utf-8?B?WmM3bGJHUXA0azF5cW9nWFZFbndKOVJuQjZoZWhacEFxWHNubUlBeVE4WmJN?=
 =?utf-8?B?RmpHMFVXTVBZcFdTaWEzdkZiQjB3bWloMVV3cXZTVlVzR1l0bmcxZmNhemJ0?=
 =?utf-8?B?U0REc0hlTWV6VmMzMEdUVjlYa3MyMUlXSVVmMnJna2F1THNxZlR4UG1JdEpP?=
 =?utf-8?B?QXA1WEFNZnA4cE1DZW9qSldHZEtoZ1k3eXRyRFNacFRWLzBXdFRiSE5mYzBv?=
 =?utf-8?B?bFZmcy9iZ1VYOFJwZ0FXaG41RWRDSUxMc0NCN2QzTHJsQms0Mkw2ZCtlTldz?=
 =?utf-8?B?TjYwdDc4R29EenBoS21rTFAvNjl5YW9qb3A3TnZNekRiRy8vQ2l4eHJSK3FL?=
 =?utf-8?B?VldtMC8xazlKZGRkalR5R1VCUzlRWWFMR1B5TTJqOFgvNlpYdVVsQ0tPZGx0?=
 =?utf-8?B?WXlhVFBFaUIwVHlPYWdISTcvSGhjeUdtaGNQb0hlcWdNeWYyR0lvVGZlS0NP?=
 =?utf-8?B?TEg0S0hMZm9FT3h1TlE1ZUU5SktPVUJvNFRINjIycHNxNjlOaGpDaW1SM1ZB?=
 =?utf-8?B?bmhnR0xHV3ZVZ2E4MlR4eUIyL3h3MGJVZFAxNGNESFRTQUllZW5IWDJGdVRw?=
 =?utf-8?B?REJad1Rzak0xS2hheWtNU2kwUU5DaWNTR25iL2VVWG8xcllPa2hBVGpDUkZF?=
 =?utf-8?B?OEJMNUoycEUvSEdxMk9DYlpodzNTQmV4S3NyYTJqSzBBV1pxVHd6YndieHBz?=
 =?utf-8?B?UUhTbGp3c2FPL0p4blovUDBBWStCMU9MeDk3dHJOUi9WT0VQOUkwZ2g0dGtm?=
 =?utf-8?B?Y0JzMko4TWMwemFpUlY3VTRCckhiTFRWZm84TFVMSWh4Tlk0ZytpbWc4SnFk?=
 =?utf-8?B?c0JQSW03YmNqMUpIcjNyb3prdkYzSmRkSW0yMkFBcFU5SlNhbHFiVE0xTEJI?=
 =?utf-8?B?WGE1dUtwUnJRck14ZFBuZWJwV042QjNIYzk1RUFDL05vYjYxNXliTXlhQXA4?=
 =?utf-8?B?RjJrQktCam42SHFMREc0Qjd2d2U0V2JnMzlhL2pVOUM1NVlUREZta3k2a000?=
 =?utf-8?B?bWZNWDJ5WHFUVUkyTCsxMlE3S0hyODRNa2ZzenJMWENpZzZWVUthTThjK1pJ?=
 =?utf-8?B?R3RDWGVybGJxSVBlMC9wYStPMlovblFzd2VySndaS3BZOGtIV20vSmwzUlRi?=
 =?utf-8?B?aTgzcUtGTmwvSGJRclU1SW4rMjdBbXN6WTZUSlFNb3JCbjVoNzlkTExnTmRK?=
 =?utf-8?B?ZEFZL2RjY09kaHFYdkdXajZXdFVIY1FzaS90V0M2ZjBneTdhYUdOd1VUQmxt?=
 =?utf-8?B?SWJzYU01YlF1cndMNTBLRUp6dnJiOXoxaXJiWVlCV0dWQkpTNk5XVm9La3lz?=
 =?utf-8?B?VkFhVFc0UEl1eFhZK1RnSmkyZHZlYVFUeHBpOEhRSGx1SWxqYjVmWnVrZ0h0?=
 =?utf-8?B?SkhXRzlyVU1Hc01CMC9XN2tNSGFOWGo2bTVSSW1QeCtYZ1U5azBXZXVQVkRX?=
 =?utf-8?B?Nm9GWVVRUm5yb21ES0lHbmV0S2NXMlBnYThDY29QUlZUWUR5QVcwdmRkQjJC?=
 =?utf-8?B?a1RLK3dEaXhwTnkzRXgvZWRtOHJHMjBHUzZ4YnBzODNvZ3J1cXdmQXRFdlZN?=
 =?utf-8?B?MDVHQ1FBR3F1bzdrU2N3SVZtZk8wWTFqQ3JsY01tREdOcEtSQk9GOXB5cnFV?=
 =?utf-8?B?bFU3N3dib1RiUUZBaUh6aVpWMjQ3WFFBbHdYbElxTXpIaktEb1NmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 84817aaf-9cb0-410b-82db-08def975471f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:58:43.3833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHuSsr5EcU8gohb4lwtLAs7DuU9hAbEhj3vibwOLfy5FlzhMXXqd4vwzdg8uG9iEcbMG4OhP+Au7yR5nUfdKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7221
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

On Thu Aug 13, 2026 at 8:37 PM BST, John Hubbard wrote:
> On 8/12/26 10:50 PM, Vladislav Zaharov wrote:
>> On Thu Aug 13, 2026, Danilo Krummrich wrote:
>>> I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
>>> requiring a rebuild of the kernel.
>>=20
>> Agreed, and it makes the patch smaller: with a module parameter the cfg =
gating
>> disappears and the code is simply always built. I used a Kconfig because=
 of the
>> "the only Kconfig needed is for retaining the GSP log buffers after driv=
er
>> unbind" remark in the earlier thread, which I took literally instead of =
asking.
>>=20
>> That one needs a decision, though. The Rust module parameter abstraction=
 has no
>> bool: rust/kernel/module_param.rs only instantiates param ops for i8..u6=
4,
>
> Yes, this seems perfectly acceptable, given that we don't have bool suppo=
rt yet:
>
>    keep_gsp_logs=3D[0|1]
>
>
> thanks,

We have bool support.

https://rust.docs.kernel.org/next/kernel/module_param/trait.ModuleParam.htm=
l#impl-ModuleParam-for-bool

Best,
Gary
