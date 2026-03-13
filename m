Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB34106FD84
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABBC10EAEF;
	Fri, 13 Mar 2026 06:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="kZIaEJjL";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="JXQ6wQoo";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7872510EB08
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:37:30 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5S1BQ2080871; Fri, 13 Mar 2026 06:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=QvdWLBM4d/1OelZxNut+sylZDezWj/TihmE2sBydhOI=; b=kZI
 aEJjLdxNdkwa6OZsMDxQqldwmN0C3bzS6xChUIVMbCNHQKcuDPIc64YPT3+oL24Q
 8LjToc5Cc4RfeZAbXyCK+JFUOrtw9pFtGvuJGjB0VfjURmdjYWGMW0rPPRl36zJV
 u57zz/TW5ZdqvRS9sFUu97VcO0l70+takw+oUTO1ZqZbDcgMqThoB5BNDiD9axYE
 l5NPw06oJqK+VkfXZ6hPpTNIlXQ3KBmTci1zftt/qehUqsvRU4HeiBhrbatyelgs
 2fQVYXUQc0NHAdQEtW90Ah+awmv0cVd439ENsPwAkPGYeFWwLXALqgN2xy7xrFxz
 fuGJK6RJpuP1RnFYjdw==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022142.outbound.protection.outlook.com [52.101.96.142])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxvy20y1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:37:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgQUOmhCQ2qQRe7qGVn+PnkES2Dc+72ss8NnmH94MJnzFcboBH81oMhTvjHomkUpxW9Vh4RYccsY2wf2SfsOacNI4BlUDRhxPYUGfdDkZRKms52uBg4S8CYxrawYzc+8Dc4W0Zv2Of9PJOQdNjR3Ot3U9u9OSZ//O8protxVFfEgq7DmzEmOpGwM54azdaKEJEo50T5/Js/dBOzAR8sOBdK8688Ly2BpBx54Uj8+HPYpFCCrKyiEIThv2xxCgWkiZ9eMtQP/KpKRjxYn9zwK+NVCPPaK8LGY+sCZHq4sxXf6Umpcjwk78GCuNbPnlAC9ZF3VDFU6m1QKFOLcasdu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvdWLBM4d/1OelZxNut+sylZDezWj/TihmE2sBydhOI=;
 b=bbeKLIdsnAbdh7aA6DqlmvomB4z7SaCV6fD3Qu2390yLQSSoN8UH6l1jRKD4aR7myEufhjFyOuqSP+Q+lJqjM/Il8eOvvOzEC3vXFhgk7RILD86dhGGK7IfKUTiYMpRIiGujBMh4lUSLRosq70LS53HLWLLDavIzbFV4puQciEJLymRE6lgxcRTe2+gMoVdMRuzJr85ClT3mwIX9IkX/xaNwm86UCCZIAU7pB+fYwL/u5H3O7Mc+vIJtDHevmxINOXeu5sc9nij4E8n/HEHy6QWrWUqRq8h3Pxo7o+GpdlgI6HPei99eZ9Xs8gaYYc9CBc1W7tge+zfJr8WmU48Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvdWLBM4d/1OelZxNut+sylZDezWj/TihmE2sBydhOI=;
 b=JXQ6wQooxTNZaHU+Oi0DBYT9icGX/tsAkZp1TDSPkG8iom+WrARwIiF43CpyydW8F29g5g9G1hwIMwbKanrEEiTsCNq9iiSCU8PgiqZmGeTkOV22vvg+/eUqQeKEsz02yvkSvNkPY4U9jr0ib/8Pfbj1FwoUma6EM/iycpj/7Zg=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWLP265MB5551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 06:37:19 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 06:37:19 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/imagination: Improve firmware power off for
 layout_mars config
Thread-Topic: [PATCH 1/2] drm/imagination: Improve firmware power off for
 layout_mars config
Thread-Index: AQHcrJBAcayrkvLU9Eq11QRQd8zbhLWpPbyAgALQvIA=
Date: Fri, 13 Mar 2026 06:37:19 +0000
Message-ID: <bcac70b2b6e7f2ba605c97da3432b4ed47517331.camel@imgtec.com>
References: <20260305-b4-staging-layout_mars_base-v1-0-09831fa17cef@imgtec.com>
 <20260305-b4-staging-layout_mars_base-v1-1-09831fa17cef@imgtec.com>
 <e652db4b-1e6d-4bf2-8b26-24e3e642c200@imgtec.com>
