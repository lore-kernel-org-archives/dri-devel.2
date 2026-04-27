Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E9FF886A
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C21E10E742;
	Mon, 27 Apr 2026 13:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="vfu3WKXF";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="GRinlOVg";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D061910E742
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:00:40 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCDs5G3285157; Mon, 27 Apr 2026 14:00:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=09vSTZz2GrgunO6Gn1AtA+ArrENffHKfdvaoMJ2e4gM=; b=vfu
 3WKXFpb1XJw3327Z8sV71GOTlh5r/TuT0zMraJAVwyIvFMn7tYXTEk25lY9q5wFY
 qLSTNQIXy5EzHrmrBq4jYMq8OWZMBeGWaVU2YlaX0gVs4jxhO7CkLFgkhitIjryb
 NGrmSPyOSNBIRPzRVIXonA99ho6Gbr28DFRpBdBbX3WTRtcFWp3oubiqkBBcY2aM
 8fzW14amHET/lAIhcpq33YrBx2bOEUJ4BrP7UslKXXJvgF5I03mEdxvzMGpf+vgK
 f2TQ1rN9ck0UFNkWM9DQwWi44ZPM1umLM6WXzFawmkFKnURG2z7UgXTNuELqF0Kc
 HhQY+llFgGRu4tQjzYA==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022092.outbound.protection.outlook.com [52.101.101.92])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drnpxhr3n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 14:00:28 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5bkge6FS5y+oW8p+asa5YRYHuHyHgKYJetOxys3TRMB0GG1nerSenRTcfoxogBdKiPzI11hWzljdoYSjxctVlpjM2DZeIngT5C7HVDJcaZSpfytal/5fPqMZ30nIh7uDLqNdXMcNv+c8E5HtCFjQNM6t1OCZhMI7Pi6lUy2W3IbJIL2C4imRGrunMpJzDwYL39lzikXN3PzymCIlf1DtAsCED6Mnt3rjKk3Tncwl2IpVQtMWN5WaeggF5j9KhyRcXVp1xXBhuDvIcpwBNifX5Ap5tucOVl7JABzQY6ujGJal7KTrBOUJJXdrET+Eva9h0S6nZ5tfqxSFvbx2GEKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09vSTZz2GrgunO6Gn1AtA+ArrENffHKfdvaoMJ2e4gM=;
 b=UI4YKdS5B/wKGrf+azaEyhVxGOQJ3UbZfOHFPi/+8JdK6+XeYfFJU696Gg7s3sRVw/PrHhynq6EG204BT9KZukca4RB8/qYcN5pPUUHHtJIGt3Xb3Km0B0MQVNpFxk0oyMuVPDjqncy3EeSShjbFJcsNzZKkKYzQl2vkXSZ2ngYaz1LYHpMtV5UyJJ+AonjnX/xjhR0weuNyxZCKA/19b0mEzbOfIuw95SOYSDxO8xbHFF9GezA5w+51yK2/qOxPGNe97oJn2uTN3d+AYRRwhRUgGvZhfLumfYXYyXOZEJvqd6Ytl28YGnZZFo/RI5VKNvq7/lp1X7T3GAJxPRnW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09vSTZz2GrgunO6Gn1AtA+ArrENffHKfdvaoMJ2e4gM=;
 b=GRinlOVgED0cEuq2rxYbp0cy5IIuOQ7kBDz8FOjHXF1oZzBCH2UyUUGoOaMcol340O4zLw3kVnq2bdeD4/IqG96zzcuQh29PrO1MTot8nqs1zr9YwGrm21rK/CTcNpcTCg8Ki1Z5XjqQwNrg9bqoDNo7CHVR2g4hIJXPuB5Vi3s=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB1133.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:42f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:00:25 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:00:25 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt Coster
 <Matt.Coster@imgtec.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] drm/imagination: FW trace bug fix and
 configuration update
Thread-Topic: [PATCH v3 0/2] drm/imagination: FW trace bug fix and
 configuration update
