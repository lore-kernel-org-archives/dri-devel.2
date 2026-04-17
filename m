Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13564F8E4A0
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C3810E270;
	Fri, 17 Apr 2026 02:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KnKLCxjH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E3910E26D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH3OtRwevR3b4sf8DVYyrK5r2A9hNN9QWs0la9gB5e/rR/gxWrbacf/9QpKkWiLaPfDFNmp+uz6Tn2Lzstx+NTrmxO6AEVY9KZlkF3juBR+muvfKat1y6lIrgWGGPe44RFxJ1uJKOKP9zTPK7Ui2Kl4ZHwADsY8/NrNEhI8SFGjhgb1G7fmIrW1yYfExwa8N1+vu7sbtmrx3ZwkmacLMgEdJrqD5WY9SR8gYNe3q+pwmjW1vjUaA0R64NVSbpGUdLUTQwk9x5PkRfebiodpok+RfHQroBaFB2pNDKY6HWl0/vZ1gvNWVrz7cwaonwoFQSXhJB1wc76a8rD7QfCgCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viHWl7kMR6qDT+jaJgkEHCgeqIVWM/8aIfTjQTN30cI=;
 b=CF8fdELNHhg47vnn44ZwCkWfxxIusMX7CXBsQF81uXFn14jcRKwWv8eoBeA4W2QUT2JZfK49O5mw/rQY/CUBONcjdynN47mzRcDqNTGZoVmADcmmWfExDx65STwOK6ou6AgCNhE0qfkYADK9qQS8tPDXmu17NsO0fnoLCMSv9NjpcUfUtjf2Q5VFiVizVM4p0SONYP+8M6/zlSPj6D1HRJZw+DCeMw5MA1uhIgdNnAYgStt1oQ8pwlmtRv0Nu0Fys9M7ubilat6c0ZSYNfYf0VlcAvfhHH+4bd7ExukokaJxY9C7qBFEk4RylQ7CQXEYEczKcn4zA/cUi8WJWtP5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viHWl7kMR6qDT+jaJgkEHCgeqIVWM/8aIfTjQTN30cI=;
 b=KnKLCxjH+pPvAyU3hrodBchR8sNSg1vT7ocOjYEFJILX8xt6ErvIJpElmwvfZnls1IDlUzO8NAbFVaiYpzWm//pTEF1rakj13MuX9ySA3xEfsUEEJcs0oz/N4qC36TNKRdXcHF62X5YAFAmE0a+qN+Xl6fiP68wJnFDFAh8pJWO/mHyXsMVPu8WHCjFIiJuguzlpg+FN5I8WhrKCVDYzFox9P2PUlZJ9bum0s3Pc0NIirRvckgBwXNIvdTtwPfOsGLQn8S9VjSKtY1voN/+XX6K54SbEuhvjt/3B/RF81WGfnjofItRI0RZDGG3uTBQ4v1FV8GkvHRgWCJKekCqApA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 02:41:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:41:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:41:38 +0900
Message-Id: <DHV30FCX4QCU.2QA40VBWESOVU@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-8-705d30d16bba@nvidia.com>
 <54b13fa0-9405-4fc8-ae41-fd1d310c7aa9@nvidia.com>
