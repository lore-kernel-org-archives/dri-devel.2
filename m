Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F78810EF9A;
	Wed,  1 Jul 2026 23:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqnge0Li";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D41E10E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRjX7QYNKHtRNosqFAcpOOAdkJzei76cSowZ7QKYAM21AQqqyW+hcYapN83IWyMuT9i7OGL2JIiYP/e/welWdmH/MlD8wEXZVt5PSvZPrSZOV0g8joh9hk53/eNB+Wsa7RI+4FkOg/U6a1MdpVXX8Z1poluq29YPL/HOjFs+GNyNw1l2NwuNZENheysP69E15DWaIr1Ufk5WMIAhNudSfjJ/vjYxV69GLrWCwQ2+PHbc/Dth6ue7TKR0lLGort/wgUlG3fLlGEdqtjK8NXGt5bCMSITUylZyeqNlXqYzzNgnj+xL05GBSkgz45ckaTLPPAsew0CwPRHWMaYuKQw98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51hBTdzk8fR2gicwYbqOuDDMAvqwrDd3yVNYSY2WmfA=;
 b=D5oDk7QkLT/QYUnxP3WK/rEb/RJ04BWmE/GkH9plpUUDGCkPGbZmySVZirL8C1JYoJ6vy18cFcrtznmCaA+Wo4C/f14fcWaaut57lknRjMpkJkxSm3S5QLHWvjgT3cOWI8PAbiYOgMfZrLCL7rEg3FdkLh7TsQpSfR2PrpFvOFpbDCuaoM93QYYvMeKRVOuXBWL6HdLD7Oajp2ouBBXWba8QkZqAD+htSP0Ml6k/3FPFGr8s39aJ1avo7LO99CKs6Ip9UwBqgU842ZZQZnXZGl5Q7Yo0nDm2GJEJFcNJ2Ga02js6ok4z4gG4TT01cFBt99r6r+pFqh6TNtCmXZ0d6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51hBTdzk8fR2gicwYbqOuDDMAvqwrDd3yVNYSY2WmfA=;
 b=Rqnge0LiJ+i8hgR9x52Rx3EZXQN5C1hOmCMeN7/cbENTTULRNrALI307AZ9MNw0EEqtHcjT36dUc0CVA4iCrNI/5fHJxLfN6fMpuG/8txXpWyFnjDELeswozXdMhUcXvtYP7z+2wKcV+ekyU4WFBunLH5h2hm2byuYAIJ1y0QVeGhwShJ6hWl3w/xKO7yIrBv2G4sC3ztjgHjI1xfpaX/QCOR+iH7FQCGHEsV8XbEo+3wKD2sSAxnKTL/qt0Lf6vJBa8Q8kTjl1VTLZHcTmVr7/Gv4e+S44pnD9FnGYdabX3AgJ+R4mBUhwXThYjdQoR7+ZwC203khf300N49ibymQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV0PR12MB999093.namprd12.prod.outlook.com (2603:10b6:408:32e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 23:34:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 23:34:20 +0000
Date: Wed, 1 Jul 2026 20:34:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <20260701233419.GK7481@nvidia.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <20260630113919.GC7481@nvidia.com>
 <akRPkj5iNaNgIqNk@gsse-cloud1.jf.intel.com>
 <akRsELMbwJmUKWek@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akRsELMbwJmUKWek@nvdebian.thelocal>
X-ClientProxiedBy: YT4PR01CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV0PR12MB999093:EE_
X-MS-Office365-Filtering-Correlation-Id: b78ced28-f0cc-433d-94c0-08ded7c94629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XmSDzj/+BhyK1lLMvDtpr1LEFH8jhzIx1f+A+YgsiFrorL2o8k5JHlRmzNDEhKSO+i9BOsJK5MmtxgNDRO6u6LxOk8P/nedaF2tfCBdR8mUUgXnDPcrY+Ju/ib9s/4CUOBuOFEeIKW9a8AVYmSZcjxTqryOcYV9XouZKbrQMjhPgvYh2my1HFiFXeWDmMr+VISJ/zCdmVlB+LBW7SAdJUwnFa6QxDes8uINR5hYdRQnMJ/Bn0AHhPyohmaZlnqcsLtxekcV8uYiyMAD1Hopv+WalB4fiXv4okegeuMCeXY2Qm19haCKZnsCuCsAAazNPVixuNEb85GOiufteJnOE9OO84PxsyLCaI+llrHCD5M3eYFnNJVFs0FabWRPvJ+ULaOKPUq35tfUJBnQF2xtHYOh/ykN8USqBL5JYRvpZcQbJRh/ZtEtk50wIpWP2L3Ncwfpac27D40OgKI17J6pNpbIqXs4q8j4OWoJTkYRDlTznoEt1Ox2BG9O4cGk3xAwrbJQALncQ28CEbr2oyGe/e9i2aDsn7xfrp1sx/zBKE514s3idj9JJnWsrlE0ZcoWHPq3V3b8R5aMEdMFWWN/uyJ7V99YH4IWnItuzrDMIHKjzJ8nFt4em+tXvjFwqHzEcT6CT/XUHlL/4QS2QNaaTA9JXQq7IbzODf/iMl4kt+Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8X1Boxn2aMxbozDzlwySyPXbNKHgkSmAEXp8jGd9SPUXzUBhU0Q9yV/hHF1?=
 =?us-ascii?Q?2uFM+nBKaOVHOCq7VCYWhQ5oRwj9QtR0y9mEaf84QT3n8TLk10ShqGnIDNb6?=
 =?us-ascii?Q?tD7A2KXp7hfsrjGQSA0e53LN1j4tTycP/cw/+Ov0nTMRHmjbmVlSkFrUGAFT?=
 =?us-ascii?Q?NWdtzzMN38sNMAJ089J/8Nyeoq/qp5GaJkECVRE5yl4GdgSDHmctVmGUtmvD?=
 =?us-ascii?Q?X5xpetReWrbk0YRbDcijI5e0Pibq/vgsTlsCxYjRS7VnzLEOd/hk+OKg1lsB?=
 =?us-ascii?Q?4vUGKzrRqb3NwSbUwxDt9OvW+ReH+z3fscQYZUE/CihyQOLKg3HBV9ozP82h?=
 =?us-ascii?Q?47oXJRdjD/3cSzDPg+3NFlOd07t+D/Ob4KTv2s/Iafs6Txqo4iY7iYecC49w?=
 =?us-ascii?Q?DbH1o5fS9f047D3QJ9xE8wl2OisNTk/sQ/t2xXSIjH7Mz4GSacA0bCXM0ZA0?=
 =?us-ascii?Q?aNPqF4jxWeJ6yYS+t13kw148CldKQkm9dOOdZCDqsBA5hMEGCgyJA52axbrw?=
 =?us-ascii?Q?gQgCjbvy9VhSQXTJpKrfO9gh1pjIVfwCnTZEdsztyj9Jm+t1FNznuTP867jL?=
 =?us-ascii?Q?KWPAZFiS84oCtPZxjR9qmmp/GEXb80uSMIjygfKuYhILCwjfTPFecHAbrqzx?=
 =?us-ascii?Q?GwOx/FydcILKblnAgNdS9tDePlcNxy1xa4TmIbZdTeCI4R+OznhTLVUdYkaI?=
 =?us-ascii?Q?2set/fSDSo3eIqrg99/CaAydRwc2vWOgo2xsrHMiGKIrDD1WwhncWPDVTVED?=
 =?us-ascii?Q?0wcJ21WckUAGAtZZvTGCbWxln/fCY1cs/OT481ZpS0TQX2o4b/0ciExy9cP1?=
 =?us-ascii?Q?ebSpDRSFnmCdQF8lmICEeCmCYdziZqVPClITwsrWEfgqSg/NJ9a6zICY248Y?=
 =?us-ascii?Q?dNRE8jDJNOnjFxJKCBCuyM/VeQbqkrUq/anwdq8UzoviL/hSy2BudDxJdQKB?=
 =?us-ascii?Q?bEgucPE0Z3ly4/0Ab3FADPnOOmw6K23sz4zq8PkM2Nby+BnqzVk+LvkeG1m6?=
 =?us-ascii?Q?TiI7Jwdkmy5wS4NDYYPBXWTIZk6VyYMAtpGBLY9HPFDF4njduHLAmnT/uB1H?=
 =?us-ascii?Q?OCSrnBq431k+YP8T6e/pTOneff6JR+GAHfOWl4UST9g/tJ7lCBD93YmBZjT2?=
 =?us-ascii?Q?2/Sp3qk6rlomhaD3X5QNqIFQm+ZtgYRiTmyO63C5fkWL3mUyDDSp3QvyTg+C?=
 =?us-ascii?Q?n2Y1sbtqjKbrGvBeukszJ4tIEl2fJngDgHSdJure6JsBpXi2X4hUnnMqRL97?=
 =?us-ascii?Q?Ib44eEeI+D13+jZaUzhcmTGlTwSwb+gqGWupnxdTnIdcThNh+RrIVayzw5ds?=
 =?us-ascii?Q?2UkNrVucERJeZhp9K+f6U0+4L/JqkKZ3GVXmyizoTtSZSBNNBnLYXF5B1R/I?=
 =?us-ascii?Q?S2aA1crYmNafkoOyYRMhOVyauZxvske5EFmlvdVle1z5K9VBnJ1QnfTf3gmQ?=
 =?us-ascii?Q?ousuMFusEjqA692AKvicWrpC+p90gZQ9rOtPpCKA9nYi/RzQCWjRDn7LG9tD?=
 =?us-ascii?Q?GPHOno7+8yo+nxR58qYoZeyN0SV/W2kcPn+lqSaR8zsYJyn7p0VffX12+uaP?=
 =?us-ascii?Q?lLA/cZGjSIzYIDom9/pqnbrs+DaUeyRkyRc5iM6IC1y/m4hcaPSP8QpoQG3S?=
 =?us-ascii?Q?T6z9Dta/d6+hRMaBWo4gfpzECTABAcn3QNHRahcggJTKJmbvd6Ba77Veh9ER?=
 =?us-ascii?Q?tSX/knGxp21ghF5bq4Vg8e38KRv/fw0ZR3StP1AbDA1q3JxU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78ced28-f0cc-433d-94c0-08ded7c94629
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 23:34:20.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuFEdhk55mDtzQ4NlGxT+nhF/975sNqw17cq/qnYmzdExozT7agqMQtid3Ev+qIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999093
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

On Wed, Jul 01, 2026 at 11:30:08AM +1000, Alistair Popple wrote:
 
> Agree with most of the above and this seems the most likely explaination. ATS
> doesn't change much here - most of our driver still goes via dma_map/unmap to
> access host memory via an IOMMU IOVA so non-present entries there would be fatal
> at the IOMMU level. So even with ATS enabled a non-present DMA mapping should
> still result in noisy IOMMU faults.

AFAIK, the iommu driver does not log ATS non-present replies, those
are considered normal events. The device itself is the only source of
reporting.

Jason
