Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q+RpLjco
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F9110E44A;
	Fri, 27 Nov 2026 04:41:10 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B1F10E44A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSyqW8y3wi2n8griANs/47ftRqIXp5G3cfobJSMyhwMGiunJaJ1WW+qHju3oWnDplWF0XNatsHHagm1zFfkPLQ9wrKwGfy2JooVBm8f+p3SMb1jxWswLBw/umVK8o8RGbumRod8vgvYGDVuLaDzktxXWvuuHoQ+pBzDc2lj9OLsE3IOozXLKrYrnYOhrwpLCyQQ/J0narifU68lkemcOkBZQMmqWojmeTeuRss/7BI9PHsPhanJYugPexTNKcZyFmrcbcAi/ZbisEDq02KneaqZAkF3UnI8KWIaizEMySj2QNcmQGKKP8KGZ/LUiUhljhWK6T+faM1zmru5DWYsV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtuNyt1OkOxP2EtlRDMOUhaLX9j/AEJCOYL0eaCn7x8=;
 b=ugcublTZyAoCHsrQhDm953sZLUIVg6bnYT4ecoU9TSFe4x/8ILmnojSHVabgSsIJIg41JQgO/qUrNElMm9XLDZF1hIaGr4GBn/FQc/ue5cufjHKyPg5jMAA8ss1muUvwTJad6H2oAz05ZpgghWGfnxD8N+uTH6fjBTo2M4Ej7q0o8Laja31XLhXMDS6pYALQZbQzKG0/oqT6lDW/dckfBo+AS3VNvrqUUFQ149d9BlmkYBGTCSH1HPQ8CpAH2FfEwIalORPvpQ31i/wpKp4R8GGNYj4olPAksKjwmv8rnBH/XMjSxdBWVetcn4fSCStCov3yLF9N80YS3Tr/CLe+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtuNyt1OkOxP2EtlRDMOUhaLX9j/AEJCOYL0eaCn7x8=;
 b=Q+RpLjco4rxSQLRJ3yv4CGVOmY+LNUGSkVahMqBm+O7eEWtYtezvBOGYcFyhOFyOrNZhZo8aZseUKr3bk1vpTdf2ZLgv9n1XhSxmLYpTGm3MucL5SSOulX85nnUx9EPMwHYtTC3tuuNuK91EhOp3dTtuEpzjy6szHtVLHGyzKuIjA6vL/xtjyRR7z1Bhztb8B8fK0c6mnKcVAIzf5oUlbFgVKgSqYjRpI9l5b/oKjZoDsi1odeYwBW9L2ZHU3Ny5PvzYFKx9jGpTzKedmzUruFLrDWq6sR9q+bitwvhQ31/uCp71PsmVu2sL8BY5kz2bIO7rhKAM3SzB/HOMDzEG9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PPF539334D8E.namprd12.prod.outlook.com (2603:10b6:f:fc02::945)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 04:41:01 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:41:01 +0000
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
Subject: Re: [PATCH v8 05/12] drm/panel: panel-lg-lh400wv3: Convert to
 mipi_dbi_write_seq_multi()
