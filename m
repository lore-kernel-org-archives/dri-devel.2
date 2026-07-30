Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DE0C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C1D10EE28;
	Thu, 30 Jul 2026 09:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="INh4lKQ9";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023107.outbound.protection.outlook.com [52.101.127.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF6510EE28
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo/VpVjCRdWOXMsl9tnOX2x3IlI6b10WjdOAFgLl+vdhwn5nTdlF2LIdP/+wQZWOgFYyd2V8JQ8Iy5IM48liDnSzqr7AV/VIWrNXweKtQD0Zg7qg9mGgr6QwCTBi4i+2LqrJg+sFWr0gw4iAu/pgyPBDcy1gjgjZmrNjeRWYK2PoeiTSMRO3wSqSK4r98dd6sCgKBuavEXosHGwhQhISEWj/Fz6ih7wx3PYk6BzJE5gjWyHgX7Dr6dEWYDs5w/2sTjJCse80SJI/Ghn+gJYbxyQqQjceMBaVY19+dbDBr6Py6/iZnxxAaFyx05P03sa7t/Rul1nJlNiXur5WEX3ZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms6FJURN08NIDjxpADmFRwt7viw2+rwyAcVHsO9E5Dc=;
 b=Zzy7oA+ZPJTcfrsLsPX3iv7n3q1PDVGNHIH/EQi0NtPV+q/zWaUMJnt7noxtVM/X0XMKXm2/KlP3WUC9tu5zSCIKAW/3tOg0PSk+iM32ovTPhoChMWnPiOUlghtKqe9YYX6tHG6T/ABGLnb7DSB/PoffB+6a9P/gCWHy9uGQ/DPp+Tmx3linCz49UU7nzi1XF6cKz/IWbBC2/Mkz2LrqFK2uqX9W81O4ZTE7sLZb9FjqnbzhexeRkh0CTj7AONZQ5rT5ExDYe9FA9F5EfyTjTi8/FOvavzDSW6dYKFVdw48L1qWzH+6unLQcFv6Pq6SpFFLf+pctQUBULgcXNFh/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms6FJURN08NIDjxpADmFRwt7viw2+rwyAcVHsO9E5Dc=;
 b=INh4lKQ99Anwc/6lzH0AJ42WHAFRfRNKkjO5BlMs7uYS63HcG68crSavonZxtcBG1kYgYU0jRh+klSHVjUdYcRM66SyuOo0sGmcOPqJOHHcuFiebaPK/yCv6+WVOA9lEKBuUZxlGwmq6ObCWkuvXvg4a0HJUO3pOvnwCOhxvBeeoNVf355UnzKsClIlj7r87HXGJAQB0bRRYPaMLo0VBXHj6oIZEZxR+JEUibwTuXf4rCaRa6jclbfTL4gcHz976vFUJAxRWPdQwCfYdt6IWFp6KhlwO6YOS2TqZqGOnpMvUmhqApAUA/L6bKf5Ee4xVUxPSk6uOJQSZtohBYVZ7JQ==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYZPR06MB6860.apcprd06.prod.outlook.com (2603:1096:405:1d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 09:33:16 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:33:16 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Jocelyn Falempe
 <jfalempe@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Topic: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Index: AQHctghLcM60vWSjB0q2hmYy6od4zrWz5cqAgB8T2UCAruV5AIAEv6Lw
Date: Thu, 30 Jul 2026 09:33:16 +0000
Message-ID: <TYZPR06MB65681FB22E654846896F81A4F1C92@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
 <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
 <TYZPR06MB6568D830FCFB93A9776333ECF1C22@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <b601f8842b959f6d8a2bd22bf6743dabad6d980c@intel.com>
In-Reply-To: <b601f8842b959f6d8a2bd22bf6743dabad6d980c@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYZPR06MB6860:EE_
x-ms-office365-filtering-correlation-id: 42407537-0367-4c89-c178-08deee1d95c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Q4jjRkB/toj1vMJ+1WvmBVoPsYjMSHevUxM4b7sUiUg6MOxGQqlZvV3lzsGgVQhKVvVs+LhJRZwzVfbP5XfeUdevgqucaaKUAsQIfsJleyNABHwI1YIbUT55jhesqw1Mm6gBTvK4AVWz5PgipNiSrurl26puCjH0e8jqC3xepQ/kz6+IJCRKI9J6t8whcBPq6dMxtESR7Otn5+/s1/yBqaPIab2KGbf7oovO4ym0nctzu7giAVgh3BHmhOhzMQLY3OC25WgsWMqmVz3DoZQe0jz/fpgT9JByDAvSz1cJwKpdvFPL7Ck+OQqQZtH3ZUPKbqbusmG1oD6CyqB6BZfH7zZo1Mkl42HQD2EnyfmFxDPvO8hX4emA4CvSxfahFZMRdx+h8E7DMBXeHCAnYHM82sKGgFVQ04xxXi/0TbpoY+KOY19JsTWmGIfFgev3JxjmgpjYnpoVEEPKSDGkYZDh8K7vfJ3Mh98QDs1NcLcR67qp7VEAjqTv0hbwrRj355f3H6oqqOmgvgOZYGLbV8xhtGfiRa0O5ITKMyWiV3k8Joa7r5ejU2zW0ZAQ7mBt9Q45Llk+4uMzH5HQG3IeKh0BTjjM6cWYiS5TD5QJJS4y6QtRrXIJpQDZ5a+OSXPGt8YP9TXVCJdSZs6j/7mu0TrHh3ybdzYHJu+rMFOSb0vXd+aj6djTtfEBGypGF7oSRSjW8DB6YmO2vMlr+q1cVfWUSxuGJdee9lKvMKLuXP65C7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB6568.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rTyt4OVcv/k3XZrMPfND0PEfSrZMXLFhsA4Lt8YwLcqmkbBySRERiofc7h?=
 =?iso-8859-1?Q?eF7wKCW02li0NlFGUc16MAHkuhcDwAF2Ue6nK/8z/re/Qt8eVY6yK9M5cr?=
 =?iso-8859-1?Q?t81WJOXGLmQkDouThgWCWbUhYwpo1VcHaglrQDODMRSVIMEsOzqBOFcya/?=
 =?iso-8859-1?Q?oaZZHJx9jfrTbIyD5JTspIqt7RbSn4CpoUcCDqHFMAHLZsj7D1wpjkv8E3?=
 =?iso-8859-1?Q?M9tv5epF6X9uXoq/n5qjQa2CUj++pyHX8n/QeBWi71mQ1zFsPKFjolPuyy?=
 =?iso-8859-1?Q?ysWlQgOCoX1/FxYXx+mJyncYX3XIWvi2v/Cuz6UVDGx9DcFmWf8HjnMxYk?=
 =?iso-8859-1?Q?RxIRDc0OxLSxJpiWckuf4JTry7ROJNrLbfN/3CWO6nHTRHCPgXF90aagLT?=
 =?iso-8859-1?Q?kyHx0MvBYoE3fMRC8EqjomkDHg1kgvycJLWAxs7q/QvnDTkmlv8aIuNX2R?=
 =?iso-8859-1?Q?RvTFyY82a8r7Ptj46xSXxSdxG2kuwWdYfxtWVPRPDFfCE659ShOXh96Bdx?=
 =?iso-8859-1?Q?+IUoqnhbVKZKZjnmWyH4hLtWijSewWGXRoldfU4uRO1i7EFEzn0vO9FCc6?=
 =?iso-8859-1?Q?ioHMuWYqng8algvuPNbNRLyis4lp/i8tyDO3Z8IeF7ERH6We6GbIJpY+4h?=
 =?iso-8859-1?Q?jiGHzywz3C3DdA8O6VPrjQsJBTqwEWysV+9RqLCv0NhqySmw7N2u4hKgkZ?=
 =?iso-8859-1?Q?BhF9U7K90g2b4y7Yl+h5rQcXOr46Bg+VhlgCTJq23XkXWgH7Udj5aq4wNg?=
 =?iso-8859-1?Q?zsn9s7Ft5SSFPoDDGX0czLONB2IQBinF+dcjUBCtJDCyEkpMj5sDeJ+mjP?=
 =?iso-8859-1?Q?gD8B75UFMTs3RhZWs4zdFHBWM82o7l9+KZtGjKUZGhleFTG4GpEckn/Ljo?=
 =?iso-8859-1?Q?PDizxoR+w6T250LteMm0um7OJJQUqaERwSac8N+rG5K5PwQXNOEby458ZT?=
 =?iso-8859-1?Q?0Q+XULFZq/GF2BtlengkBB2jiLLwNBABxlDU0YcxiO4nxcre+ZbawP/zIT?=
 =?iso-8859-1?Q?WoROtP8W4vIGDLASc6lfu6O4IsDOQB0cCHNwZJy/gDjRxRk1Y/U17Vlgmo?=
 =?iso-8859-1?Q?cDU72O+RKB+U9c9lvqhcFpnVe4TiBfaQyky/y0lsYD+H71AAeTOG/en4dy?=
 =?iso-8859-1?Q?0aCjMEQ/QLy2LBv2yMowOPoYbwHjOd3fcVJtOXToAF+QP83Tz43GERwsXh?=
 =?iso-8859-1?Q?SsI7g902qm9pIMLD67ZAQAudrUg9yK9F4yJlyZ1JPR6YG+DU6WMSXsfSUB?=
 =?iso-8859-1?Q?qucoM+KDGOb2lhB/3LxOct/+3aPDXJnYFBeEAavSOWfDO0QexGYGJo5Tap?=
 =?iso-8859-1?Q?YnH5xaC42YfWUu+i9lDezGTt/QJrQnYQzHkBRMGvdTV2COt0ECFb574AFD?=
 =?iso-8859-1?Q?zgX0YbM92cjQYJiW/IEo/Zl6DxfM3VEo7opaGRxDWsHrlg6mk9EVGf7etX?=
 =?iso-8859-1?Q?7pdRAddwIKupazTXo+o2O/w9OIhfD3jcE8imRDsJeI9cPhKIHzFJsdb3Qh?=
 =?iso-8859-1?Q?ARVmkw2uZNJNhHPh8HlcVB2dOrTcDaAQrVgkRN1aMY/KrF0gXMQA42erCR?=
 =?iso-8859-1?Q?Affir1VpJsBoBp4k05KI4luJ8XM+FHrCNkrwlCnKEW61YWgl2XtXYBxl1/?=
 =?iso-8859-1?Q?VH1EcF1JBe0TleMSbkGlg4ivVIRdsIt/n01OfdIxR56tIzkIYC+XtK0MZZ?=
 =?iso-8859-1?Q?IBQrPueo4CP59+Bd1RPjCfZYgNyd4ID7iFIVzFUP4nS7SfSLpC7Bo8fl6u?=
 =?iso-8859-1?Q?mRaqZAwOZDxWptvjMgKdtp9a/9/GIPULmy2QuwSpWCaAZrnYBVJsE10PIQ?=
 =?iso-8859-1?Q?aQh0IgQ7Zg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hDPsSLYFeyggK7wu9Z8yZlViravj7vUbjoQ2gAEXsD3jwhK/vMPLuxLX8Cs2ymsBftPLqXdUR1A8vWZDyszukRJZPS9p16rZgWxO7oKMayYkwr8XSMZFa0lwc9yakkPGBf6O2GtsbExaY7ZRsAgIIIA3M/JRu30AtaTfZCG6xu6SgqRflxHryHbzLiuqhRF+6tLy/JZbHjhhaKweJbP3ev2U9kkkygJsul8bvuw+0d2YVEEM8q5/sUF4Akuj5C53RrjZ5RCVj9Xi3RHYBSGFXggt+YJ0CWnCB485WmcQyu2xvetjvdNbf3/O+2VEUEUGX8kL3GI0OeeDaMP5UuE/Bg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42407537-0367-4c89-c178-08deee1d95c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 09:33:16.6547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1sQP5Hv88Sr5q1ipXSUpmXX/VYNGj7XSUbz233q1p7AA8Ywcainh6h3k1BYp3QbOUyV0vFC9oq+9t03iz3VN2IfCMSEhjq8mkYFD9WcuS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6860
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

Hi Jani,

Thanks for your input. So, your suggestion is go back to return -EIO for bl=
ock > 1,
and stop trying to modify the EDID.
In this way, we can handle EDID whose blocks is less than 2.

BR,
Jammy

> > Hi Thomas,
> >
> > Good catch - returning 0 without writing to buf wasn't safe. But I
> > also found that returning -EIO isn't right either: _drm_do_get_edid()
> > treats EDID_BLOCK_READ_FAIL as fatal for any block index, not just
> > block 0, so that would have discarded the whole EDID for any monitor
> > reporting more than one extension.
> >
> > In v3, for block > 1 I now zero the buffer explicitly and return 0.
> > That makes drm_edid's block checker classify it as EDID_BLOCK_ZERO
> > instead, which is non-fatal - it gets trimmed via
> > edid_filter_invalid_blocks() (extensions count reduced, checksum
> > recomputed), and blocks 0 and 1 still come through fine. This also
> > directly addresses your point about the buffer not being guaranteed
> > zeroed, since we zero it ourselves now.
>=20
> There's a long-term goal to *not* modify the EDID in kernel, but rather r=
eturn
> even the broken EDID extensions to userspace, if that's what the display =
has.
>=20
> There are probably a bunch of hurdles in making that happen, but intentio=
nally
> returning zeroed out EDID blocks is just adding another unnecessary hurdl=
e.
>=20
>=20
> BR,
> Jani.
>=20
>=20
> --
> Jani Nikula, Intel
