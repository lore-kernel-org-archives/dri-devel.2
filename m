Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7BCF9D0E8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B996710E633;
	Tue, 14 Apr 2026 16:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b589E6R3";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A3D10E633
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQC9gVspmsSQo1EGqbqR1p26gRKr7thqjJ2gjkcwzWCg+aKjnO8RA88itGEVePhRvyJnoTLilfPk6NWHuxwLEKlJfiXcEl5/nzptyfqbjEHW7l10M9FrIMfac/xvV3FJApnaXwMq02BUdcXO5qgHSBGSfDV7hHM+gi4xngSoIEyCuLIciMJBjV/QTprVRJsDH2cGMqqEgBH6DaWE58XjGPch5A93mkudzJTBh28eEEt3Genwa/IGQNWyoIwJVV2ZkBIkoR7FHA5Gcd5qIDVXFdOl8/F+es8Da4qjr6SWqorSK8Xzdzz3aGuausfNFPTUtHT2Na4k3bM2FXcYMbhjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdNZKb2BLxhkWvXXO9cnGwU4Pk24rShaY90RE0QmZFU=;
 b=BUkyg0pd5cBCtobBLshxGhzWfr7Faen/DGh6se/iq//16bvjQdV/7dB0m5GZk3RaNFCxys/i5iI3YeCZ+X3p1QE0bvZd4hHUIG+thAsY7GGGbvWgCQXCq6l8zIHWWOFyqY2e7KTPRSRujVhOVIDtuIdANXGMHV6P9b0yIf2gwp4wNWOeP4QG1sV15jy7fb6eEuO0/OH3dOGOeZKHmAlAvxOrGWW1Dr+Ct81OHJN0iuMv2YBPIWAtu5OF2oQxpJOb7euTyl35kCychmXZ70YeVdYukGGGoLv3ere9KArZHpdvxoqEX/Ky07TmfqKDfafem/UvGvlKM0oFGOoJ2oMkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdNZKb2BLxhkWvXXO9cnGwU4Pk24rShaY90RE0QmZFU=;
 b=b589E6R3clExJAyQyT5CLsNmJJelEnWDqd0zOC0D0WUw2vCsEjf4HHphUTHh91XcD0p1S3nwXs8etyswDUuqAkbPwK2Koo6a6FqqMr1MuDhNGit5Fe0aPmmVLfr3HHgcIyEy3S2fBimJZcL/MIl54by6y5dy9L+uPVdkwY0GrMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 16:59:10 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Tue, 14 Apr 2026
 16:59:10 +0000
