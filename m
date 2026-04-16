Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDE0F8D759
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B6710E8E7;
	Thu, 16 Apr 2026 15:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfaCMzp3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE16C10E8E7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKV7E+BPTKcW6mTTDjBgmlzLwfJHUzArBXPDCRbsQFJrDW3iPkpF/8TNF40Z6TuKHnJF3Q8n/7Tcj1M8m1n8vhMmOfSiyx75FK60btK1WWHEggXVAF28L1odv/dxVB35H8rVhE5RsMzzlm5sOhUfAQ2EWnOZxe4/XRLJhkBtKYozNd1W084mjHKpruZrwED4vitr/JK+drbnHUL7lHjJyPDsvZH+dQMG61YhlK4Imb4vVjZ7Iexf6DBNPK4PefNoSrgOUsjf3G+nIj3s1Zi5jD/SkvaDsOhUbusWOA5Guxhx9aIV7mFQrbrINvHwUY2pBmGe09uEeNC6CZH2saPWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4Kf1SsdoD1b8doiXeQA794mPWCoRv/+ku+IBLrNzIE=;
 b=LkpXxLeRZX8pAcO/HOpnWHh4G2eYEGrHvi4Z6MyLivY44yqt2jQ7DhWR/l83FJv5kNwRZfbIxcKR1aMvpsjBFTJjfCM/2sXRpd2y6+KRuw6+K/e1JuM1rk41Y9VUafMffYl6ienTwXCDvDcs89pOQZQ5eNGUlDpldr1B7EuvRCd3U88z4piJd6SfzX1WpOLzP8u9anSQto3/FeAhiE6o8N32Hg60dRfQRXre8oUC28fgLG77566XDHdKZyoGtwcQx63mn8aaRl2Dd2NH5itF5Jtlq4iiniOnDFX+Tyb0clktGSwIvvz0aQH3Fb799Qg8OKAaMeNDTu+W3aCn2TYo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4Kf1SsdoD1b8doiXeQA794mPWCoRv/+ku+IBLrNzIE=;
 b=BfaCMzp36iDVB9UXpWWu+SObJTLqwGUTBEtYAv/t3uJhTOuRVtjXqzF+KrtKPImMeF9jEZctPoOq7NUUFSKZbc+9P3sLozElwnZMPd98Q7XhAvPFz0hpE/cEEwM/yZbk6gPwaQCxvCeeeLuVriNY5hzYslrr/h0KEc+VIxbN0jvOY1mZztBRPVIsm3Buu0IL6oS4Cb6cFqNLC8yHp65/gU6Tv7E1ut2ijbPP4gd8MKeO+yiJiU/NtgnYFkMACyLuB/uN2Y63yFoW6r2v2XPg8OejVb7AYo0lcCV84Z/Fe8hpBak/PV4eHLZhnRxdHJdxSYMB2WZ2YKJ+4Mb6ZxnFaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Thu, 16 Apr 2026 15:30:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 15:30:23 +0000
