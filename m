Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6737CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B50110F217;
	Thu, 21 May 2026 06:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="qcmrFSIq";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazon11020139.outbound.protection.outlook.com
 [52.101.152.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369B110E02E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sw57BbmoBZENM/bQQpVG2YizP6b4w0SgNdCpHusF1lRsdnTjEQNfkNMTkbaC1oVV5Qzy8GlMGVFPdGAaUTHMve3i9PZhu5iDlPBUeTpkReYIYngSXFHKH4nZFNNHF7tq8u2XdtS7wy7Ypgp5e+/Rw7+oteTufGMx6BmNP8XhtcIrK26Bmznzt0RG9OOQPmwxQM/1pMu3k9ZgsvKBJJdQiUA7uP4s5pDyIaAmGJawe7TrzvPczZeTBzdvECAsD+eOMKQ9Uf/kTQ4q9Bj4WvG3G4du7xIjda4l9C9bFKk5xy7ZvBDqjCwiewhTvqHQagyP58nvs7wD930+jf1JB1+ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJShREsnfgjsMLkPJaesCObJjfL7HUCq9qTzf5SMOig=;
 b=WYr3IvsXBY3A8kbkeQprRV3bPvkNiycb0o8q+JPb4hXT0u1P5qAxDN3NnpV56BWNs8FwZHAE1cQgqE1R6KSHtBRibMZv8VJvElSdjbWs7jLq8Jh39XrJ7vSEP79w73lP9hWcUVTGN/cg3pyTGbeXWJaSvAzkuMAOVmimlr0CMhWKleWUAviXFqRcttOnzV6uDLcqKVrCXd7xfr4tMq0Gn+5kHNdaLcFKdcacPbNBQ8mR4caVmCMhkwLAIx1bPLu/vDYnoVZcXl05kuEi6+slA8+llocs4ntZxPI6lZyR0dbSNf153ur/c85TeQI1FndMLOcivC3tiU5PPJSQy4/25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJShREsnfgjsMLkPJaesCObJjfL7HUCq9qTzf5SMOig=;
 b=qcmrFSIqHdLvAx18oSuJx/MS+UXXbjgCf2y3MzKXcgJ4VWzl3za/n3KBzkxzqhjEbNpP63PpEo7PureIzX+guGlMgUyKcX4uLUFMomoHzwye3PC/tXIiwz7I6hcoEBmk1xlOK6sbrTCBNoB9Z31inzboTxk7jHD3/SON0MbABAvHA90SE9oQE6PuOPvOoQvJwFKarccKy4nJYBVVic5dhE2zv+BHxhTVwUJtIlRpA/OKJ0m1xV6tf0h8ebsEvHhD7VApzgyLFlKbz35A5R6NALoEByVB4cJ3FzpLmcrRb5KC+7Yk6o3BF1DFiwk0fDhCtU/SxqTvW+NHI2Zm1VA3jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by MEYP282MB1669.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:10:41 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:10:41 +0000
Message-ID: <00a34a82-213b-4b03-801c-3c10b163d643@symple.nz>
Date: Wed, 20 May 2026 21:10:39 +1200
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
Subject: [PATCH v2] drm/bridge: dw-hdmi-qp: compute audio CTS from N when not
 in TMDS table
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0183.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::15) To ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:b2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2196:EE_|MEYP282MB1669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4894bb6a-cb8b-4fb9-32fc-08deb64faa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: A81ZfgJIXUmJ4bBh5w1MFJwILoFjteqp0TnFcoYW4lySSgrBrNLlHdZnvxFD1QwEO+A2LQmvOyn9MfHq8wzTTemoMcekmARzU24iENRpKNmAwXBUo4HPkjUfA0aMZOdSTEVWLSw5RLWj7YsKDUK8jgbWdWKrZUV0Gwr5EElyw6NzetHSaapVjaiH5evizGeVKokSFMzAc/g5UDIYxUlAng7jLRZV+ZYKltPAGiynweTIZfrujLOaI6r5NGAShb27uCpqYA1XCrl3YohUM+s4tjSJ7uIh4UethiQN5N6MEtf+Ce+tTvFmtcTpAB2ORiGMaduVqvu3A8s7XQY3k5xSDDyXqEycsT2ee/LecY3rNFyG2uH9Z6rRdtSV3btxAZ0ivKR3LOse6AfTBCo+mbGE2YcUeXErEfIZ3QaQz57Qb4ZdjElwQftg41wDteCXNV8ph4xAzZx+qEJAX3jcQiSwex8HuGr+xcBGytWkTeOIFPB8etSY++SLij1nrkTvgzwAgzohwfP7mAFin9FcjPY1NYi8jV45CK98gHE7fzekWxV07ig2ISuTce5fYlsF//oDe8FAHhCFOicEndZJ899yumaXhq3d6OhdcNnwxSrK1HHhA+PNTlbVRSpIVAYtnIUXRmsc7nOsgmty9LJoBOBRRkN7Jf3j/EsQrdhnPVGtCN82dfBGob1aj3ARWPAjhrg5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVF6ck9IcG5QUHNlQTRhUXRZajJTZ3VLMjBmNlFxUnhEcXY2UXhubTJWcU5L?=
 =?utf-8?B?Z1VHUmZwY3k0VGVUZEV4L0E1MnhlMUMxSm4zYXRhK2RxSmhBNmdiRmdJZnUw?=
 =?utf-8?B?eDNvZytMWU1pSjJvTmgwRUNYWmhOOGpwR0ZwYm50c3YwZlFGVHprVnBQLytH?=
 =?utf-8?B?V1NMTjBzWVdreUs4VDQxM1FpeEZTeVNQME01WE5ud2cyY2xxY0tmcG9Vd3Uw?=
 =?utf-8?B?aTAvTXlWdTgyWE5jTjhpSTNaVUcvOTZYUTg0aVNPWkJiUW5wMlJJS1dNWGh0?=
 =?utf-8?B?K3Y0NW1qQ1ZlVnFzanlneGw1TldNT3NuUGJCd2t2SnBZeFhhTVJNdEJFVXph?=
 =?utf-8?B?NHJkSW1aNHhPS2VlRW0vZUdHcXpYVjBDbFJsMVFBVEs5ZXNzcHpOY1ZsRHlu?=
 =?utf-8?B?N2wzYStGRjg4UlJVOTZzUDNUN1I3bjJ2cURrVjBvZ1IyOGZoTGhTZG5YQ3Bq?=
 =?utf-8?B?TGgyZlNMT1VnOGxxMjdXVy9TUiszWThlZ05jeFpqWjdETVVIbzc5LzhYd1JM?=
 =?utf-8?B?dHNlNHYxcFE5YUFGT2o5MXhtK1pMYkZoN2k5Q0tETm8rOWxTZzZFR21YMERu?=
 =?utf-8?B?RkRuYndUMENTMXMrMi9JM24xK2ZxbEphL3ZTV3hzVC92clJOYmkxYisxWndX?=
 =?utf-8?B?TlJHSkZGakluMDl1NzloeUlZRVhralhXNG1rZ3ZrUC9pSDB0blRvU0RrRTl3?=
 =?utf-8?B?T3RKNTJpUWJ3MWpyaGtVc3dqME11QlB3QmEvQmlPQXM0RGhpOWhBbHlxdUR6?=
 =?utf-8?B?eDUxSVowamRIc1orNWZ4bXFkcVNLSDJxamZwUGFJdXl0OEduSE9BVktrMEc3?=
 =?utf-8?B?VmtkYUNWcmlQSVJrMWJkRTFJaHM0VnMvWm9BYmNvTTVQV2ZHcEtFWVdrZGJj?=
 =?utf-8?B?dDBwdFZEVkVBNjV6M0ZjdVQzRkJlS2IrbklVcWFWT0VscStNTmxIWXFYZVRo?=
 =?utf-8?B?RTVmZDV3U0loVTdpR3RHZGZmYksxQjF3TXcvZktIZldtcnJiUGFEVzVjRzJW?=
 =?utf-8?B?bFNnK1N5L2JtRmtSSDdNOFd1TENMQlpyL1huTVp1RStsZmZGV2xpQTZTRjQ0?=
 =?utf-8?B?V2V5SGdraFRFZVBXdVd4aXZTdm12VityZTNVYVdieGdQY1FIN2M0RWRnQTBw?=
 =?utf-8?B?dW9ORzZMUHI3N2luRnhXQWJLMmRWR0loRzVuUGRRMm9UV0RHSjV4U2lYdU9p?=
 =?utf-8?B?SWp2aEtwUmxQVWRlN3ZLU1BUQnYwWCtBR0tHL0wxRHloRFlVeWZkN3cxbHVk?=
 =?utf-8?B?VTlrUlJqU25KRnRuQnNiZjhWRzcrSUFBblJuWCs3Rkh5b0NsM0tyQUkzVmhi?=
 =?utf-8?B?MDU0NzFhQ2ZCVWZ6ODhBRGo0UHJnb0RYVWc0VzRmb05Zak1ueVVYK3l6S3Mx?=
 =?utf-8?B?VDN3M1VmTUdwQTlVVGZEOGhPbFdta0NDeFdWanVoQlVWd3FUdEJVVHNIQkdr?=
 =?utf-8?B?R0M3L0JOVnZ5K0wwS2pkUUtrVDN2RGtVMnFGdkpUaDkrUmx6ZmtFa3hkd21T?=
 =?utf-8?B?K3VqTVY4YU1iS2pjcVIvVE5xTXlYVkVnMkJQZGhGM1YrNXRickV6d3hXSVJ6?=
 =?utf-8?B?TDU2Q3dHZjN5eTdvVUJFTXljemlGNm4yd1NaQkR5ZkpMTlk5RTM2cGRTMUxn?=
 =?utf-8?B?UzUwRWpLQXNvY20zZVNvL043eUZTRzhxcHc1WThrbzhBYzltQW5TY3dQK2lr?=
 =?utf-8?B?YVRqOUdaUDJMdDBMdCtpMVArWTgrVkE1VG1tTWxFQmlpK2xxbXlTdWRhQjdu?=
 =?utf-8?B?ci85TmhRU3RMTmVvRXBNTXZxN0dQNzhxMm9hUXlhaHk5VHcrTmsvTFpKMVZB?=
 =?utf-8?B?aldWNThsbzhiN0V5S2xycXlrdUxTd0hCZ29wM0FvVm12V2RpeUtJVG8yWTY5?=
 =?utf-8?B?QXZzNDdIZGZab3FxRFJCOXVYQ3ZReWQ2cytlais3cjEyL25xbSt1b0RMUkxO?=
 =?utf-8?B?MnpSQ1V3K0hQMTJuYW81TEROSjBMME5vcDJwV2xub25qTGF3cHJ2TS85cVdN?=
 =?utf-8?B?R2MzSWFBbWlZbUE5SFlkbDBUaHY5OVhpNklFTDdRZkJSY0s3WjFEUWZIWUFa?=
 =?utf-8?B?NldENGd4Z08xM3NvOCtYbmsvYlBQemYzakNabmR1eExGSnNvOHgweXB1eWxQ?=
 =?utf-8?B?Y2FjUGVnR2h5WWlHajNOT1N1NHo4RnhLc3ZRMXYrMXdUMEoxVEZvRjJndDVL?=
 =?utf-8?B?Ump4anBzWnBkcVhQK3pGb1IrZklnWlRQZ1VCaEw1Q2c1Uy9kNkZTaUw2azUv?=
 =?utf-8?B?dlVwUVZrMUE1c0ZlNG1Ma2NsVkpIR1JadVYrT29HdFJlN2ovc2NpeWV1ajZl?=
 =?utf-8?Q?cgngZzoxki5oFKuODs?=
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 4894bb6a-cb8b-4fb9-32fc-08deb64faa7c
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:10:41.5678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gTs1VuyLjGhWt4TpRKUKNDNZY8JFj5EZCtfQRGeNqdgX0y0fK/Rbqw0SDPS63xH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1669
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

