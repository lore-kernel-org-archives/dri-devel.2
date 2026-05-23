Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B1CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 17:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E6710E0F7;
	Sat, 23 May 2026 17:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIoF/tak";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A3BD10E0D7;
 Sat, 23 May 2026 17:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/GIPpS30BYI3riWG6cfU1EDpu/J+imHZDfWkRAaak7SUPpDuMAfok0CXRnaWd2ERluFC2Yqbp1ANXwa0/kdVABFHq+KdpDZHvXwdwXGu0OrrcvfHQmKMn+NNJzOXUU12PrFOBm0/zymqbHx5rvpYxh+eKoCbcMmkPProwBWbOaN1K8EyFdqoN2q0W2kl3TZ+HA8Oo1qLhE2rOCbYBP+GEcAW2L8GDisqBZNqAB1+VTUmsuEB4HXzuTtmKfAVOkEHUh5fQHMGahTaTa5Rty2beNnWae5JJgkwgRb0QK4KGJ0MJHQdSjRs11Cgh6yB7gmOsIlkoZ1vG118HCu+zZZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th4dQJ8qjUzkDwCZmAD/EXzBBaIDQbnvnLCcHi/0oxI=;
 b=hAgZ2gJcDV0fie7P8qMBGc5ipiyylz+3dIypQsi5NaV8ENkzaoZXn50RSt8y1Lvmvn0uFJ4fe7O4L50Ldm31MtnxWMFt0DjSHwXH4SOTTdZt/nrGCdlvFEqifSG8xnrysAWQw2WUtpuryEKnitibJXPPfefDzQp1MIautmtZM6wSFORQgNRJQaKwZxsiZ8iET0Hmf0EgNve+zSqEUCIwRvIr9HdCIBQAtNyRo8g7blWi1wtzQoqVrGc4e2jo89JM/COgf4ESl4JtoPkr9ZPG8OPXtvGW/Z9k1NK59jU3m+fEXIitr09RztsxhDFUMjIgPTUjI760ReAnsPV+H/P1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th4dQJ8qjUzkDwCZmAD/EXzBBaIDQbnvnLCcHi/0oxI=;
 b=DIoF/takgBslHXv2wNSqDSzTAN+uYzLBTtmoqgA93Aryj+K6R3qvVioQX3VzP2H5Uz4fjTQt6UtbSEoC+X5fhO8eaMqxmPmIlfZMapHaJfYMYEJ5SVLoH7mYRUINx34Oh2eTDdF7YdOIi3KBAYixJ/nansRzI4yShRnZ0EheK9EalxU9/vAyPB25K7lDuLh2ssuaFAlb9Ezbh7L2UfIMlgwAFCllXquKA8BhqSPrD1QxIgQ1vSSgMY8uN1LvC6+bYbIalSjjqQpjq5tYXXGATHX+JhwR1921ph7I8SNSeoBfa8ihsEHBDLmGfrSBFR+FpNZtD44GREwXvwMTJhN4Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 23 May
 2026 17:52:19 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 17:52:19 +0000
