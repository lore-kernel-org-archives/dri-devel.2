Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C0CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C17110E3F2;
	Thu,  1 Oct 2026 14:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="JVPZZajg";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="j0PK+VmL";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E413D10E3F2;
 Thu,  1 Oct 2026 14:31:28 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DbgSA3120456; Thu, 1 Oct 2026 15:31:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=P5HTl1G+wf6elRlYHoIpa6aBw8Eqx83NGkCJwV+3UIg=; b=JVP
 ZZajg83v27UlIP4SRw7oxffl6MZ1yVeCgidilNdrq9sCGhcshp+aPCBMmEY5sevB
 +ASaI+uu2W/biReyghFErtDb/5zJU13amuvAzJ/iUbDBHJvohIX8n+2hRSavVKTA
 DzJlSZMcKF2pkNwfgTEnl7q+KtcHGF14UaPgd9BwzV6MQnkDVwo6IoH4oSorIdAJ
 G5QNSEccjwtEPBft5pZQpfQ6ChruGD/dk7td5crM68Bbf9+/qVZW0eu3MIPVKu9B
 LW4JinMuJkibsUck9TuoTS+Q7gM+76kxJkYoznGnO0IbM888LU+DHuv9B2hOSyfd
 O9oAJv4sZMBkdpfeLfQ==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020136.outbound.protection.outlook.com [52.101.196.136])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gx4as45p2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 15:31:13 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZQ2YE83Lgy8HOJqUorhd87GV3d7CBq2YKNqkLzfJi/DNNnPEe+vnsE87/cjkfDSyDZ/yVC6aefMDe0PTj1UTPpwJJxRdJAWxzZCDgT7zJHXbjim7DfkSFkOhdfmoFSkIf77N02/KR0vc3JMmjZM40G+P6RjPwwNKAEqt3+LkZv2jqA+sQBTL50UrNwCwarcPjbDrG9M9G0J3ZkOKhFDbVO+zZZPdsahfgIPTx464g4s4+zqkzvGtCx9ki9sG/NQ0VzDRPUngSb2PC7v7Yex0mUOSmLgN1xV4SoiDsQrt4Mm/EKOo+qit+7JSqGI02ZGFk6lBLYXuM8Bp4Sx4D+Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5HTl1G+wf6elRlYHoIpa6aBw8Eqx83NGkCJwV+3UIg=;
 b=iDEq4QDSQ8WmbXjrbkNf/7wK7RAvWtE5ROnQwMF1tDmE8j9SPDv5mUiI5kSJAxO1Ms7TjWm3SZ5Edzqm0wnoYXZgCBlvim6++qdf0lgnmQ9Y1rU/nzFCCVFCVwIOMFP+1sIluwsmkov++zNYoAmzJF7RRWJnrSHZp2e5ObjAQM1YIcvVrfm23foJCwceDV5416yPmE4IDB4WYV4h74IPafcPU8PzYYsolTld96XBAk0mVgBmADLiwGU5nOjR3mvaOAQrbnuy3vNZF+s6slLpX6Owtb0TXi9wFKFxWOZzLQ/2ybTVgmbnihAec77yZq/+VNlqD8oX7TvvGFoFGBnioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5HTl1G+wf6elRlYHoIpa6aBw8Eqx83NGkCJwV+3UIg=;
 b=j0PK+VmLkg3DfxaX/kQbB3T/ymkClqIr5ixb6sxwqy2fZ2ZZ0d1KmTx1FECgY/d5M4DEHWaJsrZeJ5wqknlD27d2zm18UEIiqJzvmT6N1suLAkaRoN2lgrLZ6bqJNDZsxPswCZbSx/dVIwU81Z71SFx4uQdN4+gowM9Oop5mN4w=
Received: from CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27e::15)
 by CW1P265MB7926.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:31:08 +0000
