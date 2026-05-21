Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25651CD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDE210F610;
	Fri, 22 May 2026 14:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="c0Im7K0f";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazon11020122.outbound.protection.outlook.com
 [52.101.150.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49DC10F23B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7IuF4O7wZdQ5IctT332qLqraZ90wqvW1auoLVcCxYxTIUiGP7ubVPmgg/taXBbU2OGLkzB+mZl7DvBoJ4XA+g2EYlVAZsLNSWhSYTeOStOUiUQeo+aQRS9KqwBDDuD8ErRh6ZijI37NUwIKG5Kp1w00poMQC6epiZy3mMBtuB/FIi+8Xj3KISh7TVugU2aLVORNnQtY+Q9pqo9C/pw8bNWntckn4DKrPL1b36hTuNx7aMAcI0wpkXjejp6h/imaicfCZT35n96Cicf9xndNezdig0um9Wg4E4a/EPQbB4QSOOtW+2OtSzkJ2Q3praUIb26GnPWLZ7wJI96b9AcQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrQfdagMbbT1Uskc/vJZIwRiDfVJQdtw71QXOjgE9W0=;
 b=ea7uvfKwC+v6254sTZ1XdDVhG2cuFK9QfHd2ELJoOmC1HCXkrOsHiEtfyfstHVLGMGVJai3J8wzla8bdYl3R3mcvfDM8kw2NGpFanGXhM6IQRAUeylrxZcB5d3x5RBrsED+y0kNNvvYxZ/oag2RdtaCgGXakFnp/CnUo+3TFSVSPlniN3QbisoauqwHR7uu4DojYaQv3xcI12U6Gjpq4MW6xOQMZtyl2Wi5/Gwe1RjviZpXpy3eZdqjLfnSWhRsEVXCWoP0AKcOS1XtyUPn9eQMwwXvt54R2o/W0EYpIc1+vvMz0B08xGgXiT+yfaKqrmEFeIwmGxjczEwc1OlKURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrQfdagMbbT1Uskc/vJZIwRiDfVJQdtw71QXOjgE9W0=;
 b=c0Im7K0f6pg9CWUPQGEAnSgKJ35nku0jo+0zS7EqlxK05MEEKV5LMkGZla22WbheYgKPsVraYw6MG1Qd6xTr4d4GUPn0u0y2VnNwF8I+NaLcKZ8S9zZvSPTBvzTYLevNyH8o5VRNmJDKmY1ZB+okcCzMuVf3tee3AOgv9FvACOOdJOTalA4hDJ/aqr/rcH0mkSa11pj7WV6d16w3BOWbtnzofU7C75Xqya4BBwBN+0XqK5oVO2pf0yUI409i9WsnYxHdeHg1By0Ad9HL9Cull0FH3LLo+0TcfnA6OPBTL6/2qB7pwDPoZVW6bnoS209HE8zcmo51Ttcg6kJESagzJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by ME0P282MB5210.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 07:37:02 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 07:37:01 +0000
Message-ID: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
Date: Thu, 21 May 2026 19:36:47 +1200
User-Agent: Mozilla Thunderbird
Content-Language: en-NZ
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From: Simon Wright <simon@symple.nz>
Subject: [PATCH v3] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts()
 helper for audio N/CTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29)
 To ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2196:EE_|ME0P282MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a583cb-3daa-4db4-d30e-08deb70bbf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 54LQ8srIG9CtQiBkwO/8DbNAIXdtTjtwgAI+MmBN+UYtpm3a25k2iCiRq3BF2+FRI4mKkWQFeclbGmYM4oE4rgsYBSBSJm+ozt7WOY+gSPZ6/gmNGz+U/7XvhTChmMe/2pp2jYtXd6IoQSBjujnrOZxLY2o9d0VT8cnhZ2o2+MMAmV+xJO8n+ofeBvqhlnd0wgwEL6WKq9r3vCjmGiA3Xd/6EhApDloHiWy+GkLBQfT+v3SaqR6mZCA9IS2qqGB6D2yH/xfgL4OPTszLEAYeBVML7MKOz/A+/IezuOdISBoMSkCJGn3QxqRwZkkUxs/NSXtGLtbdo6f4TTq9jQCtZ/BMx6jazmyvBWMinr/bygDo4q8J/u7pMHvlNedA/VAFHZ2vYIMwKIDuRDxDV1KkHtWXEELmJNfZY3ds0KEv5ulJuQKDfC5Mq0kHEmYYRPwD3Ps/Avz1l/cZ5gN1SMNDdOm9jFRIAPuFvgYGKL5Dlacg4KhgeJi+Ax+pqfz2udiF8a0l+W9Q5hPYOXIbIMgNikDkHtAr7QLYnyXj1lq8jbxNr3Q0qL1PS2BysXdFLPyITtrdpAhZtIIb9K6eFKQjcTyLoXzVFc/+X6lZsYddf77lM9HYpq48an1QrUrUp95gUqQeyGd6OsdDWI8KTU1OWXlTP5Sk8ln1gOTN6jgClyaDESabQIZxxttAqjlWvrFo1fR0M1FBhCpTUjErlEZCyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RNcXJRRmdUSUN1WFBzRGloSEJJaytzVVdDTmZSSDdPcGVGQmdGSmpQZUpP?=
 =?utf-8?B?cmJ5MVByV1FpUThxV3YxL0plcTl2cHdsWk9WL1l2L09PYkFZTGl3b1gzem14?=
 =?utf-8?B?OUV0SU0xRUJnWVU4Zk1HRnYveGZWSm45RCtZUWhWaE1qVTFGYjRLdmZyYU4v?=
 =?utf-8?B?RmlaTWFNQUUwdjhjTmcxQnlhaGhLcUFITzZXKzdWREp4Q0dZb2VxU05LQUZ0?=
 =?utf-8?B?U2RhbTZISzdaZ3FHbDBQOXZNSzNCTEJ6WDV3bVliMjhSWVpuME5jendpWjRy?=
 =?utf-8?B?b05wWnhHTllxa2NRSVU2UkttSi9SVkVuTWd3V3F2ZXhEMnV3Tm1zUW4wQUFF?=
 =?utf-8?B?REhGS3hacHFnS2lHcGpjd2xrcWltQmV3NVI2MTk0WUFvN0xZOHl6NmdFbDBL?=
 =?utf-8?B?WjA5RXd2b1lTTC9UMkhTVy8zRXoxYjV0OW5wWDl0MG50L2FTbDMwOTBscVQy?=
 =?utf-8?B?WFltZTVwd1NpTjhPM3FUall4NTFJeU9VYmhHUTJ5VHpMbzBrODFTYUVzekZj?=
 =?utf-8?B?Q2NYbVY5L3BVWkxyQTN3SEEzUHdEWSs1UE1UQXJWS1dNUXE5b3FnS0ZlbjFE?=
 =?utf-8?B?L08zaVBzTUJUbjNLcG5Ob2FORTdqNzBhSXR5WEdlSHc5cjZoWlRFVHVOM1RV?=
 =?utf-8?B?MTV5SEdQQmxNNHI4SXk1Y0ZSekVJdlQxSi9ENm1KZ092STBKakszYTFYd24z?=
 =?utf-8?B?aGp5WHc3RGsxY1plWnZBRm9IanVMaHM4Q29GMWkzZmhZSEEwOTUzNnVRN3Vj?=
 =?utf-8?B?Skhwa2oydFMvUU5Mdkt5MVB3RDRKTjZCN1k3YnFVaklBYnEzYmRWNFJ3ckdX?=
 =?utf-8?B?aDhPbzhuOFNPeFZnRW1QSlpSNlF5SnF2QzRSRWpLc2RONDE5eUdsUU13N0FF?=
 =?utf-8?B?bkVVQnVBUkdXZ3JBK2dJVVE3YVdNdzBYMlVpcG9XRC9TVENjeW9JcVpUUXFH?=
 =?utf-8?B?OHUyMG1wTndvN2doTkQ2ajh1dUpRU3pIYkZHd1hMcWJ5MWxnQlFXL0RWdzl6?=
 =?utf-8?B?VW1TVXpDTUYvT2VKUW1Eb243VDFqUncvR1VEY2VtTEtxbGk1S0Z3cS8ra1BY?=
 =?utf-8?B?NTM3dDFZWVdVd3FCc1h6b1dEc0R2TmdTZFVLb1JMV0syUXVHYytkNzlEQ1Qr?=
 =?utf-8?B?bGxCLzBUWUgzdnE3SG1hQUVGY2tvN0pXYThERUx6cHo1b0tnV1lyMDBkcHBI?=
 =?utf-8?B?REpzbnU1QTUrNHc1aWQ1UmU2bVhxeW9xTDdqSk4xYnFBSFBKRklqak1NRlFx?=
 =?utf-8?B?R0lSalBuZG5MKzJQaE5LakIxTDdVYnhDQkZ5WWNBK3QyZExhZnJ0aFdBN0F3?=
 =?utf-8?B?eWJNc2R4MDFBbjNFS3RkV2tRQ2RaeHVDUUFLVktqeTQrRUpCZmFXcW5HNFZn?=
 =?utf-8?B?NG1McUsrUXE0Yk94N092WXFncjBxeGNDMUttMENEOWtPRWN5VDBjTW9OaW1O?=
 =?utf-8?B?MFUwSy9yVWxGcHhMMnV2Vy9aTCsvOWh5c3ByeDlxNUhTNmJKK09ZMXhCaEZv?=
 =?utf-8?B?Y2ovUHFla3J4RDZmMjNLdDYvZnh6dno2Zm01VkJneVFicGdPdXNaMVBzZGtq?=
 =?utf-8?B?cm9MVUVJbEJYU0puZTBQYkp3NGU5WHhnZmJhdlQ1OTk5Mk5yS3FvZkM4Qkl5?=
 =?utf-8?B?RkJrb21XTVg2M2dCb2NENXBtdmMwNTFYL1A5cjE4VkZYQ0hocG10Q1g3TEF4?=
 =?utf-8?B?a3hMK1ZCRndTM3F1N3ZoLy9FbHhnRU9NQ0dhNHNEV3h2di9EQkx6UjRQM1Fh?=
 =?utf-8?B?UHYrRXI5SGpPbFFoaGJTR3VWWkdQQWRUZTNGQ0JzZUV5Mnp4WjRuN0d5VkJi?=
 =?utf-8?B?NDJwTWRVYjVQWEo2N2tuTjdtTWpYWFZjZ0U2Y204aStPNnk4K3FmN3M1UVhE?=
 =?utf-8?B?U0RqUERvSGJpSVRiRXg1d21YMVlKcllhSlYvMGtBUm1RZERqS0RDVVRCT2Y1?=
 =?utf-8?B?SFY2Q3dzTXFiT1lPK0RzaFBGeVpxSFNMRC9SZ2Y4YWZ1TDNUN0UvT1ZwVElh?=
 =?utf-8?B?K25mcys2TyswNGlhdXNUbTIvaXJBRzBjZmtWblI5VTlnTE83cXpXQVVCUTZD?=
 =?utf-8?B?ZVo1SXZJT2tkNFY0REpsYTJNZElsLzBMQXQzK2Y0UnFSM0o5NkhFNUpBbTVx?=
 =?utf-8?B?aExsbDRBbmlpNGl2NjdkMDFKU1ZmQTFuMFhXM1cwWW5ONWtVc0c1RzN6empF?=
 =?utf-8?B?UUJDUklTRkhsL3g4clkvVEF5MHdKNnBkeko3MnZoenpFcUltOTZMcFA5V0ND?=
 =?utf-8?B?aTJ1ZG5GOWNWNzl3OE81OVN0bWNqeGp3YTBJWGFqMFU3ejRibU5MZHc4OHhk?=
 =?utf-8?Q?ONnnpbrs9gghWBAEaZ?=
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a583cb-3daa-4db4-d30e-08deb70bbf48
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:37:01.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh4vY1S/O6TH/37NBJ3rqoCft4tq6mNLbQIRJWWu9dBTmtyNceeXzHZYV/yNpkri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB5210
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

