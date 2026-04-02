Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7500D39406
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D5E10EFA5;
	Thu,  2 Apr 2026 10:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="cfEKSZEf";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="FY4VKWBX";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2EB10EFA5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 10:01:36 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6323ug3X3898884; Thu, 2 Apr 2026 11:01:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=9+/foxavBPQMgDc7swklxyyFEdY8PqRdjxvSiZX7vTw=; b=cfE
 KSZEfC+23DlRTrxiGaJP+yrh//YVSWLj3X4mHcgcg7WeWbNFGHYAlxrr5dOiE6N1
 34Dfod0DOgDn0O6j0GB4/9m2+nOUyx+Sm2dGVK+HPCnOr1tZ50yM091zt25VlbR6
 njDjSZIdgM5GdwO/MZmLjlud/GU6ZZT0JTAv+P2HN/H7mq5kcTzLa4UCsP5WUsOg
 P38mVZZDQS8nmMpCDEPuo9LbyeoNtO5PMpsdCrGZUK0PjJJMCeSWF3DLDHjYa1xY
 I1UVihXxglgIH0W/nlfbs8dZEhpUp9BMBmrwPUaUhrq/jiix2m9T6Rr9ScX7GkXA
 xg8fCeS1WLONTcziEBg==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021078.outbound.protection.outlook.com [52.101.95.78])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d67xuvptp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 11:01:08 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8X+ufEGP6LTTSruwyfDQOQygnBlzOS5Pm519tww/lbnoXK9AIT6xOgo8nDBVbSLPFI8NeGdM9IIo1TrabBJzGwFgyz5fcHNZh8l7+vSPim5jqUBnXd4fgzgAxDyc3rz2g/+smtB6HJUBiD4k20FdxX8cjmdHiSfJ9e3vvjhjVZ0T33lMO9E/W+854VVW1WmHIErFNgBYq7qoSHfieOG3aJuZIUjTyqA/LV5t+XM1R+X+qd9j34vpaJobN48nMajSkusd5yGVIAjUKQzLlCygUhqcwnSSkQRI4R9Vno6HgH4l+UmEiDLmVdh+x4G6Z/vTe+2scymzDCSDQ8mmpzv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+/foxavBPQMgDc7swklxyyFEdY8PqRdjxvSiZX7vTw=;
 b=v2L+aG8pImXFzc/7gFrRdUW8XOpfOQtOnIKLVmAw0CY0oybJBO6lxMQcBZACVreBxvNOh2saVF14Jgrpz/+dj6EeZ+ExrA4tfNEtvmFCUsuK3oEysz+ijjuDNx+pv0c7Rqyv0Zo54U83x3pOq3+M89wxT+F/mUTsTsLvKYSfRdvD1IwEwz9sPFUqNf+46u2BPzjKKFZ6ZxETRWOE/OpHUlyQO2TZsQnu5GQb4WGbeNjg4/a06oeXSfiGPflQHeD2xg1FLJoBkeUhTGGdpC72EFBeGCUjgYYU5upJn1w34CskR2+tTpWw9XYZ78dvi3HR2TZ5JwlksLkJad8Mes56cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+/foxavBPQMgDc7swklxyyFEdY8PqRdjxvSiZX7vTw=;
 b=FY4VKWBXXCDu7jdbIe4bMLMuhrOX0TZItwkDIDZj3TyUi7Cs2RmC8FA/RUtaA5WmN0w+TX98dYMI5tezPURiSY6QGVV/V75gAWouX1UGHqYdbM39QraFSEixstaEVlCea4d7NqlLevgjKJQTORRAJvD1UCj1CFLblFDVVPOxoJM=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO9P265MB7584.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 10:01:05 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 10:01:05 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt Coster
 <Matt.Coster@imgtec.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
 <airlied@gmail.com>, Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
