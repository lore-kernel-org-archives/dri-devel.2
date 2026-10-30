Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5C606A335
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PS6uPkzE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E221126D2;
	Fri, 30 Oct 2026 09:54:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011055.outbound.protection.outlook.com
 [40.107.130.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468981126E6
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM0BFD9+cHoBppwvefKUQRWuq6d7arLm0oC7r2m42O6KiG0gVghT2ZJzGQLJusdVPHN9I6IGQtWFuzKCEu7URqLBsQNC+tY4tPWB8gaLNPl/af/6pQbMKDDhqNPIa+LIAnCA5pzCkR+cFDdpaSAUP+hGzR73Fs61aTtJLYB6StOijQbR2mJeHw0kCLe/x8Jn4UuFOtzBeUq38UDIb3Nm9ty4wZmCZOYNLHl6Bk4tZX21kOGuXg9bcNcBLQ9UgtiRCr6/BOuL+hjz6cWOHHwY6R1+tlai7tV2ImSeTtUC4C5mJWLLezsEKveRLsMdVp3aCn+Gw2c9O/X0udpL7is3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk4Y5aIaRbgneWgAohtpHdWRc4rDNjOCsdfhN/15SHk=;
 b=bxuB/EueLFPhDKsEy16+wGUI2kdOJghVlXjZF9SndIKXtv+cqW5wuHzbB5edoZyph8DhfXVyfjsIT+ShvSfQ2jU7PnYOkXQmpjMiWWUmUiR1gOWbIYgJmyDKdjD2IAF5fJ1JyYF8i8sdNa/hzJtFNqIKkwvO2wPrwtKTm7edH2tutkF2pxy24zzUQ8oMsbf+p/ltH2MRkJhYoUWKk1cihLGlXP+OIcuqLCUbgwNJIepnmiSSz+4BgXd/Xq5v+NeCsutFc7fS9EtdQ+QC3cpMaRKk1v3pIjD/QreFV3KyrFU7yO1Lht+utHLfeFJ2KimxrLwwTFLnfnVevEBuueDiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk4Y5aIaRbgneWgAohtpHdWRc4rDNjOCsdfhN/15SHk=;
 b=PS6uPkzEkj1aDXVa/bDrnPyyqtTxk58DlJIvnStTllVllBN1ERy0FVPQtSr42iqlO6pLuuwXx2zUjAoZedbLb8Q9WukmAcu9zwlq6JoOo7fy4/ZXERXwvmlxN6uJ9ihRVbxT+WbHS0NjZ4F7lD9Pi6D4pjzYco3Rmqo/WY5B3Rpo/QOXRnCSKhQbE5ZuMLSb6nfPAE9RPQT6HMu2NfcoYAUC2HJD44zqcJEvbaeZ5f9ollsqCcrRigWwKlGautjOXa71wlV0G6kqh31nYmFGCH77SvZNNXducZipCQbQi3VOKTI9DvloDEgr5XLUUMeL7DVNONy9omQSyNq3EqRAIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:54:31 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:54:31 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:39 +0800
Subject: [PATCH v8 15/15] drm/imx: dc: Use prefetch engine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-15-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: TY4P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::18) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3fc6c9-230b-4740-75f7-08df366bcb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|921020|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: WyWYTbbY/Y2WFfHvxJC/pvvPxL5RpwDWOBHjEAILA5/xkIf7tjDBuxmKcFIzPVIwt1rJyio1mclmqWWZ9Rb436zWnOVp8QU357CVY7OqmCD2ZhS6ZuvFc2C7CyODmkhXpaLRJLRUk5EcObcZ2puFIvn+/CocqsVhOMJo6/r5eHa2o4IdmzSCJABXebMVaYo0Rmu/pQC8zGjXapn6rqg1b2jnv9+/sNWHKTm94SkUdcZ8v0D4LT3y7vzFaRnnQKHvh1l2wPXlY2HKfHNyt/l+S2OpB+Tv8AfSFXypc6kW+lq4ppVnc5Q+c+HKmJvAOzQDUNVLf8yjPh0qTdmbz9MUTms+Oj1H09Dv+sOq8XPXyp3bmCwTQTQx2Vuwnpn6scQnLNbP1+dvv/MXdzCtsueFxXfQztwLyZmtMPSB/x8b2DCpyBvZDlsb6McOs18oJ3Y1oriIQX0cE34k+HmXXOFSF41bQInqxiPY3RWoTfo5aQgz8rLq/vJozrlgNAPZ59Y8kzFqgVIdadpS04pc7sHpTe/Fjp2hNky8qqqp+C6JuvaVD1T3oaJah/At0oBpdGKJTkl3VnxKza1CexK4wv08lA3uZlzY3nW9JYtIX93+EhMLy6h0KGOYFAVgsRxk8rxQP2gIDi/tlRfjXZmdNGtFwX5UdmZgZRAEC23xC9Qj5fdENh90oa2i2MMG3d1GTNKosKe6eTQw1eWdTs3gAbK/3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpjTmYxMEtKQTR6cjRGY21RRVRtRzduT0VSaG5XejUzNU9qMmFLOUxvTWZO?=
 =?utf-8?B?aFhIbFFYa2w4TlpvRHMwQ2habCsrVWw3cW4vemVEcGhkUFd2dk1iZ2t0V25H?=
 =?utf-8?B?dTB3NEQrNVRhVEtZdTM4NTA3NkxpakhjTXJCc3JZTm5zbVNnak03NjIwNEtO?=
 =?utf-8?B?Mlc3ZzZLRkN3U2NiVGV0VnM2cUNGNXY2azBYT0hxR2xtd1labkxOMW9MaGlj?=
 =?utf-8?B?d21IZ08zTW9XRHNKcmVoN3J6cWdhbXdDSUxWT2dzWVZmbGl1OTcxMEIyYU5m?=
 =?utf-8?B?ZVNiNEc4U2JKL2ZsekhOaVlVeG5acGY3NENZSWszUlQ4MUlyK0E2NXFSY2hs?=
 =?utf-8?B?Z0JZaXZJemZ2WG5KVndTQW1MNU9TK3RnV3VNTWI3bzBTMURwdmNDL3RiZ0dB?=
 =?utf-8?B?RXR3cjdjWm8vNXp5Nnh0NFl1MEZZWTRtVXF4VGxWam0yM0tCaStzc2t3QU5M?=
 =?utf-8?B?b2FKNENLTlphWFZUeWVERExDZzMyZStyRHBrQVpTU1Z5WGZEUUswTFY0blc4?=
 =?utf-8?B?dU80azNDQXRwMzNsNzJYRUU1TGhaT1QxZlpxMC92Snd6eWxFUS83dHBmVDBK?=
 =?utf-8?B?dStaN01tM2pJeW9sM0p0Lyt3MURIblVyKzNpWjk1ZmM0RXE3RmR2L0F4WE95?=
 =?utf-8?B?YWdXcXV2a3FhV1hlMWJzU1Q1T05VZnFjb1hwMFpucS9teXZOSWpKTWMvTzhM?=
 =?utf-8?B?aWlXUy8xclZvWFRSb0VrL0dqc3BLU2xCVzBaWnBaaUVYRjduWDFzNjBGTk9Z?=
 =?utf-8?B?eExHWW1DM0xveTdNREIxMkhUZzQzanJKWlc4ZEdZc2ZuNHJWaGdEdUpsanJk?=
 =?utf-8?B?UzlNNEJ1aFFJMnhGZDErWFNOSzM2ek13Tm5jakFlUW9RUy9XUmJpeVEzZTZu?=
 =?utf-8?B?cUFISmx0YUQ5Yk02cnRIZlBjaFMveG40ZFpPNXRoek1rc0Yxd1dSdE0wMnIx?=
 =?utf-8?B?MGxUVW1LcjBxTVVJU0lLSnNDM1NzajNnd0NsSUdBR1EreW1aejVwazJQSWZS?=
 =?utf-8?B?WEtSaXhFNDM1Z2h5WW5GUnBOR2FpSkR2aG5PSlhIUDFxNFR1TVFYaUx4QUZZ?=
 =?utf-8?B?aEhVNzVRN1daOVdMZFJMaTdsTFM1cEluVTdFc05mdUZ4ZUlSaVUxMlltYkJH?=
 =?utf-8?B?cUczbjRsQTJGQ1RwK0ZXL215eWVXYnhqNUM1bU1PdDkvbTV2N0JVaFM1M3FD?=
 =?utf-8?B?VEdpYWFEa2wrOWRCSWh6OEVpVHBvZHRkZXFhZkk1NFNwcDNkc3FNYVhBbmll?=
 =?utf-8?B?R3VCRXdBMnAyVEFnRHpWWEltcUM5TnlOU2VvYkVnK0NLVkZaZUd2QjhLYUQv?=
 =?utf-8?B?NzRHVVk3ZFBEYjZpajZOTlZ3Vk5WTTdzMWtiYkptU0JSazNZS3BSOXBUK0Rn?=
 =?utf-8?B?UjNGcVd5c2JLM0pKWkZUTitBTDMyeG9XSEpqQ3N5WXdCSEpVeFhIZzN0ampE?=
 =?utf-8?B?UGZPRTM0VkRlRGt0dUFwdVd3TWpNWlJvM0NwRnlqWmpIVTgxMmRBNUhVUGxG?=
 =?utf-8?B?RDBpN1pYeUhrZ0ZCS1lGdEVxL3M1K1VWeHZqd2pqN052REdLY3NKQk11TUNo?=
 =?utf-8?B?SDg4WEZOdmV4eXBNdkYyTWpiSkFKdSsxbEJIb1NBZkZvYmpGWGJYbVBXaGlK?=
 =?utf-8?B?Sk5PR3IzS3Y2eXVPTTBFakNPZVhNNVd0R1ZZbkVidVI5QXdKdTRxenZvQVdN?=
 =?utf-8?B?T0JrVVkwZUJLK1BDMkpObUp1bWlaN2lFcFQxVWVqcmU1NWlDcE51UGVZR3JY?=
 =?utf-8?B?ekQ2clgveHlOaEhYa2p0d0VXaytiRjZlNzUxdHR2OFZnRzc4VENtWmQrV3lG?=
 =?utf-8?B?cktQTHc1VFBDUEtIZlpjNzlRd29BdWN2Z29wN3hHeDR3a2lvSS9oS1JEcUx1?=
 =?utf-8?B?dndteFBVcGVGd1U1SlY2Ylp3UUV0NVMwMjYxNG1CWGFpTHNzOG5yM004Nkdj?=
 =?utf-8?B?N3lKRXVlUTFJOEd5THJaSSs3YWYwRGxSbXFSV3FJdmY1Yzk4Q2I2OHR1SWgz?=
 =?utf-8?B?ZW5RVXd3d3RJYkVNRmZPNG9SemZTSW9uSEg4Q1d2NGxiUGFNZGRFcHBSWFkw?=
 =?utf-8?B?dE9NZHRJUEtNQmFCK25oS01KZTVpM2I2WmwwUmIxZnpEOFRVWFZaSmt6M1RQ?=
 =?utf-8?B?WFBoZVZMV1h2QWlxOGlJdmprWCs3YnhISWt0aDNyYnZ5QVpuTUY5RWpHcUhl?=
 =?utf-8?B?MFBCc1NLVGdrT3JwRWh1Sk95Snh5eWhGdTRoRGJvZVQyV3VjRXJ6a01Rc3Ny?=
 =?utf-8?B?NTE4aENFck9UYmVkNzJRN0w3QUwvend5ZHhFTmMyc2gzbG9lWkNETFRWNSta?=
 =?utf-8?B?VHA2dkJzV0JLaEFZUTIxMEJuWFhlTG1IeFovajcyZ3BLRWN5eVh5UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3fc6c9-230b-4740-75f7-08df366bcb52
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:54:31.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24IVlx58VFlvJGkvMmHy2NKo02P2Oo1DqSdoYgkKHPIYdEyo92ijkQEoDGNlHP10Ypkqlmscgku02Z2DDXLFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
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

