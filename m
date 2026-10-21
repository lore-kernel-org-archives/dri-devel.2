Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED797606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mc9Bv1ms
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EE410E24E;
	Wed, 21 Oct 2026 04:05:16 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AF510E24E;
 Wed, 21 Oct 2026 04:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSTGye5QxBvlp84CilErPTQ4rKG+tbGCfaln/VINEp/sGT80mn81LfzbsTP6NKo36AJ2HbbbDb/s0tgJzd7prea8xAfRhn6jD6RNr4d7qtoYqlS+ijuNTF5AdY2y3E5sCymyQpgCIDnRtI7XZLP6aBpEXTjkKlA9jE+iNKDnXkyJm30ef4yVGmh0eid0b6BaucwUcqyS2O4Hn9q4dpwAJALm7ZFS2AHoejX97mQzYLFOx4bqBDrZWE9+PzaSZEm5ftalOp3zSvlkJPzOujyBeisPK5BMmaGUHeAHVCzuKjQaAZixGMXP7/wgqf3dJLjEyir2iwE5vQbcPxdADpL/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0vcosaKsE3GrtoZCvq0PbBa7a08asmQwIeVFpdPREs=;
 b=L0Br8FKCTWILE2XX+hBQzrJf0WyFwWOPyZsq04aGmd3UIE12N1rvAVLbVpRWZ2X8CgZfJyEaYG0hVazFsoEWU3Ly9IaCCy9u/LwaO0j/Ahbz+MzRNEnmw8mJy1Bujvio4CGqBWdNOz2q494AuL6icYYfJKS+uBGFZAg0JoxZBUGtQjvDTz+8KfRMyIBL6Ckj6+bgMqeADPCA1cRJzwjmG9KPkmC2T+I5FcLNb7xqwVXT+wbbP5dufFwFtCdHO4555yByHsGf/zbY8Fkh7TuJccmgSX6eKIGiMdaY/vAr1W7fFhHl2aNMr9Ts548gXyvT2ELmTGML40JDRra7BQZ2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0vcosaKsE3GrtoZCvq0PbBa7a08asmQwIeVFpdPREs=;
 b=mc9Bv1ms2+xceNc+/hyrYt4mgLPvJSMvgGLLHUZhLSKoNh+oFtvn8CaJ1spfUWqwyEdjN1U4+wRsdOixabqUxqxiz9ToPlU+yO5qidSymHZn4n9MS0w+nmgSsJSY/TKf3CicWfVUWmKbIGhzzkDhf97k0v5osOlPK7bI2Wib809uMWt0qBKufpeFwwOiYRxMnTo8RreyrdY8V+PVZyo7/wwsekV8CB9kdXNwOZn+DYHbQYGBVvrdO9sjiF01DCehzwbwzJ8shySYJ7BiB0cj902/a4l9IF9Nq146XRoFPMDIDt0QK484pjRvrIYSKxngOyFrDQoC158aWj849k/p5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 04:05:06 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 04:05:06 +0000
