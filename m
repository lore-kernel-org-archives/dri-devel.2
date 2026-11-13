Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0B60A383C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=kHvqUyof
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0453511267A;
	Fri, 13 Nov 2026 15:57:01 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id DE96B11267B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=essLqwzEoNtV95IkKs+aOj/xFoD0x8dpaz
 OkHhZwxBY=; b=kHvqUyofsIxIYeimj9DClMfFb728PvV0jzNFQEElPehCepBrr+
 Mb5eQKfSXMwh8cP/7fsrteMIMgx8jqOlHFVECB/ckrR7UAT00LSIn6HGfsaJJNn3
 QxTPeJCYpoXa6WnNRgIu7NfOhk5LA9PCH/cHylIsjH1gOtbfpOE7U4jpo=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3rDAzM_dqxQ66AA--.1851S3;
 Fri, 13 Nov 2026 23:56:38 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
Date: Fri, 13 Nov 2026 23:56:33 +0800
Message-ID: <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgA3rDAzM_dqxQ66AA--.1851S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyDAw1fWw1DJF1fAw15twb_yoW8CF4Upa
 s7CFsrX3W0gFyag3ykWa48urW3XF9Yy3W5uFsIvw17ta1UAw4Fqw43Kr1qqF4UAFWxZayr
 uF4xuayYvFyvyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
 0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
 IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeFALUUUUU=
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

Some platforms provide more than one reset for the MDSS hardware block:
beside the MDSS core reset, the SM8750 display clock controller also
exposes a block reset for the MDSS core INT2 interrupt controller.

Allow the resets property to list one or two resets, keeping the MDSS
core reset as the first entry so that existing device trees describing
a single reset remain valid.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 .../devicetree/bindings/display/msm/mdss-common.yaml          | 4 +++-
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index c6305a6e03..51ef4cc74e 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -84,8 +84,10 @@ properties:
           - const: cpu-cfg
 
   resets:
+    minItems: 1
     items:
-      - description: MDSS_CORE reset
+      - description: MDSS core reset
+      - description: MDSS core INT2 interrupt controller reset
 
   memory-region:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
index 46dc0d28da..729de45ec8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
@@ -101,7 +101,8 @@ examples:
             interconnect-names = "mdp0-mem",
                                  "cpu-cfg";
 
-            resets = <&disp_cc_mdss_core_bcr>;
+            resets = <&disp_cc_mdss_core_bcr>,
+                     <&disp_cc_mdss_core_int2_bcr>;
 
             power-domains = <&mdss_gdsc>;
 
-- 
2.53.0

