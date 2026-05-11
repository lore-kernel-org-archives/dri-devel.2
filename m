Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13078CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645B510E21E;
	Mon, 11 May 2026 23:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MDLJizKU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4986D10E22F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AToREnB6qzbOZcf3VfGUJlHVtFHXvmPgt2nZWHFt1oo1aZxj5DkOCDa+98tYKagvARCRXtdMOnx8ZvHUQ9Y00Q/L/FdiN9Zpme4TdK0fJ4KhLORNF4rr/DOKWYa7ZpFyX0My+Nv1bwxMGVq2NxwxeC+BABjcu5oqiA9eGWbQ/eJUhzjCCRLaaIWD9x/866x4ovQfsz4gTpr2gFKCwpzA7NiChlXYkkYTpDMIy7E0k1I1Cbru3ue+Uw6TPWafaQ/od2bAIocvfvAQIrbJgo2YGwjK9KJnCB0yHWEZ03dJs1UyrduW0ECc8uVwEpVd/EXiucM5DBH23h1YmaBTntUv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGaFSH4wTJjuA3pGNvPyx3LWhSrKyaXrYVoAGZNr+fk=;
 b=p+2aE8AQhUj7wvK2OpoTUOYJFzu6jEPZ9Y4xJIhDTQQy2RZoYHoqtT/MDykyKEQ7DQhK+LvL0HQfYQmexoeSGtPoB+0Y5MP88N/Fo/jLKAwYuvckeQFqOQdd1rlXLhkrKgFKi9mGtcqPk4Dpr7M8pORjRHu5j66ZRpZcKH4egXFSuK1xfCWjzWOtZxzs89RNvNRmDpBk2Kboia9T1mn4qQG9lCOOQEMuBD/uv0BjeCtHmdSizHnnD14G9b/KXELePsHW2u5n6G9KNCvT/ls5FNKiuESu6UY+Y3gb2r/SaKkuqyy/egR9E/KsPzF7+vieGhlOhSlAcNwM6xJy9VKsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGaFSH4wTJjuA3pGNvPyx3LWhSrKyaXrYVoAGZNr+fk=;
 b=MDLJizKUZ2YPaQ9Iun13IFGpdArflzqeUC8JMVgYkKuaf8o21eefRTtcIexllXm9e61EQ2wt1DcLQVE/6vmuBtKGHmnjifzlkVLMx931eg88QDDw/39pSKZlVgow6NlIh2LRVbI3xEe3oG/3aOneYk7mSi7dDVnP+YWirCWq2vvtK4CLtuqrUuLcLMKlkZqaVMjUDJaTSxIhpQBQzeQ1EbHkI2vsi0IC32o1GZXa12YikVAI6M/YaNRv3mjSlhWgRKUE6WGRPIWsc/8bXB9HpAvrQdD5pniwftWhn2CMixrJwHkNykk9LGVGz8ausdbPrm18h274TN6TWirOOA/OQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 23:56:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 23:56:18 +0000
Date: Mon, 11 May 2026 20:56:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, pbonzini@redhat.com, seanjc@google.com,
 alex.williamson@redhat.com, vivek.kasireddy@intel.com,
 dan.j.williams@intel.com, yilun.xu@intel.com,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch,
 leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 tao1.su@intel.com
