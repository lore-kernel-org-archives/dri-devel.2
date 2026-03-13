Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0F5106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF43F10EB2A;
	Fri, 13 Mar 2026 08:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mC3u4nk+";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEBE10EB2A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLzkUbwFSPhxuc58APRoKhi+KPtoEI4yB9E17liNosby6dGxiqNXToq6fusEtqkEZnlsv6A5xLFQ62VGSgG9EVYQRr0eNAo9wZNqVgvvswK/SuzdXvpfguc8H/n+zTy8qcTi+vyvAcpgQSk3UHLkVN0n/F9BubF47tsH3G4g9O1uiYPD7QpTHrVMwjbEcZkoHvfWqZ2gwOY5ngYY+mFTvLPMEQDNS9+YozHsOFzU6uCe/J9qb4EQFZI+dprAe5cQsYec4++dFevdzz1Ku8HQ6QtimH8Vcmx38EKNvHc/h2nAgCm18M1bq2C7EbOubX7GGA6o9XWdDUxExzb7RqflNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxXuHjP4bPMWQfQlioDJXaDCJonJBVxVFa0JxWZGOEw=;
 b=ibXNxv3Yel+IePZ/NsZcWNtbUki2Y+z3szX++/Nk+68A7gUxvSkx+pPsmxaiGxJ3RESPYkRCn0zAyOMh00uXqMhBJ/5yQLBpIuY02QiaWvvIDTpzTymdnzb1zYNWo48lIYAYSTJOlYP8W0EG65253gl0/MtgCUl/NpnBHKGIoXg53smHzixJQObV85sSScG1EQlzxRN1LfI6fzuX4+pJQvfhB9JFpBoMZhUzvU8mWw5Z/OwMg2WNCvstTNrenHOaOx6Tp4E1zbXLfuzOkiZjChAAIij0utbgdOHk2L8tvr/RxPfrUcXUYenHxPwMVE9tlHjyna6XJ2JKa9gYIPGm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxXuHjP4bPMWQfQlioDJXaDCJonJBVxVFa0JxWZGOEw=;
 b=mC3u4nk+f7b2ZRA7mv1kVwNDqpGYwtGBZOcq+Z0U/zlEXLi9hyX/90UuwBahsmrsIzKh+pWbP073lxFM0KEFgTbdjh+mtbVCo4r+vdCTnAyw60/CH2Cl3C3Q4XSTt6SJjdwpUdsH2pXTgLO+JwAQ5fl9Cr9wXcDuh6+2Iq6p5D/7PNBdno612k8KMJSrCkmvVEjgR6WwHrSHSTB3m4dwFg9i7YyIfuz8jwZex6WATGFHw5rzmbosfWD6JMcb+xzeBelXJGLpFmYOMcwAaj6cAOaRYJS4FPJwT81GOai31U9BIf9C3EnnOKjlYTgslCsPZU4smoq+FiGCwA5RxY2wUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 08:32:37 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:32:46 +0000
