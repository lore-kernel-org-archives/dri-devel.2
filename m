Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284D606BAAA
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=s5LhFAtw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275F10E80B;
	Fri, 13 Nov 2026 15:56:16 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1555110E80B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=yliNjcckvr
 PWMlzW1h4BFM/GfWpjqihfWur/p54uuSM=; b=s5LhFAtwGWzXCuj3fLckz7pzGY
 u9JDR32phQv41P0UNxMgu8q/aEns5hxRvlcCzOlOBbkYugWq0HNduXglrgQPTcNE
 AlCAA6qh0TyJmm2PJhcau2c+NqkcUY8+NHv8MnCBzBhIOlovjzI19UpM3q1YK3+4
 hYwWEZepiOm8uW/wQ=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgC3KS4WM_dqbQ66AA--.937S2;
 Fri, 13 Nov 2026 23:56:06 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v5 0/3] drm/msm/mdss: reset all block resets described in DT
Date: Fri, 13 Nov 2026 23:56:03 +0800
Message-ID: <20261113155606.1677313-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgC3KS4WM_dqbQ66AA--.937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kWr17Zr4fXw48ZrW5ZFb_yoW5Kw1UpF
 ZrJ3Z8Xr4vgFyY9a9rGa109a4rG395tFW5GrW5tryUAa15JF13Jryftr4jyFWUArs7ua4F
 yFWagrWYvFyqvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7GQ6DUUUU
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

*** AI-assistance disclosure ***
This cover letter and the three patches were prepared with the help of an
LLM coding assistant.  The author reviewed every line, checked every
statement against the tree and his own logs, and takes full responsibility
for the content.

This is v5 of the MDSS block-reset series.  It supersedes v4
(<cover.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>) and changes only the
last commit message, in response to the review of v4 3/3
(<8a0c75949fcf428a2163a2e63b27fcf08d3b4f9c.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>).

1/3 and 2/3 are unchanged from v4.  3/3 keeps a byte-identical diff; only its
commit message is rewritten.

v4 said that dispcc provides "a block reset for the MDSS core INT2 interrupt
controller" and that INT2 "is part of the same block, not a separate
device".  Review pointed out that 0xa000 is described by dispcc as its own
domain: it has its own GDSC (mdss_int2_gdsc) and its own clock family
(disp_cc_mdss_mdp1_clk, disp_cc_mdss_ahb1_clk, ...), and the mdss node does
not attach that domain (power-domains is MDSS_GDSC only, and the clocks list
has no mdp1 entries).  That reading of the code is correct, so v5 no longer
calls this an interrupt controller reset and no longer claims it is the same
block.

What v5 states instead is only what is observable:

  - dispcc provides two block resets for the MDSS core area (0x8000 and
    0xa000), and the second one belongs to a domain dispcc describes
    separately;
  - firmware hands over with the display hardware still running, so the MDSS
    reset returns the group to a known state before display hardware is
    programmed;
  - on this board, resetting only DISP_CC_MDSS_CORE_BCR leaves the display
    intermittently broken at cold boot (command DMA timeouts followed by a
    panel init failure, 5 of 9 cold PORs), while asserting the group gave 15
    clean boots out of 15.

The message also records the limits of that measurement: the 15/15 figure
came from the three-reset shape that still included RSCC, it has not been
repeated for this two-reset shape, and the second reset was not isolated as a
single variable.  There is no datasheet-level confirmation that the INTR2
group and the 0xa000 domain are the same hardware block; the evidence for
that is naming (dispcc's ..._CORE_INT2_BCR, MDSS_INT2_GDSC; MDP TOP's INTR2)
plus structure (same MDSS core, separate BCR/GDSC inside it).

All three Reviewed-by tags are carried over: Abel Vesa, Dmitry Baryshkov, and
Konrad Dybcio (the last one received on v4 3/3).

If the un-attached-domain concern is considered disqualifying, the
alternative is to drop 3/3 and keep only 2/3 -- the array-API change, which is
uncontroversial.  I kept 3/3 because the failing cold boot is reproducible on
this hardware and the group is what tracks with it, but I am happy to send a
v6 without it if that is preferred.

Gates: pristine v7.3-rc7 (24a19b953e) git am 3/3 clean; checkpatch --strict
3/3 at 0 errors, 0 warnings, 0 checks; code and DT diffs are identical to v4,
so v4's dt_binding_check and W=1 results carry over unchanged.

Qianhui Xu (3):
  dt-bindings: display: msm: mdss-common: describe additional block
    resets
  drm/msm/mdss: reset all block resets described in DT
  arm64: dts: qcom: sm8750: describe the second MDSS block reset

 .../devicetree/bindings/display/msm/mdss-common.yaml         | 4 +++-
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml    | 3 ++-
 arch/arm64/boot/dts/qcom/sm8750.dtsi                         | 3 ++-
 drivers/gpu/drm/msm/msm_mdss.c                               | 5 ++---
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.53.0

