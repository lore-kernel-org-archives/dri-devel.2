Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB55CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E4F10E0A7;
	Mon,  5 Oct 2026 15:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="JxQyidO7";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="RoaunRlK";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B0D10E0A7;
 Mon,  5 Oct 2026 15:14:29 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695ERmoc896821; Mon, 5 Oct 2026 16:14:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=rfBJVMwrLlFbSzdrhR4Fzm+NULDH48x09rPU4BH0mX4=; b=JxQ
 yidO7pY3ma7pCNB6i18Sai4PqBYU09y8JFYrIQ+yDlxRjsFt9z1Y2gbt29mnuSeL
 UUNtCgIIWqBVp5qUzX9cXbazaIjTP4DniCHTBWBDG9B1YYWYYJQ7KDG7R8ULKjJ0
 C55MHlHg9AOjbNdL3orTqtqBYtGjdk9J+zcmqVMX0WIoTvG3Sd+3Ovy6FDEri+Sj
 P4qwopBFoz6BjVPYwfwktebKgb0GFvmBpMb9icdj136doZF34xF58WYEE4fzruGZ
 +X0woDIxJnrSNbXiz0G7QH8S++lUXzRG1kZdT1kFwmVLLt0PrDhuUj9WZsgdeexU
 qYvx645DeO8krwYXGEw==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022074.outbound.protection.outlook.com [52.101.101.74])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h3fnt0xas-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 16:14:19 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1sGEdE+KVQWqbSsoKFOxStPQXWWWIphZ1Xu40rQQ3damiVxgeUKkrBn1BRRes/4uNFDefyFefzfFb0U6287mPr6foi6SsUo6C69RUMooUoXW7lnVYRt7YEDJfpC3tgAf6R5/64PIy/HpZZmLnZECEvUXa6ZGQ28zsS+Iu66Xpn+fruF7zN7T5xJu6tL/1cG9j0/fPnBpn0DHl7K0t/05jEduRXJhc+UHrAxSCymTxroQxDbXUHIrtfMk7oCgnN+/YQkXiYPxOXIjrHgb1sjeINoucNpuI4GxlquLI8qP72Ghv39hhsIQW8QShAxtfmOIB7uWzBnzwp4wGt+OxkzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfBJVMwrLlFbSzdrhR4Fzm+NULDH48x09rPU4BH0mX4=;
 b=HF+NKCfGt5ZhOvua3oLiw2GaSiwejfTkm9QtPUEpIsEx+O7HuJ+fCzLdRqyDNjVFZcsGTgW51EC+e0x4b0LPRhHH9w05VED6gEISyXQzCnQ7rnjS0Gsx1HGRiN6/lkGefdYchmL+sSEBVcMLWtbJwSSST+XCrbatqzUhsBd4jZNXS0L/OzeFTnw8pK7b2gDyJTGvQ+iiiiBIMhLivS7/hCfLv7Fk0QUdBapvynik15mFvn45b2Csdg0NqoAooegCeK15g9pGntyuhQjrR57pBMBTuCMaqfR2bWExdACzfv8xNtdEOgBX/H+yMB+tDBR3nPonEVKy88xASTNeRmA0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfBJVMwrLlFbSzdrhR4Fzm+NULDH48x09rPU4BH0mX4=;
 b=RoaunRlKQIM0lWEDU5lyvkMyLSyXuVh/iAT4j2C7kzOY7EzauRsQG6WpEvWh/bLCZy8vflKq/hM8v+Go803B3H3BrdFjEN/wxmYMJEIAPfyij/zPD1ZwboH35BUywXoh57QPg9CwlW4OMKFGwR7WHwtIs5rAk0vUmqZsiGOJ27Q=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO0P265MB2810.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:170::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:14:15 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:14:15 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "gye976@gmail.com" <gye976@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdVNwvtq7tocNbJEyuF7IkxpnRNA==
