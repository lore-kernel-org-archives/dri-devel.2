Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63FACA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F6410E5E8;
	Mon,  5 Oct 2026 13:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ZV0CgIs1";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="aYn0UHNl";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A20A10E5E8;
 Mon,  5 Oct 2026 13:32:24 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CHJGA660643; Mon, 5 Oct 2026 14:32:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=0OjjhEVyY6/QImLr0xwSdhfQvZ09vcC3ovRJUHvgkJs=; b=ZV0
 CgIs1K6QQoiRdIhtDOEELA0kaGT8IUBiax+vDul9I4oBP8MmiRHBFGn/ws9lmu+P
 vSw1P7mPar8ucPvxadfK6UbLJvNDYMvlqFb8yrJ8LXviJv7pppjpn+rmv0Flg/jo
 zE9KPudV8od3HYVZApxp+ZzIfS6Y2Om2f1Xbg0YT3gEcx6s/Ufc2oy9jgwyFsXa8
 fkYC8fg5c/+aVLRaxLC+L7wb6vIQhdVNSLZxTes0F7rQ3jnTV3BXql7HaqHHmXKy
 HXEE0n5lKrsSfqSYD44DRWfXqnI7wcqIgbcGcwufpBe780JkqMDReHzS/VyaKOkH
 Mr/XSwj67NT3/gk+W0Q==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h3fnt0v7p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:32:07 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foF9rPmJ5hgj85NAKPz2DZ7fQPHXivUckYUJFoUyHhX+PPFt8JTNjmWRyTLHQJipuLu0q4j0KgOey8AV4yct9fBmpcegqIzHZ7Q91NZEh0jcywB8K66zQNTNCV4LiqZPaaR3Mod8f04IO6onbEnF9pWsSr08X97gsuXFLCyYZQ9puV4oMGQYCx9sDzGy2SDi2L0rjG6gFBWBIbwyL2Fzs3Adqb+UiYRJ6eU+KrZ4AwDSYGIXqv6Kzs4P0xRRGkFEl/oDbDXXzw61SfdEW0C5BoL2ml4fgcGOPIsl2uxsrKSElwZqqIUQyYGpIwg6VEhDxdckdgCCrQjstb4HQTiQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OjjhEVyY6/QImLr0xwSdhfQvZ09vcC3ovRJUHvgkJs=;
 b=rIe8y0+Av1eTVFHli0D1FVI9W9Q1nxGYpqizgafIc2PSWyubf2u/no+pc7TeycIkjYA/j8L/vXSjCv/k79mL02FYZktKDSDW3NChVwqKNRiJYOlxmB6YzUCkFg8fK+Sb25OxVKHg4xg7cAJO+KR1wBId8sMabqg9Yf8yNVBAFWtyS/GkTYC0lBbVGylWyPe2EZMkyYFjlCZSEphZHnmf0TdlqsU4NXWSSJpCkQOldbdTPRmYkgIdeq58fOUEQTMJZxdj0a4iAminaCOx/CbYU2K0+HPINcdawUEh8wSgPgus6pWQS1xZkSgFGN+L/f5z/7F8SJIip9P+EnO24ViYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OjjhEVyY6/QImLr0xwSdhfQvZ09vcC3ovRJUHvgkJs=;
 b=aYn0UHNlUPvU0Ru3tSQSiOAWt6KbaNFy+c8ZGOlemZ+EozNUBMOzi3nECf0GNVFEwNH4rheY0lbzhZEFJnzmg862OK/ESdQlXHsZGSqxPfeuF0B/YZljvlt9gD3Uz9bJIBeWDJMndkJBqeI/jUQilkgBfglyNZznUS86WSm2SZM=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LOYP265MB1965.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:113::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:32:04 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:32:04 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: "gye976@gmail.com" <gye976@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdVM3owfQLfTYaF0SmlBPA8QbSWA==
Date: Mon, 5 Oct 2026 13:32:04 +0000
Message-ID: <ea83a6faed24d574cee796deab9b9d1467bb4da6.camel@imgtec.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
 <0e62e6395ca0ea1c0cb6d5f973eef05a57df2136.camel@imgtec.com>
 <CAKbEznvLy3dio5FigiVzcAggES0e1fjd_xFUzq_SZ4+zv0Rw5w@mail.gmail.com>
