Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817F606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=jHCNuhH4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E59010E198;
	Fri, 13 Nov 2026 08:33:28 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 972FA10E198
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=uhmXzW9uBg5v5J8J71Iy4
 XAChJt+jEcSc4djzXvgVKQ=; b=jHCNuhH456i5tLj4IR1cGJl3IKChGbvKZwdZO
 F37xV9GzP3cw2PPixW41iDBVe6g3wp+YSmy5uiURI9LVGnovXXc6G199TcmJjBPl
 5hE+e2l3KBcNtJKNP70hcRxP6R6ymHsdIQ4QtWvnVm9vUjgkqxr3o/uQoAL0g4Kd
 nTofYs=
Received: from [127.0.1.1] (unknown [114.214.188.15])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCnIjdMy_ZqNDS4AA--.1444S2;
 Fri, 13 Nov 2026 16:33:16 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/3] drm/msm/mdss: reset all block resets described in
 DT
Date: Fri, 13 Nov 2026 16:33:16 +0800
Message-ID: <179455879625.604767.7465884400787133064@mail.ustc.edu.cn>
In-Reply-To: <awb7bslhrhemsgvu7ubaejvurk6fecotgvqlwtvsoe2benqdgq@tvh2sfjbuzyu>
References: <20261102055026.438521-3-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgCnIjdMy_ZqNDS4AA--.1444S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DWFyfArW5Xw1DZFWDArb_yoW8Kr4rpF
 Wfta43Wr4kAwsYk34vya109FyFyrs3Ary3W395Jry3ua90qFyxXrZ7ta4q9FW2krZ5X3Wa
 vFsIg3ykuayqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
 JrUvcSsGvfC2KfnxnUUI43ZEXa7IU56UDtUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2r0wlk29gAis5
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

Hi Dmitry,

Answering the three questions, and flagging a claim in the commit
message that your question made us re-read.

1) Is it an interrupt controller?

Yes.  MDSS is one in DT: sm8750.dtsi's mdss node has
"interrupt-controller;" and "#interrupt-cells = <1>", and the DPU child
takes its IRQ through "interrupts-extended = <&mdss 0>".  INT2 is the
second interrupt block inside MDSS; dispcc-sm8750 exposes it as
MDSS_INT2_GDSC plus DISP_CC_MDSS_CORE_INT2_BCR (0xa000), next to
DISP_CC_MDSS_CORE_BCR (0x8000).  It is not a separate device.

2) What is the side effect?

With the probe ordering taken into account, none: msm_mdss_reset() runs
early in msm_mdss_probe() (msm_mdss.c:372), while the irq domain is
created later (:417) and of_platform_populate() (:537) brings up the DPU
after that.  The group is asserted for 20 ms (the existing "one frame"
value) and then released; dispcc PLLs and clocks are not touched, and
RSCC is gone from the series as you asked.

3) How was it tested?

At two levels, and we should have said which is which:

- tested: the reset at this position (mdss probe, after dispcc PLL
  programming) with core+INT2+RSCC as one bulk group -- 5/5 cold POR and
  2/2 warm resets with no bad boot (card0 present, DSI-1 connected,
  storm signature 0), against 5 STORM in 9 cold boots on the base arm
  that reset only the core;
- not tested: this exact v3 shape (array API, two resets), and we never
  isolated INT2 as a single variable -- the failure is intermittent
  (~50%), so a per-reset A/B would need a large number of boots before
  it means anything.

So 3/3's commit message overclaims: "command DMA timeouts ... because
INT2 was left out of reset" is a causal statement we cannot support.  We
will send a v4 that keeps the DT change (it already has both R-bs) and
drops the causal wording, leaving only what holds: the bootloader can
hand over with both MDSS blocks running, so DT describes both resets and
the driver resets them as a group.

2/3 only exists to make the driver honour a DT that lists more than one
MDSS reset.  If you would prefer 3/3 alone after the v4 rewrite, say so.

AI-assistance disclosure: this reply was drafted with an LLM coding
assistant; the author verified every statement above against the tree and
against his own logs and takes responsibility for it.

Qianhui