Message-ID: <53c257df-9800-48ed-a975-d7bfe4d71be1@nxp.com>
Date: Fri, 13 Mar 2026 16:33:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
 <DH0ZD9UFY68E.2C1ISONVIO42L@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DH0ZD9UFY68E.2C1ISONVIO42L@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0193.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 48efa19c-84c3-4159-c820-08de80db1a5a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: svuAHW53AzrUq0/M5CU4Y6V4jfH33Iyr925ZOu28IhbQQM3bZj+WWNsDfnKmMmOW04LUAdiYxNPtQMAAWdUB/XdP3QaxWM7/onWbYlsueMMDZpzK1grS3mSYasxnlJyvUw4HC5P1IjqOX6N2D0unsMyiy3OjWOEdper06Ph3WvcMnordv21vlk2A3Pe/GptnYvTkEa3qAIiMhbozadbfqkxXbm53/xNrgGbqYb2sVCGy4smS2X2bdzGnYnWmXY7Tcz3nzaeN2XK6wufoUWhed/DZPBLma2mt4lzzefas1S/3gomMtF6e+JqfBdbsfodg4dLTTj/xS0R00VWo5PQ36u0tPhL1rbr1aw10FFnDcIhGkxQxhrPKPhwODDdidelONIojpjpBealt/W38j0f1w7TIWtFnM+uxa42Rp6MHQM8Cmuywh/N0rlqauITZT3o2ni+YZ2scQBF5QXGw7Idfnh7Ul84wmp64coumqVQGRbVLexqRE3AnYfIH/eO+Te9LjhlYv7LdXDacby8YfZDUgNWt2PyQLC+H4Uy1M3OY62OMr6beOQgZFLba8z588hiiIm7/BZpjuVn9gGoy50Thcs+ZNuPwtZLTW++aMfhJVarr1AUQvodSV7o2a1YPIzMnGLk1aRXv+HAgbUbQf6EiIMQs4r4rb70zyWpwAMDQoeIYmoq+RyosWYn81AF1mA7riPkPkET9qAmbJ5q03TTiruToBbbD/RoXWIOsuZ+juKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJMNVc0Rk95bXJOOTJ2bjFUR05TUVYyazM2NVhBdTlzVk9XNGc2ZXpnQW5H?=
 =?utf-8?B?Ulo4eis4QTlRcGdqSFVXZjdNVGRjc0kySFZXejZPUTJVRzVwcmRiZ0R2ODgx?=
 =?utf-8?B?bm1SMXFaR05VaXlySVlVTHhzdUxJUnVldjFqaXFQMjd6YkRTdnY4a21saHpS?=
 =?utf-8?B?NlFCUy9CUkhEZHhDYW90UjBpYTVYZjc4SHkyUEZSaVNJQnJ6S2JxcUU0RWxI?=
 =?utf-8?B?WC82UXVoOVcyRVVTRWVKcEgrTTNMUnZrcGtENzNta003b0VDZk5jT1k1SWZW?=
 =?utf-8?B?clZERWs5aVNJQVh0ZU41dzc4VzV3eUhVOGc5TFg2QTJmK2JwbG1VakhSS3lM?=
 =?utf-8?B?MVAvYytCKzMzWVVVVkE3b3MzZVlEd2VyaGEyNFM1OXNxb3FuVlVJdVpleXh5?=
 =?utf-8?B?RWFIY1NuMnIzV0dTaE0zVTBHOXp5N2I4TVkvY2ROb0ZnVFRLSTNLZzhTa2Iv?=
 =?utf-8?B?T2lWSXVCY2kzdjNoR0p1V1dsRVlJOGdyZ3J4ZXpwUEdVakJCeGgzV0o0MTYv?=
 =?utf-8?B?YVpyM09GMjdBWStscHJxeEVGRFNFbmVQNGg3NlVQcTgvbkhWMFRhU1VyVFh0?=
 =?utf-8?B?bzlhaDk3aHFZNi81NWtublNCQy8rNjMzMHpBWitsb3p5OTJPcUMxejNMVUdD?=
 =?utf-8?B?SmYvNWRacXg5S1lPNlZTTmVoMUhXdnJ3RmR3NGdDckk1RE1aU2Ztc29VZVlN?=
 =?utf-8?B?Vk5ZN0lmWEllc0ZSTUFiTEM5ZEtuUnA2OFR1K0Q5VU5CUWN5MEpWNmNXSWta?=
 =?utf-8?B?VXNTNmdSRXQ4L2ZuanFBVTlrUHJWcEgxbVpCQlZKeTE1eEV3N09pbTJmUkZp?=
 =?utf-8?B?bERXdCt6S2ZJdzh0Vzl1cE5vVmFIckxJZWZveVl4S01KWXRoQmlILzYwNEhP?=
 =?utf-8?B?WFd1eXRqUG4rSkd3dGxGSzR6dysvMVB6WEtaWXQxSGFKdldId0dqMGkrOWph?=
 =?utf-8?B?RnZnVzhhUXgrQnl5bzJmVmQzQ2pBLyt3Y2xqQURzZ29kZzZKNytrblFvOWNo?=
 =?utf-8?B?L1BhNGpKSVNYdTZDQ3RBeDhrU2EwS1R2cUszZnlqYTJiWkZyN3hua3g5cE4w?=
 =?utf-8?B?TFhrRi9PQTBuZ3VnN3ZodGNBYm5sVjZTdzlkM1kxRVNTSHU0cU1NNnN4TWtO?=
 =?utf-8?B?anR3dXlrWFZnSnVIOGdvMFZmSWR5YVh4NXU4dG5iOFYvbGhpeWVXRXlRbG8x?=
 =?utf-8?B?MjZpTFEwbTgyUUFQMlBHd1dxZjg1NzlLTEhEcWVEdStWWGtNUzVFMG1LSVBZ?=
 =?utf-8?B?UmtQam5Cajl0eXVkSEZJS0FOTHJUWVZ4aFV6c2R0dEt5TGZKSGY2QjBzUDNZ?=
 =?utf-8?B?YVQzeElDelA4NnRYbGhsd0NpV2V4bEs1T1ZvYXVSZktrMzg3RjlRMk15Rzhu?=
 =?utf-8?B?RzEyNG1FY2c0NmFXbEptYitQZ3B0bUFLaGZ1S0Y0c1I3RmdjL1NRWEdNZ1Z1?=
 =?utf-8?B?NDViMDhkVXkxRTNYaFRHbzQxcklqOTF2b21qTE1oelBXRGJsS3VhRnVibHVC?=
 =?utf-8?B?UEROeDhLUFlHSkdsS1AvclJJaDRXTjEwaEFQNWZuM0VjazYzMkg0U29pWUVL?=
 =?utf-8?B?UjhFYy91Q0MzQlhOcnZSYk9qak1MOWNIbFFUcXFKSy9OckQ1dUczUXc3SEpU?=
 =?utf-8?B?d2hJemR6Q3VOdDgvVDllUU9nTXpWdnBwbk40UE5JaTZPc0xHY2l0ZmIwNWNz?=
 =?utf-8?B?L3dBNmVnZjFNbXdNRmNMRUh3MUhib1pIL2VmZWx4dHBSVStlT2xlOXc4Q2Fn?=
 =?utf-8?B?YXpIV2pFcWVBdUoxY3FEQ3NrMEwyaHZyc2R3eTdOUzFCQlUzOVJ2TVF2MDFE?=
 =?utf-8?B?MWNMWDAwWldXSTZUSXJEVWkySk5neW5BMjZtSldJSGFYRmNQOFpUZXM4VHZR?=
 =?utf-8?B?bmVwUk5rVkJTRXl1MVpKUEdUWXlTSnRzZUZ1SitxYWVuU1VmcmtzYit3WGxP?=
 =?utf-8?B?aDhaSzBwaG1TZUxmTkF6eklJNzVkNWVFWURMb3hSR3hQTWtHS0JEMkVCaXNW?=
 =?utf-8?B?UFozOXIzRjU2b0cwMmM4MUlEUmdTYlBIbXJhRTJnSnZMWWkycDFtd3hpZ0pv?=
 =?utf-8?B?OG81NFRHcnZxUGtDRWtyZkJRb3NUNXpvdW5yNkkwNGNhZVpTM2lNSVFPeW1J?=
 =?utf-8?B?VXRlNXZvSFh3dUZGTm9HMXhibmE0bWt3aEx5UHVvdXFOZUVCLzd6clNzZEtE?=
 =?utf-8?B?OVFTY0lFZEZNYTZIdmNhNDBOSkxuZjJ6TkZubTB2YmNBQVhyOEFHVkFobTBU?=
 =?utf-8?B?VXFQM2hYK3ZRTkpYMGZEZXZhV2VLNGhQcHhBaDliYVhjaTZJVEtWQmdCVGhu?=
 =?utf-8?B?UGN2VEFCNE5pWWticmlUZFlVR1hGZDBaUXUzU0JtTThlQnUwc3l3Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48efa19c-84c3-4159-c820-08de80db1a5a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:32:46.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B52rDUxV1DsTlg0ObHCGr0gWQjc2g+/rdukg9LQzY5yHVkzr4ZfxA9vbfobOFhykcdsnwEQAvlnr3ciiyQ/6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742
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

