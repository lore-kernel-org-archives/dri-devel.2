Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEEFED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D05C10F684;
	Fri, 24 Apr 2026 18:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dC6EVP2h";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017E910F684
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkXVwRTQHdneYCT44Qy/pfqxLaK8SJZ5x+HHHD4xvXFdzZjb/ABIcuX6UMDBygrM8FJLFZ+tIYegfgT7JvCJP+PX1OX8r11jIqjWmJKEZEPaLyq6BN8h8KzLmTebqr2SLxutit6Xg4njX9vT7Jj/ONfLsnq4KppBUTZ9GcTB+MG5C2l220tKrqAyhSWDATebOnJwYut/73phCfYTI79QSzbCF9rduplFUv58/p7qcZQBANFP3rD+zZU+rOzCxPxOmB7Ivo8gTWJUewuTw8lZhOdFxKSIPDb6RTp+IINcL8WNOv/0Mf+eOHgvgJwaF+40iG4QH0dkmyA0fcYk1+iDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D1XMhpImdsZE5xxEIDtmTaOCFGIu73wO+P3Kn1Y5is=;
 b=EzboZi8H8xBZIhwwdK9oHqAZqjUGn4hFsqHmPMhuy+jQlNHUeHUaGV0O5Q4H+w2u2QBG8j3qakwGAL1bl6yJsG+cnsakVgmIgKXBZQcof0GA8H/fKHWnND4C2TGuMpnIWEspMdU/VGiAS0qMrAg8RIRlWMiJFruv+7RIW6StCecKNYHBHqHESZc5TSuziq+SDHAvsScb3Pzx/bmyc7o0e6LQUVLjZi8F8Qe/kHZyiet9vUpTIE6irapnCgI9uzBm1ZV2VSL/aPadmgQlL4LkrvucSfwwOpsTmz3BPKyHmzMdVt5PcF14rRa893+WS2+HxGfo0wW9CyJj3XNuHTIG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D1XMhpImdsZE5xxEIDtmTaOCFGIu73wO+P3Kn1Y5is=;
 b=dC6EVP2hyots4eelB9fLSVDslnwIaUbmCaNvz1lDXvKjwcJRW+XJGYVqDJhfg76AcNTE02uf6r/98naSObtu/E40TmEH9F5UwVsmjPvPbWUYcw2lyrlsY0NT1D8Av0C/v8C+sahH8RvDgWJkjwpCowuShRe0OpsGhokDjieRmfORyHSoDzimdvr3rYurhUBdqaY1vrRa7pRadUkTMZxfPgKfeTXJjgl5paO91giJHLRlbOuBpkO94mXXEIJffsAWymZeQq/LXxREMyXAd5Dpdo2pwPx4r5knR7t5cDYqQOql1SSRltCEePIBtbxQMfMjkQGw6I3VRrR3MZaHCgasTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 18:48:24 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 18:48:24 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
