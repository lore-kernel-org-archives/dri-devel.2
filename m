Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52C3C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E680010E26A;
	Wed, 26 Aug 2026 08:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBD7I9+k";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9D210E26A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQAtGfMIVXR65VglCe1GjNw+lNMTzQpYJbn/GF97UzSfncl7JbNxqt8Y+D3OQ8jOTBLN1tntTsudDSMjHBdmnMvpF3Gb9rz3vpLerQdZk3bE0OqXyrgwGk+emCfh+c2kcb5ckVqjcBKWd8ncVLrXP6bNORij+lhdAqb32dES2ACzEWYQx88R+rfNWRumYH4MnXWBvo/xka6cjxNQGICk2vKsKnbumBj+nE3iCI9Mz28S7yiyueBljFY6wFjcVFrQNpdk6GURh6cxcJv8A2I3LeftMre325UqOltq0rY5BiK3JbylAp4FMjMtlD2GFDpW+fbEOL+zCDOTISXN5dnCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiGlqS2G9/U0vrKA0gfmah0jBPwjV4Vi0Pk5aaSIQmE=;
 b=lVS9Klkk5xwUfLbs7I5zSaFdrECuqjmduj+XptiLS3DIGUEnrGs47iG3EAujrkZycI746ukaVKGE1XWwD0qh/PwEXJc0PKOZ3kTvjRl19PMCCEbAvmYsjxDAptCW5xXn3ST95tu9uIydFuDMEQVk1vV76khcTEFQRePbY00ChzvHnAfUaHvJBniToqIZU3u8ztKSXRuSeWMoLfuz1OvQGJYOA5eTjSWfkdJKBzLbeTBm1fBI2QbWAG/iHAZ/D1Kg/7wCRnF6fpftBOCBCYMffC3Z3xggw/BLmNgaQWKoxXgSKyAqhFBQGlAcUOuAhSiwkJvIVw52coXW8hvpBUMHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiGlqS2G9/U0vrKA0gfmah0jBPwjV4Vi0Pk5aaSIQmE=;
 b=VBD7I9+kWKSYcUAL1/0uZ1+gU4hk6VAKgeyWxikBmrvtOOWGVKACCDM7EXObRLZ6AQaDZvIh5DTS5N1pEUa0fp0gO5lvvoNvQiM0mW65AUxdTKPfYZgogta35sRu5Fuy993mvrYOQoWt4QA0SRs2QuIqSmNZ5JZ9ptOy/4JEKYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 08:34:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 08:34:13 +0000
