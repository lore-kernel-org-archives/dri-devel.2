Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1007CCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6662E10E8CF;
	Mon, 18 May 2026 15:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="EOwommuB";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="MtEpS71D";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AF710E8DF
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:02:09 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEFc8P2119320; Mon, 18 May 2026 16:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=SeHKJSiCMGsN28PAurg9QTRJw
 UDcsBIXGnRdIrF5yH4=; b=EOwommuBMqposspfM2hDRPaY7dD/ms3S+e6LlOLd5
 M3OkpYF5jgkGLvr4SWf2FSLNQW/VcKKxCQtfGovUdK6juXxvPIr2S1QUOm6hlhfA
 FcxZUI1N7O6PUyRsEfCDBmAWlDLD7ryZg6UZZJhJ8meMcKmveg5PvOQ/hFVzhhPh
 XtGDR3Bwv9m4hsw62q9gtNpWoktTmRKRnoCTPHhSgWceU0aLGtapt8apu3uIKGhA
 js5xRB3/yPou8pfwGxjxnCsvXjYKv4vMfJ9cCK4UL1ddnCnZq1ZCxn5Qs4K7kJ4Z
 mgf9FL7Zn5EAmg+LsKFPV4CzcrRGBJi8tqtgs30gA5faw==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup1kpf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 16:02:00 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCZBFuBNTLDamkrqaa78ZvqLPMulvuvcdl62kTt32rXoZ4HxYgThw+3ehzpObIEErYA12geh9g8JwvXbKEzu/iyGzjfGpvV9SlL0XBuhGYmXyFeZUW6yQ85ORlx6Wi5UxKtDkmtuRHhflKo2o3tBtVrSLCWqejrC3HFMNFVtvvxTAE6FR4NWHf/Im+V296zZ3gnp3/fzX0MosDplcKJYjvdbV9W5a7JO5sinYwgTfm6EbzFIsVwn0c6cjGADNTcJPB+00hN87M2kmq0LVb8BijQbJ/7aiy72+vFkLpisVsA9IEOCg0zBmuJ4Zj5mEQaYK3s9S4M8NoMIxMWKaJRvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeHKJSiCMGsN28PAurg9QTRJwUDcsBIXGnRdIrF5yH4=;
 b=IaXU6QdSE8q1jbYlB3XPSa0rUkm1h4StYB23ygf/+3iIHSyNhIi8pzCYQrowxrqTU0XVmUNQ4/kSisUjYS0N9PBetHHQtLthj89THXKIOQRRIIo+bOYPMfIPSjwAwKDkG00ANwj5QndwHvGHgKy06aHieV7TbJhqIasNlAfewX8aorKwcDDHqNznaBLjd9/+sghqu+YduRuJC1pgy5SBAl86XYj5ToyDgAVN06MLJxkvNTVvGo/nlBDgd/dbiqjslwzpi+oXjWY9cfP70HHbrH04+jeSW8QC1zwVhXcF+J+ih4XJUui/MJn6mXQGpyR9+j3NjcmGPZnOVDtJ134i+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeHKJSiCMGsN28PAurg9QTRJwUDcsBIXGnRdIrF5yH4=;
 b=MtEpS71DJk1eD/9fGTMhyJ5mgo65VD5iEcGVA1fOcRM2wWx5wTcpp+eKxLU5crFHtHcEtRHmr8Q8BqAJ4rPkzZo872FXwo0ahMuAv6LzTiZwACDhp/iBl3Le6mOiJtXrsUoXnGy8agjjX70l9z1mOp7aaEH5FweTsPAqucC46h4=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LOBP265MB8899.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:01:57 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:01:57 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/imagination: Rename FW booted to FW initialised
