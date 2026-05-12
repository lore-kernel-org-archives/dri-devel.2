Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECFCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF2E10E9D8;
	Tue, 12 May 2026 09:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ikgvjq9x";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="H5SMXAqh";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B80910E9D8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:06:49 +0000 (UTC)
X-UUID: e620d6aa4de111f1a4e839cc21f16abe-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Hq9ld3vAenEwhZ7E7Xt1IkGSKB8JvhGQnQTGcjSbfV0=; 
 b=ikgvjq9xfIrTrfFIvdKjIfBF3U3bKuuAI97aOdSZbcp3qzYPHobtX/rHcj2rEiPiDKXUoQdrgMkObCrBbjcuIbeMJhRXp/LpjVh8oHlBGNZgkhqvg6SIBVgOccT5WXoyz0cf/NjivHXHdz08eRe6e3NZFOLfiO/0xS9fe0Dss18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:1d8880f8-0c73-499d-ae40-3078241955b6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:50407b45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e620d6aa4de111f1a4e839cc21f16abe-20260512
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 607293601; Tue, 12 May 2026 17:06:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 17:06:44 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 17:06:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaeEtNMXNOecTgQueAeW+Qr/DuyGkQiadS0WqaX0xgorh6AzvrIW2vcYq+pYFcuaVfq5q26++G38GbAlXkHcACuUeaBNJGIJbBY5mReFINBd1ySxf8uOzJkqsK1Ezqb/RHBQn5lGrGocVwVbS624o2j/T67XVJB5D5ptg+Zj22tZ2TYz+O7ib/8Bd+9RVr+FuZY1JWsnYkiPcGiOsFSP6aIx7O8jkjyFafvrtNw3voA6bcP881QCrbvdp1knqJ0DpkzwMP7VGGeq9tVCwn9inVpy0qs8o79+ctI9QvIcAF3Xjl7d5FkySm9R8cF3b5HUdlWPgRw/pDyvhDZBqzKlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq9ld3vAenEwhZ7E7Xt1IkGSKB8JvhGQnQTGcjSbfV0=;
 b=Q35X3doIXJoiH4YpKeJA/7Il7ckhb3/UGg/BGiKEP7BHVzN+wgyDru2r+QkwFQt/5lxc0mpYLTFkt1lu+Iuy5X+vFoLIha5+nKLfL15VDFLbOxHCyxs/gD6k3CCV9WkhftAnWFVuTrtf4XdsyODmu2faCL6WwYZdUG10Ga3Uodtkgzo6tT5CG1oc3t6wfgYTjGHgXuX2AFRJ38IR12XwGRTANIzuqlCFaMQZRouEK+Fu81mh3iLTByKJnPALpuWXtpBovFI4/MRH9geX+LIOxCtPFGwckD8KuDiHPzAQZ66UQVH16AKcdm2L+N+G7Nbs+FJjPEwjFDuHlmlE17Cn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq9ld3vAenEwhZ7E7Xt1IkGSKB8JvhGQnQTGcjSbfV0=;
 b=H5SMXAqhg+5yFYqnWwrzlbo/uOWLawge3y9Osm3E5j5UKkTZGJIZLjfQbdxVkyLu1Lp30wTL+hD5CfQk4uhkoicrmnog+innLPVf6YTdjEBECinkjUyPnu1Clhqz0zy13VdsP+qwiVgArRG9tT4eSqROtGR608rCTZ7w/Yswa8k=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SE3PR03MB9917.apcprd03.prod.outlook.com (2603:1096:101:333::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Tue, 12 May
 2026 09:06:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 09:06:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Alexandre Mergnat <amergnat@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/mediatek: mtk_hdmi_ddc: Fix non-static global
 variable
Thread-Topic: [PATCH 4/4] drm/mediatek: mtk_hdmi_ddc: Fix non-static global
 variable
Thread-Index: AQHc177vLUgEuzkQqUq80wWjmMPU8bYKLcwA
Date: Tue, 12 May 2026 09:06:40 +0000
Message-ID: <dc44730f1cae13fd73db72afef72148cbe4b22ed.camel@mediatek.com>
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
 <20260429-mediatek-drm-fix-sparse-warnings-v1-4-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-4-d95c4d118b83@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SE3PR03MB9917:EE_
x-ms-office365-filtering-correlation-id: 8f810daa-a7d2-49da-1978-08deb005c80b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|376014|7416014|38070700021|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: OM3vCxPFlMLDbyrNDXxun9rHpsO2OBK+WgM+23NpXggYu2OiGpw1l9MLhRmiCB4H6WpgniR+4w+7EKPTJUigbPK+MOmKiPdKVLHqSFhe9hlFuiy6pvvV2mO5AEzzSoQkKKsClU2w38tiVndl5zxVfgib2RCga1uQ5LmATVff12NMwpPgB8PwGwy1+jXi2dK+W7tVJMtpdhka9Da5RGZomBEOkRt+Uxj35NoM6ma6DieO4jWbAGch+cGr3bLmooGWOJU37syzwQguw5Z/NEF2xe0B5gCXgPl97vofbmL3IOyC7t92ReJDhY1lpyx7oteuzt0exaZ3V9hiDLC37qZEkgU21ozJ5lvoD3G1ObInyNDAuPyBaWQLu6mS/MogCiMNvKdenQ6VyYgCqMOekRYPO+7Q03qCJuOCl2FwmdwENYThiwqKSNaGT6De4zhikFg1Y8nK7jS8BCyDXGUSMczNKLxbCH4znLeIExX3hFUKP98BLnX1y4uVDxNJAeRz8o83prCd2OOamixqbJ3WMc+EkdaX65sbJfHRgZ+z8OsxWi7YYfRQ+Ay9ZminMNs668TOh68+6VLVQV//IEXECcQZDMzb0XDq15s2qSGUGRC/MOcynIitIrPlf0Vndw3fq1h/gxF/AbVXpusmQN05eMxsXy1IE5mrW9WPkH29+u6hKD32rLgMLaASPuoGxr7/bpQP+4sSAmsDjWWaCkOxAbR7PVAuwlihPDToBO6OnaPLqxIAWq3gDMAwT0z1mCfVFyfm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZZd3BvNTBJNDJlNnRETmNKaXcwTnk3WEZPajBlaVI5RG5mQTlDeGpIaWRU?=
 =?utf-8?B?V2E2OFNUTEg4L0VIaUg3aDlzbEgwN05XeEVuczRqRlc4bWNiY01YSnR2elhv?=
 =?utf-8?B?a2R4Q1N1NG5sYW1kMko1K3dRemdEZFhtTEhSb1FMRXcyMjk5VlR0c0YxZmFX?=
 =?utf-8?B?aFVkY3J1TTNrcEtwMDhSZmRDbnViYUJyQUpJZ2ZCbXRPejlQQmZvdzJtSTFI?=
 =?utf-8?B?dmVvVStMMWY1WjMyc1lIeGR6OXdqL3I1WDNYcUJHeGFqc3hQSlUrWDFLVUk2?=
 =?utf-8?B?cjU3NHVVN0o0NlhwemRoWFl4amd6dUJ6SzFuTjJlMWlVL2d2VFhxeTZwamFq?=
 =?utf-8?B?cUFwK2plVk02US9sTGkweXArRjMxWHlBUm41cnhGTUk5YjIwQzB6Tm95ZWpL?=
 =?utf-8?B?aTdxTFB5TmFNV01NU3RtOFEzNndPUzF3Vmo1c2lXOWN6SnZzZGU1OFJnTEY5?=
 =?utf-8?B?TUE2aDJYTTI0NTZYRUEvS05iaEdsMkdGeGVBOTVmUDFPRmVpR0V3Z3Zlai90?=
 =?utf-8?B?SDlPYXpyaXBjWUQ1eUJHT3ZoWEhReW52YU02Wmxwb1VtUjZHNmlkTlZsOTBv?=
 =?utf-8?B?cEx6OHVOSTlmRHpSMVc4Q2w0MitTZmtoQVltVHJwdDN0Yy9hSjlTVVR3ekxU?=
 =?utf-8?B?MEUxWWx5TlVyeTBvSFNiNlJXc3U2MG9wSDZabnNOOUFvVlhhNzRZbk05dnQr?=
 =?utf-8?B?TU5vd1l5aDk0d0lzR3pHeUEwSWhhMFJKclhqNlRtbVd4bXBRVTN2M1dpYzdG?=
 =?utf-8?B?c1lUSVY2Tjh4VWtqU0o1WmNWT2JpbG9Wd2xFZDVvTnlkckptUmJJZDRMb1BT?=
 =?utf-8?B?a1NlanBNRG5lU0dIUEluQUVBajFWQ1llL3p0RnMvMXhNTEJ6TWgrbFVoWlFQ?=
 =?utf-8?B?QmwxVVpYazExRnhrbUJSNDV3a1l5cWZZRGNocTFrL2VtVUFVc1NCT2pZZkl2?=
 =?utf-8?B?eG10Tit0MVVjb1VwTjdrYnR4V21reUd3QUdGbUloNFJuSnR5d2ZJY04zMDVp?=
 =?utf-8?B?R0Rodmt5Z2FubG1SUjA4RkdsRXkvUzM1Q2g4RE1oWitYdmRxYnNKbHNOU09r?=
 =?utf-8?B?SXdaa1VwUk9zU0RSc09UNjBsWm5HYjlRQThIT2VlcGF0VURXL1BKMmNBN2lF?=
 =?utf-8?B?VjRsSUVJeU1KcnljZUJXRVRlV0NvaXgrY3BOQXdsVWFDSDBGUFY1NWVyZDh5?=
 =?utf-8?B?aVROa3N2V00rMEtYQis1ZE5IQlBsSHlxTWtBYlFCSDB6TEsrbnhrcWNHaHNk?=
 =?utf-8?B?dHZ2aHVpakFDZ2I1aXRHbG5DcTBmZU51NmUyQWcrb0JtUXdYUzNvbHhjTzUw?=
 =?utf-8?B?TndpZlo2cldJcEl3OUZzeFNhWElEZVR1WmQ1NXVDOFJwQkZRZGkvK0VWWWpj?=
 =?utf-8?B?Q2E4aitLWmFsZUZxaERpczBoVDhHbHdMMkN4NUF2TkxmNm1SN0F5N0MrM09E?=
 =?utf-8?B?cUtJNEJnQTVQK0ducHg0eUlYSC9oZnlERk0zY2RPQ2owOEpMakgxbVBpQTlp?=
 =?utf-8?B?OCtkM21SNmlUYkphNkRQZEhRc1Znd2lRZmQ3TENEaVJtY2lwckgxYk5HcXdG?=
 =?utf-8?B?QjVvdndIdTBJc2lXK08yc3F3KzBnUmJHdW0rYTNrUlFkVDVEUzB4WkJRNXVm?=
 =?utf-8?B?TVBDYUF2OG9UMkhVUXUyVVBJcWdTMW8wcG5uUkM5RXE1K2MxcWNKVVFlM0Z3?=
 =?utf-8?B?MTFreHlMRll5R1ZaNjhETWprdjMyN0RhdXBtbEs3dld3bkZJQVRPVzhMQXIx?=
 =?utf-8?B?ZVB6VWpnMjJyU0Nnak0vQURTbjFEZ3VFMXhwNEVFZ1VBcDMyQnMyQmV0WG1D?=
 =?utf-8?B?ZlVhYm9DQ3RlR3lhcUdYa1ZQVHd2YnlPRjJnQS8vdmJRY2lrbmFud1BCUm4v?=
 =?utf-8?B?Y1FqNkIxejRGVmNGT2NuOFlOVjg1ekU4ekpYVmNDbmJWWFBlcVNXaHllbll0?=
 =?utf-8?B?UmFHQ0xlVFQ2WlJ3MitqSm5kaWpYZGc1RkN2dU80TUFBWnkyc2FYNGpCREtr?=
 =?utf-8?B?L0szbmdld3NSZklCQTBaR2oxeWVkZ2NvN3ZtbmVaZHpKWk05VXlIQ3crVFNy?=
 =?utf-8?B?YlRaenRRNFBkVmdMd0p2Vk5RUE40NDVTTno1WGpsbS9nalM4blZvT1BicEF2?=
 =?utf-8?B?a01yclI5Qi9SaDMySDZzKzM2bjVaOHZ4N3Z0OGlPZkxodFZGanZjUi9kbm5C?=
 =?utf-8?B?ZThVcFRyaFJXMndmSVY3NVpWTkxlMHVaYlNYVUhjU29OMGFKbThuZHVoNWtZ?=
 =?utf-8?B?SW5KWW1HNWJWVUVObDIrOFVuaDNLbUxvbmRHR0RSbitLS25QbzRYbkZYYnd4?=
 =?utf-8?B?VFhLemZrbjJKYXJmcDlqYW1VbGNOcnMwQ01UNHhWeTdyMHRncDR6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADB0EBC4663D9543816DC9D1D0BF09AC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tktiKe8uqH3BcDRohuBZGDh/dp8Bpd8FlSC10b0os2fb/zNZTXi0PAF2LhPHghqwQWowpt5BCifTmk53fMbv7e7qjuwzUHeMD15WgJgh7CqUHuNi9idLCRRmMAYrkYAOcuao5do2CwKFkDzLbFSKTrnh0pw47bII3iXcyitwS3NqOMXwSiztCtDehvC0ZJhttUe7F+YhPHJGvvbRDlQHxv6UwUp6jxmin1/gT4kmJeTdGr5vp6WdUcYMm8qvwxM4mkJJY1vbt8FsKoiTqB/tCHPMVTi6T+ewN8YVCH20mka/8nv3Zxoofku6L5jLkBtLB/LFQb1ZpbxfdQOBt7S8wg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f810daa-a7d2-49da-1978-08deb005c80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:06:41.0180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5w9H+XPznEEt9N86ezbIlPlq9YQ4XYmbqubHLRA9za4ic2QP3XvrAKFL+4r2mOGGx9qvji9/gipHyqWCiEsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9917
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDExOjU5ICswMjAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBUaGUgc3RydWN0ICdtdGtfaGRtaV9kZGNfZHJpdmVyJyBpcyBub3QgdXNlZCBvdXRz
aWRlIG9mIHRoZQ0KPiBtdGtfaGRtaV9kZGMuYyBmaWxlLCBzbyBtYWtlIGl0IHN0YXRpYyB0byBz
aWxlbmNlIHNwYXJzZSB3YXJuaW5nOg0KPiBgYGANCj4gZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pX2RkYy5jOjMzMToyNDogc3BhcnNlOiB3YXJuaW5nOiBzeW1ib2wNCj4gICAnbXRr
X2hkbWlfZGRjX2RyaXZlcicgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8N
Cj4gYGBgDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0K
PiBGaXhlczogYzI0MTExOGI2MjE2ICgiZHJtL21lZGlhdGVrOiBtdGtfaGRtaV9kZGM6IFN3aXRj
aCB0byByZWdpc3RlciBhcyBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1i
eTogTG91aXMtQWxleGlzIEV5cmF1ZCA8bG91aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2RkYy5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2RkYy5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2RkYy5jDQo+IGluZGV4IDYzNThlMWFm
NjliNC4uMmFjYmRiMDI1ZDg5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2hkbWlfZGRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2RkYy5jDQo+IEBAIC0zMjgsNyArMzI4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbXRrX2hkbWlfZGRjX21hdGNoW10gPSB7DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgbXRrX2hkbWlfZGRjX21hdGNoKTsNCj4gIA0KPiAtc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBtdGtfaGRtaV9kZGNfZHJpdmVyID0gew0KPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgbXRrX2hkbWlfZGRjX2RyaXZlciA9IHsNCj4gIAkucHJvYmUgPSBtdGtfaGRtaV9k
ZGNfcHJvYmUsDQo+ICAJLnJlbW92ZSA9IG10a19oZG1pX2RkY19yZW1vdmUsDQo+ICAJLmRyaXZl
ciA9IHsNCj4gDQoNCg==
