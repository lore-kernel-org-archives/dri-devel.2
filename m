Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E178F4643A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9269D10E398;
	Mon, 16 Mar 2026 09:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="G2VtRiPM";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1351210E38F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUeYkZsaXio8kAXyH0avy1Q4Je59K9aseOVeQXAH8QFbr3ftLhcUxXmHnWrwpuh+E1KBXqCLUSZG+MXj8w4EZOYlwCUXQiEgxtOij/4DgO7+1Lkq+leswG/0shMrvJTRY02uZuUgd1U2AkzTx5rTaX1gGYdRFxo/k/wdOU1VsyGimgb1x2xC2zWjCut+eQZ+E1KURSAr4lFFf2T1eBrOBZvIDNysN3qtZik2P4f/YFJEmqvIU1OyrKjUl0v8WBBg3JSEwijH3NHabR/qTyiOC26i7/UVHhLa/r4to2E17wMruYsLE2KqPNGaqqdF/HjyX1OQLglu35/qylEcA3qMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5/8HgA//yDB8+baRkux8mvn/HclvCYSkI85R7ghKe8=;
 b=pvrmURDpVviJx+wjranl4JmiVNi6BB1h83TEGeRAv8usimSccTA4nSqARK4ZVNmyRMFFpTeybEIBSbkLBnVcY5q3plFGGzTk0y1DZJJ2hYmKRmWaNy/sMwA0aBGhNLyoBBwQq0G5VAE86br4iOUBFahuv4Wyl6TwOthM3Pj67i0K6zZUez3ZP6qqFTOjGzwcwsCXUrDWkEgZUztkWc+1ozOVQ/RuvZqZ9xwTVI5tdAUOG7kToyb8pLKtX4flUJRip+uu6yMmVbu/oXFrAjDgWqLoyxclpKsO7bDxp3lVO3i2ty49WqmZLXd339Qgbb/sVWOlT+MobpTM7BIE7OawMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5/8HgA//yDB8+baRkux8mvn/HclvCYSkI85R7ghKe8=;
 b=G2VtRiPMSFnKhvnKuREqOeWU4/VAI7Em3Rbryxuzf0uTQ242fA3iLgja+BrbRFrN0w643jFZv6R56cmHNE9vgk/6noz9CHB1n+x6IGY0EAxOYMULhJ+GKSJOX58f6I8SqR7ja+Szc7/eFUbfWFkykHkFzCyuSZqHnx0qMJw6sdw/Xed3JVNzd/Nem3A5hKz5CQK4sUht0G2DeXk9oVrEXo4WREigB7fqfA/AVAbkZfHu7vw0xADegumngi+WOcIU/fe6QtD3ic5R0bMIi1AZZMIZS4knbYWQ1nmk3CklJBUGfi110fdxJiQgbRbKHdm7n3jFUAWtLsf278McQzagKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:46:06 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 09:45:59 +0000
