Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bU94HxPL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4C410F38E;
	Tue, 27 Oct 2026 10:21:32 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3099910F38E;
 Tue, 27 Oct 2026 10:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1vm8G5rPmAzeUCghcwHfm78wgq9mWQ626ux3CMWn3NuDep8K9DA4WTmTv0ApPH2KpXPteGgIgWuRuw4y+mpGgEVvkKPCIVniAOsGODoZCeekLAJt8ziYp1nnA1uKVt7jmwHS4RkfPyIx1jOc8M/8iebZVrVESL/2w+oAj24rYfiazmqy9N04yjT9XmbnphSqC1j9u5OlM64MpD19+fCSDFtbZACLz/33X0t890JkeNXd9ettdn5Rvtf3DY93FWC5z4s3uydnCb+P0BhqnMH3mRTEiT+5HK5dFHkTgTgqQV8bG9Za3ZaR6CUgFlH6ViQR9OpumjlrU4fz90q7sK3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I3CsnTGXy6PU7EVAgWpky42/5QXDKyvv0XZvcADBxE=;
 b=fJLrm55TAMHy/V5E5IJSic/8qGBWOU1LzTlaaA0vdH/NaWKNc2MEa6P2jF9fnV6sSxpier1BKIgAQN1kUNPvvK+3/TRXrvfz6tAcNrLEEbuQFPEp362cZm3qmnUhTCS2ja62VnG+YHQNBJEwKrTlCVqyi+IAHc0WR/Fi8GT3uvuNtLxJ+iIai4O24eIqgYGVZ7stE9YSG6PMJ3G4t2/eNRM057CM8JKdWWR01vASUDileVL9MMqlu4hkcArFpCMjaSvzkXKxUUzUKtJzpfxnbIg19JPqUnvUfTt8fj3to5WxBSNSRvA7ZBQ2xgk+jbjI9WYXwbHl9tHhhT21hgzLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I3CsnTGXy6PU7EVAgWpky42/5QXDKyvv0XZvcADBxE=;
 b=bU94HxPLqB3VesaFqHCdLs5ok0tNaZjW/UKP0/hT3dGjxC64GKxNLco4qt/DkAobsSpbsqTnbsoA+Ug0F8Pg9SSMRxBsi+uT3v6YYXjqMYc9yAJ47pnAonmQZudFrFPlOfesapNfgjeSv+J4xABY6xQSnSHhFdvZyhCXf6toXbE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:21:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:21:23 +0000
