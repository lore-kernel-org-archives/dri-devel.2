Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2852EC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796D910E55E;
	Fri, 14 Aug 2026 12:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fwSGJl/H";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K7TNAee5";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A822110E55E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:04:47 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67EAe9431504056;
 Fri, 14 Aug 2026 07:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3XYmJSmTj7xU9cL6Ff+0DcWWy/tEIvxQ5HU3cqY3Z
 3E=; b=fwSGJl/HlsqKc8TVtnorgQq0XvstBUUVP5lAlun7YgvVnQy19Pp+lm3+c
 oKBsxIVW8q3FtRGlwT4EQSuEUEjgMqi9X+T/FzhtPpJfKS8cwbdLIqvASyFDx0Ar
 +LuP1e57CutnnDKMTeJDCpLCbLRyflUrWwJjzF6VCKp4/kgCXuqXf61UjlEbci2R
 xTH0tH4Z6ObQuvYKjaw3NykwJUv59RcOeUGg9ZDDcSpO2q0mCh832EbWLQobZvJa
 KS+dYtZ7PppP6MQZ/BgVlcJtn5m0OESgZJIaxxVhWbucK9CXKA0FNZtjPnPt7CV8
 i1XHhiNTkNCK6eRL0N9mJYdJgngFg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g1tryj7p8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 07:04:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbh2akfTSNy4erl8WhGnHAAx4poE64DBnn8wXiI1ejTStXvV8JISULiKU6tiPcC4+U4MkZfjCPRGwPZXFULW0Rtnvf2SUVNRNuMt2rRA4jLj3il5yC7jUQAA0IH9B6+Rs5f5qpd/3KI7TU/nOy4tWuOdguNCCfCkGhNJmBK5Zf1H68DSVzIHOfV9LPU+GF/3CBXNZ70gkfws3eVW4ZAfTFvMPoxojyuhWqNEZSo1oz+dsTiIRbSyh8ejTCL+3uD5f+UuGthX20C0BLIteARxVsqcZvVOR0juAWF7G9mcTS71dPQu+VcmaHH4FS6Dl5HfR+47sgz55sPzItZ1y0NP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XYmJSmTj7xU9cL6Ff+0DcWWy/tEIvxQ5HU3cqY3Z3E=;
 b=MdXClDvAUVcy3uNAUYbc3cF+6qvTm2XxsNwQGwZB+w7DfETGb3Q3x0OFaE3lPcDM3tPnsH3oc/0SLdfwGcgUL7mU9WzenglsmMxKlP8b3XCxJvoE9TNluMuErSGnj0L6STHwmJFBOclXUDPzEnEDoMafi5lSx7ktbgphFnW7uOwTfFz+ghChBeeTcYTFdgqMT2g7stsyHit3kfJAvZt9ocKP8XI9dfqYkwOiiV5qc85niRbLl3Q7P5wiJEnqM1i0Vuv+WN/KVZEUrBR4l6TRGT9HYGLdszgPzld2ty+2Yq7vIysvM6+BzBJsrGbpSRvTaMqLG6DYHbRL/gA4awK88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XYmJSmTj7xU9cL6Ff+0DcWWy/tEIvxQ5HU3cqY3Z3E=;
 b=K7TNAee5v9GCtjg0Fl17Tl9zhI792uZSRpofKTqylAF1l0VY8y68Q/KKmGA8qQYrUpFBkVlaK+Powx/L/d6JcWEb4SHeZLL3YSWatJ2DCSmQLUeurtCn8YbanOKrgqld18KO9tOOJX0K8kw8YyVLSEJty+tfEWZD/Vv1p6bOTh4=
