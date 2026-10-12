Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5D7CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6826710F597;
	Tue, 13 Oct 2026 07:53:11 +0000 (UTC)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn19012012.outbound.protection.outlook.com
 [52.103.72.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E1810F2E0;
 Mon, 12 Oct 2026 18:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xckwAIpn3vv85hmtgq3MGVUUgNZpdgWhlifIYSGtxYsn55A2riVszM/r7A1bwlu6gFjXjTlMQIVDmI8/VmWVp+kH9SbWrdDNFYdZTJmL7QIIJj7p5iVb7pDDYoB/WDNKx6uENp+D0gEhj4SLUhFC0+21AscGR+8Y1hep+Qk7Yx74MCknwM/wHeqcmUf1Bk54YqHnloAHt5fxDRrBqvsh5D465U56j9VNG8t71/yOAi7RaWrH7jSNjzinSCDvuRVI4gywUjTkkRWt1FS3RFuPq4mdBCgWsDiSAGVLe7/ZQhN6otmbXvRUVw2O8F+P7HCbNe9YcO/wjPq53iiESJhvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAnH6qsmyN9m0E2uwAxN57Vb+wDSzUyUrX7Kj46nyZk=;
 b=id9d9jV9ppj4bZPhoEo+WvKpR26+wBc0ROkGddXdrRFLecY3i/s7GC+tJscsOWwyr8R/g/VRGIw7UPJz5uwvr5j5se6fatPsuOBmU9uldNv2HjG8IfHpn3U5pjN1PnREZd01RkTMzAmTbVeX3Q6U8XRPAssi7HizsNr4vnaIXwhvZ4tFyrFOn46YG63v+6FQwd7q2i90mWJG9fjZ3APFvLTWSgVZpEfrfjPT+OFB0w3kjLIEChCRHDjoNV8VzBj8TNrzb01pEWOoO67byUi7X8jDGEdJidUj5AEhEMM34Vb9bByo2a3sseoJUoLA6yW0XXUZfgaJiG0+hoWalothUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAnH6qsmyN9m0E2uwAxN57Vb+wDSzUyUrX7Kj46nyZk=;
 b=VVejdKMx50TBRTH+eEOXLcFUDSGAUa/KqpsWD6o4w+R1DLQkJiE0/8eJgl1I7gp+U5mTZP4FYhFjYYaBBuVnK6UUW34m3Yp497TdQhqVXb+h4Ig/KKp89YZMqAI5Z0tYTaULTWqW6uFk3RccJvjU1Awv46G8RDymbAI+xknrl+vTaUcPJ0vsRXKwKwSPNSR+e2Dd23iyCMpMU7D1HVeNEnCnrHHa8KliF+7l1rICnQ12mH7pxKJVNVUCK4kadAWcYuPn/DgL5iQM5H3exWuNiBobxDLFAa7nkNgWfEU9EgJjcdKD7g0H3WjmpHJl90UAjVxEl8Q5AK/l4GAc1BU4HQ==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY7PR01MB8900.ausprd01.prod.outlook.com (2603:10c6:10:21a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Mon, 12 Oct
 2026 18:44:39 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.011; Mon, 12 Oct 2026
 18:44:39 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
CC: Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/3] drm/msm: correct DSC RGB and command-mode vblank
 handling
Thread-Topic: [RFC PATCH 0/3] drm/msm: correct DSC RGB and command-mode vblank
 handling
Thread-Index: AQHdV3U6XlRrfQVtoE2pt31EYdhCw7b5f/MAgADEljU=
Date: Mon, 12 Oct 2026 18:44:39 +0000
Message-ID: <SY5PR01MB10600F65F1EE8B710159B2988A19F2@SY5PR01MB10600.ausprd01.prod.outlook.com>
References: <SY5PR01MB1060041363FC41A7F40DF59DBA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
 <6e67b0b2-8bae-4568-a276-56f9db360b80@oss.qualcomm.com>
In-Reply-To: <6e67b0b2-8bae-4568-a276-56f9db360b80@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY7PR01MB8900:EE_
x-ms-office365-filtering-correlation-id: 8dc9a39b-9026-47ce-f7b5-08df2890df3a
x-microsoft-antispam: BCL:0;
 ARA:14566002|38102599003|24021099003|15080799012|39105399006|25010399006|22091999003|25031999004|24121999003|4140399003|31061999003|8060799015|19110799012|8062599012|40105399003|41105399003|18071099003|26121999007|2607281247196008|102099032|3412199025|26104999009|440099028;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ki+R63OEXQ9wcm2M8MX3aqpbmDXxGp21vZxQk4J/hJqb1KcF2IyKG2eFItmt?=
 =?us-ascii?Q?mCY2YBHI83GbigQtZ+Y5R6hcZNQKLos+/XLwfz+ADajP0RnFze/iZux3sxUN?=
 =?us-ascii?Q?J4WXHrvVsnRtuySHrJruv30NxuYJ4RwQvLUR5GRUc9sFnWKSPLpkirgY2Zcv?=
 =?us-ascii?Q?dpdiZl9Wg1aPjD6FlqXEt5DoMComAvrSqtsTBr6OqT9zvmCzb4LapFLUILs0?=
 =?us-ascii?Q?EtleQ0FBupJWQYRKWJ/f2Pfj3f29v0KHU2vt3YmdD4oUl9hh1RC+dLxCXhQI?=
 =?us-ascii?Q?IQh1YUDo6YI5WnTQuz8HIcHuXGYUrF/FkqlWAJNaWGUJmxVjhzGSVcsw5KUq?=
 =?us-ascii?Q?Lrhh5/Y88CU6IpQ5UFSpNsroxbH6Ka8XD99mClc+0k59+AIN/B5Usz2FGcpf?=
 =?us-ascii?Q?E35c1pp9auIXqTawEHSbHW/7B8qDPqJjJhlg0o2JIVpijRlzPD4ZGHaUPuKC?=
 =?us-ascii?Q?yCuplouC2Y9BBN0JN8MJ/TOkdgRNDbyXUJNQjRD2nla9o5NGFsniIGs9BH5a?=
 =?us-ascii?Q?YgDCjYUQDsQfN1MAmS7WJxX0Ye/mYjr1G1VjpnJIcQlr1tC5Sp0Fa5arSz2H?=
 =?us-ascii?Q?jcUZoaWD6cLRxHHuyUbw0M6738fDUKTIpLQPRnqL4+k9CJ+qa7YHnMz7cxyB?=
 =?us-ascii?Q?+0fyRwIzJpXymmT0AL5+VGAsP42hjx14eJYoB6o3ZPvYAUR/rPsO4DHS1RIK?=
 =?us-ascii?Q?5UMe0rO+t6FmtUMixaBF6FLefwSvpf/mIMMlzHM77hEYtTO6Zj39Kh8bHE2J?=
 =?us-ascii?Q?2G/wPwNlcCgMTY9I/wtBHi+nOLl2a9fSCY9/MT5gmS1C+8iEu8U7Et1ieri3?=
 =?us-ascii?Q?EK7gNmoIysUtfZNAXA7TvcdixuWXYwHLqvzGhftzLEPcD0SeQW43bxyAP4Sp?=
 =?us-ascii?Q?KibTcbNcvqaeSnodw7yYqmQQOKSK+N9vqOFaiwouxjuywNkyuYSCWaeSXT2y?=
 =?us-ascii?Q?8Ot/dWih+g7GTfF++XYXgLbtl16yIBXODahfLQdclKCRKjvvDcLo6I9qP8gy?=
 =?us-ascii?Q?4YxaiXXJsL9SEcS02+C4m5xzLhmmr8aDIlD9D7J5e1UYpMtXqZpGuehPVILL?=
 =?us-ascii?Q?yE+j5+oxEWHXwZZqEiJra1wx5oUL4oZjXw1LmTPBjaoQ+avSUmFw7ty0YOCK?=
 =?us-ascii?Q?tLB/XTgwQEXj9NxKaebivrC+ESQ1xxfVhkkMwdJdHhlvM9smCBV6IH8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agLcBjnZos0vn5R6xgL7Eh/REhvCfkKCbyKvTdkYST0oQ57bP8tzfcyVVILR?=
 =?us-ascii?Q?NKwjwfzOoYVFMTBLKofQNxXWsKH8WQFMmvSB/oqa7i4SnNGiVHW42poOxzfZ?=
 =?us-ascii?Q?G8D1b76Sz64hz2NmCjjEkwEmB/0bKIYCmIsBpHrkZ434rd3BqWaD/qtTVI18?=
 =?us-ascii?Q?Fk/OAmD4gXDs0+WLaPJNoRZtTChDZ65mwI1ZGYlTk6pCZLoHPzLMwH1wLr9b?=
 =?us-ascii?Q?d/YzPc5Xqk+YI2jY5QFWpevkxDsK7Fcf92OxDftvY7cp0LAaWRqjcYy5yRvg?=
 =?us-ascii?Q?AME8OdJdAhfssGrBE2GNGxF94fkv14pffrCCmZB9XF4K4PDjCazjufYng1vv?=
 =?us-ascii?Q?6vNOK8T+ZKl72ACCAyjaFGvq35RngxaVURa5tFQLNhMMeEsHtb3fgDB2SeaZ?=
 =?us-ascii?Q?vZiShw2jXVOAHGXOAv2qp5+xwJC5QuE/cdOrOq1u4vWSLS4ab8S9tCtbLxMN?=
 =?us-ascii?Q?PNGm3pQ/H3wVpHH27OB7N7ngjrNAYTVcc6QnD1b2VzRYfAp5H+P5fpm48BlP?=
 =?us-ascii?Q?fF0dxj0xfDUOXfw1vROYeOsexbWW74YLP601FGOA27851bW2FTkiSHwTGCnU?=
 =?us-ascii?Q?AFIyMTXO2hYNSycXTRln7t2TzqjQKwJBkNlVTpEHqz5HKtiMXhqHFwfCad+i?=
 =?us-ascii?Q?eNSF4FDiHG8oNIfzLTYT6Ek4/6fiX+cx9Q3vm5jFLBnwoEHcQUGmhj3Oh1hQ?=
 =?us-ascii?Q?s0u+3lPHlijn6qIZxReqF3Mz+RFN1ykwF5F569x0tuQRy5P2tKs1GAz0rcxm?=
 =?us-ascii?Q?rOlpIr/MFYcSqryFt5C99DXY36SM98cTSyzSKFw3qFBV/bvBfrb5Z5khnxm/?=
 =?us-ascii?Q?P6dpa9pWgii0Bofb9V8DXsjyiVWfGQcImiTxmOC7mKPkMyedss9afRmBwtFj?=
 =?us-ascii?Q?QYhkhi4d6Kot2RAaW5852pjuTNX0cwmwAGa86ZTOLlyK28qA62qNVCGJf7C3?=
 =?us-ascii?Q?u4ddDFcTcyvfABQnbmOW67c75RWlPzgxLKY5MhVg1HprS/rb+a/cfZO6hm91?=
 =?us-ascii?Q?+eRxxDd/0nZrgXQIXvZ3u+MlmU5xlNa/HxCPOq4H9fobeno1w2RUELL8tfFB?=
 =?us-ascii?Q?DR74fiWFPGxC9H4zT732q47a994bNA6UArt5olSU4PWzvLusTwq0Nr5XaP+I?=
 =?us-ascii?Q?5w3fjXPrO2QF1sljvJ8dAaPd4AgWl+yQzJOB0LNJ+qNnDKsbRTHBIPYG6cWP?=
 =?us-ascii?Q?lJ/4cM2FP+OazS3qc84sSlesTMeorhvHSP1+rdQj8hJ6O3UxHZa8Tst9A+HQ?=
 =?us-ascii?Q?QkQ0HWLdUVfMcGLRR3mstNs5Jp+HeOX87a9r0BYtnC7FnwBEYJ4pUawp/1+j?=
 =?us-ascii?Q?HcoWvR3Y8UybRzXF8ZMWu8YXNLbhsqt/NQ8VWlklOygpTagh0mJ9SAgnAsau?=
 =?us-ascii?Q?TBDwSUS5GLrTV7AwtVeb57eoSXZq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc9a39b-9026-47ce-f7b5-08df2890df3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 18:44:39.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB8900
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

Hi Konrad,=0A=
=0A=
Thank you for pointing this out. I sent the patches as separate messages,=
=0A=
so they were not threaded correctly under their cover letters. Sorry for=0A=
the inconvenience.=0A=
=0A=
I will use b4 to prepare and send future revisions with proper threading.=
=0A=
=0A=
Best regards,=0A=
Jiaxi=0A=
