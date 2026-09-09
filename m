Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3170EC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553F610EEA9;
	Wed,  9 Sep 2026 04:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLhuhrlt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7799C10E11D;
 Wed,  9 Sep 2026 04:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPbOSpZeqaZD8FWZytZx7x+yx9jFujnUHuP3akjtfibmGDPbgWL7COIINeLqUW3OvO1M/rB8Jo1QFX+H4YVWNaQVIALTwfsvptWtu46jF4mCHFA1htODH3FTjjMOVWQdkwsP9RUQwHgc/CEUBlqm4ASPIWJZvXz/lQ4ay05kR0ErU5gObESKaUHGOdIrA0+HdeK43txbg+vyYHwkZYRyZ/jXd8A8vqpk8ZY+4Aw7Bs/vjmnlIdUipUPnvUZl7rBIuX9NclKa78auIof+U4EdLM7f5b0RWTNJoWHidn+K7r0D/26bTn6a5oKWyIWOEJ9Tbr1fVMvaUulrilRb8ZIPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fsQ7csGtDWaUZhewPF6dldWftXZAxw0MzvpWaZDBJ0=;
 b=lxS5v98AuLFQW0KDY8xzGLSzw7FctdjfSg2r0UYTDDE27meBTJ5eRleiTY1HUksxOJxDK3DdZuQ7bGQOW15DQ/sXMp0AQQCg1lJENjOJABp8jxLwTw4SCuozkVJxNnq1+TF4wAcv0Pcx4R1MRgBYH6E1JMolLlwztOwZSmGCAoyQK3vLUVV1FQM3oG/m0UTx/jfvwTs9q8FAqgVXFWjJsoBx7Exxe+vLByoemgRlFAL215wb4/evCURkbkubAnQ3GYJ5FZGYZRPY73mUDbTmxCqZmt873d1a0zw80GVfSswgwHmSXKyUAQoLfnFr7AQBhXt7J5POZUK1ZpCNpqK+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fsQ7csGtDWaUZhewPF6dldWftXZAxw0MzvpWaZDBJ0=;
 b=jLhuhrltGCMqF4541996TI3rG5fL6mNUmwomFhLdDLL9+uLi3IjaiHrfFFBJiIHwgDKVAec+u/CeDHlpBkp3YPPXpFslAteEryQuSN5sNAyW6biNG/5yxRWO3+bfxdUdbXr/eFAiUqECMmDBo9FAerM3sosCkeXSP7rBFB0F0VE=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:54:02 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:54:02 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Ed Schofield <ed@aicharmers.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] drm/amd/pm: defer UCLK DPM enablement on Apple Navi
 14 0218
Thread-Topic: [RFC PATCH] drm/amd/pm: defer UCLK DPM enablement on Apple Navi
 14 0218
