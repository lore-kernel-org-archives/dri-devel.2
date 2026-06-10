Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CFDCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5E910E47B;
	Wed, 10 Jun 2026 11:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cda2vc0f";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5422210E47B
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsGa3M7O35bp+8hYKCUsmaS7z+W2St5tmjQfEO3QN9WCkf45b3lNgNRS0QvaTPlLW8eqynv8V0b/Ct9NEbszEPnzQhzbW4UUcoDJNpw39rdVkSQI5qY07xOLyodP7aB1ofjn/wfr/PGcWcNsR6/BCcYs9fMRCtPvs/owvbODZeO9ju1i1i5FkI6MHOmf2NW4jwLqPx+Nz4NLfGykIycOx7Tw3MgIQFXZTsSBTTGn+XZu1Nuw6rNahsaNeE6Go0Nqwq19yepIbDLGgyEcapi4FwJ1gJvPau3fHhQPwQFAUCCUu/1i8jVHN++GHy5nGW23bJsBwHiiEkm3er7vPNuKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ng56DucLzEki2woAZfq1g8gezr55yqJktihvObQIXM=;
 b=LSMlxyMNa0VR9kzvQPCZMrFZdKobD4pOj7kHREppEDGZ2R8P4HIY/RDw+H+goS7bYSvIRqBabxH/BBV2sEHT+TEznXDQt/spspmHuHQ+9Illqa6WxT/2kHY4LAboKGU3wKAHg53R+X6KJ9z0VZdlb4Fy0UxlbgJeDzgXoGdbyWAzt5oDvF7yY4JYkDTGX9z6xYMtBjh+M0Ow/QjDIDgJSF/S63reYqpSCbV1HoErji+Cq7vs18KrCo0p5phVbK0hMCePDSf7z6ugQ8OFdfXaiMh9TLSnnDSntTCNntEJszeZCP88PsxJMmAhc+OJeHs9hpU0FG0Yr/oF1fw4s5WLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ng56DucLzEki2woAZfq1g8gezr55yqJktihvObQIXM=;
 b=Cda2vc0fHjcHm/BHkv0cM1Ij7CJxr4o4eL2y44HxRaJyilzQ1Qv9aZ63ugpba9/uBzU3z94ia+Os2swt9HX7Zi09nAKtgA4dYO6AcNtUIczJr2PvFr2VndQjfy2NgTK+yJNv+by276mbVJkGerjcUHI8QSR8Fd/JEimUjhgT2luTW+wgi60aXOuJwuI7LZ8bf76HBBDbbw2VhT9jhCCehcxTp23DdYWzGOLrtDKcmsE4FC/xg7+A5h0doEqm+7lDwec/4EBr499bpR62JbfWw4kmblB4YOHit1/lz4qQq26z0HLRuV1HUUm+tHPEt8GDNnaoP3l/eEeB9GqRNn3AeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 11:21:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:21:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 20:21:29 +0900
Message-Id: <DJ5BVV2M6N61.BW2CEGDHLZPL@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
 <DJ5AG8OR68WR.3U4JD92SWJKPU@garyguo.net>
