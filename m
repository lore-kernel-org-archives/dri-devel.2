Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5132BCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FC910E12C;
	Wed, 10 Jun 2026 11:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSfHdOk/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4733410E12C;
 Wed, 10 Jun 2026 11:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA3q/UjDdIJzK9CnjM2xd830JwL1YuHccfW1eyxiL6M8qz2e/4tdCp2uvXnbRF91Lhc5rvzVvIsBmfqAsM0QnYTRFCuWAibQ4r5fioHuwK3iE203s0wzLMltMiPc1Ftn/mSlzDtdZPkOmwZsetS7yywRFzWlY4vtlcEZ5jrk00X1U+VI7jct4AzEq2f8BT5CnvFSQTgJlCNK6MQVrl07ud4bj7S6EeHw1bOudvbE7zow9UVY/sH/0xx7l4ORN+V96LC9j7fqkblQPGBoOGw1PEexgn3PqVYTkhkn44Xy6OTZFRPyXN8QJScoSVdXlrBuRwPJbMdtjwK1KHR9xAWQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uJ0mevEL5aJiwOTZThkFmy8yYf4Pm4la1D2AXU+lDc=;
 b=EUU5/842TYX6GP1fpnxwDm6/6ZHA7YjSELKUaG24+HH1ZNeO7NkjPxGf02UTGM/IlNFezHWNcwRf2fHV1djnMT86IA/j5lrLfKeUm0FtQ4rUkmBqytifRKxQSCTtjloG3Tx9IbnR/BY0vfxb4Tx890AFyFuaRdF66pwG/d8udvc5ON1X69igX2qiN+QBJV/PzD+KiBLTBBp9kWTJlXsVElLx+0MAl2Po6dnYaMYdZ4U6KzCCRo12jYjXZvTZp+zUh6Z4vCKFcgP0wVsUwAoqv0anO42kzbnyw2cziSvvE6l/0NUUoVuVrmx8zGIO1hdYNZHR63njCVpiC7ehee9LTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uJ0mevEL5aJiwOTZThkFmy8yYf4Pm4la1D2AXU+lDc=;
 b=iSfHdOk/AoHQUzYa2a+VsDZ2ZCJgb3Wxk8mecTek85p/GB/mXqbrIEV49S/q4EulY+aosqOkmj/1H0dmZ/SKbvgAyDmhsbLGJZ9Kr4nl9IyBsbbremZySOoPmhfAaEBOEDoJu/pSV+Fs+fgCIG3Z46CYBiXmiMnC7Sby6Fw0wCwbaOfJsIla2sk2M0tWu6x6wvGHNEoI4LApaF0bSNFOG58e7EcdEE6gw0GtfpRNFB5zAiUOL0G7gjpSfQNGTkO3n24oB10R6jeQ8+79x63QhEg2dzg2Y++YTZGq5rJ6UXgOA+ZuC8NoAxSIfDDDAG5r5h7JhVwXpfjX89BCsTAqQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 11:18:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:18:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 20:18:35 +0900
Message-Id: <DJ5BTNH028R2.39ZJSHDNTZ0MV@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
 <DJ52BSFTRYBX.2ZR8NX8A5H4ML@nvidia.com>
