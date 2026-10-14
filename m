Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74756CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF41610E112;
	Wed, 14 Oct 2026 12:33:46 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276CC10E112
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL32y1WdZnSVNSQFZuoadFRe7ebZdqbJLsQr72hMCFP2hVRMcq8IOtzl0L3x3xlR5cRxu8NhB0K55DJZL3rtQTrizXuocXlw5ovkOq8zRXdzjNfXZSWRNp6KMbPEBh2nIuO4oVuoEF91F+v0zTr1cTaarplJG2ztAhYYxptz0gXHA6H7WH0a7ayJqzTF2V/Z3sZ+k+H8oVnt9I2qD2kWrL9GHubFLUpL5fc1GvvA2fm9ObIkM9o+qFQdh3NXVBvURbVrjYK/IRbL17Tk4Q/XLq7wjbF/828dpdPmETG17HE6K1aeoVKNQ1mhm9NRiCuOLX2HY6d+tCoMpJArPKJDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvxkm4rSNh7RtMSRGfkfRa7xPJlWbYJjmFytknBiwyQ=;
 b=agiZoGzIPc1WcUdFumH0iuMpPUAPRQZnhCOd+qbRqjTOoP0dC+i9Xy03euuFX9TuaIPvxtLq+/7s+w70mSdfjg5oO8rHzmsq+mrbFcS510dciPvROprV3Vo6YAZBS9qeFnX+UQk/w1w9M03klkflbr+7Q1yft7GKjFvSh8SInc5bFkDCWeR67tyaXfpVXOj01uYCQYDO6lcdBkCvHZSyDdsA3n9gOsV/mzDanzABemzZ/tkcZbAjNC0EezjXVYo3UfgY2o3YTqMbxDC0vL+QwQmIuIZd52It6bohGulqyEl40gglqBke643aPKUi0T7sVCTB1EUi8ExxL7qF1I16aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvxkm4rSNh7RtMSRGfkfRa7xPJlWbYJjmFytknBiwyQ=;
 b=Epifzy4ss602yRqv1zmIbZGvQr8UbZ2c5BPrI37TUKqjgQ7b/RM9TZ5HjQiHYkAjkRIXA3Z6kjqCxMez1pR5t9ldGIpv+Me8JxXairoH0aARJsqWA7W9lbpkPyrld40ef2HErlUhxNyNog+4DGBJFwBMkGVvyYrYfcDOHeadCXv3YxjLCzpctvGgmrpHX4j2Z3BuGrgXG3cKCdPdQPqMHUhOQ5XBz5EVnEBtKvJAi4vKEBShxytnpNp7lJFJTMXx2TnMz/e5JJqQLdH5DUObDCL9it9v6tBSRNFeVqfVJcKXdAucHa1S32UGbFdR+/VkPgNwoEnBwCX4ML8MQDvNzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:33:35 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 12:33:35 +0000
