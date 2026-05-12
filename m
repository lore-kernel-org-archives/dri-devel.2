Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDE6CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B7910E290;
	Tue, 12 May 2026 16:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RvZvNstu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B2310E290;
 Tue, 12 May 2026 16:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIfumHtLZl4khEuKc9IKPHnIe7vVTjYhmKgZ3gKTY3nsj6y4KON93m3k/H/okYs29BKAcgy4tQAcev2TRWoTLyYWZ7xQGtQPxVc07g7Q/O5hgg+awrELIHhJlfpnFeMOk3t4F865zNYtUHzhyVU4VKjHjfcGQCebDnliuRaISIX0b/5OjZUaiuXCO7nA8EolJI/jevsxhrpQWsxsYPKXi559hJFR+d3NRd1fgIdpIY6t8aE0c/8yEYxz2UhqpOT1UyjYysicy1ioBx6ylOhVEZPENRDvUIwbTpER3vY3+bSSzJtHIs26eIE/M8SBgZMvMtr5ifGgCC0diJ+aonX0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVmXoNypSo3CwJJ69F5ACo5jxupgGYSLqhS/c1XrV+w=;
 b=Q+tdndjushWOMFThheXuyAIyuKoDYRgSALKbQVyROVmoyEEj5bUGfOdA7R+0pARIM/AIYwM/57HWlxC6nUmLFNQL7YccmCVzTdQoz4W8anWil5YAACdy4xrhQZvxB5dcevoh0wZEEPSeyBNuzXG+j6RSxL8fQlRL0HU/mUdjmcffOkGfCODTlXKnOISr+s0GXHLjW7CVqEcusKMVNZtKURKqFxcJNzsVKqXfcI18LaR7bVowXahvp+tEkXwnRjz3r+Nbq7lLVXGayXKI671kHBniKYq8SJ+uCOYTHtQBgGC0vl32UgXwx/+mIVkgGQGmEySor9rCDEzuhUBVSz3T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVmXoNypSo3CwJJ69F5ACo5jxupgGYSLqhS/c1XrV+w=;
 b=RvZvNstusahPbTpU1cs9HbFwl8hiOQnL10ogt4YDlRL2F3fNHDBDeSHUPgkLCojh5kEe1iGPOJT2TEdS+ZreCtfQCRMGT0kovvs1GKUnFjMY2jLNG6Y4azZuSrgpdmykNeGpse+gxv5DCgFBcx0dq3aIzrKryFTKIz58I3HA38w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 16:26:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:26:15 +0000
Message-ID: <606b422c-4531-4950-a22e-61732383f6b5@amd.com>
Date: Tue, 12 May 2026 18:26:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix inconsistent indenting in
 amdgpu_gfx_ring_preempt_ib
