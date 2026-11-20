Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E07606A338
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zU6f5TZr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516DB10E09D;
	Fri, 20 Nov 2026 12:08:14 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C2E10E030;
 Fri, 20 Nov 2026 12:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh623SoT16ncqO0hxoItPNN9UfSPQDct/BSFVOXoYr/LZRsV1aI318Ws3+ynauMK7KFAsJUPDhelO5x1Kc50U4tITDeSpCayu4iDgHDj7bzZiOVl1/s29744ydEoikraiZNKaXsl+CE13AWLNLuUcwLYI8RadHsx6o/IzSrzxak9QvknVRd+qcStYKobpVlNr7NwjBmWs6UB9Z51CKLlTDcq88gAPm1J7vgmPaYDw1a37zRYoq6XYwFf5Hks2OsXZJTM8CsXgG2kFhMa/1l0ioZMhs0nx/8/KaDsGt7MuirH0NVsdJsKogjfsa0w9TBnuSVa5sbAHQXMWtE9zQxlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyI5xtZd12Nd5q/9q70XW/CL/JtywK/0y35mWJprKzU=;
 b=fkoob1mLPeFxHe3I0jmAiWaGSXHvZg5eN3w019WaAz8+bGldRmRamHfkP8PfcSjjGg3Ej03JmHEE7O+RMX9QR6fXS0j/wlmDkj+Ma0wx/VNkCChiSrcM3qdMcI4zlS8sE3QElzhEyvCGwtCis7FD8T5oSRS+ydUVGryZxVOZF8+QvrHcH+I6FhZ4EArMnbWaz7Seos7qJYQmYKBt5MtPNwVXc/YQAHkaNpCaxY0L3JsodxEoG3jqnNrTVRKSYZLIahRYw0kWJE36L6dAX0m8QXOYx78IJjVR53iU6pXNuo0ViCqlu29W6Mazzam1IWj36QAlypRlSi6jSUrw0DI0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyI5xtZd12Nd5q/9q70XW/CL/JtywK/0y35mWJprKzU=;
 b=zU6f5TZrxxoA3iLLLOU5G6zqn+1M/1P4IPmBGFNteoRJdaxA0c4hIzkE916uUEUwEEul9dj6MLxzXqFs0HDbdpEISxHCJXWpUnVMU6La3OA5iG/5KGy820M44M3lpDYXiPARy7dGNv3fg5MnLkKB2pu+vXbAD5Nuec6/RgdnIk4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB980390.namprd12.prod.outlook.com (2603:10b6:408:3ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:08:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:08:04 +0000
Message-ID: <5fb8ce65-923e-4714-946d-ecaa4ecad399@amd.com>
Date: Fri, 20 Nov 2026 13:07:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: initialize r in amdgpu_vm_bo_update()
To: Ian Rogers <irogers@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Elkin Cruz <elkin@google.com>
References: <cover.1795106955.git.irogers@google.com>
 <e8d983aa6f81be52ea1bb9afc9c0f47d4632c1db.1795106955.git.irogers@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e8d983aa6f81be52ea1bb9afc9c0f47d4632c1db.1795106955.git.irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB980390:EE_
X-MS-Office365-Filtering-Correlation-Id: 1374fc06-0d16-46a9-9301-08df46feee4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006|261026140227099003|261022105027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: UD1nk6U9EVdM2li/6h/pbPAqoR/5Y1jwukykLRRMCLQ7UZ3JX5/i6eN1TTcYmZmay/y6JzYk/yUzgFa9r5zulI8HD5xKdWNuPha2laIdUg46qlFUrsmzjbAV9OJmqwfM6AEhkJIla0jLwTcRyymtI1ateah8fUB23xEeAyIITL8LADAgvrH6Jt0ejpVO+JpUj0HYWHeS5X23VsEkj3z7FPWKviIhiegE+RLcGWMGsFwamZmkvdRBIz12UwweC64stlO4xsdE3MomNDZB3d5ovN2Sktt+pFa21N7k0qpjPOi3qpfek9CMpRnqiKFbluxT83Zf9ZkiUkgyjAguQiX3smR5xOANchgdky3OgD05w8Cj0mEIy/jGQPXk+UwJFO4hU/NjjgKAhMSYu2SVo6I5HDumFtSETXft4KOqhmzaF9RNbAXyyJzBT+RrCJ+u4JOmXmC0UXE7Nt/1cA7yaqnLMDyNpl5D+XhyM3W4rvqrvj0152X3eRiHhEIOfjVNMIdBpIDQ0Z8/sRDK+EnnQ+MNXsK71r6JkHivKMAfwJpr07UFmn8lvN0T5A7StNiJkrWUkm3l696YmJIGbilR/riM0Bz30IuL2TI/oBGb3e+Nn+bUyeyZlIhzad92k2XNXCGDjohrGhc3XSVdTx0B9gCPEGWbU1Ho4QqiaIGb0vE1W1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lRbS85R2ljYnR0THhQNkVTcDFaZ09iSE5iZjVoNmNLWU9XRkhxVGxIcUNw?=
 =?utf-8?B?bFhmVVhTVXBxQU9vdnJ3ZmhFdU1rT3hJaE0xRS9IVzBlQmNDelp5SWpoM0JI?=
 =?utf-8?B?RFloUWVyVGQ5ZG13Nkh4bm5GaHJtQjZvVW9FbGkxaW9zeEMxWlcwRkxyZGFW?=
 =?utf-8?B?UEgvM3pPS0d3TXNaNkgzNWNNc0c4K3hWS3k0N1dZazQzbU9rZExabXNEZG1K?=
 =?utf-8?B?ak9mcnVFTXYrYnhWMFJHZnpCcllzTVJzVWo4dWl5RDdKNUlBR0x3MWZMekgx?=
 =?utf-8?B?a2VpdmRJOWhpYk9rSXJMT3JRckVjMW5nL1RiK3VLbmlaN2MwbytoMVM2STl6?=
 =?utf-8?B?QWtZWmk0d2gyZ1EwRS8yZWVPOU1qbnAvRFVQS3dzYThhN1VERHN1TDdGNTBT?=
 =?utf-8?B?Q0J2Rzg1N1hGY0pPbXJkdlFrR1crd0pPN3FBQUhZL0FCTUo4WTRuUmIveVRn?=
 =?utf-8?B?aUR0YUxkM0VldnhYaUdsZlJXcDVDSmNIWDVDbXZCeFo3aXBKcWFmSXJuS0xv?=
 =?utf-8?B?MFhvSU5iSUhVZHFOdjdaZHlFbjArenFXQ2o3eGxDdXhDdzJ6RXQzZk15NGtV?=
 =?utf-8?B?ZWFXMGFvTFZmR25TZkd1MkRTNGtPWS9DbzVlMTlqQ21sTkd1S2hMalFBblNK?=
 =?utf-8?B?VWIzSUVpZjJPU0NpZmlKcVlvQ2lOalp1QUV5QWpEWHlVc24rZWg0a1FwdVpa?=
 =?utf-8?B?WlkvSURRL2ppQ2VzRGlzNnNLa2tMLzErNDRwc0FweXR1U3pBVUQvb0N4dm56?=
 =?utf-8?B?U2t3V3dNMnpsclNPdUhhWWFvRk51MXRYVFoxSC9SSS9sbnZXcjhybjNjeGw4?=
 =?utf-8?B?NnBtRmRiRCtER2U5ZVdtMEg5ZDNMbExWTW9WSFI5Vzc1ci9VRUVBUDEyM0NR?=
 =?utf-8?B?NVluT2pjTXJ2WXlmRm1pSW9wQTdNMEY5UmY1NDArVzlwenkzNUg3OUc4RnVC?=
 =?utf-8?B?Ymc1UVNDb2tIbzJoOW0wNG4yMW9PTk9OMmxETTl2Z0xieGNnUWZSVXdKL3Jm?=
 =?utf-8?B?K1dialJJMitSWE8yeWR2czFDbVl0SWNjY244Ym1tV0pwMytXeXdkbEY1VWFr?=
 =?utf-8?B?OWl0MkxrLzZMTWE1RWhENW0xT3dLUHU0YVh0RDdRNnVNNXZJK3Y1d3FhekNY?=
 =?utf-8?B?cmxDWlZ4V3hBL1JDTWdVN1RHYjlLd3JJMlo2eWlORWVlY3R5NUJ2dXhHNkVV?=
 =?utf-8?B?aFo3T1U2MEFtQ2R2TEg5RjJkMkNXZkhjeE1NVVIvZ04wL1JqWm5FY0ZEd3Vx?=
 =?utf-8?B?ZWhwZUpFNXUvTEw2K29tZW1oR20ySmUwOWZuaHJDczBkNUNVK0ZtVTBuSTFR?=
 =?utf-8?B?eENGU2lxVWozRm1hT3ArbXBVRCsvcnI0cXpUa04yQlgrMnJoa0xJdTJuTUs4?=
 =?utf-8?B?UWdaSFJvMlpuUWRERGJqZUZTUUozSmxkMEVGMGhnQnY3KzRMWGc2RnozTEtY?=
 =?utf-8?B?Q0RmOWkwZVNaQ3I5Y0g1VnA2cEE1M3JVdFNzWElEOGlNZEVvUisrMXdiQW1P?=
 =?utf-8?B?TC9ncXpTaWUxdWxvYldGaUxIMnc3WlpUMXJTcXAveGNXL1NUNVY0ZlVpcWZZ?=
 =?utf-8?B?OUtwck40Nm5kVnZ5OS9IOXZKK0QvRmEwdjk2UmRYbm53MzBtYUs5cWEwN3VZ?=
 =?utf-8?B?dkU4WGpXMmJoaFRaWTl4TmlEY1FGQjNoeHZXZmdyT20yTEdIYll3eU5zeTZT?=
 =?utf-8?B?RWlXdGpKcTlISWg5QVFPMVYzTlRHbWNMUThSVDloWk9XeXF0NnY1VFhuWmtn?=
 =?utf-8?B?OHV6aU4rcWtWVEhQZkh6aXZXSldkMXFRUlp0NkNORHgwdGZZVzBXbU9qWHE1?=
 =?utf-8?B?RTNIeFRQVDZTTkROVWUyckp2MklHQ0VpOVR0bFVadDZOMmVJb1BRM2tISUlX?=
 =?utf-8?B?dVhQSFJDZEZ5akQ0ZDh3WFo0dERzVUY1S3E2RThLRXk1SStGTld6cUhmOWZC?=
 =?utf-8?B?OXFGZ1ZtOFJmTXBUQzdMa0duT3cvcHI5VTlKNzZFU05scUhFc0twQXRQdUln?=
 =?utf-8?B?ekdHT2xvVW5ZMWF3Q0MveHBKUWZKN1NraUxSTDRQVE1adXQra3lreENHdlJ5?=
 =?utf-8?B?Z2hVWHA2ajNZWVRQUXFSKzNTMy9mM2o3Sk8vRk01SmxCWllXc2lmbTFYREMv?=
 =?utf-8?B?a2paM2xpMHlqNXZxRXl6by9WNFRCbHE5QndEck16VFFQczcxeHZDZ254RTli?=
 =?utf-8?B?SE1VSW1VMTgzaHVEN0s0dy9tV1JNcjg1SVowNksvdW5iZ3J2cWxUaXNmUFlL?=
 =?utf-8?B?c0F3Q0ZaSEZLSnZjaTNZbTlpNHVCNktmM3RGRHlYaDFsNnptNjZSM2JBdmQx?=
 =?utf-8?Q?ig2MHgezPT/adj1wAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1374fc06-0d16-46a9-9301-08df46feee4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:08:04.7214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLBoeh6Psz+b63hIi20uIy0kIF/xGw7QAol+uEWsMnn34V70ya2q4zdCPrezn90V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB980390
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/26 18:07, Ian Rogers wrote:
> Commit bc566781845b ("drm/amdgpu: stop syncing PRT map operations") added
> an 'else if (!bo)' branch in amdgpu_vm_bo_update() that does not assign
> 'r'. Because fpriv->prt_va has bo == NULL and is updated on every command
> submission, userqueue validation, and KFD VM restore, calling
> amdgpu_vm_bo_update(adev, fpriv->prt_va, false) when bo_va->invalids is
> empty skips the mapping loop and returns uninitialized stack variable 'r'.
> 
> Initialize 'r' to 0.
> 
> Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
> -Wconditional-uninitialized enabled; fix and changelog drafted with an AI
> coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
> -Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.
> 
> Fixes: bc566781845b ("drm/amdgpu: stop syncing PRT map operations")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82b9b2d5d0cf..091589b2c524 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1303,7 +1303,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  	uint64_t vram_base;
>  	uint64_t flags;
>  	bool uncached;
> -	int r;
> +	int r = 0;

Good catch, but please don't initialize return variables a default value.

That is often seen as bad coding style and often hides problems instead of fixing them.

Instead just initialize r in the if branch where it is missing.

Thanks,
Christian.

>  
>  	amdgpu_sync_create(&sync);
>  	if (clear) {

