Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B4C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E8510E146;
	Fri, 31 Jul 2026 03:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="alJPz710";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3516A10E146;
 Fri, 31 Jul 2026 03:23:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFD1D4401E;
 Fri, 31 Jul 2026 03:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4FA1F00A3D;
 Fri, 31 Jul 2026 03:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785468236;
 bh=ExYIItcDEZWrDnj18MKrsQX+GnPewakLGGldn9zFVCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=alJPz710ds45M32sC/W4EDR1+q0unwltstCOWbnGaG6ro0iMcmbnQtoip8c8VaS9x
 ucunAffa0RGqITe9ralEA5C8L9d13xx3fChUikErBa6niEP8a0BFzEcB05S35Q/1/2
 1UFyndof2hw2Kau7xmVNSRKQRuzNuN582osWVF/C+PDDv2GUXij6aDfXH6eui0f3D7
 cL6fOvwE4GtNUfPpna/rRL5r3qKYZUh8Ra7Ca74SqJd80LQ9HhpE4EvImKKPLv7m1r
 fH9bifgptxWsZVifHaG6cyE2ohO49GEnwg7hJeZoduwMm3zEAx/5fx/2COa05v/hg8
 b48DbmwT4DuTg==
From: Bjorn Andersson <andersson@kernel.org>
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@sandisk.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
 Jie Gan <jie.gan@oss.qualcomm.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-scsi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 coresight@lists.linaro.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Retrieve information about DDR from SMEM
Date: Thu, 30 Jul 2026 22:23:43 -0500
Message-ID: <178546821257.316167.5256445385425936604.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727-topic-smem_dramc-v5-0-66188b3e338d@oss.qualcomm.com>
References: <20260727-topic-smem_dramc-v5-0-66188b3e338d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Mon, 27 Jul 2026 11:59:26 +0200, Konrad Dybcio wrote:
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
> 
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: smem: Use 'unsigned int' instead of 'unsigned'
      commit: 80350cdc5f7e2ddc6739987a78f04b9b7788e593
[2/3] soc: qcom: smem: Expose DDR data from SMEM
      commit: 1d234eeafc56af8c9af6eee857f41a4310615e78
[3/3] soc: qcom: ubwc: Get HBB from SMEM
      commit: 1b445022d1d0ec7431b6f8fe0054ae8ccf33d60a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
