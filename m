Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB542606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=sy2ks27l;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=oCfY8wEC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DAB10E067;
	Tue, 10 Nov 2026 09:14:56 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940D210E067;
 Tue, 10 Nov 2026 09:14:44 +0000 (UTC)
X-UUID: 27fd1572dce711f18dc8c9802ae25ab1-20261110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=nsbQmQBPw1ktOrHEs4NVD1dnTBD6K/USNtOhGAin0rE=; 
 b=sy2ks27lYXz3UkHNLb4U9tG59pkQTzFfDKKJ5Wvj0B1RkVBwJqylWG0+8ToZ8syaerAWtjASsopzw+PU4TCTK9RneeSGEuTDtqBWdKxcRdAc6jLbnIISufFuwrNO1W2pI/4jW3FoBH/FQ79MaHEcIbTvd4WtznwHpE0qgXnjls8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:6df1caf4-5224-41a9-859a-ccddc31f664c, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:b0318ac, CLOUDID:4ebd8b8d-b3e7-4795-ae33-b1b4d51e21d7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 27fd1572dce711f18dc8c9802ae25ab1-20261110
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1804101801; Tue, 10 Nov 2026 17:14:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 10 Nov 2026 17:14:38 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 10 Nov 2026 17:14:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcNSemhXpLOvwY7u+GloRnHeTgjDq6vc9EAEFfFSIZCTTIh3v3Tznpkb3palEtQP1DVeaVbkLtTS7+Cc0g56XNnOluYJoI113ge3vAP3EQ5jkpJqSEz+fZvWIpdekdFxjIyvAF8eTxg1szTk8kKxxtvhkAo1SQYg46plSgl8y61MQCHJwFvMc4neInWPHTQG630dNo97RF18TG2E5ThQnLseNnUBKw/bRdWPX4lEm3y6rPXIZxgZSWZLWukeirz3X2ID/BkiRDm9/mKsHReKkS8K3NHmRJMHMpeiCdI/rmChsS3P6dfV6bneU7Xh7UqH8GLM13khRzO4ElQpB7LHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsbQmQBPw1ktOrHEs4NVD1dnTBD6K/USNtOhGAin0rE=;
 b=ff27xcAk1rSI4/WIFX2EXGJxEsVOJmk6TncpVutwCmbH71lJNvsTcPdBY+tRVH7ANe/adpyN4+350P3e5fqQt+3a2sfkucsrZ1DVUG5ZxvIFYks/w2FsInrzaBuAeBlIuGw9T7qdQac8tC46aPvGXUWBCNydZVpXP9N5rsPMB6xJHtHRRbgrIj7BOt8bCYNV9gmhaxWDCS1kdnW9RX/e11xOqvNK9VUbkfEGA1eD9j4GNNhnN6DtaoX5+XBPCRhPCe/3avvDw5sPQNw/7RL6oug0oueQCeUuBf+ZWJWN+/osUibsYDUgbybNzFp0x97zrSl8dAb29fYvpdIRL6/OwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsbQmQBPw1ktOrHEs4NVD1dnTBD6K/USNtOhGAin0rE=;
 b=oCfY8wEC0Uvi/qGpLc6ihWUco3QHbA48bBpDA9Pr6c0aXSfb3bCuy/EKazF8P/n0cjQKw3zod1KptmWfTQgsEtP+UlcQuNYYbhDjU7LptIjC+Kkk9SJesQJOyD7uueVxPaEalMnC5r93u9owh/0IZxAUVGksE1FQHQRd7eeTdYU=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KL1PR03MB7599.apcprd03.prod.outlook.com (2603:1096:820:cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 09:14:34 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:14:33 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: Daniel Stone <daniels@collabora.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "Laurent.pinchart@ideasonboard.com"
 <Laurent.pinchart@ideasonboard.com>, "joonas.lahtinen@linux.intel.com"
 <joonas.lahtinen@linux.intel.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "rfoss@kernel.org"
 <rfoss@kernel.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "lumag@kernel.org" <lumag@kernel.org>, "rodrigo.vivi@intel.com"
 <rodrigo.vivi@intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "jernej.skrabec@gmail.com"
 <jernej.skrabec@gmail.com>
CC: "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>,
 "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
 "navaremanasi@google.com" <navaremanasi@google.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ddavenport@google.com" <ddavenport@google.com>, "markyacoub@google.com"
 <markyacoub@google.com>, "seanpaul@google.com" <seanpaul@google.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v3 8/8] drm/mediatek: Use dp_connector helpers to
 expose link training state
