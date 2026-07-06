Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B74C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73F310E2EB;
	Mon,  6 Jul 2026 07:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ukamR+hd";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rifNZItx";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24E10E2EB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:02:44 +0000 (UTC)
X-UUID: ad590e62790811f1b1788b6acf885367-20260706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=KNSE9nV4OFFOtQxPZL/CApmrpivDHoAimqfVKLdMVMk=; 
 b=ukamR+hdnD9oBGKtBEsXmvnWmU7XK55t2xEEjatqViNw9XbBV+l5w1HWetHM5z82v3OqrQFjAaZo4mAuudFzwwBV2fSGAs39bwHUbKqAp4giHHyx+RmKsdBd4lMfPsQjwV9KHatHqdce9vB91zQV5obTvqBb5GYFjdN9N5KFm68=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:b53bbb0a-2638-487f-8676-71a40dcba5d9, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:d5040d82-6310-4e6b-a6b1-aca20d98ed8b,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ad590e62790811f1b1788b6acf885367-20260706
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1233182623; Mon, 06 Jul 2026 15:02:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 6 Jul 2026 15:02:38 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 6 Jul 2026 15:02:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXGLCYUO4Sd0XWFlpS2XmbTFDd9EIckB6+vN93/t3qQX33LmOk9xY0C1ATDBLF4/klleDixRqix2kAd5avJt947cP/Ggwpy1GAWe2GhOhUNRAg5x44aT84gEuT3IMeRr1g1ZLopft8jt/yscf/my8DP/94y+YGUP61iA+mRlfrBiiQ+bTh7FUWkLSSJRhncGb/74npC3v7mQNGYzMXa1Thbr+ss9PWsvLDjRXKxLXGhgQttK5GOE4M/UJgHVsRVEL6RyYf6wcPFxfSJg3nzJnolrhIeJ+0Sp2xQNtXNfwUG/+Cd7tfbcrhEpX/CiZtGIFAv7PJYi24fdT9bJhMOx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNSE9nV4OFFOtQxPZL/CApmrpivDHoAimqfVKLdMVMk=;
 b=d2YUaM++H6dxZoYNTl4xzZShPTGG+sebvzqC7NAxeH8qWkztD5gvoFNuN45XGXSi+sMUehLFiXWZYeITJ+5lmEr7qyz/GcxmONTj2mqv/wmGDxT62j0Tr86hW8PWKRpDCLd9J477BDeFzf5VqR1IUmoaNJYcwgVwviw8IZ8d/Z5LfymEJwEgiHwujscpyr+br2ZsX7qbdLQKDX2UYUXr6lRgMdp/vdNyn2EpEvxQ7mjLm3lq58hjNRM1NnYLLuBKLzOzPemUOrGzdHmi6qvrh8vKWeLkHG2Gubc1uTUG0lahWfMr3ufeibANaU+2CLu7B6Vkq3MTWuAvaD99bPpxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNSE9nV4OFFOtQxPZL/CApmrpivDHoAimqfVKLdMVMk=;
 b=rifNZItxaSH6AWVNYxIQc/tk9zJBZtFWrW6bJfUORvJjoaOUn8MDJ7RdG6GjRb77KPePyE5uUnB5mmdwraeSpBSOx1WIeHKgTQkPRNCQx5lVij6VFD63+FVaz/TV8zfeWp/Avu6c1nsECeyg6m1BtOQCh5UPBhtRQfJOeqTtJjs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7227.apcprd03.prod.outlook.com (2603:1096:400:33e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 07:02:34 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 07:02:34 +0000
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
Subject: Re: [PATCH 06/42] drm/mediatek: Use hashtable for components
 discovery and registration
Thread-Topic: [PATCH 06/42] drm/mediatek: Use hashtable for components
 discovery and registration
Thread-Index: AQHdCVQy2c8zLdxbQ0WebTiesDICtLZgGC2A
Date: Mon, 6 Jul 2026 07:02:33 +0000
Message-ID: <79f44c827c78fd823300509c22058f2b6f3600b6.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-7-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7227:EE_
x-ms-office365-filtering-correlation-id: 82ba4b03-932d-4be4-d99e-08dedb2c8dff
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|7416014|366016|1800799024|376014|23010399003|38070700021|3023799007|18002099003|56012099006|11063799006|4143699003|22082099003;
x-microsoft-antispam-message-info: IF5FyTbtGhQnl+PoKi5EYk6Bsy8JdewpLsTW9ivg4P64Nzd39PKYxxB+143QgzoHsgiU+pwSM/0O3fQIioCs6HIBBD8UAGJcDtxbhJ+S+0tJXFsfixTSgtvpUlPVWgfPAEq+vnkGkh9SaQaIndj4VpRjJMPIXqaYuSD5hqAAdPhWwXBh9l0Ip/q3Nnw6PLaoxSNzOBcCtbVof906l1ZwZVl0BAL0xATUn8n2cYMerE/Rqy2mHg1tsrORkuojzdPs2R5L5lQ5bLurCaQpP1Vwui9D9kLDnLKluP7QaAKs1Ga8XVfQVnEU/skDt602FjgP6wBSYnLhuQUkw+izgOygkUmZW9p239nNg5sC/nNl/YXeyWBpdK9jrJHJXlnTNiFTsOWdSXKpl1Vg2XWHRuirLCLU4X/smWcFFSbr+oYwDedLkBsyVYe7DLm1r3tlYN0vOXn6oVTcptwbezHmVNJ7JnFXzasbchXmi0O3oKpqCEi6QmYybRTljHKwetvFWksw8qenstTT3mznQFJ+QGD3pz780MpWmfGcdXfDyszLp/eQEpqZ9H3J3cK5qeRXvvKy3vlx/131b3M9YcHnf+zphtPG6w957mQOH6lyExIzT2l1Gom0vqmJq1z+dLTG1zjZEMCQA5eTLMGnnzQVqd9kPHyCimlRb5fI4whg8G7g45UlBqynqHCgz3M7OZqHV1SYMb3G8xkPg+8zikunpkBCIkCQfSgTRsmh8ECMYUHRtwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(366016)(1800799024)(376014)(23010399003)(38070700021)(3023799007)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFUL1FISnRBM0Y0QXZ2WUt6TW9qbUxEZFc0bndZVlVqUjFSQjAvVG5LTnpt?=
 =?utf-8?B?ZWsxRG9uQWpKNk1Cc3p3Z1lWV1ZZaXdvS2JSa1RLSjM1MVNySWZPTHV5d2Ns?=
 =?utf-8?B?K1poUzhHNStWc2FydDZqSWpDZHJNUStpNHRPNXdiSVRVcmlRQXd4VE1nQVVX?=
 =?utf-8?B?NHQ4Q3BlOHZWeGkvSTVUbk9TRFFBSW1HanV4S1FwSlJiYWdhV2JZQ2lPNEFR?=
 =?utf-8?B?dmV1bE5SK0dtOVlFSWZFRlVubmNhcS9jc3p0S21aNVI1UlZJc0RFZGJVYmFo?=
 =?utf-8?B?TDVoZUxIMEh1eXNmOUpRMk1YdC94cm1ZejBsN1o1VDJIV1hsckdKVHF0aDlp?=
 =?utf-8?B?ZWVNUjUyTUZTUlRncXZSZ0dUUStNVjNaWEFiWkdTUzI3dW96MjI1TFFJNlQx?=
 =?utf-8?B?bnFSN1RaSVFhMHhWbFViVXZXMjUrWlkyWWVmSTEvbDBCNjkyaXJxb0hWSFRW?=
 =?utf-8?B?dk0wMExjbWlkMkFJZVdDNCt0a3VQakN5Ky9QSXRIYnF2empicE10SnRQZEhp?=
 =?utf-8?B?M1kxVjlzQUNqME9JeGNaSncxTFA1RFQwMnBLay94QjMwWXlRN0xVM1dxSVRm?=
 =?utf-8?B?UU1uYnFWVnpwVEdxRlYySHRKTlRxTU40MmVHaUZjLzR3bTg1OXpCcUM3M05u?=
 =?utf-8?B?OGdMczltQXZiZnBjTnpzTCtMQWl2TlM2Q0Y1ZXJTRGVpRmlaS2txdlZra3dM?=
 =?utf-8?B?eFlBRWVYMThKQlZnemJnSHpEMFoyaVpySFdjaXlXbWFBRTlmVXlLV1N0MUky?=
 =?utf-8?B?dS9tV001NExpKzhUVDJkTjE4SVorUU9wWU9MZlpPcFNPRlJwRGd4L0xmVG1N?=
 =?utf-8?B?Ui85NEJDOHowMzZBUmF5ZTEvVFdqbnZzaDlHMTE1SGdBdDJOSFR4bVNid1Rh?=
 =?utf-8?B?am5oVGtWcFU1cXUvb3c5R0NpbXlZNHFsZkx4UWF6YTBTaFRjdHJLeThSZk9B?=
 =?utf-8?B?NHNUWkRNODE3cFFabFNvMC81ZWRiQ2s0ODhhVmVrZmU4aEpZbUZOT21rSlpR?=
 =?utf-8?B?Y2tJNG5UbUpDTDVKTC9qQWFNWTQwb3RHUkpHTHlIa2dIZTN3YnhBWFpPblB0?=
 =?utf-8?B?Z1dNRDlYUm55MzJHZFhpUUhrMUk1UTM3VmFqamtYekJYUnMzamkvQmU3eHpi?=
 =?utf-8?B?b042d2M1aGdLREdhK3ZtMUZDRERLbzBGUnpBTjFpbWV1MTlCRkFWVkFTVGhy?=
 =?utf-8?B?bEdJWFc1TldsbkJDTmtGSFl4TG9OeSsrOTdTU01RR0JpNUx4L0hhbll6QXJs?=
 =?utf-8?B?d2VwdkdiaENURGNMdDFwS09uc3Nqd0hmQ0ZxYXMveEhLVmpmd2RnZ1ZETGV4?=
 =?utf-8?B?TWd6emNnMms1RGFoeVpzQmpueWlLZmZzSHJyYmZhTG5ucVY0SjZjR2NOMEw5?=
 =?utf-8?B?bUF6Mjlkbnlodmh4NStXUXFicXcyRUNkMitnV3lSb0psOGxEakozdlRHKzhW?=
 =?utf-8?B?R0NrRmsrbEE4SENlM0FlaVNUd1FXUzNFSGFCb1ZId01iVTVQTFBuT0UrNU5l?=
 =?utf-8?B?ZktLUWdEZUZSNkJ0dVVYWGl2M3owdm5sbm9UWGxKZkxsekp2OVVxeXZMYW9K?=
 =?utf-8?B?QUFHQ2pZd1BWMnFaVmtMNHZCUUtFU1BYNkFJeHhrWXdnMHRKUXJqR2grT2RK?=
 =?utf-8?B?alNDN2sxTnN3TU9RU3YvbU1CNjNJM2NjaDVTei9DSmlET0JGbUFKbENEUG11?=
 =?utf-8?B?bnlBZlVYd1lEZVVvUEp6UkdxaW9sUGEvVTExdFJ3YkYxbjB0RG5FT1lWTm01?=
 =?utf-8?B?YUJiWFZXTVZzd2xhSWhuRnJTOHVMVld3QlhPOEVHbE9jdUltbUgwTDcvR0Fh?=
 =?utf-8?B?Ui9hWlhQUXF2RkZJaUNrK3I1M2RybmdQaHJrWEUzMWNzVWxZaGkrd0JtLzZJ?=
 =?utf-8?B?LzZtQ0YycXpLZEFyQVVKS25qNElmWXdtelJXVTVkUlhRLzlUMzNsbk1kNjFM?=
 =?utf-8?B?UGNidllGeURCOERrZklnWVVzckd6ZktReTRJOWViSVd4ZGt6SkJ2WVVVMWZS?=
 =?utf-8?B?OUJVL1JhRnVKYklXa3FIOUpxSWVydU94cHdGNmlZUjlMZUx5TnlqRWJBZlBH?=
 =?utf-8?B?ZEQ0M2plZVp3M1hNQldKVHBOSFdpS0ZvSkVxVHRRVzUzWnVMdktyWHJVczJY?=
 =?utf-8?B?cjE0S2pTNWEzRFlmd0R0RlRhRkVqYkpKNm9LSk1XQi9rRGp5M3FMdEU5UFRw?=
 =?utf-8?B?ME9vWVA4VDU4RWQxek5OUzJUSlBIM0tTUXdJR1V0RnV4WVRzUGk1S1lVRmpo?=
 =?utf-8?B?d2h1NERGWDNSYU9HdWVuaENpRUtBdlZrWXVpNUpseVRFTjNTOURVOEk5dkg1?=
 =?utf-8?B?UTNqMzBuQWJpbzVvNC9GeWRmNkp6amtlUk80QkY0V2ZmdXZGekxqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E1467C74A37D045B9003544662EEDD6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kLc2e8qfB5cqSSK4+y/OeTEdEKjuthwYjZySTGcvpP55rHZnda3TZH2hblfu7JFq9MQquZbHu8NDNogeQkgtVvFjHdUxx2OU3YgtF9PGWN9hElPN5VZhU9rqFbUh2Djrle8RolJwgvtuzfrjoHXd4Fsb7p5HFfQqcwzmVlHDj1SZaVawSqOir2MEVJd/V90f198tE7ECdHXFzp0Cc3YdDwoR6xTUcAonypviqqICSU0mNWoG4Nrk80FeXw1ZCJt4f0T+1xmqMvCABQFuybZseXnmnximYZMfyrG3tPvRWF7UE9/rjQAjlvwAjxJmk3kdM/TkLxB0t6wX1xd5LVxyiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ba4b03-932d-4be4-d99e-08dedb2c8dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 07:02:33.9789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSJ0dQpzl4xKOtV9qauJD0pjT0/GQizV2ymJaghYLAxJ4zsFCQqPnaxmsNiMhsBelntRV3TO1fS0JDGbxtibtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7227
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

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE0OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgYSBwcmVwYXJhdGlvbiBmb3IgcmVmYWN0b3JpbmcgdGhlIGNvbmNl
cHQgb2YgaGFyZHdhcmUgY29tcG9uZW50DQo+IGlkZW50aWZpY2F0aW9uLCBzZWFyY2gsIGFuZCBm
aW5hbCB1c2FnZSwgcmVtb3ZlIHRoZSBkZHBfY29tcCBhcnJheQ0KPiBvZiBjb21wb25lbnRzIGFu
ZCByZXBsYWNlIGl0IHdpdGggYSBoYXNodGFibGUsIGluZGV4ZWQgYnkgSUQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfY3J0Yy5jICAgICB8IDQ0ICsrKysrKysrKysrKysrKystLS0tLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMgfCA0OCArKysrKysrKysrKysrKysrKyst
LS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfCAyMyAr
KysrKysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICB8
ICA3ICsrLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oICB8ICAy
ICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5j
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gaW5kZXggZjM5ZjE5NzA1
N2E3Li4zZjRkNmFiMWJmYzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5j
DQo+IEBAIC03MjUsOCArNzI1LDEyIEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX3VwZGF0ZV9vdXRw
dXQoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiAgCQljcnRjX3N0YXRlLT5jb25uZWN0b3JzX2No
YW5nZWQsIGVuY29kZXJfbWFzaywgY3J0Y19pbmRleCk7DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBp
IDwgbXRrX2NydGMtPm51bV9jb25uX3JvdXRlczsgaSsrKSB7DQo+IC0JCXVuc2lnbmVkIGludCBj
b21wX2lkID0gbXRrX2NydGMtPmNvbm5fcm91dGVzW2ldLnJvdXRlX2RkcDsNCj4gLQkJc3RydWN0
IG10a19kZHBfY29tcCAqY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21wX2lkXTsNCj4gKwkJY29u
c3Qgc3RydWN0IG10a19kcm1fcm91dGUgKmNvbm5fcm91dGUgPSAmbXRrX2NydGMtPmNvbm5fcm91
dGVzW2ldOw0KPiArCQlzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wOw0KPiArDQo+ICsJCWNvbXAg
PSBtdGtfZGRwX2NvbXBfZmluZF9ieV9pZCgmcHJpdi0+aGxpc3QsIGNvbm5fcm91dGUtPnJvdXRl
X2RkcCk7DQoNCkkgZG9uJ3Qga25vdyB3aHkgeW91IGludmVudCBjb25uX3JvdXRlPyBLZWVwIGNv
bXBfaWQgdXNlIGl0IGhlcmUgbG9va3MgdGhlIHNhbWUuDQoNCj4gKwkJaWYgKCFjb21wKQ0KPiAr
CQkJY29udGludWU7DQoNCkluIG9yaWdpbmFsIGNvZGUsIGl0IG5ldmVyIGNoZWNrIGNvbXAgaXMg
bnVsbCBvciBub3QuDQpJIHRoaW5rIGl0IGJhc2Ugb24gYW4gYXNzdW1wdGlvbiB0aGF0IGl0IHdv
dWxkIG5vdCBiZSBudWxsLg0KSWYgaXQncyBudWxsIGhlcmUsIHByaW50IGVycm9yIG1lc3NhZ2Ug
YW5kIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBkbyB0aGUgcmVzdCB0aGluZy4NCg0KPiAgDQo+ICAJ
CWlmIChjb21wLT5lbmNvZGVyX2luZGV4ID49IDAgJiYNCj4gIAkJICAgIChlbmNvZGVyX21hc2sg
JiBCSVQoY29tcC0+ZW5jb2Rlcl9pbmRleCkpKSB7DQo+IEBAIC0xMDI4LDEwICsxMDMyLDExIEBA
IGludCBtdGtfY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYsIGNvbnN0IHVu
c2lnbmVkIGludCAqcGF0aCwNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RybV9wcml2YXRlICpwcml2
ID0gZHJtX2Rldi0+ZGV2X3ByaXZhdGU7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gZHJtX2Rl
di0+ZGV2Ow0KPiArCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmRtYV9jb21wOw0KPiAgCXN0cnVjdCBt
dGtfY3J0YyAqbXRrX2NydGM7DQo+ICAJdW5zaWduZWQgaW50IG51bV9jb21wX3BsYW5lcyA9IDA7
DQo+ICAJaW50IHJldDsNCj4gLQlpbnQgaTsNCj4gKwlpbnQgaSwgajsNCj4gIAlib29sIGhhc19j
dG0gPSBmYWxzZTsNCj4gIAl1aW50IGdhbW1hX2x1dF9zaXplID0gMDsNCj4gIAlzdHJ1Y3QgZHJt
X2NydGMgKnRtcDsNCj4gQEAgLTEwNTEsNyArMTA1Niw3IEBAIGludCBtdGtfY3J0Y19jcmVhdGUo
c3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYsIGNvbnN0IHVuc2lnbmVkIGludCAqcGF0aCwNCj4g
IAkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcDsNCj4gIA0KPiAgCQlub2RlID0gcHJpdi0+Y29t
cF9ub2RlW2NvbXBfaWRdOw0KPiAtCQljb21wID0gJnByaXYtPmRkcF9jb21wW2NvbXBfaWRdOw0K
PiArCQljb21wID0gbXRrX2RkcF9jb21wX2ZpbmRfYnlfaWQoJnByaXYtPmhsaXN0LCBjb21wX2lk
KTsNCj4gIA0KPiAgCQkvKiBOb3QgYWxsIGRybSBjb21wb25lbnRzIGhhdmUgYSBEVFMgZGV2aWNl
IG5vZGUsIHN1Y2ggYXMgb3ZsX2FkYXB0b3IsDQo+ICAJCSAqIHdoaWNoIGlzIHRoZSBkcm0gYnJp
bmcgdXAgc3ViIGRyaXZlcg0KPiBAQCAtMTA2Myw3ICsxMDY4LDcgQEAgaW50IG10a19jcnRjX2Ny
ZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwgY29uc3QgdW5zaWduZWQgaW50ICpwYXRo
LA0KPiAgCQkJcmV0dXJuIDA7DQo+ICAJCX0NCj4gIA0KPiAtCQlpZiAoIWNvbXAtPmRldikgew0K
PiArCQlpZiAoIWNvbXAgfHwgIWNvbXAtPmRldikgew0KPiAgCQkJZGV2X2VycihkZXYsICJDb21w
b25lbnQgJXBPRiBub3QgaW5pdGlhbGl6ZWRcbiIsIG5vZGUpOw0KDQpJIHRoaW5rIHlvdSBzaG91
bGQgcHJpbnQgb3RoZXIgZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJuIG90aGVyIHZhbHVlIGZvciAh
Y29tcC4NCg0KPiAgCQkJcmV0dXJuIC1FTk9ERVY7DQo+ICAJCX0NCj4gQEAgLTEwODksMTIgKzEw
OTQsMTcgQEAgaW50IG10a19jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2Rldiwg
Y29uc3QgdW5zaWduZWQgaW50ICpwYXRoLA0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gIA0K
PiAtCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0KPiArCWZv
ciAoaSA9IDAsIGogPSAwOyBpIDwgbXRrX2NydGMtPmRkcF9jb21wX25yOyBpKyssIGorKykgew0K
PiAgCQl1bnNpZ25lZCBpbnQgY29tcF9pZCA9IHBhdGhbaV07DQo+ICAJCXN0cnVjdCBtdGtfZGRw
X2NvbXAgKmNvbXA7DQo+ICANCj4gLQkJY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21wX2lkXTsN
Cj4gLQkJbXRrX2NydGMtPmRkcF9jb21wW2ldID0gY29tcDsNCj4gKwkJY29tcCA9IG10a19kZHBf
Y29tcF9maW5kX2J5X2lkKCZwcml2LT5obGlzdCwgY29tcF9pZCk7DQo+ICsJCWlmICghY29tcCkg
ew0KDQpJbiBvcmlnaW5hbCBjb2RlLCBpdCBuZXZlciBjaGVjayBjb21wIGlzIG51bGwgb3Igbm90
Lg0KSSB0aGluayBpdCBiYXNlIG9uIGFuIGFzc3VtcHRpb24gdGhhdCBpdCB3b3VsZCBub3QgYmUg
bnVsbC4NCklmIGl0J3MgbnVsbCBoZXJlLCBwcmludCBlcnJvciBtZXNzYWdlIGFuZCBpdCdzIG5v
dCBuZWNlc3NhcnkgdG8gZG8gdGhlIHJlc3QgdGhpbmcuDQoNCj4gKwkJCWotLTsNCj4gKwkJCWRl
dl9kYmcoZGV2LCAiQ2Fubm90IGZpbmQgY29tcG9uZW50ICVkLlxuIiwgY29tcF9pZCk7DQo+ICsJ
CQljb250aW51ZTsNCj4gKwkJfQ0KPiArCQltdGtfY3J0Yy0+ZGRwX2NvbXBbal0gPSBjb21wOw0K
PiAgDQo+ICAJCWlmIChjb21wLT5mdW5jcykgew0KPiAgCQkJaWYgKGNvbXAtPmZ1bmNzLT5nYW1t
YV9zZXQgJiYgY29tcC0+ZnVuY3MtPmdhbW1hX2dldF9sdXRfc2l6ZSkgew0KPiBAQCAtMTEzMSw3
ICsxMTQxLDE0IEBAIGludCBtdGtfY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRybV9k
ZXYsIGNvbnN0IHVuc2lnbmVkIGludCAqcGF0aCwNCj4gIAkgKiBJbiB0aGUgY2FzZSBvZiBvdmxf
YWRhcHRvciBzdWIgZHJpdmVyLCBpdCBuZWVkcyB0byB1c2UgdGhlDQo+ICAJICogZG1hX2Rldl9n
ZXQgZnVuY3Rpb24gdG8gZ2V0IHJlcHJlc2VudGF0aXZlIGRtYSBkZXYuDQo+ICAJICovDQo+IC0J
bXRrX2NydGMtPmRtYV9kZXYgPSBtdGtfZGRwX2NvbXBfZG1hX2Rldl9nZXQoJnByaXYtPmRkcF9j
b21wW3BhdGhbMF1dKTsNCj4gKwlkbWFfY29tcCA9IG10a19kZHBfY29tcF9maW5kX2J5X2lkKCZw
cml2LT5obGlzdCwgcGF0aFswXSk7DQo+ICsJaWYgKGRtYV9jb21wID09IE5VTEwpIHsNCg0KaWYg
KCFkbWFfY29tcCkgaXMgbW9yZSBzaW1wbGUuDQoNCj4gKwkJZGV2X2VycihkZXYsICJDb3VsZCBu
b3QgZmluZCBhcHByb3ByaWF0ZSBETUEgZGV2aWNlIVxuIik7DQo+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiArCX0NCj4gKw0KPiArCW10a19jcnRjLT5kbWFfZGV2ID0gbXRrX2RkcF9jb21wX2RtYV9k
ZXZfZ2V0KGRtYV9jb21wKTsNCj4gKwlkZXZfZGJnKGRldiwgIlVzaW5nIERNQSBkZXZpY2UgJXBP
RlxuIiwgbXRrX2NydGMtPmRtYV9kZXYtPm9mX25vZGUpOw0KPiAgDQo+ICAJcmV0ID0gbXRrX2Ny
dGNfaW5pdChkcm1fZGV2LCBtdGtfY3J0YywgY3J0Y19pKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4g
QEAgLTExODgsMTcgKzEyMDUsMTggQEAgaW50IG10a19jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2Rl
dmljZSAqZHJtX2RldiwgY29uc3QgdW5zaWduZWQgaW50ICpwYXRoLA0KPiAgCQlmb3IgKGkgPSAw
OyBpIDwgbnVtX2Nvbm5fcm91dGVzOyBpKyspIHsNCj4gIAkJCXVuc2lnbmVkIGludCBjb21wX2lk
ID0gY29ubl9yb3V0ZXNbaV0ucm91dGVfZGRwOw0KPiAgCQkJc3RydWN0IGRldmljZV9ub2RlICpu
b2RlID0gcHJpdi0+Y29tcF9ub2RlW2NvbXBfaWRdOw0KPiAtCQkJc3RydWN0IG10a19kZHBfY29t
cCAqY29tcCA9ICZwcml2LT5kZHBfY29tcFtjb21wX2lkXTsNCj4gKwkJCXN0cnVjdCBtdGtfZGRw
X2NvbXAgKmNvbXAgPSBtdGtfZGRwX2NvbXBfZmluZF9ieV9pZCgmcHJpdi0+aGxpc3QsIGNvbXBf
aWQpOw0KPiAgDQo+IC0JCQlpZiAoIWNvbXAtPmRldikgew0KPiArCQkJaWYgKCFjb21wIHx8ICFj
b21wLT5kZXYpIHsNCg0KSW4gb3JpZ2luYWwgY29kZSwgaXQgbmV2ZXIgY2hlY2sgY29tcCBpcyBu
dWxsIG9yIG5vdC4NCkkgdGhpbmsgaXQgYmFzZSBvbiBhbiBhc3N1bXB0aW9uIHRoYXQgaXQgd291
bGQgbm90IGJlIG51bGwuDQpJZiBpdCdzIG51bGwgaGVyZSwgcHJpbnQgZXJyb3IgbWVzc2FnZSBh
bmQgaXQncyBub3QgbmVjZXNzYXJ5IHRvIGRvIHRoZSByZXN0IHRoaW5nLg0KDQo+ICAJCQkJZGV2
X2RiZyhkZXYsICJjb21wX2lkOiVkLCBDb21wb25lbnQgJXBPRiBub3QgaW5pdGlhbGl6ZWRcbiIs
DQo+ICAJCQkJCWNvbXBfaWQsIG5vZGUpOw0KPiAgCQkJCS8qIG1hcmsgZW5jb2Rlcl9pbmRleCB0
byAtMSwgaWYgcm91dGUgY29tcCBkZXZpY2UgaXMgbm90IGVuYWJsZWQgKi8NCj4gLQkJCQljb21w
LT5lbmNvZGVyX2luZGV4ID0gLTE7DQo+ICsJCQkJaWYgKGNvbXApDQo+ICsJCQkJCWNvbXAtPmVu
Y29kZXJfaW5kZXggPSAtMTsNCj4gIAkJCQljb250aW51ZTsNCj4gIAkJCX0NCj4gIA0KPiAtCQkJ
bXRrX2RkcF9jb21wX2VuY29kZXJfaW5kZXhfc2V0KCZwcml2LT5kZHBfY29tcFtjb21wX2lkXSk7
DQo+ICsJCQltdGtfZGRwX2NvbXBfZW5jb2Rlcl9pbmRleF9zZXQoY29tcCk7DQo+IMKgDQo+IA0K
DQpbc25pcF0NCg0KPiAJCX0NCj4gIEBAIC0xMTE2LDggKzExMTgsNyBAQCBzdGF0aWMgaW50IG10
a19kcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCQkJCQkgICAg
UExBVEZPUk1fREVWSURfQVVUTywNCj4gIAkJCQkJCQkgICAgKHZvaWQgKilwcml2YXRlLT5tbXN5
c19kZXYsDQo+ICAJCQkJCQkJICAgIHNpemVvZigqcHJpdmF0ZS0+bW1zeXNfZGV2KSk7DQo+IC0J
CXByaXZhdGUtPmRkcF9jb21wW0REUF9DT01QT05FTlRfRFJNX09WTF9BREFQVE9SXS5kZXYgPSAm
b3ZsX2FkYXB0b3ItPmRldjsNCj4gLQkJbXRrX2RkcF9jb21wX2luaXQoZGV2LCBOVUxMLCAmcHJp
dmF0ZS0+ZGRwX2NvbXBbRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1JdLA0KPiArCQltdGtf
ZGRwX2NvbXBfaW5pdCgmb3ZsX2FkYXB0b3ItPmRldiwgTlVMTCwgJnByaXZhdGUtPmhsaXN0LA0K
DQptdGtfZGRwX2NvbXBfaW5pdChkZXYsIE5VTEwsICZwcml2YXRlLT5obGlzdCwNCg0KUmVnYXJk
cywNCkNLDQoNCj4gIAkJCQkgIEREUF9DT01QT05FTlRfRFJNX09WTF9BREFQVE9SKTsNCj4gIAkJ
Y29tcG9uZW50X21hdGNoX2FkZChkZXYsICZtYXRjaCwgY29tcGFyZV9kZXYsICZvdmxfYWRhcHRv
ci0+ZGV2KTsNCj4gIAl9DQo+IA0KDQo=
