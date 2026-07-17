Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55F1C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F70D10F4DA;
	Fri, 17 Jul 2026 10:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="vTjUKF5E";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="fde0SMf1";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B2010E42C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:14:49 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H7A2hL2952494; Fri, 17 Jul 2026 11:14:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=LDft2DWe+I272JyDQ14Cp+IdMNJ/WuZVw2zDgSQVkbg=; b=vTj
 UKF5Evrpg3RpWCQNgswcOo6isY02zxkyaRiY3ika3V/auQR/6L/6LPwTYDy4Z0al
 zNjPR/0upXtZK8vv8v7uXE4egMRojqnRoQQC3jHn/RvZkI9q/w4eycAj7w/1UvwT
 jM1v7RV81tSzq5ltrNOZax2ZsKNMOHKlLF3CxoCA4BJMFeAUO5xj15Tb26DWec7u
 1vDiXdixKI0DPsunqWHBBJkM+j4+6CWCYeOjeGZsTT6+0/McSMLk0yk+FvrXx9CF
 XOUWZq2hwb7vcg9pdFD5Hae1frpZGtagOuI2WBDSonhB0sHiDQYD2HAyoor1ZyH+
 +XTRa2YiOQ+ZdusgnLg==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fbcp7d0vg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 11:14:30 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUmK39clsxGJDKalx2Tz4I03yWlqiX/7JlOVheJkB2dcWtLAPchqWL953dGwr/5c7IC7oW7e0jspqbQBWftJ5nXgosNYB/CFBNmikQuBBjqkmVyO4Yp6MPlT5K31mBxEk9rgezNsmmowWhy/7Hul1a4mrtvqwMZFdYF59j9sgY5mKcuMqk/hSAA23pCQer8gwpE3JlQC21A36pS17JyNFBnkuSsGJ6Eo4ysTbAVMd3e7IsNK5pQolrcAglHdZtQrg77jvS9AM8U+BlVqpysiNubARowGaEOiXwOLy1bh8HglnmenWvmMj3AVmokMYvYtJwOFlP77APJiDekIRjvo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDft2DWe+I272JyDQ14Cp+IdMNJ/WuZVw2zDgSQVkbg=;
 b=vZxLJ9t3A7PDJQ3vk0TAHkavLP0itBB4gmZve4q32nA28pAVig+hlmIquW15HBmxwCVDAkMd3y9qxyoQ4gcDC19bCPUc/UZhQrNT81cHcC0o8tyPW5RCFx93bCjidA4UXNmd/sLDrO1db9WG+1brkrCzdI2tjunUfPbtfTWPSfvwZb0rhb7Cx4goh7faEqtpxSeuadz9g1rqL/gPqhiSZE5zPuJduzcF6KM0Q1bO2X5VUtbM1BR+5lOZrCIGVF7Ic+OATWo4y57JVg6mn/w9hBZk9XSthuHosMJofZ5cgc0qbE5gA3cavLJ/c/FYIY7A5Cu1gK0krhzBa9HXvqgB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDft2DWe+I272JyDQ14Cp+IdMNJ/WuZVw2zDgSQVkbg=;
 b=fde0SMf1CvWq3dI6qGGtkp3SDqmdPHu0boFHqr5xPoAtW+ineTPcTQbvRJhEMLTF0AeYsyULjqu+gHe47iF6wBMEJDol4PdFjtCxX5Lc4U7WY8E3I3Ls/kEJCAsxFAOzHNWWqhFdJUio9YdzAnpna9bJd1SiKFrG0Mb4fJarWnI=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO0P302MB0276.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:363::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 10:14:27 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 10:14:27 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "m.wilczynski@samsung.com" <m.wilczynski@samsung.com>
CC: "lkp@intel.com" <lkp@intel.com>, Luigi Santivetti
 <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Topic: [PATCH] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Index: AQHcc5XdDp+LRZnl9keW10SkYs/JY7ZywusA
Date: Fri, 17 Jul 2026 10:14:27 +0000
Message-ID: <09a1028b03d614ffedc49dee24eee51578fa0d96.camel@imgtec.com>
References: <CGME20251222225350eucas1p1fc7c096318a7780ac7bdca8f63dc7ca1@eucas1p1.samsung.com>
 <20251222-fix_imagination-v1-1-0ac80a2ff317@samsung.com>
