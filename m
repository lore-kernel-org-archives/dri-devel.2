Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B4C5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBCF88EBA;
	Thu, 27 Aug 2026 06:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="kvO7izTr";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XoS8KKMy";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399E088EBA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:24:01 +0000 (UTC)
X-UUID: e2d35db8a1df11f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=vVlLqEvLgvAgC+N0xxlIgII6ALfV1VgsCStarNRTgWk=; 
 b=kvO7izTr4y/ZnVD2Ly9KoX6yJMdvPxXevOL24zfKY7GJ1PT4T+yaEL+ZTleCXhRw1JF7DTOMVuOAPurxrKqlyyUkdEzX+TO8QyGN2DrmbfGSruhHny+nIcOmlIVgt8uH65emF1QRmxKeGRgJPID050DnaCtID1kbaAhoq0C1DWY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:93d62bb1-a7c7-4aac-8e15-324858b46b19, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:2b533c8e-8d83-4427-9f75-6d8f03c1a154,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2d35db8a1df11f18dc8c9802ae25ab1-20260827
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1379239661; Thu, 27 Aug 2026 14:23:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 14:23:56 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 14:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmusAzt3m+Zrvkp9+K08hYF1SZkGxqQwmjruk5kZNo0SJoooLMYJ+FvRPz56la1vHEnUarnfXYubj60bpy3mi8V6YcwI6Vw4VLhqFw+uAM92q4RCWUsZL/7eE/5hZyRVU4RZgTh9JWcGX/kWNR0A84LEUZ5C9DmMRMR+LgrxeyBbDSLwgOrmUzhGVRlKl52Qu82aB1ulM9pO6YTmalZ2ROwvXEgP/erS4e4TOgm8JcRh+dKmoloshAclIxUMMol1fXMQC1nBGskY6XDl/iVYR7JwV12xf0Z8L7nM+Rinnyg7xTjIUXjeF8oQMgLy0FNbX+l6Fn8puzhkceCVTQA/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVlLqEvLgvAgC+N0xxlIgII6ALfV1VgsCStarNRTgWk=;
 b=bRkxqcbnQIAeN71dAWg+fqsHEM4VAJJNqA+4QhABS0qbYRq1qiz/bEoaCaVwmfBKSkGG0PNOjmfU+thWrOnvIbtDgFfEKhXvapaEVNmb2c2sCvjfgvQ1OnrNuJ2YtibiiU4lViUjiYk2Mb6mzSVg36xyr37t3E5q2gO1MWiCJR1XoH3J61jwQ7Lg8Uju47ZljjfDCH51MVYB4yjVx4Bp6MeE5PRyJoLB6s0ZJNjmpUJRc85psS8+10k5RAYTPfby54a6OoJA4X7PwfcZ8RGZCAMl9HwqTuEBoysTsV0cNiqLf9MVZoQf6PNO/vyzQEEEWWEeKQxZPejD9MVRuiHL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVlLqEvLgvAgC+N0xxlIgII6ALfV1VgsCStarNRTgWk=;
 b=XoS8KKMyfO5mK/OwZoo0WdSAd+45J14ANIdFiUwxj0SwuISJnNhjTumpsaD7bJihSbhhAssj5Tl9DsXwnCn16AaYq/7b4knVoWt1+RLIH0bEhBJpbL3L2l7xdXAwzpsbZCmpvCADRhTUqrJYlEbU2nY25wo+PmiYuDus7YT1Iyc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUZPR03MB9733.apcprd03.prod.outlook.com (2603:1096:d10:61::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:23:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 06:23:53 +0000
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
Subject: Re: [PATCH v4 03/12] drm/mediatek: mtk_dp: Call pm_runtime_put_sync()
 in removal path
Thread-Topic: [PATCH v4 03/12] drm/mediatek: mtk_dp: Call
 pm_runtime_put_sync() in removal path
Thread-Index: AQHdD5atUy3TqKd/tUW+NpWHk+BE5baxuhWA
Date: Thu, 27 Aug 2026 06:23:53 +0000
Message-ID: <9d31a246332d6e79e80d169d1e2daab8c10d08c0.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-4-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUZPR03MB9733:EE_
x-ms-office365-filtering-correlation-id: de5bc03f-b121-479f-18ab-08df0403c48c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|42112799006|23010399003|366016|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: hl4/IX+2yv3vFJzw7gejGVXey+yNJ0WQVXfw0jGYDncV7oBhkIp3Dh0CyOLVMAn/4t/dNXUiKYScLkYhnPhrifsuUL4tB7nwE2fO24GLkQejQA43p7YW54PwH3lA5acN/KES1ALv4Ba49d5E/vrGEFAM5bYgqRTVWrLiQ963S5hyGOHKncbUAidpa1KKp/LiIZol/j82MPIkoqWpKSKnv21NEZRfzne12VIFAPhgJqXycOypJ5BbkzbTx5szUd1BlArsPhplRfy7maNlsuxZQSm5PgZVnDFxrAIZhvf/ncF+Y5Y1Q4s06t8RyAVWzGm78NpKf8NuoSBwIciRxBZOwFP6X4SUra10PpjT86MbvvPZhMW0YyVvB+w3XjQQxx2tKTsZS1W08FjWnNmY6B1XbpZcGI7ulVvPKbNQao4c0Scwh2GmU0Xz46XmskkWVcZTSF9KUhhBwd8d66ke4Yg+TGM2y92PGRLuEFrjjrHdLkMImKQ7UlFFvOD3UfqSoV3pXWLG+/ugTmoH+1Rj6KMwxrEisSsh2NqULAy3GBlKOBgIevtVWvp8m5TpPC4PNYoZyF5s1z5qyxeuP7XtObub9WET1q4hvyLKtQJAT1R5lvEmdqRpc5fUglLNeLyimuCtZOWgDvI6FE3atUND7+qZ3Vzt0g4RK9nIHPWvucdI/gS4QW508vXfHF4I/O6N6o8nDALwmYSvDYVKD3DIfaWc99qYQRHz0BQswMF8HxBLoyY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(42112799006)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2VGV1JySFRSVk9CUlo0RFQvaU9SOE95ZDdEcmE4dWVJR0pOT0YzaGRERm41?=
 =?utf-8?B?MEZCaXJxUklDL0F0L3hyVFVCLzdlWGU0RzRnTEFKVXhLNDRnYS9heWU3M2Rs?=
 =?utf-8?B?YTZNVENHeC9JWmR5dkFOUG1Pc3pMYmdqMVVhSUhvRXVKVUx3eFFjVEZPVW9o?=
 =?utf-8?B?djNYNkw5M2dxK1A1NnlCTCtRNE1RdUJBUkpDVk40ajNaR0dzSzVqUm5RUUpk?=
 =?utf-8?B?aU02ZlJCLytzWTJRR3NWQ01TQWVBNVF6Z29jTTdrVWUrMkZBMEt0RWZkRHBX?=
 =?utf-8?B?M3hJbnVhUzVRNXJVb2lQSE1iKzhjajRITTM5dXJiYUNJM0RLeGFwaWpLMmtJ?=
 =?utf-8?B?a1hwc0VvR0xTVmlhNjFmMzlEcURqOUw4dUhHdXRBakJKc2tqUitCNTdSMkZL?=
 =?utf-8?B?SzR3ZmhXbWFpNHFIMGF0ZWZVV1FHU2NudTc4cU9RTmUrN3pOMjY0Vm5WZTcy?=
 =?utf-8?B?bnk4WGFMUUc1QStFSTZNb0N1aDlBOXlMcFRTMFByZjFOVjVZTGkvRlI5dE5u?=
 =?utf-8?B?d2VuQWRsampPaTlJUEI2QTlRTkY4cWVuc21ZNGExWUVZeEtuWVh5MG1lQTF3?=
 =?utf-8?B?amMrTXhPZVR4TUxMVWRFWmRTVjBNMnNEYjViTWF1OWJ3dHZZWm02ak9KNkpO?=
 =?utf-8?B?SGs5OFY0MmVRVFhJQnlVMkpNRHQyODdLN1ArSmZ1QUZWampuV2lkMEtWWnow?=
 =?utf-8?B?MDY1NEE2bXpaZDhQY095YkRSWURsZlFlSHFZQTllZlE4dzRsQkM2YXhhNWoy?=
 =?utf-8?B?V3M1NE5xYlVWYWliZWNnNjgyNzZ1djIyRU5USUFnQTN6TG9NQVlzOTN4VmFZ?=
 =?utf-8?B?ZUtDaWJIMUtJUEV1VVZjYjRFdmdoTkNtOGFCLzQ1UUhEZkFHT2dBOXVuS2FO?=
 =?utf-8?B?SmYxUVoxemFuY21zdG1uck13R1V4Rk15UGxaVVphWmVUV2Iva2l5Y2ZKdEhu?=
 =?utf-8?B?WENncS9MdTA0WkZYdW1JNjVUcEF2UFdUTDU0dFRISzc3Z1lkL3dQL25Xb2s3?=
 =?utf-8?B?bHdSQjZhaEFXM2dmTlRqU1NiS2hvVEs5aG9zNFZEczhLelltdTAzbjlUZzd6?=
 =?utf-8?B?bmdWOXRLSWZvYTQzNUs4VEdEWFRXQTdHa3ZxYVVCTm8yaEk1V0ZnNzRRQ005?=
 =?utf-8?B?VDAybG9aQWY2anluTHEwNnRJWngzbG9YNnNqcFQvcUlnWks2cCtWdk10aU9s?=
 =?utf-8?B?V1BwNDh5WkdlZkhkU1hNV00rNkI3eEwvemxXMWQvSG1pVkYvK0tXMTgwQVV1?=
 =?utf-8?B?c3h1ZEdnajBjNDVrZnpMMHliZURnam4rTnFJOXRWU29nVjkzU3AyT3E5elJ5?=
 =?utf-8?B?RVozSVNtV3BpWUp1LzIwTU9wdmxpUmxmRklUdVdFRUxpVmRUSzB2akkzNFBV?=
 =?utf-8?B?YzFpN2FKeFhxTnJ4dWhIOGpqNld1UysvY3NIUk9SUGl5RllBRFpKZWhESkc4?=
 =?utf-8?B?aWhVdkdHZVFVTi83L2ExakRCdHJLazYydks3VEtlb2hDcmxqVFVOeFBxbm1i?=
 =?utf-8?B?YUVoampaMUFZLzNCUnNrd0VoQStZOUhnUTlOdVpOaVhmeGJlQ0xldm9xQ3F0?=
 =?utf-8?B?YlZyN0pIdllRa2pmeVJMemhGL2RIeGVJYnhuOEMvUzJSYWRTMy9nUFg3ZnlV?=
 =?utf-8?B?Undvb05xSjkvN01pNFRPdnU2b0JXQ0ovV05pSGlVcC9vaStjMDFRVGFCQzJE?=
 =?utf-8?B?QU0vQUtHQVEyOWJ2Y3RCRTZ0TUFnUnVNaDRTMmtlZGE5M09MQ2tTbGF4OFhO?=
 =?utf-8?B?Rnk0OGdPVUtEK2lLWTJIQlVpdExLUitBdE4vdTRCRktaMVQ0Qk95bFZGbWFt?=
 =?utf-8?B?VzBQNnBBSHA0VnpPUHgxZUFlK1piQ0FiOFljRG5ZT1VmV3Y4N1IwdDI3Qllx?=
 =?utf-8?B?aFhPSDlJNnZuSmEwVnk5S0dtV25ySU02N0krY3RmdDRtRzU5eUtEazU3aWlP?=
 =?utf-8?B?Y0lIYkxhakltL21nbDlPNzJ5VGU0KzVLL1hwQVBiR3pMYnk1R1NqOEpuQ3BO?=
 =?utf-8?B?Zm4zTzNROWhZOFduZnM4ZkM0akNyQWVPUFpvcWZrRG8yVlpFZkluK1Rlbzlx?=
 =?utf-8?B?VDVjV05hV0hvaTVhaHJDQmg0bVVQMHRsbTljazdLUmxjeEo4UnZTVW0xOTBO?=
 =?utf-8?B?RlN2bGtQQUF5TU9rZnRrYTdGUnJiZkp2TURVclRrVHJzR2U1b25aOXJpeDBV?=
 =?utf-8?B?cDNiN1k3QlhDWnYzWmZmQzhPd3JUZ2tqVGJUTlEzbDR0Y0lIQWlPYkJrQTFs?=
 =?utf-8?B?T1kxRllmMEh3MDlwQlUxczZxY0dkVTZ5NklYemtLSHp5UG1JMC82OTMvWEM4?=
 =?utf-8?B?c2VIUzVjZDhZWDVSeDkxbkVCUmVEV01HS000cHpJZ2VlYnB2RG5tZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14EFD39884C23D4F9B91136FC96C4FAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xv2dONj+6Lg9cO/10pF1MnLvLq9fFTGPsZi6Qa7HqUV4Wg2VFPqHtUf4Lz5PGWPK2AoUQfp3mB4FyU2FXYVsaVd/CgaY2LsiGl2a7EAORTHqkkrZPraVccXfoz8fm5ZbqZ9mINJi7213KqMP+sU31cqtrEnsUG4d5fZG8xXA34u8F/rrlHjxFKVbex2DHIIV6kj/iVim2N2SDy5rug2cBAC7YaAv10/vsRfZKMxaqhXZne5T/jxb922c2w7NIH1yVTgPgLNUdYMR/fLKpTS4Fv9p/tjn/ube3+PZ78u6hygwD8lawCNkWVC2zhOVpEzLGC1MiQWv/HpSXQNWS7/FGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5bc03f-b121-479f-18ab-08df0403c48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 06:23:53.8534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxpQoYaoy2sKTBWTkzAkX7E4ik6iyx7ixHK8X3v3tsswSSk8VPxIkGG3nUR47M3TfpT/KBlt8iP23eZLTaeEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9733
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
ZWdubyB3cm90ZToNCj4gU2luY2UgcG1fcnVudGltZV9wdXQoKSBxdWV1ZXMgYW4gYXN5bmNocm9u
b3VzIHN1c3BlbmQsIGNhbGxpbmcNCj4gcG1fcnVudGltZV9kaXNhYmxlKCkgcmlnaHQgYWZ0ZXIg
d2lsbCBjYW5jZWwgdGhlIHBlbmRpbmcgc3VzcGVuZA0KPiB3b3JrLg0KPiANCj4gQ2FsbCBwbV9y
dW50aW1lX3B1dF9zeW5jKCkgaW5zdGVhZCBkdXJpbmcgbXRrX2RwX3JlbW92ZSgpIHRvDQo+IG92
ZXJjb21lIHRvIHRoaXMgaXNzdWUsIG1ha2luZyBzdXJlIHRoYXQgdGhlIHN1c3BlbmQgb3BzIGV4
ZWN1dGUNCj4gYW5kIHRoYXQgdGhlIGhhcmR3YXJlIGNvcnJlY3RseSBwb3dlcnMgb2ZmIGJlZm9y
ZSBtb2R1bGUgdW5sb2FkLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NCg0KPiANCj4gRml4ZXM6IGY3MGFjMDk3YTJjZiAoImRybS9tZWRpYXRlazogQWRkIE1UODE5
NSBFbWJlZGRlZCBEaXNwbGF5UG9ydCBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiAtLS0NCg==