In-Reply-To: <e652db4b-1e6d-4bf2-8b26-24e3e642c200@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWLP265MB5551:EE_
x-ms-office365-filtering-correlation-id: 4554cac3-0bdc-4531-9ee4-08de80caf984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KasNB1/75YdCkS1ukTkOPKl2fsOonncGOL4s9CKJ1SsS9y2YElH7KflkME6AweOSWYKh0YxalLoGWynWHOqcD38VaKmc8YuOPU9MNBf/mJ3wbS/ulAtHnmQ0Xi+zRTLnxtkf9t5MgxHRPm0tsYeplZddI9hru5596AjEQXHHzoCK87UeGEgSNX4inP0blluPMedGOSB2/FzioYH/iCq3uzcp9Yheq9f/P7Wh2MFKw+TJESQ7UiZMMtyWxzwTSe1Cp8ieBZqjH9UO9V9yfWi5vplyjmxY9cAR9/U8UGN5m/Jjlm2pzKIkm1DIcwRjQ6QDBLgBqtoyI680DoloUuB1g7+sFutJdfNZJUjNUYgWZTtpZmvq6bCgRUn+0PnpQebJSw4bDmV18JszaRptwaxXueG6KFSwIWnKSeSC5W/+/JsLAtUs/GEawbLQKIZlwtfBrxOP7unUtES1Z2gRA/GWSLS5ukSSP70wWA23jgSck7brBTox8MKnFwBHq6i5caiAslDUCYxZpuPOqIBC7X5hYOyipyHysSXrYZpSOPd/bovvHVQuP5PmwKGtUmDgUwbdBi0/kDBNd+PEgZQq33t9tZyweReWrMNqA0n6CkmWOGZR9lryBL9h+qmQsdSNAtkbWR1I8Q+wGAQYkxHurqmtqH5uU+ER0QwAOlOFEh4eTngH8xH7VkYHE8XfUbhtzQgThZb28jXpWXCnPWyf5DAP+yu/U+fMwpQI/SyCtyMAGTg7902H4dzrfpCVrsS/Tw3ox4mpC4BMiQMzFRkTpI5Nm6t26F0XwnKkXE96f/35+wg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU82aGFvV09YY0sxeGNzVGIzd3d5YjV5c0tjMitrVzZUREdqdHZxS3d6NHBt?=
 =?utf-8?B?dDFzbEZPRHNndGZSV2hWb1EzbTArQTh1NzRmUnA1bTBjR0lKMCtsOW1pdnZa?=
 =?utf-8?B?REIrM3A0OENUeTZZOHV3OVU5enY0SE9senVONUpIVEh6VGZkNkJXeVpabnp5?=
 =?utf-8?B?U3dybTZoREtpeFZSYnJFaXBkRmNqNzhQNXBNWlBVb2xnc3BYSkJ6TWtOOFdl?=
 =?utf-8?B?TnJhcFZzRUJWdE53MG9ia1pvUUluL3ZERjZMOTFyVGliNGxWdEVXejMxbXR5?=
 =?utf-8?B?bmZrRkxKcmw0c1J6NjFGMTc4ZXlmM21ZYzBVdUQvVFZILzdQaGxDS3lXK1pG?=
 =?utf-8?B?R1FoWjZQZVBCMElqVkR0d3Z6L3puUU9YbHhYdFZjRFV5SWZGK0N6TE5VMUFq?=
 =?utf-8?B?SjF6OGFlVUVoWGM5MmY0TzZvaWx6Q2tIMjQ2SWo0WFphYnMyOFVESEFsNUl4?=
 =?utf-8?B?U09wcWNTaEdqNFE3cVhJVWdhcDJyVGxYWEtMcCtFeXlNaFpGbFR0NUJUS3JZ?=
 =?utf-8?B?aWxxa3lpeDR5Z2Z6cFkvOEs0Z216NERiYk5wUXJmMzBiSk55dlZhVEhYNTdi?=
 =?utf-8?B?UUd6T1plUCtQUmpTM01lc1o0dDRGQ29wNFVWdGhNMXk5anZJRFdnTU9TUHRu?=
 =?utf-8?B?cDhSMFR5eDB1SWYxc1Z4TklSNDJ2UTZvUUYyY3lxMEFwSzBzUGs3THJ3ZUJy?=
 =?utf-8?B?dVo5OUh4OFN2aHkwS1B2aDBiTzJUN3p6MElDWnFvKy9PVU45TmpzcEdGU3F2?=
 =?utf-8?B?REx4aTVEM1JFaTl6Vmo4SWZrQTAvSzRLQkIwYlR1OWlQNW1wR1VnL2M1Y3d4?=
 =?utf-8?B?NlhPbmorbzZmZWtDS09rQ3N2bGI2MnY1dWJ4YmkyU1ZKMU44VVY0WnhTYytH?=
 =?utf-8?B?QnFnQlpOKzNEUDlMRzVkVG9ETEdNR1RWN3V6ODd3TER6WFQyTWVmd2hRNURS?=
 =?utf-8?B?dzF5dnFYc3AwV3NjTWgrVUt5Um1FYTcrOU5TTmtUK2RueVd2NmxqM0M1S1k2?=
 =?utf-8?B?bnNQRDhSY1lkNjVnQzBvUGF6YnhtdVlMNHg5bUJ2dFR3ejJJbFMyUTdaY2Ux?=
 =?utf-8?B?TFZ3TVZNdERZZXpkZ295Qm80ME5WM1ozSm90TUpIRkZiRWJFREJ1VmNxR1Fn?=
 =?utf-8?B?L3cyM1EyeUp3N0NtZTE1VllYR2RYL0RNTkpsTUltUFF1OUY0SXUzTW81ZERQ?=
 =?utf-8?B?U055SFB6RytMbEZlNkx1NDIzcnlLdTZuSEsya3RLSlllQjA2NDRBUzE0MmJr?=
 =?utf-8?B?QWQ5b2tWWmFDT2dITFhvWXFZaUd3MGtBZ0ZUd01nblY5eEw1TEhSeDFPMEl0?=
 =?utf-8?B?TVp3VzlRV3Vud1BOWFk5eTI5T3duY29qam5QcUFEa0JQOGF4U3JQYnJQNit0?=
 =?utf-8?B?cjNuaHNjYkdETXZNRkExWVBrMitsUkt0SStaN2lja2w3WXFuWS9KZUp6Mjdy?=
 =?utf-8?B?SDgraE5VRzh4bkhMdTdEU01OTHJMRWx2aE00Yi91SlJ2NHVKaXdrTnJab0ow?=
 =?utf-8?B?NjROWUp2LzcxMENkbWp1ZEgxUTlIQmFOUU9veHk2ZFp4WHVNcm5xQUQyVkcy?=
 =?utf-8?B?Sm56NSt2eWFXL2EycFBwOTNKR1dMSHhaZXQ1aW9oWmdzUEgvbnZFZW5aSFhq?=
 =?utf-8?B?YURha29OYTBWbkl0RllBZzlLNjNTQWVzcnp0VkZUbDRZTlJWNjlhTGFhSy9H?=
 =?utf-8?B?cXUrSHBmTFB0QVRlQ3BmcXpQR3F2b3VvQVUwczJZaUJQUmpQaFp2cHNmUDZj?=
 =?utf-8?B?Y0ZXUkxCYzlxaVErMGFZM3BidlRiaCtlcUVTdDRzYWxIYVZuM2s5bnhheG85?=
 =?utf-8?B?ZzFVSE82RVJ6bHNudzBocTlzYWFxZSs5THM2RXJQSGdQTExaa1lGV1VFSXdI?=
 =?utf-8?B?bUY4MXBxRWNNQkZoZXE5OEVPdWFJM1NIcWlGNm9EQ1NlZmFXb2EzQWtKNzhV?=
 =?utf-8?B?UmUwcWh4WGlDL2tpbUgzamZsc0tQSk40eWJYSUVMS2tvM3FTMXlqUlZRNEhs?=
 =?utf-8?B?QUJ0ZFN4SmVDU1laRUg4aVBsUy9VU25ZNEFmMGpYNDk4UU9FaFVYQTg0ekFB?=
 =?utf-8?B?ZVRvTmF2VHhiQzIzeWZaVmVoYWQzVnplNjdpQ1FOSmxRdjBQMmVMNDlSUU1o?=
 =?utf-8?B?Y1l3V2NlN2F4UXlJNkVtS1JhNTB3WUF3R3B2UkNNbkZ2VVJEM2xFdG1VWlR4?=
 =?utf-8?B?WU8yUDRZWXcxQnpXaWxwNUY1cDQ1VFRDYm92Q05VQlIxWEhwdFdvZ0libTVh?=
 =?utf-8?B?TnRPemExQzZId2FJbytWdjhFN2tKeW5RS2JpRVFkMWJLZndzQjI3VU4zM2Ro?=
 =?utf-8?B?MEhrdkdtOTJmdTU5Q3ZkVkhuUHV1bnJTRWJqK1cxQUZBWTFWL2tjOEhoV0Fj?=
 =?utf-8?Q?LVKgOhfNI5gyRNEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF27FFE1EBE5EA42B542CB49E48335EA@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ocnN7EeHO+0orYXM5LHe3uThV7Z1vbDv5SnPf8gO0ody2v8WSV585BuMKiO9rKFujgdQacrI4gS0Pz+af4DH5npSACkn/RWnDPTPANTFDQ9q9caRQQyFBS54hceQjcVjep1mPFV7evTLZYggy5Qtt6oqBu3Ne0NuaGbdsbKd13SUFEJgeKCI2PUq4FtjcsIYVGPCsZkOt6ihyZrop8koYaSm2as9KmH5fRiRxTVIEBIjhVUyH0AmyoUDA21xOIJ9YlAW8CCKSPNbxclJ30JZKZ3XkdwC5DWosgQNItKTwszREn/Jj/woof6ioyo5roLZ2NV/CwUsydygE5uCDSf2Yg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4554cac3-0bdc-4531-9ee4-08de80caf984
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 06:37:19.1018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34+iHnKPa1MgAykmwyftaGMq0i/UkrJ/Lo66htEaHNREFxFthKV8v25gMeqAtdp+B5zLhTXyE6C5+5zM8YXOTd57L73Z47h/lb1oeYXD6Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5551
X-Proofpoint-GUID: srqcWTyEztZclPI9wjs08LvZ9TAFkaMR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MSBTYWx0ZWRfX7ueARgCHlGts
 95Yrl4CxjhR0jVFMXI9fiIVkl+JzYLMiH1Kxl2he2+9agJJ7WtX5rkbP0LHCgZ9QOWg4YCk32He
 sYM/dhFeVn6Cij9yiJ9MAY8NQtx4aNk5XtGNFxc7UX25x68SkAtmreb7xtJdhl2ERYBeR/f2Z5h
 Q6f/loBMag9ZZ7ZiB9ZvGt2nxbZwzsVM6rML8N2e9/klMhnrYjodEGJbe5TE3DmZuG80bwFpoI7
 vBOmBKZ8UdDMVlEjnPsrl64uOz4nz/Zr/mSR1ZpGEKH4inMl++XzPskPsSTB0hU5+upCoKZmRss
 aenkII5rfROjxZSRqrg37QvPSH7QTuAfXK2Hmo/DeDeq+VJqG+685Gnx17wwQpPnMIqvhByYGWC
 k9jdAvjMrbZzUJSQEJL5yXAq+eiTn8J0K4n1wYmLXVsrl5ChcTmgvywu8MFim8M/KwvvNb/T7fi
 sKRLojSvjEuDynGRyqg==