Date: Fri, 24 Apr 2026 14:48:20 -0400
Message-ID: <20260424184821.294103-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e988c72-4509-485a-29a5-08dea232107e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6ITNSmEtpgsNfGJE4A+JopoEtLkaOq1FH7oPJ1Vg+tWvZE6RD+8f2EtLLCkaYipm2YTzniwnUMmY6U7fLEvZE1FjVBKi2XSVF839QIzhp7duo8JG3BakVtm4nIvFW2lEMezUgEOht8scOxBPA8YwwPusXge3ciaCXhP88ah4x7G/EP33zSoLNOKrJNEq6h13z6C7km4e2j4vNwWIScZLPDi3AH9kWV0cLladl014fyInBcZBAbLoS8inLuJZQukLCkpFIDZ7EqsPB8pnDnevvoMUPJ/ZOORqJ4MkqJ5NU8XYxvFNgrFDaYyptygAWMSwVY1IHS7l2jlF496dd+QIo9fM5PKEkSTCpnVEnabMaNg9VNPzUGDn/wrKhDkdsMOipM8PruWbYlwCLLdic+lm4Hp4wAsajc9Q+qW3LfNg5ODEBhvWXbckK2skb6+QKdqPTXDGD+x9ctQYSsio28aH4KVw+Y4slj0azphGKWau8oWix61IDOuflQE475MjWxm13RPVJygyZ50/ACTGT+gUcW1y+z3Yi7KsI3E/pHRvi/JHuORZ2M/JC0z6H+PeWJD69LNrQ+sRT0Rb4vrmaIAsUcLrm58l+r4RUdoMezhHhMZ9o4mxSEd/yVU31NZUZffwyDZAEXE40SzQjxwrtHRLE4isdllAs4oFgjad3oxeUilH7oXIcONyD/zUQ9kuRFmU7rWLABlsxdoSYVcI/lIzs/PsRmmwxVYFRlK0wVpgLTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZaN2gvNFJ4ejl0Q2RTTFo4ZjFOL2ZvR3ZTUk9PbWFMc0lqWWQ5a2ZqNFdW?=
 =?utf-8?B?S1hRY2VZNkQ0MVpjaGJ0eFdwakxKY2pRTTRZQXVmWUx6cmRzRFV5cklrSUlQ?=
 =?utf-8?B?OUNCajBTWWZCS2dXdnc3OXo0QjBNY1R0OTFJK3BxUm1ma09SUEtKT2s3OFNs?=
 =?utf-8?B?N1lKakZlbGRFOWgycm0zRjZHSHVRbGRoQzlGbWZkMkFxK3ZjYzBXMGZyVlBS?=
 =?utf-8?B?WWxLdC85UUg1SGRnY2ppRW56aFplZTQ4U01OUUdUVkRzL1ZMQlhtWG5rK1JL?=
 =?utf-8?B?NUNoN3BvUndwQTZGRnhUYlp3UVhTR1VZSm1CaWlvTitRTkNlclFUZE1FUWRW?=
 =?utf-8?B?VTZrbDBNZzdnK2dZVTZXUlhLajNlZjBiT0NzM3VxQU43OEVIc1hLY25oOEo0?=
 =?utf-8?B?a0JSSVhvTVo1U05vd2VtRTF4c2t2Y2VXMUVTRG1mVDZFT2JzQTE5a3BaSzlT?=
 =?utf-8?B?U1d6L0RDZW4vby9PbFlQM0s4NmlhSWZGdklBVndXTWpCZFYwWnM3b3BsdWo2?=
 =?utf-8?B?V1pqcHQwMnQ5U1VMNmV6YXhiWnd3Q2p3TDN1SjRhRUFYM1haTlljSFhHelln?=
 =?utf-8?B?alFqSDUzQXdDWkhjMitJYjQ3WVJOU0ZNU3BXdWduc2t6cGFHczVkeHg2VVpE?=
 =?utf-8?B?WGtqbUplTG8ydmRneWhXVWx0RHJ1bzdlS2RUM0hTK2p6MHJSaE1XMnpwN3k5?=
 =?utf-8?B?cVYzUzFGUDd1Mm0wQm8wU0VjOEdMTjdSajBXdUlINlliMlkveFpaZHBPL1c5?=
 =?utf-8?B?bU9qcVVhYlJhODMvb0lnaUxqeHpNTjRheVVTNFo2TUNnY0hHa3krYzh6dUNv?=
 =?utf-8?B?Ynd4SmxSR0lDZkloNjllRHRzREhNZ1VHUk4rQnF3bkFCaC9pR0FMeURJU2ZQ?=
 =?utf-8?B?UnZoR2VBWkJuWUorMkFyWWt1SFFkUUV2OWtuZkpTSjZNcHV4UWhpTEdHVFln?=
 =?utf-8?B?R21PVzVUV2hFeGZVYW5RakVYeUpIUjJ1YzJzL3BKdnNlaWpGeHc5c0svdm1q?=
 =?utf-8?B?QzcyTy82bHI2eUZZbkNDSS92SGRHdE5KMTgvMkhiU1c0b3FnZjB1QS91TFRP?=
 =?utf-8?B?b3pPK2dHdnJ1aTBWVkV1R05kb2tKSEl3MmsyYzZuQ0xVdDc3Z1R4MEZRSUdY?=
 =?utf-8?B?V1VHdTZ6b1o2eHFUcVMrd3JtWStXd3p0YlY1QVlMUjhOWnRnUzRERjVkZlBE?=
 =?utf-8?B?TVMxZzVBenpWZjc0Qml5ZjRTYmlkWjRWUnpiTE9zMmtBdmdnek9hamVVWVp1?=
 =?utf-8?B?WElvSFgzcVhqU2JTOGN5czNwTzQvSEphejNuNnBnL3JMYk15b2ZVdEdWN1Vo?=
 =?utf-8?B?bERqMzM1aHN6bEhHVjNsOUkzZlIzQWt6cWNXQlpISDZ3d3JPWllWNVRmNENj?=
 =?utf-8?B?Y1VTOVVFd3h2R1B5M24vSGViV1o5SGVoVWxzM3NtZi96RWVXZFVBN0IyL2Iv?=
 =?utf-8?B?ZUpWaVRyMHQyNGZqMERpVHdlb1h3NlY0SEFyNGc3R2M3M3Vab0VQbTJGb2RQ?=
 =?utf-8?B?c2xJQkFNbDF1T2ZVY0tIa2QvZkFzY29tNVNTQmo2NmtIL3o3LzNGUGM3UEtP?=
 =?utf-8?B?Q2UwWHlJb3pka0k4cmNnazFmZEl2VW0vTm9kcGFQUnd5NCt1ZEQ5NVhwTGw4?=
 =?utf-8?B?TENZNnY4KzEwbWxsMkpTbDREZytYeDdBN2dKVzJuTHVObXh4MjZQOWdHclB4?=
 =?utf-8?B?YVUrT2wzOEphbzh3NUQ2KzlyM0s0eWpHYi9KZXBoZzFvdlBiS2ZmWjFqazB3?=
 =?utf-8?B?cWlkY08xQkc3dTlZUUw4aEpUZGJwNlhmbUdlaWRYRWl3bVFObksyWG5VYWpB?=
 =?utf-8?B?cjJlSEJwT3o5SFVPTDd3VitzNjI4YVlyQWU2YnQrZG94dXJiR3R6OGhJc28z?=
 =?utf-8?B?TzAxWXI4b2RadCt1Qll6V0dITS93Um1LTmo1TDFCdEYxNktyS2Z5TEg2a3FS?=
 =?utf-8?B?NVByOHpBLzhGUjljSEo2b1JaSFNzLzVkQWxxbkRrR3EzbVc2Y1lWV1h5aXpS?=
 =?utf-8?B?UmlMQXhML3JCd1cvcG1oOXVXV3QzMjljMWwrZlRvVFNHTTdTUE5rWVozbkx6?=
 =?utf-8?B?UUpuejQ1QkZ0NXF4Q0w1dk5CeVMwWE9KNGtXNisxcG1PMGZuVHFTdDlHYm1j?=
 =?utf-8?B?Z0tZYWlQWG0vWUc1S0JDeUovM25xNmxqN3JSdlVPN3crZCtFK2ZOeEJRWHpa?=
 =?utf-8?B?djVJeXpkVm9CUGp5VXpkdVhmY0ZZZXNPZ2NtTUVacHNxRlFnb3NhblFWWVpJ?=
 =?utf-8?B?cXNWandGNUNyU2czcitWSlhFWmlVWDQ1cE03TWxOZERpNm9YVjZxU0JQUXlC?=
 =?utf-8?B?OXVmU1Y2MDVKU0F5MExwT29iTldiR2ZhcEFDdTdPV1g3emx3WmJ5SzZpeU51?=
 =?utf-8?Q?HIglMZtWHkMUUmxPBExGNUnupbZUW+lPZV3yY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e988c72-4509-485a-29a5-08dea232107e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:48:24.4776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuJkfTCsdq73qhTmxc7iJynIFBSJG9PgZ1IJrTz2JZ2ICN41LF8UHZ9CJe/q/CtXtykrDgpjhUvRSO8aJNcY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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

