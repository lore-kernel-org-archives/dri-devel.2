Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C385ECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E86A10FF0F;
	Fri,  9 Oct 2026 07:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="C0hVOASt";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com
 [52.103.73.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C218510FDA6;
 Thu,  8 Oct 2026 22:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMburVVsMucrI0DocAQPm5sUc7utCX4nED8dRFRWfYf9vQNS9PdZIYHgCXG9Isl/ux4xwXoTSKN5RUcZTr44DYZs5ERRmkIcbS7FtOhkt0FZcDbKk7tDQLbaipZCCpCBQ1GWj9QPN5i6w3nSmko3zF3R2hesRx87DfCt20xHmC8f5n6onBIL/Uvh+1bHJkd1KNuSddr/A1t96LXyPqEmWpy1pWBqiY3+7wbbj3TBl3oO/VM7l7fW7cZCN5/ESlADUw9IOT/xzcDJ6gvubFftUDvGYf3pGZRmE07rR+AOWg6VLNrm0wyOErNI3kIRkipG38sJuJY2YFIamAZSZZHqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSPa7iWTh14TTvHRBd5tphGlfdAGtZIPw0a/YY8Y8Eg=;
 b=FaSqVvepRKb5bT2hln8VBX4SeL8LxRu64kXAwbftyj597uP0HGKY1kVGHyTwZbEldMKQp1xH1z05I9bg0oy9eQbrsMkzHrgRKwBXjtWW0OsWLiK2BY/ekAqy+HD5j0dq4my8JIcfTx086KDIa9QxUv9SvzDf+Uwq0xn+j22c7p8Q5I8r1Nuqqx/doX2FaregC/Rw2BGFkLYatiC2ksj+22WHWw2kbt64V/gGeEi1Xx/42LP8+Acxkbxh27xoLn0Z8WZBI5mo1V92wA1pDDrj8Pj4l84aesfCsgjtVGjc2o+9Gxaoh/U8oRxr+MypGngGKdnwVzLIOTN5unKS4TSxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSPa7iWTh14TTvHRBd5tphGlfdAGtZIPw0a/YY8Y8Eg=;
 b=C0hVOAStbruTMSc47GKmO+3e/RvSuANmKWbgdIf8SJEM73Pv6Tj1fc4kBGjuCNojZgTpqfdmLfTqS8xc4nsOvKc1LQ936CxDtui49d8PMHJmttjeTMD+IfHw+iKdmLuoGboBAA765BB8E/r6KdmyWYs/NJaqHJwYVpLUHbZpFD6wLMavvwk4nGcc2T+J52+5nI9iY/sKCamyg1SSDBAbIM9RIw8Wn2NNTmafm52DeHzbvTAl8sLUNCfpg3LDBcaZcvF9QadrtTBZITa1ADFn79CfLPLNtuBcpdjOvy6/nlqYduTcn1J3sYqwtFrye33qkHNDsu33xBMu/m2nOOeA/g==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:50 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:50 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>
CC: Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] drm/msm: correct DSC RGB and command-mode vblank
 handling
Thread-Topic: [RFC PATCH 0/3] drm/msm: correct DSC RGB and command-mode vblank
 handling
Thread-Index: AQHdV3U6XlRrfQVtoE2pt31EYdhCww==
Date: Thu, 8 Oct 2026 22:34:49 +0000
Message-ID: <SY5PR01MB1060041363FC41A7F40DF59DBA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: 6e5200ad-54c3-4332-d126-08df258c5d5e
x-microsoft-antispam: BCL:0;
 ARA:14566002|39105399006|8062599012|19110799012|4140399003|31061999003|8060799015|25010399006|22141099003|25031999004|12121999013|15080799012|38102599003|24021099003|16051099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003;
