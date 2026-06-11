Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD7CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8FB10E7D2;
	Thu, 11 Jun 2026 15:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xI5S358D";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0185A10E7D2;
 Thu, 11 Jun 2026 15:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSBSu0fz7lNdBPA68qnBvlWxLtJWeDlr3iLzzEFdYQkBpJ4yd8CePG0ZTlEcbGnRtj23Ad8Boim5Lt5M+BuVR73rgutvZIpkIcVzA0uCf1i1lfP8GBR++bANlq7zhIQ9eRmNVeq/VPl4ikixHOwvp3EYAzwu/stN6gS6CoUNlXyJwVsQOzy/mmWl/qV+22M2PAHbwskLG0p6NSVoAtggs7UjiPBwVnIYC9cKiqHazBvXMXtFSjV9YbkeCHasWaxySWNpBeeDCW+mKlG2i2w80ke8HD9HZzWF5V2Lq61HYXx+jR5irIlm7iNAL7Q/oWo+baAyc44P2puXPcqCsw+2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az3fI1Ch7M6JVidhcXqOlfFzH1wSD3+fsx9WASPo2Bo=;
 b=YaFYcSVHFqdAkDIuK6uR9uFFNvx2Uw4diDQfFDiExqi+ady5fyW2CnqmCzdOJ6wQuCAb4peoOnsC/GzEK8dMSmwuda/HD1NeBgWFUqUMbjkcpRQG9G9BddhaX+jO3jbyNwdPqOjh6ZVG2kMV7nuwjwRXdAeBkcaz2x+L/P0hxWjSyxFcSre3pMaxEM93tq9cF0qW65yyHZEX8B8bq0gNRWphIBwolJLBpTB4g2osyaD8JMtKIBC0iEAM2Awgu5smfrhkiOO+CXt+sPFRpC4QWvjaCNMAp4r3cMD/2MeuxKUICrqJEsfgeCZS7OLUap0b7pFQGiX9AkIhCwUwKh7p3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az3fI1Ch7M6JVidhcXqOlfFzH1wSD3+fsx9WASPo2Bo=;
 b=xI5S358DnAXbCQ5MDb6TksYefagHCfQ1bvVh6KXECZStkyeXiCYrid7Gjpz+hxp0DjLiwutpk+4TuIxXcg49kfdQSDvInWHQNDSts9B8r/XrCopJyQ/rfMzaos2+27Ed1mg+YTe/aK0YYC3230Og7it2YdBMMD0S0IkYkH4cu20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:14:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 15:14:26 +0000