dw_hdmi_qp_find_cts() returns 0 for any TMDS character rate not
present in common_tmds_cts_table[], which terminates at 148.5 MHz.
In that case dw_hdmi_qp_set_sample_rate() calls dw_hdmi_qp_set_cts_n()
with cts == 0, which leaves AUDPKT_ACR_CTS_OVR_EN clear and falls
back to the controller's internal CTS auto-measurement.

On at least the RK3576 hdptx integration, the auto-measure path
produces incorrect ACR timing on the wire at TMDS rates above the
table's coverage.  Strict HDMI sinks that cross-check the ACR CTS
against the AVI/GCP and the actual TMDS clock then mute audio.

The issue is reproducible at any rate not present in the table, and
is not specific to HDMI 2.x: 1920x1080@60 with 10-bit deep colour
(185.625 MHz, HDMI 1.4) is affected, as is 3840x2160@60 8-bit
(594 MHz, HDMI 2.0).

The driver already has the symmetric machinery for the N-table-miss
case: dw_hdmi_qp_compute_n() falls back to a dynamic search via
dw_hdmi_qp_audio_math_diff() ((pixel_clk * n) / (128 * freq)) when
no table entry matches.  The CTS path lacks the equivalent fallback.

Compute CTS inline in dw_hdmi_qp_set_sample_rate() from N per the
HDMI spec (CTS = TMDS * N / (128 * Fs)) when find_cts() returns 0.
The standard override path then supplies the correct value on the
wire instead of falling through to auto-measure.

