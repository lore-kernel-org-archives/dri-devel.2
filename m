Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B6CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A72110E5A8;
	Sat, 23 May 2026 02:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gunhs8Mp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F317110E5A8
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUjb0NpUeq64wWFMlNneTVmNCRRUGdeH/DwV1VcM7gEbmEGlDqWe3cJqFagTk70d7d9nScRhTYUFLQeKXMvY/0s7P7m5dSEHYXosdS6wyawhYq24cgLUPw5GtuO1ZaaMjmuvuxt4+6LQTyCFUtNnx3K0+CnDcyVem9wqfosl7NUq3rlpqa6Q09Uy+QVHauiBluxj2yXaWFi3WNE5sVIc/EvarWeUPR+Mfcm2G3NjmFBE8prd8LPRlWJOLJjv+ikyxQq0obLYk5n+BBCL3yjgSAzbgCTUMfnMmrLl/UG5F/WNbKxirOvllddPM+DRz4fBkdnDYzOwXrcwjBnH1O5Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhhqYbM5791zC1PRxc5C4RJRw346j6kLwea3ZL7P9+Q=;
 b=oM3UyGtugTMlcz8pCSm/iDyqjHXGptV+8NorT5Lub8h/XVhY7fgxGaJwapLEmbdd4/JZ5M9b+Zi/acVPNxs3nSKE8T1rNKmN9Wv/mIiK9QGk+Kq62Dq5E2DGZlFH13xnDExoUD5iO6/MSnLdAxOycxrAnwU3PRMWICY3++Foy/+7nS5YdrE0Q5vEwpPFM1Q5cNLA1cAGn9goQ1SyI0NX5Olf8oSc8FFyG3lfPNE/KGcKV9JvpBjpoyAKFKrhxLIP1JOyQ2THEhz/lZa9UtHQVP9Holvg+skZTkSuGhRuZoKkjk+vXUrn3OSiljo0n7cy+VUAQubWbgL+Ah1l6QAhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhhqYbM5791zC1PRxc5C4RJRw346j6kLwea3ZL7P9+Q=;
 b=gunhs8Mp5iZLyHubAj+6+d/L73dqGGDOCk60lyl6RUqzNnkLBDdzlarcuEBRUMCeXCr7MKtn8iTyozHPw9Uevzq7SDEOn6T3DY8qJToWO5iI41iYeGfwmVv+kYZ9C8AHDquABb560gnTJ1HKTKTNW/ifS/uDv9KG8R+6mOgmClnei1CMXcH3sr/WJkr+/kNkqL2/SLc7p5eAtR5zIMxyVFaOS22oqnQfXHOXLlKwXbwmmP9Tst6C/xpN72uaaFbeObFYz/KpZgBzkl8FFY0jkOyfPx/7AU/N5qGx3/mEpAwX+liyDNisYfab0W0y4d06PuXs0rChK2NmbqFE2fDlWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:48:36 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:48:36 +0000
