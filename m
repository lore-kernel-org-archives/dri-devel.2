Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD941606A338
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Pl7NnQ7f;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=oaSMHjVi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA4210E711;
	Mon, 23 Nov 2026 08:57:34 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2AB10E711
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:57:22 +0000 (UTC)
X-UUID: de003ffae71b11f18dc8c9802ae25ab1-20261123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=fr8PZqLtRKo4Bq8BzDB8RTsIpCquN+aMbdJ7khfi9uM=; 
 b=Pl7NnQ7f6cs3y5EYjq1fEg/CXx0gr4aV38YIDDgU+vP6c3qI5wQfmRFFfLQJEBBXhiuOeHF0SLYj1o5BgP9gUIIq282rY//MRBddniEkKlOfbqyuBVBUV7rJrFemS9WMjZKp6IA3aW0uJa8Bo7DlQgqr/jLIfyhHK1lzU+C5pK8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:aa2af141-b093-41fa-83b3-f1de2e24844b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:d44ef219-ae4c-4a2b-b1c4-72e411efd0c9,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: de003ffae71b11f18dc8c9802ae25ab1-20261123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 974894043; Mon, 23 Nov 2026 16:57:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Nov 2026 16:57:08 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.53 via Frontend Transport; Mon, 23 Nov 2026 16:57:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8N3DtSBY/gh8z0uCGvFsWNn1/CBO8V1FEwZRCRRiVKbSr6gm6BIyjAvt4TE5ZHsLasvt2KvpmV5jvPh/ES6Y98MOfyfDM1stRjemFIab+nqL8uJ90hOIynlvBTTqzg2LEj0TcOkEVLfCXZ+NDcV0a7UC9lYyPbbonsCZDsc3EveftYYwS5Omb+0Ea1yMjUhlbsziqJBeTNArdse3wK/Owjh9BFPNQMkWY6sLm7DSqI8dFDUuHcUXB4WNd+3MrsvEQxVl6Mheuq7OtwEQMX3YgZhlcSLnfB2ci0oaIgmg9fjMvjAbyq9g46kwX4hCfMSqsb7hy/ihiHK8orswKJ+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr8PZqLtRKo4Bq8BzDB8RTsIpCquN+aMbdJ7khfi9uM=;
 b=RfYJ8qPg/OdX0/CTw4oWpDbHknortADA2vJuFiARMr/oRGwz3jjFYDsNXhEp+1Vf+EA6ChZxjwQLcsPwTd9dkFj1C3r8KExDA5qyoZ8jietIUW/K8Q8vdvHlznMVwQdGUzpR7aKE3ufa00WIrpFfEJQBu3AkR5RO/xWuZpNWgGWtD3KRhEJNeHwjjIb+Sne5yHhAQP8mCkhBvgZbYRqkGMf4+C3+Nx6c8kex3NorBvFrvqVj1OkwaKI5yTKt5tzhjMXhI92yT8FMBdkkiawb4x4pRMoEdpRwOv4r53bfz9mrCMMaMlFrhFOOno/sVOmtbMBL1KjqVZaSSu/og2QWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr8PZqLtRKo4Bq8BzDB8RTsIpCquN+aMbdJ7khfi9uM=;
 b=oaSMHjViLyORSEZ8RSbmaj0FSJ2a9kAzzobmnwy/Cen0gCHMrdB5Delhowaj8hs94giRlcY/xV6JCLgEBaKUegfTdWdBX028YzeDrRWv7K8gNITtlwTOoP4rx4HdzxSuQXj+KYi5mJbJY58HmnzyF51xM/DM9Fayr9R6rTSb14E=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE2PPF03708E4CD.apcprd03.prod.outlook.com (2603:1096:108:1::484)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:57:02 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:57:01 +0000
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
Subject: Re: [PATCH v2 39/46] drm/mediatek: Introduce MediaTek Asynchronous
 DirectLink Controller
