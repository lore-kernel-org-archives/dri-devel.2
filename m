Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D32C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D1710E1FD;
	Mon, 21 Sep 2026 11:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="UIXVvpql";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="hLB+dH2M";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06C210E1FD;
 Mon, 21 Sep 2026 11:30:08 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAe2jc1074796; Mon, 21 Sep 2026 12:29:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=cMOzh6Wt9iHqJtlXOG7GZKogtHui/0qtLUQH65DB9Jg=; b=UIX
 VvpqlxWblUaAcfuKkz/HhNgYFwbi6jLOBzYGN2apT1MYGrXRlH87GpcIF322mi76
 eTKNE8WYyTLanmhBYJ/wI7k972FK9I0zEeqkR5TgYYYSKAcPNV7kXJUOl764X9Gs
 cGYqB4BeE5YVRWBZNWiR1/xCzZ6cigJYUVZ+VNrbFWV2wyLVbP7e1ge+5RqrROwc
 cz8Y2iBofiejWCT3QqKBuT9LSdb/5mBUHgSk7pbOkgC0OPzEDHwAx3qj8OS+h11T
 2FldEbL+Q6ELJ59Tw+ySLkCgO+xcCKJL9C4AVZJGFwwKqeNZi4Y02M2dErJdb1TS
 cpXbP1n5JYA6PVIBZ0A==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021107.outbound.protection.outlook.com [52.101.100.107])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjfthmvm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 12:29:54 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTR8i4aV/5ZtFOJuQZsg6VBZKO+Z8zjUuqi7W5Khq/f8wkoZQWo6XcBHXxsBMRB1+oOT7WqFMIwR36YmDqxNeGuoZ66BPkauJfSjLVtwgx10xS6bxVxVzlTPCKsU4VrFyzP/yaNOjoU7LRgDbF9RFS3nbmFxQZS3L9fakc+tO+uO5yS4yJ5T4LT7DpirxZ9U6LHPuXKIevjtVakXWMN0ciAcoM6Zpg0EeljIEYPmGmjLCokeJS7caWVkN8tmlQZWcaR0NoiF/OBp/StnSSwR8AzxRyEQcFlZfDTaIEe+xEr+/jqEqRT8IMFjHVnQ78juZj4Ty4hhnPBJfjiDOZ8M0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMOzh6Wt9iHqJtlXOG7GZKogtHui/0qtLUQH65DB9Jg=;
 b=SZSAG9YbyQ3ARlSHHsNwYbI1t1DMw7IViDcbFfoNCMdq4m29u0txgFiTEq1c5FVx5jBbARXqc1WHiIPVFZRlCaWjQ5OU1PjCIkznUQwaS8fl50KcAFOCY/wxYULua18qx2Zy43v5xWdcnrqjlWpJOhYe0YVRAl/Zvrb7NHlYCG+3EG+2FEpvrpEZjrY/i/OxvF/+1fpOD0qd5dk7L4dlRi+hra6W0NsnZH4qjUewejPHqBLwMCpAcUlyFK+baQzf4Op4BRDozG2q4HLvV9FnS9R1DUPdvhi8F6PNjUxnP3JQkk+8uEjjmTqXIvuLWIOQm3KpEZ73nozKRf+LoWtBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMOzh6Wt9iHqJtlXOG7GZKogtHui/0qtLUQH65DB9Jg=;
 b=hLB+dH2Mg5ypvENLqTw/foVla7k3Ev6iq1w22/+uwJdR6p6oom46fE+LhMK4lv8sWFj7WwdyH6hhksZZbztdQrSv1fmh82XoXgaAFfXXThHwxl1gAJVXeAVhOXx3lUKfIS9RcCtEKIHfIEyLlvHiGC4y9TCoe8Zv4DWCN15NiSo=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO4P265MB3648.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:29:48 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:29:47 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/imagination: Firmware interface cleanup
