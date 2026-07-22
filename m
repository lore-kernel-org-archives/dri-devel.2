Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C7DC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC3510EE71;
	Wed, 22 Jul 2026 17:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="23bZviOO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E4B10EE6F;
 Wed, 22 Jul 2026 17:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f65/wK10hhEQaEahd9L/d6Ogw+s8gAl10O1djhDz3c6e5veCutnN+lJJbUqPd2FtPUC7jvty2gK0dZjUbLyGCZw6LkPEkmq4L7UUPE2ntKJFVj7lTFNGw5OayvFDexD7yWEJ9PY1XA8mS6q4kC1PmocD8bk2A/DuROolraXzqfWrMMsO73mz+g6vYBhN3jkaOYzCvws2RrbiYCTfKfSirAbZvRbEy+ACWC2f/iWqYfpAF5mx+m/oohTsa6jzsHrjJf6B/ktKaqVV0sp+vxFOAa7HjNcHNT5HSPBf+3srMSC/78bZNiD2pybhf99lUHQqHopIPz+/oM/pLFI8NlgkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FIlLGAbyVGY74fQ0fVYuTQfhy7cMso4a+nNK5dvdiY=;
 b=jL632ndhFT502EfZ+KZ+9IscadY4Y4eEH3cyXLKD8zYA1INezgVg28YZoLOJq7/T6FZW39QDrhevVNcE50folzoc3KVsGKP2+ld5utEXg+Hq8QhxJeXKHMLXMSwGfW+Sg0P1IKrBt3Yzv6a0tcrMCRSgJRAEYPYeSEWqE5oBX7FoOKpiLrdg+OG3mus4ahH1FPlAe6su0glnQcdHEGD3fAWLt8VdYOcZvSJrNg8UY+Hjx89LhRr47++kEIIUsdDoseUCrgmZwtg+Cpl0m3TL1oJuFfxBdPQqc5u7BvBmCOLqIy5BogERq1pJvZoUjqn5ZPavNV1PR41nHZzK14HFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FIlLGAbyVGY74fQ0fVYuTQfhy7cMso4a+nNK5dvdiY=;
 b=23bZviOOuBrStuE/78FPr2hUJmODnUDBQss3Wg1XwmdLBmC1SskprIZyd0MTGvsJTCh4SoQ+x7hkm7jL47dm6zCWHBAJSe8O0x5wCBG2eVsjPbAB0NJQs5P4MFh/2tl5suZqY+x04O4OG570kK7gHup2LbAqci4Rydo8PKl68Fc=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:51:23 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:51:20 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: use proper context for logging
