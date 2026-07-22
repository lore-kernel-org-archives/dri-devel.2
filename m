Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6926DC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD2810EDCD;
	Wed, 22 Jul 2026 14:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="CUlsfnWR";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="JPAS7uRw";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B5C10EDCD;
 Wed, 22 Jul 2026 14:06:54 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDY81U3939921; Wed, 22 Jul 2026 15:06:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=bbz871HW4yvpcL73gGk0vSMqezI/Y7POVHbRjOx155I=; b=CUl
 sfnWR7ADu1YUEaJ4axLaQ+W9KjhqnmilbpVP6N8dnyEmbYgugtJV2VW/F7E6dUwT
 EEEZqdEqQu8NSLfgTTiGk9DhkZiRq33BBLCESjcGhLWsgSKakLu4FOgfoC2kmUTJ
 X9awKDfjXfdok5e1Vp63enUjYYgRvIqfmMGYV1kCwgVUhbROjRDUzriIaAC24Kpe
 sddvjgE/8uCUX+I5H2ywqo+VBajYxWxns4ho8Sm9IVKgueVZwfjpN1vwJ3yNLBCi
 YzbmdWZ1LZ+s/pJEBrseAL5sZJhA5NaVJQaoLsXqB5aOh17nefL7dSnLKNUYXTkY
 4C2yN/qWVcfw1tqW2QA==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1htwu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 15:06:43 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkB/GT/71fWWz+CFKYA1GpXpXg7pwJO8jEWH2XrM5syh4rVWPgs0JPy0NuBy6tDi9rfk2b8Pj2R5LnMro5kGbP0RAjZOxlDgzIIquKvc/PYYnRODruHrDgbjupFXcDKNF9m9jkEQKrCCxGIEtIIggP8R4YAIi3TPiFqq16mrpIoPqS5mxSy0tugajpI91FnPeq87qPt2PzrTCnz0SchQgKKeCG/kFZ99uquT+DxeGV82eX4p6eTStqDGrCrjlYjwP325IjAnQxX52AdDOdN6w0KQsGzcZPnQ2Z3vmQftwTVZWuIEKaDKZMNrnjZqqDbSaOJNMDGJzAcDWEnM3+Mpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbz871HW4yvpcL73gGk0vSMqezI/Y7POVHbRjOx155I=;
 b=DNFnaKrS02eXdLpmg0ZERIhefMQj6sE45zgY5y6Qxgdw1kcDOu9zwwFl28l0/hmvI05aL9G7xtI4TW3IRb647H+K47/WGBBsuei3Hh8ymEqndF1546USQP8pmrwPy/+JpswB3rPDymZmBZ9NeQ1An3VPWMizc5h4AydhpgaXajSKGyw7JKHIhj4Ndx+OexScXdKiw7/mGUUfF4MPiBIImrMBspf85whk5u8pX8u5NgnzP2wDqMH34TCmXSGZWsZKqApz9nW2X4rJp7pU1x1u+rEkOrJIlgXpLQdiRkCZZodd3/cAqdH2Nykwcb+SZu6ve938TXzFO6sStEpDCueNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbz871HW4yvpcL73gGk0vSMqezI/Y7POVHbRjOx155I=;
 b=JPAS7uRwj86uZHOCBfkNv3ckQuhBBiRhN9YuHrFklsSy7/PwU67pwfH/AfSBu5hxMYHQ8W1TXcMyW9286HvDM/YE7ej72pxp14H2uTYY+4qiaJ32ucBQDOMg4oQQTQncuBVnyHX7VHswlTR9wPIMqwhQN8JabrwC1Id/MuPn3rw=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by CW1P302MB1144.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:06:29 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:06:29 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Frank Binns <Frank.Binns@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH 0/2] drm/imagination: update BXM-4-64 MC1 support status &
 GPU support docs
Thread-Topic: [PATCH 0/2] drm/imagination: update BXM-4-64 MC1 support status
 & GPU support docs
