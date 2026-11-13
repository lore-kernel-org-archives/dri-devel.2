Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE70606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlGKjtd/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C05410E721;
	Fri, 13 Nov 2026 01:33:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47A310E721
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:33:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2091A60D2C;
 Fri, 13 Nov 2026 01:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC691F000C4;
 Fri, 13 Nov 2026 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533580;
 bh=yQVJRceumFd3S9xDfb9b5jpTVTAv9ljoeKEyL9VyzMM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hlGKjtd/HU4WxY4M9uRAhjiBa88jX/u6l061ApHmmB+lgsD4Nv2UwcVnJ++lxUht9
 pZxIEWSfI5hMpNugKOxYc/aRt2OS056pj/Hnb9bnW3sddg1mmcKLPCGAitNywc4Wp7
 e2M0KbYgXaztVVE+eR2DBagf0f7Z7mRhDjnow12lIjt4OwsKtYKi2KHMaDV45L9Qmh
 556edfnsykGiyMBZtiZAVy89jGey0UWXhF2Txa6N9MnyC53kjUeQjz5Jgx0DGX/cRV
 9RetbFyUVzLDePOSsK6KjQP5UJrV5YQUt/71jbAoSxJi0VjbkT6SZh3w6ea60PqNi7
 gHijy6qM9CgAw==
Message-ID: <sashiko-outbox-212063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-10-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-10-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:33:00 +0000
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
- [High] arm64: dts: qcom: Signed-off-by trailer uses handle instead of
  real name
--

commit 6202c1bff4c338ba19173eebbf9dc1a6bca1824f
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
>
> Configure the thermals for the xo-thermal thermistor connected to
> PMK8350.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author header and Signed-off-by trailer use the single-word handle
"erebion" instead of a real full name, which does not meet the Developer's
Certificate of Origin sign-off requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D10