Message-ID: <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
Date: Tue, 27 Oct 2026 11:21:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
To: Matheus Tagliari <mptagliari@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261027001506.27266-1-mptagliari@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0366.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: b57ea6ba-8fc8-45e5-e896-08df34140cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: UOAl64ckunff25MU+mRV8UN6LcfadFAijn37SMobIKseuJaAB8hdIR56WrDK7X7KLK+34DcZccKzlhhbk/NlUDnbbVx/h04MJP4kehiOHIRkEPf8c8It7UKRF/Wm9OE2cL7WJoSuYhf/+vCrnZMJs/dvd88JW5W3OB7V0WW9kCpVhBZczLFZPEJiBntXK+2MnFPOqq8Xv7RN64HWchABJOZS7I1J7MznixyYBcyE8UCpqFPHDqT4UVY6QiUMM9XoKwlYUWqZtW0w96SjJKGuJjE3qtbu/DW0VP9tSt8xg7pM49D/aIXZqxSfZR14KOlgCg8FEojiJPiZ8UFv+xSfN0uSVINM912XFklqpnymLlwC7KWtagUUTHTwg6cUm6+7waB9XCRsYkFG1GfXsWGfKDS1oJu9eKWinUZVxqPxlSyU7C0YquhDh9rY3k8oia2gxVlWy9iibXyNv2BpM6J2XtK8L7ED4zdmuzbOj9PMczR8csek3g6R75Z2Xa3OhCPC0I/JoUmkr9mOGfnoLRoucGdnEvqcYIq3bSRjBcSMj3eJgtu2IIFbQu+8B5vEPEoCMghyPAHGqW9RgRAc6I8r34Vl4EQ2TFt9zO5s4vbk42wL1UfKv83nIT+uB9CwOZpDTRK48kgOA3REnkBMxm46wNasSJ2TuJ7vbmQWTkuwXz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW01NnUyc0hhVEhwWVlRVnpOdXpIRzJmeFVPdDlIUTJEQmppcVBWdU03K0lu?=
 =?utf-8?B?L0dwQXNaTGNxbmEvQ2xvSTkyN0VDTnBUYnJiTGZndkhWbnpnbUYyeEZUWmxL?=
 =?utf-8?B?RTJpcm96K0p3NkFDd3MvMnRUTjFmcXNTNzFPYXJ0R1JQWU5RZHE5RmZaaWNP?=
 =?utf-8?B?aE5YdEtyZEhGSjI0b2IyWU43NDBLQ3J1bWhPaG5xUXByVlBxdzhZbGRWNjFY?=
 =?utf-8?B?QVBuNUhJL21jUzQzdzExaE82RFVFMTZaRzMzcEh6aElhR1p2Q25IaVZTdVZs?=
 =?utf-8?B?Vm0wSUxvOVQrelk1Q0R5aGR6dGZvTWtMTUxMelF4d0hrUHN6RURaNjFJZXR3?=
 =?utf-8?B?SzVrbmlPUGoxdTRRdHB5K0NZdjJSblpFU05qcEJVMzVSaUtaWGg3ck0xZ3BV?=
 =?utf-8?B?NXhpK2RqbG5BSmh5Z0RuSjQydzA2SmdnWjFlTVZzNzRwd1NJd1Y5TFdTb3F3?=
 =?utf-8?B?YWp1M2FHRzhSS3Y2UlRQWTVUODNFWkdHN1Q4TDRqUU5Xem5DYldZVjNDZVFQ?=
 =?utf-8?B?SnZNUngzNFYyOEFLNFNRUW5aMm5NK1BZL0FkZXUzY3JuUzk0N1MrTDVla2o2?=
 =?utf-8?B?d0ptdXIwT2RHSGR2QTRvM2xtYU41bmlhT2FCTEhKMXNqa281a2V2eFdTdGdk?=
 =?utf-8?B?T0s2WkU4ak5kZm4waDZTamdkMWh3dGVXTlFRSVhMbmVWZ0J4NjU4VzlCMmNJ?=
 =?utf-8?B?WFZIRVpYWDU3eVgrWXNsb1RVRmt4ZUtaS0hQMFhMbG10b2dOUlJ0dzRvY0FT?=
 =?utf-8?B?RFIzQ0d4N21WSzJSSlE1M01sU3JaMUlUdFhTbCtsOE9GTldrTURLWm16Y0tx?=
 =?utf-8?B?ZWRPL3ozd0loUGRRSlJ2TmZ1b1U4NjhIK3lkU25leWxoY3NvcTBIbFdHOUZF?=
 =?utf-8?B?TlY3OUxYd1pYT1ZINGovd1dCcGplTUo0WloydmMrQVBncmVucTNzQ3p6clRz?=
 =?utf-8?B?SkFTL0pkUlZzOVFRQktaSkhmV2JxODFGa1Rtck1yNjAxZ0I0ZHJUb1REZ081?=
 =?utf-8?B?YkRkbGJSa0d1eTJzRjIxWUdNazg5ckhUdGZERlg2cEwvelplYy91VWc4SGZn?=
 =?utf-8?B?QzY1WVJzT3BzNEV6cTNhcXVWZkRkNWZqVU0xS0xGN0FjTERMSGJUOEpWbTNl?=
 =?utf-8?B?ZkNhRmtNbFQ5UkQ1QUdHYlMyQm14Umw1aHlSc0YzbTdGbVE0emp5SDVjb0tS?=
 =?utf-8?B?UmxUOGhIYVROcUpZSEpoaW9yT1dncUxUMG1zck1hSXYxSW9GbW04V2RtSEdh?=
 =?utf-8?B?b2czeEo3YUU3QnR6V3JIWmYySWl1L2V5WU16eVdsdnRqRnZWUFhhbUYzTGNO?=
 =?utf-8?B?NTdOQUJVZFNaNy9BeWNmeWVKYUQrUXBuTjl2TFpnY215N080Ylh0NWJWNjFI?=
 =?utf-8?B?Y1FxcVEvWnhkTkZHZW0zREVPekJoa1lVZ3dyblo2NzdOQmNuTUl4Mmw5eFJR?=
 =?utf-8?B?bmdGNDJSQW1rS0t2S2l0dGt1Rk1nTEg0S2VLREJEcjNYUzVhQmdveFo3SkUr?=
 =?utf-8?B?MTg4ZGQ2OENYMFZ3VloyZ3JBcVVmLzJLZkpQQXd4dUFMN3Y1bkxKRVlTSERx?=
 =?utf-8?B?TGNRdUtLdmZ0MjJLeTZTRkRpTVRxK0dsTFRGN09OOWhVeVdmcTd6NUhScVU4?=
 =?utf-8?B?V2ZkNXMyclZLQ1NXaGdHdnhGUmRvR2ZiVCtiNE50NzQwWE9wUXpXZ0VsQk5H?=
 =?utf-8?B?dmIxRHROQUhWYkNWeml1WXBsVms0dVdRaGJ2Qll5YzU1MWhnQTYzMm1NUWlm?=
 =?utf-8?B?Q3hPKzU0dU51OTNGdGt5QUZsMG1EdkNqbTFSQVYrQjU4cENlYzd6RjVDMmFt?=
 =?utf-8?B?SDg3dlhITGRIb0tRSEtvRlNjSjZFMXhxM0FJeVRETVp0Y0NPanp1VUxadlpX?=
 =?utf-8?B?cXZzcnFtOGduOVE5cWx3TlBjK3I2OC9hcjVTYTVFM1FUNTJtellnOWQvSmU3?=
 =?utf-8?B?eWFvMW5wUGNGRGU1ZlkzYUd4VE9adDlPL3FnejZwSXpSZ3krY0lPT0tVbHlC?=
 =?utf-8?B?Vmg0KzlHQWxVa3JTaFpaOFk3TCtPM0lMcmlwZEoxb0pDTEZvR3RJdmtnckhK?=
 =?utf-8?B?K0pHRUxRbjM1OEJ4SnRQYW15cGVRd0JxdnN2OFNsWmQ0KzRLeUFLUHJSUlJv?=
 =?utf-8?B?ZEFaS2tOVW9UL0F6clgrRHlmKzBFVURVWi9CQmRhREpFeUpsaTdBcmtkVzRR?=
 =?utf-8?B?L3R6dytKSDg5OHhlV1R1czdQalUyczNNbStQSFM3MERhbWVZZzM3YmQraFdr?=
 =?utf-8?B?U1dHMnhNaG96Sm1CeWFJS1M0WTRVdEFCeFFMYUthRVpubVUyM1VwczRSci9a?=
 =?utf-8?Q?NYRbUufUeAO3hWD7P9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57ea6ba-8fc8-45e5-e896-08df34140cbc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:21:22.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RufzausTlxpeScKveoYcXk9aIKFpoDWWnYYEnIsN8O5W4hud0StbZIOYts7N6kzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 01:15, Matheus Tagliari wrote:
