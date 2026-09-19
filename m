Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E66C982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E3D10E206;
	Sat, 19 Sep 2026 20:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARiJFj+9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F68F10E206
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 20:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7+RGhEpyMCLPX85o8LeCEwMvpBlIgSKhXwOqA2oDapS5uUs90HouZvq3++nV4dK1veK/+4QXsdz4c1a7A9+CDU8gGfRXeaE8hhjqmodXQ3qEsrk3YrvWheLs7GqypLRIKX+aOhm9VDeMZMZX2p6DutbhmgeXXRgFClRRtH97UshKODjIeywemwNPI5JG/4t2d5qrP1aVgGL8cJLbJ1jH5U3EeTZtVRO5ZW5MZwYfUdxfZO9ZdmMpqGdy7zywAxs1ZTVvuHJ2En6Z4khj/NSiFtHs79rlLKmYzF4z71YkzMsjFbKEL9ysYKK6jpXQJcUEgSZLhMzVQGREocLZ1uv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvtLvyzUiBtQ8d6zc9w+Uk3Ull+ezut9NJjtWB7C0vo=;
 b=TC5z33rQ5T09tChF72mc+boemHg5SwMsb0t5ag8u8ic9HGrt7YHxsFj8qfditdISKvwx0M+Jg9P/1a1WA7qhWVYzG6xzeiwd7LXLtSfanKiY1CgG9qpauTE0tx6DtG3f3BEYK6R46QFFFUCUmgkEH9Kij6vk3LfSvQXZoXfR252qkp/2JkdEynKIybOrPo3SqccmBun7XdOgEBhdLkSPdRaUhU66S1YIaytjZuI7ESM37kMH/2TT26W0uvIWepoomkX/PzWAcapITUPMwD19o7xEHPljjpoR3GgK66VZi8HPZmcwJ0FGI9tTbSQIMJmQdK8dkczrldaNcyTBM6u6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvtLvyzUiBtQ8d6zc9w+Uk3Ull+ezut9NJjtWB7C0vo=;
 b=ARiJFj+9GeODuOPpdUxTvJy9A908Sugx3XgLI4O/hZtihj+PI4mWymZB44IL7OWo0llR17hS+yGqtptWjD9FqXawB0121bqb1utuLSa+kHsiSatatZPuf6TXhGNJ71moAvsJYZRomBQ2ZeUGU274nl+/ishxyXB6Ttj1gsYONJoY0VG3gGx0TgYkpLMSWPCfU1GD7JUsN4sjvLvv1uENQfcADODytWa9yFEgCH7gLlHv2f1q6c7LJQHyYhBvR6Zdcblvbl+5VDCLH6FBQ+YZ6xYADRPZQ9JSkZo87AfH+Au6GIs1fuJjBFd1wBiI479hP37HGF0WPDz3Gry4iZ6iNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 20:13:29 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 20:13:29 +0000
