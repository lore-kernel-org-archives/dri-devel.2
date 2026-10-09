Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31569CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D04610E152;
	Fri,  9 Oct 2026 14:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIKFDnP4";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1C210E152
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcDM862P/jjvN3R7nW1Zvt9q1v5tX/E4sNEE56rNrn1ZwVbgq6Wt0MZom0cRnOuGB7FB5mh5OgvMIZXczuqDDO7LuVooQqb+j6k8snZUPMk+or2mGlObqUKOSYhOheUEWS7AtwcWllfWCOCS6uJS59BN5Ys36KYerDdkN4q+bMRtz2/uSOISOgtewj7Vi4GP0CEwCpvmG63ywp7tGRxwi/Mxx/SmNzEPdJnAIuCA1WRqzmzRJMs/Kj62oyP1QjE924vBMjcMXFTggFUPunRbLGgJQ4oG/KSsNgPujlJVAJ5+rig+XeO22TTbvl8arIcSEZr2/id6lN2Of2L8SLxoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmFH5aasguRf7nvWPjzZYqBZc7VMhhWgnZHTn3qHuEo=;
 b=T2pD5NG2cZz8cingK0CBYb2ckHtO9OjtvMSiNIDWixbJhl0oLkCcx93ZRpttcKiXD9MTen+WfdcWfmNEmqlIYS13uaaZuAKfRoqzU65HCrdFOqu1OWHD0/j91sIdCcnnV6qiK06h9FFFGr7PeCe/KXUYK3Mt4Hxg6K2ewuIY7sLe7bfuXrOkPix818CUYUju/CNDMKKTQrAK5u4A7UAa/NSo9NH+3AvhZB9ajAawvt15rf58/SCvZuEfgGrfEoCSUbTBU3RrYvOBMIBKYkDRMbwQEMDjabX0bjO+PPnJv1wltLuHsLjFu0V7/OT8IfwkOXjvhZshhA+DmK16SEkPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmFH5aasguRf7nvWPjzZYqBZc7VMhhWgnZHTn3qHuEo=;
 b=EIKFDnP41v6WeoZWbFhgDc4Ca4b4jmrnLmAmYpPAavatfFOUXlIHIhZ1QW+2Ct4CXLWtHzNBQ5ThFBTaBiidcCHle1FwBTpSVM9guX4SdWAWEtETV4hKuYEpOroNIm8I4OwrPT1rEKrTKO/h2PV0KMAuLkPNvroWVRWP9GmSaM84B7HSfkKVWZDy3sHHWtN5r5DJtRZua4JA5fBSyFajzyTnbG+czv+zV0QYknF1rPGWPB5HOC1naN2kwhoQ1TA7cl1HIOt0XTfreUbD5JgQCL8hz0G7Cz/bL0U8Rzq+a/9VhdwJTcllSNvXwubR0pEjxkUGHOfMO7SUNSDVBzVVdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DSVPR12MB213845.namprd12.prod.outlook.com
 (2603:10b6:8:4ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:24:39 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:24:39 +0000
Date: Fri, 9 Oct 2026 11:24:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Diederik de Haas <diederik@cknow-tech.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
Message-ID: <20261009142438.GD13920@nvidia.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
 <DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com>
 <20261009125338.GB13920@nvidia.com>
 <50f74418-a1b9-4d93-a9a9-02bb7cbf4544@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50f74418-a1b9-4d93-a9a9-02bb7cbf4544@amd.com>
X-ClientProxiedBy: YT4P288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::19) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DSVPR12MB213845:EE_
X-MS-Office365-Filtering-Correlation-Id: 92498108-6d14-45eb-599b-08df26110dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 7Iv0CdW8UdCsEks1EdJ9Q0DOvGyPR6DGoh9hzmBi/MigqAuTVv6GKq9rGmxNH5AHegBLeoYULHKtgnCmUT4wbA88BY3HZ3Z5+1zBaANCefLBcuhErXN4AuJ6pSY1OpBER5VD7cSPTH2RZjnz5kaEKBHhqspJmcn7DAVUODH59ffWNk8INrbbFWQMeWjGJJfHCWL8slGFgh+kyLIMLkvl83L08p03amhewjF4VyCu/0x6eRNvgx8qYzWwYbeRJJtrArz0eqpSgfRrAGWc/XUeO1OoMkAcel6XI817dYjdqtq0q0j5gvHkxhXUa16Be+IPIHisomhUJTKQGNLMblGUmA5blLORqkjVoyq1kAg+86vTr1bn6Z4fVFwYJGlIJykjRnN83gvyUckuKOHgnYypugrkHD25wHonxu9KGJBWkupXwGHa4KBW3BeERsyJMfvsL64M4YwZfJiz/BfyxzyeBhjNZQwJP/0dvHppms1GbGjGBxhw4lxdBJe/BCe4F1mIL3KOAK90QnoHgM6Ck0oXJjpivaSkwRDgNrw7KyIPubyCH9HOgu+6KOGb6auJ4ZT+9yI4WEFqWe0CNfPv8YU4Gj3IQSV26TGI/f83dQhxgKw50CZTIcp2aXXq3AY72EZWa5Y3gtkWeyOj7LmHwGOvMboUF0FzGMtMy/gaJzt1mbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWcwazlHRm0rQUIwZ3dDK2VKcnlDUFdCMEVZaUVYMDNLc09Xb0xtMmQrbC9r?=
 =?utf-8?B?L1hybm1hNStIMlpRZTVSdHJWSzRkWEl2RjNnYmhWbm04aElNbTZmcUxlZUhN?=
 =?utf-8?B?Q203R2Z1eEQwa0tEZnhmRFVPRkZ4V2ZlSXJrQUo1c2xZNGVhZEswVmxrbS9t?=
 =?utf-8?B?L1A0eUNnb29NYTdsVXVqMVpFa1lhbnNXcEtISkJManpDVVlRdCt5V0xvNU1H?=
 =?utf-8?B?dk9qdmZ3RW1EY0NWY0tKNCsxcTdkTGN4bFVmdUFJREtMajZLK0pRZlo0ZVN5?=
 =?utf-8?B?VkUyamVPZExEbjZFZmZqSmp0cTBmRmU3Yk5wN2RxN29tRXJkRnYzNVdRV282?=
 =?utf-8?B?ejJNWUVpQlM1c2hDSksxeDl4Y1pZT2MwUVB5ak1VcU1hNXBDTzI0VldVUEZJ?=
 =?utf-8?B?WkhQNXdHMkNZZzlNNjZPcWU5Y0pVY3pNUlZkUTFDaDVQUW9HOHNLZURvTWNP?=
 =?utf-8?B?WTFnYmlhKy82eTF0a2YrRHJ6eGJqSTh4b0NFbmRKYUoybkFLT3dGemVZVjFX?=
 =?utf-8?B?YnU0ZzhGZCtxNk1sZ2IxRVVDY1BVZEM2NTFoUlYyL285VVY5d0t6Tnk5NXFt?=
 =?utf-8?B?VHRBalUxbzF2ZVl5dUtQRzBYTG5XZDJoRVNQaFFlWHJpVFZod0dUSW80bytX?=
 =?utf-8?B?bkVaNG9DWWFSSjNKSFNSeUIvUlh2MFd2aUtFaHBsM05xamkrSENwQmRXdWMw?=
 =?utf-8?B?ZVRKL2t5WlZ5emtFMjduL3UrQ1R5QjRxZU5xZkxIRWlBSlBvdVFtanRKenNo?=
 =?utf-8?B?b1o2bkh6UExRY2g2ejB4SCtXR2F1V2pBMEFRQ2RCcE1JRE1KbU95anpoMmZB?=
 =?utf-8?B?VG1HNXZFR2hhZGNIb2FiTGk0Tm8xanFNS0hRUHBkTkdOY0JNVzhqTzJoRnRx?=
 =?utf-8?B?RksyOUNiYlFIbkVJS0k4Nk0vWmRCNHE2a1JXSzBybnJkS2FpL21ycXUrR01l?=
 =?utf-8?B?cHFlSVdwenYrMm5LdTdYRlE5TDB3SjJ6UDhGNWFKTGJWbGo0alVyTzlWRDJO?=
 =?utf-8?B?OVBzSmFqZmNwbXRvbDd2cXgyRktzSkVjYTA4QUJuY3BxMlJPN25CL3lhSWZM?=
 =?utf-8?B?YXJYQWhERmtTU1p6WHoyWklaVm5vd1JLYVV3bjJORDlqRHRMZUFodXhDTHJ2?=
 =?utf-8?B?Qy90eEI0c1B6SFpPc29EMXVZdUhzNTVFL2wwd1ZWbWloQ2Z5eEh5K0hiVGZt?=
 =?utf-8?B?bnBwT2FFY21rYmtnNmlUcjJndWNlVjNhVlFURnJDd1JzY21TVlVRcndZV3lN?=
 =?utf-8?B?dkpuMDJLeURsWEZiVzg3QjZWaUpoQmRqVHpoVTRXbk96U1NHLzIzbG54SkFH?=
 =?utf-8?B?TnliaVhMcm1ORlFJbTZ3UXZLK3BDYzBPVXd6MCtIZ0pYdHplbzJpU0pIWjNZ?=
 =?utf-8?B?V245UVY2Y2ZyZVdoRVFpV05YekZ5Y0ZWbVN2ajFMZmx0QkJ5d001MS9YRlly?=
 =?utf-8?B?T1lpUzZvaU0wQzR2MmNiYm40NGdhZUVYWFlRV0FUS0YzNGZBZzBORXRSZHhu?=
 =?utf-8?B?VzRtVWJrNG9LVEthQlFma3AzQU0vdnhHNWNqM0haTDQ0VXBUWVpTbTcrNVdp?=
 =?utf-8?B?Y0ZDT0xQeXh0UUp1bU45QVExRExFRVFNZTRNSXhtc1k3U0daMkI5MWZGckwz?=
 =?utf-8?B?dTdLVjc3ejlNVHlmQjFhaldGWDhKajJoUW9ORDVNRERmVDVyVU03elVycld4?=
 =?utf-8?B?ZC8zKy85K1dKbnZUTmRQdkR2MkhSQXBiRTZKeHRLRVFoMGdQcS9TcW1xR0JP?=
 =?utf-8?B?Z0VpMXpUM0NoQ2I2eHU3TTZTckZMY0hNVXZieUtyZWVNSkYvMFNPbTFjMUVj?=
 =?utf-8?B?Mk5qelM2bEw5MTA0WXNaNlZjbEZ2bUVtbG9QZkI5UmxqWW5rTEJtSVZMM0lh?=
 =?utf-8?B?M0tRVk5ETkNnU2ttRWljc2ZSckJJZmpLcmhnK3NnQThFSk5wY1hpa3VQOXU0?=
 =?utf-8?B?Mmp4eVhRL1RIK1Q4Ny80TE1HL0hTV0hkOTVHRW5DeHNUeU9CVlRZSWxqZU84?=
 =?utf-8?B?MDRUK0Q2VStKQTNkMGpZNzhkZmxJV203alVjaFNOVkRoR0F2bmZZRFJFR3Ux?=
 =?utf-8?B?YlRyMDFLK2Z0YjhORnhOYWRMM0R6cVBzb2pkaWNTSEVrQ1VvT2hzMHhNTUVH?=
 =?utf-8?B?WmN6WFBCUGZRK2p0bW00UEVkT0U3eHBLL0c2MGRxMXRNK3l6NVdnTWJXalI1?=
 =?utf-8?B?YTBFVGo3cXdhdHVXMEtEMytrbkRvUDFZazZ4VTRqNXkvTTRFVUF5alpVcjFu?=
 =?utf-8?B?UHhwU0pnSWRzV25WclZHTENuR1JtbHBnRlEwQWptYUcyM2lWKzVCT0VLQjdF?=
 =?utf-8?Q?6w+Eu/PavwkaiACuRX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92498108-6d14-45eb-599b-08df26110dba
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:24:39.7890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53k9rrDwLdhE3WhxBI/3bK3qmhf/mfDfa6DMj3OMJ6rxWZ+BcUJgb3/+ebbiDegx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB213845
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

