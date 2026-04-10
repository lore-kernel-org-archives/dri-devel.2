Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8586F44873
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193FB10E249;
	Fri, 10 Apr 2026 14:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kLJ4kw79";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0601210E249
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phiFRlIHT4ZqWjRzb0H705/6OpEbkwxauy+2TVAbpM1oe3thGZwsNXIjVTmbIpUFE4/7vZ/1YLFyhTTXQDXs9vHlSASCIzVMYk4c0X0lJtvQC7pQoQIIyTWgFLrBksIKnWCMgOC8bPbWN1P0exPHej3BreNxQz5KyAN1DzVaYwGUfGFiwfUIV+iMzn5B4C9FOMaIe8b6yd1X3mzTudmHcDA1b0QjJ78N63uSxcLjYNjt35iRlJxjfuGBsbPQ+HrOgGf4AAf9IURt4b0arVJJRV/BOkCxCYlXSeiEGxeGJYXWroisHlsi0EX8bnCFx3HjW3CqDorHZjcLyqojUKWotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSMtyvv/7Y0NYzoaUsPvCT+s6EMkSXlY8x/AzGr+lMc=;
 b=W+5vw26ZQcVAjv0UtWgsbz4JH2rJ7+IWPoPPd2/tVZXAQgHgB35PTCbU7J91uF4qfkisOj2NsgTI45NYmz8upAs4idPW12oE0UGVJ3aGfa3pMzxwTvoD1h0MxxZbCts+VswJreBItnYSBVNwvL4A0/ZNvSkRhDZ4rdr0q6Fx4HGATaVGJ/+EmgiUZnLo3+3H8AlbWqYUIliOTOd8llR6+iHzR+QbrmsykdP1MKD4B8OrIo1PZGCmUm+D8mZAs9ge/GbtcTsjHrzaIUW5ixGwJZ3YqW7ndiJt1ofqzdWCMbr15NYBQpRooX2iXgp1p+S+qxltZ/j5PBhTjqBVCWavwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSMtyvv/7Y0NYzoaUsPvCT+s6EMkSXlY8x/AzGr+lMc=;
 b=kLJ4kw79vG9gk2eOC5QNCkIf8qSl0HuQ6FXOu4PhmK8mAvBupalP0y7gUuJ+7pRtz6ttcC/Q2k2f+oiey7Pz1NOwLPfJNlYW16yJIV6XoqfktXEG50vdtTcUYHGVxTWTUTBpj/+NAkq/9/uwH2CoWMJwBvjuzWMc8XvGVB6FdnrBVd5VqbxfVYGirw3/eiN2OtCSXkP4a8GAgBfzB1P/BiaQsM0FGCpJwhuyVjGcpVbR3MjFkPm4qk/sN55OqhzHXV7aYG+gHj6Kx9w1DnH+IdTtfFPv4cE+yAEZePdg2bmAD9JAeFgjF5YqOBalysOSUohcnkVR/7qfof39yBjq5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 14:30:18 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 14:30:18 +0000
