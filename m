Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77041606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=KOiEErbR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75C10ED0A;
	Tue, 24 Nov 2026 01:52:22 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id F2B9710ED0A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=Bu/axAx8BU2cICwCPSy22lmYpBgK1vJ7Vr
 SHsLWeVlg=; b=KOiEErbR/u+wQk9OAEj0x2RxgqAiJQtPlD/V9UOEr1wiVVVUGY
 ypGqB+uTNACq9lG9qto81nd8/J8YWLpcjFrjgmBtMSL9qSuQBF6IjduiBFOYgj/8
 vDh4ZrCQSdP2kLICdHJdMo3/hqHcyTleGw6cIl0Hh+64EErf9UZD8O0aE=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgAXo0fH7QRrLzPvAA--.95S2;
 Tue, 24 Nov 2026 09:52:08 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v5 0/3] drm/msm/mdss: reset all block resets described in
 DT
Date: Tue, 24 Nov 2026 09:52:07 +0800
Message-ID: <20261124015207.1432460-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgAXo0fH7QRrLzPvAA--.95S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7CrWxZFWDCr4xKrykZrb_yoW8Ww1kp3
 yYga13AFyDXr1rAFs2k3409r4fCayrK343Wa1q93y7Zr909F10yrZrt39Y934DAr93A34j
 yw48GrykGF15Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
 c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7knYUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQBAs4
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

*** AI-assistance disclosure ***
This message was prepared with the help of an LLM coding assistant; the
author reviewed it and the facts below are checked against the trees quoted.
The design decisions and any errors are the author's.

Hello,

a quiet status ping on this series, no action requested if it is simply
queued: v5 was posted on 2026-11-13 and has three Reviewed-by tags (Abel
Vesa, Dmitry Baryshkov, Konrad Dybcio).  As of today it is not in
linux-next or in Linus' tree:

  - drivers/gpu/drm/msm/msm_mdss.c still only has the single
    reset_control_get_optional_exclusive(dev, NULL) call, without the
    block-reset walk the series adds (2/3);
  - mdss-common.yaml still documents a single "MDSS_CORE reset" for
    "resets:" (1/3);
  - sm8750.dtsi still lists a single reset for the mdss node,
    <&dispcc DISP_CC_MDSS_CORE_BCR>, without MDSS_CORE_INT2_BCR (3/3).

  (Both trees carry a byte-identical msm_mdss.c, checked today.)

If the series needs a rebase or a re-post to be picked up, say so and I
will send a v6 on the current tree; if it is just waiting for a pull
request window, please ignore this mail.

One thing worth flagging while it is fresh: "[PATCH v3 07/11] drm/msm:
mdss: Add support for MDSS on Nord" touches the same file, so whichever
lands second will want a small rebase of adjacent hunks - not a conflict
in the design sense.

Thanks,
Qianhui

Series references:
  v5 cover  <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
  1/3       <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
  2/3       <20261113155635.1677541-3-xiaqinghuan@mail.ustc.edu.cn>
  3/3       <20261113155635.1677541-4-xiaqinghuan@mail.ustc.edu.cn>

