Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67459CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B412D10E3B7;
	Tue, 19 May 2026 11:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="J6+HDAY8";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="SRWEpPFr";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C068610EC83
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:41:31 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9JXNh4175727; Tue, 19 May 2026 12:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=Hl15nbauKoP7G76kIg9dGFB/8
 1Z/T5MFQvTlbmjGohk=; b=J6+HDAY8fqAzMVUfLVM5xwWyh1I0pE+FJ+lzaIsNU
 lxQvE+5OpqOvssvWIWGhF3DcN4KXxGmvloy2WjWUGuIDgVzwe3LIdCvnMWWIPwUD
 pUlA5wVNflNAqCTUjZ7SKr/oWGtUBQrL6huEM6nOqSK9hHrXnw7tSaWHpnjTR+wi
 Daxvo1uHIV56GGApegOCkbmB/nWCqrDDuZ4ze+jp9qshL5NUD1b9it2C0hRMDBj2
 ne1vaxbsmT9vQc8Jw2w22CC2lWqZhb+6ndn7VNVWGRvaBqdQsLLBJpDOsunqQLxP
 DmD9Ni+QAL+eA6TEH61zUKYHgvZHBSMk+Lbn30joKWoTg==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup2bsq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 12:41:22 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6qE7sOCOzw8M6/p1ez1ZaFAbejxkXS4MG5JiuiTlsKy4HJS9Vi+UQ3S3apGQPYIvmJacKMvLWPbdBKs9wiIYyohnsRlPg0d7+sNQ2ZRkiEHKHTVbmRwjuAh89Yy58Tb9MM8d3iV7oa7pg0AxBV2XkAfOMLxKACrlABhDsm5AoNx8v+eqFg7oWjueEvFN7rKlYxZ8YHBwWbxCNvqylCU7OC8X+c8GU9njWHNvRynhRKAJShG55OqOBzOEgBaBR2FG0c2/JGlzJTX4wCtJT0yZmQ0LVR/M9au6PaEUe3UJtBK+ioQmtvSq+IrvMwVQL0IGfxChNyHEvzTMTqpmwlxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl15nbauKoP7G76kIg9dGFB/81Z/T5MFQvTlbmjGohk=;
 b=Sf0I6ezh0o5/kHxRvkDlTZvXGKibWSHmce0tuafqN8UF7Wec8ovle+obgnyFQg0kpuLQ5MRvdDFfz2Gm4JrtG49J2L+f/oWBK80D3wr0abjhjuylU1R5v/I9OHl4p8uXMBLvbJh1/FGmqidQ/aKVCraBy0bb+EdDjvYzgeo0C+o+nqg2p3wL0iIE+xf3Lvb4N24mHAVJD2EpXKL/zzr7xVWvxIOGqOL1YKZjk05CBXucwf7H2rrHQ1H1ttj4QkIjaTmBKR4htuhJvv2GHY9LawyuenVZlX8ocAq/13TdC/j4mbe4yRB0d1oJDRlVi2XVO4SsBd81n+Q/7YE1OZoaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl15nbauKoP7G76kIg9dGFB/81Z/T5MFQvTlbmjGohk=;
 b=SRWEpPFrgrgn3+xYK8BfneUvluOsfVsYjsajfPF9rxxXLcINtM7iS5lXJAm8AQZ8p93Kk3Eg6e8FSplaPqrfyy1FlZ4R0hzKrmmKyrZjFb9YHbT8roT+ZuJA0YzFWJDZV6IHX6egYuMrAf7O6maJeyEOWT39DdeR1EfZuCav2fY=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LO0P265MB5730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:41:19 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:41:19 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>, Brajesh
 Gupta <Brajesh.Gupta@imgtec.com>, Donald Robson <donald.robson@imgtec.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/imagination: Add support for trace points
