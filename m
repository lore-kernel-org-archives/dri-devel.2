Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6B606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xvVaaSbT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B0410EB72;
	Tue, 20 Oct 2026 07:01:47 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D9810EB72;
 Tue, 20 Oct 2026 07:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLujvodZxR9WZAIJ6yqMCP7dleiSfJTU8uQ4WaKoUf0AKuAwFEu8HPzR/b/reZGDpozpqg53LyOikwgf19CAedyC6drXPvLAcRIGOsq9tvC+J5L8vkhKfLUjx5f7SGqHfxbllJh3wt5sFKyAldIlBTnCMP+lbUgD7x4hZPv35JyFc0H07DLG3bT7XcYiPRdazSccchfOsvx2m0EHmaQtXyyPDDLYRbVL9HrDYgLhAwVsZhAuXshV6MsriHCx/4lBXSydXMoApt5jwMI/699dpMbSbX++98M9mpGW0CEyTGqK9xoYwZ3Cor20xUfD8COV2t24qWa5ehdMe/IzAQ4Uyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK0J6qY3sd69gFDpDkaE1bSLOP5GqLHxHfkAYssUQtM=;
 b=xpmgNiy3IOAgGThZGWpvnMdSq0UF3kjFa9bfCNuwXKEv7f1jmKF++e8FmuWH91rpC5aWGJq1/PN3Tywf+xU4b2IYHa8dEJZ8B8TJUGNzCsYNxTR8kZnniKMxnwZCMmIW3llqPEQ0hElc/SYXRr1JsZ54xXjGdHz41YGP6SJ92InPoU9h/nISr7g5tur+E6tNWalCxAKDxNYOwPEEoT0kLUiI2tQJaxBjhJcdrE+Y4gBZWlARQ7lD43WFGaU8QOWl7rjPHs5frIrzV3e7rfrFMDF/cPlUtm2BN7ULXW4BatTHTnddAmBV6fbrb3eTyYIin4VhTpqQI8klzIUCDA9TQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK0J6qY3sd69gFDpDkaE1bSLOP5GqLHxHfkAYssUQtM=;
 b=xvVaaSbTtpIBq5dsl0GR0x21migSo5U6ZLQDOHOHES7wyxb92tAxKsW8qQlx4ikz3FGrUXk4JGuZWlMWi+eI2LnV+XGYbdLcJ0ot5xDb/H8LoQLeyxeUB3YpLfHhx741gRSdUewzwXkvj4fKHVyAxVPAjP1J6dH2JsvVs23+9qA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:01:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:01:38 +0000