Message-ID: <165ab493-9de9-43bb-a53b-3fa82f8013cf@nvidia.com>
Date: Sat, 19 Sep 2026 13:13:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
To: Alexandre Courbot <acourbot@nvidia.com>, Dave Airlie <airlied@gmail.com>, 
 Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
 <CAPM=9tweFRWWjCrkBKvR03BaRVs=N+-qw2ju0g-dgMj+S7Q=ZA@mail.gmail.com>
 <DLJDV72PBGVA.1M0RZ780ZPJR0@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DLJDV72PBGVA.1M0RZ780ZPJR0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c0f466-040d-42c8-97d3-08df168a783a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Egh00VVFte3P/HacuCxaEqB5ReYvFQCngquUO5/nwfXOi7cYa/Mo+VoQdtSYqN2k5AXkAMVzavXSQLvj8FfSy4dTRgjOejVexBnWrrktTdKfAG3ylyif9trAQrxlqkXl3BhUay1Ut/G9EVaMzTMkiC7lf7piFrdeW0iTyu1dB8wFWxx+nHWH2vDVjcepGyDoZM6OXALwe+NkbWQlfbvbcShGs+Qdy4ccvvP8S1lb8BYJ83PKukc8xV0cQdH/FQATUUxAS4bwfMGALJkGyUtNXws+FyKKQb9HeRBLfG6jw5eto7UOS7E961+RSQ3y4TxDAtkqweBmqoHeq95H9+O25TQoozTDKihpGjqMHOW2rdMnxjAK02SPBLHJWHpLj1nWu3ySKWHvDqWKYYbQ8tuI2oDoeeaJy1rnhv6NQlDS9bSjkVL9EJkP4AWeyVhEAcq0J5oNqxwUn0ukGfOVX4lA9oYXJ/SEDVvUI+NYSEW7mrS1MrPb+1ifuGx4VPbeygNXM8khKqj4kvyYQrO6ykuH7g953ga5A/H2MtjsnclHrJioREeo7nlYHizXSGTPRF/DFrMJ1pc3lGIxk92+8xDB4f+x8Lv9FjULdFGKp+kmbpvMrQwZbTkG7kf1790D0wdA6PbOrfH0i43UxDY+o4DBCVBg0tLdSivhWkFhZn3nn20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJBcHNLcFJrbm5XcHRxUFEvMG1oSkdHcERSZ2Nlb1NCYkhJcVkzNDRXZFhD?=
 =?utf-8?B?ZHo1RHRrTk5zQ0lqeG5sd29qd0F4b3VScG1aYjNvenVVTFZDdUNNaWNTaDlR?=
 =?utf-8?B?SFFkOGdpNmJSV2NBd0RCUGc2OGhDdWJOTXUwVXZhWkJjdk9DR1h6RGgzRU9M?=
 =?utf-8?B?TmF4N2E5Qkk5Y0xUMU5SOUpjUzk1RkY5Sk4zakR6ckMrNjRIRk0xN1ZveVR1?=
 =?utf-8?B?ZW5yekxUWGNVZEhxd0s1QUYyVHRZWmhCVFdiZDJZMHNUbmZWZEdtMkxMR2Yy?=
 =?utf-8?B?M1NvcmkrS2ZCTVNIMVYxVFNNQWVXeGJ0bUZWWHlDUDB1WElINlJyQ2srWWtz?=
 =?utf-8?B?VG91aEFUSnBIQlppRlRyc0lVTjUvZHErMlpLOFliaXlBZGdSeDl3U0JrTXEx?=
 =?utf-8?B?WFl5R1NBd1psVW5xRmZFdVpLRkFEa0pBUnNSdHIyUjUxMXBydVUrVnl4MlI3?=
 =?utf-8?B?anZjSGptOFl1NTlDczN2SU9SaE81ZCs1bEdzckpGNnExdzZoYlFtQjM1cXhx?=
 =?utf-8?B?MXVlWDdLN2RUb3B6dlA5NHhMMjE5elVyL1BqSHJISlo5WTBKbUVjMzNjR091?=
 =?utf-8?B?ZkptNE41Y2hyT1hIdWJ0TmVHLzh0NVJOUnQzTHBSS3d2eEFhdzQ0N2pZa0I5?=
 =?utf-8?B?Z0NUQWhtR01HdVRqZmdLdHNhSllLUDVsNUpJQ0llaXZnb3BtSzVrVFYyR1ZS?=
 =?utf-8?B?MUkvY3RWNGIxblFWM1hCMUVoMjBFWlQxQ3RGY0NzbDlnMzdIdlJMNERkZGt2?=
 =?utf-8?B?cWVBZjl2bklCMEdLZmJvaGpVM2NYR2Z5Mi9ZbGl6UGdKMkpIVy8vNzljakRT?=
 =?utf-8?B?MUxvM1lnejlFb29vblFKSzRvdHdxV2I3cDFzcVhXK0tUeGdpSFlXeGp2Y2o5?=
 =?utf-8?B?NUcwTFlEZXp0MGNOSzlEQlNCTG5iVUtOUi8ralVvTTMxNjdFZWVsU2ZqeDFO?=
 =?utf-8?B?YS9qbUpHelVqcGJxOW1WOTNqYUgvRUQ4ZE5wajlMRFFnSDBJVlErRlE4NWFa?=
 =?utf-8?B?WmxDTlZubEdIOXFOckUvUitjcUZtdTZkcW44aUpXbnRJc0hYeDNjay9ma3FW?=
 =?utf-8?B?Z0c3NlV6clNsRGxiYU9saW1NaGI3TTBZdjUzNWZjZ3RiYkx1QnA0NUJlWDZ6?=
 =?utf-8?B?dndvZUpCbllsdjVvZVdKcW95Y3VCSmloTG0zSE1aSXlaMWhqeVFXb0lub3Fn?=
 =?utf-8?B?TUE3ZmRKY1BMdXdMMnMvUWc4d1J0SnNqQ0U1SHZ3a3ZlYnZWcVNCSHVKdDRr?=
 =?utf-8?B?c1g1MjdRYVQvKzU3dDRtdVJ2Y0FEL1NCM3hSblYxTHkvcHdXa2RGcHFaaENM?=
 =?utf-8?B?VjhTVEVVc2tZdEZHV01wS3Bzc1FqOCtkdlc1MmtRdHF3b3k4bFJjdmpnb1M1?=
 =?utf-8?B?bDR1ZmFXbUI3REIrR2dtRTlGdkQvNHJ3K3JuWlFwLzRSS2lzMDMrQ1ZFeVNL?=
 =?utf-8?B?MEpHa3ZzWm9NUHNTU2Vpa3FUV0VYNUNPWGsxenErSkNaSUxYMUF4R3pTczRL?=
 =?utf-8?B?SkdXSlJJSGhvdjZrY1k3Vzg3Q1UxT1d0VnhqOWpjdkIycEQvK1BUUktwVnhQ?=
 =?utf-8?B?NEE0aEswMW9MMElLa1JCeTBSTnFuQnY5SEkybldkS0lXYS9PdkpZZHBUd24r?=
 =?utf-8?B?bmFJNFd3U3RlWDR2QlY0UU41RUFIMUxqRzhiMG1GRWVPRDNVNVVCS003RUJW?=
 =?utf-8?B?S2o5OERmNEFGTTdXak9zeUlWZ0h3UnRJMmt3blRCeU1MVEZjUU1aR1dYWllI?=
 =?utf-8?B?cjJ3UTFocUpBUElvWHJ3ejNiN3RZbVZ6TCtmdlhNcDgrTzhhM25xZlJLU056?=
 =?utf-8?B?SnVvTVFNWjF5RDkycnVoRmhaUjNjeXN6Q3hoY0dsa3g3eURrM05SQlJ2dTF6?=
 =?utf-8?B?ZFhhcVFpYnBKcldNaDVKd3NEakhLMDQ5ZWd1WVN2ZTJkY2JmREVVQWNDVE82?=
 =?utf-8?B?c2E3WTRlUmR6VWMra3pWYWU4VjREcGJHNTdyWXc0dHBTKzZIMkpqd0FVR2xU?=
 =?utf-8?B?aGdHUHlmeUJlSWZyZi91dmt0TFJLNUdNQ1FpbEo2eEdCUUJKVk1va05ZQUMx?=
 =?utf-8?B?US9oK2JYK3ZVVFdPSHZJMGE2b2pmT3JEUWVGZDVHMHVRZTlxT2ZTZDFtdEov?=
 =?utf-8?B?bzBEbTR2Ym5lVHhjTzJocU5pNkVsT1JhMGFQTVNOZmNFazRWNGZwVWl4MUVo?=
 =?utf-8?B?VmtoTktEaFJFejNIZWE1ZjlvSTVEZDFHdWNKQnUxbGJDSzFTcWQxcC9LMy9w?=
 =?utf-8?B?VC9ONkExSm91dzlmWnNPbUFaRFoyaEtYWFB5UVpyVlpQTzJkR3ZBc2MyOXdy?=
 =?utf-8?B?U1ZPazZqdnRGeDQrNzE2S0drSzRrOVpNNnU1N05TM2IrdjdvQ05hb3FVS1pn?=
 =?utf-8?Q?D3C6GgXA1Djp5uco=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c0f466-040d-42c8-97d3-08df168a783a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 20:13:29.0148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KNt1B2EloDHNGDraKif3Csx+81Y6QMEo2OQXgGTiZ1Z430R87RNmVK87Sl2pXZNHyRVicNEcfXIW8q7vsJ4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