Thread-Topic: [PATCH v2 39/46] drm/mediatek: Introduce MediaTek Asynchronous
 DirectLink Controller
Thread-Index: AQHdE4ZuT1H4fd1pXEGRj1gomcANULc8KiYA
Date: Mon, 23 Nov 2026 08:57:00 +0000
Message-ID: <138196f66aa9ddab653ae6398ecc1d3e51e9dcd2.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-40-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-40-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE2PPF03708E4CD:EE_
x-ms-office365-filtering-correlation-id: 1903303a-a1d2-43b9-2c49-08df493fbcda
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|42112799006|38070700021|10067099003|11063799006|5023799004|4143699003|56012099006|261021123027099003|261021121427099003|261026121527099003|261022075727099003|261009223027099003|261102123227099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: KVPa8RenKD52cVdirpb4XBcSTyxgTv8lzUYsY304CmP0M6U3dmc9mClGtjnVKmsTf/XS1D6rwl4+PnS1O6jJEQKRI0a8Tv6qXf/SU0l4IY/nR/5d51Ej6WaFdMA9Afol1eT5UA/nCtXVrBKB14Jov8nSaYKvqcIYebIQPeeFv/j/OGXgzUrkKCz9LU7nsli5UamJ2AHSzAY62U8LyPnGJz5xPv/2cng7B25QHfXzY14KfFjWrSRXJSajrCWS4cVwrtjqv8czCxcdxaSTKHIDJSjdGJ6GbxH7CJ6VtFSJkriCBAqWqnRMqy793BH9S38/gQvFtVn0bYAFQgmIIo7zjifsfKQqpOAgYMfmDc1ypmh+QGZiGYn11mXyUem9sFx8el9k8DOp8Q81Jsh7Rja9e1yFS1QN9BmuQtKgU3wzWJ0g9W6gM61JWoDyDasYFWgOEtE7ktRjqYIbyyQJipp2taQ2P0nrXIpCmwz+oxhkFGPQEOtQIbi80DFMEqQjkoaGOrhviCB5UsVmuQUnQBxhEKMce/j4qnkAegyjYgRX7MBIKLJ2YLBvQdBDlzInz+LhaAK5QwipNmv/gUXgWP0UtYEfCfCztLGU8nQscJFEeWBRqsic3xVtnV1150zC6yYPiQXwWticQMhXp0QnUw/IWAA2iGLarwR5ffu+l+6R6RIImoWBEwp+u6PsMVDn9qZa5o/ICHCVa7XYAChzF3fWKci2gRCAr0STgmYtV5mv8kc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(42112799006)(38070700021)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZldaVzllM3JTMVRCRVVTZEM4YTR2SlJVNi9XTmRvNVR6UXZCTlF3eEJQOTFh?=
 =?utf-8?B?S3Q4K2NxRVVOcjdnTkxVeXNHTkNlaHpZUHZjaHZvMkxzMkE3TkxOQnc0T0dj?=
 =?utf-8?B?cmJwbld6ck1lN1IvZENTczU1cWZpUmdtVjEvSUpEbG1ZWXBDRlRNK3BnRUNY?=
 =?utf-8?B?MTVBa3NRQTJNay92RFJSRG9NWWloTVovM3Q1L2I4SmcweS8rRkdIVllMclBP?=
 =?utf-8?B?YUtoN0dHb0dvV2pNMGNaV0V6RXhFVEhZdXJHNFk0UDM2VExZZUZKMnNIQXJq?=
 =?utf-8?B?ZzV4eW8vNGY1MnRZaXNucVRSLzFoVjFtWjhnRzU5NFhEeWsvT0E3VDZVejNk?=
 =?utf-8?B?RS9LS1RJOWJjVldodnZjaVczb1Q1MFJmdXVoRTNDZTV5SGF4M1RHWk5wNmdY?=
 =?utf-8?B?UGFxdGVZVHZpSk9ManFadjNBOTZ5RzNzUFN6TFNFT1JtZEE2M0dCVHlDcSsv?=
 =?utf-8?B?QW95bC9IbmxvNW9Qd2RiZGVlRENMdWZ6Y3oxTXBWYmR5Z09qREZUcjVlWk9P?=
 =?utf-8?B?M3dQYnBJcURuZWtYTVpCTHZ4eW5kT09yOU1LcDE1b0hySEJ2QTFIT0R4cjE0?=
 =?utf-8?B?WTArc1V6clNGZnRNdVk2Wm52bnhpbWVheHRKTXBud2s3dUlGWHAwOTd0SFZS?=
 =?utf-8?B?YStRbzl2NzNFNm9xa1ZHWHJBNnEwaGtaNE0zSXpML3lHV1E1bjhPblcrMHVW?=
 =?utf-8?B?TkV4N2Zoa2ZqRVlkcVdnbDl4SmdDZDVQaXBDNWdQeDVza3VFMFFCeEkwMDVR?=
 =?utf-8?B?WFJOMkhaSFUxOVp3SDU5bWo4RUlVbmo0N3FJVlVneXpxMEpQUUIyeExuUmQv?=
 =?utf-8?B?cUw3OUxIN0lML21OTkxjQXpSVlY0Q21KVU02MGRocVpHeFovQnVhR0lrRjZJ?=
 =?utf-8?B?cmxzU2ZOM1MwMTZFZjRFVmx1VmZreCszTWpCcUtJUWQ2dUZDOWV6Wk96cUhU?=
 =?utf-8?B?RjBLdFMzZjFKeElBSHQrWGM4eXEyZTR3a01oYThnZ3VuMUNvTHJINUI0UHR1?=
 =?utf-8?B?WUxFR3dWVXpsOEswNWVTNGVpblFGQkV1QStmZy8wNDdMRVFGSHF6WENPVUYv?=
 =?utf-8?B?YmpHbERCczBQeHcvK2VYdWNaSjRyU1F4SW5VZ1FGQlZwcWZxSlp0T0cvc2Vw?=
 =?utf-8?B?UmdXKzZqMzlQMTBzaEliYms0N0NlVURUc1AveUM1bm1VbDk1MkZldUNwV1ZM?=
 =?utf-8?B?Z0k0TGlWLzdSQ01HV1ZUUjNUSndqOWlJSVJGQmI5SUptRWR4ajNzSUh5ZTBL?=
 =?utf-8?B?dnhZUVArenFZYW5YUnFVMnpjblFmKyttbWszeG1sY3huZFFWdU40U08zNzhy?=
 =?utf-8?B?ZVFLZGE3OHUxVzBiYXlmb0VpOWQ3S3BQdlE4QTgzWkhpaVJCWEhwalFJRU03?=
 =?utf-8?B?ekM0dlJHVzc0eDFGUVZObWZ0TDZYZE1EWnA0ZHo3Qm8zMEFpZ3JCMkk5bmdQ?=
 =?utf-8?B?dlJnQmtLSHJPWXVtTUdLV2IxUGYyZitTbEw2MWlUckROYXpDMGMrcHErWVlv?=
 =?utf-8?B?MTdiOFhSaC9MMm1QelhPNjdHZldneEU2YzJyTlFhR1YvcGRFQ1BRZkZERlNS?=
 =?utf-8?B?RVZxVzBJVDNDQnhQYmVPSTUxa3JYUE44L2RadU9CQnpkVjh3T0NIY09BSnE3?=
 =?utf-8?B?cmN2SGNIYWp2WXoramFsTGZzc2EyQmc1S0E3dWt2RjZTdHhGSlhIZUNrYzJD?=
 =?utf-8?B?UGxTL3loMHBDSmdkTHVtdTJVTUtIRU5WU1ZXcjV6cWxGMURHTGZXQllGemxW?=
 =?utf-8?B?c3pHZEd3OE5RRHN6dUVyMzVtaVM3ckhvempVVTF0NXZ2RU9SQXJQNUIvaVEv?=
 =?utf-8?B?ZUI3VTcvRXc3YzgySnpFS0VjTDBtSmROcVRKMmxDRkE1VDh6ZTE2ekhlMzlR?=
 =?utf-8?B?ZVJ3cnZHZm12eVVicDM3R0tyTEV2TnliQVdCVE5DOWd3RUFoVzF1VXZ1dzZC?=
 =?utf-8?B?S21ndEoxQzNiSE1WMGRockVhUE13ZUkzYS94SWxIYlBOQzE4c0hGVmM0M09U?=
 =?utf-8?B?dFhoWGxhb0JLQ0Y3OEN3YXlzUlVuOHpadHc3WXBOQzFBSlFLR2RJVHd5eW0x?=
 =?utf-8?B?Nk1TZkJMb2hQdWFxZmNObDFZQTNFR2VsVER5V0VaNGpCQTEzSVhydzdqU2JW?=
 =?utf-8?B?bEtGb3I5RGcxRk84dnRHbk8yTUdsczFXQ3FPR3hkTHNxckFadGtVbk1XZVVQ?=
 =?utf-8?B?WmUrNVBNU3hRKy9UOFhsKzRaNnhra2UwYVBFeDJnQ2NOdFl4R1czY1RwL2Z0?=
 =?utf-8?B?RFVlL3ZqQjJsRUwzeFZBdWczaWRPN3dLaU1KZDlzRCtoZ3I1b2hKTXlhNlpQ?=
 =?utf-8?B?ZlRNOU9LNE1LSG9HQzFTOTBpWmt2cVZHZ1p0UFlGN0lnM0FvYUt0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <305A6F5B4D180A468A706390E9BBBBF2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lFDPnxGkGzD/CVPtXu0quLSv2mkuR2d44IYOgw26JBIFhop5SMVAyxQiVNN4LdhaUwAoKSjB+h8HkqIRtKXWM6zbKpqfZupRj4LsZmH4Ra00Ok1Iu+pByumCluOeplkYAfiIrpIrGLGMcEFsL5UwaIJUNXZo6M2oMp6UwMTRsaHNpzIXi+NKOfvvWxeGT/Q7tmOS0DXar2ECCUC+wBzn2dAiA/bXKf4IMzSWPfzlikVTzp0lySIgmFYZxJrlIRQ3sUkVvyTJH1sWQORWaHdn0AB0pCIlD6gTwDwfMliqPg3+j/1FDncl9Orwxo8BmVm+Iq9xclngY7NnA3kzAsM/wg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1903303a-a1d2-43b9-2c49-08df493fbcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 08:57:01.0042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvLl+WcY32ndyAvZ2Oo0AYwAfkshKOf4KRC5HgjD75NFdl3Qy8n69hfrPJ5BX3yVAUPOObite9eQcP7zkxrGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF03708E4CD
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

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQ0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBEaXNwbGF5IENvbnRy
b2xsZXIncyBBc3luY2hyb25vdXMNCj4gRGlyZWN0IExpbmsgQ29udHJvbGxlci4NCj4gDQo+IFRo
aXMgaXMgcmVzcG9uc2libGUgZm9yIG1hbmFnaW5nIGludGVybmFsIEkvTyBjb25uZWN0aW9ucyBi
ZXR3ZWVuDQo+IG11bHRpcGxlIGRpc3BsYXkgY29udHJvbGxlcnMgaW4gYSBsZWFkZXIgdG8gZm9s
bG93ZXIocykgdG9wb2xvZ3ksDQo+IGFkZGluZyB0aGUgYWJpbGl0eSB0byBlbmFibGUgZGF0YSBl
eGNoYW5nZSBiZXR3ZWVuIG11bHRpbWVkaWENCj4gcmVsYXRlZCBjb250cm9sbGVycyBhbmQgdGhl
IGRpc3BsYXkgY29udHJvbGxlcihzKSwgYW5kIGJldHdlZW4NCj4gbXVsdGlwbGUgZGlzcGxheSBj
b250cm9sbGVycywgZWZmZWN0aXZlbHkgY2hhbmdpbmcgdGhlIGhhcmR3YXJlDQo+IGNhcGFiaWxp
dGllcyBvZiBtdWx0aXBsZSBkaXNwbGF5IG91dHB1dCBwYXRocy4NCj4gDQo+IEZvciBleGFtcGxl
LCB0aGlzIGNvdWxkIGJlIHVzZWQgdG8gc3VwcG9ydCBtdWx0aXBsZSBvdXRwdXRzIHdpdGgNCj4g
bG93ZXIgcmVzb2x1dGlvbiBhbmQvb3IgY29sb3IgZGVwdGgsIG9yIHRvIHN1cHBvcnQgbGVzcyBv
dXRwdXRzDQo+IGJ1dCB3aXRoIGhpZ2ggcmVzb2x1dGlvbiBhbmQvb3IgY29sb3IgZGVwdGgsIHVw
IHRvIDhrNjAgaW4gc29tZQ0KPiBNZWRpYVRlayBTb0NzIGxpa2UgTVQ4MTk2Lg0KPiANCj4gTW9y
ZW92ZXIgcGxlYXNlIG5vdGUgdGhhdCwgb24gbmV3IGdlbmVyYXRpb24gU29DcywgKE1UODE5Niwg
TVQ4ODk0LA0KPiBNVDY5OTEsIE1UNjk5MywgZXRjKSwgdGhlIEFzeW5jaHJvbm91cyBEaXJlY3RM
aW5rIChETF9BU1lOQykgc3ViDQo+IGNvbXBvbmVudCBpcyByZXF1aXJlZCB0byBiZSBzZXQgdXAg
aW4gb3JkZXIgdG8gYWNoaWV2ZSBhbnkgZGlzcGxheQ0KPiBvdXRwdXQgYXQgYWxsIGFzLCBkaWZm
ZXJlbnRseSBmcm9tIHNsaWdodGx5IG9sZGVyIG9uZXMgKE1UODE5NSkNCj4gd2hlcmUgYSBkaXNw
bGF5IGNvbnRyb2xsZXIgcmVzZXQgcmVzdWx0ZWQgaW4gZGVmYXVsdCB2YWxpZCBvdXRwdXRzDQo+
IGJlaW5nIHNldCwgdGhlIG5ldyBvbmVzIGhhdmUgYSAibXV0ZWQiIGNvbmZpZ3VyYXRpb24gYnkg
ZGVmYXVsdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25p
cF0NCg0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RpcmVjdF9saW5r
X2RyaXZlcl9kdF9tYXRjaFtdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk2LWRpc3AtZGlyZWN0LWxpbmsiLCAuZGF0YSA9ICZtdDgxOTZfZGlzcF9kbF9hc3luY19kYXRh
IH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtb3ZsLWRpcmVjdC1saW5r
IiwgLmRhdGEgPSAmbXQ4MTk2X292bF9kbF9hc3luY19kYXRhIH0sDQoNCkFkZCBiaW5kaW5nIGRv
Y3VtZW50IGZvciAibWVkaWF0ZWssbXQ4MTk2LWRpc3AtZGlyZWN0LWxpbmsiIGFuZCAibWVkaWF0
ZWssbXQ4MTk2LW92bC1kaXJlY3QtbGluayIuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJeyAvKiBz
ZW50aW5lbCAqLyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2RpcmVj
dF9saW5rX2RyaXZlcl9kdF9tYXRjaCk7DQo+ICsNCg0K
