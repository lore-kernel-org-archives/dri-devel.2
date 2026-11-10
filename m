Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539146072650
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IUSSMtJg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FAC10E0EF;
	Tue, 10 Nov 2026 09:25:12 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D12810E0EF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/Q5yJS9AelnRExxaOSPg4jyAdSJGQKlbNfbwdHQZ+wQdrlXiGbIdFA4gp7viFxzFClV26MnSIp51JZCegafAeMgZr8Obaf+yh0CCYLPX9t+copPWTm8IVFtIuSxF5ybmE3+Dc1W1Co410zgHNWjG9yN1UL/LW+3w30PsCUFRaaXDpeTm0p59Ixh2scf8HTnm9NZDxO/woSJrjryBDMLCCCW+RpsZ8DgM8icXth/d3LvglIcG13jYp+vUQDdxe/M9bhnHIi6Xzns1Axkk/xhbWt6Kh3SL+PwGIBRSgKr+DFb6W2wT7Ar9xetir2KVxVvAKZqpslZV0YKBBTwGiyvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rcJgsbE84swGMqfW/5dYciOmzkOC1/uW7uX0ROus54=;
 b=e+loo7ox0rfG9Tn7buAzdmEINzx7kitQK8gTZsVj5S6PwmGK7eFtN/S1nPl9LGrwnwh5W9wetXqj4ChpK+APM6pzWSa/rSD0AwJslAZVjMzc7B+dYzOEU+9N007Jpr/R1wq9v99FzOo6tipOE08ND5tCnT004DhH/pyZKg8HlZL4faAYDU9I6QP2gIrL0K2ZV32ykwkkGBsE5JqqRreWhQUB+Eb/bxqb64N5N4QiYQfZX2oYWuMXCtns7u35ggld4XBqfUEWFwwXanA4RPa9D3U+H4o+sFFjzRjPq7PCiAvViRQvrbtiwZdhUK+tgLip10UGDLywFHfvbharX/D8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rcJgsbE84swGMqfW/5dYciOmzkOC1/uW7uX0ROus54=;
 b=IUSSMtJgg7kp7Lu7HZd0vcbae7dOMCJd9Rh3CQ41w3RlNL4RQ5ZxW9ATwxoci1TetZGnJ976P7PvCl1SNDZAexwjfzOAeU5UOom7bSLCciEHNoOoPRE9oJw/s8q9aiB8tI63v9lVhbGlIh7V0q6aEZFuodx+CEKl3stumo10elA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Tue, 10 Nov 2026 09:24:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:24:56 +0000
Message-ID: <cbf69ae3-9219-428f-9a8d-5642579c76f1@amd.com>
Date: Tue, 10 Nov 2026 10:24:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: check for NULL resource in ttm_bo_kmap()
To: kaii-k <harshicon28@gmail.com>, nat@pixelcluster.dev,
 arunpravin.paneerselvam@amd.com
Cc: ckoenig@amd.com, thomas.hellstrom@linux.intel.com,
 matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, Harsh Parmar <kaii02ctf@gmail.com>
