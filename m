Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68E606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hicqi1Hs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF0810E057;
	Mon, 26 Oct 2026 12:40:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10CC10E057;
 Mon, 26 Oct 2026 12:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A43D600CB;
 Mon, 26 Oct 2026 12:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7B61F01825;
 Mon, 26 Oct 2026 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793018427;
 bh=zrnXTK53OXXWzzbm7OM7SJBtBm4KDJ4lpnFIBSlde30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Hicqi1HsKP+dqQJI10BYrVjKMumMla6nqCDnVSlTlKdUZwZ1mU03DmWxuG9SE8/UA
 zHAR8tIT4AnJABcqdJUlASBAkWkhjZ4klJvpNpjMFmWASOendLJ9lt9dpHVLi2XgsN
 hH9GW5ENMKCHk2+nAidqUQoSB76CQ/rTGp+3R3v3ouDtNvmeFeTf+WDqAppPVbnkzB
 /DQ0agTeabsnkA/SjE/Nblj4RlDkC7cm4L6iU49v8PUjwh58tZQhXYLbWpfPDILqx2
 UFV0YUkI9lwFVCYqx355Dg6qq9BYY+LJNAZbRbHj/O9JlKt7ac67d0p+WMwXRKAU9n
 zhDwiKjyI+brw==
Date: Mon, 26 Oct 2026 13:40:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael McAllister <me@michaelmcallister.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: sm6115-mdss: Add missing
 AHB clock
Message-ID: <20261026-beneficial-aquamarine-kestrel-f16e2a@quoll>
References: <cover.1792852079.git.me@michaelmcallister.org>
 <5326d23102e89b492767862fc7ae027f3eec2205.1792852079.git.me@michaelmcallister.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5326d23102e89b492767862fc7ae027f3eec2205.1792852079.git.me@michaelmcallister.org>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 03:27:59PM +0100, Michael McAllister wrote:
> MDSS register access requires the AHB clock supplied by DISPCC, in
> addition to the GCC bus clocks and the MDP core clock already listed.
> The DPU child also uses this clock, but MDSS needs it before the child
> resumes so that it can access its own registers.
> 
> Add the missing clock to the end of the list and update the example.
> Keep the existing three-clock descriptions valid for compatibility with
> older device trees.
> 
> Fixes: b93bdff44a85 ("dt-bindings: display/msm: add support for SM6115")
> 

Drop the blank line between tags.

> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

