Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284EF483FC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6307B10E4F6;
	Mon, 23 Mar 2026 20:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O8zErPK8";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB39410E4E7;
 Mon, 23 Mar 2026 20:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aanVNSsT6APwNpz3ZerXMguDqIWWV8lJ4KW65ShDhySQdZPJSPrKK1ZN/jtgfj7xnQ4DYhwTYJb65vIyl0lBazF3ZpTFbKTeDPvExJbj1bpBidisJCpisEFiYLmgnenu3Bcx4K5O+T3tERKzoXXqJBVd79l8jOxlOd2QDaTAbY8xVjfUKnkfXsU+kIcUhwe0Gl+BtUaPPwhc9p4x9fICanf6pBn1Jjt2WhEya9G8d1IRK7xgzY7N+lzyXytS89+MEtpBcFqMqd5sKHeMgbtv29lfhoOLLrLW1wgkqnhnaVgAe6qoRBAa9VB2ZYerwT5o5j+l4hbU3tZw4r2Hzv/3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9a3bUiZuvN/srB7F0f6P4khwgWPRJFK32Vifxxdlzg=;
 b=PmqvnLctnpLlvoNqahRANl1aLGXFMChDi+tlizbgoQYdXWIZANExiBIfQJEwx4Aa2rsphqYjKr4fikTAFkKHj/93g9eX3JlTTtnHI/1YLlitx+G2XVyI8+Qr9emMPO2i2xwV3sr7FM8exROVVJQzkqBE/4CcqwFNwZA+9JXoLW9JqCqE4ZTuxxkM87aPG+wVd81cfQgC/cTAGfgfNWmq35vzq+320vXaLBcNpuWGXDMctmEBGtH9XcFvlwdJlaha8731SQl1QrNAepvF+BAhDDV6MXbn+u24IQGlgWxn6CU3EG6A8BDyjcCeG1EQakBGWQGIpiKcA5aF1Gvw2qCz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9a3bUiZuvN/srB7F0f6P4khwgWPRJFK32Vifxxdlzg=;
 b=O8zErPK8iXOwhhF/4ryU8t7zuQO8Edtns0RGd2uKudCAtx3Yj2PgQkXBKxMsNVdJ9e1J3MwVsMp/LKOeKDT0KZSQjQGg/BWHPq/bwMmiplGPFcwIPt/iDk997e90ffHQ6nLTvrnQi13PRCplaDooCHy6A9zrEVw4BzRgBaR2Bm8=
Received: from LV3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:30:19 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::62) by LV3P220CA0003.outlook.office365.com
 (2603:10b6:408:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:17 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:17 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 5/5] drm/vblank: Add some debugging trace events