Thread-Index: AQHdP2NdUDJj269I+kO2zrW9bTxkEbbFq6jg
Date: Wed, 9 Sep 2026 04:54:01 +0000
Message-ID: <MW4PR12MB6803E270CA6401343D9D6E948EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260908072552.67798-1-ed@aicharmers.com>
In-Reply-To: <20260908072552.67798-1-ed@aicharmers.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T04:39:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|MW4PR12MB6826:EE_
x-ms-office365-filtering-correlation-id: 3dc51714-388f-424c-9564-08df0e2e5e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|3023799007|56012099006|11063799006|18002099003|22082099003|13003099007|38070700021;
x-microsoft-antispam-message-info: Lv7tWokm1nzh/wwge559UARSBCAGE4oKP/O0WCRufLI4LsVpWmbNqfr4rSmPOFiqv7+sMcgA8CAaMldjI6TA5UMRatqtdU+8zKy7iO9/tQwPMOsLjRXeyuQzPMuc8ncC3QfuVxuQzM91DKjA42dJvladEGK/d1/km1haikVon4MQuK92wt66ongYGcrD617wBxXMgGOMr4vTYarnRbRz18Eaa+H4clTUqwOAjlgkA2vfIdb0XkXlN7P/qJIb5SrfcVMYU37702GztVvlDB57TlKE6XZknwJKyrF7oFbgHO9Fmb+F9EQhddVMHOuZnR22kN25b9KHR1TY+CAfv0M9uhalZ1LClvkkMxf3S7KYZ+BxXn2hNZTSw2Ikl+kkv8RQrKDrJgDtWir2jeHXtsPYE+bz6+W0BHTxSUDo0YPFJTYLgZgsLhWSPAeKCmZqECMzKiNfZrS32Ob9WVaSj5VXD14vk/AWOMrwzrWUtYth9c2xy2CMzijsrKG/CdSP6OAwdZPhjx7HgUXBVCwUhYNoCBPvaIi9xD2D/xtbpAkrWE0HXbZIAwe/jHzaXuQ6FcHen+/orU+KxcoQNNxQjueARWekw9QW5bpcJ1w5OvGjs6s4GtyxJAxVSIY0HZBOH9E2P7nZFCI7pWobGrJhwm1B2GP+ZbI3d+2Qu/X0B4RrqZc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AfpaVWHOm5BWpV//ZluvoFuM7lggFXV5//CcK1BttLIgE1u/j+KGl8WmeWy+?=
 =?us-ascii?Q?6Yfr7bj+6Ru/Iw4wO8/c6uyfivcL7W9oqoV8ktFeP96DJ+oVW5I44ZmQAwg9?=
 =?us-ascii?Q?mx8MYFy5HlEbfZVU7KiL7niuuGavq8ks6v0/JzLnmoDrLn7Ekn3aB3RqBkl3?=
 =?us-ascii?Q?Y4hJUjGqXsC70x5sapbD6pjkFNrhJ1QCmRQQqQiLm+eyYwQP31UNNYDuQiGh?=
 =?us-ascii?Q?JL3r9Tm3mz3yej328i/s0kfIlP3TuOsNcRe+9/5pMgmjnTLXzmk5vrnf7P1L?=
 =?us-ascii?Q?PHgw/MYNKCBo8K/JFGyUbF5Pp+N0iDXyqBa4GxhiA8h8HzYr+2hYlsYMk6Vo?=
 =?us-ascii?Q?xeUEisTFzt7UVmMLBdMggGmBZxgfhnYcqUhQBWrdf/qBY76VayUaDXbDSmtt?=
 =?us-ascii?Q?TvhwNw97iKeU29ZIKfRcqTAfVknRLnPHQ6RFO9/QZAQILCio5gwNKCzoNdiQ?=
 =?us-ascii?Q?QdJKO54Exe9c1AyBblxFq9e7dd9a1sn8smXKu/ymdWw8vFiazpU0E/oe2HPF?=
 =?us-ascii?Q?eD2jQfgGfRXz274as7QGCMpDcG7v0wzT4GGLzwtVvQ2FIF684gapSoCahDF0?=
 =?us-ascii?Q?7oFqzQcExynxDzU8mGym5NFq2Kw4r785MeIXT7E1pErzOyTNx77A3mkVKXaf?=
 =?us-ascii?Q?M7m/ZkDz3jVFiY3JQZ1uYTwhvLGsYJ2pftQAuTRArmtomwbHfUdGn5E+LctE?=
 =?us-ascii?Q?GQMX8iQpayUqxKeoentKThtvVxZXSzulT9JueR4TsN502lDGLmyGnoA8Be1l?=
 =?us-ascii?Q?s53UTGcJFijcrip5HKOzPfdRpZklwMjU8MtxOzXTySwwVdSWMy+wONbiH0VI?=
 =?us-ascii?Q?pJ4TE7cB3+V4AWK8HtaFXqdzxF7HGmpu8wOecWfG6+U6454ileUMOr2htT4T?=
 =?us-ascii?Q?kFgTymBLyw0sca1r2YqJvxArs/u+l+5D70F5jbaDReDTMnugNTXv52JDLngB?=
 =?us-ascii?Q?0xmpB/pnRYDyFeW3Ik2Mb0rdh69O4ywpdfWaB5sTQWe5HqOot3mLjH3u+trs?=
 =?us-ascii?Q?2n1RYDU5E7HQgpOKdS4VSgcbNRit+iS4tF7ZedYIX5viKZae2X4yPRCngGpq?=
 =?us-ascii?Q?LXO/LbBHtUh2jQyWGTPqPgovNgvi8cDKLUnY714VJlXDxiH/oPJ8Ci244b9d?=
 =?us-ascii?Q?Jcc3VNgKknbYY/HkmD/GyZXoeQwlPi5ezZsLLLMeyaswFktGnUHUhE3M04Pl?=
 =?us-ascii?Q?MiCFHchTh86lnC1GDDiWEhpcJ1tImW00/zzGaNzT2V1eT0ykc2ONZ2Mzg5Lm?=
 =?us-ascii?Q?nK8Z1HwORyDbORZc/pQhX8uob4XZRCA7dw6lcQ0LZ5anJ8bEw6+lP9sVKlXW?=
 =?us-ascii?Q?7bUZzLNEef8K4dh5/rS6/6rv7dj4yMf8tDZqlW6ngAnDRrCS3tzvk55Er39N?=
 =?us-ascii?Q?eX0Qzv9YPBsFA4dKogZ0jp6U1TjpT0yiIOHKYQevRFiyQUerprKVzqleTjQ2?=
 =?us-ascii?Q?Q6nERD+h4CWaVVNMKERpU90RG1TyyMrfRJke6O06jQgnmfysQ3iiKAJxXjX+?=
 =?us-ascii?Q?AKBLJ8Uwk8l2c20L5wg9U0PpAQbn48f8p6nP1WNngM57X8/ZrwuIIm36Fn0M?=
 =?us-ascii?Q?WvVhiNVnCQhhpO+X2ZB4Su3N+fDMGW8pSWojq/Zil9PxNUVj2HhmhdcYv1I/?=
 =?us-ascii?Q?o5Lju0OqGGIf4BOKUB4mPP022osmPOsGHA+bX26YQ3EcxkGwijM5m0mX+qxl?=
 =?us-ascii?Q?enCKn5OP7mMKGA+GK9GaN4vqRnV5Na8bX6KCkVy37itszrli?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc51714-388f-424c-9564-08df0e2e5e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 04:54:01.9161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2H7LIAndLFIS5AGWnmhNe5RGwWzwL8I2zfsKTry1NSfuP10dFt4XQLby3tAOfbxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