One prefetch engine consists of one DPR channel and one or two PRGs.
Each PRG handles one planar in a pixel format.  Every FetchUnit used
by KMS may attach to a PRG and hence use a prefetch engine.  So, to
simplify driver code, always use prefetch engines for FetchUnits in
KMS driver and avoid supporting bypassing them.  Aside from configuring
and disabling a prefetch engine along with a FetchUnit for atomic
commits, adapt burst size/stride fixup requirements from PRG in
FetchUnit driver and set use_raw_spinlock flag in ExtDst PIXENGCFG
regmap configuration to avoid sleeping on PREEMPT_RT because
dc_ed_pec_sync_trigger() can be called with local irq and preempt
disabled.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Inspect lb_sec read by dc_lb_pec_dynamic_sec_sel_get() in
  dc_crtc_disable_at_boot().  (Sashiko AI bot)
- Inspect ed_src read by dc_ed_pec_src_sel_get() in
  dc_crtc_disable_at_boot() and check it against LINK_ID_NONE.
  (Sashiko AI bot)
- Avoid disabling DPRC in dc_crtc_disable_at_boot() if CRTC was enabled
  by bootloader.  (Sashiko AI bot)
- Enable/disable DPRC properly for cases where plane transitions to
  visible/invisible status.  (Sashiko AI bot)

