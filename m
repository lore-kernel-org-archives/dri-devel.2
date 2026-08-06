Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D845DC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E358210F12F;
	Thu,  6 Aug 2026 08:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="vw+cDJdA";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="PfWE/zrP";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D8110F112
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:10:33 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6764K2a93793545; Thu, 6 Aug 2026 09:10:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=0CGn4sdl2wDkx/T7g9C3PwI4OOvC84ALhEvi/J/q/UE=; b=vw+
 cDJdAbxMcW+C1+FzWIDWEkIdlSiQDHLTNcWD0C9j1Vn0LzeAKG2UL7TkGRuxmyJX
 FRsrEWwEbsOFUvfp8xAbp4C4ofabs/+bamGKPvO9JmpKzFA0eCLgFB8ODBz2N+pM
 PBk51m+t6qBCZz8hGGRlxU6hzSa3KDIUJRT05Qt5wSI8Bajs3tjO/zCJcBuPeV/p
 onbNLZKF/uXsZTcbMl7q70ACyQYs4vmDc1FhADeK1I0jTJvTDQV4Fsp1OaPMjW8L
 79sWi5Q8v+IGNk/skZs2j4lhooOHsppFL/EAIwFp6JzAQgsgLQeXWyxSv++cS6VW
 6qtqID1l0xCGSzjuCKQ==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fv7vygsvw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 09:10:19 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3lMnFW28j5nBtKfvnLtGFBSmRdii/w/WcZ0aECXdD+zNz6kbpnHZsZsi1o0eGy0cXsYCdeIovsbqxh2TcaQpun5YjQ1zXOpWoFgaROPZS8Ebw1tBdQnYgHp4SO5hd++EhfZgtvbqSN/liwuzFMbtEzePN38avaQCI/Keb8DCqX5MRLiDYE4IAz7SKeBtStbcSZhFPXP+TtyxwAgiDOhX9o85VM8Mq9NCGZsOUAYyIL7XfaYj0XEsY49jj6WICJTopLT4SRjxifPYZAkgZ8XUU6A2yStvJoodlMJsOqeHhs/9cYWrZVu25hK9qF+jhXmKcorfl+Fm9X5q5evu41cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CGn4sdl2wDkx/T7g9C3PwI4OOvC84ALhEvi/J/q/UE=;
 b=CDprpWYtc7PGcTx0ani2m07ziFkF7JaYNwpjIXcr1mfXVMhAmmZUcuokwimcKXDEAp2uGo4HbhjzhsNBMtvwCt7pId6r7Ir+q2LW6GwNGr4aHd8cl7U8vRrXDjdsAIqsrDLowAbJ4VohIuW7m+0Miz742IQcrVPokCZxVS+Ukak46bbyzxfTwl89vyb/wOUiacn2XNuzjD9pE97J+D9xcR5Ul2fr2hqHO7lxM4yOaa2xA2KwQXYnJpYDo6DoKbWXOVcO92gfuHtP5epdJxmrWJaa623FfAOraHQcSkXDpTKWuBiZR0oYG4y9nunFMnW+KjPSOJUuOTOoOSjp1ax66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CGn4sdl2wDkx/T7g9C3PwI4OOvC84ALhEvi/J/q/UE=;
 b=PfWE/zrPcR7Z5xdm9oKkIJBCCKbGKDvMeIMPD3gD6Z2dftw3NwljNoPpsCfXKI/bNvUVkw7U3Gqy4XllZk6cGvsLeVqsJRy39PNi2ws+kWO4DbleF1gsO3yir+mNdm5fHyHTSBeCpKjXZ4IthvYUCPDR+LyEkgn2XJbdVWLzcaQ=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LO6P265MB6782.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 08:10:15 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:10:12 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: Robert Mazur <Robert.Mazur@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2 3/3] drm/imagination: Fix repeated typo in KCCB
 documentation
Thread-Topic: [PATCH v2 3/3] drm/imagination: Fix repeated typo in KCCB
 documentation
Thread-Index: AQHdJCSSdc8N3cUYzEK+SD+upbA377aQrbYA
Date: Thu, 6 Aug 2026 08:10:12 +0000
Message-ID: <7cd9c7148f7111a6b1fcaf019a2e64e2ab09a2bc.camel@imgtec.com>
References: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
 <20260804-staging-pvr-docs-fixes-v2-3-a5a9569a1c1d@imgtec.com>
