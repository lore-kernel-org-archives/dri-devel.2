Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEC8C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913F210E449;
	Mon,  3 Aug 2026 06:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="a7kdN8Je";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="XE9YbxnO";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71DA10E449;
 Mon,  3 Aug 2026 06:41:42 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67369LBR497847; Mon, 3 Aug 2026 07:41:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=90G1qwzX2udQaNPxAmTkbZTrcTmtp9OZRqyniV3D0Ng=; b=a7k
 dN8Je+UHvvyuj9g+WRlPfjQDsnQ+CRryWfB+qIk0HQP0QHl3Ibg8ahvUwj/8YxxE
 N2D3KRqSOmcZ/IS5C2K3wqgnBcJGEblwNdItmgSamnpLB2Yvm8p67bXAUfjo4sgN
 2QpHev5CvdCp1Ya3qalpCqUMPm/cER6FZ+fH/lL35MSW2ve3Y7Ng5SC2JlE1UOCH
 VVhR0sfFbFDFxFmd7ZfJxJIfuDztNlnEDQ35zITMF65PDxriR/Q31ZCXC6b2xACY
 BTx0FNWW03HgMOfGQMMMXevzrHwgRSrixkuWyg4DpAtJU11s+xJ3jLPMJ3KQh/ma
 BQ/t6r3bGN5haxvGH2g==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020139.outbound.protection.outlook.com [52.101.195.139])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72ps7x9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 07:41:27 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESPIRsjLtsPezXydR929D47GkAN1EmTrZeAgsP18zQBAhcg7JXpPUBqcdPXESAND+CRPGBS47WP2xI4tyCriMI4RmgRIjBsC7zdtyOHjt5ErEWw9isjAL3ncLZJLBDpPbmTx3HwpOTesbPfkYrWiNH3RYpl1SWnN8pfPMPxAD8cK2k0HY/Sm+NZbskVdGjeeMEojnL2DEVpRvDtxOUkWMJXyDWCIavfb/+Pgz7flgZMmkELWIFsLLL5dCz5wdmXzRcYFrGe7CQUBCaWjmesXe/lOfdBonNb0rbK642ZDfaH8yJZKoGP9y2tUX10tWT7FnA5yrZmUyCUSjcRdDS3rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90G1qwzX2udQaNPxAmTkbZTrcTmtp9OZRqyniV3D0Ng=;
 b=tUBIQQz1FsOfbnxB03jAZTsQ3555Ccuy1hlo2koRbUcdxVvg+O9p/hKDeptKoVOTlNW/B9yaUVuEhzPkTAbAubEzdyu3O6Je8HleEW68sYToRlDEgkQes7VvSgEF1ZcUMHa4Saz86vS+G3GVlGLqi51uQMSikNGOKyzQ2lFzdYOfHIDQbzIOZTcWDJHe3VoPlYgkX4EOfLDDNW/EamMYzzJ7t7UwH2lwkxn8tMUOjoFHT7szy1dViV0CjmYfyDW0r2ocmfKqLO7zHWZW5uYXK/uNtiMasepBQ24HINWav1aH2+CZka9PKaplnPUPXCVvyWXyr7XIc54esKm3fkGVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90G1qwzX2udQaNPxAmTkbZTrcTmtp9OZRqyniV3D0Ng=;
 b=XE9YbxnOMijHwlXjHjR9VrGSwxuCu6HJdUUBFr7PFiME0Tob2KJB3kY14UOUYvi5RNJUn+gPEkEt845LZT/+YC29Z9SvUowrb2XbSAELDtiyE6b6DqC0LE4eI8nqNHPZsM4c+AGmD5/BAmbbBziZLLTdb+kCkskTk682LsjAkU0=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB5731.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:264::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:41:23 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 06:41:23 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/imagination: Tidy-up firmware interface checks
