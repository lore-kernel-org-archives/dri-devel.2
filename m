Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5F606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d0dNK02/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3850410E00A;
	Sun, 15 Nov 2026 02:37:19 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24310E00A
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 02:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfeQCy2420xeBUoO/A/iCqE+4xc6YsBTJeiky9oaKltj//0AzhgBAt1kjwMXeIZQeTS5M4G194UDh8A4CV/s1ONKrLMKgBunEb0gT4vWU+Ob3jpY588D/gQA8Oe3mNb9FnliQ3eciDJmBHAoPEsRpGye6XKkLnv55yfXyEjLKp1K+qALh2aSzguXZvzk78CU0PawuRecAcPTeGzFhMbEOqQmy7t91YhTyIhZ1Z0ZHAWT1uswAk5+F1Ns/O0oH23vQCDOjX5hDQPAT85GaB8J5r5caWOLxZPf1O1nNOUZySJvIkhUilkLTcB1IKZ9TuvQX6BzDog2PqlWJboPRqBNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2UxIIaHeQM/KOq7C791LDsechzQNjeJFROc8O/AYtU=;
 b=BYy0/q6S/Lys64qOX//E+42MsvpU1H8pDBJyKgrrlWgufONsnQk2tQh3IKt6UaYIoIUiruyojVkP0Tl/v452NnVWJC+fV+W0vVyHyZMZhMyuvasAzXzkHjBnAKBI/cionQWeH2XcUhCIjVbq+ZbeGZhYImorIcP6b79Cw9/XeZVgXhWvGVwvSZ7Q3m9SOGoTiOxtYwb0I+sv/8jV3kE8GvpRTUDir4vFaPmJlrogEL/sowUX2pXD2UEPi44c3qqpomMwldIQC946gjOPXT3c8V15OWKRGouJp5zpTFPB2OIUPk4aYtd7EjAsTmU8Zh6QlEy9weGy5ih3CUmmSyGkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2UxIIaHeQM/KOq7C791LDsechzQNjeJFROc8O/AYtU=;
 b=d0dNK02/ISX/I146DkzvZRT2x7gmN0Kg2fFbQK8f5eSkjH2WNa1IQWI+VV7TPG3DMieDmA6/IAeXsqF0sCLlTYRddg3F4BKkVgq+RLWu1Pp1hat6jKo0i46+dvBmiEBAI4Ce6VQC41yTwhll9Z7WdvIC2PdRg/SRvZaK7NL1rT3jJJyz8zWKzW6sDY311n7uNu/cHZjg8B8TrWPzyCL4AHyC8bxFLuR/vJ4oxsm0DAh2l6eZiWPQEiyYBxqZyw8K0nPNwGEfhDgNy/on6u1m5cwXREN+DpQ9uakjAcsNqhKX+SZ+dr3tL4FTulqBgjJ7hQtKdW63mb5PW4jpQXfbaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sun, 15 Nov
 2026 02:37:09 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 02:37:09 +0000
