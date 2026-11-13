Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75F606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/Z9sSNl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6D310E6F8;
	Fri, 13 Nov 2026 01:30:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4199E10E6F8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:30:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B4AB43614;
 Fri, 13 Nov 2026 01:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44341F000C4;
 Fri, 13 Nov 2026 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533402;
 bh=ZdTNKOlK94X99BHyLBr2YYN+gi8mOa/+sTQWlAzR57E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T/Z9sSNlmvEYWSDahaLENkexz2Umm9fTs4JEpoldw5n9UJ2B+o97L+P5iKDTklkkr
 gB13gu+QsxsiHNDCSOn9fmxh3ojPwJsGO487fLgZj30s6urNxrPnYxmaozS8ObRGk9
 ydkG+gzS+wDTWCXPyNnVujmWP9zbvkz/xN7oiLuqV9riVOJ4tDqCv2IMOM74myrNWO
 IVfwEYI2JZBCLhD4KzLeKhK708ph/BlIpojdZZLBP/3+mJWFH5EDZRv1HuQbIkSo8l
 4vkNwCdPZiVvY2oPi4y1FZ2Kkb4fRmZbg7R8zYDWIWlbhhHf8u1PgunZt6KN/F5TMq
 ssE02x9+zaKKQ==
Message-ID: <sashiko-outbox-212057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] arm64: dts: qcom: sm6350-lena: Add
 qcom,rmtfs-mem node
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-3-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-3-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:30:01 +0000
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
- [High] arm64: dts: qcom: sm6350-lena: Signed-off-by uses handle
  instead of real name
--

commit a9ddce3144fad1d53145bd8e52ebb61fbdf78099
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
>
> Adds the qcom,rmtfs-mem node required for the modem
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author header and Signed-off-by trailer use the handle "erebion"
instead of a real name.  Under Documentation/process/submitting-patches.rst,
the Developer's Certificate of Origin requires a known real name rather
than a pseudonym or handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D3