Message-ID: <8871a158-7a68-4247-a09f-bb3d970d6dc2@nvidia.com>
Date: Sat, 23 May 2026 10:52:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:408:ed::23) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b4aa25-ce33-4f22-28c2-08deb8f408e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Doav9qoNbIgAARwUxytvIs7le5AwRdDRit++9e1DUO/SHh3qPQaP7jSdA9OmkvMcXhTRgNaR8uZbbsN3Q9nDNnCsDtG/oAUrDmgBCWiV41JMTNErYXeU3DHT+xMV2wW/fp0lNRUVEa0uYLv3F18yqlVVfpBPq6meKC91BmM/tB5yX9yAyi5m0rP1FpA9i0OuRNB+FfZePAetAi5V7Js39xDQFR/CmW7JWvIy2ZV2O7DAGu6kdaZ+oJxCkCfyMZFY02MLYv63CU9sLDQtYHnGMdECfS2eHMVYgiQyLzp989CPPoci1FTMMwEjOl1riRi4vmuT16otiEvN92bC1o5H+3thAhh8Ng5rVxc53Ccv0TdrA7tgHqBXkhQnnX+tSO/KvcHBmadgEUeHPEy8HGxNy3tNQft9qrJY0CwZaIU7DaD7wEWJ5ubZLc9HaynN/qi/EtHKa9r7dUQrmII0lG53NBOAgHq0lLkok6V3BSCL+5ATnJnod+6qxn6uC22bYvRr3jX3qpE18jqzMFOXhJbD4F7kQR89mQrDBU8+SjIN9JXt817WcvkUI8EwvR3W63xjegTEh32tnoPBz43Ce6WS6g76xL2pPpzCw2aSfkjnclstONav6F4IUmTmdPmNJJVCQzgBoFHmgfcnFORzZjhww5rM8Bkb6I5F83N5IoYcPH73WDt7JsedyplBpBo/64Qg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk92blkvZGtVNGFxVFZseEZLc0xtTlU0N1gzNTZRd1YxWXZyYmgrZCtJN0xz?=
 =?utf-8?B?d2hNak05aGdDcTBLMXluMm9yejJrSC9ybU5NVlhWTWhZOWxlVG9kOWVWcHRj?=
 =?utf-8?B?azF6WnQrWmJiWHVsbEd4MTdYMnNMWklrNWJDb1BnWlVhRTc0ekZyZTAvRldu?=
 =?utf-8?B?UnNrbENRVVcyT2lQamJyR1FzT3VUZTlEN2s5cHMzcTZuMk9KaCtaWE1IT0k3?=
 =?utf-8?B?bW50MStnbzhzUlh0QzFDMU9jbTkrdGhDMVBnS04yUTVmSmpSeHY0RWJVWDFr?=
 =?utf-8?B?R3Q3VTR5dUJGUFpWR1JLTmg3VVdjN1BSSUFkU0REazhwZTRtMlZWZGJvUkdK?=
 =?utf-8?B?U0xieDc3SnN2aXZLSVlVbU5pVjQzSmsrekc2OG5XcWNwakdzWHd6WXEwa1BF?=
 =?utf-8?B?bEJ6ajBKNVlIcm1aMVpIUFdmTURKa09VV2lvaTRNdDBhUTB2YXpGQ0FibVE2?=
 =?utf-8?B?NVFrMEpjenNzUnFVc0pFV0RubXFyRW1OYVlqZmpBUHBQUC9VblFDVG1sVDE1?=
 =?utf-8?B?YXJTK0NRYWpIZ3J2ZmtTUytvWjZ5WjlMOGlIcFRGYW9wY1JiRjdTSU92aHVP?=
 =?utf-8?B?WXJPaVlLUzZSR2FCb0h3RmllMnkyb0tncmM2MGJNTHk3d2xjSU9BUWtlY1lt?=
 =?utf-8?B?NGlCbkpoRk1PMldJRnJva1l0R1VQOURpVWRHN001OCt6QlpOVlY2MUxScEFi?=
 =?utf-8?B?U2U5MkFNeXp2MnN3bC9QaldwT0pSTng0Y1R3TVo3clVWN284WmI4OXh3d1hC?=
 =?utf-8?B?TUh2QnV2Q3Y3bmE3ZXhHcjFBUGhkdlRRZFpGUC9hMW9QRkZTTXNaYlVYSXVM?=
 =?utf-8?B?R1FGUG5OZGtVRGVrQlhiMlg3SHkwK1prQWIrcmx1disveTdSYlBPY0JYSGJT?=
 =?utf-8?B?YnoySEUzTVpaVWdEQ2FMYWxPdGRzTHBQMWM2WTQ5YS9UbHQrS0hpVTd4SUJU?=
 =?utf-8?B?N0c5Ynk2VllWdFhpdGVybGRZVnBLUTR3c3UwOHRrUDYwZ1gxaitFWm4xTUhz?=
 =?utf-8?B?TnhJYm9tc2hVWUpEeUw0bVUxV2d2TUFMenZrNGJCbkJZS01tVktFalp3SzhC?=
 =?utf-8?B?WFJtdmphNktibFJxSjg2TmVMNm4wZjB2VVB3akg0RGlhZGJaUkVQTDBxcVBQ?=
 =?utf-8?B?SEZKWWdON2xXZnZwYVRUOVgreGpHQkRGeDhiTXRkWWk2dUlnV2d4NFR4S0Jj?=
 =?utf-8?B?TzA3OUxLTlVnSmIxQ1p5VlNsWHNOcFlYQVByVVFyUk5qb1dzSlk5NkZRcFJh?=
 =?utf-8?B?K1hhSlQ3ZDVDNitXVGkyNGNyRFpRUmtLZUQxNlRIRk5GQU9tTGZvdXFTdm1T?=
 =?utf-8?B?S3FxTDBWb3VITjArU0paYVBHb0J3TGZOdWdWV0dYUFVMTURXODliZUcrZUNE?=
 =?utf-8?B?eDdlOGQrZW5LVFhMaFlzaVNXeEZRUHJSQUdyUWFaYnhGbmlFZFlOTFFNWHhZ?=
 =?utf-8?B?NThIczBGa2RiWnZRQTB4Q2xsRW5hU3duWm1jVTlEUnluZTh6R0tmTHZvUVA3?=
 =?utf-8?B?SlUxMXFzVU9oUTh2WTJ6eUtVZjFrNXkwS1NpRVdTYTd5WlQ4WGNuMWEwZllV?=
 =?utf-8?B?U204MVV0QmNBcUI3d24xTmx6eFo1eWx4WUg3WkRoWHdzUDRpOUdKeTdXb0pl?=
 =?utf-8?B?YzJINkNmUUszSmpZWkdydXh5OTZpR2FIaU44QXdiUTV0eVF5dFRuSnlzeFVh?=
 =?utf-8?B?STRuaENtQ09HZEdlVmZBdlplT0JUalovUlJSRTNNaUVwYlh2Z3NYRXMyZklM?=
 =?utf-8?B?WHVKUCtGakVwQlVTa3gzaXVFQlQ5Umk5MXNGWG95cHVLTmpVdWR1WFFWaTF0?=
 =?utf-8?B?dkZxK0tweHZYNXp1bERIN3h1WFlONnVMRlN0L2JxOE9LL1hUNnVuSDQxOGF3?=
 =?utf-8?B?SG15aXJ1MkwvSFJMMitZeEladXRqYXM0Y1J4SUtJK2RUT1hHMEhHT3p0SUR1?=
 =?utf-8?B?OVNJY05EdEFWMmpnbVhmc3RkaVM4YUhoT0J4ZDFyc3Fsd0J1dFNvQlF3VG1X?=
 =?utf-8?B?bDh1ak8wV0Ywc0t6cjlqSW1WTGljMld4dGZnTkpFS3lEK0t4cFlPRURXMnRM?=
 =?utf-8?B?NDRPYnh4REwrQVJqMXdFSXhSd3krVkxreEJWVUd6Wk5lVlFIdEJEdVZKcEEv?=
 =?utf-8?B?clhkK3VOVW5FSW5BbTQ4aHE3bWVLNEYwbC9wbmQ5d3VHZXpQbnVCeGhQM1B5?=
 =?utf-8?B?SGluYUljLzJsVnRTd3lpL09TUHVIbm1XaXJSOWVTMXczc05EczZ0QzJKZG1x?=
 =?utf-8?B?OVdZa3p4T3I5ZngrSlRMTUcwRTIyRjh3TmwvajJMbFVVTFRITVk3YTJOQlpk?=
 =?utf-8?B?WFQ3TXVLUmkrMFZiZjVXRTFhaTFGSU0zQ09qOWgwazh3RkNSMnQrRDcyNFhx?=
 =?utf-8?Q?G9/h098AnCwlIr+DrzDsDoNiHGcHWbou+c1aiVsH87YBN?=
X-MS-Exchange-AntiSpam-MessageData-1: U+HGM2DevlXHJA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b4aa25-ce33-4f22-28c2-08deb8f408e2
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 17:52:19.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsYrhlm0yaJn0mEBWPuriE8KfyX4XV9bzwHAQY+awA3ALxmki1s1lc8MRs3T+PHDs6cK21nyqC75CAmmyfzQOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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

On 5/23/26 1:40 AM, Peter Zijlstra wrote:
> On Fri, May 22, 2026 at 06:33:24PM -0700, John Hubbard wrote:
...
>>    perf/core: out-of-line and export perf_allow_cpu/tracepoint()
>>    drm/xe: gate observation streams with perf_allow_cpu()
>>
>>   drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
>>   drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
>>   drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
>>   drivers/gpu/drm/xe/xe_observation.h |  3 +--
>>   include/linux/perf_event.h          | 31 ++++++++++++++--------------
>>   kernel/events/core.c                | 18 ++++++++++++++++
>>   6 files changed, 79 insertions(+), 35 deletions(-)
> 
> Sure, works for me. How do you want to route these things, Xe tree or
> -tip?

Hi Peter,

Maybe -tip, but really, either way is perfectly OK with me.

thanks,
-- 
John Hubbard

