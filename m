Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80424606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQkI5z2W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EFF10E5A0;
	Tue, 24 Nov 2026 21:34:48 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C6210E5CE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:34:43 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so43809195e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795556081; x=1796160881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PyyQwKmFe9iM2Cp50Hb1UepVeU0i/+dyb3nhRaBGF3U=;
 b=qQkI5z2WvQaleb3qgq9ltd1CIj8V2hvbMrX4p+XcyPOuLwbzQTWYJQkfdyO7o77D+e
 C7eLE4InAZ2O7X7vXMCFqYnW9vLkPk5QeRToCt0e5IoGauFlESYYdC6tugM6USou6AEV
 fkxxB3/I4gts7xto/7jAAieljsfp+4uMf8JGsnQm4Jgjymg+HcdGYOuQmK4ahWpB/a3s
 vKKNwGPIhCNPhfwNDShZxjuWTWdBv+cPSxbU9tDVQor5ORH6xPgWQx7ZGkbWFXq2vu/H
 HihdVnzZLcfGS+PX4QSQKuQ5Fy0d2K29SrKqGFqg3YI+zBCfg7KgRMkfxfXCqwhLlCN0
 0nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795556081; x=1796160881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PyyQwKmFe9iM2Cp50Hb1UepVeU0i/+dyb3nhRaBGF3U=;
 b=uHGGt0vei9anKK38NvTxWaPqI1mpCiCpDaOrX8XvLxxilKp70/DW8Bo1WPKZVYDz83
 RPzWAxr9UAfXoPoYcO9x41N0drX+EeEhNpMdK6i6BI1Fn8EopNQYh5CiQnQU+IEgmmIw
 DdDSZ6iSaZM+GMpgsdcDAhxc6xuv/Dnrj2p4dGwLvFYQ40cmE3KeyQA9BYVAeWH4KUye
 xGaedapI4bvn5Rg4TgDfTSfvVD5pZSS6KqdN7K20qagbDBgs1SK34qhoig6kQFosntBG
 PYT2hVcyJZggQxbmcQJZEA8Xk3Qc2z8FOn+KFCfmTmHGDaRvbaNKRvNHatmXt9+WzA7S
 TP3g==
X-Forwarded-Encrypted: i=1;
 AL+hErF3DBKKq9Zpw5cz31OAXmFEdTfoksjUCORYiYPKASLQdAAxO21fOhRsZAa3s77jzZijnSrSEMcs6E8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8XVM4YhAMOWvt3Yd01HPmCMoyIXnqdywlyXVO/93udAqroD/Wz
 IA35UaE+aekp1wUXaCrtcJMDkEb77HlduOWbznkvFWMUw9snmo23ew7s
X-Gm-Gg: AZFdTZcpqDk7m0KSFLV5G5AB6E3WPl+i8ftA52+QrSe6Uy5fPej3YKKjRYlF7Rm33kC
 7p6R6rNEYxBx6JJZsoxJSGzbz9dDOEU66e2z+iHhCk3djN4dmk+E4IzDOueE43lFcGd4o4VHZ8r
 eVRkgP0rMUjyWrnyhFrMILhXd2jJHNX97qXU4Np09GDAUiEOGeVZJTcAE5v4Op5wb6EV94L2f++
 lLBXMEv3mFDPgbSoPqetCdtDKgQPhRUh+06gZiDsl35CApaZ8Op2eExNajWuVAHchduita8JHCx
 qLKNY6FIYLjVHPMlYjA+OWa4jF8jL8qu5iNlcjT3kQXYLk0cTD/78qZXbkl9snN/wystEDhzwwa
 tCNO1AO6y0lnR+Ptqeso1+9UzQKP9YAKTeqWY6Y+kajK8TwN8V8RRnmA4K9VGQahTjBSerPflQs
 sGPsXyuB6aXx268hHdXpaWfDbuZIuWRsfTWPpin6Kjca83Cr0fDGn1ojzffHQSfUZz1ACZzOdyp
 wc/nMRJufx5382TlzwQDiQ356RmT52LkYQegcCIQzzU8SxAuA+yI+VTJTHrbyX4kIAgvNAXKsj0
 e5QRkvKiG0fvNpqdV58vi+ZhxAwuDg==
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr328897525e9.19.1795556081300; 
 Tue, 24 Nov 2026 13:34:41 -0800 (PST)
Received: from fra-x8664 ([151.83.244.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm403974515e9.2.2026.11.24.13.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 13:34:40 -0800 (PST)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ilia Mirkin <imirkin@alum.mit.edu>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/devinit/gf100-: fix POST being skipped on GPUs
 without display
Date: Tue, 24 Nov 2026 22:34:30 +0100
Message-ID: <20261124213430.9525-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid
double-running vbios scripts") skips devinit if VGA CRTC register 0x00
or 0x1a is non-zero, unless the display engine is disabled.  It detects
the latter from the return value of nvkm_devinit_disable(), which is
always 0: the strapped-off engines are removed with
nvkm_subdev_disable() instead.  So the VGA registers are always read.

On a GM108 (GeForce 940MX: no display engine, not POSTed by the
firmware) those reads fault and return 0x13.  devinit is skipped, the
GPU is used uninitialised and the machine panics at boot:

  nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 00000000001a1000 engine 05 [BAR2] client 08 [HUB/HOST_CPU_NB] reason 04 [UNBOUND_INST_BLOCK] on channel -1
  mce: CPUs not responding to MCE broadcast (may include false positives): 1,3
  Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

Check device->disp instead, once nvkm_devinit_disable() has removed the
disabled engines, like nv50_devinit_preinit() does.

Fixes: 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---

Notes:
    v7.3.4 boots on this machine; v7.3.5, which has the stable backport
    (992f7f5f34f8), panics.  Tested on v7.3.5: with this patch the GM108 is
    POSTed again at probe and on runtime resume.  Not tested on a board
    that has a display engine.
    
    Read at preinit on this board: 0x2240c = 0x00000000, CR00 = CR1A = 0x13,
    0x021c04 = 0x00000001 (display strapped off).
    
    The regression was analysed and the patch drafted with an AI coding
    assistant (Claude Code); I tested it on the hardware above.

 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
index 186e09ea0c..b256404c24 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
@@ -107,12 +107,12 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
 	 * VBIOS multiple times may have detrimental effects.
 	 */
 	if (base->post) {
-		u64 disable = nvkm_devinit_disable(base);
+		nvkm_devinit_disable(base);
 		/* magic to detect whether or not x86 vbios code has
 		 * executed the devinit scripts to initialise the
 		 * board. only works if there's a display engine.
 		 */
-		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
+		if (device->disp) {
 			if (nvkm_rdvgac(device, 0, 0x00) ||
 			    nvkm_rdvgac(device, 0, 0x1a)) {
 				base->post = false;

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.56.1

