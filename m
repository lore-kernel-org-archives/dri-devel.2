Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A71CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DBF10F722;
	Sat, 23 May 2026 02:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMwSmwC3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13AD10F722
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsBb79LF4RhboOlioWx3ZiueHqy9SIVcbK/Tu/NUY8W9WsjG2Nk5RGy14k+it0QtA+9psUf+zl9fmNs9BXSS87AnejzjXTLhIoVGlN1sw94SfSov2doMxNcOSz6vB23Kv5ApGFTjfOFE11zlKM1wLZ59Gxk6L+Bh74sZhtCf3AsdCnWqjxn8A6+rj/T7vOu97hHOfQlZeSwY87xnOvOSVh4peClo4JVH4gfzcH0J9PIr6et6eTnaBLD8ov5xxX34NCGNFP7mUsqVmqxev0Cxc6peqOZJhGg/gIVnlz1pZNihgvow9zym6ES93boTe/8b54ZfJgpl2QuyljWRjpPhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpQfBfqyeORqpSVYiFxTg6G/RJLc/xCAnLbjM0Gutyc=;
 b=Bd/6yP0RA7kk+d7jMdLt7ZvrML+ihGsMY8AY5DlbWvx4H8Z7dcAuge0SBEEKcltNH8ghyOuJ+AFhq8G5Tej3GhQD4gTahOP5/MrG2UhMZx4Qf2EQWUjf5kFXukFM/M3hRMlx2U+r6uH7+JBgsvFPZ2n5ZWUNm2Ob9hBMUa/4cxHWjnGC6/Hm+if1lTEqsBNBklz0/1PBMDIg/kzxnWkcHcOWRu0E6ARVy7nxVUSvZNQ/ytCZ6HLQInJQs3Icmjs3dN9K4iVpl1uX+8TCL4Ix6AyLN9A8v7ZMmQJfXZP36RHbsBIvi9o6fHyixGKZrFMxpbqJExOcQ8AEzKq/BqkWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpQfBfqyeORqpSVYiFxTg6G/RJLc/xCAnLbjM0Gutyc=;
 b=PMwSmwC3QPKlUkt2kBt9mMjaxUUAsEYgkI7skOryxMYOZe2Osrt80HuHTiXfLwEwBU7mn0H17/cd4xxZCj0Kq0aIXd965JDcbOHWw59xXkSpKwTdrY2IXVjVsHzMKidtQNZoA+Kr6DBsyAjs5pk/xnkMMThwMcstVfP3o8WeKujhYUmDnWlgLvE6IMgzIfL1xHo28PWgPrUCFNOXXqZC4j23KOvHEdIkIZ/lyNRcZ/Mp7v4XUeFEkCKBIoA8VdmJP60PztBdkmmNiXnEGKAbWUP9nTSfqNJymi9tzos0q5VwGWtBvVs5apJEtyx1tSLpmmuKFwiUWaPjFMxZH4LCMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 02:56:59 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:56:59 +0000
Message-ID: <5fd1458b-db2a-4cf1-b6fb-514e68352146@nvidia.com>
Date: Fri, 22 May 2026 19:56:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/20] gpu: nova-core: vbios: store PMU lookup entries
 in a KVVec
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-13-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-13-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4db796-08c7-4ef1-c0cb-08deb876f573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: e5gx7wiqL0waPYGjiNowyx5FWoewY4DKnkYyfQr0Ov0dARGbXh02wY1j9TWYwh1CPlxL17TQWerg/+VSxNLvx4p7YVTCEiFL9TfwzEiIdDO5sLdqBMRp/d/PWeRQq048P6hkHEa2fH3Wv57S72NBVi1fBrfXOhmvxj6YnUaSbh5rSmAskIypzwyyMq7+IRivnRor0+ni4AcipLDBqFLcQtBWTFLMiFURWczvmFpm2PlpXRuGps75EWbDSdQRT2B91EsWXjXjYnxcmZyCo20cF5RamwEPRZG8+I4SG39WPadXeyI2zUdcedFXgGkBLmPg8nFqBo+eLSylj/JguYQPVx29Wn52S0PFYt7pBjq7clZOVM8gu1qYw9NpcGbNmnfEl28DhCihMEhAa5A1hZmM8d0RGA2WD15wwtG6sgoeiw7il9oJvF1YUsgINRaSl+l8vmIcZHkb9v/ggZa+Ynh0zIP1P27jYHVBsZJnHBJlv57mv8lBGXiQ3fyey+fMzaUXMtjCK44sSG/37zMGwMOY5KwQtTVbsS0KabgQ6udzgt2EzSFGF7YBOr9Iy5qNrJGJ8PD4KOzPfeo3w8++cfUcdX7aa+3kjtlO+qcGi5TLYqV+m2K55WzDM93jvs1XxFd9NYf21J/gsz1zOUZvUEEjHnlVCFuGGYyhYu9TnnfZPAV9pGSDS/mBhmkkOVHmnIM4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRnQnFpODUxMnIybjFrVGdWWGkyRkd5d3lJb1laVHV0dURsWmx0N3U1clJj?=
 =?utf-8?B?THJVQnR5UzJBWlgyMVBBN1h2UDZlc2JqWDFUNUFxeTlkd1JXSlh5eDVZSXow?=
 =?utf-8?B?SnFid3hUem9IaGk1ZmlMREVNWit5aUpycG4xbXBHU2NEaXEzczRxN2x2TlBP?=
 =?utf-8?B?SVJNU3dzeFdVM0c1TzYwRXhZSG42VWVzb3IrK3NlVlNEL09qUWNpVUc3UTZt?=
 =?utf-8?B?bVdCcGJiL0pRZm9DNm1jNWtoRXJZRE9EUHUzZlVaaUs2SDRjV2ZkSmpvQ0Q4?=
 =?utf-8?B?Y1VUcTUxbXVjVytRdndPQXRxYWxsY1lhOHUvY2VOWXZwSU92NEl2Z0dXbS9j?=
 =?utf-8?B?akNDRVRFak5FYjluU2RLcnRBbGtyejhJSlR0bmxsM2RDN1JpWDBkbU5LRjBG?=
 =?utf-8?B?YUtvQkF2NG8xSzhHelRWRHFZajBaMmUyV3FEQzcrZjJmYVRUQ3FaUTIwOURY?=
 =?utf-8?B?WXJJN29vTkNMemJSRzB3R0NkTnJuYmhBZHhOSWNJcmIzMUh6eml0L1czTmpt?=
 =?utf-8?B?MENPMWloMnJIN015S2VSbHJNdnhXNWhzQm1xbGRIWGxFaHlOUkFkQ0pzbzlY?=
 =?utf-8?B?YVRvK3l3OFpGbGlwa1BRRVQ5cHc5SXloOFh1aExpbUpPK2xiSTQxRytBVzJF?=
 =?utf-8?B?NTRJVC93TFNVVEpMRVU0WndqKzQ3WWtlMkVkcVhyRWRCM21Xak02ZFlrZEwx?=
 =?utf-8?B?Q1Y5NmtIWmZQUi8ycXBrcEZ6ekY1NTRibFhaQUZHbUdjYytoM0o2NDJ5dGJ6?=
 =?utf-8?B?ajVzbW50QU9HVGM3NURvREhLQlRXVEFKeU0yamRtNzdyL0U3by9YRXlwRm9v?=
 =?utf-8?B?TTlMQVY2ZWU2bDE2RkVOR0VJR2pJdW1lRDNZWDFUWnB0Z0E2WWJteElQR24w?=
 =?utf-8?B?SXBocjdqZHRaUk0renJ4U0lQRGc4Rk4yLzRIVm5RUWkvWkdZSEx3SCt1UW1J?=
 =?utf-8?B?ajIzQWtYb1RqZVlBR05PZGJRbDJBWWJ6ZWRMOC9PSkZPWGhOKzB0dzdXdGZI?=
 =?utf-8?B?TGhPWkVJaUxMR2xqZHZTOFc5MWxVUVRzUytUcEVxdVpnUFZ1UklmNS9vWDdL?=
 =?utf-8?B?SFU5OTc0aDBIN04wcWhVZ0Qzc2FqMk0yY0w1bmdROGJDSStaRnNZK1JEK1dU?=
 =?utf-8?B?NGZHcE4wODJsdWh0dm9TRUVxeVByN2dTTCtYQ2tycUd0Y2FGV01LMk00NnJY?=
 =?utf-8?B?T05DZGFsTUpaZmxjOWRVT3VrQWFKN0pIYlB5VUtIT0YrMHhLZ3RJYi9lVHYx?=
 =?utf-8?B?TTg2QWNXcGZsLzNOK3BMSVBQYitvdks5aXQ3YUorZE1NZy9FVHRpTVVpc21Z?=
 =?utf-8?B?VnRmeitwbWFKckFPK0dhV1pWLzk5WkVCMm1RUzJtNS81VndkdEFSTzlCNTVj?=
 =?utf-8?B?dzRUVmZReHphbFRBNWNPbUZyN3lZdHRLNmJ4VzdqWDJRSmkzckFhQXhwdG9x?=
 =?utf-8?B?Z0FzTVBlWHpMYUF6OHNUTmtoTUtSNWNiSU5pZTJWU0pNcGNCVU5zdlZXWkQ4?=
 =?utf-8?B?SUhlR0txWUNsWUhMVzIxS1FYV2ExclV1TlQ5ZGN0bjd4V3Rmenp0OWtuTCtC?=
 =?utf-8?B?Y3lNcU53TkRLU05ucU5YNjV0aHFBdm5lU2l4dXZHMHhTRnlwdXV6ak5xenM0?=
 =?utf-8?B?ZW5DdlkyK2FqOU9JWVpqVWVjMWMvc2phTFYrL0ZzY28zaGVpSHZyY0xvTFhl?=
 =?utf-8?B?NVBrSmZRcjEwNW45anJYZ0hjRHM1UG41d3BEd3F4Ly92bENGS3hTNmR5T3lt?=
 =?utf-8?B?VnZiSHhKQzBHSyt0bXpIc09oNXJyelpYT0RMNXlRYTV2OExuUzBERFFqNEU5?=
 =?utf-8?B?VTFRN3JmRDlhT01aNm93K00yaTlldjZaRm5LalZoMUYrRXlFRkFCK2xMTFhn?=
 =?utf-8?B?UFZDL21tcU5ld1BkWnlwbjRseFArbVgvMG1oMG50MkJLNW1tTlRhc2dQWkUx?=
 =?utf-8?B?dEdNSW9QcERoUU5OeU5URGQ4dnlGdTR3WUFtektGbWZDd0poNVdydXhlZEhE?=
 =?utf-8?B?ZWV6aFBIRG9uQThZaHFRZElJellKWklRdzVQZTNBMFBTa1oyRmNDZFZ4cHFW?=
 =?utf-8?B?bW1VRHFzTXgxaUUzMlIvU1diK25HeGxvNFdmYUVQSjJGNXdmQkg4RW9FTHpl?=
 =?utf-8?B?VE9tbmpVWDBOemFvcXg2TjFKZGRjS0haS2xOMjA5U0d4VkplZVV5TjhUSlRB?=
 =?utf-8?B?TVRMMmhTYys3S0sxUGUrVGhvYitVcU1NaDVZUmxWeTlnd0Y0bm40QjJTN09G?=
 =?utf-8?B?TTlyV25aMngvSHZEL1NFMXlpbUhTclNrK1JkNXRFR2liQk9DZWIydEgrdDIr?=
 =?utf-8?B?M0phOXMwc1dGVVh2QlZGNXRGV1Y3cTVLYTZib3NzMjNTUUdGaXErQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4db796-08c7-4ef1-c0cb-08deb876f573
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:56:59.8140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgWcXUFMJWN3h7PWGLIc+3qyB6Gws4KMTW/om70q4DgUiODQRg4i9OZN4nLZNrrUxCDCdlyl1IAXD0oQzfbyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
> The current code copies the data into a KVec and parses it on demand. We
> can simplify the code by storing the parsed entries.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 56 ++++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)

This is a nice improvement.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard


> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 987eb1948314..1ffaf0ef56a7 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -917,8 +917,7 @@ unsafe impl FromBytes for PmuLookupTableHeader {}
>  /// The table of entries is pointed to by the falcon data pointer in the BIT table, and is used to
>  /// locate the Falcon Ucode.
>  struct PmuLookupTable {
> -    header: PmuLookupTableHeader,
> -    table_data: KVec<u8>,
> +    entries: KVVec<PmuLookupTableEntry>,
>  }
>  
>  impl PmuLookupTable {
> @@ -929,48 +928,29 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
>          let entry_len = usize::from(header.entry_len);
>          let entry_count = usize::from(header.entry_count);
>  
> -        let required_bytes = header_len + (entry_count * entry_len);
> +        let data = data
> +            .get(header_len..header_len + entry_count * entry_len)
> +            .ok_or(EINVAL)
> +            .inspect_err(|_| {
> +                dev_err!(dev, "PmuLookupTable data length less than required\n");
> +            })?;
>  
> -        if data.len() < required_bytes {
> -            dev_err!(dev, "PmuLookupTable data length less than required\n");
> -            return Err(EINVAL);
> +        let mut entries = KVVec::with_capacity(entry_count, GFP_KERNEL)?;
> +        for i in 0..entry_count {
> +            let (entry, _) = PmuLookupTableEntry::from_bytes_copy_prefix(&data[i * entry_len..])
> +                .ok_or(EINVAL)?;
> +            entries.push(entry, GFP_KERNEL)?;
>          }
>  
> -        // Create a copy of only the table data
> -        let table_data = {
> -            let mut ret = KVec::new();
> -            ret.extend_from_slice(&data[header_len..required_bytes], GFP_KERNEL)?;
> -            ret
> -        };
> -
> -        Ok(PmuLookupTable { header, table_data })
> -    }
> -
> -    fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
> -        if idx >= self.header.entry_count {
> -            return Err(EINVAL);
> -        }
> -
> -        let index = (usize::from(idx)) * usize::from(self.header.entry_len);
> -        let (entry, _) = self
> -            .table_data
> -            .get(index..)
> -            .and_then(PmuLookupTableEntry::from_bytes_copy_prefix)
> -            .ok_or(EINVAL)?;
> -
> -        Ok(entry)
> +        Ok(PmuLookupTable { entries })
>      }
>  
>      // find entry by type value
> -    fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
> -        for i in 0..self.header.entry_count {
> -            let entry = self.lookup_index(i)?;
> -            if entry.application_id == entry_type {
> -                return Ok(entry);
> -            }
> -        }
> -
> -        Err(EINVAL)
> +    fn find_entry_by_type(&self, entry_type: u8) -> Result<&PmuLookupTableEntry> {
> +        self.entries
> +            .iter()
> +            .find(|entry| entry.application_id == entry_type)
> +            .ok_or(EINVAL)
>      }
>  }
>  
> 