Thread-Topic: [PATCH 3/4] drm/imagination: Rename FW booted to FW initialised
Thread-Index: AQHc4ds5EGJSZh6MsEeNR5Ko8sowlrYT6tSA
Date: Mon, 18 May 2026 15:01:57 +0000
Message-ID: <2d408760-9467-4d31-a4a3-b1883e56a433@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-3-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-3-439bee96ed83@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LOBP265MB8899:EE_
x-ms-office365-filtering-correlation-id: c3ea1255-c0ec-439a-81f8-08deb4ee683d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|6049299003|366016|376014|38070700021|4053099003|22082099003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: +JS9MZmaMXbJDLo9JdbrnFRtTkhShitjw2Hri7aZv1p2FdeimbSnKQ3YyVNw4yFA2QskoObbSKfuqd8xqoJ9Rd29U0A2YULW3h1DM2A1uucnnKJDkJoucI+ZEEzwUahTExIQHPwGC9CXM+GsqtfYZyliBR0YTW4RtYEaYyzCJ0lxzF8NN9KIYPsJrtZU9U4xXMibldnKeNLyyx60VS2GJKTuesNv1fqAQVhD/6aFRB78jDv9dUq2kNZq2Q/ZnaPQJrOKKesu3IL4sq3N6PHmlNWBxTCvzZkl2s9Nj/a2h8c8c7H0Xq31zMKteRm0D4hzzWllUNCgOhDSG+XEMS4PM3wH/AeUdyviWyHb9oEqZrwE7FQkWPatzvndO3NowyX1Ztw9ha8fB/0kT22r2K748O57N/GuVQKW9rNKYhO6UrwSSwtCJj2WOE+3Uk8aFpvwFVsd+YL5adWG7Ly5IWFlz+RcEPa6mTOC2jC1/cQXD/zgIrcynHP5MtyFUpoGXQmztNa6t26fSwmu4Xzt4hzn3+mN41KMQHp5gZlPUhVVqO6Nlw0CO2Ds2Vj3Ak31XpXqDzqOTLHIevkTfCNeW2jz8ZsjzEl5rUKSEsZjGO+R+TKVv+PdJrC0g0pnuA4MVvw6a8eWjlIpL/2EC3XQQbBULQf22sJ4dCgTdn62Pm/SAu90iZmVSWEwoiNVGLRFLQ7ZEj8hM1EiN+yjOgYaihQzPIqgKJtHULMS7rvUphKM8k0CyBZGUHTNNPbqy4CTeyZD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(38070700021)(4053099003)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzJEcHU0SE1HQ2UyS04zVkpUQTJqWXZjSEdRZitDVk05VUpLV0Y0dDRsOEUw?=
 =?utf-8?B?T3VuTW9UUGVEbjc1WDAyQS9TT0J5YzhBdTZGU2o2aGF6cFNYT2NIRnVDMzNi?=
 =?utf-8?B?SzU1YlZkL1ZQeHZDZTExUzV1d0Y1WmY3d2ZReFZ2WGNUZkJKcVZ0OXFxUi81?=
 =?utf-8?B?S1E0eEtROFA5bjZwU3A5Z2ZjUzB1eHpaVWE5cjA5TW5tWTljL3YwN0NpNjJZ?=
 =?utf-8?B?Tkc5UmJnT0tjZEljSWNFUDBuQ3NHZkNRdDlEL25XazZvSHAvTW9hZjZzRmdl?=
 =?utf-8?B?b0RlQ3FOSnBiNjhNeTAvbXNRcGI1Z1ZwWjM3VXhHM01JNHo4Sk1nd1BYTjgv?=
 =?utf-8?B?WVI3VnJJaGVGYVFWNEg0bzVjS2t6RTVybkJOMHFkdWF3akgvNUFNMG1sSFR2?=
 =?utf-8?B?TW1WbjVKZkpLOXZUbkVZMWcyQzN1eGNjaEQzTnBQTUgvR0ZNRitFaWhuNm5K?=
 =?utf-8?B?TUN2akhCd1FVSWlobStvc2RLdnRLUWVFK3VvSURpTEhFZ0tBTnlrOE43d3Nk?=
 =?utf-8?B?Z3Rwbml4ZzZRamxPWWpTWkJWOUtYdCtJUUlKTkN6akFjWXFWWURlcHVhM3Rl?=
 =?utf-8?B?dWtqNGdYOU1Hem9GQTdKQ1BvTEpya2g3amtML3J6dEtXRjMzUWNVR0lVaTZu?=
 =?utf-8?B?b2pHWWhqaFdpOC8yd2JBM1RyczdZemZGNFI3a3dmMXVIRENQTXA2ZzhNZklh?=
 =?utf-8?B?TUpvUXZSYXBhVy8zdk45ZnVVNFpmbm9KNXpDNnZ2SEZsUUptVERkU2k2S1hi?=
 =?utf-8?B?SUZ6WHBQUUJZY3h3bE5kZk5RZUluWkk2K2ZEYnBuYTJ3eTVTaHhJRjNjR0tj?=
 =?utf-8?B?OEVTMy9pdHduYVZHYXZIb2RKdDQ2U1QySDE2NW5ycXNEN21OWEw5NkdjNmQ1?=
 =?utf-8?B?bzUzUDRqN3FlMFNUVWhGYkljNlRYWVJyQUNoSEwwL1Z4eTU4OGZVQ2NmKzU5?=
 =?utf-8?B?WktwK3RxMk1INC9BdmFtcW1hUng5OXpDTDAxUFZLSWxjQzdtTjJ2NDQ1K3N3?=
 =?utf-8?B?c3diK3RoVDZtTHJwNEx3ZFFTMlhYK0p0bktqUi8ybVdOTG5QcjIvYi9vMWZR?=
 =?utf-8?B?bEJ3NUdYOWlWcmQ4REJpanJwaC9KbllXMld2RjE4SWZkNGJTS3JsVjR2cFdR?=
 =?utf-8?B?czdNdG1CbDh3Z0RyWXd5UFdPY1ZTTGZXTEp1bTJRQlFTZld0dHNRUmIvZC9i?=
 =?utf-8?B?a2lTeksvVHR6YVlrNy9MM1g4ZEYrWDF4N2FncWRqS0Izem5zeXNhbGR1QjNk?=
 =?utf-8?B?TmJ4ZnlWai9aYVUyd0VWTDl4N2ZIVkVJWXJyL05uRkdXRy9Fc3JsWjZ4UmNX?=
 =?utf-8?B?UExLQUlRYTdCRGRaYjR3TzlScnc4TEkzNm1BbFJLUklmaWRwWlE1TXBvemY4?=
 =?utf-8?B?ajltbEdMWVVLRjE2K1V5MHdXM0ZwSnZSUm85K3BkVS9BR1RFSmVsRVRpSVp5?=
 =?utf-8?B?ZS84RGxybVpkKzVNczl6MnhlNG5LdSszTFNwQXVKc0l2WjJ2NG93V2N4b09w?=
 =?utf-8?B?WWRIYStNOXhHVkRlamlKWEdLbkVoc1pQVUF5VWpVdTBnNVhvc2hDcEFGbDFN?=
 =?utf-8?B?cXdFQkQ4MVVxUkt6Vzl5Z0xrU2VrVEZWOWlYdkZJWFBNR1Noc3A2WW5aUGpG?=
 =?utf-8?B?Mk5WWnh1cEVNVzQyOGpCM1ZoQlJQeFFFcER1S2pzUmJEMUY0Z1d3a2dNN2dt?=
 =?utf-8?B?KzZsUGpWQlF3Z1B1TlF0aXpiTkxLSHJpVmRGdWRmMGFCb0phYTNQQ2FhRE1q?=
 =?utf-8?B?Sjhmb1ZrRGs5WUxRYVRLM3IySXA2TFIzOGMyQkpzUGs5MS9xUndIcG80ME11?=
 =?utf-8?B?QVBlREFnd3Y1anphREE4dEoyWHZwOG5mSm9lbEtNZWhOdG9vQkN3UXVIeEpQ?=
 =?utf-8?B?NGJiVHIyenhqNUJUUnFaN1YxQS8wdXpSUFlxUStoSHUrR2t5WDVkbjloWWQ1?=
 =?utf-8?B?RkFjbHZDZU5tV2dndWJXeUJkT0lWcVFFclVuRXpJQjVDMDQyd01tWDdIdDZx?=
 =?utf-8?B?UjJUeEJ6VEduTmQ4UHIybzBIWmNDNEZ0VmRaSFFlRjBQL2RKWkE2SFdqTDF1?=
 =?utf-8?B?a01NQmJ6bGc5YWxRUFp1a08rd1d0S051dzA1YWQxdEtmcVY3bDFPajNnTUZZ?=
 =?utf-8?B?TkdUYklxeXBJNnh6NS9PVzFrbkU0T2tCSTJ5Y0Z2QWVTd2c2dGFjVnN1SkhK?=
 =?utf-8?B?SlBGcUZpeHZLTGV4TlRRYlRJNFNOendpT0owTUdMbTRDQUthdmUxam83cktU?=
 =?utf-8?B?dDA2cGZUeWdESUM4bDhWVmV4RmNEWi9zY1F1ck1qR2pvUDFQSHFPc3YrK1ZH?=
 =?utf-8?B?V2tIS0k4K3ZtVzI3eXJIdUptbm0xK2R2SFFpVi9hL0V5ZFJSR0hkd0pOTEc2?=
 =?utf-8?Q?bWNoeZjzbsBNuGbg=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WLWz5cfmdT4Y4QtZRmX7CMel"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rs2XZzAr+EI6A5sme1WQ/avrANrYqaIj21QKk5AdSH38kJO4nWd23T1BRfj4WQaMCHrsAfaHFCjP5ouv99JjV1iQc5gBm/5y2fyzdSkcQuWEfWxgCHZVRZrD2bkBaxLJHjPpv3B2ls4K9BKEl3fr5q8ZD7vArnZi9XJvFJ+VRGWEsSy0L7t93D8X+1B0QWmBHYPFKoQtZZzDAuRj/JgmGkpaFf5q62bCiiGZADszIM03elSzkLnjqNKNIY7dSxN9y35C9T5dLIcsD+upsEsKpWtn2m2f3UJhnOoJU15zqkUL1izu+ExQEoiWBXU0pTGq0pat0NNza/NlA6lD5bWyFQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ea1255-c0ec-439a-81f8-08deb4ee683d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:01:57.7223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ultWr3tqI0AqQAqImtxt9ySYHzWUZbQQP3Gjz8kWnDj0Wtx3KSP6dl7O3GESvDvk7cgMUV1n5idw8hmCKYz35w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8899
