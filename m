Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39582606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=KSGztX+l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F55210FA1A;
	Wed, 25 Nov 2026 13:36:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011044.outbound.protection.outlook.com [40.107.74.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B8210FC32
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtjAJyvixc6nPgeDZc0IEAYf7HKyXlY/OYx+QwIANZj4wPMVEmavTmzuVdDYXJATxp8VQrNXDSg8C2aVfRBuglaTOojVD64RRzRjFAm9JvkMk5/X+zPQaS8CYBdsxgIMUXWhNzWC824XecYLIkB2OG64CWtd4MuEiD0ddmITHZSM8qxz3dzZXEOk4KkbtYQ63sT3IzMqbB2TujjzoR074uPl9cIEmsB8ml/jGQFhi+iMLlDtivP8tM5Ow18hcLSdRchz2yLlkI5XaGkqecGFWDlUqw7WS/fsoDwbczrJELeXfOqcvYZpksPdciQfrBf6692MKhwiVaECUdxzMmDmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyn/jepDkwLOIzxEwP+2HmXUgkUyYc87Xxj3KyGUQM4=;
 b=bfntxC3HvTNqRp5TAlTuQ/qpAddZiwao+SD+QZCrHry3i05qQFy246OlK+opCDC6Ba971NRQUjXsCsX+jzABI7o+rF/RsGiGcKnieOEZ5ZnYfM5SZoTNAO9gfceycMRkG4/zMbPgFMgSbDcs+jrpl1OkC2BABOd/lfhzPsCNM7frqVU2ynHpm3jFIVE0JtInE2JZLcdBZ/4V4WKSWrxzBspNeT0TbdKCBrNyqXP2xIzLoJYNpvgrIk7iAJArS9tvi+jXg+JSRQhDvsMPUlmHNlQuZYnUAVwm2Ch95LwMYRLnqCbUZLfeH+OE4o/HHfcWCGMEuzF/eNNgPXEYL48o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyn/jepDkwLOIzxEwP+2HmXUgkUyYc87Xxj3KyGUQM4=;
 b=KSGztX+lRyervHn+gUPc4Ez2TVmelDFstQnBvdqpZYCT/Ru/MKfnSkoaYsbVsB4h+Mp1YVUjrSjbwcIrIxpzmtZq4AcYzJdvDcIdF6VT9KSeeMzaOu9jIeMzwvbe8aIrwYhDO7s4ssc5MCTZ/rxE9K5OXtT3lSn1SThi/hFTFpo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS7PR01MB17453.jpnprd01.prod.outlook.com
 (2603:1096:604:43f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 13:36:40 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:36:40 +0000
Date: Wed, 25 Nov 2026 14:36:18 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Message-ID: <awbkUiagA_n9z521@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS7PR01MB17453:EE_
X-MS-Office365-Filtering-Correlation-Id: 806b6819-f65b-47c4-e201-08df4af92298
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|366016|7416014|376014|1800799024|260925022911599003|260925021311599003|38350700014|10067099003|261028144727099003|261021121427099003|11063799006|261022105027099003|260925021911599003|4143699003|56012099006|261026121527099003|261021123027099003|261026140227099003|261102123227099003|261022075727099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: JTqiYlNWIYibLStEPz4ENGxRluF7pg9AE21WrMmzy1AvRetA6tmdzDWe0pUPrbnYx0FkPwTf8MXPDLhUC++tTrvIa5VBwaL3gK2kRlof8oEsJfK615P0MgRYPJaK56fT9ZVjKley3yO8p7wJcmatoUgP2BfoozyVlT51R1U1sSe7uFZaBEZv3qF9Ai4OzC6hO7NXiFXao0ZK4C1WlnzFjZhlqOrz5aDpHk9DsJEt3q0wCneHSjsGR4c34Wm2vJycEO//tv2zhvO/te6ixhlzSRjbTjxPusrNT2Ghk/3y46wERiP2grZ37ndC+BEyRUyfnmNJPrIG7CGZqoJb0vRqigc34VT1Rbz6ejqNLpDTFbREYBcojTouU4e2AFby+PGIOpA2c+3eb/hArRWOqMcz4L/9JX4jABOQ/HvRVTtZavo+HPTd0TA5qpNxVHOh9ko6ZmPQky4TYET4KPijXU6lHoFsS+mfxIR71RwSowB0EM8hfKthm8PEav68R8wpYZ/jhz/AQ3IB028QACkX2mTz2DoGt9amZQHzkKVbtz/4rdErNtJtlguLxLpwIiqpi8C9FizttjowpZ9p1TsxXpUuWP1PYuOYUO9tlwmI59/QagbXL93r19RKT3KbQ+iia1vBkJjbK7bAComNs2rY+zGJg9ocZBX9dbyA0B8+tCGPetxPVfvXbHp4OcUMSoL4aqub5JaBSqM54DNuImJ/KlME1HEE0t1jBwWnCQJaMF9qD5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(366016)(7416014)(376014)(1800799024)(260925022911599003)(260925021311599003)(38350700014)(10067099003)(261028144727099003)(261021121427099003)(11063799006)(261022105027099003)(260925021911599003)(4143699003)(56012099006)(261026121527099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022075727099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a1jRxZlY0FHn9ZcQH8JxorwcPtXisFZ8RmcsHyp/KHrxYCudG4u81qyEpw?=
 =?iso-8859-1?Q?WxiYo+PuHcT0iPW5nfoYS+p6YsUZRX+EgdrHg/cgK493aFbxe6cZY/6xNO?=
 =?iso-8859-1?Q?SbprrF8R6gOMC+OCXY3/CUUtOk8ApGEMsZMEuyTgjjO7hwkK/RMFzRwGMF?=
 =?iso-8859-1?Q?75bO7rppfCJ/0ySrPt3/aq/hjFL3vouv4tx5ZHfD8f4dRqaDRLBX9dniIh?=
 =?iso-8859-1?Q?4u0eHZ8WF30+hMwIvtJsY3GvUWzzNiQHoZWwqTDGDc/hOHagKp4tuGnL1u?=
 =?iso-8859-1?Q?dAJLWczdsm29oy+TISs5EYjcr67lGnQ50oRn11htuAri4aVP5ws1rDerHk?=
 =?iso-8859-1?Q?FurGvXOqVn/HWpYvYJAlStvIJsD68o/lCcHOcaR9FlmUGftw3+op1SxGqj?=
 =?iso-8859-1?Q?KglUhcqOU30Zyou9Alii6R9zYORa82mdf1Gz3UHjOmMSAjSETiFADS5FQc?=
 =?iso-8859-1?Q?Hc3MkGKKrPa1yAx7YvlV4tslzawgG4RfYOR2+eV9+eA+1+Cqke0BR0g+9P?=
 =?iso-8859-1?Q?3hIRKGwNDBI8JRG3EUhBGXMxEBdrku9+amxbSfRtiLf5rEUu4QImBdBOw6?=
 =?iso-8859-1?Q?x19bGE6UCEqOG5Hy2BslQLsQK4SV1B9OTmHBDS4R29gkjvHTQ3LvA2stgP?=
 =?iso-8859-1?Q?S/oQX+xfejzwd953Zud4vRue2SgGL0dbA+UHFDZVEvtRyiTN2WK79PBzrO?=
 =?iso-8859-1?Q?P4AvAqtOua1CAubI4YgMuQrSBKkCeV37A7KXivfbEDi0jyUOLJdiNRir2c?=
 =?iso-8859-1?Q?YUoa64k7obczHq+FdXfh5OTQVWmj0XMFjqY0uz/wnt/LjWSjIBD2blJS/b?=
 =?iso-8859-1?Q?yole2BUyOP216Ws5qh0PVX1qWuMSQb7pUXyb3g8GA+UTfNipeoGarZfdRs?=
 =?iso-8859-1?Q?VrH7UMQoGJpWjBldezxpwr0PrZTlLkvGgy1jdrzdEftgKYkQE4qVTl5m7m?=
 =?iso-8859-1?Q?4TSQ36g2eMPaYjIeglq1ZXZEoDGYvGNXQz/rjR5fPSXjrnrCROuB1KFFu6?=
 =?iso-8859-1?Q?thJlPpGggmwJjpEYep1ueNQbtGcY+kSGabbvgiVeQWlRZKUk7wJf6Ujhc4?=
 =?iso-8859-1?Q?f9rpcvVny2pM+BEez5TE9nvSQ0fmFaiTydmIrzSXPej9IzLt9rWuaGoOky?=
 =?iso-8859-1?Q?FU+j6b8HFuKLtt0sGT1tUOsuCOBuvXISs6r4NhCuEV8oQWlAZ9Urt4ND8K?=
 =?iso-8859-1?Q?Nt+hbnsb8kIoEnrOpZAbvI+QngGDrxJL12alj8ceg17lrGwwzBHIoUP3FQ?=
 =?iso-8859-1?Q?K8/144jEn42rpkkyjOm/Caza3ZUO1XN9T3ppPRbBNLmQIWqiuppgDTPNgT?=
 =?iso-8859-1?Q?NCObr8LQpiGQlCPqq9ABh+bNBmt73HsvrGuF22yb86h5ib5YrMtkoHwGXF?=
 =?iso-8859-1?Q?/GkWn3xqB1J9NrWieP5Xgt2MAUEKVeOw78g7yYjXCtXoCZazycdBRMpoKU?=
 =?iso-8859-1?Q?My72RXroOLA3yiQdJuHJPQ2Ify5bB6nGT35JCug2bMDbT7/MDxOKH+0n1G?=
 =?iso-8859-1?Q?VaBqZmuQh2Hj0TIJS0PxqiDSmeuM30i28u5+rKHqJy0/wrhiPzMTYik1x2?=
 =?iso-8859-1?Q?IlrI+PWbCYoArA225DSxX71Bu3dT180fjadWjNti5HHlpHCZiimtF4tut4?=
 =?iso-8859-1?Q?2S2BUyhH3XrFWqFWR2U/TOQlHOA0HHrruILgDMi4XhDTp+NVjoHryZTZA5?=
 =?iso-8859-1?Q?4+7nzM4YtSVexIH/IVHbyq0Q5SSDk1xVvUAohMkQoAB2rfW3LqdlFEEMuD?=
 =?iso-8859-1?Q?27MdrfOE1VdvdfHS60bI64WE/hnr/sFEH6/58GJ1jlzc+Wm8o0A7U4HD5R?=
 =?iso-8859-1?Q?enFkGGEK6QxJo74KBaGuQSO6/jz8RGDMorEyPHB5B0TExx/IRqNY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806b6819-f65b-47c4-e201-08df4af92298
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:36:40.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kJ69U5GclAwyhfVB2Q3nsP0TQYBCxTfl/a7T1dcqp4olVj2MxzLguGMTHUjJtF6sSDfaXMWtlSFwqChf6F/rmaLvtq97/m8eoFq/GccJ3WU56uggwO5a8oOWzREQaDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17453
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biju,

On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 14:53
> > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > Hi Biju,
> > 
> > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 13:59
> > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > DU instances in one DRM device
> > > >
> > > > Hi Biju,
> > > >
> > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 24 November 2026 11:53
> > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > several DU instances in one DRM device
> > > > > >
> > > > > > Hi Biju,
> > > > > > Thanks for your review.
> > > > > >
> > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > > Hi Tommaso,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > > several DU instances in one DRM device
> > > > > > > >
> > > > > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > > > > >
> > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component
> > > > > > > > framework for it. The first available
> > > > > > DU
> > > > > > > > instance is the master and creates the DRM device, the other one binds to it as a
> > component.
> > > > > > > >
> > > > > > > > If only one DU instance is available, it creates the DRM
> > > > > > > > device directly at probe time, as on SoCs without the flag.
> > > > > > > >
> > > > > > > > Set the index of each instance to the number of CRTCs already created.
> > > > > > > >
> > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > ---
> > > > > > > > v9->v10:
> > > > > > > >  - New patch.
> > > > > > > >
> > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > >   */
> > > > > > > >
> > > > > > > > +#include <linux/component.h>
> > > > > > > >  #include <linux/dma-mapping.h>  #include <linux/module.h>
> > > > > > > > #include <linux/of.h> @@ -14,10 +15,12 @@
> > > > > > > >
> > > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > >  #include <drm/drm_drv.h>
> > > > > > > >  #include <drm/drm_fbdev_dma.h>  #include
> > > > > > > > <drm/drm_gem_dma_helper.h>  #include <drm/drm_managed.h>
> > > > > > > > +#include <drm/drm_of.h>
> > > > > > > >  #include <drm/drm_print.h>
> > > > > > > >  #include <drm/drm_probe_helper.h>
> > > > > > > >
> > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > +	int ret;
> > > > > > > >
> > > > > > > >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > >  	if (!rcdu)
> > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > >  	rcdu->mmio = du->mmio;
> > > > > > > >  	rcdu->ddev = ddev;
> > > > > > > >
> > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > +	rcdu->index = ddev->mode_config.num_crtc;
> > > > > > > > +
> > > > > > > > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > +	if (ret < 0)
> > > > > > > > +		return ret;
> > > > > > > > +
> > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > > > > > > > +				  void *data)
> > > > > > > > +{
> > > > > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > > > > > > > +
> > > > > > > > +static const struct component_ops rzg2l_du_instance_ops = {
> > > > > > > > +	.bind = rzg2l_du_instance_bind, };
> > > > > > > > +
> > > > > > > >  /* -----------------------------------------------------------------------------
> > > > > > > >   * DRM device
> > > > > > > >   */
> > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > >  	struct drm_device ddev;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > > > > +has_components)
> > > > > > > >  {
> > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > > > > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > >  	if (ret < 0)
> > > > > > > >  		goto error;
> > > > > > > >
> > > > > > > > +	if (has_components) {
> > > > > > > > +		ret = component_bind_all(dev, ddev);
> > > > > > > > +		if (ret < 0)
> > > > > > > > +			goto error;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > >  	ret = rzg2l_du_modeset_init_finish(ddev);
> > > > > > > >  	if (ret < 0)
> > > > > > > >  		goto error_fini;
> > > > > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device
> > > > > > > > *dev)
> > > > > > > >
> > > > > > > >  error_fini:
> > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > +	if (has_components)
> > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > >  error:
> > > > > > > >  	/*
> > > > > > > >  	 * Don't use dev_err_probe(), as it would overwrite the probe
> > > > > > > > deferral @@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > >  	return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > > > > +has_components)
> > > > > > > >  {
> > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > >  	struct drm_device *ddev = du->ddev; @@ -254,6 +285,83 @@
> > > > > > > > static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > +
> > > > > > > > +	if (has_components)
> > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > +
> > > > > > > > +	du->ddev = NULL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > +---------------------------------------------------------------
> > > > > > > > +--------
> > > > > > > > +------
> > > > > > > > + * Component master
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > +
> > > > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > > > +	rzg2l_du_drm_fini(dev, true);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct component_master_ops rzg2l_du_master_ops = {
> > > > > > > > +	.bind = rzg2l_du_master_bind,
> > > > > > > > +	.unbind = rzg2l_du_master_unbind, };
> > > > > > > > +
> > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > > > > > +	struct component_match *match = NULL;
> > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > +	struct device *dev = du->dev;
> > > > > > > > +
> > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > +
> > > > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > > > > > > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > > > > > > > +		if (!of_id || of_id->data != du->info)
> > > > > > > > +			continue;
> > > > > > > > +
> > > > > > > > +		/* The first available DU instance is the component master. */
> > > > > > > > +		if (!du->is_master) {
> > > > > > > > +			if (np != dev->of_node)
> > > > > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > > > > +
> > > > > > > > +			du->is_master = true;
> > > > > > > > +			continue;
> > > > > > > > +		}
> > > > > > > > +
> > > > > > > > +		drm_of_component_match_add(dev, &match, component_compare_of,
> > > > > > > > +np);
> > > > > > >
> > > > > > >
> > > > > > > The master is chosen purely by DT order. If the first available DU
> > > > > > > never probes, the second never gets a DRM device. How do you handle this case?
> > > > > >
> > > > > > All available instances are part of the component match, so the DRM
> > > > > > device is only created once all of them have probed, whichever one
> > > > > > is the master.
> > > > > >
> > > > > > This is how the component framework works.
> > > > > >
> > > > > > To use a single DU, the other one can be disabled in DT, in this
> > > > > > case the remaining instance becomes the master and initializes the
> > > > > > DRM device on its own.
> > > > >
> > > > >
> > > > > Assume both DU's available and run time
> > > > >
> > > > > second DU is probed first and master never probed at all.
> > > > > What is the state of second DU as bind never calls?
> > > >
> > > >
> > > > The second DU probes, registers itself with component_add() and stays idle, without touching the
> > > > hardware.
> > > >
> > > > When the master probes, both instances are bound and the DRM device is created.
> > > >
> > > > If the master never probes, there is no DRM device, because the bind is only triggered once the
> > master
> > > > has registered the aggregate device with
> > > > component_master_add_with_match()
> > >
> > > Not sure is it the normal use case? DU0 and DU1 are independent devices
> > >
> > > 1) DU0 or DU1 should work independently irrespective of the probe failure of
> > >    other device
> > >
> > > 2) When both DU's are probed, then we need to aggregate the device using component
> > >    framework so that use case like dynamically switching DSI0 to DSI1 can be achieved.
> > 
> > IMHO 1) and 2) can't be achieved together.
> > 
> 
> I guess we can achieve both use cases, if we define a companion property in the second device.
> This is a static design choice left to the DT user to choose between either 1 or 2.
> 
> Krystof/Rob/Conor: Is it ok to add optional companion property to support both
> 1 and 2? Otherwise, we plan to stick with use case 2.
> 
> Use case 1: 1 DRM device per DU

