Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768D606A337
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J5gOqd19
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757941126DA;
	Fri, 30 Oct 2026 09:54:01 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582261126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7dsg92mjyVEeRket47gUgOx+SkLviY2KG31yE2EVey/yBCQzXK9PbbCT43kbTNX7Fl+IWFtyK0KXlhbbWeul3gQe07tQV+TG3EWifQWDjon+MsOfth1snsfaUx/PGbduq1iifArKxc9yMhZLFUz18BvAM7v1Qj9+ldEWtvarBsWNiOx3tXbNxWI9N5XsHQbihMNtOIElliX37o+qtJH2z8j56BjliLzykDRn13PJGRNdcU3yFjL2b287lUe9VFhSFJK6uonLtwaDNU9Pj99xPweCs6jp4Py5WYhZ2TWSb0j8hsyptxIrUhiE4igHGUNcgHXbtS/TReD4gGALxpPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9KYcujEuNYpQcJRvedFCKkWToV+X8VwQK8BL6pfp5I=;
 b=mBi62AbSyBDwAvhdSrobYWbg3TEmSSOFCQk394r5ipyeqSV/gihF53ImGLT4c8aectKuJXithL+WPlIZ+vNML3rPBzPb9aszC8BbID+tytz0rD9J8gy5BTDVGwC4dX4lSZbE1/jNl/BeWRSqwl+eXBOPArBmNnTm83+uVDCau9+F+YKB2NNLjoAzAwLtfw2SJTNfGoZVlKBNZz2kLC8xf6WkQnDMnJ/t59hFZkAJGNi2LXks6s12Eno4ixORIlKsYPqTUTpux9AptXDyyy94+ciDosRFKy1E/GgKOsN37713r4pHjj+Wmm1oCDMsdloBKMJICuG77xM7ohWlU5e1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9KYcujEuNYpQcJRvedFCKkWToV+X8VwQK8BL6pfp5I=;
 b=J5gOqd19e00kw9NGKr8yaSnne0knP74un2SfXO7uWhxTpppqZoy6LDglWm8qFNIv3tGucBRgDxeQ7H3EfCS7d2vpqYennPhYbYVamJHJrCQyIp/fxIQjO84qymu5biyjm2Hzw758ul9yWhi9E9/J7QeInAAtrummz04U74vJYOimPKYZBq18az3992BW2bThUHEAnU5A4qu8zvn2HfsvCa/rkRSThINajv3sNRkIaf3sNxmmM/GWXiY0NHVVaCslHF8vSG/lwnXviS4Ig6AobpNatdFNXIg1I6xQ/OSQrTnYpBxBarxG8N2GAFzV1+cwQwXDDLTyQRP8xYOlqskreA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:50 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:50 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:33 +0800
