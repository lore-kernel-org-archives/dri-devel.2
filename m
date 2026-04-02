Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7FD6AAF4
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EFA10E3D3;
	Thu,  2 Apr 2026 17:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gypq/9zh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C667210E3D3
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 17:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt3yvPwJtlfyovsHeSmFlVjFU4w1booo9GmIwOTpBIfVdJEUKQ+KrrpL9lV3r7mNQIzNFb8NP0WOoGMwSquWdppGFumH6BSj0kD3xhrhMT2rTAxeGS0ucMoBKSDNyalk/Vf1L+gWdExqP3V/C3S5EuB2z+N+k+JtZgP6S6x9LofN3XgJHphkhAWAp2/stgsw3LVs4aK3sysMXWY6ZzTap/wA8lgGjMzHN/86T9AWnJ5CQMyPlh8Mf2GvjTGwMCZjgQ7llMdP6p4GrI+hWNCRZN+LsLDJdhJA3jGoVfGDNEoFUWghcrBTKVdbCtkKWfioFv+fWr/GWvKtAiquyxAaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZyHK12dnaFb2LMNBCZh+/v94k3u2XCiNX3Wk4NVgTI=;
 b=Xt1lSpgfPIXZijGphPW5Ev+wcl14hpsqMvITKtMIc/vRJfUWnbxMEl0fMbxLh4wv33COuRUC2+X/oD59eUvxu+wAQGimwrV5Kww7Nx26T3AHddTgApaOMJsMUfuHsJKmFUKKKauSCCRL1r1ZprSJJNGds3ckxvw4xaZE8B6Awq2nO83Ujnbh8vclVrN6L+Y6bI7viBmU/J8cOGBFRC/x2hXPE3H8aOabHqz2xAqA8qpwC/uKh2Syi14xGRmaoNyB4Up9UEKSHSMXVCUn4Ek5ZhPGpSR5rQpAu+zELWfQ2pvAtGIaQFPJ7mtqNmjoTNT1gW77pHKAHHtvzSXHlWarBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZyHK12dnaFb2LMNBCZh+/v94k3u2XCiNX3Wk4NVgTI=;
 b=gypq/9zhqghgZnN0CGzmOeSXP/fV6FzOzPLerDChnMIEV7vSffPux+YKoOE7NDFSsBzGCGxSyjw1nD3DfWlnt9XM9XgMwDkrjQjwKPDp9RM2bps/O7rZ1QQUgbDfcVcD6J4OOavqKSt/NyGHL1tdgb60C79ROwvcEFnNs03nxvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 17:19:51 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 17:19:50 +0000
