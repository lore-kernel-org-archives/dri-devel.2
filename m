Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28214C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0126710EE14;
	Wed,  5 Aug 2026 11:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hq/yAZ3n";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356AA10EE0F;
 Wed,  5 Aug 2026 11:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS7zh9vTQb5PaGPYAS8+P3lIjaERzsYHlRF4mETxhqflkPf3YCA5FZ7ZVXifKTVpPVf8W+Xlssv80XCoet5uofdL30Xd0iZ4R67wSlNsDcOakZCL4xMFNFlBumU2w/DhB6GT8BUmNP3l0mMmqrqAP8yLhQ0xMuGmei3mZVqZDHksMenENvS63Zzfw7Iz9XSLDtr8K/fAOeBd5Lsr8xJr3vR1HbiNEmKChQCQA/TbFlk/Ql81vuT7WS8YKvtV4EMmDVcGWsCyw+ArCN424lb4GhRWh2MCn66KJpVh99Ejzt8gXHxa/xgNkyi5zCAWuHnNObcaW1Iv86NstvJrkMTt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFdNpUrGn5XNk9h88UdwIJdYgvbumUWpKbhgc/Kibrc=;
 b=jiwjsWLF6SynAS59F3rHMvTLtV5jsw0SXI6QL7eBxKl84Jq/T8Q5aNLocbF7WkMRI4d8igShArIKNnU37VkNjWqh4uYWaTNhaaQDn+PH+za0DD4InxaZTvA55KXw6hZoXgrvonyQZi8jEc56bmUehSw7zmt1W3/mPYeOJvi1XeM4er0uLYK+3v9THXDvNoDx45O7gcMgSwrq5Ue/1KqsWplP4ysZat5Lb6/6T4a6cWjmEBrox2qqkX3Arvq8pQxwr9itlbm7302D44fBmP/tiGVBbKc5Y2/FWIy1+XOUsPNIzndj9vTtdudMNTAUjpXaTfjZ9/gKQxkDcx8E92Nvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFdNpUrGn5XNk9h88UdwIJdYgvbumUWpKbhgc/Kibrc=;
 b=Hq/yAZ3n7EplcOcOgJ2FEZYJ3dAL+Aiq1HBEiGtTBGvQ3i/a+fKUzid4nWGemtsFdPtn1MOsLQhp6G6jBVnxhZwHZ6eYmmfiMGIuZkOQYFF7Fv5DckN//5x6CB0qup+btACLRik8ApfQRNpyhTHajKDxkYzhEG1piwC+R6il50A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 11:43:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 11:43:11 +0000
Message-ID: <0ede7c4b-955e-4417-a58a-4a18a1f08790@amd.com>
Date: Wed, 5 Aug 2026 13:43:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: restore hardware polling in
 fence_is_signaled to fix performance regression