Date: Mon, 5 Oct 2026 15:14:15 +0000
Message-ID: <64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
In-Reply-To: <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO0P265MB2810:EE_
x-ms-office365-filtering-correlation-id: b2d99bd1-3f54-4964-d3a1-08df22f351aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|9063799003|38070700021|18002099003|22082099003|10067099003|4143699003|56012099006;
x-microsoft-antispam-message-info: UsXx44oswG4CD5C+3G6o3M1P1znelphnGpyL19NeLDt4zvpyTeD2GmeqE3n/yj1W6daEo71dp+PTaYGBEFt+ZL/fVi97u6MZrIik+LFahq1rqi9LXN2ioEiV4/D1+AHDM2+8GsZG0psxtaAh1fDUWwv+Qe4vz/mQVgGe2N6gXKijxHpkmcXu7VAJBQQN2JVGFdv+mHBl1uf1zv22ZD0oM9Uz4Irw00tx7fs10Ge8Dj9Xg0L5VQieT+1yh0G86pSLpkd8dI4uqfigWw9i+t5GAh/5gFRPewSHtYD9oF7b9JKBICUTUMYqWsVoFsJOFfN4JOdfoC4XAcREOBqHr3nPuPa0hoSfe3MS3NPj11wdBRGg/x/r91QfODRsqDwiRX4l+fwkaqIwPrZzt0DT53sRac+O+abgpRhCJTYPwv9mcUj731NPOz1OtyTthGn9mVTIU/VEbIW5YHLnJKam4PLRxebMbvri9WYdj0ir2br2IIiH8pfuUwoDeWo02ubiZy0wnsRqykruyKJvlrxiwKhO11dkooL4xTVJWm5/UjFP1V1F7deDqrzyBvxZ9uDNK4oohrIlr/GcRKZ3ugZuLgfNhF+02Vm8LLAEuISb3tBGAYiVCUgxpXblpJmImCeLF6fhH18oQcV+ee5gnpBXBiFHto1cPj0PlzimmMgOm2jSs0udLyN2ARKmTJZ02duO/tfVImGmaEwPegsGn5oywDD1C2W39fwj3Q9XtfBssxUDsoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(9063799003)(38070700021)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTkxdXJJYXgxNzNMSURUK2lJNFFpaFppY3NJUlg5LytmbEtweG9RVTgwdnlJ?=
 =?utf-8?B?OU1uSEJMdnVrV2lYVkxkcFZLRDdOeUM1akNTeitiaVROTStQd1plMDlXQTJ6?=
 =?utf-8?B?QUhJZnh0UmNqdUFYK0NkdXg2cmx4Q3huQmcvWlVtbE5QYityNzMzWXFSZ1FO?=
 =?utf-8?B?UUpOWWVrbGtMcGpJNmJtKzZTcUw2Wmp2OW5EMXRMRGxMcHZLVkc3clNwLzlT?=
 =?utf-8?B?enM0ZmtxWVR3WFJCVHNyUkFnWC9WWU5zaC8vUW5SZTYzMkJPcFRhVXVpM1Nt?=
 =?utf-8?B?azVrejJNeEJhZzEzMzQxR1BxWGJ4cm1jbzVpQkFhQ0NXWEF4SE1SSGo0M2V5?=
 =?utf-8?B?VTB1SlRqMUxJcVhrQVpUYVlJcWxRY3hQbUZvaG96U2FUSlJRSXV2cjlnMzdz?=
 =?utf-8?B?M2tKcUlwV3FQZmdQNnZTSDJvWGtyVGJsMFRZUUF3RGpBWXBhU2k5N2hGdXFL?=
 =?utf-8?B?NU42VkNiZEQreGdaYVI3RWJXYXRBcDdyTHNNVjZ1MnV2am1GWGFzV1RGVkor?=
 =?utf-8?B?dDFVd3h2Nm10a1pTYTUyZHVoaXduMHF2b3lZS3UrVnUrNVpzSXRLa3Z4QXV1?=
 =?utf-8?B?MlI1UVlSY3VGenpsNVR0YzJUQ1JPTmhld3FwaDlhaVcreXBjd3J5azhIcWVw?=
 =?utf-8?B?QmxHTkM3NGZJbGljSWFuVGhYaDk3anYxZkwzRXdsblFZWXdvajF6UitkeDZS?=
 =?utf-8?B?U1FQZm9Vd3ZaMHk4WGNTK2lnNC84NFo5TGhrSHdjY210UnVtS2RnY3BNS3dk?=
 =?utf-8?B?SjZTcWxXZjQ5dXdIRTJjVE1pTXpnNE1RSTZ6TjI4R01Qa1JBdWVLR1hCNmkx?=
 =?utf-8?B?N082SkVyUUJ5ellzZzNtcG1FdHY2SUhMREtINUVlMmxBeGtpQmFQdUZvMkJZ?=
 =?utf-8?B?RVdadkcvVlE4MTlWM2hxV1JJWk9sRWxhZE5SVGt2THkzWFF6a3BtQzdqWFJz?=
 =?utf-8?B?NzFXRy9ONUNCeXhyVDNEOUM0czV5SUNiQ2xGU1pjb0FmMk1hTXdyZHN6dzZm?=
 =?utf-8?B?MGQvbUJqQVg4UGs1SzYvMTFlRUl4TFgvQmRheTZRNTRld2p1YlFDVXdVNFlS?=
 =?utf-8?B?aDdYZEZHWTBBQ25lZXo4TjF5T3FSUUZJVnRLWVRsNFlmcmRMUnN1ak95K1Jz?=
 =?utf-8?B?NWF6R3F2WXpsODN3ZW15Nkt1NXh3clcxemxlclozWjY2Nmo2WjV4Z2V3eG12?=
 =?utf-8?B?cHR3YVJEKzZ5RkNZSHNrT0hMRDdXcXhPbWpkTzlsTUtXeGwzQnozRE1RNUZ3?=
 =?utf-8?B?R2tKZWNqSDJTU0VVVTNNTyt6SlZ0MUJjQmZRdlpWeHI1YVF6QjlMb3JEVk05?=
 =?utf-8?B?QWNSZnowVHpmZElTeVpFMFE5cTlldTJQRVFjeW1DMVZHZEJTMW9RUTVaSHVT?=
 =?utf-8?B?cHRzLzZTQUQ4MHdyK01TdGcyMnFvZE85Mlh2TEZ4eExqbWk3UzlKU0ErckpT?=
 =?utf-8?B?NGJRUzRxNFJ0ZmV4ZVk3LzljM3Z4SDllWWdZV1R1VXhhMUc0aTJLaWdpUGZR?=
 =?utf-8?B?MHNnZjhEUkFHS0tuQ2tadjJsZUtzbS9Eb2ZGMG9UWnhBYkREWGZVZlJnVkY1?=
 =?utf-8?B?RmliZ2VpbTJyNldCZlk2WEl4d1RPWThEZFpnRzhJemZNKzVWOTBCamlCaVVD?=
 =?utf-8?B?UTVvQy85SlY3S21uZzF1L2wremhCNmhhMjJmT21XNlpKRzBqSjlPV2wwdnNm?=
 =?utf-8?B?Q1Fma0NweTNyUDJiVlovdjdTaXdnZzVkRGFUVXd3T2VIaE5MWlZvTnlQbHVB?=
 =?utf-8?B?ZU1yUThqbHpKbldMeDBKK0FJNmY0bzJlNnJIZFJJR25mbkVraTVDQjFPdW0z?=
 =?utf-8?B?OEJKeHJTNVQzNWtUREhXOXo0Ukg2ajFkSjVuMUtJMjg5aklSUVpxaTliMVBL?=
 =?utf-8?B?S3dNcURvdjZTblNHci9rZ0lMY3RYbVdOVytXWTc0Q01hNWp6Ly9DVFZGZWJN?=
 =?utf-8?B?N2xmUWlsS2xiSEE1aDFERDRYVXk5dTV0QkFoY0R6blBQUnJDQlQrRGFqcFFu?=
 =?utf-8?B?WDJmRjExWlNNblh3NlFmL2lMTHFlS2JrczdNanMweTNlL2xMZERlZlk5OXQx?=
 =?utf-8?B?YVJ1V2gyQ1JqV1IzcysvSHByUVQ2dWdoWkxtMkJYMHhJQlVhWWZBQVhNdzVO?=
 =?utf-8?B?RnZ4ZXpJd1ZMdk5iUXdUUWplRjhneEpwb2VPellXYzUycUtka281T3dUaXJZ?=
 =?utf-8?B?bWVjdDR2bmJUd2gvd251bitIaHNmRk1RU0M3aERsbjc2SkZPWElQa2swTUU3?=
 =?utf-8?B?SE1ha2daTG5iMkJiM21CM2xGYkYyUlVEYkM5aFFaMTZrTDVReVQvZGdDTWtp?=
 =?utf-8?B?WnJPcEhldVpHR043S3l0ajl2QVBLZElITjlTaThCR2lPV0hlMWtFUktyUVV6?=
 =?utf-8?Q?c59LOA75U/aQXCFs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B24562422F800A43B43C976B4A37ED6D@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uRCTsZnDuko61VPZzr9LpRQDmBNs/vyd80rlE2627xc9gsXVrR3v97wCoxal+UNejtfi94RXoxhixIcoNBjfybUo/U/HWrG0Mn5OENj3NRb1icCd9L2BqblRiTeZu8CQLlf40uofDsMO7qDgYVE4BxHrJFsvCP2XIt7ryjEW9XuoVJw04p7i3uju6d1qF4xzaT5nYNjmnEd2unsMw4RAK3M00wiC6yqoUv6/e952QzDH+MgagXeSjv1jPpcN1uHoDjhLGNV5zzY8r1liZg6uaQjqPuz314Ilf0cZLtdHkhoNKP5F2Jab0jmrZxLEaJHYvXCsXbHl4NMZAjNDtHnSsA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d99bd1-3f54-4964-d3a1-08df22f351aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:14:15.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVAmZTb9qcVManXfwfeh0muwfBHw2URKteS0GB6AszJNGyRJTj+ZSD/wKCLROVCiIQ1D7OYnBLnDaR6wXCs3MCTM76LYbMd2XIFNmRPVKME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2810
