Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94199606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ckvwpvTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE54B10E074;
	Wed, 25 Nov 2026 17:08:39 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E7810E074
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUSe8E+nPBGleQyQZE6uvGOO0M5KVeHRXTKneWwUCzkRtyrWeaS6DnNoQZGZxex1CmR4Zhw4CSvBRfEnvS1oFv7w+/hxDrQ6I5ky5xH5cHZtf7IVa3HHIwDamNXqsh5YA22ELvmntABuq+UZnqk1QhH21ZBKytRgxyeYS2DskrLzlTVgB4QXdfTQ7dwAbF5XfdY+6nVT9aS2JdGPhJeI2SgTDh2RyezsiHXUlpq0HYtE8oCp8MvJOMqptltMNY33LDf9KSnJMwK4joc5TYzDc8X0bqyBe8wAm7X9wLAjqj6yPtZLOFr4QtW1R7sgSftP1yvgaHEMJaF145isPdtj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVAJRqVIORPWOlUunoErCijSYHQBZ4X3Uw3Fj2IRAe8=;
 b=Do3gSmRrlu8RGKmqZHxr5tMt+U8+S1GcSg+/zpiTTqoDn34Jt/V7OqSIsv0rUehomzwq90GQTFeBND0hlM20j70rp3uBZcr/jbEHgtyfJlo8DC1DeydIynUMcV2EkkL8gQ5YYwDHX1uVveb8WESUlwOMWVPGdappOt4+f/5JSxeNi2umRBMTR93MlUXGFTC5O6AXKQSaCNnn/iUApLwPMlb5zPoKpxb7yKV9XM0awSUkrpeI0MVOsjpFuaIVkJCmY6b38h4THMfcwtL1XYIkUi0ur0Zq2+TStJU3R41/npSK63F16fBswlSAQ9N2ibPfEJvYkToWQS8xw6EPi7bRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVAJRqVIORPWOlUunoErCijSYHQBZ4X3Uw3Fj2IRAe8=;
 b=ckvwpvTj9QbaR/nb9yo27Ic7/UAZr+oyE2jDcgRH9Yzv0C7zRw3wkHIU6E3+9FhF65Aw4sSuRC5EGirkAxowvKKdcHpeSQctgBUq5b9l00IIGJJGk3xWhccIkRfkFm30iJG2Svi+y0QfEn1Adbaf+dfINo2skyF93tEClbhDM5Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB17123.jpnprd01.prod.outlook.com
 (2603:1096:604:45a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 17:08:29 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:08:28 +0000
Date: Wed, 25 Nov 2026 18:08:09 +0100
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
Message-ID: <awcV-el2FwqD6pC1@tom-desktop>
References: <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
 <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awbkUiagA_n9z521@tom-desktop>
 <OS3PR01MB65961475F4B3C1D5D781E7C486432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awbtGl7FghBWsW2C@tom-desktop>
 <TYYPR01MB6603FEBB7A68BE8A95F930D286432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB6603FEBB7A68BE8A95F930D286432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB17123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1d924f-fe1a-466f-ddba-08df4b16b9b8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|7416014|23010399003|4143699003|6133799003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261009220027099003|18002099003|22082099003|56012099006|10067099003|11063799006|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: H9pB+pd27Sh++10ZnrNgNlj6ZQDqu8r8Zl4TVl7I0Z3hkunoz+KLeJ1VviCKf9cm9RFxQ6+j/+Rj21OyQQBH9Z/sPixsURORNU+y4wjyoiPWB/w9Vnn5XGPgAAh+4+KVjBDQYYknXsNBfak/La2HA2d1LmHodco6ytBKGjsT7d8PXFjn67PIlrOooqhQ4mw/Z8So0yRS4e5YD9uilxYiwbSNkhUmy173CznsCEejOQs7alIpz2w2JUIaqQg1ksMT7m/+brlBY0oLS20+F65Bs1C2WkNRqWjc2lpzRStvffWDUkUr39588YNM0LZzspmldBAXq2o1i/uXZE8hJ+TryBr/pT9SBEtDom8JPBwd4/9cfbg1PgRjGl9v06DiK64Lj+FSYxKy1taMiD8OqTSrh2zvlHzp5K41ZXLxU8iz+jxud7Lrjr1MyCOEAfGzdDcSz32a0YrWRUSqoWmZUuxXam5DbSuprjCj9ifVApnwzjDIKxAX/q/+NQcEIjbNtRYsmtqhQJjIDnxrOn3u4v49CItlFNEoZxDyObvepgIGX/ll9VBoqSIULoKI+0JacKSugZAh4hEjKvHQwbXmajhPF0dfbFzWo/OZmyd/wNY9fqtms5Nb2BXAPz6iMYsAHUlvor63/OpZKP5YOfI4D7pSRFl/YRM1mhVTb8/aWQ+fvLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(6133799003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009220027099003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y0Vov0d8Tec/R7XrEAwLjGPu2pC9zEVOIcrh9h/yAezyARQGAONnsBzdPJ?=
 =?iso-8859-1?Q?VwXRkVQr8e6K5XPmsi5eOi0SQGk1XUy3oUDrao7HUmzdFtP7mg5/AsGuvv?=
 =?iso-8859-1?Q?JV5Y/uWA7RxUKKw8sRs5MJVqQfj5oHMjOCyqNZXza9N3Bi29d2a9mOLiLA?=
 =?iso-8859-1?Q?qnqR7xQFg9FFawCpGeI00bNFBgeU28ls50AKxTRJIIJndqBc38N/vI/IOl?=
 =?iso-8859-1?Q?GL0IINnmMb1Qm+Qgcrv6IMHn0SxhA1X6Vacy281sZ6+HXdR07UOwRhFTM6?=
 =?iso-8859-1?Q?mrg5dGHOlFmZASEuQWx3xov4zFjTaOA46OYFkHcGoNr8Jw4AQh+gni1N5c?=
 =?iso-8859-1?Q?CAE+PPQra+x/ivCKZ5lhUQbffpUlWEgXvqE0YZPASeq7BKj3xaeMNdY3Ga?=
 =?iso-8859-1?Q?uaUaNbIS3sTGaWN23c3LzY/GcPZ28Nbj7BRPo/WPXdK9fwHcLzxUMtjFBl?=
 =?iso-8859-1?Q?TnVzWGzchjJ8FkqfEr5HtbjOuNMueSsGzT73tG0sAK6mMJvF9mZU9q8J8V?=
 =?iso-8859-1?Q?0mFFdcCKGsNpRViU5EhrX5colwxYFf8UR0KrYtyOZZw98P25PrbuMcCRuf?=
 =?iso-8859-1?Q?zcY2MFQpW7xWaHwXS3W52jQdXzm6mK03L7wfafZa5XfFE6iAbyjnCPGuyF?=
 =?iso-8859-1?Q?/Ovb0ZczibnIdYJ/BfkDL4if3vZBbTYgr1+N/bvalf1d6Tc6pae6BIuRMN?=
 =?iso-8859-1?Q?YfqhKfDpa0sE8dkZhiI8AzOQ6PSpoO6i6Orcs6/X8lBtb+UNLRfaMq2QER?=
 =?iso-8859-1?Q?BdNVNZoFefzssVkPz0zsn9K8mW0e8ZSBR1PQzh9kqiVw4XQh4wWpZ8Kf/+?=
 =?iso-8859-1?Q?h+NvJJqFYPcKnuOeq2HNj2GyLw2KxhN6i2V2UBL0Bn3sz89HOUfItr79cO?=
 =?iso-8859-1?Q?aPsP1T377VTro7DHvrx0gSWR1iu9ntv1u/ioFDm0QSlsgWd1Ma1H8ILMl6?=
 =?iso-8859-1?Q?GG3b6xCIRbndM4jqdd+R7bo+6FCR8aPLQGEt87m+/SOeC0ckYyNmV5y8Kb?=
 =?iso-8859-1?Q?Hr9x1Q/ktBIgCBWABZ9LPJbD9bQ1DoE2+MC+0pcM+ud/gcJO26KnRn0jrE?=
 =?iso-8859-1?Q?a56Wj1vhNyryPR7Z/g0sDMDiQj1Yhq4WEolrESyagHB69J4IbiJSLKQiqS?=
 =?iso-8859-1?Q?4RRcoZgWkc6AH/n5W27Xo4zUf+VPpG8MDxMhUBajYqg7m02YdMdP1oGy5W?=
 =?iso-8859-1?Q?sP0E2Da/Mko8GDVBFcX6DHbbdVxieGHzAnq3W88x1oIONaAkA/QPlbL0JF?=
 =?iso-8859-1?Q?rsykC1HlSWEhdy/qf6JtmIqpz2fjTh172VA7eVQEv0TFMj64numkJLFSh9?=
 =?iso-8859-1?Q?5HqD7DMRU9sn5Rw59uMMoNqZNEwMAHd2bgDnhbnQqWARKjWXtUpfjnwDyD?=
 =?iso-8859-1?Q?N+kI8s8IJiMHr6azoifs24RYcd+lYLo/56JT5UNa9VPvbfcarlBrFDqzQc?=
 =?iso-8859-1?Q?oc6j9LyuAlewluQDs+44z45Qu0+yZk+fcmtgP3hpWJJyBHQJrul5Ab8Chb?=
 =?iso-8859-1?Q?jtIZ5Lr2oJnJqqZ7FttQMVukJcuzBXlmGAcxyzmnH6h/ikI9Ape9s+hL9x?=
 =?iso-8859-1?Q?dsoHQU2M/Pt8H4wi6RpSTLY/8XXcjYRA4uevbCNl/lhPCXjZKgK1JDcQOc?=
 =?iso-8859-1?Q?YZYEjykaePn/vp4ZXeJboDxtcXjR9negS/z2lbP7tCtOZNGR/US9g63e0d?=
 =?iso-8859-1?Q?Om0mTR7Wez2e402AmDZFILJ38bDROuPDdMieZzg9aIZex1x7qGlg50yhaa?=
 =?iso-8859-1?Q?UdZaW/qIUI2L5ey234AGKu+n+E8gq7hFL9LKmQ+r70LuzQ6JX9T+MTrXWL?=
 =?iso-8859-1?Q?SQgMCJxvN887ZAepKKOBb2dihMknJij2SOMi3cXnIqD92g+d9tzK?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1d924f-fe1a-466f-ddba-08df4b16b9b8
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:08:28.8803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFqLdT1INIbL+677NrCHpOlwhSWGsTjtf8GwqH1tAVzHArCImUsfFIkCezA+sHT/FcyI4KJx6M7w4P/E2eckQyjoPEPeE32p3LcAnY7kTx+5wRhupGeBtmi/ZrGS++Pf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17123
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

On Wed, Nov 25, 2026 at 03:42:43PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 25 November 2026 14:14
> > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > Hi Biju,
> > 
> > On Wed, Nov 25, 2026 at 01:45:46PM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 25 November 2026 13:36
> > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > DU instances in one DRM device
> > > >
> > > > Hi Biju,
> > > >
> > > > On Wed, Nov 25, 2026 at 07:28:17AM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 24 November 2026 14:53
> > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > several DU instances in one DRM device
> > > > > >
> > > > > > Hi Biju,
> > > > > >
> > > > > > On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > > > > > > Hi Tommaso,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > Sent: 24 November 2026 13:59
> > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > > several DU instances in one DRM device
> > > > > > > >
> > > > > > > > Hi Biju,
> > > > > > > >
> > > > > > > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > > > > > > Hi Tommaso,
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > Sent: 24 November 2026 11:53
> > > > > > > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > > >
> > > > > > > > > > Hi Biju,
> > > > > > > > > > Thanks for your review.
> > > > > > > > > >
> > > > > > > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > > > > > > Hi Tommaso,
> > > > > > > > > > >
> > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > From: Tommaso Merciai
> > > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du:
> > > > > > > > > > > > Support several DU instances in one DRM device
> > > > > > > > > > > >
> > > > > > > > > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > > > > > > > > >
> > > > > > > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the
> > > > > > > > > > > > component framework for it. The first available
> > > > > > > > > > DU
> > > > > > > > > > > > instance is the master and creates the DRM device,
> > > > > > > > > > > > the other one binds to it as a
> > > > > > component.
> > > > > > > > > > > >
> > > > > > > > > > > > If only one DU instance is available, it creates the
> > > > > > > > > > > > DRM device directly at probe time, as on SoCs without the flag.
> > > > > > > > > > > >
> > > > > > > > > > > > Set the index of each instance to the number of CRTCs already created.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > v9->v10:
> > > > > > > > > > > >  - New patch.
> > > > > > > > > > > >
> > > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> > > > > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c
> > > > > > > > > > > > index
> > > > > > > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > > > > > >   * Based on rcar_du_drv.c
> > > > > > > > > > > >   */
> > > > > > > > > > > >
> > > > > > > > > > > > +#include <linux/component.h>
> > > > > > > > > > > >  #include <linux/dma-mapping.h>  #include
> > > > > > > > > > > > <linux/module.h> #include <linux/of.h> @@ -14,10
> > > > > > > > > > > > +15,12 @@
> > > > > > > > > > > >
> > > > > > > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > > > > > > +#include <drm/drm_crtc.h>
> > > > > > > > > > > >  #include <drm/drm_drv.h>  #include
> > > > > > > > > > > > <drm/drm_fbdev_dma.h>  #include
> > > > > > > > > > > > <drm/drm_gem_dma_helper.h>  #include
> > > > > > > > > > > > <drm/drm_managed.h>
> > > > > > > > > > > > +#include <drm/drm_of.h>
> > > > > > > > > > > >  #include <drm/drm_print.h>  #include
> > > > > > > > > > > > <drm/drm_probe_helper.h>
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > > > > >  				  struct drm_device *ddev)  {
> > > > > > > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > > > > > > +	int ret;
> > > > > > > > > > > >
> > > > > > > > > > > >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > > > > >  	if (!rcdu)
> > > > > > > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > > > > >  	rcdu->mmio = du->mmio;
> > > > > > > > > > > >  	rcdu->ddev = ddev;
> > > > > > > > > > > >
> > > > > > > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > > +	rcdu->index = ddev->mode_config.num_crtc;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > > > +		return ret;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > > > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > > > > > > > > > > > +				  void *data)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +	return
> > > > > > > > > > > > +rzg2l_du_instance_init(dev_get_drvdata(dev),
> > > > > > > > > > > > +data); }
> > > > > > > > > > > > +
> > > > > > > > > > > > +static const struct component_ops rzg2l_du_instance_ops = {
> > > > > > > > > > > > +	.bind = rzg2l_du_instance_bind, };
> > > > > > > > > > > > +
> > > > > > > > > > > >  /* -----------------------------------------------------------------------------
> > > > > > > > > > > >   * DRM device
> > > > > > > > > > > >   */
> > > > > > > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > > > > > > >  	struct drm_device ddev;  };
> > > > > > > > > > > >
> > > > > > > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > > > > +static int rzg2l_du_drm_init(struct device *dev,
> > > > > > > > > > > > +bool
> > > > > > > > > > > > +has_components)
> > > > > > > > > > > >  {
> > > > > > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > > > > > >  	struct rzg2l_du_drm *rzgdrm; @@ -213,6 +236,12 @@
> > > > > > > > > > > > static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > > >  		goto error;
> > > > > > > > > > > >
> > > > > > > > > > > > +	if (has_components) {
> > > > > > > > > > > > +		ret = component_bind_all(dev, ddev);
> > > > > > > > > > > > +		if (ret < 0)
> > > > > > > > > > > > +			goto error;
> > > > > > > > > > > > +	}
> > > > > > > > > > > > +
> > > > > > > > > > > >  	ret = rzg2l_du_modeset_init_finish(ddev);
> > > > > > > > > > > >  	if (ret < 0)
> > > > > > > > > > > >  		goto error_fini;
> > > > > > > > > > > > @@ -235,6 +264,8 @@ static int
> > > > > > > > > > > > rzg2l_du_drm_init(struct device
> > > > > > > > > > > > *dev)
> > > > > > > > > > > >
> > > > > > > > > > > >  error_fini:
> > > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > > >  error:
> > > > > > > > > > > >  	/*
> > > > > > > > > > > >  	 * Don't use dev_err_probe(), as it would
> > > > > > > > > > > > overwrite the probe deferral @@ -246,7 +277,7 @@
> > > > > > > > > > > > static int rzg2l_du_drm_init(struct device
> > > > *dev)
> > > > > > > > > > > >  	return ret;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > > > > +static void rzg2l_du_drm_fini(struct device *dev,
> > > > > > > > > > > > +bool
> > > > > > > > > > > > +has_components)
> > > > > > > > > > > >  {
> > > > > > > > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > > > > > > > >  	struct drm_device *ddev = du->ddev; @@ -254,6
> > > > > > > > > > > > +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > > > > > >  	drm_dev_unregister(ddev);
> > > > > > > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	if (has_components)
> > > > > > > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	du->ddev = NULL;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +/*
> > > > > > > > > > > > +---------------------------------------------------
> > > > > > > > > > > > +----
> > > > > > > > > > > > +--------
> > > > > > > > > > > > +--------
> > > > > > > > > > > > +------
> > > > > > > > > > > > + * Component master  */
> > > > > > > > > > > > +
> > > > > > > > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > > > > > > +
> > > > > > > > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > > > > > > > +	rzg2l_du_drm_fini(dev, true); }
> > > > > > > > > > > > +
> > > > > > > > > > > > +static const struct component_master_ops rzg2l_du_master_ops = {
> > > > > > > > > > > > +	.bind = rzg2l_du_master_bind,
> > > > > > > > > > > > +	.unbind = rzg2l_du_master_unbind, };
> > > > > > > > > > > > +
> > > > > > > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > > > > > > > > > +	struct component_match *match = NULL;
> > > > > > > > > > > > +	const struct of_device_id *of_id;
> > > > > > > > > > > > +	struct device *dev = du->dev;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > > > > > > > > > > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > > > > > > > > > > > +		if (!of_id || of_id->data != du->info)
> > > > > > > > > > > > +			continue;
> > > > > > > > > > > > +
> > > > > > > > > > > > +		/* The first available DU instance is the component master. */
> > > > > > > > > > > > +		if (!du->is_master) {
> > > > > > > > > > > > +			if (np != dev->of_node)
> > > > > > > > > > > > +				return component_add(dev,
> > > > > > > > > > > > +&rzg2l_du_instance_ops);
> > > > > > > > > > > > +
> > > > > > > > > > > > +			du->is_master = true;
> > > > > > > > > > > > +			continue;
> > > > > > > > > > > > +		}
> > > > > > > > > > > > +
> > > > > > > > > > > > +		drm_of_component_match_add(dev, &match,
> > > > > > > > > > > > +component_compare_of, np);
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The master is chosen purely by DT order. If the first
> > > > > > > > > > > available DU never probes, the second never gets a DRM
> > > > > > > > > > > device. How do you handle this
> > > > case?
> > > > > > > > > >
> > > > > > > > > > All available instances are part of the component match,
> > > > > > > > > > so the DRM device is only created once all of them have
> > > > > > > > > > probed, whichever one is the master.
> > > > > > > > > >
> > > > > > > > > > This is how the component framework works.
> > > > > > > > > >
> > > > > > > > > > To use a single DU, the other one can be disabled in DT,
> > > > > > > > > > in this case the remaining instance becomes the master
> > > > > > > > > > and initializes the DRM device on its own.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Assume both DU's available and run time
> > > > > > > > >
> > > > > > > > > second DU is probed first and master never probed at all.
> > > > > > > > > What is the state of second DU as bind never calls?
> > > > > > > >
> > > > > > > >
> > > > > > > > The second DU probes, registers itself with component_add()
> > > > > > > > and stays idle, without touching the hardware.
> > > > > > > >
> > > > > > > > When the master probes, both instances are bound and the DRM device is created.
> > > > > > > >
> > > > > > > > If the master never probes, there is no DRM device, because
> > > > > > > > the bind is only triggered once the
> > > > > > master
> > > > > > > > has registered the aggregate device with
> > > > > > > > component_master_add_with_match()
> > > > > > >
> > > > > > > Not sure is it the normal use case? DU0 and DU1 are
> > > > > > > independent devices
> > > > > > >
> > > > > > > 1) DU0 or DU1 should work independently irrespective of the probe failure of
> > > > > > >    other device
> > > > > > >
> > > > > > > 2) When both DU's are probed, then we need to aggregate the device using component
> > > > > > >    framework so that use case like dynamically switching DSI0 to DSI1 can be achieved.
> > > > > >
> > > > > > IMHO 1) and 2) can't be achieved together.
> > > > > >
> > > > >
> > > > > I guess we can achieve both use cases, if we define a companion property in the second device.
> > > > > This is a static design choice left to the DT user to choose between either 1 or 2.
> > > > >
> > > > > Krystof/Rob/Conor: Is it ok to add optional companion property to
> > > > > support both
> > > > > 1 and 2? Otherwise, we plan to stick with use case 2.
> > > > >
> > > > > Use case 1: 1 DRM device per DU
> > > >
> > > > Some clarification:
> > > >
> > > > For 1)
> > > >
> > > > Just FYI, the series already supports this when only one DU is
> > > > enabled in DT. If only DU0 (or only
> > > > DU1) is enabled, it creates its own DRM device directly, without the
> > > > component framework, and we will get 1 DRM device with 1 CRTC.
> > > >
> > > >
> > > > # r9a09g047e57-smarc-du0-dsi.dtso
> > > >
> > > > &du0 {
> > > > 	status = "okay";
> > > > };
> > > >
> > > > &du1 {
> > > > 	status = "disabled";
> > > > };
> > > >
> > > > > Use case 2: 1 DRM device for 2 DU's
> > > >
> > > > For 2)
> > > >
> > > > When both DU0 and DU1 are enabled, DU0 registers the aggregate
> > > > device with
> > > > component_master_add_with_match() and DU1 registers itself with
> > > > component_add(). Both are driven by the same DRM device, with 2 CRTCs.
> > > >
> > > >
> > > > &du0 {
> > > > 	status = "okay";
> > > > };
> > > >
> > > > &du1 {
> > > > 	status = "okay";
> > > > };
> > >
> > > DU0 and DU1 are independent devices.
> > > Currently if DU0 fails to probe, DU1 won't work.
> > > So, there is a limitation in the current design.
> > 
> > Mmmm, checking better the others vendor drivers I can see the same behaviour:
> > if one member of the aggregate fails to probe, the others won't work either.
> > 
> > mtk_drm_drv.c driver where we have vdosys0 and vdosys1 [1] that are sharing the same drm device. And
> > also in this case if one fails to probe there is no drm device.
> > 
> > Same for rk3399-base.dtsi where we have vopl_out and vopb_out [2] Same for imx6q.dtsi with ipu1_di0,
> > ipu1_di1, ipu2_di0, ipu2_di1 [3] Same for sun7i-a20.dtsi where we have fe0, fe1 [4]
> > 
> > Please correct me if I'm wrong.
> > 
> > [1] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/mediatek/mtk_drm_drv.c#L374
> > [2] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm64/boot/dts/rockchip/rk3399-
> > base.dtsi#L245
> > [3] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/nxp/imx/imx6q.dtsi#L304
> > [4] https://elixir.bootlin.com/linux/v7.4-rc1/source/arch/arm/boot/dts/allwinner/sun7i-a20.dtsi#L254
> > 
> 
> Thanks for the link. After googling
> 
> Separate DRM devices (card0 + card1) are only advantageous when physical isolation is mandatory
> (e.g., safety-critical medical or automotive instrument clusters where a primary gauge cluster
> cannot share a kernel driver/compositor with an infotainment screen) and no one normally
> split SoC display engine for such use case. So, I think we can go with single DRM card
> approach and no need to support 2 separate DRM cards.

Thanks for sharing.
So we can stick with the current approach right?

Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