To: 2564278112@qq.com, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wang Jiang <jiangwang@kylinos.cn>
References: <tencent_38CA3044B54F14EC7314032134C531AFA807@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <tencent_38CA3044B54F14EC7314032134C531AFA807@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: d33c4d00-aeef-45d0-3fe7-08def2e6ba4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GjrhMetKPMj92TISG4g0wEE2+anIE8p5BDHY6twBL1kt3HpCE0hDjJbOkoL4ZBTJXAviiPNR39/WPG3HomSNlKaScSNmi0kSTXHshaW3BiRgE7QtFN+hkPwxAyl6Y92PQFC8UpiKJf4GNftobwkRClDOeFIcNdBL34909uyJNgGYyhjqggTKPrt5jDzndWjzMD2e/Ed2Dfc2tjoEtsUwIqasp41bHF2avZEdd4nbEfHDzO+g3rXXP2KL4oRJJejfPpkgP0+yGwWmg4cZKdDZDRddiVbpar3/0IJog1fR6yN9rOhrGJKUW/IC51Id0yd9Pnd0D6bcBgBQ64yt30C9RCROtESuYMcQRedMAVdQWSjj+EuLubfYJGwrZiYGE/UfYoHJNBhtvdHc6f1onKAtxpB4WQ5u45OIWvyODF+Ss57NgTRDST1hu4PuQlb5UdNaq5garzeGs8sun4BC9CihaFhC/bbdm5DMbbwoI++ZcaNncWHrHTYPmi3/xx1C54JuCVIySUF3JVx5lIEYN38/Elkh6pUGbiH6E2xA10DderuRewxajXtgtw3x9vrTqhIOMPKH5XKI3lyBAaZR2hmsY7BwOa41fbXeQSLLkICokaoMfFNA7Q2n22G9BuTYd3doLlnYfdhb6st33HN7exh+jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNqMDFmU0x0eUJxTlEyVWNNOXUreUw3b3VBOVgrOTdxL2w4czBvTXJEZFA3?=
 =?utf-8?B?Qys5SEU3MlZEbnUwK2VjcWd5V1BMRWdFQklOMGhsY295VzlSRDhDRmpRQVpX?=
 =?utf-8?B?OW0wUnN4a0JxWUZaS3Q1MjdsMjM0S3l4aG5SZWxkaXF4dVlZUFN5Qm5YcGV4?=
 =?utf-8?B?aWpUYzBNMGFwWkxMVXYyT0xqMVZnaGY4RDVTc3MxUjZwMTZmZEMrV1RuRXJp?=
 =?utf-8?B?N1N4UUJNbnJNZHZTa29HTUFzQ2ZhQXAyY3FuQW5QK3g3NmZvcVNqS3VOeDFm?=
 =?utf-8?B?THRSTVpPWStOWHJOTWpnZUUwWlp4blNUNElQdDVsZTR2WUZORHJEeDB6WnVL?=
 =?utf-8?B?SGxYdHdTdTlnNE1oemNZRFRYQmVEUVJSRmNDVGRPYWhFbGRZelVEUEpkMDRl?=
 =?utf-8?B?SERCSTRnNlU3b1JRQytyWVVvVXJoY0RPOVdIcTJvWUQ1NzVzTVdZZnovdW0z?=
 =?utf-8?B?dHRnUGlMRFB0dndhVzJqcUZ0elk5a21VUmhUL3lFNm1IdldzbFpKdDhCZHBa?=
 =?utf-8?B?Vk1OV3JDN2Nja3NjQ0xqeVp3Y0R1dzl3OE9XZFUzNFY0M2JHbmdYM2wxSWZI?=
 =?utf-8?B?UnVLLzhmQzZnNUJjQWZPbjRIMXhlNWIvWjlMMVc1b1BndDBkQkhIdzNUOS9a?=
 =?utf-8?B?K1dWY1dHbkYzTTNVYW1mTkxZT1pTZXhtaDBXYmxxUHVlVjBvVy9ZTjF1UkNl?=
 =?utf-8?B?Z2RQdk5YNEdRU1I3WnA4TFlqN1RCMndrL252MW0rNGQwdUM1WFNLVHovcFJs?=
 =?utf-8?B?bzYzbStmakc2eEVGZW1JTFVPUlZBNXJrbmh4d0JoVWcvdExCTnFTZGM1TjJQ?=
 =?utf-8?B?cU1EQXd4UXI0VmUvSjZJVTRyeDk0S0RFNTVLUjdqaWZJOHUrREFTbUNGb0cw?=
 =?utf-8?B?UUhWT2VFYWplVDRHbXJBUmNva2VHL1lqbWMzdlJpSHhEMFV4UXNVRjNmMTZQ?=
 =?utf-8?B?Y2JZa05rSFI0R3ZzQVh3SFFlSFVrc3hRT2R2QU91V3VMMVYzVXhUUFRoUk5t?=
 =?utf-8?B?MHIvSm1saDFtQmpERGorcFUxa2VmdVRkVmp6YVBtTUJ6UU9qb3grVG0yTU5F?=
 =?utf-8?B?OVpvRHdNRmlSRGVLYzE2U2RRdEc4TzhSNjAraVkzNUdGTHZvc3BoWkdKb1Qv?=
 =?utf-8?B?VFJwTk0rdERGNVFMNDZnS01yUmNWRkUzUHl2MTZkV05KVS8wWmV1a3hXaVor?=
 =?utf-8?B?KzNlOXBaQWJIdVJxM3ZCSnkvNVFyVlNEK2svWXlxNEhKajlpcEYreXVueU5C?=
 =?utf-8?B?ekRtUmtRMTVBRmdiY0x2WHNYbEd6TDJIL0RURXJCQTlKT2xOMFRLZFFVWHBP?=
 =?utf-8?B?OHh3c1VwTXZxaW1ZRnlGcGtPUmVPdk5ISHN6ZWdkNU4zOW53c1hwcUEwZXR0?=
 =?utf-8?B?U3BnaWJTZVlTMmIyL04zbFpRQXBKYUFleWVNQ3Ezam1vOHh2KzM1cXVveGZ3?=
 =?utf-8?B?T1EyNk9JMmpRZEN6RWJSSzI2dWJQelNRODA1T2VYek5VUDZpNUp5K3p3WVFh?=
 =?utf-8?B?MWQzdk01T3ZRc1lMa3BGaFpGL09sckZVU2hVWUdoZS9tOGQyRGpOSGVrQ01P?=
 =?utf-8?B?TjJ1cEdBRFp5eS9TNlBBdWgzMWNxd3Q4WlY4dUFSSXBqdWF1bUtkSVk5RGFq?=
 =?utf-8?B?YVR5WU5KaTA4b1JtUmo0Sm1qUTgxSTFXaHhSUkgzMVJEVFM5NStuVHlMNTdp?=
 =?utf-8?B?NTJhaDFpbDJTNkJwd3hlUmV2T2ptYndvQlo3Y0J1ZUdxVFF6TlVVeWs2WUV5?=
 =?utf-8?B?RFRBWGVBTGJac1NrTUt4UzdEODFrZDl1UHQ5ZjB4V3BZM2IyZ04yakhzSGht?=
 =?utf-8?B?TGhEUTlsUEtPWGJydkh4UFdFUTBPdzYwMXpTTVhTdXkzbFAwbzNYR2NlRC91?=
 =?utf-8?B?WUgrQ3JvRU1GYTFtN0JHMllxWjMwemNzVGpadmE3WmIyN0lwazRudVB5dER2?=
 =?utf-8?B?cUUrYUx6ODEwZGRVRHdaVGdqejRpeGhJT0JVb3lGcytYYk0xMlRac0dQZ2Zz?=
 =?utf-8?B?WXNFb0dhMFpiTFRkTVd5MlJNTk5xaTluNVlvMU1Sa1RSVFUwVm53VTFWNE5F?=
 =?utf-8?B?eCtObktkdkNmTkhDZFJ0aW1XVW9hN1Rwc2ZvU0xpR0l6bWF3NWc1b0lNTktz?=
 =?utf-8?B?SGZrU1FZTFFMb3ozNjdpOTBuMGFCZHNLdnJlSzNYZktpSTgzMzBoZ3J1Vk9M?=
 =?utf-8?B?YlRGcUkza2pqWU15bFc2R0Mrd0Y0bk11TERFdFZESnBsT0ZqNmxLbmxWVDJR?=
 =?utf-8?B?eGVhRUJCbUVLVlBkRWQ3VjQ1NE5hTW52MVp0ZTRTcWQydUVWYTVLYmthc2dz?=
 =?utf-8?Q?26B4XOL5OWsFW7o1Sf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33c4d00-aeef-45d0-3fe7-08def2e6ba4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:43:11.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLhrZ0od8paSXaugyG2/8clG2VoQg59Ki7BqC74Kp5XU1rKxwWeCD95lRERKzGbh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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



