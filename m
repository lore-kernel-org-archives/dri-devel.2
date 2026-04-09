Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0788BF364A4
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369BE10E004;
	Thu,  9 Apr 2026 17:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAOO+8KZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD4A10E004
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/B98PPNPgK0mq2NGD8RW8OUuWgk6hjNXlmxg5wgamdDYnT/8qnX0gcIveneGotDsZHSVqzYf9j72yXG3sWCdF3Lyi7d25kbPXbGnRA8V97FsjdgyNIIje8sBvaR32PcyrUx4ZIRFeT5MP3oGL39EA3lsAHrIzPZV1q09TIIxrW+QY3GZ3Oa369BGx/FzByAOy9N/obQnoB9NjtUL2vJEFDfr3hkTlgXIpLAM03w50k3BKmXNIWADKn5+NPvSXH5EeuuPGrm4dnhHboOywdnZkIqW/Tc0BUouR5Wr/Q8/NgNNgM9RUcEhGPsZVonJugvs/0KXKpk58wfJ+wczuzHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4bCTnjNztYFWiRdTSLHYkxdqn5ap1kpplK1tOJ6mgk=;
 b=sAZNcairr3H2xJNSX8lEAjbQ7i6GRFgrBLTMJhcZ5TxjcrrW/wKd5RzbSkvtyl8D6Ee7TCkeYtirtwn3O6rD4/bg8QezKPPrNQLkZB7n07gPu6scjhINFve1uciZxiqHTAaXSruWZbqBPy53SZzdwae05jN3Y7fHaeRf6KpiBax9Yay25/PlqyOa1iVIWSKWVI5lFkn8PLEAr3GScVjPdnCue4dNkAb+uJYTSTbL6ZeJDRMQJC79GslDYA/3SobV1EBl9rf6nO+HfJGUDDnXzqTlITwwmjiACY1A1YnzrMPrwuC+4tq9XvthW5nwDa1CRNcl+RJh7HdH0DIMA11ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4bCTnjNztYFWiRdTSLHYkxdqn5ap1kpplK1tOJ6mgk=;
 b=dAOO+8KZ4Wpa5EGUbIGcJ8LqE1MM34TH+U/o0Ys1uFwvVhubRG9PiF6lgkLa5NA8p32+YU9Zxha2YgBygdIa6XxGsObEYE1FP5PJ75SiIHshw3M2sBM/DKPsXUSFsHTn6IbT81VuIwvkyfRZl2s26ARRNjLCVgYbw/KsLBLzwzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS1PR12MB999189.namprd12.prod.outlook.com (2603:10b6:8:495::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 17:02:17 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 17:02:17 +0000
Message-ID: <cc594c62-8ad7-4582-8838-7f46872be939@amd.com>
Date: Thu, 9 Apr 2026 12:02:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Expose per-client BO memory usage via
 fdinfo
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260409152259.176883-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260409152259.176883-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:806:6f::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS1PR12MB999189:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb5c959-1290-4b21-bb5c-08de9659c159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Bp+VFPmM0dAtxNy+15XH1KjD9yDIwsKSrIQ0H1EsYoKKDGlpqxzhpQo+E0OBSCFtY6IkaX4pDBqdwQFwCP25wiSwFhDWM42R7VKf81aJSEBge8qBSqhKMVCS0mrIdgycyb2mCTPr+5nbW557ps3lW315MbeyY+pIaWuYBoNrjjZhka6Ir3RimAIRR49CJuHkzSAifYhwfJTOf0e5+5dKKNGCNMB+Qq/pvcA29kKuztbAbVGQpkZ8cmgmoC3DrSuQvV0nm0XI29Yi6nClSZZlwvW7u71RtKgBZbcYvK3AnWGRuWrZQbAx0ANPztpjIZ6ZPC0gyJykcUeuOjFZ4jNohAxeqcUmxKuZBPEWdc9t+MmjKdHa45oVcVkyQoyfamN+WLl7eMWist3DHfEs+eubfSqsV05IfeYi/+UbjcmVKWl8KpeUURbhaafSh/yEplV80i6sx8dU4Jza8ylid6L425EKCjk161r3yhH3oQ1GjQD43drS4gpUdaoYkBcJibAGtJxMwIaf906Lq3GzbeHzFH9oQBs3MGgY2D9+8r4hbVBnooFr4n7OvySWjjZsRtaT0ERd4eqe4Qkedlndw3hGkt/nSJJz/hjVtXVhfe/mQLRtocIS0fkn8GPmSC5OFQZ+am2ZdP6TuNO/MHhfZ95v20qMCW8SntTVNfYcMhqdCSW/TMKcudMbMLolJ2IV8BQBrkmNShMCdP2l7+2ixdDbV2lMBnjPWlpudjueDgEHZ9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEhwM0ovdVdhdXB2OU1GZGxFc1l2WHRPKzFUb0p6eW93a3BQdS9abzFGcnR0?=
 =?utf-8?B?M24zUXUvUE5veEZORjVKSHpxVGJFb0RRM0xBWnk3WDB2UHcyak5IMmdOWmtT?=
 =?utf-8?B?RTREc0xvM3JLNk40cHBKVVJXdWs4QW1raGVWTjhuTjh2ZklGeTJqcHBuR3Mv?=
 =?utf-8?B?K09vdmVOemNrR2RjQ0VXQXdpOE1JL0ZoOWY0bzVhblhhNDRRVVdCcklwbm5q?=
 =?utf-8?B?dXNLNmd0eFRJaVBkR21LWVc5Z05oWkdqdHBka1p2Zno4b1h1TVBLZ3BHWTZN?=
 =?utf-8?B?eFRzVVgyT0VBV3MvRnN4QkM0a0xtbFp1N1cvK1ZrZ0dwMm9NeW5CYytHSmNS?=
 =?utf-8?B?MlNETk9YcHZEMXpQN2lsVEo3bkMwSTBBRWVTYnFweWtTcVQ0eG5QbHMxQldk?=
 =?utf-8?B?bWMxSE9yaXJBMFJMbEIydG9pQTgxeUh3c3d4MHpleStwU3dSYWFBNE90SzMv?=
 =?utf-8?B?VXdCSE0rS3dNdmVYMUdmWmNLNE0yc1JHR0w4QTlWTEdtY2lhTkdXMUJwZjJx?=
 =?utf-8?B?aHJFdys0WkFjUVF5ZTF4ZjU1OWY4Y0ZYSXQ2RXpzMEE3MFpCbjVNaUJGTGtO?=
 =?utf-8?B?T3BDYmk5ME5VUGhYTlBTMUpNbFhTQXlFdG1OOW0yOGQ1RmpibmgwSE1SVGd0?=
 =?utf-8?B?aEkrMkZPWkdzSTcyeTl0c1dDZzJDSVpHQWd6MzhRSDY4NU5LYk03cE5rTklN?=
 =?utf-8?B?b1hpeWtlR1Y4K2VXYW1kSWsvbXRPWS9uUlFYVU85ZytMYmh0dXRVNlhrSVhK?=
 =?utf-8?B?WVEyOEY4aUVKRngwUDJZMENSWngvRXRWQ0FGUDNUcjB6WWtCK05pSUVxQmVM?=
 =?utf-8?B?WjQ2WkY3eURkZzFUZ2ZjT0NrK01iWWVVYXdYTHBTb1Y5ZjhoeEF2MUMwYysw?=
 =?utf-8?B?YjBrR2t0dzlxcjlLcWhxazgxb1FueTlCcGRsRCtNRGc4SXRrakhRWm5zTFJ6?=
 =?utf-8?B?KzVYRGcyd2FvWVREdUdoOG90MlVjRmNweW03UW84d25yRTJ1NGZNRlRLWGlL?=
 =?utf-8?B?dGNEUWE0R2VLU2VtemxRNDRHeDIvc0RzekpUaTQ4VEJwV1ArL0xreTNnempT?=
 =?utf-8?B?VFJlak94YXZhb3FoNyszSGoxajN3eWFuN1RkOFZJNC84Z3BKWWhNZk14L1oz?=
 =?utf-8?B?dFphRHo1L2w0MXFLZno4NXpEQXhwR3hnRTBYQ3UwaXRVbU5xZko0c0tyY2pX?=
 =?utf-8?B?Q3FJK2hLdmpxRWxtRXFCZ3I0TzRML3lsWVFPeldOYWNEVUVTbTI0MGl0b2ow?=
 =?utf-8?B?OHdtN2JuUkdpbldDSVhJVkZTbTV5R1ZoNTY4b1dWL1FDOVRjMmRGNk9VVzd1?=
 =?utf-8?B?bWRpU3AyTGlwVjFpNGQrVE1GdzVwUStNUEtsQUtvY2JleTFpV3VSMG5NUjRk?=
 =?utf-8?B?bEtOZlJPb3p2VWRzVGVNVDczdGZPcnAzemZ2dGZOcGZQTGluS0ltL1RJb0Z5?=
 =?utf-8?B?Y05paHExSXVwV3hCZFNiM1E2UlNsdWpsZ3FGbHFuczNGSktIVlhqTVJRcTdP?=
 =?utf-8?B?blVlVGtIdnZYdG1GSVlNOE5yYytMekRaL2F6UlM5V3QxYlZWdDhEQmpvcC9o?=
 =?utf-8?B?Q1ZuUUd3OEZvWi8zUkVBM3BUeXZPVGlOY1NoKzZxS2ZzeFhUTndKaGU3b2dl?=
 =?utf-8?B?M0dZRGhzYm14SFJDczIraG13SGFXRUhxbU95QmtWbm16TjZZdUdtbkpQK3lk?=
 =?utf-8?B?V1pOUXBaOHFYYUF5bUdCSE05THBYei9SaVF6RjVIV0lQNjE4dlkzblBKN20v?=
 =?utf-8?B?anBtRTdEaUowa1NuT0lyVS9ZaHlGWFNtVHE1QlVlblhacmdNMkxvVUY1VEtD?=
 =?utf-8?B?M2FDcEZNTmpnMXhpYUhkUzlzbW5ueVliWllhZWlZNCt0Rlh0ZndEVEJuWnA5?=
 =?utf-8?B?ZURvaE5TZ1hiNHRoZnZ2elRmK3dKbnhJaVdiWU9TeEc5d0hBY29pMTBkS0xz?=
 =?utf-8?B?YWN0dDZjaDJnaWZtcEpxMW10OVhxRnlEV1o1aWlKd3p3QzBlU25TNEhYdkNX?=
 =?utf-8?B?OU03dEZWZGJRNms2dDF3RUJZMmd0QTJYQXRSK0RRRG5uSWJPSVdSR0FiMVo1?=
 =?utf-8?B?M0M0L09MSnFKak5SS09ETmo3Y3kzamUvWUo1c2RJUWxNQ1RrZm9LMExHT2h6?=
 =?utf-8?B?bFNKOC9xdW8vK1ZUTDg1ZGpGbm1Bd3BObjRnOHNmM2g0UFQ4NUNJdnhoSGRo?=
 =?utf-8?B?ZjlXZ09jNlVUYUN1RDc3Z1loNDhQSU1IcG5BSDlKZEZvY0ZRTHFsYi9nZkl5?=
 =?utf-8?B?d3pVSm55ZlpEVUJIcHVPRXVLS29xVGM4TEJMMndIVFpnTFlOYmJIMWd1cXRt?=
 =?utf-8?Q?45OyLj7eWNExs/97KO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb5c959-1290-4b21-bb5c-08de9659c159
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:02:17.5180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi6OStBACHcfjolf1EYli+zqFz+H/X6yyOVflKv7uyC+HWYjQmMCqPFEZBeG0UAebEZKkLC4EGETRRKHoGDKRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999189
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



On 4/9/26 10:22, Lizhi Hou wrote:
> Implement amdxdna_show_fdinfo() to report per-client memory usage,
> including below driver-specific memory stat:
>    - heap allocation (amdxdna-heap-alloc)
>    - internal BO allocation (amdxdna-internal-alloc)
>    - external BO allocation (amdxdna-external-alloc)
> 
> Hook the implementation into the DRM fdinfo infrastructure via
> drm_driver.show_fdinfo, while continuing to expose standard DRM
> memory stat through drm_show_memory_stats().
> 
> This improves observability of per-process memory usage and aligns
> with existing fdinfo reporting mechanisms used by other drivers.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

I think you should add a Suggested-by: tag for the person that suggested 
it (I forget who it was).

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   Documentation/accel/amdxdna/amdnpu.rst  | 25 +++++++++++++++++++
>   Documentation/gpu/drm-usage-stats.rst   |  1 +
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 32 ++++++++++++++++++++++++-
>   3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
> index 42e54904f9a8..064973bf4893 100644
> --- a/Documentation/accel/amdxdna/amdnpu.rst
> +++ b/Documentation/accel/amdxdna/amdnpu.rst
> @@ -270,6 +270,31 @@ MERT can report various kinds of telemetry information like the following:
>   * Deep Sleep counter
>   * etc.
>   
> +.. _amdxdna-usage-stats:
> +
> +Amdxdna DRM client usage stats implementation
> +=============================================
> +
> +The amdxdna driver implements the DRM client usage stats specification as
> +documented in :ref:`drm-client-usage-stats`.
> +
> +Example of the output showing the implemented key value pairs:
> +
> +::
> +
> +        pos:	0
> +        flags:	0100002
> +        mnt_id:	29
> +        ino:	939
> +        drm-driver:	amdxdna_accel_driver
> +        drm-client-id:	3219
> +        drm-pdev:	0000:c5:00.1
> +        amdxdna_accel_driver-heap-alloc:	60 KiB
> +        amdxdna_accel_driver-internal-alloc:	67588 KiB
> +        amdxdna_accel_driver-external-alloc:	0
> +        drm-total-memory:	67632 KiB
> +        drm-shared-memory:	0
> +
>   
>   References
>   ==========
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 63d6b2abe5ad..24d3012ca7a6 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -215,3 +215,4 @@ Driver specific implementations
>   * :ref:`panfrost-usage-stats`
>   * :ref:`panthor-usage-stats`
>   * :ref:`xe-usage-stats`
> +* :ref:`amdxdna-usage-stats`
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 09d7d88bb6f1..21eddfc538d0 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -226,6 +226,35 @@ static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
>   	DRM_IOCTL_DEF_DRV(AMDXDNA_SET_STATE, amdxdna_drm_set_state_ioctl, DRM_ROOT_ONLY),
>   };
>   
> +static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
> +{
> +	struct amdxdna_client *client = filp->driver_priv;
> +	size_t heap_usage, external_usage, internal_usage;
> +	char *drv_name = filp->minor->dev->driver->name;
> +
> +	mutex_lock(&client->mm_lock);
> +
> +	heap_usage = client->heap_usage;
> +	internal_usage = client->total_int_bo_usage;
> +	external_usage = client->total_bo_usage - internal_usage;
> +
> +	mutex_unlock(&client->mm_lock);
> +
> +	/*
> +	 * Note for driver specific BO memory usage stat.
> +	 * Total memory alloc = amdxdna-internal-alloc + amdxdna-external-alloc
> +	 */
> +	drm_fdinfo_print_size(p, drv_name, "heap", "alloc", heap_usage);
> +	drm_fdinfo_print_size(p, drv_name, "internal", "alloc", internal_usage);
> +	drm_fdinfo_print_size(p, drv_name, "external", "alloc", external_usage);
> +	/*
> +	 * Note for DRM standard BO memory stat.
> +	 * drm-total-memory counts both DEV BO and HEAP BO
> +	 * drm-shared-memory counts BO imported
> +	 */
> +	drm_show_memory_stats(p, filp);
> +}
> +
>   static const struct file_operations amdxdna_fops = {
>   	.owner		= THIS_MODULE,
>   	.open		= accel_open,
> @@ -236,6 +265,7 @@ static const struct file_operations amdxdna_fops = {
>   	.read		= drm_read,
>   	.llseek		= noop_llseek,
>   	.mmap		= drm_gem_mmap,
> +	.show_fdinfo	= drm_show_fdinfo,
>   	.fop_flags	= FOP_UNSIGNED_OFFSET,
>   };
>   
> @@ -251,7 +281,7 @@ const struct drm_driver amdxdna_drm_drv = {
>   	.postclose = amdxdna_drm_close,
>   	.ioctls = amdxdna_drm_ioctls,
>   	.num_ioctls = ARRAY_SIZE(amdxdna_drm_ioctls),
> -
> +	.show_fdinfo = amdxdna_show_fdinfo,
>   	.gem_create_object = amdxdna_gem_create_shmem_object_cb,
>   	.gem_prime_import = amdxdna_gem_prime_import,
>   };

