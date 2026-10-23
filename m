Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD5606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OMhLDcpX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D3710E5C7;
	Fri, 23 Oct 2026 07:15:01 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3846210E5C7
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggcBgt14rWsWbImzm43LcSWA+r+eJoitnLxs6upykcJh0NgjL4HTc3tNbMpW+nhxhh3C8AUnsyBpymyB4FslaHkN3ASJe0GRaHZ5w0NwVS9LtAUNvIrUdFwdQsTThnhf0krPjNkPUzOMdGO1OrpuoXfNVnPBHDEDxvYpjnbC4jX5sxNNxFnar5vqJykBLBdeKof5puCc5KLe0Pktc2cx71n8Bvox3Mhg7M5hgIEyxj/+/Jgq0+Psuftu8/IwfsjnTsBGKwEdJbgELqx7XL3eK1y8R3AuXuzEqlHk5XGvljroW0l3jxTi/9b6HuqrL2tSj222reiCdFfLpIcVL+84jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzqSrX2bMwhO1aGJlqNCcXTA64P3dT0ynYGxwuXVl0g=;
 b=pyOln43ywK/TWVYzbiyj4H0tm1S60S0a+4uahWeLzzKvi1fFLB+A9n9QBcZG59fyR7NwhE/7VgcJE7bWDxk0W7fXW3PKuqaCNrjmGZxO41puYWrhc9dQqcIkKqZh2gpDDwSLN/eJ6TjCPAHyt97aFmfui5QXSEaoqCR6tcvLJPHVkmTmrnpzfeX0NrXXAmiQJjyCLIS3iK+vC/QeRHUWncUGHpDzNoqB1kbY7nmOKWvaGyubokXhRA60LnC2RH0SNPzZyRKoHrdW3CCDdnCJ6wLxkQ78hPZERKT8vV3mIlpaQ0F8DVDXul4ZiUXAL59VLxhlf8YpYBex47EqcBdb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzqSrX2bMwhO1aGJlqNCcXTA64P3dT0ynYGxwuXVl0g=;
 b=OMhLDcpXY0jRDxVZIWjJCtC0Sasj0zdbbwgOP/U1YP4H5UYhQ9Sut5HfrE24UP3vRTx+yO7GezlwdV/3YTcyKEIlR8OAyrZz3WEsQ+3IVwNv0a3vQ7rBkDH5tvZ8RvmioIFyGLrdqd90qZFSBzBg2N1TW/I6a331Aj4M3dVZwbpVp/O5e+fV1U+NOXzXELqPdB+lndII3B2SQe9lQgQud78cv98zE8U7E8WzbZ7QeAV8FaukcgXufzNamaSIRtCZoeWl46SlWAQ8dSnBIGGTrYLucZ3AysQfTD+Qyr3OpVT3O+pot83s+vzaBjk8M9a/6pLaifQi/q9E+v3aDv9eVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Fri, 23 Oct
 2026 07:14:25 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 07:14:25 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 4/7] drm/tegra: dc: Expand available registers layouts
