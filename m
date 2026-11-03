Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC40606A83B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=EFztt+me;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=EFztt+me
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640F210E570;
	Tue,  3 Nov 2026 10:59:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980E710E7D1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:59:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TSBGk1NaSpglL+QwvlbYkl0gxCv1eFBwA/h3Q8JtmRm4zlYJbzV8Isz+HaVx60T0JUFmWJNBgWgTL8kpt0RntSYlsh8OMGIAloEQKIRCyQvm82MlcX5EQ6tPlSq0QJctpaHXm2RxmO5oNFQX84d/trWdtmaCpnGNjV1lKQpFFdeVOjeGyHIMly2O+hlmK5rMLik47j8TiFQFyj3qbp3hxgWkm4Em3O9c10bsWwtZIpYLoJ6FsBGC3TCWyEQNHaOYo/ju50dfcHRG4du68+vac5PQvmFmsdWhKs99zoJQ6gwlzWFqGObsoHgx8/xMK0fpVQ3bYusdIYbd6uhn1lCF1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy+T0HXGeblC4mgYhwD5w3c5vhVf2wZDluhkUeyeIzU=;
 b=XQRxNHnz66LGTrPlIMJwOTmfWK0sgdb13rTmeR6di6mLkcvu5uW7yNacqmMHXKbLI8ooZz/lm1ywhvIHClXPHJhDiC+akFSU8jQMNKjPc6EyXXIw8CI0lU1yq8WyCfmUGdsXR92c64hEJ6OjraR3yLpZEAcjzAs58WIh9w6gi6KBW6y0l/4SRnBuoTQ2/AL+og/5VtO6w7f6RO7d0PVNVy9JpmVUXs/VsxuPOqZuE6ZwZCTRK0fF8E3LjqrNDzaG8KHMpTlzzXEvPwQNkaVvOsDPGQrholvrW/mMwtnouzonfwpEnNeYZwd/WlP6WJLPKldmqHC4VI8xA6gzmMsqhg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy+T0HXGeblC4mgYhwD5w3c5vhVf2wZDluhkUeyeIzU=;
 b=EFztt+meB78ogZnnoVmWoIVr1Cob5CwoPwXf/QAbqd+SJTsp1kY8uO4sdBl+GvckzqgRKxod/3j7KGsmTB0M9jAY6nG1gnE+NuYVBDxgpRQlKYZhgHvajyplcgKA7K8slNBSqjURIzn56ykmuqQf4fA/OtX/Y/CoxaTlL3RUZ7Q=
