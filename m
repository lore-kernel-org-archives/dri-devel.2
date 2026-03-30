Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC121061B15
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85A510E66E;
	Mon, 30 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdPZ0hKB";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DCF10E66E
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:18:25 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso363630c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774894705; cv=none;
 d=google.com; s=arc-20240605;
 b=Vc5F1HQFRgZy9gDqJbNpYCA+JIF1FcdGWSK625+BDKmljlDaz7kYYINN1m5jlmgncb
 9hTEGnawp+vgnf2j+0KYGHh3aY1bFu38MFMTYevphux37e7v84ai5nN8bTSD0UhzmuZ4
 Q0Cg+siiOGIPNSF6YLxu0ue9dCPUOiY/j8GP0b5V8Y4mjTPTCL1OUnL8nXll+4NNIGuy
 oJLoX8isLik42Y0kp/4+j0/wShEc+eKW7liqNDd5ztho7FDLK+2n8NMQu99hwLYWSRj2
 M7rnnmmXWTy29+48QW/px0uHu8VtJ5kXx9J4LgstlYSC4J2xj0sRMPpo+h3QwcXVY14g
 z7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uiYX3xfwqul1X1K5+MQ8+sq6/6bgawtwqXSPeYTcwxY=;
 fh=BRr0uRo96aNkGG68FO9cK6GqIOZM7biCYplrfT0l7sQ=;
 b=J83hFv/kViUBWWIRyFT/iUT4MW2pDvbuBaWn9V3L+2Yz56kFdhDmQTyXEYWwAJhN0/
 mxX9IKKHMx1cvdp1mp+qp/pXxxbspdFg5TsBQ8+HKwjEa0QsYobZ5Ua0y0r3e4O7/rEx
 DA0XtiAEYwLJQBcH57Fk3zRumPHp0EbeePFgEOdUJjJs2hJC3lsvpyAfHdEBm+BYc3+4
 aW+VUJHezrYtfIzEW+23Xw4OrulweX7I1IpZExYFbzZOg8cyex4Zy7zQuK6ntfvJEEVQ
 wHskvko0ExAA82X1gzZilyW0i+/qILU1KjcPSu7qUDBeKnqXsdweVWYSK1pZTuEqqXKs
 WrvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774894705; x=1775499505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiYX3xfwqul1X1K5+MQ8+sq6/6bgawtwqXSPeYTcwxY=;
 b=BdPZ0hKBFS9lZ4vgWRcyinuvJWrec2Yy0wXc6wJEX+6YifxrwsVo90akdpzOdQD5Dg
 oqMQeRZJyUP0sbNFJCXR4j9IBjTcd15nALwv4lJ5XNLygYMkvDBuY/Rd0BoLfli5VAfs
 xTUVxCopP30eDrWXYPhylyp8SpffLHZ6Yt3mBuBt7vPiKSW8UcEvirBzHicA0axBU6Jd
 pYoMDMDMLieoQ/dN/8GjCnHxf9kxDIrNEFKI85E+0tFeclcvI0ZJ49Z0mIckpbe5xz+/
 E7PnHTablRkgJUNSLX6e+vINeN0wkGw7aToJmkKa6yzrHSM2e9n5c6kxsVO1pwEHOmIS
 WlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774894705; x=1775499505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uiYX3xfwqul1X1K5+MQ8+sq6/6bgawtwqXSPeYTcwxY=;
 b=euVpRkmxg6wuHonluOQb3JYEADVkK6hfe7xU2J7bXG1F7tDsSVgIT1nKLMYMbOAxZD
 87A+aVEKMl+fx4bNNHv0zCheO0CQv/XZp1BD+UABPyRz9eA+d6aVsDSCtjhWkESkuEJf
 k1OKe2M2sqXEmPFJ47MECVYofTHt99ATTBQsAh1ef5LlHn3zAe1MRwcR5UcY6ufzXwXt
 ATdngO9mj39ti/n+AxytCWxtyiPjjnPhW2Wy2qqm+qpL9AiwuS/fODIpSK+Hz/9mzh62
 7Fur5QyDRiMuDqL4zgLB8DdlTs/0QlqOJ6fesQ3F7gKQzt6dz5dmhLFxN+S0vdlB3q0p
 /B0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzPtR9LtGuInHbxEmiDe4qzeB4GKc08O+Qs4eNV+4/OmHTISl61o1Xm5v+lkPkNsoTmCuP/svAmOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx0huQ80z7dktj1Q97OFlonc6Ap+s86vw1sQKDVflKytsVh9CY
 xyV2D5/rknsrLb6TLEOA3Y8k10AxuKsu1GWZaV8USXANDOID/13hs+cZ6cifiSksV3+uU6Pm6w2
 9jXL2bzSzHcSJHVa07nNFD7Lq+0qLnvM=
