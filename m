Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E49FB5191
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 05:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EF810E030;
	Tue,  7 Apr 2026 05:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NSmL7EX1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92DE10E030
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 05:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqnO1dlC4vdZOWlJFqbQTHmYdJiZOEvAWdXd67/9DjOlf/3Lne+82jPhi9qMhlxILb/yjVNsCknji9dhvFa1VlUXCNyBVGR6nU5pFSC3bZ4kCiK9jxNKDYg756SMtq0leG2X3Rkj/XCFmk+VdGDMsh7FKYxxdFlG8nxt+ocPKXIMF//pnewS8yNYk09PHDdxtN7wHAQjis9yAarjxyyvc6IWvuxn84C6n/9Y7GDEoTAvDEUEgMj1cA31Wm5hj+rkYOdg00OpZXN/fQFX/aPrNBFeTuuUXN+EXMQu3YXJ84bxc/nnmvQ8Cm6oanC857EWS4GKnMScH4RS3J+FaviUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM9L7ShSiNPfBQXBtKF9y+Yop1ZrASvnGxQmXANBItc=;
 b=q4sAz7I2cocdJznOs7V3E8uvpEQk6kVMA+L08o3CFOAkGoJg+R6JFfTGqwJQxJgQLEPFX/ghW8u1XCzJNZeRxq7xEnIzakZMLDDePMFlclqUB4bH8etZOMdgi97e8CO/09u9n+pj2e3u9yWOYFRqOnRb50Rh7COjoVS2XwS2T17wCsghflnbNPzeNQurlTwIIXosF5tbtoiGaN0aDW+GYEkeRhMuiKB/6RwWdQUVY7NgCd6K/LmIfovlsvgqF/5G65N81wcAp9s067Qmm7ouSE/k+dnlU81bO/VtPTjE1Ge/TBiFBRQTosyuU2yfU69i+3q9GKU2xhvz3b0HNwRUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM9L7ShSiNPfBQXBtKF9y+Yop1ZrASvnGxQmXANBItc=;
 b=NSmL7EX1W0nfKwmrYq4N//FvOBKS9XKKJSuzqCppdnhBu15Q9NJ9fMYIcj7Df5yYecaLlIMaIJPSMEX5FuZVaPt94ka8ksxLYK1T+pyg5Uh9Rvr+ItpogfveRb12SSv3wTrd6sCJKt5mqspdfGyBQ6kv/2WHhW7sP3p7O68h2djsIMFwyEV2oTTOEbwr+BjpfOgxm/fx9vD8fZRPk+SPzKWOihfhGqO/xuOYVfhL7deVz5ehT/9rN4jFoN3J2yafLU1KJw4MAuuCMvLvBiBcGKpaWXCpAcTdkGsr00JDZ+ZQNaUxVRPJeZ82LvUd9Z71bzagINqtxA/hi0gctGlcEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.12; Tue, 7 Apr 2026 05:09:39 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 05:09:38 +0000