The legacy DesignWare HDMI driver (drivers/gpu/drm/bridge/synopsys/
dw-hdmi.c, hdmi_set_clk_regenerator()) computes CTS from N via the
same formula when AHB or GP audio is active, so the pattern is
already established within the family.

Tested on R76S (RK3576) on Armbian-edge mainline 7.0.1 with Cristian
Ciocaltea's hdptx-clk-fixes v1 series applied, against four sinks
at four TMDS rates spanning HDMI 1.4 and HDMI 2.0:

  TMDS         Mode                In table?  G3     C4     TCL    Kogan
  148.5 MHz    1080p60  8-bit      yes        audio  audio  audio  audio
  185.625 MHz  1080p60 10-bit      no         audio  audio  audio  audio
  297 MHz      3840p30  8-bit      no         audio  audio  audio  audio
  594 MHz      3840p60  8-bit      no         audio  N/A    audio  audio

Without this fix, all four sinks mute audio at the rates marked "no"
above.  With the fix, audio plays cleanly.  The 148.5 MHz row is a
regression check confirming the in-table path is unchanged.

The LG C4 OLED's CTA-861 SVDs do not advertise 3840x2160@60 over
TMDS (it is signalled FRL-only in this model's EDID), so that
specific case is untestable on the C4 over the TMDS path.  The
same audio-path code is exercised on the C4 at 297 MHz and behaves
identically to the G3.

More-permissive sinks (older HDMI 2.0 TVs tested informally) play
audio at all rates with or without the fix because they do not
strictly cross-check ACR CTS against the TMDS clock.

Reported-by: Simon Wright <simon@symple.nz>
Closes: https://lore.kernel.org/linux-rockchip/ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM/
Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Simon Wright <simon@symple.nz>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Simon Wright <simon@symple.nz>
---
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
  - No code or test-result changes.

v1: https://lore.kernel.org/linux-rockchip/92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz/

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 0dbb1274360..b7203787057 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -461,6 +461,23 @@ static void dw_hdmi_qp_set_sample_rate(struct dw_hdmi_qp *hdmi, unsigned long lo
 	n = dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
 	cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
 
+	/*
+	 * When no CTS table entry exists for the given TMDS rate, compute
+	 * CTS from N rather than letting the hardware auto-measure.  The
+	 * auto-CTS circuit produces incorrect audio timing at out-of-table
+	 * rates (e.g. 185.625 MHz, 297 MHz, 594 MHz), causing strict HDMI
+	 * sinks to mute audio.  Computed CTS = (TMDS * N) / (128 * Fs) per
+	 * HDMI spec; the standard override path then supplies it on the
+	 * wire.  Mirrors hdmi_set_clk_regenerator() in the legacy dw-hdmi
+	 * driver.
+	 */
+	if (!cts && n) {
+		u64 computed = (u64)tmds_char_rate * n;
+
+		do_div(computed, 128ULL * sample_rate);
+		cts = (unsigned int)computed;
+	}
+
 	dw_hdmi_qp_set_cts_n(hdmi, cts, n);
 }
 

base-commit: c1079aebb4de218caa86c44f9a53700d1a582683
-- 
2.53.0
