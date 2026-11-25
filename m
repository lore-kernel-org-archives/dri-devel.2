Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=syM5ToDy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE5510E1B0;
	Wed, 25 Nov 2026 03:21:53 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADCB10E1B0;
 Wed, 25 Nov 2026 03:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh5cDO82qJqqT4heF0uwJvO55f4mlFooPvYlkzxYMN+LzXmvwzpiw8CtsJb8jK+G5OUmcf2OahEx9mNaKaXB5Io2i8ougNAyKV3abYWpBY4O7lioJ+mcYuCfqpoHj3gfMRqxfYWaUMwVFWwiPM3spKUE69s22lON6K5R8V2DdaEwkL8ymwRmZ/HEr7gXXySjv2GrCFyrWcKnv3k+x7+t49v8PCoVhQpkTP5ar+0gBGCmO+h+zB9p5Qmu5YCZ9KnDkgWspl4w2XedlVlz1cUQ9UAJqYVOIlYu2IFDVAP8PveFoDSSp8rY3BvERvsylTYhEweCaYSf7tyO7w+kKgJQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwYThEBc1KQliI/zLmrsxgebloQQ2cx6OELKT1TwTSY=;
 b=flw6OsU72pnrfAU4G9THTXOY5SZVq6hD40ehoslGeDCykfZW/MOK8gaH//khWl+lRBb5pOy8t94gZgU1S+mmeJ7ZavSh+WSGuH321V9gcFerA8QURWzfluT9Imm6sOyle3R9mKVHWVOoVWDzxX5LccCTAcukNB3boxz83/8zN+NbjGhQTrZ4JC81UqvTtODeOYtM+37hLqhVPFRLCQuTdtoyrdpdMFObO4UK838eMSVLgcrOV0A30npo0VG/UpdTyOxHF9hLvXJ0y3Zqrg0F2RQSxUOHuhHiQ6XfML+2X5DJmzUYcfRIksu176ZSHG2mi2SLd8pstsHd9OI98m2aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwYThEBc1KQliI/zLmrsxgebloQQ2cx6OELKT1TwTSY=;
 b=syM5ToDyqXfXpJQEu5OqC1npU5YjPc13GFRUyQEp3wrs+Wkp4o+jv1stkzJ2LpL5wZqEcQM9HTeE6GfDxCh0wYoDY+D1vCXQonC0O4eJbXu6blue7TdaeSl2lxvlSkhqLx+EHHvDbIHCjA8j5oKNtU8qLjr5zJNqAqa9+u4bmILRFxLJ3puFsC43+QjrdvMIcXUzD1bcssuk2V/Iur2BoC1m5G6+qvykRDUhSOh9ke6iReHjVBAk+7OT61axeBdfj2LMSaAt1w3cRu4buTTZCbsnnuh9d69kUdyzp/34KaLYrXl9E1Vvx9PykFI0/M+sJZkbE7UKk5Z3wlee3kGVaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 03:21:43 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 03:21:43 +0000
