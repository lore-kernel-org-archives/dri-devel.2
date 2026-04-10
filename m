Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0293EF459E7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B1410E972;
	Fri, 10 Apr 2026 15:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="reW6tIW5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE70C10E98B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQK5s6AyjuQYn2B/9c4rqLsK5s/j5EyQuzjDlPOXZj9cPb6R5lEuenfe2qFlJyxW6fZ09HaZpx5ImfIaza59IoP04MgfXGPVW+64zNhRZmtvJXYY5JkjEakBuS5M9iRCImiaDBN2MHCPGwxu6WT4soy4NojWS1h92mCMQr60gVUDc4+8IdYFz0idXfOGV0Y1WMq/JqQWaFdZzgtAKain6lKrwRfwJIFFHEPwqq1NhNV3xTbZZe6M1U94prKMcrkI99ucjicY2SBIKNuZ5KIQzCKKJtvKIYZ0p0UHeQ3vo6SkwqTPLzvqnspdw8iMrPfe5mp8URuJHWi1Bc5DVKkS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNTgbDhskTXscYG24Wr358tHxm9N0v/SynykI3z/P7A=;
 b=G1wGyPDrb050qTwTpkvNqnITTMuS12q+EmYK8UBhnwB9LU+o+jm6UvA9RgmNI08qsxrmYBvnYmMXffwECbCwQo1E7K+zd7XrARQXuKAFDhc8S5CSOz41871huXZSPMir2Z8o0gZwrMGWWJB0+FNc/HRQcRcgU30hM61VDFnl7MjCvOEWZhreu9dWKB9rbqFubtbVx78RNROdbM6SLtq20lXbcoX8W7IKSXWr3LMfp+zObDS11Va+7ao2erIw4vnd5OULy1A+7pl2cPvJJPqfDZXcC00Wk0aM/jqFJbNgmvHHdOVook7MK6hWEV9LtY79/YcJkaXNcpOykhQQwY+i0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNTgbDhskTXscYG24Wr358tHxm9N0v/SynykI3z/P7A=;
 b=reW6tIW50DUnsIgrd3npZll+nYT0J0Me/XF6kYSYvM9XzsR/UCtla2NyqFFK3kI7WReN2UhlDByB79pnNF/OanzHuq+XIIVYm0OiVDnQAaq5rIHc8dtq/LJY0ZRSPgdTdXEJYm/iweNtzQNN13C1sJYTtr0h59Ru5ofto0CBHpwBo/ae3/vP0/t3j2BrKEYERCaEgBhXJ0MOcOY/44pEngreKCbAwBlfoO97Owk9Q7l5ayOFcP3elIWLLo/8rGSBBggKu1HTLJBgkD5BMMfixjO62OADIOmcmA4Lvqyqwi30LEmvyzJaOV/JF1FYZLZijk2dVfBsv6iIvHjhvaaNLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Fri, 10 Apr 2026 15:00:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 15:00:25 +0000
