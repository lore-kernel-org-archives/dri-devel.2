Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDCECCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEF210E021;
	Fri, 16 Oct 2026 15:17:58 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazhn15013061.outbound.protection.outlook.com
 [52.102.163.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24E510E021
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywErEqBZpEldtceB3HOwT2kev0kpQWfb5zw52asCSdUysbFHtiKHT2zzLqOUNyx7dr61loP9PERgAPFKH9q3FnDHDVeCcKSMZxQ0qI3Ja1kYoOlCiK7ZQRuatjOaV3kLkMX4DgUW4hpyseMQJB+hkJhiXinT3pV+mCSM7CwMS9HMlhO7ltXz5K+13umfnXV4sL1S1rSpcwlGtjFCeLtmy/Q+C6V3dJju25UkSU7uslpIa4PbgUJvsJ/Y85kT4JjPJ2Yzcbm9sU1r7Cnn3RoofjIsmsP7OffaS5L6q5VtXk1jffD8VnOhuIAgsEyOSA7Ya2/Is/SE8A/5D0u83SmSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BWWmk5KwjgXLJLh6nH5pqYovwzJyYU4JmXgnhA/UTE=;
 b=SWuabv871fzwGnC+TiDO0v+5Fm7vvt5XI8ahIiT4/wxZlm+S3TAEydmGrBtAs2sP4OR3utAJxleGglqoqeiouee+OYQMe+/96npPDPNe5MzKMjmnEhqWKLhsghyMqu0ppx1+wDHmeQOLiNWXmfomueXCZHyWyQthIRP56lrhDZweke5fGNtEgvXIok0yupjXBSi2+4X8B/ljSh3Z+BrzsVd8IGK1FSpyifyjXLTCgXxFCmLYH3qcctDUkSwu8MAv1RF71nS32AcakVW3QOG913iAUyGgqWCEeDoanCT83hsyeqo4g2kcFn+1jDQGnw9mWj9U7QG6+4I6VOj5gsoRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BWWmk5KwjgXLJLh6nH5pqYovwzJyYU4JmXgnhA/UTE=;
 b=bhcDvJPK4b1IsdXvNGst6l/liumDuCCC4L+Vok0T5P/b92WD1FMgssBByQq6XEQWE/A54V77gi/3GrBzlFPS/zpY/xg/k8m2HH/eLMQKkiiwnPbvLvJ6oXPj1OwRrWd5vnHZ8bQjSyBQudxgy2964VCNC0L+3O8dDOyp+b/w2FqCVMF+7crZVPbP/ZDCz3++1KWZTWgTSRPh/5GCEG7MsjstJPP2LPYmn0gL2YC+/q0Eqi5zHxaf93+qvM0s+S7eDhwPVl43LYxbVugUFZnnn0AYTN6jtHCFxpXpZenvHYui9bsLy23uymA/i6RPeNBnzb9m0lFM0FTsPouPikPimw==
Received: from DB8P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::40)
 by MI9PR10MB992235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 15:17:45 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::97) by DB8P191CA0030.outlook.office365.com
 (2603:10a6:10:130::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 15:17:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 15:17:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 16 Oct
 2026 17:18:12 +0200
Received: from [10.130.76.182] (10.130.76.182) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 16 Oct
 2026 17:17:43 +0200
Message-ID: <27650748-3041-4996-9138-a90583bbbf4c@foss.st.com>
Date: Fri, 16 Oct 2026 17:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/75] drm/stm: Switch to
 drm_atomic_helper_connector_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-37-586c9c026823@kernel.org>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-37-586c9c026823@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.76.182]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|MI9PR10MB992235:EE_
X-MS-Office365-Filtering-Correlation-Id: b8411793-7d3f-4271-a0cb-08df2b98a114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|34020700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006|12100799066;
X-Microsoft-Antispam-Message-Info: BVrUo8uTv6RDHqFLQUh9xCBR3W/soJ1nzhPtUEG3TBurFXZ5S1kTzj8nfUuQUnO9h8tgpYgJgJlg40da47xKhasEWIiyMXwaY0N2sXiZbJdupatG6uPPygAznYpxkpFnN+MF8f6sLyBCeOWYbjabbkqSwCR6tw+MOE6SiowKSmMlxm+FTu99HZAhfIhvSkhCJLygJMGpt4yBA6O1dgHvqSpWyf1I5uTmwP6ezUds/6e46tO1fL3XAHgK3xdTqjiSjM33NaVXar1wykm4TG8rold0kOhvDl/en+nxFGL0xbVibtmzMJapP7hpjlvXOGwlubZbxAv6xhEhIi963UAkBSFqX4YHOGdqhwFYA+hwwZYdk5PWMfk2Hj2WP7m9fNkuc8BcsR21oNf212NwtH7otSRPBk+8JMgUUD5tN9UHLGxFrarxLZgdu1dZzcUyBjccoVyrDg4J7AmWGGcRkKncGVtIaQP5VVwSkYpdZUQBLVjEqD8aciYrgWEYirOTvEpUsVCLgSztZnBjCnl82j15xEBhVikZMo+nG8JNqXaGwWzao+hB/vOElpzcFVRnEx2fxkshwmNngETt1zmnBzFlNC4FFVu00mmandBjTDvQjg2MpXdeXOML83zg1Maz71V1ZtUFp4KURlzy+x6ESmv7jVjuyC26WgAgpUnWxyN1KzzaJFCoRJbuxy9MbJJQ/+WBBEAPc3UvmAlI+ChnIwD3hQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(34020700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TS7kfqb0TbEphS4sJ2sqqZ0w5iDb0LTwsCCWd60QBqbCaqEFgGjvwZqKDb9YW2ikLNajtCUtUuHW/i+xUEOXAQ75WPNQusnUm2+6p4XVlOg3IrfCk4FQ3os4EzK085UjYI2tFjty0vhu6k+i9hPKZtXZzQRmcnR8eiuMwG6OJmI8c05lsgRXr1uccLf0sn7tqmzH9NTl7Lb5m6ThMs7/vAh+TUcpdQblcDxl2uTDK1FnDI93sK5/4FLnmGGB8GPc2uGtJyYcnjAn2P0xehPEqkFZbzV6Bj9LvpgBsQgfQ4t2l7/jibKjptTLtrbByWRjvCMB8kAFZp+EZAmeNJGsI3yFnNC1oOfRbWX08Go2ZYj/cR+LlJZ2lZJZ/27sUZui85mMmQcevoqNrDORrT9dq+1NgNrqfhFfMJl0UrkShYSx5KUNGEP8F2OIRt5TtyEW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:17:44.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8411793-7d3f-4271-a0cb-08df2b98a114
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992235
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



On 10/14/26 19:27, Maxime Ripard wrote:
> The stm connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>  drivers/gpu/drm/stm/lvds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
Hi Maxime, 

Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Best regards,
Raphaël