In-Reply-To: <DJ5AG8OR68WR.3U4JD92SWJKPU@garyguo.net>
X-ClientProxiedBy: TYCP301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: b3068a2f-dd63-4891-2837-08dec6e26cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: j1FYG8KKFriQFjHVx+c0zuSEvvDObMVBFfFz/92gykNCPNTnqcu+E608NKFGjvzQVVFJHXxwGvEUFCyjl9ZCMGofiLV8K4/Weyf2W+rn2jQ/ai3M9pKgApQu+QQtbfEW5n6285lddL7XMrutK3Uck6LC60iR6DB7FqM+62h1ZlSdDGeOyDS74LEAIm2nz0yRlmn91WatN0lTrwIxAkrqq2Eh+E2Q2j26OK8BHGORS88vJEJzJJWy8oBr3IOri5bkC7nYlJykftIDjVtD+UPgd7n52ZB+TzFYY2ukxnmwjPxkLQtcpt7t6ZjFwhAnq9HzBVv8SRM98SXXGkDjWaL4Fu79otkw56QtAK5ONH1wv6dB2DwmpmDBDi79LIUf4MFmObzm2HqU4Bz7pMz+sIOhbTRAO9e0sEd9QAo5N56BalCh9GJWa/u7I8BqzUZ3EqgCMyQT4RxLgcuWZbXb473B4/DXmNk7XWmJYY3WjGQodOUcnpUbh0s0LxTo2sVyXlaI5aBiAk7ht4Q0aU87J3kfEIClTqPjqEtFp6UBcvWPFzuBLTIhGKTW9w6kvsS/gyadiUWfI2RD9GTJ3/SE/BN5CHNnFF4zFKnUx0ZBki2aJUVxM6QHUjg7iWlEmJKuB0cPsksVGSjN81i3fPKxGwRo9r1cu0vw2bILXVlRfv0Is00MhK/ZW68Ju1FzIkYRjNEi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVKV3dOMUdMbXZnQ3h5c3NBTTNGUTBGZWFxM0xIbmZWM2xOR3hTK0Q1dTNE?=
 =?utf-8?B?azY1WjAycFZ1K1lSOUlPNDdLa2NaVjdkWkVIU1dXZGZZV3U0TU5SRkRLN2c5?=
 =?utf-8?B?MmV0WGhKbDdCOXlWZXp2c3BTMGgyYjh6STFIOUt1V081UXcvT1JPNlU5VzVY?=
 =?utf-8?B?MzJGZ0JxcW9jV1JjZDlOYTBUWXBmKy9iZ2xESHJlSUdnYi9JaWxzdGFEd3R1?=
 =?utf-8?B?dHlJSXBIV2I1NTU1cEJNbHIzNGNwREIxZURDVWZPdnJMcmlzWTJUeWRLZmVs?=
 =?utf-8?B?YlQ2eU1aQjAzZDNnK1ZpdGZBaHZZTlFBUnNIRzhKWkMzWjRVM2Q5bUhiZVpk?=
 =?utf-8?B?dUttd1EydDRxRHZFaEJMNWdmYmZSNnN6Y2YyQm5uNlZmU0tkM1ROMWJ2ZWFn?=
 =?utf-8?B?eEFmbUVJcFdiMlRXYWNKM0F6R09tZkY4dmdWR01sNDQ1Rm1hMWZZbU9LUVJL?=
 =?utf-8?B?UDU5RlY2SjlpRHZ6d2JXbjlhVVhpMGVEVm1PQnJGOUg2VEZhd2VybjhtY05I?=
 =?utf-8?B?OU9SNnZ1UnM5dkRFNlQrNnFYenoyRmExWm5vKzIrbjRxQTk5L3hOSzBLc1Qw?=
 =?utf-8?B?V0ljYThmMzJ4ZGloWVNPeldTQ0lHTDNKd3E4SXZoQTZxQUFOeDBGenh0Wnpt?=
 =?utf-8?B?V1EydEI2UERTaWlld0ZIcGFqdkErRG9LTndKNlBTUmsrVllHZ1pYaGpTTUpy?=
 =?utf-8?B?eGhiZmRjQVdGa3FOdEF0V1FVeEpzcGxleGxoSWhrTDVwYmY0VjBRb3pNb2xD?=
 =?utf-8?B?VTJWSnVkdVF4QWp0Y3NXay9CajFaeGhxT2x1RjBrSnZhbFIxUC9CZXQ4Unp3?=
 =?utf-8?B?WXptZEFOTzFRbmdvRUtIUWxrQnp5bHFhN2xvN1hUc0pvUXhIaDFobkVqZWd4?=
 =?utf-8?B?OWdFY3JNczhvNmdtdFZ4SFNwZjl4bzFxZ3pJa3ZHU0FOSWVlcUJFVHpvczhP?=
 =?utf-8?B?eXg3VHZlMEQzWlYzQzFUb2xSZ3hVYSsyVVlTR2hhL3dWNG1XZENYMUtJNm11?=
 =?utf-8?B?eTJBcDREeHpqMnhFTXJQT2FSUGJsaU5BZ1VxNExYSjJFdW50NVBUeFJHT0E2?=
 =?utf-8?B?Ky93NHZKck55N2FUUXJ2eUU2amtKNUt1elR3amlkVnQrckNPaGxGeVBaR1ky?=
 =?utf-8?B?RXRvV0xMZ05tdU8xYnRFYyszYkxaMlhYOWh4RlM0b2NIUHBqcFhHaHdkLzRJ?=
 =?utf-8?B?MDBLZTZvcElta1FnU1hiSTdaa1Z6SklhQzg0anZqclE2dTViWXVOeEppL0VI?=
 =?utf-8?B?dFVKQ3k5QUswUjMzWUgxdXhOb2Jxb1lPRUlWcTVOZFJwMUVENGE5Z29aU3Zo?=
 =?utf-8?B?YXhDemdkSmNPZVJsNEloR3FQYVpEeE5BanBtU0xhakNqaDdWVStOQkYwWkVw?=
 =?utf-8?B?TkdNYkMrbTI3YmJGVU9ZdlEza1pRRWRGb0swSm5RSHlhSE9WU3YyN2l0STBC?=
 =?utf-8?B?UDdQNXhkdWQ1dkRRV2szcUpjSkN1ZmNhRktIaC91NHlNNXJiUmFpb2JrNDVX?=
 =?utf-8?B?elZpeHFYL0FoNGI3L0VIN2I0RUU5VHBzTFAzNEtTdnBvZ1E5R1RxVjBvRlY4?=
 =?utf-8?B?aXQ2eXY4cTlFbXhwUjRmMjlnYVBRSXRLUUNpOVBqT3JJMDdsTVNndm9sL3dZ?=
 =?utf-8?B?cGlldEU3dWZzMHVCUXI4WURNdGNHYXJGTnlMY3B5NnlFT1IwYzZSdnJ6QXgx?=
 =?utf-8?B?UTZ6MEdEcWR3U3pvYnYwQjd0dEkxUkVDZGZiWkFndkhwOFpVd1Q0bnlaU2Zx?=
 =?utf-8?B?NXE3TjRtbDNWNEx3SWtyWWlXRDFuYStUVzBQbVZJYVdHUEVHWER2QkZBSm42?=
 =?utf-8?B?Nk91QTd0VGlYbzlNMWRuTXlzTkNnS3hXRnpLZ1dyOHJraXZSRE1Qa0lzWVNh?=
 =?utf-8?B?bVhLUC9xYjJaVWxtczVYaXN3ek56Tjk3c0pUTEFOeXdWVTBrSS9ld21Fb2pi?=
 =?utf-8?B?NHVHTEljSS9UczJ5cUJkOXBsVGJvYzBlZnJxbUZCRFU3WmRjcXJEQlJFdkVG?=
 =?utf-8?B?TWF4YWM1OHpTdE1MMWJETFRTQVBuMGIwck4vMW1sN2NHWkRqTzEzWmVtejYv?=
 =?utf-8?B?TmVrU2RQZG1hZUhHaWFtNUNkWXozZC9LQjF4WmRraWI5QU9kWjZBMWJhdG1H?=
 =?utf-8?B?SDhqb2JxOXRUMEU2UGJEVGkyZEFTQ1pSNHZBaE9Tc0pMaDhTQmxtQzFaRytR?=
 =?utf-8?B?RUJ3UmJiTkJYYmZCcGg5NGx6WExpNHhONW9ES0xxb0N5dlpFUzZTYkNyS29a?=
 =?utf-8?B?UkVMTDlwK1V1SDI2TXVTZ0RGUTNOcFZIcVR4UFdIZnUzdGd1S2V6R2NrbjBF?=
 =?utf-8?B?NUR2VHpUTnErUjF6WUxwTTRVTWNvNlZPZC9JRE5NNTMzMXVTVkhIQTUwWHJi?=
 =?utf-8?Q?BgFciSXPyHf4xExmwP3viqy2CJ0VEQOnR36XSx7agjqwT?=
