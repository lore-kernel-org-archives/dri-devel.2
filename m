Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D86D6AB16
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2188810E0C3;
	Thu,  2 Apr 2026 21:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aNo+fSbT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4221510E0C3
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 21:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayoahp38z695y0ob3Iz+1v5TwfOP4M30491uoNEf8lIUzxjaX2AdBzgRIAPiY/enfRjEQA5fTeYeK5uPbdPTWC91Vq0RoNHSAt97Bh49joXYiWPJC+LqS2fs81U2vcZYx5NOoz9Xm/XEgs+V/03rCQjfEvK/JgsrWoBnK2v+hMzgfUPKPNDdVcFsXYDEdZyc/buh3xCJ9xYw32Wfufm+novFtMJvRboNYl5eBM2Fx4amn/3LMxJwWvf78SzME8lmO4VydLZmopznduBpZmPHjGaZfjuiJ5lLYJiIIJ7L8zjIBsa8U9YF/uf1TlheDL28IbZqSR4u+l999kG73u8pVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajqkklwu4U/MP7sNRRX7C4lLHyKq/6FQdInqOhcVmnE=;
 b=nCTfbdyHIuoCcxRZNfkDq3FNaZgBuN/bqyTN7nKA0WFYKWHzsqzkbObkAllyNQUpJTRdg7fh43KH4d2p00O/JRr56liJbiI3rT0NcM0/tDDVS/eEeQv+MaL3UnKwf9wIfK/gB4Q+pUUP1Q1Vj32OOsXHwrSkY8pP7+BS8WvtG+1rrmajlKhSoMeD9Y52SuTmNa6O+kak5nhEqNu8pl8Np3x6Ta/oBkB+wwNcwiJpTDwAOgtFpIkIfPoEW2Cg+rqmDcyguqQ1wxN85lwCzuBal5Pzo9wbLywe/BGGDxdZtCrdZ1taPT6fncnBO3+8erGX//NWfUZhbo4IYyTf526yYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajqkklwu4U/MP7sNRRX7C4lLHyKq/6FQdInqOhcVmnE=;
 b=aNo+fSbTyLrO4ePjsB0PTEK3LJyZXhIGI5unInhvq86h+oyTweq9aPQYX5Mwb3kanV64l2acs/6QTciSKzncDzBe8Rf4VRf/sLQt7xT9xMAKjtczKjwhPVam5I1SjK8pYv5YkIof/iic5lwpQCDoeUani9+wG32VAwlDyF/mYOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 21:06:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 21:06:08 +0000
