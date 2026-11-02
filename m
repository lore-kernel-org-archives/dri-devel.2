Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43981606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RkxaBTtE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D0210F04D;
	Mon,  2 Nov 2026 20:03:31 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A21D10F04D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 20:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBYkZSmwo2yBXBreJHiYDIo1R1mPV/GWgHC0xaWkI1yrVrx9WcqqxzpQGUN78I+Xlm1Hy/IE2qFxqfo9rDo7xncoYzlxP1LwuvP/7pAFQnVRbdzRtkXpOyVH7jku8S6OG3Qal7MnGYSSQslgSEFArdBEUO2kKwSF7uXFBUF0TL/dL01/tBuUJ0EoVCPybu5yUzSUtaN7NJLK3isXSuwsGbgmhA+EBpE2LpWgYq11sbIPRgMyWgVZqVfNmJg5JuOakeysLSvdtYhrojEBXMBe3S18vfwj8Y5ANTormhtR+6PTD1EPUdGsVs0atfaPy6+j4JY6j9yPsjY7pNc9u8r7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+QoJR/LdiMFCjfmPj/8RmrxAhSVu05NG4poE0NY194=;
 b=ytaHt9+OWxuOIAvixBCONw4CPfh1jvbhuEta5pFBRXlvrF2W+Mac43pocdi7URH62oKN4POMCZhCY75CU5OkUkAv3mAnCffEMWFDVBW8nAsf9KF2M+Bf8PUIgHLXLzJk0x0jLfiE4GJArAwvUX0+xhhT0ULQ+g80OB9UWfqTNFXcQCvjYj1noEc6GjCpENGRSvueYRDOtzu8xD+69gOw33UI/1xnX4jkL8l5tKOxaCuIErqqww6wEBEEIz0fqmTa/Hz2A2p5X6i0tXHxlKTHdrOQfRqQOTZbI7uB9x4QZb3HLxyMq3s3rmewRjPtcHTMB1FyMZ91tUbC0d9pPiUhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+QoJR/LdiMFCjfmPj/8RmrxAhSVu05NG4poE0NY194=;
 b=RkxaBTtEZwbrZX8YrXgAAlNj/h2rz4yjUyK8OvyPxShG5o5I1AggIo7WemB8BqZLmyhuohGIl+NWXUNGWUgt8NaRhqlTAopR0aPDiS0oE/chvJM0nTx6smr9mYQMi+XU/Mja2Kmp1uYF49uTKc/Wbr1hAwckBhnHiiq4bfHpmU8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR0PR04MB048688.eurprd04.prod.outlook.com (2603:10a6:2c8:48::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:03:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:03:20 +0000
Message-ID: <fa346541-c877-4390-9837-1bdff86eb4f9@cherry.de>
Date: Mon, 2 Nov 2026 21:03:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
To: Heiko Stuebner <heiko@sntech.de>, neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20261102161801.102464-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261102161801.102464-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::45) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR0PR04MB048688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb83baa-0b31-4f3f-b718-08df391c57a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261021121427099003|11063799006|56012099006|261022075727099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: dXqQrrEIL0BwJvfayVkPS0mf3WuKKMXW0Hh41j2vpxksO0wEqVXzjW33wWqcPVRkBHYrXpzA2KhlEatdBvY4Y8/SQzZiEGfIvY60XTQg482dpr5nxtaAJLE80Ff6/AdHh1scDr4Q5JH8prU+DpjGKCUVVqCYv0YMjzaTuXgIDawJ9YkSF+i/SA3nINslw390nxOIC+hiGtO2YDnZnMqZthcA5eH6CgOge31QOSQ+v/gT7dOAqzKttjYJWmnW7IAtTl8wmSSGuxFe8YqA9yUzBPgH7+Tq6ProbYN0FQskKCeQVejRh15dO/mU5Ek2Z4hxwqE5epBOtiglXAHGTBoGycFpHyQxlCgvGxXjHzHmJINU+00lgCZQK1tQV13VmgFCi7ww1Hmh5zSVnU/+EVwN3oTetVifDpg23sLUeYEDiIx+PV/izlbDb8VZz4ytHhcJBaw83obgasTbTUtZaO4LtU9zIox+u8kGxaK8RIhWsm1DlGbYz35kVe8+wc0PTSgngl5JiQM1xh+S2XNafFJ6ebC5Mtt5q3B7iOOCoNG+jeT5UVl4jfzkTZtfZwCCi9OloatcL1Rp9wOP+6SS96f/MzAKfaSvtdvhhFqJG4xqZgJ3m1LOXycQR0pFcqzlO6Okd9bJPUzbqIdnmPjWcMG0qswLy4WPzj3F1mwsKRF3Qqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021121427099003)(11063799006)(56012099006)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2o0VCsrUVZVcmdVNmp0R2UwNnVDM3ZFTlN5M2R3Ykl0YU9mN0c5UTRKTCtR?=
 =?utf-8?B?bTBocXE0SFdLMjNlSk9KL0dhTDJDNjJPL1N6c2JsNjVhUnZ4QUtHcE9ydXFJ?=
 =?utf-8?B?NmdEb2laaC9GYXBLZlRlLzdUalU4Mzkxdm1KSlV0eEdQZWFVaFdwUkJBejJy?=
 =?utf-8?B?U2UwOUNlbUdvMXpiZ0dQeFNvTER2T05PQzliM0dKbmZMYnpVQS9QUmN3UnRE?=
 =?utf-8?B?U1dzcnBVR3ZIbk1mc3dMSVh0djdxS2VGbnMrays2SXc3TlVxakxSYjNWdWEz?=
 =?utf-8?B?ZWp2b1UzNlN0MG9hRk02Tk5YME9vcDgvTy9YYUxoWjUzK3dwZERPazl2NjRE?=
 =?utf-8?B?L2dublI1YmtSUkZlbnFCNkNqenc2NXU5dkI5SEpTVEt5VXpXVWxoclYvejJp?=
 =?utf-8?B?OE9MTUhzVmpYaXVyVWltZ3VXbXU1N3dkUy8wSDUzWGx6ZDJOMjRPZFVyRmY2?=
 =?utf-8?B?MGJBTVJVbmcvaWlMVzhjRmcxL1FZSG1wdnp6QkYxalFROVVJWU1MejhjdUdx?=
 =?utf-8?B?RlFBQXFqVVZSanRqa3NhMFBaa0RSY1lpSmsySWMrS3FvL2JNbUJoY1MrZjM4?=
 =?utf-8?B?UWJLWm9ZVHQwMk51dWw1VzNNejhaVlJtYkpKak5qQ0dXaXNMaUlyRDF4aGZO?=
 =?utf-8?B?OWRseXQ1akhtRnYvRzJ3NEk1TkRHYlhhV0lEUit3bGVCaktNYkJKaXJTTnFz?=
 =?utf-8?B?OGk4Q3NRaXNLVWdoOFZhc24yakJZaGRRdVJTS2FpUXd3aDlPVU9mZVpYM3Z1?=
 =?utf-8?B?bUxKZGJQRE1GZXEwa2NiZHRjcDhMUFJUOFRrNHgrSzY1YTlLVmFBc0UrNkhW?=
 =?utf-8?B?VjFmRXZIOHdjQlVabWtwRnZaWDdnVGFMbnNDMWN3ZTBnWUIyRUJINU1zazBu?=
 =?utf-8?B?RUlFNlVLZWpIWGNKeEhLeGxXUmtyaFpwVmx6MStjZytIczNaQkZtQ0ZSTERi?=
 =?utf-8?B?ZE5GZ1UxUEp2YWlvV2Z3bENDZE1NVVFISWV4czFZbXpJc2ZIcUdwMXpVQ1F4?=
 =?utf-8?B?cUxTMXZqemtXZHQ0S3pVZG02UkhOa0RlWUZhL2dTb05tV0hQZmE1dFlLRjhO?=
 =?utf-8?B?MzMyaEV0VjI1VEVsdm5PdGp2dEhSUVNJbzI0UGNhWGdvVEsrdm9IR1lBcVRQ?=
 =?utf-8?B?U000MGk1NitxcnVGLy8vN2toMGFuY2RMUHlVTEVCRnZaMURqRmV3ZnU2czJk?=
 =?utf-8?B?UVk1MXQzRlNiMUtzSDY4TGRGdFY2b29ZYWtPM2JqM2drejJ5VGRLejFNUmJh?=
 =?utf-8?B?R2Q5Rnk3MW01WFFNVEo1Q2NUd3FENXltR0FQQlY5UXBON0xCSS9FWGlYVEc4?=
 =?utf-8?B?Y0xySWJ0bTQ5LzQzMldZb254NUlDVTBpNEl6d2ExQ2Y4OTJhMjlpUS83VXIx?=
 =?utf-8?B?M1R2WEIzWTVCb2czZlJ0QkpiZUJ0dngvenorZUFNZGJjUE1MMDZ4ZUJ0ZXpx?=
 =?utf-8?B?WW1XN2tiYVFCMVRVSkVhWlNXeU0zYWRYQUZzUmVMWVBVaHVTaVJPcjgxZkhq?=
 =?utf-8?B?cml5ZDRnZmppVUVWbWkzRU1PMGd0L3NiQWZneUdhWDVnNDBzNTNEcUZRcXFI?=
 =?utf-8?B?WkhPMWV4TE9UMlZjTnBRY0I5bHpwR3d1MUk2T0U0RjRMSzh0WUpTSEx1SU5R?=
 =?utf-8?B?ZWZ3K2xwODNDNG40TDJsRk9PQlBEdEg0NDhEd2tTa0hJbkZIZ1NBaitLcUx6?=
 =?utf-8?B?NDdicVdoNHVsS1ZkRThtYzNkZ084a2Z2UzErUUM5ZVorMTlsM2dmZTRYbDZl?=
 =?utf-8?B?S0lCN3ByK1hHT1Q2Ynh2cU4xN1dXSkY3aUoyaGtwckg1amRVSUNlNlR3ckNv?=
 =?utf-8?B?WGJkU2ZSbFA3c2JUTkhqYnVZblJXMEJ3YnhJaUp1SHdpMzZRaUlSOTdUZklu?=
 =?utf-8?B?YUV0eXk4S1BDaW9oQUNBRFB1aGpKc0hKcHVmZEFvUEZMNDZ0YTNwWi9BeG1u?=
 =?utf-8?B?bldFdjkyZ1ltUzdRVjlrb2piY2pCakhoR1pzQm9ZNFdpVlFldy92WFF6U3FS?=
 =?utf-8?B?aUhETXh2VnJqY3I3eW95d2VMcXI5R3c3bUJOcFJhQ24zRGoxQUJ2MXN2bWla?=
 =?utf-8?B?OEQ4b1Qzc3h5ZDhhWHR5SUNiZytkbzl3aDZRNXZUZ1h6NmdrN3puck5DdE9w?=
 =?utf-8?B?NGZ0TGllVUNNMEVWYjg3S1VwK2ZuclRCQ1gyNGJIMnFBLzZvVlVSWVExSVQ2?=
 =?utf-8?B?cm91Mkx0TnBQalhzNGk3SlZIS3p1RkFGWllSSmdFU2xtMXlySE4rL0pQQUti?=
 =?utf-8?B?SFFDOFdTS0NPZnJLK3QrYldPSmZsWkZvUjF6cU5vL2NPNTQzNVdzM3FnWkJN?=
 =?utf-8?B?Rllyb0R1TlJkMlA3K1FFbUF1NDNmU3laOFh6NHBudFZLUFA0Q01Idz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb83baa-0b31-4f3f-b718-08df391c57a0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 20:03:20.4050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhbiwzwFsK+UE18QlpZxN1wuzbcin0TGcxRFh4kGzA0bQv4ZqiI/loKFR1dzun1cCLFVKj7otGJRHhqbrSQpUlo94WUj6RgMZFH5g/YQLvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB048688
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On 11/2/26 5:18 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The panel will happily report every defer during probe with an error
> message.
> 
> Silence that to actual errors.
> 

You forgot to add Neil's Rb from the v1. Here's mine:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
