Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E117CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF8110E10B;
	Sat, 23 May 2026 02:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Be1LUCaP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F8110E10B
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj7zzv+9+Yy5CT04fX3mJjt8R8VZ/IKS+RqoLiDLD3zn45ljKlCdwK0vVypMX3fdoRSDTT0cXKH/aqH7ZZAwdjVqJYIrRJiXaWV9PNdZziwtx9vSZlniDWsTzhcyckA9V6PLzRlRkGxA5Ktuyxv2IPhGGxxsH6lk0bt78hXRElIeei8GjYlwP93DulyIEXUVtksUvcESrvGBJxagIuHSpGoiw7Y8Rz+EdgZjf7SeDdNN2kUuFwO3BdWBrt0wDtZVlEBdICjg3u2ouznFYbehHnhDBCo7rdFGUT5ijqJOQNe7tAV9D/POwwi0oaGCbodfKcl0GGQ50LLeE99H5OmsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYz75APC+cPISjgBRMHi8WWzI6YqWeaA1lsDg+Es9Ok=;
 b=S+ozpRLu+P0VpGlx8nSX2OUIx86UwtwlFlCOZij8etvGQYn6ZgY1CJV5hi/rX7MNyBS8h5NlLfa/4tIyxM0CP8xTl9/81VUIuUEF12icG2dLbo4bFA25UHQMkg0BtsDCIVu9iknmyBnqsnJRerhOd56xrF2ed7kuNr6wmjrjakvcMwbIHaIdV7gDmRr8Ow5VvA/kIFBccLzeVhpd6PIxoXNbRZPCyp6dkui4jMbpyUGmT4jw0CV3PTVdmn0oJZpFhyr941oDtInlPCmrILw+9GlOtY54+C6TYbA4cXup67iuIQlVekG6rQmqV99PQ/mJsoZSoMOhelrxDjrD8lcZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYz75APC+cPISjgBRMHi8WWzI6YqWeaA1lsDg+Es9Ok=;
 b=Be1LUCaP6ltooOI6Q7V+PiPc6KKFl0P3oSnemFPNoPaVqnHpTTGyZhbHKGLE1h8nkGFnN9AKKTsic1EQFAE8itOCVsyzkJ3EWwd63keaLQT3G29pocPf0SEhuq4ZIZ4/wVdeP46gaN8bE9SbKD1iqH1OPNXH56xR4O5iEtdCGgiA0C++4MIcFeR4k+6C8Zu8/d7le6w1SayKFiHoBJYAZYLHAklPJQz5Tks44344OpphJh4ER4ywvtE79/JrJRiSsdCO9bUBaV3v8ETLys54LdGClibvPG1jSnzTYWGR6JZsk+nFrXtluCvBxlxF/AFj/FwkBfRmnkPWld6iPoEBTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 02:55:04 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:55:04 +0000
