Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F5CD98EE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D237510E23D;
	Tue, 16 Jun 2026 17:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="2brQOGfK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUAUFrRd";
	dkim-atps=neutral
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D904F10E1ED
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 17:59:51 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 927631D00047;
 Tue, 16 Jun 2026 13:59:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 13:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1781632790; x=1781719190; bh=2K
 HqdAQvS6LYGq9BigDCPJUQFQ0+SZhsyyRYGHPKzOs=; b=2brQOGfKVLiD3sGEhd
 vKnJ4l7KqAvkKyO3MOFb2QXZ8xk0QVFLlEm+fDhOs7LbTXwGxxQ5DG9zraFAjcxA
 JJA6nUOf7tT1XO2spcUAuHkFXMmLlPe4LCZSrGHuj7uyM3CjPF5eZkffNQcvvUKY
 ZVWAmFwj8hwmFD6CHyXTGPO8prfx4MErwI+SqFpLHm3r1d2QLQ6ePIgWIUjoN14U
 T84Y9+LBNsCqrFYeEftqj+UpjPpu8kq7B0bDs1yUXqYh3pOqimuzguPniTMd9WUe
 HfXGiLTT3xK92CYLamkOipbazg6OUn5HSianHvGhmIbgPcCiXy/9yOJYmLqvPhLr
 WMhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1781632790; x=1781719190; bh=2KHqdAQvS6LYGq9BigDCPJUQFQ0+
 SZhsyyRYGHPKzOs=; b=FUAUFrRdw0df3ehoPtkWKF3HsqJMu6wO5Gx7zU2Ozm66
 0ppiJ74MUkz3xb1W23EfkUwop55cikaZCcsNNSGiSWQCrEX1Q36Flie77+cdAxEL
 nb995MqFHIr9hOT1WK6gcpqGv7pHg7VnrqjbloyA3sDBeRszi8Lai6pPkFotQb2G
 8QfHDI6nICXndz2jG1rSk+JNt9+8155etn8gydpsonMwTXFxuce5VUnqd0/+Xa/c
 lUOyJ7keoFfvaD6YEwIuLcDmuEavUTfbuTLVD9oDPhJuNbLqCLYWwbTuaAEEC/xQ
 1gDB4hAf8zljg6mCn1u5a278zx1JHrUdISOeByAOZQ==
X-ME-Sender: <xms:FY8xasdjQFturD8kGbWS1alJ_Xgjm3B1BOMNf527q-aeHoKJjNCaag>
 <xme:FY8xaqgPBe9amh7xJaz8bqCWAYsnVKsL5sasgCpXh5loN2TuFRheVv_XPZA2PmluI
 RFVcCwfHuMdsSyyRBvjYXEzIQOmlQZdtiUsrjm7suRHX-_O2ivTyg>
X-ME-Received: <xmr:FY8xavI8Dipt10N9OtJ5Ci-1ZNX_CnBXkDV1blQy7WRgW7l7F85vbTS1AXMAnkU5ytM0QjMh6l0WDV53uMwCq7_xtVIa>
X-ME-Proxy-Cause: dmFkZTFZzyQWraOnST6FuDBlHu3xHOEH2q3xdoju3GmHJ9O+ktDvIl7h/6KkwZA+sIw1K6
 tX+BvuEZo0yWeRvKtd1fUdkREWavinalVe9+ePjYvGL63Fz0KKTVFBCe47T8ru2qH5Uf74
 AEfJmsTCJS66cT/v46iyiovOmg/KjHn9wwBXq07BGa0ITIClrTYrDXVni51h3b4GYiLAtC
 wxaAZ/b0hHorrpP51lEQfpyd6FjzzYAyJRTm5wr2syUFR6Nyesl4p2mFxDz/+9BEgh0IID
 WOCd96YyJmBe3X4nW265gJBJpVvOjYom2yIcMhTBEPOtSnK26tM0F/TUJsIn7gO7BUBBTe
 TtA64UEAmph0guL9fnWq2kxZ1Z+OoOSegkGWd21PFa7RG7iXF1k6OmD+YQR9Tv5mCcZEre
 NTZk7GmvvkSNmQuUtrqt0Vy0A76O9E0DyuSra0TTtMeYqUUy7S9E3TcbE6ToEGk9v2Sq2f
 DkdO3HQiRwtSl7vhmrMrVgiV3Tt/yuw7bhYogqjsJJ7AoTQ0NbQfd7vfe6JzqYkGqhEXfb
 TyTJ4m2AhndT36/nLgwLR786nMoY1wIiQWglXjEY3geXQFM/SmfAeoFiKnAU6gKyoyonL2
 uNnINl4DrEJQF8xkI699Pev2P7LQw8m6rTuBaw4td6cELSlvNWy17WcAxPhg
X-ME-Proxy: <xmx:FY8xavEdLgccP0tQo3c23--KblonfH0GspMq_4om0I2hsdR8bql09Q>
 <xmx:FY8xat3hltiaP0yBysvLR7qoFZIVtVMnpRU3YC0h71C9JAB-1tckAw>
 <xmx:FY8xauyRjMfCk5Dwqm_0VJmX__YltLM2Q1siPLp7_2CRWLEnQkOJkw>
 <xmx:FY8xakjcQ3xj4ENwTFO1XrYuHjpEr7JuPdNq9lDP0Pec04q1lvlDGw>
 <xmx:Fo8xaroGMPGGJwMBuDMcsNBcm9L_KEqDsS6G_bWOrXTp6YwXPnbTMv4Q>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:59:49 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] arm64: dts: renesas: Describe GPU on D3
