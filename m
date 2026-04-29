Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB54CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198FF89EBB;
	Wed, 29 Apr 2026 13:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ptm0eQG0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC76810F012
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQLsWAy+q2AtUfOmsAM5dMf13+QH/Ml6AG4CLtbZ60ia+bzPrFZQJztf+0wOXgjTiFB4A7nzFR3IZO1q8+BjnD115XhbSoiFgMoe6JPwtj/do6WcABoonVkGUkDpn30jZRHj5STdD6b5Zq9J3zBZiYBtXSWSFevOAvYLSfZ3rJamVlUcBBEX9tHAZtEGcdC+ys9ZH8T8z8e0l899Y7LH3BxyfZdfO/rPsAJWAwU/NYEz2HBHoU9yIwOZdxay+xq75i37i5Ry83rB31yKCyS67dgAoTPHCLW7JcUb4LsPJVrtgxiVPWIFceCtKaYNj4Q3EofWYbLokKLh+eHgsObr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLPBdWSiBz9pSIZYr3ZWkyL6llm5HptqyCQ4YminRBs=;
 b=sftS50fHi+NuoPFwvZk7NjW3EtDMhLpNpghsTxunH+4IkBdEtuznCjYKXDmCTrc1JTBZaJv9YhZHtoJCGgtIs/xzMy8rOWas046V1F2lTCWDoJC7ZeOw/mQ0nlZtbb0BiIMKP9W2nrfsAXxrDRXt0eqTKQ2mJ4ZyZL6AR/MkB7vrT7dRkHANnmqXJ6QvUXbQpa0sPDZX5J9o7LN3ajhenSG/BTIQgN6ZjxcXjGsG06GwHrl7WXvheYCaCyJtrE9h4XRj+f+2Vh6ySzFvNj+DCDDD+rOSc5LxeBLMDGWmV5f3tWn5y9zRfNY2tg6I58VIa+Q2dXgjLp/vqEtfUXia6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLPBdWSiBz9pSIZYr3ZWkyL6llm5HptqyCQ4YminRBs=;
 b=Ptm0eQG0yJB2q8dGmCUQ74SGWLJ5N9RyMpa0oYVxrP8myk44uPOtu33uwhh5Uoeb05PGhKSA333ghat3I6/ejbNJJaq0X8cOVJweNGiNWh/5lj8YwBe9gbBRfYnCWKQu9NGM3J/AEpb8KTEba2V12yr6WVXo5kkRfA9A6W6r3+eau0Aa4gacohQkVshUnmsR8FzNDHHncMUVRrJYRvmZGrdVjtEXUmxPlPYZ0ro4aFwzQaJnHfsCRTRVHp3uWRzJPpRSDYcbzi/MZKzqrTXCFJxE4NisXS3TX6POk+bZ5tFv8m3fIsXNEp+sJOYxJLgjCMDSxz9EAm6Cf32w47j1+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 13:35:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:35:33 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 22:35:28 +0900
