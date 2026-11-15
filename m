Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C37606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wqTDtZ83
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867BC10E292;
	Sun, 15 Nov 2026 08:20:02 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E0910E292;
 Sun, 15 Nov 2026 08:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI51ymNvT0zpZ37i57Md3Rx01l/R1GlXdaCfLuU/ScnPj44crsKA3f0FTzFsXL8/Lz1ZBvX4EUhlgXCkd8rW3Gjy79QvZ8DWaDflnTUkCr2BtHUpWG0p99+yg6rrbsGCZdD04CFdf78EbmQQ5yTfoZBWJZgtiO6AgyNEaJlfJJy7wGGg6xSIx5poCNyeRHwqZX4q1lap1gd3x/1+6e1DLc8bFtAqFCzhmIs2Pz/dqyHS7XGEGAUeDalNum274sU8akXZaGLXunYRFpzytflzHvHUZd7MSCnSaSKOW5TVdCbtj2lbxdn8ICsWoTA+GgJN7Sy4Vf9I8MxD14xhNLhzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt5uxd5QvfObo3EWW9do14rMxIvkTMWqwnXdkARK2mM=;
 b=XrpSt4X2VuGVyORKtEDbQn9FFaxTccQ6cgJZgMIbz4a5T9WLfLMYOfVbeDftXQium7rjMM+ZrNcYnY7b38juFyXWVojICoz+vh3znTghEhKrQ1es+UC3fFbTTXZaoDcSsSkgFmPLfz1+tP9KNbfSJHgcGC1UOmb3V9ngwfKoNLP1ru5pdvqSnCFNP9jMummdHbLWBrvFM9YFQihPaNk0/Zi7JL8hhkj+2dGFAdz9vGExCQTtvqYSItTC0wc/YLNDgKwgGqEHlmGkLt8fd/KiVwbdsRfe9gJ0iAPf5+LI9LPAQffiAJNY17HqqWU2ZEhV8aPePFWoJHOoV35NvMSp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt5uxd5QvfObo3EWW9do14rMxIvkTMWqwnXdkARK2mM=;
 b=wqTDtZ83YwZsthNWC+vYqI3Bh/pZmyjkQWNpTpKMBagbx2UYcTpghN8cXqWOWareXfXtzmmjg98n6l+Jc8cN+7AwvpO91bM/woOU5iptGn2Qmjogaw5NMYC5jfaLUVMhTe10cH44AUEoKfxx5wp/bk9IU4fR16D+kSPG7167IbQ=
