Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03770606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Em5nmgUl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D92410E563;
	Mon,  2 Nov 2026 05:50:40 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7339410E528
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 05:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=35dr66TVG/
 UNLRiSmChXhIrnYZ+v9R42rUMC6R88jJc=; b=Em5nmgUlIA2zVAjYFLoLAPtfr7
 91u7U/BIQzkBPkjmrCvVRXq/Ack7DTtVJo/dVD3LmvZydpbjqyrhz+WC2nWt0uOm
 8OmTy4oLyNk7l89Mxab1awZrq2vWNOFAVOtueaq8nml8plDYaETqmkE799PDyqiX
 pXaEYrymugbIOyAA0=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.182.90])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3vECiJOhqkOR1AA--.392S2;
 Mon, 02 Nov 2026 13:50:26 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v3 0/3] drm/msm/mdss: reset all block resets described in DT
Date: Mon,  2 Nov 2026 13:50:23 +0800
Message-ID: <20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgA3vECiJOhqkOR1AA--.392S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF18Gw15Zr4DAF1xCF4UJwb_yoW5WrW5pF
 W3Ja4rtr1qkw1ava1xta1Uur17AanayFW5Jr98K342yay5Ar4ftr4akw45KFW7GF93Ca4Y
 qF43X39rZFyDtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
 wI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5q2MUUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARESB2rnk1cDXgBMsd
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

AI disclosure first: this mail was drafted with an AI assistant and edited
by me; the content, the measurements and every decision are mine.

Changes in v3:
 - 1/3, 3/3: drop the MDSS RSC reset.  Dmitry: "Please drop the RSCC reset";
   Konrad: "MDSS RSC is not part of MDSS itself".  The RSC has no node inside
   the MDSS block and no device tree in the tree consumes that reset; v2
   listed it only because the reset bit is generated inside dispcc, which is
   a register-map argument, not a block-ownership one.
 - 2/3: remove the long comment above msm_mdss_reset() (Dmitry).  What is
   left of the reasoning stays in the changelog, not in the source.
 - 1/3 keeps "minItems: 1", so every device tree describing a single reset
   (all of them in the tree today) still validates.  The SM8750 example now
   shows two resets.
 - I also have to correct the v2 cover, which said the shape had not been run
   on hardware.  That was wrong.  Details below.

Evidence, none of it new:
 - This position (mdss probe, after dispcc has programmed its PLLs) was
   already measured on this board: with core + INT2 + RSC reset there, 5 real
   POR boots and 2 warm resets came up with the panel connected and no DPU
   errors, while driving the core reset alone failed in 5 of 9 boots.  That
   test used the shared-reset bulk API and all three resets; the array API in
   2/3 and the two-reset list here have not been on hardware.
 - The two resets kept here were asserted and released in all 8 boots of the
   Q28 operating line with no bad boot (5 POR, 3 warm).  That is coverage of
   what is left in the series, not an isolation experiment: I could never
   separate the three, which is why dropping the RSC entry was cheap.  The
   failing state only involves these two anyway - the SM8750 MDSS node
   described a single reset, so in the failures the core was reset while INT2
   was left as the bootloader had it.

So the ordering caveat from v2 shrinks rather than disappears: resetting the
blocks after the PLLs are up did not disturb them in those boots, no scanout
was ever in flight during the reset, and only block resets are driven, never
the PLL registers.

Built with W=1 for drivers/gpu/drm/msm/; binding checked with dt-doc-validate,
dt-validate (with two resets and with one, so the old shape still passes) and
dt-check-style; the series applies cleanly on v7.3-rc7.  Only SM8750 is
touched here.

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