Message-ID: <0762ad09-12a9-4e44-9c8f-86c93f4925e7@amd.com>
Date: Wed, 26 Aug 2026 10:34:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] WARNING: refcount bug in sync_timeline_signal
To: Jaeyoung Chung <jjy600901@snu.ac.kr>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 sumit.semwal@linaro.org
Cc: linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
References: <20260824155629.2370441-1-jjy600901@snu.ac.kr>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260824155629.2370441-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: d1122693-0e39-4303-6edd-08df034ccedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ygrLVtjsB4ucax1udxHbzVwb8VSPT6AIHChonVEAVqjvrltJWF8AzypbXRxb/rgqIs7JSv9jPq/80XAMOTIqw9pPVNuU6TWgEHjepXH4hzgdb6y/7Wqj7ZoRnh/JkKzgPrDikfbOoovGI2XRq9EOQ7d4A9utlL/IoEsC1qEZTIjnpbZ3IaI3kzzXTjwerDf1psV7TD2/TAdjW6MFby0ba4FvDsAZf2EWTs/zXlS1Pgqfr3rowY8JRWDJI4DFLNaZzm5BwExPzigA9YPleTB6U0kR81q1LvraaOnJDWSkMiklWbSfIkh/IggHj6yZ9jSWegcVimJqak9POBUnEU1k/pk4jPxRxnke9rGKv4xEXaZuzlQpjeoU8g6TSj+iGhcT8Wt13sKMCqmWIATkZfMRqtGo7HkMtBXdlIZcx43mVT1kJIwd77Rrp7VT83AfPoLW8DtsI0kTcs43sdROZLlzZlLffcMjQorHdk0EXdzZ2mXgPigvyiw2uWxeLboV3n6ezxhsjwdNvizaaamySm8a3rgYPX+trR4l69Fgg2jrBSe2LqTjSto3w1F+LcQ5n03zIBFrOqrCRlvJ8oLbGJ/kv0IYnzP5nzy3IgYahGwt+Q/RqV64XCD308EOZfBiA3OdNXbkkMkkZh1BTGsLeyqPkJBSh4mC4qB2mvS0yPftiHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpJY09ZVHFIN2VCQWZTTG1SMDUwd0FCTVd2WVBKWUxYU1NodFFQRTZScUtX?=
 =?utf-8?B?ZEQrVktiMU5kLzhoeWd1aDhQODVuY0d5eVFrY0o5VGNSUEVOdG94UHlkQURk?=
 =?utf-8?B?ZUFTRWtrQ1JUc2JwQlB2aGhBWTFsNWEzdThmMTBGRDZDakEvdU9MUjAzK3F4?=
 =?utf-8?B?dWVGVUJxWkcralZKUFJUb0VIQWhLS1JKY3Y0Nkp1dFFWVk1YS1A0Nmo0dlNt?=
 =?utf-8?B?d0hCL2VzS1RlSGcxTXNNSHFzaGF4ZmFoMkFqMDhBR3ArZUZjbmM5dVdCWTN4?=
 =?utf-8?B?OXhkd01TMnRFSzAvYXo5RlA4YWNMY2RYQVMzVmtXYSs1aGlNVlcxanpqM3NC?=
 =?utf-8?B?ZStjNW93d2RFVVhzS1B6aHJwTHoraStiK253UXArU2dnZ05BbXExVzhPUnhw?=
 =?utf-8?B?UUp3VUxhUVF1cS9UblZiNHBpQm9oc0gvK282dFFUUmxkNmRqVGM3eC9YeTdY?=
 =?utf-8?B?UEJNR3NjRVYrTk1uaVRuK25HWVlIR0hJNHptdzQxRmg2TnQwVHRtdnUrUzh2?=
 =?utf-8?B?SkRESzRiUVh1dHA2am9TYUs3cThmWUo4dloraVZVSzFaVkJJbVdwMVZhMSsz?=
 =?utf-8?B?WlVobkRTVHBNZHBzYkcyb1pyeGZtdUZRNitFRXRpRVJHdTl1ek90NGNGeW92?=
 =?utf-8?B?ekkvSU9qaDJBanBISnMrVnphelFBNFhqUzg3ZTBaVmhqQ3IrM3JaRmdpcHVR?=
 =?utf-8?B?MDJqMHZMU1FNeHN5R1NPZm9TUHN6cDZHOXI2VzVmbHVsVWIzMGNxUW00UUFQ?=
 =?utf-8?B?a3dPQ2w2SDYyWHIrY3A3Q0hxcmVWSVBQSkhHbktJQUVBNzV4c2x0cUxpa3pD?=
 =?utf-8?B?VERxRkhaNUJmWnk5Z1UzVklpQ3pXemhNM1MxWWY1YnlQNkNzOUZITE4rbzEw?=
 =?utf-8?B?WXp1NlB0WjRVM2xMTThROTJyM083aCtMYjlkOXRSNHdHZHB4RXdmcURPb0dv?=
 =?utf-8?B?cW93NzF5WHRFN0U4VFFiWUV0ZWhBdVY1dGhmR2xIb3lIUlY3LzM0ZmtKV1BC?=
 =?utf-8?B?eFptd0p6b0NkdEZQTTg0UFVIcEUwWE5DRmFkYVczQldRem5IRVhLMnRVNngv?=
 =?utf-8?B?OHdiQy8xSVJMYkY4bmp2dUdFdWpuWjFEMFliUzVOOHZ1ODNwRlRIZnpCVkVM?=
 =?utf-8?B?L0xzbFExWVgrNXRQQjVldFZRdTBhTVBMR0M0R3BPL0RWbGw4cHFqK3A0NlYx?=
 =?utf-8?B?S3N6djZKNEpUQW14S1VCaS9Oa0IzQlQ2R0l4OG1PdDkrYlVDekZWSnVFK0lV?=
 =?utf-8?B?SzBrS1VOM0lZLzN0Y29qSVc5OXNNTUlIYThIRVBmSDFsRThNYkIrMC9tTUZt?=
 =?utf-8?B?WWRycjYyQjlaU1YxMXdXd29iNys0TkxFNCtKOEM3b2tRd292NWM2ZUpObUtx?=
 =?utf-8?B?S0VDT1RrVkxNcVRiVjRQN1dENVNSQUlkMmhRM1NndHZSemZ1QTh1WVBlL05H?=
 =?utf-8?B?MER4a3FMWi9kS0ZONjZ2aHJOYTFVSXdjSlVzOTdGSmo0WlBKMys0dTJMakgx?=
 =?utf-8?B?ZEdMY3dhZE96UG41MDIwNDJzYWhGNi9JQml4ZFVXeEtKc1NSemZ4VThKeVlH?=
 =?utf-8?B?SE5RcjhEV1BZSlRjelVOSEIwRi9EY1c3RmFnaVlIdU0wdllhMXhjeU5PQzZp?=
 =?utf-8?B?bjRQcGJ0aUo5K1I5ZjV2TlpYamZqSExSU1lJQkk3Z1gxODVWYkZmWWVNZjlV?=
 =?utf-8?B?bVNSNG1oSVU5MGNqR3FnQ3lRN0tKQld0d1lYY0U2bG9GY2ZEaVlpb09zQkFT?=
 =?utf-8?B?V1dnM3VXczJnMjJmbjR3RmpRZXlaRm4vclg3Z29aOW1rNTZtVGFUYVpnRUhZ?=
 =?utf-8?B?a2FXVktnUGF5ZDhyYnNORG0vN00xdWtTZ05SNStRZWY3c2lOQ0lsUXhpOEE3?=
 =?utf-8?B?WEExWUdOMzI2SmYrSzZ6aHBaVzhUaS9FMS9GVGt2WnVDbmxIWnpNa0lXakhV?=
 =?utf-8?B?eXRseWlnaXF5dk5RN01kMy9Wdm9oa2JTeGl4UDhpTzJMM3podXZaODE5L2J3?=
 =?utf-8?B?YkxvalIzUzByWCtlenA1RU9GQjV2WkltbDl3L2ZaZmNuSVl0b2VpeXdqZmhU?=
 =?utf-8?B?a2JXQmJxMnhCZHFtcGtENzQ3RmpWaDdHMUN3R0RZRlZZek5ZMC9yak1zSTlk?=
 =?utf-8?B?RVVQNUc3RU9Fd0JmRkIyQktMTnAxR1FxaVlTNkdiclVXSGpaaERGelFBZ2NZ?=
 =?utf-8?B?d0NyT1FFVUtyQkZleUIvQmh6UXQwYzlrU3hRRVgveDA3Q0hlbW1rbk5uM1g0?=
 =?utf-8?B?bGpqZ0c5c2kwNXFQOCtiYzBSUDkrTGNFQWpsMjRsc05pRm5OMUFBdmlxY2p0?=
 =?utf-8?Q?09oyv4+Cysgnc2KG11?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1122693-0e39-4303-6edd-08df034ccedd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:34:13.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fZQ6DGix9tX3EaRRkn0RqcTTK5rnmwWBWlwoYNc1dkPwFcCzY4qSb/Tyg5RvgnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