Received: from BN9PR03CA0157.namprd03.prod.outlook.com (2603:10b6:408:f4::12)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 08:19:45 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::3b) by BN9PR03CA0157.outlook.office365.com
 (2603:10b6:408:f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sun,
 15 Nov 2026 08:19:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 08:19:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 02:19:44 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 02:19:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <superm1@kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Richard Hughes <richard@hughsie.com>,
 <simonit.orig@gmail.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Date: Sun, 15 Nov 2026 16:20:42 +0800
Message-ID: <20261115082042.1902826-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b6c35-ccb2-4bd3-d278-08df42f134c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 2uAfP9hwM14BrWLRwsaH6f8UvTHLIY34i2Ky8rrAu4rAFi3wEKLBIJ6LeO26turyXOYZTxj1HJ/iWs13Z+sLX0JaIvouluN8npFkmHPZHp9yd8U5OtAhWDybFWT3n97Y4cTKp/rLAWK8CS9yEsqMh/k2IviVFftufjVt0hdcsa7Q15A6L3BeFPgHskRnhsD3Myb8qPSk5zhPuU6a/VbtKZC48bhPznmLFJYlTdCgSWngGxt1B8tuQtgpPQYipjj1QXhhs3ndVbO/YAKg0gpx3Jkyn170C0vKbQD+oBB7vRDovvXU1K3Y/zklU1oPbto1w1DRZ2XJI87rhcfEJ4qqI/YN9mvHuLRlqbIsZMCczoFwLq9+2Rp1/zMDjyeU2aAsLEs5IMn+wRtMlaMK2dQSbgftKHjCPSPSokBd/Q5TCsKUxiJcqggvGeBE1iGGy2g+B0kcnye+qGgxoo9f+5zzN56YZ4MMMrXM9JdWQGfCUSVFnXHorn7dVtZqDxyJhrxKYqqH2LRCmhKk1QuqraXw3jq6u1+8PBunz1FEyfnc0QknxOPRGRBBJGr4kJu6Hz8ELSBl588eEj5Panpbll+DnHkWn0QeZuuF9DqiPT35T4ACo4T26JTytFotBUemho+FbfkmeTIu+PbpkEUChth6l9fzC+g4Q63J5rLV03E3SS4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 92NV2iOyJ90klmdAAyXaE8NSWIwKhP52v3hgLmQBfEXdlXRJ9w0msSIv6Rd/zCIAbJ3V7mwzz5rJFSgByW/QV0OWXiXJW7c+9cC2ZTwxyV1Tb6xXEslZAaxnl4gWz3sSQkbrAQePRN0LXR4mF2dmpKsvo0GiSVYks6S5gohbiLrEQ7qLZOhax0pZs2unwTjbJKKJbgiB0YsC+8D5EV+dz2i/T+KBcO7RyuPv7wtCA+61nP7Cw8TPO2qwu2r2b1Lm9G2b6D4njFX2ZuiTy7Yzi2G7f9k8o/h0DTbd4iYRTTkPmdreE365kOoX/bEAaPcXJ2xbyxIndh50kNyPqD3/m4a5SkxBDbd+yVr3OgkFA5DHq4gpi55OpITP9ZD2BgJBrwIGw3GZGE31Axa5NDRm4FqfAxayLMF7MkssMGaa/Tbq/f+A9L1rOkS8tp+PW72X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 08:19:44.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b6c35-ccb2-4bd3-d278-08df42f134c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Tue, 03 Nov 2026 08:18:40 -0600, Mario Limonciello wrote:
> On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
> but the connector's "ddc" adapter ("AMDGPU DM i2c hw bus N") always
> drives the physical i2c pins, which don't reach a native DP sink.  The
> AUX backed adapter ("AMDGPU DM aux hw bus N") does, so userspace such as
> fwupd, which uses the "ddc" sysfs link for DDC/CI, has to work around
> this.
>
> Keep a single i2c bus per connector and pick the transport per transfer
> based on the detected sink: if the sink is a native DP/eDP/MST sink,
> forward the transfer to the AUX adapter, otherwise (DVI/HDMI, including
> DP++ with a passive adapter) use the hw i2c engine as before.
>
> Reported-by: simonit.orig@gmail.com
> Closes: https://github.com/fwupd/fwupd/pull/11308
> Signed-off-by: Mario Limonciello <superm1@kernel.org>
> ---
> Changes in v2:
> - Check which i2c bus to use on the fly instead of changing static symlink to
>   avoid regressing passive adapters.
> - Link to v1: https://patch.msgid.link/20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..678caffa3d120 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i;
>  	int result = -EIO;
>  
> +	if (!i2c->oem) {
> +		struct dc_link *link = ddc_service->link;
> +		struct amdgpu_dm_connector *aconnector = link->priv;
> +
> +		/*
> +		 * DDC to a native DisplayPort sink is tunneled over the AUX
> +		 * channel; the physical i2c pins only reach DVI/HDMI sinks
> +		 * (e.g. DP++ with a passive adapter).  Route accordingly so
> +		 * the connector's single "ddc" bus works for either sink.
> +		 */
> +		if (aconnector && link->local_sink &&
> +		    dc_is_dp_signal(link->local_sink->sink_signal) &&
> +		    aconnector->dm_dp_aux.aux.ddc.algo)
> +			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
> +	}
> +
>  	if (!ddc_service->ddc_pin)
>  		return result;
>  
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022
>
> Best regards,
> --  
> Mario Limonciello <superm1@kernel.org>
>
>
