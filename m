Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A9606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YUM5jmGz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C7E10E275;
	Sun, 15 Nov 2026 07:05:26 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C031C10E20D;
 Sun, 15 Nov 2026 07:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBUdH8bszINnSQEWkYaaeR2eoUp8xZx0Qyma98NRrHZyVzKtEz8m8tOoEKrzJwp/Arv+PR+oj/us+ewf+rnzFWb1R9fcpksG3/OTQg3bIyC+yi7Jn0mz21tIrkbLlgxD6XHi6kcQnCtZ1yns7VflOfqEdAbmDLVNdQ/TzsjctItjN7bfHltUWXYmhiNvkCWacBdnDzacxgeWKJcKifytMVRTpeeqNsnzOAgSRzDh1AsdKu7Y3FGZXndSOQHs/KUV5/9Tv3tx+b6cXE9vm6vqXTgZ6WaPLwwFKBcL24sTv4JCCL5UCfo6TW4auL9eHv09PLr98sVMBKQa47gNVDJi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJk2U7sYzXBmSdICHzSjvZnousE20TadLP2gkREvEfQ=;
 b=RVnX5KoMxuhpxFJnbpENwH3Wxpxq4xKQSw39NKC+H4FWv4XJSnRg2pQklAIB4sTlu1IcWTYzmJQOt5Wewz+MSKjfN93svrojONtN7k+QO5tHszCnz4Esj7ZM6IdLG+yuTXZA3SAOqPRQGORuPeD6STgMkwO8xr8tWFVaZ1aK2bLYhI252m+cO/oiqKBUsGxl6Gc4NUPatJJB0jbP+K8c6iDzdk8LQLZdx9q0lbnrntlRp/4THZee0w4Dd3dF2V92Vp4wP/9bSDrupkH0G0JiYSaabyFGzRj0i4H6MJzJUzdXB+EtB6UMQ1VElFQbxY2j4mk3JXG7YcGz7l8gennrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJk2U7sYzXBmSdICHzSjvZnousE20TadLP2gkREvEfQ=;
 b=YUM5jmGzXlttRKBn4hdeBjUia9wKTbJZB5J4Ohoy0bk8Jo8pRP4lHkNPqkZxMRQxOBkUJUDt0zdVDioN7tol4ytIvE9kEpaRb22fOOLSLzEF0xorsWmG+A4sOo6wGWiqzNhWxJIPfASS+4YHaogLHacsOymeM13e0j64i8zdDP4=
Received: from CH2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:610:58::39)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 07:05:16 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::3b) by CH2PR20CA0029.outlook.office365.com
 (2603:10b6:610:58::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Sun,
 15 Nov 2026 07:05:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 07:05:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:05:15 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 15 Nov 2026 01:05:12 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Weijie Yuan <kernel@wyuan.org>, Weijie Yuan <wy@wyuan.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Harry VanZyllDeJong
 <hvanzyll@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Use a plain comment for panel polarity
 declarations
Date: Sun, 15 Nov 2026 15:06:12 +0800
Message-ID: <20261115070612.1464433-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dfd520477e9987eca7719e537b2865f4abe43043.1793362629.git.wy@wyuan.org>
References: <dfd520477e9987eca7719e537b2865f4abe43043.1793362629.git.wy@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c65625-015e-45a1-da8f-08df42e6cce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ePX0QQXCBTb9ro6qnLYn3bYT0rNupSDFj/u7/HzCCvE+F40Bnk5cswh3A7BTyci+vmjShCCpVOrN5XZkPLvdvs6zIMChz6nE4bAh/JstGEOmzgIUegjJCLrj8uzUSFqQE4hj8ahKJegiwl/m9Iz3VlpVeWIrunFu2A61lSse26U7Cj1P6qTpC4VNff9nvtkuXz2AIgXjY8lF5gzXS/mNpgxYE+E99lR4VDPyAIUbmKj7tmuki+XdEyxmTjZ49v09h1dypovEZj9rK//nmTYFXaJO3vX/NnwWtvpFhig8sbKkaulLIOhVYI+ZRfPw0gnVGTO7Wq1dn33eq0q+q+H+ftkU69QUaJiDA9K1C+xzo/joFTsYcSZhtWjG8gpWUwmWjmJPsLKUOaoWcZb1h24q3y3kJg1YQfa6Ls9J6GptAs0ukEvH+DB+JWgk5wGH597ArvRLCHzTsdpYZSxMSYxEmLtrKnhmqrI+i4ytZk0egAhRtKGLp4z/QxXk//Pra8j6PScoKyp8tRq27IKaD4dFYUuED1Tn/aiHV13ky/GaRXiIvbONsV+8+al8fxq7/FDXQOz8+fKvlpjonEvxX5tToBaQ4/AroN24OFWUGanofWwQh+cg9Av0EgneaZihCBQ5Xes75Lp7cN7y08WMV3TZ+rSsCjGMBr3HuBL+Wh7qup37WPLbTzuNY5Ewyfk99bJ4T7hl9SmWBAgYvAXKOVb+Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uqLv1tkQaEduzojk7574uqo7tAJdAZVsy91vDgIQIPdz5DETuYk/tpZDhrXQq/kwLetTHwwdxo256djmhiZnHJDbP3HU23LLnYu0jziK5Bt9NtZFGYzF5PBIZNlo2DVFAv0SGshHgU/Nob94bsQ/aNQnRl0naKD+00HUZzbzXghzXVEyL7zjLBPJudYFEngYgDOAHTAlJtG89/9E2VYNp4JZzSWaWrmZAN20gV4DG4GdYtb/onvCGj7BWRieNjXZNt8wzchv8sTK5aWODRR4kd4lqRF9QuB+Qpb0alIEi9unnIOgwJ9021AE10NDFDHSWm5ZS+CTtwjZ0hCWJwUoNEGT3fFtdK5t5MJ7gcXcJni+JHexlwaP9SQf+keXr3SX+bw9QHl2eukJDlfFVISYecbiUgzQ03tGcfDEx3F8AKUEC0Ip9Uwf0hygOOnlxVea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:05:15.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c65625-015e-45a1-da8f-08df42e6cce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Fri, 30 Oct 2026 20:27:13 +0800, Weijie Yuan wrote:
> Hi, when running 'make htmldocs', Sphinx complains:
>
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:3883 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>  * Panel Polarity Control
>
> But since I am not familiar with your workflow, if this is duplicate,
> please feel free to ignore.
>
> Also for this file:
>
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'
>
> Thanks.
>
> -- >8 --
> From: Weijie Yuan <wy@wyuan.org>
>
> The Panel Polarity Control heading introduces several declarations
> rather than documenting a single function. Its kernel-doc opener
> causes a warning because the heading is not a valid kernel-doc block.
>
> Use an ordinary block comment for this section heading.
>
> Fixes: 7dcd85c2241f ("drm/amd/display: eDP panel polarity control and test support")
> Signed-off-by: Weijie Yuan <wy@wyuan.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index d3c484f45333..03286f6aa651 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -3880,7 +3880,7 @@ unsigned int dc_override_memory_bandwidth_request(
>  		struct dc *dc,
>  		unsigned int bw_mbps);
>  
> -/**
> +/*
>   * Panel Polarity Control
>   */
>  void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);
> -- 
> 2.56.0.438.g30c3f27cb8
