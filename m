Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE44606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ginzinger.com header.i=@ginzinger.com header.a=rsa-sha256 header.s=selector1 header.b=gMF80mji
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0BF10FDAB;
	Thu, 19 Nov 2026 07:48:59 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023128.outbound.protection.outlook.com
 [40.107.162.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C788410EC28
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BetxwPkRFFcvvkTtAZqaI5X3fJNIKffpUqjFeDhZU7bx/IP4ZZyfaQAmUc2XzZZtG2wTUEuJiI/koy0YUDIzhQd61LC0YdN9Lu/CyoTNiC8wO9B3idk92ihnR/9OatpuqjBYBHXY/8KMC3WzDXMbGbf/klUL9c0EPCii8jBJm4gII4u3kwczhaWDNI+r9iwS56wVsGYj8mYrnvipaKZLbfdM85fizw97+yDRZ6Ddah0bNs2f5CFq4w5EHAiEEZo9e7MnTrVCpSujerH3xThWCH16+8h/pY9hIeoSS4LchZIHEG6rMocO/uI3PHj9CMjHGhmmhEBTdQd2AbV/uBLByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zfof3ZiPX1McltR7TdTHCii4zFyMJGI4YFyO9qQFdI=;
 b=il+WwT3fqYMwP7JbQh/mM2T8+ZmkmNW6+5tpP/uOJYhwgnY3P3aEBVtuU16Kl3pHmZWi4kmPX17uhkVxE4eMpwg3QoeSqmwdfgBSHszPSLLtURDot4LURUVQqkoAY0zZXUJWHCFVcipKAZ8/SXuitJxQGRL0ITIKYlval4IWUr0E5tS70uU3EzBKkdk6E0a7eVhNOZtd4ZaPMYJTuJs7aShMUxUr5AlpLneljyVE3y6sRiuEjwW94gqXYa81cemzcSaKKJ+rH5p7YDbTiJ3g0F5gSnRrETjVoPLKNBo3SCKO03fvNLnxKNQUCoP9FDEFvD0vpyOhdf1u0knAIR+/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmx.de smtp.mailfrom=ginzinger.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=ginzinger.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ginzinger.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zfof3ZiPX1McltR7TdTHCii4zFyMJGI4YFyO9qQFdI=;
 b=gMF80mjid/4tLTTE/5yIv7tB5SJkB191qCfsjeC6PGKFM3xawtv5sOvchTaUNwAPehfzuQuJPaR4YRX4y8IiddS8FDTurCwGkPXn0io3QQJ8UxN95h6Fx2kGZnKQJOqnv4NknD+SqTGGDMmvqLZmimwWKih0ApGhCOcMPYi9iRUQacsqCRxq2S/NhBIQVP0FDaCMLr0RMx42xw1HNIRjoRUsQ9q9is78UCF2r1kIbWH426LTh8GomD1r+FbtupME/ht5Rc8cmhydx+WHa29kyqu9FpDC7Hw06XlzlbdO++7enZkcqW+c+rlJrZGSnssjfg/60vO+KWbT+A7uEu5D5Q==
Received: from DUZP191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::14)
 by PA6PR06MB10303.eurprd06.prod.outlook.com (2603:10a6:102:51d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:23:59 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::6e) by DUZP191CA0056.outlook.office365.com
 (2603:10a6:10:4fa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 14:23:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195)
 smtp.mailfrom=ginzinger.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ginzinger.com;
