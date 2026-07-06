Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C91C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A35B10E1DD;
	Mon,  6 Jul 2026 16:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="UTHPnamS";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="EWLctnlg";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C39A10E1DD
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 16:31:40 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FhZ1T635458; Mon, 6 Jul 2026 17:31:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=bpzAlVUJZzAJ9Et1VAGmoCLlZUX24TT8fIUpwDUJTO8=; b=UTH
 PnamS1nwZB9FmTw1aX1aoTQTCP5ud0UhW7iB1RFs2AikGNJJsXJs7TIkJlwkWLfg
 shAR59v8xl2Ks8MBTxmPY8WsAk79DjTP2TfJofwlBRgs+Fh24civoXbe9l7fkwDT
 jVBZm/u7D4qkCzcu0+koqJZOyzTZA+X/YE0djROFth8kuuNJMPcpweesI0Bj6HdC
 PZ/9ljLyKFJvgf3bMnyIilNNYj1P7t9B1S1JbEcI/ojWgwfhbhhZpkiw04Dltud3
 NEn+fYnFM1QXreCadIs/7rUVI72j1st9JTpz6Ux1U2mGJwcQYhhpxLRrhS3+8a2t
 PigCodOD/gTcoK7NIgw==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020130.outbound.protection.outlook.com [52.101.195.130])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f6rephsgr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 17:31:25 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5iAlwqyxFJZybXyg8EqyN32k5ANLf8bZA+CteQlKO+4ifK3RpUe4+hyDpF5bSKZkaj3wnXkEsVhUeNEB8yLSCSYl1dz6fTM9MYPQTSENSulqAJ0kib+Mjkh+929K088ZEofhdiDhnbf/8W3x3qpFD7l7F0sL/lAp71TDd/lqE0ef3WjliN3bgY8KkkW/z9P8NpZy57gfdopMQn95aHJKIoesl+OZ3CCX5rLJ13DCjr1r605OBG7xpgMc/W1khbvu7WKHNcm8qvFHe1PeqyKPLEIsjhn4UdhtTWrB2o6C6+mS3y9Ew2aL8VWaFeG3jmA5hNIC8AXR64EWoNYE3S6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpzAlVUJZzAJ9Et1VAGmoCLlZUX24TT8fIUpwDUJTO8=;
 b=gr4v5IfCGfPOXkeDjSYEc7NFPrha39pLduac6+8zmv68oLYe95kCQzDgrswH/UVdfU0gHhTLPBIA/qml2Fb84U/hdKjh24yvAuFNi2BTvhV4aMTWNJjuy5JS7Jzgx/bXFU4WPzMRX/8MMExpsHlqqQldCMhSwD1uYsD6/ZdHBzdKCUAf+qz+pzZLzxmM9Y125xlwBKOpWYzd3kqi5C5O765TEdjjZU6PAh38YBNyRmu8ij7NiIGR7qYo3SRjrtPEN6eIH/c8nNOLe4dlB+CV8ZeD9GYm3582im58OFnNF7eka0TQ6PtT7u4DL38T+ZicYIoSsHzwk/shUhPrP8J9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpzAlVUJZzAJ9Et1VAGmoCLlZUX24TT8fIUpwDUJTO8=;
 b=EWLctnlg2ZrWgsP0dkvMh53jm4HuqSG04hhYVqvyHlPsIOYDtw5iXuyQsBALoqw87SGQgpPAddDIk/orMW3bz81w8gr4IFZKaiT+Vl8U/h6W9aQ6yl/hfLQ9t70dykAzhHT6OXYZAe9EvXS3nXT21RwhcCX3GG+UE6cT5s0mSMI=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by CW1P302MB2115.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:261::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 6 Jul
 2026 16:31:20 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 16:31:20 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Topic: [PATCH v2] drm/imagination: make pvr_fw_trace_init_mask_ops
 static
