Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487D6F55811
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 11:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791ED10E2A1;
	Wed, 22 Apr 2026 11:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWmDvS3S";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F5210E29C;
 Wed, 22 Apr 2026 11:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHp46jk5SPF30RSoMwnTMVYGaG+judrZErOSSyTP5IRstHyflujkokptdK3bxZSPIzkju3cdupwUxtu07Nv0lkbalFHqx4c5nkFIBypb7ud2qnazMGs8HP9aJHJpDQVoM5kiHmgeejFk1YqyJBQkqDM2gMWZU1bcPM+coJe3QJUJgRIz964CtbjB/m9S2l8Z7PH4JmGYvrij7rG415Y39gFxS2dv03cUwdA5CbKTWiYookiR2BDJBoexzghSc7CNaB63FaT8CItrZbCZ0oFNI/3pEfxi9gjzf3EiXbz9sAOwEajC2I0NpwxfDA4niAp0F6P9LMlVvcbtrORx9uuRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkXjEdLMe9aJrz4ycb9wIOhpNsIq/d3xfhCWGB1vfLY=;
 b=QDul7b93aAvi3kPPfBO62Z44sg7zUt0GI4Q219VlEOgUijp5UbwHgUUnvnLLnbdTe5Q9nzVk+hha0Ct8LTGWIOfb97RqWD0g0nhhGplv+sLJqI1IatrSpGTtjced9m7sQz1GittbpWXQYvOObeowgx8g6ZgPnlvYJtp0OpRU6X55S1B6MPpVi+ghTton5BUNCTxpOcnMOoNuodhLQU3YpBqpefMQlX2ZTZhigKV1scdBKiVScmhaQPrz+/iR4PSRp8smT3kZntfybNcrqphdvbCQA+udbUXQcK63GLp4K6UcbqeC9Z6tkyJhKilrTUFGpDQDcw6BVx1F8QXBmMmDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkXjEdLMe9aJrz4ycb9wIOhpNsIq/d3xfhCWGB1vfLY=;
 b=RWmDvS3S1Ezj6A3ZkfYx2wROo6sZ5xrr9cwqZpcYQMeXV5zE27AVADTNph4746TidLtRKY2okMJkPeXHyNqdEhV3S1My658v4JJ7ZQMRcwWcYD7x3kyT8AZChVSXbWndvEh5gDWdkSLbfqsUdCUWpnnkn3OQX+ZaKv5X5KXNBhPsceBYX4c7u9V3tmSjy4AOwxrGd8qnFhEqf/ChrqHTXurRfRptOSlaX9Bj/oQmr8mNkx6RUhzyFhbGPV93yYHQmPHt6s6c54nbbU3cLDn9dJBqh5jGa7Yyx0mlxwUR2ekermsuBDKVEplEOmJ9qZ22qG6zsTHYb+auiTcjUeqzFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 11:53:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 11:53:08 +0000
Date: Wed, 22 Apr 2026 08:53:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 21/26] dma-buf: Add the Physical Address List DMA
 mapping type
Message-ID: <20260422115306.GI3199414@nvidia.com>
References: <21-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
 <20260413121628.GE2588311@nvidia.com>
 <f6d38a08-009c-4efe-9dc3-6bcf00ac35f7@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6d38a08-009c-4efe-9dc3-6bcf00ac35f7@amd.com>