X-Gm-Gg: ATEYQzwzCTYDJRsyEh2/8rAzem9urSE76ZA+g/i6+gjtSHL1pgx8NTSU2sQu5UCeIVv
 N2ypRqPDKZp3grftaMQZy5ngCcm+ASTxn4abeicN6e4xfD8nQiBrPDqxkohvynIRj482AV5jv0/
 L+RF50zTbHde0EInTArNMRtXA/e0N0qCaQX3r/ib3ixBjVMZmqcQO16I5+ol1d5OqZDw0VaxsWj
 6rItOIm4cFYr4pf/Lg72Jpv4POSPySfbUfBDE+mUK6GE57js8uISeyqMRR0rQdncUQyVJuOkiQg
 GyyzOoWUEKwF4tjZ4TmbTf/sWAx7NXFVCrLHjn3w2hmbJZuC8eHVC0+j+xNJzUwWO01tMw==
X-Received: by 2002:a05:7022:e2a:b0:12a:6ab6:8a64 with SMTP id
 a92af1059eb24-12ab276b704mr3506578c88.0.1774894704790; Mon, 30 Mar 2026
 11:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260330134700.GBacp-1CFyWlXo7LcZ@fat_crate.local>
In-Reply-To: <20260330134700.GBacp-1CFyWlXo7LcZ@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Mar 2026 14:18:13 -0400
X-Gm-Features: AQROBzBKlZPVN8HLWLgvsbTDAfSBAxnnzIN_2WXl97wY0eZvWgmrIMOBu0No5bs
Message-ID: <CADnq5_N+PSqi7Lf2Y1ZnKvWyy8jST4RZkCYAjFB7tdUc-ZkswA@mail.gmail.com>
Subject: Re: 7.0-rc6: amdgpu: BUG: sleeping function called from invalid
 context at ./include/linux/sched/mm.h:323
To: Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 30, 2026 at 11:39=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> Hi folks,
>
> this is on a Zen2 laptop:
>
> [   13.819253] amdgpu: Virtual CRAT table created for CPU
> [   13.821152] amdgpu: Topology: Add CPU node
> [   13.823395] amdgpu 0000:06:00.0: enabling device (0006 -> 0007)
> [   13.824714] amdgpu 0000:06:00.0: initializing kernel modesetting (RENO=
IR 0x1002:0x1636 0x17AA:0x5099 0xD1).
> [   13.830092] amdgpu 0000:06:00.0: register mmio base: 0xFD300000
> [   13.830925] amdgpu 0000:06:00.0: register mmio size: 524288
> [   13.856868] amdgpu 0000:06:00.0: detected ip block number 0 <common_v2=
_0_0> (soc15_common)
> [   13.857744] amdgpu 0000:06:00.0: detected ip block number 1 <gmc_v9_0_=
0> (gmc_v9_0)
> [   13.858510] amdgpu 0000:06:00.0: detected ip block number 2 <ih_v4_0_0=
> (vega10_ih)
> [   13.859299] amdgpu 0000:06:00.0: detected ip block number 3 <psp_v12_0=
_0> (psp)
> [   13.860037] amdgpu 0000:06:00.0: detected ip block number 4 <smu_v12_0=
_0> (smu)
> [   13.860763] amdgpu 0000:06:00.0: detected ip block number 5 <dce_v1_0_=
0> (dm)
> [   13.861484] amdgpu 0000:06:00.0: detected ip block number 6 <gfx_v9_0_=
0> (gfx_v9_0)
> [   13.862213] amdgpu 0000:06:00.0: detected ip block number 7 <sdma_v4_0=
_0> (sdma_v4_0)
> [   13.862988] amdgpu 0000:06:00.0: detected ip block number 8 <vcn_v2_0_=
0> (vcn_v2_0)
> [   13.863704] amdgpu 0000:06:00.0: detected ip block number 9 <jpeg_v2_0=
_0> (jpeg_v2_0)
> [   13.864450] amdgpu 0000:06:00.0: Fetched VBIOS from VFCT
> [   13.865144] amdgpu 0000:06:00.0: [drm] ATOM BIOS: 113-RENOIR-026
> [   13.894122] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
> [   13.895053] amdgpu 0000:06:00.0: Trusted Memory Zone (TMZ) feature ena=
bled
> [   13.896463] amdgpu 0000:06:00.0: vm size is 262144 GB, 4 levels, block=
 size is 9-bit, fragment size is 9-bit
