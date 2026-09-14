Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E87C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926EB10EA9D;
	Mon, 14 Sep 2026 00:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oHTD0fMQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432C110E19C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB1WGPSDaJw2ZGvXVKQtxqJxLOTQUgdaimMDZe+bGier9ShFz0oXTRlmrWk/HeP2AYOnwJcj+QeDRyfpUxlSu+t2ghKnQE/g57RpcO7tRAIW+qvlwIt1zJXETQJmP77LeSt9HGAB/WliBPA/2WcXtJQ30lPa55AWQBRr088JMJR1MDjuN0QMEeBatKSf/M/JhZOEH98gGJw+6rMNW8DPApUZ/Y+2s05QfTnnOGymLJdj7GmvtqusdAea9PQBW9Q9OJKt5MWdNzZavTnMrgjR5w9g6pHa1stn5A03++X+QK/XQ7Lqwh0sRigcQqBNOSDpbzoAe4JdR7CfWywrCNTJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0srAe7leHLcuTk2u8vKWuuvw7NWA22PuqY7pZolgt3M=;
 b=ELl9I7oZS/yisGemutLo9HfBv7vLQZ20JFm2MGXBcy5AhMotvW/5Bc/71U9Lm3Aj3txg9z4ElsBmli9Pdld4ZaPcOJpLxNLpUsXDjz/jnoSdtXg/uKCVpj0OQSmXy4v+psSYcBG8nCoNPT4aXXXKeD2zPiPQGa7a4GIQEnpUNzoCJ4KtdgtRZXNL1gq6Zz7jQ3i7sl8H93FszRM2G2Vo1GYZzmnNEikpb8ihRz9HY/pqAI1xDbUKFr7qJh6Sg6POeMCYqjEzR3+iYp5kRskomdNY5cP6Ty43d0/zP1l2yRtwdK2KpSYpFQ7d4KSmaHCd6N/R2lh1WVb6xYYy2w7dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0srAe7leHLcuTk2u8vKWuuvw7NWA22PuqY7pZolgt3M=;
 b=oHTD0fMQDqiGo+1tancMnbX9jZSk9C+gL4T6zglWL+1Q/bfqKaAkjE6dgUu9IjzKtx29GfBaKQYxhS/T/ZR7zV6/T9f59eXSKeZ9Nfl05799BnrhNJlGrtly0JnSslri+XGRaRYN28gLmJw2LAcC86vdiEEOuHofsa9yVQR28nntArHEY5VrHYq7fhH4tjim/r3frAPXuZk13FtgnVjTrjZNPykU/XozPU37c9WtOUYbGbPt0Yx7aKZz13kw0Wdiygx8crk2c3zuLU9PP0SREJ+T/TRy+k8fd7tuJtd9fafqw3W4O0mF3Lrc9IvhE4cgpYGD1u0oCxcuknCV5jxUtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 00:45:21 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 00:45:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 09:45:17 +0900
