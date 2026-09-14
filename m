Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E17CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5F410EE6F;
	Mon, 14 Sep 2026 13:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="bZNJh02A";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="YI62Kd6W";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC30410EE6F;
 Mon, 14 Sep 2026 13:25:14 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED1C12121687; Mon, 14 Sep 2026 14:25:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=aimrsrW6iK4ClTyVtYwVySMtpzxP8ZC/CQLtLaH1N3g=; b=bZN
 Jh02Alb6uRvEXATdNFic98/kIJPTjz8KBvShJTyktQMZWnPve6LXUtTGu6UHh1N9
 CI9SgpeTW6htMuzl31x3V7N1Xk1nwQ5hIXsrd7Ktr0TV5OErAb8k9PVYHPFfgdCV
 WJN6llvrOEu5t4dld7XmLRmMcgrlhW15DjXRughktjqoR+M/fSDaYySh4hskEH6t
 dwy8fuhFf1QDnC29wWVrtWg+ZgoJp6IBgUSV18Wo+Ikg98aDHBjBI+tfnUoFtKHs
 oN2maOXMCG8jzeRI0y5sJCSGPlgN+TeWeU79glE4NetiqUlGJijDhx6MBwiBsizv
 TmJ4dB2DZj0NHQi779Q==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtuhnkt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 14:25:05 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIdDSm26+OFBG/DEURuZnZhc1EcZNy3IZuNvbNhbQL9sqAMUYqiU8zNaSfI9+zDrvJeNUVSIR0uDZODWZw1pT+I1QZ8Yfmt1I68kNQlvfqOtCM/J8/g0aSltZSkbxj8Dy3zapFZC0J/+LPnXyH6xe1eH45vMgayCvTKeMS6SnKOpkuCcd3Y1o6QiTge3MZQuRvAIM8k6pMNYstqE8RX59SNcZrq0XGnO0oX93gofLK9KaC1Ds5FnTCaWsLD1GHTA3G6f3NQw1fHCvjkXRJcNKNMW8n1D2kZ82NfLH5lqZ2glfKagu4GFcejRVzSCOuLfe7MhUoimPHAKiWspztW1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aimrsrW6iK4ClTyVtYwVySMtpzxP8ZC/CQLtLaH1N3g=;
 b=ssWb+yZCCj3OHiteO9pzZRVE2HSLGJ5A0ElgIlaBmLJV8Cd7nJhs0eqb4NVmGDXPsnPgej0LVIrYaJFC8qGm0hrbc0CWY3QbgYkWjP8dochKH59t/iArSM95CsyKzxdNlBMuD/hhr6fKMoFpQvG7WNCSc7pTht6kfsP5qf+dlYI9vDJ0K0OXQu5Qt9zTbxDP1qlz5ZYoRV9G5VjrDkutMLGnLQFIV9GOHx8KNjR2u349GbpotlomySrYgoRd9VilEaLoGCJNOsWdyu62YjpdE/xaurhYTiesbqz5NizJky3ouHTa5h8SBgx2dTG7jYAy7YDKtRcUWNfH2CRA/ROq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aimrsrW6iK4ClTyVtYwVySMtpzxP8ZC/CQLtLaH1N3g=;
 b=YI62Kd6Wiamk9Otd7bNShaBvthVfjVj6aVJpylNC8KyS1VxT8RkJRzU82C9wqSmFJ79hZA4MoFlbam8yrhH7184Ul3E3SjPdMtZss/fbn9MF698epX0z8OQCgnAJr+k/+vjXo0xBS90f7yz87fBbjw1C0i8bhXflBiyuueuvX4M=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWLP265MB3188.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:25:03 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:25:03 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: Add job type info to pvr_job_submit_fw
 trace event
Thread-Topic: [PATCH] drm/imagination: Add job type info to pvr_job_submit_fw
 trace event
