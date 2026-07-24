Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDAEC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF63C10E00D;
	Fri, 24 Jul 2026 12:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G5Kab1sl";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010056.outbound.protection.outlook.com [52.101.229.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95A710E00D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 12:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez+xTHWLTRcoIEuegfg1lcjdtJzvtvDqtnfB5rvUaLD19kV4tRimXMDElVsq3helaozop5gBhswLVUlCsatmWlXLlxkquX8n+tJhQ6C20JrvA1xW54hFVN67as10CEvVN34NkyKfOjQ9nvwJ4gFb3m5cNIT/NyN7X3PjdnpN3tT/7N89CxbjhLrILTOlzf04n8vrbYIEGN09+RgYzsbBaEv2ILLVyZoFVqpy/22I3c1zE0XeCz/dvjMIELrde49itLT8crCUQS+PV3etEbBNjPh3H2mdIIiFVW0OsKkL9DXNNMK+22R/ObM2OLTbVweTXnH/VwNdILX3I8CntfDiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulnEew8oKGp/5xNfwPeZxaBUr4mE0Ej93qSat/vYajk=;
 b=PQuk5q2EPDl82KByy6KJ1/vrducWrHoCmbx06+RctMZZLbRHo0jVan7Ze8d6Zf5V4CXGSyfbpGXVfVoBrLWTdzXNFZXx+9H9zHldGNOPsjpL3na+wt1ebM5LRnK3Gdue2LZJjxdl0/mfB5hqcnzA2SU59B5Yv06MWVT8pSJ/G0H6wN3XgCADi+4iO45k0VoPczVt+rm2UkKSGa2zC4lx3mprGS/Rc/9yqIoQ86vzw4O2e4slwO3GgZBPg4yvrxcMsAAyi6HfdXvddNKKE2rJB3jrun69211g3GPiEI0DsNpYUaDuVCKNOCH1UPXkMHhOOwc7jXaNQ7UuS0eh8wrpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulnEew8oKGp/5xNfwPeZxaBUr4mE0Ej93qSat/vYajk=;
 b=G5Kab1slNOCqMVuQXT3kRCJEwgLsmXRRwPN9xh0jJ+cl1b1OPAk8ZvX3NSkpro5RVaNRE0V11C3u7wq1aa4JG6WlXNnLLV34JYFwBDi3gKRFzhdytbIcGulut4vNh3c3NmTGrMKR2lLNAHdTX7iCG+tvzSsVr+bav3UjlmQgCrM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17480.jpnprd01.prod.outlook.com (2603:1096:604:44d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:52:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 12:52:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: biju.das.au <biju.das.au@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
 laurent.pinchart <laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 01/16] dt-bindings: display: bridge: renesas, dsi: Document
 RZ/G3L
