Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E2F8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C63610E8EC;
	Thu, 16 Apr 2026 16:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UBxyPG63";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D9D10E8EC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDsdpRbwYDpUAruaeQde+dLDiY5OGJYnOtuxowRnp3vRgKqa07xlfhXQwvm1PCKwsmQJsMiGGaNenQKkcxAXhPycHJZ9pbKmpKVH83SXPkjxme1a203Pid7uvjJnaUICsrTmwysA//T0ERwVQkykUKqcsUEHmsdQVUo0Lu8radDnmKM8u2FYVzNg+hKC5KnmMG86bAMdqZHPp+B47NXIxyqn1bNyhB3d2aqtp67dCT0SYbxa2XWqx9OOsBRQVWei0uiJMTPPNCyO4PABMeTa5hWAA4rbtWQc9iOc1z6mFLoibREIuEHcD88cNwQKBnWfuYMmYCKAg6POxhq+GjRf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpCkr/gEm+RifmZpreE22SvbH9SaeHdRcjMA2u8P+CI=;
 b=l5B7/dDbs8NjQ9BYR18EDtHzqyrqtd4cYWoeu3XxXxEVbADPnvW/QDpxp4im0UcPNIljJslZ6ZTuYpXemEzV0VQk6f/Mxmf4TXNL06NKTFQsm/85bG5ixxWqwK327j0Nl+bKEXPsFWcllxNi1lKAuuXBpgnPXdDWJcXNDulLgwbu3e8A+iAD/uxuVC7vQzhUTQid8oaPlTQIaCOYnVTCX5HIZICFKpM1BzrJACqdFJ3ikYmDEP1RL4jgO4afMjMrBjGRroHVFcoqcDnKE1dMtwihe0eQMdX7K4As2G/5j9pNJo2IzWiULRPaNip4B14elH7Z8GATIIrEcwHqHeRLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpCkr/gEm+RifmZpreE22SvbH9SaeHdRcjMA2u8P+CI=;
 b=UBxyPG63nJE2TIuSLAow4qW8zs+uS7Jep23iPMCKgY9Klqh6i9gK2aecRFwsIHyPteaT1GxklJa8z7VICW51fchJcTkm9WdkqFsEEAmVSsvJp2fkdMvHBa4Xk5UHlRjLh6HMIhwowQRBNMMQLBPcuKk5PTRambq8+XHqSvyvYXD+FJM+XvCdVKsI+YunZOwXxTLW0++NgUV0pxj1YbKdSXUOfZrgsAjiw2uyjju0LJ8hw2/OkSyKm6EtZ0//lgORE7IXyS6X5PH8rSPSx2kne43wx19DLZJfy9YHSa9bBQ09nJkWTbde8z/ooUYF/TzameC0RD8uz1MtGnN2Vsxe7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 16:14:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 16:14:09 +0000
