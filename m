Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCD606D807
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=DVP5NtvX;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=GYGa4DGw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767D210E2CD;
	Thu,  5 Nov 2026 09:36:26 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4713610E2CD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:36:14 +0000 (UTC)
X-UUID: 53440e96d8fc11f1b1788b6acf885367-20261105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=0s8J26wHFrosL9b6jamU/xUOyCO1q3i0pzAPETGIhaI=; 
 b=DVP5NtvXXGOQni4A07ekcy0mYJdydpGdxBtKBL1rwm8a041XH1ZeGknnAZiukRGQFj8LjfUowCinHSkyO9208asDbfLLsb0raxvooPnCw57VaS9cZJE3jQpbxa/e6OJ3wBGQVffsgiCnV32e0W0yGlxsU3WgrhnShCr7Tc9+HNM=;
X-CID-CACHE: Type:Local,Time:202611051736+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:c3398801-829d-4ad3-bb6f-b6b29fd9ae3f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:0bb0a656-6f68-464f-9fe4-a2bcffa484f1,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 53440e96d8fc11f1b1788b6acf885367-20261105
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 33048491; Thu, 05 Nov 2026 17:36:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Nov 2026 17:36:05 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Nov 2026 17:36:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGxzVW85FjYFxUxCYjkN7mU4P418ZoNzu6Ly51pMm3ict8vBuzDnEGM55RmzthXkP6sPf3Y0Hrw0IdC9400Qu2PPvwGta51F/mmYLNuPiioBhhB++2E1L1hbW/+g7RV6gt4Xkme3b8Xm2Jik8iHS387k3tJOm+6NwvvYJJepVdHfzKBiIcD8Sv+fIo1ixJblcG2J7H9Poqkqei4s1NpbzVSN35jEKpMIznBZ6DfrqI95Dte/Rt9G3BT1X2jTfdmerDJcQ32TToROYUQGgvWPySh+uxQvhIgZ123uFSRgAwmTI4iyDNeIyAaDlaILFhiIJAKHllC14ig7NIQ0F27WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s8J26wHFrosL9b6jamU/xUOyCO1q3i0pzAPETGIhaI=;
 b=vZ4RTweZTXu4AhIMKgT8YEJMSS0b1bZbFt99ybe93kZllp5eZSeMrma2/4hpFxZTIggGfEl8PeF0SKLzZmSoU7OAD51/mZMgCnczriQddXbRWqPL0ePQQRkSo+tnlicxvx/p2TbdjAwod17brve0/vZmLBUVh0vVy4jJAbGYMe2UDRo4Rqqf8/3QjAChITt/qbYHW65jmxYxTuu6t5ruoRZlsQBtY3K4/7iEpPvwIRWWewPy3tCaDzQo0xw5cadWu4tMstakCdrXtZKdOYnN7zbffIQZoiygI0ZBcHGid9ecqK2qAh6oM9HWDg8wXxDj8Qg9TvBzEMaXFMfeMovUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s8J26wHFrosL9b6jamU/xUOyCO1q3i0pzAPETGIhaI=;
 b=GYGa4DGwyypr2OPcIyID8aRNOV2k7wfMFizSH7SJcjNr0xWjv4HrRv9SgIt5537GU4kfFkWVSGmyAXF437raZU1RZXMXqmYxiopCFAI/FMblIq49HudrVyN3ZXspKJ314k+5n9syRKKXGxMXYa7U7NsXfqeZ7xfC9MM1ntHy8Uc=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEZPR03MB6619.apcprd03.prod.outlook.com (2603:1096:101:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:36:01 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:36:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v2 20/46] drm/mediatek: mtk_crtc: Dynamically find
 vblank/cfg component indices
Thread-Topic: [PATCH v2 20/46] drm/mediatek: mtk_crtc: Dynamically find
 vblank/cfg component indices