Thread-Topic: [PATCH] drm/imagination: Add support for trace points
Thread-Index: AQHc4tArMh1Gqw2OJEaqyFg+KYvKDrYVQy8A
Date: Tue, 19 May 2026 11:41:19 +0000
Message-ID: <76aa5f15-4210-44f1-a71f-d7112941fc2f@imgtec.com>
References: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
In-Reply-To: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LO0P265MB5730:EE_
x-ms-office365-filtering-correlation-id: 98c1bc69-88c1-43ee-cecf-08deb59b8b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6049299003|38070700021|4053099003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: /tLbCduKn40KlgLmtryD83bolw1rUiGUS8ufT1681h/RBJK09mXHjhKIgLf4S7+BUe0+1mjhqH+wBv+Lp9hqcdqP9rO4yOs/Mic4lq63PW2mxIxnL3CLIohaiAcFqgLJYuWGeBEDiCZ/o3UGODWl4X+RYmLsy8FMDPl3Dk4uzW1C2rJPmW/DNZrTO8iXdOmNkVvacDPkuBXI9dw9HySM+cIyj8Jmz47UBlqmeW3vLkvutk1h/rMuz3alt9LjG+8TVDnAIINWlOD8Y0uhX1IFxI5JQ0auXx8TR9n5DEv5oklLNv4trS7jC/Rv555CBnrPL2ghRmMAwy3jiyU7QNm173LMwOQTUbPwOf2f7fTkdFr/Wmu/nsQ0I0mGm4FptlQPzpa+SawhgtHwqLOhE9GwrEwVd4N8qbpo6s4RtWi/rATXTyZ+9RboCEBypWgoAG++wn6UAs0cinHDLTzsxyJVscBSITA4+bNk0id59p9dsOvYvKMbFscbOYyW3adKd9x4VAFcBjT/2dowagOB0gdGRZFvbI2ZNb5mURPwpTxPSI5Bn/NUXLTeP/l+ucK6AnedAODH7X88KKH00qZtvH5dAwKhv6pP2tNQaqX6/2CbItH0coQoUHkQUD3J3PkJpIZRWr1M8/gVo4tj2qDIt439OtkZ4t9deDsRFu51Tp8l3rWQKUDgvlejknabdJpbAanCVc2D/FbPVsTaZ1VEaoaqmFVjb3vFpnDTBRkXe9RytdzP7OsNuqHUdenMVqkS1ppo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6049299003)(38070700021)(4053099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFUUVpremJxZGtxYVBYL2RaWFlmS3B1ZkM1b0s3OWI4a0Z6UUxRdkpIdEJS?=
 =?utf-8?B?aE8rYTRBa3VpMmV4NHB4Yk1GVEdPbzBvRzRWWDhOYnE4QllPU3VPMDBlS2V6?=
 =?utf-8?B?OTU4UWxRdlNMVkxMYklJNlQwUHgrWGNpc3VENWdublZkNHVwSnYrYmN5Q0Vp?=
 =?utf-8?B?T2UyelFBYS9TRE9OUW9UVWxNM0lmWm9WaCtNYzdiMzIxZHkydUQzUkdsNExo?=
 =?utf-8?B?cm1HckRPVDZscXF1RjN2enpzejBJVldJSytlR1FEZ2MrUHp1dlhQN2dka3JN?=
 =?utf-8?B?RHVFT0cvMGlKU283WEphZk5WeFJsVDhnSUpMRm1RZUJhUHBhV0taUHVZUjl0?=
 =?utf-8?B?M08rakZINEpVenhZb281eDNySEdVT1ZXVit2YnlqeFl5T1c2Ny82V3BjbTQw?=
 =?utf-8?B?M0dpck9Nb3lWSENKd3F4ZUYxc3ZvRXFUQlJkQURsTytUT1hLNkpxM3U2WDUv?=
 =?utf-8?B?NVpRcDJhZm9CQmkveHBZVXI4SDFYdXYvZDl1QmRLN1g1VE02ekFDdFFGWUdL?=
 =?utf-8?B?SDlaaHY1VkNwcFZVUzRLYlNEOHN6UmlEcTlyZlVFWE9ONnV4SnJQcjBmQmIv?=
 =?utf-8?B?Rkc4c3NOSlhQTElJSG5yc1BsSEIvODNyN1pWcjhDdjlFT3hIc2J5Z2lKWFVi?=
 =?utf-8?B?RHY2OW4wN3NjNFUwNFZtYjRxME9wV3NyY2JTMmxXbUJXdnRxRGZodjVkUjRK?=
 =?utf-8?B?T3h5R0pySmJyeGR6VHQ5WTg0dkpHY01udHRXK3pJSyt6eFU4ZVpPMEhmdEk5?=
 =?utf-8?B?djlOV2w3N1o2RGI0SlJDWW1JTVp2KzUva3FJbWZCYWQvMms5VlJ1bHF1R3Vz?=
 =?utf-8?B?K0k2ZEY5eW94Q3FIYkpsWGtmS1luV0tLTC9WUFRlMEEvR2NYZVo1eUR4RWxw?=
 =?utf-8?B?aS9pYU1VQUZTUUtqSnZFalBWSWxHNDdEZWlOZW0vY3BXRm5XQ1lIUHpGcElw?=
 =?utf-8?B?NzdxSXJtWXdubktXM2ZVSm1kb09CNW43dGpMMXB4Q0g4RkJWZHJsamRqREM2?=
 =?utf-8?B?Qy90V3ZvenRTWENRbXZJclpJbmZ0TWJXbHRWZVZQTU9zMG5pemw5elBKOXB4?=
 =?utf-8?B?Nk1MMjZzLzFRc0FRV3Zac3dMcTVUa0srR29sNnNjYkRzS1JpeGRScDYybC9K?=
 =?utf-8?B?OFlMQnRibjhZNWxVekVPdWRiSmdhVDBaMm9Sd3lTYUJOaU1Rc2JBYjF1eE11?=
 =?utf-8?B?MDJBRGxPSVUyak93M0NleTBuT3BFNDJPc0huNUZ6REt2QXBVVVBBRzlQbnRI?=
 =?utf-8?B?NUtPaXhINmxxODRQMFMvRmFnVEtsNkZGWisyYVFFVi8rQ0dtdk0rMzB0Ty9E?=
 =?utf-8?B?d3A2R2dWdVh0eVFJbE81MDFPZGR4N0xCc1VZTnVuSHE3RFBWK3VqUjNheis5?=
 =?utf-8?B?Z1FBay9ha2xHVmhOZ1RnbXYxNmM5V2JQWHUyWXI1Rzhzb2h3NW9mQmZVRzhP?=
 =?utf-8?B?QWpzSTRmYUpHd2dVM2JGa1BBOWl2WnlndE5tdEpUOFl0ZmtxSkRVS25RUnJj?=
 =?utf-8?B?aXZOSU5LVW5ySVVWZG1oV2hPMlZhOUdKL1BnT2JWdHhxRFNoYzZLMVJBcGFQ?=
 =?utf-8?B?QnNFS1FVNFpRa2x1REM3OEJGaHVIazVIUkVYVVlScEo2bzZQdmlJTEdpZWl1?=
 =?utf-8?B?YVRJZko1YU5BSkZtR25wSVczcWxBcHd4aFFrbjdBZTEvaW9qOFRxbGNLZURq?=
 =?utf-8?B?N295RGg1NVZ6T0tKSzlNLzlVdHEzVHFNUUo0NWtPbGNDWUh4em5jYWt3RHN6?=
 =?utf-8?B?ZC8xRTZTTTRTVEprblIyMXEwTGE2cVlGeEE1NGZDclZNSTBBdVM3eTdQVng2?=
 =?utf-8?B?TzdHb1pyVVAzVDh4NDRxVEJGQ0VLcjd2NGdxcjI5bDh1d2lFbmhwT2RlRWVh?=
 =?utf-8?B?YjArVHpXalY0Zk4xbk94SGJKY0FlbDc3cUdoV2lkQ0NvRzlyU2Vnb1BoKzZD?=
 =?utf-8?B?VVQ2TnQ3QVpwcWlJeFp3S25SQUhqOHNDZzQyL1E3L3RKNlc5RHRYLzNHQzg5?=
 =?utf-8?B?V0hBQ3ZCejY2bGwrY3dac2p0V2RmazloTnlUSDdiNGloRmYyQkZDc0pXOUd1?=
 =?utf-8?B?RVpBcTBRMFJ3ekVJK1VyWlBDYlh3amJzQXNUNUs1N2pUdThwY3VCZVJYRjN6?=
 =?utf-8?B?SGJ0a1ZxUGlLNThlWmthMHBpbnhmQ1hVSWNldmVxaGtRYlBHQW5LNy9xbU1Z?=
 =?utf-8?B?NFh3ZSs2UGZHV2RZcUtpbjRHSmltbnlFdWpJZVBrY3A1RTZ5SmU3bnB4RHl3?=
 =?utf-8?B?Q3dHaHV2SWpUWGN4QS9jSzZIRllmb2k4eVFuMU8rSEJYK1lpdlVlYkU2ekI3?=
 =?utf-8?B?enFwQ2k4b1NRQzEwZTRJY2FiVERRUklEd1J3TUdyN3BmdnRvRyt5Zz09?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mQjE50rmicRyI5wYFsotY0xy"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J8urbZ0Rh2ZO1TTt7qKQNG2k8d49HImop+HEod+YJLL4/ihv5aqVfr/9fzALkJtpjasWSwFPeMkadheeQ2M+c6QGWIa9bfn+XsKQHJS7DdJOoqY4Cj+pcNhRWlxkjlo+e4TZ0biOsGUDXxc2gxLm5VTE6+0SB74/Y8qd6e3gd5EUsyUcPUiHIRWv2qOMNBAe9fGHxyIKehWw4JgnAkoAK+5EFlPX5ewXgYy4MV9LnkFBxvtkrmh9Q9sgQpKpSWJN5w+a1kGEX9QtlYKHTQ51ZfJQ7YhpYZJvHRulrogziCjb9CzrKka3Qgxxi6AeAL7Xv2yOqmIKWcDrBDSAV7LTSA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c1bc69-88c1-43ee-cecf-08deb59b8b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 11:41:19.3609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPfeIVnz00z6xPvqeg8dOWMlWLDS6WExQgt7huSJ46PFIgFgej4cBU0B3r1Xirjn0bDTZ7iY1Ofu0n9RQbPWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5730
X-Proofpoint-GUID: R3TF8fLz_UPopwGFDfdGhUfjtxHAjAQH
X-Proofpoint-ORIG-GUID: R3TF8fLz_UPopwGFDfdGhUfjtxHAjAQH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNSBTYWx0ZWRfXw23T5U+g4HB1
 KM9ewM8zEEAJiVzibPoOQ7XHj0FwpAQJAqVkby4uI5ZSSlNRfSHgRlVybj5vzYDqBmfwMBoR/Q8
 FvkEGSYrgzTLG4PuRMsJ3JxGBcOuZWLrsE68DFC8sUumY3vLMHec+lwqJ7/kkQ6OzDuAuzoJyBl
 F6hzHeRxCSCx0ccDo+7lGf92afRZ05hScI1C8S7M3K0RrJCHX5FIotpVkunie52OJ0LtHGFb3tF
 eVzBL9Ejo5K6p7DZ7md6SowqZ+ToAOzGkEbLrSlq4rZ1cbstlweZY9rOmop6gzH3urlf8q/M6kz
 UgAu62XmZQYBH3x/+z3X1Vkdvk5LCl6GYZ5AAcH+u1fxBckSb45LUx27VtLKgsfJYc3l5hyq8Pe
 qkmnqrxoUUCd9f1MS0YR269ABeNT6FrP7KkcNE5nY1zPFwNSk8Td2Vb0PgyuMElOlhusahDzwNZ
 GEAvt/ChhBFOc2P9NlQ==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0c4c62 cx=c_pps
 a=t7jrPeAW8isWQ8DBdB4q6g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8 a=LSCN5g25LAhXxnAEil0A:9
 a=QEXdDO2ut3YA:10 a=lhmcP61rKEMR1-jKyeAA:9 a=FfaGCDsud1wA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

--------------mQjE50rmicRyI5wYFsotY0xy
Content-Type: multipart/mixed; boundary="------------FNpveKnKM5ChJHc75e6U6L6Q";
 protected-headers="v1"; hp="clear"
Message-ID: <76aa5f15-4210-44f1-a71f-d7112941fc2f@imgtec.com>
Date: Tue, 19 May 2026 12:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: Add support for trace points
To: Alexandru Dadu <alexandru.dadu@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
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
In-Reply-To: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>

--------------FNpveKnKM5ChJHc75e6U6L6Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/05/2026 13:00, Alexandru Dadu wrote:
> Add support for workload submission trace points.
>=20
> Co-developed-by: Donald Robson <donald.robson@imgtec.com>
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>
> Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

> ---
>  drivers/gpu/drm/imagination/Makefile           |   3 +
>  drivers/gpu/drm/imagination/pvr_drv.c          |   3 +
>  drivers/gpu/drm/imagination/pvr_job.c          |   3 +
>  drivers/gpu/drm/imagination/pvr_queue.c        |   5 ++
>  drivers/gpu/drm/imagination/pvr_trace.h        | 113 +++++++++++++++++=
++++++++
>  drivers/gpu/drm/imagination/pvr_trace_points.c |   7 ++
>  6 files changed, 134 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/ima=
gination/Makefile
> index 1222a14262e4..a5c5e386f16a 100644
> --- a/drivers/gpu/drm/imagination/Makefile
> +++ b/drivers/gpu/drm/imagination/Makefile
> @@ -32,6 +32,9 @@ powervr-y :=3D \
>  powervr-$(CONFIG_DEBUG_FS) +=3D \
>         pvr_debugfs.o
>=20
> +powervr-$(CONFIG_TRACEPOINTS) +=3D \
> +       pvr_trace_points.o
> +
>  obj-$(CONFIG_DRM_POWERVR) +=3D powervr.o
>=20
>  obj-$(CONFIG_DRM_POWERVR_KUNIT_TEST) +=3D pvr_test.o
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/im=
agination/pvr_drv.c
> index 268900464ab6..b20c462bcba0 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -14,6 +14,7 @@
>  #include "pvr_rogue_defs.h"
>  #include "pvr_rogue_fwif_client.h"
>  #include "pvr_rogue_fwif_shared.h"
> +#include "pvr_trace.h"
>  #include "pvr_vm.h"
>=20
>  #include <uapi/drm/pvr_drm.h>
> @@ -1150,6 +1151,8 @@ pvr_ioctl_submit_jobs(struct drm_device *drm_dev,=
 void *raw_args,
>         int idx;
>         int err;
>=20
> +       trace_pvr_job_submit_ioctl(pvr_dev, args->jobs.count);
> +
>         if (!drm_dev_enter(drm_dev, &idx))
>                 return -EIO;
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_job.c b/drivers/gpu/drm/im=
agination/pvr_job.c
> index dd9f5df01e08..b8a58d817009 100644
> --- a/drivers/gpu/drm/imagination/pvr_job.c
> +++ b/drivers/gpu/drm/imagination/pvr_job.c
> @@ -14,6 +14,7 @@
>  #include "pvr_stream.h"
>  #include "pvr_stream_defs.h"
>  #include "pvr_sync.h"
> +#include "pvr_trace.h"
>=20
>  #include <drm/drm_exec.h>
>  #include <drm/drm_gem.h>
> @@ -510,6 +511,8 @@ static int pvr_job_data_init(struct pvr_device *pvr=
_dev,
>                 }
>=20
>                 job_data_out[i].sync_op_count =3D job_args[i].sync_ops.=
count;
> +
> +               trace_pvr_job_create(pvr_dev, job_data_out[i].job, job_=
data_out[i].sync_op_count);
>         }
>=20
>         return 0;
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/=
imagination/pvr_queue.c
> index d10a13173f0f..3c2331e834fb 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -10,6 +10,7 @@
>  #include "pvr_drv.h"
>  #include "pvr_job.h"
>  #include "pvr_queue.h"
> +#include "pvr_trace.h"
>  #include "pvr_vm.h"
>=20
>  #include "pvr_rogue_fwif_client.h"
> @@ -725,6 +726,8 @@ static void pvr_queue_submit_job_to_cccb(struct pvr=
_job *job)
>                 cmd->partial_render_geom_frag_fence.value =3D job->done=
_fence->seqno - 1;
>         }
>=20
> +       trace_pvr_job_submit_fw(job);
> +
>         /* Submit job to FW */
>         pvr_cccb_write_command_with_header(cccb, job->fw_ccb_cmd_type, =
job->cmd_len, job->cmd,
>                                            job->id, job->id);
> @@ -1193,6 +1196,8 @@ void pvr_queue_job_cleanup(struct pvr_job *job)
>=20
>         if (job->base.s_fence)
>                 drm_sched_job_cleanup(&job->base);
> +
> +       trace_pvr_job_done(job);
>  }
>=20
>  /**
> diff --git a/drivers/gpu/drm/imagination/pvr_trace.h b/drivers/gpu/drm/=
imagination/pvr_trace.h
> new file mode 100644
> index 000000000000..ffbbde3b2bcc
> --- /dev/null
> +++ b/drivers/gpu/drm/imagination/pvr_trace.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/* Copyright (c) 2026 Imagination Technologies Ltd. */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pvr
> +
> +#if !defined(PVR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define PVR_TRACE_H
> +
> +#include "pvr_context.h"
> +#include "pvr_device.h"
> +#include "pvr_fw.h"
> +#include "pvr_hwrt.h"
> +#include "pvr_job.h"
> +#include "pvr_sync.h"
> +
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +/*
> + * NOTE:
> + * When adding trace points, or extra data to existing ones - you must=
 capture
> + * all the data in the TP_fast_assign section that you wish to use in =
the
> + * TP_printk section. This is because the printk is performed on deman=
d from the
> + * captured data when you `cat /sys/kernel/tracing/trace` and by the t=
ime this
> + * happens any pointers you captured will likely no longer point to va=
lid data.
> + */
> +
> +/* Job submit */
> +
> +TRACE_EVENT(pvr_job_submit_ioctl,
> +           TP_PROTO(struct pvr_device *pvr_dev, u32 count),
> +           TP_ARGS(pvr_dev, count),
> +           TP_STRUCT__entry(__field(struct pvr_device *, pvr_dev)
> +                            __field(u32, count)),
> +           TP_fast_assign(__entry->pvr_dev =3D pvr_dev;
> +                          __entry->count =3D count;),
> +           TP_printk("pvr_dev=3D%p count=3D%u",
> +                     __entry->pvr_dev,
> +                     __entry->count)
> +);
> +
> +#define PVR_JOB_TYPE_TO_STR(val)                                      =
   \
