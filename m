Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04CACD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3572510E6B8;
	Mon, 22 Jun 2026 13:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZ85UM/m";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF55810E6B8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8m9G8iaL1wicCSG0CWcx8TbPT9BW4dCWztfvX43BXzDqaezXSJ7vHyozYgXkq5O8QiUI8EY6zZQA0+3gZdEWLgTU+Po39Ts2fubCot+QJawObwUtTusE+AOGOkSyXcLwEKsrWm+q9tV2xWoVDKbkukLYj7zEsgpzv3q10HP/ivZPaumbnnQCR7SgDHnLKv7f0tf+C9PNB5q1GxiKntj0Z/73qgaqj1/r4DzCnMMERyL9WXdewg7QWlNUr4PUfPDy0kTi/EmPx5XhWqw3+0uDRfjk4UdR0+Nj9Bx+hkmW6M2KUGSKHU7FHJ6LRwsp3Y5XG0odDCgk70/TaHFrpuCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTIa/kru1L/XvXYxYtyWtZA5qpwPLdlr/Eye9w4HTis=;
 b=fZSCowifRtk8hGdcmdXKEYatrFlUe1oe5UQmNGI/HV5gu5aebpIR9IIR18smQZQc3miT7SQsZ27q9JlvMVdx+ipoOpmlZWwcW8RZGjJNRZ4hd1/i5dBB9su3wZKjKoRHKMxvtLNSUtl/yCZAp6GQNP03mWNDHSPLiJGLRB9za8aayyedMDcWzyUYFqEsbNtLZl1tJm1HP7aHObcgW90FVUlXd7x+OUqVHLo7G19Mqh9k/lGnmMAeXqawiF6kW6ySpCIrxEzCQcPHWsuEqmzMV3Dd97vgi81RI2PoMv41F51+Go863CJeXOhLws12ni2IPdDm+ZrsObS+aEkTsJJIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTIa/kru1L/XvXYxYtyWtZA5qpwPLdlr/Eye9w4HTis=;
 b=VZ85UM/mJFNw2iv+TQiqoEOKu1OBcgA8hGLeaiBYIxBvCP6xMxsRlsx0kYTmN+N+GCw1bg7+p24WEoo6Epb6GU6P7ksHLccL1g6WAhcK5LXbRM8xkhdVZ1+w8DjGpXQhs0RFK9qYrQ4RzT5H8M5NwTB1ncRyjNxrTfNs1FG5/pessNEyaT0/yJqfHHbXl0q26VKz34FAtWaz0fMBaAvFVjnvXbQd3hXYAx5WYBbDfqoeJHw4gMBM+WwGAATFpjdlwa/QnGIdvgZLVez3oIVODreD4a8lw5vEgZVWfCD1d5DLP8j+MaPSLQtZsK1UVPCi8oVcEUySTW8IQSKoPlZhaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 13:13:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 13:13:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 22:13:25 +0900
Subject: [PATCH] drm/gem/shmem: fix documentation of
 __drm_gem_shmem_free_sgt_locked
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-gem_shmem_free_doc-v1-1-85496c597b18@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMj3SQT3fTU3PjijFwgmVaUmhqfkp+sa5aSYmKRZmmeDKSUgHoLilL
 TMivA5kbHQvjFpUlZqcklIMOUamsBu0+II3kAAAA=