Message-ID: <b25719e0-21d3-4919-b95e-22b22bdbb388@nxp.com>
Date: Mon, 16 Mar 2026 17:47:18 +0800
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
 <53c257df-9800-48ed-a975-d7bfe4d71be1@nxp.com>
 <DH1KCR43169Z.200HRE4K6DNRQ@bootlin.com>
 <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
 <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0182.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::17) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: d7061b87-e1fd-4927-c615-08de8340d3e1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: w1yJTu/7wi96nY2bKTG0A1YapZoudrLm5ueCIPdluwUZ6opAFPeI9+IyuvwSn2O+pzI7NzroioOTwiTexvYPX+zs3K2AkywhLEktGhyLZJJknF/6+VhqCFYZKfJZtHz0u3fAeCVF33WJHV6mL8FjiCE+gmqx0/ik5kjSVlRNnutvrSQ+kh3R5KRiJpHnQMLQIoFrsKcjLO0wTbHwx4TzQLcK2Fr9ffij4CgxvUCDs5xFtdw87c4AtQuOzLeQfztoSHxi2Z8AqCZCXvW6OEXlzi03SReM/dNMlWDmCHzhGErTAuHVkRV2bsF4leU+9fxy+DupCvnxY0vWxie7Lv6iR1I2/IgjfRkEASDot2rC++ivSC7uTPJjXeVs5f0Jzx7Citfx4EEjM0gH7ArI1uLpABcSEfGRUoKzjYGBH5PkDSww79YBq5iEXT1e3RBs+4reZ9OdZOXPzgDKBRve/UldcRfQLsJG5zPJpfpZ6b0Vv7wfUpIHM+qQIkaHbDmE4aQRze3cZH48Xf+FtA4VNWSDBKsW3thE8sTyJuHPQokYdEP3g8p77eBcQK4y9+Vsrw7ZP1EmANQoirOaTEa1eDfdCFpNit49vgmZ25NyF24zIry5ormbtyEczHV7Ztom1B9BK2O+AGF8W7IveVJMpc7ErvyqjSHxQUrSXhEgZtQnIHX4fsySdDpU6RaKNVyOuuJwCdY0h3T5Ixdu9XdiM0lmxeS08IPoNYDmsMh7P3RgPwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVI0QW5kUzJyUnNaQTNhTVdsc0JpTktxTWJpTkM4R0QrbWptV1lPeFlQVFlV?=
 =?utf-8?B?b3ZxZW9pRXFHcWZ6SG14ZmxmT2orQnBVSVk0WUthNnA4eFpRT3dIS2R1YWI0?=
 =?utf-8?B?MXFJRnc3THhoTUJ4bmZJZ3V0OVJxT2tQOXZkR3h4R0lDb3h6SXAxc3kwNW12?=
 =?utf-8?B?VWFZcms5MDBTOEVWYm1qN21DMzg3aHF1TExLSUhiMTVYcFFZYnZldHA0TkdC?=
 =?utf-8?B?cFhETmF2UjZnKy9CUTdqTU0vN0F6YWFtVEtNZ3ZVYXM5THphUlp4ZHRUUHBm?=
 =?utf-8?B?em1qSTJjd3h4Qis5RGhmWmxSQUpVQUNOeUVUTTVlSGdYR0k5ODg2VVpuaXpa?=
 =?utf-8?B?SVhKZFFVOGJsR05KdmhrYzhDdjlnZHJRSHBHUWRMY0tzVkwwWW5JUW5FQkIw?=
 =?utf-8?B?dTFTRFRwcUsrQ1BFUnhkTlhDMWMzL1F5K0RWbWhhNlp3ODJsR3RMVDU0Ky9l?=
 =?utf-8?B?T1puc0toaGJnelNxVWV6d2M0cXh3d1JPQVZZWUlMamFXZGxmdjd6ZDBtWG9B?=
 =?utf-8?B?cWNUMmcybEk3a0dabHBqb1l6VHgrMEdvMVdVUFh2OUxuL0ZPbkpodkVqUGht?=
 =?utf-8?B?d1dxYUNHTlVlWVB6NFgzZGZ4STdEN2xITzFmTEdiaVVuZGFXWFllaDAzZG5U?=
 =?utf-8?B?NCszYVJXL01nUUlSaHoyQUc0c3RtRHZtL3dFTUdEbDlaaUtCbVJ1bnlUNXd6?=
 =?utf-8?B?QnUrOG9wQVNBNUJBUEhWVHlubTB1MjJaMDdkM3VsM3N2ZWJ5SFVPanZTbUN1?=
 =?utf-8?B?emlJcWhuQjNHeSsxVEthMDNkTEpGc1lyeVNOSUpIZUFhbE9hdzBjeGFCbmtX?=
 =?utf-8?B?OWc4ZU9aK2NTSzB3TC9RTTY3Nkl2V3Q3c3d0RUhRK0Fqa3l5Tk5hU25Jcmw4?=
 =?utf-8?B?K3pzb0tpWjh0cHREN0hoS0t6TzRWUk5iRERzZmg5dVhCYVJteXhVNXNLVEt3?=
 =?utf-8?B?eEFrUjJzREJRM1kyV2dCVXVvVnZRZDEwMXR6TVh1NEZ3WGR0M3U2UnFNditT?=
 =?utf-8?B?R1o3RTlwOTRvTkFRWnpLQ2RzUDF2dmdMQ0R3U1BvS3hJOHFjTnduWWQ2MU0w?=
 =?utf-8?B?Mng5bkdvempzNHZzZFdhdkJ4TURDMFg1UlA5Um1zOGxBVVR5UHBOSUpnUFF0?=
 =?utf-8?B?aTN5dnFwSjY1NVRoSTVjYjdMUVpjOS9qTHV1VWdEVHhmQkVkUjdpNmZCSWR2?=
 =?utf-8?B?cC94TmJPRFpqUWw4eGpHQVp1bHhzQVlSTHgrMENUeEZJRXJaL21KeXovemdY?=
 =?utf-8?B?SjE0TGFmc0tsbXNoMU5FSElCenVVUWMzREsxWHB5TzBLeU95RmFrSm5EV0Zi?=
 =?utf-8?B?emFFQUp4YjhJaUdldzVKai8zbTFtWmN0bXUwZFFjcnQwVVJobXZmQXpZZUln?=
 =?utf-8?B?M0FKa0hYZFVkT3kwNEYySDNrZHZoYVJKNTlyR1FHeDF2aVZ3QmVIT3F3Y1F4?=
 =?utf-8?B?NHJjclNQVzBOQUZWN3BTendqcGZiSmtJdEVjMVlFNjN2MjJxU2RWS0tKUFpF?=
 =?utf-8?B?U0dIamxyYTZXK05qTis5RTZTZThocEVIUERHbmgwaEMybXJEUGJJVmpqUnhh?=
 =?utf-8?B?d2xFckNjNUsvMnY0TXBrK0N3TWs3Z0JZSnp0YjV6TXlOUmVtMmpqUlZxSlh1?=
 =?utf-8?B?U1FTN0FhczJSREIvb3YyVTJZaHNBR2V4YTJxdTNuZTlQaHNGQisvbVI0V2xV?=
 =?utf-8?B?OG0yazE2VEhWZEtRbVRBejFid1FKcmtkcHppQWdMeDdzZzN1SmNqZWIweDFN?=
 =?utf-8?B?c21ZTFRQQms3N3p5QURMRXNvSEoycUhnS3A3NTJKNnJyUGVja25jVy9TbmNN?=
 =?utf-8?B?NXllWHJCeFc0VG15bjl5NEZONSt6Mm8vbG1iZHhuM0Y3bnZobWkwS01qbU80?=
 =?utf-8?B?YTNGMXRnYkJNRHBCNnRmUSt3RVptTlFpTUJxN1EvYnBuZ3BMc0pEZVBzVzEr?=
 =?utf-8?B?Ynpwb2hseFVzbm1LMzZ0dG1MTzVDMlVhaXdScWhyQjhDRjFxWTV1TlQzWFRT?=
 =?utf-8?B?bW9lb3FXa3h6dExyUStiUnhiWnJ6M1hFTjh1ek85Yzh4bkxCMGRnakpsZ1d3?=
 =?utf-8?B?U0g1NXlrN0dHUVJURXhkVEFLb3pSZzl0cFloeEdwMzJVU3JUeE1PSThlNm0z?=
 =?utf-8?B?Nk9uS2VMdWVDUkdlcFFSL1pVak14dXdnU2ljbmloZTdiOXlWME94NGMrWXhM?=
 =?utf-8?B?NWovY1BHcGZCSHlSSndMWFl3YmNxL29wZHAvd1E0d3FjcnY1OEFkeFlhUlNp?=
 =?utf-8?B?VkdtZmM1eEUvT0M2QXJLY2kwSDNsbzJ5SGdnUjJHZDgzVmZJdFhLYXU3Qk1p?=
 =?utf-8?B?aEtIaVVwajM4MFlXaC95MnlaN3FURlZQNzdpU1NqUlZMaTBUN0gyUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7061b87-e1fd-4927-c615-08de8340d3e1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:45:59.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px5fJGVsGtgtM7z18a72fgvp44l84UDs74A29yo4zeYwzunDl80RtVq4/V8cqsh2hcqLUCWx7GMCLj+/hgKUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
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

