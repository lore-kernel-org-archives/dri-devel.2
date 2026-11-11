Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B9606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DOYfmNx3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C46010E3DB;
	Wed, 11 Nov 2026 08:42:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013067.outbound.protection.outlook.com
 [52.101.83.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC7F10E3DB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc5NOJulnIQjjWxs19DYGz+htPn18gd5T3hwjVn3JLAEg/0RQvRcSzgaPzggwanMwb/DUUndVSdRJdg2zzFZabMyheoc1IlHN6gA9Gr1hr1vz1zUxCI+fDcMIb+K07ij7ugPRo84Mz6uVbbQk/VsevoXety5juZ/8nqVJMi7cNMefrRU5Rzm1Zh3lT5gwnr4uvV5xBvVrAQS6Ah2TuCReoHmjkLlxddmGaNlBs26pJMHRiz+PVelHBljSaAyNLhusf2bINeSWwlSbzQqNoGwRVmgsd6ah1kc5/q0tAdGNkEZOH6AKptQv7FpE5F+VSDg72JRNvGIE8rd5hDZYupViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FatHv7+69U0p39FN6pTtTDmbk9zN2SKWKr2RLPiY94k=;
 b=CxKnG3mqD+9C2aDowYx1L42+echv3WluSFKOerEvZSau3AR5RffGWr9iqHFLahMAhcmH8C3v/O1HwZjJi0/y3tS9b2MM2DT/13lnNo31anfAU59rkt2ID+FqLuDd0SEiRZJVum9oMPw4btYHl7XG9Mswo6DCqOGJ1HxOYkvewU5jXsEfNBFf+c5/mav4hIyU/eYozeObnjr/5pzRmzxV5hp1f9+MKIj4Z5q6ymlB4UpcsSN4Yj1Cc/QTC17kMD42lPBhM7zEg41A//AXObekeSYBynnhfzk+pnF+hSqDzjBo/2Bdu48HEbQwc/o/I7UrkuWXlZywCUtm7AlEVZEJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FatHv7+69U0p39FN6pTtTDmbk9zN2SKWKr2RLPiY94k=;
 b=DOYfmNx3JmFLQmDrBkZ6AD690f3kAY00FXlht9u5aawQf54afvPA+n0P7HvYg2CtCVwfmOtvO+wIkqeelaeHsxrtGNsNbr9+WBiAAKJsUU4VLVxkmKn4Nt1b/1icUyZWop7EQtuy17HsKeq/3EGpgHuyfSbiY2tE1fM3VCcJH0TvwWuE9I/1OgzMECYVV3Isp0/SW0aSpuiVTKt+0uZ8G53J6JwoirnR4mnCOWpLnemtipl1sTzoXt49FVrrN9Bf/SC3eu1D/6t9TMLG9eTXeglBd4kljMsBq6h9x57CUY1JaNA0JGWXsC7Cdcbmr4s57/PkQBbokB6g3Qk8TUUutQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PAXPR04MB8270.eurprd04.prod.outlook.com (2603:10a6:102:1c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:42:28 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 08:42:27 +0000
Message-ID: <731ae75d-26a2-4660-83f4-501eb11b200c@oss.nxp.com>
Date: Wed, 11 Nov 2026 10:46:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93
 platforms
To: Frank Obergfell <frank.obergfell@bytesatwork.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
 <20261111081150.950272-5-frank.obergfell@bytesatwork.ch>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261111081150.950272-5-frank.obergfell@bytesatwork.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PAXPR04MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9ad4da-dbc1-41da-6f6c-08df3fcfb6ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|19092799006|56012099006|10067099003|921020|11063799006|4143699003|261022075727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9FDfn5uUH4oAc+8Z9UbkvDBWmiVwtSV/BnlciGy6hUdL48kEZB1J1AiwChzSE+usmIMXykbf4SeCZmc8nIGLOYi4W1+FixY379GnpYSyT2QK3ZjQ5SC4XX4DAhCXCiWwikOsIN1asYQG3qxW8b6gyUDGkXaqHfeCQ9H0Z0iZ9C/w4f7LuUZFVceOqt7Z6/Qalr+rpVPVLjUhr1oXopodDwtArHh2thiBUQ2ywK1DGfJOq5nEkpKPPPMs3H0bt8BUFRjCQMDKSqYniqFMWm1uxE//85BCbguy9H9OUQ9Va1E1bxImCFd7JY3LO6Vyrgf7xZAJGc4YzuVoan6bi/TumynZ842g1TSk6smfWDXJir4aq3yV5O2n/ZisucKjYJQrR+5S14/RGCbE91/XourQblWsBHhoL86+Wde0oRkLUs2qXlG5iMF1s02LCDDGxPbBv/xmi7GZDPk62nJE5+zV57+tpYLsCLvmNfS19Up+Srhhm4po/k8D/jgN8z6sfOu4GXSNtg2Fk7w3hPduIpXRygevf/ao/6+ZM0T8tz/sctAqrzP7kajE8N7qFACRLzZ2LPlOOswTK9sKLGVbI4zTzLw+D+eY6FeOwNd4yLP5vyQ/c83Y1vmq0NcO9Kov8YuPtRvvwcLMq/xlS9P9GmQlgVBBsTVauKT+7sHHy/mSyns+moI+GzoGhnhxBM+PbZfPxMGOCExRfcDkMBxuwzRS6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(19092799006)(56012099006)(10067099003)(921020)(11063799006)(4143699003)(261022075727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNmNktQejFMdDkyMTBONkpyYnYzL1lOajRaRFZmU29sWHVNM2E1TndaUTVp?=
 =?utf-8?B?Q08vNktSNDgvSjVPUmxYbDh0N0dybGI3anNjeGRQb2Q4UzQxbGl1clVHa0Vi?=
 =?utf-8?B?dDl4M09Vd2lCaTZDeVB3SWxBTElpcjNoMkdSMGdpOUpvK3g5cXpDSmVONGxT?=
 =?utf-8?B?Slh5V3JSQnRQYkYxTUcwNVp0Wm5rOXlwM3M0cG9VNFZqUHVwVjdLalJuaHZj?=
 =?utf-8?B?TjZhb2pVcS9oeXIyM3JnVmo1TlpLZGE5NWVTV2tUTXBxN3FMWG9KemU5N0t0?=
 =?utf-8?B?RTQ3SGtHN2g3d3RCWFNhODJBTW9XVjJGUkRTM1E0Y08ydnYrT1dHb01pbWpK?=
 =?utf-8?B?b2IrVllnTnBXeWhyekxldEpkTU0vL016TzVnaWVMRWw3RzdPbEQ1alZHZWFv?=
 =?utf-8?B?d0x5WUdzMUJOckZPcXluQlRNS1p2Q0hEZnFlbytqODFKb1QvWVhMcFU1MC9y?=
 =?utf-8?B?T1lleHZBRWxiRkYwdkVNaHFUdEZLQTBUak02ZWt3Q1JMVDJhM3ovek1aYTdo?=
 =?utf-8?B?Zk9UeUhja3dnSEJRNHQ3ZHh4NEp4clNIYXBqenV5ckdnbU1vL09Gd2FQRVRO?=
 =?utf-8?B?UEs4YVpYcmtIa0YwdTI3ZjdOV3VpbmlNeXJOeXEzSEZST2ZJNnZ4K1N2bjBt?=
 =?utf-8?B?Zmo0VHhDWUI1ZUhhRU9ZODUrWXVobzBsMFg0RmtoVVFpT0JNZUtjM1pZZFdm?=
 =?utf-8?B?cVp0Tmt3RnZKYy9qeDZpVy80MU90ZXhRYzdJcU1lMmFCaHRsbm5ZcVRPRURH?=
 =?utf-8?B?UWFLQ0xaOGdvK0krRG1HWXJ1cWgwR3g0b1dBZ2Z0anpZVDE4Vld3MG8rZjVI?=
 =?utf-8?B?V1FYQVd5TldNbGZXTjNVSXkrOUJpamJITE9UUGtvNnN2ck94K0lrRmZnRnRh?=
 =?utf-8?B?ZmRCS00yQy9xQ1Y2d25EbmEyRlJUQ3JRRFVFR2hyQ2lqVDI2aUlJa2hkNjZO?=
 =?utf-8?B?dit5Ull2d09oZ2Nxb2VSWktaeGNlS2FoekJyMjhORHdDdnBmVzl5ZXlaMWky?=
 =?utf-8?B?ZjdnUk5oMUdxdUFUUzlGczVzaGdwT0Q1cVBTZWxpMFQyRytwMjdEVjRpZVh4?=
 =?utf-8?B?MUh4V0pzTUlNd2lqVzQ4ekJIeS93d2RTKy90VHoxa3ZnN1BvanZMVW9hNkVS?=
 =?utf-8?B?cURodWUrRjhCaEc0Y1JoamdDQ1NpaWNHcTUxSk1pWk5taFBZODRDT3o1N1dY?=
 =?utf-8?B?eXg3bDhJcHIyNHRWK2orMi9yMWZ3M1hCUWUxRjRSdVRpMTdBRkM3VU5kRjBM?=
 =?utf-8?B?NDZWb1pVNXFySXlYTWVqalgxTjJVMjRyTkczRUE5VE5oUUx3clNXS3Ztb2FV?=
 =?utf-8?B?YURVNm1UWnh5QVBlYU52NCtzK3pLZStzYWFCaTVBWE1zT2pYM2xqMzFnV2RX?=
 =?utf-8?B?clAzenVXbkxkR1ZVYkxKTlFkaGhTeXl1M2taWWk1NUR0djZ3K3lscXU1cVNy?=
 =?utf-8?B?ZVQxUCtDOHVBZGxRbGMvVG9XUG82OElMTnp6YlFGK2lleVhXYTI0aHAyT25w?=
 =?utf-8?B?TGNGQTZmdVd0Z3BPYTRDeGJLeEd4K01aUXQ0KzQvMm9EZTUwbW9hcVlMbzlC?=
 =?utf-8?B?R0VsbHVReXR1Q2Z4N3R4ZDdmdzdVUHVrcFI3OHNraWVBWm9WQXk3V2YyQlV1?=
 =?utf-8?B?aVpBckxZWUkvdjE1SHlxNlg1d1RRbkZVS1NGMnhxNTU3aDJoUHZpeWhMSkdz?=
 =?utf-8?B?RE5HZWFXOHRldWRqU0FCdS9uMVNkaUdtei9WRGk1d282ZnIzQ0JwUk9kWmJH?=
 =?utf-8?B?V0FYZXpkcUdJRUJEaXpMV091blc3QlgzQlp3c2dFWnlKVmM0bWl2TlpkUXN0?=
 =?utf-8?B?SnozaHlWcURYSngwUFptQkRVOHBiT2ZMSU1TdTI3Ui9KWkVmSXhsM0x2dXZt?=
 =?utf-8?B?MVN4d0FJbjdHc3dLWW1TSXh0V3d1akIwMlZYZmxZQTUxY0RkZEgrT1ZSamUw?=
 =?utf-8?B?ZFpMcnJSakVzZ1F3MjY1QktGaXQwNU1yYWxIYm9jZ3FNR2E3WEtnSnNFYmQ0?=
 =?utf-8?B?ZjUwVUZnYURtU2tCTFhZcDBSMjRqTDNPUExyVVE3amdqK3QvU2dwQlR6cmtw?=
 =?utf-8?B?RWMzMEtFR3VrbHFvaFlhTmFjRDBwNTNXYWpxU0NQS3dySGIzbkJxL25jRVll?=
 =?utf-8?B?c0VLM1huSUxCUzBMYWFRUk1yTDdlaUxOTkJybTdUUVhxMUFNa1FONkZrWm9j?=
 =?utf-8?B?OG5ucXVVeHBWTlJsNUhRTDBFTFk2Vmx6WmNOMHNBVnh5ZGw1WkNGbTRLTy9p?=
 =?utf-8?B?cnNSUHFrTE4wekFmZUNkUnBFemhldUgrSGVUSHpJUVhGWUdmQmpTNkFnUGpq?=
 =?utf-8?B?NEpFaXBuOWJnQmNWbnI2eHBFc1dIaWlERjd6RlVqaUYvZU5PREc1UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9ad4da-dbc1-41da-6f6c-08df3fcfb6ef
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:42:27.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LcXIej/IL3+pVITcI5rWVjp2HqF++sXjN/rZKT1xVBtXD1ZsaPRjMqg+RIcKhQZQnzoDoXu6/73oRbzgJ0d+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8270
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 10:11, Frank Obergfell wrote:
> Document the vendor prefix for bytesatwork AG and add the compatible
> strings for the byteENGINE i.MX93 System on Module (SoM) on the
> byteDEVKIT carrier board.
> 
> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