On Fri, Oct 09, 2026 at 03:21:47PM +0200, Christian König wrote:

> >> [ 1268.968710] CPU: 6 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc6+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
> >> [ 1268.968715] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
> >> [ 1268.968717] Call trace:
> >> [ 1268.968719]  show_stack+0x20/0x38 (C)
> >> [ 1268.968726]  dump_stack_lvl+0x60/0x80
> >> [ 1268.968730]  sg_dmabuf_cpu_access_warn.part.0+0x24/0x30
> >> [ 1268.968734]  sg_dmabuf_cpu_access_warn+0x34/0x38
> >> [ 1268.968739]  iommu_map_sg+0xc8/0x1e0
> >> [ 1268.968745]  rockchip_gem_iommu_map+0x8c/0x128 [rockchipdrm]
> >> [ 1268.968757]  rockchip_gem_prime_import_sg_table+0x58/0x160 [rockchipdrm]
> >> [ 1268.968761]  drm_gem_prime_import_dev+0xa8/0x1d0 [drm]
> >> [ 1268.968776]  drm_gem_prime_fd_to_handle+0x1a4/0x280 [drm]
> > 
> > So.. This is the exact same thing I need for iommufd.
> > 
> > rockchip is managing its own iommu domain and you cannot map to an
> > iommu domain without using a physical address.
> > 
> > Of course it is *completely* illegal to call iommu_map_sgtable() in the
> > importer side of a dmabuf.
> 
> Yeah we are deprecating this for the last ~5 years now. This bubbled
> up because I change to DMA-buf debug code to be enabled by default
> on DEBUG_KERNEL.
> 
> Rob is now working on a solution right now for MSM which should be
> used for rockchip as well.

So is Rob's plan is to remove the iommu_domains, somehow? Lately we've
been NAK'ing alot of the DT hacking that people have been doing in
other devices along those lines, so I wonder what that will look like.

It is probably easier to just fix things so the importer can get
things into an iommu_domain..

Jason
