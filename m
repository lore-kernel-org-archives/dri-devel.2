Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541BFF9EDD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE3810EA42;
	Wed, 22 Apr 2026 14:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PonzqXL3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F37910EA1D;
 Wed, 22 Apr 2026 14:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSNZspWzT7HiAGdzYO7kUJ6GuLsmtRMcoSt2lXTI6D44HqVjpabyObLKPjoNqBoy3DR98sdVCKjtJKB1Cy8DPvjRrVN7B1iEgWZFCXSSQGocJ6rC3cvztsOWuudnZDD7v3rx8dKYVI2XeC4Ih/pCy8VzeGXJI7rimHJG8sk55Wou+upJFF4Klh2pkSK3LmVxtPmXyiW8BmT+fBSHIbnNhbVIzBJjlN4bwUAd7QYf0ugWqMx4pNjX3FdweK/kp9zprR0Tz71kxSot3LJU/D3qQTAJPDiKZKnhcpKshihM+umhszIjtwGFw7RmxPN0BQn1J8ywKZti9waix83O6QwgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W08rXg2JXb27CWxBq1GMWSPCrtSBOL1NfSnyWZ7xGtA=;
 b=dJpK2O6PcPEiGogFJmK/XNqx8HHbPV4cKtyQ2jPdK4jDUFvHZcFrY0EfDh8GaTC5ZVHpg+qkoveKLGB5k1n4bzEtv7iBd4JvwSq8ydp99VhOb7RBqgFN+HIqtvZ0DyuoLhlaiIFUZaHnA1j7qC59rc4ikM1K3WuCGggi0o8/XsU92lZbYNsqt+BIsdCubeVrkneOwVNEtwYwClUuvfgWMuHwk8gJJmTlCVDE/Jdfp3schUcH1cGzJq0HkgzXf4D+p7+BdCggWwM1ptC7Ynpj0IAw2McRjfJGXi3naxDZLuy5yf9UyjHs8y4AB0mBtLl7H8lrDFI+8umJuoeKWgQYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W08rXg2JXb27CWxBq1GMWSPCrtSBOL1NfSnyWZ7xGtA=;
 b=PonzqXL3TshIhODa1WsJUq1aoOkcjCy7tFzxjUftIAc92b73Y12E2bkEixCBZj6wiN23yAEVCe2EiylNb2iQCNbrXe3Agcd1jwyP7Io9nVDCcIW3hvmCtyrjPS5zL+otF98TnrfFOaud5ULpKd/MMNulNez7i6azgbeIXZI+CoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 14:04:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 14:04:29 +0000
