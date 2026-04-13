Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4376F34C43
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA0610E40C;
	Mon, 13 Apr 2026 11:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MpXNKcqE";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013031.outbound.protection.outlook.com
 [40.107.162.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF4E10E40D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWmp1hhP6OqOwt6ucJWalK73XHlUgcIwg/bnEcTxIHpsAZ3nN8C2Jez+uC2oUd+Vxh/yzmcMPTlFwGiPfk4ZpclgmNKgwsm6U8Ms0P/aFRa99aM12KN7x2frN3A5ufXjtX+vikNizPz4YHNILCrHM1PHm1MzDTJUl0xdEaI6pMnEQMDHNyMuLJ6wP0DhaH2eQxuw6hwaogw5/bNA5s94TKD5/dvCoJEx1jcm/VBxnv5ZSCVLrfuCq/2gc0Ntg+0u75dOClrNZ/i8NuU4dYqcCvZaei0q6tUBM11ZWiUVBZgmARuZDKhFcnWrMTJ5A/tpSTK/NQTGHxerHu1L7/+ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cBndj+1OrdzmEv+QgTGSQmNkLH35U4GrGYozwObmUY=;
 b=S6qW77r7FPWwdjWTlbDksuC/rTRmCZVUhxh/6nM+b34R9mnY/O3ibRRZUCQVrxYFfC6nSXqMLSWX4caz+3MKO1rCgH72EWE07+AGo/tON7A9GT6odrfqIyGUW3X5ifU/Pobm/Da+YTp/xfgmaK30WXzdPsiQHhOOhMxYtb6OREZlvppHygyiTSqZIM5kyb/kmHs03wrzx2NdqNJo5Y6NKW0dElB5GM/vm1PYWHoUNkM2c+t3VcijnHmG4tip6MWYSrKyLwJCmsCToq3yim2eu9rkt7QMT4h1VSH4LtHl0Rg4vOSPJE+/kQoMvVuy0zZXstAyEfjzbndU4nVzIAUcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nabladev.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cBndj+1OrdzmEv+QgTGSQmNkLH35U4GrGYozwObmUY=;
 b=MpXNKcqEtUDt8tJ17nhf6fYqJep/VELDiVbDcyTFNBLqx/Xce4HnXTUhX5e86xNNKO/DOjv0zBzSDdG+vHLFZ0Md+wzYQWwIClAcAb4mIe40F9d3LtPJ7zYk2O2KxI54FfzKhpAWXTltbcrzYiI3S72NslIzXjuDuVH1tlU3SfZAIETwrRg36PA7sSr3NhAnVkddqEF/tqcD1c0CAtwyeA0ZyCCvJT1ENWMrHB8KrqINp9rqX1M8IK3MmqiRPcn7lU9RmJxz8aR7KQeNMyadGZPpKoAAx6ukahCKFo4myQI/iXERjCfbUTXOUh7E53ph/n4/mtRqP7FuvU7Ig9gRPA==
Received: from DB7PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:10:36::33)
 by AM0PR10MB3537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:48:47 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::a) by DB7PR05CA0020.outlook.office365.com
 (2603:10a6:10:36::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 11:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 11:48:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 13 Apr
 2026 13:51:54 +0200
Received: from localhost (10.252.11.107) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 13 Apr
 2026 13:48:46 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: <dri-devel@lists.freedesktop.org>, Marek Vasut <marex@nabladev.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>, "Simona
 Vetter" <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, "Yannick
 Fertre" <yannick.fertre@foss.st.com>, <linux-arm-kernel@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>
In-Reply-To: <20260409024928.344010-1-marex@nabladev.com>
References: <20260409024928.344010-1-marex@nabladev.com>
Subject: Re: [PATCH] drm/bridge: stm_lvds: Do not fail atomic_check on
 disabled connector
Message-ID: <177608092576.35288.17760549377022484534.b4-ty@foss.st.com>
Date: Mon, 13 Apr 2026 13:48:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Originating-IP: [10.252.11.107]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AM0PR10MB3537:EE_
X-MS-Office365-Filtering-Correlation-Id: 7359a7d7-694e-470b-fac7-08de99529f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QdCrhCi2txi+JerRjYf6H4gFCC+wdFLQeDr0ZlNCrV7vHiCxTPKcG+SukU9L5b3PhcOcrCpZUTuQn8puwHdP6JFkFlR9YaVEQGBHmivCg8qBDAi1CpFceRd6y7n14ZUEhIhcoQiZY45VvKZm/kBec8tXn87cN/P1I6ONbWB9nZlTXJLn1UgVhxe5iH1NURMRQR48VM0qfzyjnfqA/AJxkQNmtroh5rfmeJ21a3+FpK9rZVms0D+wn5tLOEnJN8KR4KXhAxwtt16VR1/+iC2u9dhE1t4VkjL8CczSqr5L3TTlF8tc1CUAxh3T6Kw+Tq+2ssCBgFhqtoYTvE4ELl7RjEYaNAJc+YY9Yp2MxkQp/bmyZz0DlbN1jelYoDBS7CjTFaA8MYazbQIdarBy+vm4nZVEwDRGSgDPLNLI1heYnFDFIglnkIvCzApJ81A1j51utRVnk51F0tvUhlq3c/CAoKCqpDn6up106L4+yTnfzBZpeKh+Vuw0nKKZnbliJ/92NEPcjpDPRrFJTh4/jEXo/iBoA6sHmKGF4glnvhLUJbYJWnliGWYu9/l553VnlMoQBW4Cc4aZ9qivT+WOG+T3Mwa3tM39s0GTDW4j7kZ5ScK9rABkeocDx9WW2CVjqw7Vqer2pn14TkL4hdAg4okIjeD+PTsd9xsQjUtR5EuaGMUMjYmFqAbhxHssM932V/lIHzX9ArDXQasL8zNjKBaCcv9QWG9SKQ5RZvDTjByFPqZUXzuFFrEn1JYp1TuohwgKlyu/aNboX+ni/Zfeg28J+Q==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EI0jKnUTLzDxuMvqa9tbcinCFwao1r6oks8anx/Sy1+u+XHkOSHmYQZAp7BR1821zwQQOXkpcfpKbdyJlXTPe34sSvS85QcZATWpM14oSZbdw+hYUZGdKi1TStePgNgkF+yiYjESAaQZm0ymcSrrYuDjeFuEOVKCl6QwLnzyWDe5PlFHQc+HMyjtCKAGOmHwVzuLURFKYTtnjbPFICn8H16Yg7QkQ9CcI3AWhIUGfc+pbjRC377bB/O7N7DM8Kj+7/bImp7Jp2b4Y3CE4JDpZPm3k9p0zNU+9Vsj76D9yvr33JHfJwm52Zk2s8vjlgvGo/gNGNVhnlZO91sxrjtA5GKhi3buGr6R1hds1pG/LpfFcP9UzgEn6Dt6YwXFC7HCDFkpezLVVJDMkIybjpNo+n9j6jBmelY3EnfuyRYuieHgUI1enaLGD6tDZVr3UhHi
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:48:47.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7359a7d7-694e-470b-fac7-08de99529f5f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3537
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


On Thu, 09 Apr 2026 04:48:41 +0200, Marek Vasut wrote:
> If the connector is disabled, the new connector state has .crtc field
> set to NULL and there is nothing more to validate after that point.
> The .crtc field being NULL is not an error. Test for .crtc being NULL,
> and if it is NULL, exit early with return 0.
> 
> This fixes a failure in suspend/resume path, where the connector is
> already disabled, but .atomic_check is called, fails, returns -EINVAL
> and blocks the suspend entry.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: stm_lvds: Do not fail atomic_check on disabled connector
      commit: eecdd4bd6e47bf0c8ff1e049771fa5bab7074c7c

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

