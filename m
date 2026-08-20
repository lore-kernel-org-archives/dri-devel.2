Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE28C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CDB10EF53;
	Thu, 20 Aug 2026 08:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="BSgHbJTn";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazolkn19013085.outbound.protection.outlook.com
 [52.103.51.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE90010E127
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 02:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INVqw84u3/hq1gODx6hgemkGycLniHSVXi6IXFPVHJuX+EhGFsmese/js2g2CVb2liU98drZPQ1cNTqJ/38U3tCAc7rtsYAHT0mT6tgy2lIOFXaKxe9HWARb4TThSfLp0CiytyA3vBsZAlUQE02u4380uu9WBT6uvDYaaDMb1AOyaGjvIYDj+lLNRKJJwoppLKs6b8Ga8fKkDQtCi3lNiStBPmgoMs5+Q6XnAFVkQfACatjlxs8JyTbnvo4t78ki6u2pw/FYb0W2szw2jpFsqAAVxnOvDqOuf7AEqIEm+++PYNZfxkVYn0DQ3LV6SLuwPNHttXoziFgc+g2BZgAR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E37irka3ASR0e0P6hO2AODC03Uu9R7rXSxtAsmGlTxI=;
 b=n6gvfVdXb0BhaZqhcdGnyQ5Ft8eJo+JnPJBQ87q3I1HvWFanWIYnh1044rBaLSyQDGi3dzh4t0VuPzs7oRayrmGyuSDpNVL6ro+oYo9yuI+qyBDARBFsGdLOWs8jDmjgXjdRJeOuGGreur3YGOUQ/44/9u9aedI1rmTtTNgTr1f3rMRlCQCLCn3g92/S+DAiHKrwtUy6e8UXYnAluCn/PCCom79nXcGYpSz4R256DcxZokpos1AelHuY4ZH2ZQqjp+ch6xzTG7JPsYbdGv1qCbMm6Gj5liyF0pq//PO1sZkxcjSNArnzr5kbMVEldtCAY7L8bHqdCCj583vR7ybOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E37irka3ASR0e0P6hO2AODC03Uu9R7rXSxtAsmGlTxI=;
 b=BSgHbJTnj7WMfVxImEOQ/7mfP+IXIuN5fB9nxLwku6xuRrJcNVAIy4RffNFeWJld/cbq2stSDktvMnI8nAb9bsIux1VxZHsLZCJqDCKDjfGbNQgcIZjabizWk+R2ml7M+smRjoCqBddj0c3/7kLiiTTTMVz7NghUU7hurpFl6RPBzaf25zQwzwCdW0zwqYTiAkcJWQIwtXTGJAUzQYJCFdDIwrJZrJ6D2LVM9VTJP4V3cupdDFIHQy89wt+X1zNAvOOyCuBwOo3U+ISKnEgkccG97d7Dum4ONMyH8ukJdHpAcdK6x3l497MHL80wQycEg7XjQWbYz8uHw2sP2DKM2Q==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 02:37:41 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%3]) with mapi id 15.21.0315.016; Thu, 20 Aug 2026
 02:37:41 +0000
From: Muhammed Subair <msubair@hotmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RK3576: rockchip-pm-domain fw_devlink device-link failures 
Thread-Topic: RK3576: rockchip-pm-domain fw_devlink device-link failures 
Thread-Index: AQHdLvCMNWbWHsFh9EaBFwHuViS45ramOttw
Date: Thu, 20 Aug 2026 02:37:41 +0000
Message-ID: <DU0P190MB2445F437F9F99BA3FF2B467DBCA42@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
References: <33aa66b2-cd6d-416d-b1ef-20cc83e0ee10@hotmail.com>
 <DU0P190MB24456FE9DB02005BCDDEC336BCDA2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
 <DU0P190MB24453BCF26CFB4E7B391F609BCA62@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DU0P190MB24453BCF26CFB4E7B391F609BCA62@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB2445:EE_|AS8P190MB1063:EE_