The merge-commit 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next") removes stubs
for drm_fb_helper_xxx() functions, so the buld gets broken if
DRM_FBDEV_EMULATION is not set.

‘drm_fb_helper_gem_is_fb’; did you mean ‘drm_fb_helper_from_client’? [-Wimplicit-function-declaration]
 1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      drm_fb_helper_from_client

Restore the stubs.
Fixes: 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/drm/drm_fb_helper.h | 111 ++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bf391903443d..ca214b5c0283 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -273,6 +273,117 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
 			     const struct drm_gem_object *obj);
+#else
+static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+					   const struct drm_gem_object *obj)
+{
+	return false;
+}
+
+static inline void drm_fb_helper_prepare(struct drm_device *dev,
+					 struct drm_fb_helper *helper,
+					 unsigned int preferred_bpp,
+					 const struct drm_fb_helper_funcs *funcs)
+{
+}
+
+static inline void drm_fb_helper_unprepare(struct drm_fb_helper *fb_helper)
+{
+}
+
+static inline int drm_fb_helper_init(struct drm_device *dev,
+		       struct drm_fb_helper *helper)
+{
+	/* So drivers can use it to free the struct */
+	helper->dev = dev;
+	dev->fb_helper = helper;
+
+	return 0;
+}
+
+static inline void drm_fb_helper_fini(struct drm_fb_helper *helper)
+{
+	if (helper && helper->dev)
+		helper->dev->fb_helper = NULL;
+}
+
+static inline int drm_fb_helper_blank(int blank, struct fb_info *info)
+{
+	return 0;
+}
+
+static inline int drm_fb_helper_pan_display(struct fb_var_screeninfo *var,
+					    struct fb_info *info)
+{
+	return 0;
+}
+
+static inline int drm_fb_helper_set_par(struct fb_info *info)
+{
+	return 0;
+}
+
+static inline int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
+					  struct fb_info *info)
+{
+	return 0;
+}
+
+static inline int
+drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper)
+{
+	return 0;
+}
+
+static inline void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
+{
+}
+
+static inline void
+drm_fb_helper_fill_info(struct fb_info *info,
+			struct drm_fb_helper *fb_helper,
+			struct drm_fb_helper_surface_size *sizes)
+{
+}
+
+static inline int drm_fb_helper_setcmap(struct fb_cmap *cmap,
+					struct fb_info *info)
+{
+	return 0;
+}
+
+static inline int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
+				      unsigned long arg)
+{
+	return 0;
+}
+
+#ifdef CONFIG_FB_DEFERRED_IO
+static inline void drm_fb_helper_deferred_io(struct fb_info *info,
+					     struct list_head *pagelist)
+{
+}
+#endif
+
+static inline void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper,
+					     bool suspend)
+{
+}
+
+static inline void
+drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper, bool suspend)
+{
+}
+
+static inline int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
+{
+	return 0;
+}
+
+static inline int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
2.51.0