Date: Fri, 23 Oct 2026 16:14:21 +0900
Message-ID: <Rqw6Z6zYRbyIFoTAHJtpuw@nvidia.com>
In-Reply-To: <20261022132259.240717-5-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-5-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: dad510ef-ed90-49b5-6870-08df30d544dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|23010399003|261021123027099003|921020|261022105027099003|56012099006|4143699003|11063799006|10067099003|261009223027099003|18002099003|22082099003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: UvbenTK2+VsVJyMiX0JOh/6+TmhuGddV52AZctEsJ5oP0QVDlyX+6TKjSqivwZbrPU2ibC5gxAjXAkCHk5fShomNwxqJ2uBnfHgVcmE/miMs/SrbGYc5kXvbEKtTg1GTrCagkbTvSO7czeoogrf72JpKhUpdmZuX5e7JaLmIF1gxYeSKUpj3MBtXSWa7WTLDj7imksVaOh3V7O/fU63aTyJwJS7vHn8mTv5jMWL6ubQ2JAgj4rQs8UTPSSoH5JNJ6zA8F9mKSrSBSI0eoL/rRuVoslYlN5tRXtAnsa3XUmus/RRbh23zMyRrB6B0DNohyPbaq+EOQSd1cNHxYaVRisWmrd2M/Zz/YyjHy9Bw0NOdeRpVRcrktKYoXiXoS1yOVxRQSdCSDPYDnBgpAQo9KT98B/y3nO4OEMaXzl8IhWAl5mCXG9B341heFC2OZBE7G7zbU5ZfbHz8eN3rSikJxAtW4CN6P1Z4xbHi20xYJuLG1V3X6PO2seH2qkYwzBKzEDJWefXxaIitylLzwTn/dVU2YJUTzHkH/vAV46eUIvROUESe2MlT86EzHd21dKEIn4eE8fF/Elbs+hxTRHyZ13V3TMn2EmSw1PlJzzs/gXLHV03/AG9BGP2Oeiz5AGGJ9NsLGZXTYKwujgxGQxR3Vp05JQ9JenD38SmLrGjRtlssqktPOiw4i0y+CImonk516i5/Jwt8GOG8lQRsm7r0Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(23010399003)(261021123027099003)(921020)(261022105027099003)(56012099006)(4143699003)(11063799006)(10067099003)(261009223027099003)(18002099003)(22082099003)(261021121427099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZwRHFCTGNCaDZjQ2VXNm9yWlphU213cVRvVFVQRGl1aytVNldseGdyNHB2?=
 =?utf-8?B?VmdJTXh6bkR5eGdDN2M4cHNiamVWUFdJZzVXU0tmNUR1c0JJM3ozUVpDMU1N?=
 =?utf-8?B?dnlEbURUSUdhQVFGTUZNaDBpUG1hWFdGaU1kU3RnbzJLdVpwWmhYOFh1VzUv?=
 =?utf-8?B?TVIweXQ1VG9PZnFnQlRBNEF2NVZSWGF2ei9JQ0hUUXA3bkgzTlEwdEZVekxs?=
 =?utf-8?B?K2c2cnpPWlVMenVoQ1AvRnJWWVlLSmlFNUdCZ0R5SDRtTHgrb1ROWlh3U1hQ?=
 =?utf-8?B?T2NHM3YrdkU1d1ROZ0Z0Mnp3SStpWHQwZS9iVUQvZWZrMjVEdi9FZTdjOWxH?=
 =?utf-8?B?Q2VvWk9WZzM2WC9hVldHaGNscHppWEgzQmxlazFtUld6RmFiR3dhbkt3TklV?=
 =?utf-8?B?Y1FFVU5nVkdCQUJJV0NjMy9KMWlJZXFSaE9ZaVFKNjlaQzJYcndsWmNvY2hp?=
 =?utf-8?B?M09sU3o2RjNrN2N4K3VQdVpnVFlsdXF0d21KRVpHTWZLSjBqTXV6MVhXR3Jz?=
 =?utf-8?B?RW9zMlN5bEJzMUlPd3BMb2hvaUxGb1VSdlBJaHVoZ3pHU0thVmtsUnpYRnRr?=
 =?utf-8?B?TkFKbTFFdHVheFRHbEhaWmU3OXArYTAvRGUzaXhVRE12T2xMT29PamNuV3Bo?=
 =?utf-8?B?L2tIMmxCUVkxS0JDemR3cThncHA5cmNpQUVQNzJyUGEwM2hCR0RSQUc0RWVQ?=
 =?utf-8?B?bHU0d0NxbnlleEFsaWtMclJKRERITVZydjhuZzdvNnpkUjViOUUyNUp2aVkr?=
 =?utf-8?B?TUFZcm5NbDl4WFVrYkloZkI2NXBCYVVDYXBONjh5djNEV1VITnZOWnpWK3JD?=
 =?utf-8?B?QTdZSE1nZ1pkOS9oU2txRDVlQkk0NHYrekljZWRSL0N3RDd2K08vcHBMWmlr?=
 =?utf-8?B?VDIzQUdXNjRZVmdLUTI1WUQvVUZkaXNERTFSb2JMVytFN2k3bkczUHpTQURs?=
 =?utf-8?B?QTV0a1huZER6Y3JsellIYzBhL09vS0dzT0ZISHlRVlRnemJCUW9QNmpZSU1i?=
 =?utf-8?B?bkxZOGR1SmlrMjU3V2YvS0s0OUhrTWhaTE9QY1E0YUNVbU4rS1ZzUXhNeUJa?=
 =?utf-8?B?bjlRYnpaemNOc2pjOXBGTGdpbjlUQk1NTmlpdTZ4OWFMY0xqdXFNelQzS3VW?=
 =?utf-8?B?bjUwNEc5bkpxNDdJbFJSUFVBOEw5eGZtUWVuOGJ4aGVBQnRnY3lDOG9VbFhm?=
 =?utf-8?B?MlUxbXJrWE1saDVKK2hoUlkySEsxMEtMeTVBSk1QVjlqQW44UmE5VGFDWlAv?=
 =?utf-8?B?azRIaXIyV3dyMVhZUVpOVmwwczRlUlBQNGZWMCtDaVVzNzNXZ2hzMWhEczd2?=
 =?utf-8?B?d2JaTlF4NnFDL0QrZGxVbk5pNTBtUENIQzNSR3FjYmRZNHJ1cUJ6VHBiZ0w0?=
 =?utf-8?B?dytkeVgyYmxjREdHdHFHZkplTmhTM21XdGhOdDdmVkY0V0xLY3BER1ZNamps?=
 =?utf-8?B?OFhNcmRXUmw5T0FWdVZwU3BXcFdlMUMrYUtlUlV0SEtPVEE3a2RzM0VTY0NZ?=
 =?utf-8?B?V3FsTURRaGw0dWFJbkdaUUlFMXFCcHhnellmaHBteU14blp6QkV6YndJRGlu?=
 =?utf-8?B?eHZ5amNmTE9wdEw5K0psVXhIYklJZ0FzOFZ1ZFYxdWF2QTVNN3Y1UFVVY2x5?=
 =?utf-8?B?MHA1OWNUSXlZV1Z2ZDFZRHFkMEgvRnJpVUVBV09jcUhUdUx1RXV0aWpCVFZl?=
 =?utf-8?B?NGtpZ2pFT05XVm9HS0cxYmVxbGQ3TkJ5RFhNR3B5elYwenpFTEdLME40OEFI?=
 =?utf-8?B?d0sxa2RnODViVkNiM29UbVBnaDY2OTYrR0gxU09oaWgydEtUSWNkTENwTllE?=
 =?utf-8?B?MDhUSFMwaXJkZXRvSlhtTWNnbjd0bldUNCtiNThod1BiUjdWVVN1SWlNbmRG?=
 =?utf-8?B?YUtGYnFYQzNPRHlWUXM4am5MRTlCb3dWQ25CUExxL3diMWtPMHFQNDAyU1Vh?=
 =?utf-8?B?R0RObUhsOHRna3VESWRSbjBQNXNUWVM1WVA1WVlFeGR5RCtEb3BYMkIrajJx?=
 =?utf-8?B?Tlk0ZUNWNnRjMVY0Yi9hbEU3dm9GSENQVWgxYnlMbC93OERyZ1JKT3Z3OVFD?=
 =?utf-8?B?U0hzaEZIM01hT0U0ZzlDTW5vVDRJSVBDSmNpNUJGdlFmYVlmY0pkeGRUa1ZZ?=
 =?utf-8?B?Y1pIR1BieG1xaVZCaVVGbXhiWWI1d0RaVERyNVcvaGJpYVBrNlNUbmhVQTZr?=
 =?utf-8?B?VGEwVlRTL2lFVEtZcDlqaVpCTFpJeGlHazJDL2E1S0FycDZYak1BaUMwYVRw?=
 =?utf-8?B?amV2eUZ4STN1ejdFbjJxYXBrZnRPVGhqcHNhZzFLSDNxLzlTaWVoU2RJRHlU?=
 =?utf-8?B?VGdoZW14WVdtaTFIWG5xN2pLb25QNkVja25HWGJXR2gvVTRTcDhPdnZSNlhN?=
 =?utf-8?Q?CSxWpS7WkCLbzx98osFFZRM41Aqr2fRfal6tTXBYuR2Yh?=
X-MS-Exchange-AntiSpam-MessageData-1: yByAbHnfTJjMgQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad510ef-ed90-49b5-6870-08df30d544dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:14:25.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je/CbgE6rdWNDJYVAxF+XX/7mO81OCkopm+7LT6NP6Llrv3Mucpsktrr5meavPGXJCOSrXLGHlYcUmpaYzroUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, October 22, 2026 10:22=E2=80=AFPM Svyatoslav Ryhel wrote:
> Expand existing DC register definitions with additional fields in
> preparation for adding the 8-bit CPU interface.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c |  3 ++-
>  drivers/gpu/drm/tegra/dc.h | 49 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index b0bfa946e6979..5c67928bcabfa 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_crt=
c *crtc,
> =20
>  	if (dc->rgb) {
>  		/* XXX: parameterize? */
> -		value =3D SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
> +		value =3D SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> +			SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
>  		tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
>  	}
> =20
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0cb0515968b35..7005df32f485f 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -274,8 +274,11 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define DC_COM_CRC_CHECKSUM			0x301
>  #define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
>  #define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> +#define LSC0_OUTPUT_POLARITY_LOW BIT(24)
>  #define LVS_OUTPUT_POLARITY_LOW (1 << 28)
>  #define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> +#define LSPI_OUTPUT_POLARITY_LOW BIT(8)

Please update the existing defines to use BIT(n) as well, and align the=20
define values (incl. the lines around here that are already there) like=20
elsewhere in the file. Also, currently it's hard to tell which register=20
each bit define corresponds to, so I'd like some comments like ..

/* DC_COM_PIN_OUTPUT_POLARITY(0): */
#define ...
#define ...

> +#define LDC_OUTPUT_SELECT_V_PULSE1 BIT(14)

Please move this below the DC_COM_PIN_OUTPUT_SELECT(x) define.

>  #define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
>  #define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
>  #define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> @@ -303,9 +306,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
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
> @@ -451,12 +460,26 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define BASE_COLOR_SIZE_888    (  8 << 0)
>  #define BASE_COLOR_SIZE_101010 ( 10 << 0)
>  #define BASE_COLOR_SIZE_121212 ( 12 << 0)
> +#define DISP_COLOR_SWAP_BGR	BIT(16)
>  #define CMU_ENABLE_ENABLE      (1 << 20)
> =20
>  #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
> -#define  SC1_H_QUALIFIER_NONE	(1 << 16)
> -#define  SC0_H_QUALIFIER_NONE	(1 <<  0)
> -
> +#define SC0_H_QUALIFIER(x)			(((x) & 0x7) <<  0)
> +#define SC1_H_QUALIFIER(x)			(((x) & 0x7) << 16)
> +#define SC_H_QUALIFIER_DISABLE			0
> +#define SC_H_QUALIFIER_NONE			1
> +#define SC_H_QUALIFIER_HACTIVE			2
> +#define SC_H_QUALIFIER_EXT_HACTIVE		3
> +#define SC_H_QUALIFIER_HPULSE			4
> +#define SC_H_QUALIFIER_EXT_HPULSE		5
> +#define SC0_V_QUALIFIER(x)			(((x) & 0x7) <<  3)
> +#define SC1_V_QUALIFIER(x)			(((x) & 0x7) <<  19)
> +#define SC_V_QUALIFIER_NONE			0
> +#define SC_V_QUALIFIER_RSVD			1
> +#define SC_V_QUALIFIER_VACTIVE			2
> +#define SC_V_QUALIFIER_EXT_VACTIVE		3
> +#define SC_V_QUALIFIER_VPULSE			4
> +#define SC_V_QUALIFIER_EXT_VPULSE		5
>  #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
>  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
>  #define DE_SELECT_ACTIVE        (1 << 0)
> @@ -493,6 +516,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define DC_DISP_CURSOR_POSITION_NS		0x441
> =20
>  #define DC_DISP_INIT_SEQ_CONTROL		0x442
> +#define SEND_INIT_SEQUENCE			BIT(0)
> +#define INIT_SEQUENCE_MODE_SPI			BIT(1)
> +#define INIT_SEQUENCE_MODE_PLCD			0x0
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




