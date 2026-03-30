Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65B710D14B2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37DE10E226;
	Mon, 30 Mar 2026 13:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxF0AyjC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7F710E226
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qia19ncz6iw9s0SVwq5f/wJDt5cFdzugaKZnNY7XxIXtC6okKM+75ekzRAhJrXLvSuodXJB44qW4jOWO214MZ+2cJEjErqhw1AzQ9IJDHZk/Y3z9PugnD82y84XIaBCKZciAtlkhA11v7yonfHeGU4+m9daFZ5bQAOsxqqOhc7F6r4Vpvz6kfhAxmyoan0XT3F/BdiO1mJ7xB21TRPTwHYWkyvRK+8Bux0wjZfLVbv3AtIqBgxxdsaO0LCyNQ77snsAaHFEMLOmGaI7sK2K2RLnAKsE6LVNoh6SUTi2unF/lP/F3vcb0EMeAbWtrNGcdHxx/t8KgaVBqSVSD//64Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHu7oARcXqcT/LqkwGigPTk9t6jPyJrXft+ZJ+vmMcU=;
 b=PIqI7pGGerNGIADOHBzyw2gZhpJ163Afp9l2RdXgtBtjVu2glQADqUEIEkHAjBeTJjMzr0BoVUE5TXDeYgUaHPULtDPweFw/Wl9OIDyy6LSKcJcLGRYeO4Swkn4O6F2AwLJKv2vk/EXGMqkHITpn7Fn1MGkapnHm8FXnuGYsE2O/4yb2OEyH6bfTG4+1hnDu6xLikvyDjlhcU2u2wvmgGS/KeMvcR7zzn9a6yznN9ioh2SI/fp1E6oP36NOI8lAbAvV6hqi3OAcoAK+7X+knBufBxsUfce3Ow+yynSf+sRBNKpWfrCEzL9WEkg3A3XxTWbgwdHKger6D1YBXH17bJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHu7oARcXqcT/LqkwGigPTk9t6jPyJrXft+ZJ+vmMcU=;
 b=VxF0AyjCz20eZ7BjTxW+KL4CZbGsdT7D7vL4EinTpMlBnW1UzwYpRd1QRXCYm8vcYmyg4Ck6eBAqdBCy6lHD1K+rrhWOFYVMQiSZaBOURYl8GSCTw+F0cHNHGzP/ClfxJTW1SQ0lvvFRwzMrd4+lhErK4Afb6mgOZs2m6DySI/MlL+IlV/pRvhMa0eNRYJVQG+IhpT9wHrDwmFLd249xLhEyKU5phhURmOg1sVlIcX0kJ+1GR0qH9rL9APx5f8h2B1J1V4/+9z5pNVlV2b5cs+mbVaOAjm90z5yCqTWGxdAzC35+tlieSC1vpXekXwhvZ1Qb31kYgqe6RJDNAD0PKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:29:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:29:53 +0000
Date: Mon, 30 Mar 2026 10:29:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v2 PATCH 02/10] vfio/pci: Clean up DMABUFs before disabling
 function
