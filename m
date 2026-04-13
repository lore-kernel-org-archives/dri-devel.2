Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E9EBFD17
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099DE10E375;
	Mon, 13 Apr 2026 08:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gR1BfzDa";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E977310E375
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1omWcCQ5cD+oK2WH8AZg47tdkCd41wwBu+0nU8dxL7haznLwiK9fip4XF0M5AyosnzvQiECfGOzDbiF+kyOXjRWBk3UIBmRd5o0d4K+kQvy0QsOCXQYW2euAsEqIsQJd1iGkOKlLrQLxPlJZC5LeQ6BFlliTN3C01g57mtulH6/oi6S5Flse2Y9JBGoTLfOUDIZ/jQBfJ1PG1gK3QbqtBLyaFCCNoaOL6dbp7B6/XmkluE92N7+qGn40/5szMSoaJVj+iapZzzm4UdnpWFdnDE+sl8juT5GzYlLo5nIlSQJxlk4UHq8Zj7/U3odB2XNhP6e+3y6KMJ9mMvDwkUx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRsIjzFRAdgdUITkijWJXayB+2gBt8shsNYSADIVJ1s=;
 b=sVfTHEl/1dYb3q7/iaytB+2qFwF0g5kx9Xjy7RpoWDKCaO8boJf7ocOxCw2zplAhw0Aa1RaROm5L6v0k/jeaCbxc3JQfDvz64IemU8R4rb+hArqC5MnLS7pBH4CkBDQ0oLIZUo046u1mGcct/DmbMV6Ks7b8Pnfi6YAdC9CBbebCv/xgdK9Ow1M62vRJLIChRf9Pw19c+UFVF9Jy8OeC8B1p1wrX18fuAGfAByf/EhT68MnnJdgRkoDy82/nhFGXKUFmrIGiyqFNqewck7bxazweMflY2Z7fVaKvJeFFFb94XQxuxtVle9Jf10vG+fjQhqde1pWP+kE+5RJRgduc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nabladev.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRsIjzFRAdgdUITkijWJXayB+2gBt8shsNYSADIVJ1s=;
 b=gR1BfzDaIcahwVJotLoFfu0hg1rhpMEILtaR+tzwjw0mx4xgp4A6UNbyGZitLnyBGR8MFZKujrwhl76PkKfuJPGjSIVOWQnnt6nRLN74z79yNxQUXD+U6rdDI+LYNU+ginrMGkMUxu0OF8Kv3LjfcxK9u8hh3L7fJU0L7MjnCXi7SMIjGDQhJaG3RfjZ8nkjtDyI8mgm0PvvUdXpcJlNUf8v6d52enAfc0gZ0S1zHSOklm9CnVtbs35xA7vKcYQQzZrKtnW+E3Q88yK5Gu+08nXKh9QrCFRPwRGAOnMb/YlLWLxccpZZW0b1Lu6iqlrCaE+LqTDGnPXElELD5TQ4+A==