Thread-Topic: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
Thread-Index: AQHcwBrM1b+P1yVqFUKS+TRZarrY6rXLjkaA
Date: Thu, 2 Apr 2026 10:01:05 +0000
Message-ID: <d5d548e13b806108999259f84cee38051b8082e4.camel@imgtec.com>
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO9P265MB7584:EE_
x-ms-office365-filtering-correlation-id: 65c7bfba-7df4-444b-d564-08de909ec153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 27HjiR0yRCTXKMRP1v8m+YsrLIh9KovHOtp8qZ9Qg/1n24t0MOanOEcn90cFG9ro6+RkipDCthfXnMNWMRl/zVl5eEo7cF4uvEDvkKKAJjiDXJikK94M2c4g35jIRizqV2qS15AFwuHcIJ/t5AvvWIbbUkO8ob6NVURPDXPU+AaiKQJpyiu7DIual1zw6Ij6hFeInGlxvFdY+rve9BDjYWlOP8+BDVYokvrj/y3k+6BVi/1TZ1Eevn4SSfYMaMickimX/vjzq7JqM2GuKrGIHBltbq9N4rvC76MftSpgJE/OhAJvchfcnsa+MLAbfIXkkpOLXyDLSRzVN0bFNFpBv/L6ol9I9Jc3aCte39sHqomCYG1OvdbGu9erOXIWzO2l15xvnkgFZMIBARkbBZwm7pnYQ/T+1mgfEZGWc8p+Cj6LCX3sNAeKBTcTTKHFu4CGVktdhUls/ZlUdM5BUi7Vj1teR3uu/yIf2q4dAbaqWO+UxdlNiCVf0SloNSDtygAtMc/EiGex06Jm595WA/iluoLlL6HpB7zKQoh3PFuuohkK6YbJtok3fgdHpduAHxrcAv/mE6pibAwvacR7soQSpWj42GNfIvY4Tarrq//a5we3EJGGa7liUiRI4l46BEp62twUw8CNIYK9z60bCE3jS6dcYkmlsHP5X38rjzXWZIwNiZeiNQcDnfrVBcSDxBiYnCdMW2fXapMBfdB+zrTLVJQ07tB2Ncj0U7XBpqMUOiZMn/7iiLMSNsyKLBj5HL4PRJVazt07Qd3ZzzU3tz0onKxOvPgwlvTcof8spuu1yJ34KhsSuk7rC0VmRZZ4Fu5v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtJaWR4QXVQNktXUmNRaysvMUNpNS9GRVJRNm0wWmVqRi9WMmR6ZnlRU2VZ?=
 =?utf-8?B?bUVtcW1rUDd4NWNKNDJxVEt5NzdkajEyeEVHbjRJcERHaUQ0V0VjOTI4WUlP?=
 =?utf-8?B?Y1AwbjRZaGxSejdCRWRJS2JmVHhOeGY2dmpCd3ZHWTZUdzhMQ2NQOTEwRDY5?=
 =?utf-8?B?SUR0OHJtbWlTbDY2SFdQWHJJeXkwK1NRaEVVeENsUDE1SFV3cUVEWUFpQlFq?=
 =?utf-8?B?amN1YnRjYXd5NUtheUg3VHRGNmhWMUgzWWpoRDNQU01IcTY3eDVabGpxYnJt?=
 =?utf-8?B?QVROR3A3RUora0o3U2lUcUxuSk14TnBGRS9URzZRQkI4bFRMWktXWWRWeSs4?=
 =?utf-8?B?bk9jYWt4Rm1IZ0pvZmpQL01xSmdSYUc1K2g3QzhFRnRGN1IxOEVISHArbHNv?=
 =?utf-8?B?OUpYN29XTVNGMHkyMU81dHo4TU9UZUJZVG9JeGhTanpvL3VWRzlBMlBjTnlu?=
 =?utf-8?B?Wko5Z1hQTEN2VDhnOTJYbVE5T0RUeFdtRUNQbFdvWk52ZFA3aW82UitTK2tq?=
 =?utf-8?B?d1o3TFlKSkdyNHJBNUw0RDNnUkUwWU9pcjN2b0cwbTJxSHliNlBGU2YrUGp1?=
 =?utf-8?B?M1VFVTZJcml0UTdNbWt6ZmRwOEwydVYzQjJPQ2Z0bGg1WnkxU3hBckROU2ox?=
 =?utf-8?B?cUM1WWpmQ0YvMkw2QjRLc1F0SDRyTUcremw4eWVBY1lLdHNyb0VvWFJ4Q3V1?=
 =?utf-8?B?T25zS1FCWnMrNjRoc2psa2dRMCs1RXhFcW5kZGVYRUxSOS94ODdOSjNXSGpH?=
 =?utf-8?B?S3htMUlsd3d4d1VpeGRvdjdoRTVQWXplZTltU2FySjA1MVZvaHdUMTRhS1pP?=
 =?utf-8?B?WnBnVmMvdktyeDNQbWIvNnkwN3cyUzlIMTNqTkRxMnJXcW1rdi9rdFpLK0R0?=
 =?utf-8?B?dTVLK3V3cEtYdWNFM0xQME5zdHFFS2pJMFlXVEZ1OEt2cUw5S2ZPTDhmUnBM?=
 =?utf-8?B?RE90bk5sUkpESEJZUC9IcFFCbHhCWXEyUW55dW4yWGwvamV2VFM3c29VMFk1?=
 =?utf-8?B?ZlJsUCsyZjF5aXBzZ2VZQXBiSmEybGIrdnlseStTaWRDUXB3Y2RYY2NqVnQ4?=
 =?utf-8?B?M1p6Sy82c1dvMlE2STZlYTBZOEMxVmNodVJDdjdtY2xtWEVoU1JvM0ZHdy9W?=
 =?utf-8?B?V2tZTkI1eXh6VUxpTi9RMWZUcEpkV0JMMjF3c2IrLzQxdVNnbjFGbTNmNEp4?=
 =?utf-8?B?aUJqb1FLaUtKNjhuVllSSndxcE9rRUdBNThuZmw2TWRURXpJUk5IdmhodllC?=
 =?utf-8?B?MDgwZC9nMkVEdnQyTWNUNnB2T0l0MXZXcUVQWXlLM2sycmdWRTJFd1c3SExS?=
 =?utf-8?B?S0FrclZ0aEo0T0VkN1NEUHJiNUZKUkxHYVpXbXhOb1Babm1zS3VOZ1JLY2tH?=
 =?utf-8?B?MHZpTE5WMmE2eEhqTlJWc3gxMGdPcktMNHlTNEg0SHF6MXMwd25ialcreHBG?=
 =?utf-8?B?a2pwVGs3d3RkZDVveDNOSEVMME9NUlBTNWkzUVVZMG5PSCswdGdHd1RYQ0N1?=
 =?utf-8?B?WE56RWRyUy9QUEJUTWVuSHRpa3Z3U1pHMmVRamMveURvQThXcXZFQ21FMVhv?=
 =?utf-8?B?eGdBaHAvRFhTK2d2dnhDazU5SGtndEV3K1U3d1g3c2dHY3htLzV3NUlzZ2hX?=
 =?utf-8?B?OW1UejlsSHRoR1U4MzNrREl6TndNMDVtcTVwQjRDNmtrTzZqV2wxL1ZTUE1R?=
 =?utf-8?B?YjdSazcwRlhRWXdxcTkzYXRkckxEN2M4dWpyZElmSEdWRGFyRkd2M3A1cW1l?=
 =?utf-8?B?OU01c1EyVnlQaExYMlROUk5zOTIxVmxlTTBLaThPdENkL0g3emdiWENYU0RW?=
 =?utf-8?B?a25rRG50TVlHeDhka2x2WDVST2hWRGVDZDRJY1NPZ3E2dzEvSnlQZ2Uzcmow?=
 =?utf-8?B?Ukt5Q0hVTkJhdkVzb3hSQk5uUlcwcUVQdy8weVVzdDJ0bElJMU5sY2tYSGl5?=
 =?utf-8?B?SDhaZDJHK25kS0k4a2NycW1TNDd4NUNhUEpWM0d3UkJFd3l4ZjFRbVlUZGxy?=
 =?utf-8?B?V3FYbVFWMEwrNVY3azRaQUE1NHNHVjRFNkk2SEpEcjdxaHVSUWNldmNRWkMr?=
 =?utf-8?B?R2NQd2ZOQmExeU8vbm50U3ZJaTNQMkZTR0wzbktFQ2xRL1V1bXJmZVVXQnMv?=
 =?utf-8?B?R1ZOTElLU3lPTUFPMGw2U1pOUEc3WWg3OEpaRVlKQ2dkM2pyNElRTzdlSFRQ?=
 =?utf-8?B?RnNBQWxrV29SKzc4K3dwRk5OaWVzamRsaDU5SU1lSGFYRjFncmxqT1dTczZy?=
 =?utf-8?B?TEV5cmkrc0pVZ3VzaHpCUWhxblN2enJqVjZTTUR6dXlJanJlc2RuVnNqY09D?=
 =?utf-8?B?aFcvcG5sczZpcUhaR3VTR04xMVR4emNvRE9qbXVzT29qQ2hkQmcxb016T29D?=
 =?utf-8?Q?jvm62TRnXjX7JH/xWVskjV3Tvegeg9QdB5q3BGPv1TzGa?=