Message-ID: <c19b1cea-0a35-4889-a36f-891f0d9fcb13@nvidia.com>
Date: Tue, 20 Oct 2026 21:05:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
 <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
 <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
 <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0168.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::19) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1134f158-7b7e-4bd4-cd1f-08df2f287db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Rp37+REKtGozb/9IP6m8xers9BN26EwzipudFZ0EYpL13dWztv6QNHgHHHWkYRFw5tZQITIOBXzsF9Mt2K4ncT0qVt1HPuDJuz59r9v8fGZ8P85T24zjmqQciDyN2G052TqFoSZZMypq4K5omjsNMAoVYrG8Qqrcb5MRsMHAPv8y1GnGVCtyrmqZzqccneIiOnEMYOYOPTkBPf2DazINN31xjGqFIlT7v3YbVZqHQYc79JT8XIJ2r6vIm0lJpEFGvTBOTY318ImJoLHR8OdMEcobQkpAGvkGT702StbF+95BE1fDByleaGca9Sthl+Rv7HGCwN3/QZos12SuibfINm3eSR7tV1OClmuCgJytJ3z3JFuF3xNnjdNZOeENEzHBGrEg9opo8ueh81+giMnzTQMVWiLGEBW1nV+Dni7o7CbXE3XAd3ptIrUifG7EAXHWpNmPC23cd3SN/OLpPoKCjfloj2dQKbzGx6DN/SaLFwFpiqD8f1QayNmHHpy5fkgOdYF7+lu0wFOmarGQK0lsaKHoJBH6VtmRWfxrp+xH5jqAxRikqG29m/Dm7Z/kCLmYUonpcv1exXjdiFSfaTYS1o9fgx2DbFgFgqw3MML+wbpGg3OP6aWopE8zdAK7dKIrW+pn+oW/Xb/cHvgVrooldPj/+D+HFrwCd0l4Jjog7hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NVVTk5ZjZFYmN0V2J6N3A1T2tyanFlSHA4ZlZBSGYzbzZNdi9UU1k3NE1O?=
 =?utf-8?B?bGVGZDZ4aUhjQXlPYzg1L0dYc3J1bWlrRm11eXVvSm51dWFtU2hlUmNzTGZp?=
 =?utf-8?B?dGlnaCsvZ0pqaFFZd0xzekdNdGdTVDM0NTM5UUk0ZVd0K3RRa3RWR3JrdjA4?=
 =?utf-8?B?VzVqdXN4M1NHZURGMEMxMndIT3FhN09iTHJvVVhHcGZHRURYNnllbEVKV2N1?=
 =?utf-8?B?UXNtazBmaDhBSEVVUFNLWlpld0syVmUza3d5a1hMUlg4cExtWGtVeTd3SGtC?=
 =?utf-8?B?amNZbmk4MllXc2wzUWtvTm8rOVp0ZHptWDB1OFhIY2REc2pWMitmZURFTHpt?=
 =?utf-8?B?blZrTTVsZVlSZEc2UEltVm1KNmdyNWdoN3V0RnhLakdXaEdzNWJ3NWkxZmgz?=
 =?utf-8?B?QWxZUlMxOFcyMVVOY3M0SWVVbHI2czVHTWZibnd6dURsZXBrdjR1eVpDMWQ3?=
 =?utf-8?B?NFd4dDFNUlg2SExybnMvNFhPNDQ5K3o1TFovUGw1OFAzM2ZZKzV3ZzZIVjJu?=
 =?utf-8?B?cWR3MHhQdXQ4eGIyY1ZKcCtjeWVEck5FaVA5N2Z6Zm5VQ3RYY2hFY1NHemZK?=
 =?utf-8?B?Qk1qQWhEaTkwRk1uenBoUUJGS3VRTnU0azlJYWRKeGhwOStxTmJRcFhFQ2F0?=
 =?utf-8?B?ZGduRjNQajl6V09Ka1ZKTDlRVXV1OEVyOFFhNUxtNzJ6dllDVGVYR0RSU3hI?=
 =?utf-8?B?R0Z2TEpTRm0vc1Q1aW5PeTJEOHBxNXBVMm1NM21kbjJoOWV2SEdkUko0OS80?=
 =?utf-8?B?K0RpY05ReGVJWnp5c003OEp6cGkyeW0rcjdGVStWUmIveFVVZENVVHNZRTVa?=
 =?utf-8?B?Z3VXVDlpR2FYemY2eXEyU3BqSkxRTzZucGw2ZGVMMHFOS0lZb2pQV0hLUjJM?=
 =?utf-8?B?bVJ4ZTVMQmM2ZC9jdFZQZ0EzQVVtZmJSV1RNdmZ0L0F5Z3V5TkJvMlRCU09t?=
 =?utf-8?B?R3BaMG1BY3h5R25IREp2b3FNaFl0TDg1TTJnOTVpNkJ5b1dkTE5YTURuVHhQ?=
 =?utf-8?B?clZUWlV2NkFScFBVdkxVbUg3RVFpb0pHeHprMVIrbitWbkJLYVVXaHZvT1FN?=
 =?utf-8?B?UHF0Y2JIbFVDeEhRWXU2SEhacUNZMk15YzlFdTZsRmRqeVV5amF2RERSMjNh?=
 =?utf-8?B?WUNBR2VtZ2ExRUZ1TnpTSHgyNTY5b1lOMGt2UFhLdzI3bVc0QWhhNExaTU4x?=
 =?utf-8?B?QU9ETUdlOWNwOFozQ0doRENiMHhnSnpMNUlLMWdYQzZoNTQ2ZmZHVSthc0s5?=
 =?utf-8?B?MS9SNkNjRE9KRVIyNXRKbzBDclMydFI4RnRWcDIyeEV0dU80K29FQTl5Tkor?=
 =?utf-8?B?MlJ1TU1CdE13N1dXWnpScWo5QmphMUhrVm1ocnZmNnlPOXdyMlMvOU5JWms4?=
 =?utf-8?B?L1pDMnNaR0tFb3c1RzFnMHFRbUh3VjF1bndSTnlrbzBTamlsd3dvcm81KzNi?=
 =?utf-8?B?c3FydGRhMGhDRndPc3ZZb1N1Q2RHZ242ZGNEVmZRRWlBQ2cwRlRtVk1CTjZG?=
 =?utf-8?B?TXRzZFl4U3dDU0lRZmZOR29zdG91NGQ5MjFMVVhUSHhuQnI4SjRVRy9oRE5z?=
 =?utf-8?B?bHBabXhUbzNycXl2bDcxcUYzbXZuSUl5VmE1T0hOODdpd1g5SGV5YXFKVE80?=
 =?utf-8?B?TnVVNmpsb3JJOGRUUWU5NlN1VXhIQW9yOUZjczlkcXgyRC9kWnhrSkxYNHVU?=
 =?utf-8?B?cG5QRkxvK0ZJcDI3WFk2R3NZdkFOVWIrQlBtbExvTitUWEdyTWNSbk9SckVZ?=
 =?utf-8?B?QzBnYjNMbk5zYUQyclNWdVBZS3dDRHJicGFCMG5rSVp4a1hmek5OWjRmd1Y1?=
 =?utf-8?B?YlpkUGRXU0N2bVJmL0NJeFRZNXpiSDJFSjJlODhqOHBYVXRYdmVobWF3K0RM?=
 =?utf-8?B?ZnBJSm81dXBKOG9TRzZ4aXF5Y2c4aitrMUNkdXRreDlpWkRLd0NHb0ZTOEpY?=
 =?utf-8?B?a2NVOWJVeUZEMGFKbnZTY3NFdkVNVVZ2VXZrN3lDdk1OVHJyNmN5bE43RUtV?=
 =?utf-8?B?R2t5N1F2dzEwaXQvK2Z3UHFqeDF3NWMzbDZ3cEVhakp2MlVsZHdBTGVIaFRj?=
 =?utf-8?B?b3ZvZnRveFV4WjVoRGtCa0RtaEVGbjFrUFF1Q0ZhNkl4dlVUMGpLWDNqSEls?=
 =?utf-8?B?Q3dGcUZKTXhaMDJWbXYxYUZzekhSK091OUJyM2I2bHpUc0NDSDkyZlpadlJM?=
 =?utf-8?B?NnV5TTQ2V05XQ1BZeHF0SjV2czBuOElNRmxiZ2hzbU04WW05ZFJsQ0M5Rnlk?=
 =?utf-8?B?dTdQWStYMDNod2tDNWh6Q3ByTit6ZXZzcXVpQmJHNTNNYjdsY0I4UnVGRXhz?=
 =?utf-8?B?NGNXWlZNY3VlY3U5eDFoU0h3NW9XTkt6ZEdNdGV0bzFGREdneGNEWFRkMXV3?=
 =?utf-8?Q?R36pmFnvQLm1QCvI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1134f158-7b7e-4bd4-cd1f-08df2f287db3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:05:06.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4NQA6SZeWWLBrPnXqq9EMBOdqI5fyj6ThZIs6VHKInkwJJJ+kYKST43qtGzA7nRySd0wXFSxGePUlVu7YOx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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

On 10/20/26 8:23 PM, Eliot Courtney wrote:
> On Wed Oct 21, 2026 at 12:12 PM JST, John Hubbard wrote:
>> On 10/20/26 7:57 PM, Eliot Courtney wrote:
>>> On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>>>> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
>>> [...]
>>> I'm also fine with special casing `wait_for_msg`, but personally
>>> (maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
>>> me.
>>
>> It's not necessarily wrong, depending on how you think about it:
>> "sleep, but timeout at zero" is something I've seen used (I forget
>> where) as to mean "context switch away", kind of like a cpu_relax().
> 
> Here, it only sometimes sleeps ("(maybe)"), depending on the resolution
> of the timer and how long stuff takes. So it's really pretty
> inconsistent IMO.

Yes it is going to act in ways that look non-deterministic. And that's
OK, because:

a) It's not broken.

b) It's not unreasonable nor even terribly surprising behavior: one
can reason about it.

c) The requested behavior itself is impossible: "do X for an infinitely
short amount of time".

Why are we adding code to optimize behavior for callers that should
not even exist?

thanks,
-- 
John Hubbard