dw_hdmi_qp_set_sample_rate() open-coded its own N and CTS lookup
tables and search/compute helpers, but it lacked the out-of-table
CTS fallback needed by strict HDMI sinks at TMDS rates not in the
table.  The original LG G3 OLED audio mute (linux-rockchip 070633)
was caused by dw_hdmi_qp_find_cts() returning 0 at 185.625 MHz,
leaving AUDPKT_ACR_CTS_OVR_EN clear and falling back to the
controller's internal CTS auto-measurement, which produces incorrect
timing on the wire at out-of-table rates.

The shared drm_hdmi_acr_get_n_cts() helper in
drivers/gpu/drm/display/drm_hdmi_helper.c already implements the
correct behaviour: it has the HDMI 1.4b spec N/CTS tables, and for
TMDS rates not in the table it computes CTS = (TMDS * N) / (128 * Fs)
inline (the canonical HDMI spec formula).  It is already used by
drivers/gpu/drm/msm/hdmi/hdmi_audio.c.

Convert dw_hdmi_qp_set_sample_rate() to call the helper.  This
removes ~200 lines of open-coded tables and search functions
(dw_hdmi_qp_find_n, _compute_n, _find_cts, _audio_math_diff,
_match_tmds_n_table, common_tmds_n_table[], common_tmds_cts_table[])
and fixes the strict-sink audio mute as a side effect of using the
helper's complete N+CTS path.