Thread-Topic: [PATCH 0/2] drm/imagination: Firmware interface cleanup
Thread-Index: AQHdSbyCo2tgTbNbnkmbLbfjtXXOeQ==
Date: Mon, 21 Sep 2026 11:29:47 +0000
Message-ID: <22da6ad8dd9f99b61c1291bb94439ef2562f7807.camel@imgtec.com>
References: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-0-a0e2ccee154a@imgtec.com>
In-Reply-To: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-0-a0e2ccee154a@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO4P265MB3648:EE_
x-ms-office365-filtering-correlation-id: 39bf61de-ee6a-4086-9b93-08df17d3a49d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: NjgITavm4rkMFtXLhgOo/guhY14tKvuvnNX7MOaWbCvVhWSgxyMRsg3dpMoBHW9oypCjrlhl9NQ+r6CpLQBrnf54Z2s87byaRNkVlue8B9jghY2GNUs/rz4ErP/DhphdnLuYeAcoCwwEIBzsuXiE7/TMLV0EoUZ8XsZwePp2pPJESg1LlegFwbEgFMJjSX2QXB7BIH/HpyyoS7ZcEbGHc1Q9p/DqLMaivwEAsGpnmk5svY3k/1zLUtShYoH2uNjekyjchGV/3IMAkFb06I7EiuT+L+1bXNn6qqfQV7DAHUexdK7tT2yWWikrAO1Gc/zvjn+tR+Y1BHsw5qbApf2dCNpGMaS2Nud04lkSeYjOm14TGuPTLLTjNmgJ+zMKC/NirPF6ARUqSr8qtWORhJE6boeb5/+LLTLVTF7WCO9kTx6B8GliWuldaVDKyAqNLAB4Uebk3w0VD9SFDNFXvLiXlzG7U2rQH8uxLKkfcLt+rF1UjRPFqjlqb8w6a6aJ55ygCSPEmvW7vYNLOHsrwAXRpKNhgX0vFAvB7BSE3I50DcuxiP8Qt+MTqxGtV9BJPhyXfK+20RbbJ40IaeQRKzO6ZLitku/NiAiqBz33kQroUz5ZDFVwHZBzAgXeOvPxDw1d7LwbdlP7hh6IXYZm1qSMtk/Sf/hCq6nb37SpwlVLvNuLPD0b18j+YWBXXmgYXy+Tfr018uHgKCmrtwTzGz84fpw2hSevhFQiJ1lFTJrJSMs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlNxNGcwRDhxWGlTcHh6SWRFanBtZXdsUDVBdlRaNCt6TjdtbTNDUXpMLy9N?=
 =?utf-8?B?eENEWWRSQmU2ME95ekI5bVdlQmFvWjZ4SDRaMjlqUlNuWVAvMHdqNEdCNkNI?=
 =?utf-8?B?QzRvSkNlQmZnMUZtWGpLbmhSNHBUN2pMZFcvRklmZXJvaDFiSzB0REZoam1G?=
 =?utf-8?B?ckRLa3IrdTRMczRqZDdTNkJ0SmtCaDhneUZhL1Z0NEpaMVo0UWdGQVgrNHcy?=
 =?utf-8?B?WGpiMVJvd2RJWFNWME83OHZoR2lJdnp2S1lSVk13a0J5b1U5ZFhVTW9pUXJQ?=
 =?utf-8?B?VnM2R2dSc3d2Vld5b1ArQzZMOU5nVlJ4V0Q2YjFCcGdBZjNVa0t2dC9kOVhU?=
 =?utf-8?B?NnRxZE84VnNYTTRycXl0d01uUVcxNEJydUVxVXArQTBWS0VKR3BuV29Ddld4?=
 =?utf-8?B?eXZLa05GNlhBekFDOFFITy8rZmpvWFFUblJRWnptZWFRSVM0WGthT29UczFv?=
 =?utf-8?B?T1RnTXI0TjBnMlBNaFo2WXZjNXlJQkpmR09VM0I3T2V1WlFkY3IzdHFnV3dp?=
 =?utf-8?B?aERCcXVQZi9LUERYUWFTQ2cwWHZob0xsVDN4dFg5US9TZmV2elVzTEZBSTh5?=
 =?utf-8?B?cTQ3OWhPTFBVSjhWOVNCWTVqeFpaNGtSMnpkdHhuSWprVFdaMVBUYkZlcmk5?=
 =?utf-8?B?MHA2V0dtbWpEWW1COFRZbnZWS3dmczYyR0Z0dkpyS09QZUIvQUN5V2VnSDhS?=
 =?utf-8?B?d3dGUDZTcSt6ckc4clhLUUxhekpYbHVsWHBkWElZdTNsVTlzWVR1eDJENDhB?=
 =?utf-8?B?aFVUVFBoMms1SE1ZbmV0cTg3aWp5SlcxdnFBZHh2NXhVL1h6TUc0Z1lDb2hu?=
 =?utf-8?B?eUZqVXZnLyszMVpQWEhjMmpJWDB4TDE4TTBLbGlleFE5RzJjNEt1dWlWVWJQ?=
 =?utf-8?B?QnREaHlTY1FJM0VWcmxTZy9GcTdPN2JWV2JjejhTMlYvMHV2R0Noc1FCNVln?=
 =?utf-8?B?Zmw1L09nM1ltY2ZmZzhxaFRuZnZ5QU5nbFpTUndNOURkN1lwdm5kcnJVSUVs?=
 =?utf-8?B?WHVPb05tVFhDY2syemk3b3lnaG5NWnpWQnlCK3dadDlGdU85YUh4WnRKTXpv?=
 =?utf-8?B?bFRTdi9JMDVFZDdtNnB6QlBZa1BvdHhkcDYzdEFWOG5wK05tOHI4YXE3blAv?=
 =?utf-8?B?RVJHV1c4aldBajEwZmVHZGZXb0RUZGR2V0JBKzNHOERoUDdOWWpwczJBaEpN?=
 =?utf-8?B?Rmg3Z3NpRzlpeWg0VGpxYjVYN25FbG1oMzVXcmcvS2x5Si9XcXdXRHdpM213?=
 =?utf-8?B?VjM5L1Jobk1RbGVhNjRFT1lsekt0b0NZTWFqVFVLNVROQ0dwQmtRcTdRemdx?=
 =?utf-8?B?Y0hveXF2RkRZRnJOS3JDR0pNL1cwTkR2ZTR6VksrLzlHd0pRS3VveFczWW1a?=
 =?utf-8?B?eGNTb0FudW9mOVRtV0xVYTZLSHp1aW9BU2RvWldKYnpYa21NbmZvQ2xpbEJC?=
 =?utf-8?B?ME1XSjRLK0haK3g3cllha2k4SkNjK3lFME5FTjYyOVRBZHV1NXFNVG9uQTFq?=
 =?utf-8?B?b0JiYmdxUjQwU2d1L0toUEJ2c0d1M0JTSUJkWm94akhVdXVNS1RaaHdVaGMx?=
 =?utf-8?B?bWtEVEJiRjZCVFIxNmxqOVYrS2VDNkdIZVM3bVhkRGRXZHZwMlhCOElWclVM?=
 =?utf-8?B?eTlrTkl0YlhwTitQZzlvYnU0Nm5mZmp1TkttM05ZTXVmQ01OdFNQRnpRYi85?=
 =?utf-8?B?cHhpdWNmUUoydnhJMWlGWjFkRC8zY0F4MGZJRDR3VzFacmUyWjR3aWNMd2hK?=
 =?utf-8?B?bGo0ZXAxRGlMM1ZPVkFGb3dvRitPWFNaWkEyeWhYR1QvZXFZdWRhdGVKMjVa?=
 =?utf-8?B?SCs5MldNOEZNRXNhWW8raUdoTUxrOEh5SzVpZ2Q0dTNKOUtEOXRVcG9YR2ZC?=
 =?utf-8?B?YnhxUjF4RU1zQTFvQ2FzR1pwYnhzMWJRYXZXS0xJSXRBa3JTbFpkTDNrOWRq?=
 =?utf-8?B?eDFOeWFncWIrU015a254cWJqTGhhWVV0Rjh0UjVNNGFiQlZ5UHNzQUp3UzZC?=
 =?utf-8?B?MHF5NW94N0lqaUJuQm9UQXdUVW10NjEwMDl5R2RLUWIvUS80WDd1dFFJSkJ6?=
 =?utf-8?B?TmVqUkI4Y3RIUExGdVplZUFRd0FPc0V5Tk9BTmF2TUpVT3FxZjU1YzFNN25h?=
 =?utf-8?B?MHZpaGEwTEQyQWE0OWVGRTFWT25JeVd4RlVZNG5pZHFMcUVUNnh1R0pScnhr?=
 =?utf-8?B?MUIvSmtNS3BRMitwS0Rxa2RidFVyNUcvcHk1Z3JsdXRLVzF5bWs5bER5S1lM?=
 =?utf-8?B?TFIrR1RUQmM0ZVhWQkgwWmhGRzdVK0FEMWhxNEhmVkhtaks5aEgvWnhRcnBO?=
 =?utf-8?B?dktMajdQMkppaTlLTEk4QXRvRXVHUjhMYkRJSlA2RlFkQnRjNTl3blp2NW12?=
 =?utf-8?Q?WILpFK9Qm0rneNe18B0dnBbgdycuDMbxZiThRSnWpAstZ?=
