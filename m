Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7834CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208C610E179;
	Tue,  9 Jun 2026 08:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLuTlrby";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D926210E179
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1t93QtrrfcLPm27Y/pqWjQJldJIOCoDfbJAvIzEmEyee3WldCrZoXgZv/F3WNIGfZhyYmEvfkw3oLzw261SmltpPY3OKRzyl8cu+DzcVvVhKfOfxpVsK1tDUyJxFQdUoIpw+a9QttGOtg7TjvyKSw+EnTHfv6x9I2GPzakWIswW6XFt8A+hv2EZu8kGSIAOfr2nHejeMAFPKczkV4oMdAO59KqjIX9RYrwuXIR9/OmdT4LbzqXyXqxdrVhyF7zXOeXEsMaKsvYNVD1mXFHJ0rVG9T/StIzY5fBbImQi+6CgVY41V9k4Pic5PYjXfMTcvLG/jWbQ7G1smue7ct6K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRUP1eX2dq7vyYc6OvQwYRLFBKGI8W8WBTYbDg5RP4Q=;
 b=MdE6V91FrnhB5/sGKkWx63JHXJNxvcy0gUP148ThXnlBOtM53G4Rr+aAMz9QvfCD2vqXUMxUrLKjIQTPNlDtaXowIdCgHeNv9mCLlSwf2XmbMeRA+in5dh3qsq5I1011C0hX3yMjUkkyC75QEbHbPOwe6XugGyQWeOhtxpcaI5fdcLquAqyEqAvI8m4STAJiZ2QMLMOhVefXSLXY3HNqiff6WercFhqRHNowTMWFeD/MknnHSOyRG1xHU+NaNXY042YdVC5JOmiasaNIjrZfsHgomyB1XHQaYBhjtAO51UC76bNc1oYcorY2ETdjmbdqsF2cX3Jfhah6fPpYp5Thmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRUP1eX2dq7vyYc6OvQwYRLFBKGI8W8WBTYbDg5RP4Q=;
 b=dLuTlrby/S0qAUEFZrdMcX78coyPXT18M136TCQDXK38SdtiR9zV05WqReYXcZK+HN3fwgQUCVwCPxtauuJqZnrKQtu4NEFeDNmUx0VPGeho/RU6aQIse7wmJmdJMmGUcZSD7WHqOrLVVCdX4s4OyxdxEhRedIZCBmxGoh9beJPLxCARVQ5yM01z+KuxSQW8jXjobzPe1P2UODrmv092vUaPjE+0tzyKVy+e1wDTtX5nkw/uPRwlTZxnx1oHDPmiMjXo0YXRa6yrItfKOqZ3uKnCTaPKtlSMtxNfA8M+E4KRI0bb70KsTnHY7UNhKAfEG/+9l5WQ0/xgk0zYaFo+2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:07 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:17 +0900
