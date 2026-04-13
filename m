Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94742F34C47
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B642E10E41D;
	Mon, 13 Apr 2026 12:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZoKXTQT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B3A10E41B;
 Mon, 13 Apr 2026 12:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACZgV2Uv9Yc1JXWVl4BS9B7AxZ+Wrt9RMlHaL8sRGoplLez1A5SMBnR9HeY9h99cDMSuqcIWQZKvLQua1Wuk3CRJXgQyxAdhDwH0CDbr5h3yYqmwl5sGSr7P/A6+UnRef/FtsTnPivd0SOqXE1D1SCdV/2ndtyEvKoBjY2mph2vJWTGKMBQLmjgpQpFDsuefVcaDjLplUxtUKOTYXiCTpGWiFz7p6yNcgl6Q7IwcniaiyvkMIoERhrClgNnx/Y77m0ghGRZcgrmf1ztGO+dKKEqspPgI4V/JhbjRoD2r5IDCNMoay6EWRnvJFZMRsJzUBTjVhEfhLn80psRbK0R35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdHUw/MgWYNUNCCOBm9JlWeYgmR/ML6TGzDWrdEykDA=;
 b=T1lIm9BQQQbDtJlfMq+1QwsgLFyV9Fp+DvXht3E5bOWjWvHyfzJVqL8QDYmu26QmFw6Y1++XVIZbqcVuQT5jJhIZFwO3OtQ5r48ebimRxdd3A5Mb5yssmHLmBN5oeHUkPEPi7E8YpwvxsqvWGyLMHRgmiMZNo00G+itCGP3gtN3c8MNp3Zlncu/0pQmOJ9EfYb/kvcHBfgQqsmOxstp/N/+OavVAilc7Cka0X8jdO3Y/v0NS3xRMpYJGvDw0ueuu0FcQ3CahqLfS1wsC/o+kWgSV2OVF6PGAk9ZKAYx54jLhJbA24aSWpoTCKXR2DPbCzQZiZEC5yEvbhRH0DraC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdHUw/MgWYNUNCCOBm9JlWeYgmR/ML6TGzDWrdEykDA=;
 b=dZoKXTQTLK5mcETYsyBTujTdQdB0379HF1nbc3QomnEXu7EY75j6C4D1TrtPeu2zzol4/nFMd32dCWOuGLEheS7SrpQ9u2bXC0lJQIxKdJfQ8EU5lnd8iLZjin/IQ+V+mFHMULPpCH2STBXSE7G0flaaWniVCl3DucDf91B48g3fHNSkkAcMB1eGAFx28ptgWvN1uBj1AVZ6zHpIS7/0I/PHVTw6vq/g6t0a/yRuM+aIowNbynR1/D7YYbkczml9bayyN1ueLJkpLi72Dryq1xmhrQ3XAjDfAyjwxikXRHkgpMf4qKH+4D9ls0NT5GAgKl8ocUnj5ygs3CZYThrBLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 12:16:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 12:16:29 +0000
