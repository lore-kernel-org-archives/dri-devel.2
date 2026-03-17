Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A9FB5EA4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 02:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C203D10E2F5;
	Tue, 17 Mar 2026 02:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gfNQtK/B";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8804510E2F5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 02:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz9dbH8lWYbriqfopSh4KYseUPWkByTpWkY7IX17ANqRcg/+EGFCPZ0nUSPta1Bw3I5gyPgJDTWxawch0dT7MFXZ8XhkSX62Fka2N3uQroRekO1dea1YkuMkcoqh0kMXHzWCAcQ0arzqNelvM53Hu40g0kyO3XvOQ9UZtxeowynwIlEdCZOABkvLPENnn8SeEQ3Y7hi8n37rBS8s75Jqds2yPOc1jq4TSqh4aHZ5ZDvcfP0af/idD0Dk1c3ap6pvRGPHmNNPQTNpAj9AL6vU7+Yiu4dSKHb5ZaWhI5KN3Q4uVxySHHk2FU4K1aVgQ8ouzPD8YVBJ+TfoSchKjCqqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ik1eKO6Vs1Pyyy14tGX/OfuUiJiX2+dF3mEexYA3bk=;
 b=kcoE93tkjPfwPZl0TB81HOHLNHDOiUzW1kdOJ9SW7HW+XCphqVz4VQ+/snklZJHxeceEMwA07LuDDgE0vktkMQ2zvYdEwZngF4yzacL21E0OlYKHv7ruzBz9O4g0M5xlpkiNISfR2bzlNcflgJXYt18bLrm1uVj+XhoeDI3XVqJx/2MeLuwTYhaOVL5LJEJWTJsso+tI3KLZXC46uthkGLeiosy/lnqXF1PPFWEhzkmQREa2HnLqctUch9FmHuShsyPtK+Opwwg9GkpRM7jwvSzXyr1H2gnTNk6vdU1KkM5ulkKbmUb3BOBNYuvfHbeHdeycERzOtg+CCovAC4Vf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ik1eKO6Vs1Pyyy14tGX/OfuUiJiX2+dF3mEexYA3bk=;
 b=gfNQtK/BbyoQrww3r9j0qkIy3aofx037u4B7yV1sietRptCN046oegn1jVGgfugyqKxSiUb1Eg1mhJXkiYxHBOQsLuJkm0FdNf2ivQBRO/Zp1BAuk49k22JJw74QZ0pSNWYnH2P8IoL29GNhmJ+yWe9BlCFkBNoGiAdTgY+TR2XoUsHiIrNF4p4ISf8W27ADqoSo5KeMdYskisu0nU/WAYHZ9peIBpC38OKB2vpxXtVFIut2W62ggH53qVHAFU32K5H0tJDA+/yBucyEFgkx1/85S5Dkpt/EueFPpiqxSukpi0G7OiCZ/mj9J+BcnN67XSdHoEVjvNC/XB1aovU7hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 02:34:21 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 02:34:32 +0000
