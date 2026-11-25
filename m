Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0435606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Czb+06O8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82EB10FC91;
	Wed, 25 Nov 2026 14:14:16 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011003.outbound.protection.outlook.com [40.107.74.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75FB10FC93
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZuHygCEsUlLgpjft9a/oj8jKV17bohmWJkhaBNVIq24JlpwEJrzkocy9rv0Bv+jyJTl2xY7S+E9BaUfB06GOLf5e5ESvxgnO81HIJRA4cfQTCXDV6uuMtzHRKiw/kPAuEau+A00h/s25cV4//BSznrq9o5GxPCin1wV6cWp864Zcp9orWXkRd+QAWe1gOk59sYISuYx5nG26pFpB0lKnie5J9FO01oByrywBQaio6zyrttvpKC8rXBeiPkkKj4c+QyDSAHxwS6cpNuGuJwecgqr63W10vg3MRgNdhEfwGKbY504KeH2c4HNG2STmfvJL3krw/AoLEdaX/mb/jY23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sNwLQO8gieO/OxCrjEULpHsGcaeURtY2PJ76wUMQHA=;
 b=m3boyhwIFjewnDy5ubwbr6xSq3rGtSRzXY/2405/tWdMpZamMhNWC5qveJwIkuw4yi8evysjiaFfN2y+dUh/MZNSTDijEHXukbgLRAm1u0RrkAEsiHt/9nzMyaBdqjypdfzXrxUAACiEuqtgUXpa8ANmX8dBEmxO0vcqkOlfSRzpgIkLKsgcZQ3QwGmmKgVRSo3E0CkcPDXG902e/+n9tsI/1SqxSfTsCtN1hC83LBbWoY1zYEk5KdAtkAOR9fRl309Vybk0v0+p+Zbn0wnVsljgj0GcCnXk/x2oLDYkOj//W6G32OXaeoMjQs5rkcPcr+JLsIfvtXzVMF47J20rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sNwLQO8gieO/OxCrjEULpHsGcaeURtY2PJ76wUMQHA=;
 b=Czb+06O8+ZlctQCQ3tOy1w9WRGppfH7KksUgI10Hc7DcqOWGw4a6I8LLagVaH4f/lztgamn34BesTeWtuJLwzQzdWOO8wGU3q24VY8aojyiY6udEQl0/TfOUqooZip/Ds/rQBzbxl+NWrhGq+eMfoYvIs252aLlnB54KyUhITWM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSZPR01MB8815.jpnprd01.prod.outlook.com
 (2603:1096:604:159::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 14:14:05 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 14:14:05 +0000
Date: Wed, 25 Nov 2026 15:13:46 +0100
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
Message-ID: <awbtGl7FghBWsW2C@tom-desktop>
References: <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbkUiagA_n9z521@tom-desktop>
 <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSZPR01MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f121f0-355d-44bf-2691-08df4afe5d2e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|38350700014|10067099003|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003|261009221727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ihiYsFkUtmsK8SNRUtMuqZey5JAc99FSfdoPDI9GJYMoME359ASafLToc2TJp07JdYMdLwK5B4hrd9J4Bv6Xhy0KFx4WDuOMOUvCY6G3KlHqkGyo58BqfSwAEH3+HRizdGuiFo75cIx8fxHkEKOdeZTVNbQSHADr1Mvdtx4NwXlGGLyCIdU7v0MRA7YLWdtCD1l2W5mfMUDM92QfP3lxOHY96mtR9G8m+nYilJcO3/+0CE5SNhAhT2XlarHuWl+lcJLbaBUJs0tGaJfFLMs1ub7rOFUTy+9VKOGCx/0vDAEh/bnRn9u6YT8nJFIJnOuroaJd4EiD32sEQth84987PhAaUKv7mei3sMnbI2BmcZvbSIOwh51fYmaoTV7Z5/W2n7g+05NQ9vDr807sRxkSoWNgYtNlNEAiAUNbrWiqtN+BnB8MNm7bXBVSD38afbGTmtCJYPZOsI2cmAtMkJc7uMO/1lPQWGSsFpiceTLOMW/X1eCqE2MR5LecBSEA+zVNzv4ui+zTM0MT+QDLUsvpsZ+RjGhjXrKwfHVSyp4ND4I384To/uEr0QSUgPsJ9/9DqANpuxWqQdF4UicGUYbbxiZtOjelgIifrhHhxC3PPqKQA/Ce9PwA3RQe9ivPmP/iujfI7YP1zY0abBm53+7Uz0y+em1/eRJFc44iFESQ1Cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(38350700014)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MTjjLXLyOKRe8Viwq0nRg7YwbF2xj+uEIZ+YKwA7zt8zemeaJy/mJev9kj?=
 =?iso-8859-1?Q?1yPrl/Q04yGfucpvsSGqBsDPpJe4NBAowOt3vAfvhdSiU8L3n2hR4cfkzN?=
 =?iso-8859-1?Q?9EGe7ncqlk7I5DQH/0CXY2csALMWaBPah+5WMx84Zr22OafAjZzfe7bTT8?=
 =?iso-8859-1?Q?xLBQ5VlizAU6nljo/rZ3Ggy64hbuk0pPdaQf+8Y5HJluUDN0y6roepJG3s?=
 =?iso-8859-1?Q?CDwcx7p1GRa79Dr5Ai2Jvpqi++jjf0a4bUq021HjnZiXhm9Jlad6GLBzei?=
 =?iso-8859-1?Q?bGaWmrdF3ZiPEa2lj7xOcwqoOlFLB7bz7W9qAKpI58uUhFRK8kO0jyxBFA?=
 =?iso-8859-1?Q?M1hBoacc8582lb/aiB3C7iA0iZBfm2h89Kdq8ck6xG1r1TFOuyYV3eZ8/Y?=
 =?iso-8859-1?Q?h9dD0KHY+YBRzi0P7qAzLmmbx1cwlPxpIoLRUbqqCsRkXp6Tw1huiMG15O?=
 =?iso-8859-1?Q?9DeLRiySxb+zzSWgDagjeS0Qni8DeRuMZ4HKC8YBsYPirhdV1rYyiB1I/b?=
 =?iso-8859-1?Q?CycWxitZYCzHFfu9wcOmRxfGrItT+FR1pn/2mwxsRPt1JpheZesfkjPBiN?=
 =?iso-8859-1?Q?xx89H0UM0iw02r1ipz7OgI1ZO5LIJjfJcmm4Kfo1PVCr4DcYLgb4EtLy7W?=
 =?iso-8859-1?Q?FuIAvPMdQtZBNlhTqLjQQFh7G/VTSzIepHR1NLV+8kvKEn0O9Nb/aMbYNm?=
 =?iso-8859-1?Q?czeQ6Di3lTM+IMhi/O1V9eiR+ekWBfF+cptMKo0GeJkxF1RNLmeHHnrguD?=
 =?iso-8859-1?Q?HTc0rL+evwx1/YneadbZZWO62nLTavmKkK1KkeNBBeQWlBvbCq4vDfKtU1?=
 =?iso-8859-1?Q?SD8UzmORGqDePvj3ldyPJDouzRG4xnrSMoFeOJRqo2c4sDcPTKDSZQUA2Y?=
 =?iso-8859-1?Q?aV5etW843X7/SJ9chb4V7ddlD3nMmRtrzbbN8cFQLzZjfsZYEafwtOZBOH?=
 =?iso-8859-1?Q?ciSysyUJKM5JxxQKqoYcL4B7qv/94QzljNl6PRCK4NHExT4UoEFsBvDbBR?=
 =?iso-8859-1?Q?17B9/9dfsjESNebiPO5jkOzIjA4MyCy6/A0m0y5pzoMv4+P0wd67rk92Q8?=
 =?iso-8859-1?Q?JVz++ReAOi239Ui5kv91VJTuYNc70m0PxISwp7E7vVxUrK60NI+jz+abWh?=
 =?iso-8859-1?Q?YQoWlNCNmJkP69bmG/ewIpocZGK3NSSySXh+Fz9d92h/e6y5dHhh57x2h1?=
 =?iso-8859-1?Q?9Y3TRe47eYdC2PUWnKOh/2NfZLEjY8+fNKcB04RS8rZDYWwq0FGG9Vzs+m?=
 =?iso-8859-1?Q?oEwKnEvvsWHk0YwhVFiNBIfvFZdnfojxCcPsth+j7hIDxIbh2+TBE9Jd6s?=
 =?iso-8859-1?Q?+NEUIoiRON6ot3wlUMMf91t6kWhaW6pVuYMsrj4u5owReOardC+l2mGy+b?=
 =?iso-8859-1?Q?QP6pN7C2NknyRVKvie9ilgsyJwOPX6LvxkaTBBWnCkhZ67NHyxTSth2AC2?=
 =?iso-8859-1?Q?5MmU3yQ+1DrmU+pgF4fA8rezwop6nG61zpM4n6701fEZHwYDZiLwoEN+yH?=
 =?iso-8859-1?Q?+UOh7HDzSPFguQnYTIRZlpI7JJiNaU/5Z2cBT07SQ2JpmrdjdpCuK0jUgS?=
 =?iso-8859-1?Q?RDspttrI2tPnEM1DGb0bogbRg/VoZNbCnfeElg/aKF9o12WxmP6acgkJTK?=
 =?iso-8859-1?Q?9KSBY9BSSh+sRM94zRp+xDpXhbILbkY8tY0sDBzkP+GjyCsc+y4JTdIZtK?=
 =?iso-8859-1?Q?QEzfZqx4FiEewUM7lXd1FUvE2RZ2I1RID5aI9MboMpyhFZ3HIyZHRENNUd?=
 =?iso-8859-1?Q?SKvoi/8cHadeWiCdRRYr3OjCW/PVpya8l/l9T1L+KW2Ifg5A236RiXI1b6?=
 =?iso-8859-1?Q?V0NsU/Rqk0+vPAeUt4C8rkYtZYqK36HtkdrfpIv6eJs4n/G6Fkuy?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f121f0-355d-44bf-2691-08df4afe5d2e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:14:05.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dsPwqwFgSx0XxH8bPPK/Kk8AXGoJR9Uz0XTaefDX6WiUBnxTMPIlKbC1SxRlBFKOwDJlDGkS0TtZHF2mOSsjJ9PlkIfjYMR+cn3a7g3HbHjNFQ+B7eCTUxLmkqI89Ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8815
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

On Wed, Nov 25, 2026 at 01:45:46PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 25 November 2026 13:36
> > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > Hi Biju,
> > 
> > On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 14:53
> > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > DU instances in one DRM device
> > > >
> > > > Hi Biju,
> > > >
> > > > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 24 November 2026 13:59
> > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > several DU instances in one DRM device
> > > > > >
> > > > > > Hi Biju,
> > > > > >
> > > > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > > > Hi Tommaso,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > Sent: 24 November 2026 11:53
> > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > > several DU instances in one DRM device
> > > > > > > >
> > > > > > > > Hi Biju,
> > > > > > > > Thanks for your review.
> > > > > > > >
> > > > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > > > > Hi Tommaso,
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > > > > several DU instances in one DRM device
> > > > > > > > > >
> > > > > > > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > > > > > > >
> > > > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the
> > > > > > > > > > component framework for it. The first available
> > > > > > > > DU
> > > > > > > > > > instance is the master and creates the DRM device, the
> > > > > > > > > > other one binds to it as a
> > > > component.
> > > > > > > > > >
> > > > > > > > > > If only one DU instance is available, it creates the DRM
> > > > > > > > > > device directly at probe time, as on SoCs without the flag.
> > > > > > > > > >
> > > > > > > > > > Set the index of each instance to the number of CRTCs already created.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > ---
> > > > > > > > > > v9->v10:
> > > > > > > > > >  - New patch.
> > > > > > > > > >
> > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > > > >   */
> > > > > > > > > >
> > > > > > > > > > +#include <linux/component.h>
> > > > > > > > > >  #include <linux/dma-mapping.h>  #include
> > > > > > > > > > <linux/module.h> #include <linux/of.h> @@ -14,10 +15,12
> > > > > > > > > > @@
> > > > > > > > > >
> > > > > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > > > >  #include <drm/drm_drv.h>  #include
> > > > > > > > > > <drm/drm_fbdev_dma.h>  #include
> > > > > > > > > > <drm/drm_gem_dma_helper.h>  #include <drm/drm_managed.h>
> > > > > > > > > > +#include <drm/drm_of.h>
> > > > > > > > > >  #include <drm/drm_print.h>  #include
> > > > > > > > > > <drm/drm_probe_helper.h>
> > > > > > > > > >
> > > > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > > > +	int ret;
> > > > > > > > > >
> > > > > > > > > >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > > >  	if (!rcdu)
> > > > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > > >  	rcdu->mmio = du->mmio;
> > > > > > > > > >  	rcdu->ddev = ddev;
> > > > > > > > > >
> > > > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > +	rcdu->index = ddev->mode_config.num_crtc;
> > > > > > > > > > +
> > > > > > > > > > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > +		return ret;
> > > > > > > > > > +
> > > > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +	return 0;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > > > > > > > > > +				  void *data)
> > > > > > > > > > +{
> > > > > > > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev),
> > > > > > > > > > +data); }
> > > > > > > > > > +
> > > > > > > > > > +static const struct component_ops rzg2l_du_instance_ops = {
> > > > > > > > > > +	.bind = rzg2l_du_instance_bind, };
> > > > > > > > > > +
> > > > > > > > > >  /* -----------------------------------------------------------------------------
> > > > > > > > > >   * DRM device
> > > > > > > > > >   */
> > > > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > > > >  	struct drm_device ddev;  };
> > > > > > > > > >
> > > > > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > > > > > > +has_components)
> > > > > > > > > >  {
> > > > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > > > >  	struct rzg2l_du_drm *rzgdrm; @@ -213,6 +236,12 @@
> > > > > > > > > > static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > >  	if (ret < 0)
> > > > > > > > > >  		goto error;
> > > > > > > > > >
> > > > > > > > > > +	if (has_components) {
> > > > > > > > > > +		ret = component_bind_all(dev, ddev);
> > > > > > > > > > +		if (ret < 0)
> > > > > > > > > > +			goto error;
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > >  	ret = rzg2l_du_modeset_init_finish(ddev);
> > > > > > > > > >  	if (ret < 0)
> > > > > > > > > >  		goto error_fini;
> > > > > > > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct
> > > > > > > > > > device
> > > > > > > > > > *dev)
> > > > > > > > > >
> > > > > > > > > >  error_fini:
> > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > +	if (has_components)
> > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > >  error:
> > > > > > > > > >  	/*
> > > > > > > > > >  	 * Don't use dev_err_probe(), as it would overwrite
> > > > > > > > > > the probe deferral @@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(struct device
> > *dev)
> > > > > > > > > >  	return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > > > > > > +has_components)
> > > > > > > > > >  {
> > > > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > > > >  	struct drm_device *ddev = du->ddev; @@ -254,6 +285,83
> > > > > > > > > > @@ static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > +
> > > > > > > > > > +	if (has_components)
> > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > +
> > > > > > > > > > +	du->ddev = NULL;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +/*
> > > > > > > > > > +-------------------------------------------------------
> > > > > > > > > > +--------
> > > > > > > > > > +--------
> > > > > > > > > > +------
> > > > > > > > > > + * Component master
> > > > > > > > > > + */
> > > > > > > > > > +
> > > > > > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > > > +
> > > > > > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > > > > > +	rzg2l_du_drm_fini(dev, true); }
> > > > > > > > > > +
> > > > > > > > > > +static const struct component_master_ops rzg2l_du_master_ops = {
> > > > > > > > > > +	.bind = rzg2l_du_master_bind,
> > > > > > > > > > +	.unbind = rzg2l_du_master_unbind, };
> > > > > > > > > > +
> > > > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > > > > > > > +	struct component_match *match = NULL;
> > > > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > > > +	struct device *dev = du->dev;
> > > > > > > > > > +
> > > > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > > > +
> > > > > > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > > > > > > > > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > > > > > > > > > +		if (!of_id || of_id->data != du->info)
> > > > > > > > > > +			continue;
> > > > > > > > > > +
> > > > > > > > > > +		/* The first available DU instance is the component master. */
> > > > > > > > > > +		if (!du->is_master) {
> > > > > > > > > > +			if (np != dev->of_node)
> > > > > > > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > > > > > > +
> > > > > > > > > > +			du->is_master = true;
> > > > > > > > > > +			continue;
> > > > > > > > > > +		}
> > > > > > > > > > +
> > > > > > > > > > +		drm_of_component_match_add(dev, &match,
> > > > > > > > > > +component_compare_of, np);
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > The master is chosen purely by DT order. If the first
> > > > > > > > > available DU never probes, the second never gets a DRM device. How do you handle this
> > case?
> > > > > > > >
> > > > > > > > All available instances are part of the component match, so
> > > > > > > > the DRM device is only created once all of them have probed,
> > > > > > > > whichever one is the master.
> > > > > > > >
> > > > > > > > This is how the component framework works.
> > > > > > > >
> > > > > > > > To use a single DU, the other one can be disabled in DT, in
> > > > > > > > this case the remaining instance becomes the master and
> > > > > > > > initializes the DRM device on its own.
> > > > > > >
> > > > > > >
> > > > > > > Assume both DU's available and run time
> > > > > > >
> > > > > > > second DU is probed first and master never probed at all.
> > > > > > > What is the state of second DU as bind never calls?
> > > > > >
> > > > > >
> > > > > > The second DU probes, registers itself with component_add() and
> > > > > > stays idle, without touching the hardware.
> > > > > >
> > > > > > When the master probes, both instances are bound and the DRM device is created.
> > > > > >
> > > > > > If the master never probes, there is no DRM device, because the
> > > > > > bind is only triggered once the
> > > > master
> > > > > > has registered the aggregate device with
> > > > > > component_master_add_with_match()
> > > > >
> > > > > Not sure is it the normal use case? DU0 and DU1 are independent
> > > > > devices
> > > > >
> > > > > 1) DU0 or DU1 should work independently irrespective of the probe failure of
> > > > >    other device
> > > > >
> > > > > 2) When both DU's are probed, then we need to aggregate the device using component
> > > > >    framework so that use case like dynamically switching DSI0 to DSI1 can be achieved.
> > > >
> > > > IMHO 1) and 2) can't be achieved together.
> > > >
> > >
> > > I guess we can achieve both use cases, if we define a companion property in the second device.
> > > This is a static design choice left to the DT user to choose between either 1 or 2.
> > >
> > > Krystof/Rob/Conor: Is it ok to add optional companion property to
> > > support both
> > > 1 and 2? Otherwise, we plan to stick with use case 2.
> > >
> > > Use case 1: 1 DRM device per DU
> > 
> > Some clarification:
> > 
> > For 1)
> > 
> > Just FYI, the series already supports this when only one DU is enabled in DT. If only DU0 (or only
> > DU1) is enabled, it creates its own DRM device directly, without the component framework, and we will
> > get 1 DRM device with 1 CRTC.
> > 
> > 
> > # r9a09g047e57-smarc-du0-dsi.dtso
> > 
> > &du0 {
> > 	status = "okay";
> > };
> > 
> > &du1 {
> > 	status = "disabled";
> > };
> > 
> > > Use case 2: 1 DRM device for 2 DU's
> > 
> > For 2)
> > 
> > When both DU0 and DU1 are enabled, DU0 registers the aggregate device with
> > component_master_add_with_match() and DU1 registers itself with component_add(). Both are driven by
> > the same DRM device, with 2 CRTCs.
> > 
> > 
> > &du0 {
> > 	status = "okay";
> > };
> > 
> > &du1 {
> > 	status = "okay";
> > };
> 
> DU0 and DU1 are independent devices.
> Currently if DU0 fails to probe, DU1 won't work.
> So, there is a limitation in the current design.