Received: from CY5PR15CA0044.namprd15.prod.outlook.com (2603:10b6:930:1b::27)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 12:04:28 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::4e) by CY5PR15CA0044.outlook.office365.com
 (2603:10b6:930:1b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 12:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 12:04:26 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:46 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 07:03:46 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EC3Obb1679011;
 Fri, 14 Aug 2026 07:03:41 -0500
From: Yashas D <y-d@ti.com>
To: Douglas Anderson <dianders@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link directly on
 cable replug
Date: Fri, 14 Aug 2026 17:33:04 +0530
Message-ID: <20260814120304.887993-3-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814120304.887993-1-y-d@ti.com>
References: <20260814120304.887993-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c3f9e5-b42d-48ba-c579-08def9fc300b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|6133799003|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WVSZ9q6+XpuAGXvQHTSZ0XbvZFWRDtQ406mbXKO0w+b9fU0u+WLn/4qfjQ8mTW8N37GeEm62cZonwzzXAzRioQQnaJ0D6LfDG6WsfNAJ4bPUlCyMRDYSIg2adcsjBXV6y4qhuT3sAcR33vEF0Wuy2uhLDyqCHunr2hCqH53QJyrvIip+FBmDjI+NfE+12djVz6PzKP0h14M5MAHfkgn0P9JY2Y90Tf9jMoD0sAangGq5ZOeMxcUwdtOUPE58H1e7rMTspp3u+NiMOi7J7fjA9XWgwpu0nlMfh3ExEKrui387DEPt2IEGO0pUFMIw831Tinblxy2QmpKyv/XECpfoj2UE3+Um0C/sXVFqYJp7Pd+yFAfie4LPJt9WWewtGp1TS70gwkYuLn9KbWFt8mgCUapxKPIsjcqjNkXUw613ysZsneANV93QyY0bgYqKCfXmamxvHTzkFXegopIRYBDrfnsGEuvJtk7/XW2JK1hliOQKE4rmOryNB4fZuBp0KnW2pf6kLYn1V8Z1b2ltm5k5x1NDhJKUnox55HD0Uzepm2MnQzMNT8Ks9INRbNzJebP5g9Rj3iJ6cJIBfSrr63pV2OJRfTdCn1UdkoAjLYWFn67mS/vq7KbXXU/X+pyEgZHx+BJ3KBSkt5rJhIUAjIVVoRTCXb63b5tQaewg3IIKkdv9ZNg4YYSFkrZduDsHiW0yXRNSb9jEc2nTI4CaENb95A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CvuZQ8HtRbfSsi42O5+DQarH91hY2dkJgd8yvU41IWSCGuNu4lh0sJ7zu99juT38a/IuDZwceDMiT3fjlJaqXLSP1J9WtIlqoOtXU9U8CyAe5vKRefy/H37ztXpqBZOFVW8Wy95vQYxTuuxsmu9fJOu45HDhocAsgCAKmjuHfkrdm8r+f0vBzTinX4YvbkY9WFJu2MP7vhOanB0iGJE4QLktOwEiVdhZK7gHnkR5W0RWkkhb5nz0Xk+z48LWty5C+BfTENdByCMKsMT/XN+3sr51aj1PWoN5KEfhlGmrQZyl1RqXuOIEE3MYe9/r2UAnaOPG4ha2SZRjqNyXjLg5H/PPXevYeVi3Qehrh/g//LO2d642+MZYjc/qWKBLahZZq3e4SJoc742YttTOAXNN7S1c8kqLLPv+8jO7a4AGjoC0eqwHL2EA4jdkPuy13rWL
X-Exchange-RoutingPolicyChecked: AS+mJfSSi0UcjDXrBUHoJzIR7jbd8dStWLyfRboB2v7SXabKWJ4yROw8ek26MhGReUEADj4UgpZR4IBSA1l+GeBxfH6TsYqf3+t2QVVuwDrxz6E2jYwANUX2Y5FizkcZJBj9nJENx7gKPg55wZIi4DVi6z5BaPVALe78J0bedGt0Av4HwTtLE+KaUryfmZG7OBCn1cfd6B35FOaKl2tsf2ToRAud2e7MO7DWbSKpswGJzi0gvealQpP7o9HTekFdes1LOsKWfavHYQWeuRJmNTABYEv8xg+JR3ID0jG4WvDhan+/S+2qoGcPGKAg5cbcZ696p+wq1/wxYbtpDwfAWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:04:26.5412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c3f9e5-b42d-48ba-c579-08def9fc300b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXy41zvcCLmcbu
 LdBI8cPLtfJrV8ZEUyBL0WC7V1OozY6XRUf5xxZOg24B9n4bo+kjmj8ffWRjub+21sZPuVXGwUL
 jkEU0Tq4Ifh4i5/3kGwyCDM403JEhAbvzx0DMXO8OieiB+k/EMC3rpB9B5SV4FMTDuAyNisDF51
 T6xMR/+7xQq0axCr3BkMnl2yFA4RyPMLJ107QKUqzyiKZjYSDg89/rgOcq+pABdwBkJpmcjET+P
 s/3d4d93K4bj8NDlfa6rd2FZEwc4CUSKy7p3PEgmwaM5QVxhc4aDy5cL2MaYMqGiPR7NNuOMlih
 Ewf6Rt8b39LcUmv8VFOu4X0bhzkjaaIS+uMB4GPQ6taAE63QcthmAI0/vgf7kidpkLZv5BGKG84
 BLOdae2XSd62N6sNTaVrzjkWqBjaQmNFo9cuaeJtszfcC8KFR48ABGGw44t0cK6jXgJxGwHGuow
 MVR4O6XLZSM6QQZlXbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX9Wb+Hae8KwPU
 sXVZ2U4H03y1QGGlsObMCIyKEm4sVojQjv5lWaT6Vp8LhjTL0owjPmjWCtWu0TLxT2Lkbnj5fYy
 ejYqgf8uFjTMd3DphpfWSFwCeyN+Rt8=
X-Proofpoint-GUID: pmWd7r-a6y5h6ZjgvL0vod7c4PA5Xjq4
X-Authority-Analysis: v=2.4 cv=H87rBeYi c=1 sm=1 tr=0 ts=6a7f0450 cx=c_pps
 a=4HEXQ/P5pkaUFkQJdDnQHg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=YjtN_N7XWMqpCh5YRzkA:9
X-Proofpoint-ORIG-GUID: pmWd7r-a6y5h6ZjgvL0vod7c4PA5Xjq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091
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

When a cable is replugged while the upstream display pipeline is still
active (e.g. a compositor holds the CRTC), the bridge can retrain the
DP link and re-enable the video stream directly from the HPD interrupt
work handler without requiring a full DRM atomic commit. This allows
applications to recover display output after a cable replug.

Signed-off-by: Yashas D <y-d@ti.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 215 +++++++++++++++++++++-----
 1 file changed, 179 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d9bd4ef8f0e2..f6f930ca1519 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -212,6 +212,24 @@ struct ti_sn65dsi86 {
 	struct mutex			comms_mutex;
 	struct mutex			hpd_mutex;
 
+	/*
+	 * bridge_enabled, cached_bpp and cached_mode are written by
+	 * atomic_enable()/atomic_disable() and read by hpd_work(); all
+	 * three are only ever accessed while holding hpd_mutex.
+	 *
+	 * Set true by atomic_enable(), false by atomic_disable().  When the
+	 * cable is replugged while true, hpd_work can retrain the link
+	 * directly without a DRM atomic commit.
+	 */
+	bool				bridge_enabled;
+	unsigned int			cached_bpp;
+	/*
+	 * Copy of the last adjusted mode programmed by atomic_enable().
+	 */
+	struct drm_display_mode		cached_mode;
+	struct drm_display_mode		hpd_mode;
+	struct work_struct		hpd_work;
+
 #if defined(CONFIG_OF_GPIO)
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
@@ -285,13 +303,32 @@ static struct drm_display_mode *
 get_new_adjusted_display_mode(struct drm_bridge *bridge,
 			      struct drm_atomic_commit *state)
 {
-	struct drm_connector *connector =
+	struct ti_sn65dsi86 *pdata = container_of(bridge, struct ti_sn65dsi86,
+						  bridge);
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+
+	/*
+	 * hpd_work calls this with state == NULL since it runs outside any
+	 * DRM commit and holds no modeset lock.  It has already taken its
+	 * own private snapshot (hpd_mode) under hpd_mutex at the start of
+	 * its run, so just return that instead of touching live CRTC state
+	 */
+	if (!state)
+		return &pdata->hpd_mode;
+
+	connector =
 		drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
-	struct drm_connector_state *conn_state =
+	conn_state =
 		drm_atomic_get_new_connector_state(state, connector);
-	struct drm_crtc_state *crtc_state =
+	crtc_state =
 		drm_atomic_get_new_crtc_state(state, conn_state->crtc);
 
+	mutex_lock(&pdata->hpd_mutex);
+	drm_mode_copy(&pdata->cached_mode, &crtc_state->adjusted_mode);
+	mutex_unlock(&pdata->hpd_mutex);
+
 	return &crtc_state->adjusted_mode;
 }
 
@@ -833,8 +870,16 @@ static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
 
-	/* disable video stream */
+	/*
+	 * Clear bridge_enabled and disable the video stream under hpd_mutex.
+	 * hpd_work takes the same lock before its own VSTREAM_ENABLE write
+	 * and rechecks bridge_enabled at that point, so whichever of the two
+	 * runs last under the lock decides the final hardware state.
+	 */
+	mutex_lock(&pdata->hpd_mutex);
+	pdata->bridge_enabled = false;
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
+	mutex_unlock(&pdata->hpd_mutex);
 }
 
 static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata,
@@ -1092,34 +1137,27 @@ static int ti_sn_link_training(struct ti_sn65dsi86 *pdata, int dp_rate_idx,
 	return ret;
 }
 
-static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
-				       struct drm_atomic_commit *state)
+/*
+ * ti_sn_bridge_link_train - configure lanes, scrambler, data format and
+ *                           run DP link training.
+ *
+ * Shared by atomic_enable() (state from DRM commit) and hpd_work()
+ * (state == NULL, falls back to current CRTC state).
+ */
+static int ti_sn_bridge_link_train(struct ti_sn65dsi86 *pdata,
+				   unsigned int bpp,
+				   struct drm_atomic_commit *state)
 {
-	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
-	struct drm_connector *connector;
 	const char *last_err_str = "No supported DP rate";
 	unsigned int valid_rates;
 	int dp_rate_idx;
 	unsigned int val;
 	int ret = -EINVAL;
-	int max_dp_lanes;
-	unsigned int bpp;
-
-	connector = drm_atomic_get_new_connector_for_encoder(state,
-							     bridge->encoder);
-	if (!connector) {
-		dev_err_ratelimited(pdata->dev, "Could not get the connector\n");
-		return;
-	}
-
-	max_dp_lanes = ti_sn_get_max_lanes(pdata);
-	pdata->dp_lanes = min(pdata->dp_lanes, max_dp_lanes);
 
 	/* DSI_A lane config */
 	val = CHA_DSI_LANES(SN_MAX_DP_LANES - pdata->dsi->lanes);
 	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
 			   CHA_DSI_LANES_MASK, val);
