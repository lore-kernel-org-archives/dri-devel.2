Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9CEC88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832D010EF93;
	Mon, 14 Sep 2026 15:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="VOB1f6pF";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="kbvfAzo9";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B21410EF94
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:34:51 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0oFc120844; Mon, 14 Sep 2026 16:34:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=UdkOHTLVQiUgcNAcXHl4uz9OeE6DA+yF0X3M9otaTLg=; b=VOB
 1f6pFOuCnUjQbMgp/3AP1TZd17Uw959EmL57ypYfgow1+KrGqVN9NeWgKLyC2RXP
 qxp/c/wUYkkDs4wCd/dwAzIdiFbCOOMJnFkttMJzbyZTquLs2EqVZbsULgJZeR/x
 xdob94J3wK5D9pJQw0ee4I40Wx1BtNlZsiHyRGWu3+n/8QaJjXLeqIztwoWnop14
 usZgBa2M2T/sOGoPpm6QT1FlWSV98hxfzRAJ+9TTDMBd3QOu0yHN1kYMyw44fxlh
 c8+u4i6r2IMHxJ/gadappjwpMnso3lm67DY0ApENA8KGVpDw6DKZfqjj6GxVtYBR
 NJiDWN0jyohpgw40Itg==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtuhryw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 16:34:37 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpP1dSgsfBigipXjYa/gksnCDjwOJ2TEHENw9CBCi2LRLjrbAN4tJ5x2tJVEixZl4wMyFOaLvfpEo6Zqsg9GkPq8BPRuc22LBMdbBCs75maC4euSb7djQ7CICTtEb8XRHhP4Jr3WerZHidJ7cAvuNbb6SmzSbDJHXtuHFcccS718DE+63MzVndDF0Q6iyAAx5ivepNbjZUBDJk0RrJq0ckd5BdbrGrQ8uKFPW3ZRCkO1pIVlOqjfp8oWcOQnXu5MPEpvefcGPGS0oLUfGtRolzoDAwSp8xpH2Eg1gcH0GaW4DzSBgp8pW5UQJbI7MHcvb61JK0Uu+BuKgIw03E/2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdkOHTLVQiUgcNAcXHl4uz9OeE6DA+yF0X3M9otaTLg=;
 b=LhTkOF5+3rqQIqFDGkxzfbRXRdDwXb0rTMUctETWsAY8ncFrmmbY2o8jtK73JGAHwljeMkquUb1j2bXOpRqCA7wMLQiPWesk2JwbGTnb7Gcam9ADccPITL8O76shC0u+hMj++Izt9Phf/GIoxbst5cRzYCYAMQ9eBgH1MRzkd9+qn5DEz+txuGp7yrZ9XE3YEETvzjBdoN1pHbU/rTIGiJgv/E2iCqajG9vsYOYT8mi0DS75XMUsqWvWTVKHGlqdaBlWlXj5wg3JpVZz9K29FlXW34w/qv/WhbOzVkb37RsLYec9Mk10VQGQsxQQPzOt4HbqcssIXmpRXD9GMhd9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdkOHTLVQiUgcNAcXHl4uz9OeE6DA+yF0X3M9otaTLg=;
 b=kbvfAzo9OmqwmT3g1wr6X4zdkYHUDEtMFUyip+u7KxywB4cdmKWR3L4t/s+dUZIGpsq+tQAjebqfSRD2ZSfL5HezhDpAt+vYCNtKDAfjvgxe2dgP5448E2lP+2fzRD9Po+7W3isao3J9V32dSX0/M1fYBDG9cztfOGI64VDaRx8=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOAP265MB9208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:34:32 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:34:32 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: clamp freelist reconstruction requests
