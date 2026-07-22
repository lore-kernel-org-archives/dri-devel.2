Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A919C4453F
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AED10E43F;
	Wed, 22 Jul 2026 09:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="dKeRi6iD";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="FK5f31co";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351C410E43F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:56:31 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M90eGJ3443955; Wed, 22 Jul 2026 10:56:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=ecckNinLBK10Dn2OCyRpbZd7Ve7MkQU1+UDvKv9gOtQ=; b=dKe
 Ri6iDx0xTExnlCcn59dtQmq1TxlAOggk8OWjwyeFf3txr9cPpVDbNnBFNF5Yadsf
 zTqcAsWH3rkFagjjGM4bMvIAL7A6x/FIb2JbtoNAqpGkdhgUxieHr+egAO5jED60
 AGPxpgI/5Y3ahGodkp5m/nm6eSNpeN85rqLreFs7vHOesxuJd+D9sz9wjL10IiUl
 ffFA2TK3A6kvmUafTvqzqokT6caOBVZpX+wkNNGIY65YeZQ0d+b9ykUolahWi+NI
 nXc09N+HuBD7p4ZWHleu9rmErDxZw08gX2l/VAW9PPMmsIqqJURzSRoNdsgWMGpL
 ByNpkDtqyBRNxFAqb0Q==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1hnmj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 10:56:14 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ4uNMUxPaGp8t7h+dk4aWXQRjGSP1jjKSD5cARIyKIzEY0LD3OUFMAGgJZxiiEdcldKUGSTiWHQUjCyaTDY33mxf5s3fL/GFfh0TY8TocoOeGSNh2OERh0onCMHNBPpOinoHXSN49nuFS+VbH7J44W57R/8r507WF21UifF/FxgjZdB9k89lfedJ9+X8aZFcD0hlZ10lFUKbTDCwVLdHQylRcafxH/n4XCBYuqmZZ2bZR91jWWQh6FioEg0MfoWXkU4GaEtNjGgmKW05Gf3y9eL7WXbV3fn6r0feXpNuJVW6CZhIVA79moiuiRq0Pgu7CLCcbfDB7yRpgU7Yz+S1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecckNinLBK10Dn2OCyRpbZd7Ve7MkQU1+UDvKv9gOtQ=;
 b=JbeLf23uwLvv3QXwdjSqg6IzeMrwyxWbiUsPLneL5ags6NbkZeJKAHy8CRIRvFzDE90Zl8CUc7QXKKENcVfrFDMDkuv4fm9K2GXVLEUAq+B/SrfxHOnkrG0i0D6whdR8d+O9/hkz6bq7WdpHARPmo5s6XUxW+ovkMt95hSwDO4AUqbdVZj7ZyyB29MnB4Wyvk/2qVEw+NcfNdNtmI0sqpba6lc5elkathTNQgXYp5WNL3lBGHD1J/ClpUf+Ct8DQOJbOwrWGbILogyY2sH+2i7Y2cbHS7FnPVrMKSzajl+EF9akZd64+PnH1MWb9m+hcVESg79M3ZiBcBsbJj8lsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecckNinLBK10Dn2OCyRpbZd7Ve7MkQU1+UDvKv9gOtQ=;
 b=FK5f31coqVzXiVoGmgSvyBqxW21DI7wS7eXL0AeJhRJJ6Ikjj2rKeykeTHJXrrpHbgquoSyaH/IkvNuIwT5g8/60y0rPVky9j/MvmrXAsi1PWGUpfIaYxNhsQg/+1CBBM51WwkV4Wj8EtEwxl4QvsG8WSxGYW/AIClMMWy8iQoU=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LNXP265MB2460.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:56:12 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 09:56:11 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Fix value of HWRT address in
 pvr_job_create tracepoint
Thread-Topic: [PATCH] drm/imagination: Fix value of HWRT address in
 pvr_job_create tracepoint