Message-ID: <ee3f4041-dc0d-4c4f-b8b7-fdfbda97014f@amd.com>
Date: Thu, 2 Apr 2026 12:19:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Adjust size for copy_to_user()
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260402171441.3525556-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260402171441.3525556-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:806:120::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: ef510d4c-7d29-483e-d5ce-08de90dc0c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yOF/dlL69cNhvGICtAnBLcma0GIuv8jQO/gmSdc0lwyen50Q04eIUwMH9+x4GFAOyQdhg02Sb47/eR2Pw7xapdo61Ofy3uQ2nlvqCBH5aGtQH6K78ZhB8Ul1e/2ln/zZGZdA/c7E1wYY7YEgsYMrZDf+wWRky5IDdiWP20aZ/qa19ZgxtOIeeqYPT2j9nYLBHm/EnaPf/JlrAmkOU5Z3okeMSUi5B9gT66Ro/8mqnHXhE4fSVLI5wYbI8P28hRuXZc4rZFOq5Ci3GxEa/XgO4Hno+am9w6pwPGtLb9RpA2hwmlR4Nu2DzxLseG+uNE7uGC070gqexXLPlE+umKiRbYrYypKgBROWmVXtlk2J7QgCk2kv+hcngyPCZh+ekuRapx83BkOeG70+9xaDMsc9TWFKXWR7n81OSYheiKTXyNDvAEwh5BFTyT2QGcH7r1hlCxyqfTpH3rRGNA9uKyGJyuu33A3KaCfdUop6VIFvy6py6mPsfjAm5aiS8ZFLrriwsQBlF3ruOV6si3wvZhYSe6YNZA2LWQKMHbhYsViN2eZWIPacnpF04Hlz+R8uTiT/dLhmXtJKwHxrx1zcx50lHbOziq2CiD+mbSU3d9M0QGvBiirhpZ2NnHHRquhZlFnDLbALYLO6o/eoSKpPAVrLUTFRQ+QCNnudPh9vWvEE96GnaGZig8DKn8ZH9WvW9ljApDl5KUuhgXnMtCDVSisL0VqQAUlETpWX2qzB7dc1euQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNNUitQdGk5M0ZpV2V2OG44SmpGbUZqRE1HZmNjRXBWSkRyZEZMNW00eFZU?=
 =?utf-8?B?U3pkRUdQaDlIbWcwNGFGVlByTC9lVmVVbUFzdWcwVndKMlVJSUtaa0ZHQkdm?=
 =?utf-8?B?TnJoejJ5N3V0MExXczBTc0QrZkgrY2lsaXZVOEZDd3ZRbFU2aldJUUt3UlpL?=
 =?utf-8?B?VzlxWE10TWpyWXpJTjl3cXMyRjdvaUFLQlAyQzRwZkc1YzJROWhwdVd4NlFD?=
 =?utf-8?B?S3pSWFJQemVUTzBSc1MyVEF1TDI4MVkvNG9pSjQwa1kxb3cxWHdLV0IyK09M?=
 =?utf-8?B?NEZQeENGL0I2OGYrZFV0U2FSZU9jK2NtQ0oyeHpXZVFzNkM1OER4UkZBZ3RK?=
 =?utf-8?B?SlVBaEcxMGRlMEZtRWZ4eC9QbzRYaDMrZDlvbk1JUlp6Zk52cG8vcE1hNVpu?=
 =?utf-8?B?c2ZDTGdUNFFOQjJHdlh1ek5CYUo5VkZqTkZiYWlFNkZDa2hXelZNZVg5QmVW?=
 =?utf-8?B?QWdsWlBLNFdIYnNaWmIxeXU4Lzd0RG5jYWZET01SbWl3T3gySmVvb3NjNHhV?=
 =?utf-8?B?bStFN1hLdXNVYnlFbTlWUm1kL0xMc2JIalRQR2JOL3hTbytLdy8rZUdQWFpq?=
 =?utf-8?B?WGJzVmNSMklNVmozRno5SU9TTkJPZGRHWlliYUorV2U5dksvN1hDV3pSSjFS?=
 =?utf-8?B?OEY0cXdrTmM2bTA4cGxtdXl4UjRDTW9tUHRPOGtmRTFuTE9tMTZsMkdxTFVa?=
 =?utf-8?B?Q3pwNGNDeTIwL0NSVGZzQ3VYcmhraUNXNUMyMEE5MllLME9nL3JyNVRpcUdh?=
 =?utf-8?B?ZFNmQkhIc0Q5MnRSaXFkUVBJOHYzWkpONktZMkFWckVibDkxVENHK2VOdDkv?=
 =?utf-8?B?OVJCUkMxOWRuaDVjOEdKZ0x2aHExakFLVGNlSWdLYnZqdi9qbUZlV1k1MTVN?=
 =?utf-8?B?UUo3cUdhd2c2Qm95R3E1eVU2amxuY2M3bUQ3Mk1lRExDVlY3OGVrMjc3Qlg2?=
 =?utf-8?B?eDZCeUtMbzd5ZnJYYkFpdWExZHBCb2kwZTArMWhJQTh0RHVxUTlWRGxqbkk0?=
 =?utf-8?B?UmZHelNmaUlOUmo2dXF3ZEhpSU9SQXZuQUlLMkFCK3l6T016WEI0cVVRZFlh?=
 =?utf-8?B?WHFrbjl5Z3FMMWtMZkFoNG1EMlFQRGltczNaWjVYRTVGMnhISWJsTkRSbjJE?=
 =?utf-8?B?RVJoSHdFcGlrYXMyWDRNWWpJY2EwTGJyU3V4N0lEd0lvQTRkN2ZoZUpiK0dH?=
 =?utf-8?B?K3A3ekU5SUFjR2FtYzR1dUZzU2xXdjFSRmZPZFM3ODhEampPS0pIa2VtWXlN?=
 =?utf-8?B?MlR6SEIwM1NHejYrS3Y1T3Z0S0tkTHAxdnJoeTNzTTJGdjgyQ29GMm1NUjhj?=
 =?utf-8?B?eTY3cnpiS2RzQWxrR1dvbjJhUkR5SlJxQmtWRjZUMWorY0t1SkE0eUxlem9G?=
 =?utf-8?B?ZFFzTFBJNXd4WkhyaUhaRCtVcHRoSVVObzVyTnpMN3dSRzh0dDVGbXk4cits?=
 =?utf-8?B?TGdXT1JzQjRsSzVxVnp1MzExSG1Jbjh3Nnp0blA1SWxvaHhBWVdzT0pwUUpT?=
 =?utf-8?B?eDdqanMwblZxNEh2Y1pCdkRVSS92eERVYjRTMVAxeDVPNFRLNzZQN1lFTnUy?=
 =?utf-8?B?clZ0dWYzVmp6Y2dCbWNvNEJodTVtdHpJQ3RWZzUya2J0Vk1qMjJwV1NXUHEr?=
 =?utf-8?B?OWtPMnpXb1ZlYWNjdThyNzhaZVlCbkhuSlVMQmg2SXF2QmJsVlNNSEE4MDNH?=
 =?utf-8?B?aS82M0pVS1BEcisxVDg4TnFUVndLcXZsQ3JBMWNvVXNEcytEYWhsRVNlQlhH?=
 =?utf-8?B?bGw4SVRRNm04MEUyUjFmZGN2QjFtNitnWWh3M2NkbTBWVTJFNzVQK3hmcDdN?=
 =?utf-8?B?NitmcXNCdFFYM3FOcFc4Qjl5SkY4WjQyWnF2eGhpaC9YQUI2M2lpeXBmRnR6?=
 =?utf-8?B?YlpzbW9qVEVtbHVyTVl6ZHpXckdXcWFLUVJNaU9QK0tWZ0pJN1c5T29IaUtQ?=
 =?utf-8?B?L1NlV2ozTjZCN3VjS09qczdueStBay9hUUxsSEhOWXljZWFzUWpqUmRhcE5l?=
 =?utf-8?B?NTU2NTFXVGJwcHNra3laTkZNODc1amlGOUIxWmNNU3NnbEY3a2FKQ1JNTGJx?=
 =?utf-8?B?bVNDMGZjQjJpZXhGWUFReVNzcWNvVy9HeHpsQkNHNWpoZmw3Z1FLajZUTlNi?=
 =?utf-8?B?RUwyQUppQzlrYzdjK3JBbm1WQkl4anhSTWx2alkwM1RFT3hOdkRZMGhuN2hQ?=
 =?utf-8?B?TGl3Vm4yMzhmSEphSElXdFdSMS9tUEd4ckhQdG10U1hkb1U4Rm9xdFMydEps?=
 =?utf-8?B?aG1LbzQwcDlOVG5kNWFYdC9pUlJJblNwOUFMN3o0NkdoczZYeUZZVDBSUjcx?=
 =?utf-8?Q?4gZpDc0MatlwkHLGHu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef510d4c-7d29-483e-d5ce-08de90dc0c49
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:19:50.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+cGfFG6IZr9uNEnjA+KuhfzLNcVBA5xqHDU2cJUn8NpLs8zK3XmqCFoG7ZlBKTp3GZ4vaEKDdsy1850XbLkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

