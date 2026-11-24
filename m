Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F2606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EQlrv0Pj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8292C10E300;
	Tue, 24 Nov 2026 20:32:55 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E15910E300
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1N5+pQFVfC/PZ4COyUwI0yJud9rgCPEaqOcZHRl4i3jlDWtlEY5a0sK3txNyy4MQC+I+BBNDB5qH0gcVIZMMizvHMFT6CS15mSGBOEoZIRvgQyA+xzQzaRpQr1ssehvvBkLjc9FTxIIx1fs1kYTZybWuVH69d8hQtjd3UFj0q1APnMZLr7qYcGIH3jxWSfXT8ZdxhX36DaZhV3jwoFjWSs54eO/rHl1/8HdRRNQDhAGIERso98PAfrYt2SHN9iuCHFXOVdCRr06aW+UI46REDTYAejFLkNhuuHFUbpp4t1YmozQtCHRJivaOrYUKRc04nxNafvn7vCCRJrpQlk8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeN7EtCxFjFyK9Cyolxr882yiwzOGhdWlX+Fhc8chJM=;
 b=w5Ee1TnhED211Z/IsfFF6VmvlnimxP6IVp8nHAuGy6gjl68dEyQLpSQQs4Er9Qh9RiQ8lT5s9ef5EBshbym7MzEFxpKiN9izYKv0Y2KfrSK0gjy3xMZmAkK6lHgzZz+Jf2v2S8MSai3OOMMjteA80Z8rbJyZp/0Kb5bYW1nKkCAw6I9AcQDdXVRR4vUg5Eulp2654dzDArUUKhNZNUzhnVw2qHVL6/nJ/RMXr9r8DRw6bPjDXLxLyT0O+6EvbRTjsH1+2LC5YcusX0iKaNnFicwgikNmc1jcYB773CP++S0Cl/bv4SEzML7KZsxIfzlZHJeH0olV1cESHdrtyWijCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeN7EtCxFjFyK9Cyolxr882yiwzOGhdWlX+Fhc8chJM=;
 b=EQlrv0Pjhlgf970LMxqE1y6ZGe/m/6GXrUHkGHmZqBU2N4RHahlBMyWN7yFfePNP/RtCC3SM378+35LITmx65jZMmoBaNLXa5jr20tyq7C9pgad1O9+FknQVjnhoNIccGYk264U/YB9jnU0lvUujtCmxCUBOdQlC3gvJSYjRvLTVacNmDQbWkNkcTedBJV4zwE2eJo4NV1QZkUgpycGIkVnKM9RmSwRUA/Ebfni8svyotHtDu7SqefBNBjkAfZdRHh2InoBSmoxI2Y7z8PqDwBhjJkT1/WEM72dAs3ZdW6QahiSk3Nf1DQtxhI2p3ke1yGdwQQpRksQNP9yiha3PqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MMZPR04MB618476.eurprd04.prod.outlook.com (2603:10a6:190:4f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 20:32:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Tue, 24 Nov 2026
 20:32:46 +0000
From: Frank.Li@oss.nxp.com
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Cc: Frank Li <Frank.Li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] arm64: dts: freescale: Add support for
 bytesatwork byteDEVKIT i.MX93
