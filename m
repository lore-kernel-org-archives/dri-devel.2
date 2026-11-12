Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E660606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=usOOyN6M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DCD10E274;
	Thu, 12 Nov 2026 09:52:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABD010E3EB
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b26Y/4KQr1m1hOtVHRuDe0v6JGyqOypvNlvkX8pzJDQQJXLH+P3+bxSDFirl/T/JO/z6nz08dZBiv6VTMMJ8UG/e3oWNwFBGVqT5ulQVxJMX9mniIpGvRAo0E5++WFkEjLyTgqDPK1MQHuiHUATjI+0Z5ktmBGKYin1JNmEr46SuTGrjQX5BLmqYVS9HHm2kavWW2yh1RGLhWJjl+IVcz+lwdFGhU0P6ZKKS6zLmhZeQzn/Ghd5/B1xLM6odwqvsLjHpmSKvyjRs6V0QxU08Nnc8UAJQRK9clE7a8kIbWGGP9NbtT30jSATeKwcDm4Lil485ZOYqh9aA7IxhtxcfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eICWT9mOH9GYKNEuFVRfcXk8QFDAoSIkQV/mIuYhqNE=;
 b=S8W7/Whn4IO3IoTmUZJ6lm4dWk1J2yFVqBj5AewPrADdjKc20P7eV/OpOtsU6Lg65nF5gNkyvXjtFX1BrxWghpb14nArVP0XMNEOGCSRDLwZ678PCGq/yg5XepZeMTFx0JfSO7frwf7VTjj81Jlfkx05aMoqqpe9Nq86wB+XGB+yw8/L8EBDxHXl1GbIbefgMP4LVWt+Toi+0Eel9l32tNERGgPvHIkAoqylHOIopWfXX2ykq75t+OQKsOJ1wVw2PZbUXwuhjt1QU9iJOQLzkrZCsdIDKTaF3Pec8KM/eJ1xlk0wiCRwQ6E+S1DZFUs/Tc9Kss2Xci35A9CONh2BAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eICWT9mOH9GYKNEuFVRfcXk8QFDAoSIkQV/mIuYhqNE=;
 b=usOOyN6MIeuMuQcUV2e/y4jqgXOVx6DiNbS3GV9OTevYY1XN6pvrp69R2MS85kVpP8ngVExX4EOBNdqtRU4vXxgFHwPdFwgvbFgOcXwiYwuOyQxaNU0Km0W4d4N6vJeeBTpK80LFufgzMq5pfoj2Hoa8z1jbeEuQvnXntk3603s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 09:52:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 09:52:19 +0000