> [   13.897230] amdgpu 0000:06:00.0: VRAM: 512M 0x000000F400000000 - 0x000=
000F41FFFFFFF (512M used)
> [   13.897939] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 - 0x00=
0000003FFFFFFF
> [   13.898716] amdgpu 0000:06:00.0: [drm] Detected VRAM RAM=3D512M, BAR=
=3D512M
> [   13.899407] amdgpu 0000:06:00.0: [drm] RAM width 128bits DDR4
> [   13.908463] amdgpu 0000:06:00.0:  512M of VRAM memory ready
> [   13.909211] amdgpu 0000:06:00.0:  7569M of GTT memory ready.
> [   13.910896] amdgpu 0000:06:00.0: [drm] GART: num cpu pages 262144, num=
 gpu pages 262144
> [   13.912527] amdgpu 0000:06:00.0: [drm] PCIE GART of 1024M enabled.
> [   13.913187] amdgpu 0000:06:00.0: [drm] PTB located at 0x000000F41FC000=
00
> [   13.917136] amdgpu 0000:06:00.0: [drm] Loading DMUB firmware via PSP: =
version=3D0x01010028
> [   13.921080] amdgpu 0000:06:00.0: [VCN instance 0] Found VCN firmware V=
ersion ENC: 1.21 DEC: 6 VEP: 0 Revision: 0
> [   13.925929] amdgpu 0000:06:00.0: reserve 0x400000 from 0xf41f800000 fo=
r PSP TMR
> [   14.013599] amdgpu 0000:06:00.0: RAS: optional ras ta ucode is not ava=
ilable
> [   14.024160] amdgpu 0000:06:00.0: RAP: optional rap ta ucode is not ava=
ilable
> [   14.029775] amdgpu 0000:06:00.0: psp gfx command LOAD_TA(0x1) failed a=
nd response status is (0x7)
> [   14.031696] amdgpu 0000:06:00.0: SMU is initialized successfully!
> [   14.034094] amdgpu 0000:06:00.0: [drm] Display Core v3.2.369 initializ=
ed on DCN 2.1
> [   14.035077] amdgpu 0000:06:00.0: [drm] DP-HDMI FRL PCON supported
> [   14.036454] amdgpu 0000:06:00.0: [drm] DMUB hardware initialized: vers=
ion=3D0x01010028
> [   14.071376] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops amdgpu=
_dm_audio_component_bind_ops [amdgpu])
> [   14.251260] amdgpu 0000:06:00.0: [drm] Using ACPI provided EDID for eD=
P-1
> [   14.262586] amdgpu 0000:06:00.0: kiq ring mec 2 pipe 1 q 0
> [   14.278743] kfd kfd: Allocated 3969056 bytes on gart
> [   14.279639] kfd kfd: Total number of KFD nodes to be created: 1
> [   14.282841] amdgpu: Virtual CRAT table created for GPU
> [   14.287260] amdgpu: Topology: Add GPU node [0x1002:0x1636]
> [   14.288300] kfd kfd: added device 1002:1636
> [   14.289236] amdgpu 0000:06:00.0: SE 1, SH per SE 1, CU per SH 8, activ=
e_cu_number 7
> [   14.290147] amdgpu 0000:06:00.0: ring gfx uses VM inv eng 0 on hub 0
> [   14.290945] amdgpu 0000:06:00.0: ring comp_1.0.0 uses VM inv eng 1 on =
hub 0
> [   14.291677] amdgpu 0000:06:00.0: ring comp_1.1.0 uses VM inv eng 4 on =
hub 0
> [   14.292391] amdgpu 0000:06:00.0: ring comp_1.2.0 uses VM inv eng 5 on =
hub 0
> [   14.293108] amdgpu 0000:06:00.0: ring comp_1.3.0 uses VM inv eng 6 on =
hub 0
> [   14.293806] amdgpu 0000:06:00.0: ring comp_1.0.1 uses VM inv eng 7 on =
hub 0
> [   14.294501] amdgpu 0000:06:00.0: ring comp_1.1.1 uses VM inv eng 8 on =
hub 0
> [   14.295243] amdgpu 0000:06:00.0: ring comp_1.2.1 uses VM inv eng 9 on =
hub 0
> [   14.295940] amdgpu 0000:06:00.0: ring comp_1.3.1 uses VM inv eng 10 on=
 hub 0
