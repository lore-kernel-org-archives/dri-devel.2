Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A7606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=vB8KtyJ2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCD910F307;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id B66FD10E53A;
 Mon, 19 Oct 2026 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=/FvLg/JhfYgqdLi+lLSlw
 zqOzFhUoWz9DASzUD4HLbs=; b=vB8KtyJ2gEzRwsdvt1goucEKprG/Ybv/ksio8
 IWa4ng/XD+QFOYypmIK64Xp8FRgFqodayFbcl1r7wCXuffe662b7ZAgKiD97Jslm
 gN748sZHyoF6nf4cWb2vC5BitA2KJE7EYp1XfyD6DOZrN0/3E8vHEDXHmKlGSNZg
 mz2h4I=
Received: from [127.0.1.1] (unknown [114.214.183.93])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDXUTbEFtZq+hETAA--.1130S2;
 Mon, 19 Oct 2026 21:10:28 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Joonhoe Kim <26rote@gmail.com>
Cc: Arpit Saini <arpit.saini@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
Date: Mon, 19 Oct 2026 21:10:28 +0800
Message-ID: <179241542813.315541.11037007061803544238@mail.ustc.edu.cn>
In-Reply-To: <20261016125036.1069-1-26rote@gmail.com>
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
 <20261016125036.1069-1-26rote@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgDXUTbEFtZq+hETAA--.1130S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fKrykXr4UCF4rJFWUJwb_yoW8WFy3pa
 97Ja12yr4ktF1Iya9rtr1xWrWrAa98tay7Ar93G3ZrAanxWa4Sy34UGw4j9Fyjkrnaqay0
 yw18G34rCF4DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxkI
 ecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
 02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
 Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
 bFDGrUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREFB2rVHlSR7ABDsZ
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

Hi Joonhoe,

Thanks for the detailed data points in this thread.  We are bringing up an
SM8750P board with a bonded dual-DSI panel (NT36536) on a v7.3-rc7 based tree
(this file is unchanged in 7.3 final), and your "display off, system awake"
observation matches what we see.

Measured with DPMS off (org.gnome.ScreenSaver.SetActive(true)), reading
power/runtime_status before and after, in this order:

  ae00000.display-subsystem                     active -> suspended
  .../ae01000.display-controller                active -> suspended
  .../ae94000.dsi                               active -> suspended
  af00000.clock-controller (dispcc)             active -> ACTIVE

So the DSI/MDSS devices do runtime-suspend, but dispcc keeps
runtime_status=active.  We then read clk_summary last (we are aware it
runtime-resumes clock controllers, hence last) and while blanked it shows
disp_cc_mdss_mdp_clk with enable=prepare=1 still held by
display-controller@ae01000, and disp_cc_mdss_ahb_clk at 3 with one consumer
being af54000.displayport-controller.

Question: with your runtime-callback variant, does dispcc end up suspended
after DPMS off, and does the panel still come back on DPMS on?  We are trying
to tell whether the remaining dispcc reference is a DSI/PHY artifact or
something on the DPU/DP side.

Separately, on a fraction of cold boots our panel init fails (first DCS
command DMA timeout) and in that state DPU core_irq stops incrementing within
~3 s while DSI interrupts stay at 0.  We have no causal link to the dispcc
runtime state yet; just noting it in case it is useful.

No logs needed from you -- just curious whether "dispcc stays active" is a
shared property.

Thanks,
Qianhui