Thread-Topic: [PATCH] drm/amd/display: use proper context for logging
Thread-Index: AQHdGaPZZbpH5J/YLU2sFStfCjiUp7Z50Aqh
Date: Wed, 22 Jul 2026 17:51:20 +0000
Message-ID: <PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20260722063210.1144266-1-jirislaby@kernel.org>
In-Reply-To: <20260722063210.1144266-1-jirislaby@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T17:51:20.591Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|CH0PR12MB8531:EE_
x-ms-office365-filtering-correlation-id: c1367bfb-22e8-4dfc-1933-08dee819d694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|38070700021|11063799006|10067099003|13003099007|22082099003|18002099003|8096899003|3023799007;
x-microsoft-antispam-message-info: sYceIFf8NCF6jmVy2J3p7m29T1ysKSeSCgm516j0le4C40F4E6bnKwYkydGHXZLe8BFpx+2habS4skn0T9K7lFpAdgaMi/8oO2Isd1kGf3I2in338wnIL8NopW6RSLfT9oEKXU4tC45H96bHqI0yjJ/+8zSxhzd/JPnmJQ40RR3W34UNzzFqW0BDPRNLiVYDHQC5WhNIpewzAGFLNyUuEubYZuSfEZiXf7+GYw97dX674nYPNQrCh2G7VfUGsc/GS6GfnRdZfHwdK1UTafbJ972H+QkjSz68ijlYpTpF04jBKkadBTvW0u5hgAjPOYX99YGy99lYtZSMq5FdujGG3MGr3somaV6o91niDdJflrtwsnDtDwJZpTf6XvoyP4VnbM+N1qvDMn8/VsPnD40kbqeN3KcGirN6q37RE4tap75e2LS0Z5nhNQ2aayEsa2X0nnNSU8pTAGZx8/YjvbCAw3P8GiG495w6+9NgAe2uRgYAT23yNnXO53sY/ngdvFeFi6rQbsSiekJOrnsNz2FOirBkOadHUJRpJ5bwunn2YU5V9N+nwjPahOktgZHsAvMsRd7IwPUBSVsTb1sMnQfpKqZ9dutfWIMJvgvlgib7OzJkwXM1tE7ifZPL8KGAB9aSyWmyIXT/DDGWjthobQ4vwBmAc2UwT+uQv7dsweaYnb9wSfnOacmmQL3zPiBYiN9j3xSBY9T8KXuBN2MeAG0s2eD0YzQkLI6bi/z9qaWkkq8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(38070700021)(11063799006)(10067099003)(13003099007)(22082099003)(18002099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1pnNAiU3Zi9piQ0nidBNpsxu8EizV5H4TAc6jZtiZOf/7LF7/rpMaa2bj4?=
 =?iso-8859-1?Q?ab3f1wbvLPMC7VR6EKQJHyVMroSMyGs8RwQMjhMk6thnhBn2pGJRgziPBe?=
 =?iso-8859-1?Q?M+dx33mliMnfkiCwvAd0osXsfSCvrFKlIEqCp9RlWbyPmljRyQxaRyEl3j?=
 =?iso-8859-1?Q?C4hZinYr0Thd3KeoDjys97gwA4rS7EqaiOPdCwg3sSkKOdJpwZ+xTQaflT?=
 =?iso-8859-1?Q?KLE5EKEi7aVNrq/DgpiDdplbF0Ip5VtLwlMXtSJ7rpRLpuwsvyiVXTvkJZ?=
 =?iso-8859-1?Q?vk/o3+EJ5DQ82VpFtGMFu+obJFLTaNT7xYz+Xd1S+3PMExFNxWtsFLDQEb?=
 =?iso-8859-1?Q?fKc3zzoRQTRe+p14ygt+olWUhRFtvfqb8XbHRWBMO1wVmK+mCIyj/99rDd?=
 =?iso-8859-1?Q?+ZNMg6l5/yUSFcmGlNP9j5QwMx/7rAJMSwefvHVLYlRbeKNbm71sZK8g8g?=
 =?iso-8859-1?Q?1nSeN1Qx91epXQldNFsjIpxXldZnBC2LA2nyO5Mkh4lWao1HYyTFtvP6H3?=
 =?iso-8859-1?Q?IitvG9GUwl6ALm8068Laz0CYLbmCY/5+SG9AbW0Nq+vXiFwzbKtllyJ/A3?=
 =?iso-8859-1?Q?YDlh0+EOPQbBgAAwCXX3oLmjZEFen0E82cJ/rkBJiIYUPyaXTySlni84+I?=
 =?iso-8859-1?Q?tou1OxTZj+bw3kWihyGaF26KtDV+hGjgiCzxGaMc/nF9yDCo7TpfWd4p9s?=
 =?iso-8859-1?Q?KST1oX5PBzn8FPYMuK1CTdrCZCb5H+lSiOA2tnW5Genb0fiZpYBw65VoU4?=
 =?iso-8859-1?Q?O+32EPeNuOSY4FLugRHrgXKM6w5dQlbESnxSqjPj4xnac9ZwyOD5Dhk1J5?=
 =?iso-8859-1?Q?4nKL1V6W/hYQRDwLlDm6u1vutUv9WZrzMap/SJrqhkHKSB2HeZEuQU1H3E?=
 =?iso-8859-1?Q?4VY9J3kkgCvI6XtVsiot+0DYK/HiL/IiQC8Lzm2v6H/IyqZXbB/IEduCvD?=
 =?iso-8859-1?Q?hLcaqg5OCdv/i5zqzEvpBBG31h58vojfl+rE8hjqRuTLKx9tGshEDTfWUw?=
 =?iso-8859-1?Q?3+0R6UiVyC1SVq14hlSgAG2h0UZqCNDIuF3ASBIKSdP98RruJB6KaXOY6m?=
 =?iso-8859-1?Q?moXMXa1gaER2+Tts7xjSwacXOwjAhHsRa0lZBWe5vybcRRlCZr3IO6Ez3/?=
 =?iso-8859-1?Q?UAPYdl/SEqDT9iPQ9cZwN30M60r9nh5YZ4x3+ISm9/sW6lkRw13dxFn50P?=
 =?iso-8859-1?Q?RUPKK2I+PGakEQKdLWeUeaJiCpZmU3Jxb5Ekt1bvyKHQuNJKWoXcb757ES?=
 =?iso-8859-1?Q?vFCvmLmenq3MG5J1BoAYLVKTiH4cnQiqhNUXEFMpLIiBIXcCfL9PRca21J?=
 =?iso-8859-1?Q?qlZ+go7Xk8y6fcz/LwGtB/wF0rQWp7Fc1OgKLbdgLfbpiERkS2SIB7It18?=
 =?iso-8859-1?Q?YvLxaX1gCU7gw/VxgiCdOdkoDVduXZrvv6DxUawavTb6NDMV91ZzBvHVjy?=
 =?iso-8859-1?Q?DRremprDWZ3d3JcAImwycGoB4k5DxHz/kqo+8llclht2cs1JAgEAWQ26n0?=
 =?iso-8859-1?Q?kvBUV6axuPCLNXIBziLjAemW9YhPVLhZqBFFl02ssck8bEa/83AmCZamts?=
 =?iso-8859-1?Q?QASY5uIhooV17mkCYDKuvZDzPVKzNJhzOOiV9PlxaENXMkHj4zJn+vg96I?=
 =?iso-8859-1?Q?+sdAU6B5DLdQfWUCSJxKNNOzr+2uuiACxaqhtKV5C2vhfrbyB7iECj8Tws?=
 =?iso-8859-1?Q?M7+0DBPx0XIR3rcd/HpZWkKU/NYU1efgOyYMbmw0oihLLgG9yrRJfSvXb9?=
 =?iso-8859-1?Q?at9FKUNk0/PKRpIsbOyZjRUO4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12PH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1367bfb-22e8-4dfc-1933-08dee819d694
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:51:20.4058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQI1ya8OgFvXcyW+3eokhV8JqJLipK7tIQ60H6ZJqLG1HeGQx3gUQ1YfpTw0FlOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
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

--_000_PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12PH8PR12MB7279namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Why not just do

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -45,7 +45,7 @@
        clk_src->base.ctx

 #define DC_LOGGER \
-       calc_pll_cs->ctx->logger
+       clk_src->base.ctx->logger or CTX->logger


clk_src is available everywhere right after dce110_clk_src_construct()


Bhawan

________________________________
From: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Sent: July 22, 2026 2:32 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jiri Slaby=
 (SUSE) <jirislaby@kernel.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.=
Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <si=
mona@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: use proper context for logging

The same as the rest of the code, get_ss_info_from_atombios() uses
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
initialized only later in calc_pll_max_vco_construct(). Therefore, any
output using DC_LOG_SYNC() leads to a NULL pointer deference in
get_ss_info_from_atombios().

To avoid accessing the NULL context, use clk_src->base.ctx->logger
in get_ss_info_from_atombios(). That context is initialized earlier in
dce110_clk_src_construct() -- before get_ss_info_from_atombios() is
actually called. This is done by temporarily redefining DC_LOGGER to
CTX->logger.

Before:
dce110_clk_src_construct() did:
 -> sets clk_src->base.ctx =3D ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
 -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx

After:
dce110_clk_src_construct() does:
 -> sets clk_src->base.ctx =3D ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx

Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271175
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@ke=
rnel.org/
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian K=F6nig" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
---
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ecb8493ec523..d3f7aa853e3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_sr=
c_funcs =3D {
         .get_dp_dto_frequency_100hz =3D get_dp_dto_frequency_100hz
 };

+/* calc_pll_cs->ctx is set only after get_ss_info_from_atombios(), unlike =
clk_src->base */
+#pragma push_macro("DC_LOGGER")
+#undef DC_LOGGER
+#define DC_LOGGER CTX->logger

 static void get_ss_info_from_atombios(
                 struct dce110_clk_src *clk_src,
@@ -1526,7 +1530,7 @@ static void get_ss_info_from_atombios(
         struct spread_spectrum_info *ss_info_cur;
         struct spread_spectrum_data *ss_data_cur;
         uint32_t i;
-       DC_LOGGER_INIT();
+
         if (ss_entries_num =3D=3D NULL) {
                 DC_LOG_SYNC(
                         "Invalid entry !!!\n");
@@ -1631,6 +1635,8 @@ static void get_ss_info_from_atombios(
         kfree(ss_info);
 }

+#pragma pop_macro("DC_LOGGER")
+
 static void ss_info_from_atombios_create(
         struct dce110_clk_src *clk_src)
 {
--
2.55.0


--_000_PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12PH8PR12MB7279namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Why not just do&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
@@ -45,7 +45,7 @@</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; clk_src-&gt;base.ctx</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;#define DC_LOGGER \</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; calc_pll_cs-&gt;ctx-&gt;logger</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; clk_src-&gt;base.ctx-&gt;logger or CTX-&gt;logger</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
clk_src is available everywhere right after dce110_clk_src_construct()</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Bhawan</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiri Slaby (SUSE) &lt=
;jirislaby@kernel.org&gt;<br>
<b>Sent:</b> July 22, 2026 2:32 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.org&gt=
;; Jiri Slaby (SUSE) &lt;jirislaby@kernel.org&gt;; Lakha, Bhawanpreet &lt;B=
hawanpreet.Lakha@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt=
;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Rodrigo Siqueira
 &lt;siqueira@igalia.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; David Airlie &lt;airlied@gmail.com&gt;; Simona Vetter &lt;simona@ffw=
ll.ch&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; dri-devel@lists.freedesktop.org &lt;dri-devel@lists.freedesktop.org&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amd/display: use proper context for logging</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The same as the rest of the code, get_ss_info_from=
_atombios() uses<br>
calc_pll_cs-&gt;ctx-&gt;logger for logging. But calc_pll_cs-&gt;ctx is<br>
initialized only later in calc_pll_max_vco_construct(). Therefore, any<br>
output using DC_LOG_SYNC() leads to a NULL pointer deference in<br>
get_ss_info_from_atombios().<br>
<br>
To avoid accessing the NULL context, use clk_src-&gt;base.ctx-&gt;logger<br=
>
in get_ss_info_from_atombios(). That context is initialized earlier in<br>
dce110_clk_src_construct() -- before get_ss_info_from_atombios() is<br>
actually called. This is done by temporarily redefining DC_LOGGER to<br>
CTX-&gt;logger.<br>
<br>
Before:<br>
dce110_clk_src_construct() did:<br>
&nbsp;-&gt; sets clk_src-&gt;base.ctx =3D ctx;<br>
&nbsp;-&gt; ss_info_from_atombios_create()<br>
&nbsp;&nbsp; -&gt; get_ss_info_from_atombios()&nbsp;&nbsp; &lt;- uses calc_=
pll_cs-&gt;ctx&nbsp; # BOOM<br>
&nbsp;-&gt; calc_pll_max_vco_construct()&nbsp;&nbsp;&nbsp; &lt;- sets calc_=
pll_cs-&gt;ctx<br>
<br>
After:<br>
dce110_clk_src_construct() does:<br>
&nbsp;-&gt; sets clk_src-&gt;base.ctx =3D ctx;<br>
&nbsp;-&gt; ss_info_from_atombios_create()<br>
&nbsp;&nbsp; -&gt; get_ss_info_from_atombios()&nbsp;&nbsp; &lt;- uses clk_s=
rc-&gt;base.ctx<br>
<br>
Closes: <a href=3D"https://bugzilla.suse.com/show_bug.cgi?id=3D1271175">htt=
ps://bugzilla.suse.com/show_bug.cgi?id=3D1271175</a><br>
Closes: <a href=3D"https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528=
ae3c63a3@kernel.org/">
https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org=
/</a><br>
Fixes: 1296423bf23c (&quot;drm/amd/display: define DC_LOGGER for logger&quo=
t;)<br>
Signed-off-by: Jiri Slaby (SUSE) &lt;jirislaby@kernel.org&gt;<br>
Cc: Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
Cc: Rodrigo Siqueira &lt;siqueira@igalia.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: &quot;Christian K=F6nig&quot; &lt;christian.koenig@amd.com&gt;<br>
Cc: David Airlie &lt;airlied@gmail.com&gt;<br>
Cc: Simona Vetter &lt;simona@ffwll.ch&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
---<br>
Cc: dri-devel@lists.freedesktop.org<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 8 +++++++-<br=
>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
index ecb8493ec523..d3f7aa853e3a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
@@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_sr=
c_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dp_dto_frequency_100h=
z =3D get_dp_dto_frequency_100hz<br>
&nbsp;};<br>
&nbsp;<br>
+/* calc_pll_cs-&gt;ctx is set only after get_ss_info_from_atombios(), unli=
ke clk_src-&gt;base */<br>
+#pragma push_macro(&quot;DC_LOGGER&quot;)<br>
+#undef DC_LOGGER<br>
+#define DC_LOGGER CTX-&gt;logger<br>
&nbsp;<br>
&nbsp;static void get_ss_info_from_atombios(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dce110_clk_src *clk_src,<br>
@@ -1526,7 +1530,7 @@ static void get_ss_info_from_atombios(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct spread_spectrum_inf=
o *ss_info_cur;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct spread_spectrum_dat=
a *ss_data_cur;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LOGGER_INIT();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ss_entries_num =3D=3D =
NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DC_LOG_SYNC(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Invalid entry !!!\n&quot;);<br>
@@ -1631,6 +1635,8 @@ static void get_ss_info_from_atombios(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ss_info);<br>
&nbsp;}<br>
&nbsp;<br>
+#pragma pop_macro(&quot;DC_LOGGER&quot;)<br>
+<br>
&nbsp;static void ss_info_from_atombios_create(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce110_clk_src *clk=
_src)<br>
&nbsp;{<br>
-- <br>
2.55.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH8PR12MB7279DCFA0D11A95FDCA0D773F9C12PH8PR12MB7279namp_--
