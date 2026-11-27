Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFC606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tsYiaz6h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D5010E220;
	Fri, 27 Nov 2026 04:56:51 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A886810E289
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klkNnOZS2tI8j7BcTt/WQ5SJ/3Z2Rln0/hkAZEQBKHbNNTWLOu5RzIzgWdTyWDyRPL7QmY5UtJTqP+JFBCQsXz4+6nQzNL0FbOq89oYLrHECatNozhskxMx97uJrTp8rhZ0nqsIkGmfPYP53ceIHCqMCJ8EvltsyH6ZkJ9QRT1o4WmVQ0i/n/HQfYRcejRU4thFNyTHKp+lRfsxjpec6YeF7mpzu4kvl0e2tD/TAyhM/F3x5++xdOYlPTRCLstRu3svNLqkdcEXpjIUZ8m91lTdQXTpcsJbEH7t8KHAzDeYOBal+kkDg39n7X+nvaatKu4eFn/LJJ6IYX0svrJk3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irGQC7zuBG+4smKYfdjZ2ooZS2o+R8gHo7UswdRdjHA=;
 b=Q89rFZ8l4o7iE0FQQjrihqs/1TlvADDiTyhes0XAzQAcFEfq36tyds/o1I4eAnW+m8mvAiDCj5atU3w3gtdnORjN/B1o65YYe/0pdc9CVxeK6kTEBmAgUUF8FR9jpHoxBAivVlvVzspTAorc7THcucSpgpAK9jWZuVe5TwJg3g5DIFrFn/YJjd9ItLcqp1bCFRpIF7EULaao/4Z+aMIcb7Ng/EOJ+diiT6931YYf+SnT1pbKmPQ4AQ5qPzrja9Spul8KMt9aJ9qnwV9BbswyxmvRmUuKw2oT9U21xQnNdj/MjltuC685KtnrhhbZ2PyXv17ebXy/6IdGeTnIbCrQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irGQC7zuBG+4smKYfdjZ2ooZS2o+R8gHo7UswdRdjHA=;
 b=tsYiaz6h0BsQOClzJWDkZkBKIsTRUBgmioF+A9H1FnoW3rps4oGEdhn6evHtHH5Pux6UqvlUIZIovCufBsrpH6x6/MUG2O35XTd79ciYTCrm7/UJAbIHoHRKCcX/OezwOEnlDHr0XvU1MeplnzFJxPGLTnkCgYeBrjiMU5426da4kVdul6RMjc6TeckTmcEuDZz3knvgXDKhObkOCEysCpCG9LUn/5hoCtdSpNUuBKLXVfLF6mfK4moiuntA2bHXmrRcdQqOnnV8qFiHWNWFa0LHARpY3jtCGSzI6hWSIU9ZkMCPWvqbjE9FiAArFwWdM+o9SJoeSyBUGCyOaeDmJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 04:56:41 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:56:41 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 06/12] drm/tegra: dc: Add elements required by Tegra
 MIPI DBI