X-Change-ID: 20260622-b4-gem_shmem_free_doc-6dd48f97cd48
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6PR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c9c8ac-a3c3-43fc-1db1-08ded0601123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +S1j7B9ghJfu3VArCFiP2dd8iSPz54Pap29+CoAaSBRnEPC1VkxtbxuPCKYwrcTHmRxGMCYHYSTQXUpVh85pF3vxoNm5zB2WJSrYs/LlbeLQqPSSPATx3LJLTtyIwfIfSq+pXKUkvdXVWgBS+BCXNCXfKLil74bzHro1WhABGfD5bUUlyjQzqsSZxEQN61AYBX/RnlolsMfHNzgSpWMsdaLuaivn0X/4uLK9hXPBflDvdOY+h3SSNp5damfsQG6Smqk3CaJL2gD7NCN1prwtaipprJsM4qjQEHEbTjOhd8Gm9bWBRvJ3jPe07MtJxEusb+p+ZfWt2+Rhlc1EnNge8EZk+qLZkUaVW6crBO8CdizySBhE76USiwKAJjkGHV6aluNHIaUb4KZkF6Hx+5stBU3ixJj4jVdx/I57ANHTc7/MxUNa+Eug3yvzmJpSkVof63tnYxYvBF5rM59cJTevmVrmL+iG18x45KjiJBYgcHYwPbQ4BtaJxUCWwWu2c2junrM/xrP/yikjVszDeOai+K7J4/R7vb4mX6zQ1ZzhbLqbmIKWFssc83dSQOO33CFkPhZ//Z+FJxwO+WLhC6Z6drafchkjM6EKXkQsKMLRpbiM+0V3aAWDFjpSV+Ka9olny9G6JNnF3LYa4qZhHt2WPHldQeNO5cHt2oZU0aYIqrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlYRXZmVVAyRkIwM25jY2VENXpvYlNLYWNOL2xHbWlnVlRjSFlVS1ByLzIv?=
 =?utf-8?B?R1ErZTNIT1FEWVRGV0VaazZSWS9Td0NRYzZteFhzRHlIYlBKK2d4L1F4N1ZM?=
 =?utf-8?B?UUdTaWRuYzlENVZUZy9KWnhVOWhOYnJmWG91TVJ0S0hkUmdzMkIvcmdsUnRo?=
 =?utf-8?B?SnhHUjQ5TVFQTExFWHZJMjlUbXp5NXdFcmNRT1J2TkE4enB1RWpzMVpUbjBQ?=
 =?utf-8?B?NkNCOG5zdm1NL3RZL1BxSlk0cGt4R1kxWDdJdEdKUVhCTXdYMmY3VWU3ZUQx?=
 =?utf-8?B?TXRheS9EWGFJV0pGZHdkczFORDRDakkyRUsxcVdXVm5yUENLL3plSWN0cFU2?=
 =?utf-8?B?NTVmR0QzQWdzV0V2QU1xSjdNWkVlRytvVUFvNmJ1MHJyZ0J1TWhpYWo3dzlx?=
 =?utf-8?B?SDJHOXA2SWJjUnJSRURHTHNQSldoUEpDcE5oMTk2UVRDK3NaTnVXVFFmOUxN?=
 =?utf-8?B?MXRYdFJLT0VoSVdYWmlzMjJWWjFTU2FqSkkrKzRYMHJpK0prZEY4cGhFSVhw?=
 =?utf-8?B?VU9zWFVPWEJBSDR3eVJNV2VMYm9ZQkNlbXhXdjBjQ0h4UW1NRnVyajFSUDBz?=
 =?utf-8?B?N1VYOXZhc0pOcVBha1BzeU1HeGI4NmZEeGNFc1BSanczSG9YZ0greEZMcFI1?=
 =?utf-8?B?aXJkaVI1blJnd3A5OFd2Z1R3NlAvWGp3eURGbU8yMWphcTljcXdrWEFKejl0?=
 =?utf-8?B?U1FDazk1TGFhQ3BEZTdsb0NBSjJ6TTRTQXZzNy95K1Q0UXJ4dWFOQ1VSZFdD?=
 =?utf-8?B?UVdSMkg2bDlWVFlxWDlGSlRFNHo1UHRhdW5VRE5lbG1makw2QkZ1K0pKSW5q?=
 =?utf-8?B?Z2J4cGdGTnNOcWJ0cVpvdnRkbXhOQjI0MXlLRkptUTdUUnNVZFN1OCtlSmVX?=
 =?utf-8?B?WGxuQjQxMHpnd1VlU0Q0L2l6VWF1Ykttd3lrd0t0VXlKSHowQ2V5TFE4OTNT?=
 =?utf-8?B?SHJja05JQktiaThPU0hBUll5Y1MwTE5BT0V1SnRhTlR6dGw1Mk1NT2pHczJX?=
 =?utf-8?B?ODRSaUQvVllsK3FPWmtqNlAwTUUrR0xkbzY4Q0xpeW5ManMxYmhwVDNEWGt4?=
 =?utf-8?B?ZHBUbHZBYmVIdFFVOVRLc3ZNV2pRSUUzQ1pZZUlYVExVNjJpRGphK1VBMWhM?=
 =?utf-8?B?YjU5ZitTRnJVdFQ3TE9kd0hINlQ4NjVwdktmOXFIUFhpQ2MvdU1ubHdpZjBW?=
 =?utf-8?B?aDZOTnhiV3ZjNjBsVGg3bEdKV1hyamxaTlY4WU1HeVUwSUtkaGYzQzd6Y3JZ?=
 =?utf-8?B?N1RjeWwvR0JITlF6YUxHRS9NeWJQRzduZWc4VWNESDBmVklxMlQ3MWZrUERB?=
 =?utf-8?B?UWo0M3dEMXQ5ZTVxZG51MjNSR2FuK2hKbkVLSk5HLzI5REVubmo0RWNyWEFC?=
 =?utf-8?B?WW9TbzRuNVB6RXE3RjZtNGVUUnVIMVhNRFMrVVBBY1dYLzdLd0tlRzlkRXNV?=
 =?utf-8?B?Z1RQNUNRTlJubDVoSzR0em02LzVKREtiZ0kwZGlmOW1xbmE3bWpTOCs4bDAx?=
 =?utf-8?B?T1drU0pGbWF6R3hwYnFRSzI0SWdoaXM2QmM0dGluRTNvR1lsVmVOUFFVZjMv?=
 =?utf-8?B?aU85eEpCVlhHMS9pcEVuV0hBdWlHUXZkM29SZnJPZlhSaHF4ZXpCc1lIekVn?=
 =?utf-8?B?QzUwNkJYOG5qamNITWE4T3FyMHl5Z0x5ZDJTU05rOFFSM2VLazBQN2lWeXNB?=
 =?utf-8?B?NGlzQ1drbi9hSm1JMUJIbWdQcHd3amNnY3pXbVlzOVVjMytvdzJ0dXNUQ011?=
 =?utf-8?B?M1c0VnZkb1pHcm56eFMrZWlRekdYMXh6VVR2WXRjcHZSRTJSSS9nR1lqMC96?=
 =?utf-8?B?TzFCSTgvbjIwblFwVFFvbUwwRzhjYUN4UEMyalhPQmF2aUZsdVR5VldpbTAr?=
 =?utf-8?B?OE1JRnRZdHhIRDdKQ05DVzl4OVc1TVp6d2REckhyRkFvOGVTV2JyS3dDdVQ3?=
 =?utf-8?B?K1B2V04rSnpWdko0aSsxVWVuMFlhWFBGL2R1VCtmNS9HVnJXeVV2TVFFNlBK?=
 =?utf-8?B?WFdqNEhwTmRUVDdqS2NiQ0F4dFI2QkRrUWhwOVkvS09IUnFqbjRFUWgxdHN0?=
 =?utf-8?B?Y1dLVnVKLzBkNHVZS1A5NkduUFV5L0FuRElXZU5PSFMwcmVjeWUyWktxQnRr?=
 =?utf-8?B?T0VmWkg3c1NwTUZTZ2tWSXExWXB3Q0NCdnlSSW1NMTVHMFcvTG0vV2U2bU53?=
 =?utf-8?B?cnB3VzdpaXZKb3FrVnJYd3ZHL2tKRGVmdVc1djZVdmN4d0JFY3FCMTJ0NlM4?=
 =?utf-8?B?ZE5LZTV3SzlFc2JpYmc0dkU1SW1Rb083bFJqRlNBbUVkZnBOY1EyWnhlUHdI?=
 =?utf-8?B?L1BMZjYzTFhrMmxoSCtNNlBnMURxdjdzak5QZ2ZWNnRRQW5US3kvNmJDdVV5?=
 =?utf-8?Q?0G7fyQ3YV5X6Ni9nZvoGHen00jIibCwP/8oQsX11GGNLS?=