Some clarification:

For 1)

Just FYI, the series already supports this when only one DU is enabled
in DT. If only DU0 (or only DU1) is enabled, it creates its own DRM
device directly, without the component framework, and we will get 1 DRM
device with 1 CRTC.


# r9a09g047e57-smarc-du0-dsi.dtso

&du0 {
	status = "okay";
};

&du1 {
	status = "disabled";
};

logs:
------------------------------------------------------------------------------

root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000001      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      57      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      57      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch


# r9a09g047e57-smarc-du1-dsi.dtso

&du0 {
	status = "disabled";
};


&du1 {
	status = "okay";
};


logs:

---------------------------------------------------------------------------

root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000001      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      57      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      57      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch

> Use case 2: 1 DRM device for 2 DU's

For 2)

When both DU0 and DU1 are enabled, DU0 registers the aggregate device with
component_master_add_with_match() and DU1 registers itself with
component_add(). Both are driven by the same DRM device, with 2 CRTCs.


&du0 {
	status = "okay";
};

&du1 {
	status = "okay";
};

logs:
------------------------------------------------------------------------

root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000003      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      71      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0
60      0       (0,0)   (0x0)
  #0  nan 0 0 0 0 0 0 0 0 0 flags: ; type: 
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      71      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
50      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        52 alpha:
                flags: range
                values: 0 65535
                value: 65535
        53 zpos:
                flags: range
                values: 0 1
                value: 0
        54 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
55      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        57 alpha:
                flags: range
                values: 0 65535
                value: 65535
        58 zpos:
                flags: range
                values: 0 1
                value: 1
        59 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch


Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