Message-Id: <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
In-Reply-To: <20260913210806.125589-1-kernel@matt3o12.de>
X-ClientProxiedBy: TY4PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c03a56-74e5-47e6-7c27-08df11f97490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YxU5O3vLGcRb6d2JbgLlf7Kj3x5THIDpQNcCEgFE5+flrV4U9Ffd1EzqHRJ4SOxQXnaqBArACk4Xw5kLIGCizC6C9dSL8PK8UmE+VH249/sHK7q2jlsqO5/wD42lYVBbZMIae2oosXyb9M7iVe4K5N6jsDjxgE5Mg9OuU7ulEyJZ3hAYl3lpezieDku/kZZPrFSDzCnQ4++wcIZkGZzn6VcC0YzoQjwmPq+hGb7IejvD6hxDNGQXUG8c4NrXxxS8AIRNxWDKhVbcPj5POBd5z1MY/98+x0Negc/3Ba5Zg71ktXdBWPyQdlit1Xc4Z8N3rI2Gh9Vp4GUzrXac4wR5GxmmwcopR0LR3C/XChrBcPA7Hazgr2Omre5c2Fqq7bpG9V/Nk5xDt3MW4cqZOjHpFtLaM7dHWWPQYU+bBSxrVlmn32JBQhf6G4Q5Ce2++A8/0XpOp9uZf5EHDQnQbBFTO3nJX444SMlMczHN7lOTR3XaO3tntzbAZ+rtBZWSTDZfcj0JJYCeR2jYsmgv8S9CF6cZxj/YpoxaYXaiLIgGDmXDiusbSm9YCBXI1OspB7IHRpiRXeIuxhf3ifaCjliHaGr09WoVpJxmEJ7QVu2Br9Wfhg/AgNBtU8WlgzWamRhzYNzW7peuECEUHddN1iuQK2dut2sKOkZE0+TTDVa0bhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhWV0NJNm1zdk1XL2diKzVaamsvSncreUVIQWkxaEhnd3Bac1hVNFBtMW50?=
 =?utf-8?B?VjNtbGxaazVUem16OThWQm00a2xGcDlZUDVNVGNNczJzZ0x3UEtWdm9LL0pM?=
 =?utf-8?B?NVN2STlySTEvYTR5UGwxbGdYSTlKYm1hdHBkQnh3TUJFNG03TlhqY0hweFhs?=
 =?utf-8?B?YXpDRGUyRjV4dkRsMVNEVEZLS05WclVPSmhHS0dHaFE5REYrNGE4V1VCUWdD?=
 =?utf-8?B?dXd1aEhkMmY3WHByaTJySE9ZQ2NBWXdkdDNob2V4eVJxTVJMcW12NEdkTEhq?=
 =?utf-8?B?MjIwc1BiRjkwNVBsTUZFRjV5aGpINnovdk9MOCtwV3MyU3dQY0o2RW0veVdD?=
 =?utf-8?B?NFY1VGh1Tml0WUNLS01mYXU3UGNSRkZDdE4rUmJjTVBrVzJVU3p2Nkp1Rmkw?=
 =?utf-8?B?UUVwSW5jTldLS0pxYWZkRDJIREZIbWsxNDVvU1hBTzc4aENYL0NkVVdCWnJj?=
 =?utf-8?B?VlJLTEFOZk8zMkhBbS8wQS9KYnNLUzdKUzRjMmY4UFp4WHdXRGZEK1JjV0kw?=
 =?utf-8?B?WjNxMEV2STVNTUVqcThDZWZRZGlSUDY0ZHYvZzMzMzZZaS9rejFuTWVZNzkx?=
 =?utf-8?B?eTg2QVZiaFVKSysrUmxaV1grSnJUUWE5djc3aTEzQUhCeGQ4ZHU0WThYQmIv?=
 =?utf-8?B?aDlibERGUldGWnZWNjltMWswUW5sTkpnRzNtZ2ZDYnE2TnJwZWw3aHZNR3d3?=
 =?utf-8?B?ZWZaQ09lYlJyU0V0WUJ6WnlwRGppaDJQZmNzTFIwUHlXTG1aUC83Mm9hTTFs?=
 =?utf-8?B?cjBkV1JtdzliNWtjMWJBQytud0E3bzFJK1RFSXFXU3dWdjRZWCtKZTVpS3F3?=
 =?utf-8?B?dWxtZitPdzdPSVFlSksyY2JWUjFyeHhUOUFPSnd1b1RodGVrL01TVjE3MVdO?=
 =?utf-8?B?QVAydGRmQ3N5dXo2K2UrMUxRUFJrd1JSVk9NOFF5NjlNWEVySCtCMTNJMHE0?=
 =?utf-8?B?bS9xckE5RjdDalppSzhJc09nY1RjNG9EY2dxNDlVbmN0RjRXYXBFV0hITlVJ?=
 =?utf-8?B?cDJrRWowamJjdjdzb1hiaWdkeFhSWEswZHZyMHhWVGVvSUEvSG9VdE1oU0V6?=
 =?utf-8?B?ZWtXNFJ4U0RzcUxVR0FHWC9Fd0Q0M01SbmJOWUNyenYvQjVJS0ZDTVZKSFU2?=
 =?utf-8?B?RWlTTlNzWDY1bUEvYllGS0tibXI2d04xUlRMa0QwZGFGYnpKVXh0VUFuTWcv?=
 =?utf-8?B?M3dldndCQTJldFNEeFQwZExMSmI3OU52bUF2VTBJMVNvQlhWbFdqWStTNGN3?=
 =?utf-8?B?blRjSlRpZjV4OGljdUJpa28wMDZVdklNbEM3WlRSR2RVMXdmUjFZcnpSZWhr?=
 =?utf-8?B?L1BKQWRQMVM0K0xLUnhCUlE3a09kREthQkFpYW03WFJlOEhoeGJ6bnlDNGpJ?=
 =?utf-8?B?UnJBUUk1L1lvYUJGSzlEYWJVL3dpNllheHZ0NlhYakx6TCtIcjc2WlFsQjZG?=
 =?utf-8?B?YVZIOEJaV1RMeWFGT1drbWdTUHVsTFRlZ3l0eC9MVmEvU0lPY29qQytud3JQ?=
 =?utf-8?B?Y1BBdWtPcy9uT1Z6Yy9nME5POEJCcGpnRlU2QWJ4RHFaQVhSQmcwVmhWeUhL?=
 =?utf-8?B?TnJCMTQxVEUyTkxVc293MlpxVDVVK1FPMVBhcTRpUWdTbUtEQ0lPeDhnUWo4?=
 =?utf-8?B?ZG1tWU8zTmJ4WlRteWpUdXc5WC8vYTZ5Z2NQOTVSdjRKNUJLdGdLdUNuOXc5?=
 =?utf-8?B?Y09xQ2hEUzhnclhhUE9wbTVLUFc2ZDhNak1valFlRmxFQnBUcm5PM1lMbnNk?=
 =?utf-8?B?SkdlTVdXM1VQeVpsK3RGMXl3OC95Nis1Mndtb05HZEk2OHc2MGh1WlE1bk0v?=
 =?utf-8?B?SGpVYzdJTW9lYTFYME54V2JBcmhMRnROZDcybE5wbEVjVktRaVVzamFMbUFu?=
 =?utf-8?B?MVJ0azBZR3g2SVpPOERQYllKYTJDRmd4Vnlhd1JLSGdCb3FTR2hkNFB0MEhZ?=
 =?utf-8?B?dFVKVi9mQVRac01xcVJmcFR6RnNtNG1TUEhJZmFHWGZoa1ZjL05qZWROMnpw?=
 =?utf-8?B?dzdtWmI1RlpuWmUzU0ppaitOeWdDaHNTYU1pWmdFSkJNaldUTFdyVjJoZXpN?=
 =?utf-8?B?eVIyM2Z1clVoVzhkRTVFN1pHTkFucUsyYSt4U2tZdW9KMHpHODZvM3NROFBE?=
 =?utf-8?B?UFZDMjVMbDRVRHlwMHkyZngxNVpZVlMxTVhEQUlxSUdVQXBVbUd5bmIxR1ZZ?=
 =?utf-8?B?U2ZIRFFoUzVTa2VBQXptTVhZT1FIdloxYTJUNGI5a3RWWERWYVdlOXVINE5B?=
 =?utf-8?B?aDBxbnZaQnU5QW9nT2FxaDJTWWNXVlBzOVdaS1VTMzVlbnZQS092SnIrWGZS?=
 =?utf-8?B?SnlrbGVTNmJpM2t1ZG9VRS9jWjhxOUFzWDN5RXJqSCsrVjBncGdMMHRMdTdj?=
 =?utf-8?Q?S/QWT/gW9hvxh11TiUzleFKjneU6+ObpZlsLzTyb1nzzq?=
X-MS-Exchange-AntiSpam-MessageData-1: 2DG8VjztjVqDDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c03a56-74e5-47e6-7c27-08df11f97490
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 00:45:21.0913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU8SmtBS4jXWL6E7N8UI1NVVy+ohL4EqDJU0Ym2TUj/fv+WpDBOB9U4UHXseAaoFViqO1e44hOuTy6tGYFG8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>> It also means that without patch 1, nova-core would split the firmware
>> into hundreds of 64KB SG entries, which is not breaking but still
>> something we want to avoid. The correct fix is to make sure that
>> `dma_set_max_seg_size` is called by the driver, and while we are at it
>> we also want every driver to call `dma_set_mask_and_coherent`. Ideally
>> we would use the type system to make sure that both functions are called
>> before any DMA operation can take place (using a safe interface), but
>> I'm not quite sure yet how we can do this.
>
> This sounds sensible indeed. Should I open a thread regarding that on Zul=
ip?

Probably not necessary, the mailing-list has a larger audience and is
the right place for this. I expect people will jump in here with their
thoughts.
