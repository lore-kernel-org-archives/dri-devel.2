Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF7AC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2C510E378;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jolla.com header.i=@jolla.com header.b="vEVc0kEu";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023126.outbound.protection.outlook.com [52.101.72.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A3A10E133
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 10:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiJJ9LGTAZkgn47pWNhj0BFLTtEAu2g+qwMoFcWXXPRYGOZOvrJOKogdGknSFWKOVk8ap64jATFweG3n3MuRIPEiBb3thDqGfaqQ1S/ZBrx33tWA+1U5s2aLTtrQJdQQHZWqfo9ObYuKwPhFwYXN+7bakFcjVr3dFqD6uF9YT3bkopf8w41TwwaQLi3Uiv8ZXYKzWKeRY8I/yummhkCe+GWR/kIlPRQtWhwp51VFJeKZOJv2xpDDEGwmRHFeQsNDFz3Bl+QfPcXqU20lYYnWYOTmoI1SPsgv8vAInFfohGBg3t/0cCM8PegGD6ytw8Nx0NOeNDTwhYA5x+UR8VAn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W5joIT9a0o/BO5o8rfJdmdWIKv/e3ulgq2vU7mruEI=;
 b=gyLPOjQHanjuCCFOE4ovtc2HCN5YTHLc6JxB3PD9y8WJ8CNRgiQAaUC5ruiPTJEODg38RrJuhMN0u66wTHZ1mOlYc/8/QkCg8msxInrxuw8EevUOlyJek/aFnxdpOIrsARw2I/A8XVg780E8v0q6IKi+RMB2OZURfD4IOhqZ5jsg5Qx3Q32nstqbNzytc08FVQ41qMg7GC+1bi2IjeLQBsq5H7/ecUDKYQi3Z8hcwky4clzPY3jME1nnDFMuYaxbOAjuq8iygz6WJI6Q3T7KkgM239WIXJGlLP8xyiwxwo1s4klwnZ5vIz8/GaN7OzggozYeZTjVHFrg1LB9KPRMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W5joIT9a0o/BO5o8rfJdmdWIKv/e3ulgq2vU7mruEI=;
 b=vEVc0kEuPWxb+/NmioZgTwGZml9DjwT15niYwnePx90w66k0upzyfA93BjOmhXH/eFkRAeQ/UQAv45NhZkQrh/4qF/9kM6kTnLTU+GgBxEnMi4WwukQr3J9Knw/L2v5+bG30N984v/elu8Cqme2PdjkvpaJ49+o0kERkhvf15KgraeczfMIQuWSFrMK3CF40BbmfQHKjm+VDAr140I2oSoqh5HtPwh/i6VZWvs/AcaqBKqGQEHJhChLgUyUS0G4EH3RH/ctbiCVXMyPqHWEYwRe6Pr0wkLY63HPNsK8pAzHZAGx0S+5yRli8CvpS93BuiOt7dPuARxVDe1+ec17SJA==
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com (2603:10a6:150:24::20)
 by DU0PR06MB8573.eurprd06.prod.outlook.com (2603:10a6:10:358::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Sat, 19 Sep
 2026 10:07:10 +0000
Received: from GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99]) by GV1PR06MB8417.eurprd06.prod.outlook.com
 ([fe80::4cc8:af2b:8580:2a99%4]) with mapi id 15.21.0428.009; Sat, 19 Sep 2026
 10:07:09 +0000
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
Thread-Index: AQHdRQqeK2Ypb3mcyEKOw4qUZ3ay3rbPp/cDgAAVSQCAADsIUIABEfOAgASlZ54=
Date: Sat, 19 Sep 2026 10:07:08 +0000
Message-ID: <GV1PR06MB8417EC0F8704D72979464C68E4862@GV1PR06MB8417.eurprd06.prod.outlook.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
 <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
 <14b99e0a-e08a-42af-b982-471cae869149@collabora.com>
 <GV1PR06MB841771AF67A658BF71D4F479E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
 <1b7438ba-69c3-4c3d-b79b-2879b90fabc1@collabora.com>