In-Reply-To: <54b13fa0-9405-4fc8-ae41-fd1d310c7aa9@nvidia.com>
X-ClientProxiedBy: TY4P286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fbc387-9295-4b41-a058-08de9c2adbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lYri+8uSCAT7QLHEGJiOY7zTnFaoFgia6iHFkZCPm/xErIC9pdfvjhNoLeVynyFf7WPhnwR6Z+KlY1P0wxeTcNcKK6saxsoHKcYr7bjXyfwIX8HB8rFg2w0TJbDu1jdqNbhNNMyZQMxk4V7q1EpIR4+weY/1GAVomr0csEFGrfcmwaa82VbR5JgcOhadS2LRE8iMf51QPiIXdJpMcZ90dRk5MRABqeZT/9jI5kmMVZFG6ArpvTGVlf4hO4RtJvdYu5QX0XmjueTUxdJw9KVFNVkE46m0ipw5q7BuxFrllSWxWSFtMYdP0V0SXzo3e7l4txicpl30zZDtw8RPsQlsR3gl6DpVHatzWMkusJPR86uNize9MKvfZ7Vvjq9P7JnjRnPen/rv4ydFcoNPmd1Emn2rrw0J6uZpP84BVUN7KPclWSt3x0E6wNm+dydXwa1pCh8P1BDMui0tMLJfpQJezWdka4b0GNeKIfyzwqWqLXJIv8zwPqqefe25RpDoZzW84GZRjQa364pLDbcEPM83/PQ04ccPbZEiUoWFbJ903PLBiLEM5vm3BatByMHyGVB5mH0E4RWrephpZX3VY9zEOLkgcR1eeGh0D/hfnvtqawgUITnCQRSvN19SFQSQ055jJ6jKqIPZ2QLQ1iwMWf3hMcDvGWJGr0PhBGEA/9OnZau4g2IqYrpSB3n1b10I422zD7LPuwW/8GN2NQUNjTlUGZjVcJd85xeYSEHx/hfwe/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpmSk5oZDFGUWI1YUhpdm56dGpuVGNZYVc5NnpCM1JZVW0rYXdmb3B1Zk9h?=
 =?utf-8?B?Q1pCdlY3bXlIcVBRcmxUL2JoMDN6WGZyQzdxbTRQcmFmVUlPK1FENWw3d1Jm?=
 =?utf-8?B?dno1d25XeGkxNVZTbkRYbkUvcjI0aEdXMmFmWTlYSmlhWkJiU3dhWmJXM3dS?=
 =?utf-8?B?REFsVHUyTXYyeFBiWlQ5U0ZVQ0RSZmhIenBTS2dXbmdnV3RQajRpcmk4L3Fj?=
 =?utf-8?B?SXhCQWh1enBVUngyVlEvM2o2dDF1WVVtdnpFTytVYTI2N1g0Wjh3dTRnVVpr?=
 =?utf-8?B?ZWFEcWJ1Ti9JNG05cDFwQjk4SXYrMFlNU3YwcmZCSk9lNDlYQlFoaHVHRkMw?=
 =?utf-8?B?TVpWUG5Yai9XZzhGNTc0UWpYbEYzaW9IZlJ0TEFMT0ZsN0NBR2hLc2h2OEtL?=
 =?utf-8?B?K2J0SVpaVG9raUx3ZnhQWFZvWXo0ekhORlI5c1B1d2ZBbDlOR3E0NkFBeGo4?=
 =?utf-8?B?dE1Sa1lRbGg5U2lkWVE0UDRnSGI1NktoUnQ4RlJESVdwVWh2cndFOVpjdVVU?=
 =?utf-8?B?WFRyR2pVZ2ExQVoxMWdpZVBMSURCTnJld3VEZE1IOW9lbHA0eXRjdm9mOHF1?=
 =?utf-8?B?QXc5QnJKQ3g2aXY0dFVqZ2s5MHJ4dExHOEl4QmdIM1dVRHJzckdFNitCTFdr?=
 =?utf-8?B?TXRkVDVIdko1NHZrczl6TThaNVBoaWt2SEdwaHpEcWVTVkhSWGpKeURiM244?=
 =?utf-8?B?K3Rwd0dGSEFvcGNoMkNaL2UxNmF1dDEwS3paRXY5dmJ2WGUzYXUyNjBZSE1k?=
 =?utf-8?B?ZDNLK2hBZE8weDZqOXJXc3d6Rm1FVGNydjlhZURGd0lNK1lGVWRJTU4zWjJm?=
 =?utf-8?B?NGYzdWNkdGsvTWxxanZab1ExYXhvN3VMejF1MW5USFFrMnJQZUNEeFBPQjh4?=
 =?utf-8?B?UWVINm9yTUFlNS8rMyt3azE1SFhEbWRKYkd2U09RanJ2ZkJZWG0zUEdHV2pw?=
 =?utf-8?B?dCtqNUFldVVtd2lSTFQ2YU5mS25kTDJPUFNKcVJ5cE5FVlVienVVQS96WjRU?=
 =?utf-8?B?OHp5bjdoSXlwVmg1NUFHUVg2WGtFd0cwd2xaMWhZZ0Z6WWM2VjBCcTdsMWhs?=
 =?utf-8?B?NDhzdWVjN29rMlNBdDhSR041Y01vM05wNlYvWVFMTyswVG9TUmROR1QvUnd2?=
 =?utf-8?B?MkRmejJjRUJuc1FKajlUUWhDQ1dxdFNHb2k0MEJqcXIwakVKUmRKMDJRLy9h?=
 =?utf-8?B?aFBLbTJpMk5KK2ZIVk51TERndytsMGpPQVRIVXZOK2lsNVpCQVU5bThQVS9G?=
 =?utf-8?B?ZlpJcGcwVmpVL1dQaldFek9WTWJuTGRFUWJvVnBGdnhPa0MySVRRUjMvTHVD?=
 =?utf-8?B?NUZBaWN1NVFaRUduemlyQVFKTnJLTGJBREJFMmxOOFdON0JlcXp6djZaaEpp?=
 =?utf-8?B?TEcwYXlmOEozVVlBTGdHOU1zeWlyaW9ydFh4RWNMWHFFZE5KY2dmSXluZFo0?=
 =?utf-8?B?TjRTWGVxdzladVVSMXI3TnZ1bXZ5eXA2K3hOQnlGNXU0aVNwWVhhS3JYZmIw?=
 =?utf-8?B?VlROYnU4MUdXTVNPRzBXUm5CYnJQdml3ME81dHROZGJVYkd3ZlJWLzFvcnhV?=
 =?utf-8?B?SyttRTNiZlN3QUtRL2xoTTRQZC9CNXh1SG4zejNSM016T2RpbU1MWVZlN3dH?=
 =?utf-8?B?ZmtaeVBPUCtCZ2FGS1YveWF1a2dDUGdpQ2NvRGxPVm83UGswMG5zWTJBS2Qx?=
 =?utf-8?B?cUNnSkFVbnE2OC8yS3RyNlQvc094WEthMWY4VmY0dGdRTEdDK0hWNC83RXRK?=
 =?utf-8?B?K3JaTWRFSFFnUXJQWUI0NU5NWGFVSHFDVTUwNUJGK3V3d2FvTG8xdE9HVjhB?=
 =?utf-8?B?QUEzdDFiR1JOYkxaNExlZHdsQ0FLaHptUC9vNkhoczFPUllsTitpK0pqMUQr?=
 =?utf-8?B?SndVZUgyNXQxeDg0VHJabkl5M1NwbVI0V2lEZVBUV1VIQmFwVnZLNFRYTnF2?=
 =?utf-8?B?aXM3R0hWckJnVStTbnFFb3hSdFlYM3FrVEU0Ync0YUVhZHFMdjN3Vy91ZUR3?=
 =?utf-8?B?TWljTjd0VU9oVXdzS3RycnRyMlRLUTZ6OG9jTFJBd3ZPMzhaUUd6VE53blRJ?=
 =?utf-8?B?cDMvZnh4ZVBrVG0xQTdCbmVMMk0rbnJ1MEdhL0gyRjl5RFlLYS9PUGxNdFZu?=
 =?utf-8?B?djNzNmV3RVo3bzZxcVA3WnJrdk1KRUkrbVBGMUt0NFhjUDlybVFaUzh4YThI?=
 =?utf-8?B?bGVPaEdUcmZ4VFRySTRXdXEyY1BUV3VIRFplMElGMU9tZ1NlRGJjOU5FSlF5?=
 =?utf-8?B?OGxHTHltd3lEZmFsa3hIVFYrTjlUS051U2ZhcVJ0M1NqZXNVNW5TL0hDNGov?=
 =?utf-8?B?RFpDNTN1Q2tHTGhZbVNmY2tEa3FpZlFZY082UEEwZzJvd2dhbUFNM0xib0tV?=
 =?utf-8?Q?3LqZpJiIjJcc0/UeDkmSm/2wU10EO7m9p5tcMMysGKc2v?=
