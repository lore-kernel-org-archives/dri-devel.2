Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EDECD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553F510E184;
	Tue,  9 Jun 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWSwniWR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFB510E185
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcPf51vReM1MD6DKYq2ilJwWVVnl5hIstgMFeWZsLo9rcPvAIPFPQAiY5KW9nwyCeVc3QKkixV5AFhAIlDaErCmeZKkZrZ+HtaQ6PcN59Hu9PtLum5kSO0yce7hshjREhFvxiWCeIJHy/LEARwkNWotprNbgv41YzMTzZULId5V+0sDLq/l4B8L45rgfxfl6pWAiucBLlSaYg4W0vQTc2zuOqp2hJjVR7xrAYPuULU8huDMKVhEvaC40X2iQtHa8fn5u+oDpbSeOoQWZYT7ICWpVpu1b8Vu3iDu/F1XsR/vhHHP50dgZxhuNoUanK0LwQXpNZJxJ7Q2MFpmyxbkQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63i0jebnO36wgZkfsZ10v/hehNR4iDNX1zTu/NGuxVM=;
 b=yicY/CaEIOx19d68pphJdfPhYV9DFyJJXxo3dx7TSr0noQd5Au2GnWqMYxzHVTApD/jUMCoQwrJ/Nn7GkVj2w3w/+y+t7JvAJVx8CC4Ijj2fTtNI+viLK9cs/zqnftOX9UT34h75YUjBaqrwocEH9I7BRP8qlwx2wj128RxaV59B0Y+Ewd7XoEy04Ujzen/RzYjfGn19Gd9yb2IYKAWRc6wRZtiI2U5f0fwDEKoUgQp/4nOAdomshgdgt5KPKY/s1gk9IFUymUmrVihZ5xAogtt2skntjG0ALkzY5rS6XnTS7Wsd0flgswrHEi4HW75O8wjYEY6S59p6INI9Ro5vIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63i0jebnO36wgZkfsZ10v/hehNR4iDNX1zTu/NGuxVM=;
 b=sWSwniWRPE9hNbCi5VgSo7YLSmRSO+Pfy8NmAXDuS6aB/rfOSzPKEDp+WOkJ9Kr3vwgpWPjw8iV6NB2xRIidJ7egbPsSplqwfixNAKkrTDrIMG9J/y+FBNQTErTQiu3bcIXmh81ED9CpdJiiLLk1aKHi25Dhd+GNyByMnZz8ukU/nGzIyn6c+08T4slsVd/2KTgYQkFNTXz0uyD4Up8VJOtiErBxx6hkATXLm7you9rhocLox5icLBBOa4TawIrlXB5gNrY42aFp5s6G+Vh9X5GbgyVgF2JGs5hqcF0UDhjzopC6DjKFX6EXqM6RExKpIYeZvc46HQFtfUjajTlkBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:22 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:22 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:21 +0900
