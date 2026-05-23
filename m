Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EA0CD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E5A10E047;
	Sat, 23 May 2026 03:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dJJLJ/3f";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CAE10E047
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbppHw6+ZdNJo7hUL0B7OHMEh+1o9y8lSIDlnSAHAev/G7ejIsduqrzCs7fL6g0vGt5mFkKldy/Ivi6iKMR/1i7rMpmcW4kw4QXM1RsurjdFQwBV7LWE8kxqAppLQ+9Vq8qLAEK1Gnr/+9w8FTcZpr9IwHlE+cf7cFvLqUlFC2hTXtOPYnFRwC0d117ePI2UoORPk0C/FTifHIsTvsXBAb0KnEaC5mD2je8T4QN923Fj93Tx7GPJIFNw/AEWwEdPXd+vkAoWuleGeOrIIeP2pe8KCuwwkg/wGq552qDp6tVxQbP/YuNZyG6qbcGilm+dGX2JeN6C9WUxAYNPugaRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOynArN+lkpwUmiQxvWvJhkcK6XQdzUhPb6uMQbHzPk=;
 b=nA2Vd4jx0LK3y7EeHzUByV1uJ3tu2g9y4Gvd9k84G2RWoPm1U+fA6AyVIQ5691nNW15DU/pr2WLvUJDxlvBGy6M9oWl5rrOLZkT6s4ZRhBoWOnHAZH70+G3ACaDgO3M15t7Pz+OWP13fr+8VfUIj3S2oiKwaprdUEHF0glt1Cm+4XOk2ZlH1hCQcHNMtCHwnu5p+G5KowUzJb3WxjnKHuidrd8qKXrJ60Rs2V17r4zfPt1ew05ps+Vvmj+GnAyn7nUCaulpLWaAboulHHdvBqYDTFB8xmmMbk+Xwjx4Grw0IIf8GnEcINbDKHVeMBhAmHWh38Eq9MWZx+yHBZcyLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOynArN+lkpwUmiQxvWvJhkcK6XQdzUhPb6uMQbHzPk=;
 b=dJJLJ/3fC+vyHWgdpt9zqBZRLhKCbElZP7PrENQaXBceMYfIW/zp6y09gGWnOFmCiCGlcG9ymNZe3P77Xh0+Z15cWyIhpkwh/Sm6zI5uZUGcbU39yvupj6SBjo4a029qNC6xtLw0JD1p6Y1BxSeEFmfZLDHGx4YB1no66J1yQaA+mu7FXdwGNOneVRg1hreM/KI4aatZruyku0HFHL5UgPDRRIdLT/JSeFO12iUXZIEfqOCGAi5B/7S3smUqVhL6Q7JxPABp8KM5KLfHvAbf1gKRioNc/SVB0HcBw+wpeHJhOK2Ea9IGiaT1T1bS5Qp+xQ5EhhvxikiaXumLaUSdIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 03:35:14 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:35:14 +0000
