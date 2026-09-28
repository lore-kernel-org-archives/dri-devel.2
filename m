Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DE3C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC7E10E864;
	Mon, 28 Sep 2026 09:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="gicoLuWH";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="mec1kHPm";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715E510E864;
 Mon, 28 Sep 2026 09:10:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S7xjvY1984093; Mon, 28 Sep 2026 10:10:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=/3SdHLkCYDhU/XMC66ePPBAjyCfmR1ofVeXchcPBPZ8=; b=gic
 oLuWHmCSSgrgcAzzneG6ViFPHDYo5EYXS2QEvX6HVWZ6pbU41LEy5vtzNKWsoW5r
 EvGlg9U2ba8PGtn+56uGQoko5oeKv2Pdv1QfeYtFelppGet6bd57zpGX6GflL7Au
 pJS3jVYjRigNlAcP16lJMQo2poVhAI9/TPVt8T75s3076Q616dte9OmMc2bijxuk
 KjCyNcj1KrKn1UyIVb7HRZTqWe5IDnmmpUyZTzfMr/4qu5KiolH1GRoj6qPlyBVu
 Y6pO7ECU//ujCuFX/1OeofctSNH7fNPpqkufLkXlwG5T/S9AlyebtOBh+KkUOtmf
 RIR0MgnnYIetHti+4Pw==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gx64t1j1e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 10:10:07 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWBD3s8svj5d/2ZmajPzqAvPxF5g35OI8oonv8VWZcx2oqNO8DJe6EgV4a/qZ9cyHDcaqD9/4GkD1hBIrBZFTHXwEbHaKvB+rVxluFLLB4MeK0k1hnIlQszfFyRZ99G1ZDBuEFyo9qNaZ3UfP6bh59uPcQXBVzuSA+h5o7/rV3bCplgFZJ/mh+My30WfIAhWDE9+ZTyhpymxDBhiYN0E3vUnK1qgGdKUW9g3+HSF87YWa0xfT3EAQh932Fg0gKlLHcbIvtXveLVHNL//qwrG2/9VRPENOk5Czir0ESzVmrz+Q7le2Q+YFaZ82O0idWYmWcdQvWeuuN2nj/QEJw/OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3SdHLkCYDhU/XMC66ePPBAjyCfmR1ofVeXchcPBPZ8=;
 b=nwQ4HK1/H/RqFTjXKyOUyw0rxDYSMKZFPKFTVl5RoeROQeE3nKLSm3atEeN8yM2O9bvHUXsZd9gGJWPCfgvbz1qMzfLEnwz4AHuxIjLiAWKatudxWjPdBacEedvBkrjzA0ORJYDJXHQCiPyZoeryrbJjrSb9PXeCgDjy8SgWmNsTCMNZIl+5RyXPq/4hFDTCB0JtTxNWA7lKA3W6Y+Q+zDWfo4+kjdNkUyu2aMWfxGbJHgKuqar0vPKPBlM5cH3iXm8dCNm719LfBBASwTBaedNOjnKqvSErlKoDNT6f20/OvUmBhuggZ7n+SKEeipLkTNemMEl3szFLUPjiOn7Z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3SdHLkCYDhU/XMC66ePPBAjyCfmR1ofVeXchcPBPZ8=;
 b=mec1kHPm4+PDYV4JdA99sa2PNzkBHi1/C9sz6m6f4HoqPlY0XonjCLpetg0nqZ28E+U1ZMSg68CBqit9qmBqJ6Daa00uUZIHCuiuBKbWhZk0ApUfLVskbr+sISPPBxSERRF7W5Jb76Zl/5hDptF+YV/31B/KR2+jZdO4AZno00k=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CW1P265MB7733.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:10:02 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:10:02 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "gye976@gmail.com" <gye976@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/imagination: Fix reference and vm_bo handling in
 remap()
Thread-Topic: [PATCH 1/3] drm/imagination: Fix reference and vm_bo handling in
 remap()
