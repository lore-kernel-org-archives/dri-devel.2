Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sEmHWx14
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6461210E0B7;
	Wed, 21 Oct 2026 14:10:17 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0FC10E0B7;
 Wed, 21 Oct 2026 14:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYyBsN9Ez2EAa1yw+34tm8zqtjulOhPMxbnlPrr/gaIdULGJpNgtE6C/8DOInQ1ivI0YrGzII1LNqQwlZqSuvVrGS4Qoct7QSgNdaVAxXjOAtoUol8RmDV5nS5GKfdeqR2b4n7i8VXV1UzUHdRstZyzx0ZbEQdTlYgIAlABjRm3fURah0qCcaE5j5uy+ftasBpGPj5Wb1F2k/pL2EsVURuTsZLBJjIFNYLwyBeIihTFG/xKMtHsTBA+dn53/2NeNDcsdVJPeQDFrrVACOzC0N83G9404uNQlzwmAAHbO2Dy0L4BRW1Gzl2R3U5i4qSjow5Spu5vJYwH7KX749q7hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT/UObBqqMf1T2P5pITZb+stYTNInYacJJuKE5k0x9s=;
 b=BDxQsisVOlQLhAnHxIH/EYovayl8AkqUemQC0OZTA3mf4ULqfay31iFkEU0Y1gzb4gbc8GB4JMWly2yoOYjVu+EX6DI4Gi012qQQOBp6sDitbGgQGpL3oEqfHwqx/fxe8RSZyORnnE8+G9ZJ7dYsPhvUZeFrggqIETSbif67qXfl9Eu5udOfq9LR2PGCFimkam5a2aIVvkJJ2YXsUZdr3TLYQs/PfI1J92TTZCtffcfh25quaNhsD7pD6grdv6RcZQDdqdTwESWhVLjrcLusZrY2+BmbVWK5s7Sv9hzPc1ZmQ8Uqc7VEXwn24kMkk3dAhlFO6pSV2+HYZ1rpO/PWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT/UObBqqMf1T2P5pITZb+stYTNInYacJJuKE5k0x9s=;
 b=sEmHWx145CdEFT0ohHqKa5B1Sj5UJbyHeb+Oz/nJoyAmj4Px/2DawQi/9CXIzRCTANPUph8d7NS1SM4MrihtBUpiHVbExYQcE8WXiLIBabnwufi4X29rLRAUEdMrpAxkjf5uBaniZf6N66StbArzqMTPBn6Saoz+zeP4g+nMjEs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LY0PR12MB314516.namprd12.prod.outlook.com (2603:10b6:404:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:10:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:10:08 +0000
Message-ID: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
Date: Wed, 21 Oct 2026 16:10:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
To: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261021114122.94008-1-mptagliari@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021114122.94008-1-mptagliari@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LY0PR12MB314516:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bcb459-3ebc-476c-f4b2-08df2f7d0314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5QeLOhadCAoJUmufYfCwCtraZIZIz4DOOzJRNjl2PtPtFjuhCmpbKrj9UYcoOKkC3OXA7O8jjMBXTY3+fCmbg8krJ4BJ5FiTIswPMbeSxX3P+7QrMxSLLzWHhfIptKf7Gt3pIaIZD9JG2mNhTcN/4DyCCW9jnCqLGUdGhij7E22o96c2cm7f80wL6liACtiXsc76D3BdGV+XLm1LbkYP2k12xH2+BGy0EwLFI+os/xbnwBQpiSGxJDeZRmUgJZjovd1kiCefYUnezOuKNhcS1QRTwLUPEPUEhHYt9fu5DVrS4OXVMjqZVRrZw0Pi0IuMUFyObYnatmoszoy8zw/hfjDWvtKM4DCU90dN91FvTTDKXehzX7QHjAgqqCnow7JrEs6hnOl9Prt0zyYvvVU5MZoL2nE0hwRYPS0iPtf9f5gYVzwF56UyurVCqGeccBPxHspOg8CUGAGJFC4QQNvo7qYs0vvyku3xr0ji1jykE8W6YLdtzuNXkf9j+vQa1StnZDiiVcQX+YDsgyZ42gJRzkGIbicsZJCdwnRWBCMhUMkimRhQvL1x8FaTnQJoOxbaATv0BklNMX0J4BZDM6NlDt39Nlph9FAGS/q0JaEXcW/8I2ZFheofOTscxRv2MCo2fkxBIm3P5qe+loH4g7D/SVY7Ld/plpoGJuvqAdLwK8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVM4b3M4S0pZQlQyK2Nwc3dYVDlycG9JNExYdHpXdDNsWjVQVDk3YnVUbExq?=
 =?utf-8?B?OFNIdkh6a0FwUk4rSE9xMUlSSnVKN2MzUUtiZWxvZERPMTZUMUlHK0IxTFhL?=
 =?utf-8?B?a0g4eEtDR2tFMGNjamF1ejd2TmlzZlF5UWRqVlBaTkN5S0V5SGYyNExONkpW?=
 =?utf-8?B?bWlRUW9FdHVIa1VBL1JjOU9kTHNDZXZ5WHoyYnQ4VEFadStIcHV4dW9BSWF0?=
 =?utf-8?B?NVVLK1V2UGhTSWVGRVZQL3E3QTZLUjc0NS9CRFE3cGRIQXoyZ0pSazVvRWxh?=
 =?utf-8?B?MTBQQzhuK0hYUVEyZUNHRlk4WHFhWUJhVTdad0hVTEh4b0hVMGc0MlZDaklr?=
 =?utf-8?B?aDJOcjdLNDhJbmd5WW5SdytuTnp5U01OTDBETThUYkJTUmhld1lOeDVVZFBL?=
 =?utf-8?B?WjNUNXJIZGFnbC9LQ2o5VVNvVkRJbGxLc2l1ZVVNMHU1cWVLeFZMNEU4S3Ro?=
 =?utf-8?B?NUlXSDRtS0U4N2ZFY0hvWTMxbStIZnNFZXZ4MUFBd2J6SG01N0ZFbUxibXVt?=
 =?utf-8?B?OE5jUjR1YW5QSE1GNWxtUks4cjN0TjhGVGxOdnVNcytuYlRybGtsc0dLa2Rs?=
 =?utf-8?B?LzJBSm5sc3FjR2ZmT1c2N3Fmc0wxVTVEa3pFdUMxbUU1Z2RvSDFaY1VGMkd6?=
 =?utf-8?B?VEp4ZTIvaC9wQzdUT24vVzB6S1E2SzZIU2dxMGY4NHg2dUM2WllTYURWZExS?=
 =?utf-8?B?alBaNkF2M1RLaENNUVBYNGF1ekh3WnBPVGp3TlZPZFpMWW43Z1ZxMncxTkpW?=
 =?utf-8?B?WUhuWmVkS2F0NytZWHVwWnVwVXl0Vm8rU2RXUEprem13blhSb3JzU3RWeVBS?=
 =?utf-8?B?QitVY1UwVSt3N1grL0J4Mm11akN6NlVhdkZDbXFVa1Bnd3Zmd0lRMWljcFF0?=
 =?utf-8?B?TVZGeFFJYkZsWjNFL1VBeURTSm9BNHdiT3UySVIwMm9aWnFxeWtINXRNT21S?=
 =?utf-8?B?ZzM1YjRZemNnSTRUMWlCZzVsbXlmNG9RNlFwc00xWHZGSG9zdGIzdkpPUFFu?=
 =?utf-8?B?TTdZZk81SklqNDl2Nkd5anhtR05YZ0RsYTNmVVB3RnZPVTdWbDN2c1ZkNlB4?=
 =?utf-8?B?RHQ5NHdJYnFuUXFlZTl3dzhGMFZ2ZS9qdEYveFc3dm1nZGxVNWpXWVhOM0lq?=
 =?utf-8?B?Y0ZQWXdydklUcmpJZTV3R3poQkhKS1drdllFeUNoTlBuSGgzQUlTTE4zMzBo?=
 =?utf-8?B?WTNsQnZrTFNvay9pLzNKNEpVK2FqaE9IaVN4bXl5ZlBnRXUvZzlPSUYxclpD?=
 =?utf-8?B?Nm5YZFkrMW5BN3dpQkkrVjlUeU4xMmtMTEswbHVVODNENjVPcTY0TDFIMFpJ?=
 =?utf-8?B?bmlzTTR5QkVwaXk1ZnFlNjZIT01FaUpkMVNldXU3Y2dwUHRramZacS9tWHNH?=
 =?utf-8?B?L09MdWxubDJ5Y1hUaVFYM2NYY1F6YUxkaTNEcng3VmFDZGp4aWRPMCtuUTRH?=
 =?utf-8?B?K3VDQTB4MEJtVDhQcFZpelhkYVMxeDEwZVhPNHlhQlIzbkZKUVo1REk0eXVS?=
 =?utf-8?B?Q0pMd2dXaTNNZDNFUjU2MnYvMzg2TU1UMXJOUzNKMDlTQ1ArNzBMSW55aFRu?=
 =?utf-8?B?U1RqaWxreE9HNkdDYUVUeS9OK3p2M2NJYjBkQVNlTTdKZDFDZnJ5LzN2QzNG?=
 =?utf-8?B?S0J1MVR0YTc0T0NoZGhQWE1hTDRkUWpMUEc2VUFFRUV2SU51TEVwQXdhcWZL?=
 =?utf-8?B?eTlXQlArcStCT25TWXJQTWVvd3VhTHovQjlES0pLMVN2SFN1K3JNVHFFMTlB?=
 =?utf-8?B?dWRJUGNwa2J3dHA3SXo3NElRekZDcEY5OVpWU0gwcysvNHpJUzFZUVZuZ0Z5?=
 =?utf-8?B?RzVRc2toeFlBMU1hYXEyV0xGRlB0NXBwd0t5aTFyVWNSSzVzSGM2TUUxU3Uy?=
 =?utf-8?B?TXRRNC83T3I0VTJsQzBkVlBucHZqMGkwR1Baa0UyNDl2UzF4NlR4K3AxMGxH?=
 =?utf-8?B?bStudkNSWUwrTm1vS3AvSzRaS1NPei9jbE9VQ1lEbjVwOEg4aE5keWFpWk5h?=
 =?utf-8?B?U1JMWnB2aEVZczc0b3Rrc0YxL0dpb1dodjNBVk9WcVJGSmduWjR4NklXRkN2?=
 =?utf-8?B?dGhZNG5OQWMyT2tDaGk2ekZLays5OERuVVZYNlJLYUg2b3UwTHExQkpNYXRB?=
 =?utf-8?B?czhnaWp3dDRQWHltUHY0MmM4QVk0cjdxL0pDOCtqNG1YV3hJOEZtM3oxQ2l1?=
 =?utf-8?B?M0h5WUhzMGFESjFwQlVzZkJYaGlmU2tLYnNjekNhaU8yc012NWJBNFRIRVZI?=
 =?utf-8?B?c2wycHcwV3k0cXc1YzRYRXRTZENMR1RybGV0Rjl1UitQR1BlYnZQT3B3Rm5D?=
 =?utf-8?Q?htbct3iLSYKImaMq6l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bcb459-3ebc-476c-f4b2-08df2f7d0314
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:10:08.3026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql3206QjDWabWyPxzQCPAVNYYg2gabRhSMFk/hSi6gh21Pzrst0p+Y9PkznQXO5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB314516
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Adding Timur on CC]