In-Reply-To: <DJ52BSFTRYBX.2ZR8NX8A5H4ML@nvidia.com>
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b819a38-6d11-4e6b-c39d-08dec6e2059e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N5xisU202xyP6Nz6oMuKCGC6xijUbJXh4tOXx//6OTAaBiPoFBuvux+wW/L0OUQ0FKgCFdViwP3nFHnXrg/6zH9OwftN/69QzQHROX0JfRXxoNDiUXLIUlZGaYDQC3HRHv/H80Pvc4BdeKTwKXpcd7zGL9j/Coh+cf6pPBAv/XP6NILEtFt1vTW6n78pUIVP3ClODmfft4aRD2UCOevLdmeaXVMoSoqgmt36jn4MAkUTIMD5sblju4kj1dgp+7mAB2d6G1fsBgrq6YCKIq6zMmhewoS2QDjI9o2n/Ajlots8kB/HN5hycOaAERWZHnOfVBGf5O60W2c73IlVOtw6ebDxJLZM+jF16ARpLiRmCfygkrZoL1fMgzJI0QN8PXv/+R9bbhyUOLhGap+VQI37xbMSt5N2iBou5NYAcRyfEVpZU7Xrz3egBxGaxRzkh6vahu1Vf7gzyBXo9B7pOCuTIUQW/gu8dDmRaeCVwVzkEpgobf1HXy9goZpQE+aF2WvYHvOLSM7jWhQkLcmf4CN323hT/5hF4kd4wNBGFTUn0xwgXqMdTLqLd68f7tMa20GohT1tSQCz2jmdZggrm5+5LDLKHArnZlU68e10DnxxvFKihqgzsKjCPSTreePPaynJW4bvbFvwhjADnF8v1e6fG/nbcxx3yEcvPbydiIPywsnjy4RiRl07MI1+YEIHduI/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZjNkE2MGJJL3J4NzNuRmFlYnZwZEZtQWZKRGhSRDFPeFoydjltdTNGRTFU?=
 =?utf-8?B?U2lKMXdIUTBYcC9qSllkL3Q5UkYwT1duajhFRjEzQ295UDlNc2QxeWpRMTBK?=
 =?utf-8?B?bnh3TWJqZDkzZXJVeGZSZlBmaE9nem5adVZNQkUvUFVIUUlpc1V0eUFOa0Fp?=
 =?utf-8?B?OGlHYzBRR3F3OTdSNFFCZXF2cllMTThzVkZRRStYSk1TOGRkTFlqU3RUQVpD?=
 =?utf-8?B?ZEpLbHhXN2QrdU12V1Q1UldBaTUxUGRsdWZQUHd1UzY0bzZVRGNya2d5aGh2?=
 =?utf-8?B?eFhIeFdVM0lPRWN6dnFpNzNWZSsxZHJPZ0ZEVFIzakd0M0NpeHh2c2gvMmRh?=
 =?utf-8?B?NGUweU5pQlJKQ2VVWk5lK3FYYjdTVFRJdW1jWXkxcHRBMHFVaFZpTnloSXVP?=
 =?utf-8?B?YytMWnFxTnBKQWxKejBaNWNvSXZydTRQZWhFTlFyd0pjOWJCeXBUK2hVcDRh?=
 =?utf-8?B?SGlJUDVQNDZJR0d5TGNsQTN2a041eTJOWDFSK01GK2krNXh4Vnh0T1c5SEk1?=
 =?utf-8?B?K21PbHFNeWgxeXdHUjdQWlljWmI2cjdEWXo1TEM0QTUxWElKNFNFTUNmWkNJ?=
 =?utf-8?B?SDBuQTJzdVN4YWJhL0xVbXhMR0twVjJrazFPOGd6Tjduc3EwY0xWZVFiNnNq?=
 =?utf-8?B?Qnl1Y2dDQ0FKVXFxc0hWeDVadkxheFJyYTJ5N0lZTUcvUWpva1FDZjJBaCtM?=
 =?utf-8?B?aE5oSy9RMS91Y1ltQ1JRR25RTGVIWWplVStueHdsTHpDRzI0cUpzaXg3ZHFY?=
 =?utf-8?B?S09UUEdHeCs0a3RPeEhDRXZpR2xleFU5RmlXY1dQQVloSHFBOEp5RUVVNmVJ?=
 =?utf-8?B?ZzFoOU9hQTBhK3l5bExQTmZQTkpnK1RpR3NyNStWbk9iOXM2MGJ0MzFFVStL?=
 =?utf-8?B?TzZZUjZyUjIxc2NBa0NHNC9OVlVtZVNpMUdHMWNrd2RjS0d1NnZJaHk2UDFl?=
 =?utf-8?B?R2xxTHhmSFZQSzFIYmwzbG92SXgwMGlucHMxRkZxaVFRNEtxSDFhNkJ4RXUy?=
 =?utf-8?B?UlVjMkEyeW1yZkRQOW5ZcHc3STh6RVpZYWtrM0VpZmVjenpUSDRSTVY0WDBx?=
 =?utf-8?B?VUpRdjRVdmhrekhzeER6K1gxRG52ck1rY1dieTF3TXZibEIwTzRMUmhNMTdh?=
 =?utf-8?B?amlCaTVXQkZlZHRrNGdMUXBEMnMyMGFXcUZ5bUI5bVloenFrci9sY2ZZQXBY?=
 =?utf-8?B?NFJpaVdISTF0MER1YVp4L2lsRkpwUzJydmRMY2ZOdmYrQUJMSDZVRlBIN2Fv?=
 =?utf-8?B?U05aSm05aVAwM2M2NjJKVkJwSC9iRHExSUpXdmtqazNhSGhaMk9Eb0tIa1VT?=
 =?utf-8?B?QXROVWthdlBIUDFkc2JKL1NEeDZHdmF0dVd4M0RDR0wrOEJ5MDEwYzljcHRS?=
 =?utf-8?B?by9BZVRESDhONXV0Nm9LOXNOaU9qbzI0TWZpSHRoNFFib1pheVd4UnA4elJ4?=
 =?utf-8?B?QWNYZTg1QjdxRlNEaGxsNjJOUGlNd3JkMmNSbjIvaHREVFFDc1AzSHVhM0VF?=
 =?utf-8?B?QjFkN1k3QUZMSTFpOVlhM2J3V2NNc1l4c0J5RDFMdTBUb3ZMcFJYNnFId2dh?=
 =?utf-8?B?Sk9WWVNvQTY1NFRVSzF3aXd5eTd5eFppbXVoSUpiUW1SZnZIL1liVzE2NkpB?=
 =?utf-8?B?dWVTK3ZBNE5xdWwvc2RhRjhWdlNrL1RaMHdKUHhZTzFVeU1BR3lhVEhhMTV5?=
 =?utf-8?B?Yk9sMWVsK1RtYlMycTFpSDlIQmJ2OWFPNEtvRkkvRGx5aGJLenluZC8yVVRV?=
 =?utf-8?B?RFJ1b29ZdTFzN3g2b09TQ1gyZU1ESnFwSUxCTmNUeVdsS2lMWndXSnpPZURB?=
 =?utf-8?B?VmIvNXM0di9XcjZZaUNyNEc3U0YxbkNmbjJJb3hKOXVMZE5UcXVWSzVWN3BN?=
 =?utf-8?B?YmFXN0JZOFVjMzBFNFFnakMvZFdNY1EzUG1CYlh2TW9CR1ZUNlJpSitoNnBU?=
 =?utf-8?B?Zy91N2QwYzI3RWRXUENJbG4vbmN3Zk9VcnMvMlZ6bmQwZGVPQUxQV0lWNlow?=
 =?utf-8?B?ankwcExUVlFlR3pzMTNhSk1GNXNHbmhnWE1zaTdPd3J5RG9iS0lGUUZaVjBH?=
 =?utf-8?B?Q0JOMXNWYXB1MHFGK2xTS3JJSDVGVGliQ1NWdUM2cEtLaGpIOXZXNFZ6Q0Mr?=
 =?utf-8?B?cXU4QW5pNmlicHBKcm9jMllqYkF6OXB0WktjdE83Nnh0bGMxRDRQb1YzWkJq?=
 =?utf-8?B?ajVWZExEZUxPMnRuYnRJQU9GTHE3cGQwU09GMXVlU2EybnZsVFM0c00xekxK?=
 =?utf-8?B?ZUNiZElCZDB3YVgwKzNJQkgyZjQzZnZZejVnZVgrd25maUJsdUNUUHNOQkds?=
 =?utf-8?B?NUEyVmpMQWxTVEdPV05UWmJnWWl1enFud3dROTNRM09MTEcrNFpYbUpLdTkx?=
 =?utf-8?Q?p9BvaXrG45WOEFq+EtE61xNQ9Yi0kYO7iNsLXoDrraqvy?=
