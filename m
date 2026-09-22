Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78DFC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119AA10E7F7;
	Tue, 22 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JY7wvdhu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21C510E7F7
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF4MzpvFUu/uki69upGAAkBe6cTiIW09IHTW7jsCVCrBXC2MIy/LoGPVtx2H+4MmgyHRtxx9wzxDZbwDE9iTcwcdOxGv6nRU5MIXxJfAL3PBd9uQeYj+o+/Ju/xoRmg/VsIz1J4Gnaio1dk7ac7J66FqMVF/NQ/x/mRLQsqGbtZS7eSLdWbpBWFLST79fQf5tl5bjEVjaRehoqLtuTljkHXh4dOknxaTczIIFefCTc/FyftQmEx4zlcnt59dSt4hyai4jnYpo/ebwDQAPji04NWIOAgfe5lbDjDfAGfAi+nkc441Mf9qaDD2X5IFoDjs3ApNpyuPjILmhaegfskf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOLMWVmHH8IosztErSAptf6JvK7DG7NMIJcTGGTOsPk=;
 b=QdNizghMd0wqEfqbbRGXlSZAgb+vY5aL/FHiaRiSR3KbtowblWePSDIpkenJ8DWNvGqsn/qf09IbyfMXffmRvPSvRLtQR4nOK3xjrKOJE6Fl+djj1twyg4qNcW+cpiNRH+SOGQBh+MetDWV3hzjUNR7kj9SvtYAPR00tLwtzFBLjyk0qpaYHlUEZjYWopmaR7dEUmYheh4N+2kzcWPl3Bl+0AnkyLHznWEJi21zTTzHLOqykveU/BiY0ZLa2p4xoLPnyQPlgSaW1FqmEAlGTWCdueXqNVynBLXf5gMWrQrcZEqdJV3+OxwzlUf/S84QAR1g43Lm1Jdstf+4Xyz+Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOLMWVmHH8IosztErSAptf6JvK7DG7NMIJcTGGTOsPk=;
 b=JY7wvdhug0pOP2fda0jNREXlm62rO32ap7UiG1mES063gRBwg9Ki0ZaSuNOvE121C4HnGsyvsiO8qKX+H0+AtWtRt7EcErDjTUdv+Sug2H+KGoe64SFMvhULg1RCMD6xECgFsxJL34quLHf9fVOnbDAbURlENSfY9nAYflCVEkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 07:22:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 07:22:46 +0000
Message-ID: <5be99821-cf16-46d7-9e4e-9720d0a06321@amd.com>
Date: Tue, 22 Sep 2026 09:22:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/udmabuf: reinstate a reasonable default size limit
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, kraxel@redhat.com,
 vivek.kasireddy@intel.com, sumit.semwal@linaro.org