Received-SPF: Pass (protection.outlook.com: domain of ginzinger.com designates
 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 14:23:59 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.71) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 18 Nov 2026 14:23:58 +0000
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 (2603:10a6:20b:756::23) by VE1PR06MB6911.eurprd06.prod.outlook.com
 (2603:10a6:800:1a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:23:55 +0000
Received: from AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b]) by AS5PR06MB10652.eurprd06.prod.outlook.com
 ([fe80::703e:93ce:8522:2f6b%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:23:55 +0000
From: Roosen Henri <Henri.Roosen@ginzinger.com>
To: "deller@gmx.de" <deller@gmx.de>, "sashal@kernel.org" <sashal@kernel.org>
CC: Kepplinger-Novakovic Martin <Martin.Kepplinger-Novakovic@ginzinger.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "icb@fastmail.org" <icb@fastmail.org>,
 "a.vatoropin@crpt.ru" <a.vatoropin@crpt.ru>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: BUG: Linux kernel regression: full screen logo
Thread-Index: AQHdd2hxmF0x4onrBka1b5buRSqpaw==
Date: Wed, 18 Nov 2026 14:23:54 +0000
Message-ID: <074e66817a069dca965d9c258606f23fbcb2e1a3.camel@ginzinger.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=ginzinger.com;
x-ms-traffictypediagnostic: AS5PR06MB10652:EE_|VE1PR06MB6911:EE_|DB3PEPF00008860:EE_|PA6PR06MB10303:EE_
X-MS-Office365-Filtering-Correlation-Id: 06068005-3afb-483e-2e51-08df457f9627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|261022075727099003|11063799006|56012099006|261022115727099003|10067099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: jyKJYvWWziYyTLWOQljeUkS9u4rF3HqrVIt5wzJQrCLSh9vC1dksmnk0hsi80H84n85HLHsOaGgudlyI61MU9Pbqy1BofHS7TgsAtC09iZT8fSZYkK+OuHi6gnciKxj5S3xi6f/XnGFfH7q6eb/NV2j6dqMxTtRq3sGqbm3YPf+vwtp7Dtj5S/xeyCNWt5mPRvtfF85CO1DLekIeBG3Sy9ENh9KEYpvjyC4o0/Xrty9lDKtcUq9zIJzno3och9Vp3nH9WtXcJhxtP+tBqcAvDPFhHiDgJJT9wlbTFcI401M9tLXCGIQng8gKFJsZ5x+qfTr+BHNryTcFjdJ88cXmoCWMMk0NavcV+3OfsCxCMmD15AIjlSI++jOkT5J52hIDxIs8f67vfIkXBDwCHhMN5bgsaphZIOD6JPGUTOyIs5MSwTmPoM5oQgQR+qApamWA9pxxbOYWhtSqM8qFNaMPRilFkdP7N88XrP5Gvl77bdqgf6IH78WQUnZlBcG4etFrHj50jra2TH4/0LEA8Htrr/axbEOFgWKBQbjYiPwVvFaf5ijWWZydteKv2PhyBGPgx4HvyoNFGlG72yanJKLaTK9so/ZcL6B9jQUcSou/rbjWAPRFTtrkgfsgQcxd1EOlzkQBMqvJoa2Zkbfj2Wi3glU4riJCfSyAjQ9eDBYy2sI/59YsTrmvWYXyfp3/Vy74PwjYv0H8EKmDqFdG6v66yCwm+WJVjYICxl47mzbNLEU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS5PR06MB10652.eurprd06.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(261022075727099003)(11063799006)(56012099006)(261022115727099003)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <450EAC802749E04099348AC2F91DFD01@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FAexfHYOQoLUT8XbF5TAVRpvC2v2Q2Zcx2aNSwtmKaghNQUSr0aGsG2Zpkr1H5kkN7vDNpsdD0Sq2uBjaOqBtuK68I3sjzVbjVhH86PNNKRLWgSlkmT8xq/TQRKCJwBCHg5qYHzr/6zh2B7pinHrKNx23OaecOcajDtigpvXp1+iQC2wcBndbteuMO8pVvWzBExGVaNF+BBSRlr7oWbH/3DyE4mt4aiYulWrxoxfbjhMgy4t3KsL1DrQz3XCBII+DeT/WCDdAEhOpwShoiypW0FyluNByZWDDglyq26IEAIgBCFPwhIVKpUz05Kmymvr8KRykiZhrqAyOlvfpOWOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6911
X-CodeTwo-MessageID: e66126a9-2944-49d7-a91d-652acc5b4a94.20261118142358@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b868acc7-06f5-4100-96af-08df457f93a2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|7416014|1800799024|376014|36860700016|23010399003|14060799003|82310400026|56012099006|261021121427099003|11063799006|10067099003|261026121527099003|261022075727099003|261022115727099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: PUI0DAH6zX1i9x6KuqQ67p8a29BlUKcsQ388G6JPKjorYZShfwosZ9Tc11DEIFMHuGfJgrzAdmsL8jl1aT0b1u910TswMqLnKd1m/EjbCkwhXLghY+1rVCT7H0SUgv6y8BMKF2hsoGpYOHdjHjbZxxaLDk8uzdkGBw/n5BzMyuBtqbgPpmVhRSoav/4BqlQvqvwzCPYJZIXNJVjCzi/j2fg5ffxex+TRMpQlOOt6zMqeI7z4Knw618U1w5QcOQaqIDCQjLfPvdqepkSGwL2GhB+HWURs9Lh06aSAsADlZPamkr0kEyOZlQBMjDm1mrHAvDjebpuZXPlfyeQ0TCzLveg9Yyzf1MXcLD0WyYIQcMbyUVNM634UqeFunCvK/C/ivI1A6oyGQvMyXhPd0LECSm7UFOcJ0GtO0cgS6HP+CSg5CzkaFWLqN/38oPWvg61W4VY8OF/xjGfSdj87z6tAsdgt80YxU358YxYFoNljY09RsuXFYswaluF+yhrNQ97gXT8QSxHMUmwxvM92fQXFBmBZ0fHVIMaGsvCpUAXgozZ80IbYEo2HZtVH8juTa0LJREBgoU2lp2KyiOm9UAdAVMpFBoJvQHD3aH4bpA1MW4AngGJxbxMLbTdO4IrZrZwejYJz9qHOBlz7UNmZcFjXZum4jLAdoUEHp+seifql/UFlrjqZDzAYJyqBdHf1DcRKfsInTb/zaLeej9ruAgByfQ==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(7416014)(1800799024)(376014)(36860700016)(23010399003)(14060799003)(82310400026)(56012099006)(261021121427099003)(11063799006)(10067099003)(261026121527099003)(261022075727099003)(261022115727099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ASIevGTLcXHpU1HpI9h79KNfyirL49TkkTqrFyjmldoFeenVnzyYnTpSJRw6pFFiWzZ568Fekzr9+Rxw3Zjgg3WCB6H1A6EsWo0B8/9N49je9+RS+Zdj6bRAWc3t4rpD7v3UBMpM+Je4HCIi90EZl/n4bMnpNcyLrY/3k/5X2+NbHW2gSVg/44vF4jbu/yicRHMQsg8DOmBx+WYINhbfRP33bS4WPWEmuFoXgvD9iiy9KWog+Br0ndxy2V8bMojyPPbPUU6QyjFginmg2ngk1mgxjiYyeGsEvkBxZ7Xl3wSImRqHaCB63IG1f8wUSjfAi5F4hJViBZpnC6O8BcNZDfMHCWWamyzYLXDQ+a2qOQ0R1Jfv7csTnjxdVAr0ONjMmQkv1ro+dl/IWN3nPlSmYiK8sMofDY6crZyBmD6W7sIvUunYHtIKGXmQqE9tbxoX
X-OriginatorOrg: ginzinger.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:23:59.0250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06068005-3afb-483e-2e51-08df457f9627
X-MS-Exchange-CrossTenant-Id: 198354b3-f56d-4ad5-b1e4-7eb8b115ed44
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=198354b3-f56d-4ad5-b1e4-7eb8b115ed44; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR06MB10303
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8gSGVsZ2UsIGhlbGxvIFNhc2hhLAoKSSBoYXZlIGJlZW4gYmlzZWN0aW5nIHRoZSBsaW51
eCBrZXJuZWwgZm9yIGEgcmVncmVzc2lvbiwgd2VyZSBhIHdoaXRlCnN0cmlwZSBvY2N1cnMgYXQg
dGhlIGJvdHRvbSBvZiB0aGUgZGlzcGxheSwgd2hlbiBzaG93aW5nIHRoZSBib290bG9nby4KClRo
ZSBiaXNlY3QgZW5kZWQgdXAgYXQgY29tbWl0LTU4MmE4OTEwOWFkOSAoImZiY29uOiBGaXggS0FT
QU4gc2xhYi1vdXQtCm9mLWJvdW5kcyBSZWFkIGluIGZiY29uX3ByZXBhcmVfbG9nbyIpIG9uIGEg
djYuMTgueCBrZXJuZWwsIFsgVXBzdHJlYW0KY29tbWl0IDk0ZTZhMDU4YjE2ODIwZTAyZjI1ZTEy
MjFhNGM0ZTcxM2JhMjM1NTAgXS4KCldlIHVzZSBhIGN1c3RvbSBib290bG9nbyBleGFjdGx5IGZ1
bGwtc2NyZWVuLiBXaXRoIHlvdXIgY29tbWl0IHdlIGdldCBhCndoaXRlIGJhciBhdCB0aGUgYm90
dG9tLCB3aGljaCBpIHRoaW5rIGlzIGFib3V0IHRoZSBzaXplIG9mIHRoZSBmb250LQpoZWlnaHQu
CgpPdXIgbG9nbyBmaWxlIGhhcyA4MDB4NDgwOgoKICBmaWxlIGxvZ29fY2x1dDIyNC5wcG0KICBs
b2dvX2NsdXQyMjQucHBtOiBOZXRwYm0gaW1hZ2UgZGF0YSwgc2l6ZSA9IDgwMCB4IDQ4MCwgcGl4
bWFwLCBBU0NJSQp0ZXh0CgpBbmQgdGhlIHRhcmdldCBmcmFtZWJ1ZmZlciBoYXMgdGhlIHNhbWUg
ODAweDQ4MCBzaXplOgoKICAjIGNhdCAvc3lzL2NsYXNzL2dyYXBoaWNzL2ZiMC92aXJ0dWFsX3Np
emUgCiAgODAwLDQ4MAoKVGhlIGxvZ28gZG9lcyBub3QgZXhjZWVkIHRoZSBzY3JlZW4gc2l6ZSwg
c3RpbGwgeW91ciBwYXRjaCBpbnRyb2R1Y2VzCnRoaXMgcmVncmVzc2lvbi4KCkknbSBoYXBweSB0
byB0ZXN0IGEgcG9zc2libGUgc29sdXRpb24uCgpLaW5kIHJlZ2FyZHMsCkhlbnJpCg==
