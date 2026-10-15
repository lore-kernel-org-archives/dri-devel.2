Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A0CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8349910F2FE;
	Thu, 15 Oct 2026 18:36:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E80B10F2FE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fub9VDa/b0tZGhpAtsVqELMFfdc4mFUN/+b7dWnn8QTzvmg41zsGIOzHoKnvF34wld9LzlMUIu0EgYHRSJXhIuacZKlZjNkxuADvF+8Ym7qIZxq8Ee3BkBADYYVSkXLVGgYPbmtmLtA+g/u3us2cSaxQh9NuC9U1kUeA3tF9LIaiOT8aTgsIYW9sndmKo5iZAeeI706hVRFAO0EZNtTa6waqcWTloY/LtRoJpBSRRJYUHD2I0y+Y60PF4vNzguGaZw5nuQbN4eJap4LTEehnlhnF+ZUGzztFjs4K3eJaiktAlZzlty9M6lIavprWNICZqWsg9VrI1+NBq0rhoLbwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grqAyBMXHtzNAy+wHmuXJ3XhFdcqflg/d8q5KKzHsWY=;
 b=em6U97Ix9IioscF1GXK39upzjSu1y3TqxZL0Yaifn1fJSX2AkDm+DSOtqIq1qvb+7nLGO4Hf5Oqw/tVdGi1J0gah6o2W6C8wBI3CjetI5MYsciyEpl6hgt6cvw8hv7zeB6LrFo91PwRjVlAidEdcZoP2Y+8amdqhwVGzcY9os05mapOGxtPYmZjFUDKmhE9Fi7SmqZ67PnBfDDathzXAbjdGJqMCFGPcZW6sxhvI2JNzmbeCF06exwjDHNP2H81DvYZkooD0jTnfRYQ2XxWkjpzeC/bugMzqEfJZr5gDG6ov7t5CR5wIagYJpcsu28AsHDecb3sSC0WjRHriUqYc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grqAyBMXHtzNAy+wHmuXJ3XhFdcqflg/d8q5KKzHsWY=;
 b=2pZiyRKG+x63evWUE2OuBI9wFJ+6/Giv4/36dKh83k1fN70B/ZSRA+bRjwtLNWp4JuhqfWjVIbX805hFGarqZuLrTSH5b8/jzLbLDqub/BBteguXA2WXLpzGm6C/SyMidPcTEWlklC+sSsjZQBHSc44/K5LZnl2O2QQFSsUtZR8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 18:36:09 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:36:08 +0000
Message-ID: <dc65d236-7733-449d-bfe3-5c81f8ca69b9@amd.com>
Date: Thu, 15 Oct 2026 13:36:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the
 HMM invalidate callback
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com, max.zhen@amd.com
Cc: Matthew Brost <matthew.brost@intel.com>,
 Copilot <223556219+Copilot@users.noreply.github.com>
