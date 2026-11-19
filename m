Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GggIW5gk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0771210E775;
	Thu, 19 Nov 2026 05:22:27 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C2F10E733
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyCDVuucuJ+AMGwQp/BvGSvZQg0SJdwKR2i4NUNUDbXNT4d5FpMw6tr6YPrwiy0kdgAWvgEM5ZbfcNuhuJ0+uivkcSSguxcu/rgMxEAhYdMaoI+wmczvfaiSJESxbF6JHmOd7NWB6pTkrEZgutKO2HOd/lU3xsB6kK7gAk3xciiDyCDpFsxQ6MlESx0IjB0khA1K+D3+gGOsPDbTn9Mu7f+rxmBZSrdJGuK3YbyL/QpbYww04645xyhAuA2dcJIUgQl21LivTmUpd+4wDaHNrl/7bH60nBh4mzWhMeUtkZbMMWRTKWaejwxV4Ru826c8siTxX4RVIbZHL9Plik7apQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCmtMNTSs5B7Y8aKIJVPSuTIPiVdKQb88bK9NegugJU=;
 b=AtYpBkKyNy/Tb6MpafrAOM+xcFE1Hy4tLTFRXM/5t/vP1O7ZbefTWLbEkpIEqhcLcvcDxES0hNcicFguwfOerAix6hZUs02MQJyJMdURAuXTfJUOiNtKd95UxmAhPdZArF1axiSDQ+qAlJ7C87IFgveFZW1XpyQ/V1Q1OsGr86PG/sNcuhvy/bVDejQpr+hlbUZU0Hfhm9MVWe9fsAN3kikZjSrfb1ymZ5PkWqq2WFdyKPfRBB9MCnnE00iFJ/3YTB5VJHaCP0AauqXkgpvMEwP59XfcS21ymRzYI6zRmqT9B/e6dyZo5Kz9gnx6brZulW8FQ1dy+RUCO6D+q33yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCmtMNTSs5B7Y8aKIJVPSuTIPiVdKQb88bK9NegugJU=;
 b=GggIW5gkcCRxvXB3ktZxHlHFkVgsPtHvlcrObfb1zXUcorsvEPQAfU8JwCqbpymJ7VpcbTYy4RIJPjHNIzYGfqCHJkRNKyK+8BsSa8dT0LXsHuhGukAcG6qGYvRm8GlopNEpv8BRG6Bjox83DUQFaiTEu3I716wAgoxb0B2dOjH5cqMIjHsZ6p/Mopps3jI+6GGkLfgecVhFU9fFdco8eeg37ZPgtLVljwUdNwH9ywmvQ33MVG40FQYvxp5V3rjsxzXqCtIbiqyzd8LR5nCePa5tcORIoM0qvQt9/zX9bOJYT5TYc1F8Z3kpGXE0OciJ807OhHi6zukfYyqD28lszA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 05:22:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:22:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Sang-Hoon Choi <csh0052@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH] drm/tegra: initialize channel context before publishing it
Date: Thu, 19 Nov 2026 14:21:48 +0900
Message-ID: <jPXD2u1JTf6jvKEETDBwsA@nvidia.com>
In-Reply-To: <179001455907.44752.8291506500067688174.idr-bug-37@gmail.com>
References: <179001455907.44752.8291506500067688174.idr-bug-37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f107e43a-97ba-45fb-c4ba-08df45fd0b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|261022075727099003|261102123227099003|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: sKvjT8BHjoNJJic7ac2JTPazje1zDEVOkhdWigs6cDT9gaPbbMiaR8D4f2JMH/kwQp5rHskB+i5lkKB0fjvAVV4OezbNltWkxJjXy2fsset6OWJrJsD8Lfwc1l3/uJLgVCcyiaJeC/zbqtpcVqcNjbzdNKjXmk+J8j004mpWC9u4sACr+dSab/X1alxsm+GV0RClnabOej++qKSr07ha4D0VgUWD+dg5yk2pHfiofS3OUShnmwuCjpKb0VMvx9315bF7Fbnqt4vVTlg3yteBZat0EkS6/s2vBC11cayuaRfRJaVQ6NkDPKw5+Sr24xJtJh3BR850kiXeClKVplJdQvKIwi2r64PRILs4ejRl4AkRwGOMp5CgUYA8vvlW/ilipe9q+F9CEZU3JDzrhZ14kqCLXQqT29vM+p1ZaOred55YXlac8J88yWYvxh/c1kcSHkZiIFAd7+vCl6lkNUjnFuLkTKAsaVTB5Q7Re6n9jCCchI5G8tAMF/cQPmfNiqyDO++wJVLf2cXawGxW6gkNDKiNiit1UwVgHlrx2tSw417zHGajL8/QTUR0fb32VeenZh+OTL+AW1Wrq9bX/JcMGezTIp6MC2gjNl3b29ktHFEPUQhmMv2bCpsXbdUjRxScGe51RuEo0+DoqWPCX2EpnkpPUm5a0Whs6bkN7OG8llc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(261022075727099003)(261102123227099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRBUGltMmQxdUFpQjFEV0NpWk5vOUZRY21jb1ZSVFplSk1LWTc4TU1wa1dk?=
 =?utf-8?B?a2xNdlVBcGhCTi85UHl1MERmK1RNN2paYlM5bGN6dzFUM0NrRlAyOWhtTzZG?=
 =?utf-8?B?OGJnUCt0c2Y2R05NZWJzRUVBT090NFdjS2dOdTNPTDVraFVTMzQwdHZCUEhV?=
 =?utf-8?B?T1hOTXBhU2g4N1UvbzlJK1p5SnJTWkJXMWdVZXIvMFpNcXBaeXdmT1VSN3Jk?=
 =?utf-8?B?bnU2V1ZmOFVLZWhiS20yT3FKaGh1MSt4L3ppaDAzYTVPcXF0Zk94ZTYrbkdu?=
 =?utf-8?B?V0VCOGg3VzZOdDNUY1QxWGErSm5hM0hLMHZFRDgxSmFwT2RjemhuY1M4TFcx?=
 =?utf-8?B?TDRwUGhGMVZWNFVqY0x2VGFVZWtRUkVZTys3UU1pbE1iS3M0SCt4cFc1cUtD?=
 =?utf-8?B?aE81QmE0L0lMM1psTE4vL3NJbTM4bEEvYmFacnl4c3o0TWVQSTFVS0x5MnJK?=
 =?utf-8?B?MURsWGVrbExlV3VldUU4bnNVaXZ2Nlo0TDFFbnV6TG0zZDVyK3pFWXhqVUEw?=
 =?utf-8?B?WTdXWVJXMlZnQlRuWDRiWTdUaWYxcDVwaUNGc2FWUXV2bTJFam1PZ09qZ0Q3?=
 =?utf-8?B?YnFTQ2hacmRBYmN4a3FuK25rZjVjQzF2eGszZXhqLzUzNVBpYkNUVE5KQm1T?=
 =?utf-8?B?UzJmQ1NpazdCbTlCVFU2d3d4N3pscHpyQnRwaDlxTXRoZmZTTlRoWnh1S2g2?=
 =?utf-8?B?K3RIajlkVG5vL1dSQkV1b0pZeVZGVk80T1ppajd2V0hJL2hFMWdaUUxLV0Zh?=
 =?utf-8?B?a0xiOEV5S3NhZnBONEY0anh0WFQyQ1NUSUJ4YkVLZkxzTWtFamtzSjNnS3Iz?=
 =?utf-8?B?emtjOFh2RjFzT1J3VDU3bU90S0ZGYkJSRWx5SjBHS1Z1TkgxR2phY3AyM1NQ?=
 =?utf-8?B?YWRHMVROQmQ1NGZTc1M1RUJYZzRwdlVqZ2dHRE9IYk9qcmVvSzE5bVRrcUZZ?=
 =?utf-8?B?RlNPVGx1SzhDV3lvalpmS0RDS1VGYTRIelJiNmNoSE56TjhFWTFMNmxYN3J2?=
 =?utf-8?B?Qm1QQU50aTliOEVidmR0eEYvODFyaGtmb25QazNqemhHWkJqOHlxdTduclRq?=
 =?utf-8?B?WXdKTkhKOUxPTkdGcDZRN1k5WG9LWGFkMVR6OEQ5WEpqZnI0emVMdVhhUjZX?=
 =?utf-8?B?d3pIVWRDZUtzZVQzYXVoMDFlUzAwd005YjJOdEZrcTI2UzMzR2tRQno2VVhh?=
 =?utf-8?B?SXNzU3g3eEU0WkNsRTVRUUNsc2FMK1N0bnVkMlEvY1VRZDN5SUEvTndyeXFm?=
 =?utf-8?B?VGFySkZQL0dMZGJaM0NTYjZ3aHI4TXltYVNTNGk1dVlmUjFhMlBBV2Z0N0VK?=
 =?utf-8?B?S3dybytrTDB2WXZNQStubTc0ZEw2RXR2bk5kOUcyazZxSlVvT1ZOTXhZNFUw?=
 =?utf-8?B?U0dNZk5JdWFJRzJqTWFmQmVSTEtGbnhzdytady9acVVPaExLcnd4bGdXV29s?=
 =?utf-8?B?MzJYc3JKMjNYSFFJdlpRNFFRMC9UVXlMZWJLTXV4SHVXa0E1TnVFRm8vQUN4?=
 =?utf-8?B?akRXWklwdzNrR21lL2JLTU1HY0ZmalFma096UFVKVVBpak5wV0RBbkdlL3ZJ?=
 =?utf-8?B?Q2MrclB1YVZGU0RxY3RhVjFXSHR4UVR5NlVhczVTQVV3K0lKNXpqcy9QOHdj?=
 =?utf-8?B?cHlPcUhNcXRReFlJZGdJRGJuRWRGeTdLK0djOFRmb1lwWFI5eXVTU3Y2U3F5?=
 =?utf-8?B?K1hLd2RQS2xnUU80RCtWc1ZoRHFRckNhUGFBYWlzanZ6dUxzT3BFUjRjTE4w?=
 =?utf-8?B?NFpoQzdhZHJTZDdIazB3R2N5enU3L0ZQOWh0SFRwNTRzL002alErc0g4c2JG?=
 =?utf-8?B?L0dLanJPYlhPUkNOaTdlTUFVNXZ4bHhRY09tSmJTUFFTOFFhOE1kUnVuU25B?=
 =?utf-8?B?bXB6ZjBtZWRWVmtMWWQrS1RjbGdWVHg2WTJvdW82ZTJicStoSlQ3OU5hdm5K?=
 =?utf-8?B?T3c4OWRhNTdDWE9TZFZLNk8yK1pOaUw4Y1EyRWtyR1dEYVQzVEg0VWw1MGFR?=
 =?utf-8?B?dE1MUDlNMkhvMnJVL0JiQWtLeEdsM0t1ckdIVkRYWEw0K01VdjUwbTNjODFh?=
 =?utf-8?B?cUNzOXJiQm5GSDlDNWpsRmdWZDNid2sxQmpqY1dTcTFXRzc3ZHRnR2ZxSWd6?=
 =?utf-8?B?Yit0ZkQzcXdSMkhxcEw5VnlxVEdQZ3AzUU5aTC91elZ2WGg3WE8vZVRNTlVl?=
 =?utf-8?B?V0hiZXdPRjlNKzI2WWg0RHZ6QmlzT2tPOTg4SDFvbVlBbXRmZS9VY202OFlU?=
 =?utf-8?B?SE9zdWROdUtENzNsUGduNmtJTXMzYVFMZjRselBEM0ZFSkRCeWpHejZ5WDZp?=
 =?utf-8?B?cnRaZkcrT3ZZSThPRHhSUHpqUG1TR0g2cURmenNvTEh0bEZsaDgzS0I1TkE4?=
 =?utf-8?Q?54ICXfjcc1OuxP9/kVMI+Jm19WUpMkbyUFdVJemkMs0+l?=
X-MS-Exchange-AntiSpam-MessageData-1: qfHeWxnc5d8wlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f107e43a-97ba-45fb-c4ba-08df45fd0b35
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:22:02.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PbV/35SlcHvuuVAI7pXX5gV5352hx9uZqW6iSNke4PgeqFV+A4BqOA1XWqHAjyhUuYhWdohNe6aQLPRzcEqeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday, September 22, 2026 3:15=E2=80=AFAM Sang-Hoon Choi wrote:
>=20
> tegra_drm_ioctl_channel_open() stores a new context in fpriv->contexts
> before setting context->client and initializing context->mappings.
> Another thread sharing the DRM file can guess the context ID and issue
> CHANNEL_MAP before CHANNEL_OPEN returns. For example, the first allocated
> ID in an empty context array is 1. The mapping path can then dereference
> an uninitialized client pointer or use the mappings array before it has
> been initialized. CHANNEL_CLOSE can also free the context before the open
> path finishes writing those fields.
>=20
> Initialize the fields before xa_alloc() makes the context visible to the
> other channel ioctls.
>=20
> Fixes: d7c591bc1a3f ("drm/tegra: Implement new UAPI")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Found during source review at mainline
> 5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchange=
d
> at 93f51579e7df248780214094418f205253383cc5.
>=20
> The modified uapi.o compiled in an x86 allmodconfig build. I have not
> tested this on Tegra hardware and do not have a runtime sanitizer trace.
> This concerns the UAPI guarded by CONFIG_DRM_TEGRA_STAGING.
>=20
>  drivers/gpu/drm/tegra/uapi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
> index c0ac6b45f..1dec2f0ab 100644
> --- a/drivers/gpu/drm/tegra/uapi.c
> +++ b/drivers/gpu/drm/tegra/uapi.c
> @@ -135,14 +135,14 @@ int tegra_drm_ioctl_channel_open(struct drm_device =
*drm, void *data, struct drm_
>  		}
>  	}
> =20
> +	context->client =3D client;
> +	xa_init_flags(&context->mappings, XA_FLAGS_ALLOC1);
> +
>  	err =3D xa_alloc(&fpriv->contexts, &args->context, context, XA_LIMIT(1,=
 U32_MAX),
>  		       GFP_KERNEL);
>  	if (err < 0)
>  		goto put_memctx;
> =20
> -	context->client =3D client;
> -	xa_init_flags(&context->mappings, XA_FLAGS_ALLOC1);
> -
>  	args->version =3D client->version;
>  	args->capabilities =3D 0;
> =20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