Subject: [PATCH 5/6] gpu: host1x: Change pin_job() return type to int
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-5-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0308.jpnprd01.prod.outlook.com
 (2603:1096:604:26f::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc62cac-59e5-4ea9-bcc4-08dec5fe8de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rynrU0H0ngFSDsVSxFFxKtxd61WKrXRNv6C0RrOhuY/PTOeyGkctARdd/uzuVfP39hhFrAgmB+qHvMybevcoOjAi+aTA3VZFkIXL0f6URrobKAvCQ+YCx9irdKdqkWkyENW+3evVtPbjn7TkwO/M/hgI8djmrL6eXnjys34mZXTlVS3HbYpPcyPjV2fh9soOWc6owR3oKb/WkuQayzmj1yxZPfkoi/Ua3pHPiNP2yqLmk+iywaKFM3tQKxW/pGknJCxLgFrKFtm8dymETcd3mT0bov0zkSlrfdS7nkO5y28lTs50Kmp1tH1WsWW3Dt0dISD2uLnDBsGJWOIl9CmSKGz8mvQqtZ+ab10WN8+twUf5N7thKCdm8ltIZwO2fRZkFa3ZnGnNno+FMojgLuaRwFUBN0LRrUVeMg6iWJv9Yp62/0KCHpK20fTVcDoJnRYAz7uENDdDuS8QvcON3/JDWjVjPxmPmdGzo5yRT1P+TiblXazwU0dDm8sygbDhFJRyqHkn+tugpyX0P4DVGaUwr/q5mMyDv2Wv2j31OHyQbr8P4j3zUlHnyhlheA4JZJwfrubXCG0Wkvlur4S5GTKvKvCrU/Qy+5oO5H/Pu+T0LNqusEyL5bOQ6cjxx5W9G7ujA/4LZZbZa6CYn0AZ/boaJlmBqK2Vigg6ZOlVr8ir9ernMeMkoG+UV8Pu/vjJ6knL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aml1VlcreW8vWU1XRzNiVmhkTzViOFB1MlVMNFpDaFgyZ2ErUGZ6cDR1eHho?=
 =?utf-8?B?NkNRTFNrSXBMUW0wRCtpTldJYis5MDRReTJXcEVOalNqWGFLcW9odmQyN1VD?=
 =?utf-8?B?aEUzaGZnWExFY05kRnpkUlJtYWxGd3h3VC9nVWNzL1g0QTlUME9IOUxKTC85?=
 =?utf-8?B?TjlDd0xnSFBUa2dydFFRczhUdnIvQTNpODgwdHZEUkNBaHgxMGtpbkJ4TjZP?=
 =?utf-8?B?N2hFOWdOb2s0ZTJTSSt4T1lMdFZ4TGRSajR5RGhlcDZZb1ZwVzMwWVM3anVY?=
 =?utf-8?B?c2g1NWhuWTk0eU9lai9VUEc3UWcwTlA2REpuVUUxVWZuVFUvOCtGazBzRnE0?=
 =?utf-8?B?dW1sSDR5clBzSEx1N2NudmZ0Z05qK29JZnNmdzRrWFFGUXpqN1pDbXRzSjJu?=
 =?utf-8?B?TEtZb1Qvd1NBbzQreWdKOWdBc1Y1dWIrZnRoR1lPN09hTnJLU0xVV3dkWUZa?=
 =?utf-8?B?cGJUWmJBMlkvUVBNemZxemNIWFNuTzlJQWtpOHJDZnVHM1Q2UjJEbWNiQVlE?=
 =?utf-8?B?dkM4UzRjVm5SRnFaVXFhZFRmVWdVY3pMdk5pNG10YUpPK1B4aUp3dXo2QWxr?=
 =?utf-8?B?azIxcTg2OVN5SGRlaFB0L21WUGpUejBoRFI2RW1pM2FnbDJkTlpiayswSVBm?=
 =?utf-8?B?YW1NcDgxQkpjQmVIUE0zMXI1YlFZcHRxNmFROE9yYjNRTGNHaUc5am9iQ1hU?=
 =?utf-8?B?NTRwTGUvQ0F3bnpqOFk1cnE3cFB3ZDRtcTh6bkpvNjFJZXFnbUx3NHNwbUVT?=
 =?utf-8?B?NUFHZGZvaU1vRnBIeFVPRk5Nc0h2aWhrNGdoUGJWcHJuVkhmS3FOVXJpeGpk?=
 =?utf-8?B?NUFBLzN0enUwZGxZODBiRnJxVjdENlZnWkR4NEk1RUVFd0tMVTJVN0tRZmgy?=
 =?utf-8?B?Sk4yZXhUaWJmWUo2enIyaFc4eW4zdS80M0oxU0I1UjYxa3lQc0VLbVJZWnhU?=
 =?utf-8?B?N2xMT25KL0Q5RHhNUlNtYVk0QUdCNFBCc3RKNnh4THNWY3RiNkpGOGFmWkE2?=
 =?utf-8?B?MnpqRXlJOFRPME9pSTIyZGVHYjcreWc2a1preGM0YU9ybnpXM3U3YmNUNGxj?=
 =?utf-8?B?QVMzRlg1ekFVd0pERVpqOSt0c0UvSXN3RkM0RkMxRTZ5eFo5Q3RkZnliUFpk?=
 =?utf-8?B?U2c4dG12aDE4NWJXTTRDWDFaRTBMYW1PTUxnN3FNWXRzY0lqRXNidHlYc25X?=
 =?utf-8?B?U2RwYWtmblRTdkQxVTEwUXhUM01Lajh6UDZGQkxUT0hQRlRQMU1TbjdpVExR?=
 =?utf-8?B?bFhrSTlBa1hxSVpndzVFMXZ2NFM4THE3bS8vbTJtK2o3ZlM4NFFuWW83emRM?=
 =?utf-8?B?bGJxOGFKM0VEbExJbXN2emE3UnF3WU5uM2NxRjZyUGpqRHRYS2xyWGVTVEZF?=
 =?utf-8?B?QUppNTE5RkZycjBHZjFjcEk2VnNXa005VVZQNG9ybjQycEh1OTNzbFVaejdY?=
 =?utf-8?B?djJjQjN5VkJQUTJHZDVQMWZuZDV1dmI3WC84Q2NJMkVJRUw0Y1dTa0sxYXpn?=
 =?utf-8?B?b240d1BBZGZFSVl1SHVva0YyMEg3dWJHUlJnNFlOWWJZR25GWGg0bGFpNTFp?=
 =?utf-8?B?Uk1TdG9XL2dJQ0dmTDBMUkhlckZWM1F1dVUrOTJ1YmtrVjd5czZsQmZoNXY0?=
 =?utf-8?B?TEpXQStxUUgxMVNIK09GeGxldllxOUR5cVVicFVNc3dXcVd3MzFwN0M3MEtz?=
 =?utf-8?B?bG5UUksxMkI5YzRvTlVRaFkya3g3NGhaSGw0T3JobDQ0RFRtS0FSM3VJcllu?=
 =?utf-8?B?elFTcjYvQU1JTkQxRkVQZ0ZGYWJnSUNMamFBZGZEc3d5dWM1UXZyS0E4dCs2?=
 =?utf-8?B?SUtRUFFITnhTZHRON3FmU1pJWkFJSnd6MzdPWlNGallUSzJMbS90cHRTSXdW?=
 =?utf-8?B?VlIzVUYvQVkrT1ZxaUV4UkdBM0xna2lySG5XMDU2aGh5YzZjcUdhVEpIdW5J?=
 =?utf-8?B?aXFTL29mVS9Cb2lwYkFOelJnZHZvdHUwdFBPUHFMTEI1Q2grQkQ2SjEzL0Uv?=
 =?utf-8?B?NDJlMC9Fdk9hb0ZzT3dBY1h4LysvbU5mWlQ0dFBVanlIVUZudzhSbllqK1Fs?=
 =?utf-8?B?NStHMjZENjZRb2Nmd1BsV2FYZnNkNG1QdExmZEh3NHZEZ1pYR0svc1hCTVhp?=
 =?utf-8?B?d3I3Z3EzdUhNSUx3YUhFSVh0MkdTaTVQTWNmb0pQVDhza0JsbjJCaUlOSFFp?=
 =?utf-8?B?ZERLZDBmaDJxZE1iL0QvajBwMUZuK3J3MXo2Vnd4bk1ZSDl3T25aaEdqMENM?=
 =?utf-8?B?U2dEcHpWUkRHVnplb1ZiMktkSkpjdmhZWGlnQUR5VDlvSGhlQ1Zwb0MrWG95?=
 =?utf-8?B?b010b1dBTUFPbFB6RG5LRTl6a2RsNTEvN0M0TkM4L3ZjZ2x4dTg2Y1FKczBP?=
 =?utf-8?Q?qwlvODgk+V0A62mtqZudLMq+V2+ThPTdVYjh77HChJ/3d?=
X-MS-Exchange-AntiSpam-MessageData-1: VMSeZmsz1GB+QA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc62cac-59e5-4ea9-bcc4-08dec5fe8de5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:22.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaqQaMhNG8STYd9MgXMk2qd28UHPTldTtcbWoCod3cqnGFU7Kw8QAWTZPdvZ3aLbsdLDjiZClc/XVnsWNmf+zw==
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

pin_job() returns negative errno values on error paths (-EINVAL,
-ENOMEM, PTR_ERR() of mapping) but was declared as unsigned int.
The caller would immediately cast back to int, so there was no
functional issue, but it still warrants fixing.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 3ed49e1fd933..165979319599 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -138,7 +138,7 @@ void host1x_job_add_wait(struct host1x_job *job, u32 id, u32 thresh,
 }
 EXPORT_SYMBOL(host1x_job_add_wait);
 
-static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
+static int pin_job(struct host1x *host, struct host1x_job *job)
 {
 	unsigned long mask = HOST1X_RELOC_READ | HOST1X_RELOC_WRITE;
 	struct host1x_client *client = job->client;

-- 
2.53.0

