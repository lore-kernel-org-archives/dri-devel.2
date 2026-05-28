Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4650ACD5BC9
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 01:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A8610EB2B;
	Thu, 28 May 2026 01:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJMfs0tR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF2610EB2B
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 01:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASVnZtmHKiHxZ1EzxscayF+Ggo2CNLWQ1P0oMcNZ8hCI8ZhI4wskP2HdcE9x3oOQ35Qcs21i0O8beUs3b5i+dKhDtOWXeGBrgYVYKQTSb1cCvkRxBI5h1xPDvaGno4j6WYdVwNggVigfKyR1wi38kUDyCuPkv+mWi3tp5Tvs2Ua1mJolqk/cBBQ0myuZLLfAP7KZblcpwGd+KJrGjN+GLhp222lEnDb1AUSvEp4UZfUb4y2nqFklJ6cavLJI8hjdsnQ1A8xLFLJwS4muWjgSy4gp7KwSsdxo86SZZdvW9JiYXcgKRRorS35GtsRkFzoLNYoTAtTBNKNtZJkLjFt1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2UJm1pkBEr22T2UizUk2x7+qxNd39SkYeinVzOBMDs=;
 b=SBI+N9FQQx3Qo54A0f1kHQCIpXC2ZyMMtCYIbi3F5vsxPTPZYTqpNm+oSgHEJFPounZZANiv2Wqn1cDIoNtm0qunbupGKQilLiDHgo7Hv5prctJK+PPNxXVs4fggzjgRA9wEjvVem+OKxYjD3tswLnmdwWN/yHFck4kHCmC9g6fMxsx9fLKpBGkBpfgOqAgsKJxfEspLJYoxG5TFQvMjQnLH5Xdx9qqbutBsXGq5lhN6PQVH8ypnwQXtuVZnWFuTuVDvLYxBhr77rqo8HPFIoqWjtOZE8g+YtOicyZSYb4f86NeH9AI3eg0vMu11rBu0ZXiM3PpRn4bIRhInV8rI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2UJm1pkBEr22T2UizUk2x7+qxNd39SkYeinVzOBMDs=;
 b=aJMfs0tRfPODSRMPE3iktRBTEi/tcRaAQkr/FFZ1yKoscrjGj0YjFpQiMxOZhR9hrfUg3je0YkntuVgCjhl1DHgeOZJw4gNZ293As237av5Ra+ZkcxnP/8KGsik2GaK5k3SDMcVvlB3E+EYYt5FhLV4Pk9S0D456qMdhSrR7CUOoeL4UHftSwicMUfQZ/uy7k455hRY63gNHkGJEJwBocgYoS5C4Vx9HHK0b7mjnzTgayYGf0hAeJmYgI6ZXRaQ3xljEN261mcY5q3TNRXuI6VulhNZ4rTYrPw74wmcCZjhaspvOQL+Obz7ST5GwYYUWRegK9Bcmk2SrKNp/Y4btRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:12:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 01:12:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 10:12:34 +0900
