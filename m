Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53ACCD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A67810F74B;
	Sat, 23 May 2026 03:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppvm35wh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0139010F74B
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXk7aERT0tZLl9lD5jiWWUQf5QfYUHF4lBgNBCQmTc/wQzR+7TipzMY0VKMRlQyGV8RrrHQmElnQ/1/rEyq4njwed2ssHGeAz6qtqSunJ4HqSQ0kLBPgq8gIEriRTSHDH44gQzXK/imUgsoeiAQv1j5C4XYq0o6fxLJ0MfB93nDd2eA+CE/srs50Zd543QHlcfheuDJ2uZ6Gx9dmiiQNEL9S0SC7TYtNT75h8J9zu9ZQQHUGeEnu5N7dvOzEQeFgwPdA3KCZEAeraykvqCY11dFHhLCM+kMgODpQqskz5Jfox0mRY05FNC65ImFrSrT9kA6mmkEATMaJdymM7jC6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HESmx36/vomxR7LwVzhCSjUA/r95N41+7q+CQeflycc=;
 b=hMfGGo0wislhqenU5ulEsuvt4cgfR7NY3NBBketlork8+X5q61vWQAQ5Lx0UtYfbGfAZ+N18nUZ3yiu06FEykHVvkWXmbdRDnCJX8eztVJy0m4iolgumYmnyVIuA2n6y7+waClCjhb+WvgrdsjbtjjWHlo+lUwGBNfiqLUXgt9DpYSHgAnYDF5ijNbKN/a5jmxRXiVS/pzqXXTJLEdk77sd1cqHLGdynTBJHSmHtGszOGVY6RHe6vjmAgQT1uaIHPTIZO8y0+BsxT+IHskSTt9gbOxGn5Kzo3Jclz/8XMCBNdmfv9rVu6wRWgg1E54TBNWLiGyYTfu6kPVNF48R8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HESmx36/vomxR7LwVzhCSjUA/r95N41+7q+CQeflycc=;
 b=ppvm35whzhpJesTRVIE3KB3RhkDY3jY5018Yi7fnrnUzinpSRyqat/arI7uVtmLTdUrwKtsJDEl8/9g0jgQe9L5OUeGKaDiJ0TqfeZ+/yuZz166G19peMgdsuRZ2NBHIoSHH2cWchPyVGTCz6uZrpqQ+PIdOUY6OAz1Vv5wPFMzXwQp2QxqXARrVa7c/yyh9Mrryia2O8wbO78qmgvTvO+n5uJp2I62xGNf2NAqFJtdfvj7tMh57UV0vrv2CfP1WQ7Bid3vxiPx37eoBTJdS9El9Jb7WYBPlzGDrYOrQKPsRIiUarGorU6phjfpkYArR8KoME+SG5iol1xNsDLbJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 03:06:12 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:06:11 +0000