X-Proofpoint-GUID: CyGiIZfOh3rko-DOp2yUmUOPnP7okWKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX55P+ROm4n5Zy
 MmZcVKRGIXkV2NT7exilcsJRfGdjO3ZjVWU6VFKXVCJDiVWweOZyY1jafYj+K2VmkYgEBeX+LDu
 isJ2VeJE0VL+FNP1X5nURN7+bBgGYnWNhd8Vy1VSEVUmQuIXVToTGzvuH2LR8mAAKKf2vGLG+Sr
 NKABMNFmnPyFMM7oP/gkFf06+gu6hDBuqSBufjKuyFHotO5plgjvgqA7XhWTuaMHw2xT5xD+HWR
 Po36Z3yOqDaVRcwGyklsbcRAGgkxEAUVjzvKINRS70jYIvM2eZCbZ1yKRSN3f2iPWGCi/pPWMwS
 TkJjW1VFsRp/QKjiwL9rakQZ/aL6CwOHZO5VU5PC6Q+5TbXl9D1ufuL4dqrEFGYQeBoJTKj2vWn
 Zg3iv0ql6FY9eq5QQwdrFbx6BM5ZxPmhsLMWvBgcg2f5gP+wxWubCZKTzYmWmoZUgXIC1IIKGwo
 rAKJaaCw6uMB0bglM/A==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6ac3becb cx=c_pps
 a=Z50z5WNQq2kJBcafAK3rFA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=Ni7WLIcFNrfr_rUjZSIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: CyGiIZfOh3rko-DOp2yUmUOPnP7okWKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OSBTYWx0ZWRfX2KiC0wcRQzSM
 5nHq1PFgk7iJH0bzPY0o1qe1+MOe2MC18vhjrnN0pBal93vu/b58r38aecF1lxful/Tormt/eEm
 2s9rH9s5BOUjmqHnstzWZPD4c2OwpFs=
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

