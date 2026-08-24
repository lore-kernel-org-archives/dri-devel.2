Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DABC5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3902010E82B;
	Mon, 24 Aug 2026 20:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbuemKA/";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE2210E82B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 20:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt5hn+RXUJwAwDFMUpIi6/7VuglJGOQjIzM8K6fHbu8pJ4JI/YSMLHGDqC2MFc+KJy/eeVOk6v47QIjxOuQoz0B9hY6e70C4cXU1T6MLM8D98QJ9mZzZ3oY0OBIBqkbNaHwCLxt8GcwflFeUbi+5Es34CE7lTzgW3eMj+R+a/A+IRdAkf/DZL4YHC8gsC4T6u7g1KIMTyuQ+LAcYvIkfcqxhZN96PxxhXCVMkcfA1y4jialI+yMVb/gRQlQbqmt1Al1nairTsyEGL5g9kED9G4U32qrRWY3tcvXP3LaRJqROlheENMmi5Gw4i1vetJKp1yXESVXFb1m6T68ZtpYd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5AIHWsAbrwCzAKL2A+56GkBxS4lameRP4ZU6L6L7a0=;
 b=y2bLpQ+fGNsk553pZtI0AW7xw6y/VLweao7N1Jffihi43MpcTkHbZIr4NQtCqsub+SATYDWzICT+bxoY7i0YevcC6sFSpiRGY9Pzf3dvVEcoGODbINUTldl09IVTyQLToIde8VirUYJFslCcc4rpHrhoE87ZyQdh3ZU76rCdKyRcOFu/sucb3stiqbrDeG032yIVhB+rvlfnvMdPAVGpYqBBrcpHlhIiyWChH113IeERNj7XbhA/FTHMTYknwuGRrDE+0P1e6oyZ4s26RdEB4UuHTVJqXwdG8uefMJrldEgsnIJReA+JgERdXk3uBPzahmSSey99oNXN+Cl+K5BPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5AIHWsAbrwCzAKL2A+56GkBxS4lameRP4ZU6L6L7a0=;
 b=VbuemKA/q2MS2TJ18GaWL47/4kCl4rsoNIB1Zq8nLv6DEn7Dp8yhkGpg6Ua4w3Nn5cYzO1SEig2KjlGc7YV11Xh0g8r/wiG7PQmLnVi8XVUayBU9Rqg4G1pxIBh3BZ+E7Sy+MTym4gVhIcMsc92rHin0rLMsGskmL11j618ej+a4wMvoZMqXq4cJcVMBXibq8tU+i+6OYLPBKobgxL+CGK0Q0Nmllkm+Hfs1ce3ytY9kDhWBkf4/Rntu61B7Nkf6rISBfylf+Z9YvkQpYaRbJ5oEa5nCG0QVcVH++dkOx85Dwc8mG14CVuYtBVZYlB2wuJb1CH/Nsz6i+kEAdOd2Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 20:04:32 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 20:04:32 +0000
