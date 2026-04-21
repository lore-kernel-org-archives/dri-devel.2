Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E78F5A8DF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 04:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B73410E763;
	Tue, 21 Apr 2026 04:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIEeZpu8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8790510E6EA;
 Tue, 21 Apr 2026 04:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADNPmsJ3D6y8Zom56RFgb0zuadZQ5pBeWF4K3PLXO8ST6Y39RsD/2SdXxYeEm6KIaeLVRslQeMoi+nrrw/EqIor+e6S/MvssqXZXpZSPTiLa+l7XqbButJ95AULV0rG0zlApJDo3W55l8Yq9ksKZgLPgrfXNQS1H55vBTWBAY9NKOlwcmSm+jt331Biz4O+O8/7T6hvueONdiQLvIqhnx8ZGYqKwIvounBgAqK3ZwlNkgQRmNW9Zxzw5oXLmDLaX//HPRSJg9SevqKn/3nRStk3LzN+if+rgh9PDofcQt9feKnyjbxyAlOOSJsW6WOZeKgeJw0IinmZzS8f+qbRXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPWTdT4KtuTtHVukyHQdVWRzZmls5rOfCuG71RrhY4A=;
 b=wrOsRhGeAkQyDP1InDQKk7hTkxra2TWk7jk0C+vRlupF3T5Q7sCHyq9khW1z1moLv9b2N/AtuY0tDNFk7c3Ya/gv1lSkDTKUsKtK0MnS1dcDSw7lMA6kOVn2/P9TtKeCMj1NeppfOyj/VZdgbDM5APlFrgrSnx4zd9Tb9wKRJzWt99h8dk9yMSSL4PcmCburdj+OKQNPLV0eqy9aDcCT9y9oZo77+jEw+tvOVGGeUE6taDDq0cxYyAJyGg+totwMNEjoKMGCF07JbQdPqmUAnguaeIRfwdFf8MKrZnzvQ9iIa0aC9c4GH0zl+FWskVQneXGEQ9nL9JmrXTl19ewg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPWTdT4KtuTtHVukyHQdVWRzZmls5rOfCuG71RrhY4A=;
 b=lIEeZpu8jQSQ5rU78aHBdi3ldEB6KdZpsfi4HycFL94BJYpNbMsdb2Ozz1zt+Qhtr4wMOOZuKws+ai5Ie4Cdp9RisLRd/UQtN7iYL80jytWMtgbeuASwMnguGANmScOn6XcW/fBwJbaoBPVaX5lVyd2PiNSZ0DPLAXfCgVkodLuWnIGGcUFQWjSGFlc/P7IrQqxnurD5T6rdKFJSkd2DpKtDl7+d4qs7gXLlfKYQ/qWFgLaX5kcMbRSBn8hp1K3Zn2J8TyO47OototUEDnfO9m9wlHMUsslEwel188zMC/d+LKq/JCCqpVmXE8T8KWKR4iv9ZID6IfvMNGLwLUjRDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 04:03:52 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 04:03:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 21 Apr 2026 13:02:36 +0900
Subject: [PATCH 1/4] gpu: host1x: Fix iommu_map_sgtable() return value
 check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-iommu_map_sgtable-return-v1-1-fb484c07d2a1@nvidia.com>