Date: Fri, 27 Nov 2026 13:56:37 +0900
Message-ID: <CQmBXmddTJ6v1iTnbDfQLA@nvidia.com>
In-Reply-To: <20261122081820.53199-7-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-7-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: f977c383-df6c-47bb-5acf-08df4c42d381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|10070799003|376014|1800799024|10067099003|4143699003|261026121527099003|56012099006|921020|11063799006|261009223027099003|261021121427099003|261022075727099003|261028144727099003|261022105027099003|261021123027099003|261102123227099003|261026140227099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: SW9VDjEmkl7VSL7BYLz/XDrgcb9roIs527kEqeGMDFXXZczd8qIpWEAkXPVBz7meXkNpV0GkR3GhsJa5T9rHywVEdZxiVc7kCtMu+CP2DkTeR6YMa5KOV4+g7YnI3lOBdq4JX2q7Gwu/2FZ9lDmCZi1KDUiBpAKh40PNLSnx216E9u91P01shx7G0ptUoErncnpGaJnUROLUCttiihtQMITM73F3BOQbPcqOefTdGnXvknimaX7Yh5S+CzuQYx07PY76+SLGD5jzwpsx3d9fpmJ7U2iBeLgGUGNr9ybv6dwGMifv4bCtWNoM/K3waPP13ceOTMOHv9mE8JptfQn9ye4pPGGdOR1yjWu6/WY/aHZJ/5iCXh+wdxKiSXB+Wnp2LYuAqw2krwJAJDxAILMtd8yEe4+RBKhijRIVtixMivXh7y3fEE7CQ4OZ0EZ3OH/rqjW6xN2pYD7kkhTQtytj1w0EemDnvX80b/8meUtQvRVDMmsAcqxsV9wvVYW3IWF28rFeIyVwylSx8NL/fhIFZqPDpvUor1cAAiKgUz892Orl5JhPAXbuh8d8TWZISVVFICPP3Q4naEBe7fnUebEA/KqBB/Jn15YNKc+GLLo3JqOuGqp3l2s/wgk65mfhJogWLWJQpmDS06ID3MT2fFHACc58yXPSh/OaHQLsSbFmTyQATXnuWq5t0yQZhLUFkOTbu4ujLcW12u5QQlaaIuiuRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(10070799003)(376014)(1800799024)(10067099003)(4143699003)(261026121527099003)(56012099006)(921020)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261026140227099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1c1TzhjYXRKV1Y4dkZIa0VySkJwYk91KzVneDdUN28vbjAyVnN2YmJSOHpL?=
 =?utf-8?B?emVBZW5seGRlUzIvY1NWOU1jWElUZ1dTYWNxZ1pyR0pvV2NJeXNMUUdaazZt?=
 =?utf-8?B?SDZLL2IrUmJhQ1lhR094aCttYzFuOVlSNThLUElicEtCYStGYXNxNkdEOXRJ?=
 =?utf-8?B?OU5ha3NWaEg2WHIzYVdvRTRhS0FVYXBjNDU5THpSVTRPTGludG5KVzZuZmd6?=
 =?utf-8?B?YnQ0T3JpcmFGZU5OTFVTYTBQeG94UXdXd1NrOE9yQ3N1L3QvenZYbjRoVDVo?=
 =?utf-8?B?WTVYeE5QYU4xNFhSckZQV3dka1VmWWgzakQ0ZWtGYW0zZFBSRDNkTkh3cTJ5?=
 =?utf-8?B?VWFWdEdxSjJtZWQ5NEJKODNnZE5FZHIyeWJzdXU0emh0STgyaGpVekdEV0ZG?=
 =?utf-8?B?c0FXOG9rSVQvekVYcG05YVNydUFNcXViZldLWmR6QURtREFhYVM0VHEvRnRv?=
 =?utf-8?B?SGY5Q0plV2lNK29mQzM3VFU2Y0VKcXhZR2NKVzJGSmNMQXA5UlI0ZnQzOEsx?=
 =?utf-8?B?bkFFSWxlbmZaZHNrVStNS3JrZEgxSmRrOEZCWWJNWkp2eDV0RTBrZWM3UUR1?=
 =?utf-8?B?NXpsWUNROHEwUGs5LzZmTENVNnZ3L3d2djhXZmJ5dXhDL0pZa3ppTVFWZnMw?=
 =?utf-8?B?OVNPZVhhR245aXdzNWNRK0V1OUJRUUJZcGQxRzdxM242cHZRRk5TS1ljWFdr?=
 =?utf-8?B?SVdCUElWM3ZmSHF6KzdiZGJERDRvNEhKbFlvaVBLR3hDTUFZdTVWdCs4VGoz?=
 =?utf-8?B?NFowRXpkMmZueDdUZTJweStmTUE1YURqamZNakFKak9kZXRWc2xnUzluZG9S?=
 =?utf-8?B?T3dOajByU0l5eEdIcVNlOFZoVHJjdmg0UUN0dGd1ck1LYWF1a3F2enUzcjlH?=
 =?utf-8?B?a3poZmhpYklaSE5kaElOYVlPN3kvSHprZFE0ejFUQzZZRmxIM0tRNTZJTndy?=
 =?utf-8?B?NFp1VkR3TlRzYVREdGJNWmJZa3JlQnYvMnNvUTAzVWZtaG5JTW9XdWhseUVo?=
 =?utf-8?B?VmhhbzB5aFF1NlcvM1FPTnB2VFRUUGFwRVM3d21PSmxDQ2FJb2pFZkx1dUIv?=
 =?utf-8?B?RlVKOHdScCthbndCQkZKUjExd0k1TTF1WnlQYi8xajFHRzExWE1SUnM0WkNy?=
 =?utf-8?B?bUFWSGlJSkRENU1kYm5jZTZtRjhKalQ2TFo5NTBGcmdhbjdKMGNsNis2VjVB?=
 =?utf-8?B?Rk16U1ZGYjJ3Y3FxNGxCRkwyVzVIVmhwcEdSSWtoaUhKNGpYSWNpUzVoODly?=
 =?utf-8?B?YkNoSGRiU1FvNU50NmlYNlNaUEdjYlJzQ3M4Q1hnVkRJZjJxSWY3MmIzWG9a?=
 =?utf-8?B?NFhpZzNsYTFETVY5YlBmZjV6dzNiV1YzZ0dINjUrdFlYQkx5OVJDemVuK3R5?=
 =?utf-8?B?SVZvU0VVMkpYa1lKOEF3TzV4TzJQT1JvczYvSzFUeUdnMVY1ZGdOS2M3WEJl?=
 =?utf-8?B?L1FnNVZpSW1ZY01yYXBWMzBoZFBvTlQyajBaMDVLVjViUHdsdmJlekFSUGZK?=
 =?utf-8?B?ZWpHWkVrSlJVcWptalc3cFJTSjlJT2xNL01wOWRBMC9jMVdHUFpmSTI4OWdC?=
 =?utf-8?B?L05KR01DRFdReFNnL0ZOcDl3NWQvYzRtV3lsaUxMdUlnbENHamxNTTBkOVpC?=
 =?utf-8?B?YWl1RDNSK2ptK3pNVHRZMGNRWDVvN21LMWdBbStXNkhiTnhMektxc0hlQnNv?=
 =?utf-8?B?ZW1KcG9scnB2MUNqMVI0Q2JqcU5XVDlzMW9FMmJZODhpYkw5SWNjV25VYjNV?=
 =?utf-8?B?aDVzQ1BNQUpZU2NCS3prVVNyQjBnZ2prL0w2UjREcnBwclZPY3hyN0NzbjZ6?=
 =?utf-8?B?aU16WE1nYVp1VlJGSzZLRWNRUzZnVkt4T1VvOXYrZUxncEhIRTVZNk5LTWxC?=
 =?utf-8?B?WG12bTNnVTlvWnFzU2hzMlhaNm13aVo3cklMZ2FPeFU0Z3dxb1FHTDYyNTlh?=
 =?utf-8?B?eExtTmQ4Y0o0YWZsRnp1aVBWM0I1Yld4WDc5dDBNUXV1enZRallTUko1eHMr?=
 =?utf-8?B?TG10SmZlZ0FzQ1pUT3lnV0tnRDhpcUIvR3hzQ3kwSTAwSm9sMWVPY2EyUWM2?=
 =?utf-8?B?bDFWeHl1SWhscVc3Rm83ZVFjQ0hEYWRId0N2bnF2aXR1bUswNXI4NThqS1Uv?=
 =?utf-8?B?U0MvVDBWMk1kUGdNcDBrQjFDSDBxenJBaE81R3l5UFpDNVN1VHdMYUZCY211?=
 =?utf-8?B?RmhwWW5ab0IzOVE1ckJtUzkycDl1UnhsYkZrdG5mUVlaTjlOUDQvMlJ4dkJn?=
 =?utf-8?B?ZWxCOVpaMFl1WXBjeWp4UTBLRU1MbC9PdWtoY2lpYnd2aGRtNG5EOHB3UlhY?=
 =?utf-8?B?eVpVZnh2bENJaDgvZkc1Uk9abEJJRDN1eXBYblpPdWZOM2F2RWhuMldHV1dG?=
 =?utf-8?Q?ctM9ee1L0wVzgKvhckBkn8FGG6FpI08TfzKiHo6I0VmGJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 4pEqlRzU9S/mLQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f977c383-df6c-47bb-5acf-08df4c42d381
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:56:41.1191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVImXkwBfFZMBZeTbN14ae4ZsSPHLzkwq1RaCwzpvCmdtDIMegVXS/YY1cpf2FcAGk0JiLWKVzYEWKQG8Svkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add DC register definitions with additional fields in preparation for
> adding the 8-bit CPU interface (MIPI DBI).

