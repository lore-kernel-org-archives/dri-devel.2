Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AADC4453C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4D310EE6C;
	Wed, 22 Jul 2026 18:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpcvWvm2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E2710E4DA;
 Wed, 22 Jul 2026 18:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijgAIXYk3C6WW4Pp432fb4uwQlJbUeNXYvVck86ohIFvFNJkX5nHTeKHTdkDNVKHdo9HnwLb/xWbiE3QtdHYuIcnlZ0QgoIv1HGELZpCk3BfgDc2R55WGrV7aQtqst3bRGI1e2iAMUDTtnDuAc1O8+y++VCY7qeY7f7zIhaCcCPfoUJpn6BIpy6JM6fR6lw1/u68043jzI2osXO7vkQa9eAYJ3TZrMNXpGUXndUFay+klu9XFJ+rX+8u0psZSPMBAeidGtq7egFrV/HriH59oCmA0Us5bYudeORvzHZOdwPxyEhoEjBCUJVcNUQ20nMtFtEukQ+Bw58CHlinD5LpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vl1ngS/M/SpCulLqBV3+hsIBl/nKbXZztJz3q7VPIM=;
 b=MyXjr43mF8YAzILC9zIHh2v+TqdszLCRTaOP/r8JDcuo/GdU9PaK/dt5NMy2bPW5mFx29nzTImTauDirVDh3u4B7Z9INsg/LUUwGSSUC5jOubJGwT4WTocb2kIQP6WXs4ZNjDKimEzJTfyW8UzV1G/6j/g+Afp8EniaW/DL8/6XA8Yvp+nswnGg363iHVV6V8jTKpQ6bNYp/FpH8H9PAF5CjFrik6HKD0Af5Jo59qECpVy5pYkPvaDT/z+olReAfVBQtyEW9ix6af4YStWUpXp5f7RWFKFOhzrAIFbc3nLVOpzwOa2hrL+gtoJk3TAAVSS/F2UM3TKfG+LoVWRce8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vl1ngS/M/SpCulLqBV3+hsIBl/nKbXZztJz3q7VPIM=;
 b=bpcvWvm2YbxiTMnHIDT0y6DMjR10s0BL/Dct3S2qEM5NuDievMAReTFAEQe3SynDSd9SyJoF02RqbqoXgBZLWiI/JrmfJCN5SSRW3BYbFALlsmxjKu5eg+ynw6zGZogjZxoK0TxBGELomNSzfUQM8nmLQ0dwvYK22hmWpuukZBY=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 18:19:26 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 18:19:26 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: use proper context for logging
Thread-Topic: [PATCH] drm/amd/display: use proper context for logging
Thread-Index: AQHdGaPZZbpH5J/YLU2sFStfCjiUp7Z50AqhgAAHfD8=
Date: Wed, 22 Jul 2026 18:19:26 +0000
Message-ID: <PH8PR12MB7279B23FD4E5E8BD15294798F9C12@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20260722063210.1144266-1-jirislaby@kernel.org>
 <PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12@PH8PR12MB7279.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12@PH8PR12MB7279.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T18:19:25.616Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|LV8PR12MB9333:EE_