Thread-Index: AQHc1gc01y1cojmvK0+7vvTQW1OnvrXy35AA
Date: Mon, 27 Apr 2026 13:00:24 +0000
Message-ID: <aa0859ec972b716c6fe0e3c1d956d2628c9c5d7f.camel@imgtec.com>
References: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
In-Reply-To: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB1133:EE_
x-ms-office365-filtering-correlation-id: 8ed03d04-d74e-40af-197e-08dea45cf2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KOwtcRpO4G8OfTvR2hi2zVfTJRMYRc3UbQk1MTAWqfnWOCGWaFklY1RJJb3ZbEijJ0hfT0swe2jTYJVrvUB5tFKE117TFoCbuTydSNXnDSQSGbjpLjH7SuBW6Ew6SOaZyn05KF92wp/95ixF3L8NW9t9WNmmxfoZ6D6pI/nqepduyx/eW8c9UkPqJzhln2Tv2c7vSbs8zCWopZ7bIRLt7OqAHhmnSUwUjTmL6uzeaL5cc4OaXrD4zm8T9TKD4DHtE9bemOI6IjEdaMLyLGB1HWNkTisYZgsBGQeUWQ9inIZPHoCX6wQqg4L77sQ67GF9zuhKUeHW7TvT63OnQIhZGqwZHCRXkdXvHGs/KZx3DFkt2QSBP14tF7IHq/Mj70qHVVpNk4GZybXROSVnO0TeIkr3wKIpP4kjlRcpxjpEFh7L5SXwAHj0S5vw2nGTxFI0Q1Xh5xENJOqQJBvv2WwQCeqLLYHjqWK7GY3y74Nbcc/ApVUpdP1LFmu33VR7YWngE3366kHv0IHYxS+aHJmZf67dogDwDhbJpCoWMG7iZGJaxZ6t+4aH3DX7KsAy0JfTu9GKUKTDGG401Y/WgVmFjJrXmZ/KjAunzDcosH27nLGag8npR8kYWUZ5UZ8sMMFNsqO8k6mgO7668Px54K7e41mrbk4qnfwS5fQvXdh2nLiPf8e3sNnGtxvrgGqgDY+WCVZ7kMc4X/IVX62YxRT6BbbsaGZsro+Roamxj+qUpQiqM2CfvZVQyB2jaDr/nIxTOf2SXSk5CLDGB5iB00n+ym3K3tYuUVHJYkwl43s3uc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTJ6OVRJMUxMU1pxNDg5UHVaODRYQXJheW5WK1diRnlLdUduVnRYZm5YYjRR?=
 =?utf-8?B?dHJ5LzdENWNSTUgrK3BNQkQ2NllYdzMycWorVU9tZ3JTRXF0RVptNFZwU2Ft?=
 =?utf-8?B?UDlianJFcjZGcENLa2F5czdlNzNhNktqYnl4d3d3V2h4UzFkV3NmRUxyamR5?=
 =?utf-8?B?eU5kOE10UWJhZE51dHZ6NkE3eFRMN0VHZDV4WXY3M1FLRnBmazUybEFPYVQx?=
 =?utf-8?B?TklCempIdXRIVnVtUVRMQk5nMmsxTWliVnJJNHlBd3ZnYTg0THFhdDQ3cXhr?=
 =?utf-8?B?K0ZER014cDMwTDRXajU4YURaM3o5eW5CUkZrY1AvVGpaMmRNb3A5T3hUcE9Z?=
 =?utf-8?B?UkdMcFZlc094cmJrdk92eHBKTTVFbXB6UEV0VDdzTExiZjRQVFZOWUlURmdi?=
 =?utf-8?B?b0Q0RXJZVVZ1UjNXczcyb0x3R0J0M3E0WitnQlNJdk90UklLVnlVYkptcmlN?=
 =?utf-8?B?OXEzN2xXbkUvZStvYjY2YlpDT0FYL2V1dkgxR2RPVW53c091ZGwzSHdWM1R3?=
 =?utf-8?B?c3c2eEFhNENhdVhxVTAxZHg3eEQxMWpjUXJ6TTVFVDZVb2dQOFVEV2E0TWlk?=
 =?utf-8?B?UkRUd2JRbGVtVW41N1RqY0FsaHlmZTZia0NpZmRGaGJDa1RmYlQ1QmVzNXNQ?=
 =?utf-8?B?b0pGRXNwTnF6QnVYUmVWb1pWY2Y2d05paFZLUDRVTGVsOWJpWEExblg2Vmdw?=
 =?utf-8?B?eTgzSTE4U2h2Ri9oWGFDb21hcGlnWGNxaitxRjlDdkpQejh1L0JMdy80Z3lR?=
 =?utf-8?B?Uzl6U2NSWDFPT0Jia3dHQjJoeUl3OGh0QnA1cTg3ZzFZTzh2b0RHUHQ0ZExR?=
 =?utf-8?B?eFRVSXRXUW9Nd3RDVFhXMHIwMEF2cVFxUXZrQ04zTXRiR2s0SVVSK2NOdzVI?=
 =?utf-8?B?U09pNWc5U0FDWDVYVmtYbEhVU2F4enhUb3ZFUjY5NVBzUWxVam93V1lGeEFx?=
 =?utf-8?B?TmNRMEpuWElSTkM3aVN4elFJMnA4Njh0RzdiUjVSUllkam1MWVQ1U2lZWEZt?=
 =?utf-8?B?ZndUVVZuRzFPT250RlJoNmlIWFFvdk9xaWJwY29HTUFxODBCcllxYnV5Mnpp?=
 =?utf-8?B?TkE1REV0bTJxcitkWi9yMTJsRzRMT0loT2pzbWYrdFVSN0kxTEtrT0puWE9G?=
 =?utf-8?B?Q1AzM2FxVXpZTng1bFZZLzJVTzZlVHBRaUZXMk43Y01jUTc5Z05FRUJSTDho?=
 =?utf-8?B?d2QrbHRXaHFiWk5jNzJkeE1IWTdGMmRIc1hpSDIydjhKajlYcy9veGJoREZ0?=
 =?utf-8?B?Ly9LbS96SHhjK0pvN0tyS2ZQdDE5blV0bC9tS3VYOElwL2VxU2swdWxxNXRB?=
 =?utf-8?B?Z0JYaVpndE1rU2NFdDJjYm9POUZ5YVVCTHJxVEdPOGZvZEhuQW1oaVFKcUln?=
 =?utf-8?B?UUhhajNQMm03YzBPd3llNlMwMU9PbFRVenhWcmJBVXVSN1QxVGltNm95RFMx?=
 =?utf-8?B?YzNBblZScnBKVE1VZTY5RUVibTVYRnFTTjJ0ckRYRmpiTlVVZVlXcEdrK3Bj?=
 =?utf-8?B?eHB3NDhFWUlXczZ6SHNYVEFyS1RNZEN3T3pqWlQyS2xkRUVrVk9OZ0luT1Fv?=
 =?utf-8?B?UmhGSHRMY3BUTklCS0FXb3pjSFJNZ3RwTDBiejRHUVFJb3VQZTVNUzRhUlRT?=
 =?utf-8?B?TjhZRit1cXFOeCtjSlZzLzVja1puaG5yV1JBaVNIYzB6M0NPdmQvYTgvUFlS?=
 =?utf-8?B?cEZjbkZNeEY5WmlkRTZPVHk1SUltdW03NUJXMG8rZ1A0YTZmMUhuOUtrWk5I?=
 =?utf-8?B?c0lCUnlqYmdnN2JYVWk2cHZWMjFGUzNPOTRld0dYRUtqaVZ3YzhYcWpnVDZM?=
 =?utf-8?B?WjlKcmU5aUhnRm1MajFicUxHekx0eENzM2FLQnZTSlZMVDhjcGoza3hZMDBU?=
 =?utf-8?B?SWlnKzN6U3pvVDRrRDRRV0cxVmNXcjNSd2dzUzhOWFhTUk5DWHhqNTBNMkF0?=
 =?utf-8?B?TlNxc1NnY042bVBqazhUWWU4dWM0L0ZLcUxzb1VxenA2WHRyRzA1TXlvaHo5?=
 =?utf-8?B?RmNoWlhRcjJPanBXeCtvNXo1d0JwenhLUDJPYldKR3VBL3QrNHd0OWFZWW5y?=
 =?utf-8?B?Yjc4VnF3ZWl0ZDJXNU13Z3g2YkpMK0NXSVdMY2p6TzdjTVhwUmRITTB6UDZ3?=
 =?utf-8?B?R01iRG96ZjdzTUlXVFNPMDNGSG05VkIvcFVSdWlPNFJ3TllwallaZnRkQVd6?=
 =?utf-8?B?Zk5uUVA4TXBMZE4yaW5lMDBicDhuUW1Cbnc5TzBoZlVnTWlVOUFnVXNnNTFP?=
 =?utf-8?B?ck94RjJFdFFvdWw3cG81eTZ1WmJZR3lhSVBtTWdvTnJSUjhSMHZQVVVObktT?=
 =?utf-8?B?RG9iV2hBZUFlT0xnVTVnSlhLY2pUNFV5S05qTXNGcW1SSHQ2SW5yQTJrT2NJ?=
 =?utf-8?Q?85yJpCrDIc+L++cw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C9B73A87F25B4FB5FDECCACBECA0B8@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HCLtve8vTFkqV56ymamRWpuFxDcnB361fyCFCv1XxBh6NcTEGJsgL7WZoXzRbmg+aUVORrdYoAQ69Y9boDvd5vtDVyJzmvDTY9j6pQfUWBXOGc+h6K77XwevKr++m9NTjuao6/YisQ479J+gQZBhAUQYvdH5yt28P9NovLQKi3xmVg9hP7FF66+teghP+SE4j5OrpNv1noka3rjbHi1TDEFIaMISIOqHf1OtalwakIwL+/xosQu30CpC9FMv3UfIoeAazo+TPUH3Hv0+5qQWnLE7BiaaBzrUYFdWkkAijFvkua+YiQQf2BTTuMJObtFafOIppCavjJj4mJLsA8pTzg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed03d04-d74e-40af-197e-08dea45cf2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 13:00:24.9417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNnj5SMV3Qa1Jlh9ereGREOA3d8bpiyy/kBoGcx5w7j5YYzIEEEfr6Gr3kPltfgi2j4wmNGyzqnGYX4QtHur7mo2wex7sj0b1OUUGCAAYCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB1133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzOCBTYWx0ZWRfX6VEJUujAIKcL
 +YUSR9sUYjccP8+JrAEMcNDIvcSeG0sJmihtT2tBkfApnWT3G/ZnOCvwtjjmAeL7PATnJX2y7g+
 UENQ4ypABRhJdaxja0CejwYumt9Tsyyu80a5FYyh7JZs/g6FlIAh93erqUxOENJAT7Eck41pkUt
 gIauDFa/+GMl6umGMFuu1sHPeOpUulhhalR1eJ18lXpbVhhRDD0iKPuSO+hJTQYAkQ6y1EMha22
 TX8vg5f6TqC12Q3vdQYjEXzkMfAifFY4HGXuzPgSkW5nLltWI8FXdmiP++ZTMXQXKIptFGo5D2J
 dO4kaKKKRbDP8m6HaIiafchQiP6dbGLP1GDcytYENlJqSfb5r1gduCbQqKFcKWfpDg/gAyxReB+
 lmMjtY54Re6ZCLRjSi58NrQfmUvXgyyoYKBnLjjD0yarwoiu/z2jzTKpv/sHLh2jBFqhk21qsdj
 7bu1MgWyp7SETpdTHDw==
