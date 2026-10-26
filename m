Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B0606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5PU4LIbo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEE710EDA1;
	Mon, 26 Oct 2026 10:12:48 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F8910EDBC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeRdfbDG+3j+to0MabTsLhqoEPBPeXws7AieSSuV584M04bOfTKpmS2PKXAEfIoS5ShSb0Kfo4b3qr4OSGs5qYv4IWPQ+0tX6IjGYDmoukCdhtVY2gSM0cXdRpm8JbvcG46bliTEB5owTOCClQgWPzeC0WOZL/zX4ntsKev6pKq7gVaGzssm4gZ4LtJ+O6eO8Qo7uz+5fWIMwLdBhqMkwaZgb4BTgZIAMenffamKZ1Egv/ZuqG+NObFX7K8+Mw5aCyQRz5tEZ1Oblrdd+dRs9UDj/+Ryqn79tsspH1lIQWIJMe8U2WQG92gHyB1oQO5+ez4veTOJ1rFdRFN+yK4/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MI1b/8VmxRUKvqh6xPkRi8crG6E/sFhRsmY8DR7ifU=;
 b=msC4FYONfuEbkpeYed0ALP9JNaBb7gFBH9lSreFG95rlPWBzT0R4Tp/gtTrAbn6VfBQhWvQxu6B7nxnezCREMQD4//pAoFxEMBsukClliIMtVU5Gxkoj6/j6jThivZ9BQHKyB1a+pxU0A5UssIjnkf82nK7kztJ6xKCObUARljILP0sWadH7miGovnbDgec/NoDtaRanwLx/34Ywe13iV2YYD9l1NlWnKAP1xbKKwk7tcQiDOgKHUiTOpmBYdCT6HzHYN+MqlUVxDqeyMKfd7UfxVIqTdItegQG1cQigGnIJLZ0OjH4mjnAyRgKkaoMKJQPgUpcThCxLLD1pQtYo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MI1b/8VmxRUKvqh6xPkRi8crG6E/sFhRsmY8DR7ifU=;
 b=5PU4LIboH47hyWJmcDBWccUakawTULCQDcDM64Xvhbci7Onf9pGjzIJvjBQU11c//bWoGGqdSF2i6flEVOH8wKuMuo3QhjT83GNSHRq4NkcFIIcalrx7ggSkBrv1lv2JbbI6ZNsZleeq3K+PB1s6V7m33XAocjoLJv2yugwmv5I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:10:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:10:35 +0000
Message-ID: <bd97b230-b513-4864-b4dc-882ae224c2ac@amd.com>
Date: Mon, 26 Oct 2026 11:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/16] accel/thames: Add IOCTLs for job creation and
 submission
