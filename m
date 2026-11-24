Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F6606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=19uKsZEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513B210E57B;
	Tue, 24 Nov 2026 09:26:11 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9444710E57B;
 Tue, 24 Nov 2026 09:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMYYp9PmXd//qv+cxpCIzLzXFpkkiJ6nAtw2ZrahyZC/vM/HsZX0hZbQF1fSAOGTufhMm+U5l8rWksjvJkwIPhGppBKSs+mWbkHPXOfOu+LHYIU/IEMzhOgwp4CLAOtXUEDfQ4uCTVwjr21vNdkRIaJIGoifpolOJUXTJL5KCLucWOZF3om5YZk3YYubzcLX7hnaG0FN53yD/C5HwARyEqu5f4cy34qxXJH+aoXJmpPygNAXRBnB14GkLX8L1T3VKlvsRtRnX3E28eB7pUuw5/maWFof3oFBujJFNKTpdwtf3SoYBB3otQ55cnnoMUGA0FKY15fipxlMHuAlbtHVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdzyJDphydQIk0KHJG6EvhREEk8St5hqVwoyy0ThiJw=;
 b=tRwyZm/VmHFqysFulzBnY1tXpQGpql4oD51OR3ouvWBDJwaU7aacN+06K4AZLvgoN9QBGRPhimLcOxm1GlTP51rLgXg9E7FryCU3HeA0YLZuOl5+Dqe3UwLOw19Lvvms6+1R7Kiq/dQlPDLHEb0rXBYCWi15emdZOkt9u85sH5jSeGxhL/xpGCZ6KU/qKz8jMK8o5MSOXxyWSwQUemaIqWDuYi5ob5yLnY3dYZd1VksDlh/HRx0HN4y7dB77i8O/0dcCmWFML1YdfcdyCJUXui+TLDJdGh9feSuwcVnBLV/zyJ1QqaIoh11RDBRLMDQxCFVhAhiUnDyM7XPhSTga7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdzyJDphydQIk0KHJG6EvhREEk8St5hqVwoyy0ThiJw=;
 b=19uKsZEQJdVGN5pPcIhLmafE+vjY1zTEyYb4aiqrk/Z4O/3dZvUMIoLxMFkpL098rcxR/wR31X58JcnlmVz4lgJtHd/5/Wxjst/Y1NkqxqwUj3ffx4olP13oQaJam4uVDl5ngpAryeo+lSH31y2ULmSZj0PEUHQhkTVUL6R01zc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 09:25:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:25:58 +0000
