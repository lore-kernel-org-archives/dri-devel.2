Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F3C531FA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97F610F17A;
	Thu, 23 Jul 2026 17:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="plCrNqIt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389E610E547;
 Thu, 23 Jul 2026 17:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB7QgLlmV3VQ1YXM1Wlr9umF9D7A4D+QZHxC2MMCxf9U4QwUyBJTLk7nPYm/Mwpmbrcgl/S7buOd6CQHLxu4+vtjRrVk2XuUh6J6Y+7r6kVOBAd3RE5+CtdSYVK/qKMYm6cKBcIg0EpDNnT13/KQdlpPHISWiXw028+CPLWiC8rqgsJKPCtPTm6c1Mkr2Xs8zvzYo6VmmS/Ca5V0Dve/5kTAxXCGfks98SED1AbzaffOYcuABhXewNsjCEyZAyci1dQgCwLC7HuWOQvEBFEVRnsF1OvPpvr7ReD6OWm4TGnyWOVl1mOvxAjlK9qQocLInfzQOEcql/EdGHhIghIoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MBTb+SWoRP6ZnQGPQtJ/0TGoDeZbmo/tjWWzutpdt0=;
 b=sOHV+4e/RMslxT6P1Yl0VsMMfzOiOcmZcKnKFDJ3wsyCnn1LbhrO4zlf/mjl26tqh7esVSIqItqBRRdRzkwyf5PCVaM0r+YJd+NR8r2XYVKlNfGqrg5C9H/0D8OMmHjXpKZY9ReRo0coCc45gimQ38cNmqogFnN+bwZEXD1lW51YDNElesNusCEBy9w/HqSTAjygiZWI+fVU+aipq6rjgR/piQ2sVF5sh20KQaDEvUso/qPga43cyN7T4RgHkyzjQ2Jyp9r/cKb7k8pkgJ3j/kzsPfD5Arp49T88RfXhEEL/qoQm8Ynpp6vlKVfp+cYCnLEwKxJ2COb/zNpP9J06rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MBTb+SWoRP6ZnQGPQtJ/0TGoDeZbmo/tjWWzutpdt0=;
 b=plCrNqItq2cOANX1wSTGrEl//FRwd+cu035cWWflvgVmEVIRibZuk+A+BY9tuGhsvBoeqXIVCy7giu+zx1N8ztCsQM89RSCmAqLDtJDN2lW3CsZfV/qSjTpG9ZlFQpz+Z1AbGpT7fDCiTXfpeyb9zPFXO/OMmPsr67RMiv8eSk8=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 17:10:46 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 17:10:46 +0000
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
Subject: Re: [PATCH v2] drm/amd/display: use proper context for logging
Thread-Topic: [PATCH v2] drm/amd/display: use proper context for logging
Thread-Index: AQHdGltbKB8ar0NLz02RaCplLReMvrZ7Vfrd
Date: Thu, 23 Jul 2026 17:10:46 +0000
Message-ID: <PH8PR12MB7279B4E7FAA1899E488AB356F9C02@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20260723042548.1225691-1-jirislaby@kernel.org>
In-Reply-To: <20260723042548.1225691-1-jirislaby@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-23T17:10:46.752Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|PH7PR12MB5927:EE_
x-ms-office365-filtering-correlation-id: 35c2399c-3b67-4e31-2722-08dee8dd5653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: YzKIRJPyR8g621ieVLaK2o/YP9TUBrB5yqVT/YXNzqMBCWREksHbihh56tDcr2imyUld8O0ix//f/I7LN1LxkFlaPaeJqIxrD3Jc8vb7hEGHaTQkzwic3StO6dS0KOZYUGYmDlCMlLfRyvFnitKeEBDbEmc5UW0a3cE7NDxI1y/PQFi2B8bXMCQbLOeJ1jUy6Vuc4jkNy1h6FVB8GLfN05wO1FSaGhZSAhWQH0RPA8++aiiy2jwDby1urzJQybCipQOd02J/1tQZBT6jcsGdOQJbX59LctPLQKJrL1qA3MBkmEugIlUMEnF1bqG2FiXCWUZqgJidyopSgtPp42hkMyXtGtz7ofC55zwGzk7zPN76QjLwh7dG1lfX99tTssI/bdO/VVjWCTmgZle6SSQy+E0AbKU1yHyT1Ole3FSJf3ReP4RBv7mT0ZQ44dVCACbD5rU2nbmBHC5HZal0X9GXr4NLh+PvtdH76i4Vl3gIE8+A13tdUn+XaH7F0EtqBvx/mOifN6fAHWgr5GoW4cSW0q+Qvgv+0zu5YTInTCChRnb4PTSBwvuOYrre+csqMLgTMQ1Xznkp/VMcfh62VvrVNzZjXtIfpCvOtNFp84eKUR0EG1X3Q28Iy/8jUtsxVpBXtEZksJvna08eMRYoWCExILFvYW7e0S5VnOBP5ZsuTYd0rKtoG+++zsqEpbfOTBgj0W8JVvMNAgwo70qAAIxT/HYnkpgtvVkYM3Ay3IucC7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2xozwkaO7Fmctd8mdZqCCwhmUD84nJOCJsvaS8oMEnIIPz1sgQrzPePIDy?=
 =?iso-8859-1?Q?Onwu2hUnfbpY7nUbDmPWgY/YkdQi/P+jfg6YlKU29PxZRUe64TNMbdBgyY?=
 =?iso-8859-1?Q?BfwH2Ouo2ePXWLVP9/zkjzLjhq7+t3L/o4v9D2msrVtVFB/a73K7uo4Yse?=
 =?iso-8859-1?Q?THuyLKycbWbSeqis7f6THVcdXauJJTeAOGv6vfsK9u3Mc7KQxzrzSEbY08?=
 =?iso-8859-1?Q?a2SyVDTe7+Q984h489O8jc8xjzaeoaaLJmM6o3307yB/hpZWp+XiKeLWVj?=
 =?iso-8859-1?Q?2+YUzuxSOa7vgsb3gtAgi9W+zciJ23EiBn/gJUNkFR8oTbDSJn1rXjjqa0?=
 =?iso-8859-1?Q?t4AIlT2Q5nJb5h9aRsgi+Wru0R2SI1X50PhGFeToJAjCwyu7tab7mb5Zgh?=
 =?iso-8859-1?Q?8GoLGYGo/0vI/lgMVkAVIU/VMBJIp2ndwU7dP6AIRrLkgwi4fFgSe7ObPR?=
 =?iso-8859-1?Q?UsWMdmIsBfOsHgNZaXdyTbp/A2mWQGHXqDyX8K7pkItGqxEQK5FDGUtS95?=
 =?iso-8859-1?Q?crGP14K0oP5SzWuAq3RBYXZ62/CNmqn3b2U3CQGPIpq5IOpBpycarOx/1i?=
 =?iso-8859-1?Q?HdS4wPigpwu6Fcdzqh4XGRBGotRIc02/M6vziTLa1KbhvnbYK8pobXtCvI?=
 =?iso-8859-1?Q?VI2AKk9zUqoWPat0AAZvoDrqRWQDAAXxHj88K3EgVBqVqqtSMbPN/w8r6c?=
 =?iso-8859-1?Q?JpvhTMD4URcaMerQcXIkworcWKj3RvB5aOO6mw8D2pfpeUgX34yuF0QS5q?=
 =?iso-8859-1?Q?C3oOLRp60tKKjK8PCg1Md1+HfVgerL/M1zr+r+cyHJuiX6En2uqyY2n2/m?=
 =?iso-8859-1?Q?i0q6zYXRYYJFhgtf1jwCC5kluRSHix9PGSd7kbRCYSd0WWdR2gL/+2u47Z?=
 =?iso-8859-1?Q?HcVAfOpd+OBpGAznepdWmE+HGll1F9Jj1B/Z0m7kot5JXltvvlfxW59CgI?=
 =?iso-8859-1?Q?5yoxMQ6YaFwpLGt7uBZcWtxgd3sACm8YvVJeWnPaR4umIkBzpanhlJesbJ?=
 =?iso-8859-1?Q?a4WCzyiDXhVH+HXdXXSd5DS4SUJKaUl2omFAwqnGLRwREY9GpRbYc+1N2v?=
 =?iso-8859-1?Q?8ZHlL/NhV0C6ibYbvTOhN+Vpq5u3zjU7axQ1m/8apnPzSu9W3KUF/5boLw?=
 =?iso-8859-1?Q?ieCkM4fTvWmOEv2GsthEauBPwoaqxa+NW3AfCZv6vZr45hUWP71VxU496w?=
 =?iso-8859-1?Q?Grs7Ufm00+K7Pvo0Hv7CcHRw+ZY1pKKyZIXl54fl3jC7Ip5K5fZ0dvHSvE?=
 =?iso-8859-1?Q?gP2MsBrMvX4vzQT5J8O4n4Ck3c45xIu+95MDZBUMbxt5ejbNQqlvo14Q65?=
 =?iso-8859-1?Q?8SP56gR3db4RX/kQkG/M6J5lpzRCRcZQwt1YOXfhA8j1Rutq4/wE660HLE?=
 =?iso-8859-1?Q?VSuiXSHq4BCQDmEaUtjU+xBgrVE+PpYaXZUpJa9FuV0VK2aYCOIAPBW3Aa?=
 =?iso-8859-1?Q?laD1MSSqxfFzvFr1pjLwcHa5r2+/v54rSg6EiYEKlM7kWAVM7Xf7gutPvn?=
 =?iso-8859-1?Q?BCBjZsJmfeg6Lh5eeSbpstR78yfU5eOdf7ZeyTMcZN+/mp6p2+jCQz5nxM?=
 =?iso-8859-1?Q?Wmvz2uJRGzch9wfP8ER36sYWwfqdfCIZtfx417yaM72R8dOD4gMUBDcvZW?=
 =?iso-8859-1?Q?aXFymOY46YE1CeZBI5rm4pa8uWyQk16G1U+YGsfJGg0S2AezbfFx5g/0TI?=
 =?iso-8859-1?Q?XJ5Kd0tMimMKsTzu5cCHPBkKD9n9yrTfmpgJZVC4pjt4+mgB98H0hSfrGW?=
 =?iso-8859-1?Q?bjbzTnGqNaZ8XHJQW12dXtB4+O7ysBqdDGt+h4Lt8pTIdB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2399c-3b67-4e31-2722-08dee8dd5653
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 17:10:46.6606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVNBRrcJGiquqKS2QjZORadRBE/6C5uvlvUZQ7gZFEZbFfMQTBNA0VBv2TCnBPV6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