x-ms-exchange-antispam-messagedata-1: Sj41q1jkpvEmrJFXcubTYjdJ71QfOd4KTTs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <343717DEA4378B49A525B3E3FA59C03F@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ImHf91tmcOwtPNHyqlvgp4/Ima9v77dPSWP5bLnLy/gcK02F3RQHrKIQM9wUidN1TxnW8QCIwWkb9YWLxUqKQ8zT1GrQqTKJROE7YsRYJXgIdaN2rhDZlagEhdJyZ8Z8oPsxffU723JyVx/MBf7WgsDMsWYiexPHGe2NCBCpNihTjwsyzEIqTz6FQuwsfBYTn7ej2o9JjM0tCgix9gk9f0ASZNzQZekaWBi0OUl1da+36DKBvuL3VTKd/+0Yb80o2HBm+m8ipQMMgO6yEI6Lluk7NNsUu7X2qA4u0G6wFhbfd5fsvXKKPEg/qaim1/Hk/bgYr9gNQhyCO0POv+Qjsg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf61de-ee6a-4086-9b93-08df17d3a49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 11:29:47.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mNNIp3z7IEbXolP0lCUOZN0YMuc2c1IwAJJtUDQGAc+TJIAl1uQHZsuDNfUF7zrtV5v2ld/UMaG9vJryXaGZEASRblvaBo1uNKehyhIeQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3648
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab11532 cx=c_pps
 a=Fi9KNgdC//FklvOUCr4BaA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=iR0Bmp7gVbHCY0cZFVAA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2NiBTYWx0ZWRfX+Fl1n3Z1wHi6
 c/4qq5/EQegpSNjlJ+mI8Ky+jWH/cetmLd0nch/gEe7eMv1nfXwMPQV0hd7K+SE3b+B6fjVl5Y4
 Dk+g5jwXuf2Rp4x8cKNHIoZBp3z1A6QXMlfF90M4c5FE9VMSwnkJseweL+kxa1O4yWpiQAudC/h
 4HIP8rHwnXBMymvVxBZPPG95ZgaoCh2vMUvjf5/uImklBNjNVyAR9X6g2WlSuVkP+d6L6YlMYFw
 NdTZ/tM1gY7vvfW91yyLE3x+seNZ0VJIBk6TH3F0sR2xtHnqL5CHJZziTF2T/j1zMHLwE+tUWQk
 WAfOOcg0FtON7m5OW3/lnNJtGtekaKGQ0f0BAJWfzSRAaxrkQCk8ozzfUiM8r456CEVh+tF1Fxl
 Z5SUPO07EAgazKI1WmIsfF2MaF5dRMETeIzqv9Pxs8XrRUOskh7QehdZz3dp9ysfnModOodRu4l
 8HYpnJlAf2Cp9BrH57A==
