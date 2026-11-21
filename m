Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4494606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6z0+5DL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DAE10E606;
	Sun, 22 Nov 2026 17:13:43 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748BB10E9C2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:14:01 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5ee2ad94713so1278657e0c.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795266840; x=1795871640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3uk1V2g2BrgRRimIAVfUYX/6Cv+bp9NcizxCwFi/VHA=;
 b=D6z0+5DLseFJil6tzOph1gkY+Rqg6aSVA+DcBtXtxqae1bTqRSQ7D4OUR0LzAAleGX
 dbHGjEytAgf2UDku3IUHXowjZScHu49fsrjxv2n+s+XuwW86jk+KNR4JuXjUnzVr6A+H
 BIWJD97TNmmI3+pf0HX6gtZxf4s7mlYGKQsaI6FKa5gqcjQXVlqqexBQnh9k6PiQbdW2
 Kdfqq+n7i0jcjQWBDOY7eaGTCDljBaQBi8LLvxvkPJNtA1uBraxInmFgY3ylHcwz/9Mv
 2WSdPO13dJc7XRslJumeK4wNhv6MZMrek/rsP5a6NACB0Lo2Gfs6Jj2KZrFx6fiDlfd+
 1d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795266840; x=1795871640;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3uk1V2g2BrgRRimIAVfUYX/6Cv+bp9NcizxCwFi/VHA=;
 b=0P88b0+AeZT62Q1dezBuOOsu1UfB+6g1YH3jDK1jv8XSqkh6W6Gqf6WdClDIRyrdGf
 Ppw+TX65/Q29bCCGJkvq9lr6x1AkEa5FglCwjMh/8+roX/iLtPlnvxFcxoZbN6pCv4Zq
 ZxC3iveYHep06y5dYwj08KEg2BlVGRUZp2vYWjgeqjhyP54TX+0Jbrb36iNnNQe4fULg
 ODWL3XWHcTpZUPNBh2hQV6pBIBeWClub7QjYuxNUlcouHTEHuZVT+NQojMFjYsTh6s8E
 ZSw5a7rO0GXwmR0165bZgyXShrtjI+zJQ+tQbRe6vnve5E28G5E/CT4HHai6KxlcGE+A
 IBjA==
X-Forwarded-Encrypted: i=1;
 AL+hErHJV42e6gayIMoNFJdUMOKoFhHtlX1WP+jEgt2qGgUiME3+yHJr/y5dk8lqL1HuY8w1diVpO/TZoGY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qqwiJ0TVUyeYlkVSOarhIzl6IewAyCIz6SrFslKqe7BNz9+71
 aWAZ3ue+8Ctaeo3oGVHVCqSVElunWgRPWQOTzxFirRq2skfz8/c/Wk1B
X-Gm-Gg: AZFdTZcahKboZRkMGER0y9EroTw4ueZw/D026WAhUpQkUDH7LSNSbRQEMH1oRTtxnBb
 Mm0kMq2KvoeH+ZuzLYBomohDZgV/Q7HlboTKq+HFdcxdOjFdALMxJkO4ouezaFxctVvBusZBQQw
 Xy7CQGnSomXTKwXKrGLSc+0ZqicSq1ul8ZwJoaerqIYQ2HuqxZeVT8sugvNoZWYoMrLor9nWlon
 99Sk1BDXNOHtN8BnKqhvWXEqErQCNSoA4m8mJYQVM442wLT73ifSHfo20+BFtniTM7DMKo4bWWh
 vWI0JkZD2oF1Aw33Wi2L2AiCdsUoj/rCN0bxaztx4xeyCcWGFDtbf+RZ6MI8yuGbxpo5ZFC85WN
 ukdyhH6nohHJVraYJkWvRo2WWrIBVfCHfPXkjSfwY2WJnd2TRi3uhjstzRgj/7t9RBaiCtGLDv7
 MfdWdSEuEb4N0jXCuBNpMExptDR1IxMKipIYCz1KxQilAGN+DUAbg6TANMtBtjPS9F1biKTL1qj
 fxqx7TzKABCMr0zQvygcjDnI4Yvw045wwnpjw9mhwsicB801+n8270DJ4zABIqE7fYuhT8XCll8
 DVBxY641fzGM0zV0mhmq7DxFDjLY4HFAICrdn2SsuIxclVg=
X-Received: by 2002:a05:6122:4201:b0:5ee:a81:e77 with SMTP id
 71dfb90a1353d-5ee8af0e023mr2950746e0c.6.1795266840149; 
 Sat, 21 Nov 2026 05:14:00 -0800 (PST)
Received: from localhost ([2804:14d:5cd5:542e::1a7f])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dfc0b22sm5702260241.6.2026.11.21.05.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 05:13:59 -0800 (PST)
From: "R. V. Lobato" <vieira.lobato@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 regressions@lists.linux.dev
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Ilia Mirkin <imirkin@alum.mit.edu>,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] nouveau: GM108 hangs at boot since
 "drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts"
 (6.18.64)