Cc: robert.mader@collabora.com, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260922012341.367268-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260922012341.367268-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0357.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: f934e2bf-efdf-44e2-6de7-08df187a4c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: knG5lJPGPojuDbm/kZ/2eyp+DctLQtDQzBlWYcShZdXRr6An0eRN1y2e+TG3kPmWQrLOaF5SQkolg5YGuduES7bhizHoYVTdlIL8Urs5O4hFVe0r33FVgsNK/zZpN4H8QvU4QxNhjOC7YBXVpkhJjef6yGFyto7iFGhbr0uFoi4d/R6AnXkAk2l7mdWBhj5wiBz3rPLjQ6ctqYsrwtffVfPESZyKHYjDNI8Cy3najxsgfrct6NtAXH+qGUCbaHoMzqGbJQLmTJBR9uk29vY2sHXKtYVCj7lUVkkvwdghuIynFD0OxAkYnUTxSKek+3+gAfoU1OMMAotlqFMSnlnWIbw+m7spjieivoZvezaKpnvSuMRUxW0BoVMHCzJsi0Y1EGm45DlitqCczHrh4abve6AzQpKmS9fSr3gI4IC1kgkxAaKAIfBo6r1RBw+hQzzstaSs1IRrVv3XMYBd4M+9SheHnEqX9kpNfLSAL+P+ygDQI7VSriOncNcCBc9Y6XRTKoolSfyuJDKIZ8bUbCeHjtmwdzp+nRdWAx8VJ7sZNdWarI+nxo+EYeyQ0+5VWeXJNDSATsYMFae5hIQxszs1NuHWXapS8vT+zFF/0sdUTq3aQf9T2z8yvpio/5PBwbnBCSIaO2sDJh0JhQ6rRwb8CxFlY9sgC0jYoNB+UN7rjmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JjSUVzWW53RGNqblRDYVNOOHpscjZKVnNqU1FMTHlab2RUR0RNUDFvRjE1?=
 =?utf-8?B?cEQ3K2pVYWNjU2dhdnlxMGdNL0h2eVJaMlhhOXhjcjdPTTZkZUN2V0ZFdWQx?=
 =?utf-8?B?a1pTeTlTSVoreEFTUm42VTI2L2p4bHpOVVlXOXFWVk5nTkxXVWdJd3VacWtG?=
 =?utf-8?B?OTQrbGFreFdzcG8vQzdoY2UzK2RMWGVEV3ZqaW9qYTdoa1RFQUUrODFtZWRr?=
 =?utf-8?B?UFBmRTJBTktrVXp1eVYyaVkwMzZvaE9NQUNGVDgxVU9POUd1VEh2NnZjM3l6?=
 =?utf-8?B?OTQwU2FrQllVZWpuNzA5QnFWb0xCS0VFY3FidDZ6MG5YWjB3djdqcjNvUjBN?=
 =?utf-8?B?T2xLazVzcTlMU3JLdmtiMUhRb1FHbTRpZjNaSThaRHhBN1JMRGZyUnVISXJu?=
 =?utf-8?B?dGtjN1gvRlBNM3NkMWdTTXQvbCtraG1VNXR4WFdNeWZBc3JwSDZSOVZSTkpx?=
 =?utf-8?B?TTJCSHlrQlRhc2Y4cGhKWVRxMXh1RHBhVGNid0Z2LzJYSjdnb0phK0R0bW1u?=
 =?utf-8?B?TjJXRVI3WGcxa3ZtLzFhQ3gwT2tpcWxHNG80RVpDYk5BMWRPa2JCcE5DMWVP?=
 =?utf-8?B?cEJWMXY0Tmg3NW1na3FNS0luK0pNdUR0OXF3UWdHaFEyb1EwUkgwdzAwSnlX?=
 =?utf-8?B?b053dWNFR3dPeE1sQktZTmp0cWV4NWV2bHUrUitxREZ2ZGJFZWwxWHZIajZj?=
 =?utf-8?B?bDJ6Uk9MWldmNjE0S240ZkRKSjM2dm9nSGZIVzQ2dkNJbzBGVEFkZGdjUWJa?=
 =?utf-8?B?UERyNFJIczVBRUYxeTdBTU5pQi82SjFOMzlHOHhKNmxmK1d1ODhoVjdldm1n?=
 =?utf-8?B?WW9SbmxQWEhnZGpqZlM3QkRHZ1lHWEw0amhpaEpLRDRQaTlKZkdJMkFOenJI?=
 =?utf-8?B?MTB3dTJiR0RFQTlZZUphSVVRaTRucHR2eG5XZ0dsVkEwSEFiN2J4amV3bW9h?=
 =?utf-8?B?UHhFb0N5VVJkRkwvUGtCTGN2TDU2ZlhBTy8ycXRxWHR0NThFVEkvdjVtVUsv?=
 =?utf-8?B?NmdKSzE2RmlSWkppbTdDc0U2UHBmdFRHK01iclZuVXNSNTdEM2VKSGpRV3dU?=
 =?utf-8?B?WGE4TC94OTQ2Zkp2alhYWHpjamNkeVNIdGorSzZMRHlueUVLMUJyN0xFdlV2?=
 =?utf-8?B?QVFlSDNHeS9WZFZNMzhPeWJoNHlRZHdwb2FkYjZ1emozMkQ0YXo1c2diYmhn?=
 =?utf-8?B?dWh3Q3A5NU1Oc09wSUlRdlZENFAvSHY5L2xFWTNiQlE0OEZ0MGhhR1cyaDFI?=
 =?utf-8?B?dzJoNlk4ZWVBSzBjRlVZWEQrQWNVN0liUmkwQTI1OWNCZW00ZmFaclBYZTEv?=
 =?utf-8?B?OEg3enhCTVFuZmcwNjJ6TnpOYy9sOUl1eEhyOHM2N094WVpabU9NMndidHlK?=
 =?utf-8?B?RHMrREpIbHNNdnFkbUkvSnVlNUNrcXZLa3p0ayt3Z1lIQ2NJTUhFcEdWQTRC?=
 =?utf-8?B?bjBYanYvMFg2Tmk2MXRXcWhBRE1uSmtocThIRHRQOGlROGVZWFM0bnltc2t1?=
 =?utf-8?B?Y1VEMVhiVTBWSTZoR3pZZHZlcVZjdGFkWUtpeXAxY0N4NXJYTEt1a3NiZ2lX?=
 =?utf-8?B?TFRDV0s0bThUU2RiRXdrYXVqZFJ1VWpPb2k0TVh2YTB3cG1DR2RMempzdkZI?=
 =?utf-8?B?azRtNVBGek1sb1pBUHhiQ1JPdnpqaVM3WnRReTJoeUErV20wc3VSeFNHQjRw?=
 =?utf-8?B?RXlXbU1PcVFZbDhINzRPV0FIRkdMUWFUNkx5RVhBMGJJeWVDaHVobytZT2lZ?=
 =?utf-8?B?dm51S3lXSk53M2szN1JIcXBiWk9VK1NkSW1Dcm1JamU1MGxYVEFnSE9DZEpu?=
 =?utf-8?B?ZncxSUU4aXg1TmVyVkFZNXo3R05Pb2VQeWFtMWZRYzZNclhJNVgrL0NKemxl?=
 =?utf-8?B?dW5pUmMzOGlYRnNyckJhbDk2MnhLV2EybXEyLzNUM1l3VVB6K1RjR0MwcXg3?=
 =?utf-8?B?cHV6RWRvZDR4UGRaQXRsZDIvd21ZWkIrcy95aG5uTmVaaS8wZiszcjRRdUlE?=
 =?utf-8?B?djV1c1dtZDNwY3JZOTFvMDBnSytUNUx5dStkWkNpbzlDSCt6RXgxTzFMMGo1?=
 =?utf-8?B?MGliZnB2L2RPMC83MTBmVERhZGNudkRTQjkzTVRReHJtZUJoRUlWWktpRE9u?=
 =?utf-8?B?eFdlOWJ2MUVUTkxCbG1XeG4xOVpiQmUyd1FLQXVyQmpHT0NhdTExWWk3eUtX?=
 =?utf-8?B?bTR2VHcyUUd3V2JySnR6NEdZeExiNWZYakliWHNuTDZoWldzMUZHWlZZYUph?=
 =?utf-8?B?ZUpJNjRUUkEyTFhuVkpkek1UM0R0eGlINk5JMVgxaVd1S3NnMHE2SWJWaUV5?=
 =?utf-8?Q?ecQBCYUdnP9gDV+jcH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f934e2bf-efdf-44e2-6de7-08df187a4c66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:22:46.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBDwDSVg/a+9fibUYPYw7k13ksrmowjA3aifGoeVZcxv157AiVBZxvThawAeVea8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

