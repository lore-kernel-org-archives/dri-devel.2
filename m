Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC55606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PQ8R1X42
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF0910E680;
	Fri, 30 Oct 2026 05:54:33 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F1C10E680
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8VDxOeavt8cm4iKEPnh2SWrss0O7SflZ/D+LaHMNdWnK52ezeihSNedLAGKoI16wnXchJ4kqC2ATQ61HKa07cAKGWomAgb4grur+36cwj7EVa6Da4v8sFCZfS/wVmBO/LsrOfNJvaJC0zcaNONOzf1jEWvPa1JoSqvfb9dngRFlM+qD6vvdHKNG6y37Mi2AaXnijQRI1XHdi7veXr/A0acX+KX1GvPM29VY94hfC7/Eh5ZFHexXyPPnnXJVXM+APEpDtxW0u2oLhxxUiglo9xNdWYRPsqp6S8rCbFZXb+3vyzCM0mOxB3F5DGkS264Toien7Iu3NEh3cXvU654AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L77iIrv7ZZ3h/89dP9A3PvLYwPbUGsppcJgOlAG4TtA=;
 b=kzt4B4yUcDxSSnmMkvw0NYvJ8yW7aiYMWEeTljcQ9+K0aQaFFcsJKuLcQEpEFWGUMp1Z1GSH+GyAK0nawIbck0RaUDIP5GE97wuKrNjoxeF3iX1reV1p1nDlepU8qUrWJi5d1GqPTWDY0Cwv6Javkl4QggzPWIyWlHNxYlPMe5zayHLVwTa+JpKJBDEfxOb7Ikq5WNHPnNxZM4vLYQtxeNVEG5l4927HCRETk8OL1EXWHeC3AqDCRBi4LEZiw00XIVzR2YTZdNHp47ZElSRhjm//pvjY2X42DaTDSsD9uqF4RKFElZN360ldP9he4aTsCjvxVX0acV+vloryWz/e0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L77iIrv7ZZ3h/89dP9A3PvLYwPbUGsppcJgOlAG4TtA=;
 b=PQ8R1X42lhJSM4/IR6vv3qehZEj71FYbPSVXF0iPWtR0L/12tVJvjcw6lLiEVfI5TuMtlM0sgpZoGm/kccCfpKPg6QgNkqD1rEZA2OWJggGb48tPkS5o1tpwAg8IMMszI8ALmbAFi1tUf1/ow+v3pLv55u5OyWIQbD3vtUsrHBnB3NOUeyLZ6ZC0Sqmp+wlpV6auQEMwven/+U1Ky0tMs8OhMFfXQSYAkMBFVnZWxu7gqvRZ3/3/F86OrQnd+E2fHqCuVe3y8uhZ6Da0Si3dvtLh2WMO0SA809xJV6u+5cDFZEIa2p9Z8vaU89SQu2FiQkGT0AKzGcxHTvJEYJJbhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 05:54:21 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 05:54:21 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, linux-media@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: Re: [PATCH] drm/tegra: Fix dma-buf reference on import errors