Thread-Topic: [PATCH] drm/imagination: clamp freelist reconstruction requests
Thread-Index: AQHdRF6KnOWnyN9syk2EJMF9Jo+U2A==
Date: Mon, 14 Sep 2026 15:34:32 +0000
Message-ID: <86ca80fdd4d3d25bf2c08977e2ad961c5add7ac6.camel@imgtec.com>
References: <20260813152759.35856-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260813152759.35856-1-pengpeng@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOAP265MB9208:EE_
x-ms-office365-filtering-correlation-id: 38c92a95-1e1a-4520-d050-08df1275ac9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 0pYeiYMGxHudh9vDrlmHoEmSfGBFaVoU1gOUybSCmkGAzxzQKsrOMmorWjZFNO9YVKfyD+OBTybM8QlrrEbffRXRtD5zRbICdDgWbdG4jSl1APmtVTxkhdq7uiwDuQTdQl4rkmphcO1zGxDJEFmBtajUC0GDEZcXF45vgjVBRI397Nkn1nBGsQMzY6FZ4IzD51RHjxONBAKHy46XQ+4uj8jKm+lHp9al95isWlnn70g5qo8mP/E1ZTXD2MCy6cH2Vay3m3UVPfp3k/17P7IiGEf7rJhnoQLKDPrQMSOUhFcig9ZJPGioLdDRfX65dxfUcWA0PMtESUY9ipQ9pbR4QUZI/NoN78XCRhGUmVjSvrGOBR4FDGwHKtC0gRoUVD+WoNuSkzrPubBwIumeYyZOQD+j6H9iVTDG5xgB2IF5potKhnH8Jqdd2lKxReaKSe3kCtTbwQz3yeE/tYF8cNmScd5wCLUgOIFxCP+kNW2qYGut7a5j9zAUB5V9T6E+Gliuy6t7w3YtIUD0wy1KcC1PSZkUXDEWusik+1Y4Q9Un2m7I6/p7eU4/jiiRGgj79vFT4JFv2QP+GYlalSNOzLKPAYro/WcrRAmTdhNkJMYYdc0RL7PzO78XZgdyJZCRpRpt/E9chzinKbLyL8LW5q8/cRJWHv0t/KMAdM0Nj5KW1DMp8cJZM6gToKEwyNroIjrxLySmcdSzM07htCZXfhoXKaInOneGreJ1P68Nma68+XE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVlQczVUbnRrKzZiMEsyV21aaEp5ZmNLdGRpZE4xeVFlMFNodGZyVmlUVEty?=
 =?utf-8?B?RVNIMUgvcll6M3hyZjRCOENBanFHTDVRLzlKUHBuZ2tMMlNVR21KZDFZS25o?=
 =?utf-8?B?aDVONklBTkJsM3M2endLNTg0c0dMRmNnSWxNUEhJQlhnZ1ZmSzNQR2pFdDNB?=
 =?utf-8?B?TU9walExV0dabk1zUnhEVG9LTFhaZlAyMThOTENUamlYV1pEK1d0cW5ueGF4?=
 =?utf-8?B?SGM2OUt6VGV4SDRja0lZWmFkcWRUd0FqbDltaG5UUkdyWXNiZVRoNzdLSVY2?=
 =?utf-8?B?WHZidWpvUkorMnFRZW5rNTVHd3BXNE1FeDgrMElqN2VSakRuYzRQWmhoUjZi?=
 =?utf-8?B?d2k2VWdNc2NNMnJ3TXhWanpYNkR4TTh5eFB4VUQ1RTFRNmlrWi9pT3gwV0hu?=
 =?utf-8?B?UWxWZ01oekZ5eHhkKy9GWGhPakVUNzIrSzNOeU9PU1ZiUUxJQXNXZzNpRWhr?=
 =?utf-8?B?d1ZsTng4cnd4Z3RCaWV0V29TNUs4M0prOFdON1VyWWVXTkdJeGhXQStMNHVz?=
 =?utf-8?B?U0NEUzRKY3BKdVcrbWNwQVdYRmhvMzJ3MFZ2K2dJa092bG1sRGF4bXpEaHM0?=
 =?utf-8?B?YUtxaU9qaS90aVFJWUI3aSs0LzhPY1B5azdoSlBUakNOM0tKWEpIVExQOEE2?=
 =?utf-8?B?c084TkpTQk82MysxVWxTN1dmOTd4TlZQcWVrTklXL3BtUDZlT2FyRzF3Y3lE?=
 =?utf-8?B?QTYrWVNMUmZoQlU3SUY1MXZqV0locVY1bDZ1Zy9QZjdxeFN2bHBpUXdCaHlv?=
 =?utf-8?B?cHNRZkQ0NVFsNnZONGVRVmc5allOZkVjUTRWYk9kSUFWZWNjZzdUTHg3enlP?=
 =?utf-8?B?b0YwdzVqU0d2YXBETnBtWHpSSm5DWjFWRE96eVBXU2ExckVBbU96Yy9GTzNC?=
 =?utf-8?B?WFlyMGRJNy93TXJ2OWEyTGs4Z09PSGVoNWZtRVlVT0dyZ0xaeGVqcTM1VlBD?=
 =?utf-8?B?aVNOWWI5WUErYWVBZXlrYlk3bkljaXZYUDUxeHhSTkhQQllMcFNuWGY1cDdR?=
 =?utf-8?B?cEQzKzAxa3VaVzl5M1NVWEFxWE80V0F0bzVZU1ljeS9CaURMbnJyN0lZZ2w3?=
 =?utf-8?B?UzlCRUVHMGQzWTl4RkNWc1dndkNUd2pRQ01DeFArWWhPaGtTUkR1NjJaVWhJ?=
 =?utf-8?B?ZXdOUW5ZQWJhZkx3TjdBVWNLekQ0RTF4MVdTckpxYkozSnVncms3M2ZZNEsv?=
 =?utf-8?B?VzZ2M3kySnB5UWdvL0ZKZ1oyM2R5SFdSa2FLeC9adHYrdi9KenJmeHFGREMv?=
 =?utf-8?B?dGQvMVBjTzhNR2pSRTk5V3pNVHhoWVRCV3crZzBXNUpDLzVKT3pEdkRrdUE0?=
 =?utf-8?B?a3FHQnA5ZHllQ2pRbld1NjV5QkZpVkxCT0RiM0c0VHBnTG0rRTg0cFIyZFRT?=
 =?utf-8?B?clhTZ3dlWWRHWCt1ZE1ZQk5wUjh2VG1zMG5IRWovaUxycHdUcGlMRWdRKzlt?=
 =?utf-8?B?cVdRVDlMdWpEZFdMMjJGSnNWVElTTzJsZVkwYXhDb3JrOU84R1AwQWZtWEdz?=
 =?utf-8?B?UWRqcDNiZkxLUFd4VW51MHFUU3IxbWZsTTJVK255aHZpamVYaUxmRnJFQTFi?=
 =?utf-8?B?dktqYStlOXE1Z1JKQlJucUk4b2pyK0ZtRlV2YTB0SmdYTitGdlZGUUoyOTFS?=
 =?utf-8?B?emZ3Q0EwYm1IaWFRSFgrK0hBWlRxZmVtdGdDSjRNTTlhaUNIK01JK2w0eWtX?=
 =?utf-8?B?MFJUTEVwM3I4ZW4wWW5DckNlajhuT0YwRDNvVDFiT2VrMVhxc0oreWZWclpk?=
 =?utf-8?B?cmRBa3pnSXMrVUhTQmdXYWlEZEM3c09GaEZ2Nk0wczJuUktLalE4Q0p5UEhm?=
 =?utf-8?B?b05NNDRBU1BEM2xMMUVTeU1XTS96Ymp2ME9yLzV3L2JqR1lBbngwbENyRlBG?=
 =?utf-8?B?dFJpeExXU0JZcjZUMXFyVDZlMGdpQ2hVMmdJTHdiTGV4RlZEQUh2Zk1iUVhH?=
 =?utf-8?B?L0pucy8ySFp5L1JxRENjcXFrQ0I5QlZIdHloNGYwcm45R0loUHhENkFGeWRV?=
 =?utf-8?B?aUxYN21JZ0JudXVvdWZOYjQvRitzcFhUcVVGZjIzdHJjK2RwcndUY3YvYzlZ?=
 =?utf-8?B?d1NXdmFrT0dXQjZCVzNoZ05iL29CZTlDYnY0bklrMklJbTNnT21GY3EvSk5m?=
 =?utf-8?B?YnVUUkJNL1ZqVDBsNm5ubXhzWGIzU2pXL2Vvd0JPd05oelVmU3BhOUNqWC9C?=
 =?utf-8?B?VHU1bXNJcjhxT2dzYzhBNDN6cXg4cEhXeHRqQkVZRmVwWS9wU29JN2tYYUQv?=
 =?utf-8?B?ckpPLy9MQlpTRytoR1VtaTBDOUd5SGtmU2pudmlEek1Vc0R6cWFCUTZkMjRv?=
 =?utf-8?B?TlltVExQenJjRlZ1SmhRWTVhTStXSXJJUTl4RXlTQ09RMzkrRjZNNWpKa3p5?=
 =?utf-8?Q?bVWjLp/nF5WA4Q0M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0F2B70DA24A5A41A4ECB54FDE50563A@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xWwhr1LkZ7lDu/OzQyVKnOnn+qELkjklbei9CEY0FWzJKNZxzvTJMOEjXyhhUmh0WW32k75oYrSTpwbpRhfvfofrxKdY/ipzIa+m99D9edWjdOTO8QQdEK2m4PU7SkxpBQpBsMX+StjeUJX88P57XRwAUR3pQIA4GV2tXBY5GeZqQ2BF/05aTx94vDF43FMl5KVjzLB9/zVV6nzzJlQw1HgEFQUeiopDQTSxlLHUNEwtN9dYgVNzpV7iOqJUcbLgce4CUlPr/GraV3eprgaI+26tOZOXe0eBpuaV4zjPoYMlTLjiZImKY0NRLTPe8hmwM8DyKMAbJn7yMUJd2JZpIw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c92a95-1e1a-4520-d050-08df1275ac9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 15:34:32.6300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JZHB1KGdzHiTt9alIcZ3ZskRub+9nDLPG2NzbIOhqCPs2D5RPCK4KL6K7P42+If9m9LjpvfDP+f3XmHVexuKSy3zWlRAJsRknsTxUEQAto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9208
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa8140d cx=c_pps
 a=OjXkuQQm0AP+IgRToencdg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=k-2M-my9udMEBF9gLdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3-MuHeew9A71VQScNnfiRNUDtok2nndj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNCBTYWx0ZWRfX/iYP1zRxh6pJ
 JLKbHLA9YWZ1XLhhc9wLrcJESi/p/Rz0yNoGLXysl3wX7zy8IlsCLjwXdYbJSuHPBkrB645VLei
 OuShdbp1tLTvjXY1EhPdcFKtw1gZ9f9FBaSXw8KsUpj58/9mTawhS+IR4Y/ZTC7kS2Yo1FGXUrd
 54YF1CKNgSXqoLjnA0KHv6w2Qngfe0fSK3uwmPcJEvJgPw+N5ovUM00qF+ghdvz7Z8EM901hCLy
 t5JQPU0mN6SBHO9JFbhpRVrnMRwTIbmkK6rs3kIRJoBb++p8DENIelgOA8Zrfr9vQgh18f8tp8B
 iExKIxdy3BHyJYUPHwILzOgr9EeZ8h2XXS+jzdT0hI5bnIqQFTE4KhrX+G6192g4jd3r1vdKcut
 90kBG53SNU19Lbu8FbNmKYriuJhcP415LGHtCAvlC0Rl8SxSLBPOgCBnrFe/8CYklQUwF1+GCoJ
 STKTCJmZdxlMoXXiHng==
