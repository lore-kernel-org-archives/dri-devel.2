Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D1E10F9300
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D575610EBA8;
	Tue, 31 Mar 2026 21:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a9yrPW5O";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220D310EB59;
 Tue, 31 Mar 2026 21:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3jDIndk7rtw+EEb48apaXN7cQ7ZvVRx+u761nZTpEM1IdwK72ZExFGR6tKvEaCBFqBoNgDS+TSetpK5cpwF50vUzWd9hUIZywJqanmjDUUpAs3jJAYkGg4V6oiFp5wp6jRnigoTWOv7pJ/y+3X8OZ6N35zIrqb1sCH9rhUiqFf7BgVWlVC5ZTWQcCk5qAwQeZmX/MujrX8M3eFDwDh6U2Rc3W2YQcSBMVWHZBdRrACylVX+rW9N/SHfyMrRzBYspDlErTGm9yzMl7dxwZH7tRjdhaMh7bDeLfnVgWbwT3kX6WYSPNS7Ouq3zyVEY2voio+rhyDDi/jRyQbl34+92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAG+3+cMW0SViSPZRdh6rSoei2nvryhmaco2VNmZCuE=;
 b=ynsa1AcDPA+m/0vhPOJdvu/VTptxKo8ygQgC8zZrpxywqlq25t8u1fw0jp0xhrdPeBCpVlSs26cvBcFC5gffK2qM8yB2z2cZHe7WmhKtB1wdVhcutfL7tvpDuZ1Ev+42ewoycqEXACbZO84mOusnM0LMOw9++Pu2nESy1m1eSgFFxGTs5V+NWaCCwx4nHmzNbo1NssF2L7AJ/WNBSrrfnultocA2dyJJ7C2RjRN8S2eW6tjA7ayNR5LrdUFa2Vdje45h+gtb/1DdhSTlFRvE7ahQcT7EQGiOR5N1BnVClIiiVVNzL5oA5nDyu1j9QMmtWkP/uAf1St+X+RFk1Ete4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAG+3+cMW0SViSPZRdh6rSoei2nvryhmaco2VNmZCuE=;
 b=a9yrPW5OY8OEI/AwdMUmhXOPCdtGqj6pS3tvy2eZd8N0U8DgYxKbwhumRtJ3JgzoJhDBdewEI9cj0zY6SYKxTYTEPH4MvmS0qEF7uH8ibxO/2ChfwaVMxFpuVr+gTys6MuMxYTOSfFg8RcAPnXysPwstdSuHhsckwKiXemNpId0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 31 Mar
 2026 21:06:39 +0000
Received: from DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4]) by DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 21:06:38 +0000
Message-ID: <220ec077-3187-457e-b42a-7b2bd87528f6@amd.com>
Date: Tue, 31 Mar 2026 17:06:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Mario Kleiner <mario.kleiner.de@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>, "Cyr, Aric"
 <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
 <CAEsyxyie_2Tr9_3vqz3N=_9u=Z1b4SqBGMcptKW454XH5ZEsQw@mail.gmail.com>
