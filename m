Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1317CD37B7
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944B410E61F;
	Sun, 10 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="GglqbBxu";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazon11020133.outbound.protection.outlook.com
 [52.101.150.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D4810E257
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 07:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfvyuWx0NMh5psqFI+Jdwa8GIWTlsvSJv/TTk0s2oV16ZbtMmDciRtJYfDkWRgR7u3tQOIVGCY/ROzuYQBtHbuIhTuo1I6jZWZbToU3qryDA5F2GGR76nH6fr26kthMWqcupo1BUFBKS8/nYhDdveO9T5KITsXB+2RWLvBUaLpBHJpewdyeayVHI/rVIJtsuiDyjkdkbl9cxT/d2zRAP4+9i9QlPWkTNO7tOZ2g3r02M5szVRmsUL968Cr1A+5/CpasUuXxc6tKzWJyesQ+vg83tm6mUV81gfIfMyG7aU0gZg8ldF80qqEWFdQ4WC+GiDicuzDxItP/9JXl8tyeA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeBwZIp2TJpJLp1u4Q+NDWpvgQMAE2S0ckWkEmiDTro=;
 b=NS/vxnd5M10Bwr0cIVccOgPpSlE+4JYDeIttJlY/ujcA1m2tdwWuL9JXIQEn9ocN1rX79jpadojlyNpcZvXqZ3K0VZ238xKG9TnWtu9hg7qPxsCFf2u2qyCCvLiDNQo+gPfe1AxCga2Qf0LqDt4AoUXwKFGdmS8l1BkxT22rkEqaImD488q3k6V6KHfIFlwZPCP/yvvrGzJOjiUpe2E20OgDUno9P4YICWOU2gjaZzLmtRYl6AlRIEpR3QsLL9m0DDgmbAKSfKAPh/jljctyj+fCGqRPTCxNDoA2mVbdybPpmVMzKXks9ZVSI3CUtlUpYRz8eq96yGQD27PHbKi0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeBwZIp2TJpJLp1u4Q+NDWpvgQMAE2S0ckWkEmiDTro=;
 b=GglqbBxuEinuCPDbBpnGjJfRkVirst9USHly1rD7/vX5V8/1iad3mbISGRl/qVXW9u21bXf4g3enbwRDLAtZDuMqHcYEmaIVMrBsnCRyCEU9u5ypjs58vrTgaoT6lfu0ZvuoL2ZF6fz6715SlJ78Rzu/f9pPGLrFBFv6wMFy88njQRr6ErM0EAaI1cxI/PcGgmGxw4i4Z/IyZU4T/rvSmbfDqZD5nPVjZc4LSdIn6q3vwTNXrZtd0aghMluJXCnoZG43lHa/SjZBoNzDKFrBtnhJjhb03iuwvGGil21j0GXontBQ3Mh1oT0bS5huVbZ80jARFRJvtu4QdKl3SmAffg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by SY4P282MB1257.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 07:09:09 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.20.9891.020; Sat, 9 May 2026
 07:09:08 +0000
Message-ID: <92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz>
Date: Sat, 9 May 2026 19:09:07 +1200
User-Agent: Mozilla Thunderbird
Content-Language: en-NZ
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Simon Wright <simon@symple.nz>
Subject: [PATCH] drm/bridge: dw-hdmi-qp: compute audio CTS from N when not in
 TMDS table
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AK2P299CA0009.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:18::22) To ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:b2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2196:EE_|SY4P282MB1257:EE_
X-MS-Office365-Filtering-Correlation-Id: a281fac9-75ea-4200-cd57-08dead99dd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2i1hLH3NbJjDauo7S/fxQa6hNEkoQeRiFUSLcMjVxQv4NKN9RHunkEbbYLQa2zO1jHfXnrrrMSNKC83su8uQqSHs9G0data21f+OfLhXr/Gj0LovGl9mxIm5PqfmXvbzZjYf0NvGHzDvWMNqWbOt4T22SAKx4Im0oeuxjvu+bcbMEoFhbjyijkh4hNJZx17NMZOC/KPKK4cf2UqoxPvWQhRIamLnUTdEMf0rXpNuecOOLUu/1yqslc/MEy1o64lzuE3k0Qu//AxLyiL3HED3ztSXNDPs2t2H8FmWK9J4DGDC4jBu/E3Hjk1x29VPAdq3div226kNvQFA0v0HT2gdIqc4iyNYtVcw3KrmWXCAu8e52BHR4Hhq55ZtAUf3pTesa/40ZihGyzMAZOR0wdyA7EVObLCxaNi/2szblyPiX0kx+SeFIqjLMJ94za/OJBUkCFdoEHV4dsLvuBeutBw4JrKUWKMII3YAai14/3j7YxityTEGFaVcMSDu2KUXSQpw/IT3ZG8b0RXlI2usYxF7V8gHiQshmIZkAn0NpfXLcMib9jq05QSborGx0l8PvQVS49t3t0FQsmvnmVpZIQkiTHvwqGUlUKwwDTVQ9vK36QtAD1BwNClRduLbjQ2lF+2bp1IzHT2CrGmbtOenfA0q4VlSEwrRDmgs/ne1XnjMpZx05rurjr4nCykto+w/D19u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(3023799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9FU3ZqL1d6VWRFVStmU1hyQmNyOVdiTkY2ZUN4aS9lMUVQZm45akFSYlRy?=
 =?utf-8?B?UEZNNnR3QlR0N0V1bXBWbmtmYVZ4NWN0QlFhaEJZaGdML1lKSEhIaURISjhY?=
 =?utf-8?B?V0JqRGtycVhsT05HSnpaSmxnWWkvZnhhWVBRYzUvbm1HL0FVd1VpOHRDRnpP?=
 =?utf-8?B?cGNWbmw3VERUbkp2a2dBZXd6MDc2bHkwekQxRDdYT3J2dDVlN1NnOVVYekQ5?=
 =?utf-8?B?V3BCNy9XemJBSmdDL0dyaUJBUkxUanpsNG9KYjV2d3FmdnZwd0pnV3VkSzZZ?=
 =?utf-8?B?UnRFWnJzMWsxbU5xM2VyNDhkZGQrdk5sVjBDb2pKOEw1M01YZ3gxbCtTeXY1?=
 =?utf-8?B?SXVHVjM0SFF0OG9jU0twS2RRRUdnYWVSZzhIMEdkbk9GYSsyb1o1K1lMMTkw?=
 =?utf-8?B?ckVRaHBVYzZoSkJCbDJQQ2gzREF3aExqQ1NUN3ZNbEEwRlJzdkVhZ0h4UlF4?=
 =?utf-8?B?VWxJRDkxcXJ2Z2pqYUFHYzhicHdzeG5oKzR1T2xKbGJ2ano0SnBZaUdUNzZ5?=
 =?utf-8?B?TGtLWGhTU3ZBTmpIZmNVR3owaHNmVHR0VjQvQ1FiSkc3THVOUGduT0lYQk16?=
 =?utf-8?B?Mnc2ZGVzMitnYkFVeklkNStCMTlBRldlaXZjU1NMNUdZWnhJMCtsblYycEs2?=
 =?utf-8?B?TG5VZ0hvanRSbExQemdGWFBGbmg5MVNGSUJ5anVYMVNBRWFVeXFxblRhYldq?=
 =?utf-8?B?dVphWGtRS3ZnZUw5OSt0N2FJMEMzRmtZN21DNGdsTlpTdmx6N0V5V1IxNFVO?=
 =?utf-8?B?QlVaMlJ2S3VMQThIZzBTNWRJejkrQWY3OXQ4T29US21HTTVoTVRzaTdjS28x?=
 =?utf-8?B?MmZSd1B6OCtsdkhET3puTWxJeWlaTFE2SWRBd055ZlUwWkJPdVpQMkhKWG9n?=
 =?utf-8?B?T1lBRnBkLzFpZGszTlh6OFpzQlRwU3JxOW9iSTJpTzZkeERnRGRsbFBINmVG?=
 =?utf-8?B?ZjJIeGVOOGRsRWQ3b25BNTJ6djZia0hPOGRZQkZ4N3FTdUJmd0dXdFBJMlpY?=
 =?utf-8?B?UEdPRjZxdlc5amJ4bHJnVC9iUTBOTy93S0IwUG9Xem9XbkhiaWlUeGdMaHcw?=
 =?utf-8?B?MnJiNU14a0toUHFYbTI4aG1GazMwZXZxbDJ2SUE5aFF6eXBmR0ZXcERWSS9J?=
 =?utf-8?B?cFFOKzY1bkNKMG5LSTBZbFU4d3JYbmE4cVBwMlE0ZnJkTHRVSyt6am02aVdJ?=
 =?utf-8?B?d0puUFE4QU5jeUs2U2t4aDdjWXFUUkpqakUrMHRPeE1zOFBWbjVmei82bmFQ?=
 =?utf-8?B?WG16NG00TE9DbytVSzhSakEwSXBrMjNpSzJmK01ZUWxPT3lxNnNRelN6Wk9L?=
 =?utf-8?B?QVM5ZnlnRDJIaHYvdEN1ek1rOW5yOUJmMm5CRmkrN1Vjb29Wbm4xc3ZybzFs?=
 =?utf-8?B?eVdRTmgveFhuVFl1c3JaemplbFJtZ2lLdm9YRVJYVStGdE82ZW16eTFVY1pv?=
 =?utf-8?B?cS82MGtxcmtCdHFEWTlzZ2VUZWJiWDAxVlFOT1FxNEpXZE5KQVczbTBaNVZt?=
 =?utf-8?B?dCtFeEVTQmZEemhoM0x5cVJqQXpnbS81WFA2L1AzN2RGK1hxZTFMTTVwby9C?=
 =?utf-8?B?aWRIbG5ob1UwWWh3M21wcWo4bk5WMHhaaittcTA0SVM2ZGxQVWtpa0FaNVZY?=
 =?utf-8?B?RGFxSC9kSjNabVZkWWFhSmRVZU52Sm9DOS9ZZjUrMnZZM0NIQ2ZDMG9hYzBR?=
 =?utf-8?B?ejVJOWlyVkdHcWFoaUEveHlSOWdTWTZhM2NvQzlMRnQ0UHZOT0I4VzF4UWhJ?=
 =?utf-8?B?Tm9DWUpnanhFTWZVRldIMWNwa3BqS0dMdWljZ3VZQ0NKaFM4aWFsZFBRV0xC?=
 =?utf-8?B?K0JscVBNbjRmcVFQMDhoQVRBNGJ3T0Nhb09UdjY1UWg2YVVEL2xQWU9mOUtx?=
 =?utf-8?B?TWhMcldXNTBQYWdjMC9lT1g1WUNvd2FZWnVDVk9IQ0F1eU42eU5RLzFjNmJk?=
 =?utf-8?B?VkNHZGRMUThmbUlpV2lGOEY3MEVsdWFXMFZwRFhuSHlhZmNieW4vRStocitE?=
 =?utf-8?B?MkFBcWRWdGYzS3JmeFhDamM0QjhBNzY3bUhOcDRhSnJobWhXckpCQXA1RDNh?=
 =?utf-8?B?aGlWQytWV0xZQTRUVzh2NDJWanEzYjZCWU13ZXNCMk5Vb1lEQlFSc1FySzJm?=
 =?utf-8?B?NXo5eHY2SzVNTFpLdjIvdUdiV2dXUmZXQUZMd1h1KzJTdFRsWUNCTXphTStZ?=
 =?utf-8?B?Y1VWcEFjTkpBYkFhdlAwY24xRUZTZWJqdW1rb2ltRGNIc3l2WXVNZ08zYWRK?=
 =?utf-8?B?QnFESzE3d0lFLzJsWUxNZzhjMHZRb3o1ZUtWTndqb0J6QmIxR1liOTI5QVhJ?=
 =?utf-8?Q?lutPKpGdxq/ES0WcN0?=
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: a281fac9-75ea-4200-cd57-08dead99dd27
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 07:09:08.8164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c3MCE72HX64evSCn3pUZy5Og3Jpubeb6yeE8ONoEeokcaUEMVuZ+dzMGmpWFeWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1257
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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
present in common_tmds_cts_table[] (which terminates at 148.5 MHz).
In that case dw_hdmi_qp_set_sample_rate() calls dw_hdmi_qp_set_cts_n()
with cts == 0, which leaves AUDPKT_ACR_CTS_OVR_EN clear and falls
back to the controller's internal CTS auto-measurement.
On at least the RK3576 hdptx integration, strict HDMI sinks mute
audio in this configuration.  The behaviour reproduces at any rate
not present in the table -- it is not specific to HDMI 2.x:
1920x1080@60 with 10-bit deep colour (185.625 MHz, HDMI 1.4) is
affected, as is 3840x2160@60 8-bit (594 MHz, HDMI 2.0).  Supplying
explicit CTS via the standard set_cts_n() override path resolves
the mute.
The driver already has the symmetric machinery for the N-table-miss
case: dw_hdmi_qp_compute_n() falls back to a dynamic search using
dw_hdmi_qp_audio_math_diff() ((pixel_clk * n) / (128 * freq)) when
no table entry matches.  The CTS path lacks the equivalent fallback.
Compute CTS inline in dw_hdmi_qp_set_sample_rate() from N per the
HDMI spec (CTS = TMDS * N / (128 * Fs)) when find_cts() returns 0.
The same formula appears in the legacy DesignWare HDMI driver
(drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, hdmi_set_clk_regenerator())
under its AHB / GP audio paths.
Tested on R76S (RK3576) on Armbian-edge mainline 7.0.1 with Cristian
Ciocaltea's hdptx-clk-fixes v1 series applied:
   TMDS         Mode             In table?  Audio with fix
   148.5 MHz    1080p60  8-bit   yes        plays (regression check)
   185.625 MHz  1080p60 10-bit   no         plays
   297 MHz      3840p30  8-bit   no         plays
   594 MHz      3840p60  8-bit   no         plays