Message-ID: <f9d3f749-dacb-4cfa-acf7-e748795729a6@nvidia.com>
Date: Mon, 24 Aug 2026 13:04:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
To: Danilo Krummrich <dakr@kernel.org>, Alistair Popple <apopple@nvidia.com>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKXFCIT7WHBE.1MJV6UKAJ5VEU@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKXFCIT7WHBE.1MJV6UKAJ5VEU@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abaff58-b308-404a-09cc-08df021ae99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: WyA13ll0zoMx0b3YbccRUcFpueGU06mjsOOnk9FzOI5LoHZ85BL/FnPP6qC74TclazdARmM0dmTCg/MLhlcizQz2xtucel+nLi0V8LPK/uShe8KyQJEYKWfhSlFshHxNyW427pp7eIGiNf54biyOiki1Gh4MaCTb4n7MV47cuAyrNQbRoaTfCm6QeV8CUy+CQgN+/SqaLzqjQfptFdKSgHyqBAcj7PH/lq1V32LWhBs3Eyc4REdMyv6XDomyR5F0YjZ4o+8oW8yEittQKZhU4vGKH4aQUFnU/RnCq1/qX2GN5pwMDve0k/l9ZqnSxK9Ob7lh0s/NiUdKTGmILOHViZmIB4+gRV9AarjfvkOsM4PDdkFQ3DTF9zbdjdFq+WpjQNZ0nab1WUj79RBfrmBopyUZHFAHL4bsI5hcxWXxs96KbgZm+3WCoDrRmjPgLt9vyWjZfwNShW1BmFOKobMMAe5fsgvc8dPtnaGVun8iF5cq7F1UKiq3yXM+SsX4hmChuV1iuhLCKGNtyFUH/xIO3LvldxKP2m/CHKrU0VZVkaJH4QxB3DftVLng/3KJNPcnVCUFd+XabkTkeQHPMeqr4JAturJ0jelnNQ/Ki6pLEOy1JP6qlAWIETPZMCViTcac/MMzYv2vu5yfSST9+HyCj9VvRYKcAwEoe+Sd7i8O2OQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1M3QjZBcVBZRVR3V3AwYjUxMkdqdFlQTEdOV1JXTGlzUjExbkJIQnQ1WWNu?=
 =?utf-8?B?TUpBM2NVeGNLQzVvRVdIOEliMDRlTTNwVDZDeFN5aHNIbldiU1M5RVdTMDRm?=
 =?utf-8?B?V3h4c0dCK2ZtQm5GeUVaYzBQTEpUbjNIVjVrR0ZVRkhMcWdybklSakV2N0N5?=
 =?utf-8?B?SmVRcFZyV01ZekRIMkRVaUtCc0dEYlprYnlQcEZaNy81b29mQTVmSHA5RnBl?=
 =?utf-8?B?ZTRvdS9naE1mWGpaclJvWGt5N3dnMDJjazg3d2FqOC93cW9zbEsrbkk1Nmlv?=
 =?utf-8?B?cHRhd0x5M0tEWXk4MVc1VHM3RXEvbUh6Z2xZUE9ZSXBrZUM0bzJhajBMaW1t?=
 =?utf-8?B?WEJrRDUrcUczbjRVc0oxakVEUU1NN1NQaCtUc1F6Nm5sUk1LSXdHZDlMbU9X?=
 =?utf-8?B?c2MrSXBoMTJaUWVQQXNyd2t4TlhzM0pXK1c4dXg4QnA3V3RHMnRkVU1UZmw2?=
 =?utf-8?B?Z2h1cW1iTk5UNXJRa2xMbW1nSjhTTFpML0dPKy9WT3hORVhxcjNxWjladHB1?=
 =?utf-8?B?OStTRUJqcUZ4VThNazdLVFZwcGFXaXNOZis3WEoyeXNXa1VuQU1KUFBpOFZo?=
 =?utf-8?B?NDlPZDhVcy9rdS9pMTl0Q3JBNGxEVHFqUEkxZHl0RmRHMThPM3ZoN3hyRm1z?=
 =?utf-8?B?RnBSTE9ITllUTk5nUlBBdFJkRldyV2FEZVdNc1R3YktXMkhVWjZFamhDVXps?=
 =?utf-8?B?cW4ydllQY3RyQVZQekgwMDRYbVljSlZHRlFLSlU4bnhWNEg5Z3F4YUMvcDRz?=
 =?utf-8?B?V2ZML2pNeHd0WFFnOTZ1MUp2dG1QMkc3aC9ScmdoUkxnbDRRZHpERlgzNU1v?=
 =?utf-8?B?SlhoWGU1YjdTYWZQSVVqVTYyamZyazZNWGgrVVJvbTVBUFJYRUxBTmFUSDdt?=
 =?utf-8?B?bVg3UTR4enVuN094b1R3ejd5SnpqSHVZdVg4NW45cGszTVVkbTVJY1p6dHlv?=
 =?utf-8?B?ampXdFJVaFN0bmZoK3NpUnhlN0VIbTRENE52elBGa3prNW9Gem8wRndDOU5N?=
 =?utf-8?B?SVRqY2pxa2NEaWh4OWgwTHZ0SWFwc05PRkxURzJmUm1VVXczRkNBQ1BsMnZq?=
 =?utf-8?B?d1hPUzQ3N2VKWEVvZWtoUW1jRzlRWVMwYVpRdklremwvc3dHakVPRHcwWTFM?=
 =?utf-8?B?MkJaMWVhNzBBc0QyVnFzdnBhUDk3UjJIc3p6SnhOc1NPUEZqR3Y3VCttM25v?=
 =?utf-8?B?SXorM3dNMWtkRmNlQjlGcHFWWk5ibG1OT3pCTktkV003WWtudmJwLzVTTlp2?=
 =?utf-8?B?em5CT1l3bHZacFBsZWM2N2pEcEdLRmVkbXNoSzMrREk3d0N4RFIxeEpFQWJM?=
 =?utf-8?B?YTV1VWRzVWJVVHBVL05kN09pT0hJenJLY3ptd3o4dlR5bC9BWWRjWXUyOFlv?=
 =?utf-8?B?OTgzWW9Id0g5d050TmxyaHN1TzBKOFJPNE5yaGVxMWtXb08yT1ZkdlRhSE10?=
 =?utf-8?B?Z1Q1d3ZveXJ2bzBBbW91NW5icGNqcU9ObnMzdktKeHV2RllZelJDQXpxc0tP?=
 =?utf-8?B?YU5jak5PaEdOMFBONHFlcEV4MzFsR2JDOGZ2QWlmdnlCNnRQRGYyTDF1cG9Z?=
 =?utf-8?B?MzczUjl0Q0RsMWYwUXZvempXMU5XS1RmeHFsdmFheUZaZXo3ejNaUlR1YThX?=
 =?utf-8?B?eWpjNGQ5WVJ3Qm9laVN5UFlQcVV0alRUV1pvMUx6Qm52eEJ1TDBQaGV5cDEv?=
 =?utf-8?B?Ui8wRXVtaXM4L3ZNaWVnblZENUE1R1piWEQ2TmRIa0swYlJxSEJlT0hXSkFB?=
 =?utf-8?B?M0JUUXRYUlNGVmF0TFRLMXFjUllkQ3dVVDBoamZjMlVyRWRkV1QyWVREZGVC?=
 =?utf-8?B?MUx2UmNKd1hPdFFuUnFPd2pFTmU5WGVvQ2g2dlBYNjQ3RGFPcVdRa3lvYWI2?=
 =?utf-8?B?bG83ancyVHZ1b1E4KzB4TjZ6N0IvR0FEV3JqRkxPdG5SWUpRazFZZkthVlNS?=
 =?utf-8?B?eTljZHZkdjVZb1JqaTZ1ZWdjMUdZMWQ3U2h4Q0J3RjJuSEJ0bklIYmhQU1FS?=
 =?utf-8?B?S0JoWXVjK0hDVEVGVTN0Z2tBRGFTY2JBOFBKZUM5M0tSSDdjeEFVK2o1bUd4?=
 =?utf-8?B?REprQXRuSG9wci9JNnBsY016Rk5yMldVa3FRakkyeXQ2RmxQS1hETldIZlpy?=
 =?utf-8?B?SjlGV0FtS0V5V29CRW02V3FSeGpYM2Y1YUV1SzRJNGM4anc2dVZSck5ZaU1F?=
 =?utf-8?B?dnpPcHNEOE56T3Jici9XdmZlMTdlMWhUSlRZNEpiaTdwNTJpTTJETVAzZFR0?=
 =?utf-8?B?WGFmcmZwTHZ5TlFZL0daaEVybXlxSmIxYXp6Y3ZjNmlkekhsY29jSWF2OTdh?=
 =?utf-8?B?elB4NHY5Mm50TjVQTXlwbzdzMFhHRDJLRlhyNWVBR2NDdFJveFhJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abaff58-b308-404a-09cc-08df021ae99b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 20:04:32.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOixT0txSIKUoPvAG36vceTHlI2v23/3vxU/ykuQ/PhDwcqAzxRozst/Dg2yZpEaR2PHGo7yP5eDzCaLCyC2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

