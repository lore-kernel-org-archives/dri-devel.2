Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B7EC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7872D10EA55;
	Tue,  8 Sep 2026 07:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="b31XxE1N";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazolkn19012066.outbound.protection.outlook.com
 [52.103.14.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFAA10E35F;
 Mon,  7 Sep 2026 15:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5vz+ndVFrK8P4A/c4TyDURhc5mCwZC/kI8tJDIKXQFCj2kGWjQnyUfDJleAdK/OHca0WdDnj213w7Fb17UaaRPHMn5Ok6gmx5uIJWqHAlQkBMaJkkNKFDjTDtmf8CHzVGm7n1veGMrfVtllnWGy03ZBQMsKNnFw+xuwAt8zjaBDWEzsv59iF4/s10LABTzNLYyZ4T8cDJcgJmbGTPh7Wj+qvpVgwoN2+t92XbgP4FV8NvpEn9qR6DvqX9dCKKnJSegwKjVbzwhDvbPN6KIMiVSFpk3pSvvf94lMzaewhFE8U9ipHjq1U0S1s6YV7ncWdXEOlyQrnF57GlNUTdAA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjWpL3z1ExwwzVr8x5jZLQ8FBkoH1OHa3IKQre/V+EI=;
 b=SWf3KhhXWNvDFrzNpbFG5rva3ThjkO/Y5RAD09RFpNzYw0p9TTlxbOI7HY1wu0svg2ImyH5TfrKxgkMAmQMCi3OvgsdmR84Je7Pd6Io5jRwLUDeakq18QVGF9mWG9EZrI9m5CmpVna5miq25kdXmWdqarNnjLKtez4Ma1h6i3zFrvMVcy5THbpnp49xfQkfvJWCVO99uXisQp7xsRjtmCibF+1szDqxj6heK6ozrrVt9oaqdT73wSn4Nj6vZBWbziMuGL56RBK6nuQBVhJqCiVQ24OHrgD39Xhv/onkj+lo4oUmrycIjskTGPPbz/XA1TWrPTVnZpUmTAaSveRdeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjWpL3z1ExwwzVr8x5jZLQ8FBkoH1OHa3IKQre/V+EI=;
 b=b31XxE1NV1ojfz5/qVcQitZZ4e1i+MBczlh2KESeDIobNu+Ja0bPb/IltZqS/MZcs80A4HmJUI3QYd8HllEDnqwFCFH7kxUmW95WAoDxW4Q6G26qMPglQEsN0dFMmSyFtd+RIRbx6RKg5sLPlgEYcVJUQxTV71eu5TUsD/rgpGM1tTJRJCKG3IKFKRmOGGsOCfc+jt0T9PqckV2vuknTxq+0NPZo2J8zvCZVbhjKNkyiCuEfFXPuabOjIJY7vQGxy7o9navynkOTcRfY/rhVxL5+dJwAs5lgpVkxXUEsS07sAptHDNQMu9DY9iurppJvpOzKAmKwhoQFnvYtp1oIhQ==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by CPUPR80MB429769.lamprd80.prod.outlook.com (2603:10d6:103:3ae::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:21:04 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 15:21:04 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux@leemhuis.info" <linux@leemhuis.info>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
Thread-Topic: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
Thread-Index: AQHdPtw9Ub0bdlVoJkOLBrcx72wrOA==
Date: Mon, 7 Sep 2026 15:21:04 +0000
Message-ID: <CPUPR80MB65833B1554155D4CCF024CF2A3B22@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|CPUPR80MB429769:EE_
x-ms-office365-filtering-correlation-id: bb67ec1a-81b5-4c89-a678-08df0cf3a223
x-microsoft-antispam: BCL:0;
 ARA:14566002|25031999004|21061999006|41001999006|8062599012|8060799015|24121999003|19110799012|24021099003|25010399006|22091999003|55001999006|31061999003|15080799012|15030799006|51005399006|5062599005|4295299021|440099028|3412199025|4302099013|102099032|1602099012|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+rGcMLpkcrB5spUdI99dFGHfpZnRoEtQVktuCVRQsUqsFRPq2h9UzClGb6?=
 =?iso-8859-1?Q?ZMaNgH4wO1UUcb2MQbJagxR1jl9DFL4wz87y3duspRvE84NZoe1eaMoxfg?=
 =?iso-8859-1?Q?w0uISVXcKrjkRSfbdrM0TJJP483gkT/8DsD8VdxJ+yMPQZSXVTWoGne/GW?=
 =?iso-8859-1?Q?PgBiLNAbwlpCAnoDsjjRZvBNOGY6HeUU9FW6mcOuzwLkL/eTx3Frr1gAAM?=
 =?iso-8859-1?Q?BjICzZOaOYrIHJF/xxjamNYEDYgdgksGcFYYljIdc8CTUREMpVubH4Z5zw?=
 =?iso-8859-1?Q?mGd61WjIQ8ROfjOcTxpleDFNGIPmtsmOAJVLGezZznB666/yAArgUDPdba?=
 =?iso-8859-1?Q?R1jnIgRWvfxnLYMRbvQWKnqn+N839JmoW+t1T3HffhA25Gf5PLrmDvM5ni?=
 =?iso-8859-1?Q?Mo/8RFdi6Oy8nmKsVEZrXndVb1+8XCw6rt/OqCjlHgNKvs5i3CoK3WaZV5?=
 =?iso-8859-1?Q?6vm3926cHd3FtVlABztNCLAucDeaWdfNdrcKEgijmAZa9doIjFuF8FLNI1?=
 =?iso-8859-1?Q?lNyTr4YXB4v4CHeYf9PuUfmjqUIGcr6c4SkHZPkmEGvTq/6A/E4cmU3FxY?=
 =?iso-8859-1?Q?PfeS5+Xd4PPXFmMbjmNX0yOwmilT8Zi3iTf2yq9SuqyJVCcE6mKVtC9fwI?=
 =?iso-8859-1?Q?wmLU8QsP8jN6hBgztKm+qcpkgwjxu5vYcuX8jxScfsIAbxrPIJ76dyV1kQ?=
 =?iso-8859-1?Q?6UBgf6aegvUSOYxV93v8TH8PqgZi8sXShAfN6TSRTkZeD0VCzaLhLt2Q+o?=
 =?iso-8859-1?Q?LPJOzq87MoBsSQIZ9CTSjDUAjowFcemwcYn/VkP5Aw9kJiKPqpawK2NC/r?=
 =?iso-8859-1?Q?UMCvAw8MnByVLbWazQplc0dFcWkfGr22umNLuIvpJXmlpLBzIW/XfKY9fE?=
 =?iso-8859-1?Q?SXngt2LzrjYBTmme2dYawt34dFxf8Ga+5xXUDyEN9MWDAX3V6hsBNiPfR2?=
 =?iso-8859-1?Q?ZLm7qFIyNIks63lYm6B7xxSD+6HkhWm0KENiwVAqAtknmZnDFtQDlufFvz?=
 =?iso-8859-1?Q?vaoZxDAWzcLCfA8DZhQ8PH3XUofXqr5NINTG15nT1sTXAwniPNFDNXXjxy?=
 =?iso-8859-1?Q?YKp6CkpuqPSfQDcJq9ShRSKBGqMpUXJG4TOJW2u/vIB1bVku4U2VJbJu/4?=
 =?iso-8859-1?Q?98r2PmGnIlHvrvjWNOgoCgZ+1ZoUFQFqQcbW0qIHuyKLXaRQ84gdrcCGJJ?=
 =?iso-8859-1?Q?ysd2HhCX8x7diQmlL2Yy+Ja2nM8waLL7ysJeAZC3829/qbAaDVM3s97+km?=
 =?iso-8859-1?Q?+69cUpjHhnK9PSNBtuUHT1fVbrjyNr09kelBKSSVU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0WIuRoJoh/ylNCsD+cezshwDT2W1Nsp3k/yQ8TZ819tr83w872594TT6as?=
 =?iso-8859-1?Q?gD9nE1jrGZ+I0IA8nE9GETJ6JeHsf8Ws0+Ss67aks0fR+qHQSAbE7kmLfC?=
 =?iso-8859-1?Q?y4JorUOdNmOALpP3Lt6G1FKQQxcT/YJF3/cI0rJlYzbn+NYb9nYLYrJas1?=
 =?iso-8859-1?Q?6WHw1MxN3G0KDpHtOEXrME8iPL5qU4gWhsM4h1rp1A/e0DLQqfXNxu7m9s?=
 =?iso-8859-1?Q?lOnd+V8gCH+oVKweHyKLiyIrqkxrJdf6GraCrihRT6428GV10U9x70c8xf?=
 =?iso-8859-1?Q?74+T8rjDCIZkpz9eyLkAZMnvfhVujzmlt8XswEVWoBEHTesLMrdFqjYHA1?=
 =?iso-8859-1?Q?rv0hmXOOle92HJB6+hq7JXdQQ7ZfXboqUu2DNoMU2Wz/jrQOLSIruW2W+h?=
 =?iso-8859-1?Q?Ja0j2z9ZS9aK/+javeXT9XNSaVDaMwbEmxQU8NJZ8MlOT5Zy21yYHl+waF?=
 =?iso-8859-1?Q?W16Qx35ZcmBQtIARSH9fD8GQy9fW5n+5NRkIhhxWIIeRHcAmTJEcL0xQ/k?=
 =?iso-8859-1?Q?M1AoYhlNf/JjkKtAqRByHllufLERWTrjll6jzRqxQnzPzIxK6itaf8I0DU?=
 =?iso-8859-1?Q?+GfXRe2DNuwaGxva5Me6hxXvEW6YwujjO/Borz6UzpVJA+VzqXtHsnYiOs?=
 =?iso-8859-1?Q?auAP/bomsBswevoX2ETR6RdXo+KMY5RwMT44UhlaZaJL+kBYD2HjHiY9tI?=
 =?iso-8859-1?Q?WceBkbu3yJGsDkP06v4QYTA60CVkCWLMV0rK3UKBP0mW/eTRJ6i1vyP9+Y?=
 =?iso-8859-1?Q?7M83/o1rKwmGogS00O6/fmsGW1jXf2SgHLWwr33vEfJhlVABCxxt7W6S7a?=
 =?iso-8859-1?Q?B4UH6+7rwLNmqnZNxtmaEJNNLxSOGAyphYC5S1T04BYTBDmF5K/Imc30gz?=
 =?iso-8859-1?Q?UWmBLa8MzkrVTKQFpZE4Zu3U56ln9A+2USbTrJXm4TgISO4McD+Tr4cL/2?=
 =?iso-8859-1?Q?gjeI4fxRpghtw7cuem7UBwy9sWEIFE2wh3XkMSRUHWfjC5DJ+eQpKYXee+?=
 =?iso-8859-1?Q?cf+c/JvkPSEXVz+eTiCoGHBUNfZTY066frahpUMaWFaZGESZCz+IGbWVex?=
 =?iso-8859-1?Q?Eb0dbpXAk79zbPFLtHOHMsFkmWG1gsgFuzxgK4nX5W0ro3nFfUkB6QdSO3?=
 =?iso-8859-1?Q?vEGxK62nmMjiC2fmWuYfrjqgI3OZPGsxd+2VOCKNbKY4E9Sy6IrtEkhOOB?=
 =?iso-8859-1?Q?piUWZ4qd+LW8p8/+sm3/xm0VO9pbM/9R7RBf8oWy2whBGuKxauhoRRbgNa?=
 =?iso-8859-1?Q?NgDx+r6yqaiEM6E0Jiu0E9s2UEakRlJCsolFNB+Tdz13LP1jE3egNcXAZB?=
 =?iso-8859-1?Q?IWIB54rPQmfNBc2S3iiUJMYouEtYaZaDLy5pwK18Sy2qLo2ZIQM2U0/Zwp?=
 =?iso-8859-1?Q?+uRYkvUUajl4EYWFXUvCs6me0kKvdGlHF6VIWeNZDZuQz5GBraOiGBlFk7?=
 =?iso-8859-1?Q?ePePdq8DBQJh03x+5iKXZ3mbYSUb0l9NX5ewSJ4xBuZ6dYr3XAuZq+T5y5?=
 =?iso-8859-1?Q?X87xWHtOcRODROaS/dnSwIreQZ6IAPT9kXlit+zDvCOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bb67ec1a-81b5-4c89-a678-08df0cf3a223
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 15:21:04.6289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPUPR80MB429769
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

#regzbot back in-progress=0A=
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21423=
89=0A=
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123=
=0A=
=0A=
Hi Thorsten, Alex, and Linux Kernel Maintainers,=0A=
=0A=
I am writing to update the status of this regression after checking the Reg=
zbot tracking dashboard:=0A=
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=
=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/=0A=
=0A=
The dashboard currently lists this issue as "fizzled out / resolved: inconc=
lusive", but I want to clarify that this bug is ACTIVE, UNRESOLVED, and act=
ively tracked. The lack of recent email activity on LKML was due to ongoing=
 technical data collection on Launchpad and GitLab while awaiting upstream =
feedback.=0A=
=0A=
Current Status & Verification:=0A=
=0A=
1. Launchpad Report (#2142389):=0A=
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).=0A=
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed affected=
 users across various AMD architectures (Tonga R9 380, Polaris RX 400/500, =
and recent Vega APUs).=0A=
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389=0A=
=0A=
2. Freedesktop GitLab Issue (#5123):=0A=
   - Status: Open.=0A=
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123=0A=
=0A=
3. Technical Summary:=0A=
   - I have executed 3 full git bisect routines on hardware testbenches, is=
olating the regression behavior between kernel transitions.=0A=
   - Recent user reports confirm the same black screen / no EDID handshake =
failure upon resume and DPMS display wake-up across multiple Linux distribu=
tions (Ubuntu, Fedora, Void Linux) and kernel versions (up to kernel 7.0).=
=0A=
=0A=
Please re-open and maintain active tracking for this regression on Regzbot.=
 I remain available to test candidate patches, kernel builds, or debug flag=
s on physical hardware.=0A=
=0A=
Best regards,=0A=
Danilo Machado=