Tested on R76S (RK3576) running Linux 7.0.1, against the LG G3 OLED
(the sink that originally reported the mute in linux-rockchip
070633) at four TMDS rates spanning HDMI 1.4 and HDMI 2.0:

  TMDS         Mode              Audio with v3
  148.5 MHz    1080p60   8-bit   plays
  185.625 MHz  1080p60  10-bit   plays
  297 MHz      1080p100  8-bit   plays
  594 MHz      3840p60   8-bit   plays

Without this change, the LG G3 mutes audio at 185.625, 297, and
594 MHz (every rate outside dw-hdmi-qp's open-coded CTS table,
which contained only 148.5 MHz and below).  With this change,
drm_hdmi_acr_get_n_cts() supplies the correct CTS at every rate --
table-canonical at 148.5 / 297 / 594 MHz, and computed via the
HDMI 1.4b formula at 185.625 MHz.  The 148.5 MHz row is a
regression check confirming the in-table path is unchanged.

The Kogan KALED43XU9210STA (a permissive HDMI 2.0 sink that plays
audio at all rates with or without this change) was used as a
no-regression control: audio plays at 594 MHz with v3 loaded.

The open-coded N table in dw-hdmi-qp included optimised N values
for some TMDS rates that are not in the helper's table (e.g.
various non-CEA rates between 28-162 MHz).  For those rates the
helper's fallback returns N = 128 * Fs / 1000, which is the same
value dw_hdmi_qp_compute_n() returned when no table optimisation
was needed; no audio regression has been observed at the rates
tested above.