In-Reply-To: <1b7438ba-69c3-4c3d-b79b-2879b90fabc1@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR06MB8417:EE_|DU0PR06MB8573:EE_
x-ms-office365-filtering-correlation-id: 982fa652-0224-452b-8f29-08df1635c40d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|3023799007|10067099003|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: wCj4OT0yE2NzBWXHCD3PyNJhnGEqNXrQjwYAsDurw9pFsRovu2MRoxlaHxj5tXxAcPqDZH+eVSeoLCTvfLZ0rKOgApKwYd3CkuORjzN0cWRlTbuZSgfNiAmzW1cFCfEEUgzVLCuwqtnoOlT5BZQ26H22ykQSicOY+sPP3ZzzKiVbMq1dFRQBT8fKOyoPfYZaBu6P2v++lYFx7nJGCBif9xk3QCzsGhwtAriNWDLiURDQVyO2/9GaKg08Yf6Ahb/ZT53VUApWXjBJCA/kXEIyYSUI4XjTVzZDeSjNMs6dPBJIbapqJKyEkBfREGbskBzq/E59ECg0T+1XpzrpACE+Nsfio+LSh+VBrt4L5CSLpM6eL7r3FWgPSatA4kd5jD7iRYlfar5A7JarquMjbF1KeF14lcGDr/9CxOguReOqNXWYrTWN2RRvw2f4PNCQUZdlju/zZBbNuDdjtBFY5kVscn2t89AdG8y4w0bxuDkBq6GsmLfk70xauUlQoQVwjjhkigk3Y5EZJliPQKEyrZKn+S749Gm3ZtezEY0A4FS47ECBkT05RZ7X69shmQu+Hq9BmkASTscrhl/Ve/ozguC3JcxMPHkFD7b0AbKaHHVHtOU19uijKbDlOy3T1DfkIqoy6JkuzNQ2+1dfDfWzP/cxnhMrd/9pjC8awUeuMXFJn8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR06MB8417.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(3023799007)(10067099003)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rzdZRwmlwq9pYp35VO48AlmS51ah2rimcK2pJAD9Cb0Mlzj8Q5ReZOhn4X?=
 =?iso-8859-1?Q?WQqo5FXmqP6uoRvlS6oPv6XoF9WKjAbky6JxsZTfVrDjfZYLJNWHSWSty1?=
 =?iso-8859-1?Q?vmnhwh4IkLRwfg4o0eHulE5ygbT8ABkkzTG3fd/MSrk/lMDNY39vG+q1go?=
 =?iso-8859-1?Q?MtJ1SsqhC6mpy1Q/xHgi32GadPG2RsLq53+4DEbWq8g4mK/TxEgTz/QCCU?=
 =?iso-8859-1?Q?6Ykn4BZ5/BgIksCRScQWhZIrx2COJ6G131o+vTNJoERZ4T6eJe/vMroCaD?=
 =?iso-8859-1?Q?lBHe9WOpBjojHjRcWJPGNUF+LgpNPfzGwoa34bi8tHe6JTlNTxjR2tOmex?=
 =?iso-8859-1?Q?icTQWxZ8FnKYebK/V64bLmu2mt1o6WpaMwKwq9Fj1IIOD3gbWm5laBaf4A?=
 =?iso-8859-1?Q?uSr2rE/Z62yWUL3bDifNDcdiqrJybnkTucGeUZ8wEtqRhB6eomto201EaE?=
 =?iso-8859-1?Q?VcqG1VQeTbujniJDzCVXb9wpqy+Ie+4QJmQFh3XBcYmdLTMz+P0OfhRxPa?=
 =?iso-8859-1?Q?1GMylexVGcwzLdtHslOlly6fVL+gF6VR7PlGbjsjIaHJiC4aTjas0Vbaew?=
 =?iso-8859-1?Q?OImVKsH3kdHiUnh9QmadLihdXeh1zUxpbGwNM3z9cYF23RvkdFwFjPHICb?=
 =?iso-8859-1?Q?BklkP0l5XrPB5JXxttAy6dW5NN85bniovzU03ykHhCBb8t/oQ88GpQ4vHv?=
 =?iso-8859-1?Q?wvWz0Sk6uEoCHrEjC6cbhTgpYJ7qTQ++URTsThpJyGmUHXsWuxkPU/F6qL?=
 =?iso-8859-1?Q?IB0KDKzk3cyDaQlqJCRE0cisHhW6giH4ppC7V27iThAd2Rdxc73lybSnG0?=
 =?iso-8859-1?Q?x28kOPjUBOjKzcTDoEOhzDWdjQXkkIa8UK8Yq+whhTpAOBcLZGCpqDhaeF?=
 =?iso-8859-1?Q?e9u8mrUD50d2gVtYhP/TTwSWcMTOU80nHGmS1JhNtzvd+/uON/mM7Bz9m/?=
 =?iso-8859-1?Q?7nLH1Y+VyHiSc/BW6RM1nx0Cx8tpWg1G0LUW7ItCLoQ4kS+kTU9ZiDZjLv?=
 =?iso-8859-1?Q?Q0TJPE88XS/cM36oUNidoXtPdb428uvVUQFHwVw9BdEC2LCBYbRI8c5Lmw?=
 =?iso-8859-1?Q?lPDttfijiS93er7Yl5og/XLrlBREmnOtMGeYQmIZv8zgGv3TA/EAFZBvoS?=
 =?iso-8859-1?Q?15dg/4PJQNDdD+mYxTUPB5Jw6mREWQ3u1VrgbhlvES3kbKWBIblrZTaBOu?=
 =?iso-8859-1?Q?XT7t5pHX2kTqdCAa+RN/opQoD4I3Pm4bqRQmJJxNiD5MSYdUGfvcLf4SoD?=
 =?iso-8859-1?Q?Pr2nAVoMpY7wNMbv96aWeT30S+KQ1dPsR4iTU8XR+AXSiXehaCgZUN/sy1?=
 =?iso-8859-1?Q?iqRMhGN+dVz/kCh0dN7Jz88MK8Bl0F9yOoOEd7YQi7Z6f/h4hR7RZ7vSv1?=
 =?iso-8859-1?Q?VWlk9VeCiSoCpLT54wB6VmBfRce4smQvrW29jYJAzDGfoQhKC5jHgtoAnY?=
 =?iso-8859-1?Q?427UWcNxT/KLPVg1PDu/BKU8qxs4XJmUc+fSKh04zys2j/lsEonEGqi9oV?=
 =?iso-8859-1?Q?YnpS8NZ+Kf3fTN4lXgvsWI7etTEbgOjGJXPqBm5aXaqrTXIgbhJ/AcddGX?=
 =?iso-8859-1?Q?G27u7FIiYNyHsBoyr2G+Mod6YCCU1mxSGt3mrqL21E5iAStUPqhTX1I1+h?=
 =?iso-8859-1?Q?4Qj/bc746cO37ft+MCXt0v3Or1DtVmM7UDmmFcPdmGraYiUx05QyNIoAxI?=
 =?iso-8859-1?Q?+CPsVifdJo/YNB4+M2+f9ibUMkSGXCz1RXVFfcYaxSvHnz2TjcO8d42qZX?=
 =?iso-8859-1?Q?Nf26DDtt3JCGnZW2k7LS/VCp2m6LrLxuQxoku09QWxQrSco5Ky7o74AIrQ?=
 =?iso-8859-1?Q?Yeyvof6rOMwXJXGwcXwv7s/yJwGsazlDptMyf16LV3fzq1LbG8c5rr9Aon?=
 =?iso-8859-1?Q?lW?=
