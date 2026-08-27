Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48126C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C8510EEB7;
	Thu, 27 Aug 2026 07:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cZDfHhLf";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HHwC4nKJ";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1296810E3B9
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:22:52 +0000 (UTC)
X-UUID: 19f64bb8a1e811f1b1788b6acf885367-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=jvhpzmw0HO0k3cBAsvHxqQDqA8gpTqhDnPOlwYZU0Gw=; 
 b=cZDfHhLf5QvcwDULSLlnG4zkhNrqJJcyN8t6CzuPffDv3KQPqMH9VvwW0lSpSxVBUZKWzp4OVY/uAuVcRpzTTrx51LSnhiK5RsH+X8teyiI+mGybRrjIEWsYk0rn+feDL+X2bMigqcFkPQ9xR4KFmA6fWbrkFl36bHVQIAI3bmY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:639c9232-7dce-4839-ac80-ccd35a52dd0e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:9a7a68b9-70a6-46ee-89b5-5e757858aa60,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 19f64bb8a1e811f1b1788b6acf885367-20260827
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2024199454; Thu, 27 Aug 2026 15:22:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 15:22:45 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 15:22:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBdIQnYmvg1wfDFJzauUYHcXwe/O8KUYsIPyK8/8EGlTM7xg3bEQ/5D1TxJT0hmpE03NjZXKwpOwmWZOr+qlXM1/IC4by3LU7YaHfZtaptI6l9MFy3esYHtaJQS2YfPglfiHx6BfP7E4//wxICNE5eNx4fIKjokrbG6GYeevnQwdDWf9giA67HZyIVIJ/S+dEbx3MdDmNcWRDJN+Fu6BqExCCaHmx5Ot/z7PvzmJtcnxjLCeyjv28u/vLy6tHXBpstSQRgvPgY5n8SgiU5J6M4igqruDCcd2ooZcpLfcCaK9F8myNYmmkbZBoJ1ADoTOnKN7ieB7n/8hLMhjh8oo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvhpzmw0HO0k3cBAsvHxqQDqA8gpTqhDnPOlwYZU0Gw=;
 b=xvp2wSqdYFz/NRYC4xWiNw4dJtLL3thy+wZQ/w1y0iSJ4gr9pEF8c3/sRKS+HuIdytP0IUAHH55Y6X7aBhFs5XqjomaGJtnT4rdKpW/r2x3KbzBVAerzIMbobTYFeWCWotGjcmI53zvmNaTQOlY1aPsMuHTSLamOoH8gE1KIIUyPVRF4z4i3vulSwy/AIl2qFJHoy6cL+yYkLX8iaxM8538lL3TaHA9KycGSl4lrYp59oYwYaMMMtr7kFeJs9olw2l+qey10xZRr86mST+UnE3N9WahK3ebKKJDAi65kPYGMCmeNZFRE4r3bPD/ZcQRVF9Pul+Xyp7XEk9N28wrrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvhpzmw0HO0k3cBAsvHxqQDqA8gpTqhDnPOlwYZU0Gw=;
 b=HHwC4nKJ+q7mbIKFG1L9z83P0RdFnOxGPgrT9OfzCM6/gtsCMUotdzl2D65S7nGCocIC4ssT7LZvKTVMGM50qC9jzBHc9gAxXrlnEG+dReXScqslADmiPYr6YAXUWi/b+Ow7RpahgcOP9Nor3tTHgxuT0BSd1RXfoBkoccLT0TQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:22:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:22:42 +0000
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
Subject: Re: [PATCH v4 04/12] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
Thread-Topic: [PATCH v4 04/12] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
Thread-Index: AQHdD5as9lnz2ceHaUuezTo9MSBQi7axyoOA
Date: Thu, 27 Aug 2026 07:22:41 +0000
Message-ID: <fb8e444ce71ea3e0dcd66724181cc05c242024a2.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-5-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8233:EE_
x-ms-office365-filtering-correlation-id: 7ff21b05-93aa-4286-65b6-08df040bfb74
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|42112799006|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: vBi3YFzCpCSQUyaQ1YZL9de1cbsF69+yR3V9NmTw+PPaJNk2M69wLtMG+SJBRFnCsyCNjWvOLzeZluwrT+dstAapaolagg6CCofDzbUWJybjRgwCiRWOlqIqhDVNL1dRMSquOrWpFU4bJ+LMFPGhf0avhHmdp/Ujd2muQO6MkBr19LYvjHIP0C9dq7lBL3/XC89PmAjc40v1a1XBWF0Oh38LkFsM89kHWddFePPhhemYshXOztsXYVxJBUriLgpT7xWwhC/7j8a5urBqU7AcVW08x2/5N7MXu1pDZoVXvcaeGpqNfFK0m0MiYyIG8sJyPfMsML+C3CR/CtXBHKDKvNDlPZ89y8079I/Z90Mb96ONOw1YsK8ea8L3A0BCU40ckQNssPDjdCOtfa4DcoCFEyjLni5xIKNVLO/maqcw19cnvH15iyhr1V+/lOlj0InBeASQHE4Iofah8vuTgX4UGxMsjE9QcoCv+rMCMYkbHH0osUxThUSqKhhgV6J2GJ8Ahc8HY65aAU8rwrGuTerkQQVxByXKE6VNO1bztCGx4DTvsXElful1OSaFmjad+ovaLykQmGZv16mfMLYA5ChRvJ4zBbhni/CiXP7yTOMRtWlAEK8AjiyPPWbj1dqVC5vH1v/ebMSg8b3SRbK9tc5n+gXqxS48JiXjGdjXAFHgdJ0Y6C67N+Sw1W4N2yjQnTjoqGOyJ+xEnuZxOEIWFqQ9N8rHFB87dcS5Cn6J5+kkTj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(42112799006)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXljL1kwM1VsUXNZUGorbGNEdjE5TUx4UFgzVlN2SGtFYlZoZnNZSWJxQktn?=
 =?utf-8?B?OFE1dUcvd2Rub0pYcGIxU3AwQWRFL2hzMmxoQVc2TFl1bkErL2VreC9vSGM1?=
 =?utf-8?B?eEhaYm5uVExYRVBCL29KYkN3VjFoWXNXcmx5a0ZYVFAweFFrYThKMlFJYjhl?=
 =?utf-8?B?OGJCOG4xNEdwQzNlWmRnbjAwS0gzaDE5TitJVmFiNXZ6UmtuOGlGZElNK25s?=
 =?utf-8?B?Z2F0aFB0NnJpMjN6SHhjWGV4MExoNnhEaUxXVjNUSEFqaHdWTWVlVC82NDA3?=
 =?utf-8?B?emloTFJ1MGtnbHJaUXF6ODVzQ0NHUEpwUTFHSWVyL1NKOC9TQ0k4eEFCNWdG?=
 =?utf-8?B?d1BJTHRqMmJ1UWRUVHc2b3VxTSthbTFIdHM3Yjc4VG43djNMb0lnY2RvMjEv?=
 =?utf-8?B?ZXRHY05CK1RBNkF4RGVJMG9aNll4VmQwUUJWQzQwR0NMTmdzQjVTa0pVK0tx?=
 =?utf-8?B?cjZVQXpGNFl3R3hTeHhXemlhU1A0ZkpoYTcrU2pHcmQvU0licmpwSWpsZEdZ?=
 =?utf-8?B?eVdlT0FteGg0SHljTWFmcWJ6Nm9LWkFRemM2TUxFOWdMTTRFNFV1SVMrVFV0?=
 =?utf-8?B?MTdHSFp2TWNwUnVoUkRNYmV6aTlVcnJQaG5Mc01Yd0k1ZnpHY1Q0bU1FSFNz?=
 =?utf-8?B?YXRZdGVDRm5nNHhEclRtYkl4dXo2c2dxYll6OHlqc2IxY3ZMQmF2MEMyWnB4?=
 =?utf-8?B?Uk00czVZQ0RKY2M3OHgxaWdibFNDVWdMREUrSjJ4NUltT3pnak9YVERzVG95?=
 =?utf-8?B?YldFSWNSZXdNZVJFMHVQTm1VeHpaRTY0Sk41Vi9NenBFbkJqcmU3V3dkSW4y?=
 =?utf-8?B?b3FRR3p5VENXdUJlamFUcGNLYmlMUUVNS2FQWCs4bzk2R3RFbnRBenpnSlFC?=
 =?utf-8?B?ZWZPc2JTaWVSQS9NM0xKOUo5Q05sYTZnT2llVVpwZjZqd2FXTmR6VWJ0aytI?=
 =?utf-8?B?SWVibzB5ZStXVXJSUDk0d3hHb2lQK2RZVTNCTDFnWXd5M1VBekgwVlhudEZG?=
 =?utf-8?B?OExyZUFPTWxpQUEvTTlsQXRmRzRQa2NUaGJ1VWdiNWVjOVlHRmVQamRPWGJL?=
 =?utf-8?B?S2lWWTVRenlBMEJmTlRzTW03TmRFUXNnV3ZMakZlUEV6ZjB5MUo4UFNLS09n?=
 =?utf-8?B?ZmpHenNjaHNKb3lodHNxWGZFVUU0OXo4KzhtTGFsNWUzYm9MNitFNkMvWUFX?=
 =?utf-8?B?VjF5elFmMENYRU9KT0RLNHEwSkg5VFpSUzNZK0ZwcHNNRjdCNnhpQlBtTk1l?=
 =?utf-8?B?S0FhdmxKTjBYeHREOFJHSVJvbUQ4VUh3cHp0WUp2NXNtd29TZWVvKzN4dG5Z?=
 =?utf-8?B?ejRFcEVYNXhpU3FIMTdkRnZuaVJUUCtDTlVnUTFZbm5PRFY2Wktsd3pkSVBa?=
 =?utf-8?B?Zmw1Q1dzelQ5eVJlYlB0em1nY0x0eVU1V24wbm9MT2ZUcEFFU0J5c05Camk1?=
 =?utf-8?B?bDAydExnM08xbUQxM0IzRE9ZWWJ2VTh4UUwrTzBVU0wxeEg3RlQ1czIwbFcz?=
 =?utf-8?B?NEh2RitrZTZtaGR1MFdWSnQvbTUwVlRVUnFuMlVkTGNQcTl2djZUVWVxSmJR?=
 =?utf-8?B?Q3pIMEw2SFIrTjJOWUdSaG1tN3Vycm5XZlVoTkxiTEd2QUdaSTY5ekJoSmc5?=
 =?utf-8?B?NXZvNW5wQnVFNFE2NkVUSVJwRGxEdE0rR0x0RVdxZUYvbjZoajg2N2ZnaVM0?=
 =?utf-8?B?c2cxOHdIT2ViSVdwdUFlNHN5djNROWczSkF4NzhEbDhSMkNTSSsxN0xTSGhJ?=
 =?utf-8?B?TU8yNGpaOEJBUnN2Y1Z5NFV1TE9xdzZFT29XSkllM241emhyTUJ0dWc0QkRH?=
 =?utf-8?B?bTZsRUM4U1ZydFYxUVlHOTN3M2E5RjU3bEhPYU5UZmhyOHJiTzVTemJXdWZU?=
 =?utf-8?B?clNtaEV6ZDhzYUxacFZHMlpCRSttSFJiVkVYYUVYbnJmSVlKVnBRNnZOOXUr?=
 =?utf-8?B?Tks3RkpIbXlabWxnZU9icXprTHpudENlVFh2MUVJcFFUM09ENzhOSHI4ZHRD?=
 =?utf-8?B?eWR4VjJ1dWNjaEpkWEFYdEdFUkUvWHBpblhqUU03elRNNnhYV2Nkbml4T3lI?=
 =?utf-8?B?NGQ1Um1jekJxYURSdHkrV3lFSGZyOUhhZ21YQ2tzc2pWZ1BlWVo1aUc2ZFVR?=
 =?utf-8?B?VTdFUHBoMkhyem9OOVgzTldWdnZWZkZkcXp6YWxCdG1pSWdCcUxGT1c0Y1NP?=
 =?utf-8?B?NkJBeUoyUWVoS3hhbDFwU0JpdTBUSnpRZll4Qi85Nzk4SXZvOUozWnY2bGFN?=
 =?utf-8?B?d1NwaVN0TnczRzlTa3JUQ1JkTzN5Z2p1M3hVT1pRMVprN0dXWVo5Ny83bkJH?=
 =?utf-8?B?NFMvSS9uZFJtWVRkbjZKSGIyMDg5M3pkOXBBalQ5ZUpTOFYyeHNrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4297DD5FA7BAA44917B1FD19588BDF7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0rYJ/ESU4dDoXaLWNqnbyB6OjuAiuTaV0rU/g8YUPLR/GzcDX1Qy50AUuwFI4NltkIu04n15dGThDGG1THlw/tKXk6yXplC9/GWFtPEx41L+sbqT/WhPQk2AR658I0CAxyLPtszw/rZnVGcixbUVjgYu+9/SbhXlBAN25oN6bNypIIx3pxdcQjfIFQDjxyWj59fxBYzk89PlbtXjjxCVEYSUh3FJjhTMIc7ksSanBp8Bi/gifx5C5fd0xa0sTuG3jryGMokzPj2Je5ek9INVl2cVaG56KlxTaLA24Ra403zYYc2rPCWbVpIsCWuGoUDu7NpkOBU9nGlKhtxh4Id9cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff21b05-93aa-4286-65b6-08df040bfb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 07:22:41.9615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B43vUJOz9WlKs5EClTrUs4c6UkIyscSyemkomrOcoc2eW6XxPb1Tf/CMjWT6rlTvrFHmgsQj6l9zsDLZo5pvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233
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
ZWdubyB3cm90ZToNCj4gRHVyaW5nIHByb2JlLCB0aGlzIGRyaXZlciBpcyByZWdpc3RlcmluZyB0
d28gcGxhdGZvcm0gZGV2aWNlczogb25lDQo+IGZvciB0aGUgSERNSSBDb2RlYyBkcml2ZXIgYW5k
IG9uZSBmb3IgdGhlIERpc3BsYXlQb3J0IFBIWSBkcml2ZXIuDQo+IA0KPiBJbiB0aGUgcHJvYmUg
ZnVuY3Rpb24sIG5vbmUgb2YgdGhlIGVycm9yIGNhc2VzIGFyZSB1bnJlZ2lzdGVyaW5nDQo+IGFu
eSBvZiB0aGUgdHdvIHBsYXRmb3JtIGRldmljZXMgYW5kIHRoaXMgbWF5IGNhdXNlIHJlZ2lzdHJh
dGlvbg0KPiBvZiBtdWx0aXBsZSBpbnN0YW5jZXMgb2YgdGhvc2UgaW4gY2FzZSB0aGlzIGRyaXZl
ciByZXR1cm5zIG9uZSBvcg0KPiBtb3JlIHByb2JlIGRlZmVycmFsKHMpIGluIHRoZSAid3Jvbmci
IHNwb3RzLg0KPiANCj4gSW4gb3JkZXIgdG8gZml4IHRoaXMsIGFkZCBkZXZtIGFjdGlvbnMgdG8g
dW5yZWdpc3RlciB0aG9zZSBhbmQNCj4gcmVtb3ZlIHRoZSBtYW51YWwgY2FsbHMgdG8gcGxhdGZv
cm1fZGV2aWNlX3VucmVnaXN0ZXIgaW4gdGhlDQo+IG10a19kcF9yZW1vdmUoKSBmdW5jdGlvbiwg
YXMgdGhvc2Ugd291bGQgb3RoZXJ3aXNlIGJlIHJlZHVuZGFudC4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiBlNzFhOGViYmUwODYgKCJk
cm0vbWVkaWF0ZWs6IGRwOiBBdWRpbyBzdXBwb3J0IGZvciBNVDgxOTUiKQ0KPiBGaXhlczogY2Fm
MmFlNDg2NzQyICgiZHJtL21lZGlhdGVrOiBkcDogQWRkIHN1cHBvcnQgZm9yIGVtYmVkZGVkIERp
c3BsYXlQb3J0IGF1eC1idXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0N
Cg0K