-
 	regmap_write(pdata->regmap, SN_LN_ASSIGN_REG, pdata->ln_assign);
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, LN_POLRS_MASK,
 			   pdata->ln_polrs << LN_POLRS_OFFSET);
@@ -1139,7 +1177,6 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (pdata->bridge.type == DRM_MODE_CONNECTOR_eDP) {
 		drm_dp_dpcd_writeb(&pdata->aux, DP_EDP_CONFIGURATION_SET,
 				   DP_ALTERNATE_SCRAMBLER_RESET_ENABLE);
-
 		regmap_update_bits(pdata->regmap, SN_TRAINING_SETTING_REG,
 				   SCRAMBLE_DISABLE, 0);
 	} else {
@@ -1147,7 +1184,6 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 				   SCRAMBLE_DISABLE, SCRAMBLE_DISABLE);
 	}
 
-	bpp = ti_sn_bridge_get_bpp(connector);
 	/* Set the DP output format (18 bpp or 24 bpp) */
 	val = bpp == 18 ? BPP_18_RGB : 0;
 	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
@@ -1159,28 +1195,130 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	valid_rates = ti_sn_bridge_read_valid_rates(pdata);
 
-	/* Train until we run out of rates */
 	for (dp_rate_idx = ti_sn_bridge_calc_min_dp_rate_idx(pdata, state, bpp);
 	     dp_rate_idx < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut);
 	     dp_rate_idx++) {
 		if (!(valid_rates & BIT(dp_rate_idx)))
 			continue;
-
 		ret = ti_sn_link_training(pdata, dp_rate_idx, &last_err_str);
 		if (!ret)
 			break;
 	}