X-ClientProxiedBy: YT4PR01CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2328d1-e33d-49e9-ee0a-08dea065b85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9HvkVcbVkMR/o95wl2MQxxJaajL3BtCQddbKG4gX7dDGlBI3T1om4xzXTwOJmRbuwBEkIj6Ad1S8B5O8Htsp5IVyo1sLwpVEopuHO6AupvwJbWSfu4NHPhWDbS299rHrVYzsL96QGIJkmhYj6lgbQewz8DZuft57WGga7Hwqn1pQ1oYx1OGG2xXFDvz1Le6Tss4XJsSRlmO8C5KJ4YBrln4389NJhKntLJXomKcPudWxnt0N+PrVHA2rqsilHFXyw5uUI/R8PKHO+IWEvAttxqDmIvi3VdgzIFrUVIhtmpfla6xzueAH48YWSSq+YPu9+ejKiAf/ycD1awouNuwiqBle7TMVZROUbatxO6B4S7JdHsUYjyuCHSkna7NFPpfUkUhGgFm/THnZPrCifGIGe5HtWrI2NIWKtNl87HdZeqHz0zg19iwVFz+YeHee6WRwZdsUQMGRlNd851YsJLqvxmfliaGAxu2Zj3YlViu5noJ86td0XewhyQHbyHOLJ2FdZKHS/tRm1nddxSwcXS8irMawraauAGKpqCUwOkBoJfOnk5JIBgwNDYHUNH4rAZWAiu9rdf+1h7ffdX9RugKbDn1Htp1DocNtG442GtoA3XEOnjWa7OPVvTN9Br+QqyxAsxsaFwmyT7fPcUqUNOl7I0bvHEpv/w5wDq+cKIfW521lM52Fv1tpJw5V62fmfqaQg1n8xhbrHS4bFM12XVrkbDbdS0g+zyrJWT47nPUu6Fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmF2Vm0zTHlyM1E1R1Q3eG5EamthTnNLenV5SU85bENSODRPN2JodlNhU0h4?=
 =?utf-8?B?ZXBpbVVwaGNFSEdZSXVYSzZMakxxVTZ3ZXZ1K2NVT3A2b21VUXJNU292VWo4?=
 =?utf-8?B?cUpxbkg4ekVxMWVlUVJjTXhNeGhZaEdQVnVCbHRuNGJTbkJRTFlWNnRSazZN?=
 =?utf-8?B?MVZDSUJOMlJ6b1lTYkNUWnBjaFAvU05Qc2ZrRTcyUk1obkhRU3VnVUd6dlp3?=
 =?utf-8?B?V0lqU1hKRW05a1Ayc05xZ3p4TDhXQTMzbERUemptQ29CNVp4QkpQenJQOGxy?=
 =?utf-8?B?V2VMd1RWQVJyYjY1QzZpenZXcm9CTUJ0dTBiMzZLTDc3TTFLSWNRdWdyQllL?=
 =?utf-8?B?RDY3TUs2eWFKcmFSdmkvMFBqUHVWWUJrdnFmdnF3UnczMXlZU2RIejdDRnhs?=
 =?utf-8?B?ZVo1ZzRGbDlnRnc4Uyt3Q3NGZ1VOZW9WSU1RdWxXMzRhTUtOY2NpL2ZqNW9q?=
 =?utf-8?B?UW0vRzJ0QnlGUDN2Y2ZnaFVzWm40SkZHbm5FYlR2Q0ZMZkFPeGpIV2FMUmUw?=
 =?utf-8?B?dnhQeGNkaUgwbnlVSWRUNXRqUHBxbVR1aDZyQmN3dUlZOXlKVG96S1Z5enJY?=
 =?utf-8?B?YTRBUzA1bHJwdm5uQ2FiUlR6OE0xOURnUnpqUUZERVRVL1NIS2czRVQwN2RY?=
 =?utf-8?B?Yjh1MHdONjVCWWhsc3FkdTAwait3SWVqVUFGRGJpRGNLbTVnTlN5NU9qazNh?=
 =?utf-8?B?UGF0eDZxc3liL0hqb3VBZFZqVWN3YUsxRW9JWEo1V1ZhTnRqaFFsRUl0ekhK?=
 =?utf-8?B?bUlYS1k2bzAxSUp0emZiTCtCMmRkTTRrUWE4bURFalpBYk1BVDUvc0E2bUVW?=
 =?utf-8?B?N1p1aW5yaW4xeEtiblcrSzF1dDdnZlZlNGZteWFQYUYxYzZBcUJlU241eG15?=
 =?utf-8?B?QURMMnRCQ1FFcFBFSkdMaUxjeWM2S0pEbFhTNndxWHZ3eE9NQzhnRERDalNU?=
 =?utf-8?B?ZDBHbGxVSEZPd2tJLy9vMnRUNEFpZ0FoSnVzdG1VUXhiQzFiUFpFcEZJRitE?=
 =?utf-8?B?aml6b2ZJS2tWbGZtd2dFY0VGWGw1K3MwdWl3dXlVTmN3WCtjU1k2elBFWEZR?=
 =?utf-8?B?VXBqSFpiU2F4SWQvWkZoZ3R2cWZYbzBZMURwVlJkV3Z0TkVnNm0yQnVVSlBD?=
 =?utf-8?B?L1MvWllOTFhqblIzTVVlRWRZcUY2eUl5STJEM3NaTFJrL2xSNE5qQkhnd0ZX?=
 =?utf-8?B?QlBFUHdRY0FpcFZ0Ym1ZTUlkREhvVTBCNmdQUGw5dEcxcjV5WEpabFEyd1dO?=
 =?utf-8?B?Q2RHZ3RYVjFIbFdQUXBEdmhHbUpiMkZPVjFZOS8rTmxOeGphc21sbUo5NldC?=
 =?utf-8?B?N0pxYlEvVXljaXo1NEJ0ZnpIMHM5ZnFjbWM2N2xsYytKUVl1MlpUaGJ5R3dm?=
 =?utf-8?B?STZnUnUvRFltR2R6S3NhN2lzdFYxb1FIZFhDUDBwYis4dCttNjdoZEwwanF4?=
 =?utf-8?B?Z3VWbE1GVkFNWEVDNisyMzg1M3ZML3JJZnRORlR5L2VqaHZ1aWliT1BwTTQx?=
 =?utf-8?B?M2hGQngrbHJPNUVOTDA5TFVGTFN2Nk52VHdVdlBsL0N6UFVaOEhnMHRpdlhx?=
 =?utf-8?B?N0MwVWc4TFUrbmF3eEdmQlFaQmVPZUdZNGtuS3ZGQzBNL2dlYkN5STR6N1J3?=
 =?utf-8?B?TndBZEdrd0FDWmdvTCtsdS9ubzFyR3BSQmYxdSt3SGZQSXpJWTRaQ0FXMnhS?=
 =?utf-8?B?QXdETnFQa3h4OUU5akJDaWlLNitJemVNY0ZudGR3RHFPcXhlRTFLNzR2aHlT?=
 =?utf-8?B?M0lwWXJZZWZ3V29YWGdTREdpWFh6MlBvMVpFeVRYTU1sMnFaMDFvbFZtUll2?=
 =?utf-8?B?aC9Yb0ZBaGlOMkVhYnhRZGhvMi9LRXBmWDZwUWNwVHBnR2xqZUxydFhZbnFI?=
 =?utf-8?B?cFlEOC9IYUVnSTBmblBvRXhuZnEyRDBOTHFZb1FEcTNpYitxQlRCS25UeGFW?=
 =?utf-8?B?UEJvdGtIcGxzeGcvaW0yVVNhUVY1aTVyUXJWZWVXbFFvVlFLYXhLek9TVDUr?=
 =?utf-8?B?V0pBVDRhenh1a2VYM0VnZVp5YnRFMmI2VFZCaEhiUW4zWVlKcXYwb3ZRTDVG?=
 =?utf-8?B?UDBEd3hWZS9uWmZ1Ti9VMGFSbGRTdGh1cVFNUnZGaEo1Z2Q0SHZSdzlxQUZT?=
 =?utf-8?B?cDVFREt2d3h4WC93TDFLZmtzWDhmblVJdnJMQ0N0Q0RSci93MzNHU2h4Y0tu?=
 =?utf-8?B?dW8yUUR4S2xQRmNydi9hN3J4bW1VMkFObEh4TVAwRExvWm8yajBqN05GRXhz?=
 =?utf-8?B?NVd3WkFXalZyZGJ6YkhrcWxmUDdCRjNhYVJxVDRKMU5qbm9ZWGUycFNzei90?=
 =?utf-8?Q?Dk6CoztP4YAd+mJLq2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2328d1-e33d-49e9-ee0a-08dea065b85c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 11:53:08.2007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxW9aM54Ix/5cMhO9OcmnlG2TuzqJ1+osPaI3SP8Mz/2avTAB0OZl5RYO1O93XRo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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