Message-ID: <3fbb8346-ea13-47a3-976f-d13406552599@nvidia.com>
Date: Fri, 22 May 2026 19:55:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/20] gpu: nova-core: vbios: read PMU lookup entries
 using FromBytes
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-12-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-12-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::33) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: cb539b1d-1774-46f0-478c-08deb876b0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: y5k5/+6TbMnkSJZt8F3hacV65ZHQ7W1xWD6F3alGlHO7vMVPSNqMHZRFpqhZl1QLHIk4l8+1esITbfE8200X9kxguHV8uzVXBM6i4HVWhrZvlrHxGQTeyoVuZkq+28Plk93ZOm63YdyM9KXlMwsfkWiUMPSRr2lnRAcBU9fllGpJ9hjNFue7nArri8gAq+BdSZakdqMKWvb4t+ufjtVquzY966/x7T242Nc6uxXcVMwJzZjt1Yeo+R4335zN3h6UFvhOo2DOKrBpAnFpWeNGgPtHIDqE9nfJR94K74c0PJAmq+AEUZjJ4X6NUgqA2urri9M0FEuWkHGtSnldew2cY+um/5LeUqYix7jZsxPpKCwLzQhRSTq5xIKhANQiTwO+L+RrxPoMSj8hQ0/6GUjjzLS0o+AChuJK6wJs8LQE444qRyoLWwu47Veaz1TY1Y0chxyNm3658HmRtyshvWCSpJHdfzbZZB56L5M3r/3MPbCCFo5dQkybERemwBEMz/TGdOd2XHSKfjejouyyg9PcltJsJcRN/WY5BMvEHXXuzVdCBBtTNMebnzSOtmZkOOLOfZZCE7XWaK/JrYaL581mzsoHmoAiG1TlRzBCsLxA7Eab0CL1UZClONN6ZsFmBRzLcZsavh6aYm9t+A+RxGB8b2KiBcfH73B6WqDh+m/KHifl+XYtSD29RKJfaQMDv/mT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFPbXp1NDdBdzVzMks5SDBaekxTa01HSlZ4dFRuWG9Jd0ZUeXZITHdkRUFD?=
 =?utf-8?B?VHp1YURFb1Rzb09wM2docFlMdXBGOFEyMlBEOWExaVBvU3VjQzg2VTZVRU9l?=
 =?utf-8?B?czhjSE5yYzhnbnRaeER1OGNWSEJzU251NkpJLzlTTUo4MnE4OEkwQTN2SG11?=
 =?utf-8?B?eitUdkJyZ2N4L0YrT3pyM0lId000ajhxalJwWnc3andJc3hjYW1aL0MyVFlF?=
 =?utf-8?B?OWtxQkJHdkhFNzNxY3NKakdMWnlSYmx4cFRPNUhxTk5WeVkrekk5VzloRTdI?=
 =?utf-8?B?c2FBeVhkYk9YMGVEckV5TDNCaFp1MmxxdXNObEdRYnV1a281UmlUNWZKTFcr?=
 =?utf-8?B?SU5NM1FBNmxPa1hoeWdtcEdmaGVQcllqOHR1SzRrRTRFdm1URGlCU2VCYTFh?=
 =?utf-8?B?cS9pNytLMWwrTVI1NFZWaXllbWdhVE5UODl1NlVVSXVnRkNZYkRIZElqa3Ro?=
 =?utf-8?B?NC9aSE9wUmpiWklpeERDVzFweWtoNTFaTC8yY0pldGQ5VUlYSmdRT0E4NFlK?=
 =?utf-8?B?UzgrZWUzTEVMTUwyV3N4OEErbUJKY3NRTU1GM0RBUzdZYzVBU1hMM3ZsaStz?=
 =?utf-8?B?M01teElnRG1VVndkNjEza1VKL3lTMUZwMWF0TDM3TUlRUm14Q3VVY21LRGNx?=
 =?utf-8?B?M3F5SEU3Ny80Yy9rRGtsb2ZOZWgwVzFXeTFjWm5FVlg3bTVKK3F6TUJmbm9G?=
 =?utf-8?B?QzFSSlM0bXhQbFpMU3hQQmdNRURUKythRHJaMkZkQnk3L1hYd3hMSVlieXhp?=
 =?utf-8?B?dlAwWnp0ZFFvMEN2bWtSQ0dLNS9XVlFQN2VvcVhsRW1uSytnU0xMUTZjcHB4?=
 =?utf-8?B?c21lV0F4MUM5WUd4N0I0S2Zob2xZZjJpMVZ3bVFHZ3djbCtUT3hZUTE1a3Jo?=
 =?utf-8?B?eXB0cmJ3c1FhemF2Q0grbDhhZkJBbFMzZnM4MDlzY3o4VHFxUGJwSXkzc2h4?=
 =?utf-8?B?RjcrZUU2U3NPU3IxQ3dQTXYzNXgzSHQ5RG9DNVpWSVg5eUt3NTIvZ205WjhN?=
 =?utf-8?B?UWZIOE5QQVFFNVBFVlgwbkYxb3ZYTVV6czJaanIvV3k0UmgvNXhUVzBobEpV?=
 =?utf-8?B?aWhHNy8vWkJpeHdORmwwMWpBR0V0UldXaElXVlpqd1JyNkp6WlRLTmFPSC83?=
 =?utf-8?B?VzcwNisvQU5YMjhwM09CMDVwZ29OVHRSb0l5SXQxOTNtRWoxUXhya1dtZG8y?=
 =?utf-8?B?NjdQMU5SdHFRNStsdnFoS25sNmdSd3phUVZONHNnVTdBYm41U0o2MElGMkpS?=
 =?utf-8?B?WERCeXRrV1krZEJkM3hXZVVIckZvUSsxdDlCdy9jQzcvQ1FDYUFuaXlkTjJq?=
 =?utf-8?B?eWYzakRIMmNUQnhIUDN3aXBBeU85c0hScWFUWHFBZ2dzK2ZUOU8rWG9QcGxv?=
 =?utf-8?B?KzFRSWREVGFDZjV4d09hdStWS3ZUcEV3NTY3NkFPZ1d5TTBRalh4Z2ZoTU85?=
 =?utf-8?B?T012dVRReHlYN1V5QnZ4QWtOOXMrWGdYUkljMjVNd3hNR0RTUmd6WEwwMWs2?=
 =?utf-8?B?cGIwa3hsSUZueVVCelJ5MmtqVFUrdFhjVlZMdXo2Tlp2WlhJaFl5SVpDdXh5?=
 =?utf-8?B?cjR5YUtSeE1JTWVVUlFvMFdPZ2JkcUdmZ2hlY1pHaEV1MjhQWmZUL09NUXl3?=
 =?utf-8?B?U1YvRERHTWNXV2xKVGtUWkg1dmFOUE8vTUw0KzFabVA2YS9QVEdYbzBiYkJW?=
 =?utf-8?B?d0NpUUxqU0NLOW1IQ3gvYkM5cVJzNnVabDhpbTZMcnh5R3VNVXEzNjU5ZzE2?=
 =?utf-8?B?RGFYVzdacy9RVVZRNUFMVUczZzR4dmh1b1hTN0dtc2ErMmVDN3JUY3A1QzUx?=
 =?utf-8?B?Sk5ETlUyc1FWb3huZ3RxMmdtZE9WcFVtelNKa1NXMExvSkZmSjFXNzMwVFg5?=
 =?utf-8?B?NjhBU3FHTmdlNnlJS21YQ3VXVUY5YjVQNFZHL3RVWStWbkdzdmNTK2RIbXBn?=
 =?utf-8?B?cEdZZE5LK0VtRjM1WEdwWHkrdWF6a29pNTlHQkxyRGtIaTFpVzhHTDBIdzRi?=
 =?utf-8?B?RU1ya2N1WXluM1RxUlE3VUZFVFloZEg1b2ljS21pNjFzUWdCSHM3aXE0dXAv?=
 =?utf-8?B?UFk4QkwxSnRpRnBHWkwxRHVOU1hWTGkwWHYxQ1UyaGg3YzMyR2hFbFVnOFNT?=
 =?utf-8?B?Y05DTjZ1UCsvdEpjcUlZa3VrZTdpZnRvcUtVTWpwUVpRY3NFckVON0hjT3JW?=
 =?utf-8?B?U1dsZlM5Z3lSZFJ0SVlyOWxRTW5nNkl2c1JvRXBsNHkyNC9mRXNFRlFwTnJU?=
 =?utf-8?B?RDIwOEo4bnY5ZEZvbUJ1cjJIOEcxYmczckI4RHFTRXNiYjRNV3p3bENtTERH?=
 =?utf-8?B?bHYwWHJYZllMaVg2NC9SZWs3WkhqaE9SMVpHdlJSYkdYODFxVkdjZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb539b1d-1774-46f0-478c-08deb876b0bc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:55:04.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UXtmxJSzliJj/VvGjYGneM+mG73QErJ0kHnnfIx4uzIZHROvyItexicL8ZqVGFcdjSonuv0qYlr7Zfh7mrYCg==
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
> This simplifies the construction of `PmuLookupTableEntry` and is
> allowed now that the driver can assume it is little endian.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 470e0e2a81ab..987eb1948314 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -897,19 +897,8 @@ struct PmuLookupTableEntry {
>      data: u32,
>  }
>  
> -impl PmuLookupTableEntry {
> -    fn new(data: &[u8]) -> Result<Self> {
> -        if data.len() < core::mem::size_of::<Self>() {
> -            return Err(EINVAL);
> -        }
> -
> -        Ok(PmuLookupTableEntry {
> -            application_id: data[0],
> -            target_id: data[1],
> -            data: u32::from_le_bytes(data[2..6].try_into().map_err(|_| EINVAL)?),
> -        })
> -    }
> -}
> +// SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
> +unsafe impl FromBytes for PmuLookupTableEntry {}
>  
>  #[repr(C)]
>  struct PmuLookupTableHeader {
> @@ -963,7 +952,13 @@ fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
>          }
>  
>          let index = (usize::from(idx)) * usize::from(self.header.entry_len);
> -        PmuLookupTableEntry::new(&self.table_data[index..])
> +        let (entry, _) = self
> +            .table_data
> +            .get(index..)
> +            .and_then(PmuLookupTableEntry::from_bytes_copy_prefix)
> +            .ok_or(EINVAL)?;
> +
> +        Ok(entry)
>      }
>  
>      // find entry by type value
> 