Thread-Index: AQHdGFmLsSWvjmTZ+kaNIxvEHyPF9rZ5T7KA
Date: Wed, 22 Jul 2026 09:56:11 +0000
Message-ID: <9f6f9fbd79bef9d827c508f77189dd06d69ae5ea.camel@imgtec.com>
References: <20260720-fix-pvr-job-trace-hwrt-v1-1-b24551802efb@imgtec.com>
In-Reply-To: <20260720-fix-pvr-job-trace-hwrt-v1-1-b24551802efb@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LNXP265MB2460:EE_
x-ms-office365-filtering-correlation-id: daeb0079-80d1-440d-81e8-08dee7d7760b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7ZrEhzWfv7pJyY3q/AKUULmi22y7jUxDzZNlXIT/Di4wFxFRKahnznkmFMrlQsMbIEYg1ZuHA2OoWdglZ8yurc8HdmfyeNZeWwPPC1UGPIuPnNEZElsy9bD605GKUTDk0Z1BLKhxmKaVr5ZfpwkpyZtH1jsg2mKn/tmaJgPRJwNHbAMmLieschSAJeaTyeWOHl3m4QzVhkk6HRp/4oDzM8uXe4KPQhqtxMLO1zDlqge4iz8aIk41hkLEbhM3WiYTJZ248tRFE02Ravz1K+zfPDC/S4ExvWa65Gp1AxqAHpFJxVlKcZoqX1cOApKc1LX9sEthImIHT2vyhN59ksicRWdAP/2CLqlp+hlatdp89GM4WomG5m4TlCHn7l3+zlF9DVANAy06S96bexJNO2DCm9eZmIam7a0xS6gJwS9D1gsXgyEjMsiNosJYQ6MwGJDOLaJs79MJ+TCCnvoc1TNYpsOvBfO3AD/QyHhfSCM86drbuZ0o/Q/LjbR5GtVCgYIae27EgSJyDklC0x7mFLqmJGFKtLtsuhDq5tKYl+zGX1jqZg2plcTyIY6bUj6MbLHMJlrG5tm/UPpsbx+jc7RrNaXzt8djvWTwxvDSoQZkYg14W6a46I4Lm7r9ZBpPmtZNSticnUa+3Zg/Ow71ZlXoZDsc7R7HaMMSozFjdhBJWhP6z7gK21eaOMMeflsiZxdj79wX6QGmUpJTCrVDVyjcBE6gv/Xl5P8bz8q/ZtlcyQQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRaMXAzNnVCYkxKbjZBb2gwVmQ4OUMzL2g3TkFabkk5bHdtSXNhUDlFT2xM?=
 =?utf-8?B?WlBiNnBtMUwvcEtXYkxGN3E5RDVwYm1EZk40UXFBZFJ5RlRpTDFxTER4ZnJW?=
 =?utf-8?B?UUJnZHVod2UwL2wxbFlaR01hQTNRaGd4WWpjVXExVTc4a2trb1RPUmdBTy8r?=
 =?utf-8?B?WjZrRlZ3aEtXZ0tDQTczRHJDQXFkWFNONGQvY3FBbmFZT2diZE9RSjYzWGs4?=
 =?utf-8?B?eFJLTGhPSVNTRStDMXVSMkpEUG5QUmVLREpIWXpYVmhYa3VZeTNVVy91TWdM?=
 =?utf-8?B?K2NDSzZCd05KSHMxR0pJN0dGWVg5cXhOcVFaTDRyS1VDRjk2Ums4MkR0dk9D?=
 =?utf-8?B?VUNzVjVqOVNwV3ZERU1KR2R5dHlrUEVRbFhZeFhIMWs0dGczWEJNaytNVDhZ?=
 =?utf-8?B?RTVuVXlTTERwTExvL1IzczZRMHlPZG5HL0VYeDZ1cXVDSVJoOGZqQk43d0hQ?=
 =?utf-8?B?cCtKTStwdk8rNEl0aHNHMXBXaENUOXdZS3MwUDlyOW9yb1dQT2dFU2dOVkRx?=
 =?utf-8?B?dEZMazZUUldsbTlpa0tLSERWTXlwLzdkY3dROXNUODE0VndXcEVmS3V5YnFa?=
 =?utf-8?B?dis4YWZqNTZrY1NadzJlcnFBenVWbVMrNjRMQU90SThaWjUyNHgvZnJDbi9L?=
 =?utf-8?B?YVA5ZHF1WnNwV1RNenlsUDhmdkFHdUI3c0Z1NEkwSkJBUStCQUt3ak5HRzhi?=
 =?utf-8?B?NGc0NFlqTjZWWDhVQ1YxUDZIN29KVkEvbENCc3FCbS9FK0lKQmJlQWd5TWNG?=
 =?utf-8?B?UkNkR2I4K1Q0RW1XOWNDSlYvVitQTzN6M1pZRnVKSmwzS3gvU2UzZTFZN2pr?=
 =?utf-8?B?RFFtYkhjdVBDMk5pVkF4dGl1bk5wZDlHa29jS21QVUdsNk9GRGxSelAxTVhi?=
 =?utf-8?B?ZE1xMVppZXhJTm91NWlia0NqTWNiSERyeDErdTdyM2tDZHZ3S1cxVThQVi9N?=
 =?utf-8?B?ekRFK09sMkpsYjJsSmhRc044Wkc1WnVoOThDeUVuMkZJMXp4U1Z1bVBlYzJt?=
 =?utf-8?B?aHcyRFFUWExtc0NoS081QkJXVWl0OWtEdkhkTzNrTVhlSGNSMHF3eEJOVk9t?=
 =?utf-8?B?encrMEJHZEF0eDIxd211Q2JZem1RVCtBa3pnWUJJZXgyK3grazRwb2g0TUxu?=
 =?utf-8?B?eXpvbXpPQ1pMWkdBYjd2T2dndmJpSG1JeXhtRSsvOGxScTBWakdTMjkwQi9m?=
 =?utf-8?B?d29EVmtVUHdhTjJIRHZzMWdOQ25zMWkrT1NQL1k0a09pN1l4NFlOd0ZnM25Q?=
 =?utf-8?B?U0lOdGIwcTRJY1ZBbGtmQU16dHkvS09YaDg1ZWlrME4zWjArbXB6cFNEYkds?=
 =?utf-8?B?UzZIcEEwQlBWbUM5RzhxbTEwMUJscXprNGRXYlRLOUxSOHFnVDJqVSsrZnNp?=
 =?utf-8?B?cWxuYVJyNnNEMlhSWUtVSTh3cm5HRjYyeFBFa1JjLzlUelBXUjFDQjQ1d3N6?=
 =?utf-8?B?K21md1J4cDlqWWx6SHIxUE1na0VzcGU2UlZPWEZIUzBzWFlFNWJEaEZtRTR0?=
 =?utf-8?B?UDhFVFd0dERYWkpnUkJQbW1sNEdMai8ycE1ROHFNN2s1ZEdZQmRhNEErRko0?=
 =?utf-8?B?UVBwSGVTK3ZNVUJxOXRMWEFCWE1hbnFBZUp3eFZwT2JKNG8vcHYzdDN0MnMx?=
 =?utf-8?B?K2pXVjVqTkhUaGpTY0VScGN6VHJRYjRzeXhKbEpjaEhLZWJaR3NaYUFrd3Vq?=
 =?utf-8?B?YXEzY1lZQTN4TmdkYTVCNkYrK0RQMUN4RXlERTFpRm5ZK1FMdkc1c2cvYlJq?=
 =?utf-8?B?ajVlTDAzRDZ6Z2JYWWphVlRpV3BhcUl0c1JPSklnVjVoSi84TGxDNFRYalhv?=
 =?utf-8?B?aUEzdEpGNk0xY3ByckFFY3VKanlTNTdnQ1orRzhta1BTcWhKWG1DdWxWZ25w?=
 =?utf-8?B?enVGQWxCT3pvQzFrSi9zVUdyYU9DQkphb2F6SWJVRWp4Qisxd0pSbjNqRXla?=
 =?utf-8?B?V3JJRGZSKzVTY2VibjhyUlNTbUJxM3l2MG12SFV4N2hTYU9HZDFSNmNyTXhi?=
 =?utf-8?B?VjA4d0Y4MHRkNkVVUlF0eGZ6STdwUnNpVkNzemJWak1UWisxWlZhK2Y3SEJJ?=
 =?utf-8?B?akZYNStwRFVCTjlGZHJ5QkVWbXgrUGZnOVJ1S1ZDaU8rMHNXVEk5T0U0WXpJ?=
 =?utf-8?B?RmlmYXdlNmdETjByV2M4dkhQTGU5aW40UGFwd0huc1h0Nzk4MWdROTFuZGYr?=
 =?utf-8?B?V3pKYWIzdFMxMExvOW1lVk1jV2VxdmtHdjhDcDgxV1Q1ZVJlb2NJSGRDRWI4?=
 =?utf-8?B?WWpCb1pNU1VVL3FXM2pFeHVXbkVGdDlEcDBjN0k4ckRuL0hWa0FPcTlBWTZ4?=
 =?utf-8?B?WUJPdHlnVG1FbmNxclhHSXNTUzNNbVE5aUlMcjNNTkRLMUNQc3dPUlIyY1ph?=
 =?utf-8?Q?D9ZY0/O+KlMHqnY49902OX85VCEMOv49KgCFFxoPI1EcK?=
x-ms-exchange-antispam-messagedata-1: pUtvFs7bYGC8g3hKv7A07hbPFHIlZpGLR98=
Content-Type: text/plain; charset="utf-8"
Content-ID: <544F49EABE78A849BDF6FF7F32AFA244@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CwNQbc/HVz4WF5yP99+KaWJ9JggeqhdtJySIubEYXfANUaT/DsH+N6N9wRGYtP317RLu5g7wOC+cLD3TqkSmbzvpK9hPOLe71xEt8y+tv14a4E4nxqU2g7uydfl5ogahaBo//Md8rP7Us7iqknn7t4QJ6r5o2CS+gYSYkNzPCpICbetCRqqOxabDRCJSbE0+OWcea3u3DWyKYJc+aEPFyOf4KKFv2G+kHkiQAzoclkMZ6YR17L6muynZBKJoG2fjCcK6KM9cW/hLYJ4YO1//gAd1Ilbw53ezPZGeGaAuF53dZi1pxqzpUJUq8UMEJzzngYig78sc83OEkVCTVsZ60A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: daeb0079-80d1-440d-81e8-08dee7d7760b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 09:56:11.7245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sp59iBwNCZDt92ogbDBZOxUXPFUGH+8fshnZxA/c/0c5bddjjD1BpwjbwXIZOBWZVaB36HlwZ2Dmyh6AkHFiaMOsssFMZ6WyI9HZUWGEK+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2460
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5NCBTYWx0ZWRfXy1lBzqnHZVGj
 j5f+oIHuuujd9+MT84Itt5+hNYbo/WcpJI9Dih02qeyUR3rfE8VIT2EkpqCHfaD2hBGiaYGuXCH
 RAEjXbC4f0D3qdBPqIafc+dUTdv+hN5HVg4RpcX6AVh1u0HASA+JP8iWj89Xa/8qTjo9ngTleFd
 djYgSRuM5+nzfH6ObMIJ8ojeQDVbMY3vQyJv2bqbmLFMFljt6+UgStq4IGAwgDJFA1T7dPNxEjm
 k7v7mHnsWHl1wv4J4J7tico7KzeXREXR29QeE/Ncp0aP71Ub5ZYn+72vlUl/CgIdju5fZSh5qH9
 rMd6yPd8afapOMjl72Yg+73rNcw1813AFxjeQBf1yUehPNSse7BgF1rsOK7QZWlmv5JB/Xzb91r
 MN9E6jSrDFZi9ZV2HvlddypSggTo8hudk8qTgjYjoTOqpQxENRfx0pQXxo0RgrJkWq5BH8SIAti
 1FbOTecZUlxJN9VT5Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5NCBTYWx0ZWRfXze1woQoKTEKI
 i9eSythwJEtpUWLGwzu+iMkrNx7iVVRrLZ9oYMeXyQXBT1fsnnJRzs4RTDNEvz3G1Zb6JRFKIF/
 TuSjs4WlR1CR2Z2d3/Ds/QQxwyjycdQ=
X-Proofpoint-GUID: M5MfBwh-9nFQmHI_haKqg6MhGIObxZvD
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a6093be cx=c_pps
 a=b9j9FjBF/Z3i40esLa4jYQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=CJxmP7BVghtzcXM7oGEA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: M5MfBwh-9nFQmHI_haKqg6MhGIObxZvD
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

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDE2OjA3ICswMTAwLCBBbGVzc2lvIEJlbGxlIHdyb3RlOg0K
PiAqKiogTk9URTogVGhpcyBpcyBhbiBpbnRlcm5hbCBlbWFpbCBmcm9tIEltYWdpbmF0aW9uIFRl
Y2hub2xvZ2llcyAqKioNCj4gDQo+IA0KPiANCj4gDQo+IFRoZSBwdnJfam9iX2NyZWF0ZSB0cmFj
ZXBvaW50IHdhcyB1c2luZyBwdnJfZndfb2JqZWN0Ojpmd19hZGRyX29mZnNldA0KPiB0byBkaXNw
bGF5IHRoZSBmaXJtd2FyZSBhZGRyZXNzIG9mIHRoZSByZW5kZXIgdGFyZ2V0IHN0cnVjdHVyZSBh
dHRhY2hlZA0KPiB0byBhIGpvYiwgYnV0IHRoYXQncyBhbiBvZmZzZXQgaW50byB0aGUgZmlybXdh
cmUgaGVhcCwgbm90IHRoZSBleHBlY3RlZA0KPiBmdWxsIGFkZHJlc3MsIHdoaWNoIGlzIG1vcmUg
dXNlZnVsIGluIGdlbmVyYWwgZS5nLiBmb3IgY3Jvc3MgcmVmZXJlbmNpbmcNCj4gYWdhaW5zdCBm
aXJtd2FyZSBsb2dzLg0KPiANCj4gVXNlIHB2cl9md19vYmplY3RfZ2V0X2Z3X2FkZHIoKSB0byBn
ZXQgdGhlIGZ1bGwgZmlybXdhcmUgYWRkcmVzcy4NCj4gDQo+IEZpeGVzOiBjMTA3OWFlYmI0ZGUg
KCJkcm0vaW1hZ2luYXRpb246IEFkZCBzdXBwb3J0IGZvciB0cmFjZSBwb2ludHMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl90cmFjZS5oIHwgMTYgKysrKysr
KysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl90cmFjZS5oDQo+IGlu
ZGV4IGZmYmJkZTNiMmJjYy4uOTQzZDZiMjQxOGNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX3RyYWNlLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl90cmFjZS5oDQo+IEBAIC00MSw2ICs0MSwxNyBAQCBUUkFDRV9FVkVOVChw
dnJfam9iX3N1Ym1pdF9pb2N0bCwNCj4gICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmNv
dW50KQ0KPiAgKTsNCj4gDQo+ICsjZGVmaW5lIFBWUl9KT0JfR0VUX0hXUlRfRldfQUREUihqb2Ip
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsg
ICAgICAgKHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBw
dnJfam9iICpfam9iID0gKGpvYik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiArICAgICAgICAgICAgICAgdTMyIF9od3J0X2Z3X2FkZHIgPSAwOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIGlmIChfam9iICYmIF9qb2It
Pmh3cnQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiArICAgICAgICAgICAgICAgICAgICAgICBwdnJfZndfb2JqZWN0X2dldF9md19hZGRyKF9qb2It
Pmh3cnQtPmZ3X29iaiwgJl9od3J0X2Z3X2FkZHIpOyBcDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIF9od3J0X2Z3X2FkZHI7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAg
IH0pDQo+ICsNCj4gICNkZWZpbmUgUFZSX0pPQl9UWVBFX1RPX1NUUih2YWwpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgX19wcmludF9zeW1ib2xp
Yyh2YWwsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICB7IERSTV9QVlJfSk9CX1RZUEVfR0VPTUVUUlksICJnZW9t
ZXRyeSIgfSwgICAgICBcDQo+IEBAIC02NCw5ICs3NSw3IEBAIFRSQUNFX0VWRU5UKHB2cl9qb2Jf
Y3JlYXRlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5jdHggPSBqb2It
PmN0eDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgX19lbnRyeS0+Zndfb2JqID0gam9i
LT5jdHgtPmZ3X29iajsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcHZyX2Z3X29iamVj
dF9nZXRfZndfYWRkcihqb2ItPmN0eC0+Zndfb2JqLCAmX19lbnRyeS0+ZndfYWRkcik7DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmh3cnRfYWRkciA9IGpvYi0+aHdydCA/
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGpvYi0+
aHdydC0+Zndfb2JqLT5md19hZGRyX29mZnNldCA6DQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
IF9fZW50cnktPmh3cnRfYWRkciA9IFBWUl9KT0JfR0VUX0hXUlRfRldfQUREUihqb2IpOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5qb2IgPSBqb2I7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF9fZW50cnktPmpvYl90eXBlID0gam9iLT50eXBlOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX2VudHJ5LT5zeW5jX29wX2NvdW50ID0gc3luY19vcF9j
b3VudDspLA0KPiBAQCAtODIsNiArOTEsNyBAQCBUUkFDRV9FVkVOVChwdnJfam9iX2NyZWF0ZSwN
Cj4gICk7DQo+IA0KPiAgI3VuZGVmIFBWUl9KT0JfVFlQRV9UT19TVFINCj4gKyN1bmRlZiBQVlJf
Sk9CX0dFVF9IV1JUX0ZXX0FERFINCj4gDQo+ICBUUkFDRV9FVkVOVChwdnJfam9iX3N1Ym1pdF9m
dywNCj4gICAgICAgICAgICAgVFBfUFJPVE8oc3RydWN0IHB2cl9qb2IgKmpvYiksDQo+IA0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IDE3ZTIwMzBmMzc2MDA5OTQ0NDBmODc1ZGM0MTA2MTVkNWM2NmVl
NmQNCj4gY2hhbmdlLWlkOiAyMDI2MDcyMC1maXgtcHZyLWpvYi10cmFjZS1od3J0LTMyZjU0YzBl
YzE4NQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lv
LmJlbGxlQGltZ3RlYy5jb20+DQo+IA0KUmV2aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWpl
c2guZ3VwdGFAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQnJhamVzaA0K