Thread-Index: AQHdL7QQ2vanvF3gBk2goWS79pUOdbbOOXuA
Date: Mon, 14 Sep 2026 13:25:02 +0000
Message-ID: <925239a5de5ef761adb85e2d236714e38061925f.camel@imgtec.com>
References: <20260819-b4-submitjob_tracepoint-v1-1-f817b222bf6a@imgtec.com>
In-Reply-To: <20260819-b4-submitjob_tracepoint-v1-1-f817b222bf6a@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWLP265MB3188:EE_
x-ms-office365-filtering-correlation-id: b030e908-7016-476b-9732-08df12639583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: omZidRb6sW61eOlRwjNbdNaBjM623uzWpVDOKkTm0K1+CGLAd67DtyR65uzX/vwC+BK9og/Hk2LD30jBUCxnkSop5mSKB0vUG9BT4HyAY8Dmf7V+3J7HRrT4s+4RcwlAdu/057oKwaHJYzQ2DG36S2c6FzSi6DQpQB3PwBjcCzjBz0f8zHIiYutxycQeAZnGtqQawvhtBE0vnHQnsV6Qv18NgzlrgUq9VVsXJO+J2yMRNPrcnB3/+TCCFxHBW8Z4vxH3eVTmnT9imFj2gHskLUcd29rWpYWguVDmPs2UggUITQA+wtvHozJz2lrkgShUsL2Xr2GbQBucL9EL3X6XFTEYF0s15pfaTDyyELYgPFbbeslHmz3877+Uq61RDqNeHYRZf/VO7suS1yJZPhdmgMy+jDVqBzz/HTObqFUhLGJmiryCn+SXJ350gKEmsRwOURT88tI6sRs0Zi75mo3BU/YVKt/Rxsekfs1l8IQSNDOPXQIJgYUGfTGwDivycCQIEpfPW5ei/y6bIQMwrorxuf0Iu7fPIu9Guxs5Z0bG7McEHHiW2fiypezJ+aicw+jkAp14w+WcHRIcPsanlZO18ZOj+6jXrVurXiNaJ/8/9bK/SVAxd72KAqYxMkA9zQF3EdR6eKEXDErVQWA7/WkOYSZ+9sbHdhh/5uZo6MLAbPMQIU5z4ZEnxEKTExOzhaUNVwnXEo92M764G5yZr0yXMCi55u9TBDdL6P1mSbbdAks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJOc0NqWVZseDBiK21teTArMXZhZU1NdFBDZVhJd1hZQ1ZyOXlId2dYZm1I?=
 =?utf-8?B?dGI1YVRMcWg2SDRWdjFteTZiUldMTVB1c0pkSlBsQk1iT1dFK2NOc1VqdEdk?=
 =?utf-8?B?RDNEdE55b2ZtOTNCWXRMVEhwZmFoWHd1eEVvUHYyV0ZTbS8xUUdOSUt4aTdp?=
 =?utf-8?B?TVZCZ2xGMlhlRTZzeDNLdldqVmFudER6dUovSThKYnQ0am8vbHBCU1RFZXc4?=
 =?utf-8?B?SUo0a2tSbzRnZmxHTXBQZlpVUEwyc0N4eGkybWRhZHZtQkNHL0lrY2ROWlVx?=
 =?utf-8?B?ZmNRRVZtUlYwZmljd2t2V05FQmZaTllmOHN2VHpPYkphZEJadmVQaUF0bW5h?=
 =?utf-8?B?K0xYMWNsNmpxVEtYbnl6VjBjWUZXTURubTZHeWlSV2tMejIwNWx4RWZHUUlW?=
 =?utf-8?B?OTBNVWpkY3l4cjQvTVd6dkpBdlphWVA1YXJyQ2dIdUFvWkx4TUg5K2o1MDhU?=
 =?utf-8?B?dUxEUzFzeGNyak9zc3lKbGpKeTVDakVxZWlCd2ZVODB1bnhHN0hwU2pvRVQ4?=
 =?utf-8?B?SndFYkJuL0l6bGtaWDdEWnNRRllqTER1Y3FGekcyUzlUeGdZa3dIV3c4L1JK?=
 =?utf-8?B?dVhqWDI1ekN4NUg4ajRSVE9tTmJBMVFLd0ROUy92d3ZaOTVWSjhwbmNia2pS?=
 =?utf-8?B?eUZsMG41MlBkSXM3ZHF1UVdLKy80dEcyTWVqc1BBR3JUaDVpSlVwQ1FvVDRS?=
 =?utf-8?B?clVNSFo2N3B0RmVpNURRcTBZcGI1MktGNGtaeklFM0lTZmVwcng5eXk1aW0y?=
 =?utf-8?B?WEE5MGhmVUpUcDg4aTk3RkJhbzFBaEM0UkhONXBKcWRxcU5lZXlvOTdrWEdh?=
 =?utf-8?B?cXdUT2JkZlM2SGovKzZIelkvam9oVmJwbXozQ0lRaWN5K1BOb3ZOVzI2R2hW?=
 =?utf-8?B?TURGYXRUSFEwdVY4dW9VK2haRCtuc1FXTDh5aWZzSGlwaEE4NXdwWWJPVkM3?=
 =?utf-8?B?ZzNQQ2p4Q0xWWnlaeWJQd0V3N05Lemd2bW9xaWFObDFYY0c1RnEzVzVLeWU2?=
 =?utf-8?B?STM3KzQySklOUzlxc0RSSDBYRTkyRnZXWVJLOUlBZitHRmlLVnN4SWZkbzhu?=
 =?utf-8?B?UElLaGpMS2lZaGZHY0JCUkVISURTTGpCUysvNk50cmVPd1d4QktFOWh0ZjhF?=
 =?utf-8?B?aThiZ2xMSzE3TDJacVAyQ2RZbks3T0NDNDZHZEpTamVGelVaL3plQ01JeGJl?=
 =?utf-8?B?RXphN2h2cW1BbGJlTGd2RXdhUXIxQXNqcDBqOC9uNUJ5d2FzNmRyTklaTEd0?=
 =?utf-8?B?MXBNUDlBWklYNldnb056QUErMXpEamtxWDJndVova1dXSnM0ZUhnZXEyK0U2?=
 =?utf-8?B?bDdyVlF2TGJySHowektjVFAzUXB0SWIzdnNLM1pVZXozL2FKbE13RUdsbkh3?=
 =?utf-8?B?SVBXazg1VVdRQXdGZDdycmo0cW9MSXZISHlDeVBwM01ZYjRpQ0t3WnlIWU0v?=
 =?utf-8?B?Z1ZJSmZSYUdUN3NIay9JVGN2a1BUSTlxTmRhTDIrTFRHblVxQS81aVUrQTF3?=
 =?utf-8?B?TjNkTlJMbDRPeUJ0bktIdnlHR3BvU0t2a1AyaDZpQmx1eFRqRVRxZ0lWZmN1?=
 =?utf-8?B?NHd3dEZ5U2k1QWN3a1kyYk1peHhBV2lEeHRYeEplS3JHM2xMRElKWDk2em5K?=
 =?utf-8?B?eWhtMEZUNHZ4T0h2eUJtOFF2Z2tJNHJJMHhNUTV6c2E4ZGFhUFJiVjBvQXVX?=
 =?utf-8?B?RXQ5aU50WVc3Q2NLU0FxeW5SVjlQTG1jRzdLdXBwY1AvNWN3NkZSRHcyME9C?=
 =?utf-8?B?UFVWTG5nVnJ6MHZ3NmsrbGNaMURhK1JnTE9BendVY0ZQcmFSZ0o2Y0VpdlUz?=
 =?utf-8?B?QzIrZG9UbUhwajB4RUV4NnJZQ0FubHZ1enp2YTV5UmwrL1JuT05kOHoxUVph?=
 =?utf-8?B?cm1kcmxjdjNSMHRSbERnRzdsU1ZpL2VabHJzTTZHNGk0RHQ2cElINVJ2SmFr?=
 =?utf-8?B?aVNOWTZpOEo3b1hiZzNrNnFDY3BsU2N0OW5hY3cxTkwzTzFqV09hVHo2OVpm?=
 =?utf-8?B?Q3pTNkJjQ0V4K2FMYmIvUmYxUWsyTTdpeEg2Q2p0SVpybGJFZE5pNWVnTlQx?=
 =?utf-8?B?UEsrdHB1Mk8xbmN3cEIyaGNlZTM4N0RuRmZWOVVHdk41aDRpeU9pSlhXMXhE?=
 =?utf-8?B?RFk4NWMyQnAvYWpZQzlBMHRYUWtKZ0M1T2xLYWs0dStNblJXNHo3dnZVNmwv?=
 =?utf-8?B?dEZZOTFkWGE5cGp2dDBGc1BjczNOZVNhMHQxVnpXMEordkJiclRXYUs2YWxx?=
 =?utf-8?B?Y0VRNzY3WjhDaVhKYzhLOHRSK0pxbzk0MnpZSzViRzNyZm1QcjRic0NUMHJ2?=
 =?utf-8?B?ZlczZGpwYzNkUURVazV3TnFBS3NqM2w3dXZoWlZTUWRMaE5ibnpHb25BNXFG?=
 =?utf-8?Q?OcME7cRuvUaB4y30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CC7E01075E6334284696A72A137E0C8@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u7nIjFYSzeCIdHif7czpgtSPVfoV9HffLEUZi+OI9rVfsePovi1ufCtFuuFMz5trlo6STIbQq+tQpe1m/6DW1UKtxZ7hq19dTx9991ItIrXXIruNKyhe88ZZKnIqTspJbl7QIES79vNLQpNNGJNwoj2i7PeLQymbdiPZquHwOZBPjTcUuFAdrNzRKqk9GZMW9xulimYSy8nlsPCGDKZSI/5XjPGNC0HDWxk4RP4cJUOjQOVSmwJ6WBd/rrU+U6HJSmgKbqwX+ub5SougrS5edGPyO7zwx2wMzp+ToQ7JXKAovwtkR5Nn1vG9N7kMkhqE1rmV3/+CwUMRHX22i/8Kcg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b030e908-7016-476b-9732-08df12639583
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 13:25:02.9102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlsYD2p1xnhiMZbyjRrDLgaifT6UOf9eV4HG7zKkZKSwWZk/XFIX1I8J6/BUcp+rW/fZluFgDVjeYa5/kWprffnsqyTVmVzPYWFbqco44AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3188
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa7f5b1 cx=c_pps
 a=2kOSVXLH6HfbNZ/dWSA3qA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=KbAco4bpD1Pb2Wl7vmQA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: KPOi9Ci0WJjOATnnnscuFMYImfGS6a8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfX6thMhSADmOfM
 yGy1b5Id/zJlrsIbEvA6dSQOm/6Z9iCrL3eb7rx0WXeT1nHLcA8v1IWKp7o6A73srn2lYfJJw9G
 CEE5m/+f9QdJ8DXFqvm6n3LuOCn6qVsjyD7JbRNRRis1TOgtxgTo046zhlPPt5svJceSjGDqM6x
 kQixW9zgvhl5jo/GZOREzmlJ/JS/gp2ZiQ5vE6060oEy3MqSGhEgljAJFatz69VlrXkrWGwtCHM
 L8S9uyFlBhVIRnRnhDdvFItPkEfYtogYpnecXTYfTRg5aQrpOvX1Y+A8JxXKCk5UZ7ggG6hb5MA
 tsXvP55wS5X4m+8HBC5AJ/5l6hxk297pMaA00LZ/vBcnbeAnXcbGauOyXREIKtizgDTD5YXiokE
 4UvcCh0K/Mltfi01I8M8+SVuFvHGRHCXN8asVl6mj0MOXl1PzuH7E1PVY6evCPSWfVkOSPfqsWb
 PyA8hfId4CkICE6c2Hw==