AMD General

I think the workarournd is ok.
Just curious what if this deferred UCLK dpm enablement is put at the beginn=
ing of navi10_set_default_dpm_table() instead of the post_init?
navi10_set_default_dpm_table() is also after SMU_MSG_EnableAllSmuFeatures i=
s issued.
I guess any point after SMU_MSG_EnableAllSmuFeatures is acked is ok?
Thanks.


-----Original Message-----
From: Ed Schofield <ed@aicharmers.com>
Sent: Tuesday, September 8, 2026 3:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.=
com; simona@ffwll.ch; dri-devel@lists.freedesktop.org; linux-kernel@vger.ke=
rnel.org
Subject: [RFC PATCH] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14=
 0218

[You don't often get email from ed@aicharmers.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

On the Apple 1002:7340/106b:0218 revision 41 board, enabling UCLK DPM with =
EnableAllSmuFeatures can time out and leave amdgpu without a DRM device. Om=
itting only UCLK avoids that timeout; enabling it separately immediately af=
terwards still timed out in a local experiment.

Defer UCLK enablement to the Navi post-init callback, then verify the firmw=
are bit and refresh the supported-feature bit, memory DPM table and sustain=
able clock limits before the UMC workaround and UMD setup.
Validate the PPT memory states consumed by DCN20 before that callback.
Keep both memory-voltage features enabled and respect PP_MCLK_DPM_MASK.
Limit the change to the board and revision tested locally.

Based on Atharva Tiwari's delayed-UCLK proposal for Apple board 0219.
This adaptation uses the Navi callback and updates driver clock state; it d=
oes not change T2's existing 0219 allowed-mask workaround.

Link: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.=
html
Link: https://github.com/t2linux/kernel/issues/19#issuecomment-5537823876
Assisted-by: LLM
Signed-off-by: Ed Schofield <ed@aicharmers.com>
---
This is a board-specific follow-up to Atharva Tiwari's August 25 delayed-UC=
LK proposal for Apple 0219:
https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.html

T2 review: https://github.com/t2linux/linux-t2-patches/pull/60
Hardware report follow-up: https://github.com/t2linux/kernel/issues/19#issu=
ecomment-5579537553

The affected machine here is iMac20,1, PCI 1002:7340 / 106b:0218, revision =
41, with SMU firmware 53.38.0, interface 38. The original-policy control ti=
mes out in EnableAllSmuFeatures (message 6, -62). Omitting only UCLK avoids=
 that timeout. Enabling it immediately afterwards also failed in an earlier=
 local experiment; Navi's post-init callback is the point tested successful=
ly.

The patch refreshes driver state after enabling UCLK because initial table =
setup ran while that feature was disabled. DCN20 also consumes the PPT memo=
ry states before post-init, so their count and nonzero frequencies are chec=
ked.
Both memory-voltage features remain enabled, and the public MCLK-DPM policy=
 still takes precedence over the workaround.

A direct control on this AMD staging base used the same kernel image, confi=
guration, firmware, boot parameters and 6,434 companion modules, with only =
amdgpu rebuilt from the pristine upstream source. Comparing the two extract=
ed initramfs images found exactly one changed file: amdgpu.ko.zst.
The first unpatched warm boot passed rendering and video checks. The second=
 reproduced the EnableAllSmuFeatures timeout (message 6, -62) and left no b=
ound AMDGPU driver. Linux remained reachable over SSH. Warnings in amdgpu_i=
rq_put followed during GPU error cleanup. The control series stopped at tha=
t point.
Restoring the exact patched module/initramfs recovered GPU initialization, =
hardware rendering and all 60 VAAPI/software frame comparisons on the next =
warm boot. This demonstrates an intermittent GPU initialization fault on th=
e upstream base, not an inability of every unpatched kernel boot to reach L=
inux.

The experimental implementation passed 40 warm and ten cold boots on this m=
achine. The extracted production implementation has separate T2 7.2.3 warm,=
 rendering, video, sustained-render and public-policy checks. The productio=
n
T2 patch also passed prescribed AC-connected and AC-unplugged cold starts, =
with operator-confirmed 60-second intervals and rendering/video validation.
An intervening start was corrected to AC-connected when the operator clarif=
ied that he had not unplugged it; the actual unplugged test followed.
The T2 build also passed a ten-minute, 2 GiB-budget Vulkan memory test with=
 a load/idle/load transition and a normal boot after system updates and ini=
tramfs regeneration. This AMD staging variant has a successful W=3D1 object=
 build, full kernel build and extracted-C ASan/UBSan checks; it has now pas=
sed ten warm boots: two attended boots, including recovery after the failed=
 unpatched control, and eight further unattended boots. SMU initialization,=
 SSH, hardware rendering and all 60 VAAPI H.264 frame comparisons against s=
oftware decoding passed on every boot. Console login was visually confirmed=
 on the two attended boots.
All four memory states (98, 500, 625 and 875 MHz) were available, with both=
 memory-voltage features enabled. This build has only the proposed GPU fix =
on AMD staging, without the T2 patch collection. Rust was disabled after an=
 unrelated Rust DRM preparation failure. This is AMD staging hardware cover=
age, not a boot of Linus's current tree.
No AMD staging cold, suspend/resume or full desktop test is claimed. The st=
aging boot also logged an applesmc probe failure (-5), Bluetooth initializa=
tion errors and the previously observed boot-time MCEs. The T2-patched SMC =
driver initialized successfully after returning to the protected production=
 kernel.
USB storage and wired Ethernet provided the boot and SSH path; this test do=
es not establish full T2 device support.

Is the Navi post-init callback the right place for this sequencing quirk, a=
nd are there additional clock-state consumers that should be refreshed? The=
 predicate is deliberately limited to the tested subsystem and revision.
The related 0219 board has an existing T2 allowed-mask override and needs s=
eparate evidence before combining the cases.

Codex assisted with investigating the initialization sequence, writing the =
patch and tests, and preparing this message. The session progressed from re=
producing the GPU boot failure to isolating UCLK timing and extracting a bo=
ard-specific fix with public policy and error handling preserved. The patch=
 contains an Assisted-by trailer. The host checks use extracted C with mock=
ed firmware; the T2 hardware results are recorded separately above.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9a..4e8fb9e7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,18 @@

 static int navi10_init_ppt_limits(struct smu_context *smu);

+static bool navi14_needs_late_uclk(struct amdgpu_device *adev) {
+       struct pci_dev *pdev =3D adev->pdev;
+
+       return pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
+               pdev->device =3D=3D 0x7340 &&
+               pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
+               pdev->subsystem_device =3D=3D 0x0218 &&
+               pdev->revision =3D=3D 0x41 &&
+               (adev->pm.pp_feature & PP_MCLK_DPM_MASK); }
+
 static const struct smu_feature_bits navi10_dpm_features =3D {
        .bits =3D {
                SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +368,11 @@ navi10_init_allowed_features(struct smu_context *smu)
                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEA=
TURE_MEM_MVDD_SCALING_BIT);
        }

+       /* This board times out if EnableAllSmuFeatures includes UCLK DPM. =
*/
+       if (navi14_needs_late_uclk(adev))
+               smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+                                          FEATURE_DPM_UCLK_BIT);
+
        if (is_asic_secure(smu) &&
            (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, =
0)) &&
            (adev->rev_id =3D=3D 0))