Received: from CWLP265CA0305.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::29)
 by AM0PR10MB3506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:30:41 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:401:5d:cafe::5f) by CWLP265CA0305.outlook.office365.com
 (2603:10a6:401:5d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 08:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 08:30:41 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 13 Apr
 2026 10:33:48 +0200
Received: from [10.252.11.107] (10.252.11.107) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 13 Apr
 2026 10:30:39 +0200
Message-ID: <c8cef596-642c-4707-af83-357ba70de02a@foss.st.com>
Date: Mon, 13 Apr 2026 10:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: stm_lvds: Do not fail atomic_check on
 disabled connector
To: Marek Vasut <marex@nabladev.com>, <dri-devel@lists.freedesktop.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>, "Simona
 Vetter" <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, "Yannick
 Fertre" <yannick.fertre@foss.st.com>, <linux-arm-kernel@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>
References: <20260409024928.344010-1-marex@nabladev.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260409024928.344010-1-marex@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.11.107]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AM0PR10MB3506:EE_
X-MS-Office365-Filtering-Correlation-Id: ef38b35c-e485-4b2f-5d87-08de9936f2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +6xq2LVpF0jTI8dY6p1PZATkKQ7j6Jy49CiACQkouBz6VNtACWTkArIiJkkXeElCchZqDy9yTwXLuQni3tDU13IGmVR3SB4Z/UgEzzXZCuReAnsaqJeyvWT/ie2BZzrfDdMm6gO6SRdpbrmkKA3wzjf59Cz36iovjp53TONNHgR1wPoIk7n0wp0EMqNzxcdJjDkEPSqqq+QPHsCX771DduA7hRFkX2AgcAHHJTbpp9S2FXIaHzJbXA+E4Hs7jx5DPAc3pjBOry7iHe58w+h6HNaFjAhvYFafaWNshxpQIe2u8rfxfrUKLcOvYs5CWfAvEegkku2Typam9vGR92xFivpcRRux3nXrlAXcwhGe4R04LFzHaF95WY8/H2N3vylyqdFqG3LEHTmUTbSwuqEmwc9m9EPoKvo08n/vvcR7ApdwuRW2yWiQS19oYnPSb738thg7Ep110H7lsqEx5r7GuOdfC+CtHeBwLtDLaOozrjfWwM4pPTjuyKTESPj4FG9UnSqHU6T7f9ffiM6bXlMS0y7wkdrFpbZb4vyA6pZhyqJm8J+ObDyFDfAXWRfYpYi/8zLL6r9W06aEuX4jYoYIdV583gxJi5y7mUKCVUoDPZOfZBU9zRNQSdg3FwXSt00TXnZBjJZvc+UNFVxAa4rKTUFRie7hLYRKSlElApDQfzYr2e6rlgElgaGNtbsmS+HhLmRQ0AOBzRfYR1aG1VSZ9iADI+zQwtxYGfmfZFuFfvmHT+kGYJYA9r/mToS4fvHc20oKoYpM47rCZttHPQvGRg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zAQW0ALHEVUOtflQOhMztauFhmVOT6tybvKEKiUipDO4TGxgouD3v7Sx180Ep9UVHZxpS+08grugm0ZpUSL9i3kXfTIIdvnaljyhRjmo39gdh30xN6yVfQRsXpjp2Du6XIx5Lh6Z2Cl0+vxuAdVH6AUGubnRi1Q1EEVTibyf3gUu6PaFQ5yRoQ9E49z3UItVphyLbJEyDDIX2aQgXL+Rf1DYJ3NKr3Aq0PyRduz/THiAM7kMCPyNu/o9c9T0ReGEgIKuquN3Vgb/AhERKnZzoQeL+HqRdKz0AJIqgiL3sWR8ZIXMQCZCAPRAGFNvSr9XpQiu7mgahE+oiMxSyJoTjANqsIrg/smhzjB1uJb2ezA71wMy100Os+RQHSifqCXhuQl0YH/L9S/9fwtzs8PQWEjz4Xn7U34RND79yyrepsYcbl62BFIzf1Rsc9ro+W+8
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:30:41.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef38b35c-e485-4b2f-5d87-08de9936f2b4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3506
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



On 4/9/26 04:48, Marek Vasut wrote:
> If the connector is disabled, the new connector state has .crtc field
> set to NULL and there is nothing more to validate after that point.
> The .crtc field being NULL is not an error. Test for .crtc being NULL,
> and if it is NULL, exit early with return 0.
>
> This fixes a failure in suspend/resume path, where the connector is
> already disabled, but .atomic_check is called, fails, returns -EINVAL
> and blocks the suspend entry.
>
> Fixes: aca1cbc1c986 ("drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver")
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
Hi Marek, 

Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks,
Best regards, 
Raphaël
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/gpu/drm/stm/lvds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index fe38c0984b2b5..25e2ba98f36ae 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -897,14 +897,14 @@ static int lvds_connector_atomic_check(struct drm_connector *connector,
>  	if (!conn_state)
>  		return -EINVAL;
>  
> +	if (!conn_state->crtc)
> +		return 0;
> +
>  	if (list_empty(&connector->modes)) {
>  		drm_dbg(connector->dev, "connector: empty modes list\n");
>  		return -EINVAL;
>  	}
>  
> -	if (!conn_state->crtc)
> -		return -EINVAL;
> -
>  	panel_mode = list_first_entry(&connector->modes,
>  				      struct drm_display_mode, head);
>  