References: <20261015183248.3414119-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:610:e4::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 253ddde1-5dfe-4162-7e76-08df2aeb2db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zdYE37CZNIGELvgW+Ysrfj5nUfVnS5P09cba6te2WTt2J5clzIhZ3oOrr4Gp+YFtckN1uch9x5GDeEPQMIm0/M22kELFfS30QquoJvfNG7OjH9gk4cWAihmbZnHngQYubg2AsoGYPMsa8FBw1/RL2b5Ano8JqbnI74WuSqorbhmDH3Hs9kt2+UqS2HKy3mjBoCpiQ8YTMu5/TY0L2HECmoktYhzADUXGY0ZkOb++VwRbRmglYgwqi2ikESim2tfrIFyZC4YotgQhvO/9kERPtI+cLrHWKBF3fJgeIcPdAO8Abg0py4fjDrkBwyPLtrEFlRlE07pWKBzOihaC6N/YG+Hrm1goAz18kj5W1o4UuvmKVotlmi8zOfMMDM0440UMD5kQ4Q4us3aVUGRdZQDHgxazpkg6TQcxD0uxAR+/kxZ4T1khtU9AkCdMkyM300xuwfR/oJLGKJHAyYtTZDTndBQSCGQ2FKYz84IiCBfIZWz9+9gDlcRHUURnuTWVfhnYNjGaCzc5KR09fR0Jue8bDDpg3ikxXZka/w0arI6uPWduaG0/BRPYscTmaar1jfMRFhrxZW6WdZOg4wPcJm7DqvY/Juq7TC5ui7zF/Us0VZkclVKgOxyj04dYs/Dcyq4VR62I0C6gV2WgH7VYplw2JLdFqVjzyMk9DBoMNg4PVR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNVT1VXK2l3L3NpUmp1NGE4a1ZDVUxXa0lIMFlEUSt3QXlFaGNFQjBQaXZk?=
 =?utf-8?B?c1RGODY0K1p5RzdHcllWK1hUV0NPQmRWQnlJQTVEVkU1SGlNb21KY1FuQU5H?=
 =?utf-8?B?NmRRVDFSd0pGYnFrYzZMQ0RpbWxoMDcyaHNQYUgvU0IvRWkxZkFMTDV0V01l?=
 =?utf-8?B?WXJFUzZFOUVDSmxIZW1PbnZNU0dpM3NKTkxudlN0dDlxY0ZiZnNzTy9UbEY4?=
 =?utf-8?B?UkV0T1h5aHgrdmhibEd5ZG9mT1ZxdnB5a2dQblhpcW5GSExuMzVMWFZibjNr?=
 =?utf-8?B?VFBmdHgzU1JyR0FIVS9VRi9NMU1FdlFlUEh6SUs2ck9mSEd0Y0JrZXpDSita?=
 =?utf-8?B?Y3BGRWRYWnFFRHVCNlVCeFBkWVZrMkwrNnorb3hVd0dVdzhsQ1M1M0hIUTRV?=
 =?utf-8?B?cXI0anRDcXJXMFlTQVVjL3dyQ3FKQUZHbHA4ckFZUXppR0dxclBhZmVCTk96?=
 =?utf-8?B?QVdLQ0ZENXVvTXVLOEFqWjBnOWNldnIxSk8xSmgzamlaMy9UbGVZeEFoVUFy?=
 =?utf-8?B?RlFScEMvNlQrb3RoaXF1b1ZqRmszVDRjNTI0a0w1cEY0dGYxUTNncVBmWVNk?=
 =?utf-8?B?N0haaWZMUjlhQXVZN2lHTThtTXlGZVYzeE9iSnVBdzZOZnduNmFKYndDc050?=
 =?utf-8?B?ZFREUFJEWEpOOC9LNjg1cmhYZDJVdDNkOGVFSXFHUVJTZjVWRjVwQ2xJOTE5?=
 =?utf-8?B?UUV4N2VBNWRpZi9VZndMemZpOFl1Wm8xMzk5S003NE1XZ1cwL1plS3RnTzFV?=
 =?utf-8?B?SnNsdmNEVFpQK1l6VUJWeWtzbUh0OFRWVTRaa0JVV0lpOEdYZlZpVWtrN1pU?=
 =?utf-8?B?cmovejc1T0ZVTzFWMUVaRnNyUjdWZEUrSzNYTDZNNVBBSUd1WjdSblFPSDVl?=
 =?utf-8?B?eUlIUHZ2MHlpQmlYV05qYWdUSERiWWRHSC8rSVR3RzBObTFuTkNKRWpVcTE4?=
 =?utf-8?B?RlV6ZUl2U1ZkU2FwL09RbkhuV09Rc3d2YitPME1STHhQNVBEaE03dTVMcGhT?=
 =?utf-8?B?UmpwZjhQTWFqVnViamJwVzJaMUVNZjVWbTRNYXdVVWovcnFpcVVndFcyeWlW?=
 =?utf-8?B?NS94anJSYVR3dS9vRkt0Y2piRlM2REVjenRFYzc5d0VRMUdyakVGUWV5bUhZ?=
 =?utf-8?B?Q2RQUzNqS0toaGl4aFJkRE5yTXJwWExXcWdoU2FHMGlzZHZYN01lQ1VMa0Rh?=
 =?utf-8?B?Ym05M1IyWE9PU0x5SExEcUhOTGplWTFnQVdmMW1IWS92WmgrTS80cVQ2akR2?=
 =?utf-8?B?OHQxWVRxZENzSGE2ZWtwdktIMzhVSU5PcWxvUmUzZi9NNlFNTW9kNG0vWHNT?=
 =?utf-8?B?Zml3UDJkeExSTlFRRW9ldmNEZURkU1ZZREk2WnFPa3daMUl6S2IxcW9BSUVP?=
 =?utf-8?B?eVlyN0s4Smt3SnFORVk0RDZabmF5YnJXUVNsbEMzbEEzR0tOV0tlMHJiS1Na?=
 =?utf-8?B?OGp4enUrcmFJallUa3dVNktjNXIxWjYrMUcydFc0RkQ0OFhCZkloUmZMem1j?=
 =?utf-8?B?dW9LSHc1bVZ2SnFLTkYraXpCRWlvdHEvajJHd2h2aTRKaFptend0Z0M0cXpO?=
 =?utf-8?B?LzN5bWEzUHRLeitCTmlramdlY3htdkVUcUEvbFEzc2tHTm13T05iSXIxMTRC?=
 =?utf-8?B?Qm54Wk9uY0d4NmVoQjI2c2NQUkV0aGZoNSt0d3BLcThWeFhRdE9PV3FmSUtj?=
 =?utf-8?B?S3NJVVJwTVg3dGMrdzMzUk45dW5FVEh1citGQXJleWZWZGNPWFI2V0N2c1p5?=
 =?utf-8?B?bFRMb29QbXhsZzJRRjBVa0gyaWYyb3JqMU10V3RCdnJjS00wajlxSDE1SDJF?=
 =?utf-8?B?K3p4eklGNUYrM3IvZEFRa2QwNllqVWhtYnozV0pSU3pSOE5keWYrZjhXcURo?=
 =?utf-8?B?NEVnbkJjRDVodWM4RUFuQzg2YzY0a2FzRTVubjU0S0Z1ZnpVUnNWanhydlNn?=
 =?utf-8?B?TnR6c09EeW0xK0RKc3B3VGJhaVUrbW84Q081dlRTRFNpeUpwUmo0QlRPRTVM?=
 =?utf-8?B?STN4czJjdVVDMTRyL3E0TkhBUUx6MFE5RHpHS20rWjRoVnBCNzhFbmdTb2N3?=
 =?utf-8?B?ak5OdGZsc0k2eDFxMXNHWWEyemJGU1o5VjJDcnpvL3FqcklLUVlNQzEvWXZx?=
 =?utf-8?B?bC9jaVNjYWovSExWbkljNTZwenhUYzk4Z05UcEZURDVmUXlsY1M5WCtwWHdh?=
 =?utf-8?B?SC9JbTVUVjRpa0czWk53NDdwRWt6WVJ0V1NvNGVYQWFqQTlUL05YR3htdGJP?=
 =?utf-8?B?cnVsbm1kWXZvK2ZvVS9tSVltc2NpSW9ObEYra2dlaXpkeXgzMTRreEpJQTdS?=
 =?utf-8?Q?5EBldQlyrS7Tl3w/1Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ddde1-5dfe-4162-7e76-08df2aeb2db2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:36:08.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3iWem3KFwkNJuNRribzOel0n9izuPh7QCCWcmnF2IZXut9OQFRTVDtV+QkAU7D4xLs4FoaVUs+R36baHq2u3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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