Date: Fri, 30 Oct 2026 14:32:23 +0900
Message-ID: <rOjrytXLQoKMi-JohQNB0A@nvidia.com>
In-Reply-To: <20261026055842.96484-1-kmehltretter@gmail.com>
References: <20261026055842.96484-1-kmehltretter@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7PR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:604:253::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ed2bea-c76a-437d-05f6-08df364a3e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|1800799024|23010399003|366016|261026140227099003|11063799006|261028144727099003|261026121527099003|10067099003|261021123027099003|261022075727099003|56012099006|261021121427099003|261009223027099003|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rucRruHn/k0dxCqrulxGxlcC2acJgDcHiGhVHWY2VWz1hep4/Szg6HARoRBI2AbmAaNeHHGGpvEYVwstgf/6O4wy0FImywFTdBp194Pkhe9r18wr0hqT6XdNxt3JpdVA2q8qve5WdponaUmlJU+Xx5PSe7RDxUupz+J/Aqk11unKbepIla/c2In3TF7Oa+2iZ82Ns7qLeNXjibtwUs6cn9SrSEgMytx69e0s0IDfBG48KBTPhVCm3MXA+wz0Tr5aCurgyCk0zYZ4SPSknfyorVjlHgQmf21zv068eDGLZQQuQZs0DOd/TZXlufsHf0a1ufRZIKxyz5yARUR2lP2nAHUiTJxufCqLLNcWGTYSQkzUUZmk7UU5A4m8IIc/YPWWRnk3BFXI9pTigBMxsxUZAh1AE0xr6sbTT9HnX7Yd1wUdz5FVgV+lBFQfU8z/+86jXVRhhf+loBYb3YT9KEB0TKFJ6LDvNAS3/tuhSgTAOhPmEXSHNFiLMC6yzf1ePoLO8HMqHp11zscJbOlo5+BOzIU+CtOxb2DMXENDNMv71NEzAhshJDQp7wUHv+Xt68cMpqGDCq25fR5LoIzj5QmhxxcRwUxV2+/AL45/AWbwu2c0YWQe4sNOt0mo6WCJH+Q6zBrYzp8bqyxdh2sfz56v2cb3CMkz0TluTU0fp4i20ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(23010399003)(366016)(261026140227099003)(11063799006)(261028144727099003)(261026121527099003)(10067099003)(261021123027099003)(261022075727099003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3p4a2w5Nlk5aUdacFJwRUkvUEhuMHVady9zQ2VTVWV5Z20wclBDZ2oyZGpi?=
 =?utf-8?B?WDBqY2ZOM0pIaDdBY0VYQTZSVVBaRURvdUZwOHBDVWc1bGxVMmxIOWZkcG9l?=
 =?utf-8?B?UjU3Q2dOcndMSlBGcXA2eS85aEdSU1FCM3BKZUNJenQ2K1hVVkQyS3lNejRO?=
 =?utf-8?B?emJ0MFRJK2FvWStaZkh6OVViSjNvQW9FWVBoTjB5Y1FKSmVNUG9SeFJSdWta?=
 =?utf-8?B?Nml3bG9tUENIQUFQeWhBTmRWRFA1K0pzcFFlQW1CMFNDdW16VlBuZGlIMFpw?=
 =?utf-8?B?cVBBRUdESllkdldVS3VNNFp2UU4zYVR4UHJKdER1ZTZrSkVMZ3Y2S0ZXOTBB?=
 =?utf-8?B?V2lZVlp1OHlnVjJiVW0zYnJEUDZVMHFvdG9RaTRSMjU5OUswRUdSUis2YmxZ?=
 =?utf-8?B?M2hsMUxHZ1pJK0xCcUZPY0FKVmI4eUFERXViZTJHdElVUTR0a0tyZnFJbWFY?=
 =?utf-8?B?d2tzRTNHbU14bUpjbmllU21sQTRCY3lUNktoRWp4Mld1NGMySlJvS1NRdUww?=
 =?utf-8?B?S01MbDFrdmdVWTgrK1dKa0tSYVZlYnpsM2RaUFdWMk12RzVZNzB0bkVSTjR1?=
 =?utf-8?B?VDVDeDFqRUdKMWV3dDRUQ3dtQWZhTHovZ3hsZkw1bGMvcEI0TVFCdXNFUnA4?=
 =?utf-8?B?akE3NUlaZVc1blNzRjk1dlFYeTRFb1YxZHNWVGhPVlJJOEtWTXkxblZtd0I5?=
 =?utf-8?B?TjUrU0lQM2NHdStIWU00dEZ0TW9GMXhraHJkUGVWWExEQ1JZd0gyZk9oVG5R?=
 =?utf-8?B?Z1lXNmNWS0pSaEh4SCt0WXZEbUxteDFvbGg3dWliUkZzbjhvbmhlemtiLzlG?=
 =?utf-8?B?ZkNlOFFrbnFxRHJQditiS2pIMmczU0dkOUpsRE1JWm5vK2Nzd3BNWnpaMTFJ?=
 =?utf-8?B?bCtoWS92VkVyZzU1Mk1GSXl1bnRSdytDM1pOekRaVVM1dE1FdW10OVp0RUE4?=
 =?utf-8?B?VWM4MzlXeGJ5MVB0Tm01Qzl6L0YyZGRYQUw1OFRRMFlBN1hMc2IzOXFrQzFw?=
 =?utf-8?B?bTFHMFRpU1ZHb0c4S3BxblJJMGltR1RjcCtPOUlMOFpDU1I4Y28vUEdkS0Fr?=
 =?utf-8?B?dkhJajIxbk10NStuU01kZEtrckRjckN0V2VtbVhzdU1KYUZYREJYWlhYR1RY?=
 =?utf-8?B?endSWkp4b1ZXTmtpZmR1VkZXSzBFWWcrZThyOTYvQlYrbTcwUjQxS3ZhaFdx?=
 =?utf-8?B?S0oza3Bmd21IanA5YjJTNDZhY2ZMYm9rUkdiVlhvMEpkL3d3U0tVT2g0bE5C?=
 =?utf-8?B?alE5ZDNkZXB1RGRUYXVHczFDMEdBSW43SnpsaGlQTitYVFNjdXcrKzFqK0pt?=
 =?utf-8?B?M2M5aVNsbWI0SUk5blo1ay9wMnB1SnBMNnBXZXJ5ZmxPNVZGQ3VvME80VUNX?=
 =?utf-8?B?ejhycnRDQUpYR2U1L2x0RFkzQVloWVcwd21ud0pGYUhWQkloTEloa2pMcDV3?=
 =?utf-8?B?L2RaTWVMQm5nUU9BSFlCUGxPRVRFcjdrdTNMcVJsZFluN1hvUHlLUmpoc3BJ?=
 =?utf-8?B?QnRCQS96M3ByaStPT2tyS0Z5QmN1QUdFa2tWWTgzME1qVDR5NTVMaUVHQSth?=
 =?utf-8?B?SStDLzMzSzdsdVhuN0l4dmVRTUVqVFdtcU9ITVUwaVdHKzJJc2NnTjJrV2Jo?=
 =?utf-8?B?eG44aTNFMVY4emMxSUVRajhZQldIb3g3UmV3amNOSGlpb1FoTjhDRllFT25V?=
 =?utf-8?B?ZzRBNit4MXljcDJ1QnFLOXZGQVdUbURWK0VRcWhnV0tTNm8wZFBKTUtWWjNI?=
 =?utf-8?B?V1VRK0Z2VWFSV2FsWFdxaU1TTnk3L1JnclB1bEVCVVBzR3l2SW1OdDdBS0Z5?=
 =?utf-8?B?SFY0TnlhYmpLY0FoNHBQZ1MyVjByclJ3NWpibHUzVzU2TXp6RlFsWmp4RDhM?=
 =?utf-8?B?bWxHL2g2N0NVLytjMVFQZ21FWnpHYytEanhwc05rZkpuL0Q1RWF4MWpsZkVF?=
 =?utf-8?B?UjZacWRReWxRaEszTjE2ZEZwbXJiTlk5WTRwZG5RWG9KbCsrWmsyUDQwZjNR?=
 =?utf-8?B?aHlOWkozQmppZ1cxUFp2QmJkb3Y1T0lUVmlicEs0eHpRSHA1TmtoNFgybk9B?=
 =?utf-8?B?M0RFMVozb1FBcFl5SVUwK1JRd1FDUTlyZWVaTUwzZnZveEx3TVJrVUJ5NXNq?=
 =?utf-8?B?WDN0TDloNzdoVFlId0VYUzRUQzRnWnk0am9vSWFJYi8vVEgvVXJpT0h4cWRq?=
 =?utf-8?B?U1NEbldoTWwwby9IWk8wbmt0SEo1a1k2QW1wVzVJYTUvMDhuTTlHWFo4cEhZ?=
 =?utf-8?B?dWV6TXFsck1RT3BSM1JZLzBaS3V6aDJwZFJVeVZDY1Y4WUlWRDdxTk02ejVO?=
 =?utf-8?B?bGN1UkJTS1k0b3o4MUhsQ2laTUY5OFdJRTl5d3F2eXdKdm9kQXdBd1VUdUFR?=
 =?utf-8?Q?TlTt1LK8vWPOgZUWO8Uh3V/7Ogu4REAye74TCjCS0z4Ef?=
X-MS-Exchange-AntiSpam-MessageData-1: 2z2MD/9irrLGVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ed2bea-c76a-437d-05f6-08df364a3e9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:54:21.8135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKWxzNWMVaKJJzof9LkCCEBLXPRTNaRkxa2sPXtjHG7JcC+laF+2YQ5WkA8geFaKmFqQo6TNuf9ZHEJEV2WOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, October 26, 2026 2:58=E2=80=AFPM Karl Mehltretter wrote:
> tegra_bo_import() acquires the reference retained by a successfully
> imported object only after all attachment and mapping operations have
> completed. Its detach error path nevertheless calls dma_buf_put().
>=20
> drm_gem_prime_fd_to_handle() holds a temporary reference while invoking
> the import callback and drops it after the callback returns. Consequently=
,
> when mapping fails after a successful attachment, tegra_bo_import() drops
> that borrowed reference and the caller drops it again.
>=20
> With only the installed file descriptor and the temporary import
> reference present, these two puts reduce the file reference count to zero=
.
> This queues the dma-buf file for release while its descriptor remains
> installed, leaving the descriptor without a live reference for later use
> or close. On a Jetson Nano, forcing the mapping to fail after attachment
> produced:
>=20
>   VFS: Close: file count is 0 (f_op=3Ddma_buf_fops)
>   imbalanced put on file reference count
>=20
> Remove the unmatched dma_buf_put(). Successful imports continue to take
> their own reference before storing bo->dma_buf, and tegra_bo_free_object(=
)
> drops that reference when the imported object is destroyed.

Please edit and compact your LLM commit messages. All of this verbosity=20
and description of only tangentially related code just obscures the=20
actual issue.

>=20
> Fixes: f5b8794e17e4 ("drm/tegra: gem: Don't attach dma-bufs when not need=
ed")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Found while auditing Tegra PRIME-import error handling for
> CONFIG_DMABUF_DEBUG testing.
>=20
> Tested on a Jetson Nano (p3450-0000) with CONFIG_DMABUF_DEBUG=3Dy and a
> separate change that rejects zero-byte IOMMU mappings to exercise the
> post-attachment error path. Without this patch, the forced failure
> produced the diagnostics quoted above. With this patch, 100 consecutive
> failures returned -EINVAL, preserved the original dma-buf FD and left zer=
o
> dma-buf objects. No file-reference warnings or DMA-API errors occurred.
>=20
> Additional regression coverage passed 33 dma-buf heap selftests, with
> three vgem-only tests skipped, and all seven udmabuf selftests using a
> volatile 2 GiB HugeTLB pool.
>=20
>  drivers/gpu/drm/tegra/gem.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index f76af73..ed35a34 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -502,7 +502,6 @@ detach:
>  		dma_buf_unmap_attachment_unlocked(attach, bo->sgt, DMA_TO_DEVICE);
> =20
>  	dma_buf_detach(buf, attach);
> -	dma_buf_put(buf);
>  free:
>  	drm_gem_object_release(&bo->gem);
>  	kfree(bo);
>=20
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> --=20
> 2.39.5 (Apple Git-154)
>=20
>=20