@@ -470,6 +487,25 @@ static int navi10_store_powerplay_table(struct smu_con=
text *smu)
        return 0;
 }

+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi14_imac_check_uclk_states(struct smu_context *smu) {
+       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
+       unsigned int count, i;
+
+       if (!navi14_needs_late_uclk(smu->adev))
+               return 0;
+
+       count =3D ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
+       if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
+               return -EINVAL;
+       for (i =3D 0; i < count; i++) {
+               if (!ppt->FreqTableUclk[i])
+                       return -EINVAL;
+       }
+       return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)  {
        int ret =3D 0;
@@ -490,6 +526,10 @@ static int navi10_setup_pptable(struct smu_context *sm=
u)
        if (ret)
                return ret;

+       ret =3D navi14_imac_check_uclk_states(smu);
+       if (ret)
+               return ret;
+
        return navi10_init_ppt_limits(smu);  }

@@ -3219,6 +3259,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_c=
ontext *smu)
                                               NULL);  }

+/* Rebuild memory clocks before the UMC workaround and UMD clock setup.
+*/ static int navi14_imac_late_uclk_enable(struct smu_context *smu) {
+       struct smu_11_0_dpm_context *dpm =3D smu->smu_dpm.dpm_context;
+       struct smu_dpm_table *table =3D &dpm->dpm_tables.uclk_table;
+       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
+       struct smu_feature_bits enabled;
+       int ret;
+
+       if (!navi14_needs_late_uclk(smu->adev))
+               return 0;
+
+       ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT, =
true);
+       if (ret)
+               return ret;
+       ret =3D smu_cmn_get_enabled_mask(smu, &enabled);
+       if (ret)
+               return ret;
+       if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
+               return -EIO;
+
+       smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
+                                FEATURE_DPM_UCLK_BIT);
+       table->clk_type =3D SMU_UCLK;
+       ret =3D smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
+       if (ret)
+               return ret;
+       if (!table->count)
+               return -EINVAL;
+       if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+               table->flags |=3D SMU_DPM_TABLE_FINE_GRAINED;
+
+       return smu_v11_0_init_max_sustainable_clocks(smu);
+}
+
 static int navi10_post_smu_init(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev; @@ -3227,6 +3302,12 @@ st=
atic int navi10_post_smu_init(struct smu_context *smu)
        if (amdgpu_sriov_vf(adev))
                return 0;

+       ret =3D navi14_imac_late_uclk_enable(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", =
ret);
+               return ret;
+       }
+
        ret =3D navi10_run_umc_cdr_workaround(smu);
        if (ret)
                dev_err(adev->dev, "Failed to apply umc cdr workaround!\n")=
;

base-commit: c22f9a61e288580824edbbc3ae5a29c9a338594f
--
2.55.0

