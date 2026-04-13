Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF99F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F6C10E502;
	Mon, 13 Apr 2026 18:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GU06mTyx";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5B610E502
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGNHpmps5OJYBL5TFrwpvT+Uym5JYpRShd+Qp5E+7en3bxPF6GevJIe1ALaalkP8USuuIpDA7Em7ht4N/IH6FCkc57csC2lNVbaA2v7Bs5LmVLIZ7RX4li4NXRLf4NKK2jVxCjSSp0V/PxweUVv32yzdKBPwGQcO1tQPFxfsXfmYqSoH7CWgN18J1Q0tf9vYDcyWRgbadxCBtiEvJa4AUFmkOcgk+Ay1hkf4PyH7alChK5dm6oKX4dFDM89QahHAiMPhbwMzVFImE9mi/ANIOKyVRQTYiLpIqpIUl/3LTV1oIdG9aTvNEApI0RPSZ9KP36MLTp6nwYsvN2A+D6WiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBFi9Ii4CE+678NxjhMGZsVooes6/1qf72DEfm4hOc4=;
 b=EEjoj1JaQgAVnS3f/MePIc4X+RGUI3I+Ou9fOusWlwcxJNp/mo23nJ0l1t/cGTB4sqZQADsvjEYiiLfFxkH27wgmBoDOkELTu+ujRtXaCNGsRqX9G2xOWSUxdCbcPmLYVr7GZKMkbMIKrUFYk2bb5OVEh+vBUcHb5ov0L91M+AzvcVPrXhJxu6di8L7s5ifcmdKEgRgwK89Z8HZjgCkB8kiqt6KbmjS7cz6/TvqL1VntlGah7JDgzp/EJYdSMa26QDSU4QWvGYlXxVd7pfx3K9JeNlvMKQVyD8Wsb3O0tq3nB4geie4ku1Z1EfpWc1S6I1rXCTKsZ1i8UR+8dWrB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBFi9Ii4CE+678NxjhMGZsVooes6/1qf72DEfm4hOc4=;
 b=GU06mTyxLjwFQufCXWM+sTUtX0/hgoQKq/VlZYJXx7250YhMIp+cU/Nx6cJHkhzMMT8o7hJSC4wBzf6EuNpjNedm4zYPKiBGF66seAQm5BjM7ozEODxB/LAr/k9iljamLmnXac5VlBkT10KgFjchcf35RXWIxxYnSStM1IOSIck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 18:27:26 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Mon, 13 Apr 2026
 18:27:26 +0000