Message-ID: <7c401d0b-c6a2-4244-b470-b6eb831cf42b@amd.com>
Date: Tue, 24 Nov 2026 10:25:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/ttm/tests: do not count pages after pool's
 teardown
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-xe@lists.freedesktop.org, Ian Forbes <ian.forbes@broadcom.com>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>
References: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
 <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1435d99a-6471-40f0-0977-08df4a0cf25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|11063799006|261026121527099003|56012099006|261022105027099003|261026140227099003|261028144727099003|261021135927099003|261021123027099003|261009223027099003|261022075727099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 9do79E7iUxXC5YE1aGsHiNS1iu4jJnX0y/grs4QzJ2yTQRG0T4Q1rAMMq42YxN2K1EG65y/BLgmBge5clMrKZIszS+Lh2Hk2gFvKWW/uPE71LmmzDV1kRWGz+rYiUkO/zTg7ex7VeNOxBMVxkxzSaV+bGM2uQA0zFAdEvodwzC7R5KblaNzLkGVgW1pAPSt/CXmcwQH/Wbh7eBtpRoxHEhx3pLB5UhwL1DDGC1gyw27VTkpWyLRvaJyFXA+njQ4JDBCA4wEwJ7CgD2fMf5LwjKqFC8G2AooWiJkSz5W6vX01LQDYXT8u4kGbnwWH9h367kJCycE+D1GUDR03nqzTh7+9O2Klx8WlpvEtO1AZLPBzbzmx7cFkm5pX7il3oGrbv/UxqODJn4jxBzQXbautLUmUD6GdpY4gUBl83SRjXJPpVtsyzHbxZ08w19QHqi6L03tpEvzShYBj/Cr8m8eAAvq7sBUY71TIruycoqCVZaauaVJ43tEpllw8J7HRL/NRjv9yQDKAVJYhGJ7EbgdTtHP2cfjwCxnep2pHw7pIatWwzeiu+O5V9BN5+eiRO2QKUROiUuUu8K9wq3/H11ScP+xMBHww/CugowxSCSQYJ8RlWem/HagnlmgbXvnACnAoXpIlwhxgscV6RN2QUDcBgIKJSYMK1F/vcGjDRFgigzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(261026121527099003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021123027099003)(261009223027099003)(261022075727099003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9GQnF2Q0RjSEZ2Z2o2QmE2S3Y3QWNvM0FVMVNjSjBxSzA5YmQzeUR0NXlZ?=
 =?utf-8?B?b3dxM0J1a2ZPUGxxMzA5c3dOMTVqa2xsMGFwTTNQQ2ZVelNJdy9jdlo5TlVS?=
 =?utf-8?B?aysvTmVvcjFJSTFTWVNkMzB6SkoyVWY5SFgzd3lBcHN5UGI1MFZMT09MYWo1?=
 =?utf-8?B?THgyTGlNZXV1ckpjaGFGQnIwdXMxV3EycHROc1lhNFpzT2FlaEhsQ3ByK1U2?=
 =?utf-8?B?SUQzc0Erekl4azRVandyVXFFTHZSOFY1bTA3NDJzd1dld1huNXdWcHAvUTla?=
 =?utf-8?B?b0VRQ2wwSERFUFFjTUpwRWgvKytmMFhUTDRKMjhoQTFBMHd0a2p3eWJhV05x?=
 =?utf-8?B?N1BvUGxELzlEYTZBc0xBSC9VUzRMS21nWi9TWUxQbGpLQnF4Zms0eXQ4UUZS?=
 =?utf-8?B?eXBzM1pBeVFpMm5ITW9LYktZWFdqVHY4VzZ3TUZsZ2h1dlIwWDUvTC9VTDdV?=
 =?utf-8?B?WEpSZ0M5MDZmVkx3eFBkOS9aUEIwM2dTeDFOZGVQbHlhWktWRXIycTNEZjNW?=
 =?utf-8?B?ckVHR0NjKzFQNWhXbGtnK29LbGhsa0J0RnBpTmV3ZEFhNitxdlVWUGs4SThX?=
 =?utf-8?B?eDhkNGxoQ0ZkTndDSm44bW9ZbDZBeWdFNy9RMTVTMkJtY0E0SU1FSGtScWVL?=
 =?utf-8?B?U0RINDhDMDhDVUpQVjUxUVZrZmQreHR0NVFWZFBySlpWWnN4eEhFN0NwdUxl?=
 =?utf-8?B?SDNib2FUL2ticHpQWkZDN2tlamp3T1RmaGZZcU1KdWsrNUZqVjErMUJiYjhX?=
 =?utf-8?B?VFJiLzRrWHhjSmJ1MzBQOWJuNEJ3RWhZRnJUbXFoQ0NMcllvR2RMQTN5QkdG?=
 =?utf-8?B?TWhuUmNTOHZvdUtkb1VxMnNZTUFjcUNZMG4xd0pKV3Fod3JjZXpZcHIzUThX?=
 =?utf-8?B?VFFRc3BVMm5WMmtuU2RweGJITUtMSklPcExvNFovKzIzWlJkTm9xaE5kVjVx?=
 =?utf-8?B?bWxoS1JrUGdIc1BkZjBSOTJ1clpQQWpmUmhrTkcwaEZaeW9ld3Q4YW5JTlpo?=
 =?utf-8?B?aitCQml4ejhVbUo0SUxBd2VQMHZiUTBmTWFjUWJKdDZzQ09TcGJSTW95eSt0?=
 =?utf-8?B?RUJmSjJ0T1NhREYrZEgvTXowQndBV3FhS3BnZnRadmF5a0laR3AvS29KalVt?=
 =?utf-8?B?Y1VpVzlRVmNIeDA5VlVhV1Z0YndYMEV6L3ZvdmR1amFFSi9OVjZsMmtGMlda?=
 =?utf-8?B?Tm8wYXFkekZXL1RCa08rUjA0WlZxMVJ0eFl4SmxWYnFRWjBDZjFxMTVqblpM?=
 =?utf-8?B?N0NTVzJlYnlkZkN1eVo2U1RkU1NzNk9CcDRRbHRRNEZMd1Q3dlcwRDhZOVR6?=
 =?utf-8?B?LzIyRTBNVGlteUI1ZkFWZTBUTk5QZlEyZ1d1ZCs5eVZvVGdTb2JZSUhyc1M5?=
 =?utf-8?B?N0JpamRKSU9SRUI4STNkTkJyR2NvZ21RNUNuaE9vcnRUdS82a3ZxOStIamh2?=
 =?utf-8?B?emZVQkN3NWc0MGRROE1lNTR0OWVxL3BaeFFHK2wydCtGUHI1bDNSc3VGTEhQ?=
 =?utf-8?B?L29xbmhDeCtxY3h6WnBwQnZkMFJRc1I0a1RmNENkbzlURG5rWE94Wk1xZzFF?=
 =?utf-8?B?dnZCWjlsdGRFK2tJMkYzMk1YSW5RamREOTR4ZmpuM3Nrb0thZmQ3OTBnemxI?=
 =?utf-8?B?UWFCWTBxU2dQdXF0bjN3SmJPTTRtUFhqWHNHL2h6N2V5aURjbWtPZ1NpNWNr?=
 =?utf-8?B?eWw4bTltQi81OXVsbExZZHUxTG4rc0wvMmthR2grc0NGaXU3cGZ5YWJYaXFK?=
 =?utf-8?B?QU1YLzY2YXp0Ri9VVXVxdjdVWWtiZDVZeFRBM1hjMGhsWTFVYVFqdFVYQ091?=
 =?utf-8?B?bVhQdHI5MU9HVE0vSWtmOWhmYXpEL1lLTlUyZk14ZjlzTVVuTmM1dDdhMkFF?=
 =?utf-8?B?LzV1MkJpUGo2ei9adEtEc1VETlpGYTJxcW1vK0MvRGVPUzhzOTVseXVid0NN?=
 =?utf-8?B?OTdNeGFsS3lRSlVCanJDUVVHT0R4dzA1MVl6SFlqTWwwbEhCMWlzbkIybWx0?=
 =?utf-8?B?YU1ia1dvTXRPMjlTUFBSUEZQVTc3UnhuU0pSMm5VOTB1ZlpiZG05UUtKUUoz?=
 =?utf-8?B?dVB5VXRyWlVLZmZHUDNEb3hKUnErYWhDeU54ZEZBVHhhSkZhSFFVV2IxYTQ4?=
 =?utf-8?B?U2huSTFGdDZXN2lBcGNjWG0waTNiL1lkRlJjT3ZoZlNiZ0QzaFFBUkZWaXox?=
 =?utf-8?B?SU5FZEVEbERMQzJoVURqVUdNVGdlSFFYclp2eVRYWXdObk9JV1VyRGlqNEp2?=
 =?utf-8?B?Y0k2S3NUM3I2YjY0Ty80bFBFVktJNisrbmVudXVUSTdBRnd0QUhrb0prczJY?=
 =?utf-8?Q?M6YMIW1RKDLfej6NTR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1435d99a-6471-40f0-0977-08df4a0cf25f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:25:57.8990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iasE6/pGDzXP4bosUPdJyjsxVaEw7n35n3MLtS417e+u7W26YVC3QL1VjWJmHzHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please make sure to send TTM patches to Natalie and Arun now.

Regards,
Christian.

On 11/24/26 01:43, Michał Grzelak wrote:
> [Sie erhalten nicht häufig E-Mails von michal.grzelak@linux.intel.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently ttm_pool_fini_basic() checks if page count of pool-type's lru
> list is zero after tearing down its pre-populated pool.
> 
> After commit 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> this check causes NULL dereference because page's lru list is destroyed
> during pool's teardown which leads to KUnit's crash:
> 
> [20:08:24] ========== [PASSED] ttm_pool_alloc_basic_dma_addr ==========
> [20:08:24] [PASSED] ttm_pool_alloc_order_caching_match
> [20:08:24] [PASSED] ttm_pool_alloc_caching_mismatch
> [20:08:24] [PASSED] ttm_pool_alloc_order_mismatch
> [20:08:24] [PASSED] ttm_pool_free_dma_alloc
> [20:08:24] [PASSED] ttm_pool_free_no_dma_alloc
> [20:08:25] [ERROR] Test: ttm_pool: missing expected subtest!
> [20:08:25]
> [20:08:25] Pid: 80, comm: kunit_try_catch Tainted: G        W        N  7.4.0-rc4-g401a3e7b64d1
> [20:08:25] RIP: 0033:list_lru_count_node+0xe/0x20
> [20:08:25] RSP: 00000000a08dbef8  EFLAGS: 00010246
> [20:08:25] RAX: 0000000000000001 RBX: 00000000a0803c70 RCX: 0000000000000020
> [20:08:25] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000060853030
> [20:08:25] RBP: 0000000060853000 R08: 00000000a08dbe98 R09: 00000000601246ac
> [20:08:25] R10: 000000009f227d00 R11: 0000000000000000 R12: 0000000060124640
> [20:08:25] R13: 0000000060853030 R14: 000000006047c950 R15: 00000000604c6488
> [20:08:25] Kernel panic - not syncing: Segfault with no mm
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: ttm_pool: missing subtest result line!
> [20:08:25] # module: ttm_pool_test
> [20:08:25] ==================== [CRASHED] ttm_pool ====================
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] [ERROR] Test: main: missing expected subtest!
> [20:08:25] [CRASHED]
> [20:08:25] ============================================================
> [20:08:25] Testing complete. Ran 28 tests: passed: 23, crashed: 5, errors: 6
> 
> The crash in turn prevents Xe CI from running IGT.
> 
> Drop the post-teardown assertion.
> 
> Fixes: 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> Cc: Ian Forbes <ian.forbes@broadcom.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> index be75c8abf3883..dab03dd6c9dd7 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> @@ -401,8 +401,6 @@ static void ttm_pool_fini_basic(struct kunit *test)
>         KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt->pages));
> 
>         ttm_pool_fini(pool);
> -
> -       KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
>  }
> 
>  static struct kunit_case ttm_pool_test_cases[] = {
> --
> 2.45.2
> 