Message-ID: <e67426b9-4ded-4f6c-8309-7f847adb4540@amd.com>
Date: Wed, 22 Apr 2026 16:04:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 21/26] dma-buf: Add the Physical Address List DMA
 mapping type
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <21-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
 <20260413121628.GE2588311@nvidia.com>
 <f6d38a08-009c-4efe-9dc3-6bcf00ac35f7@amd.com>
 <20260422115306.GI3199414@nvidia.com>
 <fd8065ce-fd0e-4df5-9c80-8e9603657cfe@amd.com>
 <20260422131337.GJ3199414@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260422131337.GJ3199414@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2add4dbd-da79-4f21-1627-08dea0781203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RfTLSNZT1IzYxVr1X548uhzClTsv0H8JOYGrUSRB57CYKAapoRXRPIYBEVuRb+Bs59j9/Ok8/D7xxEMptDFy2anjjsYUfV0Z8V/peW/1ZMzjxtuQktHgnHynghWj0ciLQsPbw889hT0F+ZlGA1w1B8SPTM60REd8qwnymOjZvfRWYCXQTX5TDX+bJmSVXZUwM1ybql4KG+65ACFn8YXrExYBwFtp/feYi5c+fY93AOiNGI90owQAy8gs2dbwax8JR3J8xw1HyrUv+jp3EsApUJ7uSncWx2bJsH7q+n15kVB1dW6YeCafUpJEkW2st35Dl3vy5pzYjxliHzs37FQ1mwv4B0MxfMAcOo0W9cp0AdKh1Fn6E4JNg1YQyvAI7VKE4wTA1QLuejQrJVDIfLPChIsihVsf3CQVJikS1qmcykhGWwXyVTYOfBYhviYuYhNiF0bEgGtQXOIqLXig6OJcP2rh081Sm95ROonK0gcYGdX2IHfBZA4c4vg3zCuuoSkjXJoOUSO1nmINPEHujb4JZmgOU8xcfMY4n9a1TPMhb7NpiQ4nGO67q3761SY2i2VUplff029jvxNJDeF4Jff4RYQqDR471Kui3SovTsoPLo7pO8lAxV5ChEiW265wB4LsZ7DKL0z2dXREMZLQjPihdhvZNqNEw0JSfLY3A+5dgZKZ2dIxLhXG/bqlVPG26B6K5czWgPUARZ48cEeUhch6FaONYy2zaY6cRH1ial+FtHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGkxNnhEdkdYK1FyL0xlTmx5K1R6N3NoUEVRTGpFT0VFbU4wLzFlYWVHMW44?=
 =?utf-8?B?S2oxUXQvSEIxbmZmNlFXZXN6SGltK1JBd251QmlWeVhCVjU2UXlPbGIxT3NM?=
 =?utf-8?B?UFluMm8zamZnTjJRSFpzNmhSUzh1L0dtU29EZHlNUkJEcVBOWHptZGtCcUpa?=
 =?utf-8?B?ZHJSaElHRmpMbXNJMkVJRmJVUnBOU2ljRGpDRzc4TWJKTmNVd2lHeW5EeE14?=
 =?utf-8?B?M0lyOEc3aU5iTkJndW5MMVYxa01yTktDTXIray9NdjJPS3VyYTBzZFZkaGxm?=
 =?utf-8?B?N1hxaG1zVFQ4NU5MVUExcjh1ZDBUdWJtRnFlUGkwUkZ6b3ZPaGhmcmNZQXFD?=
 =?utf-8?B?d3NvY3llVGR0U29iMGVoRjlwQTJJRzRMMVdRS1c2WEVOZjh4NjQvSktoSzVF?=
 =?utf-8?B?anpTYWVWdmpWekdIc1RWaWhjTFJ0b2RDdTlOTW1RdkxGeEpmTjcxUHNGUmlj?=
 =?utf-8?B?K3NSSC9xSXRwdC9rUnRITlhhQkwvdjM4QzBuYTVtaWtJM2pwd2oxUGo3dlZO?=
 =?utf-8?B?cTZnQXh1MUFZMDhad0dsUVhrd1V3a2dJM1JLOFM1OXpvQ3Q1TUF5aFd2eDhJ?=
 =?utf-8?B?MEp1a1BNcFZxK1lTY2lWWVFmNWRYTFJid0d1YllBUWVNcVZSZjZRdEFHK0hR?=
 =?utf-8?B?MzdFOHUvQnkzSFgzSGM1TDdtdmVvWlBnWEtzVkhKejUwY2JQM1ptY3JGaDVB?=
 =?utf-8?B?TklmOS94MFhRb0hKNkJCTzNsckJmK0Vidkt1ZFNFWXFqZ2hqRTdsd0RBU2t4?=
 =?utf-8?B?eC9ySElLbzNISlVKNU1qU3V3cmtLNkpia1N6VG9ZdmdSMlZJbHlWQ3BHR0xl?=
 =?utf-8?B?cUVudWV1amJvcXF0SVFyMVhObDBzdGQvS2poTHM3T0hYbHREM2ovcUxtOEdH?=
 =?utf-8?B?VUhuRjFxcUpLT2V2NzN6RGh0UHd1blVXQ0U2UjhUd3U2TWdhRzJPbEdKS1Y2?=
 =?utf-8?B?VjBRdzVMR1Q1WFpVWTNjUG9ZTjVKS1FyOEdoM0x3VG9YNG1FVjJsQ3RHRzNL?=
 =?utf-8?B?L0VrbVZ5ZEtJNTZTVGdJL2VteUVuZTU0bG9CL1lkclFQVkt3VWdFaVIycis2?=
 =?utf-8?B?NlBNV2dMcmpKN1VBYVF3a2I2dy9MR29uWVdHcWJVc2RRMURNVlZYRWlqbm1x?=
 =?utf-8?B?bmRNVG1lKytrVmp1TXVtTDV2UFVsOUxrSHY3STEzZlFmZVM1dEQxM1BFbHI1?=
 =?utf-8?B?Qi9sWC9od0IvZVhIeVhSUnFsUVlqb2FHaThFYU8vNitaRkx6RmlWR3ZucnV4?=
 =?utf-8?B?SXMzamtNTURyYnh0MFBwQ3RVQVovNUNibXdvMlh1Y0dwRW1tN0drdmtLTlE4?=
 =?utf-8?B?aGg1SVU1RXVub3hzZFBGMHZuMHgvWVc5UHBVR0hXUWxlMmluZkdwS0VLOFpl?=
 =?utf-8?B?RDcvNHFKUytLS2xmaEFDbVZjTm1wYUFpd0E0cHljTStNbVEzYmlKVkdBdTBr?=
 =?utf-8?B?LzgrSTdKcTR1dnBKVTVjOE9CSGV5bkpLT040S0hsL3piQkRuUjZyVHdsaE5T?=
 =?utf-8?B?ODY5akNTZWt6WFR0T0pFczZZcGtKZzk2cUdKREVWQi9LV2VmbDMxWm1KeFp2?=
 =?utf-8?B?aWNVbGVPRERkcWhzTnpFRExTcUVIOTQ4bVpVQktmT1BteVZUQkFPRXI3UE1J?=
 =?utf-8?B?TGRKZFJ3bFBub1hTYnltUm93OFVmMk92UlJwWWVTaEw4cCtTdmVrL1g5d3Rq?=
 =?utf-8?B?OHkwZHp5cXF5MEgvYXN4NnFkcTN2QnNtQ1pOSGZEa0pzN2t6UmU1cVlYVzRS?=
 =?utf-8?B?Y2FQZG1PT0JXQ3dGWGYvb3kxa0NvRklHMUxFQ0tyUWp6dWxWY1AvNWJDR3p0?=
 =?utf-8?B?Y0pkTHJVRldkWHAxaXVPci9ZWXphZTdWcTYrNXRibmdIeiswRlhOUFhzMUhU?=
 =?utf-8?B?MXZPNFhwM01TY2VaSXhDTjVhMGkzWDZhamNKWGlCNGlnRnNzaVFzLzZlOXkw?=
 =?utf-8?B?WUJjTmRmUm9aUUNjN0ZZYVVYeGZKLzdKYUIreUltdlM5R1daakVzRTlEbW1L?=
 =?utf-8?B?YXduamcxVjcrcW45QjRuTFRDVkNWbGk3dzNRSEhZcmdScEoxWlpZcG8vUHhX?=
 =?utf-8?B?bGNaOUhzYVhSb1hGSjBxeFRIV0JHVkw5dUI3MlNLckJqV2JnVXp0eWFYQnVQ?=
 =?utf-8?B?M3QrUkJ1aGNRSUx4UjY5bjFucVl5V0dORXZHWWdibGdmK0hUdHN3OVhuZ0Mv?=
 =?utf-8?B?czVIV1pGSFpiczM1dXVNY3ZDK1J0ZWQ4T3ZRak9zb2RjWFYvMXB3anhLbTJO?=
 =?utf-8?B?bGFrT0tPOHEydlVOMDBESXUxSTZ3bjg2bjh5R0dGRzhlVlhpUzJkMVh6QTFB?=
 =?utf-8?Q?rUVvXPDnWAmZtvr041?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add4dbd-da79-4f21-1627-08dea0781203
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:04:29.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YzlEaNLvCAbzrECi/swVyGc0XqF4yBHARatujO3tXScsnHzDMMOgR+Ayn/j5IOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