Date: Mon, 13 Apr 2026 09:16:28 -0300
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
Message-ID: <20260413121628.GE2588311@nvidia.com>
References: <21-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
X-ClientProxiedBy: BL1PR13CA0405.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1b16ba-9831-4f73-c0ec-08de99567e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7iH8i+y1I7cP8Sz3pgxttrOhGVUSnhjWuRpf9frGffcR0pmvByv2BlaOK9k3HbvuevIrPMGSrgVnicB5DUN6YWGlkP/4+BwBZ/qcYeqdg/I0sh0GqAy7dTGJVmrD3VhtNCLk9dJ6adJFc/HHchMmZFnfqY1rd8Hl7R4//T5zABXaKwK/N+kcaVvYM2GASXXYRkm1vuUR0QqQyOPU9Pe+aHx8OK6EK6qlxi2EG6fuyH6EHLx2+eowLCVqFMPkiR6Z7I2iMXofkQNovjYb4TgQlJet/j+rpihVfHdx1FAn08UW3Id2iEyYP3sOXys9cpy5bD6fPXwD4UqlO1HXNc7K7A6nk3tC2s1RX7n0QeeVtxAU2NyLTC7brCTPHMn8moSJPXIj8UtXylefpzdnT9Bcl6o4ZWmAOukbiFLtCKMaVy/1pbBJva4KcWE7lu7ra9SFJ4qvLneLrdTO8tSYBhn3/DFD65LuDSQkOIA0AKngM6nUwqSU9AYNvzyJx0L+hbBLWm48C6/D3evNEDVTHT/R/heFTQ7b6R3rlj9Qe1R+SIwYxQzc+DlbxvsbP6SCDyz3WTUTBkGzqJdpT8VIZVJLosQ/+8wRpWbBf7pTzq8XTlUWmiX6Gej2hTMGTPhsjdF0m14ZNkD+gaOqyv2al814XiqhqrQNrBLi6fkrifcgWZFSXZ3T28WD8vENa7JpJ8skBk5B87CO0aE2q/dXavaEIXbdevhSE/7bxFJH7MCa6Lg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktLWmNaRzNQRDZHSGZyQ29qeHdqTnZMN21Cem5wZEV0Nk5PZWgvWHhUa0tI?=
 =?utf-8?B?c0c0cmdqb0RMR0pBNTdrNWxHcHBWN3hPeFErUWRvZmltbyt5T0tGS3N2bWNu?=
 =?utf-8?B?RE5NMkFBMXZ1eS9FOG0yd0ZtZHFzSXJRSmF2cjBDMEZJbEpuU3plV3BZL0FJ?=
 =?utf-8?B?SVRvSEIwTFhpc2FyVk5QZmtQb3ByMG1PSkhvOFFadE1UVXBWa1BqSnR0UmRP?=
 =?utf-8?B?V1hjN25tRWNTMUdsZVN6RDNXbkd0RWY1M2g5ZUJIbHFUVW5jcWdHRFQ4VVRj?=
 =?utf-8?B?TTdWcnZNMnFreXVMeHdZakZ1bHFlUW5BaE5EQzdoendEbEhkK2xQYlhuUEdy?=
 =?utf-8?B?MnJuSktiSEJDN093blpyamtIeWx4K0RZelFhaS93M2YrSzhlU3AzT2hJWE8z?=
 =?utf-8?B?Nk1sR0UzZ1pPZTZDWldjSGZZL0RFUW5pdDIwZ0wzNXFJSmV2eW04cFUrMlZ2?=
 =?utf-8?B?UVpPWE12MG9XVVZJcnJnWFBxMlpEbUhSM2tKSm02Y1hlQ0kwbFdQcGVwMjVG?=
 =?utf-8?B?SU1WQmE3OHZFb3JMcmdDQ0NGZWtPTWpUS09xV2pxVHNyanRGUzIvRnNlM3ZW?=
 =?utf-8?B?bzNHT0NRRWZGRWwrOUd1Z0JkcWRSQ2ZqUEJvZ2Ywc2dYQXVTNUJqS0N0MklU?=
 =?utf-8?B?SXJtOHIwZGZyL1lpT0tVL2dMQUM5ZVlYNU5BTU9VUjhVSVhDZUV2TS9VTlZx?=
 =?utf-8?B?aEk1VHJHQ0l2SzhqU1JkSC9XMXJCVzJCR0dVN0t2NkpQQTd3UDBRWDdLaFFG?=
 =?utf-8?B?cnVRMG0xQjNCb3NqMU5POGFJL0NaVXpsV00xcGlVY2M2ZVBEcUlCQWUyeU1B?=
 =?utf-8?B?dlZPdWlFNjV2T1VsRDlrY1FraGNsR2c2cVJQRzdhVnRPa3MxbkhPekJGSGFz?=
 =?utf-8?B?dmRVdk5aR3VVWloyWStPSFdkcEoxTzFhZ3FVaFRrWEZuT2lhQXR4b3ROcTQw?=
 =?utf-8?B?VnhiVEtCVnNyaEYxbDd1U3BmNjRVc1A2d3VzQnRCWVFOb3duNndXWHFpWExS?=
 =?utf-8?B?WnAySEtyNVh2YlFtUzVrRTN4NXpLbXZLRkc1c1dUUUM4NlJIV3hxR3dZTXA4?=
 =?utf-8?B?bTYxbk5ZTkErVkx3UUJPeVdldWhSUmZRZ0ljNWdKa2hZZFhSQTQyRVRna0ZM?=
 =?utf-8?B?UmZKSVZRdzFqVXVtanZoYjJ5Y0FwVHNxSTlpMlRKWHJPbHRHSW9YV2MvVnhY?=
 =?utf-8?B?M1JBbG00OWlhb29hNEtuOGV3Smh6Z0tlMC95cGNJcHJuYjFza3FFL09CbDJR?=
 =?utf-8?B?ekEvWUxZb1dsUmE3ZVVmSWxQZmxZMjZBUnpENVo0RnVFb3RVZ1pNUGRTS3k3?=
 =?utf-8?B?L2IrcjZhRkZoQm1VNUN1VkgzMlN3RFBKYVlXdGFGOGFwRUpSdE85SDhVZ2hZ?=
 =?utf-8?B?TWNTT0xNd09BaWNUWG9iRStkZytXOUkzd1M3MzRZbk43ZmFhN3RLNEdZUFZR?=
 =?utf-8?B?YVRubHpQUFh0dGx4cTlHRTQ4OHduWlc3Q0xSL1ZPMi9DZTV6YnBjOVp5NTJY?=
 =?utf-8?B?aHk5OTBlUjVXbEdWMnhZYkR6dmdQVUI5RkNJSm5CWkttOWFDSmcrOWJzWFN4?=
 =?utf-8?B?WEowWlc2VWVmZ1JFZ0RXNWgyZFFnOFZpbWJPb2FOYjh5QjNvN3VLS1dsYThk?=
 =?utf-8?B?QmJQVVBncmVYN3dNQ0o5ZFluZFFRbGVYKzJUdXFJOUNXSVZLVGlmUUVDbHIx?=
 =?utf-8?B?U2ZGaEgzclE1YXF2enh6eHRhTFNKYTlkOVk3RW9CaGJmcjlSR0NUQ0M3WGxs?=
 =?utf-8?B?b1Evc1d1ZStwY2FWMEFmeXVoNTEzcVNEN0N1eVdyajFJQ3BSbUxtMFp6M2FV?=
 =?utf-8?B?WU5KNG9qUVJVYnpITnF6UEZFaG9kUFVLcERXcDRrU082cEY1UFZBRnRiU2pq?=
 =?utf-8?B?eFNLaGZxQXo1VnBSaTBKLzdnelV0Ui9hQlIzc1ZXUEpsbm1TYms4NzVhM042?=
 =?utf-8?B?T0dmY2F1aXdnY1NpWVRIWTZVSTBRRVFJR2g3WU5MWFI3VUZYR0hXZXlJYmVn?=
 =?utf-8?B?LysxRHhhNTFyM3grL0lUVFQxV0cwdWx3clhoaEM2WFZPNTVLTlBGeGt5VVQz?=
 =?utf-8?B?T1g2azFFMHhpU0ZpT0lIWnI4ZGFZVTFpRmRFRGpHU08wU01DUTJpbEMveE1J?=
 =?utf-8?B?SDMvZlRyczBXcHVCMHRPUlgzYmlPQytjWWhzY05xNnV4bWcwQTFoMFR0UjBk?=
 =?utf-8?B?QmVITWhMZFQwZXlpYjYyakE1WDk2VHEvQUpsOUE5emNSb0Y4QStxMzIvWEhP?=
 =?utf-8?B?VkQ3NlB0emFLbVU0cUdVSWZuYkdHMmlLVnJZdHpuRExhR3NkQVZtWkJxbkE4?=
 =?utf-8?Q?/J8WxBXm1k2c7Isc8b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1b16ba-9831-4f73-c0ec-08de99567e32
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:16:29.8941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAqU402pXdFr0TA0RI4GQ8XvjOxj/uMiKDTl11kuJmCrxtPQwADWSY5m5sfJLIM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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