Received: from AS9PR07CA0043.eurprd07.prod.outlook.com (2603:10a6:20b:46b::6)
 by AS8PR08MB9526.eurprd08.prod.outlook.com (2603:10a6:20b:61e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:58:58 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:20b:46b:cafe::3) by AS9PR07CA0043.outlook.office365.com
 (2603:10a6:20b:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 10:58:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.2
 via Frontend Transport; Tue, 3 Nov 2026 10:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXz5Fo5QHSggs5ihaWPyY96vKrQdubIMOyLpDpZRf1mtkBnA4XH880oQSRN0zvHAQSjE4FX533Ebd5857sTjQk0YKlR1/NFWOhHnth+vwOSEtTO+uOTYArdroka2LClzqYhm54EStgmP2lcRgLR5mRxfOamlFcbk1TEpIxh3oiB4bv1JTGo48zxccCfGWEpQr6xjmFjhCXSM3M9OcU2RXZ8qM3A5P5DDYohaeHulqpV/fm+yvaSKxwFOJK4FltShc93hwWJMkEDuJjsOYeqpVhQN7MvBnHMrR/NoHQ5DqXqior1Dm3rMfRuZTBxJzUafU8Z/GMidvejNOqjl8XP8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy+T0HXGeblC4mgYhwD5w3c5vhVf2wZDluhkUeyeIzU=;
 b=psBnY/MUAEe4ZPZMySkpPn8jaxq2B+5zInGSAmE8/NklyZioA4fE1TchL4MKjVhFH2vvJ89mj+Di9RKQ+9Uzip8QSj1QKIEAVwburYDPEcrRV6Tk/sRwAnoP3++7sBk11N9YK7wS0QAW6K0RM77RdbOUUTeDGvhGm2YM6GiCQBKXrwBroQeXbd8JEObicFDc+DNmd6s6ko5y6KPfrvBE7y4ethsESIAxzING8WrGH0ZYO03ZRHgNwFee4t5/lliWVrw3y2nTKS+/ZixK/+bk8ERX227ybtb4MYHCE1BdeNJvrzE1fuQfoa6qfE8LBt81WXEZXt12sm9F2sa56jXSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy+T0HXGeblC4mgYhwD5w3c5vhVf2wZDluhkUeyeIzU=;
 b=EFztt+meB78ogZnnoVmWoIVr1Cob5CwoPwXf/QAbqd+SJTsp1kY8uO4sdBl+GvckzqgRKxod/3j7KGsmTB0M9jAY6nG1gnE+NuYVBDxgpRQlKYZhgHvajyplcgKA7K8slNBSqjURIzn56ykmuqQf4fA/OtX/Y/CoxaTlL3RUZ7Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:58:25 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:58:25 +0000
Content-Type: multipart/alternative;
 boundary="------------wJDZe2zuMm2FDW5nz8LHh1D8"
Message-ID: <6ce83db8-f696-4507-88e1-0e113b8da8a3@arm.com>
Date: Tue, 3 Nov 2026 10:58:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20261030144805.667158-1-liviu.dudau@arm.com>
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|DB8PR08MB5433:EE_|AM7PEPF00000054:EE_|AS8PR08MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: c005e635-1880-40b8-416f-08df39997644
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|261021121427099003|4143699003|261028144727099003|261009223027099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|11063799006|10067099003|22082099003|18002099003|261102123227099003|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info-Original: vqqsNtV0S9iF3C5tqzwwQrlp5JBZecAhMJ4+VSvhC10V/TH1vQEFrMGm2myoKnpBj8OPe2/6E9GLYlpfbNZQkQ5+V4vxvQYueYNWs8kqPROHm6LoQcuVCJ/CheR4+di7DhlVoyDXfa0dhlsD0F9UKH9wWFkBrV7vNmztRdbnPGOOSSb7Ys/cXPQF273yJPUpMR856HN61Ylt/dBGtvmPTJf8BbgiXBV+KFGBMqbeyL6WWO5EePxvwWy2Jq+f7CMVZoJIvgcecE0Zv9hDhbGmx3dwhrWzHY6LhbWWEGsukC45nHKamzEyf6FtXcLTdM3bbhDboEl+AZ+tctECnMwibjA2xzsophsP1nG7+ESdjxlvlgHjkMmiP7RQehSkUsvJ2Y+7wc7XZxyVIJAhQDDxiJb4oxSOw6otO9WGW80/w71F4XgQayuplvkf995VGIv1PllMs9Xzyc+9R8+CgwgKwfcs3b2+mEKY4ZGhalh9U/ZM2JMujztkr8z2gqpPFCvG1871/v3YBltL+7EQzwh07oyc45JVOv6Glb5/AxHOb1BKqUJNpH9L7f+Q2zb+BJbS3cENHV/4CC6jbgwNWBTw5Q9wL03++qPxoZWaM8TAQnY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(261021121427099003)(4143699003)(261028144727099003)(261009223027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(11063799006)(10067099003)(22082099003)(18002099003)(261102123227099003)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NbYj0U9g3tVGrO8kHUzmzAvKZwavlNI+wzxM6P8NvzYIpgv4UT3hXiWK7+kHF3wQVPcRQb4vHmerM349Yibly5arE60QZzQpD110dnDsQr2m5xLGgthINSCSOpuN1W5n1IifLZUmgYU449230paL/O1vh5iYscnHDacuHVdYDZcpuDQmXoE0zt3VJJ1fvF/xqUwCVOr1R0JuJSThA4yfEBBcLpGlz4foUePF9bJoRpoF906DMPBHs7yglech9+pi1AZ541XPkh+asLls+O4RVpmlwjWA42Z6/s11JPz2lVfWKadvHeJQjPpE8k/NE6Ed8VyXY+Ik+/jl2LIvYhri9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5433
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6533f111-16b7-4c3e-8575-08df3999628e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|35042699022|376014|23010399003|1800799024|14060799003|10067099003|18002099003|22082099003|13003099007|8096899003|261102123227099003|56012099006|11063799006|4143699003|261026121527099003|261022075727099003|261022105027099003|261009223027099003|261028144727099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: MvurmiEtfiJwVUovKd1L6vYls7a2zg13Nh+boCR6GDxoQozaD4omnHTjUGuLiKpUTx0q4VaFJQ41plysCxeh34l3ykS6taPOrHeZLV10djIo43ZD+rRJ90GcMqkoZCDldrHG31fcYeISFQCqJShDwH+yO9EzT+fSEBJjIXcbFo+UxiB9n2RGlhrRaLDDRgNn+jSD1tMxb2KyZ0PE2VMHZ78j02fo2XW4xiepngzfNd2grdj39zXCjUKyoXyzDvETiF8ioIXHeGPDkeQifrpWn3O55RaTMtJqZw82AIx9GksnZvJJcWbwhmIcnlZ4g1a2kIS29DWkuAFr6ItgS5n7GHVCv5yX8fhrL2+CK0w0+sB7FckmTjYUL0rLDYakHmmjlRD+LytiPA142QNRULNHESylMgsKm5/8Vj5yYCrPawFh78X+aoEFwV6mdmQTbWh1A01QtVYaclUjV7VCwecTKyZdiWISPA+6Ks6JQdfHeIcsLRilnqK6NYJMCHJjb1dMaT907pm6a2hY42Ufu14EiKMGzdNPbmoDD29fQRobMeRhkjH4aKUTg4tnzIvWBR0kuu7AZ7HV4a1nrLcNfiGY92TEolkw+Bj00OzqVB5fvOg=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(35042699022)(376014)(23010399003)(1800799024)(14060799003)(10067099003)(18002099003)(22082099003)(13003099007)(8096899003)(261102123227099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261022075727099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zZUa51sz7KA2iv2rAldj5/XCclAvPAmvWx042/2NtaY39AlcRIX+PX5zvf8zEUT5pigWtpzDgvT1I90a8fVw0vDJUPgkHuvrArjk9hBKEFq4SJYAUVjkxMZ0i2mgOZO72tXiaahyGqgMtXhENFXwfK2VAQ91z8LkWcoJYqmujQC3WvWlojU+7EXYtSerRPmCI+zhUu3ln8ClI5qssxPULi++63fRBwoZ+8CsYFZSbsAaDExAPaBYAuwMDSNhXyknBmtBhnniYrcQNcqkAV8fYfHmzoVFwBacEgKc2DhgYKq25vO07v5t4h79isq215B3rLqhaJ+lPaPH6pOuFypWU+SZEbsbkP6WtvBHYiN75+D0WvL8vhPcXNbOKNnYnXs5lBk7E8hZTniqiklqppuAbOgVblMD5msAfaURVWoZ75xNQfZDDv7YO8aVTELVvRda
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:58:58.5906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c005e635-1880-40b8-416f-08df39997644
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9526
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------wJDZe2zuMm2FDW5nz8LHh1D8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/30/26 14:48, Liviu Dudau wrote:
> We now have more people that can do reviews and contribute patches
> to Panthor, so add their names to the list.
>
> Signed-off-by: Liviu Dudau<liviu.dudau@arm.com>
>
> ---
> v2: Forgot to add Chris Diamand to the list, fixed.
> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ea35a35c680..ef92c462a8381 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
>   M:	Boris Brezillon<boris.brezillon@collabora.com>
>   M:	Steven Price<steven.price@arm.com>
>   M:	Liviu Dudau<liviu.dudau@arm.com>
> +R:	Akash Goel<akash.goel@arm.com>
> +R:	Karunika Choo<karunika.choo@arm.com>
> +R:	Lukas Zapolskas<lukas.zapolskas@arm.com>
> +R:	Chris Diamand<chris.diamand@arm.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Supported
>   T:	githttps://gitlab.freedesktop.org/drm/misc/kernel.git

Acked-by: Akash Goel<akash.goel@arm.com>

Best regards,
Akash

--------------wJDZe2zuMm2FDW5nz8LHh1D8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix"><br>
      On 10/30/26 14:48, Liviu Dudau wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261030144805.667158-1-liviu.dudau@arm.com">
      <pre wrap="" class="moz-quote-pre">We now have more people that can do reviews and contribute patches
to Panthor, so add their names to the list.

Signed-off-by: Liviu Dudau <a class="moz-txt-link-rfc2396E" href="mailto:liviu.dudau@arm.com">&lt;liviu.dudau@arm.com&gt;</a>

---
v2: Forgot to add Chris Diamand to the list, fixed.
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89ea35a35c680..ef92c462a8381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
 M:	Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@collabora.com">&lt;boris.brezillon@collabora.com&gt;</a>
 M:	Steven Price <a class="moz-txt-link-rfc2396E" href="mailto:steven.price@arm.com">&lt;steven.price@arm.com&gt;</a>
 M:	Liviu Dudau <a class="moz-txt-link-rfc2396E" href="mailto:liviu.dudau@arm.com">&lt;liviu.dudau@arm.com&gt;</a>
+R:	Akash Goel <a class="moz-txt-link-rfc2396E" href="mailto:akash.goel@arm.com">&lt;akash.goel@arm.com&gt;</a>
+R:	Karunika Choo <a class="moz-txt-link-rfc2396E" href="mailto:karunika.choo@arm.com">&lt;karunika.choo@arm.com&gt;</a>
+R:	Lukas Zapolskas <a class="moz-txt-link-rfc2396E" href="mailto:lukas.zapolskas@arm.com">&lt;lukas.zapolskas@arm.com&gt;</a>
+R:	Chris Diamand <a class="moz-txt-link-rfc2396E" href="mailto:chris.diamand@arm.com">&lt;chris.diamand@arm.com&gt;</a>
 L:	<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>
 S:	Supported
 T:	git <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/misc/kernel.git">https://gitlab.freedesktop.org/drm/misc/kernel.git</a></pre>
    </blockquote>
    <p><span style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Acked-by:
        Akash Goel<a class="moz-txt-link-rfc2396E" href="mailto:akash.goel@arm.com">&lt;akash.goel@arm.com&gt;</a></span><br style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Best
        regards,</span><br style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span style="color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Akash</span></p>
  </body>
</html>

--------------wJDZe2zuMm2FDW5nz8LHh1D8--
