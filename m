Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05634C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D8010E100;
	Thu, 30 Jul 2026 04:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILjI68fe";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D48A10E100
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA9KmGSu1wxHpaXwoX58y5PlJXx+qrbHFwwjz1w0mbaSo5iH9L2JzokApIVXP/zOR4xUx6J59ca8foRELKA6K++3ImE4nWcv41GQiG6ap0h9Un4wdo4y/eybaXjvsS7Ye7Y4t3UP3dq/9FrI6iB5MAHFap3dqYoWtj865ByqChVmPsqkAlqbBWnhCuGYwiZpfdqveqGDrEelbhCdfXBLJ8bF+FPqxMqw4xX2oaqvvd3n3tddVMrTeq8opqnJ6agCmohtyBQxqt8ZHI7t+MlrBDPWN39+HjQ2hq1/1LW1TYDrqRLdVpRkXXWlwXWHb77M8KAjLTQb1jW/PB62hDmqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH04tDS8xNC8N9L9Ynonmzp9QL4myKoZjhMQlBnNl9g=;
 b=IQFCjx6IVdVNcjHZb0XtHk33siQD2wFhtQPL1SMbTgBBJEDvz4yXAoB+jUH+pHWJP1VDcuepDHciRwYK4K+nYWI04mMOM0+STwY4RBIgKJ5VQT7m/UV5M1m/ZlIHPsKABwJFtYDc7Ma3cQzsLFMb6XRSJwA2vHp/vEiyrAPX2yfAdQD+pPN0W0xkvYQRy4xdIB6reZhWMebZKh9zE0HDzO/J0NkVd+dNNarnSB74kVYMggDKgmIRY2Qkr8nD9C7WzhyD9bYsrdTvzPR5/JREC4AR/rE6Lubj38NBLj+5hvbtBYmEOW/1svHA4uBMfmOGlSrgPNXJXwCJBmJjrkuFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH04tDS8xNC8N9L9Ynonmzp9QL4myKoZjhMQlBnNl9g=;
 b=ILjI68feUFygTF5O4VN05qW9//xgHzDIzMSip0BL9837me+D7oLhkWPrmnSAhbX8dXZ0r54mp1lZYe22DN574mJTr3oLDCt2fN+oI8WSHqDX52kOKZI/hpB1JGGh9onILzVmT5FGl8YDlGLrdlHbJBtJAtGpEBKdPKZdnhK4nySIXq3pZ6qFkVGD2vERjduR3e3JlqU7PWxn+V0WHIoaG3f8bAYPbu9I0Dsba7OeNDvgUHc98o6CbaA95WvrqKGtgKP0ewEvdE00PkDMxWA2CzoqcnrC2fI1vJV0mo+8PRQIwxrs+aY/+Ewbl5oeL/niQq7emWasL8IMBGF2++7s0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:41 +0900