X-MS-Exchange-AntiSpam-MessageData-1: jZtc8DwitVkyPw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3068a2f-dd63-4891-2837-08dec6e26cd7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:21:32.6862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/qjsT6jVPXOloyuUVs81ynYUB5kWICvW8WgEFx6bRWjVxD4AZKNwu8IHhaO0dkFh11nGlvCziF3Yj+ClC0WYw==
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

On Wed Jun 10, 2026 at 7:14 PM JST, Gary Guo wrote:
> On Tue Jun 9, 2026 at 9:03 AM BST, Alexandre Courbot wrote:
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
>
> I suppose this field is for unloading only? If so, you could just create =
a new
> type that stores `device`, `bar`, `bundle` only, which works as `device` =
and
> `bar` are Copy.
>
> struct UnloadGuard<'gpu> {
>     deivce: &'gpu device::Device<device::Bound>,
>     bar: Bar0<'gpu>,
>     unload_bundle: Option<gsp::UnloadBundle>,
> }
>
> impl Drop for UnloadGuard {
>     ...
> }
>
> This does mean that the `device` and `bar` are stored
> repeatedly, but this way you get a very clean way of representing this: o=
nce
> `UnloadGuard` is created unload will happen.

For `UnloadGuard` to be able to run the unload sequence, it would also
need a reference to the `Gsp` itself, and to the GSP and SEC2 falcons -
which would basically turn it into `GspResources` unless I misunderstood
your suggestion.

(the falcons are owned by `GspResources` because I want to make their
`load` and `run` methods take `&mut self` soon)

`GspResources` also already stores `device` and `bar` in the fashion you
suggested, for the same reason.
