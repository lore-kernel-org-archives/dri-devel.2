Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNw4+UDN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C375B10E717;
	Fri, 13 Nov 2026 01:32:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5196510E717
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:32:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E26440713;
 Fri, 13 Nov 2026 01:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96A51F000C5;
 Fri, 13 Nov 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533544;
 bh=9y2sacLsjlr5JpUq2MRW6Y8Zll0tkKJ8pUYb8ltDrck=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YNw4+UDNC9017JsHNlLemRe7oQMrIp58SE2uOANCmw2Tjk+p2IUc+YrfJUgpHrWaF
 IE4djgPYPBg1/t6ZfUAINTtmRvv22Is//IA9ssZP6KFjfoRm9xh+Ku+wqFqO8MMu6N
 g2/AWcxapA0gmm1u2/1vZH9Cmsdgs/BfK70xvITKqYs7v8Amlx+JiptvPdL9Hp4IHu
 RC78YdilCdyyB1KPUvwn6nW/y5WWKuIIgf1tsLbydaAT35uKThDjTs8QGfBAky6kmu
 L+0eSYdlWg2n2naDAsI88UL2VJVvtvOXwvEOq3x9tVfgLFxFgUgaRNdMSUdqCxN9DY
 BePKZx+TC442A==
Message-ID: <sashiko-outbox-212062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-1-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-1-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:32:24 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] arm64: dts: qcom: username handle used in Signed-off-by and
  Author fields
--

commit 9d995ddc664157d72483c0a7caa443b691f53025
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add flash LED
>
> Add a node for the camera flash LED found on the Xperia 10 III
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
As reported by Bjorn Andersson on v2 [1], the Author and Signed-off-by
fields use a single-word handle ("erebion") rather than a full real
name, which does not satisfy the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.

[1] https://lore.kernel.org/r/arnF0u2F9ipfnNP-@zenbook

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D1
