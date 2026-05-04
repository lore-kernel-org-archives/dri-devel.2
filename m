Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE4FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CAB10E0FF;
	Mon,  4 May 2026 07:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qioONi+3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698A610E0FF
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcuWcJ97t1ZTkUX465tIo9Ris10losQJTRiyc8tA+ZYCjx9kP7wfgSsQxAbmUzE7SL9rydgmhFKLH6xTXKJu8dBGhoCu4kvHhndwlU/tDLqavBxHjx/siqpN53bdNQ1pDouPRcpngWhd56EzOVKnvcO+ucF6TlXvduu6cUJlmDOhH+ZDkn/nOvJrK0cmP+pBx7cfne5x8ykN+Vmjlwve3bgaP4hAj+9pZyRdEbHcKCPiDlpIb7Z5eVyio3/J/RYkEaj6bqV664yh0p5DNpXDyUqUhCaiQNpeeqV+ay6KmaY8crM+q6POY0rbkq1PSw6CrO/VALC9DxQaibAcj0V/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krvXVQcErdCDEWHMjORKXrYhnS33piyJupCz6aIIGxk=;
 b=k8ZWuMdwtjZTuIPMi+x1PNLbrj/iHfLicSLmN78NoxzFRwgVh8Bqd0EpTu4CzSOw/Hby7QlaGlmofQNyAWLM6X/RxdhJe4Nzgvs7TDrPPrszToPz5EBClP8We7bkTkBBMKYmsN1Hw2T41RUd6QuAeGFN4j3O3iHuMEO8YK/XhE5aNB3BlHcgJzWwlxQ5lO6ffmqfyf0JvNfvghLgrlPhoG8lBO5xp7eS2g8MGN2NB0919hzHIR38icVtqBaLuGcrTxr9ylkX9qnESU72xVNuEa9frp2pJsaEmzjXLk599wsuO7caOwnEw4t+ZRaZs3ZnjueZEX5Qj+TIE5ih+TzAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krvXVQcErdCDEWHMjORKXrYhnS33piyJupCz6aIIGxk=;
 b=qioONi+3aQBkkzOjn8Hq3y+Cde36vC9yyFSZh4xyovcv90+WwtMQhuHR1Qem+CsbkhBtRFEn/7O3OfiKvmZrJ+rKY9pELB18YqKW8Vfwku129qqIqBiOuJYBuMlC+mbW1V6FTz4a/YJ5fQNVw79nTRfheTS+dnrVXnQwg6G6HhX8xOPkTmz5TNISGCCqj0AP/rjH4aSOAh4lnIG7/Z33YdeEd0WFO12/J3s9+iLWX4ByeYDJNmwXI9u7ei4Gyss20uErhc3ljTfXPE9e5GjWPV3jhWELshLak9PRzPs7CeQ13IEBdRJUaog2yfc1VAiE6vvt4z+EgJAWMa5SFU5lqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB999077.namprd12.prod.outlook.com (2603:10b6:8:2f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:40:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:40:44 +0000
Date: Mon, 4 May 2026 04:40:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <afhNeYS174EW7RYp@nvidia.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-5-mattev@meta.com>
 <20260501161915.75525c15@shazbot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501161915.75525c15@shazbot.org>
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB999077:EE_
X-MS-Office365-Filtering-Correlation-Id: 375d09ab-e1fe-46d2-e728-08dea9b072f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: c95MchyQmwVVLh1Dw89K5VCajggiv0/Z9Y5cPdfHeJQezVhwof/+YL/REyTsbBZgdUfBFZGwfgLvr+iapY35oMiWIk6iGc52fFc0pBNddcIt42rKn50NprdJTYo5z09IWAEm06qbfh0MS63UMAFhqS6rFL7jO7EfEfkW2hO7MOJVYcI4oB8TyUnxHJ3fge3/jf+yRVjpaFBtQhEwXhmLTsTCuQJXJymWlNqOqQd/zY/3BfciRV1VaXQpbaiB+ZfFJjMTaync93H1mESqdPquZSnBxtAiufN5MdJwenqG6gaf/j/FYrHm1LXNXtOMrEGrDeYmqPr8XE+/09h4JXJluL1LZfmKIOzcS3g/j0kUTtGr3qGK7Wa6lJIql2/yaU2XnPOzjQEePfaHRXlh8fsufXIiGjzwfYlxG3im8RZ5MrgD2viFf14jMyKqp2m4or/qRuGiwNbx024JPTT7XYHRl7DAATSnBC7VIAhv8dyVAoKvS7MDCR0VZ2dARS6uriZmMaolcYgIySmRRIKeN8dsKfdDnGQQF2uOHczo//iUfvN4Pi1yLUyzPSGOKmjmaY2chli5TI0DSa9r5zwJ9i5HaXcAEirHShJoBrDd8urVtyJ+WnYSh8TW+U7RMtvnmPgbh7TeEtBv7NCKArNqkMPFTHZNK3vZ2T7bV28HTaB9ipVgAHzhZTq1QSoNjzEhBhAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiUYDpu2MLrcLXQfvWdTHXEJh2bcJ7ppFkH/5ibdlrM3XaIk5U1LyUMaAis+?=
 =?us-ascii?Q?atweZ8cBLedrWkPdRu41XO7IndHpKnxdVURtCWz/NbhH7mpkWEaSBHSwWC+t?=
 =?us-ascii?Q?ZgiKhDLX6lj6lvIW2BbudssS6k1wWUJOGS4FMegPtPlXvfhny+RwgQ3dIgPI?=
 =?us-ascii?Q?fsZp8B6hBbX73L2YeYts8UrxL+bFAIcqN03HMg4M8i1w7uXN3AKW51ySGROI?=
 =?us-ascii?Q?cgsYhrJ2Gvms1r0iohtl2THfijIkCl61qSNRoBVttZO5l8lotpYMGRLoQmi5?=
 =?us-ascii?Q?minEAUcWTxxZoTYwd0w1IAXT1ZvT4bBztkArOpNQPINH36m1dNiiZYZ9QZYM?=
 =?us-ascii?Q?xHOUq9E7prLzjjqcssmo8si/IUlP51+1X0SMPIwiUV/Q/dEcraPNw5dc5E4K?=
 =?us-ascii?Q?V66/PWP5fcOrBTIMTKgv5Ve78E/7z5Wa7etnXfAc6Vy1PQeuJS5u0XITVMP9?=
 =?us-ascii?Q?JJcdeQklkZV3w1agiCiOK3aHGt2G/mHWzwVyS4c/pNm5Z1SLfEL6gqDFzBNo?=
 =?us-ascii?Q?TAMYYiZGH+6+WNPxyHnXLKZy9+nj3D2nDTohhQB60Ym4UL4/8rGNUoxrTXoo?=
 =?us-ascii?Q?hf32UNhpGuC/muIRCQiI1aMUFUfjZIYqCUOo4d5vcC15XgaW2UUyUc1hLeIt?=
 =?us-ascii?Q?9aW1xydQJ1u+086j5Y8EoJxNLRpiZ4sOqMFF3KVf72bxXehfJAEGpD+zi6Gy?=
 =?us-ascii?Q?6ILFgHvNyqJ5Mf5zPGdNv87U+fM5m7sONMEs09EpvC1V79t2hjY26nILEsu7?=
 =?us-ascii?Q?AK+o0QQVMptvJwtmhFo59Ia+Ta1zJNfWQaoAdARlMDyISVLgDkHTzj7VZoVq?=
 =?us-ascii?Q?9GP0Nwf1ZgM445GiFHGg06DiGRy+R5D8hMdVvDuAlzl7jjiV2RZQiM/q9cZJ?=
 =?us-ascii?Q?nxrtDqvlxj/xHJvINLBksgCqVRRD+oxsIvOdRcsOx2PjsUckgzm5AGIlv6Bj?=
 =?us-ascii?Q?7oTAc0UtOozmZ3MlawIRQfkXkBTky0D7T4rBW5mv3TC4yNl7GvcXPXAkZNIO?=
 =?us-ascii?Q?Dmn0SCGC2rLCfGRP7CQbRKYdvL1MKwO6ZGlo93M1Di1Nr5/GndreI5IHeUSt?=
 =?us-ascii?Q?+GdOcwi06pX3mNgmYWMM6lVsQBHSqPxC45yMZrNC8itWAesi0G76+YqFLknQ?=
 =?us-ascii?Q?z+TFt6268lwesHlEPdbvJ7FTsFRKzuh9dA94sPg4B6uyBUAurcs7TTTZwPHj?=
 =?us-ascii?Q?8wP15hOaxieaW6gfLNaIIPefr2/R3ghjXGUbmId08qpw/yi/GM34c3ZGWzW7?=
 =?us-ascii?Q?K5QxV00EHlJD7V1RlzalksSjlrWYDa2wHwiEeI/m/pUjvKNnse/a3/RpFfI6?=
 =?us-ascii?Q?ySmx/1Iqo3+fLSPxpUrJKIMFxuQ/XIuDJFKSysbBrSrY93MSmOmhq3s60xO8?=
 =?us-ascii?Q?uiFHwYUeBJI8nBHcPhrzNVc7sURfSPoAVyyuxQUYwH3jbGNQZLqWS2EMtI5W?=
 =?us-ascii?Q?NNK+w2tbXhlrqkkKzp7Aagn1pNO9pKTSlqr9bsQzkDBi6mxy12f7viQrwE+W?=
 =?us-ascii?Q?pQn7jcIqri/w/7Ffzy//YPbknnWIlxd21yMNbvLJOw9VYvY8r59KJLJGykS9?=
 =?us-ascii?Q?Tg1oFlqREdxakioAHYsTNakQ1Aw9vApCYGGFC0zI7+Ru69fycH8AuwFqX1jd?=
 =?us-ascii?Q?xiC823vlTh1RMdmbbcUPZ2tl4C+tSSmNJAPzB+S0jndsZ6wTFEhBVwdPcKpw?=
 =?us-ascii?Q?MdzcDpVYsWVQfKgoU+j/PzrXtW8l7zhA5QZnUvfwfF2r5RHd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375d09ab-e1fe-46d2-e728-08dea9b072f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:40:44.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ilseAvqKxdSrI4XHuDDfA/BX2q1G9PTEfqdEZ90CVgKOcSV1z3ot6Vci2qvzWYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999077
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

On Fri, May 01, 2026 at 04:19:15PM -0600, Alex Williamson wrote:

> Exporting dma-bufs from vfio-pci is a feature, but mmap of MMIO BARs is
> a legacy requirement.  That legacy requirement now depends on
> PCI_P2PDMA, which depends on 64BIT and ZONE_DEVICE.

That should be split up now, Leon missed it when he added the new
APIs that didn't require ZONE_DEVICE..

> ZONE_DEVICE is harder, it seems like it's possible there could be
> minimal 64-bit custom kernel configs where vfio-pci currently works
> without ZONE_DEVICE.

Several VFIO using arches cannot tolerate ZONE_DEVICE, IIRC, so we
must avoid that dependency.

I think if we clean up the kconfig for p2p so it is always available
it would be no problem to keep this patch relying on it, but that
needs to either be done in this series or before it

Jason
