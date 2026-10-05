Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF20CA5FF5
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 00:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958EC10E5B4;
	Mon,  5 Oct 2026 00:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWc8UqGL";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF2E10E5B4
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 00:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiBezQT1l6UIUKBSAGSRznCuORRRYD5D0kfONQeJydjfmEQ7e29ZcrHjFJfbJjXMHAmexuifXQhd4SqOxw5qjhOloDtqFU4cXd77mfWuJcTb86yk16xAgYWiIp9/bk45wPvHEVRSRBvvxd7CQPFNEEmZnk6WTjfMl0a/uYhvBEsk7nI52SW+gQCT1ePwD6VSZdXuffsPYKlPZXkCG18SKCopXkIIt4iv2KyQ/uqV3ft0SHGqCHawoToAc1qQh8Ac8bO2zS+xEjjFxP+ep28qZHzeaUekxXOl+P8xdKNJIjjPwJqGd+3EdrYMVjVm5fouSE8srH1urSsCENlVesTGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxLYen+ojZMClb9lIE+bvY2/aJg6KsDyC9hmmqu6tR8=;
 b=Y7w6HGc+b1ioAdb1/+dR3zHa1mdByhNW464YisvHNS6tsMIaPKfUo+nIu0qS4wCqRjkb4v6PzaD/haT0VZSe1KYSA69M1HLL4giepgjbF4YzisngX0bt4QGpapforqRE/hlGuTzC1SZ5updS/a1T7boSG8yjB3Kby4gR9vd0wO0IAWGM0XhfiD9Vt1Jp3E4CZ8nd3C0F7KiZxtffyNdVsfzFKLcQe+06wQWqHM0PiqYZRwvpLxs3Yl5r2J7hvNCLdoTttfe15rXxKxydfkVCNn/di859R5VDpBpFKcgK3t73kIK0bFeSTi7+7oSrkPJoFHo6UuojNWsCGquvOJnMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxLYen+ojZMClb9lIE+bvY2/aJg6KsDyC9hmmqu6tR8=;
 b=BWc8UqGLB34E8fxE1P81AMbrxKsvvS9NbUpN2oifSNAIQxc6SWpCzv1Xh7+Em2zOtqrFjgzorXqIi2ynBVwQvDIQ5AhRs6d8HDK9bxqElz2aHqgHldgHy+rhaOhFTuItU1+VQ0bBvz6QiMuDOr78eP9Bom6FYVr/lv36yrisQfHoltvxgPlwIiF39WKI32I6Z69S+SvPI8b51HwPkrPSgMlyY6FPt22a1gZkIAg39elb5cShUBaX6ufj5EGmNB7/8MbbD7gtvpd2Eh0TH+cyG1hz8y1MDkWEcHXPYLHdKvqDaw2nj68R1Sf429MZTAwqNYqoaabmY2quf0zpRQ6bPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 00:59:37 +0000
Received: from CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056]) by CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056%4]) with mapi id 15.21.0472.015; Mon, 5 Oct 2026
 00:59:37 +0000
