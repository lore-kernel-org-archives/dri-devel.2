Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38F5C4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19C310E203;
	Wed, 15 Jul 2026 21:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNHFRUMS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA5B10E203;
 Wed, 15 Jul 2026 21:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY/4XcQ7Nn5eBUTKN4+xUErqDFsz5cCYs8EZVfDO4LIq/fP++YNuS9dOKj/FRQJJTZqlMMKRUffQWVfaUV5kDmFIhCQ1wECHbEKqLMXLbqq+WFep2r+xoufjjoM0EQ3LbkXDa1RMDuu6EYGjNb0air7Xdyrhy+CCeyM2DK+8QfuU0sim/r6QGwWO/2RbSH7zDVX6rnC3rubFXJq1we7BAhK2l1mhVCAsq/zmzwgq6Kmyr5wGpGXa6vTCPgyJwSo8rmvmzBr7oEcG26m8rl7KEhKbLgSmPz+Q7LYQcfkA7e4qHIuzC1b79qXdUrKp8onbIdZeAjwCYL875Lc52lqCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEFBki3hIKnNrWVtchzaxOsk1TXHr1S3yYDZh/9GKGg=;
 b=cUyMFAUtlcIhCNjAB/Vu5YokEhvRngZtU6JA4/FHBBaCvYdXAZIbO+t4UMKK4Zd8yAnwtvhPjSLdMcQ/rsM2oPfiNKIHA7mFRGbErfhM/X98Bmpj7Kct4kopSHrQVMAElmArQSGwmfYn4if45ayz2/Xaj6Ck8FYfi8HgE0l6Aux9EX74DtXzvqS7yHvoq2Nvz8LqJmUIQzw5pyLhjOz7ELE4IZzBHqtRQuXErbY6SMHlgkpFmN7VGPxkoB53Lk0Ku8UF1AZj/8MQgPCBy86N2PZaNeTJgD30GTvmrI5kCnbnuulkyo1kfjudge3UnBYF7iqdrVZGjEXmPXNTYRqbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEFBki3hIKnNrWVtchzaxOsk1TXHr1S3yYDZh/9GKGg=;
 b=fNHFRUMSAKa2BulPSu85HB6aHJz2wq2BOj5+6seKkqFmttJwdcWX5vyKCoqn7CncMeh95T72K3e6GvaWwjxI8KIKFZPGieYrjalW4RjBhXev+dnWoWEPq5dy/2IHI0+g3vUv3qiJbSCWL7xOtzm42/CRxvhyB5os4bnEJb0IBeo=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 21:52:45 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::87e7:239d:191f:3bb%3]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 21:52:45 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: Jiri Slaby <jirislaby@kernel.org>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "siqueira@igalia.com"
 <siqueira@igalia.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Cheng, Tony" <Tony.Cheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, DRI devel <dri-devel@lists.freedesktop.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: amdgpu crashes in get_ss_info_from_atombios()