X-Authority-Analysis: v=2.4 cv=G9gs1dk5 c=1 sm=1 tr=0 ts=69ef5dec cx=c_pps
 a=vNb6YmZAMQ9o5yQhuWb2Pw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=hPTxVbfT2LzzYvtpCZgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: UgBXHvLb_mRAkIxEB_KXcQasGWIG1PQm
X-Proofpoint-ORIG-GUID: UgBXHvLb_mRAkIxEB_KXcQasGWIG1PQm
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

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDExOjAxICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOg0K
PiBTaWduZWQtb2ZmLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZpeGVkIHR5cG8gaW4gdjIgdXBkYXRlIG9m
IGNvbW1pdCBkZXNjcmlwdGlvbi4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjYwNDI0LWZ0cmFjZV9maXgtdjItMC01MDE0NmZmNTI2ZDVAaW1ndGVjLmNvbQ0K
PiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBGaXhlZCB0aGUgbmFtZSBvZiBtb2R1bGUgcGFyYW0g
aW4gY29tbWl0IGRlc2NyaXB0aW9uIGZvciAybmQgcGF0Y2guDQo+IC0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDQxNy1mdHJhY2VfZml4LXYxLTAtOWZlZmUxOTQ1
OTJhQGltZ3RlYy5jb20NCj4gDQo+IC0tLQ0KPiBCcmFqZXNoIEd1cHRhICgyKToNCj4gICAgICAg
ZHJtL2ltYWdpbmF0aW9uOiBGaXggc2VnZmF1bHQgd2hlbiB1cGRhdGluZyBmdHJhY2UgbWFzaw0K
PiAgICAgICBkcm0vaW1hZ2luYXRpb246IFJlc3RyaWN0IGluaXRfZndfdHJhY2VfbWFzayBtb2R1
bGUgcGFyYW0gdG8gcmVhZCBvbmx5DQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9md190cmFjZS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDNiY2UzZmRkMWZmMmJh
MjQyZjc2YWI2NjY1OWZmZjI3MjA3Mjk5ZjENCj4gY2hhbmdlLWlkOiAyMDI2MDQxNy1mdHJhY2Vf
Zml4LTVkZTQ3ZDI0NDhjMA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpGb3IgdGhlIHdob2xlIHNl
cmllLA0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMu
Y29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQo=