Content-Language: en-US
From: "Kovac, Krunoslav" <kkovac@amd.com>
In-Reply-To: <CAEsyxyie_2Tr9_3vqz3N=_9u=Z1b4SqBGMcptKW454XH5ZEsQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::22) To DM4PR12MB5213.namprd12.prod.outlook.com
 (2603:10b6:5:394::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 38840621-b46d-4281-c273-08de8f69666c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: u4T890j+MhlrEpm2Bm3S6vt2B8zVy3JfXMQ2up9A3/Ap4WSXhzMrPYS6KgNh0i7AloMxeqRpUwdAeeXNBnT07PHEsNc5as5Jn8iBhO8VlS+UDsev+Gnj3j++rLDc5gZfkkE+k1KnJCXEurpN13oML8yQCVwoUowS2C9b2Le2UM0mCHhf7RwMtT2+fH0aQAjPX1aJELb+TLzECwM21tStCYTe4qfHjR1XRYdbQT+SYkx/GXnIzJXSVx7V5KnY5LgYOH52/vh7vOdHCmbTvFm8QMQniS6+DoEpN8TyXQEOXKC0L1dDsv0fMzTvR38xSj5nbXhfUW3VsaKWAE0sBpkyzupaVVspJ3Z1Bo0+0nmvOaxGzHVv5sDf9mXHAXSMF8K2eOnk74TX8lvFbVZpF8jXrHVn9KutuPGokNFCweFNBrja3JE8DHXiRo2gsv/zVPfshimcWGHKtlhNtENyaZQVWtQGvLWdk5ZDVpZCw432PMAFOFwLS8gZv1PmLKEEwKRWlsk2bbJN4ndRI+e9ZKzHY9AgbQG8Kz4RsMaz1v7DbrdnCV68us09jtmcMYkyb3BDf7rI/SDiANVFJy18dIG6GbfuINrY5VumbYJFidvYeOXPZc3hHA8iUKrYRzAQ9my1f3ak13MrBRlZv2wAXtYj/1CZ4UAfgXSWfUn/+yB1CmxPksJKt82wSVfiFBEYTCQJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRXU1RtNzBGV20vYitNQ3BCeDVwcXRzU09Ia1RGMGYwa1I5VXVWditkckx1?=
 =?utf-8?B?TFJDNDNSR251UjhzOUhrYTY5WDNJVHJ2M1ZVcjBJeDZabUVYS0pENTJ2Umtz?=
 =?utf-8?B?bnU1LzlSdGZDYVVjckhMaml3Vld2dWRLMGJtQ0xNOWU1M1hic1JEOWUyRkNI?=
 =?utf-8?B?RHZmUXgxd01FVFZpaHU0QTZOQWJlZzZIc3VhbW9ZSndaaXNuUEdGTTVsWEhz?=
 =?utf-8?B?Z3lUd1BrTy8rM3pMc1lFZmpzbURDaEMxKzlNMmJqSm1HTmZsWEhZMy9PNHYw?=
 =?utf-8?B?SlpHaHlabUVITXZMRHR0SWUrOHlaSlI0TVM3d1dSV3Z5bFVvWjNBazV3dUsv?=
 =?utf-8?B?T013aGRra2NNbjFwUzc4VEoyajJ3UTdhZHFEb1dmSURVLzdrUDliQW83eEJj?=
 =?utf-8?B?M2sva0tNTmhXd1pSTHdHL3E0NGdUYldGMGpNR0trYmlyc3llcGJCYmZKRGNF?=
 =?utf-8?B?NUMyS2RwV3o4VlhzOXRiV2I5NXROMlFCa2tzdmtCSDVnWkFITWJRbkJjZjdU?=
 =?utf-8?B?Zm4xNGJPVG9vUFdxRHdwZEcwak5Hc2xwUDRxVHZBRmF5S0lNK3FReE9UMWs5?=
 =?utf-8?B?NFlhckhOMS9oa3RHMko2cUpBYjhYd1dCeXFBVmI2WDlIS1N3dDAxanRVNjZT?=
 =?utf-8?B?Q2xVOGxiQnNkK3FYVm1RWXE2MnowZGQ2ZkVQSFRwanduZXRFT1NrV3UrWTZh?=
 =?utf-8?B?UXRWaTJHQXlsZEVMRlk0STlGWjEvRllGTmxYV3NIRk15V0pMUDlKajQxKzcz?=
 =?utf-8?B?Y1JXQWxjUVRxYWJqKytvNXNOb21wSzNCdndhUGtuQXQ5KzNzWmtkQnlnU3RV?=
 =?utf-8?B?aVBuekovQnlEQ0tNUDgvNUc5dXZodit6eWlMNFVLTlBmWFo4N1VRU3drNGJN?=
 =?utf-8?B?YURsa1ZEUjlDMTVlTEVxM2l3aXB3VDhmZWpFaWRXb081OWZDMW51dVY5em5m?=
 =?utf-8?B?bzZoQ1pncXdrMnRsaVN1WUhrV2ZSc0tyRDVIa1BzTnozY2x1NkIzYUZBY3Nk?=
 =?utf-8?B?bjltck9KMlR0emR3dnFsWGVrOXZOeGhyRWhqSXlEQWgvcGU5a213dTd3MElr?=
 =?utf-8?B?K0hJYi94ME1Lc1ZheG4xcTdpRUNIUno3RXRHUnNrUFRUdlJWY2FZcHFRMlZt?=
 =?utf-8?B?UU9ySDMxNjZIb3hDTlhUSUZpeWdGKzQyUmZCMW81eGthOStVR1NLVisvWm94?=
 =?utf-8?B?OTJDYkgzamVsa01uZk55SExYSDJWS3Y5Y2hxZmRRN1B2ZkN3NlRja3pwSitU?=
 =?utf-8?B?eTRjcTlZR1piOEdudXRzQy9YTEU3TGRwQUwwSmU2aGdXSlRWUTdnTDM5eUQz?=
 =?utf-8?B?anpZZURUS0dneHJubzJpSnNWc0VYUi9uTWNGcVVSUzhlS2c2b1ZPbkFnRnNy?=
 =?utf-8?B?NitRczlzcFVZVG85MjkyaC8ydlRxU1JUZ21CWVFYOEU1dXpFT05mNk1kK2sy?=
 =?utf-8?B?dGVSSXRzblBKTEswMmN2SUFwQlgzTDc4N1l5TjJxVVFRSWpMNmZ0dVFVNEth?=
 =?utf-8?B?SXptZnh0ZmV2M2tIN085UlM3WUg3aGZ3Y2x1bjdLVVlUQ2xwaDNPcmE0VlBS?=
 =?utf-8?B?ZUR6RzVTMTNHODN0R2NnS3c2a3ZaMTRrMlpWd01lbkdWV1ora0c2Q29pN1Nu?=
 =?utf-8?B?c3dHMlRRcEFNa1dYVnZTVHFkZWFCLzloMzNTSDlNOTV3V2k2VHBNRG9vK2Jo?=
 =?utf-8?B?bklrMUdKMVhmZmFOdGFWVkIxYkN0UXFSdHNta3cwb3FDcHNWNHFaZVhyUjY5?=
 =?utf-8?B?dVFNRllpcXNPbXVEdkgrYTJIMis2eE41cXQ2M2JCRExUeElGYU1USDhXNHp3?=
 =?utf-8?B?ZlYrRlRuRzNTbk9BQ1M0allQa2dINk9wbGFYU2k0SFh3RmRtVXB5YXMwcXhm?=
 =?utf-8?B?dDlGYUZ5S252N2d4cEVGNW9SSldZWFc1anFtcys5ZEFzL0k2R2gxMWpXSWVQ?=
 =?utf-8?B?SmdrMnIrL2hucFQ5T3lGTkV3U1ZPUjRWL01CeUE2Y1l5TEpFd0U3TVZneGFT?=
 =?utf-8?B?d1IxU01weGJFQmJDUjVveWc1Q2RWRVJIL0ZPakhWV3Q2eEQwL1lXVG4vd1p1?=
 =?utf-8?B?c010ZjZUVVhERGN4QVRVcHlDR3ZKczVrSFpPZXVOTG83bDBFMDlSbWtCL0JV?=
 =?utf-8?B?SW15RWMzV2VFSzEzQlhMTVEwWHVLWCtObDNvKzVtTnhFZG9aSUdzMlZ5WGtH?=
 =?utf-8?B?eXJveWR1MXFPMnRhTUpucEZFZ0VWRjJhOWdyTlZOeE95RHJub0JHaVdCbHBv?=
 =?utf-8?B?VzF6NHIyRGxPR2tPOUpyRW5EVWdqM054TDJHRmxLOGxmTXpSOG83MjhHdU9p?=
 =?utf-8?Q?6xNpPz7yHwDK0LP22+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38840621-b46d-4281-c273-08de8f69666c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 21:06:38.9101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHGQdV0dJBUe+OwWsh4a173HUPLGRZY9Mbt7tgnMeF73e6Sc/wVhcdlPSN5lNjH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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

On 3/31/2026 16:13, Mario Kleiner wrote:
> To clarify: I do agree with Michel and Kruno that in most typical use cases
> you'd probably want to get all or as much of the internal HW pipelines
> precision as possible to the Eyes of the person in front of the display, or
> at least an approximation of it. My understanding of current AMD hardware
> is that you can have an up to 16 bpc framebuffer, which gets
> truncated/rounded down to 12 bpc somewhere in the pipeline (gamma tables,
> color transformation matrices, etc.) and then retained at 12 bpc until
> shortly before the actual output, which can be 6, 8, 10 or 12 bpc depending
> on connection type, bandwidth, "max bpc" etc.

At the start of the pipeline we immediately go into a 19bpc space. Except around 3DLUT, all color processing happens at this precision.
It's near the end of the color pipeline that we go from 19 to 12 in a block called DENORM. Other than some specialized ABM block, we then go into FMT that does 12 -> monitor bpc.

I didn't see any difference with my capture HW for 8bpc->8bpc either, so I left spatial dithering as default. There's enough extra precision that apparently it doesn't matter here.

Maybe your case always has an FP16 plane, say compositing space?
  
> If the final output depth is lower than 12 bpc one would usually still want
> an approximation of 12 bpc reaching the "eyes" of the person
> (/animal/retina in some of the use cases of my research users) in front of
> the display, and spatial dithering down from 12 bpc -> 10/8/6 bpc is the
> way to go. That's also true for most of my users use cases, and especially
> for the use cases involving 16 bpc framebuffers/surfaces.
> 
> Some more special use cases will require an absolutely perfect identity
> passthrough of pixel color values, where any kind of transformation in the
> pipeline, including spatial dithering, would be bad. Some of your customers
> seem to require this for 10 bpc output. Some of my users require this for 8
> bpc output of a 8 bpc framebuffer. Specifically, some neuroscience research
> requires up to 16 bpc color or luminance precision, but all graphics cards
> and normal displays max out at 12 bpc. There exist special display devices
> and converters that can do up to 16 bpc precision (native or via some form
> of spatial or temporal dithering), e.g., the Bits# or Display++ from
> Cambridge Research Systems (UK) and Datapixx, ViewPixx and ProPixx devices
> from VPixx in Canada. These are essentially active DVI-D or DisplayPort 8
> bpc to 14 bpc or 16 bpc VGA analog converters with 14 or 16 DAC's, or
> special purpose LCD panels or DLP video projectors which can do 14/16 bpc
> precision. Because commercially available gpu's and PHY's do not support
> true 16 bpc output (the DP and HDMI standards specify such signal formats,
> but no actual transmitter hardware afaik), these devices encode 16 bpc
> color content on top of a 8 bpc framebuffer and link: The software renders
> 16 bpc unorm/fp or 32 bpc float content and then uses GLSL shaders to split
> up 16 bpc into 8 MSB and 8 LSB and puts the 8 MSB into the 8 bpc red
> channel and 8 LSB into the 8 bpc blue channel (and 8 bpc color index
> overlay into the 8 bpc blue channel) to false-color encode a pure grayscale
> image + some 256 color index palette overlay. Or for true color images, it
> sacrifices half the horizontal resolution by putting 8 MSB of each color
> channel into the even pixel columns, and the 8 LSB into the odd pixel
> columns. So a false color 8 rgb8 framebuffer -> pixel identity passthrough
> -> 8 bpc link output via DVI-D or DP, and the video sink then decodes and
> reassembles again into 16 bpc color/luminance content and uses special
> display hardware to these 16 bpc into the eyes of the being in front of the
> display. Some medical imaging displays, e.g., for Radiology use (e.g.,
> cancer screening) in hospitals or at eye doctors, also use such special
> framebuffer encodings to get > 12 bpc content out of the gpu Siemens
> Medical and similar companies sell these for research and medical use.
> 
> Another use case of my users requiring perfect pixel identity passthrough
> is to encode side-band signals into the scanlines of the vactive area of an
> image, encoding binary control data and packets as false color pixel
> values, similar to the various info packets transmitted inside vblank. This
> for control data that is very custom and not standardized in any Vesa or
> HDMI standard, e.g., in my case to control special neuroscience hardware,
> e.g., sound microsecond synchronized to pictures, sending various analog
> waveforms to electrophysiology equipment or haptic stimulation, or digital
> trigger signals to transmagnetic stimulators (magnetic pulses to brain
> regions), or start/stop/synchronize various recording equipment (fMRI and
> MEG scanners, electrophysiological recordings, video capture etc.)
> 
> For the pixel identity passthrough, the difference is that I only need it
> for 8 bpc framebuffers to 8 bpc (DVI-D or DP) outputs atm., and that works
> fine under OpenGL with an identity gamma table loaded, despite spatial
> dithering down to 8 bpc active. Right now, I neither have the need nor the
> equipment to verify 10 bpc identity passthrough, as my capture hw can only
> process 8 bpc signals.
> 
> I don't think there is an automated way for the driver to guess the proper
> configuration in all cases. The proper solution would be a drm connector
> property that can be queried/set to control dithering on/off/method/target
> depth, and plumb that through. Or maybe something that could be derived
> from existing connector properties? E.g., if a content property has
> something standardized that essentially requires identity passthrough? In
> my case, it is important that such settings still fully work under native
> X11 via RandR properties. Something that is only realistically accessible
> via an atomic client or Wayland server is insufficient for me.
> 
> So yes, as Michel points out, there is a disconnect between the framebuffer
> color depth and hw pipeline depth and what dither settings should be used.
> But Harry's patch, if it worked, would be at least a good enough
> guess-o-matic or heuristic to make the situation better in the short
> term, even if it is not optimal. Or at least for my users use cases it
> would make it better, as for my use cases the framebuffer color depth
> usually corresponds to what my users need as effective output precision.
> For me there is also the urgency of wanting to have a not broken situation
> for Linux 7.0 and upcoming Ubuntu 26.04-LTS / Fedora Core 44. If I have the
> choice of having the current state, or this patch, I'd gladly have this
> patch as a step up.
> 
> I hoped this patch would be still simple and contained and early enough, to
> make it into drm-fixes for Linux 7.0, and maybe be backportable to older
> kernels, as all kernels since late 2023 are impaired from my use cases
> point of view. But as I said, my testing didn't confirm the patch is
> actually working - it always ends up enabling dithering. Which, to be
> sneaky, would also be a step up for me, as that "only" breaks use cases
> that don't affect my users specifically :/
> 
> On Tue, Mar 31, 2026 at 9:16 AM Michel Dänzer <michel.daenzer@mailbox.org>
> wrote:
> 
>> On 3/30/26 19:36, Harry Wentland wrote:
>>> On 2026-03-30 12:20, Michel Dänzer wrote:
>>>> On 3/24/26 20:20, Mario Kleiner wrote:
>>>>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <
>> Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>>>
>>>>>>      I believe we don't have surface info in that code, but one way to
>> work around it would be to use spatial dithering for FP16/ARGB16 and
>> rounding for 10 bits. But if we just switch to spatial, some of the earlier
>> complaints about 10-bit output having one-off bit errors will be coming
>> back.
>>>>>
>>>>> Looking at all callers of resource_build_bit_depth_reduction_params(),
>> they all have access to the associated "struct pipe_ctx", which should give
>> access to pipe_ctx ->plane_state->format of an associated display plane. I
>> could prepare a patch that passes the pipe_ctx from each caller
>> into resource_build_bit_depth_reduction_params() and that function could
>> check if a 16 bpc framebuffer is in use and switch to spatial dithering
>> down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc
>> otherwise.
>>>>
>>>> That doesn't really make sense, the output of the display HW colour
>> pipeline has more than 10 bpc regardless of framebuffer format.
>>>>
>>>
>>> The output will be determined by the link bandwidth, display-advertised
>> supported bpc, and userspace-selected "max bpc" on a drm_connector. This
>> could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the
>> internal DCN HW representation of the values?
>>
>> I am indeed.
>>
>>> They're higher, but that's somewhat irrelevant.
>>
>> How so? Surely dithering is applied to those values, not to the original
>> values sampled from the framebuffer.
>>
>>
>> --
>> Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
>> https://redhat.com             \               Libre software enthusiast
>>
> 

