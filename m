Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF2606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=cPsvRrN4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6952B10E1BD;
	Sat, 24 Oct 2026 22:59:01 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D81A10E038
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1792852122; x=1793111322;
 bh=SNbYPXjdDvBqxnd6BWiHDZ/T7eGyoJJ0/v+O62n7CMA=;
 h=From:To:Cc:Date:Subject:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cPsvRrN4h2PcKKckDkOW/C4TznSurpWu9gFzhpw+q42IvBsb7y860TzJJW9lqYYiL
 DpaRc9LxdHYxfV0C4l0/+cG9ZCpieUpl6+HsY12uHvTK6JNYxBrA0IxpOBOWYpeyhH
 a8CL3DJUjnu4ousk0mgCrwV/xgDGGbuc3EL2Ec67DdLRV/Saw5fgcnxUongf2mscVl
 /IBmBhLmIK4+Oyyf9UwYjBaBWwSpfdpsZJ5ExaofYQJFzwjXaBsoguu17noEJf+5PA
 MVwNLpsYmxU8FssTAET6SOzQh4o9wF/ombumUT0ZtymQC2DC7OGKV85PtQZKcDIV8s
 qYqTOG2qs9cOQ==
X-Pm-Submission-Id: 4jBj1L2Pnkz1DDnW
From: Michael McAllister <me@michaelmcallister.org>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Oct 2026 15:27:59 +0100
Subject: [PATCH 0/2] Fix SM6115 MDSS register access during runtime resume
Message-ID: <cover.1792852079.git.me@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This fixes garbled compressed scanout on my device (Moto G10, SM4250)
after display power cycling. MDSS needs the DISPCC AHB clock before the
DPU child resumes, so this adds it to the binding and shared SM6115 clock
list. I tested this on 7.2.9 and power-cycled the display 20 times.

Michael McAllister (2):
  dt-bindings: display: msm: sm6115-mdss: Add missing AHB clock
  arm64: dts: qcom: sm6115: Add missing MDSS AHB clock

 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml    | 5 ++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi                         | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)


base-commit: d053e38e614fb2e383b298ce8fc308a780d7f209
-- 
2.39.5