Thread-Index: AQHdDWTgwpRMFUSddESZZd3dHZQiyA==
Date: Mon, 6 Jul 2026 16:31:20 +0000
Message-ID: <1c7c5867cfba89094d39e5178cc281c0cc9c87fa.camel@imgtec.com>
References: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|CW1P302MB2115:EE_
x-ms-office365-filtering-correlation-id: 46bfac90-6e7e-494b-a094-08dedb7c02fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: Y/WjJFLi7l6kh+ifT8RXZcv0AbSBIwIhu+LCw0y75/qlIQcspTMPBfWTHI4zy4ouX5QfMeqIL0LwxYgJ/A/FkdwgPPOcp/78bW2ytVCdwukzONPxOs9unp2K2JeMona9WF2w0KMDDFKcsYvyo3bYx7u4JvwwaFXBGjDMXQp7xNkK8iUYZMx8bQ6dzB9bzF9vPmf5VPZwMB8czCUvUoWZAl45/7ZRfQEvESUx9pF2YV745ur7bqBYBaRE6SlJ5aFexk+lf6mWdwWLy6SkPJprVjqSaIEvvBfWuaYZPThpjtVHpPckG7FUc+UV25HS0FvTM30Bd3a+VXOalkuzxHiCL2lKre6OTdbCBuMzNGh77jNmghRIQ/3ASmjIjvzV3sH627U3LBYxZjyWW5NVVG7yDJX6cHxH3SgwlXQDgL7yegL8Sd6/A7UUnwNE+w+2V6s5Njyxn65eEs9K4/3nWkjBCb0diBKDVqG1qa321uE3LDfxyFU7LJqBYpTvRbC53FmT3gLmf0dAHScEVTEcOKaTWcabGR+KB9ZUz/d6n2ipC5SiEhfN2oCCBsRdNPBWJSlLmP696aijwIbPCB/0og0OzqMRoZZ9lcldjPlVlRHMmtD328zIFEe7a7YU/rCEC2LTqq3U48yyVkHRWmWhHh8d4uG7AtnkMy3V1jNd19XoAHJ1GeTR6SlSVLnI3ojd6WgenkLygG0sqfswnqnCpNN7bYpae72fweongNhqoejMuAA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0pIbjlhMXNQVmlHRTJvQ0VmdnQ0N01sUHZici96OFJiR3VDWlFPbmdDbmxh?=
 =?utf-8?B?RUs4UU9ja2p2UGNPcG5GNXdHdmtIcEhpb1hoUlFnSGhxc3hxVXF4MktacXNW?=
 =?utf-8?B?cDFNTk1RMDNER1c0NVVPRjNDemlCQjdhekpoa1JMRkpJY2FIa0drcDZTUEVJ?=
 =?utf-8?B?ZnQyUUZ6a3pyYm52ZExtR0ZDL1luNk0vRGdaSmg3SEV6eDRPM1ZBZG56bjI0?=
 =?utf-8?B?S1VOcW9EcGQ4V0pzYjFEbm1Pb0xYSVVOV2JPem10d2tEZUNFalFmaWpBWjRr?=
 =?utf-8?B?RFV3ZFJoWjFPWVlQUngrZU9CTVRPMEhINnNNa0hRamljUk4wU3NmQkhwOWk5?=
 =?utf-8?B?YTFsK2x6MitLRFcvb05xVldrSytwNEk1Y0JlazlUUHJEdkFXSmg4ZXRWK0hM?=
 =?utf-8?B?anNxT05LSDhYS1hGZ2lGYXlZZTZPVXFQaC9sRnUzVVVpYUoydUFwT3g3N2JM?=
 =?utf-8?B?cHE5YW5SSUdvVDMwY3N0eklRMDliSDlacnNYUWVra2YzWW1ub2VRdWhpdlJy?=
 =?utf-8?B?RzJkbDVUeHVDNlp6RDRhb1RmdEwzZ2psZUlpZUFZUllFYStSQk9GbVFEQllE?=
 =?utf-8?B?aXdVcW9ad0F4RTV0NE9PR3FOZzkxbytvVWxZbEF3VHlKYytVaXJMZ0N6MHdT?=
 =?utf-8?B?OGJwai9ZQ2lTby9JZ0phaXRkNUJ2V1dEVEcvTVJ2UHNLbFRDenBkd0lhNUNK?=
 =?utf-8?B?aTYyVkRmMkpyZ1BVS0VyRERFUGNZZHRYUTJzZU5JWXZISjdGTFJvaVpza2lG?=
 =?utf-8?B?b1JGcnJxZkVZWjRURUVwTlhCV0xadkZwRnJaWUtERy9pUkY5Z1BVTno3WVBu?=
 =?utf-8?B?TVlPRHdlR0FhZ2lBc0xDcFpkZzdReE9yQk1ZQkY0VVZGUGZ3Nkozbjl3LzJT?=
 =?utf-8?B?QXN3OHo3akNLb3A5cFJUZVg2UEl4MXVRdUJ5TnM4aTVwd05yTlJ1UVJldVJq?=
 =?utf-8?B?SG0yaXZkendXeHJDTTkyc29qNmRVOU53VEpaSXV5N2srdjdGOWE4VXRxdjFY?=
 =?utf-8?B?T2lvMEV1bGpWYkpSdnpPSE1ESjRHK1M4WlRUL3NmbjNuSWNqZmFMVW44NlhR?=
 =?utf-8?B?M0gyV3N5VTd1Vm4vaVNxZmFqSzh2NThRVkpOdkpGb09BZ1hWN3NYYi83a2RC?=
 =?utf-8?B?bS9xTTkydUJLS3p3a1VSb1R5K1hwVjVXTythaHZTcWV2OXZ6M1RZU1p5YUNE?=
 =?utf-8?B?Q0JpaEJYLzlhRktBNkZYNHFiQ2gvSFBFc050QjlLYkF6UFNkcVJ5MllmVTJP?=
 =?utf-8?B?RTRJSnZ0V25EV3diaXd6Ny8zbHEyaHhsN1M5TDdnUm4rdTA0dlBnRTFJTGtR?=
 =?utf-8?B?TjJmalc5Y3VqRmhIRWRDQUdxQ0Z5aVNnRWlkQjRHNFpKejRPYWR6aWlIQ3d4?=
 =?utf-8?B?S0crUzFRTDNVVTcvUU44d1A4OVJzaXArMXhQZmpBem11NGFHMVJZVGVPeGEx?=
 =?utf-8?B?RmNFR1dkNEhCRzh2YWpOVFJ5QnBScm4wTWgwQ2UvOURROHI2YmtuY2FocXFl?=
 =?utf-8?B?SjgxdEIrcFMyaW5ubDlQNnBwTnhTMk9oUFBhdUJ0eEI4b296WXNGeXJXeXJM?=
 =?utf-8?B?N3ltTHp0Yi9TM2I2dndGK1FQSmdxcWhmVnB5eXdCRlUxUzQxNVpNUkwxREdj?=
 =?utf-8?B?QURjRVgvNlhLZ2Z5Yk8wZnNQRkJwVFBtclJ4NERrSnc1cC9BNTQ2a3pRQ2Jp?=
 =?utf-8?B?UDhLWGxOSWM5S3Z6M3U5K3hMWWZoQVR2SUVnUGZHdkJ0MElJZEpiQXdmK2x5?=
 =?utf-8?B?Y0wvWXFDMGJLM2hzR3ljRjhmWlpTK1RmdVJjUUJTVmpBZjJGdDlOQ0M0WmJz?=
 =?utf-8?B?YzR4bE1GcDZ4dDhycVE1clZEN0FnTHJqUk1hV0JPTmJnYXQzaUVRT3pOSXNh?=
 =?utf-8?B?akZYTWJhMk52RjRkdFFuSXo5ZHdYejZ1c0Q3bjhiNEovMGg1Q1Rsa0kzVllq?=
 =?utf-8?B?QTdJV2Foek9TZjRlRVRRdTNGM200MHJmaDRYOEprM2J2K216b3Zwd3p5cVRl?=
 =?utf-8?B?bzVNczNwVHhEMURpamp5ZUxZU1JvMkZCRFlJd2ZuV3pDMHVZaStkOVJ4Q0pu?=
 =?utf-8?B?dFlaY29mZTdTRkRLb1M5TmRqb3ZvRWhKMHlHNlk2dzRyWnZ6b2tySVF0SVk5?=
 =?utf-8?B?Y3F2MGJDNUIxUTc3ZklaTmxWTkNIMXVrbVNSUnNGYkxMclRUMURJVzE3aHg4?=
 =?utf-8?B?RjdZUTJtZURuZ1R1VkFEZjZ5cEh3aFpmWkRYV3V0WU41dTAwNzcxNzZJZlNL?=
 =?utf-8?B?d3AxM0t3Z1JpMFd6VFRqWkUra1Y3Q0ZLOVlhd2U3L2lpbHRHMjJzSTJ0TG0z?=
 =?utf-8?B?eTRhdytxRDM3SS8vWDRNRlFnSUhmZVZSN3JZQzJvZkgrRzRwM0lNTXppbjQ4?=
 =?utf-8?Q?nS3S3foXrYbfn0Ug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBF5F4A71D87C54A8C8E7AC2A0CA6F01@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jM3Uv6vGL6dwnL9tEh+gAGWM3bg3l3oOGF+ZGw3OkEDBOf4dV+km4zWDNiz4Z5r7FLlZAhOdzZYvaOkybmp4IV6F1OfYirGQ5IJGSQR87qdXrLva0jZWWfrW8a24NyXYvBqlcygbZJEQcggMHUYoE/KlIqF0EtAKytTxvSOGAqK2b35ZJHyO6Nefl7mt698DT69BB1R93m3ddUVbgnWMif1InaiS5N7fPU/RistnfnW/XUhg/3J2xwUbKlUrWIqnYP4/cQ74SWt0t27oJijL72CBVkTWaH0EhAG4ZSpbG7XdZnDf5ex6MpCLnjedp2goFdNjkuK1U6DlsBDjRUGcmg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bfac90-6e7e-494b-a094-08dedb7c02fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 16:31:20.5349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdDNpaBTknh2I6Q5Iuk6NKKrPQ7CBx9qlcYBJkrxVhehDX4W+LvIRV4eWCZF3Zklh4tuvyOOkZPb2I9QM1+bI5mxzQGaYeqzJDWnF3AylKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P302MB2115
