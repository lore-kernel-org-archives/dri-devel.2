Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78263606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=XzYMB7wD;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=ke8aQPRa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E09B10E258;
	Mon,  9 Nov 2026 06:40:04 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7230910E258
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:39:52 +0000 (UTC)
X-UUID: 5aea40f2dc0811f1b1788b6acf885367-20261109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=DA0zdyRbiIWQrEWXvg6GCX4hQ4YGjenFgp9uqUNMqVQ=; 
 b=XzYMB7wDA5K9prSD2Ih/lw58dqFqtFEnTsANVh+nxnnnJLt3WfYPWDzBV/5n8Eyak7z+YcqwrUI7scMLpI2ugQn2jgb6LyuewODf2P5baSSR/F1BbHP55tvWuj+Bo1kRlC+kmDHW8PiPQ9ZUcX4Nt7xy8TUIgpfLeDFQUW6sC7o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:bbfc5810-193d-443e-a24b-a807942e14c2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:ac367d8d-b3e7-4795-ae33-b1b4d51e21d7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5aea40f2dc0811f1b1788b6acf885367-20261109
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1599341684; Mon, 09 Nov 2026 14:39:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Nov 2026 14:39:45 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Nov 2026 14:39:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGUqgZD4o565/SJNxO67KI4KV+KQoyukhYaCKvLUHgW3jAf48+3PARb85EVXov8lhfI7adhy9gChx2QxKoe6fo2N/qqwy/FT8ViwKTohrXi5RQVeLfo2iqTvj2135DrHrFxN5vi8dVmmvqxrVLWwNGpZF61JElXH4wVYKRC2LbnVU9g+ValGTvh3QHntmYC/gcNG728mY6CpxYJFTh/eI3HG2MR/kIGtNsUu1UHU3nBdHZuoifA7T3l7js9JQBOtMCA37t1KdPpby7IIJJca3tE3Ytj74ast7ePGA0122YXfBvQPR+p5QC7vuIGgc+dUMX93rFSxeQ3Lzp9KbMI1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA0zdyRbiIWQrEWXvg6GCX4hQ4YGjenFgp9uqUNMqVQ=;
 b=h5/VNITqbhQJvUWoSyHxAuJFfdq09LIuP3k6u0xsceOFLFsI+465bCLAAHWAOcdUjmV4YP8zzPd+l0Z+9tzg6RD136XdhhGsU2dpAZDQn110oqokFfdTXdEyijCS+GgdOrXtF9STYDoICX8XFKd02Pca1fpkyidTFFEPLF2Xv9+La7SYMXo1mT8Kc74YJIG/OkM+Nre6XGRCskmgXYBxZ8iZORbvwi7RobyaXWrhi3JhYRcaSoDqePcisvvmwIJcT5/ZsnUCHC29QusyOfgTk1hPSwB7KGb3VEhQMHR07HX7Uu5pHxk7J4gx15TtSR0E5H2R4NCnzcdYP3ODabVE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA0zdyRbiIWQrEWXvg6GCX4hQ4YGjenFgp9uqUNMqVQ=;
 b=ke8aQPRaBEQhoHaD2PIEE5PDAFbQdJHBdafWrUJliHexGN6vpoTUJTdz/CNVQ33VJt1MuLWxHkRssC+vF73+wFQ/hgYh1OPp9NYN8Hit9q4ijY/eOg2ZBOINN6gZWfTL5US8Nb0CX6tqyfNw/LCNAwSkyP8uyfkUmpZl7zlHzIU=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYZPR03MB9574.apcprd03.prod.outlook.com (2603:1096:405:399::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:39:42 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 06:39:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "agentzoan@gmail.com"
 <agentzoan@gmail.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
 <Nancy.Lin@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/mediatek: mtk_crtc: Pick the connector route on
 every CRTC enable
Thread-Topic: [PATCH 3/3] drm/mediatek: mtk_crtc: Pick the connector route on
 every CRTC enable
Thread-Index: AQHdWRmWSndTB6Oa2UqgMGTqAR6PM7cld/+A
Date: Mon, 9 Nov 2026 06:39:41 +0000
Message-ID: <ee8ef5532faac8aaa137d6e947037e79575e6a6f.camel@mediatek.com>
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-4-agentzoan@gmail.com>
In-Reply-To: <20261011004248.1117649-4-agentzoan@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYZPR03MB9574:EE_
x-ms-office365-filtering-correlation-id: 5ed8af18-abdf-4172-918e-08df3e2c3c46
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|7416014|23010399003|376014|22082099003|18002099003|10067099003|3023799007|38070700021|4143699003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info: Yc1jWwRo6nTvRPnri8DaKMeuHArrMo2anftVTBKATeDtVU+uD92PChjjXfg2WxNEZkxqOYubp2RYj/Qv2TPZonFjm82ciL1X5tr1TiUo57NSFSexSNLtmgEbC6QuW18cBJAu921vqW4TGwYUHSg1WcmKZzJeHCJMjPYt2N0zugYW2sCg99gwfyTpMdl3Vr7TyB9/2ll+/vUDojuM61qJTk8xNCZJLaCpIY3jYUuu29J+eyQy0T7PncWvIW4U5OUg50yaoCqW2sdNqPlACXm4+GMxyxVoSoSQNkoST5eCRivQT5mU8acADtrtFPolSdzpeJd4xOWisHU4l0d7me0YeoIAdSgAu4jQIONZMRz3hMquVhCGwFDJeXXtc46gZRowVRjiwtnQnPRmQu320LZKyEJXmKA7uM03eaVPhZRlEQyByXFxFnPDGuxLNQWoRVRiqag7QZAihVYj9ZrsDB8qnp+A1yjmqEf+OLnEFGB4FcnpHF3119rPZDwyOTM1p5Pt62m6BdHwQ7F+adQ28PoMzAsd0QzehaMDXcQ0BqLtqGZUj/SKXLd62tn1X4pat9MPlAiLb4xQI/rIyeqPtu5iPT/36oc7UN+S1A1KWewMe8iudJMfThIHtKNmL3zRlmWPIqrhVQ25DihwJjGBKY885ajv9npgbrWqaGhN4067TW9Sa00dUNx8SXGKFn9Qcm/il2ephwXGp/20j/CN/X9KCaV/V85Zd1m5YzSWGRw5Arw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(38070700021)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUUxVlRzRGVoK2ljQVJueUpOSC9pYVI2TmJsMkhRM0oyUC9GVHNtSHBIYkRm?=
 =?utf-8?B?REkzdmE5QXVvWVhXMVgrK25YRFFJRjF2N2Q3L0FpUjUvL0xPQngreWV5dEth?=
 =?utf-8?B?UGpTTTVpWWw3OFp0Vm5IRG5hSGc4clhncDVIQ3J1VUtxTzFLRGpycXBUb1pl?=
 =?utf-8?B?bDJ5aG14Vys5L3dMQUlnM015Z1g3RjNtcEJHdDBvSHFOemRuTTRTUDJoSHZS?=
 =?utf-8?B?TjYxU09hdU54RUhaYWpEUS9oZ3FqaGd1cllzN2JXanRXcytQTmtBUjlOWjV3?=
 =?utf-8?B?TFdqM2l0ZVl0WGtpcHljdEtpTWdpYkpZOGFpWndwRTg4bERnNFhjMSsrSExD?=
 =?utf-8?B?YkNmVU1oSFVWMmlTZnM2QXpXM3N3SUZxNlBDRVFxZzhGRk5vYlZBcGdpRkRS?=
 =?utf-8?B?SXZIQm9XRjY2bFVXMXRSZi93SHNwRW1iRmdaWEUxM0p3U0RENGJpekNzcVNG?=
 =?utf-8?B?a3JEZmtpV2xZNEMrRE1QS3k0UFhTclNiTU9KVlExVkhlU2JCbHBlNGQyVW1F?=
 =?utf-8?B?TncvdzFTU2RmeUpBQUtGdGtaUDl6LzZENjlDanZwWHVTdVJqOGdZaThKRzJa?=
 =?utf-8?B?UnVtTDFvTHM1WEFyZUs1WXZvd2U0WE9XbXRpN2Q0WkhaQnpUVkFORnpBbHNI?=
 =?utf-8?B?UUlNcEJHOHovYXg0U2VqbVdJZE50VDJselBsRDYwcVE1WFFpZi9renJTUm9V?=
 =?utf-8?B?ZS9HR094TTdLampMcllyR2IrRUpxMzZqTHJ6R3FRM2JkbkFLbWdDY2pCYURl?=
 =?utf-8?B?ZkdaR05CbG1IeXlsYlRjRG1yM3E4dzl2RUtiRC9vVS9RcHBpNVdOYkQ3TGRC?=
 =?utf-8?B?Qno4K3Flak5kaG54Zkl3ZUxhcnRtZVRVaHc0MWZMdlNDTG1sdUJ1b0hzYW9i?=
 =?utf-8?B?YUR6VnVNMTJpM1F2ejEyclZCWklDdVVLOWdnRmNwaHdzc3liZndVT1NLTHZt?=
 =?utf-8?B?L2tUNFRKRGFTWVBJcnBzZ0xtS0RVSUlVbGR2cFlGNzdwQnhvRitUY1ZJQ01p?=
 =?utf-8?B?alJRUTZYUjJqUE91SUhzT0JrOXRjTXg2eUpGeTNqTDd3ZjlKWDVHVzFWekh4?=
 =?utf-8?B?bHErZ2hJcVhUWXAyeE1tbDUycUdrWGlmRWRpY2xiY0xQQ0QrVjF6SjNvTVlE?=
 =?utf-8?B?bXlPcnNlelh3NmNOaW1UMnp0NldKQlE0MnI2WUkzaElRZ2VaMzkyWnVyM1RO?=
 =?utf-8?B?SmFqeFV5cW9ZYnN6WkhCNGRtUUhkL082NWYxNTNGdWd1bkx3Mnp4dEkwTDNp?=
 =?utf-8?B?SjNacndsdllhNzA2ZEU4TVJuMTc4bEhzNzRXTjFETFpqeFpiRG1JRDFwWmht?=
 =?utf-8?B?WEF2aVNOdTlmbVdXZzRuY0VORmMvMCtuNGNDeENvaVFWU0l1OStWekl5czlm?=
 =?utf-8?B?ZkVPVGZ0Yk9WR3dHc2g5UElwV1BxazNlU1pBd3BTMStubDhadjZ2SkxHc2hP?=
 =?utf-8?B?Y01oVFJ4NURQSHJMN0FLbG10b21Ec1ZSbnlaQzF2aDE3elhSU2hBUXZPUWpC?=
 =?utf-8?B?bFNGdDlXT0c0Z051emdXUEpRR24rZ0VmRFMzdkNRWW5XWTA2SkQyWUV0WnVm?=
 =?utf-8?B?dzh0L0dLcFl5YnFmK1c5S2xXTUNTMURyRHVLYUQvV2ErUWVmd2Q0R09tVWNE?=
 =?utf-8?B?azBqaDVseFRQNWs5allwcnVpTERFd3IreHpGZ0xLTU5yTHRCNVdlTlFULy9H?=
 =?utf-8?B?VHh1emJjZmJvbDF5OTQyN3ZEWHlvOC9OWE1FZkZEUmg4dXpnV01JRkxleDVD?=
 =?utf-8?B?dlFIWFp6OGlXbk9ZakNGL2xZQVRlTk9aTWxCYnVUMHZJV1RvaDBKd0FaT3pC?=
 =?utf-8?B?WCs3bHpMUUJ3Q1RTVFNBRldkS2RSVlJzblM4VUFwU2hMMk5KclFnUzhWNmhw?=
 =?utf-8?B?WFhKMnJpOFoyTGJoUUs4STBOVyt5ZEYyQlNxUlpKaVd1UnRWbW9ENjlLTXd3?=
 =?utf-8?B?UytmdTR3bE1aTWorcGZLMEt3d3MrSXZ0a1pnRkt5UDAxSDRueTdxYm9RUnFJ?=
 =?utf-8?B?TnlxcDBvdzRWbEtGTGFzenFlaVNmR1hNM0ZHT1pPTVFEcEhGam9UL1Z6d1My?=
 =?utf-8?B?dk9EeTZQMTZ5L3BESHRNdm9VUlp4RktiTUlqR1pjVzJyenJRVWtMd1VxUDJs?=
 =?utf-8?B?TC9Cdk44Qzc3UHZNVDU2YTU2aGQ4Rm5rSy8xenJuNFpOcFN6a0pUMlRTNEcx?=
 =?utf-8?B?allkeU44eEVMRk1kMUVCNlNzK08wMDE4ZHROWDlUK1FRcHFMYjNjNjBUSmJw?=
 =?utf-8?B?ZFFjWnVCeVN1d2tndjhGRFZ6eS9BYkx6TXJPbk5jbTNTenpuTHR3eVVSSy84?=
 =?utf-8?B?Sm5GOExCRy8rN01TOEhQN3pINnRSd1FzRUtBVFJCR09lNWJrSU0zUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA476603AE1F84BBD7D679B34852AF3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wXX4WmWVPl8NA4MlShvdnuqt+SLZgBynnPMg9BCdLxye84YzZNGamQe+4yaN7prHXucxkHQG/60F8U9P6zxVyoG9TrTVKW7b6b2+5i+MEQt0kuUk1Gpzs0BK5m9XEldzolfSG44rclg1cmr+PNPJwX1jLQ4d9YRNVXnrmWvN6H30nffxZI4fnqglgSgbHDyzVbaM792cPhSaPnWkpHMUj0VhDayRgfBfEy0W99HoKfzpx302YDU1sN5JZXvzkfvnL5TESkUJFTg6iktxMNWo7BEeTahrJZG46tZwdSCa6dCOqoc884FqRxR6Qw/8pqIEghUkeZEWUSTuu2CpmkiZyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8af18-abdf-4172-918e-08df3e2c3c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 06:39:42.0008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSqTV1TuigsvHT4rMTO3KBuvt5HLo1WaHyqAW01nPk3A8SHxGV13tjY06UCfwBKmifSnVE1mpQ1V3/OUlji5sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB9574
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

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDIwOjQyIC0wNDAwLCB6b2FuMzcgd3JvdGU6DQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0K
PiANCj4gbXRrX2NydGNfdXBkYXRlX291dHB1dCgpIG9ubHkgcGlja3MgdGhlIG91dHB1dCBjb21w
b25lbnQgb2YgYSBDUlRDDQo+IHdpdGggY29ubmVjdG9yIHJvdXRlcyB3aGVuIGNvbm5lY3RvcnNf
Y2hhbmdlZCBpcyBzZXQgaW4gdGhlIGNvbW1pdCB0aGF0DQo+IGVuYWJsZXMgdGhlIENSVEMuIEJ1
dCBjb25uZWN0b3JzX2NoYW5nZWQgb25seSBzYXlzIHRoYXQgdGhlIGNvbm5lY3RvcnMNCj4gY2hh
bmdlZCBpbiB0aGF0IGNvbW1pdCwgbm90IHNpbmNlIHRoZSBDUlRDIHdhcyBsYXN0IGVuYWJsZWQu
IEEgY29ubmVjdG9yDQo+IGNhbiBiZSBhdHRhY2hlZCB0byAob3IgbW92ZWQgdG8pIHRoZSBDUlRD
IHdoaWxlIGl0IGlzIGluYWN0aXZlLCBhbmQgdGhlDQo+IGxhdGVyIGNvbW1pdCB0aGF0IG9ubHkg
c2V0cyBBQ1RJVkUgdGhlbiBoYXMgYWN0aXZlX2NoYW5nZWQgYnV0IG5vdA0KPiBjb25uZWN0b3Jz
X2NoYW5nZWQ6DQo+IA0KPiAtIElmIHRoZSBDUlRDIGhhZCBuZXZlciBiZWVuIGVuYWJsZWQsIHRo
ZSByb3V0ZSBzbG90IGlzIHN0aWxsIE5VTEwgYW5kDQo+ICAgbXRrX2NydGNfZGRwX2h3X2luaXQo
KSBkZXJlZmVyZW5jZXMgaXQgKG10a19kZHBfY29tcF9jbGtfZW5hYmxlKCkNCj4gICBhbmQgc28g
b24pLg0KPiAtIElmIHRoZSBDUlRDIHdhcyBkcml2ZW4gdGhyb3VnaCBhbm90aGVyIHJvdXRlIGJl
Zm9yZSwgZS5nLiBhIENSVEMNCj4gICBzaGFyZWQgYnkgYW4gSERNSSBicmlkZ2Ugb24gRFNJIGFu
ZCBhIERpc3BsYXlQb3J0IG91dHB1dCB0aGF0IGlzDQo+ICAgc3dpdGNoZWQgb2ZmIChEUE1TKSB3
aGlsZSB0aGUgbW9uaXRvciBtb3ZlcyBmcm9tIG9uZSB0byB0aGUgb3RoZXIsDQo+ICAgdGhlIHBp
cGVsaW5lIGlzIHNldCB1cCBmb3IgdGhlIG9sZCBvdXRwdXQuDQo+IA0KPiB1cGRhdGVfb3V0cHV0
KCkgb25seSBydW5zIGZyb20gYXRvbWljX2VuYWJsZSBhbmQgdGhlIGxvb2t1cCBpcyBhIHNob3J0
DQo+IGxvb3Agb3ZlciB0aGUgcm91dGVzLCBzbyBkbyBpdCBvbiBldmVyeSBlbmFibGUuDQo+IA0K
PiBGaXhlczogMDEzODliMzI0Yzk3ICgiZHJtL21lZGlhdGVrOiBBZGQgY29ubmVjdG9yIGR5bmFt
aWMgc2VsZWN0aW9uIGNhcGFiaWxpdHkiKQ0KPiBBc3Npc3RlZC1ieTogTExNDQo+IFNpZ25lZC1v
ZmYtYnk6IHpvYW4zNyA8YWdlbnR6b2FuQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBOb3RlczoN
Cj4gICAgIFRlc3Rpbmc6IGZvdW5kIGJ5IHJlYWRpbmcgdGhlIGNvZGUuIFRoZSBzYW1lIGNoYW5n
ZSBydW5zIG9uIHRoZSBNVDgxODkNCj4gICAgIENocm9tZWJvb2sgZGVzY3JpYmVkIGluIHBhdGNo
IDEsIHdoZXJlIG9uZSByb3V0ZWQgQ1JUQyBkcml2ZXMgZWl0aGVyDQo+ICAgICBIRE1JIG9yIFVT
Qi1DIERpc3BsYXlQb3J0OiBEUE1TIG9mZi9vbiBhbmQgc3VzcGVuZC9yZXN1bWUgd2l0aCBhIERQ
DQo+ICAgICBtb25pdG9yIGF0dGFjaGVkIGNvbWUgYmFjay4gVGhlIHNlcXVlbmNlIHRoYXQgZmFp
bHMgd2l0aG91dCBpdA0KPiAgICAgKGNvbm5lY3RvciBhdHRhY2hlZCBvciBzd2FwcGVkIHdoaWxl
IHRoZSBDUlRDIGlzIGluYWN0aXZlLCB0aGVuIG9ubHkNCj4gICAgIEFDVElWRSBzZXQpIHdhcyBu
b3QgcmVwcm9kdWNlZCBvbiBwdXJwb3NlLiBDb21waWxlLXRlc3RlZCAoVz0xKSBvbg0KPiAgICAg
bmV4dC0yMDI2MTAwOC4NCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMu
YyB8IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGluZGV4IDcwNDkzMWIzNjliNi4uMGJmZDE3ZjY4
MjgyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBAQCAtNjk1LDkg
KzY5NSw2IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX3VwZGF0ZV9vdXRwdXQoc3RydWN0IGRybV9j
cnRjICpjcnRjLA0KPiAgICAgICAgIHN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXY7DQo+ICAg
ICAgICAgdW5zaWduZWQgaW50IGVuY29kZXJfbWFzayA9IGNydGNfc3RhdGUtPmVuY29kZXJfbWFz
azsNCj4gDQo+IC0gICAgICAgaWYgKCFjcnRjX3N0YXRlLT5jb25uZWN0b3JzX2NoYW5nZWQpDQo+
IC0gICAgICAgICAgICAgICByZXR1cm47DQo+IC0NCg0KQWdyZWUgdGhpcyBtb2RpZmljYXRpb24s
IGJ1dCBiZWxvdyBkZWJfZGJnKCkgYWJvdXQgY29ubmVjdG9yc19jaGFuZ2VkIHNob3VsZCBhbHNv
IHJlbW92ZWQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAgICAgICAgaWYgKCFtdGtfY3J0Yy0+bnVt
X2Nvbm5fcm91dGVzKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gLS0NCj4gMi40
My4wDQo+IA0KDQo=