In-Reply-To: <CAKbEznvLy3dio5FigiVzcAggES0e1fjd_xFUzq_SZ4+zv0Rw5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LOYP265MB1965:EE_
x-ms-office365-filtering-correlation-id: d0161ef9-15fe-4d72-dc75-08df22e50b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|366016|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: E6wskIAor62/Sp8mBbH8lskfPPHgt6vlx4jG2gvNPtom5l+Dg4HTi8NTtX4WGGy6HHYlNidhhhx4ZJxqmxzv4e8jG1XY2cNOXGmKYO91Tbjphems1JCKusItyaPMr39rpINaQ7PHN+QdsLLArBBdSXlmKvjJFEsV1oAENwcQ6dubB1DLAMq6drf2FQdyPeXLiaH+p1/HYrflRRzzLVAlKiKN1VkAREYbN4MmgazRps1URIL6X2b1jVUaEhWNOzNThGHGguZG5DD7hn/soEwogttroLHUvImnB9dNKwJSUVhgm7xbyIBJhyyeUd1V5AeSLkAOOEGMYZZApaE7tcBw7tI4a5bnd/91gfqInFBttS+vaSmEY563Oqa938R2Hz8OerslLBeQYx0BT+uQ0g9bIG5H4v+nga73YzP5LzISNT9q4R4IdN+d8X81tEZgiydmrl0tbcS4dDp7O8q+m44rPmQOAKWtHuEH49cnaUXcBLK7cAooa2TdH0rwDdC2gUnI4E59oyx/Tu51NsMZ97I2gSZbDCNjR8+scSXol1p79KDKF5Z7n3jHCO8HGdpnIiL3Fv0GZtVNl8hhk0PF0zKDjK5X+U+c5iyiGfRAGx7DdycU/1f1AoI9JmjEeQXlFTMI/iNSuzrovRQTO422GEgx0rYb4JujojmTRwpZt/08QCdLXJoDvxdejQ1cjU2dsUd3K/DnRECmfDUuOn6/uz4JTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUc1ZlhsWldIcWRHSGRnY3l6WTFLVDFlODlyNE5qNUUvSnZtUzdQaHh1OUht?=
 =?utf-8?B?YzlReG1tMGFyaGxVME9oU05iQjdZUENNbWRLRENxRytpZVBtWlBGNTdoVXV2?=
 =?utf-8?B?RnErSzEwcHRWNSs0S3VsRFJGbkhsUkNKOUF3L0xwaFRnaU9qcDMrRVowQXEx?=
 =?utf-8?B?c1QzMXM1MkVtb05VdjVyUTlRY3pya3EyRTFjYzJTdTZkd25GU2ROWTNMRFdE?=
 =?utf-8?B?cEZldkdJWUNGZ2E2WFMrV24zdGJJbkxwODF6NlhKUmVmdHdPQ1A4Vkd2d2tt?=
 =?utf-8?B?bTBOQ2ZVUWxlaUlhNzVUQ1NQQjVudXFobFd5V2FUMHQrTTdTbmIvK1VyNis4?=
 =?utf-8?B?ZmFmSVR2R1MyVlR4b3RpNnRoanZySFA4eS9vMkxwOU0wRElrd0xZU29CNG1z?=
 =?utf-8?B?V3hxdHpGbWpSOCszZk1yQU12TWR3RU8yZzZWejBtSUprRFhtUFJMWTN0Rlkr?=
 =?utf-8?B?TGx6aXVJT1RZK0NwUTZITnRTU1BWMkZSa0s5N3ZRYzFhVmZmVEpQNzZEOUJq?=
 =?utf-8?B?bkVDVzN2a1pVYnZhQjdIWGcvVlNWdkFpVWdJZ1JyZmJwNFhqNnJOUjhEUmtq?=
 =?utf-8?B?Q3RSeUJiTExWYlJvL2V6RTV2b3F0YkdrUnpuemg2aExZL0FacnY4VHFQTkk1?=
 =?utf-8?B?dXlUQmExV3QxNkRDa0h0bCtWR3VCalV3YUN3VUpya2wxOFlBS3QvZEU0ZURQ?=
 =?utf-8?B?SHJ0K3BsZGdiS29WdUNpT093SldSN0dZZit4YXNFajl4UU14M3E1T1BRaVdy?=
 =?utf-8?B?QUc5eW16eDkrcW83emRKNUV2S1BYbGNDQW5pTFlXeVYxYTlCWUpmQTZZZTB3?=
 =?utf-8?B?eVlma0dqa0V4ZzJpUi9VTjJZaGRkZXd4Zm1RM0N4Z1k1UFR1clFFYUxJQjhN?=
 =?utf-8?B?V2VaODUyUVFUK2VxMU03ZURVa2dOWStYT0FFcjN4Vmd1TWs1eWl0RlBBSGFF?=
 =?utf-8?B?Y1ZuWnE5Ri9FOVJnS0FyRXVtWU1PaFNLb2lHVEU3MzY1eXZ2WkdWR1RqVDhq?=
 =?utf-8?B?UWxKUm9aYmkrUGlrMGp5RTdXQlp6WXVMQ016MVJOK09qbFJ1UWt4bkNkaXlj?=
 =?utf-8?B?bWtReHNkbklvTDV3N1JKSWtyV01ma1gyOFEzMEtBTHNKaEZnVjlrN1JiN3hO?=
 =?utf-8?B?LzRrUjdGMGdxb2lpQXd2RTU5Mk11QmU0emZJMmFiaEVCYTVwQVNjSzdXRUU3?=
 =?utf-8?B?bEI3aCtZdm9MRzI4Y2RyOFZjWVRVZ29iTzZBTTdiZ0g3UXhxSUNFZmhyaERa?=
 =?utf-8?B?Y2NFZk5MWTM2YUlTUU5raldMRm5DR2hLUFpjRjZsczFaV29NVzF5RFJ0UWxX?=
 =?utf-8?B?TDVmRE9GbWFLbm5iN3M3MzByOVpqbHpJWFBKcVdCSXVjMUVzeVVNcjhqcDJV?=
 =?utf-8?B?eXlLdGVPc3BtaWVqbUZTczBnTldXT2N0YlduR2hhenZOZUVrWkRXM2FBbXpB?=
 =?utf-8?B?elZKV3FJandwZ3cxQVNvbzllVmVaMFN5MXM2VURLYTNQaTZJa2tUWWlnejgz?=
 =?utf-8?B?aUwxQ0c2SURnVDE5bjJQa1RuVkwvWjY5TnFBVlhhMzZLVlFrSVhQZHdFWXNk?=
 =?utf-8?B?MW83ekxkYmF3YmhvMzhZcGlkQzRzS1dZMnkvbldCc2lWdFlrbnZXaHh2bnFD?=
 =?utf-8?B?Q0luTFNJTHBhcklpSUxKQ1l4K2VrVnBXSE9OcG9UTGNSMjQ5ZGVTc1FqSzZr?=
 =?utf-8?B?NkdOU0U3VVpGdUFxUVVVVG5na2FPUUpsRk5Fb2dlZWFxQS9ZOW9Edi8ydzBH?=
 =?utf-8?B?VC9ENzl1WnJBODRKbHRvSjB2Mjk4em15QlcrUjhNYkNUdXpVQ0RKd25oVVJ2?=
 =?utf-8?B?OG05ME9jZjMvYUVtZzl0N1FIMkJ5Z2lZb1dsdDVjU0dPQkFTa0dkUWF0Y3Z2?=
 =?utf-8?B?TWhieC9OWnl2Ykc0ZGV0aVJqaXE0anZrdXVVV2U5a2luVnc5RmpYcld6Szk0?=
 =?utf-8?B?dnJRZmVpejVHdHczSi9mMjhNUjZMdm1KVWV0ZWpIL3REeFg4WUV0alRCZmpz?=
 =?utf-8?B?RDA4YU5TNXlreW1GZE9aaDNXNHkrNW0yR3czRHFYQmdaeVdBNUM1UjZFa3hu?=
 =?utf-8?B?QWlQcFcwYzh6OFdqa2h2TmRpZUtESUJqNEpUUlJwZTZZK0RZYTM3RURkc1VE?=
 =?utf-8?B?cllMcm1uSlpacnR2UDB5c2ZtM3AweHhKN1hYU3VKUUUxdW5MMXdDYml5UExu?=
 =?utf-8?B?VlVSVTdKSkhyellHRWdqT2MzOWxlRVp3SWNDQjBKRG1qOFFlSjlGODVRdFJv?=
 =?utf-8?B?MTI2Q2MwNzQyVzhlcXlENlg4TlQ5VmhRaTk3Sm9pbnRzaWc5Tzd1bi9wZHpP?=
 =?utf-8?B?ZSsxc2l4WEpkZ0JkOTRtbVExZFJzTVZKM0xOYVpLOG9NYU1CTXRNbjl6bjFT?=
 =?utf-8?Q?uB7YfAc7xczsumhtHI6b4wASZL4nKdM3o8Vi0BP0C6YqI?=