On 4/22/26 15:13, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2026 at 02:39:16PM +0200, Christian König wrote:
>>> Can you be more specific please, I still have no idea what you are
>>> thinking in terms of an acceptable implementation.
>>
>> Let me try to describe it differently:
>>
>> The iommufd deals with iommu_domain structures which userspace can map different things into.
>>
>> So of hand I would say that an interface to map DMA-buf into such an
>> iommu_domain should look something like this:
>>
>> dma_buf_map_attachment_iommu(struct dma_buf_attachment *attachment,
>>    struct iommu_domain *domain, unsigned long iova, unsigned long
>>    offset, size_t size, ...);
>>
>> The DMA buf exporter then maps the its data into the iommu_domain at
>> iova starting with offset from within the buffer and size number of
>> bytes.
> 
> Well, my first reaction is very negative, this suggestion is leaking
> deep internal details like iommu_domain out of the single place that
> needs them - iommufd - into about 6 exporter drivers. Not nice. I have
> the mirror of your concern that I don't trust DRM drivers not to abuse
> the iommu_domain pointer in some very creative way.

Yeah, of course that argument goes into both directions.

The point is just that we have much more importers than exporters to handle, and from experience it was always the importer who messed things up.

Background is that the importer integrates the buffer into it's own handling which might not be made for the way the exporter is expecting things to be used.

The result ranged from extremely hard to debug data corruption issues all the way to security issues because somebody used vm_insert_page()/vm_insert_pfn() with a different address space object than the exporter expected to be used for it's memory.

> However. With a suitable helper we can largely isolate this to a
> single function and yeah I can see making this functional.

The important point is that the exporter should not need to expose it's physical data store and how it's housekeeping works.

As long as we can guarantee that I'm fine with it.

> Not sure how this can work for KVM, but I'm getting the feeling the
> way forward here is to "live and learn" together.
> 
> So, in the context of this series, your proposal is an iommu_domain
> mapping type, to replace PAL. Yes?

Something like that, yes.

> Do you have a positive feeling about the general mapping type system
> from the earlier patches?

As far as I can see that goes into the right direction, yes.

> 
> I think if you want these kinds of APIs there are going to be several
> mapping types required to exchange their very narrowly defined
> details: scatterlist, scatterlist-ng, iommu_domain, the Intel vfio
> thing, UALink, driver private interconnects, and whatever KVM needs.

Plus those strange device to device interfaces you find on ARM/Android which people currently manage out of the upstream kernel and happen to break all the time.

> Thus I think this is making a stronger case that we should have this
> formal negotiation protocol between exporter and importer for the
> mapping types. 

Yes, absolutely.

Regards,
Christian.

> 
> Thanks,
> Jason

