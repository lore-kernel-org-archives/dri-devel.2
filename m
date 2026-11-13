Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4805606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD/MInvS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB7210EC5D;
	Fri, 13 Nov 2026 16:08:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFD910EC5D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:08:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76B6760261;
 Fri, 13 Nov 2026 16:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350B1F000C4;
 Fri, 13 Nov 2026 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586099;
 bh=7HCQsoKBHtIuRVqYGL/sXSZ/WJIPHBKdU19CX6ZrJQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GD/MInvS/r/kVol9hR+xKVZYMGjTbHrYWDtNw174NNfswqfP5cK6j+o5AQIoWwBCo
 fuJ/PEFACMPOC/aISmxNAfuMMXgTO/val8UTfOcNTLR1+RgICzLiOTcA8Ig71zQ8of
 08/SFxNKlmYliTNmxuvAWiMIkC5IaDZ6cMRdaleNpqvVFbMfNxxkOv7w1g0Fqr1dJE
 HJQvK73iqORJYG0Bv+65p7GZGp78A+8JMGeVL/9nuv57VeDcneB2zvP9MQ9VfRH/b4
 6KP9tvz2XW9cgJK8AaIDLtrKs3h+oLFe+yJBx5W3jIDoh8PHPIR0Hyz0s2J23qmT6O
 BhivPTsxqxBlg==
Message-ID: <sashiko-outbox-213159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/msm/mdss: reset all block resets described in DT
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155635.1677541-3-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155635.1677541-3-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:08:18 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/mdss: inaccurate INT2 reset description in commit
  message
--

commit 216edbc98463c8e657023589d0ec19367667e829
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

drm/msm/mdss: reset all block resets described in DT

This commit switches msm_mdss_reset() to devm_reset_control_array_get() so
that all resets listed in the MDSS device node are asserted and released
together.

>     msm_mdss_reset() acquires only the first reset listed in the MDSS
>     device node.  Platforms can describe more than one MDSS block reset: =
the
>     SM8750 display clock controller also provides a reset for the MDSS co=
re
>     INT2 interrupt controller, which is left out of reset when the
>     bootloader hands over with the display block still running.

[Severity: Low]
As reported by Dmitry Baryshkov on v3 [1], is the commit message accurate
about DISP_CC_MDSS_CORE_INT2_BCR being an interrupt controller reset, and
what is the side effect of leaving it out of reset?

In drivers/clk/qcom/dispcc-sm8750.c, DISP_CC_MDSS_CORE_INT2_BCR at offset
0xa000 is the block reset for the second MDSS core clock and GDSC domain
(mdss_int2_gdsc and the disp_cc_mdss_*1_clk clocks), rather than an
interrupt controller.  The commit message of the follow-up device tree
patch in this series was updated in v4 to describe the second MDSS core
domain and the cold-boot symptom, but this commit message was left
unchanged.

[1] https://lore.kernel.org/r/awb7bslhrhemsgvu7ubaejvurk6fecotgvqlwtvsoe2be=
nqdgq@tvh2sfjbuzyu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155635.1677=
541-1-xiaqinghuan@mail.ustc.edu.cn?part=3D2
