Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JeDTAM7d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89C010E39F;
	Fri, 27 Nov 2026 04:40:24 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C6510E2BF
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nueYcvWWLqSrgXVGQr4ZmMXIDaRb88ZmWFoWuKmB1+nl31yDzQtVHHNWE7q4XafODz1v5K9uszSl8HaND4GgGGvP8cWeuZxVbHLQjRy6EHcKkF1r4UO5AQnaGjGro+hsUOHwSiU7K/j8AeIkq2dERrBuyfaFa8J0Je7/LozoVUY8U9uIWl0oDU33+1ednhil/WNKJd4R9E5Gsmpuwl709yj+haZDLpyJXwfrb/YoSxvNJxaacnx2BhXfsDdHtPC+R6cIk7J297X0lvOapo9yZNQSVivyJxUUGMxaW9PClZYjdDZNuo53vST9Rpv7Rnvrjz4CcageknUPrkpEB1TEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdJQM/wfYisv1aa9gNcAaTTKAbpS3pIa6xYkNd+SLh0=;
 b=qI/OxPuPZABfFw7AGfR6tNIIqDeGOwM0Kce4wyiTtFkZAKUxAD7SucqNmr1iEPwwPDJrtx6KvsFeYaaf8ggGEYzsssD4GqNnNq15sPnGpkCjov8f01qg8kz9g559MJFPTYqggQW3p3jhSMAnzfKXEfx45bGkEP/lvX6+h+Zdqmy4BtHGEYtdzT7VQ6t2taJxPKHb/p5qYVvVxC/HPTASbeLmd2bhk4Fvg+xK/++aSiLOFwibxlMnCi2e9uf7SC9Q7zWsWKsnvKiMYGNnIX9o+0ZTsaTQnuwx2x12lv/SSwqjMyZw6Q34QvS4GCoInsKptexZRvFVlbpIU0uaB18wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdJQM/wfYisv1aa9gNcAaTTKAbpS3pIa6xYkNd+SLh0=;
 b=JeDTAM7dgtT0qCYHg9mJSDed1Gi7C57eP0jW95oMzEhAHSo2l8cHljipr6qoJf+wdyO6pRjxFHWCiujM9FPmivVjbmPRzLuayKvXyz2Q00aaxlxiCl4qgQS0bTX5MTWAE3KfBrZQHjpnoM+newdrIyVQpCWbvkOymkFe4Oe7aYuwkBeNkdbvnJ8TcJxJCLVfR/jkzthM+QEdKlFk7LFWipTkcR3rI9LqaocDs3xUXVDID6JWml3yJicGNwAqPm4jFSB0dNP7VazwDcMQ5LooWmKBW3wveqWulbXz/41kSkRwdQLSXsFfyhSf/rqJUPrk98fUPHmat7Af0CbadI0LVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PPF539334D8E.namprd12.prod.outlook.com (2603:10b6:f:fc02::945)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 04:40:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:40:13 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 03/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert
 to mipi_dbi_write_seq_multi()
