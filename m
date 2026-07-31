Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D038AC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2106510E180;
	Fri, 31 Jul 2026 06:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXFTobbb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89AB10E180
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmfilMlEUs9PMLHqjcJhyMrGbLlwZN7QnBgrJfY3ZcnQqx32gVdglJa7kTO+lmZpiZz1+FpjyjHyJXw9JLu19A0NU7edalAjFlh+01y1MBlCpqKCM1v34RJ73t0R1wJb2WhKOeH0FEyCM4eQ39WK/S+ViXzhNxdz8jYTRGGlQ+1hhJH5Ak6yHXNCzEXOr99p1txIC2FFeg+RgwReqKHin7nfZOySDS91NzX1XdiSC3Yw2t84cEiqcK5ZqNgooq+TbD3pM80rDdUvTY8eyYWujLSad+HJkHAzpNYd3V9dEuI2o/uLY0pr4ZhJ2J3C3PjB1Btgl7iq7EPSL37otLWHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJQzdZJF5Iinyl3bBrd7ImhLtdjRu89bFvM5SmT+BKA=;
 b=bQOdjj/+pqnWk5bhdh6XxtoHQxAJAIg+KSjgRryD42cq2ZS75CGwkpMgV8WyIA52HaLGo4KLRZtl3wL0SPOptW+3GtF7CDP/htcIIgG9l4Kv8BtjXivWpBRpWbfwQar2VTLDwW0ES6dEjxxSifOok3rbuFV54yfgVp5T/4ooZlY7HOk29HvJh32JaIIej/50EKNiFsB67BEESHeS5tCnWsLQqP57JFqig1wRq0rTffCtfdZWp9eu2/6WZQvmVI7//lwUIX9fOsooPoKjIgjkX2AbkZy6jdDsQuiEiAXShdu17m6+1GQTjpdPgeybVAhMhJlXkwauMO8FyCUSSdYstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJQzdZJF5Iinyl3bBrd7ImhLtdjRu89bFvM5SmT+BKA=;
 b=XXFTobbb7hEoBoOuWBgbmV/kvGedKee9Ws3GwKOcwttaiNjQN1fXePxxQlhnAMfLd8LlyFnCpPmHtqwiW4ybT3kIw1cNCLWCtlJFURUb6NPEpmVyMlEWbODqOY7T4Mr6oINFE+W6R6v1zcRGMV5YiLiACZSfJMyCDFlyFOGXx7J2J3auaVF07T+/rg+wiSUbHK020gLuwF4SPpvKNpdY72sEe1kx0v6yst7jfcYRgqnOhVIzLkmSIShb7rw2IhqguPOQQRXDZ2POFVXBedfMjaqYnL9fW1sZ1d510WXRKRHIehndNhgNptc+8KGa91XjvnpIjoWMEgC+rGs87mvmwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 06:04:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:04:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: nova-gpu@lists.linux.dev, jhubbard@nvidia.com,
 Alistair Popple <apopple@nvidia.com>