Message-ID: <4166acdf-fdde-44e5-b052-7eb059296f36@nvidia.com>
Date: Sat, 14 Nov 2026 18:37:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] gpu: nova-core: retain the GSP-RM log buffers
To: Vladislav Zaharov <vladazaharova2018@gmail.com>, dakr@kernel.org
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261114044304.245684-1-vladazaharova2018@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261114044304.245684-1-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e54c298-f145-48fa-8ae4-08df42c15843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261026121527099003|261022075727099003|261026140227099003|6133799003|261028144727099003|261102123227099003|261021135927099003|261021121427099003|261022105027099003|261021123027099003|10067099003|261009223027099003|5023799004|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 83D4CHYJqB6i6FqA1iDuE8JbhRs54TJBGEy8tptzIlVsPHUFjnkbX6y/Rc3AP31QAUCZ3haLizuNDFFp16NKHCUiyEw5TQxgwZxf/OIIBeAJC180yzdGTBAy0cagHC6i4jKncPkUs93tkJd79LWUZauZYBCiJrhlRqJKPV5ldoB+Z8kxA3hZ3HOJQdC9+rDaMmskUuJw8QTyyq0YanU9DclpROLV1Rq3Pvp48gFhVVmhiKdFflESYJC+Gcll/S3e3sOBDiZKyLp8C03mWSuNmjGX39NMPvowR3muN9ThAGvS5PNPLLASdck4X65maoEBwJjc7Z45ewSJzd5D6dAZXI9sjU0ByEPge6Mx0SJw1tZc9AkgDFEh7nPZfUnSHkmwqKcdlbfIuU8St8Fdk+Zc/OhRkR2iB5MIWvss2bVC7Jsc7ilnnNGyvzA4hkgWg7vXlhg3wzz6+HYbbpnLgozIhloMX0qBPjeKSNmnQ2K/zJt65B9fHBwrGJMYK9yAl1jL98h1txnD9QfMesN6/bIW8JVQlmbqZctYXi86C3QYRZnISQ6LjNJrtJOygGQdsC2Og4dmlPWbzJE7LJNXGeQppI7PGMzI/6dKnqyvWk7BhKHeSetuPeJkjdf1Y3qAz1epQ0dvXJ7Cb6VJNp9lDaoTbho/zjspiGLyepnmS/sDJEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(261022075727099003)(261026140227099003)(6133799003)(261028144727099003)(261102123227099003)(261021135927099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(261009223027099003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJseS9qZFhiUGYvQi9lUEJCUVlMVGs4NWVtdjFvelRGWFVMQTdub0dlcDdT?=
 =?utf-8?B?NU1raEs4WnFmS1RhT3ppR2dpR3l2SkxKaTlCOWIrVTB0NC8vWW4zYWpybytN?=
 =?utf-8?B?c3M5ZXMwRVl1NVlYRHEzcERwRWVXMUFCb1BxYUVaTFJQNGRzRTYxcmo2TnRZ?=
 =?utf-8?B?SjBvRmwyKzNIVG01OWFDU0RvekcxbFAxUlRTU0k1RzllNTByb1lCODM2bUdO?=
 =?utf-8?B?SnErWERLcHpxRFBuMzRrV3V1dmJvRjhqM2xiUkZ0bEw4Z2huMkRsRFdzSGVW?=
 =?utf-8?B?ZmJvazFkMC9jTkdselNwTmx0T05FQ2NLcElqM3MrYlM5YnNmMXdGUmk5Qzlp?=
 =?utf-8?B?UEFVcjRMaUhtZUxCa3d3MU9HQXNNcVFUUkJTeWpqa2hkdVhiMmhrd2xjNVJ2?=
 =?utf-8?B?UEdpRGlkU0FsK01waGRGU1ZKbW1NQTZSaSs3Z3JnUWk2UDlNRm4wT29vYjJa?=
 =?utf-8?B?bFJDN3hCQ1JySDZocUJHWG5sUHo3WElFbzR1UVdoeit2dWQ3WkZPUGlVOEpS?=
 =?utf-8?B?SUpvd1dxUmtYTW1hbFpjSGlvWHVVYTdQOUlGNytKbGNpTmw3c1JJMy8rcjd3?=
 =?utf-8?B?MTlZbzgxRmJzd3NLbGJORXIzVWY3bXp3R1RMYkpablc4UWtESWcxQ0FzRk1M?=
 =?utf-8?B?UVRvY2RtcXBzTVE5MVptbjIyMDRvL1JlRDBvb1VDRVROOGNLV09nU21zNXR3?=
 =?utf-8?B?SXp0elFpdjE1ZFA1TGY4U1pmOU5xVE5Lb2NLTUFXNUhwcS9mNnNLRTBJMmtK?=
 =?utf-8?B?VEp5NWhDcytBQUg4ZnRiRkUxajFMdVc5WGFTLzhEemlJY1FLVTJnLytjcXZJ?=
 =?utf-8?B?YUttbHBlUG9rbE1hTG83Ni9jVjVVVjJuSlVZdlNPSEZHQStjNTRtRE9tZzlm?=
 =?utf-8?B?YXBTRXRCWmFTdEVjV2MrNTBYdy9HTHlsUVZPek5OcWh2dVYzREtpS3JxdHJr?=
 =?utf-8?B?TExncTY2bHllcUI2aUd1eWUxWXlzR0FYc0pybHBFTXpGNks4NjhYY3FBNWJa?=
 =?utf-8?B?OThWZVYwTytBbXF3UU5zelI1b2RqQWJhM2paVjlmNlNaaGR1VkJSTTc4Z1FF?=
 =?utf-8?B?WkhHV1RSa2FFV0UzdUZ2S0lIbEp5dDgrSzlXeU56eVZuQUliUUJpOWRoZVhD?=
 =?utf-8?B?Ym15YW5EZUdBbkNUUEMzRXNKK1RrbUc2ZU5nR2tBN3lRTnBuR0dwTGRmSFN2?=
 =?utf-8?B?WnBvcnVTaFYwZXRRY1l3cU81Z0tPeDBReGN2MnVnbWU2RzdVUzEyaDgwRUph?=
 =?utf-8?B?ZzlkVkdYOWFyOGpBbFhCSm5zZlU2U3FwczE2dlpiS3E0ZXk5REZrQWVkaDdF?=
 =?utf-8?B?ZGt0RXRqakhPeFhLcXdJZHZrMGdRZXpmT204YkZLNjczK2ZjSlZwSUl5Zjd3?=
 =?utf-8?B?d1I5QkgzcjlVUXNPbXljUnBqN3JPc245Szc2Lzc5UWhPc2J4c3RXYWtoL1Rl?=
 =?utf-8?B?YkxsRW44T1FIZFZhUHBuUUZ0UWNGVFJMMndqVDZqMTNYYWNyREFCd0lKUnVl?=
 =?utf-8?B?dldnM1ArSGtRK3ZYKy9wSWhaWDdVRzBwL2lSV0QxV3FlRkd6QVV4L2FvbStQ?=
 =?utf-8?B?SFEvR0gvOXFub2p6OUUyVkd2T1JTMXRueWdCU2ZOMEFUSk1ZYnRhcFRFNWZm?=
 =?utf-8?B?OVpWWmg3K1ZuYmwwUGx3a1NCWFRBWjFtN3piWGdjSWR0andDL2U0UWh1UXZo?=
 =?utf-8?B?OXI5QnBjTVNybytEczVxM21ZS25hRGF5eXAraGpjaGhBSDBJVFcwU29VTzU1?=
 =?utf-8?B?NTFmVlRrVU01Rk1peHhndTA4eWNEbVdTOXpCOVJCMFBDQXFTZTRSMFh0R2NO?=
 =?utf-8?B?NEpMWFhpRm1HMEJvSElxU2crdkJlWmhzb2czZjRsQ0drajlXM25jbnd0dmpF?=
 =?utf-8?B?aFZSc0NZSDJJalIxbVV4aDRiZGNaS3h4QlVTdGo2akQxdWxGdG9pRWZUVlQx?=
 =?utf-8?B?SGdnU1hoWVhlN1NhTWFhQWFZbTJrUVhOVlpPajFrZkU2WDZqbm1ZNXVxNlF0?=
 =?utf-8?B?VGlHS1NLOFhjOW53MVJQK0M4cjdZOHNRUzVMSnhHd2g4NXFscGNuVXdWay9o?=
 =?utf-8?B?aStwYVFlcnRGblB0R1Z4aEZvTVJZTXJ1MWJrc2xCOTZDQTZlaVp2MlV3ZDB5?=
 =?utf-8?B?MzJtS042Tkx6VGdHenBuekhNdTB4ZG1YV3RLQ3BMSFRkWFkvMEgybld4ZzFr?=
 =?utf-8?B?cjIyZGRoSDE5L3QxSGNPbG1PQjRRc01Ha2xQUm5DZEo3bW9Ua2wwWUxjSVNY?=
 =?utf-8?B?L3RSaGVyeHQxdGRBL0N0RzNDNVpUWnF6RDlKMHNKV2U5NVROb2xtcDltRCtt?=
 =?utf-8?B?RFR6ckNJbkRrZ3VaSEtiVTNxNFE2SlIvWGNIS1Jlc1BKT2VYc0JWZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e54c298-f145-48fa-8ae4-08df42c15843
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 02:37:08.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzuI6SgF7YCDWvwD5H73c8IgRVmb23syrSJOy8rLNvwwMhbny50u2Gy6NNTPwHVlkbiPlI1NdBdzFHhKKtVc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 8:43 PM, Vladislav Zaharov wrote:
> The GSP-RM log buffers are exposed through debugfs, but they go away
> when the GPU is unbound, including when probe() fails, which is when
> they are most useful.
> 
> Patch 1 moves the debugfs root into the module data, which also fixes
> the root being leaked when the driver registration fails. Patch 2 moves
> the log buffer code into its own file. Patch 3 adds a gsp_keep_logs
> module parameter that keeps a copy of the buffers after unbind. Patch 4
> drops the completed item from todo.rst.
> 
> Changes since v7:
>  - patch 3: check only gsp_keep_logs, not CONFIG_DEBUG_FS, drop the
>    reserve() before replacing the copies, add RetainedLogs::push() and
>    mark retained_logs() #[inline] (Danilo)
>  - collect Alexandre's Reviewed-by for patches 1 and 2

Hi Vlad,

This is working nicely for me, the logs stay in the same place and
I can retrieve them even when I inject an error in the driver to
fail the probe:

root@redforge:/sys/kernel/debug/nova-core# dmesg -t |grep nova-core|grep failed
nova-core 0000:c1:00.0: probe with driver nova-core failed with error -22
nova-core 0000:c2:00.0: probe with driver nova-core failed with error -22
nova-core 0000:01:00.0: probe with driver nova-core failed with error -22
root@redforge:/sys/kernel/debug/nova-core# tree
.
├── 0000:01:00.0
│   ├── loginit
│   ├── logintr
│   └── logrm
├── 0000:c1:00.0
│   ├── loginit
│   └── logrm
└── 0000:c2:00.0
    ├── loginit
    ├── logintr
    └── logrm


So for the series,

Tested-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

> 
> The code and the commit messages were drafted with an LLM coding
> assistant and reviewed by me. Each patch builds on its own, and the
> series was tested again on a GB203: the copies are kept after unbind
> and after a failed probe, replaced by the live buffers on the next
> bind, and nothing is kept without gsp_keep_logs.
> 
> v7: https://lore.kernel.org/nova-gpu/20261113075317.934264-1-vladazaharova2018@gmail.com/
> 
> Vladislav Zaharov (4):
>   gpu: nova-core: move the debugfs root into the module data
>   gpu: nova-core: gsp: move the log buffers into their own file
>   gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
>   Documentation: nova: remove completed GSP log buffer task
> 
>  Documentation/gpu/nova/core/todo.rst   |  12 --
>  drivers/gpu/nova-core/debugfs.rs       |  45 ++++++
>  drivers/gpu/nova-core/gsp.rs           | 100 +++---------
>  drivers/gpu/nova-core/gsp/logbuffer.rs | 205 +++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs     |  68 +++++---
>  5 files changed, 313 insertions(+), 117 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/debugfs.rs
>  create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs
> 
> 
> base-commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86


