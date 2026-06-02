Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBB2CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD3A1138E8;
	Tue,  2 Jun 2026 08:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cLJALbja";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C191138E8
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw7ex2em/hGx7fcBL8ZKjQJ8OX1ja/3y2Z7QM5WGAAaG1b4WpAsI5a/TxRNNzlrYwvD38D47k6B7rO0pshBQUKRz7xHkbcDC90Bzj2YzAIX7nokWuk7G4SRL84IQFDSBvN/qxNIqt26UQTtmy44dQWiYPbhT1ItUyzrpKs3cMtw1ZZhDck2bMUUS972pedGo17kHm2MR0Xw+alvyd692Hblczo/IMHzgtTyN86adUugcsn2gnAqgprm8zavOfAPOPR3XDmrUBilqhNp+cX0eRH6v2dMx6pnGvyVCoW3PPIhwuDEcPm1Rt32gNda6r9m8dPiYJ6yulq8U4z70q8u9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKlKAvmKXgVCvK5OX/ngbwW8OrWWXnOHqs/ho5T95o0=;
 b=tDN7B8by+1Z5sMFMHlgeUiY5SaPr1nShGJSfQ1u2wRoiDbjTjU2DNeV2X3Lt+UBecUi5qg+ddEpYTDRLtCuzeQFOquqlrAVOEhqcYSDH+dzKj9CB54wV/PZhC6VXhz0BIBIEK8Ty8N+ppcWHerqQcinzrcrAvcy1GlteJO6DNjZX46SHF/Z3d+3JM10ACF8yE3rYm/Kn83lg+20khuOximTN5MRG0Wp0iCR7PrXyJClvYBTkG/aU3fHp9CTDyBK7NHPWb8zvJCbIFRDCpmw6GxvYw8TCvOH6yeb75SINiEDDWSG+WaTwrwQwAeGiHbYxhsJmiWN7OILwPL0cvuwQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKlKAvmKXgVCvK5OX/ngbwW8OrWWXnOHqs/ho5T95o0=;
 b=cLJALbjaMtn1OuU3DUEHjSBeoGTVllK1l2sR4QCKXWMpd6XkLSYWkGrCrybxgsgV4JRiiOl2l4el6QlQ6TAkpWfrEztMpO7pgM0RAzIuCKlA1rhzfaeKU9uNR68hkdRbTBnCBiNFhoY/iBtEJbT7ZHlYwS5gCoL/If7KnFzXn9DEnU9ZZj3ZQK0hUNPoHgrH1/AI274yFAlIUfbE16eV4gDEJIcBxd2/u/AUs48ya6BQEoXd3NG2nd0JX83yjeccBoUkxZuOLRMirTeZ7LMllkFmDE1f+7lXw0cihtZiY6ULFMCk0xoYJRcjyeYW5b2qDUSIeO6IE0q0QdnfBKVgDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAXPR04MB9006.eurprd04.prod.outlook.com (2603:10a6:102:20e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Tue, 2 Jun
 2026 08:14:02 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 08:14:02 +0000
From: Liu Ying <victor.liu@nxp.com>
To: laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de, 
 maarten.lankhorst@linux.intel.com, Yicong Hui <yiconghui@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, me@brighamcampbell.com
In-Reply-To: <20260406180013.2442096-1-yiconghui@gmail.com>
References: <20260406180013.2442096-1-yiconghui@gmail.com>
Subject: Re: [PATCH] drm/imx: Fix three kernel-doc warnings in
 dcss-scaler.c
Message-Id: <178038813577.703194.10614984028238892706.b4-ty@b4>
Date: Tue, 02 Jun 2026 16:15:35 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAXPR04MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d15581d-008c-4475-eea0-08dec07ee7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4SUn17vkvF1NxG/tbJ8AkrEF+9omUSVpeNVAeIZvXHc5pv1+kKG/QCZvhxpIP4/MZM+LlArfJ8doVeIIZF3o6hrpKnLmuooRVphBBR5UZIJAJ1Njyuk7Eb4wb7hglvPA0c3gOiEmZ1gOqLlCgSv4Pox+UEC/vxs3VB5rMhNEgQmDbWQd+vjarlWYM8UKke76pQB/DGCTGfOx/G6sZvrV4Gv6oWQB9oUsKbkQho0VKOP64IqJr69kvABmrJOYXrBfEYmV0ouPfRy1NBdGHZGBCYF2er5NI3+D2w2jVuUBdZHjM1hNP0kf1yE6HYgmY4oUf9gJsbcEWNnzlPMhcqw0bRfpAG5Dz5MX0FRYAxA0FRglOZDcbtRNaWbiOBhVkS9HGDqUu78QkmRsTCoA2hdxChlEc8agLovSAzWE9fN/LMM7odNHQFeJiOmZCtEmDv1Ih78nmGwPb3RgqwLmn2ryWmTUPci9agl6K0HBRyxyCHmaysVVc7RUn+Dn0uAhNAZzjc1dBU/65ER3FX45J+DRAJ2rrL2pOPyoy9PHQq2bAZUcpl8TdKdz3I0c5GHhlYgpwiFBxPhAO1NdNqQVBtlITUJWma/9C68Jg7MOQ8wORdc9UT5Bb95K0B7/V6cJVO2KEVUrxoTSHLgtNZquUDqoW6ut3U7ezjKFaypQzGmkViHmchsbyLgPrhJ6ZpAW4lHz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxTbWl5VWZLUDA0NmVNaXBSeGZ2K25PcXE5VEtjYkhwcVVPOEQ0dFU4Ynk1?=
 =?utf-8?B?S0c0Ti94MWFFUE1IMWZmRVp6YjIyamI3Zm1ZM3ptZm8wM1dpUXltOUtyQjFv?=
 =?utf-8?B?ODJHekV0eTFyMTJaZE8veld3MUR0b3dJVmRyVkZOaEFPOHg3UThlaWpydHk5?=
 =?utf-8?B?SEtlMWJkcU5vS3hXRGJ5c0ZZbmdGTlJBZjhGZXRrVGJkVVNSVTlPcExrV2hY?=
 =?utf-8?B?NDBzTlJjc3RRU2FvZWxJZTdTTnhtSXRtUlZ0L1lYN1pxUk5jUElNZDJlK0dR?=
 =?utf-8?B?OE9FM0Erc2RxQ2wyN01QOTFjS0JFMFVqQXVsMkRCTXpFYXJtMk1kUHdlNXlT?=
 =?utf-8?B?R1QrM09Hd3JUOTZ4NjViYXNlYldNL29XT3QzU0x2azdBZzRBdWh6K3hZREcr?=
 =?utf-8?B?SmlMcDd5K0FKWEExWTUweFVlaEhYckxuL3VPUGs4N1FPOXliSlgvWXJ1OWNM?=
 =?utf-8?B?bGFWMS82Qm1sSVJ3dWpYbnVycTdjYTBJbkJlTlR6ZHFLT2RIc1JZNWZlVjdT?=
 =?utf-8?B?dkkrdFVuWjdNYzhiVWZybHQyVEY2bHdaZVU2NExOT0F5M2ZuRU5VS09iMHBW?=
 =?utf-8?B?NTQwbG5pV2RPUTJtVGRrTDc1d0o1NzNKQVN1MjhCYjVtRndWUWZIbG5FaUxI?=
 =?utf-8?B?YVBtT3lXUVhQSTVMU2x5NDMzdjFvT0N6c3JpaVFqc3YwRzVzdTNiVnhkNWlB?=
 =?utf-8?B?Tno4UUVKa2R3RE5NZWlOZEFlRDloRVY5VWhLeFRUbXU3Z3VyM0FMYUd1cHBw?=
 =?utf-8?B?TjJvNGtDUmxLMHNSS2dEK21DRmlKalRhWVVNUURPRnJGdFMwWGxoNjIvSERG?=
 =?utf-8?B?QTZESWU0MktoT0I1Q2VGckdSZHNrTEVYVFN6MUJQS3NpU3BxUzlBZSttVE1W?=
 =?utf-8?B?eEYrTG1EZjViV2JkdFNvandJVzlnS0lIUllyZXdIVWxhM2VIdzQ2U3VGZUJJ?=
 =?utf-8?B?aVpza1ZyV3ljeER0eDRmd1ZmRm5rQW1TbUtoZE5xcnFWajdXS0s0ZzN4N1lY?=
 =?utf-8?B?ZTNxck5zREoyTXV5RHVJT1lLemcrN3RjcXkzVWxvV1JSYUVIMFhrRnF5WHU3?=
 =?utf-8?B?QVg5cDVPV1RVRmJpYzA3NXJldTJJM2NyWEpxY3UycHVnMngzZHVPd2pKQTBq?=
 =?utf-8?B?anJhTTZEaXVzMTB2OFNaQWwrWE1UZm5yRkZXSG9QWWhlZmc2NWhVYTcwY1pO?=
 =?utf-8?B?M0EwT2tkOXBkMXR4eXp0NXhrRzVYenlDekphUXIxRy9kVGZxakFsVG8wcHY3?=
 =?utf-8?B?Qk95N3ZQTUZERUNKeUdBRXRhbGtMU0tneEFxcGdJa3hxODBybldZWmE4bUNC?=
 =?utf-8?B?ODhmUE9rM0YwVWtmd0lYNlZYbmNQWlUwM3Fyb0tadkVHd1JiVTd0UHFNYnF2?=
 =?utf-8?B?UTVqVS8zaS9FcXlYZ1RzYnN2c2xPcmVBMmMxK0gwNWtSWHd1eFloNzdFRTF4?=
 =?utf-8?B?Ry9STjZtZnNnMkIvdTFJRkQ4ekdWQUx2cldsYzFETG9hZm5FY0FGMzV0YURG?=
 =?utf-8?B?d0x1ZUJtZi9KTlg2T3k1YmpQdFNIVDRuNVJOa2V3T3BNT0NPNVpQSlo5Z2Qr?=
 =?utf-8?B?WkZ1OXFhTkJYb1gzODRpd1lrTWdKKytaTmoydGxwYldzL0N6eGcvNjJBdE85?=
 =?utf-8?B?N2Vydm05VlZkYzFmeEVIS3J6MUdMMExvSkk4dUh2ZktYVW82Z0hETWVGRklT?=
 =?utf-8?B?VkZTb0J1cmp5d3lXSmtubjRqWFJJMTJad1B5Q21OcGxQcVYyL1JOSG9iZ0p4?=
 =?utf-8?B?clI0aEZDV1V0QXliZ0poT1pDSGEvVXB6RWgxWWtyQWRFRERUSVB4emNaTVo0?=
 =?utf-8?B?ckpiNFMweWRkVkNoZEl5N2VYZlJFS0VuVUtSQlI0UzBJSlhXcFVyVzdkRTNl?=
 =?utf-8?B?Z01vL3ZmeDhHcTFtaytyZnV3SDVGWGhXNDFBTHJSUWhhVHFIWTZ5RVZERnlG?=
 =?utf-8?B?UWI1NHdPTlZxeWhmYTRtNDZzV0JMWmJOSkpPZG1hL24vMElyV09rMVJ4UTh4?=
 =?utf-8?B?SlkyQ3JUeWN6dDF2d3FZcXlpd0F4N3FweXRlN2l5SlhaUklSS3BCUEdmclVl?=
 =?utf-8?B?d2dVVVJjTG1mSVUzMENIZ3BmVjk2cEttMUxkcHUyY3lRM3JXeGhKS3RXTVBL?=
 =?utf-8?B?NEs1Vklmc3FlNDNaaStyNFBWQlN0Q2xnalUvOE0vUmZtT2lJZjF2Z1JuNVpT?=
 =?utf-8?B?OUhHais0RzV6V3NFTjBBc0l2UzZLOW9RV1N5ZE16ZHBianUyRndqUmExN3FB?=
 =?utf-8?B?dzJjclowNXFCMTl1OW5DN0l3SkRvMGQ5REZqSE9ERTJEQzRQMDRCOU51NW4y?=
 =?utf-8?B?MWlldjE4QVJSSGlzOHBZclI5RDNUa3Ira0xBdVdRMVFEbmRMU2c3UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d15581d-008c-4475-eea0-08dec07ee7b5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:14:02.2729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8VwhJM8WrvJNf2f9KnZipUMIvt4oNCGmEGjf2EUpTxUELA7X9EvWcgzg0jLJfxsFfIPKwCDUjKUFkIJ0S4aQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9006
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

On Mon, 06 Apr 2026 19:00:13 +0100, Yicong Hui wrote:
> Fix the following W=1 kerneldoc warnings by adding the missing parameter
> descriptions for @phase0_identity and @nn_interpolation in
> dcss_scaler_filter_design() and @phase0_identity in
> dcss_scaler_gaussian_filter()
> 
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:173 function parameter 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'phase0_identity' not described in 'dcss_scaler_filter_design'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'nn_interpolation' not described in 'dcss_scaler_filter_design'
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes), thanks!

[1/1] drm/imx: Fix three kernel-doc warnings in dcss-scaler.c
      commit: ae0383e5a9a4b12d68c76c4769857def4665deff

-- 
Regards,
Liu Ying


