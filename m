Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0B4CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00EA510E942;
	Wed, 17 Jun 2026 06:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEYdIAuG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC1E10E942;
 Wed, 17 Jun 2026 06:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPFUUfr5estXejJbtkn487q8e1DpkV5HirnHgznEQpTzCgIb/DyrpHXy5IwtEJYYlCjI7ETP2Zjhnbt6/fjBuegKcoMOmXCguIDzr7l1Qzufyoal5Yxv2yXU08/0MMgHANhxm0THAsflfh2HldR5d7k2KTIfKndu+TaLipFG6y74ZGPeRItxPK2yRMjiamI/a+cQYLrIj5mzNhkHvet0nxCFHO9i2rQ3Fw65nJejmFEM48TPn03CYsi6T4mAoTfA7nL5WsNvVwurKNLC5iqtuHWjp9i2006ax0nnLpvGn7IdaST+LN6MAONSTKLpc1onNZtc0EsOe1wYK8nnxQP4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD+iztgQdN+MEv6OJRHX9xK73c/+zQStC1xd9T4tclM=;
 b=Pte9jQWyNAa2SYHtnSnxHT1/cewEJ2Q3/0m9t5ZL+WQv4mXYac2QIjOj/mu7hrO0IAza6yXu/7EuhsodEm4aNJFT/PfJ56mR4P7LjaAwlNHNKdFg/rP1BIIIEl2pyL4r+vL6PIDEKKXFztNTtJT5oDEBPy62+FQpUNTXMLKaLK2udeGpdjjZ/medEzNVQKvSritQUvqjvlfEPeBJPAM1ZsQJ5u0kxiUOphCp1TX3A9Sp7WmqVupSSaErtYH2Kn2aCJxwBTtJr9CD+q7G8pXp+qxLa4A5bANugw74VVufevWKXhrLjkSKMX1mqzXKikXOIqkr3YciZw1xhcr+FNdfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD+iztgQdN+MEv6OJRHX9xK73c/+zQStC1xd9T4tclM=;
 b=cEYdIAuGLJo+sfN1T7y0BiMSpIVlFdp31srFKF06EVIXVVrVlfqnvJBaFWkclJANTv9Sm7YYkUFmzGy0b/cwBEwFn2XPOtBFGsQnDTZehbDxZnWbqihGEgPTed+jDsa7oNh8HW7wBOG6YXXn8KL33CSaJCZdiG3dYTJFHFhyOx3XHY4T0z7FpwEWemZ7EFo3TY0wPwP6l6Ym2/AhqDnc6nCI1XvylkqRqqzJYGp4aGS6rFAsL9VHZRPYcc992ti1nbpJuLsbyB85OBoP8mXu2O74ygG6lhNIU7MzqnJm1PsPgS7DaYDq09X1C74+XMp9piExxrJ447pPdNubhLrvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 06:20:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:20:04 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 15:20:00 +0900
Message-Id: <DJB3UUM98IBI.2FTWDAZF9W8T3@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] gpu: nova-core: gsp: Extract usable FB region from GSP
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
 <DJ51Z8EBBDGN.2RGGG26YG19R2@nvidia.com>
