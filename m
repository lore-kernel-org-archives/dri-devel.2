Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8479ACD5BB3
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 00:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6E210E043;
	Sat, 23 May 2026 00:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAIgrbEY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DD510E043
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 00:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGxC45rGXThdEX+elJsCCLKBkGWE0YIu5S0TzVIZ4iwP9P/42B/KXwmaArA2o7qLklsVL8ZszRfoAdIK/C7XtOGewdrTHpmP6JjXDVMTfUHnXh0I+TfG+xA4OuG64Hfdnryzmhp9xtDiHLG52nyQgUyEcf+VmPevOsYMQOsIm41//m9SdlJ+/muQBczA4pu1AHEv4k1Ppm+2LBmec1b+Jqh7lQnwviXjhv7PW0fHx7yw9bsZMvwS4vjU9xsISDK4qnQQ+sImM7ZFpdXpalpvtA48ylaw2mdJLRfOTcPfTuRiBMl4hkOjfqNX4a4o+vvd8QCKJKkt/tODnkV0h9v1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDMYhXft+k1xzyogkftZKkzkAriD2+9oUielgcNvlB0=;
 b=cS4nBQDTliqt7eFlhFrdK+Nkbk/U3SyyMrCR21z+1ljDCHLe6CfOv65nvGS9ocsMMqwexnM1IHcl7qATJTOymyn12tyhulpoOHHeBijt8WxOsmH4LM64Da9Wb63RczbmMI7vYWb35XOOS//nPdQW26Nun5smDI8xuxD4qgXHkqWPe+u4jpjJ36Wt8KMUIhYhzXdo0b9QrA8Fwdzt9GyRkK1oaAX1utam+nQiu6+cXwVgvuXqzhxB9ieQ9pnmKheVvoIB7Htz1l4qw9mNHjRwcRaNCqB8PlM3oI5nCELZ3WE2vnkk+Ds/K7/QRBrdwO6rf/fuBvHaCUFYZgB0sLRifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDMYhXft+k1xzyogkftZKkzkAriD2+9oUielgcNvlB0=;
 b=RAIgrbEYGDCD/2IdOu0qbmHXQHr2n130oiEnExeM84529MerFmP1r6uFotWOMKXEWT0zPPHa9CByFrvHY5nGBHoM18bET3bHrcutzZorqSZJ3S1IchMKMew1SqqtQ1ByEu4m+rmdYfXNqfAY3X2Lkxlxox/clnSZkypsecIa+LL4irWDMBJSE5EfADASOYcIYiCTiGQirELyd4OEhwqG3bSfM3LEMZ3/W5zph/P/T1ouk62JZ+OUn8918PQTrNQ2r0rohyCo05N6HHOK4qmQYZTKJZzI+X68oG4YR4re9CeO12tcgi85aQNWjbOY/tRWFKWXjBvbTC8Oua9eanTNMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 00:13:59 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:13:59 +0000
