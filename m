Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E4606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=LIVE.CN header.i=@LIVE.CN header.a=rsa-sha256 header.s=selector1 header.b=qlE1Cz1V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2A510F319;
	Tue, 20 Oct 2026 07:36:45 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011029.outbound.protection.outlook.com [52.103.66.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B0C10E6EB
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 20:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSXZTzLEdM/Pe8LPqpLb2KzmE0LI33BsVNktcYrT5CKRbk4q38BFShxXtTek2VDawgBp8CUDYvKWK5OcWA1TQRfdyb+svJ5vWyzAl+mUFuyq7s6XGYnu77+IAN+o4DcOuMVY+dmtesGrLX1N+6dh8jpPAUcw+NcmxlZ5qbPN1+iEC9O8SOb5iBo/JFSWDka7cnJ5mGS3M/gauMZrn5Or3C5J0GlAA/KyDqSAQlToN/gm5/tPfPcMBrqVfVynhlyhyuCvyUNdMiJF0r0hyh4YRn1LZw16xplnNmMVt9/yuShTTrWUyzj1PKuHecy4vfW/MewpCVmZRQv01G7MvKCBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z8zKT+SfctimGEyEXF/vFgnlaj+3hbvFo895qqp8VI=;
 b=D6YaPJH7yZ7yPlQtysYC6I5yAWWM1cr0kX9fd/9z33DudmvFwCQFYOesD73o4P69AmlQRx9F9IbbFTG4UrJtIz8qvDByj4EEj/ICm1EXUwBNJtDpFm0h51y1IQZd0Hf20Vjge1l+gI8d6+Xjd4w8FQzaCYq5p4esbMCr12ymz7gUVjV/uYeFiQ1UDLzdYKMuea89mnC070orI1ogKXzBxmUHBcPhfGR59JeznrtXauJ+C8DA5IDXAk9+mGW6KNF2EVVR3M3nRAqUiRfIIJbKBFmMS4pQhZA9uJPslkaTzR+W/IaHHV+rBHbj2nRdjNCjGtilI5sKUnEL2Oy+68N5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CN; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z8zKT+SfctimGEyEXF/vFgnlaj+3hbvFo895qqp8VI=;
 b=qlE1Cz1VqOtImBur9UDHk8RUAPbpsX5gWwS5UM+lkSGgYamVLOV6K/lxC9KjdcfNO7rPRGbUmUWNJOfiMCPmhCJA112BwdSQ8Yc9dww/sagN/qcHbu2sD2kmyGK+Kb1b2ndpA9f7YA/qW5pjZTu5Hyp8XfjmxaWU9XvVoP7qZECT9rQ780wskW7O7r/SAFTNPUBnJnsuD3uo8NosyCvaPpwvlQKqR10qiLntAeV/xEWWsa522QIQBw9qmvVEzUA9Pu/Bz9V5loS3aSF55wLL2kOvVemmvqUuqfMqeJrzJ/66pjpbyoafNydgpTneo80Jayb2UljuFjMhwZWhA7bGig==
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:30e::5)
 by OS9P301MB1584.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:404::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 20:37:35 +0000
Received: from TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60]) by TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 ([fe80::2834:779c:2a80:9f60%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 20:37:35 +0000
From: CatMe0w <CatMe0w@live.cn>
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Date: Sun, 18 Oct 2026 14:37:22 -0600
Message-ID: <TYYP301MB1525C9BFF791357B5AE980D9F6992@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <d7028fb7-da1d-416f-8038-0c4cefdafb8c@gmx.de>
References: <d7028fb7-da1d-416f-8038-0c4cefdafb8c@gmx.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:30e::5)
X-Microsoft-Original-Message-ID: <20261018203722.61367-1-CatMe0w@live.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP301MB1525:EE_|OS9P301MB1584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b60a805-6a71-4555-3b49-08df2d57a3b0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|25010399006|5072599009|23021999003|25031999004|37011999003|260925184616899003|8060799015|19110799012|24021099003|8022599003|440099028|3412199025|4302099013|1602099012|3071699003|10035399007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VsfZ+KpAvQfjqIYuEX/3KxY4W/4Vt4e4SnNsN9SAed/SH4pIti8bL6Es1ujP?=
 =?us-ascii?Q?ExoCmmfC7uPa8mYUoFY28SLOwwYI22olpxARW0p2KP5oOmKKqtvbXSOKpuy+?=
 =?us-ascii?Q?x6SyZ2hjvvguJpZFQAxc4QFFIRWXiVheehufl8bmTBLrISpTGDT86mdmXhPN?=
 =?us-ascii?Q?Lxah7OVuSRUelYTVP9iDlGnODKFuvKupP/VAscFYZQrbI5QlYKaGOpfhGKwI?=
 =?us-ascii?Q?TGP2UFWUjFCn0Jq0nX1OuLDCw7RC/ZsSiAnn1vetbtm/f3sYDGWCUrynJ9br?=
 =?us-ascii?Q?eurBwAF2yQtBXSXYloAVZJxeHvUAasKoiQRAGIt37ckq6lwn43s+wVvOwiGi?=
 =?us-ascii?Q?yhFavxwM+USkyhjU30UlzeKIebDx6Xq/UrCJzh+Nk43l417220Ou7RU065JY?=
 =?us-ascii?Q?kOCwj9fn2GnRqQ33GwtZl7gizyB02Fn9OKqLY6pQRtIxlehQpksIhlvR8Klg?=
 =?us-ascii?Q?ZtpCfcjk33NwKtJJm8VnlM7faW4iIMjmVRQWsNO913ViMbXWrVWR6+D35Pex?=
 =?us-ascii?Q?s/yVOUl8ruJgIXZzQS9uLeNEMNLnpvSes6CE+D6JV+oDJu8B08Cdtyj8vpFP?=
 =?us-ascii?Q?cZi4kxM9mfAJQZ807jJddaUuxHt7LBDTgeWg+kt/FHi7ozODAkzHDsMd1lCH?=
 =?us-ascii?Q?Ax7uTxrZsgxCz+b1WHD9XFAkXo/kta6/cH6LRmeLkeSL9uM0eYClMSuh+EX7?=
 =?us-ascii?Q?HQQNXjgui3+F6y/l3kcAsjHSpwW2ukUsB9aM2GsO0VxFOlVTtfQk3kfSZ4l0?=
 =?us-ascii?Q?6NeFr3xj5pFElgjw1Tw5W/qn01OYfy9eOkVxFcKzmcWCgckbu/GPxs1xgmRR?=
 =?us-ascii?Q?XKn/wmuPho8LvTEoKY+RduPJ0pWaoRklJPBxzd3weDv5EtAaB8LGOf/QE1mD?=
 =?us-ascii?Q?WdetyS1XIFS1go7WpQHSBKxykuMVI03RIZAFA5cx68qdrN1e16GTyeH2NkvL?=
 =?us-ascii?Q?8PeVkKe/qLP8WHktR6Ck9xt6U4P/K06b/SR/PMszxfs63ujlVWxwEsfO9jxD?=
 =?us-ascii?Q?qIDhQ22eV28O/ebiMUuEi1XJLkDN/3jZZnORuL6aMjgw9No=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WB7BfLCQOVRUJHna8mrvICKd8K23Go3VI5lOeqB2uSiCp0FehcOdAeR5Jf2J?=
 =?us-ascii?Q?uG/PuX3sg+ZINuSD8bj6usCs6MiFvXdurMZ8KtMTLl+H9EZxweX3JABV4ESa?=
 =?us-ascii?Q?DKYWBpo2nfOtkTGDM/tj5h+ndkX9TQBGQ00Ws7oSFZ9q9QT8FlLfzRXHlKEN?=
 =?us-ascii?Q?rroYcDgMh6aW7O196xAB11YYRL1gT6ADl93iZ4YWdd/yWyaD2PMiJjmKC7qI?=
 =?us-ascii?Q?PbwuoVXAXsMEpoK5lnZF+r8X+rNPzDKNXyO6VnPeDF9Vn/yD/GisQGVENzSn?=
 =?us-ascii?Q?7N7JQ8Ndx7n6kotKIEut0Zan7uFblIyuuoOJTKOv1GZiMWMKfd8bghgHspOd?=
 =?us-ascii?Q?ZVG/4ypA3obqnK2U9UHLNqGM+HyhuFg8rk6dyB7RKUODeuVDW/ur89ttLhmQ?=
 =?us-ascii?Q?8fSa+0qYyYrsezeXLN6hQKrApcrW36kI/PKq4pTmHZfrSk/BYoMgJILMdxnf?=
 =?us-ascii?Q?prFTh6o7TtkuvtQy3vAVhy8k80CROfG6ZfAEVsbb0DuXXbuiwA1YYIBD2iqW?=
 =?us-ascii?Q?jtE1RT5rfkAeF9c7i1pIjjo/amOiJ1f0dTTDFMycvLLKvpQwFcCGFfK7jhLE?=
 =?us-ascii?Q?fYk6MuMqrkd3AwcK/hYAUYNsuO5EhgqUKTNuVMcMDS/aGMN4DqgSuBWVXHoD?=
 =?us-ascii?Q?rATlnw5ZGROApCv/OEm0vy0QNj/ZcU2G6yfTGNE0mzlfKGqjPHGH3cmqWgQp?=
 =?us-ascii?Q?dvQiQQVI/j3+Tnj34CCXglagNQFmgx9UbqpL7DkidSn2iBDV/Iy2I2ZMBnxD?=
 =?us-ascii?Q?u4Q2/S/ON1GTv4qPzNF6WWjG2ofH4PpBtTD9tqxKnnaDyQsREBOaXaYtMFkG?=
 =?us-ascii?Q?sGsZDMgQ78KUIyvIP0A9ig43DG5VwSi5cDrs7kELU7/Wvn8OAJ3EpShuv001?=
 =?us-ascii?Q?CbWxv51CgV1iidaNqounRIq4U32ABDhzQa1+JCjFO2EGabcuwb/NAZ3ijBZa?=
 =?us-ascii?Q?g4D4Qe89JY1u+xsEzksrS6FZNUHX66lXct/fNtFZc5EGgfUrXoSNMavPaHMU?=
 =?us-ascii?Q?JDQqZ7CxMGkttkBXTpy79zrw3eSmlNzfiIxSTgt5ekKNG9vRKMxVhlEjiTql?=
 =?us-ascii?Q?YNeOcb/PGPmq9d2GVCh/jy850IwN3qu9K8qn5jB8e0TrG/2p4Jf+cHNcF0+A?=
 =?us-ascii?Q?aQ0lHPxRRF226PJBhEdf/SZ1yIrRmoSbD3sPrtklQzp8S2l34xmQ5olulcjS?=
 =?us-ascii?Q?TEFmmtz5sgQGj9dlCLPjItjLh0k3gjTjuBGC6c0x6IGaCIKY25XQTWA+khn0?=
 =?us-ascii?Q?EpbWg5a3jyfnefuZc9onx4YjGP73XFj3au4kW/eA+RNr1Vb4CDxibqlNvaCc?=
 =?us-ascii?Q?v4NYU8p99i3BI52mIkNUJOkDQBw6tnRGxNCOLgU0ttFtx/lnkQdHTqWwTTSJ?=
 =?us-ascii?Q?SRyljEcc8mZzcalTT5oJWLcmzImKlkWgiiwQrM2XVhiHlmmOe1ml7waacwKs?=
 =?us-ascii?Q?7+FYvfbOiS1X0SlTKTJaOyF6qmn968uo?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-a91ca.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b60a805-6a71-4555-3b49-08df2d57a3b0
X-MS-Exchange-CrossTenant-AuthSource: TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 20:37:34.9971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P301MB1584
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/26 22:05, Helge Deller wrote:
> On 10/15/26 11:07, Thomas Zimmermann wrote:
>> This patch mangles fbcon output on fbdev HW drivers. It's
>> reproducible on matroxfb and sisfb. Reverting the change restores
>> these driver's functionality.
>
> Huh?
> Are you sure?
[...]
> I don't see any specific issues with stifb.

Hi Helge, Thomas,

I believe this is the regression I sent a fix for yesterday:
https://lore.kernel.org/linux-fbdev/TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM/

matroxfb and sisfb set FBINFO_HWACCEL_YPAN and start with
yres_virtual larger than yres. With
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y, fbcon then scrolls
by panning and draws text rows up to yres_virtual. bit_putcs() clips
to var.yres, so it drops these rows. stifb does not set
FBINFO_HWACCEL_YPAN, so fbcon uses SCROLL_MOVE there and never draws
below var.yres, which is why it looks fine.

The fix clips to GETVYRES() instead, so the bound from 3637d34b35b2
stays in place and the syzbot report should remain fixed.

Thomas, could you test whether the patch fixes matroxfb and sisfb
for you?

Thanks,
CatMe0w