Message-ID: <19e31c05-4ae4-448f-a9fa-7961230a2349@amd.com>
Date: Tue, 14 Apr 2026 11:59:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix fatal_error_info layout in firmware
 interface
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260414165625.788853-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260414165625.788853-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a382ec-19ea-43db-d7ed-08de9a4725ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: wlQaGuevsfQasQyXpYNNVxSORNfhlIG9NSOoAX3EXZuaG81s6dWi/JUHnUox+8eamJKjgZ17abLs5PxTTwMU6EZkKwK6UgmTLEkXSKPhA1RKTRjL65HwgmY+NubaUc6dy8nbP09amq1cbv8+visp/bdZaB6gwYrfUJv9f3dQ2Om+Ns0foXZcwiT0h4P2M6OkNhVjEsHq0Q1h7hcblABXEJvM1GtzqWlaXXo+TccDVZ677HwV1wtPISOiU8vPp5DVFYxJXRaI2zYcLRdLXznbYyb85tY7wpwG8JPG3kqdlhVp2RdccVp2pTrXA6YnPvqlHmFSuJPe4A2Qxv9mwcAaAil0h54jJL6t74XesyNCHocK7kFchJB+SdhFCd73II4n1D0T5YPXIwa8nze84qf7cPID9pTUuR5rIQh7en3IvKNXFNMQdTSOyGW5pL6apcubBRhwrCPQXRjc7g1ZAEDw1QrdzMByiIiIh3zNJDLnonBrbyKbCvmRnt/NuH5zrSOywLssqvVFpDetkC7Z9HvCTjRQQ6PX05BDCH6SxdK4k1Sog5OhGSGftH/njBFqkf/6WOxcvh8flA/zX9lxcixT9qnG1ars7NOGr7Gd9Bg3pRPHTqvHblCkJ03Y4Dq+YZEwI8br5W15m7aAFNEm3ix/HYogRiTDCu/sYrSyHaIN4+FrqsIUlx1UMAzzIZdoOYd1kEdYL46Cv74MKI7th1H4aKdDW4MnsE+qya9tvHcalac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZtakFsWWZLWXlya0hIdmlXVit5WklhVWdJRmpPWUZSRmQrUGpTZVFjZDJp?=
 =?utf-8?B?K2o5REdHTHRwUGRNc0Rna2ZSVmU3dFVqMmZzdXZPNTJMYnhid0lwYTFsc2xE?=
 =?utf-8?B?UFZsVjRMMnNaN2ZhQWhwRFJWek44Z3dyYk5ZTDBkNUMveWNpNU83SDJnZk5W?=
 =?utf-8?B?d0FpaWVhcGNyQndCL0E1VGVZM2ZubTRXeUFicFdPK1hJU3l4S3QzYlEzZlF5?=
 =?utf-8?B?SmVIU3JoTFdxZjRLb0hsd0EvUEFZVTlkOTB0aWk3NGRHanlGaEsvUzBUTVIx?=
 =?utf-8?B?bTRjR0tZckEwZmpiRDZJZHRzWTJ2WVBkdnQrL0tlODJZMFVDOHc0Tnd3cVdD?=
 =?utf-8?B?S0dSTitzRm5POEsySnJHUC9FT0p0OEFINDduWm9NenhpTmROTUxNYUtRbFg4?=
 =?utf-8?B?RXJxclJzVHF6MElrN2wzTHIxNlFtbDRHUnRrcnlWUHR6WEl6Nm1IV2VVeVVW?=
 =?utf-8?B?V3BGSlNmT1VSR0crQlJOZUFvTy9nR2VIMW9YRmVmcHBqSXpmeFVvUURxUC8w?=
 =?utf-8?B?K1dGZWRHbS9TSW85U21OcXdSZkpUMW5UM2dXWUlWVFUvMTdoaVVtZkFFbHZL?=
 =?utf-8?B?ZGxPWHg1UElMeTVzbERKVUVZaEFBVHpMNGZKWStEWFNFZjJ6T1dGWkJ4UUs5?=
 =?utf-8?B?bStnUnJOYVR4QzZvT0xJdVZEcmdWMElnK1cwWnN5dXl3NmttWS9JR0I2Vk8w?=
 =?utf-8?B?RHNMeVQyUmR5WlNmQkR1SnRNL2g1aHVhT213alBrakM3K1BZT3hMSU04V0lD?=
 =?utf-8?B?VjgwZlkrbUE3eWNSaEQ1d3h0MzdzOVRjYjlicFBxc3JGa1o0MVRxVnBLLzB6?=
 =?utf-8?B?RTJTeTcxL3hqRmN5SWpySjE1VTFxV09EUU1yRkRHZ2UxNTh4Y2p4ajFySDQ2?=
 =?utf-8?B?S20yb1p5VkJJY0VIVE92eWtoYWI3K05iaDhKTkVKSGhCdVpxVEVjcW02Tksy?=
 =?utf-8?B?b2JwdUcyYU9Ob0x1bFFzVHBlRml6eEdVZDlObndmVHUyelUzS2EvTmpaWE9n?=
 =?utf-8?B?bzRXVkJaaXhZZW04RDk0YW92V29qcFFSUVhwMzI1dnNCQVF4ejNLTlJtUnJJ?=
 =?utf-8?B?VjdWVnd1Ujk3bU5vOSs0dVlzN09selVmT29OeWRMM3hKS05RMGFBekNUb3BX?=
 =?utf-8?B?di9RVlBjalBMRVdtZm9GT1p2SnlyNHVnUjNZaHhOR3JVNnl4ZFUyZ3hsOWty?=
 =?utf-8?B?RVZUZ2Z4YVowUytSdmEyUzVoVjZoN1lCWEk3VlhvWWhjWmZ6RUw2WGVXN3lM?=
 =?utf-8?B?cEV2cytPVXd5YjAraC96QmtIczArNm04emRHaXl2M0sxdzkybmZReEVmY2wr?=
 =?utf-8?B?YWpkZjBsQUl3RW9MYkZwMGxNUmpqSXFYWTRqeUgzRWRFc1V0OWFYK2NIa20w?=
 =?utf-8?B?WUUzOSs3bEh4amVqZEZJUFZmNTlrVXBaWG1KY29pVkJBZkRDWThQb3R0NzYv?=
 =?utf-8?B?eVlkNTRCbGhaN0hIZ0xFQjJYQVpIQmZwaFd0T3ZQaDB3ZXIvWHNDd3RHYktn?=
 =?utf-8?B?UlFvOHB6U3lCV2xUTGRzV1hYbUJhcHNmdzVYT1B2eWs4ZGRNRWZ4aFZGc1Nk?=
 =?utf-8?B?Y2NyeGN0cFh2eFRvMzMwL29PTmI1ajAwNWlyY1ZSNXZXQzA2Ui9QYWZyVWJk?=
 =?utf-8?B?cnpoQjZYaUVTaE01eU96WmZFbGRRclhlSGF2S3pVUE1vZFl6cmljYUZyWW5j?=
 =?utf-8?B?Y3kxUEFnaDA2M01hR3FFTkJVcUh0Z0ZON3UxMjV1VzZLblhCdWRXTy8wVXRl?=
 =?utf-8?B?NW0rZU1FQWFpZHNUZmJBOWViMDB2UmtxbjU0K0Q4N0h5OGxvbDI0MkpWTWpT?=
 =?utf-8?B?YkhVcEh2eUp4em5Vb2pQNVpFallvR1MxNE5ENGVwZzN1ZGZNdGNvZzExUUtj?=
 =?utf-8?B?UzFjSURvTEJtNnlmWXJVaU11a0Q3eHpMeUh6QWJhdXlEWVM0TFNQeGo5b3A2?=
 =?utf-8?B?b01sTndZSGZmS0R5eGVsd1QvSVUwMllwSVZBbXlQakhQc0RzZ29YeU1nZldQ?=
 =?utf-8?B?bSs5eENiQ0FIb2FXZ0tFQitDSzAvbm5oaEt6cEdnNmt1Nm5TK0VZTFFxVHRO?=
 =?utf-8?B?ZGVYNCtldDBqalFnS3A5OGF1em5UY0RJcGpwMzVGTVBqbTEwbFREcEUweVFR?=
 =?utf-8?B?a3dWVldzbDlndmJvcFlYeWN5WCs4cnJKb1BmMDRtcm55S2NsNGlaYXE4SE5N?=
 =?utf-8?B?S3diQ0VkdkV0c0t5MEdtNWM0WGZTUklQMjVaM3AwZG5CakJNbG5Fb21DN0Z4?=
 =?utf-8?B?bFZsWVh4K3VEQjlxUWJHcWZGWDROS3hRdHJXcXZjVS85eUprTC81YkF6cVpO?=
 =?utf-8?B?Y1RPcE1nQm1naXhTamVFUnFuaDhLVVAyakNSM05McGhOcEhkcHVwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a382ec-19ea-43db-d7ed-08de9a4725ed
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:59:10.4072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut+I8dk+bFCsiND/u1vIOxpksdUOOsUrxXXdUXrenRqONgRof3ATD2bk47KZxcyyU5h0iPOK1MUHMO0ey+lIYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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



On 4/14/26 11:56, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Adjust struct fatal_error_info to match the expected driver/firmware
> interface layout.
> 
> The structure is used to retrieve debug information from firmware when
> a command becomes stuck on the device. The reserved field currently
> uses 128 u32 entries, which makes the structure larger than intended
> and causes the layout to no longer match the firmware definition.
> 
> Reduce the reserved array size from 128 to 127 entries so the
> structure matches the expected interface format.
> 
> Fixes: 25854131c04a ("accel/amdxdna: Support retrieving hardware context debug information")
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/accel/amdxdna/aie2_msg_priv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
> index fc2e99510980..b10552c627ee 100644
> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
> @@ -461,7 +461,7 @@ struct fatal_error_info {
>   	__u32 exception_pc;       /* Program Counter at the time of the exception */
>   	__u32 app_module;         /* Error module name */
>   	__u32 task_index;         /* Index of the task in which the error occurred */
> -	__u32 reserved[128];
> +	__u32 reserved[127];
>   };
>   
>   struct app_health_report {