Message-ID: <ff7cd77d-a7c6-42ec-a1bc-3790aee8b727@nvidia.com>
Date: Wed, 14 Oct 2026 14:33:28 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>, Pavel Begunkov <asml.silence@gmail.com>,
 Taehee Yoo <ap420073@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>,
 Kaifeng Wang <kaifengw@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261012174300.2338784-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfe72f8-912c-4284-6793-08df29ef5d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: NbNeZXCm+gdHwETjAqi4vvt6koUpcvJqYKyVHnLfJbKrxWS8Aqj6051aHWPeuqkkTLGHUrdH3gMMWvNj2VV1R44FjVUtQXZLQPLEyKEtL3pI0Vu5QypDWs/HvqwCfl15BZGpzzNCRNkpiZjloV6hP1JvhZguXwUGT91kd5QL6EKscFnumpt4aJ4XDPw2D4mC66yoU1qUYLM1WYSR6vOiR0F5MIdGEw9avM8xg+sPilOMkQKDEbG5vMXQvn49pcZmYElMgy4OulF0/tRq3Pj8ci2/ToKsy6yCmpuhxWO18/s1CGnD4mEaKzCEZhRhOeDIHDVFwKn8UOlxIVDDi2eIHff3HcKdZedY+cdw+RH8X5h0OgDXcFbMj2E6MwopRpEHwrbQpxy+sjjhDMZVQlQnaQtgdJbgbgl4hC5vUvfa1tE7bmeWuHMwxbjDePe7O7xzgU97UYt3QCCmG8uA95BuKe2Jkps0vSRy8Z6FZ69uPDmpqqMh07UoMesx2m4iDXRzUY62IoKqorJ+JesgS2pEQAASFKfXiV2msJ+W28Vi6q3oY0+H5pw2xU/UH85CRzDymAlDJGoJMUmokt1xEZJUZvhGiEJi3DHEB1rWNt+/6epOKZSAK+r02OXWdAB2C3xV8yG4lr69BaBvN80YuSVV0qfQVYYAK9G5K7WZg+Wg0WeENNSwccjXBT67VFCHlkOnV1pUjEzzFOX7ZR1+agWbWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RTUTFSQVZOUU5hU0kvNU9GNTREeVY4RGM4SVJTalBnRHF1SEJFZGwxb3Ni?=
 =?utf-8?B?VlhnUmhmTEZ5d3NlelcvU3hON01JQjkwdll1V2h2ZEhlcU8vdDk3ZE1Sc0d1?=
 =?utf-8?B?Tys0aFNsNzN0YlNDcDFkYnJRcFpZeU9jSWZjNzZhUmtwRDRIcFlQQ1pPOXVx?=
 =?utf-8?B?Q1BnUlI0emNEWmlOODlzTE5PanZLOWNJcEJ4aDk0OHpHWjh0cDdxMmdqNG9F?=
 =?utf-8?B?VDBlUmQzTTF4VlgrWk9rWVV1SEwrdlpSa05rUVhJOUdMdmdBUDhlellVM3JN?=
 =?utf-8?B?VW1kcHROWEZvQUVJK01oY3A3OXdRRXp3Vm1Sd2F6Q3NHbGM4dVh2azRocVRM?=
 =?utf-8?B?SDJtVkhQNHQ0UXRPUXRHQmxnMWxvNjFoaXhQTTZvaStqWjBQU2U5Zk5uYmQ4?=
 =?utf-8?B?RWlmd2daOVhLMXovTjFYYnN5Q0ZRNEVIa04xMUtkdzVBZ3o4VitnN1E3c1Ni?=
 =?utf-8?B?ME1Vakl1STl1ZkRPV2pnQ3VJU1cxM0Myd01rNUx1OUVSd0pMVEZUOXFJcVZI?=
 =?utf-8?B?blAzeUVFa1VFU3BKTVRaMkdLVXdmRmdWak55U3duOW1pQ1JlOVlxSjF0cHZ3?=
 =?utf-8?B?MVdzay9sT3hXakpRZE5FOWROcTVCb3RMT3lUdnoydzZvNzJIdkt3WW5WdkpU?=
 =?utf-8?B?a3RaN3k4L3RoWVJ4LzFXYkY2ZFZaYnhwb1hxRTM3L252TmdzeCtRekRNQ05G?=
 =?utf-8?B?a3p3c05jSmROZGk1VS9IZ3VBOUdTWXV5YUZPYVNiVE5KVFhWYkIxWWQ5b2M3?=
 =?utf-8?B?Z3UrMThLQW5yakNIYVdXbmd4aFRlQkUvOTFMTS9penEwUS9vT1lCZDl6Y1lW?=
 =?utf-8?B?bkp3UGhtRjlEWFlLcDJQTlI3QUJsejA4bVlzbE50SWduaEZSOTVVVnI0NmRF?=
 =?utf-8?B?UzU1a1phZzEvWDBoNDZNamtpc0x2dlF1T1NNbTZvMnJuRzFUUXZsOGlmNVdv?=
 =?utf-8?B?b2M1SjJRU05pQVpNb1lzSUlQeVpyM0dud056bGJVVElGNFQvc2l2V0JtaFlN?=
 =?utf-8?B?UkhzQVRlVFJoUVkwNktTUTdERkY1NlNUbGowL1ZFZjBLcXdEM2JnK3M4Q05S?=
 =?utf-8?B?Y1MwTTVtalVPOHBHdWtUL3JNb1ZUNFcyZGJTZkJzcGRVYnQ5cmd5TUJrdmJj?=
 =?utf-8?B?V015ZGk1MDZhMzhuTkpXMTRkOVdWeUsvVHV2WEQ5Y1E2T1pzL211V01FNmJp?=
 =?utf-8?B?NG1mY0Y1L3YrS3VsOHVqWER1eVg3UTF0aFN0RkxTVXJtQXEwcFdCN21rZG1t?=
 =?utf-8?B?akJ4QWlIUnI3MWh1Z1ZkQXVUeHJGMFJSbExkMC9md21JcEhxWmUrZHRkV2ZS?=
 =?utf-8?B?R1Q5SVJGK0o4OHFQREJRWFErdDNzcWFkMFErVkJ3RXRscGVuN3FXVDdvV1VX?=
 =?utf-8?B?Wituelcvdk5HTCszRXMxMlRTY1l4czFQd0EzZUhBcEhEM2xIVzA1d3VMbGNh?=
 =?utf-8?B?V1MzaDVaMkFLbyszQlQyU0FiOVZ0bTI4c1JMdHF3bTF1NGY4R3VhT0NzbnNo?=
 =?utf-8?B?YnVoWW4vcTlLWlo3T1IvQnpaQkRrZzNXVEJGcnhlQnBSVFFaQjh5M1dncmFx?=
 =?utf-8?B?REh6V3ZZMG9vZW1TSHpSWmZEd1dyMDhtK3pjR2tQZ3FuQjU5bmFreHZHTXZh?=
 =?utf-8?B?MGpQbDdBeWdSc0tKb2hoRE5mQjhXaTcxVmRxcDNVb0Y3S2h6bWdITlNFNld2?=
 =?utf-8?B?UkxtRHFVaGJFNWVyb1ROR3NacTRxaGVRNld2Smh4TWhDWE9aM2RQZFFjcm1h?=
 =?utf-8?B?cElsTGh3VXZ0Q1JWL05zR2QyNzkxeHlPUGd0RWEvOHdEV0RhejBqMC9xOHdN?=
 =?utf-8?B?VGN5ZlF1OUpsenZTN3JZdHU5VmpCVjhGTE5YWlFFYWdpa2dUWnFLeTJRWGMx?=
 =?utf-8?B?eDBGSnVsOHNtQ0p4dytyc2toRGk4SU4rSFJ6TWZRRStHVzJ6UVF4bXJlQzI1?=
 =?utf-8?B?UUxyY2hzNmV2d3dxaStta0VMaG5oQ1BOdTlsbjMrcFJaUS9LSUpIakl4YTYv?=
 =?utf-8?B?QWFPNFJXTzZqMWQ3TllSdFQ1Qzc3TXp1ZTJDOFJUWkdlbHpHaitWV0lHR3Ex?=
 =?utf-8?B?U2RNQUZhMEtUNnFKS1pDbnpUKzh4aXM0dExDYjR3SkkwNVloYlo3Snkra2Qy?=
 =?utf-8?B?V1J0TG9PRlNwRTdFSTJkczNlQVpTeXVvOXkyQ0phb1crdHVZa2FGS0h1MVE4?=
 =?utf-8?B?d3Q2Sjk1dTQ1WWQ2Mm4wYUEzcmZWT0R2NUFuaVdyMFVQcWlzbldTWHFHaWd0?=
 =?utf-8?B?RUUwTTRCb1lVeDZwM0VLcGVGc0E2SXBRRVpwWmJtOXoyQXhTTC8yRGI4MHli?=
 =?utf-8?B?RGtlSGovNlkxV3dwT1hIVFFHaXhTSXplZmpLUnRObldHRkRYODlvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfe72f8-912c-4284-6793-08df29ef5d8a
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:33:35.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaM9HOonUnyNMJhYfSPtVd1jzrGW0g/WrFjJ8OU1J/zAKrT3ho9OQUYY/HJAN8jhrKujrT5dzP5u+zaIdCPnTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
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



