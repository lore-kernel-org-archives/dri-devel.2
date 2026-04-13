Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5684F34C4E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568DF10E453;
	Mon, 13 Apr 2026 13:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tb52cO0d";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E75F10E453
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSX01t49w5stk9sXV1tpnSL8oJK+XKHCejykR/FzKbICSxl49o99AjOfD3BGcSrU3LhyQqjmM+YUDX6B8ryvXcHVLT0+EjVWmUQIoQ58dhgOCAPHLnzprKCdfpNahnpsDlbycK+JW5qkVYKtM3e9lsuRrdwj0gxNDBGQ8aVh008EZBSqI8tS9bkm2ScCOtzTUbBO/TPnuoRH04HTuOKXLCwKV9yF6A6U1RofGC7pHqm3dszpGD73dym5hZQK37haqiLLHzl97wXmqejL0ZUkUAftYKSwaJlChY5tPNdP7s2jUvuB1Y9wd8UA+WK0HM/NM9tPA/iAWGbCIsxgbO4S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj6vWVlhZo+1DHjErSWtPb39TRxQexW+V+jegBdD05w=;
 b=vgZaVAg0PPwjugQdeYWKRNNsehNIlZppbEjbHXrhtSEMnGyA3RTKkcP7TcTNnSSvfpNeoDO++aTw60V8gvg5UnIEDKMSZYFmAS8K2J+0M5ucaf8Hth48mA+QgMf8+Ur8NXCFnEvovmFJCXMJFhsnBSNt796E605w9oglc1I2Y7bZ4P1jLdKV+wqxrTMTBDLU8O2rCSHiqEJK+PJXT/bNyGnOSdma1QEkq4c36WzPXIRo2/pMHzYXUuCZ3qS4OY3RsoZ4jZGqhTVZxLq4/OfrQj74J87MNfzbsIxQBVLFWrOegaosMVVxhOccS2u7OMuMwqcu98TOlvvFQnS6APf34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj6vWVlhZo+1DHjErSWtPb39TRxQexW+V+jegBdD05w=;
 b=tb52cO0dCdrEfl5a5n83Zz7caGbet9cnp161V2DXqqqEgl7pvWtTaYIF3fb8gvugA5Ha32J6jObK0JFkWSlyca6SVUDRu6UgjDsc6izMr+1BCBv6asL6121pRTxl6v1Ddom/tPty7oJBJ+EHOV9AtxVPrrYJYfJgTF7n6rOPH3HyujR6hp1A+IeB/j/o5YNK9qmN+EGn5bWOx2J7t0QcDodjQWmtqyTj+eJrNabAwdgAv1RuSj9JzkN8lGqR1FpcPGu0hXv8ADi7E2ftb1YiimQt7phoSaRiD82wrq2KgLellYVAVFcwW2B5DtSlwQR0hhDaKvOxgmZf1K3Xcr/kfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 13:33:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 13:33:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 22:33:50 +0900
Message-Id: <DHS2DLJW7ISY.1QW0Y0WC1NSZJ@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush
 on boot failure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
 <DHPLKB40FM08.1L3H2S589WUW@garyguo.net>
 <DHRZ01R16ZXR.3T0D56PREGR18@kernel.org>