Thread-Topic: [PATCH 0/2] drm/imagination: Tidy-up firmware interface checks
Thread-Index: AQHdH2qUI9lRk3pQfUeG4WV1davoKbaL51uA
Date: Mon, 3 Aug 2026 06:41:23 +0000
Message-ID: <a134f6d0905622490d1bc276aee0cdaa352b99a5.camel@imgtec.com>
References: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
In-Reply-To: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB5731:EE_
x-ms-office365-filtering-correlation-id: b6c012db-8b73-47e1-1abc-08def12a3c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: VQ4uZv+ELplHDeH92S+ZOQkoVMUANa05JDpgeo9b43pSfC1Q0tl2IRen9bfh7YSgxXdpmRG08g40vxUzmJZIF5QUXWwlEMMcWsF/YWePfoh/qCjxnjPq1KKsu/HGXCuGIqzo3Lc6I+1BRSiIq021vEIX10lOcrrI1AeEFCZV1Z5qkBLRuJT+8z22UJ50+Oyi8ym/fQ4hf9yTCDFHU4Ep2yuRbINqkJOdVIiawCekOrsqmsKs6HZl3HxVZD7Pq2lGqRtoYcCHYe78uNL9YNvpU0gjYqSFWnCO4AwXmmpCkpORMX8EZEIgJCAxh/vi4+Del+PONDcfBsMrTrvLUJhG8aYhY5tjNXE17wAlDlE28SAijRdgLB9ftXWpmsaxvnhBrPIRWw+OUMA04XBAMYpla071lnA8qHCGeDhaulCG1vvVyCkQHdF/DLRLnhe97SQdPS1TF6FIrCwxSVdI5mnX1X7jXRNW0fQECbMvKZ8BYFxNxMKkW7qfwAQhwdU/KEYxPTQWnsGWyhagquYd174xt9LDJlxoV5Og3RH89WIFpXAbDig/fc9Vwj2BA8xYCQm0RjPAWgOdwFGIYlODk/qnbl+ei3KMiNdkyvFBFZOoJCc37gzyRZdo5ZjrvBi+4fW//0nKlDbM4Yl5GrdRfyl5AUDujGbn/004GF4s7l9Qb+8n1ZgTwN2AcpXo6arAIH2ybNJD7VHzCk++GJvcUi3mOj1AWcYC/+8F6MN8iabI9sM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZrL2VrR0JBSFRyT0J6RGUvc2Nya3VGRTZGOGVWK1VUZTVHTXExQUVHeEVC?=
 =?utf-8?B?ZmVBb0pocWZXMExoQkNYcGlyVmM4bkk3MmZvMWc5UDhldWdLbllldktFaHFU?=
 =?utf-8?B?dFQwaEV3STBiUlJBK1YvMDZYakF2NWdObnZSdGI5bUl0NnVBYkFWeC9YNGM3?=
 =?utf-8?B?YnVDRE1VbUVxY2FWUTBJeWd1bXpBUHNDQjZybDQ1YkJWV3lLK0dROHhMT2tn?=
 =?utf-8?B?OG1hTld5Z2o0blNQb2Nya2R0RFVmSDlhRytqaTB6c09lL3BMWTNYUVBGTW5H?=
 =?utf-8?B?TklRUWtFa3hXZUhQREJlQzAxN0hTcHpzOHNzL2xBMlpYNUZKZUEyTGIyOEJ1?=
 =?utf-8?B?VENDQTBEM3RVTlpHT2VNS0RmODBEYWdicm13MUtLMmhIeG0zdnluYjRSV3Rm?=
 =?utf-8?B?S3VXTFZ0RU55eFpLdGwycDVvcmk0UFZRRWpnUEFFenVmcnRDQVBjcjl6bXBz?=
 =?utf-8?B?blhYUVJrU2FISlo2cGhtM0J3TlBQMStXdjUxbEpjZHBCSE1jeFlGL1VUbUlX?=
 =?utf-8?B?WGNGUXYzQkZlS2JlMGtxN2dra1Nad1h0YmJTQUFOQkxKL1RiL1NFYkdaaThY?=
 =?utf-8?B?UEl5SWNuOEpRSXk5bzhUOVZJMEhKQjlUa3M2VmsrczViNDA2dXhUbFZZMlUw?=
 =?utf-8?B?MHdycUp3bnp5bU42Qk9BcmNCVS9tb3FRVmVuRVFETjh2cjZIVVpldHVvM1VR?=
 =?utf-8?B?YTd5QXRwRUl1WjBLMHk0N084eFQvc2dqQkxnLzBaMUlERTdSd0JmVDVnMU9T?=
 =?utf-8?B?RzdkaU9uckJxTUJaajF2R3ZscHNEZUEreno3aDlYWWdMNWw3SXRXQVBNeTJl?=
 =?utf-8?B?SUk1U1RQQ1VRbDlaNTBESnlsRWlmd2JobDQyYnJKUzdyQmN0enpwNHVJcEVV?=
 =?utf-8?B?REVPWG1XRlpLMXJBYVlNMlNJWWl3b2xZUWRGejJKQTg4YTVHTCtTbHY1Z0Er?=
 =?utf-8?B?aU1yZ1RaaktlOURZWWt4VFJrSHZlSVUyaVd4d0hZKzB4OWlFRW10WFVVZVhI?=
 =?utf-8?B?dG5odXFaeUp4SmxGTlo5SU5YZ1BSbjJnRnJmRFBNM3NSUWRrUWxDdmQvYW9V?=
 =?utf-8?B?Mm9sb3JWSEEvcGt2ZE5KZWhLSXptSHEzc0dHai92d2pnWGhMT2tHUDVBdFVW?=
 =?utf-8?B?emNHWWtRUGdSbXRlL1RFOUQvUlNUVis2YXV2bGxycDRsZVBDNUpFZVRyWjFU?=
 =?utf-8?B?T2RaaXowYWdFaU1LTldqMWpndlhZSEtRTjVlRFFhc3ZVNEhPSTlKK3ZMNHRs?=
 =?utf-8?B?SFgwMFJmQ29Qc2gzdFhDM291S1Zrd1diZWU3YUtxNEI5NXYrazVvYkV6U3dr?=
 =?utf-8?B?NCtEdXRKV05LdVRHcml6dWRwVlJlcys5WFlnYzIxdTBDUzMzcGF4ZEhBLzNl?=
 =?utf-8?B?T3EyZTYrQmxKS2ZoZTlMTDRNZ0N5VlBVaXJ1QUx0aXNua05QdGNKdnc1SWlp?=
 =?utf-8?B?NTZlNzZsU2t2aVNOTDRFV2xLLzB6MDhrc01POXJ4QzRMZllJeGJPRDQ2dGI3?=
 =?utf-8?B?REYrcVQxUGRvelJrWkRDZWRUOXdDcnV1VDdwQlFIWURnblY2NGRzb204OU1I?=
 =?utf-8?B?UlYxcWlSQnFFSDNDb2FyYU9nK1YwOGZoOFdLQ0hiMVZ5L2diOE9UaVZPYlZS?=
 =?utf-8?B?bExkbUt1VG1wWkJicXpYV2l0TnJhVEJhd0ZpMXV3NC93UVVOSU9ENEVZMUx5?=
 =?utf-8?B?MG5RRm1BQXUyMmlEcDVoTEZ5ZnlEMDBBVjkvNkN3ZWduOFZoZHZOQk4xK2x0?=
 =?utf-8?B?b1JLcTJORVVpbVVIVDI3TFFPRjJScEsxdm1vWFE3aStpWWg5M242RExWL2Y3?=
 =?utf-8?B?blNPSzlzamhjWkxSVjI1WG9pcTFxd3dwQnpBZk1iYTViOSt2WW1PVWxtNHpD?=
 =?utf-8?B?RHI4SzI2VkpkWlBZR1hCV2FJOW5yTE1LOGh2dDJUQzExVGRneVZXc2xGazd5?=
 =?utf-8?B?TFo5RTVweWk2UDQ1TFJtK2owWHlXOGttRHI4KzJ6d1VUUUcvS1NpVjcxbUV0?=
 =?utf-8?B?cGJTc053Nkk5LzE0UUtjR0xmSGx0T1VLWHFLV29nMEhNL3hTK2gzWjNpRWhE?=
 =?utf-8?B?MlB6b0ZpWE5iVnlIcEFwZk92Wmdyb2hnK0xvbEc3akJHMFB3N2h4MUtYR2Fa?=
 =?utf-8?B?dmpSM0JUbkFmWUErMUFJVzcwbnZJTnFITENYTmttZThnZzBpeTNSWTREQy9i?=
 =?utf-8?B?TnQ4bk12a0h5T3FSRzJhakplOVBkaVY0SmRJWXNlQVZxRDlYcEtnaVlRYWo4?=
 =?utf-8?B?SExYS0VNVSs0V0Y2TDlJQ0ZQQ1Z1RFZ0dkNtUUxwWHh3c242bVpOSzVLbEw5?=
 =?utf-8?B?TTZqZTcrRlJvNk9ISDdXM2ZueFdtdkMxOTZWVGJJcXk0OC9ubU5OQWJnTmZZ?=
 =?utf-8?Q?YsKyz1rUv6WezooM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E79FD6C4E2853146AAE35E9FE19FF35C@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: creVK6oTR/84H0XYuNjNVYXO0eWtvUErS+WlIZozh1g2p5sykPQS0/fqwhZ0IC9McO1LQFEEOL8C+6iufW0aEJ2ra9it7iAO36H7UoOG9VC2AC92MLrrQTMh22Di/gEI5cL3vffLAy+pKdZldIZirwCSZSRGAg+9aiml8qYC//1pO3XE+orcqN9cdYdY4pFiwP4ysZfj2+TVs/Eyy+hqTD0EmkdLmt14e3qRo5v7vL5gZNguitinvS1jMzzPr8L0PZQh5G6nitvfHHr/A1oTQK1iLS/brg37cdxWz3YovAchGhC93P8xlB4+PlraUh5CBqIT47CyzVFEBocz7FUMwA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c012db-8b73-47e1-1abc-08def12a3c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 06:41:23.5871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Khh8LFi5QnLxoQQhkNP1DQlUQGBeo29yT/adP7jzqkrVDF1/vTROxMJCykIwt/9T91WTmH8R3TgHkHtXRZCIf/ztPo4kQKGEAzQ9M0qUhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5731
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfX6vS6cyrk57zF
 6MvlSZfbcoh1QrxpcaNzLVE52TY8A8MMw3+uLXKX1+fE5TZBDfIZJDOWA3V8j7sjVGQGZDtHsy7
 72wFtvK5NbxuiMvZxmjIKz0oEzc6Isk=