On 12.10.26 19:42, Mina Almasry wrote:
> Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
> add netdevsim support plus selftests covering both RX and TX device
> unregistration:
> 
> 1. net: devmem: unmap dma_buf synchronously on queue uninstall
>    Synchronously unmap and detach binding->attachment under binding->lock
>    when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall(),
>    and unmap RX bindings that were already unbound on NETDEV_UNREGISTER,
>    preventing slab-use-after-free in dma_unmap_sg_attrs() when the binding
>    is freed after dma_dev.
> 
> 2. net: devmem: detach TX bindings on NETDEV_UNREGISTER
>    Extend net_devmem_dev_unregister() to fully detach and unmap TX
>    bindings when binding->dev unregisters, or clear binding->vdev alone
>    when only a virtual device unregisters while binding->dev lives.
> 
> 3. netdevsim: support devmem RX and TX bindings
>    Enable PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM, 64-bit DMA mask
>    on nsim_bus_dev, and NETMEM_TX_DMA on netdevsim so devmem RX/TX bindings
>    can be exercised in software selftests.
> 
> 4. selftests: net: add devmem RX and TX netdev unregister tests
>    Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
>    to tools/testing/selftests/net/nl_netdev.py.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> 
> ---
> v2:
> - 1/4: Don't unmap when a leased queue is unleased. Keep bindings in
>   net_devmem_dmabuf_bindings until freed, hidden from TX lookups by an
>   xarray mark, and unmap unbound RX bindings on NETDEV_UNREGISTER. Update
>   the binding->lock and binding->ref comments. (Sashiko)
> - 2/4: Detach TX bindings from the same net_devmem_lock-protected walk,
>   which now also covers unbound TX bindings, and clear the LIVE mark
>   instead of erasing the ID. The walk no longer uses RCU or takes
>   binding references (Stanislav).
> - Link to v1: https://lore.kernel.org/netdev/20261010025532.839559-1-almasrymina@google.com/
> 
> Mina Almasry (4):
>   net: devmem: unmap dma_buf synchronously on queue uninstall
>   net: devmem: detach TX bindings on NETDEV_UNREGISTER
>   netdevsim: support devmem RX and TX bindings
>   selftests: net: add devmem RX and TX netdev unregister tests
> 
>  drivers/net/netdevsim/bus.c              |   1 +
>  drivers/net/netdevsim/netdev.c           |  21 ++--
>  net/core/devmem.c                        | 121 ++++++++++++++++++++---
>  net/core/devmem.h                        |  10 +-
>  net/core/netdev-genl.c                   |   1 +
>  tools/testing/selftests/net/nl_netdev.py | 108 +++++++++++++++++++-
>  6 files changed, 236 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 4f6ac74fa594a918d41255c941256e1d51592d3b

Went through the series and it looks good to my feeble human brain:

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

I am biased though because I need Mina's code to add support for
unbinding the dma device for data-direct.

Thanks,
Dragos