looks good, thank you=0A=
=0A=
Reviewed-by:=A0Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>=0A=
=0A=
=0A=
Bhawan=0A=
=0A=
________________________________________=0A=
From: Jiri Slaby (SUSE) <jirislaby@kernel.org>=0A=
Sent: July 23, 2026 12:25 AM=0A=
To: Deucher, Alexander <Alexander.Deucher@amd.com>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jiri Slaby=
 (SUSE) <jirislaby@kernel.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.=
Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <si=
mona@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>=0A=
Subject: [PATCH v2] drm/amd/display: use proper context for logging=0A=
=A0=0A=
The same as the rest of the code, get_ss_info_from_atombios() uses=0A=
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is=0A=
initialized only later in calc_pll_max_vco_construct(). Therefore, any=0A=
output using DC_LOG_SYNC() leads to a NULL pointer deference in=0A=
get_ss_info_from_atombios().=0A=
=0A=
According to Sashiko, the very same problem exists in=0A=
dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.=0A=
=0A=
To avoid accessing the NULL context, use clk_src->base.ctx->logger=0A=
everywhere. That context in base is initialized earlier in=0A=
dce110_clk_src_construct() and dce112_clk_src_construct(). Before=0A=
get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions=0A=
above are actually called. This is done by redefining DC_LOGGER to=0A=
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
=0A=
[v2] Set DC_LOGGER to CTX->logger unconditionally (Bhawanpreet).=0A=
[v1] https://lore.kernel.org/all/20260722063210.1144266-1-jirislaby@kernel.=
org/=0A=
---=0A=
=A0.../drm/amd/display/dc/dce/dce_clock_source.c | 20 +++++++++----------=
=0A=
=A01 file changed, 9 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
index ecb8493ec523..8e3862f6dac2 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c=0A=
@@ -45,9 +45,7 @@=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 clk_src->base.ctx=0A=
=A0=0A=
=A0#define DC_LOGGER \=0A=
-=A0=A0=A0=A0=A0=A0 calc_pll_cs->ctx->logger=0A=
-#define DC_LOGGER_INIT() \=0A=
-=A0=A0=A0=A0=A0=A0 struct calc_pll_clock_source *calc_pll_cs =3D &clk_src-=
>calc_pll=0A=
+=A0=A0=A0=A0=A0=A0 CTX->logger=0A=
=A0=0A=
=A0#undef FN=0A=
=A0#define FN(reg_name, field_name) \=0A=
@@ -287,6 +285,7 @@ static bool calc_pll_dividers_in_range(=0A=
=A0}=0A=
=A0=0A=
=A0static uint32_t calculate_pixel_clock_pll_dividers(=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk_src,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct calc_pll_clock_sour=
ce *calc_pll_cs,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct pll_settings *pll_s=
ettings)=0A=
=A0{=0A=
@@ -474,7 +473,7 @@ static uint32_t dce110_get_pix_clk_dividers_helper (=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t field =3D 0;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* Check if reference clock is external (not pcie/=
xtalin)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 * HW Dce80 spec:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 * 00 - PCIE_REFCLK, 01 - XTALIN,=A0=A0=A0 02 - GEN=
ERICA,=A0=A0=A0 03 - GENERICB=0A=
@@ -517,12 +516,14 @@ static uint32_t dce110_get_pix_clk_dividers_helper (=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*Calculate Dividers by HD=
MI object, no SS case or SS case */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pll_calc_error =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ca=
lculate_pixel_clock_pll_dividers(=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_src,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &clk_src->calc_pll_hdmi,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pll_settings);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*Calculate Dividers by de=
fault object, no SS case or SS case */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pll_calc_error =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ca=
lculate_pixel_clock_pll_dividers(=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_src,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &clk_src->calc_pll,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pll_settings);=0A=
=A0=0A=
@@ -568,7 +569,6 @@ static uint32_t dce110_get_pix_clk_dividers(=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_S=
RC(cs);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (pix_clk_params =3D=3D NULL || pll_settings =3D=
=3D NULL=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ||=
 pix_clk_params->requested_pix_clk_100hz =3D=3D 0) {=0A=
@@ -600,7 +600,6 @@ static uint32_t dce112_get_pix_clk_dividers(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct pll_settings *pll_s=
ettings)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_S=
RC(cs);=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (pix_clk_params =3D=3D NULL || pll_settings =3D=
=3D NULL=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ||=
 pix_clk_params->requested_pix_clk_100hz =3D=3D 0) {=0A=
@@ -1442,8 +1441,6 @@ static uint32_t dcn3_get_pix_clk_dividers(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long long actual_pix_clk_100Hz =3D pix_cl=
k_params ? pix_clk_params->requested_pix_clk_100hz : 0;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_S=
RC(cs);=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
-=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (pix_clk_params =3D=3D NULL || pll_settings =3D=
=3D NULL=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ||=
 pix_clk_params->requested_pix_clk_100hz =3D=3D 0) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DC_LOG_ERROR(=0A=
@@ -1513,7 +1510,6 @@ static const struct clock_source_funcs dce110_clk_src=
_funcs =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .get_dp_dto_frequency_100hz =3D get_dp_dto_frequen=
cy_100hz=0A=
=A0};=0A=
=A0=0A=
-=0A=
=A0static void get_ss_info_from_atombios(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dce110_clk_src *clk=
_src,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum as_signal_type as_sig=
nal,=0A=
@@ -1526,7 +1522,7 @@ static void get_ss_info_from_atombios(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct spread_spectrum_info *ss_info_cur;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct spread_spectrum_data *ss_data_cur;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t i;=0A=
-=A0=A0=A0=A0=A0=A0 DC_LOGGER_INIT();=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (ss_entries_num =3D=3D NULL) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DC_LOG_SYNC(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "I=
nvalid entry !!!\n");=0A=
@@ -1657,6 +1653,7 @@ static void ss_info_from_atombios_create(=0A=
=A0}=0A=
=A0=0A=
=A0static bool calc_pll_max_vco_construct(=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct =
dce110_clk_src *clk_src,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct calc_pll_clock_source *calc_pll_cs,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct calc_pll_clock_source_init_data *init_data)=0A=
=A0{=0A=
@@ -1808,6 +1805,7 @@ bool dce110_clk_src_construct(=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 ss_info_from_atombios_create(clk_src);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!calc_pll_max_vco_construct(=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_src=
,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &c=
lk_src->calc_pll,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &c=
alc_pll_cs_init_data)) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASSERT_CRITICAL(false);=0A=
@@ -1822,7 +1820,7 @@ bool dce110_clk_src_construct(=0A=
=A0=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (!calc_pll_max_vco_construct(=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &clk_sr=
c->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_src=
, &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ASSERT_CRITICAL(false);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unexpected_failure;=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
--=0A=
2.55.0=0A=