To: Tomeu Vizoso <tomeu.vizoso@gmail.com>, Nishanth Menon <nm@ti.com>,
 "Andrew F. Davis" <afd@ti.com>, Randolph Sapp <rs@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Andrei Aldea <a-aldea@ti.com>,
 Chirag Shilwant <c-shilwant@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Markus Elfring
 <Markus.Elfring@web.de>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-9-3ab40aa17157@tomeuvizoso.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261023-thames-v3-9-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf3e292-5183-4fe1-e875-08df3349603f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|13003099007|3023799007|921020|56012099006|4143699003|11063799006|5023799004|261021121427099003|261021123027099003|261022105027099003|10067099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261022113327099003|261022075727099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: PSWtF5SfADMrPdgNzjT61hlAytQrNeUb5n2hLM4dZtisuvNYG7KVQKl/ekrPIjhXz8l9fRmfUsSJbxN2KZYp6AeAze+0ciHyk1tenCjWemZMfr2MXHMfS8DaFX4emZZRRKnC5ntGna9oAPuuO7YJFy66nbQlqVoI+Nom/csdfaRM/CxfelrgTL5AvTvUWzVHvQE5yytaN06gSQNft0ZUspU90n1hf2DW0l7xYX4sTLJJJpnm9cEDJbb/ytKiHmwkzOOccK5I4er6gcswDEJNCMC10XM+9R8Oi94j6xlmVAoEVlQSs8iA6x6bYurSbzTShqTs3nUuKdk9jghp4Z0g+EVSCZgzgW5JuHNBa0J8hdZkpxbIPA2APzlf/cWcVHmwIXy6SsW9Vt1MqVmpYlQ6KLEOlL+GvO8TVJUEjYtjTbJAdg2IxJ24Xgu/iH6IKYDqWmguL2yBJ9fAGJDtsj1Ajh0nAPuQMqOIRvBxa0SxVUN4xcMStRjXqVm2RE02YuedbS/6umfz2LBN9Ul9t8B9RTK51Z7iIQDSThEkrwUqnO/zh6uvFcgGez06IV9v5vTHaYgKnn374A0mVPzn6jnu721Qmi6q4P8EQDrh7WN3wZd/h44HL/DXcWX1F9L6oVAbwZEbNa3cyD8le48Y9xburw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(13003099007)(3023799007)(921020)(56012099006)(4143699003)(11063799006)(5023799004)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261022113327099003)(261022075727099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBTdVlCVHkyVVFMTzczM0lBMjQ3YnlBelp2WjVoRVJmOUZRQWg5aUJ4Z2Zn?=
 =?utf-8?B?ZkJvV2F5NFR2aGRORnNWQ3ZWV2NZWkxneGUrdXdUOWxMeUFqU2FIV2NwT1hn?=
 =?utf-8?B?VXB5NDkrTDZwWWVYcHpLK3JpaVcyVnBwU0d5czAzdXNqYTZjVElCZjdMZFBY?=
 =?utf-8?B?dmh2VnFpUTJWeExGclRRaGxNV2sxSWEwaHQ2M2diNDQrdDl1bGZYWkFhSzZx?=
 =?utf-8?B?Z1pvM0FyRVRlR3JZc0pweGJLY3dMZ1BudlEvRWd0dnZUZDBvR1BBTkxxM0ow?=
 =?utf-8?B?dU9PeG9TYzVnN05Hb2hqSmI4dnhKT0Fjc0lWeWV2OVhCbm5DOU9xSUpMWFJK?=
 =?utf-8?B?ZGxXY1hQL3NZQ3dIakFLR1hiTExsS1YzTUc2dTRhWlMvU3RkQzRoZVkzZyty?=
 =?utf-8?B?eDRNLy9JZzZGb0JtMGxZNzBjS3AyNWdBdjJ3Z1l4R1BzcGpLRDBNeEtsdGtm?=
 =?utf-8?B?NW5UelduRmVDZi83Q0o4YWtQaE1oZU5XNDR6amExdGNGejF4VFBxSXJ6YlJT?=
 =?utf-8?B?TXVRUTlwZ0NRSWxDdFV6MzgvMFhGQWw2akJJNjlXb3hVTVlYMmY2N2pOR0c5?=
 =?utf-8?B?M0xwOGJOb3NYcThCRitMZHNDWEhtU0l2T0Uvc2UxRmZBbjVLOUlPYmNGQnR6?=
 =?utf-8?B?YnAwcHVhMHJlRGtROUcrZjliLzVHVENZSXNnZHpGa2ZCY0x2bDgwWTE2aElZ?=
 =?utf-8?B?dnJTaGdrZjRtQzR0NlJnaG1aRFJ4M05wWWxrTzZIOENyQVU1bzZ3ekdIaXYr?=
 =?utf-8?B?a2V4MzgybW1nMFZVZjZoYS81bUJUd3hIblB6aDNwNVpQekxFNWlEeXhMbEJn?=
 =?utf-8?B?cnU0N1BmaEIrUDRJMzRud0NJVWx6UmRtTzJZOVNOOTAveU50N3V5V00yVjE3?=
 =?utf-8?B?MklGUHF2SG5vNWtoTjY4OGQ0T0cvTEpIRGtxRytma3FFSTQ0WUFqQjZTK1pE?=
 =?utf-8?B?UkVRWEVpb0taVkMycGNsVmtBL3RyUVBkVm8wajF0MG5jT3BiT2VpMjRCZEt6?=
 =?utf-8?B?UjhTWFFiUkRBengva1JubHJkNVFTM3R3MURLMU9ZR2FKdTBva0JQRzcwN0tk?=
 =?utf-8?B?RW5oRy8vZTFETG9tTWhvb2o4RkcyTC9JL3lWNDlZYjhsSXR5MXY5U0FsejVj?=
 =?utf-8?B?VWRDRzh5WnhVbUV5VTJZSUEvSjRuWE5Nd2lPZUtwZm9nY0NvRC80U1BCY1dV?=
 =?utf-8?B?NTRQSFVlTmZRRlY5SEEzbDVIcTVIbHZyVTZxalRrWVJxdHIxYkdORTdLUzNl?=
 =?utf-8?B?SzMyRmlrYWt1L1BBYlFYbTFvcERoUnIxaEt4MWcvdzB3UUV0UWtyTURxRU1u?=
 =?utf-8?B?elBGRG1HcnhzMWRiaHJiZGY4QUFnTVdGMjllNHJzQW9EV0VwTzJ2TE5VUjVP?=
 =?utf-8?B?QzA1aHU0QU1LTFNPeDRVYzJ1WWNuL0dUVDdIeGR5K0hzKy9wQ2l0dlNpNnBG?=
 =?utf-8?B?THUzcERTT29sUWR1OTdKenZIV2JXTUxOY0FmRWIyR0RiZ3kya0pWSm94akdW?=
 =?utf-8?B?c2UzTHZTVTNSdXZIaTJxWXd0ZWhoZHR2dE5jZE1yaDZNT1c1UVNuTTFMSDRR?=
 =?utf-8?B?ZGNPWk96ZUdmVnVGZS9QOXR0NHQ5QlU0dzByemhOaTlNcWJyTXZLRmFZVnJK?=
 =?utf-8?B?eEs3ZGNOek5LMGZFVmJQaVRudkd6dU5TTW40ZnZZQzh1RnQwNStydCszUVhZ?=
 =?utf-8?B?S0s1TjNiWFVWWU1CTzlCTE1DNTRjK0E2Zk5FdXp4NXFQSDgxdGlmOUxaVjhp?=
 =?utf-8?B?MlhicTNPb0ZzK2tXQXZtbmd1bW5aTEhhRllYcVZCUThoY1hWWnVyOFBzRzA0?=
 =?utf-8?B?RGwxakFmV0dEYlEvaUphUC90NDlCZDlqUXpyTHQxeHc4cTJVY0VVNmdwL3Za?=
 =?utf-8?B?SEpxQnBwOUNTalE3d0ZVSkJDZi9Ja2Q3YzhSeHl1T1NhZ0JuT3JGY3RwUDR4?=
 =?utf-8?B?VDhwd3JoM1RPRnFUck1qZTZBV2JuNjJMMVBjc3hSdm13aUtldlBVWTFUQThM?=
 =?utf-8?B?QjIrVzNzNzAwQkxlSGVxRjUxSGtya0M4bEtSR1RKV3RSVmNlOG5SdmFRNFNs?=
 =?utf-8?B?ckI5cWs1bWQrMmF2UWpicmxsQUJmcmxXM0dGbnQ4UzJQUmlYa1MzQXpZOTA5?=
 =?utf-8?B?OXRieHpQNnRyT0tPT2R5eGt4Sm94Wm1RdWJxZTI1SFErSHd0NFNIRHMxc0RY?=
 =?utf-8?B?ZWRzVU1Zejhaa3Q4S1FUWkJISW9aQWpjVkpOZktXNDdmT3pZSUZITWh4cHBa?=
 =?utf-8?B?Njd1QlV5eFJYYnBJTEd0K1FiVm9nc2xqNlJwV051Sld4Q1BucDJZNk5mU2c2?=
 =?utf-8?Q?tkOVD8dWw0U6+2eccX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf3e292-5183-4fe1-e875-08df3349603f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:10:35.2936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5opi0ZpJJ1e142OX//82zkHJfdNz2ru7pXQGKdVPEA26S1QBKysGbHBug5kBq47N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 08:39, Tomeu Vizoso wrote:
> A Job is created once from a program, its parameters and its transfers,
> checked then, and submitted any number of times; the params buffer's
> contents may change between submissions. A submission pushes the Job
> onto a core's Ring and rings the doorbell; the firmware moves the Fence
> when the Job is done. Each core has a drm-gpu-scheduler instance, with
> one credit per Ring entry. A submit call takes an array of Jobs, the
> buffers they use for implicit synchronisation, and sync objects to
> signal; it waits on none.
> 
> The job submission code was initially based on Panfrost.

I only skimmed over this, but what I saw looks sane to me from the dma_fence requirement side.

Regards,
Christian.

> Assisted-by: LLM
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> 
> ---
> 
> v3:
> - Add Job create/destroy, for validating transfers.
> - Add sync objects to the submission IOCTL.
> - Allocate the done fence with the Job; run_job allocates nothing
>   (Christian König).
> v2:
> - Add thames_accel.h UAPI header (Robert Nelson).
> ---
>  drivers/accel/thames/Kconfig         |   1 +
>  drivers/accel/thames/Makefile        |   3 +
>  drivers/accel/thames/thames_core.c   |  36 +-
>  drivers/accel/thames/thames_core.h   |  14 +
>  drivers/accel/thames/thames_device.h |   6 +
>  drivers/accel/thames/thames_drv.c    |  43 ++
>  drivers/accel/thames/thames_drv.h    |   7 +
>  drivers/accel/thames/thames_job.c    | 869 +++++++++++++++++++++++++++++++++++
>  drivers/accel/thames/thames_job.h    |  73 +++
>  drivers/accel/thames/thames_trace.h  |  77 ++++
>  include/uapi/drm/thames_accel.h      | 259 ++++++++++-
>  11 files changed, 1381 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
> index 47a2986fcabd..f2c32ce8d228 100644
> --- a/drivers/accel/thames/Kconfig
> +++ b/drivers/accel/thames/Kconfig
> @@ -6,6 +6,7 @@ config DRM_ACCEL_THAMES
>         depends on TI_K3_DSP_REMOTEPROC
>         depends on REMOTEPROC
>         depends on MAILBOX
> +       select DRM_SCHED
>         select DRM_GEM_DMA_HELPER
>         select DRM_GEM_SHMEM_HELPER
>         select IOMMU_IO_PGTABLE_LPAE
> diff --git a/drivers/accel/thames/Makefile b/drivers/accel/thames/Makefile
> index 143a829f24cf..7bd652795cf5 100644
> --- a/drivers/accel/thames/Makefile
> +++ b/drivers/accel/thames/Makefile
> @@ -6,4 +6,7 @@ thames-y := \
>         thames_core.o \
>         thames_drv.o \
>         thames_gem.o \
> +       thames_job.o \
>         thames_transfers.o
> +
> +CFLAGS_thames_job.o := -I$(src)
> diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/thames_core.c
> index dff76abd8951..85e8f48aec60 100644
> --- a/drivers/accel/thames/thames_core.c
> +++ b/drivers/accel/thames/thames_core.c
> @@ -25,6 +25,7 @@
>  #include "thames_core.h"
>  #include "thames_device.h"
>  #include "thames_gem.h"
> +#include "thames_job.h"
>  #include "thames_transfers.h"
> 
>  #define THAMES_RESTART_TIMEOUT_MS      5000
> @@ -327,6 +328,7 @@ static void thames_mbox_rx(struct mbox_client *cl, void *mssg)
> 
>         dev_dbg(core->dev, "Doorbell on " THAMES_CORE_FMT ": 0x%x\n", THAMES_CORE_ARG(core),
>                 (u32)(uintptr_t)mssg);
> +       thames_job_complete(core);
>  }
> 
>  /* Embedded in struct thames_core: nothing to free. */
> @@ -515,10 +517,18 @@ int thames_core_init(struct thames_core *core)
>         if (err)
>                 goto err_timers;
> 
> -       err = thames_core_request_doorbell(core);
> +       /*
> +        * Before the doorbell: requesting it delivers at once a word the core
> +        * wrote while no driver was loaded.
> +        */
> +       err = thames_job_init(core);
>         if (err)
>                 goto err_unmap;
> 
> +       err = thames_core_request_doorbell(core);
> +       if (err)
> +               goto err_job;
> +
>         if (rproc->state == RPROC_OFFLINE) {
>                 err = rproc_boot(rproc);
>                 if (err)
> @@ -540,6 +550,8 @@ int thames_core_init(struct thames_core *core)
> 
>  err_doorbell:
>         thames_core_free_doorbell(core);
> +err_job:
> +       thames_job_fini(core);
>  err_unmap:
>         thames_core_unmap_ipc(core);
>  err_timers:
> @@ -554,6 +566,7 @@ void thames_core_fini(struct thames_core *core)
>  {
>         if (core->mbox_chan)
>                 thames_core_free_doorbell(core);
> +       thames_job_fini(core);
>         /*
>          * Drop only our reference and keep the boot count: the core runs on
>          * for the next load to reattach to; only a reset or a suspend, which
> @@ -567,6 +580,21 @@ void thames_core_fini(struct thames_core *core)
>         core->of_node = NULL;
>  }
> 
> +/* The system firmware accepts a stop only of a core in IDLE. */
> +bool thames_core_idles(struct thames_core *core)
> +{
> +       u32 head = READ_ONCE(core->ipc->ring.head);
> +       u32 slot = head % THAMES_RING_DEPTH;
> +       struct thames_fault_record *record = &core->ipc->fault_records[slot];
> +
> +       if (head == core->ring_tail)
> +               return true;
> +
> +       /* Read the fault record after the head that says it is there. */
> +       rmb();
> +       return READ_ONCE(record->kind) == DRM_THAMES_FAULT_FIRMWARE;
> +}
> +
>  /*
>   * rproc_shutdown() reaches the system firmware because the core has one power
>   * count, remoteproc's auto-boot or this driver's boot: the probe defers while
> @@ -577,6 +605,10 @@ int thames_core_suspend(struct thames_core *core)
>         struct rproc *rproc = core->rproc;
>         int err;
> 
> +       err = thames_job_suspend(core);
> +       if (err)
> +               return err;
> +
>         if (core->suspended)
>                 return 0;
> 
> @@ -589,6 +621,7 @@ int thames_core_suspend(struct thames_core *core)
>                 err = -EBUSY;
>         }
>         if (err) {
> +               thames_job_resume(core);
>                 return err;
>         }
> 
> @@ -640,5 +673,6 @@ int thames_core_resume(struct thames_core *core)
> 
>  offline:
>  restart:
> +       thames_job_resume(core);
>         return err;
>  }
> diff --git a/drivers/accel/thames/thames_core.h b/drivers/accel/thames/thames_core.h
> index 590c5716f7f5..a78414d18ad3 100644
> --- a/drivers/accel/thames/thames_core.h
> +++ b/drivers/accel/thames/thames_core.h
> @@ -10,6 +10,7 @@
>  #include <linux/mutex_types.h>
>  #include <linux/remoteproc.h>
> 
> +#include <drm/gpu_scheduler.h>
> 
>  #include "thames_abi.h"
> 
> @@ -44,13 +45,25 @@ struct thames_core {
>         struct mbox_chan *mbox_chan;
> 
>         u32 ring_tail;
> +       struct list_head submitted;
> +       struct list_head held;
> +
> +       struct mutex job_lock;
> +
> +       spinlock_t fence_lock;
> +
>         /*
>          * @rproc_caller is the task inside the driver's own rproc_boot() or
>          * rproc_shutdown(), whose subdevice callbacks then do nothing.
>          */
>         struct task_struct *rproc_caller;
> 
> +       struct drm_gpu_scheduler sched;
> +       u64 fence_context;
> +       u64 emit_seqno;
> +
>         bool suspended;
> +       unsigned long timeout_left;
> 
>         struct resource l2sram;
>         struct resource l2aux;
> @@ -81,6 +94,7 @@ static inline const struct resource *thames_core_window(const struct thames_core
> 
>  int thames_core_init(struct thames_core *core);
>  void thames_core_fini(struct thames_core *core);
> +bool thames_core_idles(struct thames_core *core);
>  int thames_core_suspend(struct thames_core *core);
>  int thames_core_resume(struct thames_core *core);
> 
> diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
> index e183c78e2acf..0a34764885df 100644
> --- a/drivers/accel/thames/thames_device.h
> +++ b/drivers/accel/thames/thames_device.h
> @@ -36,7 +36,10 @@ struct thames_caps {
>  struct thames_device {
>         struct drm_device ddev;
> 
> +       struct mutex sched_lock;
> +
>         struct thames_core cores[THAMES_MAX_CORES];
> +       struct drm_gpu_scheduler *sched_list[THAMES_MAX_CORES];
>         unsigned int num_cores;
> 
>         struct thames_caps caps;
> @@ -72,6 +75,9 @@ struct thames_device {
>          */
>         struct mutex bindings_lock;
> 
> +       /* Whoever takes a file off the list closes its Jobs. */
> +       struct mutex files_lock;
> +       struct list_head files;
>  };
> 
>  #define to_thames_device(drm_dev) \
> diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
> index 030c60963a0a..fc3328834162 100644
> --- a/drivers/accel/thames/thames_drv.c
> +++ b/drivers/accel/thames/thames_drv.c
> @@ -23,6 +23,7 @@
>  #include "thames_core.h"
>  #include "thames_drv.h"
>  #include "thames_gem.h"
> +#include "thames_job.h"
>  #include "thames_transfers.h"
> 
>  static struct platform_device *drm_dev;
> @@ -54,14 +55,23 @@ static int thames_open(struct drm_device *dev, struct drm_file *file)
> 
>         file->driver_priv = thames_priv;
> 
> +       ret = thames_job_open(thames_priv);
> +       if (ret)
> +               goto err_free;
> +
>         ret = thames_context_create(thames_priv);
>         if (ret)
>                 goto err_close_job;
> 
> +       scoped_guard(mutex, &tdev->files_lock)
> +               list_add_tail(&thames_priv->file_node, &tdev->files);
> +
>         drm_dev_exit(idx);
>         return 0;
> 
>  err_close_job:
> +       thames_job_close(thames_priv);
> +err_free:
>         kfree(thames_priv);
>  err_exit:
>         drm_dev_exit(idx);
> @@ -87,6 +97,14 @@ void thames_file_priv_put(struct thames_file_priv *priv)
>  static void thames_postclose(struct drm_device *dev, struct drm_file *file)
>  {
>         struct thames_file_priv *thames_priv = file->driver_priv;
> +       struct thames_device *tdev = thames_priv->tdev;
> +
> +       scoped_guard(mutex, &tdev->files_lock) {
> +               if (!list_empty(&thames_priv->file_node)) {
> +                       list_del_init(&thames_priv->file_node);
> +                       thames_job_close(thames_priv);
> +               }
> +       }
> 
>         dev_dbg(dev->dev, "Context %u: file closed, %u references left\n",
>                 thames_priv->context_id, kref_read(&thames_priv->refcount) - 1);
> @@ -208,6 +226,9 @@ static int thames_ioctl_##func##_entered(struct drm_device *dev, void *data,        \
>  THAMES_IOCTL_ENTERED(bo_create)
>  THAMES_IOCTL_ENTERED(bo_mmap_offset)
>  THAMES_IOCTL_ENTERED(dev_query)
> +THAMES_IOCTL_ENTERED(job_create)
> +THAMES_IOCTL_ENTERED(job_submit)
> +THAMES_IOCTL_ENTERED(job_destroy)
>  THAMES_IOCTL_ENTERED(bo_bind)
> 
>  static const struct drm_ioctl_desc thames_drm_driver_ioctls[] = {
> @@ -215,6 +236,9 @@ static const struct drm_ioctl_desc thames_drm_driver_ioctls[] = {
>         THAMES_IOCTL(BO_CREATE, bo_create_entered),
>         THAMES_IOCTL(BO_MMAP_OFFSET, bo_mmap_offset_entered),
>         THAMES_IOCTL(DEV_QUERY, dev_query_entered),
> +       THAMES_IOCTL(JOB_CREATE, job_create_entered),
> +       THAMES_IOCTL(JOB_SUBMIT, job_submit_entered),
> +       THAMES_IOCTL(JOB_DESTROY, job_destroy_entered),
>         THAMES_IOCTL(BO_BIND, bo_bind_entered),
>  };
> 
> @@ -272,6 +296,10 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
>         if (err)
>                 return ERR_PTR(err);
> 
> +       err = drmm_mutex_init(&tdev->ddev, &tdev->sched_lock);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         err = drmm_mutex_init(&tdev->ddev, &tdev->transfer_table_pool_lock);
>         if (err)
>                 return ERR_PTR(err);
> @@ -288,8 +316,13 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
>         if (err)
>                 return ERR_PTR(err);
> 
> +       err = drmm_mutex_init(&tdev->ddev, &tdev->files_lock);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         INIT_LIST_HEAD(&tdev->transfer_tables);
>         INIT_LIST_HEAD(&tdev->contexts);
> +       INIT_LIST_HEAD(&tdev->files);
> 
>         tdev->asid_next = 1;
>         /*
> @@ -347,6 +380,7 @@ static int thames_platform_probe(struct platform_device *pdev)
>                         continue;
>                 }
> 
> +               tdev->sched_list[core] = &tdev->cores[core].sched;
>                 tdev->num_cores++;
>                 core++;
>         }
> @@ -391,6 +425,15 @@ static void thames_platform_remove(struct platform_device *pdev)
> 
>         drm_dev_unplug(&tdev->ddev);
> 
> +       scoped_guard(mutex, &tdev->files_lock) {
> +               struct thames_file_priv *priv, *tmp;
> +
> +               list_for_each_entry_safe(priv, tmp, &tdev->files, file_node) {
> +                       list_del_init(&priv->file_node);
> +                       thames_job_close(priv);
> +               }
> +       }
> +
>         for (core = 0; core < tdev->num_cores; core++)
>                 thames_core_fini(&tdev->cores[core]);
>         tdev->num_cores = 0;
> diff --git a/drivers/accel/thames/thames_drv.h b/drivers/accel/thames/thames_drv.h
> index 7f9031b63780..2115f7eae589 100644
> --- a/drivers/accel/thames/thames_drv.h
> +++ b/drivers/accel/thames/thames_drv.h
> @@ -11,6 +11,7 @@
>  #include <linux/xarray.h>
> 
>  #include <drm/drm_mm.h>
> +#include <drm/gpu_scheduler.h>
> 
>  #include "thames_device.h"
> 
> @@ -26,6 +27,12 @@ struct thames_file_priv {
>          */
>         struct kref refcount;
> 
> +       struct list_head file_node;
> +
> +       struct drm_sched_entity sched_entity;
> +
> +       struct xarray jobs;
> +
>         struct io_pgtable_ops *pgtbl_ops[THAMES_MAX_CORES];
>         u64 page_table_base[THAMES_MAX_CORES];
>         u32 asid;
> diff --git a/drivers/accel/thames/thames_job.c b/drivers/accel/thames/thames_job.c
> new file mode 100644
> index 000000000000..6560106d47a8
> --- /dev/null
> +++ b/drivers/accel/thames/thames_job.c
> @@ -0,0 +1,869 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> +/* Copyright 2019 Collabora ltd. */
> +/* Copyright 2024-2025 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
> +/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
> +
> +#include <clocksource/arm_arch_timer.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-fence-chain.h>
> +#include <linux/iopoll.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/platform_device.h>
> +#include <linux/xarray.h>
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_syncobj.h>
> +#include <drm/thames_accel.h>
> +
> +#include "thames_core.h"
> +#include "thames_device.h"
> +#include "thames_drv.h"
> +#include "thames_gem.h"
> +#include "thames_job.h"
> +
> +#define CREATE_TRACE_POINTS
> +#include "thames_trace.h"
> +
> +static struct thames_sched_job *to_thames_sched_job(struct drm_sched_job *sched_job)
> +{
> +       return container_of(sched_job, struct thames_sched_job, base);
> +}
> +
> +static void thames_sched_job_put(struct thames_sched_job *job);
> +static void thames_job_put(struct thames_job *job);
> +
> +#define THAMES_MAX_JOBS_PER_SUBMIT 256
> +#define THAMES_MAX_SUBMIT_BOS 4096
> +#define THAMES_MAX_SUBMIT_SYNCS 64
> +
> +/*
> + * The host's timeout is longer than the device's: a Job still on the Ring when
> + * it fires is on a stalled core.
> + */
> +#define THAMES_DEVICE_TIMEOUT_MS 500
> +
> +struct thames_submit_bos {
> +       struct kref refcount;
> +       u32 read_count;
> +       u32 count;
> +       struct drm_gem_object *bos[] __counted_by(count);
> +};
> +
> +static void thames_submit_bos_free(struct kref *ref)
> +{
> +       struct thames_submit_bos *bos = container_of(ref, struct thames_submit_bos, refcount);
> +       u32 i;
> +
> +       for (i = 0; i < bos->count; i++) {
> +               if (bos->bos[i])
> +                       drm_gem_object_put(bos->bos[i]);
> +       }
> +
> +       kvfree(bos);
> +}
> +
> +static void thames_submit_bos_put(struct thames_submit_bos *bos)
> +{
> +       if (bos)
> +               kref_put(&bos->refcount, thames_submit_bos_free);
> +}
> +
> +static const char *thames_fence_get_driver_name(struct dma_fence *fence)
> +{
> +       return "thames";
> +}
> +
> +static const char *thames_fence_get_timeline_name(struct dma_fence *fence)
> +{
> +       return "thames";
> +}
> +
> +static const struct dma_fence_ops thames_fence_ops = {
> +       .get_driver_name = thames_fence_get_driver_name,
> +       .get_timeline_name = thames_fence_get_timeline_name,
> +};
> +
> +static void thames_job_fail_done_fence(struct thames_sched_job *job, int error)
> +{
> +       if (!dma_fence_was_initialized(job->done_fence) || dma_fence_is_signaled(job->done_fence))
> +               return;
> +
> +       dma_fence_set_error(job->done_fence, error);
> +       dma_fence_signal(job->done_fence);
> +}
> +
> +static int thames_job_hw_submit(struct thames_core *core, struct thames_sched_job *sched_job)
> +{
> +       struct thames_ring *ring = &core->ipc->ring;
> +       struct thames_ring_host *host;
> +       u32 tail = core->ring_tail;
> +       u32 index = tail % THAMES_RING_DEPTH;
> +       int ret;
> +
> +       if (tail - READ_ONCE(ring->head) >= THAMES_RING_DEPTH) {
> +               dev_err(core->dev, "Ring full on " THAMES_CORE_FMT "\n", THAMES_CORE_ARG(core));
> +               return -ENOSPC;
> +       }
> +
> +       sched_job->stamps[0] = arch_timer_read_counter();
> +       sched_job->ring_index = index;
> +
> +       host = &ring->entries[index].host;
> +       host->context_id = sched_job->file_priv->context_id;
> +       host->transfer_count = sched_job->job->transfers.count;
> +       host->transfer_group_count = sched_job->job->transfers.group_count;
> +       host->transfer_table_offset = sched_job->job->transfers.offset;
> +       host->seqno = sched_job->seqno;
> +       host->program_dsp_va = sched_job->job->program_dsp_va;
> +       host->params_dsp_va = sched_job->job->params_dsp_va;
> +       host->context_serial = sched_job->file_priv->context_serial;
> +       host->timeout_ms = THAMES_DEVICE_TIMEOUT_MS;
> +
> +       scoped_guard(mutex, &core->job_lock) {
> +               kref_get(&sched_job->refcount); /* Put by thames_job_complete(). */
> +               list_add_tail(&sched_job->node, &core->submitted);
> +
> +               /* Order the host half before the tail. */
> +               wmb();
> +               WRITE_ONCE(ring->tail, tail + 1);
> +               core->ring_tail = tail + 1;
> +               /* Order the tail before the doorbell. */
> +               wmb();
> +       }
> +
> +       /*
> +        * The Job is on the Ring whatever the send returns; it completes
> +        * through the Fence or the timeout.
> +        */
> +       ret = mbox_send_message(core->mbox_chan, (void *)(uintptr_t)THAMES_DOORBELL);
> +       if (ret < 0)
> +               dev_warn_ratelimited(core->dev, "Doorbell not sent: %d\n", ret);
> +
> +       return 0;
> +}
> +
> +void thames_job_complete(struct thames_core *core)
> +{
> +       struct thames_sched_job *job, *tmp;
> +       LIST_HEAD(done);
> +       u64 completed, signalled;
> +
> +       completed = READ_ONCE(core->ipc->fence.seqno);
> +       /* Read the entries after the Fence that covers them. */
> +       rmb();
> +
> +       scoped_guard(mutex, &core->job_lock) {
> +               list_for_each_entry_safe(job, tmp, &core->submitted, node) {
> +                       if (job->seqno > completed)
> +                               break;
> +                       list_move_tail(&job->node, &done);
> +               }
> +       }
> +
> +       list_for_each_entry_safe(job, tmp, &done, node) {
> +               struct thames_ring_fw *fw = &core->ipc->ring.entries[job->ring_index].fw;
> +
> +               job->stamps[1] = fw->doorbell_seen_stamp;
> +               job->stamps[2] = fw->run_start_stamp;
> +               job->stamps[3] = fw->run_end_stamp;
> +               job->stamps[4] = fw->kernel_entry_stamp;
> +               job->stamps[5] = fw->kernel_exit_stamp;
> +
> +               if (fw->fence_value == THAMES_FENCE_ERROR) {
> +                       dma_fence_set_error(job->done_fence, -EIO);
> +               }
> +
> +               list_del_init(&job->node);
> +               signalled = arch_timer_read_counter();
> +               dma_fence_signal(job->done_fence);
> +               trace_thames_job_done(core, job, signalled);
> +               thames_sched_job_put(job);
> +       }
> +}
> +
> +static int thames_acquire_object_fences(struct drm_gem_object **bos, int bo_count,
> +                                       struct drm_sched_job *job, bool is_write)
> +{
> +       int i, ret;
> +
> +       for (i = 0; i < bo_count; i++) {
> +               ret = dma_resv_reserve_fences(bos[i]->resv, 1);
> +               if (ret)
> +                       return ret;
> +
> +               ret = drm_sched_job_add_implicit_dependencies(job, bos[i], is_write);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void thames_attach_object_fences(struct drm_gem_object **bos, int bo_count,
> +                                       struct dma_fence *fence, enum dma_resv_usage usage)
> +{
> +       int i;
> +
> +       for (i = 0; i < bo_count; i++)
> +               dma_resv_add_fence(bos[i]->resv, fence, usage);
> +}
> +
> +/* Nothing here fails, so a submit call pushes every Job or none. */
> +static void thames_job_push(struct thames_sched_job *sched_job)
> +{
> +       scoped_guard(mutex, &sched_job->tdev->sched_lock) {
> +               drm_sched_job_arm(&sched_job->base);
> +
> +               sched_job->inference_done_fence = dma_fence_get(&sched_job->base.s_fence->finished);
> +
> +               kref_get(&sched_job->refcount); /* put by scheduler job completion */
> +
> +               drm_sched_entity_push_job(&sched_job->base);
> +       }
> +}
> +
> +static void thames_sched_job_cleanup(struct kref *ref)
> +{
> +       struct thames_sched_job *sched_job = container_of(ref, struct thames_sched_job, refcount);
> +
> +       if (dma_fence_was_initialized(sched_job->done_fence))
> +               dma_fence_put(sched_job->done_fence);
> +       else
> +               dma_fence_free(sched_job->done_fence);
> +       dma_fence_put(sched_job->inference_done_fence);
> +
> +       thames_submit_bos_put(sched_job->bos);
> +
> +       if (sched_job->file_priv)
> +               thames_file_priv_put(sched_job->file_priv);
> +
> +       if (sched_job->job)
> +               thames_job_put(sched_job->job);
> +
> +       kfree(sched_job);
> +}
> +
> +static void thames_sched_job_put(struct thames_sched_job *job)
> +{
> +       kref_put(&job->refcount, thames_sched_job_cleanup);
> +}
> +
> +static void thames_sched_job_free(struct drm_sched_job *sched_job)
> +{
> +       struct thames_sched_job *job = to_thames_sched_job(sched_job);
> +
> +       drm_sched_job_cleanup(sched_job);
> +
> +       thames_sched_job_put(job);
> +}
> +
> +static struct dma_fence *thames_job_run(struct drm_sched_job *sched_job)
> +{
> +       struct thames_sched_job *job = to_thames_sched_job(sched_job);
> +       struct thames_core *core = container_of(sched_job->sched, struct thames_core, sched);
> +       int ret;
> +
> +       if (unlikely(job->base.s_fence->finished.error))
> +               return NULL;
> +
> +       /* The done fence keeps the seqno of the Job's first push. */
> +       job->seqno = ++core->emit_seqno;
> +       if (!dma_fence_was_initialized(job->done_fence))
> +               dma_fence_init(job->done_fence, &thames_fence_ops, &core->fence_lock,
> +                              core->fence_context, job->seqno);
> +
> +       ret = thames_job_hw_submit(core, job);
> +       if (ret) {
> +               thames_job_fail_done_fence(job, ret);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return dma_fence_get(job->done_fence);
> +}
> +
> +/*
> + * A done fence not signalled here is a Job on a live core's Ring that may still
> + * run.
> + */
> +static void thames_job_cancel(struct drm_sched_job *sched_job)
> +{
> +       struct thames_sched_job *job = to_thames_sched_job(sched_job);
> +       struct thames_core *core = container_of(sched_job->sched, struct thames_core, sched);
> +
> +       if (!dma_fence_was_initialized(job->done_fence) || dma_fence_is_signaled(job->done_fence))
> +               return;
> +
> +       scoped_guard(mutex, &core->job_lock)
> +               list_move_tail(&job->node, &core->held);
> +
> +       thames_job_fail_done_fence(job, -ECANCELED);
> +}
> +
> +static const struct drm_sched_backend_ops thames_sched_ops = {
> +       .run_job = thames_job_run,
> +       .free_job = thames_sched_job_free,
> +       .cancel_job = thames_job_cancel,
> +};
> +
> +int thames_job_init(struct thames_core *core)
> +{
> +       /* One credit per Ring entry, so the tail never overruns the head. */
> +       struct drm_sched_init_args args = {
> +               .ops = &thames_sched_ops,
> +               .num_rqs = 1,
> +               .credit_limit = THAMES_RING_DEPTH,
> +               .timeout = MAX_SCHEDULE_TIMEOUT,
> +               .name = dev_name(core->dev),
> +               .dev = core->dev,
> +       };
> +       u32 head, tail, before;
> +       u64 fence, before_seqno, last;
> +       int ret;
> +
> +       spin_lock_init(&core->fence_lock);
> +       mutex_init(&core->job_lock);
> +
> +       INIT_LIST_HEAD(&core->submitted);
> +       INIT_LIST_HEAD(&core->held);
> +
> +       /*
> +        * Both indices run free, so only a tail not at the head is wrong: the
> +        * previous instance's entries are still pending.  The Fence may trail
> +        * the head by one entry, the firmware moving the head first.
> +        */
> +       head = READ_ONCE(core->ipc->ring.head);
> +       tail = READ_ONCE(core->ipc->ring.tail);
> +       before = (head - 1) % THAMES_RING_DEPTH;
> +
> +       if (tail != head) {
> +               dev_err(core->dev, "Ring on " THAMES_CORE_FMT
> +                       " has %u pending entries (tail %u, head %u); not attaching\n",
> +                       THAMES_CORE_ARG(core), tail - head, tail, head);
> +               return -EBUSY;
> +       }
> +
> +       /* Read the Fence and the entry after the head and the tail. */
> +       rmb();
> +       fence = READ_ONCE(core->ipc->fence.seqno);
> +       before_seqno = core->ipc->ring.entries[before].host.seqno;
> +       last = max(fence, before_seqno);
> +
> +       core->ring_tail = head;
> +       core->emit_seqno = last;
> +
> +       core->fence_context = dma_fence_context_alloc(1);
> +
> +       ret = drm_sched_init(&core->sched, &args);
> +       if (ret) {
> +               dev_err(core->dev, "Failed to create scheduler: %d.", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * These Jobs' core may still run their Kernels: the Jobs, Contexts and buffers
> + * stay allocated.
> + */
> +void thames_job_fini(struct thames_core *core)
> +{
> +       struct thames_sched_job *job;
> +       u64 first = U64_MAX, last = 0;
> +       size_t kept;
> +
> +       drm_sched_fini(&core->sched);
> +
> +       guard(mutex)(&core->job_lock);
> +
> +       kept = list_count_nodes(&core->held);
> +       if (!kept)
> +               return;
> +
> +       list_for_each_entry(job, &core->held, node) {
> +               first = min(first, job->seqno);
> +               last = max(last, job->seqno);
> +       }
> +
> +       drm_dev_get(&core->tdev->ddev);
> +       dev_warn(core->dev, THAMES_CORE_FMT
> +                " may still run %zu Jobs (seqno %llu to %llu); keeping them and their buffers until reboot\n",
> +                THAMES_CORE_ARG(core), kept, first, last);
> +}
> +
> +/*
> + * Above the device's timeout, so the firmware ends a runaway Kernel within the
> + * wait.
> + */
> +#define THAMES_SUSPEND_TIMEOUT_MS (THAMES_DEVICE_TIMEOUT_MS + 100)
> +
> +int thames_job_suspend(struct thames_core *core)
> +{
> +       struct drm_gpu_scheduler *sched = &core->sched;
> +       unsigned int wait_ms;
> +       size_t pending;
> +       bool idle;
> +       int err;
> +
> +       drm_sched_wqueue_stop(sched);
> +       core->timeout_left = drm_sched_suspend_timeout(sched);
> +       cancel_delayed_work_sync(&sched->work_tdr);
> +       drm_sched_wqueue_stop(sched);
> +
> +       scoped_guard(mutex, &core->job_lock)
> +               pending = list_count_nodes(&core->submitted);
> +       wait_ms = max_t(unsigned int, pending, 1) * THAMES_SUSPEND_TIMEOUT_MS;
> +
> +       err = read_poll_timeout(thames_core_idles, idle, idle, USEC_PER_MSEC,
> +                               wait_ms * USEC_PER_MSEC, false, core);
> +
> +       if (!err) {
> +               thames_job_complete(core);
> +               scoped_guard(mutex, &core->job_lock) {
> +                       if (!list_empty(&core->submitted))
> +                               err = -EBUSY;
> +               }
> +       }
> +
> +       if (err) {
> +               dev_err(core->dev, THAMES_CORE_FMT
> +                       " is not idle with its Jobs completed after %u ms; refusing the suspend\n",
> +                       THAMES_CORE_ARG(core), wait_ms);
> +               thames_job_resume(core);
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
> +void thames_job_resume(struct thames_core *core)
> +{
> +       drm_sched_resume_timeout(&core->sched, core->timeout_left);
> +       drm_sched_wqueue_start(&core->sched);
> +}
> +
> +int thames_job_open(struct thames_file_priv *thames_priv)
> +{
> +       struct thames_device *tdev = thames_priv->tdev;
> +       int ret;
> +
> +       ret = drm_sched_entity_init(&thames_priv->sched_entity, 0, tdev->sched_list,
> +                                   tdev->num_cores, NULL);
> +       if (WARN_ON(ret))
> +               return ret;
> +
> +       xa_init_flags(&thames_priv->jobs, XA_FLAGS_ALLOC1);
> +
> +       return 0;
> +}
> +
> +void thames_job_close(struct thames_file_priv *thames_priv)
> +{
> +       struct thames_job *job;
> +       unsigned long handle;
> +
> +       drm_sched_entity_destroy(&thames_priv->sched_entity);
> +
> +       xa_for_each(&thames_priv->jobs, handle, job)
> +               thames_job_put(job);
> +       xa_destroy(&thames_priv->jobs);
> +}
> +
> +static void thames_job_free(struct kref *ref)
> +{
> +       struct thames_job *job = container_of(ref, struct thames_job, refcount);
> +
> +       if (job->program)
> +               drm_gem_object_put(job->program);
> +       if (job->params)
> +               drm_gem_object_put(job->params);
> +
> +       thames_transfers_free(job->tdev, &job->transfers);
> +       mutex_destroy(&job->lock);
> +       kfree(job);
> +}
> +
> +static void thames_job_put(struct thames_job *job)
> +{
> +       kref_put(&job->refcount, thames_job_free);
> +}
> +
> +int thames_ioctl_job_create(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +       struct drm_thames_job_create *args = data;
> +       struct thames_file_priv *file_priv = file->driver_priv;
> +       struct thames_device *tdev = to_thames_device(dev);
> +       struct thames_job *job;
> +       u32 handle;
> +       int ret;
> +
> +       if (args->flags || args->pad)
> +               return -EINVAL;
> +
> +       if (args->type != DRM_THAMES_JOB_DISPATCH)
> +               return -EINVAL;
> +
> +       if (!args->program || !args->params)
> +               return -EINVAL;
> +
> +       job = kzalloc_obj(*job, GFP_KERNEL);
> +       if (!job)
> +               return -ENOMEM;
> +
> +       kref_init(&job->refcount);
> +       mutex_init(&job->lock);
> +       job->tdev = tdev;
> +
> +       job->program = drm_gem_object_lookup(file, args->program);
> +       if (!job->program) {
> +               ret = -ENOENT;
> +               goto err_put;
> +       }
> +
> +       if (!(to_thames_bo(job->program)->flags & DRM_THAMES_BO_EXECUTABLE)) {
> +               ret = -EINVAL;
> +               goto err_put;
> +       }
> +
> +       job->program_dsp_va = thames_bo_dsp_va(to_thames_bo(job->program), file_priv);
> +       if (!job->program_dsp_va) {
> +               ret = -EINVAL;
> +               goto err_put;
> +       }
> +
> +       job->params = drm_gem_object_lookup(file, args->params);
> +       if (!job->params) {
> +               ret = -ENOENT;
> +               goto err_put;
> +       }
> +
> +       job->params_dsp_va = thames_bo_dsp_va(to_thames_bo(job->params), file_priv);
> +       if (!job->params_dsp_va) {
> +               ret = -EINVAL;
> +               goto err_put;
> +       }
> +
> +       ret = thames_transfers_build(file, &args->transfers, &job->transfers);
> +       if (ret)
> +               goto err_put;
> +
> +       ret = xa_alloc(&file_priv->jobs, &handle, job, xa_limit_32b, GFP_KERNEL);
> +       if (ret)
> +               goto err_put;
> +
> +       job->handle = handle;
> +       args->handle = handle;
> +
> +       return 0;
> +
> +err_put:
> +       thames_job_put(job);
> +       return ret;
> +}
> +
> +static struct thames_sched_job *thames_sched_job_new(struct drm_file *file, u32 handle,
> +                                                    struct thames_submit_bos *bos)
> +{
> +       struct thames_file_priv *file_priv = file->driver_priv;
> +       struct thames_job *job;
> +       struct thames_sched_job *sched_job;
> +       int ret;
> +
> +       xa_lock(&file_priv->jobs);
> +       job = xa_load(&file_priv->jobs, handle);
> +       if (job)
> +               kref_get(&job->refcount);
> +       xa_unlock(&file_priv->jobs);
> +
> +       if (!job)
> +               return ERR_PTR(-ENOENT);
> +
> +       sched_job = kzalloc_obj(*sched_job, GFP_KERNEL);
> +       if (!sched_job) {
> +               thames_job_put(job);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       kref_init(&sched_job->refcount);
> +       INIT_LIST_HEAD(&sched_job->node);
> +       sched_job->tdev = job->tdev;
> +       sched_job->job = job; /* The lookup's reference. */
> +       /* Put by the completion path once it has counted the Job for the ban. */
> +       kref_get(&file_priv->refcount);
> +       sched_job->file_priv = file_priv;
> +       kref_get(&bos->refcount);
> +       sched_job->bos = bos;
> +
> +       sched_job->done_fence = kzalloc_obj(*sched_job->done_fence);
> +       if (!sched_job->done_fence) {
> +               thames_sched_job_put(sched_job);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       ret = drm_sched_job_init(&sched_job->base, &file_priv->sched_entity, 1, NULL,
> +                                file->client_id);
> +       if (ret) {
> +               thames_sched_job_put(sched_job);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return sched_job;
> +}
> +
> +static int thames_submit_bos_lookup(struct drm_file *file,
> +                                   const struct drm_thames_job_submit *args,
> +                                   struct thames_submit_bos **out)
> +{
> +       const struct drm_thames_obj_array *lists[2] = { &args->read_handles,
> +                                                       &args->write_handles };
> +       struct thames_submit_bos *bos;
> +       u32 total = 0, n = 0, l, i;
> +
> +       for (l = 0; l < ARRAY_SIZE(lists); l++) {
> +               if (lists[l]->count > THAMES_MAX_SUBMIT_BOS - total)
> +                       return -EINVAL;
> +               total += lists[l]->count;
> +       }
> +
> +       bos = kvzalloc(struct_size(bos, bos, total), GFP_KERNEL);
> +       if (!bos)
> +               return -ENOMEM;
> +
> +       kref_init(&bos->refcount);
> +       bos->count = total;
> +       bos->read_count = args->read_handles.count;
> +
> +       for (l = 0; l < ARRAY_SIZE(lists); l++) {
> +               u32 *handles;
> +
> +               if (!lists[l]->count)
> +                       continue;
> +
> +               handles = thames_get_uobj_array(lists[l], sizeof(*handles), sizeof(*handles));
> +               if (IS_ERR(handles)) {
> +                       thames_submit_bos_put(bos);
> +                       return PTR_ERR(handles);
> +               }
> +
> +               for (i = 0; i < lists[l]->count; i++, n++) {
> +                       bos->bos[n] = drm_gem_object_lookup(file, handles[i]);
> +                       if (!bos->bos[n]) {
> +                               kvfree(handles);
> +                               thames_submit_bos_put(bos);
> +                               return -ENOENT;
> +                       }
> +               }
> +
> +               kvfree(handles);
> +       }
> +
> +       *out = bos;
> +       return 0;
> +}
> +
> +/*
> + * Allocated before the first push, so signalling cannot fail once the Jobs run.
> + */
> +struct thames_submit_syncs {
> +       u32 count;
> +       struct drm_thames_sync_op *ops;
> +       struct thames_sync_signal {
> +               struct drm_syncobj *syncobj;
> +               struct dma_fence_chain *chain;
> +       } *signals;
> +};
> +
> +static int thames_sync_op_check(const struct drm_thames_sync_op *op)
> +{
> +       if (op->flags != (DRM_THAMES_SYNC_OP_HANDLE_TYPE_TIMELINE_SYNCOBJ |
> +                         DRM_THAMES_SYNC_OP_SIGNAL))
> +               return -EINVAL;
> +
> +       return op->timeline_value ? 0 : -EINVAL;
> +}
> +
> +static void thames_submit_syncs_free(struct thames_submit_syncs *syncs)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < syncs->count; i++) {
> +               if (syncs->signals[i].syncobj)
> +                       drm_syncobj_put(syncs->signals[i].syncobj);
> +               dma_fence_chain_free(syncs->signals[i].chain);
> +       }
> +
> +       kvfree(syncs->signals);
> +       kvfree(syncs->ops);
> +}
> +
> +static int thames_submit_syncs_get(struct drm_file *file, const struct drm_thames_obj_array *in,
> +                                  struct thames_submit_syncs *syncs)
> +{
> +       struct drm_thames_sync_op *ops;
> +       u32 i;
> +       int ret;
> +
> +       if (!in->count)
> +               return 0;
> +
> +       if (in->count > THAMES_MAX_SUBMIT_SYNCS)
> +               return -EINVAL;
> +
> +       ops = thames_get_uobj_array(in, offsetofend(struct drm_thames_sync_op, timeline_value),
> +                                   sizeof(*ops));
> +       if (IS_ERR(ops))
> +               return PTR_ERR(ops);
> +       syncs->ops = ops;
> +
> +       syncs->signals = kvcalloc(in->count, sizeof(*syncs->signals), GFP_KERNEL);
> +       if (!syncs->signals)
> +               return -ENOMEM;
> +       syncs->count = in->count;
> +
> +       for (i = 0; i < syncs->count; i++) {
> +               struct thames_sync_signal *signal = &syncs->signals[i];
> +
> +               ret = thames_sync_op_check(&ops[i]);
> +               if (ret)
> +                       return ret;
> +
> +               signal->syncobj = drm_syncobj_find(file, ops[i].handle);
> +               if (!signal->syncobj)
> +                       return -ENOENT;
> +
> +               signal->chain = dma_fence_chain_alloc();
> +               if (!signal->chain)
> +                       return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void thames_submit_syncs_signal(struct thames_submit_syncs *syncs, struct dma_fence *fence)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < syncs->count; i++) {
> +               struct thames_sync_signal *signal = &syncs->signals[i];
> +
> +               drm_syncobj_add_point(signal->syncobj, signal->chain, fence,
> +                                     syncs->ops[i].timeline_value);
> +               signal->chain = NULL;
> +       }
> +}
> +
> +int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +       struct drm_thames_job_submit *args = data;
> +       struct thames_submit_syncs syncs = {};
> +       struct thames_submit_bos *bos = NULL;
> +       struct ww_acquire_ctx acquire_ctx;
> +       struct thames_sched_job **subs = NULL;
> +       struct dma_fence *last;
> +       u32 count = args->jobs.count;
> +       u32 pushed = 0;
> +       u32 *handles;
> +       unsigned int i;
> +       int ret = 0;
> +
> +       if (args->flags || args->pad)
> +               return -EINVAL;
> +
> +       if (!count || count > THAMES_MAX_JOBS_PER_SUBMIT)
> +               return -EINVAL;
> +
> +       handles = thames_get_uobj_array(&args->jobs, sizeof(u32), sizeof(u32));
> +       if (IS_ERR(handles))
> +               return PTR_ERR(handles);
> +
> +       ret = thames_submit_syncs_get(file, &args->syncs, &syncs);
> +       if (ret)
> +               goto out_syncs;
> +
> +       ret = thames_submit_bos_lookup(file, args, &bos);
> +       if (ret)
> +               goto out_syncs;
> +
> +       subs = kvcalloc(count, sizeof(*subs), GFP_KERNEL);
> +       if (!subs) {
> +               ret = -ENOMEM;
> +               goto out_put;
> +       }
> +
> +       for (i = 0; i < count; i++) {
> +               subs[i] = thames_sched_job_new(file, handles[i], bos);
> +               if (IS_ERR(subs[i])) {
> +                       ret = PTR_ERR(subs[i]);
> +                       subs[i] = NULL;
> +                       goto out_subs;
> +               }
> +       }
> +
> +       ret = drm_gem_lock_reservations(bos->bos, bos->count, &acquire_ctx);
> +       if (ret)
> +               goto out_subs;
> +
> +       /*
> +        * Only the first Job waits: the entity runs the call's Jobs in order.
> +        */
> +       ret = thames_acquire_object_fences(bos->bos, bos->read_count, &subs[0]->base, false);
> +       if (ret)
> +               goto out_unlock;
> +
> +       ret = thames_acquire_object_fences(&bos->bos[bos->read_count], bos->count - bos->read_count,
> +                                          &subs[0]->base, true);
> +       if (ret)
> +               goto out_unlock;
> +
> +       for (pushed = 0; pushed < count; pushed++)
> +               thames_job_push(subs[pushed]);
> +
> +       last = subs[count - 1]->inference_done_fence;
> +       thames_attach_object_fences(bos->bos, bos->read_count, last, DMA_RESV_USAGE_READ);
> +       thames_attach_object_fences(&bos->bos[bos->read_count], bos->count - bos->read_count, last,
> +                                   DMA_RESV_USAGE_WRITE);
> +       thames_submit_syncs_signal(&syncs, last);
> +
> +out_unlock:
> +       drm_gem_unlock_reservations(bos->bos, bos->count, &acquire_ctx);
> +out_subs:
> +       for (i = 0; i < count; i++) {
> +               if (!subs[i])
> +                       continue;
> +               if (i >= pushed)
> +                       drm_sched_job_cleanup(&subs[i]->base);
> +               /* The creation reference; the scheduler holds its own. */
> +               thames_sched_job_put(subs[i]);
> +       }
> +       kvfree(subs);
> +out_put:
> +       thames_submit_bos_put(bos);
> +out_syncs:
> +       thames_submit_syncs_free(&syncs);
> +       kvfree(handles);
> +       return ret;
> +}
> +
> +int thames_ioctl_job_destroy(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +       struct drm_thames_job_destroy *args = data;
> +       struct thames_file_priv *file_priv = file->driver_priv;
> +       struct thames_job *job;
> +
> +       if (args->pad)
> +               return -EINVAL;
> +
> +       job = xa_erase(&file_priv->jobs, args->handle);
> +       if (!job)
> +               return -ENOENT;
> +
> +       /* A submission still running holds its own reference. */
> +       thames_job_put(job);
> +
> +       return 0;
> +}
> +
> diff --git a/drivers/accel/thames/thames_job.h b/drivers/accel/thames/thames_job.h
> new file mode 100644
> index 000000000000..a851febe8f98
> --- /dev/null
> +++ b/drivers/accel/thames/thames_job.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright 2024-2025 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
> +/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
> +
> +#ifndef __THAMES_JOB_H__
> +#define __THAMES_JOB_H__
> +
> +#include <drm/drm_drv.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/thames_accel.h>
> +
> +#include "thames_core.h"
> +#include "thames_drv.h"
> +#include "thames_transfers.h"
> +
> +struct thames_submit_bos;
> +
> +struct thames_sched_job {
> +       struct drm_sched_job base;
> +
> +       struct thames_device *tdev;
> +       struct thames_file_priv *file_priv;
> +
> +       struct dma_fence *inference_done_fence;
> +       struct dma_fence *done_fence;
> +
> +       /* @seqno moves at every push; the done fence keeps the first push's. */
> +       u64 seqno;
> +       u32 ring_index;
> +       u64 stamps[6];
> +       struct list_head node;
> +
> +       struct thames_job *job;
> +
> +       struct thames_submit_bos *bos;
> +
> +       struct kref refcount;
> +};
> +
> +struct thames_job {
> +       struct kref refcount;
> +       struct thames_device *tdev;
> +       u32 handle;
> +
> +       struct drm_gem_object *program;
> +       struct drm_gem_object *params;
> +
> +       /*
> +        * Taken at create: after an unbind the Job faults in its Context rather
> +        * than read a binding that is gone.
> +        */
> +       u64 program_dsp_va;
> +       u64 params_dsp_va;
> +
> +       struct thames_transfer_table transfers;
> +
> +       struct mutex lock;
> +};
> +
> +int thames_ioctl_job_create(struct drm_device *dev, void *data, struct drm_file *file);
> +int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file *file);
> +int thames_ioctl_job_destroy(struct drm_device *dev, void *data, struct drm_file *file);
> +
> +void thames_job_complete(struct thames_core *core);
> +
> +int thames_job_init(struct thames_core *core);
> +int thames_job_suspend(struct thames_core *core);
> +void thames_job_resume(struct thames_core *core);
> +void thames_job_fini(struct thames_core *core);
> +int thames_job_open(struct thames_file_priv *thames_priv);
> +void thames_job_close(struct thames_file_priv *thames_priv);
> +
> +#endif
> diff --git a/drivers/accel/thames/thames_trace.h b/drivers/accel/thames/thames_trace.h
> new file mode 100644
> index 000000000000..3d1e59708869
> --- /dev/null
> +++ b/drivers/accel/thames/thames_trace.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM thames
> +
> +#if !defined(__THAMES_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
> +#define __THAMES_TRACE_H__
> +
> +#include <linux/math64.h>
> +#include <linux/time64.h>
> +#include <linux/tracepoint.h>
> +#include <linux/types.h>
> +
> +#include "thames_core.h"
> +#include "thames_device.h"
> +#include "thames_drv.h"
> +#include "thames_job.h"
> +
> +/* Every stamp is the SoC's system counter in microseconds, so any two subtract. */
> +TRACE_EVENT(thames_job_done,
> +           TP_PROTO(const struct thames_core *core, const struct thames_sched_job *job,
> +                    u64 signalled),
> +
> +           TP_ARGS(core, job, signalled),
> +
> +           TP_STRUCT__entry(__string(dev_name, dev_name(core->dev))
> +                            __field(u32, core)
> +                            __field(u32, context)
> +                            __field(u64, seqno)
> +                            __field(int, error)
> +                            __field(u64, submit_us)
> +                            __field(u64, doorbell_seen_us)
> +                            __field(u64, run_start_us)
> +                            __field(u64, kernel_entry_us)
> +                            __field(u64, kernel_exit_us)
> +                            __field(u64, run_end_us)
> +                            __field(u64, signalled_us)),
> +
> +           TP_fast_assign(u32 hz = core->tdev->caps.timestamp_hz;
> +
> +                          __assign_str(dev_name);
> +                          __entry->core = core->index;
> +                          __entry->context = job->file_priv->context_id;
> +                          __entry->seqno = job->seqno;
> +                          __entry->error = job->done_fence->error;
> +                          __entry->submit_us =
> +                               mul_u64_u32_div(job->stamps[0], USEC_PER_SEC, hz);
> +                          __entry->doorbell_seen_us =
> +                               mul_u64_u32_div(job->stamps[1], USEC_PER_SEC, hz);
> +                          __entry->run_start_us =
> +                               mul_u64_u32_div(job->stamps[2], USEC_PER_SEC, hz);
> +                          __entry->run_end_us =
> +                               mul_u64_u32_div(job->stamps[3], USEC_PER_SEC, hz);
> +                          __entry->kernel_entry_us =
> +                               mul_u64_u32_div(job->stamps[4], USEC_PER_SEC, hz);
> +                          __entry->kernel_exit_us =
> +                               mul_u64_u32_div(job->stamps[5], USEC_PER_SEC, hz);
> +                          __entry->signalled_us =
> +                               mul_u64_u32_div(signalled, USEC_PER_SEC, hz);),
> +
> +           TP_printk("%s: core=%u context=%u seqno=%llu error=%d submit_us=%llu doorbell_seen_us=%llu run_start_us=%llu kernel_entry_us=%llu kernel_exit_us=%llu run_end_us=%llu signalled_us=%llu",
> +                     __get_str(dev_name), __entry->core, __entry->context,
> +                     __entry->seqno, __entry->error, __entry->submit_us,
> +                     __entry->doorbell_seen_us, __entry->run_start_us,
> +                     __entry->kernel_entry_us, __entry->kernel_exit_us,
> +                     __entry->run_end_us, __entry->signalled_us)
> +);
> +
> +#endif /* __THAMES_TRACE_H__ */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE thames_trace
> +
> +#include <trace/define_trace.h>
> diff --git a/include/uapi/drm/thames_accel.h b/include/uapi/drm/thames_accel.h
> index 5671cffaf8f9..bd2b4271b896 100644
> --- a/include/uapi/drm/thames_accel.h
> +++ b/include/uapi/drm/thames_accel.h
> @@ -57,6 +57,15 @@ enum drm_thames_ioctl_id {
>         /** @DRM_THAMES_DEV_QUERY: Query the device's capabilities. */
>         DRM_THAMES_DEV_QUERY,
> 
> +       /** @DRM_THAMES_JOB_CREATE: Validate a Dispatch once into a Job. */
> +       DRM_THAMES_JOB_CREATE,
> +
> +       /** @DRM_THAMES_JOB_SUBMIT: Run created Jobs once, in order. */
> +       DRM_THAMES_JOB_SUBMIT,
> +
> +       /** @DRM_THAMES_JOB_DESTROY: Release a Job and the buffers it holds. */
> +       DRM_THAMES_JOB_DESTROY,
> +
>         /**
>          * @DRM_THAMES_BO_BIND: Bind buffers into the file's Context at the
>          * addresses the client chooses, or unbind them.
> @@ -244,6 +253,21 @@ enum drm_thames_dev_query_type {
> 
>  };
> 
> +/**
> + * enum drm_thames_job_type - What a Job is
> + *
> + * A Job is one Dispatch, and a submission is an ordered array of Jobs.  A Job
> + * whose transfers are not K3 DMA records would be a new type, not a new
> + * operation, and so are the copies, fills, timestamps and the list-carrying
> + * command buffer a Vulkan compute driver will add.  The query grows a field
> + * naming the types beyond the Dispatch when the first one comes; an absent type
> + * is refused at Job creation.
> + */
> +enum drm_thames_job_type {
> +       /** @DRM_THAMES_JOB_DISPATCH: Run a Kernel with its transfers. */
> +       DRM_THAMES_JOB_DISPATCH = 0,
> +};
> +
>  /**
>   * enum drm_thames_hardware_id - &drm_thames_caps.hardware_id
>   */
> @@ -255,8 +279,9 @@ enum drm_thames_hardware_id {
>  /**
>   * struct drm_thames_caps - The capability query
>   *
> - * Each window sits at one address whatever core runs the Job and reaches that
> - * core's own memory.
> + * The submit's limits are stated on &struct drm_thames_job_submit.  Each window
> + * sits at one address whatever core runs the Job and reaches that core's own
> + * memory.
>   */
>  struct drm_thames_caps {
>         /** @l2_size: Size in bytes of each core's L2 SRAM. */
> @@ -328,6 +353,35 @@ struct drm_thames_caps {
>         __u64 dru_capabilities;
>  };
> 
> +/**
> + * enum drm_thames_fault_kind - The kind of a Job's fault
> + *
> + * The kind is what the firmware knows without decoding a register: what stopped
> + * the Job and whose mode it stopped in.
> + */
> +enum drm_thames_fault_kind {
> +       /**
> +        * @DRM_THAMES_FAULT_KERNEL: A Kernel took an exception in user mode.
> +        * The Context continues; the registers say why.
> +        */
> +       DRM_THAMES_FAULT_KERNEL = 1,
> +
> +       /**
> +        * @DRM_THAMES_FAULT_FIRMWARE: The firmware took an exception in
> +        * supervisor mode while running this Job.  The core was reset.
> +        */
> +       DRM_THAMES_FAULT_FIRMWARE,
> +
> +       /**
> +        * @DRM_THAMES_FAULT_TIMEOUT: The device's Job timeout fired: the Kernel
> +        * ran longer than the driver lets a Kernel run and the device ended it,
> +        * or the Kernel returned with transfers still running and they did not
> +        * drain. The Context continues; NRP and NTSR say where the Kernel was,
> +        * and are 0 for transfers that did not drain.
> +        */
> +       DRM_THAMES_FAULT_TIMEOUT,
> +};
> +
>  /**
>   * struct drm_thames_dev_query - Arguments passed to DRM_IOCTL_THAMES_DEV_QUERY
>   */
> @@ -353,9 +407,9 @@ struct drm_thames_dev_query {
>   * order: the first group starts at the first transfer, each later group at a
>   * transfer carrying this flag.  The firmware submits the first group before it
>   * enters the Kernel, and each later group, whole, when the Kernel asks for it
> - * with system call 2.  No group may hold more transfers on one channel than
> - * &drm_thames_caps.dru_queue_depth.  Never on the first transfer.  A Job
> - * without the flag is one group.
> + * with system call 2 (see &struct drm_thames_job_create).  No group may hold
> + * more transfers on one channel than &drm_thames_caps.dru_queue_depth.  Never
> + * on the first transfer.  A Job without the flag is one group.
>   */
>  #define DRM_THAMES_TRANSFER_GROUP      (1 << 0)
> 
> @@ -393,7 +447,9 @@ struct drm_thames_dev_query {
>   * auxiliary aperture, at &drm_thames_caps.l2_main_dsp_va and l2_aux, which the
>   * kernel translates to the physical aperture of the core the Job runs on.  The
>   * Job holds a reference on each buffer a transfer resolves to until it is
> - * destroyed and its last submission has completed.
> + * destroyed and its last submission has completed.  No list names these
> + * buffers: the read and write lists of &drm_thames_job_submit are for
> + * synchronisation alone.
>   */
>  struct drm_thames_transfer {
>         /**
> @@ -409,6 +465,191 @@ struct drm_thames_transfer {
>         __u32 words[16];
>  };
> 
> +/**
> + * struct drm_thames_job_create - Arguments passed to DRM_IOCTL_THAMES_JOB_CREATE
> + *
> + * Once per Dispatch: the transfers are copied, each checked and translated, a
> + * reference taken on the program, the params and every buffer a transfer
> + * resolves to so the translation holds for the Job's life, and a handle
> + * returned.  The buffers the Kernel reads and writes are named at each
> + * submit, in &drm_thames_job_submit.
> + *
> + * The firmware enters the Kernel at the program's start as a C function
> + * taking one argument, the params' address, and returning a status word:
> + *
> + *     int kernel(void *params);
> + *
> + * That is the whole of what the kernel and the firmware know.  The Kernel finds
> + * everything else, its inputs, outputs, constants, grid and status buffer,
> + * through params, whose layout is private to the userspace driver that emitted
> + * the Kernel.  The program must have been created DRM_THAMES_BO_EXECUTABLE.
> + * The program and the params must be bound in the Context.
> + * The Job keeps the two addresses they are bound at when it is created, and
> + * every submission runs the Kernel at them.
> + *
> + * A Kernel asks for its Job's next transfer group with system call 2 (the
> + * SYSCALL instruction with 2, no argument).  The call returns to the
> + * instruction after it with every register kept but A0-A3 and RP.  The firmware
> + * submits the group only if the Job has one left and every channel the group
> + * uses has no transfer queued or running; otherwise it fails the Job, writing
> + * none of the group's transfers.  A Kernel waits for the tile event of its
> + * channels' DRU records with system call 3.
> + */
> +struct drm_thames_job_create {
> +       /** @type: One of &enum drm_thames_job_type. */
> +       __u32 type;
> +
> +       /** @flags: MBZ. */
> +       __u32 flags;
> +
> +       /** @program: Handle of the buffer holding the Kernel. */
> +       __u32 program;
> +
> +       /** @params: Handle of the params buffer. */
> +       __u32 params;
> +
> +       /**
> +        * @transfers: Array of &struct drm_thames_transfer, the DRU records
> +        * the compiler scheduled for this Kernel; may be empty.
> +        */
> +       struct drm_thames_obj_array transfers;
> +
> +       /** @handle: Returned handle of the Job.  Job handles are nonzero. */
> +       __u32 handle;
> +
> +       /** @pad: MBZ. */
> +       __u32 pad;
> +};
> +
> +/**
> + * DOC: Sync operation flags
> + *
> + * The low byte of &drm_thames_sync_op.flags is the handle type, bit 31 the
> + * direction; every other bit is MBZ.
> + *
> + * The one op accepted is a timeline sync object signalled,
> + * %DRM_THAMES_SYNC_OP_HANDLE_TYPE_TIMELINE_SYNCOBJ |
> + * %DRM_THAMES_SYNC_OP_SIGNAL.  Handle type 0 and a clear bit 31, a binary sync
> + * object and a wait, are left for the client that will use them.
> + *
> + * - %DRM_THAMES_SYNC_OP_HANDLE_TYPE_MASK: The bits of the handle type.
> + * - %DRM_THAMES_SYNC_OP_HANDLE_TYPE_TIMELINE_SYNCOBJ: A timeline sync
> + *   object, at the point &drm_thames_sync_op.timeline_value.
> + * - %DRM_THAMES_SYNC_OP_SIGNAL: The call's last Job's finished fence is
> + *   added to the timeline at the point.
> + */
> +#define DRM_THAMES_SYNC_OP_HANDLE_TYPE_MASK            0xff
> +#define DRM_THAMES_SYNC_OP_HANDLE_TYPE_TIMELINE_SYNCOBJ        1
> +#define DRM_THAMES_SYNC_OP_SIGNAL                      (1u << 31)
> +
> +/**
> + * struct drm_thames_sync_op - One signal of a submit call
> + */
> +struct drm_thames_sync_op {
> +       /**
> +        * @flags: %DRM_THAMES_SYNC_OP_HANDLE_TYPE_TIMELINE_SYNCOBJ |
> +        * %DRM_THAMES_SYNC_OP_SIGNAL.
> +        */
> +       __u32 flags;
> +
> +       /** @handle: A timeline sync object of the client. */
> +       __u32 handle;
> +
> +       /**
> +        * @timeline_value: The point on the timeline sync object, nonzero.
> +        */
> +       __u64 timeline_value;
> +};
> +
> +/**
> + * struct drm_thames_job_submit - Arguments passed to DRM_IOCTL_THAMES_JOB_SUBMIT
> + *
> + * A submission is an ordered array of Jobs, one Ring entry each, so a sequence
> + * of Dispatches is one call.  Per run the kernel re-checks only the Context's
> + * current state, waits on the implicit fences of the buffers the call names and
> + * pushes the Ring entries.  A submission of a Job while an earlier
> + * submission of the same Job is in flight waits for it, which the Ring's order
> + * gives on its own.  One Ring completes its Jobs in submission order; there is
> + * no order between the two cores' Rings, but the Jobs of one call run in the
> + * order named.
> + *
> + * The buffers the call's Jobs read and write are named here, one pair of lists
> + * per call.  They are for synchronisation alone: the first Job waits on the
> + * fences already on them, and the last Job's fence is set on them once the Jobs
> + * are pushed, for read usage on @read_handles and write usage on
> + * @write_handles, so DRM_IOCTL_THAMES_BO_PREP on a written buffer waits for the
> + * call's Jobs.  No flag turns either side off.  The call holds a reference on
> + * each buffer named until its last Job completes.  A buffer may be named once
> + * in the two lists together.
> + *
> + * The sync objects the call signals are named in @syncs.  Every op receives the
> + * call's last Job's finished fence, the same fence the listed buffers get; the
> + * call waits on no sync object.  The call is all or nothing: every Job handle
> + * is looked up and every sync op resolved before the first Job is pushed, so a
> + * call that fails has submitted nothing and signals nothing.  An opt-out of the
> + * implicit synchronisation would be a bit of @flags, appended under a minor
> + * bump.
> + *
> + * Every Job the call submits has its fault record cleared; a refused call
> + * clears none.
> + *
> + * A Job of the call that fails does not stop the ones after it: each later Job
> + * runs, and completes or fails on its own merits.  Only a Context banned after
> + * its faults has its Jobs not yet run cancelled, their fences signalled with
> + * -ECANCELED, and its later submit calls refused with -ECANCELED.
> + */
> +struct drm_thames_job_submit {
> +       /** @flags: MBZ. */
> +       __u32 flags;
> +
> +       /** @pad: MBZ. */
> +       __u32 pad;
> +
> +       /**
> +        * @jobs: Array of __u32 Job handles, run in order.
> +        *
> +        * At least 1 and at most 256 Jobs.
> +        */
> +       struct drm_thames_obj_array jobs;
> +
> +       /**
> +        * @read_handles: Array of __u32 handles of the buffers the Jobs read;
> +        * may be empty.
> +        *
> +        * At most 4096 handles in @read_handles and @write_handles together.
> +        */
> +       struct drm_thames_obj_array read_handles;
> +
> +       /**
> +        * @write_handles: Array of __u32 handles of the buffers the Jobs write;
> +        * may be empty.  Counted with @read_handles.
> +        */
> +       struct drm_thames_obj_array write_handles;
> +
> +       /**
> +        * @syncs: Array of &struct drm_thames_sync_op; may be empty.
> +        *
> +        * At most 64 ops.
> +        */
> +       struct drm_thames_obj_array syncs;
> +};
> +
> +/**
> + * struct drm_thames_job_destroy - Arguments passed to DRM_IOCTL_THAMES_JOB_DESTROY
> + *
> + * Releases the handle and returns at once; it does not wait for the Job's
> + * submissions.  A submission still in flight keeps the Job, its validated copy
> + * and the references on its buffers until it completes, and its fence signals
> + * as it would have.  The handle names nothing afterwards.
> + */
> +struct drm_thames_job_destroy {
> +       /** @handle: The Job. */
> +       __u32 handle;
> +
> +       /** @pad: MBZ. */
> +       __u32 pad;
> +};
> +
>  /**
>   * DRM_IOCTL_THAMES() - Build a thames IOCTL number
>   * @__access: Access type. Must be R, W or RW.
> @@ -431,6 +672,12 @@ enum {
>                 DRM_IOCTL_THAMES(WR, BO_MMAP_OFFSET, bo_mmap_offset),
>         DRM_IOCTL_THAMES_DEV_QUERY =
>                 DRM_IOCTL_THAMES(WR, DEV_QUERY, dev_query),
> +       DRM_IOCTL_THAMES_JOB_CREATE =
> +               DRM_IOCTL_THAMES(WR, JOB_CREATE, job_create),
> +       DRM_IOCTL_THAMES_JOB_SUBMIT =
> +               DRM_IOCTL_THAMES(WR, JOB_SUBMIT, job_submit),
> +       DRM_IOCTL_THAMES_JOB_DESTROY =
> +               DRM_IOCTL_THAMES(WR, JOB_DESTROY, job_destroy),
>         DRM_IOCTL_THAMES_BO_BIND =
>                 DRM_IOCTL_THAMES(WR, BO_BIND, bo_bind),
>  };
> 
> --
> 2.54.0
> 

