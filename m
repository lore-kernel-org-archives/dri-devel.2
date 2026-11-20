Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A9606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=bETgjiPs;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=f/p9CbZe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65E310E159;
	Fri, 20 Nov 2026 07:42:57 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA0710E2A9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:42:46 +0000 (UTC)
X-UUID: f76a76d0e4b511f18dc8c9802ae25ab1-20261120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=3REjViTQP+iT+mKAu4FHnGRcQjdI/fsiwYCzcC70dpc=; 
 b=bETgjiPsPjxnqcVBKqvFBv/Drqe/ASPjt9VBg7OOgepPbmwtjd8yRDGRRTgmXRmcgdl+NSTXw6CwPgreNitxo08Oub9ZULAC3vfYHziBcmI/ebHMsKSnw7IdNcjECDrOmETflJ3CIdloc8Hfxt2E+XDIM3oC7NxdE7PWVDttbOc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:9bed4555-7b4b-4c42-a48d-66b5816b89b4, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:027850c1-9366-4dc0-bd34-c7a549614a11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f76a76d0e4b511f18dc8c9802ae25ab1-20261120
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 830675036; Fri, 20 Nov 2026 15:42:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 20 Nov 2026 15:42:40 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 20 Nov 2026 15:42:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNZgN0tGWepRJbnVJ/EflydQbxkeInIbZcyqB0Q/qeRsJfDJ+/TaODW/57mTmdj2XpLUlSfUiNe+2nrkvVX7vL3pyoCOxtM4KQfF7lVhXTuphILuPLRsHfC1udl9dA8Oq0kiJfzEUD8vedp5ERz8gxzqbrJZ4QKkQA+bFIZuJkwrjVijgXKKUxnn4khEP7wj2T1Q1jCqa5AH+BnbXR6MH/VrGTiOo3dZeGCGMeuumyJHjt0gGiSpffQgJR62uFPCmgnL5A91mjvEBAJUzso1uT+xeg1yIXL5mVTRWs3HRmmLhlkxLaiG3XOd9XiwaMW9tjUqtwxKNGxUNFe60P2Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3REjViTQP+iT+mKAu4FHnGRcQjdI/fsiwYCzcC70dpc=;
 b=EokHrnAFz/7uQ7bifpTlJxvSH7isYRVdDxWyzwT5n9Nif6OYAjj3AjsmNyMqoQgR4/M2jwjIXwso3Vz/HLNdw/pWLiSjdGfZ87BiUgbDDN/lQtjoOxiUqMlEcokr6HXa3PyQE+swhKBiTbc/oIm+Y4dv/8dmz95aAuYzEgqe2200HOQk/IGfmw1DrhHWpgAYTaGm0dj+/wqiKkgiGSuVazltV+KCpoKtiGS1w20Bd8TOs7ECN4ki10IGbeVY6VSblOqunrWL/l6SB195wZ5uIPqp8zAs8Sm63JHHVt3fLmhwV6mna4FxV+1AUbsCOQ8XgEKrIlwDSaSb/6uT3uGVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3REjViTQP+iT+mKAu4FHnGRcQjdI/fsiwYCzcC70dpc=;
 b=f/p9CbZeq7Q+FXygTK6Ce95wlLrY7wNCYE7t3MU/mJn/s5da3Tv10Fej5+xX5YEfoSNuP3BfXbeifcVfJQsuDTXb9LLsc8npYB+2bwAfdYBYdv40X/xfbhqFWkisGwNAMHLh1FBRmRY10IQUvbVdkxwJoqiZrry7lVvPH+TZquw=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TY0PR03MB8176.apcprd03.prod.outlook.com (2603:1096:405:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:42:36 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:42:36 +0000
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
Subject: Re: [PATCH v2 28/46] drm/mediatek: Add support for MediaTek Digital
 Video Output (DVO)
Thread-Topic: [PATCH v2 28/46] drm/mediatek: Add support for MediaTek Digital
 Video Output (DVO)
Thread-Index: AQHdE4ZYdxM0OLyWS0qa9C/bi88FAbc3Xl4A
Date: Fri, 20 Nov 2026 07:42:36 +0000
Message-ID: <b7b4c2bf61a88b533e504603c4dcbc79c1de6f06.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-29-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-29-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TY0PR03MB8176:EE_
x-ms-office365-filtering-correlation-id: edb063f6-2b01-46e8-0c6e-08df46d9d880
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|23010399003|366016|38070700021|4143699003|11063799006|261009223027099003|261021123027099003|10067099003|261021121427099003|261102123227099003|261022105027099003|56012099006|261028144727099003|261022075727099003|261026140227099003|261026121527099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: BkcjYMTBKVk00BsttxG79JdFRSdgtsIXpG8bdulAxeNx8uKfVhcazVEnpLRkcC/m82Gid3YKHrLc9Nje15YKQMhiKTa07Tfyo8ubiQlVhc47mce74DT8Ft39vRlaEVppcaz4hgVC3GPYZ7mfBbx5t7qdrfln9I2gUAfI2u22SQqKqRqwPW0qjv9gGM7HyvO6ZMTN5Jc+2gW26ykYkhbUgZzu0g/t7rXnCbTGB/b+fWqdQ97QTC2wVfTQvnfGXZFj4LYnHaC1IEWlVRUY4iw+ThdxF061byp1Jw9qPIzp0OtdS91935kX25GFFLYri8nVE1t6S9Wi1PQn66sYGkZIWK/DVuhAgqWDJU+URYUrqlnTzXbU0hFA6T1uIB//jf5+Xd/t4kvlbJaiQ+FowA2rFmAezq/rK6sXY8P2FbNLPUR+NBig8noeAsPrGK0sFoxLcJDaTuNFWD1CwDeVDVZifuWfmDx5bpXzqdp24/HwUetMjobhFD939gmcJa9Cm5qB9u6ioqWEpX5Q1F8HktJ7IP+xEZ6spAQNIsgbV4dupbZ0L5Y5q/zqwzKCJTdOYTaLRwYup5fKs0+jbcP+eKqQ5P6tK0ozwmQ5MrEc1WyB1uss5X39yT0cgnUxn8m8OFqEyTZmDfAbBXVQlVCTDopGqQRb8E2ckgyBENkRmYKVv4LdrXrFrv8YmDJfz30Cgu8lKmuM81C6D9AZN9vUTuRgcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(23010399003)(366016)(38070700021)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261021121427099003)(261102123227099003)(261022105027099003)(56012099006)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTlvU1ZxL2JuV3J4dGdxWnpPY1RTT0ZlTHZocHkyTVdOQWlua0hVTjdnM1hw?=
 =?utf-8?B?VXA2WlhNS2tOZ0o0dFNDYkU4dFpycE16M253bjEvUWpoazc4bXZjaE5hL1BL?=
 =?utf-8?B?TUg2NEprNUtwUXBFdFA5cnNQTkFtRHVFNHkwQ3dNb1VpSTkrTTYvTEk3cXd6?=
 =?utf-8?B?UHpRWXQwMGxRSm9RNWphSzhZYkFrY0JKakpscEtXb0dVWTgyOGtSMG8vVmRL?=
 =?utf-8?B?QmxiVWtUdk1wQ2pvM1YyQkY4QWJkVlpad3Q2b3F3N2dzVjNNRy9pcUl2OGNo?=
 =?utf-8?B?WmpacENObnZQd3MraVI4REF5QnNvc0JmemJkdElxc3gxa1lHMkRZVGh0VUFP?=
 =?utf-8?B?TVhpU2xIWXZCYjlEZ1VxaGliRWRZZVNuVHM1Q0g2VHBmK1AwSS94ekllRndr?=
 =?utf-8?B?dU9LdHlBNnFCb3l2ekE2ZjNrbGlLRGZwWXNtclpVd0I4aDdPamdIUE9rTnk0?=
 =?utf-8?B?V0xsSWYwNjN0U3h6emxwZllsc29oN2hOTEFOdm1ZbzBvOStGTDgwbElvM1NB?=
 =?utf-8?B?dENVbFdJbFowS3dxMzVLTVZ3eDcvaGVFOUtEaEluMVBDT0t3SllCRFNWTVYx?=
 =?utf-8?B?OFFmb2dYQy8xODdzSFlJelo5Um40NHRoUHd3M25VYy9iamxhQXpMWGwrWms4?=
 =?utf-8?B?RWdXRnZoeEFtR1IyOUxYanNEWUJ0dHVkQ2tORWhTaUVLd1BJMDRyeXV3UEJN?=
 =?utf-8?B?REE4UEtZUGpZOHg1dGswcDZTSmxudzlGRi9iU25nSE9QTWN5UEtuUUN4cURu?=
 =?utf-8?B?UXI2Y2ZrRFlWRTZvSlduNEJQcWhuUjAzWHhTb2FqOEp3L2Z6OHlzRDc2S2Vu?=
 =?utf-8?B?Yml5QWo5SDNzeWlnbmYzaGFIbFJUWHF3YUJrcS9SUVdidUIxU0dCM3hyQWZh?=
 =?utf-8?B?Uzg0N1pTUXNYbVdKV3JHUlZrRjJ5Qkx4NDNFSjhyelVoaU03cUVPbGFmZ2pN?=
 =?utf-8?B?NFBBaUw4MnJLaVF2TU8rQ0sxYzNENXRXM2U3NDlpcW9DT1VyRlBzaUJjazdI?=
 =?utf-8?B?bUNvNEJFUkFIOGtaaW0zdDFJSVl0dzhjbW45Vm55Y0lZTHI0SkZjcDV2bGIr?=
 =?utf-8?B?c2dDd25CNkw0aWxSbXBQQXd4SnltZUpMQzhCclI0cktEdmk3UGhYR0RIR1I4?=
 =?utf-8?B?Mklzd1BnQnpIRWpsaG1kQjlJQjYwN3BlaDZpT1ZaTm93SituNE9JWVRqZjZo?=
 =?utf-8?B?b0d0K2x2cmNkS3A4ZlBaL1FoQmRjQ2Zhajl4U0duSmtGcnliUi9wdEFhVTYx?=
 =?utf-8?B?NnNzYW9ROEE3aUdIVmM4NkcvZjlqNzFEdUdyWWtENzR1UkhlT2dQQWZIV2NL?=
 =?utf-8?B?V2xGV0pQRjcwTDlaRURJZXRPbFlMOE9Cblk0Qnlhb1V3bU11djVJUTJvc1ZZ?=
 =?utf-8?B?bU9rOElibEdCOHl3Mkt5bXdDcnlvNkV3dm8wSjkyQkJRaHJhT3VkckF1bG9P?=
 =?utf-8?B?bHBnd2I4dW9NM3BWemtnR2VodkdPYlVkVkdNUnVtWVM0cnNXaVMvKzRrRnIv?=
 =?utf-8?B?QkNtbDArdG9iSzY4Vm00OGI2bUcwb01FWkNBc2lLWHVOZDR3RFVON1VwT3JP?=
 =?utf-8?B?YzZiT0dHK1FHNzAyS1ZkRXV1OXY5UWF4OGJQV2YwZmVWZmN0Q1hmbnNEYzRk?=
 =?utf-8?B?emlBNG96TnNmbGdyYkpxL0ZUQWRWQUg3cDVldDdWWFBEWkE5RFNMQTFYeWZq?=
 =?utf-8?B?V0Y5bkh0Vzh2RElZM05GR1E0ZTQ4aFFKbElOWmhyV3hrcThiaGxhOXRFMnZY?=
 =?utf-8?B?a3F4VlhrLzRyM1h3KzBzZ0dJYzNYQ3BUd3U3UlArK2JZbm5JYno1d29lQ3FD?=
 =?utf-8?B?MnR2c3RPVVdtU0YrU2UyZ1VTK0d0RVRQZWppdVB3dTBDcFNBL1hMTTl6R2dC?=
 =?utf-8?B?eVRPeWlnVDhWNnJXUEtFbXZxMzU5ajdQb2NMUCtkeWp5ZW9iR0RrRkNTMW9N?=
 =?utf-8?B?R3hwZlNkb0tQVlgvK0NNbjRqOGpKU2twZXNSKzI2T2hEbEcrRlN6bXRHeTlV?=
 =?utf-8?B?Tmh6dFN4c09WNzhmUDhWVWhzbG1nZUU5K0RMdFdqOGhKWSs5Y1RuOUVhekFm?=
 =?utf-8?B?d3d5UmFaQjJZcDl5WHZuUkVSY1AvUWszTktoNjh5ekdwSzQzSUp5ek8yWVJL?=
 =?utf-8?B?aU93cVdaVURwOUdlQUdKS091R05UdlRsdEYrSnVXaThFSVZ0MkpMNXJuNmhh?=
 =?utf-8?B?SEJqQVRvWlh1QkhVNVZFVjV5N1ZPKzZ4UG40M09ibm03YjhWR2VMUVFlQ2No?=
 =?utf-8?B?Z3o4SThuV3RvVGVSV3NRY3d6NG5ZL2RYWnZtTlBVWXB4UFhLVXBGbXI0RGNr?=
 =?utf-8?B?dzc4SnA2c3ErVW1vUXA2N3lnR1ZiSk50M3lLTTZCdE1DblFGb1M5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B044A13C1ECA534C9FF17133690432D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mbD0mRgQf5tIJuLX5JiU2UjsLx15RbgeZW/AsG1YOO7l0ywXE4cvzdYeJxct6JFLUkJHNAjDSeK+Dz15vwaDdoK2JgJyHfyDuneeJXGwI8MXNlnqTCxIBF4jTzSk8HbqA2vU2wo2TDfP5MMnwnHqNPnsFKq3GCPnq7rUWAlYJVhIUGntjCvtPADkWmbEm9efgE6F6fifH7q/yddkxuAq2znYkXqvJMP/GMZeAwgvWzGu7C16Yt8v4+oHIyWrmBLrzy6m9ENmWTC/CoyO+FgR10RT014E8O5YC+duapOfc47yGDpSxxc57+TYdPDtc9ZGGqZO8YOCbB6IQcNcMwE+ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb063f6-2b01-46e8-0c6e-08df46d9d880
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 07:42:36.3838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/1bGZN6G7AvBpqSOkqbtG4Wna2HDoY2vn1qdSPWNiSo/r+Ljddy9Ldvc/M0Dp44tRpugMkopQHZjTj67LvOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8176
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
ZWdubyB3cm90ZToNCj4gQWRkIGEgbmV3IGRyaXZlciBmb3IgdGhlIERpZ2l0YWwgVmlkZW8gT3V0
cHV0IChEVk8pIGhhcmR3YXJlIGZvdW5kDQo+IGluIHRoZSBNVDgxODksIE1UODE5NiBLb21wYW5p
byBTb0NzIGFuZCB0aGVpciBEaW1lbnNpdHkgYW5kIEdlbmlvDQo+IHZhcmlhbnRzLg0KPiANCj4g
VGhpcyB2ZXJzaW9uIGN1cnJlbnRseSBzdXBwb3J0cyBvdXRwdXQgdG8gRW1iZWRkZWQgRGlzcGxh
eVBvcnQgb24NCj4gTVQ4MTg5IGFuZCBNVDgxOTYsIGFuZCB0byBEaXNwbGF5UG9ydCBvbiBNVDgx
ODkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5n
ZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoN
Cj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IG10a19kcGkgKmJyaWRnZV90b19kcGkoc3RydWN0IGRy
bV9icmlkZ2UgKmIpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGlu
ZGV4IGY3Y2JmOWI0NzY3Mi4uZjk2Zjg4NzgwOWMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtNjIxLDggKzYyMSwxMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBtdGtfZGRwX2NvbXBfZHRfaWRzW10gPSB7DQo+ICAJICAuZGF0
YSA9ICh2b2lkICopTVRLX0RJU1BfRFNJIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODgtZHNpIiwNCj4gIAkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9EU0kgfSwNCj4g
LQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni1kc2kiLA0KDQpXaHkgZG8geW91IHJl
bW92ZSAibWVkaWF0ZWssbXQ4MTk2LWRzaSI/IFRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gdGhpcyBw
YXRjaC4NCg0KPiAtCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX0RTSSB9LA0KPiArCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LWRwLWR2byIsDQo+ICsJICAuZGF0YSA9ICh2b2lk
ICopTVRLX0RJU1BfRFZPIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODkt
ZWRwLWR2byIsDQo+ICsJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfRFZPIH0sDQo+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtZWRwLWR2byIsDQo+ICsJICAuZGF0YSA9ICh2
b2lkICopTVRLX0RJU1BfRFZPIH0sDQo+ICAJeyB9DQo+ICB9Ow0KPiAgDQoNCltzbmlwXQ0KDQo+
ICtzdGF0aWMgdm9pZCBtdGtfZHZvX2NvbmZpZ19jb2xvcl9mb3JtYXQoc3RydWN0IG10a19kcGkg
KmR2bywNCj4gKwkJCQkJZW51bSBtdGtfZHBpX291dF9jb2xvcl9mb3JtYXQgZm9ybWF0KQ0KPiAr
ew0KPiArCW10a19kdm9fY29uZmlnX2NoYW5uZWxfc3dhcChkdm8sIGR2by0+Y2hhbm5lbF9zd2Fw
KTsNCj4gKw0KPiArCWRldl9lcnIoZHZvLT5kZXYsICJbRFBUWF0gZm9ybWF0OiVkIiwgZm9ybWF0
KTsNCg0KSSB0aGluayB5b3Ugc2hvdWxkIHVzZSBkZWJ1Zywgbm90IGVyci4NCg0KPiArDQo+ICsJ
c3dpdGNoIChmb3JtYXQpIHsNCj4gKwljYXNlIE1US19EUElfQ09MT1JfRk9STUFUX1lDQkNSXzQ0
NDoNCj4gKwkJbXRrX2R2b19jb25maWdfeXV2NDIyX2VuYWJsZShkdm8sIGZhbHNlKTsNCj4gKwkJ
bXRrX2R2b19jb25maWdfY3NjX2VuYWJsZShkdm8sIHRydWUpOw0KPiArCQlicmVhazsNCj4gKwlj
YXNlIE1US19EUElfQ09MT1JfRk9STUFUX1lDQkNSXzQyMjoNCj4gKwkJbXRrX2R2b19jb25maWdf
eXV2NDIyX2VuYWJsZShkdm8sIHRydWUpOw0KPiArCQltdGtfZHZvX2NvbmZpZ19jc2NfZW5hYmxl
KGR2bywgdHJ1ZSk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgTVRLX0RQSV9DT0xPUl9GT1JNQVRf
UkdCOg0KPiArCWRlZmF1bHQ6DQo+ICsJCW10a19kdm9fY29uZmlnX3l1djQyMl9lbmFibGUoZHZv
LCBmYWxzZSk7DQo+ICsJCW10a19kdm9fY29uZmlnX2NzY19lbmFibGUoZHZvLCBmYWxzZSk7DQo+
ICsJCWJyZWFrOw0KPiArCX0NCj4gK30NCj4gKw0KDQpbc25pcF0NCg0KPiArc3RhdGljIHZvaWQg
bXRrX2R2b19jb25maWdfaHcoc3RydWN0IG10a19kcGkgKmR2bywNCj4gKwkJCSAgICAgIHN0cnVj
dCB2aWRlb21vZGUgKnZtLCBzdHJ1Y3QgbXRrX2RwaV9zeW5jICpzeW5jLA0KPiArCQkJICAgICAg
c3RydWN0IG10a19kcGlfcG9sYXJpdGllcyAqZHBpX3BvbCwNCj4gKwkJCSAgICAgIHN0cnVjdCBt
dGtfZHBpX3ljX2xpbWl0ICpsaW1pdCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9k
ZSAqbW9kZSA9ICZkdm8tPm1vZGU7DQo+ICsJdTMyIHZhY3RpdmUgPSB2bS0+dmFjdGl2ZTsNCj4g
Kw0KPiArCW10a19kdm9fc3dfcmVzZXQoZHZvLCB0cnVlKTsNCj4gKw0KPiArCW10a19kdm9faXJx
X2VuYWJsZShkdm8pOw0KPiArDQo+ICsJbXRrX2RwaV9jb25maWdfcG9sKGR2bywgZHBpX3BvbCk7
DQo+ICsNCj4gKwltdGtfZHZvX2NvbmZpZ19oc3luYyhkdm8sICZzeW5jLT5oc3luYyk7DQo+ICsJ
bXRrX2R2b19jb25maWdfdnN5bmMoZHZvLCAmc3luYy0+dnN5bmNfbF9vZGQsIERWT19UR0VOX1Yw
LCBEVk9fVEdFTl9WMSk7DQo+ICsJbXRrX2R2b19jb25maWdfdnN5bmMoZHZvLCAmc3luYy0+dnN5
bmNfbF9ldmVuLCBEVk9fVEdFTl9WX0VWRU4wLCBEVk9fVEdFTl9WX0VWRU4xKTsNCj4gKw0KPiAr
CW10a19kdm9fY29uZmlnX2ludGVyZmFjZShkdm8sICEhKHZtLT5mbGFncyAmIERJU1BMQVlfRkxB
R1NfSU5URVJMQUNFRCkpOw0KPiArDQo+ICsJaWYgKHZtLT5mbGFncyAmIERJU1BMQVlfRkxBR1Nf
SU5URVJMQUNFRCkNCj4gKwkJdmFjdGl2ZSA+Pj0gMTsNCj4gKw0KPiArCW10a19kdm9fY29uZmln
X2ZiX3NpemUoZHZvLCB2bS0+aGFjdGl2ZSwgdmFjdGl2ZSk7DQo+ICsNCj4gKwltdGtfZHZvX2Nv
bmZpZ19jaGFubmVsX2xpbWl0KGR2bywgbGltaXQpOw0KPiArCW10a19kdm9fY29uZmlnX2NoYW5u
ZWxfc3dhcChkdm8sIGR2by0+Y2hhbm5lbF9zd2FwKTsNCj4gKwltdGtfZHZvX2NvbmZpZ19jb2xv
cl9mb3JtYXQoZHZvLCBkdm8tPmNvbG9yX2Zvcm1hdCk7DQo+ICsNCj4gKwltdGtfZHZvX2luZm9f
cXVldWVfc3RhcnQoZHZvKTsNCj4gKwltdGtfZHBpX2J1ZmZlcl9jdHJsKGR2byk7DQo+ICsNCj4g
KwltdGtfZHZvX3RyYWlsaW5nX2JsYW5rX3NldHRpbmcoZHZvKTsNCj4gKwltdGtfZHZvX2dldF9n
c19sZXZlbChkdm8pOw0KPiArCW10a19kdm9fZ29sZGVuX3NldHRpbmcoZHZvKTsNCg0KVGhlIHR3
byByZWdpc3RlciBzZXQgYnkgbXRrX2R2b19nb2xkZW5fc2V0dGluZygpIHdvdWxkIGltbWVkaWF0
ZWx5IHNldCBieSBtdGtfZHZvX3NvZGlfc2V0dGluZygpLA0Kc28gbXRrX2R2b19nb2xkZW5fc2V0
dGluZygpIGlzIHJlZHVuZGFudCBmdW5jdGlvbi4gRHJvcCBpdC4NCg0KPiArCW10a19kdm9fc29k
aV9zZXR0aW5nKGR2bywgbW9kZSk7DQo+ICsNCj4gKwltdGtfZHZvX3NldF9vdXRwdXRfcGl4aXRl
cihkdm8pOw0KPiArDQo+ICsJbXRrX2R2b19zd19yZXNldChkdm8sIGZhbHNlKTsNCj4gK30NCj4g
Kw0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgZW51bSBkcm1fbW9kZV9zdGF0dXMNCj4gK210
a19kdm9fYnJpZGdlX21vZGVfdmFsaWQoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gKwkJ
CSAgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X2luZm8gKmluZm8sDQo+ICsJCQkgIGNvbnN0IHN0
cnVjdCBkcm1fZGlzcGxheV9tb2RlICptb2RlKQ0KPiArew0KDQpJbiBkcGkgZHJpdmVyLCBpdCBj
aGVjayBtb2RlLT5jbG9jayBtYXhfY2xvY2tfa2h6LCBzbyBJIHRoaW5rIGhlcmUgc2hvdWxkIGFs
c28gY2hlY2sgdGhpcy4NCg0KPiArCXJldHVybiBNT0RFX09LOw0KPiArfQ0KPiArDQoNCltzbmlw
XQ0KDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kdm9fcmVncy5oDQo+IEBAIC0wLDAgKzEsMTkyIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDE0
IE1lZGlhVGVrIEluYy4NCj4gKyAqIEF1dGhvcjogSmllIFFpdSA8amllLnFpdUBtZWRpYXRlay5j
b20+DQo+ICsgKi8NCj4gKyNpZm5kZWYgX19NVEtfRFBJX1JFR1NfSA0KDQpfX01US19EVk9fUkVH
U19IDQoNCj4gKyNkZWZpbmUgX19NVEtfRFBJX1JFR1NfSA0KPiArDQoNCltzbmlwXQ0KDQo+ICsj
ZGVmaW5lIERWT19UR0VOX0lORk9RX0xBVEVOQ1kJMHg4MA0KPiArI2RlZmluZSBJTkZPUV9TVEFS
VF9MQVRFTkNZCQkwDQo+ICsjZGVmaW5lIElORk9RX1NUQVJUX0xBVEVOQ1lfTUFTSwkoMHhmZmZm
IDw8IDApDQo+ICsjZGVmaW5lIElORk9RX0VORF9MQVRFTkNZCQkxNg0KPiArI2RlZmluZSBJTkZP
UV9FTkRfTEFURU5DWV9NQVNLCQkoMHhmZmZmIDw8IDE2KQ0KPiArDQo+ICsjZGVmaW5lIERWT19C
VUZfQ09OMAkJMHgyMjANCg0KSXQncyBiZXR0ZXIgdG8gcGxhY2UgcmVnaXN0ZXIgZGVmaW5pdGlv
biBpbiBhZGRyZXNzIG51bWJlciBvcmRlci4NCg0KPiArI2RlZmluZSBESVNQX0JVRl9FTgkJCUJJ
VCgwKQ0KPiArI2RlZmluZSBGSUZPX1VOREVSRkxPV19ET05FX0JMT0NLCUJJVCg0KQ0KPiArDQoN
CltzbmlwXQ0KDQo+ICsjZGVmaW5lIERWT19QQVRURVJOX0NPTE9SCQkweDEwNA0KPiArI2RlZmlu
ZSBQQVRfUgkJCQkJKDB4M2ZmIDw8IDApDQo+ICsjZGVmaW5lIFBBVF9HCQkJCQkoMHgzZmYgPDwg
MTApDQo+ICsjZGVmaW5lIFBBVF9CCQkJCQkoMHgzZmYgPDwgMjApDQo+ICsNCj4gKyNkZWZpbmUg
RFZPX1lfTElNSVQJCQkweDEzMA0KPiArI2RlZmluZSBZX0xNVF9CT1QJCQkJR0VOTUFTSyg5LCAw
KQ0KPiArI2RlZmluZSBZX0xNVF9UT1AJCQkJR0VOTUFTSygyMSwgMTIpDQo+ICsNCj4gKyNkZWZp
bmUgRFZPX0NfTElNSVQJCQkweDEzNA0KPiArI2RlZmluZSBDX0xNVF9CT1QJCQkJR0VOTUFTSyg5
LCAwKQ0KPiArI2RlZmluZSBDX0xNVF9UT1AJCQkJR0VOTUFTSygyMSwgMTIpDQo+ICsNCj4gKyNk
ZWZpbmUgRFZPX1NIQURPV19DVFJMCQkJMHgxOTANCj4gKyNkZWZpbmUgRk9SQ0VfQ09NTUlUCQkJ
CUJJVCgwKQ0KPiArI2RlZmluZSBCWVBBU1NfU0hBRE9XCQkJCUJJVCgxKQ0KPiArI2RlZmluZSBS
RUFEX1dSS19SRUcJCQkJQklUKDIpDQo+ICsNCj4gKyNkZWZpbmUgRFZPX1NJWkUJCQkweDE4DQoN
CkRpdHRvLg0KDQo+ICsjZGVmaW5lIERWT19UR0VOX1ZXSURUSAkJCTB4MjgNCj4gKyNkZWZpbmUg
RFZPX1RHRU5fVlBPUkNICQkJMHgyYw0KPiArI2RlZmluZSBEVk9fVEdFTl9IUE9SQ0gJCQkweDI0
DQo+ICsjZGVmaW5lIERWT19UR0VOX0hXSURUSAkJCTB4MjANCj4gKw0KPiArI2RlZmluZSBEVk9f
QlVGX1NPRElfSElHSFQJCTB4MjMwDQo+ICsjZGVmaW5lIERWT19CVUZfU09ESV9MT1cJCTB4MjM0
DQo+ICsjZGVmaW5lIERWT19CVUZfRFZGU19ISUdIVAkJMHgyMzgNCj4gKyNkZWZpbmUgRFZPX0JV
Rl9EVkZTX0xPVwkJMHgyM2MNCj4gKyNkZWZpbmUgRFZPX0JVRl9QUkVVTFRSQV9ISUdIVAkJMHgy
NDANCj4gKyNkZWZpbmUgRFZPX0JVRl9QUkVVTFRSQV9MT1cJCTB4MjQ0DQo+ICsjZGVmaW5lIERW
T19CVUZfVUxUUkFfSElHSFQJCTB4MjQ4DQo+ICsjZGVmaW5lIERWT19CVUZfVUxUUkFfTE9XCQkw
eDI0Yw0KPiArI2RlZmluZSBEVk9fQlVGX1VSR0VOVF9ISUdIVAkJMHgyNTANCj4gKyNkZWZpbmUg
RFZPX0JVRl9VUkdFTlRfTE9XCQkweDI1NA0KPiArI2RlZmluZSBEVk9fRElTUF9CVUZfTUFTSwkJ
R0VOTUFTSygzMSAsMCkNCg0KR0VOTUFTSygzMSwgMCkNCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0K
PiArI2RlZmluZSBEVk9fTUFUUklYX1NFVAkJCTB4MTQwDQo+ICsjZGVmaW5lIERWT19DU0NfRU4J
CQlCSVQoMCkNCj4gKyNkZWZpbmUgRFZPX0lOVF9NVFhfU0VMX01BU0sJCUdFTk1BU0soOCwgNCkN
Cj4gKw0KPiArI2RlZmluZSBEVk9fWVVWNDIyX1NFVAkJCTB4MTcwDQo+ICsjZGVmaW5lIERWT19Z
VVY0MjJfRU4JCQlCSVQoMCkNCj4gKyNkZWZpbmUgRFZPX0NSWUNCX01BUAkJCUJJVCg4KQ0KPiAr
DQoNCg==
