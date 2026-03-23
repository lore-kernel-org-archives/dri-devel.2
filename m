Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8419EC01A1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308D410E095;
	Mon, 23 Mar 2026 08:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="l4hRP+dX";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8A710E0B4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2hWRBm9qJoQHvvg7j/75KYFwirunSzxBqsb8IujuRHDDMh93+fPOqflvGEBQuEZfPvF1D7b2twqNlE6NV9KYQJV8+LASHILXKnTwvIdpoFpG74SsEXj6RPrxsrT6TcB+SkijQ151w9x0akJN+YdmZLDPQgH0t3pUiTXwM4XJFaqqkNlI1w0UfNDhZedb7QSszJPZqCEQstJTnrx+9xR0qvNE86dMC9c+g2QfUMy2GsWwumh+IQ3lAogizrQpDuBbSCucJqA9EDhM0npxEbnlx//R3hyRJx8X3YgOR7fF8Mvj4Gpvr9+nww+hN83vzZ8bYYykTTw8phYtf2KO7H58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcX26sg5zcztqc0CyyT8SaTd0lXKkgoRfRFeF1vMH/4=;
 b=L++zL5791373juEVaaHXt2TFghGcbfZ9YE/58+RvfFSTkUWg8fMvRb9czxWzw9za2fr9Bqh9gDsaM1jIrWmT40U3+o7LScj5dZxKwozrwypLDGUHW2V93ykySFKwqM8EYG7noF+HCqbPoJESx5Zd75KLGcCALbD5RJpLinKHmVgmB993k81qjROWJ8Su0KWaDbnbR0aV2ctd+8fWmYmiamGf5ey8fbfRo2JHYF66FvEuq5eGSEp4ll9BUGqXIZxv+EurCGGtNTqvJJAd0rkaAvrG6X799utThF7qdgC9V1/gpD8bMqhJ4Ay9IxPtQVIK8xtJIT65GF+EtgBxxLKwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcX26sg5zcztqc0CyyT8SaTd0lXKkgoRfRFeF1vMH/4=;
 b=l4hRP+dX/DslJRsj6VLH2K7dZcCIiQQCF+Wswh7WK/CpogqDlkmQtanKN3ckIXEXBecIpw4YUdzreICrwHKVugCt0pqhlyk+XvMBXxrEXmzv2OzxIdzNup9gq0E1bf9b68ddabdHP2oE2Z/hKRynXQAFU6W47lu43Et80nLteuZvsVLx/DT0IkEr7CEYOuV7hJGyBv8ZVm9R2KMhX1GKqg2qaDhqOKBtr6V6VUSq186/8gfSz+hfVOA8xMBClB260FQJyRzfyseiCiJHGrPdazhmgbokLouJe9TDrkzqXoVgmyozQ+JcWQvw4ul1P2JcFGBOiZiyc9ZocHvA0J/W3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GV4PR04MB11975.eurprd04.prod.outlook.com (2603:10a6:150:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 08:17:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 08:17:25 +0000
Message-ID: <ecd02f87-c4b7-44ed-8ecf-98e0990af34a@nxp.com>
Date: Mon, 23 Mar 2026 16:18:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8MP: Fix HDMI LCDIF FIFO underruns
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Maxime Ripard <mripard@kernel.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@nabladev.com>, 
 Stefan Agner <stefan@agner.ch>, Simona Vetter <simona@ffwll.ch>,
 imx@lists.linux.dev, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
References: <m3ms04caaj.fsf@t19.piap.pl>
 <32317022-3c44-4ead-9e2d-04caa12b28cb@nabladev.com>
 <m36pvjbo4xy2rtdymshjpmwu7icl3wlyiwcmmjaozo7jpe5lqk@zt7byx7iwmym>
 <20260320-amiable-hairy-bullfinch-28bfda@houat> <m3a4w2d4ds.fsf@t19.piap.pl>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <m3a4w2d4ds.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GV4PR04MB11975:EE_
X-MS-Office365-Filtering-Correlation-Id: 78948a98-20ad-4a40-3db9-08de88b49d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|19092799006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Pc4kgNQw8JEGRINVqJu+5uGAoGipcYLdrMguegJYO/GKwf8JyBIpur0SeXeD+Qd7S6JFRo8w7eft9otPZfScW917UcKgL9PCm68apybgjwNu6eiIVQuenKr+FN/lIk4KMXGNUcWqwFSDIz+AZ7kQVNh0K2gFDKE5/HmVodVgFGir51gx4R1a+4KlYb1uHXBtyKXi8SBOCDvX+6zbKHN85VMwivRbLV2Amhulxpw8WErtLrxVouALPkDgReLrPrZLxn0mh5cBDYIDcKtyIWiEumH6e4bPPyzjI1SC0WN48R6aJMWYJoJ9t/1QmyF3MuWEQ7UBx9MPHDWy8EQfIA4n2P3Ge0pyMzlqqTuwlaBCdSZJeCOdc5OhOE5hcYT0wuW13D4rT5Qxi7XTdNvtCMbW+1Ux2eh7MYbv6sUmT7wfrBaM6RrFjJhC2Nt6DRT7s86vK4OaGoyoxrqfkt8xm9+guyisvJkCe4EpHakBAnYGWP950cVPgqdygXB8Y0EZTJtZg5eRS6OoVeHeKeo3aJDAn92TQROa+bR5qBYyEY0u2VaprKejKYi2HxZYhuSBFCU4u3pLuRsyhJWPLCmsnJ7hxeEKTPK0LY0KJB0Wz3g99lFq0WYm+rcz7RffV4qjPCLxJP/vb9n/kZGtyDjGF+fMpUa1+keLXcTN19qcG9mleBbjskICd4W+RNhe9cSTkUnkwiHPGenyS1qgY2RzHAbleJuh+tZDllOcZi18YpuAMCK/yV47CGA5Aqkc8NrLddV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtDNndSdDRvcWZ2dURLaks1NEJpVmh0WHV1bFBQaVluM2NBR09QNXJGbHFT?=
 =?utf-8?B?ZnhmMWxlcU5kakEzT1NKMGFydUdTbmNoUlRIWGdpOUFWY01qQk9QOTFGZkZK?=
 =?utf-8?B?NjlZeWN1dC9VS1JFNVdJd0JyWnZlQUo3WW1tanV3TC81ZVJsWngwZ0Rzc2dT?=
 =?utf-8?B?NDdaYzJMUk5TVFNlSTlzekxJbWlrazY0UWdOdVVuTHBSZWFiOCs1UTl1UjZL?=
 =?utf-8?B?TVlGdy9FMVJvb2RML1EyUVhRdGhQRjVtMkZ4cmY2U2Y2VGlJZXYrQkhjcmhQ?=
 =?utf-8?B?UEg1dmhQRytvRkQyRFJKcFVzQm9lZ2lyK01PdmRpVDlJdTR6VUpBUTUwV3Qw?=
 =?utf-8?B?Q0lndUgrdmVhM0VlYzhTQ3pEMjNvU000ZnhiN3ZSRW92OW1lNGZlYnZSbEpk?=
 =?utf-8?B?OFlRSXFOUGc2N0Z2Yk9Xb041eFUxaEdHcUU2S0dGRFpNcXk3amRWRVk2UXEv?=
 =?utf-8?B?UXQvYVhydHBvb3dOZjJFV05pMjNLZWxDeHZ4eGl6V1U0NnExbXlqTjEwdlZC?=
 =?utf-8?B?bG9TMEsxU1RGdDg4LzUxRDFFUFZZUTAwc2JoN3kwR2hJUmZMR1BqenNHS0V2?=
 =?utf-8?B?U3NuQS96RS85R1V2WDZ4bUdsNTVMUGhvT2FicHc4SUp0b3UxR2h5QzBLc0Fk?=
 =?utf-8?B?ak0vMFpqVWcrdittV2cvNTFLT0FZU1NjdDdLSElNekhoSUpUS2o2N21qMHJy?=
 =?utf-8?B?MVZXalB4NW5vS2oxcmFTUE45K1pYd2FZTmcrKzZSS3FNdys1N1RieG0wNis4?=
 =?utf-8?B?K0lKR1VKcWxWN0haTFhvOUtybVE4clV2Z3dHd2p4emphOUd4WnZiRXUzdUox?=
 =?utf-8?B?WGdLdjdlVkhQcEZWb1lHYUoyQSt1TlR3VE03ZWNLSmJNbzdQRnU2aXMzeWFN?=
 =?utf-8?B?ZFExWE5GcXFHMTJDWWpYbm1VZVhEcmxaUkxEa2w3RTA0Nk91N21KWjUrdUZp?=
 =?utf-8?B?WkJWK1Z6VGY1VXZ1WTVYSGQ5QXJIYWU1aGJaMEp5bzFiTTRKZzdpbzNGaktU?=
 =?utf-8?B?THByTmJCSURidnhOYjY0Y2JPT2FDODNRMG9mcnNJRGxud1ZtS1NBMTcxemp1?=
 =?utf-8?B?V2QwcVg2azdYZHAySXdyb0lzeXJPOVFaWU1wVXBnd0x4TFhvOUk3TFJ5ekNy?=
 =?utf-8?B?d0RvVXI3dWRBaXVnRm9XOWswb2QvZHgzdjM2bnJHejFaZEwyYVk1U0xMaTdn?=
 =?utf-8?B?NVNyWW54RmZEMWNPOXNMYmVzdkpCY0V5RlQrVXNNT2hQcHZIYXMrZEloWUxJ?=
 =?utf-8?B?alNkQU5rTU4zRWhFZ2t1bVJGVWFCdmdlZjFVOFl2SUlobHJJU1RoNzI4TUhw?=
 =?utf-8?B?b0hnTGZWa3ZXQjc4ZGpGNGJJZTZWZXh6Z0w5RVIzNUQydEJYK2xqV0VqTklS?=
 =?utf-8?B?QmhpVFFsUGRSaHBBa0R2Y25EUDdlTEM1VlVGWDl1bUlOcS9CN3lKNmdZWFZC?=
 =?utf-8?B?b2czbllqUHNTRldldzVnWlBCbFZLMWJ3Z0xzaWsvcllibnZVK0p2Mnd3SVFN?=
 =?utf-8?B?TkxtL0pTWkQvdmZ4RDVHdTNJdzl1SjNDRWJyb0JkYW1BOGVWSjhaTjZxT0c5?=
 =?utf-8?B?dkpDbTM1SFg1a3RsKzhKWGVPMDZ2NzVpNSt1UHB2QmpuL0l1K1FvaFV0ZTMy?=
 =?utf-8?B?QXEvcXpPUTZVNWJkb05tTEdPaU1Db0ErVmhUUFJxREZBZXNJWWxCMVY5blRv?=
 =?utf-8?B?dDBhYkQ1aXlmc3lha2NQbjBQNmVkSU9GZzczL09oSEo2MkNTVHBBcERSalhU?=
 =?utf-8?B?c2RFVGowNUhNb1g1cS9zN0g0bFYycmF6NXRXcmNsM2lXb05kU1gzWWV0czU3?=
 =?utf-8?B?ZnVJdmdkOVF4V2J0UFBoZGhHQWd3eEtKYm1sMThtMFNSQXFhQTlsekZUQ1Ro?=
 =?utf-8?B?Y2s1L09Qekx3eUF6UkJmVSswd09Jb0NIVTczVDRpMktLUmx1bGNWaDA4NXNS?=
 =?utf-8?B?bXBEL3A1b0tjZWx2UkgxVkNidXpvaTRxVzY5dktPajZkbUlnTjVuT0xvbUlv?=
 =?utf-8?B?RUdDR2hNMmlQRCtNY3oyZ0Y5L3E5bENLQ0hibVZHYU9wYXNQaWFZMHV0QVQr?=
 =?utf-8?B?TVpDYnc3T2VLUWdDZ2VVWjRtNFJuODNCZkNPYWtpR1JUSER2ZUR4ZE8vZk1y?=
 =?utf-8?B?Z0VVbUpTVlpIcjVyVC9JOEwxeE05enhtREdwMDY2TDh1dVBHVWZWdUhHcW0w?=
 =?utf-8?B?d2ZyTVNPSUJ1enZKV2tOYlI0WTdHWmxpY0k0WUZ1ZHlaekdqOG5hUGNndUR3?=
 =?utf-8?B?cGFTY3A1YUJjclRzbURRUVFWOVZyYkVHWDNTa3NwcFh5WndONTJGWWJQOFdx?=
 =?utf-8?B?TDlNWWFzL1pFQndsNyt1OWJtSVQvazg4VGkrdGFXemNUdHZoKzlTdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78948a98-20ad-4a40-3db9-08de88b49d84
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:17:25.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iowsDa2D3WsmX/OkxtE8Qqi1nKRegwf0IVLGIkSwFmxzAB4KwvzmifecN7RmU/glHqhOpp0jCW4kL7eSOiHvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11975
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

On Fri, Mar 20, 2026 at 02:20:15PM +0100, Krzysztof Hałasa wrote:
> Maxime Ripard <mripard@kernel.org> writes:
> 
>>>>> -	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, 1 * PANIC0_THRES_MAX / 3) |
>>>>> -	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, 2 * PANIC0_THRES_MAX / 3),
>>>>> +	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, DIV_ROUND_UP(1 * PANIC0_THRES_MAX, 3)) |
>>>>> +	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, DIV_ROUND_UP(2 * PANIC0_THRES_MAX, 3)),
> 
>> If this is related to the output resolution, the DT is the last place
>> you should deal with this.
> 
> Well... just tested (v6.19 + patch) with 2160p30 and, surprise surprise,
> it doesn't work for like 10% of the time. I.e., the display may freeze
> at weston start and/or shutdown time, but otherwise works:

If you may use a display mode with low resolution, say 640x480p60, and
the issue still happens, then I bet it's not related to the panic
threshold settings, but more likely related to KMS detail control seqeunce.
This reminds me that Lucas had a patch series[1] to try to fix the
sequence, but it seems that it didn't fix i.MX93 LCDIF according to [2]
hence no landing.

[1] https://lore.kernel.org/all/20230928113629.103188-1-l.stach@pengutronix.de/#t
[2] https://lore.kernel.org/all/AM7PR04MB7046FF021B8BA46EFB758BA098CFA@AM7PR04MB7046.eurprd04.prod.outlook.com/

Cc'ing Lucas.

> 
> v6.19 (frozen screen while starting weston, same display, the patch
> applied):
> 32FC6000:        2        2        2        2
> 32FC6010: 80000000  8700F00  12800B0   480008
> 32FC6020:    A0058  1000007        0
> 32FC6030:        1        1
> 32FC6200:  8700F00            223C00 EF000000
> 32FC6210:        0 89000000                 1
> 32FC6220:        0        0        0        0
> 32FC6230:        0        0   AB0155
> 
> OTOH NXP's 6.6.23 works all the time:
> NCP v6.6.23 (a different i.MX8MP):
> 32FC6000:        A        A        A        A
> 32FC6010: 80000000  8700F00  12800B0   480008
> 32FC6020:    A0058    10005        0
> 32FC6030:        1        1
> 32FC6200:  8700F00            A23C00 97C00000
> 32FC6210:        0 89000000                 1
> 32FC6220:        0        0        0        0
> 32FC6230:        0        0   AB0155

A newer downstream kernel with newer kernel version dumps reg@32FC6230 as
0x01000180 instead of 0xAB0155.  Note that this downstream kernel sets
lcdif3 thresholds in DT:

&lcdif3 {
        status = "okay";
        thres-low  = <1 2>;             /* (FIFO * 1 / 2) */
        thres-high = <3 4>;             /* (FIFO * 3 / 4) */
};

I didn't tune/determine the threshold settings for downstream kernel, so what
could I say?  Maybe, align upstream kernel with downstream kernel.

> 
> 32FC600x 2 vs. A is pixel clock inversion.
> 32FC6208 is config P_SIZE, T_SIZE + pitch.
> 
> More tests after weekend.

-- 
Regards,
Liu Ying