Message-ID: <c5fd18be-9537-424c-9c65-48d67ecfe266@nxp.com>
Date: Tue, 17 Mar 2026 10:35:53 +0800
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
 <DH45WF6QQX3X.3197SDA7BFY30@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DH45WF6QQX3X.3197SDA7BFY30@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0b12a5-f327-4c17-9710-08de83cdb8d1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: odYQ/wfy8HROBRM8hCfydnA2Rja8up4io+KP8IMvipSeSqGrv53mlN8qHnY7pcSIuU6dePxcfnBqoez85EBNQl50ltkXD50ySnRqZbB+AR78NGrT7q2i/+Hukwqm6y6SrAMg8WMaGiMtmdVrFUU652EG7d8hsiewNpOsJyrCO1Vak8ROQhjhu+MMiOA8I0QztU+eclVlmyWM73hCyrEto5G2uUpDpuqFXbUHYIWGlZw9WQqp3ldAJCKN9LKfTPlU5x8cx42J3y9Jf9bICrKu6cwXZre8BBNTjFUu/AlX9GGk9T8ksvs78Le74d52dbn1RZvqvDdPpyEpGhSTRjFbNheoAo2AlVd+QHiVpZ7k226UrRQsxtBp3UzjZuWcPgfDAZzzfJTF8HWg/UbXvq9L5d4lqp/dK5MDatv2+75nJ12UmmISe6Yx9ZWMZggNl+2vOeJQ5gREpHASDZRRsUcaSuZtyrq8oglj72H45Bl++EmijVlbzMgW+1SGXSc+SNS1l082l04lIw0xgbhOkpf/Bg8ZfMUO+QJuAmtLrFaUfotfV8GGM7WkKle+d99yk5mhRBPX9q86fg6CwYYkeneaV1Kga5MuG/Q1ddzO7/vdsgABAvnGYsEFRYlFcyJClPSeP/2uFZmN61e53mULNGcJWAEnjFuSTqHTIG2B+cRHvHLklF5RKYEPtN7PwyUYngdENShON0KJr3yIJVSwDk1jM+aA9vqCJVc+0G5ExtxYlDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBtSnBTSnVvSStHWWtVMmtCOE5VUzloTS96OEtibTA4MmtoRVJLUEJRZ3JZ?=
 =?utf-8?B?UHJiUmRoejJSOFdKaWFCWWtFS3dNcnBjRm00Q3J5Y1B1bHdvVVU2RHhnRUcz?=
 =?utf-8?B?Kzh4dEd3NkhWN3Znc1plVDl4VFIwcUIvT09scVMxL3M1QlF5UUpyRE9mOStE?=
 =?utf-8?B?R3VoVWJtM1ZCM1lBbWRhVXFKWHlQdVRXbXlxVWpHUzUxM1Jvb1BpQ2Y4YVAy?=
 =?utf-8?B?dEswVkNHM2RRTDNQcnprOHZzRXlKNXJBOHFxZ2FDaCtMTE9XTTRPT1B4bG5E?=
 =?utf-8?B?R1lKQVV3VHVzMlEwKzZYRTJIRjd1TmhmUkNRYktBUWNIZS9xUm1FWTA3RXdn?=
 =?utf-8?B?ZlFveUhGbHpjZUZGNU12MGVQRndvdXE4TkUxaExNeHdzT3dpeFJ6QThyYnhC?=
 =?utf-8?B?Vjd2ZUUvOThpU0lNeUdwd2gzUmhpQUMyTXp1NjhMTWhKc2RDOTZ0Z0hTa0sr?=
 =?utf-8?B?VEFRKzUrZENDLzJYdHc4SSs5WjR5ZGw3dzRTUmJ3WnhWNm1NQlpWdC92TTdh?=
 =?utf-8?B?bnI5ODdaNURYR2Jtc3IwcWxqWVZWNmhZVUpubEo1R1JKRFJOT0k3Rnk4Zlk3?=
 =?utf-8?B?VFpYUXJGSTN2RXNGUWlBYnhhS1JjMnRsSWJUNjEzNEc5R1RkRkVydnIrSXJa?=
 =?utf-8?B?aFRwNlhQZm1HQmk0dU4wQk42OWRmT081NTI4cnNGRDRZdjc4clNXZVJiR3NS?=
 =?utf-8?B?Uk14YVp0a2RacTZFMlpDeFBiQVJqbm1WSVByeEMvUkJxb29WVWcrUjlrS0lu?=
 =?utf-8?B?c3NlSkllVHlrMllWUmpIZEpQU3pTYTZYc1pqK1dFWTdJLzhKd3NLaFdJMlUr?=
 =?utf-8?B?YjdleXBLbEtCd2lwdlBJTDlDaXZEMHhlRW11ZGR0UzR0SkJqaFlmUHJqeEhj?=
 =?utf-8?B?NXBweVRlRk9LZURWYnRCUFJpUDlQYjNTYjQxSlBmTUpJcGUxSk9Ec2Y5bjdI?=
 =?utf-8?B?R0lVbmpncWtJT3VPTHlSZUx5UDRIMS9MdFVaMjRtUlFIL0ZOUVg5anlNTjdu?=
 =?utf-8?B?KzEyd2tlekZ1dzVJMVByTDM4bGxqODJNUHl2WU9Mb3RTYldqc0pMU1djYmpD?=
 =?utf-8?B?QlYrZHVhSUtNMEcrTUw3TkdZakdsNmJOb1dBSTBOUFY3QkpVcEtEZ3ltK09y?=
 =?utf-8?B?Q21lV3pCMW9zZnRoRVpOYTNBWGdsQkJvOWxCRlZOdDFaZlpodVJQNDBMYUZG?=
 =?utf-8?B?ZHFtSGZiZlBHaVc1dUpxMWpTb2orZFAvbDRBdytsam10eWpIQm9uV2ExaHk1?=
 =?utf-8?B?SmtmYnJxYWEyNUtIdDdKa2RWYTlPb0ZvanJnbVJ3TkdZeGVYLzFZaG51QXRK?=
 =?utf-8?B?VC9TZVZMV3p0ZjR6TWR0bVZsWUZqWnAvWFR1NVNqaFl0STlqRDhXQlV6VG42?=
 =?utf-8?B?ZStaNFM4eGp4blRFWHI5ZUtRTDBNY21nTjdaWk5SbDdZZk0rSndvRXppejF2?=
 =?utf-8?B?dTFWKzlZQ2Npcm5KWU5ZRzNrMDRYN0pqK2R6ZjJTTFdoZ3ArMW5rUGpTVUp6?=
 =?utf-8?B?bzBHMkw3YlVzRjZ6dm54dnRBcGlQQ2JyUnV1aWRIcW5weWRaUGVvRm1qNWd0?=
 =?utf-8?B?RmM2dk15Z0diVmptbDNFVGFVNFhWY1MzdGM4Q0Y2UGh4Z2pVbmluSGdvTjJl?=
 =?utf-8?B?aGIyOEhxWG5CODRQcGxvMGRrQmlTVkJVN3RrZEtjWDRuSXpOSVRjK3RrOWZ4?=
 =?utf-8?B?czhmVll5eTlkb1hHNGc3bGZlbXdxZTFNWXlVTXFaWGxYY2hUQ0pWMEErOE5k?=
 =?utf-8?B?akt3eXBZb0c5aW51Qk44T0NiK3JZbVJQOGFsMlBCK1hrU0M5cTZwd3FsRmVo?=
 =?utf-8?B?aFNweTVOcHJtWnhPKzh6QUtLWGY0Z3hxc2x5YlFUTXRhV1ZWYVVZZ3RHaTNj?=
 =?utf-8?B?ei90SmJWMys4OENkUVBFc3FaUTVtUGZtNGg5RDgwNUtveWlyemd4NjdUVVA4?=
 =?utf-8?B?TmYxUnBFOUxaU09nOVVjQVBrSm9LOTREaDAyNW93VG93ZEJLbzNKNWNsQ2xj?=
 =?utf-8?B?NElaZy8zQlFIYmJlMFhGS2czSDJZVUkxeW9wSWNCRDlGR3AvblZqUU14dzIv?=
 =?utf-8?B?Qi9tRUk2MXI4K2dNSElMZTZvZmVzbWhWOE1sUHgxanNxZS8yS3htVnhnanVp?=
 =?utf-8?B?WHdYNUQxcGJONzBMWHdHdmhrcjIxc2dFUVVYdUdSeXQ2YmxHa0pQNmNHV0dp?=
 =?utf-8?B?dXRzcGdGSEs4KzYwNFR2Q0Z4WTVLaGRxU1hndG5OMzFDZ1BRWkxkMnFPQkJ5?=
 =?utf-8?B?aVV0LzNuWi9Td2pwcW45L0ptQmxWdzA4Wmtudy85NFpKK2ZXV3UxUnIzZnov?=
 =?utf-8?B?UXUyL2hVT25QNmFGWjc2NTl6WmRoelAvTUFCd29NQVVDNjB0YmNnUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0b12a5-f327-4c17-9710-08de83cdb8d1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 02:34:32.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjwUi8bibopZ0jezX0YawK+mrJ7jfOZdYJKQpvDsLSy0bqk6eLt5wwgAh1d9TvsBd8d2+0fLqHCQZrfKd6nO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
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

