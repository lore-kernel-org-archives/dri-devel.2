Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98608606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=osEtesiC;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=FUJmq7l5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D768010E1EA;
	Tue, 24 Nov 2026 05:55:18 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7948C10E1EA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:55:06 +0000 (UTC)
X-UUID: 95f28df2e7cb11f1b1788b6acf885367-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=QUMxrRvBDzLeFHuFvjLFX4Ou1EP5PUFmzJ+HyjhWiDw=; 
 b=osEtesiC/iNOAkffyr6wL4xjBN1BHnh9miFEuE6QmjTDFuMgDduWr/1/xYVFjBCsgO1A7sp+X/W+g/9ovoQDuX+sYeuo4Dn7jseft+OGZ2960swVW3t1NbSNHKXGakKIgJBameS4ryjJoTEgfhRrFCC0c7g4iEk0JsOgDFjqS2w=;
X-CID-CACHE: Type:Local,Time:202611241355+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:1bafc756-0b12-4577-b197-4a5ad3fdc442, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:b0318ac, CLOUDID:6f208043-cbc2-4c94-9713-3885eb4257f6,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95f28df2e7cb11f1b1788b6acf885367-20261124
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1198431413; Tue, 24 Nov 2026 13:55:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 13:54:59 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 13:54:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXLN6kpDQB7qFop9MDaUND+Sv6BYb721CPRWhUBNxbgHAb2f4pjnefXJd5lOQn0+tHWlYWt9TWsdJGzYPVNPdReiJ8qGqjkbGsyYfdwPhfncRz9p8JVkc35YpZXwAJWynf56kF8uxnU1uONpuq8UJ3sH7E6QzHHCDbQnD6fEye8GrzSdrRWSnd/N9DPMaysEOqgVds8xKBNJNJZoDAWrD8fCZkWUSjkMRkTnkC/uDyR3Y17awC14y2pLwj+4EpJ3Gl/TxshRFgjayKIPW+DG+53NKkT/f1NFailR/GlpOD85cFLQtDL6ZLcxffPcaJjO8zLyNVBxch7leNiEoPvT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUMxrRvBDzLeFHuFvjLFX4Ou1EP5PUFmzJ+HyjhWiDw=;
 b=pfS7Uf6oXW2SN7DMn3AOSKyA9bPZU//Q/o/RyWz9XtcELwdK6tKR0itzJ8Zh4n2kgz1wDjcqXo0NOYTb43+GVPDZyh8RJJLAeGdwonYS9Zw1jIsQ3LMI+9PlWCgSlPuREP1E/TTpOxzrWHNnrfL7iEPitAPYGpdCfCheCG0qxX0JJz8vnyJj2YQVDDNuo5HyV7o18da8MqSF6si0Twb3f4jARreOpYEwnvuXxwfZ/bZG8+HZnE5v4LXWzCMLkpQJx5ebGTsiQTjNIAHKhlTatVuC00hFuBJQFS7fc7lVOlvFxbhIQyniQsKgmPo2Hmww6+qhmAZKj5MsI8brqTghvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUMxrRvBDzLeFHuFvjLFX4Ou1EP5PUFmzJ+HyjhWiDw=;
 b=FUJmq7l5QxtaZlwY6sB9bRtLB/q8/7bwcU39WYXY8x9wj2744rJRk0S52+LrmuS8MHW4dON6evF41L0FR8Oyoihe/aZXgX7CQMvguE1Z1rB+0Cu0eDnMzH4SEDRNxTfirR36W91vl0utKuppKSIkQqyjFbrrH8SjOH+4ax7KkCo=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SI2PR03MB6757.apcprd03.prod.outlook.com (2603:1096:4:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 05:54:56 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 05:54:56 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?WmktaGFvIEh1YW5nICjpu4PmopPosaop?= <Zi-hao.Huang@mediatek.com>, 
 "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>
CC: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?U2hhb21pbmcgQ2hlbiAo6ZmI57uN5piOKQ==?=
 <shaoming.chen@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
Thread-Topic: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ
 wait short
Thread-Index: AQHddz/kX7eK8tYFzkqGS79HExAcKbczw08AgADYqACAACPiAIAHp/oAgABaVoA=
Date: Tue, 24 Nov 2026 05:54:56 +0000
Message-ID: <65140b86aed23f307f8552be8bc5ae13f1de1874.camel@mediatek.com>
References: <20261119033634.1844084-1-zi-hao.huang@mediatek.com>
 <fe208c0c-cea4-4e56-8283-e242ac1cd2ae@gmail.com>
In-Reply-To: <fe208c0c-cea4-4e56-8283-e242ac1cd2ae@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SI2PR03MB6757:EE_
x-ms-office365-filtering-correlation-id: 39472749-d9a1-4d98-42f7-08df49ef77b8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|42112799006|23010399003|6133799003|18002099003|22082099003|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info: 03ASvbfZ8ua44ZSvcGLNpz3qRmY/LY5jGB+saGfQQYO32qtZu8v+hCBALANOxh2YsnEutJEU+9iJuRHPnINdqsWSTtGctZ4TW7NdMjpGWthq6pZ8MHVTGuD7nhJtR2az3/0CHD27zwqoh0DCaZnD2AyTel/9JpiAz2tytIkg+/fzogmLr87aLDQ7LmtJyskzK1l3SvQk3znplScN6i6SAIIcFlNXGPuGEhubZC50dRMThg97OT2cPdcJvmoKYuHvER5ZX5OMjOxK94WjBk7/1chvwJbR4qRkUcb/mdykPlp0iHMz8YuOzm/ciwrl4WrkdlqZ0JQV8dADI9hqWmINkOedzmQYKY73TJHtD+4zaqpno8qoFTSjaePyqg3MygTACcdv+iB2eyZffIkHa4+SuVlOmf0MSxsbHP55u7Y24E7s9YVbN1XwZ+Tx24fooXpaIzgCasQh2WFwF7Z/5HNwfCrYzru9cd4tNAvPShliIY8jvij8c0DeXIATbtMAoDL/CDIT6WdQNbd3gFzyVtSkaY5nrfe4ZoM5SGvNidyiPrLRCxiEbS2CGXSCAi9W+7/lIYpoJ6sqzQmACQdz/9RL9VFlVrYF7qCbOQ/Ing6rdAGiUT93nPcaG5Beizx4UoK7pQYLC+w2iANt4AnU4QkrqpYBl9+CiwdqP2vptW22rxOAkc1B36k4r/9YIKtjqgENvgv/ajFihA+qKhAYP0bFaEkM5lecTXC2eU81zQLdXQY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(42112799006)(23010399003)(6133799003)(18002099003)(22082099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFSbjZvdGFwMThURFFCWHNGS24vQW1WU09iNnhOS3J1NXhQazVDYnZkSENM?=
 =?utf-8?B?ZU5JTi9BZW40TVNzV1hidGsvK1NZVnVKazFKK1hTblNBODF6VXpYMTdqSklw?=
 =?utf-8?B?bkl5SkhPUUx5TWZhN3UvNkJLUVpKdjBsRXQ2QWUyTGNTS1NCM2F1eUF5bWJa?=
 =?utf-8?B?SWNqVU95VGpORFpyVkJFVEwxRnoxK2FudkpMSnNUTmNvdlU1Mk1GWmpVbzVW?=
 =?utf-8?B?eSt4SUVJTHNMT0RIM0tRMFYrQVdlamJhNXVSUFdjc3pzVXdpMjFHTURsWE0r?=
 =?utf-8?B?dC9xTFRCWXdHbWRxbkJrR1NaNlhxaEtBcnFUa3B5Q1ovYnFNMFRPa0tIc21B?=
 =?utf-8?B?VWpYRW1RS3ZTc3d1NDZWeExQTTJTTzZJcyt5N0Q4VHZVRFYvbTJnVE15bUR5?=
 =?utf-8?B?UUNuRW5IcmxvemNETkZuazhWZ291cEYrVXI0cEVkRExTUFFkTEpZUUxLMzBB?=
 =?utf-8?B?TzlGd1UvNFNBTUZ3bUcwL3MzcmlxQ3p2bENReEQ2NS9ZenpCL29PT3RGR0hC?=
 =?utf-8?B?cjQ4clYwOWRyN2l4UklyU3JtTWxGQUpxRG45OWZHc1pJekViRVlOdi9hTDhp?=
 =?utf-8?B?OGNla0pjaERGS1BLeVNZREVWMUl0eU9QMTdUUFIrN0l1V0ZBWURIVXJJOFRt?=
 =?utf-8?B?TVJjQlhxQnlTQnJGWWRxaWpEVHNIQUcxUjE0Z1R4UTR2RnhoYytVaFVrNXRz?=
 =?utf-8?B?M2QzNTl3cDZQQXcrZmRiYjJxaStuYzR3bHZEeUVuUUVjTHFSSTJBQjFjY1A5?=
 =?utf-8?B?aDQ1Tlpid3dYYWYzbkV3QWd5RFJNUDVwVHNoa1AweXdXRzlXaVl2TW9LWnZa?=
 =?utf-8?B?d0M4R2duOFNUSmV6YmlxWUdYZFBGalI5TzNwK1hQTCtxTHlvSFRiWVQwVWt5?=
 =?utf-8?B?ckdjZG41bGVaWHhFM0JiNC9zVVZNaitNTkpQaWpBcU9qTy94dzIxckQ0RmhO?=
 =?utf-8?B?cTY2SVZOMGExdFRqT3Q5NUFrQ1M2SGEveGtFOG1lNXZxSXZBQWNzaXlpSG1H?=
 =?utf-8?B?S0IySk1zNGlHZkVZSnluY3pqVno0SDNCSGtZR2JQOTR4bjhxbnowMXRtamRr?=
 =?utf-8?B?dmxsV1NGMTgwWmVjUktYNzBLY0N6OE54a3dDWDhYd1NPbHhWaG9Bem9FMWZa?=
 =?utf-8?B?Q0lNOHRLMENiTVgxSG00RERwTWorNlRQUFVNWlU1UVVZeDM2eTZNYmd0RmZs?=
 =?utf-8?B?eW1ZZzU4RXBPVi96YWRpMVN1Zy9OZkVtd0Y2anl2MncrRTNIQzVEMzJFcDZx?=
 =?utf-8?B?QVkxczhydW1vNWI5VDlFaTF2R2dSdDJuM2RUNFJuZVZsQjBoSmliZjVQMGI3?=
 =?utf-8?B?ZVVidXNCY3lsL3JOUjk5ZTFxTkJzK3JBd2FYYVNQVFJNU29oNm5zYmk4RWp1?=
 =?utf-8?B?S1B4VmN6NnM0L3FDM3hPL2ZLWWdSQitDemxYV3NPZytiUmY1YWNEdFZEY2VT?=
 =?utf-8?B?dTNzZkpYY05IbVQ5U05VUjVoKzhGTXEwR2EzQWZtMENQczh3T1VLUEhIemVN?=
 =?utf-8?B?eXJBMTNOQkkvYWh4N2tRcUNqRDdNUUxEV0YrMm8rbHE0MFd5N0txRjUyMFRp?=
 =?utf-8?B?bEF0eXJpWHBxTTF3d3lOdU5Vc2UxMVdlYldZbEJ3YWk3TjFVRnBDckpuODlI?=
 =?utf-8?B?c3FOMkc2eU5iYnk2Zmd4Y0RTQkVIMW5Eb1daQ0lsRVdXMnBCYUxyM0g5MEZF?=
 =?utf-8?B?V1JIZjVMejJRRUxCdVlEZXJhWUdNMlpiamcveXM1WjRibEJpN0kwNFd0cDZQ?=
 =?utf-8?B?R0FoMzBDL1BUekZKVTlYbjBobVlJdkorTys0WStMeVJIT0NzZnhBNGd1SWVC?=
 =?utf-8?B?OEJZdGMvdjVEL2ZNRXI0OTRqaHpSak9aSFdmb0N6TTJtMXI5L2FxV0pGY0VD?=
 =?utf-8?B?VEVyUWR0akRtWHVDWlFCKzFDTUd3S200Rm5uM2ZnL08veW1rQVhodklrQUti?=
 =?utf-8?B?VW8rdDd2OFVkZ2JqWW5kcXdhaVEwTzNSYjNyWDgyWkUzOFpHMm4rYkxldU5Z?=
 =?utf-8?B?aVVESEtLRzM0cW44d2RZYnJ1Tk9VWkE3b3RnbkFDcDVFcTk4dnN4RDZzS0hB?=
 =?utf-8?B?RjZUMkpaWXFpVUxwY25FSS84MXVoWExQQ1BDQWttbCtrUTNveUtBbmRlbnlZ?=
 =?utf-8?B?b1o4UGZ0N09IblY0aEFiMElFRFZjNVJTZlRiWGVXYkw3SXBQaXRsMEwwcmpJ?=
 =?utf-8?B?ckoralowNDloZFp1d3dEZ0lQQmZyQlUreGxjUU5Mc2xKSS9ydncrc1RxZ0JL?=
 =?utf-8?B?eW84anpZdEdoUG1yMStxSy9yWW45ZU1oZE90dUh0emlhTDlzeERvU29MSHl3?=
 =?utf-8?B?VjE5YTlxNWhBcjFMcFhRMUNlblBiNm9TRzlDa0V0N2QwcWZuVzFqZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60739A4E6F23F48B9FB32EABCFDCB6E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OkAJBzG3xHOMJ+wLbDa4tQdYahA6CTj6mUWH/DtXuYws5AHcHG12ExbYt93GgC0447SNt0XWuNiFjDgOZ8VFfxNaQoyJL7mvJWkBzAoruJdxww5Wn1z/bq38AjbAGNWQWhVXHgKM2WqWjMr0BFXYfMHDmtbiUs3dYwqLMuIKZ88mzH6yyWQil+WssAgkUtv5roOuj7JWggLhC59yAy8oobyHtOOt/UQeSv4wLilBtdNPwoZtpn1sGUGdBhzat0yOXcuk8lMQ8SGnZGnZgLfd5OEzwfTYnXkBXNhiJfqsInXO3mNhhEY4dTlF3k0CfJ6sajSpbG0ooARbiwQdYVPw5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39472749-d9a1-4d98-42f7-08df49ef77b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:54:56.4320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WN/BohIQkcQwLH7mIFzSiPOIOCuKRf+emOzm6dfsRkjWd9hj1HCZGCE/DX/E9qUkac2ql3axaIsR3w60VJmbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6757
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
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE4OjMxIC0wNjAwLCBSeWFuIEJydWUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gT24gVGh1LCBOb3YgMTksIDIwMjYgYXQgMTE6MzY6MzRBTSArMDgwMCwgWmktSGFv
IEh1YW5nIHdyb3RlOg0KPiAgPiBJJ20gbm90IHN1cmUgdGhlIHRyaWdnZXIgaXMgc3BlY2lmaWMg
dG8gb3VyIGRvd25zdHJlYW0gZHJpdmVyLg0KPiANCj4gSSBoaXQgdGhlIHNhbWUgbG9ja3VwIG9u
IE1UODE3MyAoQW1hem9uIEZpcmUgSEQgMTAgMjAxNykgd2l0aCB0aGUNCj4gdXBzdHJlYW0gZHJp
dmVyLiB2Ny40LXJjNCwgd2hvc2Ugb25seSBEU0kgY2hhbmdlIGlzICJkcm0vbWVkaWF0ZWs6IGRz
aToNCj4gZm9yY2UgY29tbWFuZCBtb2RlIGluIG10a19kc2lfcG93ZXJvbigpIiBmcm9tIHRoZSBt
ZWRpYXRlayB0cmVlLCBhbmQgdGhlDQo+IG1haW5saW5lIE5UNTEwMjEgcGFuZWwgZHJpdmVyLCB3
aGljaCBhbHNvIHNldHMgcHJlcGFyZV9wcmV2X2ZpcnN0IGFuZA0KPiBzZW5kcyBkaXNwbGF5IG9m
ZiBhbmQgZW50ZXIgc2xlZXAgZnJvbSAudW5wcmVwYXJlLg0KPiANCj4gVGhlIHRyaWdnZXIgZm9y
IG1lIHdhcyBzdXNwZW5kIHVuZGVyIFBsYXNtYS4gbG9naW5kJ3MgUHJlcGFyZUZvclNsZWVwDQo+
IG1ha2VzIEtXaW4gdHVybiB0aGUgZGlzcGxheSBvZmYsIGFuZCB0aGUgc2Vzc2lvbiBpcyBmcm96
ZW4gd2hpbGUgS1dpbidzDQo+IGNvbW1pdCBpcyBzdGlsbCBpbiB0aGUgcGFuZWwncyB1bnByZXBh
cmUuIFRoZSBmcmVlemVyJ3MgZmFrZSBzaWduYWwgZW5kcw0KPiB0aGUgaW50ZXJydXB0aWJsZSB3
YWl0IHdpdGggLUVSRVNUQVJUU1lTLCBtdGtfZHNpX2hvc3Rfc2VuZF9jbWQoKSB0YWtlcw0KPiB0
aGF0IGZvciBzdWNjZXNzLCBhbmQgdGhlIGxhdGUgQ01EX0RPTkUgbGFuZHMgaW4gbXRrX2RzaV9p
cnEoKSdzDQo+IERTSV9CVVNZIGxvb3AuIEFmdGVyIHRoZSB3YXRjaGRvZyByZXNldCwgTVQ4MTcz
J3MgbGFzdC1QQyBsYXRjaCBzaG93ZWQNCj4gQ1BVMCBhdCBtdGtfZHNpX2lycSsweDg0LCB0aGUg
RFNJX0lOVFNUQSByZWFkIGluIHRoYXQgbG9vcC4NCj4gDQo+IFdpdGggb25seSBtZWRpYXRlay1k
cm0ua28gY2hhbmdlZCwgc3VzcGVuZGluZyB0aHJvdWdoIGxvZ2luZCB3aXRoIGEgR1BVDQo+IGJl
bmNobWFyayBydW5uaW5nOiB3aXRob3V0IHRoZSBwYXRjaCA1IG9mIDYgc3VzcGVuZHMgcmVzZXQg
dGhlIGJvYXJkDQo+IChhYm91dCBvbmUgaW4gdGhyZWUgd2l0aG91dCB0aGUgbG9hZCk7IHdpdGgg
dGhpcyB2MiwgMCBvZiAxMCwgd2l0aCBubw0KPiBEU0kgSVJRIG9yIHZibGFuayB0aW1lb3V0cywg
YW5kIHRoZSBwYW5lbCdzIHBvd2VyLWRvd24gc3RpbGwgdGFrZXMgMjcwbXMuDQo+IA0KPiBUaGUg
d2FrZV91cCgpIGh1bmsgbWF0dGVycy4gV2l0aCBvbmx5IHRoZSB3YWl0IGNoYW5nZWQsIGV2ZXJ5
IGNvbW1hbmQNCj4gd2FpdGVkIG91dCBpdHMgMnMgdGltZW91dCBhbmQgdGhlIHBhbmVsJ3MgcG93
ZXItZG93biB0b29rIDEwLjRzLg0KPiANCj4gVGVzdGVkLWJ5OiBSeWFuIEJydWUgPHJ5YW5icnVl
LmRldkBnbWFpbC5jb20+ICMgTVQ4MTczLCBOVDUxMDIxDQo+IA0KPiBJIGFjdHVhbGx5IGhhZCBh
IHNpbWlsYXIgZml4IHJlYWR5IHRvIGdvLCBhbmQgZm91bmQgeW91ciBwYXRjaCwgc28gdGhhbmsN
Cj4geW91IDopDQoNClRoZSB1cHN0cmVhbSBkcml2ZXIgaGFzIHRoaXMgcHJvYmxlbSwgYW5kIHRo
aXMgcGF0Y2ggZml4IGl0LA0Kc28gSSB3b3VsZCBhcHBseSB0aGlzIHBhdGNoIGZpcnN0Lg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBSeWFuIEJydWUNCg0K
