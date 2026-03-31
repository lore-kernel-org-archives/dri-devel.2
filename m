Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4376410F92F8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD2510EAB3;
	Tue, 31 Mar 2026 19:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b4X7i2hE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7347110EAAB;
 Tue, 31 Mar 2026 19:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2tnFIWkqZeWgswn2zpPLMnabelssrubogXCUceJQVRSL0xC/QLNpMxKfGe6YJ+ODVB8juUmf9pGTpC5gJnNAOJSiIWylybLk8bnpUwT5i0kRD2CUyF84myB0awK9rg56EDAajB+uG+jCPP9tou2jZuE8OiQZAgsZaKq3p3AaNQR3H32adbb8CnPTtQac24lvtDQES2ykB1CQyqszFnMqSOoYDriP5gV96b0CYkn5CssCmbYnLeYMXDN/lfzk98zyfheup+pOCTFTaaXwXwfg2u/4qkPwq/wAGWLLCkvYIpGgcJHx064pjM6xg5IQ+uEPgMWoN2zT9iILfmjRNWUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXltOEwqHNctzvryME+LVSyo+nw1R5PIpm/wc4xJmbA=;
 b=vz0ytaiP0aBFKE6KryrocMYfS8RA1sb3XM7bZxeKikSlmk1wzj4XveiztkztVsYtjIZ7H/GrHSxDJIMCVfMlYDycfQlUSoOjUdkCyacdlxkI3kjhb8rIe7sn8DxkKiIkM/araMf1bUIa37MD35aiLLx0UkFjD8HWZ9tCmrMkBMJ4+K4SIwWyHSxyGxrWSsGvLCeB3IhPWxfqqb9xxCxc+IsvWLtw6UcX7yNCcXuIz6rFFgGj/7zjp9UB9Xam6SR9FOQ9dWi/e4kIGa8UgSGk5/pmt9WkPkNMwER5FU/l2BxXbfctfnyzDqHpdrmuhRJxykwcj21eW+uBVHaLbYTZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXltOEwqHNctzvryME+LVSyo+nw1R5PIpm/wc4xJmbA=;
 b=b4X7i2hEWlV98kjV1NVrpC74tVe8FNd6B9/aSZWc4fh9oX6dnePAp5UM2ZTSKE9fmbrI+vv0vrUbc9PtSLnAEi3p/wpe88F8M9JCvZaVhbq4q9U3e9nUV/G45lqF7RG8Tb3/DJjzjyQHmELkjDq6LmY/QtQC8a2XGmo/fEq3SAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:51:34 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 19:51:33 +0000
Message-ID: <97777bb6-6b5d-4a5e-aa33-ffb2c6e7baad@amd.com>
Date: Tue, 31 Mar 2026 15:51:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::9) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7e9fae-88eb-4e63-4bc4-08de8f5ee903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ZiAIxxgxyRfJm9OnPifWEiUZ0IG5hHp1evOEYmZEePQaFJ0weROboUimkBVXbnapkqDdpszciDwh0VQ5bIoT5Mn4UjeDcTeaYB1/ESpuFSWBFov0Sop1jzSmdFHhrNPmgqomZI48s+ZeYCynZWAsq2q8nM1Z5L1oqFX6vG+6eqXAq6iiABC2wu83t1SeXKg9MN37csBHqSOHS8eK/4Cg24Tv2EdsOTqB/99ibsZUUrHqK6vHeMSQATMIIxHBLOtid4K/9OsadVAoQ3rudciRXDiSpL20KpfOSN9rma6OWdTEveZpDfYMethCUpaq8DPcGkyR1wic3bzAId5N9/PHj8D49OwA9AHFECMXwm4E4UzCkAzlwkNfQE7M5WvnRK29BD2+BSRwWS91BQno4dwZvS9tCApq/Jnqoo7Cv516YfwzpDa+I4ACxVo2YcRmuPh3teUian3Rd88jjArXcZVRfw3o8zCUN4wihNa64mMUC572+bVhrRSN6Za2kgFEdGmAfbGzDXRauNTeoAKRj3oGdLiWBnIGai9xzGBNHD+ORO5quRO9yIHFetDWH5k0z+xdAWt/PVZ1C0MKDvlHZ0rmamPLbpYhvPnYEL/S+FRwun5QT+KVeRk2/HAh1Ccd475Nb+Kb0b8+9DMXn0GfZxVf0s5Hd2EgdrfYCQl1ieIdy3soUny6EUzWky8T8rflLUhuV+2GhHpHCPfxVKzlhh2Ro4VGuy21SgEGEFSMOf82Tx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlCNVl4OHhNVTk1WGg0Q1NHVzhQOENNUWNYQk5xQy8vc2F2SnRVOEhyOEgr?=
 =?utf-8?B?cUNTOEdNaUttWDh5SVhpWFBWRU9IOTQ0a0xaU2J3YzBSN2lzcis0Uk5SUkdX?=
 =?utf-8?B?bWFxd0ltaGszYUp0Ung5VWFSL0k4aGx2Zi9JbUMwWDJkbElZQ1JBQTlGZmtJ?=
 =?utf-8?B?MUhicWhBeGxwQUpja0pvckRVa2JZRGZWUEJWZjZXWVgxNmVUVmNmTTUrWDFB?=
 =?utf-8?B?K1h0VUJFem1aY3ltM3dnVGJjcVBONWhOWnIybHNlVlhSTzFSd0lacU9EYS9z?=
 =?utf-8?B?a3RFcmVNMXBjVm9hMU5XNkVGY21rY1hncXhLMU93UFBteWVNd1VYd1d2Y3Ja?=
 =?utf-8?B?cy91VVZobmRSaVdkOWNub3BpTWtyNEZsTU1icFlYVDZ4WXFSa2lKSVpEelZT?=
 =?utf-8?B?aTB6SzlnMk0xK2xlbSt2SnN1ZmFIbUVmRnU1R1NZTUhseVQ0M1Q0VW0rVEhK?=
 =?utf-8?B?ZXNlbDNoNWdGOG1BSm93YmduZ2RCbjZwNGFucGJrTSsrWkVoelA3OVJ3Zy8v?=
 =?utf-8?B?QTNNc0c5d1NOeHQ2dnFvblgzS1Y0c09nZmN0MnhXd1BqV0tWN3p3c1FpcUp6?=
 =?utf-8?B?SUIvcVJRc1lkU2lCZVY1cmxSeE5RWisxNmRoQlBvTXErSEh4aVFJUEgwT0I3?=
 =?utf-8?B?c3lYM1dIcE1RbTZlUmtpNGhWM05RMmtwNFNzQTlEcmlwWE52dld2QUtEaE5Y?=
 =?utf-8?B?c000bFgyVmo2ZlREU0hIS1BsV2RwbUFDWWVsMEthNGxTbGpKaXE1YWoxYkto?=
 =?utf-8?B?OW1GRmczMWVRUzlkaVA5dW43M1NFNFM1cmI4U21vZDNtTFJaVng0TVN2Qlpt?=
 =?utf-8?B?N3U1MzVnWmFzVWwyemREZXI1MFpKb2dScm4wRTB5WTB1dEYzNU9vN0RoMHpy?=
 =?utf-8?B?d1U3TEtXNDUvalBvYnFRWWNRMGhwM1lhdXNhYzQ4aTdRb3l2YktxRnlOTnk4?=
 =?utf-8?B?Ly96ZzNHNEUyQWppYkQ1NVZ5UTBLVDF0bkF5VkoyeGcrbkdvRGkyeG1uWnly?=
 =?utf-8?B?Qjl1ZXF4MlQrUnNGWGpoMlVaOTJWM0FMNEhWQm1ZOHNsMmhVUFZVUWxTRk1F?=
 =?utf-8?B?eFFvQ0doazJoY0tYTGRCdlBLbXQ1RHlOU1JJL09HUmdLU3F3SjJYY0JRZmFq?=
 =?utf-8?B?V0E0dWJKWXRaQUkxSUh3aDNlNFBkWjhxdmZ1RHVWMmo5Yi9QSk40bmYrUlVi?=
 =?utf-8?B?dGYyWVRFQ1Z2YXBkUHo1WlZ5enlXVjZ2d0dlYWY2L1ZsZDROdTEwcDJ4RERC?=
 =?utf-8?B?S3Q4Yk1IQThTYWlOcjBaK1JpSHl0Y1p0TXlSNXZVYis4NDRHZjlpZmpTWlh0?=
 =?utf-8?B?S3B5UEx6R2tIN2xkT0p4cUxyT0p3VG10TXo4RXJWbWh2WjhqT3pabGRnVFRn?=
 =?utf-8?B?dXJXdEJYeUNIdVhtMTNzWHRjUWdjQVdEU0N2UHhvbmI4cnFqc0F5TDFBQnJr?=
 =?utf-8?B?dUtOVzFuMnZUUW1BYldHZmdaZSszR1RQMFR1cHFPbkFSVDJlOTQvS1lKRWJn?=
 =?utf-8?B?dVlrNThMWVczdmIrUzErWmRVckdnYVVjUkRkaUVHQ1laZTZ2enQvQ08vd3ls?=
 =?utf-8?B?ZDNTK2N0K3ppaU1WRHZOck5EUkt0NE5qUEozWnhCeUxLSUdSTnFpK3B6RkJz?=
 =?utf-8?B?OVdwRStpeDd3MVI5QzRqM0pWWk03TE9FbGN4cVpodzBuaFAzTWpMSEc3cExN?=
 =?utf-8?B?cWt3WUZMcWZTQ0hOTFVIQjJPemxWbWRBUWNmOXhaK2ZUbEludWF1d2tKcGUx?=
 =?utf-8?B?T0hZYkpGYlZoOW5FcGZpYmVQdHBsVzdYVDJTV3cwaWVYWG5NcWxtS25uaVBz?=
 =?utf-8?B?OTlpNGxUejJld1dBaGhVTHpIVnpmTjFhQUYwSXpjblB2dmdHdjMyZUlZekpB?=
 =?utf-8?B?UjVNcXVLQVIrbzNKZzlFT1dTcms0WVR5clBnZXc1RWQrRTFoNy9hUFhpcHNE?=
 =?utf-8?B?Q0NMKzF4bStYMlpNYXJuOEZoK0tpQW9jdGpxSTlZR0FHRElQQ2hiU0ttUFA3?=
 =?utf-8?B?NjJTZGplTXd1M0ZGUFRnVXBIUXNOMjBZSzJYcDd6bWtBa2NoOGk2WVZGOXBr?=
 =?utf-8?B?cmVMK0ZLdDJKSFlVVUFrYXdXUlRTSzYxVXZGUUltREpaZjJ4SDA0YUJ0OVBa?=
 =?utf-8?B?QWJNbC9QNHl4UFBYRlFNbWF0UGNXczQ2VjVnWWZKNkh3K0ZqMlJSOXNwRHUv?=
 =?utf-8?B?RGJXY3F0ZDVmMWMxd21Mckp1VU55WTZYaXFaeC8yVmpaajk3anlwMzRZSmJp?=
 =?utf-8?B?RnV6WVRBSjZScXJUM2xNbU5CZFRmSEQ3VVA4elErMCsrcEtVNnViQ0pXWVlP?=
 =?utf-8?B?NFNXcHRtVCtMdmp1Mk9TMmUxZzJ2Tlh2Rlh2dVpvU0h1M09XdlJJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e9fae-88eb-4e63-4bc4-08de8f5ee903
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:51:33.4437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDj1xcwT9B/b3lxqigIDFYp32a5RZeb1Fke+DnrRq2K+qidIb+FugWzBZNBcYurWuOc1Lfp4ySileEp77q4VMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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



On 2026-03-31 03:16, Michel Dänzer wrote:
> On 3/30/26 19:36, Harry Wentland wrote:
>> On 2026-03-30 12:20, Michel Dänzer wrote:
>>> On 3/24/26 20:20, Mario Kleiner wrote:
>>>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>>
>>>>>     I believe we don't have surface info in that code, but one way to work around it would be to use spatial dithering for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spatial, some of the earlier complaints about 10-bit output having one-off bit errors will be coming back.
>>>>
>>>> Looking at all callers of resource_build_bit_depth_reduction_params(), they all have access to the associated "struct pipe_ctx", which should give access to pipe_ctx ->plane_state->format of an associated display plane. I could prepare a patch that passes the pipe_ctx from each caller into resource_build_bit_depth_reduction_params() and that function could check if a 16 bpc framebuffer is in use and switch to spatial dithering down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc otherwise.
>>>
>>> That doesn't really make sense, the output of the display HW colour pipeline has more than 10 bpc regardless of framebuffer format.
>>>
>>
>> The output will be determined by the link bandwidth, display-advertised supported bpc, and userspace-selected "max bpc" on a drm_connector. This could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the internal DCN HW representation of the values?
> 
> I am indeed.
> 
>> They're higher, but that's somewhat irrelevant.
> 
> How so? Surely dithering is applied to those values, not to the original values sampled from the framebuffer.
> 

True, but if, for example, the input is 8bpc then the intermediate
representation won't be able to add additional precision.

I guess if there are color operations on top of the 8bpc content
then the values might be shifted in such a way that outputting
or dithered 8pbc will be a better representation than 8bpc rounded
values.

Harry

> 