Reported-by: Simon Wright <simon@symple.nz>
Closes: https://lore.kernel.org/linux-rockchip/ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM/
Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Simon Wright <simon@symple.nz>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Simon Wright <simon@symple.nz>
---
Changes in v3:
  - Switch to drm_hdmi_acr_get_n_cts() helper as suggested by Jonas
    Karlman, instead of adding the cts-from-N fallback inline.
    Removes ~200 lines of open-coded N/CTS tables and search code,
    and brings dw-hdmi-qp in line with msm/hdmi.
  - Re-tested on the LG G3 OLED (the sink that originally reported
    the mute) at all four TMDS rates (148.5 / 185.625 / 297 / 594
    MHz); audio plays at every rate.  v3 has not been re-tested on
    the LG C4 OLED or TCL 75P7K QLED that v2 included; those sinks
    are expected to behave the same as G3 since the helper returns
    spec-canonical HDMI 1.4b values.
  - Also addresses a do_div() divisor-type style issue flagged by
    sashiko's automated review of v2 (the offending line is removed
    by the helper switch).
  - Add Suggested-by: Jonas Karlman.
  - Rebased onto current drm-misc-next.

Changes in v2:
  - Resend after v1 was mailer-mangled and unapplyable (reported by
    Luca Ceresoli).
  - Body split into shorter paragraphs for readability per Luca's
    review.
  - Original LG G3 report (linux-rockchip 070633) moved from inline
    prose to a Closes: trailer paired with Reported-by:, per
    Documentation/process/submitting-patches.rst.
  - Add Assisted-by: trailer per
    Documentation/process/coding-assistants.rst.