On Mon, Mar 16, 2026 at 12:15:29PM +0100, Luca Ceresoli wrote:
> Hello Liu,

Hello Luca,

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
>>
>> Fixes: bd57048e4576 ("drm/bridge: use drm_for_each_bridge_in_chain_scoped()")
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++------
>>  1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index f8b0333a0a3b..84fc3cfd17e0 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -1567,14 +1567,18 @@ void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge)
>>  }
>>  EXPORT_SYMBOL(devm_drm_put_bridge);
>>
>> -static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>> -					   struct drm_bridge *bridge,
>> -					   unsigned int idx,
>> -					   bool lingering)
>> +static void __drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>> +					     struct drm_bridge *bridge,
>> +					     unsigned int idx,
>> +					     bool lingering,
>> +					     bool scoped)
>>  {
>> +	unsigned int refcount = kref_read(&bridge->refcount);
>> +
>>  	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
>>
>> -	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
>> +	drm_printf(p, "\trefcount: %u%s\n",
>> +		   scoped ? --refcount : refcount,
> 
> I'd s/--refcount/refcount - 1/ here, no point in modifying the value while
> printing it.

Well, maybe there is a point if we consider 'scoped == true', which means
one reference should be dropped from the refcount.  In the future, if the
refcount is used in this function multiple times, then we don't need to
do 'refcount - 1' for each time with '--refcount'.  But, for now, since
the refcount is just used for one time in this function, I'm fine with
either '--refcount' or 'refcount - 1', please let me know your preference.

> 
>> @@ -1599,6 +1603,22 @@ static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>>  	drm_puts(p, "\n");
>>  }
>>
>> +static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>> +					   struct drm_bridge *bridge,
>> +					   unsigned int idx,
>> +					   bool lingering)
>> +{
>> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, false);
>> +}
>> +
>> +static void drm_bridge_debugfs_show_bridge_scoped(struct drm_printer *p,
>> +						  struct drm_bridge *bridge,
>> +						  unsigned int idx,
>> +						  bool lingering)
>> +{
>> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, true);
>> +}
> 
> I think this should be much simpler and avoid a lot of the boilerplate
> code: just add a 'bool scoped' argument to drm_bridge_debugfs_show_bridge()
> and pass true/false as applicable.

Hm, I was thinking how to avoid the two bool arguments(lingering and
scoped) for drm_bridge_debugfs_show_bridge(), because they make a function
call look ugly - people have to go back to the function declaration to
check which bool argument is which.  So, I came up with the boilerplate
code, at least any function call has just one 'true' or 'false'.  I'm open
to any better idea.  If you insist on adding a 'bool scoped' argument to
drm_bridge_debugfs_show_bridge() is a good way to go, then I accept that
and would follow - let me know your thoughts.

> 
> Or maybe an 'int offset' with an integer to be subtracted from the refcount
> for diplaying, but that's probably overkill.

Yes, that's overkill at least for now.  Dropping just one reference from
the refcount is currently enough.

> 
> Best regards,
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/

-- 
Regards,
Liu Ying
