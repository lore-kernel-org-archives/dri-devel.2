Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D8C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C1010E72B;
	Wed, 16 Sep 2026 07:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jolla.com header.i=@jolla.com header.b="xVhy/Pu+";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023115.outbound.protection.outlook.com
 [40.107.162.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C410EB0D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 18:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POFSOLmJZfwzr+Fy6VzZiGGgrY4q3PJQetk7xa7mKEglW142rNQlHrEBcejkD2H9q6XCd213g0TZcYmBiUvmbRZBdhDvLttrsB+Ee4timsev00WSp1DG47QKsxMhhHi7Xzk/evr2DGRi3LbMWinyDZkxV+U34Z43ZusXv+rKac/rYcqDoR8Jig+fdMB1HXCLJVIOO0DsCWWmExvX+ZFUDKbEdaUuWTrxMti9WfN1z9LK4g8Ggbf1SlM9lRKNvLdiJ8fU0gdvWcsrTdwIay4DFNlnIAjk5W8pht/D8ChKAorglPIdPuzPUR68OyF4udkMaIlO//He3NwPqnmqVxJ7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy4e+TiE3ZBRV7e/zyq8KrJd0p7tRcqE+1ERfNyFZLM=;
 b=mOiAfZ2CEfOrHd2oA3Vmmprg3ScelgUxPisdTG7OTiKnVb6pEnTYEVgRVinko33BcGsWi7WOZuvVeiG2zpQ1byvfi/0T8zLBUGajM5LTd2TtW+s65RYoQgt+OB4/1RkOekYqtrgtbZw8a1emSLTGALPzW2vlF/vp7SlfPd79b8zhBECLsR8jZlpi8jTfyaJIZ/2q1Iq/AiV7jMOyQ7uJy5XGBvcjobzm5tH29m4aMXLVObjthWY8vVGEl4lIZI4E26H6D1xNiKTExPgSpRJxuuZXXcWvE+HVQEqycsGoHcwWNszmQyUpXx4Ne9CdFoZpOo0He18Qg505IUpPvgaFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy4e+TiE3ZBRV7e/zyq8KrJd0p7tRcqE+1ERfNyFZLM=;
 b=xVhy/Pu+2gA8TGBVtez0rAPZOwphG2NsYvcEJWF21n1NIkV7gmC6wQv6jpITao88iG2GYP9NhUW0YqBlM14q81Wy/LC8d8qMiVefJXNzlOK+uTpTTemZOdvloTZKb6M5yFBHsJJhLYhcTGUWOQjxgjrHLp09LCopOWtDphzdjlYmaZbDXaAbvkhK34uXIX75NcVmMiYlLKCoofMBrd750owLP9JdQfFqYCd6oqKSrc9DI+hZYXeNWuK2R02j8lvvPdw8caRAaT5JtiijrTgLlcMAiWT54sYGtWkm89SZF9NNJRFKtvzY3GiWNfMUsVrfrtjnVCi3UTkE3/AlWAs9LA==
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com (2603:10a6:150:24::20)
 by GV2PR06MB10875.eurprd06.prod.outlook.com (2603:10a6:150:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 18:51:10 +0000
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99]) by GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99%4]) with mapi id 15.21.0428.009; Tue, 15 Sep 2026
 18:51:09 +0000
From: Nikolai Burov <nikolai.burov@jolla.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "jitao.shi@mediatek.com" <jitao.shi@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "justin.yeh@mediatek.com" <justin.yeh@mediatek.com>,
 "jason-jh.lin@mediatek.com" <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
Thread-Topic: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
Thread-Index: AQHdRQqeK2Ypb3mcyEKOw4qUZ3ay3rbPp/cDgAAVSQCAADsIUA==
Date: Tue, 15 Sep 2026 18:51:09 +0000
Message-ID: <GV1PR06MB841771AF67A658BF71D4F479E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
 <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
 <14b99e0a-e08a-42af-b982-471cae869149@collabora.com>
