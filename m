Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1720CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDBC10E607;
	Fri,  2 Oct 2026 14:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="inl573lx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9B310E607
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M36lFFnc/45hzIXLFZ//xiyazW5opAUAhNCGnLwcI2FiXqcBzFEnYYFuA20RqvGPJUb3eMmJ4MxS0pVNUaI3sscPJbxMr9uDasAwctBvUkh6xqAmQHC9gMA406bjnfkwyoNpQfU4/2vk1jiYrsS4WVZN5neirPWtJ28UP3NeNSeamlkFKHiRyg9DkfyFDwiFb7SVy1C848xLBfWzBRlB6uBX9EnpJ7/+VZYXZzT42FgBxFtmwLpzQRGTnVZaEql+W1RaUjIYPWRTrYLjQxhtNOxxocpLLFJu2Y8Jjls4Mz6UoQ1F+Vhphx1QGFUhxn52+7hX+s4iaVK5Z3VbfbZ+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+/JACs6VWzkJy7PSj7+l2nHHFgpx9QbYRpEIsfkSjQ=;
 b=fy7XZbVBg3b1PUOTzBTlCslQxUG8mSdx7WI54QtIrL9EgbF54QOnD2cxX6YqnwuoKYW4kkk0KKYJQq153nZDnwwwJ98T1YyXiRK+5elcyg/ittvcbu2l6KhCBkGtIM0ZjVnwSwrssAsC5cVZEtEmjQDT1bfwWTS24pI7sOMDK8itIWmv9V6W4SJZn9b8+DM427elRZURzW9o9ARkHUq8E5UZH1J+Hs3e5oRaF8UrXUJbqQVsaOlWu06pNhv/OZpPMdBIpz+SD0kX85h1Kgu2v3M72DTP5M6ZjRURxJvwgH5+5kxDe8/tnMqgYKi4ndsD2b2nIHbAQdl+mzpPDidnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+/JACs6VWzkJy7PSj7+l2nHHFgpx9QbYRpEIsfkSjQ=;
 b=inl573lxxDwXVvqiOls+u7QQHKRodFTF/hVshZYkmyHaaFfKiIMwmKfrwAqBDryF8wot+H09XV4KdzS0ylJLH48BNGY9eOihCd+3RAYY1F5DS/3eEHkJSy1huwVULaN9/uHREI/YQqoUxD0xz/S0OnJgznPW0DnVWFWaOkmlJIMvcr/O9Hhfy1zm6MIdelAN2kUOFN0wuCtKwvTRZeebZXSJYUMAEVzOptbSkBi0Eyp6uud2+ejUKj7B5Dwrw+sK4hwHa7ybM84ZGO3fbRvD7TGovFJiGwrR/7jSdpsc15CaWgwjXr6V3RK9I90AFeKEJWN/v3uXcsZdBrnR3kOwIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB7744.namprd12.prod.outlook.com
 (2603:10b6:8:100::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 14:51:10 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:51:09 +0000
Date: Fri, 2 Oct 2026 11:51:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 Manish Honap <mhonap@nvidia.com>
Subject: Re: [PATCH v7 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <20261002145108.GU1616761@nvidia.com>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20261001153834.4a2528a2@shazbot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001153834.4a2528a2@shazbot.org>
X-ClientProxiedBy: DM6PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:333::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 789cbe2e-7e9c-4a15-72ea-08df2094986f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PvnPe1Wwpstlfl8SRK7j6hrHoCJZJPhOti0O/VrAO2ql3rXp2J4D+aUaRghzUQUJenWq73hpoQ2Iw0v+XeM/yhp+WZs33hz7GI2jmiQQtIkBrK1RlvunAlLbkL00BHytx7vysuLqERpeAJz/Of2yRW5WS8fx6khmIdDoVNVgZRnx/yZgsH6FG1k+nuFtZAUGrkHeqGaJMj/L/JlbU/6wVs7OT+paJnuWtTFFEMb5Ke71CWV09yExmi/YkhkRidZsgILoslNZNlSv4yb3TTvpd1wcCqSDU4vEbSyHNZAyKcXJ4Fp1BBMURsA//SGYkEeE23qVP+C9eyyyoo1n9VyMTkl6gwVx7pZ7WgcFOgTRBmTbk8iBvG/ZQeoo2XMi+6n7SrlQArrRKKpzHrqDVGkXLojJEDq+bp0tjht48odDfNyl1XbiFIFeJQIweXgCZnk5ZHugAooqF9WU9ASLJKwgGYVeSuHkL/OAXXEWWuVqRN5wiR4uBAo1PuLDSIsfij9vKAODooPDl3AMwVmP4n2RWmrciQTqDJHeOAc9Qs16vBOVXRZAfQPOYeIT4GqvWJK3eolernFs+MJPRTy0yWrnABqF7/lW2Lpy2y/9gUq7zYuPw9JLz3xUyh4rHiC/83SkartyFxPzmFR9uXFWsdjyZ7UYsoIHnfdg56SynwgzZtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9JH8NHwXVqgiVbof3qoRgpO8tX4koSDlcrlzAIFNJdqd3QqYOH501oRG9lA?=
 =?us-ascii?Q?BS+IH/6ZQdh4uRfmF4wSP65UzMFVe96vRNj3HhsMi0WVXIyTqPPKI/9gEyaf?=
 =?us-ascii?Q?3riulgzyoIpqjj0y8BVw05IOf8GnGabFrO6pmGizckU/msxWNVte9+ChhOyD?=
 =?us-ascii?Q?BtD7sO1uNsBJGblVzxoqz05rw9ZjIq/MKW63KxRfiim/uZNu9CTFqY7JHKvq?=
 =?us-ascii?Q?ayWRA/703VB85PveReO6M1CJP949xXm47puNk66SkexmhipY6a7WXzBFpU+d?=
 =?us-ascii?Q?YaByDuwD7vGtU4xDGjJXjOxk6Sp50ONdvIzN4GldyE3CbyTAThgPatb32fXq?=
 =?us-ascii?Q?09neXxO+kjqJ8Yd0fdJUqUhjS90CJ0l0WC8aW2x30eya+4iXuW7AIf6ZCDb3?=
 =?us-ascii?Q?OgVfxHtv1h0Cxus26Yv+ul9EFIgVNWNVonteKgTWaW/SPkh3h0wcspjDvLJO?=
 =?us-ascii?Q?x5eP5AiIG3Soct8kSL2Smso2bz2lV16SeeRwaqwdNKBprn9KV0XNcAU+C2w4?=
 =?us-ascii?Q?cpNjq/mbujmXXg7m7kj5WI8uZH8Tb7OO7SGYd24qxzuXmJjww3eBqLd7gjBk?=
 =?us-ascii?Q?J8yqyTqDxI1PHMkRPNxrSLJbKRTD/eUNs01Wurtd1Zml8VER+vmafYmIVPJX?=
 =?us-ascii?Q?vv2mgtMnoUdYgfm+XFu8s8hPNz4JGReCk3Uj84pAAWIS7cOyX/PELh0HmZv7?=
 =?us-ascii?Q?UqoHsC804fNH9IGX+jNU7n12Cr5cFHxMtHQltG+KWlNKna+/Sa5kNuulucSh?=
 =?us-ascii?Q?tkgV83NN61FIUzSrfs2LM82gz70Fxqxs39Iv8q7mnTiFav+yxm+XVZbJNe7h?=
 =?us-ascii?Q?hhaYHXhqMrXT5Sa/AUtliV1tNrnKwwI8ZR4KhxNSkhxSwEb8iExfVvlp7uKP?=
 =?us-ascii?Q?5UF830WLnfJ/BXPdBM9f/Gfpaua0v2EuJnn+Ljz8uGijxGZTy+CP1AFvmOYX?=
 =?us-ascii?Q?dpDMUFIFKo62zZSn5G3f5DVw2YceI4Zd34khFyEfnlE7Z+oA4rG5Oucl/phM?=
 =?us-ascii?Q?EAEYzX9TMGA3Jr8WV7ipxShN5hWDmNOeBhzP/umlP6mwCVGd8vLJnxRV9Sxd?=
 =?us-ascii?Q?9ahwMK5I3gSgY+W7U/oqawml/OoAcghwo+kJR/+IFt75NMN0tTf4OHz2g6P+?=
 =?us-ascii?Q?xsxZy1oq/A9j+tzcDbbl1MdANWmu4QjUuvNTUW6oeRfIX5ScvcKyMvsssERA?=
 =?us-ascii?Q?RSc7H2JJov2Ojcnq6/5JITRiOewtO6kNICdWbjACokptIPAZ4Ro6zJSfMROu?=
 =?us-ascii?Q?vECuaFhiBQ/Y/YtPvQ+nDf2HFYnitWr6tRQ/9digJbTHTTIS2K3fBXZedV8Z?=
 =?us-ascii?Q?Ctv+CimHCnOGo5MAeJCVwiOIvWMj/CFEXoBb48WnARo7sC8JcMi9J7ao52H0?=
 =?us-ascii?Q?C4DG6TU5M+4TAaudZ0zb3PAGLF+qKv7AcrM0o+67/mG3CJRi1/SIjFJcsx3Y?=
 =?us-ascii?Q?265aNVEKsvssxnzpTDrOCQUEtyCt1XN70JOhTJ1l0qKr2g2QwIIAuE+iTe0H?=
 =?us-ascii?Q?t9rW5KJ60PVSPIYuqTh6cUglAFk8EsGX3wucZy2I037SLuuIb1XvDsBlyqyh?=
 =?us-ascii?Q?TZWyOhV9WAKGbxBm9WB2OEn9M5luh8yPQKfLNRe+eSPRKfhi5R3lHMkM7Fj1?=
 =?us-ascii?Q?Tl6P2DPT09D2n62XlwWqcqVLkRnpcJ+0VnbGmS9k982LNIiOv9Oh+xYckeU5?=
 =?us-ascii?Q?pRjz354Y8zqDCEym5X6vT28pYcdLEUzy/z51rrmeBao8rb2I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789cbe2e-7e9c-4a15-72ea-08df2094986f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:51:09.6676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oLkrp3FNsawpPVnYcePwFEU4h4ZeAwK7OIKRBfd2HkP8voLl9iQzFWBjqsjBZIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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

On Thu, Oct 01, 2026 at 03:38:34PM -0600, Alex Williamson wrote:
> On Thu, 24 Sep 2026 16:21:43 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> > Dear Reviewers,
> > ===============
> > 
> > Along the way several related issues came up that warrant more
> > eyes, and I'd be grateful for your input:
> > 
> > 1. If VFIO fd is opened O_RDONLY, it currently can't be mmap()ed
> >    (because PROT_WRITE is rejected in do_mmap(), and PROT_READ alone
> >    drops the VM_SHARED so VFIO's mmap rejects it).  BUT it seems we
> >    can export a DMABUF from it, and then pass the resulting fd around
> >    for P2P writes.
> > 
> >    I don't know if this is intentional/relied on/a known limitation,
> >    or a bug?
> 
> Seems like a bug.  In practice it's probably not very meaningful, the
> user can still potentially change the device power state and trigger a
> reset, but being able to source a writable dmabuf to a region on the
> device fd that isn't itself writable seems semantically wrong.

I'm shocked O_RDONLY even did *anything*, I never expected this.

IMHO with these kinds of cdev's we shouldn't do anything in response
to O_RDONLY. If the core code does something then fine, but I don't
think we should try to define a semantic what "Read only vfio" even
should mean.

> >    a) We could reject export w/ -EPERM unless the device fd's f_mode
> >       has O_RDWR, to reflect the RW abilities of P2P
> 
> This seems sufficient...

+1

Jason