X-Proofpoint-GUID: KPOi9Ci0WJjOATnnnscuFMYImfGS6a8e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfX9Zo/0xXWF8pT
 d/dLbttDbP4aipAxIOfA2r/STPuIV+8lYJCrGTQ7fxp2U6ZC9GWdg5R6O5678Axdm27yliXoAO7
 7TifqXTVclTHDcL3985pa8Mt6/XADJ0=
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

SGkgQnJhamVzaCwNCg0KT24gV2VkLCAyMDI2LTA4LTE5IGF0IDEzOjUzICswNTMwLCBCcmFqZXNo
IEd1cHRhIHdyb3RlOg0KPiBVcGRhdGUgdHJhY2UgZXZlbnQgcHZyX2pvYl9zdWJtaXRfZncgdG8g
YWRkaXRpb25hbGx5IGNhcHR1cmUgYW5kIGRpc3BsYXkNCj4gdHlwZSBvZiB0aGUgc3VibWl0dGVk
IGpvYiB0byBlYXNpbHkgbWFwIGV2ZW50cyBhcyBwZXIgdHlwZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3VwdGFAaW1ndGVjLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3RyYWNlLmggfCAxNSArKysrKysrKystLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl90cmFjZS5o
IGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl90cmFjZS5oDQo+IGluZGV4IGZmYmJk
ZTNiMmJjYy4uMWI0NDlhNjRhNmFjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX3RyYWNlLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl90cmFjZS5oDQo+IEBAIC04MSwyMCArODEsMjMgQEAgVFJBQ0VfRVZFTlQocHZyX2pvYl9j
cmVhdGUsDQo+ICAJCSAgICAgIF9fZW50cnktPnN5bmNfb3BfY291bnQpDQo+ICApOw0KPiAgDQo+
IC0jdW5kZWYgUFZSX0pPQl9UWVBFX1RPX1NUUg0KPiAtDQoNClRoZXJlIGlzIGEgbWlub3IgY29u
ZmxpY3QgaGVyZSBvbiBkcm0tbWlzYy1uZXh0IHNpbmNlIGEgZml4IHRvdWNoaW5nIHRoZXNlIGxp
bmVzDQpmcm9tIGRybS1taXNjLWZpeGVzIHdhcyBtZXJnZWQgYmFjayBpbnRvIGl0LiBDb3VsZCB5
b3UgcmViYXNlIHRoaXMgcGF0Y2ggb24gdG9wDQpvZiBhIG1vcmUgcmVjZW50IGRybS1taXNjLW5l
eHQ/DQoNClRoZSByZXN0IExHVE0gYW5kIHdvcmtzIGxvY2FsbHkgc28gd2l0aCB0aGF0IHNvcnRl
ZCwNCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNv
bT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+ICBUUkFDRV9FVkVOVChwdnJfam9iX3N1Ym1pdF9m
dywNCj4gIAkgICAgVFBfUFJPVE8oc3RydWN0IHB2cl9qb2IgKmpvYiksDQo+ICAJICAgIFRQX0FS
R1Moam9iKSwNCj4gIAkgICAgVFBfU1RSVUNUX19lbnRyeShfX2ZpZWxkKHN0cnVjdCBwdnJfam9i
ICosIGpvYikNCj4gLQkJCSAgICAgX19maWVsZCh1MzIsIGRvbmVfc2Vxbm8pKSwNCj4gKwkJCSAg
ICAgX19maWVsZCh1MzIsIGRvbmVfc2Vxbm8pDQo+ICsJCQkgICAgIF9fZmllbGQoZW51bSBkcm1f
cHZyX2pvYl90eXBlLCBqb2JfdHlwZSkpLA0KPiAgCSAgICBUUF9mYXN0X2Fzc2lnbihfX2VudHJ5
LT5qb2IgPSBqb2I7DQo+IC0JCQkgICBfX2VudHJ5LT5kb25lX3NlcW5vID0gam9iLT5kb25lX2Zl
bmNlLT5zZXFubzspLA0KPiAtCSAgICBUUF9wcmludGsoImpvYj0lcCBkb25lX3NlcW5vPSV1IiwN
Cj4gKwkJCSAgIF9fZW50cnktPmRvbmVfc2Vxbm8gPSBqb2ItPmRvbmVfZmVuY2UtPnNlcW5vOw0K
PiArCQkJICAgX19lbnRyeS0+am9iX3R5cGUgPSBqb2ItPnR5cGU7KSwNCj4gKwkgICAgVFBfcHJp
bnRrKCJqb2I9JXAgZG9uZV9zZXFubz0ldSBqb2JfdHlwZT0lcyIsDQo+ICAJCSAgICAgIF9fZW50
cnktPmpvYiwNCj4gLQkJICAgICAgX19lbnRyeS0+ZG9uZV9zZXFubykNCj4gKwkJICAgICAgX19l
bnRyeS0+ZG9uZV9zZXFubywNCj4gKwkJICAgICAgUFZSX0pPQl9UWVBFX1RPX1NUUihfX2VudHJ5
LT5qb2JfdHlwZSkpDQo+ICApOw0KPiAgDQo+ICsjdW5kZWYgUFZSX0pPQl9UWVBFX1RPX1NUUg0K
PiArDQo+ICBUUkFDRV9FVkVOVChwdnJfam9iX2RvbmUsDQo+ICAJICAgIFRQX1BST1RPKHN0cnVj
dCBwdnJfam9iICpqb2IpLA0KPiAgCSAgICBUUF9BUkdTKGpvYiksDQo+IA0KPiAtLS0NCj4gYmFz
ZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3YWI5ZjE5MDM4NjBjNGI0MzA0MzUxNGUNCj4gY2hh
bmdlLWlkOiAyMDI2MDgxOS1iNC1zdWJtaXRqb2JfdHJhY2Vwb2ludC1kMzc0ZjA2NTM0NWUNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCg0K