> [   14.296631] amdgpu 0000:06:00.0: ring kiq_0.2.1.0 uses VM inv eng 11 o=
n hub 0
> [   14.297326] amdgpu 0000:06:00.0: ring sdma0 uses VM inv eng 0 on hub 8
> [   14.298022] amdgpu 0000:06:00.0: ring vcn_dec uses VM inv eng 1 on hub=
 8
> [   14.298767] amdgpu 0000:06:00.0: ring vcn_enc0 uses VM inv eng 4 on hu=
b 8
> [   14.299471] amdgpu 0000:06:00.0: ring vcn_enc1 uses VM inv eng 5 on hu=
b 8
> [   14.300173] amdgpu 0000:06:00.0: ring jpeg_dec uses VM inv eng 6 on hu=
b 8
> [   14.308567] amdgpu 0000:06:00.0: Runtime PM not available
> [   14.317036] amdgpu 0000:06:00.0: [drm] Using custom brightness curve
> [   14.325476] [drm] Initialized amdgpu 3.64.0 for 0000:06:00.0 on minor =
2
> [   14.332003] BUG: sleeping function called from invalid context at ./in=
clude/linux/sched/mm.h:323
> [   14.333000] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 415=
, name: (udev-worker)
> [   14.333733] preempt_count: 1, expected: 0
> [   14.334407] RCU nest depth: 0, expected: 0
> [   14.335152] 2 locks held by (udev-worker)/415:
> [   14.335836]  #0: ffff888102509200 (&dev->mutex){....}-{4:4}, at: __dri=
ver_attach+0xaf/0x1f0
> [   14.336613]  #1: ffffffffa1465998 (amdgpu_pasid_idr_lock){+.+.}-{3:3},=
 at: amdgpu_pasid_alloc+0x1d/0x110 [amdgpu]

Should be fixed with:
https://patchwork.freedesktop.org/patch/713383/

Alex