Thread-Index: AQHdGDw1Z0ZWbLJKIkOxt9DgRxM8MLZ5lhqA
Date: Wed, 22 Jul 2026 14:06:28 +0000
Message-ID: <38cbb3bf560be8e9384d02351717316d16170745.camel@imgtec.com>
References: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
In-Reply-To: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|CW1P302MB1144:EE_
x-ms-office365-filtering-correlation-id: a74f2bea-8c0b-44db-9b8a-08dee7fa6cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cP7xoOWixPKFAhfu+zQfrDEKPa/J7hdGyrL1sv7awagmFeM9fKXCtjE2CSoG92KokizAvXL2TOX/VBEmbbajvvWJf23K9VBJhlX5jbk5qOPJvxAYGLmq5ajCab7oXPGQWpX8KYZlOhbl6dSZfa2nGxvzsKAXF+EVzz18sSFJqGIR3a46Pd0EJwuRtP0PKaNHyxxp0arUs1TPlKBvL36T0rtu3WiDyMzndl12je5SoG9qj5Zcwjx1f/lWL199fJ6RE+wMhyxVOYNQ3zlXrdHrQRLmK71HjnYljMRfJQIBSbFsewzNYZlun5YhJV5Ix1uIRz6z4BiXvUZfOiHFhTPPP2vesl1h17vIDbc5wxWObDXM1WevW7gGVQlozjeFM5IhKU1eq9e7DLaAzSeluFB6xNMDggClJ/8vzur0chHxJf0o/T0Xim5S8MbGtci3hcg40ObbQx3+dfA4LhOzzUtdyuurPZsieg+QxxloNYQmr6DM95QXET2ebdRNZiUdCzoyuX2lc37H8iLPLmvHZHv1U+NEQuBJ5Jek2Mm62H7gWtIFSKpx2VxqemR5lu3rQOI9t3iy4EYndfVvHsvgBMw/CVWde7sndy6jot+i+WujogLVyg55JZMnJD8BK30B9K+yA1It89PVAkyoqyZXayMRPNAacrn82EDrZHm/EOpd8x9ayvviEA8kjOkqizbYVpLDXz92MfF7qrje6cHwwllEK/i1KIbf9pGKYLGRP0j6Cds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEdnV1ZWUjZwQ1pUdzJVeWQzZytyZXZhd0pqMERBSmJZSGtXNXY4VTNtdWkr?=
 =?utf-8?B?Nnh0OXJrM2ZtYW9BZ2dGb09Rb1RmREtIbUREVlpqTStkVmo4M1NneHZ3eDdu?=
 =?utf-8?B?SnROeXlRMENweTN0RjBlK3hHQ3hTZVFKUUdzTEZzcnFaUUhCTGlIdkY4dFY4?=
 =?utf-8?B?TFZmQ1Q0SDBFTUdPazRmeGFLaEIvQXZ5Smh3NjVNSGhiS2ROanpiWkNiV3lQ?=
 =?utf-8?B?YTBINEFqeGdoaW9oWWQwRzZFM3ZNWVp0UVdQcGxaakRKQ0RCQWZaK1liZGZj?=
 =?utf-8?B?b1pXRlZ4dFpRVGh5ZFBLblozRHhaOE1SeDg4QnVnZ2tEdzJDNGxCTHQ1Q1FV?=
 =?utf-8?B?a2tCR21LZ3RCRFl5cGNPM2JhQ1hNVlhFN1FseklhNWxiR3dmNTF4UFZSY015?=
 =?utf-8?B?U05SYkZyT1BpcUFuZlNQcThPSjZOT2YxTHpNOElhM0I2UHo1UHpDb2VYMU04?=
 =?utf-8?B?cXgzV1A2OStzQXQ4OHRSekRXUWx3cTVPZ2g4TDRCbGc3aFE5cUJ6NE5TbmMx?=
 =?utf-8?B?a2x0RWZueWttY0IxbDZ1UDFpS3JkLzNDdlBJWlAwL2VKdlJiWUIvYkZxaVBW?=
 =?utf-8?B?elZ5VEgrTmVtbEUxM245NDF0ZGhRbnE1OC9oYWxRSXc5N2Jyb1ZpWkNod0NT?=
 =?utf-8?B?d1lINm1RdUZ3VVFMYkFFMDRkSWhrNW9GemdGc1lRY1YxODREdWduc29aUWJu?=
 =?utf-8?B?MzlKbFhtaUNtZ1crRXhBRFZLM0NXWHI3MGE4RjU0a3NKY2RmRm5FaU9RLzh2?=
 =?utf-8?B?cHpLNjdYcGpWV3VBVlQwSnNrV2xvMjkvWWtiMCt0QVlsWXdBYzIrSDlDN3RX?=
 =?utf-8?B?bVBkM2VhREpvMXgwS1ZIV2lPWEVndndrbmZRRXFQSXFQemlhUmVZSmJQWnp0?=
 =?utf-8?B?UVo3a2Fqd05wTXg4TVJ2bTE4WWlEQnNaTmwxUDF2a2ZwMnc3V2RuWGZqb3ZF?=
 =?utf-8?B?RzJOak5GaTlSWlNRaWlWRVd6azI2S0pzWlpZcDJCMnZVVnRkclZOQjUrYmZJ?=
 =?utf-8?B?aEg3YmVLV3VFUUxsaFJzSGdVeVBCSVk0bG5ZNUVRYzA2TWlEUkZvWktmek9G?=
 =?utf-8?B?ZUo4Sm5GZmlrbXBIblBrenhHd2x6QXU2c0NEcGNQb1FEVFMxWWt0Zzd4WmpU?=
 =?utf-8?B?WmN3a2U2NUt2NmpWWFBnd0JzZUdoYW05MSs5N01vWlNuN2ZkTXhWU2RreGx5?=
 =?utf-8?B?MWU1bGZka20xVHFpeUhxUVJpNWVUdlBobkt6VWEyUjBMcmVYZVpmOE1lbVB6?=
 =?utf-8?B?K3dRVEFsOUgvZ084ajlra2JsS0ZkM3FLQnpZNEtaTHA5Y1h6dzlQNGFpV0ZI?=
 =?utf-8?B?djZJdDZML21CT0NpcWZsWTVEbUlhN2JGRUZGT24vRzFpS3BnTENZL3A0THM1?=
 =?utf-8?B?YjdUUjVMV2hPMXF1aVBIbjc5R3pmbGtubjlXTldiVEFYaTE5V3JYMnc5MnN1?=
 =?utf-8?B?WnZENzAzSm9GMUNzaTlVWDBtNXpYTVpWUzdrQlRIL2ZGWWhVREZTNk50Z1pV?=
 =?utf-8?B?T25xUCt4U3kyYnJwWlNCVzlMWU1Wd0ZnOTdEbzVZL2J4K09ZMnVIZFcwN1Ez?=
 =?utf-8?B?SWZWRWk1YmEzdm5FVytsVDNvL1pMdG9KWVMyaDJqa2NnZVF1UE85bDJpdUZH?=
 =?utf-8?B?Tk50ZnFNTWFqVWF3VXBkd1JKalFBdS90SXN2QU9PQzI4Nkh0Z2Z4SDdnMm1C?=
 =?utf-8?B?RHhPK201NVpBOW9FMVRNcThnTmFuVjZlcXA0OVUvcFhhOGthaEZEUTZaOTBy?=
 =?utf-8?B?L2x4WE01UU5WUEhSK0xsS0JHaHVEYWVacEpheU9sRlVvRnoveGRQTlU0MmY5?=
 =?utf-8?B?L2dLd2VnSnIyTjM4WHpvdDByZndBUUJOUFcrTTBkcUU2ZDBpZ3hoNW5xMlA3?=
 =?utf-8?B?Q0pka2hqWkdMTXpxTFZaQWJXSjdxZjZmQytZNlBJOHh1Y2c0UURTcGhEUWM3?=
 =?utf-8?B?N3h0QktQUlFqS0hkWURPQ243cFRFOUhDVzlpZjF6cVo1eC9GVHpsM3IvNC9E?=
 =?utf-8?B?ZUFLaklpWFo3ZlBRcTNkSUtramgrZnpMcVJuWUZyYkVFOHY1NUMyVlZ4cDBp?=
 =?utf-8?B?ZmdLOTk3S09HUnVCVkZXb25RNlNIMHJVRU41YW9lQUVocmVBclVwQVNscndy?=
 =?utf-8?B?RTQvQVZnQm5mYzUvQWVKbVdPcXlBSDNKODNnYy9pUUhRd2E5QlRlQUpYamlW?=
 =?utf-8?B?TW52cHlQL0ZaaWpSNnJta0JqS2p4ZjU2Yy9SWXhUcmNtcmkyWnlSUVpHTU0z?=
 =?utf-8?B?akQ1clhBcjVUaTBnY2RoVkpBMENONDRTNHZGdUJaNERWVWtVaS94TytiYTAr?=
 =?utf-8?B?U1E2NmVlMGN5TmQwNGRzU2Y2dllrZTdyT3EySnhENyt2VFdWME9nZFNQVkQx?=
 =?utf-8?Q?l92YVNpl/tzYcDh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <938B3B216FB2804CAF5DCBCC41BECA64@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nTR/o/GTYUiu7Az/gcgE0sysEVM16Z46e+p0au7TfGmENEVc1XATPe80OlRzSkr6i2a0v7MfR4hZYSmpHIkdcJNltTA96lwM5CpRBv27gxYuSLCrCB7qR/gM2NmWuodNzjew4DVZZFyAfLANYbPlcVQjxjwJtXz0N1XvZuHm2xgMRrptBPNw34xr5lfZyNDgeam6wbAYrgx4jVgfLeLEc49UVphOr1kHNm2X350hx5fhAQ5hXG1G5gUweJYxMcZgkXPSlmZD/UMON4+sVvd9r1hQBVKd31Z5yiDDLoWAZXnx/bE4SasqPmF5auSmuFj/A2J48Eyn82jKoqqIg+rSxw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a74f2bea-8c0b-44db-9b8a-08dee7fa6cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 14:06:28.8990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhbRryungKjg6FyYKvtinwf6yW0E1WgcEyGig8oVinwt9oCdpsTdJUY+Rvk+xWI+FSxNTnyg4fVZfcD0zgNls3Clr75eb+BjbbU9w3yFLdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P302MB1144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzOCBTYWx0ZWRfXz3cJT1eGfIdy
 YDs8MdoIb9y75tO+NWpyZ3LfRvi0GRSsfL6/sDW+fiE8rEhFO2SzTAw5PwcyUnT/jtsbItO3JSK
 8oU43MwkLfFhC+J37eZsB4gdVHg0tw7Md/IQdjeklu5WbM8RV23kHeQ+Uvg6Lw9BK3EiEx8+JKL
 oWFcieIL9uq2lMa+nXqXnmu+rgTkYFsaCSYtiIp3f1Dgw8ejwB4EqzvVdtNdVArssHqQsfnNFyc
 JpP8lS49QSHyy2gODVbuMEJqtHK5C58iGYg83dcuX0QPnuHSSPVX6j0MiZgQhTjpiuEeGSrweXG
 VRyh3mA+7lvzDBAF9sU8JHoAKfmxR1B6cOzajrrtHbjYbDz0+fmkEYg5mjGIdvy80Rm/9wAp+3r
 rftcDH38WVgJjFd9bS+WmS8PKrzzYUPM+3vFzKNUhtHHjxdX2eT6cwh9r7SnR48jCqXNBl1ns8N
 1dnIvDM0rnkL5HbYWJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzOCBTYWx0ZWRfXy6j2JGZhK3tG
 K3/ALlRzbmaXrEAo1avxXOWxKMJdGz1lJagmxt63rVwysSYk2T8fkE/qdlhZirQ9EsOL8U+pvsZ
 W1lEGIs1+2SmFKHzdULhNU7ei9MKRmQ=
