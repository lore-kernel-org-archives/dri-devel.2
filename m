Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065BECD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641EF10F772;
	Sat, 23 May 2026 03:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cup6vNeE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFB810F76C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYgnl0cHvuInksDt+9MR6nuoYbeoav2aNKPyNTh3tjj/rbmudx18K0v+V5CUXz0l9v0QK0FVOmcuj0vRZ8M19VFy4GMtouzvNXPm8UYNUqEcs6+FmGUNi7j0UM3ZLDNNAA7fiITUA53GBKfulkhogx5zLZQbbzlxrzT6Am3mU0ZrJqyNbeVn/0DqyaPB9rq9HTSrqsl+C4tnVT/Ns8Hf/by8kYOwHyf7MPX0JH5y9zO22GoU6Iw1cNRCJtxa+9dO8YMvNGUgSpvBS+/gkDmcRZYFMyH5s3Hitqf/cLdw7+6xcP9LGbHK2LN2Pa4DWDWFy1AFS52cbgJXfVUOyHH87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2nxtFmeHLZI1LGMR8uK1X+Hi64giIH86piY9+V8Cf8=;
 b=VHlAOWzLjEq5by07FbwQyVLHypSzN5knSYJrJxDboiznKPKonwlSFZDlkb579XqNn9crHapGxsapJz49qgsK6PNxoDaHZXcOI8v8lYpcyJVyzJj0Tww8SP5BZAkJZ9/NXurrZxReSiRnFV7j5g7beHU0csuMDIVnUlqJQnFfVL8SHpxIMAPwvkGP/JKk5/Zv+NFZGUdfURWXRmFVKrTsOQQrHRTNBRBTCEE+mxkw58b2hdYONziAmnCaYkbbuH+E9RXs+7ymRletAvVWF44iaikNxVLMtu4xoUir8A4RoGDTV5F7/M77RY7EKboyiNSdBAzi0VPrTf0SOI550+deqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2nxtFmeHLZI1LGMR8uK1X+Hi64giIH86piY9+V8Cf8=;
 b=cup6vNeEEC/hrbSAHSlQRwMtDAm0aP74cS90a5esyjAg5mVOLeiazoyqHzGTZ+A1TGbvuSJb6RR5np+HnVf/KM9dvtzYn+lWGSo0zBlLdqzpRToktcJhNEp7ExUzNyUbduKbBJVA1C9j7+XPwXJqmc0WhIN9bE4XUTb19lHnkzdq9+C4E0DLf8wJquimSfooe5FGDWnR77RCgDYPMm/0MQfn2gqjtFc1AIOygQjiHUtehG59c5rkw6Pq5PK3gUVlVwW3uJ4H2SknXlRUKWLONNKkhRjIgphJWgIRDnzAOXSUJ5I+FRp1SxqfxaiUNOJ7SfOcne0acGkJGKhQsg77jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 03:11:01 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:11:01 +0000