Subject: Re: [RFC PATCH 04/12] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20260511235617.GG1116784@nvidia.com>
References: <20250107142719.179636-1-yilun.xu@linux.intel.com>
 <20250107142719.179636-5-yilun.xu@linux.intel.com>
 <c0b160f8-2930-4158-9e50-b4cc4209e2ca@amd.com>
 <afs/Jamxnj6GGFfM@nvidia.com>
 <3128deea-95a3-4c36-902b-37f280913f2b@amd.com>
 <c166f41e-d983-4a22-95d1-c485a82d1d06@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c166f41e-d983-4a22-95d1-c485a82d1d06@amd.com>
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3d19d0-c0e1-4db0-ab8f-08deafb8e4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: JwmD1hKy8Ot3WY0uY3ysyIAJnNN4Z+bQdtgVwad1W4UxyfYf0LQWwr/srtbwt0hbrjmyzntbCZsHil4QmrE5Mn9/kzmGrf9fcxkJ9BmwnC7u6+aEj44Lc9VNBFJcIaeW9XXJjRC8ZnJJjnW8KY4rTZgOyL6Xtiqwo+KyCGcwcfgo/ydWBLcyyFRrbETcxtEuUq2AoUnxGycVGIcTr69mGYMcJ+oTZ7sSckbrGWus8yk7k0KPae8CrLgao3fHBATUDXtk2YfyRF/8zvZkws1Q9p41UlMr5nS+EL5axRuztQOIF6PNmtUl56wNGRTkWZUKtODttB7I+wtJz4uTaLva9+LJITTphnZWkVOOpd1Ff10V6VUtIvl4D8TQ16+C7zC38tg4E5aQfj5kcuf0Zh7rdMHYOi9hpVT6fLzFldnCy9Chr+cT8TsfaWi3W5qhQzdbTu72cXyQbEXLQgomWtelYSuGDQwkI4NV6EcwvoZt46qpkZQyhuB/C22IyxahiYaqd4KIfopaecMRSDnoGUX2hggcItEpPJxYcSG78Nyi358PttbH7GERNU193dYehxjKX/SGHDZwINfTduMthVCpcLHghIW+lPdd8gdTfJyql6HneS+yEO9yyQY8xDRz8c4j5se+7Q0hu9hk1w+n+gwpKuq+6rzpLZT4h8vqtdWtBNeE02nMxTVHZiqLCrbaJWyL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0deAJ6I29UlUMgyiOOKQcSIRhED5jYsudoM2xuttJVwgbW8HDv96aHCqPnSw?=
 =?us-ascii?Q?jtzDD9QCRjT+9AfsJZmJ7l6BHlep/oDflzbLVhQFU0+ElosYG4j0T2UCTrGU?=
 =?us-ascii?Q?WEXZi75DmLPbcjCzzfl/MaGVgXLCnhwzIXFQux2oPWU5WTDUVlxad3+SMQnS?=
 =?us-ascii?Q?kA9fY9O+WOyCz2UK9fwjabCaJWDIIrEzsZeKx/1V97VpF8BJk6IZg5I0Nn0Y?=
 =?us-ascii?Q?PHVrcTwFsPtnn6LHd6RSeyLsicznCjz/ljFc8DEeT+BxCgY4bdm7Axj8jY1u?=
 =?us-ascii?Q?1ctqTLMaD6j0nuljuZsv+U/zbTNQLnMFnYRD4kPv+C7agAElw5omD6bUTZEp?=
 =?us-ascii?Q?mTbsliaMNTqJn07miUmKifBxFeF6AQiQFjs4WLe+ASKLjBWrmTBvBP4fdKa6?=
 =?us-ascii?Q?Wq95kPRYHjTcdasP0sNs+uIyVAMX2mCQlPc47uTu00yu9oiylWayonCQfp5z?=
 =?us-ascii?Q?4rq/lm3zQyA3u3OSstzSSy9jQ7C4rh9jzWy5y+Kszt2Vn8EJouseUN/I/D9R?=
 =?us-ascii?Q?cYHCmaUiHoaD1pXHe1K0MB9IKRVEjVx4LqfrFroJHv2FnIw3+1uKLJcFVq7E?=
 =?us-ascii?Q?uH2nd/r6i+ZdbGXmdbT6uup7tM7YscRlfyzO+HOoHzUwOfB9UQIQc1wqIVKF?=
 =?us-ascii?Q?iTOfjjrOMTH2//PRQ7XuW4TlHod8BR5az2aXwts4TPRSIhSN89DTWLP9z3C+?=
 =?us-ascii?Q?WxtPN+EEKSV6yfWTAUqSlsR4tZOoX1hP8qCqlBMKY5XEi8XX5dZ/OTdDKiUn?=
 =?us-ascii?Q?6uzBdMC9uUdo+w9r4PZuxD56+Irpr8PPmJDK6nYUubmWQg5cc4NdAcylXac+?=
 =?us-ascii?Q?YHZmwJ9E/il5U0dyUcyK/6d7ihrOmpgKepP0p9lPoJH00HKIIwUtJ9ppOyg3?=
 =?us-ascii?Q?zrc19UBqHYmIgPJhkelL26PAv9/W1XSJAyo/32AucSTE8kvFDRgLMgRvJV7n?=
 =?us-ascii?Q?SWwWiMP9xe6hgZ/mJj3Lfw8eD3G8dgiBmynqI2R0uw+9gJVFUiHgHqGaJi7a?=
 =?us-ascii?Q?vYslgbHpcDubQWCvBhEkRgEyG7jAneBiSI242/GO6B9NbYZyEfkN9sDPv0yX?=
 =?us-ascii?Q?NhiqCNQmQQuQ59WG9lui7yzEDnnB7o3GjuAQEMn2HUxAR+WHUxjsXYfFXkSw?=
 =?us-ascii?Q?FgiFvQzu/BqRqXXE/7AogBRXrYFg45859dzKrb9qE1exycVBmC9l++3mAWc1?=
 =?us-ascii?Q?DQTXIvdrdJ/fEIdiopPEPMLwRTS8LixoMN24OrZlf+qkUq1BQQQY8Q0SP0QK?=
 =?us-ascii?Q?nS6uNKJTjvHeOIH4ufx5XkR0nD1h6Ele3E3FPpv73nAg5JNWheZMkYu74ybR?=
 =?us-ascii?Q?AseubN0EAyGJoDBUPFNvD+xapEOsNBaJCyumpA9//qxYKOyAmcdVNhBNNlrJ?=
 =?us-ascii?Q?d+r69RS62cvHV5XUO0M1fn9JS96TL4vuMi05T5jq3RCo6fFOc7Y2kHdEw+q2?=
 =?us-ascii?Q?vOpm50yFkwjdKE1tQr0DYr0A+89frwtjIROjGfjtmoaAEuKtUljYnnR81+gK?=
 =?us-ascii?Q?UDCoBWVCEgaOO/dXUGT6nrvrZ0bCGSbVGXkTYkftXhOfqlQMso0tkRg7Z4hJ?=
 =?us-ascii?Q?msdsLOUcDdXo+CngbT0YwG+AdJBlUqlbVM2u7aCNf1sQYK5AS+jJ8ADnvpZF?=
 =?us-ascii?Q?2VoSwUR+siJsc/qA9UwB9TwPJEordf+ubm7Etnjsgc/j/uRiXECdsUq5Gvx4?=
 =?us-ascii?Q?y25kvwff3rufSC7VzGXQuWAxGkBdRcC4mV67CDla+ZPTY0FU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d19d0-c0e1-4db0-ab8f-08deafb8e4c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 23:56:18.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpLh8Wh64OOGKYoTNVQCqO84jALxka7f9ybpsQdyFu3s1Ogzc3rc2YDvBxG5/fx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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

On Tue, May 12, 2026 at 09:42:01AM +1000, Alexey Kardashevskiy wrote:

> > true but either way dmabuf slicing will be directed by QEMU's msix-table
> > emulation MR and this slicing needs to match the TDISP report so I'll
> > have to teach QEMU these reports, right?
>
> Or TDISP devices are going to align MSIX BARs to 4K, and QEMU will
> do the same and it should "just work", and if it does not - the host
> won't crash. Can this work? Thanks,

Host crashing stuff is a different issue, I think the plan was to
revoke the entire MMIO space from userspace and remove it from the
kernel mapping. Entire because we don't want to parse the TDISP report
to figure out something more narrow.

Therefore there is no way the host can crash.

When qemu constructs the VM memory map it already has a scheme to
insert a hole for a SW emulated page for MSI. That will keep working
exactly as it is.

When the VM validates the MMIO the hole has to fall within a T=0 space
of the TDISP report or the VM will reject it.

This means devices need to have a T=0 hole around their MSI-X/etc
suitable for a 64K page size OS.

This is already the case, if a device mixes MSIx with other things
qemu will work but it becomes horribly slow and a little broken.

Jason