On 10/21/26 13:41, Matheus Tagliari wrote:
> Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
> hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
> RDP server, which encodes through VAAPI, and reproduced it with a
> plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
> 8870M (Cape Verde).
> 
> The VCE1 code never enables the VCE trap interrupt and the SI (and
> Trinity) interrupt handlers do not process it, unlike the CIK code and
> amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.

Oh, I do remember that I intentionally never enabled interrupts for VCE on radeon. But I honestly absolutely doesn't remember why (that was ~12-13 years ago!).

Timur hammered out most (all?) of the UVD/VCE bugs on SI, CIK and partially Polaris hardware as well for amdgpu and we are strongly considering just dropping SI/CIK support for radeon.

The fence handling on radeon should work completely without interrupts since those have been rather flaky on really old HW.

So no idea why that actually crashes for you if the interrupt is not enabled, my educated guess is that enabling interrupts actually doesn't fix the crash but makes it less likely because of timing change.

Would it be possible to just switch over to amdgpu instead? Or is there any support still missing there?

Regards,
Christian.

> 
> Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
> none after, and 34 fps instead of ~4 fps for the workaround that avoids
> the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
> client, now encodes on the VCE ring for several minutes (about 40
> fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
> clean kernel log.
> 
> Two caveats:
> 
>  - I have not worked out why the missing interrupt turns into ring
>    lockups instead of only added latency.  What I know is that the
>    hang needs the VCE ring to wait on a hardware semaphore (disabling
>    only the waiting side, or both sides, of radeon_vce_semaphore_emit()
>    avoids it) and that handling the interrupt makes it go away with
>    the semaphores left enabled.  If someone knows why, I would be glad
>    to improve the commit message.
>  - The Trinity/Richland change is compile tested only.
> 
> The series was developed and tested on Debian's 6.12.113 with the
> radeon module built out of tree.  It applies cleanly on drm-next
> (fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=1,
> allmodconfig) both after patch 1 and with the whole series.
> 
> Matheus Tagliari (2):
>   drm/radeon: process the VCE interrupt on SI and Trinity
>   drm/radeon/vce1: enable the VCE trap interrupt
> 
>  drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/sid.h       |  2 ++
>  drivers/gpu/drm/radeon/vce_v1_0.c  |  4 ++++
>  4 files changed, 34 insertions(+)
> 
> 
> base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
> --
> 2.47.3
> 