Message-Id: <DITWSKI85TXW.2933647HXSSQC@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>
Cc: <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Danilo
 Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: vbios: Fix clippy error in Vbios::new()
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260527171521.2406456-1-lyude@redhat.com>
In-Reply-To: <20260527171521.2406456-1-lyude@redhat.com>
X-ClientProxiedBy: OS0PR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:604:26::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b44adb-5d4d-4fb4-4c42-08debc5635b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: olqrT+2YyMbTIJ8X3o8WTp8dBG0eACmilNFnTk2+SszcIYOBeqfOovPluxr52Hn1nR1uptCfxzohjTTUd7l0iXc0CvWpX255oKdVsQ2CuJldgLO1F05vODYnIqhz5yNpVEEStOMkh3qdCgFmX0TDxrBSCVfLVNLPBdShJQCvvxi08dRoBBW2jdglUkI6Bg2/aJl+Ptoy2pkfaiix9BqbFxpD8OcQ+/mOaAISUc6QaydcAToasNDQLQ/VkEzex+/A6qE8q2ZYfuTo9EvjdsCCNWcQtK8uZ+M8hsgBDdNjX/nvyVTpvJwWmnPTu5SynkQu4GiCcMlNgncAZgvJNNWtr0l+KKgN6QeUqmu7nz4/u4Ogy2f23AT+CLcnFFJhUQkBVQsE6dctI66exvqy/5Q32e0hZ0co/rSD/L8i0dokphCJKtQL+c12/IoI9M5AQdtX63YOLyrYVUwT3RwH6plde2MOC9o2yTz7gk/BmTQHi0pQgniUhj5aYw4HNI217xMm9Hhlc9POCCARf2wUVltZJZ2JqVZLrjlQrPkjhNK1B0AOViWD4gvcsuvAYoXb8vHL72DM8G5KWAaZoKhWFHVL9kmgJA9h56APv+OB3kG6Kjh8YB37ndRJHDI2nFsrqH3Uuy/7lrBU8KYnDKJvm971R1ZyREOhL3CBNa51U5dzZoPdB7adQoEr9S6C/CRoiAt5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldEdE5vNm85aGpSOEJCWUhUWFZRWW1ZK1k4NmtzaWFoaDBxeCtiQ2lwRGVC?=
 =?utf-8?B?bHlDcEFOeWd4bW9BYjcyRHlhZWsxT3V3MVBUK1hJWXhReVJ6SU5RZkdKSnlR?=
 =?utf-8?B?VllIWkRxdG5tNWdmMk8ycCtIZThEQnpZdm5ibmNaNWdSUGRUZ1k4RlJ0M0pC?=
 =?utf-8?B?bXEwQ2wxY3NKSmVKVStNSk51aW1CU1pKQVNKa1hJVjE3c0l0ZVFQSThqN0du?=
 =?utf-8?B?K0VLNlMydEo4MVU2STZTVFpNWEkvQm5ZUHY5UUlNYWZackJsa1VQMHhJRHU5?=
 =?utf-8?B?WVM0YUxnRWhocE9sLzVNSjVxQXZCT1hYZFB6OGs0VkxlWFJ3ZlRCUjBWeUEr?=
 =?utf-8?B?WUg5SnRQVE43R1pLQll5YmlUY0JNTWRjck9XYjBhSytwN0dtb1VTbGl2VUcx?=
 =?utf-8?B?NUx4K0V5TWtYbndJOTY0TmZrWEVsUkRWSjdMRWpGakhiVzJDQW9qRkpoSTho?=
 =?utf-8?B?RUdCMGQrMks5QUthdkJuOUlJZDJ5ZkRCSG9hS2xpZHhmY1JLNWwwR1B1bEEr?=
 =?utf-8?B?bmZ5U05CWGk3bCtIVUJYRjI1VTU0ZDkvYXd2UnpqM05RRG1xU0h1RGV6aGZM?=
 =?utf-8?B?ZVVvMTZTSnZCaFY1amdJa1lQRFZqbTZ2WjFZRTF4ZEdFQUR5RHo5cHBXREs4?=
 =?utf-8?B?YVZBSlVpK0J1L0tQOWZCbkZDV1lDZnpNRlVybFpVM2puT3pVR1hiQXJWOXV0?=
 =?utf-8?B?MnZqb2Nyc2U4WnVpY3F2cnBnaGM2MGV6YllQRGovRnhNdkU1ZHZOaHJvbDI4?=
 =?utf-8?B?VWM5VFVmSVcrSVVvMnExTmNTTTlGN1k2SXA2bzFxWDdtcmdhV1NQMHRFaG0r?=
 =?utf-8?B?NUdONG5HMWpoLzU4eXpnUDJuQ1FQL2hVWWZ0bG1NWjFra3lGNzVTNFY5U25C?=
 =?utf-8?B?bWhuNkpCTS9PeW9qUml1aGRkVzJ1YXRuRlJnNVFmVjZPV1RieENNaUxKcWFJ?=
 =?utf-8?B?ZHBzQWl4WUlYVDJJazc1Y3M4TVZySXlXQjNWUDJNam5qN3d5VkhUMnFaS1dC?=
 =?utf-8?B?S0xQVEZJNEFMTUg1RW8yZFdPenJGSkxYRFlFZHg2ZDJtcEVzN0JFbHZjT1p0?=
 =?utf-8?B?SVJPQStkbEIvSGE2dG1LM09iVStZVFNZVjc1Uk1Bc3ZSQ3dQeHYxNW9FQVpU?=
 =?utf-8?B?ejkrNDR0M3hNaGdRcVBuR0xLSm03R3p2d0tjSXBZVmtpb2V2VTZieTR2aCsz?=
 =?utf-8?B?VnZENWd3TElqSTlSNlVFMG1NTndzNnR0SUxmdlhPV3lVUytFSVA4UUNHMXNZ?=
 =?utf-8?B?MzhsTUZLU3pYUlZqRXJqYmxaampTRVVFc2hQUjhYRmtnQWJtMytNaFl3ekJa?=
 =?utf-8?B?aStMaEVDM3MrVnpVNGYvZHcyR1paOHJYa0dUa013MWRtWHlTRTZiajJ5MHdq?=
 =?utf-8?B?Mm9HLzRUWUM3NDM5cjA5MWZjS3ZPL0gzazRFY3ZhdDNUTEptdGQ2c2VlbGky?=
 =?utf-8?B?YTJ1c2d1RTN6bSt0N1ByNlQzVkpZbDRvVDRJYUZIVEZOS0lBMHd6dTBQTnRi?=
 =?utf-8?B?dXhGdTMyd3hzR3MwVXBtdXlxYzZGb3h2OGZSdkREY0oxT1BsWjQvelhaekFi?=
 =?utf-8?B?d2JKNk51Qk9yejRVWmhiS0V1UFlCRXN1aXNFTkI1ZExWSU9CUTF2aHZKN1lY?=
 =?utf-8?B?NURpVEhsTWhmaEdHczZ4TzdlTmFsVWtoQWtzMkhwa0VjeHpRUDlmNkVtK090?=
 =?utf-8?B?WFFIbXBWY1BYajhqbHlMTDNoS3JOVTBMNm1Camw0OFR5allsbXpmVTVsS0Jx?=
 =?utf-8?B?U2duTXB2SkFaMSsvaFpjVW50WFZpM3BuYjFyaU1tUjI1N1JQSFNBelZLbEwr?=
 =?utf-8?B?d3d1ekRhbEpJTWZoRmQwSlZzNXoxWnNwdThpOE4vcXJhSU5aVkVmSXZnQk5I?=
 =?utf-8?B?VkNhV3gxOVdvTGRWTmRzekk4OFNrNHNlVWdhd2QyZ2FFV2d0UjFWN0R3OEtx?=
 =?utf-8?B?TkVCMlMyOGJXRjdUcjVCTENqM2hiZEFFeUVQd2RzZnZuSU8vTjJheXQ0aUVv?=
 =?utf-8?B?ZG9SQjlsVGxPQ25JTGdQYm13ei9DV1hUUklpS29BaFlYZHlkTXlOZTh0Q2RP?=
 =?utf-8?B?S2ZMSGxUcDBwSVR3WmMyYUpnZFQ5Wk9YeHlIVGR6ZWx6b0hLeUZDTjlSaWFC?=
 =?utf-8?B?bTRmMTlKU2p2Mk1GQkx5Y3FVbkg5QlY2RDRiREtvYTRJUWM4Skx2UFZKQWlJ?=
 =?utf-8?B?M2cyZjlZUngwODFzY0tEK2hBcll5N0J1aU5DOFp6YnJteTBjQmEzdXFRWHZi?=
 =?utf-8?B?a2xjT21UMldKOUJhR2hVcndxdGFyanl0V1hnQ2g5c0FOTTBncVFHZTM1UTV1?=
 =?utf-8?B?czRmUjRUMHVvL3NwT1NNQWkwMW5qNGROWHlQSEZYUkx4YVFRSDl2dVAweEFC?=
 =?utf-8?Q?ic4ibblpG8sCAIOGXCwgHAMT5LjIWKpAi8qxpFOYBJ8fC?=