Date: Fri, 27 Nov 2026 13:40:10 +0900
Message-ID: <86PXavKOQP6x9YV3szjG2A@nvidia.com>
In-Reply-To: <20261122081820.53199-4-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PPF539334D8E:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e326d3-837a-4165-182a-08df4c4086d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|4143699003|11063799006|261009223027099003|22082099003|18002099003|921020|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261022113327099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: BsotrAzJ56rYHq3rt8NIlSSfX+i0iQlTFiz89/zsBxT+ldBO8c8e0GL3rxVuaSbe5K9VgPYHsZh4KYqSr9ogMe6i4y7vuEEotyPnNGBUgmxGq1Al+Z20AnSq14EL6L2fEl07I9ySlzQdbKSDW3CPrVIhtgSYOOBAmohmPcchKy1FcfdJdET60HkKlBPSy496Hw67nS6jbzbW64ZhnneOL9KTmBsNRQ6Ah12wcKzh069snewAtzAROM1Vpu8g/qBR9SYaqPEMIQ3raczNvlHMxa15lv9WqhT04apXY8NqTDR1nhWpTgZ5z9ELagWV5h5hyXUt8RYr4fbE0RrpcEtoU0C7huW/lOb8pyLD5KrgUPfI7LrHUB4II9TwtnY7JW2U9UoBw7/O93ZF9SG8mN9mmMwlVw5Yw2DCDHmRlpUASFoC4/JQdnN7eNXeAWJ9ijX/F1EE8/ntAIpF3A2eIz6+/WzRy74RO74hQmRHT+9sIBZAcGC2xxxtBYPmzVPeZhJL05zRpadZlBSkomyo+SeWH3m5Q0EpWBiVK+dM9tKFxnUjEsYEoLkLOj+KcPcRPbUgY70GBmP2CE4RJHRrWDCtKv9emuJn/I9NE0jVfQtEB7PgkACxBvBbyBLsv0jzkbI+J3JxMU3tLcZafnqU9n1h/50KQ9p1vR+6tEUd9Kg4ILdpT0RbTiqsOP4UBvdiqKG0qQlvUU7PR7S/2aqfU/GYZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(4143699003)(11063799006)(261009223027099003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022113327099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1drK1J3ck5JcG9UQ2ZpOFV1UGlaZUpTY3gvaTd0Y3RZL1FlOUZkMnY2L1la?=
 =?utf-8?B?ZDhRK3I1UkFXdWJXbGxKVzYrMXg1UkVNdzJvUXNETGFKMVZldWo2S2JXbUNM?=
 =?utf-8?B?RFRmcENlTklvQUhRS0F2eFg4d2FNR0xlOHVZeUszYWVlc2hobDUyNkxuZzRP?=
 =?utf-8?B?VXIybkVYTlh4dWp5SXJIVUFyT05LbTZYaEZ2bkhEZnZtWkxUd1ltVVZMV0Mw?=
 =?utf-8?B?MFpacmNKelJUSFB1anVuWndid0d4dFRWYlFHL1IvbXZ1Mjh2WGRVRkxLbkRz?=
 =?utf-8?B?SWtNMVZnUkxsUVBIMlFHdVNsUEFqNWdUQ1RTQys5NkRTUVloTXJid1ZHSXRl?=
 =?utf-8?B?UTZuR2s2eDlRTTBLV2YzbGNTQytYdkNIM0ZTTUNNa0tINW5tNU1PcGplODB4?=
 =?utf-8?B?TGVLV2dOd3dPUGZWSk5xQWEwamROWkloVTZ1NXBxZkFRalZMZ0lnWGx6dGFL?=
 =?utf-8?B?TXdZWUVSQTJjKy83MUdsMkVvbUpaei9TS2tQbWYwWWdsb2ZXeUxsS2RQK2ZJ?=
 =?utf-8?B?bmgyK2YyeTQ3N0hrMXA1MklSekg1bGVZdy90N0NIOWR1WXVRbFhXdDMxek80?=
 =?utf-8?B?ZlV0V2hXRVk3R0xXWWFEZXQ4aVBhdE1yZ3JwWkU4amV6L1V4cUFuck5TcExS?=
 =?utf-8?B?RWVIOFZGc3JPV3c1Vk9XMU5jS0tqOW9tRXNNTFFpTFpSOFZ2UkpmaFdWR3hk?=
 =?utf-8?B?RjhNdVBLNFJ4VHZPVXhnSVcvWEYwbU1sVlc3YjBXYXpQR2krQm0xNVdmWDB6?=
 =?utf-8?B?ZGNVc1NleDNsbkpVNkF0Qmp2RWQ0Q0M3NHI1QnNibTg4ejhXaG11bzhEM2xX?=
 =?utf-8?B?SURwVHFvUjJNSUY4amd6eGUyUk9rQlBISURYM1RMV3RzdGRxakt4YkU4VjRq?=
 =?utf-8?B?aytpSmZ0SjJFWjFFQUVUNC9xMXdQTGZQVDZNV2xUL3gxaC9xeTBKenlJV2Zx?=
 =?utf-8?B?dW5Fa05FNU41YVJON2NnV2VxWWlXckZIYXM3enpRZTNkZysvSU9vdTRHRmlF?=
 =?utf-8?B?cEMxTGtsaGVvdlpkUE9oM0orWkRnZ3RJSzk5aC9WTzlxWjBaWHBDT0RZTEhz?=
 =?utf-8?B?aTZNTldNWm1weEJGMFptMkFiQTcrZFc0UWw2bUZpSGYvU3ZaK3AzeXoxWits?=
 =?utf-8?B?VUxJZzgxRmtKdy9LeU5rb3BFcTRhQmJKdWszc044ZWZNNjFYdTByY2FuN2p6?=
 =?utf-8?B?NUJPR3VTMFJ5OCtmVW1sMU9PSHp2MGROYXVyZjJCZmlUVWhWdlN1amt6cGxx?=
 =?utf-8?B?NENWQUhXY0E0RGZEejdzQ0lyWTNwblU0bTloOW1tZ21JTk9ielNuV2FTK1pM?=
 =?utf-8?B?NWpnZHI1VGdtMThScEp0MjhKN0pHbmljM1dta1Z2R3lwdHFSczMrK2JPMTVS?=
 =?utf-8?B?Qk5nR3FiYTVpUzlhc0gvQ25GenVUQjNGSHdyVkp4elZPVE13aFlXaDVMM044?=
 =?utf-8?B?c1VqdUR2MlkvTllCb2ROaUt1cGpQYndMTFNoUm5ZZ0dLZklyUGxNK0w4Zmlm?=
 =?utf-8?B?azhxVUVtTWszNU51YzEwK1ZhY3BrTmxxTnRNZUo2UWQ2dm11bEdzbFRGSVVa?=
 =?utf-8?B?VCtXbGd5SHpvL1l2TEt5OWtGZzhkaE5DNUlHTVRFRmM4b2xOREVxUHlTZHU5?=
 =?utf-8?B?WUJ1bnBZTjJWVTVHcFBzYVV3N2dzakVyamQ0VkRuYXZOc1ZXcG1uZ2xLVU1w?=
 =?utf-8?B?UUJiVWl4QVh5UDhUVXdBTUh5UHArZWxXYkJYL3ZjOUx6ZjFmaFhVbDI0MWc1?=
 =?utf-8?B?YnFTZEpkcTZDNE5rV2loS2pqWmhad0I0QnhIbTh5U3lYRG9XZ00rNkVtSzZv?=
 =?utf-8?B?VUlaUnlrSkhUVm5JckhmNFU3T0RWRzNvRnhPOThkSkdld1JnSkY1N1RBTjgw?=
 =?utf-8?B?bmVBcmpGVjF6ZHdGV3BJTnRudWRXNFRZRHlqNVE3TytLdHgwWmhFRlNVbGgr?=
 =?utf-8?B?UTRrbXZGNWQ2cUQ0VWc4U2cyY0dab1JWRlN1bkpSeVEyb0l0VGovaTUveVpC?=
 =?utf-8?B?bXAzWWRZY2c5TWlCQUV5anJVVzBHVHEyQnNYb3h2azh2bXJxNFRLTFk5U1lm?=
 =?utf-8?B?OVp5bzlDK0FBTlBKYlBOUmYwZ3NkbDBFTGpPWHQxOVJGait4UUtGNGdiQ3pE?=
 =?utf-8?B?UlhXSlVWOXF5cGJHQ2RWN0h2UENHWEhXOWZwOG5aZC96cG9WS1BSdlN5NC9E?=
 =?utf-8?B?RWFza2Z0Z2hVQlJqUi9mQUlhaU5vQWRLRGZqOWNaZk1RdmZIM0ZaMFMxdWJR?=
 =?utf-8?B?eXVwQlpNNGZlTlBnajU5N2dTVDNuckVCWlZMZlVQSzhRS29VUG1UWmpoVjBr?=
 =?utf-8?B?ck9WMStUVlNMRWkxZWNuT2xOcGQzNDdIL0ZxclhUS3h2aVhHbTJ0ZXAvWEcw?=
 =?utf-8?Q?T8RTD+UuNbZuNAiKmjy/kjKa8iu1nDc7h4OSAVN/W/GmO?=
X-MS-Exchange-AntiSpam-MessageData-1: NGJdvIcxPf3b0w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e326d3-837a-4165-182a-08df4c4086d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:40:13.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN709hvJ0vhvSzFOlLUnVl2chdw3AlCPfm06X5nUR1qM9TL/Mp7VQoA8WZRKr+HpbBriUVMBy3j0hh2cIHh1sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PPF539334D8E
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> Switch from the internal panel command-sending macro to a generic one
> to improve code reuse.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 213 +++++++++---------
>  1 file changed, 101 insertions(+), 112 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> index 318ece68b7806..c5b59a7341d8e 100644
> --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -37,19 +37,6 @@ static inline struct hitachi_tx10d07vm0baa *to_hitachi=
_tx10d07vm0baa(struct drm_
>  	return container_of(panel, struct hitachi_tx10d07vm0baa, panel);
>  }
> =20
> -#define panel_dbi_command(priv, cmd, seq...) \
> -({ \
> -	const u8 d[] =3D { seq }; \
> -	struct drm_panel *panel =3D &(priv)->panel; \
> -	struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
> -	struct device *dev =3D panel->dev; \
> -	int ret; \
> -	ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d))=
; \
> -	if (ret) \
> -		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
> -	ret; \
> -})
> -
>  static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
>  {
>  	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> @@ -76,118 +63,120 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm=
_panel *panel)
>  static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
>  {
>  	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x=
1f);
> -	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x2=
0,
> -			  0x00, 0x00);
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
> -	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_2=
4BIT);
> -	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
> -
> -	panel_dbi_command(priv, 0x71, 0x00);		/* Ex_Vsync_en */
> -
> -	panel_dbi_command(priv, 0xb2, 0x00);		/* VCSEL */
> -	panel_dbi_command(priv, 0xb4, 0xaa);		/* setvgmpm */
> -	panel_dbi_command(priv, 0xb5, 0x33);		/* rbias1 */
> -	panel_dbi_command(priv, 0xb6, 0x03);		/* rbias2 */
> -
> -	panel_dbi_command(priv, 0xb7, 0x1a, 0x33, 0x03, 0x03,
> -			  0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
> -			  0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
> -	panel_dbi_command(priv, 0xb8, 0x1c, 0x53, 0x03, 0x03,
> -			  0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
> -			  0x00, 0x01, 0x01);			/* set_ddvdhm */
> -
> -	panel_dbi_command(priv, 0xb9, 0x0a, 0x01, 0x01, 0x00,
> -			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
> -	panel_dbi_command(priv, 0xba, 0x0f, 0x01, 0x01, 0x00,
> -			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
> -	panel_dbi_command(priv, 0xbb, 0x00, 0x00, 0x00, 0x00,
> -			  0x01, 0x02, 0x01);			/* set_vcl */
> -
> -	panel_dbi_command(priv, 0xc1, 0x01);		/* number of lines */
> -	panel_dbi_command(priv, 0xc2, 0x08);		/* number of fp lines */
> -	panel_dbi_command(priv, 0xc3, 0x04);		/* gateset(1) */
> -	panel_dbi_command(priv, 0xc4, 0x4c);		/* 1h period */
> -	panel_dbi_command(priv, 0xc5, 0x03);		/* source precharge */
> -	panel_dbi_command(priv, 0xc6, 0xc4, 0x04);	/* source precharge timing *=
/
> -	panel_dbi_command(priv, 0xc7, 0x00);		/* source level */
> -	panel_dbi_command(priv, 0xc8, 0x02);		/* number of bp lines */
> -	panel_dbi_command(priv, 0xc9, 0x10);		/* gateset(2) */
> -	panel_dbi_command(priv, 0xca, 0x04, 0x04);	/* gateset(3) */
> -	panel_dbi_command(priv, 0xcb, 0x03);		/* gateset(4) */
> -	panel_dbi_command(priv, 0xcc, 0x12);		/* gateset(5) */
> -	panel_dbi_command(priv, 0xcd, 0x12);		/* gateset(6) */
> -	panel_dbi_command(priv, 0xce, 0x30);		/* gateset(7) */
> -	panel_dbi_command(priv, 0xcf, 0x30);		/* gateset(8) */
> -	panel_dbi_command(priv, 0xd0, 0x40);		/* gateset(9) */
> -	panel_dbi_command(priv, 0xd1, 0x22);		/* flhw */
> -	panel_dbi_command(priv, 0xd2, 0x22);		/* vckhw */
> -	panel_dbi_command(priv, 0xd3, 0x04);		/* flt */
> -	panel_dbi_command(priv, 0xd4, 0x14);		/* tctrl */
> -	panel_dbi_command(priv, 0xd6, 0x02);		/* dotinv */
> -	panel_dbi_command(priv, 0xd7, 0x00);		/* on/off sequence period */
> -
> -	panel_dbi_command(priv, 0xd8, 0x01, 0x05, 0x06, 0x0d,
> -			  0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
> -	panel_dbi_command(priv, 0xd9, 0x24, 0x01);			/* ponseqb */
> -	panel_dbi_command(priv, 0xde, 0x09, 0x0f, 0x21, 0x12,
> -			  0x04);					/* ponseqc */
> -
> -	panel_dbi_command(priv, 0xdf, 0x02, 0x06, 0x06, 0x06,
> -			  0x06, 0x00);					/* pofseqa */
> -	panel_dbi_command(priv, 0xe0, 0x01);				/* pofseqb */
> -
> -	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
> -	panel_dbi_command(priv, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
> -
> -	panel_dbi_command(priv, 0xe2, 0x00, 0x00);		/* cabc pwm */
> -	panel_dbi_command(priv, 0xe3, 0x03);			/* cabc */
> -	panel_dbi_command(priv, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
> -			  0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
> -	panel_dbi_command(priv, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
> -			  0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
> -	panel_dbi_command(priv, 0xe7, 0x2a);			/* cabc */
> -	panel_dbi_command(priv, 0xe8, 0x00);			/* brt_rev */
> -	panel_dbi_command(priv, 0xe9, 0x00);			/* tefreq */
> -
> -	panel_dbi_command(priv, 0xea, 0x01);			/* high speed ram */
> -
> -	panel_dbi_command(priv, 0xeb, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
> -	panel_dbi_command(priv, 0xec, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
> -	panel_dbi_command(priv, 0xed, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
> -	panel_dbi_command(priv, 0xee, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
> -	panel_dbi_command(priv, 0xef, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
> -	panel_dbi_command(priv, 0xf0, 0x00, 0x33, 0x0e, 0x15,
> -			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
> -
> -	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
> +	struct mipi_dbi_multi_context ctx =3D { .dbidev =3D priv->dbidev };
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0=
x03, 0x1f);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x=
03, 0x20,
> +				 0x00, 0x00);
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXE=
L_FMT_24BIT);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0x71, 0x00);		/* Ex_Vsync_en */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xb2, 0x00);		/* VCSEL */
> +	mipi_dbi_write_seq_multi(&ctx, 0xb4, 0xaa);		/* setvgmpm */
> +	mipi_dbi_write_seq_multi(&ctx, 0xb5, 0x33);		/* rbias1 */
> +	mipi_dbi_write_seq_multi(&ctx, 0xb6, 0x03);		/* rbias2 */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xb7, 0x1a, 0x33, 0x03, 0x03,
> +				 0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
> +				 0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
> +	mipi_dbi_write_seq_multi(&ctx, 0xb8, 0x1c, 0x53, 0x03, 0x03,
> +				 0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
> +				 0x00, 0x01, 0x01);			/* set_ddvdhm */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xb9, 0x0a, 0x01, 0x01, 0x00,
> +				 0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
> +	mipi_dbi_write_seq_multi(&ctx, 0xba, 0x0f, 0x01, 0x01, 0x00,
> +				 0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
> +	mipi_dbi_write_seq_multi(&ctx, 0xbb, 0x00, 0x00, 0x00, 0x00,
> +				 0x01, 0x02, 0x01);			/* set_vcl */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xc1, 0x01);		/* number of lines */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc2, 0x08);		/* number of fp lines */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc3, 0x04);		/* gateset(1) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc4, 0x4c);		/* 1h period */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc5, 0x03);		/* source precharge */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc6, 0xc4, 0x04);	/* source precharge t=
iming */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc7, 0x00);		/* source level */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc8, 0x02);		/* number of bp lines */
> +	mipi_dbi_write_seq_multi(&ctx, 0xc9, 0x10);		/* gateset(2) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xca, 0x04, 0x04);	/* gateset(3) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xcb, 0x03);		/* gateset(4) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xcc, 0x12);		/* gateset(5) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xcd, 0x12);		/* gateset(6) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xce, 0x30);		/* gateset(7) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xcf, 0x30);		/* gateset(8) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd0, 0x40);		/* gateset(9) */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd1, 0x22);		/* flhw */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd2, 0x22);		/* vckhw */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd3, 0x04);		/* flt */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd4, 0x14);		/* tctrl */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd6, 0x02);		/* dotinv */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd7, 0x00);		/* on/off sequence period =
*/
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xd8, 0x01, 0x05, 0x06, 0x0d,
> +				 0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
> +	mipi_dbi_write_seq_multi(&ctx, 0xd9, 0x24, 0x01);		/* ponseqb */
> +	mipi_dbi_write_seq_multi(&ctx, 0xde, 0x09, 0x0f, 0x21, 0x12,
> +				 0x04);					/* ponseqc */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xdf, 0x02, 0x06, 0x06, 0x06,
> +				 0x06, 0x00);					/* pofseqa */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe0, 0x01);				/* pofseqb */
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xe2, 0x00, 0x00);		/* cabc pwm */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe3, 0x03);			/* cabc */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
> +				 0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
> +				 0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe7, 0x2a);			/* cabc */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe8, 0x00);			/* brt_rev */
> +	mipi_dbi_write_seq_multi(&ctx, 0xe9, 0x00);			/* tefreq */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xea, 0x01);			/* high speed ram */
> +
> +	mipi_dbi_write_seq_multi(&ctx, 0xeb, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
> +	mipi_dbi_write_seq_multi(&ctx, 0xec, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
> +	mipi_dbi_write_seq_multi(&ctx, 0xed, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
> +	mipi_dbi_write_seq_multi(&ctx, 0xee, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
> +	mipi_dbi_write_seq_multi(&ctx, 0xef, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
> +	mipi_dbi_write_seq_multi(&ctx, 0xf0, 0x00, 0x33, 0x0e, 0x15,
> +				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
> +
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
>  	msleep(110);
> =20
> -	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
> =20
> -	return 0;
> +	return ctx.accum_err;
>  }
> =20
>  static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
>  {
>  	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +	struct mipi_dbi_multi_context ctx =3D { .dbidev =3D priv->dbidev };
> =20
> -	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_OFF);
>  	msleep(35);
> =20
> -	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
> +	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_ENTER_SLEEP_MODE);
>  	msleep(50);
> =20
> -	return 0;
> +	return ctx.accum_err;
>  }
> =20
>  static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
> --=20
> 2.53.0
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



