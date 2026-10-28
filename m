Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B6606A323
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TWoxkcp8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C267E10F92D;
	Wed, 28 Oct 2026 02:04:33 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651B810F92D
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpTfHs79GA7ntzYguwM4EBgt4qWbYVJyvqRIBpyrdHveNSkiI/ovqS/4kF51WuPHfjwm0CmAmc3pJbRwBaNCV0DT5rmRcD8gTht41GVPBBQlsu4tk1SKn34OaD8edohLUaAqaRK+5OWSzbQbURlIeNcNe3tzRfgzDqNQxvFq0+IQvuieBCA+uA4VfUd1XQaD+9kvN9N0oeP/FAcZ1H97BynpI4ZlJKbBpjwwpYwydeT7pyfuT/s7Ew0mGjYPhj0m+fs7Qdo/Dq93gOGW9354yI4nmKipKBm+25L61gPAG3hVILU64SOfjejSHrVd6KFfdoIGl1prThB75cMe4G7xPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lVuRy2gWGxjsf1R6JK3SvvTrJxE1D0C2aENTplraHY=;
 b=F0I9AEd2RQsNgdQCGzYYql8x/QwGBFTkEDtXKSd+om+7l0BqVC8qa/0GOmfLGEOjIhps8HIJ7sCD9562AXaFNyVjOcBKwmAclaZNkH11o95BEBOj9/pEHMX7pJqDtQM8uhWx/EjwGfoHpxOcwjXJRCF9R+9iYpQiSjmXaADvScA44YYTNrIT+Ohkuj6JwhATqMQSbCm4b3O6B4qBFOFO3TefxdpIH+cbaezOZkGc5rpmKTZYkm3nzm7Ob82mvIoxTIodCGTi2dAEcShTaT6dBqjb1+fKTLZpmyw8QHB0tWZaqLCKaBeKQ3Zc2BBDiKX9wPnI7V9OAopd+yzpiQGD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lVuRy2gWGxjsf1R6JK3SvvTrJxE1D0C2aENTplraHY=;
 b=TWoxkcp8x1/BF0oqCR32vAAUdZykItHM027F9ReIJIVmuaZHN1uXswX/CLPeo/EvExTFIYeC/nXxT93AXj0TcKNf2yg0WP952iWjfjS1ta1EATc11vwYdst7uUxPImXIFInObNs0wczNolrc/uVHuQ4A8xauVdIfRETzB54KAQjTmWnQlpUijJ1ITp+rhMxBAmgEmwObjJAEW7p+82gI9FVbTq9wmHDoIzIUWKwkvNQenhSg+wOLWockFi79ja78VtCAKjL9dK+VKB1aLsuLQ2oqXERFSs1dEZ4NkmZMc+v3uSi6FHN+111pxnajLCyHL8JpjRVZrBMyTcGqonXD7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS2PR12MB927960.namprd12.prod.outlook.com (2603:10b6:8:403::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:04:24 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:04:24 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject: Re: [PATCH] gpu: host1x: mipi: Disable clock again after powering
 down the pads
Date: Wed, 28 Oct 2026 11:04:20 +0900
Message-ID: <w40wFI2SQUWozyQ_FyS3Bw@nvidia.com>
In-Reply-To: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
References: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS2PR12MB927960:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ae4ecf-c2c6-4c21-2c12-08df3497c9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|261026121527099003|261021121427099003|261022113327099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: sVEnzldewBPhWE+kiVlc2ATdOjoUZflQV0HevBrZ8/ws73M4eF7DZa2EtPGz3ybdZVZ1f5mBX64OhOvTWxElktfKcKSr8S3m9KAtDdwNkC59HegX0A54sg8amYxlyy2l7LI+lbV3TkT4jzoRCIC2SLUlPyOtkRMX6TSD/JAkyD+8OnsNw7yE9H2NzZujbC8IVlDOz3OToDsQPZmZ03qiPRrW+DiiSBRvLICKI8d5tI0Jk78fFM+rNPxCtX9yj7T5b1KD1B3a/Pss9ZL2VIH/6FOTiI58qxb+S5UrtvAkr01UHCjwDM4fn/JEA/w/jJgIuAb0B9MWOdfbyZjoHj5z6L70pLAk5e65s/Hi1kpS65SbySy53gfwi8QQOUvMI1lADl/Hz1bnLqzGuVpbk3KKZuxT8xNtqcghTYHJDDwEkIiO/Yt5kXvr6lwjQgYeb58u9aV7A7uDhkJbTAKX6i+UZIUStPVBY4eDntl7jue2usQs6DAGlFh/iatAo7ryZViP9wsoRO6TldJIEnXsaiCCzTYNkUil4VWzGyuJ/jZFL8aeZ6CPKuy5EknH3FbDboN80JWKcvGj2TthAx8bqg85sjyb48V8jH/B8l8KaEUjnkPbf77Uh7XJ7fcG1AZMKNvfIpY19FfN4VF5JRueLNikt6QHf7p1f17oHL7qrhRqPqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022113327099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znp1Zk1od044UGIyb0ovUjYyMWpCRGNiWndIOXh0OS8yNWRuZmJQckVCWFFr?=
 =?utf-8?B?a0FkYUI0UytjZkNoYWlyYVd3eFhSSEVRdmlIVXZzUGQzdk1SZHkrSWloWW1N?=
 =?utf-8?B?K3ZSK3FTOFlhWFNSSGJ5YkFRcUdQbVJxcnUzSjhRS0sxanNmSHRMVlk2R3Ni?=
 =?utf-8?B?OWRuamVDcU82Z3FWSkZsK1IxMFUvNXRHb0wzNGE5WVExT2RtZjNYS0tTaDQ3?=
 =?utf-8?B?R2RTdUdWbW1oQ1JTNWJEMkNoZWZ6V3plZWxVSnBJWWZrTHF0U2JMcFVjc09S?=
 =?utf-8?B?QUtOUzBEc3J2RHpENVNNOEdWZjI5WVIvenF2Nm80QXZEM3ovZlI1RVZLMXlR?=
 =?utf-8?B?TUFoMUdLM2FGK1FtMHlCY0MyRFR1Qy9FU3F1MWhXWis5SXNEZkQ0dk5hczFN?=
 =?utf-8?B?L0tlQzcyM3FwcVRwbzcrSW1OcmJpcUh1bVYzbWJXWHVOVlI4Nk5VVWNRYXpM?=
 =?utf-8?B?T2hlZG9tL0YzTGVOSlRoS1d6M1hPelltVmZpK3dsc2FmZEUwNEhMVHJwejkr?=
 =?utf-8?B?dlF4b01GQzNrK0xYS2Q4RDYrTFRaVng3M2lSUVpYL0dxYlh0dE5YbnVFSGJz?=
 =?utf-8?B?cXV1ejBEMStaRjBlNjI2U2d1dzFoRytGK0dXdXVYNCszL3dzTW9INFJRSjFM?=
 =?utf-8?B?dSs3dWtpT2NqNW5KUlZuYlhoZE5vOFJ5aUp0TEFyNlZqa2lwTSt2QVV0Nm9M?=
 =?utf-8?B?bHdPc2N3aWluOHc0dk9CeVExZEtJK2hacXlwOWtnWXo1blJJc0R3VndPOTJ5?=
 =?utf-8?B?bnZ6empjQWJqZjJoazNxUE9GSHFxeU5tRFkzTkpsd2Erb3VmdC9mb294a0V3?=
 =?utf-8?B?R3crYzQ5eHJrWEhFMGR5QmN3K3d0dHVCdlFaSGtyK1RudkZyRTRMY0cxNUJv?=
 =?utf-8?B?Um1kbUdSMjk3UHRIVUNRQnhOL200bmNEVjVoc0U1M2ZJNm5JcnkvMHVJYmFq?=
 =?utf-8?B?MUtPc0EwNUk5Um5pekFZUnBwKzNjdWxvU2NaekxzWVVMK1VOY09OWmlLWERY?=
 =?utf-8?B?NS9HRTRGTUFMb0VSb1VOOWFNUThUS1lTdEE2SzkzVlRiUXdCeE85a1M2V1Bx?=
 =?utf-8?B?ejRoNEVPbU5pYmhBNU83T2tQR3BQRDVVL0VBTlk5Tk5qS2x6K2gza2pMMDh6?=
 =?utf-8?B?TTdqQXJSM1lmbG5jaHlJRldxUmRCcnRRb0xsYU42R2hGKzEwOVlKYmx4MGVp?=
 =?utf-8?B?ZUxRV2IvNGVKTzZDNFNnMms2NHpaN2lzblBYenB2STRIeG54cVFveEM3ek5H?=
 =?utf-8?B?ajRVUEhCbFFRUjdtN0ZaamZSdDRqUnNJalVxMmQ2S25jc1diVkg2dUJoVjRp?=
 =?utf-8?B?dmp2RjEyWGQ3WC9IZTJKNDZqdWE0OFlWWTB0NWIzYzZvcUtGZ3pNZDVJeVdO?=
 =?utf-8?B?Yk9EWkxMam9WMGlrOE83eUtHOWRQK0VkNWRzWVZjRUpRbzhlaUU5YWNKdXlu?=
 =?utf-8?B?aWRob1lZU0pPTXNtYW1NUm5lWW51akFmRlhEekRIWWN0N3FlNzJleWsvdjdG?=
 =?utf-8?B?WUFuekYzejV0cE5KcEZsUGpBRlk1aW5oUk1WdWRpaENFKzlwUXQrZ1plQ252?=
 =?utf-8?B?VVcyTGxsSzVkWWFmRkd0eGNHbnVSMGJuYzFyQmxaQm0wYk85NEFtVHFISE5x?=
 =?utf-8?B?emFRYlpFbUI1ZVpNdVp1NTkyQXFZNGJyYUNLVS82VnZidlppMWJ0M0hLaVpx?=
 =?utf-8?B?UzFnUXVma0hVZ29peHFnSTFHVTdnUGlSZkZLYWlRMkdWd1Zlc0J0clBuY05u?=
 =?utf-8?B?VGIwaytwaWhQQ1J5RHhtRDNBRnJiVHVuZW5LWmhMNElBbTFiZnF6amJoUGhI?=
 =?utf-8?B?R0psWk1rSVd4cXplTGxJUnVrM1ROMlM0VnFKUG9BNW56Wm95RmhOWHNralVu?=
 =?utf-8?B?RnZvYXBDVEcwa1A4RkVTcUpMMDlTTHlKb21YOURSeGMwSVl5b0U2WDNQTzlV?=
 =?utf-8?B?L1N0bzlLZGFhWktZaGdFZmc3T1QzaGFzeDYvVFRRTUdocktJVldWazBvWE02?=
 =?utf-8?B?Y1ExN0szbU9wSlRjTTNMTWZqUUUzcUZCS05QTnl0ZjhuczdNOUlwRmlscHll?=
 =?utf-8?B?T0x3T1dCOW5RR2Q3Zi9GTlF0ZWowQytGZVQ3Ni9FeE1ZbExibGdHN09XcUZq?=
 =?utf-8?B?UXFDQkVjV3ExQjIzeUdPazQ0elBlVVQ2WXNvWkxZRGsvZitPcTAyWmxHazl1?=
 =?utf-8?B?dVNMWmNlRnZ2VnE0YWgwWDVQSE5CSkYzTUNIR3pHa2d5NWFpQjh4WCtwWFFt?=
 =?utf-8?B?KzFETGlDY0J2QmhnSWVRbXRrd29rNjdtSjlYajdSYjNlM2hzTmVjcE1VTlFz?=
 =?utf-8?B?V1JOa1kxcnlDay9RQnQ5eEwwVzR3V1VwYSt3cXB3em9XMW5RTkIrbWQ2NnlB?=
 =?utf-8?Q?nedshV6bMW9tcxGyxsJls0YGtZozzcPZ0LiGMzTpfh+Zs?=
X-MS-Exchange-AntiSpam-MessageData-1: lajNUi6f2J06nA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae4ecf-c2c6-4c21-2c12-08df3497c9a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:04:24.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkVkrcUh8EyIZnFO0J6LCpAarXIaHNOJOa33fqFkzWeuG0p54hZ+vNhEfKonDzQWgGkHGHFvd9Pksmzq90nQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB927960
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

On Monday, October 26, 2026 2:13=E2=80=AFAM Patrick Fischer via B4 Relay wr=
ote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra114_mipi_power_down() enables the MIPI calibration clock to access
> the bias pad registers but never disables it. Every disable/enable cycle
> of a DSI or CSI user therefore leaks one enable count, and the clock
> stays on for good after the first power down.
>=20
> Add the missing clk_disable(), matching tegra114_mipi_power_up().
>=20
> The leak gets more costly with "clk: tegra: Fix Tegra114 MIPI
> calibration clock parent", which makes PLL_P_OUT3 the parent of
> mipi-cal: without this fix PLL_P_OUT3 would then stay on as well.
>=20
> On a Tegra Note 7 (P1640) the enable count of mipi-cal in clk_summary
> grew by one with each DPMS off/on cycle of the DSI panel. With this
> patch it returns to 0 after each cycle.
>=20
> Fixes: 15372d4be7f0 ("gpu: host1x: mipi: Power down regulators when unuse=
d")
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
> Mikko's "clk: tegra: Fix Tegra114 MIPI calibration clock parent" [1]
> fixes the MIPI calibration timeouts on Tegra114. While testing the same
> change on a Tegra Note 7 (P1640) I noticed that
> tegra114_mipi_power_down() leaks the clock enable it takes. With [1]
> applied that leak keeps PLL_P_OUT3 on after the first DPMS off, so the
> two belong together, although this patch applies and makes sense on
> its own.
>=20
> [1] https://lore.kernel.org/all/20260930-b4-dalmore-fixes-mipical-clk-v1-=
1-0518be6c7979@nvidia.com/
>=20
> Tool use (see Documentation/process/generated-content.rst): this patch,
> its changelog and this note were prepared with an LLM coding assistant
> (Claude Code). It traced the clock enable counts from my clk_summary
> dumps and wrote the code change and the texts from my measurements and
> instructions. I reviewed the change and ran the test on the device.
> ---
>  drivers/gpu/host1x/tegra114-mipi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegr=
a114-mipi.c
> index c084a09784d1..83a43a5e33af 100644
> --- a/drivers/gpu/host1x/tegra114-mipi.c
> +++ b/drivers/gpu/host1x/tegra114-mipi.c
> @@ -197,6 +197,8 @@ static int tegra114_mipi_power_down(struct tegra_mipi=
 *mipi)
>  	value |=3D MIPI_CAL_BIAS_PAD_PDVCLAMP;
>  	tegra_mipi_writel(mipi, value, MIPI_CAL_BIAS_PAD_CFG0);
> =20
> +	clk_disable(mipi->clk);
> +
>  	return 0;
>  }
> =20
>=20
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261025-upstream-host1x-mipi-clk-867edad177b0
>=20
> Best regards,
> -- =20
> Patrick Fischer <admin@tsv-stahl-riesa.de>

Thanks!

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