Subject: [PATCH v8 09/15] drm/imx: dc: Use TCON operation mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-9-c4f81afd4533@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6d85c7-af31-4281-0748-08df366bb337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|18092099006|18002099003|22082099003|3023799007|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Hdy5AeXeF51Pat0vjPgee1SJ92Ya9IYpaOCxojVXy9FRYq0KKLC41pzvX02OoXVxO2XaIqGGksrUrtiyeMOg/0p8rULaBln1n3RQInPW/mf6Fe4DieO5u2gxQQHvVbLAa0VhuB7nMtKXR6ZF9QlqjHZmhs2FNKSwCkMDinf3+3Uj9qBpIRDys0254TiIg71G+FO26WCP86egOidH+uwiHiQiTK/l9frhWdtmMnoUCHQ6AY569/PcgGrniGL4lo6px0rytANKhHbFVNMZSGJov5w/6nIv7NKviw5aWBi+byyNvggguzteut/gVZDjLfKcQWEorc4v0IriLZZQTvbI7dgEXSU2Ckmd58ovMMn1uAbPpWNhUzYNe5vGRFAF9yBSpIUfYvgVo/xrwpUqvYmrafXA6NWav8vqeWNvnZvyn/H80aJ+DQ1tpNLrBKCkAtTwDMxmbynJBYea1tFvIH23++oxsVa4Gi1cJ9MDb/cpZyI052dfX3xCOXm+UEr9xHykXa+KhlCLPxFxsKWjYSbvPw+BCLCyqQbDUAXdAFeKghAfPI4cqgmhNJxBMd5p6MqIy7L/R3J9KGLRBR0Gc/twCBOrbdSAx85gB1yABD9Pz5vPupO0/nlqnN5NXByn1ZP237Fti77RSCltMk3KIKYCdJ4dVWa93lDR0x54MzOWY2NmotvhoOCBXVl+cJ2wzifdEhI7wv/CTSPtw/8cfh68Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(18092099006)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJCT0ZRUmUwNmtBNWFFYTRIdTRjWDEwZjNzQnBvemdzbVJHN1o5OGdwamY2?=
 =?utf-8?B?OFNEczB2RzJDZTdYc0FqZWowa1hiOVF2OUFzcUNkT2hJVXovMW1VNm9lem5D?=
 =?utf-8?B?SnRsSFJ0S3ZsWDRGRTV5aW1tdENhb2FKSml6OGxQYVh6blArK3hDbmVQYUx1?=
 =?utf-8?B?YzhYWkZtWWlWY2grVkRUd1hycXJoQjRPTklNWHRYVTcvK3F0cTJWQmNsV0Zn?=
 =?utf-8?B?a3RQV3hmbnI1TzczZGprak1lbXdBRzVsd05weDI3WjZnRmxMd1JuNjl4eENU?=
 =?utf-8?B?ZVdBd09CTHkwQTBDN3hlU3g5VnhHZGg1d2gvS0xOVnpXdDN3cHNNMS9WZnl0?=
 =?utf-8?B?TTZWRTRKakhRWk8wNGs3VDFZQzdLcmt1MjF4MkxDRHkwQW9mQnRMVXdneE9l?=
 =?utf-8?B?d3REeFlTWXAyME9JTC9pVmxKaVdxK3M3cWZ2VFY4c3UxU1hCT0tYTnJZeWZT?=
 =?utf-8?B?Wnh1NjJkcEtkWndQa2lpR1Bud1VWdGNrRGFSd01YYW1MeGxTeFhOTkl1eStO?=
 =?utf-8?B?aU9jeHRyVFZ3N0VFKzUxUzJKNUF4TGlaOCszK0ZPQVRJTTdjNEJ6cy94SXk3?=
 =?utf-8?B?dVdyem01QlNKU094ZzZTcVArTFBaZGhmTHdpeEJkR20rSXhncmxJN2ZaQVpI?=
 =?utf-8?B?K0tuc1l0OFhFajJpNzRmTnBEYW1XS3F3b1JjRXk2KzErOHRxTVYydDBmVzJZ?=
 =?utf-8?B?ZVp4THFQRlhGV2QwSkdWdmdkUHpVdDJLVTZkMXl6c1BkdEJMVnl4VXkvQTlW?=
 =?utf-8?B?MzlGTGQ3WHdRRHY2ZHpXWGlCc043Y1Q0Nlg1TnoxTjNkNTdiMzE5eThkSURX?=
 =?utf-8?B?Z1ZjZWh0SzhHVzk0OUo2TGZjcnpIdHFoL2JLaEdqRzM4d0dZQnNuZ3ByMys0?=
 =?utf-8?B?SFRCSFFUb0FUcjlwam85aVIxdU5JUnpobWlVWFFVbTU0bmxNNE1XUWcxY1lm?=
 =?utf-8?B?WmFWN2piWElFRUVqdVY3My82anVxcmJCdk1lQVhYcmFITFhwelRKa21XUFQ4?=
 =?utf-8?B?dnlwUU1CbndjR3lwbDhRbGI0SnF1Rm9iTldPKzgrQ2FEZGdEWThJWXYxeWpp?=
 =?utf-8?B?N2ZqUEJVUXBQOTVndTZNSGgxcGd1anExWHFnS0svZ1prTFdVL2tPcHVvTEJF?=
 =?utf-8?B?N0ZjaCtZcW5RaGRQR2ZpVWZEUmhMOWdSUzg1Q0p0R0loQVJJbXdFN2szZytO?=
 =?utf-8?B?M2lDOFI3TVFGVlhWUlBhWEE2NWs0ZDcwMHZTK28vSVdnV1lmL2psWmR2ejYx?=
 =?utf-8?B?RCttQzhYQU5sL1FKTCtpaStjc3BKakwwdU12dlNrR1VZaVVNU0xlRTFxT0du?=
 =?utf-8?B?aGVqLzJDaVlvU2xaNGwwb2FMYjhLY3p5b2hKWDBZV0xhbFJRTmhiUC9uc2Ju?=
 =?utf-8?B?WGZWL0ErM09sYU5ldU5hNVdPY3o2S0paRytmNDRxQzA5aUFxM0V2ME1vcmRC?=
 =?utf-8?B?YmpsNnQrV2Z0a3dtanlzQjBOaVVmNm5QcURPOXN5em9qSytrY0FXL283OTdv?=
 =?utf-8?B?WktnbzlNYko5NllHWTZJdmdjREdPd0l1UlgrSGhIN2FNblk2QngzYk9HYVBz?=
 =?utf-8?B?U2cxTWhndStkVjhPNWU1dExHeHJnaDA2U0ZPNWlORkQ0b0tSSTlMYTBKb1Iy?=
 =?utf-8?B?cFF2QktDcis4YUVvK1FZMkZZaW5rUjNGYzBFRHdNN0dtZXBMeStEQXIvY0t6?=
 =?utf-8?B?SkhHOWcvZEF4RXA1MnNLMkxjaDdYcFN2eFpNSjdTSWZWRGpiQ0JISzhJUkZ6?=
 =?utf-8?B?ODZKb3JzUzRRMGlnT0w3YWkzOVNRZVpwRC9IRDVJWXdha09zYmNteHRDVFRH?=
 =?utf-8?B?V2dNNTh6N0lndGtiWXB2S1JTbFBOd0diZnVUNlVCT2RqdUpxbTRPNmNHN3Y4?=
 =?utf-8?B?MGVadW1aSUJ6d0l6RXNwb3NyanpoeGJKR29KMVRudE9XR2UxYXFCdzlHZDdi?=
 =?utf-8?B?VTlMUzF6TmJNdEJtUDJKV3NUZ3RibHJSb1hkMkFDVVprT3RDYW43a3hubklN?=
 =?utf-8?B?Wnl0ZTBJU2xnaVBISW45a05McENyeGFOc0ljVm5JVEs4TlJKWG5VR3lQdktE?=
 =?utf-8?B?WUNNQWkya3d4WUdVTEtrMUpDTjBseFBERHFUbnZEUW1mekVPZzF3UUUxSEhm?=
 =?utf-8?B?WTNTOEFXMmovRWFxYjVFMnVrcjFBcTRGbnlqdlA2MmhVN3pySnc3bDNheEpi?=
 =?utf-8?B?T3hFZUZrZXN4MmxEQm1PQkdYNmpxSldhbmZTcEljaFVSS0wxVm1FNmFTNE5q?=
 =?utf-8?B?cjBPMHlKRUNBUlFIb0VmWWIxWERaMklWK0t5NjIzL3g3R0JCQkFVVDg4Qmtj?=
 =?utf-8?B?d3ZxdEZXQ2l3SFRBVWxGakZmZWdramREd1R1Q0Rza3NtS3JYOU40Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6d85c7-af31-4281-0748-08df366bb337
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:50.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgaYbSvlRHlmvYE4BQSuoB3uYP4NzEe7pHY7vPyp2xHXR/W9FWeeR4cWpqjY1yZCVwZ2LZ48QsyJWf9OYnrgTQ==
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

