Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77411606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io/0S5TW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD70E10E11E;
	Fri, 23 Oct 2026 21:12:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7966010E11E;
 Fri, 23 Oct 2026 21:09:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43F894164A;
 Fri, 23 Oct 2026 21:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE00C1F01825;
 Fri, 23 Oct 2026 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792789770;
 bh=fS/pPTQHJuueEinFzIzT1Dd4kSXtnBmxPEmCZ9VXz+U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=io/0S5TWf9ihwG2cDTXygBCxMICgD6333oWFamc8RD/aL5EUH4etZEiIEm6Awspfr
 +pIlwdPM91Sbges4mT16sJGL+ve8h8vbfIRoUxC2+ZUp2mx1z69AIk4GNC+C9jmP1X
 1OkaOmNqzDRacwKMo48ChuE12bGXq8ECO/YsK2B98JWupwnKPeJh44PSEO1SAb1xIm
 l44W4O5QVbRQgootmmUzBnOJ8ETjvj2U9kfUsFPeuM3Y9wZgG4HzbAMSc33ZL8vOKu
 AzIrtlWYROLNPp0pJhqMEoZu358reRB3IhVpvQtdXrM97Ft49dMUdSGgEL1MUL5eiZ
 owZNgUqWoiMZA==
Date: Fri, 23 Oct 2026 16:09:26 -0500
From: Rob Herring <robh@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: display: msm: Document Adreno 620
 and its GMU
Message-ID: <20261023210926.GA6026-robh@kernel.org>
References: <20261023-adreno-a620-v3-0-2d1d566e5e13@brar.si>
 <20261023-adreno-a620-v3-1-2d1d566e5e13@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-adreno-a620-v3-1-2d1d566e5e13@brar.si>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 03:23:31PM +0530, Ishu Brar wrote:
> Add the Adreno 620 found in the Qualcomm SM7250 and its GMU. The GMU
> has the same registers, clocks, interrupts and power domains as the
> 650.2 one. As on the other A6xx parts, the GPU clocks are defined in
> the GMU node, so the GPU node has none.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>

Missing Krzysztof's Reviewed-by.

Rob