Subject: [PATCH 1/6] gpu: host1x: Wait for timeout worker completion on
 channel free
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-1-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS3P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21f::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: c9410275-a728-44ac-3dea-08dec5fe84f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Y81oywOMiGfjdIoVjLLG/9bhrW5v437TOTVTXS1wg9W8jnLh1KQvppwLomNfUsje/+cbt4ckGgR4NpqHMlNu9kO2M7H+Xyq0ZhaN5uiiVtbEhwpWAB5gHjryHaYNk7kmOXtAbU3SSEVuUaXZfUZxQwaeH3RahPA3CeKio4j93YYByNqPnZebYj0B/2Ff6qO7U9SctAgNmgY3oYG9pPGhcD/bTYcMRjIxo04UlFEEfve46QaPuxtb6H4iTCtXL2Zdu3+oGy9KIcmLaZQ+yzs7SAnuKoKZk91o2QakNqT1OXH7CtbTxGpC5sOgLB5E2py9CTg2L9FqntGVtj/Jp9k5lu/k6iBoWLH081XLnV54O7rJJNaa9ZnkuebSy07wUx/KcH7UBvO9xQGIvbGzlGXnLUkOgpAsZ08A8mZW419Bi9vRw7P9i2PslfMfQ8y7sEvsqrD3Vk0WU4xIzihscZiRXTXGDg3IBwhSybbjGzZG6qnqzV2umR5Rd3YqiV+/Uv9Iss7SttsycAg2UsaBCJVTF44SH6R/AW4WSBhzdLJL5vbJXHa/68mwzh7wUsVmsa7gPWPP1c4oNqlAvWIttC8Q6yNEt28fPikGoGMw/v5frcEkXNppWe24BcbHdHAR9E22i5ILqXRUJLyUb3ATdpzAsY2QxyQSAg59fWhA6HtUICqHp2NDu2DyrFqMkizVnjsb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJqMlcyQTNJV3RTUDRHdVV6b0JJYUdWdndvL2FhekZxZnZzWjVRNFNFWW5t?=
 =?utf-8?B?YnNibUdPc3VOZi96Njc4UE15cDJQM0wreDYyV09KbWxNdWZvWmxsMVhQb200?=
 =?utf-8?B?djZHTUc2S00zRTRXcC9lMVhlZnRvRWRvYTYyTzBuYlkxU0xUL1RGMG9HR0Ro?=
 =?utf-8?B?VXBmR3NlMVZ2T29iT21BQ0pvTWVwL1N6bHplN2tWdVBGQmVRemVkS0ZuRm1i?=
 =?utf-8?B?bGNaV3VPWThpay8xRjY0NTVSZG5DWEc1ZHRuQVM4dEZJL3hJOU5zSFNZcHNm?=
 =?utf-8?B?OEliZTNlanEzSGVVSEpQTFhOTTRDZUg5amVCYndLOGpCMHV0RmhtSm9HS2Zw?=
 =?utf-8?B?U1FlTDVEZWp2MUVvaGRoVkZ0WUZHYU9XVmdKR0dqb1d2d1FyOG1kWmVJTlpn?=
 =?utf-8?B?UjZOMGJtLzlyS0RvUmRhSjhTeFI4ODl6NEJMSEMwVWpua3dMOUtXT21oVEoy?=
 =?utf-8?B?RHlPUDcwM05OVmp2M1d5T3hwbnlQL29oai9mSzBvYTZ4NDRXSGFVQ1hTYmRi?=
 =?utf-8?B?bDliR3JiZGxzM2ZNMWQ5b2FySlhBMlYzUGc3MlQ4VjMyMm9oTlprM1JLa3Zz?=
 =?utf-8?B?MUU2M3AyTURKdlF5cmx4NzJyUll4dzI3Y0hyLzdqNEczeW1aOThZUUlRTVV4?=
 =?utf-8?B?S1FtY0lJNEduY2QrWHZ2MFZJMURRYk5yQjZHUU10TVRiQmk5cFVJaUFEeWhh?=
 =?utf-8?B?dmRPUHBmVHNYZkVpRjB0SjJpVm1YVVhUNG11bDF6YXBob0NGMXR5OGk3RGNo?=
 =?utf-8?B?KzFQNjBzVDFVbXBJL3ZzLzFPMm5XVWx5RVRWQktmRS83RFdvKy9FRGVZSHJY?=
 =?utf-8?B?cVpvVEJwb2xkd2Npb0pHbUtWRk5DZGdXYWFjeVRXSGJueThVSm91MVJWdE9P?=
 =?utf-8?B?VzBSOFp4eUNuc0lXa3Rwa0JnYlNhNnVZd2dpMDQvMENjdjhnOXdnQVpBUkEz?=
 =?utf-8?B?U21JdTdranNvTGJGbllxem1YeElzemNkNkRBNTN6SHF2UmVUclAxYm5Gc09I?=
 =?utf-8?B?VDRyQTB4aFBQSy8rekRkWWt0NkxYbjVQRldJV1l4L2xBMFBjdGVqcUxQcE9z?=
 =?utf-8?B?WjJBc29aYXpXeFcwd1FRSm1Makx0Z1hYejhSRUZjTVI4dmdCZ3VpODFTakFt?=
 =?utf-8?B?bkJNc2tWTkVrRXExVkdXSlB5Y3UrbXRkVURPUGxMYUFFbjdFcnBPSitGbTJR?=
 =?utf-8?B?SjlBcTdoaHF1ZUErNVJSY2puQ21MRGt3dXB6Q2I5ajNtd0tJUnhyRXBRS28v?=
 =?utf-8?B?STNWZndKdWxoNTc3M09lUXVVNUd5bHV3L0lsZ2RNZ3I4YmhieCtDSG0zUjN5?=
 =?utf-8?B?U2hrcnY3V2FROEd0VHhaU3VTeXY1U3VWODludWNHaDhCeFc0RHhsWGpCclV6?=
 =?utf-8?B?bmZmVG0yTTN0Z3QwZU4zSU5oZzBZQWplbHh3QW41OElZV2UxSVpqVGNaYUxy?=
 =?utf-8?B?NG9YL0VXT3pkSndiUUZaMGlSOVhUZlgzRU4xZnR1QmVEMWR6ZXRBUlB3WVF3?=
 =?utf-8?B?UEFSOTVBYk9sek1jMHpEY2NoRWtZSDN3czlUOEM0SzZBQ0tuV20zSUc0TTY1?=
 =?utf-8?B?Z3VQam5VTVlFeWNCT3Nqd3hhVm1JeURWNm4vY3RsZmY2aERuWlF6bWlVdmoz?=
 =?utf-8?B?V2xVYTd4b3BMM3lwT3ZnYXBjR3VIN1kxZXR1UzY5eEpmUldMTUlFTTliMEF6?=
 =?utf-8?B?ZHpmNkRtSWI4M0ZIZDk1dGw0VUo0Vzg1ZGFLWWRSLzZXZGtxbStsd2RuRUNl?=
 =?utf-8?B?WFFzNlJLMXRwZFJxSkpIWkJsc1NScHA1V0dkcnFPQVdFcHRyQjVlZEhWTnYz?=
 =?utf-8?B?T2QrcUhheWd4UnVyTHdXRnB4bDlOTUR0OUJQaGRIMk9FQzZzSTJmWFV3MVFY?=
 =?utf-8?B?TkZwVXJxcWtsNnA3VGpFOGNqR3FtRUdHQitzRGxXMG05K2ZRN3cwZEJBdFdK?=
 =?utf-8?B?K3VyZ0xLM1pkNlRJZTZVaTUwWjd3TFVtSXR0aGFONWIvS3oxSW8weDh5eWF1?=
 =?utf-8?B?UWFsRFJOakxtT3B1ZHNjbFgrU3pSbjY0RWlXRmcwL3FId1NXR1BEOXJydGJq?=
 =?utf-8?B?dWZ3MnRKUEZhQU1zcWY1akZ1bFdWS0VYRGZxczl0dkNDcy90MVJjcTlJZnpF?=
 =?utf-8?B?NDV2VjJIOUhtVXNzL2VEZU9ZVkRVVFhBNWhBNTEzMVhGMEd6dnB4TUswTjdx?=
 =?utf-8?B?RmpBZ2Y0WTNvNFJXREtuS1dHS3JYcDBtek5BaVVrTXU2NEVBN0hsRXdvd3FU?=
 =?utf-8?B?T1RuVnIxd0l2RDNIWDFyNEN0UVpDOFNPSFpFYVpVSzdaM01PZVRkYjI5dWEz?=
 =?utf-8?B?SWZUcmdVOGtLcm56dUFJM3E3NS9admtTTi9RN3p5dzQrZFUyYXBDM1ZSeEl3?=
 =?utf-8?Q?mvPVmU21Kf387hQyRdlOY8XZxx2udauCASK8copDIarJO?=