x-ms-exchange-antispam-messagedata-1: t4Zl4q8KTI5QmQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8417.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982fa652-0224-452b-8f29-08df1635c40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2026 10:07:08.7735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmJ3SA4/cEpL5syhBaBUSDxR+vibfBuZrV3lIFYhKcLd6/Ke0aDvMunlx2MPyblKDT8Ahfq8yWn6VtuE6aD5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR06MB8573
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

On 9/16/26 1:57 PM, AngeloGioacchino Del Regno wrote:=0A=
>>>> The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, no=
t=0A=
>>>> DRM_DSC_1_1_PRE_SCR, and the panel on my test device requires that eve=
n=0A=
>>>> though it uses DSC v1.1. This may be a panel-specific problem, but hav=
e=0A=
>>>> you tested this with any actual panels that need 1_1_PRE_SCR?=0A=
>>>>=0A=
>>>=0A=
>>> My downstream uses 1_1_PRE_SCR... that's why it is like this.=0A=
>>>=0A=
>>> I can resolve it like=0A=
>>>=0A=
>>>       if (dsc->dsc_version_major =3D=3D 1 && dsc->dsc_version_minor =3D=
=3D 1)=0A=
>>>           type =3D DRM_DSC_1_1_PRE_SCR;=0A=
>>>       else=0A=
>>>           type =3D DRM_DSC_1_2_444;=0A=
>>>=0A=
>>>       ret =3D drm_dsc_setup_rc_params(dsc, type);=0A=
>>>=0A=
>>> ...that will work, granted that the panel declares the correct DSC =0A=
>>> version.=0A=
>>>=0A=
>>=0A=
>> Unfortunately not, because DRM_DSC_1_2_444 is also needed for some v1.1=
=0A=
>> panels. From drivers/gpu/drm/drm_dsc_helper.c:=0A=
>>=0A=
>> /*=0A=
>>   * Selected Rate Control Related Parameter Recommended Values from =0A=
>> DSC v1.2, v1.2a, v1.2b and=0A=
>>   * DSC_v1.1_E1 specs.=0A=
>>   *=0A=
>>   * Cross-checked against C Model releases: DSC_model_20161212 and =0A=
>> 20210623=0A=
>>   */=0A=
>> static const struct rc_parameters_data rc_parameters_1_2_444[] =3D {=0A=
>> ...=0A=
>>=0A=
>> I'm pretty sure that my device is not using DSC v1.2.=0A=
>>=0A=
>> Since this is definitely panel-specific and there seems to be no good=0A=
>> way to detect the required parameters at the moment, this is probably=0A=
>> something to fix later.=0A=
>>=0A=
> =0A=
> Ok, let's just go with 1_2_444 then - makes sense... that's something=0A=
> that must be accounted at the API level, because I know of some panels=0A=
> that need the PRE_SCR set... and that's even if they're using v1.2, just=
=0A=
> because - for whatever reason - some of the DSC params are stored in and=
=0A=
> read from an OTP area of the DriverIC (and that would mismatch then with=
=0A=
> the other params that are runtime-programmable from the DrIC view, which=
=0A=
> results in pixel-garbage artifacts).=0A=
> =0A=
> Not sure how many panels are doing that, but this is of course not a MTK=
=0A=
> specific thing... I looked around, and apparently there's a mention of=0A=
> that in the Intel driver as well - yay I'm not the only one who knows, lo=
l.=0A=
> =0A=
> (And I definitely didn't expect that to be the case anyway).=0A=
=0A=
I just double-checked the downstream code I was referring to, and it=0A=
seems that the 1.2 parameters are only used for 10-bit panels by=0A=
default. The parameters for 8-bit panels match 1_1_PRE_SCR [1].=0A=
=0A=
So this would be closer to the default downstream behavior:=0A=
=0A=
    if (dsc->bits_per_component =3D=3D 8)=0A=
        type =3D DRM_DSC_1_1_PRE_SCR;=0A=
    else=0A=
        type =3D DRM_DSC_1_2_444;=0A=
=0A=
    ret =3D drm_dsc_setup_rc_params(dsc, type);=0A=
=0A=
But again, this is actually panel-specific and should be fixed=0A=
separately. I wasn't demanding any changes here and you can also keep=0A=
using 1_1_PRE_SCR or whatever works for you if you have to send another=0A=
version.=0A=
=0A=
[1]: https://github.com/oppo-source/android_kernel_modules_and_devicetree_o=
ppo_mt6993/blob/4d505a4292dab3176a45fec66dc85debc362e24c/kernel/kernel_devi=
ce_modules-6.12/drivers/gpu/drm/mediatek/mediatek_v2/v1/mtk_disp_dsc.c#L152=
2=0A=
=0A=
Best regards,=0A=
Nikolai=
