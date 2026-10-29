Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC5606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=PMaRwV/c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE1810E301;
	Thu, 29 Oct 2026 17:18:24 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9189A112262
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=rp9Bigau5B
 UMff/pM8buWvBGYqS+HU6+1SI+AXy/AD0=; b=PMaRwV/c4NUQj3n75NNw27DTXo
 mkZFxLDamEjPccuADtLzcaAjD2rQeU+FjMi1G0XMJQdm5mSfezPzmQBhRzvKaeyo
 Wr4+W5D/JO90yGTJ5QwKbZzoX+CPTh90QZH6193MdHAru2znsc7nJoSXYcTzkeYS
 7Glb9PztSG/oGLmqo=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.224.240])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCnHjPmPONqmPdgAA--.889S2;
 Thu, 29 Oct 2026 20:32:38 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Taniya Das <taniya.das@oss.qualcomm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/msm/mdss: reset all MDSS block resets described in
 DT
Date: Thu, 29 Oct 2026 20:32:35 +0800
Message-ID: <20261029123238.29877-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgCnHjPmPONqmPdgAA--.889S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4xZrW5JF4ruFy3Ar1xGrg_yoW5WFy3pF
 W3ta45tr1vgayIvw4xAa109ayFvws5tFW5Gr9xt34UAa15JF4xtFnIkws8tFW2gFZ7Z34Y
 qF4I939I9F9FvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
 04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
 0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOYLPUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREPB2riTVZTsQBPsm
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
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

This is the replacement for the RFC sent on 2026-10-22, which Taniya Das
correctly rejected: the MDSS block resets do not belong to the clock driver,
and resetting the whole block from dispcc probe would also take the PLLs down.

The problem the RFC tried to solve is real.  On a board that enters Linux
with the display block already running, the kernel later sees command DMA
timeouts on the first DPMS enable and the panel never comes up; resetting the
MDSS blocks before touching them fixes it, and it has to happen before the
first commit, not in the middle of one.

This version therefore leaves the clock driver completely alone and moves
the resets to the display side, where they already live:

1/3 describes three block resets on the MDSS node instead of one.  minItems
    is 1, so every existing device tree that describes only the core reset
    keeps validating; the example in the SM8750 binding now shows all three.
2/3 makes msm_mdss_reset() drive the whole array described in DT instead of
    the first reset only.  Platforms with a single reset behave exactly as
    before, which is why this is not gated on any board compatible.
3/3 describes the three resets on the SM8750 MDSS node.

The reset is still held for 20 ms, the value upstream uses today, and the
PLLs are untouched by it, so no flicker from reconfiguring them.

Scope and status, stated plainly: this was built with W=1 and the binding was
validated with dt-doc-validate, dt-validate (both with three resets and with
one, to prove the old shapes still pass) and dt-check-style.  It has *not*
yet been run on hardware, and the ordering is the one point where I would
value review most: in the arm that was measured as good, the reset happened
before the dispcc PLLs were programmed, whereas here it happens after, because
mdss consumes dispcc clocks and must probe later.  I could not find a way to
get the display side to probe earlier without reintroducing the clock-driver
problem, and resetting only the block resets (not the PLLs themselves) is the
part that I believe makes the later point harmless.  If you think that is not
sound, say so and I will drop it rather than argue.

Only SM8750 is changed here; sc7180/sc7280/sc8280xp/sm6350/sm8150 also have an
RSCC reset described in their dtsi, and sm8650 has the same three, but whether
they want the same treatment is for their maintainers to decide.

Qianhui Xu (3):
  dt-bindings: display: msm: mdss-common: describe additional block
    resets
  drm/msm/mdss: reset all block resets described in DT
  arm64: dts: qcom: sm8750: describe all MDSS block resets

 .../bindings/display/msm/mdss-common.yaml         |  5 ++++-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml    |  4 +++-
 arch/arm64/boot/dts/qcom/sm8750.dtsi              |  4 +++-
 drivers/gpu/drm/msm/msm_mdss.c                    | 15 ++++++++++++---
 4 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.53.0