Date: Mon, 23 Mar 2026 16:27:55 -0400
Message-ID: <20260323202755.315929-6-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323202755.315929-1-sunpeng.li@amd.com>
References: <20260323202755.315929-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: de31fdc5-b460-47e5-fe4f-08de891affb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: EA/TyS/a7m7v01szlB9bBp/pyiwVeb+2VJQXpsNQJ34Kkkf0Li3VkisQ724ErlEbHxU0RBlNunw+LnRg5anUDQyfIh95T27yqzvvSxxA26PzW9adVmQcTQYemUBVNjEgLvMYb/bwkABWscq8wn5DLTBjX+pkpvMHZGw4vgSk2n9TbNTjkXXAZqnxVtY/MLltZ0W3px+mhN3ujoXYbHqqrBETWGAaUTSSQ/llgPRvriVj8gwDR40/hf/Q8B1CPeRc2lndLT1e6xtTeDmfy0Wd2/FB3+1Vw91GHCjjMreVXgnminRKQ/2EEpuX4mYKz5iUiQj6nk87SqcadFSFmAVwzGsBQ541XcMU1+PMPY4joECCka7gvAlytIopU1FEbp/tK88cFC3Wg09Z+/C3jHJU7/unC8gN70mG9PxiZmoi0G1oMYZADsYtxGAJ2gS2ga01LPT8qC1ZjpaMwQleUK9kx3c0OBdxG+AG58edO1lREoyDpLmEuIiTtwqEZkU179V1VHGuX6Ri8UYRHyk3ATLchaj3hqGmWC5DFuZcvTa6oMCXm/l+YzhXXO8sEYQkirGuQEMYMnCzo40F1EgNl9c2G/IEwq01Icexj0QID3BqS0ZV8IxmnfaqinIemp1e16CTWzom3KwlSTjGb57nkkboC8KIzCEV8qIpyZDhGp79uCXK5+Hoxzdb3eoiBb81y/gEUII038Z8di/HqXPg2oO2NTV/pDNedxY+4RuA502UM0u1XKKfvXt5w86BklKlLpG4M3qt6QbYtEqwJfkK6G+KXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 08SwhQfMWCmKCjpeV/mXK2sMIPA7PXUWP73k17BryA/0DnZYIq9FezY3cJ5wFrQxz/oQCIQRe62iwPkIZWlE19AwOcfuwjSnDuwA4argX2A6UpDkDH5CntAwNRayYmx4hWaeS4YeePuFf1OOXu+L7xwQ15iv/z01cEG7a/vl/y57C13LMxQxF6bhQ9OVkbz99SpXx4wQKnaffLkeAjLuEfrwbO60zlD2c3drg1yLP8Vbt4xccp+izFjc1O5Eg1rW7hQtTdx13lPj27x/mR2p2V+WELrS7AUX4itoY5DRZA7sF1KSPLoIwOLu95ExCauvuazhDjLFDrMaCtVjq+hZ+OMuN8IK0hYwYTck2UrRw5ExVSplhRWUmOzAMGtyW70tDKKSO/mzdw3geqcFWm/FNpq9gr5WxJb22aKoJYR4KBXwZ840DPsYh5AiTuHeRbAl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:18.5029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de31fdc5-b460-47e5-fe4f-08de891affb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

From: Leo Li <sunpeng.li@amd.com>

It's useful to trace vblank get/put and enable/disable (plus their
deferred variants) when debugging. The trace stack feature for events
can be especially useful.

Using trace-cmd, one can obtain a trace like so:

    trace-cmd record -e drm_vblank*
    # With deferred events and stack info:
    trace-cmd record -e drm_vblank* -e drm_deferred_vblank* -T

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/drm_trace.h  | 112 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_vblank.c |  34 +++++++++--
 2 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_trace.h b/drivers/gpu/drm/drm_trace.h
index 11c6dd577e8ed..3372513a10eeb 100644
--- a/drivers/gpu/drm/drm_trace.h
+++ b/drivers/gpu/drm/drm_trace.h
@@ -66,6 +66,118 @@ TRACE_EVENT(drm_vblank_event_delivered,
 		      __entry->seq)
 );
 