v7:
- Check {old,new}_plane_state against NULL in dc_crtc_atomic_flush().
  (Sashiko AI bot)
- Return 128B burst size from dc_fu_burst_size_fixup() when baddr == 0.
  This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
- Set use_raw_spinlock flag in ExtDst PIXENGCFG regmap configuration to
  avoid sleeping on PREEMPT_RT because dc_ed_pec_sync_trigger() is can be
  called with local irq and preempt disabled.
- Modify debug message in dc_crtc_disable_at_boot().
- Adapt dc_drv_crtc_was_enabled() in dc_crtc_disable_at_boot().
- Rename __dc_crtc_disable_fg_along_with_dprc_repeat_en() to
  dc_crtc_disable_fg_along_with_dprc_repeat_en().
- Update commit message.

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c  | 164 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/imx/dc/dc-ed.c    |   5 ++
 drivers/gpu/drm/imx/dc/dc-fu.c    |  30 ++++++-
 drivers/gpu/drm/imx/dc/dc-fu.h    |   2 +-
 drivers/gpu/drm/imx/dc/dc-kms.h   |   5 ++
 drivers/gpu/drm/imx/dc/dc-plane.c |  48 +++++++++--
 6 files changed, 231 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index d03246036d4a..9d8fbcef79fe 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-kms.h"
 #include "dc-pe.h"