Message-ID: <41dac367-ab55-4e0e-91a2-9fd68ef0c8ce@nvidia.com>
Date: Tue, 24 Nov 2026 19:21:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
To: airlied@redhat.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 nova-gpu@lists.linux.dev
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
 <20261124-nova-nouveau-gsp-v3-1-e1440479ded6@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261124-nova-nouveau-gsp-v3-1-e1440479ded6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ce6cc1-e351-4ab8-ca28-08df4aa33a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ZDKj15fkLSlBD6zpQM/eLITO3UkbtlIBqhFa+ASYOAP9VcKkDX7acl+JflG4Iev7pJrKI2C+pPE0UDdLlxKSqlaBzsLjmgfRcHnlgQAHnv06ZXFgNCEo7aH8nhCK62bj7TqFpCldtrRfbQgjiPjIkFuNBdlMaN7g0sEnxic7Y2mGYh2+b5Nq1SHf9iJCHGdaNOnTFnKjhsFr5tlruZ6cF1KEKzN5CvKUp9nO7p9ijP1pFrGNT3SxIZjfinQVVgCw7+XLvnkuOuU6dyvW7n14QNCKWgw3GBwqcAs5CnuE0ayvNwMjrOnWGjZ2HOc6657Mv4aLzfqfCDc/mAS6VX7htRonn95Yc17rbJqg6WCbT5WJWn7Kt6eb5WrOXNqIt8i2WLznSC87osWl1TFZI/079Ik2s8/P//0QG32G0RQfQdVa9zHkVU4IHTlT6pGXOQcqDj/YobxucGVu2iEwV/1M6Qg6ffAhSjvKdKdFBirdRDAOG5pn2Mr3TwAa5OoRa47OPxCk5t93ZDgX53+N5ua+Ami5WMfZWzwXsaWBJ7FRVipwVgtWOs7Q2DQUHyMNnDDqTSR/sdee3Is8immKXS/PnJdMuGu183/f1TMreKUIX7BUT03lUA+D+FTU0/2enSrcDB7reyImUeCZ1WCTXSLZsowliWp1p4PTz3zY3zCclgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGx0VnhCVCtmT2NhWTlJZ2NET2tkZmpyWElaZHJNMzd6QkRKL1oxZ2I2ay9V?=
 =?utf-8?B?VldtN01rYUVVVWdDRFVHT2J3NmNzc3p2UzhqdzVyMGVtNk9Uc3JPU3c4a3hJ?=
 =?utf-8?B?ekxiaERXaXBDVUxYYWZWcm8wK3REMXNnSDU0bjN1R0NQcUdrbTFJWEJDY01q?=
 =?utf-8?B?TVBab0xwM1FKZjZZQ1ljVy92ekpjK0s4eE00WU5lVUwxbFBBZ3l4VGdQeWh0?=
 =?utf-8?B?LzZhOE5IU2pTOFdWMHkvYWFUdy93ZSsrNkZtV2JnRWtoK29hUm5tb2NHRExD?=
 =?utf-8?B?bEo4aGowRGg4T1pBNCtJcmFzaEpPRTI2QjkzejZiUldCR2pnOGxYR0YyVTlU?=
 =?utf-8?B?Y3J6aGNZU3JuTTdaeUE5eEJlbU00Ty9pSStZSG9HUklZNXVmaDZ1LytZRlZB?=
 =?utf-8?B?REFzQW9VUzY4SzNJUlUzd2VjMnJ6c3hzUE9kY005S1BNU1FmSEFkNzFTS0ti?=
 =?utf-8?B?UU00SWZJTWc5cjF6bjZyWWxZRytjZDJwYWw1YVF5MXZZZTdCaVI2TkZrd1M5?=
 =?utf-8?B?RDc1WU1DNEVuc0t2bGFtZVdOV0JEbVV5ZFE4ZjUydnMydVZsUjBHYUVWL3M0?=
 =?utf-8?B?aUV0NDloNnR0SXFsUTIrcll6SkFaZmQ5QXQzWmFpdXlpVDdqeDh1R2hUUU9K?=
 =?utf-8?B?ckt0UVRsZ2Z4anN2QW50cUthaVlzb1pFaGpGRlZlTmNDL0wxdFM2dDFQc1Zo?=
 =?utf-8?B?dGErYVQxNktpSzh2TGhOcTMxL25SMG5hbnZtZlBRaFFaQlVJdk44Z1BEYUtw?=
 =?utf-8?B?TUpTSGg2cWhVLzVBQng3UDQzRDVleFpTeWVqYWhDYUNSK2JFNlIycW9OV1px?=
 =?utf-8?B?T3FNMEFPajF1Qm9FaHNIRDJLeTFVMmlsU2xuNUZjVkdXSk8wVDd4ZWVORjV1?=
 =?utf-8?B?b0NwWWhEOWV3eS82MGhtekNUL1JpaWI4dyt4T0NmQ0xKUkxyY1A2dE9FYWNj?=
 =?utf-8?B?eUhhcWRjbnlYeXZHOXlKMzdtYmF2RzVMWGVNSitxZ1ROZi9zVGY0dEpTT0NW?=
 =?utf-8?B?TWtUS0p6OW14YUh5WDUwcEJXY3lKamgvb1J3OW5IM1U0dkhMa0pYajVrSURj?=
 =?utf-8?B?ZE14TDBDazRiUy9XdW4zd1p0NkVBVmNweW5jYjl5eVE0RFVPQk4rSExhR3pR?=
 =?utf-8?B?bVAzY1BvWmJ1V3BlbThkVzEvbWptQVlDWW9XQURnZnE3bndVUnJkYjZOZ3pj?=
 =?utf-8?B?aUc1NkNqSHg4aksyd3llMTM2Vkk5Y29ELzZCNG5Lam1mMC9SY1hYczd5ek9p?=
 =?utf-8?B?Z3N3QVVESlVGcVZmVjcvbzZzbUFMVkNQNHJlcmQ0cDl2OVdEd2RQKy95dktM?=
 =?utf-8?B?eGdWWnpDMklDeVNnaDVrMGllbHY0bmJHeWFaOE1wWjRUOFZ2M0V4RTVVTW1l?=
 =?utf-8?B?U3gvcXlDaUhNZVduRll6dWN3WHBVOXZhb0NUKzlTN2xOSndVODJIUHpURTBz?=
 =?utf-8?B?ZG93NFhDb1FSeW00TW5tTFE5blJHOUs2eGNwM3B4a2hGSW9HKzFpRWp3Y1pi?=
 =?utf-8?B?ZnNEVEJ1VENzTlNDdWpOWUU2MTdZYm5LVnIzUjUwTVp0Q1NqS1loY3dmVkhy?=
 =?utf-8?B?RkNLOW5jYWtZMWJPVUZhYlc3TE0yL0FxSEhkR0ladUtoTTljUnF4a29GWS96?=
 =?utf-8?B?c3NKSVVSaktxRmVwanowc0c1ck1EKzlrQjZTUEJjZnd0SytlcFNGQWtja3pS?=
 =?utf-8?B?OUpRK1VLcFhaK1N4Vit3Rk5kc0pjenIzMFQ0TFlXaGlsUE4vTDlaY05GOGsv?=
 =?utf-8?B?MjVFRTZVZVJMTWpBcUU0aExRdklHS2ZFeFFyT2NGUzVhLzViNWlaRTBQUjJO?=
 =?utf-8?B?UjVNa29OVEs3c3ZzK1JFOVlqRXhqdjQ0ZGZtcDV5cjhvN2NlYWNmaC9nTURw?=
 =?utf-8?B?K2hwMzhSYVRJSmZyYVdJVWsvdVhqb3ZQQjJ0SWxaeDZPdVNQOG1uR1FnR2ov?=
 =?utf-8?B?VW1TK2xOKzA2QXl0MHNhQ2NDMkx6NDQwTm1vWmdhcVc5V1FlaHBmZHg5Y3ZK?=
 =?utf-8?B?aXhPWjhZMCtNZlh2bktyUEt2cng1Ynl3UXppV092NE9KMDRQM1h2K0hYTFBk?=
 =?utf-8?B?QzBrN0JjZWgzZGJYcWsrL2laSmREUWFqTGRUd081L09ua05UYkw3dWptYzk3?=
 =?utf-8?B?b3VJcHFrZk5xaVkxZ2NTS2gwdE90b0tqR3hEb1JySW9FMWtTeFN0b2NmOHg4?=
 =?utf-8?B?TnhXWlVWU053R25CdlFDbjFCUEl6aTlYWStiZDU4ZWhqa2FTeXNCSU9XVzg5?=
 =?utf-8?B?SDdVc0tOWDZNdEJWUFphU0d6Z0tNSk5ZaUJNMVJ5RWNON3NEZDBwZXpoOFow?=
 =?utf-8?B?Q0JXVWpYVjZUbjI3UlJEbmdmcVUrZHZRSW1aU1VadmlGNnJtYVNYQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ce6cc1-e351-4ab8-ca28-08df4aa33a6c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:21:43.1499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEzANu1HCOuGw03etAghOWyWJAQ7VwRKzzIIC0j6XLq2tsN+yCUn2e9rX8eAilN3m/PZneQtAynmGOLDa09U4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 9:50 PM, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>...
> @@ -3446,9 +3483,11 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
>  
>  	ret = nvkm_intr_install(device);
>  done:
> -	if (ret && device->pri) {
> -		iounmap(device->pri);
> -		device->pri = NULL;
> +	if (ret) {
> +		/* Unwind the partially constructed device, so that the caller
> +		 * only has to release the resources it allocated itself.
> +		 */
> +		nvkm_device_dtor(device);

This also fixes a user-after-free on Tegra (not just a leak), because struct
nvkm_device_tegra embeds a struct nvkm_device by value. In other words, if
nvkm_device_ctor() fails after adding the device to the nv_devices list,
nvkm_device_tegra_new() frees tdev while tdev->device is still on that list,
so the next nvkm_device_find_locked() call would read freed memory.

I'm not sure how important that is, but if it matters, then splitting
the fix back into its own patch might be the way to go here, after all.


thanks,
-- 
John Hubbard