In-Reply-To: <DJ51Z8EBBDGN.2RGGG26YG19R2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfa842a-f3b7-4ff2-bfd6-08decc387832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|11063799006|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bZjGs0nXGXoLEJZ7fX385D0XsWAADJKpylrPZX+mo0+WFEogFc2Yb7Crl++nnjdmNhjMPs5l4ET4oEs00OYshWLG/0thwY4tyFCx7f8zcMP/ayMqEEoFPKIHRS48iqsX1pxq6dIUyg+Gr1EnQoW/NRJz+8/tSWPVqzR7TtCk5LMD7dDr1E4h2vBko+oXRIUlIYZK4GWNaeSndWF24qJdPO9YxnXDIyEVBdxDg0hP4Bupu6ylcK3i7UnF8GzQJ1d5yrudoNbSbXMfeUesOalgyNHER2cpTG3fZzmAyjovfdXdI8KUuX1PhuF/G0GE1Dwv0ve/UKonzIoggJSuE1OHvVsVIImsmUtSEeE/7jSvSnimjJpVX+DJh3KC3PMzqU6/GaYUUKafymPRSGcKRb/7BSiYMw13kvh65WMZIJy4/2clje8EHHf0JoH97krbbQ3Ep+plz1cE0lEtTJh6Yy3KslIpq0QLuh2SAuW0QxEA2ejRxQ9OGvaoyXHiJeQ45S6UYgtdv7yTZIKvTVSLd6B71c6m9/aZxYQVeR+FKJe6qD7qLPJp1/FHSNhAWEMdHjegCB2Djyj0dpVY6XLxJrbHWKHUNZAUgZc/sH6CVMlZaCORzqbopQAJKnYxKqtu/UtwLlYaLKIkuIZmF2vXq+qu4U9ZUZr2k2UxcpM7EvwVf61Jf7O3Jn/+whpuh9/HNUh8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alV0azVhMEN5Q1ZUeERySU9EemdXTDNOMU1QaEFvVjBaVDBqN3E3VXYrSG9o?=
 =?utf-8?B?RFpZb0pTOUN3QW9jeVZSYjVRWk13TFJ1ZlMrTmdBNEVubmI2T2JLU3FHSnJR?=
 =?utf-8?B?RTBwcEQ0NVdpQnFmUDg4RXRHaDNsMERpWHlKMnFCbU53eGdBTWZvNE82eTJQ?=
 =?utf-8?B?S3A3MW01dU10cTNDcWhtaWY1bVZoZFdZMWdqMzg5MENEYXBIcXhjTVdiVmw3?=
 =?utf-8?B?ZTgvSGszTXE0OGczRFF5TVE4N29hMEkvT0I2VkNLNi9uNlQ3NXBkTVVNRTJr?=
 =?utf-8?B?NXhCNnlXL2VBeFNvWFlIeU1MRjRmVjkyQXBhMmhpU3JKOUozZDVkSWFJNjEr?=
 =?utf-8?B?U3lxNC9pSUJvTGNwckpnb1pLR3hKYlhCbEI1L3VUcUVlb0tJOFp4YkRNK05p?=
 =?utf-8?B?QXlIMnVWWjloY3dQemN2MFNKUi9xak51OTU0SmFpc3ZuOHVNdGRxZm1lNVpU?=
 =?utf-8?B?YnoraXdvRHhOY1RTYldFY0tJbUVsZ2xGTWIwS2VDTW5EamlNYnpWZnpETWlj?=
 =?utf-8?B?QUl5ZVZZM0QxYVJOcTk1YTVOS2l1cG9pUTM1M05YR0Jtbk1LUkJnSWxjK25F?=
 =?utf-8?B?eEltVFB4L2MwVDhuYys1ZTZDb3R3bkg4ZVVQTHpqeWphYVVqdFlFN2FxS01u?=
 =?utf-8?B?RmIwNEpVeThjMWZOWkpKRllkdkFsQjhqZndDNDBlQS9Na2JXeSthdnBpWFdL?=
 =?utf-8?B?bkNIVC9YM3hDYU1GeWRNRXAydldNNnd0SFQ3YzlmVGV4RkZWaEpCWVU5RVJQ?=
 =?utf-8?B?MWFYT3JhcXgzY0EzNXplcGtVVGJoSjhSZmI0MkhKSWc4ZXpXN3BHOUtMN3Nv?=
 =?utf-8?B?QThqNVdnYlFJeGF6RGUrZVNNRDZDUWx1d2hqLy8vUzRHZC9QVW9IR0JNL014?=
 =?utf-8?B?TEo3WlFMMWV0THlud2VpSklwSFJSWHptUzc4U1duSzk3dTIyR2tTTFJFMWpr?=
 =?utf-8?B?UU00VDdNamZkTWowbUR0djdIY3FhYW5zRnRNcFlYc1BDaG1tTEVDamI5dGgr?=
 =?utf-8?B?dE1oSllXRG4vV0NOWGhNd3BpZ1UvcnZaOHIzQzVJaWhkc3MvSmxERHNzVlF2?=
 =?utf-8?B?Z0dPY0VBelFFUlNnRDMzQ1FWN1ZmeERnNG9OZ2hNUC90VFBTVW1BL3JOUFdI?=
 =?utf-8?B?bFJXN3pwVk9hWFpRMmhFQjZzNmp2UVV2NkJhOSs0TUIxbzVkS0ZCWFRpcmYw?=
 =?utf-8?B?bjM2Um0vcjNLTkFoRGlXSUo3bysxQnZ3TzRnYkxENGd3SSt6QjBxTkRrZkhJ?=
 =?utf-8?B?cEVrVWlUdXVHUENMYWFXUHlXcThEaU5qaW1uUEcwNnREeVVaN3I5R2NpbDIr?=
 =?utf-8?B?N0liNDNrTEJwdmR2bC8vM2hkMkxwUUNCZ1U5QjVoWTVBaEc4aUJPb2x0MUF2?=
 =?utf-8?B?WkNHU1dZUGl5U3dpdFd0bHI3b1RhbjVUM21MME9PaFJHcGhWOUpOellyVmU2?=
 =?utf-8?B?RkJJRzFLajc3Tmdic1Q5djJDQlB6WEx3d01qd0Q1MlhoVDJ4YWQyT252Q0JT?=
 =?utf-8?B?Zno2a1NlSFRmMTBxYkxGc1ZXTDJ0RWYrQVZFTGJOMWxzMjVqamNQaWhJaEhR?=
 =?utf-8?B?SXZReGU1RnhlR3FhczJwT3RyL0NqRnV1Zk9iUGNsbzZOdy9FK1ZtY1BseVEr?=
 =?utf-8?B?RzN3dmFKZHlnUURuTVN2cnROVWNrQ0dTbUVFSzYxaWl0RnRRczJzWUVKK1Z4?=
 =?utf-8?B?Yk9uOUlldy84SFg0M0xOK0VLczBZSjRjTGpHYWk2TmgxUnMzNFZoRDlwNDMx?=
 =?utf-8?B?RmdkcWxnQ2JacG9mMXFyelhsZHMxSlZJL0puc21jVnVaanpXbElnd1oyZktB?=
 =?utf-8?B?THFjSTRQZWRJVjBqUFFCMWNhanUvRkpqMlh3ekE4V3JwV3hlbGw5bENtaHk4?=
 =?utf-8?B?MTNiUVB6eTJ6S0JNc01hUjZiTGVaNHk2T3hqd2VOSTBlQU4xcjFKM01SWTBF?=
 =?utf-8?B?T0RVNmVoR2I3d1pSL2ZUSHpaN0tzcnBVTmV4a3lUck5WdTJ4dkZzSXNBcUF2?=
 =?utf-8?B?SHhPNXRFYWkrRzlJWWhkLzZpMWg4Z2RHNDRXN1ZFYmhzdHNZbmRyQTk3Z3ZT?=
 =?utf-8?B?U2FpaFZtd1psTnNmTU4raXQ3ajRxSnlyaWlSSTVjZWtEV1NXMER6VUF6RnNS?=
 =?utf-8?B?RHcwVHdMMzNTVmw3NVExYUkzbzd0L3FzYkZZbnJXTzg1N2xnd2NCamRGVUNR?=
 =?utf-8?B?TDFldk9zR1Y4YUh1YUlJSU9nQXc3dFBBVnRwNy8rTnVkVmlJQ3BsV3Q0aGp0?=
 =?utf-8?B?Y2t3ZDdHZ0w5Y1JEWm92dUJEcy9NRlZCV3lzaElqRUJqU29xNDRFRXY4elkx?=
 =?utf-8?B?dmtRUnRpNGU3aEVOVmJGUXhDU0pNRTFKODViOEdPckV5WXhqTWVuVTZVc2ZV?=
 =?utf-8?Q?E9sgBlaN8GhflrV0n+tBGTysOXqZJ5IG6Klctu+dbkosx?=
