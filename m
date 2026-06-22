Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB772CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B4610E404;
	Mon, 22 Jun 2026 01:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gi9TPIcw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970C110E404
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 01:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaOCQMXaLNGQ2iKfcAPZ55pHjxGtBmbUyMU8TQxEa2YVzQ4o1+c8YR45GeKSGiJxAm+Eu2XtcbfPI1rq9B+dl+UQBmMFXK5tF3ZLizo8pF5w6Dcd+RL4quN2wOVvCd0BX9LiF+hHcHQ5WcMT0PCN951Qr+M+aXsigf9XPxLNoGUsmvZy808oCWokMEhnorUfw9x+kQIm/LfPJok47eqBZQ+Vu6b99+POkEgxTLFGvAPLtKzEbmO1mGJIvcKWOq4OvRj6NzLlAckPTArpuAnri2cU6mO52dq4SZYuBy5RPdJEeLvvwcAeTOnPRnpgMJmI669bKAcPwyVWgrXQjf+8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHJz7/pYiuuq3IDBL3jBrc1J9GbxR/1+j5ru+2/s25U=;
 b=IBCq3o4QnEg0xJsMLY0Dmq3i3oEkTBHO9cAGl/Kw+RtlyIq/X0upf2N8Dg9QVUJYwh5axbSG0AbHFSK/FwXq1eJAggZ7dR4LgWaa2Lv/QN5IZd1Wd4zGRBgLMYmggnb9ysfGneJlT/KznQPll587Ue2t954KnKGg+nZSo6OFQxjS/90t/vRdzhNKWb1QsRhoBonbWrZqubL4kjP1IAr0VXs6jwAtm0T3PiaE2WY8iSXBl2ViNAZpOeo4N5m7oN1fgVf7P2tDaIn5HUlKHxdwpqwcISBCM/+ZAb3TIdzjRzDbJ08NyBDIJPBAGbLe5nUQt+jZopCM9h8OpY/q9c+R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHJz7/pYiuuq3IDBL3jBrc1J9GbxR/1+j5ru+2/s25U=;
 b=gi9TPIcwJ3ptpvBXJZde9UqM7wU7Ugk4XFgX5ZoDILhWGupoQOVJK+XzpBUGDM1Uha/SmjXi62H3VTMJoTl+haMYb+7WWJ0cefhhSxNGuOnEN9on/i70HrlU1qIfgYhJfO28BtbST5DFzFLpCmdR27EJrLtpFELR5+3/PNGuguce5UraaDaDkl7sDEcqgMskHxfC+Zy/cFnNjpcsSyicTwQgJdMW2mfNWgZFhffgv5B2Gclw6qnBAHYTMyqrhDkYQ81zwGOp8eNoLhNokAUelFRr2Fecml3LQMf5S+gO4Dw2wG3ylgk0xUJL2J6RCRU+pGBwuF2+Ro3lRGJ0Sdds6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 01:11:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 01:11:14 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:11:10 +0900
Message-Id: <DJF6F4194K7C.P89RQTXATU6O@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
Content-Transfer-Encoding: quoted-printable
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
 <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
 <DJDXNDGXLZZY.8IEHLBTRKCQO@nvidia.com>
 <DJDY31W202BF.4OHIYPH1MEDX@kernel.org>
