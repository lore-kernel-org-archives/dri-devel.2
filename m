Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9CDCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873410E3FD;
	Tue,  9 Jun 2026 22:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WRxzmC+P";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1A010E3FD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 22:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba+c9p/2wQ+nBBHsVMupUV+bkqpHtM7jLf7cn8+lgjUNqcziPUhm4Sgoy8n+GmC6L/tqycvoIJD6imzH6NkNueGE/P4dDk1ipw4j9kvyejZGFqsSO7mmnT639MlL2Eh0ifPqPXSUzxPuP/HyB6RnWI7bDJclYe7W4MeMuUXnjkQtZMu2m46Au1mhOy/9V4V8T+EB/LKxJkSh1S1SzTGdApQmRlUIrthpDUGlq2X5BhuyIXFqHW+LXCTqOb79mUj7Pie4U9LViBDnQMNXeAkDXBqw0XVQzfdpk6JfVRYbr8SPyKd+NY7FHTJKZWWuahJ6hjqXnjiJoLUSz3C+tmfuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puUpZonLCStDKu8/cz5YB7CB9zQprYgFp1IzwkoSu3Y=;
 b=W6pdk7PeIPrtJlkhOdROBPTdJh93SRKEVoevvG57nEieojbWQ648xV6LI238GQJBAWEOsg0yc1j9e3TR0WrKDmlqyeCgthA3CZmeKECo6oectAfiNkRmlzsvyQBtRR25LMQOvdrg4sC9PTGGL1axrSC/j1MLI3yQ7eoDnpjITxIbnd9spwlDOywFxy4aTqvAEPZtzCBc7Zr1MCxLCbTic/0f477KxUS65wdXwij/EruVskf6+I/fA+1dTGr9897AFzgpNYP0dpuLvmo3bw/QxILoVVujR+Z57FwdtUJ0VHanY7sbi0OXJu5GQEdi0hlugMBc0Mw7oxJaZvuQhSx7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puUpZonLCStDKu8/cz5YB7CB9zQprYgFp1IzwkoSu3Y=;
 b=WRxzmC+P/HO6jy/0rt0MGI4kjskJHhxzKzcfh9RgbtLQ61aJelTsVDlJXy0gn+6IfFIDI0lIHJ89Zwq97pwYrBIukqoVs9E43Y0cPNXYvwdacN/w5ywpS+6wI7YRXOGBUDmsbrHx8LnzBKqqpAn1IX8a633WTGASpQG+RSDay7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 22:46:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 22:46:06 +0000