> +       __print_symbolic(val,                                          =
  \
> +                        { DRM_PVR_JOB_TYPE_GEOMETRY, "geometry" },    =
  \
> +                        { DRM_PVR_JOB_TYPE_FRAGMENT, "fragment" },    =
  \
> +                        { DRM_PVR_JOB_TYPE_COMPUTE, "compute" },      =
  \
> +                        { DRM_PVR_JOB_TYPE_TRANSFER_FRAG, "transfer" }=
)
> +
> +TRACE_EVENT(pvr_job_create,
> +           TP_PROTO(struct pvr_device *pvr_dev, struct pvr_job *job,
> +                    u32 sync_op_count),
> +           TP_ARGS(pvr_dev, job, sync_op_count),
> +           TP_STRUCT__entry(__field(struct pvr_device *, pvr_dev)
> +                            __field(struct pvr_context *, ctx)
> +                            __field(struct pvr_fw_object *, fw_obj)
> +                            __field(u32, fw_addr)
> +                            __field(u32, hwrt_addr)
> +                            __field(struct pvr_job *, job)
> +                            __field(enum drm_pvr_job_type, job_type)
> +                            __field(u32, sync_op_count)),
> +           TP_fast_assign(__entry->pvr_dev =3D pvr_dev;
> +                          __entry->ctx =3D job->ctx;
> +                          __entry->fw_obj =3D job->ctx->fw_obj;
> +                          pvr_fw_object_get_fw_addr(job->ctx->fw_obj, =
&__entry->fw_addr);
> +                          __entry->hwrt_addr =3D job->hwrt ?
> +                                               job->hwrt->fw_obj->fw_a=
ddr_offset :
> +                                               0;
> +                          __entry->job =3D job;
> +                          __entry->job_type =3D job->type;
> +                          __entry->sync_op_count =3D sync_op_count;),
> +           TP_printk("pvr_dev=3D%p ctx=3D%p fw_obj=3D%p fw_addr=3D0x%x=
 hwrt_addr=3D0x%x job=3D%p job_type=3D%s sync_op_count=3D%u",
> +                     __entry->pvr_dev,
> +                     __entry->ctx,
> +                     __entry->fw_obj,
> +                     __entry->fw_addr,
> +                     __entry->hwrt_addr,
> +                     __entry->job,
> +                     PVR_JOB_TYPE_TO_STR(__entry->job_type),
> +                     __entry->sync_op_count)
> +);
> +
> +#undef PVR_JOB_TYPE_TO_STR
> +
> +TRACE_EVENT(pvr_job_submit_fw,
> +           TP_PROTO(struct pvr_job *job),
> +           TP_ARGS(job),
> +           TP_STRUCT__entry(__field(struct pvr_job *, job)
> +                            __field(u32, done_seqno)),
> +           TP_fast_assign(__entry->job =3D job;
> +                          __entry->done_seqno =3D job->done_fence->seq=
no;),
> +           TP_printk("job=3D%p done_seqno=3D%u",
> +                     __entry->job,
> +                     __entry->done_seqno)
> +);
> +
> +TRACE_EVENT(pvr_job_done,
> +           TP_PROTO(struct pvr_job *job),
> +           TP_ARGS(job),
> +           TP_STRUCT__entry(__field(struct pvr_job *, job)),
> +           TP_fast_assign(__entry->job =3D job;),
> +           TP_printk("job=3D%p", __entry->job)
> +);
> +
> +#endif /* PVR_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/imagination
> +#define TRACE_INCLUDE_FILE pvr_trace
> +#include <trace/define_trace.h>
> diff --git a/drivers/gpu/drm/imagination/pvr_trace_points.c b/drivers/g=
pu/drm/imagination/pvr_trace_points.c
> new file mode 100644
> index 000000000000..71b53f267af0
> --- /dev/null
> +++ b/drivers/gpu/drm/imagination/pvr_trace_points.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/* Copyright (c) 2026 Imagination Technologies Ltd. */
> +
> +#ifndef __CHECKER__
> +#define CREATE_TRACE_POINTS
> +#include "pvr_trace.h"
> +#endif
>=20
> ---
> base-commit: 921578cf373981eba92774a27f7644a11282cf89
> change-id: 20260512-b4-pvr-trace-points-4d3b66116e15
>=20
> Best regards,
> --
> Alexandru Dadu <alexandru.dadu@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------FNpveKnKM5ChJHc75e6U6L6Q--

--------------mQjE50rmicRyI5wYFsotY0xy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagxMXwUDAAAAAAAKCRB5vBnz2d5qsM/7
AQD6+ZNjc+LsWhGCHkUlEol87x9rO83KL4pB3y6bosR0AAEAirrH1Nif4LRscvqVU+qBN8sIkja+
syiJPD9F6Zm6KAM=
=yaNl
-----END PGP SIGNATURE-----

--------------mQjE50rmicRyI5wYFsotY0xy--
