Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7691DC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FCA10EBF1;
	Tue, 18 Aug 2026 16:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XCEgQmoH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151B910EBF1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WucvZHZvcw/jnV5UG3y8OCfNZR9ZHJsm15XENZaeDcTjLakncOHXE9NGwJx7t2kKC+UHR9lmOJ5IlXM/1aEKnGDc7i7yyUpU1xOi6Ig9BVGv4d4f3+lk3og28mCWlw6wTFrWPi9+YyXdoZ2BRBhpliHgJRISJR4qEH8RRd3P7BTIdKharDIBvQf+AIyIVyotO1ftFgbzXQ0Zg/sNiHHR/yXe5aYIyDmmCClTQumL+IFlfPiM8LrdSqppSvhicWYxg4+BO7z/nWYYhnhxtl2nBTZJRTBOH1Tk7/EWGYsuq2Q2XGbi5QrxoXNMaBQL9Iy/gxR4CmpMaM4MfAwHWwU2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic1ouIkNJvMQthOESDRvgx33H4oDlUZKYjMbtIMammY=;
 b=mpxWgH/etL3vlXzpNvNesmzq0H7CJsMfXQK9XnIc8YxCGPVi4IN8q4MqGd2OnW+Cy0ouWxiJyZd5d5WALmsnjQh5VNlYB+e7+dzyE1CYuSVwzwLehYySdTyhYSxN8NGo94ItFyppHZxt4Tw6lGCmP9c097jN2HFn9GYCA5m6kjU3boaPoh2DWE7dlPqRmoM3cU8zs9gJjAdhPITBmRRjsI2viM/wPpbuRSU3LUCebuJUzOLDTlCVEunvWdf8RbavpXLsZ6X+cEoicUVU5h6bkp4i/awGJVc7ZtdG7idf7TnJ64exPSrlVkFljYwwnKuUyaw/AE0Kij9RYhbP2uxzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic1ouIkNJvMQthOESDRvgx33H4oDlUZKYjMbtIMammY=;
 b=XCEgQmoHJwdG/dJPkZlwmdVZPsZghMU6VL3MhprX/LoIRWasouOKUNUKkOhT8geFYmCUZWz7QwogBwyswgVtUCdlDoBZVt+ASSxreRZyXr/VdKKH35swE1q844Ws8LTGUjAMeT1HxSPQua0w1jwImeLUOxjeQTlcvg4OrhTxcYo=
