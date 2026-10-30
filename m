Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD49606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=XizF0I5H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CF610E89B;
	Fri, 30 Oct 2026 09:53:23 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B9410E865
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ/ewbGSNIXj1TSiZU1q1VaVle577vnzztQrDQ9eA50ygHhAzyr+6cW8Hpx2AgCkqD5P3kIeslj50+ttwHpLJaL8mNuCPK7bVRwTamNlp+a6jk66gzGANZ99YkU5lJU7zRRr9Bs0O8UJjnSobiXGPPEV2RCQqqdpoGJKEHbJhx/UWKEFMgXIlAS5AE5hvC4nLtrvQANRwEPDsx+Iz7gm5ZB0Y/83XETcDtg+1dTL6um15cHtdXXVDeltHGuZDvOeRIZbgpwl7LECOohyG6Ed2GD1vWOD8wmhz8P5manc0JG9a89iPLfsFAogz/KEx2feP3PPbk5RyiplZFrX+XpVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaQNiFuTq+VHuJT98ndkdbVs9pf8GOWc9/zeRyNgX/8=;
 b=B9zMJpgEBms/yteuNnMJ2xzTdBV24ctBIvTcfgVZsGK+3WbiIzv0qtRk2YtgJvrjGAm4Bd7A9ei2NpYuSH1Ygsfl+2weduG4jqPDz8pbbOtbxSVLkCxuYndvwAcj7gIo1Yl68X88t0zvs4n7dPh2AQ14+QvpL8NKmE0WHVCT6XRrBzbJeWdYmCaCGWlo4uTEmaQpv8dOq5yAE+7He9ed/1k8YNkvKbnr0dB/ZqQcBQwhoE6P+202Y+tcsvlqhlagDxVbRHq7zxkt1c28HJFmHmy7e0n8jqOEYYtg1/oR/oSrbchZtf8I3jizBhkLehhdwePhbr9t+lvu+dqZIMOhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaQNiFuTq+VHuJT98ndkdbVs9pf8GOWc9/zeRyNgX/8=;
 b=XizF0I5HvtUcJqXt2ppGhIwp1iKmCMPSbhIzbmtXjdWfAYHeu1KVX6eQmpaH9wU5QE/OG53COfVYfRV73vqx1YFS83b38Tp/W1aRW2mng14hX+mGNLwqWAUndxXXl5E/PsYChjaqqqSKsg0nuwCG+lp0cRCYSvbSVBpi0jiSt0EKmF9qdDqlEQwPMqtEV26WodCUbz5jt8eF1DuzdY1CPEIjlkPHzZaYdNXCoO0mr2FoiawSE6o+wbaLdjIO+4vkVDQaO5mdKo0xo2MaIsaC8CSfmNpEQXFYJ1QiPcVMBs2KPOQ5wanofUcu2CXvbmROG7vbRYKQEAb9M8V8X9A5/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:12 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:12 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:27 +0800