Thread-Index: AQHdTxguSEm/k0mowEGh15neEdFguLbjtBeA
Date: Mon, 28 Sep 2026 09:10:02 +0000
Message-ID: <8c182c4d6e9679a464cb29336c4000515e456ace.camel@imgtec.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-1-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-1-7f5b18ab989a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CW1P265MB7733:EE_
x-ms-office365-filtering-correlation-id: bee968dc-9ee4-4398-33a9-08df1d4047b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: spoadkVv92DHTzN2JPkYKflov43igFvQNOYjTpOGIQxTtNwJILr5WJQw2ud0wB/ALrBLSCBeU/cYaFSLpB2RNRDlYPMEVNwL3wVUcYiwV48fO0ETa2LlUztpeH6Kxceb9D11/nclnsjTNqwYnT6ABnbx0R2YunDQCciC8tkYfvPvK1isYB0OCZJTKv+iDpN6+NJI/vQDZ57ae1Pl+CLv4MROnYwrb7MRa6J83dlc8PuXJ8sXqMetFaEf+upgKVjVzb6d+VO5+To6KaVmgs4+1ZwJMroadl/NlgvF97EUBpL1Bi/Y5a2FX6ZfJl3to3LIQKmEE8q4nMg7t3XDroqz+1SFjesMu8p5emKCGp0hqZO73up7Bb5OA80Kv5j36wQbo9zzi1rwv8Sjzmm+dzS0ivGBan/vXLBY7f57HRzX4sSy3CDZj+z5HlPRShxMnihmCC+cYLpzgXvW1GieiHpfNpkN0X/9tOcYq+0hT85YhsnMbh9J80bz9hyyEGKEBbDVEPJooqWgzdjDzq5sSTaRLvK531DkvxsGTz5y4grP1D87Of7kl3qSsGpaU0Z1MVfko7jBeSREzQG3GA28bxN2pivtnBtjSQ1Ney7XM+Q/Lr36S4oVzUz0BM5UqiK2G7xk4yeX/XyJzT9Ga4xHtAp9QldEDXZWvvWvQhm597jtbKIZvDUR914MMQ1kFqyo0ejeqerL2YQwxr/4oh4b7I6RbGGc5wi+2eOP7vDBNMCxQbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm5ISnU4SHVkM3AwVklNNnJQWWRuV0E5QXo3NmlWZ3hKYXFYV0l3TXB3c2J2?=
 =?utf-8?B?dUxpNzdndmNvaElpYWUvOUszamxRV3Y0UGRFLzBaUzZCdTBlLzFad1VtQ2ZR?=
 =?utf-8?B?RHYyd1lwZG5ZWVJPVGxkU25qU3BQaTNCZFpnTzlRMDhuRnM4alVBZGFZbDA1?=
 =?utf-8?B?aW1wL3hHT0xrZkozSHBrZW5aQTFJSFM5U2ZTQm41WTFQaVIwM1ZaczhuMmJP?=
 =?utf-8?B?bVlNOVVMMzU1SGlkc3dReW5vcStuUzMwQUtJRFhmUWJWdXNPaUllYUw5bldy?=
 =?utf-8?B?bVB1ek1jVzdJMUZZMlRhVDJtdktyb1lLUXZjYm04VG9YTmoyaVVGZU9NdGVU?=
 =?utf-8?B?S0ZKYzd6b0V2L2xrNHI5dFU3ZHRRR1IrSjF1VzFzclNKUG40T01mSEtKMkVo?=
 =?utf-8?B?Y3ZPbEZ5alhDbDlLOHA2enc1d1hMMDdzQUR5blJHbzlDL284K3R3akxNdm1J?=
 =?utf-8?B?OURJblpTd2FrRWdCY0YwdngwbkQyeXkwYU1NTlhoZ0ErR2NSajRIbDN0SjhM?=
 =?utf-8?B?SmFTWjNyQjNRMDN4RkdRNlFhMmhoYlpxdWRaWkhxZVE5SmhlNVFuZ2ZsWWVY?=
 =?utf-8?B?aVpCU1dkc2RNeHdqVy8xVlo5WlhveVMvczR2UForVkpqeldYYWJrdUVRNTJE?=
 =?utf-8?B?SXA3dENGT2VGU2taVXdMSnpodVNMdVNXS1RsWVp0OXFSRFZkenBmTjJMT20x?=
 =?utf-8?B?TU9IeUtJWG1jZlFyaWZyQm5JZnlnR0FyYUFKN0l1Y1E1amlqdklUdVlielZl?=
 =?utf-8?B?d0NFcmgrUE0rWGZJM1hnU1hDd0ZWOFJpc0hxMTRpTHdLclg4cmhEUVM0RHpH?=
 =?utf-8?B?eVFnYzkvd2ZXVzJpZ2s2ZEg4Tjd2b2pwWXFVWmE5YnNKell1d3d5Uk5GYmxw?=
 =?utf-8?B?WS9BTmxxeFBROVNmRnhMNlFaZGJSWGVRT1FqeVA5TXFwMHJ2NTYrbHV1Qm0y?=
 =?utf-8?B?aHRyT0ZOVFBqYVQzNm80dm5jZTBpczA1RUlRcGpqb0NvRlFvOFZjaFcyRTc2?=
 =?utf-8?B?S1lJTW4rNGZjL2VkelZrMWk3RXNxWnpYRGtwSnIrR2p1OUJKUngxL0xpWnRR?=
 =?utf-8?B?bEJGUVlVQ1M2b1RFSnNkS0FDTlk5d2FtWVhtWnNkQTFhTUxoMCtoSEZwR1Fi?=
 =?utf-8?B?bEhmY0xoZDFvYWYzQjJwNjdJaEs5YnBYWklUaWdIdmppam56eCs0T1c5WWJ3?=
 =?utf-8?B?cUpFUmNzWVdLa25xbVNUV3ljd2hEVlU5aW9OU3MvSlRyYUVRd0JnRnBSNXUz?=
 =?utf-8?B?UHZ0TDVieVpJLzBvQlo3QW4zeHRndEwrbzF4VExwRUM4UjNWVkErOXV0Z0dL?=
 =?utf-8?B?dnowVlo5eHY1V2p0QVQyNmtNV1VqMTdSa2RUZnVrWFJWTW00dExoZHBQN0Fm?=
 =?utf-8?B?SHZ6bzNXU2pCSlhWTVJDMWRLWmYrYnZZbWx0KzlFNUtzVEFrN2ZQRTdWTVdB?=
 =?utf-8?B?MUdhT3BHbm9wMVJETC9KNStCdldnRTFHMWtGMmh6MVVFMEdnY1FqMDZBdGpC?=
 =?utf-8?B?alRFL1ZDVi80dVZTQk1GcUhRdFhZeWhtdDBDMlR6RmhWSkxmWHgwWjYzMy9U?=
 =?utf-8?B?a3dnZ3BKT1lYU0g5SE85M0Q3UXBiZGJzNzFuYytOUXdnWVZLKzgrbFlPZ1h0?=
 =?utf-8?B?bEE4R01HWVFGRGZ0Q2JVM3VIY28yaWhWNUpEa3N4LzNXaVlielZGWE12MjZN?=
 =?utf-8?B?S21ydGQ1WmxEQnlUUzZFK0FBZTF1THcxMGFmekRMUFlRL2RPK20zY3NuQm5N?=
 =?utf-8?B?RGNNaURML3BIZTBoeE1lNEd0cWpSbDJPcXQxQmFYQU44UktIMDJEMnNuWk1z?=
 =?utf-8?B?eHVmTUpua2FUd0Y1Rlg2czdoWTFNdEZteG5DaHV5Tk5qelJzTFRvRlZVR0Yr?=
 =?utf-8?B?Nm1pWk5iZHBsMGlBamtCU1NCNG5UQitISG0zQk12TVhnekd0MjdCczB4dFo3?=
 =?utf-8?B?bTlzYzFIUU9GS1l1UzdZOG1yOUdyMnVaSzFkWjJUOTAzVTRPQW5DN2FnYkZa?=
 =?utf-8?B?d1BPZzRDN1lWNEVqTkVLdUwvOXcrVTdRRktoQ1RoQ3BtSVJNdm1iZ2JXcHR4?=
 =?utf-8?B?ZEdnczhZMHA3cW5yM2lOTjNhaEZUUyszMVhZVkhLTVJVWE1IbldKYm1XbW94?=
 =?utf-8?B?SUN2azMwOWloVSsvcXJMWnpMT1BpNTFieUhDYUFheXY4WlhDVWVaSVczT2xm?=
 =?utf-8?B?eHpRVHQ5ZW5RN3VZNXVTcHcwa2lHMkllUkRzb0pUS3R5RTJNdlJpNWt2ZC82?=
 =?utf-8?B?ZHk1bFMxN3Z5bDVacUdsdGxDMXJ6eWVrTWIxTHpKRGxmUHlyTWtISGZNbHVS?=
 =?utf-8?B?MUlCYXMydDl3MmpRdXdpNmRNVG9TQ2N0NkYzckpJTDNhMk1VTVh5c1NDTkxq?=
 =?utf-8?Q?FEXVCONUplhjBZt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14AD0CE0966CC749A2EF36C226B6B598@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: paNs0TaoV+WeMbjt21seJMNj/lcAtFH3AifJ+MLYfO0MNU3g9+npAjEJ8NDr6TPHo+KtVJNYYdIUM5pnqDM8aBkEC9jpbhMswb+13c6B0zoc1F/OTqI71BVn9d4jyCxV1IIieS6rSKNQVgPRHrtYSdIHSwlghG0Y3aasI9I83MjR5G1UuOL1tw/b+hMvIgl2rQSMDlrE5BAjHMrKVqhiyZXOjJg6nTeIL5I/D+OC5KN6MSqrv5ETkFit5GiWUF8GsHEBOBn+9yInx2BiSL0WkL/tT1VPdWIQk0gtV2zZt8zQr6KVzrMUcPMRy04xBjx1TPseTGeIUxlL9O/uPC6VDA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bee968dc-9ee4-4398-33a9-08df1d4047b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:10:02.7423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIKREZ+KYJ55Y4hwAJJpnKB+0IVWc/b1NuXzwJ3lYvD+lbBPiWjeveVJxYwjdi5eg6nqsBRYNXdNnYVYa5ua/x28dMtsCjnOosund+zCdR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7733
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfX48/CfDJBktOE
 TC5IOYY3CWiksAUTyXpCuBfwQYy8quIZrM2p8y5c57qLJ78v+p2nuyNrOdcRNyEiWR1uN4G+pFP
 5FH0UOAMzuOxzYWggYM98g6ou56Cuq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfX6F9nZI7B3mn3
 pvwJNJ/JWo+jM6jBpYndDdowj6RN7bXBmdblaxxj855IujkdtY9vUpNcnZM6GYQUarfKGtZDVy6
 0wsREmtYkGkrasMj24O9CdWqebKU1LaU0wC+3RMBrXjtVcdhGJb0u8v1zWWCaWce1NKG9Njy/kt
 TH7h6Aixl8tIXr9aF3HMiQggQgy6U2btxnUwUw3Dh4NHCGiFFB/idsem+0TKiCGff6vd64K1axm
 vjLCtmdrQaHKxUvoDNd+p0UPQO3Xbi8KaXE1qft/Ky6fZ7aAqgB5TN58GoW/kXHuc6xGdD3bl6D
 FWOxB10efo7XytT2vKtWBRSGu5FaZcxj4VtsslpXSG+si0pq6jnrkevIR33O4ER5eG8XcL5caYC
 e/q/aR/Q76Y6oNH+6lUT4JkE2hTnsWdhiVYU/pHUSPfyKesNbw8+ZSGbcrNCT3L2TauNSsnsbs+
 XWpQo11/jIBtuwPQqNg==