Date: Tue, 24 Nov 2026 15:32:37 -0500
Message-ID: <179555227333.1032701.11663881152667132012.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MMZPR04MB618476:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbe9ee0-7c03-425f-bef7-08df4a6a193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|56012099006|11063799006|261028144727099003|261022105027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: LJVSJYycpYP2MawB7bpvpj0aYVgAUBKNpWumRsCYxuJ197H0SoVVWxMqf4zaUuS02EkkNAJN/i1bxa3Z61uXuZSu/wsrzzFWzks+K3/7XNk1T2ydipJEGi4LMgdLwjAfcwycG0hmgtnVbAEVZxaUzo1SLZvNb+P1tIton6LwAPI3g9kZH24V8dUJuJRE11rGrF1uQ5CDT3tZ2C/F2DGlbY+3IizsPDg5b0Fqxps4Rr+QyxXiay6EaA7WygUgHjLd1SHWzW4dzM2ZdLtCkM0qT/GO2YzZqIuFdD6oTdfpRfF0tYtnPo/XULgwqev91MArBf166wMprA4TRToPY7TJ8oLGBqi4Dy3+GMmB0BZyav0J751d+neHi/NflQQBKQGgk6+64SopvIuk/JOM5hN9ZDRknn7dbf3quGnkA8GNq0RDI2xOB7PsfmlC7iIsi4O0zZHC8/6J2VacpmXKZB6cll4cx129b0OKyngjrgeY6/pBMKRCsHSIe5qN+MkjIyWprXBPmQK9l/jlvSCYuzT/HadWmbIhOxM7ydptM5E77nu6Cy1C8HP/rOKrdkdx1/Whp2HIuZMcw+Qm9l270aD7+agNIQ8u9UfN0jelsANjezRBfTcQfqP+ZB1sSoAWpGFMLqj/ip4v8wEOH0CdYtyP1xgXjUjSJDP4vuAmZW0XPWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZmVTNiUDJ3b1R2MmJqL0ZkZTF6UGxucDhNZ0c3TlVBRnFlR2svdVJNSCsx?=
 =?utf-8?B?TFhUaFhRVWx6YkR4NEdscUpxYXQ0YncxN056bmxmRWdaOTNWTVhVTG01L0gw?=
 =?utf-8?B?cC94Z2I1alVqSUw2TU5iV3JOT2JrMjlVcjRnekNUREI2SVdnRTdDU3hvek9Q?=
 =?utf-8?B?ZUQ1dkNsa2hUTHpNK1pVSkhyMDRyL25BRno1TU9adkhxam9TczkyWW8xdCtG?=
 =?utf-8?B?Z3Q5cUMySkNoc2ZBQnAwc2VxQng1MDljZ2IzaktDZ0xDTlkzQ2Y5RmJ1dExp?=
 =?utf-8?B?cFpZY0xoUXFzYXEvK0k5ME96T3J0NldsdzB4dEV3bUplTysxNUI4QTU2eis2?=
 =?utf-8?B?LzBCL3Z3bWZHSm1jV2JVclBYWW82N0tqK3JVcFdlL0EyWXYzL0xMU3E2Snkz?=
 =?utf-8?B?V3VnSW51QUJGUm5yL25wL0ozbzh6LzFxK1VZTzUvaEYxclVxOGJ5d3VKZ2xO?=
 =?utf-8?B?Vm04L3ZXdFpucWRxT0hHZnBKSlp5RjZSZkF0VEQya1Nqb3VCdUJZZlhtcXli?=
 =?utf-8?B?L2RaaUVGTjdObk54ZFRzY2hlT3phRkpnamJRaWZQbmhFd0tIczdTbEFkMjRl?=
 =?utf-8?B?aHphTzQ1MTV5TUU4bVhWNVlKUzcraWo0MTkwbE5HVm5DZVdnaVF2NkZTK251?=
 =?utf-8?B?cjNlWldvOTR6clJnM01PSWVsb2ZWWktSRkJ2c1dNSHhTVStyYXlvNVhOMEVq?=
 =?utf-8?B?dzhjbEpMVC94Zi8rQ2h2MGRiNXNLem5HdDE0djh6TGV2Mm9vNHcwVDZhSlor?=
 =?utf-8?B?REdtWStZb2FTSWh5RTFkYlZrZUlwQVFNcm9RSDBLbXlKb2g1dnVud3dodHdD?=
 =?utf-8?B?K1MxajFBWksvNHhQQ1J2MUZYRTEzTWRVYWlrY3VhcWdickJJdW5qeEw5RktW?=
 =?utf-8?B?aUZVSlNUOHprZ3duQ0ZyejJhOGEwMFBEeVA1UHFkN0R1V1pwQTd1cEticEZp?=
 =?utf-8?B?cHpYS2dUbTZBbU9VUXhHVGZTdDA4WWVUZFo3RjNrSGFDZ3VlVnJZK2ZER2lR?=
 =?utf-8?B?WGhVWVg2OHFiVjlxQ3RCNTlYUzdEbElLbWFDVjR5dzFlWkFqa3g4VGVmQnVj?=
 =?utf-8?B?U1Mza1pBTDAyL0FnRzNUSlJMc0R2Z1V6WkxDc256SC9vd09uZnhnZmt4bmJk?=
 =?utf-8?B?NUJCa1hJTDhIdFlKL2xHWFdEc05xeGRuSzNyV0dRZmxtMkRtRllNSGhnd1ZM?=
 =?utf-8?B?NzA3Wi9CMzhyT1Vob1RtZzJKUTJZamdmMkhpL21ONzlRZGVTcklMUnEvaDNQ?=
 =?utf-8?B?dmVISTFoeEQrQnMzN3BRbXFJcHZkN2F6Y0Yza2RWTUxGek1mSnAxaVZCUXFz?=
 =?utf-8?B?MnMzc3FkdFVHQmV4K1l5WGRzbmRLK205MG9maGsxSUtvRnVBT2ZZZGwrU2xl?=
 =?utf-8?B?aTgrTGt2b0lwTHFQbXAwNW5NbmhibVRVbUJadkcrblRGdXY1eEZoT21tdVlF?=
 =?utf-8?B?UFZ1cHZwS0tnOW96VTNxcDdpdy9CNlRuNjhVdXBxUGZuVWVOWEl4eGtvVDNm?=
 =?utf-8?B?R0lzVGEwc3FBcjhoMW5FQ0w0RnpLSGhKYVRydXhydzdmcHVMTU9iZi8vQUhU?=
 =?utf-8?B?OHRtOElYSWlNdkdkYTk4MWhuS1JrRXZ6R2RGd0prbVRUWG9RQ3FLVXpEUDVG?=
 =?utf-8?B?aklHM3FUZkY4cW81eGk0VVM2aUVoL0ZvNEVhbGU5c0ozMXpuTVhVK1RoejVD?=
 =?utf-8?B?WDBkdGltRnFxNGIwaWdHN1prem55SUJ3SytUMFJ4bXExYmh6c0FYdzRVdE9V?=
 =?utf-8?B?ZEJXZmdsUXZRTHRTUnZRci9MWWM4RXVyWW01RE1XeDdYMWJLSmpLTjRaRFEx?=
 =?utf-8?B?bUdERmkzaHZETUpOR3NMay9SNTNnakNJVG1QcTUyRVdRME8vejF4dUpRTTNa?=
 =?utf-8?B?cTFadzRGRzN4c2dkcGxZOGczZVBDMCtjSUZSWVh3SUgwUjl5NkZ5Wlh0aEFa?=
 =?utf-8?B?TDZaY0tsc1lkWVdlMXF1eHJ6STdEVUtwa0ROc1ZONEZkRFhjUkUySXJhZTkx?=
 =?utf-8?B?WHpQOVlCLzF2eUVGNWlJdjV4dHRkYXpJcUJCTHV0ZkVaeDB1YmJ1S1dRMElX?=
 =?utf-8?B?Uk5ZNHBNZVJJVGpPY2NNSEpuWkZpb1NXK3lGYSt1K2Zvd3o3UndGR3lrWTla?=
 =?utf-8?B?MXBOaCtXam1adFZxekQvUXFGUEZqK3FReGJiYmFIMFpQcy9Yc2NJWG5STThy?=
 =?utf-8?B?L1B2MElDamtWazZZSmxOUVdEejhoWXpHaFBKc3gvSEhlMnp4VmlpMmtxcE1Z?=
 =?utf-8?B?RjFvci9EUUJld3hJb3pTSGdoK0xNT3ZhNDcyOFlVMUJZTWxEUGFXWW9lbXlj?=
 =?utf-8?B?YWs5czd1aFFRUHdjakZISm9USldLT3RYT1ZRN1FaS29kaUw5Vi9GTUQwT2VJ?=
 =?utf-8?Q?zh+JdkLEzMpmJvGSWl4CEUMgC3X7dF9eHmCOC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbe9ee0-7c03-425f-bef7-08df4a6a193f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:32:46.1350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqGHMTWaF41XDjnIb9daV9xTq1FAnSjlISLAr4C3cjae2ihvKMJZdpniqud5r88BgB4eDL05Bs2ICnjUzNO9uWiW/kvyT2W+zk4HaOZS/2WQ5zz+PdRSiFuvyBU5ImXs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB618476
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>


