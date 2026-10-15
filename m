Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1973ACC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA0210FF81;
	Thu, 15 Oct 2026 16:15:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478C910E2CE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZgSTy2RVdx3ydkiTKAImevZsyPnCYc+JVgp0fVbiIejPkpXYmrBpJTsoF2cIA7x3F75iPAWdmw1VuzQDybmXOoQyKH69qn3ThQ/olf13lhdYhE3hzWwJ98hFmFVnTifUn6RmhoWw4S59/teFGbwZ4aG8n7RoYJTIsF6HM0XJdzWdfTEYmWrpOlVX0TvHUBocTwu8NGdK42v1vd+d9t8Z0hXAG+OPGmrBZDL+8+RnRw9v8i3jxA4DnL/pqR/jwbREb0zOnzjXvWjE2pnE/j4DEz9CG3r+q9CV205rXI7jr2Emo81iAOfFpsXvC206AcWXzNEG526Y9S5vP3fpYEX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnGGOdfV4L1Vxp33gd2utc21B+nOtjsUGlS680XAwQA=;
 b=jdD0DZFqsvTSINiB5g9ngep6cYRc9tJ0gaH6HAfOI7xAhgEhuff4+dHSpLkpU7HQoXGZyWQ0U1jgeve5CH2Fu0OBKTfOPrQHiblQ1FhV9n0aW/uIXmVUvERmBYn/ef5U/N5vUrwaQYdMBjJUWsum6kh/DIsNJ1SRUIr+FtlZapISwO8/mzQwuf2K+mGxwUo21spd1YrrPiIVki32BaMXua9ISBfxnAD+KTJk5V1lYskR5hFXJmd8Hv7OgEy8hAtPujK6hXozI7onuj25Yth8DUQL6iS0ZXb7SMInwADao+dNmD27BP9H4x3uZ3kE2YDbJuAYYHDijiPL45SlrrG2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnGGOdfV4L1Vxp33gd2utc21B+nOtjsUGlS680XAwQA=;
 b=R/e6biUynZ+Mls+Y8wz8DfRA5ReDJpqfSZYW+A8o9Q4G40vx8rEQRCx/S7bsyG+5Jh8WWjsYNR2MSWzj5zCDWUSRgbJNeTyavRDQbNQmKFG2V1sRM5BdDmZYovvu1P+GxM74dW91b/idkU/dafJejuNnYOjs9Nx7rYVtmTmTZEo3Cg2E4B4tlDbvVQnkEC9ww5s9DH+N5Gb3Q8kDzabhYZmsx2U1KntZf6QXNEbEU1GiDrZ8m1lR2PhzqnRy4HRhytKLZdu2rfx3OzNpBwqkC2QKRLFGAK/W4hgc2Y0vpBeQkW8WVg2GekfC9BSsm0vfuB6bn0koqe43xUdRgvMTSA==
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by IA4PR22MB108726.namprd22.prod.outlook.com (2603:10b6:207:14c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 12:37:47 +0000
Received: from PH7PEPF00000006.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::18) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 12:37:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 PH7PEPF00000006.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 12:37:45 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 2FA0E1A2D0;
 Thu, 15 Oct 2026 15:37:43 +0300 (EEST)
Date: Thu, 15 Oct 2026 15:37:42 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Peter Senna Tschudin <peter.senna@gmail.com>
Subject: Re: [PATCH 12/75] drm/bridge: megachips: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <atDJFgbFu8Md0C8E@zeus>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-12-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-12-586c9c026823@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000006:EE_|IA4PR22MB108726:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c23257-ef27-4d02-bb14-08df2ab91d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: HIqKV9LZuaWEp3GAjUqsWjPBrWOUg7Dv7x/xC4rU+PYXbcybER6D5qKYTSyzoauQl4kL2teDmz2wQfuAMDBWV+NUslE60bIMVqOKFVI4nwMbW60RMw5jKjRiadaEouDRIosiV45028nzgGPadA+9IitH9hPh0GPtc4NJ/u9HCA/lvgZGkOfKMydCQw4IgiWsLP2mrqNTflp8v/qELdpzVccw93kTyww7V5BcrvxVnhxCNAZZkxTyNn903fd8I3g5Hb9d2/V4l85FZ0ANTL3upUG5h9H3tJ8GmmJiijqNNZPq6JDjYXKVyuMx4nQaRifVCikoCCZ8mlif6DvaiQsGis2mr7LY1cYqd3dCF0bvjqbtnBxwSfykv/ac7POXAPEAzbqc6bwUmImT7/KD4SslkB3wwtTDKWDiU5Ubtg48o+r9X1lrLrcywkGWKwWvSfuwOSVBatXHdFkxI4Sr5kSibztRYZqW4ZKw8fKi54C6lKMrHKDp2p060saC1BVg4vlAV5Jle9CLCN1AZITC5OtHn/DgTpohik6stqs2JfGnZBb3wTD+o3XRyGJSSumWsuhI3RSwrcF5vnwPE+SkHf1aQQTsW4biBZj2mh8MFZPqb9WZecJ0L03Zs6ZEzfczgVcFzsI9ZZ0OD5ZW1iBc/L36DZ39CAV8CmZp/F+bZNfPCIQTLdKJk7vdDLImHS1N4dAT5uc2vB3MMiuB69Fu3qtT9Q==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +9DjmkwDjX5MQgfprreEbkIoDpswiC/95oqnU4S+QD3DiBW1wlqrG3/cunIvLuNcE+sExc0XhKZ1GsUJ86AHebjf3MI1Sh8ANiQICszJQAjJzlTSa3FuBVAAJdysgrkJDOnbIRimcEe8WifryYOE+fXpQ1ogb8LIV0GrbHSQvUrQnlrABbldmVabpovF79crHtAh1vtBqAovOZOh7dm3rzQW12jqQZL22H/2V8ARfnBV31UnqgLmBCywdZXkD6OC+rzYcs5R3lLVOWCwrbotwPpQg8r2qAzxQ6YRSb79TfMXPNaK0tVRn5t32fTRrl5KId4T6wqRCwxSO1ovkEfYciLDd4HMhd5sPjzt7Ei7w6p6UuS9Ps3C11uqrjsVf1IfR4XfiHrRZcO7f0smK5/X2sw8Msn8bcAySjYKMmPotv5Il3zS1kkjQck/J1mVGttE
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:37:45.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c23257-ef27-4d02-bb14-08df2ab91d63
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-PH7PEPF00000006.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR22MB108726
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

On Wed, Oct 14, 2026 at 07:26:35PM +0200, Maxime Ripard wrote:
> The bridge: megachips connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
> Cc: Ian Ray <ian.ray@gehealthcare.com>
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 4d244e6d4ed9..9153bf629fd1 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -147,11 +147,11 @@ static enum drm_connector_status ge_b850v3_lvds_detect(struct drm_connector *con
> 
>  static const struct drm_connector_funcs ge_b850v3_lvds_connector_funcs = {
>         .fill_modes = drm_helper_probe_single_connector_modes,
>         .detect = ge_b850v3_lvds_detect,
>         .destroy = drm_connector_cleanup,
> -       .reset = drm_atomic_helper_connector_reset,
> +       .atomic_create_state = drm_atomic_helper_connector_create_state,
>         .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>         .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
> 
>  static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)
> 
> --
> 2.55.0