x-ms-exchange-antispam-messagedata-1: pph2uYdDdhfwN+gj0gGAtbLZDhWRmMq8cgE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C1CAC9B021A4A43B89C35816835885B@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DkGE97bbBipNGXBh5Islw83m0R81vS/Fevwm9HZm3xFZVEiU+oFhLH4Ax4ci3CawIKvdXP64r8n4op7e3xGU74VgLFFPmMNXMspOG5Vnd+G4w+1WNge7JxFXflP+MaCL85ynBMYrrurP7z0hYLRgy/IzkIE5HCzCM/o9bgCOCjOt7VDGPakoxlGNwnX9EvvqLJw8xMzdmrAaF8oeyHCmJs8ZNsvd6GM9fRtloGt2OPN5WGkUGxiQZoJUR6RjzNd93nAKMZ43gdOkZEIzqJiu+uKuyPsPU4HTSHdO78oyU3N/b/7fVJOuMfoGUqhSXq53DHQWCHyqKju2yM6wkBKOjA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c7bfba-7df4-444b-d564-08de909ec153
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 10:01:05.5411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDj1t20uIGAyqvp/6i1TAyrYfkdzGYRESS8AO/tOCbh3pcZnXge7i6z5WAYXAKr9u9YzFcL68v67LumIcGa1v8yCMNOUlVSTZWtl+qVfR8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7584
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4OSBTYWx0ZWRfX0JGYMQyQGbbL
 rnymVejC6/QuGpwUYuuRiUfRz+m4Px3FNQsmLXIJjhpwBEYTKAiMO2+vB++CO7ha+v/+0h9wqiC
 GC0d5liwdNSQBOAdYNP/dnX+i/ALZZNKlF8QuFbbZIauE2cwQiO8+Zt3zvOc2j+PpaEn746NnTe
 AknlEz7x/Hkq47F5mzYXLGqwmuuRXDKQq9yq4C4HOH6wvGnRVJacr636yjiyzg7/EA4BdTFQeTW
 JCETyt0JCz5UKpk9Ju6J8d8+8+FDMu8fqbdxuYtcReW4x3KkaBVT3wd8ZpyvxeUDKZIeZ2G9uA1
 OMaVFX8UHvWhdq8jRIGgesgkeb5XkuVPy1axvGdZynZ0IeKBxGYdXtNWixmldRzW8SdDo2CecV6
 Wfm+RVdd44kadAPcSBg5dKNZV/SvqkXXLXVBzX4RjoCke79ylVcPKkUfULfBJGozREI2VPA6oZM
 QHUdG7bVePOSGUK8VXg==
