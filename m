Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=j5OtIRou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A5411205B;
	Thu, 29 Oct 2026 07:59:16 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1373A10E299
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=SIzXsF2cSOwvj4zqSccNZ
 xhOlsxGaf+jUqImNxmEMvo=; b=j5OtIRou5pxx8OXpqnpffa/sdOzjFs4VnYkiT
 58imOHjSX2FiuCcGYWiC3Z1MghEwI1YQVyVf78hcGHzCsaRyUf+4xMpfLUUQkmNX
 zuyb6ISlVnflNwywTcbXRkw4oGZ816/TP0JuA+CAtuBd/bx9Lt+kgiCClL68Zj6j
 rcpbVE=
Received: from [127.0.1.1] (unknown [114.214.180.23])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgB3_kI84+Fq3M1YAA--.876S2;
 Wed, 28 Oct 2026 19:57:48 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Taniya Das <taniya.das@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH] clk: qcom: dispcc-sm8750: reset the MDSS blocks at
 probe when the bootloader left them running
Date: Wed, 28 Oct 2026 19:57:48 +0800
Message-ID: <179318866835.88849.1485640983989491497@mail.ustc.edu.cn>
In-Reply-To: <22a87c51-4f8c-49c0-a13a-c11767f10e85@oss.qualcomm.com>
References: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
 <22a87c51-4f8c-49c0-a13a-c11767f10e85@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgB3_kI84+Fq3M1YAA--.876S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUCF15WFWkuFWkXw4ktFb_yoW8tr4xpa
 1agF4rCrnFk34SvF4xAr40vay8C395KF43Jr98G343Z345trySvrZ3tw4YgrWqkrs7Xw1j
 yr1Ivw4UA3Wvva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxkI
 ecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
 02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
 GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
 xUgmhwUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2rg+9ZfJwBfsZ
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

Thanks, that is a clear answer and I will drop the clock-side shape.

Taking your two points at face value:

- the resets belong to the display side, not to dispcc probe;
- resetting the whole block after the PLLs are configured will flicker.

So the RFC as posted is withdrawn. I will not resend it in that form.

Where I think the replacement lands, and where I would like your opinion
before spending time on it:

The reset already exists on the display side. msm_mdss_reset() in
drivers/gpu/drm/msm/msm_mdss.c asserts the mdss reset, sleeps 20 ms and
deasserts it, and sm8750.dtsi already points that reset at
DISP_CC_MDSS_CORE_BCR. The "hold it for one frame" timing is not new
either, that function carries the same comment upstream today. So the
mechanism is there; my patch only moved it earlier, into dispcc probe.

The reason I moved it is ordering. On this SoC mdss consumes dispcc
clocks and MDSS_GDSC, so dispcc probes first and the dispcc PLLs are
programmed inside disp_cc_sm8750_probe(). msm_mdss_reset() then runs
after that, so resetting there would take down PLLs that were just
configured - which is the flicker you describe, and quite possibly the
same failure I was trying to avoid in the first place.

So my open question is narrower than the original RFC: given that
ordering, where should a board that is handed over with a live display
block put the reset? Three shapes I can see:

1. keep only the single CORE_BCR reset that DT already describes, and
   let the clock framework reprogram the PLLs after it;
2. drop the block reset entirely and do a per-encoder reset in the
   DPU/DSI enable path, so the PLL section is never touched;
3. leave it to the bootloader - the vendor loader has a DisableDisplayHW
   knob for exactly this - and carry nothing in the kernel.

I am not asking you to design it. I would just like to know which of
those three you would not reject outright, so I do not spend a cycle on
the wrong one. If the answer is "none of them, this is a bootloader
problem", that is a useful answer too and I will write it up that way.

No date attached - this is a background item for me, and I would rather
come back with measurements than with a schedule.

Thanks,
Qianhui Xu

