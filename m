Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A1C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740C310F211;
	Thu, 16 Jul 2026 08:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=anton-paar.com header.i=@anton-paar.com header.b="UBnXhEyH";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023099.outbound.protection.outlook.com [52.101.72.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F6D10E02E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0epOgXdwUh+epEoWfumKXr+NwNOFzOK1ONAhVsuhAInrEH/r7+8jHXjcw5N7TmY7P4149Niq8f0RW5erzjXkVXbdf32MEvRXScp/bZAAImWhfHgb3wh8GmZAQ7gydkEaNdJ/TCo/3HjdcFt4wN7s5IHhXLDGPYsixmiaQoFx4+tGKxCVx2R9htRruttJZpi7Q3VTKT8nN2xsBd9aMnJSvB6cjeaCH+TchgKU2d4KmRKoFNvberDcxEG5NwW2p86E9aa1mwHglDaiTV9ys4VRb1kAVxDBHX7M0L4CMfDecrhR9sv7sx/yvlGhJFD6q+usdgZ8lq9L13ka3G7IRxgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gday1megTAtKDGqVY3wMI/33DE8AL4aS3RwVwXYErSg=;
 b=KQgG1vP41Wp+rr2fyzhIn/ke3NPTdTA6df4AAgUuG0/QQQN5bs+HG2MTzuh1d7NerNiZtEGVX2xMZ+/TghnDw9+aCwq1vW64dB1t4384A6s1eOsHv4JljOLOCmeLPjNOr12DkqfNIMvt+/VuJE3OxKyVZ+aZlXFKRXSg5tbtA3a6cJkUE8A8HFfWpex/AOq1i8zHpyBaIERgVkSOXMIYIMz4ej+ZFxccOps5ektpIIh+spgXdoJXCWNwykslzFSjklS+tazh+3BB+7kolmKNnnz7Mg1B0Y7pzNAXcnPetNzAcW4jmlecmT+D6NeAugHR366lsx/uE5+AA01tdwiJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=anton-paar.com; dmarc=pass action=none
 header.from=anton-paar.com; dkim=pass header.d=anton-paar.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anton-paar.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gday1megTAtKDGqVY3wMI/33DE8AL4aS3RwVwXYErSg=;
 b=UBnXhEyH0IQ7l0fUG/u25o3KBJvNaFFbTqTp1rmSybu+J37SvdxF8fwxt8gNxY9i+GTr8STcDEAhBvkR7PXdFZzrCcKEvyE346QITI+jGx4hM6Zlm+58+7MYFd7I5gSVlpEuO3Gk8wu0hz/fU5oFqWUM7YqCjxrr0Q+ie36AupRrX9q7azn0GP51RAz4g/QSgryAGKCht034dDFhO7qRgWTC9SdO3KT4/YgrEkEPVSzDmW+jzxFPh5usoA4LPrMmEo6EnYWU6rca1AKyrZgyBf1WWQwHcpTOtUJVF9Q/jdhpe4/Kl9iDjZKixWlOYMsXPDhADX+LGjKSrqp/wbM13w==
Received: from AS8PR03MB6998.eurprd03.prod.outlook.com (2603:10a6:20b:23f::12)
 by PA4PR03MB6781.eurprd03.prod.outlook.com (2603:10a6:102:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:36:02 +0000
Received: from AS8PR03MB6998.eurprd03.prod.outlook.com
 ([fe80::cdb0:4678:1582:2a50]) by AS8PR03MB6998.eurprd03.prod.outlook.com
 ([fe80::cdb0:4678:1582:2a50%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:36:02 +0000
From: "Lalaev, Andrei" <andrei.lalaev@anton-paar.com>
To: "arnd@kernel.org" <arnd@kernel.org>
CC: "airlied@gmail.com" <airlied@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lumag@kernel.org" <lumag@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/imx: select DRM_DISPLAY_HELPER as needed
Thread-Topic: Re: [PATCH] drm/imx: select DRM_DISPLAY_HELPER as needed
Thread-Index: Ad0TYRiIjQy4bP9uS9G3PNFd40Aj1w==
Date: Tue, 14 Jul 2026 07:36:02 +0000
Message-ID: <AS8PR03MB6998811B9AF89D4E64AC10E8C8F92@AS8PR03MB6998.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=anton-paar.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB6998:EE_|PA4PR03MB6781:EE_
x-ms-office365-filtering-correlation-id: db42c0c2-3016-4789-e838-08dee17a8e7d
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: zX8eTnTBTEsjQ3JPfHiL+2ykD/IX4zZjPWIi1lY8NaVCpZ3xgCMOh3DorCtEAaFbUVHpuLR9ZybN+5nb7HAVo8jQ0wNT6MW1bndGEzPN1gVL89ruBqciMDHuZtfHMPxQoMTJMcqIS76rsOC541XrPHJNIIz4lNV09GIZI+XbOX89N3euDnvPe87bq4oamXZkEJYlnSxpJ3/5YCXGoD71fSS56er6SJf2KE5maU3nvtnTB/mL8ZkMtVd3fLdjDS5OS/f6HapQhNMrfN6or8yrE3fY6WubX8CSb6FJ2POe4AIBOXz78M01CGRQYmZEH5Zs8O/LqaxQq2mxMshCTxeiKGGQ5QWtMWbSKOnNMB5zCZdm4lfIlehydYmK5RyqSenXkwfVlydTg2DqMdlW40aCmkhpm1YF/7fBR9pZMtSY49vxP+aeRnPR5p0Jkax7U3pXy4oVWjPiQ3GkguQr6jPQle+iPP9ss8a/n0mSgzR/ckdK6gekGBbIeJzk3/CYP/qNmM7ty6EtaMN0j/rEEpzO1kC46P7WGBeNkfZ9h0ZVv9letFyFOibPgImTkASZubAVq3o27zL7rBOmL8uZjLl2tSXmJ+hsH8w+gMf/tgvI/mW6/nSFTVYdK7u7n+0HuRg/TmMOlw1oi7cQQf2hLddnwcdeXBb+NW46cqVLJMPWwxeCHpAY3PSQkGw4V4yfnUS6l/cooSSIp4STNBPOEzmkMktpdcx8DRwj+FxLz8DY9Ps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR03MB6998.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/64usDnG/E0YjWURx5Un28gXE50+kAaR1c3+q99rtoOK7VFsTgClXxTV4dTK?=
 =?us-ascii?Q?8ULSueWaIwM7RhbMhKMiyYhH5VpaNfd4975ENVIP9hPq1fy46KoWoYxlFIXm?=
 =?us-ascii?Q?PVXcTTZFrURzwudebhX/K/FuXbDCEAGnQDQ62o+ov4irPjmX/sbZB04EgjSk?=
 =?us-ascii?Q?XDqtt0rdVMJJ3blHQNS3FPYFnYQiNe81HdNR+Tmpya2oAGZ9zyLGHrJvDYqO?=
 =?us-ascii?Q?2lBYnoq9YOw1NQey/FR1QqofuNgUBG57EPEGHjOxF6KadHpCk28ibBII6QmC?=
 =?us-ascii?Q?7ZKTKHQF5Ak5MU5Yvx+pAtEdSoIZjJ8fLfBjbiIxix3ZZZr/nPGGYFtIHRtF?=
 =?us-ascii?Q?kmgSQisQPOLCMlMdjLTazayZ9O03mCc3QIVfjNEfFu3PUT8N+UshfS1Bj6V8?=
 =?us-ascii?Q?ADV5Zg/eLkUiQR9gZMgY0/7kZSdkywBN5cvMfa+pxWPnaBeLTqCQPfa3k3ms?=
 =?us-ascii?Q?HQdRqLhyBZIofbdIBOIltZBYy0PO65u9v1u1iKDtvX47h+yQmlNAYt40GV9F?=
 =?us-ascii?Q?n+TeXKo9GIgwodMhsOGCZiahHzzcjsdkRhJySvZgfqXIeQ2ElpA7+she/QQI?=
 =?us-ascii?Q?kZBZvPaJsV6bsIu9bN73dDw2jT91j03x4TwFYniUwbNxdMyUIHwpG4Mq+lcE?=
 =?us-ascii?Q?4xesx1z4DMykVGeDIMUBjMY0S/9jfR8h/v4gSSRCkeN3LVpEL6SWW0fwlgkd?=
 =?us-ascii?Q?8yOcmcUygvpw8mvdvT80dhRfJLXAM1MDLIEoZ1N05qrtS242IY5mj7ZZvaFs?=
 =?us-ascii?Q?IR6Lo4XpIyjLbhTBzrjv6BAC0ByFZ4o0smG900q1RYo3CLN0y96Q8MwZbR3C?=
 =?us-ascii?Q?efWSWaxA8LEA5ukGPibTQxRgUsbnL0bpdXISFjHXMY0fpcy7KMy7qmcXMmHO?=
 =?us-ascii?Q?lOuLBvhUQt5WcxdIFVCdxlTdRfMq1lx/R2XAy5E1ccMAe7BiM5oIcHwnOeDU?=
 =?us-ascii?Q?YTm7ocAkfNeQL+lq8X9xQRjOZtuQ+4az4dz5djAKpCJe76I+EDJuw6Ol5CHB?=
 =?us-ascii?Q?udEmKwqvwkQGmywwtNHJEVkN2VIHxXGNWZgpov6R9SER7pp6kVRyzNmOIqmo?=
 =?us-ascii?Q?Kbny9E7Kcaf+ywC43hMoo1dQNYp1A9MYHvm4I1TJ2M2rperh3DKCETcKSCtr?=
 =?us-ascii?Q?G/xAmqbN6azFbUnKhwJwXUE5AomteRTGpnNeK4K4QABhQLSLGKo0rgZyjQ3Z?=
 =?us-ascii?Q?JXR6IUBp2Qar6Ek7UPwJIV5BWZ61UfCbzHU/ELixjjUCc9JLR2FGYel2NTWV?=
 =?us-ascii?Q?+I+XVPmlsjAKpWHgwT34CS3Ie8LSk17glm36GDCWmKlPbF1PoWbSrCqug3O2?=
 =?us-ascii?Q?cK33l9CA33IwxJeI6WvvOZarjpJ55CfgmjG3XeG/rPypj277zEw2c3Jj7zfE?=
 =?us-ascii?Q?d4tmcpxeIiejQUqE2z4xslfn8oL5EY5b7dl8MU1BHE7+c2JUi0UKPlgf+M7r?=
 =?us-ascii?Q?ybNiU8B0TzAMKf5p4gE6HIMNMVyaOcJ9zY08YMlbzG87HIUoS6dBin05y7jh?=
 =?us-ascii?Q?nnCKjNZaWYIU+ydJmVSDNZlGHjNLFQ02YzkNnIAf4dOsWmSShA4LP3Ijkyrf?=
 =?us-ascii?Q?p0G3Ixf6VwMkyBX1m1XnxJCmGC/5eTIYQnNT/sCVVO4S+XkB9wB1vJVWwoh+?=
 =?us-ascii?Q?VEKu3sgrZ3uUXrJmcG5jg411+RzkGHcHaGFgjFUqt9rzgPAncik2U78bxHuZ?=
 =?us-ascii?Q?acNujG8dXNTX++9vZyKjlDHzExfXkjKsc/LdFR8jg1XwjwtkirKCuAYVeGeT?=
 =?us-ascii?Q?SHllF0h03Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: anton-paar.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB6998.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db42c0c2-3016-4789-e838-08dee17a8e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:36:02.5500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1650d056-0824-4040-8341-61f3c6069bbd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJC/02OlZTsXdWae6ml75gHkkSIo29jIPcpnRRo0iAQ5zqDs93+jaA5cDYH4vZ0WyRtsAZV78cRu186sqI/JMeYi/AcIN4dm5FiCDKnHTAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6781
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

Hi,

Gentle ping.

I noticed that another patch [1] selects DRM_DISPLAY_HELPER for DRM_IMX_PAR=
ALLEL_DISPLAY, but not for DRM_IMX_LDB.

[1] - https://lore.kernel.org/lkml/20260121102607.4087362-1-martin.keppling=
er-novakovic@ginzinger.com/

Best regards,
Andrei Lalaev
