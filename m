Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C0C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 23:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F7010E1ED;
	Tue, 21 Jul 2026 23:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dQAiuqtO";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4FC10E1ED
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:04:16 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso41898125e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784675055; x=1785279855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ak+PR6hDv4ylIDL1+7y4ZtHjaiTte6mYviZU2/IVpvg=;
 b=dQAiuqtOMRTF2CJja1kQk6EFpIAahW/RZ3/5WvATrnmwc73jHPEfHELfk9AH7KMf7e
 ykfvf6Uc7cNUJDruH/zMcFeAOpB3nckXzhXZbRKbs2yk1H4gZXY77KKMQ4AI4DDogn/7
 cIVKOJFsZFXqBtwq0SVnIK8Sg6+pCLjp0XFCqP6sn92AnASD0hJzymV+e0ghVVzQbJlA
 X5DN3VeQ3Rg2Kt7hsDoiY1Pm0PfgI4dvlLfzjKodh1NJ2FWBiaaxscvrGBH4Rmbjk8QU
 8a5eD32kAT1B7hivPUNd5SsyB+GCcenwZx/llL576uPmhjXJmAejxTbWeoexTQdd4dBA
 cO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675055; x=1785279855;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ak+PR6hDv4ylIDL1+7y4ZtHjaiTte6mYviZU2/IVpvg=;
 b=YDid2zfoyd4IrCI6PTonN5j2xQslSj7NIU6/oCQZg7RfBV9Y+KfmRUXk9VAZGTNY2v
 Ct3Y42aN9Mx6zEiCGwx7V6LUmRSDUAwOmOFbDVI0Zf8/1kP4w10Ptzq7YO6m2pASLlcv
 gO3K5eGCl8ChxbTgaOgqIGLQagjg5EGfn4eLrT28Q0S4zNq2U8NpZ0DNjkX+Da9g5KYK
 7bgVjxW6RshWd/iY8DCvUhEJsxN7DwsZbazKMHrFwkkpvj8JtAYQFIiV6VxVllX+laIM
 ciAS7YdV13LNaZpt53fRM2FR3Aa3BAIYMn53Il+Ef3GwKOW9eJb56+JTG3T4JWNwcAtn
 oWvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/L8R1ZE8eiJ7+FOCf7nsAlxltwbjRZEup41b+9+wvNp0tRE5MvH8X5FqoUbwv/JOUuUrNuCvwvbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWVr6Wgij/uYwILPH2yNoN9PfH0wQKgdn/GtRj8Q6Y6zT3Jcvv
 B4aNHZHN3JaTrfafwEA2GkkKOt8skmwRJ+ShC9ISbNpxMMqggJ98+3rX
X-Gm-Gg: AfdE7cndSoahzDhx85YQVetCVzwm22s3oOWJgYvy2ZByfsSB0YJY+hywFanNTtO1Pj2
 DCnI0Nv19xv2QhYysjx8w28vt87GBpooiB+BUDhUBolbuwb/8XkI60jcnC/rVE8NlT/LtkZO34d
 mvTaah6Rvv4IASTZO8jTun3lScc+jM2zUETbi6GupFF1EwNWuqV/nTQdzuj9+EZO7+Sr17mzdE1
 o6tqPYfxHI1wzEuD2IzF39xa17S9T+vtD6kJCHQD/GVi2vjAMDkJpsRMoqy8scme4KaS8c+2AqK
 ZRiyLqHaiICEcBJsWnhFG0YUawlNZT+1jtVztttC8f+WlN97Tgod2Ew58Z9cEb5wriQFGQG0uyY
 VZ6H97BoiNb4xkG1ez37YuKGpqKczVPgKKGfAhQBwswtdJRFCW3pRIpyVxez7hPeiB8ejH+xhui
 6lNFPxv/ov1U7ecRPmGmRo17vR/hYzVM88CDgfiloEJgp806ORJVdIFbD7wfbgqSI=
X-Received: by 2002:a05:600c:b8d:b0:493:f0f5:f2d7 with SMTP id
 5b1f17b1804b1-4954a3e6e97mr236752495e9.7.1784675054358; 
 Tue, 21 Jul 2026 16:04:14 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565304aefsm93200775e9.0.2026.07.21.16.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 16:04:13 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: chaoyi.chen@rock-chips.com
Cc: linux-rockchip@lists.infradead.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Simon Xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org
Subject: RK3568 NPU: what triggers the CNA weight-fetch DMA after the executer
 engages? (mainline rocket vs vendor rknpu)
Date: Wed, 22 Jul 2026 01:07:46 +0200
Message-Id: <20260721230746.175786-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Chaoyi, hi all,

Following up on the RK3568 NPU work — thanks again for the AUTO_GATING
bit-31 fix and the MMU-v2 clarification; both are in the driver now.

