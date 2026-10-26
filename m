Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A118606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=M/2ype3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C91710ED7B;
	Mon, 26 Oct 2026 10:04:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6095410ED7B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCWIUZCAk98t1/iN90JocggzjJbwyTDGxAOFqGCLTuTew6fwdhwPEKqRKW/EkUG3N5ARhckhSvjr4tgBrp7nvE8GP5jkL1w9VmPyAzjm7Hcd/BPaX5ZjxGRuKN/TPH62GyHGjK6mP8GS4GEyas0myC9YOZNz+YcnrpzNNUkt84Mo8YWNIySldZDocPtAFugyi6DVJEkkczRW9q9vj/0MIsInRtLZRuJCiWAhIApnEVbLDlq0bhBcwQ92hlnMn0b6mMIHFumOlW6veXp393SBcdJhQMbZTiMVmB48EyDKt5TWVM+Sw4Wk/1x2TnPNlxp0m+A+kQ/VvE1ddN2KI5L9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwbhFidvjMiGeUMjwnaD0razUZVskz2H4g8d1mC99h8=;
 b=kRXFGD3u1XN4UT3H+JhFMFG8XqI6+6T0RdXHr8vEK5IZA7Vx1xURzjcW6ljE5VfZPRKAkQ/VqevFn+UQWPTP2vAvOOv6trmuO4ILSxWRXU94LVwZSLkFnpOISqP31AZgqxnn7tGhYSr+J1PEkt2kBcabT5qqIxpZgcbif9dLnP41rTzvTj1Gv7UJlMGzPGeaI8ABR+ZkC2iyUzI5StulgquYb8lsH521pQmtdHzSSoUdfeV+rn53pkesE1E4FNkrFonj0PEzoDutNhJu/hdLAmWTI2CyWD8hYvRCo8KErWyeZ3vQlwNrEHUo54KE2SdQQZNfHKh4jrJfwOZlD7jc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwbhFidvjMiGeUMjwnaD0razUZVskz2H4g8d1mC99h8=;
 b=M/2ype3oXzZgssCnRZFgCH25GJMjqEVjpgaOh6I/uNEttnn/W3qDsvrdnymO+9YFsLea0Fwvh9I5CTUbRZ0PAWHx9mHSdfMd87+NlVw/i+7260j6Iph6OycPmfPFEHZvflKDNFmmkvesFAm2kogajrbYO8klg+D46jo2JrLJ5d3hIRuDMy3q4thdEjDDfoOv7bmoGakDmNzuc5X4L+mAucb2E+LcpPGiNz4w8Lx0p3aSZEwF++VdGkJO/LP0F6BW9PwEJTSmgXnerFsry0cTExRPjp8+pMYDZ/tI10zzS8dt2dyylUx3zs7ZxYg8VxADXnx/n1O7R8GnYGHEYxwhlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:03:53 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:03:53 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:08 +0800
