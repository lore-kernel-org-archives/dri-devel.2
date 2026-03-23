Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437C1F483C6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A564F10E02E;
	Mon, 23 Mar 2026 16:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Ghzy9Zu1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ghzy9Zu1";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64DD10E02E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:13:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yRnzamdpcoNusWETHgKLnvpha//gVRuWLV92jyKV2DwosMpXlgu1Yq5Ng2DHkFrZnW/c+tKYZ1TbdmyUOhXK9ZpTlkQOx2mjtflaD1YxBqCbuEY0RjU/e9T5gfOAVpX2Qhq6f6ygLJPsKjLt3WcR0ios3JFdoGsjuDthL7nLCHWmknpPIcbg+Gjb1TXJTuvYhETwSayvAqqB+Rbl4aVdW9WBrOZHkBHQnbvyGfhvZ4vBVVlmkApU+fRwgSZazjSVr6XNU1SxHBS22DPve34mXWXZUPp9SwdwaHjBOjftnEw/iin277s7V1rUheUBAG52fkafTCZkc/wb4BizcfMuug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ks7QJFa1pHGNR6jqwiJGh0Ah4PaPq+0SeqgmZ1Fnk=;
 b=xMu22T8Te7rZp/wUpOHdrtH1NUZdkeT8yw81S1ocYfzm9BY5nfia/a3CCL0yeKWvZI7BYD8GOR8/j3u6kBEM54mo/VLsaKIMMOJG4mRyKX7tg5WppYjUkei8avu0ViREyLUw7UWKiOGoAzr8MtFV/KxRoiYTFm6vK9YRHFgb4mzqvlOBEcQqdck+rTNL8FeDUON2Ytmur7lafGoRKXCUqlaxe4qw8+xhR9/NI1O/KOSRSpQ9B29IWxGDY8Ao8M/IjPp9QFqrZQnzYuyz1waLqSAMQ2z0MUKixQm9GXw7EjUWXGTt3Ple7oxx88I3NCGiyLfo1Rb/EA1uCjkO+4Mzqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ks7QJFa1pHGNR6jqwiJGh0Ah4PaPq+0SeqgmZ1Fnk=;
 b=Ghzy9Zu1bFynXD5rxBB+byzu46TK3miAYVgiP9dz7JkVbNSVGxKas98FOcBSTH+z+XBBPIKoK0vc3R1q4rG31OX15q1Jyd1JCoLLB2cVGsjZU6sUp65INwTW+fpsLaf2HCG06QAPTrrf+qxQJao3FW1UrQd5tkcK+fa7k6V4ZNg=