X-MS-Exchange-AntiSpam-MessageData-1: 9hqgbNXc9Z8q8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9410275-a728-44ac-3dea-08dec5fe84f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:07.6817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VhjDfTfR9W2Smu1abS8B/TABvSjUIQwdJej3ne4KN6isgQicjM7TbBHrhshoFJ88U3RGimXtxtGJpOAqtsYgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

cdma_timeout_destroy() used cancel_delayed_work() to cancel pending
timeout work when destroying the CDMA. Usually this is fine, but
there is a narrow race condition where the timeout handler has started
execution but has not taken cdma->lock; the channel is freed causing
cdma_stop to take cdma->lock and flush the channel; host1x_cdma_deinit
then proceeds with deinitializing cdma while the handler is waiting to
take cdma->lock.

Therefore change cdma_timeout_destroy to use cancel_delayed_work_sync
instead to ensure any pending timeout work completes before proceeding.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/cdma_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index 3f3f0018eee0..ab714d221120 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -355,7 +355,7 @@ static int cdma_timeout_init(struct host1x_cdma *cdma)
 static void cdma_timeout_destroy(struct host1x_cdma *cdma)
 {
 	if (cdma->timeout.initialized)
-		cancel_delayed_work(&cdma->timeout.wq);
+		cancel_delayed_work_sync(&cdma->timeout.wq);
 
 	cdma->timeout.initialized = false;
 }

-- 
2.53.0

