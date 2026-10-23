Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A925606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ifpwZ8sf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C4910E666;
	Sat, 24 Oct 2026 23:01:39 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8D30311274B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=vQQytljDwXg0nX3cEDh0N
 uGm8qzuvL/zsNqhnlEujQ0=; b=ifpwZ8sfUJK39CEQAUvkKCCmp/NlFfq73RLGq
 yhPjL4oRIlQlBd8wE6ovi0O5FSgB7otwUPtsXwUu23Fi4k0zLIUvG3zUPBMbqEhU
 zwKLkAbKPcuZbC7NJxkfyku8q5hcLcTl8T2lhgmQwYx5kLHo6ddeel3+9h9Wc1nz
 /ewkV4=
Received: from [127.0.1.1] (unknown [114.214.178.200])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCnHzRSEttqdlwzAA--.2232S2;
 Fri, 23 Oct 2026 15:52:50 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Taniya Das <taniya.das@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH] clk: qcom: dispcc-sm8750: reset the MDSS blocks at
 probe when the bootloader left them running
Date: Fri, 23 Oct 2026 15:52:50 +0800
Message-ID: <179274197058.1374475.15035361812241082707@mail.ustc.edu.cn>
In-Reply-To: <22a87c51-4f8c-49c0-a13a-c11767f10e85@oss.qualcomm.com>
References: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
 <22a87c51-4f8c-49c0-a13a-c11767f10e85@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgCnHzRSEttqdlwzAA--.2232S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1DGF4xAFyxGw4xtFyDGFg_yoWrCrW8pF
 W3Ka4Utr1DCFyxZF47Aa18uFWfur95XF45JrWfG34UZw45JFyfJrZrKa1YkayjyFykJa4Y
 yF4agry8uFykta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgcTQUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2raZFU0sAAhs6
X-Mailman-Approved-At: Sat, 24 Oct 2026 23:01:38 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Taniya,

Thanks for the direct answer. You are right on both points and I accept
them: the dispcc probe is not the correct place to drive these resets,
and resetting the whole block and then reconfiguring the PLLs will
flicker if anything is already scanning out.

Why it ended up there

Looking at why I did not put it where you suggest: msm_mdss_reset() in
drivers/gpu/drm/msm/msm_mdss.c only handles one reset, the unnamed one
from the mdss node, which on sm8750.dtsi is DISP_CC_MDSS_CORE_BCR. It
also runs from msm_mdss_init(), i.e. after the dispcc provider has
probed, and the PLLs are configured during that dispcc probe
(clk_taycan_elu_pll_configure()/clk_pongo_elu_pll_configure() sit a few
lines below the hunk I added). So CORE_INT2 and RSCC have no writer at
all in the current tree, and by the time the display side could touch
them the PLLs have already been programmed. Asserting the three BCRs in
dispcc probe was the earliest point I had access to. That is a
description of the constraint, not a defence of the location.

What I think the right shape is

Move all three BCRs to the display side, into msm_mdss_reset(), and use
reset_control_bulk() instead of raw register writes. Three questions
before I write v2:

1. Is extending msm_mdss_reset() to CORE / CORE_INT2 / RSCC acceptable,
   or would you rather have them taken from somewhere else in the
   display stack?

2. Can we guarantee that the reset happens before the PLLs are
   configured at all? Right now the ordering I can observe is
   dispcc provider probe (PLL configure) -> mdss probe
   (msm_mdss_reset). If that ordering is inherent, then a reset in
   msm_mdss_reset() is still "after the PLLs were configured once",
   which is exactly the state you are worried about.

3. If (2) cannot be guaranteed, would an explicit reset in the mdss
   path before the first clk_set_rate() on the dispcc PLLs be
   acceptable, so the block is reset while it is still quiescent and
   the PLLs are then programmed only once?

Measured data

On the same unit, 23 real power-on cold boots (POR, fastboot boot of
images that differ only in these hunks), alternating:

  without the reset:   5 of 9 boots failed with command DMA timeout
  with the reset:     15 of 15 boots OK (two variants pooled)
  Fisher exact, two-sided: p = 0.003

Split by hunk: only-0154 5/5 OK; only-0155 3/4 still failed. So the
display-block reset, not the DSI PHY change, is what moves the failure
rate. I am not claiming this identifies the root cause, only that it is
reproducible and pinned to that one hunk.

A caveat I want to state myself

The A/B tree deliberately does not describe chosen/simple-framebuffer,
so the "simpledrm is being torn down" case was not exercised by these
measurements at all. If simpledrm or efifb is running on a board, the
reset I added would indeed pull the framebuffer out from under it and
produce exactly the flicker you describe. Your objection and the review
comment below point at the same thing, and the display-side placement
plus a liveness check is the only version of this I would defend.

The review comments

Also folding in the three Medium points from the automated review, so
the thread stays in one place:

- The lenovo,elden board compatible is not in mainline arm/qcom.yaml
  yet. It is added by the board DTS series and goes in with it; I will
  not send a separate binding patch for it.

- The raw regmap_write() of 0x1/0x0 over the whole BCR register is a
  real defect: it does not mask and does not read back, unlike
  qcom_reset_set_assert() which uses regmap_update_bits() plus a
  readback to flush the posted write. v2 will use reset_control_* for
  this reason as well.

- The comment claiming the block starts from a "known-zero state" reads
  as if the reset also resets the PLLs; it does not, and
  clk_*_pll_configure() returns early when trion_pll_is_enabled() is
  true. I will drop that wording from both the comment and the commit
  message.

Next step

I will send v2 with the hunk moved to the display side, reset_control_*
instead of raw writes, and a control run where simple-framebuffer is
present in DT, so the flicker case is measured instead of argued about.
If the answer to question 2 is "cannot be guaranteed", say so and I will
drop the series rather than work around the ordering.

Thanks,
Qianhui Xu