Message-ID: <9e83007b-08bf-408b-8694-b92271793d1d@nvidia.com>
Date: Fri, 22 May 2026 20:10:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/20] gpu: nova-core: vbios: move constants and
 functions to be associated
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-20-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-20-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe17717-7aea-48fd-d01e-08deb878ea8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: zu+DeQVOlc7sJt+ozWSlSX1JJcnqmrYK3yjCU34207IV2pTOcIRh9kQg9HrTtHjDpCpSyRIjCdALtBq9jtl0SA6qVbkYgbXU2JLeKwDRhq1kL2OkZX+izrxnWmpNKsF3/J4fc/3paK9s+OeynV+SQYfo85frZGomZhtMOtmVYhC4vP6PHN5OkZbFHkV9/WW1pjnBuZdFlw1C+aLBcAdALY/vz4YUFoO4dXmc5diA+u10WC0iPT/gGKYrp0A2rdIA6s+PIc1V8uJkV35e8Ut/tpBoVyUaU9ol9qyZiPCAwkJy7Em+ePHkxBgRiwIVnJAT6T338YXPWPBoqopiq1Y4n+vcSLyQKG31NBWIlznIfGZ6OmfWkSlIqdKYS+OaDPCGOCH5jKHYyh/68t7S7VVBgGNfklPbx3YAKLmnwGuaGrmIlBtvxD2BH7jV/ht7D6nYDzMxa1/Vdc3jzGGxAO7w3rcjJFqlEsn5utxZ5HinGNbOFAkjZjtSARJk3u8vVEBv9Xo+3yWpOxQzG3Ba6Xogg0QHfsBr4IeL6gDM3N84cfGSLOShWUOjm29lJerQydpq9qWe4tQowRc8T9P0g7ArA/l20zi7p+Kz+HU24r3xNlnUBrNnvu9Zd0JR+Pi+ZnvRpg+lmP9/XK6oHjls/CKxj/NogOuVPROH7Am99HtSUo/9bsr8xkkotISzpgq9GAhg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdEZVlkZmRtaU5oMWlxdDFPT3lObGMvZmszSDhqSE5kOVdoSFdkanJEVWtH?=
 =?utf-8?B?TzRkVFRiWUd6bmFSY3pSZyt6bXRVMGZQSjNaTkZOVHVGY0V3R2VldkZFVXQx?=
 =?utf-8?B?RnExY1hPOW5XMWZpSUhXc3JwNFNFUTc3U2VGbHdWcTN0ekVYaDZXcVdDeGF0?=
 =?utf-8?B?RExVZHRpSTZGdmtWamMxbDZBWGdJeEpsV0RHenpsdktseURYc1h5cExFaW1O?=
 =?utf-8?B?K2ZMKzhFN0E3QXBVdVlvTnFoUlZOdGJLZHZNSzdhSk1zMzA1VnFNWkI0MG94?=
 =?utf-8?B?OExaeWdkaHkybmVpRWF3UWEvNkNSV05ZbklzVVB3OXpSOGNzc3NzNzZnUk5S?=
 =?utf-8?B?NVhWNktWNGExMUxhanl3bmhWY05lYUk3dFUwdWZyRFFtYkE0WFZocC9ud0FO?=
 =?utf-8?B?VmpLekVrNHhqS3FtY2NvQ0ZXejRqejB1ODFlMmc2blJqZldvb2Z4RUxIdkNt?=
 =?utf-8?B?VGsvbFRJVHVGVVNRc3ZVRjk0WGg3ZDF0NSsrKzB0OFZPK3hKbEk4RmVmb2pr?=
 =?utf-8?B?cGNrYmlyeU1NdHJzRkphK2Q3MDQzYXNTbTRKQVc0VkVlUlpHMW9qQ1h0ci9H?=
 =?utf-8?B?c2E1ZmNvOFBqNDBQckpwVmZCZnpzRzJxSjNrazFyOTNxZC9DQ2pSR3pHMUpo?=
 =?utf-8?B?MFk1dEloWWJhZWw5VVVRamVwdkZCM3phc0VkOW9UWUo2NUNFVkJjRVlYWWNV?=
 =?utf-8?B?d3RweGh4RE9ZVm9sK0FIbi9ld2pQT0E3bUVHMlVma29nOEhXaisxbVg4bHlW?=
 =?utf-8?B?LzBXdmY0TmxSKzBFNGlCbjJnejhxY0FzSUR1L3lNNWROV2gydktUaEhvWVIr?=
 =?utf-8?B?VE04SVEvRkwzMTgwNjA5MkVhNk1QVkVNUnRQU2JVMy8yM0VWYWZBQm9tUjVK?=
 =?utf-8?B?SEtKSXQ3VnE1a1Q1N3M5Q0tvWENmeHdFQnNDQ2cyRDNZZDFOdE9aSHFQU3JD?=
 =?utf-8?B?OGRFVm9iNVJHS21RQzF6N0UyU1BXQzN2Nmk1TEpkdkx5c0NHMVMvb0c3aE53?=
 =?utf-8?B?QXhTQzBtVkdua2k5eXRSTFBHcHpPRlpaU0kwYlRxeGZQOGJabW14bkU1R200?=
 =?utf-8?B?bHFiYmV2YUJnV1RET0tLYkRhOUFSeUFONGpPZmxFanZxWTRGUTZSQjVjcFNt?=
 =?utf-8?B?Q2RiRE5JQ3dSUDE2emxMVVJIOU9qRHRtckxsMWt5aklKclNsVHpoWk5xUTF2?=
 =?utf-8?B?NWJ3MU5RTldVejlpcGhWa0ZmMjlNaEhjaWdTUmtXQUE1eVVkNjg1Z2dYbVFI?=
 =?utf-8?B?bjI0ZHpEVnNRbkJtYjJObERZZEZxNHZZSngvZ1ZJRld3cGtnOExRRWlvN2Ri?=
 =?utf-8?B?MEZiQkxRNFFHbG9OZUV5UnhHaE5LMmxyeWRHVy83N2tuUmZiL3dXVHJSaUpt?=
 =?utf-8?B?VUtzd0YvUmNnL0t6WEVpbDR5OFVtTEp6OHdGOEZzMHB5NUU3NFJTSy9TbkVF?=
 =?utf-8?B?RnRGZTkrc1Q0Y2YvS1pIYy9QOFo0cEYrWjJ2QStyT1MxSjgrWGROcE5xZ2hh?=
 =?utf-8?B?SWFDYXZFT01WVmFOZk1SSUs0dHdnUVdVaDFqOHh4MGR5UEJUWWNERXhKTnJV?=
 =?utf-8?B?a1hyTG83Vk53Tzh0RnRQNXpRTkRSV3JQejZUZjhpc3dhNERFNExUaTlpVEZw?=
 =?utf-8?B?bTZNVmhrMGRWSDNhMFpUcmVVeStjR2tIamVYQlYwU2ZRdWhvT04vZ0syVlE5?=
 =?utf-8?B?cXgyRXZNdjcxQlpVUHZOWWNRcTJoamNoT3BvWDh1dmhqQzJ2akZReGJkUGdm?=
 =?utf-8?B?cTE2QXQyajJLSlY0RmJhbGcwL0ZvRHdUUmtkOUNzUDBGeS9SeVdKWWZBSHZD?=
 =?utf-8?B?cmg2ek5pWkNQdzMzQUtIY3VIVXBqUnRJMGROZyt1QUFCTEFjbXgwMWxDcmN3?=
 =?utf-8?B?elNVSmZ4QXpwVUJRV3plVzJudHdTRXFUSFVkUkdRSFVrRksrSU81L0JSWDRK?=
 =?utf-8?B?WHMrazNjbnlvK0tqeFFhYWx2K0Y1dXJDWVFqeUU1ZXZIM2JFeGdBZlVRZWVJ?=
 =?utf-8?B?TXIzSWVNQ1JJMjR0a3c0Z3JrUmo0T01mOEc5RDJvUUxxdEVKYUF3cEN6OXcr?=
 =?utf-8?B?UCtsNXFrN1FQcGwvUHNDUHJOK04wa1hUdmh0ZmtZOFJtVlZ5Zld1RmQxSjUr?=
 =?utf-8?B?a290dXNiSUlGekxYNGpSMTJoQ053Q05vNFFRSlhmNzZ0Zm1WUFppUlVlNldB?=
 =?utf-8?B?OEVieEJwZThkZ1p6RFpITG5kaXVDZGpxOXZzQVhRSjA3VXZJUC91RGF5b1Ev?=
 =?utf-8?B?NXNJMTA3bE9QMVRYZUZ1RUFJdlA4MUZOdEhhRmpqMU1iMHdaaDJGVU83UTVG?=
 =?utf-8?B?dkh3N0thUEtBNlhPalEzb0M2Vi9wZ0pWck01VVFyR0F6WTl3WTcyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe17717-7aea-48fd-d01e-08deb878ea8d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:11:00.9258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IANhIrPpZJo9VwG9rf7tV6kL5MRjFB1TPfgtYmr9okSlXUM4/TT/mSgsXlFb3kO2G4pp2BoVDdZ/UHsIDQb3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> Move constants and functions to be inside the impls of the types they
