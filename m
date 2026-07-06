Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D5CC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C66D10E813;
	Mon,  6 Jul 2026 08:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="TxvNOlNg";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn19013083.outbound.protection.outlook.com
 [52.103.33.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115F310E813
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf3wMwLO9MYAHJW4o8QO9eLfcHvkWIH0tT3N8IWQ9Q3C5F9wFpmR1kKKhVCDYuIeaD/0oKepbK5GBX2siIDUcIsixdJPAzq/CIsWsEPQI8WuacFfldVODZgYf+4e1jEbrajFr6pq3v+V34N9UYut1dr1UmCHPJiL437namxg5bbGvbt7OLdluJcqQ6+UcU1k4E+Q8fbirwX5Pp0ABoL4+MsBKDFr9gPuzPoBnkRcfqen+A+V1tLH5aefQxEn2lrK98Y3H5gwr8beJY1NUXE1KN1lBhhomUiIf7zbOjkafeF2oaC8KsnL+gXqOrnvqg8AXpOcAl1OSFRyxnZ84rTPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/AnyAcUhowlKtvWxukttUWQ+xGkaLupaEueWFpkn0o=;
 b=bwZiNxTVupHlN51PJddgvCc8mWiWfarNDsk824+Ik4JuyzTZhdiIQDSyUqY6LNrxv1mceYKXi0YlVYrlLPdYBleNHDm6++Z9oQnrdZSIiXkArsmPEBpJNghcE+SIRUJXOXJZLt+gEgrsHpw7a7pmlbfilXsbCxzrPbMWFaiMwfAtu5eMX7FAsVnAsYddoVJp5fbtrhVXpw7hukgPoCOT0z7ZSzZN8zEKKX1ig1v37p9rfgNc1ZdjugnKI2Rdf4BZwweVc99urfIqfBHlE6bIbnKwEbOhq7fYPDmJpO1BFMlPQ+Dm7dqAjImqDh3XW9gPFInJBGdQzoc/XCE3ncxUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/AnyAcUhowlKtvWxukttUWQ+xGkaLupaEueWFpkn0o=;
 b=TxvNOlNgawrJ0YwU2UUypGcNi5i8Rtaeqnez6z9v5Km4NaZu78BDiSd5odzV/lp5kGlVaeVhTwuA2dZwNxifI/eLYFJx6rAMcSFq/3dffQ2P01guV40poLf8ORZMc5TEUELhSZLsDDOg9SCGILX++8vZ59FF8nRY1hlDhUrvJzBI2VMBzxbQ5jgtU9bTLtVYdpYEx/iHLjm07FZq1ob2Mxtyt0vf6byqCzxWb1J4WUdQvu1EyBzJCoBBEdjUGQR/hYFqWpG7Lmk3d+0/M87TCvQONcBaji8aGIx6M3slbXI14bebSTWhL0EXs+FouW5/k98HryQ83ZAgfdaDDeD37g==
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2dc::14)
 by AM4P189MB3485.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:33:11 +0000
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6]) by VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 08:33:11 +0000
Message-ID: <VI0P189MB368755F862D5D09583250AA3E3F12@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 6 Jul 2026 10:33:09 +0200
User-Agent: Mozilla Thunderbird
To: cristian.ciocaltea@collabora.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, andy.yan@rock-chips.com, daniels@collabora.com,
 dave.stevenson@raspberrypi.com, diederik@cknow-tech.com,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, jernej.skrabec@gmail.com,
 jonas@kwiboo.se, kernel-list@raspberrypi.com, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, maud_spierings@hotmail.com,
 mcanal@igalia.com, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