Message-ID: <8285bb4c-90ae-4a79-8f82-a8f42adb67f8@amd.com>
Date: Thu, 11 Jun 2026 17:14:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: lockdep: move temporary mutexes off stack
To: Arnd Bergmann <arnd@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260611130240.3388318-1-arnd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611130240.3388318-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:408:111::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 390ea7aa-912f-4e50-3c22-08dec7cc2074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TIPP/0W+huDgh/xy6vchz+TOgIak2W83O6wmUmDL0bA1D0idmu7uL7rtd+0e+tcQKtmCPQj7EusxFfkZ76AFXF5578t/1MAZkyYJ+zKrO/TP7XNpWEZvqGMnUgQrFJpDXw5Ul/A8eR5BIsVSZDQUaatgzUm+GRucUsILtgc9ZVrAKB/yeoVf2y8Xi1XOhT0FvxQW7b8W+mo8nC6O0JKvsGs6Ag5zg7faTAj4/vf03gyKn2N9RP4DVx5lpHl36Zcnunjnk5rXtUwuNufxTOi/7AtcmULF9qKZN0Oz33dDupKjEMev+v30t96zmY4IcCndXRwVytTaxLtEGmpbMUotTpgdZhzqzr3bAwQbcKXJT9wHDHdD6odoa+ezrK9tvEyadqL9FpN7KKL1wgouP4e9v4LJP7Ocy7GJ2rcjisW4aZG/1v4ng4WIFCN4B+B+fHfLVXaxzl81jOo0qEWyQrW3AHx7P8IOK2JZyx1XgWgl+ZP20VN21lKGSYQMMs8WKlrAx6Mju/r7tYKRyHrkBnCtJmHmDsxiHBwhXjsDGHVZQ1h3I/2mopiciWZatdFmE9GeJ32bYUAJEtTaN16w0PfuAD1Cb4WxG70D6WtI+XHPNxZqbIR9EVdEDzxMTXW4Mt4B8bZVJqoeud64ndskmgA/5wKZkyBwnweXuMemIsODN58dpHPTZ/up8kEm5dR6u0UG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRvVEFxbXpKMTZoeE5QNHpNOEVuWUF2SXY2Y0g2Q0FUQWY3bHNnamxTUnRD?=
 =?utf-8?B?eTJta1dUMGNsdzhSQ093bmR1cTJKMldBVk9XaW5vUnRoZXVtRDFKdi9HWUVj?=
 =?utf-8?B?dnUwazFIY2drb1pXd0NpemJYWHFjemVTSkR1T293SnBnV1pNQlR5R3QxNk14?=
 =?utf-8?B?dlhlYkNPZHFkT0trcWpqbVdwWlpreUdNNU40ZDNYMFZWQUF5STYzUmFTbTBC?=
 =?utf-8?B?Wkd3YXl1MGFIYU5DOXF0eVdIMU9mN3dlcUhIdUxMYlJReCtmY3BDZWZXelNQ?=
 =?utf-8?B?SVJKUFhiZ0lrL1Z6dTI0MVNiRXdkZi8zQ25aT28wbWxXdjg2Q2xtbHBiY3FS?=
 =?utf-8?B?SXIra3Zzd0JxQjlwRmt1YmhFTUxEdjE2UGx2Y3FHZVhLWENucnZ5eE9TTm0y?=
 =?utf-8?B?ZDFXVFRxU1BGVVRmL3p4TlEyTENvRi9TZ0diNEFnMmZuZ0hVMGVEbDFabVNH?=
 =?utf-8?B?VjJFdnplbkNPTk5rS0E4NWlOcWdyeERNejBPTE54YmJzMk5iZjRwYldCVVZK?=
 =?utf-8?B?UThzWHk1NjZSdXZYTTdsMDl3ck10NDE2N3RNQlNJaHJFdytiQzQ2VmdjaHl5?=
 =?utf-8?B?YjFFNnphbWhYSmd3Zk9uc0VRZXVnbTBkTytPYmpjRHNHWkE4SUpXYjdMeG44?=
 =?utf-8?B?TU96dStqTmRGS1hGWjZqMXJXUjIycFppekIxUzh3YTBqWE42TnVRR1RiVmJn?=
 =?utf-8?B?V1IvRHd6QUVrLzNnb2pEbnl4eHFEUnRrSXNSMWRDWkhDVkdOMVAwQS94VklG?=
 =?utf-8?B?Vi80ajVaUXlOWUNwRlBkT3BlM1UyVjY2dHhZM2xEMVFaY0JXcFFHSDIyZTh6?=
 =?utf-8?B?T1JkRGI0YUswbGNXOVg3RW1XSThQNmxkSlJvU3NxNUVLa1l4Q2daNnluMXVR?=
 =?utf-8?B?cE94d2RaTWdtYjk2Q3VDejlDL1FjWVA0STVRY09HbUVNNEpmN1RGb2xVMWY4?=
 =?utf-8?B?bzZ0VjllQ3RFd21lbG5CYWZqS2x2eS9mdEUrdXRobkZiMXluZUV5NnpKZHYv?=
 =?utf-8?B?dXM3bkd3SjJYclVXNTFwSlFDb25zbWcxSzdDakhFMVpZVFNORlZidUJSSnNi?=
 =?utf-8?B?L1dlZGVqZUdUem5aVDE0cDNwNGM4VHE4K28ydlE4MmRuQnVmbmVvb0hyN3hU?=
 =?utf-8?B?cGUrTGRuaElvc0NOUW9qSHVDVm9LbGV5OHF4a0VZNDUyOVdXUUErUE5qTFJL?=
 =?utf-8?B?V1N1WGhMWUZHWUg5WXRoSTZ2Um9xc21pRmJEWjhrMmJ0VldVdVJGc3ZzeEFv?=
 =?utf-8?B?S0NUbldaSkVtdmx3UlZIQTcxc29aZ212a0Q0blJDMVpSZ1VpaW9WWHdwazhU?=
 =?utf-8?B?MGg2ZFg4M25JV1ltOXJ6bTZYd2tabjdmSWlsaWF5SG9NcXZhcTJ5Skg3aVor?=
 =?utf-8?B?N1J3NDhUUWZheUN0QUJ2Tm1iSWZSbm9iSWFHeXZJQXlROGR4cEJGRk9wSTBK?=
 =?utf-8?B?SUkxdkNEWlJMOUZKRGlnbDFDc3hZQVNzU2sxVllNclp2bUs1S1VHSm96QVVD?=
 =?utf-8?B?dGovYlZzOG9XQ3N2YmpxQkg0djlYcmJJeU90dzR5bTBXWGFMT281dlRKVVp5?=
 =?utf-8?B?SHAweVVrVFFWTmpnTWdEZGgyRktPQ1ZOb05sRU9pa0QweTg2OW1kbGVQbGFY?=
 =?utf-8?B?VXV6WVNOcWRvOUZCaXRwcDBnSjVLbkdhWkhxeHIvY0c5MHhFajl1UWtMVitW?=
 =?utf-8?B?SHRGWlBFaXMrSDRYRDhla3U0Y3Z2SWRwQWRiV1kraUtLNkxQc1pIcjRhL3hC?=
 =?utf-8?B?SkxGYUdtcUdpQVVHVENTTUtPbDhlRHYxL1Z0T2xIQ1laZ2Q5aDJrajAyM2pz?=
 =?utf-8?B?T3d0OUFBVVRuUW0zTjB3VDFtMGszdWZ1ZDNaVm9hQ2FlQkN1eWNIbGNKZmVp?=
 =?utf-8?B?T2hlRUlSWlNwNDAyUXhyWUhqTlY3dW1FaUp4QnhFQVpRalVlL1pKRUNNVzNY?=
 =?utf-8?B?N3UyQ0Jjc1EwMzdjYWdxajliQTJjTXdYblRHbjJJbDhOeGNQN0h5UGZZMmwy?=
 =?utf-8?B?WGpKRzlpZnZYYW1iR1dRSmZ2Vm1HSzhzbTFNZ0VyYjViNTErSDU3Q215djN5?=
 =?utf-8?B?aXNaMXFQOTdtbjdEeDVqZnI3WnF3SXVaU0x2UW80NFhCMDBmQ0JLbDhnd3RJ?=
 =?utf-8?B?NmY3dFZraXdHK3lSQVRPRlg4YmFha28xaVVmRnladnNPaWJuMUx1MWJXMGhy?=
 =?utf-8?B?ZnF5QWxtTDZGV2J0MzljM3UvNFFpWFFkZTVsN2ZEc3ZHV0lsVmlMeG9VUlk2?=
 =?utf-8?B?SlQ3VXZlYU9XQy9KM0RueXVURnI5allQbDBNamxDdDBTMGlqMHkvNlN5Wm9G?=
 =?utf-8?Q?JYfcw5xLqLTfrAkyqi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ea7aa-912f-4e50-3c22-08dec7cc2074
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:14:26.7311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnHofl6TsATcqhM1L7Crukc+sZr9jFbOTY8RAII/wvwTAd7g5aH03zKY/NOCUb3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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