Date: Tue, 16 Jun 2026 19:58:33 +0200
Message-ID: <20260616175835.2109336-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello,

This series adds the needed bindings to operate the PowerVR GPU on R-Car
D3 SoC.

Together with the D3 clock changes [1] and a still OOT patch for the PVR
driver [2], I'm able to load firmware.

    powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_22.67.54.30_v1.fw
    powervr fd000000.gpu: [drm] FW version v1.0 (build 6889268 OS)
    powervr fd000000.gpu: [drm] Unsupported quirks in firmware image
    powervr fd000000.gpu: [drm] Unsupported enhancements in firmware image
    powervr fd000000.gpu: [drm] Unsupported features in firmware image
    [drm] Initialized powervr 1.0.0 for fd000000.gpu on minor 1

I can run vulkaninfo from mesa (need to add the driver to
pvr_drm_configs):

    $ PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=1 meson devenv -C builddir vulkaninfo --summary
    WARNING: powervr is not a conformant Vulkan implementation, testing use only.
    MESA: warning: Warning: The available RAM is below the minimum required by the Vulkan specification!
    MESA: warning: ../src/imagination/vulkan/pvr_border.c:117: FINISHME: Devices without tpu_border_colour_enhanced require entries for compressed formats to be stored in the table pre-compressed.
    ==========
    VULKANINFO
    ==========

    Vulkan Instance Version: 1.4.335


    Instance Extensions: count = 20
    -------------------------------
    VK_EXT_debug_report                    : extension revision 10
    VK_EXT_debug_utils                     : extension revision 2
    VK_EXT_headless_surface                : extension revision 1
    VK_EXT_surface_maintenance1            : extension revision 1
    VK_EXT_swapchain_colorspace            : extension revision 5
    VK_KHR_device_group_creation           : extension revision 1
    VK_KHR_display                         : extension revision 23
    VK_KHR_external_fence_capabilities     : extension revision 1
    VK_KHR_external_memory_capabilities    : extension revision 1
    VK_KHR_external_semaphore_capabilities : extension revision 1
    VK_KHR_get_display_properties2         : extension revision 1
    VK_KHR_get_physical_device_properties2 : extension revision 2
    VK_KHR_get_surface_capabilities2       : extension revision 1
    VK_KHR_portability_enumeration         : extension revision 1
    VK_KHR_surface                         : extension revision 25
    VK_KHR_surface_protected_capabilities  : extension revision 1
    VK_KHR_wayland_surface                 : extension revision 6
    VK_KHR_xcb_surface                     : extension revision 6
    VK_KHR_xlib_surface                    : extension revision 6
    VK_LUNARG_direct_driver_loading        : extension revision 1

    Instance Layers:
    ----------------

    Devices:
    ========
    GPU0:
	    apiVersion         = 1.2.330
	    driverVersion      = 25.99.99
	    vendorID           = 0x1010
	    deviceID           = 0x22054030
	    deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
	    deviceName         = PowerVR Rogue GE8300
	    driverID           = DRIVER_ID_IMAGINATION_OPEN_SOURCE_MESA
	    driverName         = Imagination open-source Mesa driver
	    driverInfo         = Mesa 26.0.0-devel (git-8fb0621f2d)
	    conformanceVersion = 1.3.8.4
	    deviceUUID         = 19031a08-e22f-9565-d78b-ddda8240380a
	    driverUUID         = 48685174-7bd0-6840-5716-9d00003566aa
    GPU1:
	    apiVersion         = 1.4.330
	    driverVersion      = 25.99.99
	    vendorID           = 0x10005
	    deviceID           = 0x0000
	    deviceType         = PHYSICAL_DEVICE_TYPE_CPU
	    deviceName         = llvmpipe (LLVM 21.1.4, 128 bits)
	    driverID           = DRIVER_ID_MESA_LLVMPIPE
	    driverName         = llvmpipe
	    driverInfo         = Mesa 26.0.0-devel (git-8fb0621f2d) (LLVM 21.1.4)
	    conformanceVersion = 1.3.1.1
	    deviceUUID         = 6d657361-3236-2e30-2e30-2d6465766500
	    driverUUID         = 6c6c766d-7069-7065-5555-494400000000

I can't run test Vulkan applications such as gears as the PVR driver do
not support all features need for GE8300, for example
simple_internal_parameter_format_v1, see [3].

1. https://lore.kernel.org/linux-renesas-soc/20260616175247.2104891-1-niklas.soderlund+renesas@ragnatech.se
2. https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/38211#note_3177232
3. https://gitlab.freedesktop.org/imagination/mesa/-/issues/13

Niklas Söderlund (2):
  dt-bindings: gpu: img,powervr-rogue: Document GE8300 GPU in Renesas
    R-Car D3
  arm64: dts: renesas: r8a77995: Add GE8300 GPU node

 .../bindings/gpu/img,powervr-rogue.yaml           | 14 ++++++++++----
 arch/arm64/boot/dts/renesas/r8a77995.dtsi         | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.54.0