Maybe also mention that some whitespace cleanup has been done.

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.h | 194 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 183 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0cb0515968b35..e8913c5530a2d 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -272,14 +272,150 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
>  #define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
>  #define DC_COM_CRC_CHECKSUM			0x301
> -#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
> -#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> -#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
> -#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> -#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
> -#define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
> -#define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> -#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
> +
> +#define DC_COM_PIN_OUTPUT_ENABLE(x)		(0x302 + (x))
> +#define DC_COM_PIN_OUTPUT_POLARITY(x)		(0x306 + (x))
> +#define LVS_OUTPUT_POLARITY_LOW			BIT(28)
> +#define LHS_OUTPUT_POLARITY_LOW			BIT(30)
> +#define DC_COM_PIN_OUTPUT_DATA(x)		(0x30a + (x))
> +/* Pin unmask is 1 bit above position of the pin in the OUTPUT_DATA regi=
ster */
> +#define PIN_UNMASK(x)				BIT((x) + 1)
> +#define DC_COM_PIN_INPUT_ENABLE(x)		(0x30e + (x))
> +
> +/*
> + * The definitions below describe pin positions in the DC_COM_PIN_OUTPUT=
_ENABLE(x),
> + * DC_COM_PIN_OUTPUT_POLARITY(x), DC_COM_PIN_OUTPUT_DATA(x), and
> + * DC_COM_PIN_INPUT_ENABLE(x) registers. The comment before each group i=
ndicates
> + * the index of the register (the x value).
> + */
> +
> +/* 0 */
> +#define PIN_LD0					0
> +#define PIN_LD1					2
> +#define PIN_LD2					4
> +#define PIN_LD3					6
> +#define PIN_LD4					8
> +#define PIN_LD5					10
> +#define PIN_LD6					12
> +#define PIN_LD7					14
> +#define PIN_LD8					16
> +#define PIN_LD9					18
> +#define PIN_LD10				20
> +#define PIN_LD11				22
> +#define PIN_LD12				24
> +#define PIN_LD13				26
> +#define PIN_LD14				28
> +#define PIN_LD15				30
> +
> +/* 1 */
> +#define PIN_LD16				0
> +#define PIN_LD17				2
> +#define PIN_LPW0				16
> +#define PIN_LPW1				18
> +#define PIN_LPW2				20
> +#define PIN_LSC0				24
> +#define PIN_LSC1				26
> +#define PIN_LVS					28
> +#define PIN_LHS					30
> +
> +/* 2 */
> +#define PIN_LHP0				0
> +#define PIN_LHP1				2
> +#define PIN_LHP2				4
> +#define PIN_LVP0				8
> +#define PIN_LVP1				10
> +#define PIN_LM0					16
> +#define PIN_LM1					18
> +#define PIN_LDI					20
> +#define PIN_LPP					22
> +
> +/* 3 */
> +#define PIN_LSCK				0
> +#define PIN_LSDA				2
> +#define PIN_LCSN				4
> +#define PIN_LDC					6
> +#define PIN_LSPI				8
> +#define PIN_LSDI				10
> +
> +#define DC_COM_PIN_INPUT_DATA(x)		(0x312 + (x))
> +
> +/*
> + * DC_COM_PIN_OUTPUT_SELECT(x) is a set of 7 registers that allow select=
ing
> + * one of 7 functions for each pin using 3 bits. Clearing all bits sets
> + * the pin to its primary function, while setting them to 1 configures i=
t
> + * as a GPIO output. Other functions are unique to each pin. For details=
,
> + * check "23.7.17 DC_COM_PIN_OUTPUT_SELECT0_0" in the Tegra30 TRM.
> + */
> +#define DC_COM_PIN_OUTPUT_SELECT(x)		(0x314 + (x))
> +#define PIN_OUTPUT_SELECT_MASK(x)		(0x7 << (x))
> +#define PIN_OUTPUT_SELECT_PRIM(x)		(0 << (x))
> +#define PIN_OUTPUT_SELECT_OUT(x)		(1 << (x))
> +#define PIN_OUTPUT_SELECT_F2(x)			(2 << (x))
> +#define PIN_OUTPUT_SELECT_F3(x)			(3 << (x))
> +#define PIN_OUTPUT_SELECT_F4(x)			(4 << (x))
> +#define PIN_OUTPUT_SELECT_F5(x)			(5 << (x))
> +#define PIN_OUTPUT_SELECT_F6(x)			(6 << (x))
> +#define PIN_OUTPUT_SELECT_F7(x)			(7 << (x))
> +
> +/*
> + * The definitions below describe pin offset in the DC_COM_PIN_OUTPUT_SE=
LECT(x)
> + * registers. The comment before each group indicates the index of the r=
egister
> + * (the x value).
> + */
> +
> +/* 0 */
> +#define PIN_OUTPUT_SELECT_LD0			0
> +#define PIN_OUTPUT_SELECT_LD1			4
> +#define PIN_OUTPUT_SELECT_LD2			8
> +#define PIN_OUTPUT_SELECT_LD3			12
> +#define PIN_OUTPUT_SELECT_LD4			16
> +#define PIN_OUTPUT_SELECT_LD5			20
> +#define PIN_OUTPUT_SELECT_LD6			24
> +#define PIN_OUTPUT_SELECT_LD7			28
> +
> +/* 1 */
> +#define PIN_OUTPUT_SELECT_LD8			0
> +#define PIN_OUTPUT_SELECT_LD9			4
> +#define PIN_OUTPUT_SELECT_LD10			8
> +#define PIN_OUTPUT_SELECT_LD11			12
> +#define PIN_OUTPUT_SELECT_LD12			16
> +#define PIN_OUTPUT_SELECT_LD13			20
> +#define PIN_OUTPUT_SELECT_LD14			24
> +#define PIN_OUTPUT_SELECT_LD15			28
> +
> +/* 2 */
> +#define PIN_OUTPUT_SELECT_LD16			0
> +#define PIN_OUTPUT_SELECT_LD17			4
> +
> +/* 3 */
> +#define PIN_OUTPUT_SELECT_LPW0			0
> +#define PIN_OUTPUT_SELECT_LPW1			4
> +#define PIN_OUTPUT_SELECT_LPW2			8
> +#define PIN_OUTPUT_SELECT_LSC0			16
> +#define PIN_OUTPUT_SELECT_LSC1			20
> +#define PIN_OUTPUT_SELECT_LVS			24
> +#define PIN_OUTPUT_SELECT_LHS			28
> +
> +/* 4 */
> +#define PIN_OUTPUT_SELECT_LHP0			0
> +#define PIN_OUTPUT_SELECT_LHP1			4
> +#define PIN_OUTPUT_SELECT_LHP2			8
> +#define PIN_OUTPUT_SELECT_LVP0			16
> +#define PIN_OUTPUT_SELECT_LVP1			20
> +
> +/* 5 */
> +#define PIN_OUTPUT_SELECT_LM0			0
> +#define PIN_OUTPUT_SELECT_LM1			4
> +#define PIN_OUTPUT_SELECT_LDI			8
> +#define PIN_OUTPUT_SELECT_LPP			12
> +
> +/* 6 */
> +#define PIN_OUTPUT_SELECT_LSCK			0
> +#define PIN_OUTPUT_SELECT_LSDA			4
> +#define PIN_OUTPUT_SELECT_LCSN			8
> +#define PIN_OUTPUT_SELECT_LDC			12
> +#define PIN_OUTPUT_SELECT_LSPI			16
> +#define PIN_OUTPUT_SELECT_LSDI			20