X-Proofpoint-GUID: tfePc2lXmXzD8Nui1HeHWwsCRSN6Dy8A
X-Proofpoint-ORIG-GUID: tfePc2lXmXzD8Nui1HeHWwsCRSN6Dy8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NyBTYWx0ZWRfXyAeQhE7Puo+s
 lAHz5IbZJAhc1OaCqObJFi7QN0N7SkbXv0Zc/nZA8m+nYrnThyKmXej2FgE5DqKaktUEXlYRH2L
 tZA6ylew6TCJcmnGkahaeAYPNPgJV11gN219+c7/sk2+WbaGovemgPi33a6Q/p9cpLDF2HGzz+a
 ahHE2jWCKkn760AYOMFDL+IWRW/t+RyFdaFt84DLqDe6xao6XWDxlKGcrpLv2Kc97H2vNyt+A5Y
 UZXs4mTmflFOM7vFsZVuQig4Sr+c2qxa4ZWYcdpHObNHAdAwtD/6ey2Pl6GEsk+4mEYd4bn9U3C
 DEOlXj+lU2cfa6MvJH1Bph60M84XtpfW6deWZmcysiXRbLaZIEC5kvAcw7wlTuYPrpcCE1DdvaM
 BUI9pHn+e+a3WAVcpLcMaua4ZfVjGXMvlNGR7dpAgAS0n+OX7EnJCiKjnn8FKgl4YK9u0H2WE49
 9wA7oV6+L0lJyVMH31Q==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0b29e8 cx=c_pps
 a=Rvvafz/nfqJTHwFgE6i6/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8 a=uji3MpxeiruQX1L7JFEA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=CBv0nxMjoVHzJITRQJwA:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