Subject: [PATCH libdrm 0/2] Add libdrm support for auxbus devices
Date: Fri, 31 Jul 2026 16:04:13 +1000
Message-ID: <20260731060416.1400253-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d11459-251b-4530-79f0-08deeec99b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: P8amDWTAU9L0KYp1nwutS3Q0JoGSjp2lvo1PUv9uPLsv1xw2hvT8rFOJrqQOcRIOAV8i0Gxa+7VQYg2dMdSGBiMjvN5wIdQXbKmLrqxvzo1xqpy2ghkmx2s1eDSDdCBi0QkYG1aFiJ5OGEojSVAgZsHnq5Pl3OR5RQ9LZV0pscR0s79YnvAiu/LCck9VOcniU8BXvmAK2eqvVOpNiq6eP9sygTcEwZS46E75uqGVaNqzEQrNPsF7HWcvTquamkdDCtSUe31Pb/iXdp7MWmZdTtmLF5GRwe9RPQzmjZINKzxtI54joKkjgA3R5RKv3AXD4d089FUQfpPrIbiJ5dxCIHOSl2wU36kfmU+AFGKm/sC+q2m5xRgkqDKsDhyzv+dpK+LtHbvoNGyckCjznqDgoPXGewWng1TVhoXmEi2oNJKRm28higM2pd7ZRGmRjTxtPYRCvk7fRmD5AdSj/Ih2zLJOue1fastfUg/buzwAP+pJDP5MFegH8k5L7osmJGxGaOy3stVrNc8UhUK7OZ9sGVEw/IHDdOnoCauDtXX3ayxfy21lPT1vJWYz7CLRuZu/T0k2VxJGZ2KcRMCMeyZbsimSCNU4GL0O+1iMiSpue9P4IfvpSd1L4y9OtsOpRfuHOsJbNXxBSMslCsUmJ+LO0CjGp8ltGtiYuF9NsazdVFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58x056c4M9egU2QKrJR3eqX/dnRh5R2Qi+Ye/eXwB0vDq6VOKlcH3jFHTxxI?=
 =?us-ascii?Q?8yTfqbb0/TEDBz2o2WjuAYhxVofF0WqGirsAylheppBX0GTOMrkiVjTkTRlZ?=
 =?us-ascii?Q?HSNL6NHInSFjoarwgCWR+DcxLTvIQ90suCXLanKpsm5c4P/5x597bwRbTbLt?=
 =?us-ascii?Q?l2kjHBhuNesEgspuDy9r4p6wSZMII7vPDqYIuqjAc3lirWJApkeOWyjh0CDY?=
 =?us-ascii?Q?33Vuz0P4/N1DvZctwFleZarTQ0uoWiGZQDA3WCggx+RHEdAVhwzMweYvOuH7?=
 =?us-ascii?Q?GbgRt9LsB+UHjmYwWfGPNMaUatQoey6wyBfA6LHXV98ueyGOcMyzqPCfJSkL?=
 =?us-ascii?Q?HkneSDsmism0r+k25xuI8Q2y2qm4sbiCJpPHFeSnUsHvezDWQe5bC7wssc4q?=
 =?us-ascii?Q?esxnyYx+GUV2/BimenxaeE1etKH3GO0pIJGpj4wlEYh/cKXKrIJhbEe6E3NY?=
 =?us-ascii?Q?PqqL4P1+w/cegYepqOITRaCOVEieS26B13MFV8YJPOoya9BAo5t+kIJNuDdz?=
 =?us-ascii?Q?SyiZ+NhPkr2s2Rsl5zhuNu9fJ/OuCQyxnGS8V4yNzrAfFrTGZ7ZnFEVej7jY?=
 =?us-ascii?Q?1EFBTz5Lca5y/A63DCk4ukUNSFjwZdt8EFpfkFT1ysKquRto64HvY0Pu5zps?=
 =?us-ascii?Q?76M9sFi/vxXh8UBc5ruTQXjMBNLoVhTfWGHIcExbsp+MgqUP2G4ESyga84q5?=
 =?us-ascii?Q?miZwXJpRgRVxJzw5m46MKDlDUrwC9lshvdSnsEmcv+hmG1Mhzwy1b2BUDqBG?=
 =?us-ascii?Q?O3k0W213Z35aI2GvGDWaEjvyx+NakJWPTZQuzMZoKuC7iyB4URz0ZTsPUGPX?=
 =?us-ascii?Q?hY73IvcyOpJqHUNuF0JBfmCcM0t4fN1RXUS6PxqmB7tyhtPsnqxO8UxDsV3t?=
 =?us-ascii?Q?jyYs8UAkbJMppt3skp8m3jMN0ZlqJaauiATLYP7jrtxAKWe+kpo2VzdKRp1X?=
 =?us-ascii?Q?+CJVI0X/oHc4P59bbzdWdmmkEbH5qe9jfmz/RE1ntNW4951eLUAaZXHZMEDz?=
 =?us-ascii?Q?qK9Af8DIrdbGuI7k2pDvC7VLvWakxTPuwjhQQYuSPFDAiSX18JGhwyWObVWZ?=
 =?us-ascii?Q?4crN3i3wK0ojYAN7n5TyMfkU9jKZaf2gL7a4Z25AHk162yGF6DHVzO8aDxYz?=
 =?us-ascii?Q?StPlJzmvrEEaRdrmbtZz3oQ+hONYv/RhTZUYqksp4h9cOlZw9ukmC+z9BDeO?=
 =?us-ascii?Q?wQ3vR8hKtiSlPpYs+5qeyJlBDsd01AexAI35vStQ5PPysV63L9Q+i0KXtZRS?=
 =?us-ascii?Q?IwR8PwVYnCHu1CL2lSRoZqiGzdOeAj01YX2k9DyFs/ePDSal2kJCTjMmz0SH?=
 =?us-ascii?Q?Y7zA8ITFpPOIJ8lAa0Bp7icsEKAnV6OlnUZV+OGISIG6oDCJRBvj0gk4YIpC?=
 =?us-ascii?Q?eDjuhnitnzb1LOYPVf7LDqxvgsDNKwxqBg9ybpocD8SKMDQ7oFyDRoRyzKPY?=
 =?us-ascii?Q?ugb9Q5byFCYDk+9nCle1XQd+j6qnSQzFsrGtOMTJ/NZz/k7oq9Ej99Jozy9S?=
 =?us-ascii?Q?blepZ+PLm4k9alEszKuVF/lRiPTpXfZuYFxYlwKJTHzv5c6+y5sWo1DSG4z0?=
 =?us-ascii?Q?F5vIQQhnzdtS0eS4SEeYbAezTW0lCMke7F3SllH6f9Isr1gcG4wTrg1nCWja?=
 =?us-ascii?Q?ZgU4VlVBwVdQ0a2r//VDcB2vnkRpbXX6zRsjX5KXvHSzI6Giqv2iAlKqD/A8?=
 =?us-ascii?Q?FzL2GkVF0POJoqrwrhDt0gsQz/UlGF1RcnilBlUwniTr70kL8kheb/iLQ0vT?=
 =?us-ascii?Q?X70M9A6WFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d11459-251b-4530-79f0-08deeec99b9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:04:40.1463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fws7QU2TMlx/agIoIPUV+HjeBAZUObZDXYyZAQF1CuiNatFvfe2A19FXq+CaGztnQle/RhWl2T2WhU7oCe9SXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

The new Nova[1] NVIDIA GPU driver exposes GPUs as logical devices on an
auxbus. Currently libdrm doesn't support auxbus, so it ignores Nova GPUs
during enumeration. This adds support for devices on an auxbus.

Rather than follow the lead of virtio and resolve the logical auxbus device
back to the physical PCI device, we add a new bus type and associated parser.
This is because in the future a single physical GPU may present multiple auxbus
devices, so it needs to be possible to resolve individual devices even if they
share the same parent GPU.

[1] - https://rust-for-linux.com/nova-gpu-driver

Alistair Popple (2):
  xf86drm: Pass PCI path rather than maj/min when parsing sysfs files
  xf86drm: Expose auxiliary bus GPUs as DRM_BUS_AUXILIARY

 xf86drm.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++-------
 xf86drm.h |  12 +++++
 2 files changed, 130 insertions(+), 17 deletions(-)

-- 
2.54.0

