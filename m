Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D006FC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B44A10E183;
	Wed, 19 Aug 2026 20:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N037WFnM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A2710E183
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaVcbfEjTtagTRrExrc2LZSx0Na3+vsQNsnImFqEEOW+gAMy/b9zIATH6GQUvCsAlPYdFPy5fhMy0YrjJRX8fIQ3ufuHV6GeDgmn+OearrYBYIB5osJPfb0ZJZg3+wjzBx4xlL1uVe+7rvjOKnGnwxNAT0vM3WW+gGJ1k6QaualeypghRuAuuMwzZwPrznQvIXalmcOKPUASV9TWdw4tiGSFYxRVdHfHEiVyDOzqK9POjVxTGhZKlHVVApMUCwqbYejnUWS+q5mE5Vkba8H2pmCBlgVbE9WFRwGCYWwSusGGBZclPtBeOycG+CE9DOEeHwVM0qnu0Ph6R92HyNmY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DUKGdgpeDpfgABuWrm+KpdMbSelyHpd6WgUTqGlsiQ=;
 b=lwk28/XX5PfhqIeg3v+Pihwz+05JvYj0+VXNRLdX3ifZl3C2T8G/AZjYJ/Z1kjaZTdzoF16Qm1h5CHkhB62orpWo3nUqPxbKqChwDDRW9WJYSq/mewOk8qIiMbA7dLUiZbutiiH6M40m4XpdRZvrLnlh2sDeXS+PVvDFXGZKPVYIq9dTRJJggamjP4jJn3LXTkdHSjfY87xXuhDVPH/7k/9r7A1XcI9MhyStr0bKbvMpOeu4rd58UjKw0N+yYKIQ3t91mGceOgFzPyK/DI5whJe2M/rLzMqWAjvx2YudYOK99cu1a1svCuSPQ3x2c8scH2nKfxDEaDPO8Mkp9/kJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DUKGdgpeDpfgABuWrm+KpdMbSelyHpd6WgUTqGlsiQ=;
 b=N037WFnMur4gHHpHZM7pXmkX4MsGCYvf1QJYZo8ZpSFmH2H8XKexXhK8lCX8GJ+2v9t9kFH4VI+vjMs5HXDYv0khBiohrI6sOvAUP0MWa/mA2qviIogI7ZQOzKMPSH2ECXXOzdo81srGBGC+Zp3BNDE+/B5wNqJhaoQoOrTmKBA=
Received: from SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::6)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 20:57:42 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::a5) by SJ2P220CA0003.outlook.office365.com
 (2603:10b6:a03:5da::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 20:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 20:57:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 15:57:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 15:57:41 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 15:57:40 -0500
Message-ID: <4d9ab5fc-deb5-b0f2-66d8-68d74902e64c@amd.com>
Date: Wed, 19 Aug 2026 13:57:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/5] accel/amdxdna: do not warn when a sync request is
 rejected
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <alexdeucher@gmail.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
 <20260817230707.356828-4-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260817230707.356828-4-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: c794eecd-1ccd-4919-786d-08defe3482d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vINbudbfBQu7W1mGFk7ic8REAK23QlDVcogArw/BKa6yxJ0XRR0CreQKRwtcCtRmtd254A64kiga9AFGrTjRWEMlNSqLAa2cJjQRBzztAksVRDJt0x4ypdCioa1VUDeheJYzlF/kWedBIMF98x79bteO2/0qPgTTjMJ3TDtB/Vna74nla71Yry1DYe/ifbg7HFfgi0f0kO5PzHiv7guj7W+9CUBMKvbmX+Kk94vigJbFyqHkAZtCQ6pBQbS1nej2M6s0wYzLLoW3diCw25hEC60y4TdyBB9jvUxGeWRg8gVZHeaXT3gKRIK85cbEzQByQTIbhdtKZ4O47rROUnMvJQEyPdqvuoah9FLwfYdheKPhCxk2ytr9Y8FAfdR05gLQXfSub9ETtfzHO3bjBofTeLEE3xO9yACLg9o3t1XDEYOLm7y8tzo8KV1DDnBtXpHc3ROuCukQNodCkOtku4f4JukRRx86rjELL4YHJBDBhj+aLeaASK3AptZ12WXgE1ZA4UORemelRFdC9PMknzmXK/Ajtu6x6VKWSVJ7jorzT7H4smW2CHCaxlkjJcRv2mqOo1QZ6uU1pB0efAdvUFNVDi9uvSlGUyMal50sXSESNUQ1V4Z2eWyXiaw1GmpglW+BWJWAEsmfxAObbj3vCBm5M/R8cQgMNF0g0S+7qjFs1PJsPgIlRCraHibQUXKrsq2IGmTWC6+FpOoKWwd4QDLqng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ojlEaJrZkF8nJhj9nCzIw25Wx1EHTagLgFgWQk6U8gXj2fDRLpcO69H4IFLkCEUvh9xzz5cgJdODC3aAs9Njj/NgSCY4/u1gyCTqe7P8rPtIGmJ4qY1WJvHol3Jk7hYItAa9fwOKUoIbxHRK6fw7TIQt4oj5+Q6TByFXLEO8jRrujEtwFmg3iXyuDik0kTKRwswZP1075Vq2HapA0OY2jqbu3d8dBz0qEdVVTNe57ZlXnrzd2vcOCULSiNR7sc5PIDkpOi8sT2NyTcFvEQ72hqwhGSn4uTAKWgfBHcVcDKImGg7bcvkfi3iZgzMvwFYxU14RBu8yzoFTGIghQ7KhVgfA48kKvQbw1Zfu8dCbBBnpSx2Zu86oJ2qwZNI2ZdDguNYFAuZxnoGSldED3BoxmaXStRxlMTev7imwUSQMKvn4lmohbY45fv9AjcUD7ng7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:57:41.8372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c794eecd-1ccd-4919-786d-08defe3482d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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


On 8/17/26 16:07, Taimuraz Kaitmazov wrote:
> amdxdna_drm_sync_bo_ioctl() answers a failed amdxdna_flush_bo() with
> drm_WARN(). Both of that function's error returns are decided by the
> ioctl's arguments, so SYNC_BO with an offset past the end of the BO
> splats and taints the kernel from an unprivileged caller.
>
> Log it like the pin failure above it.
>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 77a9493cd7ba..4f38f985c74e 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1310,7 +1310,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   		amdxdna_gem_unpin(abo);
>   
>   		if (ret) {
> -			drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
> +			XDNA_ERR(xdna, "Flush BO %d failed, ret %d", args->handle, ret);

Should it be XDNA_DBG?


Lizhi

>   			goto put_obj;
>   		}
>   	}
