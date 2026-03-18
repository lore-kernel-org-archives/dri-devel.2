Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EA1FCD0AD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D3010E634;
	Wed, 18 Mar 2026 05:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jadPejKv";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EBB10E5F0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8YPsDZEFQyhssq/opjyh6zywK1rXMpPgaM/MN23aqsOSQg37IPDBiYtCjkL4GSjHr9EUoaRfuXnAUHkR8WgRIx2GqekyG929ARoqj49VLaAZOW+/BpA32ikokiAj3TwEEi/6ytkTmCoh5irPr1GxKikJNgjEzBBlcXJkzBY7g6WGE1Hw7ACnwslrcJq6PLFB2D11tfqb/i/iR70pMdJP6mirJztVRhP/bViUFjZ41aCcd+FEv5lGlYEDHJsdzVCJacrin3huLtW7MpAkWdNzBuVDDshj4VMHw0s8yWl6cKR1eYiAjEMeKV0/sSsdiJCOv7ifneirj/yCxBHbssZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRExay/FpLkxuPNJYqyMQWLfXdNniiAab20ogWUJRyk=;
 b=Hk/F0qRSC9sEPFFMY6Do+uV8wmNFSzC6Fqh1EGgEDjfRhFVAW/4MyQnHRP/N5jrJXDY09ioOfqkuZeRm5tU9P+LnRQlWdqpGAcvL4t2MpIYErgN4ilQfN5OD8bETdphYK5pjzpIFbBXXCMqRvzLEWyyiF5DgvcekxR7Z+A5TfT1Chqk1Z5/CNrKrd7LEn+hkxsCNve3xJZu75CJxAPM1M3DEbjYJUnASfH0LrPeAmMMaGLM+2jsh/ojtG+Yrg2TSSr3LBWw1y9RR7erbSwYQtO50wM99A+qUwt+PJkSCY0dGlXPjGbS3XOKaxLy2IsphbLh+eqflyu8g/zsAhuUReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRExay/FpLkxuPNJYqyMQWLfXdNniiAab20ogWUJRyk=;
 b=jadPejKvjUKqViKC6y1iV+U0PvCdoBqpmiJlXwr9jAxWEZsWouTiZNecvTC9j3jbYkozIj5uB9uj2GFBAr7ERaEeEm7sAJfey1GQ2jyGT60oc3gx2qJn7AYfKg8JPATtppL8/Vc70fnBxrd4FQTWL805zJI3LCKoCvikLi4KZAl8kps0Fp5UbnyQIiIumGLpsJoJuxH2TOm/zr6CPpFkCEx4kB0GeRONmSEYqYvyqWcxHIe/DjlYcUn0qYztDyrE3seYMdacmjO9qhE4cb1u5xNUBK6DxtslBUZzzIQ1hAXYYWbiud6zmjjNo+epChQSsl2HQW7XmhoPugyEi7uHAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS4PR04MB9291.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:21:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:21:08 +0000
