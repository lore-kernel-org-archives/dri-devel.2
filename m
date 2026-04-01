Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE61E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C638710F424;
	Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HeWytHG1";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1627F10EFF4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuznjFPlq8NbktN1y3fU4lJgRsAtrKV31LNMj0ngpSQxOy9GCay3SFW8T0dh/VlLHBYhj9ShXpZyxj/5vWz2yGAeNkNbods2fr2OmZuy9JBBw3CMIWKBuJbsPd7U2tJ5VZUdDORi/71MAlTLvsAB5esiUSOAM+JVNNnWcsNg4LOVWA80/KO4vRqS830wFWMWuH+Wvg+4RnnDOq84Nf3s9c1MsvnvmVTx494t9F1LjM9fOKIOdTPkqhvoTHWJlz0fjBaY5ryS6OTHbKZa0g89/viBznWS0YRz4xsnRnwibiFnOVdM5aRHXrGxUnGRtQgO1s4PUE7ka4Om3vLhvfKegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awCqBOF5GsbAqasZJdiecFhkmotk8E2OwpDkaSuIvk0=;
 b=t+VbTMLk/O7jPkzDpjAQ/wE0a7SvHt9u/gGPX2xNjXPcfDl6E/jeWHzrz3h4pQz6jZqVnw+By2hA/lOBloqKtyQLYQ0w3X5RO4/UwTBmTIrtAxrm/d17AO6fTFX36zhZMQ4ps38bJpI38ujw95vNovwuMUMHY9RwOOgchIxxB9D+PfLgQXojZ8CB+eWIMQ0DB+Ur8jG9DK2hr8H1U292dJUF/YHwki7OB2llMy8iQgfO13M3yaPxPXNFqg5n7y7AYyZJ55baxbE5NHma0Kn6+3fEu40Ubps+sP+1VzgwyazekTdnUMaK5piLqv1NpucqPZHxQMHpyJJFa7hzOBE8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awCqBOF5GsbAqasZJdiecFhkmotk8E2OwpDkaSuIvk0=;
 b=HeWytHG1M2aOU5DBYHcy7xZcu4yuZ7yhT7FBe8GsmZ/VA51ri/vmNa4zPqsyX+7EFXpgmf0z9mRyqOkretMhYKV0sJC/5qz64Bwkk3xRKdb4vZRX3E5e48OzuB3eAYu0TQ7XRNT5fNPV37rpl6R+c6t5xU3PJpM9cVtBpky8T+zvG1+qZFG0GBfkVNGB99rsm03jqGLSEaKCgK0cYgNeJqqdS1Q3tNZv+Xa9h3W0cgw+hzYC9IihXLvjfz4CwNr3VRDmYIh4b5Wx4/syGBzsNRWk8Nkir4ngbD8sTXtSLIuo45EsKk8WT2uAyxtgpQgWeh9xJF8rSpco+CMuOHJj1g==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by DU4PR04MB11962.eurprd04.prod.outlook.com (2603:10a6:10:617::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:11:13 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 09:11:12 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwbd8KHaYJQuy102Hh0xMmBlXdQ==
Date: Wed, 1 Apr 2026 09:11:12 +0000
Message-ID: <AM0PR04MB4707CFEB0D2BEB83174E205AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com>
 <20260401-weightless-mule-of-opportunity-57f45e@quoll>
In-Reply-To: <20260401-weightless-mule-of-opportunity-57f45e@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|DU4PR04MB11962:EE_
x-ms-office365-filtering-correlation-id: 87f8bbad-e2e6-4650-e29d-08de8fce9f28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: RbRWrOu2/zgfW9h50AP/yrHY73zLlNIOpPNnHY63gjlrdhTXH6NilpjgVqY2H4qbP+WqmU8WgDgKWNwn4I4FpqiwQm5yiJ4+KgjjoCVL4o68u/BFJWdlaBtogzEIBugWaKOfQh89YFZhRccKWqNRDkGbz6TmyKqdGApjh3qVaHhyXRB5yaYYl+/k3hCc1Hv0VqVqYzj6vhcWuYO42EJAzYEx1OyIfe2N0E+EZDjqeuG+kczKu0BEPNjjrZcXnP4DCowtNA3EjrfmBUlqVYY4fX1fvVnT5cbit1Jfswj3JBYKpCBf9J+txZZs9/cWjiRrtEoMj2P4s1rxc15Otzf0Qf9MIt5q6Zn1/P5hFqh/xrxK+QIUU3GGvXcnPI7VfUgglqYWzIGtvPX/hLalGSnWbZIQdaS0IhsgZRiQwQlPWkd+qGAuVI041VpaivvBf2seZF5ZOa2I4tsu+G0YfVjX7x9adZvrCDVPPSklaaRqPpiJMh33l0Aobk1LutK5zjdjl3Wvt4grNOXEJpQEg56IAqu8NgirmGUUzDJGLUwnzQxjEXBceN3FiV6+rWYVoxg0n9b5VdDAsMDNmDsTThYFprpsi+pftJ32r66oi49dx9Y6i7i75U/jXqow4e1YEiRUwBuCVfKt/htn7O5tTwbIo9/KrOGQ9SK4yVJAyGf8I8uuZ5ggbE1iRTqnfdM4uBp5KIKmJeF+hlcC0FSVP/L7vOkYIYCTrFRSliljN4oAc5HfMhLFq7wqKxZCWrLjDxQIhNQm2PbNvXy8Wn4DjIjOknMfwrybBkqc2Iw/WGkvqQk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piGp+lEQBaK/Zd87ASCZNtojupfQYVtzUnSdCjs9vDrt+ms0VSymAkCfGxOC?=
 =?us-ascii?Q?wYNziYd+1K5zoF8cE6spwVsxblan+FTAPQTk+HHuloNpflgJM+ROqeqaT5Xl?=
 =?us-ascii?Q?1UylTO2lZfwvXsv7WhTZMsM1odcspmwsc9PDLRpcn1bz9UTsupD8unu5t3lE?=
 =?us-ascii?Q?f3c4n+EgpJtYRbqKYvWg5YPG99zo8tKSgbR9dT21wQE9hslDVNuxZHG8msNk?=
 =?us-ascii?Q?Fqlnnk9JFs403Ol7QPa2sdy86Z65gpufzKPOzlXfIafH891rz43paMzvvwCP?=
 =?us-ascii?Q?5RegeDzA7ZNLqnjzzsc0EkXfZoGVresXLg0BKINNpSZGRXfElHJ+pxv6l1aq?=
 =?us-ascii?Q?pXiEmu/mvmRI/gGn3oSXhzx/f1U++eU/x4mQBuImHsnlWS2nXMhDE/zM6XJu?=
 =?us-ascii?Q?/NlCRYVD5RompeS1H56eDy5+w2GZkF0VeQB6BQj3at4O1TwRcj/lmkyEexhF?=
 =?us-ascii?Q?ol4EtS2c6exmT9WIymkMkVV6wOPC2T8/SAOZY8nHa3uzwY30m2D65yGVxZNl?=
 =?us-ascii?Q?BOutYEKyMVSk3rjj43neIyXKmrJGJQnAPf6BI3IGO67isIGwc+CgrmHlv/aH?=
 =?us-ascii?Q?/LwfxPGPId5f2xtNj5N6jcsm2JaZnim/oMLeonzrkXQ3BmEr5OK2wC4mFbO1?=
 =?us-ascii?Q?lz7XcCTJsYwD+/gpCfbbk8mrf342B5aFGXhfv4+NkX50e4lsRG8TwbSnR6op?=
 =?us-ascii?Q?RPwxQuQnt0+sLahqyHlSUi5hGO1pdCmE8dVCSnhKk6UQpIyrfDOJ6vngmNdO?=
 =?us-ascii?Q?7bAV+2lUL+Hfx/wbC+pG2UYGaIwZpaJE5cerkTqk05XT593ZPdYGbiEIgApo?=
 =?us-ascii?Q?lOqPtIBsX/Ga4ZhO8NbW5i2v3gfrlAldtKg5EqooPemYi3rHMt9ne/ju1IA+?=
 =?us-ascii?Q?caAqc6LS7fYxXZW3X00IUVjk5xn1LGLR1Cr+nBBw05RekZHWKP3UPeFd7kmC?=
 =?us-ascii?Q?39hWeKMQJu/TMXt2nzY3MvkmLhAsnKtN6RRFNsYPR2pfo0ocCgBdIsQoAFvS?=
 =?us-ascii?Q?WGVuk4+xCP5H5V5og17aUWeLVs/qjJflWOjYWeClbTXbW3J1klY4n9xmTJ1J?=
 =?us-ascii?Q?7c9UO7Utk7pH3QlEsUIuunlCr0irSQiuYvycK7t/q8cYbduI0dN9W0aAu8ZH?=
 =?us-ascii?Q?3z/vwTmw657C9TksHYhxzxkNtNxz0OwodPNOIV6TnoNVoUHb58oc7f1JuGap?=
 =?us-ascii?Q?05sW4X/LwmKSJGjig+HNahmH9UxQHX42wvx89QftS93LrrkP33/Ob6BziD+a?=
 =?us-ascii?Q?MNM5ILJxHxvjOcMxGKkni9wIbmCadrQqAY42FzjZcSQxKmTL+99KMh8Ua0ts?=
 =?us-ascii?Q?qMj7SqBzHXlmrqMi6ktd0okeI0QZxfL1PPxlbh3BCjKTDdkicq7JO44j3JtL?=
 =?us-ascii?Q?1Cblvlooy2KvDmA3l5Dnc+2XzdPozwoti+Coc7Q2hvZ/F5KSdpCC+S0POFe3?=
 =?us-ascii?Q?Q2aC3EdbmsVa0c3hYqtmklaw51uzUlVnaPk29tMtd42Pz6zIRn9CnuYe3lqw?=
 =?us-ascii?Q?jMTbpuWDwjGwOBbh2zf0aAkH+l0L7b3flUytOvlxdWazS2pWy45f5NAELWfa?=
 =?us-ascii?Q?ktpTa++TMr9v3A9QJYfcFlV59beCSqA4V5zPRfiudKSAROV86zKBZp+j8OdV?=
 =?us-ascii?Q?12ujZlE0QiCnFQL5S23oh5eneIP4K8We2z5eApvIf2Jq8R9LCcXOwwQ/UJVI?=
 =?us-ascii?Q?oBYT4Q6UZ28/1ZR7dRAVTaaB/oSfYXsnXkMsrgOgjiyjXwQP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f8bbad-e2e6-4650-e29d-08de8fce9f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:11:12.9275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXRf3dDeipqII1+hUr1d6TMFrgGC2TxB2xEl6SdKZ17CF/mGLLGoG1T+s58n7G6Uj9k8XOw31BI72BZ2NEUvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11962
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Hi Krzysztof

This is my first upstream contribution. I will improve the patch in v2.

> On Tue, Mar 31, 2026 at 06:12:38PM +0800, Guangliu Ding wrote:
> > Add compatible string of Mali G310 GPU on i.MX952 board.
>=20
> We see this from the diff. Say something useful.

I will improve the description in v2.

>=20
> >
> > Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
> > Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>
>=20
> And the review should tell you that. Did that review even happen? That's =
a v1
> and a single liner patch, so how basics could be missed?

Yes, it's v1. I will remove the Reviewed-by tag in v2.

>=20
> Best regards,
> Krzysztof