On 4/2/26 12:14 PM, Lizhi Hou wrote:
> The amount of data returned to user space should be limited by the buffer
> size provided by the application. If the buffer is smaller than the data
> size, return only the portion that fits instead of failing.
> 

Prolly should have a fixes tag for this I'd think.

> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_error.c   |  5 ++-
>   drivers/accel/amdxdna/aie2_message.c | 20 ++++++----
>   drivers/accel/amdxdna/aie2_pci.c     | 59 ++++++++++++++++------------
>   3 files changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
> index 9d20e956c020..70007b4363cd 100644
> --- a/drivers/accel/amdxdna/aie2_error.c
> +++ b/drivers/accel/amdxdna/aie2_error.c
> @@ -406,8 +406,11 @@ int aie2_get_array_async_error(struct amdxdna_dev_hdl *ndev, struct amdxdna_drm_
>   
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>   
> +	if (!args->num_element)
> +		return -EINVAL;
> +
>   	args->num_element = 1;
> -	args->element_size = sizeof(ndev->last_async_err);
> +	args->element_size = min(args->element_size, sizeof(ndev->last_async_err));
>   	if (copy_to_user(u64_to_user_ptr(args->buffer),
>   			 &ndev->last_async_err, args->element_size))
>   		return -EFAULT;
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index e5e7da7a8f40..e52dc7ea9fc7 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -369,12 +369,13 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   {
>   	DECLARE_AIE_MSG(aie_column_info, MSG_OP_QUERY_COL_STATUS);
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	u32 buf_sz = size, aie_bitmap = 0;
> +	u32 buf_sz, aie_bitmap = 0;
>   	struct amdxdna_client *client;
>   	dma_addr_t dma_addr;
>   	u8 *buff_addr;
>   	int ret;
>   
> +	buf_sz = ndev->metadata.cols * ndev->metadata.size;
>   	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>   	if (IS_ERR(buff_addr))
>   		return PTR_ERR(buff_addr);
> @@ -398,13 +399,14 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   
>   	XDNA_DBG(xdna, "Query NPU status completed");
>   
> -	if (size < resp.size) {
> +	if (buf_sz < resp.size) {
>   		ret = -EINVAL;
> -		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", size, resp.size);
> +		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
>   		goto fail;
>   	}
>   
> -	if (copy_to_user(buf, buff_addr, resp.size)) {
> +	size = min(size, resp.size);
> +	if (copy_to_user(buf, buff_addr, size)) {
>   		ret = -EFAULT;
>   		XDNA_ERR(xdna, "Failed to copy NPU status to user space");
>   		goto fail;
> @@ -424,13 +426,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>   	DECLARE_AIE_MSG(get_telemetry, MSG_OP_GET_TELEMETRY);
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	dma_addr_t dma_addr;
> -	u32 buf_sz = size;
> +	u32 buf_sz;
>   	u8 *addr;
>   	int ret;
>   
>   	if (header->type >= MAX_TELEMETRY_TYPE)
>   		return -EINVAL;
>   
> +	buf_sz = min(size, SZ_4M);
>   	addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>   	if (IS_ERR(addr))
>   		return PTR_ERR(addr);
> @@ -446,13 +449,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>   		goto free_buf;
>   	}
>   
> -	if (size < resp.size) {
> +	if (buf_sz < resp.size) {
>   		ret = -EINVAL;
> -		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", size, resp.size);
> +		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
>   		goto free_buf;
>   	}
>   
> -	if (copy_to_user(buf, addr, resp.size)) {
> +	size = min(size, resp.size);
> +	if (copy_to_user(buf, addr, size)) {
>   		ret = -EFAULT;
>   		XDNA_ERR(xdna, "Failed to copy telemetry to user space");
>   		goto free_buf;
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 164e188ba501..041cbc8cd7e5 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -620,23 +620,19 @@ static void aie2_fini(struct amdxdna_dev *xdna)
>   static int aie2_get_aie_status(struct amdxdna_client *client,
>   			       struct amdxdna_drm_get_info *args)
>   {
> -	struct amdxdna_drm_query_aie_status status;
> +	struct amdxdna_drm_query_aie_status status = {};
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
> +	u32 buf_sz;
>   	int ret;
>   
>   	ndev = xdna->dev_handle;
> -	if (copy_from_user(&status, u64_to_user_ptr(args->buffer), sizeof(status))) {
> +	buf_sz = min(args->buffer_size, sizeof(status));
> +	if (copy_from_user(&status, u64_to_user_ptr(args->buffer), buf_sz)) {
>   		XDNA_ERR(xdna, "Failed to copy AIE request into kernel");
>   		return -EFAULT;
>   	}
>   
> -	if (ndev->metadata.cols * ndev->metadata.size < status.buffer_size) {
> -		XDNA_ERR(xdna, "Invalid buffer size. Given Size: %u. Need Size: %u.",
> -			 status.buffer_size, ndev->metadata.cols * ndev->metadata.size);
> -		return -EINVAL;
> -	}
> -
>   	ret = aie2_query_status(ndev, u64_to_user_ptr(status.buffer),
>   				status.buffer_size, &status.cols_filled);
>   	if (ret) {
> @@ -644,7 +640,7 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
>   		return ret;
>   	}
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &status, sizeof(status))) {
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &status, buf_sz)) {
>   		XDNA_ERR(xdna, "Failed to copy AIE request info to user space");
>   		return -EFAULT;
>   	}
> @@ -659,6 +655,7 @@ static int aie2_get_aie_metadata(struct amdxdna_client *client,
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
>   	int ret = 0;
> +	u32 buf_sz;
>   
>   	ndev = xdna->dev_handle;
>   	meta = kzalloc_obj(*meta);
> @@ -690,7 +687,8 @@ static int aie2_get_aie_metadata(struct amdxdna_client *client,
>   	meta->shim.lock_count = ndev->metadata.shim.lock_count;
>   	meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, sizeof(*meta)))
> +	buf_sz = min(args->buffer_size, sizeof(*meta));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
>   		ret = -EFAULT;
>   
>   	kfree(meta);
> @@ -703,12 +701,14 @@ static int aie2_get_aie_version(struct amdxdna_client *client,
>   	struct amdxdna_drm_query_aie_version version;
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
> +	u32 buf_sz;
>   
>   	ndev = xdna->dev_handle;
>   	version.major = ndev->version.major;
>   	version.minor = ndev->version.minor;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, sizeof(version)))
> +	buf_sz = min(args->buffer_size, sizeof(version));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>   		return -EFAULT;
>   
>   	return 0;
> @@ -719,13 +719,15 @@ static int aie2_get_firmware_version(struct amdxdna_client *client,
>   {
>   	struct amdxdna_drm_query_firmware_version version;
>   	struct amdxdna_dev *xdna = client->xdna;
> +	u32 buf_sz;
>   
>   	version.major = xdna->fw_ver.major;
>   	version.minor = xdna->fw_ver.minor;
>   	version.patch = xdna->fw_ver.sub;
>   	version.build = xdna->fw_ver.build;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, sizeof(version)))
> +	buf_sz = min(args->buffer_size, sizeof(version));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>   		return -EFAULT;
>   
>   	return 0;
> @@ -737,11 +739,13 @@ static int aie2_get_power_mode(struct amdxdna_client *client,
>   	struct amdxdna_drm_get_power_mode mode = {};
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
> +	u32 buf_sz;
>   
>   	ndev = xdna->dev_handle;
>   	mode.power_mode = ndev->pw_mode;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, sizeof(mode)))
> +	buf_sz = min(args->buffer_size, sizeof(mode));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
>   		return -EFAULT;
>   
>   	return 0;
> @@ -754,6 +758,7 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
>   	int ret = 0;
> +	u32 buf_sz;
>   
>   	ndev = xdna->dev_handle;
>   	clock = kzalloc_obj(*clock);
> @@ -766,7 +771,8 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
>   	snprintf(clock->h_clock.name, sizeof(clock->h_clock.name), "H Clock");
>   	clock->h_clock.freq_mhz = ndev->hclk_freq;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, sizeof(*clock)))
> +	buf_sz = min(args->buffer_size, sizeof(*clock));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, buf_sz))
>   		ret = -EFAULT;
>   
>   	kfree(clock);
> @@ -792,12 +798,14 @@ static int aie2_get_sensors(struct amdxdna_client *client,
>   	scnprintf(sensor.label, sizeof(sensor.label), "Total Power");
>   	scnprintf(sensor.units, sizeof(sensor.units), "mW");
>   
> +	if (args->buffer_size < sizeof(sensor))
> +		goto out;
> +
>   	if (copy_to_user(u64_to_user_ptr(args->buffer), &sensor, sizeof(sensor)))
>   		return -EFAULT;
>   
> +	args->buffer_size -= sizeof(sensor);
>   	sensors_count++;
> -	if (args->buffer_size <= sensors_count * sizeof(sensor))
> -		goto out;
>   
>   	for (i = 0; i < min_t(u32, ndev->total_col, 8); i++) {
>   		memset(&sensor, 0, sizeof(sensor));
> @@ -807,13 +815,15 @@ static int aie2_get_sensors(struct amdxdna_client *client,
>   		scnprintf(sensor.label, sizeof(sensor.label), "Column %d Utilization", i);
>   		scnprintf(sensor.units, sizeof(sensor.units), "%%");
>   
> +		if (args->buffer_size < sizeof(sensor))
> +			goto out;
> +
>   		if (copy_to_user(u64_to_user_ptr(args->buffer) + sensors_count * sizeof(sensor),
>   				 &sensor, sizeof(sensor)))
>   			return -EFAULT;
>   
> +		args->buffer_size -= sizeof(sensor);
>   		sensors_count++;
> -		if (args->buffer_size <= sensors_count * sizeof(sensor))
> -			goto out;
>   	}
>   
>   out:
> @@ -909,6 +919,7 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
>   	const struct amdxdna_dev_priv *priv;
>   	struct amdxdna_dev_hdl *ndev;
>   	struct amdxdna_dev *xdna;
> +	u32 buf_sz;
>   
>   	xdna = client->xdna;
>   	ndev = xdna->dev_handle;
> @@ -920,7 +931,8 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
>   	res_info.npu_tops_curr = ndev->curr_tops;
>   	res_info.npu_task_curr = ndev->hwctx_num;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, sizeof(res_info)))
> +	buf_sz = min(args->buffer_size, sizeof(res_info));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, buf_sz))
>   		return -EFAULT;
>   
>   	return 0;
> @@ -956,12 +968,7 @@ static int aie2_get_telemetry(struct amdxdna_client *client,
>   		XDNA_ERR(xdna, "Invalid buffer size");
>   		return -EINVAL;
>   	}
> -
>   	telemetry_data_sz = args->buffer_size - header_sz;
> -	if (telemetry_data_sz > SZ_4M) {
> -		XDNA_ERR(xdna, "Buffer size is too big, %d", telemetry_data_sz);
> -		return -EINVAL;
> -	}
>   
>   	header = kzalloc(header_sz, GFP_KERNEL);
>   	if (!header)
> @@ -1002,6 +1009,7 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
>   	struct amdxdna_drm_attribute_state state = {};
>   	struct amdxdna_dev *xdna = client->xdna;
>   	struct amdxdna_dev_hdl *ndev;
> +	u32 buf_sz;
>   
>   	ndev = xdna->dev_handle;
>   	if (args->param == DRM_AMDXDNA_GET_FORCE_PREEMPT_STATE)
> @@ -1009,7 +1017,8 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
>   	else if (args->param == DRM_AMDXDNA_GET_FRAME_BOUNDARY_PREEMPT_STATE)
>   		state.state = ndev->frame_boundary_preempt;
>   
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &state, sizeof(state)))
> +	buf_sz = min(args->buffer_size, sizeof(state));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), &state, buf_sz))
>   		return -EFAULT;
>   
>   	return 0;

