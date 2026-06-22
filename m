Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3DCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D4510E4C9;
	Mon, 22 Jun 2026 06:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Guht0r8t";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA63A10E4C6
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeBGOxpKXxh9fW+6AvqWaeEjfB7IZerS87XKOWZXdL+nxkeGQvkLotfeWIgbIeIzDSjPrXZNktOfqFrXGu6V/LhFB4dBuw1rIL9CyCyb8jHpSM8oOaWGqn7CFp0ZWzPj3Ttk3gR2RD40xd1hWZsCZL2tNY8u6XnjZtWx55tLvr6FAAb7agidyrwqARSOdN1QN6u/AbxhBhxZCvX7w+awULpZkNWvvv/0NO3EUyw/gSajvsURk11b2KzgJy9vAPCaWyCYYMQAwHy7jhmNJEh2zcqXudxGUwf6ar/8aPa1gGQSuLHNgLpRZgw4H2s7xN2dD20DvMA3ltHMKXfrd9ziPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzqTCg0R/p/QmE0fyh51kTb4TZfSQtZuIW3Vl4GkIAs=;
 b=igzTywQeu3+FxmqSw/c8h4tqVPNNZ/EaSXPgrS4Ula/BP5A6yGq12UrSLarvEXmhTfpTjL48FqNeLvbYw+nvmsAnbTOtPbjLOxndqkncKbE/rSGS57ceFzGGwHOta5e9igyo+3NrTO1iVBEmgWuJrj4NwtkQJy+YIrcKGAFZeZD0PmMGZqIDUYssbBVeBZe3xCJkWqJtS0PuQhVJEg1L7gz7An07+U/WwTleJdSxZMWZ3K5upgJWapWk5j2uwZZy6dB1wiDFb/usQxmNR82J1g9/n4gPwOtm1x3D7II3WTX+6Re5ksVIkZcgaHmZjCJtZbB5gnyATpsrPAUdsoTGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzqTCg0R/p/QmE0fyh51kTb4TZfSQtZuIW3Vl4GkIAs=;
 b=Guht0r8tW93GFGZq0Lnf4lTrNlm/mHucPqDRGOO82mnISpUuVwkMJY5lA5seuBFnIwPWw6axnNzIrFXBwWBeB9Q4lj2uIaeodJqLc2kz7eyc4CNcHGWryF1+GAGva4me19j27Xf4co6I2mmQDuWp+VrHh2AhWh8/u9NowrnQ8b5ZJhjEWDvYXHNJUC4vKNh3Kg7tSe83Uzdq4IYjmWZ2opUIaNK9uSVow88jQHm3JEtcrxqhM7s0b/nydpEux71TwhjdFKtdaVBlZBKtgR31xoU226o4fqIGq4NKXh8jd/5EbD/ll3wI1FwbQb0hrQ+4XyfdjRHQhVNLXlMmv77deA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:05 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:40 +0900
