Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC2606A326
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3+VceWB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2493D10E367;
	Mon, 23 Nov 2026 21:12:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18DA10E367;
 Mon, 23 Nov 2026 21:12:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFA0A41FBF;
 Mon, 23 Nov 2026 21:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B0F1F000D2;
 Mon, 23 Nov 2026 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795468340;
 bh=THwWWjucJLHrTSc8VPkQZeTqtfJVV5aJMHAoWWO0YH8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=l3+VceWBOJiFskUO9JkxVGsiHVwM+MDBSm97ESFObDBCxEgMMH7Uhn0EyYibrrBdg
 7ooOcgsGL/aB3oAlUMZXet5io1Gwwl7Tlz9JB0LEU4qJWP7ENmZgEIxjxEswe/ws3i
 KJipkh2mLyBd9UTbPGPHKK++sbtYfFn37HRzY/bmFf4KO3IY5QJNHBKcgq/kOZdICH
 uEd465AFvpOrudbndobnTOjPbOIGTcgdIv3Q6h9PJ+V+IugqBPA0iNXDE4Cv0KkZ64
 hG+ByfUB1wHy48J2wDCtLWUuu3FbTKpJ6Nyny3BU2n923STfUrMB5KVowsn3b9CT2d
 ngMBZl+YLDctQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Demeter Barna <me@fromdisposition.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org
In-Reply-To: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
Subject: Re: (subset) [PATCH 0/5] SM8350 GPU: memory bandwidth vote and
 speed bins
Message-Id: <179546833676.519617.18442308019433292321.b4-ty@kernel.org>
Date: Mon, 23 Nov 2026 21:12:16 +0000
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


On Thu, 05 Nov 2026 13:29:59 +0000, Demeter Barna wrote:
> Two things are missing for the SM8350 GPU in mainline.
> 
> First, the GPU never votes for DDR bandwidth (patch 1). This fix stands
> alone and can be taken on its own.
> 
> Second, the GPU speed bins are not read, so every part runs up to
> 840 MHz: parts validated only up to 738 MHz run above their rating, and
> parts that support 900 MHz never get it (patches 2-5).
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: nvmem: qfprom: Add SM8350 compatible
      commit: d19de535c5a8e041840e5399d0006a105e806fe1
[3/5] nvmem: qfprom: Add the SM8350 keepout regions
      commit: 7fa27a3057a750d30cfb1603d377cae38b146530

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

