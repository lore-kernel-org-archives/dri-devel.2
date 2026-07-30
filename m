Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDAC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4FB10E0BA;
	Thu, 30 Jul 2026 08:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="OTbkxVN/";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="EOAELwnY";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9508C10E0BA;
 Thu, 30 Jul 2026 08:20:09 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U6eFQD2770200; Thu, 30 Jul 2026 09:19:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=2vKup5cUJpzXVtyQnzvEbEtJ6WVpEJCqUkbcNc8PL+M=; b=OTb
 kxVN/5YQvl6wVlDyzbCPuVxRF0Gar1jtcrL/2zjiTDQ2r61bPg7S3tthXbMCi3P6
 2Y4j75yOuUF88x0etPwW77L6CJX+PSsNbsSess6Q26Z8rdo2Tj66Y4NhfFWLmuX/
 gyC7TnBAuFibBCAmTIg9Ruz+R05ghDejQaf/9L3UTvP/qRwE1OhLeUDmGoSv4R7u
 8jWksU/mSuwhVlLTCzgLKUshLTKbWKuQHR9mgGJJ1JSUBi75CoUg2W7UQ/CK7e2o
 smgndbilX57pgzT9QJZQRtGkxNp5Wwk3EROhW5FuyQ+sw3fYCQzLgAPtvt7KFDxv
 DkkbemKovYgK1WjHovQ==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021119.outbound.protection.outlook.com [52.101.95.119])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr1aew-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 09:19:53 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cujastqG4pJIgmL2aCoE50CuZB24/WMenw7+Ve3WXdZu0ojTL5NYxSq4vDJYHb6owhla/1K1UU+5PbVWQ6CAfjGM3didDT0ijtqUS/C+9L5/oDNqsbFFj+JVmJ5nJFxPWs0qPpapljNRczZ/CVjKGzmBzsiFWh7bPqHksGi4JcF3qKy8gpYb73trHTTAXD/tJkvMc94ry/cHEhUqG+RXFQZEo1DIhRHNunGNo9cZXYx5tJ4dXlISi6myEE06JFcx5/yV536fmahWUnprUUsDvQogm91aUu30YEmWmWD4EW7kONY7R7KdIi7ReRKNzIABEQdhW6CzX2xPNsl/or3ubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vKup5cUJpzXVtyQnzvEbEtJ6WVpEJCqUkbcNc8PL+M=;
 b=g+yeDNHxYOxPXgUFYv3JNv6J1XO/qR8RhOc04KRowRYuYaNzjugyHP7gucDHHUuaQ5ghJahlNLtLf9FemZw67RkLbIRtqpqzKOFL4bwiEOuG/p492Lu0aG8veAThWUsYOVOGDz44o0TRe4lHUpW0ZucwTupXCU0RgynpBcHE7HAxgRGxQ/c6bugZxhxhxwq7tDj5uiCOflnJQ7buLCLi/z8obOLFKfaCdB4z+aTUaKQfrSTCZBJ1C0HSGDL27zNW2Lurg8x35NcbrV5GNfgB/jAFxbdkJbplNR1N0Y3fvIp9sEgFTwyS5E9vrNtdHaYNUQ2CMi+hFzNE6z7IJxuFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vKup5cUJpzXVtyQnzvEbEtJ6WVpEJCqUkbcNc8PL+M=;
 b=EOAELwnYdeaIfNT4H0xK6dhmEslLVbje6V5MsLHvg608Xt2+oR3EhtSQAapFI75wf1sx/t9NTsPgNcmnwG69LbDhnr4E+008F+fV3MEp2hEzTCxQ7XPn14FRZG/arCSNzEfEcTadK6zl7WXDA7/wDdVa7JPxZTMA9w/52pBIqKU=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB0878.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:430::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 08:19:48 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:19:48 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: Set scheduler timeout period higher than
 Firmware timeout
Thread-Topic: [PATCH] drm/imagination: Set scheduler timeout period higher
 than Firmware timeout
