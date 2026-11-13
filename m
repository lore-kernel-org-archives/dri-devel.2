Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20666606B2E8
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=kVkapyQC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9F011267F;
	Fri, 13 Nov 2026 15:56:46 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 378D4112695
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=yliNjcckvr
 PWMlzW1h4BFM/GfWpjqihfWur/p54uuSM=; b=kVkapyQCjpw/cbksdZ6J0wQwer
 QAaFf0VVla5v+3jEvlNCiogNkeAe24wgljzWuipW+w3ldYc6NybEzWIu3axAIazD
 qHAkVu5X9dbzPH8RJLV8yCmMUgn/qS7unjLsqabpaWGqJsJ6r7W4x+CwG1MhVgnT
 R1uWhcpmFK0mvUyS8=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3rDAzM_dqxQ66AA--.1851S2;
 Fri, 13 Nov 2026 23:56:35 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v5 0/3] drm/msm/mdss: reset all block resets described in DT
Date: Fri, 13 Nov 2026 23:56:32 +0800
Message-ID: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgA3rDAzM_dqxQ66AA--.1851S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kWr17Zr4fXw48ZrW5ZFb_yoW5Kw1UpF
 ZrJ3Z8Xr4vgFyY9a9rGa109a4rG395tFW5GrW5tryUAa15JF13Jryftr4jyFWUArs7ua4F
 yFWagrWYvFyqvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2UDGUUUUU
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