Message-ID: <7f0ef676-2663-435a-badd-f4106cabf66f@nvidia.com>
Date: Thu, 16 Apr 2026 11:30:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] gpu: nova-core: vbios: simplify setup_falcon_data
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-9-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-9-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:408:e5::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e4045f-8f1c-4384-064c-08de9bcd135c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: AVZHT3QOBlxtgzgekImzFgZjAsu0VAzzzU/iybeAUIlC75ytalLS/iUyfjVFBSj3GnDlWAoZreTx0S3ltcck+6kXqdgbp/VBCS0RHePnSGD/HcFdkXLgk0w4G1ugXbQelS24aayVyreRI3DDtZnSv0Y+HPUGtAozy3U8X10bsWEpHP73xyzGFdau1AigjyE6sha9KIXLgxYRtJurMAmVpkOwDPmyzdsh/9ZlOTeB1WPETGzs+IC0mAJgXZ3HZHUSZOjmMkl2Qm5dHFsj7PS06FThitV3+KqMaJSqADutTUVlptkGzr6TB4p4Jqg60ijY8LYhmJ7k2QahQl+s37nZOb2izkbw4EQHeQMHGk50YGwInUF9EwolpXN2j1uWOr4aS0iq+RnYCaT6aa1fOOmIBz7rWWIKnwLvEkYwaKnKEpqVHifZ7Ugj9oPgmInsJX4sNiA5w/5vP1JsHcUuW6rblPdcsAuZ0TJ8lblhTYPotU32Anwx5Xgc0aXUFDTuzG9iWvgcfrUBtaT0dCn7thJ0VUXms1oHgh8ZZIcMvrZdf+c9UIBvtwIm+C5fAX6beNs/rCmntKowjHSUUnUdgxFjSkYehScguBnD7jG4XtvX214DwqSUC7ANNk2ElxZy8OrZWmXqn/0PW2xyXpaqBWJQQumT0xuw0K3g7IwTJAVtQS9QuXsnCs0MjFs5St716ttzJShD0wwNBTHogk9FjViV3Qxtcli2Agnw6LEuPPkd14Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZac2RYcVpidy9wVUFVQlBMdUJUVnJCdGUydU5ocm02STNJQnQwQjhWUzBu?=
 =?utf-8?B?QmJPT0t6cTR0N2x2UFdkRnd4ZThiODBjYmxTM1AwOXY5a25iN0MzUDRtajRa?=
 =?utf-8?B?VXk2ZW9rdWlwTUE4SkUveXFYWVJvNnU5RHdBUUhZMWpDS2luWHMyQ292Tmd4?=
 =?utf-8?B?aGNFSUw0cjVzVzNEU05JM2cyRDlGamx0Y3FKUDgwTTZYRWZkOFh5NXNjbnIz?=
 =?utf-8?B?SjUrM3N2K1JMTE1iK0kra2REVDY4T2RFOHdvK0RqRlF3UWdnY0hsVzZvUlF2?=
 =?utf-8?B?dUtiUUkzMlRlc0xzZEZoNHIvQURqcmNoZU52MDdCOEQybWVpVDVZeVFzcVZ6?=
 =?utf-8?B?S2JXZVZsSndjTUpWT0pldHZQZmlnUzRXWW80OHhDbFo5U1QwRHdvdVVqT0VP?=
 =?utf-8?B?b09IRytRNjlWbEVTQitPamtWdFFpd0VDQmlFOTN5TFBEMFUyZm9vK2VsUWU0?=
 =?utf-8?B?S0hFdWtLakd1KzFhRU9vYlVNZENEVFdpeG1FcGNqVHBiaDUxY0xYMjRESlpx?=
 =?utf-8?B?S3RhdFQrNEVHWkI3WHpmbmJDRmtJTkVoMlIzVkNUd01CRzZoTm5uODJVTWNY?=
 =?utf-8?B?cFZRYXBEaUpLSGZtT3B3WjFpdktmK0pDQWJpK3pvem9KMU1UbVg4SVpwV0VL?=
 =?utf-8?B?eWowblJyN1BSRVoyMVZreUx0Rzlja3o5c0FHTk5TNk8yYnVNdFhaM0h2ZUlL?=
 =?utf-8?B?ZFFPMFBXNXJET2ZJS0xvZVJMM1JiYXhDY0tYcW1vd1VIb3lMT1UwRFBoRk53?=
 =?utf-8?B?Z0FqNE92VUZhRGp1ZmNnaE9hZXprdXNzYTBDdGFWL1dNOTQyVWV4Rzc4QVVE?=
 =?utf-8?B?b0ExOG5kVnM1SGp6djZJNVMyZEo2TGdJdHZEN2w1NWVna0xhOXVPVU1GZ2sy?=
 =?utf-8?B?WTBVdWdSVGc4WTN5Q3BxdjNIcXpjOVg4NWJKNGVmSmRDSWxBbnZjS0ZQeFJm?=
 =?utf-8?B?OGZoZkhKME5FNGd1SUxUOURsZndaMzBLU2NnODlSb3ZIUnlFeWNJWVZMd3lV?=
 =?utf-8?B?clJNdm1kQjFWbUtadUsyNVhBV3lPUjhCbnRES0dES0xXMnVyY1lvWS9mK1NC?=
 =?utf-8?B?SnRzT3JYOXhZVUZ1QUsyWnF1cXZ0MVlRWDJqc3YxUFZqVzdBdWhDVktWcnFY?=
 =?utf-8?B?Q09BNjJzc1M4N3lkWmk1VXFYN3ErTW9qTGxYVWJ0azAwSlRISnZNU0h2Q3U4?=
 =?utf-8?B?T2ZIVC9CZVRJVzIydk55ZExIOHgwaVI2c1RLTUF5dVVkbEZuQmVvbGxST1pT?=
 =?utf-8?B?RGpqdTVqOVBaYmNBc2ZtNUJUMm9WTllXalNQZ1ZuMHNWRmcrZFh1dktQNHBq?=
 =?utf-8?B?bXZFTWpRMXF2VHRpQ3VMVGRCeElDSDhhQm01c05CMXE0TnlwclRNQU5CVDhD?=
 =?utf-8?B?dUIyd2RzNVcyYmp4Q2FQY3lJZUd3NEEwdjdvbk5CWUYwVTdtbnBUNWxDdHI5?=
 =?utf-8?B?WVZtb1c1OWFzaWFNcU15d0U0enJrdWpOeCtybVhYcTN0SEFJWHQxNUlRbjhr?=
 =?utf-8?B?SzkxT3UveUo3aE05RVdhQVIrRlE4T2NKZFBoQmFrb0RlZUsvRlQvcHRlTGhQ?=
 =?utf-8?B?VDBDVVpOaGQzRm1SUG5tOGFOOU5iNkVPNEVvcUJudzRVaUtrc1ZzdVBBZGJ3?=
 =?utf-8?B?THVEc2c4ZlgvMWFSelY0L0NjNFE2N0JoeWUvOG5RcFBXL1N1LzI0emhMQ1BL?=
 =?utf-8?B?TUdZTEs0ajR2UmJnT05sU1NURE9pMHQzQVJ0WmgzK1F6TWJ2MzloaENUN0RT?=
 =?utf-8?B?NDJlVDFhNGxuQ1ZXaG1tSXN1eHlicjM1QlIrV1VVZTVKaWQrVkR2a1c1d29s?=
 =?utf-8?B?SlZEY1Y1M2VNSnRsNzQrbnJNWk1JaDhHR1R0THR5RjdYeDhKQ3pDRlc3Qmxl?=
 =?utf-8?B?dE9VYWU1YzZaR2FLT2hqMWxaSGdnMXAxN0dYTHdVTEFNQ0E5dnM5WVNpNkUy?=
 =?utf-8?B?WE9pN0NKanZZWUN3N21hMmVCSlM3QlNmcFVaaS8yS2UxWVBFa3FHNk9yL2ZO?=
 =?utf-8?B?M1RJYmtkZVpjc2lsc256M1A3NEtHVGlRVmhoVWRWRDlScXpQYmlhUTZLZklB?=
 =?utf-8?B?TUU0QlpienJRc0lKa2xCQWNpOThzbi9ZM2RDWE5qL1VzalRtRkVMS3Blb2hS?=
 =?utf-8?B?T0lBcWU4cXV0Z0duMlRYV3YzKyt4K2pUa3h2cGh4Z3RmNC9LUDNJYkJFbkQ2?=
 =?utf-8?B?RXV4bUtvMS9IN25laHpBejlzeHNlYkx5V01CTGd6VDRkL05jd3F2TFJvMmF4?=
 =?utf-8?B?Rms2NkQ1Z1FpNDhTaU1UWHNjNlEyeTNPWTVpOVZYSGhueXpmaXJ3NVNJL1B6?=
 =?utf-8?B?L2FJQ1BiL3RLY2Y1SmxZamsvQUZ3MzY0Z2syU29RNVM4THZ5eGt6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e4045f-8f1c-4384-064c-08de9bcd135c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:30:23.1486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd60lsx7KHmF0HRayQFethJOCMkeHAU5mNL0wYBax5vYzr7jt3CdJ3B+Z42sL+aKVqoR8NCoMW6NyJL58FiH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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



