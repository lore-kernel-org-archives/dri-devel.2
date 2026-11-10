Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9B606A323
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Og1g4l1H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5FB10E18E;
	Tue, 10 Nov 2026 19:27:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C859210E18E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 19:27:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFC3863B37;
 Tue, 10 Nov 2026 19:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320AE1F008A4;
 Tue, 10 Nov 2026 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794338868;
 bh=QT8U/Wbxd0LEOhqdFM9UgIZXVJTz3ehOLkQh570wNN8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Og1g4l1HR9MXueT6FF57KRax4ZIUpWr8DKEXHZPuRHFJy5jWjbkRr2rz/jcYmay7F
 AyFFLy4Fl6B4L0Cz8L243YlTL2/g2UaxA98hdKE6ABd8/LY4UyCuhHyP2zRI1URUh7
 ya1eFH/JBQp0NAnCy+QYn+rb8Npyl6clu7lM6MHBSKpLCdcqy2To4y/mqQDu12qjAe
 gZYRntNlBeK+9/tfEyMFZlwRrzxnfUYmCTWdBVazo+c1FcPecuq/nSXSBdTaLBeJ2Q
 C4tD7LimFRoAGpTA5B4E4vAr3gtnGgAIVoplTVFsVP/zAtshVN7aklwQHrz8DLSZma
 F8pl40GtZaPdA==
Date: Tue, 10 Nov 2026 13:27:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
Message-ID: <179433886406.1494254.12130093452944735192.robh@kernel.org>
References: <20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261102055026.438521-2-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102055026.438521-2-xiaqinghuan@mail.ustc.edu.cn>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 02 Nov 2026 13:50:24 +0800, Qianhui Xu wrote:
> Some platforms provide more than one reset for the MDSS hardware block:
> beside the MDSS core reset, the SM8750 display clock controller also
> exposes a block reset for the MDSS core INT2 interrupt controller.
> 
> Allow the resets property to list one or two resets, keeping the MDSS
> core reset as the first entry so that existing device trees describing
> a single reset remain valid.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  .../devicetree/bindings/display/msm/mdss-common.yaml          | 4 +++-
>  .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml     | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