Message-ID: <6e55e0ee-5f7b-4cc1-bdee-c6e5edf2795b@nxp.com>
Date: Wed, 18 Mar 2026 13:22:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v2-1-cb705bd84a31@nxp.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v2-1-cb705bd84a31@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS4PR04MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: cec0c89d-8271-486e-07ce-08de84ae2909
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uPIZoCvv3cp3diAjYj/+9JK9Ja+BK3fY1hCCblgUuQL74IKhIWkJy+1473BtYFWQ9iiwS3qKCW7Gp22/9txSNIxpKrzHGtyQv2adoX5ED8sWip/OVcMjGl0hCs17XzRnQx3H1z5mZdPRua44NJbwWbggEqZYHwkai5JAUjYQOjqEj/gozpGBxgWLsqGd1Kchll4Zag4pmLqAZ24czqAgKCyoeCVf34YP9Mj7sdHME+7EQXB213hFtiPEhrhQY4yuOfYiUVwymqScab6eem4lu5CqtuhqOd9wa4bhcyRkgC03o61UNw1n/L/Z8rVNkVUdvp9eg2gGnVHPFyruv5NFwJby28pWtqmYzxqNXNV9TAx7dt5y7zpVKhNhZxjoxcdakDhnibXi5ecBZCFySqBx/QhTZFmd9YjP0nN+rTE4jZFc8ZD+A529G5HEhwClCUnrwaJoocnli613QmuHiY6zaiXUZxsJ3Zbs/+sUu7HBX7P8Ud4flEdoYQCVpYEn59i+59vS003LwXa/tpDPv/dSSEDByHYGEzctU4kA2joYa83yBMkJQa08fbW/7Y1UPrJIF4LBn9eqoMnRpzhLXoyvpJOY0xfSmPv7CeXlxeI27E+QVFSBvntqYXD8wJwQ4iRUMb9gVpzuabWmnT+i14NEObPScB/vOzBwqWkhV+CGxAfXala9h44/vCz4ZMnfTszM/it1mV45qTNvVkz4RuGnC1Qr3fHzchB0pcw9eIVzUHD1L7eT5eF3mZ6foFVzVVPCD+ML/BfNRBg/U9bwYL70Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVteXEySWlVdlNMdTcrcEZkeEdkaU0vYWpuSXFES2RYS2JxTFJYVkcvVm9N?=
 =?utf-8?B?TWl6bWI5NnZDb3kwMUFtaVJBVXJtS2l6TTU0VVIrdWFRdm1vckJxVUt4RFJT?=
 =?utf-8?B?MkZWano5YlpaMlFYTmlocHd0b0JSL1VBVHdzMmRwUWV2dlZYM3VRNUt4azV6?=
 =?utf-8?B?d2hLbzJRWm8yU0hSZExBenA4WkxOTHJWUFEvQmxXNXR0ajlPOGM3WkpzL3Vv?=
 =?utf-8?B?SFVvNlFOcnBRRzFzQitIT3FEUmlPbTY3OWNvaVdnNEk5SmhKNXQ4TjhuQXc3?=
 =?utf-8?B?TnpNeHVRMWhScWluRWFxMGw4L1BhVlpRTzZab01wOFZadldoZ2h5SDBHY3pW?=
 =?utf-8?B?SS82c1pQc1lpRWpBMzNSeXVXemlGckJ0N09XOHlBVk1TMlNxN05qcnNLT3ZK?=
 =?utf-8?B?bEUwSEtmRHF3VWZtNnNyM1R0RDJTN1BzREFZK0RhYW15NkJIWTZMK1JMR3Bv?=
 =?utf-8?B?MStid3ZTOE5YNUZ4blpiQU1aemp0bEloMFVlMEtWOU5lOGt2SE9QZWNQTURv?=
 =?utf-8?B?b0JLVHpnMEFNcXE3c1F3Z1M2aTVKMjJhNDMwVk1qM3kyWmpwZ1NTcGZlUW50?=
 =?utf-8?B?RFQ5RENONzl0ZURCSVRvMFozYWplNllNMjVMdDVydGtpZ3lHK2hOSDI3Vk1j?=
 =?utf-8?B?TldjcVE5d0xQS2VkZUdhWTlIcDU4NEhYZHo1d3BEOXQza1gwcjByeUk5OWxN?=
 =?utf-8?B?YmhHUzY5emxSdW16MU9uaGNBa1VBWGluUW04L05uQ24rKzJJd3RBOG0zdVlV?=
 =?utf-8?B?WjRIMVdlcVF6UzRIcXBSbjlhV2xGYjZZR0x3VVJhTGJOMXZDZjBJVEVDVVdl?=
 =?utf-8?B?b2FYaHNVZTZ2MXdnT3A4d1RaR2k1TjVueUJpYnliRmtEQ24zT0FXSUNQQ1RI?=
 =?utf-8?B?M3dJUkZIaEhscWNXQUlQeHg4emJHTXI3Vlh6bXBLS1ZhUHhTaEYvMzRDVURX?=
 =?utf-8?B?WU03Z1Y1b2NLNXIvM1NPK04zZk8zMHNuTUNleWN0UGFlRVhMbzFpMDE5WE43?=
 =?utf-8?B?TmFERU9UR3FXc2JtVGdsMm85cEhZU2t1NHZCQU9mY3pZQStBcnJMa0t3bnNQ?=
 =?utf-8?B?SXZrclhwamllNE1yZFEwMXphUEdkaFFHTEY5dTJFYWRheXFhU0JtYXVsVzNP?=
 =?utf-8?B?MHNZT0EvR2dhNTBqekdRcVlraE5sZVZtVzl1MVdpeDUwQ1NHTXh3cDJRMisw?=
 =?utf-8?B?SDA1WmNhdkVCS1Q3TWtGTWdHMW8xN2RLeFVuK2t4aDhBUDh1Z0tmQ0ZEaURl?=
 =?utf-8?B?Wjl2QWNaY1ZRRWNBSGgzekxMN25TTHlTSjFXanNYNXA1Njk5RDNOalpwajQ4?=
 =?utf-8?B?WlhidXNSanljK1JjTkZpMnFidXhLUVExR3ZBYVdXWktmaXcwZWM4N2xUZ3RY?=
 =?utf-8?B?LzVBOGF0cXNYUkdiczZvbXkwZDRDQ1JUN1h5YnYzUm03RDJQN0lyT1hlQUVX?=
 =?utf-8?B?QW8rUXpRb2s4cnRQT1VJNVFhbEN2UUQ1K0FFMlZpM3VaYWVKZExBN21XV004?=
 =?utf-8?B?cUxkRTNDV1ZxSHRVUWhCNGhuSTRIdWQrUVB4bHgwYzVUbEZQMy8vcWg1TVYw?=
 =?utf-8?B?c3FNdWZFZXl0ZUdtOURGRnZISEJJa0xaem50UHFiMUdVdnVMeUxUaCtmM29q?=
 =?utf-8?B?a1diTFk5UVJJRmdsRTZjWjB0QURvTkpZMkZnYkppMlA1K0dFaHZOY2ZBbndK?=
 =?utf-8?B?ZTQrSXBjcW9tdHYzWis2RWczN2doVHZ2MTVqbzR5TGNKak1RL1FkM3hUS3cw?=
 =?utf-8?B?OXVuaVhOWGRxejc1NFVtWHdkMjZQTjJERTEyOTMzcWh3WFZzODN4a1hFK1F3?=
 =?utf-8?B?MHdWZFdkY01vNVBpRERVRUVheUZQcTZWaGkrVU5IZWZEOWpjVGM4T0t1RURD?=
 =?utf-8?B?N05WSkx6Y1gvMW1XQ2ZaQTZVQytFQUZuaVdralM5eG1RK1pQbk1BQ2JKMC9Y?=
 =?utf-8?B?ei85MGhKdkVPekVzeXpRREdvcmQzZ0lzMGVjT0pnY00vb3JYZDZsWkdCc3ZW?=
 =?utf-8?B?K2RxS0lGZXZqeG1vV1B2UUQycnZqcWpWTDVSUHRmZitxWHZ5c05FVm5ETXRY?=
 =?utf-8?B?WkIvaXlobGRUK3duV0hxczA3SnV2MmVMSW44ZWxwaWZaVVBOVWJabGFabTVJ?=
 =?utf-8?B?dU9zMEVSNHFwd0RVQlBuMzRCUjhDYUxielZmVnBvZzExdnkzZzVhYmNoTC92?=
 =?utf-8?B?UnNxMlpxc0dwQkZOVHFUV1BZMDE4UmVvRkoyaW9qam54TW1BOVNqb2VzSWpm?=
 =?utf-8?B?cUpUNTNLdFBxeDdTWmI5Q1BxelhlTG5TUzFoYkRaQ3JZWlUwSXdLUjk1eWRK?=
 =?utf-8?B?ZEVjeGR3eGk0NEI0dXlRenc2bk56dWpZSnJMTGsyOE83ckNwUEVOQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec0c89d-8271-486e-07ce-08de84ae2909
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:21:08.1965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEBzO3Prs+Cb7ilTE2sfkM9S1iReyMESfQnGAm3Mz4WSxdsT++FGslOBrWgPF9DbT1/3oNhF05x6ixAiYY80JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9291
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

On Wed, Mar 18, 2026 at 01:11:24PM +0800, Liu Ying wrote:
> +	if (scoped)
> +		--refcount;

Definitely 'refount--' would look better.  Sorry for the noise.
I'll give this a respin.

-- 
Regards,
Liu Ying