> [   14.338343] Preemption disabled at:
> [   14.338351] [<0000000000000000>] 0x0
> [   14.339821] CPU: 2 UID: 0 PID: 415 Comm: (udev-worker) Not tainted 7.0=
.0-rc6 #1 PREEMPT(full)
> [   14.339830] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W=
(1.27 ) 10/20/2020
> [   14.339834] Call Trace:
> [   14.339841]  <TASK>
> [   14.339847]  dump_stack_lvl+0x57/0x80
> [   14.339869]  __might_resched.cold+0xe5/0x120
> [   14.339891]  kmem_cache_alloc_noprof+0x296/0x580
> [   14.339920]  radix_tree_node_alloc.constprop.0+0x44/0xf0
> [   14.339944]  idr_get_free+0x237/0x2e0
> [   14.339972]  idr_alloc_u32+0x6e/0xe0
> [   14.339987]  ? lock_acquire+0xdb/0x310
> [   14.340012]  idr_alloc_cyclic+0x56/0xc0
> [   14.340041]  amdgpu_pasid_alloc+0x41/0x110 [amdgpu]
> [   14.340913]  amdgpu_driver_open_kms+0x9b/0x320 [amdgpu]
> [   14.341661]  ? srso_return_thunk+0x5/0x5f
> [   14.341670]  ? lock_acquire+0xcb/0x310
> [   14.341684]  ? srso_return_thunk+0x5/0x5f
> [   14.341690]  ? find_held_lock+0x2b/0x80
> [   14.341701]  ? kfree+0x262/0x420
> [   14.341711]  ? kfree+0x262/0x420
> [   14.341718]  ? srso_return_thunk+0x5/0x5f
> [   14.341725]  ? lock_release+0x170/0x2d0
> [   14.341765]  drm_file_alloc+0x206/0x2d0
> [   14.341787]  drm_client_init+0x7b/0x110
> [   14.341819]  amdgpu_amdkfd_drm_client_create+0x56/0x70 [amdgpu]
> [   14.342778]  amdgpu_pci_probe+0x2a0/0x450 [amdgpu]
> [   14.343115]  local_pci_probe+0x41/0x90
> [   14.343115]  pci_call_probe+0x55/0x2e0
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  ? _raw_spin_unlock+0x29/0x50
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  ? pci_match_device+0xf8/0x120
> [   14.343115]  pci_device_probe+0x91/0x140
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  really_probe+0xde/0x380
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  ? __pfx___driver_attach+0x10/0x10
> [   14.343115]  __driver_probe_device+0x78/0x120
> [   14.343115]  driver_probe_device+0x1f/0xa0
> [   14.343115]  __driver_attach+0xba/0x1f0
> [   14.343115]  bus_for_each_dev+0x7c/0xd0
> [   14.343115]  bus_add_driver+0x11e/0x200
> [   14.343115]  driver_register+0x6e/0xc0
> [   14.343115]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   14.343115]  do_one_initcall+0x58/0x3c0
> [   14.343115]  ? do_init_module+0x22/0x220
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  ? rcu_is_watching+0xd/0x40
> [   14.343115]  ? srso_return_thunk+0x5/0x5f
> [   14.343115]  ? __kmalloc_cache_noprof+0x3a9/0x580
> [   14.343115]  do_init_module+0x60/0x220
> [   14.343115]  init_module_from_file+0xc8/0xe0
> [   14.343115]  idempotent_init_module+0x104/0x300
> [   14.343115]  ? xen_error_entry+0x30/0x60
> [   14.343115]  __x64_sys_finit_module+0x6d/0xe0
> [   14.343115]  ? do_syscall_64+0x28/0x510
> [   14.343115]  do_syscall_64+0xc2/0x510
> [   14.343115]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   14.343115] RIP: 0033:0x7fad2ecbbc29
> [   14.343115] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 51 0d 00 f7 d8 64 89 01 48
> [   14.343115] RSP: 002b:00007ffe23a10fa8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [   14.343115] RAX: ffffffffffffffda RBX: 00005648c5acf5c0 RCX: 00007fad2=
ecbbc29
> [   14.343115] RDX: 0000000000000000 RSI: 00007fad2e9f844d RDI: 000000000=
0000025
> [   14.343115] RBP: 0000000000000000 R08: 0000000000000000 R09: 00005648c=
59d8fe0
> [   14.343115] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fad2=
e9f844d
> [   14.343115] R13: 0000000000020000 R14: 00005648c5ace500 R15: 000000000=
0000000
> [   14.343115]  </TASK>
> [   14.398663] fbcon: amdgpudrmfb (fb1) is primary device
> [   14.398682] fbcon: Remapping primary device, fb1, to tty 1-63
> [   14.399847] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not =
needed
> [   21.521405] amdgpu 0000:06:00.0: [drm] fb1: amdgpudrmfb frame buffer d=
evice
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