X-MS-Exchange-AntiSpam-MessageData-1: WMW9fe2vbGDXrA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fbc387-9295-4b41-a058-08de9c2adbbf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:41:42.5772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGtjrgZv5GZAXNThhavo/INzNroa1+EDHjJzkXbd00UMV3IHxWd64kOF5keGq6mRP2XZm0/4l7U9QPhdkjHZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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

On Fri Apr 17, 2026 at 1:13 AM JST, Joel Fernandes wrote:
> On 4/14/2026 7:54 AM, Eliot Courtney wrote:
>> Push the computation of the falcon data offset into a helper function.
>> The subtraction to create the offset should be checked, and by doing
>> this the check can be folded into the existing check in
>> `falcon_data_ptr`.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++------------------=
-------
>>  1 file changed, 19 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index 01f65d50cbb3..0c0e0402e715 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -765,33 +765,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<Bi=
tToken> {
>>          BitToken::from_id(self, token_id)
>>      }
>> =20
>> -    /// Find the Falcon data pointer structure in the [`PciAtBiosImage`=
].
>> +    /// Find the Falcon data offset from the start of the FWSEC region.
>
> The comment change is incorrect, this subtraction is just for normalizing=
.
> It basically normalizes the pointer wrt the PciAt image.
>
> It is only after the following in the caller that we get the true offset
> within the FWSEC.
>             offset -=3D first_fwsec.base.data.len();
>
> I suggest, let us rename falcon_data_offset() to
> falcon_normalize_fwsec_offset() and update the comment above.

Thanks for your reviews! W.r.t. this, my understanding is that the
layout is something like:

PCI-AT | Efi? | FWSEC | FWSEC

And that the falcon data pointer that we get out of PCI-AT starts off
like this (indicated by ^):

^ PCI-AT | Efi? | FWSEC | FWSEC

But the actual "address space" it's in is:

^ PCI-AT | FWSEC | FWSEC

Because it doesn't count whatever images are between PCI-AT and the
first FWSEC as part of that space. So by subtracting the PCI-AT size, we
convert it to this logical space:

^ FWSEC | FWSEC

Based on the above understanding doesn't it make sense to say that
`falcon_data_offset` transforms the pointer to be relative from the
start of the FWSEC region? Once we subtract off the first fwsec image
length, it's then relative to the second FWSEC image. Please LMK if I've
missed something. We could also emphasise in the doc that the "FWSEC
region" means the contiguous region defined by the first two FWSEC
images. WDYT?