Subject: [PATCH v7 03/15] drm/imx: dc-plane: Disable plane when it is invisible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-3-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DU4PR04MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe0354b-308b-44fe-b86f-08df334870a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: XFM0NevAsC0rVj0CRxjZsGyqh+U01K7K5W+JZ9FA6ktd/7DAIpJiDNLL6E1YwgzXUTkQA/ohc5H6TmAsl0c1WSWFWVS/hzPMUYC0cKMruPBOjNkYBis9RTtCPzT2T23jjm8+WSE8U5U4SoiNDbc9QkGUDxoYi5Y31spYwxxU+tcVeU+Chi6HCLXcLdNrWan6GZUDSEB3IBEoMl37KYILHndlInn24Z7P0XPXCdOvwfFPE5ei7FbkjK75mvkNHgCWyuih58RYc3RWCkn94PLJaE4Lp8mRAGKQM8NDBvwDve3ZTeBK9w1hlt4cV8zDFgm2FdmWxbJXIOtaHB/L4iOOCE1F2mEG9YGVo0jeI+SuUEbXQbyyhQzuZ4eBIrsMsFVvtXELRMqS1cH1AldFrSIWcWEi8HVuPSuEstEyCrK6MefnnqpoH8ah4dWnsn1vXPw9BkiUF9IX22JSxoUn/lX2gCmjBTLqfwUgQw2nKukFdqDg4C+Pkb+/K8iM7t8aHl0olctOzHrq5o8sssrVH8iE9iR86VUnX7An0s/VrTzMW8THmh6g2xXTE3cqhpLjnhbskMpL+RgQmubdl1x4fdWLLBUwvkSb+sQyrvr0GzPvZUINy+bD1IAFmgQ7or83uJQbr75j4+fqpFz6yPqTgMk0FyU6zOTDxRfXiqfcxq7Jz4jRV8Uu/pOOPeBZXEhbizCL255jeoqoZCSEQsyUMoL5Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDY0elJpR29pUTdEZnFraXpWSFNRcWJ1MkFvZUNCWVk4dHJwSjF5NSs4L1hE?=
 =?utf-8?B?TFhrcXY2M0FOWHJHaFZCenBUamxoU3VGTzJ4MzMwbEt1Y2JKRXFoNlhMM1hN?=
 =?utf-8?B?TzJhcnF0bUxVVDIvUE56NUl0TUVoMFF0aUlHaDdDRFJSbCsrSlN1bEFrUE82?=
 =?utf-8?B?dHpJT2NTcWJ3UHpBRThzc0htVXlTajdQNllTNElNMWNtN0U4V0dTL0tXMlFv?=
 =?utf-8?B?WjV5aVd4M1AxNlJwRnZYTjR4QzVoMjlMWk1LMEo5WUpGWHFERTZPZ3JINllW?=
 =?utf-8?B?cGlKWDIyQnpSd1A0cTdpRXFKTytpaXkvdU5WTlh4MmQzbzZFWWpFYlpYQ0lK?=
 =?utf-8?B?cG85aEozQko2RlpYVDhJZS9yclgyTXJ6YTM5RDVWU2FncTJWNkxJa0U4bVdG?=
 =?utf-8?B?dXgxMGZRVGFQS3lMTHhYUytmelJwdTdaR2prSTUxUVdMb1A0aVhHT0JNVWtJ?=
 =?utf-8?B?RmYxTUdHWnFwWWkzRFp4enl6eWpZMm0wckdVNHNncEFoUnI4SHhQR0lNSnZo?=
 =?utf-8?B?ZkZQa1ljRHA4VXRoWTltSVVhT3MrMmhoazZBQUx2U2dsNUJMY3FzV2ZNWFBr?=
 =?utf-8?B?Q0JJL3lrYlk3MVVMMDdkOXI5b3lsNEZDVU5tdTJZVlhnVUdSaGVuVENCWjYr?=
 =?utf-8?B?cVFWV3pVbDBmWkpLWFZCSUxhNm93U0EwUUNLUmNwVDhMNXJCdWFsOFU2Kytk?=
 =?utf-8?B?cGE1NXBYMThYWnQ5YWpRVThkTXczLzcrL0x2NnRwblBpRUZZSzBCMThnNUp6?=
 =?utf-8?B?b3Z0QUl0Qm83VHFVUjZGV0pVVXJCK0FBN3V6c2RrbUJxeE9JUjdNTUhJanA5?=
 =?utf-8?B?RlNGSVN2dlFxSWJ4Z2NkZ0NTWVpiZittOVhYQWVqMlBXa2NDT2tUd3I3aHl4?=
 =?utf-8?B?VHA4NjNTbGhVeGhrZnAzZkt1UGxkV1BuSjByWGoySDN5c0FLbno2eWxpcGpZ?=
 =?utf-8?B?QlBTVXVBbUI3WGFnaldNN01lbHc3KzFrR0hMRmpERUFaQmtxQU1jUnhSbzk2?=
 =?utf-8?B?Vkh2emtTNGVDbE9OamoycEd5Mm85TDRmZStRSHNTSENManczMG5GRzlqN1Ro?=
 =?utf-8?B?eG9vdm9vZ25lQVJpdGRrbFlQWUFjVE92TDBhdW42RHpCVm94cmFDeTdnMm5C?=
 =?utf-8?B?bCt2M01ENkM5N0VvYWtXVmdSbnl2OFVsZXVDSlhaQmxQS2V1VzJ0WHBMOUQ3?=
 =?utf-8?B?WFpTTDRWWklTYTZ6MDFxd2U1NnBlQVZIWDlvQU0waDdUUVFMLzBvUjNMeXZz?=
 =?utf-8?B?RkVuZkd6WTIvY0ptZmdBN2h1QUFKNUJyR3Z4SEZxNlFHN1hXL3d3bWptVUR5?=
 =?utf-8?B?V1VWWHNya2FYK1hmN2s5UTlvc3RSc3JYSkpWQ2xXSjRNM0FtWTNJR0xxOGV6?=
 =?utf-8?B?NlJEUFl0M1BoV3FxWFhpUTBYQmQ5cU9kVTFTTXVhTzl0alZoOS9VZTgwV2hv?=
 =?utf-8?B?eEMrQ3VnZ3VZRzFJTUtUN0VkOVMrZjlHb1ZkUllQMzRmSDFqQTdHVnpXbG0r?=
 =?utf-8?B?QWpUMis1UEpsTGU5UGl3UFp3L2pDcjVCTlordmt3eFk2MmYvQXVaSlBLaStp?=
 =?utf-8?B?b1lZMHJibEFnaDRZYVdCY3EzK2VFY2Y1M1ZHOENOQlNGQXVmMEw1YWRGYzVG?=
 =?utf-8?B?SGlnZmNNK2UvRzAxTzF1bG9lbWNlY09xT0Myd3BRY1dnNWVoYzQwNkc1aDU0?=
 =?utf-8?B?YU5qaUdSb3FvN0hHdUphUWJiMXFEek9kQnhmS1kraFd3NlhUL0tNcFNHSG11?=
 =?utf-8?B?SnJYcGRzdkFtYzJtUTZDTWhUcjB2aFFwRDdta053bEc3STNJekFvZ0dtRUI2?=
 =?utf-8?B?dVc5OXpYZTZrQTBxUkNpRWdGeUpaNDg2TEwwdk5oTEVhY1hmdjdFZjdZT0VV?=
 =?utf-8?B?NndKWWJ4cUNVQms1T0NrZlFEc082SUVqNFIwdFZ2Q0NQcmtjT3JoV3NYZjJv?=
 =?utf-8?B?SnVnZ0QyZ3NVZTRCVTJEcndnaE56QjNnUnJpVVJkSXYwQUNRaGFzdy9KSzk1?=
 =?utf-8?B?SG0xRzVabzBhQ2I0dXZYVzN3UGU1dWhySjRtaWpwbWFDNVRtYWgydEVIeVh2?=
 =?utf-8?B?RXhCTnRzTE5CQ1M1b0tBZWhiNHBPY1FYNzBuWDhXcEtRZTBqYXNRdzRoOGMr?=
 =?utf-8?B?L3draGZIRXl6SUFzL3RhK0gySm9ueWNGZWpXa09uVGJTMUlnckREU1FkQmhj?=
 =?utf-8?B?SkxoYVpuZlIrc0dkWGtBRVNVdFZtaXUvem9PYStYZkR6eW8rbWVWL1BnYUFj?=
 =?utf-8?B?OXRnUXFPTXBTLzhDNm1EcDYxN3J5K2wxT3ZLUkdXMzZNNVk4N0xqN0RzQ1VR?=
 =?utf-8?B?SHMrRVRWSDl3SEhtbXBFSVZVWXBQRVZFVFZGVG1CV2h4NHNYcncwQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe0354b-308b-44fe-b86f-08df334870a8
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:03:53.3359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //xadY3gUEbfhR24H4ZZShnpD7OrypA9CExa1p2MlQnRMtSWfgqLAHUTAgrLK1EqGoKyvhTTjaeupnezMNhfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10529
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fetch unit backing plane doesn't support invisible plane because
SOURCEBUFFERDIMENSION and FRAMEDIMENSIONS registers only accept
dimension for visible frame.  Disable plane when it is invisible
to avoid wrongly programming the two registers with invisible
frame.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Newly introduced to fix invisible planes.  (Sashiko AI bot)
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 54 ++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 62dd0576fadc..42c0a46281cb 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -126,6 +126,33 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 	return dc_plane_check_fb(plane_state);
 }
 