On 9/19/26 8:03 AM, Alexandre Courbot wrote:
> On Fri Sep 18, 2026 at 12:38 PM JST, Dave Airlie wrote:
>> On Wed, 9 Sept 2026 at 14:25, Eliot Courtney <ecourtney@nvidia.com> wrote:
>>>
>>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>>
>>> Add the BAR1 user interface for CPU access to GPU virtual memory through
>>> the BAR1 aperture.
>>>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> [ecourtney: map BAR1 in NovaCore, borrow it in Gpu and BarUser, no Devres]
>>> [ecourtney: update for the VramAddress raw API and gsp_resources chipset]
>>> [ecourtney: drop the owned GpuMm, pass it mutably through map and release]
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>
>> BAR 1 and 2 need to be optionally detected and used. At least on SPARK
>> there is only BAR0.
>>
>> I've been playing with John's branch on spark and had to rework this
>> code to make BAR 1 optional.
> 
> Thanks Dave - indeed we also hit an issue on a device where the FB
> console was enabled (?), which preventing BAR1 from being used.
>

That's different: another device driver was using the GPU. People
should Kconfig their system to avoid having two device drivers
trying to claim the same hardware.

Once Nova get a bit further along, it will be a non-issue too,
because Nova can drive either an fbdev, or whatever the modern
alternative to that is.

  
> I know Eliot has a bunch of follow-ups in the pipe, Eliot can we make
> sure to dynamically detect and enable BAR1?

thanks,
-- 
John Hubbard