Message-ID: <20260330132952.GS310919@nvidia.com>
References: <20260312184613.3710705-1-mattev@meta.com>
 <20260312184613.3710705-3-mattev@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312184613.3710705-3-mattev@meta.com>
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: d98875ad-2983-4e78-1a78-08de8e606cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: M9J/TwJwDqumeOSsPEFp5Nsf0kvZfyF2qux7T8afKKg8obGy3427UAX1cr/7IJ5tS2T//8ekDw7zwFWd0gh4Kuq/NDSkPrbbrD/PSBQr+pupPwE4MFx7aBVRA0zmNZhNHxXnzfU2Rf9IyvK+qF1pvV0cgyD+QqrVmjYtmhakacef+Gm2DNK4wbtnVp0T2Jnk4Ka4U7EE3DARflaGrMHjAjcyuNwYGsnRX6Kf9KbR7LB/nxinSKtXqHoGRdQ08ZVSxc/MbwOu3UR0ZcB9FhhD1pfmJci3iGMtkOOJrO0Q+0ZBg0ZmG8hmeY/NetRD7D3c7hmSXTcs9QtL2M5v8YYL3WbwvXB3Mh2avPR9L7hmmDhWVtXq1zDFP2V3vyYsRyxTcgPNx6woYmnHaWhZj8pELKawxZvV/VGzdJXTNcg5zAejB3mAkTtqAVhg6kBJW4hXfpW6dFAw45cGM2Z9Xa2N99eLS+0hXOzxNfpyH31fUV1crEFnZ/PbkIrptrPZiN+wSWKejgDKNj8gsvf2NjvEeMC8j6gLBZ8BILVXkQt9ymuNOggjpDg29KKmO6S9RASz2RBjNESSdNWbOnXDzdhqXjDk70WEsgf8f4uy8a9mbbEYd7pOFvkOe5xabbjE68Ce0cTQOxl5P+EdTjlxBWXkPDoHLUtHmHar9sdErcN0yOjHnWBvVMYQU2JRKl1vcanwGncnTxCeWWAaz2CophYbNS8t9QME6HOEJcIwzBacWWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOxcbMQ/YsRPetYIOFGHqp3+2LYxMnEcNC1plELL1pidwjvFV2j0YTC8ecoe?=
 =?us-ascii?Q?+D7MLYV2a69zdM/22dny9NK3eziPtiMIZlAtSkkMOeKTucxW1Q2x7Zo+iqwP?=
 =?us-ascii?Q?crI/g9jrfhvhnEmdpPmGvw1/NDt+j0oZJenRVLccWEKNNCjN2Y74fxehPY+t?=
 =?us-ascii?Q?JQbbZuJJ/hg5L3LOQ2vrB4Lb4HqjLCMl5gO4YnvPdTg0+207bkblJtchWxJm?=
 =?us-ascii?Q?uLC5q4UZ8aNeIVh+uUwAIvZWAp6yhuped2PwrFwcaQOogK1Hkjik8p6S99Rr?=
 =?us-ascii?Q?JT2mbcUKuTxkib7YPtuGAlr/b4Hl8CZbJ79r0ztDyGYUQ5YOB1RB6kGpyLR8?=
 =?us-ascii?Q?wKhQna/Mk8r2l1Ch6aB4S8k8fLXQkOZo/zJrY94Vrc05NilPaK0ejNFnqhQR?=
 =?us-ascii?Q?cBWA3n0ccMsOmF4ks7yZVZpP7c5LfR9NQZWsJ5n1SzWKy28l0KRFXiQm+t/H?=
 =?us-ascii?Q?quo5A9u4x7QrC+xXWQc+M0laNAeBSHzC6g75dyVBG1qHeFCg/aM3+b1VBJmY?=
 =?us-ascii?Q?DImNdU/YLREY/4V4A31etNBlQr/+uEoZvlTBg1LlhYQNeNu16RfZeYttmylO?=
 =?us-ascii?Q?D31kWgt/lLBM8+WVjbSiYm97qW16/fJGXDHPBWTDidWzXtxkEpmFDt6tvKPI?=
 =?us-ascii?Q?dhAMMoKMghcDfeQp7CYtT6LX+V63SnXWZdtzNhZrPCgz3lnaGV2Fj//s3T3F?=
 =?us-ascii?Q?hI9E9/PcPVAKBXMqoFIK5gdT3eeU6v3EpZjROVOMLqE7s3rkz3Lt1QXnoOmB?=
 =?us-ascii?Q?270kqMDUHqcVgZKCACzDBECqsgBKR6aWO5NZXPvZ36EtYhZipl7PELFtKSlH?=
 =?us-ascii?Q?F+2IgqkOMr58T1ck62zZzly5vO/nX5hhumqeX39WsiJ8qpoTvhZcU3EmGWbO?=
 =?us-ascii?Q?ZqpCFQ1Qh0ggY0yhdOPvcu6jVKdfW9qeu9kfI3sM5UMOllRrM6aZNCuynq6g?=
 =?us-ascii?Q?OXK66pgCf3PtoL709ZUvose05Q3nQMBiwFyFL6jbpJN3E01oVVAIWh1bIoQG?=
 =?us-ascii?Q?4hKQ3xnX6OyoElUMBK3uz7b6FUWZu/mKHiflm1yIfLOYOjeuiveA7HxeYMgu?=
 =?us-ascii?Q?T6WzYzMlxHSN5e+vZJFwKnptZJppi6SguLaSy5DyageB7s8OZMCzh0gtLHVd?=
 =?us-ascii?Q?c62ex1ml6801/MoClo4Nx0wG7+P5eJQoIUZouqYQuRqSeMh3VJiUNgLtKR1b?=
 =?us-ascii?Q?DtN2T+DLMwwgZWGMPQHJGPsjMohmHrqv8MzblTJa2e6TgsSyj5ykSUukf2vN?=
 =?us-ascii?Q?Yii+1Qjry2nl6ozhqJhoOkGAKc9i2kwXLklnTOjzMOHMjOWzuaW7tv1nxBaz?=
 =?us-ascii?Q?P1mhCPLvLnvoK+7NtHsKIktftZgDCqmL7YnucWSrbuERObnK9tc0sNNQvr7Q?=
 =?us-ascii?Q?Mzrt5mznQjdZ9pE6NYKe6hD+6tXz/plx7qvGZtWrjnnkHfXDu2KyGu2fA2uN?=
 =?us-ascii?Q?l4qV37mxTf5DkZ6JqktveiNLKrEvw7D/zDaJRnozXreNmKoSYeUlZiECX+Un?=
 =?us-ascii?Q?tKzXnziP/wjx9gtXnez1Ub3sLrU5S2xqkOqQyYYpi4zlO3KoPT16VImdpQ3L?=
 =?us-ascii?Q?fFiXGPRbeLY8lRoi9nyUGuSa8w46k9LHmmj4b/K4UwhxPeKTT2LqVISKMgwf?=
 =?us-ascii?Q?2Vw1h6EYpq5pWDwgu/mtDmCkMa9RuaNrJLbkFgjrgbm3ZxcgmzcOKl8nq2Yc?=
 =?us-ascii?Q?/y5jSn/mjzxk0G+nZaCJ9aRanjONuT2PjC9xRhPLmIxDGiUr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98875ad-2983-4e78-1a78-08de8e606cf0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:29:53.2019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Am+YZVIU4IPxKM8pjflYcF38Cbw36CioUFMhtac5/BkltjqmOAkxBLVoLK9LWxP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
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

On Thu, Mar 12, 2026 at 11:46:00AM -0700, Matt Evans wrote:
> On device shutdown, make vfio_pci_core_close_device() call
> vfio_pci_dma_buf_cleanup() before the function is disabled via
> vfio_pci_core_disable().  This ensures that all access via DMABUFs is
> revoked before the function's BARs become inaccessible.
> 
> This fixes an issue where, if the function is disabled first, a tiny
> window exists in which the function's MSE is cleared and yet BARs
> could still be accessed via the DMABUF.  The resources would also be
> freed and up for grabs by a different driver.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This seems like it should not be RFC and it should go to stable?

The normal mmaps are cleaned because they hold the file open while
they exist, dmabuf upends that and it does need zapping early.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