-	if (ret) {
-		DRM_DEV_ERROR(pdata->dev, "%s (%d)\n", last_err_str, ret);
+
+	if (ret)
+		DRM_DEV_ERROR(pdata->dev, "link training failed: %s\n",
+			      last_err_str);
+
+	return ret;
+}
+
+/*
+ * ti_sn_bridge_hpd_work - retrain the DP link on cable replug
+ *
+ * If bridge_enabled is true the upstream pipeline is still active so
+ * the link can be retrained directly without a DRM atomic commit,
+ * allowing applications to recover after a cable replug.
+ */
+static void ti_sn_bridge_hpd_work(struct work_struct *work)
+{
+	struct ti_sn65dsi86 *pdata =
+		container_of(work, struct ti_sn65dsi86, hpd_work);
+	struct drm_connector *connector;
+	unsigned int hpd_status;
+	int max_dp_lanes;
+	unsigned int bpp;
+	bool enabled;
+	int ret;
+
+	pm_runtime_get_sync(pdata->dev);
+
+	ret = regmap_read(pdata->regmap, SN_HPD_DISABLE_REG, &hpd_status);
+	if (ret || !(hpd_status & HPD_DEBOUNCED_STATE))
+		goto notify;
+
+	/*
+	 * Snapshot what atomic_enable() published under hpd_mutex.
+	 * hpd_mode is only ever written/read by hpd_work, which never runs
+	 * concurrently with itself, so it is safe to use lock-free for the
+	 * rest of this function.
+	 */
+	mutex_lock(&pdata->hpd_mutex);
+	enabled = pdata->bridge_enabled;
+	bpp = pdata->cached_bpp;
+	drm_mode_copy(&pdata->hpd_mode, &pdata->cached_mode);
+	mutex_unlock(&pdata->hpd_mutex);
+
+	if (!enabled)
+		goto notify;
+
+	max_dp_lanes = ti_sn_get_max_lanes(pdata);
+	mutex_lock(&pdata->hpd_mutex);
+	pdata->dp_lanes = min(pdata->dp_lanes, max_dp_lanes);
+	mutex_unlock(&pdata->hpd_mutex);
+
+	ret = ti_sn_bridge_link_train(pdata, bpp, NULL);
+	if (ret)
+		goto notify;
+
+	ti_sn_bridge_set_video_timings(pdata, NULL);
+	mutex_lock(&pdata->hpd_mutex);
+	if (pdata->bridge_enabled)
+		regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG,
+				   VSTREAM_ENABLE, VSTREAM_ENABLE);
+	mutex_unlock(&pdata->hpd_mutex);
+
+notify:
+	pm_runtime_put_autosuspend(pdata->dev);
+
+	if (pdata->bridge.hpd_data) {
+		connector = (struct drm_connector *)pdata->bridge.hpd_data;
+		drm_connector_helper_hpd_irq_event(connector);
+	}
+}
+
+static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
+				       struct drm_atomic_commit *state)
+{
+	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	struct drm_connector *connector;
+	int max_dp_lanes;
+	unsigned int bpp;
+	int ret;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	if (!connector) {
+		dev_err_ratelimited(pdata->dev, "Could not get the connector\n");
 		return;
 	}
 
+	max_dp_lanes = ti_sn_get_max_lanes(pdata);
+	mutex_lock(&pdata->hpd_mutex);
+	pdata->dp_lanes = min(pdata->dp_lanes, max_dp_lanes);
+	mutex_unlock(&pdata->hpd_mutex);
+	bpp = ti_sn_bridge_get_bpp(connector);
+
+	ret = ti_sn_bridge_link_train(pdata, bpp, state);
+	if (ret)
+		return;
+
 	/* config video parameters */
 	ti_sn_bridge_set_video_timings(pdata, state);
 
 	/* enable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE,
 			   VSTREAM_ENABLE);
+
+	/*
+	 * Publish cached_bpp and bridge_enabled under hpd_mutex.  hpd_work
+	 * reads both under the same lock, which also makes every write this
+	 * function made above (dp_lanes, cached_mode via
+	 * get_new_adjusted_display_mode()) visible to it.
+	 */
+	mutex_lock(&pdata->hpd_mutex);
+	pdata->cached_bpp = bpp;
+	pdata->bridge_enabled = true;
+	mutex_unlock(&pdata->hpd_mutex);
 }
 
 static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
