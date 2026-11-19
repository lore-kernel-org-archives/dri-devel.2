Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887760A261B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t1DFahr7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622F710E04E;
	Thu, 19 Nov 2026 03:04:22 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F0610E04E;
 Thu, 19 Nov 2026 03:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okKNa/6it+RDdckSokqEVMvsiqmZ8v/VJ7adesZprnBtXMkSVbF96ddAWXf9NrvllvMJhjFNfBaH+U7tReduFamWz4s54QhOkKdYHxEdSWFCJ5SbQXS2qFaVL8kqMAiNBb3C/UAg1FXhbZH9NS+2ShrTaZYXeg/UeBT4++2oCr1pXJVpyhy6PGHyuwKXHyhZPBiACzFcJ6OxN6G9FDVOpVDTq1znNev0RuTqUeDxo7gWQcywDl8k6TgRsRmdQpMRW2oqk+pbjSckBrbb1DhF62hnRyd47/MMiH/9D4d0Tjq3HJhKf4O69qM6lsty1xZOAUL++PYrbtGL1tiFneHnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc+daP5Wc7vjgit6jpDbcovc86JHC/tXHaNpw3bCka8=;
 b=aVhiXiv88bDxHkzMaNbT/mE39vhC7CO0VZ51NBAGK08+2ui3IFotHyt1g/u5B9ESZqzDYRU7yZ84kevj7IBgxeGGHAOewTtJ+49V6KUW8ziig2fcNkqVo+00cXim1X9WVYQOvlm1BaJsXEBW43SPC/K3RNDX2m0oX5nAmvy06r/xpX/OW5S3ca8daKPC0Fqw9hLrCsOfpXy5VXSP+DARJrd42HnuwiLLiiYAzV6mK4jhAYyRKhK5ujkXDcgnkQkaz0Dhqsf59RBbll+8DRe/Nf0ilKYvD9zt8nXhtnBdyVdFWkP1N88b4o2B9wl75n6L08r49CrrufFrXhGuIV4L+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+daP5Wc7vjgit6jpDbcovc86JHC/tXHaNpw3bCka8=;
 b=t1DFahr7jJ8TlvnIiz3mWiyOPHo71kByBqueAMWQPsotQwUhftFh9R+nJZZrSUo6OK+TUjB0FoB0JIf3zc08olVNNrin6ZprD/OiQh8xRx7HHxC4NIFwsfExVx02R24rzeR2PVtxBYxNg+mh7VG5Hov8domQqK89tXMGUzENn0A=
