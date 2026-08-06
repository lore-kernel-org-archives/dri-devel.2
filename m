Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8264BC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9197F10E276;
	Thu,  6 Aug 2026 04:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="GKHJv7Oa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA47F10E276
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 04:30:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763wl881070540; Thu, 6 Aug 2026 04:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=hp6F5WvN6ZdgocoTHmFDHhzit9y0SFxU+2o7UzTOt6A=; b=GK
 HJv7OaQu9EWw5VuWvtW4GJ06BDG8cg7DIYmB6iVbyeUb+n4qW18i+MnmvQyEtmSK
 lCaRDRe0540ZEIycSA+MtAQ4ZfPkafercppVJHlsRtvjaOVP9OiajK/LOPS4rNaQ
 rTeC58Z7DonCeLGhUYk5ZvGLd9nAIgWjWJAFomaX4vbKcQgoyQun3xgABFNw2a1n
 Lzfu0r5c0gJuJ8auB4y9WAWQN/DM8DHnT/uJu/LUnmxOEI2aP3b2MCZgpF7eVCBO
 LwHhjit9fvrMEY7STPjsZhXHbUf4M3DiZt0ABPmImxu5XjDMecImh7Yaez4kjQKM
 VZVL875mo45X92K67GJw==
Received: from bl0pr07cu001.outbound.protection.outlook.com
 (mail-bl0pr07cu00101.outbound.protection.outlook.com [40.93.4.1])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud033w-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 04:30:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCON5pZK5DfvLshdWB7zbV5n7Kgv80Nz2Jf9YLNblu9SjvXihxHCQ9O6w9DJghArsW4QCi0xUBwwuI8RhPobH5AQNNUCNaLVQAFWgjqNSxdZUcXL9zW6SbPVyYbcfGci0+FArWKURNjujoMW0A8/nnOIBwvomZ7xSqcMKd2cHmM93OOjLt47i2EQfmU6tYCTyIL+9qeB2rFNa9QpcVG0y7gRqOuiPArePThBtoo5uCZv8+GCLmnyIEhHwAHq5E3ZSSz7CU5Q/TUxHXdTOihipZ7MuI7p1s/4mjUcMM1QQrFfuGmU7nqncrPun53E8YvgCjxD3ldDHtvBYYQ3nm3WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp6F5WvN6ZdgocoTHmFDHhzit9y0SFxU+2o7UzTOt6A=;
 b=vTPFfJFLUIrHW5/GK1ymvLcrNeU+XdPS5Kpa1R9G7gaiDIINuvWmS3w0NSYH+2krulio5/zAZeTplQdF4aW+kKoV0hge9LUFpBswFc1+IbOjFKALQ9VFetB/s5ftkF/lOwBAiiHqcjD3kNIfAv8gAUhp+cy/ebzzOJDc69BHuAvyKU1o2vPTevBadhGSbXOMIc+Nz4EZtYAaHnE/cWvXATwb7rHPMBOV0xSYNy+bOtftAdPaICJ1MWOAwh+CZG3RAi8FTemIb7ygKoNOAuSOgtQcO8rqZBAVpFA9GELCZVXcqwxdkXunqs/+wwtVuJxOizyO+td+04NzBfXHnpnISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BY5PR02MB6866.namprd02.prod.outlook.com (2603:10b6:a03:237::13)
 by DS0PR02MB9126.namprd02.prod.outlook.com (2603:10b6:8:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 04:30:03 +0000
Received: from BY5PR02MB6866.namprd02.prod.outlook.com
 ([fe80::dd2a:252:431d:6ed8]) by BY5PR02MB6866.namprd02.prod.outlook.com
 ([fe80::dd2a:252:431d:6ed8%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 04:30:02 +0000
From: Pravin Kumar Ravi <pravinku@quicinc.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
CC: "linux-accel@vger.kernel.org" <linux-accel@vger.kernel.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "andersson@kernel.org"
 <andersson@kernel.org>, "mathieu.poirier@linaro.org"
 <mathieu.poirier@linaro.org>, "konrad.dybcio@oss.qualcomm.com"
 <konrad.dybcio@oss.qualcomm.com>,
 Rajesh Sastrula <vrajesh@qti.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>
Subject: Synx : global synchronization framework
Thread-Topic: Synx : global synchronization framework
Thread-Index: AQHdJVileDNayhyIKk2Ms5PPbbGODg==
Date: Thu, 6 Aug 2026 04:30:02 +0000
Message-ID: <BY5PR02MB6866E35A2B4241CF3A728A99D3D22@BY5PR02MB6866.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6866:EE_|DS0PR02MB9126:EE_
x-ms-office365-filtering-correlation-id: 16fe45bb-2d2d-4d9a-fa5d-08def373624d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003|8096899003|3023799007;
x-microsoft-antispam-message-info: FWBIil0VmBTGbVCajJ7QXABCCqlvogxDeiHjYKWFmwBAxaXpO+Bv35UXKJ09LnsWgptn+r0HXmtZkEkWhCmmxjoeHJAc+z2mjUwLyEv7kg0wVW0DYkWcpfHSlrNz4ck3fp19KLHfWlo3JYic1+3C6CmZgD1mjeQy6o8ByymRoJ6p8iYnTuzGH1ez4Oq2Ur6R1mM7Ew2EQT4TyFvyW4Zp6MYHtYE1IJOV+cd9RePj1NZNFIFI5jidI+mLCONJAbrAsBzoDByxsCaCZDKCiY7evMmpyUD92dFbAsaRU8ZtkRgFCrLBBhLxqXPKKuZQ4T009u6w6cM1z33d9Ew8KtUt3DXHEzQiynu19LeZlWPC/Kt7LNmSrPaUDMX6PD1z799JbMfCS7bEl14ux1E5kkElJotcX0cKiQy++PP3+UW8N3/FzwYxdfuK8f3H1HPxrvPWcs5J9+t5ZoLpJtDfXrOEyrbMOgP61JB1ZVBacViW6UdaE0Lt+16C2CWRg3qRHnR5lcjZUSXw4u5Iu3kiyV1y8y+rj7s2qOgEhK0/BHYcCddlt4oT2moyE8W2oGR/8mL2levDyhW8PFJAFWyPikCtz4j5Mz5Sy40guYha34cqGT3usv1dbn++3LRyOziozX8XuFrnlgpXZXOaXEhrHZkZh4NRWZyKENIrE7TNRAC5JLAAbrkcYjdLPjnS80zs37y/a89+rmRTDfbgu4vfjxa3gL0/pDU1Nn7DgPrgBJtPqdo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6866.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wPYDvEY3WvE0o0XNMSEILrDqtmte2S68Q7a670CzaRpsiHjDUzQTBFtHyC?=
 =?iso-8859-1?Q?zFWLFVT9v7XMjBkz8UNr25a/5KF5+ovnubZQZGisN7vKyEETA5GX1KwvSs?=
 =?iso-8859-1?Q?LXxAQWCUhgWoxU9reWnZTh/OI38UXD39B5kc1jts3Ibwq9LiQd0unpVAxM?=
 =?iso-8859-1?Q?NycMcQehE8gTn5Ly2kAclubdCzzQ8qxFdFI0m3DGZ/egmq6iXVeiFmSO8o?=
 =?iso-8859-1?Q?fueUC0UTSL1+87pLYRyRL7sNXYLR10mPNpHEIePiy+6WkGTB8uS8ciQuw0?=
 =?iso-8859-1?Q?WmlhW3vSApEVQUSBGWWn3eUoauzIpWr59qzPr8Q8GTdgSQf7uL5hGaqn24?=
 =?iso-8859-1?Q?WNcuRAxVbgtBzBxswOvFq4fMGbb1NZCpv3+wPwI+wbeERliBkLnLKu6HI9?=
 =?iso-8859-1?Q?bIS0H8KGlqUa1tUzDhz5plZt8Yi/1fRwgKacNe/OGzVCnFrVI8MKDMbxZl?=
 =?iso-8859-1?Q?pLHuIsMToFyntMYhfzfntqpi5xoIMNJ64TF5c24ej7efzdGU6jIMcV8dbO?=
 =?iso-8859-1?Q?vFBA2KhVOvl6VRgbKDs9DjOCq3qGP6lgMtRyogO0tn1DwHuUCM++EsoJV6?=
 =?iso-8859-1?Q?IPmeltD4IAvWs8jehQD64Ec9n+zfkNFvW+dgQ+BbjMW7oQKPXGmuC/Juz3?=
 =?iso-8859-1?Q?ci6rI9R+10AMcfIcfWhoACIYAAf/41dADOgDhO04SorE9d+2NPiL3uezgi?=
 =?iso-8859-1?Q?/8lbjhEwpGFLTbPPXxjYsX0t0XOyuYFGowcCrY2JMJ/CpJXq6TIe3zkUlf?=
 =?iso-8859-1?Q?MxVbUNsQvaFOMl1/VaRVlCMHEL9DdF5M5/QbRLZK/pQVExwFRBrghigYR2?=
 =?iso-8859-1?Q?oDu4PIU2khT6rLhXSRUvglho7O95Z+T+vZFeOGwED57FfVCpdptNC28YSi?=
 =?iso-8859-1?Q?4fw1X3RgZSjKSiPf51xIVH7cVAJInURY71HSu/FreBRB2OuCYiz5nDChZN?=
 =?iso-8859-1?Q?HDKwPLbnwbilHlF2a31Nodm4d/NtGHZW7Zso1DH0Pprhb4zq5xExhyEvQr?=
 =?iso-8859-1?Q?qTdhA9c8mMEh1ZyioSJUauq4Yx25QxW4pW97HNeA4STxUmJdlWx45e0URV?=
 =?iso-8859-1?Q?0fYpflunkUYWod2Y7WuzX5wDHZlkuZNvnxBIJAxiDK3aRgPeP9OeC/yIdB?=
 =?iso-8859-1?Q?B+NxvK8PEKYACjfFtWRR471+PEfRjETQt7IrIY1BRGc+i0PijfMlUH8Q4n?=
 =?iso-8859-1?Q?9WdVL1A/NTwlxUJmQZLzDlzXDsTYiYgzQ7udWBKoH/Yu3pRACrRhoIg73T?=
 =?iso-8859-1?Q?3nbwfJBYr9xZeVET3BeSQzf2zlPw1dAGJKj0vtg7pC3tkt5XGdbcz3t8Ih?=
 =?iso-8859-1?Q?iQDs/mkwb67XfvqvaZuiqQLUdKhkagsTTwJLccxny/8tG7Isncm10WP4aL?=
 =?iso-8859-1?Q?ks0NUe6mCpikUAdsMjHA9irQ/BVdTjy6XgDkmvgscnqPGs8CzVgkJcFgYZ?=
 =?iso-8859-1?Q?Msx5uTGnvMsxXIely9gOUAkwszD4akMYdYyIP9X8gMyXRl9gyK/p2V5iyj?=
 =?iso-8859-1?Q?eVInJO6rF59rwLPY1fLv7zfCclPMatRYbB9gsHHm3lFjWFpa21tvcH9Iod?=
 =?iso-8859-1?Q?JixqTmSA3Sm4DJo347V3tLIIKe4jEVR4q+nIzZyb7r0YIplHRJwPdk1HTg?=
 =?iso-8859-1?Q?fRcyeuT2Ds8MdyahqfCP/I9BnLQ9SpL8fndhrM42f+5HG7XwQdt0sET5oN?=
 =?iso-8859-1?Q?viYtAn6t6VeHanV2tclNrzU3qBZLPo7JzAtWN8W3YaOoNmONmmQ1NFiBNC?=
 =?iso-8859-1?Q?2FarktTDgNvtnV7lh8ope06EF8KY8MbozwQ17qzi+j5Exc?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR02MB6866E35A2B4241CF3A728A99D3D22BY5PR02MB6866namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SwkfeBoVPPuoOF5f/RCEdvwDpVb8BzGWWL/PI3shwHQqDjDlIk1MiTKvctDnVxWincmLb/qH/UoYYL8O9n65LWZ/1lxxwn6l8qpmUZcbcno4xXIpAAbu09LZhoBd5ViPQmlWcOr7KVOxkc4pgSLGNYebhTr2w+Y9zz3eFHYGUsgQ7Kak1jjUV4zcBC/JtDaOve+9LPxhy174MN+ZygcdJL+jGr7igvLTPy99aTsjAciolPWSvT2MQrKojy3txJdF8RRBAh79pzHg8hX7f5DqEGL1ggJEF4bigYmbF6PVrkSx/AXEoDiYElBA7ufK/SlKkSSn86Di3O5jB4UznzwX3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FBBJLyFtbe2sy5RHCPvvZPvD12i3PgEv+JCRkRGWnp4SY5SjPx91ojLyEHrjHt820Lsx6YiYO/5FFzfm99qjnByS1kLocsn9v3BP0iwagjdxwXIEjDRPR0LuRuQ35QOzDseRQNJQgwWPok1amJzwqJfoAvpEG8Y8slLwIUburoLYrdlqGDtgOMAxWz/vjKjwV3ufkiFBt3Cp//+p7LruSUDKLfVNYgFv+bgBURYlI4hbd4PG90JKzn9OU7MGTQoY+PJHqjWeHQBBMSwxJ9/wSlJqn8n2ueIkUEbWarTqbw2Wj7GBX/kx9tF1959qDDZysCeIhpUaw88C9hMbE1TzM5ClEVHA79OEAGZCDls+ahhrPj+hXTnnQMuIobsnySLpYJAl3f8E5GpSC3Ybi8SJgAfTZn2i7OIzRC6wPG2LcyYvsKmWjJ4GqTXGh8TQ9QpTUYCe+5h/yQ+p0e2dr+tka7nWFCvgvylpkaZUa/ArD/MSTvPoUkVJZwyyzaJ/N37O7m0aan5wJFh0srZr0CRvwYgFSNgyxgpbrWZ+lwKopPSbpm6DFS3PtqRmxMd7ceCNCsmUrCiXtjXqnfCq5sGUS+hEOnseshdBPR1VkiEtkIdxM4QDjS/VgyaqLMQK1F1V
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6866.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fe45bb-2d2d-4d9a-fa5d-08def373624d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 04:30:02.8731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiErvfRfccWR2W970UsIQJ2ieiGxIdocmlhO+CGxH6/2pFmBy+qd59qURw3FCMDxWSV8k5jPaprERXF06f6SOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfXynKFbTaGlKew
 PZzQx4ciykbZl3YslbfKWYee1GpMiBLZhckWFXPwDzBFPNhQHoBAYSpJ1QHygwfUddMzBDe5TFV
 qHsBN/RyhijPljfzI+bYhXq3aA2rT0KLFjN+LW86qRK4PGRtAqM0yYZAdkH55fEmRFSGycAaMQV
 ZT87KHJ8HEdyZZ9yqn6fq/103vELNGcPH7HazRrATe4ou9w/sTpQuDvN3jlt7QLRmObJNhyucoA
 GNp8rdmYGnX7l302OIEAyZr2Dm9obPFvdM1UObPeAR05WptL/yDNSaupOv1fLNXZ02sTPv/vZjP
 Fkr4Ib+y8pf90vc0xrWV1jAxoSOsSf+62M2cPX2BNZPktz/UOEgRZR6jEb42n9bbYgz9PQex5Fm
 9jtgNeKFdkgQGkKRXa5bX2h6K4nODmL8zuKooviIzTiY3LYNIn5ZYt51d2n7XPe4HoTst85aFQU
 434uDCL7wdi9XxhhHnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX0h3mUf1BIEJW
 Y8rBmevOkGDsEP67Rwsafey7yqkxoT392VJXLccBVPBA9lJft0p/838z587Gb+2ZamaFkyT/3cY
 EHcgObA7cPelBwNpM45fjCwNNYFF6kI=
X-Proofpoint-GUID: o90YSCVydSOPpRwkQ2TfYJSfIN8rjVRD
X-Proofpoint-ORIG-GUID: o90YSCVydSOPpRwkQ2TfYJSfIN8rjVRD
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a740dd3 cx=c_pps
 a=bIbXKPR1jM9XdZLceGeTKg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=hXotQlNcC7C-2Yt5ytcA:9 a=wPNLvfGTeEIA:10 a=V8nqiAqmkI3wPzAPRPcA:9
 a=p2uNuvApzVthyoZA:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

--_000_BY5PR02MB6866E35A2B4241CF3A728A99D3D22BY5PR02MB6866namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
This RFC is intended to start a design discussion around Synx, a SoC-wide s=
ynchronization framework used to coordinate fences between Linux-hosted cli=
ents and non-Linux execution environments such as remote processors and fir=
mware.

The intent of Synx is not to replace dma-fence for existing in-kernel GPU/d=
isplay style synchronization. Rather, provide a global synchronization mech=
anism spanning multiple subsystems and processors, while still integrating =
with existing Linux primitives such as dma-fence and sync_file where approp=
riate. The solution has shown significant power and performance benefits in=
 the last few generations of Qualcomm mobile and XR chipsets, and is gather=
ing more use cases. Also, the solution is SoC-agnostic, so other vendors ca=
n adopt it in the future if interested.


Motivation
Many multimedia and accelerator pipelines on modern SoCs are no longer stri=
ctly host-centric. Work may be produced, consumed, waited on, or signaled b=
y multiple execution environments, including Linux drivers, userspace compo=
nents, DSPs, ISPs, NPUs, video firmware, camera firmware, or other remote p=
rocessors.

dma-fence is a good fit when the fence state, callback list, and lifetime a=
re owned and progressed by Linux kernel participants. However, for cross-pr=
ocessor use cases, a synchronization object must satisfy properties that dm=
a-fence does not currently provide:


  1.
Cross-subsystem visibility: A fence created by one subsystem must be import=
able, waitable, and signalable by other subsystems, including non-Linux pro=
cessors. struct dma_fence is local Linux kernel state and is not directly v=
isible to remote processors or firmware.


  1.
Point-to-point remote signaling: One subsystem should be able to signal ano=
ther subsystem without interrupting the Linux host CPU every time in the si=
gnaling path. Since dma-fence maintains all waiters in the Linux, remote-to=
-remote synchronization has to unnecessarily interrupt or involve the Linux=
 host.


  1.
Distributed lifetime management: References may be held by Linux and non-Li=
nux participants. Any subsystem must have authority to create and clean up =
fences. This requires lifetime state to be tracked in a shared/global table=
, rather than being owned solely by a local Linux object. dma-fence lifetim=
e is centered around Linux references, which does not naturally model refer=
ences held and released independently by remote processors.


  1.
Race-free global synchronization: Registering a waiter and observing signal=
 state must be atomic across participating subsystems to avoid missed wakeu=
ps/signals. Atomicity between remote waiter registration and remote signali=
ng needs a protocol-level guarantee, not just local callback handling.


  1.
Subsystem restart recovery: If a remote processor or firmware subsystem res=
tarts, references held by the crashed subsystem must be released, and waite=
rs that depend on that subsystem must be completed or failed in a well-defi=
ned way. Subsystem restart cleanup is outside the dma-fence model.


  1.
Global composition: It should be possible to compose fences that were creat=
ed by different subsystems or processors into a single aggregate synchroniz=
ation object. dma_fence_array can compose Linux dma_fence objects, but it d=
oes not by itself solve the composition of globally visible synchronization=
 handles created by different processors.


  1.
Transport abstraction: Remote signaling should be independent of the underl=
ying transport, for example rpmsg, mailbox, GLink or another SoC transport.


  1.
Linux integration: Linux clients should be able to interoperate with dma-fe=
nce and sync_file where that is the right ABI or in-kernel interface.


Proposed model
Synx introduces a globally unique synchronization handle. The handle indexe=
s an entry in a global synchronization table that is accessible to all part=
icipating subsystems. Each entry tracks: a global handle ID, current fence =
state, the set of waiting and subscribed cores or subsystems to allow point=
-to-point remote signaling, a distributed reference count, and parent/child=
 relationships for composed fences.

The design is organized around four components:


  1.
Handle and session management: Any subsystem, Linux or remote, may create o=
r import a Synx handle and hold a reference counted against the global tabl=
e. Handles are destroyed by the subsystem which releases the last reference=
, regardless of which subsystem it is.


  1.
Transport abstraction: Remote wait and signal messages are delivered throug=
h a pluggable transport layer. The synchronization core is not tied to any =
specific backend (rpmsg, mailbox, GLink, etc.), enabling point-to-point rem=
ote signaling without involving the Linux host CPU when both producer and c=
onsumer are outside Linux.


  1.
Linux interoperability: A Synx handle may be associated with a dma_fence or=
 exported as a sync_file, allowing Linux kernel drivers and userspace to in=
teract with Synx objects through existing interfaces.


  1.
Fence composition: Aggregate fences are modeled as parent/child relationshi=
ps between global handles. A composed fence can span handles created by dif=
ferent subsystems or processors, and its completion state is derived from t=
he states of its children in the global table.


  1.
Subsystem restart recovery: When a remote processor restarts, the global ta=
ble is walked to drop all references held by that subsystem and to complete=
 or fail any affected waiters according to the configured recovery policy.


Possible initial patch structure
If the overall direction is acceptable, an initial RFC series could be spli=
t as follows:

  *
Documentation describing the cross-subsystem synchronization problem and th=
e Synx object model.
  *
Code to manage Synx sessions and handle lifetime. And synchronization using=
 wait and signal
  *
dma_fence and sync_file interoperability layer.
  *
Fence composition support.
  *
Transport abstraction for remote wait/signal messages.
  *
SSR/restart cleanup hooks for remote processors.
  *
A minimal Qualcomm SoC integration backend and example client.

At this stage, feedback on the model and layering would be more useful than=
 detailed code review. In particular, we would appreciate guidance on wheth=
er this should be pursued as a Qualcomm SoC-specific driver first, or wheth=
er the cross-processor synchronization pieces are generic enough to justify=
 a common framework.

Thank you,
Pravin Kumar Ravi,
Qualcomm Innovation Center, Inc.

--_000_BY5PR02MB6866E35A2B4241CF3A728A99D3D22BY5PR02MB6866namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Hi all,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
This RFC is intended to start a design discussion around Synx, a SoC-wide s=
ynchronization framework used to coordinate fences between Linux-hosted cli=
ents and non-Linux execution environments such as remote processors and fir=
mware.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The intent of Synx is not to replace dma-fence for existing in-kernel GPU/d=
isplay style synchronization. Rather, provide a global synchronization mech=
anism spanning multiple subsystems and processors, while still integrating =
with existing Linux primitives such
 as dma-fence and sync_file where appropriate. The solution has shown signi=
ficant power and performance benefits in the last few generations of Qualco=
mm mobile and XR chipsets, and is gathering more use cases. Also, the solut=
ion is SoC-agnostic, so other vendors
 can adopt it in the future if interested.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 14pt; color: rgb(0, 0, 0);">
<b>Motivation</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Many multimedia and accelerator pipelines on modern SoCs are no longer stri=
ctly host-centric. Work may be produced, consumed, waited on, or signaled b=
y multiple execution environments, including Linux drivers, userspace compo=
nents, DSPs, ISPs, NPUs, video firmware,
 camera firmware, or other remote processors.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
dma-fence is a good fit when the fence state, callback list, and lifetime a=
re owned and progressed by Linux kernel participants. However, for cross-pr=
ocessor use cases, a synchronization object must satisfy properties that dm=
a-fence does not currently provide:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Cross-subsystem visibility</b>: A fence created by one subsystem m=
ust be importable, waitable, and signalable by other subsystems, including =
non-Linux processors. struct dma_fence
 is local Linux kernel state and is not directly visible to remote processo=
rs or firmware.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"2" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Point-to-point remote signaling</b>: One subsystem should be able =
to signal another subsystem without interrupting the Linux host CPU every t=
ime in the signaling path. Since dma-fence
 maintains all waiters in the Linux, remote-to-remote synchronization has t=
o unnecessarily interrupt or involve the Linux host.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"3" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Distributed lifetime management</b>: References may be held by Lin=
ux and non-Linux participants. Any subsystem must have authority to create =
and clean up fences. This requires lifetime
 state to be tracked in a shared/global table, rather than being owned sole=
ly by a local Linux object. dma-fence lifetime is centered around Linux ref=
erences, which does not naturally model references held and released indepe=
ndently by remote processors.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"4" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Race-free global synchronization</b>: Registering a waiter and obs=
erving signal state must be atomic across participating subsystems to avoid=
 missed wakeups/signals. Atomicity between
 remote waiter registration and remote signaling needs a protocol-level gua=
rantee, not just local callback handling.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"5" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Subsystem restart recovery</b>: If a remote processor or firmware =
subsystem restarts, references held by the crashed subsystem must be releas=
ed, and waiters that depend on that subsystem
 must be completed or failed in a well-defined way. Subsystem restart clean=
up is outside the dma-fence model.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"6" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Global composition</b>: It should be possible to compose fences th=
at were created by different subsystems or processors into a single aggrega=
te synchronization object. dma_fence_array
 can compose Linux dma_fence objects, but it does not by itself solve the c=
omposition of globally visible synchronization handles created by different=
 processors.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"7" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Transport abstraction</b>: Remote signaling should be independent =
of the underlying transport, for example rpmsg, mailbox, GLink or another S=
oC transport.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"8" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Linux integration</b>: Linux clients should be able to interoperat=
e with dma-fence and sync_file where that is the right ABI or in-kernel int=
erface.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 14pt; color: rgb(0, 0, 0);">
<b>Proposed model</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Synx introduces a globally unique synchronization handle. The handle indexe=
s an entry in a global synchronization table that is accessible to all part=
icipating subsystems. Each entry tracks: a global handle ID, current fence =
state, the set of waiting and subscribed
 cores or subsystems to allow point-to-point remote signaling, a distribute=
d reference count, and parent/child relationships for composed fences.</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The design is organized around four components:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Handle and session management</b>: Any subsystem, Linux or remote,=
 may create or import a Synx handle and hold a reference counted against th=
e global table. Handles are destroyed
 by the subsystem which releases the last reference, regardless of which su=
bsystem it is.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"2" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Transport abstraction</b>: Remote wait and signal messages are del=
ivered through a pluggable transport layer. The synchronization core is not=
 tied to any specific backend (rpmsg,
 mailbox, GLink, etc.), enabling point-to-point remote signaling without in=
volving the Linux host CPU when both producer and consumer are outside Linu=
x.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"3" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Linux interoperability</b>: A Synx handle may be associated with a=
 dma_fence or exported as a sync_file, allowing Linux kernel drivers and us=
erspace to interact with Synx objects
 through existing interfaces.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"4" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Fence composition</b>: Aggregate fences are modeled as parent/chil=
d relationships between global handles. A composed fence can span handles c=
reated by different subsystems or processors,
 and its completion state is derived from the states of its children in the=
 global table.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"5" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:t=
rue}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: decima=
l;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;"><b>Subsystem restart recovery</b>: When a remote processor restarts, =
the global table is walked to drop all references held by that subsystem an=
d to complete or fail any affected waiters
 according to the configured recovery policy.</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 14pt; color: rgb(0, 0, 0);">
<b>Possible initial patch structure</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
If the overall direction is acceptable, an initial RFC series could be spli=
t as follows:</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:true}" style=
=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: disc;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">Documentation describing the cross-subsystem synchronization problem =
and the Synx object model.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">Code to manage Synx sessions and handle lifetime. And synchronization=
 using wait and signal</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">dma_fence and sync_file interoperability layer.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">Fence composition support.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">Transport abstraction for remote wait/signal messages.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">SSR/restart cleanup hooks for remote processors.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1=
9px;">A minimal Qualcomm SoC integration backend and example client.</div>
</li></ul>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
At this stage, feedback on the model and layering would be more useful than=
 detailed code review. In particular, we would appreciate guidance on wheth=
er this should be pursued as a Qualcomm SoC-specific driver first, or wheth=
er the cross-processor synchronization
 pieces are generic enough to justify a common framework.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Pravin Kumar Ravi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Qualcomm Innovation Center, Inc.</div>
</body>
</html>

--_000_BY5PR02MB6866E35A2B4241CF3A728A99D3D22BY5PR02MB6866namp_--