+DECLARE_EVENT_CLASS(drm_vblank_get_put_template,
+		    TP_PROTO(int crtc, int refcount),
+		    TP_ARGS(crtc, refcount),
+		    TP_STRUCT__entry(
+			__field(int, crtc)
+			__field(int, refcount)
+		    ),
+		    TP_fast_assign(
+			__entry->crtc = crtc;
+			__entry->refcount = refcount;
+		    ),
+		    TP_printk(
+			"crtc=%d, refcount=%u",
+			__entry->crtc, __entry->refcount
+		    )
+);
+
+DEFINE_EVENT(drm_vblank_get_put_template, drm_vblank_get,
+	     TP_PROTO(int crtc, int refcount),
+	     TP_ARGS(crtc, refcount));
+
+/* put's refcount not sync'd using vbl_lock, use for debugging purposes only */
+DEFINE_EVENT(drm_vblank_get_put_template, drm_vblank_put,
+	     TP_PROTO(int crtc, int refcount),
+	     TP_ARGS(crtc, refcount));
+
+DECLARE_EVENT_CLASS(drm_vblank_on_off_template,
+		    TP_PROTO(int crtc, int refcount, bool enabled, bool inmodeset),
+		    TP_ARGS(crtc, refcount, enabled, inmodeset),
+		    TP_STRUCT__entry(
+			__field(int, crtc)
+			__field(int, refcount)
+			__field(bool, enabled)
+			__field(bool, inmodeset)
+		    ),
+		    TP_fast_assign(
+			__entry->crtc = crtc;
+			__entry->refcount = refcount;
+			__entry->enabled = enabled;
+			__entry->inmodeset = inmodeset;
+		    ),
+		    TP_printk(
+			"crtc=%d, refcount=%u, enabled=%s, inmodeset=%s",
+			__entry->crtc, __entry->refcount,
+			__entry->enabled ? "true" : "false",
+			__entry->inmodeset ? "true" : "false"
+		    )
+);
+
+DEFINE_EVENT(drm_vblank_on_off_template, drm_vblank_on,
+	     TP_PROTO(int crtc, int refcount, bool enabled, bool inmodeset),
+	     TP_ARGS(crtc, refcount, enabled, inmodeset));
+
+DEFINE_EVENT(drm_vblank_on_off_template, drm_vblank_off,
+	     TP_PROTO(int crtc, int refcount, bool enabled, bool inmodeset),
+	     TP_ARGS(crtc, refcount, enabled, inmodeset));
+
+DECLARE_EVENT_CLASS(drm_deferred_vblank_template,
+		    TP_PROTO(int crtc),
+		    TP_ARGS(crtc),
+		    TP_STRUCT__entry(
+			__field(int, crtc)
+		    ),
+		    TP_fast_assign(
+			__entry->crtc = crtc;
+		    ),
+		    TP_printk(
+			"crtc=%d",
+			__entry->crtc
+		    )
+);
+
+DEFINE_EVENT(drm_deferred_vblank_template, drm_deferred_vblank_enable_queued,
+	     TP_PROTO(int crtc),
+	     TP_ARGS(crtc));
+
+DEFINE_EVENT(drm_deferred_vblank_template, drm_deferred_vblank_enable,
+	     TP_PROTO(int crtc),
+	     TP_ARGS(crtc));
+
+TRACE_EVENT(drm_deferred_vblank_disable_queued,
+	    TP_PROTO(int crtc, int delay_ms),
+	    TP_ARGS(crtc, delay_ms),
+	    TP_STRUCT__entry(
+		__field(int, crtc)
+		__field(int, delay_ms)
+	    ),
+	    TP_fast_assign(
+		__entry->crtc = crtc;
+		__entry->delay_ms = delay_ms;
+	    ),
+	    TP_printk(
+		"crtc=%d, delay_ms=%d",
+		__entry->crtc,
+		__entry->delay_ms
+	    )
+);
+
+DEFINE_EVENT(drm_deferred_vblank_template, drm_deferred_vblank_disable,
+	     TP_PROTO(int crtc),
+	     TP_ARGS(crtc));
+
+DEFINE_EVENT(drm_deferred_vblank_template,
+	     drm_deferred_vblank_wait_enable_start,
+	     TP_PROTO(int crtc),
+	     TP_ARGS(crtc));
+
+DEFINE_EVENT(drm_deferred_vblank_template,
+	     drm_deferred_vblank_wait_enable_end,
+	     TP_PROTO(int crtc),
+	     TP_ARGS(crtc));
+
 #endif /* _DRM_TRACE_H_ */
 
 /* This part must be outside protection */
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 4b73ccde35425..3a010ee1a6596 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1266,6 +1266,8 @@ static void drm_vblank_deferred_enable_worker(struct work_struct *work)
 	if (drm_WARN_ON(dev, !crtc))
 		return;
 
+	trace_drm_deferred_vblank_enable(crtc->index);
+
 	if (crtc->funcs->pre_enable_vblank)
 		crtc->funcs->pre_enable_vblank(crtc);
 
@@ -1295,6 +1297,8 @@ static void drm_vblank_deferred_disable_worker(struct work_struct *work)
 	if (drm_WARN_ON(dev, !crtc))
 		return;
 
+	trace_drm_deferred_vblank_disable(crtc->index);
+
 	if (crtc->funcs->pre_disable_vblank)
 		crtc->funcs->pre_disable_vblank(crtc);
 