Thread-Index: AQHdHxF1MVAq9R9SA0CfYPb+58F0WraFujqA
Date: Thu, 30 Jul 2026 08:19:47 +0000
Message-ID: <0e6f71776667f6a36fc7a7482c985e9e044051ae.camel@imgtec.com>
References: <20260729-sched_timeout-v1-1-4adc801b1997@imgtec.com>
In-Reply-To: <20260729-sched_timeout-v1-1-4adc801b1997@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB0878:EE_
x-ms-office365-filtering-correlation-id: 8527e479-3178-4d04-e706-08deee1351fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: eCy9MK6qeX7OUcpP6RBU7JdgxBEnSSgfNSn68LCqgHAGhwIUgLNOsRIeDuVg1wul0eyldJPerM+HIePO/QrwQ9SoYMQQnhrPLx1YZQ+ze4K8EZxD7zvny6goKNjLQ1k1rHJWsmjwECoTIStK/n9/KjjV6WEa3wid0NE2aiNSPiOQ3dZS0DVEPWY006Ln10Pk4q/gdt4PncZiN3d0l/2donKDS7ldBQZlYkRWoEZL7Clfncp87mHkMbMZfXNVObkMx4B5BdY6BlNr/zVN/aqnumGAuA9uy7/qfLxSLHyAVcx9b9Qy8SfAmd+mCEq74w1ZI35w1owTcK83KJgtw2wjzTzQg7VeJHqGJ2pLKRjBxNqpTXRQzwKoZl2ePq/Oaul+83ZpriiZmJW8I3DmviQxxFbkjzbjkr0ITN2nz1yVgVwDccp6ekGhT7Wx6Vp8zGCRZ9iRKqVmvhXCoOR/H+TS727PM9ZtnMPDhAtuKctWj2KaZqwPxc0uGHWLOBCRSFvoRPS5He8y7OyK+mNArKsEQVb+1u7LaJbAmpEphxhs+NjUVp14VdYkkwHGnMBonUbJEa+JBewe1pwNx2/cN178cZZ3HEmhW80xg9s81s2zNJ+vrUy0w79evdBXyDEvGKN6wfcZ7Pb4R5XNHLmLOvs42+B1UZWWLnTMV8GSa5DaYWcDV2p/TkHtaOJR/UPWldgvuisimyuozytu7bIZ3pTlRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZuRm95a0FIWk9XVUkvc1lXNXZmVHU0R2plY1FYVGNrVzNTclRmTmRacTc3?=
 =?utf-8?B?bFNaSFZtOGZxNFpXV2VJWHZSa0ZBYXJzVnVSSHl2OEZRb2pKTGVaaFhvZ01F?=
 =?utf-8?B?TTg5aWtsZmEray9mdWVNT3RnN2pRK0NyeE9sTE90YW1pU0ZmSXQ2Um1UREFW?=
 =?utf-8?B?MzUySTMycUxGenEvNnpta2U4VWxUVVAra3B1QndBaE82bS93aGVwei95SUJZ?=
 =?utf-8?B?UGptZWQ3Z0JCK0h1YTNFaEExNHdNdWdhSk5Ma3lGang2bWlyWkhUSnVJSlF5?=
 =?utf-8?B?cFN6UG5aT01SNFhzRk50eFJGMEtWdVdGWGs1dHR0K0w0ZlFCUGEvMWxaTVlL?=
 =?utf-8?B?Y3ZnRGVRNFUvUkg0K2Fuck4yQy8zTVlBaVVXbGZoeFV5eUh6Z01yMFo5NlNr?=
 =?utf-8?B?QmZQOUpDcFhqWnhlTlV4WnNOR1lqL3YvYnR1UXhXd2FvUEhONExlTzkrRHpq?=
 =?utf-8?B?UkJ1WnpzVU5qT3FhMGJlSUpHQ2ZvNm9TdnVPbVhwazBTUE9KME5zempaOTNw?=
 =?utf-8?B?dFRMdWNmYWE5aklDNmZNWXdZMlJiZHNHc2VFUC9PZFZhYWMxM2xlZnBwZVBl?=
 =?utf-8?B?NFdvbFNnRVZPU3ZXdU0xSUN0N290dlIyUVdVWGlFOHgwNUgxOXJOeHI0NVAy?=
 =?utf-8?B?UUtVRkRMVnFCU2VFQTZLT2UvdVRmV2VzS3FpOTM4UHlqUU4xaCt0ci8xQk5P?=
 =?utf-8?B?Zks3d2dlc1BLZ3RhckJSNkhDRVF2MHc4VFA1RENjODNOUExjSFBIQnppeXhB?=
 =?utf-8?B?ckZUbHR1RDdNY0U3TjY5YjNjS3NMTUdFdzJ5eDgrK3VGbmQvN0Jic3ZhQWJp?=
 =?utf-8?B?clo1YjNYUW9CeE1kNndNZ3I1R09WT2xvQmg3UThFbzg4U1h1bHF0d04rSTc0?=
 =?utf-8?B?dmxibFh6dVB3eURKYm03Q29FNHlYaVY2MUZobnI0L0JZNXROd0VWa3JNbkxZ?=
 =?utf-8?B?ZXJWNHh2R3hiaDBUdHE4M3VpUEp1d3gydXdwS1Y1aHdibnNpMjNONU1Bci8y?=
 =?utf-8?B?UXE1QmxNUUVIWWRtSCtZQjlKMW1pNnVUaHBkak9ISzN5akJ6YXNNTFVqS0hp?=
 =?utf-8?B?SUdqc0lTUXRYQitzUEJxQW5SOXZMU3dDUldabjhPSytNSUxrclBnMk5CaFdR?=
 =?utf-8?B?cVRHcllPMHJuMDRJNzBtZ0FkOWNZeFJKUHNmVmVNM2hmUDFOR0Rac05pamF4?=
 =?utf-8?B?akRUS1o2RjV3VG5ibHNlV2R1Yzdlek1vUXFaRjBvZjEwN2poWmp4RlN3NUs5?=
 =?utf-8?B?cTBzVUljZUdEYWRQUXlqNzEyVnFuN2d4SVNZdVo1RmdJd3V4eWxobkVvT2l0?=
 =?utf-8?B?azZMYmY2ZDZIb3M0VCtkVXJuMWdsdjU5V2NwQ0g1czlmTXpZaVIzVGFmYlJQ?=
 =?utf-8?B?SmhUQjF2K0p2d0dOazJjT05vSWRUUk5GcU8wVk8xSjBIY0xLK0JrZUFuSGVU?=
 =?utf-8?B?cnNFMkptTkMvakhhUWw1bXh0WUlRK011d0JaYmdJVmg5T2ZmQm1IeGQ5N0x6?=
 =?utf-8?B?WC92MEtOd2JTU0FhZXp0MWN4U3MyalQ2OG1kb2hJdVQrKzZzSXp1RGFDS3NC?=
 =?utf-8?B?cmhRUkVLR2IvYUxNczBWUDZnU0I3TjM4alduL2VTRnJ1YWpEbFdsZWxFY292?=
 =?utf-8?B?czNuVzkvM2dselJCVG9VWC9WeFE5YURhTksweDAxYU4wL2d4YVJYZk5JNWZ3?=
 =?utf-8?B?ZDVUQm5jdFZMdXdOcWw2V21kYWZQejdYMmVvMlFSamppSHdQK2pTQzRaTlVk?=
 =?utf-8?B?ci9SSC9aVHlwYnJJTVkrRXkvL3VJeEhVME1qN3BpdW81Z0x1WjZEdFFpT1Zs?=
 =?utf-8?B?Mk5oRGE4clRyblJoRmpXeGVObTN0aEJZc3NHcWZSNkVSVlNKSDdEOUdwaklT?=
 =?utf-8?B?SHAyZ2F1bmVFc1ZRNGZZZStzTVdtR2w4S09scFd1dTVnNjF6TXYwQWRkN2Qv?=
 =?utf-8?B?RTVYUm1haGdkTWxMbEZTTm1WTkJYc0xKL1dmV2JLMzFJMmJFS1lWWGNGWm9i?=
 =?utf-8?B?V08zd1ZUMEdkd2RqN0NpanQ4QjQrS0N2QUEzdTZkaXk0Z2pWUW5FZlB6ZS9S?=
 =?utf-8?B?YW9JQm44UVIxbFdtK1pQNzcyblUxeC9MM2hETzdpZkVWV0NLcThmME5OamUr?=
 =?utf-8?B?eUJTTkE4OEFHek1PSjZ3ODVIaTFkVEd5TUg0WVR0OUJvdGtPS1lJWVhCOHVV?=
 =?utf-8?B?VjdGdEx0d0lGNHBZenFsSVU3eVV5M3hFL3k4R3U4bnpMMTRNbjdialAxR2tT?=
 =?utf-8?B?Y3ZGelZLQ3cwbWZjYVdBdnZEYjRFSzVrazY2dXE5dm1Zc0ozNGQyRitCZ0Y0?=
 =?utf-8?B?RUpHR3VCOSsxdXBzUFd2cHR0c0xRWjMrMFV1K2RRNHVzeVdjMm9Mb3Vzbnpt?=
 =?utf-8?Q?IFe8X13Hl2ALGncs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B985E78B863EE2499174E6CAAA89ADA2@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TT028HkT04R7HPIGOQmHeeGIc6aig3z3iLt6ZDrf+lJ/brQh79ROor7k2HDX8+SYxO9vdVvAv3P+ua3FYy+LPDn/4r9xAYn+lMyusiAeAoTzUFocCcGPuVoqZ0d98vAGQOE5uHNMbZOiCPznf1DrBhEdTXvNLUQWgrxPUOAul+DiWD/SY++wobIDddKv0vnV0rURnZKy2Rk9QSKULfvvkX+I+q+n6m6JzgTIwsIMAWPvW50iTSRTpydx81MrtBSjxouy04s1XP8i3bPmbwd+d6ZTPBSCjQCSa6MUDv5OUDbIWWJpuhftlmbQTfeqvegbBGDZUee1ET0UuPD6MxOw1w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8527e479-3178-4d04-e706-08deee1351fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:19:48.0051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEl8N3zML4t728ehAbtxAouiVRc9HuGzExKJb6IOgLeWw77lxhJ/LTHCcAZJBTJxDEnchE1CUcLsEmm+nWsao6QdtfOp9FDyK4ZuhTCiEPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB0878