Date: Sat, 21 Nov 2026 10:13:50 -0300
Message-ID: <20261121101350.bab69dff11a2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

The 6.18.64 backport 15465d681517 ("drm/nouveau/devinit/gf100-: try
to avoid double-running vbios scripts", upstream 2139cb633d48, review
patch 426/686 <20261113153835.372076643@linuxfoundation.org>) breaks
nouveau on my GM108 laptop GPU. The machine hangs during boot.
6.18.63 works. Reverting only the gf100.c hunk of this commit on top
of 6.18.64 fixes it.

Hardware: HP Spectre x360 15-bl0XX, BIOS F.04, Intel HD 620 (i915,
drives the panel) + NVIDIA GM108M [GeForce 940MX] [10de:134d], no
display engine, runtime PM enabled.

On 6.18.64 the VRAM size is garbage and the boot stops shortly after:

  nouveau 0000:01:00.0: NVIDIA GM108 (1180d0a2)
  nouveau 0000:01:00.0: bios: version 82.08.62.00.15
  nouveau 0000:01:00.0: fb: -1159778304 MiB GDDR5
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 6013d4 [ PRIVRING ]
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 10f65c [ PRIVRING ]
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 17e280 [ PRIVRING ]
  (no "drm: VRAM", no "Initialized nouveau"; the system hangs)

On 6.18.63 the same machine prints "fb: 2048 MiB GDDR5" and nouveau
initializes normally.

My reading of the cause: the new code in gf100_devinit_preinit() runs
the VGA CRTC check only when

  !(nvkm_devinit_disable(base) & (1ULL << NVKM_ENGINE_DISP))

The guard expects nvkm_devinit_disable() to return a mask of disabled
engines. In 6.18.64 it calls the void ->disable() hook, which disables
subdevs with nvkm_subdev_disable(), and then always returns 0. So the
guard is always true, also on boards without a display engine. On
GM108 the VGA CRTC reads hit the PRIVRING fault at 0x6013d4 and, I
infer, return a nonzero value (I did not log it), so post is set to
false, the VBIOS init scripts never run, and the memory controller is
left uninitialized.

nouveau.config=NvForcePost=1 lets the machine boot, but only fixes the
first init, because force_post is cleared after the first preinit.
On every runtime resume of the GPU the check skips devinit again:

  [   35.770421] nouveau 0000:01:00.0: Enabling HDA controller
  [   35.805652] nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000120000 engine 05 [BAR2] client 08 [HUB/HOST_CPU_NB] reason 02 [PTE] on channel -1 [007fd38000 unknown]
  [   35.806084] nouveau 0000:01:00.0: fifo: SCHED_ERROR 20 []
  ...
  [   75.453651] WARNING: CPU: 0 PID: 1081 at nvkm_runl_cgrp_get_cgid+0x79/0x110 [nouveau]

Counts per boot:

  kernel                        runtime resumes  fifo faults  SCHED_ERROR  WARNINGs
  6.18.63 (two boots)           25 / 30          0            0            0
  6.18.64 + NvForcePost=1       2                31           103381       39
  6.18.64 + gf100.c hunk revert 3                0            0            0

The revert I use (restores 6.18.63's gf100.c exactly):

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
@@ -27,7 +27,6 @@
 #include <subdev/bios/init.h>
 #include <subdev/bios/pll.h>
 #include <subdev/clk/pll.h>
-#include <subdev/vga.h>
 
 int
 gf100_devinit_pll_set(struct nvkm_devinit *init, u32 type, u32 freq)
@@ -100,25 +99,6 @@
 	 * can use it as a reliable way to know whether we should run devinit.
 	 */
 	base->post = ((nvkm_rd32(device, 0x2240c) & BIT(1)) == 0);
-
-	/*
-	 * However some VBIOS init sequences miss this bit. So fall back to
-	 * the nv50 method of checking if the bit is not set. Running the
-	 * VBIOS multiple times may have detrimental effects.
-	 */
-	if (base->post) {
-		u64 disable = nvkm_devinit_disable(base);
-		/* magic to detect whether or not x86 vbios code has
-		 * executed the devinit scripts to initialise the
-		 * board. only works if there's a display engine.
-		 */
-		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
-			if (nvkm_rdvgac(device, 0, 0x00) ||
-			    nvkm_rdvgac(device, 0, 0x1a)) {
-				base->post = false;
-			}
-		}
-	}
 }
 
 static const struct nvkm_devinit_func

A proper fix probably needs the guard to test whether the display
engine actually exists (for example nvkm_device_engine(device,
NVKM_ENGINE_DISP, 0) after ->disable() has run) instead of the return
value of nvkm_devinit_disable(). I have not tested that. I have only
tested 6.18.y; I can test patches on this machine.

#regzbot introduced: v6.18.63..v6.18.64

Thanks,
R. V. Lobato
