Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4513C61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3729510E023;
	Thu, 27 Aug 2026 01:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="NwXXD+dT";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gJiXox71";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5061B10E023
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:52:38 +0000 (UTC)
X-UUID: f8dafc54a1b911f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=LpC17be2nnfk6N/200E2yV+PoSJPhSHJgzNTmmEV0Ng=; 
 b=NwXXD+dTTFwRhAZywIjnZCOGrOU94sZzHYsHi0ldXKK0wFt57jxzct4Wx+3ryQZXL+ks5pH3yA6ecnSNtXCq4iuLLkE/CfnEUXEWcb+axKMrojTR88LsKPIdeB2JD4Wq+3G4HMjzDpntcHZ6pKU6MZBnlXDis3yBpL3hkGXP7kQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:6c18ebe5-3570-4bbd-9685-fe606659a1fb, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:0b2277fe-f4cb-4ad2-b022-e3ac6648bf25,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8dafc54a1b911f18dc8c9802ae25ab1-20260827
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1032202706; Thu, 27 Aug 2026 09:52:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 09:52:32 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 09:52:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXRAn/IXTSchV/iaTYvvbQ83u6XEtI5NpSQeN9j9KAL1fbtYK1l5vr6FYZoYLDnSXO0ydSjqqXvzPmL7zUbUURTEx9rdvxdisiHRzpiZRnWb+2LfX0d6FiBB7YBDRnAg6/zpvIPJrtMtDTXsPhvfNnw3OQi6Rr6QxWkSWf08MElASwoQgTsz4iu4FoqOgg3am7U5Q4q5sqLGph76sLcGmr/4zJLL717zpfpoP7TTTzFlWlMpRQePnBTZ1yrc+hJwqlXUwZ/crZsfjzWJq0aaD0m9P9QA08iT57P//xDCitTpw4ZEKKepDi3ywEs3QsBiV9lCoQDXg/BPhMaPagOsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpC17be2nnfk6N/200E2yV+PoSJPhSHJgzNTmmEV0Ng=;
 b=MtzQRg6g91T8+UmxE4mBYpSdeiw78kJCYMoc9kEGd5MylY6q3gg8eH1Ht0Qm5bHam/Pl8GLPGH14UkxU8fbEaWGgD25uIYRaw6djCVCe2HAEC+URbEcLsa1jRpxbLRb5gS4CfYYOQizfcFHbTswFz4vRjASfdqiP7GWwdeHJMc9rlEFUp6X7enrIcuFveKWb64vOOIEwnps40zvcijNYOpCp7+F51ef3MPH3cdHC/zRvzVk6+Xavo9A8FY3c1BXWrLA2rDmpA/0YW7yfLDHSq4v8IPlW3AmGrhwIBR7fFtKXcR13TtndG4TPUIKY8vZ2IpBoe9UFaN5VfLZX4oSBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpC17be2nnfk6N/200E2yV+PoSJPhSHJgzNTmmEV0Ng=;
 b=gJiXox71mO+o1LaKZyvPtOsgcFlu6TEX/sAkLrrIKoCZMJc9o2gdE/J0j3fdfshsP40+Ik7KMsqqCnoX52h2gD28I4XOiw/vbWKAno46b5SQyb2P8vYWOB6QHg0SQXMYs0E0hAIA2NGT1ZFeOhg/RDqvg8UWM0DxdDLf4BfPmNM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8576.apcprd03.prod.outlook.com (2603:1096:604:275::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 01:52:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 01:52:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 07/11] drm/mediatek: mtk_dsi: Add support for MT8189