Hi Jaeyoung,

the SW_SYNC component is pretty much deprecated, only kept for user space unit testing and not maintained any more.

Background is that even if you fix all those known bugs you can still hard crash the Linux kernel with it. See the big warning in th KConfig and the kernel tainting when that component is enabled as well.

So if you have patches which fixes things I'm happy to take them, but nobody will investigate in bug reports on that component any more.

Regards,
Christian.

On 8/24/26 17:56, Jaeyoung Chung wrote:
> Hello,
> 
> We found a "WARNING: refcount bug in sync_timeline_signal" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root cause,
> so we do not have a proposed fix to offer.
> 
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.
> 
> The following kernel config options are required to reproduce the issue:
>     CONFIG_SW_SYNC=y
>     CONFIG_SYNC_FILE=y
>     CONFIG_DMA_SHARED_BUFFER=y
>     CONFIG_DEBUG_FS=y
>     CONFIG_KASAN=y
> 
> We hope this report is useful. Please let us know if any further
> information would help.
> 
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> 
> Kernel delay patch:
> ==================================================================
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..d30ce9d915ba 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -8,6 +8,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> +#include <linux/delay.h>
>  #include <linux/panic.h>
>  #include <linux/slab.h>
>  #include <linux/sync_file.h>
> @@ -215,6 +216,10 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
> 
>         spin_lock_irq(&obj->lock);
> 
> +       if (strncmp(current->comm, "syzrepro1", 9) == 0) {
> +               mdelay(50);
> +       }
> +
>         obj->value += inc;
> 
>         list_for_each_entry_safe(pt, next, &obj->pt_list, link) {
> ==================================================================
> 
> C reproducer:
> ==================================================================
> #define _GNU_SOURCE
> #include <errno.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <sched.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <time.h>
> #include <unistd.h>
> 
> #define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })
> 
> #define SW_SYNC_IOC_CREATE_FENCE 0xc0285700u
> #define SW_SYNC_IOC_INC 0x40045701u
> #define SWSYNC "/sys/kernel/debug/sync/sw_sync"
> #define BIAS_US 2000
> 
> struct fence_data {
>         uint32_t value;
>         char name[32];
>         int32_t fence;
> };
> 
> static volatile int g_round, g_stop, g_tl_fd = -1, g_fence_fd = -1;
> static volatile int g_armed, g_done0, g_done1;
> 
> static void spin_us(long us)
> {
>         struct timespec a, b;
> 
>         clock_gettime(CLOCK_MONOTONIC, &a);
>         do {
>                 clock_gettime(CLOCK_MONOTONIC, &b);
>                 __asm__ __volatile__("pause" ::: "memory");
>         } while ((b.tv_sec - a.tv_sec) * 1000000L + (b.tv_nsec - a.tv_nsec) / 1000L < us);
> }
> 
> static void pin_cpu(int cpu)
> {
>         cpu_set_t set;
> 
>         CPU_ZERO(&set);
>         CPU_SET(cpu, &set);
>         sched_setaffinity(0, sizeof(set), &set);
> }
> 
> static int wait_round(int *last)
> {
>         while (g_round == *last && !g_stop)
>                 sched_yield();
>         if (g_stop)
>                 return 0;
>         *last = g_round;
>         return 1;
> }
> 
> /* T1: advances the timeline, signalling the pt */
> static void *thr_inc(void *a)
> {
>         unsigned int v = 1;
>         int last = 0;
> 
>         (void)a;
>         prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);
>         pin_cpu(0);
>         while (wait_round(&last)) {
>                 g_armed = 1;
>                 __sync_synchronize();
>                 ioctl(g_tl_fd, SW_SYNC_IOC_INC, &v);
>                 __sync_synchronize();
>                 g_done1 = 1;
>         }
>         return NULL;
> }
> 
> /* T0: closes the fence mid-signal, dropping the pt's last reference */
> static void *thr_close(void *a)
> {
>         int last = 0;
> 
>         (void)a;
>         prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);
>         pin_cpu(1);
>         while (wait_round(&last)) {
>                 while (!g_armed && !g_stop)
>                         __asm__ __volatile__("pause" ::: "memory");
>                 if (g_stop)
>                         break;
>                 spin_us(BIAS_US);
>                 close(g_fence_fd);
>                 __sync_synchronize();
>                 g_done0 = 1;
>         }
>         return NULL;
> }
> 
> static int open_sw_sync(void)
> {
>         int fd = open(SWSYNC, O_RDWR);
> 
>         if (fd >= 0 || errno != ENOENT)
>                 return fd;
>         mkdir("/sys/kernel/debug", 0755);
>         mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
>         return open(SWSYNC, O_RDWR);
> }
> 
> int main(void)
> {
>         pthread_t t0, t1;
>         long i;
> 
>         close(SYSCHK(open_sw_sync()));
>         pthread_create(&t1, NULL, thr_inc, NULL);
>         pthread_create(&t0, NULL, thr_close, NULL);
> 
>         for (i = 0; i < 200 && !g_stop; i++) {
>                 struct fence_data d = { .value = 1, .name = "syzrepro_pt", .fence = -1 };
>                 int tl = SYSCHK(open_sw_sync()), w;
> 
>                 SYSCHK(ioctl(tl, SW_SYNC_IOC_CREATE_FENCE, &d));
>                 g_tl_fd = tl;
>                 g_fence_fd = d.fence;
>                 g_armed = g_done0 = g_done1 = 0;
>                 __sync_synchronize();
>                 g_round = i + 1;
> 
>                 for (w = 0; w < 5000 && !(g_done0 && g_done1); w++) {
>                         struct timespec ts = { 0, 1000000 };
> 
>                         nanosleep(&ts, NULL);
>                 }
>                 close(tl);
>         }
> 
>         g_stop = 1;
>         __sync_synchronize();
>         g_round++;
>         pthread_join(t1, NULL);
>         pthread_join(t0, NULL);
>         return 0;
> }
> ==================================================================
> 
> Crash log:
> ==================================================================
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x76/0xd0 lib/refcount.c:25, CPU#0: syzrepro1/402
> Modules linked in:
> CPU: 0 UID: 0 PID: 402 Comm: syzrepro1 Tainted: G             L      7.2.0-dirty #2 PREEMPT
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x76/0xd0 lib/refcount.c:25
> Code: 3d ff e4 bb 04 67 48 0f b9 3a eb 4d 85 db 74 2f 83 fb 01 75 38 48 8d 3d f8 e4 bb 04 67 48 0f b9 3a eb 36 48 8d 3d fa e4 bb 04 <67> 48 0f b9 3a eb 28 48 8d 3d fc e4 bb 04 67 48 0f b9 3a eb 1a 48
> RSP: 0018:ffff88810cd47d68 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: dffffc0000000000
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff9be2c840
> RBP: ffff888102a5dc40 R08: ffff888102a5d73b R09: 1ffff1102054bae7
> R10: dffffc0000000000 R11: ffffed102054bae8 R12: dffffc0000000000
> R13: ffff888102a5d740 R14: ffff888102a5d738 R15: ffff888102a5d738
> FS:  00007ae687b8f6c0(0000) GS:ffff88817d75f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000578dd65f7e58 CR3: 000000010b72c000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __refcount_add include/linux/refcount.h:-1 [inline]
>  __refcount_inc include/linux/refcount.h:366 [inline]
>  refcount_inc include/linux/refcount.h:383 [inline]
>  kref_get include/linux/kref.h:45 [inline]
>  dma_fence_get include/linux/dma-fence.h:317 [inline]
>  sync_timeline_signal+0x383/0x550 drivers/dma-buf/sw_sync.c:229
>  sw_sync_ioctl_inc drivers/dma-buf/sw_sync.c:410 [inline]
>  sw_sync_ioctl+0x140/0x980 drivers/dma-buf/sw_sync.c:475
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7ae687c90d6b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:00007ae687b8edd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ae687b8ee3c RCX: 00007ae687c90d6b
> RDX: 00007ae687b8ee38 RSI: 0000000040045701 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffcdb19abc7
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff80
> R13: 0000000000000000 R14: 00007ffcdb19aad0 R15: 00007ae68738f000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:   3d ff e4 bb 04          cmp    $0x4bbe4ff,%eax
>    5:   67 48 0f b9 3a          ud1    (%edx),%rdi
>    a:   eb 4d                   jmp    0x59
>    c:   85 db                   test   %ebx,%ebx
>    e:   74 2f                   je     0x3f
>   10:   83 fb 01                cmp    $0x1,%ebx
>   13:   75 38                   jne    0x4d
>   15:   48 8d 3d f8 e4 bb 04    lea    0x4bbe4f8(%rip),%rdi        # 0x4bbe514
>   1c:   67 48 0f b9 3a          ud1    (%edx),%rdi
>   21:   eb 36                   jmp    0x59
>   23:   48 8d 3d fa e4 bb 04    lea    0x4bbe4fa(%rip),%rdi        # 0x4bbe524
> * 2a:   67 48 0f b9 3a          ud1    (%edx),%rdi <-- trapping instruction
>   2f:   eb 28                   jmp    0x59
>   31:   48 8d 3d fc e4 bb 04    lea    0x4bbe4fc(%rip),%rdi        # 0x4bbe534
>   38:   67 48 0f b9 3a          ud1    (%edx),%rdi
>   3d:   eb 1a                   jmp    0x59
>   3f:   48                      rex.W
> ==================================================================
> 
> 