Thread-Topic: [PATCH 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Index: AQHdC5hXT7Bl3w0M30ul9DikKlntD7ZjUJkAgAAKgnCABrLEgIASalQAgABF1pA=
Date: Fri, 24 Jul 2026 12:52:19 +0000
Message-ID: <TY3PR01MB11346892D9619A8D1A6C2DF4A86CF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-2-biju.das.jz@bp.renesas.com>
 <20260708-hopping-exotic-baboon-6c5a46@quoll>
 <TY3PR01MB11346CB08784610C00EBC870A86FF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260712-jumping-whimsical-alligator-8fa8ec@quoll>
 <TY3PR01MB11346D4E610DD535786C9B92F86CF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346D4E610DD535786C9B92F86CF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17480:EE_
x-ms-office365-filtering-correlation-id: 7bf8e117-8359-4209-444f-08dee9826607
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|1800799024|376014|38070700021|11063799006|3023799007|10067099003|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: Um6yD+lF9VR7PhtKw/wkHevuuYTpJ+5Nc6MhsdZ+vFsGKsSlZdHvi8ZWSyguQf6uiO+nOrsvivfhVYuXW8b5WLKMfp7i43bZCcAxxeYmrx0zsqln1wQCu+kBD/HhuSyqrD6wbgxlb/G74L7KFtCZ6bCnmOUVXeWs531TxjvPs/2lebsTC7PVe3FY86lhuZYwzgNSSWCOB6SHmoqlNzsBV5p21N9OJdyTfVKs3eGlJ5clGDPKaExWB/Yrlq282nyBanbfNwcg9hjoUa4wi/2a2eGscHNkMVP51aA3ax+GaaIsSXvcuR7tH5pZjgVNWplPg/E//0WxOhtu179KQ+1jAG+kav88DNgUNqRZ7WkO4sbwo9MBgxx9iixfmVA4BE8f+v7xFiAFibsWglfAo2Uc+orfW/aU0WBlm80OC/ns7nV3OV3Z0vT6u+MLK13CBGiPQ1COPO0ZLSyY3uU6HZLXHcFJBGglflw8nUweOWPIcAqZ2LKfOtcyYqDkhcNrXcN/iGp1bi3C5oCVN0sgC2mRD03un78LGrOSVumyG339xH8qtSAEIliCQdSEWLxDuj/NT5LRowA98bMLz3WOF49qziS+pGTIptRb6ezfX2DAJRFBfx8kDyTLv7tPGW5nGkFqkyIQsFh+VOd+J+o0Uro+RwOy5vmIuCcrwqkRW2RHiew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(38070700021)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnJpUjRwcjFsMm5ORExGWndxZmhkRHV0T0xnZzJzNU9zQWJwbzFxS0JCVjlu?=
 =?utf-8?B?Y2svWWF1aW5jNlZQMldwWDVjaFZJWkRJaGxhQTJJeS9NdGY4K0t3R29DYlFy?=
 =?utf-8?B?RkVhRGJYZmRsYmVBalpMTWg2MEJqMDdhSE1MNERIT0ViaDJSNWwrOGdzemZo?=
 =?utf-8?B?WEMvTU9xV3VhYU90TzRqYlgwODJnUVhDTHhDd0JuMjNIRVhiYWQ5UVBOQ2pn?=
 =?utf-8?B?NXhUR3N1NmJ0eWQyN3NQOTdvZWY3bnJ2cFQwSjFtRThOQTBrVFowcDErOUx4?=
 =?utf-8?B?TUhBbXA3YXVFUjc2cXd6Tm44d0FXYXhXd1hPQmw3K3hFVkl5bHlXd0FBRDEx?=
 =?utf-8?B?cGpSdnhucmRYczJ3by9aUytlRVpCakR1SlRxa0NCRmFuSzBYZEZRdHJqc1JL?=
 =?utf-8?B?QTI3ei8xc1IwWFhSdzk3ZE1oM2czU0lSMkttYUNNaUphN3RkV2RVZGR4cWFE?=
 =?utf-8?B?YnJLRVd2QU5hTkFEREtMTndnODZlUkNMc1BtQmkvVyt3T2hPMUhXSkpWWEtE?=
 =?utf-8?B?NzZub1NLYXlqd3JTMFFJZC9ZVHh5SkdseUNqRjdTbzgySG9OSjR3bnBIbXh1?=
 =?utf-8?B?SEY3Um4xZzlYYUdzOWp6LzI1R3dGV1F0VDAwWnNCY0Qrek5TWlZsMnM3b2Nk?=
 =?utf-8?B?cDhGaVFJKzgvc0dBUWlnbTdLNlE3YXdaT1lOdjU0V1MzMXZsWmVvUjVtQjh0?=
 =?utf-8?B?cmsrYzZ2ckVINXJocS9VRUFlVGI5L2hmYkw5N3lsM1BtQ2FRVzhDUTVwWjUw?=
 =?utf-8?B?clVJT3dJL0FqS1ZNbTA1anhqaEtVWkRPcVZxL2d2RGxKYm1vbS9hMjdXcjA2?=
 =?utf-8?B?Y0IzcThmUWs4bXlDd0JjNE1wWC9VVjZiZmhKcWFMVlNDQ05sVFZIbXV1UTRt?=
 =?utf-8?B?Vm9jRFVQd0RyVzZSZENJU3NFR2t5Y1dFSkowMy9DVWZRaUh5RHhmb0ppbWNC?=
 =?utf-8?B?ckZBK2JVbmFvcFRkbWNvTXJsVzh5ZTYvbDlXQkhwMFRsMGU5RktqQjhTNWNU?=
 =?utf-8?B?VmE5NE0yZ2JiZXpFZGpXVS9LcEMzOEtwd1c3QkZLUjQyRnVTbm5qK2lyMlNH?=
 =?utf-8?B?anVBKzJQTStYbmp5Qkt1MnJEM1pBZ2JrWU14amhtK0xOdHk1TjBKRWxwNWcr?=
 =?utf-8?B?bVdOeFJBSjBFNXFvdHZkcis5QURtRnREczFZU0tiVmhyQnJmbUpWU0FqTzZq?=
 =?utf-8?B?M3JtbW9jN1hIQ3FPWU1yWngwTTQvY1YwV1JtaGNKYWdmVDBraUFrVnhPN045?=
 =?utf-8?B?S25qN2hTNTNzSGdrNzR1YVc2OFluQ0ZTbFpOWGg2TUVJcWxQL0tIOU0zbGFu?=
 =?utf-8?B?cGF1cUl5bGxyclN3MDdBV0djbmpIbTA3YmlESmZjRXZoclR0MWJqSFE0Vnh6?=
 =?utf-8?B?NjBFNzVQSXMzeUdud1ZkUUY5TC9VWTZ3K082MmtjaTBFR2k1azJ3R3FkSENR?=
 =?utf-8?B?QlVUTUZnMzZla3Y5Sm9xQi8zRkpqTVdoMk1UdVVkOHo0WHcySkpmZEllL3py?=
 =?utf-8?B?RkZ6OFNWdGpNN3FoQXJITHVSVGVmdkd6akRYaXkvbmFQcVJReFZEMmk5TUp6?=
 =?utf-8?B?SENJZWtMZ2lrV2lqRVdkaEd3S1NxbEpFM1hTYlBDaVYxaEt6ekF3VDVteXNF?=
 =?utf-8?B?b3BlVmlRaTlsRWpuRzZsbU5ZOGMwUUVsWlFxaFJaMHB0STZhWXV5NVVlTjFs?=
 =?utf-8?B?TVg4amxXYXVRT1R6RzM1T200NXFxUmVXTDZSWWVvYU5uQ0txZk53dysydm15?=
 =?utf-8?B?SWpycW42cW5MVEp3UGUvNDNPVlF0ZUU4bGc2WFRaS1o3Z2ZOTlVISzdkZEZS?=
 =?utf-8?B?VHNxSE1rN0R6T2EzbGJjZFlWQll4WmorTUJUbEdvQTFLY05URnNRNkd5Ti9P?=
 =?utf-8?B?bG1hdkptMHhQMml4cVpRc2NGMnVQZ0p2c29WNmN4RzlxWmlQK0pXRUljdkhD?=
 =?utf-8?B?K3FtOUNnSEx2WE1sYi8zOGtIK0hnSXZBY21VU0pXb3VuOTNaZDlVM2hFMFNi?=
 =?utf-8?B?SVQycnRHNE5yT01wMnFUeHlwOHcyeWtrZzg1RTZPcHA3WXNiOWtrcGY0MFVU?=
 =?utf-8?B?S0tjVHZlc0YwVTBOUlRJZ2xwMTNIQU5ZVGQwN09wOWdEZUpqQjByU0RpdjVi?=
 =?utf-8?B?blZLVElkWEExTGdmOS90YkJDaDQxbWNSVWtrN3FROEVLSmJXL1RQRVNiT3kr?=
 =?utf-8?B?OGYyUkUzazZJTHdnZ0VtQlpaWmViUVJlejM0Q0FheTFHbkU1VFh1TU1XeHIv?=
 =?utf-8?B?ZDRvc3ZJbnV2NXZpZ3lmTk04YWtxVmRvVXpsc3F2TldaRURFZzFWa3lQajdn?=
 =?utf-8?B?Qzl0dXlkcUE0RkREVGw3S0QzcjRjRE5KdGZqeEh2ZUdYN1ZyL1JTQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf8e117-8359-4209-444f-08dee9826607
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 12:52:19.4707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7O2p6gxAOPx1XcMdLEP99Qbbz5iJCgj6SPLx2UsSVEy2nIUwscY3FfhMXbRODC5NW4NiIy5N/hTCvlCC3IAfWFCw0HM/4idaj4DmOLBB01U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17480
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

SGkgS3J6eXN6dG9mIEtvemxvd3NraS9HZWVydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBCaWp1IERhcw0KPiBTZW50OiAyNCBKdWx5IDIwMjYgMTA6MzMNCj4gU3Vi
amVjdDogUkU6IFtQQVRDSCAwMS8xNl0gZHQtYmluZGluZ3M6IGRpc3BsYXk6IGJyaWRnZTogcmVu
ZXNhcyxkc2k6IERvY3VtZW50IFJaL0czTA0KPiANCj4gSGkgS3J6eXN6dG9mIEtvemxvd3NraSwN
Cj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gU2VudDogMTIgSnVseSAyMDI2IDE2OjI0
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8xNl0gZHQtYmluZGluZ3M6IGRpc3BsYXk6IGJy
aWRnZTogcmVuZXNhcyxkc2k6DQo+ID4gRG9jdW1lbnQgUlovRzNMDQo+ID4NCj4gPiBPbiBXZWQs
IEp1bCAwOCwgMjAyNiBhdCAwOTozOTowMUFNICswMDAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+
IEhpIEtyenlzenRvZiBLb3psb3dza2ksDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0aGUgZmVl
ZGJhY2suDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gPiA+IFNl
bnQ6IDA4IEp1bHkgMjAyNiAwOTozMA0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzE2
XSBkdC1iaW5kaW5nczogZGlzcGxheTogYnJpZGdlOg0KPiA+ID4gPiByZW5lc2FzLGRzaTogRG9j
dW1lbnQgUlovRzNMDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFNhdCwgSnVsIDA0LCAyMDI2IGF0IDEw
OjM0OjExQU0gKzAxMDAsIEJpanUgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIFJaL0cz
TCBEU0kgSVAgaXMgc2ltaWxhciB0byB0aGUgUlovRzJMIGJ1dCBoYXMgZGlmZmVyZW50DQo+ID4g
PiA+ID4gZ2xvYmFsIFBIWSB0aW1pbmdzIGFuZCBhbHNvIHRoZSBQTExDTEsgaXMgdW5nYXRlYmxl
IGNsb2NrLiBBZGQNCj4gPiA+ID4gPiB0aGUgY29tcGF0aWJsZSBzdHJpbmcgInJlbmVzYXMscjlh
MDhnMDQ2LW1pcGktZHNpIiB0byBoYW5kbGUNCj4gPiA+ID4gPiB0aGVzZSBkaWZmZXJlbmNlIGZv
ciB0aGUgUmVuZXNhcyBSWi9HM0wgU29DLiBUaGUgcG93ZXIgdG8gRFNJIHJlZ2lvbiBpcyBjb250
cm9sbGVkIGJ5IFNZU0MgYmxvY2suDQo+ID4gPiA+ID4gRG9jdW1lbnQgcmVuZXNhcyxzeXNjLXB3
cnJkeSBwcm9wZXJ0eSB0byBoYW5kbGUgdGhlIHBvd2VyIGNvbnRyb2wuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIC4uLi9iaW5kaW5ncy9kaXNwbGF5L2JyaWRn
ZS9yZW5lc2FzLGRzaS55YW1sICAgICAgfCAxNSArKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQNCj4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L2JyaWRnZS9yZW5lc2FzLGRzaS55DQo+ID4gPiA+ID4gYW0NCj4gPiA+ID4gPiBsDQo+
ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlk
Z2UvcmVuZXNhcyxkc2kueQ0KPiA+ID4gPiA+IGFtIGwgaW5kZXggYzIwNjI1Yjg0MjVlLi5iMTE0
YWMzYjExMWEgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvcmVuZXNhcyxkc2kueQ0KPiA+ID4g
PiA+IGFtDQo+ID4gPiA+ID4gbA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9yZW5lc2FzLGQNCj4gPiA+ID4gPiArKysgc2kN
Cj4gPiA+ID4gPiArKysgLnlhbQ0KPiA+ID4gPiA+ICsrKyBsDQo+ID4gPiA+ID4gQEAgLTI4LDYg
KzI4LDcgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gPiAgICAgICAgICAgIC0gY29uc3Q6IHJlbmVz
YXMscjlhMDlnMDU3LW1pcGktZHNpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAgLSBlbnVt
Og0KPiA+ID4gPiA+ICsgICAgICAgICAgLSByZW5lc2FzLHI5YTA4ZzA0Ni1taXBpLWRzaSAjIFJa
L0czTA0KPiA+ID4gPiA+ICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA5ZzA1Ny1taXBpLWRzaSAj
IFJaL1YySChQKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICAgcmVnOg0KPiA+ID4gPiA+IEBAIC0x
MDgsNiArMTA5LDIwIEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gICAgcG93ZXItZG9tYWluczoN
Cj4gPiA+ID4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArICByZW5l
c2FzLHN5c2MtcHdycmR5Og0KPiA+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4g
KyAgICAgIFRoZSBzeXN0ZW0gY29udHJvbGxlciBQV1JSRFkgaW5kaWNhdGVzIHRvIHRoZSBEU0kg
cmVnaW9uLCBpZiB0aGUgcG93ZXINCj4gPiA+ID4gPiArICAgICAgc3VwcGx5IGlzIHJlYWR5LiBQ
V1JSRFkgbmVlZHMgdG8gYmUgc2V0IGR1cmluZyBwb3dlci1vbiBiZWZvcmUgYXBwbHlpbmcNCj4g
PiA+ID4gPiArICAgICAgYW55IG90aGVyIHNldHRpbmdzLiBJdCBhbHNvIG5lZWRzIHRvIGJlIHNl
dCBiZWZvcmUgcG93ZXJpbmcgb2ZmIHRoZSBEU0kuDQo+ID4gPiA+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQo+ID4gPiA+DQo+ID4g
PiA+IFRoaXMgZmVlbHMgYSBsb3QgbGlrZSBhIHBvd2VyIGRvbWFpbi4gUGxlYXNlIGVsYWJvcmF0
ZSB3aGF0IGlzDQo+ID4gPiA+IFBXUlJEWSBhbmQgd2h5IHBvd2VyLW9uL29mZiBhbmQgcG93ZXIg
c3RhdHVzIHdpdGhpbiBTb0MgKGltcG9ydGFudCEpIGlzIG5vdCBlbmNvZGVkIGFzIHBvd2VyDQo+
IGRvbWFpbi4NCj4gPiA+DQo+ID4gPiBXZSBhbHJlYWR5IHRyaWVkIG1vZGVsbGluZyBzaWduYWwg
YXMgcG93ZXIgZG9tYWluIGluIFJaL0czUyBhbmQNCj4gPiA+IGZpbmFsbHkgVWxmIGFncmVlZCB0
aGF0IGl0IGNhbm5vdCBiZSBwb3dlci1kb21haW5bMV0NCj4gPiA+DQo+ID4gPiAiIFNZU0Mgc2ln
bmFsIHNlZW1zIGJlc3QgdG8gYmUgbW9kZWxsZWQgYXMgYSByZXNldC4NCj4gPiA+IEFsdGhvdWdo
LCBpdCBsb29rcyBsaWtlIHRoZSBVU0IgUE0gZG9tYWluIHByb3ZpZGVyIHNob3VsZCByYXRoZXIg
YmUNCj4gPiA+IHRoZSBjb25zdW1lciBvZiB0aGF0IHJlc2V0LCBpbnN0ZWFkIG9mIGhhdmluZyB0
aGUgcmVzZXQgYmVpbmcNCj4gPiA+IGNvbnN1bWVkIGJ5IHRoZSBjb25zdW1lcnMgb2YgdGhlIFVT
QiBQTSBkb21haW4uIg0KPiA+ID4NCj4gPiA+IFRoZW4gUGhpbGxpcCBwcm9wb3NlZCBwb3dlciBz
ZXF1ZW5jaW5nIGRyaXZlclsyXSBhbmQgZmluYWxseSBoZSBhbmQNCj4gPiA+IFJvYiBvayBmb3Ig
dGhlIHNvbHV0aW9uIFszXQ0KPiA+DQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCB5b3UgZGlkIG5v
dCBpbXBsZW1lbnQgb3IgcmVmZXJlbmNlIGhlcmUgcG93ZXINCj4gPiBzZXF1ZW5jaW5nLiBZb3Ug
Y3JlYXRlZCBwaGFuZGxlIHdpdGhvdXQgY29ycmVzcG9uZGluZyBhbnkgaGFyZHdhcmUgc2lnbmFs
IGFuZCB1c2VkICJkcml2ZXIiIGFzIGFuDQo+IGFyZ3VtZW50Lg0KPiA+DQo+ID4gcG93ZXIgc2Vx
dWVuY2luZyBkb2VzIG5vdCBtZWFuIHlvdSBjYW4gc3R1ZmYgcmFuZG9tIHBoYW5kbGVzIGhlcmUg
YW5kIHRoZXJlLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIHBvaW50ZXJzIGZv
ciB0aGUgYmluZGluZyBhbmQgb3RoZXIgc3R1ZmYgdG8gbW9kZWwgdGhpcyBhcyBwb3dlciBzZXF1
ZW5jZQ0KPiBkcml2ZXI/DQo+IA0KPiBTWVNDIGRyaXZlciBoYXMgUFdSUkRZIHJlZ2lzdGVyICho
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4
LQ0KPiBuZXh0LmdpdC90cmVlL2RyaXZlcnMvc29jL3JlbmVzYXMvcjlhMDhnMDQ2LXN5c2MuYz9o
PW5leHQtMjAyNjA3MjMjbjI4KQ0KPiANCj4gSXQgQ29udHJvbHMgUFdSUkRZIHRlcm1pbmFsIG9m
IFVTQiwgRFNJIGFuZCBDU0kNCj4gMDogUFdSUkRZDQo+IDE6IFBXUlJEWSBkb3duDQo+IA0KPiBZ
b3UgbWVhbiBQb3dlciBzZXF1ZW5jZSBoYXMgYSBoYW5kbGUgdG8gc3lzYyBJUC4gUGxlYXNlIGxl
dCBtZSBrbm93Lg0KPiANCj4gVGhlcmUgaXMgbm8gb3RoZXIgcmVzb3VyY2UgYXBhcnQgZnJvbSBw
aGFuZGxlIHRvIFNZU0MuDQo+IA0KPiAgICAgc3lzLXBvd2VyLXJlYWR5IHsNCj4gICAgICAgICBj
b21wYXRpYmxlID0gInJlbmVzYXMsIHI5YTA4ZzA0Ni1zeXM9cHdycmR5IjsNCj4gCSAgcmVuZXNh
cyxzeXNjLXB3cnJkeSA9IDwmc3lzYyAweGQ3MD47DQo+ICAgICB9Ow0KPiANCj4gICAgcGh5cnN0
OiB1c2JwaHktY3RybEAxMWUwMDAwMCB7DQo+IAkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEw
OGcwNDYtdXNicGh5LWN0cmwiOw0KPiAJCQlyZWcgPSA8MCAweDExZTAwMDAwIDAgMHgxMDAwMD47
DQo+IA0KPiAJCQlwaHlyc3QtcG93ZXItc2VxdWVuY2UgPSA8JnN5cy1wb3dlci1yZWFkeSAxPjsN
Cj4gICAgfQ0KPiANCj4gICAgIGRzaTogZHNpQDEwODUwMDAwIHsNCj4gCQkJY29tcGF0aWJsZSA9
ICJyZW5lc2FzLHI5YTA4ZzA0Ni1taXBpLWRzaSI7DQo+IAkJCXJlZyA9IDwwIDB4MTA4NTAwMDAg
MCAweDIwMDAwPjsNCj4gDQo+IAkJCWRzaS1wb3dlci1zZXF1ZW5jZSA9IDwmc3lzLXBvd2VyLXJl
YWR5IDI+Ow0KPiAgICB9DQo+IA0KPiBDdXJyZW50bHkgaXQgaXMgbW9kZWxsZWQgYXMsDQo+IA0K
PiAgICBwaHlyc3Q6IHVzYnBoeS1jdHJsQDExZTAwMDAwIHsNCj4gCQkJY29tcGF0aWJsZSA9ICJy
ZW5lc2FzLHI5YTA4ZzA0Ni11c2JwaHktY3RybCI7DQo+IAkJCXJlZyA9IDwwIDB4MTFlMDAwMDAg
MCAweDEwMDAwPjsNCj4gDQo+IAkJCXJlbmVzYXMsc3lzYy1wd3JyZHkgPSA8JnN5c2MgMHhkNzAg
MT47DQo+ICAgIH0NCj4gDQo+ICAgIGRzaTogZHNpQDEwODUwMDAwIHsNCj4gCQkJY29tcGF0aWJs
ZSA9ICJyZW5lc2FzLHI5YTA4ZzA0Ni1taXBpLWRzaSI7DQo+IAkJCXJlZyA9IDwwIDB4MTA4NTAw
MDAgMCAweDIwMDAwPjsNCj4gDQo+IAkJCXJlbmVzYXMsc3lzYy1wd3JyZHkgPSA8JnN5c2MgMHhk
NzAgMj47DQo+ICAgIH0NCg0KDQpXaGF0IGFib3V0DQoNClJaL1NZU0MgZHJpdmVyIGluc3RhbnRp
YXRlIFJaL0czTCBwb3dlciBzZXF1ZW5jZSBhdXhpbGlhcnkgZHJpdmVyIGFuZA0KRFNJIGRyaXZl
ciB1c2VzIHRoZSBQb3dlciBzZXF1ZW5jZSBkcml2ZXIgdG8gY29udHJvbCB0aGUgcG93ZXIgcmVh
ZHkgc2lnbmFsPw0KDQpJbiB0aGF0IGNhc2UgcmVuZXNhcyxzeXNjLXB3cnJkeSBtYXkgbm90IGJl
IG5lZWRlZC4gVGhlIHBvd2VyIHNlcXVlbmNlIGRyaXZlcg0Kc2hvdWxkIGdldCByZWdtYXAgZnJv
bSBwYXJlbnQgYW5kIHVzZSB0aGF0IG9uZSBmb3IgY29udHJvbGxpbmcgdGhlIHB3cnJkeSBzaWdu
YWxzLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