x-microsoft-antispam-message-info: =?us-ascii?Q?SXFcgE/WVrIOFyEfKQh2eDh0SBu5/fxxPW8xHgzbL6ww8SOGMDFGaYaUMWFb?=
 =?us-ascii?Q?TjpLsXEjBvCcyrXkIHbLmuwR+CEwoKdFZkQhxEPhCtTB3/OiJe3IGQpGuI4T?=
 =?us-ascii?Q?n7d511Hoh0c1EBOK2qavWzY5kVhtFeWFU4nEQ/jrcVzTQL3hHNj2N4ha64FJ?=
 =?us-ascii?Q?J6oqL0O7dZ86WNSsA8LGwjHoksM9q/WaFr9vO+FqrsuNre6BlGmQW/O7IXLe?=
 =?us-ascii?Q?rCWwVWxRQ2PJtFOg/ryGma8io0vWse5LAz0wJbKyznPuePk+2uC2W31FR0xg?=
 =?us-ascii?Q?i839A4fu8tdXLQRH4ef0MxoxenwbN1ASlkcWAoZ9vIo/Movh+XHXhAFGZW0x?=
 =?us-ascii?Q?AuB+DNn7jo+RLBBC/jj+oH3fcFwA3xyx9tqrWLxmWfiUJAM+7p6Me2MP/DFi?=
 =?us-ascii?Q?9okD1z/SlzUJ2pcc3V3eb5CvyRvl1AdWsGFIVRG63MDzQh1c9vgcabTjr0Rd?=
 =?us-ascii?Q?paeIVVZd4ARUerblJJfWC6RHnOuetBTtAy0bYk0JC8W5vfLiGziQSWiQWXkV?=
 =?us-ascii?Q?yLeshUYl3QDbyYsOgrpFSWOLTnmW1j1HuuikD7QZfxtGTWqBHkilo6nltEBx?=
 =?us-ascii?Q?AGIQ79jxCEv9QQN9HCvwk2SJ0aPZS1r+1g3G430tsaTWkcyK1x7UdzdvwhzJ?=
 =?us-ascii?Q?B+HHjjCG38P0hYJDUFCKhPMjAXldyJt8lGRz9Ek6m05lOL8lVp4GWblVicXK?=
 =?us-ascii?Q?moXe9ISUIH9tqt7U131yZqh6X3GHomhoVH2zy3lWsfIlyLdMV8l6VaumLelu?=
 =?us-ascii?Q?0XUmbF9WR+mghepsqddxAVleZOpQkmeh0QDwV2QzklPCgyR+7RSyzXFgBVz0?=
 =?us-ascii?Q?Mb84xdZWDkzdyjADadUk68sd1uwgDyl8UNlGgv7sXI5eQEgAsyTeMATdNTtd?=
 =?us-ascii?Q?ryIHo+Q3kNCEx5YxmHa/WHnIGqANXoPNc8vIOV5XTzi0YAQ74YysTNpgB9Ih?=
 =?us-ascii?Q?r+EQSIjgO8GESbyMAVrTKNF/fEeVZLcF6Ev+RZhQspMtAPTOFXmg3jHG8s8v?=
 =?us-ascii?Q?U87KrTiySu3WMi//YMM2r8ElNnU/nTmUsOgpwaKmqRD8nd8du2/fCwwU8BV6?=
 =?us-ascii?Q?hEJp7oz2QZBEzGWoWVAf0mAnadRqKpvNw4sb69kVklrDjW2h1Ro=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SF1ZjNRYM8Jt+BC4CznY8PnkPYNDXoLiZkXZtT1GBZDhgg0+tHMF/TIovGfq?=
 =?us-ascii?Q?+PZfvWGTR5+qzzEdaUdghmUzG5FJMaKP4MGVYgvpZhxmOHlEAXj/Y0khcuwU?=
 =?us-ascii?Q?6T+bi1u9xgb8ibZ3IEHclsw6z4qxTB6b0rKRFuvpK7TgySr7BbIkP+cKX1mT?=
 =?us-ascii?Q?IepkUxusF82+gl8vllAplP/mmLbibmGSTLJEyBniI3Y6GB7N9o6krtHl24+S?=
 =?us-ascii?Q?npl3LvCgiceoRKucyIiB30x+yjMZlKToPtcKR3TmyqtobENMK/ZFVtSw7hwc?=
 =?us-ascii?Q?BtgZ+qpq2Lt58GU0C02Acxl3n7JpYPOF9UBmwen7Sz8Fh7vQ2RRrsoBVVl+J?=
 =?us-ascii?Q?3d+2AykYcByMsc3fIjk7sPqOVxAIUsFn8L8zzCvJf9xg1SOieprZXm80u40U?=
 =?us-ascii?Q?2nLTb9xcA27fvLfogjswfwWbvP0bjMgS5Jn8Yk8/0XXwc7mr3tgV+Yx7Ebnr?=
 =?us-ascii?Q?Rniz0qoAarXBP/VmDsjxCSur4x/2a1avIemo736xddukcp8IuUTnrY70eE80?=
 =?us-ascii?Q?bJaPpgvfAtXo1+jQ8rEM61CeEXBiGpqvyyoAdgG6xqDutYBlk83dib6KMX+o?=
 =?us-ascii?Q?k07DdHaaOh0qZne4N6scg+wgrFdS9LNS1jmR7Ha3cyKWOcVSHUV9rUwgJPC5?=
 =?us-ascii?Q?dSBeJ3RydOybgxa3fmUgaWEUqS7PGs0R6Mc7J3AYEJdBt/TOio26dFDs9PZ8?=
 =?us-ascii?Q?BLvJYZ2mipAg/CxSmGZ+hzVZ2Tthx7Kpw1coW6X7IxLJjYhdz3sbti7rTLHs?=
 =?us-ascii?Q?tGAOq4t8rAsxAclQgEgonLq65AcK3IcRClW819s5Hb/+jVMgf/mytTuWAqnr?=
 =?us-ascii?Q?wojrKvx4CwCPyE1h4W+Gm/3YWwkQ+i32YTlkqAAqLcVB9AJ7Kr56bFuiDepm?=
 =?us-ascii?Q?aDxFO1EY2endRtJ8Zkm7wpBNrdI4LaA84Mh4YufQm+C9frm+exCuxoPA17DH?=
 =?us-ascii?Q?f0Kuh1jOD4R6WMOiuLNY90cyTG9n9onpyR7XdKuXBY1mPJ5Qp15WHWxD9Oi+?=
 =?us-ascii?Q?NBcW1xxiKuUknm2LXvwibio08Ixjwp86N8oHI18v+IuKyLF2K6s4pwkkdEXp?=
 =?us-ascii?Q?0wPztI5DXBr071uTU8oK7MBiRkSwVwvqe4nkyKQpzwt1x4XQ1kp9+Yqh6LKn?=
 =?us-ascii?Q?whvAQKHKC8IYlaTQ90acEEICocZgj6vSSxxdmzDTv5lm3a0FKwkU/tZ5KFt+?=
 =?us-ascii?Q?lZPvVy5CUhvzOu7/DqK7Eq3yvPNqrBOZgzlROQxUrqw6M4fo1zh2Vo/0vpO3?=
 =?us-ascii?Q?rGBVS60s0KEetYhzTJxwGPZ0BecN5c5j6rA5WcBe22adWi82PHI+VEfeRILa?=
 =?us-ascii?Q?GMZug6bbTh8lQl4NYsjw+kI7KGLhzzrY+uRh40hD6B+WP91m1W1f8Y3+BUxo?=
 =?us-ascii?Q?OQwZUjxJdV5e5nUQPYi+35qLS2Qj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5200ad-54c3-4332-d126-08df258c5d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:49.6630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF346C5784E
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