@@ -1270,6 +1408,14 @@ static void ti_sn_bridge_hpd_enable(struct drm_bridge *bridge)
 	mutex_unlock(&pdata->hpd_mutex);
 
 	if (client->irq) {
+		/*
+		 * Clear stale status on all three IRQ registers before
+		 * enabling, to avoid a spurious event.
+		 */
+		regmap_write(pdata->regmap, SN_IRQ_STATUS_REG, 0xFF);
+		regmap_write(pdata->regmap, SN_IRQ_STATUS2_REG, 0xFF);
+		regmap_write(pdata->regmap, SN_IRQ_STATUS3_REG, 0xFF);
+
 		ret = regmap_set_bits(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
 				      HPD_REMOVAL_EN | HPD_INSERTION_EN | HPD_REPLUG_EN);
 		if (ret)
@@ -1294,6 +1440,8 @@ static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
 	pdata->hpd_enabled = false;
 	mutex_unlock(&pdata->hpd_mutex);
 
+	cancel_work_sync(&pdata->hpd_work);
+
 	pm_runtime_put_autosuspend(pdata->dev);
 }
 
@@ -1410,16 +1558,10 @@ static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
 		return IRQ_NONE;
 	}
 
-	/* Notify only the DP connector, not all connectors on the device. */
 	mutex_lock(&pdata->hpd_mutex);
-	if (pdata->hpd_enabled && hpd_event && pdata->bridge.hpd_data) {
-		struct drm_connector *connector =
-			(struct drm_connector *)pdata->bridge.hpd_data;
-		mutex_unlock(&pdata->hpd_mutex);
-		drm_connector_helper_hpd_irq_event(connector);
-	} else {
-		mutex_unlock(&pdata->hpd_mutex);
-	}
+	if (pdata->hpd_enabled && hpd_event)
+		schedule_work(&pdata->hpd_work);
+	mutex_unlock(&pdata->hpd_mutex);
 
 	return IRQ_HANDLED;
 }
@@ -2050,6 +2192,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 
 	mutex_init(&pdata->hpd_mutex);
 	mutex_init(&pdata->comms_mutex);
+	INIT_WORK(&pdata->hpd_work, ti_sn_bridge_hpd_work);
 
 	pdata->regmap = devm_regmap_init_i2c(client,
 					     &ti_sn65dsi86_regmap_config);
-- 
2.34.1