Subject: Re: [PATCH v8 00/39] Add HDMI 2.0 support to DW HDMI QP TX
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::15) To VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2dc::14)
X-Microsoft-Original-Message-ID: <51ae8587-e735-406f-9394-8c45935c901d@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3687:EE_|AM4P189MB3485:EE_
X-MS-Office365-Filtering-Correlation-Id: e964193b-f75b-4fdb-2520-08dedb3936a2
X-MS-Exchange-SLBlob-MailProps: ymJijV9pwJmqIFlrpIev1LE8wkolwKKSEFejQRcvs6iXaFysy6S0YOjZWVy8cAf/kbuXkqwMryry8mHfieWh/dofBUJHiueID8E1gbwlap8zdqOULoHnA3sSVPcxxcSMUUx1xclpCAyN+KcIIAGpcmgRQe/fJKbr5MYLjNsps7fz/n8iOdsQKSg4tQoBE4axdrdtS+oi/oGtEofj88Aa2JpwZdtvqzWsSZriYm3m5pmsAqzgfajdCF+TNsZnBfHE5NAjA7jciMwzLy1414SC5LpDd9leJHFoqVI+t2Qj6OqSDxdfNtRaqNsFWIngJKtnIW1D6WdZIN32ps3nAKKEHawaVnOrdwe4SYIAuIUBiwBu67HV9Kgv0QPCKAj6uiNL2yfaLtQdo5KVRwlQtlXLHFPY2juXETzsb7U0bSOsKpsJ98DUHvp/w7wA1trMJhmwuOYm7TwizgexpQKeHfYkQQExXefVwBHDiKG9BwMSPJcRUh2k4cLrlgfvRhH8wx6AQoi0/bYZtqaO0DFDy/ahJhJalF03R+VYo8Ky3jZbzL9Pv1SyGYZF49bArRO9hOAt73FX30Lm1q3tMkg3EJ13Jr9qaFEFVILwC1UKT6CN9hEK8t3118R/GwK0mQlNWMyyEwY9Y4dcCnqSz9vA/nLwDdP0VC9fpzUPpyjHE1vwftUsXx9/ri4AJ/mEIaTZwNvb880EkvEo8IFYJ+VWtM5f/Ft8MMLKKpAIUX9sI9ZGSkhU28kmGEJshlOfGRJSnSqUXZpiZTiHkqpc13prAE1yDnscTq+2LMWbruSYmwdxTbNptnlypkahGZ2vAxYpnk5e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|5072599009|4140399003|15080799012|25010399006|24021099003|8060799015|19110799012|6090799003|440099028|4302099013|3412199025|41105399003|10035399007|52005399003|40105399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjBESitabTVhanlzZzZpYkpQdWxhTkJjREJ1YmdFSjdJVWFMSVFqaWwxT1Vm?=
 =?utf-8?B?VFkxRXMybjdMZjFZdTdiYkFHeWVuV3hlenk5YlI5VHRJam93QmcrNGRzdU9v?=
 =?utf-8?B?cEVTVFBnU05EQ2dLemdmakVQQWg4NVVpNlVST0ZTWkxxcTExd0JiOW4yT2JR?=
 =?utf-8?B?bUdrb0ZpNXBJMFlnRVdrQTNWUTd3b0dUK1RsYitXN21LeitBV0xJN3JRODA3?=
 =?utf-8?B?TFlESVJFb051NlhWNEJjYWRQU3hkcTFTZk1CaTZEVjZzaDRaV1ovWld1YzBY?=
 =?utf-8?B?UmpXWDVTY3ZPWEVROFJuVDBhV1BqVlZUS2QrZEJ2c2NYbW9rbHN2MGJqSmUw?=
 =?utf-8?B?RCt5VU9GdTQ4K29tb3V3WVlnWmZaN2ZDRXdiMHh6V1FrUDdaYm9KckliSEt5?=
 =?utf-8?B?UVN2aHNxUzRYMTMxdllBYnBhSUQyTko3S0ZsSVhxUTBvT0VCTSs4R3I2ZVBC?=
 =?utf-8?B?MUpJVjRaeXA4cUtTZVRmcEdoMWJRci9rYjcxelRaeWh1NENlc1dzcEhCRDdI?=
 =?utf-8?B?Y3Y2dnlEN0xyMGE5QmYrd3F0YkplZng5bUx4RGF2UzZrbXZnd3JJQ3E3UDlN?=
 =?utf-8?B?am1IWitqTjAwakxxV2JrRlJDMXNaZ3lrMEFLZUJuRjR5cXVVaWpzeVl4NmZX?=
 =?utf-8?B?bWZWQWJqU1QrS2Q4WFJuV2RpaDZ5MVcxeGpKbHNSRVQwSlV2MTdvdWZJV3lW?=
 =?utf-8?B?a25PUm5DOTU4OThNbEptMndZSXZUU3JEZDVuUVh0TVI5eWw5TEduMEZrQWVo?=
 =?utf-8?B?OW5GYk1GNUl2RkRXZWlxL3pERVRkdmcwc2JpZzdLMnZ2bk5NWkxZUGx5aGIy?=
 =?utf-8?B?czlERWw0L0FHRkNHbU5UemRMa0syWkRqN2ZBZ0F0ZXVBOW1Cb0FRREVXZVh3?=
 =?utf-8?B?czVEb1p6eFA4OWsyN3JDNFh2dDhQSzk3N2VjYU9ONjY1NCtXYkhoc05PWnFs?=
 =?utf-8?B?cVV2WTdLSlRmVGVIYy8vaW84OXltWjlPNlpiMk5OS0R3eWx2RFYzbExFeHBw?=
 =?utf-8?B?dVZmN0twaE1iUkQ5MTZSTmZRRHBXY1M2N3ozNVJmZUtHS2hDUWkzdUxpTEhT?=
 =?utf-8?B?ZS9XL0RJZnZUb2FOdmdhdUs3UGx4T21sMFpvNitTSmlybDhQVjl6ZmNRR0Z0?=
 =?utf-8?B?cVdOWXVVQWhlNFF4L1pGRlM1L3RLZTlRUHdPUE5hcFVzQitvVTBWZkdqZ2NF?=
 =?utf-8?B?em4wS2xhemZqZFhjS3hoM0VYT2piNTJ0ZUxiYzErL1B1VUZqUjZPZHpuQkMv?=
 =?utf-8?B?M1Iyd25kUnJtR2NqNUM1YWxhK2ZmYUhETW13dDYvVTI4NDVicXYrdUp1WEF1?=
 =?utf-8?B?eTFsbVkvY3E1S2RGYWNpWUt2YWVRWThadFpic3RhaVZ5YnRiSG5VNmsraXly?=
 =?utf-8?B?MU9PNE9rbWk5T1hVQWRVbGJHdkR0MmZLRU9rcW1YWVlDSVNXa0pydDJuUjZW?=
 =?utf-8?B?VXYwcGVqMWpJUWR3Rm1Tb2NBN0xyU1N0bjBNVXpzTUQ5VjRJNzl2UG9TK1I2?=
 =?utf-8?Q?UhKSM5V7oy340K0RbC22g7PUn6w?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVoQkYxb3phdi9vdDFiaWdpeS9sZ2d6M2tyaS9nQ2IrWG94bEVuUlVUYUU3?=
 =?utf-8?B?ZnNnSzJnT1Y2Y0Y5S3FHT1h0c2F6SjM2eWg3MEVMM3RUclN2NlFkeGQxeVcv?=
 =?utf-8?B?MFcxd255bnZObGJGWkROeWFrSVg3aGVqZDI3TWVxSU1ldnVUYkJ4OVpKbTlO?=
 =?utf-8?B?Q1U0SEw4djVHdEozVFdZLzQ1UVM3ZWFGL3VyVGVNUk9iei83dlFRMDhKRTl6?=
 =?utf-8?B?dEs3dmJuRVNKOVRoV2FrM3MrbzhHVXFQUTFIYzhrWGhlMnpxNkNsWjVid21G?=
 =?utf-8?B?TnNWZlNzMENYM2lBdjZhcTIrSmNmSFhVVWdIMlUyMlZQNjlpS1BCY21HWXNq?=
 =?utf-8?B?L1pWVzNuVGVlYUgvNHlFbkwyR1pScUNaTjJKaGowWTVFSDIrcEltaFMwR0hB?=
 =?utf-8?B?L2ZHNW1CTnRWZVNhb2ZsRVc2Mmo3bHg4L1dWY2VIUWFxVXZ0VzVLSFU3S3Ir?=
 =?utf-8?B?dWRrbC9sQmJGeExzTmtlZkNHMmZtY0pSZmEzWUQ2Y2FuV0F5VmJhWml5OTda?=
 =?utf-8?B?WnZYR3V0UGxaREx0MmZpTFlkbkZIYmdHMTMzWWNPTlFzWVY5SXg1T1g2TUMv?=
 =?utf-8?B?aTRYQU83OG1URkhJM2I2ZUQ0cWxmVk56N2ZDSW1LTGhuRFE1amVkb2Zpc014?=
 =?utf-8?B?cjB6VUN4SGlUdjNtN0NxUll2L1ZTY2pyTjhCNEpLa3pBK0pSYm5uV0llZ2JK?=
 =?utf-8?B?WHFWL0s2Si9SVXRNSGdBMlN0ajBZcEJVWFJvQXlHL0NLbnJ5UWZtaFNvYnZk?=
 =?utf-8?B?OVZ5SzhodkR6YWxCRWcwQjQya1BLemVtNy8wZ05EdzFHRDFMWFBHSkErQWhx?=
 =?utf-8?B?eGhwUDFzMWxvSVRBYmg0S2pmOTI2a2duQTJmVEl6Z0NMSjhOd2REb0FrRkdL?=
 =?utf-8?B?UWw5RlhVVi9PZk15UDlaYnliaVVERW9Zaktvd25FM2FoMTl3aUJSUTB2bHEy?=
 =?utf-8?B?enVWNGRDNFVFL0lOTTBuUUg1dkR3eUpEbEdsdmlMZVo0OHB3cUZGNGZ1c29F?=
 =?utf-8?B?OVN3bXVnU3oxZStSenNzZlllQ1NQbG1jYi9takN5Sjh3NWtnOXZYSHFISjNo?=
 =?utf-8?B?VXBEZFZvaEVMc2Uwc09MWVRDZUt1dzQydStVV3ZMSGE1VE5TT2hLMFZLc0Fm?=
 =?utf-8?B?N3BYZG1FN0JORk1pQUsrNEdVeTU4NUpRQm83K0kvWmpHbVZ3MGpTcmFDZlVP?=
 =?utf-8?B?bm9yc3kwY1ZjbVQ3WUd3NE1WODNKanFJL0Z2Zi9tR0VPWll5NlJGN3YvMzZp?=
 =?utf-8?B?amUwaWtNcUVNVzlGbWJobnRyV2FjdUZhVEVHMEhvaUs5OHNuSHVKcmtyQ3Vs?=
 =?utf-8?B?MVpMcXZYOGhUZE9odCtseE56ZlVycm4yWWI4Z3hwZTYyK3p4TXpTR1NHZnN0?=
 =?utf-8?B?MklKRmxqNjZESjhZZ0JyN29oUlM0cmNFdWZqRW9Lb2FTWXhBVHdYb2hyY1V5?=
 =?utf-8?B?K2djMkxQT2xEQitFR0wwR0tvNFRpVDlnNW1NWEpOaVJXbnR5Q1gxVG5BK3Zo?=
 =?utf-8?B?MUVVY0RiNldpS1VOR2JMNDh5VTFWNG1VMGkxa3BnWC9ZV3M5NTh1c0dIM0pt?=
 =?utf-8?B?VldNUlFvOWZYN2kwLzBoZGxDY0swYTMwdjJLbEgzNlhUUlRNMjJQUGttWTNq?=
 =?utf-8?B?b1ZWeHlvWGJ6aittMmtvZlAzQXNQTkRJbFB6VEUrSW1WUWRRQ3NrL0VPYkR1?=
 =?utf-8?B?ejg3bDR3TjduaGpUQzVoTm9ETHdtdDArVjk1a0NTRkQzYU5BS3h4UUlRRFFI?=
 =?utf-8?B?anNkV1dmd3dnNTR4Ky9KdDdSdVBXc0xGaFpBU3I4ZlNJbmx2T0ZCZ0VKbVR6?=
 =?utf-8?B?QUJKUHI1YUJMYlM5eTk2eWVUSVVSSUFTWkJXWnVCSEFLd1dxd0F3QzNySFlw?=
 =?utf-8?B?THVPQjFLc0w5b3M1VXlxd29wY2tEYjJaRUg5WjVnNStSbFUvbmd0elM0cjRj?=
 =?utf-8?Q?t7o0bDk2tD1J2FijYoR59VJaM62uKyaY?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b25a6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e964193b-f75b-4fdb-2520-08dedb3936a2
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:33:11.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3485
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

> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
> TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
> management for high TMDS clock ratio and scrambling.
> 
> Since SCDC state is lost on sink disconnects, the bridge driver needs to
> trigger a CRTC reset during connector detection.  To support this, the
> series introduces the connector and bridge scrambling infrastructure
> (patches 1-8), wires it up through the bridge connector layer with an
> atomic-aware detect_ctx hook (patches 9-11), then implements the SCDC
> scrambling feature in the DW HDMI QP bridge driver (patches 12-15).
> 
> Patches 16-18 are minor cleanups in the Rockchip platform driver.
> Patches 19-23 improve HPD handling by deferring IRQ registration until
> the connector is fully initialized, adding .enable_hpd()/.disable_hpd()
> PHY ops, and restricting HPD events to the affected connector.
> 
> Patches 24-25 convert vc4 HDMI to the common SCDC scrambling helpers as
> a proof of reuse, replacing the driver-local scrambling implementation.
> 
> Patches 26-30 add KUnit tests: connector scrambler validation, a new
> 4K@60Hz 600MHz EDID, hdmi_state_helper scrambling tests, and EDID
> conformity fixes for some of the existing test blobs.
> 
> This has been tested on the following boards:
> 
> * Radxa ROCK 5B (RK3588)
> * Radxa ROCK 4D (RK3576)
> * Raspberry Pi 5 Model B Rev 1.1 (BCM2712 D0)
> 
> Note that commit d87773de9efe1 ("clocksource/drivers/arm_arch_timer:
> Default to EL2 virtual timer when running VHE"), introduced in v7.2-rc1,
> causes Raspberry Pi 5 to hang during boot.  Reverting the commit
> restores normal boot.  This issue has already been reported in [1];
> alternatively, the workaround proposed in [2] can be applied.
> 
> Regards,
> Cristian
> 
> [1] https://lore.kernel.org/all/ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@samsung.com/
> [2] https://lore.kernel.org/all/20260619204832.586079-1-dan@reactivated.net/
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Tested on an Orangepi 5+ board (rk3588), with a 4k60 tv and a 1440p100 
monitor.

To all applicable patches:

Tested-by: Maud Spierings <maud_spierings@hotmail.com>

Kind regards,
Maud