It becomes apparent here that the PIN_* and PIN_OUTPUT_SELECT_* are kind=20
of redundant as the pins are in the same order, the stride (and thus=20
register indexing) is just different. Hence, I think it would be cleaner=20
to have ..

#define PIN_LD0		0
#define PIN_LD1		1
...

and then

#define PIN_REGISTER_INDEX(pin)		((pin) / 16)
#define PIN_SHIFT(pin)			(((pin) % 16) * 2)

#define PIN_SELECT_REGISTER_INDEX(pin)	((pin) / 8)
#define PIN_SELECT_SHIFT(pin)		(((pin) % 8) * 4)

This will also simplify the tegra_dbi_idx tables since they can just=20
store the pin index, and the register index (and shift) can be=20
calculated based on that.

> =20
>  #define DC_COM_PIN_MISC_CONTROL			0x31b
>  #define DC_COM_PIN_PM0_CONTROL			0x31c
> @@ -303,9 +439,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define  UNDERFLOW_REPORT_ENABLE (1 << 0)
> =20
>  #define DC_DISP_DISP_SIGNAL_OPTIONS0		0x400
> -#define H_PULSE0_ENABLE (1 <<  8)
> -#define H_PULSE1_ENABLE (1 << 10)
> -#define H_PULSE2_ENABLE (1 << 12)
> +#define H_PULSE0_ENABLE				BIT(8)
> +#define H_PULSE1_ENABLE				BIT(10)
> +#define H_PULSE2_ENABLE				BIT(12)
> +#define V_PULSE0_ENABLE				BIT(16)
> +#define V_PULSE1_ENABLE				BIT(18)
> +#define V_PULSE2_ENABLE				BIT(19)
> +#define V_PULSE3_ENABLE				BIT(20)
> +#define M0_ENABLE				BIT(24)
> +#define M1_ENABLE				BIT(26)
> =20
>  #define DC_DISP_DISP_SIGNAL_OPTIONS1		0x401
> =20
> @@ -456,6 +598,22 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
>  #define  SC1_H_QUALIFIER_NONE	(1 << 16)
>  #define  SC0_H_QUALIFIER_NONE	(1 <<  0)
> +#define  SC0_H_QUALIFIER(x)			(((x) & 0x7) <<  0)
> +#define  SC1_H_QUALIFIER(x)			(((x) & 0x7) << 16)
> +#define  SC_H_QUALIFIER_DISABLE			0
> +#define  SC_H_QUALIFIER_NONE			1
> +#define  SC_H_QUALIFIER_HACTIVE			2
> +#define  SC_H_QUALIFIER_EXT_HACTIVE		3
> +#define  SC_H_QUALIFIER_HPULSE			4
> +#define  SC_H_QUALIFIER_EXT_HPULSE		5
> +#define  SC0_V_QUALIFIER(x)			(((x) & 0x7) <<  3)
> +#define  SC1_V_QUALIFIER(x)			(((x) & 0x7) <<  19)
> +#define  SC_V_QUALIFIER_NONE			0
> +#define  SC_V_QUALIFIER_RSVD			1
> +#define  SC_V_QUALIFIER_VACTIVE			2
> +#define  SC_V_QUALIFIER_EXT_VACTIVE		3
> +#define  SC_V_QUALIFIER_VPULSE			4
> +#define  SC_V_QUALIFIER_EXT_VPULSE		5
> =20
>  #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
>  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
> @@ -493,6 +651,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define DC_DISP_CURSOR_POSITION_NS		0x441
> =20
>  #define DC_DISP_INIT_SEQ_CONTROL		0x442
> +#define SEND_INIT_SEQUENCE			BIT(0)
> +#define INIT_SEQUENCE_MODE_SPI			BIT(1)
> +#define INIT_SEQUENCE_MODE_PLCD			0
> +#define INIT_SEQ_DC_SIGNAL_SHIFT		4
> +#define INIT_SEQ_DC_SIGNAL_MASK			(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
> +#define NO_DC_SIGNAL				0
> +#define DC_SIGNAL_VSYNC				1
> +#define DC_SIGNAL_VPULSE0			2
> +#define DC_SIGNAL_VPULSE1			3
> +#define DC_SIGNAL_VPULSE2			4
> +#define DC_SIGNAL_VPULSE3			5
> +#define INIT_SEQ_DC_CONTROL_SHIFT		7
> +#define FRAME_INIT_SEQ_CYCLES_SHIFT		8
> +
>  #define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
>  #define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
>  #define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
> --=20
> 2.53.0
>=20
>=20