Thread-Topic: [PATCH v6 07/11] drm/mediatek: mtk_dsi: Add support for MT8189
Thread-Index: AQHdFGH3p7dEOOyEFkmUyLiP6uKVCraxZKiA
Date: Thu, 27 Aug 2026 01:52:27 +0000
Message-ID: <614bec3336f5e450e914926bd390ef2f6d942ed1.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-8-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8576:EE_
x-ms-office365-filtering-correlation-id: c9726858-3bad-4d14-6005-08df03ddd960
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|1800799024|366016|23010399003|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: wdQXFcTDFTNzHunV6sQIXatHFPM17fheNw0CrU+OoZ+3TdnQx8PX2JMnX2auoq1JURKvmIYU3bRrvtN3N0WVjPy5AKlgLJkeqfTR7kes1EdDlJdC93NLCakaIKQjXUCNZ1uJ780np5kgNpXegJ3bGGKCabLx16OVsRLFQL2WsX5+NPdjXYGvqFzBFiBt4CH31k9fwZ3k++R5wXlmGRvpNr+N9ubYp7U5vP0DxamqhB4R8K/QIvc5KJdF8mT6JqezdzhyoP0vXMl0HQuV8yyR2j3gC0L6fk8DvtXillCyyzdjzMcilMmijIzX1tpMVPlWhf9Zh7TuT6Rb3vVuk2n1TLMQt8QMb63YJWDB+aGrzFcLoDBoajLBqMTS8EWoxEGLApJTIqTWecGnHdqmOFYS3SfQU5vTFbselSr9Si2CI/8sBXwYX4v+EHShdK1qZcdXU8MNJc0TFiiI4Nzry+XZW9G/Kkwc7ATNLXWgVvJSpe4sJ/R61ps4htcn3avmiL8OWPAglLMYRH4zyON6FIioV/OjKAnkSG/f9XsKh0RHEmiSoylZ+obWr9efwsaoTj49TnNLfIMY8ShV0SxZt3Ig1+zF9FJJGhdU0ndCEJndRSboxS8tF3Iml+8YqZgNfpZEyXBKQ1ebdSU0NZIZPWXLrrhhINABpRHWHGK+EA3Z6OAyfTqps/TeQGkRqAuhPl/7GFvi4Z6OTRN6eN1nUgsaEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkdIV1g3dXcvQktPSzRxRkhGK05IYStyTllHeVYzM2xtem04VnUwTnhUa2Ro?=
 =?utf-8?B?QW5YZW1oamgyc1h1c25pMDc5aVBZL3hjZ3VCR0RaYWU3YmgyeW81Y3R4QkVI?=
 =?utf-8?B?Z3NLUEZiQ0l1NkJnZjYzZDN3My91ZjgxeEJQOU9GcUI4TTJLSDRWM2dZdEZG?=
 =?utf-8?B?YlpPb1lwUXo5dWhuVE1TcExOd0lod1hhaURPMEpkQjlVbTBGcVFyQVRpVkFq?=
 =?utf-8?B?dWRLeU5JbFBPV1BzZGZhL0ZOdGJqcWZkSkYzSThsWmF3azlUaHBrYlpLMjRN?=
 =?utf-8?B?RjM3UUtkQ0ZwQWVYUE9nWXh4WEg2N0tkWXN6RlB1K2d2MHBXOWZYODBmbzhM?=
 =?utf-8?B?NVJUeW1rM2k3bEJnZ1BtanNWcy8rZG81Rmh1YWpxVlN0ODdwU2ZPa1lNa1lW?=
 =?utf-8?B?VXZPQVUxTjAvTGpqY2hXL0N4QzYveGU1NTJmSEdKc3ZuV250THozN1NwVUVN?=
 =?utf-8?B?bVRaWTFERnp0d1FjSzg1dGJ0VmNNbmdYNWc4OWdmTk11MGFWK29NVnFjYkEv?=
 =?utf-8?B?ZkFCRkhwV3FKeU40SHZRSXlyZDlxWk1GaDlaMTJKK1F5REhiTmlYV0VDRDBS?=
 =?utf-8?B?Szd5VlBEWkNoUm5IcFJ0RzVpOTI3eWwzOS8rOXBKK3dDcFBrVkduMWZydm5l?=
 =?utf-8?B?cndPQkhaYlQ5c2NkTVdpNzhWK0ZPVnhRRllCbnNoMWZHZU1MRHRnalVMSURq?=
 =?utf-8?B?UWg3S3pwSjZuZ2V5WlhhQlhJTWMzcTJsVTFIVTMvbmgvSGRvM2loY3FlWFJC?=
 =?utf-8?B?ZlR5T2VVTUQ0bDJ2R0t5N1kxYVFCQUx3Y0xwZUE5ZjVtTm5QcnByeDcrQlBP?=
 =?utf-8?B?NzZ4NWowNVlXOEZPdHNOc0trTnROSjFCNGlLQVRzWmJBYzhEakdJMmVWQ0Nj?=
 =?utf-8?B?TDhONGhidFNkVXZYZTljMDRjczFnRjZXemRUVW9aaEFFNVBDSXpZK0EyM2Qx?=
 =?utf-8?B?OUtYd2N5SDFRUld6Zy9SdkdBREVhaS8rbCtVbC9LbE9OYU5qOW9TSmJoS292?=
 =?utf-8?B?VDhkM3NxRjgzMlkrdkRlenZBYUFrRzF1cXlWUTMrbzlWUGVnL3JIREp3WXZ5?=
 =?utf-8?B?UFhVS1IrRHZ2Y25BdFhJaUtKdnkzOUs3dmN4dGhXY0ViL0tSSDk1QnQ5YjFZ?=
 =?utf-8?B?SVJBWEhIMys2c25wdzFvZHZDcnkzTWVSVjJIdFgvQzNkTGd2Vi9vaTlROUly?=
 =?utf-8?B?ZlA3U3VYNkpHcWJNc29vdERJSkM5OFhPRUNYc3VHekJ1eDMxMGY0cDJEMVov?=
 =?utf-8?B?S0VjS2RqTXcydnBXSDlabkZTR3NRODRPc2pCdTN2ZFdHR1Q3OEdiWi83OWtM?=
 =?utf-8?B?Ny93UkxlOERYSTdBdkRjMGRRT3FZZ1RxT1NydzNrRXJsZE90a2hIeTMvbEJQ?=
 =?utf-8?B?Z2pMeTY3OEhBRzFWZkp4L3cwaHBYVVRpb2pPY2kwSk1iU1F1YklaeGlZTzFB?=
 =?utf-8?B?TStKb3JUS2JWYStEeXVRajY3MzQ4aXByU01HeFZ6VzcrY3puMmRWelJsa2Ny?=
 =?utf-8?B?aU1tMXZkVTVtMVgyYjYrSDl5T1dMS3h6S3pVWU9WR0hvOHZKMElkNnNPa2VI?=
 =?utf-8?B?d2RNenhWOVBZOWhZengrYW90aWI2VjVLKzVzTm93SnFnU2NsOEJDSE1CT0Zv?=
 =?utf-8?B?cUJhNjVCdXVCVDJBSDhFNFBjam90U0FoN1BLSUxBM3NhL3U3UzBES01EdVA1?=
 =?utf-8?B?RXFpVHVOK0JrSFVRREpsaWZoTWw0RTRrZDVQZEV0d3hXWVRUMkJHaFdtcWkz?=
 =?utf-8?B?L05xcnQ5eUkzTUtoMitWZUE0MzQ5M1hMOGhIZTF6Q0l5VytlSlVhY3lDTllj?=
 =?utf-8?B?TWMwczcvZ2dxN2VVUzlnNEx4TWRKR3pkMlJjR3BQblRhSlFyc0RsZ3FMelB3?=
 =?utf-8?B?ZWIyaEJnTW83SWxiU3k1RW50ZVF3ZDlpa05tNWtJaFd3WUZQc2NoeXcvWFRm?=
 =?utf-8?B?dzlYbjhkUlFoSWo5bWowOGdNUWlDOGQrcHVTSnZFcG9iVzZheHNZUWhQVHBS?=
 =?utf-8?B?cDZZQ3VXcmdDWU8yNG1Wak9SRFc2SFNjWjhQcU5jK1I1K0svcnB1MDBNSjgy?=
 =?utf-8?B?S3RRcEpyNnlJejVRbVc4ZTNCRlhXalo4M2o3YVI1T1N3OVJyVTRkdDF2YTNw?=
 =?utf-8?B?YUVRR1JSMjliNFVYaUxiR2JHZmhoSHc3SjdySlJiUG4zUy8zZEc2dFJXR0cy?=
 =?utf-8?B?Rk5qcUFJN1B1c2JyZnZleGxyNll3b0ZvNmxVbkUrMDNKQ1VkTE10MDRIQmtI?=
 =?utf-8?B?U1JQK3JoUDBqWmdDaHExVzM1NEN5L1loT0sreXU3a0xFNTNhTkQzQi9ieVpE?=
 =?utf-8?B?aTZNUStGZ1ZtR3BpbEpTdThJbkFHL2xZK0ZGaDFEd2hzeFVHTjVtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1870311CCC914791683411710A1C33@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: biZoeB+7bexcOheu4lkPDeQEQ3A8ryXQC6LNMdlOu6NaWXy39oSLgJg1wcgfm9zg5aUZcaZq+UVODk2SJj+D1bwc82ebNLTRSdiRViqNfPmnGWPtzwv2FByWxsrf+9RA70HHA7HiwZb4plmu2Ub2ND5sDn0zsJNEGXszNDOtFil2+qBAU/n2Zycp3QxcZv8Pu1Pr/djm3j84+eCYmZDo1UCq8XFpshpKs9EGOkYNr7ENYRebXJekKFI7D4fiki+hR1OAGmdsMYkn6u0xRijn4AEqE1YDw73Wl4XP7GQkUzpPcnWHeJkHr4BzrDfZnDoy0/+dUjtAZgzWJQmyZmR4QA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9726858-3bad-4d14-6005-08df03ddd960
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 01:52:27.8980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrPXvV7pQ72eCIUnQC9t9L25QnzAr3BdV7/A9PkX5FO2w3o7R5Hk4ksE80ydUpxpuGN0e0QfKiIT90zKrwdB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8576
X-MTK: N
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBEU0kgSVAgZm91bmQgaW4gdGhlIE1U
ODE4OSBTb0M6IHRoaXMgb25lIGlzDQo+IHNpbWlsYXIgdG8gdGhlIElQcyBmb3VuZCBpbiB0aGUg
bW9zdCByZWNlbnQgYWxyZWFkeSBzdXBwb3J0ZWQgU29Dcw0KPiB3aXRoIHRoZSBvbmx5IGRpZmZl
cmVuY2UgYmVpbmcgdGhhdCBpdCBzdXBwb3J0cyBhIGhpZ2hlciBsaW5rIHJhdGUNCj4gb2YgMi41
R2JwcyBpbnN0ZWFkIG9mIDEuNUdicHMuDQo+IA0KPiBUbyBzdXBwb3J0IHRoZSBoaWdoZXIgcmF0
ZSwgYWRkIGEgbmV3ICJtYXhfbGlua19yYXRlX21icHMiIG1lbWJlcg0KPiB0byB0aGUgbXRrX2Rz
aV9kcml2ZXJfZGF0YSwgYXNzaWduIHRoZSBjb3JyZWN0IG9uZSB0byBhbGwgb2YgdGhlDQo+IHN1
cHBvcnRlZCBTb0NzLCBvdGhlciB0aGFuIHRvIHRoZSBuZXdseSBpbnRyb2R1Y2VkIE1UODE4OSwg
YW5kDQo+IHVzZSBpdCBpbiB0aGUgLm1vZGVfdmFsaWQoKSBjYWxsYmFjayBpbiBwbGFjZSBvZiB0
aGUgaGFyZGNvZGVkDQo+IDEuNUdicHMgdmFsdWUuDQo+IA0KPiBTaW5jZSAubW9kZV92YWxpZCgp
IGlzIHN1cHBvc2VkIHRvIHJ1biBqdXN0IGZvciByZXNvbHV0aW9uIGNoYW5nZXMNCj4gdGhlIGxp
bmsgcmF0ZSB3YXMgZXhwcmVzc2VkIGluIE1icHMgYW5kIGdldHMgbXVsdGlwbGllZCBvbiB0aGUg
Zmx5DQo+IHRvIHNhdmUgc29tZSBiaXRzLg0KPiANCj4gQXMgYSBub3RlLCBzdGFydGluZyB3aXRo
IE1UODE4OSwgaGlnaGVyIG1heGltdW0gcGl4ZWwgY2xvY2sgcmF0ZXMNCj4gYXJlIGFjaGlldmFi
bGU6IHdoaWxlIGF0IGl0LCBhbHNvIG1ha2Ugc3VyZSB0aGF0IGNhbGN1bGF0aW9ucyBhcmUNCj4g
bm90IG92ZXJmbG93aW5nIGJ5IGNhc3RpbmcgdG8gdTY0IHdoZXJlIG5lZWRlZC4NCg0KSSB3b3Vs
ZCBsaWtlIHRvIHNlcGFyYXRlIHRoaXMgcGF0Y2ggaW50byB0d28gcGF0Y2hlcy4NCk9uZSBpcyB0
byBhZGQgbWF4X2xpbmtfcmF0ZV9tYnBzIHRvIHN1cHBvcnQgZGlmZmVyZW50IG1heCBsaW5rIHJh
dGUuDQpBbm90aGVyIG9uZSBpcyB0byBzdXBwb3J0IG10ODE4OSBkc2kuDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5n
ZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCg0K