Message-ID: <4e7b5050-a120-4fd0-a208-7e9d5f61f402@nvidia.com>
Date: Fri, 22 May 2026 20:35:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/20] gpu: nova-core: vbios: use the first PCI-AT and
 FWSEC images
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-15-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-15-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 2815e8af-b574-4e80-695d-08deb87c4cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WAuayrYdLV5NA2qISkTeqxXwNauLCGvB1Mq+ygJuIu19n4PNj02kWnrIoZ3ZSL8IVbUEZBV3sx71JP+RFevzpvZwHRPCBdWlsO5hkjXQpgoKmtKyFcKPlxwqGPzSN1xqcV0wSoI8kHYMM6zASeIp6rYML/R6wDQnSjeEQEN32J4hgd11KlFYVzoOGq7mdhC+KB78mmvpqrikiA94uSg43ld4YnHtNzfgt0awMFzJJfSXcR+8ss1ag0o4LMmm5kOOIz/8+2PpvmV+I1Csny8vP6UWsYgceAu2iffnhMFckny054NcqWq2FLD0ymMUbtb5N0jqUwPp5vtFy51ncjjR2FoNjmMEE/8q4NLrdSTTnJ8yhqcdX5P4wtBHn7HsxM8Nbp2McDuzycrdfZEP24a1GsLM5YngSO3RbW3qnFX/R7WRmKN7OzydCxMALrkojkWwrI1CpSgd1VbAIDuiM5ZQDei5GYuq8G/uLNC5/BItQ6zQmk3TYGVd9Si6h3pYy8V+JcK3o8ATL/UjMX8a7/Sf0hVAP5baoSU928TsAUk2xhcnFDjQMyJlaOzU54jT7So4h5JncoBQeGyD/WuUKHK6bGCTTWcGHLj/zwRhn2eioFs4ov/X8OtaMXJFFqORAv45eLEbhVIBxPq/x9uyCReOdQI5J0d/rRSdF42Gakkze44rrKsbdCBBdvl7b75RZ0zH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWgzVVZvRXhVRlRGTE1yeDdTSmpWSVpFeEFweERCb1ZaNXFEaHp2L21HWlBO?=
 =?utf-8?B?NElyUjNEWmE1bUszV0JtbGkwVUtOMGF1Z010TVk2NjltL0NMT1hBbGVrMDQw?=
 =?utf-8?B?U2lIejlZbzdQcTI3a3M3Y1c4MnZoc0swc0FXL25VdkgxbDZYeVhKb2dnbU1z?=
 =?utf-8?B?dDM1NFA3aFJmZ09rSnRlZzV2WjNneXB3MExRNytiajV4QXlJTGRaVmVyUzgw?=
 =?utf-8?B?K2I1S3YxVUZ3YU9uakJHV2hUems4bnBPMUlOd01rdHpaNnd3ZTVwSWFjU29X?=
 =?utf-8?B?YVRIU3JVcXhsV0RNSDAwVDBjUThERUFSbUltSFF5SWJjamQyMDhKZ0x6N0Vl?=
 =?utf-8?B?am4xN0ZVT1ZyMnh1bXNFTnVGK3dLaTJPV2ZwakhRMTFSM0dLL2R6UDBZYXV0?=
 =?utf-8?B?T3BQQXdNdktiWmpsUU5NeDZrWFZ2cHJSQlRMZVFSVWlyQkZwZDY3bTJHTlBN?=
 =?utf-8?B?aE05WFNkQ0dJejNwaDVueGlmNUdubGQxcVlLYzBQWHJtMkdhblY1MDBoSW9r?=
 =?utf-8?B?eFM5K3ozQXlkUzlzZ1JLd1dDUS93Y05ER1c1Rk52eHF1SU5xN0Q3OHhtVVBn?=
 =?utf-8?B?eFEybFJsMmh5cXRRR3JHTDNUVW1RbENpK1N6ZUhLSmtrQ09DT1FQZGxsSG81?=
 =?utf-8?B?bFRLSmtDUFBuSXhPSzJ6V3Z3WTNKcWFUazRaOFFxTm9tYk11ZVFsZk83MktJ?=
 =?utf-8?B?ejZremdXUHk1MXVLY0w1enJ4M0NDMzdLcmg1VzlSNE9Ea0dKdnowOVVZT1Yz?=
 =?utf-8?B?NmY3czF4MU1Ka05sMCtEZHlHYi9BOC9KSkF4eEw2cTViN0xDbGdVMk5uWE5B?=
 =?utf-8?B?STlqQmhDdzNQaXBqM3R0c1lPcEUxZ2FSZktIMmlFaEYyTkcycU4yclN6Rkwr?=
 =?utf-8?B?c3VkbTl2Ulk3cDVxQ0prS04yeWtQR1hZQnNsenVHWjJYTXBoazhWZDRrL0tD?=
 =?utf-8?B?QXBaUXpGZ1dxU0Q0Zkt5U0FmTTdkZE8vL0RqZDVJVVVmbDdMTEZRQzVyWU41?=
 =?utf-8?B?MWxPN25QVnQ2SXQ3c3BYZThlTlRQdE5EWURoakM0blMvOUFlRVRnbW9UMmJo?=
 =?utf-8?B?RS91OUY3YzRHRklHM0RjbHQxbzNIQm0wUXFFTGhkSGhKbldWMjVjMFc5cHVO?=
 =?utf-8?B?SVREVFY3OE9tV3BiMm1NYU5BNVdqUHF0bEdWeU16OFN0TjhPajJRMXNDNnY0?=
 =?utf-8?B?eGx0dGRMN09ScGhaRlZpUUpKdDFtdkNEblgyd1VoeHlQVCtnbFhhb2hSUkMw?=
 =?utf-8?B?T0VOUzdGV3AwU1hkQ3R3Nmg0NFc4L0tRakQzTkFwdlIwa2I2V2xSajVob21F?=
 =?utf-8?B?QU4zU0tnQ1ZJS0M1STF6L1dCSFJ0Z2Qva0RMRWNDd3FMci8ydldWSWhzOTJ3?=
 =?utf-8?B?blowTFJhNXJPd3NjdEY3c2lCalh3dUlGZlhwRXkzbmhFU2FEbXJZQ2RyZUQz?=
 =?utf-8?B?QUVSVmQ0UDBXcjA4MlRlTHBCM2ZqZmEwN0NZR085YkIrTnExMmo2c3pXemp5?=
 =?utf-8?B?aFUrVFFaMUVtanlXS0ltSjU3TkdTSC9rMFE0MW53aGJ0R2lKclVsMXM2V0JI?=
 =?utf-8?B?a2UxR0ZyY3ZvN2Fxd2lEbVVuVlM0R2lOZFRXOWNYYXdGOEZPM0RoTUo4VTM4?=
 =?utf-8?B?THl2V2xnK0hiRWs4T2Yray95b2xtWnp1N3B6Z01mT2oxN3hocmtKWnBJZjhk?=
 =?utf-8?B?UEc5bXVDTFVGTmRNT042SGcvZzU2Zmk0N21BVTBzYmRmQkhURWFVWDVqOGlR?=
 =?utf-8?B?RTJiRy9wMUZrMjJUS0d5ZFhCaE1jR2xwTFpRWTZNdXZOOUd3MHg2M1dOQ1Zr?=
 =?utf-8?B?RHJnVm9YRTI0WEQ5UFZtTUlkd0Q5YnA5S1RoNjBYTVpIQldNVGR6bm5RbmF1?=
 =?utf-8?B?QVl3cmFkS3BWR1hzbjJIcFlBWCt1UFhZakQzeVZSRTExRGZ5bkhiSjJsSnFt?=
 =?utf-8?B?UkVOK2p3akQ3ck1JMFk0MlNwMkpOKzZkait2bzNUSXFKaHhNd3RNWk5jTkpx?=
 =?utf-8?B?dDBJTUJCRHhXdHNEMkpXVUZkbHgyakNxejlmRkVPZVptMEZQV2hXRTZ3Y2Yv?=
 =?utf-8?B?MmpYU2ZTVmtCQnlPMUtqMEZ2a0dRQm9UWDRxT2hWQktwR1gwU0lSUGcwY2Z4?=
 =?utf-8?B?b2QrYloyK2VPV00xWFRjTlRaOFNGalpIaS9HekpkWDNOQUZpY3JKelZqOWpy?=
 =?utf-8?B?ellwZG5URlVmaS9MT0Y3NTVDaXdDdW9ZZWZUc0pZcXBoTDhOZUl4L2hoamlS?=
 =?utf-8?B?UkpSMVIyME8wTERrcHNOdjBFcE9jbTJrWjNKVXZtcnUyUm9DK1dlN2w0M0Ex?=
 =?utf-8?B?M2hxOFFmdjdLMm9BZmNhVWUxZmd1MUJSdDA1MDBGU1A2VlI2VmNFQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2815e8af-b574-4e80-695d-08deb87c4cdc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:35:13.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acXg3/VRecu/NU9HxhFlaQR5MJWDnHpdOQb+UQL2ORVkYLySBNgasGtFfdgQcpfhAe6ZH/9sTLMJ35MGk/svYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
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
> Currently, PCI-AT takes the final image if multiple exist. For FWSEC, it
> takes the first one and the last one. Align both of these to nouveau
> behavior by taking the first ones.