x-ms-exchange-antispam-messagedata-1: p3ODOydtUIeAyW0lEDyBJIwWXmQ0DPm7F/8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <886EF35AAA8F2847BB705E504EF6C3A4@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tmqkcN3fZyzAFO/B4u23fqEgQlB6YJvCGFtT5C99dGWB9+oKGkdNatjdMSR3lXlLK1JykOIQP2kRkLQWpTgp3aOEp6bTGcP7apRLZQP2dXMN7CSlCP3VnC/oZMrwxp/cOLIC5lR3ZNqOFod6fj5IDMfjEffRwpCc9JOsGwSRipJY41CEkl9JXKJKB+uiOICVHq/T5EqHtf+1wZJzFZN4Eux8bkX77CfoLmecAoshssCt4NLSQgXh5VhRdVJYWBLBZDaF6oN+G2OnNS6GtIcM+veJ6AKDyVjMAd1wiumVsXwJYdKOwTsMu8+KDy0Fmc914XtCfyF1iHkpDBfsxmnDAg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d0161ef9-15fe-4d72-dc75-08df22e50b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 13:32:04.3358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5fg2cEnFYPF5UpAWP8No+RiU7DZAubIj/0zf91xv2lGvl5DGzOGSvSJLJmtnyOLSY3n7xJ3BjsW0oYaNlrZ5q+MnK4p8X6l4z4uEjrVlbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1965
X-Proofpoint-GUID: j5kVlRarqMHtB5vb0MwnUNF-axZEghIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX0Xe4VCCdeMh5
 C4pm79YZPtZ5EbfMoO48FWLMyEEH+zAKjLyp/KOkeeeKnb2dPhyIYmp9Hy75PM9JzklY5bW3e+t
 jsRWqH9ZlEuVqu2lC4k9iaordggmTUzCz0Gpv4ya7VTfzsFVxZhFY4gdRaevI5bHMawyiNXK1Tw
 QCs+Uqj3+f1ISoybMTwXEcdStOFhVqIcsJyMcIuVL/zRRR4gHsTJO8nRnrELf3mU9Ulvk4p5fsw
 kqlrPtN36xBrbVjlYfklo8HYWEuxATgfu8f7aLKuV7cHZxIXr2mOp3CQbCoPVkRkv2bJumnciN3
 4LJwWNGe2VHBxdSFxOWrhf/BQK8CRzDb6mAmh4aplFpMiF0OV/d55EBkMnSIZoQhGu4JEuAJto1
 IhtQMPr4rFXUy/KrgRcR3kMjfplM1ii7wm/KNy/WPIZY+lyYNr9gIo6A/KnVGiuanhjlzyhi3dB
 QVOWlElT8YoPbPH1UUw==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6ac3a6d7 cx=c_pps
 a=zy4dD9/zh7NSanIoVQ+o4g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=RFjs_ILRvdKaBOsUAbgA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: j5kVlRarqMHtB5vb0MwnUNF-axZEghIg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX3HkabOPmm5rp
 vchzYH7rAnCHEP8qEqANdwZWObyvYkvPnnlTswZR2rwPw2lfHEVR+JrHYCE9kJjqwEDMVnTx6Qm
 Y6WftaKeS6aMnt21CYWOzAUCEC9Ivww=
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDEwOjA4ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
SGkgR3lleW91bmcsDQo+IEhpIEJyYWplc2gsDQo+IA0KPiA+ID4gLSAgICAgICAgICAgICBjb25z
dCB1MzIgbDFfc3RhcnRfaWR4ID0gcHZyX3BhZ2VfdGFibGVfbDJfaWR4KHN0YXJ0X2FkZHIpOw0K
PiA+ID4gLSAgICAgICAgICAgICBjb25zdCB1MzIgbDFfZW5kX2lkeCA9IHB2cl9wYWdlX3RhYmxl
X2wyX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7DQo+ID4gPiAtICAgICAgICAgICAgIGNvbnN0IHUz
MiBsMV9jb3VudCA9IGwxX2VuZF9pZHggLSBsMV9zdGFydF9pZHggKyAxOw0KPiA+ID4gLSAgICAg
ICAgICAgICBjb25zdCB1MzIgbDBfc3RhcnRfaWR4ID0gcHZyX3BhZ2VfdGFibGVfbDFfaWR4KHN0
YXJ0X2FkZHIpOw0KPiA+ID4gLSAgICAgICAgICAgICBjb25zdCB1MzIgbDBfZW5kX2lkeCA9IHB2
cl9wYWdlX3RhYmxlX2wxX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7DQo+ID4gPiAtICAgICAgICAg
ICAgIGNvbnN0IHUzMiBsMF9jb3VudCA9IGwwX2VuZF9pZHggLSBsMF9zdGFydF9pZHggKyAxOw0K
PiA+ID4gKyAgICAgICAgICAgICBjb25zdCB1NjQgbGFzdF9hZGRyID0gZGV2aWNlX2FkZHIgKyBz
aXplIC0gMTsNCj4gPiA+ICsgICAgICAgICAgICAgY29uc3QgdTY0IGwxX2NvdW50ID0NCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAobGFzdF9hZGRyID4+IFJPR1VFX01NVUNUUkxfVkFERFJf
UENfSU5ERVhfU0hJRlQpIC0NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAoZGV2aWNlX2Fk
ZHIgPj4gUk9HVUVfTU1VQ1RSTF9WQUREUl9QQ19JTkRFWF9TSElGVCkgKyAxOw0KPiA+ID4gKyAg
ICAgICAgICAgICBjb25zdCB1NjQgbDBfY291bnQgPQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIChsYXN0X2FkZHIgPj4gUk9HVUVfTU1VQ1RSTF9WQUREUl9QRF9JTkRFWF9TSElGVCkgLQ0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIChkZXZpY2VfYWRkciA+PiBST0dVRV9NTVVDVFJM
X1ZBRERSX1BEX0lOREVYX1NISUZUKSArIDE7DQo+ID4gU2hvdWxkbid0IHdlIHVzZSAnZGV2aWNl
X2FkZHIgKyBzZ3Rfb2Zmc2V0JyBpbnN0ZWFkIG9mIGp1c3QgJ2RldmljZV9hZGRyJyBhcw0KPiA+
IHN0YXJ0IGFkZHJlc3MgZm9yIGwwL2wxIGNvdW50IGNhbGN1bGF0aW9uPyBPbmx5IGFjY291bnQg
Zm9yIHJlcXVlc3RlZCBtYXBwaW5nDQo+ID4gaW5zdGVhZCBvZiB3aG9sZSBtZW1vcnkuDQo+ID4g
DQo+IA0KPiBUaGlzIGFscmVhZHkgY291bnRzIG9ubHkgdGhlIHJlcXVlc3RlZCBtYXBwaW5nLiBg
ZGV2aWNlX2FkZHJgIGlzIG5vdA0KPiB0aGUgc3RhcnQgb2YgdGhlIEJPIGJ1dCB0aGUgR1BVIGFk
ZHJlc3Mgd2hlcmUgdGhpcyBtYXBwaW5nIHN0YXJ0cywgYW5kDQo+IFtkZXZpY2VfYWRkciwgZGV2
aWNlX2FkZHIgKyBzaXplKSBpcyBleGFjdGx5IHRoZSByYW5nZSBwdnJfbW11X21hcCgpDQo+IGZp
bGxzLg0KPiANCj4gQWRkaW5nIHNndF9vZmZzZXQgZG9lcyBub3QgbmFycm93IHRoZSByYW5nZTsg
aXQgc2hpZnRzIGl0IGJ5DQo+IHNndF9vZmZzZXQsIHdoaWNoIGlzIGFuIG9mZnNldCBpbnRvIHRo
ZSBCTywgbm90IGEgR1BVIGFkZHJlc3MuIFRoaXMNCj4gY2FuIGxlYXZlIHRvbyBmZXcgcHJlYWxs
b2NhdGVkIHRhYmxlcywgYW5kIFZNX01BUCB0aGVuIGZhaWxzIHdpdGgNCj4gLUVOT01FTS4NCj4g
DQpNYWtlIHNlbnNlLg0KDQpSZXZpZXdlZC1ieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0
YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQo=