v2: https://lore.kernel.org/linux-rockchip/00a34a82-213b-4b03-801c-3c10b163d643@symple.nz/
v1: https://lore.kernel.org/linux-rockchip/92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz/

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 209 +------------------
 1 file changed, 1 insertion(+), 208 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 0dbb1274360..4e745e2c97b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -42,88 +42,6 @@
 
 #define SCRAMB_POLL_DELAY_MS	3000
 
-/*
- * Unless otherwise noted, entries in this table are 100% optimization.
- * Values can be obtained from dw_hdmi_qp_compute_n() but that function is
- * slow so we pre-compute values we expect to see.
- *
- * The values for TMDS 25175, 25200, 27000, 54000, 74250 and 148500 kHz are
- * the recommended N values specified in the Audio chapter of the HDMI
- * specification.
- */
-static const struct dw_hdmi_audio_tmds_n {
-	unsigned long tmds;
-	unsigned int n_32k;
-	unsigned int n_44k1;
-	unsigned int n_48k;
-} common_tmds_n_table[] = {
-	{ .tmds = 25175000,  .n_32k = 4576,  .n_44k1 = 7007,  .n_48k = 6864, },
-	{ .tmds = 25200000,  .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 27000000,  .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 28320000,  .n_32k = 4096,  .n_44k1 = 5586,  .n_48k = 6144, },
-	{ .tmds = 30240000,  .n_32k = 4096,  .n_44k1 = 5642,  .n_48k = 6144, },
-	{ .tmds = 31500000,  .n_32k = 4096,  .n_44k1 = 5600,  .n_48k = 6144, },
-	{ .tmds = 32000000,  .n_32k = 4096,  .n_44k1 = 5733,  .n_48k = 6144, },
-	{ .tmds = 33750000,  .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 36000000,  .n_32k = 4096,  .n_44k1 = 5684,  .n_48k = 6144, },
-	{ .tmds = 40000000,  .n_32k = 4096,  .n_44k1 = 5733,  .n_48k = 6144, },
-	{ .tmds = 49500000,  .n_32k = 4096,  .n_44k1 = 5488,  .n_48k = 6144, },
-	{ .tmds = 50000000,  .n_32k = 4096,  .n_44k1 = 5292,  .n_48k = 6144, },
-	{ .tmds = 54000000,  .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 65000000,  .n_32k = 4096,  .n_44k1 = 7056,  .n_48k = 6144, },
-	{ .tmds = 68250000,  .n_32k = 4096,  .n_44k1 = 5376,  .n_48k = 6144, },
-	{ .tmds = 71000000,  .n_32k = 4096,  .n_44k1 = 7056,  .n_48k = 6144, },
-	{ .tmds = 72000000,  .n_32k = 4096,  .n_44k1 = 5635,  .n_48k = 6144, },
-	{ .tmds = 73250000,  .n_32k = 11648, .n_44k1 = 14112, .n_48k = 6144, },
-	{ .tmds = 74250000,  .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 75000000,  .n_32k = 4096,  .n_44k1 = 5880,  .n_48k = 6144, },
-	{ .tmds = 78750000,  .n_32k = 4096,  .n_44k1 = 5600,  .n_48k = 6144, },
-	{ .tmds = 78800000,  .n_32k = 4096,  .n_44k1 = 5292,  .n_48k = 6144, },
-	{ .tmds = 79500000,  .n_32k = 4096,  .n_44k1 = 4704,  .n_48k = 6144, },
-	{ .tmds = 83500000,  .n_32k = 4096,  .n_44k1 = 7056,  .n_48k = 6144, },
-	{ .tmds = 85500000,  .n_32k = 4096,  .n_44k1 = 5488,  .n_48k = 6144, },
-	{ .tmds = 88750000,  .n_32k = 4096,  .n_44k1 = 14112, .n_48k = 6144, },
-	{ .tmds = 97750000,  .n_32k = 4096,  .n_44k1 = 14112, .n_48k = 6144, },
-	{ .tmds = 101000000, .n_32k = 4096,  .n_44k1 = 7056,  .n_48k = 6144, },
-	{ .tmds = 106500000, .n_32k = 4096,  .n_44k1 = 4704,  .n_48k = 6144, },
-	{ .tmds = 108000000, .n_32k = 4096,  .n_44k1 = 5684,  .n_48k = 6144, },
-	{ .tmds = 115500000, .n_32k = 4096,  .n_44k1 = 5712,  .n_48k = 6144, },
-	{ .tmds = 119000000, .n_32k = 4096,  .n_44k1 = 5544,  .n_48k = 6144, },
-	{ .tmds = 135000000, .n_32k = 4096,  .n_44k1 = 5488,  .n_48k = 6144, },
-	{ .tmds = 146250000, .n_32k = 11648, .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 148500000, .n_32k = 4096,  .n_44k1 = 6272,  .n_48k = 6144, },
-	{ .tmds = 154000000, .n_32k = 4096,  .n_44k1 = 5544,  .n_48k = 6144, },
-	{ .tmds = 162000000, .n_32k = 4096,  .n_44k1 = 5684,  .n_48k = 6144, },
-
-	/* For 297 MHz+ HDMI spec have some other rule for setting N */
-	{ .tmds = 297000000, .n_32k = 3073,  .n_44k1 = 4704,  .n_48k = 5120, },
-	{ .tmds = 594000000, .n_32k = 3073,  .n_44k1 = 9408,  .n_48k = 10240,},
-
-	/* End of table */
-	{ .tmds = 0,         .n_32k = 0,     .n_44k1 = 0,     .n_48k = 0,    },
-};
-
-/*
- * These are the CTS values as recommended in the Audio chapter of the HDMI
- * specification.
- */
-static const struct dw_hdmi_audio_tmds_cts {
-	unsigned long tmds;
-	unsigned int cts_32k;
-	unsigned int cts_44k1;
-	unsigned int cts_48k;
-} common_tmds_cts_table[] = {
-	{ .tmds = 25175000,  .cts_32k = 28125,  .cts_44k1 = 31250,  .cts_48k = 28125,  },
-	{ .tmds = 25200000,  .cts_32k = 25200,  .cts_44k1 = 28000,  .cts_48k = 25200,  },
-	{ .tmds = 27000000,  .cts_32k = 27000,  .cts_44k1 = 30000,  .cts_48k = 27000,  },
-	{ .tmds = 54000000,  .cts_32k = 54000,  .cts_44k1 = 60000,  .cts_48k = 54000,  },
-	{ .tmds = 74250000,  .cts_32k = 74250,  .cts_44k1 = 82500,  .cts_48k = 74250,  },
-	{ .tmds = 148500000, .cts_32k = 148500, .cts_44k1 = 165000, .cts_48k = 148500, },
-
-	/* End of table */
-	{ .tmds = 0,         .cts_32k = 0,      .cts_44k1 = 0,      .cts_48k = 0,      },
-};
-
 struct dw_hdmi_qp_i2c {
 	struct i2c_adapter	adap;
 
@@ -215,130 +133,6 @@ static void dw_hdmi_qp_set_cts_n(struct dw_hdmi_qp *hdmi, unsigned int cts,
 		       AUDPKT_ACR_CONTROL1);
 }
 