@@ -204,7 +205,14 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 				drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
+	struct drm_plane_state *new_plane_state =
+			drm_atomic_get_new_plane_state(state, crtc->primary);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	bool plane_becoming_invisible = false;
+	bool disabling_visible_plane = false;
 	int idx;
 
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
@@ -216,13 +224,48 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	enable_irq(dc_crtc->irq_ed_cont_shdload);
 
-	/* flush plane update out to display */
-	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	if (old_plane_state && new_plane_state) {
+		disabling_visible_plane = old_plane_state->visible &&
+					  drm_atomic_plane_disabling(old_plane_state,
+								     new_plane_state);
+
+		plane_becoming_invisible = old_plane_state->fb &&
+					   new_plane_state->fb &&
+					   old_plane_state->visible &&
+					   !new_plane_state->visible;
+	}
+
+	if (disabling_visible_plane || plane_becoming_invisible) {
+		unsigned long flags;
+
+		dc_crtc_dbg(crtc, "disabling FetchUnit along with DPRC\n");
+
+		/*
+		 * Don't relinquish CPU until DPRC REPEAT_EN is disabled and
+		 * sync is triggered.
+		 */
+		local_irq_save(flags);
+		preempt_disable();
+
+		DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+
+		local_irq_restore(flags);
+		preempt_enable();
+	} else {
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	}
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
 
 	disable_irq(dc_crtc->irq_ed_cont_shdload);
 
+	if (disabling_visible_plane || plane_becoming_invisible)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
 	drm_dev_exit(idx);
