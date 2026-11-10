Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C1606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vzc0ZU0A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB9610F065;
	Tue, 10 Nov 2026 18:37:38 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D140210F062
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TllsPy25XkdUvMj1bmSM+kLjoZxr7tN/Uaw7ERL4zH+vGCuKDCnnAJXSIemmInYZEF6pp2pUUAbP+OR1hnszL6yRBYtGjZWmKRxTZ8cOrNX8UA+Jd2TL5hdr7MaTwWovFBVsr+zb2pICE/AnL0dT+exn57YvtJN9FmhiKax5YJxd/gr/6/frp9det4DDQczm4yWm+auNx84gjl+zQTJJxGDbo3rScYp2ALD/FBbDXe+k+Uvmht3ZHRp2THMjp/6vajuUUiZo7cWzJPOI06eJLnOoSj3xEtur8Kl7n9ZXVOAF+7Z8g6KuflZP1OqtWmPVVo6Xu4AZBJDAvjQ3fd2oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+mvcMvUrCK2ka3OrkAt35+zJaGlo/qFjBSkpaVnPno=;
 b=IvHRCjlurO2kjdIVaI1E6TMAol//+Yvul5jzrhW44XaFTxrDCdRdN9JFK3Ku91ONOep7jXaqQ5iQN4UoI28yCUX14tuITwzNHxIkeSFStJ5gIdehjJP7nH//POvnjgt9Ci4zpPd2bXl1MjqyxO7WGnyhKLWBl2quw8uLduqUBgNER9ghDTLxVVSdQpNoS3DCsLtaqQmpBHVJg91LMjdikvmamYgbjO8Lt94mMKKwBGwOhR3YoKQas2Nmw1C6Q0EuNw4/7WfHftZ0DhoONBO6Ht/R83c5BNlYsuDXsBUTfdaugAwLEZwYJBLdaBLdFK6/esye37idxiP86KhlVqUlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+mvcMvUrCK2ka3OrkAt35+zJaGlo/qFjBSkpaVnPno=;
 b=Vzc0ZU0AH+wCZOFa6xZ/fkH8s/FEZDoxZoZkweyg/SDtbLhFfyAM20sD8xteSfp83eM5tGWDSAcbw+TZsoX/10zD6qZRthQi4DW12OVHcsml65ZlLUhi6Y0MSeQ6YtI60j5SBRmUSMKnjB7G2cIPHi5EAXNsTH+FYCyDV7xKDfw=
Received: from PH0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:5::19)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:37:24 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::5a) by PH0PR07CA0014.outlook.office365.com
 (2603:10b6:510:5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:37:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 10 Nov 2026 18:37:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:37:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:37:19 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:37:17 -0600
Message-ID: <1c79762f-6b00-7707-f8b9-0851f834b22f@amd.com>
Date: Tue, 10 Nov 2026 10:37:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND V1 4/4] accel/amdxdna: Add AIE4 CERT firmware
 version query
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
 <20261104224302.643329-5-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261104224302.643329-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ca1923-22ff-4042-199f-08df3f59a928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261009223027099003|261028144727099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: JHNL3hrwXldmpQ4TTfDcE+7RALAtFPGNA/TQ8BYAfDw3ZiybpCMdqYt7PkqJzX6bzNfhLXja+VHAaS/yctUyglqSzlUeMOb86xMVDUY2IXdFrZTToq46QVn/RS0s/bmUpLg8Dmo58rR9i3UAMmmgXzhC4BoRBtSztDln9UCRWoZsM3dUa1GTo9pTnmCvFGFLI48NFubIGP6JGUx0VExdwzTvq2X5n57LlnPMEfyzeXDWhLKob4iIOYABnt7/j0CNSKND2lUkQ0iWr7LoUxXA2w4EmLgPqjmt1dTjEIqf1KboKZQqyGQxOIkNpw7+Pc9CE/54uGxKbQYOLbBASfYNC4HqwAu4gFJXL1a5sOCmpKKVx3xL1601o8EPv+KF8CHzDMwCOHLpRfg28p+nwAq7dOEArhUzQ4Pnfdesw7+KT6xwHU0Q7UZqUSq6FZjAZ+9Rcm42T5bCuJ8UexymsDDirjVyz/pC+fQ2rVXb84kqmRYm4+COWHCaTGhgnDtH1EAR59xQucxr82wkqjCapK3G/z4VYYJ40e2L8xFNQzCe2veqqCkpIAv0WZpaPynOfXRSHEHNAIIhq+QWURfITPunA64Ncp7GLTLiYy3ziD32q9ZF/bPtUiPZEh0/F27FM3y3CyG6m2+wxpwZ4375qy4FXD3t/j9p7HWt2QfoxAcF2F7pYhthz5I4SmiMPyiVVN+FpyTIt9axtiyn2PK77t3SfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(56012099006)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0yAYlavjbbNQn87KT0ZKeT0Xw1yuXI7p634jkg2mlZVsxSEUL1EXUI/hUGaWQCGAQdGetWVDxae7bbv4Z9DGT/qwjF7rHZFKvwVBhmgrWS9yfOIYEIBKs+kNg9Z9lUloRyvD1fmDMQfxFVqbrF8X42UOrhAKA+QqOuu/h0DdD9rxZ3jMjDTQYVIHWXozp2PorPt5ATqW/SMkWzNzF4WPn5LgB7SUOWzp6khnbIEyL3jEuaAdOClONCwvfYvbzzAZnKXO8MfcM4ADncPRXKGwCVAkYXZGcdMM5TWeujAvd+CmY5rA5RYFjVG5YsFvRbidMld6Ln+YL1aruk1UUjclLYDcQgRtbfwsg9dhsuhXf8YBuV7YkK0UJpHAMFfTgOceej+NR28fSWHu+/vJMBW2kBQABzsZcM2WFTtzpjcP6vRh4B6UcYD1GXAT9q5BTZ3+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:37:23.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca1923-22ff-4042-199f-08df3f59a928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/26 14:43, David Zhang wrote:
> Enable the CERT firmware version query ioctl on AIE4.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_pci.c | 3 +++
>   include/uapi/drm/amdxdna_accel.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 101f0f27b466..5b1d61dd0d8a 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -835,6 +835,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>   		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>   		break;
> +	case DRM_AMDXDNA_QUERY_CERT_FIRMWARE_VERSION:
> +		ret = amdxdna_get_firmware_version(client, args, &ndev->cert_version);
> +		break;
>   	case DRM_AMDXDNA_GET_POWER_MODE:
>   		ret = aie4_get_power_mode(client, args);
>   		break;
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index 0e41c45ba720..6369d82e5067 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -525,6 +525,7 @@ enum amdxdna_drm_get_param {
>   	DRM_AMDXDNA_GET_FORCE_PREEMPT_STATE,
>   	DRM_AMDXDNA_QUERY_RESOURCE_INFO,
>   	DRM_AMDXDNA_GET_FRAME_BOUNDARY_PREEMPT_STATE,
> +	DRM_AMDXDNA_QUERY_CERT_FIRMWARE_VERSION = 14,
>   };
>   
>   /**
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