x-ms-office365-filtering-correlation-id: f1df45b9-30ff-4be3-1c94-08defe6401f7
x-microsoft-antispam: BCL:0;
 ARA:14566002|55001999006|24021099003|19110799012|8062599012|31061999003|8060799015|15080799012|13091999003|25031999004|37011999003|51005399006|25010399006|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?utf-8?B?eCtxVVlEVWV4QmJGbk1yTXdrUWNsQzlyRzV5azFMS3R3czF1eW5kQjNxRUJz?=
 =?utf-8?B?ZWY5S1VPNVJ4KzdTY2lrTVJOZkJNS2V3eXZrR2k3SHEwSTgzc1phcEtyaEtt?=
 =?utf-8?B?Ry90bmowdUF6VlJOVVpLbFdNSUVrbzNFY2hNNzBYYUYzQUJSU3E5WlZSUzU4?=
 =?utf-8?B?WWxJcnhPMlZ5VmlDaTkxUmRlMGRvN3pNZ1htNlk4ZEpPUk5Gb1ZJaVBWN0pK?=
 =?utf-8?B?dEdvZkhaQ0lONktwNkdRTGZNM0JzZENTQzcrOHpzM050cEZkWHEzRE1XL0x0?=
 =?utf-8?B?eGlVZm1BK3VYUnJGTEJBNHNNd3g4dEpGN0xwNDVjSzlJWlcwN21ScHZMd3NB?=
 =?utf-8?B?SlFFc0k4WVNHeXVXOUh6NGozdmMvRWZwWko3K25xZUVhZXJad3hoNVp3akRE?=
 =?utf-8?B?ZWtnZjRjYUQ4WGhxS2lQNit2WlI1Z1lDNDBrWDR4UjhsWkVQbFV6UFA5em5K?=
 =?utf-8?B?c2VGVmkzZU1yb3A2dGc2TnlYMldwbTBFbi8xdXJvN2gxT2xwRjFCdGVuT2FG?=
 =?utf-8?B?aVIvNG1ZZjA1OENad1Jib09oQnhMZW10SmhicWtJWW5jRTVwQk1WRnB4N2ND?=
 =?utf-8?B?K2VTVWpSM2FrSFBnUlovYllMR09vMU8wUUV1aHh2YnpGUEFERUlwdzFlS0pL?=
 =?utf-8?B?L3M0a3BxY0lzMWRJNWhmQzhjbXNXK0JNVXpzWFlScldLOGsvTzRtN0J2MDFz?=
 =?utf-8?B?THgvM3orL0dWZWVMYVdJM2psSXh3dHNPZ3h4cCttTjU3dzFNdlpOeWhDL1Jr?=
 =?utf-8?B?b3R4OFA0ek42OHR1T3lVYXNUQ0U0Sm1MS1NXeVJ6SlNWWDY0VW5Vbkx1NUZP?=
 =?utf-8?B?bzkyTXJ3V3RqVnF2USthaG04WXBjMDBHZ0FRWXBsbm9rb2hxMTU1eW1la3lF?=
 =?utf-8?B?ZGxzNHFHd2swczBkVUFIdkNoQUZoWExDU21WbC9TYTNyVURZZUM3dzF5bUF2?=
 =?utf-8?B?UmFOYktTN1I1ZnBSc0FQWUdBNTBETkxQRGo5c2V0S2NEMU5LOFVGZ25xeXA0?=
 =?utf-8?B?eGt4MGJ3bngzVm1VdkZDa2lGdis1NnhLWjVIaHR6d1J3QWpBekhlSXpzd0pp?=
 =?utf-8?B?dUpFdUJRZURQY1Y5OEp1MUUrMGhXc0psWkZwc2FubDJ0cy8xK1J3VkpUYTgv?=
 =?utf-8?B?ZExoV3RNY3puTWlZSVcwYUo3a3ZVYkhORmM2aHBvb2RkLzdmZlh2Y2dscG1C?=
 =?utf-8?B?ZXdpak5kOXI4T3V0TlRUb2FKaWJVSGZHaGxDSzNDV2ViN0pYakUrZkQzUU9E?=
 =?utf-8?B?eEV5TWQvK0xQakFPNEVuRXhERnloT0NBU2JMUnAveVJCZEI0dUQ3dERJcncy?=
 =?utf-8?B?SkZsbmF1RFkwTmhaODZHdkZUcVY3MzdtQmtMMk1vaXZLcysycEZJcU1XMEVo?=
 =?utf-8?B?bTNjRVliSGgweDNyTWY3OEI1NjB1MWlaTTczU0h6ZWxZZWNZcEl4eG9TTnRy?=
 =?utf-8?Q?Oz32MUim?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnp3d1FMK09ORkp4ei9LbHVsaFJFNEorOXhWczR5eTZGeUpLbC82OFNqWlhk?=
 =?utf-8?B?OTNXMmRlQTJZSGpVUzdMRHdsSTlOUWxsaE5wSzlhQ0VJV2pFODdKbW9EbnR2?=
 =?utf-8?B?NVFUVUdnMG40Qk1HeDhqWk9LcjF4N3RsS2tXS0t5emFRdG1TVlB6d0l6REwv?=
 =?utf-8?B?bjhKanJjdzNXOEtrNDBtQmptZ3NMd3AxaDN3VDJuaXptQ1BYWDdqeGMwaVk1?=
 =?utf-8?B?aE1YODAyOGszM1RNWHVjL2ZDcUJJWGJETUNoNHJJaUlUQklnSGZ0dkgzc0lm?=
 =?utf-8?B?dHFRVEdrYVI1SEwvMW9CT2JrdUZoeU1TLzJkYmhyMC9rMHZScExMU3RpK0J6?=
 =?utf-8?B?NUJDQWRGa1owTkh3bFlFcTU3cGdQZmljeHhXMlJXbkVxdEl3TFkwR0RWcHdm?=
 =?utf-8?B?N082NVFFaVNHSk5XT3pYdXNJd0J5WWtYOHoyVklOQUl1SXNFYWN2eHJLT1R2?=
 =?utf-8?B?MnVuR1cvSENzbW4rSzZIU3BDelJCbmI5N3RmdUJ4RElwaE5mcUVZdkFqL1Nu?=
 =?utf-8?B?MVN4QnZVdnAyTDdhWHpxV3dXeDNJYWlhV3dJZ0VqVUpkdXlKNkl0L0E2Y0tt?=
 =?utf-8?B?MEs0ZDhPTzNKS1ZEdk52eGY1WWhaWkFMVG9ncGp3bmk1aTN6VUthSkVBdkJ6?=
 =?utf-8?B?Vm5rb2QwNkJTQ3VEaTRIZmpFL21zWGp4U04wWXFaSjRCR3lYSFVYKytBWTBI?=
 =?utf-8?B?bko5dVdNRlVkejR1ZnRwUEVHalNYbGV6TFYzd1czYlZLdXZIZGtzNS9qMnBr?=
 =?utf-8?B?c1R4K0JRNmRkUVArWUZDREFyL1pBTHBQSVhJZzhSYjIyMU1iYmpwQ3d1M1Mv?=
 =?utf-8?B?QlhFeEFHbzk4QnAydVM5SEx6OHdjN1VTaWZ4THoyTXBVeHpyUGlwa3NmdVQv?=
 =?utf-8?B?cFZYa2xsUVZybTFDWTcwY01RNlVzLzFrUVJ4Q1Rlcit0ZXhoL1BUZlUyT1Vj?=
 =?utf-8?B?VGU4d2NIaFJUUWh5RllwZi8wYnBadU5Jc2FGY2M0UlBpMWhhMVk4bzh4RDdi?=
 =?utf-8?B?RDBCaGpXU3p4UkFUeDZUYUVTVGNyZ3YzMWtyNktFUVJGc3lGME9mL1ZSNC9y?=
 =?utf-8?B?cmJCUnV3cDYxTnZJeEhXZjZaeHhiL2dJUzdhak1HK0xPS1FvTjhmNkI4aTl5?=
 =?utf-8?B?SUl1Y2h5QkgvL0JFSG5XcGI3Z3BOczVCRUxqOUQ3S0Vxd1lrNThJL3hvSkhT?=
 =?utf-8?B?bzJaNlUxN05UZjFLc1ZsaklrTWQzZ2hya1o3c2doWXJ2bDN5ckVNTWtqbUlo?=
 =?utf-8?B?K2NqREFsa3BkWEFiZi9DUzM5SWRMcStKc2sycHhKMXFiTmhVQTdJMXdMeHhH?=
 =?utf-8?B?ZVp6cWUwbWlnN3dMK3NtNFhSNnVMOStOQnR2c0lMNjlNTit3bWREai9uTGlB?=
 =?utf-8?B?VFRTTzlIMFZIZ1RZZjNTcFh4Nzh6OGVEK2k3VitCS0hiazNWeDBGUUtqQzVJ?=
 =?utf-8?B?SHJoU1VhK25iZ0xxbnJmYXdCUEk5QnZQbDJXb0pRSE1FQ2RYc25aekticUor?=
 =?utf-8?B?MW04QkJZTlBrS3gyNzhubVc4Z1JKenl2TUNLYUFFSmZPNXBTblJPazY1dThI?=
 =?utf-8?B?TTRJTkM2QURRYjBKekZZSEw5WlRWMzE4Q2hwOEpYdHdtT1l5STBYRFpIRSsw?=
 =?utf-8?B?YjA2eTJzQk8wZ25pdjNCd2RvMkhMT1NNZEwrMjJpdm5ZRjBpMlNsRFFjRTlQ?=
 =?utf-8?B?WmY2dnBlN0FzWU40cENlRDE5bVpjdURxcmxFeWpOV1ZrbktVUjkzTEVEbm92?=
 =?utf-8?B?YjhaS1dmS2FWNnpqV3Z2Zk9BekpFbFluSElmbjNxaVpwME1XVW9oM0pCbEJt?=
 =?utf-8?Q?VDpUXeAXXBV5cEq7SncBe7VUR+RQYqaCavwiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b33f1.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f1df45b9-30ff-4be3-1c94-08defe6401f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 02:37:41.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1063
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