Message-ID: <ec41932c-79b9-4301-a66f-e1a50ede017c@amd.com>
Date: Thu, 2 Apr 2026 16:06:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Adjust size for copy_to_user()
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260402174148.3527757-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260402174148.3527757-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR19CA0038.namprd19.prod.outlook.com
 (2603:10b6:930:6::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: cb286694-3936-43a0-cdf7-08de90fba89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: lSqGFHWHqz3K9n+aOZfZ76M23iwLXd8FPmxCm3xvpwlA4JsuMVxmlmTeXKhDJ5FtXXMqajVRiyo9smTFRo7LLB5fzmn3kvc2ASZa3/P8aZFarAOzmOsKrW7rPWZnRmd3KCkZqud/9XrV/MOT5N5ViWYcuGxLN3FfRs6+5YLxjNW0d1qV7eAFQdtxEPImJF3/+RB8hd9X06BIlrYoWk3M8pCfxRYobZqcfme7rI+J0CcwDFUDZ100TYc+uoLudsk6OBZVKr7ey2T1q1fL7zpn+MIbx2Ubi84oAun68o2G6LHWKLz2RVs5CdIiW1CXCnYtPUzaW8eZA/yqdDi4OsMfEyJFhVHpyZaWjeOTjlT5KOZYQCHx+6PhhZMbOFY1+bi1RWHuz150l8UKKSlECt3DEQnRYjRVG2BLWLsAyLTsiofDCaEk7z+S82O2cIYzQBjd03flDT91QH0wQ0tyXV/8LaHXCeWBxLK82qfgwxNpjTydRLQAb8vomaltPPYz/EjoLxHoAcOwYC6pK3Z2QRQOns092bDC/DDQ/I+6FjCMwTTqPwhwNvLPUXV6GCLkjg8O95hzRduKZBpdgn90SN/1mND1HRUDYRiNZEaYOGoAbaMziO+mjkqmKzI28Ip4ZGYqxJ4DV1bM1/DEh3GuWpHGa60QOMOPKNMu4JGfqwug8gW9nLPlB4evv4S1R4+i3WB9WfYooQ0ig97VJSwLSSFd/4vFqBKXLhjT0RM54bqkHNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3d1eTc4MVk1OVo3U0duQjRFd0EyWjBWb1R3bU9rQjdHQi9tY1JyMHpvUFdq?=
 =?utf-8?B?UXdraWh1RCsxRExQdkRhVTlmWlprVkZlQjd2UDQyYW5SWEw2c0hydjBDUjUz?=
 =?utf-8?B?YXREV3ozMm1lMjViUXhLWGEzWEJPeTZXVkF1dUlFZVFyTlNGa2RZNitia1A2?=
 =?utf-8?B?R294ZHVNWHFCckJnVTRXYnN6N2N1UWt2ZnZsc2w0dWNDV3d1cWJNSzE4L0Rw?=
 =?utf-8?B?dlhZZUhxOWhYemw0dE1Bd0IxZ0orZG1wZlN0NENTb0hacUJTMkh1S0I2QzNR?=
 =?utf-8?B?RUVybmdiK3U3U0pkeXljSGFoTTNnWXZQWkhFd3ZyZHhIenVvOThyTW1maGVK?=
 =?utf-8?B?RVhHSTA4NG1pdG9jb0JsUWx0d2c3SWZRSUpERmpyRzgxTUV5RlhUMkFIRjFp?=
 =?utf-8?B?YUxJUktpajc1dUFuWjJiek90M2tYaGRHR0dEekcrODNuNmhvVVF5dWNlaldn?=
 =?utf-8?B?NE1vMVAvMEc1VEFLUW9XRmJtQ0ZSMEtqM0JOZ3dENzRrNlR5R205Unltb09C?=
 =?utf-8?B?b3o4eVBwV1V2MTRsRDdrdnA1M0F2Q2RwYXV3REdDOU1lcEdBbFpRSE1GUUd4?=
 =?utf-8?B?LzRzeFB1OHlyVTZFcFg0UFl0bFpmaTBxTURCajRiWW42cTUwb1RWVXZwdm93?=
 =?utf-8?B?bTlzdVBQQkd2UmRoZ3BTb2QycyttL05zRStZbFd4NC9YWWxoWCtOUDNsQmFh?=
 =?utf-8?B?N3FRTmZ0QVVvWDNZL1hsb3lnNHk4TWJST1BudXZKQlNrckRFbTlQTTNncGdy?=
 =?utf-8?B?bEM1QjJ0eGEyeVNDRzR2aTBWZHovTTZ0bjc4WWFDY0RaazNNQnRRNUgxZ1dK?=
 =?utf-8?B?SE1oUXVXdStId2hnb0dINjMxVmlKckJKM1BhL0MrVDIzNEEvNmtMdE5KUFFj?=
 =?utf-8?B?R3RSUEdEZGg5UXRIMVEwOHQyT0twbDRmeXkzZGRNTFNkU2ZwbGc0YklFcm0w?=
 =?utf-8?B?VDEwR01kNyt0UWdwajRkNC84YkhEVVFkM0xZZFhlWXNBdWxQMGR0UEJEeWVy?=
 =?utf-8?B?RWh3ZGdEaU1lSmQvNW9VckxkUUxOd1A5Y05yKzR4azNSOVVNZjBPNXRDU2Nw?=
 =?utf-8?B?NDVmQnVDejhSNEdidHMzZStZclY4Yzd5VDJUMEgxZHdFbEh6KzlWc3RPcWJi?=
 =?utf-8?B?S0tJMDVRYUc2ZSsxc3NId0MzZDladVVnQTN6Y0R0YU53WFhEeDBhc0kwMGRB?=
 =?utf-8?B?Q2ZSZ25oS0Q3enhLRFBkY21kRGhMeEl2NzMycHpTZU5pKzZUVjlnT0tLNVRM?=
 =?utf-8?B?NGpMck95ZDY3VEdOYld6VEdRY2tXTVhFRm9xYnRsbVpEbk9WSzlmY2Y4TVlw?=
 =?utf-8?B?Tnorc3dTSlI3MFVmWGs2SDk2Z3dPQ1BzVW45dDBQeWxjVlJ6LzRSZlVQYmlR?=
 =?utf-8?B?NkRWdzJUSWU1c0k2cFNSUXJCbHd0RXhVREpqOFYxOGNLR01uT2VZR200QURu?=
 =?utf-8?B?VCtBcXliTFp6MFNoVmZNdTFjTW1nd21sR1l4VXZENkNFZ0ZpenlsNVhmVkov?=
 =?utf-8?B?WjJEUWxENUltTVp3SGNrS3JMbjFudzloTkZnUGpTdnBkcjlYYXB2WEt6R0NL?=
 =?utf-8?B?cW1hNlovaVBLaDRFRUxSTjNpb1pjRUlwTFpRb0d3WVVUcnN2WFVHSFUzUml2?=
 =?utf-8?B?TWRDdmdmVHpxSkpaM2xaQ1BnQ2tpeDA2TlhKZHNDL1VTMkdidng5NnprTEtv?=
 =?utf-8?B?K0tVZW9QQjJoZ0FmcWhBeVlJY241QllLbkFkNDBna2V2TUNYNmRocUtvV3Vx?=
 =?utf-8?B?anZySW1CRzBUZm16RXozVjB5TnpMdVlEaFBEa003TWgyUE5PVExnb3UxYktJ?=
 =?utf-8?B?dGdBeXRYM3lpZDJYRFAxWXlMUlB1anZwWW01VUVORDF0REFJc3JGdTZRS2lZ?=
 =?utf-8?B?ZkxvWG5zNk5VemhTSGZ1RG5zRHFQS1phVHMrVDY1VDFwYkNMWWZDSTE3cFg0?=
 =?utf-8?B?SFNCYnF0OFA3dTRhUEltMGtQc0VvSGF0d2pySFRqbFl0UUNQS001RWN3Zk1z?=
 =?utf-8?B?bWQvK1RtUDRjTkZYd2NaNlpuN0xQMHkwT25iME9SWlRYcHZzL1hhTG9hUXpt?=
 =?utf-8?B?Q1UxV0VGTmtmSlV5aXY1bVZveXFyTGttTXZXc2k1dlZNZk9OUzdGeHRuMEdh?=
 =?utf-8?B?T2I5N1g5RU13MldzcENsOXdDY2ZRTVpVV1ZVYWEzM3FuZnNRRmt5TE84VnIv?=
 =?utf-8?B?MyttL2Fhc2g2VUoyZVdvYU5CcFdwVHNzaHBqQkEwbDdvUWQzN0NTbUhKbU5D?=
 =?utf-8?B?VkxpNm0ySTF1V3ZHQmFyMklweWhzam5YSVY5SVl2ZjR4MnNyRkt5OVI0dzVa?=
 =?utf-8?B?SHVJc2h5czVSS3VRSzJaNzRISXV4dzhSVVcrdWdXa1Npa25QMWxiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb286694-3936-43a0-cdf7-08de90fba89c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:06:07.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4ZQV2EzFuhFemufPIgyIi9jeCzP0bwby9f8dJB8AUArS/ELFa/GGr1r+wYyKcHIjQCzbDtzbRBrebmCOEpKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107
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

On 4/2/26 12:41 PM, Lizhi Hou wrote:
> The amount of data returned to user space should be limited by the buffer
> size provided by the application. If the buffer is smaller than the data
> size, return only the portion that fits instead of failing.
> 
> Fixes: 850d71f6bf4c ("accel/amdxdna: Add query functions")
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

I don't really follow.  Why check if args->num_element is 0 and then set 
it to 1?  Does the check actually make sense?  Just set it to one and 
ignore what's there before.

If it's for protecting args like a NULL args->buffer, wouldn't it make 
more sense to check for that?

> -	args->element_size = sizeof(ndev->last_async_err);
> +	args->element_size = min(args->element_size, sizeof(ndev->last_async_err));

As this comes from userspace, couldn't it end up being clamped if 
userspace sends a smaller buffer?  Is that intended?

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

Don't you want to respect /check the size of the caller immediately?  It 
seems odd to hardcode it here at allocation time.

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

