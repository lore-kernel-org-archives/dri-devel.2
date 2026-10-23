Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB6606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DS8/L4hn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9680D112C61;
	Fri, 23 Oct 2026 17:01:04 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED15112C4E;
 Fri, 23 Oct 2026 17:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJP06AGT3XK98+7yfnwKxlXz5MkibW+PQ4+sXfz28sTurprM/WhxHwSK5ZCs9wsGl/o7we2Vj3T9FYWL041uG0LZwFUsaXISybB0arpsANZVliHjb+2FCq+f8+qMmVvrND/CY5duyrHg6KmxOD0iBvcaOfpcNVzPzHM6uIJFTICbxwUveHDbVsA5xBNdW7hyfFJzAl20L9ZrcBB/TPygofxhpPIw/jtzqUdqjUWBI8d1dNb8cx2J9/1ulE6Rl7YHJ5m/tZrgEJX39lipR130y5oyWzln888tAffma4x8WKxxCgCBVgqLKbT7vvpvNPmgXOQflSSd41SoCNvXcj6SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNEmCOM2uqeN9moJiN0uWJhdK8D7CHuX68OQLyGTd+Q=;
 b=DbBbF0sRWw8/lfqI65LYWvTPl1JyCzs6fYQtIHta1V5nIJZFfFpHNsK3LKyVc5IRO+L8w8m8uW195I96kyqNHS8k2co2pL5HdXZG6k6VqbpXIW6pOr0BtvlHHMqqdRy/fBXN4qfua0oUeDpAS7fr9HAsyvnlTxjooniQ81Q6mvHNrLAmElqEAXztHRaGkdfPG9vXg3vgDPe7HjWQvyU/pmPe403rqmp5ZsyNI5tTT8Dgj+aBi19+aJHgeDUuvlWG0NC1WFF4Zjcen3ulSF/s4Drt/LGMmfB0krLLniTylMDS7k9yt6G1qK7XytdL2JYkmxWDdQSqMrBIhZ4AL9Dl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNEmCOM2uqeN9moJiN0uWJhdK8D7CHuX68OQLyGTd+Q=;
 b=DS8/L4hnSq+w3/4j1ZLCtN4Dfm+jEa/SP59rxkBiWk6HjhmBWLrrYw0jAMur/S/ru64iYOTpf4mm98dAngrJtEbc14YYBWMR/zLbzc+TtrQhxK1kAk19LqNlQPbTu/Pls7vytwpr5GBQuCWRIbQtrM8KEOHSRV0F2Da1fieF0k4=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by CH4PR12MB516140.namprd12.prod.outlook.com
 (2603:10b6:610:506::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:59:49 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 16:59:49 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: David Janice <djanice1980@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training
 at every rate
Thread-Topic: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training
 at every rate
Thread-Index: AQHdSJ+3gktfw8rd2ESLnJsPZ/OvCLcLdfcwgAAYJMA=
Date: Fri, 23 Oct 2026 16:59:49 +0000
Message-ID: <CHXPR12MB99922053033BBEAB715EB8F8DBE5642@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260920013050.21259-1-djanice1980@gmail.com>
 <CHXPR12MB999220096CBA8DA25F23E138A0E5642@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB999220096CBA8DA25F23E138A0E5642@CHXPR12MB999220.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T15:31:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|CH4PR12MB516140:EE_
x-ms-office365-filtering-correlation-id: f08828e4-e5a5-43b3-4ad3-08df31270c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006|10067099003|3023799007|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: ilMB09jcuBCn//oxMZoLn64EyVnIrCMs9CgcaU/Vvpcgi/F70AkMvYoaDZCa+JNg+wa+s8DEa93VgyvYzYe4KqHXVlhv8BE8nRjrxj65ykmCiBeqWvr6sDI3ZuQypPYOLUFLsrtksZwbDjN4oydf3vsvfANaFiQ+Tc2hsBtVVezJVcTd66oZRBcDF48R2h8bujej13+M6YBe8A/Xw48JnPsnjUrChRBcc1eBYhnILI1XBNFK9j/IyQJSFXM0C/lhabxutDOLCamUBBlHKUeP30WCm+Ex1sVMWB+Fln5sPSkMQSUgL1WH+rEw9qgn0RerQKFDEIElQJ1ucua4iVWYKenRLLXOnzLdH1vSBNS7LnLwMUM3mqVxj+YHRZOUN2jHSlzke5g+nb3OysvztVlfp5M2FvoqJYL6W2Rci8jr5fRVMj0S6QDfAlDnbPnlOEt4KMNwdk47Ekg56+lOA6IfYaA7P4vkXe/yqhOnJsDc1ztE4JMx6dP/ikyObQ+LRznoUlwEzgCuNySGD8h8NqrYfcSCfydwkp4+QDIXeWNNRA6RShEwXWz5JRQKq5+hqa9TQitYRsHKW5A2vhW0YRIDELgrqVJvT78ZhZIX16oWff7x3buSm22SJmmQ/ac1axnf1v7mmkcPytRC87IjMY31sygWWuPOeROwrmFFZuEmNpNG3lacavC7TqgsYfDtrAHh7TtPrm2JwUooJvs9CCpII380DKtZ1h1m+muU191kCOo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Tr4RmlH8A60dWXXRv3JFsriiVrAZsiJIpGn8WSepCE+zjwskAMOrbp1ENWe?=
 =?us-ascii?Q?bo/yzoxh4ABh0gf1IZqyzP06RDMbSpQrkzk4MTBK5YD/TM1XBOUHu4a7fZPY?=
 =?us-ascii?Q?sMq7WKik7y3DDg74wMx/Tx+xpjBq5CEGqr6cI9MToB6orZg9t1Mye/F2AJh/?=
 =?us-ascii?Q?a+dMeoEKDT3uckZf4iG3yN0CGxRcWyRpk/YZwCEOxsMKYoVrgUPBSJAXzW9B?=
 =?us-ascii?Q?EXxdSBDilYOQ6qNK2hcHdKOJF6cEdi3wGO03sgBcv3l/wNfNzCk6zhEO9Pqn?=
 =?us-ascii?Q?REkrZXXWrhT6h+N7LhPW8zkd3zbMyFK1T3hzOqI3/NJMQbmZaUaML71TT4aL?=
 =?us-ascii?Q?D6X+ae/GQF5LJ8vdOjNUEf7Ys6Y6qe9mWhfjjM7ILn1OwF5NHAYnSal80fx5?=
 =?us-ascii?Q?qJmoGLx85+qi9f8AKrJAccGFCW7VS1XZGRE444Boo2J3czTvCWT7kxLT6P4G?=
 =?us-ascii?Q?c9FZMVnH4bwLbJi7Yuh2zLo/Y+OKwsAMDW512QH4QXpQGbcD1Km0c4fmZ9BJ?=
 =?us-ascii?Q?ODwuOaWpWwZdbD7bgAlxn5ywdXZMMaG4w8kpaYjCSbY0l9CX/KGWU/+/GA1x?=
 =?us-ascii?Q?O84fL51pj6+Q8cAc7DzqNOUagdnEUJp8WbQtTSanurCFN4qMpw+b/KA7V+ow?=
 =?us-ascii?Q?MHrRbDlv0b4xWNgzCdMr/XDJapQBaearf1k4wa7Rs8+7RmlhUMO9oIrf0xCt?=
 =?us-ascii?Q?Jz/HtrFH1v6ObcJneivbAWD1Dfa7xjv7DnBXEfPBljh1YbHOqRWyl3pgOsJN?=
 =?us-ascii?Q?AVFzTIdFzEH4PLFEXEreerI/jCkU5JdsKxBQvNgqiePIkp4hZtElj/v8jTJq?=
 =?us-ascii?Q?5uL4o6NH9zAeDDFxIVRsCkmF2D7GbHodR15XuKkQlGBX0GOglVkqwyHnh6zg?=
 =?us-ascii?Q?f8GFS40VUoyjMuKfgycWYoCUKS3xO7rvkXgegu3p9CHpAgQoe8CcoTqgAf24?=
 =?us-ascii?Q?04ulGIy3e/VV3JKOOjVnwxmf25VRxHTP39K0yovZpGtHMjHkS8asYf7U0IqG?=
 =?us-ascii?Q?uVZssLbuqtTPGX8fEhZJ25uhzZuhTuNmi7QhCsDobzcGXPXUeAWM3lTsaRIZ?=
 =?us-ascii?Q?zs1Tu3lvpr+LzFB4QHic9h4qokcZAQHTyAWyguHwFyBt+ZMNNdQ3UkFLob2C?=
 =?us-ascii?Q?uEhaRzZ36kFYbr/W92LXKTakLhBNnTCroeE6FQaXyGA0Hvunt65nGyBQikOe?=
 =?us-ascii?Q?OhUjHyyEOGxo3NLvzlpgEW7IQw73KuraiY81WX5RJdczKCR8OZ0QDraey43v?=
 =?us-ascii?Q?6JWWlaGkRPgzpfx761SOqkm+rKPAwpjd+U+nhgVQh1jwUpkiNsvWBqVOZYUM?=
 =?us-ascii?Q?EwYJdRL4M/6+nO2uB+Eo2mzWfmPDsjbn5R17ZHNnvwuOSjYyyb8k/fYo8jXw?=
 =?us-ascii?Q?pcjIqnvuJyxN3riXzgmzkwuVqyuk+hj+2En0/+QWquYMmALG0bEHqOaiDuW5?=
 =?us-ascii?Q?bTS1+Q+Okbyvkgnuhz/alcElY+eMtdD1RQT9D6fqyrUzpqAKbR/Dfs+wU1Td?=
 =?us-ascii?Q?jJO7Yen4UKjTRI4ci5hAjzzVnuLFc3QEbtE/YvOaYqtmMWjfoUdCSl5BuBQv?=
 =?us-ascii?Q?jleMu9VqVchJ3SnBqX/bJoCukRuq1Sjf3u2R29yxYQcLvMrKZffXioGjDN1Z?=
 =?us-ascii?Q?ILNtgQKM5iHsEfnWhC9WGNJlR1M5PQ+yDl8/Pdgn7eX+zO1q5Z9/fG0IfsKu?=
 =?us-ascii?Q?g+3X20OK2OlF4h4aQuoHnxFslSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08828e4-e5a5-43b3-4ad3-08df31270c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 16:59:49.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq2aNTECQz3a7yz50nwdjMfwfDWduW2GMv+ofUDLaIfB6euHAqKm6l8qGEWZhgIS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB516140
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Zuo, Jerry
> Sent: Friday, October 23, 2026 11:50
> To: 'David Janice' <djanice1980@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; dri-devel@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link
> training at every rate
>
> Your change already being considered in below two changes. Please kindly
> check below two changes:
> "drm/amd/display: Fix HDMI2.2 LT timeout duration"
> "drm/amd/display: Adjust HDMI FRL LT timeout"

Just add commit title for your reference.

Regards,
Jerry
>
> Regards,
> Jerry
>
> > -----Original Message-----
> > From: David Janice <djanice1980@gmail.com>
> > Sent: Saturday, September 19, 2026 21:31
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Zuo, Jerry
> <Jerry.Zuo@amd.com>;
> > dri-devel@lists.freedesktop.org; David Janice <djanice1980@gmail.com>
> > Subject: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link
> > training at every rate
> >
> > [You don't often get email from djanice1980@gmail.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > hdmi_frl_perform_link_training() gives LTS:3 a single budget of 105
> > polls at 2 ms (~210 ms) that starts at the FRL_Rate write and is not
> > restarted when the sink raises its first FLT_update with the LTP
> > request. A sink that needs close to
> > 200 ms after the LTP request to report lock therefore fails whenever
> > its LTP request itself takes more than a few tens of ms.
> >
> > Measured on an LG C2 (GSM 49352, 2022) driven by a Strix Halo DP-HDMI
> > FRL PCON, DPMS off/on with drm.debug=3D0x2, kernel 7.2.6:
> >
> >   6G x4  (3840x2160@60 10bpc):  LTP request at poll 11 (~21 ms),
> >          lock at poll 100 (~179 ms later): PASSED first try.
> >   10G x4 (3840x2160@120 10bpc): LTP request at poll 22 (~44 ms),
> >          no lock by poll 105: "FAILED - Timeout waiting for FLT_UPDATE"=
.
> >          Retry 200 ms later: LTP request at poll 11, lock at poll 101:
> >          PASSED.
> >
> > The sink answers FLT_READY on the first poll every time and locks in a
> > steady
> > ~180 ms at both rates, so it is neither slow to wake nor marginal; the
> > total just does not fit 210 ms once the LTP request is late, which
> > happens far more often at 10G. On this system that is the difference
> > between reliable DPMS wakes at
> > 4K60 and mostly dark ones at
> > 4K120: hdmi_frl_perform_link_training_with_retries() retrains at the
> > same rate up to four times 200 ms apart and the output is then left dar=
k.
> >
> > "drm/amd/display: Update and revert FRL LT Timeout behaviour" already
> > allows 155 polls (~300 ms) for 16 Gbps and above. Use that budget at
> > every rate. With the change applied to 7.2.6, five consecutive DPMS
> > wakes at 10G
> > x4 trained on the first attempt; three of them locked at poll 104-105, =
i.e.
> > inside the last 1-2 polls of the old budget.
> >
> > Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > Signed-off-by: David Janice <djanice1980@gmail.com>
> > ---
> >  .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 14
> > +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > index 7f93009..005feb9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > @@ -528,10 +528,18 @@ static enum link_result
> > hdmi_frl_perform_link_training(struct ddc_service *ddc_s
> >
> >                 FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
> >                 /*LTS:3: Start Link Training*/
> > -               /*Start FLT Timer =3D 200 ms, or 300ms if link rate >=
=3D 16Gbps*/
> > +               /*
> > +                * Start FLT Timer =3D 300 ms. HDMI 2.1 specifies
> > + FLT_TIMEOUT =3D 200
> > ms,
> > +                * but this budget runs from the FRL_Rate write to the =
final
> > +                * FLT_update and some sinks need more than that in tot=
al: an LG
> C2
> > +                * (2022) at 10G x4 raises its first FLT_update (the LT=
P request)
> > +                * ~45 ms after the rate write and reports lock a furth=
er ~180 ms
> > +                * later, ~225 ms in all, so it failed the 105-poll (~2=
10 ms) budget on
> > +                * most DPMS wakes at 4K120 while at 6G x4 (~20 ms +
> > + ~180 ms) it
> > just
> > +                * fit. Use the 300 ms already allowed for >=3D 16 Gbps=
 at every rate.
> > +                */
> >                 num_polls =3D 0;
> > -               if (link_settings->frl_link_rate >=3D HDMI_FRL_LINK_RAT=
E_16GBPS)
> > -                       max_polls =3D 155;
> > +               max_polls =3D 155;
> >
> >                 while (num_polls < max_polls) {
> >                         flt_poll_cur_time =3D
> > dm_get_timestamp(ddc_service->ctx);
> > --
> > 2.55.0

