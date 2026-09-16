Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94516C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D172910E56C;
	Wed, 16 Sep 2026 13:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPrgFdfQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C385F10E56C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4usrxmHwtLMCHv9SnKXuFjgksBgbxjTivaLj7BnP+uYyff6Mn10qZmXL9SOL5maidwFmLTnd0oZ6cTU3prKx4d17JeWDUsEAJDH21yiVdgkDRgmXy4lLy2bhH9LRxdvDiOtMF0adZ+f/ARzzq0N7e2ZC6fn+Sdk1ontUV+3zvG9PlEB3CDMV4YQWDrvPFRLc5oR3B5OW+naWqthqFflO9MLgSY2wEfnu+gnp5AdQ461u2PI9xFbIwGGmwY0UgWZwarCvQ26tKq99NjaNSwe7Dko8tSJWZJsF69PUipP5MhbITnnaUPM8fY/buhVV17wpsfBuHARoTbSllum2c/GCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo8S/l8JJzBQNMO/i75lVdt/pq9IEWuVKGTUb8oHPVc=;
 b=WAcmicr1kKsR8206TAKVWLU35rzA3IvtYB0oaE33x0lHa9DqaVxDVyvKetK1mQW6dcMPH23lZQ3kj5jTGLgFMmCLPPyZ1Em9M/tuzEUjY3vX3e4DrT9K2/1AubJJTsZ7WBialPx79pksWt8B6lIBYY9ZrzhzXR8f3Y9Oykf5dEaM9SlXhR2CeEc8Qr/XIV+uPhVa7BTcggR/NNiP6owFSQAr7yB16IeQyfS0c6foyR3bqP2HkVEIWGRlOdvXDXsjfwTyFYGbohnshYjLoIVYxoKObxlb1EyyQa/u5+RaR6gV7rj0Vx+brjIk+aa53gFwuagPw9dPMeqQFFINoAnJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo8S/l8JJzBQNMO/i75lVdt/pq9IEWuVKGTUb8oHPVc=;
 b=WPrgFdfQawn9/diq1ac8xFIlY2ZSLhHqlz/37PgkNOVq54g984oFXl6yUQ7NkXu7vMXCfmTNvpB2kxmaanc9gcW6h9ykmbYUdiynBBWGCRCQpVh1o99SU7jYZHayRXsbBq8Bj6/ac6wEU/pVSK3zmU7AjJEcLpNUpuhb9j6rhuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:30:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 13:30:11 +0000