Message-ID: <df5de969-d8da-4641-8c68-27a7398cfef0@nvidia.com>
Date: Fri, 22 May 2026 20:06:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/20] gpu: nova-core: vbios: drop unused image wrappers
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-18-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-18-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8058078d-f37b-41c1-b9a9-08deb8783e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZhzbOw8DTug21JnL8JCkXci/hdt5iWcS8e/dDlWCXsrUCCCGAFYnW0aS1/AKSgCfkFkNXn+G4764qdWTbEnwXxYeFXCZvy3oF6ZCjqMEkjzEcpkhvHAbWjpkt2qfbS9DMabGtZXXHR4mxZt3RK05/Cssv2LRzbHHQUJ7eurlopAyU3oFFqun+LoRbSqDMy13wEfSntMHOKx91QkYGV6O2iA8wL7z6V6yZFg2YTvF9udM9bJgLJjVQs/Kw6SnkmwHVS78gT/Dvwur45Ob2oER6BMFmJH0kc6lr26Q/EYoK1w2YHDBR5B3uixj6kLjeAELLpKIhp+L1W/ZD3og1a2orkoMw7maqh8IK4SpigHv1MAUZA3cXsphn447eZmUclUaatyf0gCqBdwWfQ5YS9tTpDFOHFcl4HmDpD2sPLMlC9TOAtUa9Dn9C2KIWuvbARDmgmbNR5lri27XXYuV2dN0/2tSLvJGGJJEowgDSaSGX98C2eWQsUs8w2ckQJTxlxUZRlgb+yS7hJK53/Wd7G1IgfKkXsP8dFLZqZW9SP7m7UvH41yOuEP0gSeBpFmw+5cTIIBGUfw/KxwFNi7s/3kw5tEWPgVkRBK2/ul15cW9fA83memGowfpZAjNsqlc2GVCnD64Iv93d+70ZVopo4akdIpJWl2e0ik3lozHl79+mZ9JMl+pKM4Be3CMzUEHUCqx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9WYjkrTHM3VWhPSjBHMGd2Tnh1cmo2VVVoOEZQcExzb0grMmVpK3gzT0l2?=
 =?utf-8?B?eThNUUc5QllQY1ZSdThRTG5BR2pjRU1abUhMOW9wMVdMdjM1MjZkVUlTK3hj?=
 =?utf-8?B?RHpWaUFXZlFxTzZmb3RUZnUzWG9yN1JrdkJDeUVBMGR2M3poUmJWN3lESTg4?=
 =?utf-8?B?bTJqOVdRaEE3eGdKMFVFYnRidkJ0ODY4RFhxNTBXZGRoeWwvU1kybGRkSkdO?=
 =?utf-8?B?V3RKVWQ0RmtoRUtEZ1dQWWtuY28xRUNVRHAzUlpMSzJiR25uQWJSQTlxK2ZI?=
 =?utf-8?B?ZVR5NTQza1pZLzFwMXloTWx1cW1vRFVFT3h1ZjcrdUpGQ3VNSWFOVnFJUlJI?=
 =?utf-8?B?NHZPUTNOWjd0Nk1XUlNBTTFDOUovbURqb0FZRWVCamYwc05KUzJJSDg3Z3VU?=
 =?utf-8?B?TlZtcDk1YVVIK0hybDV4UlNMc3poZ3A3ZWI2SUNTdEFVZ0pwaVJ6cmhRakNo?=
 =?utf-8?B?VW1uYThYeVFRL0dQR0F6cFU2SS91Nkh2ZHh3U005MXNPcFd0dkIrZlZtZE95?=
 =?utf-8?B?d3NBNWNYWEV3TDM5c2NtWWh4UStBbG9FcXhyWC9lbVQxNldCVnpKeDNWelNs?=
 =?utf-8?B?eHk4eXBQMVhYY3JpZ2s3eUUwNHY1Ty95OHlWVi9ZMnhTc3Z5bTMxNDI1cHhJ?=
 =?utf-8?B?OTduQm9jMHhhV0E0MGsvSUxMUW9mVjVwYlh3MHpPeHQ4VWs5NDV1UmJydVBv?=
 =?utf-8?B?alVhZjMrdEh1QWp0UmJaME1HUW5nWThvNDRGQXgzWkRGSmx1bkRWWlc2OHdH?=
 =?utf-8?B?NkNkZjE4ZUE3K3NnbXdLNURaRjBvVmVCMWpKc1M5VGRPU3Uxc2EvRzVNeUE0?=
 =?utf-8?B?UkhFdEJHaVhVSjhzY0FXRHUwR2ViallDQ1pjVkdjS0JVVG53MHY2UXBCVlRB?=
 =?utf-8?B?RCszWHJXdHZnbDVIZ2cxS3o3S3c4c1B4QUYrZE5sWkRyRUliVFZxM1BxcXhx?=
 =?utf-8?B?dXFwNzJEQmNIQnVBWHVkU0MrdWtlaG1qMjI5b3l6Q3BNODVXczF4RzFCb3Z3?=
 =?utf-8?B?Tm9tVkI4REx5STMvR2RpdTR3NkkwRkNkWnJGODRYYnFES1dsOTRJUWZCLzI1?=
 =?utf-8?B?ME9YNGhuM3NZb1M3bU1qUkVleHg0K0E0bloyRmhTcjNIUGJpT0hzNnhJeng1?=
 =?utf-8?B?OXdUdjc2MDA2VGFyVEM2NUQreFRKbVcyMExuTWpaYmllcnkvOS9XMjQyRi9n?=
 =?utf-8?B?a3pvaSt0bDljT3lIUU9PSHU2TDNxeDhqcWVvSnpJVFJwUDB3Y0p1T01MSHhC?=
 =?utf-8?B?cUs0cUJQVjdLR0N6ODgyRkxkNkNTL2VtazVjYTlwYVhaY081elQ2QU1yUTcr?=
 =?utf-8?B?Z21weWlDMDRkbWRhL0hwdEJYNldWWEIyMU1SMnc1TEZiUjFHOHRFd2M4VEZ2?=
 =?utf-8?B?bGhCd0tPTjZQZHBQVWVGMXgyYXFPcVl3K1BFTytDMTZldlV0OFAvZ2J0V3U2?=
 =?utf-8?B?Tk94QllSRmdLODFTL1dCTnJISlFoWDFkblF5aVFjQWZTOVhUU1V2MEJ2UFpN?=
 =?utf-8?B?QkRRU0JIWlpDT09sekQydDRPN1dmYVdXQ3JUc2k1S3VDZy8vRVhRNUNFWUh5?=
 =?utf-8?B?TzRMeS9lT3RuMlI4c1hBOUJ2b3dnQS9iQTdlU0JPNFV4RDJLRnJSSFlmUE8v?=
 =?utf-8?B?cGlqeTdLbTF6YUVLMFJxeE9WakxHZmpuS3JlWkNQY1F3alZKVDFERkJISW9Z?=
 =?utf-8?B?ajBrbEtHNUZTMkxnRDJGQ2hwUGQ3dGZWTUgzMkM2UFZtNm92bXVWVTY3ZTcw?=
 =?utf-8?B?VUxMNHZsVVB4L0hndXdWNWtHL2kxS2FzR2laVUtrY25rdERQNGJxNGp5eWRT?=
 =?utf-8?B?WlQvdVh1V1Z6alNpL0RSbzZMVHlybXAzYU1OYUNQcXdCQnhVVGFhN2dzaHlS?=
 =?utf-8?B?d3dicE1peHNWZ1RzaEZLOVhZd2haTFZWOHA4b1RTenQ0L3gyNTd0aTZYYmcy?=
 =?utf-8?B?bnlTVi9hMEl1YWpXaE1qTHFBTGxyY2NZSTdMRERtNDFuZUphMWVJT1YwUWdo?=
 =?utf-8?B?ZDIxL3RzMmNHN3pOejlyeENRNHpwT1pNMjV1ZGlKcVpIZmswWnl1eS9LNXhj?=
 =?utf-8?B?NU4zRC9LeGQrS0dONnVKOFl4S3hTdll3b0hDaTl4VG54eHdtcitSTDJxeHdM?=
 =?utf-8?B?L3UxWkN2QXR4WDVOVCtOd0dkV2ZBUWtrQ2RvdjMrM0w0QUdLemxodTYvM1ZQ?=
 =?utf-8?B?ZlhEcm51K01NcjFNa2FZSkR2UCtPUlhzWnpyc3hwMnlncWl5RzM2UTdrQW5F?=
 =?utf-8?B?MmhVaCs2eHNCS2djSVdyNkNGemVnMktqWi8zdnl1cHhYOVJCZmJHT2YyQ1Ro?=
 =?utf-8?B?dHpIT29Nc3dWVVVpVVJaalYvbFZtWmVYRUlEWGl4ZEY4dm9YdEZtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8058078d-f37b-41c1-b9a9-08deb8783e02
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:06:11.0883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YbuSu09NRaiu8omvvv3ifGmowSWGrYIgrj2LSGLJWQ9jtyt3Kp2gA9UdJcBWr/KTw5Yp+1hOj9SnGZ4wW1Sfg==
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
> These are unused currently, and it is probably sufficient to just check
> the type of BIOS image in the future.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 1dca7933fac5..ad571b39400d 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -669,18 +669,6 @@ struct PciAtBiosImage {
>      bit_offset: usize,
>  }
>  
> -#[expect(dead_code)]
> -struct EfiBiosImage {
> -    base: BiosImage,
> -    // EFI-specific fields can be added here in the future.
> -}
> -
> -#[expect(dead_code)]
> -struct NbsiBiosImage {
> -    base: BiosImage,
> -    // NBSI-specific fields can be added here in the future.
> -}
> -
>  /// The [`FwSecBiosImage`] structure contains the PMU table and the Falcon Ucode.
>  ///
>  /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.
> 

