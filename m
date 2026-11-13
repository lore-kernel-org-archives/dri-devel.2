Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B660A380B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=cNNssa8C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF2F112683;
	Fri, 13 Nov 2026 15:56:56 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2B06A10E0DB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=O/C1Sngj/PBuWLi5GwZyVNwyXbkT3sPLrX
 9t731M1Ys=; b=cNNssa8CY39r2J3WKsey9u/C+wcIeWQjDCvtF5FtcubiJb1Rwf
 eHVr8TKcMw0OstM8sex3WCB2dLa9Q1gQ9JgScnRRJHLzpdkDaxuJADHlPLuYSr5L
 IFOwj2XxI6sfYiVksVCCvwMbXUgJCYJhZr5G5dPrKmrUn2t7Q8eXSn6c4=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3rDAzM_dqxQ66AA--.1851S5;
 Fri, 13 Nov 2026 23:56:42 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8750: describe the second MDSS block
 reset
Date: Fri, 13 Nov 2026 23:56:35 +0800
Message-ID: <20261113155635.1677541-4-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgA3rDAzM_dqxQ66AA--.1851S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy5Zw1DAw48XFyDZFW7CFg_yoW8uw18pa
 17Ca17Wr1v93WFgw17KrWjg3yrCwn5KryUGFZxK3yUCwsxtFnxXF93KFnagFyUAFs5ua1r
 WrWagr4IqF1kA3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
 0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
 IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1XdbUUUUU=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index dd738d13df..e8e2832f91 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3071,7 +3071,8 @@ mdss: display-subsystem@ae00000 {
 				 <&gcc GCC_DISP_HF_AXI_CLK>,
 				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
 
-			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>,
+				 <&dispcc DISP_CC_MDSS_CORE_INT2_BCR>;
 
 			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
-- 
2.53.0

