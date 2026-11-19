Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65468606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ginzinger.com header.i=@ginzinger.com header.a=rsa-sha256 header.s=selector1 header.b=J777axGv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA36310E84B;
	Thu, 19 Nov 2026 10:27:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020121.outbound.protection.outlook.com
 [52.101.84.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BC010E84B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8mF+hII/yqpTql56hIaxOsp8yjCuHVF+q2l2T4scvT9JHVAv6J+oq1D7rZXi3uor7tczMdW4wIYD6oWDzndcMmWwizUduFcnjQSxE/UKwPj/jCPnoW8hGjcqFCeWPkM+1LsALggCpPyDSyNtQR9bYNe49EvHNIPhsetWMMwaMm5LE+66L1/ncjtC/g7vNAmgZPJVrjZObavg4QbjPq8GfuCB8CseSWWB4usiLzuMkyy7v8GWKeXc5DBuw0gIjvA/p5+E8VjSeBmt/Omx9UgR2M7HIehkjw2AlJaaKbonCmZLUDThImgLFVKlZpq+535cpKUMama6vN97h9HzYKLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjlW9G2aP+vcFoe+aP1dIE9/axlElj2NpZRvtqsft34=;
 b=Gp8Dl6GN5vS0ujaR/Ys0wGgsEt6qjMgsiaqbBYtpW3zKGjM41+ymOORnE0B2MinMrYotNJoa/Q5cXN80BolyVCtayurW+dTmsLjSV+FlKnLyt75QNGWDWB+COWtBBm3Rm6s8py7gGum3opUvN1kl5Kcub20hfl1NX/FlSb/+4qxgiGNv0qPNvPcwifu096G/HAzkTAQkA+5aPQI1WnIaCMlDxsn5G0vnfqT69dPKaVcTHRPrPFILHpEkjDwExlqoFXZC8FSxSAweVY8JE4fQges4B+7rKX2ZCzNFetcntRsP+TQdYFLButjx/9w/pxPU3TopAPGvpvyeZ5qOCQNIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmx.de smtp.mailfrom=ginzinger.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=ginzinger.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ginzinger.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjlW9G2aP+vcFoe+aP1dIE9/axlElj2NpZRvtqsft34=;
 b=J777axGvV3+gGI+7hfPj+uLylZ/TT3g2i5u2O5o8HrhSyMvyv60H0qzzwClQOGng3pOxzGcPyacEdQfyxp3Y0U9vcmzUCTSpxOk5DR8QAlaLmDl2CQyw7SRvmYMBuZpMYVCKuIzXXQ0O9rCyRKCdxTgin9qXU4B89SNmxRVRRlvL68+X4uFOvMCpoaPlBdQlqbjxZB7R6f/67yjYRL3N9v24/RN/YswTnfwbnUH4AI2gRd6CAFfmbltHQCrzOwHw6TF0U8xXQYKjB/O0v3y4AnjxBagCiYNIKOrttvUNQ8qET/kPJ3sQMuTA42/NsFIffTMIUcxY2+zwe/POruZFQQ==
Received: from FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:cc::12)
 by DU4PR06MB999645.eurprd06.prod.outlook.com (2603:10a6:10:63c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:26:56 +0000
Received: from MI3PEPF00008487.eurprd02.prod.outlook.com
 (2603:10a6:d10:cc:cafe::f) by FR4P281CA0055.outlook.office365.com
 (2603:10a6:d10:cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Thu, 19
 Nov 2026 10:26:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195)
 smtp.mailfrom=ginzinger.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ginzinger.com;
Received-SPF: Pass (protection.outlook.com: domain of ginzinger.com designates
 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MI3PEPF00008487.mail.protection.outlook.com (10.167.240.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:26:55 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.102) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 19 Nov 2026 10:26:54 +0000
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 (2603:10a6:20b:756::23) by DBAPR06MB6933.eurprd06.prod.outlook.com
 (2603:10a6:10:1b1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:26:52 +0000
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b]) by AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 10:26:52 +0000
From: Roosen Henri <Henri.Roosen@ginzinger.com>
To: Helge Deller <deller@gmx.de>
CC: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: BUG: Linux kernel regression: full screen logo
Thread-Index: AQHdd4dK4l7VcHagp0WmMQqpafib17c1MaSA
Date: Thu, 19 Nov 2026 10:26:52 +0000
Message-ID: <c4a479738a82f805068d16b5b0c65b8bca9a20ff.camel@ginzinger.com>
References: <074e66817a069dca965d9c258606f23fbcb2e1a3.camel@ginzinger.com>
 <d734924c-6083-405d-8ef8-d0d522d6a187@gmx.de>
In-Reply-To: <d734924c-6083-405d-8ef8-d0d522d6a187@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=ginzinger.com;
x-ms-traffictypediagnostic: AS5PR06MB10652:EE_|DBAPR06MB6933:EE_|MI3PEPF00008487:EE_|DU4PR06MB999645:EE_
X-MS-Office365-Filtering-Correlation-Id: 59023476-f983-49ab-1209-08df4627a295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: fEB58AwqVSQsbEvvjOYUDZGB56qKwVrKG1SkHi7BrJsFEOyxTL3ha7UK10hWtGI+duXMKZYx6idQjHUUal5LfuPaKkXaAiVPvQEer+iTeqdGm5Bl0+mKX0Tj4R8MvK/ZZwmTORWs/Pbxu5hfJL+p2pzmJBoiXrGTQpLvXl2uYzFY9OFxEYLDhRTKsU5dXYWFF6LhcexWdT1yTVGlg3nylKOMqrNXqPF8oFu0Uv8gTabwCVo91ZIDSn8ECqgI2BO7rkjopqB8suBLtSeS92GoF+embCIzb8NDGo+nutZmlhjW3TvsXnpy/BXnaVY2BMeYghZCGr4sxw8pbXTy7D2yaEKTtyZm5OspKhguXIJUaYA5Cmv54gpzewugiooTW+XwqffL7wT2tO4OVPnRrtUOTRIoeUCZ5fv5TeyfhEpObtqxaY8WYG1BGajZ30zAQJxJSooXFuVS4uftajACoFPg2GFRuNGoTCCr3eMugtieQ+JSRU6nsEve583t21UKmM3/VxMA6UKu5whnI2yBCN4dTa0oTPSrqP3M93B0P4sUi/qib+UMeYrpAVCoRgih95utcGXvSaTBPSBO0jSxbPQTi+Rik1mb4XqttuR98X3vxmxFJ/U6dwfye47OzlyPYkvNBWEsCrCYVRVpPrIjVoj985dG9nCb39x5/qN5oY7xTJKpsgZ3o3EaN/2M4Nmcx5Ein8ZBZ5J7iMb2ReMT/aTYd0IHOKikum3We/Rf+wq/Td0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS5PR06MB10652.eurprd06.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <66FD1C59BF830C4DAA4F0DF5BBFEC7BB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pXOJNiX4BPBIeoC1ObttNPgEF97oft6y7ISws/tVPEgPBZvFuUGDvAdU7tk/sKkGJHdZuoZ9JtT0QwFAApJcNvsivaqWtmeSwIpKO4JQk9V/WALuYi14OAFkWsxha18ek3ev5XHcoqI0Su0E0PaGTFTczXXeUfa45AoynleoUjnXCFK42Tb7X7kCe0zFHrGWShy0aTkcZPiEhics1Eh/R9QZljoVD5Ehc6yUeMrU3YQOntE+ZpiQpdH7LP9E4XXfITlRjhxGBGLzsmIQ03BzJk8IFGOf+GN6jSL/YzBZ66y5iSxe348HOg4CEeQw3A7nOdn4gdxiYxyejVM+S8hNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6933
X-CodeTwo-MessageID: 8d2e02bc-561a-4c8e-874c-ff35da5c8624.20261119102654@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008487.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6932e1e0-932d-424c-3ba0-08df4627a0a2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|23010399003|35042699022|376014|82310400026|1800799024|261028144727099003|10067099003|4143699003|11063799006|56012099006|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261022075727099003|261022105027099003|261022115727099003|261021121427099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: w7ctd1PLKEFuSorvNKU0EOTwhGwBOOSl6gYKlD5ZPB1DqnaelIuQNOWyyHHmmVhuKqalUnh714QHulxQ6qX9QNKJpaAIncd3TvCyu4UITFgWaOcbS1HChqAztTYN5G8XNqODxI6S7oc+Do9FsdAo3uJ3lGTt+a53RVb5PvG5B8uXuxV1QbcxJKHTquTTabB+UViucHIk9vgz71F5yOVhzo9MwzW2PZs1V/km/yNO76Ujx/YvdQz0pnqUxQXTIwmRHb2pC37gOrDk4v8FMsv7DiBBHg06SpS7Kw4pvXh2fCAKiTAVxgrpQxvsbgl/2SlCsjALoT8o7GYGVf6t8pmfNCsU76Wjc7900ktr4TNCUhmXGgko8pLdVDEZbrdWbV1XZVxde3O4TW5od2sb+91EotXxXTTnokuEwWhfK8PXKDq5R5cGehLdJgh4aBOo87XIh/lO8VKWFHRZY2X9B4+j2+2ageNk52T7osPDjg3/RDEnfm88YLI23Za6N5NGsMS3zPWhSTI7LsmACJDMTZNNTLybJRK0TtrPgab+r8QcrkZYHmTNUh4EkcFRG5KfCN48v3M1WcOW96n9cycrMMY9j1bgYwVMgXejGlQA+MhDp4mPJQbQ00er/qK3CtEQHTW4qdrYlcXSDuLCxrM+4e9/rlq8lh/bA2eyrvmwDP5YM8MyLrCLzXmRgMzasKpVPoKG/8FDU6jsY0ll8xkvOKeCug==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(23010399003)(35042699022)(376014)(82310400026)(1800799024)(261028144727099003)(10067099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261021121427099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ASriLXFIWzZ5OAdjeR6fGyHj7ruCCk08dipMLUt7CJskh3lw0s93nE1yRyPQhNRTNvnavwEX8msGTh+Kl9T6ASxdHIA7DBbCccnjkGII10SCa/Tb2HrigiS1ggXOLBQK7+BGYUs0uVRVfK7Gy88J7MiD8TYIJWS1gLGFFsfR8cfJXJNGlwKpcENwTnFIVgxckIYfiY2q1J823xAnRrI+ZDuISjmI+9gGPQQIEhbiq+irS1V8RXGp1GVbgbz1GEAJUa+INSoutL6ArVr6GKtyWVxnqfxnendqFO45vUEi0W/H9cZ/LYzwGTassUJe35tgCTfSXWkkAkjnkur8C8MCDfwECLZPDhzyeqPcF5Sob60xlzCbhi3F9V6MNwkBsWTNKWcj5pCh7zSTTsnWjs6pF0Mbp1uuBUtyqhVDMx0BTRGBtPeVWYfdkNyV/x+GMZZE
X-OriginatorOrg: ginzinger.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:26:55.4172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59023476-f983-49ab-1209-08df4627a295
X-MS-Exchange-CrossTenant-Id: 198354b3-f56d-4ad5-b1e4-7eb8b115ed44
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=198354b3-f56d-4ad5-b1e4-7eb8b115ed44; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008487.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB999645
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTE4IGF0IDE5OjA0ICswMTAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
T24gMTEvMTgvMjYgMTU6MjMsIFJvb3NlbiBIZW5yaSB3cm90ZToKPiA+IEhlbGxvIEhlbGdlLCBo
ZWxsbyBTYXNoYSwKPiA+IAo+ID4gSSBoYXZlIGJlZW4gYmlzZWN0aW5nIHRoZSBsaW51eCBrZXJu
ZWwgZm9yIGEgcmVncmVzc2lvbiwgd2VyZSBhCj4gPiB3aGl0ZQo+ID4gc3RyaXBlIG9jY3VycyBh
dCB0aGUgYm90dG9tIG9mIHRoZSBkaXNwbGF5LCB3aGVuIHNob3dpbmcgdGhlCj4gPiBib290bG9n
by4KPiA+IAo+ID4gVGhlIGJpc2VjdCBlbmRlZCB1cCBhdCBjb21taXQtNTgyYTg5MTA5YWQ5ICgi
ZmJjb246IEZpeCBLQVNBTiBzbGFiLQo+ID4gb3V0LQo+ID4gb2YtYm91bmRzIFJlYWQgaW4gZmJj
b25fcHJlcGFyZV9sb2dvIikgb24gYSB2Ni4xOC54IGtlcm5lbCwgWwo+ID4gVXBzdHJlYW0KPiA+
IGNvbW1pdCA5NGU2YTA1OGIxNjgyMGUwMmYyNWUxMjIxYTRjNGU3MTNiYTIzNTUwIF0uCj4gPiAK
PiA+IFdlIHVzZSBhIGN1c3RvbSBib290bG9nbyBleGFjdGx5IGZ1bGwtc2NyZWVuLiBXaXRoIHlv
dXIgY29tbWl0IHdlCj4gPiBnZXQgYQo+ID4gd2hpdGUgYmFyIGF0IHRoZSBib3R0b20sIHdoaWNo
IGkgdGhpbmsgaXMgYWJvdXQgdGhlIHNpemUgb2YgdGhlCj4gPiBmb250LQo+ID4gaGVpZ2h0Lgo+
ID4gCj4gPiBPdXIgbG9nbyBmaWxlIGhhcyA4MDB4NDgwOgo+ID4gCj4gPiDCoMKgIGZpbGUgbG9n
b19jbHV0MjI0LnBwbQo+ID4gwqDCoCBsb2dvX2NsdXQyMjQucHBtOiBOZXRwYm0gaW1hZ2UgZGF0
YSwgc2l6ZSA9IDgwMCB4IDQ4MCwgcGl4bWFwLAo+ID4gQVNDSUkKPiA+IHRleHQKPiA+IAo+ID4g
QW5kIHRoZSB0YXJnZXQgZnJhbWVidWZmZXIgaGFzIHRoZSBzYW1lIDgwMHg0ODAgc2l6ZToKPiA+
IAo+ID4gwqDCoCAjIGNhdCAvc3lzL2NsYXNzL2dyYXBoaWNzL2ZiMC92aXJ0dWFsX3NpemUKPiA+
IMKgwqAgODAwLDQ4MAo+ID4gCj4gPiBUaGUgbG9nbyBkb2VzIG5vdCBleGNlZWQgdGhlIHNjcmVl
biBzaXplLCBzdGlsbCB5b3VyIHBhdGNoCj4gPiBpbnRyb2R1Y2VzCj4gPiB0aGlzIHJlZ3Jlc3Np
b24uCj4gPiAKPiA+IEknbSBoYXBweSB0byB0ZXN0IGEgcG9zc2libGUgc29sdXRpb24uCj4gCj4g
Y2FuIHlvdSB0ZXN0IHRoaXMgKGNvbXBsZXRlbHkgdW50ZXN0ZWQhKSBwYXRjaDoKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZiY29uLmMKPiBiL2RyaXZlcnMvdmlk
ZW8vZmJkZXYvY29yZS9mYmNvbi5jCj4gaW5kZXggZDc4OTBlMTE5ZGM3Li4yODA5YzdhNjg5M2Yg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZiY29uLmMKPiArKysgYi9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYwo+IEBAIC02NjYsNyArNjY2LDcgQEAgc3Rh
dGljIHZvaWQgZmJjb25fcHJlcGFyZV9sb2dvKHN0cnVjdCB2Y19kYXRhCj4gKnZjLCBzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbywKPiDCoMKgwqDCoMKgwqDCoMKgIGxvZ29faGVpZ2h0ID0gZmJfcHJlcGFy
ZV9sb2dvKGluZm8sIHBhci0+cm90YXRlKTsKPiDCoMKgwqDCoMKgwqDCoMKgIGxvZ29fbGluZXMg
PSBESVZfUk9VTkRfVVAobG9nb19oZWlnaHQsIHZjLT52Y19mb250LmhlaWdodCk7Cj4gwqDCoMKg
wqDCoMKgwqDCoCBsb2dvX2xpbmVzID0gbWluKGxvZ29fbGluZXMsIHJvd3MpOwo+IC3CoMKgwqDC
oMKgwqAgbG9nb19saW5lcyA9IG1pbihsb2dvX2xpbmVzLCBuZXdfcm93cyAtIDEpOwo+ICvCoMKg
wqDCoMKgwqAgbG9nb19saW5lcyA9IG1pbihsb2dvX2xpbmVzLCBuZXdfcm93cyk7Cj4gwqDCoMKg
wqDCoMKgwqDCoCBpZiAobG9nb19saW5lcyA8PSAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbG9nb19saW5lcyA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbG9nb19zaG93biA9IEZCQ09OX0xPR09fRE9OVFNIT1c7CgpUZXN0IHN1Y2Nlc3NmdWw6
IHRoaXMgcGF0Y2ggbWFrZXMgdGhlIGxvZ28gZnVsbCBzY3JlZW4gYWdhaW4uCgpUZXN0ZWQtYnk6
IEhlbnJpIFJvb3NlbiA8aGVucmkucm9vc2VuQGdpbnppbmdlci5jb20+Cgo+IAo+IEhlbGdlCg==
