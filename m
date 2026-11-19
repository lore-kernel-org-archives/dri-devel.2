Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4060A2607
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n3ppcRm6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C771127A4;
	Thu, 19 Nov 2026 23:28:10 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A043310E801;
 Thu, 19 Nov 2026 23:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2aAwE0zXcvTkIjWjEV0t4szxyQ8BRm0XvZSenFt14lFlsNQxlmvhqMuAjrgTKdcAwFF6Uo/lzxKdWZuKkgh/WsM9Ufubc+338b2JMHDUu+nablcTE4zGkxv9i+9J+CYOb9/W1+5VHMTEYvVWhA+lnmJY8x7JT2r4G3TNmEr6Niw5/+FZ2jRK3c2jTUT7X5yMNU4a9LPAwS52SzbHQJh3NEghabGZaetoVyOuyMb8T1LYIjuSxRTKsyavONkmRQkaEjdyIDCGop8tYxpTazkgZ4pQI5Y0UMpV4Z6gORBkHXYVxuanD98zXTjBsgUw/IAaqMshPfpevLvbtRVTJDYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmJMMAft6CLxi0zA5TafEWpZP2dC9+3XGI1TVc9rhCg=;
 b=Gn5I/LBOk0hlYCjc2dHlEtuvyyvhPZ8Q85jW/leTkSwY7C8JNU520IWdJgu4Sd7yAZsJDgThUlcKJLc5hRErGMZus0d27SOTShXrOdaP2Lv8PonKrjBNXqyDI4AF3WGjzG1jvSLASc6ANZNluiYTFetG5SnIZRdDyvaTF/9+uez1rAMoed6goEoXpi1ckGRMlUlMfqv257p6zomVTszLFonmgYjtFLh0fKrNuDGz6S8SsRaXYKQeOf1CI3uMiu42qFvzlm2ignpwvwsOakcUf4o8Z0nhEjLVKbQbpQjGSQIIJLBkEaYtu18OURybic0zR+ii3ufQJyyBjgaznHXJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmJMMAft6CLxi0zA5TafEWpZP2dC9+3XGI1TVc9rhCg=;
 b=n3ppcRm6suPklvGeLCb61CJuwducc03FV8d5+cvEofOm6mQU2kHa61EK4AFA6h7mURAkI9qfxu6FJN+UDX4qH3Yk56bjKGsHO1YT+1aeGTpKNVOl4Zx97l9/Lc7NOIRNWQyKheRssQdpVGraTJ3PKqDcSpWLynKhRT0vvMPttFI=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:27:53 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::1e) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 19
 Nov 2026 23:27:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:49 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:33 -0600
Subject: [PATCH v12 06/12] drm/bridge: add connector luminance operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-6-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8dced0-afa0-4d97-d4c4-08df4694bb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|56012099006|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Wh+HEoe1JlYFoTcEvI+rpG4GOhFF4vxQiGOSV9WgOGkckr0CTT1lMIWz6KT+EhRVL2nNV0vZp0n1TYaAHYFqQZxt91vfWEwNBz4INVv4CPHn8Ub1+R4cHGZh655hzJaRAJD2cQVZ9ntq5vvr3/REJRH+gOoVvjBrVCvra2WCkUIYmaVw2SF8i5qaIVH7AE+VEVJhKfkgNkCz6XG4R3XmvkXLSblPq4wITuu3pNBmyiVZZvJL4t9iuVYhHn3AKawMMAujT7XdjvOaN9cc02sXvn67ma4Z1UHE3C+2RchKtBYFxm3w6ZRvOkx7nI9kASJw2Jo0iZ6GxmJ2DgFjw+FRosCbYubsN+Ve8jWNtAq1ms2DNTuYno6RGVq/j9u4oFt6Sdkk5Udg52fhUjC9HgGyCSc6VTnfbA6Ip0ji+ypblSgckggw5GLq/j0FX68aMnePjIuyru3iSufI2dnuv9+pIGptSk1xU09C9xHV/+u6MUqg0Ku/j4Uh36g/Ym5F1damDhn2K3KhbtOsIYLi5hGbxIYLj3/HOB1BhSnwfotegpOo2wnUodxeXDFGUn+hJsFAqPV/EJi5CIDLBJRtsT5VUPMj64ptn4/w5W9+XnUpeNF/6Gev4hEqKDwTVJBbeuIivzjXW3qGaSqNv5lhdD0//IcBwmVXyRD39es8k77gg36H99RP7WtbK/i64AdbAZO43kh2YjMYZ3rj6OAxwyKZMdCFU1k+uSxt5eQXAqIUGWWY+3tXUYUnBWHIP9Zs73cy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7ZHcwE3ZyJOG04gzqIC1hP3OChIK5ykSvegC3xgjWzqzM+Y5SkKw0CBsVJcJDFlpaBiP2ehtI3C6IIkiLDrwRZqXtP7x7GNo0pPotxaoLqIMAAKjK6mLkpQB55sDQycBb1CbvTTn3vlzHn3hK0CvGPgxcZHFBi2cy1yPpR5/XM2/3jCajMaU+4mkXRt521GZhZir+Efnxy0BS00SQKbxJiMHDVjYVHYI1LVAp1fJTJO/wW1BqMWaoWCJZgLnSMKA9OtvZGdGHnZubrOd4hGZhtATiIriOPOrdvLi+ssk2enpQuHkoWxe1HHD/3JY2A4sQygTjT3FCmTCJf0SXACzQa+UtohcnnUWcnjix+vWm1y8Qbx/l9aFPRhjnTH5fV9uxB18rTclPVVRbI89U35xzep586xYtcgfx4a0OU7WvzGAgHGeQ52GnW3dME89q3kD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:52.3737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8dced0-afa0-4d97-d4c4-08df4694bb82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

Allow bridges that own brightness control to advertise a luminance
operation and its supported relative range.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Add tag
v11:
 * Drop panel bridge declarations re-added by a bad rebase (Sashiko)
 * Document @luminance as the initial level
v10:
 * Split bridge operations out of the combined panel and bridge patch
---
 include/drm/drm_bridge.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d2..240a69c1233e7 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -62,6 +62,15 @@ enum drm_bridge_attach_flags {
  * struct drm_bridge_funcs - drm_bridge control functions
  */
 struct drm_bridge_funcs {
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply a relative luminance level to a bridge that controls panel
+	 * emission. Bridges implementing this callback shall set
+	 * @DRM_BRIDGE_OP_LUMINANCE.
+	 */
+	void (*set_luminance)(struct drm_bridge *bridge, unsigned int luminance);
+
 	/**
 	 * @attach:
 	 *
@@ -1021,6 +1030,11 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+
+	/**
+	 * @DRM_BRIDGE_OP_LUMINANCE: The bridge controls panel luminance.
+	 */
+	DRM_BRIDGE_OP_LUMINANCE = BIT(11),
 };
 
 /**
@@ -1071,6 +1085,12 @@ struct drm_bridge {
 	void *driver_private;
 	/** @ops: bitmask of operations supported by the bridge */
 	enum drm_bridge_ops ops;
+
+	/** @luminance_max: Maximum relative luminance level. */
+	unsigned int luminance_max;
+
+	/** @luminance: Initial relative luminance level. */
+	unsigned int luminance;
 	/**
 	 * @type: Type of the connection at the bridge output
 	 * (DRM_MODE_CONNECTOR_*). For bridges at the end of this chain this

-- 
2.43.0