Message-ID: <620d8ae0-f219-4698-b8c3-72143e7cd30c@amd.com>
Date: Mon, 13 Apr 2026 13:27:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix iommu_map_sgtable() return value
 handling
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 Dan Carpenter <error27@gmail.com>, Wendy Liang <wendy.liang@amd.com>
References: <20260413180238.668441-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260413180238.668441-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: a999ca48-2619-41ce-20df-08de998a502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ofl4TWIm3i9rQp4HvaLEQcHVg0JZVodsy2NSQAAQIFUimVK4RAu/iJ0r99jhqQtEkwV2BeQ8DVJ7A8toOMbPZ35AnVHttGoLhd0hKS2+3QHFiL30uHq3epAeMlCapLKB27v8fdDYXSBDRsDVpig+rRWQjTxZtI4rxrnBJdLiL2n0w+cP1OieKeABKxCX3oregoJMF9bvlxbwA31fz/U4WBbTkFdcHAnVFz9NxsywjkgTskeR20nR7cq4x8CCjt8OYKvnTUuiwgsF6e2C5Y85h257+ruq/q+yiUHAj0SDhX0lTBf6BuTK+ic5KcHOmydtk4Af3Q9QuM+JnrOEsz2DfMYVLqozLMIumlBwf6lrGh92DMpDohwcgis5Nm5A6TnT/1y4k/WFV+Ntg2i4SQLtpcVhZft65h+faicXEv4VGSq7D8BF+Vja4tTl7NrQfcByaVk6Uphm5JoDpLm8Gr0mR3AbI/lTXnTwHC+a5fZUBY4f6f1fa54EjEbGCM9pE7dNe9Tml5F3TJBOH19XsK8M0gsAWpkcMQrPTH5PcAXy65cwOQmvQ2CL7Z+EF9breCDt6kJLVlpLT7I8CxUGAD/J3HWTG8cQGl9E++/kCQA2lEy3NyAAFwxfMP5hd7u1WNdr5CeJLGFk76ywwuBxp7dqpV/zoUFSJYGAk/pkB8/EgexiWEGpYJedcQwWPR2qdTR+i31WOShTHe3ibnRwDAmbXorNNFbvaxhzY7HeqVf7L5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1N4cUt1b0pCTkxwZk1IME95Vkg5aU01ZDhwcGVxbFRPdDVSUUNGL2Fod0xL?=
 =?utf-8?B?d3pDeDZNN1owRUhtT0ViemphUEdUU292VU1QVmI2OVRLY20wK2dCT01vcTYz?=
 =?utf-8?B?OVFmVjhFbFZHNUhvN2hWN01MWkNNOUZEaWh6c2tRbm13Z1phNjRITE12MVdZ?=
 =?utf-8?B?V1p0dDliWVpwNThpRi9GUXVaSmhuSjY1bW1jRElORVAxYm1ocmFSb280SzVm?=
 =?utf-8?B?eFVrQmVMUXEzTGNMc3dGdEdNaTdHTDNYeEI5M0k2MkdiUHZ1RWlzQ09NSWJK?=
 =?utf-8?B?UW04WFJleHd3L0kyNU1CZHBRV3piemgwMGYwcE8wT0JkYzNnUGMzclRpekRI?=
 =?utf-8?B?WUlhbk5iM3NWZEVsWlVJN2ROajc3OTNZeG4vVFFVUFhHOVVISUVNak9IczF1?=
 =?utf-8?B?WlNFV2xZbnpXTGhNV1RIQ2ZIa0QvYWYvdVZwMU53OEZEcG5yaUN6OWZJTTd3?=
 =?utf-8?B?MEIxOE9TMzZsVWE5Tzk4NlVyUnVLY2ZMZTNxQVVpZlM2eVRtT2toUTJ3WDJP?=
 =?utf-8?B?SUFMMUpURXBKN2tiWXY5NUtBZkY0MEU2TUlDV05oREgxRWpMRmN1Q2VPOUZ6?=
 =?utf-8?B?VVJhRk9SbWNUSWFzN2J4TTZhNmtUc2xHbU9pVFJtak1wcnl4dHZMelVPZGFq?=
 =?utf-8?B?T1hLOGFjL0tyTjl5ZGdobkZ6QVRBWXBGZ1lyWVZqU2JzejdhTXhiN1loZHl2?=
 =?utf-8?B?SVFsMGtEK253MkhoK1gwRXVLaGhBc2wxY0hCNGV0U2xLN1RuRkJSRytMV1JG?=
 =?utf-8?B?RzZVaDRBY3BJdW9maWM5ZnlLbkdMeDFjOFkvSkpJY2l2MjhtRTZSTStYUzhG?=
 =?utf-8?B?eFNjSkpVRDZ0VmRJTDFwNlpQR0FCUkRtYUtibThJQi9UL3M3cFBGamdMZkVQ?=
 =?utf-8?B?UzNKUkQ5V2xDeG5YcHh4M1gycjk1QTM1cUtEcnk0VlVZbWdkTTlCYmtCaEhx?=
 =?utf-8?B?Zk5aemp1MHhSNkJ6M2dvSzM4MG8zRlY0OFdRSlQ3SzFMYXFqdFE1bnhtVjgw?=
 =?utf-8?B?RHR6Wng5cThxbnRKMEFqemtUSjRONXlpMlNBejh3Z3N2ZkI0S3FFZHZzTmls?=
 =?utf-8?B?QjhEc25NaWZ6Tjdna1NMVy9GMlBBa2pNdU1yS2s3UmNZV3FNQm9lbGt4YVVG?=
 =?utf-8?B?bDZiNkI3Ly9uaDloVGVXWVNqY0ZDc1Fid0tpWU5pTnNueTJxUXpPaDdTUWpI?=
 =?utf-8?B?UTZHbkRTSWtTeHhFMUdKODAwZUxUSXhSM2I0YUZzQndMZUhlVEJKc3NoUUVP?=
 =?utf-8?B?M2ZyNWxZZFZoQUZnWHlKcTdacWdRYUszYVhQa21udWxTSkZqSVFLcUM2TElx?=
 =?utf-8?B?QStWTjE2WkdyZWkyM0hYYmJIMTJ0c0R6L054ZUp3U3FuemxmWWlkeUJSeldi?=
 =?utf-8?B?QTF2dEVySGVSYlJub0JUTjM1TTBjQ2w4eXprdWJlaTNUeUwvK1o3VkFCZGZk?=
 =?utf-8?B?T2p2eVg3SGYyejd1YzA4L2ZFd1FaR0V0c2FJTitybjFtbld2QnB6UGd0MCtC?=
 =?utf-8?B?T05WUzZib2p2NWNpOGgvcFphRFVTN29idFlDVEx2MnVTWHpERFJQTVgwdGlM?=
 =?utf-8?B?Zm5ZdHgwQ2paMzRFTHh2Nm9ORG1wNGlrWkRsNU5na3h3d3Y5Z1Jja0R5WE9E?=
 =?utf-8?B?c29ZVXNCNlJJV2JhZEJ5enljK2x2eFBuVTRyTGptOHFFYUpOWjRkVWFYckNq?=
 =?utf-8?B?YlBqeTRhU1dSd0VyZHo1THhpU1BYTXhSa2JPVWluSE1CS3BQYmFDeUhTMEhG?=
 =?utf-8?B?d21mNi9JVTVNRWQxOStaSGU5RGNpOTdqQ0NNNmRxQkdOWHA1ZUNUeWY3elF3?=
 =?utf-8?B?c3RDYm9IMnhieFM1aEJlN253WDB1R3o5OUU1em8yL1VrR1UxWURNOHdwQVlh?=
 =?utf-8?B?Wk9Ob2lIdEVJV01tcHdNVzlVRS9JOVRMdHNtZnFHYUV2d05aRzIzb2lwb0Rz?=
 =?utf-8?B?eEJLNkVsQkc1VXp2TVlqbnozYUNGaXhGdHdTK0VsY3dFSUk4L3ZmSHE3eTB6?=
 =?utf-8?B?ZGZXZzBHc2EvYS9pNHJ1T25yZGw5WHVyL21zbzd0bTdoUXVDMHBjM291LzJQ?=
 =?utf-8?B?QWJwZHQ1c2JER0U4WEpOdGRjQ3pSUCtKTUE5NnZQQUI1VFRmRFNkZHEvMFBj?=
 =?utf-8?B?YjdxVG1hcVVocnhPMHB4eitKQUlBakFuQ3FYTlM0Z1QrVzF3anRSRmVXZS9U?=
 =?utf-8?B?VHRaNE5KVUhWSi9Bb0hEUWRDYnNiSjZucWtmUlVid0JLSVJzcUlENWtaTmg3?=
 =?utf-8?B?KzNIb0pseEhGZlU5amU0M1JHb01Lb0Y2bU43MGxLVlZOeE5HREJ1bksybFcx?=
 =?utf-8?Q?Ygs7wcYL9kUPxHJPzS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a999ca48-2619-41ce-20df-08de998a502f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:27:26.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPs/JhREIuU9ogK621w9GZVQ9uV2zpuvJ4bDf6EjLdyMoufNOCPwQ1tpxzVCaiOVl/DV/MR7ze7pSPKbLrj4NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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



On 4/13/26 13:02, Lizhi Hou wrote:
> iommu_map_sgtable() returns negative error codes on failure, but the
> result is stored in an unsigned variable. This prevents proper error
> detection.
> 
> Change the variable type to ssize_t so negative error values can be
> handled correctly.
> 
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adk7kOUBwIyYnX1M@stanley.mountain/
> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_iommu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
> index 4626434d4180..2676cfcfabee 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
> @@ -40,7 +40,7 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
>   	struct sg_table *sgt;
>   	dma_addr_t dma_addr;
>   	struct iova *iova;
> -	size_t size;
> +	ssize_t size;
>   
>   	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHMEM)
>   		return 0;
> @@ -65,7 +65,14 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
>   
>   	size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
>   				 IOMMU_READ | IOMMU_WRITE);
> +	if (size < 0) {
> +		XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
> +		__free_iova(&xdna->iovad, iova);
> +		return size;
> +	}
> +
>   	if (size < abo->mem.size) {
> +		iommu_unmap(xdna->domain, dma_addr, size);
>   		__free_iova(&xdna->iovad, iova);
>   		return -ENXIO;
>   	}