X-Authority-Analysis: v=2.4 cv=Fos1OWrq c=1 sm=1 tr=0 ts=6a4bd85d cx=c_pps
 a=iEMUFiQyi0tF3QzJbt+z1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=1EsaE_6oAAAA:8 a=zs9F8P-ln-FCdrcqSUQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-ORIG-GUID: kTTA0PetRK-PGL_OzkmYSQ6C09CUA6SL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfXwH3oWvtdiuSC
 FKnqwgq55CxhwJmn4gA58ADzZY+nN5M7CW+YP23/wguEjoMtjF7EYiGYDKMegw4Aw60Mr0vBNSS
 TkQ9+aCayn20awCEuIXrfJt32T4U1cbgwhMD+DFhSLn/phwoUlh/IvaxCWjU5jJHkkAFA8fX4rf
 IzvEC+HmnJI59HgPl7cL6KXXf0Vw1VRkn0C8AqllQKtqDRdolfg45bhEAfmJscNU84nsN9Ji/S5
 t9qiqg2b3/f6u9gEMFQOga4J356T9x6FMdMCLvaf+WqW/qAE5hEnoNyr+B7Tt3q99nUWjtC1UlF
 d0amjPsJspQZUjXA4f8OEFVBNaZQFsP8MbNEDQtMNX6iy6ytI53FlOfXTlCk2vS1o43Jb93j6GC
 1vm+qtNDT8o851srYQs6X2XhDSd458y0srn84lbqMyIsePORgvuhr4W2vQ5RJCRc4uEd2ryWzZo
 uhOF5uRDHtQqyCupGuA==