Date: Fri, 27 Nov 2026 13:40:57 +0900
Message-ID: <HQu8082xS7qYmUTkCtc3sA@nvidia.com>
In-Reply-To: <20261122081820.53199-6-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-6-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PPF539334D8E:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f94d98-26cb-4c1f-4973-08df4c40a2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|4143699003|11063799006|261009223027099003|22082099003|18002099003|921020|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261022113327099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: tPCV/+ygbRAgQPYyy2bEJP9ZqUvb69A/4h08lHiWp1elctxR1vXpj58JCbt1IQPve3ExcXAifDEt5jwPBjiQHHTIUvZOb21iJvChxWRV1aFE9ty6itW5sKN4+jYTF36rkWSNjlZJEswMCkCzza0rD+9UIkixfg+ryW+DDoy0arUxgRnEzqG+O/e5BBwj7/VI//BwPa/79ca3GjJVmufokcyElI0vXEjw5sIfIvruWZDhto6D8hJu3q+hmJx+LUpMET/ig/7TSxLHYH/5dx/e7hpcT/fK2Qzw41H1a9a4p/jmpxuATvtzW48GwUUAqGGbk/v34tx9z9s1eoDv84Izu9q5vx3x/oROTUjwZGAacmspEC8/aWrvO9REbVFwwVe8QZcWxv5hy/F4l2zbngqYDWlXpiDjZX+tJvmHsqNKmhG9jTihziK9wDYmxURxnQc1//SlAK6U/c2bBZ/gaVR3lVjpwjDSPUopk06mos0nx/aOG0dHCHPyOg44N0cSf3W2uGl/RUgUTSBkzgrkW5IN98SsvY/fUMX/69zkh53RDAYz6A2oBCvsJ0yuj82CliS8GjyQWYWQcbnH7iTMtoivtE1z9R/9jdFVOOxnJfLjpky4NcBK713bMGXYmS76+ElTa6Ea9GOqn1E2MuiISwKTgfC2D2GgmnrlBem/j5EIFXDbTuCcCYujg2K8Ysm6XKfM7J7KwTZ9UANakAMUsc1+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(4143699003)(11063799006)(261009223027099003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022113327099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9YbVIvelpjQ1ZDSC80RlNxclQ3ZWhLT0pLZWwvbHdpbzVVVi9DeTlxQ2NL?=
 =?utf-8?B?dXNONmszNmc3TTRpeFcySjR3SmhKd0trUjFjQnZwTDZDanVJWU1sdFIvOTkr?=
 =?utf-8?B?M1lGVlVIM0FEYWJ0VTZBQlZYTjZoOTJzeUdZa2hWTzBkaGVuTzlKNFpWUXRt?=
 =?utf-8?B?N28rRndQZWRIU2VVK2pubFpORTlCUTBkYStmOW5qTWthRWl0RHdrZW9EUVBH?=
 =?utf-8?B?ZkJITklTYmpvTUNjeFpPc0N3bzUrcFU2a29WdWtTTXczelZGemMxNVhlWThN?=
 =?utf-8?B?dmRiVWtSM25UcmlmVm51bEVZWTVhdktrRGoyVkR5Z29Fa2tkQ0dJNDE4aHFn?=
 =?utf-8?B?LzV5NE1EYjdFdDZWWVJPa3REWlhmbTNhVTRFVUNpTk9idUxXZnNad1FnOWV4?=
 =?utf-8?B?aFFVcWRHdmNoMXZVM2tKVEozTzZ3MFZObkx4Y1JRZzJSNjg3cFFiS0t4ZnVk?=
 =?utf-8?B?dVFnNTdjbTFBTi9ZdzRoQU85eTFDb3ArRGRCMDJ1NDhoeTBWNDZ1SzJtaFlQ?=
 =?utf-8?B?eUxoNndkNEVWYzZVOFlHZmEvRmpXY1pVNzRYQ0hXOEZoOGlJVDdtMktiRHlH?=
 =?utf-8?B?SzVQOXg3azkwalhJcTlhN1ovVHdLOVpiV3lYWGJ2U3cybys2aGtlR1RKU3VC?=
 =?utf-8?B?c21wZTFYTlVnQzYzWThNTXQ2NE9QOW9TSjNTdzF3MkEzZ0dISUNVTzBLR0x4?=
 =?utf-8?B?bDFvekZoUzE0MkRLaSt0a3BLeFJrQmlQYkFPNncxYXl6STdEM3hlYmJ5eTNr?=
 =?utf-8?B?M21mdFpwa0NLWStId0kwazZ5a3dLTzY2MENoNnVxSUR2YTZMbGx4cHdhNXRs?=
 =?utf-8?B?cmhnbHBnaGdNVzFOWjI4L3FNNG45cTdETDU2L2NNYVA3aFM4YVA0eHhGNll6?=
 =?utf-8?B?Y0k4VUtUYWhsWGUwU2ZyQk83YVFMV1p1Y2k5dCttTk1Na2pqdnpKbnBtVFVl?=
 =?utf-8?B?V1hJeWdTQnc3ejE4blBVN2oweDVRTktZNHdpdkoxQ080Ym0xNjFiWFpIVTFN?=
 =?utf-8?B?MVRzeGsxbVNxbFNLMkpnaVNyNXJYamkvK3IrUGFSWGhlYkFxMEFmbnVBRFFj?=
 =?utf-8?B?UklOckl5YlhzY1NoSG1Db2wvNXJ6WUREaG9MMmRwY1lDRERkazVrNTFoWnZJ?=
 =?utf-8?B?cmJMdll3dlYwMGJhQ2FvQTdMWWxzemNyMTdTL1dsKzQ1RGVwSUVpcjhMczls?=
 =?utf-8?B?WHJOb2F5bGxKZDdGL0pRbE1teVdGMWQ5aTRWT1pweE9oVkpxRTdydHh0cWVG?=
 =?utf-8?B?Vnl1ZnVYM2dZckNSdUdPWXpOS2NYNXJmMU45WXozTGUyRm9lSEVBZFplUFBz?=
 =?utf-8?B?c1RuY0JURkFGbDROVS9kQUYvVnhZT0dpR2RvbVJjdzN4bmNjVllrWGVzcVRa?=
 =?utf-8?B?b2pLQUdjdlVtS2s2N0xXZ0NxZnVFZG9CaU41dXdpSnd6SlRLRUlBTU1KelB0?=
 =?utf-8?B?TmxqbzN1ak5Wbk9sWXZ5VGJyMG1nZGdwb2MvM2FTSVNRY0hhazJPdTZhd3FJ?=
 =?utf-8?B?ZUM3Vnlkd3Z0ZWIxY2c3TGh0QXpjeGNqZkFqM295S3dPaG85bjVFamsxbWJ2?=
 =?utf-8?B?cklqNkZoL1VJd2tLYUhyV3dHbUM2WUR5enEvZHlnN0VSQ2xJN2RVL3VldVlU?=
 =?utf-8?B?RlUrWmVCSnZad0Y4MnMrYzVMYmVkOWtSOHR1STNabGJCc1Qwc2dEUndJTG5n?=
 =?utf-8?B?OU9oNUI1VXJQN2l4cGlmZTgxaFJUQ3QrVHR4WDVsY0ZKeWxDelpOdStiQVh0?=
 =?utf-8?B?VVZtWGN5NW1MalE5MWIzbm5HVmhaRlc3dzdyVkJDS0I1VFBiQUgwQlZiMExK?=
 =?utf-8?B?QUU4TG0vZ0o2cG1LUVVKWGNHb1luY1JNM3NsZzV2OGhsZGhDR3RMSzZudzEy?=
 =?utf-8?B?bTNhL2l2NFFNY2h2YVpuQ2JaSDBMa2xBQSt6MWk2bGVnTnpMKzByRTMyYWxQ?=
 =?utf-8?B?WmFuWG9URHlhV3N6dXA5bzBiQyt5cUxUb25oOWtnRlZxUE5JYWIzeDJVVlk1?=
 =?utf-8?B?UExSZkZhMnp4L1VwcWFXR0VSVFV4VWF4bzdZUzRyMHVZRW9sMUVuRjJLL2pk?=
 =?utf-8?B?YWhyZmd5Zi82TThkS2xCOWFLMWRQY0ppeThnRGVFSkRmVjdiUnl2aHpGZjNB?=
 =?utf-8?B?UXNjQmNoMWM2NGNBZUdIUTFZZU12bi83RFl3bVlURkpscFcrZnNtUXFwQjVl?=
 =?utf-8?B?TUNWZUo5WVRFQ01XLzhHd3RIcEtiMWJ2Q2Njc0pBWGR0YUVuL2kyWHFyQUNQ?=
 =?utf-8?B?VTRldGpzeE9LZHBVZnBXaHcrb2FLNGd4aG5kaEpxVit2Uk9YVjh0OUc5NzdZ?=
 =?utf-8?B?cnRmZnNFZit2aVgzWlZnT3lJU1h4bzBHVEhPVjF2dGM1N240WlY3N3VHRWcz?=
 =?utf-8?Q?5sLYHP+3VhzXljwmpdnqnRWhy+Q8Z6d6WJTh5ywLAsmpV?=