-static int dw_hdmi_qp_match_tmds_n_table(struct dw_hdmi_qp *hdmi,
-					 unsigned long pixel_clk,
-					 unsigned long freq)
-{
-	const struct dw_hdmi_audio_tmds_n *tmds_n = NULL;
-	int i;
-
-	for (i = 0; common_tmds_n_table[i].tmds != 0; i++) {
-		if (pixel_clk == common_tmds_n_table[i].tmds) {
-			tmds_n = &common_tmds_n_table[i];
-			break;
-		}
-	}
-
-	if (!tmds_n)
-		return -ENOENT;
-
-	switch (freq) {
-	case 32000:
-		return tmds_n->n_32k;
-	case 44100:
-	case 88200:
-	case 176400:
-		return (freq / 44100) * tmds_n->n_44k1;
-	case 48000:
-	case 96000:
-	case 192000:
-		return (freq / 48000) * tmds_n->n_48k;
-	default:
-		return -ENOENT;
-	}
-}
-
-static u32 dw_hdmi_qp_audio_math_diff(unsigned int freq, unsigned int n,
-				      unsigned int pixel_clk)
-{
-	u64 cts = mul_u32_u32(pixel_clk, n);
-
-	return do_div(cts, 128 * freq);
-}
-
-static unsigned int dw_hdmi_qp_compute_n(struct dw_hdmi_qp *hdmi,
-					 unsigned long pixel_clk,
-					 unsigned long freq)
-{
-	unsigned int min_n = DIV_ROUND_UP((128 * freq), 1500);
-	unsigned int max_n = (128 * freq) / 300;
-	unsigned int ideal_n = (128 * freq) / 1000;
-	unsigned int best_n_distance = ideal_n;
-	unsigned int best_n = 0;
-	u64 best_diff = U64_MAX;
-	int n;
-
-	/* If the ideal N could satisfy the audio math, then just take it */
-	if (dw_hdmi_qp_audio_math_diff(freq, ideal_n, pixel_clk) == 0)
-		return ideal_n;
-
-	for (n = min_n; n <= max_n; n++) {
-		u64 diff = dw_hdmi_qp_audio_math_diff(freq, n, pixel_clk);
-
-		if (diff < best_diff ||
-		    (diff == best_diff && abs(n - ideal_n) < best_n_distance)) {
-			best_n = n;
-			best_diff = diff;
-			best_n_distance = abs(best_n - ideal_n);
-		}
-
-		/*
-		 * The best N already satisfy the audio math, and also be
-		 * the closest value to ideal N, so just cut the loop.
-		 */
-		if (best_diff == 0 && (abs(n - ideal_n) > best_n_distance))
-			break;
-	}
-
-	return best_n;
-}
-
-static unsigned int dw_hdmi_qp_find_n(struct dw_hdmi_qp *hdmi, unsigned long pixel_clk,
-				      unsigned long sample_rate)
-{
-	int n = dw_hdmi_qp_match_tmds_n_table(hdmi, pixel_clk, sample_rate);
-
-	if (n > 0)
-		return n;
-
-	dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
-		 pixel_clk);
-
-	return dw_hdmi_qp_compute_n(hdmi, pixel_clk, sample_rate);
-}
-
-static unsigned int dw_hdmi_qp_find_cts(struct dw_hdmi_qp *hdmi, unsigned long pixel_clk,
-					unsigned long sample_rate)
-{
-	const struct dw_hdmi_audio_tmds_cts *tmds_cts = NULL;
-	int i;
-
-	for (i = 0; common_tmds_cts_table[i].tmds != 0; i++) {
-		if (pixel_clk == common_tmds_cts_table[i].tmds) {
-			tmds_cts = &common_tmds_cts_table[i];
-			break;
-		}
-	}
-
-	if (!tmds_cts)
-		return 0;
-
-	switch (sample_rate) {
-	case 32000:
-		return tmds_cts->cts_32k;
-	case 44100:
-	case 88200:
-	case 176400:
-		return tmds_cts->cts_44k1;
-	case 48000:
-	case 96000:
-	case 192000:
-		return tmds_cts->cts_48k;
-	default:
-		return -ENOENT;
-	}
-}
-
 static void dw_hdmi_qp_set_audio_interface(struct dw_hdmi_qp *hdmi,
 					   struct hdmi_codec_daifmt *fmt,
 					   struct hdmi_codec_params *hparms)
@@ -458,8 +252,7 @@ static void dw_hdmi_qp_set_sample_rate(struct dw_hdmi_qp *hdmi, unsigned long lo
 {
 	unsigned int n, cts;
 
-	n = dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
-	cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
+	drm_hdmi_acr_get_n_cts(tmds_char_rate, sample_rate, &n, &cts);
 
 	dw_hdmi_qp_set_cts_n(hdmi, cts, n);
 }

base-commit: a48bbcc7ac739e93562d6148c6fa504c2e9f22f8
-- 
2.53.0