In-Reply-To: <DJDY31W202BF.4OHIYPH1MEDX@kernel.org>
X-ClientProxiedBy: TY6P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3ec62a-19fb-4ec8-ee3d-08decffb2790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7esZ6RUf0C0ZN5lj8YQOzblB775fzwd+Bl+iD3L7Vb4Fb58CaN4RDZx1UuPzzIdi0m0/kEWfZEDLWUzRfAA76qP5c9mflWwgT5C3nQ2QIOjrKL+uYGFSs9+sT2HWZfTCJ2IC9Et/3WpRTJxZohGUZK1bN7ZcDaoyFMlFT30i26dnFHAEbdcHBmA3Z1TznbsHgLTDBFAiRXMWXvGWRPKucpbIvdBU40+567pn00vKkp18c2XxgWOBCFM6EoslF1j0bhD1BoBrXIkH7QJux2XirjqWdkwO7IuM8gsSPbBHExjzpjAZEBdTGkgUZyOxD8CRcBj5Wscn/mdaycu9N85IHXq8QL6/jwbaPB2Sm3VNoYo8BGLAcb2wL09WBUvwntOtwS5i8BpLfqq3+90Miua9lvA6zK90RaN7cmqEi/c+oaszzzeEYHYQMoyg1JQvxuC7YHkl1KlOq71QfpbnMmvSR1Qj1+Gzhw2DeMiupQJcbfpRBWmDQPn3g3g9yJbum10XpwoblPHc77yZGW6k7CI6/9URhi87Ug+RVHA7VVJdc4WmIkSRqPyW/El46JHdcjZ8IpzbtxS4eOxAlCmVhd1zbMVSSWdvDt/lUErYX3V9bu9mV1OUdWXbqOd2GmHDQ8V4Kngs9rvk8b5H1ROSreh1Wbu7z8K7Gx3UuFNllQ1I5Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmc4TXBLdHlLTWRjZjYzeEpMc2RVT01aMDVPd3FDWWV2MU5lWXFuWXpvOUVj?=
 =?utf-8?B?TDFTT2tRa2FhOGlENFR1OEVSQ1hka3AzNXVHK3l2UlQxcFY0Y1BGYjNFemxZ?=
 =?utf-8?B?aEczcG5mbnJBMjA1akh1UEh6VCtQejk5cjFheDJLT0p6OWZnMll1QjlvMmcw?=
 =?utf-8?B?MjFFdnpFKzBTdnZ2YU1Xb2lPWnIwMngvWmlTbnQrQ1orblBibFNsdjBCcC9o?=
 =?utf-8?B?dzdpNXpKYjlERnlySDhoaGhxa2k3SlFMVWFIdENnRzQzZDR6bVkwaURocjJW?=
 =?utf-8?B?MVU0dEpXckViU3I1eE1kUnBWUDFRNXIvYmw1TzQ3L0lQRXdVUU1qOW1BUUhy?=
 =?utf-8?B?M1B3OWRYdUZaVThqU0ZyMG5jQ0RvOE9mK3FMYS9mb3lRb0Rlb256NkRGeUtU?=
 =?utf-8?B?VGdScmI1WGYya3U3VDJnMUxreEMwc2xzeXdiMkthOVlUVWV3RjZPN0Q1aHVo?=
 =?utf-8?B?WkVpTXd1K1dtRHhaVmRwKzl3cnNERXU0ZFhkOTFWZ1U3cHdDOUZSazZXWVhN?=
 =?utf-8?B?Tm9iNTJvY2g4bllVN1ZscW8zdWxzbHRaK1ZzbVl4TkhubjNoS1h1dm9Ca3Jx?=
 =?utf-8?B?TzZYMzIzNEJQK2Yvb05CbTJvblJSc29mQU5jSExKM1JvOE5BaDkzQjJCUEdt?=
 =?utf-8?B?UUMvMGFqc0pyRENmeGR3V2xxb21oa3lseEFBZGg3R0UxUWh5SXRjQkxKeERi?=
 =?utf-8?B?b2p2OHExb2wvZGNjclhjazNNOFVsV203ajZXWGhLUVBLd2MwR2ZGQmtTK0ZF?=
 =?utf-8?B?dy9XZHBZcU9sZGg2SWNiM2VTZ2lmNVhEYndLeGIxZEw0S1FXVzZPZGh4V1Fk?=
 =?utf-8?B?dTZpaFhlVnhxTGNSN1BNdWozQm9lbHBNYU1zQlFWMllDeXAybjFTejVTYWov?=
 =?utf-8?B?SkhueVJvdnR2QTh5eWY1MFg4TG9Nd1RkUWFaWTduRXhtMC9SWUNuSWhHS1lC?=
 =?utf-8?B?WTBPYVZheGhLSDM4NWZkSEtPZi84VUpUejBpL0plWlNXQVlVcExFdFVmcGFM?=
 =?utf-8?B?dzFqcnpWODNnWnI2SFRBR216VmdrK1hmWjQ5OVBZUm45RE1zT2h5TXNxT1Zi?=
 =?utf-8?B?VUVQL1RNUzUvQk1qOTVmVzQ2WGhJRGUrL0w3T2tacWZXbmFGbjhtU01lZXJO?=
 =?utf-8?B?OEdoRFhGc29PTmJFc2paVUdINWQydlAxR3JHWGQ0L0ltUzByREc2Sk1Ec0Vu?=
 =?utf-8?B?QXZ5cDhYWjY5VGFtSHIxZ1pQWFU2UUVKRHp4Y1c1eEg2NnlncXp2alRQb1pn?=
 =?utf-8?B?MHdZU3g5K3FjK1dIMlJuMXVqS0xEcjNmVXRCVWRidDAwQlpLQkNENUxnOExJ?=
 =?utf-8?B?bGRaZGhqT2sydEIyVExCRXJseWJMYlpndUtrRkhDdlpsSGpMdXhmbjVNUXVE?=
 =?utf-8?B?aUhPVml6dExhN2NFM0NpRjVrRGhCbkNHVWpURXoyQzREV2pWVTQzdEI2dTlZ?=
 =?utf-8?B?czNwRTg3d0JoczR5YmxPTnFiUjlXTGRmRVplTUNjWnZoWkFCRFNlSnpwVFFG?=
 =?utf-8?B?OTlFM2xFODNaZGhORjg1Wko5R2wyaVdiMlZJelhUUTBuMUxQZTlCSUNiNitl?=
 =?utf-8?B?OEhlZHhEL3RSUGt0cE9XQ2EyQmVacUxpckI5Yko3QzNsYWR1OHhDUlBZSEp6?=
 =?utf-8?B?K2RlcDhVci9FZVhSaTRyZDFBSWZjLzBpem1ZTTA0Q3B5d1dwc0ZNUk0xK3lE?=
 =?utf-8?B?VHJEU09wTXhUSHN0TmZtOW93WGdhb2N0a21scjZsUnNSSkF3U084aDAyVUh4?=
 =?utf-8?B?N2dka1VQOHNWYlQzWDk4Z2pWWUtFZkJIcjlCT2VDNzNoS1lBbEdocEVVblAw?=
 =?utf-8?B?Y1dMVWVzK2oyeW01YjYxN1BMaDBSd0tFdXpZV2pCVi9YM2dsaTEyeVQxY0R0?=
 =?utf-8?B?dGVXZU1SMzFXRllzSm4zcU9lbDZDRm45eHVwbHlTNlV3NGs3Rk9YM2lUTjFt?=
 =?utf-8?B?ek9hTDU3clhUTjVaVUVnSzNyM09zUzlkSmhTa2dHL2V0N2VVbGprS1RNQzBa?=
 =?utf-8?B?ck42KzZsZlVuWU9QMk8ya3liNzZBN3g0enJIeWd4c2ZuUEkxejNkTk9KaWFp?=
 =?utf-8?B?SW9Tb3ZyZTROREd0RU9rbzV0eG8zUEM5bW9QNjEyeHFLYkt5OVNkMEl5WVRa?=
 =?utf-8?B?c3FaRTBzYjR6a0JhRkw3M1VaWlJCbEwyeE1qUFI0bVlzQWZucFBINHlBZVVB?=
 =?utf-8?B?dU52WlNNb3h4SG1QZkJYN2ZvQmlpaWNEdlZjd290YWVMbE9DVTh3L0ZXem5B?=
 =?utf-8?B?QmhHZmQrbFMwdXg1K1NzTGxrNmNXVDJMTjhod2ZDVllEb0Vybm5ML0QwSmNl?=
 =?utf-8?B?Vms3b2I0b1V5NDlscGtrNkFDV3pIUzF0R0ZrN2VvLzlObUN4SHltSDloUGdD?=
 =?utf-8?Q?hAZIP4UQnvv9Hf4fOEaVxABmPiqoFXkdABXk4rsTUAtWs?=
