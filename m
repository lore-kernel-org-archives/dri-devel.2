Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8D606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837D410E370;
	Fri,  6 Nov 2026 09:34:43 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F0B10E370
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:34:42 +0000 (UTC)
Received: from [172.100.0.8] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAD3+4wnn+1qQHZrAA--.5284S2;
 Fri, 06 Nov 2026 17:34:31 +0800 (CST)
Subject: Re: [PATCH] drm/tidss: Fix serial clock reference leak in
 tidss_oldi_init()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Date: Fri, 06 Nov 2026 09:34:41 -0000
Message-ID: <179395768117.2284846.12976462915703779115@iscas.ac.cn>
In-Reply-To: <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
References: <20260916182950.2092071-1-vulab@iscas.ac.cn>
 <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowAD3+4wnn+1qQHZrAA--.5284S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW7KrykGFWUKw4xKrW7urg_yoWfXrg_u3
 y8ua45uw48Z397KF17KF4UJr4IkFZrZryDu3yIkayfJFyrZF1fWF4qvr1fCw1xurZ5Jrn7
 Cr4jywn8Gw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
 s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
 kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
 Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWU
 tVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
 1UYxBIdaVFxhVjvjDU0xZFpf9x07bbXocUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUDA2rtky8t7wAAsl
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tomi,

Sorry for the very late reply.

You are right.  The clk_put() I added to tidss_oldi_deinit() only covers
the unbind path.  When tidss_oldi_init() fails for a second OLDI
transmitter, tidss_probe() returns the error directly and
tidss_oldi_deinit() is never called, so the reference taken for the
first transmitter is leaked as well.

I have switched to devm_get_clk_from_child(), which is
of_clk_get_by_name() with a device managed reference.  The reference is
then dropped both when the driver is unbound and when probe fails, and
no explicit clk_put() is needed any more.  The updated patch follows in
a separate mail.

For transparency about how this patch was produced: the candidate issue
was found with static analysis tools, and DeepSeek-V4.1-Flash and
GPT-6.1 Sol were used to help audit the error paths and to prepare the
patch.

Thanks,
Wentao