Received: from CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d42c:82bf:d426:2147]) by CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d42c:82bf:d426:2147%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 14:31:07 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "gye976@gmail.com" <gye976@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdUbF/KpkaDyovGk2sEA/rQdapbA==
Date: Thu, 1 Oct 2026 14:31:07 +0000
Message-ID: <0e62e6395ca0ea1c0cb6d5f973eef05a57df2136.camel@imgtec.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
In-Reply-To: <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CW1P265MB8667:EE_|CW1P265MB7926:EE_
x-ms-office365-filtering-correlation-id: 9ee7b192-9371-42bc-b055-08df1fc8a1ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|376014|366016|10067099003|56012099006|6133799003|4143699003|9063799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: oo0F9bU9HGGhHc62xF+l+XlX5TFAB+XO2TRgeyHH8eL8tiToaw2hQ7RCr4Ug1VIiBWfs/jCtB8Cl0k8mc53kIH9xonXqHw0u6yxDkPU872TqA8OsKnxK1eK4gN3MuQO3uiTnf5Wjc/+WgNCQQSXwxA8UsQoe9qRGYFLRHz36Aa0qjyrYldkw74xAacRRPL7Wb7/syj3ZyBFbIOa5mL26HYdmH8TD8mcbkj9LJOneyI7FoQs+crfpox3UJ0fmZ33XvPHTiSv0hcjBXRlkirUJPmkVOxiTwBEwHJimEB8Zc8rvDuT+HQiUrIAij6PxKzNzr2Wlk8IwDp1dK+TjPrrHDYnBypv37mil+iUdtZTiudbaALsBNCv/9BocJk3KGNc8tA4MWkgWZ2mutDoFVK6pF4jeMM0fLtjnp0QSuxs+0xEz2flWer3IUqV1uG9oG42dBCgeqxnzroTUtzQoo8Ifl7YcJtRnwGIsICmRuF+FxJCHjsigGHHNbJ4mrLacyv69Ad3/M620nT4ARn9GGQT2Q5JH+ituB08XS4yAvanfLVYDwJUkWF64/3Wvri5HvNvrqXp4gmxzCHXF7Ba4v5V6AVnkki5JS3rzSshJhCvtRqXMXr+HahPnUjUd6eimt6V89CODOoRQTreYROWcuVq3Ktplh8tMigzzlf3Nl2DMH4eYoR/7df+MNk53rP9dlVewA6byWyIsDCS6BdDOaCORZHFoO6cqIWEbFT5g6UVUZBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(10067099003)(56012099006)(6133799003)(4143699003)(9063799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmZCMlFkRmp2ZWo0VW10U1hVSDQ5cW13bHBZS21aRmtZaXZzTTUvb2dNSUZ6?=
 =?utf-8?B?NzZYSmN1UlErejVuQ0JlRWJSWjUzK1dVdFkzYlR3dGdaR1pUcFp2a3FWNDBG?=
 =?utf-8?B?cE9BMVVXdTVqZWpROTJoWXNLTDlqaUQxT29zTE5vbEdmYm1lamRmTmQ1eEYx?=
 =?utf-8?B?cVBDVVhvNkVEblJvZFh0NldaOWY2WFJMdVdCbWl2aWdpM3NyVTN0QTk1Qjcy?=
 =?utf-8?B?QkhUKzk2MGJ0S241ZU5xWStDVWZVQW02QnAzZGNhakppQVZoWnBCY01aMTVH?=
 =?utf-8?B?YTFNbXFtWk56V2dvK0RQUUEwUSt1RDZHeTl3UGVNZVlDWk9JT2lkeGE3SWdS?=
 =?utf-8?B?Q0tXbGpUaWlwUzlQWTRjd2pXaVd5SC9OSFU3QWoyblZGODdYeFcyNkZpZVR0?=
 =?utf-8?B?Y2EwSVBrYnV4QTlDZDl4bzQ4NEtOeElhbjloeVFWblFZc3RMRlJHTU4ySy9n?=
 =?utf-8?B?NWVhNGVocml2UUJIdmVFRVVJU3NBYTVLV2ZLd3FDUFM2aVFTSVE1V3d1YldY?=
 =?utf-8?B?d00rdWRzUGg1dms1dlJtYk5FeDJrZUN2eG5hdjhTSkJmVGZOc0Zva2h3NUNo?=
 =?utf-8?B?ejZFWkhjVjlEWG5rTlQwb1NlTnlOMzM2dzVxL3F2dVVWbG9EelZzcDBUM05F?=
 =?utf-8?B?dWM2V0Q2c0p0aG1aaUNMRjJ0OUFBY1YzcFQ3NU9heW9tS0VyTk9iQVAzT1RL?=
 =?utf-8?B?UU9FNldPV1l5eFBHQ1ZNMnkyWDJNU2JLeWZZQjBUR2tFV0EybzQ4ZnVNY29w?=
 =?utf-8?B?eFl5ZTBVQXJMWThvTDl4dXh5YUl0a0VVS2JERXhKcVhnVWJFSWM3UDZQN0NL?=
 =?utf-8?B?UEhIbFdBUFFJY0cyeXo4VXpUYXdPeWtBRVNCQkN5SXdZOFcvSG51RmlIZ1lM?=
 =?utf-8?B?ZDlWckhQRnA2clZEa2plaG1saWhSQVk5OTVuNURQaGpNZW5mdytYaXBLdHI3?=
 =?utf-8?B?b0ZQSXo0aG92UXE2N2c0M0x3aHFOQmVicThDckUzb1hVYzBzeEVORHJJNVFm?=
 =?utf-8?B?Mk9tVlBRR253b3VRa0hnbG5XTzhWemxheTRFQnhVTWZwdE9QVE9uUkNXb2V0?=
 =?utf-8?B?Z0dOVlg4UzlCYVFzMHU2L2s1ZEFWa21UcWtOMjR0aks4clBySTQ0ZlQ3NmRD?=
 =?utf-8?B?Vm80RytuRFJCeFhOQ044MDdpUmtqenBlTzl1dGI1ZCthSGpSaDM2SlpOUXpY?=
 =?utf-8?B?STJEeVZIbG91OHdhM2I4QnlaSGZkVUw5aEI0eDN2K1lUZGR4OXY3U3hPZ2Zi?=
 =?utf-8?B?NC9OMENla2thd1Z0YnhSZzZjbFVFd1hIbVdydUlyK2MrRlNiWjdRV1NINDh6?=
 =?utf-8?B?dzVTcEd6Y2pvUHNkSXJKckthZE1FSlNhVVQwd1c1aFlZeUpyNlJuSzZNRFZ3?=
 =?utf-8?B?VUYxSmtDRGl5Q0RCd25FSmtTdlVBMkF5aTlwQ0lHQTNMYkJQN0p2bnhueUJ6?=
 =?utf-8?B?VW5tREpwUmpxdFBpQmdzcDJCaVFmemFlUHA3aHpmS3ZoK1ZFZmM0ZGRxWldE?=
 =?utf-8?B?K3RuSXBwM1NXS0htNjMxS0J2aW9DRkV5NmdBVUIrV2dMaVk5S0RWcDVCODJj?=
 =?utf-8?B?QjBtRWFjaFFVM0dMdks2TXh3MDZLbjZMVStkWk1LQlRyeC9wbXUvMTFZMEFu?=
 =?utf-8?B?dGVMd3lpcXBLSU5UZ0p1aUhlYkpBSmFsQjhManJEd29PN3Q5YTVwMTduaE5P?=
 =?utf-8?B?MDZUck54bkN2K1dCbnRxcHRKV3ZCSDhubDBtMlFZR2poSGdqRmhtTDJGQ0s1?=
 =?utf-8?B?SjZaVi90UGo0bWVyZGU5ZUFwMStheU9VWW1Xc0dVaDA5aGUxUXpkemNIN1hG?=
 =?utf-8?B?ak92Um9BQXNmcFE0eTlOQlZLU1N0RjFMakdmREJKMENYeWZ6UEdCR0g1U1lX?=
 =?utf-8?B?clpMWlQ3UEJjTEc3RmI1UUFTQTFub1o1c2hKb1prSUNCaXZ5U1Fwb2hubkNK?=
 =?utf-8?B?RVpVZFdoMlZBY0hOa2pXeXlyNXVIak44UXI4VG9aeGdYU0FHZ1NuMXpTL1d5?=
 =?utf-8?B?czBuNXdCMkNwbEoxQlJJTWlGeEVtSGo1WitIMTRlbFM1VlFrNVRoSU51a3ZV?=
 =?utf-8?B?OEJJZmJtQ1M2cDhNNUNrbWdiWm5oNHZYQ0dpSWlBWnB2OHdlbU53ZGFsWTRq?=
 =?utf-8?B?Y2FPSTVEd1gwY3d6eXVIUkhDTE1VNXlqYXVTOWI1Y1BqWFlOTW4xc2ZmYXJU?=
 =?utf-8?B?Tlp5WnRNQ0hyaHJ3c0x3T1dlSFlOS1hUVlY0UzFLUzFTTE1uMjg1RVUwdlVt?=
 =?utf-8?B?akgvRDU5UXQvb2ZFYnN3QlhQaFQ1L0t6eGY0VkpzMGMxM1I0TiszM3dobHBO?=
 =?utf-8?B?emw4VlNNUnFoZGdmWTg5c0tVRGdlaElqUkZwc2RhdXE4a0h5UmtJUmx4alhG?=
 =?utf-8?Q?0rdDdqL4+JaTlWpE1V9W3s617p3I0rEMFyjKcw35zEdgU?=
x-ms-exchange-antispam-messagedata-1: WMkj/irlp8LZ3MWdIXujydgejCvpDJkR6qE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0165317FF35EF34992132E5D79344488@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ibel7XnZVTYNkAhOiamnlGJLGzKzA47oeg1BfQ0TlGudjhhMdj+6wKW9Gxb2qkokBtYGF8dmu6h7+VFNnvI0rXKGxCtU7PqtauyfVlCuwDRan3flhSjTGgLUtBkuB3FDPF1uzHZuSG0ku10r+FwT+7Q/l/ZmSuvnX8Mp80fXiG4AkzDk3s5hIAL/mZsW2veERIZ3HkrgH8DZaEpwXBvWUTlnX6qIfyYWwcGqGPlmBlyvMHAdweEyBzchJrcpLCwGj/KmwtSBcA4CQRyJ9ZJ/fK152k8RrBEhjrDlsar8diNgZ7hmHeVpnpY8pK4sokLLEpvk1kjoa5LEmsA1gzcsJA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee7b192-9371-42bc-b055-08df1fc8a1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 14:31:07.8220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxoROl4qA6gd8D7UcU6zJNQ68Uozvl5tBf0snnHeBgl0SXLqC3ifG1KIvz74ON3JAdz6xMC/u3+8Cfp8sAeRN0oG/+PO+0nwedVqHLg6T7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7926
X-Authority-Analysis: v=2.4 cv=BPomP1QG c=1 sm=1 tr=0 ts=6abe6eb1 cx=c_pps
 a=LJcX30EIWiR+oGJ2guYx6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=pGLkceISAAAA:8
 a=rVyTQKPRZ8r4_9Q1FsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oRIQ3wzY7l-COAP2QOk4DafJQ3sxiy74
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfXzD5z9D9h1yON
 Jex6JaeVPkTyRxw1Gq8YfiSHWdUiz8V6AfzFdVf8fZLl18Evq5VLTiZ29WEnS9Wyw+lNvfqA5l0
 QuGmYCftXwmku5ZDlN1qsj/vbm2fqr8=
X-Proofpoint-GUID: oRIQ3wzY7l-COAP2QOk4DafJQ3sxiy74
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfX4gyNEleYlZxd
 jpkslU5ak8edbxxkrKlqYeZq/dXxvBDC7kf7W8Fid+PpzhvM+qw2bF7rTNnKj+rBxoizoskLltc
 ij2LXOQ4iSIBdC+kz6vWEjkRvqpKX62VdjkN/yBJdoGbddAbwm0AHe+/+mbOJfoh5w/v3eo21VU
 o/3W/hVKJr+p6n/8cBZlXlxvlKJSWeyM6Nt41YrxqMzmENtLkO2nFgWmJsE9LdeNhfYGiy+8V81
 jNmQVBimVQhWILUHyMAXl3/OhmLq0yOl7mZFQ2xsKAtryYPEgTQfTJo5UV6M457maoAZuM7sCb5
 k2JMaWF4u9JTZOOGyVLsvYnppwDBoGuvK+yPjo3wzBTdDG5RyEVSBfOAg09c+R02314xbj0vGj7
 QhdghWMpzzub+r3pMX/HtGg/KdJM27bLb7BnfJpqwfxqVaXg8zgR+3h1LyEp1v3BR4hKLaTUo6f
 orpq2HGqcPIZnHDK5tg==
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDIyOjM5ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
SGkgR3lleW91bmcsDQo+IENvbW1pdCAwYTgyMjQwNThhNTggKCJkcm0vaW1hZ2luYXRpb246IEZp
eCBwYWdlIGNvdW50IGZvciBwYWdlIHRhYmxlIGZvcg0KPiBtYXAoKSBpbnRlcmZhY2UiKSBwYXNz
ZWQgdGhlIGRldmljZSBhZGRyZXNzIHRvDQo+IHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoKSwg
YnV0IHRoZSBwcmVhbGxvY2F0aW9uIGlzIHN0aWxsIHNpemVkIGZyb20NCj4gZGV2aWNlX2FkZHIg
KyBzZ3Rfb2Zmc2V0IHdpdGggYW4gZXhjbHVzaXZlIGVuZC4gVGhlIG9mZnNldCBpbnRvIHRoZQ0K
PiBvYmplY3QncyBwYWdlcyBoYXMgbm8gcGxhY2UgaW4gYSBkZXZpY2UtdmlydHVhbCByYW5nZSwg
YW5kIHRoZSBleGNsdXNpdmUNCj4gZW5kIGFsbG9jYXRlcyBvbmUgdGFibGUgdG9vIG1hbnkgd2hl
biB0aGUgcmFuZ2UgZW5kcyBvbiBhIHRhYmxlDQo+IGJvdW5kYXJ5Lg0KPiANCj4gQ291bnQgdGhl
IHRhYmxlcyBmcm9tIGRldmljZV9hZGRyIGFuZCB0aGUgaW5jbHVzaXZlIGVuZCBvZiB0aGUgcmFu
Z2UuDQo+IA0KPiBGaXhlczogMGE4MjI0MDU4YTU4ICgiZHJtL2ltYWdpbmF0aW9uOiBGaXggcGFn
ZSBjb3VudCBmb3IgcGFnZSB0YWJsZSBmb3IgbWFwKCkgaW50ZXJmYWNlIikNCj4gRml4ZXM6IGZm
NWY2NDNkZTBiZiAoImRybS9pbWFnaW5hdGlvbjogQWRkIEdFTSBhbmQgVk0gcmVsYXRlZCBjb2Rl
IikNCj4gU2lnbmVkLW9mZi1ieTogR3lleW91bmcgQmFlayA8Z3llOTc2QGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jIHwgMjUgKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfbW11LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5j
DQo+IGluZGV4IDYyZWFlN2ZjZDVhLi42N2U3M2Q3ZDVkMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IEBAIC0yMzM3LDcgKzIzMzcsNyBAQCB2b2lkIHB2cl9t
bXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCkN
Cj4gICAqIEBjdHg6IE1NVSBjb250ZXh0IGFzc29jaWF0ZWQgd2l0aCBvd25pbmcgVk0gY29udGV4
dC4NCj4gICAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVyIHRhYmxlIGNvbnRhaW5pbmcgcGFnZXMgcGlu
bmVkIGZvciB1c2UgYnkgdGhpcyBjb250ZXh0Lg0KPiAgICogQGRldmljZV9hZGRyOiBWaXJ0dWFs
IGRldmljZSBhZGRyZXNzIGF0IHRoZSBzdGFydCBvZiB0aGUgcmVxdWVzdGVkIG1hcHBpbmcuDQo+
IC0gKiBAc2d0X29mZnNldDogU3RhcnQgb2Zmc2V0IG9mIHRoZSByZXF1ZXN0ZWQgZGV2aWNlLXZp
cnR1YWwgbWVtb3J5IG1hcHBpbmcuDQo+ICsgKiBAc2d0X29mZnNldDogT2Zmc2V0IGludG8gQHNn
dCBvZiB0aGUgc3RhcnQgb2YgdGhlIHJlcXVlc3RlZCBtYXBwaW5nLg0KPiAgICogQHNpemU6IFNp
emUgaW4gYnl0ZXMgb2YgdGhlIHJlcXVlc3RlZCBkZXZpY2UtdmlydHVhbCBtZW1vcnkgbWFwcGlu
Zy4gRm9yIGFuDQo+ICAgKiB1bm1hcHBpbmcsIHRoaXMgc2hvdWxkIGJlIHplcm8gc28gdGhhdCBu
byBwYWdlIHRhYmxlcyBhcmUgYWxsb2NhdGVkLg0KPiAgICoNCj4gQEAgLTIzNTAsNyArMjM1MCw2
IEBAIHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKg0KPiAgcHZyX21tdV9vcF9jb250ZXh0X2Ny
ZWF0ZShzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpjdHgsIHN0cnVjdCBzZ190YWJsZSAqc2d0LA0K
PiAgCQkJICB1NjQgZGV2aWNlX2FkZHIsIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQgc2l6ZSkNCj4gIHsN
Cj4gLQl1NjQgc3RhcnRfYWRkciA9IGRldmljZV9hZGRyICsgc2d0X29mZnNldDsNCj4gIAlpbnQg
ZXJyOw0KPiAgDQo+ICAJc3RydWN0IHB2cl9tbXVfb3BfY29udGV4dCAqb3BfY3R4ID0ga3phbGxv
Y19vYmooKm9wX2N0eCk7DQo+IEBAIC0yMzY1LDE4ICsyMzY0LDE4IEBAIHB2cl9tbXVfb3BfY29u
dGV4dF9jcmVhdGUoc3RydWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUg
KnNndCwNCj4gIA0KPiAgCWlmIChzaXplKSB7DQo+ICAJCS8qDQo+IC0JCSAqIFRoZSBudW1iZXIg
b2YgcGFnZSB0YWJsZSBvYmplY3RzIHdlIG5lZWQgdG8gcHJlYWxsb2MgaXMNCj4gLQkJICogaW5k
aWNhdGVkIGJ5IHRoZSBtYXBwaW5nIHNpemUsIHN0YXJ0IGFkZHJlc3MgYW5kIHRoZSBzaXplcw0K
PiAtCQkgKiBvZiB0aGUgYXJlYXMgbWFwcGVkIHBlciBQVCBvciBQRC4gVGhlIHJhbmdlIGNhbGN1
bGF0aW9uIGlzDQo+IC0JCSAqIGlkZW50aWNhbCB0byB0aGF0IGZvciB0aGUgaW5kZXggaW50byBh
IHRhYmxlIGZvciBhIGRldmljZQ0KPiAtCQkgKiBhZGRyZXNzLCBzbyB3ZSByZXVzZSB0aG9zZSBm
dW5jdGlvbnMgaGVyZS4NCj4gKwkJICogVGhlIHBhZ2UgdGFibGVzIG5lZWRlZCBhcmUgc2V0IGJ5
IHRoZSBkZXZpY2UtdmlydHVhbCByYW5nZQ0KPiArCQkgKiBiZWluZyBtYXBwZWQ6IG9uZSBsZXZl
bCAxIHRhYmxlIHBlciAxR2lCIHJlZ2lvbiBhbmQgb25lDQo+ICsJCSAqIGxldmVsIDAgdGFibGUg
cGVyIDJNaUIgcmVnaW9uIHRoZSByYW5nZSB0b3VjaGVzLiBUYWJsZXMgdGhhdA0KPiArCQkgKiBh
bHJlYWR5IGV4aXN0IGFyZSBub3QgY29uc3VtZWQsIHNvIHRoaXMgaXMgYW4gdXBwZXIgYm91bmQu
DQo+ICAJCSAqLw0KPiAtCQljb25zdCB1MzIgbDFfc3RhcnRfaWR4ID0gcHZyX3BhZ2VfdGFibGVf
bDJfaWR4KHN0YXJ0X2FkZHIpOw0KPiAtCQljb25zdCB1MzIgbDFfZW5kX2lkeCA9IHB2cl9wYWdl
X3RhYmxlX2wyX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7DQo+IC0JCWNvbnN0IHUzMiBsMV9jb3Vu
dCA9IGwxX2VuZF9pZHggLSBsMV9zdGFydF9pZHggKyAxOw0KPiAtCQljb25zdCB1MzIgbDBfc3Rh
cnRfaWR4ID0gcHZyX3BhZ2VfdGFibGVfbDFfaWR4KHN0YXJ0X2FkZHIpOw0KPiAtCQljb25zdCB1
MzIgbDBfZW5kX2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wxX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7
DQo+IC0JCWNvbnN0IHUzMiBsMF9jb3VudCA9IGwwX2VuZF9pZHggLSBsMF9zdGFydF9pZHggKyAx
Ow0KPiArCQljb25zdCB1NjQgbGFzdF9hZGRyID0gZGV2aWNlX2FkZHIgKyBzaXplIC0gMTsNCj4g
KwkJY29uc3QgdTY0IGwxX2NvdW50ID0NCj4gKwkJCShsYXN0X2FkZHIgPj4gUk9HVUVfTU1VQ1RS
TF9WQUREUl9QQ19JTkRFWF9TSElGVCkgLQ0KPiArCQkJKGRldmljZV9hZGRyID4+IFJPR1VFX01N
VUNUUkxfVkFERFJfUENfSU5ERVhfU0hJRlQpICsgMTsNCj4gKwkJY29uc3QgdTY0IGwwX2NvdW50
ID0NCj4gKwkJCShsYXN0X2FkZHIgPj4gUk9HVUVfTU1VQ1RSTF9WQUREUl9QRF9JTkRFWF9TSElG
VCkgLQ0KPiArCQkJKGRldmljZV9hZGRyID4+IFJPR1VFX01NVUNUUkxfVkFERFJfUERfSU5ERVhf
U0hJRlQpICsgMTsNClNob3VsZG4ndCB3ZSB1c2UgJ2RldmljZV9hZGRyICsgc2d0X29mZnNldCcg
aW5zdGVhZCBvZiBqdXN0ICdkZXZpY2VfYWRkcicgYXMNCnN0YXJ0IGFkZHJlc3MgZm9yIGwwL2wx
IGNvdW50IGNhbGN1bGF0aW9uPyBPbmx5IGFjY291bnQgZm9yIHJlcXVlc3RlZCBtYXBwaW5nDQpp
bnN0ZWFkIG9mIHdob2xlIG1lbW9yeS4NCg0KVGhhbmtzLA0KQnJhamVzaA0KPiAgDQo+ICAJCS8q
DQo+ICAJCSAqIEFsbG9jIGFuZCBwdXNoIHBhZ2UgdGFibGUgZW50cmllcyB1bnRpbCB3ZSBoYXZl
IGVub3VnaCBvZg0KPiANCg0K