X-Proofpoint-GUID: xzA0A8kqtjmU_HA8vz1r5eqb3dP-OSV9
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6b0929 cx=c_pps
 a=umo8TZUd7E50GOAIdb9AxA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=5aeDsUAm1l6IIg1PUPMA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1OSBTYWx0ZWRfXwUqlKR+pL6Gi
 uzfG3Q9krv6bKP6fJVHef0cL3Eoeln1LbKtvKDE/w8hsjqpVcZOVjVKoX3X9DcnTSwvymkyaKBz
 N5n0H1SXQbltn1UpHOZBGhkQsq62+ZSNvv5WpM0uv5sdNa3VkCniBUQHLJW9BUm+kUs7ms0fnXP
 GZIXLhD3m9pJXBv/N76CE9icG7e62yABp2cDZ4sB7h70vgLtPyBP8Ffzd29UrZ4R7PEhhi9l8G2
 ZlB3i/xQ4iYSQHhR67zFKOhpC4vEqNx0/IawV64NM82fI9J75uqn1hTtAJoks325JjrtKbRp4Ec
 BEJRT0WAAS/smov0j4siBsEq1SxE+9uYiz1w2/vi4eyYgbre2xDu9Vk0e6Xn6F7hUkWoaOtwe5+
 6Ua4Yc9pEXe4r0/tV8vWnJMeAF6B1malEmn54YjrFIIRqo917sdUmUrcttXR711YtXLvpKjjz4Q
 3CZNnxiOWAvmIlQZQ4Q==