Subject: [PATCH v2 3/7] gpu: host1x: Correctly parse linear ranges of
 context devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-3-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:604:258::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 32af6ab1-77cc-4601-8e35-08ded02b9c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: NX0Ux3WSCwvvqlfj7cn9qKo4ViO+tmuPJ1wcEQ9R9sP+2uW0iZM9GjismS1NoMlVVmJPpNGkr7Fl2Gxpr4eLCRNJ44JdNd6Sq75vs/ItdPKUczuX4EDipv3UDT0KfE685LrmVvCYHhHUpD6aejRi4N8G+3D1V2uCJ0jmm08GtHJwidR/QniMoah+6FkvqYBBeAN0HZfKuqsSBwC6pfwSH0nQ1ysOWb0dnwIxglhM6+dD9s06L4lwodTsVH7Z8re+pnwyFex6ysMhkrTw+J2Fh1VuilHmXExf4Lok4tbPV/rUXZy92eJOsYXMOb0gSvjAy9XpvlgWTh4q1rQ7f07RleHdBqbrxHvhzRwyvNH8anxEHzX61JkgB4M9IjOUjVgy/JOpf0pWJSTHxbdpI7pluPom1Tbg2IC98hzXQlwYHRCFxRBca63iFSSv+iALitUkTsN79YrNNIRMob2dXGEB1tCkUSSd9TZB+A4rbyo3ehCpUP2zKvqpUa0IccZlnmedIVxqQWaiAZKx1UNc8pK22JcHn33VeI8eJR02IGr2mvBuTirQIJxxUrJR18oJ/PoU4CsMEc4r3pOZgDTha1+dgIQIlS7sUq+bD9GZCGAK0JupNBSRZ5VkvnqTaa3IZmNc1DFL7LMfTCgIgxDQBvEv1Znmk7S8enlTHCF0iHwjBZfqfIt3WHMIzJ6E61aUDoVinMahNAzlJnZca0tiJAH/NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dwcUdpVUFVdFoyY3FUcGovR2NUWGw1NWk4emdURUlvY1p5M2MxM00wdWlh?=
 =?utf-8?B?VE42cHREc1Fqc0lmZk93ek1Hd05keFg0UVk0UDZYaEVzNzBCOHM3VjRjeWZz?=
 =?utf-8?B?OU5kMjV1UzgyNFBhWHVOWUlnYW0veURZaVdhYTNxTnpyaWVKZ0V1dTZvUmJY?=
 =?utf-8?B?TlExWXBvL3lXQ0pWK3V1UmpxZ0xQZHlwOVJGS1BvL2FGY0pQN2Q5aVp6dnB1?=
 =?utf-8?B?d0RtMWJlc0wycFJNTnFTWlM3eVhVWFdDR0kxZ0xRRDdCKzhZVWVWOVkzOWJ2?=
 =?utf-8?B?WFREcm9uMnNSYVJOQlVRMVpjK1ZwZXJNQzJDaERKZjFNUTNDdXUwai81Mlp2?=
 =?utf-8?B?Q3gvenlZalpXOXFveHJjcGxYdUZHVWtQMVZqOXNkZWdVNm1YR000TEJOWEs5?=
 =?utf-8?B?cG8zbCtHVTdZOXRuMjZQU1dQVVRkMHBITkd5MXpqSjRQbys4U1NHVE9BQlNp?=
 =?utf-8?B?U0paTFBERHNWc21GdXE4bnlmVEtudmdBc05Fd1VkNDNjdjgwbU9rMjFnZjhP?=
 =?utf-8?B?SE1PQkVmaWJOMkJiQkZFTXAzdG16clp6S2tNdTcwRDRFdlgzMWNTNFhtV1RM?=
 =?utf-8?B?bUQ3Tmd1TXBSc2FUT3JvS0VYOU15cUZIQm5TUjd0L2JGTXQrYkNEUFJGMTlS?=
 =?utf-8?B?dmlWR1RsRzBtZmYyVzB3YlpGdFpKK0tnMy9VTi9yTnRIcllja3drdm04VG1Z?=
 =?utf-8?B?ZThaSEtjRXFyWGZlUnpDTDZ3STdXMEJ5aU9WSmt6czNXSnRCazVReERMLy82?=
 =?utf-8?B?S09OUnZLWUR2Q3cxdy9RRXhkWW9rdTVXYTlvQyswS2JTSmNXYUFhcFhwMTh5?=
 =?utf-8?B?UTBITm9Vd1NwV2YyWEppdjNuOWtwTHkwcHMrejZCbU1TMDJRTjl0RERUZjJa?=
 =?utf-8?B?Z29yQTNoR1hIUDFNYjVTMHkrM0FSMDZTdXhxNTdJQy9CaGFQMU53OTFhYWpm?=
 =?utf-8?B?ZXIxQ1ZJMDlGMU5xYjBpRzdsZkNEY09uWGZtbng3SGVEck5CaEdqQ1p2WlpK?=
 =?utf-8?B?cXVCWkVHQ3ZFT2VCSVpubzdibVpldDJTYnJDTUxtbGVDeGVmbmY4dHNudTNv?=
 =?utf-8?B?cjBEallzbFpTWjJIMWFQK25vaW8xdHNVTGMzZDVta1ZRZzU4RUgwLythdGI4?=
 =?utf-8?B?VzBTQWRTcjhFUFhRNWZtNytCVE1zWSt2c1ZCTzdRZjNvOHpMUUZVUEs5YzBG?=
 =?utf-8?B?c0xTMTMxRFdSbzFJQkhpWWNQYUFuZUtHOEVGenRnMERtWWJjTUJxaGpTSnJX?=
 =?utf-8?B?RTc5VTV5bmtzcTZ0NmZBRm5DVkU5cmkyaEk3RzE2ajkvWFVGbDJRS3kyRlVN?=
 =?utf-8?B?U1B4czRGRzFpU2JqUnBZbkZjQ05WNGlKU3ZBdVcrNDZVcUNxMy9HV1J0TXND?=
 =?utf-8?B?bDFQVjYrOTlCbmlwVUFveWVHaXBlVXdwd3ppNzl4bFIwd1orTlB0U0d2dzI5?=
 =?utf-8?B?QmJveGNSbW5xcGl6Y2lac00vM2JtcUVmRGIzT3RQMnE1Wk1hVkNnVXphalov?=
 =?utf-8?B?K1VnV2VJTVNJMEhESVV4SXFlMGtpSnJMK2FPM2pYa3Rsb0ZVWUZ1MG83VVhk?=
 =?utf-8?B?cmN6c25hK1lVeEo5Q2NNQmtzZjBCbm4wTVUwaC9lRC9nQlRwUEEvcTFaalBC?=
 =?utf-8?B?ZTZUK3pUVmIzOCtnRXdkUVBMRU1lN01RODBrS2h5RTBBSHkzK2RpZEEyQ0NF?=
 =?utf-8?B?d1FYZi9Fc0liU1dIUWRnL2dhUldxKzJsamt6eGpEM29ZSVd1SkFrMlZYa05k?=
 =?utf-8?B?bFVKL09weEQ1Qy9jTW8xUDlGcW5DaThnOUFwWDgwOHBwY2lXSU1kZnZmQWlp?=
 =?utf-8?B?Q2pjdlNJOVRZNC9obmZoZUllUHBqUVJBTE40WWcwNEVZLzBZNU8zeTJFbUta?=
 =?utf-8?B?NmRCZ3RFQW01SzJYVmcwbndoOE8vTGlsa09TRC9QTHJsb2tvWThPcDZSMzVI?=
 =?utf-8?B?cmtsVjlQQTQ3YTN0SDRDNE0yWXlhN0dZOUtJQjNLZnpvR2VIbjFxeHFsUWJP?=
 =?utf-8?B?RlhaNU1JcEZKVEdpVzBOd0JhOWJSd0xURnFCL1lRblQrVFVpcUp3T0ZJZnYw?=
 =?utf-8?B?WGxyM1FFZThwZ3lPZFpEc1VPbFlRZFpNWDRqSHNqVWFrdktWTWdjendlSFQw?=
 =?utf-8?B?OW5IQ2ZoN0s2eTVzSEtQWWZRRnhKbkpvQlgveWRzaHFWKy8zbW5rR3lHeWR6?=
 =?utf-8?B?aGlLZkE0ck96SXg3OHpQZWZyRXFnQUw2c3BTUjFNOVpjSC9idWpGbFFyaXdv?=
 =?utf-8?B?UHhvelg1MU9YZUVrYWVXaG1BZWNuTmkxOGVoU1UyQllHTGczUVJyVVFPVTQ1?=
 =?utf-8?B?UHBGY3JNcXU5UXZpUzh2ZVBtUGM4TnJlemJSdnlGSVd0eExXdUx3cFo0WVdt?=
 =?utf-8?Q?Zz714rwKZTGwcP+ysOde4JkcdBJ0nNdU7cNWr1Betkkyw?=