X-MS-Exchange-AntiSpam-MessageData-1: O++i46bZt7vGEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b819a38-6d11-4e6b-c39d-08dec6e2059e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:18:39.4748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5lZcgjxyFCMSw9EqqHSQyaWZu5cADlBJ96IEyux7F+kVXomHNQREB9E6v+iPOJhXeEgcDDwJI6YD5F1BW37cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

On Wed Jun 10, 2026 at 12:52 PM JST, Eliot Courtney wrote:
> On Tue Jun 9, 2026 at 5:03 PM JST, Alexandre Courbot wrote:
>> `Gpu` currently owns the state needed to unload the GSP directly. This
>> means that `unload_bundle` has to be the last initialized field: once GS=
P
>> boot succeeds, any later initialization failure would leave `Gpu`
>> partially initialized, and its `PinnedDrop` implementation would not run=
.
>>
>> This prevents adding fallible `Gpu` fields that need to query the GSP
>> after it has booted.
>>
>> Move the GSP state and unload bundle into a dedicated pinned
>> `GspResources` object. Once that subobject has been initialized, its
>> `PinnedDrop` implementation will run even if initialization of a later
>> `Gpu` field fails, ensuring that the GSP unload sequence is executed.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs | 86 +++++++++++++++++++++++++------------=
-------
>>  1 file changed, 49 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index b3c91731db45..6b3e02c71dee 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -262,35 +262,59 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::=
Result {
>>      }
>>  }
>> =20
>> -/// Structure holding the resources required to operate the GPU.
>> +/// Self-contained resources to operate and drop the GSP.
>>  #[pin_data(PinnedDrop)]
>> -pub(crate) struct Gpu<'gpu> {
>> +struct GspResources<'gpu> {
>>      /// Device owning the GPU.
>>      device: &'gpu device::Device<device::Bound>,
>> -    spec: Spec,
>>      /// MMIO mapping of PCI BAR 0.
>>      bar: Bar0<'gpu>,
>> -    /// System memory page required for flushing all pending GPU-side m=
emory writes done through
>> -    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memo=
ry-barrier operation).
>> -    sysmem_flush: SysmemFlush<'gpu>,
>>      /// GSP falcon instance, used for GSP boot up and cleanup.
>>      gsp_falcon: Falcon<GspFalcon>,
>>      /// SEC2 falcon instance, used for GSP boot up and cleanup.
>>      sec2_falcon: Falcon<Sec2Falcon>,
>> -    /// GSP runtime data. Temporarily an empty placeholder.
>> +    /// GSP runtime data.
>>      #[pin]
>>      gsp: Gsp,
>>      /// GSP unload firmware bundle, if any.
>>      unload_bundle: Option<gsp::UnloadBundle>,
>>  }
>> =20
>> +/// Structure holding the resources required to operate the GPU.
>> +#[pin_data]
>> +pub(crate) struct Gpu<'gpu> {
>> +    spec: Spec,
>> +    /// System memory page required for flushing all pending GPU-side m=
emory writes done through
>> +    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memo=
ry-barrier operation).
>> +    sysmem_flush: SysmemFlush<'gpu>,
>
> This means sysmem_flush is dropped before unload is run. Before this
> patch, PinnedDrop runs the unload bundle before sysmem_flush's drop
> actually runs. But with this code it'll drop sysmem_flush first, and
> that isn't allowed according to the comment in fb.rs saying that it's
> needed for falcon reset. What about sysmem flush into GspResources as
> well?=20

Yes, Sashiko also found the same issue actually. I will fix that by
declaring `sysmem_flush` after `gsp_resources` in `Gpu` so it is dropped
after. Initialization is done in the given order by `pin_init!`, so we
can still initialize `sysmem_flush` before `gsp_resources`.
