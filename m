Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2641C5DF7B
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B70010E309;
	Sun, 16 Aug 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="TDcjE4fh";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19010002.outbound.protection.outlook.com [52.103.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A14F10E1ED
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 03:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVhomIFvGahk3TwUzcQGWDIK2dcHsNY+sjbONcXVMESuPZw29LrJ+Uxr/y87n9Hw6UaojOFEwGRlwdBl+7AUnCcUSlP4WU9DHhoePYivEwPuefuBCAmyQ5YWAqJ+j9U8V8s7E5aSXVthLlx74IuUfA2ugw/5sG6Mamyyh/7Vy2AuApFRUsxmQV8XohLmZtLPQQaUtqyd1D1wFMUbQr0S/5u2Xn5JquLRLSngu/LhmwHfEUtluQL6PSQqjB2yE0VHrUAnu3UeLceDbEPm8iAMKFDiYmR0DR+bj0oz05SROCUgp2bBUMmURmd6v4foKP07LbiWP1SPyGsw7xe4WZS8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnNVP407JdL9QViGEhsKmFHMiOdU46kCQp+5ESv1D7I=;
 b=WGAu2JqPWDVAdO1PVZncXjuCuUh+sCaGb9ibgQ+/ShG5Z9DABFEJvRk595zFG2hSZCa/kAgJSzwykDf8OUCqGhgYaXvNRB4ysKPMQEWVm32rShrtAxfFwBVXCkEuZn3N4bRffagJiwitBM6dAPRcc5SyzYyX8n7ru+EiciZQm+H7WkA1Q8frWloVSmabUbF5g8w0MsiEx3KbfFBGtY7Nsq3lsQW97p1AVAujmvdW20tkXYOnWD+nGKUxtoDWNIFKY4F8Tgxb2b6rpZqZTUh7HzBrSIrJyv8+FcnScKPFaCX3e6/FEveZ+XI6rJ2GKzcg1QRSJbXnVQKSQ8tpd1yN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnNVP407JdL9QViGEhsKmFHMiOdU46kCQp+5ESv1D7I=;
 b=TDcjE4fhiESkdFQw/a6Pg3fIah5SABaKzcuSGx+hmyCJx1IAL9Sxb30Gaux+ZU0Oqn8y4264y1oXI5Kcrvq9EhIsrdLGMDB9TpHvIIdrNVh/GppfhoCH5XluRqk07zLraQCjl3YVe1ILXWg5UKCldoVQoud35/pwHBG5nYTX6eB4pAe94fVD4wNpNVO5jWGtGGvJKui/ENHLBGuM37ukjPRmVulSxkLPaErLIIYNGX80zyUghkS8WHN98o5g11arY3mtOenOd7DKgenE/95dShZmS9UKciP7DSMqgt6oW96QTjjQHRLvMZ/eJhLJegVfW4+A9fp9cJw+qR6TXu9JNQ==
Received: from TY4PR01MB15735.jpnprd01.prod.outlook.com
 (2603:1096:405:28d::12) by TYCPR01MB8141.jpnprd01.prod.outlook.com
 (2603:1096:400:102::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 03:39:22 +0000
Received: from TY4PR01MB15735.jpnprd01.prod.outlook.com
 ([fe80::629b:bf8d:87d4:d3f3]) by TY4PR01MB15735.jpnprd01.prod.outlook.com
 ([fe80::629b:bf8d:87d4:d3f3%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 03:39:21 +0000
From: "zhangn1985@outlook.com" <zhangn1985@outlook.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Fix a kernel warning in dw_hdmi-rockchip
Thread-Topic: Fix a kernel warning in dw_hdmi-rockchip
Thread-Index: AQHdLS+y/yQ3fJmDUkGK5RTdqMC5HA==
Date: Sun, 16 Aug 2026 03:39:21 +0000
Message-ID: <TY4PR01MB1573507FFA8BE821721E1B0E9CDD82@TY4PR01MB15735.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB15735:EE_|TYCPR01MB8141:EE_
x-ms-office365-filtering-correlation-id: 209ac5d2-9eb4-4d2d-f713-08defb47f5d3
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799012|15030799006|31061999003|8062599012|8060799015|19110799012|24021099003|41001999006|25031999004|25010399006|4140399003|52005399003|40105399003|2607281247196008|56899033|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?windows-1258?Q?ruKNi0V/9gNlUpfhiUjn6mjFs0uZgIafe9NqTnLNOjCaGpJpzRuwLyy3?=
 =?windows-1258?Q?r8pFN4Vd7IaPp9tyYnOPeSiFI38DsZuBaN8CWGkPfvO8AevALZs9JgbI?=
 =?windows-1258?Q?ZFktTiM5HF08uI71fOpcoYIwufF7Ck/JqIzGjhkwerIpyVg6Ijqkfwy5?=
 =?windows-1258?Q?BzXD8Qkt6BaKVhi9TNRDsZD7CC2vGCfbAehLH8sDZkA792rEb8QpPUOd?=
 =?windows-1258?Q?pit4Re6qOc5b9TtGDBne4Yft5Fl9viUSHGlou6bW7FdR4+Ssx0wIA4oy?=
 =?windows-1258?Q?P/uLVMXuCvgYw2PJ++8q4votLrqK7Of1KnifENV4PvHnjA2JcN9psS5W?=
 =?windows-1258?Q?GCistZiK/744od7RILloWmOTLHPuN7+DMsfMz/wpfeoH4N2RBiW7/983?=
 =?windows-1258?Q?VuwIqBO8ibLJeTASOchkwiP2njwWfiUaX4eX8Brg94ZcOYC5Bc1ezjmJ?=
 =?windows-1258?Q?j/J0j4BMuOYMRQV4ZxjCzOv3lAsLjP3KKS231/hfAzLt8z+9s5L1Z8AD?=
 =?windows-1258?Q?TPMXws2iFcQxUB4AnfU/eT91QYkjELpMDigyFT7D+tJZ97+Fz9rWWJSR?=
 =?windows-1258?Q?nZvmykDUGXWEdeuJpqcVqghOqB275ZpZaRmf6JH5UyaekQNQlZYcEeP0?=
 =?windows-1258?Q?Pyi9V39ztsj45Mqq2J0iEyAFZYQWmdL6VwCLZycql5ZwB5qkjSnbdvrX?=
 =?windows-1258?Q?dPkVNlf9P9isZnme2KvrT8rlYSCtgBRWkhbXw64C8qyVbMTUZFH6tvpH?=
 =?windows-1258?Q?L6yqbXnNv5EXLsr92BULvpCtBmCwUJxmk371+3zymeNhdtS03Qfzq9Hx?=
 =?windows-1258?Q?/EHlAcaHMbsq8T4uk1nE7nhBZnwCUe7SJqdUONMDIjbwIXnRoZW2NLvk?=
 =?windows-1258?Q?26oVGjsxOL1xhC9F78Fue3ZfP4O6AAAQprLsRd4zS2IvBqpthJa3J417?=
 =?windows-1258?Q?gbnyRfBwxZbIiyW4WZ+dUN0BjFWgzkjeN7t//HobHZR+ml9ZwLBqk8Af?=
 =?windows-1258?Q?rKHZ761EYSoYfDfTMIncElMX4uhODwoi+SmE3lZMxLoIM26q2jTR/Dnp?=
 =?windows-1258?Q?T1IqGdMfVXPA8zhMgxV4qkefIvIG87KYeQoue7RC3G6LzNccQemB3XCi?=
 =?windows-1258?Q?EVE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1258?Q?Er91F4121W+O1VYzIXhZpc5lmX1AwmERD3IJQi7YLPHy3goYMKuk+Xm5?=
 =?windows-1258?Q?brJ/IxLn4KuNsvazubcWJPkzUtsjaZvG6JpC7UbiUOhVavXN/0KyuNJ7?=
 =?windows-1258?Q?WBgR+NIEKLVGHLrrBv6Oo7NwN5KgKwUk7FtWLB2+yKxte3IUu3GQLqwg?=
 =?windows-1258?Q?TXEmX3UojJ8YuqCjBubgN7A6QJenjCZwPEsiSdPi5ZoSyaRcaMl/4FfZ?=
 =?windows-1258?Q?4HAA5I63PfsltSzEQYtQYvyDWVSFyqPhOi+qPxKahvePkimW6k0PGfzu?=
 =?windows-1258?Q?bRDB4i1UFsg6Bd9AsMWqnW8LRT3O20bsH1aBMPU2+bqOlr2rVYDLyFKU?=
 =?windows-1258?Q?aH2cpGQ+L0hOypMeWHqHOLci2rrqL52CtGio2Gmvw10b7w6yJucF/Bsr?=
 =?windows-1258?Q?r/LmSV5kWND1xSDX6ugpf+DBTbonimYh/X6JN5BvTGE+QbEK94vrspeo?=
 =?windows-1258?Q?FZnOEs61hSttRnO/42y9gl0Qtii6heJnfqOksUww/RewEd1y1qPB8j3t?=
 =?windows-1258?Q?EyyUu6C1TTmHdci+IN/nC51j4VN85IdzycS2qE0z7NWDv9rJjxrhHYJ8?=
 =?windows-1258?Q?RpV4qV+ei7J7GCAq3qNNSc2VMNFfbAbBkV6Ox+/kHaicxz3iPPP12o66?=
 =?windows-1258?Q?HMrFKtggUuAar9PMttamIT0v+gw7LJXePHGA4wsjjLIsZfnth+iqDBFQ?=
 =?windows-1258?Q?QD4dzh3JxOiXhjrVZ48C1TmCmDfs7U2ow2Coxa15PjXUTKf0z8wQIuh/?=
 =?windows-1258?Q?BopnRykH6RDbp/OOUg1ynHQVbt7+1eHHCHXHO0t1fK/xiaRumxjm6bUW?=
 =?windows-1258?Q?j1cfao1B0P6rBehB5NzPsqgbWjG6aqvSI6rgsFIbM8bAjwBgaIhp1sFX?=
 =?windows-1258?Q?iQkKP77rn/p6cq1Kra/1Ulh2R4k6/prEo47Kw2LU/7C1Rcpk7ofRWGMz?=
 =?windows-1258?Q?9C6e3C3jJ0fJ+f3eGsZroVfUyYT5bWVqS9SqTPJQdJpnvyRX6cvlFfX7?=
 =?windows-1258?Q?H+fnu7oqYRwnJ5pC7lNnREpVGBwui2N3B5W13GsdXaKqKVWiLTp+hbi5?=
 =?windows-1258?Q?WZTnUHK+hVe/1J158wTe4D1gd21+rrYyzNwu5ihGAZfBtMU0kFjvfTWx?=
 =?windows-1258?Q?pfXl4LGz6uN1VHAFVmldTKd2UYPK/9MXuC/KmGR9lgstc1fD3k0HMCzq?=
 =?windows-1258?Q?9wHA5VZxEa27pH0WYObC+N0ILQ7ouuZfVBwoMcTMOGdcUb8qLY5GM5G+?=
 =?windows-1258?Q?c1N1gJbAsbr9SzNsxVHDDOowGU7dIpdq97fcONWcjFdnFWqiCORXqN2z?=
 =?windows-1258?Q?9A5CQG8ZZCE6KEv74Tc4ncpV88s2AxTd98Av8EVK0fbiobSg1LMaMOYp?=
 =?windows-1258?Q?L3I8IjTOBv+5mJz97K312JEjZPqROxOhKXpquIN7vPLdbycGOmPsOhXK?=
 =?windows-1258?Q?LwB3guQ2p6pli/i/W1/Gjxq1TFI2pOl5PH+SOf67s1M=3D?=
Content-Type: text/plain; charset="windows-1258"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB15735.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ac5d2-9eb4-4d2d-f713-08defb47f5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2026 03:39:21.8257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8141
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Hi, Maintainers.=0A=
=0A=
I send this email for fix a kernel warning=0A=
=0A=
`=0A=
=A0 =A0 =A0 =A0 if (!bridge->container)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_WARN("DRM bridge corrupted or not alloc=
ated by devm_drm_bridge_alloc()\n");=0A=
`=0A=
I see this warning since 6.18.X, but until 7.1.X, this still unfixed..=A0=
=0A=
=0A=
I don't have a env to follow kernel patching process, thus write a email, a=
nd leave it as is.=0A=
=0A=
anyone who has interesting to follow up, welcome, you don't have to keep my=
 name in your patch.=0A=
=0A=
here is the patch:=0A=
`=0A=
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_hdmi-rockchip.c=0A=
index c72504033e4b..89c1c13cbabc 100644=0A=
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c=0A=
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c=0A=
@@ -749,7 +749,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, st=
ruct device *master,=0A=
=A0 =A0 =A0 =A0 if (!pdev->dev.of_node)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;=0A=
=A0=0A=
- =A0 =A0 =A0 hdmi =3D devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);=
=0A=
+ =A0 =A0 =A0 hdmi =3D devm_drm_bridge_alloc(&pdev->dev, struct rockchip_hd=
mi, bridge, &dw_hdmi_rockchip_bridge_funcs);=0A=
=A0 =A0 =A0 =A0 if (!hdmi)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;=0A=
=A0=0A=
@@ -811,7 +811,6 @@ static int dw_hdmi_rockchip_bind(struct device *dev, st=
ruct device *master,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_disable_clk;=0A=
=A0 =A0 =A0 =A0 }=0A=
=A0=0A=
- =A0 =A0 =A0 hdmi->bridge.funcs =3D &dw_hdmi_rockchip_bridge_funcs;=0A=
=A0 =A0 =A0 =A0 drm_bridge_attach(encoder, &hdmi->bridge, NULL, 0);=0A=
=A0=0A=
=A0 =A0 =A0 =A0 platform_set_drvdata(pdev, hdmi);=0A=
--=A0=0A=
2.55.0=0A=
`=