References: <20260421-iommu_map_sgtable-return-v1-0-fb484c07d2a1@nvidia.com>
In-Reply-To: <20260421-iommu_map_sgtable-return-v1-0-fb484c07d2a1@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec29c1f-328c-467b-9220-08de9f5affae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SLUMDSOzRTZ2YIkYaGq5Ho6zhdxLgZWj4xgR+dipKPP4Y042juMz/bPzrNAz/VDR4NIONu/mcfVftRTiiR4p/AvoZQPlSBTHBS65F/ToW6AUULd5hWYfbaoP4fXpELpSIuZN66UH3EtfWQPjACwjKo4TR0h2WMVXjnYY8IO0STMW/l9ayPKRhZrgOp6Q7H7iIfTTNVq7SS0q1QNBob6SME0IqMRFZRRmYnqsf2Lfl4PLDftnTMYLEkyYJBN++KLPU+C3yOSayswwn5G7HeU3amhsKF9KyZZbggs7m07Btgb+Lz4lI6J4y891JrL1trHuO94TVR0NH47xP3EyOU2WyfZ3iGCs02KxkqY3bHd4ditAVlj5XO+cI6nWdrBRlX15kxeQvyLFryabgrtZ8OowXv1qBX326rM+cZ8ahOVTGhLrzYryXokAcepfnQcK17EoZsSqYjafCTMCIAc+6haMczhwMh1Uy/sWR2ZMvTq4Ub4xfAGy68r/WP1/hmI1xRb68fFwwLwYGZjK3vxS1WV14bit8MFzUNwGCxKyDMXwD67himZI70+m5GrjnPT3l/2cP8jQZbBf48+8Bz6KDuY9VUSOdif9STcLiTkG9PUiegm5TmX7fvRc+V39AZa8+y0YZsYDhXYnv2Rwx4e0VEYyC8L5hSsxf5C/V4dwcW6MYnjULUu0LWU9qRejnSSbXvoiwuouHX3wIHoPW2e6l3jxCTIzB3cHKX3YtX0FQ2hbiV0xWdz7YUyv6FVds7ExEpPB7RFsp36hUJ7ybazMi0MNAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05LaExybkJIR2lzRmZwMlNOTTlQd3lzbVJuSjluWXdzYUhpWXA0aW9ROWR0?=
 =?utf-8?B?ZGRHMUg0c3hxelc4UE5PUnlLREtKT3BlVFNjU21wYU4yMFkrTnd6MDRhNkF3?=
 =?utf-8?B?VHFabG13Yk15ZlFlUXB5dkZlYUdjbWpBM09pRzNGM0FpRGtlcTg4LzVaRUh4?=
 =?utf-8?B?bk5ReHJsUHhTcDE3ZzNKc0VBZzR3VU84YnZTT0t6M0p3UnB3RE9VanY2Z29B?=
 =?utf-8?B?SHc5SFJXMTh5azI5ZlZaTDRMbDczL3JWUFFWMFMxcS84NjdpU0ZXM3dWemkw?=
 =?utf-8?B?ZTNNK3dNdmN4b3pqRko5VXNzT0pYNCtmUkMwRXdwMlM2Rk5SZ1BGNitiN29q?=
 =?utf-8?B?SFd6ZXpvOXIzOEFab1ZFZVh0OEp1NkdYOFFQcVY4S2twTEpOZE50aWNFb0tz?=
 =?utf-8?B?Wnp5RWRtcnR6cHlCSkYvYVo4cG9ITnVGa1VFK1JsMHg0bDJmTm9kcTN5TFND?=
 =?utf-8?B?WWtMdjlwL2lnT3BOT2p0Y1ZWNjZsVkFpanVpS29YMVg4RVZXY3hCT1ZQN0hm?=
 =?utf-8?B?ZGd5aE9NamZwQ0VjdGZuK0VyUzBxbjJnbVk4MWZTK3R5ZERlZGJCamxQMEo3?=
 =?utf-8?B?b2N6cDNsN3lIK09WS2E1a2ZGeXFrNDJkVS9DMXZURmM0NkVBcU9oSjdtUmNk?=
 =?utf-8?B?QURoR1RiWlBoRm1OTG9VL2dvOC9BY2pZdVdXdkh2WldjVnhCUkhWL3p3UG1K?=
 =?utf-8?B?dlZGa2J4clFsZDVmZXpCb3ZIdHFJWUJLL0JCRjNpMWNQeWV0c1hJRURWdXA0?=
 =?utf-8?B?VmRDeUZKSFNLeUdiaTRScldQUFkzODFuVVcwRjBDSUhkWkR1eTV3VkdWdVFB?=
 =?utf-8?B?Z2w0MnhVUE9SdXhYOFEyTXYvNFp0aU1vRUFWMlZUenp0Y1cvOWVNTW91RlFO?=
 =?utf-8?B?eGtEMVNLcFVhYzZHYVhCYWJjNkdXQjhRR0NxaTRXZFhxMTZVT2xWS3ZzeUxQ?=
 =?utf-8?B?UjUxMDljVHBUUWtiM2UwcGlHbmlFbVExd2VVdDZGZ3p6SHozTFBkODlPL3hG?=
 =?utf-8?B?MVZoZnQvWk1QMjAxNndFbE9Ca0cwbDNpaWI1alBEQks0VUsrS1c0VVo0STJI?=
 =?utf-8?B?VUxXRVRudHYySDlEYzRFZVpsOW5zeTV4ZXBUVVVHVDZxTXR0SzJIUHR4N2JZ?=
 =?utf-8?B?bjN6UE8yLzI0QUkwbmxDcCtTRUxzS01BQVM0NkNPZzFjd3VCcm9aU3RXbzg2?=
 =?utf-8?B?MXAxSUsycU1IMXBjODZBdVNMY1FJM0tIZFExVWtlODhpREFEb0FuZk40bi9E?=
 =?utf-8?B?Sjc0WTdNRmtnS0xyOFJvWk1XNlpJSnFLbkFpU3IydzFYZUVCejYyK2FUeU9s?=
 =?utf-8?B?NnV5S2N0Q0k1ZGtWdm1KSDlLMDJjMGE2elh1R1hXL280Ry9aaUZ6eTRwWWpy?=
 =?utf-8?B?R0ZqeXF3eTBhYU9TMTdBM01sQVB0M0dGaWNvd0xlbzl0OEJ1YUMwS3RwejFN?=
 =?utf-8?B?YU1BK0dYNkw2Z3hPU3RCNGdRS3NLbDVXbVlxclFkd3V3eWVoSmo4eUVCMWY5?=
 =?utf-8?B?TEZ4M2xhQTYvSWhjbWZJc3lqVW5kVTRMMDVHQzZZNGw1UWxnZ2graVZsOTlS?=
 =?utf-8?B?ZjUya3ZiU3VFMyszREwzZFo5R204TjdkbVB1eUlWZW1Cd1R4SWROMzBobTF1?=
 =?utf-8?B?ZWVMdGVNdmg4NGUzWFFhNmhPQ0o4UWdDczlyUmdNN21INTRFOWxTLzF6VHBX?=
 =?utf-8?B?dVBXczFzak02ZUNOY2Y4cXZ0aTFFazAxOW95eHBEWklDK1NGK1NzUDZoRUZN?=
 =?utf-8?B?aElFU2pVd1NkaWNVVWQwaEdPMVl6d09WbWs4enNaSERXbnU5d2J2bWZlOExi?=
 =?utf-8?B?QVZvQWtlZmo5S2tKOE5hVHBZYjBoZ2RUVXd0UmFJRUNCZzgwcGNSQ3RUdXBH?=
 =?utf-8?B?dlRsQkFwc3JEd3pKbTB4TW8zZHdEZlZ0cW9aRjVJazhQS3NQa0pIazFyNStL?=
 =?utf-8?B?cndxdzVBYUtTd3U1TE92dTNSTjB1REhqbWE5OHFieUZzNnQ1bVRtL2ptS0Fr?=
 =?utf-8?B?czY3bnlmTmJXb0NwdkxHUHV1RjhWdS9ua3dJa2wxLzU0Qm9DUWx1L2MrNUFF?=
 =?utf-8?B?NmhHOXFEdWlwQ29mUDVYdmZVL09iUldrNUJKMThzN0VMN3N3RG9kVXpHZUcr?=
 =?utf-8?B?REV3RDNvcFdLYnN1blhGdEJ4UzcrQnpQNnF3cnF0ZVc3VnZna1BlS3NyRDF4?=
 =?utf-8?B?YTZMbVRzVkRqSEYzREJicDlTMUFzMnEvT0s3OVQ0R0ZwYSsxdjFWdloyUEIz?=
 =?utf-8?B?NnB6RXlRQzlvcCt0MWwrYXZDT0lPNXZTMEFVb3NGaVV2YUtJalVkaTR3YTVo?=
 =?utf-8?B?Qk1nR3JFN1ZSNDdMeE9CaUQrQ0txSVcxYVdIVzQvNE9jMjRDRTY4bmVYd0Zj?=
 =?utf-8?Q?NCyYtmYXJ9IGOgSTmX4MQFrSgKxp1qPZQp4rXX5eA4vmp?=