X-MS-Exchange-AntiSpam-MessageData-1: u4uXdxgR6ihG2A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3ec62a-19fb-4ec8-ee3d-08decffb2790
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 01:11:14.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLhe8kEy4pHLQGmRq4FSPy1nzv5cusxoPf0fDvn2LnSjx+peF+6W0Md/Bg/bgDZzbRtsfinZCtjjpej2iiibKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

On Sat Jun 20, 2026 at 11:26 PM JST, Danilo Krummrich wrote:
> On Sat Jun 20, 2026 at 4:06 PM CEST, Alexandre Courbot wrote:
>> I expect that the users of the VRAM regions (i.e. the MM subsystem) will
>> not be able to contruct properly if no region is detected, and that soun=
ds
>> like the right place to raise an error rather than making an assumption
>> here that no VRAM region is an error. For instance, I am not sure what
>> the regions layout will be on Tegra systems, although your comment about
>> OpenRM seems to hint that there are regions defined for them as well.
>
> Well, the question is whether it would just be an assumption that no VRAM=
 region
> is an error. I'm not entirely sure, but I think it generally is an error.=
 If
> that's confirmed I'd rather fail early and with a clear message, and not =
carry
> on with something we already know won't work out.

I took a deeper look at OpenRM. The zero FB region error is emitted when
mirroring the list of FB regions [1], which is a default HAL method.
Zero-VRAM chips like Tegra replace it with an empty stub.

So `gpu.rs` doesn't look like the right place to do that check imho -
especially since the list we are checking against is the list of
*usable* regions, whereas OpenRM checks the full list. The current code
is just getting the list from the GSP - the code that does something
meaningful with it doesn't exist yet, and it is that code that should
error if there are no FB regions at all.

[1] https://github.com/NVIDIA/open-gpu-kernel-modules/blob/570.148/src/nvid=
ia/src/kernel/gpu/mem_mgr/mem_mgr_gsp_client.c#L61