Thread-Topic: amdgpu crashes in get_ss_info_from_atombios()
Thread-Index: AQHdFDcXP/GhfParmU6bujxoj/Qn1rZvFJ04
Date: Wed, 15 Jul 2026 21:52:44 +0000
Message-ID: <PH8PR12MB7279ACE40040268C9A48F484F9F82@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org>
In-Reply-To: <a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T21:52:43.904Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|DS0PR12MB8766:EE_
x-ms-office365-filtering-correlation-id: 7e540aa7-5ce6-46d9-890a-08dee2bb670a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|38070700021|11063799006|5023799004|56012099006|8096899003|10067099003|6133799003|13003099007;
x-microsoft-antispam-message-info: JpaTb0rJigT7QW75nSA8pBPsGy1dTVMkiLtto/YVaHKJzeUDfrfwiVo4qIF59g+vy+c60xLeYxVn02ONdXDWRJN4nyWt60adzfBjStmWbDUkFb1/hRNSP5qx4i4x+y3NVArvgN+fF9rJdtXtQg7xH8sEky6u71IUERm9mAWaWPU8HmBIZ4DW8stSDJJk/sn6vUWz+U9Cwz1BOS6r2GfHtxLf8w3cnWtlys4apZhylZvsVRFpZVumAggIlxzulT75rCLUPJ/v/qHylJkWFwqtSFwIJXg5L8kzPzomGNl4iqIlyeB5OFMUxVN59fRZN0cFVsX/3hfqhq5dn07zWDJZrunDEDsKHGooktL/vJY5GCHpwLMm4mcW8RnkK+Jm0tTMRCd6/4dJhrDfROvuKSW4kEc/EIDrzasUbROuv9burh5i+fGDcCFAveQtMbXJvUj0EG6nZ7MkuRAivHSJbSjsOdU4rtVIw/poq+4HQZXc+r0GIAIu2sbxzajqbZntur9LybHkFX/qeminABKExG3G6kCzdPFGtx8cuNsV0IFFr/XTYALaDDi9ehbp9AuIexZkAii1p4b51CwnPyDCL+8msBHZ7s1hLU34fw2EOzwWnCL4sPWXxJXpvoZUhBZFSKrcdbZUdgvS+5XIFgEda8mdDdxvCDIuFRYlVDTxs9fy0CWOmMXX/kaeEh4W9PAtFWaxdnrr5ozY6scsQdP30pstRXz8cV8dPXqqOPYHSPeHX9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(5023799004)(56012099006)(8096899003)(10067099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7elJzCrFTn1Nt/3Pc+QKSJDuFywyBq0ok+awdJBqPAQbG8racNXnqV4QZVAT?=
 =?us-ascii?Q?oKBINWXC77W3OeJCvhHbk0etl0QgRjcQxRP1ETCyDLjch5oue3DfHbukzcQo?=
 =?us-ascii?Q?EWfnwqzSjlwpZVrGwuC3HIRrKN4iTfI0DbkCVDnd9lz8WJv4v/xTnCaIk8k+?=
 =?us-ascii?Q?aloud1RMce+gb55fN/NXW7xH86u6tW+50fibp4d0Lq6WGFKmmrdXtDHvztPY?=
 =?us-ascii?Q?O1pE1C0JOGdApIn3nqbLValeoPrxEXycRJo+RdiwBL6CM+Ja67x6MH6asNe0?=
 =?us-ascii?Q?vrbBvc51Fp87nzB9wihjksj0Hx/A/cYU0A+Y8uTLisJco/dQ/P0kQO2P1A3n?=
 =?us-ascii?Q?ARXcR0cmMyq1cg1rBtH0TURQHctgTweG+g4mlnZHZkqxWvMsNzh6rdywo5Cu?=
 =?us-ascii?Q?pXv+chvDzZGxXurubEnrL7LXM5rNGohmtXzXHH66rM03eQ4RyAEFPpxx/4eJ?=
 =?us-ascii?Q?ftpdE8/QtAVx9jBsS91pmHp3usTvQ3FtwGF/Ux9TOs10dGom7gW0vnp95iBS?=
 =?us-ascii?Q?ACY4uhyJjoNAGWXV1VBRHR4Eo28qc5plXyUPDsI/UkWM8eNSwJGQ3P75B0vG?=
 =?us-ascii?Q?HlS7Hcr8DTF7u4qCbZDlYXg5WSFURuW51n39UGdbOuyWcZj67NA//tPkm9pN?=
 =?us-ascii?Q?VKD8w8wBHte2GEsh342TTySXgX9M/w9fWTmKDdMieDQE1ZNKH8vnjX/eWMr5?=
 =?us-ascii?Q?rDNDkyGQqEIqTgurT4L5+IN9g5ZpqVtlz+5hAry9SbFakhtyXQbtH3sN17DR?=
 =?us-ascii?Q?E8pt+t3UjfDHvEYc+tziktep+OVDJhlfK/PiPXXtJoclF5zBRVLWoZM2CcHJ?=
 =?us-ascii?Q?jS6UfzegGe3AUYdMEwWH5iM3gYwYvVKJvzu+QQK1Laq9dqvj4kW31IJIkY8k?=
 =?us-ascii?Q?onw/mdccZmtT2oaAPhR9eDIyTCrXSSOiO7zBg0juhNG/OOC1ZMyBjOxh/SAS?=
 =?us-ascii?Q?WVnUbS5z98O1H2uGkR5cCsOwX9M7Mie0vI2yGqhAJ61kAAmYdcwm2lKxxYPK?=
 =?us-ascii?Q?UUgRfcvqCrSaDE93pvVx8ang7X56jHAsZYNPhETRJ9QG1jiUbwxcjWEltupg?=
 =?us-ascii?Q?xfog2lkNATJL6K3zZvxfSbqSUMIsNLZT/shqLZsbK0R+0D9DXybmKkIsw6Rl?=
 =?us-ascii?Q?2OlgpScAYgtcYDvoTlevhhpC82jq19fH/rYgHyrXcGsqWebHmqa5VB6JXKuG?=
 =?us-ascii?Q?8Mgtwu+3AanNrkE/2AtAHF3r8tRLZcxi6R+BsN0TFwdNRWw34zsa6K5ILv0Y?=
 =?us-ascii?Q?eJtSELi63s8DGCj+QX+u2bwl4KulcNJyVLZJ1EWvZPsSex6tSpEOUWjvmrYf?=
 =?us-ascii?Q?9nZwH+syNfG9d6IYBAdIC95i99rEaCSCPyaUOuKTE6FodR+BugJxFFUIyHbf?=
 =?us-ascii?Q?z1tMX3nYAVVnCK+ioc/eoHy/4nmTRySSp9ezSe6UcuND+Rz76QNSWDFXHP//?=
 =?us-ascii?Q?Gh0TL5SCIj4J/SqBrBZ4lEwiyKaup1RAzPaw+OTNyJBX9olaxHs+4aLYluQS?=
 =?us-ascii?Q?iI4AJc5T8WTo06ENgRmBdyskjgaPr41uNaNU2v53T3n8uPXwTQY14yEWehg+?=
 =?us-ascii?Q?c8tenhgrcckSdZzTMLMCVNGG69BmG6TOHOsjSFGSQN+9usCLDSv031N7rYBy?=
 =?us-ascii?Q?D70UaQSzf0m+mRNh0yRvjnxwE9vzqM1SCF/t1N2tCzQeKlmvNMN9M5VTwUv2?=
 =?us-ascii?Q?O24e422/aizgnAnbQYQ38xSMwvYMajKpDjGwIuX6bDIqZDQi?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB7279ACE40040268C9A48F484F9F82PH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e540aa7-5ce6-46d9-890a-08dee2bb670a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 21:52:44.8306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5uKX1h6DeE6U+Z6qrCGZouOhJNrDZbCOiIF/gG9fd3WVu5KFIVUX3c8J1uCWM55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

--_000_PH8PR12MB7279ACE40040268C9A48F484F9F82PH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hey,

Nice catch it looks like the init order is incorrect. Strange we never saw =
any crashes, that log wasn't used by anyone it seems.

The fix would be to redefine DC_LOGGER so we have ctx available in         =
                get_ss_info_from_atombios().  We can redefine the DC_LOGGER=
 to use  clk_src->base.ctx->logger (like you mentioned) since clk_src is av=
ailable everywhere.


Thanks,
Bhawan






________________________________
From: Jiri Slaby <jirislaby@kernel.org>
Sent: July 15, 2026 4:51 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; siqueira@igalia.com <siqueira@=
igalia.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Cheng, Tony <T=
ony.Cheng@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedeskto=
p.org>; DRI devel <dri-devel@lists.freedesktop.org>; Thomas Zimmermann <tzi=
mmermann@suse.de>
Subject: amdgpu crashes in get_ss_info_from_atombios()

Hi,

SUSE received a bug report:
https://bugzilla.suse.com/show_bug.cgi?id=3D1271175

get_ss_info_from_atombios() crashes in 7.1.2.

calc_pll_cs->ctx (dc_context) is NULL while trying to log by the first
DC_LOG_SYNC() in get_ss_info_from_atombios():
                 if (as_signal =3D=3D AS_SIGNAL_TYPE_HDMI
                                 &&
ss_info_cur->spread_spectrum_percentage > 6){
                         /* invalid input, do nothing */
                         DC_LOG_SYNC(
                                 "Invalid SS percentage ");
                         DC_LOG_SYNC(
                                 "for HDMI in ATOMBIOS info Table!!!\n");
                         continue;
                 }




Note dce110_clk_src_construct() calls:
   -> ss_info_from_atombios_create()
     -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx
   -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx AFAICT

calc_pll_cs->ctx should not be used in the former, or something.





This was likely introduced by:
commit 1296423bf23c7a58133970e223b1f47ec6570308
Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Date:   Tue Feb 20 17:42:50 2018 -0500

     drm/amd/display: define DC_LOGGER for logger





Before the commit,
   clk_src->base.ctx->logger
was used in get_ss_info_from_atombios(). The commit unified all users to
use:
   clk_src->ctx->logger

The former is set at the beginning of dce110_clk_src_construct() (before
the crash location). The latter only in calc_pll_max_vco_construct()
(after the crash location).


Any ideas how to fix this? Redefine DC_LOGGER to clk_src->base in
get_ss_info_from_atombios()?


I'm not sure if this is a regression and there is some underlying issue
provoking the "Invalid SS percentage" dump -- asked in the bug and
waiting for a reply.

thanks,
--
js
suse labs


--_000_PH8PR12MB7279ACE40040268C9A48F484F9F82PH8PR12MB7279namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Hey,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Nice catch it looks like the init order is incorrect. Strange we never saw =
any crashes, that log wasn't used by anyone it seems.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The fix would be to redefine DC_LOGGER so we have ctx available in&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;get_ss_info_from_atombios().&nbsp; We can redefine the DC_LOGGER to u=
se&nbsp; clk_src-&gt;base.ctx-&gt;logger (like you mentioned) since clk_src=
 is available everywhere.</div>
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
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Bhawan</div>
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
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiri Slaby &lt;jirisl=
aby@kernel.org&gt;<br>
<b>Sent:</b> July 15, 2026 4:51 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; siqueira@igalia.c=
om &lt;siqueira@igalia.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Cheng, Tony &lt;Tony.Cheng@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;; DRI devel &lt;dri-devel@lists.=
freedesktop.org&gt;;
 Thomas Zimmermann &lt;tzimmermann@suse.de&gt;<br>
<b>Subject:</b> amdgpu crashes in get_ss_info_from_atombios()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
SUSE received a bug report:<br>
<a href=3D"https://bugzilla.suse.com/show_bug.cgi?id=3D1271175">https://bug=
zilla.suse.com/show_bug.cgi?id=3D1271175</a><br>
<br>
get_ss_info_from_atombios() crashes in 7.1.2.<br>
<br>
calc_pll_cs-&gt;ctx (dc_context) is NULL while trying to log by the first <=
br>
DC_LOG_SYNC() in get_ss_info_from_atombios():<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (as_signal =3D=3D AS_SIGNAL_TYPE_HDMI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; <br>
ss_info_cur-&gt;spread_spectrum_percentage &gt; 6){<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in=
valid input, do nothing */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LO=
G_SYNC(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Invalid SS percentage &quo=
t;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_LO=
G_SYNC(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;for HDMI in ATOMBIOS info =
Table!!!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
<br>
<br>
<br>
<br>
Note dce110_clk_src_construct() calls:<br>
&nbsp;&nbsp; -&gt; ss_info_from_atombios_create()<br>
&nbsp;&nbsp;&nbsp;&nbsp; -&gt; get_ss_info_from_atombios()&nbsp;&nbsp; &lt;=
- uses calc_pll_cs-&gt;ctx<br>
&nbsp;&nbsp; -&gt; calc_pll_max_vco_construct()&nbsp;&nbsp;&nbsp; &lt;- set=
s calc_pll_cs-&gt;ctx AFAICT<br>
<br>
calc_pll_cs-&gt;ctx should not be used in the former, or something.<br>
<br>
<br>
<br>
<br>
<br>
This was likely introduced by:<br>
commit 1296423bf23c7a58133970e223b1f47ec6570308<br>
Author: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Date:&nbsp;&nbsp; Tue Feb 20 17:42:50 2018 -0500<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/display: define DC_LOGGER for logger<br>
<br>
<br>
<br>
<br>
<br>
Before the commit,<br>
&nbsp;&nbsp; clk_src-&gt;base.ctx-&gt;logger<br>
was used in get_ss_info_from_atombios(). The commit unified all users to <b=
r>
use:<br>
&nbsp;&nbsp; clk_src-&gt;ctx-&gt;logger<br>
<br>
The former is set at the beginning of dce110_clk_src_construct() (before <b=
r>
the crash location). The latter only in calc_pll_max_vco_construct() <br>
(after the crash location).<br>
<br>
<br>
Any ideas how to fix this? Redefine DC_LOGGER to clk_src-&gt;base in <br>
get_ss_info_from_atombios()?<br>
<br>
<br>
I'm not sure if this is a regression and there is some underlying issue <br=
>
provoking the &quot;Invalid SS percentage&quot; dump -- asked in the bug an=
d <br>
waiting for a reply.<br>
<br>
thanks,<br>
-- <br>
js<br>
suse labs<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH8PR12MB7279ACE40040268C9A48F484F9F82PH8PR12MB7279namp_--