In-Reply-To: <14b99e0a-e08a-42af-b982-471cae869149@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR06MB8417:EE_|GV2PR06MB10875:EE_
x-ms-office365-filtering-correlation-id: e1f599fd-e746-4cce-dc0b-08df135a4e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10070799003|22082099003|18002099003|3023799007|38070700021|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: 6o2kqmtbo7Gcnfb4rqtIB9hODVf1hLO1d9rkH3S6w/ms9obNF2b82Ks50M5amwEL2uztGUQPKHDjCx+jwTJxStY/JGOq7ZDpIakMvDrmkgBhZlKrhD8KDA52/h5P3np7yTRhWYMV5opI3G2m1hvjYTZM5TxQlz179dOgeWN87mICLCorW38PNvBkigjvR5XMliEFmZpGWM/ssTdo5FYxafkybascUJp2pgjGVT6IWkDVKHAWqSGh37Qhuqb3Z78p9MDm12YB3VOalGBRiZJPbsKRABMAaImzon2uiyixS50azmrrLHgc/BoutSVQcmKqMJbtODq4DrjlZ0rZ3/npoP9c+1OwWPzasCxCC1jXHcK9NlddFW6l0I0pTiKDTVtU2v+p8RZUnZOFZQvx1sMbNhqsTnuyRTyLR8D7MhCWRZnkK50V87bceo5lJCwPuwuU98FgyQTuSolep8cEn3dMSOaWuK8xR3MEBP8U0LKxfDIKdAVqCFHfnnP2mkuhvqMUFa45o6czpvXfN6r+AlVFv+w1ZFQ7XRVEvQFY79+S5sqNfTgxzr+6DtVxY+D9lC4x3gILroBHNfTI/xAwpX/xYtL0XTD7y7V9mRVMQnWuf1Z71UCCQNEpJLlT5fiMTPZMZgVn4uQYkwATqMYADA8qLEb7UzMWwBWEt/z3+x6sA3CezRf5U6D+Epy+v6kXQm8XL/oSpMgx/IJk+sjuwY7DfAtfKLwBrwb9zP7UWhoVTus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR06MB8417.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10070799003)(22082099003)(18002099003)(3023799007)(38070700021)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6tEZ/Hch3WbRUYuE72+6859/cUTmAr5o6yiuiBlefHT+Mf1TtfPfJCHboJ?=
 =?iso-8859-1?Q?jd3mmvcDG/gAfpnTYdvOvEwchmsOzujGLdtJZ6BdAfmBiRAv9rC42xCk1C?=
 =?iso-8859-1?Q?+FrJHzhokrKJhaGmMgwWI/Ik6ctpR/uxAzKRolaLcz1/CIVFHypgY0bAQN?=
 =?iso-8859-1?Q?IWnMmsahY7oFPVht+uAeo9QL+rbCyGX2gIbJhetM1kLuR/qhq65lAXyjai?=
 =?iso-8859-1?Q?EZDGO5EndNTS94Q5Q/p28aU9NoZYMzcOnIXAZGJURoOtoIulaIPijAcLWG?=
 =?iso-8859-1?Q?esHjcfA7MibMW3T23dIrBfHEDYU0ME6DZASMlxztU8C6rKvLh/DaULN7y1?=
 =?iso-8859-1?Q?7tLogZuoVYNr1SpyfaRTpPULR4ILFQglpO1hnQKow/Yn4aIKSgR29hhBQd?=
 =?iso-8859-1?Q?MC8T3kBi4+kUaXmByNFcDIyG6yCCdPvKc08PxOUpzu73wMK7DpQjnyyNUJ?=
 =?iso-8859-1?Q?GyLHVFvbQ9kwn+OLYUXd2SsHvgDJzn4qiSFVRZQCKhJEzgBzGXV+9I4fn5?=
 =?iso-8859-1?Q?5AtXIT6xn0lH3W41IynfYR303jDXZO4EhmjVbCMPqKet7561stHoNXTHjx?=
 =?iso-8859-1?Q?xcfTNwrjn2iqBQiR98Hg2s9aWX8UmqWo/TJpJa+hgZTF8Nwsmg/Aihx00e?=
 =?iso-8859-1?Q?euTcrFi1cWcTRAkDwW9wCHhlhn/9adc9ArWBF6GignvwnViYWd4a50iAtj?=
 =?iso-8859-1?Q?xPvJ6VZmoYFOYn646zfkS1mo+Hb4UFWHH5Us6Q48Bxg7Bcb+YwL+CxMTTf?=
 =?iso-8859-1?Q?W+fZeU6Z8okj3JqrQikacKbBNpwFChxD0tuGl7IbWq5uHUHPfueliShkXA?=
 =?iso-8859-1?Q?aVWHF3jTr5y6uIEtQGVtbKiXAk3T7MCIwB/npPJGUOvIh/HXxp/4XXyaQh?=
 =?iso-8859-1?Q?0GltAzd/TyJZ884t7d69oM5mEz95AxTE9dnuAynQWtAYMVc2yCW3Hmn5w5?=
 =?iso-8859-1?Q?7LTfPxLovgCd/Hiwds32b6l5pR8yvUcfnoXELSqOLgTvLv9yrgCp3gwW2o?=
 =?iso-8859-1?Q?ebzVo/e2FHE+AtoGW/eGSPh+K88+Y5meV6waUk4SeYvXcnEmP1Z9Ce+SOC?=
 =?iso-8859-1?Q?0tac4+zBbDcfj/PTYKmsA0hvln+tP68IS9qMwFzWFWo7MgmofddvnH2xuz?=
 =?iso-8859-1?Q?bSlolEnJoiiwUOmpYREx673n/iEWMxQGMNsL/6ecSMOSVaU+fpi9RI46Hf?=
 =?iso-8859-1?Q?ZBu5G4tGI80XnnGvS/x04lJdFfHfGezWFlZogU1yiIIm8S9XiEqOZ/arHb?=
 =?iso-8859-1?Q?b0g3WxzHnYZDA/FonDyJGZgkrAvV0WW4JE4WS8eqaR8QN7X4PXnI4R6m1F?=
 =?iso-8859-1?Q?iRclds8QoibZoWQQtoXjqZG0jnM0cuGU5FrUhlkIq3MYlLRcPRbhDUxCOo?=
 =?iso-8859-1?Q?55LYfBGYBePPDtfDuBsfHRhmGUlSXBaYjrhjBMXD8yxr1lsxSmkmUVt+gM?=
 =?iso-8859-1?Q?T5zJ3UdWmuQKF60KOovGMXby7Mt3MTUZBimuFErzZvcxdilT1AEHePSchk?=
 =?iso-8859-1?Q?28xmjDtbrIta2wlTdXzOlTmX3jjXLlntcGAkwSGjV412d3SvIRX6CmcJFN?=
 =?iso-8859-1?Q?6SW5ViKRVvGzKvtiUMfkfNQQIA19QHsLJfZ4bmCWWgNEodRMivTBrc3mGy?=
 =?iso-8859-1?Q?cGznSlhZl9vCAmg6TKT/tLHCoAYCDTluh4u9zXhwEsguL1s7SRxRpNO9rI?=
 =?iso-8859-1?Q?RLMCRg97WtfEF3R+Mmj1BBdUo2yKma4NP+i188RFY1P9dHsN3Bk0sQRUSG?=
 =?iso-8859-1?Q?5bfDgOLMsghZTAHOA5SmLXIKkTzbGwjKmvRHxxYUm3zojCK9nVnGfRKcMu?=
 =?iso-8859-1?Q?TcjVZzgHcFPdFyJ43ShysmQrKARzV8erkQTX5rhFgQkDXf1R8SKjiwRXpO?=
 =?iso-8859-1?Q?FG?=