--------------WLWz5cfmdT4Y4QtZRmX7CMel
Content-Type: multipart/mixed; boundary="------------oA0v4OSOV20AypRkMolJb1vB";
 protected-headers="v1"; hp="clear"
Message-ID: <2d408760-9467-4d31-a4a3-b1883e56a433@imgtec.com>
Date: Mon, 18 May 2026 16:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/imagination: Rename FW booted to FW initialised
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-3-439bee96ed83@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260512-b4-context_reset-v1-3-439bee96ed83@imgtec.com>

--------------oA0v4OSOV20AypRkMolJb1vB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brajesh,

On 12/05/2026 07:47, Brajesh Gupta wrote:
> Update name to FW initialised from booted to better represent FW state.=


Can you please add an explanation of the distinction between "booted"
and "initialised" that makes this useful?

Cheers,
Matt

>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c |  2 +-
>  drivers/gpu/drm/imagination/pvr_fw.c     |  4 ++--
>  drivers/gpu/drm/imagination/pvr_fw.h     |  7 +++++--
>  drivers/gpu/drm/imagination/pvr_mmu.c    |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c  | 14 +++++++-------
>  5 files changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm=
/imagination/pvr_device.c
> index dbb6f5a8ded1..49696101b547 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -213,7 +213,7 @@ static irqreturn_t pvr_device_irq_thread_handler(in=
t irq, void *data)
>         while (pvr_fw_irq_pending(pvr_dev)) {
>                 pvr_fw_irq_clear(pvr_dev);
>=20
> -               if (pvr_dev->fw_dev.booted) {
> +               if (pvr_dev->fw_dev.initialised) {
>                         pvr_fwccb_process(pvr_dev);
>                         pvr_kccb_wake_up_waiters(pvr_dev);
>                         pvr_device_process_active_queues(pvr_dev);
> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/ima=
gination/pvr_fw.c
> index 288516dc2560..b8ad3f1d222c 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
> @@ -1004,7 +1004,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
>                 goto err_fw_stop;
>         }
>=20
> -       fw_dev->booted =3D true;
> +       fw_dev->initialised =3D true;
>=20
>         return 0;
>=20
> @@ -1044,7 +1044,7 @@ pvr_fw_fini(struct pvr_device *pvr_dev)
>  {
>         struct pvr_fw_device *fw_dev =3D &pvr_dev->fw_dev;
>=20
> -       fw_dev->booted =3D false;
> +       fw_dev->initialised =3D false;
>=20
>         pvr_fw_destroy_structures(pvr_dev);
>         pvr_fw_object_unmap_and_destroy(pvr_dev->kccb.rtn_obj);
> diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/ima=
gination/pvr_fw.h
> index 1404dd492d7c..3390c84e4fd3 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.h
> +++ b/drivers/gpu/drm/imagination/pvr_fw.h
> @@ -295,8 +295,11 @@ struct pvr_fw_device {
>         /** @mem: Structure containing objects representing firmware me=
mory allocations. */
>         struct pvr_fw_mem mem;
>=20
> -       /** @booted: %true if the firmware has been booted, %false othe=
rwise. */
> -       bool booted;
> +       /**
> +        * @initialised: %true if the firmware has been successfully in=
itialised,
> +        *               %false otherwise.
> +        */
> +       bool initialised;
>=20
>         /**
>          * @processor_type: FW processor type for this device. Must be =
one of
> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/im=
agination/pvr_mmu.c
> index 2e4da5b2c499..e9fefcc4e234 100644
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
> @@ -133,8 +133,8 @@ int pvr_mmu_flush_exec(struct pvr_device *pvr_dev, =
bool wait)
>         if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))
>                 return -EIO;
>=20
> -       /* Can't flush MMU if the firmware hasn't booted yet. */
> -       if (!pvr_dev->fw_dev.booted)
> +       /* Can't flush MMU if the firmware hasn't been initialised yet.=
 */
> +       if (!pvr_dev->fw_dev.initialised)
>                 goto err_drm_dev_exit;
>=20
>         cmd_mmu_cache_data->cache_flags =3D
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/=
imagination/pvr_power.c
> index 88fcce433d12..a73a6815306b 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -216,7 +216,7 @@ pvr_watchdog_worker(struct work_struct *work)
>         if (pm_runtime_get_if_in_use(from_pvr_device(pvr_dev)->dev) <=3D=
 0)
>                 goto out_requeue;
>=20
> -       if (!pvr_dev->fw_dev.booted)
> +       if (!pvr_dev->fw_dev.initialised)
>                 goto out_pm_runtime_put;
>=20
>         stalled =3D pvr_watchdog_kccb_stalled(pvr_dev);
> @@ -378,8 +378,8 @@ pvr_power_device_suspend(struct device *dev)
>         if (!drm_dev_enter(drm_dev, &idx))
>                 return -EIO;
>=20
> -       if (pvr_dev->fw_dev.booted) {
> -               err =3D pvr_power_fw_disable(pvr_dev, false, true);
> +       if (pvr_dev->fw_dev.initialised) {
> +               err =3D pvr_power_fw_disable(pvr_dev, false);
>                 if (err)
>                         goto err_drm_dev_exit;
>         }
> @@ -408,8 +408,8 @@ pvr_power_device_resume(struct device *dev)
>         if (err)
>                 goto err_drm_dev_exit;
>=20
> -       if (pvr_dev->fw_dev.booted) {
> -               err =3D pvr_power_fw_enable(pvr_dev, true);
> +       if (pvr_dev->fw_dev.initialised) {
> +               err =3D pvr_power_fw_enable(pvr_dev);
>                 if (err)
>                         goto err_power_off;
>         }
> @@ -548,7 +548,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool ha=
rd_reset)
>                 err =3D pvr_power_fw_disable(pvr_dev, hard_reset, false=
);
>                 if (!err) {
>                         if (hard_reset) {
> -                               pvr_dev->fw_dev.booted =3D false;
> +                               pvr_dev->fw_dev.initialised =3D false;
>                                 WARN_ON(pvr_power_device_suspend(from_p=
vr_device(pvr_dev)->dev));
>=20
>                                 err =3D pvr_fw_hard_reset(pvr_dev);
> @@ -556,7 +556,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool ha=
rd_reset)
>                                         goto err_device_lost;
>=20
>                                 err =3D pvr_power_device_resume(from_pv=
r_device(pvr_dev)->dev);
> -                               pvr_dev->fw_dev.booted =3D true;
> +                               pvr_dev->fw_dev.initialised =3D true;
>                                 if (err)
>                                         goto err_device_lost;
>                         } else {
>=20
> --
> 2.43.0
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------oA0v4OSOV20AypRkMolJb1vB--

--------------WLWz5cfmdT4Y4QtZRmX7CMel
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagsp5QUDAAAAAAAKCRB5vBnz2d5qsAd0
APwI973ygTXOqVPHyoDX+Khm6GNp1jokFH0rPR59mA6VPQD+KEE9wwfjxobEJ4CQQqrcGV6lpYTI
ziSpLi3nnoOEnw0=
=zdBn
-----END PGP SIGNATURE-----

--------------WLWz5cfmdT4Y4QtZRmX7CMel--
