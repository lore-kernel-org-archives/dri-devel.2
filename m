Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61860CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15C610F6DE;
	Sat, 23 May 2026 03:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="On52ooXp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56E910F6DE
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgHCPweKm2HiV2JYREByfA+menLEhnuxc3SB2GP2ceyjEgImVCydhUGODQAQ33+wXL+2e4tIQrJ3k69FmFHlPDXWchENa7oph+lAtcdlN0NoK2v9HuL3541L+jFhFxwhjRF/anYGMGmnUXnCM6YDfIo/gxkoXPVNFyExVSkxOJeWtLyF9X/WYKaGe+C1WlN+J7ygFqd0bAYWydv4v0NK+DKt9Nz8UpTihRNa2Zb3z54DDGDDrv0qjh9ibWn5CVwMfkh/ERjohm8JFPx7Uq8G7dVpO3ZMLVAPZg8ayc326A6DNsOLgj9hO2WbEiIuwu6bOlYFBmHdCmM1mqw3OMoMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW76qkM5ALsaBZFzSwACeZsZvKbKAtdnhxL8Krs/6pM=;
 b=cZKpor8oWhIF3c+e1Kt7FmC5PjK0dHzFk/EmrM9RVAZTj6yUTnXkTD8QKbmupOM5z44WMdGcZBVaQIN8L4XyNY5+0zgrcaCrXSrgrvqDiLKnmGZl/t19APW8v99+7uYHOF6MLQJieVtEudijPs1znznYkf5jXhCLzWwEVCD8Uhk1IEnNVvHcGCP4j0ujo+8xfRavbVWNkF8LH0IwDmNHg05fMGn3Xn+40HSXkEiLV1lJV1YWasB9ukQh5+JtFtSHCCkBNh9z5bJPfvnB9PEJIvozaqX7EVCg/DELlGPST05+NxDf0P0D/b2LrY7d0V3O11VFaHyyY6cFhlnRsJOHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW76qkM5ALsaBZFzSwACeZsZvKbKAtdnhxL8Krs/6pM=;
 b=On52ooXpuxf5JV3qS1ZMu3jRyg7C0j0FemEHGjvLPbKorT4XoV74brn9ohO2fUYPCE2JriuKvpg2UiAbFLwmmyeXTUFIpE9afui1/eG6vSf0BQdA/5gUQSBw9Cmw+lCN4SwOoorkzdBn7Y6LIejxcYoWKQYssiyn+ffkEtwV6FkaoFcrd585nPmrtc5XI2RRPS4m4nPEjhyKl7HnRI9b8gS4Ur1yMvcCqZZH/UwwE3R99inxjnHwut46n6vC4WpELr4CKRJOHeoyGmgkg1s096Dh6tHh9ix7HpF8G+uvBRsaKkpTi+QUKiRkDDgaMBpN1iELRwVyWROAKEP1JfXCDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 03:05:17 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:05:17 +0000
