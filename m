Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7ADC61DCB
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 09:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB92A10E078;
	Sat, 29 Aug 2026 09:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eNOLCThM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A112F10E078
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 09:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A46EA60055;
 Sat, 29 Aug 2026 09:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3188A1F000E9;
 Sat, 29 Aug 2026 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787994878;
 bh=wmlfatm/24JaiLuqhF8Gi3S6J1TP/DZnFmbAkuTScN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eNOLCThMarsd398T6ekOCU4LZC2bcDd9plNok6OlDlH9N+51+U4k7K5fJt28XkpYx
 xLdnW3WSyo6yny95l8yGF1Kw9fwcvHXBNnMMvxcKG4hf5wUjcsIi+Lqgok3htKVoWQ
 Hl6yMl3xGZXCDurxmslu9SrRC4d3nELnhIInvDRfCqs+xeSr6aPhKBqgAgTcSdbo2x
 T1s6a7+zatlcV+aVcTjR69AoKsJsmdPN1yg3ulF0I7wenkgV0S1LwsWZrwj4iRNZjW
 A/pF4EASS5kvlD+EbbK0Tg5mhCNG5vxRWom5xsr5/jVt+G2wgK7RA6SUEHLDJ7X0VK
 BBvAgF4wrl7Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
 <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 09:14:37 +0000
Message-Id: <20260829091438.3188A1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves an MMIO offset 0 read/write bug and `ASSERT(mas=
k !=3D 0)` warning for DCN3.2 by adding missing CRC engine 1 register defin=
itions, but deliberately leaves the exact same bug unpatched for DCN2.0, DC=
N3.0, and DCN3.1. This exposes those platforms to a potential hardware hang=
 when userspace accesses the CRC debugfs.
--

commit 59349c8a9cf596f2dd8a832ebff31962e51092a1
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

drm/amd/display: add missing CRC engine 1 registers and masks for DCN3.2

This commit fixes a WARN and MMIO offset 0 access issue when using the CRTC=
 CRC
debugfs file on DCN3.2. It adds the missing CRC engine 1 registers and masks
for DCN3.2 hardware.

>     The same entries are missing for DCN2.0, DCN3.0 and DCN3.1.  I have n=
o such
>     hardware and have not touched them.

[Severity: High]
This is a pre-existing issue, but does leaving DCN2.0, DCN3.0, and DCN3.1
unfixed expose those platforms to a potential hardware hang?

When a privileged user enables CRTC CRC capture via the debugfs interface,
it invokes amdgpu_dm_crtc_configure_crc_source() which unconditionally loops
over all MAX_CRC_WINDOW_NUM engines:

amdgpu_dm_crc.c:amdgpu_dm_crtc_configure_crc_source() {
    ...
        for (i =3D 0; i < MAX_CRC_WINDOW_NUM; i++) {
            if (!dc_stream_configure_crc(dc, stream, enable, enable, i)) {
    ...
}

For engine 1 on DCN2.0/3.0/3.1, optc1_configure_crc() unconditionally attem=
pts
to program OTG_CRC1_WINDOWA_X_CONTROL and other engine 1 registers:

dcn10_optc.c:optc1_configure_crc() {
    ...
        REG_UPDATE_2(OTG_CRC1_WINDOWA_X_CONTROL,
                OTG_CRC1_WINDOWA_X_START, params->windowa_x_start,
                OTG_CRC1_WINDOWA_X_END, params->windowa_x_end);
    ...
}

And optc1_get_crc() attempts to read the CRC data:

dcn10_optc.c:optc1_get_crc() {
    ...
        REG_GET_2(OTG_CRC1_DATA_RG,
                  CRC1_R_CR, r_cr,
                  CRC1_G_Y, g_y);
    ...
}

Because these are missing in the ASIC's resource tables, the address evalua=
tes
to 0, causing generic_reg_update_ex() to issue MMIO reads/writes to offset 0
and trigger ASSERT(mask !=3D 0).

Could this missing register mapping lead to crashes or GPU hangs on these
platforms when userspace accesses the CRC debugfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829085941.1063=
18-1-mikhail.v.gavrilov@gmail.com?part=3D1