Message-ID: <f8b881a8-d62b-4afa-9f2b-eac1c4e34651@nvidia.com>
Date: Mon, 6 Apr 2026 22:09:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: nova: require little endian
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: cadfee22-a38b-4f34-92aa-08de9463de41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: onktYbCQ3/Lhawy3JlapCW7OcIeC65enb59N/KUAqfYQFjmgCcz4/eD1zS6E5Zfy6sYhKvn85VavUUs+aE5r2XGD95bAjCSAdebyIyRQvJ7lsdm5wzHKNrX11ollG8DTAfN4XetK/iPo6yOT6MUBrcwwgw3cMK+Y6GqB45OwcagEpR8dzSCtpsIsmteU1oZWq0x/m94YaF6rwxAivcw38Hye0bzwl1yaIGwQBeRpP9xWOz5wU9JCcWhWtdoZN0ZwLjHQ4Mm+Ky9Eiyk3IJ7nTsFhQJD/rkTbyTm7pe6eowDObpC9J5oWKhWhgGeMVXiRsz/vc6pVcOZ40GJoKTyUMeb6JRDKdaHnwWX1gmRZouM7TOF+CNHgbvyyn11866m/UMkTFdnBDV4LuX/q0T8GAuTYB6J0b99qrx0yhdCeIt5wu42aeoyH2KSrR176IuaR5CkI8pCDH1OfR7Xv/nLitvaUG7Qz2stEQLbaP0V+nN7GDMBNA25TRsLjOmWbeYe9Ysx/5dlVuntXGtrtVPBLg0IGBsZxW6k3Krzwa2G1EKBqHSJnWuvLQ1ZpY/FvTGlCGH5fbJ6BiSntBWTx6OFCa8bR1YxawbBDsasH3TQXYp5qjCV4sdBDo09ee40JpNgHlJrabZzaQo628/sCYvEnVs1bwh+4QRi8vINRm+51qHuPJvB1J9NpcN9Lo7SfFr06RsXX8gNXYO1V7w79paGXffLENEz5bApUNCTu/qPbgpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czV6TGlXR1dOck5NYldqcFdBdSs3U2ZQVkdndDVlNUpqZGF2aGFjWGsvY2hw?=
 =?utf-8?B?U2pjOEp6RUlLK3RIVERjYWNidXVoS0xCaWttdWhuNnNmNkdlT0sveElPQ2d4?=
 =?utf-8?B?WmZvZjlmNTZ2R3ZRejFtS3d0Q01JWE1RejFnZlZ4a3gxS3pRK2plb1VheWZl?=
 =?utf-8?B?aldsUUpPQ2dkZG1uN09Zcm01Zi85NnBybDJIWlpza2dDZVBLdjN2YlduZG9Y?=
 =?utf-8?B?Sk9GamtuTml1WlZWekd3bSsvRE5pQ2JQVklnWUlSb1djOXVMZm44ZFNTSU45?=
 =?utf-8?B?TWYvbXptZHdIVkpndGtZYVN5blV0VjROVnNKWEc3YXMrS2NHNkI3WjByZFRj?=
 =?utf-8?B?d3JuM3NBcE5oUU9GZnNXL0c1YTdJRk1RWEtMb3pBcVFmbmlCYjZvdnlnMHky?=
 =?utf-8?B?V2JvS0diL2FwU2ZxZDA2LzROd1dWaWcydTc1cVdGN0JWaTRWdVFpQmlWaUFK?=
 =?utf-8?B?MUNwVlN1ZFQ3bDdWU1RLZzJiRnRZaTRuZnluWlFqV2VuVG1LeTYzOWVrZDlP?=
 =?utf-8?B?ZTdnbzZRZVFsTmY3bEQ0bzJ0M0RBOHBzdDN6UmpFWU9Fei9BU3pGL0hBRVc2?=
 =?utf-8?B?SjFBMjFtaDd1cFoxSGgreFJFdTBXd2JLQldyejlxdWhpaDYzTkptY3NMZWw3?=
 =?utf-8?B?cUJuTHI5endlTHYybEdBQTU1ZDAvODFlcHVzRDJmSERta2FyY2wrNWYyNW5U?=
 =?utf-8?B?WDd3dEtqc1ZNcW1td3Z4UndWOVFCSkdoWklRQmFmeUF2RFk1WWdLZEYxUWs4?=
 =?utf-8?B?azYwSk9XaFpUYjBtR0lIZm1hclREWU0wRGZnaEw2ZHgxUWg3azZ2ZE5LZG4z?=
 =?utf-8?B?Ry9UcHlRaVRyUFM2REs5Tnl5elFmekZJVmJxeW1qSTdDM0JJdXcvc3FSZGd3?=
 =?utf-8?B?cnJNelBCaEhnVFJmUzlHMDNSMnY5Rjg4RG54bzZrWGJsNkswRUtrbEQ1UTFm?=
 =?utf-8?B?czZwTEd4V25oaGRNRURYNHpZdG1wOUVLQld2YVZHS2loRWUyOTFETFl3ZGRm?=
 =?utf-8?B?UHRLMXFZdXVLcjBKWW1ZWXZQRkhJS1lJZWFVUzRFSFMrMmhidFBlZ3BIR3kv?=
 =?utf-8?B?WENHV3dFaHMyZW15WlVLOWRpZXpCVFBmNkh0dHhObXJzRnRMY2ZXWjFNS28v?=
 =?utf-8?B?dnpRTjUvd2phZ2RxSDV4YUZBSFVHY0JPeU9aQ0ZoR0xZSCswY0YvNE1LelRT?=
 =?utf-8?B?dkJDZnJDcVBzamQrbHNsbHUzTDlOcnBQc1Jab3U3QjRvQnllckdCSnkzdkww?=
 =?utf-8?B?Ly9oQ0JFZE9NQ0pWaU9FSGUxU0RlQSt4bDJxd2tXa21pYVpwdzg1dzFlSEpB?=
 =?utf-8?B?eklJejhBVEF5ZytWRGdoLzBwUXh1aG1nVEx2OERCbmdOOWJhU2JES1dxQ1Jq?=
 =?utf-8?B?K25mbWJKdFc1aWR2bEJXOCt5US9VNnhWNHFKd21NTit4cldsZVBhQ1l0cVph?=
 =?utf-8?B?cnowREdqRGVNeUs2ZUVCa2FzWHY3QytzNHg5QmNUdjNEQ0dhQVdOU0lralpk?=
 =?utf-8?B?WFdiUFk0NE83V1kzTkhnT2tkOEFMbE9zcFA2SFBqSXgreGxrd3JaZFFqQXZx?=
 =?utf-8?B?SDMvOHJ2OEM1RFU3a2xqRmx0SURPdSs5T0JWNEpVa2phdUdJa1hHZ1cwZngr?=
 =?utf-8?B?WEtCSnp5QnpwSEVaeStPZkM0NW92Um9XODhlRExrUjVSWlBTTVBDUVZ2MzJa?=
 =?utf-8?B?SjU4emJrYUorSFp3eWt5eXdRZ0g2Mzl6UmtPdmdiT21RMlNBYW1lc1lvTEJ4?=
 =?utf-8?B?a3QvOE0vRTFuZWVtSlJlQ1NaWHI5QXNTbVowNTJsb1AwWGNDNkgvNHVrWHB2?=
 =?utf-8?B?UGZkZUdrckUwSmlhYlI4UHdTMXU0Z2U3Nnp1dnRkV0s3Z3poQklBU3dCeVQv?=
 =?utf-8?B?N2x2WUVUeTBuTGIzNjZtWFY2cnFrbzFUMDZXR0djWUN4Q0wvVElTZ3dCUmZt?=
 =?utf-8?B?ZEsxenJCVkdpVm1UOHBiUFA2NzZXa2tuekNBODQ0aExOQzd0VWEyb2lJbHFv?=
 =?utf-8?B?WEMrTGozVkF5S1F4TDVuYzVTUCs0VXdwbXk0aWlQQjFZaXo1eXhFdWx1Vk1y?=
 =?utf-8?B?WHQyUFpEeDEzL2FBT2c0cDNrQVQyelJqWHE4Zml5cCtDZEZoYjVKYXZ6QlBC?=
 =?utf-8?B?QnM5b3ZJUzVtazhqN3pFSVh4TGlaVlQrY3UwSnR3SjQ4QjhLU2NkQW1rcXAy?=
 =?utf-8?B?WVR6cENpcjFWWTFNbFRrVG5BZVNsSTBsR3Q0ZGlqbVE5cCsyWjJ0eEp1MmRu?=
 =?utf-8?B?NzM5MkF0UHFGMFJqN2Q2TnJnTnEvSWN3OHI4WTBXN3dkUHN3KzI1RXdHdisx?=
 =?utf-8?B?TzZzT3lzNFRPQlFGb3hYd3FpeGM3Uk51bUt0WHBpWVJkRjhOeUNKSmtpdGxW?=
 =?utf-8?Q?KiJfU6V/5Gl+9QgM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadfee22-a38b-4f34-92aa-08de9463de41
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 05:09:38.6809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roOMMbXGHO5xyWKwY/MPTBMVZRNfxyyLVsIAUWDWmH41JfWQWutFm1uowMnmfZtXjDCPbPrn5CxrSOi2x4nW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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

