Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE8606A333
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HHyEkdmY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13205112C7E;
	Fri,  6 Nov 2026 09:19:24 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19013087.outbound.protection.outlook.com [52.103.43.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6013110E114;
 Fri,  6 Nov 2026 03:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJwCtVEWE53gjhEby0D23N1yQT7cyNlB5C5LdjsYI3cgEFt5Hc/88i/vThtSx1n3HBOKUuhWE7rbLf1SNcxAB+jcwuOk0tmLN9LNVeqkymIhdYdElj4E9nWH1P9DD3W2iy070k1R/3AcoF7cxqyT2Ui7oogOQv6dR19WnQINz9mUJkAYgjtCBIMVPx9r9AWaMbx/UCmld545uXnOHTgbF3FdfLspPzAmGMMHSLZszSiDEPSJczL3We0JcAKWus38HMSMJAZdiMTBdLfHydb4LAXYT6PJDL8HWUK3xDXWwonukQITfGZb4/wDsoiP66I+uLKQ8TYbQqKmyb0rEbRWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dn+ZO/LbH6n7zDym7Y2kwF9buhP+xkXsoIgrMY1f94=;
 b=i/8hJ9wTyaLm3/hhb/Fo1LGdHr3pgtG/iLS7rIXWtDYkaby9ob9wcV6xGsRWnE53S3UE4MvoAiB5JcK9EVC1hG8wLtQS4lKJuSNVAx1DWzTX6BvXE75nMz+VXQLzX4mPJLU5Xcy7nmUXrn7Bw0fF6XCAIi5oNMsyLDWcjTCrc6nqVIKHYR444XU7rp4Z1Wg5R/nJYKpSHBDi21fQc/cohDmm1lOjACqHAZr3jbn4Fc8sic+2luogF4a+POYBe4MSxUg1Mv6tvz5mzqJbjBRCW2uQNuYwnUkpl6NeshDuD1T0gECrXZts512IHK+mGKmri57iZFuglXFMw1CyM4/oWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dn+ZO/LbH6n7zDym7Y2kwF9buhP+xkXsoIgrMY1f94=;
 b=HHyEkdmYKF4bWIfuzRg2MNFmkz5pl+DoND13TQ0MbxS2vQ6t4d1mV3lMIMYVi4SV/aMt3rnd8Rvad4DsWufgC3KPeZDTl9uf3x3vU3vp/hqKmyNZe3Zrhx2eVB3kMMkhAX6cImKVoUswzjT8+lffXTxfIinEIRFNkW53Sm5psZ6GN0bn2NyEladlVRxerOrDuqCO6QxMg59fiVRh0yNOFAumB6xwLRcqM/vgP8i2/p25woJKJ+UrwDLzjjoOsh6bKhssBf3AWd8gaYDA8ZxchNTbrlrbzpMOVvXXZExGygVTC/wjMzcRKGt/RLKAjj0mcojFn2+3G+61NHMXdPyh4A==
Received: from SEYPR04MB9237.apcprd04.prod.outlook.com (2603:1096:101:2f1::20)
 by TYSPR04MB7281.apcprd04.prod.outlook.com (2603:1096:400:476::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:25:55 +0000
Received: from SEYPR04MB9237.apcprd04.prod.outlook.com
 ([fe80::decd:90bc:3bca:9f8]) by SEYPR04MB9237.apcprd04.prod.outlook.com
 ([fe80::decd:90bc:3bca:9f8%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:25:54 +0000
From: Zhang Zhenzhe <zhenzhe.zhang@outlook.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Austin Zheng <austin.zheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Increase DCN314 SR latency by 1us
Thread-Topic: [PATCH] drm/amd/display: Increase DCN314 SR latency by 1us
Thread-Index: AQHcsvuFzeiUQFQOEEa7ePJTe6Ab+Lch1p95
Date: Fri, 6 Nov 2026 03:25:54 +0000
Message-ID: <SEYPR04MB923770653CE59AF6FE8E9485E6762@SEYPR04MB9237.apcprd04.prod.outlook.com>
References: <KUZPR04MB9265F4DDEF7627D2E3747BBBE645A@KUZPR04MB9265.apcprd04.prod.outlook.com>
In-Reply-To: <KUZPR04MB9265F4DDEF7627D2E3747BBBE645A@KUZPR04MB9265.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR04MB9237:EE_|TYSPR04MB7281:EE_
x-ms-office365-filtering-correlation-id: 490aaa6a-8e4a-48d7-2b75-08df3bb5aa75
x-microsoft-antispam: BCL:0;
 ARA:14566002|19101099003|25010399006|15030799006|51005399006|31061999003|15080799012|19110799012|22091999003|8062599012|24121999003|8060799015|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qjto9+7DC76FA3KxPNd7ld6MDAcvsSotwfFu5onf/f5wn1Xwa38jc7C9CY?=
 =?iso-8859-1?Q?s6J2Zy+IpDO32/fC5oQG6xlwsoCWclKb6ebdleishLxpCVOUcIvgxDcCx2?=
 =?iso-8859-1?Q?iO+7WLeAtCqSFc2yA0E2EEqUwKcZO2z2+LJUUGchPx5gzvk+HgWxAHaWxK?=
 =?iso-8859-1?Q?f8S6sky6nAWk9BBHrdLtc1QB/JnoXOvVef/qSMlabVMfYvZB6w8fdhsWzE?=
 =?iso-8859-1?Q?WBSFie071c5ba/v5b33sinluyQagfYbin2S3b1hNtvmYii8/o1bUtv7HnD?=
 =?iso-8859-1?Q?XZn7v7P89MDPd576lx/9V6NyeTr01xUXdYTCkBuWeo+DQCSscygMD0F40N?=
 =?iso-8859-1?Q?xw50Z/jtbzolckscMNfRbuFWv1x+6rPE+5qCXKBZoJ8cjTdh8Q/sNwJKV5?=
 =?iso-8859-1?Q?O++3ta8mILCKR2QxNh4gQfMes0ChuZZ2ljkL0NMmRaP+m1xELTnqd2t3Og?=
 =?iso-8859-1?Q?ANvG+DiSs3OWolxVTSKa+0A/FGERQoCA8ssYGBhLZYpc6UlS8Ffx9t7fcu?=
 =?iso-8859-1?Q?PUEZl/Wejt/br550qWcNFws3ICrOn+HVR9w8eduabxKjXcE5W4C/o9B/oV?=
 =?iso-8859-1?Q?SItp1o+61nE8AyAf8I/jPCMswgHMjLd3/OHmlM3ZjuTm3JV+f1bzDl297h?=
 =?iso-8859-1?Q?kUVr/VfGHbymbgfWmd9ceMxWWdLP7z4pwVUXwaIg8Nh+Pqo7frwCWmIk7V?=
 =?iso-8859-1?Q?lWh2ET8h4S46I6KcLxvNCbnnzysaG8NJfPHxTene3YHkwXhd70UClSFzmr?=
 =?iso-8859-1?Q?G77aOY0PwZAKqF7Er8oa5RN3Cdn5uSLBul/3jNVzDEBQJGmRBkn3BlHy7V?=
 =?iso-8859-1?Q?bEV+NppfFr9BE3Nbrj6AxEnVryGVhvCrixUUgAdjzGZxO8mc3xgWw6Rhah?=
 =?iso-8859-1?Q?mz8ItsBdVgE3f7PdKfzK+wAkHvmPH4PiueE3IeXSIvee3KJw6AP3P2RJuB?=
 =?iso-8859-1?Q?Iti++mFycFDzdipU2WUSRLSnU4RXBCsbC9ylxEht03ZS4Vmngcy8OjHxfn?=
 =?iso-8859-1?Q?3G6/EUkIitgwDFw0U7ibvgkE9D834DsJoRps6PZx7D/vUkj2WNK3Uz7RU0?=
 =?iso-8859-1?Q?RNgctcNWkj9WMnIsSCoT3hE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cTw4YhmGtm0hxyaY2vXv1FZ4zVz/E1LDPk2IKy8SZryyHi8RQkZpWOri2F?=
 =?iso-8859-1?Q?vmuXUbl5k3zlO50jIPBiQdsnZScPnWZoob2aRH64mNDCiMXd/AcU9Y+Nbm?=
 =?iso-8859-1?Q?kMLWwWttL5nnNXS/Ot4W8Red8q76KtFRn+1y1uJtnRyOiL3q9mWDOO50Ob?=
 =?iso-8859-1?Q?CNqt6qytnz02rC+avq5T/69pnVIrshbAHLE1UqmR2X+yiCUxdzhuyDvukn?=
 =?iso-8859-1?Q?2D02tP4EkDZw6euvX00HAIxg9RfOoSe2EZeI+5v01pHQhNydZ1lIM8pU2w?=
 =?iso-8859-1?Q?m/laicw0lJBTfZGgwtgsljyghyv+30miuVw+x9/nYYncH56C9rgReKGRVL?=
 =?iso-8859-1?Q?rPazu8tSgJZtdKNncUhfW3WR4EMLonWwQ3DraBkHCWCbdmDa6uSYvXlmaX?=
 =?iso-8859-1?Q?krjkI3B4Zba4YrKdtwTGkDSIRcOJl1T8tuViDPA+11L7aDlCpREpnGWIMD?=
 =?iso-8859-1?Q?Zm/Jvczd73cyE966Qvf0x+djM1wkmlXgO/SZo4spav6ZG18QRlFStS5yZ9?=
 =?iso-8859-1?Q?4RzVKJBI3vX+k4tWLZPYk6y+9tyUQns3QfWsS0DD97IpeHJKb/DCmbxarA?=
 =?iso-8859-1?Q?ITCaAKLDiF6DsOYhSsoYgdhhL/MiqZ+JDFcbpPKT5EVi4a0b7N/6mKd4zo?=
 =?iso-8859-1?Q?3Dj9qI/MN1eDZZD6oVE7UGF4rCCQBxU9HD2+uRkeesu3a68Ra7fm2vH2z7?=
 =?iso-8859-1?Q?soheK2u4V0u4aYEXCqS38Mjgx/SL07HBTYC9neifyJiusywafKTh3Z7dOy?=
 =?iso-8859-1?Q?ABxPDLkQwhPMuBE2XTNTRZ/c+P3p71FeCmg+wbyFL4P0irFQaIuCF/PR47?=
 =?iso-8859-1?Q?cAFm0u+ukRcyrXMxAzpZ/ly1wzhu3tKxg1fIhOVbDjIPFEAIQei5/b4akW?=
 =?iso-8859-1?Q?70z8zrYHnq7i5VbcwgZPRWZ2QCyGOmkfMj5NrhsnPJbDib0E2y73WrB7UE?=
 =?iso-8859-1?Q?XyVMMsETXpHHXN3EuR9POrS0Qp75fbzk2q4cFgHZy/m9PP1kMfiZ3S22pn?=
 =?iso-8859-1?Q?ViCtbdXfyWIrW5snEgeOCYzK5zzAp3wj2PvOIkY5zJDj8IoSLUglQHLJUT?=
 =?iso-8859-1?Q?oMGYj22x3SwgPM21bOvlQmIfaH6B1iuUnQz+3mhc7oupbfpf542wNgvAS9?=
 =?iso-8859-1?Q?8ZzpkfFXzufDijT2VfIiXcaSxo4wjG2BXVn/Q2MHuXnLUUyHnVD6IOM+IO?=
 =?iso-8859-1?Q?1DYdQ6Jx0ERqzQyYBs3i/FbYlQxUOcbd/grQZAtUTw1S7US5rJAdub89h6?=
 =?iso-8859-1?Q?Y1ST2nhO5zlX2VnkuMeK+RQ9ufQjqCK4OhCTQBnXpLHUNX/U+wyzsiwNeS?=
 =?iso-8859-1?Q?rurh5pLblubiUhZQbFO8tk2e3vLlzWCy8jdnLs71KITgw95kc3XC/L+7/t?=
 =?iso-8859-1?Q?nJiYdX6PwE9ht6bTdVd4YLAqFjAL4uLMkNPZmm95PrxHeYE8UGRQG5Oh7w?=
 =?iso-8859-1?Q?qcxzvBG/0GUnelhq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB9237.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 490aaa6a-8e4a-48d7-2b75-08df3bb5aa75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 03:25:54.4517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7281
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,=0A=
=0A=
Just following up on this patch, as it hasn't received any maintainer feedb=
ack yet.=0A=
=0A=
This patch follows the same approach as commit 318917e1d8ec ("drm/amd/displ=
ay: Increase DCN35 SR enter/exit latency"), which addresses a similar displ=
ay underflow issue on DCN35.=0A=
=0A=
On DCN314 with LPDDR5 memory, increasing the SR enter/exit latencies by 1us=
 also resolves the underflow issue in my testing.=0A=
=0A=
I also noticed that the original commit message incorrectly used the Fixes:=
 tag for a GitLab issue. I'll change it to Closes: in v2 if needed.=0A=
=0A=
Could someone from the AMD display team take a look and let me know if any =
additional testing or changes are needed?=0A=
=0A=
Thanks,=0A=
Zhenzhe=
