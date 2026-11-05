Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31D606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=suZta/Cm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CDC112160;
	Thu,  5 Nov 2026 07:25:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BB011216D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipHoCFJvoBbIDIhAx7zYQhrTatvM9LTE3grE/u4QRzLqTOOLyhzujPMqraanOGqM7on1oJjEMD4BRrIWW5KrA1jOCg0/Q1x5MznaZVwixydL1mWk5+JCY2Fht6W8tBqavC+0jDL8PYvmZm4fXBnVwKbudj4/KNNIDwu2XQMu2uqBvSE/N09rZHXesa1TKlrPkTCfONvfyLE7ZwjAGMlVJcAXUQ9lJhczJ8rSKDL2LkcMwGHp3tfoTKcg+dUmOIL+gaQcpY4nL6q+V3Ad6z7oB3ts2QAUcFKkuOyW4hycZ4nKfmKmzZBs7CnekT+HyJSOm2uX0Xi3zErRL/D5LlMCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB7rtAMTb5dQAG3k+up8DxQ/nrYGgyd2FmTDTwvGZE0=;
 b=OMyDjEeGTl31NC6cIycmLcYQ3iDly6s/7acMNMDybfme41Z5nN0nfUHoZ0PyhKEC/KIrxmyfDa+88c2FOh8mncHZ93FuCRAJ7DFyjdSlzrwfTZ/V4PGBWlEyYSMmFu+nffEaUP18YG/qBMpX11BJFl8puwI93UJJqL4FhV+NtpwuY3OkVnkrMYLEwgT66y880bIfhf1YDeBQbB3GWjksGE5Aq/XcCrZw79XdbwWcHjbrG1oYUgCbDQkIJgGWq9dRbAiSRkDWSw6116H8EqIbH0rc/FIv54xD0dQAsJnsF6ckiUiJNoSKVSMY1IOO8CmkhehkCqJZUakhJK+HM6GvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB7rtAMTb5dQAG3k+up8DxQ/nrYGgyd2FmTDTwvGZE0=;
 b=suZta/CmCAvr+4Ry4LgnbaDdbhzy++ySLJkHirWxr3T2GxM17EkS1IyO4nUc//Xa5CkHwGl/6P2BqgaVzgRjZL4dYF7qJs3hsrAib17GmyCukP0cMLPAPMajfwPdKzNV3iQkgCNiArjQHy6eQ0iLEl1mPlkxF4ZojF32m+lSgDeIWe7256cfmcLkqeujbB8cNuEx2EDIAuUqB/mSRVzRxgSCIXrG8eao9dgmwHATcvWZZffqbikU3+Sia42Pvcszv7BdCYrb+xKSDJ98sReOUZuATFEVx4UnlopZQ+Lsed7i0i05DMfv0TD5B6EQYfa2RHh8faAKgYbeB3bo96gJpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB7573.eurprd04.prod.outlook.com
 (2603:10a6:20b:29e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 07:25:34 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:25:34 +0000
Date: Thu, 5 Nov 2026 09:25:30 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: fsl-ldb: Remove panel naming and use scoped
 device_node cleanup
Message-ID: <auwrIKJi-v9svTdW@vm>
References: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
 <DMMMCJHUT8EL.1L6VS1X1K2BQE@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMMMCJHUT8EL.1L6VS1X1K2BQE@bootlin.com>
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6a9cb5-0924-4528-9e95-08df3b0dfb19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|7416014|1800799024|23010399003|366016|3023799007|10067099003|18002099003|22082099003|261102123227099003|56012099006|261022075727099003|4143699003|261021121427099003|261026121527099003|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info: dxhkbtZJidegkMDZQ4h1IudeYw7qGkRa2TmzCCphHbdvvBPciHonmBVLJlfxeaWibTI1pOY9QKNasuI4tSuh6UBOQiFo1uVBh/OgJYBf6p2MJrKdIJwjF6v4InItkeNcLbUblYV0+GDEtHMbzIHI7NHRf0WDEDy/74rxe2tASuLtXTKadsUd3uxVlJA2MJh7b4nBRDfJTnYGNuDbRWQkErp2UyTIEZ1av24hp7ucgWwSjQvEi97v1bLGelWD6UEh7oR37TmYvtdEA3f9r5nSkp3Dg2B3kRNUcE9yDcir4rNYbNieb6kGbMJf/nQhSPKOxDFl0+HGZmAcjIrAipti7YSQ6tHkdpPLRbDG+42KlT0DLMQYRArTfkkuYfqw/do/Tn50g/5ynCcmj422uxhHAoU2Ke2ohR64o4SwZMDdG1oQifP8cLhEw2dO9xkINbkJOwRsAQi9AaAiKbCUxKMcbFIx+ST1wnAu6ljlNpYpvlZqaJMIsAa2xueOV6sJe4ipe/XD02PZUzjCyDBML1DrtQVSLHPeiI6R+/vDGts47FnL9/x7hOIKmarii7uoqaaWur25/crBN3/ydAxYRSl3PzuCLC4KOQaX1m1phHotqmVEWe6SUaoMBDiuing0ejd7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261022075727099003)(4143699003)(261021121427099003)(261026121527099003)(261009223027099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4Y2ceclYACSLmqL9WJ6TSCJJBDsmn7KAy7bfL6UJJqNJhZXKdG9t/Xc9GCO?=
 =?us-ascii?Q?ZqM/gY0LaLZZxgK4wBzO3Eq9mIBtC/klmYQ0cB/be++1ad71T5jdGRbIRDHn?=
 =?us-ascii?Q?BtjKQufBGtBhfbCMilgZyLoPDiIWopJHfnN3Aq3zsz+zuCsc66p1YfLDMdnV?=
 =?us-ascii?Q?EyJG52Etr7Kt7zRlAr3XAxHqOlF/uzV9AwqyzyfYxZyyi0iIO5KgcPPRD3t9?=
 =?us-ascii?Q?Hj8di7QTLpKhOfBvAYZrNowsSfYVxqm995/W0LKHtSGIprVnIwY/WX+3u45S?=
 =?us-ascii?Q?M/yN14lxhqEiFt3sqopXog2HDE1WUqWFKtgOQN+hfBvSF5HExU56cTMB2p5u?=
 =?us-ascii?Q?8le8fnQ77zeziVU28yu8IKdU6lzfZJ/yjaRSln6AwS0iN/5w6G5+Xy1jcA7P?=
 =?us-ascii?Q?LFgu7fTfdY1N88rdrZ0x/z4gPObayTOWXgTDEKvlFg0n4A/jnSIflr8MD515?=
 =?us-ascii?Q?ZjqCMKwkcGNhMub0cZ5wChR3wPdh0/ZbS8NiIgO+8qF6N0t8wXdWbvxs6DnK?=
 =?us-ascii?Q?jVYpWQQX+viQ+/QAkp/vzgoh6OD04CUSWd1WrEj0ybLraJiTf3c+ej1OdL/5?=
 =?us-ascii?Q?Jdrs5ntRradQ/hafmu9kR3utLNLdsW4rz4fpuOd4DTDgWQ1iRSlUglxnT1dj?=
 =?us-ascii?Q?vav1u+y8o91CB1j/lGpztvNAAgP0/wpbETFcJdO1KNC9kHW8zz2onfgtzspR?=
 =?us-ascii?Q?drI72EFT2Eh/SaS4DJnY9UBpn77Z7BtG6swUmfWUBfVHMrJjMvof37xY+PuA?=
 =?us-ascii?Q?pRgMpLjG5NhVC8dY7e72Zki7VdcrrbQW/1rxYy4fuNMzoCs0wRerHdzsGZ/7?=
 =?us-ascii?Q?ozovGM2h+E9vjUqo5x2BG5t56xZ5FSjgHOxHQbGci9kZ1E1rfi/UyVXpOO51?=
 =?us-ascii?Q?r9AuLh+rZGER5fcLTDB2OaoT+in+TXub9iF9RpncOJ15XgAafd8cRKiTvqZa?=
 =?us-ascii?Q?4JUF7xWgvu7bgfHOrUk7w5vJFyQnrewJut4WSHXjwQm8Mno1Bp6/7WBwRMGy?=
 =?us-ascii?Q?tVzuOmfeRQt7xf3nAXyFhLsiB7MTmPKEilA5mcj4dcyUM506466hmxOaX5+3?=
 =?us-ascii?Q?F8ySqsKM+4RDENtDvVe3OJ/gJYrnlyIaO27mBJLaTqnnWwUl3AgXLgbR1sTw?=
 =?us-ascii?Q?O9HrLh72zcd43zA3du7zzPzYc3Pg9gmFAQUxbLWs09LEhmI+LqVm0wIuBnFw?=
 =?us-ascii?Q?uKIaqhQjZzy24TdMeaEzhUmeFuIEBxc5koAPD1FKbMBs39lVyCyhIS5zk4nb?=
 =?us-ascii?Q?6UrN/EEJd3wX0fNqBgbt9mU8kTmFQH/ymu+KabyTXwO+kXXxc26HM7ejykcm?=
 =?us-ascii?Q?2JJIH2nNYtrknA2Ka9oxwPuK/CkK2g+U+1DKJpo8cW1kWKWKnq83UhJrsZlT?=
 =?us-ascii?Q?h2OpR0jpEHCxqnASo5zN6AzSGjJtM85mVQr6cSfcmgAWyBacQVey5kgB3Ltl?=
 =?us-ascii?Q?+0eogkwpD5xaJQmYeSkSQTpWgu++8ZGDTR+qwOjrZrwC/sjHEU9A3WJ+OS4A?=
 =?us-ascii?Q?a3AhLRL7qfoxkO2sz5mS99GMYbMhi8zHo54FGez5xo44sT9wr0BO1YAtxCik?=
 =?us-ascii?Q?Z3qhfbLJjitXd7zvMnNvPCJY7l7Dqx19HDN9LInSbq38KDZCI7G6jjc7atKN?=
 =?us-ascii?Q?1pT9zkxKubwut3R9PtOttD5scbc49tnvEx2qaHHddbJoJaArDNJgqIDfLI9c?=
 =?us-ascii?Q?X1uCTnbjk+BxcC7gfZzIdaGtfhQdhEWN5lshYa8/JGP/z8tCzGvesw27qnVB?=
 =?us-ascii?Q?DA+2V41Ceu4kNtTmvs9yrqp9KCu6fDQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6a9cb5-0924-4528-9e95-08df3b0dfb19
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:25:34.5608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVV14Zp7xvBHfngcz5UlAzbP1nL5bnYh1TA9bHenBNU8vwoKvLsIWi9xfjeuipN3gJTUVPWXV2FRJYVU/053Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

On Wed, Nov 04, 2026 at 06:56:41PM +0100, Luca Ceresoli wrote:
> On Fri Oct 30, 2026 at 5:32 PM CET, Laurentiu Palcu wrote:
> > The remote endpoint node is not necessarily a panel, so drop the "panel"
> > naming and refer to the next bridge instead. Update the error message
> > printed when no output port is connected.
> >
> > While at it, convert the device_node handling in fsl_ldb_probe() to use
> > the __free(device_node) cleanup helper. Since remote1 and remote2 now
> > stay valid until the function returns, pass the selected one directly to
> > of_drm_find_and_get_bridge() and drop the extra panel_node reference.
> > Do the same for the dual-link port1/port2 lookups.
> >
> > No functional change intended, other than the updated error message.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> I wanted to test this patch but it does not apply on current
> drm-misc-next.

Sorry about that, I made these changes on top of Dario's patch [1],
touching the same file. I thought that would probably be applied first.
FWIW, my patch applies cleanly on drm-misc-next if [1] is applied first.

Do you want me to resend the patch so that it applies directly on top of
drm-misc-next?

[1] https://lore.kernel.org/all/20261029144132.572020-1-dario.binacchi@amarulasolutions.com/

-- 
Thanks,
Laurentiu
