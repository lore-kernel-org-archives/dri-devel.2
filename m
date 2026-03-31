Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDB510F9300
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB4410EAF6;
	Tue, 31 Mar 2026 21:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ngitMcCZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12BC10E9B6;
 Tue, 31 Mar 2026 21:04:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E6144440C;
 Tue, 31 Mar 2026 21:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C29EC2BCB3;
 Tue, 31 Mar 2026 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774991071;
 bh=em86yCCRyL2CVX8urGD8oO6MxC7Rij/SyBrH46i9bEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ngitMcCZqK8YJPw3oMlXOXSGH6ZLumD9rVj88yWO8kXfSpvgXjwYM7h65jrgonhxv
 DWwbGSi4DG0i4a6P7F1VVkVd7IqhUlSHjKBd24empwrsrfJsbl2SmyL05ORkVwon7h
 KCx0CWbsz1eE3HUQs6ES/BjnO85ytl77jTPf2Be/Tmxae1S6yIPGV5fErj7gVvI7RF
 M3/HQHjQ64fBdE2RcpFv+Zn2x3BCDWkvZqloRJwoQxSB3uPFXYS8YtWCp3fezWoKDT
 psYytvBtV/ak+QsmPhGk8pucgZ6AgZT5iT/KzmLNsXjPrbfPFYbZO+jofRWkjOBsZM
 CQiKCZVuwRnEA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/9] media: iris: migrate to using global UBWC
 config
Date: Tue, 31 Mar 2026 16:04:24 -0500
Message-ID: <177499105231.956796.588474423586543717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
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


On Sun, 25 Jan 2026 13:30:02 +0200, Dmitry Baryshkov wrote:
> Having UBWC configuration in the driver is error prone. For example, the
> driver specifies fixed values for HBB, while the actual value might
> depend on the DDR type. Stop defining UBWC data in the iris driver and
> use the global UBWC configuration registry.
> 
> Merge strategy: either merge SoC bits directly through the media tree
> (with Bjorn's ack) or merge to the media tree through the immutable tag.
> The drm patches will follow depending on the way the SoC patches are
> merged.
> 
> [...]

Applied, thanks!

[1/9] soc: qcom: ubwc: add helper to get min_acc length
      commit: 68a66a44af6e196ca426d1250104d3018ed9e74b
[2/9] soc: qcom: ubwc: add helpers to get programmable values
      commit: b2571ef8d4ec9bb636889a9132090bcc3449792e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
