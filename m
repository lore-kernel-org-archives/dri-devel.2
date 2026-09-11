Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3921C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C39410E0D5;
	Fri, 11 Sep 2026 10:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uM5K3iMK";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B3D10E0D5
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0zf+Wo3fTDI/Bypd5tnfJuN+ASDvbgaDnAFAsf/zkbS9pHCc9BV5oIgcn2DYOYF5HasOdbi8aVEk1XjDSaVaAPT9FhBbQbXJiyeMwRIHngsS6hlKKxgs9iKZlxYfnGPu0M5Fp+n56QqYEyHyCaUWgDNFAcZm4CTvH0DW2Yyy3c4nXXs5ptqofuuRNJAQoim3Gez5p+0qjVMLyY1VYFoDcbE5IxYBibaLymE5NB7eVyyiUegDkrgjeKwjKSqHLBsEZYn2k5DoEapk1DOr8jiIR9VE6G/0TQ3aG4+v5zG2bGXtuzFuYWq5JXHTfLntS6oD4OXntzBYXFUqHop4DKIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLOAxBC42pew/9SKSiUK64b/G8BsmXRwsQMPreYA2io=;
 b=eLcTU0qLA7crdqq/UFvtCemiAZGx7q3/IIdQoxVH++mt93GKoTxOTTJXyeo3RCEbk+bS6Cj6WK/ul69hQHmHRdNBbxcetNEyHy+pLfaO87Gv31rD+9jOy9oBRkX2vhNQXnEvCUgg3akrGSFCShosM+RZ5s0tFd0vWKKqsHT7zP8ZdEqr0e5qdwh4Xy02vfO51m3RJX3iZgt7kcwuSSXmUS0wit7EinUhijbcvyt5s+NF/NWaD0hi25a2wlgFndrs/9JZDBZ4dja7jvw+GM5wgfAJeDiTNk6Ynw1DubbiL60Jpp4A3yBsFgsv6JFiIi2eVDtS2N4wkzPPv7O8oJ4eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLOAxBC42pew/9SKSiUK64b/G8BsmXRwsQMPreYA2io=;
 b=uM5K3iMKqzo+d1jj/08YAkMWxzrFwI6sCKxU8Iutiydoa/dlbtKzZ6foYNaWpe8KcAk/SudFbOk4lvytklbZTdXVVd5AWAk9Zmn2u87RTv70foXmMY3R93U0kF38zqGvwiUWchy14xlnlMNZS90/MLacLY7l+A1mYXtLqCmUrU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 10:03:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 10:03:52 +0000