x-ms-exchange-antispam-messagedata-1: YcZoa4U+vk+JtA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8417.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f599fd-e746-4cce-dc0b-08df135a4e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 18:51:09.5519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJMjOIGqlSgteI1ImBxGvFhM1bjOohzVER57R265LVUX0XyhyIL2ecYoplolDXcGw3ALD+/H+FTkEPuACOpEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10875
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

On 9/15/26 6:05 PM, AngeloGioacchino Del Regno wrote:=0A=
[...]=0A=
>>> +    ret =3D drm_dsc_setup_rc_params(dsc, DRM_DSC_1_1_PRE_SCR);=0A=
>>> +    if (ret) {=0A=
>>> +        dev_err(dev, "Cannot find DSC RC params\n");=0A=
>>> +        return ret;=0A=
>>> +    }=0A=
>>=0A=
>> The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, not=
=0A=
>> DRM_DSC_1_1_PRE_SCR, and the panel on my test device requires that even=
=0A=
>> though it uses DSC v1.1. This may be a panel-specific problem, but have=
=0A=
>> you tested this with any actual panels that need 1_1_PRE_SCR?=0A=
>>=0A=
>=0A=
> My downstream uses 1_1_PRE_SCR... that's why it is like this.=0A=
>=0A=
> I can resolve it like=0A=
>=0A=
>      if (dsc->dsc_version_major =3D=3D 1 && dsc->dsc_version_minor =3D=3D=
 1)=0A=