Message-ID: <ca07f990-8b5b-41ca-bba9-2a07a26c6cdf@amd.com>
Date: Tue, 9 Jun 2026 17:46:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] accel/amdxdna: Fix VMA access race
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260609011242.2833740-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260609011242.2833740-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0657.namprd03.prod.outlook.com
 (2603:10b6:408:13b::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0bbdd6-870b-4cea-c034-08dec678e411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ebBS7MWE4ArAJTRqz4s2IaSc9mu3wLz+rbBBUhQaLJAe9TUD53r4f+eVpCXMJmnLu1itZoR+qqfuHE2MnyyfUfkrvUsteCqM3OAT0wwM2JmgvEZD4Xq+PdFQCs8m8uDL1KjjQdZcU3dU9JNUd7KPM4anOxZ461b2TxWXVy+aY4kq62mDBANf7w2VooQzM3AfK/CHnEAGJ6HXmyTkAAmaUeauKGd2mhY226bJ4aXhV55g4uhPn7T68rWrSAqdVOlitHFPPXgnBsECfLRBKhOsBzqQ+yDYOEHFj3ssACda7MztIA1BRQEPzyPdk6gNlkFMEPUWjG03InMabZ47p+o/ifsn5Takw48ICs5QGypcyCgD5y8uX1FJsRfjk3c2ts4gkMTTJ3oE04BbRmOtuTV/hcUcqqcw/e0ctSxQk0h6hX9fXZIB0is3xtuaxFgRGMdQuUOrFIQpMrL4RHACMS3P0f9j7SGK8r1FheugQWICumM6HYzpMsWM9zFJAhPDwrDaP+T6TnZwYjDHnzSqYTpYMNddTk4I659l22vF5+geuELF0R4QgM34XlCqRhN9hk4hEg/Rh7nY0oW3kmKaSyUY924Tyqtg92mfhC+u27R+F5eHnEbkAGopPBGvJQD1+Fk96FJmLWWJ+SXo7M65cYXvVMuRM60Pi7E3kqe3Wy1Wr+XtCNGw1k6WM+aVFd4vAX6+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhJZXU5QWlGY3RMZ2VsZDhMc0t6Tk9wd1BXSUlGY0dNRjg5cDR4OHhZK3RY?=
 =?utf-8?B?ak1JVU41NHB0QlV5a0pMdFJLQ1hXS0Ixbm9VZ1hTQy82RjU0c3c4RzVGMUgx?=
 =?utf-8?B?OHp1ejRJS1UrdFpJVURSUlN2Q01jZ0QxWDZubHgzSHdUU0grRUtRZVV1bmpl?=
 =?utf-8?B?RW1idVltYVl5c3pUUVBiUVBSeTM5dXFYdlMvQUs4eWNTVnh6Y3U0bUxXcThm?=
 =?utf-8?B?elhqeXFsWTVkT001cnB6VlRYWnNXQ0tpc3pnaTc4OENCZXhFOTRJK1V4TW9q?=
 =?utf-8?B?K3JZRG5vMjhnWmt0cm44cXE0amxvajF6R2ZWMnRxT01xTFlFVGpLQkdBcWIr?=
 =?utf-8?B?U3hHcGRTcHBHZFliT1hUdC85MEk4eDl4c0FERzFQVm0wbFFzS3R6enRoblFx?=
 =?utf-8?B?TlFzbjJiR0tPRUZaUWRwK0x4WUdFMGFpd2FOYU80Q1owVFFjYmtWemJuRW9j?=
 =?utf-8?B?UmxUTmxNVGs5U2dHSUJXVHBPSnMwMzdrdm1ZL2xaV25xTHJqN0hpN0F1SE9L?=
 =?utf-8?B?NFVLQU84Q1daUmF1V24zSENxMHY3dk45QlhRcWNSc2JOYzhrZ1ZScGtDMkdD?=
 =?utf-8?B?VFRnVkhSanJKeXpvcXJJVU5sb1ZTenpnN0pERWcwb1cyL2FZd2I1endiNklV?=
 =?utf-8?B?NFM4T0hmZHR4alN0MDBLa1pELzduY21oWGcvVktsZDFpVnVFSk5FNTNYVEVE?=
 =?utf-8?B?c090SUZ0UUpNRDdQeVdDNUpvazYrVFloKzhqclVtbFBVd1NMM0VUSEh6WE82?=
 =?utf-8?B?cXc2Z3N0alZMRlZjUnc4MjdLUmlyVmxSVWRTeTlJSXd5RHdSeERCU0Z1NVBn?=
 =?utf-8?B?Q0pvTjk2M3lGdWJLSWFGbHVlS1BuNDVVN0dQNHAwVm1qVWx6bGk2MXR4cFNY?=
 =?utf-8?B?WkcvUXRCM1daUGhaMTU0bjZQTjJlMUJkalBwU2JQcnZLZkdKZmF5anhQekF2?=
 =?utf-8?B?V0VsZE9VR3RDNGJKV3MzZk5tcTU5aDN6Y1hrWFhYd2Y1cjJTVTFVcTREbzJi?=
 =?utf-8?B?NlNIMi9aTlAyUm5TTnVrVG52ME5WNFEzb3RrMkQvNjg2N1dwUklDaWVWcEhI?=
 =?utf-8?B?aDZwMmRjZ1FxTUFhYlIzbUVPZzJUd1Z6dEtMYWxqV2NERTlnZ3UrdEJCeU9o?=
 =?utf-8?B?bVdHZXhQdUZTWUhTTVB0WVNKY084Rm8yc3NNN1RxZnlJa1VSM3dSUGd6YU82?=
 =?utf-8?B?RDBIenZ2YnJ1aXJmZjkrRDFlVFR5SG9sanc3dTBOSnJBcGZXSVQ2ZUpuZkI4?=
 =?utf-8?B?cHl2RkY0S3VJbzM3UGNzZ2JzUDJRVHR1cExYWndQQS9Vdnh5NlRXSkh0TDBa?=
 =?utf-8?B?VzJnN3ZyUUR6V1NCbEd3anVReW5WWVA4dFdQU0JkQTRnV3hnVkRHMmNjL0hN?=
 =?utf-8?B?bmNwZ1IxT1RDVzBJNEVEc29IS25aZXRNcWtJclJQdjNkd25SVHFZS2tBTVg0?=
 =?utf-8?B?dzlRekgvVTNaVkVndkFwVWU5b3NmVXFuZDR5SGV1WnRRbEk3SVorRDhTK1JW?=
 =?utf-8?B?cEZoWmxCdTkrTU13dXBOS0hFd0dxSmp6UnRvdVVlV1VXOHNVNWtNTkRJZ2NL?=
 =?utf-8?B?MTNxUXd6TzMybWZ0OFNxZ1VrMUVGaWFXZWY3TDMzQkZ6djlIdVRTYkhnSFVw?=
 =?utf-8?B?U1pvSFM3WlJNL3FucE9oYWR4MTlUQjNXMzJmSzl1ZzVNa3VmUHBpMEVQZVR5?=
 =?utf-8?B?MTN6OFFzc0NRVGl4Tms5S096K0lrZDZIUmFDYXVPL2h6ZVpqbUxybUdYTUpU?=
 =?utf-8?B?cFNxM2h1M0QwQVRhbFI1aG0xbFdRME5ETWJtUVZDK2RpR2gwVWdjdVRpQVVn?=
 =?utf-8?B?TTEwV2tiQVBCM011aHlydW9ZcUJ6bytwOXpmbHRRNm1rYUZJZEg3Vk82L2NQ?=
 =?utf-8?B?UnNXTjRWL3p5NDdVbW5XTDQwWDEzL2pVeVlWZXVxZUxRVGVXS2pHMDlrTFNt?=
 =?utf-8?B?bWpzcEJtYWo5OFc0aXZ4SGVnR09lbWlpZVFpeE4zMnJIMFg2Y2VUWTYyTnlw?=
 =?utf-8?B?SHJSWWZFRW51T0hKeTJCMFh3aEp5ZEhKeVBYZnV4WVA3NjkrTTJNNVhjenJm?=
 =?utf-8?B?RFR5QTNYcndxcjMrTWRZVmNjZVdmTnZzWGVBNkZCbXJEeWlSc2ZyV25hMFR4?=
 =?utf-8?B?MzVUWnMxblV1K1NKRUlDVXJxWlI4MGtXMmNXbG9MZGg5M0FmZjlpRU1IcDRl?=
 =?utf-8?B?UFlPTStNRThCWTM4REwzTmw2aW1hV09VTC9NNEVKTEVGRWVTOUh6ZHl4WVVl?=
 =?utf-8?B?dWdMV3VPRDFWNFFqUzRBNUl3eXhPVHY5QzBFWmZJelJhbzljRkQvc3lFdStz?=
 =?utf-8?Q?xqDg8vnlEIPe6mLRzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bbdd6-870b-4cea-c034-08dec678e411
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 22:46:05.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIVfr05Mx6BbDVpNR7Dy9fp89EcxTLT+XfI2tEpv8FbkAEy6j5cHS3nA8uZKcSufKx1H9fIsMBkYLynFiCrwEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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



On 6/8/26 20:12, Lizhi Hou wrote:
> aie2_populate_range() and amdxdna_umap_release() access a saved VMA
> pointer that may have already been freed, leading to a potential
> use-after-free.
> 
> Remove the VMA accesses from these functions to avoid the race.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
> V3:
>    fix sashiko comments: error-path cleanup patch race
> V2:
>    fix sashiko comments: Use-after-free on `mapp->vma`

I'm thinking we should make sure that the other existing bugs sashiko 
raised are fixed first
> 
>   drivers/accel/amdxdna/aie2_ctx.c    |  2 --
>   drivers/accel/amdxdna/amdxdna_gem.c | 31 +++++++++++++++++++----------
>   drivers/accel/amdxdna/amdxdna_gem.h |  1 -
>   3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index da89b3701f5b..3e21e2dabe82 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1023,8 +1023,6 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	kref_get(&mapp->refcnt);
>   	up_write(&xdna->notifier_lock);
>   
> -	XDNA_DBG(xdna, "populate memory range %lx %lx",
> -		 mapp->vma->vm_start, mapp->vma->vm_end);
>   	mm = mapp->notifier.mm;
>   	if (!mmget_not_zero(mm)) {
>   		amdxdna_umap_put(mapp);
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 63976c3bcbe0..20ce304b19ef 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   
>   	xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
> -		 mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
> +		 mapp->range.start, mapp->range.end, abo->type);
>   
>   	if (!mmu_notifier_range_blockable(range))
>   		return false;
> @@ -284,15 +284,23 @@ static const struct mmu_interval_notifier_ops amdxdna_hmm_ops = {
>   	.invalidate = amdxdna_hmm_invalidate,
>   };
>   
> +static inline bool compare_range(struct amdxdna_umap *mapp,
> +				 struct mm_struct *mm,
> +				 unsigned long start, unsigned long end)
> +{
> +	return (!mapp->unmapped && mapp->notifier.mm == mm &&
> +		mapp->range.start == start && mapp->range.end == end);
> +}
> +
>   static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   				   struct vm_area_struct *vma)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	struct amdxdna_umap *mapp;
>   
> -	down_read(&xdna->notifier_lock);
> +	down_write(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (!vma || mapp->vma == vma) {
> +		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
>   			if (!mapp->unmapped) {
>   				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
>   				mapp->unmapped = true;
> @@ -301,19 +309,16 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   				break;
>   		}
>   	}
> -	up_read(&xdna->notifier_lock);
> +	up_write(&xdna->notifier_lock);
>   }
>   
>   static void amdxdna_umap_release(struct kref *ref)
>   {
>   	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
>   	struct amdxdna_gem_obj *abo = mapp->abo;
> -	struct vm_area_struct *vma = mapp->vma;
>   	struct amdxdna_dev *xdna;
>   
>   	mmu_interval_notifier_remove(&mapp->notifier);
> -	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
> -		mapping_clear_unevictable(vma->vm_file->f_mapping);
>   
>   	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
>   	down_write(&xdna->notifier_lock);
> @@ -355,6 +360,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   		return 0;
>   	}
>   
> +	down_read(&xdna->notifier_lock);
> +	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> +		if (compare_range(mapp, current->mm, addr, addr + len)) {
> +			up_read(&xdna->notifier_lock);
> +			return 0;
> +		}
> +	}
> +	up_read(&xdna->notifier_lock);
> +
>   	mapp = kzalloc_obj(*mapp);
>   	if (!mapp)
>   		return -ENOMEM;
> @@ -380,13 +394,10 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	mapp->range.start = vma->vm_start;
>   	mapp->range.end = vma->vm_end;
>   	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
> -	mapp->vma = vma;
>   	mapp->abo = abo;
>   	kref_init(&mapp->refcnt);
>   
>   	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
> -	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
> -		mapping_set_unevictable(vma->vm_file->f_mapping);
>   
>   	down_write(&xdna->notifier_lock);
>   	if (list_empty(&abo->mem.umap_list))
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index a3e44c7a2395..a35d2f15d32c 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -12,7 +12,6 @@
>   #include "amdxdna_pci_drv.h"
>   
>   struct amdxdna_umap {
> -	struct vm_area_struct		*vma;
>   	struct mmu_interval_notifier	notifier;
>   	struct hmm_range		range;
>   	struct work_struct		hmm_unreg_work;

