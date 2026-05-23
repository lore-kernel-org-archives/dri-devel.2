Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972DDCD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466410E120;
	Sat, 23 May 2026 02:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+paYpEG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F1810E120
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RraogtcGpigwyEoDzjoNXyFZBJKXttrWLBc4YiPOXxk6Km51DV7x4dXOzbU8Lo4ZG4lbL0QFWYeVkXGkwRCf7CfLh2Io31r/r6h6WN56t0NX/le1Ynk+3imTi8CdnYa3rQ96CZoTQzwRt4nb2z0yyd7+W7jiS1MNym32LgwsK6TfrdC0Rg/dZ48WuKHIJe6TT2DONw1inF2JOeGJ76UdWJ1vJtgZZyR8OxCikrS7qTc0vL+B+UGcWmEucchkD7c8RxEyh34XITQIgeN4CdA3so4cZswHXTLO1/x2gxLQpubc0OtVWrca6N0h08HftrzGSAM1mA6toLe3SzuameQXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4dJB0qxyjo3qzjpSDtsiPQNd5dD8xlfYZhUXSknEYA=;
 b=IVJJK6dll/N7rLp95M1xhFTzWq/aZyoBVSJQYeZdfsrRxiM9bz1NqGB2Nl3FZ8Ss20tredpJgdiPzQppFSrXqG9t3sF1s/uPd/DDHm/LT1i0mevfmC7ChPFFaYx+RqIvmKhxXVmxHrPVgtHTlxnS9UPPl5eEtGVlQpdaR6Q1SYP1POuBwiQGs7Ob+UZjuSHh9WBoqO/nMTB+WOUBFaDAj5m5VK98GmLTQmPJtZ83tC8ZDD3YF0xBC4FGNa2fhuc1Yk7CBG2ltmsGNJ/WA5I8xja3rkpyN3eoVYc0veWyOTJ/TnNs6NK/ilOBEx52+1M+v9i2E0JY874XNq1KWk8unA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4dJB0qxyjo3qzjpSDtsiPQNd5dD8xlfYZhUXSknEYA=;
 b=b+paYpEGLn9BEOhC1KM+zXVvu+kXXkMHYiZRIfS4rWWgLR0zoHZpoQbS/luWU+VjWr2dtX+tLdnSAGE8PxdpdTKcSgO8gbua+62VTS9b89vx3WyGX6EAp9Q0UjEwX7MIb3rzksnS1EA6p4aZWsj0aHxOLr019UMAEmAOzZGpNmloT9x4jepw/W1iOUZVaEPTlXpucYeMXWpPoN8GskjH+6S/bkLhB9BcZpX+TtAkVZi1K6XdNNhNp/q8uzKLv1nMtiIxh8DKPxr/4J9cWOpB6q5uzos0ERKjPYT8y/+ZR+rvlPNLRcJ70lPZ+uGtxU4Ry4jVDAgQX8kOVj4tHVmpTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:47:11 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:47:11 +0000