X-MS-Exchange-AntiSpam-MessageData-1: OTJop/GbwolzqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f94d98-26cb-4c1f-4973-08df4c40a2f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:41:00.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGENeU+X9boEFj6WbHvBFF6hbOg5eQvLQrIQV25AVv/YfYNeH4ft1iRf9xGhtNMnkMg7lbJ4x+D6ST/1FkWKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PPF539334D8E
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> Switch from the internal panel command-sending macro to a generic one to
> improve code reuse.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 91 ++++++++++-------------
>  1 file changed, 40 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/=
panel/panel-lg-lh400wv3.c
> index 63efeb434be13..02150330f1735 100644
> --- a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
> +++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
> @@ -37,19 +37,6 @@ static inline struct lg_lh400wv3 *to_lg_lh400wv3(struc=
t drm_panel *panel)
>  	return container_of(panel, struct lg_lh400wv3, panel);
>  }
> =20
> -#define panel_dbi_command(priv, cmd, seq...) \
> -({ \
> -	const u8 d[] =3D { seq }; \
> -	struct drm_panel *panel =3D &(priv)->panel; \
> -	struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
> -	struct device *dev =3D panel->dev; \
> -	int ret; \
> -	ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d))=
; \
> -	if (ret) \
> -		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
> -	ret; \
> -})
> -
>  static int lg_lh400wv3_prepare(struct drm_panel *panel)
>  {
>  	struct lg_lh400wv3 *priv =3D to_lg_lh400wv3(panel);
> @@ -76,57 +63,59 @@ static int lg_lh400wv3_prepare(struct drm_panel *pane=
l)
>  static int lg_lh400wv3_enable(struct drm_panel *panel)
>  {
>  	struct lg_lh400wv3 *priv =3D to_lg_lh400wv3(panel);
> -
> -	panel_dbi_command(priv, MIPI_DCS_EXIT_INVERT_MODE);
> -	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_ON);
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_2=
4BIT |
> -			  MIPI_DCS_PIXEL_FMT_24BIT << 4);
> -
> -	panel_dbi_command(priv, 0xb2, 0x00, 0xc8);
> -	panel_dbi_command(priv, 0xb3, 0x00);
> -	panel_dbi_command(priv, 0xb4, 0x04);
> -	panel_dbi_command(priv, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
> -	panel_dbi_command(priv, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
> -	panel_dbi_command(priv, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
> -
> -	panel_dbi_command(priv, 0xc0, 0x01, 0x11);
> -	panel_dbi_command(priv, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
> -	panel_dbi_command(priv, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
> -	panel_dbi_command(priv, 0xc5, 0x65);
> -	panel_dbi_command(priv, 0xc6, 0x41, 0x63);
> -
> -	panel_dbi_command(priv, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51,=
 0x15, 0x04);
> -	panel_dbi_command(priv, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51,=
 0x15, 0x04);
> -	panel_dbi_command(priv, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51,=
 0x15, 0x04);
> -	panel_dbi_command(priv, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51,=
 0x15, 0x04);
> -	panel_dbi_command(priv, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51,=
 0x15, 0x04);
> -	panel_dbi_command(priv, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51,=
 0x15, 0x04);
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, =
0xdf);
> -	panel_dbi_command(priv, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x=
1f);
> -
> -	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
> +	struct mipi_dbi_multi_context ctx =3D { .dbidev =3D priv->dbidev };
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_INVERT_MODE);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_TEAR_ON);
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXE=
L_FMT_24BIT |
> +				 MIPI_DCS_PIXEL_FMT_24BIT << 4);
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xb2, 0x00, 0xc8);
> +	mipi_dbi_write_seq_multi(&ctx, 0xb3, 0x00);
> +	mipi_dbi_write_seq_multi(&ctx, 0xb4, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
> +	mipi_dbi_write_seq_multi(&ctx, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8=
);
> +	mipi_dbi_write_seq_multi(&ctx, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xc0, 0x01, 0x11);
> +	mipi_dbi_write_seq_multi(&ctx, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49=
);
> +	mipi_dbi_write_seq_multi(&ctx, 0xc5, 0x65);
> +	mipi_dbi_write_seq_multi(&ctx, 0xc6, 0x41, 0x63);
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03=
, 0x51, 0x15, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03=
, 0x51, 0x15, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03=
, 0x51, 0x15, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03=
, 0x51, 0x15, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03=
, 0x51, 0x15, 0x04);
> +	mipi_dbi_write_seq_multi(&ctx, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03=
, 0x51, 0x15, 0x04);
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00,=
 0x01, 0xdf);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0=
x03, 0x1f);
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
>  	msleep(120);
> =20
> -	panel_dbi_command(priv, MIPI_DCS_WRITE_MEMORY_START);
> -	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_WRITE_MEMORY_START);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
> =20
> -	return 0;
> +	return ctx.accum_err;
>  }
> =20
>  static int lg_lh400wv3_disable(struct drm_panel *panel)
>  {
>  	struct lg_lh400wv3 *priv =3D to_lg_lh400wv3(panel);
> +	struct mipi_dbi_multi_context ctx =3D { .dbidev =3D priv->dbidev };
> =20
> -	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
> -	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_OFF);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_ENTER_SLEEP_MODE);
>  	msleep(150);
> =20
> -	panel_dbi_command(priv, 0xc1, 0x01);
> +	mipi_dbi_write_seq_multi(&ctx, 0xc1, 0x01);
>  	usleep_range(10000, 11000);
> =20
> -	return 0;
> +	return ctx.accum_err;
>  }
> =20
>  static int lg_lh400wv3_unprepare(struct drm_panel *panel)
> --=20
> 2.53.0
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



