Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A82C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE1E10E820;
	Mon, 29 Jun 2026 10:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="LuhgdGnO";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="j7dvul1J";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7E310E820;
 Mon, 29 Jun 2026 10:53:26 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAXR6M2985572; Mon, 29 Jun 2026 11:53:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=IUexJ91JvO4xEFA5EnZytWT5UdcSr8ihmK9i6nMhLVY=; b=Luh
 gdGnOcc+H6nUXGaT7m0iNXhPyYE2Rwb3pFYZIVvb9tFXAuUPoVjzdVWw56MvO6fZ
 Npnp0R8WqqkYw4NDiMgqYVL/bRvga8RzLMndF4vZVeq809eo7Q4U8UyO5wUYNi75
 8Hjxr7vNZEYd55zbC2ORvMDtYtR7OAsriag5idgb6wrrMSukCngGO8JC17SR5sDv
 fQJvFrCEIlS/5wwVf/syPpuA2eGNg1fJygcPbwiTwuuoYnSXj2treQ7lp82f8NEF
 qR2himaUSi1p7ja3Bbfq9bagO21GkSd2Vs1Ip0AXtwdCUUqy9cfl6jFXxwnAyYYP
 fK28aBc9sJPKYZweU1g==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snsmu2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:53:21 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djO3bU8Q051aqh7HMz2itKwXlrBYu9g252CGzR0OYqg6Kck6TJxi0lf/T0GGIBc0TJTyvoxLDFo7PaZ4UU9DfrBvOmt/MuzLjDAwYAwXURtvTc647lQWr6VSoLQcvInc53m7D0UTmZ6U7eupXgr/i8lIGCZtkrMQsKi4YnBQVrH6iaasic0cPcJDhcB0M2gab62NG4vJsdtoJdkCGzbJSvaxyPxQV85AP5Y/F/AznZZCHf07f9LtCdSrUivAzWCJWn9jT4fIbMbvb0xnq1yBtXFcV6gchl+4AzfbD28niKEHnxcsHFJBVgUkS/cmMbt0SB7OuwgCuKCKsIAM5WrmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUexJ91JvO4xEFA5EnZytWT5UdcSr8ihmK9i6nMhLVY=;
 b=QdR5+3+nx+3GAMYRDSeiVlvuvC7cp05LCOULXn3Ci486ko+Q6mSi7XMtpjnt+p5BZHsmUtszMHXqvjSL2zDJxFsAhS0x/5aJDWwDXaYXijzHK8YOK1h8oIDVnycpRcbwGQTwt44ega9317noMgTzIcMF8rliudLLtv41gHXkI2zoXly2f82K0DlKxLGfYEjWK9DVy2sNQdOORwXCqyVGMXmCLyNH4t8SOrJh5eaRlH1BiMFKNKgJSKIjY4o7E6PEFLojLIRwN9k49BpXzRUtPCANs83OWpyS1kmpnzmgDoF2l4Gxt3tyt4bDHV6pWtUebb77HyGrIM5ORuY89dFLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUexJ91JvO4xEFA5EnZytWT5UdcSr8ihmK9i6nMhLVY=;
 b=j7dvul1JMkYW13SEnaucebutKRV++3b6hzJ8B9uA2hGxnNNrbCFXtJLJTwofd0gwNPFDvx4dxH6a8E728DsaH9eCU2hJY4Brcbi9MwjQtG7N4CHSWpN6IFqz4mfhhTrgphDU9wm4C3oa5V9vp4xbpUeLUXhUCjJZxizdDsQMVKw=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LOBP302MB2291.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:447::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:53:18 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:53:18 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Frank Binns <Frank.Binns@imgtec.com>, "conor@kernel.org"
 <conor@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, Luigi Santivetti
 <Luigi.Santivetti@imgtec.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Topic: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Index: AQHdBWlp6as7jqzE7U6/fkyXZvwZg7ZVYCiA