On Mon, Apr 13, 2026 at 10:58:20AM +0200, Christian König wrote:
> On 2/18/26 01:11, Jason Gunthorpe wrote:
> > This type is required by iommufd and kvm as dmabuf importers.
> > 
> > Due to sensitivity about abusing physical addresses, restrict importers by
> > using EXPORT_SYMBOL_FOR_MODULES(). Only iommufd can implement an importer,
> > the kernel module loader will enforce this.
> > 
> > Allow anything to implement an exporter as there are use cases in
> > DPDK/SPDK to connect GPU memory into VFIO/iommufd and it is hard to abuse
> > the API as an exporter.
> > 
> > The physical address list exporter returns a physical address list in a
> > simple kvalloc'd array of struct phys_vec.
> 
> As far as I can see that is still a pretty big NO-GO.
> 
> We have seen so many problems with direct physical address access by
> the importer that I clear don't want to repeat that performance.

You've said, this is why I used the EXPORT_SYMBOL_FOR_MODULES() -
iommufd does not have any problems to use this correctly.

Why is that not good enough? As I understand it your objection isn't
that there is a technical issue with iommufd's implementation it is
that some other driver could import phys, do it wrong and make a
mess. I think EXPORT_SYMBOL_FOR_MODULES() fully addresses this, no?

The only past problems you've raised were related to improperly using
VMAs, that isn't happening here.

> My main question is why does IOMMUFD need the physical address in
> the first place?

CPU iommu hw only works in physical address.

> If that is really strictly necessary then I strongly suggest to not
> touch drivers/dma-buf in any way, but only do this is private
> interface between iommufd and KVM.

This isn't between iommufd and kvm. If it was just that we'd probably
be able to keep going with the private path like VFIO/iommufd already
has.

The two paths we are interested in:

1) VFIO to KVM
   Allow KVM to import a FD instead of using a VMA like iommufd now can.
2) GPU and RDMA drivers to IOMMUFD
   Support SPDK and DPDK type userspace drivers to work with GPU memory
   This is becoming a popular topic

Jason