On 7/30/26 03:56, 2564278112@qq.com wrote:
> From: Wang Jiang <jiangwang@kylinos.cn>
> 
> Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
> is_signaled, no deadlock") removed the hardware status check from
> radeon_fence_is_signaled() to fix a self-deadlock caused by
> wake_up_all(&rdev->fence_queue) being called with the fence queue
> lock held.
> 
> However, removing the hardware poll entirely causes significant
> performance regression (e.g. glxgears FPS drop) because the signaled
> check becomes purely passive — it only reads the cached last_seq
> without probing the GPU, so completed GPU work is not detected in
> time, causing unnecessary CPU stalls in sync-heavy workloads.
> 
> Fix this by calling radeon_fence_read() directly in
> radeon_fence_is_signaled() to poll the hardware fence counter
> without updating last_seq or calling wake_up_all(). This restores
> timely fence detection while avoiding the original deadlock, since
> last_seq update and waiter wakeup remain solely in the interrupt
> handler's responsibility.
> 
> Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_signaled, no deadlock")
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_fence.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 02a40e4750c7..047ec5a1d194 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,6 +360,18 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
>  	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
>  		return true;
>  
> +	/*
> +	* Poll hardware directly without updating last_seq.
> +	* This allows immediate detection of signaled fences (performance)
> +	* while leaving last_seq update and wake_up_all() to the interrupt
> +	* handler, avoiding:
> +	* 1. Deadlock from calling wake_up_all() with fence lock held
> +	* 2. Wake event stealing by advancing last_seq without waking waiters
> +	* 3. rw_semaphore usage in atomic/irq context (unsafe on PREEMPT_RT)
> +	*/
> +	if (radeon_fence_read(rdev, ring) >= (u32)seq)
> +			return true;
> +

That check is not correct, you need to take wrap around into account.

Try using __dma_fence_is_later() instead.

Regards,
Christian.

>  	return false;
>  }
>  