Message-ID: <646be273-e129-4e46-8252-fddf89c06bf4@nvidia.com>
Date: Fri, 22 May 2026 20:05:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/20] gpu: nova-core: vbios: use let-else in Vbios::new
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-16-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-16-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 201559d7-4d3b-49c2-5f13-08deb8781dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: LKB/7yiANI+zNOtw+8eCQf/X/cz0nAdQDZoEzVhacdTmxGLb0pEHlmKIL0Lnvdp+1WkfN9x/Yc+vcLlMuHT0CcWhYYp+JqnVkybWdgOJKCaL+Jwsj7HKCMPdUaJbTi7QFzNPFy/j3JzO0vuCwtcGpbp593OF2De5qJouR1fuiyL5s4E2jZk+Fu4vL0gutVnI2uax5oY/BgxQyanbHtt/jqeLR3GgPM/AMLGZpaoyFoKRnxyYr8Mjaw5o10HSRcOx3T+fPaR8bPQ4nQVKvwhdf1EMt0GngvrOzRmiHR05FoJIHWfxyiEksSBnOdX0SZ98PSFSMmgTUOzD0NvL75ShT9JvE0z7JBeFuGB0Z7u7JWOr7cnzak/7kY8Hwa4CqKeQ2bLUFLKSQShQ5237THkQEdHeNvc+YEn2b3Uq81gDAJ0EygE/0LZfUV+fhl0GqrbaNTtaMA7qGwTG1lJZfzN6/7VKJ6x+ySN2yqUEcQbHLDdoJGX/LvqXG+T0oHComCHhhYrYWbWlo2qAUUqtQKdqeObwRcU/LuR/BpgF9jKR0wiaEtyChlZoI03x1QeizdqU94BhLr5wzC/xeueEIN/6AlpXg2JfkuR7nmm8DR946I58F3Pync3a0BvUi9vOAltpBk32SCsu3NHqc2a7yLjE+umFrWJ37AbQY+X9WwVXHrp8eIwEFN82dkX7h/oBYtPI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVtdTMyMkhUWkYwZGhTWmdNYUtUb3NwaWxqTzBlYUREUFJJbDhMYUNZMmRG?=
 =?utf-8?B?cldISEFaYVU2YjQ0WERXMmw4SEY0NWMvNWRlMmMydGlubW9ZR3k3QWZmbkkr?=
 =?utf-8?B?MU9CSHB1TWJJMWRrMUtETXdGVnNGazlQazV4Zi85ZjFQVU15SXNWNXNLbzFw?=
 =?utf-8?B?WVh0VDNTMi9qQXJTZHFjb0VabkFWUkhjbTZPSTlMZmZsN2VPV0txSWZoUHh3?=
 =?utf-8?B?MDlHVGVKTjU3R2swZ09VeUNMRTRQUmYyNXVLVVZ6eGIraGxPRFMyT2dtS2Qr?=
 =?utf-8?B?V2p1OGlGelpTblJ0WE9yVjV1QkJkZ0FUSlpYSGJ2SGhaY2FOUGIvdjhQMCtx?=
 =?utf-8?B?Y2lTUjdhcVFSa3BaSkZLOHFiZ29wZ3QvS2tkVGN2NDRJczdPREpvcTVONDVu?=
 =?utf-8?B?QTZ5T3hySmdXcHVYWnVINCt5MEdEZ2xMU01jMzdEcU9jL2wvUklSWElkMEYw?=
 =?utf-8?B?c2E5TEpmYUhEMDJqWDlUSHNFajV4TnF3ZWcydjVnK1I5OHV5Y0NTRHJEVmFO?=
 =?utf-8?B?aFVaN0RwT1k3dzNlVjNZb1J6c0x1TXJiMmxnZlErMk8rcFBVcVhMNllqQzls?=
 =?utf-8?B?eHpqNy9BYjZ1T1R2Skp2ZlcyY2VGVktHVzhKNGV0YkZNbFdXMlRMaDhEOGlF?=
 =?utf-8?B?YWw5MU1NV2UxMzJYWGRIbzRHNzFOQk9XQkpGV3I3UkpjUjhqMEFOSWwyV2k2?=
 =?utf-8?B?MHNxQjI4QWJ6a00xKzVVdHpLVUJmeDNWejBvWlppT29KOTBic3ZBTEQ2dkgz?=
 =?utf-8?B?SUpvRTQ0SXhUR3ZSSTRSWUdCb3JlcC9tdWhrYkZKMENvUHAvUG51RVgzUk4x?=
 =?utf-8?B?TGgyY2g1ZENXK1JpZWFRNHo3S2ozamYzejRET0ZUcVNEUkVsNmtsRG81NDZF?=
 =?utf-8?B?dExZcERaNmFuZG1KY2cvV2VPS1phVHUwZzYxQnVodTJaeFJybXoyUmFKN3Ri?=
 =?utf-8?B?RU5hQmE2bm45MnRRTThyVUpSazkrTEFZcWxDaTBqN2lsa3ZwM3ZtSWJWSG1n?=
 =?utf-8?B?OTR4SXZWaWUzeWMyQnk3WjlyQjFJYzBjV3pubWllNUUrVHBtSFZDLzJwc2oz?=
 =?utf-8?B?QlFWWnhJQyt5aS9UTDRkSmo2TnA4UE91NCtROHhwY2ZseWxRbE9uRW9YYk5F?=
 =?utf-8?B?My9qWUE1cG9udEVPS0Vqa3lwV1BwZmVQQ3l2R0hxZ2xKMUFQam80Tm8vdHhO?=
 =?utf-8?B?Z21jRDMwR3B4dkN3VHpsdFlaSmttTVJsdzhsdUh5WmdmUzBjRU1MQ08vak12?=
 =?utf-8?B?UTV3ZmJRL2h3ZHBOeUlMRUo2alo4MTR1YjdZZVA2ZGR1SWovdWJ2YmhYcUdv?=
 =?utf-8?B?ZEpCWTVPa2VmbVE3bXlKbi83ZGxBT0l5aU45WUd2Z0w1bTB5TFhKajhWZEtw?=
 =?utf-8?B?ZTRlVkloWGIvM2VzMy9aQ1YyVlIyRUYxQVkrV1E3VThMcGtIbUpvM2dmby9o?=
 =?utf-8?B?R28yMHpDd2hiRFdJUG5KSGdsNTBDSVlSZUxGa2Q3UWkxVG5zUzl4VHAzcllH?=
 =?utf-8?B?Zk9PQ2lBeCswMjNyV1JZOVZITVZYRHo3c3gvYnpYbkYyMWJBYTFPTitQVDRp?=
 =?utf-8?B?NUJrcnRQMHlUelBQUEJjZEpLWWlqSUk3OHZtRUpVTUEwN2hQSCtoNzhtTkFC?=
 =?utf-8?B?N2hiWXJvV25BRzZ0MDRzc0wwYmExZFpKQzZOaHI0TitwSWt3SWJPMFAwb0lk?=
 =?utf-8?B?QTZ3amh5VlJaU3hSRHZxTGtvUXMwT3pMMDB5cHN4cGhOR3FtZER5OFI2WTV5?=
 =?utf-8?B?WEFSZW52M1ZQMU90M0lnazJodmFKSHNLYkNyck1pYWV4UmhhMXpjMnUvLzBF?=
 =?utf-8?B?QzE1VXh0dnRnT0gzWnovSHZxT2V2Yk40ZkxUT3RpWk5oNUhKbUdpeDFTZXpp?=
 =?utf-8?B?UUdPdGhlWStWVW9BVnVCR2FhSmdUYXFNOW5DRzdYK1EvenRKMDRvWGhrY0JQ?=
 =?utf-8?B?WHVmWEdBMXk1UkhkWm5BeFB2VVVIT0VNeDJuVlIrV3IrNWpqSXUwTmUrVnYr?=
 =?utf-8?B?eVFrT0FwcjBLVGJSSjhsSzZGa3YrQ2NlVmZyOE9YS0lUV1FnemxkcHpPdHNy?=
 =?utf-8?B?QWxTQVF4K1FqT3JnWlM1aVRVTldvbkM1VjlHa0RjREt6L2dwY1lDZ0MwRXRF?=
 =?utf-8?B?UE8wcUxLWGxSaXFNeWtMSEVKWmF3N1VZa1pyNXBYZWl3dE8rMkVSZVFDWnQ0?=
 =?utf-8?B?TlpMcmNEZkdSK3R6NmRFUGlRNk5pckdtN3lPM1NDY1NDTFREV1Bnd0E3TnlO?=
 =?utf-8?B?YWR4aEhralhlR1Qvcm5kN0kzcTBUQ09GRlUxVWhqZldaV1ZkQXRLcGtXNjFH?=
 =?utf-8?B?T3RCdUZQRnplSEk4cit6KzBTc21TOWNQSG8vR0JJQUpvM1ROcExtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201559d7-4d3b-49c2-5f13-08deb8781dd1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:05:17.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLMrxD3T26FvHaLErHJD0snJJ5OIyZtLeX3g4tUALl+3pIfx4b3IG2Y3f3mPdScOji3MHxzVSxOnQtz0bTqFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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