Message-ID: <f885c2c3-7752-4142-af49-02475f5e08a8@amd.com>
Date: Fri, 11 Sep 2026 12:03:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL
 kernels
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20260907020015.24719-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260907020015.24719-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: eebeceea-4195-4f74-36ec-08df0febfbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: p450QnGUu3BrtgRmPhzALIR3e0S7+Z+f/Bn4DJ0L/pvqvMQEeYrvGRnhXzpELSjuhjYE/sELVHVkN+NSAUJPmTObbepxZwtMYD+o1eHkMVZ3ChL+Fq0/Q9IsxZAkvUDCD/Wee8IekLi0t7bKt4qBl7AStFpeBrBQkvc804v/C06kdHepwNdqKrBud7QMGdU8Pu+zP+37CfTy8ycP8KeODeyFLF/ncJPO82JaN2gKqLxluNdL6e3qjKvVF0iRLtZROzqpD7XbwCD3B9rZHMM1KnY23L1MEIzxJBEENg68rtDCHbXRFEz0VeKCLPs/PzmUt0JUYfMBBpgP+k2IVDtAjZCk4bIt8zrTWFeEgh/UQa03XWLwtFE/N9nESwPm2aHE4NAVPmRdo3sfVRybkXKydymD7rhor+FtKUnWmKa1BDEOjecJ2XGYMpYPnSnr7XEMQglELULApgU+jZSudk+oSbVBExA4ZTuex4YhYOlFOK4DrEPss+DlIz3XxvuMcZaJPy6jgJ+NSlFWVbjgA+AezqvxYx4R+HJ8oWCC2Hw5m1BY7SYo8N93/aQLuvJuJnd3Y8s0lrrjWpUy+GU7fhMDQmbs8TakhSw9XVJaIXttOLPZ+r+zgFMG6dXlsI6YXTjg9B7tNFBd/pbNdSwlnCXceA8b2jFgGWGzYUqFh2+kzDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0I0L1hSNVlvQ0RRMkZnVnpYSDFyVkFNNzVPQk8wLzlNaXdCaldpd0ZGeDhE?=
 =?utf-8?B?cHRac0xjZ3RDY3U5LzZwRlV1VzAva2FlSWkyWUZHSDN5WEJoa2h2SWpza1JS?=
 =?utf-8?B?TU9ta0MvWTRaRlQyaE94UTZqRkEycSsyaE1OTkwwNld2R211WkVYNTROdDhZ?=
 =?utf-8?B?SFR5SjZoN0RTQzBaV1lDTFVOQzBBUlZMZEpPOVFSNnplRkpkZVRyTHVoV0ly?=
 =?utf-8?B?ZUlRVXVaYi9tRnhUOWQ4K09iaE9kQnZBZlBDa0hkWW1rWW04K0d1SzRERE9v?=
 =?utf-8?B?MjdKU0F1Wk52SzlqR0x3VHBMNW10SE53MlVIS1k4Z3lQWHlYSEtTWXBWaEly?=
 =?utf-8?B?ODVYQ3BMYWo5WnpIdXY5cTZBaFlsT21VclJjaVBwQVZJck5FZzhmL0FyVjBR?=
 =?utf-8?B?SHNQbk5BQnAzT3cyRmtvSjhxMGtPVUpoMnJkQWFxczhXcFB2S2VUbDhRckF5?=
 =?utf-8?B?QlpUaGd2ZTd1aTJ5SHExc2dQbzRWd2tCNndIbjNsVUltWmF5eG0zZGI1Nlly?=
 =?utf-8?B?MG5kRlpzSXp4YUhvZ0tMeGVwQjBPQjVjU2NVb3pTK3pHWjVNaDgwRUlLc2Q5?=
 =?utf-8?B?RWMyRHJ2M2U5Vm5jTUdSd2VVdnZnWTFLa2EzVEgyeTZjWUsyaVpHQWprZFNW?=
 =?utf-8?B?WDI5Mm44aXFxdGxUWVVybzk5QzVjYlFSdlhVdkJCelI0YUI3UmNpajk2U3BT?=
 =?utf-8?B?eW12am1ma1IwUlBKdXJ5ZkRlVStTaHpUTDAyWnVYNlFXRUhwb21JbFpYbklo?=
 =?utf-8?B?LzY3VHF2eGZxUTMrSGRlY3JZR0pTOXhzMDJxMkxnSHhMcTRjZG5FK1orTzFH?=
 =?utf-8?B?dDdQdlRhUDJxb09CWTRseHVvYi81TDJLcWEvL21DN2ZyRXNKOWpsZXRndG96?=
 =?utf-8?B?YXhtSExRRkNuMk0wZnJ6WGdacDFOTW0yMnNjWktmZzh5cnRnbDNrL3NINFlU?=
 =?utf-8?B?aDZya2hOMFk5ZCszdWJrdS9ZNlZNbmYvcXZkK3BLdWRyZXVhTnJ4UnFWcXV2?=
 =?utf-8?B?TFdhM3BWNU1mNkh3U0t2OTBsMFFBcGdIWjJ1Ty84RXBFbWpDc1NRVzNQcElW?=
 =?utf-8?B?eTg5eFJGZThoQlNySlZPRHg4SHRjZ0ZyOTNpV0pPMmFrU1ZTeDA3RzJHeHAy?=
 =?utf-8?B?TG5uRVp0cDJMcDMvaXV5RFZSVm5sb3BFMnI5M2toMVpUU3l2bFlOcWtXd0Q5?=
 =?utf-8?B?ZVo4SjJtWVV5THppSEFBckpveGE0blZEMzRqa0Z5MWJkbFFnbjZRVVZWYTNT?=
 =?utf-8?B?YmVpYUg2N1hkN20xMnJJQ1hORDh6SjV2cHpTeGh5bTRYWVpFMFEvY0RocDRs?=
 =?utf-8?B?SHlZcDI2M2JCbmZqU0UvS1A0bDVCc3BJeXo5L3crOGZUemRPTWh5QU9aMkt0?=
 =?utf-8?B?V1ZZL3ZkMHhQdEZDSmMwdTlDcmtXMjIxeDB2ZWlzMUtUMzVjY0RNZ3I5clB5?=
 =?utf-8?B?YXMxd290VzQ5YVRYZGVlRnpqUzUzMngxZmFwK09wRS8va3UzdHA0OXRpcFM5?=
 =?utf-8?B?c2I5ZXBNQ0NFZkp5bG1RTVBOZC9FNEhHZGxWTEtTNGh0YWg3cjArM0VIN2Fl?=
 =?utf-8?B?SWNUaWNnNEJCdWJrOENlajRFd1lmMXM1R3dvTllUYU5pVUlDaVB5TzVmQ091?=
 =?utf-8?B?MUtaQXBJY2VDVklBSXBhRnU5TmJhem9sZjRGeFpSNFVGU2VrejRWc0dtVXAv?=
 =?utf-8?B?MnROS0ZVU3BjclZ1aklKZjRzeW83R3owdkJnZ3I0dDVKOGpucWdPeE9ZNDZ0?=
 =?utf-8?B?bkgzRUdmMi9aQkN4Z3h1eWJiV0plZVZvODhNRFRqZUprOWVrbVFYQ3ZyQVlC?=
 =?utf-8?B?YkVtUEhUT21iQWlNMER6WUhUZEdPWkd1cG5qd0tUY3NnK2ttR2xtMEhJLzYx?=
 =?utf-8?B?OExuL0VVR05PRURiQms4NkRyUU9JSDJNMGo2eGx4ZndkMFRURmxTS3JsQzR2?=
 =?utf-8?B?Sk5wZUoxUk12ZjFxZElyNVo1b3krUW5rVEw0REo4by9STnBTaFZtVXBTTGxN?=
 =?utf-8?B?Y2NVU0N1TEF1SnA1TFlHcGRydXZqaHU0b3R0OS9SbzBBTFpvM3JuVWdlUU1K?=
 =?utf-8?B?U09uWE1SaUl4eFRORkZ2KzBUTUNhMGE5V3QwSkYxYVZjZW9BRXk3MGhQSkdE?=
 =?utf-8?B?RE0zQUpidHQ4Vlltb3hPRC9LYUIwL3kxK1pXaEswYktXQ04xMC9TQ0NTMWEy?=
 =?utf-8?B?c1Y4RDkwemZVZ0dQQ1QzWVlpM2J6OWo3Tlk5Mzd2NHZCRlh0UTE2NnlNUmIr?=
 =?utf-8?B?eFBwWitDOXkxU0hYbVBpbzd2MkVCdzBmdm1ONmRiS3J4Zk9wVWR0Vk1kbnha?=
 =?utf-8?Q?GX+S4zY1T2ay7maI78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebeceea-4195-4f74-36ec-08df0febfbe5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:03:52.9160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utQo1nR5oFtSku1XtAKpcRbO9nB73bnafy8d4u7/Vt4VedVExiUcovToZejjRHXl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

On 9/7/26 04:00, Karl Mehltretter wrote:
> Commit 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG
> kernels") changed the default of DMABUF_DEBUG to "y if DEBUG", but no
> Kconfig symbol DEBUG exists, so the option has had no default since.
> 
> Use DEBUG_KERNEL, the Kconfig symbol for a debug kernel.
> 
> Fixes: 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG kernels")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed and pushed to drm-misc-fixes.

Thanks,
Christian.

> ---
> This enables the dma-buf debug checks on every CONFIG_DEBUG_KERNEL
> configuration, which is what 646013f513f3 set out to do. If that is too
> broad today, the alternative is to restore the previous
> "default y if DMA_API_DEBUG".
> 
>  drivers/dma-buf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 7efc0f0d0712..e4f078a326a4 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,7 @@ config UDMABUF
>  config DMABUF_DEBUG
>         bool "DMA-BUF debug checks"
>         depends on DMA_SHARED_BUFFER
> -       default y if DEBUG
> +       default y if DEBUG_KERNEL
>         help
>           This option enables additional checks for DMA-BUF importers and
>           exporters. Specifically it validates that importers do not peek at the
> 
> base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
> --
> 2.53.0
> 