Subject: [PATCH v8 03/15] drm/imx: dc-plane: Disable plane when it is invisible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-3-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: 915e13b2-b872-4ad1-a78e-08df366b9c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jqXeieaWBr7dUaTbgASyAxtH1Fzf5iwy+SnjedzCJhcxM4NAnWyliPE5/hB5nz3QTBs0GpRcmYYe3fqwneZoZE57+aYM45/IHTXArCItplg9i66zoKtYzgwhI+cJWwj1ryL0iMQNkUDq5eN8AC7Fb02giEzoF9UcXtBR2UFTraV56gRUAkET1WSC5wATMdw7Ul9POtP95sPJQc44MhpU3MOGlTYl0nULRGUXgoJaH0AXiVGV2+vqgSz3qk54dfnWe0EbiEK7t9SyC6ioc6CRCmEyY1pWagTw+BWTbjzMcojjUotQn0CDQHq3oOAeADMZlfX3rgACg2FuCf23ANIYaqxFoaJqTtofOu729jEP/4M+/815s4G0iMF2KZBYG47GocbzmeUMphO8ZIBvqTYAKRm2gJjaprnQitvYeT9sZHv71apI8DvAasXcwLfAomZgU05tABz4qC/c0TQqHfVO5MgaTnEtQ3MVxVq3sIlSFh3u2D62Wy8Eab9q9E6mF/0gXzqKojZpoW36tz7vEXm4mcjjRN4FbACMhr+GvfajRMIWvp4UdGHGdgAzmBBtdpAl2L4kGnGjDNmsb2V1H05m3t1AaKO8SrK4eq8hEk/4EJvRjdJTHQ9XAfZIR6T3c2Z/XJ5I+1+jXkQAjiPXHnwU/lwtMnL0dr2HizS/0lYZJDzTEc80vfjTloDLThmiJHEktYb0mQZuot3QOhb0ZIEcQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNyTWREN3lXYmJla2t1Z01MMkxma3IvMkQ4akY4RUhwU05rWFVJam55RkZS?=
 =?utf-8?B?cWFpQjRha1d6Q0tkU0JsaXY0MmQyTEgwVlNwazRZNlVib0h3bWN5RkI4Tkov?=
 =?utf-8?B?WTF5aVJzSWc5Z0VaT3RuNmlUbnp1TC9WaWZnK3ZmUmNnZklmcmx0V00zMi9n?=
 =?utf-8?B?by9VM2VwVUpBbkx2TVJxbG42ajk2SFFLRlA1QlFhMWw3cHl1NjAyWWZaZWp1?=
 =?utf-8?B?aC9tR0sva0trRG5RU1JYZ0ZjcXpQSU9OTENOSWpRVUd2YUlhUk1zRFIyTk42?=
 =?utf-8?B?ZzBvL3F3MlZ1dTQ0cnYwYUdyTnVXSVRrTHJ6T2xTaGtaK0VsRzI4WnJEaERT?=
 =?utf-8?B?b2FLS1ZjMUpGL09uRGpoSElyOW96bXI1RjVOUDdVK3FSQitJRTAzQ1ltdnhC?=
 =?utf-8?B?b3hzd1BkM1Rmd1lIRGxaQ3VZYll2TmIzbExtZXRuS1ZTVFhReUFSdFdsWm9k?=
 =?utf-8?B?d1lzVzJNdnZ0SS9nYjVhZnpNcUFJYzR1OHk0NWRQRDUrNlgvVitUMzFKVE1x?=
 =?utf-8?B?OFQ2azhuaXRpMURtTW92T0hLZmk5ZXNIZEhLZTQxbGxpc3BMMzdKR0JjdWVJ?=
 =?utf-8?B?dHpiQVQ2ZHp3bEludmtKRzRFOFFNaXM0MlBKVlRmbTRSUXhhNUxOekRzaEdp?=
 =?utf-8?B?amNrZDh1Qys0aU5VQXdnMS9TcS9wSDY5d2diSEVGU1Y5TWFTRGJBVzhjWjYz?=
 =?utf-8?B?NDNSdTIzdDRHMWlFMitsdGY0NzVVZDA5cDlaWVBjNC85QU9Vb2J1R1hpeC9P?=
 =?utf-8?B?TjhoTStnVU4yTFUxaSt4TTY3Zytia1N1TFVDUy91allmT1NEa01CejNoVzZW?=
 =?utf-8?B?Q0J6UlNXeUlkK1ZuMmRVSGs5UFFSem5OY0pyWmk1UGdPK1o0NjFQR3U5dUU3?=
 =?utf-8?B?MDk0UWFiNXRZcG1NYyt2eWFiMFJ6VUQ5VklKT2piUHFyc1l4eWNjNDI3VnFU?=
 =?utf-8?B?R3NRVElLb3A0dVpodDNWNDNkRG9XTkpBTm42b1E1RUNZeFFVQWVHQzBtU3Vm?=
 =?utf-8?B?d3ROeVlWYy9ORnQrc2txTUpySXR2cUNpdnNKU0FDVGZSTUF2cGRHTnJCd1RS?=
 =?utf-8?B?L1U3UjkwYWpTd3ZqR3B6SGVlbm9xeWhPbGdsZFBrb21rdEU1eFNnY2JMQ0x1?=
 =?utf-8?B?d29TMlQ2WFpsWnpESzk3L2x5c1F3bUsycWlkbHIyemJ0dGN2R0p0Q2M0bFZB?=
 =?utf-8?B?a3VXR1Y1T09wZ3Y5Y2VHeSthSkw0S3FDcEFTWWhIbTJ4eTNjZTUrNk1Ua09v?=
 =?utf-8?B?QjBOTkdUSE4rSnh5Q21nOVRvN3ZTUmhKWmdadlNkYXYzQjdtcWRhR3IrczYx?=
 =?utf-8?B?RkNNMlI5RitsV1cvSzlrODBkUzcxanVPZVZNUDVPMzNqMVBPaGdjNFNJbkRq?=
 =?utf-8?B?SE9DTnN0UUVXWEFmWHFDQUNUbm9VMGErWkxYc3FnV2h0dGtHUXFuWmNITkJZ?=
 =?utf-8?B?WVc2Vzd6aDhBUSthbkx5Z3VRTnRJYXBjOWVkajBQdzJIbkN0a3hlQjRna3Ex?=
 =?utf-8?B?RFdIa0NtNUdLSGFYQ1ZZMXNkbUpNckw4cHk2M0NGZVRXL0p6Z3JxMldSZitl?=
 =?utf-8?B?OEUxb3FCQ2sxVnFmTnFvUk4vdUdudTJXNnJBdnpKNXdYVUp1aXErSlNEQSt0?=
 =?utf-8?B?TjZZQTVZV0g4bXdPaG5IR0c3TzdNVXdMTEZ3ajlSSDdBQndoekhLc0tNb0pK?=
 =?utf-8?B?Y01Ld0laYkE5SHgyVmdaN3IwZ0ZRSklpMFFYQm5CaFdkQlF4cm9CNGdJWEcy?=
 =?utf-8?B?WmI0dHgvaDR3SW1adExrTStxWHNLSkN5a0hxYTF6YS9xWXhjWVJjOXNvcUxY?=
 =?utf-8?B?RkVqenZFL1VNRC82SUZFejJuZVJ3QWlMS25OUmo1NkE0dUtvdDE3UmdJY2Ji?=
 =?utf-8?B?aW12dmtKWnVuanVmWENnd1FCRzhRZzJONGFhbWN0NWRYWWRVczNlMG9wcy81?=
 =?utf-8?B?MzMzU09sdjIvYWFNcGVYVWdhZk9tQTlrcmdIUGZQQXkxSVVCNGg4eDNXQ01I?=
 =?utf-8?B?UmFZeXBjbmROamNIb01vczFTRlFKcHE1eHVoemU2blVnT3B3TWlJL0ZtY21N?=
 =?utf-8?B?NnVMUGxiQlZITndJV1I2VzlqSDBDRmJHWHgxL2JZVFl6ODRJVDR5SnNUTHht?=
 =?utf-8?B?b0dHdWpnLzg0ci84Z0VNekhUNURIRk5aSExLT3NqNmFkNFlRRXJFVm1mVnZs?=
 =?utf-8?B?UHNicWtERUxZTXo3Rk1mWWIyaituNGw2YVR5Mnpic2JBOTJTRFgrcGx4OXB5?=
 =?utf-8?B?YlRkMi85Y3NkZlYrVzB2aUJSZ1dHMkY1RWxDK3JIYzhSOVh2Q1I0SFkyc2Yy?=
 =?utf-8?B?Z2lOL0RtcEVoKzRIM2FxYlptbXNDd096STBvZkZQbTRJZ3A5UldzZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915e13b2-b872-4ad1-a78e-08df366b9c43
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:12.3043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2eYHcPcOTXoQqorz4xF/Qa/nkMdSNs/SxkfeHXbDItqlBzspFeWgX+DcNYZWMbnQlEr7dZhsn6oLbnFHTtgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Collect Laurentiu's R-b tag.

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