X-MS-Exchange-AntiSpam-MessageData-1: mbVMSYefGtbpnA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c9c8ac-a3c3-43fc-1db1-08ded0601123
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:13:35.8537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E25TB8yIUZmEs9jB40zPrT1VVE9UF9ICCSOP8Jdb+wNPwh7MmKyl+1hPm1ooywhhpF0SUiP3BufkexsjrZ95+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

The kernel-doc comment for __drm_gem_shmem_free_sgt_locked erroneously
mentions __drm_gem_shmem_release_sgt_locked, triggering the following
warning when building with W=e:

    Warning: drivers/gpu/drm/drm_gem_shmem_helper.c:174 expecting prototype for __drm_gem_shmem_release_sgt_locked(). Prototype was for __drm_gem_shmem_free_sgt_locked() instead

Fixes: b78dab829760 ("drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_locked()")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..6319fe44a2da 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -159,7 +159,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
 /**
- * __drm_gem_shmem_release_sgt_locked - Unpin and DMA unmap pages, and release the
+ * __drm_gem_shmem_free_sgt_locked - Unpin and DMA unmap pages, and release the
  * cached scatter/gather table for an shmem GEM object.
  * @shmem: shmem GEM object
  *

---
base-commit: f0c1bb8ead8a9790e7d0339354598b50a9c6789a
change-id: 20260622-b4-gem_shmem_free_doc-6dd48f97cd48

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