Received: from SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::12)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 03:04:06 +0000
Received: from PH5PEPF0000002F.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::3b) by SJ2P221CA0002.outlook.office365.com
 (2603:10b6:a03:5db::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 03:04:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002F.mail.protection.outlook.com (10.167.243.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 03:04:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 21:04:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 21:04:05 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 21:04:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Cooper Morgan <ext-github@cwooper.dev>, =?UTF-8?q?Eren=20=C3=96zen?=
 <erenozen@protonmail.com>, <oss@oysterdaisuki.com>, <harry.wentland@amd.com>, 
 <alexander.deucher@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] drm/amd/display: Fix FreeSync infopacket refresh
 rates above 255 Hz
Date: Thu, 19 Nov 2026 11:05:04 +0800
Message-ID: <20261119030504.3849327-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <HftAWPKURVjBtK_2BmUiLXOb8ghZxaEzAJSg0tlsmy5L3ckJyDWc6g65vrsVGdA3ZcytB6mPuyxaQbsPawfOZmdC1dyAo4lCbaK3Tj7Tm-U=@protonmail.com>
References: <HftAWPKURVjBtK_2BmUiLXOb8ghZxaEzAJSg0tlsmy5L3ckJyDWc6g65vrsVGdA3ZcytB6mPuyxaQbsPawfOZmdC1dyAo4lCbaK3Tj7Tm-U=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002F:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c01cbb-781a-4802-43fd-08df45e9c600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|261009223027099003|22082099003|11063799006|261026140227099003|56012099006|261021123027099003|261021135927099003|261022105027099003|261021121427099003|261028144727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 430rJwjDlFAN9/5stwXIIdpUjUQDTMtK5BOISqacvKUDXWXo33r3+PRUAm3cmA5+pp1V6XCaHjkXlaktNPv7HeTBHvoW6FSgAj4jBF5dxJ/y8EFOuC8AxuB3NH2F4zPza5K7i25ogEnPukL6mCAtpjHkw8LXzs0Tl6jIKzpPiuOYeS653Xn0uogM6f5KNZOAmr5On8/Oxw1uQvKNxnnhg9rKGp+3F1l1GJi9XQbAdTS5puYCl4LHfSwJKGwEhJhdXya3hGxc2msJI/cwt8VqEnXIJLfPhVQ/BFvZeui+IBO+vF8VRvLkURria+V6VQrSt/FmYzOZJw2ptWFHjQhDr07+wQrym3INULIjwAsuZIL3uk1XjGLMTaXs5rcU1RiSdKUrqajRAhWRJ5xQebV0Jq8kJno5dydKPBL0SkNCRKMdFGDxnzIiiXPakgko15cZjSLZ2yzUDObhqeSf9TnGjCxrRdrjBIeTMKJmx4ZMGEEAXhup5W6QZYJNJ+5p0BD7Ttt9v3pKM2ZZ0/NOEnug4fzfJw2mN0LAPh62moGjy+erlfqfVuUnmQp+awm+oiL1Z0aGDFL7w8jdRJV1rJaWUMm2tS/PnajVD9FVz5aaYuSSbVWZGt6ZHtbtI3QTtVr9G/OlsiWXTuFh7HXLvVvkZC8BAYxzIEwov41q5dTBm6X//toXnrKxFOj9vS3ooFMIBR3YugfQbzRq6T1TGuuU6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(22082099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261021135927099003)(261022105027099003)(261021121427099003)(261028144727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9n/N2lnlHO2wKNv5+E1lQhWWVfa2TBfmLkaRkBnRwHfxXLhTzHfKjsgNu+8SJyVIQKfgfkYtoARWWbmgQVAnjfaONHayclwVD+A8XXOcV7jtpk+JCH2XvZ7huRijIIF/SGYUonN5uYwnZb1uK127IqOXOIfPfY6S8SjWM4Vb0Y7JSGmgV1KByfCtJAWGasAgpETx1ZWaF77zEAzo2iF0K+cmJ2WMXywXBOqmTls3hFXpxwiSbmNjolb1nRlA++gitDeN7BuBqqirNKzkcJvsl03mrH92QqDmUUL9thaqr1+dZZR9yZPCuwW3VHYLE/LkcgQZ4+u0VgpSOwdzgRCqsVV/hv8gAYMMQCCWP75bFiVCZYF5sde9o3GSPkBBMH/NR8l3KcJP2SrbrwZBCPBQLhfgHquozqU9n09aOdDnjd4eOs5uzMUiuGxf3Pz73abN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:04:06.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c01cbb-781a-4802-43fd-08df45e9c600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 12:46:45 +0000, Eren Özen wrote:
> Hi Wayne, Cooper,
>
> One more difference worth knowing about if v2 gets swapped in:
> ae60ec4dcfc4 ("drm/amd/display: Use FreeSync v3 infopacket for sinks
> above 255 Hz") is missing the amdgpu_dm_connector.c hunk of patch 2/2.
> The posted patch changes four files (92 insertions, 1 deletion) in both
> v1 and v2, but the commit only changes three (91 insertions).
>
> The missing hunk is the one that stores the AMD VSDB version for every
> DP/eDP sink:
>
> 	get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
> +	amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
>
> 	if (vsdb_info.replay_mode) {
> 		amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
> -		amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
>
> Without it, a native DP sink without Replay never records VSDB v3, so it
> never gets the v3 packet, and the DP side of the >255 Hz fix has no
> effect. The KUnit test added by the same patch catches this on
> amd-staging-drm-next 8dd68a79583a:
>
>   # dm_test_fs_caps_dp_vsdb_version: EXPECTATION FAILED at drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:9925
>   Expected ctx->aconnector->vsdb_info.amd_vsdb_version == 3, but
>       ctx->aconnector->vsdb_info.amd_vsdb_version == 0 (0x0)
>
> The failure is easy to miss right now, because the amdgpu_dm KUnit run
> panics earlier in dm_test_i2c_xfer_no_ddc_pin() (I've reported that on
> the "Route connector DDC over AUX" thread). With that test fixed and
> this hunk restored, all 1931 amdgpu_dm tests pass here. Patch 1/2
> (bedad38a7ddf) landed complete.
>
> Thanks,
> Eren
>

Hi Cooper, Eren,

Cooper, I am sorry. I missed the latest revision, and an older one
landed on amd-staging-drm-next instead. Since the patches are already
merged, those tags will not be added.

Eren, thank you for the report. The hunk was accidentally left out of
ae60ec4dcfc4. I will send a follow-up patch to restore it and Cc you
both.

Thanks!

Regards,
Wayne