In-Reply-To: <DHRZ01R16ZXR.3T0D56PREGR18@kernel.org>
X-ClientProxiedBy: TYWP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: c59c2d59-b097-4748-f409-08de99614ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3E5KzPw4iS4EwCu0MZel0Jh3a0wPdU+FMKq2OF6vuVjqEjOMRYYMo3Jc1/a7eea8rSGnK6xK6UQJQaWPSWwlyRskQrw9RxO1OZVGsrGcRsgbvpV9b1wn29n9ZOQ4OuITHq2PswAFU8hONJXe2wxsP75u3KSmqBoRsKuIPz1FPNyMLnUk441ajSDP1ZqQlsAcu16/aTJ41tQhWaUjLlR2k2a6tKSF0+voJXZ+H6q0Fm4KWiUTaxsr2w06HkD6y2Exfe6Yv90fTjuJJq+UarFi8TbwXBd6tzWE6IA2RJPNt2zYWs6SRqw7PWWxYzH7r+zH8mAc3WOVchDXtNgI5HNHRs6Z+v9UPUDzdHjiRq137mb3/hxwr1FjlucP4AW8n4BgromM4OrfILuIZcLk4YFkJb0+F//gCKXKjMS3o1UwMRbC21P0nedPl35ieqdvqhOLYXF01TvX+I13Cwe85zv3bU6KyOIRN3GZiUKJuF8ktXKa6NijARsJCFkdHV5SIiuXs7XjlgX6WNtplHgOsDiwYjWbzRqLTZnTtpRoKeu0Ldo8PdE6uDOp2YE184xtAzTJXiemC3cqJhkwTlh4Dzx9Yo2GGySxFMfP63QWs4s7WNE247VW2Raa6MIVcT+EooUFnBh6U8SOuN+uRGzjQUtoZ7RNBOHlEAWVOne2WJWuc6KkxSvY8TYS4pJYgd1dp3y8yVOtv1Vt/NXTaq5r9/dPFa13McgEIkRxCxkMxKzR1QA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpvZ1o5cUpWNXJTMkZRWVlyNGhBQjZremU3UU92MWh6NGltR2g3aGZuRkRB?=
 =?utf-8?B?M2lkNmxrMlVQZEJuY1FEK1hMcUcvc3JiaHlPTUdPNVYyb0NYUFVLMVFDR2hB?=
 =?utf-8?B?QThTZDZlS3dQOUtzVllyekZrbGJIdElkZUdaMDhwNXV0bEM3NnJQc0kxK2JW?=
 =?utf-8?B?MFhCVDM4NC9wdmxUT0dFT1ZWMXdUYUFwcjgxMXU4U0xueTVMdDR6RXE2ZGdy?=
 =?utf-8?B?OWZOU29ZRFI5SDVZeE1vMk1jcy9GTElWZUxra3lGR1BtYU5jRW1pTk1RVzFN?=
 =?utf-8?B?WEs0Unlyd1RCOFdLaWdsRDRSQm8wenFsWlpKbkI1d0JHNTUxNHdBSGM2UjZM?=
 =?utf-8?B?STJ5N1lPdEYvTkorQjRqV0JqaVBnY2pQZ2hGbUZBQ3U1RXFKREQ2M2I1VTFr?=
 =?utf-8?B?UDRFN3VxYkNESC9OdldBLzg4aXp2WFVmYkREZFYxd2ZKUzZaeDJLVExIcVl4?=
 =?utf-8?B?S0VuTDMzcyt3SVRKMWJRcGRrdkxmd01HRWhsRkJwaTJiTlVFT29TQnRNNHlC?=
 =?utf-8?B?ZWRrSVRuQmFWeGpLSXE2c29RaUMrbG1HMVJCd0pzMEVhUlBBc3o0cStYenRI?=
 =?utf-8?B?aWwzUkxsNmZCUzEwT2Q5NW85TTFJS01TVnFkYkFUdnNESExKMGwxa2pDZUNi?=
 =?utf-8?B?cURSRUk5T3B2d1p1VFNmWkI0SjZyQUdLbGFJVDZKSTV4U2ZlOG92VElmR3hz?=
 =?utf-8?B?SWZxbGJlOEhORU90dzVSTi95dnRCb01GUnZQNWpJcTZKVVBobUIwMDdsWFpN?=
 =?utf-8?B?VTFXS3VENTBRV0p5MnpPb1lEMXkxOXE2WnYwenlKOS9IeUV4bE1takF5eTEz?=
 =?utf-8?B?OFJEVldBT0NVSnI1Rk51OE4wMFRQOWRINjJJR2liVmxEc1JoOThKSmF3YUhE?=
 =?utf-8?B?WWlZSDZ2amIzdXBxdmxzVm1LY3c0VWpmbmZzSm1SbWxoSFFBdjZIVm9PTm5Z?=
 =?utf-8?B?UURzSGtkV3JCZkpGMkF0dFdKN1V2Z1c2RGY2ajZNV01SV0ttTlNWUFV4Wk9u?=
 =?utf-8?B?SUNGS3A5WDhqZE5ETDFCMytxRUNUb2Zua3habGtzNG9VYzRzaFhTdnFGd1l0?=
 =?utf-8?B?MmQ3K2c2TGVCMlpCY1lSdk5aejhic25HamRleC9JS0lSbEtyMGZTTjBHUXBo?=
 =?utf-8?B?ck1NSWY2d0ZtcnBtZzhvQUk1eVhjeGo3ZUJoY1NBTGhxbXFyNFFkWXVmZHdC?=
 =?utf-8?B?WGt4bTNnVm16aE5FMUVnckhlM0swc3d3eHhTdGhvOWYxN2pIYURkb25SR3My?=
 =?utf-8?B?Z1hPa3Z2VTNOMHNHdUtFaGpnckVJZDVRKzFrYzhsTHFEUkFTKzhpYnd0WjUw?=
 =?utf-8?B?cUNxbHRjc1B4L0tkMGNPdTlrcVlOdTlQV3VvemErTGZGeXh3elREVTV2S1M4?=
 =?utf-8?B?TmEvTW1sQVE5MTBCYktlQU1yMXptSFlBZTRtQ3JhdjgxKzNIMS9UNC95QjFN?=
 =?utf-8?B?clNobFlDQnFGTWJ2QnV0d3doSzAwcDNualhCUHB2UTdndWprajVQRURFQkhV?=
 =?utf-8?B?a0ovRjJrbVk2YTRRNHZIdklWT2lpWlgraUpPZ3orVk5hb2NhWEtGcmNldS9B?=
 =?utf-8?B?Z1FQcDJaamlyYlN6V1g5OVZETC9XYkJvS25INmk1dnArTXBLWmNuNkY5K0ta?=
 =?utf-8?B?UGpQeWxlVE9OVDI2eEs0U29qTldBZmN2VkszK2NwRHFiRitoRXcwUGNtQThn?=
 =?utf-8?B?NG1GVDFYekl3ZGx4cHF1eGZiWXVLaTYydGdkTEVVMXRXeEgxaU1kNmdQbElp?=
 =?utf-8?B?MkptNjA2dHlVR2tCM1hwSG90d2RNSktLd3dPMW5SMWh2dUk4blJIVW1xaWxy?=
 =?utf-8?B?aDRtSmNpbEI3aXNnYjhtd3VRODJiV2djTWI5dFpUdW84TnVYRHAzV3VWakp5?=
 =?utf-8?B?RFkydk5WSGpOSXVEeFFqUmNMNi9rYnpEWkk3Q2JmMUNXSFBpeGFYTlErc2dO?=
 =?utf-8?B?QlVENzZCN05MVEpucXR4WTY5QzQ1ZUxjVWUra2c4cVd3Und0VERUUDc0Zitt?=
 =?utf-8?B?MERjMVNZT3NMdndBZzlkL0ZBVWZXcmR4QTdOZmJNdkJFemp1U3VGVTJOQjNL?=
 =?utf-8?B?a1diSVRxN3Z2Y1BrZExyTkM1NDY4bEpyb2tPZ1BscitzUGVkS25QOC9qM0NR?=
 =?utf-8?B?UjdCMmtCZnp1RHF2M3UrQ2lDdkpJLytFMFdDS3FTdlhxNHBtMmdpclZ2VmpJ?=
 =?utf-8?B?NUVuZkFsdVVhRkxVb21sMU1HUThzZFgyRkZEMG1UemhTcE9vMnZEUU5Od0Rx?=
 =?utf-8?B?K0ZwbTluSVdoNGFDR3laWWwwOVc2NVc3c0FLNFc1U2RTL2k1RUYvL2w3QXk4?=
 =?utf-8?B?SlgvR0dNU1gzU3ZSNER0Nm9oeFdZdU9CcnlTSGlLWC9TL3F1SFg1cFBWTmQ4?=
 =?utf-8?Q?oL58WWYqb8a9xiSmwmVFL5Lle9AVci90H1wfGSstwblzw?=