X-Proofpoint-GUID: 3-MuHeew9A71VQScNnfiRNUDtok2nndj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNCBTYWx0ZWRfX753s2P66V2rD
 UPFxh+rJpnOTSkj5Yb+OtgTZxccFfIM8lA0gbbxiTb8LRDScbhG9dBXNzO8p7Vaj0M2eA2MFSdf
 z4s+uyMDk2kMFlDI2ZhDXfm7vxyF2Rs=
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

SGkgUGVuZ3BlbmcsDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaCBhbmQgc29ycnkgdGhlIGRlbGF5
LiBBIGNvdXBsZSBtaW5vciBjb21tZW50cyBiZWxvdy4NCg0KT24gVGh1LCAyMDI2LTA4LTEzIGF0
IDIzOjI3ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+IFRoZSBmaXJtd2FyZSByZWNvbnN0
cnVjdGlvbiByZXF1ZXN0IGNvbnRhaW5zIGEgY291bnQgZm9sbG93ZWQgYnkgYQ0KPiBmaXhlZCBh
cnJheSBvZiBST0dVRV9GV0lGX01BWF9GUkVFTElTVFNfVE9fUkVDT05TVFJVQ1QgSURzLiBUaGUg
aG9zdA0KPiB1c2VzIHRoZSBjb3VudCB0byB3YWxrIHRoZSByZXF1ZXN0IGFycmF5IGFuZCB0byBj
b3B5IElEcyBpbnRvIGFuIGVxdWFsbHkNCj4gc2l6ZWQgcmVzcG9uc2UgYXJyYXkgd2l0aG91dCBj
aGVja2luZyB0aGUgcHJvdG9jb2wgbWF4aW11bS4NCj4gDQo+IEEgZmlybXdhcmUgY291bnQgYWJv
dmUgdGhhdCBtYXhpbXVtIHRoZXJlZm9yZSBtYWtlcyBib3RoIG9wZXJhdGlvbnMNCj4gYWNjZXNz
IGJleW9uZCB0aGVpciBwcm90b2NvbCBvYmplY3RzLiBDbGFtcCB0aGUgY291bnQgdG8gdGhlIGFy
cmF5DQo+IGNhcGFjaXR5LCByZWNvbnN0cnVjdCBvbmx5IHRoYXQgYm91bmRlZCBzdWJzZXQsIGFu
ZCByZXBvcnQgdGhlIHNhbWUNCj4gYm91bmRlZCBjb3VudCB0byBmaXJtd2FyZS4gVGhpcyBmb2xs
b3dzIHRoZSByZWNvdmVyeSBjb250cmFjdCBjb25maXJtZWQNCj4gYnkgdGhlIGZpcm13YXJlIG1h
aW50YWluZXJzOiBhbiBpbmNvbXBsZXRlIGJvdW5kZWQgdXBkYXRlIGlzIHByZWZlcmFibGUNCj4g
dG8gYW4gdW5yZXByZXNlbnRhYmxlIHJlc3BvbnNlIGFuZCBnaXZlcyBmaXJtd2FyZSBhIGNoYW5j
ZSB0byByZWNvdmVyLg0KPiANCj4gV2FybiBvbmNlIGJlY2F1c2UgYW4gb3ZlcnNpemVkIGNvdW50
IGlzIGEgZmlybXdhcmUgYnVnLCB3aGlsZSBhdm9pZGluZw0KPiByZXBlYXRlZCBsb2cgZmxvb2Rp
bmcgaWYgZmlybXdhcmUgcmV0cmllcyB0aGUgbWFsZm9ybWVkIHJlcXVlc3QuDQo+IA0KPiBGaXhl
czogNmVlZGRkYWI3MzNiICgiZHJtL2ltYWdpbmF0aW9uOiBJbXBsZW1lbnQgZnJlZSBsaXN0IGFu
ZCBIV1JUIGNyZWF0ZSBhbmQgZGVzdHJveSBpb2N0bHMiKQ0KPiBBc3Npc3RlZC1ieTogQ29kZXg6
Z3B0LTUNCj4gU2lnbmVkLW9mZi1ieTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nhcy5hYy5j
bj4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdGhlIFJGQzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjYwNzIyMDQwOTQyLjg1NDU5LTEtcGVuZ3BlbmdAaXNjYXMuYWMuY24vDQo+IC0g
aW1wbGVtZW50IHRoZSBtYWludGFpbmVyLWNvbmZpcm1lZCBib3VuZGVkIHJlY292ZXJ5IHBvbGlj
eQ0KPiAtIHdhcm4gb25jZSB3aGVuIGZpcm13YXJlIGV4Y2VlZHMgdGhlIHByb3RvY29sIGFycmF5
IGNhcGFjaXR5DQo+IC0gZGlzY2xvc2UgdGhlIHVzZSBvZiBDb2RleA0KPiANCj4gVGhlIHByb3Rv
Y29sIGV4dGVudHMgYW5kIHJlY292ZXJ5IHBhdGggd2VyZSByZXZpZXdlZCBzdGF0aWNhbGx5LiBU
aGUNCj4gY2hhbmdlIHdhcyBub3QgdGVzdGVkIG9uIFBvd2VyVlIgaGFyZHdhcmUuDQo+IA0KPiAg
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mcmVlX2xpc3QuYyB8IDEzICsrKysrKysr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZnJl
ZV9saXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jDQo+
IGluZGV4IGU4NWNhYzgzODM0Yy4uMjNkYmMyMjdiMDgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9pbWFnaW5hdGlvbi9wdnJfZnJlZV9saXN0LmMNCj4gQEAgLTYxMiwxMyArNjEyLDIwIEBA
IHB2cl9mcmVlX2xpc3RfcHJvY2Vzc19yZWNvbnN0cnVjdF9yZXEoc3RydWN0IHB2cl9kZXZpY2Ug
KnB2cl9kZXYsDQo+ICAJfTsNCj4gIAlzdHJ1Y3Qgcm9ndWVfZndpZl9mcmVlbGlzdHNfcmVjb25z
dHJ1Y3Rpb25fZGF0YSAqcmVzcCA9DQo+ICAJCSZyZXNwX2NtZC5jbWRfZGF0YS5mcmVlX2xpc3Rz
X3JlY29uc3RydWN0aW9uX2RhdGE7DQo+ICsJdTMyIGNvdW50ID0gbWluX3QodTMyLCByZXEtPmZy
ZWVsaXN0X2NvdW50LA0KPiArCQkJICBBUlJBWV9TSVpFKHJlcS0+ZnJlZWxpc3RfaWRzKSk7DQo+
ICANCj4gLQlmb3IgKHUzMiBpID0gMDsgaSA8IHJlcS0+ZnJlZWxpc3RfY291bnQ7IGkrKykNCj4g
KwlpZiAoY291bnQgIT0gcmVxLT5mcmVlbGlzdF9jb3VudCkNCj4gKwkJZHJtX3dhcm5fb25jZShm
cm9tX3B2cl9kZXZpY2UocHZyX2RldiksDQo+ICsJCQkgICAgICAiRmlybXdhcmUgcmVxdWVzdGVk
IHJlY29uc3RydWN0aW9uIG9mICV1IGZyZWVsaXN0cywgbGltaXRpbmcgdG8gJXVcbiIsDQo+ICsJ
CQkgICAgICByZXEtPmZyZWVsaXN0X2NvdW50LCBjb3VudCk7DQoNClRoaXMgdHJpZ2dlcnMgYSBi
dWlsZCBlcnJvciBiZWNhdXNlIGRybV93YXJuX29uY2UoKSBpcyBub3QgZGVmaW5lZCBoZXJlLg0K
Q291bGQgeW91IGluY2x1ZGUgZHJtX3ByaW50LmggYXQgdGhlIHRvcCwgYWZ0ZXIgZHJtX2dlbS5o
Pw0KDQpBbHNvIGNvdWxkIHlvdSB3cmFwIHRoZSAiaWYiIGJsb2NrIGluIGJyYWNrZXRzIHNpbmNl
IGl0IHNwYW5zIG11bHRpcGxlIGxpbmVzPw0KDQpMYXN0bHksIHVwIHRvIHlvdSwgYnV0IGlmIHlv
dSByZW1vdmUgIkZpcm13YXJlIiwgdGhlIGxvZyB3b3VsZCBzdGlsbCBtYWtlIHNlbnNlDQphbmQg
dGhlIGxpbmUgd291bGQgc3RheSBiZWxvdyAxMDAgY29sdW1ucy4NCg0KVGhhbmtzLA0KQWxlc3Np
bw0KDQo+ICsNCj4gKwlmb3IgKHUzMiBpID0gMDsgaSA8IGNvdW50OyBpKyspDQo+ICAJCXB2cl9m
cmVlX2xpc3RfcmVjb25zdHJ1Y3QocHZyX2RldiwgcmVxLT5mcmVlbGlzdF9pZHNbaV0pOw0KPiAg
DQo+IC0JcmVzcC0+ZnJlZWxpc3RfY291bnQgPSByZXEtPmZyZWVsaXN0X2NvdW50Ow0KPiArCXJl
c3AtPmZyZWVsaXN0X2NvdW50ID0gY291bnQ7DQo+ICAJbWVtY3B5KHJlc3AtPmZyZWVsaXN0X2lk
cywgcmVxLT5mcmVlbGlzdF9pZHMsDQo+IC0JICAgICAgIHJlcS0+ZnJlZWxpc3RfY291bnQgKiBz
aXplb2YocmVzcC0+ZnJlZWxpc3RfaWRzWzBdKSk7DQo+ICsJICAgICAgIGNvdW50ICogc2l6ZW9m
KHJlc3AtPmZyZWVsaXN0X2lkc1swXSkpOw0KPiAgDQo+ICAJV0FSTl9PTihwdnJfa2NjYl9zZW5k
X2NtZChwdnJfZGV2LCAmcmVzcF9jbWQsIE5VTEwpKTsNCj4gIH0NCg0K