@@ -323,14 +366,33 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
+static inline void
+dc_crtc_disable_fg_along_with_dprc_repeat_en(struct drm_crtc *crtc)
 {
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	unsigned long flags;
 
-	enable_irq(dc_crtc->irq_dec_seqcomplete);
+	/* Don't relinquish CPU until DPRC REPEAT_EN is disabled. */
+	local_irq_save(flags);
+	preempt_disable();
+
+	/*
+	 * Sync to FrameGen frame index moving so that
+	 * FrameGen can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
 	dc_fg_disable(dc_crtc->fg);
-	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
-	disable_irq(dc_crtc->irq_dec_seqcomplete);
+	/*
+	 * There is one frame leftover after FrameGen disablement.
+	 * Sync to FrameGen frame index moving so that DPRC REPEAT_EN
+	 * can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 }
 
 static void
@@ -338,14 +400,31 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_crtc_state *old_crtc_state =
+				drm_atomic_get_old_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	int idx;
 
 	if (!drm_dev_enter(crtc->dev, &idx))
 		goto out;
 
-	__dc_crtc_disable_fg(crtc);
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask && old_plane_state->visible)
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	else
+		dc_fg_disable(dc_crtc->fg);
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -371,7 +450,11 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 {
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	enum dc_link_id ed_src, lb_sec;
+	bool disable_dprc = false;
+	bool crtc_is_enabled;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
@@ -381,16 +464,71 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		goto out1;
 	}
 
+	crtc_is_enabled = dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc));
+
+	ret = pm_runtime_resume_and_get(dc_drm->pe->dev);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
+			    ret);
+		goto out2;
+	}
+
 	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
 		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
-		goto out2;
+		goto out3;
 	}
 
-	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
-	__dc_crtc_disable_fg(crtc);
+	ret = dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
+	if (ret || ed_src == LINK_ID_NONE) {
+		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
+		if (ret == 0)
+			ret = -EINVAL;
+		goto out3;
+	}
+
+	if (ed_src == LINK_ID_CONSTFRAME0 || ed_src == LINK_ID_CONSTFRAME1)
+		goto disable;
+
+	ret = dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
+	if (ret || lb_sec == LINK_ID_NONE) {
+		dc_crtc_err(crtc,
+			    "failed to get primary plane LayerBlend secondary source\n");
+		if (ret == 0)
+			ret = -EINVAL;
+		goto out3;
+	}
+
+	/*
+	 * If CRTC was enabled by bootloader instead of this driver, we don't
+	 * know if DPRC was enabled or not.  In this case, enforcing DPRC
+	 * disablement potentially causes imbalanced clock enable count for
+	 * DPRC and PRG clocks.  So, we presume bootloader doesn't bother to
+	 * use prefetch engines.
+	 */
+	if (crtc_is_enabled)
+		disable_dprc = true;
+
+disable:
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
 
-	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
-		goto out2;
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling FrameGen along with DPRC REPEAT_EN at boot\n");
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	} else {
+		dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+		dc_fg_disable(dc_crtc->fg);
+	}
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (!crtc_is_enabled)
+		goto out3;
+
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling DPRC at boot\n");
+		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
+	}
 
 	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
 
@@ -400,6 +538,8 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 
 	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
 
+out3:
+	pm_runtime_put(dc_drm->pe->dev);
 out2:
 	pm_runtime_put(dc_crtc->de->dev);
 out1:
diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index 1370b968168b..271d0745b21f 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -77,6 +77,11 @@ static const struct regmap_config dc_ed_pec_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_ed_pec_regmap_write_table,
 	.rd_table = &dc_ed_pec_regmap_read_table,
 	.volatile_table = &dc_ed_pec_regmap_volatile_table,
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index d9933218069c..fd98d02e4d6b 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -125,13 +125,31 @@ static inline void dc_fu_set_numbuffers(struct dc_fu *fu, unsigned int num)
 			  SETNUMBUFFERS_MASK, SETNUMBUFFERS(num));
 }
 