In TCON operation mode, sync signals from FrameGen are ignored, but
a much more customized output timing can be generated by the TCON
module.  By using TCON operaton mode, generate KACHUNK signal along
with HSYNC/VSYNC/data enable signals.  The KACHUNK signal is used as
a synchronization signal inside the prefetch engine(DPRC + PRG(s),
attached to FetchUnit(s)).  Carefully switch TCON bypass mode to TCON
operation mode when CRTC is being enabled so that the prefetch engine
may evade the first dumb frame generated by the display controller.
The switching is done with local irq and preempt disabled to ensure
it is done right after FrameGen frame counter moves as instructed by
design team.  Set use_raw_spinlock flag in flag in FrameGen and Tcon
regmap configurations to avoid sleeping on PREEMPT_RT when switching.
Also, replace jiffies with timekeeping API ktime_add_ms(), ktime_get()
and ktime_before() in dc_fg_wait_for_frame_index_moving() to avoid a
potential hard lockup when switching.

Since TCON BYPASS bit is controlled by KMS driver when doing atomic
commits, drop the bit setting when initializing TCON.  This also
avoids accidentally initializing TCON BYPASS bit to 1 when driver
module removing and re-installing where an upcoming patch would
disable a CRTC at boot in TCON operation mode if needed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Set use_raw_spinlock flag in FrameGen and Tcon regmap configurations to
  avoid sleeping on PREEMPT_RT.  (Sashiko AI bot)