Mmmm, checking better the others vendor drivers I can see the same behaviour:
if one member of the aggregate fails to probe, the others won't work either.

mtk_drm_drv.c driver where we have vdosys0 and vdosys1 [1] that are
sharing the same drm device. And also in this case if one fails to probe
there is no drm device.

Same for rk3399-base.dtsi where we have vopl_out and vopb_out [2]
Same for imx6q.dtsi with ipu1_di0, ipu1_di1, ipu2_di0, ipu2_di1 [3]
Same for sun7i-a20.dtsi where we have fe0, fe1 [4]

Please correct me if I'm wrong.

[1] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/mediatek/mtk_drm_drv.c#L374
[2] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi#L245
[3] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/nxp/imx/imx6q.dtsi#L304
[4] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi#L254


Kind regards,
Tommaso

> 
> The proposal is
> 
> Usecase 1)
> 
> &du0 {
> 	status = "okay";
> };
> 
> &du1 {
> 	status = "okay";
> };
> 
> Usecase 2)
> &du0 {
> 	status = "okay";
>       companion = <&du1>
> };
> 
> &du1 {
> 	status = "okay";
> };
> 
> In this design,
> 
> Based on DT design, 
> 
> User can have 1 DRM device per DU
> 
> Or
> 
> 1 DRM device for 2DU's
> 
> Cheers,
> Biju