On 10/15/26 13:32, Lizhi Hou wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 
> aie2_hmm_invalidate() waits for the jobs using a BO before the CPU pages
> behind it are released, but does so interruptibly. When the task
> triggering the invalidation has a signal pending the wait returns
> -ERESTARTSYS immediately, the notifier completes and the pages can be
> freed or migrated while the device is still accessing them through the
> PASID.
> 
> An MMU notifier cannot fail a blockable invalidation, so wait
> uninterruptibly. With MAX_SCHEDULE_TIMEOUT an uninterruptible wait
> cannot time out either, so drop the now dead error handling.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

Co-authored-by is not a valid tag.  It should be:

Assisted-by: LLM

> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 9c6b7353cbe9..84ab8a55b7ab 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1286,16 +1286,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>   			 unsigned long cur_seq)
>   {
> -	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> -	struct drm_gem_object *gobj = to_gobj(abo);
> -	long ret;
> -
> -	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
> -				    true, MAX_SCHEDULE_TIMEOUT);
> -	if (!ret)
> -		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
> -	else if (ret == -ERESTARTSYS)
> -		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
> +	/*
> +	 * The pages must not be released while the device may still access
> +	 * them, so this wait must be neither interruptible nor time limited.
> +	 */
> +	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);
>   }
>   
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,