X-Proofpoint-GUID: iLPl30KZQkm1lIfpSUfDMdeK5D3gCSfh
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a60ce73 cx=c_pps
 a=68sIzm80yF4rXXtTcQvumg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=p0WdMEafAAAA:8
 a=r_1tXGB3AAAA:8 a=ueMU7nT7jf0AcEGzyf0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: iLPl30KZQkm1lIfpSUfDMdeK5D3gCSfh
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

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDEyOjM3ICswMTAwLCBGcmFuayBCaW5ucyB3cm90ZToNCj4g
QlhNLTQtNjQgTUMxICh3aXRoIEdQVSBJRCAzNi41Mi4xMDQuMTgyKSBzdXBwb3J0IGlzIGluIHBy
ZXR0eSBnb29kIHNoYXBlIG5vdywNCj4gaGF2aW5nIGdvbmUgdGhyb3VnaCBhIGZ1bGwgVnVsa2Fu
IENUUyBydW4gYW5kIHRoZXJlIG9ubHkgYmVpbmcgYSBoYW5kZnVsIG9mDQo+IGZhaWx1cmVzLiBU
aGUgZmlybXdhcmUgd2FzIGFsc28gcmVjZW50bHkgbWVyZ2VkIHVwc3RyZWFtIFsxXS4NCj4gDQo+
IFRoZSBmaXJzdCBwYXRjaCBpbiB0aGlzIHNlcmllcyB1cGRhdGVzIHRoZSBHUFUgc3VwcG9ydCBk
b2N1bWVudGF0aW9uIHRvIHJlcGxhY2UNCj4gU29DIG5hbWVzIHdpdGggR1BVIElEcyAoQlZOQ3Mp
IGluIG9yZGVyIHRvIGF2b2lkIHRoZSBkb2N1bWVudGF0aW9uIGdldHRpbmcgb3V0DQo+IG9mIGRh
dGUgLyBvdXQgb2Ygc3luYyB3aXRoIHdoYXQncyBzdXBwb3J0ZWQuDQo+IA0KPiBUaGUgc2Vjb25k
IHBhdGNoIHByb21vdGVzIEJYTS00LTY0IE1DMSBmcm9tIGV4cGVyaW1lbnRhbCB0byBzdXBwb3J0
ZWQgc3RhdHVzLCBhcw0KPiB3ZWxsIGFzIHVwZGF0aW5nIHRoZSBkb2N1bWVudGF0aW9uIHRvIHJl
ZmxlY3QgdGhpcy4NCj4gDQo+IFsxXSBodHRwczovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJl
L2xpbnV4LWZpcm13YXJlLy0vbWVyZ2VfcmVxdWVzdHMvMTEzOA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRnJhbmsgQmlubnMgPGZyYW5rLmJpbm5zQGltZ3RlYy5jb20+DQoNCkZvciB0aGUgc2VyaWVz
Og0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29t
Pg0KDQo+IC0tLQ0KPiBGcmFuayBCaW5ucyAoMik6DQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjog
dXBkYXRlIEdQVSBzdXBwb3J0IGRvY3VtZW50YXRpb24NCj4gICAgICAgZHJtL2ltYWdpbmF0aW9u
OiBwcm9tb3RlIEJYTS00LTY0IE1DMSAoMzYuNTIuMTA0LjE4MikgdG8gc3VwcG9ydGVkIHN0YXR1
cw0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmMgfCA0ICst
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZHJ2LmMgICAgfCA1ICsrKy0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
LS0tDQo+IGJhc2UtY29tbWl0OiBlNTMyMGJlOGE1ODVhOTI4NmYyMzEzMDVkMGQ0NDNkNTljMjRl
NDZjDQo+IGNoYW5nZS1pZDogMjAyNjA3MTYtcHJvbW90ZS1ieG0tNC02NC00ODkxOTlhZDc2MjMN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBGcmFuayBCaW5ucyA8ZnJhbmsuYmlubnNA
aW1ndGVjLmNvbT4NCj4gDQoNCg==