DQpIaSBSb2NrY2hpcC9rZXJuZWwgZm9sa3MsIA0KDQpJIGFtIGJyaW5naW5nIHVwIGFuIFJLMzU3
NiBib2FyZCBvbiBhIDcuMS54IGJhc2VkIGtlcm5lbCBhbmQgSSBzZWUgdGhlIGZvbGxvd2luZyBl
YXJseSBib290IGVycm9ycyBmcm9tDQoNCmZ3X2RldmxpbmsvZGV2aWNlLWxpbmtzOiBbIDAuMjYw
Mzg4XSByb2NrY2hpcC1wbS1kb21haW4NCjI3MzgwMDAwLnBvd2VyLW1hbmFnZW1lbnQ6cG93ZXIt
Y29udHJvbGxlcjogRmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgbGluaw0KKDB4MTgwKSB3aXRoIHN1
cHBsaWVyIHNvYyBmb3INCi9zb2MvcG93ZXItbWFuYWdlbWVudEAyNzM4MDAwMC9wb3dlci1jb250
cm9sbGVyL3Bvd2VyLWRvbWFpbkAwL3Bvd2VyLWRvbWFpbkAxDQpbIDAuMjYyMTY4XSByb2NrY2hp
cC1wbS1kb21haW4NCjI3MzgwMDAwLnBvd2VyLW1hbmFnZW1lbnQ6cG93ZXItY29udHJvbGxlcjog
RmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgbGluaw0KKDB4MTgwKSB3aXRoIHN1cHBsaWVyIHNvYyBm
b3INCi9zb2MvcG93ZXItbWFuYWdlbWVudEAyNzM4MDAwMC9wb3dlci1jb250cm9sbGVyL3Bvd2Vy
LWRvbWFpbkAwL3Bvd2VyLWRvbWFpbkAxL3Bvd2VyLWRvbWFpbkAyDQouLi4gWyAwLjI4NTkyN10g
cm9ja2NoaXAtcG0tZG9tYWluDQoyNzM4MDAwMC5wb3dlci1tYW5hZ2VtZW50OnBvd2VyLWNvbnRy
b2xsZXI6IEZhaWxlZCB0byBjcmVhdGUgZGV2aWNlIGxpbmsNCigweDE4MCkgd2l0aCBzdXBwbGll
ciBzb2MgZm9yDQovc29jL3Bvd2VyLW1hbmFnZW1lbnRAMjczODAwMDAvcG93ZXItY29udHJvbGxl
ci9wb3dlci1kb21haW5AMTgvcG93ZXItZG9tYWluQDE3DQoNClRoZSBib2FyZCBvdGhlcndpc2Ug
Ym9vdHMgYW5kIHRoZSBhZmZlY3RlZCBkb21haW5zIGFwcGVhciBmdW5jdGlvbmFsLiANClBDSWUv
TlZNZSwgSERNSSwgRXRoZXJuZXQsIGV0Yy4gYXJlIHdvcmtpbmcuIFRoZSBSSzM1NzYgcG93ZXIt
Y29udHJvbGxlciBub2RlIGhhcyBuZXN0ZWQgcG93ZXItZG9tYWluIGNoaWxkcmVuLiANClRoZXNl
IGNoaWxkIGRvbWFpbiBub2RlcyBjb250YWluIHByb3BlcnRpZXMgc3VjaCBhcyBgY2xvY2tzYCBh
bmQgYHBtX3Fvc2AsIHNpbWlsYXIgdG8gUkszNTg4L1JLMzU2OCwgYW5kIGAjcG93ZXItZG9tYWlu
LWNlbGxzYCBpcyBwcmVzZW50IGFzIHJlcXVpcmVkIGJ5IGByb2NrY2hpcCxwb3dlci1jb250cm9s
bGVyLnlhbWxgLiANCk15IGN1cnJlbnQgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBSb2NrY2hp
cCBQTSBkb21haW4gZHJpdmVyIGNvbnN1bWVzIHRoZXNlIGNoaWxkIG5vZGVzIGludGVybmFsbHkg
YW5kIHJlZ2lzdGVycyB0aGUgcHJvdmlkZXIgZnJvbSB0aGUgdG9wLWxldmVsIGBwb3dlci1jb250
cm9sbGVyYCB2aWEgYG9mX2dlbnBkX2FkZF9wcm92aWRlcl9vbmVjZWxsKClgLg0KSG93ZXZlciwg
ZndfZGV2bGluayByZWN1cnNlcyBpbnRvIHRoZSBjaGlsZCBmd25vZGVzIGFuZCB0cmllcyB0byBj
cmVhdGUgcHJveHkgc3VwcGxpZXIgbGlua3MgZm9yIGRlcGVuZGVuY2llcyBzdWNoIGFzIGBjbG9j
a3NgLiANClNpbmNlIHRoZSBjaGlsZCBwb3dlci1kb21haW4gbm9kZXMgYXJlIG5vdCBub3JtYWwg
ZGV2aWNlcywgdGhpcyBlbmRzIHVwIGFzIGZhaWxlZCBsaW5rcyBmcm9tIGByb2NrY2hpcC1wbS1k
b21haW5gIHRvIHN1cHBsaWVyIGBzb2NgLiANCklzIHRoaXMgZXhwZWN0ZWQgbm9pc2UgZm9yIG5l
c3RlZCBSb2NrY2hpcCBwb3dlci1kb21haW4gbm9kZXMsIG9yIGlzIFJLMzU3NiBtaXNzaW5nIGEg
RFQvZHJpdmVyIGFubm90YXRpb24gdG8gcHJldmVudCBmd19kZXZsaW5rIGZyb20gdHJ5aW5nIHRv
IGNyZWF0ZSBkZXZpY2UgbGlua3MgZm9yIHRoZXNlIGludGVybmFsIGNoaWxkIG5vZGVzPyANCkkg
Y29tcGFyZWQgd2l0aCBSSzM1ODgvUkszNTY4IGFuZCBkaWQgbm90IGZpbmQgYW4gb2J2aW91cyBt
aXNzaW5nIHByb3BlcnR5IGluIFJLMzU3Ni4gSSBhbHNvIGRvIG5vdCB3YW50IHRvIHVzZSBgZndf
ZGV2bGluaz1vZmZgLCBzaW5jZSB0aGF0IGhpZGVzIHRoZSBpc3N1ZSBnbG9iYWxseS4gQ291bGQg
eW91IGFkdmlzZSB3aGV0aGVyIHRoZSByaWdodCBmaXggc2hvdWxkIGJlOiANCg0KMS4gYSBEVCBj
aGFuZ2UgZm9yIFJLMzU3NiBwb3dlci1kb21haW4gbm9kZXMsIA0KMi4gYSBSb2NrY2hpcCBQTS1k
b21haW4gZHJpdmVyIGNoYW5nZSB0byBtYXJrIGNoaWxkIGZ3bm9kZXMgYXMgaW50ZXJuYWwvbm90
IGRldmljZXMgZm9yIGZ3X2RldmxpbmssIG9yIA0KMy4gYW4gT0YvZndfZGV2bGluayBjaGFuZ2Ug
dG8gYXZvaWQgY3JlYXRpbmcgcHJveHkgbGlua3MgZnJvbSBnZW5lcmljIHBvd2VyLWRvbWFpbiBj
aGlsZCBub2Rlcz8gDQoNCg0KVGhhbmtzLCANCg0KU3ViYWlyDQoNCg==