Date: Mon, 29 Jun 2026 10:53:18 +0000
Message-ID: <3d39b10655e1d1766a51071b00ded938b9b8dd12.camel@imgtec.com>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
In-Reply-To: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LOBP302MB2291:EE_
x-ms-office365-filtering-correlation-id: 8382f6b5-5544-4f8b-d431-08ded5cca0f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: rlapLUm52gDwPYbcGOlQGkfx9/Kgj+WLRJJoa6Jk8y1WtTA2Z40ufWILUqlmki4c9p0pQ25F4rOrrbwt9x1Ue9yW6bceIbf/6ZMs5eD391JbZczf0sz21XzAZgnfs7CUAiV/XU7Q8qiEaTZSKXjBjpQqr6Q7Ks5p5UlQKnrJsj2yX316L9mpabg4vUmSQVyLE9YtZxK+h+5O0bux6ZdZeFqoATJRXZoYpxmx2YWahqfWZVILQ8bw7D9hJBkjd116r9CjXVN/Uabc/aFWmdE7cmrVQCdCc3xGB4/Hd6kBmSzJMqyJBU9xkVpWqQXB9Qh8UlEkGBq+fiDutTRoYAXbS6chf7zwSZfyj4ae1PysQJMNGkPXudpLf7gNYQ8zLJHgJqpR5P8/9Iv1rGkLjXxGk9AjVQgDLXy+G4LF9UYauqLhZ52/1xJX8C5igU7rexWntrTGPQnXNu0b1xioWaq2R4Bv7OtKLx48iLFFxuLDEo1XVOicd7Wd5+Cix85BQJPMY3mtrtX+6lhjUcI3/q+nppCAS1sqBfSBIdL2Mo5906sJ5SGhth7XjlUnu5Gjxy0uovitjvI2jIZDp5XsxkDtXoxovAQM6bABug6i6XU6/R9VlHJ6rFbPpzvg1C7jodefMfqMMznv7UCqkIFEt81oYl9i/LrfieofEQ+nQxXpbU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzB4aE1ZRkp0d1B6aEExbXFydHErTG56R0RrRnBEMHlRcklMbFRaNk1MMW91?=
 =?utf-8?B?dXRaU3dJY1BOUW91bU1yMmFJS3diRFBHVG15YzhZbDdVUTBGanRtU21IZ2Nz?=
 =?utf-8?B?Nml3RWsvdkFxYUErUjdmL1BtK0c5OExBUW1NT2RDUm1Hc3pvZFo5UVdLdERr?=
 =?utf-8?B?dlYzWm53OCtiUU5JUHd1eSt1MU5TVHZxS0xxdjd0b1U1blJjdlNOeVIya242?=
 =?utf-8?B?cXpRL1I4Tk9qK1lLNGVWUktuQmN1dFB0NS9JbzlqWXNTK284T0FnaHp0Slg2?=
 =?utf-8?B?R0JQNEZ0aVFkaGxiTUFHRkR3RHE2eGNrWVFqcHllZFh6UW94SDRYUW1XdG9G?=
 =?utf-8?B?c0ZiOEtMeDJjeWhkcXR0OHZ3SzBFZEljVEs4NkNucE1IRVg3T2o3ajQ1cWFW?=
 =?utf-8?B?elFVeEN3cHdDNjRCWWJwN25tYmM0NWd5dTJYbEd4U21MaWV4OWNCZlVOYVZQ?=
 =?utf-8?B?MW1iNkxKNzdPem1nL0NTdzVOaWZiWUV3dXZQYlVoamo2QnZza1BOY1ZmNTVv?=
 =?utf-8?B?S0o5NW45TWZMYkxIdEJ2NmRqR0ZzdTlha3hFMzRVK1g5SWlIT0VWMEUrZmgz?=
 =?utf-8?B?d2ZZMlkwN3ZramZlNHp0SkRVNHZRUSt6cEF0emYyY3A1SmhoVENaMHlBOVlr?=
 =?utf-8?B?OVFXcEVUUXdyUHFvdVBTMW1ia2VxRkJCQWMrczVDOVJiVEF6dzZocVQxM0Js?=
 =?utf-8?B?OWQ0RzFKZnZGUUxxTUF3TXp4NzdIT0M3K3I5NVJIb2s3WmxMUDVYcmdGa0tZ?=
 =?utf-8?B?Ung4Wis1SlNPMDg4d3RBVlZNRmxQbzVYanJ1UXFtWkJVZVI4d3o4TDdUZ1dr?=
 =?utf-8?B?RVA5TVY0TnhmK3JMSndKOGpycTJzYWt6OGNqTXlzeU5xZHE5WjExWkZKbCtE?=
 =?utf-8?B?QVlTaTJabzVmaTJLbVVvZE1ScFNPSkc2VlNBdWhDV2pibERyV2hGK1U3MDVa?=
 =?utf-8?B?RmlsNzA4YUJldnozQ3BiaS9NV2swOFN0bkl3RzZSSFFqNWFRakt0dHkwRUhU?=
 =?utf-8?B?dk41ajk3dmR2TkV5N0tGMFp6UW9xL1JyU3FpV2JIM0FNekwvbzFBZDV1VmJK?=
 =?utf-8?B?NDAzSnlKa1k2KzNMMFM4M3VOd3FxYklud250SDlWZGZiYzgrSEQwVFlpVlBN?=
 =?utf-8?B?dXhwdE1kQWxQYk5Ec1Z3aGQ3bVNHdks2SitPaUZES0NKVEVpU1NjTjZUbTQ1?=
 =?utf-8?B?LzFpZFRVWGFISTVDM3d0dUhpN1hpWngvVzFydXZNQWl0QU1pcGZXNVNadzYw?=
 =?utf-8?B?QytteUFRTklKcXUyNjJhRUh5dGgrUWZrbDI1V3FHWDUzbW9VeXFtdXlBSTQ1?=
 =?utf-8?B?aGp4dU8wY1NiQ1lMdXpPWSs3UkNvYmZLaVRkMnVUUlZqaUt4K3ZFTkNhUlpK?=
 =?utf-8?B?UkNjdWdjRTBTcWxRMmpqQ0Z2cUIvTnE5ZU1vN2QyU05vWmdrakdGSG5WNEtB?=
 =?utf-8?B?Zk1ZTEVjSjFXMUhFN2IrMU5LTStBbzNBWk1DbWZNckJXNHo1N3JBMG15ZS9X?=
 =?utf-8?B?Qnd5OTEvUXVIK3N4NVVDNUFqUytvYkZhN0QxVzJOZ1VCenFlcU1NS0RKMGsw?=
 =?utf-8?B?cnc0NUoxanVyakE4NTJZK0JmY3grTlphT1NqKzZhdnl2M0F1c3EwSXhKQThx?=
 =?utf-8?B?ODdqdnh0bXVXam8rV3FVd3RRdjV5Kzk4Q01tWHpDQzlJNzBha3pYYndhUGQw?=
 =?utf-8?B?aDFmeWc5KzZDNjFra1pBSWcvRU5RdW1CNmhINS8yV0VhWmZ3T0QwY2NxTm1V?=
 =?utf-8?B?U3loKzVBbW4xSjdwNWZ5ckZBR0Y0WmhjVHRDcHVWVFF1UUd1TkpoOUpVQ1NZ?=
 =?utf-8?B?bkRIaDk0Mng2MWVoMTdnVExVb1JuVmZtclZZdmR6Zml2c0p3TlRyWWN5ZmFO?=
 =?utf-8?B?NzM3Sy9lNXpsSjBVTDJUOGs2QnE2RkppOGJtRnF4eUpTc1pEbVlnV3ZFd05K?=
 =?utf-8?B?b1U4RnoxVEQyUlYydE9FVFF2ZFFyb2ZvY2NFbDQrcE03SjlMUEhwaDZid1pC?=
 =?utf-8?B?bnZKQVNUeDd2VnB1WVNXVG1McTY2VWJhRXhZRGlpaVBKWWdveXg1QkZJcktJ?=
 =?utf-8?B?WmltWVUycXNrVXc3SnFJVVZUTlhtYktJREQrZHpZZEErbGQrRkxabmY5bFBM?=
 =?utf-8?B?aDloOHJ1OTBXTElXaEtyYTJPdTBKWS9VTFVYRTJIVFA5SDhKMXhIMWN0WDFX?=
 =?utf-8?B?N0JVOWpJV3ZmQmUxZGNlbXlXM0dBemRYcDdMRjltMHZXVTJ4OWtRdGtFUlFJ?=
 =?utf-8?B?TGdnNTV2YkptMXp4RjNzVWNDeStFSnpabkJrSTBBK1NNV05CR1NuazBuQ3RT?=
 =?utf-8?B?UVZCSm82WXpreG1NUm5wY1B2TTNvZjhvcWZVV01CZENvZDhLVENIVWVnZFNp?=
 =?utf-8?Q?ENXR9UuSia6xt6Tc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85BF9CC1FB10742A7D38B58249FC273@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JLSIb3xTGqQsiDOBCBjgZUIlcmxlEbI+MIlpPW56bn9HTthwamubR1eIZpgJ/nwbLIYaWAgya3xMrZopurhoJ8tiHz4vUqWUZ60zxa6UQPFRXUeI5pWnD6GKZqQ90LYiLFmwuhfdFHjDj418ydFwzbBmZp3BZUWxEgm8v8ktrjzOeoYD16rBbq488iibbOJG58HiBNMxah7m6ICCrTeqcHeFFrsH5dXQk6yGAQLJF0DuCzlwZauweiHi9LHpkCR/Z6yE2f4a7WIDx1TJD/fojSamD1XO035OQoPzinVu0BbHx3idTk9ojd9qZeeI8yEG6cQbr8dgKz9NSJL4aAowrA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8382f6b5-5544-4f8b-d431-08ded5cca0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 10:53:18.3075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2y1k8SM4dkv2ZTwbNPptZvfLbsSkNH4oiu9K/Jn2d5+AVEF8g0c7YWRi8zNekh7jFrXSQ6IIJ/eA2tdaKLqXETqDJ5E+OWR8YwznYk3y1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP302MB2291
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXwhbbYws6sKsN
 /f6HhPJ1+rlBdQ6ARD4GOF6kGOPeTn6MHM3TfeasxLOj3VQZHR6YV5+bkCEbegyZNyBgblVnFZJ
 DhBrjkAy/EjS2YfjozehLwWNGUqESUI=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a424ea1 cx=c_pps
 a=/g++M5lKnzqULpF6N+OBgw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=oiPMGJNdvW4XLUKoBdoA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: aEFHb2X1ueE7oS8hTCXYkQzyVaPVtdcQ