On Fri, Mar 13, 2026 at 06:32:46PM +0100, Luca Ceresoli wrote:
> On Fri Mar 13, 2026 at 11:22 AM CET, Liu Ying wrote:
>> On Fri, Mar 13, 2026 at 10:57:04AM +0100, Luca Ceresoli wrote:
>>> On Fri Mar 13, 2026 at 9:33 AM CET, Liu Ying wrote:
>>>> On Thu, Mar 12, 2026 at 06:30:22PM +0100, Luca Ceresoli wrote:
>>>>> Hello Liu, Maxime,
>>>>>
>>>>> On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
>>>>>> A typical bridge refcount value is 3 after a bridge chain is formed:
>>>>>> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
>>>>>> - drm_bridge_add() gets an additional reference hence 2.
>>>>>> - drm_bridge_attach() gets the third reference hence 3.
>>>>>>
>>>>>> This typical refcount value aligns with allbridges_show()'s behaviour.
>>>>>> However, since encoder_bridges_show() uses
>>>>>> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
>>>>>> bridge reference while iterating, a bogus reference is accidentally
>>>>>> got when showing the wrong typical refcount value as 4 to users via
>>>>>> debugfs.  Fix this by caching the refcount value returned from
>>>>>> kref_read() while iterating and explicitly decreasing the cached
>>>>>> refcount value by 1 before showing it to users.
>>>>>
>>>>> Good point, indeed the refcount shown by
>>>>> <debugfs>/dri/<card>/encoder-0/bridges is by one unit higher than the one
>>>>> shown in <debugfs>/dri/bridges. I understand it's puzzling from a debugfs
>>>>> user point of view.
>>>>>
>>>>> As you noticed, this is because the _scoped loop holds an extra ref on the
>>>>> current bridge.
>>>>>
>>>>> For other reasons I proposed a mutex for stronger protection around the
>>>>> bridge chain [v2]. With the mutex the extra ref is redundant, so in [v2]
>>>>> the extra ref is removed, thus making your patch unneeded. However Maxime
>>>>> asked to keep the extra ref, and so my latest iteration [v4] still has the
>>>>> extra ref.
>>>>>
>>>>> That series is still on the mailing list, we are still in time to rediscuss
>>>>> it.
>>>>>
>>>>> @Maxime: based on the issue Liu is trying to work around, do you think it
>>>>> would make sense to go back to the initial approach for that series?
>>>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, which is a
>>>>> superset of the per-bridge refcount, and thus the refcount can be dropped?
>>>>> This would remove the debugfs issue, slightly simplify
>>>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues AFAIK.
>>>>
>>>> Just my take on the chain lock approach - I agree Maxime's comment on [v2]
>>>> that keeping the get/put is a better than using the chain lock to ensure
>>>> the refcount is correct.  The chain lock could be added later on if needed.
>>>
>>> Well, no, adding the chain mutex is necessary(*), otherwise Thread A could
>>> iterate over the chain while thread B is adding/removing bridges to/from
>>> the chain.
>>>
>>> And the chain mutex is a superset of the per-bridge refcount, so when
>>> adding the mutex the refcount inside drm_for_each_bridge_in_chain_scoped()
>>> becomes useless (and slightly hurting as it makes the refcount shown in
>>> debugfs inconsistent, as you noticed).
>>
>> For better code readability, I think keeping the get/put is fine even if
>> you add a lock
> 
> The [v4] code with the removal of the extra refcount would not be more
> complex. It would be a bit less code (no need for the DEFINE_FREE and
> __free()). Maybe it'd need an extra comment to clarify when the
> drm_bridge_put() is called.
> 
> [v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-chain-mutex-v4-4-60f3135adc45@bootlin.com/
> 
>> (maybe RCU list is better than mutex, since the chain is
>> read often).  That follows the idea that you mentioned in [1]: "every
>> pointer to a drm_bridge stored somewhere is a reference to a bridge".
> 
> That's true. However while it's an important pointer hygiene rule for
> device drivers, for core code it's OK to deviate when there is a reason.
> 
>> Plus, seems no performance issue with the get/put, as discussed in [v2].
> 
> I confirm performance is surely not an issue here.
> 
> All that said, I'm OK with either option:
> 
>  * no ref taken when the mutex is added
>  * ref taken when the mutex is added (as v4) + your patch to fix debugfs

Maybe consider to take this patch first, since it doesn't hurt.  Even if
we end up with the first option, the refcount is supposed to be correct
anyway.

Luca, do you think this patch deserves at least an A-b tag from you if not
a R-b tag?

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
