Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A5FF8867
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB0410E16C;
	Tue, 28 Apr 2026 02:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/uTi9QA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC7210E16C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 02:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOyl/ntQwsnc6HidlQvAP/O1Ys9A4b2Tza+iI6Lmyp88WmunW2oPB91jT/WoOTVqxFmUmFzLJOxR3dHKiwwlCTKkrWHG4CmFs2/eyj7wFN4tY2G2O+wOvKwQdho5q4ihwb/P5h06mOycnDJ+Y42JTjGwLtZtF3gQ451kQAKBfIADlMEl1ucPv1lbn2rnveeDV110XQhg2ztKJptUYXGIfiDjfAA/ME0RJw4lMLDZZDmDXfIcRSHbxodpF/s2SGRbpxuKWBh9Iw8JLiylaasXaZvw8qbaQkfmlyATmsDskAI0U7upuVCg4CZHzOCtR2luPv+prNGuw36i6h/+9mDtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeQVqr4D+R/dhsm3a1R+ZY3mC2QdEHFRvZoLFeS9EO8=;
 b=NBmFSzXbPvVRnrunbsaVTG4Jjy7VcLEn4yHGZO25lAHJOKaw8GiVn2taqNGcjVgAuNbcaOScQN6VOMaE0pFhUyIwaHWJt0krNDJpJYn8SqZedf7NVGNKC0Seaz8DRDFyHsp9nFZEDD//+kCbdC0VeOjyjhcq98Y3Z5QEvoIfOIG6acB/e0/VS3W36hnrL3faekdaVNo1LDOErRxzuUFCcX/tWsC6w0qFR6QGSmu43uRZSVEyUkZXxVzmobCzzHN2KDmGJ5GR4cpbln05x7jdyFn2R6roZJ5ORKH68wbqoLd2k9rnHgn9nHyMbLsZX/+F23rZ6Xqr6QYc49feN97kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeQVqr4D+R/dhsm3a1R+ZY3mC2QdEHFRvZoLFeS9EO8=;
 b=l/uTi9QAk/3VQ/0NxQOzEHXkxAqEnXrpPWmgk5xzjXMpJXR/R3a3vQX/JxAiHnXHlFulL3jC0Xn0waqGbPYJwQxnIbXLAncMNA6rF0DPsITkWhgwEp0p+W3dKuTyYY7K917tjU3umr1+IsKxjZXyZ+mU9+3ClI2LVqFUsY2wF++Fn5wolvDAjNU4+to/IFeMXEiuk6R6tBfKxuLDTMfNVNjlq1y58NJLPM3dkcUBnbSOudAnq+QxuvgSJpqQkf6q9vg1kzSg42LV88OPPRnN9P1eDq67LkoWGcGcdf+M5sx8fhnw/lkzBczU/Tr+FVSS1sN3DxIcNuWGLkqX8b3NKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 02:49:45 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 02:49:45 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2] drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