X-MS-Exchange-AntiSpam-MessageData-1: +gVQPimwS/YrBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b44adb-5d4d-4fb4-4c42-08debc5635b5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:12:39.5323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQzzMcxxskAxrW+0d+RbZx4TK20bwsYH7AsWlXMVlknzv9T0t9O5DTIWc4r9Se3z5qKjMv//hQsWbYoWejwO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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

Hi Lyude,

On Thu May 28, 2026 at 2:15 AM JST, Lyude Paul wrote:
> From clippy:
>
>   error: this `if` can be collapsed into the outer `match`
>      --> drivers/gpu/nova-core/vbios.rs:328:21
>       |
>   328 | /                     if pci_at_image.is_none() {
>   329 | |                         pci_at_image =3D Some(PciAtBiosImage::t=
ry_from(image)?);
>   330 | |                     }
>       | |_____________________^
>       |
>
> There should be no functional changes in this patch.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index c0bc1008ed752..d38d7f138b49d 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -323,11 +323,9 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0)=
 -> Result<Vbios> {
> =20
>              // Convert to a specific image type
>              match BiosImageType::try_from(image.pcir.code_type) {
> -                Ok(BiosImageType::PciAt) =3D> {
> +                Ok(BiosImageType::PciAt) if pci_at_image.is_none() =3D> =
{
>                      // Silently ignore any extra PCI-AT images.
> -                    if pci_at_image.is_none() {
> -                        pci_at_image =3D Some(PciAtBiosImage::try_from(i=
mage)?);
> -                    }
> +                    pci_at_image =3D Some(PciAtBiosImage::try_from(image=
)?);
>                  }
>                  Ok(BiosImageType::FwSec) =3D> fwsec_section =3D Some(ima=
ge.data),
>                  _ =3D> {

This lint should disappear once -rc3 reaches `drm-rust-next` per [1].

[1] https://lore.kernel.org/all/CANiq72kR0raSG33DgSxMuc-2uMa626dT=3D-5=3Dko=
_HBgmeOrCFZA@mail.gmail.com/
