Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8B606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moL7IqWK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43864112914;
	Fri, 20 Nov 2026 11:28:04 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA38112917
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:27:57 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so7189745e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795174076; x=1795778876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KPsWJf8/QIknvbiif9zP+BPQ4xe2P2QvRm+jnUhFSik=;
 b=moL7IqWKY5zHqKbjyXH8zO7qnnOuFEVJ4jL+oF1o0T0etJx1wwMMg+MFjO5T0LibD6
 9TQ0MWWWLyh+KkBT4s3gaz5jyDHZd8UTiyOBd4DEPUAH+EKZ6CKWbUyvrr0wxa1+03Dm
 FQDuya16cEPan3bOfyAINfp1m3iur+4OMF981vhNvUCuRDwVJm2vhFurbuIbpW3+FlvL
 eS/8tik80tz4+jt/9ZslaADXrsVas9KN0TK/oQvKO/L7Di7eCBlI3VnFkCLkwQSQ/tOK
 Px45LXaoPBYv+pCIhzer4qHSq5Cs2hHegbs7gC6d8mRNrqJXPHJu5fe6+RhZG5AdgPHi
 X8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795174076; x=1795778876;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KPsWJf8/QIknvbiif9zP+BPQ4xe2P2QvRm+jnUhFSik=;
 b=nBTzy2hfPCE8lxPNSfIlfonvdSTKmZ0S497n+7BJs2EPleJnMdd/FyiPk8a/5eT9DL
 vUz5zlvn7Oo5A7fTW+WwIL/zOkXG9u+yAZlZCxboWDQoxaEpCbhsL8FaV0cN1Gj63k2d
 MHscnhTRpwjuLJX05WR72SvCdth+MhEg3ReOQsYcvM7TQ2YrmbbFZi2oer/f1caNW7y/
 I9tzXto1pbxqlLFrYWPx+XC9SQuUJ7GSqkZcGcb4645iH1UAwxAK5IGVmEXHIxFvNDLa
 K6HxmFiYvpL/zOcYa2nssFejzoI4pFR8L3+zoXciyXAbpofRQSmHcpW5JR+H9FMpoMeG
 zveQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFocR/Jg+2Cyq2FAoSU0ilQ+Bj0sZVNeBjRLggzgzh8k9SGtvLD2mbAaKimps8OwD0VRB3QFk0TXtg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8erKhDPDh0AcfNBr0guk3uTEn+lmcKWEDAHqX2Ctv4x1ZR4Gk3
 /aYIC46i/SU+CDXHU61gfkKtABXOrDf8R9aSQHBTA4ETgFJB2hjwlTBhn9zFZJ1c
X-Gm-Gg: AYBFou05dhHvdemm4YD0aZdNdWTn9WiykfZsDQXLes05ac48Xuu3ldzjX15smrKUiIa
 gC2bj3dayB7kElkb4v8fpDn2LVwq4CXQ0a60FPenHpGnbBTBkw8J3AHIoyG6+yFbXgX3yseB+nq
 G/JU9qiy5MyYDnLJkt91PM5hBg+To2anAJ9PDBDDJfh/RKNoKpw00UQrAgIWt2fenStpL2kFjwx
 uxxCMsxNq8p6kktdKn8vp5qeETVFectBvU54+tJn5rtqhekv1ZrIoL4sV+pqJ+pL34iyl9W38VV
 UYV7nx2AIdpJmcgzooRYO+0x4MCvm1sDKXza8HE9Znq94DShDmU9rugHUK97Of/JwadA6xiCiYb
 ey3rQqfbbcqRkCxiKBoBXjO7hcEcTWke+IVT/CLIcJSVkPJf6Vq2C9jV60Aa98Ua4k/A5WqQsIn
 Y6A9UqUUsufqB5cC1IPo1E5r3LKKIAKvtbPNy5QuRlNRC2dSg1pa3moQ2MCn0YRtwKpTUE1JCeu
 hPdpVSmLa/IiTdFL442/mLZGSOGQt8ijA9xfUP3mEfraWPMOPqSFATRVT8o0zOstbZnaG3gOQxD
 j8P3NmUnOU8Drk6lh/We23gu2+1N2BG5DKC0gZqptBV2jYyE8bq6JN06g/v8dLUaJGvyxz9g+27
 F
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb88813024mr63973915e9.25.1795174075876; 
 Fri, 20 Nov 2026 03:27:55 -0800 (PST)
Received: from debian.tailb81abf.ts.net ([213.152.28.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm112095135e9.1.2026.11.20.03.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:27:55 -0800 (PST)
From: MidG971 <midgy971@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Simon Xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: RK3568 NPU: what triggers the CNA weight-fetch DMA after the
 executer engages? (mainline rocket vs vendor rknpu)
Date: Fri, 20 Nov 2026 12:27:54 +0100
Message-Id: <20261120112754.1400099-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260721230746.175786-1-midgy971@gmail.com>
References: <20260721230746.175786-1-midgy971@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi, hi all,

A gentle follow-up on the thread above from July: no reply yet, and I
wanted to add the new evidence I gathered since, in case it sharpens
the question.

Since then I confirmed the engage/completion split explicitly:

  - Loading the vendor rknpu and running ONE vendor job ("priming"),
    then unloading it (no power cycle) and loading mainline rocket,
    makes rocket's executers engage for the first time (S_POINTER
    bit 16 = 0x1000e on all five units, matching the working vendor
    signature).  So the engage is one-time HW state established by a
    *working vendor job*, not by probe/init writes.
  - But completion still fails afterwards: even primed, rocket's job
    times out with wt_rd = 0 / dt_wr = 0 (vendor: 0x1900 / 0x6400).
  - An NIU reset pulse (CRU SOFTRST_CON2 bits 8..10) at resume CLEARS
    the primed state (reads drop to 0); nothing we write re-arms it.
    I also tested a kiln-style reset edge inside rockchip_pd_power()
    at PD power-on (RK3576 kiln 0002 analog) on v7.4-rc3, including a
    forced cold power cycle of the PMU island from userspace:
    negative -- the pulse does not re-arm the sequencer, and the PD
    never actually cold-cycles on this board.
  - Cache coherency ruled out (forced dma_sync of all BOs at submit;
    live DT has no dma-coherent). CBUF_DBG matches the vendor's engaged
    values pre/post job. The board now runs mainline v7.4-rc3 and the
    gate reproduces there unchanged.

So the refined question: after a vendor job has left the NPU in the
armed per-power-session state, which step of that job arms the CNA
weight-fetch sequencer - and is there any RK3568-visible precondition
(CBUF/DCOMP/weight-DMA enable, ordering vs. engage) I could replicate
in rocket so it computes without the vendor prime?

Happy to run any targeted capture on the board (RK3568, ROCK 3B).

Thanks again.
Kind regards,
Midgy