X-MS-Exchange-AntiSpam-MessageData-1: Q5WXuc1QUW9kwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c2d59-b097-4748-f409-08de99614ec4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 13:33:54.6836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4sZjQpDgjVQYmNzhCOCmgglP/xP3IRin4UUPVX6Npk0Ky9w9MbZpIdkUXEPbdi3SEaEWkvN94dBA1jCSdFMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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

On Mon Apr 13, 2026 at 7:55 PM JST, Danilo Krummrich wrote:
> On Fri Apr 10, 2026 at 5:57 PM CEST, Gary Guo wrote:
>>> +impl Drop for SysmemFlush {
>>> +    fn drop(&mut self) {
>>> +        let _ =3D self.bar.try_access_with(|bar| self.unregister(bar))=
;
>>
>> I feel that this is the wrong solution to the problem.
>
> Yeah, it is pretty fragile as it relies on outer implementation details, =
such as
> the fact that SysmemFlush is part of the device private data and hence
> try_access_with() will fail when not dropped in an unwind path.
>
>> The thing we want is to *ensure* that `SysmemFlush` Drop is called with =
device
>> still being bound.
>>
>> It's not yet fully clear to me how we'd want to guarantee that, but one =
API that
>> might make sense is to create a DevRes API that allows you to reference =
an
>> existing `DevRes` and have driver-core making sure that the tear down ha=
ppens in
>> reverse order. So inside the `Drop` the `bar` can still be unconditional=
ly
>> access.
>
> Yes, I have something like this on my list of things I want to look into =
for
> while (my list entry calls it DevresChain).
>
> I want to leverage the internal reference count of Devres for this, which=
 is not
> exactly straight forward, but should be possible.
>
> I will prioritize this and have a look.

Yeah, I agree that this patch is the wrong long term solution. If we
don't have the infra for the proper way to do it soon, it might be worth
taking it anyway since it adds minimal complexity and fixes a real
issue.

I had a brief look into the Devres chain stuff that exists on the C side
and it looks like it doesn't provide any actual guarantees about the
lifetime (it seems possible to delete from the middle of the chain, so
descendants can't assume ancestors exist in general, AFAICT), so the
the translation of that into lifetimes in rust might get interesting

thanks

>
> Thanks,
> Danilo