In-Reply-To: <20251222-fix_imagination-v1-1-0ac80a2ff317@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO0P302MB0276:EE_
x-ms-office365-filtering-correlation-id: c4bb3eed-edf6-4f89-a0a0-08dee3ec2f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: oMrV3zYxZGVxcBIltW+PPFQ1WwMLxVRbLfLjDKsvYP1BVmP0ta/TdwAtrSeAkDi04g3yGFRw3eiQ4Oz+5ovs14McyqeO59F+A99OHrKNIT+qDr4RgZTOqOuNddGP8eVVSK7yomcdH/g+sZe3rhgw0t2NaasW5t8U80GRqIjenOe3Mf9wrqf1OZdEBOqwAGmt3Wit2iJ4dGoOg0yONbjLjrqpqNkNg7mXJlDNc40W9AqaR/MlBhsP1qYn8LiiLHEzP4+tey9VJHB8CLaBmo4B92a7saFxwcNnY/MR1qxQ3p5AwF/Sn23m4Of3owSRB3M+ZepMaDXnG2+2zHxBndRxjh5QzxGSIQCrPsbOJ0GwITVBLAGkWLT7XF6Ci/ZZeseoDPtFXVXZbiyRMFqizi+gsWnOn00z4NNof3U68/tjsRKE0BQ4+G1dh/6/yWCyWxFN47Q/6USjbgf1R7ltEIHOgBoCfo/p05uBx/O+/bwtHXnAalsNYQXZnpJvkfilF2I62rFDpQikmMyrvdeD5B42aqDZNUaCu+06LMnYUtxoco3jCLc9jvVjqzl6RyxtVxTzEfevDF/dVsM5apIeHo4oOuKIEbJe7Cng+vM6At4hV0NFEDde4m+miCtODGcm9TrhbcPpT+EMRhxWhbLmta5m9tPgTsekCAGTzSK8GoxGYHSh/wefYBhMpSysM2kfVeWVtctcIVewGbADDDIvA0zgVcZdaveCuZMg37t9WrFPxcQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJZbWhONy9yaEppd0pKT0J5cTdZZmU5K3diL29vN1duUkkzdGV6TnN0NWpV?=
 =?utf-8?B?TlIvTlk3QVR3QU82NlpncUR0cWJTRG9rMDJMektScVI3OVhReWpXbEpVbmhj?=
 =?utf-8?B?M3JrZ2V5UmZ5QjRZZm9LOFpaaG1GVXh0N2c0OXNSQ3FPUmJHVmFkcHJsTHRt?=
 =?utf-8?B?UnhYbXJQeDhtYVN6c2FpQm1XdlFQemR2VGxKOUpDRWZVajc3RndOUDV6dEJX?=
 =?utf-8?B?U2RaUHFCMTVGMHhCZHJlRlFPaVdKUEtQajcrdnBrRnQxQkM4UGNzMVZ2ODFs?=
 =?utf-8?B?SHU4VEwxNHVHTFc2MTlwMkNYMUNXeklWL1VPV0hOUlBkbVZQMXhOZkVXT3cz?=
 =?utf-8?B?KzhDUUtOd0NLL0Y5d1ljNXhUTWJodE1QTHR6dWxhYVFDbThqdlNkZG1vaGdP?=
 =?utf-8?B?aXI2WSsvdDA1TTkyV3c4dTMreEp5RmdjMFpiOFl3YXNweTZSTWxwZHpva1RQ?=
 =?utf-8?B?emxNNG5zL1BiV1lzME5nLzYyejJhWWt6WDcwVHNXMFY2dkFCV2JGU0ZWRElk?=
 =?utf-8?B?QkcvcC9WaERXdjZjVVBTb3ZXSzR6dFVlWjJkVkttNzA4Q3hyd3pVbm5BYU5H?=
 =?utf-8?B?U3oxSDAzazVGL3VINGFqME5RcERKamtNcU5Gb25qczFvaVhBTUNMVTN6ZlEv?=
 =?utf-8?B?bFhLSnErY00xdTlEVTJxQ05JWmpiVzBGbDVhU29CeUVTZ0FoUTBDS0IwcEI3?=
 =?utf-8?B?a1hGSWZVUEE1azRSMlYwdmtwNEE5UUN2bDBnSUFqdk5xNFFMWENoMjU4cFc1?=
 =?utf-8?B?UVpqNllBcXRzUHd1VXp5QytmTkNmSFl0bFFPYy8yZkpqbG1tb3NhL0NmSGQw?=
 =?utf-8?B?c2JvVTF0N1hmRk9KcTdlRGNSOUJDVm5GNjJ4RHpaMi9vdy9wUFhkMDVYd3ZM?=
 =?utf-8?B?cUhjc2hqZG9VR2s1ZUJZbkdORzB0VjdWTWlGUWtSVHpidTRPR3IrUW82RWVE?=
 =?utf-8?B?MGM0QUxDZ1U2RzhyS1dFYVBwTGs5WFV0SG9jSUlXZ2I2Y21PSWg1am1EY0E0?=
 =?utf-8?B?YnhsQVkyRTBrNVJBeTdQL1pZaWpjbC9meDF2Qk1RNjdyWlNIaXN2NjZ6Y1h4?=
 =?utf-8?B?THNkTjFVYzJKLzRxZ1VaOE16cVU0bTQ4MnNPcVNYQ0l2ODFVK085aGpsMkFX?=
 =?utf-8?B?Yk9IOUVMZi9yemdwbmJqc2M0OHkxVkhJemc1bWV3WUIrYjRqcUZiWTZaMzI2?=
 =?utf-8?B?RXVKS2tUdittWmUyNzBFem1ZRm5rQmtrVFFFajFESzE4eFlsYlR3Zmk0S0VE?=
 =?utf-8?B?ZWViekhCNjl0T2tHNVcvRUtsTWI2ZE9zSEptQXY3SFp4OVp6TjJaUUR4OHJF?=
 =?utf-8?B?Y0Y4MWg1YzY0SFppTUw1LzVqZ1BXRnFCRzJsUzUvN1NtL1ZBLzFuQ0lpcnY5?=
 =?utf-8?B?ZkNGSE8rejdkS0I1K3Q5NU5sZVlVV3hCcWIrWlI4VkhHV1FJTjhBZDNDZGFL?=
 =?utf-8?B?STRnQ29kSTh6S2FFNlc5dGVuazRqanduOS84amM0VkJ0QjRwUHp5WXFUWU1a?=
 =?utf-8?B?WktzOFlFWmNwUVl4bkFuZjMxNkFuNURxSEtVaHJMS1RvUEh5RndZUVN0Q3ZX?=
 =?utf-8?B?SkU2cjNxZDRZUlFseHBiYUo4S0RRRlBBd2VXNVZTSVZBczhkOVljd21KcU5s?=
 =?utf-8?B?a2YzTjhmUG1iR2Y3ZW1UNTQvMnVVQ2VENXA5cWFESkt3TFFhOStBdTU5bXZt?=
 =?utf-8?B?QVdTZ3oxWVdTeDl0SzFtZnVMN0hXRDM3blAxRE1vcVVNclBFNVRuVGFUL1A5?=
 =?utf-8?B?VFN6QlhyM3FUT0dpT093ZXNNb28vMUdmRmU4NDdTRFR4OTFVdlUzeElxUXdh?=
 =?utf-8?B?Z1gxbDNsRDNLUFNGREttSXBLRHEvS20rdzFLZ1dNRzc3bUVXejlWZGIwRU83?=
 =?utf-8?B?eFRDU0I2SUtzUmNvVFVZQlNhb1hvUUJOZ1RQNnN0YlJrTnNIQ21BR2VWSjVy?=
 =?utf-8?B?UDFtek1UWTNPN1NMU041aGRqaEIzRHcxdUJRdEhScVNXQTNnWG45a3NXV1ZD?=
 =?utf-8?B?VENvQ3A3Y01WVXY4MFdzNGZSMUp4L3cvbTFFZGFHOWYxcXV6T2lEZE1ISUxs?=
 =?utf-8?B?VzJZODFWbVdhMFNWUU9ZYkdJZVcrbnJSZENmTEJ5N2UxckZuTnN4MVZyRzdu?=
 =?utf-8?B?ZC9vUEJJN0h3ZWJhMWJxb2l2ZW9NVWRmMmtpM2VnM3VSS0p5VWJEaGc3aVUw?=
 =?utf-8?B?eFlsU211RWtmMU1YVlcrMVphQ2h4SWRaSFNiUmRZQVZ0TmR1RFVYVFk5MjUx?=
 =?utf-8?B?Ym9HQXBmSVRkclRQSlErbzdGSUxCWVRDWnFocGdqUkdITkpFQkVab3ZTeVlF?=
 =?utf-8?B?QTR0QTFoVzZydGhpdFRoYW9oY2FCdVBFczkzenloZDdEcUE1d2YvMm9SZjBG?=
 =?utf-8?Q?+iebroNzyagqCTrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF54EBBE893F0A46A5A96F1892C65956@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W86uUn5jgAqAPWPU3NoIs4HPJBoNe7GJNBWZjTqQKfOXKbH9w+hP/9IWe29RZjQAwQOv7WmbTdAWWDKuHaTUC9NDm/B3p0Tw9mnTT23AMdCdqEl+y4HXcF7sf7veBEU6RsttJNhdxffu5IKkOtzGO31/J4dOUsQkC+GX5efJSwMX72XuQmmvGGYLJD5UqodO8PuTqhJqemCCsdrnmfAd+6+Z9F+b1zkFaLAUUhFlkf0YPeOy2ToQoMX/mbeXx9faaoM4tXzBb0aABr3x+lQB3I9BvJU7b1tnOltolN76WfHhudZA5g9gj76cgD7efvM/d1++I0nMN5LWnJOjWA4VVg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bb3eed-edf6-4f89-a0a0-08dee3ec2f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 10:14:27.4052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqNeUUuZW38E3fVEeIR7XMlRmCQojWreR1q7eUB3nyWks7ckV9JWV2IAVWttxy73wdbeJ4cCZxC63SRZsAlLN+/MXPFk0XglkdwxW1u6U90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P302MB0276
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX3eanW2GudV0P
 RJQj5ZEhgclv5Frf+q44VSFkS5OQkLAtB2Y0jxQcyW8QABzQmLhaiHnAvuH4stPUtzzLDjWt5ug
 LvUvhyx8agv4sdMut/BwfZ66OddMBXE=