The mainline rocket accel driver reaches a good state on the RK3568
NPU: it probes, powers the domain, programs the pipeline, and submits a
job cleanly.  One functional problem remains, and I have narrowed it down
to a single hardware step that I don't think I can resolve from outside
Rockchip.

The test is one convolution (conv2d, 16 -> 128 channels, 5x5, stride 2)
run through Teflon/mesa.  On the vendor rknpu driver that conv produces
correct output.  On rocket the job engages the whole pipeline but never
computes: the output tensor comes back uniformly at the quantization
zero-point (every element == 128), and the job times out with no
completion interrupt.

I captured the working vendor rknpu and the stuck rocket running the SAME
conv, on the SAME SoC, in the same boot, and drove both to the identical
engaged hardware state.  The per-unit status and the CNA configuration
registers match exactly:

  - both reach S_STATUS = 0x0c and S_POINTER = 0x1000e (executer bit 16
    set) on all five sub-units (CNA / CMAC / ACCU / DPU / RDMA);
  - PC TASKST = 0xf000 on both;
  - the CNA config is byte-identical: CONV_CON*, DATA_SIZE*,
    WEIGHT_SIZE*, CBUF.

The divergence is entirely in the data-movement counters (the NPU perf
registers).  Read straight off the hardware:

  counter  (perf reg)     vendor rknpu    rocket    what it counts
  -------------------     ------------    ------    ----------------------
  wt_rd    (0x803c)       0x1900          0         CNA weight-fetch DMA
  dt_wr    (0x8034)       0x6400          0         DPU output writes
  dt_rd    (0x8038)       0x32c9          0x8b      feature / regcmd reads

The vendor's counters describe a full convolution: its CNA fetches weights
(wt_rd = 0x1900) and its DPU writes the complete output (dt_wr = 0x6400).
rocket's CNA never fetches weights (wt_rd = 0) and its DPU never writes
(dt_wr = 0); rocket's dt_rd = 0x8b accounts for only the regcmd fetch, so
it never even reads the feature data.  With no weights the MAC array
starves and the DPU writes nothing — which is exactly the uniform
zero-point output we see.

(One aside for anyone who has chased this IP before: TASKST = 0xf000 is
the NORMAL working value — the vendor produces full output at 0xf000.  It
is not a stall.)

I have matched every software-visible surface I can find:

  - Command stream + data.  Byte-exact replay of the vendor's captured
    conv2d regcmd, together with its weight BO and input BO, through the
    rocket UABI — still no compute.  The content is not the gate.

  - state_init.  rk356x_rknpu_config.state_init is NULL on RK3568 (only
    RK3576 has one).  I tried the RK3576 ritual (0x1024 = 0x80000000,
    S_POINTER 0 -> 1 -> 0x1e) on RK3568 anyway — no change.

  - Reset / power / clocks / IOMMU.  rocket mirrors rknpu_soft_reset (srst
    assert/deassert, SCMI/PVTPLL two-step, NoC de-idle at PMU
    0xfdd90000, IOMMU re-establish); clocks match the vendor (SCMI 1 GHz,
    CLK_NPU / aclk 200 MHz); AUTO_GATING uses your bit-31 fix.

  - Non-NPU-block writes (captured live for both drivers in the same
    boot).  The only raw non-NPU writes the vendor makes are the NoC/PMU
    de-idle (NOC_AUTO = 0xfffb, BUS_IDLE_ST = 0x1ea, PWR_STATUS = 0x7f);
    rocket makes them identically.  There is no npu_grf read-margin and no
    memory-repair step on RK3568 (those exist only on RK3576 / RK3588).

With the executer engaged (S_STATUS = 0x0c, S_POINTER bit 16 set) and the
CNA's regcmd config already landed, what actually triggers the CNA's
weight-fetch DMA?  The vendor rknpu reaches wt_rd = 0x1900 from a clean
submit; rocket, on the same SoC with the same engage and the same regcmd,
stays at wt_rd = 0.

My remaining hypotheses are all hardware-internal, and I would value your
read on which (if any) is real:

  1. an ordering/timing requirement between the engage and the
     weight-fetch trigger that a byte-identical but differently-sequenced
     submit does not satisfy;

  2. an internal CNA/CBUF sequencer or credit/handshake that the vendor's
     power-on or first-job path leaves armed, and that is not a
     CPU-visible register;

  3. an undocumented CNA precondition (a CBUF / DCOMP / weight-DMA enable)
     that must be set before the fetch will issue.

Even a pointer of the form "the weight fetch won't start unless X is set"
would unblock the driver.  The rest of the driver is upstream-ready; this
is the only thing between "submits" and "computes", and I would be happy
to run any targeted register capture on the board.

Thanks in advance.
Kind regards
Midgy