On 6/11/26 15:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In randconfig builds, the newly added function frequently exceeds
> the limit for stack frames, like:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c:84:5: error: stack frame size (1312) exceeds limit (1280) in 'amdgpu_lockdep_init' [-Werror,-Wframe-larger-than]
> 
> Change this to use static allocation for the locks to reduce
> this at the expense of a slightly larger driver binary.
> 
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch, but we already found that one internally as well.

It's just that Alex is on vacation this week and so the fix was not in some pull request yet.

Should go upstream before the end of next week.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 24 ++++++---------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index d5d71fd7c70d..cf723c9f9216 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -85,13 +85,13 @@ int amdgpu_lockdep_init(void)
>  {
>  	struct amdgpu_reset_domain *reset_domain = NULL;
>  	struct amdgpu_reset_control reset_ctl;
> -	struct mutex userq_sch_mutex;
> -	struct mutex userq_mutex;
> -	struct mutex notifier_lock;
> -	struct mutex vram_lock;
> -	struct mutex srbm_mutex;
> -	struct mutex grbm_idx_mutex;
> -	spinlock_t mmio_idx_lock;
> +	static DEFINE_MUTEX(userq_sch_mutex);
> +	static DEFINE_MUTEX(userq_mutex);
> +	static DEFINE_MUTEX(notifier_lock);
> +	static DEFINE_MUTEX(vram_lock);
> +	static DEFINE_MUTEX(srbm_mutex);
> +	static DEFINE_MUTEX(grbm_idx_mutex);
> +	static DEFINE_SPINLOCK(mmio_idx_lock);
>  	unsigned long flags;
>  
>  	/*
> @@ -102,16 +102,6 @@ int amdgpu_lockdep_init(void)
>  	if (!reset_domain)
>  		return -ENOMEM;
>  
> -	/* Initialize dummy locks */
> -	mutex_init(&userq_sch_mutex);
> -	mutex_init(&userq_mutex);
> -	mutex_init(&notifier_lock);
> -	mutex_init(&vram_lock);
> -	mutex_init(&reset_ctl.reset_lock);
> -	mutex_init(&srbm_mutex);
> -	mutex_init(&grbm_idx_mutex);
> -	spin_lock_init(&mmio_idx_lock);
> -
>  	/*
>  	 * Associate dummy locks with the same class keys used for real
>  	 * driver locks. This ensures lockdep connects the ordering learned