Message-ID: <969157ef-9ff6-469f-a900-9b8ea326ff9e@nvidia.com>
Date: Sun, 4 Oct 2026 20:59:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: drop stale @p from gpu_buddy_print() kernel-doc
To: Rosen Penev <rosenp@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>
References: <20261004235255.547593-1-rosenp@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20261004235255.547593-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:408:f5::27) To CY5PR12MB6479.namprd12.prod.outlook.com
 (2603:10b6:930:34::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ecfa87-702f-4127-8ec9-08df227bed97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: axEpACFfjAurtE7wRENp97MXlSAgEYf20xOcOdQV4quGzFeL+8eqDyVoVCLuDBvsJ+XUH9z3Fs3idnX0PwzT8UNmGbEA9eo8dMV+FmkJEyw46s10/wBGm+3liVKcvxwdQDqG2+WCPLK1UMZIhL8YRHrc1NcQLWPnorA0bb12yTaK1OyXm6CJ9hIUpRjC8r96zYyQbk/qWsDoW9QU8biGoadP8kj6/JPZi2BHTd9r7r+FYR4wLtzfwCyGMSx0gbFXj/xiwiN2h9pJCKPcF1YwVOKAH6FiTp9ZrQAAXfoRwL+bNBWaK2bmCiH71keVknEuLOk2ewqFqSavVLuatKVo8PdPf4YBtnrDgCxL7g7Ic7HWkXEd9Aj/5zdQj1fgvzlrRdjkiKX+ws/dKv1vvqJvy2DUKQh5HjvnUtLaeeC2XQ0deuKrS1dACyrCcIkKwvcrsKPY18QFW0eItOeQwiXnkRXdHJnbFHCn7sT7JEP/jdemcTnL8AI2R6tXsudUySM9fDukJCfXPxmXHI5RHqTq7SngnObiTAvks2Ce/EodYHLYTLdJbEWeQ2F2U4MYJskyhH4fBHK9UN5eaKKWMjQovUpI1Oq66gua3AA8+ts1fUY99OQaTp3Y5/CV7zYEvSxsptmcjxMxYsU9OLTgR5wuDIjA5/s2tWAnYylRSrmK56Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6479.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0VwR2cyUDFRaHdmT3RWb3RUc09wRzNTcmV3RlRNY1locENFbmZrOUxRZnJk?=
 =?utf-8?B?WURyZnZmcmtXSHV5WUVQdnMzcWdIbnFCTlVacU9JczhEa0VvWUxydk5Fd21i?=
 =?utf-8?B?LzlWSG1ZSVdDY2RUa3MxWjRCem9sbENjTVNpU2Z5Y0tDc3BEVWREaksyQzVk?=
 =?utf-8?B?UktZanFRTlo0b2gwSm1sV3dnVkhteDVPRXk1ZmsxWGJFeTJpVzViMUwxWk9B?=
 =?utf-8?B?UVdKbWxTckZ1WVRudGRrdUtydXcwcFlGbHVSMTg2Ync3M0F5VzhlbEFmR0hL?=
 =?utf-8?B?SmtVUVJjb2lNUFZLM01TRVY3TG93WmVydThmM0hvMGkvZkM1Vk96YllLMFVK?=
 =?utf-8?B?cmUxNThGbWVIN1FwYlZnbHh5a1dtdlp4RU14YjdhR3oxekxmVTJIaVNONS9j?=
 =?utf-8?B?MWNuZWc3TUIxeU1PSDhmSVl5SURiWmREaDNUZW1BcDVmbzJ4azJPTkEyUFhR?=
 =?utf-8?B?ZlBBVzhjZFk0T2xqdy9iNVJINUxOWHdyajlxSUZBTFZtYUVNK011cXJTUjNr?=
 =?utf-8?B?bXFkcCtMTjdTZU9OeXZHZjErRk5TQWlXengxMDdibHJRelJYZWgvcUduQSta?=
 =?utf-8?B?MllTUFN2U3JrMDFzakQzcG5waG5USHFVT1VrdGZvN3hhd096ekRRRklFTi9T?=
 =?utf-8?B?WkgwWDhQMUxMWndONktUTklMenNtQkZzcHVadTZiWElta0YvOFRqQjFZemhU?=
 =?utf-8?B?OEZOcU1OUFVVUXUxRU1EQ0UwVTh6VUowQjNiSGZKaE1HRVZOekJxeVFsTU9X?=
 =?utf-8?B?ZTZMdnMyOXp2WWlZM3VyVGV4RDFyUHh5UVpQaWU3T3BFQVluMXlqMngyeXNh?=
 =?utf-8?B?aC9oQkVXcENxcmlFUVFzc3E0S0xCTkQyZENnTm9zUEMxbTRRV0Q1aGg3Sm80?=
 =?utf-8?B?M203c29GRVZ0YTNVb0FkeEVnQ1hHTmVPaWJzZlVaSCtZVXdQbE1iMnAxc1ZY?=
 =?utf-8?B?UU1vNHBNaXM0Nm1EczVLNEZidkVGb1dxK3dpd1hvSWtLRkprZ3ptMjRNUFVF?=
 =?utf-8?B?TDdtaGlMRVpuWmRldGRZV3JzclJTd2xXdm9qelo0UmlnMkMxWlA3MGJBT3Qr?=
 =?utf-8?B?QzRMODhTczRRN1dqSUhSNE5ZTlZNSGlKTzRkQlM0NTl4QVBhRXBDem1XbGgx?=
 =?utf-8?B?OEl5aitrdEF5YzZWZVZrcjJDSzdHdGRUaWxVL1pWdmlubDFnUWNVZEtDRi82?=
 =?utf-8?B?UG1vVkpNSWk2cUZieVNsYllnNWlJaElhY01TOVhFWUJoU2N5di9XcFV1cXVn?=
 =?utf-8?B?emhvN2Y1aGRibXpRZEVvRUdvS3RUNXQxM3h5QS9TY0FGdWJZZ1Ryam1tZXdz?=
 =?utf-8?B?b2ZVVm14SkZaM0dJZDVEa1VreDhuNEx2UWhkbWk3VlBONzc1SDEyVWJETndN?=
 =?utf-8?B?SVB2QWVUcTZPZkVHMW95d244TFRmVkt0Sm9wUUthQTZGZU9uT1VqTkdnY0p5?=
 =?utf-8?B?RFV4eTlQNEY2WTNzWnliRmY0WnlINlcvekdXM0FvM1ZrcG9iTVRrME1wOE1D?=
 =?utf-8?B?TGN6VEJnMXBPYnJJK203S25BRWZlZ1NsZm5kd2pJcXRDTnRGZFBYTzRQY3lE?=
 =?utf-8?B?VzVCdUdLUGNCMEJwRHJ2ZjUrYnhTSnM1bHlOTEtCOWdNMkdZeEJhaDJBVk95?=
 =?utf-8?B?NWJFdllPZWUwZmRzRHNnbEprQTRIb2NEVlBIam1pM1NlSTd0aUNrdW5sVll2?=
 =?utf-8?B?UEtDSTB1ODFLRTd5VWVodndsMGV3VFJIcjJHOGhjTk05OU5iNDV5c2F2R3lr?=
 =?utf-8?B?NS9CMnNieE51d0RyQjV0d09SQk9xZ1ZROWxBSTE0UkRndzBZMVl2cEszL2hw?=
 =?utf-8?B?azJldUk5RmkrV2N4T1lXVUluVEx1eEpiS1lySXI4cnZ4aDh5K2xId1RscGQ5?=
 =?utf-8?B?L0Q2WG5SdVNQQXcwYkV2dTZMdXp0WjRRRVZiOHBzN2J6ODhWZEI1a3FzY0Mx?=
 =?utf-8?B?cTU2TnMwVnBzaHdiS0gvcUJjanBXZXUrS1NOSDFMU0NYQ1o4bTUwMzZRdm5i?=
 =?utf-8?B?dVFUVi9HdThiSzdTb0xaVmtmMnlaN2p6a0RlUTJRVjM4TEtHUDc0Mjg1anlF?=
 =?utf-8?B?OWlGQnhVc2dxVWFkRktIRm5NSkRVc05JTDBHMXFEUzd1U0tLeStJSTFudEor?=
 =?utf-8?B?ZTdHakZXbjBlenpBTXNZYVpVWVpSaDRxK25JTEZvNC9sdm1ZRDZ0THlCT2FW?=
 =?utf-8?B?MnBkUjVpSVhBcWFrZmwwbXBPM01WWklIZVJZUDc5cWtKeHgrc1FvUmNaRDN3?=
 =?utf-8?B?a1l5V2U1RDZYRFVUNUMyM05PTndhbFEwbUlMaXlnUG5yRXd0OHNzaVFoRHlm?=
 =?utf-8?B?bitBZVpYWUkxS2J6Mkg1M0ptWHQ1Q1YzL2dJYUJNVTFtS1BDZnBxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ecfa87-702f-4127-8ec9-08df227bed97
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 00:59:37.3969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3yYZipzgsecXgnnCP6A/9tPG4QJPQUX9A66AqGDmzTWDjCSmHDEYVugyoPNaOO2jrM4S1WTod2uqINs2kPZQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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



On 10/4/2026 7:52 PM, Rosen Penev wrote:
> gpu_buddy_print() lost its printer argument when the buddy allocator
> moved out of DRM and now prints with pr_info(), but the kernel-doc
> still describes @p:
> 
>   buddy.c:2153 Excess function parameter 'p' description in 'gpu_buddy_print'
> 
> Remove the stale line.
> 
> Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up (part two)")
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/buddy.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..503f7d5934e4 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -2148,7 +2148,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
>   * gpu_buddy_print - print allocator state
>   *
>   * @mm: GPU buddy manager
> - * @p: GPU printer to use
>   */
>  void gpu_buddy_print(struct gpu_buddy *mm)
>  {

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>