On 9/22/26 03:23, Jiakai Xu wrote:
> Commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default") raised the default size_limit_mb from 64 to INT_MAX.
> 
> With 4 KiB pages on a 64-bit system, creating a buffer larger than
> about 1 TiB makes the two per-page pointer arrays in init_udmabuf()
> exceed what kvmalloc() can handle.  __kvmalloc_node_noprof() warns and
> fails when the requested size exceeds INT_MAX bytes, which is
> trivially triggerable by unprivileged users through the UDMABUF_CREATE
> ioctls:
> 
>   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021 __kvmalloc_node_noprof
>   Call Trace:
>    udmabuf_create
>    udmabuf_ioctl_create_list
> 
> Instead of using a fixed megabyte value, derive the default limit from
> the kvmalloc() threshold:
> 
>   (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) << PAGE_SHIFT
> 
> On a 64-bit system with 4 KiB pages, this evaluates to 1044480 MB
> (1020 GiB), allowing buffers a little below 1 TiB while keeping the
> per-page pointer array allocations below INT_MAX bytes.
> 
> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Assisted-by: OpenCode:DeepSeek-V4-Flash
> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push that to drm-misc-fixes later today.

Regards,
Christian.

> ---
> V2 -> V3:
> - Replace the fixed 256 MB default with a limit derived from the
>   kvmalloc() INT_MAX threshold, as suggested by Christian König.  On
>   64-bit systems with 4 KiB pages, this allows buffers just below
>   1 TiB.
> 
> V1 -> V2:
> - Instead of adding a pgcnt check in udmabuf_create(), restore a
>   reasonable default size limit (256 MB), as suggested by Christian
>   König.
> - Drop the second Fixes tag; the regression is solely due to
>   44e9eb5a7621.
> - Drop the "Cc: stable" tag; 44e9eb5a7621 is only in v7.3-rc1 and has
>   not shipped in any released kernel yet.
> 
> V1: https://lore.kernel.org/all/20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn/
> V2: https://lore.kernel.org/all/20260919015731.2077604-1-xujiakai24@mails.ucas.ac.cn/
> ---
>  drivers/dma-buf/udmabuf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..7ec269809fb49 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,10 @@ static int list_limit = 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
>  
> -static int size_limit_mb = INT_MAX;
> +static int size_limit_mb = (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) << PAGE_SHIFT;
>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is INT_MAX.");
> +MODULE_PARM_DESC(size_limit_mb,
> +		 "Max size of a dmabuf, in megabytes. Default is derived from the kvmalloc() limit.");
>  
>  struct udmabuf {
>  	pgoff_t pagecount;