Thread-Index: AQHdE4ZjKorvgdandEidLokic5I1jrcf6xUA
Date: Thu, 5 Nov 2026 09:36:00 +0000
Message-ID: <2019d43f3078b8b222ef503d2f4037dbb17c39b4.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-21-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-21-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEZPR03MB6619:EE_
x-ms-office365-filtering-correlation-id: 8a2dc55f-1527-4c6c-509e-08df3b203423
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|42112799006|38070700021|11063799006|4143699003|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003|6133799003|10067099003;
x-microsoft-antispam-message-info: +gXFQvmDG46quZek9ztiTgTEAiRmWWM02lEAvka4tIGdQKGDdpLnYcKUuY8gZA/nCjTniXINqOhrweLlXYfBBL8ZjWsfOvOMqDYQzSaU4Etw0lsDyTySZJPwCJ9OjQvKGuPNRx/d48gf0MBzEHxDSY2k/CwvJJtl8wfSNEpVHthV1rCmFVM+YoHlPs8hAShE/M4E6/RVCdYYQ9CjcErbKol/gGmae2viMN9zfcXNi4zd3zACKaazpiWLgxEf1IPpkvZ1aTs7Dy9gbm2xU+jLXaVYJNNX1K2RaMx2WxCjsVmpoX8ajr3Z7ObD7rLGp9LgbYlvQcAjwWJ/n6fVGyWk3vanJv62S8W2nzvYfr/uj/HNMiAn8nh35cGXNaxjhWR2ubVf4WJcf1r5sUZO8kaRTjrn0ix35CH+f+FWHnaj740Yo6gxtw/7JrO+J3em33j9/MY+425zOQIqqq5gr/hRxLyajJi4uby1FlJ2LaIwBkpT8G7lpe073HNaR+Abgde9vfQ7xAmYga3CfJy2jVjnnL8bkqBJLBRwWVNoJU9zLZbNX5qK3tJbYWx8Mf1q0v1sfh8eovjg2YxGTjih1aA0z+vlb17lf96HPPw45lFLLYcLY47B+vyTC9BrdWK/ZvOZSXaJFT27lwwirHAB0Dksngc1ksjW/JBKHqNeT+PqZ2UNzmng9ch9EwYiqWgoN64oy+JhuiMfgwv2mVQuAHGImP2uo6tj0zIl5pDctWeJols=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(42112799006)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b00rZURvL1F5c2hvRmpWb3JiSmNRUVVYTW83ZVY2RjJRcDZsM2hXWHIycUlZ?=
 =?utf-8?B?UGJ0eDRPYnREQ3ZEUXg3MWcyRTZNa0tLSTBwMjRjbzBkRG1WRklPWU5QVjBQ?=
 =?utf-8?B?YnBrUTBPQUlwOVVnOENLNW50TGZlRXNPVG9IaGdBWTVaSGdhdjFCZ1Q3bHVs?=
 =?utf-8?B?MnNIMGY2M2QrTXVyUFJlbEttSEpaOFpEZzU4NERJOFJ2Wkc3VXI3ZjU5VzJ5?=
 =?utf-8?B?NFl3S3ZjRXg2VHJ0UVhNTHo4Y0pVWHBRS2JRUitQdXFpMmxBVWdNZ0QzcWpZ?=
 =?utf-8?B?Tng0dnU2R0lLYlRpanlES2E5V2pSRVM4RTg4WkFGWUlUNUVMbDE1czdBQzJp?=
 =?utf-8?B?dk84bzd5ekIrUXZicWhlTTRhL0tlWVdESUIxMElrQnJiSk8zS3ZtVTdYOFAy?=
 =?utf-8?B?bllPRjJZMUxMeWVHKzlUUHJpZURxdWZyRW1NdENzR2JTUkUvQ2Q4ekdjVGpr?=
 =?utf-8?B?ZmdiT3VqNWdYMzRMakRoTkxsbllCY3VxWEdNUS93bzdXOXMxQmdCOWNJL3RC?=
 =?utf-8?B?NEphL25tSlhHa1Y4ay8yRzY2TEJ6R2huRERCblhWSndKZWhxZ0FFcXY5VnNX?=
 =?utf-8?B?ZW9oQUJNMlpaZkROc0VJVGs5QnMwalFsU2ZUSjN0d1A4QWtXalQ3MGpneWxW?=
 =?utf-8?B?eS82SnIwaEM0OTVWVTM5SldEMGUvNUJ4WmxMZ3czT0ZYaEFmb0JxVGhMYW84?=
 =?utf-8?B?K24yOTZTaTlFZVBnajFWOFZ3NmZ4RElWSTNhdXloN1NJejAxY0VMU3c3SVhv?=
 =?utf-8?B?U2ExRmxBRWQwM0pWSHBJWGJ0YzRiZkNOeHlHL3ppRGNOSzk0QXgxa1dTR3Jv?=
 =?utf-8?B?UXRPeFpFd3pmUUd0d1UzRGVqd2s4djlqMExGMjdZSlYyUWl6TDlqdnNGYVVV?=
 =?utf-8?B?WmVGYUhxbFQwSHRGVVBwMFRSMUZPL3dpQ2d3bnZIa29scnNCUExQeDJmdWxl?=
 =?utf-8?B?dzFDenJKY05EU1RmUmRud082M0VQcTNDWlozcEI4RmNvWDExaHhxOTZWTmh5?=
 =?utf-8?B?YjhtQU4yWVZkb2tzQVZ4ODBVMUExd0tyNkEvYjNBVDRjUzFMN21zUWpiZi8r?=
 =?utf-8?B?U2d5WUZNNDRaZXFVc3pHWEtyOXJJU2FubEVzOTI0YURvTzFiNDRGQzBNNTNU?=
 =?utf-8?B?WXpsYjZhVThyNWZRRDdEOEtuL09OTEsrblphRGFPeUJGU3I0THd3eU5Kaiti?=
 =?utf-8?B?bUdsclhjWXZ1T2kxbVhlT2YzVm5jN2VLNkFHVStzOVh2Wi96ZGlnaHF4L2li?=
 =?utf-8?B?TEc0RFlBcG5ac21EeDluaEhNRWkveHUxK200NnpWeDA4eUk2V3FoaHBWcU4v?=
 =?utf-8?B?cWRhU2kyN1E3WnA4NTBRNVduQ2orMmd6ZHJOTnlaOGUvSVdFK0pzWUpVa1Js?=
 =?utf-8?B?c1l1cTZTamNSeVBlaDFyd0VadnlPUm5lZG5GNnI5SStZSTNUc3JwVHQvaE0v?=
 =?utf-8?B?VnpubW5TVytsYzhlb2tsTVh0ZVp4aTRBbmxtRWF1d0FvK0hzVG9RYXdXSGNi?=
 =?utf-8?B?QWh0VElIWW4xTWRHcmRWR1FXRzJaWStTbUpUUi9lMVFOdG4rb2xvSGR6S2RW?=
 =?utf-8?B?ZytkcGJqVU0wTDJabDVLc3E4TDV4eVRiQm5nZ3pDL1lVYlZtcDcrSUdPTE9C?=
 =?utf-8?B?N2s1ekpYUDViWVIrbFNvQnYyV0ZGYnEzelorcUNDeVRTb1dDcGk5dWdGS2Ew?=
 =?utf-8?B?MjliRlUwQkxHOVVUeVFIbVFTeWttQU53amNFU0pPaTBKVnhQR2h3RHRRMy94?=
 =?utf-8?B?eHB5SVFjM1NyRjJVTmVyUGpRMEFqbjJhM3ZybG9Ubm9JQmhrOWhhL0ZWaUlF?=
 =?utf-8?B?NVF6L0RDSDBsUjZaa3VBQ01Vb0NMRG9rOEZNMXRVKzMydTgyV0x3SC9wd25x?=
 =?utf-8?B?WGROSVdvM3lqUXo5dnE5MjhpQWVoamx0ZWJlcVFKTDVyRTZ3Z25BYjhKYk8z?=
 =?utf-8?B?NVZNVFpHbHVHUksreTdicFM1eGkwaVQxMVR0T290cFNYQ3FiNGNxNWhlWlMz?=
 =?utf-8?B?cklOelpXajh4VWxLQkRjKzVQMHVNR29YclRXRlhxN1lHdHZFTXBraWxOTnpK?=
 =?utf-8?B?czRiUTRKZXUyeVRpN0hDUzIrck9JanhOUm5zY1FJTnJwUUhyckwwcHI4SkhC?=
 =?utf-8?B?TVc4VEdQZXMweWtKWm51WndnVlJOK25INVZ5bmsvdmF1RXFBYWNpRGhOVjVy?=
 =?utf-8?B?ZmZ5clNVeEt2d2xGeDhFTndXOEZzREplR0lKby92Q0JQVjB0TVVJa2l3QXU0?=
 =?utf-8?B?MUtnM2tGRkxHcnU0K01xcEhBOXBuc3ZwZzJSSlBYOGpLdWE3cS9LWlVOdGlP?=
 =?utf-8?B?OUR2M01QWmFjaGpYWEs5RHhFMCtoeGVzSkNubkZJcnFHVk80SFB4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53D4821E00CA2A4DB6F1232A8C4D42D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sZKfhp0qlOIV6RQsC3zRQinKDtUIxVnymhX7G6mJPSdf0/4ihiZ8dStUMJJ3PWMxTzCg9rtJjn6HYsNKaBK2veTqOUSyMdvt3E4TSzUEvDuyNJiMelyvc4ijozwVlXKnF4Ar0Q2SQp1eeqPpVA7pEgUvwrBrIubcg8Iqq9Z6z2JBPgdjspIOsBrv3Xqu98OrNq6KI5K+l8fICEzhMBvwYLBQF4h/OuiSv4fwjhNI3AelXLrLj27C26CcEqoNmPN49UwY+B5puAdLdgYXht14ieYf/267LWQDP0Z3LrNhxaDQih+e1LvQgobF2LfxWcgjtpXakhxXQaIi4ym3ViR5Pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2dc55f-1527-4c6c-509e-08df3b203423
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 09:36:00.9290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99YM7LWRdebSvgqaUPwFtk3/j3c5J+CxBnjr1HqQYF4jLhD59PyfFimXmU0XBka5+H4/ueAE59bfXG34ArCt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6619
X-MTK: N
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgb2Ygbm93IG10a19jcnRjIGFzc3VtZXMgdGhhdCwgb24gYWxsIE1l
ZGlhVGVrIFNvQ3MsIGJvdGggdGhlDQo+IHZibGFuayBhbmQgY29uZmlndXJhdGlvbiBjb21wb25l
bnRzIGFyZSB0aGUgc2FtZSBvbmUsIGFuZCBhbHNvDQo+IHRoYXQgdGhpcyB3b3VsZCBhbHdheXMg
YmUgdGhlIGZpcnN0IG9uZSBpbiBhIGRpc3BsYXkgcGlwZWxpbmUuDQo+IA0KPiBUaGlzIGlzIG5v
dCB0cnVlIQ0KPiANCj4gT3IgYXQgbGVhc3QsIGl0J3MgdHJ1ZSBmb3IgdGhlIGRpc3BsYXkgcGlw
ZWxpbmVzIHN1cHBvcnRlZCBieSB0aGUNCj4gbGVnYWN5IFNvQ3MgbGlrZSBNVDgxNzMsIGFuZCBh
bHNvIGZvciB0aGUgb25lcyB0aGF0IGFyZSBjdXJyZW50bHkNCj4gdXNlZCBpbiB0aGUgdXBzdHJl
YW0gYm9hcmRzIG9uIG1vcmUgcmVjZW50IFNvQ3MgbGlrZSBNVDgxODgvOTUsDQo+IGJ1dCBmb3Ig
dGhlIGxhdHRlciBvbmVzIGl0IGp1c3QgaGFwcGVucyB0byBiZSBsaWtlIHRoaXMgYmVjYXVzZQ0K
PiBvZiBob3cgdGhlIGJvYXJkcyBhcmUgY29uZmlndXJlZC4NCj4gDQo+IFRoaXMgaXMgZG9uZSBi
b3RoIGluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgc3VwcG9ydCBmb3IgY29tcGxleA0KPiBEaXNw
bGF5IENvbnRyb2xsZXIgcGlwZWxpbmVzIGxpa2UgbmVlZGVkIGluIE1UODE5NiBhbmQgTVQ4ODk0
LCBidXQNCj4gYWxzbyBmb3Igc3VwcG9ydGluZyBkaXNwbGF5IHBpcGVsaW5lcyBpbiBNVDgxODgv
ODkvOTUgKGFuZCBvdGhlcnMNCj4gZnJvbSB0aGUgc2FtZSBnZW5lcmF0aW9uKSB0aGF0IGFyZSBu
b3Qgc3RhcnRpbmcgd2l0aCBhIGNvbXBvbmVudA0KPiB0aGF0IGhhbmRsZXMgYm90aCB2Ymxhbmsg
YW5kIGxheWVyIGNvbmZpZ3VyYXRpb24gYXQgdGhlIHNhbWUgdGltZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBAQCAtMTIwMSwxMiArMTIw
OSw1MCBAQCBpbnQgbXRrX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2LA0K
PiAgDQo+ICAJCQlpZiAoY29tcC0+ZnVuY3MtPmN0bV9zZXQpDQo+ICAJCQkJaGFzX2N0bSA9IHRy
dWU7DQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBBc3N1bWVzIHRoYXQgdGhlcmUgY2FuIG9ubHkg
YmUgb25lIHZibGFuayBlbmFibGVyIHBlciBDUlRDLA0KPiArCQkJICogYW5kIHRoYXQgc2hvdWxk
IHRoZXJlIGJlIG1vcmUgdGhhbiBvbmUsIHRoZSBvbmUgdGhhdCBzaG91bGQNCj4gKwkJCSAqIGhh
bmRsZSB2YmxhbmtzIGhhcyB0byBiZSB0aGUgYm90dG9tLW1vc3QgSFcgY29tcG9uZW50Lg0KPiAr
CQkJICovDQo+ICsJCQlpZiAobXRrX2NydGMtPnZibGFua19jb21wX2lkeCA8IDAgJiYgY29tcC0+
ZnVuY3MtPmVuYWJsZV92YmxhbmspDQo+ICsJCQkJbXRrX2NydGMtPnZibGFua19jb21wX2lkeCA9
IGo7DQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBBc3N1bWVzIHRoYXQgdGhlcmUgY2FuIG9ubHkg
YmUgb25lIG1haW4gY29uZmlndXJhdGlvbg0KPiArCQkJICogY29tcG9uZW50IHBlciBDUlRDLCBh
bmQgdGhhdCBpZiBtb3JlIHRoYW4gb25lIGhhcyB0bw0KPiArCQkJICogYmUgY29uZmlndXJlZCBm
b3IgYXQgZWFjaCBmcmFtZSwgdGhlIG1haW4gb25lIHdvdWxkDQo+ICsJCQkgKiB0YWtlIGNhcmUg
b2YgdGhlIGNvbmZpZyBjaGFpbi4NCj4gKwkJCSAqDQo+ICsJCQkgKiBBcyBhIG5vdGUsIHN1Y2gg
Y29tcG9uZW50IGhhcyBzcGVjaWZpYyBjaGFyYWN0ZXJpc3RpY3M6DQo+ICsJCQkgKiAtIEl0IGlz
IGNvbmZpZ3VyYWJsZSwgYW5kIHN1cHBvcnRzIHBlci1sYXllciBwcm9wZXJ0aWVzOw0KPiArCQkJ
ICogLSBJdCBpcyBhIG1haW4gbGF5ZXIgY29tcG9uZW50IGFuZCBub3QgYSBsYXllciBzdGFnZTsN
Cj4gKwkJCSAqIC0gSXQgaXMgYWx3YXlzIHRoZSBmaXJzdCBvbmUgKHRoZSBib3R0b20tbW9zdCkg
aW4gdGhlDQo+ICsJCQkgKiAgIHBpcGVsaW5lIHRoYXQgaGFzIHRoZSBjaGFyYWN0ZXJpc3RpY3Mg
ZXhwbGFuZWQgYWJvdmUuDQo+ICsJCQkgKg0KPiArCQkJICogU3VjaCBoYXJkd2FyZSBpcyB1c3Vh
bGx5IGFuIE9WTCwgUkRNQSBvciBleERNQS4NCj4gKwkJCSAqDQo+ICsJCQkgKiBUaGlzIG1heSBj
aGFuZ2UgaW4gdGhlIGZ1dHVyZSB3aXRoIG1vcmUgY29tcGxleCBwaXBlbGluZXMuDQo+ICsJCQkg
Ki8NCj4gKwkJCWlmIChtdGtfY3J0Yy0+Y29uZmlnX2NvbXBfaWR4IDwgMCAmJiBjb21wLT5mdW5j
cy0+Y29uZmlnICYmDQo+ICsJCQkgICAgY29tcC0+ZnVuY3MtPmxheWVyX2NvbmZpZyAmJiBjb21w
LT5mdW5jcy0+bGF5ZXJfbnIpDQo+ICsJCQkJbXRrX2NydGMtPmNvbmZpZ19jb21wX2lkeCA9IGo7
DQo+ICAJCX0NCj4gIA0KPiAgCQltdGtfZGRwX2NvbXBfcmVnaXN0ZXJfdmJsYW5rX2NiKGNvbXAs
IG10a19jcnRjX2RkcF9pcnEsDQo+ICAJCQkJCQkmbXRrX2NydGMtPmJhc2UpOw0KPiAgCX0NCj4g
IA0KPiArCWlmIChtdGtfY3J0Yy0+Y29uZmlnX2NvbXBfaWR4IDwgMCkgew0KPiArCQlkZXZfZXJy
KGRldiwgIk5vIEhXIGNvbXBvbmVudCBmb3IgbGF5ZXIgY29uZmlndXJhdGlvbi4gQmFpbGluZyBv
dXQuXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKG10a19j
cnRjLT52YmxhbmtfY29tcF9pZHggPCAwKSB7DQo+ICsJCWRldl9pbmZvKGRldiwgIk5vIHZibGFu
ayBlbmFibGVyIGNvbXBvbmVudCBmb3VuZCEgRXhwZWN0IHRpbWVvdXRzLlxuIik7DQo+ICsJCW10
a19jcnRjLT52YmxhbmtfY29tcF9pZHggPSAwOw0KDQpXaHkgbm90IHJldHVybiBlcnJvciBoZXJl
Pw0KSWYgdGhlcmUgaXMgc29tZSByZWFzb24sIGFkZCBjb21tZW50IHRvIGV4cGxhaW4uDQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICsJfQ0KPiArDQo+ICAJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5k
ZHBfY29tcF9ucjsgaSsrKSB7DQo+ICAJCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAgPSBtdGtf
Y3J0Yy0+ZGRwX2NvbXBbaV07DQo+ICANCg0K