In-Reply-To: <20260804-staging-pvr-docs-fixes-v2-3-a5a9569a1c1d@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LO6P265MB6782:EE_
x-ms-office365-filtering-correlation-id: bab81f8c-4a7a-4e81-861a-08def39223b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: htfCBTDhTeKH0L5pcdasrKWCIL+/CePpvGcxofQ5kdCSHxTfjd8B1JL69nQnW3XTULuqRCKwhY+9JL/o2dX64MuYkSoYEsH0ALBQOe4xI/oKNvC/BUXIxg2iPbBJ90lLceR7fN+4bZFG4/EqoATSMHkEryO1UmjSlP1go2q+ukC1FUURZvJoKj8N7KfxPYEWpswbQQB1Sc0c+xDrcUQxeWhP8CkKL6h1v7bvA2rlrxM+3Pt2zV6BpWvHtQPS2DOePVnm5uiaN+na6AKUjO9qfKNn0as7iHkY69H6nguenzYhc2pSOberguOfu8P58DQCWZL4EINwghoyoxVC0XiGzTPbSWPF4LxkRBOr4CR4lAQlUKjJNdbqt5tjQcydkgUAsNUkW8WYI20glha13kQDTttbz0Hnr26Nn0m+LCLuHSYn/AipGFfNTFHBQFNs8w4Bf6xSBYlZLv9xD0n5dJpZkLpUe9Z3oEXUjBzPy/nyhy0socU1wkNxXQQdJkhf8xnklFqqypp/8CH9r1HKirMvRwWfWqTGEkqlx55YuE+5n7jGgDscsL/zD7NZXlyrVE38Ewg0K69dBvoWib2ur77N5jD1OhuD0Y/1+uvYUsPwEQh5w+7ohoaDeSIDCKFbmOSlkaMrzZXmS8IFlpJbcsSZyVQR8k8wyZQPX2qbTlGPblMeJasTl0jFyBM/Mp7uxs+F3mav1BOBr3K2gygLSOGlDzuCGvHHj4z01mLJnsp5xB8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZDejZyVUJMdG93UkxBRWhJZW85T01PSzNvNWsvaFRqc2drRmVqL3MrSG1m?=
 =?utf-8?B?YkthQ3R4dWxyaDlmeElaS3NiMzVicXVmc0RGaHkzWitZczdRM3FSRkkrWmxC?=
 =?utf-8?B?RkUvUUNoZXpjVC84azV5bW5Ndzh5MUEwZGdudU85SFhrbUh2NXp0dWE3YXVO?=
 =?utf-8?B?di9DMy9rdVBaWmpIRHBrTTVhZjVZVTE1aTZFTmw1eVlBYWs3bkNBQXlMeEdC?=
 =?utf-8?B?czJiSTZvNXJWWGZyeU91ZGVDVEFRWDVRbE5YYTJUUlc2QU1zZ2p5bWh4ZGRY?=
 =?utf-8?B?RFJiK3lGSHhFMHpyMjVHS2VaM0RkQ1FtWE11Um5XUmpJVEFmSy96d214SWVq?=
 =?utf-8?B?K3NDTk5yTkNHN1EzU0V5RmhKWW9nNEtzbWpDd0xUOFNjTld4aXl5Q0ZGcEdZ?=
 =?utf-8?B?T2s0RHlHQnBKUjA0b2FKNDhMQWNXOTNGQWd5OEpZa292UzFIQTJoQXNudWlR?=
 =?utf-8?B?eEdBMVFPOFJ1eWJUZkp0K3ZROTJMaWRLK0VZOE5nTU5aMGVxUVNueU0wbHRM?=
 =?utf-8?B?dGg2THMzOVZLclpFQjk4VWQrUEgwM1ZkSnQyWHNaNERHK28zTTRMOVJlUExJ?=
 =?utf-8?B?bDU3a0EzaXpySm1zVmIxTFBReGU3QTFRcDZucVZSOEd4SW5XVVUrVzc3Uzg3?=
 =?utf-8?B?b3hJdDg4bG9jTmZtRXVCTVBmcUdhdVA4MjJLajY1TkRyUjdlb3pwcFJXQ0Nm?=
 =?utf-8?B?UDVPSXZJdHBFcmxoUTB1QTlGZDloQzQ1TlJLVWVvbEE2MWZFcjMxZGxsMldC?=
 =?utf-8?B?OWJhZGVSL0hncnI1SDhhVDFRTTlTUWJpaXN6WW9hcmw5TGRqMnduY1VPVHNn?=
 =?utf-8?B?WmpsWWU3OXBCOWRaUmE1TDh5U2hVbjRUZEhPekFadnIyZks1YkJBTUs1M3pz?=
 =?utf-8?B?S2dRdVBTU3lrSlBmdXgyVmluVmxmVVlpaGxXWFVQL2VFd24zUVFEVktwaWR0?=
 =?utf-8?B?dlZaeXlnMHIrSlYwd2N3eU9ETkVwV0V3dmZqenNlWXJVVUI2b2EzeEhxOGJC?=
 =?utf-8?B?SnhhQ0tNdWpMS0lzQUdkdDltSC80R1hNbGJnQjViaWZ6SGNkUW9teGRjYVE2?=
 =?utf-8?B?RHBBWS9qbUJYSFZtOHcxQVZOYXY5M3E1QlhPampXb1lUV0FWR2MxV3Z6c3V4?=
 =?utf-8?B?KzdYLzBSL3hYZ3BHYklVZFZPM3VUQm9Qbnc0dDMwYXJKckh0OXFNb20yWEhO?=
 =?utf-8?B?MSthelozdmluVm0xS1VLcFdGUTFCSFIxNmJUNUhER21lbHF2R09DQ2FXV2g2?=
 =?utf-8?B?L1NWM2hLdE0vYmlTRCswN1BVcVp3UDVEMUI3MjV2U2JNbFAydkZXc05UZWNG?=
 =?utf-8?B?SitKL21xSWgrN3U4bnh1bGhQRVZwTGh5Y2VnN0UvN2ZTbW1BclR3YmNhM1dL?=
 =?utf-8?B?OTVocElsZUlXT1JMUGVVdU5DeGVaY0xMa01QSnlKR3FwWk1GSDNMQWg2RWx0?=
 =?utf-8?B?ZDJ5NERoeGFrbmNVMStnY0JxQ3Zic3N1ejFyZ0FadDBQd2U0aWk5TVJXLzlW?=
 =?utf-8?B?MWhKeWNGM1kraUt3ZCtLTjVmRGNMLzR3Q1ViTm40UHlwYkFyWHpwZFVuSWtP?=
 =?utf-8?B?VTAzZ2FxbzdaNGdacVFiMWVDY0xoV0tkSGl2emZ1YWg3UUIxemhlNzkzOFVW?=
 =?utf-8?B?K2FvN3pYZVo5WWFjeWZSTjEydGxOMlEvR1o2dHFhR25JeU5WUlZBNk9OalZv?=
 =?utf-8?B?UUtQdER4MVRnTFFwc0F1Vmd1TXVreGh6eE1JR09iZ09lSTZYbzJNb1BpNHlC?=
 =?utf-8?B?eTlHVk1DZ1U5cWVERnUrcnRlbXFBTm5idHJWZHVhdFQzTlR2QmEzZTViTkRM?=
 =?utf-8?B?b0pQdlVOaUV0ek1ZTlBwYTZyVjAyOVBTd056ZUtuRDFDdEllNzRNOXdpQzZT?=
 =?utf-8?B?ZWpvK0RmVm5jWVhDSnJJbWxuTWY4OTZQV0VFekl2MUdhbC9RN3pQdkwrNWRu?=
 =?utf-8?B?N29MV29veVNxZWlEOHV0dDdneWdQMW1renJXWFk2aTJoUjNLcjhPcFFMVHlq?=
 =?utf-8?B?WDh2b2M2MzBQc2Y4RHJmNW5zL0VFQlVobitmbkpEcHA3am1DZGsyWU1BTklm?=
 =?utf-8?B?UGlGWkhmV0p2UzNoNGdTS1gwdFZYVXNnc0M5NkF5aFlxSXNqSnppR2FFWjND?=
 =?utf-8?B?eG1BaTZ4MzVaNnhScHo3TnpVdnByTTd3Vm92S1BRODFzRnowSUpDWndVa3Rt?=
 =?utf-8?B?WXlyM082b0ZiNEhkcVVUWGZRM2JuNjNyZDJ5WnRhTkpBeFl4NnJaR24yUUZL?=
 =?utf-8?B?eFh1VUlsZFJCdUlxTTZPNmV2SG9kZnZ3T00xcTdQZDZ4dDBLTzB0RU1acjd3?=
 =?utf-8?B?Z3czMzMvckcvd0lVWXNOc3I2eHZWTWltK2xTamZNc2Z0RTlEWklITzBwSmY4?=
 =?utf-8?Q?YHGftRl7NeBJ+WIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5BF12C7165DE344AA875D495E891E57@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gVZWdVKLVWdTqDenX/JODK9vok5BvL+Fzf95W0Z0pAQto1ZxqhpDJjTP+N9DeolR23uJ0YsYaN2zqrkbzi++GA7sLMmSgoY+aGoYx2Jtwdvp4uTLmEVHDI5CTvK2pYbTbN+F6zhpO7VIGOJ6te3FKCrVv5ONTiQRE1YS7iRpPPyLrXnECGDpk8Tm7cB/RgOCgoE1Gr8DxnVEvpBAr5v8tNrdShHpuYJ/cVNtaspVJsS6IvO1TnOzh6XxzljPIIzDs+bKpRemMygAaMfMBfZlZU4QSm7LV7mvZdsKr9NWbWtPunjbjSTjE00OyVxTX7BlmlC4/Xc+XwtsgXx/fGvplQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bab81f8c-4a7a-4e81-861a-08def39223b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 08:10:12.2556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: db1izHiYUqLGYBY6HNlJ9Gegr0T8PCtoNATXrwC7oE3Tm3qzG572YZbfdoxbJC8THVw8N0GhgvK06QyJTSJp1Pqd0FyxAT9bzyuBqaCa8Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6782