- Replace jiffies with timekeeping API ktime_add_ms(), ktime_get() and
  ktime_before() in dc_fg_wait_for_frame_index_moving() to avoid a
  potential hard lockup.  (Sashiko AI bot)
- Use adjusted timings(e.g., m->crtc_hdisplay) in dc_tc_cfg_videomode()
  instead of logical mode timings (e.g., m->hdisplay).  (Sashiko AI bot)
- Update commit message.

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c |  28 +++++++++
 drivers/gpu/drm/imx/dc/dc-de.h   |   2 +
 drivers/gpu/drm/imx/dc/dc-fg.c   |  11 +++-
 drivers/gpu/drm/imx/dc/dc-kms.h  |   2 +
 drivers/gpu/drm/imx/dc/dc-tc.c   | 119 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 5bc952d6883e..d03246036d4a 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -6,8 +6,10 @@
 #include <linux/completion.h>
 #include <linux/container_of.h>
 #include <linux/interrupt.h>
+#include <linux/irqflags.h>
 #include <linux/irqreturn.h>
 #include <linux/pm_runtime.h>
+#include <linux/preempt.h>
 #include <linux/spinlock.h>
 
 #include <drm/drm_atomic.h>
@@ -68,6 +70,14 @@ do {									\
 							__func__);	\
 } while (0)
 
+#define DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(fg)		\
+do {									\
+	if (!dc_fg_wait_for_frame_index_moving(fg))			\
+		dc_crtc_err(crtc,					\
+			"%s: FrameGen frame index isn't moving\n",	\
+							__func__);	\
+} while (0)
+
 static inline struct dc_crtc *to_dc_crtc(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct dc_crtc, base);
@@ -230,6 +240,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
+	unsigned long flags;
 	int idx, ret;
 
 	dc_crtc_dbg(crtc, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
@@ -250,6 +261,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	enable_irq(dc_crtc->irq_ed_safe_shdload);
 
 	dc_fg_cfg_videomode(dc_crtc->fg, adj);
+	dc_tc_cfg_videomode(dc_crtc->tc, adj);
 
 	dc_cf_framedimensions(dc_crtc->cf_cont,
 			      adj->crtc_hdisplay, adj->crtc_vdisplay);
@@ -274,7 +286,22 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
 	dc_ed_pec_sync_trigger(dc_crtc->ed_safe);
 	dc_fg_shdtokgen(dc_crtc->fg);
+
+	/* Don't relinquish CPU until TCON is set to operation mode. */
+	local_irq_save(flags);
+	preempt_disable();
+
 	dc_fg_enable(dc_crtc->fg);
+	/*
+	 * Turn TCON into operation mode as soon as the first dumb
+	 * frame is generated by DC(we don't relinquish CPU to ensure
+	 * this).  This makes DPR/PRG be able to evade the frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_tc_set_operation_mode(dc_crtc->tc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_safe_shdload_done);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
@@ -567,6 +594,7 @@ int dc_crtc_init(struct dc_drm_device *dc_drm, int crtc_index)
 	dc_crtc->ed_cont = pe->ed_cont[crtc_index];
 	dc_crtc->ed_safe = pe->ed_safe[crtc_index];
 	dc_crtc->fg = de->fg;
+	dc_crtc->tc = de->tc;
 
 	dc_crtc->irq_dec_framecomplete = de->irq_framecomplete;
 	dc_crtc->irq_dec_seqcomplete = de->irq_seqcomplete;
diff --git a/drivers/gpu/drm/imx/dc/dc-de.h b/drivers/gpu/drm/imx/dc/dc-de.h
index 211f3fcc1a9a..c39f2ef5eea9 100644
--- a/drivers/gpu/drm/imx/dc/dc-de.h
+++ b/drivers/gpu/drm/imx/dc/dc-de.h
@@ -54,6 +54,8 @@ enum drm_mode_status dc_fg_check_clock(struct dc_fg *fg, int clk_khz);
 void dc_fg_init(struct dc_fg *fg);
 
 /* Timing Controller Unit */
+void dc_tc_set_operation_mode(struct dc_tc *tc);
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m);
 void dc_tc_init(struct dc_tc *tc);
 
 #endif /* __DC_DISPLAY_ENGINE_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-fg.c b/drivers/gpu/drm/imx/dc/dc-fg.c
