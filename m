Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F05C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE4B10E05B;
	Tue, 14 Jul 2026 21:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C61gt7DZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B348710E05B
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:23:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3032601ED;
 Tue, 14 Jul 2026 21:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705981F00A3A;
 Tue, 14 Jul 2026 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784064237;
 bh=0qUhpyea9DsRFaa7i1kducwt5pAUOhEVL+D/nERV39U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C61gt7DZRJdlF80q46ZTG1mVIVL0zkHDcitWfitXzejbqspGxfwLP/1Mdz5s7DwRp
 QI3d8RNCNRmPW2dxzo1PoMP4Z/1K0QzYyqbsst31cohGpm+KtiVnQi1qejLvXeBkC+
 +0K0Psn2hjUCBCDHn3uWSprlq2kX7/yXvimrxPGlmKFThqlC9cOWk6JBNrXUtigOI8
 y7foO4COy/4tycrPq8blIVgFEJDcTL/buZJF6Ft+5vOo5vAXKysWsQ0OQcwwV2DVwx
 WdCLRxSLZxAltfuVIWdYlvsQipp5BiJE4/Yo6SWo7gurUgQZpdxDm6ytIltCQmHrc0
 j33g+M/HrwKAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] drm/nouveau/gsp: vendor the RUSD header
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714211429.238355-2-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-2-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:23:57 +0000
Message-Id: <20260714212357.705981F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] 32-bit platform ABI mismatch in shared telemetry buffer layout due=
 to missing struct padding, leading to memory corruption.
- [Medium] RUSD telemetry structures use native integer types, masking endi=
anness mismatches on big-endian architectures.
--

--- Patch [1]: [PATCH 1/6] drm/nouveau/gsp: vendor the RUSD header ---
commit c1a3b8ad153588da7ba08ef117defa77f7ba5f2d
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau/gsp: vendor the RUSD header

RM User Shared Data (RUSD) is GSP-RM's telemetry channel: the kernel
hands the firmware a buffer and the firmware fills it with telemetry
data (temperatures, power draw, power limits, clocks, utilizations,
etc) on its own timer. This commit vendors the ABI needed to use it
from the 570.144 tag of NVIDIA's open-gpu-kernel-modules.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h =
b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
> new file mode 100644
> index 0000000000000..9f1099a064301
> --- /dev/null
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
[ ... ]
> +typedef enum RUSD_TEMPERATURE_TYPE {
> +   RUSD_TEMPERATURE_TYPE_GPU,
> +   RUSD_TEMPERATURE_TYPE_HBM,
> +   RUSD_TEMPERATURE_TYPE_MAX
> +} RUSD_TEMPERATURE_TYPE;
> +
> +typedef struct RUSD_TEMPERATURE {
> +   volatile NvU64 lastModifiedTimestamp;
> +   NvTemp temperature;
> +} RUSD_TEMPERATURE;

[Severity: High]
Does this struct lack explicit padding, causing an ABI mismatch on 32-bit
platforms?

On 32-bit platforms (like x86-32), NvU64 has a 4-byte natural alignment,
making sizeof(RUSD_TEMPERATURE) exactly 12 bytes. On 64-bit systems and the
64-bit RISC-V GSP firmware, it requires padding and is 16 bytes.

[ ... ]
> +typedef struct NV00DE_SHARED_DATA {
> +   NV_DECLARE_ALIGNED(RUSD_BAR1_MEMORY_INFO bar1MemoryInfo, 8);

[Severity: Medium]
Will these fields be read incorrectly on big-endian architectures?

The shared data structures define fields with native integer types (NvU32,
NvU64) instead of explicit little-endian types (__le32, __le64). On a
big-endian host, the natively-read values will be byte-swapped versions of
the little-endian data written by the RISC-V GSP firmware.

[ ... ]
> +   // POLL_POWER
> +   // Module Limit is not supported on Ampere/Hopper
> +   NV_DECLARE_ALIGNED(RUSD_POWER_LIMITS powerLimitGpu, 8);
> +
> +   // POLL_THERMAL
> +   NV_DECLARE_ALIGNED(RUSD_TEMPERATURE temperatures[RUSD_TEMPERATURE_TYP=
E_MAX], 8);

[Severity: High]
Will the missing padding in RUSD_TEMPERATURE cause memory corruption here?

Because temperatures is declared as an array of 3 elements, the array occup=
ies
36 bytes on 32-bit versus 48 bytes on 64-bit. This difference in array stri=
de
shifts all subsequent fields by 8 bytes.

The kernel will allocate a smaller buffer than the firmware expects, causing
the 64-bit firmware to write past the end of the allocation when writing
telemetry data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714211429.2383=
55-1-mohamedahmedegypt2001@gmail.com?part=3D1