References: <20261109202330.1816799-1-harshicon28@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109202330.1816799-1-harshicon28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e87b9a4-d17b-41bb-e144-08df3f0c7c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|261102123227099003|56012099006|261021121427099003|261022105027099003|261009223027099003|261009221227099003|261028144727099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rZaBNoIglvZBMuNVpPBTaqiShsL/9n3KLAuAUmy9eBZcjmLG4gQ46IAqhrJanQzwF7wGaoPJz2nTuB7p4VLZEY00nJHpIjtV9LMo/DGgGXU1MXlg7kWVuNM5NUkasPlAPdORUgq1ib2rUAGX+3grlufJBOd+/Ync7FiRwFujFZs3UrkVBlh7EcF2QL0jAsXvL+7dAhoqPwE+h0ga9GxqE/NFrKgZl44+run0/GbOm+fImdGcrZBZgOka2kO8VaFqT45CmHIbavKirBcidNsq3d7UR///A0xNSpEDi18NyRZ78QUTkCZ01H7TlteC3HLmPc2p6UIwFUKJmv3fPnxB+xioHLFJXVtGLUVub8dq3lZlTiRysw8V/bBiUbHvnIrEFWCpBw2ylw2eL/R2J05sscSH2M0IMedy1++vsHnwm+7w36P6uDwC3IoV8yROth8W8u5OQxTxEPfcgD5DhFmOY0HHL/k//flefw6Zx81+peLb5L58vobp1B3frP5ek7QMWylzcBpCDMzbmHxSwgra+RQAu1tkar39lEXoWFaQ8jG42If/BpkzI1vmhj1tGZQxUNj9kq6ceEfRkWiuRnKIzxiOA/QsldOiTKiwkYJGCZwTOn6Gaya4Kcgr6NqpDyyLDdbUH5QEfiiTVtRhtI1df47qHkhk2GbxcBhWapZ34ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261009221227099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVJSXplU09xZHAvbFdGVm1kdy8raFVjN2ZXViszaEQrNDAyYUpicG9lVnJ2?=
 =?utf-8?B?b1J1WnpsNnJ3cnFSbTB1KzAwanBVVkJxWjN2QVA0S2s4YjFIcDRrMnJyUytH?=
 =?utf-8?B?dU5WcWhLbUtiZlZERnFrc3lGdXY2NUhnQnU2QXpOZHZqNXhvMXNSSUtJcFlH?=
 =?utf-8?B?bm5QVUNtc3I1V0Nzd1J3dlovV2o2bFRmeE42dmZiTkJLZDFocVN6MDlJZUhJ?=
 =?utf-8?B?ZllMV0JxWlNGZFZWZEkxcGwxR2VBdWVzYkY2dENtOUNheGo4SFlldVZOYjRO?=
 =?utf-8?B?c2c2Zy9PTG54YVQrQlFTdGVac25OT3FFM0liSkNYc2JiNDA3eEFzYUFDQ2Iz?=
 =?utf-8?B?dkhVNGlpNXRxUnROWEUvTDI3b1g2bkM1b2tLUXFYVy80cmdEcm04SjRSWnVn?=
 =?utf-8?B?MFZpY3B1Vk5JRHBIckdNTHZydUNWTlc1MGZhemZOZ1VVL3ZCclJrU0oweFhu?=
 =?utf-8?B?SXYzUmJ3YUtydUEvZVcySThmdEljSUVWMkhKa29qSmMzdWRBNmVRUFk4WFB6?=
 =?utf-8?B?MUhucEJldDVFT3djbGI4MXNReHhHS2liaUFJYUZNV1lHcTdOWGxkS29qZ1Rx?=
 =?utf-8?B?akk0Q3l6Z0x6TFdoNDVtZk1pWnhrdEkrQjZwdzMvZkc3NkNYd09XbXRpMDVp?=
 =?utf-8?B?ejFQWXR6NzVFUEZXYU9vaHcrZUtPamh6SVdiZEQrU2w4UXJMamJxTTdOMHB3?=
 =?utf-8?B?bTJjQ1RkL1Y4WWoxMHMzZHZXa0ZGVnN6c1JmTnZqMUxsWndVTW9LT2hUYmRY?=
 =?utf-8?B?SVJBemxMODlIc3ZZQjhUMjFXY2ZhdjJoQkFpVmpLTUd3Nm55Wk5Kb2dTM2FK?=
 =?utf-8?B?bThvZkpGaUwwRkRvcVQ4bDFPdENJZlFvMi9ydFVVVG1nOTZmeHJJcWlHZ0lX?=
 =?utf-8?B?d2lmN0h4dVU5MklXRUtuRDdkbFhRRkF3K1Y5cDVmKzFReEpFcEQ3YWhyQ2lZ?=
 =?utf-8?B?dzIvSTRSczNVLzZKdHV3K1dOSFA0dlZITlpzejlqcWgxaytrLzhqUVpvb212?=
 =?utf-8?B?UUk4UjdaaGFja09IRExSejdqeUErd3pjdjhIS09lNUJUdVRkRTVxZHVsaUlU?=
 =?utf-8?B?b3VqL1JkTTh0ZHZSUXRSckJVNThyMk5zY2RoSzJjYVlHamgrckpGSzFGVmJy?=
 =?utf-8?B?a0U4eS9pY2NJRndyb0lCWVA0bmtCQ3hDdmRrS3NVY3E0a05nRHFlY0c3Mysx?=
 =?utf-8?B?dWFFK1pudmJaNVc3R0hzbnpBZEdkbHU3YUk5V0dkaFpXZGJ0VmtiRDBZTHNq?=
 =?utf-8?B?NVJvUGxSSzBrdHBVdTVkbEJjY0duVDZQUDRad3o1U3dSZVJkT3BsdTV3RnNy?=
 =?utf-8?B?bE8yenBHd0dBWVVLcENiaFc0c1UwditPUmxIMUM5bERtR3MyQXplc0M0NEVF?=
 =?utf-8?B?U3g0a2ZxTzBMV2tjR3pvRWpPT2VyMlZuNG9CUFlVL3JwYlgyY0dNai9XUUx1?=
 =?utf-8?B?NDJvcGpXUGFQS1o4UVhMLzIrcjkwWUFLQ3NDSHg5VU1RWTltek4zSnpaT05S?=
 =?utf-8?B?eGVqTVAzS0FyZWhxZHVCRllOUnVIRCtPUEFvWURIaHVLUDYwME5MMVdRKzJq?=
 =?utf-8?B?dzVybS95aFFsN2l2cFR4K1FxMkovby91cTA3WHlyT0F0UWlIOEJFVlZrU3oy?=
 =?utf-8?B?WkVGUVZWR3NKaUhsQVExMjZCb3I1ZUxRemw5M2hKTEhtVUlybld1LzNRMHdv?=
 =?utf-8?B?TjR4bG5DNVVQVTVXR1NFT1VubHVJdFU3bk8wNHUzb1FEQ3dHNHpSMkhkUFNu?=
 =?utf-8?B?TEVHU0JlYUY1STlTNDNoWjBDMTZuQkg5SXBhVUJ5QURSTnE0UUo2V1ZScjZr?=
 =?utf-8?B?TUlkTlV0TEYxdVJuSC8rQU96UklwaW1ra3dvSElHeFc2UUVhUTFuTk9lZklU?=
 =?utf-8?B?VUNlaVFhK29nVGhlRWNHRk5xSnY4dlFQblc5RXVzdHBZMUQ4alNpYzY0ajg0?=
 =?utf-8?B?N1M5T3BCT0JmdGFtWkk2clROV0FKOWk2a284b0VOcFNNdHB3clZxbmFIZGZK?=
 =?utf-8?B?blZqSUIzWG5zOVZSS1JvdXhQbkZmK3VqUUhDQS80b1NocE52dHlvbHNLS2RU?=
 =?utf-8?B?bk1NamlOSHJXdDY5aVcwZkhPYktCWnpwckdsMytiUE9URXFzWW01ZmJFMmVU?=
 =?utf-8?B?c1RXSnBKVHMxbnl1MnlqMWFYYWx4bHByeDljNkliUXFzMzc1cUtvSDlyMGV0?=
 =?utf-8?B?Y0MxZldNNitNNUJWQXZCc0Y4dHFSYkdWeWJldW5hcTZxbzlMb2ZkNzlwcjJ1?=
 =?utf-8?B?RlA5KzI5MzByUy9maWNES2pQQmtwNFRSN2VjaDB3Ty8zSUNoeC9oc29JUWZ0?=
 =?utf-8?Q?RPiTtIzm5soG7t4MQh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e87b9a4-d17b-41bb-e144-08df3f0c7c2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:24:56.8182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEnozYZKPn6vf3THWJhNvCWN/n1CSGlTfsLjbdmvyNWW1O5E6XgsSl7Fe+Ju/8mT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

On 11/9/26 21:23, kaii-k wrote:
> From: Harsh Parmar <kaii02ctf@gmail.com>
> 
> A buffer object can legitimately have no backing store: a driver may
> call ttm_bo_init_reserved() with zero placements, which leaves
> bo->resource NULL. It can also become NULL after the backing store has
> been released.
> 
> ttm_bo_kmap() dereferences bo->resource unconditionally (res->size),
> causing a NULL pointer dereference and kernel oops when called on such a
> buffer.
> 
> Bail out with -EINVAL if the buffer has no backing store.
> 
> Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
> Signed-off-by: Harsh Parmar <kaii02ctf@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f9458a4..158f0df 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -435,6 +435,8 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
> 
>         map->virtual = NULL;
>         map->bo = bo;
> +       if (!res)
> +               return -EINVAL;
>         if (num_pages > PFN_UP(res->size))
>                 return -EINVAL;
>         if ((start_page + num_pages) > PFN_UP(res->size))
> --
> 2.53.0
> 

