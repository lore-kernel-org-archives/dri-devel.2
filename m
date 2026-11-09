Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455F606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtYcHYNK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F91A10F219;
	Mon,  9 Nov 2026 12:20:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CBA10F219
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04226631E2;
 Mon,  9 Nov 2026 12:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA4F1F008A3;
 Mon,  9 Nov 2026 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794226839;
 bh=ze+YCmI59m/yVO+iXLz5VO5YTj0KOc9jwUZZU33amMs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=CtYcHYNKlbOAZIWjhtvy1EYM1Zsqq14b2LPf+B0uyB7LyHOKI8xFt5D52a6RiEwZM
 2jtkN0lya9J/RpPnmQ7d/9jdwsmOOQeEdFubViJQRzkqbDfftBwkYwdP/Ki+xkXJQL
 Q/pNN7Hs8W5PuWjAOzi3g+1xrVeJAWEyLx2w/9ONXawi5IZ41fZFsXMD6e6Josu6NH
 vb+QwpDLf414qKb+tP8PbMU3S7gCgI/VvxeIf6p+wkbLXLGWly9/Rwwd5O1zerZnlw
 5f9AYB6rq7hTPDrBjaeBUI39cY1FEWG87ZgAbOuP0HVliOPVr+dhu0q3i1U35GfvJl
 Vhlwcyi4LAuJA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>, 
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
In-Reply-To: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
References: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/2] arm64: dts: qcom: glymur: Fix fastrpc
 compute-cb reg values for cdsp
Message-Id: <179422683634.26830.384008413177707013.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 12:20:36 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 16 Oct 2026 12:06:45 +0530, Ekansh Gupta wrote:
> The reg value of a compute-cb node must match the SID (the lower nibble
> of its IOMMU stream ID) it is associated with. In the cdsp fastrpc node
> of the Glymur SoC, three compute-cb nodes had incorrect reg values that
> did not match their SIDs, leading to SMMU translation errors.
> 
> The fix renames the nodes to use correct lowercase hex unit addresses
> (per DTS convention) and corrects the reg values. Since the fastrpc
> binding's patternProperties only allowed decimal digits in node names,
> a binding update is included first to allow hex digits.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: misc: qcom,fastrpc: Allow hex digits in compute-cb node names
      commit: 05c781dfb322b07d803fedc18b752e7ae2bbdc4b

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