X-Proofpoint-ORIG-GUID: 48PNqRzWeh6v3bOSpjXGaYVtAk2dQJoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfXy6f7QiVtDKc4
 f3R0lw9ppYOYXq5yMYNPRanUM0KzqeFxXCzraHwZipMGkIeifBgtmHzetEWC74llcIUMEiYUpEe
 hPLGWR9oLvWEQ8+2wTga+v+hxzcel1FiYphG96IQ2+R7ChJJrOtx7FWkMiu0PzpCZWL2PU3IwaM
 iIRseoeJYTEADmnRkwDs3dNw7Wrxg7tpU4JJ2ACtQ3G9/asMbgbiXpWC/91oZ/t1xAtVRveowRV
 Fa5qOOLzLNjh+CyAw2GxfXIn/bQO5GT5ty7PmaDweSOdZW5tN9XZlv1rcWDJuJJy5WXd1Y4+ZAO
 M1yZGPPBG7nBv0sksMPzpv05LB6NY1CgSA5EvbMbIPx6nJYpXV3sFR3FENKhc95gexB6Tw087OH
 UsCL0Wv+T/j50TwuhRQAjr+C6j1G3mOew03MdlFhcBYy8h5jJvToowqnLPn8PzkCPl9CLLBaoCC
 HIixTHtvLYBn7S5K8DQ==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a703817 cx=c_pps
 a=yus7qwhGqtk7cOL2IfhX9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=7F1fdYgB2I7AmeP7EGcA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 48PNqRzWeh6v3bOSpjXGaYVtAk2dQJoL
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

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDE1OjU3ICswMTAwLCBBbGVzc2lvIEJlbGxlIHdyb3RlOg0K
SGkgQWxlc3NpbywNCj4gKioqIE5PVEU6IFRoaXMgaXMgYW4gaW50ZXJuYWwgZW1haWwgZnJvbSBJ
bWFnaW5hdGlvbiBUZWNobm9sb2dpZXMgKioqDQo+IA0KPiANCj4gDQo+IA0KPiBUaGUgc2FtZSBt
YWNyb3Mgd2VyZSByZXBlYXRlZCBpbiBtdWx0aXBsZSBoZWFkZXIgZmlsZXMsIGFuZCBhbm90aGVy
DQo+IGhlYWRlciB0aGF0IGNvdWxkIGhhdmUgdXNlZCB0aGVtLCBkaWRuJ3QuDQo+IE1vdmUgdGhp
bmdzIGFyb3VuZCB0byB0byBzb3J0IG91dCB0aGVzZSBtaW5vciBpc3N1ZXMuDQo+IA0KPiBTdHJp
Y3QgY2hlY2twYXRjaCByZXBvcnRzICJNYWNybyBhcmd1bWVudCByZXVzZSAnbWVtYmVyJyAtIHBv
c3NpYmxlDQo+IHNpZGUtZWZmZWN0cz8iIGZvciBGTEVYX0FSUkFZX0NIRUNLKCkgYnV0IHRoYXQn
cyBub3QgYSBwcm9ibGVtIGhlcmUuDQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzOg0KUmV2aWV3ZWQt
Ynk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3VwdGFAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0K
QnJhamVzaA0KPiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8u
YmVsbGVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+IEFsZXNzaW8gQmVsbGUgKDEpOg0KPiAgICAgICBk
cm0vaW1hZ2luYXRpb246IFJldXNlIGxheW91dCBjaGVjayBtYWNyb3MgZm9yIE1JUFMgRlcgc3Ry
dWN0dXJlcw0KPiANCj4gQWxleGFuZHJ1IERhZHUgKDEpOg0KPiAgICAgICBkcm0vaW1hZ2luYXRp
b246IE1vdmUgYWxsIEZXIGludGVyZmFjZSBjaGVjayBtYWNyb3MgdG8gcHZyX2NoZWNrcy5oDQo+
IA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jaGVjay5oICAgICAgICAgICAg
fCAzNiArKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1
ZV9md2lmX2NoZWNrLmggfCAyNiArLS0tLS0tLQ0KPiAgLi4uL2RybS9pbWFnaW5hdGlvbi9wdnJf
cm9ndWVfZndpZl9jbGllbnRfY2hlY2suaCAgfCAgOSArLS0NCj4gIC4uLi9kcm0vaW1hZ2luYXRp
b24vcHZyX3JvZ3VlX2Z3aWZfc2hhcmVkX2NoZWNrLmggIHwgIDkgKy0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX21pcHNfY2hlY2suaCB8IDcxICsrKysrKysrLS0t
LS0tLS0tLS0tLS0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgODggZGVs
ZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZTU1ZmVhZDIyZmY5ZWUwNDdhYjlmMTkw
Mzg2MGM0YjQzMDQzNTE0ZQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwNzI5LWZ3aWYtY2hlY2tzLXVwZGF0
ZXMtNTJhZGY4NjU3NjE1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IEFsZXNzaW8gQmVs
bGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gDQoNCg==