Message-ID: <698c5faa-609f-405e-a33a-a48fefd8d411@amd.com>
Date: Thu, 12 Nov 2026 10:52:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] media: synchronize CPU access to imported DMA-BUFs
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hans de Goede
 <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20261107104703.44111-1-kmehltretter@gmail.com>
 <20261107105946.GA96745@killaraus.ideasonboard.com>
 <avUvHGb4talXW7qS@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <avUvHGb4talXW7qS@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: adb1ef29-20b0-4d2f-99d7-08df40a2a3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|11063799006|4143699003|261009223027099003|56012099006|261102130727099003|261026121527099003|261022075727099003|261021121427099003|261021135927099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: /lnZGPgeo1HEhOBtZpRHj+rcGRPF4eUbfNC8ESJNX2D1GKCj4ta0/DhXHi+t51g4HaNCpJqlSNDOoaSC33ZJ9mU6gqWaSkNtsMYZZHE6CjLf5HMJvDH82++nBOhDx5pZhv+XBxfie2H2oVeikUQr5OiioJLYB8xWppfsK9aGtNqf9BYvwroYuCyyyu72iUH00Tcf0kCM4ELCmnpCoMlnvCP4cHB0T9Hz5yvOyczBkLEYa8pFtjqaMmaro9tAnRGBYftkVThBnDKQMM3mBxngHIfKN3TY9+xtFfd3v5W5GDVnes5Vq0Ws2onxjiHWu1Oh8czTvZa6/lsIHLJmKIQ0t01984SALzK+lzADPlHOuSMLFXYb+Kr8BPqTve4caSPsa5JETurmirlvDOsxk6uGkIRb+iu5yFpwibUc8Fjaf0pADSEUwUieqUVH+gEbw43md6SpXS2ZHrZwoPoTQ968J4LlwMfTjRNLUUc2HCx+fPz4tWWV3caN1HHtDwXYQv4D5QBWdH1AcUCHzf605lQKpHk4J2rZZ05G7a/+Z6LFX5fQLqTPNnf2zXejC7rxe0ogJhaR46uRAfN5WYDMpL05ZBKqEHW3P50qjm+swC9fO3fP3axyKFC7cCh6JoFdNToM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(261102130727099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021135927099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3gybUIzanV0OWJFbnIzVGdKQWZUbjI3KzdZNEVsYVpxRmhncHB1SDVOc3dx?=
 =?utf-8?B?bVF6VVUwUzhKOW1ZeEVwQXBoTWswSUxYelJVcVRuMG5iWE82SVZ6eDg1aC9n?=
 =?utf-8?B?dGFaTTVnSjNQZy9NNzVjTjYyaEJlT1RWejltTWQ2eDU0Ri92eitXby8rNnpR?=
 =?utf-8?B?eDZNNkk2aGRRUXRJUkorZitBeG51czc5NGxpM0pyYjlBVkZOZGJ5TEc3cTZU?=
 =?utf-8?B?YlB5VXh2UXEvc0REK2ViRXoxWnVCNUs2WjFiZy9zMzBkaGlzc1JadVRYMTBi?=
 =?utf-8?B?RVNWZExYMnpJTjVzNlFocVdnMW9qS3FubHArOURpbVpGMUNpdHVzNDl6Rndz?=
 =?utf-8?B?Q09mck5rSmVYZ1VTRFFGdkg4MTBYa04vcW4wNEIyREhpdHB4eFM2cUV6K01w?=
 =?utf-8?B?RGh3QXhjMm52bVVwTTBYaWRENzA0UGdoZjNXWkJrcWNPbUk1UTNJOWd4ZFZk?=
 =?utf-8?B?UHhKbnowbzAwSm5wc2NWdHRIM1ozREhTU0J5STJXQWRWREx2MmZaVWE0ZXVq?=
 =?utf-8?B?SzZwNUd4ZzJlcXJqL3F5eUV5MUFFNzB0U1ErWjB6bnduS1lWLzN0RDROUGYx?=
 =?utf-8?B?Q3E1c21ZbitXOXRHb1JOcEVOeEhrSmF0SUd6V0NHdmVIOU43LzZNckpPTHZx?=
 =?utf-8?B?VlhVSGRwZFJydVQybkp4VWVrTHBHcW8yZVR5Mkg1LzVTYkpCdERtQVh0eFVv?=
 =?utf-8?B?UHJuWmQxVW9EclJVdGJpSEV5bGUxN3FZM2pmSVlNUkcwNmFONkFWcVlURXpp?=
 =?utf-8?B?cXo4bGI4QjJmRFFhS0pBQWNvdVNwc2t1d3RzS3ZjVUhCS2JaMG00Z01OaFlR?=
 =?utf-8?B?SUxRVzlUNXZTdHY5bmxFTHErUHpodGR3c3JTT0tZUER3eGp2aEZ1NVdaQ2l3?=
 =?utf-8?B?emZQQXJLalBvSWJkS0ljWEtsdjF1ZFcvTGx0c0tFd2hxb1dWQ3ZLY00yVnhx?=
 =?utf-8?B?eTJoeTh3Y0tac2hWSWJCWDltOEZOeWhEZ3hlQSt0S3J2dzFHektVbzByY2hE?=
 =?utf-8?B?RUhnQWNrMUZsQ1I0NHpPaUthamtkMGJsQUp3cE5TTXB1dXlIdzJCSkxja3dh?=
 =?utf-8?B?ZEVMdlUydlZxdkVGdnkrbjMvdkhaZHY1N29kb3JTVnVJWUttM0hCTGI3dUxS?=
 =?utf-8?B?a1dWYWRCckNRaU14RXBWekZXbEt3ODA4eEZVanltQmhMR1pQdVpzRmJzbXdw?=
 =?utf-8?B?T2JsUU9oOFp0VU1vaFlsZzZ2UXRDcVFhUkx6THgyS05vQU95b0U2NWFDVncz?=
 =?utf-8?B?VStnek5KNDVNb0M3NGRzVGdpQ1hnaDRwWThBTXh0aUxLcU1zZndOSjBwL25t?=
 =?utf-8?B?Y09QRDhGR25kY2tKZG9TSDRER1ZmNHdxazVMZ2xPNWlIdElER2FqZ2JkL3FX?=
 =?utf-8?B?M1FQaEZGdkhRREYxaXhzckd0WGpXNy9YY1Nsd2JIejUrMERSMG9BQVBmYlVO?=
 =?utf-8?B?VFBxUkpNWHRGVWJHZTZoMlR2SEhWNTFtOXU4M2ZqNXRFb2MyWlphUkFMNVRN?=
 =?utf-8?B?T3o5STlRV2tOVGs5cGNRVEEvNXNGNE9YQ3RjV3dMYThSZkdrZVZxSDh1YXRj?=
 =?utf-8?B?QUd2Vkl1Z09rbTNtU3NtNDZMd2VzNkZtd1c1MGpjZU1BS2hnYmFyelB1bUMw?=
 =?utf-8?B?ZjdYY29FTTRUNUNNS09tSGVhM0w1OTdmSVExU0R3QWJWOEhvbjdXbmgwanZz?=
 =?utf-8?B?U3BxTjdiMmViNmZuTFF3cFVOdy9hbnd6T3V5THpoVm5wTU0wUDRvV1plN2h5?=
 =?utf-8?B?ZEpmcXlCV0gyT1k2cENtU0g4bUcvdG1ZeDBnS3hQdTNFZjBqTXp4Qk1lb1dT?=
 =?utf-8?B?UlFJQkREekdTaDY5SHk0TWV0Q04vTmRydytjZTdzRHdsNERwUERNTkhOQmxX?=
 =?utf-8?B?UnJMbWNDd21sQnVOOUUrYldqeG5nL201YXJuMTJuK2JTOFBycktKL3QwUXNi?=
 =?utf-8?B?UXJWTGIrUi9WUEdKNHFCVXpqWncrSWZvb29ES2d4OXN0WFdiSmN6emZMVnQw?=
 =?utf-8?B?VW5uR2pVWjd4QW9OcVlwcTQxajZOaDRWa3RkOWNhdHJYM0xTVncvTXdZa1Bo?=
 =?utf-8?B?akJ4bnRSR0sxYjFjVzIxTUtTbWJUMWFRb0FoZWFLUHlFTHkvaWM0R2NrZTN5?=
 =?utf-8?B?TmduWFZiRnhSQy9qT3lxWHhFT3lUdVlFUU8wZGdiaXVxTUoxQVNEbWVicWti?=
 =?utf-8?B?RitFQ2dSbHFaaVp4Nm5LcDZ4VkR3SHhlMW9zVm43Z2Yrc3ovKzlTZzJ3bEwx?=
 =?utf-8?B?dURYOXIvZGMwUDVjYll1WUZwMjlXV29nSjFidEd6TmlOYnFUVEJSWllidktl?=
 =?utf-8?Q?w0j6kFvlk3OKDmpwdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb1ef29-20b0-4d2f-99d7-08df40a2a3a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:52:18.9439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srqAgoRqYJz5Pe+u/UJ6Jw6xdlhQV/nLp1UKWSbiZCJgVoLwwyaDyKE4AD5ZpMkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 04:16, Karl Mehltretter wrote:
> On Sat, Nov 07, 2026 at 12:59:46PM +0100, Laurent Pinchart wrote:
>> Hi Karl,
>>
>> We discussed in v1 how this is not the right approach. Why are you
>> posting a v2 without addressing that ? You need to go back to the design
>> table.
>>
> 
> v1 ended with two conflicting positions on non-coherent DMA-BUFs:
> 
> - Laurent [1] and Nicolas [2]: end_cpu_access(WRITE) only marks the CPU
>   cache dirty, and non-coherent DMA importers clean before starting DMA.
>   Persistent DRM/KMS imports then need a sync call on each submission.
> - Christian [3]: devices must access DMA-BUFs coherently with the CPU,
>   using begin/end_cpu_access() around CPU accesses. Importing a buffer
>   with dirty CPU caches onto a non-coherent device is intentionally
>   unsupported. Today cma_heap and system_heap sync all mapped
>   attachments inside begin/end_cpu_access().
> 
> On my Pi 500+ with a USB UVC camera (640x480 YUYV) and V3D on CMA
> DMA-BUFs:
> 
> - Without vb2 CPU sync, V3D reads stale data on 8/8 zero-copy frames.
> - With vb2 begin/end_cpu_access() on cma_heap, zero-copy V3D is clean
>   (0/8 stale). CPU capture takes 91 us/frame without a V3D import, and
>   144 us/frame when an idle V3D PRIME import is attached.
> - With a test heap that tracks CPU cache state and syncs imported BOs
>   at V3D job submission, zero-copy V3D stays clean (0/8 stale) and the
>   idle-V3D CPU read drops back to 89 us/frame.
> 
> Question to all: should I look at opt-in cache-state tracking in
> dma-buf (with a sync call before DMA submission), or keep
> begin/end_cpu_access() as is and handle CPU consumers via V4L2 cache
> hints?

A sync call before DMA operation is something we intentionally rejected.

Background is that exporters should export the buffers as they need/use it and not have specialized handling just to serve importers which would be not testable without the importer etc...

What we could do is to consistently use begin/end_cpu_access() and/or let exporters expose if their buffers might be dirty in the CPU cache so that importers can properly reject them.

Regards,
Christian.

> 
> [1] https://lore.kernel.org/r/20261021175900.GG15441@killaraus.ideasonboard.com/
> [2] https://lore.kernel.org/r/7e4c7707880e9092180d28484ecf674be29b40a0.camel@ndufresne.ca/
> [3] https://lore.kernel.org/r/1e798600-5a76-412a-959c-94313629baf4@amd.com/
> 
> Thanks,
> Karl