@@ -1324,10 +1328,14 @@ void drm_crtc_vblank_wait_deferred_enable(struct drm_crtc *crtc)
 	if (!drm_crtc_needs_deferred_vblank(crtc))
 		return;
 
+	trace_drm_deferred_vblank_wait_enable_start(crtc->index);
+
 	if (!wait_for_completion_timeout(&vblank->enable_done,
 	    msecs_to_jiffies(1000)))
 		drm_err(crtc->dev, "CRTC-%d: Timed out waiting for deferred vblank enable\n",
 			 drm_crtc_index(crtc));
+
+	trace_drm_deferred_vblank_wait_enable_end(crtc->index);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_wait_deferred_enable);
 
@@ -1348,11 +1356,15 @@ int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
 		drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe));
 
 	spin_lock_irqsave(&dev->vbl_lock, irqflags);
+
+	trace_drm_vblank_get(pipe, atomic_read(&vblank->refcount));
+
 	/* Going from 0->1 means we have to enable interrupts again */
 	if (atomic_add_return(1, &vblank->refcount) == 1) {
 		if (needs_deferred_enable) {
 			/* Arm completion before queueing deferred enable */
 			reinit_completion(&vblank->enable_done);
+			trace_drm_deferred_vblank_enable_queued(pipe);
 			queue_work(dev->deferred_vblank_wq, &vblank->enable_work);
 		} else {
 			ret = drm_vblank_enable(dev, pipe);
@@ -1408,6 +1420,8 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 	needs_deferred_disable =
 		drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe));
 
+	trace_drm_vblank_put(pipe, atomic_read(&vblank->refcount));
+
 	/* Last user schedules interrupt disable */
 	if (!atomic_dec_and_test(&vblank->refcount))
 		return;
@@ -1415,18 +1429,21 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 	if (!vblank_offdelay)
 		return;
 	else if (vblank_offdelay < 0) {
-		if (needs_deferred_disable)
+		if (needs_deferred_disable) {
+			trace_drm_deferred_vblank_disable_queued(pipe, 0);
 			mod_delayed_work(dev->deferred_vblank_wq,
 					 &vblank->disable_work,
 					 0);
-		else
+		} else
 			vblank_disable_fn(&vblank->disable_timer);
 	} else if (!vblank->config.disable_immediate) {
-		if (needs_deferred_disable)
+		if (needs_deferred_disable) {
+			trace_drm_deferred_vblank_disable_queued(
+				pipe, vblank_offdelay);
 			mod_delayed_work(dev->deferred_vblank_wq,
 					 &vblank->disable_work,
 					 msecs_to_jiffies(vblank_offdelay));
-		else
+		} else
 			mod_timer(&vblank->disable_timer,
 				  jiffies + ((vblank_offdelay * HZ) / 1000));
 	}
@@ -1518,6 +1535,8 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	spin_lock(&dev->vbl_lock);
 	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
 		    pipe, vblank->enabled, vblank->inmodeset);
+	trace_drm_vblank_off(pipe, atomic_read(&vblank->refcount),
+			     vblank->enabled, vblank->inmodeset);
 
 	/* Avoid redundant vblank disables without previous
 	 * drm_crtc_vblank_on(). */
@@ -1659,6 +1678,8 @@ void drm_crtc_vblank_on_config(struct drm_crtc *crtc,
 	spin_lock_irq(&dev->vbl_lock);
 	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
 		    pipe, vblank->enabled, vblank->inmodeset);
+	trace_drm_vblank_on(pipe, atomic_read(&vblank->refcount),
+			    vblank->enabled, vblank->inmodeset);
 
 	vblank->config = *config;
 
@@ -2135,11 +2156,12 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	spin_unlock_irqrestore(&dev->event_lock, irqflags);
 
 	if (disable_irq) {
-		if (drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe)))
+		if (drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe))) {
+			trace_drm_deferred_vblank_disable_queued(pipe, 0);
 			mod_delayed_work(dev->deferred_vblank_wq,
 					 &vblank->disable_work,
 					 0);
-		else
+		} else
 			vblank_disable_fn(&vblank->disable_timer);
 	}
 
-- 
2.53.0

