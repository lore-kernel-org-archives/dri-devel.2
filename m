Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=iR2tK3Y/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC8010E6AE;
	Mon, 23 Nov 2026 08:19:19 +0000 (UTC)
X-Greylist: delayed 574 seconds by postgrey-1.36 at gabe;
 Sun, 22 Nov 2026 18:54:26 UTC
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B468710E06E;
 Sun, 22 Nov 2026 18:54:26 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id 93A7E20DD5C1;
 Sun, 22 Nov 2026 19:44:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 65EE120DD202;
 Sun, 22 Nov 2026 19:44:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 65EE120DD202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795373089;
 bh=Wlw1svGMrjSyOsVhDZN+3pXfMCPyNzszcBB5icjp1ng=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=iR2tK3Y/S2/4lQgIxr70F7/QIwDFHg4OL8p7uqlRv9HZKlbZHOery4Gw5327vbRKz
 icd6lLGlmLeGgSRburc3EtiE0UFypWelwsQZ+BIoJW6BKIG402/U1wqqQcyA9Y6uoF
 3D8Qsd3jmYBe00ftVa05RQqFAyec8+On6y3/cRg6riQOOd9+MKa9iidRvpbdkEetsX
 72e1vjSyFrgH/17PSHbtnnpq4W7X4riDDTs9pMaAWeAlKK7VsqPaUs4WVxMrPxeQVl
 o+XDqNyursduK4ZN1AKmEIk5aKtlNYbCqbBUJdf/tbzZ/WI0n469kBKFePlhjN5NOy
 jkEtNSP+qUTBQ==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id p24HhIr6dker; Sun, 22 Nov 2026 19:44:49 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id D0A3620DD5C1;
 Sun, 22 Nov 2026 19:44:47 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Baihui Liang <liangbaihui@linux.spacemit.com>,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
Date: Sun, 22 Nov 2026 19:44:33 +0100
Message-ID: <20261122184434.545341-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:19:18 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Iker,

Tested on a Banana Pi BPI-F3, on v7.4-rc1 plus Yixun's CCU pm-aux
patches and pmdomain v5 (and the riscv reboot fix), with the firmware
from your link:

- the gpu power domain turns on, firmware v1.1 (build 6976702) loads,
  and card0/renderD128 appear. The GPU interrupt (75) fires;
- a reboot afterwards is clean.

Two notes:

- On v7.4-rc1 the driver refuses the GPU ("Unknown GPU! Set
  'exp_hw_support' to bypass this check"); with
  powervr.exp_hw_support=3D1 it works as above. Is a driver patch
  adding the K1 GPU pending somewhere?
- The GPU never runtime-suspends: after 160 s idle,
  runtime_suspended_time is still 0 and the power domain stays on
  (autosuspend 50 ms). That looks like what Baihui's "drm/imagination:
  re-check firmware idle state before runtime suspend" fixes.

I could not test rendering: Debian 13's Mesa (25.0.7, riscv64) has no
PowerVR Vulkan driver.

Tested-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr> # BPI-F3

Fr=C3=A9d=C3=A9ric