x-ms-office365-filtering-correlation-id: 588db229-612f-4db9-59ed-08dee81dc385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|4143699003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: HdmwjD3GACJvLsY73YNVBa50HisRbYhB8rHSfAmBQM+oC0gVvr3tR+a/Ec8MqVrFxgaAo6jmLoenyR8UuSoUxNIrdjt3QFt8puqnKPUjAWJV39+IgE5Z//MHjZ88LBGhOh5IIloK/9aRRaTMqVlQ1WAe9laT7V84UsXcYD5r7NJOQPT4IhsRQU98rEY86aw0v9i0fU2xmiUKVhyzI2V32Rf+HpRpyjUohlIdRskWHYKX4fbCD6gQuLah/af2/tCN/ynjM+wlw2InwggGiA7sdlDcJDNp1BmZm8MhFd4Q0eYNfj0FsUOEoK43HMjR9SJl6TC9Ff7wRKE0/2UrOJWhr1z46jpm/Mimj8FE7IudC7w1+T8Nx9oSpplEi1LSKy2bDFJx75ve83sQlMFLjVDV8qaj1DGo/URqQubhN0vbpgdHp8SEtHKkbLRl1gIc5YmjIIGCj8BxkXHns9o+Xo35Xd34ePFI3qsix93O1YslU4Kz+FXFHP1u5HutDG2uoSTLWaVk9gzJ2Z5oyayvcJknMrM2mF4PcRuQLJQlpIiA86jQp+zbtl5FMdbKEBBhPokjfGMgDz6uQhfrci0pDOYlJgtHZ0luS3wqBwEbOawQ1VVdv63nqOHcBWyYtf2fnO5e+6ADJAxMe/BeqKP3fNHRVLMfd8Ks0PKOPW8YZJ92irYv2VZTA0SrHTfwZcT7n5m/7o4XVulcEc4wO1QGreEZUtd6shf5O96jWGG8adw1IKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KxoFQHs/iuBAsq0wfZEf91qbeXXdvVTwuGvYN9tw5z1TQzrKe2GqsZkvWz?=
 =?iso-8859-1?Q?oCR9ySkyCx+dhmUvaxxLARAp7GDROhdNX0yi+gZj2SVcyF2qi2GJDzRXU5?=
 =?iso-8859-1?Q?VYtrDD4agM5M1e9j0wbeuYg212+7Q10DJzcSxZqujdlwBpn6QNkukWtWG5?=
 =?iso-8859-1?Q?7OfJnnHXm0aEaeJjdAwb2gUPxID/h52tpP0Xo0j6nnMDa91rn9TRHI55GD?=
 =?iso-8859-1?Q?9bcrl6o0YYSfgsyU8mvJkZ1S5MKmjrCBcg2duxauXiDcEiL6K6EEhbvpPN?=
 =?iso-8859-1?Q?qQiF1q9F69JVUGKtaHLVdkMT8i1/r5IK61KlukDZGBYZ+vZX4fi1Y8hjmk?=
 =?iso-8859-1?Q?U+W1fVJO1UsinVSCDELstFv16GjJ6OFgXdCB6BPv7sV/afTJVP/KQvThd+?=
 =?iso-8859-1?Q?yCgePqJ09V8pUmlIG4Aw4nzEUgySSWzudopE31uOVejVNYCXbbZlnddQs4?=
 =?iso-8859-1?Q?Ne87xq+mTVptj8UJWvpeWSiFvSCjPyppMf4gnu38py+2zhjFkmtKRApVbU?=
 =?iso-8859-1?Q?sxxeqBhDz90Iybe71dzjvPakdJf3n5gf+bqe0mXxQWyB2k3bqCiUyVWwlY?=
 =?iso-8859-1?Q?LDhXVrpWCOzqEcQ238diHhLCqBD7jUNZNTj0BSAH3HCiBMvHfD4ANc3xgE?=
 =?iso-8859-1?Q?Sad7kx6foq0rUQWDCQydTkeiqyzlWSmVKGE2a2hu06IZJgLns0g8M6QGI2?=
 =?iso-8859-1?Q?HGKzSWv3tp9qY5aPLxMeaL+nk8gdr35qbwPMuf3WricIheR+fZBAHiL4AA?=
 =?iso-8859-1?Q?jfpaXdwVwLJDxydmxpXn7cT7tWcAZWr17JyDaqAhOw/iYP9bzXeFnABrn8?=
 =?iso-8859-1?Q?VvbBBz3ONIC03F/tKD6B5KmLtEO61cZHbnNYt7+rej9BTa4rdKLBMI2eKg?=
 =?iso-8859-1?Q?/l57o0d+ujsw8CJNkliix4pVhq0zjPlBl2/etNlZ2UW68X1vosxirjHum/?=
 =?iso-8859-1?Q?gJ3OxWDEgfCM9F7bAaTyOmQ1yfzVVIVmFzbCk/XPiu5iFpmru/1uwBSuni?=
 =?iso-8859-1?Q?f4ZRjDKYMML0rmvxOGUv3ZRFW8N1SigBHkayx82J6PluEPpvAIavskFSyu?=
 =?iso-8859-1?Q?vITJrXDSbBliki1JnvHyPk4dBSzJqlYc4C/J7IINtpLR7KIjp+srimHu25?=
 =?iso-8859-1?Q?eAI0GZ+US9KUtRQ6zuxJJHwpL/YCwdwkTGNx7nbrbU8wHTCDnAP9tpZ8Dz?=
 =?iso-8859-1?Q?exb4zAZfUh8u0+BRLo8vIAd7/BTrdsQTAwqHl7e3XBLncuov99F4R0Er11?=
 =?iso-8859-1?Q?wW43IWBVyKj4tOUtEZWY3Tn02FRmkG+9VeGMLycDo+yfGrArAmmic7JXrN?=
 =?iso-8859-1?Q?Z+4x6nDlYUIJJzbzkvnddyt5LeermIzCtIcVGe6G9DPimXThiOonKaYhXg?=
 =?iso-8859-1?Q?fMe2aMM8G8k++9MFXRZq+V5DNztwU9OmeeSs1+CzMFqNcmebWvneg2Sglo?=
 =?iso-8859-1?Q?o0HipMwstMYxRf1Xfk8Xh6eFbZhnLiAxCOX6HxgMyP+v/iKeDSj7cQ5N4U?=
 =?iso-8859-1?Q?IwtZzgmbVNcIcPEsQxU6uNpnNdwKcJq14e6uZZik5KCTJQ7bnv1Nk+8Nri?=
 =?iso-8859-1?Q?htTx+a4j7/3MXTnDQIJdn//DK+8w7jATQW/oHyM0En/VTkk00HihP8qAA7?=
 =?iso-8859-1?Q?ZgC1/yRO9YS7WUamhd1VMascQK8zWRKTZ9idtFun2gpgdAwyhi0iIgdmaH?=
 =?iso-8859-1?Q?cIP2Q1YWduMtMyFvyRvPywKbV2f2MRDrCXYw89vdZYG8xawuWn5dzo+eX7?=
 =?iso-8859-1?Q?COYgkM9TBjVIhqyTisejYB3U+YdXPaFXbgEtjG6J+fnM/N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588db229-612f-4db9-59ed-08dee81dc385
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 18:19:26.4411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ClwdhEiSFkCVR9W7HPq8ISb77y4zd6z4uDOmZOFTZQXsrRWZ/5UzPnh7AR13oFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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