X-Authority-Analysis: v=2.4 cv=NuzcssdJ c=1 sm=1 tr=0 ts=69b3b0a1 cx=c_pps
 a=Y1qG7/ks9iKWtqlO43d4ug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=GLaJPFcRDszqzwYtcJgA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: srqcWTyEztZclPI9wjs08LvZ9TAFkaMR
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

T24gV2VkLCAyMDI2LTAzLTExIGF0IDExOjM3ICswMDAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
SGkgQnJhamVzaCwNCj4gDQo+IEp1c3QgYSBjb3VwbGUgbWlub3IgY29tbWVudHMgYnV0IHRoaXMg
b3RoZXJ3aXNlIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBPbiAwNS8wMy8yMDI2IDExOjA2LCBC
cmFqZXNoIEd1cHRhIHdyb3RlOg0KPiA+IEluIGxheW91dF9tYXJzIEhXIGNvbmZpZywgRmlybXdh
cmUgTUNVIG1vdmVkIGZyb20gU2lkZUtpY2sgdG8gbmV3IE1hcnMNCj4gPiBkb21haW4gc28gRmly
bXdhcmUgdGFrZXMgY2FyZSBvZiBwb3dlcmluZyBkb3duIFNpZGVraWNrL0pvbmVzIGFuZCBTTEMu
DQo+IA0KPiBJIGRvbid0IGtub3cgd2hpY2ggaXMgY29ycmVjdCwgYnV0IEkga25vdyB3ZSBzaG91
bGQgcHJvYmFibHkgYmUNCj4gY29uc2lzdGVudCB3aXRoIHRoZSBjYXBpdGxpc2F0aW9uIG9mIFNp
ZGVLaWNrL1NpZGVraWNrLg0KDQpVcGRhdGVkIHRvIFNpZGVraWNrLg0KDQo+ID4gICAgICAgICAv
KiBVbnNldCBNVFMgRE0gYXNzb2NpYXRpb24gd2l0aCB0aHJlYWRzLiAqLw0KPiA+ICAgICAgICAg
cHZyX2NyX3dyaXRlMzIocHZyX2RldiwgUk9HVUVfQ1JfTVRTX0lOVENUWF9USFJFQUQwX0RNX0FT
U09DLA0KPiA+IEBAIC0yMjksNiArMjQxLDcgQEAgcHZyX2Z3X3N0b3Aoc3RydWN0IHB2cl9kZXZp
Y2UgKnB2cl9kZXYpDQo+ID4gICAgICAgICBwdnJfY3Jfd3JpdGUzMihwdnJfZGV2LCBST0dVRV9D
Ul9NVFNfQkdDVFhfVEhSRUFEMF9ETV9BU1NPQywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
IFJPR1VFX0NSX01UU19CR0NUWF9USFJFQUQwX0RNX0FTU09DX01BU0tGVUxMICYNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgIFJPR1VFX0NSX01UU19CR0NUWF9USFJFQUQwX0RNX0FTU09DX0RN
X0FTU09DX0NMUk1TSyk7DQo+ID4gKw0KPiANCj4gSSB0aGluayB0aGlzIG1pZ2h0IGJlIGEgcmVt
bmFudCBmcm9tIHRoZSBzZWNvbmQgcGF0Y2gsIGNhbiB5b3UgZHJvcCBpdD8NCg0KV2lsbCBiZSBk
cm9wcGVkLg0KDQo+ID4gICAgICAgICAgICAgICAgICAqIDB4MCkuDQo+ID4gICAgICAgICAgICAg
ICAgICAqLw0KPiA+IC0gICAgICAgICAgICAgICBpZiAocmVnX3ZhbHVlKQ0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHNraXBfZ2FydGVuX2lkbGUgPSB0cnVlOw0KPiA+IC0gICAgICAgfQ0K
PiA+ICsgICAgICAgICAgICAgICBpZiAoIXJlZ192YWx1ZSkgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGVyciA9IHB2cl9jcl9wb2xsX3JlZzMyKHB2cl9kZXYsIFJPR1VFX0NSX1NJREVL
SUNLX0lETEUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUk9HVUVfQ1JfU0lERUtJQ0tfSURMRV9HQVJURU5fRU4sDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUk9HVUVfQ1JfU0lERUtJQ0tfSURM
RV9HQVJURU5fRU4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUE9MTF9USU1FT1VUX1VTRUMpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGlmIChlcnIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KPiANCj4gVGhpcyBkdXBsaWNhdGVzIHRoZSBwb2xsaW5nIG9mIENSX1NJREVLSUNLX0lETEUu
IENhbiB5b3UgbW92ZSBpdCBkb3duDQo+IG91dHNpZGUgdGhpcyBsYWRkZXJlZCBpZi9lbHNlaWYg
YmxvY2ssIGFuZCBtYWtlIGl0IGNvbmRpdGlvbmFsIG9uIGEgbmV3DQo+IHZhcmlhYmxlIHBvbGxf
c2lkZWtpY2tfaWRsZV9hdF9lbmQgb3Igc2ltaWxhcj8NCj4gDQoNCldpbGwgdXBkYXRlIGFzIHBl
ciBzdWdnZXN0aW9uLg0KDQotLQ0KQnJhamVzaCBHdXB0YQ0KRTogYnJhamVzaC5ndXB0YUBpbWd0
ZWMuY29tIA0K