X-MS-Exchange-AntiSpam-MessageData-1: tOh51RHiOvV6Pw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32af6ab1-77cc-4601-8e35-08ded02b9c0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:05.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /625LHdd/CaV9wze+hRdzjSp4UiOxk8neYVOveE14IWNkHU6yZQoN8DqZ/oHzc6G3jvpLTZq+hkqJqxr476Scw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

The previous parsing of the iommu-map property assumed each context
device has its own one-length entry in the device tree. This has worked
fine so far, but on Tegra264 larger numbers of context devices are
usable, so it's better to support linear ranges as well.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/context.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index d50d41c20561..52ca663902ad 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -23,7 +23,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
 	struct device_node *node = host1x->dev->of_node;
 	struct host1x_memory_context *ctx;
-	unsigned int i;
+	unsigned int devs, i;
 	int err;
 
 	cdl->devs = NULL;
@@ -34,7 +34,16 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	if (err < 0)
 		return 0;
 
-	cdl->len = err / 4;
+	devs = 0;
+
+	for (i = 0; i < err / 4; i++) {
+		u32 length;
+
+		of_property_read_u32_index(node, "iommu-map", i * 4 + 3, &length);
+		devs += length;
+	}
+
+	cdl->len = devs;
 	cdl->devs = kzalloc_objs(*cdl->devs, cdl->len);
 	if (!cdl->devs)
 		return -ENOMEM;

-- 
2.53.0