X-Proofpoint-ORIG-GUID: heCjWUg68YrZECxDMfLTxHTj3jUU_JNP
X-Proofpoint-GUID: heCjWUg68YrZECxDMfLTxHTj3jUU_JNP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2NiBTYWx0ZWRfX26u3OtBaSOq2
 go8ZZ+ha4qG/iJdGv6IZxxVBxTX7h4tKTYZXUkMg0XNRyUOlZ5Org1REatwvC0vqHrfvflpiAGP
 QOXFkfgGEYJuJHN/3JKjoTgb+edrkn8=
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDExOjAzICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIEFsZXhhbmRydSwNCj4gU2VyaWVzIGNvbnRhaW5zIGNsZWFudXAgY29tbWl0cyB0YXJnZXRl
ZCB0byBGVyBpbnRlcmZhY2UuDQo+ICAgICAtIEZpcm13YXJlIGNvbm5lY3Rpb24gY3RsIG1vdmVk
IGluIHRoZSBzYW1lIHBsYWNlIGFzIHRoZSBvdGhlcg0KPiAgICAgICBmaXJtd2FyZSBjdGwgc3Ry
dWN0dXJlcy4NCj4gICAgIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IHN0cnVjdHVyZSBtYXBwaW5nLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3Rl
Yy5jb20+DQo+IC0tLQ0KPiBBbGVzc2lvIEJlbGxlICgyKToNCj4gICAgICAgZHJtL2ltYWdpbmF0
aW9uOiBUcmVhdCBGVyBjb25uZWN0aW9uIGN0bCBsaWtlIG90aGVyIGludGVyZmFjZSBzdHJ1Y3R1
cmVzDQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogRG9uJ3QgbWFwIEZXIGludGVyZmFjZSBzdHJ1
Y3R1cmVzIHVubmVjZXNzYXJpbHkNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2Z3LmMgfCAxMzAgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncuaCB8ICAxOCArKy0tLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJh
c2UtY29tbWl0OiBiZDRmMjg0ZGYwNGQ3NmZkNjVlNTcxNDFjYjFlNmU3YTQ5ZTRjM2NiDQo+IGNo
YW5nZS1pZDogMjAyNjA5MTQtYjQtZG8tbm90LW1hcC1pZi1zdHJ1Y3RzLXVubmVjZXNzYXJpbHkt
ZGU4ODY4YmQ1OGQ5DQo+IA0KRm9yIHRoZSB3aG9sZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogQnJh
amVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNo
DQoNCj4gQmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUu
ZGFkdUBpbWd0ZWMuY29tPg0KPiANCg0K