X-Proofpoint-GUID: FHcEQK5VF7Jy_JiQS-Oi0JmQvujg_x4B
X-Proofpoint-ORIG-GUID: FHcEQK5VF7Jy_JiQS-Oi0JmQvujg_x4B
X-Authority-Analysis: v=2.4 cv=AYOB2XXG c=1 sm=1 tr=0 ts=6a5a0086 cx=c_pps
 a=Ql1bHtzprU8OF1hxyzuoxw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=Us2G9mFh6sP1UL_tPTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX/qhDhWTdYRSQ
 ylpfuar6Kh8iKbjHseo7nJhKz8okXXEXYNnet2W5nxDmdHnUPsz9BjFxTgdADL2M6VAq4j2hPT/
 FxgdfXAoCDacfFtjVis7vEbyewYrRHFu2EpoMhf62N8lWLsyMyzsOXquP7u5omLYtqF+ruGjo2q
 qM7fQVJ56IRnV73sdUJaivlx7x5XUaHP66D8Lj08yvmWmaL0/tdBYkdv4o20bqEUPBeUeKcuxV3
 biZ/JGl841TrJ+VWczhbmx0QLuxP326ovokYbFJd0Gk0zKAYFw03YLAcZCW/AN34EFgLN/5ZmaW
 k1j1L03nZo7v8rjEtZw378E48ulBp4X//zH9PVPlpBHPMWdYtGcQd8OrFQFTDTMWTmPoPgnYPIV
 58CnT4g9dt+4pBLy3Xtw9Fe2rY3hnC1OyX8mIv1MSjvhX1o9cYunhbWGYrNzc9iHfXeO4WRmDRc
 fqeSysNCJZQtb6Q7Zpg==
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