X-Proofpoint-ORIG-GUID: xzA0A8kqtjmU_HA8vz1r5eqb3dP-OSV9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1OSBTYWx0ZWRfX6JWkYdK7KHw8
 PzSuftxCZkYIOq3ChRkTXiaJ1K7ZtvvVsmOWK++e91V/dynN0HEXPxeaTiRuzj24ZsBkEhxziKo
 GXcWqysRRwHQq6KUCQ8w7wMrHrxT1zQ=
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

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDA5OjQ5ICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOg0K
PiBGaXJtd2FyZSBzY2hlZHVsZSB3b3JrbG9hZHMgb24gdGhlIEdQVSBhbmQgdHJhY2tzIHByb2dy
ZXNzLg0KPiBJdCBpcyBhbHNvIHJlc3BvbnNpYmxlIGZvciBkZXRlY3RpbmcgYW55IGxvY2t1cCBh
bmQgdHJpZ2dlcmluZyByZWNvdmVyeS4NCj4gDQo+IFVwZGF0ZSB0aGUgR1BVIHNjaGVkdWxlciB0
aW1lb3V0IHRvIGEgcmVzb25hbGJseSBoaWdoIHZhbHVlIHRvIGF2b2lkDQoNCm5pdDogcmVzb25h
bGJseSAtPiByZWFzb25hYmx5ICh3aWxsIGZpeCB3aGVuIGFwcGx5aW5nIHRoaXMpDQoNCj4gcHJl
bWF0dXJlIHRpbWVvdXQgYXQgdGhlIEdQVSBzY2hlZHVsZXIgZW5kLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdl
ZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3Ms
DQpBbGVzc2lvDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1
ZXVlLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfcXVldWUuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcXVldWUuYw0KPiBp
bmRleCA1NGU4OGI0MjA4ZDcuLjA5OTkzZTg1OGRmOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9xdWV1ZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
bWFnaW5hdGlvbi9wdnJfcXVldWUuYw0KPiBAQCAtMTcsNiArMTcsNyBAQA0KPiAgI2luY2x1ZGUg
InB2cl9yb2d1ZV9md2lmX2NsaWVudC5oIg0KPiAgDQo+ICAjZGVmaW5lIE1BWF9ERUFETElORV9N
UyAzMDAwMA0KPiArI2RlZmluZSBTQ0hFRF9USU1FT1VUX1BFUklPRCAoMiAqIE1BWF9ERUFETElO
RV9NUykNCj4gIA0KPiAgI2RlZmluZSBDVFhfQ09NUFVURV9DQ0NCX1NJWkVfTE9HMiAxNQ0KPiAg
I2RlZmluZSBDVFhfRlJBR19DQ0NCX1NJWkVfTE9HMiAxNQ0KPiBAQCAtMTI4Myw3ICsxMjg0LDcg
QEAgc3RydWN0IHB2cl9xdWV1ZSAqcHZyX3F1ZXVlX2NyZWF0ZShzdHJ1Y3QgcHZyX2NvbnRleHQg
KmN0eCwNCj4gIAkJLnN1Ym1pdF93cSA9IHB2cl9kZXYtPnNjaGVkX3dxLA0KPiAgCQkuY3JlZGl0
X2xpbWl0ID0gNjQgKiAxMDI0LA0KPiAgCQkuaGFuZ19saW1pdCA9IDEsDQo+IC0JCS50aW1lb3V0
ID0gbXNlY3NfdG9famlmZmllcyg1MDApLA0KPiArCQkudGltZW91dCA9IG1zZWNzX3RvX2ppZmZp
ZXMoU0NIRURfVElNRU9VVF9QRVJJT0QpLA0KPiAgCQkudGltZW91dF93cSA9IHB2cl9kZXYtPnNj
aGVkX3dxLA0KPiAgCQkubmFtZSA9ICJwdnItcXVldWUiLA0KPiAgCQkuZGV2ID0gcHZyX2Rldi0+
YmFzZS5kZXYsDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3YWI5
ZjE5MDM4NjBjNGI0MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDcyOS1zY2hlZF90aW1lb3V0
LWM5ODFmMzU0ZTg1Mw0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=