Message-Id: <DI5OFKEERXGP.1EFM9XNWQQ1YA@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] gpu: nova-core: vbios: limit `BitToken` entry
 reads
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-2-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-2-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: f82bd22f-d465-4e69-9cc7-08dea5f42fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: WwqM2L6Net04KaBqerd/kW7Zgf/mTcCCzfg3Oe4cmG8ujasKxyV9ii5zyOT9QeSGSy6H2cJZHitC7d3+roUmynMeRd3SQRfab3bOKMy6eJHsBpVjRRAMMc35jiuTharCY/8gn/fsw3b/rLWD2bAipFrXarwncKWgIe+lgM1SwrZDPUtREZb7fh8jtYV/gNHT9Mb6pAWIl1+iD/v3KaL1gRfHVYqJVP4XCNC8kA2jGOHx1WUAHbP801GmpxocXqHBzvkVAczBRaE3NK8uiR7tplHVGm7R0Bjvu9fbg4SLmhO35EFPJ5D+AxasY76EJRS/OSW93FrnIabu/6TcmZNm+2l+KknA45v19v3FtpIqBhfwXJUaD+H2bRbudFczLBtTZBwTwyi3wWQIv824qcC6gt/drosJNrcVrB0txtp13sUC9KJcfAraUT6nFcFUYmkZlsrsNQj71HNTuCw2bZTQVVspXcQOeyqvO9moyKzJOk2Kx4DC6aPhpE2/zLmyWox2V2gsPt2Nn76fHrT1BqSe8esEDNuRG6i4YXgTwK4d1uJBsFazmjejNHsiDgElY+Y+h4a/O2OM2N2AWjlxp3pbFbYn7LOfunRMi0K+w+AC7uMH+m+m5wqrpgX52SF2Z4tNF7jRy/QDeuB9oWsAvhBaKaamhwY7AOV+bldtuKbhyXp4U1Tc3JXzJUH4QfoQs6GPU55CohOE3GyzBcZVg9c3zW2s6/8nUcb4X+tmjMsopZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elF1M1RLQ0VpUnVtNnd2QXJFWHhYaENFWFpicXdoVVNyb2dJZkRQWDR5WkYx?=
 =?utf-8?B?T0liclo3TWM4MDJSb1pzbnk1UFR1TDU5b0hNQkd5dldzc01Pd3ZTeUROSFlm?=
 =?utf-8?B?V3A4WTEvRlI0NE5PeVJndXpPYWR3UDl6eVhGa1VIdTR3d0VmODNEbGNDVWtq?=
 =?utf-8?B?S1FFQk04ZFJEVVpqNkJmRkRiZjlaU2VqSnVuYmFqZlpETDYyazdHQ041eWxl?=
 =?utf-8?B?K3VLbHZ2ZEZUa3JjYzBXU1pGZy9xUkMyNmE4cHdPVjhEQkx5UFAxYllRSVZp?=
 =?utf-8?B?bWZEZW9tNlJHOUcrc3VMWFFKNTh6R1ByLzhsKzV6RVZaa3BuK28rUWNKUXVU?=
 =?utf-8?B?eEpaS2NVcGFwM0NwNVBXTHZzNEdzb01DekpVdWJUaGk3UHZqSStFNUg1aXdl?=
 =?utf-8?B?b0VxVnYxaElPR0RWczNlSE54VnFnWTFzbGFLN3VsSVRFVXlRdWJ0V3JGYWZB?=
 =?utf-8?B?UVZjeDJ5dEs4VWdJeUV0Mkw1ckpvcnFqZnZIbGZLZlRnTVFIZXVtbis1KzV5?=
 =?utf-8?B?Z3dHN2pmQVkwc25PUjdzQlg5ZlVlM2NUYUdjRkxtRGJIeUZqcXVWU2Q2dHk5?=
 =?utf-8?B?RnY1QTRRYVBCZUk3ZGpyYk40Z1o3VDREN2hyOUF1NDJweVJtT0ZmdVhPdE9u?=
 =?utf-8?B?OVZJejFYcksvK3o3ZGZYT1c5dTdNd2wyQy9xOWhMR01NODhtYTJVbElWZngw?=
 =?utf-8?B?ckdmd0EreXVIelNEZlZyNEd5ZEJ4RFRkZk5Sd1RHcXhJNDNQQVk4WlN3b0tw?=
 =?utf-8?B?dFQ5cGxNVWhRNmI3RjI2SlpWK25IWTBWaG9HYTVkTVh4d05xSXZOQnNINi9k?=
 =?utf-8?B?ek5CVkk2V2xMMUNRUzFSVmQ2MVRxbFhnV1piVmVmTTl4cG5sblBJeVZPQVBL?=
 =?utf-8?B?UW9OdzEvTmtHRDE4TEVzV3ROaUtYbUpaOVgwT2swYlRjcmdRTm1ickVmU1I0?=
 =?utf-8?B?WU5EZHlrWmE4VGRIMjlJSmppVGFyUCsyZHVxd1hPVFN4dzRhUFVPdzVRd3lx?=
 =?utf-8?B?QVR4ZU9US2doVFQ3RHJwalRLbFRvVnE5Mlo1WE83Uys4aHpQM0ljUlJEbWF6?=
 =?utf-8?B?ZkQvY3lRa092SHdxYzhFVFd3VUIzeU15SkNjT2dqT1ZSaHNRVEZITkR4UGtU?=
 =?utf-8?B?L3ZjZHovRDhmdjFJaFBIQlF3a1ZRRnBRcUx4aGdBY3UybkJJVlZpUXZPbFY3?=
 =?utf-8?B?TjJTVnRiQ2E3WSt2cVIySjJvam5teDArdVhTSitZZ2lVeFF6QzdTaStQaHgv?=
 =?utf-8?B?SDlRSXY5bmEwOTdJUzhuYW1EK1ZibDc4YmZSeWg5M00yRk1XaFlzRFUwOW9T?=
 =?utf-8?B?eTJ3UXhoZ3hGMDJhOHRVZU8xMzNnWFM1Ky9KL1h6aEdob2tYS0dkSU54Ulhw?=
 =?utf-8?B?NnJwYWllNDhsSXNjV1lnV2w1Wmk4VkxzcDVLNTE1TnlrL0o5d3J3bUlXNXZH?=
 =?utf-8?B?T0RkMTlFWUVwNWJZN3ZFVkZrbUtaaXNBUHVoVGRoN2dDVERNYXN4R2VwUmwv?=
 =?utf-8?B?bGY0ZmpuNXh1SlV6N3REaGxsUUZScDhtZktiMXFveGtVbFJIcW0vMy94Mm9K?=
 =?utf-8?B?VXl4VUxZTXhzZHQrY1p1MmxxL0dUdis1SFFjRXZaNWpOa0d6NzE4Q1l4cWI3?=
 =?utf-8?B?dlNjdXdSd3FFcExXZ3c1SmRNSnJDUFkvMkxiZmNFM2QzODR2T21PdlF1Sk9Y?=
 =?utf-8?B?amhFeDAyb21NRUY1VnN4M1dKMjc1bGludE5zZlZlT2hPSkRPWmlONEMvYU5r?=
 =?utf-8?B?dTZQMFBQRzZNSkFaSzVRMmxidGo0eWV4Zy9GYlVSYWNRd2FJa1piYVczcm5F?=
 =?utf-8?B?V1ZqakRKSDlCbStqZDFhS1NKZG5WeDVLV3J5MmUvU0ozZko5SVFIMXFRb1NJ?=
 =?utf-8?B?N2g1VkRmdWIwMVpscGhsNDVvZ1dqc25mNUM1bU05V1pOSXR6VDAwd0U3QTBr?=
 =?utf-8?B?dW5RRGdCNCtBczlRd1VWN28zOTQwdTVudkhGVE5oRW4zRVVlK2tSSUtxTk9R?=
 =?utf-8?B?aXkxZnhUMXZTb2JldVljWGhSOW51OWVSTW5DRk9tOXBtZnQ3cVU0Z3M3eHh6?=
 =?utf-8?B?SnQ1MGxIYTRRRGx5cmppc2tXbEtaSkU0ZjBQZlVjdnluRzJhSmpEU1pUY05R?=
 =?utf-8?B?eHpEN1ZlTlRBdEZpMDZGbWNnNzBwSjBmaW9ZajVmZFFLYWRONXl0MU5HUTQz?=
 =?utf-8?B?amg5NWFVY05MekFNWXFZcWl3SDd5bWpVc2doWllnaUJWUmNNa2lDQTRwZjdv?=
 =?utf-8?B?dHIyTHpwT25mUXBGQ0p2aVc0T0xCZ1pBWFNPRnZnNitnQzNEV0h2eDQrd0JP?=
 =?utf-8?B?T3M4T3pCcm9BQjFXWDBkRVVVSFNuUDFUcm96dXR6NFl4eGJaTURNTERCbk1T?=
 =?utf-8?Q?KwJ1KNiryCiyPfwYrJpinNKOW8xGd2Z9DZZtBGGgUVFPd?=
X-MS-Exchange-AntiSpam-MessageData-1: 0AXxzMUdG6egPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82bd22f-d465-4e69-9cc7-08dea5f42fd4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:35:32.9341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6Zr59zfXYOc6VW+Iu8U43X24X6uj/YZbN7QVRlzqlFRVQKAUHSD2eru9/ldwIg36/8o7Lz6ejNEoZj2FeaNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
> If `header.token_size` is smaller than `BitToken`, then we currently can
> read past the end of `image.base.data`. Check that the token size is at
> least as big as `BitToken`.
>
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU t=
able in FWSEC")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 6de7e58e0da0..de856000de23 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -423,31 +423,31 @@ impl BitToken {
>      /// Find a BIT token entry by BIT ID in a PciAtBiosImage
>      fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>          let header =3D &image.bit_header;
> +        let entry_size =3D usize::from(header.token_size);
> +
> +        if entry_size < size_of::<BitToken>() {
> +            return Err(EINVAL);
> +        }

You can get rid of this check if you convert the code as suggested
below.

> =20
>          // Offset to the first token entry
>          let tokens_start =3D image.bit_offset + usize::from(header.heade=
r_size);
> =20
>          for i in 0..usize::from(header.token_entries) {
> -            let entry_offset =3D tokens_start + (i * usize::from(header.=
token_size));
> -
> -            // Make sure we don't go out of bounds
> -            if entry_offset + usize::from(header.token_size) > image.bas=
e.data.len() {
> -                return Err(EINVAL);
> -            }
> +            let entry_offset =3D tokens_start + (i * entry_size);

Should we use checked arithmetic here?

> +            let entry =3D image
> +                .base
> +                .data
> +                .get(entry_offset..)
> +                .and_then(|data| data.get(..entry_size))
> +                .ok_or(EINVAL)?;
> =20
>              // Check if this token has the requested ID
> -            if image.base.data[entry_offset] =3D=3D token_id {
> +            if entry[0] =3D=3D token_id {
>                  return Ok(BitToken {
> -                    id: image.base.data[entry_offset],
> -                    data_version: image.base.data[entry_offset + 1],
> -                    data_size: u16::from_le_bytes([
> -                        image.base.data[entry_offset + 2],
> -                        image.base.data[entry_offset + 3],
> -                    ]),
> -                    data_offset: u16::from_le_bytes([
> -                        image.base.data[entry_offset + 4],
> -                        image.base.data[entry_offset + 5],
> -                    ]),
> +                    id: entry[0],
> +                    data_version: entry[1],
> +                    data_size: u16::from_le_bytes([entry[2], entry[3]]),
> +                    data_offset: u16::from_le_bytes([entry[4], entry[5]]=
),

A common pattern in this file (with several such sites still to fix), is
that since Nova only supports little-endian we can leverage `FromBytes`
in order to avoid all these `from_le_bytes` call. Here this would look
as follows:

    for i in 0..usize::from(header.token_entries) {
        let entry_offset =3D i
            .checked_mul(entry_size)
            .and_then(|off| tokens_start.checked_add(off))
            .ok_or(EINVAL)?;

        let entry =3D image
            .base
            .data
            .get(entry_offset..entry_offset + entry_size)
            .and_then(|data| data.get(..entry_size))
            .ok_or(EINVAL)?;

        let (token, _) =3D BitToken::from_bytes_copy_prefix(entry).ok_or(EI=
NVAL)?;

        if token.id =3D=3D token_id {
            return Ok(token);
        }
    }

which has several benefits:

- No error-prone `entry[index]` accesses,
- The size check on `entry_size` is done for free by
  `from_bytes_copy_prefix`, and the slice bounds cannot be wrong,
- Shorter, more readable code overall.

Unfortunately we cannot just use `from_bytes_prefix` because we don't
have any alignment guarantee, but this is still an improvement IMHO.

If you go that way and derive `FromBytes` on `BitToken`, don't forget to
also make it `#[repr(C)]`. :)
