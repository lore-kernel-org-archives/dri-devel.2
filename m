Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E96F589D2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3C10E358;
	Thu, 23 Apr 2026 13:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oK+CWkUx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E311810E358
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aofIZpWO0iTVK6jF/DYfxBy9Nn5j6sUTMolut2zDQP4eTRUU72coGocWprjcdxI3boOPgG3QmjIMro4H1+68F111MLyVgJp0G/UUkI8C9rAC9l4/t5HG+Q2bigteArJoUKXQvS36DsQRyKe2HfsSx9BWRolqPwHACeCLqcC/8a8j6Bt6LNDUdS3HrQiI3nZPhFECaZcG4wHdjzwVVJ/2LeZDxR+8V9H+khIMoGQXEykC0u78Ysx7fMSI9DGySIjqBtlbl8TVLkTJ9MTLrN0k9pUYWSl6HGg1n/n1rJ17ChM8/6d4tKYFVzn1I1dwKkcgUS5T8JEYYkGxFwI4fhz1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taeyCDrwasBDX8vNG+xlZ6KEoTyXsoHKGSiOJb8wy1I=;
 b=H0tWdFrVt/MfbHp8dWWCJc5bPL2eOe4cRmeheYxjx4CMr2m+74t4r+6tSom2Y4N1QiAz2OxQZka/Xi01rbCZHGRYlLcBFS8988soyFxjrXrWvroPYVcZqbAFfIwntSILMKlMmKgdaRVik0Ujger12tLWAJyhwsUtLxhxfdptX9VMed+a76LoYSPyGM4RdGEPDOZJzli9UChloxThpLrfw4plviQA58ufjDkiDYFoiYPIj3eroK3nt1rdvfOSgLXkwuhmVFXaHSbzrWHxYDbfc+BJx5WV3+6S+EycG29d64bCWKLzm012ikCS0iF6cAn9UBPMqgFum7b8TcExu+cZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taeyCDrwasBDX8vNG+xlZ6KEoTyXsoHKGSiOJb8wy1I=;
 b=oK+CWkUxFMvchC3Z2vUu0sqplE/MkqAlxnB/0olCk1rfayI8XzJ77zsDfIsxYmzgIbRy10m4wIilZ8nUddzOyhisqhpAiUCz4wRW8K6mvbsoDn0CQ/kgPTwacKXH6zDZrw5vFCTNSb63AGCAO7h9AwII6gmZW3eq7uwxnlHa6k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 13:29:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 13:29:46 +0000