To: Leonardo Cesar <leonardocesar@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260512140142.6610-1-leonardocesar@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512140142.6610-1-leonardocesar@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2a3068-dd3b-4185-0b0b-08deb0432fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: oqvB733urE6fP9p2JGGmkWZ2DxTBStcxvgn6KIHOBfEQJG4fniRlxyYvBYyMQJu3DGiaZzm5VeJ10xC/EOo15Ig605l1drIoKmOqFdGe3PNoOrTaHD7HR+AeuEgZocyLwvt6q/KdTzeF52jtMdTgVqd1ez2cSBov7WS9dSWv8ID06u7RicVDibppAxm17IAg33GC0tQXAJjH461eYkW+vQE23hCV3h2AwxrHKtMOBj8/cpsGL5prQUz4rBov/PPpz1M93ok0iyjeE104dkEXoKWiJsenqXGMOoP6gY7bHTb47ZzxF9Hfe5zhOz3d3Uck9bJvjMpnKurP2GrIO1vpIotMIk9aPVViMwKTMpYcpLKoba/5NHBt8aeSinEWoMqRwrfiWvClMGRHNJxii/Dv6+3EtgyQI5ijVcqYaCJzsg9Pep2N7V1RmxJJAkghLxWdywG44X8sH/GS2yzk1OaYGqMuINXsAaiTWMqD0eCBP1DI6vdfSaOssW9fIsVi5hj+4iDCvxrZ2M8ahSoV7+zl1WZ/10MJB1JzyRJJI0jARhT595wtNST532bYu5q1tG3vLPMHWNBdqaHEWvQ34Gzvx3dNu3wQSIGUF2zFpdJ9ARKTql0QPNLcOJqrD5KNsboKzBn6DoQk95fyoySE0lPgCGc4oMa203smJlQwmMKz6w0iB7fMT1C6HFc1EfTCRRXQdN/bnmRBD7mlp/Qq1EezRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1HTzRhZDJ1TlJIanFDeDk4RHNlM0ZTb1RtTXllWExXSTZOQkNpZkNZczNL?=
 =?utf-8?B?aXEzSjNaQVJMYms0bXptMXl6Z2xSR2RrUm1jTlV3RFUzaENTNWJqelF1YlJq?=
 =?utf-8?B?UEFzUDZUZFYycHlmNHB1T2tiZkVQSE9zZ2V6VjVIam9lY1k2U3I4a2xoYndT?=
 =?utf-8?B?Y2w2bnorSDZnT05PanNhcW5wUFAxMVE5UXRlSXZzb0ZsSUV2M2E0a3FkK0Vm?=
 =?utf-8?B?WGVSSTU2ODhjMG81cUVDOTE0M0xPN3BZQlNVNmVVK0pCYUU1U3pidUQrV2xC?=
 =?utf-8?B?RjlWbjBOVkxDY29GL1Q2MVRZZUUwbFN4NXVzUEFZcFlKMk1CV3lhV1FOK09l?=
 =?utf-8?B?Tzh1cHhTZnl2SHBUM2ZjWXlHTFg4SVE1eXN5TFZHSXVXbXJPTjJJK1NWbFZI?=
 =?utf-8?B?bFh2bjNNTmhLNVowQnQ5em8ycFRWNWVvQnU3RkVKSnVkb1VjQlorL3gycm5h?=
 =?utf-8?B?S3BodG9sd3hCeXg2aDA0WUVhU0VmSzBWVVl1VWk1aEl5K2t3T1Fta1hLV0FL?=
 =?utf-8?B?Z3I0ak5MTDBEa0dOQXdTZzhFZGJLbWYrRVhUV09EVDQ3TThOWlpJYXFaVWk5?=
 =?utf-8?B?RXl4ZnhYVVZoN1RzQ0Q2aWFnZnlZVjcraVQwb0lSNTV2SlpMZEtxU2puQlN2?=
 =?utf-8?B?NGxRT2tNOTYwNXVjZEdqejF5Q240NVExWmVENE1EajRBaWhvR2VJWkhhdlFW?=
 =?utf-8?B?Nk9rVmJXWmx3cE9ndFFvZWRLT25sNzBtMy9oRng0d0Y2NGlHbHFBODErYTFU?=
 =?utf-8?B?UVRJMXFiSUp6ZFAvcU95QkRWcDlIVE42alRiL2VxdzdiNEJwNzIzdEgzTWxU?=
 =?utf-8?B?ZGZPRUFGUi9PYnNiVnRmSDFxK3FpZmNrQm9DTlNrUWVWVGlYM2RnR2VzdzlC?=
 =?utf-8?B?aU1aaGpCVDBLWFRtU1pRbGsyRE0ySEFWNWpMR0lVSytxeHVZOUh4VGFmTkZx?=
 =?utf-8?B?SlZhQjZDWXhnMFNqUFExeVUyNHB0Zkx2ZjFtZ0didkpsa014MmJvMUVBVTJQ?=
 =?utf-8?B?NzFRWHJROTBRMVJjYjBzd25LN1VoVEcycitXallWRzBvaUs4ZUtYdzYxRHdh?=
 =?utf-8?B?UW0zanBuN3Y3a0Jzbzh3bGhlQWlLNVRWa2xEN0V1ZWZuMWZVcGNoK0hLUlBz?=
 =?utf-8?B?ejNNVDU3ZWVvNk02U21XYm5JOStWMmtoZ2lLWXpqT2tkMjFmUU9kWGoxVWZw?=
 =?utf-8?B?aHNkdzI1Wm5VQUNlNFdEeHUybi9HOEh1QnRpSmRTeHQrZVoyTUYxS1J6bFVJ?=
 =?utf-8?B?Tk8xZVBnWmdKNVZlemtocGRUNXdoN0dWK21TOXluSEVhaTRVNlJJWEQ3Zktm?=
 =?utf-8?B?NGNvL29NNGVZSEtiV2IyQmp1bkQxZ0ZhUERVYVJoMk1maDBDV01ZUVdPNFE0?=
 =?utf-8?B?MXg4M09sdkRLemJ2Q2YweUIyT2ErV1hrZmRpbllLTUt2OURtYlNRRnRFaTJi?=
 =?utf-8?B?TDdmMm9xSGxZNThUQWRDT2NteWI2ZVBjT3BxUWVVbjFRYU9Nc3BSYlBnejJQ?=
 =?utf-8?B?WDFPcDlhRVFEcnlyaEFQeXU0ZFpJak1TQ1N2Z3hMdHpndHU3azBKczBQYmNw?=
 =?utf-8?B?YThQQjJ6WHEwdVpEYkQ5WFd6ZGxoTVVNRFhxcmdMUnhXS3FsQnQ1dERmV0g0?=
 =?utf-8?B?OFNOdGhUZjNSOGpoRm1saXNLMnhuR1RXa09ocXVtQklOWDhzc2ZnYWNHOFdj?=
 =?utf-8?B?dWNCclVLN2RmYkRJMTVpWS9lZW9XeFZVQ1JSdGhhbDRwMmR5aUtlMzJ4dFFR?=
 =?utf-8?B?cGk2QkdhQ0xaaGRRalBzMzhDbUpGN0lIZ21FS3JyTGd0K1FhckwxRVl6QUVK?=
 =?utf-8?B?TWxHUEZaTStyRjFSYTF2VFMrdm1HRHExdFN3TzZCaFNqdkpXbWJpNEtRTkQw?=
 =?utf-8?B?dWlXWjJYNElydlNpR0t6b3pMOWkzRHBTQThYTXpSaTZGQmlDRXFCNld5c3JP?=
 =?utf-8?B?RGFFb3NsT29oUXNHNVVycXNWWjFCTW5BL1RPSFFzUXg0Z2gwZmhZUlBxNmF1?=
 =?utf-8?B?UXZiYUM4LzVweDlzQXRXRERxSjZ3SDlaVE5BbWdNQjRSQ1Z4ektWRFpWTUpK?=
 =?utf-8?B?a1V3ZGlTbXMzT3MvVHFVRmI5ZmhNZ2gzUzV5bmlJbG5pa3NnS0F2YUQ0cmNv?=
 =?utf-8?B?cXY0b1dsTDZQL0tMOUdqcjB3aXRkU3Y1SEhFT2NYUldwYldIV24zdGx4Q09V?=
 =?utf-8?B?bU5NV05IT1VidW1jWE5uVUJHWG9wVU4vamFVL2U0NDJURFhUcjBZRkp3OSs2?=
 =?utf-8?B?ZWl5djB2V1lqSDVNalQ2UUR0Mmw5VWxSc1A1dzQ3YktMdGxCUElwdkZYMWpE?=
 =?utf-8?Q?QpWhlAkN9M7NSOiADn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2a3068-dd3b-4185-0b0b-08deb0432fa1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:26:14.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/HHeunigfir2xQHQnQVZ14kwazZyZmKumW4Wf9YPSTqKVXQOJIRUbIRTd6VUXPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

On 5/12/26 16:01, Leonardo Cesar wrote:
> Fixes a whitespace indentation issue reported by the smatch static
> checker tool.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605081621.Euvx7ORX-lkp@intel.com/
> Signed-off-by: Leonardo César <leonardocesar@usp.br>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f7ebead09..d213a0cdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2725,7 +2725,7 @@ int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
>  	}
>  
>  	/* deassert preemption condition */
> -    amdgpu_ring_set_preempt_cond_exec(ring, true);
> +	amdgpu_ring_set_preempt_cond_exec(ring, true);
>  
>  	if (i >= adev->usec_timeout) {
>  		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);