Message-ID: <9dada5fd-9adb-4680-9ef6-488773ef2db4@nvidia.com>
Date: Fri, 10 Apr 2026 11:00:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-4-bc6f71d153d6@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-4-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:930:15::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 770334f3-0fde-4b35-f6eb-08de9711e51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: dLmgcZuZThY7hZE/D6+XMZFgLKC5gnxVxtnl9D5D9fXGpZSY3XFPYebY75K0XsrKBHzFmKWOfjMql5fug0/yWJPnE7zQ4fBCtgjo72axtMv4V/Wfipz2QCgnRUnSKJhtSH6B7qTliGJwl8g9eHAnK8D/jfG89Y2DgnxwpAKAZmSJ0gZ6jXu9vxBLx3ew95KXJVnPcyqm8A8gR7hP85z7UMK8AjOd9zB7H+0VTvom9CyqhDEThf+47ZvbhqcborcmObLsjM/aCbAoqxTLjuCtmi2P+IxndGMjstzRIRXKIVETnMXJF9ZtAkliBJv0b2SkFkQ0fXDjgJhnxN09AtIwlJEhiHv5PXG3S8A9cs5bk6EK0lCKJIy83fquHluGJ3OyL6t10uSLz3ke3G7LvzgXINz/KAAXgCygbPR8ZV+wGXO3vm68CjM15g1cHZLcQK+jpwV6ZjocokMTY3KnPiY+AzNkWqiT3PGb6uBMxBHOPlc+CM9FJCtgmhoIXBN2rMH9J5iWcq6W75mjAbbqnH+m7yYjxbG970b3J72IIZoYZkxn0yVnBwVoeGWc/C1iHQRa9WJHBaToCe0ddpSr4aFJfl56gL2oKOlbkAhRWD6FBmjZ4pxjhiLrqfiukZY0tSgq3bI1WQg0TSoXYxHoN9EgpQq2NAUcc2qDFHePHNz1qWIhYcf80D1XVsuzjS6yZNqm8EpYIAhbeswsGSruaHk8Wsb3E5oaZW9Eq6533lZWeF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFd4QUJ5NWlQaU8vOUJLSjJVN0RzMzMzeThWSm80N0NwLzEzemIyK0pTZWRR?=
 =?utf-8?B?a1p6QmhJVDdXWEJ0TVlqUTc1cnNlSEVoUGdnTndQdithWklFV0QwcGplRVNJ?=
 =?utf-8?B?UmY0TzNpTGtQRzlZQjdsbmxKUTRBSXVlOWdVRi9vbDR1UTl6TkRhUGowem5h?=
 =?utf-8?B?L0wrazFtZGtiODZ3N0dadkhwN2NhQTlUaExxZEQwRTJVR0p3eURNeU0xVHpV?=
 =?utf-8?B?QjRBQUJreXRGUHZsV0FURDh0N0o4azdlRDY0dVJIVTVJV0VQbzdMK21RNjZs?=
 =?utf-8?B?OE82ZDNkaEpXYkVrdDdtdE5pVGd1SUpiSnU4d1JXUDBleTd0Sm1uZ05ROHdm?=
 =?utf-8?B?QURLRVROWmNoRUFOOVllQ2xKUGNjWDNwVDkrUEdocmR5Wit0VEhFYnR4UEsz?=
 =?utf-8?B?bXB1dVFVZ3YyenlTcVVZNzQ4SElYb0hXNVhRQ2I2Mmw3QmpGVnlsRzE1RUFh?=
 =?utf-8?B?MkovYzVSQTU3VGg2VE5zVkF6eUxTbUNGeFJlZUpWTHRUamFrcXVlOUs4ak9j?=
 =?utf-8?B?T0dvKzJhcTQ4Y3RXSG5TZVNIeU5TckJBQkJnQUtFSXVNeHIySmxuOUE3Wm1a?=
 =?utf-8?B?N0t5WUpCUm9vY1d2aVo1UVlzNnByS3FrMFpxWFZDVm02dk1PZCtDUGVPdUd0?=
 =?utf-8?B?RjI0VTB5dktzWDh6TmRscVNTeE0rVS91ZnJrdWoxMlp5MGpzMVl4clh1UjVU?=
 =?utf-8?B?WlNSN1ZNVUNwUXVMVjY2NTdHTE1xbU1BUlIya2ZxcWpXeHNIZGQ0ZG1xNHZy?=
 =?utf-8?B?N01QSnY1ZmRvUDd2d2FmN3VCbVliMk9iZmlPT0JCeXdaZGZ3T0loa2J5Y1Jw?=
 =?utf-8?B?dk1rOWFobGRDS1ppZmFiM2NpQ0h5aXRYM1JtS3c4bnk0NTdVSHZNSU53MlQv?=
 =?utf-8?B?TXB6aWtHVENTSkI2RHNVSGNOMWdOOFVQWG9VZkVsN2pTMzkwbzZCUnc1T0pr?=
 =?utf-8?B?MUpzZHZ4Y2tQSjdSTEJud3RPMlBxLzF0aVNVdVoxVithTTZCM1RMR1NiY2xu?=
 =?utf-8?B?WVdNN1VybUlxSmdEYTUzSC8wSitDU2tsWkRvbGM5eU1uRldUa1hrM3llUTVK?=
 =?utf-8?B?V1h2SG84ZFM0M1l6em5Qc3FnL1lWUGtZTXpzczd0Mk1uTHg5dkxUa1hraDMv?=
 =?utf-8?B?SmJqTUYzNk1JUk04SllXSzRTSWZXajI5M1NiM3U5WVpaODBBcUVaM1hSNHVE?=
 =?utf-8?B?WkRwSHRvRjkwVDZKY0d3b1Jvanp0a05GTVRPa0hGek5lT3NXOXRhM1o2OWdD?=
 =?utf-8?B?U0JzcjJkUlhlNG01Z1B6bjhiV0VXQndpdVFORmtzM0RBMlJSN0Y1ckxrWldm?=
 =?utf-8?B?ZVh2enVZUi9RcWF0L2lDOEZNZ1hUb2ZXS0V4YjNFbWtabnAyU0pIMVkxTHZO?=
 =?utf-8?B?ZGhLWmRha0hqRzRmUzNodHltY05HYUw5M2lxb0VJMHQwc1dFYUhIM1lxMGJq?=
 =?utf-8?B?K3h1bGVDNGZuZTNUQjl2NithMGV2UExEaS9yZDVmNFVJQUM5aGg0Q0pEekg0?=
 =?utf-8?B?SDA3N3Facyt3MlRML0trNDRtQjAvRitHd1NiMlBjK2FCRHg3bThvUTEwbkF2?=
 =?utf-8?B?bFN3V0s1b1pQWjk4Vk1EWnhLdDNqT3lFSk1TK3d0SFV5OVNQd3ZxeVAzRkxW?=
 =?utf-8?B?Z3p4eEF5ZWEzTEhldER5aGxHcEU2UkdwTjhMT2RQWHN0YnEwRlgvUXowNkRi?=
 =?utf-8?B?WlhTaXhUQTRFNmNLa0VJaTVuRlF5NnZlU3BkbWt2QVpXYWlCcHNxeFgzelNr?=
 =?utf-8?B?RHNZQmxhWnZudUtMbXBEUGViV0k2dk13TldUaXh2Yk95NURFeTVobFJTamMx?=
 =?utf-8?B?MGc5dXRXbjFQLzN2T0loKzdOcUZzWU0vNi9QV2FSNzM1bFdHZ3pkSWI4SkdN?=
 =?utf-8?B?SkcxMWNxbVp2QURkUy9Da3FEMGVieUYzZkUweEpBYWJ0cHh1ZkNIS2l2SkhH?=
 =?utf-8?B?T2M2SytUUW5FZnN0N0dCTjFyNGQ0bzNqUHFnQ1VUUHlrY3dBTDZheTV1TVNT?=
 =?utf-8?B?KzlML3M1clBXYllxcmczdUtmUVYyL2ZaNUxvb2tvRE9LM1JHMmF2eFlFeS84?=
 =?utf-8?B?dExSSmF0c2lFcGtJbTJ2Q253VmV5eUM3ZTlIREhFMFVlbzJKWm55WHFDZmlY?=
 =?utf-8?B?eDJYMmhpL0xUbHlEMy9yYmNaRHhLRUgrNFBUTjVsR3NGb3lodVRBdzVEZExC?=
 =?utf-8?B?akttdVpvSVFRdElsSUNqMzhMSmcwSXlmR3NLTUI3OTExdkhJTUJsd25lWmMx?=
 =?utf-8?B?QndMU3BFY3FabW1NcWU4a3BrdUZrQmJkUzVRbFNuODYrcWJ6dXl3d29haEgz?=
 =?utf-8?B?WVNkSGJLZzArNFhYcTJwSml4R0FnVDJlUW8xaXFuUmRuTDljSGFSdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770334f3-0fde-4b35-f6eb-08de9711e51c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 15:00:25.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6EsTgxm6imtYaTtQ0RGiKcuhWNkZ4/dMi6Xc+kXW+FAyKFU4VHEl6g1vdh+hmu3Hr6MGWzTuLzBHPuwJDiE8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
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
> Use checked access in `FwSecBiosImage::header` for getting the header
> version since the value is firmware derived.
> 
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 2b0dc1a9125d..3bd3ac3a69f2 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -995,14 +995,16 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>          // Get the falcon ucode offset that was found in setup_falcon_data.
>          let falcon_ucode_offset = self.falcon_ucode_offset;
>  
> +        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
> +
>          // Read the first 4 bytes to get the version.
> -        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
> +        let hdr_bytes: [u8; 4] = data
> +            .get(..4)
> +            .ok_or(EINVAL)?
>              .try_into()
>              .map_err(|_| EINVAL)?;
>          let hdr = u32::from_le_bytes(hdr_bytes);
>          let ver = (hdr & 0xff00) >> 8;
> -
> -        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
>          match ver {
>              2 => {
>                  let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)
> 

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes

