Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4F606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rRGcE8cH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C7F10E29B;
	Sun, 15 Nov 2026 07:10:51 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7931810E28B;
 Sun, 15 Nov 2026 07:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQp4xigptitE0W74uK1n+EGGMKjWTh76gutIeQ6JmXyJxVMm3iMDz0BZNK1JOrYfofx4TMDGi0JI5rm6PwLvM0t87hjvYF806OQsi6wKjjFpSMVH3kjeCPfIOyTeo2WGEJnvGp32BDh37MGJgaCL3611wwoLJpyUjlzyvMSr/SwZEZJst6PAMiY5YwOLEW4DoUp16erR9eAzqkSoNArvgVwuXXH8gb07t8tlj9GwVEw0DzgKPrz18uSDzyyDdEbl1JVFxX3lFe7Ztqm+4JdUpqYesT+EKPunvKQQDe2IHhuOcgb+B39k6ZsBIyH57euNH0UwbMHusxIKQHxii15Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GbgQzgvWJlqUOcif4RyA/oELuh8Gzk97lKnwlHw4cw=;
 b=PjdL4UvPrjsN3JSgsZsapI1+GmTwPqyWTFg6L/saE5h/MBcQMoBLLbBsVPPtVbBKJ47HoALAG8QAVAv0jkfYsuALMdA3I8I1qKak6T0Xigmyimj4PRwPVF0h0Ms2J9nSkSG6GvwBY/vZOmOcRJAuZItdvO8d07JgHJgvDwFURBH/q7d1qc+GEebT1i4oYQOKMWn3j6xyzgEOr6Z88TDgN6dxIk+NuETUh64IgqiA+JaIrXUVBMtVMGx994N4EjMpC3l+L913i4EgtTps/hT9Zykg/0Q3sACnZib5/VjJwyPEeQ7r36LxRS2D/J1iqretHNTqXPEEuoIM8skQxAGCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GbgQzgvWJlqUOcif4RyA/oELuh8Gzk97lKnwlHw4cw=;
 b=rRGcE8cH3IwEffOthQg8CsbCL650nBSfIyQ7AeCP3B7mbMXrSXeDGnmUzihzxwpvwGlymBoBHUC3Sc4gJprQpK0rwo/JvENdsyIvNUuUHeChwzN4HxQ++W5bTJ5gOwPSwrpetOhi+xKNbe1T5DGdjNwwulbbhzxW37nGKFzj5p8=
Received: from CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::35)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 07:10:40 +0000
Received: from CH2PEPF000166C9.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::4c) by CH3P221CA0004.outlook.office365.com
 (2603:10b6:610:1e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Sun, 15
 Nov 2026 07:10:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000166C9.mail.protection.outlook.com (10.167.244.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 07:10:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:10:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:10:39 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 15 Nov 2026 01:10:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alex Hung
 <alex.hung@amd.com>, Wentao Liang <vulab@iscas.ac.cn>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
Date: Sun, 15 Nov 2026 15:11:31 +0800
Message-ID: <20261115071131.1466723-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027205229.268908-2-pmenzel@molgen.mpg.de>
References: <20261027205229.268908-2-pmenzel@molgen.mpg.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C9:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 717e549f-732c-413d-2bb8-08df42e78e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: 7sfz7rp5yTHY7KUHwcG4ojGv4Ad8XYS0almsxm3XjfSZvmk7bmefyRmlkOLCDVP1hXOL0qbwx8HPc0oBIxCThoe3gSOOKb1bBcFNTA2fVBqZBoeUmgOD1iYBe/mVjoehCEmAgheSu6HFRxoBAhldB6pIG++dZvYm0DyI8X5kkYHyoL3aLokfG/lLx6iouiPfNMTBA9mzMBTobmTnhDvLn54ot35haIGS5S74BIJx6HJKXIY7vRJRvvWh4orOz8ZhygM/5yUnjlWjAzDVntV3osPZ7Xp6D42mh7UELSQJY5+O2SbD34lAT0ZwS0V7c6HTNEeRK7yUeSvwgEfqQaTAqFoNhAg5xVNvwu8b3Wb0VWqRcRa0HbQCpYweMNiLRWRRXbM/G/ge3ytqyuFqmeOJFWTVUIAG/V+2mQXddoi/lJ6rDwcu3qafzrji2pd6nZTSsln1RTdDWDAbMevCW11wqP5vD6XuzJyk4QRr/gXgOjGhXBIaENimoMFIT+e7G7mgErEfPojDApCZK8Kw1a0ly8i/Hp5TxJA+8Jj0ht55XzJCtQN0IF4bpWCr3BCTIvNLrn75+ANm+n1t6hhv+nMNg1j4kbIgaiBLRU5yMs4yuBkznZjfQBGBnHPZlNRxadxjSPMOuC/tPIt70OeSOdtxKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Up8/L/2pJaRd49RX4LHFyIprMcbX1biKy3nD/OhU1jaMk2GyBnDx3qZ5D6zlW+5URrMfc2hJ8qBek9OiI4n06SKMO4+24Zdk6caiI6AWVTeZVLkTHSNqcSIKCDED3/fiGZUjZoO+0E/ohlJUFQDtmuQDB3Wbp/eKm9+6D7OUDN8bLRXOZtdgef8MJmer9zk/ta9mIcZrqXnIRzQBCIABgZ5PsqA/mYRLp7mYAqcrXCFs7EMDTSZVyYmFxdfdVOFWKE4sXCMz8xx74eUNeRCzGdlTRxOPXLjKMDGY7U5ME06p6ILOUuUh+8SAidaxg6kfSVHyZrrz8SqYUAhudcD09fRXnGVS6IR3qB2zb8h4l4MyiW7WSUlvURA0NMDObkCBFjVTYLqLDz1Wg7rLJflU+SboA6ZHPpBgVmXyfYBKOHkxD0r/ewTdESxLtu8Jk9SA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:10:39.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717e549f-732c-413d-2bb8-08df42e78e1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

On Tue, 27 Oct 2026 21:52:22 +0100, Paul Menzel wrote:
> With an EIZO EV2781 connected over HDMI to an AMD Ryzen 3 2200G (Raven)
> on an MSI B350M MORTAR (MS-7A37), Linux logs at every boot since v6.16:
>
>     amdgpu 0000:30:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
>
> Commit 6027cbee1900 ("drm/amd/display: Add error check for avi and
> vendor infoframe setup function") started to log the return value of
> drm_hdmi_vendor_infoframe_from_display_mode(). With `frame` and `mode`
> being non-NULL, the helper only fails with -EINVAL, if the sink does
> not support HDMI infoframes, that means, if
> `connector->display_info.has_hdmi_infoframe` is false, and its
> kernel-doc says, that this error can be safely ignored.
> drm_parse_hdmi_vsdb_video() only sets `has_hdmi_infoframe`, if the HDMI
> VSDB has HDMI_Video_present set, and drm_parse_hdmi_forum_scds() sets
> it for sinks with an HF-SCDB. So an HDMI sink, whose VSDB lacks
> HDMI_Video_present, triggers the warning, although nothing failed.
>
> The EIZO EV2781 is such a sink. Its HDMI VSDB has a payload of only
> seven bytes (source physical address, Supports_AI, and a maximum TMDS
> clock of 250 MHz), so the byte with HDMI_Video_present is absent, and
> the EDID has no HF-SCDB:
>
>     67 03 0c 00 10 00 80 32
>
> Only warn, if the sink supports HDMI infoframes. The infoframe setup
> itself is unchanged.
>
> Fixes: 6027cbee1900 ("drm/amd/display: Add error check for avi and vendor infoframe setup function")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5025
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>
> v1 → v2: Add Signed-off-by line.
>
> Notes:
>
> claude-opus-5-5 (Claude Code) assisted in analysis, code change and
> commit message.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ded8e21897f1c..636dd2dedd73d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -941,7 +941,8 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
>  		err = drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
>  								  (struct drm_connector *)connector,
>  								  mode_in);
> -		if (err < 0)
> +		/* Sinks without HDMI infoframe support make it fail with -EINVAL. */
> +		if (err < 0 && info->has_hdmi_infoframe)
>  			drm_warn_once(connector->dev, "Failed to setup vendor infoframe on connector %s: %zd\n",
>  				      connector->name, err);
>  		timing_out->hdmi_vic = hv_frame.vic;
>
> base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> -- 
> 2.54.0
>
>