Subject: [PATCH 1/6] drm/tegra: Fix syncobj_in wait return value check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-1-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linux-media@vger.kernel.org>, 
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linaro-mm-sig@lists.linaro.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eeb5596-99a2-4e95-c9c6-08deedf57596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 8lK5EqkgrJnWEkt0UTn+XOvONHbyEeF6Hmf9bvPI8sWd2BGALP/6uEFGQ/yZBDFpn3SoYLO7JmwWRbogvKX4jebAmMtsOzo+mjTncfTtnyAo4Eb99JZ9iW9qTqr8UyZbS8AO9l/W8X3IDTAP0Fla4WikfgJJ2QZTPdF4OdmstyAWoU2pQ5J0AS4NxSCjRJAMz6k7J5twj4cpr7Fpyj/esYedQ7RyD+WoJVHuA6FP3xUh8sClYXh2diOBA42PK4zcOoNCXAPLpEqDb/5jZrIJY08ZirGSgzbWEkiQgFa8Dm+QkBtUTyZDBRpE3j3pJoocvVmWlcx4zWNZHNzpMOQmCvt6ALKfccHNNW4XtXkfpvxbcZoq64gbHZwUTkegk+iLXgYdiIqNW+qFl65dMoYckuroYl+gk4wUZxX/AXS+VEuy96USGIXZjtj2DEjH13U+u9bTkj69v4Hia3d08utTtXmZUhfn6AYCt/tBGIbYjB6BE/4EhTL1wlZ1540VUgZtgbi7gyKZO9Ptc5QJNQ+Pi2FKdB3wS4Dp01D6hU7ZAOzP7FuCbf6uHkb3PtseuhcyqQL92JAvm56MzpDaOdCR8pwpUPPUhXfxsupb7VAeno4y8MW7Q8DQTWj4SuHENrZNnEoOGX5v6FD3ayc3Hgc6nA7C+/moRZFSNcG4ELOQumU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBMZ3ZIQ2JKWTR2blNWaEFUNnV3T0dJM25nNlRpdDJWeDhGK3REU1pYYWRl?=
 =?utf-8?B?VmRrRWJMdER3ZUxZamR0WjZJU2dOemRxeU50WTRzZjcxRjEvNnVxUU05OGJ5?=
 =?utf-8?B?TU1odDl4S2RmVjA3L1gwZUdqTmFDb1FITEVwOW1kOXBzc0c3ZjJaRTE4QjJT?=
 =?utf-8?B?OW5tZDlXL0FybFRId2FDSHh6WEphQjJiZHNhQVFGZlVjZlByTDduQjdOWnJl?=
 =?utf-8?B?MS9SNi9vRzZyQUVEOElTUVV6M0VOUzI0MFM0b3h3V2k4YnRRVkxUbTdPc1Z6?=
 =?utf-8?B?bldaSTRoYlRRd3kzR3NJazlTZHUxM3dTM3VRSEVNUUQ5d3NoUUh3ZDRQRlp1?=
 =?utf-8?B?UlUxdHhXZ0ErN0FsYUtZbEZYQ2xWUzJDQ21oOCtNSEIvTyszeHFnL1dUZVpo?=
 =?utf-8?B?ZnNnWVB5WUpWQWdVRndPMVUvaTZHbmk5ZElWeGZrSDA1VEtrY3VIdkxGeWdB?=
 =?utf-8?B?VCtvQ3Voc1lYeFlhamI2WE5QR0EveEFRaTMrS0pBVlVxV2tHS2dWMDU0YU1u?=
 =?utf-8?B?ZFhQeDZrRzVyU1FSUE15eStvUy9mT3RqM3UxMkwvbjBVTWlCaHByMURFS1dG?=
 =?utf-8?B?d1FzU09qRW9OS1UyQ1ZvWWlpL0ZlWmdSdmthQkhFdGpONVAyazVHek9lVGF1?=
 =?utf-8?B?dmJyQTRqVitMNUVESVNqdzI3RDRxVGhkZFR5VVR2ZG03TzFRR2NvMzJTNG12?=
 =?utf-8?B?RzZmZlR1VkFpN0J0MjNQeVNvNFVoSGVpMFN0VExtN2dXQzNDb3hNeU1jSXhS?=
 =?utf-8?B?Y3M0aWVzYWlRS3ljZFoyVjR2RlQzdkxhdnlCRlJNUGhiSmgxVnhLeGxMZFkx?=
 =?utf-8?B?YVM2UDF5L2xhRDVsVC96V3o3Z21SZXVxc1BaK3J5TWt3TXJwN1o0T3VzaFd3?=
 =?utf-8?B?L29qZ2h3bmJTY2VEQkM1amZJdHA5Q1FWWFpyYit2TS95Znp0d0MwRzFZRFRj?=
 =?utf-8?B?V2NrdlNRVWs5KzZlWHB2azlDUjRaTzFISWtTNmY4dy9rNlZWeW5FZHhacFEz?=
 =?utf-8?B?ajd4ZUUyOUlIU09ldVlmUmRUdEo2WGo3bEJRWVJXWkxLZFM2U1A0YzNJYWxn?=
 =?utf-8?B?bS9qZGNOR2x5NStuNGxZa1dkZXZIQjI4ZHErY0JiTk9FdTFYTXRLNlJNaElT?=
 =?utf-8?B?TElqYld4V3F1Tll2cnFZQmw1ZVlibkxjTm1VTlZ3bENndTd5MmsySzh2czF3?=
 =?utf-8?B?TXprRGU1Wm9LOHFJbjFaaEpkbjNDVGFBU0VNLzNqQTE0MDZWV1VaY2xISkFh?=
 =?utf-8?B?aUhRaENBajVpTkljUXl0RU1UdmNYd3RxandMcmdudDlMdHJkNzNkUFJ5ZGhL?=
 =?utf-8?B?L3RWRDdJYU9neFdHK05wLy93T1Z5YVd1amZ1MklBdXFQS1UwSWt2NzluQlRj?=
 =?utf-8?B?V05pdENVRWdNb29WQm55WEZ5QkMwZnVFSGc1d3V0ejgybUhKK1RwYXg0aktY?=
 =?utf-8?B?OTVmRU5FbUZQNFFqNVRha0hEMUFHeXFOSkhzcEMzQkFsdmwvQ1lpYUxSc2hv?=
 =?utf-8?B?a21hVThReW1LV1RYV0tTMUVla2JnTndzOGNwSHJLbG5RZTk1SU0rWFRBQ1Br?=
 =?utf-8?B?cFFMOUdhS3EvNXZSWlEwT285RUdyVnNHbXRZZG5qaGRaNlErWjk2MGxPWlIw?=
 =?utf-8?B?K1IwUk5jVmdrd0RucGRqNGo2WEhxb2gyb1FGTHMvYy9iZ2FlNGxGYnArZ0tm?=
 =?utf-8?B?T3d1ZFJyVWdJT2QxOThsK25jVG1CVENDRDFRQnRXamh2RWY2V0V0T3p4TkVk?=
 =?utf-8?B?SE94cmhZS2h4VzRrTXZxM3ZaSVdXR05JOHhzc055TGJ6ZEdpMUUzb1VhK0Mw?=
 =?utf-8?B?T0VjQ1VLU20yZld1dEwvdmtFYy9qSkJFckZrcmNxcjZKTVlrTFhBQ2pHMW5t?=
 =?utf-8?B?S0YxZHpTMUFBcm1mQVhyajNTOVIzMTliWHE0d1FYZjJ4TmUwOUJjTVhjb0p2?=
 =?utf-8?B?MHhrYTlIaXJsc1ZwMzNHQW13R2dzQllRcjNYSWRsbVJwMGZONVdaL3VUSE9r?=
 =?utf-8?B?VktmdlpIbllUUW5HMzdqT2JQbDRzSDVBdkVsOFdrUWZKRGNucWhDV3JqRkhC?=
 =?utf-8?B?NW5xTDVob2lPTUxVMVZoUGVRMm9BaUkzMGtGbk1wZ3J4Uy96R1ZCQnpBTSsr?=
 =?utf-8?B?dlMzTDZmc0RCSXlNZkt5blhVVmUzZFQzVWtUNmtsakRlUmpQcmJrU3ZyRHV4?=
 =?utf-8?B?Q2NMZExBUmhWcllRN1YyNVJJTTFlSnE0T2Flemsrc3Z0MGxxd0RtMmdYQm5o?=
 =?utf-8?B?SjZhOXBkejNZdUs4bG9kY0czdGE4UGQzd3h5bjVrbklZeUNwV1duWjRsL0g0?=
 =?utf-8?B?cy9rd0o2N3pUNDNiVkNua0Zhb3Z1clI4V1Nwd0pWUFRHOThZLzFvYzY2MkZ5?=
 =?utf-8?Q?0uowYJHwGtLkHi4bDfwRYec3X00gX+mpLWxrEnCDvTbqC?=