+/* A prerequisite is that drm_dev_enter() has been called beforehand. */
+static void __dc_plane_atomic_disable(struct drm_plane *plane)
+{
+	struct dc_plane *dplane = to_dc_plane(plane);
+	const struct dc_fu_ops *fu_ops;
+
+	/* disable fetchunit in shadow */
+	fu_ops = dc_fu_get_ops(dplane->fu);
+	fu_ops->disable_src_buf(dplane->fu, DC_FETCHUNIT_FRAC0);
+
+	/* set ExtDst's source to ConstFrame */
+	dc_ed_pec_src_sel(dplane->ed, dc_cf_get_link_id(dplane->cf));
+}
+
+static void dc_plane_atomic_disable(struct drm_plane *plane,
+				    struct drm_atomic_commit *state)
+{
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
+	__dc_plane_atomic_disable(plane);
+
+	drm_dev_exit(idx);
+}
+
 static void
 dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
@@ -143,6 +170,11 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	if (!drm_dev_enter(plane->dev, &idx))
 		return;
 
+	if (!new_state->visible) {
+		__dc_plane_atomic_disable(plane);
+		goto out;
+	}
+
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
@@ -171,27 +203,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	/* set ExtDst's source to LayerBlend */
 	dc_ed_pec_src_sel(dplane->ed, dc_lb_get_link_id(lb));
-
-	drm_dev_exit(idx);
-}
-
-static void dc_plane_atomic_disable(struct drm_plane *plane,
-				    struct drm_atomic_commit *state)
-{
-	struct dc_plane *dplane = to_dc_plane(plane);
-	const struct dc_fu_ops *fu_ops;
-	int idx;
-
-	if (!drm_dev_enter(plane->dev, &idx))
-		return;
-
-	/* disable fetchunit in shadow */
-	fu_ops = dc_fu_get_ops(dplane->fu);
-	fu_ops->disable_src_buf(dplane->fu, DC_FETCHUNIT_FRAC0);
-
-	/* set ExtDst's source to ConstFrame */
-	dc_ed_pec_src_sel(dplane->ed, dc_cf_get_link_id(dplane->cf));
-
+out:
 	drm_dev_exit(idx);
 }
 

-- 
2.43.0