Sinks tested: LG G3 OLED, LG C4 OLED, TCL 75P7K QLED, Kogan
KALED43XU9210STA (Changhong-OEM 4K LED).  Without the fix, the LG
G3 mutes audio -- this is the originally reported bug
(linux-rockchip 070633).  The LG C4 was verified during this cycle
to mute at 185.625 MHz (1080p60 10-bit) with the unpatched module.
The Kogan TV plays audio with or without the fix; it is a
permissive HDMI 2.0 implementation that does not strictly cross-
check ACR timing.  The TCL 75P7K was tested with the fix loaded
only.
Audio plays at every supported sample rate (32 / 44.1 / 48 / 96 /
192 kHz) verified on the TCL at the 185.625 MHz out-of-table TMDS
rate -- the fallback's CTS = (TMDS * N) / (128 * Fs) computation is
independent of sample rate, as expected.
The LG C4's CTA-861 SVDs do not advertise 3840x2160@60 over TMDS
(it is signalled FRL-only on that model), so that one row is N/A
on the C4.  The same audio-path code is exercised at 297 MHz on
that sink and behaves identically to the G3.
Reported-by: Simon Wright <simon@symple.nz>
Closes: 
https://lists.infradead.org/pipermail/linux-rockchip/2026-May/070633.html
Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Simon Wright <simon@symple.nz>
Signed-off-by: Simon Wright <simon@symple.nz>
---
  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++++++++
  1 file changed, 15 insertions(+)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c 
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 0dbb1274360..25ac8d3cfc8 100644
---a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@-461,6 +461,21 @@static void dw_hdmi_qp_set_sample_rate(struct 
dw_hdmi_qp *hdmi, unsigned long lo
   n = dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
   cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
+ /*
+  * dw_hdmi_qp_find_cts() returns 0 for any TMDS rate not in
+  * common_tmds_cts_table[].  Falling through to the controller's
+  * auto-measure path mutes audio on strict HDMI sinks at out-of-
+  * table rates (e.g. 185.625 MHz, 297 MHz, 594 MHz).  Compute CTS
+  * from N per HDMI spec instead, so the standard override path
+  * supplies it on the wire.
+  */
+ if (!cts && n) {
+   u64 computed = (u64)tmds_char_rate * n;
+
+   do_div(computed, 128ULL * sample_rate);
+   cts = (unsigned int)computed;
+ }
+
   dw_hdmi_qp_set_cts_n(hdmi, cts, n);
  }
-- 
2.53.0.windows.3