On Wed, Apr 22, 2026 at 10:17:06AM +0200, Christian König wrote:
> No, not even remotely. I clearly don't want such an interface in
> DMA-buf at all.
> 
> You can do that as private iommufd interface, e.g. where iommufd
> offers the functionality to say give me PFNs if you want that.

I'm not sure what a "private" interface means if VFIO and DRM/RDMA
drivers need to implement the exporter side? That's not exactly
private if it in so many drivers.

I've tried to make the importer side private, if you have better ideas
how to make it more private please share them.

> But when there is a DMA-buf interface even if it is limited to
> iommufd then others will want that as well and that is not something
> we should do again.

You can say no, that's the point of the export symbol restriciton.

> Even for iommufd I think we don't need that. What iommufd does is
> basically manipulating a specific IOMMU address space. So the
> interface should be to give that address space to DMA-buf and say
> hey please map you backing store at this address into this address
> space.

Isn't that pretty much exactly what this series is? Aren't you
splitting hairs to say an "address space" requesting physical is OK
but a "mapping type" requesting physical is not? The net result is
exactly the same, physical addresess flow from exporter to importer.

To be clear, there is no way, nor should there be a way, to use the
DMA API to create a reliable dma_addr_t that is 1:1 with phys_addr_t.

Can you be more specific please, I still have no idea what you are
thinking in terms of an acceptable implementation.

Jason
