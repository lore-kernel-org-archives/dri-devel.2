Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAA606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=RGRz4RjZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB2310E7BA;
	Thu, 29 Oct 2026 21:43:53 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FC510E7BA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1793309775; x=1793568975;
 bh=f7WfxrRogWkC2VbFyxZ98k7BXu/Nz4K5mmRfBODJm7c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RGRz4RjZPwzVZeGbBToJdHMo+OaHTQts6Ik/SS/fwmTkeCTMcz1zWKqsm+x/ZxADT
 T2KPKeEexN+gI9XqMVz5uiXc63XmcSLbiWl8Gu9xKGVrxrhJw8Sldj172bZSN0gOIo
 Zq639wiNLAqct5bc30Dl1hTZoMmzAPcd2hxeec7PkX1PCy5tuJ48m0QKLl9oeTIj6O
 sTMcx7QkgxhwurPmLt2HwObYE/eJbsnDnrMmAccWVgvYM4y1ss9ucCgsHvTTxWWSDi
 ngklTpKdgiZW/PSlrpu7Hd+44uL+WltWW7Vja+LswLtJzMXTy1HCMBKTE0UAMeMhXT
 1csCluPlIsP3Q==
Date: Thu, 29 Oct 2026 21:36:09 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 00/16] drm/msm/a8xx: GPU state capture support
Message-ID: <VVkrFTcMMRB3AjgGdwPgywO5nl0lDonm4QscNx9WTaYDTcuVQAHLgWxxkr7ool-1L7F4AHzjDKYAaq__MogbXROR7130sNTIzaHqPTyE_EE=@pm.me>
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 743194d165c51664fa7869c239141108936401d4
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, October 29th, 2026 at 4:17 PM, Rob Clark <robin.clark@oss.qual=
comm.com> wrote:

> This series introduces gen8 devcoredump support.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a=
)