index 3741dc66c0d9..26b786e146d4 100644
--- a/drivers/gpu/drm/imx/dc/dc-fg.c
+++ b/drivers/gpu/drm/imx/dc/dc-fg.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
-#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -122,6 +122,11 @@ static const struct regmap_config dc_fg_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_fg_regmap_write_table,
 	.rd_table = &dc_fg_regmap_read_table,
 	.max_register = FGCHSTATCLR,
@@ -230,7 +235,7 @@ u32 dc_fg_get_line_index(struct dc_fg *fg)
 
 bool dc_fg_wait_for_frame_index_moving(struct dc_fg *fg)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	ktime_t timeout = ktime_add_ms(ktime_get(), 100);
 	u32 frame_index, last_frame_index;
 
 	frame_index = dc_fg_get_frame_index(fg);
@@ -238,7 +243,7 @@ bool dc_fg_wait_for_frame_index_moving(struct dc_fg *fg)
 		last_frame_index = frame_index;
 		frame_index = dc_fg_get_frame_index(fg);
 	} while (last_frame_index == frame_index &&
-		 time_before(jiffies, timeout));
+		 ktime_before(ktime_get(), timeout));
 
 	return last_frame_index != frame_index;
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index cd7860eff986..a25d47eebd28 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -50,6 +50,8 @@ struct dc_crtc {
 	struct dc_ed *ed_safe;
 	/** @fg: framegen */
 	struct dc_fg *fg;
+	/** @tc: tcon */
+	struct dc_tc *tc;
 	/**
 	 * @irq_dec_framecomplete:
 	 *
diff --git a/drivers/gpu/drm/imx/dc/dc-tc.c b/drivers/gpu/drm/imx/dc/dc-tc.c
index d0d4faba790e..626758904f77 100644
--- a/drivers/gpu/drm/imx/dc/dc-tc.c
+++ b/drivers/gpu/drm/imx/dc/dc-tc.c
@@ -8,11 +8,30 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include <drm/drm_modes.h>
+
 #include "dc-drv.h"
 #include "dc-de.h"
 
 #define TCON_CTRL	0x410
-#define  CTRL_RST_VAL	0x01401408
+#define  SPLITPOSITION_MASK	GENMASK(29, 16)
+#define  SPLITPOSITION(n)	FIELD_PREP(SPLITPOSITION_MASK, (n))
+#define  DUAL_SWAP	BIT(15)
+#define  MINILVDS_OPCODE_MASK	GENMASK(14, 12)
+#define  MODE_4PAIRS	FIELD_PREP(MINILVDS_OPCODE_MASK, 0x1)
+#define  LVDS_CLOCK_INV	BIT(11)
+#define  LVDS_BALANCE	BIT(10)
+#define  LVDSMODE	BIT(9)
+#define  ENLVDS		BIT(8)
+#define  INV_CTRL_MASK	GENMASK(7, 4)
+#define  BYPASS		BIT(3)
+#define  TCON_SYNC	BIT(2)
+#define  CHANNELMODE_MASK	GENMASK(1, 0)
+#define  CTRL_RST_MASK	\
+		(SPLITPOSITION_MASK | DUAL_SWAP | MINILVDS_OPCODE_MASK | \
+		 LVDS_CLOCK_INV | LVDS_BALANCE | LVDSMODE | ENLVDS | \
+		 INV_CTRL_MASK | TCON_SYNC | CHANNELMODE_MASK)
+#define  CTRL_RST_VAL  (SPLITPOSITION(0x140) | MODE_4PAIRS | LVDS_BALANCE)
 
 /* red: MAPBIT 29-20, green: MAPBIT 19-10, blue: MAPBIT 9-0 */
 #define MAPBIT3_0	0x418
@@ -24,6 +43,16 @@
 #define MAPBIT27_24	0x430
 #define MAPBIT31_28	0x434
 
+#define SPGPOSON(n)	(0x460 + (n) * 16)
+#define SPGMASKON(n)	(0x464 + (n) * 16)
+#define SPGPOSOFF(n)	(0x468 + (n) * 16)
+#define SPGMASKOFF(n)	(0x46c + (n) * 16)
+#define  X(n)		FIELD_PREP(GENMASK(30, 16), (n))
+#define  Y(n)		FIELD_PREP(GENMASK(14, 0), (n))
+
+#define SMXSIGS(n)	(0x520 + (n) * 8)
+#define SMXFCTTABLE(n)	(0x524 + (n) * 8)
+
 static const struct dc_subdev_info dc_tc_info[] = {
 	{ .reg_start = 0x5618c800, .id = 0, },
 	{ .reg_start = 0x5618e400, .id = 1, },
@@ -32,6 +61,8 @@ static const struct dc_subdev_info dc_tc_info[] = {
 static const struct regmap_range dc_tc_regmap_ranges[] = {
 	regmap_reg_range(TCON_CTRL, TCON_CTRL),
 	regmap_reg_range(MAPBIT3_0, MAPBIT31_28),
+	regmap_reg_range(SPGPOSON(0), SPGMASKOFF(4)),
+	regmap_reg_range(SMXSIGS(0), SMXFCTTABLE(3)),
 };
 
 static const struct regmap_access_table dc_tc_regmap_access_table = {
@@ -44,9 +75,14 @@ static const struct regmap_config dc_tc_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_tc_regmap_access_table,
 	.rd_table = &dc_tc_regmap_access_table,
-	.max_register = MAPBIT31_28,
+	.max_register = SMXFCTTABLE(3),
 };
 
 /*
@@ -59,10 +95,85 @@ static const u32 dc_tc_mapbit[] = {
 	0x13121110, 0x03020100, 0x07060504, 0x00000908,
 };
 
+void dc_tc_set_operation_mode(struct dc_tc *tc)
+{
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, 0);
+}
+
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m)
+{
+	int hdisplay, hsync_start, hsync_end;
+	int vdisplay, vsync_start, vsync_end;
+	int y;
+
+	hdisplay = m->crtc_hdisplay;
+	vdisplay = m->crtc_vdisplay;
+	hsync_start = m->crtc_hsync_start;
+	vsync_start = m->crtc_vsync_start;
+	hsync_end = m->crtc_hsync_end;
+	vsync_end = m->crtc_vsync_end;
+
+	/*
+	 * Turn TCON into operation mode later after the first dumb frame is
+	 * generated by DC.  This makes DPR/PRG be able to evade the frame.
+	 */
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, BYPASS);
+
+	/* dsp_control[0]: HSYNC */
+	regmap_write(tc->reg, SPGPOSON(0), X(hsync_start));
+	regmap_write(tc->reg, SPGMASKON(0), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(0), X(hsync_end));
+	regmap_write(tc->reg, SPGMASKOFF(0), 0xffff);
+
+	regmap_write(tc->reg, SMXSIGS(0), 0x2);
+	regmap_write(tc->reg, SMXFCTTABLE(0), 0x1);
+
+	/* dsp_control[1]: VSYNC */
+	regmap_write(tc->reg, SPGPOSON(1), X(hsync_start) | Y(vsync_start - 1));
+	regmap_write(tc->reg, SPGMASKON(1), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(1), X(hsync_start) | Y(vsync_end - 1));
+	regmap_write(tc->reg, SPGMASKOFF(1), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(1), 0x3);
+	regmap_write(tc->reg, SMXFCTTABLE(1), 0x1);
+
+	/* dsp_control[2]: data enable */
+	/* horizontal */
+	regmap_write(tc->reg, SPGPOSON(2), 0x0);
+	regmap_write(tc->reg, SPGMASKON(2), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(2), X(hdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(2), 0xffff);
+
+	/* vertical */
+	regmap_write(tc->reg, SPGPOSON(3), 0x0);
+	regmap_write(tc->reg, SPGMASKON(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SPGPOSOFF(3), Y(vdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SMXSIGS(2), 0x2c);
+	regmap_write(tc->reg, SMXFCTTABLE(2), 0x8);
+
+	/* dsp_control[3]: KACHUNK */
+	y = vdisplay + 1;
+
+	regmap_write(tc->reg, SPGPOSON(4), X(0x0) | Y(y));
+	regmap_write(tc->reg, SPGMASKON(4), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(4), X(0x20) | Y(y));
+	regmap_write(tc->reg, SPGMASKOFF(4), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(3), 0x6);
+	regmap_write(tc->reg, SMXFCTTABLE(3), 0x2);
+}
+
 void dc_tc_init(struct dc_tc *tc)
 {
-	/* reset TCON_CTRL to POR default so that TCON works in bypass mode */
-	regmap_write(tc->reg, TCON_CTRL, CTRL_RST_VAL);
+	/* reset TCON_CTRL to POR default except for touching BYPASS bit */
+	regmap_write_bits(tc->reg, TCON_CTRL, CTRL_RST_MASK, CTRL_RST_VAL);
 
 	/* set format */
 	regmap_bulk_write(tc->reg, MAPBIT3_0, dc_tc_mapbit,

-- 
2.43.0