X-Authority-Analysis: v=2.4 cv=QO9lhwLL c=1 sm=1 tr=0 ts=69ce3e64 cx=c_pps
 a=kMZz7MbmqDdJlgyOwmxHwg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=yZ6PCt7aPuz2kyur9B0A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: N9aKrcKu2GBqrIs1PdBYk4DTuT7FFRNq
X-Proofpoint-ORIG-GUID: N9aKrcKu2GBqrIs1PdBYk4DTuT7FFRNq
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDA4OjU2ICswMTAwLCBBbGVzc2lvIEJlbGxlIHdyb3RlOg0K
PiAqKiogTk9URTogVGhpcyBpcyBhbiBpbnRlcm5hbCBlbWFpbCBmcm9tIEltYWdpbmF0aW9uIFRl
Y2hub2xvZ2llcyAqKioNCj4gDQo+IA0KPiANCj4gDQo+IFRoZSBmaXJzdCB0d28gY29tbWl0cyBm
aXggcmFyZSBidWdzIGFuZCBzaG91bGQgYmUgYmFja3BvcnRlZCB0byBzdGFibGUNCj4gYnJhbmNo
ZXMuDQo+IA0KPiBUaGUgcmVzdCBpcyBhbiBhdHRlbXB0IHRvIGNsZWFudXAgYW5kIGRvY3VtZW50
IHRoZSBjb2RlIHRvIG1ha2UgaXQNCj4gYSBiaXQgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+
DQo+IC0tLQ0KPiBBbGVzc2lvIEJlbGxlICg4KToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBD
b3VudCBwYWlyZWQgam9iIGZlbmNlIGFzIGRlcGVuZGVuY3kgaW4gcHJlcGFyZV9qb2IoKQ0KPiAg
ICAgICBkcm0vaW1hZ2luYXRpb246IEZpdCBwYWlyZWQgZnJhZ21lbnQgam9iIGluIHRoZSBjb3Jy
ZWN0IENDQ0INCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBTa2lwIGNoZWNrIG9uIHBhaXJlZCBq
b2IgZmVuY2UgZHVyaW5nIGpvYiBzdWJtaXNzaW9uDQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjog
UmVuYW1lIHB2cl9xdWV1ZV9mZW5jZV9pc191Zm9fYmFja2VkKCkgdG8gcmVmbGVjdCB1c2FnZQ0K
PiAgICAgICBkcm0vaW1hZ2luYXRpb246IFJlbmFtZSBmZW5jZSByZXR1cm5lZCBieSBwdnJfcXVl
dWVfam9iX2FybSgpDQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogTW92ZSByZXBlYXRlZCBqb2Ig
ZmVuY2UgY2hlY2sgdG8gaXRzIG93biBmdW5jdGlvbg0KPiAgICAgICBkcm0vaW1hZ2luYXRpb246
IFVwZGF0ZSBjaGVjayB0byBza2lwIHByZXBhcmVfam9iKCkgZm9yIGZyYWdtZW50IGpvYnMNCj4g
ICAgICAgZHJtL2ltYWdpbmF0aW9uOiBNaW5vciBpbXByb3ZlbWVudHMgdG8gam9iIHN1Ym1pc3Np
b24gY29kZSBkb2N1bWVudGF0aW9uDQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9qb2IuYyAgICAgICAgICAgICAgfCAgIDggKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfcXVldWUuYyAgICAgICAgICAgIHwgMTU0ICsrKysrKysrKysrKystLS0tLS0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9xdWV1ZS5oICAgICAgICAgICAg
fCAgIDIgKy0NCj4gIC4uLi9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9md2lmX3NoYXJl
ZC5oICAgIHwgIDEwICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3N5bmMu
YyAgICAgICAgICAgICB8ICAgOCArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9zeW5jLmggICAgICAgICAgICAgfCAgIDIgKy0NCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTEwIGlu
c2VydGlvbnMoKyksIDc0IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDNiY2Uz
ZmRkMWZmMmJhMjQyZjc2YWI2NjY1OWZmZjI3MjA3Mjk5ZjENCj4gY2hhbmdlLWlkOiAyMDI2MDMz
MC1qb2Itc3VibWlzc2lvbi1maXhlcy1jbGVhbnVwLTgzZTAxMTk2YzNlOQ0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiAtLQ0KPiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+
DQo+IA0KRm9yIHRoZSB3aG9sZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogQnJhamVzaCBHdXB0YSA8
YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQo=