> Hi Timur, Christian,
> 
> Thanks for the input, Timur.
> 
> To be clear, I'm not opposed to a backport. Fixing VCE1 for people stuck
> on the radeon driver with an LTS kernel is exactly the case that made me
> look into this in the first place. But my goal is only to help, and as I
> said before, I do not want to push a change you don't want.
> 
> Christian, if you'd rather keep this out of stable, I'll drop the
> "Cc: stable" tag in v3 and leave the decision to you. If there is a
> specific concern behind it (risk of regressions on other SI/Trinity
> parts, say), I'd be glad to hear it. I can also try to address it, for
> example with more testing, so that a backport can be reconsidered later.

I was part of the Trinity bringup back (I still have the engineering sample here :) and I filled a full swear jar bringing VCE up on that HW.

Interrupts were definitely not working correctly back then.

I have no idea when they were fixed but I want to avoid that people start streaming that this change made their system not boot any more and we are forced to revert a patch on stable kernels everywhere.

> On that note, the SI part was tested on real hardware together with
> patch 2, but the Trinity/Richland part only mirrors the existing CIK and
> SI handling and has not been tested on hardware. If anyone has a
> Trinity or Richland machine and can run a VCE encode with the series
> applied, a Tested-by would help for both the review and any backport
> discussion.

I'm pretty sure my engineering sample doesn't work any more. That was an A0 stepping and those boards are only stitched together to work for a few weeks/month during initial HW bringup.

Regards,
Christian.

> Either way, I'll respin v3 with whatever you both prefer.
> 
> Thanks,
> Matheus