On Thu, Mar 12, 2026 at 06:30:22PM +0100, Luca Ceresoli wrote:
> Hello Liu, Maxime,
> 
> On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
>> A typical bridge refcount value is 3 after a bridge chain is formed:
>> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
>> - drm_bridge_add() gets an additional reference hence 2.
>> - drm_bridge_attach() gets the third reference hence 3.
>>
>> This typical refcount value aligns with allbridges_show()'s behaviour.
>> However, since encoder_bridges_show() uses
>> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
>> bridge reference while iterating, a bogus reference is accidentally
>> got when showing the wrong typical refcount value as 4 to users via
>> debugfs.  Fix this by caching the refcount value returned from
>> kref_read() while iterating and explicitly decreasing the cached
>> refcount value by 1 before showing it to users.
> 
> Good point, indeed the refcount shown by
> <debugfs>/dri/<card>/encoder-0/bridges is by one unit higher than the one
> shown in <debugfs>/dri/bridges. I understand it's puzzling from a debugfs
> user point of view.
> 
> As you noticed, this is because the _scoped loop holds an extra ref on the
> current bridge.
> 
> For other reasons I proposed a mutex for stronger protection around the
> bridge chain [v2]. With the mutex the extra ref is redundant, so in [v2]
> the extra ref is removed, thus making your patch unneeded. However Maxime
> asked to keep the extra ref, and so my latest iteration [v4] still has the
> extra ref.
> 
> That series is still on the mailing list, we are still in time to rediscuss
> it.
> 
> @Maxime: based on the issue Liu is trying to work around, do you think it
> would make sense to go back to the initial approach for that series?
> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, which is a
> superset of the per-bridge refcount, and thus the refcount can be dropped?
> This would remove the debugfs issue, slightly simplify
> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues AFAIK.

Just my take on the chain lock approach - I agree Maxime's comment on [v2]
that keeping the get/put is a better than using the chain lock to ensure
the refcount is correct.  The chain lock could be added later on if needed.

> 
> [v2] https://lore.kernel.org/all/20251003-drm-bridge-alloc-encoder-chain-mutex-v2-4-78bf61580a06@bootlin.com/
> [v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-chain-mutex-v4-4-60f3135adc45@bootlin.com/
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/

-- 
Regards,
Liu Ying
