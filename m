Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA96606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFrwHHUq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFFE10E08D;
	Wed, 28 Oct 2026 15:34:44 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F247710E62D
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:34:37 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b127f1cc8so35823f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793201676; x=1793806476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nwQvp5gT0x4Cpwf86+olDk4WVML2oNByPo4ORkg5KCw=;
 b=xFrwHHUq+5Ds0EBDiDh5OyVS0HdqWQmhr1m3HHSsvAvnOKjSJ+pFflBiRo06ni0KD6
 b5P5ojyceunzyi8QtuEYuHZWoYe+yo6ShWukMk8ag0XAQHmTXL+KKSfAmp6QyxT/fSGT
 yUJjsKJsorIMp2pjJeduiC/uVqmK7ShQettZbbLUDQFMW6u3gF/6aubPv4cUMECRl0uP
 20EvbtEW6Fy6wVBB6pcmmQZLL0A20lYVte2WxS9iAJMCTdDO/CgKlqLiPZ2hbdUj9RIS
 qkeoB0uwR+0amikJnKD/YJKb0750o1QaYuSpzz8WNrMlQ2gsgRSwfHBzodOkxghrWKHb
 wZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201676; x=1793806476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nwQvp5gT0x4Cpwf86+olDk4WVML2oNByPo4ORkg5KCw=;
 b=lou4Ogx4dE8wqZa+EMqmVYx5Yex1s6+UXXYYffYA2T+tS+8Xew6X5ADmvlsPOimBt7
 h8LAEDCsS5gLBVhUMa0nPefBsXbiUENcjvA539piWSOzPkxMHpfAsQ7I2ptYdW5Yf2je
 NsJPvvWTCAYq9ypolPzqwIKN9bpgTDb8BiQcnFHZkNBezIfqIYImLmg07k1Grxg9yna3
 fQetzLveHEb8jwFFqoGfrBZ3CFp8lnHSx9vUIpHunSic+sNdaLCUAgFDTWxi7QguXatw
 5/DMGKxN6a9dVaKrNqTk9eJiNkv2V3jScbpGXF4nqH5XsZ7lLEfzEQDLaivgAMgJjizM
 +Tzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPCOnQf4cgH+nwu+T05UwufeSUfFAsFbNE54RFauMWBbrw+tJWRuPQpvKK6/aqXcVbgl6Mu3XSOYE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdHUO6E+AV5LNlmcX8V5BO1K3C7NUL+vH/s9Ret7xkZgdu2LwT
 Vx0CkEKVyyuXAUCJaw8xXzG6ft1Q+36NotI8DxyTnmmNT4/l8/1nb56p
X-Gm-Gg: AYBFou1eJMy5Jwfxhza10X/C7wWIyQJdoFm5zJ1Y1VdJVjll7DoiMI1CFkhz2XhW5h6
 ehOwAbjmHdfAbIaJ0zrvn3cGwwLkg6ZCJRxV9Xw3EuDr3NfBL+eBmVVuEUH0r7YNeyuVZ+j8OpC
 tXy/fV8UzhmSFoHOixM8BCU6oPEz350SiJivLvM1+de/WZD3+OLS61S9AUtnEouFQO6t8g25S18
 piHfDwbpXzfxNf/m6FOgDAKAD3x0MkSaT1N8N+KvL6FVJ/JyGnwBRzTigwInCIb4C00CZn1bo/p
 24dUep4acMWNLgySJfJyj8z4Fp4lpJziWpBPFWTL7MCnzEoz7J+c0fCiTtnCPK1VwG02I0J5nOn
 Kj7rOSt98rfYQhSRgvARslUpbmwPkFUSRCL/48ek/5nS2OUGiO5ZvUsqWn4Na/vkrqGsTtx+ceB
 W5cYdkyIbKe/4IH/JbwDnc+eHyvMkdrg63oFv4ML8mXTUegtU826midl7tA+os0n53ZR/ziTI36
 CRjn5HnhXGAqgcp0ToIPjwYjLi3SwRyxPFbwM1XzeOPDrFKvHihKV3lc41XMa3XvlwVXyQu+IGv
 +wxzdZnSS0eBtJJROpdh7xxyNac8vBSCwUBBGSe/URDYeUrvoAq0wrgoLQSrTlgNM2AElbNOjgw
 4YAFySj0lZbOITqCiHfh8M60=
X-Received: by 2002:a05:6000:2ad4:b0:48e:60aa:793e with SMTP id
 ffacd0b85a97d-48e60aa7a9emr3918828f8f.3.1793201675959; 
 Wed, 28 Oct 2026 08:34:35 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr
 (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e542ed998sm14428423f8f.13.2026.10.28.08.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:34:35 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Akash Asthana <akashast@codeaurora.org>,
 Roja Rani Yarubandi <rojay@codeaurora.org>, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org (open list:QUALCOMM I2C QCOM GENI DRIVER),
 linux-arm-msm@vger.kernel.org (open list:QUALCOMM I2C QCOM GENI DRIVER),
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 dri-devel@lists.freedesktop.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH] i2c: qcom-geni: fix double free of the DMA bounce buffer
Date: Wed, 28 Oct 2026 16:33:52 +0100
Message-ID: <20261028153353.69651-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

geni_i2c_{rx,tx}_msg_cleanup() release gi2c->dma_buf through
i2c_put_dma_safe_msg_buf(), which kfree()s the bounce buffer when the
message buffer is not DMA safe, but leave the pointer set. gi2c->dma_buf
is only updated when the DMA setup in geni_i2c_{rx,tx}_one_msg()
succeeds. If the setup fails for a later message, the function clears
only its local copy, so the cleanup helper sees the stale pointer from
the previous transfer, unmaps it again and frees it a second time.

Clear gi2c->dma_buf once it has been released.

This bug was found statically and compile-tested only.

Fixes: 357ee8841d0b ("i2c: qcom-geni: Store DMA mapping data in geni_i2c_dev struct")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a431e98723ef..78701310936b 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -500,6 +500,7 @@ static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c,
 			geni_i2c_rx_fsm_rst(gi2c);
 		geni_se_rx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
+		gi2c->dma_buf = NULL;
 	}
 }
 
@@ -512,6 +513,7 @@ static void geni_i2c_tx_msg_cleanup(struct geni_i2c_dev *gi2c,
 			geni_i2c_tx_fsm_rst(gi2c);
 		geni_se_tx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
+		gi2c->dma_buf = NULL;
 	}
 }
 
-- 
2.53.0

