Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C3606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=dKbnz78y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA4910F351;
	Tue, 24 Nov 2026 08:39:57 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3E110EF2F;
 Mon, 23 Nov 2026 16:34:23 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id 88C5820DDAF9;
 Mon, 23 Nov 2026 17:34:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 5E73620DB5E5;
 Mon, 23 Nov 2026 17:34:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 5E73620DB5E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795451662;
 bh=I+soC5Sh4FDvmwplNPuiEd1GOV3Guew6WDJ4B6BfHZM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=dKbnz78yoqvRnJtdRC6VnQGZFp4fLkUPCTeZwhSn7Gzk3++14gZaDXk7d0Eu64XEy
 2G9ClYxt8cZGjf8B2i4W2Tb5SenN0et7NeJVWmmeyx7BgeuqnH4t2fBSPUA6SR80et
 Hdwd5tWuNKFZtO2sZu9o/K0f4K2P+lskWIGbHetv0dyy5xrHHvh0umwUO7ASgLFgDi
 xe8l6crslTdOUk1SRgPttKu9XeBYtrTsBtPd4bvSSWqshubPcxY2lIYONNZoENdYwH
 cneHSRjSbbZHmc5tBAUM8zaKwQc6KZKM6rF76BxNQ8eDwGwbeVo1LCTgUZq02TRrfE
 Fh7QjJH8eK0QQ==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id JEK5IDNvoGaF; Mon, 23 Nov 2026 17:34:22 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id 709D720DDAF9;
 Mon, 23 Nov 2026 17:34:21 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: "David R . Hedges" <linuxdev844@thelittleman.net>
Cc: lyude@redhat.com, dakr@kernel.org, me@dakr.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@intel.com,
 bskeggs@nvidia.com, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
Subject: Re: [PATCH 0/5] drm/nouveau: recover DP links the sink drops after
 waking
Date: Mon, 23 Nov 2026 17:34:05 +0100
Message-ID: <20261123163407.637423-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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

Hi David,

You mentioned that GPUs without GSP-RM were not tested. I ran parts of
this series, together with "GSP DP control call fixes and two KMS fixes",
on a Quadro 600 (GF108, DP 1.1, 4 x 2.7 Gbit/s) with a 4K DP 1.2 monitor,
on Ubuntu's 7.0 kernel (nouveau built out of tree; one context line in
nouveau_connector_destroy() of 2/5 needed adjusting for 7.0).

Without your series, both of the following crash the kernel with a
divide error in nv50_disp_super_2_2_dp() (see my patch "don't divide by
zero when the DP link is not trained"). With it:

- 3840x2160@60 set as a user mode with SETCRTC: -EINVAL from atomic
  check ("mode needs 1199813 kB/s, link carries 1080000 kB/s"), no crash;
- monitor asleep (not answering AUX), connector forced on, 1024x768 set
  with SETCRTC: -EINVAL, no crash;
- 1024x768 with the monitor awake, and DPMS off/on (5 s and 150 s):
  link trained at 4 x 2.7 Gbit/s, no warnings.

Not tested: the DPMS-on path of patch 2 (this monitor keeps answering
AUX during DPMS off), the IRQ_HPD and replug restarts of patches 4 and 5,
suspend/resume and MST.

For the parts above:
Tested-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr> # Quadro=
 600 (GF108, no GSP-RM)

As said in my other thread, your patch 1/5 makes my "reject DP modes that
don't fit the link" unnecessary.

Testing done with the help of Claude (AI assistant).

Fr=C3=A9d=C3=A9ric
