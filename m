Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885E606BA45
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6z1qQH2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546BA10E5F9;
	Sun,  8 Nov 2026 20:22:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A517F10E14D
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 20:22:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E62F43ABB;
 Sun,  8 Nov 2026 20:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B431F0089F;
 Sun,  8 Nov 2026 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794169354;
 bh=TQmicMAwCZ+veK2Wt9ragwSxHzWQriH/AV22oia2TQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V6z1qQH23g2pnP8xOJSVocQNl4S7OnwjBUZ1W+jFtv1jCKr5rXrNDgYoPl1HzCtM+
 BZIRHbwo5/Y/oFtJcr8z9MlhCNvAIWIx16AFbSpYzBXCSyRVH0kDsGaey/YNelyeqH
 ATe4+PilfTH9NLCEUypFe19QGujsqnTitKWR9MckcF6kWMRZLL2r3boc2jNJ/MuHbj
 Gwk4mIUE12pOLza5hTLpH/7VFoKO7O9NYsi7JfJT6FUa1jN73fycvudJy1n15JCVwa
 N6UOz0iYlISoDOPmo9kqMZkHzJV5nw8yydgm5MQ9jUcC7oYQx2yzanJjPvKFXg/FwN
 kOZDb7FKyNr+g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
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
Subject: Re: (subset) [PATCH v5 0/2] arm64: dts: qcom: glymur: Fix fastrpc
 compute-cb reg values for cdsp
Date: Sun,  8 Nov 2026 14:19:40 -0600
Message-ID: <179416929393.628393.13698830723595892104.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
References: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

[2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb reg values for cdsp
      commit: 59cfafdd42611fe446c400e692814f8acaed8021

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