Message-ID: <41bd4593-5918-4cda-922b-251805c25b60@amd.com>
Date: Tue, 20 Oct 2026 09:01:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
To: Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
 <20261019133031.GQ13920@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019133031.GQ13920@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bff890-64ca-4f20-d95d-08df2e77fc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|56012099006|3023799007|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: jQyqjeAa0Z+QzRA0if+T2AgWuV3F3pl0t9UTLt1IaFi0y1JU10cPrXQ4DwaCDykNoat3ydJTL1KqCPzno5jdug5Drs31hcwb4RmMBEWqi+ZG7C8CIm5JeZhVk+zibQEUW/Ri8SjIQiiK2LMlmcqnjDHaSlp9dri+hf4ELg9uA6dCCCDMR69EaJ+tdsXn6SsXyZ4aHC2JMm8II2GTVT84PFTXiZhC5OJttT7YVvFMeAOxN5XYCK/29PsjJchtPpv/BPyrOdrH1jxuHbdMFOu2BFJpceLZZjkVt/yIXyFKxgZveyPMwVO3LGMLfgq2gmGndUaPBnA6msrjt98P0q9u4kJDO6YMp7DWZoujuMmWjpSutJEnItuVApxlQgG036sVzdNuKA/ceol8cwqLpxgQ3+XAgoLxKI3HvDYyUpZQUuH/pwuU3W3WtlDAjndF/wkchk/htlGaZqt1HEIgQ3eC3TXt6z0yvCXhgChUi/qfJM4hTP/cRgklENdOwb3XYAyItMiT0wJO4VwipMhfwD4ZGrCLpYEelcBUB8IuonKkYrIEh97eL+FZz9NUrEcQni+jaG1nbuHRxpUeBaX/ms3Qo0WZiWJ9siSb6l85pwZRsYRZbSVLcEFtVKgi1SSlSPZWAfAiITkQLho4rnCQDhsUVnlcaMhd73/FrCZzCfVMbg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFZHenYvRGY2dlNNSko3S2tqRGpxOUNuMDhIajNhU05rRnNESjdRc1lrTVdC?=
 =?utf-8?B?T0ZkOXl2Y2J0TFl0Z3p1ZTJqK2hPVzRkUGs4a3kzai9nbFYweUsvdFo1SjlD?=
 =?utf-8?B?RWErMmJoYjduV2ptK2RNcGN3b2ptL2d1eGMyZWxESk9IdmxQRTZlT0d6cXhK?=
 =?utf-8?B?MTdTWEE3M2tuVWVmYU9yRjlLNklwTEVVaTJqbldjdEFOUUt5bmFQTmlJdmI0?=
 =?utf-8?B?YUcyWVN1blVYU1BEdm0zOEpzOWcwS3JnSGFjZTA5RmlURjlaVm1BV2o3Tnhr?=
 =?utf-8?B?Y2ZxOUlDc21BMXpKa0tiWEd3N0c2bVZBNnNHQmtiMmMrUFZHZmZjRTNFdUVj?=
 =?utf-8?B?bU9vTytteEpsWkhKb0ZzeFYyVnE0YlZlR0NLeldoTW1QdWtMRHpNd1lFL2FX?=
 =?utf-8?B?R1NVdXREM1pRd2tTajZYeThWK2lQbmtNL1ZrMjVBY1hYeDhnclNTbGtQdGho?=
 =?utf-8?B?WFdkdldnVGthWGhENGlLS290RkgyNEcrb2Foc2tORWVLbE10VzJmR1RQMC8y?=
 =?utf-8?B?d2c2ZFdoZXd4ejNNNXlaWWhDVVVDVllVWDlRNTlDMTAxVXUydVZWSXNFTmZ6?=
 =?utf-8?B?VzA1Q1ZqN2x1aE4yWEdJcko1Y0JFZTZHRzRNRklNbFl1MXRLZVJ4TXlRM1Nr?=
 =?utf-8?B?OVVodE1YRHhSU0RwL25Jc2d3dGRqNnUrOGJSYUNyZmtvdk5QMVIweHVOT280?=
 =?utf-8?B?M21zc3o4UFBNWnZ5eUpzOVlqajAwdHpVVWFFWGUxdTg1enh1dVoyd0ZRZjdq?=
 =?utf-8?B?dVJvY0VMdWR6a1R4N1kyS3M3Wi9IWW9PcjhOOGNNRVdKN3JlSFZvdDNPYWkz?=
 =?utf-8?B?aEVXTDBJMno4WFV2YTlkNXZsZHBTeCt6RGR4NXhLV01xdloxZjF5SVg5b01D?=
 =?utf-8?B?QUV2bVU3S3p4dEIwQ0hVUGswcUVGbUZxMWMvRXB5RWt5V0lZMDhDczN6emgr?=
 =?utf-8?B?YVUvVkdCT3QwUERHdTRXa0hzM1FXa0ZyNXBacThJRHBad1AzS2pCUm5Tc3dI?=
 =?utf-8?B?UnVqYVRCZlBxQW0wNnhrN1ArdVVQb2crL0dHR2lMYmwyVUNSMkM1M3Fab3o4?=
 =?utf-8?B?OUVHTVVESnJxeFp2SFZPMXdid1lvUzV6eWFMdG5pejEwaVNjeHRVbzB6RjBp?=
 =?utf-8?B?MzhUb3BnV0lYUUJTRU4wbTcrczZrak1hanBzb29WMDkyTWRTNUplMmtrc3ZR?=
 =?utf-8?B?bFE0NmpQeWZwbXROUFE2b1BxRnppY2RIV091RGVZUGMySmU5VUlRSUhBNllX?=
 =?utf-8?B?M2tlRUpBZDllbjNDUUd0VkN5NWZrS0h1N2lTYjRYb0dpRmJDQkR3UnRMYkxr?=
 =?utf-8?B?c3FuZFRiS2IyNFVXWXVqYWxOU2h0TWdJc09hZno0d3ZMNzFjaG1vcE5nZGdl?=
 =?utf-8?B?dE1JQk9nK2lqb216aitlTEg5NzdGWHJNNENIdUhmVlR6c1gvZmFFbGhZdWVZ?=
 =?utf-8?B?MEtTMjE0VXI4TzkrZWNzT1MzWFJUTzB6WWNqZGwvdWw2cXczRk44T1g3aVZG?=
 =?utf-8?B?RGRwUlhQcms0TGZ3VU1KMEFmYjRqTW5BMVNHQkJ5Vk9iV3BSTEduVmt6bXFI?=
 =?utf-8?B?MUV0T2FVa0hERUJ2UW52ZFZaLzhiOVlnQ2xBNlhwem9haEhTUU1pRlVRWXdi?=
 =?utf-8?B?ZmF6MGIyMldkU1hmcnpJU2hKb05ZZkJkSmR6bkxzOXFkNnFaZERPcjYwL0V6?=
 =?utf-8?B?aXY1Rm1MTHpQZ3lDQnBYK2FNMzB0MW5wQ3FiS2hPK2E1UmFyTXgza2c0NXA0?=
 =?utf-8?B?bWxicmZYQTc3enZVRGRJWjh6MmZDM3RjeGoxRG50czV3L0ZaQ3hNTm5sVXFo?=
 =?utf-8?B?SUVoNXozVGg3bGJiY0JtOXF3NStkS21CdTg5K0lOc2NIRUtTcmpiK3EwTVNo?=
 =?utf-8?B?dGFlc1NMR2lKM3BPdjZDNU9JOEh6WFhDMjBSV20zNUNIekxJV2h0N1g3S1dn?=
 =?utf-8?B?L2NGQnhqSk40UWlQaDNpSFFYVVkyd1ZhVStSVXpSdTh1Q1ZucTZIZGFsbXFk?=
 =?utf-8?B?QUx2WGNjencyd3ZZekRQUkp1NDRNaUhpYUloN0xCYWtRcHIyN29HRGsxZDNE?=
 =?utf-8?B?SzZDdmRWRW1aS1YrNGpMc0EvVzBOTmYwckFSNml4d1NzZW9zem0vVDkvR2JB?=
 =?utf-8?B?VG01Ukc5Z2lXeXlKWDlzY01MeWgxbUFkMHRIeGhqZDlXcGkyaU9MaGw0a0Iy?=
 =?utf-8?B?WVI5czdueE9ialc1ODI2SEdXM2I1UVRVZkxPZ3JuTElia0EvcWFmS1liQmtG?=
 =?utf-8?B?czgzTUtjZ2Z1bUhObUxKVUJEMFNKU3VYRlZQZWxDYTBlM3VvY0V5M1lvYVc1?=
 =?utf-8?Q?vDJfvB7NZrO5szOHQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bff890-64ca-4f20-d95d-08df2e77fc75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:01:38.3126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQRBRHpI3DcSTP/0xoNC2XhsngvHtwrHXonxy3I2efo0wl5GH/5D0emWss6s8WTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 15:30, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2026 at 02:43:29PM +0200, Thomas Hellström wrote:
>> On Mon, 2026-10-19 at 10:35 +0200, Christian König wrote:
>>> On 10/16/26 22:26, Karl Mehltretter wrote:
>>>> On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
>>>>> +	match_args.attach = attach;
>>>>> +	if (dmabuf->ops->match_mapping) {
>>>>> +		ret = dmabuf->ops->match_mapping(&match_args);
>>>>> +	}
>>>>> +
>>>>>  	attach->dmabuf = dmabuf;
>>>>>  	attach->importer_ops = importer_ops;
>>>>>  	attach->importer_priv = importer_priv;
>>>>
>>>> I may misunderstand the intended contract. match_mapping() runs
>>>> while the
>>>> attachment is still zeroed and without dmabuf->resv held.
>>>>
>>>> Patch 11's amdgpu callback needs importer_ops and importer_priv, so
>>>> its XGMI
>>>> match cannot work here. Patch 12's VFIO callback asserts dmabuf-
>>>>> resv and
>>>> reads priv->vdev, which cleanup changes under that lock.
>>>>
>>>> Should the core initialize the attachment and hold dmabuf->resv for
>>>> match_mapping(), or should callbacks avoid attachment and lock-
>>>> protected
>>>> state?
>>>
>>> Right. This completely misplaced.
>>>
>>> The matching can't be done at attachment time, but rather needs to be
>>> done before creating a mapping while holding the resv lock so that
>>> the matching decision can't change.
>>
>> So question is what exactly should the contract be?
>> Looking at the pcie_p2p negotiation today it looks somewhat like.
>>
>> 1) Importer and exporter agree at attach time what mappings are allowed
>> pending placement conditions and other attachers.
>> 2) At map-time the mapping is negotiated taking all constraints into
>> account.
>> 3) The negotiated mapping is valid until an invalidate_mappings()
>> callback is received.
>>
>> Following this would allow a re-implementation of pcie_p2p as a mapping
>> type and would allow a controlled link-severing to send an
>> invalidate_mappings() notifier and the mappings to be re-negotiated.
>>
>> Importers requiring an early hint as to what the actual mapping would
>> look like would need to be prepared to re-consider at map-time, with a
>> reasonable assumption that the reconsideration and re-mapping would
>> happen seldom enough.
> 
> The idea was the supported mapping types are fixed properties of the
> importer and exporter.
> 
> Like iommufd is not suddenly going to start understanding ualink after
> an invalidation.

Yeah but I think we can sort things out early on.

E.g. even if both devices can do PCI P2P we can't use it when they are not under the same root complex and there is no routing between root complexes.

Or both devices have an XGMI connection with other devices but are not physically connected to each other, etc...

That is something which doesn't change unless you physically change the system.
> Further, I had the (perhaps naive) expectation that the interconnect
> option was not something that would change during mapping. I did not
> think you would loose your PCIe option if ualink becomes available, or
> vice versa. Though on deeper reflection I suppose someone could build
> HW so you might loose your ualink option if the dmabuf is moved to
> system memory while PCIe would still work.

Yeah, that is definitely not correct.

We have the clear requirement here that when one interconnect physically fails that we can still do things like let the work reach the next checkpoint, then it is taken of the HW, and the HW suspended for repair, then resumed and then work can continue....

Similarly we have on the graphics side the requirement that physical placement can be moved to system memory because of some other device attaching, pinning for scanout or something suddenly requires the backing store to be contiguously allocated etc,,,

So there are vast requirements that a buffer changes location when the mapping changes. I mean it is kind of pointless to have a feature like ODP to suspend your traffic if the underlying physical location of the memory can't change.

Christian.
> Making the decision right before map seems like a reasonable
> enhancement, but I can no longer remember off hand if that would cause
> complications :)
> 
> Jason