Message-ID: <6e867993-3b60-4e40-a6fd-74dd1014b3aa@nvidia.com>
Date: Fri, 22 May 2026 19:48:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/20] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-5-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-5-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: affcf386-a201-4b92-f92d-08deb875c94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fR59dvTA5P+cylTvKrFweYvWJn8HBbygkaXMyogkfL7h2crdl202HDE4H4VaZU3XaxOHZluLT7TjcGNhPoB2QOJMFGeU6ca0xzDTzl6BxcFK2YZWWHsM9xqJ8geQCPXO7640KTQf9iyvt6Hn5zlQ3RrgzRCXY45/Eq4tKaxhbLX2r6N4NYvA4njMAswjj7lrcNPMH1CDy8qyfUh9+AF6T9q6jcwfgdVZeBB3YRgDRfyaqNSZL0EyzbFhJvBQMoXibuBMViOJ067a4VOOUbU+Wlm/+GPI79Z8a0uG8Ppm9kSWhPa+oS98mJ9afdaMHZihlm0FGaMu38Vmt1YdA0k0jFGoxvYSkStxm7bsjXzoliHGN68NYzEJcJwNdDdYLHnki0x7qWh+Bk8K1vB7PregTwzHvijuo/KwJPTAnVlf0auWZLGUU/6ffwOaPh4dGDfvoAugCC15vSsN70Z+ZgzjyscR/R93PxhXGdr6KRxnPI5jTEVJulRloPdxBPUUzZKFj22wwdEI0Nwd744u/KkRQ1lxCyC531ZdMkVTWpoZ8q2qGVrlg3uLmGLYzLVoTWLjk5e3pIg6MzZweZQmn43tgcI+LplS29xV21VU9jhQdBXdrMHGQC85nPdHk1vOHBwEDzEBJib+6Ntf4PDa32VXC7DASQfAcGsCYIrMXHnKgeknRo/Od2romI8fupK6nq5W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BXUUZ1OFcrNUlrUFVyOWhwci9nWUFHY3BLSlZOS2hrTkMxVW8zbVRpajRu?=
 =?utf-8?B?dkZjS1RBUXhXbllJakVzaXdXVU5zUC9YSXp1OEErR0psR25GczJTdnJvZ2J2?=
 =?utf-8?B?RHZQTmxWUGF1Ym9MVnNSdUlDZGdxZ2hjaGNTdWFqa2pRZXRRYnUxWm9RdFdT?=
 =?utf-8?B?cWJuSzllUW5IeGpTSTlTdHdVdmNIMmNIZGtWYVFpT0UrQmdGVkpHRE5wZDJ3?=
 =?utf-8?B?STV0cWlyT2ZrSERFNU9GcjV0RCt6K3ZwRWs3VDRubmlpd1h0TWdQaVE1MFZ3?=
 =?utf-8?B?a1pZWjhpekFZSEw1SSswUWdhbnlIZ0c2RjRsb1puYkloRFBIZUpERHhkNHAv?=
 =?utf-8?B?TE9laDd6LzE4aVhoeGY2SEJRNnZnOTlGaHpZQWNGTVdRL3FTekJyejRucFFT?=
 =?utf-8?B?NXAvRWdoa1hOWVVDaUQ4ZUxTVnJVYnppdHVhZkppV2hRMUtSRXdobCtYZmY3?=
 =?utf-8?B?UkRYRWtoKzBYQlZRb3puVDYvalZQUHRFaktmL2NVbERwQi9hb0ZvOUgvdVhy?=
 =?utf-8?B?YVR3K215UFNpR3Y1WkNtbzQ4cmZmSWovU0VINWdMazlRL0xCSW9OTnFDeW56?=
 =?utf-8?B?M3BQM1VvU2RoSnJIZVNKb3hXUGdGbWNNdUpNd05Xek5RYnM1QkxuUFVHZkxY?=
 =?utf-8?B?SVBkVHBwSXlRRjJMWFJKdkFKYUFVMzlZK20yMmo1WkMwQ0FSTDZmMk1sa1ZE?=
 =?utf-8?B?aVk4eEF4dDF1bzRteFVyd1UyUXpKOGYxRFQrMFduZjEvdzE3REpCS2Fyb2x0?=
 =?utf-8?B?TG11Z3drWHEzQTU3eWNJYkJRRlZMNjZnUDg4a2hUeEV4ODF3NlJFNWpvSFBY?=
 =?utf-8?B?MGNXTFR4Z2Y2VDRqZFFkeU5pdmVqWmZpb0JEWmZpYTNVZjNwV09SZm5xVlBr?=
 =?utf-8?B?WmZLOGJJNTJIRmZCK01zdEdicWZkVC8rQmMxZGRLT1ZTb1NZM1M2M2lWR1Rp?=
 =?utf-8?B?bXMxd0xBNkFIc013dDVzMUwxS1dwbHdncVNQdGpXQ0QyVjBrandLNjg4VWxp?=
 =?utf-8?B?ZFlQWWJoQmcya1JzVXB0K0l2cy81MWJCNDZ1VWd6WUZxVXJqdUM0WVVpbWtp?=
 =?utf-8?B?ZnB0M1Q0RXVHeEJwSGtrcFpOU2lGNFFYQXZIeU5LSTI2Nmc5SnRlVnFGTTBB?=
 =?utf-8?B?SkZFNGtJOCtodFlVbktocEx4WFB2Z3FZd1BYd1VjMHFkYm5jb29qdlc3QmIz?=
 =?utf-8?B?YTlXNHNSYmhxWVhVRTJ4cjgzcnhPK2hHQmlJd1Q5OUhmcWRCT1JlSHJQN3NF?=
 =?utf-8?B?U1JSMmJKWGxWK1FmS1R2MXBndlEwYTM2bURGYVpFeTlqNUF3eHVNQk1KL2tn?=
 =?utf-8?B?TTNSSzRDWjJDUTdrWjRWVk4rd01raWJScFZTMk9GY1RManE2K25JK2pBOXlI?=
 =?utf-8?B?bGZRbzFkNzVsWDgxUmxYR0RTSTRZckhrT3ZvcXp3KzJMaEl4eG9QeThsUS96?=
 =?utf-8?B?eWl3UDQrQkgzajFFVjNJK3JJYS93ZTYwOXVTVm4vcGpNd1ZFeVJtMUwzdmkv?=
 =?utf-8?B?eXRlZ0hCcDg5K3BFNXp1cVJNaXJVK1hZSHk2UTB2QWRJZ29BM1BtZStETjkz?=
 =?utf-8?B?Y2hYSmM0LzA3RW9jTzduTnNyZUNqUkYyU1gvZ3VKenkvbFdMVHVzaktKVmMv?=
 =?utf-8?B?aS9sa3VnbTlST0dja2JLUDlMdTVwNVBsaGloOHhwM1paQ0lvb05WZXJMQW5r?=
 =?utf-8?B?ZjB1V1ZXeGV5QnpnWGZCakY1MDQycG1TdlpOK3k2dkUzUjRtSUErUjI3S0t5?=
 =?utf-8?B?a3dPNVkra04rdjFiYmdBV3dRaDJLbmNodTJNYUNmTEEwM3pkak9PeXd2UUxC?=
 =?utf-8?B?azhrMDhWYjJPTDZBbVNaT3k0WXIxTEpUaHRaMmgwd1orTVlaSjIrUy80UW0w?=
 =?utf-8?B?VDJpR3prNm52V2l3RlNYZzZ2ci9zMEJoWlVBZ1VmOW5sbWlJMHZhbnRBR2J6?=
 =?utf-8?B?cFpYeTIrblRGS3ZKcm8rOTJrVlZmRzZ2SGEyQm81azFqaXBPMjJ0MkN4SjJ2?=
 =?utf-8?B?UTF6UjhZUWlHQXZ4MVJ3YzJ0ZGRvTFRKaURac1JpblZKRWE4ZXhKNktLeWVE?=
 =?utf-8?B?cnhPKy92QVRPSlc5UlRwZ3dRUUhSby9xdFovMWFUTEx3Nys0aDF0QTlYMWhi?=
 =?utf-8?B?SS8yaDlhM1crMkg1UUNCRTVnamZvTXA1dDd6c3NCTUVhZ3dGSTd3Rkt2N3Q2?=
 =?utf-8?B?ZHFpRTdDL2UvWWpocXJhcTJPbFkwdlp5TlZlL3FvZEltdHBqbFhJZktNS2ZP?=
 =?utf-8?B?dVVSM1IvMm16RXc2VWo2eEZPZnNkOEZQL29YeUZjTHpVRGVjMFFhQ0FoNmxa?=
 =?utf-8?B?dUJlQW8ydkZwZTEyVWV0Y0FuM0E2c3Rib0RFcExibHZxWkgzMWhGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affcf386-a201-4b92-f92d-08deb875c94c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:48:36.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjrpzc1Xz8pjK/TCHkGrrPZq3Jc36U7aR6TFXAOfJ/lKQrPF+tDDf5qcu/l6CThq94Y80OqE3yZ+YsACfdlUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

On 5/18/26 7:54 PM, Eliot Courtney wrote:
> Use checked arithmetic and access for extracting the microcode since the
> offsets are firmware derived.
> 
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 2ff67273fdff..c62d918a3041 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -1110,16 +1110,18 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>  
>      /// Get the ucode data as a byte slice
>      pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
> -        let falcon_ucode_offset = self.falcon_ucode_offset;
> +        let size = usize::from_safe_cast(
> +            desc.imem_load_size()
> +                .checked_add(desc.dmem_load_size())
> +                .ok_or(ERANGE)?,
> +        );
>  
>          // The ucode data follows the descriptor.
> -        let ucode_data_offset = falcon_ucode_offset + desc.size();
> -        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
> -
> -        // Get the data slice, checking bounds in a single operation.
>          self.base
>              .data
> -            .get(ucode_data_offset..ucode_data_offset + size)
> +            .get(self.falcon_ucode_offset..)
> +            .and_then(|data| data.get(desc.size()..))
> +            .and_then(|data| data.get(..size))
>              .ok_or(ERANGE)
>              .inspect_err(|_| {
>                  dev_err!(
> 