Message-ID: <f840abb3-5a0e-43af-8b57-6b4db97255cf@nvidia.com>
Date: Fri, 10 Apr 2026 10:30:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] gpu: nova-core: vbios: limit `BitToken` entry reads
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-2-bc6f71d153d6@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-2-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc684db-c8e2-4055-d0c4-08de970db025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: oaNm08GFhQnTTXir3B/B4RXcLGVE35l8CjhmP86O+urcspwRekKTXlWtGKkct7dCJG4LT3G4Y/FKUzdhMyqq3xxbske7cgepU+DrP1jwEiYQYSeZL5ZdRvPTg6fCVDJp/cCu7rN3WEVG3X0MIlnlgqbHIIo4rtBOUDXEfzjCRcAhWP2VFhTPSm3Ym5oXa24XXaCzE5wXn8wKMAshBm34vQD7Pd68zIAyhkIw+2H96Q9L2sDkBLJMku51e2NJBoM5lTA53EWMQ//lYyLWm4ZQtM3x/Pv+mIoSk+dYyMRDuJWKjmpjOq0ef1m6g02G2tQjgNDB/SMCqYYzFPtpKKFqcEbz+37xDxPwFfwd0WZBSgvCwmBtJIfT1PHYl4N8bP21AUnmzfHU95Pji4OTXt/yCNCmYR4laW7Kzf9ND7rIQLgqPcQaVaFzGce4Z2Lw40+GS7lOvnoFwKt39CjZnlZZcqUABjrfqPBV4CUFvQpK044F818NLQyVSEdRFjozZHdVElCqFbm5+FyY35JKRlOdN4iknmzgvwbTELLBLPjL56+q93MEqTptxkCJAXfh3uMAjCyKrUmn29OCFSBfG5ws+i/eHlB2TJ4l2cqqaXvAegCY05R9fhzKBn2dNLoIkftsOUTPFOgJ1PknYi8c4FE5l+zuXcJS9wdSeyTLHqco7HHM2mWfCbuaA1g7+K7SSgpctLTS0uRVqqW8Xpb/ZNd5EkM4QstYmeOP1B8/du5OVNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGoxcWRXYkRwQ2VHRWYrNUFvWmt3NDIzL2JFbUp1NDFaOWR1a2NibnRqUWNF?=
 =?utf-8?B?UUdzRDRucFJaUEhHNXNRWFpvMGc3a2hPTWoxSkhkS1RCUW1kQ1RwUEVCWXNS?=
 =?utf-8?B?c2RuN1hQbHVTNWU1VnNIZVVtdFRJV1RSTllGa2JlYmk0TmhDaytSamxlV2wr?=
 =?utf-8?B?VFVVWU1YSDR5bDJJeU5BSEYyRm1GUXJyOHRrbVNXUVZkakdRdUpRL0I3WExj?=
 =?utf-8?B?aW9SdVBoYnc1S0FJSUV1T0ROV2pKc1ZHSVlFUXl3Y1BXWFZocDh0VDVoUUFN?=
 =?utf-8?B?ZHRqWWVQdW54dzZWb1lCdEhwelo3eHMwNXZOTWVvNmxLeG9qbHNyTHFsMHl3?=
 =?utf-8?B?dUM1bzR4UFdqZ21TSXlQanN0MGt3Q2RtVzVuQWQzSWkzSkM4cWdsS2lrejRD?=
 =?utf-8?B?SWtxWnRSanQ2ellXVm9OQ1Y4bzl5Y0RnL0x5WVU2anIrNjFDV0VxSDBScEs5?=
 =?utf-8?B?OEtoam5aNW5Wak4vTkVUWVlzeXhkcklRQnZnV0U4TnR0ZHkzVVc3YnF2czZj?=
 =?utf-8?B?UDRuOUxkWEJLTzQxdlY0cXlOT09nTlF2ZndOR2JmNEJXaDc2OFdjNFZrOVFC?=
 =?utf-8?B?ZzFQL0dYRERhZVJzSC83OC90U0pTZ3NrbUoxTW1Ecm84L1BQNHJGSnk1WC9V?=
 =?utf-8?B?QTBSa1ZjMnFEaXhkVWl6ZUxPT0JmVktCQU1pRnF4ZnhrYmViL1kvUkluLzNp?=
 =?utf-8?B?NXRvL1JyU2xmWEpMcWlCTGpZb1RabHdkUjZXbXZaclZkbHArZVVsVHFnNXBy?=
 =?utf-8?B?bVpwc1Y2UjFBTGxqa1d2NGhjTFJUOHRGQXhMcnpGYlMvdmVXQlhCdno5VjdJ?=
 =?utf-8?B?WWc1dlJRYmJTWGhvamwyN212K1pSRDJram52SGxlNkxldXhOTndYaFJKd0NI?=
 =?utf-8?B?MTVIRjVNZGlpSmMrUXhZYm03WEVhVjlSeGU2Z0dOWEFkMkdtTGtxSEp3TVBV?=
 =?utf-8?B?TWR3SFVQYnVONUdXeDQ0M0x6UUVOTk1tZEpmNVBnbCtLOGtUaXZxYnVQN2Rm?=
 =?utf-8?B?TGhndmI0UzJkRVQzZGN4d2FhQnEzZ2llZ3ZCdkc0V3NpRzd4UkZleHhURGg1?=
 =?utf-8?B?N2NaZ21RWVdFdTB0Z2pWaFkzWHdrejJPTm94VllhWVJnbHQxcEp3Z2REcFpW?=
 =?utf-8?B?eXd2T0hKcTZyVHd1d1J2Um5sdDgvZUFjN0dHUmt6eUM4OE5lSTVDYTRwdXQ1?=
 =?utf-8?B?QTZtYlVJK2FkRkJkckVFYXpiMk5ZRlUva05PMG5sUFg3NmdiUkk4cHN0cHlJ?=
 =?utf-8?B?T2kvekk3MlhUM0JuOFFvV2ZRV0taUzdZd1NCN3lJbjdrUUxoRUMvSVgzYXd3?=
 =?utf-8?B?ZmNNOHdjUnVUSDB6cnJ6aFVwZ1Irc2Z6cXZQV3BZTE1tWk1DWWcwandDZHRH?=
 =?utf-8?B?RXVUQVJFY2FtWEYxWDhrbUs0djlnZHJ0MVVXT2ZJWEdUdmFSYUlIcUEwK0cz?=
 =?utf-8?B?WUx4Ui9rNXUwS1kyclJMaGs0RUMwZzhhQnlLYU42aXYxUnhzSllOc1ArSVc1?=
 =?utf-8?B?QzI4SENDV3p5ZU1ZZFZITTVrOXFpZUVtRENwRnN0Z0QyR3pqODZKZk9ySld6?=
 =?utf-8?B?WnZCdHdJWGJwa3k0Y1NIRThGOTlaa1hZOHVlOHNSYTY5UmlPeVFCcWxQNy9O?=
 =?utf-8?B?YkpVRE1ueGNmem9rTXc5bFAzM3pTc25JL21tY2Fwa3B4OGdjSVh4MHpPZFJz?=
 =?utf-8?B?bjhjVVJkT0R2TXBEVzZyTkJBSWx2ZG5tMDVvZTBpWjJjbEQwbHZHYThqS0Ux?=
 =?utf-8?B?YWs1NWdUenpOVEhHYzRPRmRmdkJHWkoxWWVsMU05NHA4OWdVb1lFeFZ3ckRS?=
 =?utf-8?B?VE41S1hCUWxwLzkvRGJsZEM5NXJvR2Y1eFhOSlpZeTNLVDBNbUNBVk44cWxM?=
 =?utf-8?B?UHh1ZWpvdTA5cXpuWlBqa2U2YnczVlR2aUhuRllUVjNVaGxMT3pzRGxDNEJh?=
 =?utf-8?B?c0phclZ4UXVLUWpHQmpsbENwN0tLdVhoNDYvVDR0bXJURU5KcWJ0R1lGMkFR?=
 =?utf-8?B?YjhBZ0Rka3BmeHZkQ0h0TmdKVG1pUjY0b05TaFJKZkRmZ2ZwYlN2YnRSLzFX?=
 =?utf-8?B?RDhpbWFPU2I4cWltVURkd0cybFZsaTB1aXAyUjhvcG1XRlBjV1NCSUJkSSt5?=
 =?utf-8?B?RU1hWG96MDZuaUs5UGtsZGJWQVVlRFZlekQzOXBiSVNKZ2pHZE5EK3I5SkJM?=
 =?utf-8?B?VnZUclRITU1rT1p4VG9HdzA1NUxYNStvT0N5Y3BHRGFwMFlkL1FyclVNYkRu?=
 =?utf-8?B?RjZacTNVYzV4MDhwVzJ5NUxpaC9NaHNtY3VORmtqZGF2ME9oOEpHQXZHem5v?=
 =?utf-8?B?Z0JVSDhxZS9TOStidnNNTnpyMzFmRTRsalZ0dm5mMmlDQWFWMXJQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc684db-c8e2-4055-d0c4-08de970db025
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:30:18.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXskx70pefA9rLwsacJxO10eMsfPeOYkSU5RmkuDfX6uGXURHThL2iXxhP8niNLG7ebO3rwBmMIEXlMVusXabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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



On 4/10/2026 4:38 AM, Eliot Courtney wrote:
> If `header.token_size` is smaller than `BitToken`, then we currently can
> read past the end of `image.base.data`. Check that the token size is at
> least as big as `BitToken`.
> 
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 6de7e58e0da0..de856000de23 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -423,31 +423,31 @@ impl BitToken {
>      /// Find a BIT token entry by BIT ID in a PciAtBiosImage
>      fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>          let header = &image.bit_header;
> +        let entry_size = usize::from(header.token_size);
> +
> +        if entry_size < size_of::<BitToken>() {
> +            return Err(EINVAL);
> +        }
>  
>          // Offset to the first token entry
>          let tokens_start = image.bit_offset + usize::from(header.header_size);
>  
>          for i in 0..usize::from(header.token_entries) {
> -            let entry_offset = tokens_start + (i * usize::from(header.token_size));
> -
> -            // Make sure we don't go out of bounds
> -            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
> -                return Err(EINVAL);
> -            }
> +            let entry_offset = tokens_start + (i * entry_size);
> +            let entry = image
> +                .base
> +                .data
> +                .get(entry_offset..)
> +                .and_then(|data| data.get(..entry_size))
> +                .ok_or(EINVAL)?;
>  
>              // Check if this token has the requested ID
> -            if image.base.data[entry_offset] == token_id {
> +            if entry[0] == token_id {
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
> +                    data_offset: u16::from_le_bytes([entry[4], entry[5]]),
>                  });
>              }
>          }
> 

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes

