Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32401C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4B910E43E;
	Fri, 28 Aug 2026 03:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ItHBsCud";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IOD0Gty2";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85DF10E439
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:32:52 +0000 (UTC)
X-UUID: 222a0a82a29111f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=H4t/G9GZCpolYbhUfnszaGlwyMp/MJvjWvvhkQaUKhw=; 
 b=ItHBsCudrS+vmq67Uf0UaAo43nPZekSdmuDQnIWUc/lozF6yK/0d5Q1zxEpEGT/+bATZhOn1ukpbUAgZZm0diyM8b+0QqneY8uZPdWDnQFh0B6YLX6OdyOAb7vZWf6MovaZT3NLzv+fNEM/KrnXgpRdVwa1bF1mppAnwNxJfa5A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:a02212b6-daeb-494d-9f54-cd0d923fbd10, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:34210eec-b0ff-457f-a9cc-6dcde3642cb9,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 222a0a82a29111f18dc8c9802ae25ab1-20260828
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 893969455; Fri, 28 Aug 2026 11:32:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 11:32:44 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 11:32:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5tpEtJKwYnEljID7QZ39ES7/HDyLkh4wl1vkRAfE6bhH8ozuzf5bDBc60P4KOqzwEmy5/uXniOBTQc1onJl4cO2l9pxkrC2lc4Qxv2PvKZSIZaFZTjx4YUAtMyJjfshZtYCkV8x6elj41sOQZnFLK9CVoHHWqu7r5a5tcYTWABI98C+N9jCIl11Sk+McueVxgqeBXxfrIcPh/N5Y+rGLe7uABoJnHaK8WyEc0Tzv1UcxX0DR6w3vNzY/Kcle8BgoVhzI34ord0tBzBUavW6BWhjkgJOkmXNZm+Th/vE0M0glA2Q1gEDgvHe1P2NhleJPvKTwgoNW2352tnwoRDKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4t/G9GZCpolYbhUfnszaGlwyMp/MJvjWvvhkQaUKhw=;
 b=bKjhSwzb4bC0A3tVplyesgtmyG+8ByhVXC96i0OHWOb2NDmoTRBWOn1SFghqvaB2I7E/E5myXFmkH8GXbBkFJV6lfvMPC/FdVWXZykim22fVUcQva/Tn33bM1akhfz3yTY5WNhCw7dLhVPW0wBJ9SlsZ+dywae2ARoIwx2FhcDssNl1+TtZOoERlDlEkCLnuA4fJ8n+xb2lpgh50O5Jx64ebfOMGxZy4q53tJy/w6teDxkgAmLRp8ERslFeh6wyFHtzCg8+Y+hpfK6CrmsCw35e2jAQlvdEQgICh1gn4RPtEUDCA+dIOhiiS7HsbU047cYePIiM+a2J1YY94DbKDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4t/G9GZCpolYbhUfnszaGlwyMp/MJvjWvvhkQaUKhw=;
 b=IOD0Gty2S+4A9j8Jp/SAPvaK27Lys/Q4lGoAJZRI3mX1JAPxJoFKU+S5cQ3NhKIPtPheNsIdxN/bd3fX+GWDpAvrLUCMe4y2vm3qHxTFPwKLw/SQGFGvY/btkfna60svVvUom32cELKvROkbaahDPW4Y8zaOkSICdf9zPYJrHSM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY1PPF06104D10D.apcprd03.prod.outlook.com (2603:1096:408::a44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 03:32:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:32:39 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 06/12] drm/mediatek: mtk_dp: Rework register offsets
 for proper PHY usage
Thread-Topic: [PATCH v4 06/12] drm/mediatek: mtk_dp: Rework register offsets
 for proper PHY usage
Thread-Index: AQHdD5ayvQRJaNCs006qrE4ZEq+BB7azHJEA
Date: Fri, 28 Aug 2026 03:32:38 +0000
Message-ID: <ad5343f93cc992dca96b42f6cb81868de0458f70.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-7-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY1PPF06104D10D:EE_
x-ms-office365-filtering-correlation-id: f726c524-99e0-4ccc-8389-08df04b5029d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|42112799006|23010399003|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Z8uqnv6w0XASR8M7YBJlNC15UuJqIDUete5zvqvyQtww3fsv6/CBJISDL5XdJWzz/WBJvRR6xsKvB2zv552XdoLlOsmymdettw34XrrU5lczR6LoAMt1UnKm1FdFAq+SdYfAePHCapSpyIE4qb2Kb+NMjQTNNxC7DTG1To9Tiuyb68e8m/LoUDtT9hVXyjDn4oJgjrh/2YeKMjTK1s++XI6RNuI9V4uxUdAWfS66RZ9zL4ctYSOoLTs+Xw4lCcyJg1cxM2t06fRER2gKbPwU/qAspDw9Xcqhsu5HL84b+bouDHeThIWtv4uOROkXgDsdC/tWgEslOxrF5AX/P+vUCUfeemybA5wvdHZyRh5yV/8XO74Hb4I7uokZkZkSiGoOxGFDHEKG18fcSPNBqWBUGjvzrKwH1O+TjCMLh0kz4RA3xv1QKiwjKfyZ+lRncqgE3vWEopAD3MOXkicrbDrZhq5aG5/tFFn5z6YeLLa69EJ1eiLazBdj06noQVOv22B21iLlOHAX9m20z4n1jvKzom9OYAVBHI461X4ZuZlw7HA9GRQTQM1vafYW36GPgwSef7gAu08/zKBzSlif5LFh2SbTGxNn6dqUw//Lg7PQEvFJ6RNWB6JsRhAfJFt/lk2NwSWufVS2bYZNwfdAzs+tey0Z650dajpQTOE1+jMS8x5pU7FQF/GwjUYy4klrtQ9ovivdU9iVRMCgTXbdqe1H3+gD5wZM363NGXTe6HLyIQs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(42112799006)(23010399003)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhnc1lmcmU2aDdEZkVSanZOYTd3YXJPZCtTUkRZRnBURFh3Z2dzcHJkMkY0?=
 =?utf-8?B?UEozYnhEdVJxVm45Y1o5RlVrSk9xTGNSMDJGNTRBL1pPVjQrbVdOc0I2QTEw?=
 =?utf-8?B?WkVNYlc3T3dLVUdzU3lwTk5wQzg5SVJ3U1lENittNG9PNVZBMm8yVzBaeVVB?=
 =?utf-8?B?WEQzWWpJc0gwNk1FdlJiQ3RXSmhBMmVZVlFEaldEeFFXbTVGZGdja3pmOFVl?=
 =?utf-8?B?cWxHendKYmtJeFd3NnRwRlBRbytxZU9zMklYWTNnMFF2R0d2UzJlWG45a1lz?=
 =?utf-8?B?Q0V0cDBiZkVsSUk5Q2RvblJmdUxRcE91dVhUamhpZ0kxZ1VhaDZSZUhUYmJU?=
 =?utf-8?B?NXVHUVYyN0ZNeEc5a01LTzB2Y3VJRGZEaUFQVkRtWlY5QVVIanpQeHNuZ0pK?=
 =?utf-8?B?T0ZqVUdGVUtFVk85a1VPaGtFQlYzY3RRREZIUDhhQ0E4T29GZzd4bmdpYzRR?=
 =?utf-8?B?NTZLTlEzZDdCNW96b3lMMGs5emZXZkc1VnNJUWVpdmhvUzlXbjBTeEFBOStG?=
 =?utf-8?B?bkREYVpsS2VuWG81NUVIM0NWVFQ2ajlLL0lnMVcrZWJGMHk0K2RXdENDU2l5?=
 =?utf-8?B?WEhmcWZ0L0RuV3NCTWFOTURDZTNLeWtBVDNpZFlGeWFEWGg2TjdjN0NwblNl?=
 =?utf-8?B?TTcwNHFFZ2NEaGdPTXh1WmFVYUQraEVDRHF4WFM0dVRIL0FONUV6M1ljdXBk?=
 =?utf-8?B?Zk0rTTQ3TWFwZnFrYjBEeDRuNWlvUXYwMmdzQlhhWjRNNFdRdC9DMXBiSVdH?=
 =?utf-8?B?dlRzOElTeGVnUkFkVmQxRkN5S0w5WGtHVzNFaGdWTzhoVjYwQW1lTU9JakVx?=
 =?utf-8?B?d21RSGErWnpWQVptR2Y4K08xcStnSWJSVFpnUHFEck03bUFTeVZjbGQ5bXZp?=
 =?utf-8?B?dHQwMWhFQndRUjdsOFpNZGhkTmtQVFpMRGgyWXJjSEdwRStLU3U1RUlRMk5B?=
 =?utf-8?B?YzJXcHM2QTg0VktpZE4rUmdZMzVjbmc4L0l3ckowSzErOXVieVQvVTZuNjda?=
 =?utf-8?B?UGEzU01RNFNMcHViZ3d2OGFlNzNHdVc2NElRR25JNHZwQ1d0ZWZqdUZuMzk0?=
 =?utf-8?B?R1NVTEFZN00rNGdONnBqRUtCMkpmTXU5UWJhc1FtbHcycmZOQnU3dUlRSU9i?=
 =?utf-8?B?elRRYWlibnpHbnkzbFRlNityUFFOQ3B2WEx0NHdhZE9ITlJ4cDdMM2p5cy9x?=
 =?utf-8?B?TG9ITnMyU0RGdXZQT3h4T0VDTjRnNzJKcm5aMXVGQnBYZjVMNFJSOHRJUjJV?=
 =?utf-8?B?Wk1yeHd1SHAxa2xHamZkcDZBYU9rSjczYUMwSWN2Z01sQ0NraGlmNjFJcXJy?=
 =?utf-8?B?RkRUdnRsa3hYa3JzdTFTMkNmamxkbHpCUmM0bTJqL29QSWRqMGxiNnh6QXRN?=
 =?utf-8?B?bFBiKzFtelJiQmZDc2d1Wmluc0MwekVjY1d1eHlXa3R3ZWZmWExlU3R3WnpQ?=
 =?utf-8?B?Z09HMjZYN1cyc29keXZUTlRXNlJ3VTZ5VjNiaWR6RitsVmZ6Wkl3QjBhMWNp?=
 =?utf-8?B?RUJFTGZvN0NUUGRkVkovbXNJUWVMc2RObjlYNU02N2txSm95VzdkaXZrc040?=
 =?utf-8?B?WXJzODcvMnNnTWx2SkF2WFNhN3JtdTBsVVhMU2VzMXZ6eEVyRlk1UVJyTnFT?=
 =?utf-8?B?SU54L3RRYzYzYzRVVVpyMUdmV0U3T2hNWnNydUl1c05ud1E0d2FyenRnTUJZ?=
 =?utf-8?B?YXJvNTFtczZOTDc2OUd2d01yWUxuRitNSDFyc09VeVMrMTNzb09DRzljSEto?=
 =?utf-8?B?V2h0U3dzTTVkYW9IUmJiYUcySFFRTGF1QlZKaE15M3RqVk5DSVY0WFdLVHht?=
 =?utf-8?B?NkVHOHVQdlVNcVlSZU1TRFJ5U29GVEpIS2gwYkRJODZuUEw3ZS8vWDBnQTJl?=
 =?utf-8?B?OGt3U1owM2tBaGpsK2J4Vzl6TTdYWHF2VGUxVUtwZUpsL2hEU05VZ2ZPL1pj?=
 =?utf-8?B?NnVYc01rRnNEWVBTR3JORW02QnM3dHRGUDdHakNIRGhRVy9aWTREc0NLdFpK?=
 =?utf-8?B?N2UwL1hUNyt5dDA1N0lEWG94UXJFWlRZM2JVNktmeVhmQkMvZk4vYUhnelJS?=
 =?utf-8?B?SDBqNWZsaGEvTEpCQkIwaittUEZZMUYyazR1eUZGVGlTblNBOFFkenNXYWhJ?=
 =?utf-8?B?R25nTm91aFRDZnNsL2J5UkkzU1VlWElTc2dCNnl3N2Nrbkx2eDdsQTZuZk5B?=
 =?utf-8?B?a2Y4OUZKL3FvWFdqTVNyNmM1TlVObThZRm1CdUc5RDNPT1pCbTBwM0h4MWhn?=
 =?utf-8?B?citUaHZ5Z0hXZGtoWXpWNjk5U1I5VGxVc1I2Q0JjSHE0Q2tpbUlCci9KNlp1?=
 =?utf-8?B?WFN0Y1hHcG01YzBaa0hYN0VGZHRtcUU5V0Z5K2hzL3FnSTRTeStaQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43FF4D5F51B15C4582270915A23384F1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gKLKGMbxqlW+9gRSETijPIInF6MG1w0Gdtpy3yYoj+xwiaM4WH8l2PdC/g1AFtNTrui64C+01JOrzSN4O45Msa8LGN/0qXgg9dcajU82hTc9J9HAVEh3f+RIdFBxX9QT2FAd1d41uITkgn06vIlVqXUu98OIAPr5PbkQWTK1OpqZonNx3ujEZJ3/y005fC4JTIjdbDHuHxlDJNavKjYKZfr8src5lW6PdC0FfuXB4zH8+GB0OWpkHa5WbLc3XI4/k8NqwCSRQy26Oy4ZWHjvuY9vkHMZEs+D9gZd0IBVuoMKPxxTounXvkC4zMjCr5wU9jFWbVJPzBoXOnriNaWZQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f726c524-99e0-4ccc-8389-08df04b5029d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 03:32:38.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfUgI7ysUe2iYWrlPpusg0S84HRbYsxEyqSn12hVGeQkEvklNLqgKic1eRa0Sxg3wK1Pn3bDAsh603H1/NN3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF06104D10D
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gUmV3b3JrIGFsbCBvZiB0aGUgcmVnaXN0ZXIgb2Zmc2V0cyB0byBzdWJ0
cmFjdCB0aGUgRFAgUEhZIHJlZ2lzdGVyDQo+IHJhbmdlIGZyb20gdGhlIE1lZGlhVGVrIERpc3Bs
YXlQb3J0IElQIHJlZ2lzdGVyIHJhbmdlIHdoaWNoIHN0YXJ0cw0KPiBmcm9tIFRPUF9PRkZTRVQg
aW5zdGVhZC4NCj4gDQo+IFRoaXMgaXMgZG9uZSBpbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIHN1
cHBvcnQgZm9yIHJlZ2lzdGVyaW5nIHRoZQ0KPiBQSFkgZnJvbSBkZXZpY2V0cmVlLCBhbmQgYWxz
byBmb3IgcHJvcGVybHkgaGFuZGxpbmcgUEhZIHJlZ2lzdGVycw0KPiBpbiB0aGUgUEhZIGRyaXZl
ciAoaW5zdGVhZCBvZiBoYWxmIGFuZCBoYWxmLi4uKSwgd2hpY2ggaXMgYWxzbyBvbmUNCj4gcHJl
cm9nYXRpdmUgdG8gYWRkIHN1cHBvcnQgZm9yIG5ldyBJUCB2ZXJzaW9ucyBpbiB0aGUgZnV0dXJl
Lg0KPiANCj4gTm90ZSB0aGF0IHRoZSBjdXJyZW50IHJlZ21hcF9jb25maWcgd2FzIHJlbmFtZWQg
dG8gbWFrZSBzdXJlIHRoYXQNCj4gaXQgYmVpbmcgbGVnYWN5IGlzIG1lbnRpb25lZCwgYXMgYSBu
ZXcgY29uZmlnIHdpbGwgYmUgcmVxdWlyZWQgaW4NCj4gZnV0dXJlIGNoYW5nZXMuDQo+IA0KPiBP
ZiBjb3Vyc2UsIHdpdGggdGhlIFRPUCBvZmZzZXQgYmVpbmcgcmVsYXRlZCB0byBoYXJkd2FyZSBy
ZWdpc3RlcnMNCj4gdGhpcyB3aWxsIG5ldmVyIGNoYW5nZSBmb3IgdGhlIGN1cnJlbnRseSBzdXBw
b3J0ZWQgU29DcywgaGVuY2UgZm9yDQo+IHNpbXBsaWZ5aW5nIGNvZGUsIHRoZSBNVEtfRFBfVE9Q
X09GRlNFVF9MRUdBQ1kgaXMgYWRkZWQgc3RhdGljYWxseQ0KPiB0byB0aGUgbGVnYWN5IHJlZ21h
cCBjb25maWd1cmF0aW9uIHdoaWxlLCBvbiB0aGUgb3RoZXIgaGFuZCwgaXQgaXMNCj4gYWRkZWQg
ZHluYW1pY2FsbHkgdG8gdGhlIG10a19kcCBzdHJ1Y3R1cmUsIGFzIHRoZSBsYXR0ZXIgaXMgdXNl
ZA0KPiB0byBhZGQgYW4gb2Zmc2V0IHRvIGV2ZXJ5IHJlZ2lzdGVyIHdyaXRlIGluIHRoZSBtdGtf
ZHAgZHJpdmVyLg0KPiANCj4gVGhlIHJlZ21hcF9jb25maWcgcHJvdmlkZWQgcmVnX2Jhc2UgKHdo
aWNoIGRvZXMgZXhhY3RseSB0aGUgc2FtZSkNCj4gY2Fubm90IGJlIHVzZWQgaGVyZSwgYmVjYXVz
ZSB0aGUgUEhZIGRyaXZlciBpcyB1c2luZyB0aGUgdmVyeSBzYW1lDQo+IHJlZ21hcCBwb2ludGVy
LCBhbmQgdGhlIG9mZnNldCBzaGFsbCBub3QgYmUgdGFrZW4gaW50byBhY2NvdW50IGluDQo+IHdy
aXRlcyBwZXJmb3JtZWQgYnkgdGhlIFBIWSBkcml2ZXIgKG9ubHkgb25lcyBwZXJmb3JtZWQgYnkg
bXRrX2RwISkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyAgICAgfCAxMDEgKysrKystLS0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaCB8IDI1NSArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNzkgaW5zZXJ0aW9ucygrKSwgMTc3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBpbmRleCBi
NTAyNjRjYTFmMzEuLmIyZTVmYTA5MTRiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHAuYw0KPiBAQCAtMzUsNiArMzUsMjcgQEANCj4gIA0KPiAgI2luY2x1ZGUgIm10a19kcF9yZWcu
aCINCj4gIA0KPiArLyogUEhZIFJlZ2lzdGVycyAtIGZvciBsZWdhY3kgb25seSAqLw0KPiArI2Rl
ZmluZSBEUF9QSFlfR0xCX0JJQVNfR0VOXzAwCQkweDANCj4gKyMgIGRlZmluZSBSR19YVFBfR0xC
X0JJQVNfSU5UUl9DVFJMCUdFTk1BU0soMjAsIDE2KQ0KDQpBbGlnbiB0aGUgcmVnaXN0ZXIgZGVm
aW5pdGlvbiBpbmRlbnQgdG8gb3RoZXIgbXRrIGRwIHJlZ2lzdGVyIGRlZmluaXRpb24uDQoNCj4g
KyNkZWZpbmUgRFBfUEhZX0dMQl9EUEFVWF9UWAkJMHg4DQo+ICsjICBkZWZpbmUgUkdfQ0tNX1BU
MF9DS1RYX0lNUFNFTAlHRU5NQVNLKDIzLCAyMCkNCj4gKyNkZWZpbmUgTVRLX0RQXzAwMzQJCQkw
eDM0DQo+ICsjICBkZWZpbmUgREFfQ0tNX0NLVFgwX0VOX0ZPUkNFX0VOCUJJVCgxMCkNCj4gKyNk
ZWZpbmUgRFBfUEhZX0xBTkVfVFhfMAkJMHgxMDQNCj4gKyNkZWZpbmUgRFBfUEhZX0xBTkVfVFhf
MQkJMHgyMDQNCj4gKyNkZWZpbmUgRFBfUEhZX0xBTkVfVFhfMgkJMHgzMDQNCj4gKyNkZWZpbmUg
RFBfUEhZX0xBTkVfVFhfMwkJMHg0MDQNCj4gKyMgIGRlZmluZSBSR19YVFBfTE54X1RYX0lNUFNF
TF9QTU9TCUdFTk1BU0soMTUsIDEyKQ0KPiArIyAgZGVmaW5lIFJHX1hUUF9MTnhfVFhfSU1QU0VM
X05NT1MJR0VOTUFTSygxOSwgMTYpDQo+ICsjZGVmaW5lIERQX1BIWV9BVVhfUlhfQ1RMCQkweDEw
NDANCj4gKyMgIGRlZmluZSBSR19EUEFVWF9SWF9WQUxJRF9ERUdMSVRDSF9FTglCSVQoMikNCj4g
KyMgIGRlZmluZSBSR19YVFBfR0xCX0NLREVUX0VOCQlCSVQoMSkNCj4gKyMgIGRlZmluZSBSR19E
UEFVWF9SWF9FTgkJQklUKDApDQo+ICsNCg0KW3NuaXBdDQoNCj4gIHN0YXRpYyBpbnQgbXRrX2Rw
X3dyaXRlKHN0cnVjdCBtdGtfZHAgKm10a19kcCwgdTMyIG9mZnNldCwgdTMyIHZhbCkNCj4gIHsN
Cj4gLQlpbnQgcmV0ID0gcmVnbWFwX3dyaXRlKG10a19kcC0+cmVncywgb2Zmc2V0LCB2YWwpOw0K
PiArCWludCByZXQgPSByZWdtYXBfd3JpdGUobXRrX2RwLT5yZWdzLCBvZmZzZXQgKyBtdGtfZHAt
PmxlZ2FjeV9yZWdvZmYsIHZhbCk7DQo+ICANCj4gIAlpZiAocmV0KQ0KPiAgCQlkZXZfZXJyKG10
a19kcC0+ZGV2LA0KPiBAQCAtNDM2LDcgKzQ2MCw3IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3dyaXRl
KHN0cnVjdCBtdGtfZHAgKm10a19kcCwgdTMyIG9mZnNldCwgdTMyIHZhbCkNCj4gIHN0YXRpYyBp
bnQgbXRrX2RwX3VwZGF0ZV9iaXRzKHN0cnVjdCBtdGtfZHAgKm10a19kcCwgdTMyIG9mZnNldCwN
Cj4gIAkJCSAgICAgIHUzMiB2YWwsIHUzMiBtYXNrKQ0KPiAgew0KPiAtCWludCByZXQgPSByZWdt
YXBfdXBkYXRlX2JpdHMobXRrX2RwLT5yZWdzLCBvZmZzZXQsIG1hc2ssIHZhbCk7DQo+ICsJaW50
IHJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhtdGtfZHAtPnJlZ3MsIG9mZnNldCArIG10a19kcC0+
bGVnYWN5X3JlZ29mZiwgbWFzaywgdmFsKTsNCj4gIA0KPiAgCWlmIChyZXQpDQo+ICAJCWRldl9l
cnIobXRrX2RwLT5kZXYsDQo+IEBAIC01NjYsNyArNTkwLDggQEAgc3RhdGljIGludCBtdGtfZHBf
c2V0X2NvbG9yX2Zvcm1hdChzdHJ1Y3QgbXRrX2RwICptdGtfZHAsDQo+ICAJCQkgICBEUF9URVNU
X0NPTE9SX0ZPUk1BVF9NQVNLKTsNCj4gIA0KPiAgCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAs
IE1US19EUF9FTkMwX1AwXzMwM0MsDQo+IC0JCQkgICB2YWwsIFBJWEVMX0VOQ09ERV9GT1JNQVRf
RFBfRU5DMF9QMF9NQVNLKTsNCj4gKwkJCSAgIEZJRUxEX1BSRVAoUElYRUxfRU5DT0RFX0ZPUk1B
VF9EUF9FTkMwX1AwX01BU0ssIHZhbCksDQoNClRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gcmVnaXN0
ZXIgb2Zmc2V0LCBzbyBtb3ZlIHRvIG90aGVyIHBhdGNoLg0KDQo+ICsJCQkgICBQSVhFTF9FTkNP
REVfRk9STUFUX0RQX0VOQzBfUDBfTUFTSyk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCg0K
W3NuaXBdDQoNCj4gIHN0YXRpYyBpbnQgbXRrX2RwX3BoeV9jb25maWd1cmUoc3RydWN0IG10a19k
cCAqbXRrX2RwLA0KPiBAQCAtMTQwMSwyMSArMTQxNCwyMSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBf
cG93ZXJfZW5hYmxlKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIAkJCSAgIFNXX1JTVF9CX1BI
WUQsIFNXX1JTVF9CX1BIWUQpOw0KPiAgCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19E
UF9UT1BfUFdSX1NUQVRFLA0KPiAgCQkJICAgRFBfUFdSX1NUQVRFX0JBTkRHQVBfVFBMTCwgRFBf
UFdSX1NUQVRFX01BU0spOw0KPiAtCW10a19kcF93cml0ZShtdGtfZHAsIE1US19EUF8xMDQwLA0K
PiArCXJlZ21hcF93cml0ZShtdGtfZHAtPnJlZ3MsIERQX1BIWV9BVVhfUlhfQ1RMLA0KPiAgCQkg
ICAgIFJHX0RQQVVYX1JYX1ZBTElEX0RFR0xJVENIX0VOIHwgUkdfWFRQX0dMQl9DS0RFVF9FTiB8
DQo+ICAJCSAgICAgUkdfRFBBVVhfUlhfRU4pOw0KPiAtCW10a19kcF91cGRhdGVfYml0cyhtdGtf
ZHAsIE1US19EUF8wMDM0LCAwLCBEQV9DS01fQ0tUWDBfRU5fRk9SQ0VfRU4pOw0KPiArCXJlZ21h
cF9jbGVhcl9iaXRzKG10a19kcC0+cmVncywgTVRLX0RQXzAwMzQsIERBX0NLTV9DS1RYMF9FTl9G
T1JDRV9FTik7DQoNCkhvdyBkbyB5b3Uga25vdyBNVEtfRFBfMTA0MCBoYXMgYSBtZWFuaW5nZnVs
IG5hbWUgRFBfUEhZX0FVWF9SWF9DVEw/DQpXaHkgZG9uJ3QgeW91IGtub3cgTVRLX0RQXzAwMzQg
aGFzIGEgbWVhbmluZ2Z1bCBuYW1lPw0KDQo+ICB9DQo+ICANCj4gDQoNCltzbmlwXQ0KDQoNCj4g
QEAgLTY5LDQzICsyOSw1OSBAQA0KPiAgI2RlZmluZSBEUF9UWDJfUFJFX0VNUEhfTUFTSwkJCUdF
Tk1BU0soMTksIDE4KQ0KPiAgI2RlZmluZSBEUF9UWDNfVk9MVF9TV0lOR19NQVNLCQkJR0VOTUFT
SygyNSwgMjQpDQo+ICAjZGVmaW5lIERQX1RYM19QUkVfRU1QSF9NQVNLCQkJR0VOTUFTSygyNywg
MjYpDQo+IC0jZGVmaW5lIE1US19EUF9UT1BfUkVTRVRfQU5EX1BST0JFCTB4MjAyMA0KPiArI2Rl
ZmluZSBNVEtfRFBfVE9QX1JFU0VUX0FORF9QUk9CRQkweDIwDQo+ICAjZGVmaW5lIFNXX1JTVF9C
X1BIWUQJCQkJQklUKDQpDQo+IC0jZGVmaW5lIE1US19EUF9UT1BfSVJRX01BU0sJCTB4MjAyYw0K
PiArI2RlZmluZSBSR19TV19SU1RfTUFTSwkJCQlHRU5NQVNLKDcsIDApDQo+ICsjZGVmaW5lIFJH
X1NXX1JTVAkJCQkweGZmDQo+ICsjZGVmaW5lIFJHX1BST0JFX0xPV19TRUxfTUFTSwkJCUdFTk1B
U0soMTgsIDE2KQ0KPiArI2RlZmluZSBSR19QUk9CRV9MT1dfU0VMCQkJQklUKDE2KQ0KPiArI2Rl
ZmluZSBSR19QUk9CRV9MT1dfSElHSF9TV0FQX01BU0sJCUJJVCgyMykNCj4gKyNkZWZpbmUgUkdf
UFJPQkVfTE9XX0hJR0hfU1dBUAkJCUJJVCgyMykNCg0KVGhlc2UgbmV3IGRlZmluaXRpb24gaXMg
bm90IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaCwgc28gbW92ZSB0byBvdGhlciBwYXRjaC4NCg0KPiAr
DQo+ICsjZGVmaW5lIE1US19EUF9UT1BfSVJRX01BU0sJCTB4MmMNCj4gKyNkZWZpbmUgRU5DT0RF
Ul9JUlFfTVNLCQkJCUJJVCgwKQ0KPiArI2RlZmluZSBUUkFOU19JUlFfTVNLCQkJCUJJVCgxKQ0K
DQpEaXR0by4NCg0KPiAgI2RlZmluZSBJUlFfTUFTS19BVVhfVE9QX0lSUQkJCUJJVCgyKQ0KPiAt
I2RlZmluZSBNVEtfRFBfVE9QX01FTV9QRAkJMHgyMDM4DQo+ICsNCj4gKyNkZWZpbmUgTVRLX0RQ
X1RPUF9NRU1fUEQJCTB4MzgNCj4gICNkZWZpbmUgTUVNX0lTT19FTgkJCQlCSVQoMCkNCj4gICNk
ZWZpbmUgRlVTRV9TRUwJCQkJQklUKDIpDQo+ICANCj4gLS8qIG9mZnNldDogRU5DMF9PRkZTRVQg
KDB4MzAwMCkgKi8NCj4gLSNkZWZpbmUgTVRLX0RQX0VOQzBfUDBfMzAwMAkJCTB4MzAwMA0KPiAr
I2RlZmluZSBFRFBfVFhfVE9QX0NMS0dFTl8wCQkweDc0DQo+ICsjZGVmaW5lIEVEUF9UWF9UT1Bf
Q0xLR0VOX1JFU1RfTUFTSwkJMHhmDQo+ICsjZGVmaW5lIEVEUF9UWF9UT1BfQ0xLR0VOX1JFU1Rf
VkFMVUUJCTB4Zg0KDQpEaXR0by4NCg0KPiArDQo+ICsvKiBvZmZzZXQ6IEVOQzBfT0ZGU0VUICgw
eDEwMDApICovDQo+ICsjZGVmaW5lIE1US19EUF9FTkMwX1AwXzMwMDAJCQkweDEwMDANCj4gICNk
ZWZpbmUgTEFORV9OVU1fRFBfRU5DMF9QMF9NQVNLCQkJR0VOTUFTSygxLCAwKQ0KPiAgI2RlZmlu
ZSBWSURFT19NVVRFX1NXX0RQX0VOQzBfUDAJCQlCSVQoMikNCj4gICNkZWZpbmUgVklERU9fTVVU
RV9TRUxfRFBfRU5DMF9QMAkJCUJJVCgzKQ0KPiAgI2RlZmluZSBFTkhBTkNFRF9GUkFNRV9FTl9E
UF9FTkMwX1AwCQkJQklUKDQpDQo+IC0jZGVmaW5lIE1US19EUF9FTkMwX1AwXzMwMDQJCQkweDMw
MDQNCj4gKyNkZWZpbmUgRFBfSV9NT0RFX0VOQUJMRQkJCQlCSVQoNikNCj4gKyNkZWZpbmUgUkVH
X0JTX1NZTUJPTF9DTlRfUkVTRVQJCQkJQklUKDcpDQoNCkRpdHRvLg0KDQo+ICsjZGVmaW5lIE1U
S19EUF9FTkMwX1AwXzMwMDQJCQkweDEwMDQNCj4gICNkZWZpbmUgVklERU9fTV9DT0RFX1NFTF9E
UF9FTkMwX1AwX01BU0sJCUJJVCg4KQ0KPiAgI2RlZmluZSBEUF9UWF9FTkNPREVSXzRQX1JFU0VU
X1NXX0RQX0VOQzBfUDAJCUJJVCg5KQ0KPiAgI2RlZmluZSBTRFBfUkVTRVRfU1dfRFBfRU5DMF9Q
MAkJCQlCSVQoMTMpDQo+IA0KDQpbc25pcF0NCg0KPiAgI2RlZmluZSBWSURFT19DT0xPUl9ERVBU
SF9EUF9FTkMwX1AwXzhCSVQJCSgzIDw8IDgpDQo+ICAjZGVmaW5lIFZJREVPX0NPTE9SX0RFUFRI
X0RQX0VOQzBfUDBfNkJJVAkJKDQgPDwgOCkNCj4gICNkZWZpbmUgUElYRUxfRU5DT0RFX0ZPUk1B
VF9EUF9FTkMwX1AwX01BU0sJCUdFTk1BU0soMTQsIDEyKQ0KPiAtI2RlZmluZSBQSVhFTF9FTkNP
REVfRk9STUFUX0RQX0VOQzBfUDBfUkdCCQkoMCA8PCAxMikNCj4gLSNkZWZpbmUgUElYRUxfRU5D
T0RFX0ZPUk1BVF9EUF9FTkMwX1AwX1lDQkNSNDIyCQkoMSA8PCAxMikNCj4gLSNkZWZpbmUgUElY
RUxfRU5DT0RFX0ZPUk1BVF9EUF9FTkMwX1AwX1lDQkNSNDIwCQkoMiA8PCAxMikNCj4gKyMgIGRl
ZmluZSBQSVhFTF9FTkNPREVfRk9STUFUX0RQX0VOQzBfUDBfUkdCCQkwDQo+ICsjICBkZWZpbmUg
UElYRUxfRU5DT0RFX0ZPUk1BVF9EUF9FTkMwX1AwX1lDQkNSNDIyCTENCj4gKyMgIGRlZmluZSBQ
SVhFTF9FTkNPREVfRk9STUFUX0RQX0VOQzBfUDBfWUNCQ1I0MjAJMg0KDQpZb3UgY2hhbmdlIHRo
ZSB2YWx1ZS4gV2h5Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArIyAgZGVmaW5lIFBJWEVMX0VOQ09E
RV9GT1JNQVRfRFBfRU5DMF9QMF9ZT05MWQkJMw0KPiArIyAgZGVmaW5lIFBJWEVMX0VOQ09ERV9G
T1JNQVRfRFBfRU5DMF9QMF9SQVcJCTQNCj4gICNkZWZpbmUgVklERU9fTU5fR0VOX0VOX0RQX0VO
QzBfUDAJCQlCSVQoMTUpDQo+IC0jZGVmaW5lIE1US19EUF9FTkMwX1AwXzMwNDAJCQkweDMwNDAN
Cj4gKyNkZWZpbmUgTVRLX0RQX0VOQzBfUDBfMzA0MAkJCTB4MTA0MA0KPiAgI2RlZmluZSBTRFBf
RE9XTl9DTlRfRFBfRU5DMF9QMF9WQUwJCQkweDIwDQo+ICAjZGVmaW5lIFNEUF9ET1dOX0NOVF9J
TklUX0RQX0VOQzBfUDBfTUFTSwkJR0VOTUFTSygxMSwgMCkNCj4gDQoNCg==