Message-ID: <a51b4181-f102-4820-b5c1-af9cb3d9b77f@amd.com>
Date: Wed, 16 Sep 2026 15:30:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: DMA BUFFER SHARING FRAMEWORK: tighten F:
 matches
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260916-maint-dma-buf-v1-1-0f8d6c5bf1cd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260916-maint-dma-buf-v1-1-0f8d6c5bf1cd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: a06b9ff9-6f05-470e-6cb8-08df13f6a261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PxIevyZJUKiDbfcoglak9mxEd8KNg8dLfuwQ6z+jmWLyZ3PJ/6VYMkouxmpq2CDB9x2pH4NdpURoicbZ6Z8J9xnsJUFoIcmZRYFVbpmZNRA/0J2AKEvUieBOt3a/l6ypj6Y0t5yTSZnY6Tovrjg7e6qWm3OGv9YeO67Z+aml+C7qc09V+SlJJw9vqQIc3lHqiNv4dLixbwFsf8fyF4rVk033QhsBmqQr6xMljzjIP6R4Vrte7SbAKbRJ4burfz6V49jsftCLw2QKKEQGzjWygzTMRHJydSuFMLbVQX6UVabbLhoZZfQqXJNvx/EECSCAiShoJIi1C2cGcL0pJSpE/6TlCxbwy+GgICisN/uCE1t7G3ABJJuamYLD7g0qhJpfi8oiNhJHE8NF+BXdxWe5oZPF38c9lq4RGdceG0RoeH8/DnyYTwLWHBNf5g6MZasCd1PDeA18L6qQsfDifDr+mfFcb4wpL99/Lt8Ty+50Isi/gly2/n0HVH++nDWGtLaNYfAewyis62kt6/CKUWdkTR87G2FTGqa/uFKWrr4gHrRbL88mzqZ1dGfIfNQXgioBiGi6RohyPZ8NcVzXD3qTy25vNcpc6l6L+BsaX9BHz8Rm5/vjzsP9fKeBLdNFwY73
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2o1T3pUNkR2M1Z4eW1XODJRakdick1CclRqbU9INFlHam8zMDcvK3ZSNitn?=
 =?utf-8?B?MDZVbkNmMjRFSk5JR3VHNHpMb0pqRTlVWm5QZ3VQdkZRdndLeGNCRTFxUmRE?=
 =?utf-8?B?SDgzYzZPeGhlL1U4MTFmdFBUSVdxSGxJd1F0RVlZZnJibXBrYmJueGkzdE5O?=
 =?utf-8?B?UWQ5RHdSR2R4L2Jpa1hXbW0xSGRJR3BUcWJ3dmtsZDFXTnVFQlpnbWRDVDl5?=
 =?utf-8?B?RXRPY2w1VFZZTCtLR3BjcE5KeG81VDJ0cS9QbHJNcGV0NEpsSkdFOSs4WERz?=
 =?utf-8?B?c3phNVZ3M1IxV1FudVpyTk1EV0k4anJJQ0I5TG1GZ1paQXo0Z1RVUnhqODVq?=
 =?utf-8?B?SktqYUVkZ283QTlhNlNyWFJ5STBxSkdEUEFNMVBsUWYvZzl1a202eXBwelNV?=
 =?utf-8?B?ait0cmU5RURUS0Q0NzVjd01aazJ5OG9mVzB6bnM4Ny81U3IrU1hsZWNyQ0Jm?=
 =?utf-8?B?YXVqT0lwTDdIODFGNkxqT2FlSDhMZUZKN0RKSjQ5WUJaL1dSTndwQUdMRU5D?=
 =?utf-8?B?cHpKTXAyUDJ6OHZMOFptYmcxNkx5MVE5RzhjbDdFWFYxSHkxeG1PckhST3Jt?=
 =?utf-8?B?UHZSYWM2TUhLNTFCUVBEMmMxR3J0QVpsZXc1ZEJiNmZ2eitWb3F4Q2Q1U0tB?=
 =?utf-8?B?c3Ixb3FuR1h2WXU1MW1vMEtvSkcwUEp6Q2UzMXVzQ0NiSkRyMFBIU1hGellv?=
 =?utf-8?B?U1o1cG4yeVlPTEJRYU1icDRtTENPYlEwZDNCQ1JWN01ubXNiQVpnQXl0YzMw?=
 =?utf-8?B?cTZaeko2VU5wckNsL1l5VitMY253K0dvdFBoNnY4Wk96K0dUSmV1U3Y5WGcr?=
 =?utf-8?B?ay96WjE2bDhadGNkZ2FYOVBlUmhod2pKR2NEMUlsUjVlQkthV0VNdjNnNWpj?=
 =?utf-8?B?U052Sjh4Wmo3K0IyeEswREhLaHdDZEVDT0tQamJDUVJKR0l6aFpYNzgvM0dY?=
 =?utf-8?B?MzMySDJTL0Z0bGxwUmZFcDg5ZGh3bVNBQmtRYll2eWY2UHU2VzE1Szh6S2Fv?=
 =?utf-8?B?RUdubTJQUVNCN1RDTFFCOFVhNVVvbTViTjVZUGR5Nmxtd3FBdDhMbzMvbDl1?=
 =?utf-8?B?REEzRlZBNWE1UUcyWmQ4UXRjQW1Cc0hSK2V5RnYvbENRUXEwR2NvR2hMdktp?=
 =?utf-8?B?ZFJEYklxMGl4cVBjZTNVUGN2WFcyREZSbUc2Nk5BYy9IK1FFZFRhQW1raDdR?=
 =?utf-8?B?b05keU5oaWdPUUFKRFMzQmlNc0lYMEhMWjk0aHh0NVVidGhDV2p3QVNFcnRG?=
 =?utf-8?B?S2NkS2FmQ0JtOTBJOTdpM0ZTY1Q1V2RqU2JEVDVRZTluaGRHU2NZUXhkc0hK?=
 =?utf-8?B?UURxMnV5T0RnZDc1ZjNhL1lnVEtBWjNCdDg5TlArbjhxTEx1K0JDa2FQSzVU?=
 =?utf-8?B?QnE2K0RoSHVlek1OYXlIYU9jQ0dycVgwa01aTzQvUGZtS2g3N0dtY0VUS2lL?=
 =?utf-8?B?Y1Awbk5IU1FXQnpRYk1XUWlLUWVaSGNWcjBOMFJDRFRzbm91V01PMXBrZDBa?=
 =?utf-8?B?UGhueE8zRFhuZGpNTVhQTXVpQ2hqWUFkNDBlamFld09IaGdjeWU0bytaZTFt?=
 =?utf-8?B?UFRydTUrSkpIT3ROOG1MS0hvUi9RZjdLdGlJaWIyU0VFOUxYTEIyZEs3VUVN?=
 =?utf-8?B?S3lYdVhvM2prOVhUNitTME9BZ1pjODFiREdJbEZYR2JGRzg4V2xuelIrNWt1?=
 =?utf-8?B?YStjMWxscXZDYW5RaVNDemxaZi8vOXJyL3pBL242ejBnUzJLWEQ4TXlMQS9H?=
 =?utf-8?B?MVh6NzUrK1A1TWxqd0h5VmxWY0VzWnZsZzV0N2FtWkRrSW5PRDNrZEU1RkhK?=
 =?utf-8?B?U0pjWThZKzBMcEs5QnM4R1N4aEE2NjJKVFprTUh5OFNmRm5uK0JvcGRQNzdW?=
 =?utf-8?B?bFNTTEhwNWJWbzE4Sk0wSkY2bFhYT3VMeENFbGt4MFI5dTNoeTZDWXoyRTBR?=
 =?utf-8?B?RXRaZGMxcFl5Q0NEOFltZ3ZUMTRNRlpoSE92TGRBdjFmSFhyLzFXNDhhYUtD?=
 =?utf-8?B?elpYbHJFSWlPeWFGMEJ5azRWdDY5aUZhV01FQ1dQcnM0emNmMk1KVEdvUFVh?=
 =?utf-8?B?TjhOQ1crdXRZRXh6K2d1cktSbDd6cHc5SkdsSGREODBqVzg5OUcrMndZdUt0?=
 =?utf-8?B?ckNxcURHMFF2azdieFRPaG5NU1hKOEtSNzR4b3c3Uzg3U3JxU3Zyc1UvSFVC?=
 =?utf-8?B?TzM5YUxUOGlaNys4LzdpN1BOSlVJRGd1NEZ6NSt3WWZ0ME1RMW1uZG5kbWxi?=
 =?utf-8?B?dWxYT3BGZWVIOTRYeU96ekNMby92MW5EOGk0ZGpsNVlJRW51dDVaSXFWWHc5?=
 =?utf-8?Q?7daODAhcHdXO7zuMY2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06b9ff9-6f05-470e-6cb8-08df13f6a261
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:30:11.8979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WT+pO/mzRrxugBiT0ysnI7MVivprNeg8U63WgG1CNn8XwRuTAb+p9WWMfklsxr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

On 9/16/26 15:21, Mike Rapoport (Microsoft) wrote:
> F:	include/linux/*fence.h
> 
> in "DMA BUFFER SHARING FRAMEWORK" entry matches include/linux/kfence.h
> although that header has nothing to do with dma-buf.
> 
> Replace it with explicit 'include/linux/dma-fence.h'.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

Thanks a lot that was on my TODO list for an eternity as well!

Regards,
Christian

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2414447892c2..656bc5ed8d2ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7688,7 +7688,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/driver-api/dma-buf.rst
>  F:	Documentation/userspace-api/dma-buf-alloc-exchange.rst
>  F:	drivers/dma-buf/
> -F:	include/linux/*fence.h
> +F:	include/linux/dma-fence.h
>  F:	include/linux/dma-buf.h
>  F:	include/linux/dma-buf/
>  F:	include/linux/dma-resv.h
> 
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260916-maint-dma-buf-3311abfdc90e
> 
> --
> Sincerely yours,
> Mike.
> 