Message-ID: <759f311f-3551-4a3c-b889-8149de7081ef@amd.com>
Date: Thu, 23 Apr 2026 15:29:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DRM Equivalent for top
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 "Francis, David" <David.Francis@amd.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
 <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
 <f37d6f6c-49ac-4725-ba4f-b7ce0a3baa5a@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f37d6f6c-49ac-4725-ba4f-b7ce0a3baa5a@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbe940f-613f-448f-97fb-08dea13c62eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: GElfT6Zy0Zotu3mlRYeT2FE0MCYs1PfMNq9vBIRlC3tPkE9Q29J4nehd/ebg/KnMj3k3nY127reZPhi5B2EYRJzY9tXRudsaFClMY7cUjNhhKqf0GLC3FzUdlFQUXpcj/evb1Jzer5jdKpK12XPs6lljfEDAbNIu5gfF6Nwobw9TlMmvAygW8pSEH2zmO18IBX6mz6nMdvCUi0l9J5LV1wd/rbslPurev0s/CiCjC6ru5nE1o26KkyU7qY8o+oJeHCRvQ2WfJ8Glt817MPVspsVlas4XnL1Orn45nSs1Coz+rkQzTYHBbGfamkJRTaCQPhwO1T3DJuDBA6JsJ1b3cGqC6tjWzPnQmGR/s/q7Yaw8rR0SeS1Kjln8i3vDAANtcGHYoh1tLFHsOtVo2u1DMBSwYNaNAnflUWuhDxuqCHVgU7BF2BZyEX0haGRH2/fzrkPSc/4WTW7gPrax2NmxIzNQnufjbAsdslzxsdFU8jL22c9MiOtkOBR2BAGUZ4Wk+u0354+Gel302I7zoAWVsf9zBJg4cfQiWccvU17hpMsWUFTogvzznGjhJc983k35W/Bo1imdzgXlAGfgUHHC8JQgwuksF/HkbFL0qr8Yi3VeDjRICJxiUTkkSWDHldcZBqWSPcLb6pqvY7BDUWXocQ2pwVPQNRvGY4qDjnQMocAlxkhHt3R7p8/Gn2+Ye/9l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElXQ1p5Tnd2OUdlNmkxYytBYXFock1TRlpOVlBmTS9QY1Z0QXFUZFZTLzI0?=
 =?utf-8?B?M1p3K3pzQ2R3aUJ3SFZSTUo5M1B0MUdITk83WW04czdFdlAxRmpheVgyRzhT?=
 =?utf-8?B?S2RaRGl2RmJ5d3hja3dpSHFsSFUxLzVWRXdSUlJjSmJCNkZveEtzTnpJSUJx?=
 =?utf-8?B?V08rVzZWaG1IcjdOU1ZhRXg5VWl6QkNLNTVYZlVySDVwbEFXNmJUZldTeEVT?=
 =?utf-8?B?bFhHS2pBUTlldTVmRTVVVjhqVElWc2tKWjhhRit0dDVtbGJXNTdvNzhic2tM?=
 =?utf-8?B?YWFMSG9sdC9VWjVOVyt2OXJuOXpWR21wZSs4d2ZPVmZlbUhZYnZ3aXRpc3do?=
 =?utf-8?B?UlkyZ2drTzAzQXVOcEdaNzlDTi9ZTU9UWGQwUHhWNlpzOEtqaTl2WStsdm9O?=
 =?utf-8?B?US9rOFpwU0ZTb3FHemFjUStnMTlUdmRiYzVIYXpxUkxJSXZXWXJacWNsSHlz?=
 =?utf-8?B?V2YrMTltRlFLY2M4eFg2aXcxOU5CdWJRRlZqb1ZWdTI1VVJuSnBGVVl1c3ZT?=
 =?utf-8?B?WVpxQzVEaytheGZpRCt5aU5OZjI3bmdZZXNQcVNEeTA5Yk5uOXRCaGpmSlpQ?=
 =?utf-8?B?SG1aLzVzWStHYnRuWTFFaEx2anl1OE5LSDROZWVqcEdiQlpJZVl5dXY1YXFl?=
 =?utf-8?B?cHFMRE1Ua1JwQmhUSGFsc3FNdTRyenNHQTFoOUg0NTNyMk5nV05OL1FLeVZB?=
 =?utf-8?B?amFnZ0NBUzlMQW5RZWZWNjg3MGtvcXNMeE41ekJDb1VvYmxhRTZJTW8rNkFO?=
 =?utf-8?B?UzI2M1NmdlJOaG9XWDhTbWxGUHdxZmtNZGprVjVjSEUrY2d5a1ZkYUlHbW85?=
 =?utf-8?B?bDZyMzV3cW9RWFFOeE81eTlwVDFubkI3R216dEpVOXFUNng1bS9nb2VqdDBs?=
 =?utf-8?B?Si9JNGFrSnFtRHpuQU54b3M1Y01QL0dXamJDNUtjY3pQRUJVNitXRjBDK2w0?=
 =?utf-8?B?cmMzMGVQSUNveWpWb3ZMWStMNVJ1M2hHc0NSdFhuOUJITTN5eVh3UjdzTG9m?=
 =?utf-8?B?QWFMSC95WnBteWVUeGpnQ1M1QlRWczJhaS85TDA4a2lnTFVmOXY0bmdJalow?=
 =?utf-8?B?cHJMdUNPSDV5U2tLMm5wSEh1RWJSYkxPWG02WXcrRHZSdCsxblpncEVmM0Rk?=
 =?utf-8?B?UmVrR25jRHQzbHdEU1I3UURtb3VDU3dxdzF2UUtFaWFtdXFUTUhzSmZSVGpi?=
 =?utf-8?B?NkJpZWlNa0R0ZFprdWRtMThXL3k4M0lnSVRpSjJJZWtsdnFnSi9VM3JmWWNw?=
 =?utf-8?B?VDdIc0h2ck11UU1tbUVIb1VtVDcrOTIxakczTm13NlA3dWxJMjlNUDlpeEVn?=
 =?utf-8?B?ZE1XaktSSWJpRHk1VVlibE1VMDQvNGNqL3BBWGdFY2JVQlArTzhJZm4zWTQ2?=
 =?utf-8?B?WHJhMkl4MGFrZU9LdkdPcmQ4Y3ZlaVloWGNvSzVSYUI1emdSQjZJbTdqYlVO?=
 =?utf-8?B?MnRmZzFHK1B0MHFrK1d0eWMzNlQrZVF0bklHb0tOL0tsTUhiaWVLOEJick1X?=
 =?utf-8?B?bVhpM3lxNTg5TGRYcWF3Z1NROUd4dDVRNVlSQXJ5SEV1SFkySWRWa25oR25i?=
 =?utf-8?B?YmRWOFl2YTBBTFpFUWhlUXNyQW5DKzM4N3FDMW81R3JmMGlma1czWU1FaSsw?=
 =?utf-8?B?bDU1WGZFL3p2Ly9xTjRPV1BScEFta1JHcmc0SHNDL2FBV29FdkF6Q3lPK255?=
 =?utf-8?B?R0tuU1hXMmtmV2VpazFEcnZGOVJlUTcyQzB4TitWcTRBM3JlVE1KdlhGYW5i?=
 =?utf-8?B?YlJPK0R0Q3ZjTDA4Z214SHhmVlBlWXdmUWtjZGpkSzAvb0hPWStPd09KVWdm?=
 =?utf-8?B?Z0todEljMjV1bG13YkhMbVB2YmRhdmRDSDFKT0RNVEV4WUZ2b09Fb08wTjRB?=
 =?utf-8?B?c2ZuY2cyUm9ocFVncFZSRitFOVZlWTdVSjRlL2djWlhlSENwYXUranB2Zkhy?=
 =?utf-8?B?TnRUeGR6UitBdEpaeW81aUlabHdZOFR2TEtnaXErbUN3U2lzVHppQ3Z3ZHh0?=
 =?utf-8?B?eWxuN0EwZmJsZnNVY0xFU3FmYTBOeVd3dEpLcU1qQzZlOFozRmU0RzZRSldJ?=
 =?utf-8?B?Z0ZNREs5emtkajRRVHhlQ3IrK0VqSjY5aGE1eHM5YW5GUmdSeE9Eck5PNnc3?=
 =?utf-8?B?ZkIxajlKOWZiYnM0MkdNMEN3emp5ZU9FSHh2RjJVMERWeHJCV0gvdmFhZkJj?=
 =?utf-8?B?eVJ6M201VFdWYmY2Vk9vQlVXdk9YMDhJaDlEVVoyaHR1V0xGWGwzRFNDRzE5?=
 =?utf-8?B?UUJOR29EZGtrcG5qTXBoWlhDbUwwMnNldXR0OG9Nak1UcjZuRkhSV3R5V0xv?=
 =?utf-8?Q?j9DnbifGIinwBuWSlb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbe940f-613f-448f-97fb-08dea13c62eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:29:46.6284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF8UfMU/BApHy67bsGs8sXrI1FpcGoHuRXU9i1grHZlzvEsmQa58GeiAPhXxOmCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