SGkgTWljaGFsLA0KDQpJdCBzZWVtcyB0aGlzIHBhdGNoIHdhcyByZXZpZXdlZCBidXQgbmV2ZXIg
YXBwbGllZCwgbm90IHN1cmUgd2h5Lg0KQW55d2F5LCBub3RlIGJlbG93Lg0KDQpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI2MDYxNDEyMDEuU1E5Y1J4TjAtbGtw
QGludGVsLmNvbS8NCg0KT24gTW9uLCAyMDI1LTEyLTIyIGF0IDIzOjUzICswMTAwLCBNaWNoYWwg
V2lsY3p5bnNraSB3cm90ZToNCj4gVGhlIGJ1aWxkIGZhaWxzIG9uIFJJU0MtViB1c2luZyBHQ0Mg
YmVjYXVzZSBgU0laRV9DSEVDSyhzdHJ1Y3QNCj4gcm9ndWVfZndpZl9od3J0ZGF0YSwgMzg0KWAg
ZXhwZWN0cyAzODQgYnl0ZXMsIGJ1dCB0aGUgY29tcGlsZXIgZ2VuZXJhdGVzDQo+IGEgMzM2LWJ5
dGUgc3RydWN0dXJlLg0KPiANCj4gVGhpcyBpcyBkdWUgdG8gYW4gYWxpZ25tZW50IGNvbmZsaWN0
OiB0aGUgaW5uZXIgbWVtYmVyIGBjbGVhbnVwX3N0YXRlYA0KPiByZXF1aXJlcyA2NC1ieXRlIGFs
aWdubWVudCwgYnV0IHRoZSBvdXRlciBzdHJ1Y3QgaXMgZXhwbGljaXRseSBtYXJrZWQNCj4gYF9f
YWxpZ25lZCg4KWAuDQo+IA0KPiBXaGlsZSBHQ0Mgb24gQVJNNjQgaW1wbGljaXRseSBwYWRzIHRo
ZSBzaXplIHRvIGEgbXVsdGlwbGUgb2YgNjQsIEdDQyBvbg0KPiBSSVNDLVYgc3RyaWN0bHkgcmVz
cGVjdHMgdGhlIDgtYnl0ZSBvdXRlciBhbGlnbm1lbnQsIHJlc3VsdGluZyBpbiBhIHNpemUNCj4g
bWlzbWF0Y2guDQoNCkkgY2FuJ3QgcmVwcm9kdWNlIHRoaXMgb24gYSByZWd1bGFyIGJ1aWxkLCBi
dXQgaXQgZG9lcyBzaG93IHVwIG9uIHNwYXJzZSBidWlsZHMNCmZvciBlaXRoZXIgQVJNNjQgKHJl
YXNvbiBJIGZvdW5kIHRoaXMgcGF0Y2gpIG9yIFJJU0MtViAoR0NDLCBidXQgdGhlIHRocmVhZCBm
cm9tDQp0aGUgQ2xvc2VzOiB0YWcgYmVsb3cgaGFzIGEgcmVjZW50IHdhcm5pbmcgZnJvbSBhIENs
YW5nIGJ1aWxkKS4NCg0KSWYgdGhpcyB3YXMgaW5kZWVkIGp1c3QgYSBzcGFyc2UgaXNzdWUsIGNv
dWxkIHlvdSB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRvDQpwb2ludCB0aGF0IG91dD8NCg0K
VGhhbmtzLA0KQWxlc3Npbw0KDQo+IA0KPiBGaXggdGhpcyBieSBhbGlnbmluZyB0aGUgZW50aXJl
IHN0cnVjdHVyZSB0byA2NCBieXRlcywgd2hpY2ggcmVzb2x2ZXMNCj4gdGhlIGNvbnRyYWRpY3Rp
b24gYW5kIGZvcmNlcyB0aGUgY29ycmVjdCAzODQgYnl0ZSBzaXplIG9uIGFsbA0KPiBhcmNoaXRl
Y3R1cmVzLg0KPiANCj4gRml4ZXM6IGEyNmYwNjdmZWFjMSAoImRybS9pbWFnaW5hdGlvbjogQWRk
IEZXSUYgaGVhZGVycyIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxs
LzIwMjUxMjEzMTg1MS4xV05YazNCQy1sa3BAaW50ZWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWwgV2lsY3p5bnNraSA8bS53aWxjenluc2tpQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfZndpZi5oIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9md2lmLmggYi9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2Z3aWYuaA0KPiBpbmRleCAxNzI4ODZi
ZTRjODIwYTMyYWUxYjA4ZDYyYmYwODE0MjUwZjJhOWJkLi4xYmEyYTE2N2EzOGIzMTkxMWUwODQ2
OTIzZTRkYzcwNjI2ZjVjYTY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX3JvZ3VlX2Z3aWYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX3JvZ3VlX2Z3aWYuaA0KPiBAQCAtMjE3MCw3ICsyMTcwLDcgQEAgc3RydWN0IHJvZ3Vl
X2Z3aWZfaHdydGRhdGEgew0KPiAgCWJvb2wgZ2VvbV9jYWNoZXNfbmVlZF96ZXJvaW5nIF9fYWxp
Z25lZCg0KTsNCj4gIA0KPiAgCXN0cnVjdCByb2d1ZV9md2lmX2NsZWFudXBfY3RsIGNsZWFudXBf
c3RhdGUgX19hbGlnbmVkKDY0KTsNCj4gLX0gX19hbGlnbmVkKDgpOw0KPiArfSBfX2FsaWduZWQo
NjQpOw0KPiAgDQo+ICAvKg0KPiAgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiANCj4gLS0tDQo+
IGJhc2UtY29tbWl0OiA4ZjBiNGNjZTQ0ODFmYjIyNjUzNjk3Y2NlZDhkMGQwNDAyN2NiMWU4DQo+
IGNoYW5nZS1pZDogMjAyNTEyMjItZml4X2ltYWdpbmF0aW9uLThlZjBjOTQxMjJjNA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KDQo=