X-MS-Exchange-AntiSpam-MessageData-1: k0iXgAtCnrDB/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec29c1f-328c-467b-9220-08de9f5affae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 04:03:51.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdUX274CUIGFL1h4g4ERd2h9ZNxrf9JY/0FzqjxdHM9sgVMm13X1t90/Rpxb9yE0HJA8IKIPReeonBB4MhtHVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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

Commit "iommu: return full error code from iommu_map_sg[_atomic]()"
changed iommu_map_sgtable() to return an ssize_t and negative values
in error cases, rather than a size_t and a zero.

pin_job() also was incorrectly assigning to 'int', which could cause
overflows into negative values.

Update pin_job() to correctly check for errors from iommu_map_sgtable.

Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/job.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 3ed49e1fd933..70bda32f1ff4 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -235,6 +235,8 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (host->domain) {
+			ssize_t map_err;
+
 			for_each_sgtable_sg(map->sgt, sg, j)
 				gather_size += sg->length;
 
@@ -248,11 +250,11 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto put;
 			}
 
-			err = iommu_map_sgtable(host->domain, iova_dma_addr(&host->iova, alloc),
-						map->sgt, IOMMU_READ);
-			if (err == 0) {
+			map_err = iommu_map_sgtable(host->domain, iova_dma_addr(&host->iova, alloc),
+						    map->sgt, IOMMU_READ);
+			if (map_err < 0) {
 				__free_iova(&host->iova, alloc);
-				err = -EINVAL;
+				err = map_err;
 				goto put;
 			}
 

-- 
2.53.0

