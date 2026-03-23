Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4597BF4610D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0AD10E004;
	Mon, 23 Mar 2026 13:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fKzbfg2W";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4328310E004
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhlY/2oH5sphvdpvC+VR96WEzYtlPhvl0H29yXx8iRksKU9l5B78RkiUEDFWgtHtI1PphCjYP1GC9h3BLcVjA8u7spn9DuIJVvPYbxmSbU3+95q2+B56lVsWuKYlQsRwGR/bbERUtsb1/+wbrzt5mAtbevTj+cfxZS/hvS76yo+ANQi96dp2vILttCObK2nKSn51LxGru8uvaRaLAwpvZORavPid5e9GNIAi64VEtJVc/cpEDREVbkc8vYlNLumuOkyALN8h2djAceSsuAR9gCN8hYlJ/aQdc/9kCTzzZrAgpqoyYBHoWJKUFhMgOdiakQ6Os7fFB3DjQKwESVkmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElObXdYKkr5+Zmy0X8sfD/HZ7Z4/6F5xLeO9AFHBHow=;
 b=uvuBs2VtoKA/D2lvsilbSCQ/rySAhYc1CKbvq4s2Zf8b+jVxf8mY9b5Ll1zyROf9MH84tEsKul/MZLtsHlmaYSbMtKeng9qqNEYKtBkkOAWi++AfhXfyVAcULcN7D2WOsZjaZPB71Qq1zHYehaGRpu9VLAYONaMcgclUTmMbildf4K6cUqrpvwy5OIxFEkcCSflE5X1PBiZO1Q/a1XKKZPJOeltjWPu3XPHEv+l61JfOrhIDYQPp4BCiLySiru2pe5YAdcJYOJaxQPhKXaxWmY/tQCZlHmit1AmW41S3vDznW88zt/oV0Pi31hHgM+5iCS89ql1wKWjZjauYU8+J6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElObXdYKkr5+Zmy0X8sfD/HZ7Z4/6F5xLeO9AFHBHow=;
 b=fKzbfg2WYnbCpB8PFAY7mvpKl3GRuSru4PEC4uc4sbfwzs7mlTOt0c7Bg++PNv/tnh5+Br4B/MePT3tYJZVgZYlaiPbn7ria1qizLpcq5XJ3eObUb+5IDblqGrGxicKZ/owIN6ZrTByr4kFv0fEX0UZny3+K13k9cA5q5Gm53uWm+wjd+v3EhXoJNbNcFdpBkDrwzHnxVXYJ4cp5cklqAKNBsxLsyqyATcew/4zlHVKg+UahGqLmLOT8g2iIEUccfxlTgExfhMmxj8JGIA+/KLtJCx4t83qgeUS3XxWUZxgKvTA3LR8WpMy2EkoI2IEQMVaQzBgtynVPJgzRjs+AVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:25:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:25:37 +0000
Date: Mon, 23 Mar 2026 10:25:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [RFC v2 PATCH 04/10] vfio/pci: Add a helper to create a DMABUF
 for a BAR-map VMA
Message-ID: <20260323132535.GJ7340@nvidia.com>
References: <20260312184613.3710705-1-mattev@meta.com>
 <20260312184613.3710705-5-mattev@meta.com>
 <20260318140408.4677fff5@shazbot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318140408.4677fff5@shazbot.org>