> Improve readability by moving the success path outside of a nested
> branch.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index ff21f85fdfb6..64d100b6699b 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -353,30 +353,30 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>          }
>  
>          // Using all the images, setup the falcon data pointer in Fwsec.
> -        if let (Some(second), Some(first), Some(pci_at)) =
> +        let (Some(second), Some(first), Some(pci_at)) =
>              (second_fwsec_image, first_fwsec_image, pci_at_image)
> -        {
> -            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
> -                .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
> -
> -            if cfg!(debug_assertions) {
> -                // Print the desc header for debugging
> -                let desc = fwsec_image.header()?;
> -                dev_dbg!(
> -                    fwsec_image.base.dev,
> -                    "PmuLookupTableEntry desc: {:#?}\n",
> -                    desc
> -                );
> -            }
> -
> -            Ok(Vbios { fwsec_image })
> -        } else {
> +        else {
>              dev_err!(
>                  dev,
>                  "Missing required images for falcon data setup, skipping\n"
>              );
> -            Err(EINVAL)
> +            return Err(EINVAL);
> +        };
> +
> +        let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
> +            .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
> +
> +        if cfg!(debug_assertions) {
> +            // Print the desc header for debugging
> +            let desc = fwsec_image.header()?;
> +            dev_dbg!(
> +                fwsec_image.base.dev,
> +                "PmuLookupTableEntry desc: {:#?}\n",
> +                desc
> +            );
>          }
> +
> +        Ok(Vbios { fwsec_image })
>      }
>  
>      pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {
> 