X-MS-Exchange-AntiSpam-MessageData-1: kwIz1YRzRBBScg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeb5596-99a2-4e95-c9c6-08deedf57596
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:02.9796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC8Bnoz90Pp4mAmObv69Go4OSgpxfu6bU7PB97kBEQGo6ZQh2vP+GzhCWVN7y+gxg5rww4RuOyOmjXjl6zICug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

dma_fence_wait_timeout() returns the remaining timeout in jiffies on
success, zero on timeout, and a negative error code if interrupted. The
return value was assigned to 'err' and checked as if it were an errno,
the opposite of the correct logic.

Fix the code to use a properly typed variable and check each condition
correctly.

Fixes: 13abe0bb15ce ("drm/tegra: Implement job submission part of new UAPI")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aJM_te551jUwnRv7@stanley.mountain/
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index e5841857c937..5dad6dc4eb8c 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -530,6 +530,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 
 	if (args->syncobj_in) {
 		struct dma_fence *fence;
+		long wait_err;
 
 		err = drm_syncobj_find_fence(file, args->syncobj_in, 0, 0, &fence);
 		if (err) {
@@ -537,10 +538,15 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 			goto unlock;
 		}
 
-		err = dma_fence_wait_timeout(fence, true, msecs_to_jiffies(10000));
+		wait_err = dma_fence_wait_timeout(fence, true, msecs_to_jiffies(10000));
 		dma_fence_put(fence);
-		if (err) {
+		if (wait_err == 0) {
 			SUBMIT_ERR(context, "wait for syncobj_in timed out");
+			err = -ETIMEDOUT;
+			goto unlock;
+		} else if (wait_err < 0) {
+			/* In practice, -ERESTARTSYS */
+			err = wait_err;
 			goto unlock;
 		}
 	}

-- 
2.53.0

