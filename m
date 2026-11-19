Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2A606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=dHfwcQXu;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=eIVg4TgP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF55710E55C;
	Thu, 19 Nov 2026 07:01:24 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB0D10E55C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:01:12 +0000 (UTC)
X-UUID: fcaba1cae3e611f18dc8c9802ae25ab1-20261119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=DMufzST1LeTVh2/off2SaFaaBWEWofCJ4XM9wnwlC5I=; 
 b=dHfwcQXurzHgRFo8PFsWM6siYhCUdUmSVyXZqE3pO91ga5zEtC3v/EQxaSj7Nz4LPss1nPVahpO6+fOzdpnTiETBzoeIh9xfxjQq++q1thUWIbQ/w0u2T3zJpSJUN74Mj8IrBWX9f6j4sMg9MN5kq8h4pMYb2T+bNU7ogQJmmfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:18bb8b9f-e936-4bcf-bdb2-2eca327236b2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:32228166-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fcaba1cae3e611f18dc8c9802ae25ab1-20261119
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2041023276; Thu, 19 Nov 2026 15:01:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Nov 2026 15:00:52 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 19 Nov 2026 15:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgWE89blNNv5sRsEH3IUMmgIH/vYnCsFF1c6sgjmMbdPI/4D+a0MQ6QfS3zzugq5ZhAqkbCCm20gEjH5SivwFx93GPTSnYeShxfRu7wcsK1omfzK/cby4s6W0pXzOrSPlYU2WAIFQeJX9jYwAlu0I0pkW3N/ltEvjejzVAfl9eejay5XUag+jPYc0X47e+MbAXo0njyvfQhwxdRa38QZ5nyioAjHFuZ9QocALld8GA358YMcvajinKTYlpNX/ojEbeCVyMz3ILbUDG+0bR7wz9V7Ze67X/44Y+87wl/DWs3v/BdDnZIrVwOHSfQhXr2njD4m3ixvNuDiqYx6Eo/nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMufzST1LeTVh2/off2SaFaaBWEWofCJ4XM9wnwlC5I=;
 b=ULPOC5Ttcztzzs1F/6gOjOmDR8H7l6QeKv24xagOAL0NFtXad6mFnV64bFLZn1pDvHpYaDwXrvb2mSQV58/hw92wMUtUy2eNyjYPze7qdUjXOIhy1JhWwh2qW++aXUtMld3PSBGRqi24XAgL67nHtJ40F62sjPiKIQ3E5zq23u6bT6gF3qwV+Vy0e0ZA6toeGrv8jS536wPr8acwBVNDciJn2D9utP/ocj93i9kL1CquU+ykkpyI96G4zdcJqFuHVWcbsb4R4ODrkFCJbu5U0b5DpkEBEs7rRMccUj3gUfblpSaXP1Yn0t8ER9mlvR0rZPvDZKJRuSB54618Ylv1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMufzST1LeTVh2/off2SaFaaBWEWofCJ4XM9wnwlC5I=;
 b=eIVg4TgPwA6wXiddlbrWDERDgiTy90mTDNPoFYFTpipjzKK5gNkP8BLtZRoBpQ3Ojjy0vtNzbrzs6ZvTup++oqtjc6tXXitWiPE5QkzuFVxy3VbLFAuPDqIXAvr4MUhoMvA5l1Szr+E3lduRBj/qNWlydn9oDIrFjF5FQH0wx7g=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYPPR03MB9747.apcprd03.prod.outlook.com (2603:1096:405:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:00:04 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 07:00:04 +0000
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
Subject: Re: [PATCH v2 26/46] drm/mediatek: Create new mtk_dpi_common lib and
 move mtk_dpi code
Thread-Topic: [PATCH v2 26/46] drm/mediatek: Create new mtk_dpi_common lib and
 move mtk_dpi code
Thread-Index: AQHdE4ZpJzU2LWyK6UWmzcJ6J6kKI7c1wCaA
Date: Thu, 19 Nov 2026 07:00:04 +0000
Message-ID: <461b49dcfd4a5a3de1cd9f087e1f9ce3de802ac5.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-27-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-27-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYPPR03MB9747:EE_
x-ms-office365-filtering-correlation-id: 1c7e9d88-be29-4bb3-7a53-08df460abcfb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|376014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info: cDctNlcKqJwfQJnBGAMjKBGqsmwAphyZuh7RffSDelWmVOw7IG4OOZBxblXur5Ni6kNvZUN2ZmMNdgoICPihLV4xHiSf5yIJk/c/F5FkYcdga69JM0kpdJMmF1cuiM/+kz9RUSKHmcD9aaqWXKyimwE/sQwjE29e/ISln5SIH15/sVs5RaBStgatyMZU7yAraU4wi21X5bo5okAajSCBC1Lm7l70f3tKFAsPIj1lTiqKt4pJcgLUFTZrUpOQbNwHRgRfZI0FquGBTH3yspYlxDhh9YsIpE84ZWUYnzdzZ1BS6m3TjG1jH4u18u/sqQ9u8zve/pwHTRDn/KG1ugq2voRwD0Y0RQILu+Yn26aC0NY4RY+NO0h5/z7Lu4vg/0QVX/laaPzWX/KiDEe8ImEMI8TQ0eeSMSACnBnU78gvmEq3EiOueDBAPx/rBpIJvmWfiv5dsstD9WjYaTudNjTtyTThxXapAj3u9MWicoEDVdCd4AtT+g4uoqZJF6sM8SXDGa/JIkB6A0nuioJE3yO2Y6G/GilInTHUq6iCyiR9ncJ/lyFpOjVRB1KNgk7uRD2tiOpVfSewDeI+Srw3SzVE2xTmVN2/VUoiv6jiVw54v+6PUdNlKUDgGrG+Ezs/+TF48dkY0Ca73K7JSvstrRN8sjSZA/1VQGklIw2XXalYld0RIUKWxL427DdlWKAhaehu9FYzVGvfdsX7D0BOFpZ+Kp4ref5lVJMLgMqQL3NHcKc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VOS0NPWjJyNEVTYUJnQ2wzUkxFSjFtcS9VbDAwSjJ2Qmw1M0FSNmJSQW8z?=
 =?utf-8?B?Szh5Z09rcjMwL2Z3c2hza0JucWI5YVBXanl3YVpad0twTTNjbjRpVDQ3cWdC?=
 =?utf-8?B?OGdrSWtldk1FMUJ1bFBEZ2tBaFU2d2svalEwRlBsamN6Si9zMEU2Q09aSTRY?=
 =?utf-8?B?OTBYRC9rdnRaQ0tEeXk0Q1AwZVN1b2gyc1lJbDhxVjk0YTFxSFRaL3pNb1VF?=
 =?utf-8?B?RlN2TUF4YzAwV2FpM1RnTEJKV2FyQ05xNFdVRXlaVXZPL25XV2xjVWswM1Zk?=
 =?utf-8?B?NzBCR3MrVVJabUxhSGlEejRkYjYxOS9ROW12Ymw4eEdDbUpjOWc2YmxIM2lP?=
 =?utf-8?B?Sld2Wld4dnp6Qjl6SWpYVjRldmYyU0RDQUtKekNZNldXelFWMDRvaTlQU1Rj?=
 =?utf-8?B?RnlDZGdMODB2dEZCbEYvTFRwc3VaVmMralBYaDBQZUpvUXoxZWdvUFhWT1d1?=
 =?utf-8?B?YWtzeStKY3FHaVJnWmVobGRuWll4QUFBQ2hkOHhubGVsYy9HU1JnOWZNaEE3?=
 =?utf-8?B?OFFBdHhZSFA5NUZQdHBjbUp3K3hBazdpZnNNNXBvZ2FsZ1FTb2pEYnBuVG5P?=
 =?utf-8?B?a00yckREUWpJdzFwa3JLenl1a1ZFUTFvazVkT2wydVpsVFFaN0s1Wi9HL3l1?=
 =?utf-8?B?RkVOYUhSWVVhQ01FVVU2dzZXbzlJcFV5WEJTeW5qZGhtMS9RVnRsZ2VRWjJN?=
 =?utf-8?B?bi96azZVeGVSL2gwSEo5NGxYVTVCMTBUcks4WVpzN1plR2I5VXh6cnJ0Y1l5?=
 =?utf-8?B?Y0FrYlVJYnptUjhOdys1c2h4MEtJQnNLZklnbW5oUnBvb09lcWdYbmpYczVB?=
 =?utf-8?B?YmtBenNkb29xeWdLM0tBRHhmQXY0Y0w2Uzg5cU5mV3NjVnE1a01BRDBFYjl5?=
 =?utf-8?B?MWJXa3JaMVRZdWVyMmtDMGZOQUJlckNEY3RBQ3lPa2owMk41b1BSTHg1OXFs?=
 =?utf-8?B?dUNiTFIrNjR2dEU1WGMrekt0djVBWkhTa3NTY2w3b3ZuV2x1LzRIMlhRcmN4?=
 =?utf-8?B?NjJ1czdONUd3aTBLM1c4eDg1VE95ckh4cWhhOTdaZjY2UDlZZ2NXWXRUNE1Y?=
 =?utf-8?B?T0lITVRwcFNRejh2T3k1TjdvUzN5WnV4b1IvRzNpNWxrVGQ3WjhFd2xYS0lI?=
 =?utf-8?B?dlZKY1VzUngxdVg2SGJ6SkRRaysxZHF0Q0hMZ1IxTG9iVFFmVzNoNFYrbE9l?=
 =?utf-8?B?cWFkM3loNkNNWFBUVExEZGpLVFFFOXpIWXFNd0VKTnlIRmtpejQ2NXNGN1pm?=
 =?utf-8?B?VXRKT3RZOERndURjVW1adjhtSzlmbG5HOUdxRVptSjVIY1UycFpCc2ZIRDVI?=
 =?utf-8?B?eEJCeHJoeVpWTjVsMWxHYWVRNDJnVVMvbS9jc2VEc2FmYmFMRlJGNFFTZmcy?=
 =?utf-8?B?NEJwTjVZbi94OWN6Y052VXQzcnpMaXowNVBmWVo4WkNlUVBhYzk0WlNaV3ZN?=
 =?utf-8?B?Y01hRy9MTVpiWHAxQmsyYnlZTHh6eHJ0Mk1sU1JUYytZSlpzMldxYm9KS0E4?=
 =?utf-8?B?RXpHallPb05CL0FTdFRsNnVVRXA3SHFWWFc4cm9QLzZGOGdzbHVGT2RuS1c0?=
 =?utf-8?B?c251cjhHNnErZENXdGRDbDNDZDNsN3M5c1NUcXk5SVEvWWFTSHYybmoxMGpp?=
 =?utf-8?B?MXlHSEVrWjV2VnRyOEp6Rmt2TVdTSk8ybTFDU1hSajh0SG1obmNRTURLc1FW?=
 =?utf-8?B?RGMxM1dJdGE2SWs1bzdmdUtKQlVJdGIzelVGSUhZY1ZJUTU0b0MvTjZMcHlO?=
 =?utf-8?B?L3NGc01aMy9Hd1FJV3dTaDdRdEZ5TFZMNnJjZWdWclE1QkhkN3E2R2dHV3p2?=
 =?utf-8?B?am5URllHZlovY3lKOE5XTnBFdk9yR1AyT3I0N1djYlhyeTE1Zzl3NmdRN0Zl?=
 =?utf-8?B?M0QwaXRWQzNTUFdoUE45WGZ1bHJNdjdFUjg3Y0xqS1hWdktXNUtCbDNaeElV?=
 =?utf-8?B?WnpvWnU5ZExKSDVrRXE4NDErZjY2ZkVWb2xxVThFemZEZTZSSHBWb3JwakNS?=
 =?utf-8?B?Ui9mTVhpOTB5Y3N2ODZhbjFPakxSRHR2UVRJQW5EZXNKMXB5dlZycDJ2L1gy?=
 =?utf-8?B?UnEvM1pITzQ3cmdzZW9ZVlBLQzZMUlgweENFV3NZcGpoUUNXSFNmREk3Q0lx?=
 =?utf-8?B?bFBDVUw2dkxOeUR3eVk5d2tremRiYkVOSGRHUXFGZHR6V2pPaFNSUEdidC96?=
 =?utf-8?B?MER1eitWazgyQVdaUXdOVXg3Yk11TVJvQS92dy9EcVRZcWRqVTBCMUdLb21Y?=
 =?utf-8?B?N0prQ2JzY1M5bTRSOWZ0bjZOZnB1NEhpUWRYVDJmK25tRlg4b1NUbmRHUHRH?=
 =?utf-8?B?Vm43ZkN2UHpGYll1Y2wvNFh3T2sya1EyVS9hQTk1MURCU3VHVm80dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <479CE97CC9762943979CA1062AD8B65D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kjKb0PIFG90hSP8CVDxSFb15GJzx7kGQNzm2FZMetmXx/VFkx4Q8WWviIIskfSOKWI105PYbWIO6wyCOGVSOevozv7IZu63XAvqbtAsPvfVkBoSbpF11UrNPYUfCRwAOhRDuqudd9zLExLrYH0HeGKyDMQAasZu50Q7OQ8stcTOQ/pK2VBiJ8HwOC69TnYMByrLxNeqTo5I00j9sD9Ko22HPQ81Y+X4DL3DwyL8dEBHwXlfHIIqHZ7GdNe+MuNKFIcmEs3cV5HGfVSz4SmE8yTljTKwyZ9gMQCrCyMECeKIfhr2tbK4IzBMYUdwwgze31IFzmc54BrmGMbXl379qVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7e9d88-be29-4bb3-7a53-08df460abcfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 07:00:04.3740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ny92yRwVLVXdMvAdh3Dtl4wpItaEuVhLRaw1S9eGBpLt7aMdz5KK1APb4X3pYt8k3OZTy+ayC3x8PyzhjMcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR03MB9747
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgYSBmaW5hbCBwcmVwYXJhdGlvbiBzdGVwIGZvciBhZGRpbmcgc3Vw
cG9ydCBmb3IgdGhlIE1lZGlhVGVrDQo+IERpZ2l0YWwgVmlkZW8gT3V0IChEVk8pIGhhcmR3YXJl
IGZvdW5kIGluIG5ld2VyIFNvQ3MsIGNyZWF0ZSBhDQo+IG5ldyBtdGtfZHBpX2NvbW1vbiBsaWJy
YXJ5IGFuZCBtb3ZlIGNvbW1vbiBjb2RlIGJldHdlZW4gdGhlIERQSQ0KPiBhbmQgdGhlIHVwY29t
aW5nIERWTyBpbiB0aGVyZS4NCj4gDQo+IFRoaXMgY2hhbmdlIGJyaW5ncyBubyBmdW5jdGlvbmFs
IGRpZmZlcmVuY2VzLCBhcyB0aGUgbmV3IGZpbGUgaXMNCj4gYnVpbHQtaW4gb24gdGhlIG1lZGlh
dGVrLWRybSBvYmplY3QgYW55d2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4N
Cj4gLS0tDQoNCltzbmlwXQ0KDQo+ICt2b2lkIG10a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtf
ZHBpICpkcGkpDQo+ICt7DQo+ICsJaWYgKFdBUk5fT04oZHBpLT5yZWZjb3VudCA9PSAwKSkNCj4g
KwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKC0tZHBpLT5yZWZjb3VudCAhPSAwKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5waXhlbF9jbGspOw0KPiAr
CWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPnR2ZF9jbGspOw0KPiArCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShkcGktPmVuZ2luZV9jbGspOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9OU19HUEwo
bXRrX2RwaV9wb3dlcl9vZmYsICJEUk1fTVRLX0RQSSIpOw0KDQpJIHRoaW5rIGFsbCB0aGUgY2Fs
bGVyIGlzIGluIHRoZSBzYW1lIG1vZHVsZSwgc28gaXQncyBub3QgbmVjZXNzYXJ5IHRvIGV4cG9y
dCB0aGVzZSBzeW1ib2xzLg0KU28gZHJvcCB0aGVzZSBFWFBPUlRzLg0KDQo+ICsNCj4gDQoNCltz
bmlwXQ0KDQo+ICtzdHJ1Y3QgbXRrX2RwaSAqbXRrX2RwaV9jb21tb25fcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldiwNCj4gKwkJCQkgICAgIGNvbnN0IHN0cnVjdCBkcm1fYnJpZGdl
X2Z1bmNzICpicmlkZ2VfZnVuY3MpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBk
ZXYtPmRldjsNCj4gKwlzdHJ1Y3QgbXRrX2RwaSAqZHBpOw0KPiArCWludCByZXQ7DQo+ICsNCj4g
KwlkcGkgPSBkZXZtX2RybV9icmlkZ2VfYWxsb2MoZGV2LCBzdHJ1Y3QgbXRrX2RwaSwgYnJpZGdl
LCBicmlkZ2VfZnVuY3MpOw0KPiArCWlmIChJU19FUlIoZHBpKSkNCj4gKwkJcmV0dXJuIGRwaTsN
Cj4gKw0KPiArCWRwaS0+ZGV2ID0gZGV2Ow0KPiArCWRwaS0+Y29uZiA9IChzdHJ1Y3QgbXRrX2Rw
aV9jb25mICopb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsJZHBpLT5vdXRwdXRf
Zm10ID0gTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVgyNDsNCj4gKw0KPiArCWRwaS0+cGluY3RybCA9
IGRldm1fcGluY3RybF9nZXQoZGV2KTsNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoZHBpLT5waW5j
dHJsKSkgew0KDQpZb3UgY2hhbmdlIElTX0VSUigpIHRvIElTX0VSUl9PUl9OVUxMKCkgaGVyZSwg
YnV0IGNvbW1pdCBtZXNzYWdlIGRvZXMgbm90IG1lbnRpb24gdGhpcy4NCktlZXAgSVNfRVJSKCkg
b3Igc2F5IHNvbWV0aGluZyBpbiBjb21taXQgbWVzc2FnZS4NCg0KPiArCQlkZXZfZGJnKGRldiwg
IkNhbm5vdCBmaW5kIHBpbmN0cmwhXG4iKTsNCj4gKwkJZHBpLT5waW5jdHJsID0gTlVMTDsNCj4g
Kwl9IGVsc2Ugew0KPiArCQlkcGktPnBpbnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRw
aS0+cGluY3RybCwgInNsZWVwIik7DQo+ICsJCWlmIChJU19FUlIoZHBpLT5waW5zX2dwaW8pKSB7
DQo+ICsJCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQo+ICsJCQlkZXZfZGJnKGRldiwgIkNhbm5v
dCBmaW5kIHBpbmN0cmwgaWRsZSFcbiIpOw0KPiArCQl9DQo+ICsJCWlmIChkcGktPnBpbnNfZ3Bp
bykNCj4gKwkJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2dw
aW8pOw0KPiArDQo+ICsJCWRwaS0+cGluc19kcGkgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShkcGkt
PnBpbmN0cmwsICJkZWZhdWx0Iik7DQo+ICsJCWlmIChJU19FUlIoZHBpLT5waW5zX2RwaSkpIHsN
Cj4gKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KPiArCQkJZGV2X2RiZyhkZXYsICJDYW5ub3Qg
ZmluZCBwaW5jdHJsIGFjdGl2ZSFcbiIpOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJZHBpLT5y
ZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiArCWlmIChJ
U19FUlIoZHBpLT5yZWdzKSkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHRyX3Byb2JlKGRldiwgUFRS
X0VSUihkcGktPnJlZ3MpLA0KPiArCQkJCQkgIkZhaWxlZCB0byBpb3JlbWFwIG1lbSByZXNvdXJj
ZVxuIik7DQo+ICsNCj4gKwlkcGktPmVuZ2luZV9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiZW5n
aW5lIik7DQo+ICsJaWYgKElTX0VSUihkcGktPmVuZ2luZV9jbGspKQ0KPiArCQlyZXR1cm4gZGV2
X2Vycl9wdHJfcHJvYmUoZGV2LCBQVFJfRVJSKGRwaS0+ZW5naW5lX2NsayksDQo+ICsJCQkJCSAi
RmFpbGVkIHRvIGdldCBlbmdpbmUgY2xvY2tcbiIpOw0KPiArDQo+ICsJZHBpLT5waXhlbF9jbGsg
PSBkZXZtX2Nsa19nZXQoZGV2LCAicGl4ZWwiKTsNCj4gKwlpZiAoSVNfRVJSKGRwaS0+cGl4ZWxf
Y2xrKSkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHRyX3Byb2JlKGRldiwgUFRSX0VSUihkcGktPnBp
eGVsX2NsayksDQo+ICsJCQkJCSAiRmFpbGVkIHRvIGdldCBwaXhlbCBjbG9ja1xuIik7DQo+ICsN
Cj4gKwlkcGktPnR2ZF9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGxsIik7DQo+ICsJaWYgKElT
X0VSUihkcGktPnR2ZF9jbGspKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wdHJfcHJvYmUoZGV2LCBQ
VFJfRVJSKGRwaS0+dHZkX2NsayksDQo+ICsJCQkJCSAiRmFpbGVkIHRvIGdldCB0dmRwbGwgY2xv
Y2tcbiIpOw0KPiArDQo+ICsJZHBpLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0K
PiArCWlmIChkcGktPmlycSA8IDApDQo+ICsJCXJldHVybiBFUlJfUFRSKGRwaS0+aXJxKTsNCj4g
Kw0KPiArCWRwaS0+bmV4dF9icmlkZ2UgPSBkZXZtX2RybV9vZl9nZXRfYnJpZGdlKGRwaS0+ZGV2
LCBkcGktPmRldi0+b2Zfbm9kZSwgMSwgLTEpOw0KPiArCWlmIChJU19FUlIoZHBpLT5uZXh0X2Jy
aWRnZSkgJiYgUFRSX0VSUihkcGktPm5leHRfYnJpZGdlKSA9PSAtRU5PREVWKSB7DQo+ICsJCS8q
IE9sZCBkZXZpY2V0cmVlIGhhcyBvbmx5IG9uZSBlbmRwb2ludCAqLw0KPiArCQlkcGktPm5leHRf
YnJpZGdlID0gZGV2bV9kcm1fb2ZfZ2V0X2JyaWRnZShkcGktPmRldiwgZHBpLT5kZXYtPm9mX25v
ZGUsIDAsIDApOw0KPiArCX0NCj4gKwlpZiAoSVNfRVJSKGRwaS0+bmV4dF9icmlkZ2UpKQ0KPiAr
CQlyZXR1cm4gZGV2X2Vycl9wdHJfcHJvYmUoZHBpLT5kZXYsIFBUUl9FUlIoZHBpLT5uZXh0X2Jy
aWRnZSksDQo+ICsJCQkJCSAiRmFpbGVkIHRvIGdldCBicmlkZ2VcbiIpOw0KPiArDQo+ICsJcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgZHBpKTsNCj4gKw0KPiArCWRwaS0+YnJpZGdlLm9mX25v
ZGUgPSBkZXYtPm9mX25vZGU7DQo+ICsJZHBpLT5icmlkZ2UudHlwZSA9IERSTV9NT0RFX0NPTk5F
Q1RPUl9EUEk7DQo+ICsNCj4gKwlyZXQgPSBkZXZtX2RybV9icmlkZ2VfYWRkKGRldiwgJmRwaS0+
YnJpZGdlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiArDQo+
ICsJcmV0dXJuIGRwaTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKG10a19kcGlfY29t
bW9uX3Byb2JlLCAiRFJNX01US19EUEkiKTsNCg0KRHJvcCB0aGlzLg0KDQo+ICsNCj4gK01PRFVM
RV9BVVRIT1IoIkFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb20+Iik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1lZGlhVGVr
IERQSS9EVk8gQ29tbW9uIExpYnJhcnkiKTsNCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4g
DQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0cnVjdCBtdGtfZHBpIHsNCj4gKwlzdHJ1Y3QgZHJtX2Vu
Y29kZXIgZW5jb2RlcjsNCj4gKwlzdHJ1Y3QgZHJtX2JyaWRnZSBicmlkZ2U7DQo+ICsJc3RydWN0
IGRybV9icmlkZ2UgKm5leHRfYnJpZGdlOw0KPiArCXN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25u
ZWN0b3I7DQo+ICsJdm9pZCBfX2lvbWVtICpyZWdzOw0KPiArCXN0cnVjdCBkZXZpY2UgKmRldjsN
Cj4gKwlzdHJ1Y3QgZGV2aWNlICptbXN5c19kZXY7DQo+ICsJc3RydWN0IGNsayAqZW5naW5lX2Ns
azsNCj4gKwlzdHJ1Y3QgY2xrICpwaXhlbF9jbGs7DQo+ICsJc3RydWN0IGNsayAqdHZkX2NsazsN
Cj4gKwlpbnQgaXJxOw0KPiArCXN0cnVjdCBkcm1fZGlzcGxheV9tb2RlIG1vZGU7DQo+ICsJY29u
c3Qgc3RydWN0IG10a19kcGlfY29uZiAqY29uZjsNCj4gKwllbnVtIG10a19kcGlfb3V0X2NvbG9y
X2Zvcm1hdCBjb2xvcl9mb3JtYXQ7DQo+ICsJZW51bSBtdGtfZHBpX291dF95Y19tYXAgeWNfbWFw
Ow0KPiArCWVudW0gbXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KPiArCWVudW0gbXRrX2Rw
aV9vdXRfY2hhbm5lbF9zd2FwIGNoYW5uZWxfc3dhcDsNCj4gKwlzdHJ1Y3QgcGluY3RybCAqcGlu
Y3RybDsNCj4gKwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KPiArCXN0cnVjdCBw
aW5jdHJsX3N0YXRlICpwaW5zX2RwaTsNCj4gKwl1MzIgb3V0cHV0X2ZtdDsNCj4gKwlzOCByZWZj
b3VudDsNCg0KWW91IGNoYW5nZSB0aGUgdHlwZSBvZiByZWZjb3VudCBoZXJlLCBidXQgY29tbWl0
IG1lc3NhZ2UgZG9lcyBub3QgbWVudGlvbiB0aGlzLg0KS2VlcCB0aGUgb3JpZ2luYWwgdHlwZSBv
ciBzYXkgc29tZXRoaW5nIGluIGNvbW1pdCBtZXNzYWdlLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAr
fTsNCj4gKw0KDQo=