-static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+static unsigned int dc_fu_burst_size_fixup(dma_addr_t baddr)
 {
-	unsigned int burst_size, burst_length;
+	unsigned int burst_size;
+
+	if (baddr == 0)
+		return 128U;
 
 	burst_size = 1 << __ffs(baddr);
 	burst_size = round_up(burst_size, 8);
 	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_fu_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+{
+	unsigned int burst_size, burst_length;
+
+	burst_size = dc_fu_burst_size_fixup(baddr);
 	burst_length = burst_size / 8;
 
 	regmap_write_bits(fu->reg_cfg, BURSTBUFFERMANAGEMENT,
@@ -151,8 +169,14 @@ void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp)
 }
 
 static void dc_fu_set_src_stride(struct dc_fu *fu, enum dc_fu_frac frac,
-				 unsigned int stride)
+				 unsigned int width, int bpp, dma_addr_t baddr)
 {
+	unsigned int burst_size = dc_fu_burst_size_fixup(baddr);
+	unsigned int stride;
+
+	stride = width * (bpp / 8);
+	stride = dc_fu_stride_fixup(stride, burst_size);
+
 	regmap_write_bits(fu->reg_cfg, fu->reg_sourcebufferattributes[frac],
 			  STRIDE_MASK, STRIDE(stride));
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index 9fbd7aadd264..0527a7b2221d 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -87,7 +87,7 @@ struct dc_fu_ops {
 	void (*set_baseaddress)(struct dc_fu *fu, enum dc_fu_frac frac,
 				dma_addr_t baddr);
 	void (*set_src_stride)(struct dc_fu *fu, enum dc_fu_frac frac,
-			       unsigned int stride);
+			       unsigned int width, int bpp, dma_addr_t baddr);
 	void (*set_src_buf_dimensions)(struct dc_fu *fu, enum dc_fu_frac frac,
 				       int w, int h);
 	void (*set_fmt)(struct dc_fu *fu, enum dc_fu_frac frac,
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index a25d47eebd28..8b45b21a6f8a 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -130,4 +130,9 @@ struct dc_plane {
 	struct dc_ed *ed;
 };
 
+static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct dc_plane, base);
+}
+
 #endif /* __DC_KMS_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 42c0a46281cb..2b58c4e2b7e4 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -17,6 +17,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-fu.h"
 #include "dc-kms.h"
@@ -44,11 +45,6 @@ static const struct drm_plane_funcs dc_plane_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
-static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct dc_plane, base);
-}
-
 static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 {
 	int src_h = drm_rect_height(&state->src) >> 16;
@@ -88,6 +84,28 @@ static int dc_plane_check_fb(struct drm_plane_state *state)
 	return 0;
 }
 
+static int dc_plane_check_dprc(struct drm_plane_state *state)
+{
+	struct dc_plane *dplane = to_dc_plane(state->plane);
+	struct drm_framebuffer *fb = state->fb;
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	struct dc_dprc *dprc = dplane->fu->dprc;
+	u32 src_w = drm_rect_width(&state->src) >> 16;
+
+	if (!dc_dprc_rtram_width_supported(dprc, src_w)) {
+		dc_plane_dbg(state->plane, "bad RTRAM width for DPRC\n");
+		return -EINVAL;
+	}
+
+	if (!dc_dprc_stride_supported(dprc, fb->pitches[0], src_w, fb->format,
+				      baseaddr)) {
+		dc_plane_dbg(state->plane, "fb bad pitches[0] for DPRC\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
@@ -123,7 +141,11 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return dc_plane_check_fb(plane_state);
+	ret = dc_plane_check_fb(plane_state);
+	if (ret)
+		return ret;
+
+	return dc_plane_check_dprc(plane_state);
 }
 
 /* A prerequisite is that drm_dev_enter() has been called beforehand. */
@@ -158,12 +180,18 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state =
 				drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_state =
+				drm_atomic_get_old_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	bool needs_modeset = drm_atomic_crtc_needs_modeset(new_crtc_state);
 	struct dc_plane *dplane = to_dc_plane(plane);
 	struct drm_framebuffer *fb = new_state->fb;
 	const struct dc_fu_ops *fu_ops;
 	struct dc_lb *lb = dplane->lb;
 	struct dc_fu *fu = dplane->fu;
 	dma_addr_t baseaddr;
+	bool prefetch_start;
 	int src_w, src_h;
 	int idx;
 
@@ -184,7 +212,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	fu_ops->set_layerblend(fu, lb);
 	fu_ops->set_burstlength(fu, baseaddr);
-	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, fb->pitches[0]);
+	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, src_w,
+			       fb->format->cpp[0] * 8, baseaddr);
 	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
 	fu_ops->set_fmt(fu, DC_FETCHUNIT_FRAC0, fb->format);
 	fu_ops->set_framedimensions(fu, src_w, src_h);
@@ -193,6 +222,11 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
 
+	prefetch_start = needs_modeset || !old_state->fb ||
+			 (!old_state->visible && new_state->visible);
+	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
+			  fb->pitches[0], fb->format, baseaddr, prefetch_start);
+
 	dc_lb_pec_dynamic_prim_sel(lb, dc_cf_get_link_id(dplane->cf));
 	dc_lb_pec_dynamic_sec_sel(lb, fu_ops->get_link_id(fu));
 	dc_lb_mode(lb, LB_BLEND);

-- 
2.43.0