On 8/24/26 12:34 PM, Danilo Krummrich wrote:
> On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
>>  include/uapi/drm/nova_drm.h    | 27 +++++++++++++++++++++++++++
> 
> Btw. I think it would be nice to have project to play around with and write
> tests directly on top of the uAPI before we can run the big test suites.

Yes, I think it's reasonable to do something like that. Seeing a new API
from both sides, caller and callee, is always illuminating during review,
for one thing.

> 
> When I implemented the VM_BIND uAPI for nouveau I used IGT for this (but didn't
> enjoy it too much). It turned out to be very useful to test and benchmark the
> implementation before being able to complete VK CTS.
> 
> When I sent the first nova-drm skeleton, I also submitted [1]; maybe we can
> extend this further accordingly?
> 
> I'm also open for other ideas, but I'd really like to have something like this
> as we develop nova-drm.
> 
> [1] https://gitlab.freedesktop.org/dakr/drm-test

I was thinking about where this sort of thing should go, and this
location seems as good, or slightly better than the main alternatives,
to get started anyway.

Alternatives include:

1) The kernel's kselftests (tools/testings/selftests). These are
helpful in many cases, but some minor issues include:

    a) Oddly tight coupling to kernel code, even though the whole
       point of these is to exercise the kernel from user space.
       (Otherwise, these days one would use KUnit.) I've personally
       working on mitigating the coupling-induced problems and 
       ran into other, bigger problems along the way, such as:

   b) Confused build system and an arguably wrong way of invoking
      the tests (from Make(1) !).

2) Some other github-like location to host user space tests for
   nova. The idea is, do we want to set up a well-known location
   that people should keep updated? Or let a thousand github
   small test sites bloom? 


thanks,
-- 
John Hubbard