On 4/23/26 14:00, Tvrtko Ursulin wrote:
>>>> We would like to do this through fdinfo, which does track by pid, but that would require
>>>> making part of fdinfo public, and we received negative responses to that.
>>>> https://lkml.org/lkml/2026/3/16/1816
>>>
>>> Would setcap CAP_PERFMON on the executable be good enough?
>>
>> I don't think so.
>>
>> The fdinfo access is currently protected by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).
> 
> Right, sorry, I was very unclear. What I meant was, if the patch which was rejected by the fdinfo maintainer was changed not to propose making access public but gate behind CAP_PERFMON _and_ new FOP_PERFMON_FDINFO flag.
> 
> I sketched it out, on top of David's patch, here:
> 
> https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=cap_perfmon_fdinfo
> 
> With that if one does "setcap cap_perfmon=+ep $IGT/tools/gputop" it can enumerate and show GPU utilisation for all clients. Well all which have marked their fops with FOP_PERFMON_FDINFO to allow that..
> 
> I am not saying this is great as it adds more code and more inefficiency to an already sloppy path of client enumeration so for discussion only. It is exposing things less so may have more chance as an interim solution, or it may not, I have no idea.

Wow that is impressive.

I knew about the capability system but had no idea it could do something like that.

When that works it looks quite reasonable to me.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