On 4/6/26 8:59 PM, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
> 
> Make this explicit in Kconfig.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
> 
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
> Changes in v2:
> - Also add to nova-drm (Thanks Danilo)
> - Did not take Reviewed-by + Acked-by because commit changed
>    substantively
> - Link to v1: https://patch.msgid.link/20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com
> ---
>   drivers/gpu/drm/nova/Kconfig  | 1 +
>   drivers/gpu/nova-core/Kconfig | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova/Kconfig
> index 3e637ad7b5ba..a2028b8539d7 100644
> --- a/drivers/gpu/drm/nova/Kconfig
> +++ b/drivers/gpu/drm/nova/Kconfig
> @@ -4,6 +4,7 @@ config DRM_NOVA
>   	depends on DRM=y
>   	depends on PCI
>   	depends on RUST
> +	depends on !CPU_BIG_ENDIAN
>   	select AUXILIARY_BUS
>   	select NOVA_CORE
>   	default n
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>   	depends on 64BIT
>   	depends on PCI
>   	depends on RUST
> +	depends on !CPU_BIG_ENDIAN
>   	select AUXILIARY_BUS
>   	select RUST_FW_LOADER_ABSTRACTIONS
>   	default n
> 
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260406-fix-kconfig-3a059f622697
> 
> Best regards,
> --
> Eliot Courtney <ecourtney@nvidia.com>
> 



