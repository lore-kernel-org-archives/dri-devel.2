Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B4606A89E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=tkkKofEl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9239711266A;
	Fri, 13 Nov 2026 15:50:10 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id BD7FE10EC59
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding; bh=LNHsVij+5x9JgaPUweBLaKGHplyWWoiTn0
 aitA03H2I=; b=tkkKofElPkfzCs7g3VoIizyQ+jHk7+TPYige9O0fEiupXcGbH0
 cz3sgBSB6GUeKRynXXL4pexWpcqx2iSmB6Dh2u72IzBUnCZ4W/yTILbvDeIVD8zr
 f0udTUvUz5G/a0PZSh9KHJFn5lJFa7hOnXB0fB+TfDkybqYBPZo5hvyd4=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDXYEWnMfdqQwm6AA--.1802S2;
 Fri, 13 Nov 2026 23:49:59 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
Date: Fri, 13 Nov 2026 23:49:59 +0800
Message-ID: <20261113234851.42e0bacd02fa-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8a0c75949fcf428a2163a2e63b27fcf08d3b4f9c.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
References: <8a0c75949fcf428a2163a2e63b27fcf08d3b4f9c.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDXYEWnMfdqQwm6AA--.1802S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF45AFWDCw4fArWDXr1UWrg_yoW7uF4xpF
 W3Ga1UGrsYqr1S9w17Cw409a4rCws3GFW7GFZ8tryUZws8KF1xZFZ7Kry0gFyUCrn5Xa4F
 yFWa9ry5uF4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
 wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
 0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
 17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Konrad,

thanks for the Reviewed-by.

Replying to the sashiko finding as well, because it raises a point I should
answer properly rather than wave away: is 0xa000 a secondary display core
domain rather than the interrupt block?

Partly yes, and my commit message overstated it.  Let me separate what is
established from what is not.

What the DT and the driver currently describe:

- mdss is an interrupt controller: "interrupt-controller;" plus
  "#interrupt-cells = <1>", and its children take IRQs through it --
  DPU "interrupts-extended = <&mdss 0>", DSI0 "<&mdss 4>", DSI1 "<&mdss 5>".
- The mdss irqchip itself only reads one status register and demultiplexes
  (msm_mdss.c, offset 0x10).  It has no per-line enable/ack registers; the
  mask is a software bitmap.  The block that does have clear/en/status is
  MDP TOP's INTR/INTR2 group, driven by the DPU driver.
- dispcc-sm8750 does describe 0xa000 as its own domain: its own GDSC
  (mdss_int2_gdsc at 0xb000) and its own clock family (disp_cc_mdss_mdp1_clk,
  disp_cc_mdss_ahb1_clk, ...).
- The mdss node does not attach that domain: power-domains is MDSS_GDSC only,
  and the clocks list has AHB_CLK/MDP_CLK/GCC_DISP_HF_AXI_CLK, no mdp1 family.

So the reviewer is right that 0xa000 is not "the mdss interrupt controller"
and that asserting its BCR reaches into a domain the mdss device has not
attached.  That is a fair reading of the code.

What the measurement says, and its limit:

On this board, resetting only DISP_CC_MDSS_CORE_BCR leaves the display
intermittently broken at cold boot: 5 of 9 cold PORs fail with
  msm_dsi ae94000.dsi: command DMA timeout: status=0x2200200
  panel-novatek-nt36536: Failed to initialize panel: -5
whereas the same kernel asserting the group gave 15/15 clean boots.

Two limits on that number, both of which I should state rather than let the
"15/15" look stronger than it is:

- That arm asserted three resets (0x8000 + 0xa000 + 0xc000), because it was
the shape before you asked for RSCC to be dropped.  The two-reset shape in
this v4 has not been booted; the driver-side change is the same, so I expect
it to behave the same, but that is an expectation and not a measurement.
- I have not isolated 0xa000 as a single variable either.  The correlation is
with the group, not with any one member, so I am not claiming 0xa000 is the
sole cause -- the honest statement is that asserting the group is what
tracks with a working display.

What I do not have: a datasheet-level statement that the INTR2 group and the
0xa000 domain are the same hardware block.  My evidence for that is naming
(dispcc calls the reset ..._CORE_INT2_BCR, the GDSC MDSS_INT2_GDSC, MDP TOP
calls its second group INTR2) plus structure (same MDSS core, separate
BCR/GDSC within it).  That is why v4 no longer claims INT2 "was left out of
reset and caused the DMA timeouts"; the message only states what dispcc
provides and that firmware hands over with the display block running.

Given all of that, two honest options, and I would take whichever you and
Dmitry prefer:

  a) keep the series as is, with the commit message narrowed to what is
     observable (group reset correlates with clean cold boots; no causal
     claim about INT2), and
  b) split 3/3 out and drop it, keeping only 2/3 (the array API change,
     which is uncontroversial), and revisit the SM8750 second reset once
     someone can confirm the block boundary from documentation.

My preference is (a) because the failing boot is reproducible on this
hardware and the group is what fixes it, but (b) is cleaner if you consider
the un-attached-domain concern disqualifying.  I can send a v5 either way,
including a reworded 3/3 that drops the "interrupt controller" framing and
describes only "a second block reset provided by dispcc for the MDSS core".

Unless you would rather have (b), I will go with (a) and send a v5 whose only
change is the 3/3 commit message below -- the diff stays byte-identical to v4,
and your Reviewed-by is carried over.  If you would prefer (b) instead, say so
and I will drop 3/3 from the series.

--- >8 ---
arm64: dts: qcom: sm8750: describe the second MDSS block reset

The SM8750 display clock controller provides two block resets for the
MDSS core area: DISP_CC_MDSS_CORE_BCR and DISP_CC_MDSS_CORE_INT2_BCR,
at 0x8000 and 0xa000.  The second one belongs to a domain that dispcc
describes with its own GDSC (mdss_int2_gdsc) and its own clock family
(disp_cc_mdss_mdp1_clk, disp_cc_mdss_ahb1_clk, ...).

Bootloaders hand over with the display hardware still running, so the
MDSS reset should return the whole group to a known state before any
display hardware is programmed.  Describe both resets so that the
array-API change in the previous patch asserts and releases the group
together.

On this board, resetting only DISP_CC_MDSS_CORE_BCR leaves the display
intermittently broken at cold boot (command DMA timeouts followed by a
panel init failure, 5 of 9 cold PORs), while asserting the group gave
15 clean boots out of 15.  That measurement used the three-reset shape
that also included RSCC; it has not been repeated for this two-reset
shape, and the second reset has not been isolated as a single variable.
What is observable is that resetting the group correlates with a working
display at cold boot.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
--- 8< ---

One more thing worth stating explicitly: this series was written with AI
assistance.  I reviewed and edited every line, the measurements above are
mine, and I am responsible for the content.

Thanks,
Qianhui