X-MS-Exchange-AntiSpam-MessageData-1: zeGZZ4XGWXFxyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfa842a-f3b7-4ff2-bfd6-08decc387832
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:20:04.2598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvxJPMs/Flv+L9inRn19P11VXy/8dI9Qb/H3w5WsyPbVK8d8LI+ihfYAsLEYkd5+lzDc/Xwitjq/94tBrPCaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

On Wed Jun 10, 2026 at 12:35 PM JST, Eliot Courtney wrote:
> On Tue Jun 9, 2026 at 5:04 PM JST, Alexandre Courbot wrote:
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Add usable_fb_regions_iter() to GspStaticConfigInfo to extract the first
>> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
>> that are not reserved or protected.
>>
>> The extracted region is stored in GetGspStaticInfoReply and exposed as
>> usable_fb_region field for use by the memory subsystem.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/commands.rs    |  9 +++++--
>>  drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++=
++++++-
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-co=
re/gsp/commands.rs
>> index f84de9f4f045..d955f52a93bb 100644
>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>> @@ -5,6 +5,7 @@
>>      array,
>>      convert::Infallible,
>>      ffi::FromBytesUntilNulError,
>> +    ops::Range,
>>      str::Utf8Error, //
>>  };
>> =20
>> @@ -191,15 +192,18 @@ fn init(&self) -> impl Init<Self::Command, Self::I=
nitError> {
>>      }
>>  }
>> =20
>> -/// The reply from the GSP to the [`GetGspInfo`] command.
>> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>>  pub(crate) struct GetGspStaticInfoReply {
>>      gpu_name: [u8; 64],
>> +    /// Usable FB (VRAM) region for driver memory allocation.
>> +    #[expect(dead_code)]
>> +    pub(crate) usable_fb_region: Range<u64>,
>>  }
>> =20
>>  impl MessageFromGsp for GetGspStaticInfoReply {
>>      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
>>      type Message =3D fw::commands::GspStaticConfigInfo;
>> -    type InitError =3D Infallible;
>> +    type InitError =3D Error;
>> =20
>>      fn read(
>>          msg: &Self::Message,
>> @@ -207,6 +211,7 @@ fn read(
>>      ) -> Result<Self, Self::InitError> {
>>          Ok(GetGspStaticInfoReply {
>>              gpu_name: msg.gpu_name_str(),
>> +            usable_fb_region: msg.usable_fb_regions_iter().next().ok_or=
(ENODEV)?,
>>          })
>>      }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova=
-core/gsp/fw/commands.rs
>> index 7bcc41fc7fa0..d025167927df 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> @@ -1,6 +1,8 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION &=
 AFFILIATES. All rights reserved.
>> =20
>> +use core::ops::Range;
>> +
>>  use kernel::{
>>      device,
>>      pci,
>> @@ -13,7 +15,8 @@
>> =20
>>  use crate::{
>>      gpu::Chipset,
>> -    gsp::GSP_PAGE_SIZE, //
>> +    gsp::GSP_PAGE_SIZE,
>> +    num::IntoSafeCast, //
>>  };
>> =20
>>  use super::bindings;
>> @@ -129,6 +132,41 @@ impl GspStaticConfigInfo {
>>      pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
>>          self.0.gpuNameString
>>      }
>> +
>> +    /// Returns an iterator over valid FB regions from GSP firmware dat=
a.
>> +    fn fb_regions(
>> +        &self,
>> +    ) -> impl Iterator<Item =3D &bindings::NV2080_CTRL_CMD_FB_GET_FB_RE=
GION_FB_REGION_INFO> {
>> +        let fb_info =3D &self.0.fbRegionInfoParams;
>> +        fb_info
>> +            .fbRegion
>> +            .iter()
>> +            .take(fb_info.numFBRegions.into_safe_cast())
>> +            .filter(|reg| reg.limit >=3D reg.base)
>
> Do you know if we actually get broken values like this (limit < base)?

No idea; but filtering for correctness sounds sensible (and is cheap to do)=
.

>
> Also we could print out the `usable_fb_region` as well, if you like?

Good idea, this also lets us remove a `dead_code`.
