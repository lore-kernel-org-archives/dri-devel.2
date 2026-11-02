Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38272606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=p6dbFqdC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2212610E17E;
	Mon,  2 Nov 2026 05:41:06 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 29FAD10E17E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 05:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=RMxeWhurdkzBOtmQMeOUG
 yk3DusCM1pMbWX4mqqfSic=; b=p6dbFqdCvHDaFXjHlH9Wf9rN3BahsjIIMAlfV
 NRuvMyQTMVrBK/qUonSKExLaIor5scDYd7WFNKtmZgHI1QmkLHIZR6RFSbbrvpnQ
 xq/YYJPVuPJqRggZmC/uGXMGAWVl9KLSOlPnlJ5IzyleECjHatIvoexNYXjHZ/pO
 rnqiYs=
Received: from [127.0.1.1] (unknown [114.214.182.90])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCnHTJmIuhq2Nt1AA--.389S2;
 Mon, 02 Nov 2026 13:40:54 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/msm/dsi: collect bonded command-path data into
 per-SoC config
Date: Mon, 02 Nov 2026 13:40:54 +0800
Message-ID: <179359805420.413286.9245285367012895571@mail.ustc.edu.cn>
In-Reply-To: <j5ixobskknatvusosmhgvvmnze4q67iyfwk6gsa3y5goovx4z4@mhumd2vsnfkm>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
 <j5ixobskknatvusosmhgvvmnze4q67iyfwk6gsa3y5goovx4z4@mhumd2vsnfkm>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgCnHTJmIuhq2Nt1AA--.389S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWkuFW5ZrWktFW5Gw47CFg_yoW7GF17pF
 ZrK345Ar4kGr1SvwnxA3Wj9343Zas3XrZ7tFn8Gw1UAwnxJr1xZr1Iqr1YgFy2grn5CFyj
 qF4qgas8GF4kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
 Y4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
 ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
 Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUg7
 3vDUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARESB2rnk1cDXgBFsU
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dmitry,

before the technical part: this reply is drafted with an AI assistant and
edited by me.  I am the author of the series; the content, the measurements
and the decisions are mine.

1) Why change it.  Upstream's bonded DSI is clock/PHY only: dsi.xml defines
CMD_DMA_CTRL.BROADCAST_EN, dsi_host.c never sets it, so no path sends one
command over both links -- which is what this panel needs (first DCS ff 20
fails with -22, the DMA engine hangs; slave-first/master-last fixes it).
This series is the data half of proposing that path; behaviour unchanged.
[E1][E2][E3]

2) 1/5.  Both style points accepted: v2 moves dsi_bonded_cmd_lock into
msm_dsim_glb next to the flag (today DEFINE_MUTEX at dsi_manager.c:40, flag
at :41) and reflows the comment to a leading "/*" on its own line.  On the
base: 0f1fb1c9c1 is not public -- it is v7.3-rc7 plus one local squashed
payload commit, so the definitions you miss do not exist upstream. [E4][E5]

3) 2/5.  I have SM8750 values only, so I cannot claim they differ per
platform; that is why they are data in a table, and if a second SoC turns
out identical the entry collapses.  On every other SoC cfg->bonded is NULL
and the old path is taken.  You are also right that SM8750 data must not
hang off the sm8650 entry: both report DSI 6G v2.9, so v2 selects it per
compatible. [E6]

4) 4/5.  My commit message was wrong: IDs are not assigned by probe order
and the master is not derived from it either, it comes from the DT.  The
corrected paragraph is

    drm/msm/dsi: take bonded DSI master cfg from per-SoC config

    The bonded master link is selected by the device tree: dsi_mgr_parse_of()
    sets msm_dsim_glb.master_dsi_link_id from "qcom,master-dsi", and the link
    ids are the DSI host indices, not the probe order.  The DT stays the
    authority for the role; the per-SoC entry only records which link this
    board's panel sits on, so a bonded transfer issued from the non-master
    link can be rejected with a warning instead of failing later as -EINVAL
    during panel init.  On this board the recorded id equals the DT-selected
    one, so behaviour is unchanged.

So in v2 I will not take the master from the table: the DT keeps deciding it
and the entry only backs the "caller must be the master link" check.  I will
recut the series on top of current torvalds master, so it applies for you
without the local payload, and resend it as a new series.  I am not sending
patches in this thread.


Evidence

[E1] v7.3-rc7 (24a19b953e) as exported from this tree:
     grep -n BROADCAST_EN drivers/gpu/drm/msm/registers/display/dsi.xml
       -> 190:  <bitfield name="BROADCAST_EN" pos="31" type="boolean"/>
     grep -c BROADCAST_EN drivers/gpu/drm/msm/dsi/dsi_host.c
       -> 0

[E2] Panel init on this board when the bonded command path is absent or
     mis-ordered: reports/b5-step4-master-from-cfg-20261027.md:35-41
       panel-novatek-nt36536 ae94000.dsi.0: sending dcs data ff 20 failed: -22
       ... attempt 1/2/3 failed ... Failed to initialize panel: -22
       msm_dsi ae96000.dsi: panel is not prepared; refusing video enable
     same file, section 0: with the path in place the seven error counters
     (command DMA timeout, vblank timeout, reset failure, panel not
     prepared, ...) stay at 0 across 10 blank/wake cycles.

[E3] Command DMA engine state with the two links armed independently:
     patches/upstream/m6-b5-p4-rfc-20261027/RFC-SCOPE.md:12-15
       STATUS0=0x20003, TRIG_DMA=0x1 (self-clearing never happens), panel
       shows backlight only; symptom disappears after slave-first /
       master-last ordering with the completion IRQ on the master alone.

[E4] Lock and flag as sent (both file-scoped today):
     linux/drivers/gpu/drm/msm/dsi/dsi_manager.c:40
       static DEFINE_MUTEX(dsi_bonded_cmd_lock);
     linux/drivers/gpu/drm/msm/dsi/dsi_manager.c:41
       static bool dsi_bonded_cmd_failed;

[E5] The base really is v7.3-rc7 + one squashed local commit:
     git -C build/m3v2-7.3rc7 rev-parse 0f1fb1c9c1^   -> 24a19b953e (v7.3-rc7)
     git -C build/m3v2-7.3rc7 show --stat 0f1fb1c9c1    -> 148 files changed,
       15513 insertions(+), 700 deletions(-)
     and the DSI part of it: dsi_host.c +578, dsi_manager.c +249, dsi.h +19.
     Consequence measured earlier: on pristine v7.3-rc7 the series does not
     apply (0/6; only 0002 is clean) -- reports/b5-preflight-20261029.md
     section 1.2.  That is what v2 has to fix, not something I can talk away.

[E6] The SM8750 bonded data is attached to the sm8650 entry in the sent
     patch: patches/local/b5-resoc-20261027/0002-dsi-per-soc-bonded-cfg.patch:72
       +   .bonded = &sm8750_dsi_bonded_cfg,
     on sm8650_dsi_cfg; the only thing distinguishing the two SoCs is the
     compatible (7 uses of "qcom,sm8750-dsi-ctrl" in dsi_host.c), since both
     report DSI 6G v2.9.

[E7] Master is a DT property on this board too:
     linux/arch/arm64/boot/dts/qcom/sm8750-lenovo-elden.dts:1658
       qcom,master-dsi;      (inside &mdss_dsi0, the node with the panel)
     parsed at linux/drivers/gpu/drm/msm/dsi/dsi_manager.c:80-81.

Thanks for the review.
Qianhui Xu

