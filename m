Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786D606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=GhJiDAN3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6210EBB6;
	Mon, 16 Nov 2026 14:50:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A2010EBB6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHVtjb3ZHHY6oucIbicnFj1oyru5cx6LpLGU85YDdUwVCARhmD4ByKpliN+Uu+RHgLgfR8dbDRdGZ8C16L70H4456+4ENIHq819mUP1tGB9Q5qY70o9AWG3VRHyBOuwLXg1parlX8OkvHBdyaWQM8jnr+nRHm0IGzSP4GQtWc5YqPl4imrewlzUIfMf6OecEd1EFzOF4slVOK+Lavh4KV9m+rtR0M7IGFcpI+frD8YPTNK5Mh++7BlDa3+bEJHSCkgR9YzekeATmH6iWejBfNC7PqTXg3dexd23x0XR4nUb4f8lwZF4EEDFXzvJqY7yPSm6DDCevmcP9Anp0vGU7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ8uTD6eEE3uSrpkf4GjmmY1uCzEAvBDY2W8EfMMRQ4=;
 b=S3LKKKYsIiW6s++WR7H2/DxygS9qNGsV+c9+bzdM5Da4AWn7aurCOD7sfxJRIUDffd/xHki135CJ0qkrjirSJmwUevs8Ab+5817rkhk2hos3kR2eigdFN7vmGGkbtv6xQqete2Xf4BNIdn13qRnM0orV6um8uC1DiysJRWMOTgb6jdyzjEomPqF5+9UgD+OmCx8Mokl8Vci4s1QV2ve3fXVRHT/WFhIBwvIcuCdMHU4Jk1Vj5n+ALlH41tMZd1Cor9728FPm6MeTwPY99+K2GavJ8QQ5XGzZqMPON7m1SmUmnKfkcCj6xt59qBjM3lFRT2jDiDFzNqpzxBZ4rmMMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ8uTD6eEE3uSrpkf4GjmmY1uCzEAvBDY2W8EfMMRQ4=;
 b=GhJiDAN3ZU7VzSRFtzFQ0OjieODbr7zLqu20IroDkz9uirmbNO8Y3K2xnJ9eeMIZTAbHaUXQvG43RUKshROWoBA7Y6KxyoY2YeC7DJ/U/oMKISvX/o8qI1hhGC1Lx0b1g47xSlqQ909oW4mM5Pw26AADz4MpMSVeyYMQIUvrsVXnqfT3a+frusMmcHFQy5R9phfTWkRetYzi/nW8MCqokO0/h8t87kmp6DKd73DD5e9JR88NWOTOfC47MydN0wIwtQ2epl8U73JBjVifszonVWvmllDSClsKyhOXIqLcfXVG7nmx82+G1yKMV2YFZog4UQtLwTjdLoKRzx6fa2YsUA==
Received: from DB8PR06CA0037.eurprd06.prod.outlook.com (2603:10a6:10:120::11)
 by DB5PR10MB7702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Mon, 16 Nov
 2026 14:50:10 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::1e) by DB8PR06CA0037.outlook.office365.com
 (2603:10a6:10:120::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 14:50:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 14:50:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:50:53 +0100
Received: from [10.252.28.159] (10.252.28.159) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:50:08 +0100
Message-ID: <dbb59c5f-145c-4544-a729-3e8baf261050@foss.st.com>
Date: Mon, 16 Nov 2026 15:50:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/64] drm/stm: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-35-0bb471f4d1e0@kernel.org>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-35-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|DB5PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: a07b84b9-9f70-4ac3-f29a-08df43f0e98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|4143699003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fUqMt1yWZazyHNLQRZ4vstEA1CaVhWWVLCb+NER/GAJdU/lKxKE9h+ACE0PA8Abs2wS7JUDuarqYwfqnUf2nwUNU2hW+hJvNQBCDq1HNzvU+vJLLGxl265DWogNAgBG9O2SXar0TImjxP9zT64Bt4yRyCy9y3OfTVwOHoKu8dJ+Jh/VFSH3wUMU4wMWajT9Ky/dMBU3MGDXB9L8obnq09QmIKtQdXYc/WqNURAz9DJVGpaCCsn1pTVso8latBsusYwnY7ds1aE5fC6iaH9IBC1BGTBx3cj46Dntf6daTVMbR8aizcTmmVe3bB/T8GoXI+AJjDGuKXsB56k4Ko+8nxwAR41K6VI/mQU/pP20XICUZiXZB7geD4QIt7QTX1iGpY5+w3whSii4ZCSfLPjuJ4UNgVt5ccNa7d2xZi4zr4Rkg1KprQKwbZzIkGmYdITpeO0NiO1345yjwGhmSkqPkByqkwBeHlsRDMK72hvY3Af51oJYBCIPr56TXqyf2Y0Ko8aZDON/bTjVGsgLgnoHP6MpPcg8BcIoobaOnkrpPDRjxARl2LFpT94FDrb6USwZUTfchuSdnPNz8ENmKXDgNBjziOB/CCRszuWKVJh9Ew4yTYKJ7BbaIuZg7QP2f5a/lIFQQjkKgB4nuR7Mqhpw+4BVf4P1Vf2zMFGRyZ+F0IOtmfCxydTFavQRQpMNzvtUReEk001c8/BmYhgboO2r1zg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OgHWs6yh3HACz1V1LLksA9ilTE5ln6iMhjFITaqYEQmA9J5hWOZ8WGJNtEt+d7YhsHPMklHzTHz/ep+pFYYfWtD83buLIZRT82qrlDepA/xsAJ8FzUSl6zKSViNoxU3m5NVXxknBd7aUmNZJt53kCbrTLYTv5sBNKDI9qtUe+Woo6+LSCfYQPvq1hX6SVwmzhI1l/cSZa52IkCuplaL7oz+tG0ELOghBpo+QnLyEAUR/tx43BoDKHxJRz4psflipwwoh5UutUV0kVmoKsnlLpM12x8DxfT4y/Wei5ua6hicG4NX+klYGqlrP2NOSnyjKyhEC5oJPJLAm/Xjik9Ze7Z35ElPrryhjAWeAegPhEGOzjEThagBDIWSnHDSgpVMUSbpNqsTynJ09WJtMugc8HV8vjbhlZ0aApQqhWU0c17CuXtCdqSu6vuVbvcho4WK8
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:50:09.8120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07b84b9-9f70-4ac3-f29a-08df43f0e98a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7702
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 11:30, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Hi Maxime, 

Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks, 
Best regards, 
Raphaël
