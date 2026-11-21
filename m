Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E2606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV26d+4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC97610E349;
	Sat, 21 Nov 2026 07:41:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4CE10E23C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:41:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E637F4605B;
 Sat, 21 Nov 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795246865;
 b=OsWdpC1H+IUymHXpfX/ZH4+6tKOMNHEb68Y73km8dzr5F4RVWQ541WG9t56MHxw+TRyV
 8s6NNlYoNY6CNLa4iUKRyPKqQO6vrZeupe6uzgqTT9gZATVBNi1rJQtO0T900jWCVr9td
 hEFamTPimSH5m4C7cH9JTMbG3RCqey9DCJhq9RNji2m77KQnbH6zzg0Zy8nax2aadXtp2
 qYv6w4WUesAjHCvhswqDVTb9ZL8XQjW4oPVek4kuuWWYMGS/JfItNGa3axRU4+fVSGefE
 si2X+dzH2bIxXN67g1b8fXaavFd5dKLkxTImQuagF296sN8fAVB4eQeIu5pYhW8ZJNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795246865;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=APjcjN7LNtjWX/4CCT5XFBMQqLR6Sx43Xbky9olpkZI=;
 b=u7qOxZWUQOkPURc5t0g9Wlvy8M+MErVwmOs8BkBzdPsLX39UdjoaOmMDIXw6s+wPfkDI
 rSBG/kLb+fvz9Q9XMOlYJN0F0EznSMogjd+z3VP3i1WP1I9EDnoEMFs/AIWa5tMLuNfB2
 q0RwY3cEd8dnaiH7sG1MPNVvT0cFwO1OgvJEp2yTVWvZnBNmKzq09tmHFYJD06zxMN3KL
 bzD/HewNQmRCw5pVwNEh/OpA/Tnai70f8O2zu6sJG0/SuTnAkDc0Rr25akc3uruR/UoDf
 p9/sRxZWDpXALc+4jFxjbYnwmk0xI3wlyzDT4fKyCeyFFNb22PZKsSuGqYF6k4cKDfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 519021F000D8;
 Sat, 21 Nov 2026 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795246865;
 bh=APjcjN7LNtjWX/4CCT5XFBMQqLR6Sx43Xbky9olpkZI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=FV26d+4O1cgP+HoKx1WmIUv0Wpy7SEEpAicOwH+hYwzly4V50FhpuNrdoR5XnQ5/a
 u86DkXDdP8wbTRejMCepvi5RbCm1h0hfWMbMCuUEK8ZwLpT33zlYI4xG8wxndzYooU
 u/RkdnQwjgmMJ40Mtj3dbZSqHj0Pu39Zlxu/6VQVFFNvhECw8ewTEOfcX4UKbSrhLc
 0G7yDU070IYBwfDng38Vyotfm7y9sKSgRiJtXKL+SWFVtMiJpSKX+pOD3yux4443o5
 YZdrBTQynLBcEp9MGp+qGpTi8tXKC2n4VfDMW6lCK8QoRqDPyPNKFVd1yxjVL7ytlm
 lZnzZxB4+zR5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3681A4BB8B;
 Sat, 21 Nov 2026 07:40:52 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:40:56 +0800
Subject: [PATCH v3 17/17] riscv: defconfig: spacemit: k3: enable display driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-k3-display-v3-17-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795246844; l=761;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=tELOa0phwzFcnnYsjPBFCdZHVagIANvdSbzxyaUKABU=;
 b=I2GGXpkKedjPts8bA32L+iZxIS5TVwMypDbPdg5RwmuuEhJOkkn6XJ6fnIUuthmARg0i14S5e
 DDSHtiMfr+LCG+UgtKst1jlJ5iOdHfPNCT8AySF+jdr1n4aaqXH984u
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cody Kang <codykang@vsit.ai>

Enable the Saturn DPU and the DP/eDP controller as modules, matching the
other DRM drivers in this defconfig; the DP PHY follows through the
controller's imply.

Signed-off-by: Cody Kang <codykang@vsit.ai>

---
v3:
- no change
v2:
- no change
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511b..7db411d385582 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -194,6 +194,8 @@ CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_SPACEMIT=m
+CONFIG_SPACEMIT_INNO_DP=m
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FB=y

-- 
2.43.0