Message-ID: <ab8775ac-c552-4d89-ad48-74fbba08bafb@nvidia.com>
Date: Fri, 22 May 2026 19:47:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] gpu: nova-core: vbios: stop scanning at
 BIOS_MAX_SCAN_LEN
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-1-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-1-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: eae60643-1b77-483c-ae96-08deb87596ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZXud3dNfpPsWI62QhagwfKsXv7ZDc+udPByfhjOmy2ta/xwji7vEh08ojB4O3Xj+Vu+yTduTcC8DZRoeXEbN1EwKBIFU+hgoZvj/llS3slHwpxRrW3zqhhfi5/OW+Oh5AZc51XEln0mS49A6T+d2NjRGlWNwCTw1yRUpoxuiiakOE4+JlYuYdriznM/01E7NZ9pYmCRJXM0q9r/g7lU/IIF5Qs5eclbGkfXJtbRMef2d/PbOp1ees1wffwLQG8DgJ4wNw5VcwCbEbUzKwdrGEqaY8yae9VPWKMnzLXeHF0/bzgPSBQfWaX0FkVJThfb0L4NPt9h+pkLZ0EERMIphMDr8oCjYvpEtMrVMIWniubJN1eI3ICb18e3PKBlDo61BWRvKJGIEkp+KyHg+LGC6G16qKzyMrrqKKZkSkR+gugdWbwFt1VTCb+OEa4bl9Jw/aWmJPs8IMQ7ZkmM4S0/UdW37ceeXAe1+GKhgDODuyFpPl1SNDsCBhs7m6pvkJ94PqMmRn8Je9KAigYrDnH5YPYwyC7UOIEKQdcopOKp+X2ToNOiEsM49jGfT9BX7xLvDN67fPGcm0DFcTWMX/eF1VVWwWZTxxjEz5SSrUDVJz4+dLmJAp9UKhX2XVTuwcrJBANT3r/3/FGH8uL7qVYWoPLBLZWKHN5EM6AuOZQURNJA5sV/qg1qiInuSGDggZp5i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFNZ0hoRnZ0a2RXU3RralZDNjZtMGtsbGpmemdrQ3RlYXRURmNZM2U5a295?=
 =?utf-8?B?a25VYXdIU0tHY1ZZRTUzWXNVVHdvbDF1M3ZONkkvOFJON2RONENBY1U1dkht?=
 =?utf-8?B?Znk3d3FoMEFDVXphR3NRVkN4N1J0WkRYdTB0aGthZFZ6YzFOaUszR1RjNUVM?=
 =?utf-8?B?K2tLV1hqU3k5MFIrREoxNFpTaDJlb25RZ0NMMEMrNGIxSFBLaXdFL3Q0L1Na?=
 =?utf-8?B?NCtOZG9qMytDQWR1OWpVZUhZOXQxZU5hUmwzVHZjSFpTY2FHUnA2U3laTWRI?=
 =?utf-8?B?NmVxRVo1N0IvQVNRUGN0SS95V0FJeCtIci90RHFkZFF1ZFJCWFQyMzY2WFIw?=
 =?utf-8?B?bmtZSXIxVHYvNFRMWmZjdFIvOXlnbzBiTXRtaHowUVFhcU5RS3Z2MUxkeEtm?=
 =?utf-8?B?WllTNTBmVHBpSWVuL0lFT2NHL2VkU0QrQ1BDQWZRR1RoWHNxVktURHZjcXdv?=
 =?utf-8?B?MFZHeEtNTjg5QllWalErYlJ5YVhqT01FS0ZUZXpYUFlIMHFIUWZTeWJscjNG?=
 =?utf-8?B?ZXNScXF0d1UyTXBsSzl2NHV3R3c4YkxEUjNzL2NjdmZQV2RlNVBpQVRnNjZ0?=
 =?utf-8?B?ZVVIQVdoK1hGZUVrWUcvMldwZkV0bjZWb1o4SVRMQ09WRTRNZG96Wm1ReTZI?=
 =?utf-8?B?d0lnejdqR1BKVHRZNXJUcWVxQUx6OGV0MDhYMVRSNFRuQUZOR0MwditBZWdE?=
 =?utf-8?B?S2hGNmsyK3ZjYzZDcVB1bWQ2VTNJY0UzdzhrSmNKWjk1WXRmdWhWbHZwc3RL?=
 =?utf-8?B?bDI1YlJCcGZKZmZSWDArUE1OeFRzVGJhckFzMW5sV0I2aStmWnQ3ZjJsQUJh?=
 =?utf-8?B?VTFFajVLdkx6S1pIZ21MclZFdzdvYUY2VHI3djFWVHRlbjRmWFpXSTAxNGR5?=
 =?utf-8?B?cUpZN1RjYXM3NFNsWWFQVkVXK2pBTmVKemd4allRUzRPdllUS2h0YUt1MWgw?=
 =?utf-8?B?aFAxZmg0ZlZVQ3pHc1pvTkVHam5PNURBbHkxa01IMnZTbUVLTXVLcmdkNEx2?=
 =?utf-8?B?UDl0Zkk4eDhJbjR3NFJud2Z4LzBaTTU4dTkySlVZd0NySmVPQ3RidEZKUU1j?=
 =?utf-8?B?QUJMcWhvZFZBUUZ4YXkvNlgvNlZwV3VOam1Wait1MVR5TGN0SWFlYzlUR1Nh?=
 =?utf-8?B?eTNPQk9TaFplN21tTzZsUVFnVHdQVlhlc2w5Q3pJd1p2NTFFMXg5eVNvbTVi?=
 =?utf-8?B?aGhHZmVIdktIRUJKcTJkZmN6SHBNT25BYjlqUHBnN3ZCWkJLYXNBM3ZZSWdO?=
 =?utf-8?B?UktVMkRtckVQWHM3Uzd5NWdXNU4zVHg2bU54RTNOdEc1N09ObTVkQlg2YnF3?=
 =?utf-8?B?c1krNXZkN1R1eGZ4VUx5TUJZYUpJc2h6YXZIbkZ1SThTYVhMa2RBRFVnVkRR?=
 =?utf-8?B?MlltZ3VFVzYrcU1JUnR0S0ZqWW9yemRqQWFJdDlOejdIYVlJWlB3eDdVMEdw?=
 =?utf-8?B?d1RQdHhoUXU0K2xvY2lRQjBDUzNwZDJJUEtyemd1bjJaOG5Xb2ZsWlgxck10?=
 =?utf-8?B?N0twTDNpajA4SWNnYUhLaCtyajMyaW5qWCtYd1pDaFVVOFlYKzdDWkh4TVpF?=
 =?utf-8?B?ZTZxTHpUZzFRZVd3Q3hWUUNyNklaQmFCallLVDhPc1dkYjV4a25TUGZsdXNK?=
 =?utf-8?B?dytvYVY4K2FqQitZZ3FpK2xCQUFLWXd4d2ROcWh2OS9jQ1hRU2J4aDFURXlu?=
 =?utf-8?B?ZHI1TzNic3ZWcXpjTCtuZ3NKVXQzZ05yUEw2TFp6QnF1UURzOVZPWWhnM3VX?=
 =?utf-8?B?MUJwZ1R5a0puWTE4UkJnY3UvVUN0aXJlOVlFbEVtRGk2cnBNV0VEOHVrR2lU?=
 =?utf-8?B?WUxpM0dUdVpLYjFZTDExSHUyUXQyZUNBN01HMGI3M0M3L3lUR1djOEVIOWMz?=
 =?utf-8?B?b2I2K0xqVk1PWDlQSjFDRmRCRWJLRVYzVTZ6cnVxNGNhcTJSb0sySzRGTjlW?=
 =?utf-8?B?QUIzRHNtZ0lhU0x2NnNmSVNhTVptbndPZ2Z3ekNKVWFUb3hsaEN0QjFJQlov?=
 =?utf-8?B?aDF2NkN4Q3NjSi91eVR3UlhYcEJsYzRLekFQbkthZW40R1VVVWNzWEdiYUJP?=
 =?utf-8?B?WHRkQ29GSDZocEsvQWQrT1pxaUZDTG4xOGlhWitqMkpkVlpuWGFzZXJhNTRi?=
 =?utf-8?B?MmhoLzFVSERRMXBXRmhFYS9PWlFQdkZ6ZThTekxOTG5jWG1pNHF2WSsvK21C?=
 =?utf-8?B?K1pHTUJuSmFycG1US0dHK2tXTy9TWGJDVURydnhtV2MzSjdiZjJ1azBUR0ZG?=
 =?utf-8?B?WndmTmNQckxtR3N0TTNDUWtCMU9JNXF6YmY3MGdXZ2ppallUcllzTmw5Tmkw?=
 =?utf-8?B?Ny9yUU9pWGEzb1o0ODlxL1lKdWE4ekNkSFB0bUVQSUkzMDFUSTJxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae60643-1b77-483c-ae96-08deb87596ab
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:47:11.3781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7bRaP2F7EkJnxpkxCQcdwkhckNbynF3oQtkREyQpQx2Pbx7y1jBSvy6+a9EQSr4cuor4txO1WVCbJFWKmUBGg==
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
> Current code lets `current_offset` go to `BIOS_MAX_SCAN_LEN` which is
> one byte too far.
> 
> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 6bcfb6c5cf44..7bec81a37340 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -272,7 +272,7 @@ fn next(&mut self) -> Option<Self::Item> {
>              return None;
>          }
>  
> -        if self.current_offset > BIOS_MAX_SCAN_LEN {
> +        if self.current_offset >= BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
>              return None;
>          }
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
