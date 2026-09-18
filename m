Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEC2C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE6F10E831;
	Fri, 18 Sep 2026 06:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3GOYcsB";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CB210E821
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7uJ/kps5MSfFk6yspEBKNNv6G2XuWS8sfnSpbDPVLbcLWZX52vnyzTS7WMTqTujkYmXE7SruOKQ9MDJfu1xQWkYMKaxL/A4lFVC6K43I3KEnweOctwsaTqp1Fe17DDlNFaig9tISHtpgC2gIss5k7xoa0v3YTUbkmat3cqqY50myndw6nDmWX2ES8mB8Ji/SiPyQFuT9l2wiL5JRmXmWNly+YsT44VFHfYPSHvJ0JA9NyP8M1j+0JCeGBYLZoNe6reoXQcEI/ZMsYM7lzu8lzGIVzC+sJ4G/gyf3nYbRdrj9d1FhG+yd6Cn6TguYrjHKwGUvdQiUnVjzuWccWZfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=KTprhMwZnfpTdCVQbhP/kPCfG7W+A8bn5oR0ffqbKE0VdLlD8smFelpleg0X4JLD6od1oenxed1tj82Qw4eyjDIG5aYngKd7BA+MRYecbqGMG/+n8OHgCIbgIf/KeWpglPo1XZHYf4dnuc/4gZwYyCC4LRamSjJj/8Kg7zRSiz6+UepSrkMKVpZQaHHa3gk00XFNCKLpJmnJV575e5drjO7deqI3D+SyF4gZDIWIwm9p9F1CvofpcrRClrOJ4NQP/XoGcOFSJBT7pjc4u5MZBb48XRhaKMU+4i1NQREMCwIUjLt+7otNRenLMH4k/VOTqXscHQ2nszreETT0sn/n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=j3GOYcsBEFf4QLdg6ZMtLDdAQxv+vNFxDDPgP4C2QNZVIqwpt3A3T91zPvVX1xuNZgEUJ8wIVLtl3/hzIe4FEQSzsNmeddFfTOGKr1tYeHkNC2ALepw29EArEjz5yvR10y9zQPZ80puMU4R3u/BbxZRKX63kX6BKVRARj+3RBv0=
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 06:57:08 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::7d) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 06:57:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 06:57:07 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:57:05 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 14:56:50 +0800
Message-ID: <20260918065653.2170828-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918065653.2170828-1-honghuan@amd.com>
References: <20260918065653.2170828-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a7ad1a-cd25-4463-8e9c-08df15520df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O9s+2JzLf4U8Uv1EjsBQKJge/baEXDAdZTt8lc30Q+lpCqJhD5PSN8TDszxWhFm8wZ51V9/Jy+NoFKsb6K1pM7kF1M4Cv/neswDElRMGaJ4B9Gpe2JE0CWUwry89PfKl+wDvkGvc51W4a57HGKX3opoR8/hDYJ4/YEqF+Pkxlz+0EjDerWo34/wpsw+wM7ylJG7ZRlzRjMMXrT1Ll4SkK8gsei2/ZT8qexgJo4dY9ijgpVCNoLKmHYGYg6uQHK9f/fusEecvrAn4YnH7+C7xLinM1TMFVsghPQvy5MTcHtfZDklgCn/djCQ1J3I1u4zwzcW3cDJ44nAYiXUWOUX9sRcpy30lhfxogBQXtcBm0o66PV1zaDg5x1t2r8S+MtCZrbIvcawFdiD70SOJZoCG1HwmQv0fv6Wa6Iq3bGOmHh1F37qa3VoRtYLyKQIln9n3ceALUybjG/Xlz1c2iPtjlIVGlKqkD1RPMnR6bN2qbjVlFdaGxIs173O/7x9+eVXGn/s4OmsebyyuTmPlPZKAryioMAJ1h4gq04rU1TzHFmQ59GQInsNatieJdZRTbUYC0EH2BwN5khI9xhYH1MhqrPbl2Jx+fgNLLEOeZbfFCOI+KajsCNVNM496v8uQ1eynJglbX1Bi7H2VZfKDPO1EG3Me3Ukso6dbIqaTnyrsynGW5TFqFI4N0K/iYqZUa/dmYsflEJpFIRjzNrl4alXuZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nBAveqCdutOyOYB2ruKS4SIReQfhLJDO1A5XYzBciSl0iPLntrg5xNNZeDxnkQnOI05luQRT1wzP7lUf2snCrjwCy1ZMGVXHXRl1nmU6BexcL2qH3VwnX+OECumAacWbnD2rtagU/dy6ChjLxdtAd+0NmG+qHeAPUQKYDKE5ogZX255jyy0q9LF3c8dRZkXQdQl5wt0OxH/JMEuN++otZ1iMsxu9Sl4QCoPWeMdnhYdOX99VHCoyciop+BGh1yQwgljcoW1sMwf+UYULlcUrAYue2/zGVcvvlcz2XhyrX/BPhm5xLWE+7SRD4gZItEvB+/z7dRbzjEG+uhw0rps0j3nXrwXTRa1CUYVZhBOp3Xa4DbKZwav5mQEhtEqi6JwS978LnOSF3oitdCeP1dKJwyUaoWMR20IpPXDkDaI38ozju9Xf7gYOzhU4mSaU97Z6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:57:07.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a7ad1a-cd25-4463-8e9c-08df15520df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

ID 7 is already used by VIRCL in the virgl/virtio-gpu stack, so
ROCm uses ID 8. A matching virtio-gpu specification change is in
progress to register this assignment.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..3d4dfadc9d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