X-Proofpoint-GUID: aEFHb2X1ueE7oS8hTCXYkQzyVaPVtdcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXyiGG6kfoOXzo
 kwFswbpBdBNXSgRvXOKyYtm1edNq2PsYXmulaaYaySfvSYLW913oZhpdjB9HQl/6UcBpj2w6xA3
 tiApr0vs+YEVovM4In+/3cichYNeZyFxe/yuWa/OHm4JmagIrAfqauPvgKH0/cPbc7TfO2sWECs
 Dc6akQdKqqAHKM8r5g7SJOvfM5BPaApkWtXpgVPXU4O5YRKGioYPIR5+UUfznyRuBCO0rIN53h/
 bkLdYBcRuQU7l4IKZqrbU4A1k3zuW0BSENee1ZsP4zWJ7Do8ZjhkSkEPMKWGQVf09+AoKe2OmMO
 KTRKc44MYigIyd8QWRFxEGTR5aiqlIwvcMr4R1+Qqa/uITnccOdaGjZZlUL8PQ/x/i1kJkArpIk
 MoVAtq+/OEQpGN+5Bo4SIBtbR9lMURYRCZ5JmrzwmfBdIQQsk7FC3KokxpEVHvGHIiR3pfcST/M
 RwzBihQ15iAvuNEXKvQ==
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

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEzOjQzICswMTAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
V2UndmUgZ290IHNvbWUgbmV3IHBlb3BsZSBzdGVwcGluZyB1cCB0byBoZWxwIG91dCB3aXRoIG1h
aW50YWluZXJzaGlwIG9mDQo+IHRoZSBpbWFnaW5hdGlvbiBkcml2ZXIsIHNvIGxldCdzIHRha2Ug
dGhpcyBvcHBvcnR1bml0eSB0byB1bmlmeSB0aGUNCj4gbWFpbnRhaW5lciBsaXN0IHdoZXJlIGl0
IGFwcGVhcnMgYWNyb3NzIG11bHRpcGxlIGZpbGVzLg0KPiANCj4gVGhlcmUgYXJlIGFsc28gc29t
ZSBuZXcgcmVzb3VyY2VzIChtYWlsaW5nIGxpc3QsIHBhdGNod29yaywgSVJDKSB0aGF0DQo+IGRp
ZG4ndCBwcmV2aW91c2x5IGV4aXN0IGFuZCBoYWQgbm90IHlldCBiZWVuIGFkZGVkLCBzbyBsZXQn
cyBkbyB0aGF0IG5vdw0KPiBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBDb3N0
ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQoNCkZvciB0aGUgc2VyaWUsDQoNClJldmlld2Vk
LWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQoNCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gRURJVE1FOiBkZXNjcmliZSB3aGF0IGlzIG5ldyBpbiB0aGlz
IHNlcmllcyByZXZpc2lvbi4NCj4gLSBFRElUTUU6IHVzZSBidWxsZXRwb2ludHMgYW5kIHRlcnNl
IGRlc2NyaXB0aW9ucy4NCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsv
MjAyNjA2MjUtbWFpbnRhaW5lci11cGRhdGVzLXYxLTAtMzUxMTJiMmYwMzhlQGltZ3RlYy5jb20N
Cj4gDQo+IC0tLQ0KPiBNYXR0IENvc3RlciAoMyk6DQo+ICAgICAgIE1BSU5UQUlORVJTOiBVcGRh
dGUgaW1hZ2luYXRpb24gZGV0YWlscw0KPiAgICAgICBNQUlOVEFJTkVSUzogVXBkYXRlIGltYWdp
bmF0aW9uIG1haW50YWluZXJzDQo+ICAgICAgIGR0LWJpbmRpbmdzOiBncHU6IGltZyxwb3dlcnZy
LSo6IEFkZCBtYWludGFpbmVyIGVudHJpZXMNCj4gDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dlcnZyLXJvZ3VlLnlhbWwgfCAgNCArKystDQo+ICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dlcnZyLXNneC55YW1sICAg
fCAgNCArKystDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNjBi
NWZhNmVkZmVmODY3MzIyZmNlN2M4MzA2ZTVjNGI0NjIxMWJlNw0KPiBjaGFuZ2UtaWQ6IDIwMjYw
NjI0LW1haW50YWluZXItdXBkYXRlcy1iZmMxODkyNTQ1NTUNCj4gDQoNCg==