Received: from BN9P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::14)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:23:48 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::4c) by BN9P220CA0009.outlook.office365.com
 (2603:10b6:408:13e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 16:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 16:23:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 11:23:43 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 11:23:43 -0500
Message-ID: <a6cc7a11-5ada-cfd6-07dd-df3cad271f5a@amd.com>
Date: Tue, 18 Aug 2026 09:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: return early from a zero-length flush
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260817230655.356785-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260817230655.356785-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0718aca2-7cdd-4c8e-77d8-08defd45128b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: cM6z29+mggAM+4lINDaNw3Nz9pSptAjRhSW9W9NIT8FEZf4kinNcIEqWs2x+7YsRkXlVW6hfNLwyNNpL19BMZy/b7+/+FNKX3XIbpj5Kty2O+udehMayMmGvCGFnmC0jOrtO1Lc/BMz/JbjIS9RfEAtuLXO3nZ4gpetmTJ68iCAK/4kMzpduIWUb/cAaMStIJ8UNBvt1d1vrYvOT8nbqYKukiAwpWl3zzU9lU67ZvIJNEUXnKgARZG/w9mMoB+dLLT7tMeY1GmGO8D6qY7XWLm33KxFwG1dmiLSQNb1UMFIF3x2iSm08e80s8vWp3E+6c+N0LNB7WkeveeVVeiZgc75TR8wXOR3AGPzkjsvU8+fa+LV6jq5uTMZGqhxTfTicQahHkCaE5fts6cBg48uCYYc2RwXjgPrfTgp8NYEmYB0BOo8gREL78IYQPVJi/cmFawBt8jRAhwS31mfbW4PhbSSnpyzFMJnigNX2sUsZ+BoBaA3fTiYtDdXAJJAsj9vGE0V3z+fMxnybSAcwUduHbDbNtCw/0McTzzNqAxyuHm2CYTcNaqvI9B1pNeDlE2HHixwWe4bC0XIwVujsslDgidNPSWJSCqUunIhNJvmeDF9cOJxattg9x0pM1+q8J5YA289YvDZHSGuXx0yQzkaZ5ElFmqJnt5ocg9++Z9/vK4cXLNuE+FqlsEC1aQpBXmJVoFSAmVKyqnNIa7+ugtRwGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hJ1kLWWgX1u5Ai3/5eXFv01s6zyBn+yOhIzNjnWAafja0xnQBoYf+vnpzDWTTX9i3rUArjN100COS8nUvHrGN4lAgqdf2bKRPYoxakWpIu8uui2s6wwyJ8/JzGSjY84WlMUP+GHTCdZO9UlVGcZR6hrIRFe+jmHiRw29E43McNo8LtHERyHJvpjgg2WOSgCAsyIXKM0nsFfsrNFLHj2aV1o/OR8OSw5yKi3g9/SbaCAYZg1kA3Xs9Ph7mPEdiyxWcgdkKXGyYYT8+KL6vX2y7eOvlbOPVqeQQCIKmiwDEyMSBGVhQpgswSR0QoVNkaPSpV7j188vLmBLKZyBm2DOplVe9BTu8+Zq8qBdVcHv4fg/A2FbjDb/hNMoNHwkroUA8Y5MA0v+WcL+ECjHFNVStPfxqT55MJXFlEI0miwyusfE5Rmhjcut1ntSgO6YzVAK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:23:43.8456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0718aca2-7cdd-4c8e-77d8-08defd45128b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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


On 8/17/26 16:06, Taimuraz Kaitmazov wrote:
> SYNC_BO does not constrain its size, so a request for zero bytes reaches
> drm_clflush_virt_range(), which ends with an unconditional
> clflushopt(end - 1). For an empty range that is the byte before the
> mapping, and abo->mem.kva comes from vmap(), so the access lands in the
> guard page below the vmalloc area and faults:
>
>    BUG: unable to handle page fault for address: ffffd16fbbc70fff
>    #PF: supervisor read access in kernel mode
>    Oops: Oops: 0000 [#1] SMP NOPTI
>    CPU: 7 UID: 1000 Comm: sync_bo_probe
>    RIP: 0010:drm_clflush_virt_range+0x3c/0x70
>    Call Trace:
>     amdxdna_drm_sync_bo_ioctl+0x124/0x430 [amdxdna]
>     drm_ioctl+0x301/0x4c0
>     __x64_sys_ioctl+0x115/0x2f0
>     do_syscall_64+0xa6/0x3d0
>
> Any process that can open the render node can do this. Reproduced 3 of 3
> times on a Strix Point NPU (1022:17f0), by calling SYNC_BO with size 0 on
> an AMDXDNA_BO_SHARE object. The import arm takes the same request but
> flushes the whole scatterlist, so it survives it.
>
> Nothing needs flushing for an empty range, so answer before choosing a
> path.
>
> Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
> Cc: stable@vger.kernel.org
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
> Trees before amdxdna_flush_bo() existed carry the same call inline in
> amdxdna_drm_sync_bo_ioctl(), with args->size passed to
> drm_clflush_virt_range() unclamped, so a backport wants the guard at that
> call site instead.
>
>   drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 1c63eff0a4a8..2a16de96e6a4 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1247,6 +1247,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
>   		return -EINVAL;
>   
>   	size = min(abo->mem.size, end) - offset;
> +	if (!size)
> +		return 0;
> +
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	if (is_import_bo(abo))
>   		drm_clflush_sg(abo->base.sgt);
>   	else if (amdxdna_gem_vmap(abo))
