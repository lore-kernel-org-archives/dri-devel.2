Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A0606B1E6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nwnnRATS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A0A10E7A7;
	Fri, 13 Nov 2026 08:36:29 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 77C7A10E7A7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=jPPDfViig2
 yIjbJ0gx2L1ZBwONIm1pAcOolkFFJ0dzY=; b=nwnnRATSCZniyi3GA5BW4mPzz5
 bUx2/IMgEyzvEvDJ4pZBAEcUhLIEyz4Fh64RIiQ+nT1fa8OFFtKshMyWtBTztM61
 8+l563YI4mTO7sLEdlr1beCQTwvtR+g0XHhpqj39SmSWDeX7x6MXA12QACgVvi9c
 VoZgIUfL80kped5eM=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgD3g0j_y_Zq+ze4AA--.520S2;
 Fri, 13 Nov 2026 16:36:16 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 konrad.dybcio@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 taniya.das@oss.qualcomm.com, andersson@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] drm/msm/mdss: reset all block resets described in DT
Date: Fri, 13 Nov 2026 16:36:12 +0800
Message-ID: <cover.1794558882.git.xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgD3g0j_y_Zq+ze4AA--.520S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kWr17Zr13Ar45GF15Jwb_yoW5Zr15pF
 Z8C3s3Jrn5A3yUZFs2g3W8uFy8Can5tFy3XrZ5tryUC3y5JF1xXFW3trWDtay7CFWfZ3WY
 vF4SgrWv9F1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
 04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
 nxnUUI43ZEXa7IU5IAp7UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2r0wlk29gAls+
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

This is v4 of the MDSS block-reset series.  It supersedes v3
(<20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>) and changes only
the last commit message, in response to Dmitry's three questions on v3 2/3
(<awb7bslhrhemsgvu7ubaejvurk6fecotgvqlwtvsoe2benqdgq@tvh2sfjbuzyu>).

What changed in v4
==================

v3 3/3 claimed that command-mode panel initialisation "fails with command
DMA timeouts and the display comes up as backlight only" because INT2 was
left out of reset.  That is a causal statement the data does not support:
the failure is intermittent (~50%) and we never isolated INT2 as a single
variable.  v4 drops the claim.  The commit now says only what holds: MDSS
is an interrupt controller in DT and the DPU takes its IRQ from it, the
display clock controller provides both block resets, and firmware can hand
over with the block running, so DT describes both of them.

The two Reviewed-by tags received on v3 3/3 are carried over; the diff of
all three patches is byte-identical to v3 except for that commit message.

Answers to the three questions, for the record:

- it is an interrupt controller: sm8750.dtsi's mdss node has
  "interrupt-controller;" and "#interrupt-cells = <1>", and the DPU child
  uses "interrupts-extended = <&mdss 0>"; dispcc-sm8750 exposes INT2 as
  MDSS_INT2_GDSC plus DISP_CC_MDSS_CORE_INT2_BCR (0xa000);
- side effect: msm_mdss_reset() runs in msm_mdss_probe() (msm_mdss.c:372)
  before the irq domain is created (:417) and before of_platform_populate()
  (:537), the group is held for the existing 20 ms and released, and dispcc
  PLLs/clocks are untouched;
- testing: the reset at this position, with core+INT2+RSCC as one bulk
  group, ran 5/5 cold POR and 2/2 warm resets without a bad boot, against
  5 STORM in 9 cold boots when only the core was reset.  The exact v4 shape
  (array API, two resets) has not been booted, and there is no per-reset
  A/B.

2/3 exists only so the driver honours a DT listing more than one MDSS
reset.  If you would rather take 3/3 alone, we can drop it; say so and v5
will be 3/3 by itself.

Gates for v4
============

- git am of the three patches onto pristine v7.3-rc7 (24a19b953e) applies
  cleanly, no fuzz.
- checkpatch --strict on the rewritten 0003: 0 errors, 0 warnings, 0 checks.
- dt_binding_check and the W=1 build are unchanged from v3 (no code or DT
  diff in v4).


Qianhui Xu (3):
  dt-bindings: display: msm: mdss-common: describe additional block
    resets
  drm/msm/mdss: reset all block resets described in DT
  arm64: dts: qcom: sm8750: describe all MDSS block resets

 .../devicetree/bindings/display/msm/mdss-common.yaml         | 4 +++-
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml    | 3 ++-
 arch/arm64/boot/dts/qcom/sm8750.dtsi                         | 3 ++-
 drivers/gpu/drm/msm/msm_mdss.c                               | 5 ++---
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.53.0