X-ClientProxiedBy: BL1PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:208:2be::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcbc565-694b-4953-23f3-08de88dfab48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: D2NQ6t8zxXSiownOmvCY1Pl5R/uUAyaD5qL2kaqSlyrZKWsu09mN1K2+q8X4x3vW6lI1uwVf2+y+VW8B8jjyp0i8yn2S9/77myZYneybbKwfbXyGcCDp78WBFCk3m1YIKWRUIrqofWI3Wm2AJKFDmXnRV0HnxI7WGGuoEBB1Aq/Vg+CUY6Lw0NKWFHW49NglR2iysu2ZcbAEsrymg4/9/vGzELUx+cnXCz6DbvW2/kQRgne69lk0N4NYf8UZ1vhijykg/hQa11bwni4gH3dradON2dX1bteTPGCmqD/kUB/1TunjcmTDdOMLJwdVSu1fi+U1PvWFSPVfNQvDRiXD8dtgrH3orAeDbbnCJ+CLHWItf88GMOosCcr6xl+cSqGDpJDxHSdG3pkrC9enHskYLdMJorgrXONIDy+8HVExyKV+D5rpVI9Srz1wZ9xpWPOzPBUFGrCNElW1KzzwVW9esnPU2/epVfEBvLiL5wE3vaSuJIgfYa0xr59dzFDQ4fDFmiWosQ9eG8moqe6pLwUQG5+Qh6+haYWHvP/bWuRHSDbmN8n4nJbOGuz3Gf/Yk4qWwcYYhF9fGyOHyaLOjcbo6Fkrs3Qg1rK/3VBD5e1jRN/p/CrekmM61VrQqOh3Y5LfwdQ5NQyuPCmD6cmyIFWtcj/NC4TBG5aEbNpcZHDq2ywqCUO8FzS5zsNQSMnEazpda+MMqkY2AHtvRHY8runn4zI81hQGi3qv/zOtENLrLew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hkMb0716B/GhLQqPHGswrlmo9tbZkYeZjw9XSO422wLFaMGruEVZbxmsXOS?=
 =?us-ascii?Q?zGakgqsS0rXmM9Yu6m0b//5V9SO0VHI4kY4SCOhkvyJkRC9GArE1xeQDdotR?=
 =?us-ascii?Q?KzG/+B9yGk33qnr8aS6aBtmmGA/xpZJJ+2HOWcd9hMcJiXI9jttKVUzd/tI1?=
 =?us-ascii?Q?AfWRmnsfgMU5s7W3ghUciKGO6uJ5vxK5B256K56535RufO3QDnZgkDWTPNSv?=
 =?us-ascii?Q?9LQCWW0Y3gij1stfwrNqRYTJM/zrouAWwYcMJ8dkzWU+COXDBys4j3drAIdZ?=
 =?us-ascii?Q?Dn29n48EBMCNGiptFVV7ZAJ6dZ73xPxrw/jZMAzVvEfSVTC91tdIlxP7ULYc?=
 =?us-ascii?Q?qRyWxlny7cNDaCOuO/VpZ9ANeJrrKdIFmqaqmdmROOwEKWyDNBZYkmRC8xj3?=
 =?us-ascii?Q?qx2JAxRz87sVq4sKTdHiuGFrIv4VD3hMQYHMZVd6V9Zgq/mOCzBlAYUjwkZ2?=
 =?us-ascii?Q?xDihkF7slsn2cNZG0pkD9AMtMIzHihDIUfyri4VIPNvUvyCC5G9fLegRWMDT?=
 =?us-ascii?Q?2lcnoXHOcMQUE1LfMbWSvaFgnSRsnQ/gMKnkoQM36IY4Eb0SqeBtKbJlnseh?=
 =?us-ascii?Q?8sci2wMqOEq1dMQm1/MFy+AVAjAjj2w3umuW5loA9Dc+CtWX4+BA9iVqh4vQ?=
 =?us-ascii?Q?gNRCLiv12cEneeVVwQU7gHPjv+2nsTYBE9nzXNDWvCb/nZV/ZMy3tlUvb2oj?=
 =?us-ascii?Q?q5AR7oSOOPpqsSmoQWQwXYg2iYR9aK86jgArBuqng2QklNrAQgecfB+rX2G5?=
 =?us-ascii?Q?O3m+NXTuWY1ZRwwye7PM+f31TeteDOg2D5DXTB4zajkyk/5XwE2mwA3XcaZL?=
 =?us-ascii?Q?mvCXm/u/IAc5l1r5njba42Ni4cKLTCk8UJwQY9t94fvD9w8rmXtWe8rzCPHF?=
 =?us-ascii?Q?TKJfPEmlPYTYI1Rbl9EZOuRjGICESWHKtDQkH/xWH0h8EP52BL3T3hMBe62i?=
 =?us-ascii?Q?nfdrn9btu6ZG80JOtc6rFr+L1oQPO8i7H1eagN//W/B1xUshL5Jot+NzFS+B?=
 =?us-ascii?Q?z/87y6QKKhSfBZfrzSTnPWJHGqhQ5ouRLwangTXKiL+cXQw1hXLAiTdozqKD?=
 =?us-ascii?Q?MLfbw68dfLb8+p64TSuHumFTp6i+trS7UqTn16RDS5QWtEEjQu7mN/f6FKjf?=
 =?us-ascii?Q?SQXmtGJ9IXq7Xo2mGGEfIKYwbJfFQ523R7D2KYAyEcjIC7dqoBHBrwWi6OLX?=
 =?us-ascii?Q?RcIPHnrTz58F+hSGVONyKAl7vE+XGtxdyrb1HjgENiMRvePxO/v8nXclHTJo?=
 =?us-ascii?Q?T5KAaCtbU7ha5NqknKCvc5woqMVcxmvBy5ySa4YElel7MExRvBKBAXWoEolw?=
 =?us-ascii?Q?hroZMv7SdTByySUrPbCH3jwXZGIzMbys4QpcHBAioLMD+PYjUXwvR7ySdxSY?=
 =?us-ascii?Q?+Y8Oa+iVfNvitmPuz4gIC6OEhZMuBhEwWWz6Do1a+SuK/75GyhpdQ1/2Pf9o?=
 =?us-ascii?Q?bGyT8hTjbHaN2n1dMGQXBgbmLmysQl+hy8LsB5HkOVMMX53faZquJFc9Ct0T?=
 =?us-ascii?Q?QuS2GNKQXScRDcT7+BLlUXQAF+lk2wmsXrBTiEE2aYO2K+tevO8MC2SQpQLJ?=
 =?us-ascii?Q?wT4DPCI2z0hxwFbAX/lnlmlpjg1CuHI+2Zznl2erLEm7WeBRUboP3s8LmTAV?=
 =?us-ascii?Q?W2SnEX01E2n8M1565Z9BunREerSvya8eATzDZ8EtQXPO9EO6fNzrxoGI5XYl?=
 =?us-ascii?Q?/UfyNDGE4OyhpDpaGtcTOpzHNAn/GLXtTFN+iZEajml4rsZs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcbc565-694b-4953-23f3-08de88dfab48
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:25:36.9762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FlAOQ+CFsM76fQ9CNv1XelEUa1KyEZFu9CdDq0w+SxE6JBCUVRY6R9hu1TVpBWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

On Wed, Mar 18, 2026 at 02:04:08PM -0600, Alex Williamson wrote:

> AIUI, this affects what the user sees in /proc/<pid>/maps, right?
> Previously a memory range could be clearly associated with a specific
> vfio device, now, only for vfio-pci devices, I think the range is
> associated to a nondescript dmabuf.  

Probably

> If so, is that an acceptable, user
> visible, debugging friendly change (ex. lsof)?  Thanks,

IIRC there is a way to attach a string to the inode that lsof can
display, if we do that right it should be good enough.

Jason