X-Proofpoint-GUID: jrlWIfJ1whaspFKgUOdvvzd-dmyErKtk
X-Proofpoint-ORIG-GUID: jrlWIfJ1whaspFKgUOdvvzd-dmyErKtk
X-Authority-Analysis: v=2.4 cv=OasNnRTY c=1 sm=1 tr=0 ts=6aba2eef cx=c_pps
 a=vLRwiXW9df4xC8AjbIh2Jg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=pGLkceISAAAA:8
 a=r_1tXGB3AAAA:8 a=-DtPhjmn28urkdB7XTIA:9 a=QEXdDO2ut3YA:10
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

T24gU3VuLCAyMDI2LTA5LTI3IGF0IDE3OjI1ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
SGkgR3lleW91bmcsDQo+IFdoZW4gYSBtYXAgb3ZlcmxhcHMgcGFydCBvZiBhbiBleGlzdGluZyBt
YXBwaW5nLCBwdnJfdm1fZ3B1dmFfcmVtYXAoKQ0KPiBzcGxpdHMgdGhlIG1hcHBpbmcgaW50byBw
cmV2L25leHQgcGFydHMgY292ZXJpbmcgd2hhdCB0aGUgcmVxdWVzdCBkaWQNCj4gbm90IHRha2Us
IGluc3RlYWQgb2YgY3JlYXRpbmcgc29tZXRoaW5nIG5ldy4gSXQgZ2V0cyB0d28gdGhpbmdzIHdy
b25nLg0KPiANCj4gLSBBIEdFTSByZWZlcmVuY2UgaXMgdGFrZW4gZm9yIGVhY2ggcGFydCBidXQg
aXQncyBuZXZlciBuZWVkZWQgYW5kIG5ldmVyDQo+ICAgZHJvcHBlZCwgc28gaXQgbGVha3Mgb25l
IHJlZmVyZW5jZSBwZXIgc3BsaXQgKHJlbWFwLW5leHQtaW4tMm0gaW4NCj4gICB0ZXN0cy9pbWFn
aW5hdGlvbi9wdnJfdm1fbWFwLmMpOg0KPiANCj4gICAgIENSSVRJQ0FMOiAzMzU1ODUyOCBieXRl
cyBvZiBzaG1lbSBzdGlsbCBoZWxkIGFmdGVyIGNsb3NlDQo+IA0KPiAtIFRoZSBwYXJ0cyBzdGls
bCBiZWxvbmcgdG8gdGhlIG9yaWdpbmFsIG9iamVjdCBiZWluZyBzcGxpdCwgYnV0DQo+ICAgcHZy
X3ZtX2dwdXZhX3JlbWFwKCkgbGlua3MgdGhlbSB0byBjdHgtPmdwdXZtX2JvLCB0aGUgbmV3IG9i
amVjdCdzDQo+ICAgdm1fYm86DQo+IA0KPiAgICAgcHJldl92YSAtLW9iai0tPiBCT19BICAgICAg
ICAgIEJPX0IgPC0tb2JqLS0gdm1fYm8gKGN0eC0+Z3B1dm1fYm8pDQo+ICAgICAgICAgICAgIFxf
X19fX19fX19fX2xpbmtfX19fX19fX19fXy8gIChtaXNtYXRjaDogQk9fQSAhPSBCT19CKQ0KPiAN
Cj4gICBkcm1fZ3B1dmFfbGluaygpIGNhdGNoZXMgdGhlIG1pc21hdGNoOg0KPiANCj4gICAgIFdB
Uk5JTkc6IGRyaXZlcnMvZ3B1L2RybS9kcm1fZ3B1dm0uYzoyMTA4IGF0IGRybV9ncHV2YV9saW5r
KzB4MmVjLzB4MzEwDQo+ICAgICAgIGRybV9XQVJOX09OKG9iaiAhPSB2bV9iby0+b2JqKQ0KPiAg
ICAgQ2FsbCB0cmFjZToNCj4gICAgICBkcm1fZ3B1dmFfbGluaw0KPiAgICAgIHB2cl92bV9ncHV2
YV9yZW1hcA0KPiAgICAgIF9fZHJtX2dwdXZtX3NtX21hcA0KPiAgICAgIHB2cl92bV9tYXANCj4g
ICAgICBwdnJfaW9jdGxfdm1fbWFwDQo+IA0KPiAgIExpbmsgdGhlbSB0byBvcC0+cmVtYXAudW5t
YXAtPnZhLT52bV9ibyBpbnN0ZWFkLg0KPiANCj4gVGhlIGxvY2tpbmcgb2YgdGhlIEdQVVZBIGxp
c3RzIG9mIHRoZSBvdGhlciBvYmplY3RzIHRvdWNoZWQgYnkgYSBzcGxpdCBpcw0KPiBub3QgYWRk
cmVzc2VkIGhlcmU7IGl0IGlzIGhhbmRsZWQgYnkgc3dpdGNoaW5nIHRoZSBHUFVWTSB0byBpbW1l
ZGlhdGUNCj4gbW9kZS4NCj4gDQo+IEZpeGVzOiBmZjVmNjQzZGUwYmYgKCJkcm0vaW1hZ2luYXRp
b246IEFkZCBHRU0gYW5kIFZNIHJlbGF0ZWQgY29kZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEd5ZXlv
dW5nIEJhZWsgPGd5ZTk3NkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRh
IDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkJyYWplc2gNCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMgfCA4ICsrKystLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYw0KPiBpbmRleCBjZWI3ODY5NGNkOS4uYzVhZTBi
NzlmZTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0u
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gQEAgLTQx
OCw2ICs0MTgsOCBAQCBwdnJfdm1fZ3B1dmFfdW5tYXAoc3RydWN0IGRybV9ncHV2YV9vcCAqb3As
IHZvaWQgKm9wX2N0eCkNCj4gIHN0YXRpYyBpbnQNCj4gIHB2cl92bV9ncHV2YV9yZW1hcChzdHJ1
Y3QgZHJtX2dwdXZhX29wICpvcCwgdm9pZCAqb3BfY3R4KQ0KPiAgew0KPiArCS8qIFRoZSBzcGxp
dCBwYXJ0cyBiZWxvbmcgdG8gdGhlIG9iamVjdCBvZiB0aGUgbWFwcGluZyBiZWluZyBzcGxpdC4g
Ki8NCj4gKwlzdHJ1Y3QgZHJtX2dwdXZtX2JvICp2bV9ibyA9IG9wLT5yZW1hcC51bm1hcC0+dmEt
PnZtX2JvOw0KPiAgCXN0cnVjdCBwdnJfdm1fYmluZF9vcCAqY3R4ID0gb3BfY3R4Ow0KPiAgCXU2
NCB2YV9zdGFydCA9IDAsIHZhX3JhbmdlID0gMDsNCj4gIAlpbnQgZXJyOw0KPiBAQCAtNDMzLDE0
ICs0MzUsMTIgQEAgcHZyX3ZtX2dwdXZhX3JlbWFwKHN0cnVjdCBkcm1fZ3B1dmFfb3AgKm9wLCB2
b2lkICpvcF9jdHgpDQo+ICAJZHJtX2dwdXZhX3JlbWFwKCZjdHgtPnByZXZfdmEtPmJhc2UsICZj
dHgtPm5leHRfdmEtPmJhc2UsICZvcC0+cmVtYXApOw0KPiAgDQo+ICAJaWYgKG9wLT5yZW1hcC5w
cmV2KSB7DQo+IC0JCXB2cl9nZW1fb2JqZWN0X2dldChnZW1fdG9fcHZyX2dlbShjdHgtPnByZXZf
dmEtPmJhc2UuZ2VtLm9iaikpOw0KPiAtCQlkcm1fZ3B1dmFfbGluaygmY3R4LT5wcmV2X3ZhLT5i
YXNlLCBjdHgtPmdwdXZtX2JvKTsNCj4gKwkJZHJtX2dwdXZhX2xpbmsoJmN0eC0+cHJldl92YS0+
YmFzZSwgdm1fYm8pOw0KPiAgCQljdHgtPnByZXZfdmEgPSBOVUxMOw0KPiAgCX0NCj4gIA0KPiAg
CWlmIChvcC0+cmVtYXAubmV4dCkgew0KPiAtCQlwdnJfZ2VtX29iamVjdF9nZXQoZ2VtX3RvX3B2
cl9nZW0oY3R4LT5uZXh0X3ZhLT5iYXNlLmdlbS5vYmopKTsNCj4gLQkJZHJtX2dwdXZhX2xpbmso
JmN0eC0+bmV4dF92YS0+YmFzZSwgY3R4LT5ncHV2bV9ibyk7DQo+ICsJCWRybV9ncHV2YV9saW5r
KCZjdHgtPm5leHRfdmEtPmJhc2UsIHZtX2JvKTsNCj4gIAkJY3R4LT5uZXh0X3ZhID0gTlVMTDsN
Cj4gIAl9DQo+ICANCj4gDQoNCg==