>          type =3D DRM_DSC_1_1_PRE_SCR;=0A=
>      else=0A=
>          type =3D DRM_DSC_1_2_444;=0A=
>=0A=
>      ret =3D drm_dsc_setup_rc_params(dsc, type);=0A=
>=0A=
> ...that will work, granted that the panel declares the correct DSC versio=
n.=0A=
>=0A=
=0A=
Unfortunately not, because DRM_DSC_1_2_444 is also needed for some v1.1=0A=
panels. From drivers/gpu/drm/drm_dsc_helper.c:=0A=
=0A=
/*=0A=
 * Selected Rate Control Related Parameter Recommended Values from DSC v1.2=
, v1.2a, v1.2b and=0A=
 * DSC_v1.1_E1 specs.=0A=
 *=0A=
 * Cross-checked against C Model releases: DSC_model_20161212 and 20210623=
=0A=
 */=0A=
static const struct rc_parameters_data rc_parameters_1_2_444[] =3D {=0A=
...=0A=
=0A=
I'm pretty sure that my device is not using DSC v1.2.=0A=
=0A=
Since this is definitely panel-specific and there seems to be no good=0A=
way to detect the required parameters at the moment, this is probably=0A=
something to fix later.=0A=
=0A=
[...]=0A=
>> I don't quite understand what is going on here, even in the original=0A=
>> driver before this patch. What is the point of setting VACT_NL twice?=0A=
>> Does mtk_dsi_ps_control() really need to be called in mtk_dsi_poweron()=
=0A=
>> if mtk_dsi_config_vdo_timing() ends up calling it a second time?=0A=
>=0A=
> I didn't do much research, but MT8173 and 8192 if I remember correctly=0A=
> won't work=0A=
> without this sequence. I saw that 2 years ago or something, so I don't=0A=
> remember=0A=
> all that clearly.=0A=
>=0A=
=0A=
Okay, it's fine to keep it as-is then to avoid breaking older SoCs. One=0A=
change I would definitely recommend though is to move=0A=
mtk_dsi_set_dsc_params() to the very beginning of the sequence, maybe=0A=
even into mtk_dsi_host_attach().=0A=
=0A=
Otherwise some parts of the code might end up relying on unpopulated=0A=
parameters by accident, and it's harder to debug if they change in the=0A=
middle of the sequence.=0A=
=0A=
[...]=0A=
> We can always come back to this in the future with a separate patch, and=
=0A=
> we should=0A=
> do just that, otherwise series versions will never come to an end :-)=0A=
>=0A=
=0A=
Agreed. My work is currently also based on the restructured mediatek-drm=0A=
driver, but I will try to send follow-up patches for MT6858 support once=0A=
some of this stuff lands upstream.=0A=
=0A=
Best regards,=0A=
Nikolai=
