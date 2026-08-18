Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A5C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFC110E48F;
	Tue, 18 Aug 2026 02:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aD7sm3Ml";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73CC10E48F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:12:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77ADC600C8;
 Tue, 18 Aug 2026 02:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA4A1F000E9;
 Tue, 18 Aug 2026 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787019140;
 bh=ilVxbAEyPCdQeyT159ppq7juBlEw4p6vfYYryqNole0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aD7sm3MlsCsZVAYBe5iwRnyU6in82LmCTrmkdfYgYPHJu0L4JzuHqmw2heOCTgya2
 XhBoHFqbjvWv8fGg+rIdzXKkRLGGFwowCqTbu1urzj/MPigUjoJ3LevGRxqwuFbllp
 J+kfy7HF0Ekh5wDhxo1S0iLZ8AxdEEiMVW9l1fs4XYShKjle3F1+WCFZjKio8YbRbi
 wcPPW6Zp0nNzTa8G5an1vyuq4PSkGjBhqS3kXqJ3PapYlhZsShTclkeResfCHPPPfr
 FQl/fIWQ/zLXdG5zEYgdrb8hEdPryLjc2tZBdU3JD5ssdZohTlyr30O/Is0/bPlyHx
 +tFGAolrCQugA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
To: "Xin Ji" <xji@analogixsemi.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260818020559.961335-1-xji@analogixsemi.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 02:12:19 +0000
Message-Id: <20260818021219.DCA4A1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Adding a vendor-specific DT property for audio interface format =
bypasses standard ASoC DAI format negotiation.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right just=
ify property ---
Please note that due to recitation restrictions, I cannot quote the original
patch code directly. The review below is provided as a free-form summary of
the findings.

commit c7f75f4b785470ba45b421324266273f5142da0b
Author: Xin Ji <xji@analogixsemi.com>

dt-bindings: drm/bridge: anx7625: Add right justify property

This commit adds a new boolean property to the analogix,anx7625 device tree
bindings. The property controls whether the driver enables the audio right
justify function for the data stream.

[Severity: Medium]
Does adding a vendor-specific devicetree property for the audio interface
format bypass the standard ASoC DAI format negotiation?

The standard hdmi-codec framework already supports right justified formats
using the existing DAI format structures, which are normally passed dynamic=
ally
to the driver's hw_params callback based on standard sound card properties.

Creating a custom property like analogix,audio-right-justify-enable hardcod=
es
this configuration statically in the devicetree, which creates a permanent =
ABI.
Should this driver instead rely on the standard hdmi-codec API to handle the
DAI format negotiation rather than introducing a custom vendor property?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818020559.9613=
35-1-xji@analogixsemi.com?part=3D1
