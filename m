Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A29606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AWbd4jrq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BCB10E8AA;
	Wed, 25 Nov 2026 13:02:18 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011013.outbound.protection.outlook.com
 [40.107.130.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA3C10E8AA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RecQWHcf0g/7phsZhG6kVT1xfoMmFPKf3VWSRx3g5gx00W66A+JCsg32K19YAezwF84XNl1JdXcVyZlY3OIdrL0CXiGIG0dQCiY/gNssxJQnPFzLVoTfS0hP9ujjC42xSVrTu9GqwVi1SBe3US+C7SBNY8doFFKXx3TKr7HiUJsnpnz2x9mtie+BE8eQvs3xu0TJLXibxOZT1PeZ/Nk7OZBv9lUgkaBhTG1dZif/iZbsPsbgOgn1bNJOaDp9EZV8xBP3obtMhh7Oaq9MLhxCXpzS8GGlzs5SyfqN5eyvnLegHmL3V86SmG6nq9jOASRKWxHsJV7OOOlap/ZZ1tC3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QsMJtJV/CkPhS4NsdJdCHHhtGGr6AOii/eJkT+S85w=;
 b=XT03KaONAKHD9AgHuoTpt7aP6eN08rD8OQv9Zf1K4aQBX6Ftfa9V2M0PN5MOpWJBmJhjO2HEySS/SIQB0gESBtHmm99k7hbU8A8cMfdv3w2zzTZMBRuDMoxT4JiuV6IqbpPYVXg6vc4xdBZrleuvW2bLAu+pSMschW8xsyXhrOkzARUq6DOuWHLlujHEpF5wscfHWJL8xoBQWt91yg9dtGXhvoO4poyr4bHx69fRFKVz/fv3HohxNTT8pYUPa6pYZQ+ZftwkE5/TXDnaHa7Z96xu7aCOlGGARdGAuDAg+Kwyria979b3j075X+/sSq7j+xvhQ2PK9qoOggKGrRbpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QsMJtJV/CkPhS4NsdJdCHHhtGGr6AOii/eJkT+S85w=;
 b=AWbd4jrqPGDXlSAXKHLZY1AHo5kp7odSke/Ch/r61summhzcI/3iQLAwMNJXh5n8j052QdyvEEAXQcvSGPqwvgdBX2ibU5LHbnSeVtD2pXH5a5FP/nA71MZx0UMyA2XEor43ctjB+UsLhkvxtWeaKqrUsyjzWTq+19m3Ws6LY/fiO/LVPND6Iz6jNWnqit0fJRkVipPC7MrJ73T5dvqO8xVmXAAHqJ9fAzUwTl1T4NMAwsBTw5JgfpjqSAjNu2CjJsVsOvaBTXLdbNN2r4sG+B4MmOXmWWCiGWEa4z1Zyi+YT2hzG5DeHNIsr0b8oN29+UzKfgBnA1A32rKjF0Oc6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by WA4PR04MB209098.eurprd04.prod.outlook.com (2603:10a6:1d0:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:02:07 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:02:07 +0000
Message-ID: <92ce4557-a93b-4ef7-af6c-a2c1b24a3b11@oss.nxp.com>
Date: Wed, 25 Nov 2026 15:05:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/5] dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB
 bridge child node
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-3-966ac248773f@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261120-dcif-upstreaming-v13-3-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|WA4PR04MB209098:EE_
X-MS-Office365-Filtering-Correlation-Id: 89148a5e-00bd-4860-4d6c-08df4af44f1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|376014|7416014|366016|18002099003|22082099003|921020|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kFgAWY+SuPfR3RxDJva4i/wWCLc5WWQj8f2NRgSDiYLx1He0SyYjAqnv/aDVsrIix0U5ZhWcCtCcksntcSx0/BfWy5WVYXvP482bk3JtTe7llUV2fYodFTCmpK3NcDKdsx/UlMkzA6B/8D7s5IZ1v+9aNUs0sg62WsxXfhmDi2PnRpK6GkGhp8PA7on9L+d1afj3shCIQXMx/zjus949sFwwn24R783fHxDHjCBi4+q2h4S0XJGQE6OYcB+/mflqazZWrUbHkMe7+4+kxjIcYiKxorVyAaJ0NmQxP3+MXyWO0GzaosLlEYr/tFTbtxSnCyYX4ZSMHJtdLAUaZMZdMRRGDrOBcuFFlME9ZJMMkH/FVE4q9ZB2LSLeepSMQqZTDQfPujRm5TeBPsT0vjNayvZgTjRsl22P8Do4UFvIUFXa2Sa36kRzQsKKSq5SwPdeICCNqS5yikKLoC9gZ9gEjSNDk+oIRcXngOGL+aIujC54wZJQ6JoagCNI6OOyg31TixbrA7CLhRxqaoev2T18x1xLfdkAYeC5x//orM8MROjoRl7GNswEsTWIsl7a8lkUZ3QhYYBWP5PZ8QbY6QcV/zstXiUw0+jXSSA0k/RvC2QVZBxL1SFsa8hj/cd1MXd99f66GTBqe5fqeUsN+KzqPDl996kHnsyq9CHbB4vbxXcNGbbOYU2fUhRQAAzvT8Xj0Nz9Yzu8EF63yUsZiArgLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlTdWZHb0UzdHY0cTNPeGVwcmxzSUE2MzF1dUw0NVBNSnlxQVVCUjkrMUZn?=
 =?utf-8?B?NW5kcTB2SFpZWnVtbzRWTlVXVEo5ZU11bmtESEZnTE1uYkRCMktFaVRBRFRU?=
 =?utf-8?B?QnEzZG1Hd3FYRG1haVU1bklVZ1NHN1FtcSt4NTBUdWdZOWNHaWE0aXAvdVZM?=
 =?utf-8?B?VGhTd0phZmNKM1oyb3JURU45UUtwamUvbzFvR2VLOHFUcDNHTFdvSlBvdEJZ?=
 =?utf-8?B?aExQRzMzcEhrQjFZN3NLd1lYOUdHZW1YUTRCVm10MGZWa2Z5TkJBMjE3ZDdK?=
 =?utf-8?B?L205RXNJVGt3bTVTQXJ1TTVFWUt3a3lsWWRhaVhTSXEyWkNUbTZnWUpCYzFl?=
 =?utf-8?B?QVViTVQzVmhWaEYwTlNON25hK0xOTm9jSnZYZTh2bjF5YitVMlpEQW4vU3ky?=
 =?utf-8?B?SHBraEtKL3FyNnRDYTJGTmRUMlMxMUk1eVhOZkJMTlpEd2lJdmk2TzJoVVdY?=
 =?utf-8?B?VG9ITjhVd21MdnBPL1FCYlRXN0o4aDRoSHVCM3Vid0pmRXdMbDQxRVRDQjhW?=
 =?utf-8?B?T0YvVnlwT2hIcjAxa281cGJFWm14eWx5T1RoQWllakdVOEVWejZWZytaQXd6?=
 =?utf-8?B?MVEvQ3FJZ0xsQThvU1RjMGt6Ry9EV3R4ZStiUGJkcVBCS1pwc0NFVVpvV0t6?=
 =?utf-8?B?SGJyNmR4eXhHQ1F4Vnd2a1BmcUlCa25NajFWOW1oRWZnVlY0ek5uV0FkMFVF?=
 =?utf-8?B?d2JQdjU3MElkQjVXWmgxM2dSQnhIRGxNWVBOQ1NKd0FEMFBMS1JESElNVEpj?=
 =?utf-8?B?OWRDUDVVSytQVVZpdDBzRjZKclV5NXYyMHlsOGJ6MXpaYm1XQmRIR0FCMWFX?=
 =?utf-8?B?clFhMks0ZVA0R0dZRHVYYkE1Tml2b3NEcjNFVzIxRWxlSjVHZjhRU0NNcmVW?=
 =?utf-8?B?ZFEyN0hKZXZLYzYzTkRmQzdSODgzRnVTMjJWcHBpZDRGdnJDOEFYOHpqTHFz?=
 =?utf-8?B?V0MyQ3NGWkd4VjVPaS9nQzNIcGlkd0x1cVdWanZZbHBRWW51WWE4V3hDK2dP?=
 =?utf-8?B?c3ZkM2NCMUtPcmZvYW1jbTl2STNCenk4NmhlVVNyZmk5eEFCUzJUTWRhbDVw?=
 =?utf-8?B?K1VwOGgwczNGNndnU0xVK0grdndLMXA3TmhUVUVnZW02aTU0VWc4M3RvQVhU?=
 =?utf-8?B?OVo2ZFpZRWFzeko4ODEvUndSSXFxSGx0Z0g1QXI4VXVkdG5qRW1LOFFhdjc5?=
 =?utf-8?B?Y2JCWHFXcXJHOEEzNVkvU2tyYVBmVEJOZVNwMnl2cHRvZ0FzVlVhUHNOYzNx?=
 =?utf-8?B?d1ZGVmNqZ0F4MkU0dGVrNnhLc2NzcVhGNzVpSVhpNVhXT0JHbmpGb0dDb0Jo?=
 =?utf-8?B?V0c3VStUaWhFWlJJNHV2aklKT0o5cjJCS1k1ckJEZGRXZGl1bGJVUFowNUND?=
 =?utf-8?B?RzRVSG9xWXRPTUYza1JDMzlTNk55eWw5Zlo4SjU1c2FzM01lclkxN1h3NXZ0?=
 =?utf-8?B?Q0pQQlhFZkNpNTUwUlhya0hmT1cyTG9CVnBtZGI2RHZra1NjbThFb2dtak1j?=
 =?utf-8?B?bFN3Umx6U2VNejhxNmpjalFkZTA4ZVJENnVVSmliZ2ZTUWpNUWFuNFYrMVpX?=
 =?utf-8?B?Yzh2UnRGV0t3My80TXVmRi91UXQ4bElGd2FtRFNPTXpEb2NCMXNiTVYvMVpk?=
 =?utf-8?B?WVlEUnEydGlhREtwanM5UWVvQ3ZVSFZ2NCticU42dUxtMGtWREEyVjF1SG9z?=
 =?utf-8?B?UGV6UnZTQlhaUE8rOExYeFVyWkdCM0F0eXppaW83UTFUTHhINXh4WW1jUlFU?=
 =?utf-8?B?NGJIV2VRRzI0dGNadWVlR3hrbXRWQTIyN0dJeXg1SElQNzZMamRjazFLQ2Fz?=
 =?utf-8?B?WGJTY2FzWGRuQW1iSmhCR0NEQXhiSXZDV0tmbVdFUjA1Q0VGN2lIbmE4ZHRO?=
 =?utf-8?B?d3hESlpwM2REQ3VNV0hlUVBWZVdhNUc3THZLNGJaOEw1c1pvMVo3dkZSZEMv?=
 =?utf-8?B?SlVTL2ZNaU9CaDdwbUt2RzJwWTc2M2JaOWFjQ0pnRHNIV3J3UE9zdnZZMk1T?=
 =?utf-8?B?em1ZSlFzemdaeHIyYTFpcERTajNNQmpMOFlCaGk2eGhzNTMrakxtMXlZY1kv?=
 =?utf-8?B?RTV6NFZoYkRJZkVLS050YlEyYTgyQVJpTHpYWUk0aTl1YjdhSDhTV3Q3UTYv?=
 =?utf-8?B?VFkvd3BTdjNWbzNuYjh0N01xWXpaZGx1L1g1eEhCSTlXUDZqcmNINTZadTd3?=
 =?utf-8?B?NCszbmUyL3RaZmZORjFtT0ZZQlJvQkgvY1FpUCtRYUNMOUcvK2c0V3NsSzhn?=
 =?utf-8?B?eFdBK1RUcXNKNGlJWWNBbVluZFd4ZENzakF1bUU4S3AwRXErUU16T0RZclhN?=
 =?utf-8?B?T1p5UXNSQmlFNHl6K2l2OWRIa0JiK281dXZ5KzVhcnJ1d1BCbWxBZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89148a5e-00bd-4860-4d6c-08df4af44f1a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:02:07.1197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpidVdqUMBIsnc03cHEB+kw0ThyknxnkGkcPXsZ1B19flkWudzkcLfm3ob6ukIttJUSDZx+EwbC+HVuwhrOzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB209098
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

On 11/20/26 14:50, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add a 'bridge' child node to handle
> these use cases.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