Received: from AS8PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:20b:311::28)
 by DU4PR08MB11746.eurprd08.prod.outlook.com (2603:10a6:10:63e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 16:13:09 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::2f) by AS8PR05CA0023.outlook.office365.com
 (2603:10a6:20b:311::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 16:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 16:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpVCu7MsQf95yeKg8Z7fJcwm+8lfAFEBtR8Iafes5GUXoFnu7NUGwCtif3nL7reECxRxaH5sA4eRg1EmfIDlyi5nOKIvIYgMC11NWSyrTjTmDCU1bQysPeACKIqYzjIu7M90bUfDPk2wJNwZLEr25BoGcXn1RFpm74olbctHSxyCpD9HhFmzh9ZMmgv7TkokMhPlvNmEjTaR0wzaMW1ZCrhWsNJ6bOYSRfjnq8jYUcKw97d+RrV9exXz1floRI9SjTjmA+0hFtqDtCONwQsBio6ptdyiO3Mr+PIDrQ2XYeYqUADrbkzxQuI0/xmW/LqLGNSzmmcOWTxp1JX+N0Lt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ks7QJFa1pHGNR6jqwiJGh0Ah4PaPq+0SeqgmZ1Fnk=;
 b=EtbLWihwJthSvBoc/a2fja/o9ET8zaqgg82fOdSCNG03I/7+utemUQAJqbl3t+sdcwy+qQoO/ofgsDoSqGy7zGO1n5/slk0Ni5ST+He1YdqJmXGusYBTwp0ChbG9kOFpAWPbKyM8QfPWPsWNxIVnSxplzbf35YAH+/5A6GsW1a4eDTIykGNB2HqoY9jOxfHiGYI4d+lcEtLv0i9HVN+vLSon2vYeoA2uBWWiXw/Ks+F5B7K0G35M3L99xi8wZ+GmQP9oJ18uiHitx/P8kTDQZQCuhk+4huFZeD5rkaq/WaowwZ1eVniBK8DHE6wQyLzkhkAQBnrptUxSJmI2O4SNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ks7QJFa1pHGNR6jqwiJGh0Ah4PaPq+0SeqgmZ1Fnk=;
 b=Ghzy9Zu1bFynXD5rxBB+byzu46TK3miAYVgiP9dz7JkVbNSVGxKas98FOcBSTH+z+XBBPIKoK0vc3R1q4rG31OX15q1Jyd1JCoLLB2cVGsjZU6sUp65INwTW+fpsLaf2HCG06QAPTrrf+qxQJao3FW1UrQd5tkcK+fa7k6V4ZNg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by DU4PR08MB11792.eurprd08.prod.outlook.com (2603:10a6:10:642::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:12:07 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:12:06 +0000
Date: Mon, 23 Mar 2026 17:12:01 +0100
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: extend timestamp query with flags
Message-ID: <acFmUc-qx0eO8A1F@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607> <abvujKZxtg0zvFaz@e129842.arm.com>
 <abwTkBi5WvItsEX-@e142607> <abwXXFgPheyA03P8@e129842.arm.com>
 <acE9LkMYQvrGKb8b@e142607>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acE9LkMYQvrGKb8b@e142607>
X-ClientProxiedBy: PR3P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::21) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|DU4PR08MB11792:EE_|AM3PEPF00009B9D:EE_|DU4PR08MB11746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d635d0a-fed1-499b-fe8a-08de88f712e7
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: fCKh2CcsUN0+51g+eZAIEscNgxwv8ZoTv8P4mpisMzumY1EN8kIpl/CrTb0ZW76PG+f7em1hW8Dp4z9bASxpP9hsrn6DB1F1twfZy6czoKlaTkeJXkCCCEWDKiI7T/tLD5pgvvzRTFWcovEloVbu/m4puMA33sfcg2GnQG64vMUogY62cuQGnv91CmxVPeb+wgN+r9hSey0iLVCEEVOayv8Mo32FfhSNj7kEfzZ8Om/cPTe7E58A0odcH/8RLOjz5+xKiqXtfhpnXxC90evPAqvOeIdj0uCbH5+8k+9KpAw1Uppc8cshd5khduqVb82j9d5iM5u4K20t7b2oZEm7kytePxGeQprjWBtTthmwvxLbd5BXB/tVdrn1F525KKXbOWSX0K58J03KwysV/zHZfbeaWNcrmooYKu4ImisA4NWgoY0doxutV2fKtuJA+9lx34VRE/8ZKGM2T6W+ihj2aRjki7ShnUtADOuFM2jr2mW4voCqkm69s7DnEs5sRiVSnhPIQx/fRiq3QYfbIxsXzj53k3dKgt3wDpGnfHRWvTIvQqrLBF0ECObYjjevjRI7uZ761XnuDVI5tGB7IkOq9wPuWvQHp3cjabU9sdDUL/NCUosOVdwu/zQYvM3oyz3WNL6LvNTwehZTqoii0VTqgrG4+tQ5gOEHYcTjXzSkh+KnFDU7VjLdIPG9qB5TiPGoyYxcT1O5XjdJB7IGMvkkh7QpsicMEHlOrsiyUPublYQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SzIIqqktlOpbfO1k+p9llRfZ7DsGU5y29tjEHmoVkAJgOJtkpolYJ8DEqrqwwLmDyWTnZhr7Blci8gxrbAzu91wl6pn3wboFddWgtpPW2wNL6E7U+Tg0YE1/0GUhMJ6/fcJRQtPfbBj2QbBGEazSeVPcpd7oOuYY2URO0y0acN+3L7L80+DmXhOJhi9/jyAwhlEtp5dSPM64zpMLXDZ4QULgaRDXYAhXBdrNjvPooZugXy+bbrZpt6UNGYCaf3ZIGVO+n4WHzQTOJGMUeLxCp2jy7zcsru0bxMCJP/9KCk3UgEw/gst5XEH8ltMal6q4xEXDLeOiWcG5tjy4zxRFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a70df7d4-4c4b-49e1-392c-08de88f6ed4d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|376014|36860700016|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SPbWGf5hkltbxFy6ibdzvYRknaFXqlvvPG2ZcREE+WbrCh2IBcIxb5KHfc0zRR/H7wfMyaSBq4JHTepyOcYTn1usZiNKjwIDjl0yGsv8LDe1NLPAIAK0iVEl5vZnVbi63ThRfDPKfJo+UEkrXczDVZ5An7SCx8WWozw53GchUbACJZYSDmTLYB/sQ2xuimFaWBy04M8EeFIXZ+5DJCzE08qOK+EkBGp1ipt5qeq9MhX2gJpC07VaTXkqiQnh+HF7tOdNJww4TCYKA0NmiPfLOIybJK62U4+zQxmx+jUUmTXQOT7ALJpNKtzIEDQ9EHbu9wxB+6DX8FT54pS3AumD7bVgixCkJ4erqEsgPaawO0lcJ3UelxdoNjMI4Y4PATGS8yFFFcjx4dciIaDmBnG5CE5OCeWrIO8zNZLtSDoLEk0iStGSYBj0NuwUXcGH/D1gFanl9ZKra7VsqVDK2OSP0mF8y1VxfZqVoOCO/HKuKt+JLQpiyQfjaQkoTqIrO6SUQh3Q7c/Y7WdTKXBRaMV95wFEocmPatZcmBiHGR18H5DCZhXytZzPizYDRAf8zBrBEQN3XK4c9IU2YOCyw11o+ec6BANoMlxsCqdn4sqTzJwvx8Bqm7856jOWGclwUmDLWrd1w4xZk3hoydiBzfwA8hZJwbdOjznufcVeN71mIxc9OsZec+gsPIpKQUlZO7qzzWrt0dg6gp3HXEYbu0p5RXCurjmWDCXQKk/9nl+yo78oqM0X6ZpYBffoMGHG2WAtdwSn9rQNYpeDYC3fa96GFw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dw+Y05prSn5Bd8C44s2j1i2YmwCOQ+pX4lEBkNf03XEeh9nS+ZIGi7c36ZPZnspv5+bKZBwxqGpWsIMzIQ6yHiuEi3DiuIpw5UqCAJcLaEUcplQwg2BsYJBm0nejHeCGR5tY0XqrPvq7j4W/huZx5rQ/5ztMMlzjJFY0jKKR4/r9G2nbgEwiV4wa0efvhZt2rUPQi4sbVk85yQgHO7mpUczmcMkaCMRfabKSNOb/LBgsjD2fqxa+UtjzVX9Gau0BCfZUOd6S40HHULMfWOwy0SfBGQG//Q1xIx48H5w3Zakdl9YfUXIVQLMZXIr5GiqZAkby7kaRZlQdN3mgiJNA60Ur8FhjqD/tffo7zMWimowpuaNB5USIsaUSzYUzxMsNEZN4vx9OnOwwIKX9lSwT50SThyEYQH5TSSzCMiQd4ongAjCXpBAXn//nEw++Qfmp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:13:08.7607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d635d0a-fed1-499b-fe8a-08de88f712e7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11746
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

On Mon, Mar 23, 2026 at 01:16:30PM +0000, Liviu Dudau wrote:
> On Thu, Mar 19, 2026 at 04:33:48PM +0100, Marcin Ślusarz wrote:
> > On Thu, Mar 19, 2026 at 03:17:36PM +0000, Liviu Dudau wrote:
> > > On Thu, Mar 19, 2026 at 01:39:40PM +0100, Marcin Ślusarz wrote:
> > > > On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> > > > > Hi Marcin,
> > > > > 
> > > > > On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > > > > > ...
> > > > > > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > > > > > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > > > > > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > > > > > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > > > > > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > > > > > +
> > > > > >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > > > > >  					struct drm_panthor_timestamp_info *arg)
> > > > > >  {
> > > > > >  	int ret;
> > > > > > +	u32 flags;
> > > > > > +	unsigned long irq_flags;
> > > > > > +	struct timespec64 cpu_ts;
> > > > > > +	u64 query_start_time;
> > > > > > +	bool minimize_interruption;
> > > > > > +	u32 timestamp_types = 0;
> > > > > > +
> > > > > > +	if (arg->flags != 0) {
> > > > > > +		flags = arg->flags;
> > > > > > +	} else {
> > > > > > +		/*
> > > > > > +		 * If flags are 0, then ask for the same things that we asked
> > > > > > +		 * for before flags were added.
> > > > > > +		 */
> > > > > > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > > > > > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > > > > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > > > > > +	}
> > > > > > +
> > > > > > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > > > > > +	case 0:
> > > > 
> > > > Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.
> 
> OK, are you going to re-spin?

Yes, as soon as we get to some conclusion.

> > > > 
> > > > > > +		break;
> > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > > > +		timestamp_types++;
> > > > > > +		break;
> > > > > > +	default:
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > > > > > +		return -EINVAL;
> > > > > 
> > > > > Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?
> > > > 
> > > > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
> > > > clock type values, so we still need to validate the bit field.
> > > 
> > > The if () test eliminates the default case, and if you change the switch to:
> > > 
> > > 	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_NONE) {
> > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > 		timestamp_types++;
> > > 		break;
> > > 	}
> > > 
> > > then it should be equivalent, right?
> > 
> > We need the default case to detect garbage values in the part of flags
> > that ands with DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK.
> > 
> > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is 7 << 1,
> 
> I understand that you want to make sure that user space doesn't insert values into the
> flags and then pretends that because we didn't return an error that's now part of the
> ABI. But then maybe you should not reserve the extra bit now if you don't know how
> it's going to be used (in other words, why not make TIMESTAMP_CPU_TYPE_MASK  3 << 1?).

I think it makes sense to reserve this bit now to make it easier to
extend the interface if we ever will need to. Changing uapi definition
is painful enough, so reserving this will rule out misuses of the current
value. Another point is that we would have to validate that the bit is 0
anyway, so I don't see why we can't include that bit in the field that
is supposed to go with.

> > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC is 1 << 1,
> > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW is 2 << 1,
> > so 3 << 1, 4 << 1, 5 << 1, 6 << 1, 7 << 1 are all invalid values that need
> > to be rejected.
> 
> I am confused about why TIMESTAMP_CPU is a continous range [0-7] while the rest of the
> flags are bits in a bitmask. A note should be added to the panthor_drm.h file to
> explain this.

Well, just look at the definition of struct drm_panthor_timestamp_info -
there's one to one relation between field and a DRM_PANTHOR_TIMESTAMP_* flag,
with an exception that CPU timestamp types have only one field (well,
a pair of "seconds" and "nanoseconds", but from logical perspective it's
only one value). There's no known reason why anyone would want to query
multiple CPU timestamps together with various GPU counters from _GPU_ query.

> 
> > 
> > And since DRM_PANTHOR_TIMESTAMP_CPU_NONE is 0 << 1, we need it too in
> > the switch to not be caught by the default case.
> 
> It only makes sense if you explain that TIMESTAMP_CPU values are in a range. I kept reading
> the different versions of the patch thinking that they are bits in a bitmask, with
> TIMESTAMP_CPU_NONE being the logical state of not selecting any of the sources.

That should be resolved with the documentation update below, right?

> 
> Best regards,
> Liviu
> 
> 
> > 
> > > > 
> > > > > > +
> > > > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > > > > > +		timestamp_types++;
> > > > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > > > > > +		timestamp_types++;
> > > > > > +
> > > > > > +	/* If user asked to obtain timestamps from more than one source,
> > > > > > +	 * then it very likely means they want them to be as close as possible.
> > > > > > +	 * If they asked for duration, then that likely means that they
> > > > > > +	 * want to know how long obtaining timestamp takes, without random
> > > > > > +	 * events, like process scheduling or interrupts.
> > > > > > +	 */
> > > > > 
> > > > > This comment makes me think that user can ask for both CPU_MONOTONIC and
> > > > > CPU_MONOTONIC_RAW timestamps, but the code is built to make them exclusive.
> > > > > Can we document better what sources can be requested simultaneously?
> > > > 
> > > > Somethine like this?
> > > > 
> > > > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > > > index 8a46ef040c3d..0e455d91e77d 100644
> > > > --- a/include/uapi/drm/panthor_drm.h
> > > > +++ b/include/uapi/drm/panthor_drm.h
> > > > @@ -466,6 +466,11 @@ struct drm_panthor_timestamp_info {
> > > >          *  DRM_PANTHOR_TIMESTAMP_GPU |
> > > >          *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > >          *  DRM_PANTHOR_TIMESTAMP_FREQ
> > > > +        *
> > > > +        * Note: these flags are exclusive to each other (only one can be used):
> > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
> > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
> > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW
> > > 
> > > Yes, looks good to me.
> > > 
> > > Best regards,
> > > Liviu
> > > 
> > > >          */
> > > >         __u32 flags;
> > > >  
