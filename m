Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE5606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvGEP6Ag
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB5C10E728;
	Fri, 13 Nov 2026 01:34:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8906A10E735
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:33:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D3C66250A;
 Fri, 13 Nov 2026 01:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793591F000C5;
 Fri, 13 Nov 2026 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533638;
 bh=pXbk8nAr5mOwObpYkax+yv51c3ydDsMqckubch6UOBY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZvGEP6AgwvLJ4LZVfw2tm2SM/cuOz6t6PExNf6dhVd5/uhdZYgRUbOS8G5/F2gGKv
 3OYxf34+FpPphK+UCLEhVKnXTiQvHtq5hEkXtyqTPwuZg3aZaqMcgCGhZw+Yej8B3Z
 VFw82bBTM6rlGvOJuyPV3IqJu/kZdch0B2itJlDGfhEgSa5VZP29NOtEXXPeU3V30t
 TQIIQWu80sFHL+MBM73ZNH4G4evCQY+PIBJQtIuJgDLiOcWEcMV67v+YmF9RHzrAHo
 vWzKDhuuN7/y/3t/JnJBUdQzbDdY7NnS1OCNxGOCYleqKVGkR0N4T2RFf2jHaP/BWF
 5sZFosN5dB1WA==
Message-ID: <sashiko-outbox-212065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-8-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-8-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:33:58 +0000
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
- [High] arm64: dts: qcom: invalid handle in Signed-off-by trailer
--

commit acc7716614faf15423968aecc6a9f74285660459
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable PMK8350
>
> Configure and enable nodes for PMK8350 on the Xperia 10 III.
>
> The phone has two PMICs which have a PON block, disable the PMK8350
>  PON and keep the PM6350 PON, as only one should be enabled.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Per Documentation/process/submitting-patches.rst, the Signed-off-by
trailer and Author header must use a real human name rather than a
single-word handle or username.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D8
