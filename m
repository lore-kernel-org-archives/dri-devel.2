Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD17C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B92F10E16B;
	Mon, 14 Sep 2026 11:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oxTRcO9H";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C7D10E16B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzxiJQTyi2VgisHnHL5QIYq/Fqu1I8D7bsxR1P8r0Gdb2ElHGLlvTJG9mDMIFcDGtGkJ0qiLHi16cEfi5eDxIjABz0cixGZFeNWAZaK4OER5HBc4dfd06yviX/SszDMgPNu3g4u4QvhkXoKfQ6cUtt7/MEUPodKEKFPTZuY8j42Ag5Zgoyo6/vDOS2UyHKnw/eVc45sEJRkQGloRUNVMzmD/5qwn1zz7808VDMO/HKP8XVu8n3Y1ek2b5yhtOdUSW7voxraLbolbjIz5tVdQciYn2o6nLufv1eKqIVfZ8NjYQl7fy6vfiqzj31IYb+UXNoL/4i+mX9pWQQsfPu768Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NxEtL2qAT6NJDXz5T9PpJ/ipi9NSCuLwXUdEd4YP8Q=;
 b=ittxjEkgXj24CuV5bMuz3MIEnKFWDu0sj6kH8+Syh1DqNFRTl76F+MAb8+xubLTklF71MXGCBw3b2uCZb+zxkk2NBMbWP1ChUjlOit+EKZGG9OXs2QO0Y2YSW/1gZYG7KbiMncFIyhDlHxveaIB+8SQGBr+p0Qo8H32HbcToIQW9v4k8gcwqssVoWkqvKXXmcLzSDM3tlku7QdG/pHj73WkcrGi7heaUSnslVJ3xizDj7uKPlFmiiWx8mJiV2RvEA6m01t/30H8xm2PAc9Oe4WOly0Xop88zKAtm43aiBPsPFuhpiUxhT/sn73g2Xof0p2psnoj9Z6nWMq+l8XzU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NxEtL2qAT6NJDXz5T9PpJ/ipi9NSCuLwXUdEd4YP8Q=;
 b=oxTRcO9H8Lb+2yXj7czTIIl3p5mKb9OeBqJI6jMEwtRfzQdehIzimOxOzfc+hAPEYzSoY8SuewK9BUgft69ZcKcZafrPvZsgic1PfEv+fokquFyssUI1riww9QocMpOQ3httXccWx/qtiTPcdgl1JaTCchVsD9K4MN7xK2NXpvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:46:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 11:46:36 +0000