SGkgR3lleW91bmcsDQoNCk9uIFRodSwgMjAyNi0xMC0wMSBhdCAyMjozOSArMDkwMCwgR3lleW91
bmcgQmFlayB3cm90ZToNCj4gQ29tbWl0IDBhODIyNDA1OGE1OCAoImRybS9pbWFnaW5hdGlvbjog
Rml4IHBhZ2UgY291bnQgZm9yIHBhZ2UgdGFibGUgZm9yDQo+IG1hcCgpIGludGVyZmFjZSIpIHBh
c3NlZCB0aGUgZGV2aWNlIGFkZHJlc3MgdG8NCj4gcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZSgp
LCBidXQgdGhlIHByZWFsbG9jYXRpb24gaXMgc3RpbGwgc2l6ZWQgZnJvbQ0KPiBkZXZpY2VfYWRk
ciArIHNndF9vZmZzZXQgd2l0aCBhbiBleGNsdXNpdmUgZW5kLiBUaGUgb2Zmc2V0IGludG8gdGhl
DQo+IG9iamVjdCdzIHBhZ2VzIGhhcyBubyBwbGFjZSBpbiBhIGRldmljZS12aXJ0dWFsIHJhbmdl
LCBhbmQgdGhlIGV4Y2x1c2l2ZQ0KPiBlbmQgYWxsb2NhdGVzIG9uZSB0YWJsZSB0b28gbWFueSB3
aGVuIHRoZSByYW5nZSBlbmRzIG9uIGEgdGFibGUNCj4gYm91bmRhcnkuDQo+IA0KPiBDb3VudCB0
aGUgdGFibGVzIGZyb20gZGV2aWNlX2FkZHIgYW5kIHRoZSBpbmNsdXNpdmUgZW5kIG9mIHRoZSBy
YW5nZS4NCg0KU29tZXdoZXJlIGluIHRoZSBkZXNjcmlwdGlvbiwgY291bGQgeW91IGFsc28gcG9p
bnQgb3V0IHRoYXQgdGhlIHByZXZpb3VzIE1NVQ0KcGFnZSBjb3VudCBjYWxjdWxhdGlvbiBjb3Vs
ZCB1bmRlcmZsb3cgd2hlbiBhIG1hcHBpbmcgY3Jvc3NlZCBhIHBhZ2UgdGFibGUNCmJvdW5kYXJ5
LCB0aGF0IHdvdWxkIGxlYWQgdG8gdGhlIGRyaXZlciBwcmVhbGxvY2F0aW5nIGEgaHVnZSBudW1i
ZXIgb2YgTU1VDQpwYWdlcywgZXhoYXVzdGluZyBzeXN0ZW0gbWVtb3J5IChzbyBtb3JlIG9yIGxl
c3Mgd2hhdCBTYXNoaWtvIHBvaW50ZWQgb3V0IGluIHYxDQpvZiB5b3VyIFZNX0JJTkQgc2VyaWVz
IGFuZCBpbiBvbmUgb2YgQnJhamVzaCdzIHJlY2VudCBwYXRjaGVzKSwgYW5kIHRoYXQgdGhlIG5l
dw0KY2FsY3VsYXRpb24gYWxzbyBmaXhlcyB0aGF0PyBJIHRoaW5rIGl0J3Mgb2sgdG8gZml4IHRo
ZXNlIHRvZ2V0aGVyLCBvciBhbnl3YXkNCkknbSBmaW5lIHdpdGggaXQgaW4gdGhpcyBjYXNlLCBi
dXQgdXAgdG8geW91IGlmIHlvdSdkIHJhdGhlciBzcGxpdCB0aGVtLg0KDQpEdWUgdG8gYWxsIG9m
IHRoZXNlIGFuZCB0aGUgZmFjdCB0aGF0IHRoZXNlIGVycm9ycyBhcmUgZWFzeSB0byB0cmlnZ2Vy
IGZyb20NCnVzZXJzcGFjZSwgSSB0aGluayB0aGlzIHBhdGNoIG5lZWRzIENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnIGJlbG93Lg0KDQo+IA0KPiBGaXhlczogMGE4MjI0MDU4YTU4ICgiZHJtL2lt
YWdpbmF0aW9uOiBGaXggcGFnZSBjb3VudCBmb3IgcGFnZSB0YWJsZSBmb3IgbWFwKCkgaW50ZXJm
YWNlIikNCj4gRml4ZXM6IGZmNWY2NDNkZTBiZiAoImRybS9pbWFnaW5hdGlvbjogQWRkIEdFTSBh
bmQgVk0gcmVsYXRlZCBjb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogR3lleW91bmcgQmFlayA8Z3ll
OTc2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X21tdS5jIHwgMjUgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX21tdS5jDQo+IGluZGV4IDYyZWFlN2ZjZDVhLi42N2U3M2Q3ZDVkMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IEBAIC0yMzM3LDcgKzIz
MzcsNyBAQCB2b2lkIHB2cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29w
X2NvbnRleHQgKm9wX2N0eCkNCj4gICAqIEBjdHg6IE1NVSBjb250ZXh0IGFzc29jaWF0ZWQgd2l0
aCBvd25pbmcgVk0gY29udGV4dC4NCj4gICAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVyIHRhYmxlIGNv
bnRhaW5pbmcgcGFnZXMgcGlubmVkIGZvciB1c2UgYnkgdGhpcyBjb250ZXh0Lg0KPiAgICogQGRl
dmljZV9hZGRyOiBWaXJ0dWFsIGRldmljZSBhZGRyZXNzIGF0IHRoZSBzdGFydCBvZiB0aGUgcmVx
dWVzdGVkIG1hcHBpbmcuDQo+IC0gKiBAc2d0X29mZnNldDogU3RhcnQgb2Zmc2V0IG9mIHRoZSBy
ZXF1ZXN0ZWQgZGV2aWNlLXZpcnR1YWwgbWVtb3J5IG1hcHBpbmcuDQo+ICsgKiBAc2d0X29mZnNl
dDogT2Zmc2V0IGludG8gQHNndCBvZiB0aGUgc3RhcnQgb2YgdGhlIHJlcXVlc3RlZCBtYXBwaW5n
Lg0KDQpuaXQ6IGNvdWxkIHlvdSBhbHNvIHVwZGF0ZSB0aGUgb3RoZXIgc2ltaWxhciBkZXNjcmlw
dGlvbiBpbnNpZGUgc3RydWN0DQpwdnJfbW11X29wX2NvbnRleHQ/DQoNCldpdGggdGhlc2UgdXBk
YXRlZCwgeW91IGNhbiBhbHNvIGFkZCBteQ0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8
YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gICAqIEBz
aXplOiBTaXplIGluIGJ5dGVzIG9mIHRoZSByZXF1ZXN0ZWQgZGV2aWNlLXZpcnR1YWwgbWVtb3J5
IG1hcHBpbmcuIEZvciBhbg0KPiAgICogdW5tYXBwaW5nLCB0aGlzIHNob3VsZCBiZSB6ZXJvIHNv
IHRoYXQgbm8gcGFnZSB0YWJsZXMgYXJlIGFsbG9jYXRlZC4NCj4gICAqDQo+IEBAIC0yMzUwLDcg
KzIzNTAsNiBAQCBzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoNCj4gIHB2cl9tbXVfb3BfY29u
dGV4dF9jcmVhdGUoc3RydWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUg
KnNndCwNCj4gIAkJCSAgdTY0IGRldmljZV9hZGRyLCB1NjQgc2d0X29mZnNldCwgdTY0IHNpemUp
DQo+ICB7DQo+IC0JdTY0IHN0YXJ0X2FkZHIgPSBkZXZpY2VfYWRkciArIHNndF9vZmZzZXQ7DQo+
ICAJaW50IGVycjsNCj4gIA0KPiAgCXN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCA9
IGt6YWxsb2Nfb2JqKCpvcF9jdHgpOw0KPiBAQCAtMjM2NSwxOCArMjM2NCwxOCBAQCBwdnJfbW11
X29wX2NvbnRleHRfY3JlYXRlKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCwgc3RydWN0IHNn
X3RhYmxlICpzZ3QsDQo+ICANCj4gIAlpZiAoc2l6ZSkgew0KPiAgCQkvKg0KPiAtCQkgKiBUaGUg
bnVtYmVyIG9mIHBhZ2UgdGFibGUgb2JqZWN0cyB3ZSBuZWVkIHRvIHByZWFsbG9jIGlzDQo+IC0J
CSAqIGluZGljYXRlZCBieSB0aGUgbWFwcGluZyBzaXplLCBzdGFydCBhZGRyZXNzIGFuZCB0aGUg
c2l6ZXMNCj4gLQkJICogb2YgdGhlIGFyZWFzIG1hcHBlZCBwZXIgUFQgb3IgUEQuIFRoZSByYW5n
ZSBjYWxjdWxhdGlvbiBpcw0KPiAtCQkgKiBpZGVudGljYWwgdG8gdGhhdCBmb3IgdGhlIGluZGV4
IGludG8gYSB0YWJsZSBmb3IgYSBkZXZpY2UNCj4gLQkJICogYWRkcmVzcywgc28gd2UgcmV1c2Ug
dGhvc2UgZnVuY3Rpb25zIGhlcmUuDQo+ICsJCSAqIFRoZSBwYWdlIHRhYmxlcyBuZWVkZWQgYXJl
IHNldCBieSB0aGUgZGV2aWNlLXZpcnR1YWwgcmFuZ2UNCj4gKwkJICogYmVpbmcgbWFwcGVkOiBv
bmUgbGV2ZWwgMSB0YWJsZSBwZXIgMUdpQiByZWdpb24gYW5kIG9uZQ0KPiArCQkgKiBsZXZlbCAw
IHRhYmxlIHBlciAyTWlCIHJlZ2lvbiB0aGUgcmFuZ2UgdG91Y2hlcy4gVGFibGVzIHRoYXQNCj4g
KwkJICogYWxyZWFkeSBleGlzdCBhcmUgbm90IGNvbnN1bWVkLCBzbyB0aGlzIGlzIGFuIHVwcGVy
IGJvdW5kLg0KPiAgCQkgKi8NCj4gLQkJY29uc3QgdTMyIGwxX3N0YXJ0X2lkeCA9IHB2cl9wYWdl
X3RhYmxlX2wyX2lkeChzdGFydF9hZGRyKTsNCj4gLQkJY29uc3QgdTMyIGwxX2VuZF9pZHggPSBw
dnJfcGFnZV90YWJsZV9sMl9pZHgoc3RhcnRfYWRkciArIHNpemUpOw0KPiAtCQljb25zdCB1MzIg
bDFfY291bnQgPSBsMV9lbmRfaWR4IC0gbDFfc3RhcnRfaWR4ICsgMTsNCj4gLQkJY29uc3QgdTMy
IGwwX3N0YXJ0X2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wxX2lkeChzdGFydF9hZGRyKTsNCj4gLQkJ
Y29uc3QgdTMyIGwwX2VuZF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMV9pZHgoc3RhcnRfYWRkciAr
IHNpemUpOw0KPiAtCQljb25zdCB1MzIgbDBfY291bnQgPSBsMF9lbmRfaWR4IC0gbDBfc3RhcnRf
aWR4ICsgMTsNCj4gKwkJY29uc3QgdTY0IGxhc3RfYWRkciA9IGRldmljZV9hZGRyICsgc2l6ZSAt
IDE7DQo+ICsJCWNvbnN0IHU2NCBsMV9jb3VudCA9DQo+ICsJCQkobGFzdF9hZGRyID4+IFJPR1VF
X01NVUNUUkxfVkFERFJfUENfSU5ERVhfU0hJRlQpIC0NCj4gKwkJCShkZXZpY2VfYWRkciA+PiBS
T0dVRV9NTVVDVFJMX1ZBRERSX1BDX0lOREVYX1NISUZUKSArIDE7DQo+ICsJCWNvbnN0IHU2NCBs
MF9jb3VudCA9DQo+ICsJCQkobGFzdF9hZGRyID4+IFJPR1VFX01NVUNUUkxfVkFERFJfUERfSU5E
RVhfU0hJRlQpIC0NCj4gKwkJCShkZXZpY2VfYWRkciA+PiBST0dVRV9NTVVDVFJMX1ZBRERSX1BE
X0lOREVYX1NISUZUKSArIDE7DQo+ICANCj4gIAkJLyoNCj4gIAkJICogQWxsb2MgYW5kIHB1c2gg
cGFnZSB0YWJsZSBlbnRyaWVzIHVudGlsIHdlIGhhdmUgZW5vdWdoIG9mDQo+IA0KDQo=