Message-ID: <a0f1d610-92e0-4cbf-ba15-0bc3ae8614ef@nvidia.com>
Date: Thu, 16 Apr 2026 12:14:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-6-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-6-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:930:45::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b511b0-13f3-442b-ba0c-08de9bd330fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: k2vayuolAybKr2P0Gvpkxla3sUuXmwzXvCNZCPmNGpx6skEJUhrgjMVqdvuuzAoXkgsD6E0WYvV5ele0fs1Ck/ukd28Z6ZrROlwyKW/zr+oqsT4/inxt5up6JH07kRL5ZA/KGxwJnLMDA1dHc6bztOouIECw1JF+U013bGVKxPQTNgU4NKwZIVzFcy/iqVNNBlRzdK0tSbqr0JvmmSQDXIxdW6BGxkzEhKvwr1BWNVq+VQCgU+59+L6/mN7Zd4XeuzQNwa2CKYcidC8DG/TrXkPduSBYdMge/E2p3M/Ws/jsEAdzvCB04fMZv6FslVja5Z0Ea8jwFln+XqneazppfdotlFG4pOBmjqqkO2GuZvYHyaBjNS7r8NDO5+3pE57myLFDI/5jZND2Srnw8ciaKezSSeu5ILNEvd8AgarV0ohQGQmAwKOIdFqkRbp4EZP7Dgdq7y8T4oyCZFELUOMwvHB/poV3uQ8v1WjCMw8vaTg6KU3tX1dL52vbXCXqnfQ/qoidFaKcLj9MHilS+8vxk4yaR4vKFwYEptXDKwceonNwkh7Xt8Si2/VyYUe0F1lUkz9grnmpLIR+dsfFOSsgsZFzafJn9wj5KPBlMky+LSpGbjAPg+jcuPx+4QANaGYNl+/dptPWl7ag2v0Q2t4+M2T9JZiAXZA4fw4uCAMjwQtYiiw8FZAhUz21iod1QVZkg0dBg4Rcc5EMfKUDUBCORt2xWjWXT42QJGxFC1VP0pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGhFYnRaOXRwc29SM1F0QXp1NkUzU3d2alQzZE1PTlBFNlgxNXlOYkhPcVA3?=
 =?utf-8?B?ODhBQk91eXBxSXU4NkNMeGt5Z0NlYjBGT01BVG9yVVZxTFdtN0V6Zml0T0Nr?=
 =?utf-8?B?Q2kzbjMvTFhiMmhHZVVVNjdLeUJhcnBucXAvOHdiRXpScXdIYTk2bE9ETHdw?=
 =?utf-8?B?bDlsMUJkZDNxUWk0TnlFRjlvNzNSZVM0SlEvL1BMOUpBdGU0UG5Mdmowcnlv?=
 =?utf-8?B?MkxnOHRrbzdLWWN1Zkw3ZDBuRlJrR3BGQ1p3NDJsdDZQTnVNeGdYdDJmT3Np?=
 =?utf-8?B?UGt6Z0p6MjJyd2R4Q3NEY2hFbnk5T2ZjU3NKMXVpSUVaUnZwVkFtL3hBRWRW?=
 =?utf-8?B?TkNYeFF5ZU1lTHZyU2p5SkdDNkpkRUNsYUgzaDFPM08rZHUzOEx5Qmh2UVIz?=
 =?utf-8?B?K09ITnRIMlQvcXA2NUZEa2tzc2k1VWlVdWVWZHdna08zOU9zc1NCakFlb1kr?=
 =?utf-8?B?TzYxS2F0TFRTemxCKzNUWitzNTBJeWJCSTdUSDZLUVJWRWdTQkhSQlpvZGhR?=
 =?utf-8?B?MjlEa2wrNGZ4SlFNUUlPcForMUtFcmVHOTlFeDJ4bnNNTUtJa25IVFFPNnRR?=
 =?utf-8?B?R3RsZXNkbHZRMUQ5VkdGWk5ENTA4ajhOWDRGT3k4enRpeTd3bFVQOXR3MUt0?=
 =?utf-8?B?dFZiUjNYcXdkVTlpTnRFM3Y0QlV0NEZIalgyc29KR3p5Q0pWdm5COUtlV3FH?=
 =?utf-8?B?alU2TWxkeWd3OUlWVjBBRUQzYmhWbSsreWVTQWw2L0dQcThBVFI3UGlPUWc2?=
 =?utf-8?B?cFZFK3FXUkkyeTBRRFBZQ3p0NkJSUlcrNWhDTjBaN1gybUNOcDJQR2d6bUxT?=
 =?utf-8?B?ZFNMbHZ5MHFsN1ZCbjBFeldDQWY2eE9aeDRRYUFtU3JHYVp0dVVHeWhZZk5N?=
 =?utf-8?B?dU1hZXlGaDRlaTNIVzE1bEN5Y0FQWSt4ZXN5TG81M1J3NEprSkJDMmRJS2da?=
 =?utf-8?B?VGN6U2pDUk43a29ZZ3lWYVVKS0N3MndIN3pCUHZqb2diWENVZWZJMVl1eUo2?=
 =?utf-8?B?QmhJVk1udlMxS09jMDVrWkhiSDhYUmpMWmduNm9jbHpXTnRUdXdnZ3orV1I5?=
 =?utf-8?B?aFRlRGhCbmN5dG04NE84RnhhbGVYT0EyZDJMbWlxMDZ5U2VNVDRvY1JnSjhV?=
 =?utf-8?B?c09kbS9PdzA3K3pRZm1SVGJNQitpVFBqL1VjSzBVenFKdXhJblJ5SHdITGUx?=
 =?utf-8?B?azBNVlIrQW1RMTV5MUFBZzNYUVdTajFweVNodG1zbHRpSCtKY1ZrbUkvZFpX?=
 =?utf-8?B?dEgyTHFpOCt4WGZwWExMSjNzQ0ZKYVprSE1ra3c4VkdpVnZJRmZqVHBPSVhF?=
 =?utf-8?B?WGFOOXZWa2lSMDFwQmFBYWthblZpbXI0M3hlVjVxUjRnNUFBWVc1RHBaZ3NC?=
 =?utf-8?B?K0RqM25NdC93SGhseTJvUVFGM3hPWFF4aHlHVlJtWE9wUmRyNkZFcy9lZURN?=
 =?utf-8?B?STZqM1ZWb1hZM0RTOGV1RElKNHlGRk9jU2FLdU1NWTJzWEJBZTZxc0R2aUlF?=
 =?utf-8?B?bzI2RzZjUHlPR0lyVUFDWjYzQWxicXlRZFA3bnZ2dDIzVVBjTVBtRnA3bjN1?=
 =?utf-8?B?d3ZyVFR1bEJJZzluWngvSlNZRzZqMUVKWWJIV2RQNVFqUnlreTdWQzVxZDg5?=
 =?utf-8?B?MTJIOU8xUjQ2QkFoZGZ2eDEycXRZcG9TVkc1NGllRjE0ejZlNDJwNmhTSkZ4?=
 =?utf-8?B?aUd0TEVid1VLaGNrYUxSSytycTFoV29qK3pGQWQ4b3N6eW0weERKQkRibHIz?=
 =?utf-8?B?QTdVSVpMZGZlNGtGcC8ySXhsUEJXTWFBMmc4RkZvZ01LZXpFWHdiOWxTRWRi?=
 =?utf-8?B?KzhCTGdtVjVQdW1jYjZMQXNRay9kenFEUkh6YzN6cVVmcVZBZ3U4MndSdHlE?=
 =?utf-8?B?OGZZVWx0bGhCQ0ZFWisrWXh3NmhjR1RVY2VUVzUyd0FjQk1JRFFUSTVwSWFX?=
 =?utf-8?B?NWVjcFRSZVVFdnFXa1ZUY1Q1WkdlM0taejV4bnZJNTluVlp6R2FrdW1JRm9Q?=
 =?utf-8?B?TEVGb3hlK045d2xOUTRHUjBYUEhRN0cydkFqTlIveEVtZDVaN2YrZTVFTGhU?=
 =?utf-8?B?WnY2aWZ3UGQ5dHFJVWFDaUE3UHYrSHVVZ3ZyZ1VabC8rZk1ENGp6UUJKakRD?=
 =?utf-8?B?RVg5U3lpK005c3NXRzA3ODZLbjdMSVpDenE5VWZ0bW4zOVBSUTFrcWdwNzVK?=
 =?utf-8?B?VzlaeStuaTNSREQ0YzIxRm1GMUdLRHg1dUJzY3pFaFMwYWwvTExiUzR1Y2dT?=
 =?utf-8?B?SEJ0RVhsOGtFSGlIaGhpb3ZGblhtcXV2VC90cGo5OWtJNUlFc3hGOW0yWGwx?=
 =?utf-8?B?QkZYVS8vakx4c1ExZ1BZWFhNRnRsSitTV0VTSkVLZlkwRjhDWXMzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b511b0-13f3-442b-ba0c-08de9bd330fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:14:09.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljlCEUE3vgNqGfZ2M/75goHJ+A6HITO5A3A08gSe8WFqUfEnOwiCdKoxR2tLZlMZd/BBYB/viHdKj88n8og3Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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
> This is unused, so we can remove it.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


> ---
>  drivers/gpu/nova-core/vbios.rs | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index d8633e61178b..d63af95eb642 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>                  Ok(BiosImageType::FwSec) => {
>                      let fwsec = FwSecBiosBuilder {
>                          base: image,
> -                        falcon_data_offset: None,
>                          pmu_lookup_table: None,
>                          falcon_ucode_offset: None,
>                      };
> @@ -631,8 +630,6 @@ struct FwSecBiosBuilder {
>      /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
>      /// [`FwSecBiosImage`].
>      ///
> -    /// The offset of the Falcon data from the start of Fwsec image.
> -    falcon_data_offset: Option<usize>,
>      /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
>      pmu_lookup_table: Option<PmuLookupTable>,
>      /// The offset of the Falcon ucode.
> @@ -934,8 +931,6 @@ fn setup_falcon_data(
>              offset -= first_fwsec.base.data.len();
>          }
>  
> -        self.falcon_data_offset = Some(offset);
> -
>          if pmu_in_first_fwsec {
>              self.pmu_lookup_table = Some(PmuLookupTable::new(
>                  &self.base.dev,
> 

