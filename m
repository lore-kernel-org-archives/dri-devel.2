Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A4606A88B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PnBa5MCj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502BB10E111;
	Fri, 13 Nov 2026 22:57:47 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B7B10E111
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHB9KO2xjAJFFrJxrAOYT9ZPlaylKR83cIgdEWat+1vjUXdG0wFszFTWnCZx63h77YH+0WvnnGpPaj5LOaiaHsEp2pDVeLKeVmC2/BzmYwFwbRMsQ6P+l0Yby2VGhlfXTdZ/HfPykRGm7XgTxc2qd8X/b7Db5vcBDY08tcc0Qi7AYPz2UbzRqR8ytPhBjQM1uin+zifBrFjWn1C1fyhfi/z0zOg3WbnBTYQtNEo3/bPmZTiehUncrYDMmYPtkhux2piVwDpk3t1lYQUY+owrldWnS/s2QPItU8w/rQe5OsxjD5Au4vPW5LGABi9oADl27eA/pfSwYpCY7/9KiXfkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr2g35obSTwFbDcVu1pJ5/MTt2tur5PHecenUXMxXjc=;
 b=nKtoi9urUWswZJ4lEhMT3UDpI1gtCeo/Kjs6CzUM9PJ/kyBt06rA/T330O9zLYmylPUYKHdV4zYx/1+f9So118TitPBGnHxLOf7R92sWEMEp3e49hhFFKjVZw4JVFJi0myW3/Bl82YXSKkIW6WnRWUzVpJHhSYoKFptFwvZQYbiS0lzqeCPRdF7T5J+69l3FgP+wMmmd6H19m0hJD9iYMrL7Yc2eBh5/u2jU23CGFbETqqKjKV33q6+3BMfesa8yl7Pat63d4KdZrXG7yUuIJN6sgWx4I71TbxAQJffqhKgcS0yYKY7TatemAi3WUl9Gdpjf0zag2yCPGfhj4PDjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr2g35obSTwFbDcVu1pJ5/MTt2tur5PHecenUXMxXjc=;
 b=PnBa5MCjbfkzCk/uv2H2Dgp/SHSLLe0ACvN77N0DRaXcmveqOrObv0w+acrBg87Wt0K++EOxOI2PPIARjCmS7K20GHastwGrP4tWKLtkvRyn3g3CZx+sluRyp9fXmZB5640uGIXud9JXqqE1aCyNTGvBdatgrrKFILnX3ytIGY2QQiQ+1Nuq40uIVre6tgcVjfXWl3WZ89jZ6qR9jsbxLYU81IcDUhdkHRH3bbyXafSdJQtxMW88fAGXjrbTvZ8bIdVltVAPUlOhcYQwlBpjaowNTKlxxOoGMe50sL/sWyOcs6Pq8XYnc3B9iDLTUkFc0pX54QrtrC8k0o2Uj/+dvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB530740.eurprd04.prod.outlook.com (2603:10a6:800:35f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 22:57:36 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 22:57:36 +0000
From: Frank.Li@oss.nxp.com
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: display: sgd,
 gktw70sdae4se: use unevaluatedProperties
Date: Fri, 13 Nov 2026 17:57:28 -0500
Message-ID: <179461004096.472201.1470837672942154435.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019205000.1084408-1-Frank.Li@oss.nxp.com>
References: <20261019205000.1084408-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:8:2f::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB530740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4887677f-0e78-4dd8-e75b-08df41d98290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|19092799006|921020|10067099003|11063799006|56012099006|261009223027099003|261022075727099003|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tsWTbRhYUtbY+bFur6+WFQvJbWzdVNYQsUzotKxTmu934700gdbTK1AQBNlzxOCaWoz4DHLWPfO8nGgTlvcU4Q+Q51niXtjFY81gDmAQwgfCtIieNxdRKDJVDkfh2J1UmPOA3U5n4WhqoeAyPWK+W+5WFBlvx8CJy32nyMQ3bs32DfuEmUefeyoZcVuMyj69VH24ugk3ELrhcm9BuAepiaeGEUQ44KTQfAEBAmIFNbyyOXqquT3Y6aniWgSP/qOh7oxUDQejgKFJaXtPlzJXCBRh1f9FXL8PNzyNjfJwXWyk+3bd5wL76eQoq7L1BzwkcJ8l3iLNMjsRSXe8h35hAIr04OSyzrwi25/+z9m+Ri1JCvlZvaiINiChxOZ2cTkZJS+oO/4D5pjsAih0DV++rHISnoubjaoE3HMLl81FhNUDGfGLgW923z0/HBOwZ1BhOQJxX3WCsZaGMZEbL4/C00JtzWpqcIP+n/Kc4Qi/6mPzGL2UH662Su2Z8zVlz8iVn0woqTDV+Mg7faiSId685V+EogqFT74bTXD7x4HJBte9uN9nfcvrMRA/L8IRcpdRelnN5yhPEMP8tPK+b18iZe8pH4EZoweMAK9Fa53J3MtFMUsb9Fl5fbTL0deL1pwcgpgoIcOqEW/hATK1nxC0kTIAcKJcmrJCgvu/X4sqxyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzU1clpUMWhpOHZpRzdrY2t3WTRXREROQ0hBbnJXVjRuOGZ3NHJvSlpITThB?=
 =?utf-8?B?M2pUZ2dlbXlKem1JeSt0bGVraTBERXFrUHBxc2ZrSmYrRG03Rk91cWZrN3Nx?=
 =?utf-8?B?UEhsMDQrYVY3RlBpQ1IzNjgyZVByZDAvU1hvYityZURmVnF2STV5TWJZU1J6?=
 =?utf-8?B?NWhWZEZIMGg4ZzVUazhTU1dhdk9pTENGV1NJZm9TbTk2RG9xS3ZjZEs4YkEx?=
 =?utf-8?B?MkxVQnpYWVFRbkFrYXp0Y1BGTkdYUGF2cXBvRldDYjFaM3pyQ2Z5WUZIZVRW?=
 =?utf-8?B?U0NHemlNVEx4UWRIMjJPZlFqdlV4YVdxcE5zMVJ3c2hEUU9YaEpIL3lEcmZY?=
 =?utf-8?B?UXQ1cDdLOGhkRTUrWmg1aWowZTFNbkc4SlEzbVBYOGlTT1Rma3Q1T3Z4ME1S?=
 =?utf-8?B?eGVINTBXeWtkajdGMGJKaERKejRYSGk1N3FFaVAyR2hvRXFvdWxGa29rK0hO?=
 =?utf-8?B?cXpVc3ZWS01jNisxd1o4amNycGJGeE90Z290b1NpR1g3dVphMHFsVjBTQ1NM?=
 =?utf-8?B?WGdHT0pFR0tYVTFuWWJiN3NzNU5ObTdXcWNVblEva0hSNnhiSW1kY2IvR3Yx?=
 =?utf-8?B?VzFMMW8yR2F2QVk4c2c1NDZvREpPeDlvSW8veVlaMHNFdGVPNHlPcVZIenE2?=
 =?utf-8?B?elVZOWpWeXlaTUVwWFlBUGg0Qm44RFd3VVJnNm9MRGE2L3cxbGNZYWVSMkNP?=
 =?utf-8?B?WXE3OFc4NFJ0anU4YTRUazZObmdDMjdoNWJwNTdkMlJBWTQ0SzJuTmJwcVhB?=
 =?utf-8?B?QXY1eWV4L2o3YXR3QVJVNE1YRnYzRkFIL3dkNVFOQm1Pa2dLYjZLVGIwZ0Jh?=
 =?utf-8?B?ZlNCOTZCUmdUc05EQzA1QnpjOTNRS09xWlVSblF6Z1JaZUlQNXEyN2VYZEhy?=
 =?utf-8?B?MVJxY21hSnVjYXRtY1d3cDlVNGRQMFVyK3oxK2t4Y1VwUHRmZmNtM0ZROTdw?=
 =?utf-8?B?T1l5WSs2MCt0YkorMjRuRGRmM29odXhtV3QxZWs0citkUEluZHlwYmNuV3k5?=
 =?utf-8?B?MGZHOVpsUDRRZ3RDakk0QVg4bnlkeUpjTjFBejhUL1NqUmFCaTV5Ym1IRlhy?=
 =?utf-8?B?b0JydjJSNmFCMGhtb0cxYnRtclZVbVBSaTdLVWpZcUE5NU5SRElIME9IY05O?=
 =?utf-8?B?NXA4c0tqU1ZrZ21CTUJCL05Hd0VSTkkyZDNaeitjZ0xhak91OTI0M1piZTR6?=
 =?utf-8?B?ZUNzcThmQmd1ZmR3RFI2dTMrN0M2ZVU0L1BidzRzcnFXQVJpUDVleDRCQS8r?=
 =?utf-8?B?TXVqbWl6OXVHd2xVNDEyelFFVnZEanBoVkd0eXdFdnVYR3M3K0lnT3JLQlYr?=
 =?utf-8?B?aVltWUNyeXdmUzFNeUZHNFFkRmFrQ0Q3dWZ4V1JXa1hIME1tcm5xNlVlVWR4?=
 =?utf-8?B?MTREWXJVbEtabkJJZm1zcFl4a1hSNHRYOTdDRTlhVzFncEc2bXJZNlRWYk9K?=
 =?utf-8?B?b0YyM3NZSXV4eVRuaHdhUVBlRG9aNUMzcEY1T2c4RThFV0E1VnI2Tk5hdDVQ?=
 =?utf-8?B?U0o3cGZLaFdJQWZIVkdOcXJORUdaSndoaUlkTXVFZUJDWm5WODdIN2RZcXhl?=
 =?utf-8?B?ck9QV3JabGdUeDRWUlhINXZZT0NGZW1hWG9nSXY1bnNkLzJaNXJ0VlFGMnVh?=
 =?utf-8?B?UUpYdFdPN0QwcGFwdHhPTmNiclZPcGZwQlc4TWdIbnFKN3FIWFJlM0J5NlBz?=
 =?utf-8?B?T21Wck5qVEE0cGwvWENYZ2ZvK0NxZWIxVFNvTTc5NmN3WUhWWjFTRnZhRDdX?=
 =?utf-8?B?bjJNVzcyUnNaRXYrK21aSHRkOFRrVVFTOFN5bW5sa0U5N0hMYnFtQVcvWjVL?=
 =?utf-8?B?czJLYmVMbE9FNTd3TmxoWmx6Qkk2aGYyRjY4RTVobVg2enlLK3o3Vmk0OUlQ?=
 =?utf-8?B?Z1IxdWNHYUNPaENyeHl6TkhYMmVtbEEzWEJGZVRuTEVtTllKN1ZBMSt2dCtM?=
 =?utf-8?B?RUhrM2h0dDgxUnVhTEpVQ3ZrRXBVOERUTlk3Ung0TXFoNHo3WVM4U0dBSnM1?=
 =?utf-8?B?azNnV2htZjU1ZHZzd3IzbFNTMFRIRE5QZ3ZrVGRXdDFMKzJ3MXZTZ2RpL2lq?=
 =?utf-8?B?NmJsN0NZREtIelFWUnJzSE0wUk01WmRzTjRMNnpCY0QzSTY0TFZ1RFlSL3FE?=
 =?utf-8?B?UjlzamFKTlVWRmVibFlNSS9SbkFWdlBuQXQ0RllCK29UbG1qZFJQVkU2TUJW?=
 =?utf-8?B?R1NObmp1aUFVRjVxcUZyV2R1YjdBRXkrUDJia0N4WFYyeUpoeUR3TWVCT1hW?=
 =?utf-8?B?cmI3dlRVM2IxMFQ3VkYwK04rQkptVTBKdWxkdXB2aW1tdGdMSTRvWlNFQmxX?=
 =?utf-8?B?akJoUVBEM2FjUlpJQ0kwK0xocnpOcU9EU0hlYTNBM21RMG9MOU5WbjhOWXZ2?=
 =?utf-8?Q?qPB72ENbcqpTxHZm3mTjQ1Bbi2HyyS4vwJTDO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887677f-0e78-4dd8-e75b-08df41d98290
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:57:36.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd8YSsP4dxkc5TREYinZ48ScGLaZdNuDAl2LKxBXeRLyZNuFuxTlTe1SPfpcqnf8aLP01p5u4gOUn0S8nzMgaZgygurlusfNoQrZ2M948+dgiKy7fVqmkmobRMqCu6Kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB530740
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>


On Mon, 19 Oct 2026 16:50:00 -0400, Frank.Li@oss.nxp.com wrote:
> Use unevaluatedProperties replace additionalProperties because it ref
> other yaml file to allow backlight and label property.
>
> Drop panel-timing and port, which copy from panel-common.yaml. Others have
> additional restrictions.
>
> Fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dtb: lvds-panel (sgd,gktw70sdae4se): 'backlight', 'label' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/panel/sgd,gktw70sdae4se.yaml
>
> [...]

Applied, thanks!

[1/1] dt-bindings: display: sgd,gktw70sdae4se: use unevaluatedProperties
      commit: 6f5338af664c42e200b846a8d51c80a5a230ce6f

I picked it to avoid warning, any concern, let me know!

Frank

Best regards,
--
Frank Li <Frank.Li@nxp.com>