> are related to. This makes it more obvious what each type and value is
> for.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  Documentation/gpu/nova/core/vbios.rst |   2 +-
>  drivers/gpu/nova-core/vbios.rs        | 185 +++++++++++++++++-----------------
>  2 files changed, 96 insertions(+), 91 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard


> 
> diff --git a/Documentation/gpu/nova/core/vbios.rst b/Documentation/gpu/nova/core/vbios.rst
> index a4fe63422ede..9d3379ccfb30 100644
> --- a/Documentation/gpu/nova/core/vbios.rst
> +++ b/Documentation/gpu/nova/core/vbios.rst
> @@ -232,7 +232,7 @@ Falcon data in the VBIOS which contains the PMU lookup table. This lookup table
>  used to find the required Falcon ucode based on an application ID.
>  
>  The location of the PMU lookup table is found by scanning the BIT (`BIOS Information Table`_)
> -tokens for a token with the id `BIT_TOKEN_ID_FALCON_DATA` (0x70) which indicates the
> +tokens for a token with the Falcon data token id (0x70) which indicates the
>  offset of the same from the start of the VBIOS image. Unfortunately, the offset
>  does not account for the EFI image located between the PciAt and FwSec images.
>  The `vbios.rs` code compensates for this with appropriate arithmetic.
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 9cc2f008bbfb..07b5235faff8 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -27,16 +27,6 @@
>      num::FromSafeCast,
>  };
>  
> -/// The offset of the VBIOS ROM in the BAR0 space.
> -const ROM_OFFSET: usize = 0x300000;
> -/// The maximum length of the VBIOS ROM to scan into.
> -const BIOS_MAX_SCAN_LEN: usize = 0x100000;
> -/// The size to read ahead when parsing initial BIOS image headers.
> -const BIOS_READ_AHEAD_SIZE: usize = 1024;
> -/// The bit in the last image indicator byte for the PCI Data Structure that
> -/// indicates the last image. Bit 0-6 are reserved, bit 7 is last image bit.
> -const LAST_IMAGE_BIT_MASK: u8 = 0x80;
> -
>  /// BIOS Image Type from PCI Data Structure code_type field.
>  #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>  #[repr(u8)]
> @@ -65,14 +55,6 @@ fn try_from(code: u8) -> Result<Self> {
>      }
>  }
>  
> -// PMU lookup table entry types. Used to locate PMU table entries
> -// in the Fwsec image, corresponding to falcon ucodes.
> -#[expect(dead_code)]
> -const FALCON_UCODE_ENTRY_APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
> -#[expect(dead_code)]
> -const FALCON_UCODE_ENTRY_APPID_FWSEC_DBG: u8 = 0x45;
> -const FALCON_UCODE_ENTRY_APPID_FWSEC_PROD: u8 = 0x85;
> -
>  /// Vbios Reader for constructing the VBIOS data.
>  struct VbiosIterator<'a> {
>      dev: &'a device::Device,
> @@ -110,73 +92,79 @@ struct VbiosIterator<'a> {
>      }
>  }
>  
> -/// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
> -///
> -/// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes
> -/// the PCI Expansion ROM images (VBIOS).  When present, the PROM shadow
> -/// method must parse this header to determine the offset where the PCI ROM
> -/// images actually begin, and adjust all subsequent reads accordingly.
> -///
> -/// On most GPUs this is not needed because the IFR microcode has already
> -/// applied the ROM offset so that PROM reads transparently skip the header.
> -/// On GA100, for some reason, the IFR offset is not applied to PROM
> -/// reads.  Therefore, the search for the PCI expansion must skip the IFR
> -/// header, if found.
> -fn vbios_rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
> -    /// IFR signature.
> -    const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
> -    /// ROM directory signature.
> -    const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
> -    /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
> -    const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
> -    /// Size of Redundant Firmware Flash Status section.
> -    const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
> -    /// Offset in the ROM Directory of the PCI Option ROM offset
> -    const PCI_OPTION_ROM_OFFSET: usize = 8;
> -
> -    let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
> -
> -    if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
> -        let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
> -
> -        match fixed1.version() {
> -            1 | 2 => {
> -                let fixed_data_size = usize::from(fixed1.fixed_data_size());
> -                let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
> -                bar0.try_read32(ROM_OFFSET + pmgr_rom_addr_offset)
> -                    .map(usize::from_safe_cast)
> -            }
> -            3 => {
> -                let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
> -                let total_data_size = usize::from(fixed2.total_data_size());
> -                let flash_status_offset =
> -                    usize::from_safe_cast(bar0.try_read32(ROM_OFFSET + total_data_size)?);
> -                let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
> -                let dir_sig = bar0.try_read32(ROM_OFFSET + dir_offset)?;
> -                if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
> -                    dev_err!(dev, "could not find IFR ROM directory\n");
> -                    return Err(EINVAL);
> -                }
> -                bar0.try_read32(ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
> -                    .map(usize::from_safe_cast)
> -            }
> -            _ => {
> -                dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
> -                Err(EINVAL)
> -            }
> -        }
> -    } else {
> -        Ok(0)
> -    }
> -}
> -
>  impl<'a> VbiosIterator<'a> {
> +    /// The offset of the VBIOS ROM in the BAR0 space.
> +    const ROM_OFFSET: usize = 0x300000;
> +    /// The maximum length of the VBIOS ROM to scan into.
> +    const BIOS_MAX_SCAN_LEN: usize = 0x100000;
> +    /// The size to read ahead when parsing initial BIOS image headers.
> +    const BIOS_READ_AHEAD_SIZE: usize = 1024;
> +
> +    /// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
> +    ///
> +    /// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes the PCI Expansion
> +    /// ROM images (VBIOS). When present, the PROM shadow method must parse this header to determine
> +    /// the offset where the PCI ROM images actually begin, and adjust all subsequent reads
> +    /// accordingly.
> +    ///
> +    /// On most GPUs this is not needed because the IFR microcode has already applied the ROM offset
> +    /// so that PROM reads transparently skip the header. On GA100, for some reason, the IFR offset
> +    /// is not applied to PROM reads. Therefore, the search for the PCI expansion must skip the IFR
> +    /// header, if found.
> +    fn rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
> +        /// IFR signature.
> +        const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
> +        /// ROM directory signature.
> +        const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
> +        /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
> +        const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
> +        /// Size of Redundant Firmware Flash Status section.
> +        const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
> +        /// Offset in the ROM Directory of the PCI Option ROM offset.
> +        const PCI_OPTION_ROM_OFFSET: usize = 8;
> +
> +        let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
> +
> +        if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
> +            let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
> +
> +            match fixed1.version() {
> +                1 | 2 => {
> +                    let fixed_data_size = usize::from(fixed1.fixed_data_size());
> +                    let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
> +                    bar0.try_read32(Self::ROM_OFFSET + pmgr_rom_addr_offset)
> +                        .map(usize::from_safe_cast)
> +                }
> +                3 => {
> +                    let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
> +                    let total_data_size = usize::from(fixed2.total_data_size());
> +                    let flash_status_offset =
> +                        usize::from_safe_cast(bar0.try_read32(Self::ROM_OFFSET + total_data_size)?);
> +                    let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
> +                    let dir_sig = bar0.try_read32(Self::ROM_OFFSET + dir_offset)?;
> +                    if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
> +                        dev_err!(dev, "could not find IFR ROM directory\n");
> +                        return Err(EINVAL);
> +                    }
> +                    bar0.try_read32(Self::ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
> +                        .map(usize::from_safe_cast)
> +                }
> +                _ => {
> +                    dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
> +                    Err(EINVAL)
> +                }
> +            }
> +        } else {
> +            Ok(0)
> +        }
> +    }
> +
>      fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
>          Ok(Self {
>              dev,
>              bar0,
>              data: KVec::new(),
> -            current_offset: vbios_rom_offset(dev, bar0)?,
> +            current_offset: Self::rom_offset(dev, bar0)?,
>              last_found: false,
>          })
>      }
> @@ -186,7 +174,7 @@ fn read_more(&mut self, len: usize) -> Result {
>          let start = self.data.len();
>          let end = start + len;
>  
> -        if end > BIOS_MAX_SCAN_LEN {
> +        if end > Self::BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
>              return Err(EINVAL);
>          }
> @@ -205,7 +193,7 @@ fn read_more(&mut self, len: usize) -> Result {
>          // Read ROM data bytes and push directly to `data`.
>          for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
>              // Read 32-bit word from the VBIOS ROM
> -            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
> +            let word = self.bar0.try_read32(Self::ROM_OFFSET + addr)?;
>  
>              // Convert the `u32` to a 4 byte array and push each byte.
>              word.to_ne_bytes()
> @@ -267,7 +255,7 @@ fn next(&mut self) -> Option<Self::Item> {
>              return None;
>          }
>  
> -        if self.current_offset >= BIOS_MAX_SCAN_LEN {
> +        if self.current_offset >= Self::BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
>              return None;
>          }
> @@ -275,7 +263,7 @@ fn next(&mut self) -> Option<Self::Item> {
>          // Parse image headers first to get image size.
>          let image_size = match self.read_bios_image_at_offset(
>              self.current_offset,
> -            BIOS_READ_AHEAD_SIZE,
> +            Self::BIOS_READ_AHEAD_SIZE,
>              "parse initial BIOS image headers",
>          ) {
>              Ok(image) => image.image_size_bytes(),
> @@ -416,6 +404,9 @@ struct PcirStruct {
>  unsafe impl FromBytes for PcirStruct {}
>  
>  impl PcirStruct {
> +    /// The bit in `last_image` that indicates the last image.
> +    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
> +
>      fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
>          let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
>  
> @@ -439,7 +430,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
>  
>      /// Check if this is the last image in the ROM.
>      fn is_last(&self) -> bool {
> -        self.last_image & LAST_IMAGE_BIT_MASK != 0
> +        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
>      }
>  
>      /// Calculate image size in bytes from 512-byte blocks.
> @@ -505,10 +496,10 @@ struct BitToken {
>  // SAFETY: all bit patterns are valid for `BitToken`.
>  unsafe impl FromBytes for BitToken {}
>  
> -// Define the token ID for the Falcon data
> -const BIT_TOKEN_ID_FALCON_DATA: u8 = 0x70;
> -
>  impl BitToken {
> +    /// BIT token ID for Falcon data.
> +    const ID_FALCON_DATA: u8 = 0x70;
> +
>      /// Find a BIT token entry by BIT ID in a PciAtBiosImage
>      fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>          let header = &image.bit_header;
> @@ -604,6 +595,9 @@ struct NpdeStruct {
>  unsafe impl FromBytes for NpdeStruct {}
>  
>  impl NpdeStruct {
> +    /// The bit in `last_image` that indicates the last image.
> +    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
> +
>      fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
>          let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
>  
> @@ -627,7 +621,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
>  
>      /// Check if this is the last image in the ROM.
>      fn is_last(&self) -> bool {
> -        self.last_image & LAST_IMAGE_BIT_MASK != 0
> +        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
>      }
>  
>      /// Calculate image size in bytes from 512-byte blocks.
> @@ -799,7 +793,7 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
>      /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
>      /// offset.
>      fn falcon_data_offset(&self) -> Result<usize> {
> -        let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
> +        let token = self.get_bit_token(BitToken::ID_FALCON_DATA)?;
>          let offset = usize::from(token.data_offset);
>  
>          // Read the 4-byte falcon data pointer at the offset specified in the token.
> @@ -846,6 +840,17 @@ struct PmuLookupTableEntry {
>  // SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
>  unsafe impl FromBytes for PmuLookupTableEntry {}
>  
> +impl PmuLookupTableEntry {
> +    /// PMU lookup table application ID for firmware security license ucode.
> +    #[expect(dead_code)]
> +    const APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
> +    /// PMU lookup table application ID for debug FWSEC ucode.
> +    #[expect(dead_code)]
> +    const APPID_FWSEC_DBG: u8 = 0x45;
> +    /// PMU lookup table application ID for production FWSEC ucode.
> +    const APPID_FWSEC_PROD: u8 = 0x85;
> +}
> +
>  #[repr(C)]
>  struct PmuLookupTableHeader {
>      version: u8,
> @@ -923,7 +928,7 @@ fn new(
>          let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
>  
>          let entry = pmu_lookup_table
> -            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
> +            .find_entry_by_type(PmuLookupTableEntry::APPID_FWSEC_PROD)
>              .inspect_err(|e| {
>                  dev_err!(
>                      second_fwsec.dev,
> 