Date: Mon, 27 Apr 2026 22:49:41 -0400
Message-ID: <20260428024942.452389-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0921.namprd03.prod.outlook.com
 (2603:10b6:408:107::26) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 5949b9b2-964b-4ca4-dd9a-08dea4d0ce67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5IlWEDB53m98yDgz1gU6CFBirEqb1sMFe9jWUa3c5hYbNkjD2k+PYxdaZDSi2Xu2ONTEjrCQEmbRcaqDMSgTP6eFSFNeatSwPsunYI/vmp3cpJZw0VbP/5+5Y0NNHizz1SZhUQjp6Qb8WiUCpBkCy+2CF6i0/kdGY4mkBDF4jV1KpwOjPZqIbvFZbkw4ssbZ3eXK6YFX8Pnb66TPrVTlYgEGcHkRnIdMBIlkHPqyRrrQKjf3E8cC2afTIdbISq4jn+sxx7JF7OJ3pVsKNKiLb8bg/OP7leMltJd2rZLoRqdv7QBa2JPbHAndqIxwzaNelrQ5pNMgKwOEcp6NMiN2E+bJuvaQyihEal9Dg4nBW+zOotGRX85FLCUYQs0LdsaSBeyX4ei9W2xfIJd3o09t0Ms7jxY3YRiJHC53Zt0oV0yycuH/ouZ7ufU+SzSUu3PSmd5l9KgPsT/FxfzIo+78cZN3rRk/FGPluPlGDkpnWDpZgOT2BsDbnPTjo5ayenlXidUVLin2uOGXjd0EEi9S+WV2l9ErmYlfxTZOXn6LzSmQOVe6CLdyIGXD+iKpj4o/aFYsR06ipUELmfku9m9wU2FL5Sggxtewl310p2RksxILtVh8VTmv8coEBAB2orM+UyzxM24Gok3Psu0BTB9KGt0TIzI8Epy85ecxNnmVQz6v//CFZ08J3889c19ZWD7brs/2WRWJcX1eNyzYfEqYXBMtKwQLTaHKB15yPec9Jiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZCaHRtS0VuT0JRbmc0ZzA4MGJDVGovVkJqczJMU3piL0ptTmpHT3JYOXlm?=
 =?utf-8?B?VGhGK0I4T1RSVHozTXFkN3cxRGpIemFzSlNzYVFFMEJOeFFNOVFOdWZlREMy?=
 =?utf-8?B?blA3VXRaZ25SQjVRQWM5UEwvZTZaR1ZyQ0gvWXI5ck8vYXBYSXNUcnk0OUN6?=
 =?utf-8?B?bEJQUTFYUVRuNTlvalFaM2FoV1BldGc2dkVwallrV1dtRE9TemZieEtXTVpo?=
 =?utf-8?B?TjBkTDdLL0xpSEp6QUF0aVNFWE9GclVhOFpyN0RJYlo0SHpoN1dadXBINTd5?=
 =?utf-8?B?aXkzZUhtcVdKSEg3bWpBV29qYU5ta3I2dHVtbmkrbjRWczR4V1kzc2hZVEVv?=
 =?utf-8?B?S1IxcTRDZEgvQ2FOU09vMnF1V0lNdis1YUJodURwQnJ4bTF5N3YzaTFWK2Z6?=
 =?utf-8?B?SnJmN0JITFhDV1VxOFkwK0RYYjR5dDBQYmpURU5VS0duWUhSWmJDM21la3Z6?=
 =?utf-8?B?ZW9NY3ltVjYvNm9YMmZRMnprdEdWWEdDcXJkbXUvS2dsOUtwOG8rVzZIeFZU?=
 =?utf-8?B?UE9JWGR6TFVaRy93ams5NVNSRzlXbjhmTHFkeUpZMUcwMjZtdEJqWDVrem9t?=
 =?utf-8?B?ZUZzbEpHNGJ2U2w3RnRFTUFtZ3VLLyswKzdWL1l3TVhMNjhxTGJ0SzdYVVU0?=
 =?utf-8?B?YmRQb3cyZWY2Z0gwalM3WUV2VWlNTVo2cWhLMWlHYy9aemYzcnN4Uk1SOXZl?=
 =?utf-8?B?TDFqbHhld0d0MlpzSEZ1VTd1NWluSnZPdDhiYWNkUHl1QTIwRnVhdkJnbkds?=
 =?utf-8?B?RkF4S1AzOFZMUUVSYU1IbzJOd0VVb2V4blZIUlVQL1daSnFvUFJFZHJKTkI4?=
 =?utf-8?B?dkMwLzliOVhOUXhQVXF0Z2NGT1pSSDZSRXRwVGhFSURZekRjSDJrVkVMdkw1?=
 =?utf-8?B?K0kxOU1JMUxaclNMQllpeVVQTVlEa2Fwd2piN3RucjZGaVFDMVNDZ29WTkV3?=
 =?utf-8?B?dzlYbFpPU3BFNWRrN0M0dlpiTkZJY2pZMW42VndKY0h1Q1JUQXhHNVNYSGZQ?=
 =?utf-8?B?cHE0NG1LM0t0T1VhWmRVeGZIL0Y2QzU2UCtIb09xRFdrS3pLcEFjQlJaVmdv?=
 =?utf-8?B?d3lLeGYySjJjUDVHVFFGQ1RVdkZtRVFyaW0vaVJiNGVFZmtUL0hWUEtNcGFx?=
 =?utf-8?B?SWt5KzU0M3R1ZExrRldoRlUrRWkvcnFhMDAvVUpQc2FySFBTenZsSDUvV250?=
 =?utf-8?B?UWx0S0ovWVF1WnJJSlhxVDFabmJGT000aUI3eUlrVE5SaXF0cFZoaXpNM0Rq?=
 =?utf-8?B?bGlCSXdtbXBGeXBmWjNuT3A3RWRRUHFtZzdWejJBUEgyMk91cXRuS1ppVHJn?=
 =?utf-8?B?c2VEWFR0aEVKQkdqS25IekNMVlNESldjU1ltdEY4UGFaN0ZpSGZQWlRRSU84?=
 =?utf-8?B?NXZMV1Z4dUF0N2VNeW82REsxNURXbzVpUTBVUGN2ck40cW1EeGd1Z3B0dGdJ?=
 =?utf-8?B?UkRZcjNkMGMrUEIvV0wrTGg0SUlXSkNDMEtSWVBmOUEzbU1CZVNwRjhjbSt0?=
 =?utf-8?B?dmExblo0WXZhWjU2MG1aMmZ0TzB0bUZyYnBJTEZtZDlORzFwSTNQd08rVHBV?=
 =?utf-8?B?dE5sZUpFenJ1UzVyRUduamNCbHM4Y2cyMVV3N1BCMzZoWmZMdTZxditGVW9Z?=
 =?utf-8?B?YlRadmkyd2VoTVdscmZNYmxVOVpyeXd0TzNLYTZ2Y1JEN1V4SXA5RTY2ci9Z?=
 =?utf-8?B?a2x5aHBvVkdVZ0x3QUJvWGthelNWMjBTbHZrTENBRkVSRGFLVHlqbm84OHZk?=
 =?utf-8?B?Vzd6SjFmbUJnRzJLSUg3bmtldTU2Q1VjQWtQL3VURGd1VTlHSnd4U1FIbWdS?=
 =?utf-8?B?cTFIYkVpMkxNeFoydnpEN01QTzJUaDBNVkJZSVptWDlqWXNFK1VLek9EMWRN?=
 =?utf-8?B?UW53OHFDenB2OUczUUFPUUNBNDVXWHlpNzltMFpXSURyZzdpWjR1ZE04Z254?=
 =?utf-8?B?djYyb1pSNUVaZGlMd3U1d2lYK0RPVXhEYjBPOUljc1Nkdmh2aERrM0kwbUds?=
 =?utf-8?B?aFdrRTFBZEo0RzJNTnE3YTFENUx4aEpmQkFFNDRrQmtjeTJKd1owVHRQNDU0?=
 =?utf-8?B?OUgrRVZSbGs3dVY1c01KVmJsaVltYWxhTE5BMW5uS1dxbjVjRGxoT2wyYnds?=
 =?utf-8?B?VXg4M1k2NFAwVExkSkQydHRqekJYSXBkTmlIMUhlZS92cllQWTFGWDRHd0dr?=
 =?utf-8?B?THFnZ1lpd2wxVStMTWxiK0xIemFHSHpqOEdBU3pHZ3ltSGtmNk9vN2hZSUhF?=
 =?utf-8?B?b1RyTEk0QmhkSUNKYUZ2S3NLelNnWXA3RXd4cS9nbEcrcGJBdGdVY1lLemtQ?=
 =?utf-8?B?RmUwWCszWVdYcVFvSHZWU3czTy96SFBvUFMxVklYcE1IMURXMGUxSUR1ckRJ?=
 =?utf-8?Q?izMrUoRWG2h8d474ZZZc+0H6jHhf4NKzZhKxY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5949b9b2-964b-4ca4-dd9a-08dea4d0ce67
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:49:45.7079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD/KXEJi1JU4xZ2ZQU/jkWDR79HYu5ouNFBDsnWu9EBcU+RrHzGzhgTrBPWps9rbTdJosi1JCItsVKX2m4JZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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
https://gitlab.freedesktop.org/agd5f/linux into drm-next") removes the stub
for drm_fb_helper_gem_is_fb(), so the buld gets broken if DRM_FBDEV_EMULATION
is not set.

‘drm_fb_helper_gem_is_fb’; did you mean ‘drm_fb_helper_from_client’? [-Wimplicit-function-declaration]
 1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      drm_fb_helper_from_client

Restore it.

Fixes: 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
v2: restore only drm_fb_helper_gem_is_fb() (Thomas)

 include/drm/drm_fb_helper.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bf391903443d..0c5e5ed7b5e7 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -273,6 +273,12 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
 			     const struct drm_gem_object *obj);
+#else
+static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+					   const struct drm_gem_object *obj)
+{
+	return false;
+}
 #endif
 
 #endif
-- 
2.51.0