X-Proofpoint-GUID: kTTA0PetRK-PGL_OzkmYSQ6C09CUA6SL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfX6QS/Piqe0TGg
 n3pZ8Ud9npKeuV2Dwg3RHvvpyySTUaQYJiMJzCCcNhyIKMsM8dbikL/LD23cgMpjGr/cM/OjpGp
 Um9sV8s7zBqDQwrWHRYcK7lxEoASnUM=
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

SGkgQmVuLA0KDQpPbiBGcmksIDIwMjYtMDctMDMgYXQgMTc6MjMgKzAxMDAsIEJlbiBEb29rcyB3
cm90ZToNCj4gVGhlIHB2cl9md190cmFjZV9pbml0X21hc2tfb3BzIGlzIG5vdCB1c2VkIG91dHNp
ZGUgcHZyX2Z3X3RyYWNlLmMNCj4gc28gbWFrZSBpdCBzdGF0aWMgdG8gYXZvaWQgdGhlIGZvbGxv
d2luZyBzcGFyc2Ugd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfZndfdHJhY2UuYzo3NDozMTogd2FybmluZzogc3ltYm9sICdwdnJfZndfdHJhY2VfaW5pdF9t
YXNrX29wcycgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gDQo+IEZp
eGVzOiBjNjk3ODY0M2VhMWMgKCJkcm0vaW1hZ2luYXRpb246IFZhbGlkYXRlIGZ3IHRyYWNlIGdy
b3VwX21hc2siKT8NCg0Kbml0OiB0aGUgIj8iIGF0IHRoZSBlbmQNCg0KPiBSZXZpZWQtYnk6IEFs
ZXNzaW8gQmVsbGUgPEFsZXNzaW8uQmVsbGVAaW1ndGVjLmNvbT4NCg0Kbml0OiBSZXZpZWQtYnkg
LT4gUmV2aWV3ZWQtYnkNCg0KSSBjYW4gZml4dXAgdGhlc2UgbWFudWFsbHkgYWZ0ZXIgYXBwbHlp
bmcgdGhlIHBhdGNoLCBpZiB5b3UgYXJlIGZpbmUgd2l0aCBpdCwNCnVubGVzcyB5b3UgcHJlZmVy
IHRvIHNlbmQgYSB2My4NCg0KUGxhbm5pbmcgdG8gYXBwbHkgdGhpcyBwYXRjaCB0byBkcm0tbWlz
Yy1maXhlcyBieSB0aGUgZW5kIG9mIHRoaXMgd2Vlay4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+
IFNpZ25lZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVuLmRvb2tzQGNvZGV0aGluay5jby51az4NCj4g
LS0tDQo+IHYyOg0KPiAgIC0gYWRkZWQgZml4ZXMgdGFnDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9md190cmFjZS5jDQo+IGluZGV4IDZiYjViYWE2YzQxYi4uODA1ZDlmOWJj
MWRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3Ry
YWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5j
DQo+IEBAIC03MSw3ICs3MSw3IEBAIHB2cl9md190cmFjZV9pbml0X21hc2tfc2V0KGNvbnN0IGNo
YXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+ICANCj4gLWNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHB2cl9md190cmFjZV9p
bml0X21hc2tfb3BzID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3Bz
IHB2cl9md190cmFjZV9pbml0X21hc2tfb3BzID0gew0KPiAgCS5zZXQgPSBwdnJfZndfdHJhY2Vf
aW5pdF9tYXNrX3NldCwNCj4gIAkuZ2V0ID0gcGFyYW1fZ2V0X2hleGludCwNCj4gIH07DQoNCg==