Message-ID: <b7e1739e-08f4-4283-a480-f06a9738a0c7@amd.com>
Date: Mon, 14 Sep 2026 13:46:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Fix dma_fence_enable_signaling() reference in
 kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260911221100.7079-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911221100.7079-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 700fd71e-f890-47d5-62bc-08df1255d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sUN8G1mcMVGMd3Yb9u5VMfP82jz12ILIhkYHMU0fnBQelUIkQTpGjAY/oDhTcvVEBC8ChkwnwZN+/ZkLUBnrVmJkE7nY9vvAcm5HEFPBp3zPUPUE1dXJGoa/CBAH4nKiQiQIvSEb2UyUTAAZIO/D0Adc5lmAEsSjikNvZV37zJ+78gtS9asth4tls/i4DvctfjtkYufGY6R6m/wo2P6rdIg103gwCzFfX3hYpYaSKWyArn1UOUMfqQNQoo2+mSg6belVdzB3qWjhhQpqVl4mpvSt6D8w9fc/S+pq1ZbEJFdf37q7jXYOVRyL//TmTSZsbLB89M1zycDZztD+XANoVowJlm4/7JujkvD6oQumAmO1nKLCuShX4C2SG+OROMtn0TAG4QE8KQz/+JfZplEZdjZubtLVFFvc32yBZvVw69ZODMUjZJo4tQ5ksQC6jdsZ58WxwjlQ6TGd2KXp9w0LQ3tCE+5SqYkU3JrZ1N+xcO2mjSP2qZPu2HK8Lln2sGd8s0RllypJHVr7jUMMnlnCEvNt5N24msWNn+GlEWmxIuQSjj/fSnEqudXlro+0Z1CEaJQnza2sYOgf83OuFi4FJmEtOTO8M9FJCnDl6z9DIYC0kLOOZebt6uAn9R4O1N8yKUHj8oCzjumSmGpyV0P+mrfpbit9C/qWv5O8G/5mKB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1J1NUdkd3o0SFlrVHhvRytnSHNvV094RHRpZTBkQk0vMjlBUkVZejZGcVRs?=
 =?utf-8?B?c1RYUmRNUEFyZTNMZlNLd1A1bnlaUmRERXJXMVlRTVhRakZtczBpNzZnOFc0?=
 =?utf-8?B?NVFkbWp0VTRKQ01BTlFjbHAwZFpyM2J6WGs3NVliR1NnZUd5Nnp6MXJqbXV5?=
 =?utf-8?B?TktWN0o1d1VqenpKRzVUNWUwY0hBMXVBTXlBaFcrc0dyUnE3RjkwalVOL29Q?=
 =?utf-8?B?RTNsNkxYMElsYXBSOENBR3grTTVrRzlKaGp5a0ZFTXJYQ3FjVEQ3QzQ5Vm5P?=
 =?utf-8?B?MExvUUFYNjJKZ1BTZWtTeCtnT2Y0ZjNNeFJDQ3IxT29mQ3BTQXp6c1hJek1m?=
 =?utf-8?B?bHNjZUVSS1ppR25BRTRlcDFJWkoxNTlMY245V2N3Wml2VHpHdFI4Y2lzeUZz?=
 =?utf-8?B?anE2bGN6a0JRMFRUN2Jtc1RHL3NiLzV6WEIrbVF0V2hnRXRIUDNFc1czWUlw?=
 =?utf-8?B?Q1lycTltd3NDekF5UUtmZkl4K08vM0MrNEpudktCOThia0ZqazRpUUdSUnlq?=
 =?utf-8?B?dUF2eWtNanNEejFPbGVPT1ZxMmJxYnVPYUVLbjZqVXAyVkhDcjNzZHhjUDYz?=
 =?utf-8?B?NEIzSDdlWjVJMThLdER5b1FFajhTT1Q1REVEVVRiYXlPMzE3d01yVnZQck1O?=
 =?utf-8?B?dmlXbFczbVhZbDhGZGs4V2phM1JFdFYwbncwZ3NxUzJSZzg4Y01XVzFjSTNu?=
 =?utf-8?B?d0srQ3lFOHE3Yk0vY3JmcUc4ZlZiVHo3aUhTRkhWZGFlQU9NdTJaTUh0N3NZ?=
 =?utf-8?B?Q1hSSmZtZi9pRGswMXlpRTVrUE1mUTRRMlo2Zk0zb1c5em4zUkY1cDljVGw0?=
 =?utf-8?B?VVRYc3hXd2NkTXJSTnFIOXFsSTZXVmVNV2ZYOEV1QU5JaGMwbmdYbmhMUmhi?=
 =?utf-8?B?MHhMVjJ4S1NlT2xsQUE0RFZFMDUwcUlPeXd2Q3ljb3U4Wm5nd3ROdmMvaS8z?=
 =?utf-8?B?RkV2TGtwd2VJc0JEanM5Yjl4Q2Y3alA0ZzBRaUxtaG1zMWZVWXhjZTE0anBD?=
 =?utf-8?B?V1VJb3FFejQ2cGR0ZXhGNjVhTko3YkpTdjRvSUNZcW9kejBmd3NMREZMbVdy?=
 =?utf-8?B?TndCNUlIZXdkVVZTTUtVTmh1a1NaSnZRY2VJVnkwMnF5WXZFTmVDTFRSSjRL?=
 =?utf-8?B?ZTJTNTRSUGN2MitMNGFuWXdSM2dteTNaaG5FaGMrUFZrdGtOUzEwdEFJdU5Z?=
 =?utf-8?B?cG5uVndkTEc1WkJtVWhldVFJMkJKcC9ma3ExT0pvNkwzTVZPdER4c0dXZFFI?=
 =?utf-8?B?UjFwLzdCMDlhbzFPQ2xDbmFJQ2RuUHUvRGtXa3E4SEp2KzNTcVBteldsaThm?=
 =?utf-8?B?eUhiNVhEQlpsR29zRktuUExLSmJCblBrT0VhT2doT3R4WmhMVmJaNG5CdFd4?=
 =?utf-8?B?QkN2Z2ZkWHBOZHFoZ1g3MFZOcW5OdXdtM3M3V2psbFFWK010M1U2SnpHMzV3?=
 =?utf-8?B?V1VDSHhIRDY2T3hTdEYxVUFIeUhNbk9ZTVVaMk8xU2VLNkl6Q2EvZS81RWUz?=
 =?utf-8?B?Q1BxSFhkOUp3UENXaDcxMnFMVXBsclQwWHhKdk9oTXJsTG00eHFHajZtTVhT?=
 =?utf-8?B?WnV4anUvWnZRTDhJazluTEZmSWRtODgxclRmYWZnSWxXdGExL25YQlB1aXd0?=
 =?utf-8?B?ajRqeTRCYStGQzlUTE92ZmdYQXVxUDdiYlhEZDhsL1owN01aQXROR0pZb0tE?=
 =?utf-8?B?bEhnT2xneTgzYjk5U0tvRmV2RVpyZEdxbGd5T2o0cVlIa1Q1UU0rdktZckVX?=
 =?utf-8?B?dzIrR250MEkrbEo3VUpvK2EzVm5SeDVtZXo4R1h2NVBJaDNNZlBiWUxiemcz?=
 =?utf-8?B?ZHNXTzl2cG8zSllDejY1Mm40OGVlQm5jV0JNaXZ0cjBPVFoxeE5kaTA3dTFV?=
 =?utf-8?B?MVlyYkhVSDVTUHlvcnBZVVNvY3NEU3VML3diQmJ0SzFrWkZJTlFab0RUL1F2?=
 =?utf-8?B?aWM1NEdlWGwxZmFIS3doUEQrR0VTeDBsN05uZ242NWF6Lzd5aUZWUHlIelNQ?=
 =?utf-8?B?MjZtd0REUGFFcWNNQWN5SUk4SHludG84N05JYldzcGloMEVmV2g4S2xERENM?=
 =?utf-8?B?Vk1mZDRnbUZkRjFINiszVXV4QTlpTUlXMGtRUlJ1cUp5b3UzbS9ObTZwcm9W?=
 =?utf-8?B?b0xtUno0dkpDeVd6bm9KaTY0TE84TlUyU29rZ1g3Q2xYZE9QWnJrblpaWktH?=
 =?utf-8?B?VFZXTlVJVXZ1VEtWZTBZY3BHaE00OElFMXFBY1RXR3psYzRDYnJQQmY0c2ha?=
 =?utf-8?B?ZEtZZnlZNjhiVzJ4cG5BVW1tZm4xNi95MUxkMmtJZEpkaXJ1RUdLOTRUUmJH?=
 =?utf-8?Q?j7VaH9DA2YKaXwArpL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700fd71e-f890-47d5-62bc-08df1255d4ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:46:36.6121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSzTlJgJS7eVXq+4BTGoRJ+rtj7GsZt+Eu9IN/F7OosiEJh+DRcf915m4/sTca7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

On 9/12/26 00:11, Karl Mehltretter wrote:
> The kernel-doc comment of dma_fence_is_signaled_locked() refers to
> dma_fence_enable_sw_signaling, which was renamed to
> dma_fence_enable_signaling by commit 9370a5c664e8 ("dma-buf: rename
> dma_fence_enable_sw_signaling"). Say dma_fence_enable_signaling.
> 
> Fixes: 9370a5c664e8 ("dma-buf: rename dma_fence_enable_sw_signaling")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I'm really wondering why that was not automatically renamed.

Anyway reviewed and pushed to drm-misc-next.

Thanks,
Christian.

> ---
>  include/linux/dma-fence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 158cd609f1036e56668867f092041213cbf30427..3aa85be43aada5a80ea2e1cecc5f76824b434d14 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -501,7 +501,7 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
>   * Returns true if the fence was already signaled, false if not. Since this
>   * function doesn't enable signaling, it is not guaranteed to ever return
>   * true if dma_fence_add_callback(), dma_fence_wait() or
> - * dma_fence_enable_sw_signaling() haven't been called before.
> + * dma_fence_enable_signaling() haven't been called before.
>   *
>   * This function requires &dma_fence.lock to be held.
>   *