Let's do even better, and use Open RM for guidance instead of
nouveau, for this case.

Open RM tracks one offset where the FWSEC region starts and reads
everything past it as one buffer (see s_locateExpansionRoms() in
kernel_gsp_vbios_tu102.c). Matching that in nova-core drops the
first-vs-second-FWSEC dispatch and the second checked_sub in
FwSecBiosImage::new.

This saves about 40 LOC.

I think it's worth doing.

thanks,
-- 
John Hubbard


> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index c5dad9e065da..ff21f85fdfb6 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -333,12 +333,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>              // Convert to a specific image type
>              match BiosImageType::try_from(image.pcir.code_type) {
>                  Ok(BiosImageType::PciAt) => {
> -                    pci_at_image = Some(PciAtBiosImage::try_from(image)?);
> +                    // Silently ignore any extra PCI-AT images.
> +                    if pci_at_image.is_none() {
> +                        pci_at_image = Some(PciAtBiosImage::try_from(image)?);
> +                    }
>                  }
>                  Ok(BiosImageType::FwSec) => {
> +                    // Silently ignore any extra FwSec images beyond the first two.
>                      if first_fwsec_image.is_none() {
>                          first_fwsec_image = Some(image);
> -                    } else {
> +                    } else if second_fwsec_image.is_none() {
>                          second_fwsec_image = Some(image);
>                      }
>                  }
> 