X-Proofpoint-GUID: y7Vy7W49JXKadUjiuB9Kir_srLYoHmzl
X-Proofpoint-ORIG-GUID: y7Vy7W49JXKadUjiuB9Kir_srLYoHmzl
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a74416b cx=c_pps
 a=LmPWV5H2tvJnRZSP1rVgxg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=oQiPBGkC6IMlHw-3YQsA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2MiBTYWx0ZWRfX6n6LnyAaTMgH
 VmYiZ3it+rModOfMmiG0xjuaECt9vZFV6wRWmvI+jGYVpt/yXYIUmyg3eC4Wq9VimndirZH4QCv
 aFUTNxf8cyvCUekNC4FiGgoKRnFbnNz0Qn2msf+yqwHCOrdOxFLgKB7TSrJlM85TvNbXkM8iQpM
 7KmBGh5Oja9ZumTJAD9Dq+C231DcEqhE6tVWk4EqIY8crLqTbuNqBpzMGc7U1HQ1XI5lPBXfuRz
 l2F6goklqR4ztp/a7SIg+VpCfmtwpoK2KggZeIVRAEI/NnM4sQtYuYrSIjqlvldaQYdXwg39mQy
 bj9pUqr7XHWorKmtZPe0te/FdWG93vrPXbAWn49KKnyh0DObIuDjtvyi22GhvavvqsWqpXLyOqp
 w7NsqEhx/MEC96hAN6mI4j13e9+kIKUK6/W+g4Yy02xj+jqShNdCFUd7vDQhlCqqdfNp5Pyrqfg
 5Si6bPP3Cd0uRP71NZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2MiBTYWx0ZWRfX5mAoCMsIa9V6
 lPYnox+vmcd8ygdylpxYuMyv5qjHfO9yx1QWELKlQbbT9K7Jugva8ZuYWOrL170xDh+dWNXS7Oq
 iv77BEXOL9OMBBBhhYUPfepkWBPTheA=
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

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDE2OjE4ICswMTAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiAqKiogTk9URTogVGhpcyBpcyBhbiBpbnRlcm5hbCBlbWFpbCBmcm9tIEltYWdpbmF0aW9u
IFRlY2hub2xvZ2llcyAqKioNCj4gDQo+IA0KPiANCj4gDQo+IEZyb206IEFsZXNzaW8gQmVsbGUg
PGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gDQo+IEZpeCBzZW50IC0+IHNlbmQgaW4gdGhl
IGRvY3VtZW50YXRpb24gZm9yIGFsbCB2YXJpYW50cyBvZg0KPiBwdnJfa2NjYl9zZW5kX2NtZCoo
KS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1n
dGVjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2
ZXR0aUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRy
dS5kYWR1QGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkFsZXhhbmRydSBEYWR1DQoNCj4gLS0tDQo+
IMKgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jY2IuYyB8IDYgKysrLS0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2NjYi5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jY2IuYw0KPiBpbmRleCA0YWNjZjE4ZTIzNDEu
LmI3MDJkMTIyZDc5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9jY2IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2NjYi5j
DQo+IEBAIC0yNTUsNyArMjU1LDcgQEAgcHZyX2tjY2JfdXNlZF9zbG90X2NvdW50X2xvY2tlZChz
dHJ1Y3QgcHZyX2RldmljZQ0KPiAqcHZyX2RldikNCj4gwqAgKiBwdnJfa2NjYl9zZW5kX2NtZF9y
ZXNlcnZlZF9wb3dlcmVkKCkgLSBTZW5kIGNvbW1hbmQgdG8gdGhlIEtDQ0IsDQo+IHdpdGggdGhl
IFBNIHJlZg0KPiDCoCAqIGhlbGQgYW5kIGEgc2xvdCBwcmUtcmVzZXJ2ZWQNCj4gwqAgKiBAcHZy
X2RldjogRGV2aWNlIHBvaW50ZXIuDQo+IC0gKiBAY21kOiBDb21tYW5kIHRvIHNlbnQuDQo+ICsg
KiBAY21kOiBDb21tYW5kIHRvIHNlbmQuDQo+IMKgICogQGtjY2Jfc2xvdDogQWRkcmVzcyB0byBz
dG9yZSB0aGUgS0NDQiBzbG90IGZvciB0aGlzIGNvbW1hbmQuIE1heQ0KPiBiZSAlTlVMTC4NCj4g
wqAgKi8NCj4gwqB2b2lkDQo+IEBAIC0zNjEsNyArMzYxLDcgQEAgc3RhdGljIGludCBwdnJfa2Nj
Yl9yZXNlcnZlX3Nsb3Rfc3luYyhzdHJ1Y3QNCj4gcHZyX2RldmljZSAqcHZyX2RldikNCj4gwqAv
KioNCj4gwqAgKiBwdnJfa2NjYl9zZW5kX2NtZF9wb3dlcmVkKCkgLSBTZW5kIGNvbW1hbmQgdG8g
dGhlIEtDQ0IsIHdpdGggYSBQTQ0KPiByZWYgaGVsZA0KPiDCoCAqIEBwdnJfZGV2OiBEZXZpY2Ug
cG9pbnRlci4NCj4gLSAqIEBjbWQ6IENvbW1hbmQgdG8gc2VudC4NCj4gKyAqIEBjbWQ6IENvbW1h
bmQgdG8gc2VuZC4NCj4gwqAgKiBAa2NjYl9zbG90OiBBZGRyZXNzIHRvIHN0b3JlIHRoZSBLQ0NC
IHNsb3QgZm9yIHRoaXMgY29tbWFuZC4gTWF5DQo+IGJlICVOVUxMLg0KPiDCoCAqDQo+IMKgICog
UmV0dXJuczoNCj4gQEAgLTM4NSw3ICszODUsNyBAQCBwdnJfa2NjYl9zZW5kX2NtZF9wb3dlcmVk
KHN0cnVjdCBwdnJfZGV2aWNlDQo+ICpwdnJfZGV2LCBzdHJ1Y3Qgcm9ndWVfZndpZl9rY2NiX2Nt
ZA0KPiDCoC8qKg0KPiDCoCAqIHB2cl9rY2NiX3NlbmRfY21kKCkgLSBTZW5kIGNvbW1hbmQgdG8g
dGhlIEtDQ0INCj4gwqAgKiBAcHZyX2RldjogRGV2aWNlIHBvaW50ZXIuDQo+IC0gKiBAY21kOiBD
b21tYW5kIHRvIHNlbnQuDQo+ICsgKiBAY21kOiBDb21tYW5kIHRvIHNlbmQuDQo+IMKgICogQGtj
Y2Jfc2xvdDogQWRkcmVzcyB0byBzdG9yZSB0aGUgS0NDQiBzbG90IGZvciB0aGlzIGNvbW1hbmQu
IE1heQ0KPiBiZSAlTlVMTC4NCj4gwqAgKg0KPiDCoCAqIFJldHVybnM6DQo+IA0KPiAtLQ0KPiAy
LjQzLjANCj4gDQoNCg==