These three independent corrections preserve current target APIs:=0A=
select the existing RGB DSC 1.2 RC table only for version 1.2 and reject=0A=
native subsampling in a forced-RGB path; retain the commit's vblank referen=
ce=0A=
until completion delivers its page-flip event; and reject video-porch=0A=
scanout-position conversion for a command-mode tear-check counter.=0A=
=0A=
Command mode initializes that counter at vdisplay, puts RD_PTR at=0A=
vdisplay+1 and can wrap at twice vtotal. This is not the video raster used=
=0A=
by the shared timestamp conversion. Returning false only marks that=0A=
accurate scanout-derived timestamp unavailable; TE IRQ/counting and the=0A=
current off-delay policy remain in place. No always-on IRQ policy is added.=
=0A=
The completion callback consumes the current count/time and does not wait=
=0A=
for another TE interrupt.=0A=
=0A=
The baseline is torvalds/linux=0A=
6c377d19d4a5116d9bec5203aa3c6c11523e7898. Normal arm64 Kbuild compiled=0A=
DSI/DPU after these revisions without diagnostics; the unchanged atomic=0A=
payload reuses its earlier object result. Actual DSI-populate/DPU-scanout=
=0A=
function tests with modeled helper I/O cover table selection, rejected=0A=
native formats, the command guard and unchanged video boundaries under=0A=
ASan/UBSan, including old-code counterexamples.=0A=
=0A=
No new device timing, idle-power, DSC-math or panel cold-init result is=0A=
claimed. Original A830/SM8750 dependencies remain with their public authors=
=0A=
and are not part of this series.=0A=
=0A=
Jiaxi Zhang (3):=0A=
  drm/msm/dsi: select RGB DSC 1.2 rate-control parameters=0A=
  drm/msm: keep the commit vblank reference through completion=0A=
  drm/msm/dpu: reject video scanout timestamps in command mode=0A=