On Wed, 11 Nov 2026 14:31:14 +0100, Frank Obergfell wrote:
> This series introduces support for the bytesatwork byteENGINE i.MX93
> System on Module (SoM) and the carrier board byteDEVKIT.
> It also adds display support for the integrated Youritech et050fw01-kt
> MIPI-DSI panel by extending the existing ILI9806E panel driver.
>
> Changes in v3:
> - Patches 1 & 4:
>   - Added Reviewed-by tag from Daniel Baluta.
> - Patch 5:
>   - Added imx mailing list (imx@lists.linux.dev) to MAINTAINERS entry.
>   - Moved controller activation (&lpi2c2, &mu1, &mu2, &usdhc1, &wdog3) from
>     imx93-byteengine.dtsi to imx93-bytedevkit.dts.
>   - Removed unused LVDS backlight (lcd_bl), disabled lpi2c1 node, and unused
>     LVDS pinctrl groups.
> - Patches 2 & 3:
>   - No changes.
>
> [...]

Applied, thanks!

[3/5] arm64: dts: freescale: imx93: Add MIPI DSI controller node
      commit: e9d67b72ffcbfa53c76092827ea084ebd7259436

Other patches wait for panel patch pick up.

Best regards,
--
Frank Li <Frank.Li@nxp.com>