Hey, why not just do=A0=0A=
=0A=
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
@@ -45,7 +45,7 @@=0A=
=A0 =A0 =A0 =A0 clk_src->base.ctx=0A=
=0A=
=A0#define DC_LOGGER \=0A=
- =A0 =A0 =A0 calc_pll_cs->ctx->logger=0A=
+ =A0 =A0 =A0 clk_src->base.ctx->logger or CTX->logger=0A=
=0A=
=0A=
clk_src is available everywhere right after dce110_clk_src_construct()=0A=
=0A=
=0A=
Bhawan=0A=
=0A=
=0A=
________________________________________=0A=
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>=0A=
Sent: July 22, 2026 1:51 PM=0A=
To: Jiri Slaby (SUSE) <jirislaby@kernel.org>; Deucher, Alexander <Alexander=
.Deucher@amd.com>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Wentland, =
Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Ro=
drigo Siqueira <siqueira@igalia.com>; Koenig, Christian <Christian.Koenig@a=
md.com>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@l=
ists.freedesktop.org <dri-devel@lists.freedesktop.org>=0A=
Subject: Re: [PATCH] drm/amd/display: use proper context for logging=0A=
=A0=0A=
AMD General=0A=
=0A=
Why not just do=A0=0A=
=0A=
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
@@ -45,7 +45,7 @@=0A=
=A0 =A0 =A0 =A0 clk_src->base.ctx=0A=
=0A=
=A0#define DC_LOGGER \=0A=
- =A0 =A0 =A0 calc_pll_cs->ctx->logger=0A=
+ =A0 =A0 =A0 clk_src->base.ctx->logger or CTX->logger=0A=
=0A=
=0A=
clk_src is available everywhere right after dce110_clk_src_construct()=0A=
=0A=
=0A=
Bhawan=0A=
=0A=
________________________________________=0A=
From: Jiri Slaby (SUSE) <jirislaby@kernel.org>=0A=
Sent: July 22, 2026 2:32 AM=0A=
To: Deucher, Alexander <Alexander.Deucher@amd.com>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jiri Slaby=
 (SUSE) <jirislaby@kernel.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.=
Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <si=
mona@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>=0A=
Subject: [PATCH] drm/amd/display: use proper context for logging=0A=
=A0=0A=
The same as the rest of the code, get_ss_info_from_atombios() uses=0A=
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is=0A=
initialized only later in calc_pll_max_vco_construct(). Therefore, any=0A=
output using DC_LOG_SYNC() leads to a NULL pointer deference in=0A=
get_ss_info_from_atombios().=0A=
=0A=
To avoid accessing the NULL context, use clk_src->base.ctx->logger=0A=
in get_ss_info_from_atombios(). That context is initialized earlier in=0A=
dce110_clk_src_construct() -- before get_ss_info_from_atombios() is=0A=
actually called. This is done by temporarily redefining DC_LOGGER to=0A=
CTX->logger.=0A=
=0A=
Before:=0A=
dce110_clk_src_construct() did:=0A=
=A0-> sets clk_src->base.ctx =3D ctx;=0A=
=A0-> ss_info_from_atombios_create()=0A=
=A0=A0 -> get_ss_info_from_atombios()=A0=A0 <- uses calc_pll_cs->ctx=A0 # B=
OOM=0A=
=A0-> calc_pll_max_vco_construct()=A0=A0=A0 <- sets calc_pll_cs->ctx=0A=
=0A=
After:=0A=
dce110_clk_src_construct() does:=0A=
=A0-> sets clk_src->base.ctx =3D ctx;=0A=
=A0-> ss_info_from_atombios_create()=0A=
=A0=A0 -> get_ss_info_from_atombios()=A0=A0 <- uses clk_src->base.ctx=0A=
=0A=
Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271175=0A=
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@ke=
rnel.org/=0A=
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")=0A=
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>=0A=
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>=0A=
Cc: Harry Wentland <harry.wentland@amd.com>=0A=
Cc: Leo Li <sunpeng.li@amd.com>=0A=
Cc: Rodrigo Siqueira <siqueira@igalia.com>=0A=
Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
Cc: "Christian K=F6nig" <christian.koenig@amd.com>=0A=
Cc: David Airlie <airlied@gmail.com>=0A=
Cc: Simona Vetter <simona@ffwll.ch>=0A=
Cc: amd-gfx@lists.freedesktop.org=0A=
---=0A=
Cc: dri-devel@lists.freedesktop.org=0A=
---=0A=
=A0drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 8 +++++++-=0A=
=A01 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
index ecb8493ec523..d3f7aa853e3a 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
@@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_sr=
c_funcs =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .get_dp_dto_frequency_100hz =3D get_dp_dto_frequen=
cy_100hz=0A=
=A0};=0A=
=A0=0A=
+/* calc_pll_cs->ctx is set only after get_ss_info_from_atombios(), unlike =
clk_src->base */=0A=
+#pragma push_macro("DC_LOGGER")=0A=
+#undef DC_LOGGER=0A=
+#define DC_LOGGER CTX->logger=0A=
=A0=0A=
=A0static void get_ss_info_from_atombios(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk=
_src,=0A=
@@ -1526,7 +1530,7 @@ static void get_ss_info_from_atombios(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct spread_spectrum_info *ss_info_cur;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct spread_spectrum_data *ss_data_cur;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t i;=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (ss_entries_num =3D=3D NULL) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DC_LOG_SYNC(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "I=
nvalid entry !!!\n");=0A=
@@ -1631,6 +1635,8 @@ static void get_ss_info_from_atombios(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 kfree(ss_info);=0A=
=A0}=0A=
=A0=0A=
+#pragma pop_macro("DC_LOGGER")=0A=
+=0A=
=A0static void ss_info_from_atombios_create(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk_src)=0A=
=A0{=0A=
--=0A=
2.55.0=0A=