Message-ID: <b7bba000-adf4-4ebb-939b-8f9f549fa6b0@nvidia.com>
Date: Fri, 22 May 2026 17:13:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/20] gpu: nova-core: vbios: construct
 `FwSecBiosImage` directly from BIOS images
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 943133ad-8998-49e2-8f4c-08deb8602f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|11063799006|18002099003|22082099003|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info: uvPgMamcKiZ50cxLH/Ty/zn5OZcnnGh9ivMwOVKqX0EIgZ+TwGVrMB/MnS35qEzbbxsFvUrkUjgwuWxTUotIWKiYDcrd9nnK61x9HkjRaMJh9XTHj+bydiZkCN1c2caHQnXPQ8wxlRXzMZOpKoQISsPtQjzWtqdF6WRf5+2eGtBx+3+6AqMKdZNEHRRIgbZU8jfRZvsZ4w02qq3eGBwUu+fSYDx5GbButYLNCu+Cq+Tm//ZLVlZavjegexUWgwlD8e9kDhagqepphu+AZCv5VFs0AQThYT8tm00IGVOU5ldLuktDqe1zx62+RNoEKhJL+pJeFuR2Q86X12WhTjf/Yf4k846FkvPc/P9c3fm3OiUXKL6qyKKAz1h0JffhKSIKcOPs+EPJZEjfKzxa7qTQ0Qx1U9UgI1sbiW7oCET+vghH+MBtSR9QceImRTapQKvGaJ9g0tmlAHWd6nHvqCq5ehIUo9agCoh9H1cTv8IeNyZ6wDGp1PLvze3tsum9ZPFzI5SQ8Nj6AlUydyMsIl5+lRTg6xw0g3+3Pjqcrf3m0NGpoFty/iMdVATokvcFLfkTW5VxeMWLYqbxXB2SuvB2eC2qPNnWSsWtMFuakonrNdynG/b3UO5I7D1pvQRXeOJwAc2s+59nQz5Q/oEmh6eC4ukWTERv/idXJQRvqpdWrYlETthnBH/6N4Lloq4AzMpw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lzbTAxUmpqODRwVTcwellYNFZSSWdxTHJIcWtycGpVR09iTFlsTkR2SVc4?=
 =?utf-8?B?RTdFamJ4QnE4NHdFRWhsVFMyK2VPSEQ1eU9RMXp1Z2FuY29qa2pYOThERERR?=
 =?utf-8?B?YzF3Q2tpbDcwYzg0OTBjVzY4bzFIZVZzRlRyTW5wUy9SeHBuckNwa1dVS3Vr?=
 =?utf-8?B?YUN2WXJDSUdjc2ZhcGFEa2Z0bDZ5RGdYcmxKWVl2bTRtTjVtSHdJVjNLbW1X?=
 =?utf-8?B?STMwWE8rUmZTejY5SE1HNGRXODFwc0svSW83UWdRcGhXUHpFQU9QUVlDMHRr?=
 =?utf-8?B?Q2Q4VCtDbGZlUThXcks2eFdVSXhyQVV2SW8yUTAyVDRWUlNCcktadG1YTDdo?=
 =?utf-8?B?V1JRSHhoQlFKcko0bExWbVIzTXllWklEQ2VZUWN6SEtBQkFZNTJxYldKRnNa?=
 =?utf-8?B?QkRnSCtXT1JGTkJUdE9FamNlUHg4VUlPRjk5TlNCOTFLMnhWSWcyZnRuQXo1?=
 =?utf-8?B?MUlFTG03dXFXcDRsVDY3ZkxtcGZicS9ocCthd05pblVKN2RlWm1TSjBQL1hC?=
 =?utf-8?B?TXpCdE1UUHJzQ3R0M3BiREpVblh2NjJHSzRlOUhCZ2V5OFk1U0x1SE1PVFBk?=
 =?utf-8?B?QVNlNndvRElabUxoS0h2dXR2ZEUxdVNkNzdEeDlncTVFOHN1YlkzZFAwdWJh?=
 =?utf-8?B?YnU4eGdOWFdsaHJzdlc5b0dZYjYrYzBhKzk5STR2c3lJbXd0bk4zNVY0cjFS?=
 =?utf-8?B?bG41R2tTcCtlbVNMY2RJWDBFejJMM3R4UndzeCtLMGZnNU1hR2hNNzUya2hu?=
 =?utf-8?B?U2RLd0tNS2ZYNjRtYjV4MHMzdVJKRStjNWpZdUoxVEZIVlQraExhQVhHVnRy?=
 =?utf-8?B?OUZ3S0t4TDRsYkNVdUJ1QXN2cm1YUXVKRWF2clRYWWVVVWs4NGlQUE1sbms1?=
 =?utf-8?B?R0pNMTNHclVSVGptWDcrQkM0akZWNTlhb1RKb1FrUjd4bzVxdS8yakdxdjBr?=
 =?utf-8?B?UHlORGQ5V3JWbU5ENVlTMjhEeEIxWkQ2Y2cwZlpVUUh3M2I4WS9WdGx1Q0dn?=
 =?utf-8?B?cFcwYi9GeVpOTGxJTGFwcGFqSXpFbXZWTTBIQlNLOXlZUDJONW95YmVndFJo?=
 =?utf-8?B?MHF3c0N3c3FEc1B2MmVxVnNHRHRwdjZLVExkejlQRE9VWXFvOGlheDVreU1Z?=
 =?utf-8?B?d2IvOVB0Q25wU2lkeFp0OVN3eVdWaW1ocnRlNDdRR0lsdFRvS0xmUmpoMWx3?=
 =?utf-8?B?WTZ6WTF4VVFLMllIdjRYbmpNT1FST2hvZFg1ZjErUWgrQ2tpRnZhMW8rU2hZ?=
 =?utf-8?B?THpITVdiSThibHdtaDkwQjAwajFCdzBzV294eld5Rk1IRlQzWlRLbDM5ZkFG?=
 =?utf-8?B?MmtIK3hjWkhIVUNSUWdJbmR2Y0dWMlpDcWpkNURKYkNkakJLVTdzWXU2ZkdH?=
 =?utf-8?B?WnNjbUtjYjNlZW9ESXk0VTQzNDB3MVI1U1dxc2R2azBXU0o4T0FiNWhjMWYz?=
 =?utf-8?B?MVJUVGxTNzgvZGdMSDR1Uno3SXRueWpveFJLT00xRU5teUQ4N0FkVC9nU2Vm?=
 =?utf-8?B?cU0rOHUvQkk2MDFvMWFVcnA3ZXZSUG5BdzdRQmlxVXcwVVgvVmUyTG8zQWVS?=
 =?utf-8?B?eE11d2pINFIxV2QxMGRsa21yV1A5c0RKc0hOTmpYdnhDaGlBVDBrZDc3ZVFM?=
 =?utf-8?B?VFY2azdHbVB2K2tjQlQ2VW5ocWQvNGdmUjlGb0tLaHpkSlhGeVNnRmU0QjRZ?=
 =?utf-8?B?WmM4U2d6Szk0YXEyRW9MK3VmM096eis0RlJQWk9yY2l2UzVaUUt6ZG5GTTZ0?=
 =?utf-8?B?aTl5K1VJSGpoVEJQZmxWRlFWbjEvU2YvUTdXR0hMSmFnRWkvV2Q1MUdKQnpr?=
 =?utf-8?B?Zk1qM3N3SnpQaGlHbUxoYVgzUG5sdzE4bDVwSGNkMUJLekZ0VUtTOVRzUlZH?=
 =?utf-8?B?STErTUFFNzMyU241anRhQUVIZXppWWladWdhYi9IdHYwL3Bsb1lUSjhrRjc2?=
 =?utf-8?B?RnVtcmo5TDcyNGZFYXNRZ3EwQUNBa1lPRXFta0tZVUlMWXIyUWlGVWoyOE9W?=
 =?utf-8?B?eDhqVlI0RmhBOHlkRDI5RXlWdVhQTWZhUnp2L1BGRTcyYTlDZHduRDVqMlhF?=
 =?utf-8?B?YkovekRoK2t0VmYxeWZlWlBTWVZYbzh3alhtWFltOTY1Wk5XNmZ3ZVdsM2Uv?=
 =?utf-8?B?cm5ETFdvWHZMbnVZSWFuNjZ4Q2NsZk1COUszOVowdjRNdzB5RDBWNTQzeDF5?=
 =?utf-8?B?QUZnYVhIdytSWnYzQ2xpdFdkMWlKUHpSQU1lU0lUUmtqRFFDTU1RQzBSMG5E?=
 =?utf-8?B?SWRJZXRmcEN5ZWtQeDBjU3B6ZnFnWnhSdmRTSTFHbmR3Yk5JbmJWQllZNDh2?=
 =?utf-8?B?VjdBMDRPOXBMOHhWWi9kb1I5KzR2NHE4WVJ2R1FXUUE3OUVJVEJxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943133ad-8998-49e2-8f4c-08deb8602f9e
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:13:59.0036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcyCAVS+bYtmNLYGJSFmVZ3lLmAvEqlQHpm6LVP5MMBxwkn6Yn7Ya+KoHrXcppvSvZV/6ecWGwZeZ2t/YmXIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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
> `FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
> gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
> and construct `FwSecBiosImage` directly, as a simplification.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 59 deletions(-)
...> @@ -353,15 +349,23 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>          }
>  
>          // Using all the images, setup the falcon data pointer in Fwsec.
> -        if let (Some(mut second), Some(first), Some(pci_at)) =
> +        if let (Some(second), Some(first), Some(pci_at)) =
>              (second_fwsec_image, first_fwsec_image, pci_at_image)
>          {
> -            second
> -                .setup_falcon_data(&pci_at, &first)
> +            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
>                  .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
> -            Ok(Vbios {
> -                fwsec_image: second.build()?,
> -            })
> +
> +            if cfg!(debug_assertions) {
> +                // Print the desc header for debugging

Both this patch, and patch 16/20 are doing a tiny bit of work to
preserve this printing. And that looks good.

However, after careful consideration over several months, I have
come to believe that this printing is no longer earning its keep,
even for debug-level printing.

A significant fraction of the dmesg debug level output is consumed
by this one print, for example:

nova-core 0000:01:00.0: PmuLookupTableEntry desc: V3(
    FalconUCodeDescV3 {
        hdr: 78381825,
        stored_size: 59904,
        pkc_data_offset: 1444,
        interface_offset: 28,
        imem_phys_base: 0,
        imem_load_size: 57856,
        imem_virt_base: 0,
        dmem_phys_base: 0,
        dmem_load_size: 2048,
        engine_id_mask: 1024,
        ucode_id: 9,
        signature_count: 3,
        signature_versions: 7,
        _reserved: 37449,
    },
)

...and yet it is exceedingly rare to make use of that particular
data, even when debugging.

Let's just delete it. As always, bringup people can add it back in
temporarily if they need it. But they likely never will, because new
hardware doesn't hit this path anyway.



> +                let desc = fwsec_image.header()?;
> +                dev_dbg!(
> +                    fwsec_image.base.dev,
> +                    "PmuLookupTableEntry desc: {:#?}\n",
> +                    desc
> +                );
> +            }
> +
thanks,
-- 
John Hubbard