On 4/14/2026 7:54 AM, Eliot Courtney wrote:
> Remove `pmu_in_first_fwsec` and reorganize some code.

The patch itself is a nice improvement but the patch commit message needs
more description [1]. Perhaps some of Alex's comments from here? [2]

[1]
https://kernel.org/doc/html/v6.19/process/submitting-patches.html#describe-changes
[2] https://lore.kernel.org/all/DHSJTFBXA2EM.1I22OK3J5NPRL@nvidia.com/

With the commit message updated,

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 59 +++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 0c0e0402e715..d71ff5de794f 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -904,48 +904,41 @@ fn setup_falcon_data(
>          pci_at_image: &PciAtBiosImage,
>          first_fwsec: &FwSecBiosBuilder,
>      ) -> Result {
> -        let mut offset = pci_at_image.falcon_data_offset()?;
> -        let mut pmu_in_first_fwsec = false;
> +        let offset = pci_at_image.falcon_data_offset()?;
>  
> -        // The offset is now from the start of the first Fwsec image, however
> -        // the offset points to a location in the second Fwsec image. Since
> -        // the fwsec images are contiguous, subtract the length of the first Fwsec
> -        // image from the offset to get the offset to the start of the second
> -        // Fwsec image.
> -        if offset < first_fwsec.base.data.len() {
> -            pmu_in_first_fwsec = true;
> +        // The offset is from the start of the first FwSec image, but it
> +        // may point into the second FwSec image. Treat the two FwSec images
> +        // as contiguous here and subtract the first image length when the
> +        // target lies in the second one.
> +        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
> +            first_fwsec.base.data.get(offset..)
>          } else {
> -            offset -= first_fwsec.base.data.len();
> -        }
> -
> -        let pmu_lookup_data = if pmu_in_first_fwsec {
> -            &first_fwsec.base.data[offset..]
> -        } else {
> -            self.base.data.get(offset..).ok_or(EINVAL)?
> +            self.base.data.get(offset - first_fwsec.base.data.len()..)
>          };
> -        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
>  
> -        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
> -            Ok(entry) => {
> -                self.falcon_ucode_offset = Some(
> -                    usize::from_safe_cast(entry.data)
> -                        .checked_sub(pci_at_image.base.data.len())
> -                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> -                        .ok_or(EINVAL)
> -                        .inspect_err(|_| {
> -                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> -                        })?,
> -                );
> -            }
> -            Err(e) => {
> +        let pmu_lookup_table = pmu_lookup_data
> +            .ok_or(EINVAL)
> +            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
> +
> +        let entry = pmu_lookup_table
> +            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
> +            .inspect_err(|e| {
>                  dev_err!(
>                      self.base.dev,
>                      "PmuLookupTableEntry not found, error: {:?}\n",
>                      e
>                  );
> -                return Err(EINVAL);
> -            }
> -        }
> +            })?;
> +
> +        let falcon_ucode_offset = usize::from_safe_cast(entry.data)
> +            .checked_sub(pci_at_image.base.data.len())
> +            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> +            .ok_or(EINVAL)
> +            .inspect_err(|_| {
> +                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> +            })?;
> +
> +        self.falcon_ucode_offset = Some(falcon_ucode_offset);
>          Ok(())
>      }
>  
> 

