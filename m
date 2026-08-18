Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25830C5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544C010ED21;
	Wed, 19 Aug 2026 06:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="QudSGv8f";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013086.outbound.protection.outlook.com
 [52.103.35.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6293210EA65
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkIAqNe9WTcBUrEBUGlWLhMmydpKfCK30t9JvuU8MCPDVApub2bLTRGUjAVjk6LJZXWOdewZiG9xgP4aJophu4YPO8AV2zqAlxxBzwEGFUf5OcJTD6z47tqXgKvn5sEpA0M/VWlzICfgoOhASFGpq2u6UY/jPQnbo4+RLGuZQIQ9W7frvl7Y1uFCPKzfFdJgUHs6kHvZrqGlWefqIfGdVLg8SVn0BfRngib2pVYFqFkWpGCR1k0UdDF47hIuyrW7/wqi1w0AFCgi3AD9aZIukGf1L/uiEpDogpj+d8V4nQeTAhzqYsUsDR8JOca6sR+iAcg8QSrakqa6MR1Oz5iIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E37irka3ASR0e0P6hO2AODC03Uu9R7rXSxtAsmGlTxI=;
 b=jv01gYTM+89YmJ4AFG1SaYeFis8mORDKyGKYddTPZmV1u95ibOYri0v3NTt6v5O6PeDznRJ9Jtvn50ojgQZLycodUau7fjOPzTvUmJt+HPakdadX05DsaTVnXox1KH/83HrmFntFGrkt8/MNySC2B32HVflb+Vw2ND9oBA88TSn22pbyJxMrs9qBmKoYERF43Np65WZWYlQm1zlV+ftxnDkoAOAJldWGN5MMC0c5968Gkrr8KuidPqWM0iHV7oLIAIn56rUcxue9tkBsIEWS63kA2QXi2tyCS4erLQd3TqkRFKnF62WfBYo46RRljNNgh5VX7QrcH2cVsNQuIiXVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E37irka3ASR0e0P6hO2AODC03Uu9R7rXSxtAsmGlTxI=;
 b=QudSGv8fs/Fgh/OBlACZqoSh/vlAy/WSnI+UfYY6TMMRmkjxZLWRziNgi1B/eYrSYkcBWdjyL2T0QTxwcbPqL9vpgEbcX6gK/9wCCo9MAyCsEDlb/RzB8GtZJ4XEowfXG2psxV+4g08yzXj++1MwjXmks/ui2IP2caefsi8OILG1Ght4q5ozpGknZoFzlTEouvGrNl5C94xy6ij9Ou3dZgrgH4vFJdeIIA7tj9Bft2+c5eNOe3Y/YeM7+09i3DDroMrFdw6UXRenYcd/x/voOSWZ9uxS/rwfDFJFdkdbs8YVsvFp+4EFFUkfEun7KsPA7hFjHItqMyHd45U0FEhULw==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 DB9P190MB1290.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Tue, 18 Aug 2026 09:04:33 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:04:18 +0000
From: Muhammed Subair <msubair@hotmail.com>
To: Maxime Ripard <mripard@kernel.org>, "'heiko@sntech.de'" <heiko@sntech.de>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, "'hjc@rock-chips.com'"
 <hjc@rock-chips.com>, Alexey Charkov <alchark@flipper.net>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Andy Yan <andy.yan@rock-chips.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "'royalnet026@gmail.com'"
 <royalnet026@gmail.com>
Subject: RE: RK3576: rockchip-pm-domain fw_devlink device-link failures 
Thread-Topic: RK3576: rockchip-pm-domain fw_devlink device-link failures 
Thread-Index: AQHdLvCMNWbWHsFh9EaBFwHuViS45g==
Date: Tue, 18 Aug 2026 09:04:18 +0000
Message-ID: <DU0P190MB24453BCF26CFB4E7B391F609BCA62@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
References: <33aa66b2-cd6d-416d-b1ef-20cc83e0ee10@hotmail.com>
 <DU0P190MB24456FE9DB02005BCDDEC336BCDA2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DU0P190MB24456FE9DB02005BCDDEC336BCDA2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB2445:EE_|DB9P190MB1290:EE_
x-ms-office365-filtering-correlation-id: db16e965-e848-4f94-2da2-08defd07af56
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799012|51005399006|24021099003|31061999003|55001999006|13091999003|8060799015|19110799012|8062599012|37011999003|25031999004|25010399006|40105399003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?utf-8?B?Y2xuR2RCTjRXODRyam8zNGtoNlpmSjh1dndJWUdMakhLV2s2TVZSMTBBbE1r?=
 =?utf-8?B?RnlVeGZzVERiclg4S2loL0FReENYQmdHclZrajQ0cTZmWTBvZnF3NFdYbmNR?=
 =?utf-8?B?ajlYd3AvQ1lEMGRHVUg4SnRtc25yRE1DTmpIM3VqZS9JRFFBbkVFTG9wS1B6?=
 =?utf-8?B?NG9HN2dmcGtFSjhQYmtjamptcVNLZDFtNFB1MlQ1MW9JVFVRNDBoZjRlTUI5?=
 =?utf-8?B?WG9NL2NWNEYzb2kzN0dVV0FmMTlqQmNyckRld0MwRURVTDdaVDA2WFM3RkRH?=
 =?utf-8?B?a2IwMWx0WGxkaU01TDg1andsS09ZNEdEcC9tUjRsS2R4TW1CNE5DVG5Vano1?=
 =?utf-8?B?TGZaK3c4TzJlY0RzL1Q0czc4MEE0UzhnZGVxeDVlTXBBSjVKK3gwK3FUZDk2?=
 =?utf-8?B?L0ErMXB1cjN4QzZrRGViTGZGN1l5aTBtaDl5YTUyaU5aTDdubDRTcHRVQ3E2?=
 =?utf-8?B?L2pqdkhEM3YreUNyTjBKZEhCcGZsdUVNSE82SzRWM2Ztck5sYVZqN1QyeXln?=
 =?utf-8?B?VFNja2hFaEVaWk40Nll6QWZ0ZXN1RWF0eGsrd1JOMUZGL0NqVmNBTG9ZL01V?=
 =?utf-8?B?ZHdMWlhIODRxczJyUXQ0N0tPa3JIYk9sRXoxTVNBTk9ER1RoU0RFY0tZaU0x?=
 =?utf-8?B?bUpnYlFoUm1VQ293cHhOUDJFbkZGL2xzVHZsRko2MWg0Ni9jMkFHZ0VpWjNO?=
 =?utf-8?B?dUZWZWpjbnZkWmVvd2pwY0UxbnJ2eEZ2bVJNOVRNaldWalU0SHZwSld5UzIx?=
 =?utf-8?B?alA3U0pvQkYzVWFCTEs5Z2xOaE1NZlVFdFV3NVJEQjVBcTdReEs3aTFMWXU5?=
 =?utf-8?B?UE5GbWRNbFh5SElDWDU2K3BQQVExcys5eUc5QWNLOXZ3Z01COVM2a3NvWVU4?=
 =?utf-8?B?am5qWlRIbnI2VUUzU3BxeDhmYWx0d052SDM0Vm1OK2lYOENkUUhUc1VMZHRr?=
 =?utf-8?B?WVZaVWxHVHJJQTFiTXNwdUpDZTRROVVwUVNlZ1NRcVdWclM3dHFtTnk1QTBP?=
 =?utf-8?B?Z0NiWGhuOHJ0RFE5ckMycHRvWjNhVTlNWEdHWXkyaTFTVHlmbzhsSGZERG5y?=
 =?utf-8?B?c2hEUmFsbFdkZEErd29mL3Bva1N1dmxxM1BRbXZlbzFpaGxSMG5TUUlPU3Vl?=
 =?utf-8?B?QnBTcFZmcHNYcFhyeWZrSmRPQkNINHBrcTBwcjV6dmk4NTNjZHA1dkdJeE41?=
 =?utf-8?B?SmgvaUdnVGc2T0UwdjU5Qnd1TFJCZ0tuU1c1WTd2ZC8yVGpUQ004ZFVvQ1hk?=
 =?utf-8?B?ZGZkeHg5djBFTlJoaU5lWmphQTBubjg4eitaK2JReDFwOHBqRlZoQll2Y3hz?=
 =?utf-8?B?Qmd2QjNzeWlJS2V0TzBhcDJ0QXozME5WNE1CUXZySDdOVVhBczBubi9NV3Ru?=
 =?utf-8?B?dnB4amhUVzBYQmJXMVhLN2hOZEcvaGFaanAvWnQ3UE9QNERCdkl2MFVwWHFp?=
 =?utf-8?Q?V/f3znYL?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umk3Qjk3VDJ5WWgvUnU2R2ZGSUhZY1BPSVV1Vi9iZVczKzd2Ri8xTCtsb2Q0?=
 =?utf-8?B?RXk1RERNbTZoSmhENWNoOFlvazIvcUVJNkZvVi9Ia2w3ckNlZ2xxRTY0Zmhy?=
 =?utf-8?B?emt1M2pLb0FUZng1bmQvV0FyTjJUaVIxVWFoQ3Z1NjBudXBHZVllWDBUelZW?=
 =?utf-8?B?N1gxNCswbFFjM0ZmTzA2QTZRRmRCQjFnNm1BUzhHaSt5NkNDL052UEtJNURi?=
 =?utf-8?B?Nmp6bEFGdVJnUnFqekhCSFlXdVcxUTdUdEg0Njh1ZTNKQ3pXRGRUQWN0WHFK?=
 =?utf-8?B?ZVZrWUN6cmZJR2t2RlBUVEt5TFBMbHNOblN6clo5ZzIvVFRyOUJZMlM1VVlM?=
 =?utf-8?B?MnN5WDRWekhoMUJPN2Y3KzhLd2prNXhuMXRBRlQ1Z3JXZWxsZm9YSEFyblEr?=
 =?utf-8?B?ZEVtc0xmZk1NV24rK2doQmhwNmFoUXZEc2t6U3JyR2pvVnVRdTQ4b1AxWVpR?=
 =?utf-8?B?SWhaVW1tNW41M2hTaEducG55eW5DM09nc2p6RkFRbVBKbDI4SXBGdDU0eFJZ?=
 =?utf-8?B?VlB5ZUNWMWZLdU1WT3VUU05LbmNMSXBUTGV6MG9pSzJraGUzQzgrTzNtdGJp?=
 =?utf-8?B?QkcwNnZrbHFOc1phNEkraTBOUk5YQ2t3ZUNudzIzaUlVWVZ4VHdFSHMxaCtw?=
 =?utf-8?B?SHpoc0tOUnJuUHVmUm9WSVVSU094dDRVaXErYXJRUVpvbkZRbXpmdmdWWmxu?=
 =?utf-8?B?Z0J1dCtkdWRsczRyaVpQdy9GeDVYbEIra0QyU2lrOS82bmZrbThRTjcvSnBk?=
 =?utf-8?B?V2I1TkpqMGtCUjA2UG9lV2tGbVF5aVNVSDVFT2RlMWF6aFE3VFdNT3UvWmpQ?=
 =?utf-8?B?bVNQcWZtSlJxV29tZEVVUGdsWjVmZzlIc1V3SUFaU3BPSkZmR1pCUEdTdEhv?=
 =?utf-8?B?R2hENkZLdXpqOEZBU1B1QjRhcFkxTThlcFdncklJc3V3aHErZ3FHTzNnRE9L?=
 =?utf-8?B?VDFPZURIaEZId0lvaDl5WUpxMmhUbjh5VHJIZFNIVzk4Z09xWXhZdlpPUGxr?=
 =?utf-8?B?YVBvTWxRNThkVHFtMm00L0NFZTltTDJnSFJrSnRLeFZPOFF0S3cyaUE2QnRq?=
 =?utf-8?B?NE1UdVgzdG8wWUFaMHhYZHQya1phcWsybU1LKzVTR3hKb1d6dldrbDROeENw?=
 =?utf-8?B?WmpYdUE5SXdxcFF4MHQvOWJYNkswRkEwMFM1Y0tUOGU0eWhLbkV2cUdGdFVh?=
 =?utf-8?B?Tmo4Tm5FbFl1c01OdFVLZHFEUEVTSEJmVkdmOWFWYm5LdGpHT0c3QUkxUzBW?=
 =?utf-8?B?eHNPYVBhT0czRU92ZjYvcWlNVmZhZ09FUDhFUjF4Ylp5dWNZR2VzYy9GK1dH?=
 =?utf-8?B?QUVBYmVOVnh5NTRGRDVSOUdHN25KMkd3c0RtMDNyZDBmdnZ6NHh2QlZVdXo2?=
 =?utf-8?B?Mkk4WUo4c3NvN3JCY3h3a2Y2ZGg4SXpsS0YrS3gyUDdHZkVyM05IbHczWDgw?=
 =?utf-8?B?TkV3dGp1WmFnQ1A2OHpZeElDdHZUNWkzNThSY0p0SGtkYWZQT2d0RmJJckpU?=
 =?utf-8?B?MnA5MmRkSUtHR0RaZjF6a2o3WXpHUkorbGpFNGtXd2ZRekVmYjkydzM1MTdN?=
 =?utf-8?B?N2tkajdHOC8wc1JuK3RVWWdhS016bDJqaWEwMytZRzhsUWRuSkJhR0dkY0li?=
 =?utf-8?B?anpSN3FqbzBsYWZsZjV0S2d0TlNPRWw4Zm5YdVNwWXlCOWo1Y1htRUpVdlJz?=
 =?utf-8?B?YXp6Vm1FaWdRdWlVUVpsSEMzVEluMFJZZzdsbGIzVkdSRWhDNGV3d2k4bzB6?=
 =?utf-8?B?cGI0NXA3WEFIZXZYaTBFZjNJL0d2eDdtbDdibDdKSEFjS1BnWHlFdHRJZG1z?=
 =?utf-8?Q?PXVQxTrGuDIx8+nrg+FH38YdAXLuk9nX8VCgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b33f1.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: db16e965-e848-4f94-2da2-08defd07af56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:04:18.0545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1290
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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