Thread-Topic: [PATCH RFC v3 8/8] drm/mediatek: Use dp_connector helpers to
 expose link training state
Thread-Index: AQHdWlwyIlLaBh/dhkqekwlWDkO+nrcnMxIA
Date: Tue, 10 Nov 2026 09:14:33 +0000
Message-ID: <e97d95b78d4cf00789d9736f12cd67bbbead9a00.camel@mediatek.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-8-7517f4aba0f3@bootlin.com>
In-Reply-To: <20261012-feat_link_cap-v3-8-7517f4aba0f3@bootlin.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KL1PR03MB7599:EE_
x-ms-office365-filtering-correlation-id: 5b789659-71d4-4032-1169-08df3f0b08a4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|42112799006|366016|1800799024|22082099003|18002099003|6133799003|3023799007|10067099003|921020|38070700021|4143699003|11063799006|261102123227099003|261026121527099003|261022105027099003|261009220027099003|56012099006|261021121427099003|261026140227099003|261028144727099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003;
x-microsoft-antispam-message-info: 22biz8wMyII4eIMm9ZEbVAN/WDx99VTO9W97ARHP/vKLfL1vAbZRMa5Z7c6fTwBcaw9w97/vW+5pWmGalB86BczLE2Y5m79jLA5m6DF1ABPLS9rWzTIAF+OwAmevl4ODEGK9lVfw7mR2gVWpi+h7nq05FbXJj3z9BsKRCd/Y/yU1uCGX+M9c9uz0P8dfh3FxEUCLkDmgOUcCOzdRbM7ZxJgJ8oQeJYPv9YFNLbKts/IgDwWp+M9ofNu+u+aUtbazvTmCZNHGcxlXa4/YqbFskagngA71wNLMVDRVoOlH1rnKKESGHtGL/M6DKvR9YQfS6hZA/JiDap48upaA15lM6fcIdy4cWVFSzL7lN7MxNCMH1SCMcHeJJMhX7L3qHxVrUQ8KU1V4S4gcdWSrMpUlxE1/VfKTQTgWJM/JIQcBxWMlFQT4YykLZdkGgP7AmmLmRbpc/UG19qXQSfOf7fPVpHoHyQBbtE5Dck5ytoPt8IF+2U2qoP1m+d5SoNm6Vw7Z6Nui20RQ4tyR8BulzwQo4UADasMcFje4YU9BCu/6sZa3jF6kkzF+J7761DZDyTlbmkYSLxYxxC4Dxy6FYyNiiiSyrYm9JkUBaHrhdJ2AMGj/OmWGMS9hmiTkXNNLiPhbN81EoPpI6mWVvJtO7IX5NWS/+pp5tQxJu4p/Hp2v7dLvUfTc8adJFlc65+JqIAddTlexPxAbZnK01nJj96vSgOBo+5wXwsCMY5laGuZExPrXDSbGxbvKSJVqQyH0Itc9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(42112799006)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(921020)(38070700021)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261022105027099003)(261009220027099003)(56012099006)(261021121427099003)(261026140227099003)(261028144727099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVqRTJvR2pqSEVtODJSdm93V2wwMnVRVFZYVi82ckw3YUZaQ1FqTWlZb2dQ?=
 =?utf-8?B?UlZOb0ZXZVVqczJoYXhUNFlSS1BDZmsrMjZqZnRuNTVIRmx4NnNPRXc3VDlw?=
 =?utf-8?B?cVNaTzlXL0ErYkhrZnhDL2VlS2Jma0YwU0tUQ1ViRVR0NVhNbllqNEhkVXFD?=
 =?utf-8?B?bDFpS2N5QnVOeXlZTGwyOG5rckl4bUhxdmF1MG5mRERpbnNtVWhQbjdVSHd6?=
 =?utf-8?B?ZzVQQjA3Z2h5bFBmNXJMNTBhSHplNnVRblVhRXIvcjRwU1F5NnNUSDNhc3lM?=
 =?utf-8?B?KzFUY1NlN0hpaW1mM0s5OXZnOGEwZXJueGZCM25Xdkc0Z3doMG9tYUIzTjlN?=
 =?utf-8?B?bFEvWDNYbU1IWEJwaER0SVV3c0hDZ1pqMWdiSzFuYnNZMSt0M21iZkNCUkYv?=
 =?utf-8?B?Zit3ZnB2YXBwUUdRY20xazcwcmcycjU4d3Y4Q0cyNkNIeGF2US9id1FlSk9G?=
 =?utf-8?B?NjJBRGNBdWErOS8xSXdlWFcrUXcwTFhvazFpQnpJUFFETHBNcU1uTGtvTmhL?=
 =?utf-8?B?YS9yRmlhQlFNSkMvSGo1Q1hRb1ZKQUNHbEhmOVBQakR2VXlsV203QmJsSUlD?=
 =?utf-8?B?dEc0WE0wdXE4QTZEWm9UMEFuMGxMbnB5WHNHV1A5VjR6L1l2SFBVS1c5c0Mv?=
 =?utf-8?B?akRqQzNrZ1VYeW9DNCt4VmExM3YyYTBBcXVwZjE2SktqeFF3TGZLblhyQkhJ?=
 =?utf-8?B?SURqTkRud0JQY2VybzZRcTQrQlJ0d3k5UWk0K2Y2bHo3a0w0YkpxOEIxUmZI?=
 =?utf-8?B?Q0YwcTlhOVVQTUljRGo3eGxXK2ExekRqb0dsdFdHa2piTFRmSnJxcGs4TDBG?=
 =?utf-8?B?ZVZxSjFIUWRJdzJQVnNwdkZuWkpDRXlBbDMyamx2U3JCLzYrSVB2ZTNxZGVa?=
 =?utf-8?B?V0tXcEhmeDFDRmxuVnplQ0kvWHRnSStwQmh2VFYzNWpuZ2J3U3ZEbXN4c1ZK?=
 =?utf-8?B?YXhQV3FaeUN6SllVL3kvTWk5RTVYSC9xdnRsZDNPdXNKRjJmTUxDWEpKOWVT?=
 =?utf-8?B?eVQ4UkFORmpPeHdac040SjVkeXE5OGNac1VpRXhoQVUxakZNWXIxVFhsNEQ0?=
 =?utf-8?B?Tld6ZkFUeTVYSVRIN25ZZGVnS3RzSDdub3dVV1BJSWRVWTBHdE81YUJXNTFE?=
 =?utf-8?B?WjVZNnlrcitrcVZERklFRjg3OW5JUkZXVG5QNTlLd3U3Tll2OGJIOXNsZXZu?=
 =?utf-8?B?SlhuZlR4TWU5Slp6TElqd3QvWlFCU2FkUllob2cxdVpCQTVybEJzZFEvVEpV?=
 =?utf-8?B?S044QjYwd0pRelhscExEeE9LVStGYURCSnFkRXhLYWo5ZXpCcHdCb0FJMUEy?=
 =?utf-8?B?R2hoWnU1UVpwZDRqaWZqY3Q0TC9wM3FNRWNzbnBNWUoyNnM5ZVlTQ3ZsSFJI?=
 =?utf-8?B?cjRRVGpPeG51UVlxeUE0V2w5VHBQaUhMOHJ2R3NQazJWTDZvSDk3MUtnaEpT?=
 =?utf-8?B?V1NON24waTIyRVZ4ZkRZR1pvSkxLTmpmZURpL3k0YktLUS8xUng0K0VxZkhF?=
 =?utf-8?B?Y054MkhhM0U2TS83R0R1akZMQkdFTGJrbDRmYVdqSjhHQm5zbkt2R0pjSXdW?=
 =?utf-8?B?MkxTUkNOV2RJS2dhY2tydm56ZHY4QkNPVnd3QmdXMlZDRHdJbTFJOGo4RzF0?=
 =?utf-8?B?cG1iWGd2dW4rUmRIMzlSZGo1Yld3dVdQS25KNW11c0lTK3A1RWdOekpyejVy?=
 =?utf-8?B?Znl1cWZDWEMybzhIU0FZL3hYN1pDd0cycFVJU1RsV1ZlcC9TU1dIaEZTZ1V2?=
 =?utf-8?B?SlFUNTJBSXNpNFNPNTA3ZytPVHE1dEpFaUVNRjdwZXRGU2UzeVF0ZUhVOWtp?=
 =?utf-8?B?c0RlK3BxanhQL3pBenhDcXBOYlpGWFVwV1dtRS90bGtYUjhOVGtKTzNIZVpR?=
 =?utf-8?B?SDI5eEs0bm1tVStpM3VvaU1DVXNuNWxCSUVkcEJLUU9ybHZVMGhCUVJLcnUy?=
 =?utf-8?B?SXBlWXpCT2tMbmI3ZjYyYjZkenFGenEwbSt6TW1yRlVxK2R0d1ZHZG4yVWRI?=
 =?utf-8?B?Y0NRdE40ejl3blY0Q0xPbkxpN0R2a2JwSlAzKzJ1UGhXZ2t1c3YxdGt6Q3I4?=
 =?utf-8?B?MzhzcURUL1ZiUjFDZUw5aVNhUHVjWEN0cU01QXBHM01QQmM3aEc3dHdqTlJx?=
 =?utf-8?B?MWlGQWJRb0VpbjBkUnZyN1FtQStPS2Y2YnhDZGQ4MWx4ZG5GaDRwLzl2K1Aw?=
 =?utf-8?B?QkF2ZHlsL3dVdE5ldDAvblhwRzlFV1pmd1pIb2xZajdNZHkvQm9YK2ptRHRS?=
 =?utf-8?B?U3NsYjJiczQxZmtzQk5qNGplVkVZcnYyRWVKOExrSllKNEZRQ0lsNko3UHM5?=
 =?utf-8?B?M0lkeGRlOXF6RmxobmhjRmZNOFNJbXhRVG9yQzNPc3VNaW5PaGFxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9AE4746EAA5C440880887C664D8229E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: poUenV7TkbehRnSD9ioNqxklORXHkTxA/c0PzqmzCD+V/rnAUmnkep6JCPmwaRLLxKEfSsm14Pybs+hyPfsFhLeUdcQwewKOKVNdOUWsfybTl5Nl4bqhHBwvFyjHV7kU3L+WcHJB943UBC+68kvenzD+U6XE/qVkVjA725USZ9dAMJclTrKKh47/Ax9D/DFmT+ReOgGYeJ7SG4zTH+QyVCF0s6meNQJPTLku4XTLMrlPfnEQ9OrsSgmUz2xnncfRbSjverostyXWMDlfzccu9oaA2J8ElRr2OBxbhPkwpBDaKKWfwq3TKW8tWLqKrEuDg68/o9hfviyTnqA2Z+CpAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b789659-71d4-4032-1169-08df3f0b08a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 09:14:33.1153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCV04J7rFinqbw8wf0TE7z0ijrZyIH7dGWOWjRJiDfXJpOjiwzouQiB4vsP0hIwVcECo6QXHR3HY3A+J/NXdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7599
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

T24gTW9uLCAyMDI2LTEwLTEyIGF0IDE3OjExICswMjAwLCBLb3J5IE1haW5jZW50IHdyb3RlOg0K
PiBBZG9wdCB0aGUgRFJNIGNvcmUgRGlzcGxheVBvcnQgaGVscGVycyBieSBzZXR0aW5nIERSTV9C
UklER0VfT1BfRFAgYW5kDQo+IHBvcHVsYXRpbmcgdGhlIGJyaWRnZSBkcF9saW5rX2NhcHMgYXQg
cHJvYmUgdGltZS4gUmVwb3J0IHRoZSBzaW5rDQo+IGNhcGFiaWxpdGllcyBvbiBob3RwbHVnLCBy
ZXNldCB0aGVtIG9uIGRpc2Nvbm5lY3QsIGFuZCByZXBvcnQgdGhlIGxpbmsNCj4gcGFyYW1ldGVy
cyBvbmNlIGxpbmsgdHJhaW5pbmcgc3VjY2VlZHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLb3J5
IE1haW5jZW50IDxrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoN
Cj4gIHN0YXRpYyBpbnQgbXRrX2RwX3RyYWluaW5nKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4g
IHsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMjAxNSw2ICsyMDQ0LDggQEAgc3RhdGljIGlycXJldHVy
bl90IG10a19kcF9ocGRfZXZlbnRfdGhyZWFkKGludCBocGQsIHZvaWQgKmRldikNCj4gIAkJCXJl
dCA9IG10a19kcF90cmFpbmluZyhtdGtfZHApOw0KPiAgCQkJaWYgKHJldCkNCj4gIAkJCQlkcm1f
ZXJyKG10a19kcC0+ZHJtX2RldiwgIlRyYWluaW5nIGZhaWxlZCwgJWRcbiIsIHJldCk7DQo+ICsJ
CQllbHNlDQo+ICsJCQkJbXRrX2RwX3JlcG9ydF9saW5rX3RyYWluKG10a19kcCk7DQoNCkkgd291
bGQgbGlrZSB0byBkbyB0aGlzIGluIG10a19kcF9iZGdfZGV0ZWN0KCkuDQpTbyBtb3ZlIGRybV9o
ZWxwZXJfaHBkX2lycV9ldmVudCgpIGFmdGVyIG10a19kcF90cmFpbmluZygpLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiAgDQo+ICAJCQltdGtfZHAtPmVuYWJsZWQgPSB0cnVlOw0KPiAgCQl9DQo+IEBA
IC0yMTQ1LDkgKzIxNzYsMTIgQEAgbXRrX2RwX2JkZ19kZXRlY3Qoc3RydWN0IGRybV9icmlkZ2Ug
KmJyaWRnZSwgc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcikNCj4gIAlzdHJ1Y3QgbXRr
X2RwICptdGtfZHAgPSBtdGtfZHBfZnJvbV9icmlkZ2UoYnJpZGdlKTsNCj4gIAllbnVtIGRybV9j
b25uZWN0b3Jfc3RhdHVzIHJldCA9IGNvbm5lY3Rvcl9zdGF0dXNfZGlzY29ubmVjdGVkOw0KPiAg
CWJvb2wgZW5hYmxlZCA9IG10a19kcC0+ZW5hYmxlZDsNCj4gKwlpbnQgZXJyOw0KPiAgDQo+IC0J
aWYgKCFtdGtfZHAtPnRyYWluX2luZm8uY2FibGVfcGx1Z2dlZF9pbikNCj4gKwlpZiAoIW10a19k
cC0+dHJhaW5faW5mby5jYWJsZV9wbHVnZ2VkX2luKSB7DQo+ICsJCWRybV9kcF9zaW5rX3Jlc2V0
X2NhcHMoY29ubmVjdG9yKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICANCj4gIAlpZiAo
IWVuYWJsZWQpDQo+ICAJCW10a19kcF9hdXhfcGFuZWxfcG93ZXJvbihtdGtfZHAsIHRydWUpOw0K
PiBAQCAtMjE2MCw5ICsyMTk0LDE4IEBAIG10a19kcF9iZGdfZGV0ZWN0KHN0cnVjdCBkcm1fYnJp
ZGdlICpicmlkZ2UsIHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IpDQo+ICAJICogd2hl
dGhlciB3ZSBjb25uZWN0IHRvIGEgc2luayBkZXZpY2UuDQo+ICAJICovDQo+ICANCj4gLQlpZiAo
ZHJtX2RwX3JlYWRfc2lua19jb3VudCgmbXRrX2RwLT5hdXgpID4gMCkNCj4gKwlpZiAoZHJtX2Rw
X3JlYWRfc2lua19jb3VudCgmbXRrX2RwLT5hdXgpID4gMCkgew0KPiAgCQlyZXQgPSBjb25uZWN0
b3Jfc3RhdHVzX2Nvbm5lY3RlZDsNCj4gIA0KPiArCQllcnIgPSBkcm1fZHBfc2lua19zeW5jX2Nh
cHMoY29ubmVjdG9yLCAmbXRrX2RwLT5hdXgsIE5VTEwpOw0KPiArCQlpZiAoZXJyKQ0KPiArCQkJ
ZHJtX2RiZ19rbXMobXRrX2RwLT5hdXguZHJtX2RldiwNCj4gKwkJCQkgICAgIiVzOiBlcnJvciBz
aW5rIGNhcHMgc3luY2hyb25pc2F0aW9uICglZClcbiIsDQo+ICsJCQkJICAgIG10a19kcC0+YXV4
Lm5hbWUsIGVycik7DQo+ICsJfSBlbHNlIHsNCj4gKwkJZHJtX2RwX3NpbmtfcmVzZXRfY2Fwcyhj
b25uZWN0b3IpOw0KPiArCX0NCj4gKw0KPiAgCWlmICghZW5hYmxlZCkNCj4gIAkJbXRrX2RwX2F1
eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgZmFsc2UpOw0KPiAgDQo+IA0KDQo=
